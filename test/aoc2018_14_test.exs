defmodule AOC2018_14Test do
  use ExUnit.Case
  import ExProf.Macro

  test "solves part 1" do
    assert AOC2018_14.solveA(635041) == '1150511382'
  end

  # @tag :skip
  test "solves part 2" do
    assert AOC2018_14.solveB(635041) == 20173656
  end

  test "solves part 1 (sample)" do
    assert AOC2018_14.solveA(9) == '5158916779'
    assert AOC2018_14.solveA(5) == '0124515891'
    assert AOC2018_14.solveA(18) == '9251071085'
    assert AOC2018_14.solveA(2018) == '5941429882'
  end

  @tag :skip
  test "solves part 2 (sample)" do
    assert AOC2018_14.solveB(59414) == 2018
  end

  def read_input do
    File.read!("test/data/2018_14_input.txt")
  end
end
