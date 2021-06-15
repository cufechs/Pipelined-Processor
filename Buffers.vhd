library ieee;
use ieee.std_logic_1164.all;

ENTITY nD_FP IS
GENERIC ( n : integer := 16);
PORT( 
clk: IN std_logic;
d : IN std_logic_vector(n-1 DOWNTO 0);
q : OUT std_logic_vector(n-1 DOWNTO 0)
);
END ENTITY;

ARCHITECTURE a_nD_FP OF nD_FP IS
BEGIN
PROCESS (clk)
BEGIN
IF rising_edge(Clk)THEN
q <= d;
END IF;
END PROCESS;
END a_nD_FP;


