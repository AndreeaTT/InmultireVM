----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2017 10:37:34 AM
-- Design Name: 
-- Module Name: sum8b - Behavioral
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

entity sumAntTransport is
  generic(n:natural);
  Port (
    x:in std_logic_vector(n-1 downto 0);
    y:in std_logic_vector(n-1 downto 0);
    tin:in std_logic;
    s:out std_logic_vector(n-1 downto 0);
    tout:out std_logic
  );
end sumAntTransport;

architecture Behavioral of sumAntTransport is

type matrix is array(n/2 -1 downto 0) of STD_LOGIC;
signal t: matrix := (others => '0');
signal p, g: matrix := (others => '0');

begin

t(0) <= tin;
add: for i in 0 to n/2-1 generate	
    Ent2b: entity WORK.sum2b port map(
                x => x(i*2 + 1 downto i*2), 
                y => y(i*2 + 1 downto i*2), 
                tin => t(i), 
                s => s(i*2 + 1 downto i*2), 
                p => p(i), 
                g => g(i));
    cond: if i < (n/2-1) generate
        t(i+1) <= g(i) or (p(i) and t(i));
    end generate cond;
end generate add;
    
tout <= t(n/2-1);    
end Behavioral;
