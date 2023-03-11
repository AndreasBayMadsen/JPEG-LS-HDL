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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity JPEG_LS_module is
    Generic (   image_height    : INTEGER   := 500;     -- Image dimensions in number of pixels
                image_width     : INTEGER   := 500);
    Port (  resetn  : in    STD_LOGIC                       := '1';             -- Active LOW reset signal
            -- Camera interface
            pclk    : in    STD_LOGIC                       := '1';             -- Pixel clock
            pixel   : in    STD_LOGIC_VECTOR(7 downto 0)    := (others=>'0');   -- Parallel bus for pixel data
            href    : in    STD_LOGIC                       := '0';             -- Row synchronization signal
            vsync   : in    STD_LOGIC                       := '0'              -- Frame synchronization signal
            );
end JPEG_LS_module;

architecture Behavioral of JPEG_LS_module is
    -- Component declarations
    component collector
        Generic (
            image_height    : INTEGER   := 500;
            image_width     : INTEGER   := 500
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
                A           : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');
                B           : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');
                C           : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');
                D           : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');
                -- Outputs
                ctxt_idx    : out   UNSIGNED(8 downto 0)            := (others=>'0');
                sign        : out   STD_LOGIC                       := '0';
                X_pred      : out   UNSIGNED(color_res-1 downto 0)  := (others=>'0')
                );
    end component;
    
    -- Constant declarations
    constant R_size : INTEGER   := 5;   -- Number of bits per color
    constant G_size : INTEGER   := 6;
    constant B_size : INTEGER   := 5;
    
    -- Signal declarations
        -- PIPELINE REGION 1 - Collector, gradient and fixed predictor
    signal pixel_uns    : UNSIGNED(7 downto 0)          := (others=>'0');   -- Unsigned version of the 'pixel' input signal
    signal A            : UNSIGNED(15 downto 0)         := (others=>'0');
    signal B            : UNSIGNED(15 downto 0)         := (others=>'0');
    signal C            : UNSIGNED(15 downto 0)         := (others=>'0');
    signal D            : UNSIGNED(15 downto 0)         := (others=>'0');
    signal X            : UNSIGNED(15 downto 0)         := (others=>'0');
    signal valid_data   : STD_LOGIC                     := '0';
    signal new_pixel    : STD_LOGIC                     := '0';
    
    signal ctxt_idx_r   : UNSIGNED(8 downto 0)          := (others=>'0');
    signal ctxt_idx_g   : UNSIGNED(8 downto 0)          := (others=>'0');
    signal ctxt_idx_b   : UNSIGNED(8 downto 0)          := (others=>'0');
    signal sign_r       : STD_LOGIC                     := '0';
    signal sign_g       : STD_LOGIC                     := '0';
    signal sign_b       : STD_LOGIC                     := '0';
    signal X_pred_r     : UNSIGNED(R_size-1 downto 0)   := (others=>'0');
    signal X_pred_g     : UNSIGNED(G_size-1 downto 0)   := (others=>'0');
    signal X_pred_b     : UNSIGNED(B_size-1 downto 0)   := (others=>'0');
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
    
    signal href_delay   : STD_LOGIC                     := '0';
    
begin

    -- PIPELINE REGION 1 - Collector, gradient and fixed predictor
        -- Component instantiations
    pixel_collector: collector  -- Collector for incoming pixels
    generic map(
        image_height    => image_height,
        image_width     => image_width
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
        valid_data  => valid_data,
        new_pixel   => new_pixel
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
        ctxt_idx    => ctxt_idx_r,
        sign        => sign_r,
        X_pred      => X_pred_r
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
        ctxt_idx    => ctxt_idx_g,
        sign        => sign_g,
        X_pred      => X_pred_g
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
        ctxt_idx    => ctxt_idx_b,
        sign        => sign_b,
        X_pred      => X_pred_b
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
    
    delay: process(pclk)
    begin
        if rising_edge(pclk) then
            href_delay <= href;
        end if;
    end process;
    
    -- PIPELINE REGION 2 - Context modeller, 
        -- Component instantiations
        

end Behavioral;
