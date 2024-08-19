--Befekir Belayneh
--lab 2 structural demo

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_single_bit_structural is
  Port (
    A     : in STD_LOGIC; --first input
    B     : in STD_LOGIC; --second input
    Cin   : in STD_LOGIC; --carry bit
    Sum   : out STD_LOGIC; -- sum output
    Cout  : out STD_LOGIC  --carry-out bit
  );
 end adder_single_bit_structural;

architecture Structural of adder_single_bit_structural is 
  signal xor1_out : STD_LOGIC;
  signal xor2_out : STD_LOGIC;
  signal and1_out : STD_LOGIC;
  signal and2_out : STD_LOGIC;
  signal and3_out : STD_LOGIC;
  
  component alu_xor  --component structures
    Port (
      A : in STD_LOGIC;
      B : in STD_LOGIC;
      Y : out STD_LOGIC
    );
  end component;

  component alu_and
    Port (
      A : in STD_LOGIC;
      B : in STD_LOGIC;
      Y : out STD_LOGIC
    );
  end component;

  component alu_or
    Port (
      A : in STD_LOGIC;
      B : in STD_LOGIC;
      C : in STD_LOGIC;
      Y : out STD_LOGIC
    );
  end component;
  
begin 

  U1: alu_xor --xor gate for first stage
    Port map (
      A => A,
      B => B,
      Y => xor1_out
    );

  U2: alu_xor --second stage
    Port map (
      A => xor1_out,
      B => Cin,
      Y => xor2_out
    );

  U3: alu_and --first term of Cout
    Port map (
      A => A,
      B => B,
      Y => and1_out
    );

  U4: alu_and --second term of Cout
    Port map (
      A => B,
      B => Cin,
      Y => and2_out
    );

  U5: alu_and --third term
    Port map (
      A => Cin,
      B => A,
      Y => and3_out
    );

  U6: alu_or  --combine terms for Cout
    Port map (
      A => and1_out,
      B => and2_out,
      C => and3_out,
      Y => Cout
    );

  Sum <= xor2_out;
  
end Structural;