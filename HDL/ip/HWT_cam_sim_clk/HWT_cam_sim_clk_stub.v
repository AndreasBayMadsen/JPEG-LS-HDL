// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Mon Mar 27 20:39:29 2023
// Host        : andreas-Huawei running 64-bit Ubuntu 22.04.2 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/andreas/Desktop/ProfileProject/JPEG-LS-HDL/HDL/ip/HWT_cam_sim_clk/HWT_cam_sim_clk_stub.v
// Design      : HWT_cam_sim_clk
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module HWT_cam_sim_clk(clk_out1, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_out1,clk_in1" */;
  output clk_out1;
  input clk_in1;
endmodule
