// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Mon Feb 20 13:39:20 2023
// Host        : faur running 64-bit Ubuntu 22.04.1 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/faurskov/Documents/PP/JPEG-LS-HDL/ip/context_memory_block/context_memory_block_sim_netlist.v
// Design      : context_memory_block
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "context_memory_block,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module context_memory_block
   (clka,
    wea,
    addra,
    dina,
    clkb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [8:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [39:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [8:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [39:0]doutb;

  wire [8:0]addra;
  wire [8:0]addrb;
  wire clka;
  wire clkb;
  wire [39:0]dina;
  wire [39:0]doutb;
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
  wire [39:0]NLW_U0_douta_UNCONNECTED;
  wire [8:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [8:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [39:0]NLW_U0_s_axi_rdata_UNCONNECTED;
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
  (* C_COUNT_18K_BRAM = "0" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     6.1213 mW" *) 
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
  (* C_INIT_FILE = "context_memory_block.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "512" *) 
  (* C_READ_DEPTH_B = "512" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "40" *) 
  (* C_READ_WIDTH_B = "40" *) 
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
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "40" *) 
  (* C_WRITE_WIDTH_B = "40" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  context_memory_block_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[39:0]),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(1'b0),
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
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[39:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 31936)
`pragma protect data_block
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
BEPgQ/VvL85HfRHI8ux3GQ==
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
