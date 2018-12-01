defmodule AOC2017_11Test do
  use ExUnit.Case

  test "Advent of Code 2017 11A" do
    input = File.read!("test/data/2017_11a_input.txt")
    |> String.split(",")
    |> Enum.map(&String.to_atom/1)
    assert AOC2017_11a.solve(input) == 810
  end

  test "reduce paths" do
    assert AOC2017_11a.solve([:n, :s]) == 0
  end

  test "Advent of Code 2017 11B" do
    input = File.read!("test/data/2017_11a_input.txt")
    |> String.split(",")
    |> Enum.map(&String.to_atom/1)
    assert AOC2017_11B.solve(input) == 1567
  end

end
