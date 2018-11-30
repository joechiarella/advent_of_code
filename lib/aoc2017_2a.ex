defmodule AOC2017_2a do
  def solve(input) do
    String.split(input, "\n")
    |> Enum.map(&parse_line/1)
    |> Enum.map(&checksum/1)
    |> Enum.sum
  end

  def parse_line(line) do
    String.split(line)
    |> Enum.map(&String.to_integer/1)
  end

  def checksum([]), do: 0

  def checksum(list_of_numbers) do
    Enum.max(list_of_numbers) - Enum.min(list_of_numbers)
  end

end
