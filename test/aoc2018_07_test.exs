defmodule AOC2018_07Test do
  use ExUnit.Case

  test "solves part 1" do
    assert AOC2018_07.solveA() == 'HEGMPOAWBFCDITVXYZRKUQNSLJ'
  end

  @tag :skip
  test "solves part 2" do
    assert AOC2018_07.solveB(read_input()) == :ok
  end

  @sample """
  Step C must be finished before step A can begin.
  Step C must be finished before step F can begin.
  Step A must be finished before step B can begin.
  Step A must be finished before step D can begin.
  Step B must be finished before step E can begin.
  Step D must be finished before step E can begin.
  Step F must be finished before step E can begin.
  """

  @tag :skip
  test "solves part 2 (sample)" do
    assert AOC2018_07.solveB(@sample) == :ok
  end

  test "experiment sample" do
    assert solve(%{A: false, B: false, C: false, D: false, E: false, F: false}) == 'CABDFE'
  end

  def read_input do
    File.read!("test/data/2018_07_input.txt")
  end

  def solve(%{C: true, A: false} = map) do
    [?A | solve(%{map | A: true})]
  end

  def solve(%{A: true, B: false} = map) do
    [?B | solve(%{map | B: true})]
  end

  def solve(%{C: false} = map) do
    [?C | solve(%{map | C: true})]
  end

  def solve(%{A: true, D: false} = map) do
    [?D | solve(%{map | D: true})]
  end

  def solve(%{B: true, D: true, F: true, E: false} = map) do
    [?E | solve(%{map | E: true})]
  end

  def solve(%{C: true, F: false} = map) do
    [?F | solve(%{map | F: true})]
  end

  def solve(map) do
    []
  end
end
