-- Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
-- Date        : Sun Nov 27 13:55:42 2022
-- Host        : DESKTOP-5F25APE running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               d:/Work/50_Dev/Oscilloscope/project/Oscilloscope.gen/sources_1/bd/oscilloscope_bd/ip/oscilloscope_bd_adc_processing_0_0/oscilloscope_bd_adc_processing_0_0_sim_netlist.vhdl
-- Design      : oscilloscope_bd_adc_processing_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity oscilloscope_bd_adc_processing_0_0_adc_processing is
  port (
    ch1_adc : out STD_LOGIC_VECTOR ( 11 downto 0 );
    adc_tdata : in STD_LOGIC_VECTOR ( 11 downto 0 );
    adc_tvalid : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of oscilloscope_bd_adc_processing_0_0_adc_processing : entity is "adc_processing";
end oscilloscope_bd_adc_processing_0_0_adc_processing;

architecture STRUCTURE of oscilloscope_bd_adc_processing_0_0_adc_processing is
begin
\ch1_data_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => adc_tvalid,
      CE => '1',
      D => adc_tdata(0),
      Q => ch1_adc(0),
      R => '0'
    );
\ch1_data_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => adc_tvalid,
      CE => '1',
      D => adc_tdata(10),
      Q => ch1_adc(10),
      R => '0'
    );
\ch1_data_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => adc_tvalid,
      CE => '1',
      D => adc_tdata(11),
      Q => ch1_adc(11),
      R => '0'
    );
\ch1_data_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => adc_tvalid,
      CE => '1',
      D => adc_tdata(1),
      Q => ch1_adc(1),
      R => '0'
    );
\ch1_data_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => adc_tvalid,
      CE => '1',
      D => adc_tdata(2),
      Q => ch1_adc(2),
      R => '0'
    );
\ch1_data_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => adc_tvalid,
      CE => '1',
      D => adc_tdata(3),
      Q => ch1_adc(3),
      R => '0'
    );
\ch1_data_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => adc_tvalid,
      CE => '1',
      D => adc_tdata(4),
      Q => ch1_adc(4),
      R => '0'
    );
\ch1_data_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => adc_tvalid,
      CE => '1',
      D => adc_tdata(5),
      Q => ch1_adc(5),
      R => '0'
    );
\ch1_data_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => adc_tvalid,
      CE => '1',
      D => adc_tdata(6),
      Q => ch1_adc(6),
      R => '0'
    );
\ch1_data_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => adc_tvalid,
      CE => '1',
      D => adc_tdata(7),
      Q => ch1_adc(7),
      R => '0'
    );
\ch1_data_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => adc_tvalid,
      CE => '1',
      D => adc_tdata(8),
      Q => ch1_adc(8),
      R => '0'
    );
\ch1_data_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => adc_tvalid,
      CE => '1',
      D => adc_tdata(9),
      Q => ch1_adc(9),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity oscilloscope_bd_adc_processing_0_0 is
  port (
    adc_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    adc_tvalid : in STD_LOGIC;
    ch1_adc : out STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of oscilloscope_bd_adc_processing_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of oscilloscope_bd_adc_processing_0_0 : entity is "oscilloscope_bd_adc_processing_0_0,adc_processing,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of oscilloscope_bd_adc_processing_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of oscilloscope_bd_adc_processing_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of oscilloscope_bd_adc_processing_0_0 : entity is "adc_processing,Vivado 2021.1";
end oscilloscope_bd_adc_processing_0_0;

architecture STRUCTURE of oscilloscope_bd_adc_processing_0_0 is
  attribute x_interface_info : string;
  attribute x_interface_info of adc_tvalid : signal is "xilinx.com:interface:axis:1.0 adc TVALID";
  attribute x_interface_info of adc_tdata : signal is "xilinx.com:interface:axis:1.0 adc TDATA";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of adc_tdata : signal is "XIL_INTERFACENAME adc, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 0, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0";
begin
U0: entity work.oscilloscope_bd_adc_processing_0_0_adc_processing
     port map (
      adc_tdata(11 downto 0) => adc_tdata(11 downto 0),
      adc_tvalid => adc_tvalid,
      ch1_adc(11 downto 0) => ch1_adc(11 downto 0)
    );
end STRUCTURE;
