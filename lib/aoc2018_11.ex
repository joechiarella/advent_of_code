defmodule AOC2018_11 do
  def solveA(ser) do
    for x <- 1..298, y <- 1..298 do
      total = for dx <- 0..2, dy <- 0..2 do
        get_power_level(x + dx, y + dy, ser)
      end
      |> Enum.sum
      {x, y, total}
    end
    |> Enum.max_by(fn {_, _, total} -> total end)
  end

  def solveB(ser) do
    for size <- 5..20, x <- 1..301 - size, y <- 1..301 - size do
      total = for dx <- 0..size - 1, dy <- 0..size - 1 do
        get_power_level(x + dx, y + dy, ser)
      end
      |> Enum.sum
      {x, y, size, total}
    end
    |> Enum.max_by(fn {_, _, _, total} -> total end)
  end


  @gridsize 300

  def solveA2(ser) do
    grid = build_grid(ser)
    solve(grid, 3)
  end

  def solveB2(ser) do
    grid = build_grid(ser)
    for size <- 1..30 do
      {x, y, max} = solve(grid, size)
      {x, y, size, max}
    end
    |> Enum.max_by(fn {_, _, _, max} -> max end)

  end

  def solve(grid, box_size) do
    sol = Enum.map(grid, &(
      Enum.chunk_every(&1, box_size, 1, :discard)
      |> Enum.map(fn list -> Enum.sum(list) end)
      # |> Enum.with_index(1)
      ))
    |> List.zip
    |> Enum.map(fn row ->
      row
      |> Tuple.to_list
      |> Enum.chunk_every(box_size, 1, :discard)
      |> Enum.map(fn col -> Enum.sum(col) end)
    end)
    |> List.flatten
    |> Enum.with_index(1)
    |> Enum.max_by(fn {score, index} -> score end)
    {max, index} = sol
    y = div(index, @gridsize - (box_size - 1)) + 1
    x = rem(index, @gridsize - (box_size - 1))
    {x, y, max}
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
