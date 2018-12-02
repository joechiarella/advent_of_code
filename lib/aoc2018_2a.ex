defmodule AOC2018_2A do
  def solve(input) do
    {x, y} = input
    |> Enum.map(&get_counts/1)
    |> Enum.reduce({0, 0}, fn {x, y}, {a, b} ->
      {x + a, y + b}
    end)

    x * y
  end

  def get_counts(box) do
    counts = box
    |> Enum.reduce(%{}, fn letter, map ->
      Map.update(map, letter, 1, &(&1 + 1))
    end)
    |> Map.values

    two = if(Enum.member?(counts, 2), do: 1, else: 0)
    three = if(Enum.member?(counts, 3), do: 1, else: 0)

    {two, three}
  end

end
