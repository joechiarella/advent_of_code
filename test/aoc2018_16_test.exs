defmodule AOC2018_16Test do
  use ExUnit.Case

  test "solves part 1" do
    assert AOC2018_16.solveA(read_input()) == 529
  end

  test "solves part 2" do
    assert AOC2018_16.solveB(read_input(), read_input2()) == 573
  end

  test "addr" do
    reg = %{0 => 0, 1 => 1, 2 => 2, 3 => 3}
    fun = &AOC2018_16.addr/2
    assert fun.(reg, [0, 1, 2]) == %{0 => 0, 1 => 1, 2 => 1, 3 => 3}

  end

  test "sample" do
    input = {[3, 2, 1, 1], [9, 2, 1, 2], [3, 2, 2, 1]}
    out = AOC2018_16.test(input, AOC2018_16.all_funs())
    assert length(out) == 3
  end

  def read_input do
    File.read!("test/data/2018_16_input.txt")
  end

  def read_input2 do
    File.read!("test/data/2018_16_input2.txt")
  end

end
