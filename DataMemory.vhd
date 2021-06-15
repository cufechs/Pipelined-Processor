LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
ENTITY DataMemory_E IS
PORT (
clk:IN std_logic;
MemSel: IN std_logic_vector(1 downto 0);
address : IN std_logic_vector(31 DOWNTO 0);
datain : IN std_logic_vector(31 DOWNTO 0);
dataout : OUT std_logic_vector(31 DOWNTO 0) );
END ENTITY;

ARCHITECTURE DataMemory_A OF DataMemory_E IS 
TYPE ram_type IS ARRAY(0 TO 5) of std_logic_vector(15 DOWNTO 0);
SIGNAL RAM : ram_type:=(
std_logic_vector(to_unsigned(0,16)), std_logic_vector(to_unsigned(1,16)), std_logic_vector(to_unsigned(2,16)), 
std_logic_vector(to_unsigned(3,16)), std_logic_vector(to_unsigned(4,16)), std_logic_vector(to_unsigned(5,16))
);
BEGIN 
PROCESS(clk) IS 
BEGIN
 IF rising_edge(clk) AND MemSel ="01" THEN 
RAM(to_integer(unsigned(address(18 downto 0)))) <= datain(15 downto 0);
RAM(to_integer(unsigned(address(18 downto 0)))+1) <= datain(31 downto 16);
END IF;
END Process; 
dataout <= (RAM(to_integer(unsigned(address(18 downto 0)))+1) & RAM(to_integer(unsigned(address(18 downto 0))))) ;
END architecture;

