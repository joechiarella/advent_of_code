defmodule AOC2018_16Test do
  use ExUnit.Case

  test "solves part 1" do
    assert AOC2018_16.solveA(read_input()) == :ok
  end

  @tag :skip
  test "solves part 2" do
    assert AOC2018_16.solveB(read_input()) == :ok
  end

  def read_input do
    File.read!("test/data/2018_16_input.txt")
  end
end
