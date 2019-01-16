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
    order =
      AOC2018_15.get_turn_order(state)
      |> Enum.map(&(&1.id))

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
      |> Enum.map(&(&1.id))
    assert targets == [1, 2, 3]
  end

  test "in range" do
    state = AOC2018_15.parse(@sample1)
    elf = Map.get(state.units, 0)
    targets = AOC2018_15.get_targets(state, elf)
    in_range = AOC2018_15.in_range(state, targets)
    assert in_range == [{3, 1}, {5, 1}, {2, 2}, {5, 2}, {1, 3}, {3, 3}]
  end

  test "unoccupied" do
    state = AOC2018_15.parse(@sample1)
    in_range = [{4, 1}, {5, 1}, {2, 2}, {5, 2}, {1, 3}, {3, 3}]
    unocc = AOC2018_15.unoccupied(state, in_range)
    assert unocc = [{5, 1}, {2, 2}, {5, 2}, {1, 3}, {3, 3}]
  end

  test "shortest path" do
    state = AOC2018_15.parse(@sample1)
    assert AOC2018_15.get_shortest_path(state, {1, 1}, {3, 1}) == [{2, 1}, {3, 1}]
    assert AOC2018_15.get_shortest_path(state, {1, 1}, {5, 1}) == :none
  end

  test "nearest" do
    state = AOC2018_15.parse(@sample1)
    nearest = AOC2018_15.nearest(state, {1, 1}, [{5, 1}, {2, 2}, {5, 2}, {1, 3}, {3, 3}])
    assert nearest == {2, 1}
  end

  test "take turn (move)" do
    state = AOC2018_15.parse(@sample1)
    elf = Map.get(state.units, 0)
    assert elf.location == {1, 1}
    state = AOC2018_15.move(state, elf)
    assert Map.get(state.units, 0).location == {2, 1}
  end

  @movementsample """
  #########
  #G..G..G#
  #.......#
  #.......#
  #G..E..G#
  #.......#
  #.......#
  #G..G..G#
  #########
  """

  test "take turns (move)" do
    state = AOC2018_15.parse(@movementsample)
    state = AOC2018_15.take_turn(state)

    #########
    #.G...G.#
    #...G...#
    #...E..G#
    #.G.....#
    #.......#
    #G..G..G#
    #.......#
    #########

    assert Map.get(state.units, 0).location == {2, 1}
    assert Map.get(state.units, 1).location == {4, 2}
    assert Map.get(state.units, 2).location == {6, 1}
    assert Map.get(state.units, 3).location == {2, 4}
    assert Map.get(state.units, 4).location == {4, 3}
    assert Map.get(state.units, 5).location == {7, 3}
    assert Map.get(state.units, 6).location == {1, 6}
    assert Map.get(state.units, 7).location == {4, 6}
    assert Map.get(state.units, 8).location == {7, 6}

    #########
    #..G.G..#
    #...G...#
    #.G.E.G.#
    #.......#
    #G..G..G#
    #.......#
    #.......#
    #########

    state = AOC2018_15.take_turn(state)
    assert Map.get(state.units, 0).location == {3, 1}
    assert Map.get(state.units, 1).location == {4, 2}
    assert Map.get(state.units, 2).location == {5, 1}
    assert Map.get(state.units, 3).location == {2, 3}
    assert Map.get(state.units, 4).location == {4, 3}
    assert Map.get(state.units, 5).location == {6, 3}
    assert Map.get(state.units, 6).location == {1, 5}
    assert Map.get(state.units, 7).location == {4, 5}
    assert Map.get(state.units, 8).location == {7, 5}

    #########
    #.......#
    #..GGG..#
    #..GEG..#
    #G..G...#
    #......G#
    #.......#
    #.......#
    #########

    state = AOC2018_15.take_turn(state)
    assert Map.get(state.units, 0).location == {3, 2}
    assert Map.get(state.units, 1).location == {4, 2}
    assert Map.get(state.units, 2).location == {5, 2}
    assert Map.get(state.units, 3).location == {3, 3}
    assert Map.get(state.units, 4).location == {4, 3}
    assert Map.get(state.units, 5).location == {5, 3}
    assert Map.get(state.units, 6).location == {1, 4}
    assert Map.get(state.units, 7).location == {4, 4}
    assert Map.get(state.units, 8).location == {7, 5}

    state = AOC2018_15.take_turn(state)
    assert Map.get(state.units, 0).location == {3, 2}
    assert Map.get(state.units, 1).location == {4, 2}
    assert Map.get(state.units, 2).location == {5, 2}
    assert Map.get(state.units, 3).location == {3, 3}
    assert Map.get(state.units, 4).location == {4, 3}
    assert Map.get(state.units, 5).location == {5, 3}
    assert Map.get(state.units, 6).location == {1, 4}
    assert Map.get(state.units, 7).location == {4, 4}
    assert Map.get(state.units, 8).location == {7, 5}

  end

  @tag :skip
  test "solves part 2 (sample)" do
    assert AOC2018_15.solveB(@sample) == :ok
  end

  def read_input do
    File.read!("test/data/2018_15_input.txt")
  end
end
