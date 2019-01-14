defmodule AOC2018_18 do

  def solveA(input, size, times) do
    input
    |> Enum.with_index(1)
    |> Enum.reduce(%{}, fn {row, y}, acc ->
      row
      |> String.to_charlist()
      |> Enum.with_index(1)
      |> Enum.reduce(acc, fn {char, x}, acc ->
        Map.put(acc, {x, y}, get_acre(char))
      end)
    end)
    |> iterate(times, size)
    |> get_value
  end

  def get_value(map) do
    tr = Map.values(map) |> Enum.filter(fn v -> v == :tr end) |> Enum.count
    lu = Map.values(map) |> Enum.filter(fn v -> v == :lu end) |> Enum.count
    tr * lu
  end

  def iterate(map, 0, _), do: map

  def iterate(map, times, size) do
    IO.puts "#{rem(times, 28)} #{get_value(map)}"
    for x <- 1..size, y <- 1..size, into: %{} do
      curr = Map.get(map, {x, y})
      surr =
        for i <- x-1..x+1, j <- y-1..y+1 do
          Map.get(map, {i, j})
        end

      surr = List.delete(surr, curr)

      # gr = Enum.filter(surr, fn acre -> acre == :gr end)
      tr = Enum.filter(surr, fn acre -> acre == :tr end) |> Enum.count
      lu = Enum.filter(surr, fn acre -> acre == :lu end) |> Enum.count

      # IO.puts "#{x} #{y} #{curr} #{tr} #{lu}"
      new =
        cond do
          curr == :gr and tr >= 3 -> :tr
          curr == :tr and lu >= 3 -> :lu
          curr == :lu and lu >= 1 and tr >= 1 -> :lu
          curr == :lu -> :gr
          true -> curr
        end

      {{x, y}, new}
    end
    # |> print(size)
    |> iterate(times - 1, size)
  end

  def print(map, size) do
    IO.puts ""
    for y <- 1..size do
      for x <- 1..size do
        Map.get(map, {x, y})
        |> case do
          :gr -> ?.
          :tr -> ?|
          :lu -> ?#
        end
      end
      |> IO.puts
    end

    map
  end

  def get_acre(?.), do: :gr
  def get_acre(?|), do: :tr
  def get_acre(?#), do: :lu


  def solveB(input) do
    nil
  end

end
