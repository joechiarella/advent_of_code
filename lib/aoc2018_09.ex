defmodule AOC2018_09 do
  @moduledoc """
  This solution uses a Zipper to represent the circle.  I got the idea from
  https://ferd.ca/yet-another-article-on-zippers.html

  Think of the zipper as two linked lists, pointed in opposite directions.  The heads of each
  one represent adjacent items.  In my code, I call them `left` and `right` with the
  "current marble" being the head of the right list.  To rotate to right, you simply pop the head
  off the right list and add it to the head of the left list.  In Elixir, these operations work in
  constant time.  If the list on the right is empty, you simply move the left list to the right,
  reversing it in the process.
  """

  defmodule State do
    @moduledoc """
    Struct for storing the current state of the circle, scoreboard, and number of players
    """
    defstruct circle: {[], [0]}, scores: %{}, num: 0
  end

  def solveA(players, last_marble) do
    state = place_marble(%State{num: players}, 1, last_marble)

    state.scores
    |> Map.values
    |> Enum.max
  end

  # last marble has been placed, game is over
  def place_marble(state, current, last) when current > last do
    state
  end

  # when next marble is a multiple of 23, move 7 to the left, remove it
  # Add the value of the removed marble and the next marble to that players score
  def place_marble(state, marble, last) when rem(marble, 23) == 0 do
    circle = move_left(state.circle, 7)

    # pop the current marble
    current = get_current(circle)
    circle = remove(circle)

    # figure out the player and update the scoreboard
    player = rem(marble, state.num)
    scores = Map.update(state.scores, player, current + marble, &(&1 + current + marble))

    # update state with new scores and new circle
    %State{state |
      scores: scores,
      circle: circle
    }
    |> place_marble(marble + 1, last)
  end

  # normal turn, rotate the circle and push the new marble
  def place_marble(state, marble, last) do
    %State{state |
      circle: state.circle
        |> move_right(2)
        |> add(marble)
    }
    |> place_marble(marble + 1, last)
  end

  # move left by 0? easy
  def move_left(circle, 0), do: circle

  # if left list is empty, reverse the right list and set it as the left
  def move_left({[], right}, steps) do
    [current | reversed] = Enum.reverse(right)

    # move the head of the left list over to the right.  The right list is never allowed
    # to be empty as its head is always the current marble
    move_left({reversed, [current]}, steps - 1)
  end

  # pop the head off the left list and push it onto the right
  def move_left({[prev | left], right}, steps) do
    move_left({left, [prev | right]}, steps - 1)
  end

  # move right by 0? easy
  def move_right(circle, 0), do: circle

  # if right list is empty, reverse the left list and set it as the right
  def move_right({left, [current]}, steps) do
    move_right({[], Enum.reverse([current | left])}, steps - 1)
  end

  # pop the head off the right list and push it into the right
  def move_right({left, [current | right]}, steps) do
    move_right({[current | left], right}, steps - 1)
  end

  # adds the new marble to the left of the current marble
  def add({left, right}, marble) do
    {left, [marble | right]}
  end

  # removes the current marble
  def remove({left, [_current | right]}) do
    {left, right}
  end

  # returns the current marble
  def get_current({_, [current | _]}), do: current

end
