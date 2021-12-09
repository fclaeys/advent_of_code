defmodule HydrothermalVents do
  def part1 do
    # input = """
    # 0,9 -> 5,9
    # 8,0 -> 0,8
    # 9,4 -> 3,4
    # 2,2 -> 2,1
    # 7,0 -> 7,4
    # 6,4 -> 2,0
    # 0,9 -> 2,9
    # 3,4 -> 1,4
    # 0,0 -> 8,8
    # 5,5 -> 8,2
    # """

    # input
    # |> String.split("\n", trim: true)
    File.stream!(Path.join("data", "day5.txt"))
    |> Enum.flat_map(&String.split(&1, "\n", trim: true))
    |> Enum.map(&String.split(&1, [",", " -> "], trim: true))
    |> Enum.map(fn coord ->
      coord
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.reduce(%{}, fn
      [x, y1, x, y2], grid ->
        Enum.reduce(y1..y2, grid, fn y, grid ->
          Map.update(grid, {x, y}, 1, &(&1 + 1))
        end)

      [x1, y, x2, y], grid ->
        Enum.reduce(x1..x2, grid, fn x, grid ->
          Map.update(grid, {x, y}, 1, &(&1 + 1))
        end)

      _line, grid ->
        grid
    end)
    |> Enum.count(fn {_, v} -> v > 1 end)
  end

  def part2 do
    # input = """
    # 0,9 -> 5,9
    # 8,0 -> 0,8
    # 9,4 -> 3,4
    # 2,2 -> 2,1
    # 7,0 -> 7,4
    # 6,4 -> 2,0
    # 0,9 -> 2,9
    # 3,4 -> 1,4
    # 0,0 -> 8,8
    # 5,5 -> 8,2
    # """

    # input
    # |> String.split("\n", trim: true)
    File.stream!(Path.join("data", "day5.txt"))
    |> Enum.flat_map(&String.split(&1, "\n", trim: true))
    |> Enum.map(&String.split(&1, [",", " -> "], trim: true))
    |> Enum.map(fn coord ->
      coord
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.reduce(%{}, fn
      [x, y1, x, y2], grid ->
        Enum.reduce(y1..y2, grid, fn y, grid ->
          Map.update(grid, {x, y}, 1, &(&1 + 1))
        end)

      [x1, y, x2, y], grid ->
        Enum.reduce(x1..x2, grid, fn x, grid ->
          Map.update(grid, {x, y}, 1, &(&1 + 1))
        end)

      [x1, y1, x2, y2], grid ->
        Enum.reduce(Enum.zip(x1..x2, y1..y2), grid, fn point, grid ->
          Map.update(grid, point, 1, &(&1 + 1))
        end)
    end)
    |> Enum.count(fn {_, v} -> v > 1 end)
  end
end
