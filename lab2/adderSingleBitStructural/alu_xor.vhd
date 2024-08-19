--Befekir Belayneh
--XOR Gate Module

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_xor is
  Port (
    A : in  STD_LOGIC;
    B : in  STD_LOGIC;
    Y : out STD_LOGIC
  );
 end alu_xor;
 
 architecture Behavioral of alu_xor is
 begin
    Y <= A xor B;
 end Behavioral;