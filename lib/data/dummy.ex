defmodule AtisDecoder.Data.Dummy do
  @dummy_data [
    "ABQ ATIS INFO H 0252Z. 07029G41KT 10SM FEW000 FEW045 BKN070 OVC140 00/M07 A2996 (TWO NINER NINER SIX) RMK AO2 PK WND 09041/0252 SLP152 FG FEW000 MTNS OBSC NE-SE 51012. SIMUL APPROACHES IN USE. ARRIVALS EXPECT VISUAL APCH RWY 8, RWY 3. DEPG RWY 8. CARRIERS EXPT TO DPT 8 AT A 3. 12500 FT AVAILABLE.ADV IF UNABLE. NOTICE TO AIR MISSIONS. TWY H CLOSED., TWY ALFA ONE AND ALFA TWO CLOSED. TWY ALFA BETWEEN ALFA ONE AND ALFA 2 CLOSED. WIND SHEAR ADZYS IN EFCT. LIGHT TO MODERATE TURBULENCE BELOW 150. CRANE AT TERMINAL 250 FEET AGL. CONTACT TOWER ONE TWO ZERO POINT THREE FOR PUSHBACK AND TAXI. ABQ VORTAC OUT OF SERVICE.. ...ADVS YOU HAVE INFO H.",
    "ADW ATIS INFO X 0255Z. 29009G16KT 10SM OVC040 04/M03 A3007 (THREE ZERO ZERO SEVEN) RMK PRES ALT PS141 TEMP 39FAH. ILS, RWY 1L, 1R, VISUAL APPROACH, RWY 1L, 1R APPROACH IN USE. NOTAMS... TWY W4 CLSD. ALL ACFT MUST READ BACK HOLD SHORT INSTRUCTIONS. ALL ACFT TURN TRANSPONDERS ON WHEN ENTERING MOVEMENT AREA. CAUTION, BIRD CONDITION LOW, BASH PHASE 1 IN EFFECT. ...ADVS YOU HAVE INFO X.",
    "ATL DEP INFO P 0252Z. 32004KT 10SM CLR 03/M02 A3029 (THREE ZERO TWO NINER). SIMUL DEPS, DEPG RWYS, 26L, 27R. XPECT RNAV OFF THE GROUND DEPTG RWY 26L, XPECT RNAV OFF THE GROUND DEPTG RWY 27R. GROUND CONTROL WILL ASSIGN RUNWAY WITH TAXI INSTRUCTIONS. NOTAMS... TWY W CLSD. BIRD ACTIVITY VC OF ARPT. OPERATE TRANSPONDER WITH MODE C ON ALL RAMPS, TWYS AND RWYS.. ...ADVS YOU HAVE INFO P.",
    "BWI ATIS INFO M 0254Z. 31009KT 10SM OVC042 04/M04 A3007 (THREE ZERO ZERO SEVEN) RMK AO2 SLP183 51030. ARR ACFT EXP VISUAL APCH RWY 33L, RWY 33R. DEPG RWYS 28, 33R. NOTICE TO AIR MISSIONS. TAXIWAY ROMEO 1 CENTERLINE MARKINGS BETWEEN TAXIWAY R AND RUNWAY 10 NON-STANDARD. TAXIWAY ECHO DIRECTION SIGN OUT OF SERVICE. RUNWAY 33L RUNWAY ALIGNMENT INDICATOR LIGHTS OUT OF SERVICE. BIRD ACTIVITY VICINITY ARPT. WIND SHEAR ADZYS IN EFCT. SIMUL APCHS ARE BEING CONDUCTED TO PARL RWYS. 5G NOTAM IN EFFECT FOR BWI AIRPORT. FOR FURTHER INFORMATION CONTACT FLIGHT SERVICE. ...ADVS YOU HAVE INFO M.",
    "DFW DEP INFO D 0253Z. 09006KT 10SM SCT085 BKN110 09/M02 A3019 (THREE ZERO ONE NINER). SIMUL PARL TRAFFIC DEPG RWYS 17R, 18L. NOTAMS... RWY 17R CL OTS, RWSL OTS. TWY K CLSD BTWN TWYS EL AND K9. ATTN ALL ACFT 5G NOTAM IN EFCT FOR DFW ARPT FOR FURTHER INFO CTC FSS FREQ. BIRD ACTIVITY VCNTY ARPT. ...ADVS YOU HAVE INFO D.",
    "LAX ATIS INFO H 0253Z. 00000KT 10SM CLR 13/07 A3008 (THREE ZERO ZERO EIGHT) RMK AO2 SLP185 53015. INST APCHS AND RNAV RNP APCHS RY 24R AND 25L, OR VCTR FOR VISUAL APCH WILL BE PROVIDED, SIMUL VISUAL APCHS TO ALL RWYS ARE IN PROG, SIMUL INSTR DEPARTURES IN PROG RWYS 24 AND 25. CTC L A GC ON 121.75 FOR PUSH OR TAXI ON A. PAPI OTS 24L, RY 25R THRESHOLD LGTS OTS. HAZD WX INFO FOR LAX AREA AVBL FM FSS. BIRD ACTIVITY VICINITY ARPT. INCLUDE YOUR CALL SIGN IN ALL READBACKS. ...ADVS YOU HAVE INFO H.",
    "MSP DEP INFO Q 0253Z. 27009KT 10SM FEW015 BKN060 M01/M04 A2999 (TWO NINER NINER NINER). DEPARTING RWY 30L, RWY 30R, RWY 17. NOTAMS... RWYS 4, 22 CLSD. ATTN ALL ACFT, 5G NOTAMS IN EFFECT FOR MSP, CTC FSS.. ALL ACFT CTC GND METERING ON ONE THREE THREE POINT FIVE SEVEN WHEN READY TO PUSHBACK OR TAXI. RWY 30L CONDITION CODES, 5 5 5 AT 1900Z, RWY 30R CONDITION CODES, 5 5 5 AT 1900Z, RWY 17 CONDITION CODES, 5 5 5 AT 1900Z. HAZD WX INFO FOR MSP AREA AVBL FM FSS. CTN, BIRDS NEAR MSP. READ BACK HS AND ALT. ALL ACFT TAXI WITH TRANSPONDER AND ALTITUDE ENCODING ON. ...ADVS YOU HAVE INFO Q."
  ]

  def get_dummy_datis(), do: Enum.random(@dummy_data)
end
