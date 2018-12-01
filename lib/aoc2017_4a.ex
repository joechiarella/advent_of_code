  defmodule AOC2017_4a do
  def solve(input) do
    input
    |> Enum.filter(&valid?/1)
    |> length
  end

  def valid?(passphrase) do
    length(passphrase) == length(Enum.uniq(passphrase))
  end
end
