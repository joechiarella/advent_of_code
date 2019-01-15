defmodule AOC2018_15 do
  defmodule Unit do
    defstruct id: 0, hp: 200, location: {0, 0}, type: :unk

    def is_alive(%Unit{hp: hp}) do
      hp > 0
    end

    def is_type(%Unit{type: unit_type}, type) do
      unit_type != type
    end
  end

  defmodule State do
    defstruct board: %{}, units: %{}

    def add_tile(state, location, tile) do
      %State{
        state |
        board: Map.put(state.board, location, tile)
      }
    end

    def get_tile(state, location) do
      Map.get(state.board, location, :wall)
    end

    def add_unit(state, location, type) do
      id = Enum.count(state.units)
      unit = %Unit{id: id, location: location, type: type}
      %State{
        state |
        units: Map.put(state.units, id, unit)
      }
    end

    def get_unit(state, id) do
      Map.get(state.units, id)
    end

    def move(state, unit, location) do
      %State{
        state |
        units: Map.put(state.units, unit.id,
          %Unit{
            unit |
            location: location
          })
      }
    end

    def get_adjacent(state, {x, y}) do
      [{x, y - 1}, {x - 1, y}, {x + 1, y}, {x, y + 1}]
      |> Enum.filter(fn loc -> State.get_tile(state, loc) == :cave end)
    end

    def get_occupied(state) do
      state.units
      |> Map.values
      |> Enum.filter(&Unit.is_alive/1)
      |> Enum.map(fn unit -> unit.location end)
    end
  end

  def solveA(input) do
    nil
  end

  def get_turn_order(state) do
    state.units
    |> Map.values()
    |> sort()
    |> Enum.map(&(&1.id))
  end

  def take_turn(state, unit) do
    targets = get_targets(state, unit)
    in_range = in_range(state, targets)
    nearest = nearest(state, unit.location, in_range)
    State.move(state, unit, nearest)
  end

  # Each unit begins its turn by identifying all possible targets (enemy units).
  # If no targets remain, combat ends.
  def get_targets(state, unit) do
    state.units
    |> Map.values()
    |> Enum.filter(&(Unit.is_type(&1, unit.type)))
    |> Enum.filter(&Unit.is_alive/1)
    |> sort()
    |> Enum.map(&(&1.id))
  end

  # Then, the unit identifies all of the open squares (.) that are in range of
  # each target; these are the squares which are adjacent (immediately up, down,
  # left, or right) to any target and which aren't already occupied by a wall or
  # another unit.
  def in_range(state, targets) do
    targets
    |> Enum.map(&(State.get_unit(state, &1)))
    |> Enum.map(&(&1.location))
    |> Enum.map(&(State.get_adjacent(state, &1)))
    |> List.flatten
    |> Enum.uniq
    |> sort()
  end

  def unoccupied(state, squares) do
    occupied = State.get_occupied(state)

    squares
    |> Enum.reject(fn loc -> Enum.member?(occupied, loc) end)
  end

  def get_shortest_path(state, start, finish) do
    seen = %{start => 0}
    wave(state, seen, [start], 0, finish)
  end

  def wave(_, _, [], _, _) do
    :none
  end

  def wave(state, seen, latest, iter, finish) do
    adjacent =
      latest
      |> Enum.map(fn loc -> State.get_adjacent(state, loc) end)
      |> List.flatten()

    if(finish in adjacent) do
      [finish | traceback(seen, finish, iter)]
      |> Enum.reverse
    else
      latest =
        unoccupied(state, adjacent)
        |> Enum.filter(fn loc ->
          !Map.has_key?(seen, loc)
        end)

      seen =
        for loc <- latest, into: seen do
          {loc, iter + 1}
        end

      wave(state, seen, latest, iter + 1, finish)
    end
  end

  def traceback(seen, {x, y}, 0) do
    []
  end

  def traceback(seen, {x, y}, iter) do
    adj = [{x, y - 1}, {x - 1, y}, {x + 1, y}, {x, y + 1}]
    next =
      Enum.find(adj, fn loc ->
        Map.get(seen, loc) == iter
      end)
    [next | traceback(seen, next, iter - 1)]
  end

  def nearest(state, start, dests) do
    dests
    |> Enum.map(fn dest -> get_shortest_path(state, start, dest) end)
    |> Enum.filter(fn path -> path != :none end)
    |> Enum.group_by(&Kernel.length/1, &Kernel.hd/1)
    |> Enum.min
    |> Kernel.elem(1)
    |> sort()
    |> Kernel.hd()
  end

  def sort([{_x, _y} | _] = locations) do
    locations
    |> Enum.sort_by(fn {x, y} -> {y, x} end)
  end

  def sort([%Unit{} | _] = units) do
    units
    |> Enum.sort_by(fn %Unit{location: {x, y}} -> {y, x} end)
  end

  def parse(input) do
    input
    |> String.split
    |> Enum.map(&String.to_charlist/1)
    |> Enum.with_index # list of { row string, y }
    |> Enum.reduce(%State{}, &parse_row/2)
  end

  def parse_row({row_string, y}, state) do
    row_string
    |> Enum.with_index # list of { char, x }
    |> Enum.reduce(state, &(parse_tile(&1, y, &2)))
  end

  def parse_tile({?#, x}, y, state) do
    state
    |> State.add_tile({x, y}, :wall)
  end

  def parse_tile({?E, x}, y, state) do
    state
    |> State.add_tile({x, y}, :cave)
    |> State.add_unit({x, y}, :elf)
  end

  def parse_tile({?G, x}, y, state) do
    state
    |> State.add_tile({x, y}, :cave)
    |> State.add_unit({x, y}, :goblin)
  end

  def parse_tile({?., x}, y, state) do
    state
    |> State.add_tile({x, y}, :cave)
  end


end
