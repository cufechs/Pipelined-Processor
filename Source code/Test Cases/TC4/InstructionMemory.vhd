LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
ENTITY InstructionM_E IS
PORT (
address : IN std_logic_vector(31 downto 0);
dataout : OUT std_logic_vector(31 downto 0)
);
END ENTITY InstructionM_E;

ARCHITECTURE InstructionM_A OF InstructionM_E IS 
TYPE ram_type IS ARRAY(0 TO 544) of std_logic_vector(15 DOWNTO 0);
SIGNAL RAM : ram_type:=(
--std_logic_vector(to_unsigned(0,16)), std_logic_vector(to_unsigned(1,16)), std_logic_vector(to_unsigned(2,16)), 
--std_logic_vector(to_unsigned(3,16)), std_logic_vector(to_unsigned(4,16)), std_logic_vector(to_unsigned(5,16))

"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0101010111110001",
"0101010111110010",
"0101010111110011",
"0101010111110100",
"0010001011110100",
"0011110011110001",
"0001001011110001",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0001100100010101",
"0011100111110010",
"0000000111111111",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000", --
"0011100111110001",
"0011101111110011",
"0000000000000000", --
"0001000111110101",
"0101010111110110",
"0000000000000000", --
"0000000000000000", --
"0011101011110110",
"0001001011110001",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000001011111111",
"0001100100000000",
"0001010001101111",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000111111111",
"0010001111110110",
"0011010101100110",
"0001001011110110",
"0000000011111111",
"0000000011111111",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0001111100110110",
"0001111100010010",
"0011011011111111",
"0000000111111111",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000000000000",
"0000000011111111",
"0000000011111111",

------------------------------


"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000"	-- NOP

);
BEGIN
	dataout <= RAM(to_integer(unsigned(address(18 downto 0))))& RAM(to_integer(unsigned(address(18 downto 0)))+1);
			
END InstructionM_A;