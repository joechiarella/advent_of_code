defmodule AOC2018_5Test do
  use ExUnit.Case

  @sample "dabAcCaCBAcCcaDA"
  test "Advent of Code 2018 5A sample" do
    assert AOC2018_5.solve(@sample) == 10
  end

  test "Advent of Code 2018 5A" do
    input = File.read!("test/data/2018_5_input.txt")
    assert AOC2018_5.solve(input) == 11754
  end

  test "Advent of Code 2018 5B sample" do
    assert AOC2018_5.solveB(@sample) == 4
  end

  test "Advent of Code 2018 5B" do
    input = File.read!("test/data/2018_5_input.txt")
    assert AOC2018_5.solveB(input) == 4098
  end

end
