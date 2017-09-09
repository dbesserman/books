defmodule Drop do
  import :math, only: [sqrt: 1]

  def fall_velocity(distance, gravity \\ 9.8) do
    sqrt(2 * gravity * distance)
  end
end
