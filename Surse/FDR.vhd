----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/13/2017 03:32:06 PM
-- Design Name: 
-- Module Name: FDR - Behavioral
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

entity FDR is
  generic(n: natural);
  Port (
  clk: in std_logic;
  rst: in std_logic;
  ce: in std_logic;
  d: in std_logic_vector(n-1 downto 0);
  q:out std_logic_vector(n-1 downto 0)
  );
end FDR;

architecture Behavioral of FDR is

begin
 
load:process(clk)
begin
    if rising_edge(clk) then
        if rst = '1' then
            q <= (others => '0');
        else
            if ce = '1' then
                q <= d;
            end if;
        end if;
    end if;
end process;

end Behavioral;
