defmodule AOC2018_16 do
  use Bitwise

  def solveA(input) do
    input
    |> String.split(~r{(\r\n|\r|\n)})
    |> Enum.filter(&(String.length(&1) > 0))
    |> Enum.chunk_every(3)
    |> Enum.map(&parse_sample/1)
    |> Enum.filter(fn input ->
      length(test(input, all_funs())) >= 3
    end)
    |> Enum.count
  end


  def solveB(input, input2) do
    fun_map =
      input
      |> String.split(~r{(\r\n|\r|\n)})
      |> Enum.filter(&(String.length(&1) > 0))
      |> Enum.chunk_every(3)
      |> Enum.map(&parse_sample/1)
      |> Enum.sort_by(fn {_, [op | _], _} -> op end)
      |> Enum.chunk_by(fn {_, [op | _], _} -> op end)
      |> Enum.with_index(0)
      |> Enum.map(&find_fun/1)
      |> build_map(%{})

    reg = init_state([0, 0, 0, 0])

    input2
    |> String.split(~r{(\r\n|\r|\n)})
    |> Enum.map(&parse_op/1)
    |> Enum.reduce(reg, fn [opcode | abc], reg ->
      fun = Map.get(fun_map, opcode)
      fun.(reg, abc)
    end)
    |> Map.get(0)
  end

  def build_map(potential_mappings, mapping) when length(potential_mappings) == 0 do
    mapping
  end

  def build_map(potential_mappings, mapping) do
    unique = Enum.filter(potential_mappings, fn {list, _} -> length(list) == 1 end)

    mapping = Enum.reduce(unique, mapping, fn {[fun], op}, acc ->
      Map.put(acc, op, fun)
    end)

    to_remove = Map.values(mapping)

    potential_mappings -- unique
    |> Enum.map(fn {funs, op} -> {funs -- to_remove, op} end)
    |> build_map(mapping)
  end

  def find_fun({inputs, opcode}) do
    fun = all_funs()
    |> Enum.filter(fn fun ->
      Enum.all?(inputs, fn input -> test(input, fun) end)
    end)

    {fun, opcode}
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

  def test({bef, [opcode | abc], aft}, funs) when is_list(funs) do
    reg = init_state(bef)
    funs
    |> Enum.filter(fn fun -> fun.(reg, abc) == init_state(aft) end)
  end

  def test({bef, [opcode | abc], aft}, fun) do
    reg = init_state(bef)
    fun.(reg, abc) == init_state(aft)
  end

  def init_state([zero, one, two, three]) do
    %{
      0 => zero,
      1 => one,
      2 => two,
      3 => three
    }
  end

  def all_funs() do
    [&addr/2, &addi/2, &mulr/2, &muli/2, &banr/2, &bani/2,
      &borr/2, &bori/2, &setr/2, &seti/2, &gtir/2, &gtri/2, &gtrr/2,
      &eqir/2, &eqri/2, &eqrr/2]
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


end
