defmodule Day3 do
  defp max_occurence_of_0_or_1(list) do
    count_zero = Enum.count(list, fn d -> d == "0" end)
    count_one = Enum.count(list, fn d -> d == "1" end)

    case count_zero > count_one do
      true ->
        "0"

      false ->
        "1"
    end
  end

  defp inverted_0_or_1(value) do
    case value do
      "0" -> "1"
      "1" -> "0"
    end
  end

  defp read_data do
    File.stream!(Path.join("data", "day3.txt"))
    |> Stream.flat_map(&String.split(&1, "\n", trim: true))
    |> Stream.map(&String.graphemes/1)
  end

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

    data =
      read_data()
      |> Stream.zip()
      |> Stream.map(&Tuple.to_list/1)

    gamma =
      data
      |> Stream.map(&max_occurence_of_0_or_1/1)
      |> Enum.reduce("", fn r, acc -> acc <> r end)
      |> String.to_integer(2)

    epsilon =
      data
      |> Stream.map(&inverted_0_or_1(max_occurence_of_0_or_1(&1)))
      |> Enum.reduce("", fn r, acc -> acc <> r end)
      |> String.to_integer(2)

    gamma * epsilon
  end

  defp get_oxygen_generator_rating(data, cpt) when length(data) > 1 do
    begin_with =
      data
      |> Stream.zip()
      |> Stream.map(&Tuple.to_list/1)
      |> Enum.at(cpt)
      |> max_occurence_of_0_or_1

    data = Enum.filter(data, fn c -> Enum.at(c, cpt) == begin_with end)
    get_oxygen_generator_rating(data, cpt + 1)
  end

  defp get_oxygen_generator_rating(data, _) when length(data) == 1 do
    Enum.at(data, 0)
  end

  defp get_co2_scrubber_rating(data, cpt) when length(data) > 1 do
    begin_with =
      data
      |> Stream.zip()
      |> Stream.map(&Tuple.to_list/1)
      |> Enum.at(cpt)
      |> max_occurence_of_0_or_1()
      |> inverted_0_or_1()

    data = Enum.filter(data, fn c -> Enum.at(c, cpt) == begin_with end)
    get_co2_scrubber_rating(data, cpt + 1)
  end

  defp get_co2_scrubber_rating(data, _) when length(data) == 1 do
    Enum.at(data, 0)
  end

  def binary_diagnostic_2 do
    original_data =
      read_data()
      |> Enum.map(fn x -> x end)

    oxygen_generator_rating =
      get_oxygen_generator_rating(original_data, 0)
      |> Enum.reduce("", fn r, acc -> acc <> r end)
      |> String.to_integer(2)

    co2_scrubber_rating =
      get_co2_scrubber_rating(original_data, 0)
      |> Enum.reduce("", fn r, acc -> acc <> r end)
      |> String.to_integer(2)

    oxygen_generator_rating * co2_scrubber_rating
  end
end
