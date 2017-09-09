defmodule Geom do
  @moduledoc """
  performs geometrical calculus
  """

  
  @doc """
  calcultaes the area of a rectangle based on it's width and height
  """

  def area(length \\ 1, width \\ 1) do
    length * width
  end
end
