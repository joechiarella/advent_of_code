defmodule AOC2018_20Test do
  use ExUnit.Case

  test "solves part 1" do
    assert AOC2018_20.solveA(read_input()) == 3014
  end

  @tag :skip
  test "solves part 2" do
    assert AOC2018_20.solveB(read_input()) == :ok
  end

  test "solves part 1 (sample)" do
    assert AOC2018_20.solveA("^WNE$") == 3
    assert AOC2018_20.solveA("^ENWWW(NEEE|SSE(EE|N))$") == 10
    assert AOC2018_20.solveA("^ENNWSWW(NEWS|)SSSEEN(WNSE|)EE(SWEN|)NNN$") == 18
    assert AOC2018_20.solveA("^ESSWWN(E|NNENN(EESS(WNSE|)SSS|WWWSSSSE(SW|NNNE)))$") == 23
    assert AOC2018_20.solveA("^WSSEESWWWNW(S|NENNEEEENN(ESSSSW(NWSW|SSEN)|WSWWN(E|WWS(E|SS))))$") == 31
  end

  def read_input do
    File.read!("test/data/2018_20_input.txt")
  end


end
