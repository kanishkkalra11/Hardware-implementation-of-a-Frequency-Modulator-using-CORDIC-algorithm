# Clock signal
set_property PACKAGE_PIN W5 [get_ports clock]
set_property IOSTANDARD LVCMOS33 [get_ports clock]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clock]

# Switches
set_property PACKAGE_PIN V17 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

# LEDs
set_property PACKAGE_PIN U16 [get_ports {ledsine[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ledsine[0]}]
set_property PACKAGE_PIN E19 [get_ports {ledsine[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ledsine[1]}]
set_property PACKAGE_PIN U19 [get_ports {ledsine[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ledsine[2]}]
set_property PACKAGE_PIN V19 [get_ports {ledsine[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ledsine[3]}]
set_property PACKAGE_PIN W18 [get_ports {ledsine[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ledsine[4]}]
set_property PACKAGE_PIN U15 [get_ports {ledsine[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ledsine[5]}]
set_property PACKAGE_PIN U14 [get_ports {ledsine[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ledsine[6]}]
set_property PACKAGE_PIN V14 [get_ports {ledsine[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ledsine[7]}]
set_property PACKAGE_PIN V13 [get_ports {ledsine[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ledsine[8]}]
set_property PACKAGE_PIN V3 [get_ports {ledsine[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ledsine[9]}]
set_property PACKAGE_PIN W3 [get_ports {ledsine[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ledsine[10]}]
set_property PACKAGE_PIN U3 [get_ports {ledsine[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ledsine[11]}]
set_property PACKAGE_PIN P3 [get_ports {ledsine[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ledsine[12]}]
set_property PACKAGE_PIN N3 [get_ports {ledsine[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ledsine[13]}]
set_property PACKAGE_PIN P1 [get_ports {ledsine[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ledsine[14]}]
set_property PACKAGE_PIN L1 [get_ports {ledsine[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ledsine[15]}]

#Pmod Header JB
#Sch name = JB1
set_property PACKAGE_PIN A14 [get_ports {wave[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {wave[0]}]
#Sch name = JB2
set_property PACKAGE_PIN A16 [get_ports {wave[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {wave[1]}]
#Sch name = JB3
set_property PACKAGE_PIN B15 [get_ports {wave[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {wave[2]}]
#Sch name = JB4
set_property PACKAGE_PIN B16 [get_ports {wave[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {wave[3]}]
#Sch name = JB7
set_property PACKAGE_PIN A15 [get_ports {wave[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {wave[4]}]
#Sch name = JB8
set_property PACKAGE_PIN A17 [get_ports {wave[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {wave[5]}]
#Sch name = JB9
set_property PACKAGE_PIN C15 [get_ports {wave[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {wave[6]}]
#Sch name = JB10
set_property PACKAGE_PIN C16 [get_ports {wave[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {wave[7]}]

#Pmod Header JC
#Sch name = JC1
set_property PACKAGE_PIN K17 [get_ports {wave[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {wave[8]}]
#Sch name = JC2
set_property PACKAGE_PIN M18 [get_ports {wave[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {wave[9]}]
#Sch name = JC3
set_property PACKAGE_PIN N17 [get_ports {wave[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {wave[10]}]
#Sch name = JC4
set_property PACKAGE_PIN P18 [get_ports {wave[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {wave[11]}]
#Sch name = JC7
set_property PACKAGE_PIN L17 [get_ports {wave[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {wave[12]}]
#Sch name = JC8
set_property PACKAGE_PIN M19 [get_ports {wave[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {wave[13]}]
#Sch name = JC9
set_property PACKAGE_PIN P17 [get_ports {wave[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {wave[14]}]
#Sch name = JC10
set_property PACKAGE_PIN R18 [get_ports {wave[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {wave[15]}]

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]