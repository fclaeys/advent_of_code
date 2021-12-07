defmodule BingoSubsystem do
  defmodule Board do
    empty_board = Tuple.duplicate(Tuple.duplicate(false, 5), 5)
    @enforce_keys [:numbers]
    defstruct numbers: %{}, grid: empty_board

    def new(numbers) when is_map(numbers) do
      %Board{numbers: numbers}
    end

    def mark(%Board{numbers: numbers} = board, number) do
      case numbers do
        %{^number => {row, col}} ->
          put_in(board, [Access.key!(:grid), Access.elem(row), Access.elem(col)], true)

        %{} ->
          board
      end
    end

    defp row_won?(grid) do
      Enum.any?(0..4, fn row ->
        elem(grid, row) == {true, true, true, true, true}
      end)
    end

    defp col_won(grid) do
      Enum.any?(0..4, fn col ->
        Enum.all?(0..4, fn row ->
          grid
          |> elem(row)
          |> elem(col)
        end)
      end)
    end

    def won?(%Board{grid: grid}) do
      row_won?(grid) or col_won(grid)
    end

    def sum_unmarked(%Board{numbers: numbers, grid: grid}) do
      Enum.sum(
        for {number, {row, col}} <- numbers,
            grid |> elem(row) |> elem(col) == false,
            do: number
      )
    end
  end

  def bingo_subsystem_part1() do
    [numbers | grids] =
      File.stream!(Path.join("data", "day4.txt"))
      |> Enum.flat_map(&String.split(&1, "\n", trim: true))

    boards =
      grids
      |> Enum.chunk_every(5)
      |> Enum.map(fn rows ->
        Board.new(
          for {line, row} <- Enum.with_index(rows, 0),
              {number, col} <- Enum.with_index(String.split(line), 0),
              into: %{} do
            {String.to_integer(number), {row, col}}
          end
        )
      end)

    numbers =
      numbers
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    {number, board = %Board{}} =
      Enum.reduce_while(numbers, boards, fn number, boards ->
        boards = Enum.map(boards, &Board.mark(&1, number))

        if board = Enum.find(boards, &Board.won?/1) do
          {:halt, {number, board}}
        else
          {:cont, boards}
        end
      end)

    number * Board.sum_unmarked(board)
  end
end
