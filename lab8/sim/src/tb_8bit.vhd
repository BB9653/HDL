library ieee;
use ieee.std_logic_1164.all;

entity tb_8bit is
end tb_8bit;

architecture Behavioral of tb_8bit is

    -- Component declaration for the Unit Under Test (UUT)
    component block_mem
    port(
        clk       : in  std_logic;
        reset     : in  std_logic;
        execute   : in  std_logic;
        state_led : out  std_logic_vector(3 downto 0);
        HEX0  : out std_logic_vector(6 downto 0);
        HEX1  : out std_logic_vector(6 downto 0);
        HEX2  : out std_logic_vector(6 downto 0)
    );
    end component;

    -- Signals to connect to the UUT
    signal clk         : std_logic := '0';
    signal reset       : std_logic := '0';
    signal execute     : std_logic := '0';
    signal state_led   : std_logic_vector(3 downto 0);
    signal HEX0      : std_logic_vector(6 downto 0);
    signal HEX1      : std_logic_vector(6 downto 0);
    signal HEX2      : std_logic_vector(6 downto 0);

    -- Clock period definition
    constant clk_period : time := 50 ns;

begin

    -- Instantiate the UUT
    uut: block_mem
    port map (
        clk     => clk,
        reset   => reset,
        execute => execute,
        state_led  => state_led,
        HEX0 => HEX0,
        HEX1 => HEX1,
        HEX2 => HEX2
    );
    --Reset process definition
    res_proc: process
    begin
      reset <= '1';
      wait for 60 ns;
      reset <= '0';
      wait;
     end process;

    -- Clock process definition
    clk_process :process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initialize Inputs
        execute <= '0';

        -- Wait for the global reset to finish
        wait for 100 ns;

        -- Execute Add instruction
        execute <= '1';
        wait for clk_period;
        execute <= '0';
        wait for clk_period;

        -- Execute multiply instruction
        execute <= '1';
        wait for clk_period;
        execute <= '0';
        wait for clk_period;

        -- Execute Save instruction
        execute <= '1';
        wait for clk_period;
        execute <= '0';
        wait for clk_period;

        -- Execute Subtract instruction
        execute <= '1';
        wait for clk_period;
        execute <= '0';
        wait for clk_period;

        -- Execute Divide instruction
        execute <= '1';
        wait for clk_period;
        execute <= '0';
        wait for clk_period;

        -- Execute Recall instruction
        execute <= '1';
        wait for clk_period;
        execute <= '0';
        wait for clk_period;

        -- Execute Divide instruction
        execute <= '1';
        wait for clk_period;
        execute <= '0';
        wait for clk_period;

        -- Stop simulation
        wait;
    end process;

end Behavioral;