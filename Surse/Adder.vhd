----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/14/2017 11:11:32 AM
-- Design Name: 
-- Module Name: Adder - Behavioral
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

entity Adder is
  generic(n:natural);
  Port ( 
  X: in std_logic_vector(n-1 downto 0);
  Y: in std_logic_vector(n-1 downto 0);
  tin: in std_logic;
  S: out std_logic_vector(n-1 downto 0);
  tout: out std_logic
  );
end Adder;

architecture Behavioral of Adder is
signal sum_temp: std_logic_vector(n-1 downto 0);
signal tout_temp: std_logic;

begin

add: entity WORK.sumAntTransport generic map(n => 10)
                                 port map(X,Y, tin, sum_temp, tout_temp);
                                 
subb: entity WORK.sumAntTransport generic map(n => 10)
                                  port map(sum_temp, "1110000001", '0', S, tout);
end Behavioral;
