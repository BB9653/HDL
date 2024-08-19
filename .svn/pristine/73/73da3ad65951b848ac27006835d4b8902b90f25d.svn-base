--Befekir Belayneh
--top level module for lab 5
--contains all components and process and instantiations
--6/19/2024

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
  port (
    clk         : in  std_logic; --sync clock 50MHz
    reset       : in  std_logic;
    p_btn       : in  std_logic; --push button for add
    m_btn       : in  std_logic; --push button for subtract
    input_a     : in  std_logic_vector(2 downto 0);  -- Assuming 3-bit input
    input_b     : in  std_logic_vector(2 downto 0);
    sum         : out std_logic_vector(3 downto 0);  -- 4 bit output from arithmetic
    HEX0        : out std_logic_vector(6 downto 0);  -- seven segment display for input 1
    HEX1        : out std_logic_vector(6 downto 0);  --seven segment display for input 2
    HEX2        : out std_logic_vector(6 downto 0)   --seven segment display for sum output
  );
end entity top;

architecture arch of top is

  constant NUM_BITS  : integer := 3;

component add
  generic (
    bits    : integer := 3
  );
  port (
    a       : in  std_logic_vector(NUM_BITS-1 downto 0) := "000";
    b       : in  std_logic_vector(NUM_BITS-1 downto 0) := "000";
    sum     : out std_logic_vector(NUM_BITS downto 0)
  );
end component;

component sub
  generic (
    bits    : integer := 3
  );
  port (
    a       : in  std_logic_vector(NUM_BITS-1 downto 0);
    b       : in  std_logic_vector(NUM_BITS-1 downto 0);
    sum     : out std_logic_vector(NUM_BITS downto 0)
  );
end component;

component seven_seg
  port (
    bcd           : in std_logic_vector(NUM_BITS downto 0);
    seven_seg_out : out std_logic_vector(6 downto 0)
  );
end component;

component rising_edge_synchronizer
  port (
    clk      : in std_logic;
    reset    : in std_logic;
    input    : in std_logic;
    edge     : out std_logic
  );
end component;


  signal add_result : std_logic_vector(NUM_BITS downto 0);
  signal sub_result : std_logic_vector(NUM_BITS downto 0);
  signal bcd_a      : std_logic_vector(NUM_BITS downto 0);
  signal bcd_b      : std_logic_vector(NUM_BITS downto 0);
  signal sum_signal : std_logic_vector(NUM_BITS downto 0) := "0000";
  signal p_edge_detected  : std_logic;
  signal m_edge_detected  : std_logic;
  signal op         : std_logic := '0';
  
begin 

  uut_add: add --addition mux
    generic map (
      bits => NUM_BITS
    )
    port map (
      a => input_a,
      b => input_b,
      sum => add_result
    );

  uut_sub: sub --subtraction mux
    generic map (
      bits => NUM_BITS
    )
    port map (
      a => input_a,
      b => input_b,
      sum => sub_result
    );

  bcd_a <= '0' & input_a(2 downto 0);
  bcd_b <= '0' & input_b(2 downto 0);
  
   
  uut_rise_sync1: rising_edge_synchronizer --detect add button press
    port map (
      clk => clk,
      reset => reset,
      input => p_btn,
      edge => p_edge_detected
   );
   
  uut_rise_sync2: rising_edge_synchronizer --detect sub button press
    port map (
      clk => clk,
      reset => reset,
      input => m_btn,
      edge => m_edge_detected
   );

  process(clk, reset)
  begin
    if reset = '1' then
      op <= '0';
    elsif reset = '0' then 
       if rising_edge(clk) then --check clock edge
         if p_edge_detected = '1' then --check for addition button press
           op <= '0';
         elsif m_edge_detected = '1' then --check for subtraction button press
           op <= '1';
        end if;
      end if;
    end if;
  end process;
  
  op_select: process(op, add_result, sub_result) --check for execution button press
  begin
      if op = '0' then
        sum_signal <= add_result;
      elsif op = '1' then
        sum_signal <= sub_result;
      end if;
  end process;
  

  seven_seg_inst1: seven_seg --push input a to first hex display
    port map (
      bcd => bcd_a,
      seven_seg_out => HEX0
     );

  seven_seg_inst2: seven_seg --push input b to 2nd hex display
    port map (
      bcd => bcd_b,
      seven_seg_out => HEX1
    );

  
  sum <= sum_signal(3 downto 0);
  
  seven_seg_inst3: seven_seg --push output to 3rd hex display
  port map (
    bcd => sum_signal,
    seven_seg_out => HEX2 
  );
  
  

end arch;  