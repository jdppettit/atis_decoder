defmodule AtisDecoder do
  alias AtisDecoder.Data.Dummy
  alias AtisDecoder.Checks
  alias AtisDecoder.Data.Units

  def decode(data), do: &iterate(&1)
  def decode do
    Dummy.get_dummy_datis()
    |> iterate
  end

  def iterate(nil), do: raise "No data provided"
  def iterate(data) do
    data
    |> String.split(" ")
    |> Enum.reduce(%{acc: 0}, &parse_data(&1, &2))
  end

  def parse_data(nil), do: nil
  def parse_data(data_block, acc) do
    acc = if is_airport_block?(data_block) do
      parse_airport_data(data_block, acc)
    else
      acc
    end

    acc = if is_information_block?(data_block) do
      parse_information_block(data_block, acc)
    else
      acc
    end

    acc = if is_time_block?(data_block) do
      parse_time_block(data_block, acc)
    else
      acc
    end

    acc = if is_special_block?(data_block) do
      parse_special_block(data_block, acc)
    else
      acc
    end

    acc = if is_wind_block?(data_block) do
      parse_wind_block(data_block, acc)
    else
      acc
    end

    acc = if is_visibility_block?(data_block) do
      parse_visibility_block(data_block, acc)
    else
      acc
    end

    acc = if is_weather_block?(data_block) do
      parse_weather_block(data_block, acc)
    else
      acc
    end
  end

  def is_airport_block?(data_block) do
    with length when length == 3 <- String.length(data_block),
         true <- Checks.is_alpha?(data_block),
         true <- Checks.is_iata?(data_block)
    do
      true
    else
      _ ->
        false
    end
  end

  def is_information_block?(data_block) do
    with length when length == 1 <- String.length(data_block),
         true <- Checks.is_alpha?(data_block)
    do
      true
    else
      _ ->
        false
    end
  end

  def is_time_block?(data_block) do
    with length when length == 5 <- String.length(data_block),
         true <- Checks.first_four_numbers?(data_block),
         true <- Checks.valid_time?(data_block),
         true <- Checks.z_present?(data_block)
    do
      true
    else
      _ ->
        false
    end
  end

  def is_special_block?(data_block) do
    with length when length == 7 or length == 8 <- String.length(data_block),
         true <- Checks.is_special?(data_block)
    do
      true
    else
      _ ->
        false
    end
  end

  def is_wind_block?(data_block) do
    with true <- Checks.is_of_length?(data_block, [7, 8, 10, 11, 12]),
         true <- Checks.is_alphanumeric?(data_block),
         true <- Checks.includes_speed_unit?(data_block),
         true <- Checks.includes_wind_characters_only?(data_block)
    do
      true
    else
      _ ->
        false
    end
  end

  def is_visibility_block?(data_block) do
    with true <- Checks.is_of_length?(data_block, [5, 4]),
         true <- Checks.includes_visibility_characters_only?(data_block),
         true <- Checks.includes_visibility_unit?(data_block),
         true <- Checks.ends_with?(data_block, -1..-2, Units.valid_visibility_units)
    do
      true
    else
      _ ->
        false
    end
  end

  def is_weather_block?(data_block) do
    with true <- Checks.length_divisible_by?(data_block, 2),
         true <- Checks.composed_of_weather_blocks?(data_block)
    do
      true
    else
      _ ->
        false
    end
  end

  def parse_airport_data(data_block, acc) do
    acc
    |> Map.put(:airport, data_block)
    |> bump_acc
  end

  def parse_information_block(data_block, acc) do
    acc
    |> Map.put(:information, data_block)
    |> Map.put(:information_phoenetic, to_phoenetic(data_block))
    |> bump_acc
  end

  def parse_time_block(data_block, acc) do
    acc
    |> Map.put(:time, data_block)
    |> bump_acc
  end

  def parse_special_block(data_block, acc) do
    acc
    |> Map.put(:special, true)
    |> bump_acc
  end

  # Wind block
  # 07001G01KT with 2 digit speed and gusts total: 10
  def parse_wind_block(data_block, acc) when byte_size(data_block) == 10 do
    direction = String.slice(data_block, 0..2)
    steady = String.slice(data_block, 3..4)
    gusts = String.slice(data_block, 6..7)
    unit = String.slice(data_block, 8..9)

    wind_data = %{
      direction: direction,
      wind_speed: steady,
      wind_gust: gusts,
      unit: unit
    }

    acc
    |> Map.put(:wind, wind_data)
    |> Map.replace(:acc, Map.get(acc, :acc) + 1)
  end

  # 07001KT with 2 digit speed and no gusts total: 7
  def parse_wind_block(data_block, acc) when byte_size(data_block) == 7 do
    direction = String.slice(data_block, 0..2)
    steady = String.slice(data_block, 3..4)
    gusts = 0
    unit = String.slice(data_block, 5..6)

    wind_data = %{
      direction: direction,
      wind_speed: steady,
      wind_gust: gusts,
      unit: unit
    }

    acc
    |> Map.put(:wind, wind_data)
    |> Map.replace(:acc, Map.get(acc, :acc) + 1)
  end

  # 070100KT with 3 digit speed and no gusts total: 8
  def parse_wind_block(data_block, acc) when byte_size(data_block) == 8 do
    direction = String.slice(data_block, 0..2)
    steady = String.slice(data_block, 3..5)
    gusts = 0
    unit = String.slice(data_block, 6..7)

    wind_data = %{
      direction: direction,
      wind_speed: steady,
      wind_gust: gusts,
      unit: unit
    }

    acc
    |> Map.put(:wind, wind_data)
    |> Map.replace(:acc, Map.get(acc, :acc) + 1)
  end

  # 070100G01KT with 3 digit speed and 2 digit gusts total: 11
  def parse_wind_block(data_block, acc) when byte_size(data_block) == 11 do
    direction = String.slice(data_block, 0..2)
    steady = String.slice(data_block, 3..5)
    gusts = String.slice(data_block, 7..8)
    unit = String.slice(data_block, 9..10)

    wind_data = %{
      direction: direction,
      wind_speed: steady,
      wind_gust: gusts,
      unit: unit
    }

    acc
    |> Map.put(:wind, wind_data)
    |> Map.replace(:acc, Map.get(acc, :acc) + 1)
  end

  # 070100G100KT with 3 digit speed and gusts total: 12
  def parse_wind_block(data_block, acc) when byte_size(data_block) == 12 do
    direction = String.slice(data_block, 0..2)
    steady = String.slice(data_block, 3..5)
    gusts = String.slice(data_block, 7..9)
    unit = String.slice(data_block, 10..11)

    wind_data = %{
      direction: direction,
      wind_speed: steady,
      wind_gust: gusts,
      unit: unit
    }

    acc
    |> Map.put(:wind, wind_data)
    |> Map.replace(:acc, Map.get(acc, :acc) + 1)
  end

  # Visiblity and unit
  # 10SM
  def parse_visibility_block(data_block, acc) when byte_size(data_block) == 4 do
    visibility_distance = String.slice(data_block, 0..1)
    visibility_unit = String.slice(data_block, 2..3)

    visibility_data = %{
      distance: visibility_distance,
      unit: visibility_unit
    }

    list = [Map.get(acc, :visibility, nil) | [visibility_data]]
    list = list
    |> Enum.filter(&!is_nil(&1))

    acc
    |> Map.put(:visibility, list)
    |> Map.replace(:acc, Map.get(acc, :acc) + 1)
  end

  def parse_visibility_block(data_block, acc) when byte_size(data_block) == 5 do
    visibility_distance = String.slice(data_block, 0..2)
    visibility_unit = String.slice(data_block, 3..4)

    visibility_data = %{
      distance: visibility_distance,
      unit: visibility_unit
    }

    list = [Map.get(acc, :visibility, nil) | [visibility_data]]
    list = list
    |> Enum.filter(&!is_nil(&1))
    acc
    |> Map.put(:visibility, list)
    |> Map.replace(:acc, Map.get(acc, :acc) + 1)
  end

  def parse_weather_block(data_block, acc) do
   data_block = data_block
    |> String.codepoints
    |> Enum.chunk_every(2)
    |> Enum.map(&Enum.join/1)
    |> Enum.map(fn block ->
      %{
        code: block,
        code_human: ceiling_to_human(block)
      }
    end)

    acc
    |> Map.put(:weather, data_block)
    |> Map.replace(:acc, Map.get(acc, :acc) + 1)
  end

  # Represents the ceiling and obstruction type in feet
  # FEW000
  def parse_data(data_block, %{acc: 7} = acc) do

    obstruction_type = String.slice(data_block, 0..2)
    obstruction_type_human = ceiling_to_human(obstruction_type)
    ceiling = String.slice(data_block, 3..5)

    ceiling_data = [
      %{
        obstruction_type: obstruction_type,
        obstruction_type_human: obstruction_type_human,
        ceiling: ceiling
      }
    ]

    acc
    |> Map.put(:ceiling, ceiling_data)
    |> Map.replace(:acc, Map.get(acc, :acc) + 1)
  end

  def parse_data(_data_block, acc) do
    acc
    |> Map.replace(:acc, Map.get(acc, :acc) + 1)
  end

  defp to_phoenetic(data) do
    case String.downcase(data) do
      "a" -> "alpha"
      "b" -> "bravo"
      "c" -> "charlie"
      "d" -> "delta"
      "e" -> "echo"
      "f" -> "foxtrot"
      "g" -> "golf"
      "h" -> "hotel"
      "i" -> "india"
      "j" -> "juliet"
      "k" -> "kilo"
      "l" -> "lima"
      "m" -> "mike"
      "n" -> "november"
      "o" -> "oscar"
      "p" -> "papa"
      "q" -> "quebec"
      "r" -> "romeo"
      "s" -> "sierra"
      "t" -> "tango"
      "u" -> "uniform"
      "v" -> "victor"
      "w" -> "wilco"
      "x" -> "x-ray"
      "y" -> "yankee"
      "z" -> "zulu"
      _ -> "dunno"
    end
  end

  defp ceiling_to_human(data) do
    case String.upcase(data) do
      "FEW" -> "few clouds"
      "SKC" -> "clear skies"
      "CLR" -> "clear skies"
      "SKT" -> "scattered clouds"
      "SCT" -> "scattered clouds"
      "FG" -> "fog"
      "BR" -> "mist"
      "FU" -> "smoke"
      "HZ" -> "haze"
      "PY" -> "spray"
      "SA" -> "sand"
      "DU" -> "dust"
      "VA" -> "volanic ash"
      "RA" -> "rain"
      "DZ" -> "drizzle"
      "SN" -> "snow"
      "SG" -> "snow grains"
      "GR" -> "hail"
      "GS" -> "small hail"
      "PE" -> "ice pellets"
      "IC" -> "ice crystals"
      "BC" -> "patching"
      "FZ" -> "freezing"
      "SH" -> "showers"
      "TS" -> "thunderstorms"
      _ -> ""
    end
  end

  defp bump_acc(acc) do
    acc
    |> Map.replace(:acc, Map.get(acc, :acc) + 1)
  end
end
