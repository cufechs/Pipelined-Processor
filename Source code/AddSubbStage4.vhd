Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;
Entity AdderStage4_E is
Port(
  clk:IN std_logic;
  Flag:IN std_logic_vector(1 downto 0);
  A:IN std_logic_vector(31 downto 0);
  C:OUT std_logic_vector(31 downto 0)
);
END ENTITY;
Architecture AdderStage4_A OF AdderStage4_E IS
  BEGIN

    C <= std_logic_vector(to_unsigned(to_integer(unsigned(A)) + 2,32)) WHEN Flag = "10"
        ELSE std_logic_vector(to_unsigned(to_integer(unsigned(A)) - 2,32)) WHEN Flag = "01"
		ELSE A;

END Architecture;
