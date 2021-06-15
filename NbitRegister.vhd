library ieee;
use ieee.std_logic_1164.all;

ENTITY nD_FP_E IS
GENERIC ( n : integer := 16);
PORT( 
clk,rst,Enable: IN std_logic;
d : IN std_logic_vector(n-1 DOWNTO 0);
q : OUT std_logic_vector(n-1 DOWNTO 0)
);
END ENTITY;

ARCHITECTURE a_nD_FP OF nD_FP_E IS
BEGIN
PROCESS (clk,rst)
BEGIN
IF rst = '1' THEN
q <= (OTHERS=>'0');
ELSIF rising_edge(Clk) AND Enable = '1' THEN
q <= d;
END IF;
END PROCESS;
END a_nD_FP;
