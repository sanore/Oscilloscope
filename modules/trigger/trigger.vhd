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
    
begin

end architecture RTL;
