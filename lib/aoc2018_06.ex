defmodule AOC2018_06 do

  def solveA(input) do
    points = parse(input)

    min_x = points |> Enum.map(&x/1) |> Enum.min
    max_x = points |> Enum.map(&x/1) |> Enum.max
    min_y = points |> Enum.map(&y/1) |> Enum.min
    max_y = points |> Enum.map(&y/1) |> Enum.max

    infinite =
    for i <- min_x..max_x do
      [get_nearest(points, i, min_y),
        get_nearest(points, i, max_y)]
    end ++ for j <- min_y..max_y do
      [get_nearest(points, min_x, j),
        get_nearest(points, max_x, j)]
    end
    |> List.flatten()
    |> Enum.uniq

    for i <- min_x..max_x,
        j <- min_y..max_y do
      get_nearest(points, i, j)
    end
    |> Enum.filter(&(!Enum.member?(infinite, &1)))
    |> Enum.sort
    |> Enum.chunk_by(&(&1))
    |> Enum.map(&length/1)
    |> Enum.max
  end

  def get_nearest(points, i, j) do
    points
    |> Enum.reduce({10000, nil},
      fn (point, {prev_dist, _} = acc) ->
        new_dist = distance(point, i, j)
        cond do
          new_dist < prev_dist -> {new_dist, num(point)}
          new_dist == prev_dist -> {new_dist, nil}
          new_dist > prev_dist -> acc
        end
      end)
    |> elem(1)
  end

  def solveB(input, max_distance) do
    points = parse(input)

    min_x = points |> Enum.map(&x/1) |> Enum.min
    max_x = points |> Enum.map(&x/1) |> Enum.max
    min_y = points |> Enum.map(&y/1) |> Enum.min
    max_y = points |> Enum.map(&y/1) |> Enum.max

    for i <- min_x..max_x,
        j <- min_y..max_y do
      points
      |> Enum.map(&(distance(&1, i, j)))
      |> Enum.sum
    end
    |> Enum.filter(&(&1 < max_distance))
    |> Enum.count
  end

  def distance({{x, y}, _}, i, j) do
    abs(x - i) + abs(y - j)
  end

  def get_min_x(points) do
    points
    |> Enum.map(&x/1)
    |> Enum.min
  end

  def x({{x, _y}, _num}), do: x
  def y({{_x, y}, _num}), do: y
  def num({{_x, _y}, num}), do: num

  def parse(input) do
    input
    |> String.split(~r{(\r\n|\r|\n)})
    |> Enum.filter(&(String.length(&1) > 0))
    |> Enum.map(&to_point/1)
    |> Enum.with_index
  end

  def to_point(line) do
    [x, y] = String.split(line, ", ")
    {String.to_integer(x), String.to_integer(y)}
  end

end
