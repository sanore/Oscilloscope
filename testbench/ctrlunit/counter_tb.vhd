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
    enable  <= '0', '1' after 60 ns;
    dut_proc : process is
    begin
        reset <= '1';
        enable <= '0';
        wait for 50 ns;
        assert(dut_cnt = std_ulogic_vector(to_unsigned(0, dut_cnt'length))) report "unexpected counter value. Expected 0, got " & to_string(dut_cnt) severity error;
        reset <= '0';
        wait for 10 ns;
        assert(dut_cnt = std_ulogic_vector(to_unsigned(0, dut_cnt'length))) report "unexpected counter value. Expected 0, got " & to_string(dut_cnt) severity error;
        enable <= '1';
        for i in 0 to 2**13 -1 loop
            wait for 5 ns;
            assert (dut_cnt = std_ulogic_vector(to_unsigned(i, dut_cnt'length))) report "unexpected counter value. Expected " & integer'image(i) & ", got " & to_string(dut_cnt) severity error;
            wait for 995 ns;
        end loop;
        
        wait for 5 ns;
        assert(dut_cnt = std_ulogic_vector(to_unsigned(0, dut_cnt'length))) report "unexpected counter value. Expected 0, got " & to_string(dut_cnt) severity error;
        wait for 10 ns;
        enable <= '0';
        -- counter is stopped
        wait for 50 ns;
        assert(dut_cnt = std_ulogic_vector(to_unsigned(1, dut_cnt'length))) report "unexpected counter value. Expected 1, got " & to_string(dut_cnt) severity error;

        reset <= '1';
        wait for 10 ns;
        assert(dut_cnt = std_ulogic_vector(to_unsigned(0, dut_cnt'length))) report "unexpected counter value. Expected 0, got " & to_string(dut_cnt) severity error;
        
        assert false report "simulation ended" severity error;
    end process dut_proc;

end architecture RTL;
