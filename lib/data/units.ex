defmodule AtisDecoder.Data.Units do
  @valid_speed_units [
    "KT",
    "kt"
  ]

  @valid_visibility_units [
    "NM",
    "nm",
    "SM",
    "sm"
  ]

  def valid_speed_units, do: @valid_speed_units
  def valid_visibility_units, do: @valid_visibility_units
end
