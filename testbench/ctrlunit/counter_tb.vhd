library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_tb is
end entity counter_tb;

architecture RTL of counter_tb is
    component counter
        port(
            clk   : in  std_logic;
            rst   : in  std_logic;
            en    : in  std_ulogic;
            count : out std_ulogic_vector(12 downto 0)
        );
    end component counter;
    signal dut_clk : std_ulogic := '0';
    signal reset   : std_ulogic := '0';
    signal enable  : std_ulogic := '0';
    signal dut_cnt : std_ulogic_vector(12 downto 0);
begin
    dut : component counter
        port map(
            clk   => dut_clk,
            rst   => reset,
            en    => enable,
            count => dut_cnt
        );

    dut_clk <= not dut_clk after 5 ns;
    reset   <= '1', '0' after 50 ns;
    enable  <= '0', '1' after 50 ns;
    dut_proc : process is
    begin
        wait for 55 ns;
        for i in 0 to 10 loop
            wait for 5 ns;
            assert (dut_cnt = std_ulogic_vector(to_unsigned(i, dut_cnt'length))) report "unexpected counter value" severity error;
            wait for 99 * 10 ns + 5 ns;
        end loop;
        
        assert false report "simulation ended" severity error;
    end process dut_proc;

end architecture RTL;
