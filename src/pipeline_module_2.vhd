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
    Generic (   color_res   : INTEGER   := 5;
                k_width     : INTEGER   := 5);
    Port (  -- Global signals
            clk         : in    STD_LOGIC                       := '1';
            resetn      : in    STD_LOGIC                       := '1';
            -- Input signals
            enable      : in    STD_LOGIC                       := '0';
            valid_data  : in    STD_LOGIC                       := '0';
            pixel       : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');
            prediction  : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');
            ctxt_idx    : in    UNSIGNED(8 downto 0)            := (others=>'0');
            sign        : in    STD_LOGIC                       := '0';
            -- Output signals
            k           : out   UNSIGNED(k_width-1 downto 0)    := (others=>'0');
            mapped_error: out   UNSIGNED(color_res-1 downto 0)  := (others=>'0')
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
             
            C :             out signed              (data_width - 1 downto 0);
            B :             out signed              (b_size - 1 downto 0);
            N :             out unsigned            (n_size - 1 downto 0);
            k :             out unsigned            (k_width - 1 downto 0));
    end component;
    
    component prediction_adder
        Generic(
            alpha           :   INTEGER := 256; -- KUNNE VEL BEREGNES UD FRA 'color_res' SOM 2**color_res?
            color_res       :   INTEGER := 8;
            n_size          :   integer := 7;
            a_size          :   integer := 15;
            b_size          :   integer := 9;
            c_size          :   integer := 8;
            k_size          :   integer := 5
        );
        Port ( 
            pclk            : in    STD_LOGIC;
            en              : in    STD_LOGIC;
            valid_data      : in    STD_LOGIC;
            sign_flag       : in    STD_LOGIC;
            pixel           : in    unsigned (color_res - 1 downto 0);
            fixed_pred      : in    unsigned (color_res - 1 downto 0);
            C               : in    signed (c_size - 1 downto 0);
            B               : in    signed (b_size - 1 downto 0);
            N               : in    unsigned (n_size - 1 downto 0);
            k               : in    unsigned (k_size -1 downto 0);
            error           : out   signed (color_res - 1 downto 0);
            mapped_error    : out   unsigned (color_res - 1 downto 0));
    end component;
    
    -- Constant declarations
    constant A_ctxt_size    : INTEGER   := 15;
    constant B_ctxt_size    : INTEGER   := 9;
    constant N_ctxt_size    : INTEGER   := 7;
    
    constant N_reset    : INTEGER   := 64;
    constant no_ctxt    : INTEGER   := 365;
    
    -- Signal declarations
    signal ctxt_idx_vec : STD_LOGIC_VECTOR(integer(ceil(log2(real(no_ctxt)))) - 1 downto 0) := (others=>'0');
    signal B_ctxt       : SIGNED(B_ctxt_size-1 downto 0)    := (others=>'0');
    signal C_ctxt       : SIGNED(color_res-1 downto 0)      := (others=>'0');
    signal N_ctxt       : UNSIGNED(N_ctxt_size-1 downto 0)  := (others=>'0');
    signal k_golomb     : UNSIGNED(k_width-1 downto 0)      := (others=>'0');
    
    signal pred_error   : SIGNED(color_res-1 downto 0)      := (others=>'0');
    
begin

    -- Component instantations
    ctxt_mdl: context_modeller
    generic map(
        data_width  => color_res,
        k_width     => k_width,
        n_size      => N_ctxt_size,
        a_size      => A_ctxt_size,
        b_size      => B_ctxt_size,
        c_size      => color_res,
        n_reset     => N_reset,
        min_c       => -2**(color_res-1),
        max_c       => 2**(color_res-1)-1,
        no_contexts => no_ctxt,
        alpha       => 2**color_res
    )
    port map(
        pclk        => clk,
        en          => enable,
        valid_data  => valid_data,
        idx         => ctxt_idx_vec,
        error       => pred_error,
        C           => C_ctxt,
        B           => B_ctxt,
        N           => N_ctxt,
        k           => k_golomb
    );
    
    
    adder: prediction_adder
    generic map(
        alpha       => 2**color_res,
        color_res   => color_res,
        n_size      => N_ctxt_size,
        a_size      => A_ctxt_size,
        b_size      => B_ctxt_size,
        c_size      => color_res,
        k_size      => k_width
    )
    port map(
        pclk            => clk,
        en              => enable,
        valid_data      => valid_data,
        sign_flag       => sign,
        pixel           => pixel,
        fixed_pred      => prediction,
        C               => C_ctxt,
        B               => B_ctxt,
        N               => N_ctxt,
        k               => k_golomb,
        error           => pred_error,
        mapped_error    => mapped_error
    );
    
    -- Signal assignments
    ctxt_idx_vec(ctxt_idx'high downto ctxt_idx'low) <= std_logic_vector(ctxt_idx);

end Behavioral;
