library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_sub_tb is
end add_sub_tb;

architecture tb_arch of add_sub_tb is

  constant CLK_PERIOD : time := 100 ns;
  constant NUM_BITS   : integer := 3;
  
component top
  port (
    clk     : in  std_logic;
    reset   : in  std_logic;
    input_a : in  std_logic_vector(NUM_BITS-1 downto 0);
    input_b : in  std_logic_vector(NUM_BITS-1 downto 0);
    p_btn   : in  std_logic;
    m_btn   : in  std_logic;
    sum     : out std_logic_vector(NUM_BITS downto 0);
    HEX0    : out std_logic_vector(6 downto 0);
    HEX1    : out std_logic_vector(6 downto 0);
    HEX2    : out std_logic_vector(6 downto 0)
  );
end component;
  
  --signals
  signal clk     :  std_logic;
  signal reset   :  std_logic;
  signal a       :  std_logic_vector(NUM_BITS - 1 downto 0) := "000";
  signal b       :  std_logic_vector(NUM_BITS - 1 downto 0) := "000";
  signal p_btn   :  std_logic;
  signal m_btn   :  std_logic;
  signal sum     :  std_logic_vector(NUM_BITS downto 0) := "0000";
  signal HEX0    :  std_logic_vector(6 downto 0);
  signal HEX1    :  std_logic_vector(6 downto 0);
  signal HEX2    :  std_logic_vector(6 downto 0);
  
begin

  uut: top
  port map (
    clk => clk,
    reset => reset,
    input_a => a,
    input_b => b,
    p_btn => p_btn,
    m_btn => m_btn,
    sum => sum,
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
    reset <= '1';
    wait for 20 ns;
    reset <= '0';
    wait for 10000 ns;
    reset <= '1';
    wait for 40 ns;
    reset <= '0';
    wait;
  end process;
  
  btn_process: process --simulate add button press
  begin
    p_btn <= '1';
    wait for 400 ns;
    p_btn <= '0';
    wait for 80 ns;
    p_btn <= '1';
    wait;
  end process;
  
  btn_2_process: process --simulate sub button press
  begin 
    m_btn <= '1';
    wait for 30000 ns;
    m_btn <= '0';
    wait for 80 ns;
    m_btn <= '1';
    wait;
  end process;
  
  
  stim_proc: process
  variable a_int : integer := 0;
  variable b_int : integer := 0;
  begin
  wait for 500 ns;
    while true loop
    for b_int in 0 to 7 loop
      b <= std_logic_vector(to_unsigned(b_int, 3)); -- iterate b after all a values
      for a_int in 0 to 7 loop
        a <= std_logic_vector(to_unsigned(a_int, 3)); --iterate a for all values
        wait for 40 ns;
      end loop;
    end loop;
  end loop;
  end process;

end tb_arch;
