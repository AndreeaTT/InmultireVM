----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2017 11:00:32 AM
-- Design Name: 
-- Module Name: srrn - Behavioral
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

entity slrn is
  generic(n:natural);
  Port (
   clk:in std_logic;
   d: in std_logic_vector(n-1 downto 0);
   sri: in std_logic;
   rst: in std_logic;
   load: in std_logic;
   ce: in std_logic;
   q: out std_logic_vector(n-1 downto 0)
   );
end slrn;

architecture Behavioral of slrn is

signal temp: std_logic_vector(n-1 downto 0);
begin

gen_reg: process(clk)
        begin
           if rising_edge(clk) then
            if (rst = '1') then
             temp <= (others=>'0');
            end if;
            
            if (load = '1') then 
                temp <= d;
            else
                if (ce = '1') then
                    temp <= temp(n-1 downto 1) & sri; 
                end if;
            end if;     
           end if;
 end process gen_reg;

q <= temp;
end Behavioral;