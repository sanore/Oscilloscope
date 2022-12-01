-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
-- #                                                                     #
-- # Oscilloscope                                                        #
-- # Miniproject Digital Microelectronics (Fall Semester 2022)           #
-- # OST Rapperswil-Jona                                                 #
-- #                                                                     #
-- # Group 7:   PelÃ© Constam                                            #
-- #            Sandro Pedrett                                           #
-- #            Erik LÃ¶ffler                                            #
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

entity chanel_tb is
end entity chanel_tb;

architecture RTL of chanel_tb is
    ----------------------------------------------------------------------------
    -- component
    ----------------------------------------------------------------------------
    component channel is
    generic(
        ADDR_WIDTH : integer := 13;
        DATA_WIDTH : integer := 16
    );
    port(
        clk              : in std_logic;
        rst              : in std_logic;
        start            : in std_ulogic;
        
        --read ram
        read_address     : in std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
        read_data        : out std_ulogic_vector(DATA_WIDTH - 1 downto 0);
        read_en          : in  std_ulogic;
        
        -- channel state
        mode              : in std_ulogic_vector(3 downto 0);
        edge_sel          : in std_ulogic_vector(3 downto 0);
        edge_thre         : in std_ulogic_vector(15 downto 0);
        record_ready_irq  : out std_ulogic; 
        adc_val           : in  std_ulogic_vector(11 downto 0);
        trigger_index : out std_ulogic_vector(ADDR_WIDTH - 1 downto 0)
    );
    end component channel;


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
    signal tb_sample_clk   : std_ulogic;
    signal tb_reset    : std_logic := '1';
    signal tb_start    : std_logic;
    
    signal tb_adc_val   : std_ulogic_vector(11 downto 0);

    signal tb_trig_mode         : std_ulogic_vector(3 downto 0);
    signal tb_trig_sel          : std_ulogic_vector(3 downto 0);
    signal tb_trig_threshold    : std_ulogic_vector(11 downto 0);

    signal tb_read_data_addr    : std_ulogic_vector(12 downto 0);
    signal tb_read_data         : std_ulogic_vector(15 downto 0);
    signal tb_read_enable       : std_ulogic;

    signal tb_recording_ready_irq : std_ulogic;
    signal tb_trigger_index       : std_ulogic_vector(12 downto 0);
    
begin

    DUT: component channel
        generic map(
            ADDR_WIDTH => 13,
            DATA_WIDTH => 16
        )
        port map(
            clk => tb_clk,
            rst => tb_reset,
            start => tb_start,
            
            --read ram
            read_address    => tb_read_data_addr,
            read_data       => tb_read_data,
            read_en         => tb_read_enable,
            
            -- channel state
            mode          => tb_trig_mode,
            edge_sel      => tb_trig_sel,
            edge_thre     => tb_trig_threshold,
            record_ready_irq  => tb_recording_ready_irq,
            adc_val           => tb_adc_val,
            trigger_index => tb_trigger_index
    );

    tb_clock_generator: process
    begin
        tb_clk <= '0';
        loop
            wait for t_clk / 2.0;
            tb_clk <= not tb_clk;
        end loop;
        wait;
    end process tb_clock_generator;

    sample_clock_generator: process
    begin
        tb_sample_clk <= '0';
        loop
            wait for t_sample / 2.0;
            tb_sample_clk <= not tb_sample_clk;
        end loop;
        wait;
    end process sample_clock_generator;

    chanel_stimulus: process
        file waveform_data_file : text;
        variable line_buff      : line;
        variable delimiter_buff : character;
        variable input_val_buff : std_ulogic_vector(11 downto 0);
        variable trig_mode_buff : std_ulogic_vector(3 downto 0);
        variable trig_sel_buff  : std_ulogic_vector(3 downto 0);
        variable trig_threshold_buff    : std_ulogic_vector(11 downto 0);
    begin

    -- open test data file
    file_open(waveform_data_file, "rising_edge_test.csv", READ_MODE);

    -- wait for next rising edge
    wait until rising_edge(tb_clk);
    
    -- configure chanel
    -- reset high -> channel can be configured
    tb_reset <= '1';

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

    -- wait for next rising clock edge
    wait until rising_edge(tb_clk);
    -- trigger config now is stored internally in module, enable it
    tb_reset <= '0';

    -- feed in data
    while not endfile(waveform_data_file) loop        
        readline(waveform_data_file, line_buff);

        -- wait until next sample
        wait until rising_edge(tb_sample_clk);
        
        -- set next adc test val
        read(line_buff, input_val_buff);
        tb_adc_val <= input_val_buff;
        -- discard delimiter
        read(line_buff, delimiter_buff);

        -- wait for rising clock edge (adc value sampled)
        wait until rising_edge(tb_clk);

        -- wait until falling clock edge (trigger pulse generated)
        wait until falling_edge(tb_clk);
        -- wait a bit more
        wait for 1 ns;
        
    end loop;

    file_close(waveform_data_file);

    assert false report "Simulation completed." severity failure;

    end process chanel_stimulus;

end architecture RTL;
