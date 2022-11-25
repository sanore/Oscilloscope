library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity osci is
    port(
        clk          : in std_ulogic;
        rst          : in std_ulogic;
        
        -- channel 1
        ch1_adc       : in std_ulogic_vector(11 downto 0);
        ch1_irq       : out std_ulogic;
        ch1_en        : in std_ulogic; 
        ch1_rst       : in std_ulogic; 
        ch1_mode      : in std_ulogic_vector(3 downto 0);
        ch1_edge_sel  : in std_ulogic_vector(3 downto 0);
        ch1_edge_thre : in std_ulogic_vector(15 downto 0);
        ch1_ram_data  : out  std_ulogic_vector(15 downto 0);
        ch1_ram_adr   : in std_ulogic_vector(11 downto 0)
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
            record_ready_irq : out std_ulogic;
            adc_val          : in  std_ulogic_vector(11 downto 0)
        );
    end component channel;
    
    signal ch1_reset : std_ulogic;
begin
    
    ch1_reset <= rst or ch1_rst;
    
    -- channel 1
    ch1 : channel
        generic map(
            ADDR_WIDTH => 13,
            DATA_WIDTH => 16
        ) 
        port map(
            clk              => clk,
            rst              => ch1_reset,
            start            => ch1_en,
            -- TODO use ch1_ram_data, ch1_ram_adr to generate following read access.
            -- an each address change, we must generate a new read op.
            read_address     => open,
            read_data        => open,
            read_en          => open,
            mode             => ch1_mode,
            edge_sel         => ch1_edge_sel,
            edge_thre        => ch1_edge_thre,
            record_ready_irq => ch1_irq,
            adc_val          => ch1_adc
        ) ;
    
end architecture RTL;
