defmodule AOC2018_14 do

  def solveA(stop) do
    board = %{1 => 3, 2 => 7}
    elf1 = 1
    elf2 = 2
    size = 2

    tick(board, size, elf1, elf2, stop)
  end

  def tick(board, size, elf1, elf2, stop) when size < stop + 10 do
    val1 = Map.get(board, elf1)
    val2 = Map.get(board, elf2)
    new = val1 + val2
    {board, size} =
      if new >= 10 do
        { board
          |> add_digit(size + 1, 1)
          |> add_digit(size + 2, rem(new, 10)),
          size + 2 }
      else
        { add_digit(board, size + 1, new),
          size + 1 }
      end
    elf1 = move(elf1, val1, size)
    elf2 = move(elf2, val2, size)
    tick(board, size, elf1, elf2, stop)
  end

  def tick(board, size, _elf1, _elf2, stop) do
    for i <- stop + 1..stop + 10 do
      Map.get(board, i) + ?0
    end
  end

  def move(elf, val, size) do
    rem(elf + val, size) + 1
  end

  def add_digit(board, pos, digit) do
    Map.put(board, pos, digit)
  end

  def solveB(stop) do
    board = %{1 => 3, 2 => 7}
    elf1 = 1
    elf2 = 2
    size = 2

    tickB(board, size, elf1, elf2, stop)
  end

  def tickB(board, size, elf1, elf2, stop) when size < 30_000_000 do
    val1 = Map.get(board, elf1)
    val2 = Map.get(board, elf2)
    new = val1 + val2
    {board, size} =
      if new >= 10 do
        { board
          |> add_digit(size + 1, 1)
          |> add_digit(size + 2, rem(new, 10)),
          size + 2 }
      else
        { add_digit(board, size + 1, new),
          size + 1 }
      end
    elf1 = move(elf1, val1, size)
    elf2 = move(elf2, val2, size)
    tickB(board, size, elf1, elf2, stop)
  end

  def tickB(board, size, _elf1, _elf2, stop) do
    digits = Integer.digits(stop)

    1..size
    |> Enum.map(fn i -> Map.get(board, i) end)
    |> Enum.chunk_every(length(digits), 1, :discard)
    |> Enum.find_index(fn chunk -> chunk == digits end)
  end




end
