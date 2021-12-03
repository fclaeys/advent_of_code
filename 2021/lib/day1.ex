defmodule Day1 do
  def sonar_sweep_1 do
    File.stream!(Path.join("data", "day1-1.txt"))
    |> Stream.flat_map(&String.split(&1, "\n", trim: true))
    |> Stream.map(&String.to_integer/1)
    |> Stream.chunk_every(2, 1, :discard)
    |> Enum.count(fn [left, right] -> left < right end)
  end

  def sonar_sweep_2 do
    File.stream!(Path.join("data", "day1-1.txt"))
    |> Stream.flat_map(&String.split(&1, "\n", trim: true))
    |> Stream.map(&String.to_integer/1)
    |> Stream.chunk_every(3, 1, :discard)
    |> Stream.chunk_every(2, 1, :discard)
    |> Enum.count(fn [[a, b, c], [d, e, f]] -> a + b + c < d + e + f end)
  end
end
