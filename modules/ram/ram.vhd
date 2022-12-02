-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
-- #                                                                     #
-- # Oscilloscope                                                        #
-- # Miniproject Digital Microelectronics (Fall Semester 2022)           #
-- # OST Rapperswil-Jona                                                 #
-- #                                                                     #
-- # Group 7:   Pele Constam                                             #
-- #            Sandro Pedrett                                           #
-- #            Erik Loeffler                                            #
-- #                                                                     #
-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- the ram block of a channel. It is a 16 bit x 8192.
-- 'write_en' must be set to '1' to write.
-- 'read_en' must be pulsed to read out.
-- The generic params must be set to their defaults, as not everything 
-- is working with them as intended for now.
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
        read_data     : out std_ulogic_vector(DATA_WIDTH - 1 downto 0); -- default: 0 (if rst = 1)
        read_en       : in  std_ulogic  -- read pulse, output (read_data) will show data from last read
    );
end entity ram;

architecture RTL of ram is
    type memory_type is array(0 to 2**ADDR_WIDTH - 1) of std_ulogic_vector(DATA_WIDTH - 1 downto 0);
    shared variable mem: memory_type;
begin

    -- writing only
    write_proc: process(clk)
    begin
        if rising_edge(clk) then
            if rst = '0' and write_en = '1' then
                mem(to_integer(unsigned(write_address))) := write_data;
            end if;
        end if;
    end process write_proc;

    -- reading only process
    read_proc: process(clk)
    begin
        if rising_edge(clk) then
            if rst = '0' then
                if read_en = '1' then
                    -- only output data if read_en pulse is received, otherwise
                    -- read_data will hold the data from last memory address
                    read_data <= mem(to_integer(unsigned(read_address)));
                end if;
            else
                -- set output to 0  if reset is high
                read_data <= (others => '0');
            end if;
        end if;
    end process read_proc;

end architecture RTL;
