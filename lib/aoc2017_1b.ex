defmodule AOC2017_1b do
  def solve(input) do
    charlist = String.to_charlist(input)
    len = length(charlist)
    {second, first} = Enum.split(charlist, div(len, 2))
    rot_list = first ++ second
    sum_pairs(charlist, rot_list)
  end

  def sum_pairs([first | rest], [second | rot_rest]) when first == second do
    (first - ?0) + sum_pairs(rest, rot_rest)
  end

  def sum_pairs([_ | rest], [_ | rot_rest]) do
    sum_pairs(rest, rot_rest)
  end

  def sum_pairs(_, _), do: 0
end
