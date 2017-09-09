defmodule Geom do
  def area({shape,a,b}) do
    area(shape, a, b)
  end

  defp area(:rectangle, length, width) when a >= 0 and b >= 0 do
    length * width
  end

  defp area(:triangle, base, height) when a >= 0 and b >= 0 do
    base * height / 2
  end

  defp area(:ellipse, major_radius, minor_radius) when a >= 0 and b >= 0 do
    :math.pi() * major_radius * minor_radius
  end

  defp area(_, _, _) do
    0
  end
end
