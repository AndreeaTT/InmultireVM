----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2017 09:27:27 AM
-- Design Name: 
-- Module Name: InmultireVM - Behavioral
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

entity InmultireVM is
  Port (
    Clk: in STD_LOGIC;
    Rst: in STD_LOGIC;
    Start: in STD_LOGIC;
    X: in STD_LOGIC_VECTOR(31 DOWNTO 0);
    Y: in STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    P: out STD_LOGIC_VECTOR(31 DOWNTO 0);
    Term: out STD_LOGIC
   );
end InmultireVM;

architecture Behavioral of InmultireVM is

signal dep_inf, dep_sup_add, dep_sup_norm, zeroX_val, zeroY_val, ce_sum, ce_mul, ce_norm, term_aux: STD_LOGIC := '0';
signal ce_round, flag_zero, load_xy, tout_sum: STD_LOGIC := '0';
signal A_temp, B_temp : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal E_temp, E_temp_norm,  E_norm: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal M_sup_temp, M_inf_temp: STD_LOGIC_VECTOR(23 downto 0) := (others => '0');
signal E_temp_sum: STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
signal M_temp_mul: STD_LOGIC_VECTOR(47 downto 0) := (others => '0');
signal Rez_intr, M_norm, M_temp_norm: STD_LOGIC_VECTOR(22 downto 0) := (others => '0');
signal g, r, s, set_sticky, LessA, MuchA, LessB, MuchB: STD_LOGIC := '0';
signal LessE1_sum, EqualE1_sum, MuchE1_sum, LessE2_sum, EqualE2_sum, MuchE2_sum: STD_LOGIC := '0';
signal OvfNorm: STD_LOGIC := '0';
signal zero_Value : STD_LOGIC_VECTOR(30 downto 0) := (others => '0');

begin

control: entity WORK.Control port map(Clk, Rst, Start, dep_sup_add or OvfNorm, dep_inf, zeroX_val, zeroY_val, 
                                      ce_sum, ce_mul, ce_norm, ce_round, flag_zero, load_xy, term_aux);

zeroA: entity WORK.Comparator generic map(n => 31)
                              port map (A_temp(30 downto 0), zero_Value, LessA, zeroX_val, MuchA);
                              
zeroB: entity WORK.Comparator generic map(n => 31)
                              port map(B_temp(30 downto 0), zero_Value, LessB, zeroY_val, MuchB);

depasire_inf: entity WORK.Comparator generic map(n => 9)
                                     port map(E_temp_sum(8 downto 0), "000000001", LessE1_sum, EqualE1_sum, MuchE1_sum);
                                 
depasire_sup1: entity WORK.Comparator generic map(n => 9)
                                     port map(E_temp_sum(8 downto 0), "011111110", LessE2_sum, EqualE2_sum, MuchE2_sum);                                                                    

regA: entity WORK.FDR generic map(n => 32)
                      port map(Clk, Rst, load_xy, X, A_temp);
                      
regB: entity WORK.FDR generic map(n => 32)
                      port map(Clk, Rst, load_xy, Y, B_temp);
                      
regE: entity WORK.FDR generic map(n => 8)
                      port map(Clk, Rst, ce_sum, E_temp_sum(7 downto 0), E_temp);

regNormE: entity WORK.FDR generic map(n => 8)
                          port map(Clk, Rst, ce_norm, E_temp_norm, E_norm);
                   
regNormM_s: entity WORK.FDR generic map(n => 23)
                         port map(Clk, Rst, ce_norm, M_temp_norm, M_norm);
                      
regM_sup: entity WORK.FDR generic map(n => 24)
                          port map(Clk, Rst, ce_mul, M_temp_mul(47 downto 24), M_sup_temp);
                         
regM_inf: entity WORK.FDR generic map(n => 24)
                          port map(Clk, Rst, ce_mul, M_temp_mul(23 downto 0), M_inf_temp);
                          
adder: entity WORK.Adder generic map(n => 10)
                         port map("00" & A_temp(30 downto 23), "00"& B_temp(30 downto 23), '0', E_temp_sum, tout_sum);

mul: entity WORK.matricial generic map(n => 24)
                           port map('1' & A_temp(22 downto 0), '1' & B_temp(22 downto 0), M_temp_mul);
 
norm: entity WORK.normalizare port map(E_temp, M_sup_temp(23 downto 22), M_sup_temp(21 downto 0) & M_inf_temp, M_temp_norm, E_temp_norm ,OvfNorm); 
                    
rot: entity WORK.Rotunjire generic map(n => 23)
                           port map(Clk, ce_round, Rst, g, r, s, '1', '0', M_norm, Rez_intr);
                           
result: entity WORK.defineResult generic map(n => 32)
                                 port map(Clk, term_aux, Rst, A_temp(31) xor B_temp(31), dep_inf, dep_sup_add or OvfNorm, flag_zero, E_norm & Rez_intr, P);

guard_bit: entity WORK.FD  port map(Clk, ce_mul, Rst, M_temp_mul(23), g);                       
round_bit: entity WORK.FD port map(Clk, ce_mul, Rst, M_temp_mul(22), r);
sticky_bit: entity WORK.FD port map(Clk, ce_mul, Rst, set_sticky, s);                     
depi: entity WORK.FD port map(Clk, ce_sum, Rst, LessE1_sum or E_temp_sum(9), dep_inf);
deps_add: entity WORK.FD port map(Clk, ce_sum, Rst, not E_temp_sum(9) and MuchE2_sum, dep_sup_add);                      
gen_sticky: for i in 0 to 23 generate
             set_sticky <= set_sticky or M_temp_mul(i);
end generate gen_sticky;

Term <= term_aux;

end Behavioral;
