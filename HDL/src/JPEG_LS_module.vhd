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
    Generic (   image_height    : INTEGER   := 500;     -- Image dimensions in number of pixels
                image_width     : INTEGER   := 500;
                L_max_r         : integer   := 20;      -- Maximum code size per pixel
                L_max_g         : integer   := 24;
                L_max_b         : integer   := 20;
                k_width_r       : integer := 5;
                k_width_g       : integer := 5;
                k_width_b       : integer := 5     
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
    
    component pipeline_module_2
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
    end component;
    
    component golomb_coder
        Generic (
            k_width     :   integer := 5;
            beta_max    :   integer := 8;
            L_max       :   integer := 32
        );
        Port ( pclk : in STD_LOGIC;
               en : in STD_LOGIC;
               valid_data : in STD_LOGIC;
               k : in unsigned (k_width - 1 downto 0);
               error : in unsigned (beta_max - 1 downto 0);
               encoded : out STD_LOGIC_VECTOR (L_max - 1 downto 0);
               size : out unsigned (k_width downto 0));
    end component;
    
    -- Constant declarations
    constant R_size     : INTEGER   := 5;   -- Number of bits per color
    constant G_size     : INTEGER   := 6;
    constant B_size     : INTEGER   := 5;
    -- constant k_width    : INTEGER   := 5;
    
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
    
        -- PIPELINE REGION 2 - Context modeller and error calculation
    signal valid_data_2     : STD_LOGIC                     := '0';
    signal new_pixel_2_buf  : STD_LOGIC                     := '0';
    signal new_pixel_2      : STD_LOGIC                     := '0';
    signal new_pixel_2_5_buf: STD_LOGIC                     := '0';
    signal new_pixel_2_5    : STD_LOGIC                     := '0';
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
    signal k_r_2            : UNSIGNED(k_width_r-1 downto 0)  := (others=>'0');
    signal k_g_2            : UNSIGNED(k_width_g-1 downto 0)  := (others=>'0');
    signal k_b_2            : UNSIGNED(k_width_b-1 downto 0)  := (others=>'0');
    signal mapped_error_r_2 : UNSIGNED(R_size-1 downto 0)   := (others=>'0');
    signal mapped_error_g_2 : UNSIGNED(G_size-1 downto 0)   := (others=>'0');
    signal mapped_error_b_2 : UNSIGNED(B_size-1 downto 0)   := (others=>'0');
    
        -- PIPELINE REGION 3 - Golomb coder
    signal valid_data_3     : STD_LOGIC                             := '0';
    signal new_pixel_3_buf  : STD_LOGIC                             := '0';
    signal new_pixel_3      : STD_LOGIC                             := '0';
    signal k_r_3            : UNSIGNED(k_width_r-1 downto 0)          := (others=>'0');    
    signal k_g_3            : UNSIGNED(k_width_g-1 downto 0)          := (others=>'0');    
    signal k_b_3            : UNSIGNED(k_width_b-1 downto 0)          := (others=>'0');
    signal mapped_error_r_3 : UNSIGNED(R_size-1 downto 0)           := (others=>'0');
    signal mapped_error_g_3 : UNSIGNED(G_size-1 downto 0)           := (others=>'0');
    signal mapped_error_b_3 : UNSIGNED(B_size-1 downto 0)           := (others=>'0');
    signal encoded_r_3      : STD_LOGIC_VECTOR(L_max_r-1 downto 0)    := (others=>'0');
    signal encoded_g_3      : STD_LOGIC_VECTOR(L_max_g-1 downto 0)    := (others=>'0');
    signal encoded_b_3      : STD_LOGIC_VECTOR(L_max_b-1 downto 0)    := (others=>'0');
    signal encoded_size_r_3 : UNSIGNED(k_width_r downto 0)            := (others=>'0');
    signal encoded_size_g_3 : UNSIGNED(k_width_g downto 0)            := (others=>'0');
    signal encoded_size_b_3 : UNSIGNED(k_width_b downto 0)            := (others=>'0');
    
        -- PIPELINE REGION 4 - Output
    signal valid_data_4     : STD_LOGIC                             := '0';
    signal new_pixel_4_buf  : STD_LOGIC                             := '0';
    signal new_pixel_4      : STD_LOGIC                             := '0';
    
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
    
    -- PIPELINE REGION 2 - Context modeller and error calculation
        -- Component instantiations
    mod_2_r: pipeline_module_2  -- Pipeline module 2 for red color
    generic map(
        color_res   => R_size,
        k_width     => k_width_r
    )
    port map(
        clk             => pclk,
        resetn          => resetn,
        enable          => new_pixel_2,
        valid_data      => valid_data_2,
        pixel           => X_r_2,
        prediction      => X_pred_r_2,
        ctxt_idx        => ctxt_idx_r_2,
        sign            => sign_r_2,
        k               => k_r_2,
        mapped_error    => mapped_error_r_2
    );
    
    mod_2_g: pipeline_module_2  -- Pipeline module 2 for green color
    generic map(
        color_res   => G_size,
        k_width     => k_width_g
    )
    port map(
        clk             => pclk,
        resetn          => resetn,
        enable          => new_pixel_2,
        valid_data      => valid_data_2,
        pixel           => X_g_2,
        prediction      => X_pred_g_2,
        ctxt_idx        => ctxt_idx_g_2,
        sign            => sign_g_2,
        k               => k_g_2,
        mapped_error    => mapped_error_g_2
    );
    
    mod_2_b: pipeline_module_2  -- Pipeline module 2 for blue color
    generic map(
        color_res   => B_size,
        k_width     => k_width_b
    )
    port map(
        clk             => pclk,
        resetn          => resetn,
        enable          => new_pixel_2,
        valid_data      => valid_data_2,
        pixel           => X_b_2,
        prediction      => X_pred_b_2,
        ctxt_idx        => ctxt_idx_b_2,
        sign            => sign_b_2,
        k               => k_b_2,
        mapped_error    => mapped_error_b_2
    );
    
    -- Propagate 'new_pixel'
    process(pclk)
    begin
        if rising_edge(pclk) then
            if resetn = '0' then
                new_pixel_2_5_buf   <= '0';
                new_pixel_2_5       <= '0';
            else
                new_pixel_2_5_buf   <= new_pixel_2;
                new_pixel_2_5       <= new_pixel_2_5_buf;
            end if;
        end if;
    end process;
    
    -- Pipeline register 2
    pipeline_register_2: process(pclk)
    begin
        if rising_edge(pclk) then
            if resetn = '0' then
                -- Synchronous reset
                valid_data_3        <= '0';
                k_r_3               <= (others=>'0');
                k_g_3               <= (others=>'0');
                k_b_3               <= (others=>'0');
                mapped_error_r_3    <= (others=>'0');
                mapped_error_g_3    <= (others=>'0');
                mapped_error_b_3    <= (others=>'0');
                new_pixel_3_buf     <= '0';
                new_pixel_3         <= '0';
            else
                if new_pixel_2_5 = '1' then
                    valid_data_3        <= valid_data_2;
                    k_r_3               <= k_r_2;
                    k_g_3               <= k_g_2;
                    k_b_3               <= k_b_2;
                    mapped_error_r_3    <= mapped_error_r_2;
                    mapped_error_g_3    <= mapped_error_g_2;
                    mapped_error_b_3    <= mapped_error_b_2;
                end if;
                
                new_pixel_3_buf <= new_pixel_2_5;
                new_pixel_3     <= new_pixel_3_buf;
            end if;
        end if;
    end process;
    
    -- PIPELINE REGION 3 - Golomb coder
        -- Component instantiations
    golomb_r: golomb_coder  -- Golomb coder for red color
    generic map(
        k_width     => k_width_r,
        beta_max    => mapped_error_r_3'length,
        L_max       => L_max_r
    )
    port map(
        pclk        => pclk,
        en          => new_pixel_3,
        valid_data  => valid_data_3,
        k           => k_r_3,
        error       => mapped_error_r_3,
        encoded     => encoded_r_3,
        size        => encoded_size_r_3
    );
    
    golomb_g: golomb_coder  -- Golomb coder for green color
    generic map(
        k_width     => k_width_g,
        beta_max    => mapped_error_g_3'length,
        L_max       => L_max_g
    )
    port map(
        pclk        => pclk,
        en          => new_pixel_3,
        valid_data  => valid_data_3,
        k           => k_g_3,
        error       => mapped_error_g_3,
        encoded     => encoded_g_3,
        size        => encoded_size_g_3
    );

    golomb_b: golomb_coder  -- Golomb coder for blue color
    generic map(
        k_width     => k_width_b,
        beta_max    => mapped_error_b_3'length,
        L_max       => L_max_b
    )
    port map(
        pclk        => pclk,
        en          => new_pixel_3,
        valid_data  => valid_data_3,
        k           => k_b_3,
        error       => mapped_error_b_3,
        encoded     => encoded_b_3,
        size        => encoded_size_b_3
    );
    
    -- Pipeline register 3
    pipeline_register_3: process(pclk)
    begin
        if rising_edge(pclk) then
            if resetn = '0' then
                -- Synchronous reset
                valid_data_4        <= '0';
                encoded_r           <= (others=>'0');
                encoded_g           <= (others=>'0');
                encoded_b           <= (others=>'0');
                encoded_size_r      <= (others=>'0');
                encoded_size_g      <= (others=>'0');
                encoded_size_b      <= (others=>'0');
                new_pixel_4_buf     <= '0';
                new_pixel_4         <= '0';
            else
                if new_pixel_3 = '1' then
                    valid_data_4        <= valid_data_3;
                    encoded_r           <= encoded_r_3;     
                    encoded_g           <= encoded_g_3;     
                    encoded_b           <= encoded_b_3;
                    encoded_size_r      <= STD_LOGIC_VECTOR(encoded_size_r_3);
                    encoded_size_g      <= STD_LOGIC_VECTOR(encoded_size_g_3);
                    encoded_size_b      <= STD_LOGIC_VECTOR(encoded_size_b_3);
                end if;
                
                new_pixel_4_buf <= new_pixel_3;
                new_pixel_4     <= new_pixel_4_buf;
            end if;
        end if;
    end process;
    
    -- Signal assignments
    new_pixel <= new_pixel_4;
    valid_data <= valid_data_4;

end Behavioral;
