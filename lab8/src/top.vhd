--Befekir Belayneh
--Top Level Design Lab 8
--7/23/2024

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
  port (
    clk        : in  std_logic; 
    reset      : in  std_logic;
    execute    : in std_logic;
    state_led  : out std_logic_vector(3 downto 0);
    HEX0       : out std_logic_vector(6 downto 0);
    HEX1       : out std_logic_vector(6 downto 0);
    HEX2       : out std_logic_vector(6 downto 0)
  );
end top;

architecture arch of top is 

  component block_mem 
    port (
    clk        : in  std_logic; 
    reset      : in  std_logic;
    execute    : in std_logic;
    state_led  : out std_logic_vector(3 downto 0);
    HEX0       : out std_logic_vector(6 downto 0);
    HEX1       : out std_logic_vector(6 downto 0);
    HEX2       : out std_logic_vector(6 downto 0)
    );
  end component;

begin

  uut: block_mem
    port map (
    clk => clk,
    reset => reset,
    execute => execute,
    state_led => state_led,
    HEX0 => HEX0,
    HEX1 => HEX1,
    HEX2 => HEX2
    );
end arch;