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

    def add_unit(state, location, type) do
      id = Enum.count(state.units)
      unit = %Unit{id: id, location: location, type: type}
      %State{
        state |
        units: Map.put(state.units, id, unit)
      }
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

  def get_targets(state, unit) do
    state.units
    |> Map.values()
    |> Enum.filter(&(Unit.is_type(&1, unit.type)))
    |> Enum.filter(&Unit.is_alive/1)
    |> sort()
    |> Enum.map(&(&1.id))
  end

  def sort(units) do
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
