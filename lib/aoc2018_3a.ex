defmodule AOC2018_3A do

  defmodule Claim do
    defstruct id: 0, xmin: 0, ymin: 0, xmax: 0, ymax: 0

    def parse(input) do
      # #1 @ 1,3: 4x4
      map = Regex.named_captures(~r/#(?<id>\d+) @ (?<x>\d+),(?<y>\d+): (?<w>\d+)x(?<h>\d+)/, input)
      x = String.to_integer(map["x"])
      y = String.to_integer(map["y"])
      w = String.to_integer(map["w"])
      h = String.to_integer(map["h"])
      %Claim{
        id: String.to_integer(map["id"]),
        xmin: x,
        ymin: y,
        xmax: x + w,
        ymax: y + h
      }
    end

    def contains(claim, x, y) do
      x >= claim.xmin and y >= claim.ymin and
        x < claim.xmax and y < claim.ymax
    end

    def intersects(claim1, claim2) when claim1 == claim2, do: false

    def intersects(claim1, claim2) do
      claim1.xmin < claim2.xmax and
      claim1.xmax > claim2.xmin and
      claim1.ymin < claim2.ymax and
      claim1.ymax > claim2.ymin
    end

    def iterate(claim) do
      for x <- claim.xmin..claim.xmax - 1,
        y <- claim.ymin..claim.ymax - 1 do
        {x, y}
      end
    end
  end

  def solve(input) do
    input
    |> parse_claims
    |> Enum.flat_map(&Claim.iterate/1)
    |> Enum.sort
    |> Enum.chunk_by(&(&1))
    |> Enum.map(&Enum.count/1)
    |> Enum.filter(&(&1 > 1))
    |> Enum.count
  end

  def parse_claims(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&(String.length(&1) > 0))
    |> Enum.map(&Claim.parse/1)
  end

  def solveB(input) do
    claims = parse_claims(input)
    find_non_intersecting(claims)
  end

  def find_non_intersecting(claims) do
    for claim1 <- claims,
      Enum.all?(claims, fn claim2 -> !Claim.intersects(claim1, claim2) end) do
        claim1.id
    end
  end



end
