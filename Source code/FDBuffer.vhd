library ieee;
use ieee.std_logic_1164.all;

Entity FDBuffer_E is
  port(
    instruction_in, PC_in : IN std_logic_vector(31 downto 0);
    instType_in,clk,rst : IN std_logic;
    instruction_out, PC_out :OUT std_logic_vector(31 downto 0);
    instType_out : OUT std_logic
  );
END Entity;

architecture FDBuffer_A of FDBuffer_E IS
  begin
 PROCESS (clk,rst)
BEGIN
IF rst = '1' THEN
instruction_out <= (OTHERS=>'0');
PC_out <= (OTHERS=>'0');
instType_out <= '0';
ELSIF falling_edge(Clk) THEN
instruction_out <= instruction_in;
PC_out <= PC_in;
instType_out <= instType_in;
END IF;
END PROCESS;
  end architecture;


