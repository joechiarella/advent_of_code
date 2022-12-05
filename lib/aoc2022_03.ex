defmodule AOC2022_03 do
  def solveA(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&to_sacks/1)
    |> Enum.map(&find_common/1)
    |> Enum.map(&score/1)
    |> Enum.sum()
  end

  def score(c) when c >= hd('a') and c <= hd('z') do
    c - hd('a') + 1
  end

  def score(c) when c >= hd('A') and c <= hd('Z') do
    c - hd('A') + 27
  end

  def find_common({sack1, sack2}) do
    MapSet.new(sack1)
    |> MapSet.intersection(MapSet.new(sack2))
    |> MapSet.to_list()
    |> hd()
  end

  def to_sacks(line) do
    line
    |> String.to_charlist()
    |> halfsies()
  end

  def halfsies(list) do
    len = length(list)
    Enum.split(list, div(len, 2))
  end

  def solveB(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
    |> Enum.chunk_every(3)
    |> Enum.map(&find_badge/1)
    |> Enum.map(&score/1)
    |> Enum.sum()
  end

  def find_badge([sack1, sack2, sack3]) do
    MapSet.new(sack1)
    |> MapSet.intersection(MapSet.new(sack2))
    |> MapSet.intersection(MapSet.new(sack3))
    |> MapSet.to_list()
    |> hd()
  end
end
