library ieee;
use ieee.std_logic_1164.all;

ENTITY Registerfile_E IS
PORT(
  Writedata:IN std_logic_vector(31 downto 0);
  W_Address:IN std_logic_vector(3 downto 0);
  RsrcData,RdstData:OUT std_logic_vector(31 downto 0);
  R_Address_src,R_Address_dst:IN std_logic_vector(3 downto 0);
  W_Enable,clk,rst:IN std_logic
  
  );
END ENTITY;
Architecture RegisterFile_A OF RegisterFile_E IS
  Component Decoder4x8_E IS
    PORT(
    W_Address:IN std_logic_vector(2 downto 0);
    W_Enable:IN std_logic;
    Selection:OUT std_logic_vector(7 downto 0)
  );
  END Component;
  Component nD_FP_E IS
  GENERIC ( n : integer := 16);
  PORT( 
  clk,rst,Enable: IN std_logic;
  d : IN std_logic_vector(n-1 DOWNTO 0);
  q : OUT std_logic_vector(n-1 DOWNTO 0)
  );
  END Component;
  Component TriStepBuffer IS
    GENERIC ( n : integer := 16);
    Port(X:IN std_logic_vector(n-1 downto 0);
         Y:OUT std_logic_vector(n-1 downto 0);
         Enable:IN std_logic);
    END Component;
    Signal DecoderWriteOut,DecoderReadOut1,DecoderReadOut2:std_logic_vector(7 downto 0);
    Signal NotRead1,NotRead2:std_logic;
    Signal Register0Out,Register1Out,Register2Out,Register3Out,Register4Out,Register5Out,Register6Out,Register7Out:std_logic_vector(31 downto 0);
  Begin
    I0:Decoder4x8_E port map(W_Address(2 downto 0),W_Enable,DecoderWriteOut);
    I1:nD_FP_E generic map (32) port map(clk,rst,DecoderWriteOut(0),Writedata,Register0Out);
    I2:nD_FP_E generic map (32) port map(clk,rst,DecoderWriteOut(1),Writedata,Register1Out);
    I3:nD_FP_E generic map (32) port map(clk,rst,DecoderWriteOut(2),Writedata,Register2Out); 
    I4:nD_FP_E generic map (32) port map(clk,rst,DecoderWriteOut(3),Writedata,Register3Out); 
    I5:nD_FP_E generic map (32) port map(clk,rst,DecoderWriteOut(4),Writedata,Register4Out);
    I6:nD_FP_E generic map (32) port map(clk,rst,DecoderWriteOut(5),Writedata,Register5Out);  
    I7:nD_FP_E generic map (32) port map(clk,rst,DecoderWriteOut(6),Writedata,Register6Out);  
    I8:nD_FP_E generic map (32) port map(clk,rst,DecoderWriteOut(7),Writedata,Register7Out);
      NotRead1 <= Not R_Address_src(3);
      NotRead2 <= Not R_Address_dst(3);
    I9:Decoder4x8_E port map(R_Address_src(2 downto 0),NotRead1,DecoderReadOut1);  
    I10:Decoder4x8_E port map(R_Address_dst(2 downto 0),NotRead2,DecoderReadOut2);
    I11:TriStepBuffer generic map(32) port map(Register0Out,RsrcData,DecoderReadOut1(0));
    I12:TriStepBuffer generic map(32) port map(Register1Out,RsrcData,DecoderReadOut1(1)); 
    I13:TriStepBuffer generic map(32) port map(Register2Out,RsrcData,DecoderReadOut1(2)); 
    I14:TriStepBuffer generic map(32) port map(Register3Out,RsrcData,DecoderReadOut1(3));
    I15:TriStepBuffer generic map(32) port map(Register4Out,RsrcData,DecoderReadOut1(4));
    I16:TriStepBuffer generic map(32) port map(Register5Out,RsrcData,DecoderReadOut1(5));
    I17:TriStepBuffer generic map(32) port map(Register6Out,RsrcData,DecoderReadOut1(6));
    I18:TriStepBuffer generic map(32) port map(Register7Out,RsrcData,DecoderReadOut1(7));
      
      
    I19:TriStepBuffer generic map(32) port map(Register0Out,RdstData,DecoderReadOut2(0));
    I20:TriStepBuffer generic map(32) port map(Register1Out,RdstData,DecoderReadOut2(1)); 
    I21:TriStepBuffer generic map(32) port map(Register2Out,RdstData,DecoderReadOut2(2)); 
    I22:TriStepBuffer generic map(32) port map(Register3Out,RdstData,DecoderReadOut2(3));
    I23:TriStepBuffer generic map(32) port map(Register4Out,RdstData,DecoderReadOut2(4));
    I24:TriStepBuffer generic map(32) port map(Register5Out,RdstData,DecoderReadOut2(5));
    I25:TriStepBuffer generic map(32) port map(Register6Out,RdstData,DecoderReadOut2(6));
    I26:TriStepBuffer generic map(32) port map(Register7Out,RdstData,DecoderReadOut2(7));
      
END Architecture;


