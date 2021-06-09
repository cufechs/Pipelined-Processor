LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY ALU IS
GENERIC (n : integer := 32);
	PORT(
		aluFunc: IN std_logic_vector(5 downto 0);
		data1, data2 : IN std_logic_vector(n-1 downto 0);

		z_flag_in, c_flag_in, n_flag_in : IN std_logic;
		z_flag, c_flag, n_flag : OUT std_logic;
		result: OUT std_logic_vector(n-1 downto 0)
	);
END ENTITY;

ARCHITECTURE ALU_a OF ALU IS

--SIGNAL result : std_logic_vector(31 downto 0);
SIGNAL temp_data2 : std_logic_vector(n-1 DOWNTO 0);
SIGNAL temp_Cout_adder,temp_Cout_shL,temp_Cout_shR,temp_c : std_logic; 
SIGNAL temp_f_adder, temp_result : std_logic_vector(n-1 DOWNTO 0);
SIGNAL temp_f_shL, temp_f_shR : std_logic_vector(n-1 DOWNTO 0);

BEGIN
	a0: entity work.my_nadder Port Map (data1,temp_data2,'0',temp_f_adder,temp_Cout_adder);

	PROCESS(data1,data2)
	BEGIN
		IF(to_integer(unsigned(data2)) < 32 AND to_integer(unsigned(data2)) > 0)
		THEN
			temp_f_shL(n-1 downto to_integer(unsigned(data2))) <= data1(n - 1 - to_integer(unsigned(data2)) downto 0);
			temp_f_shL(to_integer(unsigned(data2))-1 downto 0) <= (OTHERS => '0');

			temp_f_shR(n - 1 - to_integer(unsigned(data2)) downto 0 ) <= data1(n - 1 downto to_integer(unsigned(data2)));
			temp_f_shR(n-1 downto n - to_integer(unsigned(data2))) <= (OTHERS => '0');
			
			IF(aluFunc = "010110") --SHL
			THEN
				temp_c <= data1(n-to_integer(unsigned(data2)));
			ELSIF (aluFunc = "010111") --SHR
			THEN
				temp_c <= data1(to_integer(unsigned(data2)));
			END IF;
		ELSE
			temp_f_shL <= temp_f_shL;
			temp_f_shR <= temp_f_shR;
		END IF;

	END PROCESS;

	
	
	temp_data2 <= (0 => '1', OTHERS => '0') WHEN aluFunc = "010010" -- INC
		ELSE (OTHERS => '1') WHEN aluFunc = "010011" --DEC
		ELSE data2 WHEN aluFunc = "011111" OR aluFunc = "100111" --ADD, IADD
			OR aluFunc = "101101" OR aluFunc = "101110" -- LDD, STD
		ELSE (std_logic_vector(to_signed(to_integer(signed(NOT data2)) + 1,32))) WHEN aluFunc = "011000" -- SUB
	;
	
	c_flag <= temp_Cout_adder WHEN aluFunc = "010010" OR aluFunc = "010011" -- INC, DEC
			OR aluFunc = "011111" OR aluFunc = "011000" -- ADD, SUB
			OR aluFunc = "100111" -- IADD
		ELSE temp_c WHEN aluFunc = "010110" OR aluFunc = "010111" -- SHL, SHR
		--ELSE data1(n-to_integer(unsigned(data2))) WHEN aluFunc = "010110" --SHL
		--ELSE data1(to_integer(unsigned(data2))) WHEN aluFunc = "010111" --SHR
		ELSE c_flag_in;

	temp_result <= NOT data2 WHEN aluFunc = "010001" -- NOT
		ELSE data2 WHEN aluFunc = "010101" OR aluFunc = "100100" OR aluFunc = "010100" -- IN, LDM, OUT
		ELSE data1 WHEN aluFunc = "011110" -- MOV 
		ELSE data1 AND data2 WHEN aluFunc = "011001" -- AND 
		ELSE data1 OR data2 WHEN aluFunc = "011010" -- OR 
		ELSE temp_f_shL(n-1 downto 0) WHEN aluFunc = "010110" -- SHL 
		ELSE temp_f_shR(n-1 downto 0) WHEN aluFunc = "010111" -- SHR 
		ELSE temp_f_adder;

	result <= temp_result;

	z_flag <= '1' WHEN temp_result = "00000000000000000000000000000000"
				AND (aluFunc = "010001" OR aluFunc = "010010" --NOT,INC 
				OR aluFunc = "010011" OR aluFunc = "011111" -- DEC, ADD
				OR aluFunc = "100111" OR aluFunc = "011000" -- IADD, SUB 
				OR aluFunc = "011001" OR aluFunc = "011010") -- AND, OR
		
			ELSE '0' WHEN aluFunc = "010001" OR aluFunc = "010010" --NOT,INC 
				OR aluFunc = "010011" OR aluFunc = "011111" -- DEC, ADD
				OR aluFunc = "100111" OR aluFunc = "011000" -- IADD, SUB 
				OR aluFunc = "011001" OR aluFunc = "011010" -- AND, OR
			
			ELSE z_flag_in;

	n_flag <= temp_result(n-1) WHEN aluFunc = "010001" OR aluFunc = "010010" --NOT,INC 
				OR aluFunc = "010011" OR aluFunc = "011111" -- DEC, ADD
				OR aluFunc = "100111" OR aluFunc = "011000" -- IADD, SUB 
				OR aluFunc = "011001" OR aluFunc = "011010" -- AND, OR
			
			ELSE n_flag_in;


END ALU_a;
