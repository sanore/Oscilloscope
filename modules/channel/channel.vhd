library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity channel is
    generic(ADDR_WIDTH : integer := 13;
            DATA_WIDTH : integer := 16
           );
    port(
        clk           : in  std_logic;
        rst           : in  std_logic;
        -- write interface
        write_address : in  std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
        write_data    : in  std_ulogic_vector(DATA_WIDTH - 1 downto 0);
        write_en      : in  std_ulogic;
        --read interface
        read_address  : out std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
        read_data     : out std_ulogic_vector(DATA_WIDTH - 1 downto 0);
        read_en       : in  std_ulogic;
        -- channel state
        state         : out std_ulogic_vector(3 downto 0)
    );
end entity channel;

architecture RTL of channel is

begin

end architecture RTL;
