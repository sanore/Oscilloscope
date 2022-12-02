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

-- The control unit is the brain of a channel.
-- It contains the logic to start an aquisition, 
-- write the ADC samples into the block ram,
-- and stop the aqusition when a trigger occurs and the ram is filled.
-- Currently, only 50% pre/post trigger samples is supported.
-- The generic params must be set to their defaults, as not everything 
-- is working with them as intended for now.
entity ctrlunit is
    generic(ADDR_WIDTH : integer := 13;
            DATA_WIDTH : integer := 16
           );
    port(
        -- system clock
        clk           : in  std_logic;
        -- system reset
        rst           : in  std_logic;
        -- single pulse to start an aquisition
        start_record  : in  std_logic;
        -- current adc value
        adc_val       : in  std_ulogic_vector(11 downto 0);
        -- from trigger block to
        trigger_pulse : in  std_ulogic;
        -- to ram block
        write_address : out std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
        write_data    : out std_ulogic_vector(DATA_WIDTH - 1 downto 0);
        write_en      : out std_ulogic;
        -- trigger index output
        trigger_index : out std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
        -- irq output. single pulse to notify aquisition complete.
        record_ready_irq  : out std_ulogic
    );
end entity ctrlunit;

architecture RTL of ctrlunit is
    type State is (reset, idle, read_half, wait_for_trigger, triggered, wait_for_full);
    constant addr_offset : unsigned(ADDR_WIDTH - 1 downto 0) := to_unsigned(4096, write_address'length);
    -- current sample count / ram address to write
    signal sample_counter      : std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
    -- ram index of the sample at the trigger.
    signal trigger_counter_idx : std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
    -- enable for the sample counter
    signal sample_counter_en   : std_ulogic;
    signal mode                : State;
    signal mode_next           : State;
    signal sample_counter_rst  : std_logic;
    component counter
        port(
            clk   : in  std_logic;
            rst   : in  std_logic;
            en    : in  std_logic;
            count : out std_ulogic_vector(ADDR_WIDTH - 1 downto 0)
        );
    end component counter;

begin
    -- sample counter. Its counts the samples received and at the 
    -- same time is the index for where to put the current sample in ram.
    c1 : counter
        port map(
            clk   => clk,
            rst   => sample_counter_rst,
            en    => sample_counter_en,
            count => sample_counter
        );

    -- this process controls when and how data is written to the ram.
    write_data_process : process(mode, sample_counter, adc_val) is
    begin
        write_en      <= '0';
        -- The ram must only be written to when aquiring.
        if (mode = read_half or mode = wait_for_trigger or mode = wait_for_full or mode = triggered) then
            write_en <= '1';
            write_address <= sample_counter;
            write_data <= std_ulogic_vector(to_unsigned(0, DATA_WIDTH - 12)) & adc_val;
        end if;
    end process write_data_process;

    -- state machine with outputs
    state_process : process(trigger_pulse, mode, sample_counter, start_record, trigger_counter_idx) is
    begin
        sample_counter_rst <= '0';
        sample_counter_en  <= '0';
        record_ready_irq <= '0';
        mode_next <= reset;

        if (mode = reset) then
            -- system reset
            mode_next           <= idle;
            sample_counter_rst  <= '1';
        elsif (mode = idle) then
            -- do nothing until start_record is 1
            mode_next <= idle;
            if (start_record = '1') then
                mode_next <= read_half;
                sample_counter_en <= '1';
            end if;
        elsif mode = read_half then
            -- fill half of the ram before allowing to be triggered.
            -- This way, the ram is never contains old data.
            mode_next <= read_half;
            sample_counter_en  <= '1';
            if(unsigned(sample_counter) >= addr_offset) then
                mode_next <= wait_for_trigger ;
            end if;
        elsif (mode = wait_for_trigger) then
            -- aquire as long no trigger occured
            mode_next <= wait_for_trigger;
            sample_counter_en  <= '1';

            if (trigger_pulse = '1') then
                mode_next <= triggered;
            end if;
        elsif (mode = triggered) then
            -- trigger block decided a trigger happend
            trigger_counter_idx <= sample_counter;
            mode_next           <= wait_for_full;
            sample_counter_en  <= '1';

        elsif (mode = wait_for_full) then
            mode_next <= wait_for_full;
            sample_counter_en  <= '1';
            -- wait until sample counter is ram offset, i.e. half of ram is filled after trigger.
            if ((unsigned(sample_counter) - addr_offset) = (unsigned(trigger_counter_idx))) then
                mode_next          <= idle;
                record_ready_irq <= '1';
                sample_counter_rst <= '1';
                sample_counter_en  <= '0';
            end if;

        end if;

    end process state_process;
    
    reg_proc : process(clk) is
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                mode          <= reset;
                trigger_index <= (others => '0');
            else
                trigger_index <= trigger_counter_idx;
                mode          <= mode_next;
            end if;
        end if;
    end process reg_proc;

end architecture RTL;
