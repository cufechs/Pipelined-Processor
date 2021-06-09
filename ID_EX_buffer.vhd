library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.all;

entity ID_EX_buffer is 
	port (	  PC_in	    :	in std_logic_vector(31 downto 0);
		  Opcode_in :	in std_logic_vector(5 downto 0);
		  data1_in, data2_in  : 	in std_logic_vector(31 downto 0);
	 	  RdstData_in : 	in std_logic_vector(31 downto 0);
		  RdstAddr_in, RsrcAddr_in : 	in std_logic_vector(3 downto 0);

		  PCopr_in : in std_logic_vector(1 downto 0);
		  WB_in : in std_logic_vector(2 downto 0);
		  M_in : in std_logic_vector(7 downto 0);
		  EX_in : in std_logic_vector(7 downto 0);

		  clk	    :   in std_logic;

		  PC_out    :	out std_logic_vector(31 downto 0);
		  Opcode_out:	out std_logic_vector(5 downto 0);
		  data1_out, data2_out  : 	out std_logic_vector(31 downto 0);
	 	  RdstData_out : 	out std_logic_vector(31 downto 0);
		  RdstAddr_out, RsrcAddr_out : 	out std_logic_vector(3 downto 0);

		  WB_out : out std_logic_vector(2 downto 0);
		  M_out : out std_logic_vector(6 downto 0);
		  memRead_out, retOp_out, callOp_out : out std_logic;
		  updFlags_out, aluOp_out, outPortEn_out, setcSig_out
			, clrcSig_out, brOp_out : out std_logic;
		  brType_out : out std_logic_vector(1 downto 0) );

end ID_EX_buffer;     

architecture ID_EX_buffer_a of ID_EX_buffer is

  
begin
  
	PROCESS(clk)
		BEGIN
		
		IF falling_edge(clk) THEN
			PC_out <= PC_in;
			Opcode_out <= Opcode_in;
			data1_out <= data1_in;
			data2_out <= data2_in;	
			RdstData_out <= RdstData_in;	
			RdstAddr_out <= RdstAddr_in;	
			RsrcAddr_out <= RsrcAddr_in;	
			WB_out <= WB_in;	

			callOp_out <= PCopr_in(1);	
			retOp_out <= PCopr_in(0);	

			M_out <= M_in(7 downto 1);
			memRead_out <= M_in(0);

			updFlags_out <= EX_in(0);	
			aluOp_out <= EX_in(1);	
			outPortEn_out <= EX_in(2);	
			setcSig_out <= EX_in(3);	
			clrcSig_out <= EX_in(4);	
			brType_out <= EX_in(6 downto 5);	
			brOp_out <= EX_in(7);	
	
		END IF;
  	END PROCESS;

end ID_EX_buffer_a;