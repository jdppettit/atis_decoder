defmodule AtisDecoder.Data.Weather do
  @valid_weather_codes [
      "FG",
      "FU",
      "HZ",
      "PY",
      "SA",
      "DU",
      "VA",
      "RA",
      "DZ",
      "SN",
      "SG",
      "GR",
      "GS",
      "PE",
      "IC",
      "BC",
      "FZ",
      "SH",
      "TS"
  ]

  @valid_ceiling_codes [
      "FEW",
      "SKC",
      "CLR",
      "SKT",
      "SCT",
      "OVC",
      "BKN"
  ]

  def valid_weather_codes, do: @valid_weather_codes
  def valid_ceiling_codes, do: @valid_ceiling_codes
end
