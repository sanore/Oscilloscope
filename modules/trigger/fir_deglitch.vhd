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

entity fir_deglitch_filter is
port(
    sample_clk  : in std_ulogic;
    sample_val   : in std_ulogic_vector(11 downto 0);

    filter_output : out std_ulogic_vector(11 downto 0)
);
end entity fir_deglitch_filter;

architecture RTL of fir_deglitch_filter is
    signal int_val_1: std_ulogic_vector(11 downto 0) := (others => '0');
    signal int_val_2: std_ulogic_vector(11 downto 0) := (others => '0');
    signal int_val_3: std_ulogic_vector(11 downto 0) := (others => '0');
    signal int_val_4: std_ulogic_vector(11 downto 0) := (others => '0');
begin

    sample_process: process(sample_clk)
    begin
        if rising_edge(sample_clk) then
            int_val_4 <= 
            int_val_3 <= int_val_2;
            int_val_2 <= int_val_1;
            int_val_1 <= ("00" & sample_val(11 downto 2));
        end if;
    end process sample_process;

    output_accumulate: process(sample_clk)
    begin
        if falling_edge(sample_clk) then
            filter_output <= std_ulogic_vector(unsigned(int_val_1) +
                unsigned(int_val_2) + unsigned(int_val_3) + unsigned(int_val_4));
        end if;
    end process output_accumulate;

end architecture RTL;