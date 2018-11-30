defmodule AOC2017_2Test do
  use ExUnit.Case
  test "Advent of Code 2017 2A" do
    input = File.read! "test/data/2017_2a_input.txt"
    assert AOC2017_2a.solve(input) == 51139
  end

  @sample """
  5 1 9 5
  7 5 3
  2 4 6 8
  """

  test "2A samples" do
    assert AOC2017_2a.checksum([5, 1, 9, 5]) == 8
    assert AOC2017_2a.checksum([7, 5, 3]) == 4
    assert AOC2017_2a.checksum([2, 4, 6, 8]) == 6

    assert AOC2017_2a.solve(@sample) == 18
  end

  test "Advent of Code 2017 2B" do
    input = File.read! "test/data/2017_2a_input.txt"
    assert AOC2017_2b.solve(input) == 272
  end

  @sampleB """
  5 9 2 8
  9 4 7 3
  3 8 6 5
  """

  test "2B samples" do
    assert AOC2017_2b.checksum([5, 9, 2, 8]) == 4
    assert AOC2017_2b.checksum([9, 4, 7, 3]) == 3
    assert AOC2017_2b.checksum([3, 8, 6, 5]) == 2

    assert AOC2017_2b.solve(@sampleB) == 9
  end
end
