----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/13/2017 02:27:50 PM
-- Design Name: 
-- Module Name: Control - Behavioral
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

entity Control is
  Port (
   clk: in std_logic;
   rst: in std_logic;
   start: in std_logic;
   dep_sup: in std_logic;
   dep_inf: in std_logic;
   zerox: in std_logic;
   zeroy: in std_logic;
   
   ce_sum: out std_logic;
   ce_mul: out std_logic;
   ce_norm: out std_logic;
   ce_round: out std_logic;
   flag_zero: out std_logic;
   load_xy: out std_logic;
   term:out std_logic
   );
end Control;

architecture Behavioral of Control is

type tip_stare is (idle, init, comp, add, mul, test1, test2, norm, round, stop);
signal stare: tip_stare;

begin

state_proc:process(clk)
begin
    if falling_edge(clk) then
        if (rst = '1') then
             stare <= idle;
             ce_sum <= '-';
             ce_mul <= '-';
             ce_norm <= '-';
             ce_round <= '-';
             load_xy <= '-';
             term <= '-';
             flag_zero <= '-';
        else
            case stare is
                when idle =>
                        ce_sum <= '0';
                        ce_mul <= '0';
                        ce_norm <= '0';
                        ce_round <= '0';
                        load_xy <= '0';
                        term <= '0';
                        flag_zero <= '0';
                        
                        if start = '1' then
                            stare <= init;
                        else 
                            stare <= idle;
                        end if;
                        
                when init =>
                        ce_sum <= '0';
                        ce_mul <= '0';
                        ce_norm <= '0';
                        ce_round <= '0';
                        load_xy <= '1';
                        term <= '0';
                        flag_zero <= '0';
                    
                        stare <= comp;
                    
                when comp =>
                        ce_sum <= '0';
                        ce_mul <= '0';
                        ce_norm <= '0';
                        ce_round <= '0';
                        load_xy <= '0';
                        term <= '0';
                        flag_zero <= '0';

                        if (zerox = '1' or zeroy = '1') then                
                            stare <= stop;
                        else
                            stare <= add;
                        end if;
                        
                 when add =>
                         ce_sum <= '1';
                         ce_mul <= '0';
                         ce_norm <= '0';
                         ce_round <= '0';
                         load_xy <= '0';
                         term <= '0';
                         flag_zero <= '0';
                                                    
                         stare <= test1;
                         
                 when test1 =>
                         ce_sum <= '0';
                         ce_mul <= '0';
                         ce_norm <= '0';
                         ce_round <= '0';
                         load_xy <= '0';
                         term <= '0';
                         flag_zero <= '0';
                                                     
                         if (dep_sup = '1' or dep_inf = '1') then
                             stare <= stop;
                         else
                             stare <= mul;
                         end if;
                             
                 when test2 =>
                         ce_sum <= '0';
                         ce_mul <= '0';
                         ce_norm <= '0';
                         ce_round <= '0';
                         load_xy <= '0';
                         term <= '0';
                         flag_zero <= '0';
                                                                                         
                         if (dep_sup = '1' or dep_inf = '1') then
                                stare <= stop;
                         else
                                stare <= round;
                         end if;
                           
                  when mul =>
                          ce_sum <= '0';
                          ce_mul <= '1';
                          ce_norm <= '0';
                          ce_round <= '0';
                          load_xy <= '0';
                          term <= '0';
                          flag_zero <= '0';
                                                         
                          stare <= norm;
                     
                  when norm =>
                          ce_sum <= '0';
                          ce_mul <= '0';
                          ce_norm <= '1';
                          ce_round <= '0';
                          load_xy <= '0';
                          term <= '0';
                          flag_zero <= '0';
                                                      
                          stare <= test2;
                            
                  when round =>
                          ce_sum <= '0';
                          ce_mul <= '0';
                          ce_norm <= '0';
                          ce_round <= '1';
                          load_xy <= '0';
                          term <= '0';
                          flag_zero <= '0';
                                                      
                          stare <= stop;
                          
                  when stop =>
                          ce_sum <= '0';
                          ce_mul <= '0';
                          ce_norm <= '0';
                          ce_round <= '0';
                          load_xy <= '0';
                          term <= '1';
                          
                          if (zerox = '1' or zeroy = '1') then
                                flag_zero <= '1';
                          else
                                flag_zero <= '0';    
                          end if;                                                 
                          stare <= idle;              
            end case;
        end if;
    end if;
end process;

end Behavioral;
