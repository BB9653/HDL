-------------------------------------------------------------------------------
-- dj roomba 3000 test bench
-- From original by Dr. Kaputa
-- Prof. Magliocco with help frm Diego Lopez
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dj_roomba_3000_tb is
end dj_roomba_3000_tb;

architecture arch of dj_roomba_3000_tb is

  component dj_roomba_3000 is 
    port(
      clk                 : in std_logic;
      reset               : in std_logic;
      execute_btn         : in std_logic;
      sync                : in std_logic;
      led                 : out std_logic_vector(7 downto 0);
      audio_out           : out std_logic_vector(15 downto 0)
    );
  end component;

  constant period     : time := 20 ns; -- 50 MHz clock
  
  signal clk          : std_logic := '0';
  signal reset        : std_logic := '1';
  signal sync         : std_logic := '0';
  signal execute_btn  : std_logic := '1';

  -- Button press procedure
  procedure press_button(signal button : out std_logic) is
    begin
      wait for period*3;
      button <= '0';
      wait for period*3;
      button <= '1';
  end procedure;
	
begin

  dj_roomba : dj_roomba_3000
    port map(
      clk         => clk,
      reset       => reset,
      execute_btn => execute_btn,
      sync        => sync,
      led         => open,
      audio_out   => open
    );

  -- clock process
  clock: process
    begin
      wait for period/2;
      clk <= not clk;
  end process; 
  
  -- sync process
  sync_stim: process 
    begin
      wait for period;     
      sync <= not sync;
  end process; 
 
  -- reset process
  async_reset: process
    begin
      wait for period*2;
      reset <= '0';
      wait;
  end process; 

  -- button test process
  button_stim: process 
    begin
      report "****************** Stimulus Start ****************";
      wait for period*4; -- Wait for reset to deassert
      -- Press button 10 times to execute 10 instructions
      press_button(execute_btn);
      press_button(execute_btn);
      press_button(execute_btn);
      press_button(execute_btn);
      press_button(execute_btn);
      press_button(execute_btn);
      press_button(execute_btn);
      press_button(execute_btn);
      press_button(execute_btn);
      press_button(execute_btn);
      press_button(execute_btn);
      report "****************** Stimulus End ******************";
      wait;
  end process; 
    
end arch;