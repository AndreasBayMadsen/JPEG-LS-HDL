----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2023 08:56:32 PM
-- Design Name: 
-- Module Name: pipeline_module_2 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pipeline_module_2 is
    Generic (   color_res   : INTEGER   := 5);
    Port (  -- Global signals
            clk         : in    STD_LOGIC               := '1';
            resetn      : in    STD_LOGIC               := '1';
            -- Data flow signals
            new_pixel   : in    STD_LOGIC               := '0';
            valid_data  : in    STD_LOGIC               := '0';
            ctxt_idx    : in    UNSIGNED(8 downto 0)    := (others=>'0')
            );
end pipeline_module_2;

architecture Behavioral of pipeline_module_2 is
    -- Component declarations
    component context_modeller
        generic ( 
            data_width  :   integer := 8;
            k_width     :   integer := 5;       -- KUNNE DEN IKKE SÆTTES TIL ceil(log2(data_width-1))?
            n_size      :   integer := 7;       -- KUNNE DEN IKKE SÆTTES TIL ceil(log2(n_reset+1))?
            a_size      :   integer := 15;      -- KUNNE DEN IKKE SÆTTES TIL ceil(log2(n_reset*(2**(data_width-1))))?
            b_size      :   integer := 9;       -- I VÆRSTE FALD KUNNE DEN VEL SÆTTES TIL 1+ceil(log2(n_reset*(2**(data_width-1))))?
            c_size      :   integer := 8;       -- KUNNE DEN IKKE BARE ALTID SÆTTES TIL DATA_WIDTH?
            n_reset     :   integer := 64;
            min_c       :   integer := -128;    -- KUNNE VEL SÆTTES TIL -2**(c_size-1)?
            max_c       :   integer := 127;     -- KUNNE VEL SÆTTES TIL 2**(c_size-1)-1?
            no_contexts :   integer := 365;
            alpha       :   integer := 256      -- KUNNE VEL SÆTTES TIL 2**data_width?
            );
        Port (
            pclk :          in  STD_LOGIC;
            en   :          in  STD_LOGIC; 
            valid_data:     in  STD_LOGIC;
            idx :           in  STD_LOGIC_VECTOR    (integer(ceil(log2(real(no_contexts)))) - 1 downto 0);
            error :         in  signed              (data_width - 1 downto 0);
             
            error_bias :    out signed              (data_width - 1 downto 0);
            k :             out unsigned            (k_width - 1 downto 0));
    end component;
    
    -- Signal declarations
    
begin

    -- Component instantations
    ctxt_mdl: context_modeller
    generic map(
        data_width  => color_res,
        c_size      => color_res,
        min_c       => -2**(color_res-1),
        max_c       => 2**(color_res-1)-1,
        alpha       => 2**color_res
    )
    port map(
        pclk        => clk,
        en          => new_pixel,
        valid_data  => valid_data,
        idx         => ,
        error       =>
        error_bias  =>
        k           =>
    );

end Behavioral;
