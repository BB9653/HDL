--Befekir Belayneh
--AND Gate Module

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_and is
  Port (
    A : in  STD_LOGIC;
    B : in  STD_LOGIC;
    Y : out STD_LOGIC
  );
 end alu_and;
 
 architecture Behavioral of alu_and is
 begin
    Y <= A and B;
 end Behavioral;