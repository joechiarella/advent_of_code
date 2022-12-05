defmodule AOC2022_02 do
  def solveA(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
    |> Enum.map(&parse_round/1)
    |> Enum.map(&score/1)
    |> Enum.sum()
    |> IO.inspect()
  end

  def solveB(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
    |> Enum.map(&parse_roundB/1)
    |> Enum.map(&score/1)
    |> Enum.sum()
    |> IO.inspect()
  end

  def score({them, me}) do
    shape(me) + outcome(them, me)
  end

  def shape(:rock), do: 1
  def shape(:paper), do: 2
  def shape(:scissors), do: 3

  def outcome(them, me) when them == me, do: 3
  def outcome(:rock, :paper), do: 6
  def outcome(:paper, :scissors), do: 6
  def outcome(:scissors, :rock), do: 6
  def outcome(_, _), do: 0

  def parse_round([them, me]) do
    {parse(them), parse(me)}
  end

  def parse_roundB([them, result]) do
    {parse(them), parseResult(result)}
    |> deriveMove()
  end

  def deriveMove({them, :draw}), do: {them, them}
  def deriveMove({:rock, :win}), do: {:rock, :paper}
  def deriveMove({:rock, :lose}), do: {:rock, :scissors}
  def deriveMove({:paper, :win}), do: {:paper, :scissors}
  def deriveMove({:paper, :lose}), do: {:paper, :rock}
  def deriveMove({:scissors, :win}), do: {:scissors, :rock}
  def deriveMove({:scissors, :lose}), do: {:scissors, :paper}

  def parse(turn) when turn in ["A", "X"], do: :rock
  def parse(turn) when turn in ["B", "Y"], do: :paper
  def parse(turn) when turn in ["C", "Z"], do: :scissors

  def parseResult("X"), do: :lose
  def parseResult("Y"), do: :draw
  def parseResult("Z"), do: :win
end
