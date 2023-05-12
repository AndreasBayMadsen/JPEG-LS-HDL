# Clock management
create_clock -period 8.000 -name clk -waveform {0.000 4.000} [get_ports clk];    # Base clock
create_generated_clock -name BD_pl_test_i/output_uart_sender_0/U0/uart_clk/clk_uart_temp -source [get_ports clk] -divide_by 68 [get_pins BD_pl_test_i/output_uart_sender_0/U0/uart_clk/clk_temp_reg/Q];
create_clock -period 83.333 -name VIRTUAL_clk_out1_HWT_cam_sim_clk -waveform {0.000 41.667};
set_input_delay -clock [get_clocks VIRTUAL_clk_out1_HWT_cam_sim_clk] -min -add_delay 2.000 [get_ports en];
set_input_delay -clock [get_clocks VIRTUAL_clk_out1_HWT_cam_sim_clk] -max -add_delay 3.000 [get_ports en];
set_input_delay -clock [get_clocks clk] -min -add_delay 2.000 [get_ports rst];
set_input_delay -clock [get_clocks clk] -max -add_delay 3.000 [get_ports rst];
create_clock -period 544.000 -name VIRTUAL_BD_pl_test_i/output_uart_sender_0/U0/uart_clk/clk_uart_temp -waveform {0.000 272.000};
set_output_delay -clock [get_clocks VIRTUAL_clk_out1_HWT_cam_sim_clk] -min -add_delay 0.000 [get_ports LED0];
set_output_delay -clock [get_clocks VIRTUAL_clk_out1_HWT_cam_sim_clk] -max -add_delay 1.100 [get_ports LED0];
set_output_delay -clock [get_clocks VIRTUAL_clk_out1_HWT_cam_sim_clk] -min -add_delay 0.000 [get_ports LED1];
set_output_delay -clock [get_clocks VIRTUAL_clk_out1_HWT_cam_sim_clk] -max -add_delay 1.100 [get_ports LED1];
set_output_delay -clock [get_clocks VIRTUAL_clk_out1_HWT_cam_sim_clk] -min -add_delay 0.000 [get_ports LED2];
set_output_delay -clock [get_clocks VIRTUAL_clk_out1_HWT_cam_sim_clk] -max -add_delay 1.100 [get_ports LED2];
set_output_delay -clock [get_clocks VIRTUAL_clk_out1_HWT_cam_sim_clk] -min -add_delay 0.000 [get_ports LED3];
set_output_delay -clock [get_clocks VIRTUAL_clk_out1_HWT_cam_sim_clk] -max -add_delay 1.100 [get_ports LED3];
set_output_delay -clock [get_clocks VIRTUAL_BD_pl_test_i/output_uart_sender_0/U0/uart_clk/clk_uart_temp] -min -add_delay 0.000 [get_ports uart_tx];
set_output_delay -clock [get_clocks VIRTUAL_BD_pl_test_i/output_uart_sender_0/U0/uart_clk/clk_uart_temp] -max -add_delay 1.100 [get_ports uart_tx];
