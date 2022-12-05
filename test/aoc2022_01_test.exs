defmodule AOC2022_01Test do
  use ExUnit.Case

  test "solves part 1" do
    assert AOC2022_01.solveA(read_input()) == :ok
  end

  test "solves part 2" do
    assert AOC2022_01.solveB(read_input()) == :ok
  end

  @sample "test"

  @tag :skip
  test "solves part 1 (sample)" do
    assert AOC2022_01.solveA(@sample) == :ok
  end

  @tag :skip
  test "solves part 2 (sample)" do
    assert AOC2022_01.solveB(@sample) == :ok
  end

  def read_input do
    File.read!("test/data/2022_01_input.txt")
  end
end
