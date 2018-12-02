defmodule AOC2018_2B do

  def solve([first_word | rest]) do
    find_match(first_word, rest)
    |> case do
      nil ->
        solve(rest)
      match ->
        match
    end
  end

  def find_match(_, []), do: nil

  def find_match(first_word, [second_word | rest]) do
    get_common_letters(first_word, second_word)
    |> case do
      nil ->
        find_match(first_word, rest)
      match ->
        match
    end
  end

  def get_common_letters(word1, word2, differences \\ 0, return_value \\ [])

  #if we get to the end and there are no differences, it's not a match
  def get_common_letters([], [], 0, _), do: nil

  #if we get to the end and there is one difference, return the accumulator (reversed)
  def get_common_letters([], [], 1, ret), do: Enum.reverse(ret)

  #if we find two differences, return nil and stop recursing
  def get_common_letters(_, _, 2, _), do: nil

  #first letter of words match, add it to accumulator and recurse
  def get_common_letters([first1 | rest1], [first2 | rest2], diffs, ret) when first1 == first2 do
    get_common_letters(rest1, rest2, diffs, [first1 | ret])
  end

  #first letter differs, add to number of differences and recurse
  def get_common_letters([_ | rest1], [_ | rest2], diffs, ret) do
    get_common_letters(rest1, rest2, diffs + 1, ret)
  end



end
