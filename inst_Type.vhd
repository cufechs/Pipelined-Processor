library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity inst_Type is 
	port (	  OpCode :	in std_logic_vector(5 downto 0);
		  inst_Type_out : 	out std_logic
	);
end inst_Type;


ARCHITECTURE inst_Type_a OF inst_Type IS

SIGNAL inst_Type_temp	 : std_logic;

BEGIN

	With OpCode(5 downto 0) select
	inst_Type_temp <= '0' WHEN "010110",
		'0' WHEN "010111",
		'0' WHEN "100111",
		'0' WHEN "100100",
		'0' WHEN "101101",
		'0' WHEN "101110",

		'1' WHEN Others;

	

	inst_Type_out <= inst_Type_temp;


END inst_Type_a;