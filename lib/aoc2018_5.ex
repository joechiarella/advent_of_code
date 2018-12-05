defmodule AOC2018_5 do
  def solve(input) do
    String.to_charlist(input)
    |> Enum.reduce([], &reduce/2)
    |> length
  end

  def reduce(next, [prev | rest]) when abs(prev - next) == 32 do
    rest
  end

  def reduce(next, prev) do
    [next | prev]
  end

  def solveB(input) do
    cl = String.to_charlist(input)

    for c <- 0..25 do
      cl
      |> remove_all(c)
      |> Enum.reduce([], &reduce/2)
      |> length
    end
    |> Enum.min
  end

  def remove_all(string, c) do
    string
    |> Enum.reject(&(&1 == c + ?a or &1 == c + ?A))
  end
end
