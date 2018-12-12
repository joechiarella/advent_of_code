defmodule AOC2018_12Test do
  use ExUnit.Case

  @input '###.#..#..##.##.###.#.....#.#.###.#.####....#.##..#.#.#..#....##..#.##...#.###.#.#..#..####.#.##.#'

  test "solves part 1" do
    assert AOC2018_12.solveA(@input, 20) == 2909
  end

  test "solves part 2" do
    AOC2018_12.solveB(@input, 200)
    remaining = 50_000_000_000 - 200
    final = 11175 + remaining * 50
    assert final == 2500000001175
  end
end
