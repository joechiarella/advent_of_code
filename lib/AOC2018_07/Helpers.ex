defmodule AOC2018_07.Helpers do
  @doc """
  Parses the file and returns it as a list of tuples in the form
  `{step, pre}` where `step` is the letter id of a step and `pre` is a list of ids of
  the steps that must happen before it.
  """
  def parse(file) do
    File.read!(file)
    |> String.split(~r{(\r\n|\r|\n)})
    |> Enum.filter(&(String.length(&1) > 0))
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(fn line ->
      prereq_char = Enum.at(line, 5)
      step_char = Enum.at(line, 36)
      {prereq_char, step_char}
    end)
    |> Enum.sort_by(fn {_pre, step} -> step end)
    |> Enum.chunk_by(fn {_pre, step} -> step end)
    |> Enum.map(fn prereqs ->
      {_pre, step} = hd(prereqs)

      pre = prereqs
      |> Enum.reduce([], fn ({pre, _step}, acc) -> [pre | acc] end)

      {step, pre}
    end)
  end

  defmacro create_solve_fun(pre, step) do
    quote bind_quoted: [pre: pre, step: step] do
      def solve(unquote(Macro.escape(pre)) = map) do
        [unquote(step) | solve(%{map | unquote(step) => true})]
      end
    end
  end
end
