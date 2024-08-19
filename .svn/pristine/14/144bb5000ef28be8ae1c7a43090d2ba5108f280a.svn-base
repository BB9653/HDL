--Befekir Belayneh
--top level module for lab 4
--contains all components and process and instantiations
--6/13/2024

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_module is
  port (
    clk         : in  std_logic; --sync clock 50MHz
    reset       : in  std_logic;
    input       : in  std_logic_vector(3 downto 0);  -- Assuming 4-bit input
    ssd_out     : out std_logic_vector(6 downto 0)   -- Output for seven segment display
  );
end entity top_module;


architecture arch of top_module is

  constant NUM_BITS  : integer := 4;
  constant MAX_COUNT : integer := 50000000;

component generic_counter
  generic (
    max_count       : integer := 5
  );
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    output          : out std_logic
  );  
end component;

component generic_adder_beh
  generic (
    bits    : integer := 4
  );
  port (
    a       : in  std_logic_vector(NUM_BITS-1 downto 0);
    b       : in  std_logic_vector(NUM_BITS-1 downto 0);
    cin     : in  std_logic;
    sum     : out std_logic_vector(NUM_BITS-1 downto 0);
    cout    : out std_logic
  );
end component;

component seven_seg
  port (
    enable        : in std_logic;
    bcd           : in std_logic_vector(3 downto 0);
    seven_seg_out : out std_logic_vector(6 downto 0)
  );
end component;

  signal sum_sig_signal      : std_logic_vector(NUM_BITS - 1 downto 0) := (others => '0');
  signal sum_signal          : std_logic_vector(NUM_BITS - 1 downto 0);
  signal enable_signal       : std_logic := '0';
  signal seven_seg_out       : std_logic_vector(6 downto 0);
  
begin 

  uut_counter: generic_counter --connected
    generic map(
      max_count => MAX_COUNT
    )
    port map (
      clk => clk,
      reset => reset,
      output => enable_signal
    );
  
  uut_adder: generic_adder_beh
    generic map (
      bits => NUM_BITS
    )
    port map (
      a => input,
      b => sum_sig_signal,
      cin => '0',
      sum => sum_signal,
      cout => open
    );


  sum_register: process(clk, reset, enable_signal)
  begin
    if (reset = '0') then 
      sum_sig_signal <= "0000";
    elsif rising_edge(clk) then
      if enable_signal = '1' then
        sum_sig_signal <= sum_signal;
      end if;
    end if;
  end process;
  
  uut_seven_seg: seven_seg
  port map (
    enable => enable_signal,
    bcd => sum_sig_signal,
    seven_seg_out => ssd_out 
  );
  

end arch;  