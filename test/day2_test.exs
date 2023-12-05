defmodule Day2Test do
  use ExUnit.Case

  test "Correctly assemble drawing" do
    input = "3 Red"
    assert Day2.Drawing.from_input(input) == %Day2.Drawing{category: "Red", count: 3}
  end

  test "Correctly assemble round from drawings" do
    input = "3 red, 5 blue, 8 green"
    assert Day2.Round.from_input(input) == %Day2.Round{drawings: [%Day2.Drawing{category: "red", count: 3}, %Day2.Drawing{category: "blue", count: 5}, %Day2.Drawing{category: "green", count: 8}]}
  end

  test "Correctly assemble game" do
    input = "Game 1: 3 red, 5 blue, 8 green; 2 red, 6 blue"
    assert Day2.Game.from_input(input) == %Day2.Game{idx: 1, rounds: [
      %Day2.Round{drawings: [%Day2.Drawing{category: "red", count: 3}, %Day2.Drawing{category: "blue", count: 5}, %Day2.Drawing{category: "green", count: 8}]},
      %Day2.Round{drawings: [%Day2.Drawing{category: "red", count: 2}, %Day2.Drawing{category: "blue", count: 6}]}]}
  end

  test "Check validity of drawing" do
    input = Day2.Drawing.from_input("3 red")
    assert Day2.Drawing.check_validity(input, %{"red"=> 4}) == true
    assert Day2.Drawing.check_validity(input, %{"red"=> 2}) == false
  end

  test "Check validity of round" do
    input = "3 red, 5 blue, 8 green"
    round = Day2.Round.from_input(input)
    assert Day2.Round.check_validity(round, %{"red"=> 3, "blue"=> 5, "green"=> 9})
    assert Day2.Round.check_validity(round, %{"red"=> 2, "blue"=> 5, "green"=> 9}) == false
  end
end
