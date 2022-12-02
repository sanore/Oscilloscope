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

-- This entity represents a single oscilloscope channel.
-- It contains a trigger block, a control unit and the block ram.
-- Pulsing 'start' will start an aquisition. 
-- When the aquisition is complete, 'record_ready_irq' will provide a single pulse.
-- The trigger index and the ram contents are valid if and only if 'record_ready_irq' has been pulsed.
-- The ram contents can then be read out with the read interface.
-- Changing the channel/trigger configuration requires 'rst' to be set to '1'.
-- The generic params must be set to their defaults, as not everything 
-- is working with them as intended for now.
entity channel is
    generic(
        ADDR_WIDTH : integer := 13;
        DATA_WIDTH : integer := 16
    );
    port(
        clk              : in  std_logic;
        rst              : in  std_logic;
        
        -- single pulse to start aquisition
        start            : in std_ulogic;
        
        -- ram read interface for the processor. see ram.vhd for details.
        read_address     : in std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
        read_data        : out std_ulogic_vector(DATA_WIDTH - 1 downto 0);
        read_en          : in  std_ulogic;
        
        -- channel/trigger configuration. See trigger.vhd for more details.
        mode              : in std_ulogic_vector(3 downto 0);
        edge_sel          : in std_ulogic_vector(3 downto 0);
        edge_thre         : in std_ulogic_vector(15 downto 0);
        
        -- current adc value.
        adc_val           : in  std_ulogic_vector(11 downto 0);
        
        -- ram index on which was triggered.
        trigger_index : out std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
        
        -- single pulse to notify aqusition stopped.
        record_ready_irq  : out std_ulogic
        
    );
end entity channel;

architecture RTL of channel is
    component ctrlunit
        generic(
            ADDR_WIDTH : integer := 13;
            DATA_WIDTH : integer := 16
        );
        port(
            clk              : in  std_logic;
            rst              : in  std_logic;
            start_record     : in  std_logic;
            adc_val          : in  std_ulogic_vector(11 downto 0);
            trigger_pulse    : in  std_ulogic;
            write_address    : out std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
            write_data       : out std_ulogic_vector(DATA_WIDTH - 1 downto 0);
            write_en         : out std_ulogic;
            trigger_index    : out std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
            record_ready_irq : out std_ulogic
        );
    end component ctrlunit;
    
    component ram
        generic(
            ADDR_WIDTH : integer := 13;
            DATA_WIDTH : integer := 16
        );
        port(
            clk           : in  std_logic;
            rst           : in  std_logic;
            write_address : in  std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
            write_data    : in  std_ulogic_vector(DATA_WIDTH - 1 downto 0);
            write_en      : in  std_ulogic;
            read_address  : in  std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
            read_data     : out std_ulogic_vector(DATA_WIDTH - 1 downto 0);
            read_en       : in  std_ulogic
        );
    end component ram;
    
    component trigger
        port(
            clk            : in  std_ulogic;
            enable         : in  std_ulogic;
            adc_val        : in  std_ulogic_vector(11 downto 0);
            trig_mode      : in  std_ulogic_vector(3 downto 0);
            trig_sel       : in  std_ulogic_vector(3 downto 0);
            trig_threshold : in  std_ulogic_vector(11 downto 0);
            trig_pulse     : out std_ulogic
        );
    end component trigger;
    
    -- ram signals
    signal write_address : std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
    signal write_data    : std_ulogic_vector(DATA_WIDTH - 1 downto 0);
    signal write_en      : std_ulogic;
    
    -- trigger singals
    signal trigger_pulse : std_ulogic;
    signal trigger_enable: std_ulogic;
begin
    ctrl : ctrlunit
        generic map(
            ADDR_WIDTH => ADDR_WIDTH,
            DATA_WIDTH => DATA_WIDTH
        ) 
        port map(
            clk           => clk,
            rst           => rst,
            start_record  => start,
            adc_val       => adc_val,
            trigger_pulse => trigger_pulse,
            write_address => write_address,
            write_data    => write_data,
            write_en      => write_en,
            trigger_index => trigger_index,
            record_ready_irq => record_ready_irq
        );
    
    storage : ram
        generic map(
            ADDR_WIDTH => ADDR_WIDTH,
            DATA_WIDTH => DATA_WIDTH
        ) 
        port map(
            clk           => clk,
            rst           => rst,
            write_address => write_address,
            write_data    => write_data,
            write_en      => write_en,
            read_address  => read_address,
            read_data     => read_data,
            read_en       => read_en
        ) ;


    trigger_enable <= not rst;
    trig : trigger
        port map(
            clk            => clk,
            enable         => trigger_enable,
            adc_val        => adc_val,
            trig_mode      => mode,                   -- mode posEdge
            trig_sel       => edge_sel,               -- rising     
            trig_threshold => edge_thre(11 downto 0), -- +500
            trig_pulse     => trigger_pulse
        );
    
end architecture RTL;
