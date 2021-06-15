Library ieee;
use ieee.std_logic_1164.all;

Entity Mux4x1_E IS
Generic(n:integer:=16);
  port(
  IN1:IN std_logic_vector(n-1 downto 0);
  IN2:IN std_logic_vector(n-1 downto 0);
  IN3:IN std_logic_vector(n-1 downto 0);
  IN4:IN std_logic_vector(n-1 downto 0);
  SEL:IN std_logic_vector(1 downto 0);
  OUT1:OUT std_logic_vector(n-1 downto 0)
  );
END ENTITY;

Architecture Mux4x1_A Of Mux4x1_E IS
  Begin
    OUT1 <= IN1 When SEL = "00"
      else  IN2 When SEL = "01"
      else  IN3 When SEL = "10"
      else  IN4 When SEL = "11"; 
 END Architecture;     
        
