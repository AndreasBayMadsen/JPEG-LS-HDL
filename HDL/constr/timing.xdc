# Clock management
create_clock -period 8.000 -name clk -waveform {0.000 4.000} [get_ports clk]

# create_generated_clock -name BD_full_test_i/output_uart_sender_0/U0/uart_clk/clk_uart_temp -source [get_ports clk] -divide_by 68 [get_pins BD_full_test_i/output_uart_sender_0/U0/uart_clk/clk_temp_reg/Q]
