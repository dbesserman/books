defmodule Cards do
  def shuffle(list) do
    :random.seed(:erlang.now())
    shuffle(list, [])
  end

  def shuffle([], acc) do
    acc
  end

  def shuffle(list, acc) do
    {leading, [h | t]} = Enum.split(list, :random.uniform(Enum.count(list)) - 1)
    shuffle(leading ++ t, [h | acc])
  end

  def make_deck(ranks, suits) do
    for rank <- ranks, suit <- suits, do: {rank, suit}
  end
end
