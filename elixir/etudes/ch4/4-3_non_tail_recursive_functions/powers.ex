defmodule Powers do
  import Kernel, except: [raise: 2]

  @moduledoc """
  helps raise a number to a power  
  """

  @spec raise(number, number) :: number

  def raise(_, 0)
    1
  end

  def raise(x, 1)
    x
  end

  def raise(x, n) when n > 0 do
    x * raise(x, n-1) 
  end

  def raise(x, n) when n < 0 do
    1.0 / raise(x, -n)
  end
end
