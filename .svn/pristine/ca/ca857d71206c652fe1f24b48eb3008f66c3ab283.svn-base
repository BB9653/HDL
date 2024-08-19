-------------------------------------------------------------------------------
-- Dr. Kaputa
-- seven segment test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_seg_tb is
end seven_seg_tb;

architecture arch of seven_seg_tb is

component seven_seg is
  port (
    enable          : in std_logic;
    bcd             : in std_logic_vector(3 downto 0);
    seven_seg_out   : out std_logic_vector(6 downto 0)
  );  
end component; 

constant period     : time := 20 ns;                                              
signal enable       : std_logic := '0';
signal bcd          : std_logic_vector(3 downto 0) := "0000";

begin

-- bcd iteration
sequential_tb : process 
    begin
      report "****************** sequential testbench start ****************";
      wait for 80 ns;   -- let all the initial conditions trickle through
      for i in 0 to 15 loop
        bcd <= std_logic_vector(unsigned(bcd) + 1 );
        wait for 40 ns;
      end loop;
      report "****************** sequential testbench stop ****************";
      wait;
  end process; 

 
-- enable process
enable_proc: process
  begin
  wait for 20 ns;
  while true loop
    wait for period / 2;
    enable <= '1';
    wait for period / 2;
    enable <= '0';
  end loop;
end process; 

uut: seven_seg  
  port map(        
    enable         => enable,
    bcd            => bcd,
    seven_seg_out  => open
  );
end arch;