LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY ControlUnit_tb IS
END ControlUnit_tb;

ARCHITECTURE behavior OF ControlUnit_tb IS

   --declare inputs and initialize them
   
	signal OpCode : std_logic_vector(5 downto 0);
	signal EX	 : std_logic_vector(7 downto 0);
	signal M 	 : std_logic_vector(6 downto 0);
	signal WB 	 : std_logic_vector(3 downto 0);
	signal PC_opr : std_logic_vector(1 downto 0);

constant clk_period : time := 100 ps;
   
BEGIN

	cu: entity work.Control_Unit port map (
		OpCode => OpCode,
		EX => EX,
		M => M,
		WB => WB,
		PC_opr => PC_opr
	);


  stim_proc: process
   begin      

	OpCode <= "010001";
	wait for 1 ps;
	ASSERT(EX = "00000011" AND M = "0000000" AND WB = "1111" AND PC_opr = "00") REPORT "NOT Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "010010";
	wait for 1 ps;
	ASSERT(EX = "00000011" AND M = "0000000" AND WB = "1111" AND PC_opr = "00") REPORT "INC Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "010011";
	wait for 1 ps;
	ASSERT(EX = "00000011" AND M = "0000000" AND WB = "1111" AND PC_opr = "00") REPORT "DEC Rdst ERROR"
	SEVERITY ERROR;

	OpCode <= "010100";
	wait for 1 ps;
	ASSERT(EX = "00000100" AND M = "0000000" AND WB = "0000" AND PC_opr = "00") REPORT "OUT Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "010011";
	wait for 1 ps;
	ASSERT(EX = "00000010" AND M = "0000000" AND WB = "0000" AND PC_opr = "00") REPORT "IN Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "011110";
	wait for 1 ps;
	ASSERT(EX = "00000010" AND M = "0000000" AND WB = "1111" AND PC_opr = "00") REPORT "MOV Rsrc, Rdst ERROR"
	SEVERITY ERROR;
        
	OpCode <= "011111";
	wait for 1 ps;
	ASSERT(EX = "00000011" AND M = "0000000" AND WB = "1111" AND PC_opr = "00") REPORT "ADD Rsrc, Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "011000";
	wait for 1 ps;
	ASSERT(EX = "00000011" AND M = "0000000" AND WB = "1111" AND PC_opr = "00") REPORT "SUB Rsrc, Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "011001";
	wait for 1 ps;
	ASSERT(EX = "00000011" AND M = "0000000" AND WB = "1111" AND PC_opr = "00") REPORT "AND Rsrc, Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "011010";
	wait for 1 ps;
	ASSERT(EX = "00000011" AND M = "0000000" AND WB = "1111" AND PC_opr = "00") REPORT "OR Rsrc, Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "010110";
	wait for 1 ps;
	ASSERT(EX = "00000011" AND M = "0000000" AND WB = "1111" AND PC_opr = "00") REPORT "SHL Rsrc, Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "010111";
	wait for 1 ps;
	ASSERT(EX = "00000011" AND M = "0000000" AND WB = "1111" AND PC_opr = "00") REPORT "SHR Rsrc, Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "100111";
	wait for 1 ps;
	ASSERT(EX = "00000011" AND M = "0000000" AND WB = "1111" AND PC_opr = "00") REPORT "IADD Rsrc, imm ERROR"
	SEVERITY ERROR;
	
	OpCode <= "100010";
	wait for 1 ps;
	ASSERT(EX = "00000000" AND M = "1101010" AND WB = "0000" AND PC_opr = "00") REPORT "PUSH Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "100011";
	wait for 1 ps;
	ASSERT(EX = "00000000" AND M = "1010100" AND WB = "0001" AND PC_opr = "00") REPORT "POP Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "100100";
	wait for 1 ps;
	ASSERT(EX = "00000010" AND M = "0000001" AND WB = "0000" AND PC_opr = "00") REPORT "LDM Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "101101";
	wait for 1 ps;
	ASSERT(EX = "00000010" AND M = "0010001" AND WB = "0001" AND PC_opr = "00") REPORT "LDD Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "101110";
	wait for 1 ps;
	ASSERT(EX = "00000010" AND M = "0101000" AND WB = "0000" AND PC_opr = "00") REPORT "STD Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "111001";
	wait for 1 ps;
	ASSERT(EX = "10000000" AND M = "0000000" AND WB = "0000" AND PC_opr = "00") REPORT "JZ Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "111010";
	wait for 1 ps;
	ASSERT(EX = "10100000" AND M = "0000000" AND WB = "0000" AND PC_opr = "00") REPORT "JN Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "111011";
	wait for 1 ps;
	ASSERT(EX = "11000000" AND M = "0000000" AND WB = "0000" AND PC_opr = "00") REPORT "JC Rdst ERROR"
	SEVERITY ERROR;
		
	OpCode <= "111100";
	wait for 1 ps;
	ASSERT(EX = "11100000" AND M = "0000000" AND WB = "0000" AND PC_opr = "00") REPORT "JMP Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "110101";
	wait for 1 ps;
	ASSERT(EX = "00000000" AND M = "1001010" AND WB = "0000" AND PC_opr = "10") REPORT "CALL Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "110110";
	wait for 1 ps;
	ASSERT(EX = "00000000" AND M = "1010100" AND WB = "0000" AND PC_opr = "01") REPORT "RET ERROR"
	SEVERITY ERROR;
	
	OpCode <= "000000";
	wait for 1 ps;
	ASSERT(EX = "00000000" AND M = "0000000" AND WB = "0000" AND PC_opr = "00") REPORT "NOP ERROR"
	SEVERITY ERROR;
	
	OpCode <= "000001";
	wait for 1 ps;
	ASSERT(EX = "00001000" AND M = "0000000" AND WB = "0000" AND PC_opr = "00") REPORT "SETC ERROR"
	SEVERITY ERROR;
	
	OpCode <= "000010";
	wait for 1 ps;
	ASSERT(EX = "00010000" AND M = "0000000" AND WB = "0000" AND PC_opr = "00") REPORT "SETC ERROR"
	SEVERITY ERROR;
		
	wait;
  end process;

END behavior;
