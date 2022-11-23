library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity osci is
    port(
        clk          : in std_ulogic;
        rst          : in std_ulogic;
        
        -- channel 1
        ch1_adc      : in std_ulogic_vector(11 downto 0);
        ch1_state    : in std_ulogic_vector(31 downto 0);
        ch1_trigger  : in std_ulogic_vector(31 downto 0);
        ch1_mode_edge: in std_ulogic_vector(31 downto 0);
        ch1_irq      : out std_ulogic
    );
end entity osci;

architecture RTL of osci is
    component channel
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
            read_address  : out std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
            read_data     : out std_ulogic_vector(DATA_WIDTH - 1 downto 0);
            read_en       : in  std_ulogic;
            state         : out std_ulogic_vector(3 downto 0);
            irq           : out std_ulogic
        );
    end component channel;
begin
    
    -- channel 1
    ch1 : channel
        port map(
            clk           => clk,
            rst           => rst,
            -- todo
            write_address => open,
            write_data    => open,
            write_en      => open,
            read_address  => open,
            read_data     => open,
            read_en       => open,
            state         => open,
            
            irq           => ch1_irq
        );    
end architecture RTL;
