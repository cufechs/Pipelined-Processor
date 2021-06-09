library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.all;

entity EX_M_buffer is 
	port (	  PC_in	    :	in std_logic_vector(31 downto 0);
		  ALUoutput_in :	in std_logic_vector(31 downto 0);
	 	  RdstData_in : 	in std_logic_vector(31 downto 0);
		  RdstAddr_in : 	in std_logic_vector(3 downto 0);

		  brTaken_in, retOp_in : in std_logic;	--PC opr

		  WB_in : in std_logic_vector(2 downto 0);
		  M_in : in std_logic_vector(6 downto 0);

		  clk	    :   in std_logic;

		  PC_out    :	out std_logic_vector(31 downto 0);
		  ALUoutput_out:	out std_logic_vector(31 downto 0);
	 	  RdstData_out : 	out std_logic_vector(31 downto 0);
		  RdstAddr_out : 	out std_logic_vector(3 downto 0);

		  brTaken_out, retOp_out : out std_logic; --PC opr

		  WB_out : out std_logic_vector(1 downto 0);
		  ex_m_wbEn_out : out std_logic;

		  memData_out, memAddr_out, instType_out : out std_logic;
		  spSig_out,memSig_out : out std_logic_vector(1 downto 0) );

end EX_M_buffer;     

architecture EX_M_buffer_a of EX_M_buffer is

  
begin
  
	PROCESS(clk)
		BEGIN
		
		IF falling_edge(clk) THEN
			PC_out <= PC_in;
			ALUoutput_out <= ALUoutput_in;
			RdstData_out <= RdstData_in;	
			RdstAddr_out <= RdstAddr_in;	

			brTaken_out <= brTaken_in;	
			retOp_out <= retOp_in;	

			WB_out <= WB_in(1 downto 0);
			ex_m_wbEn_out <= WB_in(2);


			spSig_out <= M_in(1 downto 0);	
			memSig_out <= M_in(3 downto 2);	
			memData_out <= M_in(4);	
			memAddr_out <= M_in(5);	
			instType_out <= M_in(6);	

		END IF;
  	END PROCESS;

end EX_M_buffer_a;
