defmodule Lanternfish do
  defp lantern_recur(fishes) do
    lantern_recur(fishes, [])
  end

  defp lantern_recur([0 | fishes], children) do
    [6 | lantern_recur(fishes, [8 | children])]
  end

  defp lantern_recur([fish | fishes], children) do
    [fish - 1 | lantern_recur(fishes, children)]
  end

  defp lantern_recur([], children) do
    Enum.reverse(children)
  end

  def part1 do
    # input = "3,4,3,1,2"

    fishes =
      File.stream!(Path.join("data", "day6.txt"))
      |> Enum.flat_map(&String.split(&1, ",", trim: true))
      |> Enum.map(&String.to_integer/1)

    1..80
    |> Enum.reduce(fishes, fn _, fishes -> lantern_recur(fishes) end)
    |> length()
  end

  defp lantern_amount_shift({nb_0, nb_1, nb_2, nb_3, nb_4, nb_5, nb_6, nb_7, nb_8}) do
    {nb_1, nb_2, nb_3, nb_4, nb_5, nb_6, nb_7 + nb_0, nb_8, nb_0}
  end

  def part2 do
    # input = "3,4,3,1,2"

    # File.stream!(Path.join("data", "day6.txt"))
    fishes =
      File.stream!(Path.join("data", "day6.txt"))
      |> Enum.flat_map(&String.split(&1, ",", trim: true))
      |> Enum.map(&String.to_integer/1)

    freq = Enum.frequencies(fishes)
    nb = Enum.map(0..8, fn i -> freq[i] || 0 end) |> List.to_tuple()

    1..256
    |> Enum.reduce(nb, fn _, nb -> lantern_amount_shift(nb) end)
    |> Tuple.sum()
  end
end
