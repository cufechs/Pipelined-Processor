library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY SP_E IS
PORT( 
clk,rst: IN std_logic;
d : IN std_logic_vector(31 DOWNTO 0);
q : OUT std_logic_vector(31 DOWNTO 0)
);
END ENTITY;

ARCHITECTURE SP_A OF SP_E IS
BEGIN
PROCESS (clk,rst)
BEGIN
IF rst = '1' THEN
q <= "00000000000001111111111111111111";
ELSIF rising_edge(clk) THEN
q <= d;
END IF;
END PROCESS;
END SP_A;




