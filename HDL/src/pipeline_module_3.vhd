----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2023 02:14:47 PM
-- Design Name: 
-- Module Name: pipeline_module_3 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pipeline_module_3 is
    Generic(    color_res   : INTEGER   := 5;   -- Number of bits associated with the color
                N_reset     : INTEGER   := 64;  -- Reset level for the contexts
                N_size      : INTEGER   := 7;   -- Set to at least ceil(log2(N_reset+1))
                A_size      : INTEGER   := 11;  -- Set to at least ceil(log2(N_reset) + color_res - 1)
                B_size      : INTEGER   := 12;  -- Set to at least 1 + ceil(log2(N_reset) + color_res - 1)
                C_size      : INTEGER   := 5;   -- Should be the same as 'color_res'
                k_width     : INTEGER   := 5
                );
    Port (  -- Inputs
                -- Pixel data
            pixel           : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');
            prediction      : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');
            valid_data_in   : in    STD_LOGIC                       := '0';
                -- Context data
            ctxt_idx    : in    UNSIGNED(8 downto 0)            := (others=>'0');
            sign        : in    STD_LOGIC                       := '0';
            N_current   : in    UNSIGNED(N_size-1 downto 0)     := (others=>'0');
            A_current   : in    UNSIGNED(A_size-1 downto 0)     := (others=>'0');
            B_current   : in    SIGNED(B_size-1 downto 0)       := (others=>'0');
            C_current   : in    SIGNED(C_size-1 downto 0)       := (others=>'0');
            -- Outputs
            ctxt_idx_update : out   UNSIGNED(8 downto 0)            := (others=>'0');
            N_update        : out   UNSIGNED(N_size-1 downto 0)     := (others=>'0');
            A_update        : out   UNSIGNED(A_size-1 downto 0)     := (others=>'0');
            B_update        : out   SIGNED(B_size-1 downto 0)       := (others=>'0');
            C_update        : out   SIGNED(C_size-1 downto 0)       := (others=>'0');
            k               : out   UNSIGNED(k_width-1 downto 0)    := (others=>'0');
            valid_data_out  : out   STD_LOGIC                       := '0';
            error           : out   SIGNED(color_res-1 downto 0)    := (others=>'0')
            );
end pipeline_module_3;

architecture Behavioral of pipeline_module_3 is
    -- Component declarations
    component context_updater
        Generic(    color_res   : INTEGER   := 5;   -- Number of bits associated with the color
                    N_reset     : INTEGER   := 64;
                    N_size      : INTEGER   := 7;   -- Set to at least ceil(log2(N_reset+1))
                    A_size      : INTEGER   := 11;  -- Set to at least ceil(log2(N_reset) + color_res - 1)
                    B_size      : INTEGER   := 12;  -- Set to at least 1 + ceil(log2(N_reset) + color_res - 1)
                    C_size      : INTEGER   := 5    -- Should be the same as 'color_res'
                    );
        Port (  -- Inputs
                valid_data_in   : in    STD_LOGIC   := '0';
                    -- Context data
                ctxt_idx    : in    UNSIGNED(8 downto 0)            := (others=>'0');
                N_current   : in    UNSIGNED(N_size-1 downto 0)     := (others=>'0');
                A_current   : in    UNSIGNED(A_size-1 downto 0)     := (others=>'0');
                B_current   : in    SIGNED(b_size-1 downto 0)       := (others=>'0');
                C_current   : in    SIGNED(c_size-1 downto 0)       := (others=>'0');
                    -- Algorithm data
                error       : in    SIGNED(color_res-1 downto 0)    := (others=>'0');
                -- Outputs
                valid_data_out  : out   STD_LOGIC                   := '0';
                ctxt_idx_update : out   UNSIGNED(8 downto 0)        := (others=>'0');
                N_update        : out   UNSIGNED(N_size-1 downto 0) := (others=>'0');
                A_update        : out   UNSIGNED(A_size-1 downto 0) := (others=>'0');
                B_update        : out   SIGNED(B_size-1 downto 0)   := (others=>'0');
                C_update        : out   SIGNED(C_size-1 downto 0)   := (others=>'0')
                );
    end component;
    
    component prediction_adder
        Generic (   color_res   : INTEGER   := 5;   -- Number of bits for the given color
                    C_size      : INTEGER   := 5    -- Should be the same as 'color_res'
                    );
        Port (  -- Inputs
                    -- Pixel data
                pixel       : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');
                fixed_pred  : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');
                    -- Context data
                sign        : in    STD_LOGIC                       := '0';
                C           : in    SIGNED(C_size-1 downto 0)       := (others=>'0');
                    -- Output
                error       : out   SIGNED(color_res-1 downto 0)    := (others=>'0')
                );
    end component;
    
    component k_calculator
        Generic(    N_size          : INTEGER   := 7;   -- Set to at least ceil(log2(N_reset+1))
                    A_size          : INTEGER   := 11;  -- Set to at least ceil(log2(N_reset) + color_res - 1)
                    k_width         : INTEGER   := 5
                    );
        Port (  -- Context data
                N   : in    UNSIGNED(N_size-1 downto 0)     := (others=>'0');
                A   : in    UNSIGNED(A_size-1 downto 0)     := (others=>'0');
                -- Output
                k   : out   UNSIGNED(k_width-1 downto 0)    := (others=>'0')
                );
    end component;

    -- Signal declarations
    signal prediction_error : SIGNED(color_res-1 downto 0)  := (others=>'0');
    
begin

    -- Component instantiations
    ctxt_update: context_updater
    generic map(
        color_res   => color_res,
        N_reset     => N_reset,
        N_size      => N_size,
        A_size      => A_size,
        B_size      => B_size,
        C_size      => C_size
    )
    port map(
        valid_data_in   => valid_data_in,
        ctxt_idx        => ctxt_idx,
        N_current       => N_current,
        A_current       => A_current,
        B_current       => B_current,
        C_current       => C_current,
        error           => prediction_error,
        valid_data_out  => valid_data_out,
        ctxt_idx_update => ctxt_idx_update,
        N_update        => N_update,
        A_update        => A_update,
        B_update        => B_update,
        C_update        => C_update
    );
    
    error_calc: prediction_adder
    generic map(
        color_res   => color_res,
        C_size      => C_size
    )
    port map(
        pixel       => pixel,
        fixed_pred  => prediction,
        sign        => sign,
        C           => C_current,
        error       => prediction_error
    );
    
    k_calc: k_calculator
    generic map(
        N_size  => N_size,
        A_size  => A_size,
        k_width => k_width
    )
    port map(
        N   => N_current,
        A   => A_current,
        k   => k
    );
    
    -- Signal assignments
    error <= prediction_error;

end Behavioral;
