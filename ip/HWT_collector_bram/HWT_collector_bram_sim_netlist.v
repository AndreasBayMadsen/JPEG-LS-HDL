// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Mon Mar  6 15:08:05 2023
// Host        : andreas-Huawei running 64-bit Ubuntu 22.04.2 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/andreas/Desktop/ProfileProject/JPEG-LS-HDL/ip/HWT_collector_bram/HWT_collector_bram_sim_netlist.v
// Design      : HWT_collector_bram
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "HWT_collector_bram,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module HWT_collector_bram
   (clka,
    wea,
    addra,
    dina,
    clkb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [6:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [79:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [6:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [79:0]doutb;

  wire [6:0]addra;
  wire [6:0]addrb;
  wire clka;
  wire [79:0]dina;
  wire [79:0]doutb;
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
  wire [79:0]NLW_U0_douta_UNCONNECTED;
  wire [6:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [6:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [79:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "7" *) 
  (* C_ADDRB_WIDTH = "7" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "1" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "1" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     10.11145 mW" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
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
  (* C_INIT_FILE = "HWT_collector_bram.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "100" *) 
  (* C_READ_DEPTH_B = "100" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "80" *) 
  (* C_READ_WIDTH_B = "80" *) 
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
  (* C_WRITE_DEPTH_A = "100" *) 
  (* C_WRITE_DEPTH_B = "100" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "READ_FIRST" *) 
  (* C_WRITE_WIDTH_A = "80" *) 
  (* C_WRITE_WIDTH_B = "80" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  HWT_collector_bram_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[79:0]),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[6:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[6:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[79:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 42992)
`pragma protect data_block
Mn2d2d2U7uQfg0JgxyOiMMJ8O7lFDFc1xNVG+afLe1jW3sTNOME9M/GZYM1JSwGdPko2+94pvKcO
4hpY0f1srv09GB/yzXxSl0ULUAjnnY6XtHgkpJKBQaFDL9Sb+vRLnWw51Uiixu1LpRKtkSMX8HjD
VdCrSba/rxP4yWHN9bXUh7J9ujY1UQ6rnuE8MlFzv5O4ufFgtKH3zhQVT3puEswFB/qnqzg6fBur
t0YLPhWqDDwmo/qiKaRVfSSktEVtL3cKJJ7dAY2NnNwyogqeDTdLOzbcEETVE2ZCudVU5a604wba
Q5LlRRO0CtMqDYE5u5tU7eoTVn5DkWZJ/WOBkYvm1GM3NoOsgeKhyTpQl6NdXbajG088SdPwxXrU
dSnDOLWUyrwxeuC9q5AwXOAwl1sTUzaI0sG0nTXgq3t6kTuC79+fRj98xagSFfWIK4/VxqH9uZjI
8OK8lOungrVZVTYgnl6+BPQucLNV52NlZZTeNI2CptattBT27O7++O6c2fU8r9SNstXaiGYdzKMA
ylFwXJLqmWPdB8qKE0fDOZmvLnypPzBhYV6euXhHMXHC4FsAxCx8ZyQeXC56E8K9mF9peF6o1gd0
a9t0sGQ0A46JqKQurVVkyJwsxWcj0WbmCIa5NUBF5H/jC5pns0CTHKTJvzzgoxcae1NymYW1+rci
3+5ebjRd8a7N4bPf9WXm8OMbbX+hw/j0c96e0BtG4G6Z9mStyQkZhiez9MP/grKvlGc7U0LkYDZJ
NIvD6piqXjIPBf2AA4dzNBr3VwoaYEzzQ8gTK4mqXb7T0IYnqkT7wZk/lLisl0AOvQObxwZnk9Vh
+rZfJag+VwTrvtpgogSPvI6DIkK0tsVDHByyOsOeW6AXi176pmMov6/zWGjZFZR4zEXiun+e/Sgg
AeIhKI/bUlkOJCojW39t15Eu8jSk2TwLrt/SNz12MLaVGLyJ5rNEbZJ8VKTc/dmTH5bt+xv0k0Oy
81Xu7aPrxL077LWc5/JhfYDBHMoACOtr/Z4jq2QdTx7egDKQuVEJ6BlMrT9JLOI6Msx0eyerJvvQ
iX9/OOqjv8pDamgq64hvWSW8azddaVFimmeECk7e2NAsE02GMZeLOyf/RCyJkFnCvUckkbSWP3cZ
UIVz8IxWcc9zoFZmJcD6oxgUaLI5y4PpRUYIhHr18UTp+hVCCmcHK6kdIXQf5733MIepq1ioGSXK
Yau6fVh3Qefpp6P8T/crrVwrMxC9hqhswzBSN3UsBdVvO4jAZ+kIkDlaU3af+6Lkm4iSWLOM9Bgl
C5itRmXK0NNeZ3xXaOLG51/aYBg0sL0yka4wsmX0KG0nhQD9MKUmtXSbEYIwTzD67CfzCcFiMHkt
7TV6PWZXzIkvNnnAUrghZmJWfJRBM9nApyXYsM2F1e6B9iZrhynX2MBNCS46B1uajQj0ZH6E7X9a
vqPfp7LrucleAeiltvRnWF0NbGkAeL3ZyK7IBXaD6IY6ObTN11P/JJtquizAidgd0d+at5hNYJqX
In+dqmvD5zjfeBByh1qDzAkUqtShRD4q5T2FPAnyEidCWFqIBEKLumYeu1ckpVMksIHwVpYrMxT3
CRD5SxEOkho+CmWiLp6mK2NrgC7PUJyHN4CgSZRO5IHQ407y1IEFo5gWqxg1SVkJnlsyXHl2gJv9
QpeE0jB1+F//gopeTA0JXFuTaHrumJ8Vru4E0JJrXxls0E9oPHG+y+f6WHXyXdz3yehdPVqmSanN
d7Dm7zv3leSD/oANF7Wzpl7wAkINUnAcqbT89ApwId7HRwdrVXRkkdk1TKoD/rAq5QQlRzauLBQe
mO784n4zh+zs58kEraZhPahqTfcREJwfDQbZQh7Y83w9uHcudAMxfZNYxqM4U5eNjt67o7RkOBRb
bU3dBCLAU5Orn5X3e57BMOl8ZReYIm4MGDbESU+jY7fcCy3/cMKybg3wsfbMbMrXdwtwdU41SejC
pz6gpBEUGdN3pSiLj5GlfFXqKr9IFM77O9Enc9RbJKSey0eh5xfWH/E4QpqKLGuzSZW8Ch+9wtSq
LomfAhWda1DLIT1xUE0ZwVORBYJT0z/ByE5lRxknYnDY9M9RU9qas4VL3pla99G/r1YuJrJm+gJK
GNj57XOIF0w2vkc5F1CZBJ9mhsk7dAs19lVArgN+z+67jfNeg5VpxyjqWMmhkG76Udf2s1qvOG3V
uQRXWpLhpP5qLRkLkZ8CTc9qaEGCqsclV+Sov4BVh+KhB8hWGNZOFMQUzBotOfcs/HdM9EWyjezy
ax+2LU7wQ8Wt85tc0Kwc3xrFHcHt+hm01ZWAyZ4Bae3mB2qKMhQBMykIufUIhwRQ+XB+0TkPHwUY
SQGHV374j7CYGWgeJMwSXquex9EFp4zi7yg8zZ+ZCXt6ON6Er0fF9jEmo7o9ZJWpuNZ6beI5zV9x
/sHXGWohRT6lH0DQ8EvewfWTPnkwdHxpbk1K9MeBW12hQOu9ALK/Djb0zspSMnlN/Hk65bwHvtrL
3sei6hnYLr9f56xcKyClx0td3gTMNE7fHSM//vrGN+eSlluCMTNFtlcDpwBANRIlRRCj8tpIHJVT
AbH0FX7pg6/hdD2Ajt5jQf+pbQfd/DKHUDa6z4EFJLigc167t8CgYbYazthuELKjtpmo6gYJQFP9
qE8rkESZYHxeKcbugnXk8GQ4dZNa5kGcGnEkdsydhXeaRuo4TGEvRzJl1jrmLt6/yk8eJeghnbdz
qS6/PtGbOtEdIHuMnbd1TnqoaGQ/z9Zbc8I/ZI6YXRzfvqZQcTA0s+Pn8umUI5NL+nXXYu8atJsV
DK23FGA+rlUE8CmeUtU7ELs6G/xyufO+DaSWAXHDVt4PBZk8T6GAb7sZ4O2lFu6XxH5DGFkFukkU
cmGShgZ+IFp3vJRZcF77VMEl/0OEp+niCYziXrFFKxjTfTj1oLgl1iLUmRaHZk3VDrWkm+/aZWX5
vBamv/Rj57HTl0Zz1QH6u9WWVkLbsZiaZbhbABXIQLxPEd9SZtSzix/ft9gNawuU8EBa2J3krUxj
gZcfPQtAyx9RfNIUUl7sq3hhJ2FByxpx2a1inptfgZo7nGDe1nHQuEbP7am8DIv8DFjldSjSAh5q
JVC0WdaDN7NhY3EmeWbAH6d6e6uN7ToNojMv+Cbstep4/hFj+rrVB1hwfh0FWQot70UoJhDw3fqL
JdP32Hu9JlNAxfQvu7cOvRCD6ZuZe3pLi0BE/HZ3svk1WwKjqWTrtbRji71UY7QzXO6ExJwme3Z2
wo25okEqHZ2k10rqohZ66mMg1RJMVOFG5TC99LPJ0qhBM06QLKaQRvNhj7Y/3vFAaTSdcTMakV24
QvTcXOPPuHZIAWJYmXIKPTf/MW4tpIhBFv9YgXbhGalhayR5B8nTyBx50fD+1f20KK0cG3Pxydsq
whv+ucOzkmj9LXIUf20NvEfDPnBUM+CPqKc1U5vkGL2nNW2o+WI06/3l8Tifv2FoxO8h5ScBLASq
5pTMJXo72xypj95oKdzCDi+4Z7j9Di6swYJCZHsc/BfI4Tw6Gwlb1dJlZFwoSz3UcT81Vdf0IexE
9+bejnimZCtSZ8xx52zdO7ttUkG/Y9Xbxs+5K6Xp9cyvzexREcASmDnSpIi4SnZOI29E52eX8DG1
knk1Blle8GDfIIA65PjeqMJU1ydi5TgX0kJ6xTZPDbyz2Wmnt+HdbEBJkFyPJZOucJJrfhGvbpJL
y7r+OUZQ5Jjl7tqwuJuyLhEdWpJFNpTDV9N5/oGhK4E0QT/ZL/LA5E1oBq++rJMj17Hva7nMcsJn
Ur0MGQQoI/AfhFuVrnIwOXWG1+8+xSiGmenDK32VbZtbM+3tKweztv+akKAJZzZoPFJTcRbJq8Bw
ppcXqWijjLrnx7eyjCuNyu6c07lOB1cC2XDoI1UNRkb/teIiqOb8BJH9yue2iRvAnYxo6IK00AiG
5b72LQKFF8FQI24JZEvFMsj/BtPOGWjzljLB+pRjYhcvLlBq1foXftavty4LMF0s8iM0Pgu+PUIU
GotGLgMLhfZtNxeobow+CNI4IEvzBw8qCeEmYKqsldTzXuw8dko/OU/GS0rsZ6dR7bbRx6GjSj5c
/plLandrAJf9qDeVRu3c4ozCKa0H4DPoiLFibkyVc9Ulry8swtCOpgyl6j93pBJG5g2FbsTkWgeC
C4AIls4zI7caJJ7zXEkSlmAq8hous/HcyTyibBm/2g1QLzP9wDiMSk1Gda1ZbOnjWC59IpFqpwJQ
R2qLNhikbEzdy6JAf/kdjvB/+7CeQcpIGcuehShihVQ90FytfjmNviY8wPRkctLGqHui969m4MBT
JKHUrJNA5nYTEZ6L3T5mZTdv6PVbZqnm2CKDibBB8anc74iRNi2mBYoK84Fm79C0sEss8VT119ex
P/V90kBPdrcSyWEeucIrVsMpQRIN3521rjNwRhdjOriVNW+bwh9qQ5Z3yBIEsOlapOc6BxnPm1Uj
fNrRE7HArJtzOpB3TzkozBwW60MOSKPvUzBPImO7qv3OiYayg3rkcME5z8cZz+iy5MFGzFy+EXXt
CAIWkDcqqOhl9/hTspx9PJmNBeM1/WVlUzq5Fztx/8BrF9yR7s9yXFDgWhVe0LR+1U6HbeXkAXY7
b7OHsYUJvK4BM3bgj6Sx/Vb6ySsXo/OyagO95Akb3T7asbCD+xwqnWhrKC4a0X86D8mUuuClW7E8
I1/wZNKsFmBGXkg0/qTza6my/r38KIupuEn+GGkqqsbKZT7UbVmPJfZ/5nypUuAZ4r82QU8ds1Mm
CIqA/p+FMJKURmnONRqjxgx2oBwqrUQTLHk5q9H8HePKjGJO2rOYXVKpEmSYECU9oU9/+rChViGk
oTXXevvP/kjQaE4pCW4p5NeytVg8G8OIojjIolxBOF2iKlGVe32K1Gfeav3MyiG+P+K+a+hUQ1CF
tjwlIsKWtd5ZEZXT0Jcfw6iwIaJdnimYhRCMXVPT/ATGhSZ0wZFwMIj6J6czNnAMrJUNfC3tSuuP
Np72FjnC0lzTSRFGcMSvYSa/HvjghrpwDPbqRR0rBSJho3b69Q6DCw+MIK0PvRkIYucvuA2F7RLX
mQjc1gXdiyso4B2eYnT+Cj+dKNeExR2qKCejO1PY2NfGSSl18ecssmCiZ8C/cowsWcl2g0YlGSLr
mlr1JMvyqAY2RE+D6ayq3AgubDphiw7yqpfVzvniuE6LtvmBFWMLyE1YK0juVmi4XVcyhbFizUuY
I7ogyXW9hxRz48Y0L5ShWL2OLjzN0g/7LUu1RQ7VZ37wz/mtx6IzyNdCSvonyh7JpSb+Gi+jtNOj
1HC5yWb3nkID9s3u6Gasbt0dX1R7j8egzX4eQJtQuiMsIV+JiRPiRoaXeT+OSB4N4ss0qvddfFrC
wEe7LUpkyVgRnH4OI3VnVbSMlY9hm6ggNqWUaq9ujSrAKp1aW0iZTLp0Yn1sHK3ri1kh6xGJV+WI
NQXIkwQEaOgg0GxpsYudWdbxeIsjbWAEgaiLRlyq+YC3L3gKOv9oQXWPQnVeTLD3jG9lwzvTAoPy
MxDxSq/Fb5SY/ve9s6v1x4HE6Ola1TNP2cG+za0lE+iUoLG1Y5J97DfIk/oiBZ5WKgJkdgiXjFxB
lZtEdCZ+pU12PzUAicA+bhsLXdV4ytdL9KF48CQDv8ZzPmhJPpDMvQxlbSc97TE/uAJzn2qmr/2d
u+yUG6nMwi/9FXbf/wJXifD3oyqqKNmdxztptgP30kiuBbVAi/lWWe52sSlvyeVmO6Cw+1vhJD8N
is6owYeWy26Wu0CceUwjWzVtAVcPuT1tpPxsmUCari6KDMJuflGpJ1AU8oSJ03hzcRF+o1gj+CKb
NhTPYKdT2oY+UsPmoQrD8xVtxd6wNu2aPZ1JpwQ9RBjStIhxJE+o2LpCp1o8K6IrWLELPHx19sDx
g/3odXZD9u33FAyNxCb7UiFRbMkFrNeJnAUoZpwFObcoBDSs55yPYJh1ebpwxoL488TK9POfwzp4
AThigguVP0D4i91VE2w7MSlsr03K2uhGV1/7AsnyVB6hKJky37vrezYpnH8/dQ+lNGl6j+OYUi9o
bI7/+tbXgNCf76Uqc49g5eg5keAe2dtCVJae2eFkO0QJkp22pqsobLMmlwGqz4lg9BFe6Y9QCgWg
opG+TRPZCsZ6MvzbmEqz60fWuSiertnT/HpBdYwqBe62iv/yCxP3Hs559XrLGgM+z2g0UgeBEAxM
Y9sMBkscfZeUG5TUUsrWe2sFmQSfwnVcfn5RwoPFmhIraFS1RKhA1XQsGBfATy4okukEdrY0mtr9
HCso1+wCBzGKjaFCK1vu4rJF7+qthQW8f74uqYMvgdACtKH0pTg+5c5jFmsT3URwn765GCIO5udw
nPijtNqCPahYcV6Z/WqoRyht63LIuRvDblrPXrceZCkudWCiwURHijBsixH0bFYeUbF46DSWGNZp
S45z6YR6/uUz0u5whasF4tQp8tdNmS/QVXHukft9u8D2DkPVxUQ9WA1/Rshk9Ryjo6k3sxbVxKnc
zd0N3tD6O6R6ziu8VBxQq1lZh5khYONipIGa//5KBav0eWVfb5d1QZDd7gBaj7e/MOVBluvLY56X
b90doznZHUxVR2PZb7if2y2Q0EHlO5s9jfFHbILVFeGQGKl5U/hVnorfTCcL9YZmRbVrcu7sHtNj
jxMw8dCz4HfHSACYd0Bd5sHD/PzWCVLlII2BAFDCeQnZY9MNshwtR59kmSr3vwlBWeI959IgcNjc
BXPMoBHqBLZ9PK0pmWwCwRE9nOdpa1L6WUUnyBpA8+WT2XXAbrgNQFnWArfSd2IMeZu9GUvfa7Qs
how/u+rNXrky0Z/OQHLz4TzrSHrU+uJFN2svMNR9xQvxUD/ryHoQgMdZfA5buXS3iWxsjO+eNsvr
04A+EUug5aLXz8+36M6Fs8Z8kmo38zAyFbKsILVc39RZ6X8OqxPEW69h37xsIRuXpTLD1aYRuG/n
UJ1v7GWjXz2gviViwZd5pai+BnW4zUqELbDNvsQsQvNpWOApaf0NdNDw6a+XkssmgwrQV1zTqvyE
HMSSI4KXU5/Fl+jYhCfxTBzKP05CD8UNf/DVeyTR6Lo8T82hHaEEraL4SNL2hmc5vClx+ueZClMD
Hfn28dSPXopbtLBEdUhV0K+CwMsoSAN2gDLaGnq71L0652aUOFJx8XBhLambmHHiAOaDZQI46/4d
WucZBKR825nV2rIxcGRin0PHkzTDWkrXtNEEdYtDDG44Vo7M3BbBaeBAlPHo2tSXFlIrDwJPuZQh
CMn2KRfB2eED8+7khif431D6xNhYmHjoCaD+ErduiELmd6iNzwTBNRA8oQlC3btS653+9FG2jGIQ
zNTdd+jkq6Svu63+WSdWH2CZgzu+Lsz7iMf2AuWPcWcWUrqQzIrhvwP62nyOaDNzAtnbBxhTC7g4
320LF2eMANxVXQxq44OzQMyOnBsZ8RsLNlp3s1ZaVGJ6ryD4g3Zcg7lthyFJNhCAIj+rP9BzTE+1
m8VZari32boJTWZskA4SKU3zMH/HEp0L00I+y/q56pKP/DqomU6IKTYfaWn8Z6zx25xEHvXV0VfD
Kev9zTbvj29obZxFIjsKq6SIgPDMK+WsUJeMgPw0eLnCFRXpmBayu6RlgcydvcDl5AjC26p6SWPr
ynStz3REDgE1n8x7OTTLQGMNyFzqDFrDYQ154lWsDHVHpI3zUmZvLdlR6Ww/Z+ULexx1EHc6Da9+
h1/l3WJws4/ldnQ8U3Pqk+iJsE7kQeR7R4i+a5aO4Meoyv7LnIpD1nBYLKNd7YM2vsT5HziE6srw
Or+ilzLtsqRH9kGJ/UzgOl7TmcqG3YgZ1ft2geTb4U7AKHFkAEFE+jZVzcJXj1Fd9QTvM3DF32mJ
1yo8s17Q1IG7npB+qfYQLlyGsDGk5gE+Kxxowmwt90bWb0CvpRlBHc6BSn4tX7ShQtSBcz5rjVYH
PCY32GSuaRqCzoLZmUTNBSWiYe3wjhK11VU5xOzjgE2huNDxliLPo8K9gLZKuGsn27qlUbGDsfEJ
aK3rmB4Ynk6vWeRD1dMbjLX3LRJwUafhh/41a/Bm6XjLF9t7oPhlIxHNdocuEGmkj9zJIbVCFZWv
2LKf/yw4tdiMHavFlo+KPI4YaT1E9JdDfWnJ87vbBKyRABJSxprSR660JhGXfl/wJUdKvR/JeJFA
0GDxwqBxS7RhhxzIB1AABcP9FsCXs3WdAbn8YRoMgPZxIgeBAM/FWOHKLdS3RbqMVV4kHQgPPR+U
75vAm6Cr9Ff25SRTSoW+hBKtH7yjn3XsTG3UX/ixXkmoYEZQhcy2EMasF/erRuhvpD2+OeicXgWT
kgW3MIwaZJWoqzxhRsjUjkOJOWUmMSHJhQ9dU+u8Y6J5TUSSJKZDeV8il2cgam3W9gUGhFoaL6Ph
90Ym8pCJZQwoZOiOEjFwjUIuNiJtmveghycaDtuDJuFJVtgpJDXUu7Uv/i6EpkaBKrMP8taXMxYp
dkBgNkqYQV+vtvntVtmBAeiPbDDkoaPDuoTVbuASAvJNDu4ygI9r/Z5Lqzg2npnV8WA/siCJ/EH5
73V3EFzzci8qLPnIc/V8cK4gkeQqEUHfOUQb48lzm4tg6l1p/Khl6B9B0Rh1h9ZbwDMaldAKbqLF
q3A3UkxpYFzlOIZlPm8fgt8mE+SdUYk37/AM5P9BWoLh0H9LDnKLUdAY2YOSrrhzR6JLoMb85aGE
InonWLYet7gDPEbTVlO8WVy1moLijlLB28k2nvvreiXk2Y2XgLET0pkdubu6qcv01QpvnUQfC/1F
R8mTv8LaFmyCfA+auLsnzeO85BBaGEb329UleoRb2ukcgH75xGCUpctBF1cBphjwAJ4apjKIVnP5
poM8GgLKkLWk5n2YUF59c5xxWU54TgXbFrk/9Yit+MKUeygEz5XqaqUEERYvY1ZsrxQxkbr4iwrh
7dnK6ZdXc7mNLW5TgxPUtdqkmyI739F3Vo3PN33HJ5i343UZAcDkw+1MjWb9zSSpapEW0xQTxii6
ScPTgRuar4vfJLNVmnw4OBpDLhNChJb15c/+rzmOCapMVFxiodxKoMHTMEzwqDcddfH9lCCgYTFF
DTnW39mEIXkohXbHwAGhfckP3cKouH7k6engeGhJ+LBFHZfucCMzIeu3Er0ru7VSFiXzeZ0x0i/O
gfg3WzIPwySlSBZlxTGBA3n2x7kQlbAtawP8wGVo0oJ7CE3Q7Mhki7JK/kqYIP8VJRHbPDZ5yvwx
cndU1a034f1n83yivlsFJlVq8cp4gj8L4Sfz+jEh/RyvXU4lqD57YxG498OVXVVby6F0jpSF+Rt4
7TbKXkpTwgfdFHiWax+LkVBMa7M1Q7zAmJlxWtosySu3Zymp82l7WHnGk6cOW8HN6iaF7lAYIAAY
s9pbu3knQCErbjoHcOBTFTNKylPlQqGRNGcIuBsXctjTwp69TDbyDvHK2AVdmq8C7wZ8UZdV2zDN
KehzE9K/uALFUorDHJcKkBXFBKUUjU1PZeBRgUVtVobuore+w5IfLG+wt+6BZ+QG1fkLanfVm26o
5Q2ya6zR+xbCg++YraBjBS+N/WT6W+kEzYwyU2JvYxYY01kTh+RiKO/yWe71Ja9kKYNchYZ562R8
MFt9GRbMopFARXFBy8O24BZWr0ZWJVF6MBCr+vJUpvWkxqastqswLXmv5xGid09VE+nQ5E52E4uv
AGblnnAr6RJmp38VjsAb7o96n/IQwBox3119ael2s9vPqaEGafKB9w8ZZV/eBOZis1zX97iSkn6O
w355RsuwJmQ9dbvULZDPQQPIbZOiQt95QS6TbKaeDQTaAVjLm/uyfdJMKQpvwBk1NHTLh1EH8o1R
93nP/XqPKuLAbkPIC3mOwjGr5yf6Wb0+D3r0ZL/t88jY319Y/G/M7aUnwnJ2ngd/nl1zwQbB++cY
WNDeGXnig8LD3byCKHveNO7gNtd50//vYBFOU9xunmwRC5ze7sqKHlsfTYSVIpzCcBS9bjg4PiTK
LFFRWEnRHMf+3r5Bnp15HKf3j9WFMW5yIdZY8101Z7K3jFupNgTORYryo5Of0mBw/HjAcaen8Nbw
rCR8rCI5mroS3E5z/4yI0jZaRGfUDWbkMqfo7I2m7IldVGYsoK/kABMoKJFI4N8RqUOsz1dC8uta
yiT8B4cGDmo7sYQNzp0kdfbML6oBwJeN2/jZCXUlCzjD8oJPk3w27KL/ABBmx0sHuYySKFyjg/HO
MbagKdf+RXnGOnnjPV7+ZNmbjxpwXTDTx50tdM8ZdXzj79THls6RjcCF9hu1NF1sRUs1QzqRFkzk
eAH8rFOVmIBRRc0mpD275ue/K3Wej6gMYZdY5pRblZEJYDfSmsfu/UZeoJx3tYRThOdbsFt8GMV2
maGzDGMOg/NnlN4e0zUiE2fUGYhDJ42iAHZ9vzYrc3Kezm9hVsPvFCdVvPWSY+ivhkMHkCoRxWeO
lkGjaHLWyKav5/weFE5eNBmfDxpmMSDpwTHPGtwf0Zmo9pxNk6OKIbz2Fh1rMZutw+kiKd8zEtJD
6kd5UrjE3HvBKndrUqIKf1S1YCwZb/h0Kbh2biQSq8yzdsQYWZkXu9MIgcjRGqvLkCbCGKtDzpp8
cf50uzVlrDuRYZMU9smJgoNBSXCBNreA2PHB+0BsP0k5YsuOfGc8IQUUfKrodgKg4VxKBC2+Fj1p
RTQ7GfAFbCPDBfex6DOQO47kqAzI71uBgUBTcnTk4Ahl8/mr2QDPEgISOavIpPxINcz2FvO8xeHY
hV8YJ7ZVuWGvW+fYtCWb+jX7sxmPcFX3wD9i1hwzS4qDMHJtHdfPm0g7GBP5yXRN8zyUP7pqfEbV
KcVv0b0wV7pzGTjz6ayRzJUdEUFaHg7W+ugP0SDh236ShDqeJg0NXNkrJsFPSIQmz9IHZsbguSbu
aax5CVkO8YwO7vKpFRM/7A/g5OiaiynUPCnwM3Tx8Rq+xUDyfJ94z4o0Ss9N0IdkBnDvdwbP9QLS
zAw0hNNVQEh0jXmW1/iSf8xjBvLqLFASHgbocQ+/UYL70mi1VuzPjKW1QGJYpAjrYj50Mtzaq+8W
4Hf0AFAYbjsALG3KRUxFwNZ83cQdfm6UnamiGRb2D/vjnC9qp9ihcLDQeoBks384RuTKl2kfLDCR
S8WVnjszVZW/L33aNujmYyW1aueA7p9VbTWmcb7uwSuoUrj9+1jMCLaw302DJFlB7adc/OyqVxvc
2dVGQHfLNJ/0Rm6I8eDSUIMRJhemeu9pjGla5iuVnAhf/yVVj6+qjtE5BGWPdDQ0JJdfa3M3bFII
1cr33DeUGlcF5kPIRDsqWPkYkB3kO6TYlcfiNLC4u8IgIbOgttTKz4meP7gmh3jX1w8AKHH1xcyM
q3Xq0VIR9nzUP89qTVdO76HsB6hcZ5Rer5LEAt1UIiRAO8rrd0NTNXOUSQ6Ydw0+1SOlESZhYcej
vfDILVVkVzThgYGSqTtVbKB8AS7QH5YpVlTOfZGDXh8aVcdfECt+1dDiPD7bOap7kmymrNbTyYDP
6PMJIwg/MKQrSFFDAUEv2dXsvRMurEikItVnD+J1Ooh/72mS5BNeyO3sWQgpZKHeR570LUm33BZr
aN4ipIpg1hNxwFU/0D1KW6BKkyg1gjp1cezATrMFOS+1+7YlvjEm0cJU7Hp1poj9uXZoqnXWq7Be
Px34PAkyvgz7zHYBVPBNZTLG8K86rS7Voox+sS1sBTrlOjjd8fdRWlvM2ld7aPFzpps8L4SJpiTJ
nPrw/XEKLKbPprHFUoqH/NjSOkUaAuUcG8INfr5Y9EK98OIr7YLwt6ayB1D3xroX2kt7P2eJjA2z
Yw/rnp/FM4wSoXyE9R/Q1nUUIpoREE9NpStqL+iTF7eN/8bQqenD59wNo0hiWU1Wocg0yV+XPYFu
WYzCoeh/YIN7km9pMjq9P1oKVkKlqLwiw3nAJ2Wb0JCqcmZx0GyPyfoavVQqDqoXqoAddq+siw0k
LxN4mLOpLBKb7DRFV6ThNAwY7yDjEa2J0lANBE3GTGPOXRcvvMDnhrgTi6lpeG1Y1NgiF5bdgtNx
q9dyFxVWosU8l3GvpGujbNbjObdd1eTn1jRXy4P4tLs1qifbUNsie82tvqMDqRgioIeRG+1hQhmy
y0tXMFkx6eQZq1nAtNcA8nR1Sp/mqQJTgFJZDVS9PeM7MYHl3bWGryncDbAXFSxhu9POaC6PMLlc
xdLDZRFl+1tbZ27C2NAWH93mayhPeBVr3k2vZ28+viPrPpZ4C+MZwAfTuAAbWge/C/tvRebMmAfp
5TPzQVJAHJ0EvuZ+BhfsUDbsh+D1Vzo7xat1T64WNwYcGTZlIqYCbPyi8awvq52wTk10RqtYKKLC
je2EbtfjbLqVOzNcoDCY0H9WarjhcPhovlOKpWfnAERXCEZvi3VtDT+RM1hfpgvJ88U0ZVeed+64
vJqNiYXJ8NKaeX39yPjvFJPo3adVBwk/4gp62qm66IDjXfr54LQx40t386FuE/VsD7irOFBjfJHJ
9Ah4ODxU5Molf21HTR10mJlMyfKATCb6wAX/8pxHfSIXNWiNu+LQy9XD3T9MPfKoDVra2cc+TWsH
iEcQ24uvhPRbw+0ihNWssvQgqL0o8EM3W6IWaic+u/kNBJQGsH37qWIcRGE9Wr3JK/uDdGfe3t3j
U7LfxshkNxrG2n56+8T+dbGRhj1PXE8ypoiNwcLfCYTF2BpYg06D4WiP+93qzsIorC2K6Oya1UuL
ACEWVoZFBr5qIduYZwU4pvSi3On6MhMyclqvhil2heGQfPlH2dl5NvF12erJP5qz/hzc7d+EFFvd
AqWOLxcEPiN8uVFso0Ocx95kG7i+Zqe3yGuGT28cnyYlODjShMeL7uR4AmBXkHQEUIls2AiHo40E
p2IptRyJsiCry51ACW/yFajjXmDnfruYdmGaHHq0/VIQE6vqDCuyAwjDAK1czksONKtG5sIuY4m2
2CcFTbBpuxC6tDa7FKoP6k5N/Cqj1OGj5qiGW2EPo8mB9bR7ypZoszEuE/chMlsBK7l1bj4svcI1
BUqLcLkA8BaOIuZxhKrwzdi8zkFnRoFFz3MzOzipNaAzs+D6dMST46uyC+efXOkxcMz/b40r/9On
yhtdCN6Bka1lvM17iVfnAdPz/h97z6tnKdZdwnqpwo+fYhKgDIVdtHLBNHUFPpVyVpaJvrHVToYM
AjBqgPQF3YX/mgMR8f3hMT49tK8vkQ7tbhGBjVGrVy5kXAYEyE4tEjiGiVhiw6O8ZssmwXeGceLF
de9F39HwnGxsTQJcmdIXNA2khZQU2LWwGoHbPDxody/ZMCRhNPm/lCJkRsgQ1owgCVg3WGcbtoLC
0Qk9QSOO3jDd5PTrldXw+S/VEmvqvSTY0XHYxLGr6k8rLkwfoPTfFt3n/bXscFCC/BDMtqmyBuCG
G2do6Tjxpz4N5mQT4l1XnwHmlKHSkxlCCXiWKqJkgof2vBRCT7ZYB+cB/x0KahyQC5A4jdm4jkA7
Piv00EEZU3cSG4SoyD4dx1whf14NsT+eQE+3yj3kiSEa5FPBFKso11Ex33kfSrhMyXzD+baeZkfr
aj9CxEtjetXktrK09WTGx3KoGy8cjSypiaYFul63LhAii7S8MMgB3O5yGfcegaoFZAzZN86icY4v
ntetYBqLjeT2lnjFx02qFDaLgATUL0FSmXei7pGyDYRqjJ1Xz100XrdGZ6u+bp6iA54Lq5K6cZXG
00rntkQnloM7NVYs5O6iit0nCnvbaQBEpuiJeYdOtfbb/irpN22Jl2a2Iqd0nbwXGNIX4StX1E4J
ste0t4ZKrz13TTcdiGyili26VYrbP5O/N73Dbg/LBFR9vX74Jc/ISUi3LNdzZ4ycZ1fBKkxMpmo4
z8m4uWCbS/AZA7wFkjkLlrni2D9c5K9Tp5gmuiJWCk/rOy6nosBPz0qhVEdlhw+j82IodC6Y+rQD
mXuUsIuJXZvdJe1uO83OzslBlPHe+hTKsdJFoRUPpTtvbBFcFoVBN/u6/rZANHbZ3vhgoRk0+eiF
yFCfxnL1Gr7lJ/H3dpfiVrzsW09APbaOuB7DnbTVGKRcmiXiw3Q9JQugAP5ODnXTfTwnN6xUyT67
LfdPTTZuU53FxLVQY6xPg4jttf04bC5fOebak6mFv5N5BoGtmyBMwYL00G3rV8zZhcbRJFoEc447
JwELU/fTUK6EAr7UVp2FoUmk8KDR4Jdm17sb1GWeyZBxEd9H03ADCKY6hcU7hjnl42STEKWv/PFv
s55tBDXMs/JckHkR06Oxlzl1WYqzryCm4sa3VsysprVVURy1UoNgpW06zWwah23UoF3Ie+bM7zaQ
VlnciCiGgugjLFWNk+yzwkjeqWogVZZ1/vnInknYGCFM3uIIpS+J9L8tU1PJb5XvNmpvQaHWBoU8
3liCnziTPiloebecNJxU9FL8Ovn3qInF+bqBzUmGOAd8q6VeCXeei9wki5oEjPiM6rfuZ1yUTDzO
sqcboFDS0OKGCwG77NYcFvh5i7mHQJUcfqCrAx0Pq0tTM/ECbPMmdhpJBytLl0jhSMdnV2aqqPNT
Kai+OEMXZ2GINHBCuM+juAdABxKOTkkK0As6KD8CWqqa0yiuW+f01ctgXNnaYczbv5g4M7GMm2G4
As6ykP/EXkBucpWpZSYSF0xBlHd/ZCkMToOVFy2rrYSyvXD149sMuRk9yfvq6fwTAy8AYmm5PZBc
1YzOIhH6Lae5xhe6B2vjBrhWspAko/HMS4/ecVh8Rs0+QUnt/0KvvwBw5tTl1F/eBgVVgwZhruvq
UGS/E+4vOBNY0jpvH/suG0zYNDhcb+Szs/6Yy+g5qiQ+x6fVuJlCgFPKdpi5PdMQxZ4xTYuoF47u
wzou8a3Sj3bfr9KwoDSpkYH5D9WMQre3pnRQn3P7MDJ+nS8aM1P7ZpBB9m8dHchiz8Wom3TPJscV
3drtjAPUaVDNpXF6w4SM1sEOPuHcCjKPThbT0wN5ZAvdjcGJmoaowQbtZdQd1oLZvG+/u1lKl0E2
ILKguN1KjhND9DabIcfQiSd3JeTBVyiObI2lafTcn6cXTWM+uOIy7Qvp8SKNS8caFQ6CAR0GRfXw
H6FYgWxYPWEL8q7fmL7HlGsDRHKPbfqlGDuAVBfFZacKY8y1+jUIiTRCqfGVi9YT/pbdBKWVV4ol
YOBcNwGF+beMFYRGavHdlwJ895aJuLxhh33Y2q55Jf7b3qmm32NJmqfUh4CUZTWwIZ9WDXcVRcag
KcjsX5VpxgZ3BNqzG0cc05qO/HHW8pNUYY3XdufUeYsZrPQfFrmJT3T4yjnceRe1350ujD1Mnmlv
ivGevOynzHfQty6wGw2EIlI4eOFoYFKXsx7zf1Ji36R+EZXD4uZeAXOpuonh7iyG7xltX7TQ5dYX
NTjTLxQr7g0q5OkpV9fI0Ffgsmo4R5hgHAd/Q+ciAdazJ3RCvLlSCOHfKnVMK0dQrXqmkYdp09US
1APGleLwGkvXpyVnanoRQ6GXZTPxUxsUsCw4qk9v/FoY/9KeVH7iwihBbpX1fwMvnwuGnoSLXFTN
miOhi6/0yRypQ641dWiurfiThqZ2XFc9q+2Kp94ZnHg7bg2Aj/ySrbLil1RTLRM/tEuICc5DROM0
mZHvVNSVu9AGJh/tnFDy0LQMXZPDGb4J92qAQ+pN5QsZgUF1UlZ8bVciFxPqIvV8Nax7DQozL1uy
fB7tNGvq1H0r61vAeXb6tlCLs0Q6IX0DtLJ9+UW8iMhviJmsbhDT8i4pu2K6w9V3Ktz30agQTal+
nRs6OxraJMVDxiBr1CnTy3uq8JKCTkEVe7bhfVvtG7KJ07rsVtrvFUr/qBIMI8GDapEiuQTaADDn
9RgUZ0NGzwLqul3CEmOUmFvN3T5rx7mKBIPKizj8gYx7zjBnqveBeDPSNzcJHWNcLe7vOjqcS6zb
jyHqn6vb4j6s2ezAOBy452HNPoDXX5DhMVSux5fGJtDTJ+spcDNKLy4+N4zOLQJCqLUDRHeX+3MB
REetQzDEJzqwn4ZusXcRFJGjI80oEZoxQtrBjsZkwbcFUOg1VJYcckNKnu/pCVYTmwSKTK1fPj7x
mDjrdi5ZlQU1NkxnVVc26suQlvzVwKxudjEWrFZh/e987rxFUWXDYfHP2xqoT7eDFSbJHlLgv5sT
LMEv9uIheJPB8bO/ZEAOkkdwC9BAUJHIVwJ4+odks4bhrjT+GkREjZd/LUDu9xNhxIMzR9cf5/n7
KPWEa+fLrdCpHJ49T2c1dDO2gkun86LNso4kRSUbgtYFzVxrYxMkyosBNTmS+ZaMIN2qk7ko6gx0
aMALLvx1sblvG2DIAY4tgH6HW7+m8yyxWC/BHUNZo2Yp6WZzu76w+LmSQf8eE19Hahkiz4mLifvT
7pbfnt3UCjv5zDVS/Xs0OuVfV4q9u/08LQd92yPoJQ9mW6gIN0jK+cdmQNgaRzq2K0G8tV5+6iUu
DIkcsQIR0qH7xISZ/PC6Fzey5Wo7o3S+oWadkec6tqvnOESGese4voovjYvxzrFsqhix4iBYsFpC
pgG6fiPMpO22C9cWHW29TINEjQ9quqL2s4Eq5sCZWh38cdezC7qMoBWP7HqJFIKYsP20xWJGZ3nW
OD+mSLIYRxUgdzLXilMuVgvdaxuQGAKn1PEL8+JW/ncv0pHgazUle6MOLbi/An/CmB6WHb1YbvhL
ZPu12I0ngqAxTwxjOKSJLrPSPaMoi/N0x10YUGJQRvM9FW8y9ASbjnNAT6b/6BFc8SktEvtfYbVK
5Eu8e76LBd1A6g6oD2gFJ+CzBjYfDukvtE2h8IsCnhnGyhLAY/JGBx8BPzKQbywJTc7A0jM/jw3d
uCfrLdhFViCUsufOVIuXRkA1xOStj5wwoV8U/wdcEt5Ykkxy3qTrm4mde67eGj9q2mkp+fo9nbkV
wCKqW+8BPcIN3hVEZj+Hgoy0psxht4UGF1QN6y7LcVewh2fXlkjMmkx75RxoNxYkugPCQNoADYwi
0HwABfT790aAtgn2WCCXX336F8V82E6RkprbJYfpMogCyRbWSLevikb9xHF/5tyq0ARTmm8eh1/e
aUk97sBPLQg5/7/qHzBlMJurrKjENdQ81GWVLRNc5TkRnZH4UhuTdi/slg/tJnk8x1Mbp8YUNelH
68vkzvVGRvLdIWVVtTj1oZSitCLiWkZdLpOw9wwRqiaHc57GLoXLjKqRgxSdidUM23xPat5fSfjo
/JSvzJkxXkTir5GGJ9ZCNqzJ+a2aSIiNEwjnCz0IFQA3HOavLhRtlG+ZN5+Q44pWmdLsXChP1C7s
6szs/yPN43IssazHcIT8Vnn/5D7dOBa0NzCRmKjtLAPPXtoF/bd1hkL1iDTbXkveypeDIgSBqIKP
j8O1xSJzHPlBKxdj62SQhPpUYBlIvrNOdpvvVp9laGmikgpVikBDtkf4JO8TNqfYy3z7rPKn8qnr
Tbp/YEDW8FnA5MEhv63vm/4j/rO8z9WLLTIMd+LSVvkq1QOtCFDkCgASZv9UjjwqamMtuiGDkU24
qzKCsfv9WUxD4Pu7/txR/Awh2uFSP0NrVqapnXQy2W/k0Mbi1e3eF9ZC5++2RUO8eskGhU6N2efU
t9Mej/NfdYaEhOj9DgeoVMmOYX+dvrp/gSR4FAZggIkylNNM55k+HB9nyLYEJIjMzF/gbnGLUl9w
cNcJPi3uM1mt/1Ybme4fd2Y5xJyEgxJRDEGyJ4Y+zaanfzi4G9WJ/HSXVpygQ9iWunK0e+sHuEVY
ZoKcm+9m3yxRdBWFnFJ+u5gGQxMu39OgugSv15Dq2SP28HrK628G8EHHh5hZNcChDOuzn39uRB3e
zaBxjoEQY+pYKoyIsFgVhJfeXiYTWGscO9EUlAnUigF1CxRTw7NDz8qgowT0OFYqLWiRoULOZX0C
ELKUOFd7Bw6gpWulfy0uB+k5u/VqQX5ofR/DZPCsPaaQ0xuGq+oPFNHr9FzBtKPfKXLUyOnkRaRk
yqcHFAFgU30wPabXvalAqQI0meH2+vui5GrQjMNLZ9ZffD+RUnOo0RKDgyWo4PJ8bCsk4Fvgax4p
p4r/uLq/jeIGwjMFmsEF9yg0stYpfBib/xprc8dVgZY4gaQCaY0L/Kd8mQb8mejtdt34uusUjXI8
v7m2Jn+a4GrmDiptFHaEc40yQWwRvBjrbQDC9MB+RYZiYUyvRq3KV3AG49gB+wQ2CxtBrU0/uchO
HIVddbH2XaOuJ+07Q1cdcHDDFstoa6+5JAF8jIzl3HA6YzUp/VbNWIyADT9I4uIV8sHavXDJGLlN
4PxgngEMVO7YokJdMmFyWbUIjxKdcNx50Q14EDSVjvNxymfGYXWRDC3e35gP044Azz26hBNuKJ/y
MEk5KHQ4PnJBq1YovpW8b3QVSwDnFiHFtSea6jUJHvfXO1cmxIIjo7jP00vMZ70adrf9uCRHLAK9
CbwRx57uQX8jTPaSKTUepftKxUCy3GyH3ueUxkSreUbbhgRpt/QpS0KQi4rOrT15CHmrwWBb1iop
MQNyzg/p8XEBGcXoX5aZY7EnQCZ5K1wXV2Ujpk6hAzaciNn1yFzhcogAGJZDg7/y91QPgluX5qNR
qUeLAoj1gxGEYBgWX/v8GJ1GhY6yzD8lZpvnXK8gHZQ+00CUDRxz+xf7o4OLdOimIDSP7D1beXoS
DzVdmMu8rp6OwicnpWCFeJ//WngWozsogq7ZNfxCLHqWunV8aOEMG7VH+jLOQoDgKk6MkwJety1A
Facg6l3ybGUKgAVvM3riJ6HhZTzFzBLyZdwIuzW1VRN/SXeVP1g3Bem73CgZaf7MOo5lPcryGqdG
M1NG3OWTR1OtS9U2fa08QiRM0kW9ZcZ0GoVdU+0a18j2cp6mLVcwvRtlSfAW/Tt2GZdlnljqUdmK
vG/4buxbhey5eMd1QQpqtfIRajMbz2es2L1PPIpQ+I3t7Kn0MqUQJ9hS0xEH/jzAXO+iauv77ZmM
iXdJ5VOWPWNwH+hT6/DYphNDSMc38yRojP/GJb6S5OnH3+J/7HkQkrlfSY/gTauEoZI2Nw7951TB
u29EsUZZ4cPbdhcWIrHU7807DRmOh5GJMHCFkSRQW1oYQ27+xtbQXpeuRxDrbOvZv+qgRfI1i3Yc
HnuWnmADa9KS5NZKE/RL8wBD273eKQrvUWVaAwgOo8svsrtj9L+4CTzhgOCzWhG92JYOiLuRJJVk
kd1MiAEfZXAOl6a6ap5JGYpMndRIyjPMQXedbjS9UBqbE1OxACC0cwVCbS6q5JkMJMyP0os6vAGO
OwYFjuR4/Hi0pvatwKMCZHEE4QLj4pelpfTzAKJpdzc29GG11X8FVBNvGroAcuFuKGOGGzXfwByk
ShFwNYVA1hcwyJLHkwpQnSiLQ9tuP3bqjYxU+ygLFlcBZaOfLd4+5VZDbqGJRmkZB/CPmTFlTwlx
RPryrS0Ox5yBrXcaxIsuFlJKTe8TmYbGISouqeqa74rKp1Fid+C7XVCN77L3ozCAXCbUOgnD3dD8
AcW5W1mkvvCuNIeyHXjEQ5KkYAy9nZGTrXpAOvOapZOpmkOSBWU8pFXh/ABDRIpvZopilYaMd2hX
ERAED9djvIGnRvsZVTtWR3dvFhgQoTEyaWOcF+QdqX9Q/leoMBxrAdc24vQqTruKeqsOVeXLu5aP
Z1FmQjJb9bhhNTr2qoSMyS45EI158E8Zi+/7lgFBbl0Ne4T8brNBVnz0Ubz1l4tbH9i2nyEwDwcB
ta7vmFtsdmxzPbkTOSI5pQ5OeoOnxVi7HUCFk1XF6e9zNUWuwV6b/v5QGflU7G6SrQVFvI+SWrEJ
HLcfQKUl6MpEvCF2li2o/sTxuyagP3aAWCL74dHvWmhOg9YNjMW4+YYZwwdnAFaodGSBPkDhtjGm
sSmPUbYkLBVE9HpHjSdHi1Dv2B+Ty3iEn2cI4hc+riQx0PlbR0yuGwXYM+p/U+8iwg6werZSK2YV
4AW5tM/StQG5vHPwoQx3GH9dvnG7eOurtCllB65PdChPlGJKfA7TyB044YYdJd6kMd8oh5tv5K7w
9EzQkyQvmXi6c5la+AsDnjHEYOAZV9rwXJHxtV5/LZEgXfOu3TDhGtkH7SAl2lvmt8I0TBMe6OVi
/XwPmtuzyIaJe/oqFbDJOq59SFPNgscTjtXLxk6Mlt3u1m1fG6CKMmhWx/94UjRYyt3p28yTZSRj
4aqHwKQBRTvw0CPMb238Su23kyhdRKJaUd16USP2btrN1fgeV6Enq0uNzwcpz3OiMFovgdBo8Vcf
qXgVnJ9eYmIwCV/kVQfAeSE+ki4+dh4P6lAbQwVrPLOk1DKHTY2KLWm8NfuPopp8nsgBBKpPJm8A
CnI3lgZVOGD3W7NQVozCJMApOI6mo7I1f9O2YgoKzamO+AkgVrRpnVgu3kc4qaFdNeXhT8aEZtAE
rkPY01da+77nBFSNmEB1q/hk6YoKppub8jP8qv8KY9QcynpJftNXOXkVHikt1adLlfYjb2cuaYE4
XpnoRTWaEecVihn/8LujyveN0WL6jYPmPF3rakV3cEm3PcFG4cqTRxdQJE0baxkdD4e6FFjkxv1K
yOU3DnvEtfkvAmaKBL5R0fnV4zvHq7eeVAEb+LLlYAjgocg4trVhChb16W0DLIjdnKMHVh1Qa1PQ
waa/71BOW1ztVJbP3IMW9R6+Kv0HKbLJ+JkJTG6R0qKMDecqawSbxLQ33JtBjuBFkbpEw6gqS58m
s5gFfQ160oXOl6gyX1CYxJn8+iT8nxQjGLNZW4ObHYMBeaOTRNF9rtkhnWZ8jTi2dTuHdUhr7Q7B
C2jKdDFsIwx/2BGRjBDtdwCoO7ZsMUmv/7f9Qr6JkWvrFFk5MTQkAbfAY4ycqMGXJ1V9bnWKlZuH
fjPOI1QSHF7se6eAYX8T4ZytXH0t6zCHjSiusOwePXm5IAnhyK3j7B+yRvoH6pVx+A/SGZf/7RV6
89wNSN4Ra4Y+Dla1LgJ+rNBbC+OQRm3qC4htjVS326B+du9S9xSmu6DjSt01Q3ejBRQUQH2zqWzr
KJoBD6rqAM4JYJ5ho26ljyWlT0pl/Q4eeMhN6Ewu6XOmo6ZF6DfWb3+FGpmwwPo6yGMrWrCOmAO/
x2BLRRYhAl3M7lsBQ4iGoRm9HKYl5B+2w7ne9/ghioyEhQyCAcEVe4i8m7fFMHW+oAhjdO7q6jfK
EgK7sKi7LOCSQujB93GhZOkIgme9fuokZOpr/kNoJZy0Sf4/9+FfFBACEwo5Tu55MeNyzmlJeE5X
0WXewZV+yBPoFKPHKX53qnnB/SKYc6SBDU1ymYFZtmo8V3Bl2iuAO1gIbJCG6M/lyeq7ttC8+a4E
2r0bzHYnAfjStzVx2dcNHOi+px7TUfUf+X0+msDLYyn6XFEmxq88Jx3xP8GXzTENQXxEOVJhIQ+g
yTCP3AxRg92MYHqG3JdDIcBV7EUMlCWXYE8A0fU4oxVYy5xyVfh6h9iJG/bJ7FmPTrU5yxxcCaXf
3zyoHKuk1/3cS7ee+ig1AYEeqRsWObekVqpnceDi2zN4lNIlQ23fr0ZBFWtj0Jf1aqzKM57gvo3S
l1ueOMxgIkjnwMoaFLiuj6dArtBsvma04v87vSAtufKtwAeqUQms6ggZqjjBqpfQYZm8mqv4YCwl
Z+biMFgOaiM+i/V8bsrHKmUL0Ue8KA3aSAVds6lqqBS1AVwVLiODkXSyHu2xkbeFtU04SKWLg3iZ
bz69uzixzdpLfq0WfRfxwUwWEO+zlXfkxkgRRD26WjVM15TTX1j9vTVvMeckyqSFF/8bCQQ6idts
UVfBwqQ08/QpAUWw/1+F+0JQsmi9zVRzwIwAo4IAKAPF7VuGPQGiUg4r4vmrM3oqCXZ05oTKj8mL
SwiVYEVO/Xjza+enpAAXAUHb9AlwOh4nWKKqrFF+d0HFCaPJ0mverGQ5/Xof/SYDmNbp0dEGqlok
J2Zrq3dCRQG5Cm5SPOgMca+HTuD3Y9zt5Hszxynwkzp+mHBa5JZGRLOEm5BjXzZLtS7sUW9Ms6Da
8+auwHgzK0gHMY12ojRZO4mgK0ekjoMLB4ga44YiUvvL01kWNotuYYXdd/mjDkLBI5G7S8/SeHQC
NbwTTnkz4PSgFq30gT4Jh2C46xtGTe+6uSyb3v4m/AnRb9Z8FW3+h6MkbH1JETRXEc66N8mcjWFs
nRtkt78FzxbKGi7IvPg+5IxohrHO1HGnVbi8yijr/ypRQROyghvMDwnARcon4ZaH+RskeRknMFvW
q+fEJPVDEsUwwrEE80wF3VUKwfzj/OaV61E83RnNv48AkEKCtedSj68Lymjdfs3pwLyyRm40DKSX
QJsTDXMUrtYUSamG/fvqzRd3AxIP7DIPGB7LRBb/NOr+2kJ00jyYXKH8xKjovAi8g6phAghBce7Q
435VMsxyHFdI720B5zqcAFHQU+FNpmhka4CnfazX0+GNByiyLnf4vrkVHOTDbPXNpnk6OjfULTHj
FPKLKRTKHpjxQO9JPYq9oy/ojxy4BfuAYZwwzNapvKBleZjwivf/SF48HIcizq8f7JHmTTnZEVuD
t8cVi4Qjqin1jK6SXRQCeIKNeqF6BeGPadfzVWUNoTVW0ka4hlpJ+uuDxeHzm6dLs8s+k0m66pHk
fnMFpCUBTww0wZeZD26M3jmE5W1XZ1x0VrgFZwvszGAh0okuUpribqYeQ9L7gIenxFOX6qtgVWkv
NnpSXOpPBkzTTWYSO8fkSVsV/xD7C68OMybdy1O0uGVnXt0rVBqfeLtsR26kWcUgIANu06ifk4b8
GC4flmrnnIOgeUiwKAevqEXlh0jkhx8YBGomz87OyI1FI3IszanJ74YSHlbFlCYsqFsXFIzYpPRi
QdRWbg9OPl4fBNp94P+rZKIds7IS91GMDUSuo5PrwyiJdPDsGUBk5jytKgd0LqsO94wC1qbK2aMk
royZfrUR1arvMhc4WMuUwVvPj6YF7trQfaF+gt48p1gDH5krKFEc8P4JxDmOVStn/gV/93u/IAiB
Ma9Fbp7YvmNsKaDkDZfY2sBm7lxfpnzSQ5PLMG/1jzGXngozx/vwdEKBM49DCGxo0W4sZY46ivBr
llWNkwVSnHzoQumuZQ2udMtXSH4sHUCL/s2bgao5RrShYnhyNmr1UFQ2DCK/bzB7DGfYErjWlcei
51ptwuQSGwwhTKMLoqRTMkjTib5I/FZ/xR8DZcF3qA+zOjbQFD6yH26rAvVDm75d6rSl1agoEb1T
fMgpQjO1gR/SCRHWI3OLyQZxQXa19pffBBR3obAWZ+WXNdXI4D0epR/VT/PRq1ThuWi5+/+5S1Yh
9lHObhEuYNdAksIuEXj/RY3koTWlygl9f39ydPzWQYkqFPmBnzT4AzVeLDU3oVBrChnE4QaYJC3X
gy4gNLKlJfJcBqTQ4RHtUDvLOcRO3k3ikg8fWLBma46GhtWp+tQwrhGgw8ab/CX+SLhkyIn/mdAw
X7KlkCuH0H3GLKjw16sK2ap0MfrSIlnq2FALYIi2F+6MuN1/PfONtfTCqTcFeIvQJHbNX/Si1NZ5
1/1u3XmrqoDduEdIclUQe4Gn9aYpYYO89pzGPJalAhar5MQfaL9jEPsR3apGSuQu3nGZW7jHdR1u
n0b0RNK5BAWrQ9OrIaIOU56z+AGH2fpKxXwvc99162AV6pCMbf4/6ynYkF7+GvbIcsP3Jo0v0ivz
/BQROIOzOr5qwmn17QNcPGQLDdYugqwgwVdvcBLep4XOvY8h3U3TCtluPU7mn3EhrovurV9a2Kjo
JGIFCs1yBO1urQCLfN1vrT7eaBSxmQnfOIZD8j2Lef8cLupoFHuxRxMfBA5jmucz6y/T4TMOPCXo
axKxFjYKAc2bIBLYwnKyQBHeojiQNj+oez2/Xuw3b4YDl303J/G5LU0S9uT5dyMpuCdjcLFtHBMq
Z9ZnATeqtJShgpjI6l1bc19v3p6tQTiSOoAUdTJXRGzpjq79XY6QzxXsXiiy/OwdDmsbmIFcW2kk
IWMGIYiF4jz0/AFMRZMa8aJaaZ5Q0eHI13inUS8PlK0/2g1VbocKBA+tSexjG1EDMWd7inS4uIPT
E+H+AdgdCMCmfnYzlrweIrMLvDRauyJbZ6wrWZtI0X5QY+dB1dIvHi4Y8uvd5Pspq1/flORclBdv
7qbYU/jguETrPeX2llb9fRDK0uNRQ7LQGrli0+4uhu3R/oxh/AWYMCCQrqwZrFb/rFtYPjphN8CI
tHiOjrATq876hS8i5g8dE890oD6Y7sag+mOyaJCiBn3o39yEe9TiwkerTY94QDft7MPZy3WISXgm
Fy3Qrv09cwolpB2bFHA2eXnZVum51+Ep6hFhZCBpdnFpADJOj4n/6DLqod85o49bx4PS9sCpnBpT
4ccWaFT0F9aapG4/DRgqCvFoqXnCoU7rPducWoFbOIKvw01bvMLg9kYxvtznWhEiDxOnx2CyKtHo
iQCDzKJgUhon2N5P90ltOnfp9ryCSQXhGVTQA3dRr3fn3sMDoTvcHWXwR1DGkZMwUkSCbytKrapk
aSpyJ5Ul/Ilke4QN1Rdkb/ybSoXlo2BkzprPAl3f1TUNl7gvkMxjqKMvel6S1lfnf7sCOp7WMu8d
+q+stSHZr9GCTrT52rKsv4rVxhpE18+SD4+y6sGFtiyLjGBkgeS89YypvlRzRbbGrJYpsnVzxPxC
9fOB8MSMgRAkSJ9D8sPA5GRlrkuzynu6fvK4yvItaHQh8bVoLtzK9eGa7w+rU6ThaVQyq+zgHuM9
gzEhnUO1eQ+E/lqf03zS5S43oqI5oaYboD/px3ES174N0UU0Dibya1rjxJrjs4ri7ra88d4zWYkB
P9QNSJ7vgYowjtbRhHb/9E1Mm3GJxzqSH6Xhp/KKJmsTu9mOgRV0LedTVL5fD0WRelhjYZTSw39y
4FPSBG4i/z/pj3HEQck0HDfjbNU2zZ3mNB51ww8RvID0DEkDvnBHJrgDR2bqp9AK57rUrib6GFjk
j1ij/9483tFlxxHOd7/beOz2rY2M7wg8aQgBQ4V8vaQMKXLN+jAWXK4m80IHChSf6hCYzfRALpB1
/p1PSDQXWItcN8nqKfYV/mLg1pF5XT2LO4oUvIYgvZ8BCc+z+OhtcZNrhwzlimF7N7J8uGDZmr55
0UUWdqdDoa6PqNU4x5Wk3KSDQM/85TXkYLjoFifuNwHFY3ttGJ5/IbH0kVATUcwdyjOWRrFk3lua
khx2aLoUar1fRxHgcF5w1BeE4u4Zg4r6xxX11KEMMnBkaM2oUn84OyLnRT+WyRZOOgKVnPgMzkDH
/be3/q0KMGF70ELTbPt/wgDSrVaaAkhEP78V+v+IF2PDhDDQii3r3I7+JLaVL8/jFwDDF+DaGOUg
m9V7/4QAPHlRrph2vsrMTYPb/a6YNM/Di9/dAlNrpJNnTntcN3wwE3l5VO4MpwUl3tK+7QjlHx+Z
CvPaRRW6HApI0Crubrl390bi81vPRHGJ8S+LnoazlmPcBfPC8so7VoEMXTC6dIwNq1JzZ3U/qfLr
TQtuDgkpQkv0nhIgRnKXHRPPEx8Kx2gDQcVjhyUzeNeR9V39HOIVa4P9zcPsF73uForabmiBABN/
OmMpwPlnKz77b1tXqz4u1pYd5JkpTNla7RoMTGNAUWA21tbaGNsEZ6R6+cn0ssJCP+//7ou77nqt
8OBmE7M8RapiM6x3yJQbgIwDpLLHw1IRSEvTLH4FnetuRkfjEhGTsU6SMHh10ja3xrhVUM4Ggy3a
n0N6zgMLhn9nXYm+OAgaBegmcMiOfxpTa9G6d3hIY1u6z7WbTOusZT8SlfG9aCavb88TxSKGISPv
RMKIVC1Y1xFALg/VqlNM1nQUfryfvrVS2ixgtm35p0Oxh1QfVhFW8BAN5ixTewXoJG3sslyY0c3Q
M7maNxak2+hMgmvYv2g8zxsce09n5xmnmgY+gusI7yFTZAiwj1yIz3wC64px9UT52U5l+Oa5x4U5
2bjvdQOL6fp2ttIGeC/UUbJC82Oy/f6fHTAU2mVUfbjDynJ63urdGf514W0C/Sr3iqqddw8figip
jJO53yw6+fvE0l80mXb8Iv394riakq4q6i/If4UjPwvFgX0/uAuAWPnREg0ZewhczJgKfsbhdm3G
IywgTvBypuyv8g9MCFCUBjM+Ww8uMWLw34GCMUC8BACYZ9MVY5E17P+pVZ1riBiwm3GteUQ/FJcW
3zjf/yUH/TiyO+/VsUrx8euc9GP3aO1+3pYQdoAJXn9/dzcxgSmHSRqlW/k7NcptDsSBlb1hMbIk
ZMBPXZB6NQqeROIX6arnOv4dpUsHoRXS1T59Ap/1uvjBQrWILGVtgBScKx0MMtVThkXuI21UFwuM
MurjUthqEoigQ8e6FczLxdTVY66lJOnpaF/E/fibKFuIj4yL5sUWTPG2a34bjAj0fWDKkKteX28M
KqfhZBNaXGA4QUT39TJBdNVWxOZt5yXpLDxnjzaIAx4gl6ABzhw4rhs2m7IQB3IJJpFQuvvj9j/f
qfMc6USjfzs5cH2cNjcuogAfeqqYgnVzdyvoOu7zqOhsx1ujHV4toAWvpV0Bxd1/0tgY5Oy0ELvu
s9vAK2QkgbQPMw4/X3lSC0Rdh4OdWSeb+5mOU5O3iCy15sqiFP+w8p564AsnGHapJP3LKoIM1wMd
hTJzA2xNlfAnAQlgDAjAigkEONdjxq8tdDk7p8IXqSFahHHfsiaiz2bhkmtyYZ2JjCy209Sb2rOM
Fq8cf2Z0v/1Cl1zl/0rnz06l4GKqydJlUFIo9vQVVF6uUbPg51776wtB+sSq7qyEIwjaNDJk5bwG
m3woPk9EDRTtshlYzmJLnvuGQSD/hrqhGn/VowtuGZnPnFg3HeCMNA6V3eukqydxFh4SR8aiVnlh
Yej31Ennk5/BOVIFay3sZIVWUqKDruc1iJBibjmQj0g4hN2PGsULm7gYs+fHnl0mMtnab9CFPNVL
h98IIiHQxTjHaV79eEtUjdZxhlNJuUd8dea5Z4oj8hbJYzzRcLeoktjq2pXWCktWu+u4I4I/KDvm
yRrbivd9lYaiP3flwffm8K3Zlavu5008Q3U4TI9+wTuyuLe5lJ7DKlfbnRM4htgR6i6eAe45j3rq
lozKHBi0Lzjywk1NFOc6iziQaCl90OITdydmdOk0MLvN959BLgoAHI9G9BZdvNJIxV7VCRwXioz5
a8xhX25k7fzBjKt1Wwd80dXCBuHiPK/kzAcqweYxYzPa1UYEjO+T0BoJgABgauy3qRvKDNPwl+FX
t0Ucajyb5USX7hCIaiI7cIy9dRaSg7yUIbJPJjtIawHztxQbZwkyos5QZPLEyn+e/DGPFf/Yrlpt
ogOVwIz1esKHIVwZaIU2bfq0i9Dr5I3kESrEQIIcWpW8KJumzLcgPCZh3NiQ5aVKgyEGzEoQpC7I
PCjCaW+9c4Krnla36Sx2NUTzT0VPtQXh8Xmll2N+Z90XYCvykaQd0kasdpa0BeU7R3GX0Z9mOSlZ
pLE+P0iyWuFWRnslnpWTJSuj90AOftAWw912cTXK2Hkzjy4L8azu2ZZxcRfofVXZA/42GTaT4kw5
OCQf5eXJ5Agls1UNzWJr3eLe1PqrUmE6Q0xZ/NBkqy2O4pXsddVEsrxb1Wbnu4dfM3QFu1+95woH
KAbycGrr5HCUdOg9sa+mZ5e6IsSO5OA7hjwQcJQjgEifUlcm1rYeSQ/cYd+jNtacym2DcJEdBF8a
OPEWrKOFV34ulcT0+8ejQtJhttk5tHFGfxW3JdJ/IIoyTVbsI3YWDEv1SmJKiIkfiq2eDPMm2aDC
aQNhw2FnRt2QikEGWNe8tNss7poVs4pYBq9Ykn08tXBJ3Bnf2rGbaIpj2JNmWRjleluLtQk5z/WH
41k2ihCpRdnxPAqYeUoq9alAXd9dQ/FgILkrC1LwKMlyA/SA3nRx56Pa2ZAfsV5ZD/2O8S6G/1Pv
uZS94OOGqF2NiWGjhjEsT/puARi5m0zRNzve3s6sD8FjI/Z5VLLmFIAhz8v+6hDiLr38hvQZpDHE
CVpHGU7go/M7sxtmvS78LT1u8pXCBO2JQ3jZ683BOE76kViOAJ8uHsSROydiO1owl/kjBI2QhBt7
xIeiPqLW22hWKSAPqCfDCROzJ/IGHR/w29oXl9b5G2d6g6mxFQQCjSm0W8CKGwzM65h8+cGkNQhp
WX/2OzpWtFUQt5HlYn2i7M8MTUf+8XClXMxumSkyPRtiFep688rJhwHYs95cVA5ub1TAFnXVtgE0
axCQZSuqUYY8YAx2y0b1qLJwD+3WCJXM4rBl6g+yAPQD7DiIlaUAaA7+zRfYUFxUm7Gkep2b6GOk
CGUq1ro0mChz45A4v5/eycIrE/OEjsJvgd897eN3ktMOecYuOOpiVDYj7yN7Si9vEyXnlF5tZRAE
4nDqZB/Efn3WvPH+/H7J5JNa3JntIyR02gdVFgXBXN6GztDZeUYpULVA3A2+ZdqjaSHBrfyzSdmh
jqLBAuMWVH61pMjoSbfxWzbAWyzL5/gxZROIGTQBVLX+78wbRqT7rIlOlVQMqqCx+dOFZlwOhEyt
ldHLlQH2U+t3Z1ye/osJRG2rSbfmV/nbo1QHKETEkfLpjw/YnBfnJbnOe+m60iRm5lQM15sAssT2
8MHOjJgyhC3Sh6T/3QJibD932gz5Ub5HgZ68oG7Jz+6FnWZCtn/tIOmTMNPDwMrccqV/BrFWIDIk
mQUvVRxfuwsKD2OdygloaBaZGAXq3C3fFu1eM2tkIFERddY6FdK+LoD2s3vNjDbpbZp4etYJNYDE
rkAdob2ERBxFsE6nZ5v5XocXfvE3IbSYf8ML/TREdEK5yivSoeGPfjM/2KJuhWnrmjcaIddsTi7r
OlT0OR7+mACWxzDK/dERmXoIoyuedZRISXsR+85FyS7RsgWVaA2m8LNF8AegPoHH2HeuApoWWTD8
CC+0KQtuKPK9pNd+MIQ0AQ05FyRHnY08WAzeZ5VDwwm4oR3DQl7dqC5hCiiA3WHhS4C3E3uspQYS
eZ0lyYQejdvQokYLwgWnOS8w0aIFpSEqweAqVRMvqFYHORcV+WLN+Dq213qaiHnh+a25ZmQUUPRI
K6MIOJWEwRyrN3Y8tBL8DcSw3qeuu1Xir5qe3nEhSU7j2yoWaXCy2U/IGwVfTiDFseyNmxZ2qE+L
1kTRT0Do3iGDDhDsmPx3ow9+kKZpcnm9j08oHknkp3OY5Ah8d1eHbY4/6yKAQe6KTbMmr9cDRCLw
HDpaVRhawjiX5geBigbSJVAu7aAyHikbBP23IjLg4rnikApNrC/b/WzeEFdG8Ydo8ZlLovD68m2e
DCduIWoYQ8vDduyFdgmMx07K2Mo3xFo1jNpvzgOrQpSOxYlmphOQmlyPmS50Uf5ny8gaPaf2U/mE
ji4Fo5lW31C8cOcyoFlolcvqLI5Z/vCKpEkrgWg7Q6TBpCywhYAX/Hw5d/rw5MN0i7PpGBcmmsVM
bcK0Q1PJigoSGDHR7vH7wz/zanDAS8h75PNf0Ca9LZywMEIldlJQqqGVUy4LJfFORMA1CN6/Q+nq
5/LnrY9dcN2ewfszqrESlFtGABNyg6rBYQ0IA+4VPZb62V1n9HGvXeWI/0kW2qMMJzcw17dcgVX/
ORHwo8W5xXukz9P8bBTgGoDMP2gPHBjICVbC+BziWGZihaLyEf+NJ2+YpnROdaeDM/YSM6XHm8C2
QWMRRGzQGz/SxcsnYo5uHWTzg9y++3TZI0WUIAjFsIh38AaI0hDyxE6pbtu2jPwf3Fhx9pimbsGK
ERqaoqvAFwlqOYkJnbmHIRX8L5g/OUUYlDCEBe+uCcbowc87Wr6WArJePUebhFF2hgOA1U1+JRML
FLSXnlHVci5MjwH2j4omnr/DaKeHsFr4CqRBrLdiNjI/ROq/eIGiYwt2iVZYaYnGPL8vJ5otYuRI
tde60917OqFZiCMaERpCFL5oCwC4kaALSaLMDJGLXEqjsbRQLeRHVOf7KBGkg15lcsdpjqKg3Xhj
LDhDHqWXiaCdpi5lSIHRea6XWdcrGrtKOx7EVfAR4GBLWVlU0ApyT7LiMWsMT6rrrhYBMUJBH5qi
k/FVu1+uSlHYlytQEUQe1tmkL0KXUFKwTuA5Q8m1Q8Fbr7rtDxgTzrHQn3hGqbCPj9gMxbpcOI0x
fF1yjTof1zmVlTFo6hCh4wOOVlsymrP/Fk9+fh+mgMFi5FXh9Xj0zZ4MxzCcjj7NMhOd5HTdcuWe
OBuiYggM4je9EMkJh9/xL5dnIMN63a+SLPU3xylsFwa88PynSIgbDqCaKpTSGSIqkoVAf6cpfjtQ
NR5oxkyBVmzevVoeAj1iq2902h6rQugIUetlzyuU0UzoFMtGimaX7JEaCS0lqueKlnH5MduRS4xE
Q7hfzqI2FI8XIs741ZD406HI86W8AAFcIt/W5mlQWQHyGpjeqw66/V9SqcMd9AFJHPb4D3M3YxtL
+78/2dnH/Adxkxobm4tBINbI4egpxbzwrVHrfF7U8PZsdZnl+oXrsN+XTH9CXOTnndvFPeiE/4D2
SZM1MN4JwT0z7ud98FxA1k69GvBAeeYanoj7UJc3iZieh6gpOajGp1x5bhiuFiHag9EySlfy4hbS
pFjw4/+BCnX6AcViVJ/NjPfAUyMfD3g/8SXDbJ5j0770SOdYX9Hko1up8HrnBfe+uuuwKe88YPMS
HcHOA78uUtRNglkyuyW/xmpgsVQSYXlHZ7HwUH7+dljXvBdhy0FSjHMYPi0q4KLg7pMFl+U8KhZ2
Y4o/jDi80pYJFUu+Z+GnB3KRSzr6GftCqKflI+vOR0cP7K5Ip595zx56Fto5cUPW9UNP9btm9bF3
P282om5nBNuIr2YS5NKMQzzdZR0BszRkwgL9uvYl05pPek9sS3c4B2/KjR7/ZqbZv8pfMfTDZV2U
3Bj0aOe3n0HHlDxyC8aQr8setaRMa2yHX4/JlYwhITaWjBlqh5zrwCl0nv6l6ABjiw/CdKkhPDH9
+lNOdRBGy0M6POx/f3GkSdku3ef0ZgyeinMQaHWlZUPs+l8OXSM//WoeOPo2Kuxp3WyyDbg4Asef
F6oNu+eCW4kLDfhDc1LjYID66w+AxJ32aarrDciL5Tt/EUAgYlRg+ImbMNEg7vVwdOujRTp58MY4
+rRUg9b5KJY/uzhB0/dyK8tW6pEODTyQS0uN9p+yhqPQqvjbh63sro6Dl99N4BIkd6H8jwJggZ87
vA4WQHKUNYBUp6D6DYGtt945U8nP1cYZiLKF+w2r77NGrlhFZeH0ccPrCYu9DZlpnBVXDUwSWvce
VezEfnXTAESHXTVBl3xVWHv53+FXDYb6g9I6NrG3cS5dIllgpvaklCKzsuZ/cRa7SlW7MgigfCjV
QaYSJDht45iuXq65lsnpsosbAHPzhjspDZRKLcAYz89TEwG7QWYOLoOnPWX4HDxhAGWgWv7VdIpK
PRSQNPaQq4QvHzQJZoLoSnYVBrakO07ecBWbNvbnm/j1EXDGk+hq/eVTBVyxc4umjNRly2xG/ASh
zrgPMkKp9Qke9rLtEGLjf3ywaUoLacZETlwbQC/03YkWR6tfVBLq2pdrQ/pbYoadJJkPVamsJUHF
eohhj+Oest7xHKMDHgywxXngW32cgeoxMY51afaMOKyiK4NLWPFl+sOhwQeR9a9fHbRew/lu5p0L
15/xgyi43sZY3UGmsV7Cj+NcsJz4Ez6Iu7y4aqLSz/vKLOr1Gxa7yKVqzXUiYDibKIU3j19GPKNH
+U9iYlt/tGzjuQVRSYksaLz9neo3jwFm/wz3kpXnpotj4m2w00Rkuo8wD3Tpt5Sq5JOlhYSVT4Xd
+Nrpsad6+pciqDQUP82Wo9YXGGufXQVWxjwM0bMGjZvqGaTJTbrYF1mJlmI5vZI3fomDzf3ywH38
9SGMjZziTOpjYNYBMGEppEo29zhJrpZePkY1RWmFEAjZv2Fle9WcLVqTTEhFMGThZxljhqnKxKgy
7J54Qdn5VI2diykW68F5rjnbuG28IlFl62IGqd3Qlg1S3w+AitQRhw8U7ziYfmimFJVg49YzSp7+
p2J4kaVOKdlCpJbuBHzTAkHvrvtCv7qU8PI/Xq3P2MBVNee8PUT4JUMl1k4eUj4d+j5lpk7YNLuc
eSTcf9cROCeh0we7kuYFJUmnzpsqiTQ2UXeHI2TlXdm7DiDVh1SuVBIs74YGS+4IvmmVjI+1wq0T
4LYzDTrpudPbyHMSqYzC+UtwCMRucXnk+vDIMQxNdPmsV855MjlEt0sc1OmOt3oUp8+fBPxWTV74
0GDhcRIyrr0Lre4GjNA3ZPrjq5h09s7IhMLqQH9HbuapiRAFi5L3r0p3//OINA4MGtGvRbVwHhk7
K0jNaJDKk7XNzzGxKPKAtJNkHKF5guDmV6Ai9YUpzEfDxgfmuEOyRqN04s9DwJsL+IihSc4mh2o/
brIdP4yPpVFHX+D7mE9IqRVBOMzG3d7WR170heYmUbD9CtZLulTWybheNhJNBYVD0jarPjdIpDvh
fTdpooLGWl9rW/2x/HvnkGulfWcftgzyg1/Wk20GZFC2JiMJ7RciKSY4JunCqIx/P102IJ5P+vsN
Y/yHHuzqs8OBIMCY+KkJt/hOJiiOs30HJfeeS9EIIEqTUNXPhAzk1aGjDl+Q5eHd7MePvABXRvbo
oTk8rNsdAkanh8ojhrLwvxAPTIjXm/JXXbQdmFluyjSd+95eI5n+L/2H3+QmL/iKrPJOQZsUejFE
uQsjGpODILUCd81A7D/ICJ/Z+gBhRekrTamny2jU7TOiUmVjT0CmsfAYZovsLnVJkGxvf0XzArxW
kboqultNuE3s6YXS9R3T5CFpx14CzST//2IrqGRuiH4kVl4hP9xIaLwWJUlsGJPq/0bi70wU36K/
GzSP1HBqUGbozCCUkPoX9PCgDzJCjkfC6KyXu6qMkGXrH1g5KMLOGiwF9jR8wBxkwSGkPJqzxAev
WwolKzap2Bho3tscHuXIjjIUZxNXRiMvNWZS3vhSM8NG3uhO4ApwW75sFktzZGWW+9MpKWUEfUQb
6Us7GVqYJ7tqamgwzAITGrujMlcJTg8bLSEpCcdSiygGqds6aOf3jzUZtwPNshadcDLO1aO+8x4l
bN8UKismZEfG6oDqQFKGhE+aSeygrYOKSjikYeB+LzKR475Jzwn7izpu0DghJgqdWXGILvILM//M
e0C7s4Vszy+fgmfOOfxd/TXiJxZ4Vil0+gF5n6QA1w9Y2fW70SZHYfp3DNmYkFZAgioGGo5OeHy/
GhnzfxYIt5uEIQEl0VMhn0Gb2jHcxplOgSDdGJFa4nqZen3YKzRLa7Mm64vnmCZMl/Zy2Q3l/q7L
OYZhL9+StIee4sFo62xLlNl1M0bOr8DCLOH48NcXMO6T9PiwR1NvAZScFYeh2BmZLigIF8HGz7x2
7kB7Dw1+GKFavmQULfGRvjzT9QhJH+60wCjF6RDAmhqYBeWmMVd8jYqcBpcOhb8Pbok0y0J1B7fm
F6AAOpG2PQJpiD/1itQhV68Q5J11e4k78vWmwLYOneXHsDoS4pLt5FG1cjYR4VE4w4G8qIR2Jb9c
DK9Nuw08GXRkGMNmKTsBhf1dkGdssNTpYzRRxH+SLP5aQwIDyaqYr1UmjHcEml/Ma/ULDgVeJcb0
93Ec391pO70fhmPVSC1xQlu7cXv6Qct3aPclrmQ/RhRNNEixAh/tQvf52dQVSr8RzWEHmY3eK2UH
RXgySBBF4GMHqXCmM3Dq7Qps3HoQdJRtWFeD2GTVWCW21VJ6/hffcraXyvyqeVxfAANoEtHLsBXf
WoAjc4IJoLD9DIv4cx4AX6Z0PWnYVuH18DafhkAeSpBhzUG2Ut5EVeXKhaEhgcb7LFQ6+dCFZkkA
c/CBgoPzQOO+HsfC4zMyYyimVG9Yk9k6K2V/PgH8Xwt288euRjCae8rPHyn6XlXNIPykPM9vBZM2
smHdaV5hCUlnUM+sCbg43wW0CcnqHN0coNqZLpJQUT5ysvRt0kgBkpNEH2C/gOJ8sME5JUTaaXGw
whAwqEmBDwyJMAc9/ziwL+vztBFUTM8J5ySd7YilF49wImxVwGat1u15WhBwMXbFW+sHW5fWLURh
w3wKwBjuiJbxhmdrxKkAYiyPx+rlKyFIzJKe1ldds9aGHwOp+mhFbDEVUjm8XLs2iwe9KD3W3Fvt
6RDhUvOOOK9D2+eHghiYFPpegM8DWrtM9ssCMT+j96kjZkYKINqQqXPx1fo89j4XVNItE+F221b5
s2LsybZ3o0WB2AtzovtIyc9Zrv6h3SPrMogRZcU8XFe3WvxXyHT+yZNALjOGwrwTENsvwBCF+HZX
M89KcIAAhLXwCMIBfpylanE+/kdSjV5hgBvVXzQTe7YbiDX39HfXyVmG7R1BKLndQlEtVKVYU0zV
zk/ljFO+2O5926GAWzdsnNHHYSTg9YUFUXOA0z53S31f9ytXOB6Nu8HJtPUde/b5q59hwvpqIaGQ
Ii2hqteFd2zGCU+VRmSpiRUXAo3NNaPhD6JFrSIVb5lNLFizva0QbY1nlkp6Dmf65lAAFN/s0oJ+
rat4Rfb90VML2hNbqU4MTKQhCZQchI6HiHNGAUzKsGnhm8fPDqtXBstqxrOdZYTlubtVmAvi22Nc
vBmdMdQtTqcuIMsAbtKT3/4exh5WWqLDjf5MAl/bj33WsGgA6b8ainrXr4gSxJ/oast/7RQJLP+w
U9KTvk/VmR6m6lHpSl7sEI+x7HZaHNH984mFJ+Hx/anfYtS7PqbYlYlsSKuLu1CVQ4civvYur5M1
4Hg2rWTY9Kgx/UEb7jOERY1SmAtQAg6MAqdfv7On7EUMj7Z+k7nr/tyEFf3UcKDGb5MxMrd4sQgW
ZnxefMKtwz35cNcaKHF0NK+xoub5H4N64mD0S1X/LAceuNMnH0R7z3I38dBgZu4eLJreUWSIFVUy
xKoOlsetU7na3pdI+dyKuPbOwjN6mLG7D5021x51qYW3e1jKGrN0A5DeaHcSuLo2IVCM4pA0/cXk
Cli+2Kd81gIZpg0SUMLltpC+vtykFkDMVaCh7uBudC8VgN64ILLUQtUmvBcFkV/wwhf7811KkPfc
o1eElQFo66RJiK8st8h5tkS5fBHueiukbMToulBoEjWVraWr4ZZVit2k+Ns4orbHjXJ6Svf4P0nM
04SUKBvtD0cMrddeaNv3YliNbilvxxVftJdg553z+/X/cha6bviusyPg57P81jQ3IpE+haWyk+Ob
KI/QYcHgHo2OTYtFY3vjsb0HeDOiNvSuQ0eAsuJv6vW7c5Tphy9T6WppK5fTTH+Wqi7mbsfljWwS
Bumd7Df2UxpRv0GRjQ8R8/4Uk3OCjeHQ3ouCl/hua2Lt8+EPb/StrdhJXl3t9W8AkKqGnd18mLH/
h9HHfZFC2Etef/bQFhH+0BXZzHTYy8PUoGxcsxLQtZAI5rzR0E/UFwRKSEZp5mKBS+oGKgVhoeat
0KxfZmyk/+rNGi4HZqTpGnzZzvT2ol+jz5XagNBzxoenWAsBejb1NJ6l0FXaWx69m2Dq5KHPy9zY
NytfXSU4LI0vlUfhlpLRCVbWi2qJF8+e/S7OUR7/kSp6GT37aK9yX3I8ZYLIYe+uzqAQ6pWjd3FM
j/BG1BMiIqNu6E3l+NKj8RixUrY3xbMgPNJsBgQx/lf2qFddmqfl3QBRPfiTiqpuPFpiuFCbF/OJ
pZ3nJnStELVikaooqLvyBPoYXxk5zN5P99zKd/J6TDdvaMCn9yqfGXJ4NQRn0r5fpLoQuwGofHCM
jyfjzf+hMqil35bXHXUIj0TzoSVyJ/CueUwJarTO01QrdrBz12U0fPi3Kz4xBCe9wYsgOUau0/lo
ezRKuefeUCmfkrywAL3Di85Fwzb0jjB2wR0p6EvqQc28V/JDLGS6pjxuiBJKog5gBmgWojxQciCm
aLo+m5355YPGEnRHlEss0na/8ZP3m8tEqoggUL2jYyhvH/98KIt6MsicjB4fL/Wo9sRLSoDrJDSD
9P9wm0Daaq4oktc0CEjjdHjpNJAxRuh1GnEpZtOGTwdgdG10f5n79lPeXVBQf7ZbtNApspY70oI6
76IysKvLDcIS2ayYVvfJa4jv4NGTZ3HZq8ATxRj2AAYALwHTVrlDekVDy6ZAodLluDo7i4XngvnE
0mVRo5q7gUfVP//PWcxVnYx4C4Gapaq3+spUhzI98aMJve2qqexbOr/tTyyAvEC7Pwij/ogQAqGA
kOIQR7v9Zyr3+JA+xI/0O+3QTUI5VLRsLaXofZ4/NuVod2y5mV919A3gAI1b6M6iZAI8Yp1gzY1k
xoXMvhMopFbRVC4VKJmLEVc0dK+P2qjS8jYMyDzqEsw4uVRo7gdgBIgzRySWAj+pvycMOrULZGzZ
8dyK7sYScXJNxrnaMBqK1rPPusksduo+JXFEcLC/XqLNNQIFk5UszVOCyzux3/8X6cB+DL6HaOk0
6SYg1pvcFVmoH5OhqdVvB3SuYobFsOE9+lV5XlF2fml68RBTgWirxlcCi8OefqZyhYQFpmzV4uQl
2Xo+UFq4CE8i0YtHxikOaqtIclAe9unnFJYTvc6qJbOndiWaAw2k2Y6hncJ0adsXjSeFUOh5wzg/
VzZ8Cp1yP+IewbNzy0jsoCjtyHSy9A/rdwILAL6Bx0YOe977qy75kSVNKRNaCfefW/RzOtbcCMgK
5cwo84qSsyG40fNIlcsSjin4sXPn0fmMDMLFEvteK0DcJgC2nPBLQGh9jRUaZNarix9Kt/PySamd
eGSAjnSCFowU0lSR8XCnxoQsXDD1GW405nKUyfhaOizk07lhioj6adReeaBE8DnuKHws9d/49LZR
APxTQ6QpI4e0UZkRNf2UP/8ap3Xh90t80eZajI9oytN6qOgnjsdU5vPiIT1Z3cX99PIrZxfuQFKR
rD/MCI8rbhEZMrc627efCrAMcvc3oIlmmTf7E45TVWjiXprQnzN0AKAmalMw9SK9BpOB7QMstjct
WvVmZtpmN/dcTGefoKgIUlY0ZCY8VslQrWDS+WtNocAP3NmttHC3iBoTrrnm7QXKfIXWU2ifPQO6
Mbv3vei0QJbeF28cWzLVlDt/y5B9KBOPUm5NOWkRVkUPi/EhWBcd7o2H7ClzUobZI6aETHmzqTeH
k605+dlktQ+mrxmxOig16TwH/5PAH0sAnvEEZthNf5rg2U8CUQJ2/mp26fiwuGT8zkk71pMtSfxh
0oAh8egG8mYgIigelodPnTB2OM6Acp0qtxTQ72H2H1zZoO80J/KazKL6TtaX0lO/wcgp5xOYJVms
/qkRcAm9M+70A5G/SNFoT+GqYM4ZRxnJQ+2Nju8NnfuvOTK6UlpL6hXhsY9ZAOpnNTq5+0+dBx8+
QuorK1qK2F/SH6Kw/ZiYI2nVXt86uBrST4D/AQGu8A9EenvV4w/XsUzzx/+NG9hJUtnFKc9z2gK0
I9wTWapAIe9QwWoVjTKTq14buE3/3oSJ/TlQap5NM3HS7ScF0NBu1IsjcDm8B27PKC6PVmkHXEOd
3/LABm95+Spe6oNuinMelPifpgDEg9+x7A+loG2Yb3/489JYqfplJ7KHmD52+lJCMNNf0ckpRrRW
HUeAWQwVk+I2rlDjzucADHi3mLnTbBRWjtLvhI+gbaCHF4Kczvd68tdHesVtwcXKn2zx5qErk34X
FTvoK1h2/lIG3S+9aQSDEVaJWin2PO5tcI5asD0QoKLmFBqXIi66ruzTZ5FfmLrNKjPbbOSuBZ42
R1fKlD6mUmP2MNkDv/L1q3Wfu8r68eKFudaZvQ0p26DwjF124+pcGyVxn1yQzUuOC6Wy2LPjTYlM
VrJGEq9ZJuv1EYm15I4zsHanD3lRFX9rr7Z0k/GboWeB7haT5ZVhJKko0m/pXxqrtObfE6lZ+mu8
HX/XXCAAIEWMGtdqBg4HJmb5GnrTFT4SQkCWjgnEXApaCTPQQFGcmlBAS1lr+kHEUUtLLP3ffNcz
wiS8dGeY/nMcMNDDG9pWCK3TYqxSSXGpamWYUFIBd+P63qyVi9w5mJHYg7a50J32XgYqfOYTP13p
qzDU2LrbyfkyWHxGfsMu/q2it0ExHilI2QsAQ19qcY8wpFZ/7AZwLszltjKx67/PC5z2AyIx4Meg
bFLowREsAryWu7cyyOKjgYC57UZ7HvBllE8qAqVTyC8pfTF9sgDtTCOuOmqNfFkHUBx22lQwDXUs
WCSGzwT7DmQWSu2C+jhoMCYv++HiQJGX5yqBBb18rel11css53yTpVSITagYXFTlywPhduGFfslE
gRcbeF/1xi5oaSQWqdOsR8S+u/5lQ7a4Xju1MggSSpKgtphgxfpSixvyzDFdF/FSMmdt2l1RLjH2
ByorOJfc8ZwGUEozEwb/gdBz3PuzeeG8qDFoS7uylnb7FAQW0PE/LE5ALCL1wSJozaQu8SLfO7+a
6theqLXc4oAJGmcGwN9OeDgVhiJu2UdJ+I9vPLz3EGSsN4PzoXjPT8nrRGvP63kxCFG1mIIgxAz5
228l0S3Ikl1sp6Glm7nTx1kC16yyf2oppd7+DY/w1gbsEW9YiwLLBo6Y8bZaIYUL0+yuDT9jOhGE
QTYiYveQEI9H024Sx3nHIUGWfNcB1o+4kKIBGmChuXtsH1OuBDOMbm87QyNT7Z5IVxrTRdb8/WLN
bMipHB7xWrd3HZ9NMCcpGq7n7a8WdrE7peQ/Q+JCxxxghKAdsEEatUT9ZqKGSOoRE0IL/maFn3Se
lCjPQdaAGzZKRttJRxtrfI8+bhSydaq65LdQ3hSD8OlqOiTtloJfipOc0pBXIb7B752TKvd1gu3j
tVQYpyPTVBLuWQF8Xus5m3d0WhSCUAnshK0oJAQ2nqbZkQU7STzQd/xxlFowyU5o67DqmXhP96VZ
qz0eKTBelF8F3TE6I5BjDvuZXvLd0HdnreHc1yhJVrbjVDMb7IqJf6Mavbic2RxPAkYtM3jELlfe
EpBgrBSg2h3pGON1UVkHQF2MWU+sjKHL9uE1T5cbI+iaDtljPidQ96+Xf7MQD2GzGXBGozimq5z/
7xMsCdUKCMEyCnuwopzBO7dgncO1SogJRx0kGlx8zzUmam85Mws58ZSaWA2lqSL+M3u1vJSIk80K
+lO0sp9SzDOUH7dLLOKzYqKoQWEDIkHN9MpffayXxeL3wHE44M+YvtJJD2yOGPbli4ZdtCy90eIc
NHYCPnGg2YRsD8/9snTHa7/b8Qxm1+wMVv/x0R4Lap7mWSHKr+N6mVvTRtcQhePVfoGGKKR5gJLq
w7gHiO/r78GR2OJQk1trPBiHXp4b5mlCFSgDnBRpAtijBeFOQ5Fwpb0P8TcwLHS9D/Mnc1pN+oj5
GAMsc/ENs55AL7SdMiA7/ezg1KhVaODh4RW+oDwBVN8wDPnjGlT3WZFkprGRzfYnN0GBEUQH+QTX
hqmMtyYkvNi3U2BDWk10XASlifj9gtUgrrmlVyNMlZWj/xLeDGgNrK0FRrtgzn594FIpOp++0Q2j
EVG33zV/EcsnhTKKMGbxSYp4/H4tYh6ZEzrQc6LtOKdeA8ruzRn/isPbatFNl+KzDlnuphEDDCoj
lOn5HLu+e80HXNGZ6CJijUv3+l0YqWJ2Y42MTWLmzv5Zw4yBG9VWUxQnR4KRC6b/CeepgX0c0Een
FKxLJ6wbRUWvqrrFkl17bDYRXNLkkj19aH/hHcIRj14+j7CYPbC84xzaz7hyGQiRy48jX0/LdbHF
1cAxtEKZYvqzJqqtp+nh/GoAz7zygl6sulXsndmib9soT6ErsB3z01Faljwd64G5hER/hKuFO44q
DuJgPCRJO4THjNVuTBy9hhL8jNzhPFdmMkz5eqQJwl8Tzm/xyhXLR4tEAd/dbymXAPKayNi7ZmGg
Ou1tnSJTeJLxP2Mb60gCTQM96mWg6pzDJ6XFOf1IrSzd5ENPVhza+cwckuT7EvsNSAjGQNlvsTJr
EHM1nqHLWQXPRH+lM/2soH7EW/9UEZXnjlXEDSf6CcN++R7/cFQChEAs+Fvm/qtXiNVtoM/acjBA
YLMPlzrPyg3KSHbNvZ+yO7cnwOFG67kSsairZhLgJGHbK/ks1ApczPWdN9ES0FIUHvlVPbfBZ+th
ALHb/UT8Knh4u+j1lPJf000td0YnMOeaPCV3xE+pEq/4SpddRDUHf+e3SWwENl9MSpojMsbZawBl
q1BGLeyTdLsuaMutNVP8bFVNbiPxYTbS+Dx0kv8W7/Mf/l7lvE/oqCFcDzmjmZ9iYwFgliSVBMln
4QyVoveBnrbo+dGFmk3C9AhbI1ZmNF7x9Nl/lBy/ypUBgr18ewBt2gzRhlMep8SjbIk/CZcG5Fi1
55/TZDQGoO+sLcWH67Dh3t3pPADUMkhhKFJN13Sse3aAG1L4cCuFf2YH7cGekXYoxBwZ81zpw/ge
ZLvUaPvF5Sr/zqdpZDsRdnjzAvfkCdRTEp+qAogRTq1gfPyoOrzj93jbicX0Pn2oh25l/gPQd6zw
faySdXHgnuBphRzrY9AzH8s06YGIoirORdxQXLP/ZjA9oafAXF8L2I0GL8DgTv3Mq/g5ZvUdA/5I
1lQHz+VCOKJqty/qdoBRFyabnObxUx6sVIVkdty/3tstHx6u7wZWocac0SK4tm/UHIZqy5rTIQ3t
QHHQAtbIaEvbOXP6owsmtheYSniMiublEAN+/hI3psUVQ4wYCVVFPf2BInzTd+ouQjEz9Svzh4dg
EVuj9shs2STpCuiAaDAApllDLscnMRvMRYFT3bxhsAgKRg8+BWCH3iJ/R62ZAP0YGw6zofe/GqPU
73FFPfuSvDM3q5I5+XP7jaQsph97Nv6TTfRv0JHasZf2Pku4Ep3I93BgMrn4TNGTG786NLoam7K7
dEP0e8IhwlkdDai3JrNdyF/opunq6cBB4qfsPASKlyEGISJk/OzrkPHgKqR9IO9Jeeat4+oieLeQ
PZUilBPXG1K35jYfzjTJwVFaLQgJXxOnp+/ghXdd8yk+N27UhmBCqastzGhs1oMtiPinIdnKU5Sc
EPxYo3Nt55M19dEy+/O/WrUFe5Qb3tNQjgOqrPdyYcNxlMbiXLoz+G2pGfiteijxzmot/pirU7hl
Nxx358Rq3exhInDmsq5k5/GoCHjh9d3/rWdx4OAlKSWkNuNSjFAXTbOkl1kZdZIY4r6xSb0AmcQG
zbO8dVertbfmSIIFeaijqf/20ZnbvXBjYKkpKvRtObt+RuRGCShVk6jJt40m0ilXGckLEyZj1nNK
3D9It9M77JC7ES9byjsNqwqjsjZvLb85Rs4A7kkU3iOpb+5JSnn/IbY8vVJL7HQH5HJdJ2htshgE
R53xBRtzy6v5pPoDcnwq+n6Bdbr4kOwdEiyiPeD4LqWVPQBEO9IQv/TAX6ggsppkxIW23lycbZWg
VUBbq1p/jygHq7OMFLoFUJwCWMPkr3Oo/o1JkBG10i4mUfD+AGqAc10QWM9z9zBt+7ANCWh05qQt
JJIZGX4LK9nE369fy6WisddimupQJFb+S43EtPCoboBIWm6fuagw+egFb0jZ275SvOENL6FdDZQS
K9/kyK16KyitwfI6pZNLOPkLii6XybcFqkeMXq7GXkTumyQ9Nn2m9nhpK6QBXfcDVT3Ak+mzC3mz
DnRgdd3uMQ9iNsiNMgtljqSP3vQNnv+Y5JFem1JZs86UovG3hD7Kg8GhjNIu449bpTnLuiLExhdw
Yr8Xca5t64WvM9YlLpPTeoJ5olc0kUBmNskR66/EjsvUhq+uym4etA8fS5S6luE4FlH0NDcZ8fhK
IMnqWdqhaFHuiLr/WvyCa7xitVQ8wt0MedQQmoseLM1yB59udclWLy13GpGZbOIkyP0tIBY0y2ec
zEWdQVmzAR+OvgJfpkeeY6P/aXNxWYbzadeU4gp+70/q0wCLAtoYIfAryj2+jefmm3xdSC/gRWEK
LWSWVxugu7aiGvdK8l8hx78TRNa1cTBfHq7DQ9cP452hVwJ1RU3iV2Ef8HArOByy9J4WwmyXSrPk
u3b9BBMnPOXXMcjtp5tR9LP2UQkj9zL8EJKJMi8y7AXH0QTrSBruXYZzmv6XGYfUFXqHqIBtPZgv
/pFlz2EiJoQfqifiv6h04bbLyTq9qObP/kX4XvieAaDI9m2lHYHl8pnq/sIj2q/ezC7l1K5QKkev
Ar2as0oS18X7d9W5IJptSAmObB1o5a3yt51icPNTNyvKOhlQT8kObJgxAGUy9jDBIcK9Os2LD5Mf
1Z4qXmmB62fg3bi0y03aKu1OMIHDibdmrwZ91K6XkT8AlOt2dO5UJMkN8csSPfspGfDfiRpLCl0o
N+EfcLdmgSjlqEz6V2G0gUrzqIjnEJJ+JkRQO8dT43FfbGOeoL0ZWhYqVIE2S1mbbRhnACtQTFAr
zNd6wsQNDQGARgbNtL9Oq+VRh2wS/KYumXl/VKgcR0kNs1ujszbDTc7HpGjMgzddCM3ztHlY+qj+
HFjWcE+D+pfWxNzCIIl5dM4rUmLNEMkL7dnHe8znCiIkGXZ9c5IYwOFdVvA2nW+HzszQoU0yo6Q7
gzNhrTZv85e4T5matcH7a/EIQZIrAymk5aRzZx47XTCaMqM6klnwj8Ob+1obZ/94SpbNeI3wPFSP
EOwET4lCQLX77YFK678iQUaw9oel1hAt12jy8cueZ1FUWGn86qu1xS+M0ecxgu/wJANOAIXN2dIj
SsrW1NiFI3XIONNKtRyrUn4d9rM9Z1wYGoqWt67ncO1/vF2osD2ge5NOSchdq5hb4CAu0ey6msKW
71TTW+SRJL5vQASkw6I0Wruzvx8nS93W+0KpDEBjy0umSQZX+R+p2ujJ7Db6iVRxdI/FH+9u2rbw
JD+rAGY/2qZ3Map2wzS1m6/Iri1G6txGsRMHJ+h/28l2ZGRyGIw2Ib7s9fEQHwEHNPfDEhcGjHPh
MVYZufPU7W4KmM1i7i7jJ90HMmbf3A/BB054BaTYBpfODwJAn7WoPJn5QRdsn80ha90jTKWbZF4Y
46kdADZ0K5hcU4OOPVO8F8fcNjip0RiCseLew0Na37NJ17l3oIy4vClrVQiXzPB+c3NBRvQ3BzLy
sVRAjiMxQkvCtdmMoV8Dn7FxIQvE/9hRhP1z46GrdS9jVahyDR82gcssOZIR0WYVFtb87Q8TYMqW
ZEc1UElW+vuGUbJA6ovpM8oyGmk16Ur6b5s67xN6Wigcel1etCevvAtJmYSQR0oeVAwa/4HOHujn
dVrdrHrIQFemVYYTT2qjdyWTuSuHh7eEn5AlPNErFvsGmtJRGdp2vIds9eLMhdBWmD+lSu2rbLHO
tMvaBC1jxynUXijYpyex14gTkdP/tjI2JwAEUksqwd3fXvc5WfxHWdE2EqDTy8VPvmiB9RpPGtiT
Ga1tP5Dx9c6TqMTerJysGcyzPC5kRVbM5aszNVzlz66+01wTMa6lzjMdKz14C4jrl4bIuVNAIP1o
APOY0eZtEB5cRJutLvISJ3cSPMQgFBfmJmm2DKPo9WGoQ+AkWtY3RH7N1hIoJ9nZD7Id2yOacF5d
rcY1pFDweHt8lcMPG8vXqVdaGXOFSlbrpYNv+JA8M6bc1AY2mRPqOpLlmaAj6Cg+rCrcLux5CiXD
7Qp8zdApJqWOnYQ3SE4MfGsReeBl92pOLRsNrt1Elb+v532eou4XdWFSuT1xHAC1NtaxngLu9FAT
OC3hrsQ6dnPEL/5W/C/5wIXGsu/HcrXie1J2IOKrB1EaUzo2oUyegJuqrmbBHfrDJMFJq6p4RAL9
NuSyoQpS57KJcnsSfVdjpY4j4wECZe7tJWmtNzeuEraPv66TpaeMHawOn4kZlITPfpgRZzFj86tt
h15w4EMj3PKazQjCvXgGRR6CDKv0n3RuQfY3TRSy+oOgzuKIfrcD6lW4/2F3EcsapEnxwsBxTque
IJwoqmpmLZp1W2UZn69fo4JMYvznbcHF6w892mMS1jRLRCzAFarSXj+Y5BuUsCqfCBODVA2lknMn
j0q6Hf74207MynG/Iki4Nak/CiQMihsWxt2s6fz1uUTg/7+kXOvTDWBlnW8XhrPU48RYntS8zox0
8JKdRUZG8RfIRg5kKb4Dddsr4GyUAPAEH7roE9vhzxsdV4eUy7E0b9gCpO+CYk2Z30cHdFGTLOhh
AmFrC5x+gAuZ85m7aXIa52vrvjILJfI8p1DpLmV42LddDZdiuZiMj5JX1dmDRo3Cqn1DtkzoCEqZ
LM06MSMEZ++HeW9O3JqUpcGeX3S3QWzDoLZCAvsHfj02sLGGwzU9q7A6cfYfuQKsS8uOdKk2HvQ/
nYGqozo8ksl9fUGjT+YhcRzIoKlOfGd9ExKbUi3gB//KHr3DmNpPhAdCVucC6exL+LdihHmU6Cz+
JTveEzPnYvSbfmeFhGSFgnxocxd9D6/xYWE35HF0Emx/uvaVTvGP7Lpj8r6iwE3VkfwWZOhNszP/
o4MCg/nqT8QRVA4bw8IWUcVaw6QfbaCJHnSk5lA0odGwCD1ZD25+CTyFhhboVMFNsCk/vq8tsGx5
55UvJzueOHWE0WbZrgE12aFMhBkvpDy/RjTzxCdH4XwWEck8um5WAXWxqtAFQpTT5/4WvFNPHXnp
UWSyKUyqAuTq/4uSFXFIsEIWTQB7asqprLlkiZlomLuit9hXKCqLQCIuTxu6yl0dcouNYu4X+Qra
8ogqxGg/uLM5PVPNoxeoigktSZQvVcRWQs05kTo8ikVXa4Wc0W/qlVDFLIMgVevoEvY8IoenR1E0
Udib7zHRC2lE6bqkGpRKPt4di5OELFFtmVkSbQ0eFD5kFytgKN8dFQzxvZYk+PLjtK+y1tKd2BBe
1/3Md+BJthXtmTmhPUHhLwnCJ/9p0wVxd/hdvfTp0vLL6AQBfpTyLtBxk3Gov18+76cTCmOae34b
Pi6Km4VFdAqZVfrymZbgmPngOZaBz8ynEon3KcavfNHv9skHWJTvlp+fC0p8j8xZWbsp96tRw17o
KlkIZkZqvgQXmUvyvzhrk6goKOclXxQ1jJGQoiC08HIowvCq5Mjz5a0HzStMOek/jDQOsFsbLK3h
XiFFKZpCM49yU+jtZOJVyvbAOLhwqbR21p3o7GJ4jv6ZyzfLJ6HEO4GDMrBWMawRyF6p2MDZemSv
DqnjhLKVQ28GquI7r3ajtXjfKd8Lg0C/LVWonYIWNSPwBTaaKElsHtWDxAZb1TtdczjwVx8v6XFI
rtQkmnR77yfmaksBmzBZXlPmj7gWxld2H3cB54X5SZ3Ja5O0Xo1+uAvQg2X8UqjYzJX6JKTSfusx
GtV6+BnBMf3o5H3HUBWczP9VcTwbEOk1D3DHkm9qjkmUkiKo7UnfLdErzd0QOkr1v8tgm9W4pJGr
0vpWqnTGNxXWyQVP4vdWAN8Qu/LC5Nzv554mmXeBIjso7PbSEYzd8wqUPLPx+/E5xm/xLZ6h2HoD
Om29/I+SrnMrMpxfRwSRmFCcphLjQ329AF96YQrxeGPM5QN0hxNsD+BqYOl2JHO6KzpqXXpjyZ2L
8v65MXZRr8txXKU91LKgIjV2+RXxjvu5pOa0z30rCDVvfnJ19ditLv66RJNQdsnZaAwPN7fYTdq+
8rd0acD8nAHRwXRYl29au+0M5eVgG5CEKWUSgISUx0cnXnh1cdeiIKGG3SnFEArnyYkPwAUmCYI6
OTwWP5ESawX3v8zW2RQfN0+5gyA1j9UorrIxNZp/U5sDrufO8d08+dSj3CP4zLzHzs/knlwppAh9
N6MY1igzwc21ADVgh2qxFvujuKFIE3Ikdoa9yV1nEZHnu9bbyykvm/UxVUKCg8CRyP6t6Cpy2Gxd
0dvyVU9tyMDzS2zDVnHOhFS1AwhcrzshfZWk3a9DMhHDuerU5y9HgsAbVvGAO2bdY9zHR+HSuX2j
0WS8RAQnEURqTAaZTrCgPipFiXk3DT49XguyUEkrFbAlJhZTAWDHYfPd6I6QAy9o9DUVdUon8GAI
bps2E2tAipjxtLTiYjPCD5L5Itaceu+mkWYKY7IOk5o2kemSUjzV7AB1hH5lEYFG70e7WhX8nAC+
ZBgEA9facn8hVb3JH/ktgVwrTTuLHCI6SNuFjOnvb1wQ3dxdBzAx5hVAw6bdaM0pcLiwLajnln4A
lcmxhAyyD4+H4juykNtq4+ilhs6WZ/UlIOCP0gNzEuUOxOd4vdEGjiYLZE3PxGR6zkhyT8AIhPe/
3/xg9HUpGH2kyFQ9PPF4Sdquz5bxJnzoyYK3a+jDCaCbIathpnuhr1CbURJcRNZynH/bTy6oC6Wj
44PGnkr47SP4SmHuGrz0Rhg9dSZFDZ5yCIK2c6RSxrVmt5Gy58gXv3jUgid02phDsf7uTwRe88yC
kEDscSqur3Vh4Kl2QUCcB5LSgfNfOEMn5Mc81HOlxiy+UhNWELcXjkMCRghZLOGCr+xU9aAideUz
Fh5noROjF9IcVJEayBbHcvpoT+3kjjnpD8benZf0zrj/ZS5qzcucZIlDaLRoL/V0c27unTxInzt4
cnbtZkJqKBEoiHWp3Ym2qkuPaFt+C8Svs6kamA002NF2bNLTCNp6LZBJKe1nHdUUvh0UWe5R7Y2+
IO9R7KwQiMj+KFDi2Hyn14aAsy4lRcrsyspb47pSFQwfP50OI2E2LLn7UnIuyrJY1dtEvgQNlkcs
LSUOIkQUMkheLwFVoqVloSTRWzUc7hDQ7qSSWNzDscdqWkHIbZ34kiqMV/O16ebKSsGg4mK8F8FI
xgU0p74tBwLHeIT45D5hTMbqB4qHuBba7sjL17kLAtvihM3qmEGdWFXFipUf4ekt/gBc8xgk1FQ3
fASRKQtT7MeP10zKU4s9MbRKgli2K1oOIcaGzg7Oi/WeYQXpOhBc1EW0S9ubp4zgMRP58x6v7blv
wCLZ8pozLD70J2WT6Pj6J6tRBCG0GaYqbQVEC33/SZccwzfPwMsPCZQtAucQ3mJcfVVtFz43K9oC
RhMiPdtdEvcZDJazHLw2ALXZZx4Y9whmCID8qiT+PrYpWpnQNNDiUHcB4vb5CqIWJDRVEPWA5XjW
q+CxyzXQKuDpcuwUl9eg7M/KNOGPMSrdTlj8+I5uIfcEDCt/83Bv7mNUxwyhHOBmlgiq3+CZcwvH
oIL3u4mZHXZ2Sortv77HtFlSE5J/B1l6HQD3Ru9FlIX1aRDcVivaXEKVHKrFWfmT0RpmzElkXSIF
xDx3hw16m2+e25naVvahY9U4C21v67l2F+YvS/nlEyMgS8zuc9IKQHEd79w7EXoDc2FWixgC36XT
ZJQkcaQDh8B1dG50yHTK0tQLmRNinDWqDqTSNRAGcLT9yCZ2vYQ6/e/nS68s2fts215bPZ/CTwlN
GBGU9l34naf/6FfThvkItOVDv/7WPzh5Ilek7u5WuNyx9J5T9QK6huyPT0pRptKhdW8FhiIF0VTt
eHtefT2z8N8+XbhlyMISUZWON8HYPvhpeHC1CPHmNQk8a/QfIiRZPqFTGMPAyfSGWuuhhHM1h/2p
OOzBmEiyUBL4+K0SPsJL32YVojsagO0qiRR8uuOBHIOA8EOgQbgkFtensSjop7JupLzHnNANUlrP
P9xiDEhc23VfKktayDEK/NkOgv5+ToAvJYu9PQHJvn+ca8W56Yo7L01v2YVTLABSdcIIX121Dfur
Q2QdQ1OfkRR41DcqNticus+4FlXLiK4FAzU2xYrKKS3ibXT3SWTD4aQLPsUy+P3szU3jHVe6N1fQ
X3+MDqZl7fyQ4nwrKDmZKicBorRgWE28oVSH7YXK1XfLYOWwaQfCIA2glecHopAyzNDcau9TGiKu
8gX1LCBl4bZdlhjCEALqrqRUYfMTkxXLJiM6WZMQmEn8TvSGkCk3oVxv1ztenDP6rlGokrKRoyxb
5KRgtVJ2him13uuFKHKolHRJsCRwsez60UeTaeIUt+LwJwH2A2IcdUsCfWW1A3GnEiMLyvctF+vq
etK80nNHFkzpIlgmw7PBEw8ByH3UwOs2e6j6dx8jYddrPqiNHdq75dgI9CS+TnF+5KP8RtxJ5ct2
pKGRSw9Szqx87jXYYo7nF5LB32wYVgOkz4im+fI//cvGms4xJ7OO29BtRtYYufDBpLFvATRCchcq
u8RuCfWbEqmOzv3CkvrMGwKMbtEQ3BvuLc9mLRD2UUYAk6SSjiJ4UppAhb9/vDKm0BFSd5RKBQgX
OqElSSn+LUINSQd4RnqFxMiOkcmdFv80pqgu/XT3CZB+nh4fE6trjiar/zb1JvC9cNU+MuEP0Vhc
tw+ZryTJ3fE4dQOx9Ncyi8J0iSa1ew7i5i2WLCsErWCFESQr0ONSE4ynVdqaM8QWJGLPeZ8T9rcc
MP3XFRnwr+7bgctj5zpVrg9hMQIXkTuUrok9locDcEYrfE1cGWHyvl9ijFEQ9pav4hzk6weGp8YM
TgJxk4P4xHCTa/+vyo+5Zi+JFTVXfbkulzpn17MhLr1cPZPK3AONDWaCH0OOs+TgBr9/9CTIka47
kGUAsmkKJs2VWZ8drG5ZNAX8aNikRxA9L1uAM67effC9hyjReNcBJi3oUccZ6MXPBMlnHN7EWFpM
/EhfJybbR3RYi0rObItnAUdHwrz4aHEyK8O59pbcV6nGH0rWPwnaw4rVx1ElxELQnfTxx7eax6R7
cIEh41xKh3wWhosiqAKqP8o62RKKITiOAAXFZdaMp26fW6pA8ItWAtnw3JesLZmNkgS33TK6+U6o
uSmhBqVkEv+NlEruma9bFrU+kplfEXR9+JsBe/r7T1C6j63kPNLPkuQ1PYBTjc1zFc78sUxiSP17
msGB6H/VdcBF1I7NEBSMmQBJFJ/fuN3/56jowEDNNmcj87b5Z5J+jEfljl8LbELpGfzBGzfapHyJ
gKF4yKuHZGvM1TJxuj3u+pd2pfh/jAt7D7/7yslRGviT6qQ1Y4OUm7XE9HwDwBtmJaQ/mSOf/Vlt
ixq71Cxn7ak1bseJd7COEFhelvnWmeEZT5DcHz/UWJsyg+zvw7lNox+8LEoU1MHNgguY+4IyP9yU
gtDKdw/D7XftFfrUUigSpkTJq6CiVsUIAiirpFMMxDeK7ceUOYRdpvlsVpWJ0WklYIP4Rya6FNZc
w+I573fMJFGI5qkdJbUhjwOFsP1kZvFN3AkKn/hQFOT+jeJXOaKFa6faGVUzPxKsBe4Gf/OPEhxz
xJFjUJxsWhZqUtTWWsaeMg4RKzGE4p27NRldmw2lTzr4REyrbj8OLukF/16rZXl+DXqHdCL8XN2r
6ggKy4u06Zl6LUYiJOseRtdlwZl7SyGL8hm2JpYegMTsAKUPoMDdcZC/jKhuLZFxMfBPSO6tdZs1
cH7kDeK0UJBpHFfdBbRem/7aVT9liUOxnCd8mrqqNfghKhrhjf1RPlaezGO5EVbCfr0ljKkBtNBi
LnFkv/J9fQ4hjBU+WwsO1LN3LJJIrg7gP4eCULW+xF8Kija+RkqLzLyFtd45ijCiBKplMHwejZ4j
vbnE3bwKzfB5ihuJFwyfOq/cM/TtRZ+rV/P6TBPL8C2PiQE6IiA+x7KziyRAilvBCwIJIk+vIeFq
cWSn6ebHi9vyBZDWvOBr4ZIaAkb64rM7W3yytL0g2apI4+nPaT9KSUqKVcxkAlY4TWGTkeKnnDs7
nq5aqqpmEYTekV46NsiPFnAc1u0KGRdGF19fqoNj/JcGObwfdQDVRIIb/5Q0QdxkcLVCzvlhKT6D
xB8VKepDBou1B1ewoFRIh2WIcg5maetqSlc8hbqYa1rBXXfq9aVWXrfT8EuZiYCnHF/tunqoQ+ZF
OGZQXa2qttR9BQbhwZeeZZ4UpQmvrPXzK/tq1nQftw5nWxJxQt/I/0Q2MmQ5RPc+ILcBfQC8ku1n
6FAbANzK0n3U/ijKAk0Bo/YUyptS8geCk2zqcZKZYNSickvku3qfQ6o6qQS5yrKfzeg4yvd5LQfP
wp73Q2q1AzVKoxsO7p0s0CWnK9NmrTWg3IjrMzX1Qqjf2+F7N6ogYxVr4dHVhH46RZ2ltz5GQoe6
MOye5q97zBeBKFQnzcQbYCgpddZTzopeGa7Gawuye7foKSqVM3aK2PFyQYkQ/j1Jzs6N70j9z4pF
L3fkeMYjI6BJYb2J3z3SEnUjXepWceAAqF0tCNtAdP1WSVy8k9Nb+Ca7JvHec9A/ndxlHmyGp+iG
VW4SZfIJrVU+weu1glBARnsW89pNWLwewThshBte4ztSyZ6H7O8kaWfd/sYt1VDjhqfXUz/5Q7Qk
KeD15g2x0f6eneUfZ1FO7n1n+KYWOZ1bgx8DbR/TttSGjRVkKbaEgCSCvETKGLarWZwKYp+n3Iz4
SJ+9VWORxiJVfiewW+yr0xTcv2Ub1D6SGr/kRyqin4MNfOky7JBWyBhi01ZJKGruWyeHLwZ7nJpC
l1BlfSd+QoLMQuhUnPd9vuvVjGJJ8Rco8G1j9jf2EUfGbP5A7cI589tqNR3B2XSqukb+WdkTag8T
DjbNugXuUuT4C1/3xOkbYsa1YAXka/Wz5yOIpu1ar/z0N/uDmUuZuxr0mmBLbvRx5W8c6Q3uJC34
2cmgWxt91ih/punyc0Xjhi7TkyxN4D6BlUSeBUyir59ddGb6ryvz2YIjLmuvgmvkPpahxUJWF83o
r3oFKhS2T5isnJnM8+ln4PgkHLMi/H6hJhiOBJrDIz/sdHx6pwC3P/L3oB9bXI2OMJSSHfvo4iEU
ibUItRATt7OYD3ZIZ0uLE95dl8T2TQDOihys+T4Tp76Cj50akqHHynp8ateSy3yGl4hzl9+XaG5Z
eINRZm/0vKU3E8zzgH180Pv1C+n0F1DqvrF6V67fiMF2n7UPclMpJj7dX/Ts7ecfQ/bPSwebk4Q2
sU95i9xX6CwmjPvo4MEfvLJzQsQ0Wdt8XGT5IDET8iZDxedPQtUrf9qUvt94oPyOXrudVVc6NGFx
5aMk2tJEK7hRHEcJA11ccZMkW1gfp6/avwTy/VkY81B7oIGiYYqYxXtmLnbUfA6CLb5bVIJgJx/f
Zhg0GeYUn9SkZbaRd2YwxThvyjPbtn8YRaQLVB/gTKNUYihPTsGn4innk79wqICxjhYd0shaXP/p
+g0KeBy/8xf3bzQQeduetnCyIoqg6ayAga6QIYYcv0EX+IRSDyIw+CBuMyp4dcYRBoUNTQ3QkaaB
PBXJN+k4F9oGtGBpSSZar4oRbgjUk9oUzGYZQgbeJ5e8iwfWet/+WKUJrp68FJasGhvJUxAlsTSj
99MfQ7R1DGoR9D1iP/RT+BQD8pxGiGzJpaCpzVKzhxrMEtlhn5fGHDb1F4P4AvUDQNs4ZmUvgEn3
SLoXe6bzNFDtYCEefnElBwJsUF+p6ock0tnnbU1He+FAB/Pq/ziL+bTJsKojAYjQAG+7NQyQd/+i
rr41EixT4IuPBdCi44Iy4HbiOu86Ay8uIAg0NnsEO2ootpQm7gjiCI1s0NmoJsCaUVxFhThK8c7w
s8ZP6Ju+L0c4YXj0xjHUUyjaIbLrGWjQdr4bwK6U8dLz6wxkvXnoO0uVpXbm+SZddYmga2hhzYMZ
TKgnZkvQ8vW3xwY20lSxwqR1qg+irx2ZWFNINbUCc+cl+rRzY6whf8R7nrgSV3xHorhzMm9a/y/I
fyYbfVdp9VIY7EF+VVx36U4TadS7YeTruCg3AF+JqSNEAQCv8iFvtkpIENPMECBAuxFYEqkNnTrd
CBLgOiY/L/cDmKJ02yWnWnam1btGjhN5TbCtp4zHRAkuBFI+6sFh2k8jeg6ko2FIWrS7brJYSwRf
Je3oFcMjgIo+Fna3wEVlBZe3GsgEkUyYQqmKnf26GoCCVRnAW5uS/Y1gCdtqojL+HWTdWhINcYr9
e0JxmokCkgijx0vxN0RMpp91VAWPnNuiSiq2DWhT4b8veKnDUntXx3EFm5acb4NyCaAiuoIq7Tad
SP0MnY7Qo+aKt/u6yx8AyzcgR0rVVuxeOU4JdaISdTLPeK6JwE0hfEvWk2d8ckRAgvtjJyfx1HbD
KyO7IMh16pcsVzLQ/EtPfbVjiGXSXFXk+TSaELOJ6cKEOzMZd7fhWDcJ+d3+RJKonv6HAZTmbfRU
GiYOKpASIytr6Z592eKrrp9tfoSO0Mqu/8mjhR6laCMYbRN7vIoNbMgFGIlfQ6ubtTHRWP64MTzl
562raeaxdXpevd5GMBcS5Tc2IsEDnNhTJJX7S8OIwAN5tAPeFPaCJcIQeBxf8x5ySLglq/ON8irw
HniN3t+zZnQ9ROsZ9LPPiueOuyqDnZqsoUCmMu75qFYsjWPPGDuxkk/3h5YkYKGFEe+YbEZu8DM5
wr3joJtKn0fNPj1WU8K2vV0U55hBFVes7CJ5+gV28jRTooyG0llh6Y2tqMmQn4oZ34vHwz+G8EjO
XUTf0h/P5OGYwEH4QQxqCYy9A4u8T7WsgQ4/pRNh3OmS6igP6mYO5EsHzCO9D9Hnk7SnZ1rM/mdw
P8TGxiGUfelBR2kldAI8QB1ClizjAliFc+pCJADCefKMHY4WV4nIUb3sBrSwCu/H8WAwZF1yvF8q
vjGlhLh2Qc/jSEjUgc4+vIMvkhBE6HOBEgC6kRCWasE0T3Fjevh+4FJpf3STrUldKMADNCdrMpUe
pyDYn4rC1TKhi29sVwe/SrHUYL7ycUFhnUPPVFoTusiZRALoy1NLssrzydVW6qKDJCTh7LpFSmS8
0k3EUHef9MF6/ypBY4fGxFr/yFhNdDjbalhZDU9zX3d8s0UahyeQXxtOalTjy/B1i8EWLVh3K4iI
aFjH7bH9eHzDyE+yb+PxwqJ8fbFuQLWPh932Sf8AOyaDVfJ10wiz3ZAsGZShMTCFAG1yjRj5Y+5a
BkZ9I+aajitCxDCn1KNDVnw/CjxmAQggHm8J48cYEbEj4V5XcuCJjNOtMzGbFOmrM0QkxQ4uRVyy
20Vgh/6PXTTxXhXRuHKxGNuJjVafLNWXKBRq8aohBTBlQ8S9zMEvJyzQiXTUiJdIFrDHb4B5Ga6Q
FIw2xqbeiLPv/yqv9gcu9PKvxrlz8Fp8AH2JGieAFSiChbc/uN0M92bcZi0E/5SfGs4r97cDX96T
h16AGtb1eXxzu/mWU5q4C3YPYbVXURQS5PEJrufl0F/AGozu6xKeuxWvmKG8M/9QYrb/dnx1D2R+
vukZ2GGT/pqeczCn5aI5/3nP3e9u0xBSf6mFzyi1WhtkmS1b8UteYVz6+ToDxAFPiLS0rKGvVzCM
7JBC6sBHnqEAZfVd0hNalAE2I9Ly6A+QWierxeJfKdhYKuu7oSE7S0d7FQ8a/eqbOB+zPDDYstU3
hWS/BpSOGKhV6ijpy+EMIvtXBWLDKhYA19lVfOKrbT7MUvOvY1Yz0p0P+M3yPEhK1Oik2A3I2J0F
Kg6pvyDmAWvsOLqfo1jB5KvUmv+y0yArEaK7YYtmXEAc9RjaCGhlmOcPt3AZviBQ7cczIAnpcfQa
ITce8VD17stkl1++0fiV+7CgZnq9wJ0v8tl5WY0P17VrrDpJFdc3fNXCkNPNJjljJIMLnS/hP/mZ
+PLOsXgb918dIOzXiIGWfFs/pQ89ntPLPSQ02oLaKs3brafL5+okj5AaF6J2snmcQplTH3a9GuEi
XPyiq6LHcnPEUOaBd0+iW2KPI5HP7J91fygQexyeMf09cMEZ1aIjeyhWvFmXoEPD2E3XSjOCOUXu
bpL8SloLDuM/2ZW7/9RiiQC67YrtjEnlJ0bv1P8l0r8JMKLOxuA31kmsfL6l9+tUeWGv4bH7PLI3
8tUAo31YbIi7ePDXoAKhtndcWWwU71P1LwBRNZT0bgooArmFpQzjwJW6jT8/gKYRbJoxuDU2KVcc
vGZ+aOQcmQq5N95g/HNkSrgpPcgaQzC3I0k5dCZ8MsJjGrnvqNlZ6//ELrjXUtQEr7u+u+O/1ZSY
WHPE9HFsXAcT9F5pdiJGzr8cwQZsqnisHAUUAO/6MsHeAxwu6WMnNOJhDnCRuxner+2S0bRHXq+C
VSWhCMGnjMansL9O2pUqvvFopP029jSJf65xTziLvB2T6HtnicTBti0d0ziAqk0GWrVvuHsnojoE
mfGqQ8CuobTe0+v1KNBPgCESEX87oACgArQ8jkp2Y/yKnckXDQa/H5C79rHxo7XL1mD3Hq0MN0qC
Qt/s63Vy5uLG3lR7o82POUXW00S5sxwwq6KrNxd9b+HijqYGJn5QA20NkAQtJQp8iNwdm5/uJCnM
VWcvtb/0WEIo24nvNLbocFQId6EsS0WMuYEpSDLP+prAe6/exBfMmnCO/umgLDQiL/TNRjfdhDfy
0O53raUKNlZbi0i6Q1QIIjYcMRdrthd+klVEdMYcUQ6PzI7ThdXL5nZZ9lPh1i+Rb9PlqqbnrcWS
EWJcJqKPKJgSjFcsBHoVdqbevgECHWK8XJycM9uClKTPM9Kt8wjQqdV7kmFM20WmPWWnOnemHjGV
zqwY/LMBhblIIWuM4bHR1E/Pbr4nr6fky418e7S24gsQOU4NSGKy+PY6Ejs1qy/DA5cerge9aoBo
R4VnzzidOx6Ana1HdBDCxGBpRsrQJixERpUdTb3sY2l1V+1t9wYbd+/ca94JpyBMQQLEEBw04V31
6aMip9VqB5Uxh5x/VgvK4g5K7qlu9MsmD3WABqqFn3ln01WpXb8Na5hEaHHmibgu25DJHC6Eq7+r
6TFE/fH38xlx+o1fpIS1NwGcflPCPpn8BYReuFQpQtkzi7ng1p2TFBSD9XIf9qN2hfSuGM5vHO/I
MThAeVmL0BA9DKZPUyU6tYXlxXRbD623N9dcZcfsc/205/4cRzGryuzKBp9ALUJA+Fo5Fkq9SWyS
WDK4Vv+4u5fw+KBcssW22BQfOMpR2Ei+CJJxzaybLCMk9+g54Bk+wM1h6V64QtDA5Huh6xHt9z40
zpUsVI+XAe1TyZcMCeuNMyjWru9sFhN+FaqVT8UcnKLTUKzedTmlM4F1Y59a7TFgL/QoJolsCc7c
AOeRdtXvHZih7NAbHRKAjA/FcI5PdUja0PusKhDKBbQEuOJGTDidSZiC4qYj2ERzV3ttW/nPra1b
lICyyxzud2hX2tZaHBJqYGnuh4NiDqii2YNffciI2XxZ+CjZORowG2zS3Dq7xyacv58aNA8v3p3P
Vrrsh9bjeFGFOI+s/zKzYPYSvOceAO2WKOZS+4HiOssVXdXKpBH8v5JWfDRWtZiIEhjr8NmvhF/o
CHID9z8RBCKNUAGaPbyv6mLt9DqpeQDBVYGN8Xbh+AgrZeKHN/gpVfVX34ts8cSh0EzbDEZOGPye
9lMN+LsaVc3wiNC5dcHa8FRfILSR6fbNNMkGcB+wmwhq8Ek60W3FogXtiXUaDV+8exJeNl+WKVOp
VuXn7/NQBlntGp/wou5E4+x6NAu5xoFwP8xB0MoKFeJNIYA770zd0nUeJdw5O0iP+abJTMqgdpS0
/dwJj+CISqstSFUSQCDrktgOlfky27jGu2j28oxDYVLgjgOL1snOTpWY1jGK9KR8IGPq1cvAPDzf
LM9Ci5vI5JOV7tipSnd0dnG37zugbOrwa/RWT2gEDWcvbBDTnAsBsQ/FmovZ1QdreBy5BnBc16mE
jBKybonFQQV5x17R8TA81VR0Deb/9bGwCXwMagjzlFTyKTSrkZts6pCAwy6IydGJfFxkoIUSinyf
44qeSrQ0CsJeRwkBMST8qydJv9vMYrtfI9UTHJ9KoiXXTQwk941sFXdpgtQ6O1mkiRnN85jFJ9ql
q65BjJhg/UcY/9Fs8o4IsJ1wh6X8FsxExnrqIqduWxpxUWk5qn7QXhwFhUc5e3b9CNvbtRsj+GOn
SJcCmWps6By+txfkpMHytdy0SNqV1skHxxkUICyN9z5J49XIgG9PJXOio2oTaPgXvJi18ukmLI78
Zz8QOhstGEPIFn4/BOTnD89KKQ2Mh+1T7cSnWvlOiDxAMI232Jv+kgwbcb+JFLuVFFHK0bURgzoR
6Bkz1Nx5PB7lc10YYfr0xvS2roFbmSfeETq5mkFcef4hWhc5yNQFhLPP8putyC+cY0ck7IoHqSVU
VJWdBtSrXh60CPGYhcOXOyV4dPPNtPYgUsoSJPYyVe7SFUeu0hyR5a/AvsY+oNbjlzwAzK2BCoEl
BKuWi8fWpvXaoT2Qt7zwMlK6thIgarJ6acnKYx9zW+YtV5yPA8nkvS5D4U43KrX9OyhVQDZGn5Nd
2NMGePTKhU/pYhgxJBAfxE1+VuGUpqbs5yplWJzTpjObqMewcZcoh72HpbAsP5EuNpMNQFi0+rJX
Ob4/Xn1ETFjssV3BKSC975uKXiGD/bWlkh+cLzRLqTA1jynpZyrnKH2TlC534qcQ+WiPXl+14xyb
5TxDe32qAGi0qIB1XuwwLiyUA4fYtT1fsS8H7SVD3fairyY0wQLhEuNWO5ST8h/FlW9ZT+YNUjCr
SwiYdsY4kJ2w6VV1uGn1hCvg70NbUZ9EoekUCFDykwuBrf9HPwIANDj3hy4sa8sJwt7gXYSVWNrh
dwKq9EtdqDI01ErxnRyVAqs95OpYD7wk+q3wiFU7H9fDXRkm4dXPiA6aZRq2We7oIElcJt1m4Up6
3cPY76YNoQzkqb8VAYdUneYQrQfMqHbD7lLO/o+VzGh6/3ebabxyVWTR5Et0HznbCxldKY2Wvw6l
3EzV0/gM4g0JeuN6/hq4xH89bHQ/dKvzSOi45fhgnq8Iy+Jz7PzHl1s6uq3r2X0aLNDAxhC8sKr5
V/AOvyw7AP9uP911ntL6MKhgtOspTtRvcd34MiibRtLXU2HKhPiuIR5RA9g/bRRDsSgApwTaceLj
DJyKyaKbBMikkY7FYs8LxSRkB9xYzAqaWkzSBRld8bx5WkzqedFSxxbmIdi5Xy4SL7rpD8ZlJgqE
zsFgL6NiwROXcUgFOP1yS+CATJWyuvqpJIM9RB4Fzz6iH/XrWvQAIcTkfFVlNPOAmxkqMjd03uI8
S5963PMkibmdXs531pn9nCTpRaTMRyO60otr2z3czXRQl3ckJJ1hY70kwx6TiSnLAVJA58No9eEk
MehiModbDtIfWbv7GowsZ3fPSjsrX56dYNt7ZV8gaROjO5e1nBNoTD9xi+YqFFygUnccJ35obrkc
zzT7mlr/Eh/mxOLpvgkeQsaWPmIFG7+1JDpSBt9j95eXUWVjQ3mLK3IYLBOrGdVVL2zP8OR5CPVb
20FGs2DnNvDFCp8QcAeo/k1DKUfAi1ydc1Xj1jGMMbYI73fi2/3KA7DjlnmpGcCpYvHMjBxmTUyE
Ze3bQae9Xrh4KJF+pPoSvmZef68EeaGlXAE8mCIOft8PTF5ch1guVbmcFUC4pAsvHZTurZ68Xm7u
UZseA8U533jvJGx2ZM8=
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
