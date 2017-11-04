defmodule Powers do
  import Kernel, except: [raise: 2]

  @moduledoc """
  helps raise a number to a power
  using an accumulator
  """

  @spec raise(number, number) :: number

  def raise(_, 0) do
    1
  end

  def raise(x, 1) do
    x
  end

  def raise(x, n) when n > 0 do
    raise(x, n, 1)
  end

  def raise(x, n) when n < 0 do
    1.0 / raise(x, -n)
  end

  @spec raise(number, number, number) :: number

  defp raise(_, 0, result) do
    result
  end

  defp raise(x, n, result) do
    raise(x, n - 1, result * x)
  end
end
