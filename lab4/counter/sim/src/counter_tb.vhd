library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_tb is
end counter_tb;

architecture tb_arch of counter_tb is

  constant CLK_PERIOD : time := 100 ns;
  
component top_module
  port (
    clk         : in  std_logic;
    input       : in  std_logic_vector(3 downto 0) := "0001";
    reset       : in  std_logic;
    ssd_out     : out std_logic_vector(6 downto 0)
  );
end component;
  
  --signals
  signal clk           : std_logic := '0';
  signal reset         : std_logic := '0';
  signal input   : std_logic_vector(3 downto 0) := "0001";
  signal sum : std_logic_vector(3 downto 0) := "0000";
  signal sum_sig : std_logic_vector(3 downto 0) := (others => '0');
  signal enable : std_logic := '0';
  signal ssd_out : std_logic_vector(6 downto 0);
  
begin

  uut: top_module
  port map (
    clk => clk,
    input => input,
    ssd_out => ssd_out,
    reset => reset
  );
  
  
  clk_process: process
  begin
    while true loop
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
    end loop;
  end process;
  
  stim_proc: process
  begin
    reset <= '1';
    wait for 20 ns;
    reset <= '0';
    wait;
  end process;

end tb_arch;
