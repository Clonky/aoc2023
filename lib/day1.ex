defmodule Day1 do

  def get_numbers(line) do get_numbers(line, []) end

  def get_numbers("", acc) do Enum.reverse(acc) end

  def get_numbers("one" <> rest, acc) do get_numbers("ne" <> rest, [1 | acc]) end
  def get_numbers("two" <> rest, acc) do get_numbers("wo" <> rest, [2 | acc]) end
  def get_numbers("three" <> rest, acc) do get_numbers("hree" <> rest, [3 | acc]) end
  def get_numbers("four" <> rest, acc) do get_numbers("our" <> rest, [4 | acc]) end
  def get_numbers("five" <> rest, acc) do get_numbers("ive" <> rest, [5 | acc]) end
  def get_numbers("six" <> rest, acc) do get_numbers("ix" <> rest, [6 | acc]) end
  def get_numbers("seven" <> rest, acc) do get_numbers("even" <> rest, [7 | acc]) end
  def get_numbers("eight" <> rest, acc) do get_numbers("ight" <> rest, [8 | acc]) end
  def get_numbers("nine" <> rest, acc) do get_numbers("ine" <> rest, [9 | acc]) end

  def get_numbers(line, acc) do
    [head | tail] = String.graphemes(line)
    rest = Enum.join(tail)
    case Integer.parse(head) do
      {num, _} -> get_numbers(rest, [num | acc])
      :error -> get_numbers(rest, acc)
    end
  end

  def get_final_number_per_line(list_of_numbers) do
    first = List.first(list_of_numbers)
    last = List.last(list_of_numbers)
    {num, _} = Integer.parse(Integer.to_string(first) <> Integer.to_string(last))
    num
  end

  def solve(input) do
    {:ok, str} = File.read(input)
    lines = String.split(str, "\n")
    result = Enum.reduce(lines, 0, fn line, acc -> acc + get_final_number_per_line(get_numbers(line)) end)
    IO.puts(result)
  end
end
