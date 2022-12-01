-- Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
-- Date        : Wed Nov 30 11:41:36 2022
-- Host        : hn600365 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top oscilloscope_bd_adc_processing_0_1 -prefix
--               oscilloscope_bd_adc_processing_0_1_ oscilloscope_bd_adc_processing_0_0_sim_netlist.vhdl
-- Design      : oscilloscope_bd_adc_processing_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity oscilloscope_bd_adc_processing_0_1_adc_processing is
  port (
    ch1_adc : out STD_LOGIC_VECTOR ( 11 downto 0 );
    adc_data : in STD_LOGIC_VECTOR ( 11 downto 0 );
    adc_valid : in STD_LOGIC
  );
end oscilloscope_bd_adc_processing_0_1_adc_processing;

architecture STRUCTURE of oscilloscope_bd_adc_processing_0_1_adc_processing is
begin
\ch1_data_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => adc_valid,
      CE => '1',
      D => adc_data(0),
      Q => ch1_adc(0),
      R => '0'
    );
\ch1_data_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => adc_valid,
      CE => '1',
      D => adc_data(10),
      Q => ch1_adc(10),
      R => '0'
    );
\ch1_data_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => adc_valid,
      CE => '1',
      D => adc_data(11),
      Q => ch1_adc(11),
      R => '0'
    );
\ch1_data_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => adc_valid,
      CE => '1',
      D => adc_data(1),
      Q => ch1_adc(1),
      R => '0'
    );
\ch1_data_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => adc_valid,
      CE => '1',
      D => adc_data(2),
      Q => ch1_adc(2),
      R => '0'
    );
\ch1_data_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => adc_valid,
      CE => '1',
      D => adc_data(3),
      Q => ch1_adc(3),
      R => '0'
    );
\ch1_data_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => adc_valid,
      CE => '1',
      D => adc_data(4),
      Q => ch1_adc(4),
      R => '0'
    );
\ch1_data_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => adc_valid,
      CE => '1',
      D => adc_data(5),
      Q => ch1_adc(5),
      R => '0'
    );
\ch1_data_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => adc_valid,
      CE => '1',
      D => adc_data(6),
      Q => ch1_adc(6),
      R => '0'
    );
\ch1_data_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => adc_valid,
      CE => '1',
      D => adc_data(7),
      Q => ch1_adc(7),
      R => '0'
    );
\ch1_data_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => adc_valid,
      CE => '1',
      D => adc_data(8),
      Q => ch1_adc(8),
      R => '0'
    );
\ch1_data_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => adc_valid,
      CE => '1',
      D => adc_data(9),
      Q => ch1_adc(9),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity oscilloscope_bd_adc_processing_0_1 is
  port (
    adc_data : in STD_LOGIC_VECTOR ( 15 downto 0 );
    adc_valid : in STD_LOGIC;
    ch1_adc : out STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of oscilloscope_bd_adc_processing_0_1 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of oscilloscope_bd_adc_processing_0_1 : entity is "oscilloscope_bd_adc_processing_0_0,adc_processing,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of oscilloscope_bd_adc_processing_0_1 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of oscilloscope_bd_adc_processing_0_1 : entity is "adc_processing,Vivado 2021.1";
end oscilloscope_bd_adc_processing_0_1;

architecture STRUCTURE of oscilloscope_bd_adc_processing_0_1 is
begin
U0: entity work.oscilloscope_bd_adc_processing_0_1_adc_processing
     port map (
      adc_data(11 downto 0) => adc_data(11 downto 0),
      adc_valid => adc_valid,
      ch1_adc(11 downto 0) => ch1_adc(11 downto 0)
    );
end STRUCTURE;
