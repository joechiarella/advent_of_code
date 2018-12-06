defmodule AOC2018_06Test do
  use ExUnit.Case

  test "solves part 1" do
    assert AOC2018_06.solveA(read_input()) == 4166
  end

  test "solves part 2" do
    assert AOC2018_06.solveB(read_input(), 10_000) == 42250
  end

  @sample """
  1, 1
  1, 6
  8, 3
  3, 4
  5, 5
  8, 9
  """

  test "solves part 1 (sample)" do
    assert AOC2018_06.solveA(@sample) == 17
  end

  test "solves part 2 (sample)" do
    assert AOC2018_06.solveB(@sample, 32) == 16
  end

  def read_input do
    File.read!("test/data/2018_06_input.txt")
  end
end
