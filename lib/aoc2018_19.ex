defmodule AOC2018_19 do
  use Bitwise

  def solveA([ipline | input]) do
    ipreg = get_ip(ipline)

    input
    |> to_map()
    |> run(ipreg, 0, init_state(0))
  end

  def solveB([ipline | input]) do
    ipreg = get_ip(ipline)

    input
    |> to_map()
    |> run(ipreg, 0, init_state(1))
  end

  def run(instructions, _, next_inst, state)
    when next_inst < 0 or next_inst >= 40 do
    Map.get(state, 0)
  end

  def run(instructions, ipreg, next_inst, state) do
    state = Map.put(state, ipreg, next_inst)
    inst = Map.get(instructions, next_inst)
    # IO.puts "exec #{next_inst} #{inspect inst} #{inspect state}"

    state = exec(inst, state)
    next_inst = Map.get(state, ipreg) + 1
    run(instructions, ipreg, next_inst, state)
  end

  def exec([inst | abc], state) do

    apply(__MODULE__, inst, [state, abc])
  end

  def init_state(zero) do
    %{
      0 => zero,
      1 => 0,
      2 => 0,
      3 => 0,
      4 => 0,
      5 => 0
    }
  end

  def to_map(lines) do
    lines
    |> Enum.map(&parse/1)
    |> Enum.with_index(0)
    |> Enum.reduce(%{}, fn {op, i}, acc -> Map.put(acc, i, op) end)
  end

  def parse(line) do
    [opname | abc] = String.split(line)
    [String.to_existing_atom(opname) | Enum.map(abc, &String.to_integer/1)]
  end


  def get_ip(ipline) do
    ipline
    |> String.at(4)
    |> String.to_integer()
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
