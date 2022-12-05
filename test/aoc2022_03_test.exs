defmodule AOC2022_03Test do
  use ExUnit.Case

  test "solves part 1" do
    assert AOC2022_03.solveA(read_input()) == 7737
  end

  test "solves part 2" do
    assert AOC2022_03.solveB(read_input()) == :ok
  end

  @sample "test"

  @tag :skip
  test "solves part 1 (sample)" do
    assert AOC2022_03.solveA(@sample) == :ok
  end

  @tag :skip
  test "solves part 2 (sample)" do
    assert AOC2022_03.solveB(@sample) == :ok
  end

  def read_input do
    File.read!("test/data/2022_03_input.txt")
  end
end
