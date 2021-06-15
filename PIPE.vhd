library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.all;

entity pipe is 
	port (	  clk,rst,Reset 	 :	in std_logic;
			  inPort	 :	in std_logic_vector(31 downto 0);
			  outPort	 :	out std_logic_vector(31 downto 0)
	);
end pipe;  

ARCHITECTURE a_pipe OF pipe IS

-- Fetch
SIGNAL StallFetch : std_logic := '0';
SIGNAL Callop, BranchTaken, instType_fetch, FlushFetch : std_logic;
SIGNAL InstructionBits, PC_fetch : std_logic_vector(31 downto 0);

-- Fetch/Decode buffer
SIGNAL FD_buffer_reset : std_logic;

-- Decode
SIGNAL instruction_in_decode : std_logic_vector(31 downto 0);
SIGNAL Rdest_decode, data1_decode, data2_decode : std_logic_vector(31 downto 0);
SIGNAL PC_decode : std_logic_vector (31 downto 0);
SIGNAL instType_decode : std_logic;

-- Decode/Execute buffer
SIGNAL retOp_out_execute : std_logic;
SIGNAL M_out_execute : std_logic_vector(6 downto 0);
SIGNAL WB_out_execute : std_logic_vector(2 downto 0);
SIGNAL RdstData_out_execute : std_logic_vector(31 downto 0);
SIGNAL M_in_DE_buffer : std_logic_vector(6 downto 0);
SIGNAL RdstAddr_out_execute, RsrcAddr_out_execute :  std_logic_vector(3 downto 0);

-- Conrol unit
SIGNAL IDEX_stall : std_logic := '0';
SIGNAL OpCode_decode : std_logic_vector(5 downto 0);
SIGNAL EX_decode	 : std_logic_vector(7 downto 0);
SIGNAL M_decode 	 : std_logic_vector(5 downto 0);
SIGNAL WB_decode 	 : std_logic_vector(2 downto 0);
SIGNAL PC_opr_decode	 : std_logic_vector(1 downto 0);

-- write back
SIGNAL wb_signal_decode : std_logic;
SIGNAL wb_address_decode : std_logic_vector (3 downto 0);
SIGNAL wb_data_decode : std_logic_vector (31 downto 0);

-- Execute
SIGNAL opcode_in_execute : std_logic_vector (5 downto 0);
SIGNAL Rdst_forwarded_execute, data1_execute, data2_execute, PC_in_execute : std_logic_vector (31 downto 0);
SIGNAL Br_taken_execute, aluOp_execute, upd_flag_execute, outPortEn_execute, setcSig_execute, clrcSig_execute, brOp_execute : std_logic;
SIGNAL brType_execute : std_logic_vector (1 downto 0);
SIGNAL PC_out_execute, alu_out_execute : std_logic_vector (31 downto 0);
SIGNAL Rdst_ex, Rdst_m : std_logic_vector (31 downto 0);

-- Forwarding Unit
SIGNAL ex_m_wbEn, m_wb_wbEn : std_logic;
SIGNAL forward1, forward2 : std_logic_vector (1 downto 0);

-- Memory
SIGNAL ALUoutput_in_memory, Rdst_data_memory, PC_memory, Memory_addressZero, Memory_out : std_logic_vector (31 downto 0);
SIGNAL Rdst_addr_memory : std_logic_vector (3 downto 0);
SIGNAL brTaken_out_memory, instType_memory, MemData, MemAddr, retOp_memory : std_logic;
SIGNAL MemSignal, SPsignal, WB_memory : std_logic_vector(1 downto 0);

-- Write back
SIGNAL ALU_output_WB, Memory_output_WB, WBdata : std_logic_vector(31 downto 0);
SIGNAL Rdst_addr_WB : std_logic_vector(3 downto 0);
SIGNAL WBSignal_WB : std_logic;
SIGNAL RetOp_wb, WbEnable_wb : std_logic;


BEGIN
	
	stage1: entity work.Stage1_E port map (
		clk => clk,
        rst => rst,
		Reset => Reset,
        Callop => Callop,
		BranchTaken => Br_taken_execute,
        RetOP => RetOp_wb,
		Fstall => StallFetch,
        Rdst => Rdst_forwarded_execute,
		PCbranch => PC_memory,
		PopedPC => Memory_output_WB,
		restPC => Memory_addressZero,
		inst_type_o => instType_fetch,
		InstructionBits => InstructionBits,
		PC => PC_fetch
    );  
	 
	FD_buffer_reset <= rst or FlushFetch;
	FD_buffer: entity work.FDBuffer_E port map (
		clk => clk,
        rst => FD_buffer_reset,
		instruction_in => InstructionBits,
		PC_in => PC_fetch,
		instType_in => instType_fetch,
		instruction_out => instruction_in_decode,
		PC_out => PC_decode,
		instType_out => instType_decode
    );  
	 
	 
	stage2: entity work.Stage2_E port map (
		clk => clk,
        rst => rst,
		InstructionMem => instruction_in_decode,
		INPORT => inPort,
		DataWrite => WBdata,
		WB_Enable => WbEnable_wb,
		WBAddress => Rdst_addr_WB,
		RsrcData => data1_decode,
		RdstData => Rdest_decode,
		SelectionOutput => data2_decode
    );
	 
	 
	OpCode_decode <= instruction_in_decode(29 downto 24);
	controlUnit: entity work.Control_Unit port map (
		OpCode => OpCode_decode,
		stall => IDEX_stall,
		EX => EX_decode,
		M => M_decode,
	 	WB => WB_decode,
		PC_opr => PC_opr_decode
	);
	
	
	M_in_DE_buffer <= instType_fetch & M_decode;
	DE_buffer: entity work.ID_EX_buffer port map (
		PC_in => PC_decode,
		Opcode_in => OpCode_decode,
		data1_in => data1_decode,
		data2_in => data2_decode,
	 	RdstData_in => Rdest_decode,
		RdstAddr_in => instruction_in_decode(19 downto 16),
		RsrcAddr_in => instruction_in_decode(23 downto 20),
		
		PCopr_in => PC_opr_decode,
		WB_in => WB_decode,
		M_in => M_in_DE_buffer,
		EX_in => EX_decode,

		clk => clk,
	
		PC_out => PC_in_execute,
		Opcode_out => opcode_in_execute,
		data1_out => data1_execute,
		data2_out => data2_execute,
	 	RdstData_out => RdstData_out_execute,
		RdstAddr_out => RdstAddr_out_execute,
		RsrcAddr_out => RsrcAddr_out_execute,

		WB_out => WB_out_execute,
		M_out => M_out_execute,
		retOp_out => retOp_out_execute,
		callOp_out => Callop,
		
		updFlags_out => upd_flag_execute,
		aluOp_out => aluOp_execute,
		outPortEn_out => outPortEn_execute,
		setcSig_out => setcSig_execute,
		clrcSig_out => clrcSig_execute,
		brOp_out => brOp_execute,
		brType_out => brType_execute
	);
	
	
	stage3: entity work.Execute port map (
		clk => clk,
		rst => rst,

		Opcode => opcode_in_execute,

		Br_op => brOp_execute,
		SETC_sig => setcSig_execute,
		CLRC_sig => clrcSig_execute,
		Br_type => brType_execute,
		
		forward1 => forward1,
		forward2 => forward2,

		alu_op => aluOp_execute,
		upd_flag => upd_flag_execute,
		outPort_en => outPortEn_execute,

		data1 => data1_execute,
		data2 => data2_execute,
		PC_in => PC_in_execute,
		Rdst_ex => Rdst_data_memory,
		Rdst_m => WBdata,

		Rdst_forwarded => Rdst_forwarded_execute,
		Br_taken => Br_taken_execute,
		alu_out => alu_out_execute,
		PC_out => PC_out_execute
	);
	outPort <= alu_out_execute WHEN outPortEn_execute = '1';
	
	forwardingUnit: entity work.Forwarding_Unit port map (
		id_ex_Rsrc => RsrcAddr_out_execute,
		id_ex_Rdst => RdstAddr_out_execute,
		m_wb_Rdst => Rdst_addr_WB,
		ex_m_Rdst => Rdst_addr_memory,

		ex_m_wbEn => ex_m_wbEn,
		m_wb_wbEn => WbEnable_wb,
		
		forward1 => forward1,
		forward2 => forward2
	);
	
	
	EM_buffer: entity work.EX_M_buffer port map (
		PC_in => PC_out_execute,
		ALUoutput_in => alu_out_execute,
	 	RdstData_in => RdstData_out_execute,
		RdstAddr_in => RdstAddr_out_execute,
		brTaken_in => Br_taken_execute,
		retOp_in => retOp_out_execute,

		WB_in => WB_out_execute,
		M_in => M_out_execute,

		clk => clk,

		PC_out => PC_memory,
		ALUoutput_out => ALUoutput_in_memory,
	 	RdstData_out => Rdst_data_memory,
		RdstAddr_out => Rdst_addr_memory,

		brTaken_out => brTaken_out_memory,
		retOp_out => retOp_memory,

		WB_out => WB_memory,
		ex_m_wbEn_out => ex_m_wbEn,

		memData_out => MemData,
		memAddr_out => MemAddr,
		instType_out => instType_memory,
		spSig_out => SPsignal,
		memSig_out => MemSignal
	);
	
	
	stage4 : entity work.Stage4_E port map (
		instType => instType_memory,
		MemData => MemData,
		MemAddr => MemAddr,
		
		clk => clk,
		rst => rst,
		
		MemSignal => MemSignal,
		SPsignal => SPsignal,
		
		Rdst => Rdst_data_memory,
		ALUout => ALUoutput_in_memory,
		PC => PC_memory,
		
		mem_addressZero => Memory_addressZero,
		Stage4Out => Memory_out
	);

	
	MW_buffer: entity work.MWBuffer_E port map (
		ALU_output_in => ALUoutput_in_memory,
		mem_output_in => Memory_out,
		WB_in => WB_memory,
		Rdst_addr_in => Rdst_addr_memory,
		RetOp_in => retOp_memory,
		
		clk => clk,
		rst => rst,
		
		ALU_output_out => ALU_output_WB,
		mem_output_out => Memory_output_WB,
		WbEnable_out => WbEnable_wb,
		WbSignal_out => WBSignal_WB,
		RetOp_out => RetOp_wb,
		Rdst_addr_out => Rdst_addr_WB
	);
	
	
	stage5 : entity work.Stage5_E port map (
		ALU => ALU_output_WB,
		Memory => Memory_output_WB,
		WBSignal => WBSignal_WB,
		
		WBdata => WBdata
	);

	HazardDetectionUnit : entity work.HazardDetectionUnit port map (
		Rsrc => InstructionBits(23 downto 20),
		Rdst => InstructionBits(19 downto 16),
		Rdst_Exec => instruction_in_decode(19 downto 16),
		OpCodeFetch => InstructionBits(29 downto 24),
		OpCodeDecode => instruction_in_decode(29 downto 24),
        clk => clk,
        FlushFetch => FlushFetch,
		StallFetch => StallFetch
	);
	

END a_PIPE;
