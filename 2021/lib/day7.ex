defmodule TreacheryOfWhales do
  def part1 do
    input =
      File.stream!(Path.join("data", "day7.txt"))
      |> Enum.flat_map(&String.split(&1, ",", trim: true))
      |> Enum.map(&String.to_integer/1)

    max = input |> Enum.max()

    0..max
    |> Enum.reduce(%{pos: nil, dst: nil}, fn pos, acc ->
      curDst =
        Enum.reduce(input, 0, fn cur, dst ->
          dst + abs(pos - cur)
        end)

      if curDst < acc.dst do
        %{pos: pos, dst: curDst}
      else
        acc
      end
    end)
  end

  def part2 do
    input =
      File.stream!(Path.join("data", "day7.txt"))
      |> Enum.flat_map(&String.split(&1, ",", trim: true))
      |> Enum.map(&String.to_integer/1)

    max = input |> Enum.max()

    0..max
    |> Enum.reduce(%{pos: nil, dst: nil}, fn pos, acc ->
      curDst =
        Enum.reduce(input, 0, fn cur, dst ->
          dst +
            Enum.reduce(0..abs(pos - cur), 0, fn x, accDst ->
              accDst + x
            end)
        end)

      if curDst < acc.dst do
        %{pos: pos, dst: curDst}
      else
        acc
      end
    end)
  end
end
