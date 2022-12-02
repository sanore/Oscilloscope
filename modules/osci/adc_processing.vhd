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

-- converts XADC output to Osci ADC width
entity adc_processing is
    port(
        adc_data : in std_ulogic_vector(15 downto 0);
        adc_valid : in std_ulogic;
        
        -- output
        ch1_adc : out std_ulogic_vector(11 downto 0)
    );
end entity adc_processing;


architecture RTL of adc_processing is
    signal ch1_data_reg : std_ulogic_vector(11 downto 0);
begin
    -- select adc data and buffer it until next is valid
    proc : process (adc_valid) is
    begin
        if (rising_edge(adc_valid)) then
            ch1_data_reg <= adc_data(11 downto 0);
        end if;
    end process proc;
    
    ch1_adc <= ch1_data_reg;
end architecture RTL;

