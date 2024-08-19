-------------------------------------------------------------------------------
-- Befekir Belayneh
-- CPU mem file
--8/7/2024
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity block_mem is
  port (
    clk        : in  std_logic; --50MHz
    reset      : in  std_logic;
    execute    : in std_logic; --execute push button
    state_led  : out std_logic_vector(3 downto 0);
    HEX0       : out std_logic_vector(6 downto 0); --Output display
    HEX1       : out std_logic_vector(6 downto 0);
    HEX2       : out std_logic_vector(6 downto 0)
  );
end block_mem;

architecture beh of block_mem is

  component seven_seg is
    port (
      bcd              : in  std_logic_vector(3 downto 0); 
      seven_seg_out    : out std_logic_vector(6 downto 0)
    );  
  end component; 

  component blink_rom
    port (
      address         : in std_logic_vector (4 downto 0);
      clock           : in std_logic  := '1';
      q               : out std_logic_vector (10 downto 0)
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

  component alu is
    port (
      clk           : in  std_logic;
      reset         : in  std_logic;
      a             : in  std_logic_vector(7 downto 0); 
      b             : in  std_logic_vector(7 downto 0);
      op            : in  std_logic_vector(2 downto 0);
      result        : out std_logic_vector(7 downto 0)
    );
  end component;
  
  component memory is
    generic (addr_width : integer := 2;
             data_width : integer := 8);
    port (
      clk               : in std_logic;
      we                : in std_logic;
      addr              : in std_logic_vector(addr_width - 1 downto 0);
      din               : in std_logic_vector(data_width - 1 downto 0);
      dout              : out std_logic_vector(data_width - 1 downto 0)
    );
  end component;
  
  component double_dabble is --double dabble algorithm
    port (
      result_padded : in std_logic_vector(7 downto 0);
      ones          : out std_logic_vector(3 downto 0);
      tens          : out std_logic_vector(3 downto 0);
      hundreds      : out std_logic_vector(3 downto 0)
    );
  end component;
  
  
  --State Machine
  type state_type is (idle, fetch, calc, save, write_mem, recall); --FSM
  signal state, next_state : state_type; 
  
  --Instruction Op Codes
  constant op_add : std_logic_vector(2 downto 0) := "000";
  constant op_sub : std_logic_vector(2 downto 0) := "001";
  constant op_mul : std_logic_vector(2 downto 0) := "010";
  constant op_div : std_logic_vector(2 downto 0) := "011";
  constant op_ms  : std_logic_vector(2 downto 0) := "100";
  constant op_mr  : std_logic_vector(2 downto 0) := "101";  
  
  signal address_sig  : std_logic_vector(4 downto 0) := "00000"; --ROM address
  signal q_sig        : std_logic_vector(10 downto 0) := (others => '0'); --ROM instruction 
  signal ex_sig       : std_logic := '0'; --synchronous execute signal
  signal mem_we       : std_logic := '0'; --memory enable signal
  signal mem_addr     : std_logic_vector(1 downto 0); --memory address
  signal mem_din      : std_logic_vector(7 downto 0) := (others => '0'); --write to memory
  signal mem_dout     : std_logic_vector(7 downto 0) := (others => '0'); --read from memory
  signal alu_res      : std_logic_vector(7 downto 0) := (others => '0'); --calculator result
  signal ones         : std_logic_vector(3 downto 0) := (others => '0');
  signal tens         : std_logic_vector(3 downto 0) := (others => '0');
  signal hundreds     : std_logic_vector(3 downto 0) := (others => '0');
  
  alias op_code : std_logic_vector(2 downto 0) is q_sig(10 downto 8); --first 3 bits of instruction
  alias input_2 : std_logic_vector(7 downto 0) is q_sig(7 downto 0); --last 8 bits of instruction

begin

  rom_inst : blink_rom --ROM instantiation
    port map (
      address     => address_sig,
      clock       => clk,
      q           => q_sig
    );
  
  alu_inst: alu --calculator
    port map (
      clk => clk,
      reset => reset,
      a => mem_dout,
      b => input_2,
      op => op_code,
      result => alu_res
    );
  
  ex_sync: rising_edge_synchronizer
    port map (
      clk => clk,
      reset => reset,
      input => execute,
      edge => ex_sig
    );
  
  mem_inst: memory --memory
    generic map (
      addr_width => 2,
      data_width => 8
    )
    port map (
      clk => clk,
      we  => mem_we,
      addr => mem_addr, 
      din => mem_din,
      dout => mem_dout
    );
  
  fsm_update: process(reset, clk) --synchronous state process
  begin
    if(reset = '1') then
      state <= idle;
      address_sig <= (others => '0');
    elsif (clk'event and clk = '1') then
      state <= next_state;
      if (state /= idle and next_state = idle) then
        address_sig <= std_logic_vector(unsigned(address_sig) + 1); --go to next instruction set
      end if;
    end if;
  end process fsm_update;
  
    -- next state logic
    process(state, ex_sig)
    begin
      next_state <= state;
        case state is
            when idle =>
                if ex_sig = '1' then
                    next_state <= fetch;
                else
                    next_state <= idle;
                end if;
            when fetch =>
              if op_code = op_add then --if calculating go to calc state
                next_state <= calc;
              elsif op_code = op_sub then
                next_state <= calc;
              elsif op_code = op_mul then
                next_state <= calc;
              elsif op_code = op_div then
                next_state <= calc;
              elsif op_code = op_ms then
                next_state <= save;
              elsif op_code = op_mr then
                next_state <= recall;
              end if;
            when calc =>
              next_state <= idle;
            when save =>
              next_state <= idle;
            when write_mem =>
              next_state <= idle;
            when recall =>
              next_state <= write_mem;
            when others =>
                next_state <= idle;
        end case;
    end process;

    -- output logic
    process(state, mem_dout, alu_res)
    begin
        case state is
            when idle =>
              mem_we <= '0'; --disable memory save
              mem_addr <= "00"; --first memory space
              mem_din <= mem_dout;
            when calc =>
              mem_we <= '1'; --enable save
              mem_addr <= "00"; --save to first address
              mem_din <= alu_res;
            when save =>
              mem_we <= '1'; --enable save
              mem_addr <= "01"; --save register address
              mem_din <= mem_dout; --save output
            when write_mem =>
              mem_we <= '1';
              mem_addr <= "00";
              mem_din <= mem_dout;
            when recall =>
              mem_we <= '0'; --turn off memory save
              mem_addr <= "01"; --address of save register
              mem_din <= mem_dout;
            when others =>
              mem_we <= '0'; --disable memory save
              mem_addr <= "00"; --first memory space
              mem_din <= mem_dout;
        end case;
    end process;

  --state led process
  process(state)
  begin
    if state = idle then
      state_led <= "0001";
    elsif state = fetch then
      state_led <= "0010";
    elsif state = calc then
      state_led <= "0100";
    elsif state = save then
      state_led <= "1000";
    elsif state = write_mem then
      state_led <= "1001";
    elsif state = recall then
      state_led <= "1010";
    end if;
  end process;

  dd_uut: double_dabble
    port map (
      result_padded => mem_dout,
      ones => ones,
      tens => tens,
      hundreds => hundreds
      );

  one_seg_inst: seven_seg 
    port map (
      bcd            => ones,
      seven_seg_out  => HEX0
    );  

  ten_seg_inst: seven_seg 
    port map (
      bcd            => tens,
      seven_seg_out  => HEX1
    );  

  hun_seg_inst: seven_seg 
    port map (
      bcd            => hundreds,
      seven_seg_out  => HEX2
    );  
  
end beh;