defmodule AOC2018_1B do
  def solve(input) do
    input
    |> String.split
    |> Enum.map(&String.to_integer/1)
    |> find_first_duplicate
  end

  def find_first_duplicate(list) do
    find_first_duplicate(list, list, 0, [])
  end

  def find_first_duplicate([first | rest], full_list, current, previous) do
    next = current + first
    if next in previous do
      next
    else
      find_first_duplicate(rest, full_list, next, [current | previous])
    end
  end

  def find_first_duplicate([], full_list, current, previous) do
    IO.puts "start over"
    find_first_duplicate(full_list, full_list, current, previous)
  end

end
