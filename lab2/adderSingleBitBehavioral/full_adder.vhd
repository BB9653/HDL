--Befekir Belayneh
--lab 2 demo
--full adder logic

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
  Port (
    A    : in STD_LOGIC;
    B    : in STD_LOGIC;
    Cin  : in STD_LOGIC; --3 inputs
    Sum  : out STD_LOGIC;
    Cout : out STD_LOGIC --2 outputs
   );
end full_adder;


architecture Behavioral of full_adder is
begin
  process (A,B, Cin) --input parameters
  begin
  Sum <= (A xor B) xor Cin; -- xor a, b and cin for Sum logic
  Cout <= (A and B) or (B and Cin) or (Cin and A); --Cout logic
 end process;
end Behavioral; 