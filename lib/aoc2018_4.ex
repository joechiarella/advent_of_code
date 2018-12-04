defmodule AOC2018_4 do
  def solve(input) do

    guards = input
    |> String.split("\n")
    |> Enum.filter(&(String.length(&1) > 0)) # remove blank lines
    |> Enum.sort # sort by date
    |> group_by_guard
    |> Enum.map(&create_shift/1) # create shift objects
    |> Enum.sort # sort by guard number
    |> Enum.chunk_by(fn keywords -> Keyword.get(keywords, :guard_num) end) # group by guard num

    guard = Enum.max_by(guards, &get_total_minutes/1)

    id = get_id(guard)
    minute = get_most_common_minute(guard)

    id * minute
  end

  def group_by_guard(lines) do
    lines
    |> Enum.chunk_while([],
      fn line, acc ->
        if String.contains?(line, "Guard") and !Enum.empty?(acc) do
          {:cont, Enum.reverse(acc), [line]}
        else
          {:cont, [line | acc]}
        end
      end,
      fn
        [] -> {:cont, []}
        acc -> {:cont, Enum.reverse(acc), []}
      end)
  end

  def create_shift([number_line | times]) do
    guard_num = parse_guard_line(number_line)
    minutes = parse_times(times)

    [guard_num: guard_num, minutes: minutes]
  end

  def parse_guard_line(number_line) do
    Regex.run(~r/Guard #(\d+)/, number_line)
    |> case do
      [_, num] -> String.to_integer(num)
      _ -> -1
    end
  end

  def parse_times(times) do
    times
    |> Enum.chunk_every(2)
    |> Enum.map(&parse_single_sleep/1)
    |> List.flatten
  end

  def parse_single_sleep([sleep, wake]) do
    [_, sleep_min] = Regex.run(~r/:(\d\d)]/, sleep)
    [_, wake_min] = Regex.run(~r/:(\d\d)]/, wake)
    start_sleep = String.to_integer(sleep_min)
    end_sleep = String.to_integer(wake_min) - 1
    start_sleep..end_sleep
    |> Enum.to_list()
  end

  def get_total_minutes(shifts) do
    shifts
    |> Enum.map(&(Keyword.get(&1, :minutes)))
    |> List.flatten
    |> Enum.count
  end

  def get_id([first_shift | rest]) do
    Keyword.get(first_shift, :guard_num)
  end

  def get_most_common_minute(guard) do
    guard
    |> Enum.map(&(Keyword.get(&1, :minutes)))
    |> List.flatten
    |> Enum.sort
    |> Enum.chunk_by(&(&1))
    |> Enum.max_by(&Enum.count(&1))
    |> List.first
  end
end
