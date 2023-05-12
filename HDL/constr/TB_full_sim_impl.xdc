# Constraints for the JPEG_LS_module_top_impl module meant for post-implementation simulation
# PORT CONSTRAINTS
set_property -dict { PACKAGE_PIN D19   IOSTANDARD LVCMOS33 } [get_ports { resetn }];    # Logic LOW reset
set_property -dict { PACKAGE_PIN H16   IOSTANDARD LVCMOS33 } [get_ports { pclk }];      # Pixel clock
set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33 } [get_ports { pixel[0] }];  # Pixel data
set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33 } [get_ports { pixel[2] }];
set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33 } [get_ports { pixel[4] }];
set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33 } [get_ports { pixel[6] }];
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { pixel[1] }];
set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports { pixel[3] }];
set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports { pixel[5] }];
set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { pixel[7] }];
set_property -dict { PACKAGE_PIN Y14   IOSTANDARD LVCMOS33 } [get_ports { href }];      # href
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports { vsync }];     # vsync

# TIMING CONSTRAINTS
create_clock -period 83.000 -name pclk [get_ports pclk];    # Pixel clock