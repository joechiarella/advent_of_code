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

  test "parsing" do
    state = AOC2018_15.parse(@sample1)
    IO.inspect state
  end

  @tag :skip
  test "solves part 2 (sample)" do
    assert AOC2018_15.solveB(@sample) == :ok
  end

  def read_input do
    File.read!("test/data/2018_15_input.txt")
  end
end
