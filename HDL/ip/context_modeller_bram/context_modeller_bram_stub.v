// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Mon May  1 12:37:47 2023
// Host        : andreas-Huawei running 64-bit Ubuntu 22.04.2 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/andreas/Desktop/ProfileProject/JPEG-LS-HDL/HDL/ip/context_modeller_bram/context_modeller_bram_stub.v
// Design      : context_modeller_bram
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *)
module context_modeller_bram(clka, wea, addra, dina, clkb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[8:0],dina[39:0],clkb,addrb[8:0],doutb[39:0]" */;
  input clka;
  input [0:0]wea;
  input [8:0]addra;
  input [39:0]dina;
  input clkb;
  input [8:0]addrb;
  output [39:0]doutb;
endmodule
