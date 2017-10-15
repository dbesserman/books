defprotocol Valid do
  @doc "returns true if data is considered nominally valid"

  def valid?(data)
end

defimpl Valid, for: Planemo do
  def valid?(p) do
    p.gravity >= 0 && p.diameter >= 0 && p.distance_from_sun >= 0
  end
end
