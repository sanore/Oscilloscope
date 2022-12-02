library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.math_real.all;

entity ctrlunit_tb is
end entity ctrlunit_tb;

architecture RTL of ctrlunit_tb is
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
    signal clk     : std_logic := '0';
    signal reset   : std_logic := '1';
    signal start   : std_logic := '0';
    signal dut_adc_val : std_ulogic_vector(11 downto 0);
    signal dut_trigger_pulse : std_ulogic := '0';

    signal dut_write_address : std_ulogic_vector(13 - 1 downto 0);
    signal dut_write_data    : std_ulogic_vector(16 - 1 downto 0);
    signal dut_write_en      : std_ulogic;
    signal dut_trigger_index : std_ulogic_vector(13 - 1 downto 0);
    signal dut_rec_ready: std_ulogic;
begin
    clk <= not clk after 5 ns;

    dut:component ctrlunit
        port map(
            clk           => clk,
            rst           => reset,
            start_record  => start,
            adc_val       => dut_adc_val,
            trigger_pulse => dut_trigger_pulse,
            write_address => dut_write_address,
            write_data    => dut_write_data,
            write_en      => dut_write_en,
            trigger_index => dut_trigger_index,
            record_ready_irq => dut_rec_ready
        ) ;
    dut_state : process is
    begin
        wait for 50 ns;
        reset <= '0';
        wait for 10 ns;
        wait for 100 ns;
        start <= '1';
        wait for 10 ns;
        start <= '0';
        wait for 10 ns;
        assert(dut_write_en = '1') report "expected write enabled = '1'" severity error;
        wait for 10000 us;
        dut_trigger_pulse <= '1';
        wait for 10 ns;
        dut_trigger_pulse <= '0';
        wait for 10 ns;
        assert(dut_write_address = std_ulogic_vector(to_unsigned(10000 mod 2**13, dut_write_address'length))) report "unexpected address, expected " & integer'image(10000 mod 2**13) & ", got " & integer'image(to_integer(unsigned(dut_write_address )));
        assert(dut_trigger_index  = dut_write_address);
        wait until rising_edge(dut_rec_ready);
        wait for 15 ns;
        assert(dut_trigger_index = std_ulogic_vector(to_unsigned(10000 mod 2**13, dut_trigger_index'length))) report "unexpected address, expected " & integer'image(10000 mod 2**13) & ", got " & integer'image(to_integer(unsigned(dut_trigger_index )));
        assert(dut_write_address = std_ulogic_vector(to_unsigned(14096 mod 2**13, dut_write_address'length))) report "unexpected address, expected " & integer'image(14096 mod 2**13) & ", got " & integer'image(to_integer(unsigned(dut_write_address )));
        assert(dut_write_en = '0') report "expected write enabled = '0'" severity error;
        wait for 50 ns;
        assert false report "simulation end" severity failure;
    end process dut_state;

end architecture RTL;