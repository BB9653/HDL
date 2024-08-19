library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calculator_tb is
end calculator_tb;

architecture tb_arch of calculator_tb is

  constant CLK_PERIOD : time := 100 ns;
  constant NUM_BITS   : integer := 8;
  
component top_calc
  port (
    clk     : in  std_logic;
    reset   : in  std_logic;
    a       : in  std_logic_vector(NUM_BITS-1 downto 0);
    b       : in  std_logic_vector(NUM_BITS-1 downto 0);
    outSum  : out std_logic_vector(15 downto 0);
    outDiff : out std_logic_vector(15 downto 0)
  );
end component;
  
  --signals
  signal clk     :  std_logic;
  signal reset   :  std_logic;
  signal a       :  std_logic_vector(NUM_BITS - 1 downto 0) := "00000000";
  signal b       :  std_logic_vector(NUM_BITS - 1 downto 0) := "00000000";
  signal outSum  :  std_logic_vector(15 downto 0);
  signal outDiff :  std_logic_vector(15 downto 0);
  
begin

  uut: top_calc
  port map (
    clk => clk,
    reset => reset,
    a => a,
    b => b,
    outSum => outSum,
    outDiff => outDiff
  );
  
  clk_process: process --50MHz clock sim
  begin
    while true loop
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
    end loop;
  end process;
  
  reset_process: process --simulate reset
  begin
    reset <= '1';
    wait for 20 ns;
    reset <= '0';
    wait for 10000 ns;
    reset <= '1';
    wait for 40 ns;
    reset <= '0';
    wait;
  end process;
   
  stim_proc: process
  variable a_int : integer := 0;
  variable b_int : integer := 0;
  begin
  wait for 500 ns;
    while true loop
    for b_int in 0 to 255 loop
      b <= std_logic_vector(to_unsigned(b_int, 8)); -- iterate b after all a values
      for a_int in 0 to 255 loop
        a <= std_logic_vector(to_unsigned(a_int, 8)); --iterate a for all values
        wait for 40 ns;
      end loop;
    end loop;
  end loop;
  end process;

end tb_arch;
