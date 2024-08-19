library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display_tb is
end display_tb;

architecture tb_arch of display_tb is

  constant NUM_BITS   : integer := 8;
  
component top
  port (
    clk     : in  std_logic;
    reset   : in  std_logic;
    state_change : in std_logic;
    input : in std_logic_vector(7 downto 0);
    led   : out std_logic_vector(3 downto 0);
    HEX0  : out std_logic_vector(6 downto 0);
    HEX1  : out std_logic_vector(6 downto 0);
    HEX2  : out std_logic_vector(6 downto 0)
  );
end component;
  
  --signals
  signal clk   :  std_logic;
  signal reset :  std_logic := '1';
  signal state_change : std_logic := '1';
  signal input :  std_logic_vector(7 downto 0);
  signal led   :  std_logic_vector(3 downto 0);
  signal HEX0  :  std_logic_vector(6 downto 0);
  signal HEX1  :  std_logic_vector(6 downto 0);
  signal HEX2  :  std_logic_vector(6 downto 0);
  
begin

  uut: top
  port map (
    clk => clk,
    reset => reset,
    state_change => state_change,
    input => input,
    led => led,
    HEX0 => HEX0,
    HEX1 => HEX1,
    HEX2 => HEX2
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
  
   
  stim_proc: process
  begin
    reset <= '0';
      input <= std_logic_vector(to_unsigned(5,8)); --test case 1 input a
      state_change <= '1';
      wait for 3000 ns;
      state_change <= '0';
      wait for 80 ns;
      state_change <= '1';
      wait for 60 ns;
  
      input <= std_logic_vector(to_unsigned(2,8)); --test case 1 input b
      state_change <= '1';
      wait for 3000 ns;
      state_change <= '0';
      wait for 80 ns;
      state_change <= '1';

      wait for 3000 ns; 
      state_change <= '0';
      wait for 80 ns;
      state_change <= '1';

      wait for 3000 ns; --wait for disp_sum and disp_diff
      state_change <= '0';
      wait for 80 ns;
      state_change <= '1';

      input <= std_logic_vector(to_unsigned(2,8)); --test case 2 input a
      state_change <= '1';
      wait for 3000 ns;
      state_change <= '0';
      wait for 80 ns;
      state_change <= '1';
      wait for 60 ns;
  
      input <= std_logic_vector(to_unsigned(5,8)); --test case 2 input b
      state_change <= '1';
      wait for 3000 ns;
      state_change <= '0';
      wait for 80 ns;
      state_change <= '1';

      wait for 3000 ns; 
      state_change <= '0';
      wait for 80 ns;
      state_change <= '1';

      wait for 3000 ns; --wait for disp_sum and disp_diff
      state_change <= '0';
      wait for 80 ns;
      state_change <= '1';

      input <= std_logic_vector(to_unsigned(200,8)); --test case 3 input a
      state_change <= '1';
      wait for 3000 ns;
      state_change <= '0';
      wait for 80 ns;
      state_change <= '1';
      wait for 60 ns;
  
      input <= std_logic_vector(to_unsigned(100,8)); --test case 3 input b
      state_change <= '1';
      wait for 3000 ns;
      state_change <= '0';
      wait for 80 ns;
      state_change <= '1';

      wait for 3000 ns; 
      state_change <= '0';
      wait for 80 ns;
      state_change <= '1';

      wait for 3000 ns; --wait for disp_sum and disp_diff
      state_change <= '0';
      wait for 80 ns;
      state_change <= '1';

      input <= std_logic_vector(to_unsigned(100,8)); --test case 4 input a
      state_change <= '1';
      wait for 3000 ns;
      state_change <= '0';
      wait for 80 ns;
      state_change <= '1';
      wait for 60 ns;
  
      input <= std_logic_vector(to_unsigned(200,8)); --test case 4 input b
      state_change <= '1';
      wait for 3000 ns;
      state_change <= '0';
      wait for 80 ns;
      state_change <= '1';

      wait for 3000 ns; 
      state_change <= '0';
      wait for 80 ns;
      state_change <= '1';

      wait for 3000 ns; --wait for disp_sum and disp_diff
      state_change <= '0';
      wait for 80 ns;
      state_change <= '1';
      wait;
  end process;

end tb_arch;


--      reset <= '1';
 --     wait for 40 ns;
   --   reset <= '0';