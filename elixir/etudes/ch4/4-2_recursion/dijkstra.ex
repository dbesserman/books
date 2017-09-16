defmodule Dijkstra do
  @moduledoc """
  includes methods to recursively calculate the greatest common divisor
  with Dijkstra's algorithm
  """

  @spec gcd(number, number) :: number

  def gcd(m, n) when m == n do
    m
  end

  def gcd(m, n) when m > n do
    gcd(m-n, n)
  end

  def gcd(m, n) do
    gcd(n - m, m)
  end
end
