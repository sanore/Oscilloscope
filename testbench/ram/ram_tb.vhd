-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
-- #                                                                     #
-- # Oscilloscope                                                        #
-- # Miniproject Digital Microelectronics (Fall Semester 2022)           #
-- # OST Rapperswil-Jona                                                 #
-- #                                                                     #
-- # Group 7:   Pelé Constam                                             #
-- #            Sandro Pedrett                                           #
-- #            Erik Löffler                                             #
-- #                                                                     #
-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity ram_tb is
end entity ram_tb;

architecture RTL of ram_tb is
    ----------------------------------------------------------------------------
    -- component
    ----------------------------------------------------------------------------
    
    component ram is
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
            read_address  : in std_ulogic_vector(ADDR_WIDTH - 1 downto 0);
            read_data     : out std_ulogic_vector(DATA_WIDTH - 1 downto 0);
            read_en       : in  std_ulogic
        );
    end component;

    ----------------------------------------------------------------------------
    -- constants
    ----------------------------------------------------------------------------
    
    constant f_clk : real := 100.0e6;
    constant t_clk : time := (1.0 sec) / f_clk;
    
    ----------------------------------------------------------------------------
    -- internal signals
    ----------------------------------------------------------------------------
    signal tb_clk : std_ulogic;
    signal tb_rst : std_ulogic;
    
    signal tb_write_address : std_ulogic_vector(12 downto 0);
    signal tb_write_data: std_ulogic_vector(15 downto 0);
    signal tb_write_en : std_ulogic;

    signal tb_read_address : std_ulogic_vector(12 downto 0);
    signal tb_read_data: std_ulogic_vector(15 downto 0);
    signal tb_read_en : std_ulogic;

begin

    -- start test in reset state
    tb_rst <= '1', '0' after 1 ns;

    DUT: component ram 
    generic map(
        ADDR_WIDTH => 13,
        DATA_WIDTH => 16
    )
    port map(
        clk => tb_clk,
        rst => tb_rst,
        
        write_address => tb_write_address,
        write_data => tb_write_data,
        write_en => tb_write_en,
        
        read_address => tb_read_address,
        read_data => tb_read_data,
        read_en => tb_read_en
    );

    clock_generator: process
    begin
        tb_clk <= '0';
        loop
            wait for t_clk / 2.0;
            tb_clk <= not tb_clk;
        end loop;
        wait;
    end process clock_generator;

    insert_dummy_data: process
        -- dummy data to be fed into RAM
        file test_data_file : text;

        -- buffer variables
        variable line_buff      : line;
        variable delimiter_buff : character;
        variable test_data_buff : std_ulogic_vector(15 downto 0);
        variable test_addr_buff : std_ulogic_vector(12 downto 0);
    begin
    
    -- open file
    file_open(test_data_file, "ram_data.csv", READ_MODE);

    -- wait for reset to be low
    wait until falling_edge(tb_rst);

    -- write entire data file into RAM
    while not endfile(test_data_file) loop
        readline(test_data_file, line_buff);

        -- wait for middle of clock cycle + half a clock pulse
        wait until falling_edge(tb_clk);
        wait for t_clk / 4.0;

        -- set address
        read(line_buff, test_addr_buff);
        tb_write_address <= test_addr_buff;

        -- discard delimiter
        read(line_buff, delimiter_buff);

        -- set test data
        read(line_buff, test_data_buff);
        tb_write_data <= test_data_buff;

        -- set write enable
        tb_write_en <= '1';

        -- wait for rising edge + half a clock pulse
        wait until rising_edge(tb_clk);
        wait for t_clk / 4.0;

        -- disable write
        tb_write_en <= '0';

    end loop;

    -- close file
    file_close(test_data_file);

    wait;

    end process insert_dummy_data;

    check_dummy_data: process
        -- dummy data to be checked
        file test_data_file : text;

        -- buffer variables
        variable line_buff      : line;
        variable delimiter_buff : character;
        variable test_data_buff : std_ulogic_vector(15 downto 0);
        variable test_addr_buff : std_ulogic_vector(12 downto 0);
    begin
    
    -- open file
    file_open(test_data_file, "ram_data.csv", READ_MODE);

    -- wait for reset release + 100ns
    wait until falling_edge(tb_rst);
    wait for 100 ns;

    -- check entire RAM data
    while not endfile(test_data_file) loop
        readline(test_data_file, line_buff);

        -- wait for middle of clock cycle + half a clock pulse
        wait until falling_edge(tb_clk);
        wait for t_clk / 4.0;

        -- set address
        read(line_buff, test_addr_buff);
        tb_read_address <= test_addr_buff;

        -- discard delimiter
        read(line_buff, delimiter_buff);

        -- read expected test data
        read(line_buff, test_data_buff);

        -- set read enable
        tb_read_en <= '1';

        -- wait for rising edge + half a clock pulse
        wait until rising_edge(tb_clk);
        wait for t_clk / 4.0;

        -- check data
        assert (tb_read_data = test_data_buff) report "Error: data at address "
            & to_hstring(to_bitvector(test_addr_buff)) & " does not match. (Expected: "
            & to_hstring(to_bitvector(test_data_buff)) & ", read: " 
            & to_hstring(to_bitvector(tb_read_data)) & ")." severity error;

        -- disable read
        tb_read_en <= '0';

    end loop;

    -- close file
    file_close(test_data_file);
    
    -- stop simulation
    assert false report "Simulation completed.";

    wait;

    end process check_dummy_data;    

end architecture RTL;
