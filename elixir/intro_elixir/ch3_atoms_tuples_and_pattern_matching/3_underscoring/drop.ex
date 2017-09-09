defmodule Drop do
  def fall_velocity(_, distance) when distance >= 0 do
    # matches everything for pattern match but never binds
    :math.sqrt(2 * 9.8 * distance)
  end
end
