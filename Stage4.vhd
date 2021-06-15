Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;
Entity Stage4_E IS
Port(
  instType,MemData,MemAddr,clk,rst:IN std_logic;
  MemSignal,SPsignal:IN std_logic_vector(1 downto 0);
  Rdst,ALUout,PC:IN std_logic_vector(31 downto 0);
  Stage4Out:OUT std_logic_vector (31 downto 0)
);
END ENTITY;

Architecture Stage4_A of Stage4_E IS
component Mux2x1_E is
Generic(n:integer:=16);
  port(
  IN1:IN std_logic_vector(n-1 downto 0);
  IN2:IN std_logic_vector(n-1 downto 0);
  SEL:IN std_logic;
  OUT1:OUT std_logic_vector(n-1 downto 0)
  );
end component;
component Adder_E is
  Port(
  A,B:IN std_logic_vector(31 downto 0);
  C:OUT std_logic_vector(31 downto 0)
);
end component;
Component AdderStage4_E IS
Port(
  clk:IN std_logic;
  Flag:IN std_logic_vector(1 downto 0);
  A:IN std_logic_vector(31 downto 0);
  C:OUT std_logic_vector(31 downto 0)
);
end component;
Component SP_E IS
PORT( 
clk,rst: IN std_logic;
d : IN std_logic_vector(31 DOWNTO 0);
q : OUT std_logic_vector(31 DOWNTO 0)
);
END Component;
Component DataMemory_E is
  PORT (
clk:IN std_logic;
MemSel: IN std_logic_vector(1 downto 0);
address : IN std_logic_vector(31 DOWNTO 0);
datain : IN std_logic_vector(31 DOWNTO 0);
dataout : OUT std_logic_vector(31 DOWNTO 0) );
end component;
Signal Mux1Out,Mux2Out,Mux3Out,Addr1Out,Addr2Out,SPOut,MemOut:std_logic_vector(31 downto 0);
BEGIN
  I0:AdderStage4_E port map(clk,SPsignal,SPOut,Addr2Out);
  I1:SP_E port map(clk,rst,Addr2Out,SPOut);
  I2:Mux2x1_E generic map(32) port map(ALUout,SPOut,MemAddr,Mux1Out);
  I3:Mux2x1_E generic map(32) port map(std_logic_vector(to_unsigned(2,32)),std_logic_vector(to_unsigned(1,32)),instType,Mux2Out);
  I4:Adder_E port map(Mux2Out,PC,Addr1Out);
  I5:Mux2x1_E generic map(32) port map(Addr1Out,Rdst,MemData,Mux3Out);
  I6:DataMemory_E port map(clk,MemSignal,Mux1Out,Mux3Out,MemOut); 
  Stage4Out<= MemOut; 
    
END Architecture;