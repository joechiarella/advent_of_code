defmodule AOC2018_3A do

  defmodule Claim do
    defstruct id: 0, x: 0, y: 0, w: 0, h: 0


    def parse(input) do
      # #1 @ 1,3: 4x4
      map = Regex.named_captures(~r/#(?<id>\d+) @ (?<x>\d+),(?<y>\d+): (?<w>\d+)x(?<h>\d+)/, input)
      %Claim{
        id: String.to_integer(map["id"]),
        x: String.to_integer(map["x"]),
        y: String.to_integer(map["y"]),
        w: String.to_integer(map["w"]),
        h: String.to_integer(map["h"])
      }
    end

    def contains(claim, x, y) do
      x >= claim.x and y >= claim.y and
        x < claim.x + claim.w and y < claim.y + claim.h
    end

    def intersects(claim1, claim2) when claim1 == claim2, do: false

    def intersects(claim1, claim2) do
      claim1.x < claim2.x + claim2.w and
      claim1.x + claim1.w > claim2.x and
      claim1.y < claim2.y + claim2.h and
      claim1.y + claim1.h > claim2.y
    end
  end

  def solve(input) do
    claims = parse_claims(input)
    max_x = 1000
    max_y = 1000

    for x <- 0..max_x, y <- 0..max_y,
      number_of_overlaps(claims, x, y) > 1
    do
      {x, y}
    end
    |> Enum.count
  end


  def number_of_overlaps(claims, x, y) do
    claims
    |> Stream.filter(&(Claim.contains(&1, x, y)))
    |> Enum.take(2)
    |> Enum.count
  end

  def get_max_dimension(claims, fun) do
    claims
    |> Enum.map(fun)
    |> Enum.max
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
