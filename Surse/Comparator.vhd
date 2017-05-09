----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2017 06:15:02 PM
-- Design Name: 
-- Module Name: Comparator - Behavioral
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
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Comparator is
  generic(n:natural);
  Port ( 
  A: in std_logic_vector(n-1 downto 0);
  B: in std_logic_vector(n-1 downto 0);
  Less: out std_logic;
  Equal: out std_logic;
  More: out std_logic
  );
end Comparator;

architecture Behavioral of Comparator is

begin
Equal <= '1' when A = B else '0';
Less <= '1' when A < B else '0';
More <= '1' when A > B else '0';

end Behavioral;
