defmodule AOC2018_07 do



  def solveB(input) do
    nil
  end

  @external_resource("test/data/2018_07_input.txt")
  parsed = File.read!("test/data/2018_07_input.txt")
  |> String.split(~r{(\r\n|\r|\n)})
  |> Enum.filter(&(String.length(&1) > 0))
  |> Enum.map(fn line ->
    [_, prereq, step] = Regex.run(~r/Step ([A-Z]) must be finished before step ([A-Z]) can begin./, line)
    [prereq_char] = String.to_charlist(prereq)
    [step_char] = String.to_charlist(step)
    {prereq_char, step_char}
  end)

  parsed
  |> Enum.sort_by(fn {_pre, step} -> step end)
  |> Enum.chunk_by(fn {_pre, step} -> step end)
  |> Enum.each(fn prereqs ->
      {_pre, step} = hd(prereqs)

      IO.puts " >>>>>"
      IO.inspect prereqs
      pre = prereqs
      |> Enum.map(fn {pre, _step} -> pre end)
      |> Enum.reduce(%{}, fn (pre, acc) -> Map.put(acc, pre, true) end)
      |> Map.put(step, false)

      def solve(unquote(Macro.escape(pre)) = map) do
        [unquote(step) | solve(%{map | unquote(step) => true})]
      end
    end)


  pres = parsed
  |> Enum.map(fn {_pre, step} -> step end)
  |> Enum.uniq()


  ?A..?Z
  |> Enum.reject(fn step -> step in pres end)
  |> Enum.each(fn pre ->
    match = %{pre => false}
    def solve(unquote(Macro.escape(match)) = map) do
      [unquote(pre) | solve(%{map | unquote(pre) => true})]
    end
  end)

  def solve(_) do
    []
  end

  def solveA() do
    for c <- ?A..?Z, into: %{} do
      {c, false}
    end
    |> solve
  end
end



