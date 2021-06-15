Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;
Entity Stage1_E IS
  port(
    clk,rst,Reset,Callop,BranchTaken,RetOP,Fstall:IN std_logic;
    Rdst,PCbranch,PopedPC,restPC : IN std_logic_vector(31 downto 0);
    inst_type_o : OUT std_logic;
    InstructionBits, PC :OUT std_logic_vector(31 downto 0)
  );
End entity;

Architecture Stage1_A of Stage1_E is
  
component Mux2x1_E is
Generic(n:integer:=16);
  port(
  IN1:IN std_logic_vector(n-1 downto 0);
  IN2:IN std_logic_vector(n-1 downto 0);
  SEL:IN std_logic;
  OUT1:OUT std_logic_vector(n-1 downto 0)
  );
end component;


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

component InstructionM_E is
PORT (
address : IN std_logic_vector(31 downto 0);
dataout : OUT std_logic_vector(31 downto 0)
);
end component;

component PC_E is 
  Generic(n:integer:=16);
PORT( 
clk,rst: IN std_logic;
d : IN std_logic_vector(n-1 DOWNTO 0);
q : OUT std_logic_vector(n-1 DOWNTO 0)
);
end component;

component Adder_E is
  Port(
  A,B:IN std_logic_vector(31 downto 0);
  C:OUT std_logic_vector(31 downto 0)
);
end component;
  
component inst_Type is
  port (	
  OpCode :	in std_logic_vector(5 downto 0);
  inst_Type_out : 	out std_logic
);
end component;
  
signal PCout,Mux1Out,Mux2Out,Mux3Out,Mux4Out,Mux5Out,InsMemOut,AdderOut,word,byte,zero:std_logic_vector(31 downto 0);
signal inst_Type_out,fstalltemp:std_logic;
signal mux5sel:std_logic_vector(1 downto 0);
begin
I0:PC_E generic map(32) port map(clk,rst,Mux4Out,PCout);
I1:InstructionM_E port map(PCout,InsMemOut);
I2:inst_Type port map(InsMemOut(29 downto 24),inst_Type_out);
word<=std_logic_vector(to_unsigned(2,32));
byte<=std_logic_vector(to_unsigned(1,32));
zero<= (OTHERS => '0');
--fstalltemp <= Fstall;
mux5sel<= (Fstall & inst_Type_out) ;
I3:Mux4x1_E generic map(32) port map(word,byte,zero,zero,mux5sel,Mux5Out);
I4:Adder_E port map(PCout,Mux5Out,AdderOut);
I5:Mux2x1_E generic map(32) port map(AdderOut,Rdst,Callop,Mux1Out);
I6:Mux2x1_E generic map(32) port map(Mux1Out,PCbranch,BranchTaken,Mux2Out);  
I7:Mux2x1_E generic map(32) port map(Mux2Out,PopedPC,RetOP,Mux3Out);
I8:Mux2x1_E generic map(32) port map(Mux3Out,restPC,Reset,Mux4Out);

InstructionBits<= InsMemOut;    
inst_type_o <= inst_Type_out;
PC <= PCout;
end architecture;