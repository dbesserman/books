defmodule Game do
  def start() do
    ranks          = [2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K", "A"]
    suits          = ["hearts", "spades", "diamonds", "clubs"]
    deck           = Cards.shuffle(ranks, suits) 
    {hand1, hand2} = Enum.split(deck, trunc(Enum.count(deck) / 2))
    player1        = spawn(Player, :start, [hand1])
    player2        = spawn(Player, :start, [hand2])

    play([player1, player2], :pre_battle, [], [], 0, [])
  end

  def play(players, state, cards1, cards2, n_received, pile) do
    [player1, player2] = players
    case state do
      :pre_battle ->
        IO.puts("")
        case pile do
          [] ->
            IO.puts("Requesting 1 card from each player")
            request_cards(players, 1)
          _  ->
            IO.puts("Requesting 3 card from each player")
            request_cards(players, 3)
        end
        play(players, :await_battle, cards1, cards2, n_received, pile]
      :await_battle when n_received == 2 ->
        play(players, :check_cards, cards1, cards2, 0, pile]
      :await_battle ->
        receive do
          {:take, new_cards, from} ->
            IO.puts "Got #{inspect(new_cards} from #{inspect(from)}"
            cond do
              from == player1 -> play(players, state, new_cards, cards2, n_received + 1, pile)
              from == player2 -> play(players, state, cards1, new_cards, n_received + 1, pile)
            end
        end
      :check_cards ->
        cond do
          cards1 == [] and cards2 == [] ->
            IO.puts "Draw"
            endgame(players)
          card1 == [] ->
            IO.puts "Player 2 wins"
            endgame(players)
          cards2 == [] ->
            IO.puts "Player 1 wins"
            endgame(players)
          true ->
            new_pile = evaluate(players, cards1, cards2, pile)
            play(players, :pre_battle, [], [], 0, new_pile)
        end
    end
  end

  defp evaluate(players, cards1, cards2, pile) do
    [player1, player2] = players
    v1 = card_value(hd(card1))
    v2 = card_value(hd(card2))
    IO.puts "Value of card 1 is #{v1}; value of card 2 is #{v2}"
    new_pile = Enum.concat([pile, cards1, cards2])
    IO.puts "Card pile is now #{inspect(new_pile)}"
    cond do
      v1 == v2 ->
        IO.puts "Equal values; going to war."
        new_pile
      v1 > v2 ->
        IO.puts "Telling player 1 to pick up the cards"
        send(player1, {:pick_up, new_pile, self()})
        wait_for_pickup()
        []
      v2 > v1 ->
        IO.puts "Telling player 2 to pick up the cards"
        send(player2, {:pick_up, new_pile, self()})
        wait_for_pickup()
        []
    end
  end

  def wait_for_pickup() do
    receive do
      {:got_cards, player} ->
        IO.puts "Player #{inspect(player)} picked up cards."
        player
    end
  end

  defp request_cards([p1, p2], n) do
    send(p1, {:give, n, self()})
    send(p2, {:give, n, self()})
  end

  defp endgame(players) do
    Enum.each(players, fn(x) -> send(x, :game_over) end)
  end

  defp card_value({rank, _suit}) do
    case rank do
      "A" -> 14
      "K" -> 13
      "Q" -> 12
      "J" -> 11
      _   -> rank
    end
  end
end
