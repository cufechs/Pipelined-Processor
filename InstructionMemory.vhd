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
TYPE ram_type IS ARRAY(0 TO 5) of std_logic_vector(15 DOWNTO 0);
SIGNAL RAM : ram_type:=(
--std_logic_vector(to_unsigned(0,16)), std_logic_vector(to_unsigned(1,16)), std_logic_vector(to_unsigned(2,16)), 
--std_logic_vector(to_unsigned(3,16)), std_logic_vector(to_unsigned(4,16)), std_logic_vector(to_unsigned(5,16))
"0001111100010010", "0000000000000000", "0000000100000000",
"0001111101000011", "0000000000000000", "0000000000000000"
);
BEGIN
dataout<=RAM(to_integer(unsigned(address)))& RAM(to_integer(unsigned(address))+1);
END Architecture;

