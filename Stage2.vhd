Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

Entity Stage2_E IS
  Port(
  InstructionMem,INPORT,DataWrite:IN std_logic_vector(31 downto 0);
  WB_Enable,clk,rst:IN std_logic;
  WBAddress:IN std_logic_vector(3 downto 0);
  RsrcData,RdstData,SelectionOutput:OUT std_logic_vector(31 downto 0)
  );
  End Entity;

Architecture Stage2_A OF Stage2_E IS

component Mux4x1_E is
    Generic(n:integer:=16);
  port(
  IN1:IN std_logic_vector(n-1 downto 0);
  IN2:IN std_logic_vector(n-1 downto 0);
  IN3:IN std_logic_vector(n-1 downto 0);
  IN4:IN std_logic_vector(n-1 downto 0);
  SEL:IN std_logic_vector(1 downto 0);
  OUT1:OUT std_logic_vector(n-1 downto 0)
  );
  end component;
  
  
  component Registerfile_E IS
    PORT(
  Writedata:IN std_logic_vector(31 downto 0);
  W_Address:IN std_logic_vector(3 downto 0);
  RsrcData,RdstData:OUT std_logic_vector(31 downto 0);
  R_Address_src,R_Address_dst:IN std_logic_vector(3 downto 0);
  W_Enable,clk,rst:IN std_logic
   );
end Component;
  Signal RsrcOut,RdstOut,ZeroExtend,SignExtend:std_logic_vector(31 downto 0);
  Signal Mux4x1Out:std_logic_vector(31 downto 0);
    
  Begin
    ZeroExtend(4 downto 0)<=  InstructionMem(10 downto 6);
    ZeroExtend(31 downto 5)<= (others=>'0');
    SignExtend(15 downto 0)<= InstructionMem(15 downto 0);
    SignExtend(31 downto 16)<=  (others=>'0') when InstructionMem(15) = '0' else (others=>'1');
    I0:Registerfile_E port map(DataWrite,WBAddress,RsrcOut,RdstOut,InstructionMem(23 downto 20),InstructionMem(19 downto 16),WB_Enable,clk,rst);
    I1:Mux4x1_E generic map(32) port map(RdstOut,INPORT,ZeroExtend,SignExtend,InstructionMem(31 downto 30),Mux4x1Out);
    RsrcData<= RsrcOut;
    RdstData<= RdstOut;
    SelectionOutput<= Mux4x1Out;
  End Architecture;