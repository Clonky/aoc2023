defmodule Day1Test do
  use ExUnit.Case

  test "get_lines correctly extracts numbers" do
    assert Day1.get_numbers("a1b2c3") == [1, 2, 3]
  end

  test "get final number per line" do
    list_of_numbers = Day1.get_numbers("a1b2c3")
    final_number = Day1.get_final_number_per_line(list_of_numbers)
    assert final_number == 13
  end

end
