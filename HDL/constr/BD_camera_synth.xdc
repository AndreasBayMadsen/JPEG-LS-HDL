## TIMING
create_clock -period 8.000 -name clk -waveform {0.000 4.000} [get_ports clk]
create_clock -add -name sys_clk_pin -period 83.00 [get_ports { pclk }];