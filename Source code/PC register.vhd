library ieee;
use ieee.std_logic_1164.all;

ENTITY PC_E IS
GENERIC ( n : integer := 16);
PORT( 
clk,rst: IN std_logic;
d : IN std_logic_vector(n-1 DOWNTO 0);
q : OUT std_logic_vector(n-1 DOWNTO 0)
);
END ENTITY;

ARCHITECTURE PC_A OF PC_E IS
BEGIN
PROCESS (clk,rst)
BEGIN
IF rst = '1' THEN
q <= (OTHERS=>'0');
ELSIF rising_edge(Clk) THEN
q <= d;
END IF;
END PROCESS;
END PC_A;


