Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;
Entity Adder_E is
Port(
  A,B:IN std_logic_vector(31 downto 0);
  C:OUT std_logic_vector(31 downto 0)
);
END Adder_E;
Architecture Adder_A OF Adder_E IS
  BEGIN 
    C <= std_logic_vector(to_unsigned(to_integer(unsigned(A)) + to_integer(unsigned(B)),32));  
  END Architecture;
