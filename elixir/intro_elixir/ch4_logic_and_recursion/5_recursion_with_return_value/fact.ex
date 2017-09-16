defmodule Fact do
  def factorial(n) when n > 1 do
    n * factorial(n-1)
  end

  def factorial(_) do
    1
  end
end
