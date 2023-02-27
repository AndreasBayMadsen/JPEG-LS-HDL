// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Mon Feb 27 14:44:49 2023
// Host        : faur running 64-bit Ubuntu 22.04.2 LTS
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
  (* C_DISABLE_WARN_BHV_COLL = "1" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     6.511625 mW" *) 
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
  (* C_SIM_COLLISION_CHECK = "NONE" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "512" *) 
  (* C_WRITE_DEPTH_B = "512" *) 
  (* C_WRITE_MODE_A = "READ_FIRST" *) 
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 32464)
`pragma protect data_block
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
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
