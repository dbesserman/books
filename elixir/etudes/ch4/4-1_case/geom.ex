defmodule Geom do
  @moduledoc """
  Geom gathers methods to calculate geometrical figure's areas
  """

  @doc """
  Calculates the area of a shape, given the shape and two of the dimensions
  """

  @spec area(atom, number, number) :: number

  def area(figure, a, b) when a >= 0 and b >= 0 do
    case figure do
      :rectangle -> a * b
      :triangle -> a * b / 2
      :ellipse -> :math.pi() * a * b
    end
  end
end
