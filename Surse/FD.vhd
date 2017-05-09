----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2017 04:20:19 PM
-- Design Name: 
-- Module Name: FD - Behavioral
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

entity FD is
  generic(n:natural);
  Port (
     Clk: in STD_LOGIC;
     ce : in STD_LOGIC;
     Rst: in STD_LOGIC;
     d: in STD_LOGIC_VECTOR(n-1 downto 0);
     q: out STD_LOGIC_VECTOR(n-1 downto 0)
   );
end FD;

architecture Behavioral of FD is

begin

gen_bistabil:process(clk)
                begin
                if rising_edge(clk) then
                   if (rst = '1') then
                       q <= (others => '0');
                   end if;
                   
                   if (ce = '1') then
                       q <= d;
                   end if;
               end if;
end process gen_bistabil;
   
end Behavioral;
