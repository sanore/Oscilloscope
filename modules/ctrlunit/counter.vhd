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
    signal count_actual : std_ulogic_vector(12 downto 0) := (others => '0');
    signal count_next : std_ulogic_vector(12 downto 0) := "0000000000001";
    signal divisor_actual, divisor_next     : std_ulogic_vector(6 downto 0);
begin
    logic_proc : process(count_actual, divisor_actual) is
    begin
        divisor_next <= std_ulogic_vector(unsigned(divisor_actual) + 1);

        if unsigned(divisor_actual) = 100 - 1 then
            if unsigned(count_actual) = "1111111111111" then
                count_next <= (others => '0');
            else
                count_next   <= std_ulogic_vector(unsigned(count_actual) + 1);
            end if;
            divisor_next <= (others => '0');
        end if;
    end process logic_proc;

    clk_proc : process(clk) is
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
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
