defmodule City do
  defstruct name: "", population: 0, latitude: 0, longitude: 0
end

defimpl Valid, for: City do
  def valid?(%City{population: p, latitude: lat, longitude: lon}) do
    p >= 0 &&
      lat >= - 90 && lat <= 90 &&
      lon >= -180 && lon <= 180
  end
end

defimpl Inspect, for: City do
  import String.Chars
  def inspect(item, _options) do
    "#{item.name} (population: #{item.population}): #{item.latitude}-#{item.longitude}"
  end
end
