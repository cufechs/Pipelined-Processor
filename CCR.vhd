library ieee;
use ieee.std_logic_1164.all;

ENTITY CCR IS
	PORT(
		clk,rst,brTaken,enable_update,enable_update_C: IN std_logic;
		brType : IN std_logic_vector(1 downto 0);
		C_in,Z_in,N_in : IN std_logic;
		C_out,Z_out,N_out : OUT std_logic
	);
END ENTITY;

ARCHITECTURE CCR_a OF CCR IS

signal C,Z,N : std_logic;

BEGIN
	PROCESS (clk,rst,brTaken)
	BEGIN
		IF rst = '1' THEN
			C <= '0';
			Z <= '0';
			N <= '0';
		ELSIF rising_edge(clk) THEN
			IF enable_update = '1' THEN
				C <= C_in;
				Z <= Z_in;
				N <= N_in;
				
				--C <= '0' WHEN C = 'X';
				--N <= '0' WHEN N = 'X';
			ELSIF enable_update_C = '1' THEN
				C <= C_in;
			END IF;
		ELSIF brTaken = '1' AND falling_edge(clk) THEN
			IF brType = "10" THEN
				C <= '0';
			ELSIF brType = "01" THEN
				N <= '0';
			ELSIF brType = "00" THEN
				Z <= '0';
			END IF;
		END IF;
	END PROCESS;

	C_out <= C;
	Z_out <= Z;
	N_out <= N;



END CCR_a;