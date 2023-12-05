defmodule Day2 do
  def solve(path, validator) do
    {:ok, input} = File.read(path)
    res = input
      |> String.split("\n")
      |> collect_input()
      |> Enum.filter(&Day2.Game.is_valid(&1, validator))
      |> Enum.reduce(0, fn i, acc -> i.idx + acc end)
    IO.puts(res)
  end

  def solve2(path) do
    {:ok, input} = File.read(path)
    res = input
      |> String.split("\n")
      |> collect_input()
      |> Enum.map(&Day2.Game.get_fewest_cubes/1)
      |> Enum.map(&Day2.Game.get_power_of_set/1)
      |> Enum.sum()
    IO.puts(res)
  end


  defp collect_input([game | rest]) do
    [Day2.Game.from_input(game) | collect_input(rest)]
  end

  defp collect_input([]) do
    []
  end

end

defmodule Day2.Game do
  defstruct [:idx, :rounds]

  def from_input(input) do
    {idx, _} = input
     |> String.split(":")
     |> List.first()
     |> String.split(" ")
     |> List.last()
     |> Integer.parse()

    rounds = input
      |> String.split(":")
      |> tl
      |> List.first()
      |> String.split(";")
      |> collect_rounds()

    %Day2.Game{idx: idx, rounds: rounds}
  end

  def is_valid(game, validator) do
    Enum.all?(game.rounds, &Day2.Round.check_validity(&1, validator))
  end

  def get_valid(game, validator) do
    Enum.filter(game.rounds, &Day2.Round.check_validity(&1, validator))
  end

  def get_fewest_cubes(game) do
    Enum.reduce(game.rounds, %{"red" => 0, "green" => 0, "blue" => 0}, fn round, acc ->
      Enum.reduce(round.drawings, acc, fn drawing, acc_inner ->
        Map.update!(acc_inner, drawing.category, &max(drawing.count, &1))
      end)
    end)
  end

  def get_power_of_set(%{"red" => r, "green" => g, "blue" => b}) do
    r * g * b
  end

  defp collect_rounds([round | rest]) do
    [ Day2.Round.from_input(round) | collect_rounds(rest)]
  end

  defp collect_rounds([]) do
    []
  end
end

defmodule Day2.Round do
  defstruct drawings: []
  def from_input(input) do
    drawings = input
      |> String.split(",")
      |> collect_input()
    %Day2.Round{drawings: drawings}
  end

  def check_validity(round, validator) do
    Enum.all?(round.drawings, fn drawing -> Day2.Drawing.check_validity(drawing, validator) end)
  end

  defp collect_input([head | tail]) do
    [ Day2.Drawing.from_input(head) | collect_input(tail) ]
  end

  defp collect_input([]) do
    []
  end

end

defmodule Day2.Drawing do
  defstruct category: "", count: 0
  def from_input(input) do
    [count, cat] = input
      |> String.trim()
      |> String.split(" ")

    {count, _} = Integer.parse(count)
    %Day2.Drawing{category: cat, count: count}
  end

  def check_validity(%Day2.Drawing{category: cat, count: count}, validator) do
    res = count <= validator[cat]
    res
  end
end
