defmodule AOCFile do
  def read_and_split(file) do
    File.read!(file)
    |> String.split("\n")
    |> Enum.map(&String.split/1)
  end
end
