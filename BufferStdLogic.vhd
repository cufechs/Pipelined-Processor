
library ieee;
use ieee.std_logic_1164.all;

ENTITY D_FP IS
PORT( 
clk: IN std_logic;
d : IN std_logic;
q : OUT std_logic
);
END ENTITY;

ARCHITECTURE a_D_FP OF D_FP IS
BEGIN
PROCESS (clk)
BEGIN
IF rising_edge(Clk)THEN
q <= d;
END IF;
END PROCESS;
END a_D_FP;



