library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Forwarding_Unit is 
	port (	id_ex_Rsrc :	in std_logic_vector(3 downto 0);
		id_ex_Rdst :	in std_logic_vector(3 downto 0);
		m_wb_Rdst  :	in std_logic_vector(3 downto 0);
		ex_m_Rdst  :	in std_logic_vector(3 downto 0);		

		ex_m_wbEn, m_wb_wbEn	: in std_logic;

		forward1,forward2	: out std_logic_vector(1 downto 0)
	);
end Forwarding_Unit;


ARCHITECTURE Forwarding_Unit_a OF Forwarding_Unit IS
BEGIN

	
	forward1 <= "00" WHEN id_ex_Rsrc(3) = '1' 
		ELSE "10" WHEN id_ex_Rsrc = m_wb_Rdst AND m_wb_wbEn = '1'
		ELSE "01" WHEN id_ex_Rsrc = ex_m_Rdst AND ex_m_wbEn = '1'
		ELSE "00";

	forward2 <= "00" WHEN id_ex_Rdst(3) = '1' 
		ELSE "10" WHEN id_ex_Rdst = m_wb_Rdst AND m_wb_wbEn = '1'
		ELSE "01" WHEN id_ex_Rdst = ex_m_Rdst AND ex_m_wbEn = '1'
		ELSE "00";

END Forwarding_Unit_a;