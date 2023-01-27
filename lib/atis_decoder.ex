defmodule AtisDecoder do
  alias AtisDecoder.Data.Dummy

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

  # Airport/loc block
  def parse_data(data_block, %{acc: 0} = acc) do
    acc
    |> Map.put(:airport, data_block)
    |> Map.replace(:acc, Map.get(acc, :acc) + 1)
    |> IO.inspect
  end
  # Information block
  def parse_data(data_block, %{acc: 3} = acc) do
    acc
    |> Map.put(:information, data_block)
    |> Map.put(:information_phoenetic, to_phoenetic(data_block))
    |> Map.replace(:acc, Map.get(acc, :acc) + 1)
  end
  # Time block
  def parse_data(data_block, %{acc: 4} = acc) do
    acc
    |> Map.put(:time, data_block)
    |> Map.replace(:acc, Map.get(acc, :acc) + 1)
  end
  # Wind block
  # 07001G01KT with 2 digit speed and gusts
  # 07001KT with 2 digit speed and no gusts
  # 070100G100KT with 3 digit speed and gusts
  def parse_data(data_block, %{acc: 5} = acc) do
    data = case String.contains?(data_block, "G") do
      true ->
        direction = String.slice(data_block, 0..2)
        steady = String.slice(data_block, 3..4) |> String.replace("G", "")
        gusts = String.slice(data_block, 6..8) |> String.replace("K", "")
        %{
          wind_direction: direction,
          wind_gust: gusts,
          wind_speed: steady
        }
      false ->
        direction = String.slice(data_block, 0..2) |> String.replace("G", "")
        steady = String.slice(data_block, 3..5) |> String.replace("K", "")
        %{
          wind_direction: direction,
          wind_gust: 0,
          wind_speed: steady
        }
    end
    acc
    |> Map.put(:wind, data)
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
      _ -> "coming"
    end
  end
end
