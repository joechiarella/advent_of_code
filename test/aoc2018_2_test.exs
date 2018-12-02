defmodule AOC2018_2Test do
  use ExUnit.Case

  test "Advent of Code 2018 2A" do
    input = File.read!("test/data/2018_2_input.txt")
    |> String.split
    |> Enum.map(&String.to_charlist/1)

    assert AOC2018_2A.solve(input) == 5704
  end

  test "get counts" do
    assert AOC2018_2A.get_counts('abcdef') == {0, 0}
    assert AOC2018_2A.get_counts('bababc') == {1, 1}
  end

  test "Advent of Code 2018 2B" do
    input = File.read!("test/data/2018_2_input.txt")
    |> String.split
    |> Enum.map(&String.to_charlist/1)

    assert AOC2018_2B.solve(input) == 'umdryabviapkozistwcnihjqx'
  end

  test "get common letters" do
    assert AOC2018_2B.get_common_letters('a', 'a') == nil
    assert AOC2018_2B.get_common_letters('a', 'b') == ''
    assert AOC2018_2B.get_common_letters('abcde', 'axcye') == nil
    assert AOC2018_2B.get_common_letters('fghij', 'fguij') == 'fgij'
  end

end
