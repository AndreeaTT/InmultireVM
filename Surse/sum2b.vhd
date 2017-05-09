----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2017 10:24:18 AM
-- Design Name: 
-- Module Name: sum2b - Behavioral
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

entity sum2b is
  Port (
    x:in std_logic_vector(1 downto 0);
    y:in std_logic_vector(1 downto 0);
    tin:in std_logic;
    s:out std_logic_vector(1 downto 0);
    p:out std_logic;
    g:out std_logic 
  );
end sum2b;

architecture Behavioral of sum2b is
signal t1:std_logic;

begin
        g <= (x(1) and y(1)) or ((x(1) or y(1)) and (x(0) and y(0)));
        p <= ((x(1) or y(1)) and (x(0) or y(0)));
        s(0) <= x(0) xor y(0) xor tin;
        t1 <= (x(0) and y(0)) or (x(0) and tin) or (y(0) and tin); 
        s(1) <= x(1) xor y(1) xor t1;
end Behavioral;
