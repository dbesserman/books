defmodule Geography do
  def make_geo_list(file_name) do
    {_result, device} = File.open(file_name, [:read, :utf8])
    process_line(device, [])
  end

  defp process_line(device, geo_list) do
    data = IO.read(device, :line)

    case data do
      :eof ->
        File.close(device)
        geo_list
      _   -> 
        info = String.split(String.strip(data), ",")
        updated_list = process_info(info, geo_list)
        process_line(device, updated_list)
    end
  end

  defp process_info([country, language], geo_list) do
    [%Country{name: country, language: language} | geo_list]
  end

  defp process_info([city, population, latitude, longitude], [head|tail]) do
    new_city   = %City{name: city, population: population, latitude: latitude, longitude: longitude}
    new_cities = [new_city | head.cities]

    [%Country{head | cities: new_cities} | tail]
  end
end
