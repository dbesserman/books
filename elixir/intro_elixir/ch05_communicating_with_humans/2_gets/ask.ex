require IEx;

defmodule Drop do
  def fall_velocity({planemo, distance}) when distance >= 0 do
    fall_velocity(planemo, distance)
  end

  defp fall_velocity(:earth, distance) do
    :math.sqrt(2 * 9.8 * distance)
  end

  defp fall_velocity(:moon, distance) do
    :math.sqrt(2 * 1.6 * distance)
  end

  defp fall_velocity(:mars, distance) do
    :math.sqrt(2 * 3.71 * distance)
  end
end

defmodule Ask do
  def line() do
    planemo  = get_planemo()
    distance = get_distance()

    Drop.fall_velocity({planemo, distance})
  end

  def get_planemo() do
    IO.puts(
      """
      Which planemo are you on?
        1. Earth
        2. Moon
        3. Mars
      """
    )

    answer = IO.gets("Which? > ")
    value  = String.first(answer)

    char_to_planemo(value)
  end

  defp get_distance() do
    input = IO.gets("How for? (meters) > ")
    value = String.trim(input)

    String.to_integer(value)
  end

  defp char_to_planemo(char) do
    case char do
      "1" -> :earth
      "2" -> :moon
      "3" -> :mars
    end
  end
end
