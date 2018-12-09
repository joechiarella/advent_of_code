defmodule AOC2018_07.Helpers do
  @doc """
  Parses the file and returns it as a list of tuples in the form
  `{step, pre}` where `step` is the letter id of a step and `pre` is a list of ids of
  the steps that must happen before it.
  """
  def parse(file) do
    params = file
    |> String.split(~r{(\r\n|\r|\n)})
    |> Enum.filter(&(String.length(&1) > 0))
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(fn line ->
      prereq_char = Enum.at(line, 5)
      step_char = Enum.at(line, 36)
      {prereq_char, step_char}
    end)

    all_steps = get_all_steps(params)

    all_steps
    |> Enum.map(fn step ->

      pres = params
      |> Enum.filter(fn {_pre, sstep} -> sstep == step end)
      |> Enum.reduce([], fn {pre, _step}, acc ->
        [pre | acc]
      end)

      {step, pres}
    end)
  end

  def get_all_steps(params) do
    params
    |> Enum.reduce(MapSet.new(), fn {step, pre}, acc ->
      acc
      |> MapSet.put(step)
      |> MapSet.put(pre)
    end)
    |> MapSet.to_list
    |> Enum.sort
  end

  defmacro create_solve_fun(pre, step) do
    quote bind_quoted: [pre: pre, step: step] do
      def solve(unquote(Macro.escape(pre)) = map) do
        [unquote(step) | solve(%{map | unquote(step) => true})]
      end
    end
  end
end
