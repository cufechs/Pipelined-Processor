library ieee;
use ieee.std_logic_1164.all;

ENTITY TriStepBuffer IS
Generic(n:integer:=16);
port(
  X:IN std_logic_vector(n-1 downto 0);
  Y:OUT std_logic_vector(n-1 downto 0);
  Enable:IN std_logic
);
END ENTITY;
Architecture a_TriStepBuffer OF TriStepBuffer IS
Begin
  Y<= X when Enable = '1'
  else (others=>'Z') when Enable ='0';
END Architecture;
