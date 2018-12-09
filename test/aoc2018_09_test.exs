defmodule AOC2018_09Test do
  use ExUnit.Case

  test "solves part 1" do
    assert AOC2018_09.solveA(476, 71431) == 384205
  end

  test "solves part 2" do
    assert AOC2018_09.solveA(476, 7143100) == 3066307353
  end

  @sample "test"

  # 10 players; last marble is worth 1618 points: high score is 8317
  # 13 players; last marble is worth 7999 points: high score is 146373
  # 17 players; last marble is worth 1104 points: high score is 2764
  # 21 players; last marble is worth 6111 points: high score is 54718
  # 30 players; last marble is worth 5807 points: high score is 37305
  test "solves part 1 (sample)" do
    assert AOC2018_09.solveA(9, 25) == 32
    assert AOC2018_09.solveA(10, 1618) == 8317
    assert AOC2018_09.solveA(13, 7999) == 146373
    assert AOC2018_09.solveA(17, 1104) == 2764
    assert AOC2018_09.solveA(21, 6111) == 54718
    assert AOC2018_09.solveA(30, 5807) == 37305
  end

  @tag :skip
  test "solves part 2 (sample)" do
    assert AOC2018_09.solveB(@sample) == :ok
  end

  def read_input do
    File.read!("test/data/2018_09_input.txt")
  end
end
