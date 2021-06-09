library ieee;
use ieee.std_logic_1164.all;

ENTITY Execute IS
	PORT(
		clk,rst : IN std_logic;

		Opcode : IN std_logic_vector(5 downto 0);

		Br_op, SETC_sig, CLRC_sig : IN std_logic;
		Br_type : IN std_logic_vector(1 downto 0);
		
		forward1, forward2 : IN std_logic_vector(1 downto 0);

		alu_op, upd_flags, outPort_en : IN std_logic;

		data1, data2, PC_in : IN std_logic_vector(31 downto 0);
		Rdst_ex, Rdst_m : IN std_logic_vector(31 downto 0);

		Br_taken : OUT std_logic;

		alu_out, PC_out : OUT std_logic_vector(31 downto 0)
	);
END ENTITY;

ARCHITECTURE Execute_a OF Execute IS

SIGNAL branch_Mux4x1, branch_Mux2x1 : std_logic;
SIGNAL pc_Mux2x1, data1_Mux4x1, data2_Mux4x1 : std_logic_vector (31 downto 0);
SIGNAL aluFunc_Mux2x1 : std_logic_vector (5 downto 0);

SIGNAL brTaken : std_logic;
SIGNAL Z_flag_alu, N_flag_alu, C_flag_alu : std_logic;
SIGNAL Z_CCR_out, N_CCR_out, C_CCR_out : std_logic;
SIGNAL temp1 : std_logic;
BEGIN
	
	Br_taken <= brTaken;
	temp1 <=  SETC_sig OR CLRC_sig;
	branch_Mux2x1 <= (SETC_sig OR (NOT CLRC_sig)) WHEN (SETC_sig OR CLRC_sig) = '1'
		ELSE C_flag_alu;

	cu: entity work.CCR port map (
		clk => clk, rst => rst,
		brTaken => brTaken,
		enable_update => alu_op,
		enable_update_C => temp1,
		brType => Br_type,
		C_in => branch_Mux2x1, Z_in => Z_flag_alu, N_in => N_flag_alu, 
		C_out => C_CCR_out, Z_out => Z_CCR_out, N_out => N_CCR_out
	);

	alu: entity work.ALU port map (
		aluFunc => Opcode,
		data1 => data1_Mux4x1,
		data2 => data2_Mux4x1,

		z_flag_in => Z_CCR_out,
		c_flag_in => C_CCR_out,
		n_flag_in => N_CCR_out,

		z_flag => Z_flag_alu, 
		c_flag => C_flag_alu,
		n_flag => N_flag_alu,
		result => alu_out
	);

	With Br_type(1 downto 0) select
		branch_Mux4x1 <= Z_CCR_out WHEN "00",
				N_CCR_out WHEN "01",
				C_CCR_out WHEN "10",
				'1' WHEN OTHERS;

	brTaken <= branch_Mux4x1 AND Br_op;

	PC_out <= PC_in WHEN brTaken = '0'
		ELSE data1_Mux4x1;

	With forward1(1 downto 0) select
	data1_Mux4x1 <= data1 WHEN "00",
			Rdst_ex WHEN "01",
			Rdst_m WHEN "10",
			data1 WHEN OTHERS;

	With forward2(1 downto 0) select
	data2_Mux4x1 <= data2 WHEN "00",
			Rdst_ex WHEN "01",
			Rdst_m WHEN "10",
			data2 WHEN OTHERS;


	aluFunc_Mux2x1 <= Opcode WHEN alu_op = '1'
		ELSE (OTHERS => '0');


END Execute_a;