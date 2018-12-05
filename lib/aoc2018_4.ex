defmodule AOC2018_4 do
  def solve(input) do
    parse(input)
    |> Enum.max_by(&get_total_minutes/1)
    |> get_solution
  end

  def solveB(input) do
    parse(input)
    |> Enum.max_by(&get_common_minute_freq/1)
    |> get_solution
  end

  def get_solution(guard) do
    id = get_id(guard)

    guard
    |> get_common_minutes
    |> List.first
    |> Kernel.*(id)
  end

  def get_common_minute_freq(guard) do
    get_common_minutes(guard)
    |> Enum.count
  end

  def parse(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&(String.length(&1) > 0)) # remove blank lines
    |> Enum.sort # sort by date
    |> group_by_guard
    |> Enum.map(&create_shift/1) # create shift objects
    |> Enum.sort # sort by guard number
    |> Enum.chunk_by(fn keywords -> Keyword.get(keywords, :guard_num) end) # group by guard num
  end

  def group_by_guard(lines) do
    lines
    |> split_at(fn line -> !String.contains?(line, "Guard") end)
  end

  def split_at([], _) do
    []
  end

  def split_at([first | rest], predicate) do
    {begin, rest} = Enum.split_while(rest, predicate)
    [[first | begin] | split_at(rest, predicate)]
  end

  def create_shift([number_line | times]) do
    guard_num = parse_guard_line(number_line)
    minutes = parse_times(times)

    [guard_num: guard_num, minutes: minutes]
  end

  def parse_guard_line(number_line) do
    [_, num] = Regex.run(~r/Guard #(\d+)/, number_line)
    String.to_integer(num)
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

  def get_id([first_shift | _]) do
    Keyword.get(first_shift, :guard_num)
  end

  def get_common_minutes(guard) do
    guard
    |> Enum.map(&(Keyword.get(&1, :minutes)))
    |> List.flatten
    |> Enum.sort
    |> Enum.chunk_by(&(&1))
    |> Enum.max_by(&Enum.count(&1), fn -> [] end)
  end
end
