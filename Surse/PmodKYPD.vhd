----------------------------------------------------------------------------------
-- Company: Digilent Inc 2011
-- Engineer: Michelle Yu  
-- Create Date:    17:05:39 08/23/2011 
--
-- Module Name:    PmodKYPD - Behavioral 
-- Project Name:  PmodKYPD
-- Target Devices: Nexys3
-- Tool versions: Xilinx ISE 13.2 
-- Description: 
--	This file defines a project that outputs the key pressed on the PmodKYPD to the seven segment display
--
-- Revision: 
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PmodKYPD is
    Port ( 
		Clk : in  STD_LOGIC;
		Rst:  in STD_LOGIC;
		Start: in STD_LOGIC;
		JA : inout  STD_LOGIC_VECTOR (7 downto 0); -- PmodKYPD is designed to be connected to JA
        An : out  STD_LOGIC_VECTOR (7 downto 0);   -- Controls which position of the seven segment display to display
        Seg : out  STD_LOGIC_VECTOR (7 downto 0);  -- digit to display on the seven segment display 
        Term: out STD_LOGIC
      ); 
end PmodKYPD;

architecture Behavioral of PmodKYPD is
signal decode: STD_LOGIC_VECTOR (3 downto 0);
signal number1, temp1: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal number2, temp2: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal P: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal Ce1, Ce2, Done, Read_Flag, term_aux, Read_Flag_debounced: STD_LOGIC := '0';

begin

	Dec: entity WORK.Decoder port map (Clk, JA(7 downto 4), JA(3 downto 0), decode, Read_Flag);
	Debouce: entity WORK.Debounce port map(Clk, Rst, Read_Flag, Read_Flag_debounced);
	FSM: entity WORK.FSM_READDATA port map(Clk, Rst, Start, Read_Flag_debounced, Ce1, Ce2, Done);
	MulVM: entity WORK.InmultireVM port map(Clk, Rst, Done, number1, number2, P, term_aux);
	Display: entity WORK.displ7seg port map (Clk, Rst, P, An, Seg);
	bist: entity WORK.FD port map(Clk, term_aux, Rst, '1', Term);
	
	number1 <= temp1;
	number2 <= temp2;
	
gen_reg1: process(Clk)
            begin
               if rising_edge(Clk) then
                if (Rst = '1') then
                 temp1 <= (others=>'0');
                end if;
                
                if (Start = '1') then 
                    temp1 <= (others => '0');
                else
                    if (Ce1 = '1') then
                        temp1 <= temp1(31 downto 1) & decode(0); 
                    end if;
                end if;     
               end if;
end process gen_reg1;

gen_reg2: process(Clk)
            begin
               if rising_edge(Clk) then
                if (Rst = '1') then
                 temp2 <= (others=>'0');
                end if;
                
                if (Start = '1') then 
                    temp2 <= (others => '0');
                else
                    if (Ce2 = '1') then
                        temp2 <= temp2(31 downto 1) & decode(0); 
                    end if;
                end if;     
               end if;
end process gen_reg2;

end Behavioral;

