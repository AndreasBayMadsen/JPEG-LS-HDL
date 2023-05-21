## PIN CONSTRAINTS
    # General
set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports clk]
set_property -dict {PACKAGE_PIN D19 IOSTANDARD LVCMOS33} [get_ports reset]
    # Camera data interface
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { pclk }];      #IO_L18P_T2_34 Sch=jb_p[3]
set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33 } [get_ports { pixel[0] }];  #IO_L17P_T2_34 Sch=ja_p[1]
set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33 } [get_ports { pixel[2] }];  #IO_L17N_T2_34 Sch=ja_n[1]
set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33 } [get_ports { pixel[4] }];  #IO_L7P_T1_34 Sch=ja_p[2]
set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33 } [get_ports { pixel[6] }];  #IO_L7N_T1_34 Sch=ja_n[2]
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { pixel[1] }];  #IO_L12P_T1_MRCC_34 Sch=ja_p[3]
set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports { pixel[3] }];  #IO_L12N_T1_MRCC_34 Sch=ja_n[3]
set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports { pixel[5] }];  #IO_L22P_T3_34 Sch=ja_p[4]
set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { pixel[7] }];  #IO_L22N_T3_34 Sch=ja_n[4]
set_property -dict { PACKAGE_PIN Y14   IOSTANDARD LVCMOS33 } [get_ports { href }];      #IO_L8N_T1_34 Sch=jb_n[1]
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports { vsync }];     #IO_L18N_T2_34 Sch=jb_n[3]
    # Camera control interface
set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33   PULLTYPE PULLUP } [get_ports { sda }]; #IO_L1N_T0_34 Sch=jb_n[2]
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33   PULLTYPE PULLUP } [get_ports { scl }]; #IO_L4N_T0_34 Sch=jb_n[4]
set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports { cam_mck }];               #IO_L8P_T1_34 Sch=jb_p[1]
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports { cam_pwdn }];
set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { cam_res }];               #IO_L4P_T0_34 Sch=jb_p[4]
    # LEDs
set_property -dict {PACKAGE_PIN R14 IOSTANDARD LVCMOS33} [get_ports LED0]
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports LED1]

## TIMING
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets pclk_IBUF]