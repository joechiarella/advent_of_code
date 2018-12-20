defmodule AOC2018_19Test do
  use ExUnit.Case
  import ExProf.Macro

  test "solves part 1" do
    assert AOC2018_19.solveA(read_input()) == 930
  end

  @tag skip: true
  test "solves part 2" do
    assert AOC2018_19.solveB(read_input()) == :ok
  end

  def read_input do
    File.read!("test/data/2018_19_input.txt")
    |> String.split(~r{(\r\n|\r|\n)})
    |> Enum.filter(&(String.length(&1) > 0))
  end
end
