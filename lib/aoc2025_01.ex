defmodule AOC2025_01 do
  def solveA(input) do
    turns =
      String.split(input, "\n")
      |> Enum.filter(&(&1 != ""))
      |> Enum.map(&parse_line/1)

    {zeroes, _} =
      Enum.map_reduce(turns, 50, fn turn, position ->
        new_position = turn(position + turn)

        zero = if new_position == 0, do: 1, else: 0

        {zero, new_position}
      end)

    Enum.sum(zeroes)
  end

  defp turn(new_position) when new_position > 99 do
    turn(new_position - 100)
  end

  defp turn(new_position) when new_position < 0 do
    turn(new_position + 100)
  end

  defp turn(new_position) do
    new_position
  end

  defp parse_line("L" <> num) do
    -String.to_integer(num)
  end

  defp parse_line("R" <> num) do
    String.to_integer(num)
  end

  def solveB(input) do
    turns =
      String.split(input, "\n")
      |> Enum.filter(&(&1 != ""))
      |> Enum.map(&parse_line/1)

    {zeroes, _} = Enum.map_reduce(turns, 50, &turnB/2)

    Enum.sum(zeroes)
  end

  def turnB(turn, start, zeroes \\ 0)

  def turnB(turn, start, zeroes) when start == 0 and turn < 0 do
    turnB(turn, 100, zeroes)
  end

  def turnB(turn, start, zeroes) when start + turn == 100 or start + turn == 0 do
    {zeroes + 1, 0}
  end

  def turnB(turn, start, zeroes) when start + turn >= 100 do
    turnB(turn, start - 100, zeroes + 1)
  end

  def turnB(turn, start, zeroes) when start + turn < 0 do
    turnB(turn, start + 100, zeroes + 1)
  end

  def turnB(turn, start, zeroes) do
    {zeroes, start + turn}
  end
end
