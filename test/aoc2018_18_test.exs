defmodule AOC2018_18Test do
  use ExUnit.Case

  test "solves part 1" do
    assert AOC2018_18.solveA(read_input(), 50, 10) == 507755
  end

  @tag skip: true
  test "solves part 2" do
    assert AOC2018_18.solveA(read_input(), 50, 1_000_000_000) == :ok
  end

  def read_input do
    File.read!("test/data/2018_18_input.txt")
    |> String.split(~r{(\r\n|\r|\n)})
    |> Enum.filter(&(String.length(&1) > 0))
  end

  @sample """
  .#.#...|#.
  .....#|##|
  .|..|...#.
  ..|#.....#
  #.#|||#|#|
  ...#.||...
  .|....|...
  ||...#|.#|
  |.||||..|.
  ...#.|..|.
  """ |> String.split(~r{(\r\n|\r|\n)})
  |> Enum.filter(&(String.length(&1) > 0))

  test "sample 2" do
    assert AOC2018_18.solveA(@sample, 10, 10) == 1147
  end

end
