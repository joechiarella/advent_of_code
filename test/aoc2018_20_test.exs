defmodule AOC2018_20Test do
  use ExUnit.Case

  @tag :skip
  test "solves part 1" do
    assert AOC2018_20.solveA(read_input()) == :ok
  end

  @tag :skip
  test "solves part 2" do
    assert AOC2018_20.solveB(read_input()) == :ok
  end

  @sample0 "^(SW|NNNE)$"
  @sample1 "^ESSWWN(E|NNENN(EESS(WNSE|)SSS|WWWSSSSE(SW|NNNE)))$"

  test "solves part 1 (sample)" do
    assert AOC2018_20.solveA(@sample1) == :ok
  end

  @tag :skip
  test "solves part 2 (sample)" do
    assert AOC2018_20.solveB(@sample0) == :ok
  end

  def read_input do
    File.read!("test/data/2018_20_input.txt")
  end
end
