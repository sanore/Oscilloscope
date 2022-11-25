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

entity ram is
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
        read_address  : in std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
        read_data     : out std_ulogic_vector(DATA_WIDTH - 1 downto 0);
        read_en       : in  std_ulogic
    );
end entity ram;

architecture RTL of ram is
    type memory_type is array(0 to 2**ADDR_WIDTH - 1) of std_ulogic_vector(DATA_WIDTH - 1 downto 0);
    shared variable mem: memory_type;
begin

    -- writing 
    write_proc: process(clk)
    begin
        if rising_edge(clk) then
            if rst = '0' and write_en = '1' then
                mem(to_integer(unsigned(write_address))) := write_data;
            end if;
        end if;
    end process write_proc;

    read_proc: process(clk)
    begin
        if rising_edge(clk) then
            if rst = '0' and read_en = '1' then
                read_data <= mem(to_integer(unsigned(read_address)));
            else
                read_data <= (others => '0');
            end if;
        end if;
    end process read_proc;

end architecture RTL;
