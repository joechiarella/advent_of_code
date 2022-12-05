defmodule AOC2022_02Test do
  use ExUnit.Case

  test "solves part 1" do
    assert AOC2022_02.solveA(read_input()) == 8933
  end

  test "solves part 2" do
    assert AOC2022_02.solveB(read_input()) == 11998
  end

  @sample "test"

  @tag :skip
  test "solves part 1 (sample)" do
    assert AOC2022_02.solveA(@sample) == :ok
  end

  @tag :skip
  test "solves part 2 (sample)" do
    assert AOC2022_02.solveB(@sample) == :ok
  end

  def read_input do
    File.read!("test/data/2022_02_input.txt")
  end
end
