library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- converts XADC output to Osci ADC width
entity adc_processing is
    port(
        adc_tdata : in std_ulogic_vector(15 downto 0);
        adc_tvalid : in std_ulogic;
        
        -- output
        ch1_adc : out std_ulogic_vector(11 downto 0)
    );
end entity adc_processing;


architecture RTL of adc_processing is
    signal ch1_data_reg : std_ulogic_vector(11 downto 0);
begin
    -- select adc data and buffer it until next is valid
    proc : process is
    begin
        if (rising_edge(adc_tvalid)) then
            ch1_data_reg <= adc_tdata(11 downto 0);
        end if;
    end process proc;
    
    ch1_adc <= ch1_data_reg;
end architecture RTL;
