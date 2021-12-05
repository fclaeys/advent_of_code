defmodule Day3 do
  def binary_diagnostic_1 do
    # input = """
    # 00100
    # 11110
    # 10110
    # 10111
    # 10101
    # 01111
    # 00111
    # 11100
    # 10000
    # 11001
    # 00010
    # 01010
    # """

    # String.split(input, "\n", trim: true)
    gamma =
      File.stream!(Path.join("data", "day3.txt"))
      |> Stream.flat_map(&String.split(&1, "\n", trim: true))
      |> Stream.map(&String.graphemes/1)
      # |> Stream.map(fn b -> Integer.parse(b, 2) end)
      # |> Stream.map(fn {value, ""} -> value end)
      |> Stream.zip()
      |> Stream.map(&Tuple.to_list/1)
      |> Stream.map(fn l ->
        count_zero = Enum.count(l, fn d -> d == "0" end)
        count_one = Enum.count(l, fn d -> d == "1" end)

        case count_zero > count_one do
          true ->
            "0"

          false ->
            "1"
        end
      end)
      # |> Enum.group_by(fn k -> k end)
      |> Enum.reduce("", fn r, acc -> acc <> r end)
      |> String.to_integer(2)

    epsilon =
      File.stream!(Path.join("data", "day3.txt"))
      |> Stream.flat_map(&String.split(&1, "\n", trim: true))
      |> Stream.map(&String.graphemes/1)
      # |> Stream.map(fn b -> Integer.parse(b, 2) end)
      # |> Stream.map(fn {value, ""} -> value end)
      |> Stream.zip()
      |> Stream.map(&Tuple.to_list/1)
      |> Stream.map(fn l ->
        count_zero = Enum.count(l, fn d -> d == "0" end)
        count_one = Enum.count(l, fn d -> d == "1" end)

        case count_zero > count_one do
          true ->
            "1"

          false ->
            "0"
        end
      end)
      # |> Enum.group_by(fn k -> k end)
      |> Enum.reduce("", fn r, acc -> acc <> r end)
      |> String.to_integer(2)

    gamma * epsilon
  end
end
