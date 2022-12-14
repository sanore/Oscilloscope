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

-- A simple 13-bit counter. It counts up by one every 100 'clk' cycles.
-- The unit only counts up and when 'en'(enable) is '1'.
-- When 'en' is 0, the counter stops, but holds its last count.
-- A hard reset is done by settings 'rst' to '1'. This will set the count to 0.
entity counter is
    port(
        clk   : in  std_logic;
        rst   : in  std_logic;
        en    : in  std_ulogic;
        count : out std_ulogic_vector(12 downto 0)
    );
end entity counter;

architecture RTL of counter is
    signal count_actual : std_ulogic_vector(12 downto 0);
    signal count_next : std_ulogic_vector(12 downto 0) ;
    signal divisor_actual, divisor_next     : std_ulogic_vector(6 downto 0);
begin
    logic_proc : process(count_actual, divisor_actual) is
    begin
        divisor_next <= std_ulogic_vector(unsigned(divisor_actual) + 1);
        count_next <= count_actual;
        if unsigned(divisor_actual) = 100 - 1 then
            if unsigned(count_actual) = "1111111111111" then
                count_next <= (others => '0');
            else
                count_next <= std_ulogic_vector(unsigned(count_actual) + 1);
            end if;
            divisor_next <= (others => '0');
        end if;
    end process logic_proc;

    clk_proc : process(clk) is
    begin
        if (rising_edge(clk)) then

            if rst = '1' then
                count_actual   <= (others => '0');
                divisor_actual <= (others => '0');
            else
                if (en = '1') then
                    count_actual   <= count_next;
                    divisor_actual <= divisor_next;
                end if;
            end if;
        end if;
    end process clk_proc;

    count <= count_actual;
end architecture RTL;
