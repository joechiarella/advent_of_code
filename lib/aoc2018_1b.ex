defmodule AOC2018_1B do
  def solve(input) do
    input
    |> String.split
    |> Enum.map(&String.to_integer/1)
    |> Stream.cycle
    |> Enum.reduce_while({0, MapSet.new}, &find_first_duplicate/2)
  end

  def find_first_duplicate(first, {current, previous}) do
    if MapSet.member?(previous, current) do
      {:halt, current}
    else
      {:cont, {current + first, MapSet.put(previous, current)}}
    end
  end
end
