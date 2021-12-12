defmodule SevenSegment do
  def part1 do
    inputs =
      File.stream!(Path.join("data", "day8.txt"))
      |> Enum.flat_map(&String.split(&1, [" | ", "\n"], trim: true))
      |> Enum.chunk_every(2)
      |> Enum.map(fn [input, output] ->
        {String.split(input, " ", trim: true), String.split(output, " ", trim: true)}
      end)
      |> Enum.map(fn {_input, output} ->
        Enum.count(output, fn o ->
          String.length(o) in [2, 4, 3, 7]
        end)
      end)
      |> Enum.sum()
  end
end
