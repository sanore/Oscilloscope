library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity channel is
    generic(
        ADDR_WIDTH : integer := 13;
        DATA_WIDTH : integer := 16
    );
    port(
        clk              : in  std_logic;
        rst              : in  std_logic;
        
        --read ram
        read_address     : in std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
        read_data        : out std_ulogic_vector(DATA_WIDTH - 1 downto 0);
        read_en          : in  std_ulogic;
        
        -- channel state
        state             : out std_ulogic_vector(3 downto 0);
        record_ready_irq  : out std_ulogic;
        adc_val           : in  std_ulogic_vector(11 downto 0)
    );
end entity channel;

architecture RTL of channel is
    component ctrlunit
        generic(
            ADDR_WIDTH : integer := 13;
            DATA_WIDTH : integer := 16
        );
        port(
            clk           : in  std_logic;
            rst           : in  std_logic;
            start_record  : in  std_logic;
            adc_val       : in  std_ulogic_vector(11 downto 0);
            trigger_pulse : in  std_ulogic;
            write_address : out std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
            write_data    : out std_ulogic_vector(DATA_WIDTH - 1 downto 0);
            write_en      : out std_ulogic;
            trigger_index : out std_ulogic_vector(ADDR_WIDTH - 1 downto 0)
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
    
    signal trigger_pulse : std_ulogic;
begin
    ctrl : ctrlunit
        generic map(
            ADDR_WIDTH => ADDR_WIDTH,
            DATA_WIDTH => DATA_WIDTH
        ) 
        port map(
            clk           => clk,
            rst           => rst,
            start_record  => start_record,
            adc_val       => adc_val,
            trigger_pulse => trigger_pulse,
            write_address => write_address,
            write_data    => write_data,
            write_en      => write_en,
            trigger_index => trigger_index
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

    trig : trigger
        port map(
            clk            => clk,
            enable         => '1',
            adc_val        => adc_val,
            trig_mode      => "0000",         -- mode posEdge
            trig_sel       => "0000",         -- rising     
            trig_threshold => "000111110100", -- +500
            trig_pulse     => trigger_pulse
        );
    
end architecture RTL;
