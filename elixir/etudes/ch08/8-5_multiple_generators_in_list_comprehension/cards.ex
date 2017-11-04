defmodule Cards do
  def make_deck do
    suits = ["hearts", "spades", "diamonds", "clubs"]
    ranks = [2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K", "A"]

    for rank <- ranks, suit <- suits, do: { rank, suit }
  end
end
