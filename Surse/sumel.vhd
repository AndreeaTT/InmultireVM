----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2017 08:26:45 AM
-- Design Name: 
-- Module Name: sumel - Behavioral
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

entity sumel is
  Port (
  X: in STD_LOGIC;
  Y: in STD_LOGIC;
  tin: in STD_LOGIC;
  s: out STD_LOGIC;
  tout: out STD_LOGIC
   );
end sumel;

architecture Behavioral of sumel is
begin
	s <= X xor Y xor tin;
    tout <=  (X and Y) or (X and tin) or (Y and tin);

end Behavioral;
