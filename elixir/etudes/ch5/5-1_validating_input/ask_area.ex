defmodule AskArea do
  @moduledoc """
    calcluates the area of a shape
  """

  @doc """
    prompts the user for a shape, and it's dimensions and calculates the area of that shape
  """
  @spec area() :: number()

  def area() do
    input = IO.gets("R)ectangle, T)riangle, or E)llipse: ")
    shape = char_to_shape(String.first(input))
    {d1, d2} = case shape do
      :rectangle -> get_dimensions("width", "height")
      :triangle  -> get_dimensions("base", "height")
      :ellipse   -> get_dimensions("major radius", "minor radius")
      :unknown   -> {String.first(input), 0}
    end

    calculate(shape, d1, d2)
  end

  @doc """
    takes a character as an input an returns the corresponding shape
  """
  @spec char_to_shape(String.t()) :: atom()

  defp char_to_shape(char) do
    upcase_char = String.upcase(char)

    cond do
      upcase_char == "R" -> :rectangle
      upcase_char == "T" -> :triangle
      upcase_char == "E" -> :ellipse
      true               -> :unknown
    end
  end

  @doc """
    prompts the user for two numbers and returns a tupple with those two numbers
  """
  @spec get_dimensions(String.t(), String.t()) :: {number(), number()}

  defp get_dimensions(prompt1, prompt2) do
    n1 = get_number(prompt1)
    n2 = get_number(prompt2)

    {n1, n2}
  end

  @doc """
    ask a user an input and turn the answer into an integer
  """
  @spec get_number(String.t()) :: number()

  defp get_number(prompt) do
    input = IO.gets("Enter #{prompt} > ")

    String.to_integer(String.trim(input))
  end

  @doc """
    Calculates the area of a shape, given it's shape and dimension
  """
  @spec calculate(atom(), number(), number()) :: number()

  defp calculate(shape, d1, d2) do
    cond do
      shape == :unknown -> IO.puts("Unknown shape #{d1}")
      d1 < 0 or d2 < 0  -> IO.puts("Both numbers must be greater or equal to 0")
      true              -> Geom.area(shape, d1, d2)
    end
  end
end
