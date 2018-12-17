defmodule AOC2018_16 do
  use Bitwise

  def solveA(input) do
    input
    |> String.split(~r{(\r\n|\r|\n)})
    |> Enum.filter(&(String.length(&1) > 0))
    |> Enum.chunk_every(3)
    |> Enum.map(&parse_sample/1)
  end

  def parse_sample([bef, op, aft]) do
    {
      string_to_list(bef, 8),
      parse_op(op),
      string_to_list(aft, 7)
    }
  end

  def parse_op(op)do
    op
    |> String.split
    |> Enum.map(&String.to_integer/1)
  end

  def string_to_list(str, start) do
    {val, []} =
      str
      |> String.slice(start..100)
      |> Code.eval_string
    val
  end

# Addition:
# addr (add register) stores into register C the result of adding register A and register B.
# addi (add immediate) stores into register C the result of adding register A and value B.

  def addr(reg, [a, b, c]) do
    Map.put(reg, c, reg[a] + reg[b])
  end

  def addi(reg, [a, b, c]) do
    Map.put(reg, c, reg[a] + b)
  end

# Multiplication:
# mulr (multiply register) stores into register C the result of multiplying register A and register B.
# muli (multiply immediate) stores into register C the result of multiplying register A and value B.
  def mulr(reg, [a, b, c]) do
    Map.put(reg, c, reg[a] * reg[b])
  end

  def muli(reg, [a, b, c]) do
    Map.put(reg, c, reg[a] * b)
  end

# Bitwise AND:
# banr (bitwise AND register) stores into register C the result of the bitwise AND of register A and register B.
# bani (bitwise AND immediate) stores into register C the result of the bitwise AND of register A and value B.
  def banr(reg, [a, b, c]) do
    Map.put(reg, c, reg[a] &&& reg[b])
  end

  def bani(reg, [a, b, c]) do
    Map.put(reg, c, reg[a] &&& b)
  end

# Bitwise OR:
# borr (bitwise OR register) stores into register C the result of the bitwise OR of register A and register B.
# bori (bitwise OR immediate) stores into register C the result of the bitwise OR of register A and value B.
  def borr(reg, [a, b, c]) do
    Map.put(reg, c, reg[a] ||| reg[b])
  end

  def bori(reg, [a, b, c]) do
    Map.put(reg, c, reg[a] ||| b)
  end

# Assignment:
# setr (set register) copies the contents of register A into register C. (Input B is ignored.)
# seti (set immediate) stores value A into register C. (Input B is ignored.)
  def setr(reg, [a, _b, c]) do
    Map.put(reg, c, reg[a])
  end

  def seti(reg, [a, _b, c]) do
    Map.put(reg, c, a)
  end

# Greater-than testing:
# gtir (greater-than immediate/register) sets register C to 1 if value A is greater than register B. Otherwise, register C is set to 0.
# gtri (greater-than register/immediate) sets register C to 1 if register A is greater than value B. Otherwise, register C is set to 0.
# gtrr (greater-than register/register) sets register C to 1 if register A is greater than register B. Otherwise, register C is set to 0.
  def gtir(reg, [a, b, c]) do
    val = if a > reg[b], do: 1, else: 0
    Map.put(reg, c, val)
  end

  def gtri(reg, [a, b, c]) do
    val = if reg[a] > b, do: 1, else: 0
    Map.put(reg, c, val)
  end

  def gtrr(reg, [a, b, c]) do
    val = if reg[a] > reg[b], do: 1, else: 0
    Map.put(reg, c, val)
  end

# Equality testing:
# eqir (equal immediate/register) sets register C to 1 if value A is equal to register B. Otherwise, register C is set to 0.
# eqri (equal register/immediate) sets register C to 1 if register A is equal to value B. Otherwise, register C is set to 0.
# eqrr (equal register/register) sets register C to 1 if register A is equal to register B. Otherwise, register C is set to 0.
  def eqir(reg, [a, b, c]) do
    val = if a == reg[b], do: 1, else: 0
    Map.put(reg, c, val)
  end

  def eqri(reg, [a, b, c]) do
    val = if reg[a] == b, do: 1, else: 0
    Map.put(reg, c, val)
  end

  def eqrr(reg, [a, b, c]) do
    val = if reg[a] == reg[b], do: 1, else: 0
    Map.put(reg, c, val)
  end

  def solveB(input) do
    nil
  end

end
