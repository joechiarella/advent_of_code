defmodule AOC2018_10 do

  def solveA(input, times) do
    input
    |> parse
    |> iterate(times)
    |> print
  end

  def solveB(input) do
    nil
  end

  def iterate(state, 0) do
    state
  end

  def iterate(state, times) do
    new_state = state
    |> Enum.map(fn {x, y, dx, dy} -> {x + dx, y + dy, dx, dy} end)
    new_state |> iterate(times - 1)
  end

  def parse(input) do
    input
    |> String.split(~r{(\r\n|\r|\n)})
    |> Enum.filter(&(String.length(&1) > 0))
    |> Enum.map(&to_step/1)
  end

  def to_step(line) do
    # position=< 9,  1> velocity=< 0,  2>
    [_, x, y, dx, dy] = Regex.run(~r/position=<\s*(-?\d+),\s*(-?\d+)>.*=<\s*(-?\d+),\s*(-?\d+)>/, line)
    {String.to_integer(x), String.to_integer(y), String.to_integer(dx), String.to_integer(dy)}
  end

  def get_bounds(state) do
    min_x = Enum.map(state, fn {x, _, _, _} -> x end) |> Enum.min
    max_x = Enum.map(state, fn {x, _, _, _} -> x end) |> Enum.max
    min_y = Enum.map(state, fn {_, y, _, _} -> y end) |> Enum.min
    max_y = Enum.map(state, fn {_, y, _, _} -> y end) |> Enum.max

    {min_x..max_x, min_y..max_y}
  end

  def print(state) do
    IO.puts ""
    {xrange, yrange} = get_bounds(state)
    for j <- yrange do
      for i <- xrange do
        get_char(state, i, j)
      end
    end
    |> Enum.each(&IO.puts/1)

  end

  def get_char(state, i, j) do
    state
    |> Enum.any?(fn {x, y, _, _} -> i == x and j == y end)
    |> case do
      true -> ?#
      _ ->    ?.
    end
  end

end
