-------------------------------------------------------------------------------
-- Befekir Belayneh
-- arithmetic logic unit
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;     

package alu_pkg is
  component alu
    port (
      clk    : in std_logic;
      reset  : in std_logic;
      a      : in std_logic_vector(7 downto 0);
      b      : in std_logic_vector(7 downto 0);
      op     : in std_logic_vector(2 downto 0);
      result : out std_logic_vector(7 downto 0)
    );
  end component;
end alu_pkg;

----------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
  port (
    clk           : in  std_logic;
    reset         : in  std_logic;
    a             : in  std_logic_vector(7 downto 0); 
    b             : in  std_logic_vector(7 downto 0);
    op            : in  std_logic_vector(2 downto 0); -- 000: add, 001: sub, 010: mult, 011: div
    result        : out std_logic_vector(7 downto 0)
  );  
end alu;  

architecture beh of alu  is

signal result_temp : std_logic_vector(15 downto 0);

begin
process(clk,reset)
  begin
    if (reset = '1') then 
      result_temp <= (others => '0');
    elsif (clk'event and clk = '1') then
      if (op = "000") then
        result_temp  <= std_logic_vector(unsigned("00000000" & a) + unsigned(b));
      elsif (op = "001") then
        result_temp  <= std_logic_vector(unsigned("00000000" & a) - unsigned(b));
      elsif (op = "010") then
        result_temp  <= std_logic_vector(unsigned(a) * unsigned(b));
      elsif (op = "011") then
        result_temp  <= std_logic_vector(unsigned("00000000" & a) / unsigned("00000000" & b));
      end if;
    end if;
  end process;
  result <= result_temp(7 downto 0);
end beh;