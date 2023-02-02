defmodule AtisDecoder.Checks do
  alias AtisDecoder.Data.{IATA,Units,Weather}

  def is_alpha?(test) do
    case Integer.parse(test) do
      {_, ""} -> false
      _ -> true
    end
  end

  def is_integer?(test) do
    is_integer(test)
  end

  def is_iata?(test) do
    Enum.member?(IATA.valid_iata_codes(), test)
  end

  def first_four_numbers?(test) do
    first_four = String.slice(test, 0..3)
    first_four = case Integer.parse(first_four) do
      {int, _} ->
        int
      _ ->
        false
    end
    is_integer?(first_four)
  end

  def z_present?(test) do
    String.contains?(String.downcase(test), "z")
  end

  def valid_time?(test) do
    first_four = String.slice(test, 0..3)
    first_four = case Integer.parse(first_four) do
      {int, _} ->
        int
      _ ->
        false
    end
    if first_four == false do
      false
    else
      if first_four >= 0 && first_four <= 2459 do
        true
      else
        false
      end
    end
  end

  def is_special?(test) do
    case String.downcase(test) do
      "special" ->
        true
      "special." ->
        true
      _ ->
        false
    end
  end

  def is_of_length?(data_block, length_options) do
    results = Enum.map(length_options, fn length_option->
      String.length(data_block) == length_option
    end)
    Enum.member?(results, true)
  end

  def is_alphanumeric?(data_block) do
    String.valid?(data_block)
  end

  def includes_speed_unit?(data_block) do
    results = Enum.map(Units.valid_speed_units(), fn speed_unit ->
      String.contains?(data_block, speed_unit)
    end)
    Enum.member?(results, true)
  end

  def includes_visibility_unit?(data_block) do
    results = Enum.map(Units.valid_visibility_units(), fn speed_unit ->
      String.contains?(data_block, speed_unit)
    end)
    Enum.member?(results, true)
  end

  def includes_wind_characters_only?(data_block) do
    numbers = [0..9]
    valid_list = ["g", "k", "t" | numbers]
    results = Enum.map(String.codepoints(data_block), fn char ->
      Enum.member?(valid_list, char)
    end)
    Enum.member?(results, false)
  end

  def includes_visibility_characters_only?(data_block) do
    numbers = [0..9]
    valid_list = ["s", "m", "n" | numbers]
    results = Enum.map(String.codepoints(data_block), fn char ->
      Enum.member?(valid_list, char)
    end)
    Enum.member?(results, false)
  end

  def ends_with?(data_block, characters, options) do
    String.ends_with?(data_block, options)
  end

  def length_divisible_by?(data_block, divisor) do
    length = String.length(data_block)
    if rem(length, divisor) == 0 do
      true
    else
      false
    end
  end

  def composed_of_weather_blocks?(data_block) do
    data_block = data_block
    |> String.codepoints
    |> Enum.chunk_every(2)
    |> Enum.map(&Enum.join/1)
    |> Enum.map(fn block ->
      Enum.member?(Weather.valid_weather_codes, block)
    end)
    !Enum.member?(data_block, false)
  end

  defp get_alphabet_list, do: for n <- ?a..?z, do: << n :: utf8 >>
end
