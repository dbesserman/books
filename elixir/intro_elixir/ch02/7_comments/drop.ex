defmodule Drop do
  @moduledoc """
  Functions  calculating velocities achieved by objects dropt in a vacuum.
  """


  @doc """
  Calculates the velocity of an object falling on earth
  as if it were in a vacuum (no air resistence). The distance is
  the height from which the object falls, specified in meters,
  and the function returns a velocity in meters per second
  """

  @spec fall_velocity(number()) :: number()
  def fall_velocity(distance, gravity \\ 9.8) do
    :math.sqrt(2 * gravity * distance)
  end
end
