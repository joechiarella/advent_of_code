defmodule AOC2017_2b do
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
    [val] = for a <- list_of_numbers,
      b <- list_of_numbers,
      a != b,
      rem(a, b) == 0 do
      div(a, b)
    end
    val
  end

end
