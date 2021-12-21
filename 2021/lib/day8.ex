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

  def part2 do
    inputs =
      File.stream!(Path.join("data", "day8.txt"))
      |> Enum.flat_map(&String.split(&1, [" | ", "\n"], trim: true))
      |> Enum.chunk_every(2)
      |> Enum.map(fn [input, output] ->
        {String.split(input, " ", trim: true), String.split(output, " ", trim: true)}
      end)

    parsed =
      inputs
      |> Enum.map(fn {input, output} ->
        {
          input |> Enum.group_by(&byte_size/1, &String.to_charlist/1),
          output |> Enum.map(&String.to_charlist/1)
        }
      end)

    parsed
    |> Enum.map(fn {input, outpout} ->
      %{
        2 => [un],
        3 => [sept],
        4 => [quatre],
        5 => deux_trois_cinq,
        6 => zero_six_neuf,
        7 => [huit]
      } = input

      [neuf] = Enum.filter(zero_six_neuf, &match?([], quatre -- &1))
      [six] = Enum.filter(zero_six_neuf, &match?([_], sept -- &1))
      [zero] = zero_six_neuf -- [six, neuf]

      [trois] = Enum.filter(deux_trois_cinq, &match?([], sept -- &1))
      [cinq] = Enum.filter(deux_trois_cinq, &match?([_], six -- &1))
      [deux] = deux_trois_cinq -- [trois, cinq]

      numbers = %{
        Enum.sort(zero) => 0,
        Enum.sort(un) => 1,
        Enum.sort(deux) => 2,
        Enum.sort(trois) => 3,
        Enum.sort(quatre) => 4,
        Enum.sort(cinq) => 5,
        Enum.sort(six) => 6,
        Enum.sort(sept) => 7,
        Enum.sort(huit) => 8,
        Enum.sort(neuf) => 9
      }

      [o1, o2, o3, o4] = outpout

      numbers[Enum.sort(o1)] * 1000 + numbers[Enum.sort(o2)] * 100 + numbers[Enum.sort(o3)] * 10 +
        numbers[Enum.sort(o4)]
    end)
    |> Enum.sum()
  end
end
