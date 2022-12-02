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
    signal reset   : std_ulogic := '1';
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
    
    dut_proc : process is
    begin
        wait for 10 ns;
        assert(dut_cnt = std_ulogic_vector(to_unsigned(0, dut_cnt'length))) report ("unexpected counter value. Expected 0, got " & integer'image(to_integer(unsigned(dut_cnt)))) severity error;
        reset <= '0';
        wait for 10 ns;
        assert(dut_cnt = std_ulogic_vector(to_unsigned(0, dut_cnt'length))) report "unexpected counter value. Expected 0, got " & integer'image(to_integer(unsigned(dut_cnt))) severity error;
        
        enable <= '1';
        -- count once through whole range
        for i in 0 to 2**13 -1 loop
            wait for 5 ns;
            assert (dut_cnt = std_ulogic_vector(to_unsigned(i, dut_cnt'length))) report "unexpected counter value. Expected " & integer'image(i) & ", got " & integer'image(to_integer(unsigned(dut_cnt))) severity error;
            wait for 995 ns;
        end loop;
        
        wait for 5 ns;
        -- must overflow correctly
        assert(dut_cnt = std_ulogic_vector(to_unsigned(0, dut_cnt'length))) report "unexpected counter value. Expected 0, got " & integer'image(to_integer(unsigned(dut_cnt))) severity error;
        
        wait for 1 us; -- one count
        -- then disable. counter is stopped -> should keep its old value
        enable <= '0';
        wait for 50 ns;
        assert(dut_cnt = std_ulogic_vector(to_unsigned(1, dut_cnt'length))) report "unexpected counter value. Expected 1, got " & integer'image(to_integer(unsigned(dut_cnt))) severity error;

        --hard reset again
        reset <= '1';
        wait for 15 ns;
        assert(dut_cnt = std_ulogic_vector(to_unsigned(0, dut_cnt'length))) report "unexpected counter value. Expected 0, got " & integer'image(to_integer(unsigned(dut_cnt))) severity error;
        wait for 100 ns;
        
        assert false report "simulation ended" severity failure;
    end process dut_proc;

end architecture RTL;
