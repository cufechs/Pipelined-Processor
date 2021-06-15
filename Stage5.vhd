LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

Entity Stage5_E IS
Port(
  ALU,Memory:IN std_logic_vector(31 downto 0);
  WBSignal:IN std_logic;
  WBdata:OUT std_logic_vector(31 downto 0)
);
END ENTITY;

Architecture Stage5_A OF Stage5_E IS
begin

  WBdata <= Memory WHEN WBSignal = '0'
		ELSE ALU;
    
end Architecture;