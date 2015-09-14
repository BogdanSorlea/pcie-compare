create_clock -name sys_clk -period 10 [get_pins -match_style ucf */pcieclk_ibuf/O]

set_false_path -to [get_pins -match_style ucf */pipe_clock/pclk_i1_bufgctrl.pclk_i1/S0]
set_false_path -to [get_pins -match_style ucf */pipe_clock/pclk_i1_bufgctrl.pclk_i1/S1]

# Even though the example design attempts to convince Vivado that the BUFCTRL
# is set to pass the 125 MHz clock, the result is an analysis as if the clock
# isn't toggling at all. So the constraint is given explicitly.

create_clock -name bus_clk -period 8 [get_pins -match_style ucf */pipe_clock/pclk_i1_bufgctrl.pclk_i1/O]

set_property DONT_TOUCH true [get_cells -of [get_nets -of [get_pins -match_style ucf */pipe_clock/pclk_i1_bufgctrl.pclk_i1/S0]]]
set_property DONT_TOUCH true [get_cells -hier -filter {name=~*/pipe_clock/pclk_sel*}]

set_false_path -from [get_ports PCIE_PERST_B_LS]

set_property LOC IBUFDS_GTE2_X0Y2 [get_cells -match_style ucf */pcieclk_ibuf]

set_property -dict "PACKAGE_PIN M20 IOSTANDARD LVCMOS33 PULLUP true" [get_ports PCIE_PERST_B_LS]

set_property -dict "PACKAGE_PIN M26 IOSTANDARD LVCMOS33" [get_ports "GPIO_LED[0]"]
set_property -dict "PACKAGE_PIN T24 IOSTANDARD LVCMOS33" [get_ports "GPIO_LED[1]"]
set_property -dict "PACKAGE_PIN T25 IOSTANDARD LVCMOS33" [get_ports "GPIO_LED[2]"]
set_property -dict "PACKAGE_PIN R26 IOSTANDARD LVCMOS33" [get_ports "GPIO_LED[3]"]
