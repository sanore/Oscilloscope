-- Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
-- Date        : Mon Nov 28 14:48:57 2022
-- Host        : WS-EL-501017 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               u:/DigMe/Oscilloscope/project/Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ip/oscilloscope_bd_osci_0_1/oscilloscope_bd_osci_0_1_sim_netlist.vhdl
-- Design      : oscilloscope_bd_osci_0_1
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity oscilloscope_bd_osci_0_1_channel is
  port (
    ch1_ram_data : out STD_LOGIC_VECTOR ( 15 downto 0 );
    clk : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 12 downto 0 );
    read_en : in STD_LOGIC;
    rst : in STD_LOGIC;
    ch1_rst : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of oscilloscope_bd_osci_0_1_channel : entity is "channel";
end oscilloscope_bd_osci_0_1_channel;

architecture STRUCTURE of oscilloscope_bd_osci_0_1_channel is
  component oscilloscope_bd_osci_0_1_ram is
  port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    write_address : in STD_LOGIC_VECTOR ( 12 downto 0 );
    write_data : in STD_LOGIC_VECTOR ( 15 downto 0 );
    write_en : in STD_LOGIC;
    read_address : in STD_LOGIC_VECTOR ( 12 downto 0 );
    read_data : out STD_LOGIC_VECTOR ( 15 downto 0 );
    read_en : in STD_LOGIC
  );
  end component oscilloscope_bd_osci_0_1_ram;
  signal storage_i_1_n_0 : STD_LOGIC;
  attribute ADDR_WIDTH : integer;
  attribute ADDR_WIDTH of storage : label is 13;
  attribute DATA_WIDTH : integer;
  attribute DATA_WIDTH of storage : label is 16;
begin
storage: component oscilloscope_bd_osci_0_1_ram
     port map (
      clk => clk,
      read_address(12 downto 0) => Q(12 downto 0),
      read_data(15 downto 0) => ch1_ram_data(15 downto 0),
      read_en => read_en,
      rst => storage_i_1_n_0,
      write_address(12 downto 0) => B"0000000000000",
      write_data(15 downto 0) => B"0000000000000000",
      write_en => '0'
    );
storage_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => rst,
      I1 => ch1_rst,
      O => storage_i_1_n_0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity oscilloscope_bd_osci_0_1_osci is
  port (
    ch1_ram_data : out STD_LOGIC_VECTOR ( 15 downto 0 );
    ch1_ram_adr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    ch1_rst : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of oscilloscope_bd_osci_0_1_osci : entity is "osci";
end oscilloscope_bd_osci_0_1_osci;

architecture STRUCTURE of oscilloscope_bd_osci_0_1_osci is
  signal \last_read_address[12]_i_3_n_0\ : STD_LOGIC;
  signal \last_read_address[12]_i_4_n_0\ : STD_LOGIC;
  signal \last_read_address[12]_i_5_n_0\ : STD_LOGIC;
  signal \last_read_address[12]_i_6_n_0\ : STD_LOGIC;
  signal \last_read_address[12]_i_7_n_0\ : STD_LOGIC;
  signal \last_read_address_reg[12]_i_2_n_0\ : STD_LOGIC;
  signal \last_read_address_reg[12]_i_2_n_1\ : STD_LOGIC;
  signal \last_read_address_reg[12]_i_2_n_2\ : STD_LOGIC;
  signal \last_read_address_reg[12]_i_2_n_3\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
  signal read_address : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal read_en : STD_LOGIC;
  signal \NLW_last_read_address_reg[12]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_last_read_address_reg[12]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_last_read_address_reg[12]_i_2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
begin
ch1: entity work.oscilloscope_bd_osci_0_1_channel
     port map (
      Q(12 downto 0) => read_address(12 downto 0),
      ch1_ram_data(15 downto 0) => ch1_ram_data(15 downto 0),
      ch1_rst => ch1_rst,
      clk => clk,
      read_en => read_en,
      rst => rst
    );
ch1_read_en_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in,
      Q => read_en,
      R => '0'
    );
\last_read_address[12]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => ch1_ram_adr(12),
      I1 => read_address(12),
      O => \last_read_address[12]_i_3_n_0\
    );
\last_read_address[12]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => read_address(9),
      I1 => ch1_ram_adr(9),
      I2 => ch1_ram_adr(11),
      I3 => read_address(11),
      I4 => ch1_ram_adr(10),
      I5 => read_address(10),
      O => \last_read_address[12]_i_4_n_0\
    );
\last_read_address[12]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => read_address(6),
      I1 => ch1_ram_adr(6),
      I2 => ch1_ram_adr(8),
      I3 => read_address(8),
      I4 => ch1_ram_adr(7),
      I5 => read_address(7),
      O => \last_read_address[12]_i_5_n_0\
    );
\last_read_address[12]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => read_address(3),
      I1 => ch1_ram_adr(3),
      I2 => ch1_ram_adr(5),
      I3 => read_address(5),
      I4 => ch1_ram_adr(4),
      I5 => read_address(4),
      O => \last_read_address[12]_i_6_n_0\
    );
\last_read_address[12]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => read_address(0),
      I1 => ch1_ram_adr(0),
      I2 => ch1_ram_adr(2),
      I3 => read_address(2),
      I4 => ch1_ram_adr(1),
      I5 => read_address(1),
      O => \last_read_address[12]_i_7_n_0\
    );
\last_read_address_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => ch1_ram_adr(0),
      Q => read_address(0),
      R => '0'
    );
\last_read_address_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => ch1_ram_adr(10),
      Q => read_address(10),
      R => '0'
    );
\last_read_address_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => ch1_ram_adr(11),
      Q => read_address(11),
      R => '0'
    );
\last_read_address_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => ch1_ram_adr(12),
      Q => read_address(12),
      R => '0'
    );
\last_read_address_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \last_read_address_reg[12]_i_2_n_0\,
      CO(3 downto 1) => \NLW_last_read_address_reg[12]_i_1_CO_UNCONNECTED\(3 downto 1),
      CO(0) => p_0_in,
      CYINIT => '0',
      DI(3 downto 0) => B"0001",
      O(3 downto 0) => \NLW_last_read_address_reg[12]_i_1_O_UNCONNECTED\(3 downto 0),
      S(3 downto 1) => B"000",
      S(0) => \last_read_address[12]_i_3_n_0\
    );
\last_read_address_reg[12]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \last_read_address_reg[12]_i_2_n_0\,
      CO(2) => \last_read_address_reg[12]_i_2_n_1\,
      CO(1) => \last_read_address_reg[12]_i_2_n_2\,
      CO(0) => \last_read_address_reg[12]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"1111",
      O(3 downto 0) => \NLW_last_read_address_reg[12]_i_2_O_UNCONNECTED\(3 downto 0),
      S(3) => \last_read_address[12]_i_4_n_0\,
      S(2) => \last_read_address[12]_i_5_n_0\,
      S(1) => \last_read_address[12]_i_6_n_0\,
      S(0) => \last_read_address[12]_i_7_n_0\
    );
\last_read_address_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => ch1_ram_adr(1),
      Q => read_address(1),
      R => '0'
    );
\last_read_address_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => ch1_ram_adr(2),
      Q => read_address(2),
      R => '0'
    );
\last_read_address_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => ch1_ram_adr(3),
      Q => read_address(3),
      R => '0'
    );
\last_read_address_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => ch1_ram_adr(4),
      Q => read_address(4),
      R => '0'
    );
\last_read_address_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => ch1_ram_adr(5),
      Q => read_address(5),
      R => '0'
    );
\last_read_address_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => ch1_ram_adr(6),
      Q => read_address(6),
      R => '0'
    );
\last_read_address_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => ch1_ram_adr(7),
      Q => read_address(7),
      R => '0'
    );
\last_read_address_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => ch1_ram_adr(8),
      Q => read_address(8),
      R => '0'
    );
\last_read_address_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => ch1_ram_adr(9),
      Q => read_address(9),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity oscilloscope_bd_osci_0_1 is
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of oscilloscope_bd_osci_0_1 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of oscilloscope_bd_osci_0_1 : entity is "oscilloscope_bd_osci_0_1,osci,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of oscilloscope_bd_osci_0_1 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of oscilloscope_bd_osci_0_1 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of oscilloscope_bd_osci_0_1 : entity is "osci,Vivado 2021.1";
end oscilloscope_bd_osci_0_1;

architecture STRUCTURE of oscilloscope_bd_osci_0_1 is
  signal \<const0>\ : STD_LOGIC;
  attribute x_interface_info : string;
  attribute x_interface_info of ch1_irq : signal is "xilinx.com:signal:interrupt:1.0 ch1_irq INTERRUPT";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of ch1_irq : signal is "XIL_INTERFACENAME ch1_irq, SENSITIVITY LEVEL_HIGH, PortWidth 1";
  attribute x_interface_info of ch1_rst : signal is "xilinx.com:signal:reset:1.0 ch1_rst RST";
  attribute x_interface_parameter of ch1_rst : signal is "XIL_INTERFACENAME ch1_rst, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute x_interface_info of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute x_interface_parameter of clk : signal is "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0";
  attribute x_interface_info of rst : signal is "xilinx.com:signal:reset:1.0 rst RST";
  attribute x_interface_parameter of rst : signal is "XIL_INTERFACENAME rst, POLARITY ACTIVE_HIGH, INSERT_VIP 0";
begin
  ch1_irq <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
U0: entity work.oscilloscope_bd_osci_0_1_osci
     port map (
      ch1_ram_adr(12 downto 0) => ch1_ram_adr(12 downto 0),
      ch1_ram_data(15 downto 0) => ch1_ram_data(15 downto 0),
      ch1_rst => ch1_rst,
      clk => clk,
      rst => rst
    );
end STRUCTURE;
