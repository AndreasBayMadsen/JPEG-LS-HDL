// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Wed Feb 22 12:38:14 2023
// Host        : andreas-Huawei running 64-bit Ubuntu 22.04.2 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/andreas/Desktop/ProfileProject/JPEG-LS-HDL/ip/collector_bram/collector_bram_sim_netlist.v
// Design      : collector_bram
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "collector_bram,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module collector_bram
   (clka,
    wea,
    addra,
    dina,
    clkb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [9:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [15:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [9:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [15:0]doutb;

  wire [9:0]addra;
  wire [9:0]addrb;
  wire clka;
  wire [15:0]dina;
  wire [15:0]doutb;
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
  wire [15:0]NLW_U0_douta_UNCONNECTED;
  wire [9:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [9:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [15:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "10" *) 
  (* C_ADDRB_WIDTH = "10" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "1" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.777599 mW" *) 
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
  (* C_INIT_FILE = "collector_bram.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "1024" *) 
  (* C_READ_DEPTH_B = "1024" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "16" *) 
  (* C_READ_WIDTH_B = "16" *) 
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
  (* C_WRITE_DEPTH_A = "1024" *) 
  (* C_WRITE_DEPTH_B = "1024" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "READ_FIRST" *) 
  (* C_WRITE_WIDTH_A = "16" *) 
  (* C_WRITE_WIDTH_B = "16" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  collector_bram_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[15:0]),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[9:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[9:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[15:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19008)
`pragma protect data_block
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
uv5nzK77/jPmXr104jtwL8Vv0ZTTWoyJAIho
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
