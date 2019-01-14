defmodule AOC2018_15Test do
  use ExUnit.Case

  @tag :skip
  test "solves part 1" do
    assert AOC2018_15.solveA(read_input()) == :ok
  end

  @tag :skip
  test "solves part 2" do
    assert AOC2018_15.solveB(read_input()) == :ok
  end

  @sample1 """
  #######
  #E..G.#
  #...#.#
  #.G.#G#
  #######
  """

  test "order" do
    state = AOC2018_15.parse(@sample1)
    order = AOC2018_15.get_turn_order(state)
    assert order == [0, 1, 2, 3]
  end

  # Targets:      In range:     Reachable:    Nearest:      Chosen:
    #######       #######       #######       #######       #######
    #E..G.#       #E.?G?#       #E.@G.#       #E.!G.#       #E.+G.#
    #...#.#  -->  #.?.#?#  -->  #.@.#.#  -->  #.!.#.#  -->  #...#.#
    #.G.#G#       #?G?#G#       #@G@#G#       #!G.#G#       #.G.#G#
    #######       #######       #######       #######       #######

  test "get targets" do
    state = AOC2018_15.parse(@sample1)
    elf = Map.get(state.units, 0)
    targets = AOC2018_15.get_targets(state, elf)
    assert targets == [1, 2, 3]
  end

  test "in range" do
    state = AOC2018_15.parse(@sample1)
    elf = Map.get(state.units, 0)
    targets = [1, 2, 3]
    in_range = AOC2018_15.in_range(state, elf, targets)
    assert in_range == [{3, 1}, {5, 1}, {2, 2}, {5, 2}, {1, 3}, {3, 3}]
  end

  @tag :skip
  test "solves part 2 (sample)" do
    assert AOC2018_15.solveB(@sample) == :ok
  end

  def read_input do
    File.read!("test/data/2018_15_input.txt")
  end
end
