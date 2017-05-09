----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2017 10:14:46 AM
-- Design Name: 
-- Module Name: FSM_READDATA - Behavioral
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

entity FSM_READDATA is
  Port ( 
  Clk: in STD_LOGIC;
  Rst: in STD_LOGIC;
  Start: in STD_LOGIC;
  ReadFlag: in STD_LOGIC;
  
  Ce1: out STD_LOGIC;
  Ce2: out STD_LOGIC;
  Done: out STD_LOGIC
  );
end FSM_READDATA;

architecture Behavioral of FSM_READDATA is

TYPE state_type is (idle, ready, read, test, stop);
signal state: state_type;
signal bit_nr : INTEGER := 0;
begin

gen_state: process(Clk)
begin
    if rising_edge(Clk) then
        if (Rst = '1') then
            bit_nr <= 0;
            state <= idle;
        else
            case state is
                when idle =>
                    bit_nr <= 0;
                    if (Start = '1') then
                        state <= ready;
                    else
                        state <= idle;
                    end if;
                    
                when ready =>
                    bit_nr <= 0;
                     if (ReadFlag = '1') then
                          state <= read;
                     else
                          state <= ready;
                     end if;
                
                when read =>
                    bit_nr <= bit_nr + 1;
                    state <= test;
                    
                when test =>
                     if (ReadFlag = '1') then
                          if (bit_nr = 64) then
                               state <= stop;
                          else
                               state <= read;
                           end if;
                      else
                            state <= test;
                      end if;
                                    
                    
                when stop =>
                    state <= idle;
            end case;
         end if;
    end if;
end process gen_state;

Done <= '1' when state = stop else '0';
Ce1 <= '1' when state = read and bit_nr < 32 else '0';
Ce2 <= '1' when state = read and bit_nr >= 32 else '0';
end Behavioral;
