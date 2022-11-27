--Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
--Date        : Sun Nov 27 14:06:56 2022
--Host        : DESKTOP-5F25APE running 64-bit major release  (build 9200)
--Command     : generate_target oscilloscope_bd.bd
--Design      : oscilloscope_bd
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity s00_couplers_imp_OFSU5Z is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC;
    M_AXI_araddr : out STD_LOGIC;
    M_AXI_arprot : out STD_LOGIC;
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC;
    M_AXI_awprot : out STD_LOGIC;
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC;
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC;
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC;
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC;
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC;
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC;
    S_AXI_araddr : in STD_LOGIC;
    S_AXI_arprot : in STD_LOGIC;
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC;
    S_AXI_awprot : in STD_LOGIC;
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC;
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC;
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC;
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC;
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC;
    S_AXI_wvalid : in STD_LOGIC
  );
end s00_couplers_imp_OFSU5Z;

architecture STRUCTURE of s00_couplers_imp_OFSU5Z is
  signal s00_couplers_to_s00_couplers_ARADDR : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_ARPROT : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_ARREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_ARVALID : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_AWADDR : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_AWPROT : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_AWREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_AWVALID : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_BREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_BRESP : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_BVALID : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_RDATA : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_RREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_RRESP : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_RVALID : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_WDATA : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_WREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_WSTRB : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr <= s00_couplers_to_s00_couplers_ARADDR;
  M_AXI_arprot <= s00_couplers_to_s00_couplers_ARPROT;
  M_AXI_arvalid <= s00_couplers_to_s00_couplers_ARVALID;
  M_AXI_awaddr <= s00_couplers_to_s00_couplers_AWADDR;
  M_AXI_awprot <= s00_couplers_to_s00_couplers_AWPROT;
  M_AXI_awvalid <= s00_couplers_to_s00_couplers_AWVALID;
  M_AXI_bready <= s00_couplers_to_s00_couplers_BREADY;
  M_AXI_rready <= s00_couplers_to_s00_couplers_RREADY;
  M_AXI_wdata <= s00_couplers_to_s00_couplers_WDATA;
  M_AXI_wstrb <= s00_couplers_to_s00_couplers_WSTRB;
  M_AXI_wvalid <= s00_couplers_to_s00_couplers_WVALID;
  S_AXI_arready <= s00_couplers_to_s00_couplers_ARREADY;
  S_AXI_awready <= s00_couplers_to_s00_couplers_AWREADY;
  S_AXI_bresp <= s00_couplers_to_s00_couplers_BRESP;
  S_AXI_bvalid <= s00_couplers_to_s00_couplers_BVALID;
  S_AXI_rdata <= s00_couplers_to_s00_couplers_RDATA;
  S_AXI_rresp <= s00_couplers_to_s00_couplers_RRESP;
  S_AXI_rvalid <= s00_couplers_to_s00_couplers_RVALID;
  S_AXI_wready <= s00_couplers_to_s00_couplers_WREADY;
  s00_couplers_to_s00_couplers_ARADDR <= S_AXI_araddr;
  s00_couplers_to_s00_couplers_ARPROT <= S_AXI_arprot;
  s00_couplers_to_s00_couplers_ARREADY <= M_AXI_arready;
  s00_couplers_to_s00_couplers_ARVALID <= S_AXI_arvalid;
  s00_couplers_to_s00_couplers_AWADDR <= S_AXI_awaddr;
  s00_couplers_to_s00_couplers_AWPROT <= S_AXI_awprot;
  s00_couplers_to_s00_couplers_AWREADY <= M_AXI_awready;
  s00_couplers_to_s00_couplers_AWVALID <= S_AXI_awvalid;
  s00_couplers_to_s00_couplers_BREADY <= S_AXI_bready;
  s00_couplers_to_s00_couplers_BRESP <= M_AXI_bresp;
  s00_couplers_to_s00_couplers_BVALID <= M_AXI_bvalid;
  s00_couplers_to_s00_couplers_RDATA <= M_AXI_rdata;
  s00_couplers_to_s00_couplers_RREADY <= S_AXI_rready;
  s00_couplers_to_s00_couplers_RRESP <= M_AXI_rresp;
  s00_couplers_to_s00_couplers_RVALID <= M_AXI_rvalid;
  s00_couplers_to_s00_couplers_WDATA <= S_AXI_wdata;
  s00_couplers_to_s00_couplers_WREADY <= M_AXI_wready;
  s00_couplers_to_s00_couplers_WSTRB <= S_AXI_wstrb;
  s00_couplers_to_s00_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity oscilloscope_bd_axi_interconnect_0_0 is
  port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC;
    M00_ACLK : in STD_LOGIC;
    M00_ARESETN : in STD_LOGIC;
    M00_AXI_araddr : out STD_LOGIC;
    M00_AXI_arprot : out STD_LOGIC;
    M00_AXI_arready : in STD_LOGIC;
    M00_AXI_arvalid : out STD_LOGIC;
    M00_AXI_awaddr : out STD_LOGIC;
    M00_AXI_awprot : out STD_LOGIC;
    M00_AXI_awready : in STD_LOGIC;
    M00_AXI_awvalid : out STD_LOGIC;
    M00_AXI_bready : out STD_LOGIC;
    M00_AXI_bresp : in STD_LOGIC;
    M00_AXI_bvalid : in STD_LOGIC;
    M00_AXI_rdata : in STD_LOGIC;
    M00_AXI_rready : out STD_LOGIC;
    M00_AXI_rresp : in STD_LOGIC;
    M00_AXI_rvalid : in STD_LOGIC;
    M00_AXI_wdata : out STD_LOGIC;
    M00_AXI_wready : in STD_LOGIC;
    M00_AXI_wstrb : out STD_LOGIC;
    M00_AXI_wvalid : out STD_LOGIC;
    S00_ACLK : in STD_LOGIC;
    S00_ARESETN : in STD_LOGIC;
    S00_AXI_araddr : in STD_LOGIC;
    S00_AXI_arprot : in STD_LOGIC;
    S00_AXI_arready : out STD_LOGIC;
    S00_AXI_arvalid : in STD_LOGIC;
    S00_AXI_awaddr : in STD_LOGIC;
    S00_AXI_awprot : in STD_LOGIC;
    S00_AXI_awready : out STD_LOGIC;
    S00_AXI_awvalid : in STD_LOGIC;
    S00_AXI_bready : in STD_LOGIC;
    S00_AXI_bresp : out STD_LOGIC;
    S00_AXI_bvalid : out STD_LOGIC;
    S00_AXI_rdata : out STD_LOGIC;
    S00_AXI_rready : in STD_LOGIC;
    S00_AXI_rresp : out STD_LOGIC;
    S00_AXI_rvalid : out STD_LOGIC;
    S00_AXI_wdata : in STD_LOGIC;
    S00_AXI_wready : out STD_LOGIC;
    S00_AXI_wstrb : in STD_LOGIC;
    S00_AXI_wvalid : in STD_LOGIC
  );
end oscilloscope_bd_axi_interconnect_0_0;

architecture STRUCTURE of oscilloscope_bd_axi_interconnect_0_0 is
  signal S00_ACLK_1 : STD_LOGIC;
  signal S00_ARESETN_1 : STD_LOGIC;
  signal axi_interconnect_0_ACLK_net : STD_LOGIC;
  signal axi_interconnect_0_ARESETN_net : STD_LOGIC;
  signal axi_interconnect_0_to_s00_couplers_ARADDR : STD_LOGIC;
  signal axi_interconnect_0_to_s00_couplers_ARPROT : STD_LOGIC;
  signal axi_interconnect_0_to_s00_couplers_ARREADY : STD_LOGIC;
  signal axi_interconnect_0_to_s00_couplers_ARVALID : STD_LOGIC;
  signal axi_interconnect_0_to_s00_couplers_AWADDR : STD_LOGIC;
  signal axi_interconnect_0_to_s00_couplers_AWPROT : STD_LOGIC;
  signal axi_interconnect_0_to_s00_couplers_AWREADY : STD_LOGIC;
  signal axi_interconnect_0_to_s00_couplers_AWVALID : STD_LOGIC;
  signal axi_interconnect_0_to_s00_couplers_BREADY : STD_LOGIC;
  signal axi_interconnect_0_to_s00_couplers_BRESP : STD_LOGIC;
  signal axi_interconnect_0_to_s00_couplers_BVALID : STD_LOGIC;
  signal axi_interconnect_0_to_s00_couplers_RDATA : STD_LOGIC;
  signal axi_interconnect_0_to_s00_couplers_RREADY : STD_LOGIC;
  signal axi_interconnect_0_to_s00_couplers_RRESP : STD_LOGIC;
  signal axi_interconnect_0_to_s00_couplers_RVALID : STD_LOGIC;
  signal axi_interconnect_0_to_s00_couplers_WDATA : STD_LOGIC;
  signal axi_interconnect_0_to_s00_couplers_WREADY : STD_LOGIC;
  signal axi_interconnect_0_to_s00_couplers_WSTRB : STD_LOGIC;
  signal axi_interconnect_0_to_s00_couplers_WVALID : STD_LOGIC;
  signal s00_couplers_to_axi_interconnect_0_ARADDR : STD_LOGIC;
  signal s00_couplers_to_axi_interconnect_0_ARPROT : STD_LOGIC;
  signal s00_couplers_to_axi_interconnect_0_ARREADY : STD_LOGIC;
  signal s00_couplers_to_axi_interconnect_0_ARVALID : STD_LOGIC;
  signal s00_couplers_to_axi_interconnect_0_AWADDR : STD_LOGIC;
  signal s00_couplers_to_axi_interconnect_0_AWPROT : STD_LOGIC;
  signal s00_couplers_to_axi_interconnect_0_AWREADY : STD_LOGIC;
  signal s00_couplers_to_axi_interconnect_0_AWVALID : STD_LOGIC;
  signal s00_couplers_to_axi_interconnect_0_BREADY : STD_LOGIC;
  signal s00_couplers_to_axi_interconnect_0_BRESP : STD_LOGIC;
  signal s00_couplers_to_axi_interconnect_0_BVALID : STD_LOGIC;
  signal s00_couplers_to_axi_interconnect_0_RDATA : STD_LOGIC;
  signal s00_couplers_to_axi_interconnect_0_RREADY : STD_LOGIC;
  signal s00_couplers_to_axi_interconnect_0_RRESP : STD_LOGIC;
  signal s00_couplers_to_axi_interconnect_0_RVALID : STD_LOGIC;
  signal s00_couplers_to_axi_interconnect_0_WDATA : STD_LOGIC;
  signal s00_couplers_to_axi_interconnect_0_WREADY : STD_LOGIC;
  signal s00_couplers_to_axi_interconnect_0_WSTRB : STD_LOGIC;
  signal s00_couplers_to_axi_interconnect_0_WVALID : STD_LOGIC;
begin
  M00_AXI_araddr <= s00_couplers_to_axi_interconnect_0_ARADDR;
  M00_AXI_arprot <= s00_couplers_to_axi_interconnect_0_ARPROT;
  M00_AXI_arvalid <= s00_couplers_to_axi_interconnect_0_ARVALID;
  M00_AXI_awaddr <= s00_couplers_to_axi_interconnect_0_AWADDR;
  M00_AXI_awprot <= s00_couplers_to_axi_interconnect_0_AWPROT;
  M00_AXI_awvalid <= s00_couplers_to_axi_interconnect_0_AWVALID;
  M00_AXI_bready <= s00_couplers_to_axi_interconnect_0_BREADY;
  M00_AXI_rready <= s00_couplers_to_axi_interconnect_0_RREADY;
  M00_AXI_wdata <= s00_couplers_to_axi_interconnect_0_WDATA;
  M00_AXI_wstrb <= s00_couplers_to_axi_interconnect_0_WSTRB;
  M00_AXI_wvalid <= s00_couplers_to_axi_interconnect_0_WVALID;
  S00_ACLK_1 <= S00_ACLK;
  S00_ARESETN_1 <= S00_ARESETN;
  S00_AXI_arready <= axi_interconnect_0_to_s00_couplers_ARREADY;
  S00_AXI_awready <= axi_interconnect_0_to_s00_couplers_AWREADY;
  S00_AXI_bresp <= axi_interconnect_0_to_s00_couplers_BRESP;
  S00_AXI_bvalid <= axi_interconnect_0_to_s00_couplers_BVALID;
  S00_AXI_rdata <= axi_interconnect_0_to_s00_couplers_RDATA;
  S00_AXI_rresp <= axi_interconnect_0_to_s00_couplers_RRESP;
  S00_AXI_rvalid <= axi_interconnect_0_to_s00_couplers_RVALID;
  S00_AXI_wready <= axi_interconnect_0_to_s00_couplers_WREADY;
  axi_interconnect_0_ACLK_net <= M00_ACLK;
  axi_interconnect_0_ARESETN_net <= M00_ARESETN;
  axi_interconnect_0_to_s00_couplers_ARADDR <= S00_AXI_araddr;
  axi_interconnect_0_to_s00_couplers_ARPROT <= S00_AXI_arprot;
  axi_interconnect_0_to_s00_couplers_ARVALID <= S00_AXI_arvalid;
  axi_interconnect_0_to_s00_couplers_AWADDR <= S00_AXI_awaddr;
  axi_interconnect_0_to_s00_couplers_AWPROT <= S00_AXI_awprot;
  axi_interconnect_0_to_s00_couplers_AWVALID <= S00_AXI_awvalid;
  axi_interconnect_0_to_s00_couplers_BREADY <= S00_AXI_bready;
  axi_interconnect_0_to_s00_couplers_RREADY <= S00_AXI_rready;
  axi_interconnect_0_to_s00_couplers_WDATA <= S00_AXI_wdata;
  axi_interconnect_0_to_s00_couplers_WSTRB <= S00_AXI_wstrb;
  axi_interconnect_0_to_s00_couplers_WVALID <= S00_AXI_wvalid;
  s00_couplers_to_axi_interconnect_0_ARREADY <= M00_AXI_arready;
  s00_couplers_to_axi_interconnect_0_AWREADY <= M00_AXI_awready;
  s00_couplers_to_axi_interconnect_0_BRESP <= M00_AXI_bresp;
  s00_couplers_to_axi_interconnect_0_BVALID <= M00_AXI_bvalid;
  s00_couplers_to_axi_interconnect_0_RDATA <= M00_AXI_rdata;
  s00_couplers_to_axi_interconnect_0_RRESP <= M00_AXI_rresp;
  s00_couplers_to_axi_interconnect_0_RVALID <= M00_AXI_rvalid;
  s00_couplers_to_axi_interconnect_0_WREADY <= M00_AXI_wready;
s00_couplers: entity work.s00_couplers_imp_OFSU5Z
     port map (
      M_ACLK => axi_interconnect_0_ACLK_net,
      M_ARESETN => axi_interconnect_0_ARESETN_net,
      M_AXI_araddr => s00_couplers_to_axi_interconnect_0_ARADDR,
      M_AXI_arprot => s00_couplers_to_axi_interconnect_0_ARPROT,
      M_AXI_arready => s00_couplers_to_axi_interconnect_0_ARREADY,
      M_AXI_arvalid => s00_couplers_to_axi_interconnect_0_ARVALID,
      M_AXI_awaddr => s00_couplers_to_axi_interconnect_0_AWADDR,
      M_AXI_awprot => s00_couplers_to_axi_interconnect_0_AWPROT,
      M_AXI_awready => s00_couplers_to_axi_interconnect_0_AWREADY,
      M_AXI_awvalid => s00_couplers_to_axi_interconnect_0_AWVALID,
      M_AXI_bready => s00_couplers_to_axi_interconnect_0_BREADY,
      M_AXI_bresp => s00_couplers_to_axi_interconnect_0_BRESP,
      M_AXI_bvalid => s00_couplers_to_axi_interconnect_0_BVALID,
      M_AXI_rdata => s00_couplers_to_axi_interconnect_0_RDATA,
      M_AXI_rready => s00_couplers_to_axi_interconnect_0_RREADY,
      M_AXI_rresp => s00_couplers_to_axi_interconnect_0_RRESP,
      M_AXI_rvalid => s00_couplers_to_axi_interconnect_0_RVALID,
      M_AXI_wdata => s00_couplers_to_axi_interconnect_0_WDATA,
      M_AXI_wready => s00_couplers_to_axi_interconnect_0_WREADY,
      M_AXI_wstrb => s00_couplers_to_axi_interconnect_0_WSTRB,
      M_AXI_wvalid => s00_couplers_to_axi_interconnect_0_WVALID,
      S_ACLK => S00_ACLK_1,
      S_ARESETN => S00_ARESETN_1,
      S_AXI_araddr => axi_interconnect_0_to_s00_couplers_ARADDR,
      S_AXI_arprot => axi_interconnect_0_to_s00_couplers_ARPROT,
      S_AXI_arready => axi_interconnect_0_to_s00_couplers_ARREADY,
      S_AXI_arvalid => axi_interconnect_0_to_s00_couplers_ARVALID,
      S_AXI_awaddr => axi_interconnect_0_to_s00_couplers_AWADDR,
      S_AXI_awprot => axi_interconnect_0_to_s00_couplers_AWPROT,
      S_AXI_awready => axi_interconnect_0_to_s00_couplers_AWREADY,
      S_AXI_awvalid => axi_interconnect_0_to_s00_couplers_AWVALID,
      S_AXI_bready => axi_interconnect_0_to_s00_couplers_BREADY,
      S_AXI_bresp => axi_interconnect_0_to_s00_couplers_BRESP,
      S_AXI_bvalid => axi_interconnect_0_to_s00_couplers_BVALID,
      S_AXI_rdata => axi_interconnect_0_to_s00_couplers_RDATA,
      S_AXI_rready => axi_interconnect_0_to_s00_couplers_RREADY,
      S_AXI_rresp => axi_interconnect_0_to_s00_couplers_RRESP,
      S_AXI_rvalid => axi_interconnect_0_to_s00_couplers_RVALID,
      S_AXI_wdata => axi_interconnect_0_to_s00_couplers_WDATA,
      S_AXI_wready => axi_interconnect_0_to_s00_couplers_WREADY,
      S_AXI_wstrb => axi_interconnect_0_to_s00_couplers_WSTRB,
      S_AXI_wvalid => axi_interconnect_0_to_s00_couplers_WVALID
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity oscilloscope_bd is
  port (
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    adc_vn : in STD_LOGIC;
    adc_vp : in STD_LOGIC;
    clk_100MHz : in STD_LOGIC;
    reset : in STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of oscilloscope_bd : entity is "oscilloscope_bd,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=oscilloscope_bd,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=10,numReposBlks=8,numNonXlnxBlks=1,numHierBlks=2,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=2,numPkgbdBlks=0,bdsource=USER,da_ps7_cnt=1,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of oscilloscope_bd : entity is "oscilloscope_bd.hwdef";
end oscilloscope_bd;

architecture STRUCTURE of oscilloscope_bd is
  component oscilloscope_bd_xadc_wiz_0_0 is
  port (
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_tid : out STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axis_aclk : in STD_LOGIC;
    s_axis_aclk : in STD_LOGIC;
    m_axis_resetn : in STD_LOGIC;
    vp_in : in STD_LOGIC;
    vn_in : in STD_LOGIC;
    channel_out : out STD_LOGIC_VECTOR ( 4 downto 0 );
    eoc_out : out STD_LOGIC;
    alarm_out : out STD_LOGIC;
    eos_out : out STD_LOGIC;
    busy_out : out STD_LOGIC
  );
  end component oscilloscope_bd_xadc_wiz_0_0;
  component oscilloscope_bd_xlconstant_0_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component oscilloscope_bd_xlconstant_0_0;
  component oscilloscope_bd_clk_wiz_0_0 is
  port (
    reset : in STD_LOGIC;
    clk_in1 : in STD_LOGIC;
    clk_out1 : out STD_LOGIC;
    locked : out STD_LOGIC
  );
  end component oscilloscope_bd_clk_wiz_0_0;
  component oscilloscope_bd_proc_sys_reset_0_0 is
  port (
    slowest_sync_clk : in STD_LOGIC;
    ext_reset_in : in STD_LOGIC;
    aux_reset_in : in STD_LOGIC;
    mb_debug_sys_rst : in STD_LOGIC;
    dcm_locked : in STD_LOGIC;
    mb_reset : out STD_LOGIC;
    bus_struct_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    interconnect_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component oscilloscope_bd_proc_sys_reset_0_0;
  component oscilloscope_bd_processing_system7_0_1 is
  port (
    Core0_nIRQ : in STD_LOGIC;
    MIO : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    PS_SRSTB : inout STD_LOGIC;
    PS_CLK : inout STD_LOGIC;
    PS_PORB : inout STD_LOGIC
  );
  end component oscilloscope_bd_processing_system7_0_1;
  component oscilloscope_bd_adc_processing_0_0 is
  port (
    adc_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    adc_tvalid : in STD_LOGIC;
    ch1_adc : out STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  end component oscilloscope_bd_adc_processing_0_0;
  component oscilloscope_bd_osci_0_1 is
  port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    ch1_adc : in STD_LOGIC_VECTOR ( 11 downto 0 );
    ch1_irq : out STD_LOGIC;
    ch1_en : in STD_LOGIC;
    ch1_rst : in STD_LOGIC;
    ch1_mode : in STD_LOGIC_VECTOR ( 3 downto 0 );
    ch1_edge_sel : in STD_LOGIC_VECTOR ( 3 downto 0 );
    ch1_edge_thre : in STD_LOGIC_VECTOR ( 15 downto 0 );
    ch1_ram_data : out STD_LOGIC_VECTOR ( 15 downto 0 );
    ch1_ram_adr : in STD_LOGIC_VECTOR ( 12 downto 0 )
  );
  end component oscilloscope_bd_osci_0_1;
  component oscilloscope_bd_OsciToCpu_0_3 is
  port (
    ch1_en : out STD_LOGIC;
    ch1_rst : out STD_LOGIC;
    ch1_mode : out STD_LOGIC_VECTOR ( 3 downto 0 );
    ch1_edge_sel : out STD_LOGIC_VECTOR ( 3 downto 0 );
    ch1_edge_thre : out STD_LOGIC_VECTOR ( 15 downto 0 );
    ch1_ram_data : in STD_LOGIC_VECTOR ( 15 downto 0 );
    ch1_ram_adr : out STD_LOGIC_VECTOR ( 12 downto 0 );
    s00_axi_aclk : in STD_LOGIC;
    s00_axi_aresetn : in STD_LOGIC;
    s00_axi_awaddr : in STD_LOGIC_VECTOR ( 4 downto 0 );
    s00_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s00_axi_awvalid : in STD_LOGIC;
    s00_axi_awready : out STD_LOGIC;
    s00_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s00_axi_wvalid : in STD_LOGIC;
    s00_axi_wready : out STD_LOGIC;
    s00_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_bvalid : out STD_LOGIC;
    s00_axi_bready : in STD_LOGIC;
    s00_axi_araddr : in STD_LOGIC_VECTOR ( 4 downto 0 );
    s00_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s00_axi_arvalid : in STD_LOGIC;
    s00_axi_arready : out STD_LOGIC;
    s00_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_rvalid : out STD_LOGIC;
    s00_axi_rready : in STD_LOGIC
  );
  end component oscilloscope_bd_OsciToCpu_0_3;
  signal OsciToCpu_0_ch1_edge_sel : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal OsciToCpu_0_ch1_edge_thre : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal OsciToCpu_0_ch1_en : STD_LOGIC;
  signal OsciToCpu_0_ch1_mode : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal OsciToCpu_0_ch1_ram_adr : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal OsciToCpu_0_ch1_rst : STD_LOGIC;
  signal adc_processing_0_ch1_adc : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal adc_vn_1 : STD_LOGIC;
  signal adc_vp_1 : STD_LOGIC;
  signal axi_interconnect_0_M00_AXI_ARADDR : STD_LOGIC;
  signal axi_interconnect_0_M00_AXI_ARPROT : STD_LOGIC;
  signal axi_interconnect_0_M00_AXI_ARREADY : STD_LOGIC;
  signal axi_interconnect_0_M00_AXI_ARVALID : STD_LOGIC;
  signal axi_interconnect_0_M00_AXI_AWADDR : STD_LOGIC;
  signal axi_interconnect_0_M00_AXI_AWPROT : STD_LOGIC;
  signal axi_interconnect_0_M00_AXI_AWREADY : STD_LOGIC;
  signal axi_interconnect_0_M00_AXI_AWVALID : STD_LOGIC;
  signal axi_interconnect_0_M00_AXI_BREADY : STD_LOGIC;
  signal axi_interconnect_0_M00_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_interconnect_0_M00_AXI_BVALID : STD_LOGIC;
  signal axi_interconnect_0_M00_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_interconnect_0_M00_AXI_RREADY : STD_LOGIC;
  signal axi_interconnect_0_M00_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_interconnect_0_M00_AXI_RVALID : STD_LOGIC;
  signal axi_interconnect_0_M00_AXI_WDATA : STD_LOGIC;
  signal axi_interconnect_0_M00_AXI_WREADY : STD_LOGIC;
  signal axi_interconnect_0_M00_AXI_WSTRB : STD_LOGIC;
  signal axi_interconnect_0_M00_AXI_WVALID : STD_LOGIC;
  signal clk_100MHz_1 : STD_LOGIC;
  signal clk_wiz_0_clk_out1 : STD_LOGIC;
  signal clk_wiz_0_locked : STD_LOGIC;
  signal osci_0_ch1_irq : STD_LOGIC;
  signal osci_0_ch1_ram_data : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal proc_sys_reset_0_interconnect_aresetn : STD_LOGIC_VECTOR ( 0 to 0 );
  signal proc_sys_reset_0_peripheral_aresetn : STD_LOGIC_VECTOR ( 0 to 0 );
  signal processing_system7_0_FIXED_IO_MIO : STD_LOGIC_VECTOR ( 53 downto 0 );
  signal processing_system7_0_FIXED_IO_PS_CLK : STD_LOGIC;
  signal processing_system7_0_FIXED_IO_PS_PORB : STD_LOGIC;
  signal processing_system7_0_FIXED_IO_PS_SRSTB : STD_LOGIC;
  signal reset_1 : STD_LOGIC;
  signal xadc_wiz_0_m_axis_tdata : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal xadc_wiz_0_m_axis_tvalid : STD_LOGIC;
  signal xlconstant_0_dout : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_axi_interconnect_0_S00_AXI_arready_UNCONNECTED : STD_LOGIC;
  signal NLW_axi_interconnect_0_S00_AXI_awready_UNCONNECTED : STD_LOGIC;
  signal NLW_axi_interconnect_0_S00_AXI_bresp_UNCONNECTED : STD_LOGIC;
  signal NLW_axi_interconnect_0_S00_AXI_bvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_axi_interconnect_0_S00_AXI_rdata_UNCONNECTED : STD_LOGIC;
  signal NLW_axi_interconnect_0_S00_AXI_rresp_UNCONNECTED : STD_LOGIC;
  signal NLW_axi_interconnect_0_S00_AXI_rvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_axi_interconnect_0_S00_AXI_wready_UNCONNECTED : STD_LOGIC;
  signal NLW_proc_sys_reset_0_mb_reset_UNCONNECTED : STD_LOGIC;
  signal NLW_proc_sys_reset_0_bus_struct_reset_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_proc_sys_reset_0_peripheral_reset_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_xadc_wiz_0_alarm_out_UNCONNECTED : STD_LOGIC;
  signal NLW_xadc_wiz_0_busy_out_UNCONNECTED : STD_LOGIC;
  signal NLW_xadc_wiz_0_eoc_out_UNCONNECTED : STD_LOGIC;
  signal NLW_xadc_wiz_0_eos_out_UNCONNECTED : STD_LOGIC;
  signal NLW_xadc_wiz_0_channel_out_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_xadc_wiz_0_m_axis_tid_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of FIXED_IO_ps_clk : signal is "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO PS_CLK";
  attribute X_INTERFACE_INFO of FIXED_IO_ps_porb : signal is "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO PS_PORB";
  attribute X_INTERFACE_INFO of FIXED_IO_ps_srstb : signal is "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO PS_SRSTB";
  attribute X_INTERFACE_INFO of adc_vn : signal is "xilinx.com:signal:data:1.0 DATA.ADC_VN DATA";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of adc_vn : signal is "XIL_INTERFACENAME DATA.ADC_VN, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of adc_vp : signal is "xilinx.com:signal:data:1.0 DATA.ADC_VP DATA";
  attribute X_INTERFACE_PARAMETER of adc_vp : signal is "XIL_INTERFACENAME DATA.ADC_VP, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of clk_100MHz : signal is "xilinx.com:signal:clock:1.0 CLK.CLK_100MHZ CLK";
  attribute X_INTERFACE_PARAMETER of clk_100MHz : signal is "XIL_INTERFACENAME CLK.CLK_100MHZ, CLK_DOMAIN oscilloscope_bd_clk_100MHz, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0";
  attribute X_INTERFACE_INFO of reset : signal is "xilinx.com:signal:reset:1.0 RST.RESET RST";
  attribute X_INTERFACE_PARAMETER of reset : signal is "XIL_INTERFACENAME RST.RESET, INSERT_VIP 0, POLARITY ACTIVE_HIGH";
  attribute X_INTERFACE_INFO of FIXED_IO_mio : signal is "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO MIO";
  attribute X_INTERFACE_PARAMETER of FIXED_IO_mio : signal is "XIL_INTERFACENAME FIXED_IO, CAN_DEBUG false";
begin
  adc_vn_1 <= adc_vn;
  adc_vp_1 <= adc_vp;
  clk_100MHz_1 <= clk_100MHz;
  reset_1 <= reset;
OsciToCpu_0: component oscilloscope_bd_OsciToCpu_0_3
     port map (
      ch1_edge_sel(3 downto 0) => OsciToCpu_0_ch1_edge_sel(3 downto 0),
      ch1_edge_thre(15 downto 0) => OsciToCpu_0_ch1_edge_thre(15 downto 0),
      ch1_en => OsciToCpu_0_ch1_en,
      ch1_mode(3 downto 0) => OsciToCpu_0_ch1_mode(3 downto 0),
      ch1_ram_adr(12 downto 0) => OsciToCpu_0_ch1_ram_adr(12 downto 0),
      ch1_ram_data(15 downto 0) => osci_0_ch1_ram_data(15 downto 0),
      ch1_rst => OsciToCpu_0_ch1_rst,
      s00_axi_aclk => clk_wiz_0_clk_out1,
      s00_axi_araddr(4) => axi_interconnect_0_M00_AXI_ARADDR,
      s00_axi_araddr(3) => axi_interconnect_0_M00_AXI_ARADDR,
      s00_axi_araddr(2) => axi_interconnect_0_M00_AXI_ARADDR,
      s00_axi_araddr(1) => axi_interconnect_0_M00_AXI_ARADDR,
      s00_axi_araddr(0) => axi_interconnect_0_M00_AXI_ARADDR,
      s00_axi_aresetn => proc_sys_reset_0_peripheral_aresetn(0),
      s00_axi_arprot(2) => axi_interconnect_0_M00_AXI_ARPROT,
      s00_axi_arprot(1) => axi_interconnect_0_M00_AXI_ARPROT,
      s00_axi_arprot(0) => axi_interconnect_0_M00_AXI_ARPROT,
      s00_axi_arready => axi_interconnect_0_M00_AXI_ARREADY,
      s00_axi_arvalid => axi_interconnect_0_M00_AXI_ARVALID,
      s00_axi_awaddr(4) => axi_interconnect_0_M00_AXI_AWADDR,
      s00_axi_awaddr(3) => axi_interconnect_0_M00_AXI_AWADDR,
      s00_axi_awaddr(2) => axi_interconnect_0_M00_AXI_AWADDR,
      s00_axi_awaddr(1) => axi_interconnect_0_M00_AXI_AWADDR,
      s00_axi_awaddr(0) => axi_interconnect_0_M00_AXI_AWADDR,
      s00_axi_awprot(2) => axi_interconnect_0_M00_AXI_AWPROT,
      s00_axi_awprot(1) => axi_interconnect_0_M00_AXI_AWPROT,
      s00_axi_awprot(0) => axi_interconnect_0_M00_AXI_AWPROT,
      s00_axi_awready => axi_interconnect_0_M00_AXI_AWREADY,
      s00_axi_awvalid => axi_interconnect_0_M00_AXI_AWVALID,
      s00_axi_bready => axi_interconnect_0_M00_AXI_BREADY,
      s00_axi_bresp(1 downto 0) => axi_interconnect_0_M00_AXI_BRESP(1 downto 0),
      s00_axi_bvalid => axi_interconnect_0_M00_AXI_BVALID,
      s00_axi_rdata(31 downto 0) => axi_interconnect_0_M00_AXI_RDATA(31 downto 0),
      s00_axi_rready => axi_interconnect_0_M00_AXI_RREADY,
      s00_axi_rresp(1 downto 0) => axi_interconnect_0_M00_AXI_RRESP(1 downto 0),
      s00_axi_rvalid => axi_interconnect_0_M00_AXI_RVALID,
      s00_axi_wdata(31) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(30) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(29) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(28) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(27) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(26) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(25) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(24) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(23) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(22) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(21) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(20) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(19) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(18) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(17) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(16) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(15) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(14) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(13) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(12) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(11) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(10) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(9) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(8) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(7) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(6) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(5) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(4) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(3) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(2) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(1) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wdata(0) => axi_interconnect_0_M00_AXI_WDATA,
      s00_axi_wready => axi_interconnect_0_M00_AXI_WREADY,
      s00_axi_wstrb(3) => axi_interconnect_0_M00_AXI_WSTRB,
      s00_axi_wstrb(2) => axi_interconnect_0_M00_AXI_WSTRB,
      s00_axi_wstrb(1) => axi_interconnect_0_M00_AXI_WSTRB,
      s00_axi_wstrb(0) => axi_interconnect_0_M00_AXI_WSTRB,
      s00_axi_wvalid => axi_interconnect_0_M00_AXI_WVALID
    );
adc_processing_0: component oscilloscope_bd_adc_processing_0_0
     port map (
      adc_tdata(15 downto 0) => xadc_wiz_0_m_axis_tdata(15 downto 0),
      adc_tvalid => xadc_wiz_0_m_axis_tvalid,
      ch1_adc(11 downto 0) => adc_processing_0_ch1_adc(11 downto 0)
    );
axi_interconnect_0: entity work.oscilloscope_bd_axi_interconnect_0_0
     port map (
      ACLK => clk_wiz_0_clk_out1,
      ARESETN => proc_sys_reset_0_interconnect_aresetn(0),
      M00_ACLK => clk_wiz_0_clk_out1,
      M00_ARESETN => proc_sys_reset_0_interconnect_aresetn(0),
      M00_AXI_araddr => axi_interconnect_0_M00_AXI_ARADDR,
      M00_AXI_arprot => axi_interconnect_0_M00_AXI_ARPROT,
      M00_AXI_arready => axi_interconnect_0_M00_AXI_ARREADY,
      M00_AXI_arvalid => axi_interconnect_0_M00_AXI_ARVALID,
      M00_AXI_awaddr => axi_interconnect_0_M00_AXI_AWADDR,
      M00_AXI_awprot => axi_interconnect_0_M00_AXI_AWPROT,
      M00_AXI_awready => axi_interconnect_0_M00_AXI_AWREADY,
      M00_AXI_awvalid => axi_interconnect_0_M00_AXI_AWVALID,
      M00_AXI_bready => axi_interconnect_0_M00_AXI_BREADY,
      M00_AXI_bresp => axi_interconnect_0_M00_AXI_BRESP(0),
      M00_AXI_bvalid => axi_interconnect_0_M00_AXI_BVALID,
      M00_AXI_rdata => axi_interconnect_0_M00_AXI_RDATA(0),
      M00_AXI_rready => axi_interconnect_0_M00_AXI_RREADY,
      M00_AXI_rresp => axi_interconnect_0_M00_AXI_RRESP(0),
      M00_AXI_rvalid => axi_interconnect_0_M00_AXI_RVALID,
      M00_AXI_wdata => axi_interconnect_0_M00_AXI_WDATA,
      M00_AXI_wready => axi_interconnect_0_M00_AXI_WREADY,
      M00_AXI_wstrb => axi_interconnect_0_M00_AXI_WSTRB,
      M00_AXI_wvalid => axi_interconnect_0_M00_AXI_WVALID,
      S00_ACLK => clk_wiz_0_clk_out1,
      S00_ARESETN => proc_sys_reset_0_interconnect_aresetn(0),
      S00_AXI_araddr => '0',
      S00_AXI_arprot => '0',
      S00_AXI_arready => NLW_axi_interconnect_0_S00_AXI_arready_UNCONNECTED,
      S00_AXI_arvalid => '0',
      S00_AXI_awaddr => '0',
      S00_AXI_awprot => '0',
      S00_AXI_awready => NLW_axi_interconnect_0_S00_AXI_awready_UNCONNECTED,
      S00_AXI_awvalid => '0',
      S00_AXI_bready => '0',
      S00_AXI_bresp => NLW_axi_interconnect_0_S00_AXI_bresp_UNCONNECTED,
      S00_AXI_bvalid => NLW_axi_interconnect_0_S00_AXI_bvalid_UNCONNECTED,
      S00_AXI_rdata => NLW_axi_interconnect_0_S00_AXI_rdata_UNCONNECTED,
      S00_AXI_rready => '0',
      S00_AXI_rresp => NLW_axi_interconnect_0_S00_AXI_rresp_UNCONNECTED,
      S00_AXI_rvalid => NLW_axi_interconnect_0_S00_AXI_rvalid_UNCONNECTED,
      S00_AXI_wdata => '0',
      S00_AXI_wready => NLW_axi_interconnect_0_S00_AXI_wready_UNCONNECTED,
      S00_AXI_wstrb => '0',
      S00_AXI_wvalid => '0'
    );
clk_wiz_0: component oscilloscope_bd_clk_wiz_0_0
     port map (
      clk_in1 => clk_100MHz_1,
      clk_out1 => clk_wiz_0_clk_out1,
      locked => clk_wiz_0_locked,
      reset => reset_1
    );
osci_0: component oscilloscope_bd_osci_0_1
     port map (
      ch1_adc(11 downto 0) => adc_processing_0_ch1_adc(11 downto 0),
      ch1_edge_sel(3 downto 0) => OsciToCpu_0_ch1_edge_sel(3 downto 0),
      ch1_edge_thre(15 downto 0) => OsciToCpu_0_ch1_edge_thre(15 downto 0),
      ch1_en => OsciToCpu_0_ch1_en,
      ch1_irq => osci_0_ch1_irq,
      ch1_mode(3 downto 0) => OsciToCpu_0_ch1_mode(3 downto 0),
      ch1_ram_adr(12 downto 0) => OsciToCpu_0_ch1_ram_adr(12 downto 0),
      ch1_ram_data(15 downto 0) => osci_0_ch1_ram_data(15 downto 0),
      ch1_rst => OsciToCpu_0_ch1_rst,
      clk => clk_wiz_0_clk_out1,
      rst => '0'
    );
proc_sys_reset_0: component oscilloscope_bd_proc_sys_reset_0_0
     port map (
      aux_reset_in => '1',
      bus_struct_reset(0) => NLW_proc_sys_reset_0_bus_struct_reset_UNCONNECTED(0),
      dcm_locked => clk_wiz_0_locked,
      ext_reset_in => reset_1,
      interconnect_aresetn(0) => proc_sys_reset_0_interconnect_aresetn(0),
      mb_debug_sys_rst => '0',
      mb_reset => NLW_proc_sys_reset_0_mb_reset_UNCONNECTED,
      peripheral_aresetn(0) => proc_sys_reset_0_peripheral_aresetn(0),
      peripheral_reset(0) => NLW_proc_sys_reset_0_peripheral_reset_UNCONNECTED(0),
      slowest_sync_clk => clk_wiz_0_clk_out1
    );
processing_system7_0: component oscilloscope_bd_processing_system7_0_1
     port map (
      Core0_nIRQ => osci_0_ch1_irq,
      MIO(53 downto 0) => FIXED_IO_mio(53 downto 0),
      PS_CLK => FIXED_IO_ps_clk,
      PS_PORB => FIXED_IO_ps_porb,
      PS_SRSTB => FIXED_IO_ps_srstb
    );
xadc_wiz_0: component oscilloscope_bd_xadc_wiz_0_0
     port map (
      alarm_out => NLW_xadc_wiz_0_alarm_out_UNCONNECTED,
      busy_out => NLW_xadc_wiz_0_busy_out_UNCONNECTED,
      channel_out(4 downto 0) => NLW_xadc_wiz_0_channel_out_UNCONNECTED(4 downto 0),
      eoc_out => NLW_xadc_wiz_0_eoc_out_UNCONNECTED,
      eos_out => NLW_xadc_wiz_0_eos_out_UNCONNECTED,
      m_axis_aclk => clk_wiz_0_clk_out1,
      m_axis_resetn => proc_sys_reset_0_peripheral_aresetn(0),
      m_axis_tdata(15 downto 0) => xadc_wiz_0_m_axis_tdata(15 downto 0),
      m_axis_tid(4 downto 0) => NLW_xadc_wiz_0_m_axis_tid_UNCONNECTED(4 downto 0),
      m_axis_tready => xlconstant_0_dout(0),
      m_axis_tvalid => xadc_wiz_0_m_axis_tvalid,
      s_axis_aclk => clk_wiz_0_clk_out1,
      vn_in => adc_vn_1,
      vp_in => adc_vp_1
    );
xlconstant_0: component oscilloscope_bd_xlconstant_0_0
     port map (
      dout(0) => xlconstant_0_dout(0)
    );
end STRUCTURE;
