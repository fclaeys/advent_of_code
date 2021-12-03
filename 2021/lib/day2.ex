defmodule Day2 do
  def dive_1 do
    File.stream!(Path.join("data", "day2.txt"))
    |> Stream.flat_map(&String.split(&1, "\n", trim: true))
    |> Enum.map(fn
      "forward " <> value ->
        {:forward, String.to_integer(value)}

      "down " <> value ->
        {:down, String.to_integer(value)}

      "up " <> value ->
        {:up, String.to_integer(value)}
    end)
    |> Enum.reduce({_position = 0, _depth = 0}, fn
      {:forward, value}, {position, depth} -> {position + value, depth}
      {:down, value}, {position, depth} -> {position, depth + value}
      {:up, value}, {position, depth} -> {position, depth - value}
    end)
    |> then(fn {position, depth} -> position * depth end)
  end

  def dive_2 do
    File.stream!(Path.join("data", "day2.txt"))
    |> Stream.flat_map(&String.split(&1, "\n", trim: true))
    |> Enum.map(fn
      "forward " <> value ->
        {:forward, String.to_integer(value)}

      "down " <> value ->
        {:down, String.to_integer(value)}

      "up " <> value ->
        {:up, String.to_integer(value)}
    end)
    |> Enum.reduce({_position = 0, _depth = 0, _aim = 0}, fn
      {:forward, value}, {position, depth, aim} -> {position + value, depth + aim * value, aim}
      {:down, value}, {position, depth, aim} -> {position, depth, aim + value}
      {:up, value}, {position, depth, aim} -> {position, depth, aim - value}
    end)
    |> then(fn {position, depth, _} -> position * depth end)
  end
end
