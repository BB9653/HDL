-------------------------------------------------------------------------------
-- Befekir Belayneh
-- blink led demo
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity blink is
  generic (
    max_count       : integer := 25000000
  );
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
	switch			: in  std_logic;
    output          : out std_logic
  );  
end blink;  

architecture beh of blink is

signal count_sig    : integer range 0 to max_count := 0;
signal output_sig   : std_logic;

begin
process(switch)
  begin
    if (switch = '1') then
	output_sig <= '1';
	else 
	output_sig <= '0'; 
	end if;
  end process;
  
  output <= output_sig;
end beh;