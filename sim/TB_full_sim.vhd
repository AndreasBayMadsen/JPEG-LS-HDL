----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2023 04:15:32 PM
-- Design Name: 
-- Module Name: TB_full_sim - Behavioral
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

entity TB_full_sim is
--  Port ( );
end TB_full_sim;

architecture Behavioral of TB_full_sim is
    -- Component declarations
    component camera_simulator
        Generic (
            pclk_freq_MHz   : REAL      := 12.0;
            file_name_1     : STRING    := "../../../../../kodak_dataset/no_border.ppm";  -- Path to image file
            file_name_2     : STRING    := "../../../../../kodak_dataset/kodim01.ppm";  -- Path to image file
            format          : STRING    := "RGB565";
            pre_clocks      : INTEGER   := 0    -- Number of clocks before image
        );
        Port (
            pclk    : out   STD_LOGIC               := '0';
            pixel   : out   UNSIGNED(7 downto 0)    := (others=>'0');
            href    : out   STD_LOGIC               := '0';
            vsync   : out   STD_LOGIC               := '0'
            );
    end component;
    
    component JPEG_LS_module
        Generic (   image_height    : INTEGER   := 500;     -- Image dimensions in number of pixels
                    image_width     : INTEGER   := 500;
                    L_max           : INTEGER   := 32;      -- Maximum code size per pixel
                    k_width         : INTEGER   := 5
                    );
        Port (  resetn  : in    STD_LOGIC                       := '1';             -- Active LOW reset signal
                -- Camera interface
                pclk    : in    STD_LOGIC                       := '1';             -- Pixel clock
                pixel   : in    STD_LOGIC_VECTOR(7 downto 0)    := (others=>'0');   -- Parallel bus for pixel data
                href    : in    STD_LOGIC                       := '0';             -- Row synchronization signal
                vsync   : in    STD_LOGIC                       := '0';             -- Frame synchronization signal
                -- Output
                new_pixel       : out   STD_LOGIC                           := '0';
                encoded_r       : out STD_LOGIC_VECTOR(L_max-1 downto 0)    := (others=>'0');
                encoded_g       : out STD_LOGIC_VECTOR(L_max-1 downto 0)    := (others=>'0');
                encoded_b       : out STD_LOGIC_VECTOR(L_max-1 downto 0)    := (others=>'0');
                encoded_size_r  : out UNSIGNED(k_width downto 0)            := (others=>'0');
                encoded_size_g  : out UNSIGNED(k_width downto 0)            := (others=>'0');
                encoded_size_b  : out UNSIGNED(k_width downto 0)            := (others=>'0')
                );
    end component;
    
    -- Constant declarations
        -- Base
    constant PCLK_FREQ_MHZ  : REAL  := 12.0;
    
    -- Signal declarations
        -- Global signals
    signal resetn       : STD_LOGIC                     := '1';
    
        -- Camera interface
    signal pclk         : STD_LOGIC                     := '0';
    signal pixel_uns    : UNSIGNED(7 downto 0)          := (others=>'0');
    signal pixel_vec    : STD_LOGIC_VECTOR(7 downto 0)  := (others=>'0');
    signal href         : STD_LOGIC                     := '0';
    signal vsync        : STD_LOGIC                     := '0';
    
        -- Output
    signal new_pixel        : STD_LOGIC := '0';
    signal encoded_r        : STD_LOGIC_VECTOR(31 downto 0)    := (others=>'0');
    signal encoded_g        : STD_LOGIC_VECTOR(31 downto 0)    := (others=>'0');
    signal encoded_b        : STD_LOGIC_VECTOR(31 downto 0)    := (others=>'0');
    signal encoded_size_r   : UNSIGNED(5 downto 0)            := (others=>'0');
    signal encoded_size_g   : UNSIGNED(5 downto 0)            := (others=>'0');
    signal encoded_size_b   : UNSIGNED(5 downto 0)            := (others=>'0');
    
begin

    -- Component instantiations
    cam: camera_simulator
    generic map(
        pclk_freq_MHz   => PCLK_FREQ_MHZ,
        pre_clocks      => 10
    )
    port map(
        pclk    => pclk,
        pixel   => pixel_uns,
        href    => href,
        vsync   => vsync
    );
    
    DUT: JPEG_LS_module
    generic map(
        image_height    => 512,
        image_width     => 768
    )
    port map(
        resetn      => resetn,
        pclk        => pclk,
        pixel       => pixel_vec,
        href        => href,
        vsync       => vsync,
        new_pixel   => new_pixel,
        encoded_r   => encoded_r,
        encoded_g   => encoded_g,
        encoded_b   => encoded_b,
        encoded_size_r  => encoded_size_r,
        encoded_size_g  => encoded_size_g,
        encoded_size_b  => encoded_size_b
    );
    
    -- Signal assignments
    resetn      <= '1';
    pixel_vec   <= std_logic_vector(pixel_uns);

end Behavioral;
