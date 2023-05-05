// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Mon May  1 12:37:47 2023
// Host        : andreas-Huawei running 64-bit Ubuntu 22.04.2 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/andreas/Desktop/ProfileProject/JPEG-LS-HDL/HDL/ip/context_modeller_bram/context_modeller_bram_sim_netlist.v
// Design      : context_modeller_bram
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "context_modeller_bram,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module context_modeller_bram
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
  (* C_COMMON_CLK = "1" *) 
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
  (* C_INIT_FILE = "context_modeller_bram.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "400" *) 
  (* C_READ_DEPTH_B = "400" *) 
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
  (* C_WRITE_DEPTH_A = "400" *) 
  (* C_WRITE_DEPTH_B = "400" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "READ_FIRST" *) 
  (* C_WRITE_WIDTH_A = "40" *) 
  (* C_WRITE_WIDTH_B = "40" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  context_modeller_bram_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(1'b0),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 31648)
`pragma protect data_block
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
5SJT3teVWIdRqUroIA==
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
