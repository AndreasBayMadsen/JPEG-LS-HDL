// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Mon Feb 20 12:29:05 2023
// Host        : faur running 64-bit Ubuntu 22.04.1 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/faurskov/Documents/PP/JPEG-LS-HDL/ip/blk_mem_gen_0/blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_0
   (clka,
    ena,
    wea,
    addra,
    dina,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [8:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;

  wire [8:0]addra;
  wire clka;
  wire [31:0]dina;
  wire [31:0]douta;
  wire ena;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_doutb_UNCONNECTED;
  wire [8:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [8:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "9" *) 
  (* C_ADDRB_WIDTH = "9" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     3.53845 mW" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "blk_mem_gen_0.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "512" *) 
  (* C_READ_DEPTH_B = "512" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "1" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "512" *) 
  (* C_WRITE_DEPTH_B = "512" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_0_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[31:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[8:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[8:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VHPlDkoDlWlBfBMvPBmGYmaek3s9hXXhjF28kllYPnaNm3TSnzzpXHWHc8Ye9/2L2yiQfJ1hTWou
Ia/zeQ8h9/dtr6QB5YkyW4wlb/LbMgXb+DGIXPSllNl0IMsRQIcQDbcQm1bO/nlhb+2pjxiuaQrl
DbvxoDwPs7z3LunRxsg=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lmIhoX8hXuc7tNV1sXY1K2/gXL7Y7Hq73qQF7+x03UWWTRd3uhGmVQtOMVbhIW+66UkWUHiD26zL
fzqGor8bgSNGpSFyS11k4TwLQT4OfAMGO8C9Qmmh4+VENBnpS9TW+wHzCv8oUwht7xYtYRZvOvYK
F3fMppz2sBkUd1lciw98ZE/UmNkhqBuMfIYF43j45DEJ55PBhOZNg91Ls4v3qBHyBAaYPFFoMry3
d5Fw1PZyFQSEOSSpwgyds2aN0g6oIwl7zm0LJrM9VDAOxBUE50hk+oHr4jj8J8UhHQJnlEHm1Idm
rvxKygNKRvfSpa90NYxZJFYgqnrMYg+19+9aZA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VkyCjO2onoeZWEoYQ/4ue7X5mkHyTYVW9xjdoTsGS4GdP/Q64VaCZL/jr6R8DVDXPMnH7tRMrDpo
jpYBnyzSgOkfgqM+96ioC2fDyAaG4gYgGLmrBR6qK3/mxXwAZZX+GJ9R/eWXkc9h8xN+gsSSX6/M
jIQCgeT6q7PB4dWT6KY=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Iub91V+TnhVlZCSLu6iKmFjix71y6/l83OPTs8uewWvkE7WcqYxEKi9fonXEkzAtWzuKwEUqnOlN
VBsNJqPUdKcd22q523mrdt89mpdosWD+hvZdO7ELhJniY5u9h49FFkubpN2JiUTcIcKEYxVNlds4
wyvaYUqbPVH5v2ooJwDdimS4GVn9HerCOgPwfshvQDNlMTxLcYju4v8BHMc5Rub9Q/ihvpQU74v2
ouZ9XIwA+C6pBLwvaqS8jE7HXOokgqJilaX/W/t+KEgiFry/txRTMU9WMD7tCN7lcfjCydmS3Lq+
3u6Hsr0S8BwNjcaDpZDnBTygUJd4JSqREnk33w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
U46EWFmKmpZGaWfyL+dokyQtJtaOYsa7HCW/+fdtw9/yHKTWFpmqKBZngBj5rPkNhtTDDCJkqsYj
tUXg1j4tgIBaCQn9B0q/aG+B3gPLrudp9hLL25mVbsfiTzdekiV2hJMmhuMoavKKPJHC6zyW7kZi
80er82OQy8h+Df/fe6TRjH9xEt3/b80tRKUMbxkLfnnkAyyf1KfOhB6/uyI4mwXuQR+DsAbzybKR
YtXpOiW72tGrXTFlzcwbHamWZefqsilVpBw6V5dh33vYKGx50xwWpj76maAkpQrOpB7zufeldJe4
W1UOEN84AZdRTLkVSxamWo/wp8nP9fiGS/ItRw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qczgIJYpE/SzErzK7eWJBGcDFEzDLm8cKbwJbPXuM6YnJxx44W+E60R3war7K2QGFAkOoCDUtDC7
SghJGF32btaDLzeKm0tQ669sBtQmMIaBrlt7I9QBkNM8zN9GL92qxNC9o3UVWMOYy5BmH8nUPgcE
O6lRubeltlrTuDe7UJQ2nEPHcXjpUJJ8dxktyW+LovBy1OxW8g4GRAsmEJsoOEg0HuDdWcc4IshJ
PvwPJ7LblELAKsdkSt65y9VaklaEm7MlH4ImlgIa74TgRmutLUbWxM1QYhGE5rAzFhGU5i3RJOdx
L3N7GGGvLMW2z9NSHbIFX+/eNII9fNJ9nZbgLA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ti1NUgDv8YPk90APMwfu/mRr38QYwAxZfv0T6zQ89YS55t2EquEGVqrEafYX6rTydLOw8le1Oucv
f2oERpSSSTih/ScZneSZmuPE/Zh2BU1Ajv0j+/+0uEWXU+5lLPbDJjnapTmJXih1MYPf0SHpZZmE
BKj2IEBI9MPZlh6bxpa5BWJnyPdAvHf+UNaMXU9+pmbtrzUVebql4mFJu45Z3+ehmFY4FBW3zXMF
44C4TlHACLwL3vHVMCVfeKhgdVDbpE+/IFhTStz7mZ9h9RKGanQcs6YDVM1R+2RKA1QT1fX4FiQc
1V+FGmrm1ujxmFGXwpfNKByVlfCY0oWhRJCYYQ==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
HuEXFK0NXt09xU2yxxjng1OLsT+ZEM4EhqBgpr9D2ljw2vDaMBrqEsRQTc2B9soDq3ewDduHJXBd
OGYxkPnoN6LhjULtB2nTgjcH6NxA4puZ1ZNcndDndVBo8rTW5W1OqHq6InAG0CqPpTIkuqz3ECPl
EysI++MCDfH6tIzlekxJFIJ1McJsTq5rFuLzMMcrmkBxgcayDpOcCFuzZzCczxmt/cCCIKmDybwT
OQXmOcLJoYLP4sFu6R9c6xO8i6p++crv2N3eIxZHKbek9xBBZqQM9EYuEtsbkqAs9XZpa16i5njR
BDFxTKcP6r7JgFALJE89AZhBbate5JXWp0v4ECZD18aEL17CipwcWPutNMdG1apzSPP5y59n7rMG
yxBPz1gKHc3Emkl4WcO0hjICxqmO6dMXoY8JvBSf6ry2l0sH9Ihr3Bq5WWmlhPHnoaNr5jl//vNe
KfToWtn97eoVSt1LnmXXnSpdigbHr0UIg8AdkpdkuNRaWdVicDdgSo49

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
mokwst2bn6UxD6V9UdIgCIG1QQ/d0FiJqYGOTI2eHPV6YElaLjnJ8DnQmZnGS95o3x93FDOoa58C
RwYsX1fVoVtXkj1LuZq0k7q9vEe4T8xMjpkeYtIHY9k0Xhy1Lq/xRlfzGAf9fvf9e+f4r7aR/Sb/
uCZxxugG5niTwLENY1n3NthYL0jvo8Fmdw4Qg0nTCGWlVCws+09K0g9/lx6I9EcuHHemcHO3fOZG
lMc4NaPNozKwnyDMoWUkwiVxyFEPFaQLNYqzjvR+CqrWfhFLo96JWhL+eaDoNuZoBVYQtNH5ZwBL
BoO27Pw10lgcReGlZBz3BLO7T4ddynCx0+eSnw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PiP7AjOQqqouyQMoBQqgWIDhUSViq94rIvGiIJ/UKMDspM/yXw1caE8AhWHTjYckC4yLpPAz5P6s
1Z6flzDPrzVwg4e59X2cc4IMCHhedna0rDO804njcc6amRDTeLsMLTkWfvomB4xwszm2AgT+PRnB
WHd09ZUDVFjiBXT+Oa9AicgGJHrX3w823yBPuAa704kje/SzgtiDpcTU1eLmLhLW7LpEd9KIHd9s
ER7Uk9Orws0Kq9PMTqMX4hMn5K5mFakOeOURiEbUjdv5RiIJ2g/PlQXSItM8fHsBTQa6fOaJwQTI
vHwK3a8ZBHpfT1YH+n7wNiNUZwD4SFXm1QVx4g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ul5ZfTHJwMctaNhYRortUZizYMPYRef7uYqPSuMkxsArnxI/cjGh+KRMwzV86hyp/6TXSJIjm5ec
2wX2UONdPN+DOJ84jYC4JbgJQrPnTj7ioD8uLX/WlyPcQzyF5keqFgj5eR5s13FskVWCuAWf5m9w
mhFEKFjVXDAr7gVgAJh/hL8P6Psrnf+LGfiM8JhnDepsHEYykGlpD3fzru2BGgqHWqPqFMcnyVGl
vysaIXiJz/eYKvO8RGcgd3DJAM/wPm9A0m/DWcmSnczOgTjoqkHcBg2H5uJMLvufzmjImi6LYEqq
v04ESDEN31cSUzqUYcayvMFOnI/WNsWbFIa5+Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19808)
`pragma protect data_block
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
K6rOwNYTpqbPT79IN4QF4JQkgqtDdKeRY8u+dAc=
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
