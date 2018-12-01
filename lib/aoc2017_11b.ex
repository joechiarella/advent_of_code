defmodule AOC2017_11B do

  def solve(input) do
    solve(input, {0, 0, 0}, 0)
  end

  def solve([], _, max_distance), do: max_distance

  def solve([first | rest], coord, max_distance) do
    new_max = max(max_distance, get_distance(coord))
    solve(rest, move(first, coord), new_max)
  end

  def get_distance(coord) do
    coord
    |> Tuple.to_list
    |> Enum.map(&abs/1)
    |> Enum.max
  end

  def move(:n, {x, y, z}), do: {x + 1, y - 1, z}
  def move(:s, {x, y, z}), do: {x - 1, y + 1, z}
  def move(:ne, {x, y, z}), do: {x, y - 1, z + 1}
  def move(:sw, {x, y, z}), do: {x, y + 1, z - 1}
  def move(:nw, {x, y, z}), do: {x + 1, y, z - 1}
  def move(:se, {x, y, z}), do: {x - 1, y, z + 1}

end
