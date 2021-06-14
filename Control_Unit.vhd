library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_Unit is 
	port (	  OpCode :	in std_logic_vector(5 downto 0);
		  EX	 :	out std_logic_vector(7 downto 0);
		  M 	 : 	out std_logic_vector(6 downto 0);
	 	  WB 	 : 	out std_logic_vector(3 downto 0);
		  PC_opr : 	out std_logic_vector(1 downto 0)
	);
end Control_Unit;


ARCHITECTURE Control_Unit_a OF Control_Unit IS

BEGIN

	With OpCode(5 downto 0) select
	EX <= 	"00000100" WHEN "010100",
		"00000000" WHEN "100010",
		"00000000" WHEN "100011",

		"10000000" WHEN "111001",
		"10100000" WHEN "111010",
		"11000000" WHEN "111011",
		"11100000" WHEN "111100",

		"00000000" WHEN "000000",	
		"00001000" WHEN "000001",
		"00010000" WHEN "000010",

		"00000000" WHEN "110101",
		"00000000" WHEN "110110",
		"00000000" WHEN "000000",
		
		"00000010" WHEN "010101",
		"00000010" WHEN "011110",
		"00000010" WHEN "100100",
		"00000010" WHEN "101101",
		"00000010" WHEN "101110",

		"00000011" WHEN Others;


	With OpCode(5 downto 0) select
	M <= 	"1101010" WHEN "100010",
		"0010100" WHEN "100011",
		"0000001" WHEN "100100",
		"0010001" WHEN "101101",
		"0101000" WHEN "101110",
		
		"1001010" WHEN "110101",
		"1010100" WHEN "110110",

		"0000000" WHEN Others;


	With OpCode(5 downto 0) select
	WB <= 	"0001" WHEN "100011",
		"0001" WHEN "101101",
		
		"1111" WHEN "010001",
		"1111" WHEN "010010",
		"1111" WHEN "010011",	
		"1111" WHEN "011110",
		"1111" WHEN "011111",
		"1111" WHEN "011000",
		"1111" WHEN "011001",
		"1111" WHEN "011010",
		"1111" WHEN "010110",
		"1111" WHEN "010111",
		"1111" WHEN "100111",


		"0000" WHEN Others;
		
	
	With OpCode(5 downto 0) select
	PC_opr <= 	"10" WHEN "110101",
			"01" WHEN "110110",
			"00" WHEN Others;
	


END Control_Unit_a;