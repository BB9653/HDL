--Befekir Belayneh
--full adder testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_single_bit_tb is
end adder_single_bit_tb;

architecture Behavioral of adder_single_bit_tb is

  signal A    : STD_LOGIC;
  signal B    : STD_LOGIC;
  signal Cin  : STD_LOGIC;
  signal Sum  : STD_LOGIC;
  signal Cout : STD_LOGIC;
  
  component full_adder
    Port (
      A    : in STD_LOGIC;
      B    : in STD_LOGIC;
      Cin  : in STD_LOGIC;
      Sum  : out STD_LOGIC;
      Cout : out STD_LOGIC
    );
  end component;

begin


  uut: full_adder
    Port map (
      A => A,
      B => B,
      Cin => Cin,
      Sum => Sum,
      Cout => Cout
    );

  process
  begin
  
    A <= '0';
    B <= '0';
    Cin <= '0';
    wait for 20 ns; --test case 1: 0 + 0 no carry

    A <= '0';
    B <= '0';
    Cin <= '1';
    wait for 20 ns; --test case 2: 0 + 0 w/ carry

    A <= '0';
    B <= '1';
    Cin <= '0';
    wait for 20 ns; --test case 3: 0 + 1 no carry

    A <= '0';
    B <= '1';
    Cin <= '1';
    wait for 20 ns; --test case 4: 0 + 1 w/ carry

    A <= '1';
    B <= '0';
    Cin <= '0';
    wait for 20 ns; --test case 5: 1 + 0 no carry

    A <= '1';
    B <= '0';
    Cin <= '1';
    wait for 20 ns; --test case 6: 1 + 0 w/ carry

    A <= '1';
    B <= '1';
    Cin <= '0';
    wait for 20 ns; --test case 7: 1 + 1 no carry

    A <= '1';
    B <= '1';
    Cin <= '1';
    wait for 20 ns; --test case 8: 1 + 1 w/ carry

    wait;
  end process;

end Behavioral;

