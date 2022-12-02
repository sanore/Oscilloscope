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

-- This entity represent the entire oscilloscope, which currently only consists of one channel.
entity osci is
    port(
        -- system clock
        clk          : in std_ulogic;
        -- system reset
        rst          : in std_ulogic;
        
        -- channel 1 interface

        -- channel 1 adc input
        ch1_adc       : in std_ulogic_vector(11 downto 0);

        -- channel irq to notify of  completed aquisition
        ch1_irq       : out std_ulogic;
        -- pulse starts an aquisition
        ch1_en        : in std_ulogic; 
        -- channel reset. Active high.
        ch1_rst       : in std_ulogic;

        -- channel 1 trigger settings. 'ch1_rst' must be set to '1' to make changes.
        -- trigger mode: edge(0000)
        ch1_mode      : in std_ulogic_vector(3 downto 0);
        -- trigger edge: rising (0001), falling (0010), both/threshold (0011)
        ch1_edge_sel  : in std_ulogic_vector(3 downto 0);
        -- trigger threshhold: adc value at which to trigger
        ch1_edge_thre : in std_ulogic_vector(15 downto 0);
        
        -- channel ram data at ram_adr
        ch1_ram_data  : out  std_ulogic_vector(15 downto 0);
        -- channel ram address to read from.
        ch1_ram_adr   : in std_ulogic_vector(12 downto 0);

        -- ram address on which was triggered
        trigger_index    : out std_ulogic_vector(12 downto 0)
    );
end entity osci;

architecture RTL of osci is
    component channel
        generic(
            ADDR_WIDTH : integer := 13;
            DATA_WIDTH : integer := 16
        );
        port(
            clk              : in  std_logic;
            rst              : in  std_logic;
            start            : in  std_ulogic;
            read_address     : in  std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
            read_data        : out std_ulogic_vector(DATA_WIDTH - 1 downto 0);
            read_en          : in  std_ulogic;
            mode             : in  std_ulogic_vector(3 downto 0);
            edge_sel         : in  std_ulogic_vector(3 downto 0);
            edge_thre        : in  std_ulogic_vector(15 downto 0);
            adc_val          : in  std_ulogic_vector(11 downto 0);
            trigger_index    : out std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
            record_ready_irq : out std_ulogic
        );
    end component channel;
    
    signal ch1_reset : std_ulogic; -- 'real' channel 1 reset signal
    signal last_read_address : std_ulogic_vector(12 downto 0);
    signal ch1_read_en : std_ulogic;
begin
    
    ch1_reset <= rst or ch1_rst;
    
    -- generates the read_en pulse for the ram whenever the read address changes.
    proc_ram : process (clk) is
    begin
        if (rising_edge(clk)) then
            ch1_read_en <= '0';
        
            if (last_read_address /= ch1_ram_adr) then
                last_read_address <= ch1_ram_adr;
                ch1_read_en <= '1';
            end if;
        end if;
    end process;
    
    -- channel 1
    ch1 : component channel
        generic map(
            ADDR_WIDTH => 13,
            DATA_WIDTH => 16
        )
        port map(
            clk              => clk,
            rst              => ch1_reset,
            start            => ch1_en,
            read_address     => last_read_address,
            read_data        => ch1_ram_data,
            read_en          => ch1_read_en,
            mode             => ch1_mode,
            edge_sel         => ch1_edge_sel,
            edge_thre        => ch1_edge_thre,
            adc_val          => ch1_adc,
            trigger_index => trigger_index,
            record_ready_irq => ch1_irq
        ) ;
    
end architecture RTL;
