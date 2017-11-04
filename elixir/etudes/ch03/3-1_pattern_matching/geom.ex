defmodule Geom do
  def area(:rectangle, length, width) do
    length * width
  end

  def area(:triangle, base, height) do
    base * height / 2
  end

  def area(:ellipse, major_radius, minor_radius) do
    :math.pi() * major_radius * minor_radius
  end
end
