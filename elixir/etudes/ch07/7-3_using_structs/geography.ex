require IEx;

defmodule Geography do
  def make_geo_list(file_name) do
    {_result, device} = File.open(file_name, [:read, :utf8])
    process_line(device, [])
  end

  def total_population(geo_list, language) do
    total_population(geo_list, language, 0)
  end

  defp total_population([], _language, total) do
    total
  end

  defp total_population([head|tail], language, total) do
    if (head.language == language) do
      total_population(tail, language, subtotal(head.cities, total))
    else
      total_population(tail, language, total)
    end
  end

  def subtotal([], accumulator) do
    accumulator
  end

  def subtotal([head|tail], accumulator) do
    subtotal(tail, accumulator + head.population)
  end

  defp process_line(device, geo_list) do
    data = IO.read(device, :line)

    case data do
      :eof ->
        File.close(device)
        geo_list
      _    -> 
        info = String.split(String.trim(data), ",")
        updated_list = process_info(info, geo_list)
        process_line(device, updated_list)
    end
  end

  defp process_info([country, language], geo_list) do
    [%Country{name: country, language: language} | geo_list]
  end

  defp process_info([city, pop, lat, long], [head|tail]) do
    population = String.to_integer(pop)
    latitude   = String.to_float(lat)
    longitude  = String.to_float(long)
    new_city   = %City{name: city, population: population, latitude: latitude, longitude: longitude}
    new_cities = [new_city | head.cities]

    [%Country{head | cities: new_cities} | tail]
  end
end
