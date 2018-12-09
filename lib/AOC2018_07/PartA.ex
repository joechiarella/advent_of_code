defmodule AOC2018_07.PartA do
  @external_resource("test/data/2018_07_input.txt")
  require AOC2018_07.Helpers
  alias AOC2018_07.Helpers

  parsed = File.read!("test/data/2018_07_input.txt")
  |> Helpers.parse

  parsed
  |> Enum.each(fn {step, prereqs} ->
      pre = prereqs
      |> Enum.reduce(%{}, fn (pre, acc) -> Map.put(acc, pre, true) end)
      |> Map.put(step, false)

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



