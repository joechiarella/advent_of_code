defmodule AOC2018_20 do
  def solveA(input) do
    input
    |> to_list
    |> path
  end

  def path([]), do: 0

  def path([next | rest]) when is_number(next) do
    1 + path(rest)
  end

  def path([list]) do
    list
    |> Enum.map(fn list -> path(list) end)
    |> Enum.max()
  end

  def path([list | rest]) do
    list
    |> Enum.map(fn list -> div(path(list), 2) end)
    |> Kernel.++([path(rest)])
    |> Enum.max()
  end

  def to_list(string) do
    string = Regex.replace(~r/\(/, string, "[[")
    string = Regex.replace(~r/\)/, string, "]]")
    string = Regex.replace(~r/\|/, string, ",")
    string = Regex.replace(~r/([SWNE]+)/, string, "'\\1'")
    string = Regex.replace(~r/'\[/, string, "'++[")
    string = Regex.replace(~r/\]'/, string, "]++'")
    string = Regex.replace(~r/\]\[/, string, "]++[")
    string = Regex.replace(~r/,\]/, string, ",[]]")
    string = Regex.replace(~r/[$^]/, string, "")
    {tree, _} = Code.eval_string(string, [],  __ENV__)
    tree
  end

  def solveB(input) do
    nil
  end
end
