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
-- #                                                                     #
-- # Input file format (.csv):                                           #
-- #    1 line:     trig_mode (4bit)                                     #
-- #    2 line:     trig_sel  (4bit)                                     #
-- #    3 line:     trig_threshold  (12bit)                              #
-- #    4-nth line: adc_val (12bit);[expected trigger output](1bit)      #
-- #                                                                     #
-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity trigger_tb is
end entity trigger_tb;

architecture RTL of trigger_tb is
    ----------------------------------------------------------------------------
    -- component
    ----------------------------------------------------------------------------
    component trigger is
        port(
            clk : in std_ulogic;
            enable : in std_ulogic;
            
            adc_val: in std_ulogic_vector(11 downto 0);
            
            -- config inputs, can only be modified if enable = '0'
            -- edge (0000),  ...
            trig_mode: in std_ulogic_vector(3 downto 0); 
            -- rising (0001), falling (0010), both/threshold (0011), ...
            trig_sel: in std_ulogic_vector(3 downto 0);
            -- value at which to trigger
            trig_threshold: in std_ulogic_vector(11 downto 0);
            
            -- outputs
            trig_pulse: out std_ulogic
        );
    end component;

    ----------------------------------------------------------------------------
    -- constants
    ----------------------------------------------------------------------------
    
    constant f_clk : real := 100.0e6;
    constant t_clk : time := (1.0 sec) / f_clk;
    constant sample_clk  : real := 1.0e6;
    constant t_sample   : time := (1.0 sec) / sample_clk;

    ----------------------------------------------------------------------------
    -- internal signals
    ----------------------------------------------------------------------------
    signal tb_clk       : std_ulogic;
    signal tb_enable    : std_ulogic;
    
    signal tb_adc_val   : std_ulogic_vector(11 downto 0);

    signal tb_trig_mode         : std_ulogic_vector(3 downto 0);
    signal tb_trig_sel          : std_ulogic_vector(3 downto 0);
    signal tb_trig_threshold    : std_ulogic_vector(12 downto 0);
    signal tb_trig_pulse        : std_ulogic_vector;
begin
    DUT: component trigger 
    port map(
        clk => tb_clk,
        enable => tb_enable,
        adc_val => tb_adc_val,
        trig_mode => tb_trig_mode, 
        trig_sel => tb_trig_sel,
        trig_threshold => tb_trig_threshold,
        trig_pulse => tb_trig_pulse
    );

    clock_generator: process
    begin
        tb_clk <= '0';
        loop
            wait for t_clk / 2.0;
            tb_clk <= not tb_clk;
        end loop;
        wait;
    end process clock_generator;

    

end architecture RTL;
