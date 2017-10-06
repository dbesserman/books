defmodule Teeth do
  def pocket_depths do
    [[0], [2,2,1,2,2,1], [3,1,2,3,2,3],
     [3,1,3,2,1,2], [3,2,3,2,2,1], [2,3,1,2,1,1],
     [3,1,3,2,3,2], [3,3,2,1,3,1], [4,3,3,2,3,3],
     [3,1,1,3,2,2], [4,3,4,3,2,3], [2,3,1,3,2,2],
     [1,2,1,1,3,2], [1,2,2,3,2,3], [1,3,2,1,3,3], [0],
     [3,2,3,1,1,2], [2,2,1,1,3,2], [2,1,1,1,1,2],
     [3,3,2,1,1,3], [3,1,3,2,3,2], [3,3,1,2,3,3],
     [1,2,2,3,3,3], [2,2,3,2,3,3], [2,2,2,4,3,4],
     [3,4,3,3,3,4], [1,1,2,3,1,2], [2,2,3,2,1,3],
     [3,4,2,4,4,3], [3,3,2,1,2,3], [2,2,2,2,3,3],
     [3,2,3,2,3,2]]
  end

  def alert(list) do
    alert(list, 1, []) 
  end

  defp alert([], _tooth_nb, result) do
    Enum.reverse(result)
  end

  defp alert([h | t], tooth_nb, result) do
    cond do
      Stats.maximum(h) == 4 -> alert(t, tooth_nb + 1, [tooth_nb | result])
      true                  -> alert(t, tooth_nb + 1, result)
    end
  end
end
