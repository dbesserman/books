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

  def julian(date_str) do
    [y, m, d]      = date_parts(date_str) 
    days_per_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    result         = month_total(m, days_per_month, 0) + d
    
    cond do
      is_leap_year(y) and m > 2 -> result + 1
      true                      -> result
    end
  end


  def month_total(1, _days_per_month, accumulator) do
    accumulator
  end

  def month_total(month, [this_month | other_months], accumulator) do
    month_total(month - 1, other_months, accumulator + this_month)
  end

  def is_leap_year(year) do
    (rem(year, 4) == 0 and rem(year, 100) != 0)
    or (rem(year, 400) == 0)
  end
end
