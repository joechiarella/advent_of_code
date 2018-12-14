defmodule AOC2018_13 do
  defmodule Cart do
    defstruct pos: {0, 0}, dir: :s, turns: :left, crash: false
  end

  def solveA(input) do
    {tracks, carts} = parse(input)
    tick(carts, tracks)
  end

  def tick(carts, tracks) do
    carts =
      carts
      |> Enum.sort_by(fn %Cart{pos: {x, y}} -> {y, x} end)
      |> move_carts([], tracks)

    crashed = find_crash(carts)
    if crashed == :none do
      tick(carts, tracks)
    else
      crashed.pos
    end

  end

  def find_crash(carts) do
    carts
    |> Enum.find(:none, fn cart -> cart.crash == true end)
  end

  def move_carts([next | rest], moved, tracks) do
    now = move_cart(next, tracks)
    cart =
      if check_collision(now.pos, rest ++ moved) do
        %Cart{now | crash: true}
      else
        now
      end
    move_carts(rest, [cart | moved], tracks)
  end

  def move_carts([], moved, _) do
    moved
  end

  def check_collision(pos, others) do
    Enum.any?(others, fn other -> other.pos == pos end)
  end

  def move_cart(%Cart{pos: pos, dir: dir, turns: turns}, tracks) do
    new_pos = get_new_pos(pos, dir)
    tile = Map.get(tracks, new_pos)
    new_dir = get_new_dir(dir, tile)
    {new_dir, turns} = turn(tile, new_dir, turns)
    %Cart{
      pos: new_pos,
      dir: new_dir,
      turns: turns
    }
  end

  def turn(:plus, dir, turns) do
    {turn(dir, turns), next(turns)}
  end

  def turn(_, dir, turns) do
    {dir, turns}
  end

  def next(:left), do: :straight
  def next(:straight), do: :right
  def next(:right), do: :left

  def turn(:n, :left), do: :w
  def turn(:w, :left), do: :s
  def turn(:s, :left), do: :e
  def turn(:e, :left), do: :n

  def turn(:n, :right), do: :e
  def turn(:w, :right), do: :n
  def turn(:s, :right), do: :w
  def turn(:e, :right), do: :s

  def turn(dir, :straight), do: dir

  def get_new_dir(:e, :slash), do: :n
  def get_new_dir(:w, :slash), do: :s
  def get_new_dir(:n, :slash), do: :e
  def get_new_dir(:s, :slash), do: :w

  def get_new_dir(:e, :backslash), do: :s
  def get_new_dir(:w, :backslash), do: :n
  def get_new_dir(:n, :backslash), do: :w
  def get_new_dir(:s, :backslash), do: :e

  def get_new_dir(dir, _), do: dir

  def get_new_pos({x, y}, :n), do: {x, y - 1}
  def get_new_pos({x, y}, :s), do: {x, y + 1}
  def get_new_pos({x, y}, :w), do: {x - 1, y}
  def get_new_pos({x, y}, :e), do: {x + 1, y}

  def parse(input) do
    input
    |> String.split(~r{(\r\n|\r|\n)})
    |> Enum.filter(&(String.length(&1) > 0))
    |> Enum.map(&String.to_charlist/1)
    |> Enum.with_index
    |> Enum.reduce({%{}, []}, &create_row/2)
  end

  def create_row({row, y}, acc) do
    row
    |> Enum.with_index(0)
    |> Enum.reduce(acc, &(create_cell(&1, y, &2)))
  end

  def create_cell({?\s, _}, _, state) do
    state
  end

  def create_cell({char, x}, y, {tracks, carts}) when char in '<>^v' do
    {
      Map.put(tracks, {x, y}, to_sym(char)),
      [ to_cart(char, {x, y}) | carts ]
    }
  end

  def create_cell({char, x}, y, {tracks, carts}) do
    {
      Map.put(tracks, {x, y}, to_sym(char)),
      carts
    }
  end

  def to_sym(?\\), do: :backslash
  def to_sym(?/), do: :slash
  def to_sym(?-), do: :dash
  def to_sym(?|), do: :pipe
  def to_sym(?^), do: :pipe
  def to_sym(?v), do: :pipe
  def to_sym(?>), do: :dash
  def to_sym(?<), do: :dash
  def to_sym(?+), do: :plus

  def to_cart(char, pos) do
    %Cart{
      pos: pos,
      dir: to_dir(char)
    }
  end

  def to_dir(?>), do: :e
  def to_dir(?<), do: :w
  def to_dir(?^), do: :n
  def to_dir(?v), do: :s

end
