---------------------------------------
--Befekir Belayneh                     
--Top Level Design for 8 bit calculator
--7/9/2024                             
---------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.memory_pkg.all;
use work.alu_pkg.all;

entity top is
  port (
    clk       : in std_logic; --50MHz clk
    reset_n   : in std_logic; --inverted reset
    ms        : in std_logic; --memory save
    mr        : in std_logic; --memory recall
    execute   : in std_logic;
    input_2   : in std_logic_vector(7 downto 0); --2nd input
    op        : in std_logic_vector(1 downto 0); --operation select
    led       : out std_logic_vector(3 downto 0); --state led
    HEX0      : out std_logic_vector(6 downto 0); --ones display
    HEX1      : out std_logic_vector(6 downto 0); --tens display
    HEX2      : out std_logic_vector(6 downto 0) --hundreds display
  );
end top;

architecture beh of top is

  constant addr_width : integer := 2;

  type state_type is (idle, mem_save, mem_recall, calc, write_save); --FSM
  signal state, next_state : state_type;
  signal alu_res     : std_logic_vector(7 downto 0) := (others => '0'); --result of calculator
  signal mem_we      : std_logic := '0'; --memory enable signal
  signal mem_addr    : std_logic_vector(1 downto 0); --memory address
  signal mem_din     : std_logic_vector(7 downto 0) := (others => '0'); --write to memory
  signal mem_dout    : std_logic_vector(7 downto 0) := (others => '0'); --read from memory
  signal ms_sig      : std_logic; --synced button inputs
  signal mr_sig      : std_logic;
  signal ex_sig      : std_logic;
  signal reset       : std_logic;
  signal ones : std_logic_vector(3 downto 0) := (others => '0');
  signal tens : std_logic_vector(3 downto 0) := (others => '0');
  signal hundreds : std_logic_vector(3 downto 0) := (others => '0');
  
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

  alu_inst: entity work.alu --calculator
    port map (
      clk => clk,
      reset => reset,
      a => mem_dout,
      b => input_2,
      op => op,
      result => alu_res
    );

  mem_inst: entity work.memory --memory
    generic map (
      addr_width => addr_width,
      data_width => 8
    )
    port map (
      clk => clk,
      we  => mem_we,    
      addr => mem_addr, 
      din => mem_din,
      dout => mem_dout
    );
  
  ms_sync: rising_edge_synchronizer 
    port map(
    clk => clk,
    reset => reset,
    input => ms,
    edge => ms_sig
  );
  
  mr_sync: rising_edge_synchronizer
    port map(
    clk => clk,
    reset => reset,
    input => mr,
    edge => mr_sig
  );
  
  ex_sync: rising_edge_synchronizer
    port map(
    clk => clk,
    reset => reset,
    input => execute,
    edge => ex_sig
  );
  
  fsm_update: process(reset, clk) --synchronous state process
  begin
    if(reset = '1') then
      state <= idle;
    elsif (clk'event and clk = '1') then
      state <= next_state;
    end if;
  end process fsm_update;
  
 --State Transition Logic 
  fsm_decode: process(state, ex_sig, mr_sig, ms_sig)
  begin
    next_state <= state;
    case state is
      when idle =>
        mem_we <= '0';
        mem_addr <= "00";
        mem_din <= mem_dout;
        if ex_sig = '1' then
          next_state <= calc;
        elsif mr_sig = '1' then
          next_state <= mem_recall;
        elsif ms_sig = '1' then
          next_state <= mem_save;
        else
          next_state <= idle;
        end if;
      when calc =>
        mem_we <= '1'; --enable save
        mem_addr <= "00"; --save to first address
        mem_din <= alu_res; --save arithmetic output
        next_state <= idle;
      when mem_recall =>
        mem_we <= '0'; --turn off memory save
        mem_addr <= "01"; --address of save register
        mem_din <= mem_dout;
        next_state <= write_save;
      when mem_save =>
        mem_we <= '1'; --turn on memory save
        mem_addr <= "01"; --address of save register
        mem_din <= mem_dout; --save output
        next_state <= idle;
      when write_save =>
        mem_we <= '1';
        mem_addr <= "00";
        mem_din <= mem_dout;
        next_state <= idle;
    end case;
  end process fsm_decode;

  --state led process
  process(state)
  begin
    if state = idle then
      led <= "0001";
    elsif state = calc then
      led <= "0010";
    elsif state = mem_save then
      led <= "0100";
    elsif state = mem_recall then
      led <= "1000";
    end if;
  end process;
  
  bcd1: process(mem_dout) --double dabble
  -- temporary variable
  variable temp : STD_LOGIC_VECTOR (11 downto 0);
  variable display : std_logic_vector(11 downto 0);
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
    display := std_logic_vector(unsigned("0000" & mem_dout));
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

  reset <= not reset_n; --invert reset
end beh;