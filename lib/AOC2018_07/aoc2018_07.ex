defmodule AOC2018_07.PartA do
  @external_resource("test/data/2018_07_input.txt")
  require AOC2018_07.Helpers
  alias AOC2018_07.Helpers

  parsed = Helpers.parse("test/data/2018_07_input.txt")

  parsed
  |> Enum.each(fn {step, prereqs} ->
      pre = prereqs
      |> Enum.reduce(%{}, fn (pre, acc) -> Map.put(acc, pre, true) end)
      |> Map.put(step, false)

      Helpers.create_solve_fun(pre, step)
    end)

  steps = Enum.map(parsed, fn {step, _pre} -> step end)

  ?A..?Z
  |> Enum.reject(fn step -> step in steps end)
  |> Enum.each(fn step ->
    pre = %{step => false}
    Helpers.create_solve_fun(pre, step)
  end)

  def solve(_) do
    []
  end

  def solve() do
    for c <- ?A..?Z, into: %{} do
      {c, false}
    end
    |> solve
  end
end



