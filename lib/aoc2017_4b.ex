  defmodule AOC2017_4B do
  def solve(input) do
    input
    |> Enum.filter(&valid?/1)
    |> length
  end

  def valid?(passphrase) do
    len = passphrase
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(&Enum.sort/1)
    |> Enum.uniq
    |> length
    len == length(passphrase)
  end
end
