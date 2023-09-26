set_property -dict { PACKAGE_PIN AP8 IOSTANDARD LVCMOS18} [get_ports o_led_drive]
set_property -dict { PACKAGE_PIN AK17 IOSTANDARD LVDS} [get_ports i_clock_p]
set_property -dict { PACKAGE_PIN AK16 IOSTANDARD LVDS} [get_ports i_clock_n]

create_clock -name input_clk -period 3.333 [get_ports i_clock_p]
set_clock_groups -group [get_clocks input_clk -include_generated_clocks] -asynchronous
