----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/08/2017 08:50:20 PM
-- Design Name: 
-- Module Name: Rotunjire - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Rotunjire is
  generic(n:natural);
  Port(
    clk: in std_logic;
    ce: in std_logic;
    rst: in std_logic;
    g: in std_logic;
    r: in std_logic;
    s: in std_logic;
    left: in std_logic;
    right: in std_logic;
    product: in std_logic_vector(n-1 downto 0);
    q: out std_logic_vector(n-1 downto 0)
    );
end Rotunjire;

architecture Behavioral of Rotunjire is

signal zero, result, temp : std_logic_vector(n-1 downto 0) := (others => '0');
begin
                
process(clk)
begin
    if rising_edge(clk) then
        if (rst = '1') then
            temp <= zero;
        else
            if (ce = '1') then    
                
                if (left = '1') then
                    if (r = '1') then
                        temp <= product + 1;
                    else
                        temp <= product;
                    end if;
                end if;
                
                if (right = '1') then
                    if (s = '1') then
                         temp <= product + 1;
                    else
                         temp <= product;
                    end if;
                 end if;
                 
                 if (right = '0' and left = '0') then
                      if (g = '1') then
                            temp <= product + 1;
                       else
                             temp <= product;
                       end if;
                  end if;
                
            end if;
        end if;
    end if;
end process;

q <= temp;
end Behavioral;
