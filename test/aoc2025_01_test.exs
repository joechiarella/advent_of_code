defmodule AOC2025_01Test do
  use ExUnit.Case

  test "solves part 1" do
    assert AOC2025_01.solveA(read_input()) == 1132
  end

  test "solves part 2" do
    assert AOC2025_01.solveB(read_input()) == 6623
  end

  @sample """
  L68
  L30
  R48
  L5
  R60
  L55
  L1
  L99
  R14
  L82
  """

  test "solves part 1 (sample)" do
    assert AOC2025_01.solveA(@sample) == 3
  end

  test "solves part 2 (sample)" do
    assert AOC2025_01.solveB(@sample) == 6
  end

  test "turnB" do
    assert AOC2025_01.turnB(60, 5, 0) == {0, 65}
    assert AOC2025_01.turnB(40, 80, 0) == {1, 20}
    assert AOC2025_01.turnB(-40, 20, 0) == {1, 80}
    assert AOC2025_01.turnB(80, 20, 0) == {1, 0}
    assert AOC2025_01.turnB(-20, 20, 0) == {1, 0}
    assert AOC2025_01.turnB(20, 0, 0) == {0, 20}
    assert AOC2025_01.turnB(-20, 0, 0) == {0, 80}
  end

  def read_input do
    File.read!("test/data/2025_01_input.txt")
  end
end
