defmodule AOC2018_11Test do
  use ExUnit.Case

  test "solves part 1" do
    assert AOC2018_11.solveA2(2866) == {20, 50, 30}
  end

  # @tag :skip
  test "solves part 2" do
    assert AOC2018_11.solveB2(2866) == {238, 278, 9, 88}
  end

  test "solves part 1 (sample)" do
    assert AOC2018_11.solveA2(18) == {33, 45, 29}
    assert AOC2018_11.solveA2(42) == {21, 61, 30}
  end

  test "get power level" do
    assert AOC2018_11.get_power_level(3, 5, 8) == 4
    assert AOC2018_11.get_power_level(122, 79, 57) == -5
    assert AOC2018_11.get_power_level(217, 196, 39) == 0
    assert AOC2018_11.get_power_level(101, 153, 71) == 4
  end

  def read_input do
    File.read!("test/data/2018_11_input.txt")
  end
end
