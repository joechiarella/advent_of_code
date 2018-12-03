defmodule AOC2018_3Test do
  use ExUnit.Case

  test "Advent of Code 2018 3A" do
    input = File.read!("test/data/2018_3_input.txt")
    assert AOC2018_3A.solve(input) == 121259
  end

  test "test parser" do
    claim = AOC2018_3A.Claim.parse("#1 @ 1,3: 4x5")
    assert claim.id == 1
    assert claim.xmin == 1
    assert claim.ymin == 3
    assert claim.xmax == 5
    assert claim.ymax == 8
  end

  @sample """
  #1 @ 1,3: 4x4
  #2 @ 3,1: 4x4
  #3 @ 5,5: 2x2
  """
  test "sample" do
    assert AOC2018_3A.solve(@sample) == 4
  end

  test "Advent of Code 2018 3B" do
    input = File.read!("test/data/2018_3_input.txt")
    assert AOC2018_3A.solveB(input) == [239]
  end

  test "Advent of Code 2018 3B sample" do
    input = @sample
    assert AOC2018_3A.solveB(input) == [3]
  end

end
