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
Component Mux2x1_E IS
  Generic(n:integer:=16);
  port(
  IN1:IN std_logic_vector(n-1 downto 0);
  IN2:IN std_logic_vector(n-1 downto 0);
  SEL:IN std_logic;
  OUT1:OUT std_logic_vector(n-1 downto 0)
  );
END component;
begin
  I0:Mux2x1_E Generic Map(32) Port map(ALU,Memory,WBSignal,WBdata);
    
end Architecture;