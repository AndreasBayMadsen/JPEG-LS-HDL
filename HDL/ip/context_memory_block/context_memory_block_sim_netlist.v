// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Mon Mar 20 12:30:03 2023
// Host        : andreas-Huawei running 64-bit Ubuntu 22.04.2 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/andreas/Desktop/ProfileProject/JPEG-LS-HDL/ip/context_memory_block/context_memory_block_sim_netlist.v
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
