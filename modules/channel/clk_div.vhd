library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity clk_div is begin
port(
   clk: in std_logic;
   oup: out std_logic;
  )
  end;

architecture RTL of clk_div is 
  signal cnt: std_ulogic_vector(6 downto 0);
  signal cnt_next: std_ulogic_vector(6 downto 0);

begin
  process(cnt) is
  begin
    cnt_next <= std_ulogic_vector(unsigned(cnt_next) + 1);
    if unsigned(cnt) = 99 then
      oup <= '1';
      cnt_next <= "000000";
    end if;
  end
end architecture;
