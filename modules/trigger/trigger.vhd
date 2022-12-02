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

entity trigger is
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
end entity trigger;

architecture RTL of trigger is
    -- sample buffers
    signal current_sample  : std_ulogic_vector(11 downto 0);
    signal previous_sample : std_ulogic_vector(11 downto 0);

    -- internal config registers
    signal trigger_internal_mode        : std_ulogic_vector(3 downto 0);
    signal trigger_internal_sel         : std_ulogic_vector(3 downto 0);
    signal trigger_internal_threshold   : std_ulogic_vector(11 downto 0);

    -- trigger type selection signals
    alias trigger_sel_0: std_ulogic is trigger_internal_sel(0);
    alias trigger_sel_1: std_ulogic is trigger_internal_sel(1);

    -- trigger events
    signal trigger_edge_event           : std_ulogic; -- global event for edge type trigger
    signal trigger_rising_edge_event    : std_ulogic;
    signal trigger_falling_edge_event   : std_ulogic;

    -- states (required to not trigger immediately when initial sample is non zero)
    type trigger_state_type is (state_stopped, state_starting, state_armed);
    signal current_trigger_state: trigger_state_type := state_stopped;
    signal next_trigger_state: trigger_state_type := state_stopped;

begin

    -- trigger output logic
    with trigger_internal_mode select
        -- edge mode triggers
        trig_pulse <= trigger_edge_event when "0000",
        -- other trigger modes (to be defined)
        '0' when others;

    -- edge mode trigger aggregation
    -- sel_0 controlls rising edge, sel_1 controlls falling edge 
    trigger_edge_event <= (trigger_sel_0 and trigger_rising_edge_event) or
                      (trigger_sel_1 and trigger_falling_edge_event);

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
                -- save configuration if disabled
                trigger_internal_mode <= trig_mode;
                trigger_internal_sel <= trig_sel;
                trigger_internal_threshold <= trig_threshold;

                -- reset state and sample register
                current_trigger_state <= state_stopped;
                current_sample <= (others => '0');
                previous_sample <= (others => '0');
            end if;
        end if;
    end process reg_process;

    -- state transition logic
    next_state_process: process(current_trigger_state)
    begin
        case current_trigger_state is
            when state_stopped => next_trigger_state <= state_starting;
            when others => next_trigger_state <= state_armed;
        end case;
    end process next_state_process;

    -- detect rising edges in input samples on falling clock
    rising_edge_trigger: process(clk)
    begin
        if falling_edge(clk) then
            if current_trigger_state = state_armed then
                if unsigned(previous_sample) <= unsigned(trigger_internal_threshold) and
                    unsigned(current_sample) >= unsigned(trigger_internal_threshold) then
                    trigger_rising_edge_event <= '1';
                else
                    trigger_rising_edge_event <= '0';
                end if;
            else
                trigger_rising_edge_event <= '0';
            end if;
        end if;
    end process rising_edge_trigger;

    -- detect falling edges in input samples on falling clock
    falling_edge_trigger: process(clk)
    begin
        if falling_edge(clk) then
            if current_trigger_state = state_armed then
                if unsigned(previous_sample) >= unsigned(trigger_internal_threshold) and
                    unsigned(current_sample) <= unsigned(trigger_internal_threshold) then
                    trigger_falling_edge_event <= '1';
                else
                    trigger_falling_edge_event <= '0';
                end if;
            else
                trigger_falling_edge_event <= '0';
            end if;
        end if;
    end process falling_edge_trigger;

end architecture RTL;
