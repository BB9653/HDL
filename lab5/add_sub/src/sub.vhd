-------------------------------------------------------------------------------
-- Befekir Belayneh
-- generic adder/subtractor [behavioral]
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sub is
  generic (
    bits    : integer := 3
  );
  port (
    a       : in  std_logic_vector(bits-1 downto 0);
    b       : in  std_logic_vector(bits-1 downto 0);
    sum     : out std_logic_vector(bits downto 0)
  );
end entity sub;

architecture beh of sub is

signal sum_temp   : std_logic_vector(bits downto 0);

begin
  sum_temp  <= std_logic_vector(unsigned('0' & a) - unsigned('0' & b)); --subtract, concatenate 0 to make 4 bits
  sum       <= sum_temp(bits downto 0);
end beh;