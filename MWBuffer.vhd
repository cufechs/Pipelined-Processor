library ieee;
use ieee.std_logic_1164.all;

Entity MWBuffer_E is
  port(
    ALU_output_in, mem_output_in : IN std_logic_vector(31 downto 0);
    WB_in : IN std_logic_vector(1 downto 0); --WB
    Rdst_addr_in : IN std_logic_vector(3 downto 0);--Raddr
    RetOp_in : IN std_logic;--RetOP
    clk,rst : IN std_logic;
    ALU_output_out, mem_output_out : OUT std_logic_vector(31 downto 0);
    WbEnable_out, WbSignal_out, RetOp_out : OUT std_logic;--WbEnable,WbSignal,Retop
    Rdst_addr_out : OUT std_logic_vector(3 downto 0)--Raddr
  );
END Entity;

architecture MWBuffer_A of MWBuffer_E IS
  begin
 PROCESS (clk,rst)
BEGIN
IF rst = '1' THEN
ALU_output_out <= (OTHERS=>'0');
mem_output_out <= (OTHERS=>'0');
WbEnable_out <= '0';
WbSignal_out <= '0';
RetOp_out <= '0';
Rdst_addr_out <= (OTHERS=>'0');
ELSIF rising_edge(Clk) THEN
ALU_output_out <= ALU_output_in;
mem_output_out <= mem_output_in;
WbEnable_out <= WB_in(0);
WbSignal_out <= WB_in(1);
RetOp_out <= RetOp_in;
Rdst_addr_out <= Rdst_addr_in;
END IF;
END PROCESS;
  end architecture;




