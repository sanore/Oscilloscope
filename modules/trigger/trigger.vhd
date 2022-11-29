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

entity trigger is
    port(
        clk : in std_ulogic;
        enable : in std_ulogic;
        
        adc_val: in std_ulogic_vector(11 downto 0);
        
        -- config inputs
        trig_mode: in std_ulogic_vector(3 downto 0);    -- edge/. . . 
        trig_sel: in std_ulogic_vector(3 downto 0);     -- rising/falling/. . .
        trig_threshold: in std_ulogic_vector(11 downto 0);
        
        -- outputs
        trig_pulse: out std_ulogic
    );
end entity trigger;

architecture RTL of trigger is
    -- sample buffers
    signal current_sample: std_ulogic_vector(11 downto 0);
    signal previous_sample : std_ulogic_vector(11 downto 0);

    -- states (required to not trigger immediately when initial sample is non zero)
    type trigger_state_type is (state_stopped, state_starting, state_armed);
    signal current_trigger_state: trigger_state_type := state_stopped;
    signal next_trigger_state: trigger_state_type := state_stopped;

begin

    -- state and sample registers
    -- sample is taken at the rising edge of the clock
    reg_process: process(clk)
    begin
        if rising_edge(clk) then
            if enable = '1' then
                current_trigger_state <= next_trigger_state;
                previous_sample <= current_sample;
                current_sample <= adc_val;
            else
                current_trigger_state <= state_stopped;
                current_sample <= (others => '0');
            end if;
        end if;
    end process reg_process;

end architecture RTL;
