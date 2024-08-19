library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calculator_tb is
end calculator_tb;

architecture tb_arch of calculator_tb is

  constant CLK_PERIOD : time := 100 ns;
  constant NUM_BITS   : integer := 8;
  
component top
  port (
    clk       : in std_logic;
    reset_n   : in std_logic;
    ms        : in std_logic;
    mr        : in std_logic;
    execute   : in std_logic;
    input_2   : in std_logic_vector(7 downto 0);
    op        : in std_logic_vector(1 downto 0);
    led       : out std_logic_vector(3 downto 0);
    HEX0      : out std_logic_vector(6 downto 0);
    HEX1      : out std_logic_vector(6 downto 0);
    HEX2      : out std_logic_vector(6 downto 0)
  );
end component;
  
  --signals
    signal clk       : std_logic;
    signal reset_n   : std_logic := '1';
    signal ms        : std_logic := '1';
    signal mr        : std_logic := '1';
    signal execute   : std_logic := '1';
    signal input_2   : std_logic_vector(7 downto 0) := "00000000";
    signal op        : std_logic_vector(1 downto 0) := "00";
    signal led       : std_logic_vector(3 downto 0);
    signal HEX0      : std_logic_vector(6 downto 0);
    signal HEX1      : std_logic_vector(6 downto 0);
    signal HEX2      : std_logic_vector(6 downto 0);
  
begin

  uut: top
  port map (
    clk => clk,
    reset_n => reset_n,
    ms => ms,
    mr => mr,
    execute => execute,
    input_2 => input_2,
    op => op,
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
  
  reset_process: process --simulate reset
  begin
    reset_n <= '0';
    wait for 40 ns;
    reset_n <= '1';
    wait;
  end process;
   
  stim_proc: process
  begin
  --add 4
  wait for 100 ns;
  input_2 <= "00000100"; --insert 4
  wait for 40 ns;
  op <= "00"; --add
  wait for 40 ns;
  execute <= '0';--execute
  wait for 80 ns;
  execute <= '1';
  
  --multiply 8
  wait for 60 ns;
  input_2 <= "00001000"; --insert 8
  wait for 60 ns;
  op <= "10"; --multiply
  wait for 60 ns;
  execute <= '0'; --execute
  wait for 60 ns;
  execute <= '1';
  
  --save data
  wait for 60 ns;
  ms <= '0';
  wait for 60 ns;
  ms <= '1';--press mem save
  
  --subtract 8
  wait for 60 ns;
  input_2 <= "00001000"; --insert 8
  op <= "01"; --subtract mode
  wait for 60 ns;
  execute <= '0';
  wait for 60 ns;
  execute <= '1';
  
  --divide by 2
  wait for 60 ns;
  input_2 <= "00000010"; --insert 2
  op <= "11";
  wait for 60 ns;
  execute <= '0';
  wait for 60 ns;
  execute <= '1';
  
  --load memory
  wait for 60 ns;
  mr <= '0';
  wait for 60 ns;
  mr <= '1';
  
  --divide by 2
  input_2 <= "00000010"; --insert 2
  op <= "11";
  wait for 60 ns;
  execute <= '0';
  wait for 60 ns;
  execute <= '1';
  wait;
  
  end process;

end tb_arch;
