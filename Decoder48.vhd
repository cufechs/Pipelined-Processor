library ieee;
use ieee.std_logic_1164.all;

ENTITY Decoder4x8_E IS
  PORT(
    W_Address:IN std_logic_vector(2 downto 0);
    W_Enable:IN std_logic;
    Selection:OUT std_logic_vector(7 downto 0)
  );
  END ENTITY;

Architecture Decoder4x8_A OF Decoder4x8_E IS
  Begin
    Selection(0) <= '1' When W_Enable = '1' AND W_Address(2) = '0' AND W_Address(1) = '0' AND W_Address(0) = '0' 
  Else '0';
    Selection(1) <= '1' When W_Enable = '1' AND W_Address(2) = '0' AND W_Address(1) = '0' AND W_Address(0) = '1'
  Else '0' ;
    Selection(2) <= '1' When W_Enable = '1' AND W_Address(2) = '0' AND W_Address(1) = '1' AND W_Address(0) = '0'
  Else '0' ;
    Selection(3) <= '1' When W_Enable = '1' AND W_Address(2) = '0' AND W_Address(1) = '1' AND W_Address(0) = '1'
  Else '0' ;
    Selection(4) <= '1' When W_Enable = '1' AND W_Address(2) = '1' AND W_Address(1) = '0' AND W_Address(0) = '0'
  Else '0' ;
    Selection(5) <= '1' When W_Enable = '1' AND W_Address(2) = '1' AND W_Address(1) = '0' AND W_Address(0) = '1'
  Else '0' ;
    Selection(6) <= '1' When W_Enable = '1' AND W_Address(2) = '1' AND W_Address(1) = '1' AND W_Address(0) = '0'
  Else '0' ;
    Selection(7) <= '1' When W_Enable = '1' AND W_Address(2) = '1' AND W_Address(1) = '1' AND W_Address(0) = '1'
  Else '0' ;    
  END architecture;


