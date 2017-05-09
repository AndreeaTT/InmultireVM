----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2017 06:24:42 PM
-- Design Name: 
-- Module Name: Depasire - Behavioral
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

entity Depasire is
  generic(n:natural := 8);
  Port ( 
  X: in std_logic_vector(n-1 downto 0);
  inferior: out std_logic;
  superior: out std_logic
  );
end Depasire;

architecture Behavioral of Depasire is

signal small1, equal1, equal2, greater2: std_logic;
begin

DUT1: entity WORK.Comparator port map(X, "01111111", small1, equal1, superior);
DUT2: entity WORK.Comparator port map(X, "10000010", inferior, equal2, greater2); 

end Behavioral;
