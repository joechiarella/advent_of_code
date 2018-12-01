defmodule AOC2018_1Test do
  use ExUnit.Case

  test "Advent of Code 2017 1A" do
    input = File.read!("test/data/2018_1_input.txt")
    assert AOC2018_1A.solve(input) == 505
  end

  test "Advent of Code 2017 1B" do
    input = File.read!("test/data/2018_1_input.txt")
    assert AOC2018_1B.solve(input) == 72330
  end

end
