--Befekir Belayneh
--top level module for lab 6 calculator
--contains all components and process and instantiations
--6/25/2024

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_calc is
  port (
    clk         : in  std_logic; --sync clock 50MHz
    reset       : in  std_logic;
    a           : in  std_logic_vector(7 downto 0);  -- Assuming 8-bit input
    b           : in  std_logic_vector(7 downto 0);
    outSum      : out std_logic_vector(15 downto 0);  -- 16 bit output from arithmetic
    outDiff     : out std_logic_vector(15 downto 0)
  );
end entity top_calc;

architecture arch of top_calc is

  constant NUM_BITS  : integer := 8;

component add
  generic (
    bits    : integer := 8
  );
  port (
    a       : in  std_logic_vector(NUM_BITS-1 downto 0);
    b       : in  std_logic_vector(NUM_BITS-1 downto 0);
    sum     : out std_logic_vector(15 downto 0)
  );
end component;

component sub
  generic (
    bits    : integer := 8
  );
  port (
    a       : in  std_logic_vector(NUM_BITS-1 downto 0);
    b       : in  std_logic_vector(NUM_BITS-1 downto 0);
    diff    : out std_logic_vector(15 downto 0)
  );
end component;

component clock_synchronizer
  generic (
    bits    : integer := 8
  );
  port (
    clk      : in  std_logic;
    reset    : in  std_logic;
    async_in : in  std_logic_vector(NUM_BITS-1 downto 0);
    sync_out : out std_logic_vector(NUM_BITS-1 downto 0)
  );
end component;

  signal a_sync     : std_logic_vector(7 downto 0);
  signal b_sync     : std_logic_vector(7 downto 0);
  signal add_result : std_logic_vector(15 downto 0);
  signal sub_result : std_logic_vector(15 downto 0);
  signal sum_signal : std_logic_vector(15 downto 0);
  signal op         : std_logic := '0';
  
begin 

  uut_syncA: clock_synchronizer --sync input a
    generic map (
      bits => NUM_BITS
    )
    port map (
      clk => clk,
      reset => reset,
      async_in => a,
      sync_out => a_sync
    );

  uut_syncB: clock_synchronizer --sync input b
    generic map (
      bits => NUM_BITS
    )
    port map (
      clk => clk,
      reset => reset,
      async_in => b,
      sync_out => b_sync
    );

  uut_add: add --addition mux
    generic map (
      bits => NUM_BITS
    )
    port map (
      a => a_sync,
      b => b_sync,
      sum => add_result
    );

  uut_sub: sub --subtraction mux
    generic map (
      bits => NUM_BITS
    )
    port map (
      a => a_sync,
      b => b_sync,
      diff => sub_result
    );  
  
  outSum <= add_result(15 downto 0);
  outDiff <= sub_result(15 downto 0);

end arch;  