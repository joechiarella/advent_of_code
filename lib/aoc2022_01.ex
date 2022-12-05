defmodule AOC2022_01 do
  def solveA(input) do
    input
    |> String.split("\n", trim: false)
    |> Enum.reduce([[]], fn
      "", acc -> [[] | acc]
      cals, [head | rest] -> [[String.to_integer(cals) | head] | rest]
    end)
    |> Enum.map(&Enum.sum/1)
    |> Enum.max()
  end

  def solveB(input) do
    input
    |> String.split("\n", trim: false)
    |> Enum.reduce([[]], fn
      "", acc -> [[] | acc]
      cals, [head | rest] -> [[String.to_integer(cals) | head] | rest]
    end)
    |> Enum.map(&Enum.sum/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end
end
