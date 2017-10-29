defmodule Calculus do
  @doc """
  Calculates the approximation to the derivative of a function f
  and point x by using the mathematical definition of a derivative
  """
  @spec derivative(fun, number) :: number

  def derivative(f, x) do
    delta = 1.0e-10

    (f.(x + delta) - f.(x)) / delta
  end
end
