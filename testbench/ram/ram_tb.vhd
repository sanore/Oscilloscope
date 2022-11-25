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

entity ram_tb is
end entity ram_tb;

architecture RTL of ram_tb is
    ----------------------------------------------------------------------------
    -- component
    ----------------------------------------------------------------------------
    
component ram is
    generic(ADDR_WIDTH : integer := 13;
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

begin

end architecture RTL;
