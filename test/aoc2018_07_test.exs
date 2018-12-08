defmodule AOC2018_07Test do
  use ExUnit.Case

  test "solves part 1" do
    assert AOC2018_07.PartA.solve() == 'HEGMPOAWBFCDITVXYZRKUQNSLJ'
  end

  @tag :skip
  test "solves part 2" do
    assert AOC2018_07.solveB(read_input()) == :ok
  end



  test "solves part 2 (sample)" do
    assert solveB(%{A: false, B: false, C: false, D: false, E: false, F: false}, 2) == 15
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

  def solve(_) do
    []
  end


  @sample """
  Step C must be finished before step A can begin.
  Step A must be finished before step B can begin.
  Step A must be finished before step D can begin.
  Step B must be finished before step E can begin.
  Step D must be finished before step E can begin.
  Step F must be finished before step E can begin.
  Step C must be finished before step F can begin.
  """


  def value_of(c) do
    c - ?A + 1
  end

  def solveB(_map, 0, acc) do
    IO.puts "Out of workers, waiting"
    acc
  end

  def solveB(%{C: true, A: false} = map, workers, {letters, time} = acc) do
    acc = solveB(%{map | A: workers}, acc)
    solveB(%{map | A: true}, workers, {[?A | letters], time + value_of(?A)})
  end

  def solveB(%{A: true, B: false} = map, workers, acc) do
    value_of(?B) + solveB(%{map | B: true}, workers)
  end

  def solveB(%{C: false} = map, workers, acc) do
    value_of(?C) + solveB(%{map | C: true}, workers)
  end

  def solveB(%{A: true, D: false} = map, workers, acc) do
    value_of(?D) + solveB(%{map | D: true}, workers)
  end

  def solveB(%{B: true, D: true, F: true, E: false} = map, workers, acc) do
    value_of(?E) + solveB(%{map | E: true}, workers)
  end

  def solveB(%{C: true, F: false} = map, workers, acc) do
    value_of(?F) + solveB(%{map | F: true}, workers)
  end

  def solveB(_, _) do
    0
  end
end
