----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2017 14:01:41
-- Design Name: 
-- Module Name: normalizare - Behavioral
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

entity normalizare is
  Port (
        exponent: in std_logic_vector(7 downto 0);
        parte_intreaga: in std_logic_vector(1 downto 0);
        parte_fractionara: in std_logic_vector(45 downto 0);
        --dupa normalizare:
        mantisa: out std_logic_vector(22 downto 0);
        exponent_out: out std_logic_vector(7 downto 0);
        overflow: out std_logic
        );
end normalizare;

architecture Behavioral of normalizare is
signal exponent_out_temp: std_logic_vector(7 downto 0); 

begin
    process(parte_intreaga)
    begin
            case(parte_intreaga) is
                when "01" => mantisa<=parte_fractionara(45 downto 23);
                             exponent_out_temp<=exponent;
                             
                when "10" => mantisa<="0"&parte_fractionara(45 downto 24);
                             exponent_out_temp<=exponent+"00000001";
                             
                when "11" => mantisa<="1"&parte_fractionara(45 downto 24);
                             exponent_out_temp<=exponent+"00000001";
                             
                when others => mantisa<=parte_fractionara(45 downto 23);
                               exponent_out_temp<=exponent;
            end case;
            
            if (exponent="11111111") then                   --exponent: 255
                if (exponent_out_temp /= exponent) then     --exponent_out_temp: 256 ! => overflow
                    exponent_out_temp <= exponent;          --exponent_out_temp<= 255;
                    overflow <= '1';                        --overflow
                end if;
            end if;
    end process;
    
    
    exponent_out <= exponent_out_temp;
    
end Behavioral;







