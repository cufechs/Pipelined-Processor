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
TYPE ram_type IS ARRAY(0 TO 68) of std_logic_vector(15 DOWNTO 0);
SIGNAL RAM : ram_type:=(
--std_logic_vector(to_unsigned(0,16)), std_logic_vector(to_unsigned(1,16)), std_logic_vector(to_unsigned(2,16)), 
--std_logic_vector(to_unsigned(3,16)), std_logic_vector(to_unsigned(4,16)), std_logic_vector(to_unsigned(5,16))

"0000000000001010", -- 10	
"0000000000000000",	-- NOP
"0000000001100100",	-- 100
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP
"0000000000000000",	-- NOP

"0000000111111111", -- SETC (.ORG 10)
"0000000000000000",	-- NOP
"0000001011111111", -- CLRC
"0001000111110001", -- NOT R1

"0001001000010001", -- INC R1

"0000000000000000",	-- NOP
"0000000000000000",	-- NOP

"0101010111110001", -- IN R1
"0101010111110010", -- IN R2

--"0000000000000000",	-- NOP
--"0000000000000000",	-- NOP
"0000000000000000",	-- NOP

"0001000111110010", -- NOT R2
"0001001000010001", -- INC R1

"0001001100100010", -- DEC R2

"0001010000010001", -- OUT R1
"0001010000100010", -- OUT R2

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