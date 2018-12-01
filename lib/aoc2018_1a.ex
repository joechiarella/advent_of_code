defmodule AOC2018_1A do
  def solve(input) do
    input
    |> String.split
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum
  end

end
