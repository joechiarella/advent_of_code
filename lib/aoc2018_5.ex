defmodule AOC2018_5 do
  def solve(input) do
    String.to_charlist(input)
    |> reduce_and_recurse
    |> length
  end

  def solveB(input) do
    cl = String.to_charlist(input)

    for c <- 0..25 do
      cl
      |> remove_all(c)
      |> reduce_and_recurse
      |> length
    end
    |> Enum.min
  end

  def remove_all(string, c) do
    string
    |> Enum.reject(&(&1 == c + ?a or &1 == c + ?A))
  end

  def reduce_and_recurse(string) do
    reduced = reduce(string)
    if reduced == string do
      reduced
    else
      reduce_and_recurse(reduced)
    end
  end

  def reduce([]), do: []

  def reduce([first | [second | tail] = rest]) when abs(first - second) == 32 do
    reduce(tail)
  end

  def reduce([first | rest]) do
    [first | reduce(rest)]
  end
end
