defmodule Drop do
  import :math, only: [sqrt: 1]

  def fall_velocity(:earth, distance) do
    sqrt(2 * 9.8 * distance)
  end

  def fall_velocity(:moon, distance) do
    sqrt(2 * 1.6 * distance)
  end

  def fall_velocity(:mars, distance) do
    sqrt(2 * 3.71 * distance)
  end
end
