----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/13/2017 02:51:31 PM
-- Design Name: 
-- Module Name: defineResult - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity defineResult is
  generic(n: natural);
  Port (
   clk: in std_logic;
   ce: in std_logic;
   rst: in std_logic;
   sign: in std_logic;
   flag_inf: in std_logic;
   flag_sup: in std_logic;
   flag_zero: in std_logic;
   load_nr: in std_logic_vector(n-2 downto 0);
   result: out std_logic_vector(n-1 downto 0)
   );
end defineResult;

architecture Behavioral of defineResult is

signal temp: std_logic_vector(n-1 downto 0) := (others => '0');
begin

gen_res: process(clk)
begin
    if rising_edge(clk) then
    
        if rst = '1' then
            temp <= (others => '0');
        end if;
        
        if ce = '1' then
            if (flag_zero = '1') then
                temp(30 downto 0) <= (others => '0');
                temp(31) <= sign;
            elsif (flag_inf = '1') then
                 temp <= (others => '0');
                 elsif (flag_sup = '1') then
                    temp <= sign & "1111111100000000000000000000000";
                    else
                        temp <= sign & load_nr;
            end if;
        end if;
    end if;
end process;

result <= temp;
end Behavioral;
