library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrlunit is
    generic(ADDR_WIDTH : integer := 13;
            DATA_WIDTH : integer := 16
           );
    port(
        clk           : in  std_logic;
        rst           : in  std_logic;
        start_record  : in  std_logic;
        adc_val       : in  std_ulogic_vector(11 downto 0);
        -- from trigger block
        trigger_pulse : in  std_ulogic;
        -- to ram
        write_address : out std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
        write_data    : out std_ulogic_vector(DATA_WIDTH - 1 downto 0);
        write_en      : out std_ulogic;
        -- trigger index output
        trigger_index : out std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
        -- irq output
        record_ready_irq  : out std_ulogic
    );
end entity ctrlunit;

architecture RTL of ctrlunit is
    type State is (reset, idle, wait_for_trigger, triggered, wait_for_full);
    constant addr_offset : unsigned(ADDR_WIDTH - 1 downto 0) := to_unsigned(integer(2 ** (ADDR_WIDTH) - 1) / 2, write_address'length);

    signal sample_counter      : std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
    signal trigger_counter_idx : std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
    signal sample_counter_en   : std_ulogic;
    signal mode                : State;
    signal mode_next           : State;
    signal sample_counter_rst  : std_logic;
    component counter
        port(
            clk   : in  std_logic;
            rst   : in  std_logic;
            en    : in  std_ulogic;
            count : out std_ulogic_vector(ADDR_WIDTH - 1 downto 0)
        );
    end component counter;

begin
    c1 : counter
        port map(
            clk   => clk,
            rst   => sample_counter_rst,
            en    => sample_counter_en,
            count => sample_counter
        );

    write_data_process : process(mode, sample_counter, adc_val) is
    begin
        write_en <= '0';
        
        if (mode = wait_for_trigger or mode = wait_for_full or mode = triggered) then
            write_en <= '1';
            write_address <= sample_counter;
            write_data <= std_ulogic_vector(to_unsigned(0, DATA_WIDTH - 12)) & adc_val;
        end if;
    end process write_data_process;

    trigger_process : process(trigger_pulse, mode, sample_counter, start_record, trigger_counter_idx) is
    begin
        record_ready_irq <= '0';
        sample_counter_rst <= '0';
        if (mode = reset) then
            mode_next           <= idle;
            sample_counter_rst  <= '1';
        elsif (mode = idle) then
            if (start_record = '1') then
                mode_next <= wait_for_trigger;
            end if;
        elsif (mode = wait_for_trigger) then
            sample_counter_rst <= '0';
            sample_counter_en  <= '1';

            if (rising_edge(trigger_pulse)) then
                mode_next <= triggered;
            end if;

        elsif (mode = triggered) then
            trigger_counter_idx <= sample_counter;
            mode_next           <= wait_for_full;

        elsif (mode = wait_for_full) then
            -- wait until sample counter is ram offset
            if ((unsigned(sample_counter) + addr_offset) = (unsigned(trigger_counter_idx) - 1)) then
                mode_next          <= idle;
                sample_counter_rst <= '1';
                record_ready_irq <= '1';
            end if;

        end if;

    end process trigger_process;

    reg_proc : process(clk) is
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                mode          <= reset;
                trigger_index <= (others => '0');
            else
                mode          <= mode_next;
                trigger_index <= trigger_counter_idx;
            end if;
        end if;
    end process reg_proc;

end architecture RTL;
