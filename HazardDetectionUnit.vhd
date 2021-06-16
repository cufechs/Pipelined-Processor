-- This is Hazard Detection Unit.
-- It handles Branching, Calls, and Return.
-- It handles Load-Use case.
-- Author: Osama Yahya

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY HazardDetectionUnit is
  PORT (Rsrc: IN std_logic_vector(3 DOWNTO 0);
	Rdst: IN std_logic_vector(3 DOWNTO 0);
	Rdst_Exec: IN std_logic_vector(3 DOWNTO 0);	
	OpCodeFetch: IN std_logic_vector(5 DOWNTO 0);
	OpCodeDecode: IN std_logic_vector(5 DOWNTO 0);
        clk: IN std_logic;
        FlushFetch, StallFetch: OUT std_logic);
END HazardDetectionUnit;

ARCHiTECTURE Project of HazardDetectionUnit is

COMPONENT Counter is
GENERIC (n: Integer := 2; m: Integer := 3);
PORT (clk, Start : IN std_logic;
counterout : OUT std_logic_vector(n-1 DOWNTO 0));
END COMPONENT;

--For Delaying Signals and Better Synchronization
SIGNAL CD1_Start: std_logic := '0';
SIGNAL CD2_Start: std_logic := '0';
SIGNAL CD3_Start: std_logic := '0';
SIGNAL CD1_OUT : std_logic_vector(1 DOWNTO 0);
SIGNAL CD2_OUT : std_logic_vector(1 DOWNTO 0);
SIGNAL CD3_OUT : std_logic_vector(1 DOWNTO 0);
SIGNAL Delay_Flush_1C: std_logic := '0';
SIGNAL Delay_Flush_2C: std_logic := '0';
SIGNAL Delay_Flush_3C: std_logic := '0';

SIGNAL C1_Start: std_logic := '0';
SIGNAL C2_Start: std_logic := '0';
SIGNAL C3_Start: std_logic := '0';
SIGNAL C1_OUT : std_logic_vector(1 DOWNTO 0);
SIGNAL C2_OUT : std_logic_vector(1 DOWNTO 0);
SIGNAL C3_OUT : std_logic_vector(1 DOWNTO 0);

SIGNAL OutStallFetch: std_logic := '0';

BEGIN

PROCESS(clk)
BEGIN

-- I take the 6 leaset significant bit from OpCodeFetch
IF FALLING_EDGE(clk) THEN 
	IF (OutStallFetch = '0') THEN
		IF ((OpCodeDecode = "100100") or (OpCodeDecode = "101101")) and (not(OpCodeFetch = "010101" or OpCodeFetch = "100011" or OpCodeFetch = "100100" or OpCodeFetch = "101101" or OpCodeFetch = "110110" or OpCodeFetch = "000000" or OpCodeFetch = "000001" or OpCodeFetch = "000010")) THEN -- Load-Use case
			IF (Rsrc = Rdst_Exec) or (Rdst = Rdst_Exec) THEN
				OutStallFetch <= '1';
				C1_Start <= '1';
			END IF;
		END IF;
		IF (OpCodeFetch = "111001") or (OpCodeFetch = "111010") or (OpCodeFetch = "111011") or (OpCodeFetch = "111100") THEN  -- Bracnhing Occured
			IF C1_OUT = "00" THEN
				OutStallFetch <= '1';  --Two Times
				Delay_Flush_2C <= '1';
				C2_Start <= '1';
				CD2_Start <= '1';
			END IF;
		ELSIF OpCodeFetch = "110101" THEN  --Call Operation
			OutStallFetch <= '1';  --One Time
			Delay_Flush_1C <= '1'; --Delay one cycle
			C1_Start <= '1';
			CD1_Start <= '1';
		ELSIF OpCodeFetch = "110110" THEN --Return
			OutStallFetch <= '1';  --Three Times
			Delay_Flush_3C <= '1'; --Delay one cycle
			C3_Start <= '1';
			CD3_Start <= '1';
		END IF;
	END IF;

	IF CD1_OUT = "01" THEN
		Delay_Flush_1C <= '0';
		CD1_Start <= '0';
	END IF;

	IF CD2_OUT = "10" THEN
		Delay_Flush_2C <= '0';
		CD2_Start <= '0';
	END IF;

	IF CD3_OUT = "11" THEN
		Delay_Flush_3C <= '0';
		CD3_Start <= '0';
	END IF;

	IF C1_OUT = "01" THEN
		OutStallFetch <= '0';
		C1_Start <= '0';
	END IF;

	IF C2_OUT = "10" THEN
		OutStallFetch <= '0';
		C2_Start <= '0';
	END IF;

	IF C3_OUT = "11" THEN
		OutStallFetch <= '0';
		C3_Start <= '0';
	END IF;
	
	FlushFetch <= (Delay_Flush_1C or Delay_Flush_2C or Delay_Flush_3C);
END IF;

END PROCESS;

StallFetch <= OutStallFetch;

CD1: Counter GENERIC MAP(2, 1) PORT MAP (clk, CD1_Start, CD1_OUT);
CD2: Counter GENERIC MAP(2, 2) PORT MAP (clk, CD2_Start, CD2_OUT);
CD3: Counter GENERIC MAP(2, 3) PORT MAP (clk, CD3_Start, CD3_OUT);
C1: Counter GENERIC MAP(2, 1) PORT MAP (clk, C1_Start, C1_OUT);
C2: Counter GENERIC MAP(2, 2) PORT MAP (clk, C2_Start, C2_OUT);
C3: Counter GENERIC MAP(2, 3) PORT MAP (clk, C3_Start, C3_OUT);

END Project;