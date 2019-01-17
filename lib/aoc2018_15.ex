defmodule AOC2018_15 do
  defmodule Unit do
    defstruct id: 0, hp: 200, location: {0, 0}, type: :unk

    def is_alive(%Unit{hp: hp}) do
      hp > 0
    end

    def is_type(%Unit{type: unit_type}, type) do
      unit_type != type
    end

    def move(unit, loc) do
      %Unit{
        unit |
        location: loc
      }
    end

    def attack(unit, damage) do
      %Unit{
        unit |
        hp: unit.hp - damage
      }
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
      update_unit(state, unit)
    end

    def get_unit(state, id) do
      Map.get(state.units, id)
    end

    def update_unit(state, unit) do
      %State{
        state |
        units: Map.put(state.units, unit.id, unit)
      }
    end

    def move(state, unit, location) do
      State.update_unit(state, Unit.move(unit, location))
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

    def attack(state, unit) do
      update_unit(state, Unit.attack(unit, 3))
    end
  end

  def solveA(input) do
    state = parse(input)
    take_turn(state, 1)
  end

  def take_turn(state, turns) do
    IO.puts "BEGIN TURN #{turns}"
    if game_over?(state) do
      4
      # get_answer(state, turns)
    else
      state = take_turn(state)
      take_turn(state, turns + 1)
    end
  end

  def game_over?(state) do
    living =
      state.units
      |> Map.values()
      |> Enum.filter(&Unit.is_alive/1)
      |> Enum.group_by(fn unit -> unit.type end)

    Map.size(living) == 1
  end

  def get_turn_order(state) do
    state.units
    |> Map.values()
    |> Enum.filter(&Unit.is_alive/1)
    |> sort()
    # |> Enum.map(&(&1.id))
  end

  def take_turn(state) do

    state
    |> get_turn_order
    |> Enum.reduce(state, fn unit, state ->
      state
      |> move(unit)
      |> attack(unit.id)
    end)
  end
  # To attack, the unit first determines all of the targets that are in range of it by
  # being immediately adjacent to it. If there are no such targets, the unit ends its
  # turn. Otherwise, the adjacent target with the fewest hit points is selected;
  # in a tie, the adjacent target with the fewest hit points which is first in reading
  # order is selected.
  def attack(state, unit_id) do
    unit = State.get_unit(state, unit_id)
    in_range = State.get_adjacent(state, unit.location)

    targets =
      state
      |> get_targets(unit)
      |> Enum.filter(fn target ->
        target.location in in_range
      end)
      |> Enum.sort_by(fn target ->
        {x, y} = target.location
        {target.hp, y, x}
      end)

    if targets == [] do
      IO.puts "No targets in range"
      state
    else
      target = hd(targets)
      IO.puts "Attacking #{target.id} -> #{target.hp - 3}"
      State.attack(state, target)
    end
  end

  def move(state, unit) do
    targets = get_targets(state, unit)
    in_range = in_range(state, targets)
    if unit.location in in_range do
      IO.puts "Unit #{unit.id} already in range of target"
      state
    else
      in_range = unoccupied(state, in_range)
      if in_range == [] do
        IO.puts "Unit #{unit.id} has no targets"
        state
      else
        nearest = nearest(state, unit.location, in_range)
        IO.puts "Moving #{unit.id} to #{inspect nearest}"
        State.move(state, unit, nearest)
      end
    end
  end

  # Each unit begins its turn by identifying all possible targets (enemy units).
  # If no targets remain, combat ends.
  def get_targets(state, unit) do
    state.units
    |> Map.values()
    |> Enum.filter(&(Unit.is_type(&1, unit.type)))
    |> Enum.filter(&Unit.is_alive/1)
    |> sort()
  end

  # Then, the unit identifies all of the open squares (.) that are in range of
  # each target; these are the squares which are adjacent (immediately up, down,
  # left, or right) to any target and which aren't already occupied by a wall or
  # another unit.
  def in_range(state, targets) do
    targets
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
      |> Enum.uniq()

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
