library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrlunit is
    generic(ADDR_WIDTH : integer := 13;
            DATA_WIDTH : integer := 16
           );
    port(
        clk           : in  std_logic;
        rst           : in  std_logic;
        adc_val       : in  std_ulogic_vector(DATA_WIDTH - 1 downto 0);
        -- from trigger block
        trigger_pulse : in  std_ulogic;
        -- to ram
        write_address : out std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
        write_data    : out std_ulogic_vector(DATA_WIDTH - 1 downto 0);
        write_en      : out  std_ulogic;
        -- trigger index output
        trigger_index : out std_ulogic_vector(ADDR_WIDTH - 1 downto 0)
    );
end entity ctrlunit;

architecture RTL of ctrlunit is

begin

end architecture RTL;
