defmodule Dates do
  @docmodule """
  parses dates
  """

  @doc """
  Takes a string and turns it into a list of integer representing the date
  """
  @spec date_parts(String.t()) :: list

  def date_parts(str) do
    [y_str, m_str, d_str] = String.split(str, "-")
    [String.to_integer(y_str), String.to_integer(m_str), String.to_integer(d_str)]
  end
end
