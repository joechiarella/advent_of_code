defmodule AOC2017_4Test do
  use ExUnit.Case

  test "Advent of Code 2017 4A" do
    input = AOCFile.read_and_split("test/data/2017_4a_input.txt")
    assert AOC2017_4a.solve(input) == 451
  end

  test "valid passphrase 4A" do
    assert AOC2017_4a.valid?(~w(aa bb cc dd ee)) == true
    assert AOC2017_4a.valid?(~w(aa bb cc dd aa)) == false
    assert AOC2017_4a.valid?(~w(aa bb cc dd aaa)) == true
  end

  test "Advent of Code 2017 4B" do
    input = AOCFile.read_and_split("test/data/2017_4a_input.txt")
    assert AOC2017_4B.solve(input) == 451
  end

  test "valid passphrase 4B" do
    assert AOC2017_4B.valid?(~w(abcde fghij)) == true
    assert AOC2017_4B.valid?(~w(abcde xyz ecdab)) == false
    assert AOC2017_4B.valid?(~w(a ab abc abd abf abj)) == true
    assert AOC2017_4B.valid?(~w(iiii oiii ooii oooi oooo)) == true
    assert AOC2017_4B.valid?(~w(oiii ioii iioi iiio)) == false
  end


end
