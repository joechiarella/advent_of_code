defmodule AOC2018_12 do

  @offset 10
  def solveA(input, times) do
    # IO.puts ""
    List.duplicate(?., @offset) ++ input ++ List.duplicate(?., 10)
    |> iterate(times)
    |> sum_plants(-@offset)
  end

  def solveB(input, times) do
    # IO.puts ""
    List.duplicate(?., @offset) ++ input ++ List.duplicate(?., 10)
    |> iterate(times)
    |> sum_plants(-@offset)
  end

  def sum_plants([], _) do
    0
  end

  def sum_plants([?# | state], offset) do
    offset + sum_plants(state, offset + 1)
  end

  def sum_plants([?. | state], offset) do
    sum_plants(state, offset + 1)
  end

  def iterate(state, 0) do
    state
  end

  def iterate(state, num) do
    # old_sum = sum_plants(state, -@offset)
    # IO.inspect state
    new_state = for chunk <- Enum.chunk_every(state, 5, 1, :discard) do
      mutate(chunk)
    end
    new_state = '..' ++ new_state ++ '...'

    # new_sum = sum_plants(new_state, -@offset)
    # diff = new_sum - old_sum

    # IO.puts "#{new_sum} -- #{diff}"
    # IO.inspect new_state

    iterate(new_state, num - 1)
  end

  def mutate('#....'), do: ?.
  def mutate('#.##.'), do: ?#
  def mutate('..#..'), do: ?.
  def mutate('#.#.#'), do: ?.
  def mutate('.#.##'), do: ?#
  def mutate('...##'), do: ?#
  def mutate('##...'), do: ?#
  def mutate('###..'), do: ?#
  def mutate('#..##'), do: ?.
  def mutate('.###.'), do: ?.
  def mutate('###.#'), do: ?#
  def mutate('.....'), do: ?.
  def mutate('#..#.'), do: ?.
  def mutate('.#.#.'), do: ?#
  def mutate('##..#'), do: ?#
  def mutate('.##..'), do: ?.
  def mutate('...#.'), do: ?.
  def mutate('#.###'), do: ?.
  def mutate('..###'), do: ?.
  def mutate('####.'), do: ?.
  def mutate('#.#..'), do: ?#
  def mutate('.##.#'), do: ?#
  def mutate('.#...'), do: ?#
  def mutate('##.#.'), do: ?#
  def mutate('....#'), do: ?.
  def mutate('..#.#'), do: ?#
  def mutate('#...#'), do: ?#
  def mutate('..##.'), do: ?.
  def mutate('.#..#'), do: ?#
  def mutate('.####'), do: ?.
  def mutate('#####'), do: ?#
  def mutate('##.##'), do: ?#
end
