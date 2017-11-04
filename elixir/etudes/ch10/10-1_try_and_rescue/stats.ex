defmodule Stats do
  def mean(list) do
    try do
      List.foldl(list, 0, &(&1 + &2)) / Enum.count(list)
    rescue
      error -> error
    end
  end

  def stdv(list) do
    try do
      n             = Enum.count(list)
      {sum, sum_sq} = List.foldl(list, {0,0}, fn(x, {acc, acc_sq}) -> {acc + x, acc_sq + x * x} end)

      :math.sqrt((n * sum_sq - sum * sum) / (n * (n - 1)))
    rescue
      error -> error
    end
  end

  def sum(list) do
    List.foldl(list, 0, &(&1 + &2))
  end

  def squares(list) do
    Enum.map(list, &(&1 * &1))
  end

  def range(list) do
    [minimum(list), maximum(list)]
  end

  def minimum(list) do
    try do
      [head | tail] = list
      minimum(tail, head)
    rescue
      error -> error
    end
  end

  defp minimum([], result) do
    result
  end

  defp minimum([head | tail], result) when result < head do
    minimum(tail, result)
  end

  defp minimum([head | tail], _result) do
    minimum(tail, head)
  end

  def maximum(list) do
    [head | tail] = list
    maximum(tail, head)
  end

  defp maximum([], result) do
    result
  end

  defp maximum([head | tail], result) when head < result do
    maximum(tail, result)
  end

  defp maximum([head | tail], _result) do
    maximum(tail, head)
  end
end
