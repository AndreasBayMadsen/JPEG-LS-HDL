----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2023 04:12:26 PM
-- Design Name: 
-- Module Name: JPEG_LS_module - Behavioral
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
use IEEE.MATH_REAL.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity JPEG_LS_module is
    Generic (   image_height    : INTEGER   := 512;     -- Image dimensions in number of pixels
                image_width     : INTEGER   := 768;
                L_max_r         : INTEGER   := 20;      -- Maximum code size per pixel
                L_max_g         : INTEGER   := 24;
                L_max_b         : INTEGER   := 20;
                k_width_r       : INTEGER   := 5;       -- TODO: k_width should be calculated from color_res instead.
                k_width_g       : INTEGER   := 5;
                k_width_b       : INTEGER   := 5;
                fps_downscale   : INTEGER   := 1
                );
    Port (  resetn  : in    STD_LOGIC                       := '1';             -- Active LOW reset signal
            -- Camera interface
            pclk    : in    STD_LOGIC                       := '1';             -- Pixel clock
            pixel   : in    STD_LOGIC_VECTOR(7 downto 0)    := (others=>'0');   -- Parallel bus for pixel data
            href    : in    STD_LOGIC                       := '0';             -- Row synchronization signal
            vsync   : in    STD_LOGIC                       := '0';             -- Frame synchronization signal
            -- Output
            new_pixel       : out   STD_LOGIC                           := '0';
            valid_data      : out   STD_LOGIC                           := '0';
            encoded_r       : out STD_LOGIC_VECTOR(L_max_r-1 downto 0)    := (others=>'0');
            encoded_g       : out STD_LOGIC_VECTOR(L_max_g-1 downto 0)    := (others=>'0');
            encoded_b       : out STD_LOGIC_VECTOR(L_max_b-1 downto 0)    := (others=>'0');
            encoded_size_r  : out STD_LOGIC_VECTOR(k_width_r downto 0)    := (others=>'0');
            encoded_size_g  : out STD_LOGIC_VECTOR(k_width_g downto 0)    := (others=>'0');
            encoded_size_b  : out STD_LOGIC_VECTOR(k_width_b downto 0)    := (others=>'0')
            );
end JPEG_LS_module;

architecture Behavioral of JPEG_LS_module is
    -- Component declarations
    component collector
        Generic (
            image_height    : INTEGER                   := 500;
            image_width     : INTEGER                   := 500;
            fps_downscale   : INTEGER range 1 to 255    := 1
        );
        Port (
            resetn  : in    STD_LOGIC               := '1';
            -- Camera interface
            pclk    : in    STD_LOGIC               := '0';
            pixel   : in    UNSIGNED(7 downto 0)    := (others=>'0');
            href    : in    STD_LOGIC               := '0';
            vsync   : in    STD_LOGIC               := '0';
            -- Output interface
            A           : out   UNSIGNED(15 downto 0)   := (others=>'0');
            B           : out   UNSIGNED(15 downto 0)   := (others=>'0');
            C           : out   UNSIGNED(15 downto 0)   := (others=>'0');
            D           : out   UNSIGNED(15 downto 0)   := (others=>'0');
            X           : out   UNSIGNED(15 downto 0)   := (others=>'0');
            valid_data  : out   STD_LOGIC               := '0'; -- Is high while a frame is being transmitted
            new_pixel   : out   STD_LOGIC               := '0'  -- Pulses for each new pixel (to drive pipeline)
            );
    end component;
    
    component pipeline_module_1
        Generic (   color_res   : INTEGER   := 5);      -- Number of bits for the color
        Port (  -- Global signals
                clk         : in    STD_LOGIC                       := '1';
                resetn      : in    STD_LOGIC                       := '1';
                -- Inputs
                A           : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');   -- Pixels surrounding X
                B           : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');
                C           : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');
                D           : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');
                -- Outputs
                ctxt_idx    : out   UNSIGNED(8 downto 0)            := (others=>'0');   -- Index of current context
                sign        : out   STD_LOGIC                       := '0';
                X_pred      : out   UNSIGNED(color_res-1 downto 0)  := (others=>'0')    -- Prediction of X
                );
    end component;
    
    component context_modeller
        Generic (   color_res       : INTEGER   := 5;   -- Number of bits associated with the color
                    N_size          : INTEGER   := 7;   -- Set to at least ceil(log2(N_reset+1))
                    A_size          : INTEGER   := 11;  -- Set to at least ceil(log2(N_reset) + color_res - 1)
                    B_size          : INTEGER   := 12;  -- Set to at least 1 + ceil(log2(N_reset) + color_res - 1)
                    C_size          : INTEGER   := 5;   -- Should be the same as 'color_res'
                    num_contexts    : INTEGER   := 365  -- Number of contexts to manage
                    );
        Port (  -- Global signals
                clk         : in    STD_LOGIC   := '1';
                resetn      : in    STD_LOGIC   := '1';
                -- Read port
                ctxt_idx    : in    UNSIGNED(8 downto 0)        := (others=>'0');
                N_current   : out   UNSIGNED(N_size-1 downto 0) := (others=>'0');
                A_current   : out   UNSIGNED(A_size-1 downto 0) := (others=>'0');
                B_current   : out   SIGNED(b_size-1 downto 0)   := (others=>'0');
                C_current   : out   SIGNED(c_size-1 downto 0)   := (others=>'0');
                -- Write port
                en                  : in    STD_LOGIC                   := '0';
                valid_data          : in    STD_LOGIC                   := '0';
                valid_update_data   : in    STD_LOGIC                   := '0';     -- States whether the data to update is valid
                ctxt_idx_update     : in    UNSIGNED(8 downto 0)        := (others=>'0');
                N_update            : in    UNSIGNED(N_size-1 downto 0) := (others=>'0');
                A_update            : in    UNSIGNED(A_size-1 downto 0) := (others=>'0');
                B_update            : in    SIGNED(B_size-1 downto 0)   := (others=>'0');
                C_update            : in    SIGNED(C_size-1 downto 0)   := (others=>'0')
                );
    end component;
    
    component pipeline_module_3
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
    end component;
    
    component pipeline_module_4
        Generic (   color_res   : INTEGER   := 5;   -- Number of bits associated with the color
                    N_size      : INTEGER   := 7;
                    B_size      : INTEGER   := 5;
                    k_width     : INTEGER   := 5;
                    L_max       : INTEGER   := 32   -- Maximum allowable code length
                );
        Port (  -- Inputs
                k               : in    UNSIGNED(k_width-1 downto 0)        := (others=>'0');
                error           : in    SIGNED(color_res-1 downto 0)        := (others=>'0');
                    -- Context data
                N               : in    UNSIGNED(N_size-1 downto 0)         := (others=>'0');
                B               : in    SIGNED(B_size-1 downto 0)           := (others=>'0');
                -- Outputs
                encoded         : out STD_LOGIC_VECTOR (L_max - 1 downto 0) := (others=>'0');
                size            : out UNSIGNED(k_width downto 0)            := (others=>'0')
                );
    end component;
    
    -- Constant declarations
        -- Color space
    constant R_size     : INTEGER   := 5;   -- Number of bits per color
    constant G_size     : INTEGER   := 6;
    constant B_size     : INTEGER   := 5;
    
        -- Context modeller
    constant N_reset        : INTEGER   := 64;
    constant N_size         : INTEGER   := 7;
    constant A_size_r       : INTEGER   := 15;
    constant A_size_g       : INTEGER   := 15;
    constant A_size_b       : INTEGER   := 15;
    constant B_size_r       : INTEGER   := 9;
    constant B_size_g       : INTEGER   := 9;
    constant B_size_b       : INTEGER   := 9;
    constant C_size_r       : INTEGER   := R_size;
    constant C_size_g       : INTEGER   := G_size;
    constant C_size_b       : INTEGER   := B_size;
    constant num_contexts   : INTEGER   := 365;
    
    -- Signal declarations
        -- PIPELINE REGION 1 - Collector, gradient and fixed predictor
    signal pixel_uns    : UNSIGNED(7 downto 0)          := (others=>'0');   -- Unsigned version of the 'pixel' input signal
    signal A            : UNSIGNED(15 downto 0)         := (others=>'0');
    signal B            : UNSIGNED(15 downto 0)         := (others=>'0');
    signal C            : UNSIGNED(15 downto 0)         := (others=>'0');
    signal D            : UNSIGNED(15 downto 0)         := (others=>'0');
    signal X            : UNSIGNED(15 downto 0)         := (others=>'0');
    signal valid_data_1 : STD_LOGIC                     := '0';
    signal new_pixel_1  : STD_LOGIC                     := '0';
    
    signal ctxt_idx_r_1 : UNSIGNED(8 downto 0)          := (others=>'0');
    signal ctxt_idx_g_1 : UNSIGNED(8 downto 0)          := (others=>'0');
    signal ctxt_idx_b_1 : UNSIGNED(8 downto 0)          := (others=>'0');
    signal sign_r_1     : STD_LOGIC                     := '0';
    signal sign_g_1     : STD_LOGIC                     := '0';
    signal sign_b_1     : STD_LOGIC                     := '0';
    signal X_pred_r_1   : UNSIGNED(R_size-1 downto 0)   := (others=>'0');
    signal X_pred_g_1   : UNSIGNED(G_size-1 downto 0)   := (others=>'0');
    signal X_pred_b_1   : UNSIGNED(B_size-1 downto 0)   := (others=>'0');
    signal A_r          : UNSIGNED(R_size-1 downto 0)   := (others=>'0');
    signal A_g          : UNSIGNED(G_size-1 downto 0)   := (others=>'0');
    signal A_b          : UNSIGNED(B_size-1 downto 0)   := (others=>'0');
    signal B_r          : UNSIGNED(R_size-1 downto 0)   := (others=>'0');
    signal B_g          : UNSIGNED(G_size-1 downto 0)   := (others=>'0');
    signal B_b          : UNSIGNED(B_size-1 downto 0)   := (others=>'0');
    signal C_r          : UNSIGNED(R_size-1 downto 0)   := (others=>'0');
    signal C_g          : UNSIGNED(G_size-1 downto 0)   := (others=>'0');
    signal C_b          : UNSIGNED(B_size-1 downto 0)   := (others=>'0');
    signal D_r          : UNSIGNED(R_size-1 downto 0)   := (others=>'0');
    signal D_g          : UNSIGNED(G_size-1 downto 0)   := (others=>'0');
    signal D_b          : UNSIGNED(B_size-1 downto 0)   := (others=>'0');
    signal X_r_1        : UNSIGNED(R_size-1 downto 0)   := (others=>'0');
    signal X_g_1        : UNSIGNED(G_size-1 downto 0)   := (others=>'0');
    signal X_b_1        : UNSIGNED(B_size-1 downto 0)   := (others=>'0');
    
        -- PIPELINE REGION 2 - Context modeller
    signal valid_data_2     : STD_LOGIC                     := '0';
    signal new_pixel_2_buf  : STD_LOGIC                     := '0';
    signal new_pixel_2      : STD_LOGIC                     := '0';
    signal X_r_2            : UNSIGNED(R_size-1 downto 0)   := (others=>'0');
    signal X_g_2            : UNSIGNED(G_size-1 downto 0)   := (others=>'0');
    signal X_b_2            : UNSIGNED(B_size-1 downto 0)   := (others=>'0');
    signal X_pred_r_2       : UNSIGNED(R_size-1 downto 0)   := (others=>'0');
    signal X_pred_g_2       : UNSIGNED(G_size-1 downto 0)   := (others=>'0');
    signal X_pred_b_2       : UNSIGNED(B_size-1 downto 0)   := (others=>'0');
    signal ctxt_idx_r_2     : UNSIGNED(8 downto 0)          := (others=>'0');
    signal ctxt_idx_g_2     : UNSIGNED(8 downto 0)          := (others=>'0');
    signal ctxt_idx_b_2     : UNSIGNED(8 downto 0)          := (others=>'0');
    signal sign_r_2         : STD_LOGIC                     := '0';
    signal sign_g_2         : STD_LOGIC                     := '0';
    signal sign_b_2         : STD_LOGIC                     := '0';
    signal N_current_r_2    : UNSIGNED(N_size-1 downto 0)   := (others=>'0');
    signal N_current_g_2    : UNSIGNED(N_size-1 downto 0)   := (others=>'0');
    signal N_current_b_2    : UNSIGNED(N_size-1 downto 0)   := (others=>'0');
    signal A_current_r_2    : UNSIGNED(A_size_r-1 downto 0) := (others=>'0');
    signal A_current_g_2    : UNSIGNED(A_size_g-1 downto 0) := (others=>'0');
    signal A_current_b_2    : UNSIGNED(A_size_b-1 downto 0) := (others=>'0');
    signal B_current_r_2    : SIGNED(B_size_r-1 downto 0)   := (others=>'0');
    signal B_current_g_2    : SIGNED(B_size_g-1 downto 0)   := (others=>'0');
    signal B_current_b_2    : SIGNED(B_size_b-1 downto 0)   := (others=>'0');
    signal C_current_r_2    : SIGNED(C_size_r-1 downto 0)   := (others=>'0');
    signal C_current_g_2    : SIGNED(C_size_g-1 downto 0)   := (others=>'0');
    signal C_current_b_2    : SIGNED(C_size_b-1 downto 0)   := (others=>'0');
    signal N_update_r_32    : UNSIGNED(N_size-1 downto 0)   := (others=>'0');
    signal N_update_g_32    : UNSIGNED(N_size-1 downto 0)   := (others=>'0');
    signal N_update_b_32    : UNSIGNED(N_size-1 downto 0)   := (others=>'0');
    signal A_update_r_32    : UNSIGNED(A_size_r-1 downto 0) := (others=>'0');
    signal A_update_g_32    : UNSIGNED(A_size_g-1 downto 0) := (others=>'0');
    signal A_update_b_32    : UNSIGNED(A_size_b-1 downto 0) := (others=>'0');
    signal B_update_r_32    : SIGNED(B_size_r-1 downto 0)   := (others=>'0');
    signal B_update_g_32    : SIGNED(B_size_g-1 downto 0)   := (others=>'0');
    signal B_update_b_32    : SIGNED(B_size_b-1 downto 0)   := (others=>'0');
    signal C_update_r_32    : SIGNED(C_size_r-1 downto 0)   := (others=>'0');
    signal C_update_g_32    : SIGNED(C_size_g-1 downto 0)   := (others=>'0');
    signal C_update_b_32    : SIGNED(C_size_b-1 downto 0)   := (others=>'0');
    
        -- PIPELINE REGION 3 - Context update and encoding parameter calculation
    signal valid_data_3     : STD_LOGIC                     := '0';
    signal new_pixel_3_buf  : STD_LOGIC                     := '0';
    signal new_pixel_3      : STD_LOGIC                     := '0';
    signal valid_data_32_r  : STD_LOGIC                     := '0';
    signal valid_data_32_g  : STD_LOGIC                     := '0';
    signal valid_data_32_b  : STD_LOGIC                     := '0';
    signal X_r_3            : UNSIGNED(R_size-1 downto 0)   := (others=>'0');
    signal X_g_3            : UNSIGNED(G_size-1 downto 0)   := (others=>'0');
    signal X_b_3            : UNSIGNED(B_size-1 downto 0)   := (others=>'0');
    signal X_pred_r_3       : UNSIGNED(R_size-1 downto 0)   := (others=>'0');
    signal X_pred_g_3       : UNSIGNED(G_size-1 downto 0)   := (others=>'0');
    signal X_pred_b_3       : UNSIGNED(B_size-1 downto 0)   := (others=>'0');
    signal ctxt_idx_r_3     : UNSIGNED(8 downto 0)          := (others=>'0');
    signal ctxt_idx_g_3     : UNSIGNED(8 downto 0)          := (others=>'0');
    signal ctxt_idx_b_3     : UNSIGNED(8 downto 0)          := (others=>'0');
    signal sign_r_3         : STD_LOGIC                     := '0';
    signal sign_g_3         : STD_LOGIC                     := '0';
    signal sign_b_3         : STD_LOGIC                     := '0';
    signal N_current_r_3    : UNSIGNED(N_size-1 downto 0)   := (others=>'0');
    signal N_current_g_3    : UNSIGNED(N_size-1 downto 0)   := (others=>'0');
    signal N_current_b_3    : UNSIGNED(N_size-1 downto 0)   := (others=>'0');
    signal A_current_r_3    : UNSIGNED(A_size_r-1 downto 0) := (others=>'0');
    signal A_current_g_3    : UNSIGNED(A_size_g-1 downto 0) := (others=>'0');
    signal A_current_b_3    : UNSIGNED(A_size_b-1 downto 0) := (others=>'0');
    signal B_current_r_3    : SIGNED(B_size_r-1 downto 0)   := (others=>'0');
    signal B_current_g_3    : SIGNED(B_size_g-1 downto 0)   := (others=>'0');
    signal B_current_b_3    : SIGNED(B_size_b-1 downto 0)   := (others=>'0');
    signal C_current_r_3    : SIGNED(C_size_r-1 downto 0)   := (others=>'0');
    signal C_current_g_3    : SIGNED(C_size_g-1 downto 0)   := (others=>'0');
    signal C_current_b_3    : SIGNED(C_size_b-1 downto 0)   := (others=>'0');
    signal ctxt_idx_update_32_r : UNSIGNED(8 downto 0)      := (others=>'0');
    signal ctxt_idx_update_32_g : UNSIGNED(8 downto 0)      := (others=>'0');
    signal ctxt_idx_update_32_b : UNSIGNED(8 downto 0)      := (others=>'0');
    signal k_r_3            : UNSIGNED(k_width_r-1 downto 0)    := (others=>'0');
    signal k_g_3            : UNSIGNED(k_width_g-1 downto 0)    := (others=>'0');
    signal k_b_3            : UNSIGNED(k_width_b-1 downto 0)    := (others=>'0');
    signal pred_error_r_3   : SIGNED(R_size-1 downto 0)     := (others=>'0');
    signal pred_error_g_3   : SIGNED(G_size-1 downto 0)     := (others=>'0');
    signal pred_error_b_3   : SIGNED(B_size-1 downto 0)     := (others=>'0');
    
        -- PIPELINE REGION 4 - Error mapper and Golomb coder
    signal valid_data_4     : STD_LOGIC := '0';
    signal new_pixel_4_buf  : STD_LOGIC := '0';
    signal new_pixel_4      : STD_LOGIC := '0';
    signal k_r_4            : UNSIGNED(k_width_r-1 downto 0)        := (others=>'0');
    signal k_g_4            : UNSIGNED(k_width_g-1 downto 0)        := (others=>'0');
    signal k_b_4            : UNSIGNED(k_width_b-1 downto 0)        := (others=>'0');
    signal pred_error_r_4   : SIGNED(R_size-1 downto 0)             := (others=>'0');
    signal pred_error_g_4   : SIGNED(G_size-1 downto 0)             := (others=>'0');
    signal pred_error_b_4   : SIGNED(B_size-1 downto 0)             := (others=>'0');
    signal N_r_4            : UNSIGNED(N_size-1 downto 0)           := (others=>'0');
    signal N_g_4            : UNSIGNED(N_size-1 downto 0)           := (others=>'0');
    signal N_b_4            : UNSIGNED(N_size-1 downto 0)           := (others=>'0');
    signal B_r_4            : SIGNED(B_size_r-1 downto 0)           := (others=>'0');
    signal B_g_4            : SIGNED(B_size_g-1 downto 0)           := (others=>'0');
    signal B_b_4            : SIGNED(B_size_b-1 downto 0)           := (others=>'0');
    signal encoded_r_4      : STD_LOGIC_VECTOR(L_max_r-1 downto 0)  := (others=>'0');
    signal encoded_g_4      : STD_LOGIC_VECTOR(L_max_g-1 downto 0)  := (others=>'0');
    signal encoded_b_4      : STD_LOGIC_VECTOR(L_max_b-1 downto 0)  := (others=>'0');
    signal encoded_size_r_4 : UNSIGNED(k_width_r downto 0)          := (others=>'0');
    signal encoded_size_g_4 : UNSIGNED(k_width_g downto 0)          := (others=>'0');
    signal encoded_size_b_4 : UNSIGNED(k_width_b downto 0)          := (others=>'0');
    
        -- PIPELINE REGION 5 - Output
    signal valid_data_5     : STD_LOGIC := '0';
    signal new_pixel_5_buf  : STD_LOGIC := '0';
    signal new_pixel_5      : STD_LOGIC := '0';
    signal encoded_r_5      : STD_LOGIC_VECTOR(L_max_r-1 downto 0)  := (others=>'0');
    signal encoded_g_5      : STD_LOGIC_VECTOR(L_max_g-1 downto 0)  := (others=>'0');
    signal encoded_b_5      : STD_LOGIC_VECTOR(L_max_b-1 downto 0)  := (others=>'0');
    signal encoded_size_r_5 : UNSIGNED(k_width_r downto 0)          := (others=>'0');
    signal encoded_size_g_5 : UNSIGNED(k_width_g downto 0)          := (others=>'0');
    signal encoded_size_b_5 : UNSIGNED(k_width_b downto 0)          := (others=>'0');
    
begin

    -- PIPELINE REGION 1 - Collector, gradient and fixed predictor
        -- Component instantiations
    pixel_collector: collector  -- Collector for incoming pixels
    generic map(
        image_height    => image_height,
        image_width     => image_width,
        fps_downscale   => fps_downscale
        
    )
    port map(
        resetn      => resetn,
        pclk        => pclk,
        pixel       => pixel_uns,
        href        => href,
        vsync       => vsync,
        A           => A,
        B           => B,
        C           => C,
        D           => D,
        X           => X,
        valid_data  => valid_data_1,
        new_pixel   => new_pixel_1
    );
    
    mod_1_r: pipeline_module_1  -- Pipeline module 1 for red color
    generic map(
        color_res   => R_size
    )
    port map(
        clk         => pclk,
        resetn      => resetn,
        A           => A_r,
        B           => B_r,
        C           => C_r,
        D           => D_r,
        ctxt_idx    => ctxt_idx_r_1,
        sign        => sign_r_1,
        X_pred      => X_pred_r_1
    );
    
    mod_1_g: pipeline_module_1  -- Pipeline module 1 for green color
    generic map(
        color_res   => G_size
    )
    port map(
        clk         => pclk,
        resetn      => resetn,
        A           => A_g,
        B           => B_g,
        C           => C_g,
        D           => D_g,
        ctxt_idx    => ctxt_idx_g_1,
        sign        => sign_g_1,
        X_pred      => X_pred_g_1
    );
    
    mod_1_b: pipeline_module_1  -- Pipeline module 1 for blue color
    generic map(
        color_res   => B_size
    )
    port map(
        clk         => pclk,
        resetn      => resetn,
        A           => A_b,
        B           => B_b,
        C           => C_b,
        D           => D_b,
        ctxt_idx    => ctxt_idx_b_1,
        sign        => sign_b_1,
        X_pred      => X_pred_b_1
    );

    -- Signal assignments
    pixel_uns   <= unsigned(pixel);
    A_r         <= A(15 downto 11);
    A_g         <= A(10 downto 5);
    A_b         <= A(4 downto 0);
    B_r         <= B(15 downto 11);
    B_g         <= B(10 downto 5);
    B_b         <= B(4 downto 0);
    C_r         <= C(15 downto 11);
    C_g         <= C(10 downto 5);
    C_b         <= C(4 downto 0);
    D_r         <= D(15 downto 11);
    D_g         <= D(10 downto 5);
    D_b         <= D(4 downto 0);
    X_r_1       <= X(15 downto 11);
    X_g_1       <= X(10 downto 5);
    X_b_1       <= X(4 downto 0);
    
    -- Pipeline register 1
    pipeline_register_1: process(pclk)
    begin
        if rising_edge(pclk) then
            if resetn = '0' then
                -- Synchronous reset
                valid_data_2    <= '0';
                X_r_2           <= (others=>'0');
                X_g_2           <= (others=>'0');
                X_b_2           <= (others=>'0');
                X_pred_r_2      <= (others=>'0');
                X_pred_g_2      <= (others=>'0');
                X_pred_b_2      <= (others=>'0');
                ctxt_idx_r_2    <= (others=>'0');
                ctxt_idx_g_2    <= (others=>'0');
                ctxt_idx_b_2    <= (others=>'0');
                sign_r_2        <= '0';
                sign_g_2        <= '0';
                sign_b_2        <= '0';
                new_pixel_2_buf <= '0';
                new_pixel_2     <= '0';
            else
                -- Propagate data
                if new_pixel_1 = '1' then
                    valid_data_2    <= valid_data_1;
                    X_r_2           <= X_r_1;
                    X_g_2           <= X_g_1;
                    X_b_2           <= X_b_1;
                    X_pred_r_2      <= X_pred_r_1;
                    X_pred_g_2      <= X_pred_g_1;
                    X_pred_b_2      <= X_pred_b_1;
                    ctxt_idx_r_2    <= ctxt_idx_r_1;
                    ctxt_idx_g_2    <= ctxt_idx_g_1;
                    ctxt_idx_b_2    <= ctxt_idx_b_1;
                    sign_r_2        <= sign_r_1;
                    sign_g_2        <= sign_g_1;
                    sign_b_2        <= sign_b_1;
                end if;
                
                -- Propagate 'new_pixel'
                new_pixel_2_buf <= new_pixel_1;
                new_pixel_2     <= new_pixel_2_buf;
            end if;
        end if;
    end process;
    
    -- PIPELINE REGION 2 - Context modeller
        -- Component instantiations            
    ctxt_mdl_r: context_modeller
    generic map(
        color_res       => R_size,
        N_size          => N_size,
        A_size          => A_size_r,
        B_size          => B_size_r,
        C_size          => C_size_r,
        num_contexts    => num_contexts
    )
    port map(
        clk                 => pclk,
        resetn              => resetn,
        ctxt_idx            => ctxt_idx_r_2,
        N_current           => N_current_r_2,
        A_current           => A_current_r_2,
        B_current           => B_current_r_2,
        C_current           => C_current_r_2,
        en                  => new_pixel_2,
        valid_data          => valid_data_2,
        valid_update_data   => valid_data_32_r,
        ctxt_idx_update     => ctxt_idx_update_32_r,
        N_update            => N_update_r_32,
        A_update            => A_update_r_32,
        B_update            => B_update_r_32,
        C_update            => C_update_r_32
    );
    
    ctxt_mdl_g: context_modeller
    generic map(
        color_res       => G_size,
        N_size          => N_size,
        A_size          => A_size_g,
        B_size          => B_size_g,
        C_size          => C_size_g,
        num_contexts    => num_contexts
    )
    port map(
        clk                 => pclk,
        resetn              => resetn,
        ctxt_idx            => ctxt_idx_g_2,
        N_current           => N_current_g_2,
        A_current           => A_current_g_2,
        B_current           => B_current_g_2,
        C_current           => C_current_g_2,
        en                  => new_pixel_2,
        valid_data          => valid_data_2,
        valid_update_data   => valid_data_32_g,
        ctxt_idx_update     => ctxt_idx_update_32_g,
        N_update            => N_update_g_32,
        A_update            => A_update_g_32,
        B_update            => B_update_g_32,
        C_update            => C_update_g_32
    );
    
    ctxt_mdl_b: context_modeller
    generic map(
        color_res       => B_size,
        N_size          => N_size,
        A_size          => A_size_b,
        B_size          => B_size_b,
        C_size          => C_size_b,
        num_contexts    => num_contexts
    )
    port map(
        clk                 => pclk,
        resetn              => resetn,
        ctxt_idx            => ctxt_idx_b_2,
        N_current           => N_current_b_2,
        A_current           => A_current_b_2,
        B_current           => B_current_b_2,
        C_current           => C_current_b_2,
        en                  => new_pixel_2,
        valid_data          => valid_data_2,
        valid_update_data   => valid_data_32_b,
        ctxt_idx_update     => ctxt_idx_update_32_b,
        N_update            => N_update_b_32,
        A_update            => A_update_b_32,
        B_update            => B_update_b_32,
        C_update            => C_update_b_32
    );
    
    -- Pipeline register 2
    pipeline_register_2: process(pclk)
    begin
        if rising_edge(pclk) then
            if resetn = '0' then
                -- Synchronous reset
                valid_data_3    <= '0';
                X_r_3           <= (others=>'0');
                X_g_3           <= (others=>'0');
                X_b_3           <= (others=>'0');
                X_pred_r_3      <= (others=>'0');
                X_pred_g_3      <= (others=>'0');
                X_pred_b_3      <= (others=>'0');
                ctxt_idx_r_3    <= (others=>'0');
                ctxt_idx_g_3    <= (others=>'0');
                ctxt_idx_b_3    <= (others=>'0');
                sign_r_3        <= '0';
                sign_g_3        <= '0';
                sign_b_3        <= '0';
                N_current_r_3   <= (others=>'0');
                N_current_g_3   <= (others=>'0');
                N_current_b_3   <= (others=>'0');
                A_current_r_3   <= (others=>'0');
                A_current_g_3   <= (others=>'0');
                A_current_b_3   <= (others=>'0');
                B_current_r_3   <= (others=>'0');
                B_current_g_3   <= (others=>'0');
                B_current_b_3   <= (others=>'0');
                C_current_r_3   <= (others=>'0');
                C_current_g_3   <= (others=>'0');
                C_current_b_3   <= (others=>'0');
                new_pixel_3_buf <= '0';
                new_pixel_3     <= '0';
            else
                -- Propagate data
                if new_pixel_2 = '1' then
                    valid_data_3    <= valid_data_2;
                    X_r_3           <= X_r_2;
                    X_g_3           <= X_g_2;
                    X_b_3           <= X_b_2;
                    X_pred_r_3      <= X_pred_r_2;
                    X_pred_g_3      <= X_pred_g_2;
                    X_pred_b_3      <= X_pred_b_2;
                    ctxt_idx_r_3    <= ctxt_idx_r_2;
                    ctxt_idx_g_3    <= ctxt_idx_g_2;
                    ctxt_idx_b_3    <= ctxt_idx_b_2;
                    sign_r_3        <= sign_r_2;
                    sign_g_3        <= sign_g_2;
                    sign_b_3        <= sign_b_2;
                    N_current_r_3   <= N_current_r_2;
                    N_current_g_3   <= N_current_g_2; 
                    N_current_b_3   <= N_current_b_2;
                    A_current_r_3   <= A_current_r_2;
                    A_current_g_3   <= A_current_g_2;
                    A_current_b_3   <= A_current_b_2;
                    B_current_r_3   <= B_current_r_2;
                    B_current_g_3   <= B_current_g_2;
                    B_current_b_3   <= B_current_b_2;
                    C_current_r_3   <= C_current_r_2;
                    C_current_g_3   <= C_current_g_2;
                    C_current_b_3   <= C_current_b_2;
                end if;
                
                -- Propagate 'new_pixel'
                new_pixel_3_buf <= new_pixel_2;
                new_pixel_3     <= new_pixel_3_buf;
            end if;
        end if;
    end process;
    
    -- PIPELINE REGION 3 - Context update, error calculation and encoding parameter calculation
        -- Component instantiations
    mod_3_r: pipeline_module_3
    generic map(
        color_res   => R_size,
        N_reset     => N_reset,
        N_size      => N_size,
        A_size      => A_size_r,
        B_size      => B_size_r,
        C_size      => C_size_r,
        k_width     => k_width_r
    )
    port map(
        pixel           => X_r_3,
        prediction      => X_pred_r_3,
        valid_data_in   => valid_data_3,
        ctxt_idx        => ctxt_idx_r_3,
        sign            => sign_r_3,
        N_current       => N_current_r_3,
        A_current       => A_current_r_3,
        B_current       => B_current_r_3,
        C_current       => C_current_r_3,
        ctxt_idx_update => ctxt_idx_update_32_r,    -- NOTE: These feed around the pipeline back to region 2
        N_update        => N_update_r_32,
        A_update        => A_update_r_32,
        B_update        => B_update_r_32,
        C_update        => C_update_r_32,
        k               => k_r_3,
        valid_data_out  => valid_data_32_r,         -- NOTE: This feeds around the pipeline back to region 2
        error           => pred_error_r_3
    );
    
    mod_3_g: pipeline_module_3
    generic map(
        color_res   => G_size,
        N_reset     => N_reset,
        N_size      => N_size,
        A_size      => A_size_g,
        B_size      => B_size_g,
        C_size      => C_size_g,
        k_width     => k_width_g
    )
    port map(
        pixel           => X_g_3,
        prediction      => X_pred_g_3,
        valid_data_in   => valid_data_3,
        ctxt_idx        => ctxt_idx_g_3,
        sign            => sign_g_3,
        N_current       => N_current_g_3,
        A_current       => A_current_g_3,
        B_current       => B_current_g_3,
        C_current       => C_current_g_3,
        ctxt_idx_update => ctxt_idx_update_32_g,    -- NOTE: These feed around the pipeline back to region 2
        N_update        => N_update_g_32,
        A_update        => A_update_g_32,
        B_update        => B_update_g_32,
        C_update        => C_update_g_32,
        k               => k_g_3,
        valid_data_out  => valid_data_32_g,         -- NOTE: This feeds around the pipeline back to region 2
        error           => pred_error_g_3
    );
    
    mod_3_b: pipeline_module_3
    generic map(
        color_res   => B_size,
        N_reset     => N_reset,
        N_size      => N_size,
        A_size      => A_size_b,
        B_size      => B_size_b,
        C_size      => C_size_b,
        k_width     => k_width_b
    )
    port map(
        pixel           => X_b_3,
        prediction      => X_pred_b_3,
        valid_data_in   => valid_data_3,
        ctxt_idx        => ctxt_idx_b_3,
        sign            => sign_b_3,
        N_current       => N_current_b_3,
        A_current       => A_current_b_3,
        B_current       => B_current_b_3,
        C_current       => C_current_b_3,
        ctxt_idx_update => ctxt_idx_update_32_b,    -- NOTE: These feed around the pipeline back to region 2
        N_update        => N_update_b_32,
        A_update        => A_update_b_32,
        B_update        => B_update_b_32,
        C_update        => C_update_b_32,
        k               => k_b_3,
        valid_data_out  => valid_data_32_b,         -- NOTE: This feeds around the pipeline back to region 2
        error           => pred_error_b_3
    );
    
    -- Pipeline register 3
    pipeline_register_3: process(pclk)
    begin
        if rising_edge(pclk) then
            if resetn = '0' then
                -- Synchronous reset
                valid_data_4    <= '0';
                new_pixel_4_buf <= '0';
                new_pixel_4     <= '0';
                k_r_4           <= (others=>'0');
                k_g_4           <= (others=>'0');
                k_b_4           <= (others=>'0');
                pred_error_r_4  <= (others=>'0');
                pred_error_g_4  <= (others=>'0');
                pred_error_b_4  <= (others=>'0');
                N_r_4           <= (others=>'0');
                N_g_4           <= (others=>'0');
                N_b_4           <= (others=>'0');
                B_r_4           <= (others=>'0');
                B_g_4           <= (others=>'0');
                B_b_4           <= (others=>'0');
            else
                -- Propagate data
                if new_pixel_3 = '1' then
                    valid_data_4    <= valid_data_3;
                    k_r_4           <= k_r_3;
                    k_g_4           <= k_g_3;
                    k_b_4           <= k_b_3;
                    pred_error_r_4  <= pred_error_r_3;
                    pred_error_g_4  <= pred_error_g_3;
                    pred_error_b_4  <= pred_error_b_3;
                    N_r_4           <= N_current_r_3;
                    N_g_4           <= N_current_g_3;
                    N_b_4           <= N_current_b_3;
                    B_r_4           <= B_current_r_3;
                    B_g_4           <= B_current_g_3;
                    B_b_4           <= B_current_b_3;
                end if;
                
                -- Propagate 'new_pixel'
                new_pixel_4_buf <= new_pixel_3;
                new_pixel_4     <= new_pixel_4_buf;
            end if;
        end if;
    end process;
    
    -- PIPELINE REGION 4 - Error mapping and Golomb coder
        -- Component instantiations
    mod_4_r: pipeline_module_4
    generic map(
        color_res   => R_size,
        N_size      => N_size,
        B_size      => B_size_r,
        k_width     => k_width_r,
        L_max       => L_max_r
    )
    port map(
        k       => k_r_4,
        error   => pred_error_r_4,
        N       => N_r_4,
        B       => B_r_4,
        encoded => encoded_r_4,
        size    => encoded_size_r_4
    );
    
    mod_4_g: pipeline_module_4
    generic map(
        color_res   => G_size,
        N_size      => N_size,
        B_size      => B_size_g,
        k_width     => k_width_g,
        L_max       => L_max_g
    )
    port map(
        k       => k_g_4,
        error   => pred_error_g_4,
        N       => N_g_4,
        B       => B_g_4,
        encoded => encoded_g_4,
        size    => encoded_size_g_4
    );
    
    mod_4_b: pipeline_module_4
    generic map(
        color_res   => B_size,
        N_size      => N_size,
        B_size      => B_size_b,
        k_width     => k_width_b,
        L_max       => L_max_b
    )
    port map(
        k       => k_b_4,
        error   => pred_error_b_4,
        N       => N_b_4,
        B       => B_b_4,
        encoded => encoded_b_4,
        size    => encoded_size_b_4
    );
    
    -- Pipeline register 4
    pipeline_register_4: process(pclk)
    begin
        if rising_edge(pclk) then
            if resetn = '0' then
                -- Synchronous reset
                valid_data_5        <= '0';
                encoded_r_5         <= (others=>'0');
                encoded_g_5         <= (others=>'0');
                encoded_b_5         <= (others=>'0');
                encoded_size_r_5    <= (others=>'0');
                encoded_size_g_5    <= (others=>'0');
                encoded_size_b_5    <= (others=>'0');
                new_pixel_5         <= '0';
            else
                if new_pixel_4 = '1' then
                    valid_data_5        <= valid_data_4;
                    encoded_r_5         <= encoded_r_4;
                    encoded_g_5         <= encoded_g_4;
                    encoded_b_5         <= encoded_b_4;
                    encoded_size_r_5    <= encoded_size_r_4;
                    encoded_size_g_5    <= encoded_size_g_4;
                    encoded_size_b_5    <= encoded_size_b_4;
                end if;
                
                new_pixel_5_buf <= new_pixel_4;
                new_pixel_5     <= new_pixel_5_buf;
            end if;
        end if;
    end process;
    
    -- Signal assignments
    new_pixel       <= new_pixel_5;
    valid_data      <= valid_data_5;
    encoded_r       <= encoded_r_5;
    encoded_g       <= encoded_g_5;
    encoded_b       <= encoded_b_5;
    encoded_size_r  <= std_logic_vector(encoded_size_r_5);
    encoded_size_g  <= std_logic_vector(encoded_size_g_5);
    encoded_size_b  <= std_logic_vector(encoded_size_b_5);

end Behavioral;
