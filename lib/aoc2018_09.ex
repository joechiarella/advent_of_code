defmodule AOC2018_09 do

  defmodule State do
    defstruct circle: {[], [0]}, scores: %{}, num: 0
  end

  def solveA(players, last_marble) do
    state = place_marble(%State{num: players}, 1, last_marble)

    state.scores
    |> Map.values
    |> Enum.max
  end

  def place_marble(state, current, last) when current > last do
    state
  end

  def place_marble(state, marble, last) when rem(marble, 23) == 0 do
    circle = move_left(state.circle, 7)

    current = get_current(circle)
    circle = remove(circle)

    player = rem(marble, state.num)
    scores = Map.update(state.scores, player, current + marble, &(&1 + current + marble))

    %State{state |
      scores: scores,
      circle: circle
    }
    |> place_marble(marble + 1, last)
  end

  def place_marble(state, marble, last) do
    %State{state |
      circle: state.circle
        |> move_right(2)
        |> add(marble)
    }
    |> place_marble(marble + 1, last)
  end

  def move_left(circle, 0), do: circle

  def move_left({[], right}, steps) do
    [current | reversed] = Enum.reverse(right)

    move_left({reversed, [current]}, steps - 1)
  end

  def move_left({[prev | left], right}, steps) do
    move_left({left, [prev | right]}, steps - 1)
  end

  def move_right(circle, 0), do: circle

  def move_right({left, [current]}, steps) do
    move_right({[], Enum.reverse([current | left])}, steps - 1)
  end

  def move_right({left, [current | right]}, steps) do
    move_right({[current | left], right}, steps - 1)
  end

  def add({left, right}, marble) do
    {left, [marble | right]}
  end

  def remove({left, [_current | right]}) do
    {left, right}
  end

  def get_current({_, [current | _]}), do: current

end
