Library ieee;
use ieee.std_logic_1164.all;

Entity Mux2x1_E IS
Generic(n:integer:=16);
  port(
  IN1:IN std_logic_vector(n-1 downto 0);
  IN2:IN std_logic_vector(n-1 downto 0);
  SEL:IN std_logic;
  OUT1:OUT std_logic_vector(n-1 downto 0)
  );
END ENTITY;

Architecture Mux2x1_A Of Mux2x1_E IS
  Begin
    OUT1 <= IN1 When SEL = '0'
      else  IN2 When SEL = '1';
 END Architecture;     
        
             
  