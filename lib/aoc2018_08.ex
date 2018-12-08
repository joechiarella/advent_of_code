defmodule AOC2018_08 do

  defmodule Node do
    defstruct children: [], meta: []
  end

  def solveA(input) do
    {root, []} = input
    |> String.split
    |> Enum.map(&String.to_integer/1)
    |> parse

    root
    |> sum_metas
  end

  def sum_metas(%Node{children: children, meta: meta}) do
    children
    |> Enum.reduce(0, fn node, acc ->
      acc + sum_metas(node)
    end)
    |> Kernel.+(Enum.sum(meta))
  end

  def parse([num_children | [num_meta | rest]]) do
    {children, rest} = get_children(rest, num_children)
    {meta, rest} = get_meta(rest, num_meta)
    {%Node{children: children, meta: meta}, rest}
  end

  def get_children(list, 0) do
    {[], list}
  end

  def get_children(list, num_children) do
    {node, rest} = parse(list)
    {children, rest} = get_children(rest, num_children - 1)
    {[node | children], rest}
  end

  def get_meta(list, 0) do
    {[], list}
  end

  def get_meta([meta | rest], num_meta) do
    {metas, rest} = get_meta(rest, num_meta - 1)
    {[meta | metas], rest}
  end

  def solveB(input) do
    {root, []} = input
    |> String.split
    |> Enum.map(&String.to_integer/1)
    |> parse

    root
    |> get_value
  end

  def get_value(:none) do
    0
  end

  def get_value(%Node{children: [], meta: meta}) do
    Enum.sum(meta)
  end

  def get_value(%Node{children: children, meta: meta}) do

    meta
    |> Enum.reduce(0, fn index, acc ->
      acc + get_value_at(children, index - 1)
    end)
  end

  def get_value_at(children, index) do
    get_value(Enum.at(children, index, :none))
  end
end
