  defmodule AOC2017_3a do
  def solve(value) do
    ring = get_ring(value)
    distance = get_lateral_distance(value, ring)
    ring + distance
  end

  def get_ring(value) do
    Kernel.trunc(Float.ceil((:math.sqrt(value) - 1) / 2))
  end

  def get_lateral_distance(_, 0), do: 0

  def get_lateral_distance(value, ring) do
    size = get_size_for_ring(ring)
    inner_size = size - 2

    seq = value - (inner_size * inner_size)
    side_length = size - 1
    seq = rem(seq, side_length)

    mid = div(side_length, 2)
    abs(mid - seq)
  end

  def get_size_for_ring(ring) do
    ring * 2 + 1
  end
end
