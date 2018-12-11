defmodule AOC2018_11 do
  @gridsize 300

  def solveA2(ser) do
    grid = build_grid(ser)
    solve(grid, 3)
  end

  def solveB2(ser) do
    grid = build_grid(ser)
    for size <- 1..300 do
      {x, y, max} = solve(grid, size)
      {x, y, size, max}
    end
    |> Enum.max_by(fn {_, _, _, max} -> max end)

  end

  def solve(grid, box_size) do
    sol = Enum.map(grid, &(sum_chunks(&1, box_size)))
    |> List.zip
    |> Enum.map(fn row ->
      row
      |> Tuple.to_list
      |> sum_chunks(box_size)
    end)
    |> List.flatten
    |> Enum.with_index(1)
    |> Enum.max_by(fn {score, _index} -> score end)
    {max, index} = sol
    y = div(index, @gridsize - (box_size - 1)) + 1
    x = rem(index, @gridsize - (box_size - 1))
    {x, y, max}
  end

  def sum_chunks(row, box_size) do
    current = Enum.take(row, box_size) |> Enum.sum
    subs = row
    adds = Enum.drop(row, box_size)
    [current | moving_sum(current, adds, subs)]
  end

  def moving_sum(_, [], _), do: []

  def moving_sum(prev, [add | rest_add], [sub | rest_sub]) do
    current = prev + add - sub
    [ current | moving_sum(current, rest_add, rest_sub)]
  end


  def build_grid(ser) do
    for x <- 1..@gridsize do
      for y <- 1..@gridsize do
        get_power_level(x, y, ser)
      end
    end
  end

  def get_power_level(x, y, ser) do
    rack_id = x + 10
    pow = (rack_id * y + ser) * rack_id
    rem(div(pow, 100), 10) - 5
  end

end
