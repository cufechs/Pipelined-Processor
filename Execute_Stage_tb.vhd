LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE IEEE.numeric_std.all;



ENTITY Execute_Stage_tb IS
END Execute_Stage_tb;

ARCHITECTURE behavior OF Execute_Stage_tb IS

   --declare inputs and initialize them
   
	signal OpCode : std_logic_vector(5 downto 0);
	signal stall	 : std_logic;
	signal EX	 : std_logic_vector(7 downto 0);
	signal M 	 : std_logic_vector(5 downto 0);
	signal WB 	 : std_logic_vector(2 downto 0);
	signal PC_opr, forward1, forward2 : std_logic_vector(1 downto 0);

	signal clk, rst, br_taken : std_logic;

	signal data1, data2, Rdst_ex, Rdst_m, PC_in, alu_out, PC_out : std_logic_vector(31 downto 0); 

	constant clk_period : time := 100 ps;

BEGIN

	cu: entity work.Control_Unit port map (
		OpCode => OpCode,
		EX => EX,
		stall => stall,
		M => M,
		WB => WB,
		PC_opr => PC_opr
	);
	
	exec: entity work.Execute port map(
		clk => clk, rst => rst,

		Opcode => OpCode,

		Br_op => EX(7), SETC_sig => EX(3), CLRC_sig => EX(4),
		Br_type  => EX(6 downto 5),
		
		forward1 => forward1, forward2 => forward2,

		alu_op => EX(1), upd_flag => EX(0), outPort_en => EX(2),
		data1 => data1, data2 => data2, PC_in => PC_in,
		Rdst_ex => Rdst_ex, Rdst_m => Rdst_m,

		Br_taken => br_taken,

		alu_out => alu_out, PC_out => PC_out
	);

clk_process :process
   begin
        clk <= '0';
        wait for clk_period/2;  --for 50 ps signal is '0'.
        clk <= '1';
        wait for clk_period/2;  --for next 50 ps signal is '1'.
   end process;


  stim_proc: process
   begin      
	
	rst <= '1';
	forward1 <= "00";
	forward2 <= "00";
	wait for clk_period;
	rst <= '0';

	OpCode <= "010001";
	data1 <= std_logic_vector(to_unsigned(30,32));
	data2 <= std_logic_vector(to_unsigned(50,32));
	wait for clk_period;
	ASSERT(alu_out = NOT data2) REPORT "NOT Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "010010";
	data1 <= std_logic_vector(to_unsigned(30,32));
	data2 <= std_logic_vector(to_unsigned(50,32));
	wait for clk_period;
	ASSERT(alu_out = std_logic_vector(to_unsigned(31,32))) REPORT "INC Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "010011";
	data1 <= std_logic_vector(to_unsigned(30,32));
	data2 <= std_logic_vector(to_unsigned(50,32));
	wait for clk_period;
	ASSERT(alu_out = std_logic_vector(to_unsigned(29,32))) REPORT "DEC Rdst ERROR"
	SEVERITY ERROR;

	OpCode <= "010100";
	data1 <= std_logic_vector(to_unsigned(30,32));
	data2 <= std_logic_vector(to_unsigned(50,32));
	wait for clk_period;
	ASSERT(alu_out = data2) REPORT "OUT Rdst ERROR"
	SEVERITY ERROR;

	OpCode <= "010101";
	data1 <= std_logic_vector(to_unsigned(30,32));
	data2 <= std_logic_vector(to_unsigned(50,32));
	wait for clk_period;
	ASSERT(alu_out = data2) REPORT "IN Rdst ERROR"
	SEVERITY ERROR;

	OpCode <= "011110";
	data1 <= std_logic_vector(to_unsigned(30,32));
	data2 <= std_logic_vector(to_unsigned(50,32));
	wait for clk_period;
	ASSERT(alu_out = data1) REPORT "MOV Rsrc, Rdst ERROR"
	SEVERITY ERROR;

	OpCode <= "011111";
	data1 <= std_logic_vector(to_unsigned(30,32));
	data2 <= std_logic_vector(to_unsigned(50,32));
	wait for clk_period;
	ASSERT(alu_out = std_logic_vector(to_unsigned(to_integer(signed(data1)) + to_integer(signed(data2)),32))) REPORT "ADD Rsrc, Rdst ERROR"
	SEVERITY ERROR;

	OpCode <= "011000";
	data1 <= std_logic_vector(to_unsigned(30,32));
	data2 <= std_logic_vector(to_unsigned(50,32));
	wait for clk_period;
	ASSERT(alu_out = std_logic_vector(to_signed(to_integer(signed(data1)) - to_integer(signed(data2)),32))) REPORT "SUB Rsrc, Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "011001";
	data1 <= std_logic_vector(to_unsigned(30,32));
	data2 <= std_logic_vector(to_unsigned(50,32));
	wait for clk_period;
	ASSERT(alu_out = (data1 AND data2)) REPORT "AND Rsrc, Rdst ERROR"
	SEVERITY ERROR;

	OpCode <= "011010";
	data1 <= std_logic_vector(to_unsigned(30,32));
	data2 <= std_logic_vector(to_unsigned(50,32));
	wait for clk_period;
	ASSERT(alu_out = (data1 OR data2)) REPORT "OR Rsrc, Rdst ERROR"
	SEVERITY ERROR;

	OpCode <= "010110";
	data1 <= std_logic_vector(to_unsigned(52,32));
	data2 <= std_logic_vector(to_unsigned(14,32));
	wait for clk_period;
	ASSERT(alu_out = std_logic_vector(to_unsigned(851968,32)) ) REPORT "SHL Rsrc, Rdst ERROR"
	SEVERITY ERROR;

	OpCode <= "010111";
	data1 <= std_logic_vector(to_unsigned(13312,32));
	data2 <= std_logic_vector(to_unsigned(5,32));
	wait for clk_period;
	ASSERT(alu_out = std_logic_vector(to_unsigned(416,32))) REPORT "SHR Rsrc, Rdst ERROR"
	SEVERITY ERROR;

	OpCode <= "100111";
	data1 <= std_logic_vector(to_unsigned(30,32));
	data2 <= std_logic_vector(to_unsigned(14,32));
	wait for clk_period;
	ASSERT(alu_out = std_logic_vector(to_unsigned(to_integer(signed(data1)) + to_integer(signed(data2)),32))) REPORT "IADD Rsrc, imm ERROR"
	SEVERITY ERROR;

	--OpCode <= "100010";
	--data1 <= std_logic_vector(to_unsigned(30,32));
	--data2 <= std_logic_vector(to_unsigned(14,32));
	--wait for clk_period;
	--ASSERT() REPORT "PUSH Rdst ERROR"
	--SEVERITY ERROR;

	--OpCode <= "100011";
	--wait for clk_period;
	--ASSERT() REPORT "POP Rdst ERROR"
	--SEVERITY ERROR;
	
	OpCode <= "100100";
	data1 <= std_logic_vector(to_unsigned(3345,32));
	data2 <= std_logic_vector(to_unsigned(321,32));
	wait for clk_period;
	ASSERT(alu_out = data2) REPORT "LDM Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "101101";
	data1 <= std_logic_vector(to_unsigned(534,32));
	data2 <= std_logic_vector(to_unsigned(321,32));
	wait for clk_period;
	ASSERT(alu_out = std_logic_vector(to_unsigned(to_integer(signed(data1)) + to_integer(signed(data2)),32))) REPORT "LDD Rdst ERROR"
	SEVERITY ERROR;
		
	OpCode <= "101110";
	data1 <= std_logic_vector(to_unsigned(534,32));
	data2 <= std_logic_vector(to_unsigned(321,32));
	wait for clk_period;
	ASSERT(alu_out = std_logic_vector(to_unsigned(to_integer(signed(data1)) + to_integer(signed(data2)),32))) REPORT "STD Rdst ERROR"
	SEVERITY ERROR;

	OpCode <= "111100";
	wait for clk_period;
	ASSERT(br_taken = '1') REPORT "JMP Rdst ERROR"
	SEVERITY ERROR;
	
	OpCode <= "000010";
	wait for clk_period; -- CLRC

	OpCode <= "111011";
	wait for clk_period;
	ASSERT(br_taken = '0') REPORT "JC Rdst taken ERROR"
	SEVERITY ERROR;

	OpCode <= "000001";
	wait for clk_period;
	
	OpCode <= "111011";
	wait for clk_period;
	ASSERT(br_taken = '1') REPORT "JC Rdst not taken ERROR"
	SEVERITY ERROR;

	OpCode <= "011111";
	data1 <= std_logic_vector(to_signed(-2,32));
	data2 <= std_logic_vector(to_signed(-2,32));
	wait for clk_period;
	ASSERT(alu_out = std_logic_vector(to_unsigned(to_integer(signed(data1)) + to_integer(signed(data2)),32))) REPORT "ADD Rsrc, Rdst ERROR"
	SEVERITY ERROR;

	OpCode <= "111011";
	wait for clk_period;
	ASSERT(br_taken = '1') REPORT "JC Rdst not taken ERROR"
	SEVERITY ERROR;
		
	wait;
  end process;

END behavior;