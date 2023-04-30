----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2023 09:56:16 AM
-- Design Name: 
-- Module Name: context_modeller - Behavioral
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
use IEEE.MATH_REAL.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity context_modeller_top is
    Port (
        pclk :          in  STD_LOGIC := '0';
        en   :          in  STD_LOGIC := '0'; 
        valid_data:     in  STD_LOGIC := '0';
        idx :           in  STD_LOGIC_VECTOR    (integer(ceil(log2(real(365)))) - 1 downto 0) := (others => '0');
        error :         in  signed              (8 - 1 downto 0) := (others => '0');
         
        C :             out signed              (8 - 1 downto 0) := (others => '0');
        B :             out signed              (9 - 1 downto 0) := (others => '0');
        N :             out unsigned            (7 - 1 downto 0) := (others => '0');
        k :             out unsigned            (5 - 1 downto 0) := (others => '0'));
end context_modeller_top;

architecture Behavioral of context_modeller_top is

    component context_modeller is
        generic ( 
            data_width  :   integer := 8;
            k_width     :   integer := 5;       -- KUNNE DEN IKKE SÆTTES TIL ceil(log2(data_width-1))?
            n_size      :   integer := 7;       -- KUNNE DEN IKKE SÆTTES TIL ceil(log2(n_reset+1))?
            a_size      :   integer := 15;      -- KUNNE DEN IKKE SÆTTES TIL ceil(log2(n_reset*(2**(data_width-1))))?
            b_size      :   integer := 9;       -- I VÆRSTE FALD KUNNE DEN VEL SÆTTES TIL 1+ceil(log2(n_reset*(2**(data_width-1))))?
            n_reset     :   integer := 64;
            no_contexts :   integer := 365
            );
        Port (
            pclk :          in  STD_LOGIC := '0';
            en   :          in  STD_LOGIC := '0'; 
            valid_data:     in  STD_LOGIC := '0';
            idx :           in  STD_LOGIC_VECTOR    (integer(ceil(log2(real(no_contexts)))) - 1 downto 0) := (others => '0');
            error :         in  signed              (data_width - 1 downto 0) := (others => '0');
             
            C :             out signed              (data_width - 1 downto 0) := (others => '0');
            B :             out signed              (b_size - 1 downto 0) := (others => '0');
            N :             out unsigned            (n_size - 1 downto 0) := (others => '0');
            k :             out unsigned            (k_width - 1 downto 0) := (others => '0'));
    end component;
    
    constant data_width  :   integer := 8;
    constant k_width     :   integer := 5;
    constant n_size      :   integer := 7;
    constant a_size      :   integer := 15;
    constant b_size      :   integer := 9;
    constant c_size      :   integer := 8;
    constant n_reset     :   integer := 64;  
    constant min_c       :   integer := -128;
    constant max_c       :   integer := 127; 
    constant no_contexts :   integer := 365; 
    constant alpha       :   integer := 256;
    

begin
    
        dut : context_modeller
    generic map ( 
                data_width   => data_width ,
                k_width      => k_width    ,
                n_size       => n_size     ,
                a_size       => a_size     ,
                b_size       => b_size     ,
                n_reset      => n_reset    ,
                no_contexts  => no_contexts
              )
    port map (pclk              => pclk,
              en                => en,
              valid_data        => valid_data,
              idx               => idx,
              error             => error,
              C => C,
              B => B,
              N => N,
              k => k
              );

   
end Behavioral;
