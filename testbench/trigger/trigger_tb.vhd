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

    signal tb_rising_edge_finished  : std_ulogic_vector := '0';
    signal tb_falling_edge_finished : std_logic_vector := '0';

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

    trigger_stimulus_rising_edge: process
        file waveform_data_file : text;
        variable line_buff      : line;
        variable delimiter_buff : character;
        variable input_val_buff : std_ulogic_vector(11 downto 0);
        variable expected_trig_pulse_buff: std_ulogic;
        variable trig_mode_buff : std_ulogic_vector(3 downto 0);
        variable trig_sel_buff  : std_ulogic_vector(3 downto 0);
        variable trig_threshold_buff    : std_ulogic_vector(11 downto 0);
    begin

    -- open test data file
    file_open(waveform_data_file, "rising_edge_test.csv", READ_MODE);

    -- wait for first rising edge
    wait until rising_edge(tb_clk);
    
    -- configure trigger
    -- disable trigger to write configuration
    tb_enable <= '0';
    -- set trigger mode
    readline(waveform_data_file, line_buff);
    read(line_buff, trig_mode_buff);
    tb_trig_mode <= trig_mode_buff;
    -- select rising edge
    readline(waveform_data_file, line_buff);
    read(line_buff, trig_sel_buff);
    tb_trig_sel <= trig_sel_buff;
    -- set threshold
    readline(waveform_data_file, line_buff);
    read(line_buff, trig_threshold_buff);
    tb_trig_threshold <= trig_threshold_buff;

    -- wait for nex rising clock edge
    wait until rising_edge(tb_clk);
    -- trigger config now is stored internally in module, enable it
    tb_enable <= '1';

    -- feed in data
    while not endfile(waveform_data_file) loop
        readline(waveform_data_file, line_buff);
        
        -- set next adc test val
        read(line_buff, input_val_buff);
        tb_adc_val <= input_val_buff;
        -- discard delimiter
        read(line_buff, delimiter_buff);
        -- read expeced trigger_pulse value
        read(line_buff, expected_trig_pulse_buff);

        -- wait for rising clock edge (adc value sampled)
        wait until rising_edge(tb_clk);
        -- wait until falling clock edge (trigger pulse generated)
        wait until falling_edge(tb_clk);

        -- check if trigger outputs expected signal
        assert tb_trig_pulse = expected_trig_pulse_buff report
            "Invalid trigger output. (expected: " &
            to_hstring(to_bit(expected_trig_pulse_buff)) & ", actual: "
            & to_hstring(to_bit(tb_trig_pulse)) & ")." severity failure;
        
    end loop;

    file_close(waveform_data_file);

    -- signal falling edge process to start testing
    tb_rising_edge_finished <= '1';

    wait;

    end process trigger_stimulus_rising_edge;

end architecture RTL;
