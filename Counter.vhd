LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
ENTITY Counter IS
GENERIC (n: Integer := 2; m: Integer := 3);
PORT (clk, Start : IN std_logic;
counterout : OUT std_logic_vector(n-1 DOWNTO 0));
END ENTITY Counter;

ARCHITECTURE Lab4 OF Counter IS 

SIGNAL CounterInput : std_logic_vector(n-1 downto 0) := (OTHERS => '0');

BEGIN

PROCESS(clk) IS 
BEGIN

IF RISING_EDGE(clk) THEN
	IF (Start = '1') and (to_integer(unsigned(CounterInput)) < m) THEN
		CounterInput <= std_logic_vector(to_unsigned(to_integer(unsigned(CounterInput)) + 1, n));
	ELSIF Start = '0' THEN
		CounterInput <= (OTHERS => '0');
	END IF;
END IF;

END PROCESS;

counterout <= CounterInput;

END Lab4;