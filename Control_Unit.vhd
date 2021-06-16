library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_Unit is 
	port (	  OpCode :	in std_logic_vector(5 downto 0);
		  stall	 : 	in std_logic;
		  EX	 :	out std_logic_vector(7 downto 0);
		  M 	 : 	out std_logic_vector(5 downto 0);
	 	  WB 	 : 	out std_logic_vector(2 downto 0);
		  PC_opr : 	out std_logic_vector(1 downto 0)
	);
end Control_Unit;


ARCHITECTURE Control_Unit_a OF Control_Unit IS

SIGNAL EX_temp	 : std_logic_vector(7 downto 0);
SIGNAL M_temp 	 : std_logic_vector(5 downto 0);
SIGNAL WB_temp 	 : std_logic_vector(2 downto 0);
SIGNAL PC_opr_temp	 : std_logic_vector(1 downto 0);

BEGIN

	With OpCode(5 downto 0) select
	EX_temp <= 	"00000100" WHEN "010100",
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
		
		"00000010" WHEN "010101",
		"00000010" WHEN "011110",
		"00000010" WHEN "100100",
		"00000010" WHEN "101101",
		"00000010" WHEN "101110",

		"00000011" WHEN Others;


	With OpCode(5 downto 0) select
	M_temp <= 	"110101" WHEN "100010",
		"001010" WHEN "100011",
		"000000" WHEN "100100",
		"001000" WHEN "101101",
		"010100" WHEN "101110",
		
		"100101" WHEN "110101",
		"101010" WHEN "110110",

		"000000" WHEN Others;


	With OpCode(5 downto 0) select
	WB_temp <= 	"101" WHEN "100011",
		"101" WHEN "101101",
		"111" WHEN "100100",
		
		"111" WHEN "010101",
		"111" WHEN "010001",
		"111" WHEN "010010",
		"111" WHEN "010011",	
		"111" WHEN "011110",
		"111" WHEN "011111",
		"111" WHEN "011000",
		"111" WHEN "011001",
		"111" WHEN "011010",
		"111" WHEN "010110",
		"111" WHEN "010111",
		"111" WHEN "100111",


		"000" WHEN Others;
		
	
	With OpCode(5 downto 0) select
	PC_opr_temp <= 	"10" WHEN "110101",
			"01" WHEN "110110",
			"00" WHEN Others;
	

	EX <= EX_temp WHEN stall = '0'
		ELSE (OTHERS => '0') WHEN stall = '1';
	
	M <= M_temp WHEN stall = '0'
		ELSE (OTHERS => '0') WHEN stall = '1';

	wb <= WB_temp WHEN stall = '0'
		ELSE (OTHERS => '0') WHEN stall = '1';

	PC_opr <= PC_opr_temp WHEN stall = '0'
		ELSE (OTHERS => '0') WHEN stall = '1';


END Control_Unit_a;