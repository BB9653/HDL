--Befekir Belayneh
--OR Gate Module

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_or is
  Port (
    A : in  STD_LOGIC;
    B : in  STD_LOGIC;
    C : in  STD_LOGIC;
    Y : out STD_LOGIC
  );
 end alu_or;
 
 architecture Behavioral of alu_or is
 begin
    Y <= A or B or C;
 end Behavioral;