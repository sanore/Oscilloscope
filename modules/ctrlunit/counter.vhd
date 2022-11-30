library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
    port(
        clk   : in  std_logic;
        rst   : in  std_logic;
        en    : in  std_ulogic;
        count : out std_ulogic_vector(12 downto 0)
    );
end entity counter;

architecture RTL of counter is
    signal count_actual, divisor_actual : integer;
    signal count_next, divisor_next     : integer;
begin
    logic_proc : process(count_actual, divisor_actual) is
    begin
        divisor_next <= divisor_actual + 1;

        if divisor_actual = 100 -1 then
            count_next   <= count_actual + 1;
            divisor_next <= 0;
        end if;
    end process logic_proc;

    clk_proc : process(clk) is
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                count_actual   <= 0;
                divisor_actual <= 0;
            else
                if (en = '1') then
                    count_actual   <= count_next;
                    divisor_actual <= divisor_next;
                end if;
            end if;
        end if;
    end process clk_proc;

    count <= std_ulogic_vector(to_unsigned(count_actual, count'length));
end architecture RTL;
