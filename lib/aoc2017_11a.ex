defmodule AOC2017_11a do

  def solve(input) do
    solve(input, {0, 0, 0})
    |> Tuple.to_list
    |> Enum.map(&abs/1)
    |> Enum.max
  end

  def solve([], coord), do: coord

  def solve([first | rest], coord) do
    solve(rest, move(first, coord))
  end

  def move(:n, {x, y, z}), do: {x + 1, y - 1, z}
  def move(:s, {x, y, z}), do: {x - 1, y + 1, z}
  def move(:ne, {x, y, z}), do: {x, y - 1, z + 1}
  def move(:sw, {x, y, z}), do: {x, y + 1, z - 1}
  def move(:nw, {x, y, z}), do: {x + 1, y, z - 1}
  def move(:se, {x, y, z}), do: {x - 1, y, z + 1}

end
