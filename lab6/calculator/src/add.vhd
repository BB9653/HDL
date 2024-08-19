-------------------------------------------------------------------------------
-- Befekir Belayneh
-- generic adder [behavioral]
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add is
  generic (
    bits    : integer := 8
  );
  port (
    a       : in  std_logic_vector(bits-1 downto 0);
    b       : in  std_logic_vector(bits-1 downto 0);
    sum     : out std_logic_vector(15 downto 0)
  );
end entity add;

architecture beh of add is

signal x  : std_logic_vector(bits downto 0);
signal sum_temp   : std_logic_vector(15 downto 0);

begin
    x         <= std_logic_vector(('0' & unsigned(a)) + ('0' & unsigned(b))); --add, concatenate 0 to make 4 bits
    sum_temp  <= std_logic_vector(signed(resize(unsigned(x), 16)));
    sum       <= sum_temp(15 downto 0);
end beh;
