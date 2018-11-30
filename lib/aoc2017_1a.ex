defmodule AOC2017_1a do
  def solve(input) do
    charlist = String.to_charlist(input)
    charlist = charlist ++ [List.first(charlist)]
    sum_pairs(charlist)
  end

  def sum_pairs([first | [second | _ ] = rest]) when first == second do
    (first - ?0) + sum_pairs(rest)
  end

  def sum_pairs([_]), do: 0

  def sum_pairs([_ | rest]) do
    sum_pairs(rest)
  end
end
