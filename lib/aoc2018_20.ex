defmodule AOC2018_20 do

  def solveA(input) do
    input
    |> to_list
    |> generate_paths([])
  end

  def generate_paths([next | rest], prefix) when next in [?N, ?E, ?S, ?W] do
    generate_paths(rest, [next | prefix])
  end

  def generate_paths([next | rest], prefix) when is_list(next) do

  end

  def to_list(string) do
    string = Regex.replace(~r/\(/, string, "[[")
    string = Regex.replace(~r/\)/, string, "]]")
    string = Regex.replace(~r/\|/, string, ",")
    string = Regex.replace(~r/([SWNE]+)/, string, "'\\1'")
    string = Regex.replace(~r/'\[/, string, "'++[")
    string = Regex.replace(~r/\]'/, string, "]++'")
    string = Regex.replace(~r/,\]/, string, ",[]]")
    string = Regex.replace(~r/[$^]/, string, "")
    {tree, _ } = Code.eval_string(string)
    tree
  end

  def solveB(input) do
    nil
  end

end
