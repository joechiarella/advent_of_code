defmodule AOC2018_13Test do
  use ExUnit.Case

  test "solves part 1" do
    assert AOC2018_13.solveA(read_input()) == {40, 90}
  end

  test "solves part 2" do
    assert AOC2018_13B.solveB(read_input()) == {65, 81}
  end

  @sample ~S"""
  /->-\
  |   |  /----\
  | /-+--+-\  |
  | | |  | v  |
  \-+-/  \-+--/
    \------/
  """

  test "solves part 1 (sample)" do
    assert AOC2018_13.solveA(@sample) == {7, 3}
  end

  @sampleB ~S"""
  />-<\
  |   |
  | /<+-\
  | | | v
  \>+</ |
    |   ^
    \<->/
  """

  test "solves part 12 (sample)" do
    assert AOC2018_13B.solveB(@sampleB) == {6, 4}
  end

  def read_input do
    File.read!("test/data/2018_13_input.txt")
  end
end
