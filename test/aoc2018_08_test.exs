defmodule AOC2018_08Test do
  use ExUnit.Case

  test "solves part 1" do
    assert AOC2018_08.solveA(read_input()) == 43996
  end

  test "solves part 2" do
    assert AOC2018_08.solveB(read_input()) == 35189
  end

  @sample "2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2"

  test "solves part 1 (sample)" do
    assert AOC2018_08.solveA(@sample) == 138
  end

  test "solves part 2 (sample)" do
    assert AOC2018_08.solveB(@sample) == 66
  end

  def read_input do
    File.read!("test/data/2018_08_input.txt")
  end
end
