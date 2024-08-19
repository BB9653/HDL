--Befekir Belayneh
--Lab 6 top level module
--6/25/2024

library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity top is
  port (
    clk   : in std_logic;
    reset : in std_logic;
    state_change : in std_logic; --button state change
    input : in std_logic_vector(7 downto 0);
    led   : out std_logic_vector(3 downto 0); --state status
    HEX0  : out std_logic_vector(6 downto 0); --ones 
    HEX1  : out std_logic_vector(6 downto 0); --tens
    HEX2  : out std_logic_vector(6 downto 0)  --hundreds
  );
end top;

architecture behave of top is
  
  type state_type is (input_a, input_b, disp_sum, disp_diff);
  signal state, next_state : state_type;
  signal counter : integer := 0;
  signal a : std_logic_vector(7 downto 0) := (others => '0');
  signal b : std_logic_vector(7 downto 0) := (others => '0');
  signal display : std_logic_vector(15 downto 0) := (others => '0');
  signal state_sync_sig : std_logic;
  signal outSum : std_logic_vector(15 downto 0);
  signal outDiff : std_logic_vector(15 downto 0);
  signal ones : std_logic_vector(3 downto 0) := (others => '0');
  signal tens : std_logic_vector(3 downto 0) := (others => '0');
  signal hundreds : std_logic_vector(3 downto 0) := (others => '0');
  
component add
  generic (
    bits    : integer := 8
  );
  port (
    a       : in  std_logic_vector(7 downto 0);
    b       : in  std_logic_vector(7 downto 0);
    sum     : out std_logic_vector(15 downto 0)
  );
end component;

component sub
  generic (
    bits    : integer := 8
  );
  port (
    a       : in  std_logic_vector(7 downto 0);
    b       : in  std_logic_vector(7 downto 0);
    sum     : out std_logic_vector(15 downto 0)
  );
end component;

component top_calc
  port (
    clk         : in  std_logic;
    reset       : in  std_logic;
    a           : in  std_logic_vector(7 downto 0);
    b           : in  std_logic_vector(7 downto 0);
    outSum      : out std_logic_vector(15 downto 0);
    outDiff      : out std_logic_vector(15 downto 0)
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

component seven_seg
  port (
    bcd           : in std_logic_vector(3 downto 0);
    seven_seg_out : out std_logic_vector(6 downto 0)
  );
end component;

begin

  uut_calc: top_calc --calculator logic
    port map (
      clk => clk,
      reset => reset,
      a => a,
      b => b,
      outSum => outSum,
      outDiff => outDiff
    );

  uut_state_sync: rising_edge_synchronizer --sync button for state change
    port map (
      clk => clk,
      reset => reset,
      input => state_change,
      edge => state_sync_sig
    );

  --state transition process
  process(state_sync_sig, reset,counter, next_state)
  begin
    if reset = '1' then
      counter <= 0;
    elsif rising_edge(state_sync_sig) then
      if counter = 3 then
        counter <= 0;
      else
        counter <= counter + 1;
      end if;
    end if;

    if counter = 0 then
      next_state <= input_a;
      led <= "0001";
    elsif counter = 1 then
      next_state <= input_b;
      led <= "0010";
    elsif counter = 2 then
      next_state <= disp_sum;
      led <= "0100";
    elsif counter = 3 then
      next_state <= disp_diff;
      led <= "1000";
    end if;
    state <= next_state;
  end process;
  
  
  --next state logic
  process(state,input,counter)
  begin
    case state is
      when input_a =>
        a <= input;
        display <= std_logic_vector(signed(resize(unsigned(input), 16))); --display a
      when input_b =>
        b <= input;
        display <= std_logic_vector(signed(resize(unsigned(input), 16))); --display b
      when disp_sum =>
        display <= outSum; --display sum
      when disp_diff =>
        display <= outDiff; --display difference
      when others =>
        display <= "1111111111111111"; --display nothing
      end case;
  end process;
  
  bcd1: process(display)
  -- temporary variable
  variable temp : STD_LOGIC_VECTOR (11 downto 0);
  
  -- variable to store the output BCD number
  -- organized as follows
  -- thousands = bcd(15 downto 12)
  -- hundreds = bcd(11 downto 8)
  -- tens = bcd(7 downto 4)
  -- units = bcd(3 downto 0)
  variable bcd : UNSIGNED (15 downto 0) := (others => '0');
  
  begin
    -- zero the bcd variable
    bcd := (others => '0');
    
    -- read input into temp variable
    temp(11 downto 0) := display(11 downto 0);
    
    -- cycle 12 times as we have 12 input bits
    -- this could be optimized, we dont need to check and add 3 for the 
    -- first 3 iterations as the number can never be >4
    for i in 0 to 11 loop
      if bcd(3 downto 0) > 4 then 
        bcd(3 downto 0) := bcd(3 downto 0) + 3;
      end if;
      
      if bcd(7 downto 4) > 4 then 
        bcd(7 downto 4) := bcd(7 downto 4) + 3;
      end if;
    
      if bcd(11 downto 8) > 4 then  
        bcd(11 downto 8) := bcd(11 downto 8) + 3;
      end if;

      -- thousands can't be >4 for a 12-bit input number
      -- so don't need to do anything to upper 4 bits of bcd
    
      -- shift bcd left by 1 bit, copy MSB of temp into LSB of bcd
      bcd := bcd(14 downto 0) & temp(11);
    
      -- shift temp left by 1 bit
      temp := temp(10 downto 0) & '0';
    
    end loop;
 
    -- set outputs
    ones <= STD_LOGIC_VECTOR(bcd(3 downto 0));
    tens <= STD_LOGIC_VECTOR(bcd(7 downto 4));
    hundreds <= STD_LOGIC_VECTOR(bcd(11 downto 8));
    --thousands <= STD_LOGIC_VECTOR(bcd(15 downto 12));
  end process bcd1; 
  
  uut_one_ssd: seven_seg
  port map (
  bcd => ones,
  seven_seg_out => HEX0
  );

  uut_ten_ssd: seven_seg
  port map (
  bcd => tens,
  seven_seg_out => HEX1
  );
  
  uut_hun_ssd: seven_seg
  port map (
  bcd => hundreds,
  seven_seg_out => HEX2
  );  

end behave;