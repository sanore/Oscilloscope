-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
-- #                                                                     #
-- # Oscilloscope                                                        #
-- # Miniproject Digital Microelectronics (Fall Semester 2022)           #
-- # OST Rapperswil-Jona                                                 #
-- #                                                                     #
-- # Group 7:   Pelé Constam                                             #
-- #            Sandro Pedrett                                           #
-- #            Erik Löffler                                             #
-- #                                                                     #
-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity ram_tb is
end entity ram_tb;

architecture RTL of ram_tb is
    ----------------------------------------------------------------------------
    -- component
    ----------------------------------------------------------------------------
    
    component ram is
        generic(
            ADDR_WIDTH : integer := 13;
            DATA_WIDTH : integer := 16
        );
        port(
            clk           : in  std_logic;
            rst           : in  std_logic;
            write_address : in  std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
            write_data    : in  std_ulogic_vector(DATA_WIDTH - 1 downto 0);
            write_en      : in  std_ulogic;
            read_address  : in std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
            read_data     : out std_ulogic_vector(DATA_WIDTH - 1 downto 0);
            read_en       : in  std_ulogic
        );
    end component;

    ----------------------------------------------------------------------------
    -- constants
    ----------------------------------------------------------------------------
    
    constant f_clk : real := 100.0e6;
    constant t_clk : time := (1.0 sec) / f_clk; 
    
    ----------------------------------------------------------------------------
    -- internal signals
    ----------------------------------------------------------------------------
    signal tb_clk : std_ulogic;
    signal tb_rst : std_ulogic;
    
    signal tb_write_address : std_ulogic_vector(12 downto 0);
    signal tb_write_data: std_ulogic_vector(15 downto 0);
    signal tb_write_en : std_ulogic;

    signal tb_read_address : std_ulogic_vector(12 downto 0);
    signal tb_read_data: std_ulogic_vector(15 downto 0);
    signal tb_read_en : std_ulogic;

begin

    DUT: component ram 
    generic map(
        ADDR_WIDTH => 13,
        DATA_WIDTH => 16
    )
    port map(
        clk => tb_clk,
        rst => tb_rst,
        
        write_address => tb_write_address,
        write_data => tb_write_data,
        write_en => tb_write_en,
        
        read_address => tb_read_address,
        read_data => tb_read_data,
        read_en => tb_read_en
    );

    clock_generator: process
    begin
        tb_clk <= '0';
        loop
            wait for t_clk / 2.0;
            tb_clk <= not tb_clk;
        end loop;
        wait;
    end process clock_generator;

    

end architecture RTL;
