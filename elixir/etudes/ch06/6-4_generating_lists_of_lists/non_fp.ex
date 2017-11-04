defmodule NonFP do
  def generate_pockets(teeth_list, probability) do
    :random.seed(:erlang.now)
    generate_pockets(teeth_list, probability, [])
  end

  def generate_pockets([], _probability, result) do
    Enum.reverse result
  end

  def generate_pockets([?F|t], probability, result) do
    generate_pockets(t, probability,[[0] | result])
  end

  def generate_pockets([?T|t], probability, result) do
    tooth = generate_tooth(probability)

    generate_pockets(t, probability,[tooth | result])
  end

  def generate_tooth(probability) do
    cond do
      :random.uniform < probability -> base_depth = 2
      true                          -> base_depth = 3
    end

    generate_tooth(base_depth, 6, [])
  end

  def generate_tooth(_base_depth, 0, list) do
    list 
  end

  def generate_tooth(base_depth, nb_of_items, list) do
    depth = base_depth + :random.uniform(3) - 2
    
    generate_tooth(base_depth, nb_of_items - 1, [depth | list])
  end
end
