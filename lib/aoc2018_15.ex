defmodule AOC2018_15 do

  def solveA(input) do
    nil
  end

  def parse(input) do
    input
    |> String.split
    |> Enum.map(&String.to_charlist/1)
    |> Enum.with_index # list of { row string, y }
    |> Enum.reduce(%{}, &parse_row/2)
  end

  def parse_row({row_string, y}, state) do
    row_string
    |> Enum.with_index # list of { char, x }
    |> Enum.reduce(state, &(parse_tile(&1, y, &2)))
  end

  def parse_tile({?#, x}, y, state) do
    Map.put(state, {x, y}, :wall)
  end

  def parse_tile({?E, x}, y, state) do
    Map.put(state, {x, y}, :cave)
  end

  def parse_tile({?G, x}, y, state) do
    Map.put(state, {x, y}, :cave)
  end

  def parse_tile({?., x}, y, state) do
    Map.put(state, {x, y}, :cave)
  end


end
