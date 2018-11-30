defmodule AOC2017_3Test do
  use ExUnit.Case

  @input 361527

  test "Advent of Code 2017 3A" do
    assert AOC2017_3a.solve(@input) == 326
  end

  test "get_ring" do
    assert AOC2017_3a.get_ring(1) == 0
    2..9
    |> Enum.each(fn num -> assert AOC2017_3a.get_ring(num) == 1 end)

    10..25
    |> Enum.each(fn num -> assert AOC2017_3a.get_ring(num) == 2 end)

    26..49
    |> Enum.each(fn num -> assert AOC2017_3a.get_ring(num) == 3 end)
  end

  test "get_lateral_distance" do
    assert AOC2017_3a.get_lateral_distance(1, 0) == 0
    assert AOC2017_3a.get_lateral_distance(2, 1) == 0
    assert AOC2017_3a.get_lateral_distance(3, 1) == 1
    assert AOC2017_3a.get_lateral_distance(4, 1) == 0
    assert AOC2017_3a.get_lateral_distance(5, 1) == 1
    assert AOC2017_3a.get_lateral_distance(10, 2) == 1
    assert AOC2017_3a.get_lateral_distance(11, 2) == 0
    assert AOC2017_3a.get_lateral_distance(12, 2) == 1
    assert AOC2017_3a.get_lateral_distance(13, 2) == 2
  end

  test "get size for ring" do
    assert AOC2017_3a.get_size_for_ring(0) == 1
    assert AOC2017_3a.get_size_for_ring(1) == 3
    assert AOC2017_3a.get_size_for_ring(2) == 5
  end


end
