## TIMING
create_clock -period 8.000 -name clk -waveform {0.000 4.000} [get_ports clk]
create_clock -add -name pclk -period 83.00 [get_ports { pclk }];

## HIERARCHY CONSTRAINTS
    # JPEG-LS module
set_property KEEP_HIERARCHY TRUE [get_cells BD_camera_i/JPEG_LS_module/U0/*]
set_property KEEP_HIERARCHY TRUE [get_cells BD_camera_i/JPEG_LS_module/U0/mod_1_r/*]
set_property KEEP_HIERARCHY TRUE [get_cells BD_camera_i/JPEG_LS_module/U0/mod_1_g/*]
set_property KEEP_HIERARCHY TRUE [get_cells BD_camera_i/JPEG_LS_module/U0/mod_1_b/*]
set_property KEEP_HIERARCHY TRUE [get_cells BD_camera_i/JPEG_LS_module/U0/mod_3_r/*]
set_property KEEP_HIERARCHY TRUE [get_cells BD_camera_i/JPEG_LS_module/U0/mod_3_g/*]
set_property KEEP_HIERARCHY TRUE [get_cells BD_camera_i/JPEG_LS_module/U0/mod_3_b/*]
set_property KEEP_HIERARCHY TRUE [get_cells BD_camera_i/JPEG_LS_module/U0/mod_4_r/*]
set_property KEEP_HIERARCHY TRUE [get_cells BD_camera_i/JPEG_LS_module/U0/mod_4_g/*]
set_property KEEP_HIERARCHY TRUE [get_cells BD_camera_i/JPEG_LS_module/U0/mod_4_b/*]
    # Output buffer module
set_property KEEP_HIERARCHY TRUE [get_cells BD_camera_i/output_buffer]
    # Camera configurer module
set_property KEEP_HIERARCHY TRUE [get_cells BD_camera_i/camera_config]