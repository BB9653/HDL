-- Befekir Belayneh
-- Lab 9: DJ Roomba 3000 

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity dj_roomba_3000 is 
  port(
    clk                 : in std_logic;
    reset               : in std_logic;
    execute_btn         : in std_logic;
    sync                : in std_logic;
    led                 : out std_logic_vector(7 downto 0);
    audio_out           : out std_logic_vector(15 downto 0) := (others => '0')
  );
end dj_roomba_3000;

architecture beh of dj_roomba_3000 is
  -- instruction memory
  component rom_instructions
    port(
      address    : in std_logic_vector (4 DOWNTO 0);
      clock      : in std_logic  := '1';
      q          : out std_logic_vector (7 DOWNTO 0)
    );
  end component;
  
  -- data memory
  component rom_data
    port(
      address  : in std_logic_vector (13 DOWNTO 0);
      clock    : in std_logic  := '1';
      q        : out std_logic_vector (15 DOWNTO 0)
    );
  end component;

  component rising_edge_synchronizer
    port (
      clk   : in std_logic;
      reset : in std_logic;
      input : in std_logic;
      edge  : out std_logic
    );
  end component;
  
type state_type is (idle, fetch, decode, execute, decode_error);
signal state, next_state : state_type;

signal data_address  : std_logic_vector(13 downto 0) := (others => '0');
signal execute_sig : std_logic;
signal pc   : std_logic_vector(4 downto 0) := (others => '0'); --program counter
signal instruction_srq : std_logic_vector(7 downto 0) := (others => '0'); --fetched instruction
signal instruction : std_logic_vector(7 downto 0) := (others => '0'); --store instruction before increment
signal play_once  : std_logic;
signal play_repeat  : std_logic;
signal pause  : std_logic;
signal seek  : std_logic;
signal stop  : std_logic;

alias opcode : std_logic_vector(1 downto 0) is instruction_srq(7 downto 6); --op code from instruction
alias seek_address : std_logic_vector(4 downto 0) is instruction_srq(4 downto 0); --seek instruction for seek state

begin

u_rom_inst : rom_instructions
  port map (
  address => pc,
  clock => clk,
  q => instruction
  );

-- data instantiation
u_rom_data_inst : rom_data
  port map (
    address    => data_address,
    clock      => clk,
    q          => audio_out
  );

ex_sync : rising_edge_synchronizer
  port map (
    clk => clk,
    reset => reset,
    input => execute_btn,
    edge => execute_sig
  );

  process(clk, reset,state)
  begin
    if(reset = '1') then
      state <= idle;
    elsif (clk'event and clk = '1') then
      state <= next_state;
    end if;
  end process;
  
  process(state, execute_sig, opcode)
  begin
    next_state <= state;
      case state is
        when idle =>
          if execute_sig = '1' then
            next_state <= fetch;
          end if;

        when fetch =>
          next_state <= decode;
        when decode =>
          --Check opcode and set next state
          case opcode is
            when "00" => --Play
              next_state <= execute;
            when "01" => --Pause
              next_state <= execute;
            when "10" => --Seek
              next_state <= execute;
            when "11" => --Stop
              next_state <= execute;
            when others =>
              next_state <= decode_error;
            end case;

        when execute =>
          next_state <= idle;

        when decode_error =>
          next_state <= idle;
        
        when others =>
          next_state <= idle;
    end case;
  end process;
  
  process(clk, reset) --store instruction
  begin
  if reset = '1' then
    instruction_srq <= instruction;
  elsif (clk'event and clk = '1') then
    if state = fetch then
      instruction_srq <= instruction;
    end if;
  end if;
  end process;
 
  process(clk, reset)
  begin
  if reset = '1' then
    data_address <= (others => '0');
  elsif (clk'event and clk = '1') then
            if (sync = '1') then
                 if (play_once = '1' or play_repeat = '1') then
                  data_address <= std_logic_vector(unsigned(data_address) + 1); --increment
              elsif pause = '1' then --repeat
                data_address <= data_address;
              elsif seek = '1' then
              data_address <= seek_address & "000000000";
              elsif stop = '1' then
                data_address <= (others => '0');
              else
                data_address <= data_address;
              end if;
            end if;
          end if;
  end process;
  
  process(clk, reset)
  begin
    if reset = '1' then
      play_once <= '0';
      play_repeat <= '0';
      pause <= '0';
      seek <= '0';
      stop <= '0';
    elsif (clk'event and clk = '1') then
      if data_address = "11111111111111" then
         play_once <= '0';
      end if;
       if state = execute then
         play_once <= '0';
         play_repeat <= '0';
         pause <= '0';
         seek <= '0';
         stop <= '0';
         if opcode = "00" then
           if instruction_srq(5) = '0' then
             play_once <= '1';
           else
             play_repeat <= '1';
           end if;
       elsif opcode = "01" then
         pause <= '1';
       elsif opcode = "10" then
         seek <= '1';
       else
         stop <= '1';
       end if;
     end if;
   end if;
   end process;

  process(clk, reset)
  begin
    if reset = '1' then
      pc <= (others => '0');
    elsif (clk'event and clk = '1') then
      if state = fetch then
        pc <= std_logic_vector(unsigned(pc) + 1);
      end if;
    end if;
  end process;
  
  led <= instruction_srq;
end beh;