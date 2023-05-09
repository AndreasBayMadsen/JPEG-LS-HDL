----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2023 02:38:06 PM
-- Design Name: 
-- Module Name: JPEG_LS_module_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Wrapper module to remove generics from the 'JPEG_LS_module' module for post-synthesis simulation
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

entity JPEG_LS_module_top is
    Port (  resetn          : in    STD_LOGIC                       := '1';
            pclk            : in    STD_LOGIC                       := '1';
            pixel           : in    STD_LOGIC_VECTOR(7 downto 0)    := (others=>'0');
            href            : in    STD_LOGIC                       := '0';
            vsync           : in    STD_LOGIC                       := '0';
            new_pixel       : out STD_LOGIC                         := '0';
            valid_data      : out STD_LOGIC                         := '0';
            encoded_r       : out STD_LOGIC_VECTOR(19 downto 0)     := (others=>'0');
            encoded_g       : out STD_LOGIC_VECTOR(23 downto 0)     := (others=>'0');
            encoded_b       : out STD_LOGIC_VECTOR(19 downto 0)     := (others=>'0');
            encoded_size_r  : out STD_LOGIC_VECTOR(5 downto 0)      := (others=>'0');
            encoded_size_g  : out STD_LOGIC_VECTOR(5 downto 0)      := (others=>'0');
            encoded_size_b  : out STD_LOGIC_VECTOR(5 downto 0)      := (others=>'0')
            );
end JPEG_LS_module_top;

architecture Behavioral of JPEG_LS_module_top is
    -- Component declarations
    component JPEG_LS_module
        Generic (   image_height    : INTEGER   := 512;     -- Image dimensions in number of pixels
                    image_width     : INTEGER   := 768;
                    L_max_r         : INTEGER   := 20;      -- Maximum code size per pixel
                    L_max_g         : INTEGER   := 24;
                    L_max_b         : INTEGER   := 20;
                    k_width_r       : INTEGER   := 5;
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
                new_pixel       : out STD_LOGIC                               := '0';
                valid_data      : out STD_LOGIC                               := '0';
                encoded_r       : out STD_LOGIC_VECTOR(L_max_r-1 downto 0)    := (others=>'0');
                encoded_g       : out STD_LOGIC_VECTOR(L_max_g-1 downto 0)    := (others=>'0');
                encoded_b       : out STD_LOGIC_VECTOR(L_max_b-1 downto 0)    := (others=>'0');
                encoded_size_r  : out STD_LOGIC_VECTOR(k_width_r downto 0)    := (others=>'0');
                encoded_size_g  : out STD_LOGIC_VECTOR(k_width_g downto 0)    := (others=>'0');
                encoded_size_b  : out STD_LOGIC_VECTOR(k_width_b downto 0)    := (others=>'0')
                );
    end component;
    
    -- Constant declarations
    constant IMAGE_HEIGHT   : INTEGER   := 512;
    constant IMAGE_WIDTH    : INTEGER   := 768;
    
    constant L_max_r    : INTEGER   := 20;
    constant L_max_g    : INTEGER   := 24;
    constant L_max_b    : INTEGER   := 20;
    constant k_width_r  : INTEGER   := 5;
    constant k_width_g  : INTEGER   := 5;
    constant k_width_b  : INTEGER   := 5;
    
begin

    -- Component instantiations
    unit: JPEG_LS_module
    generic map(
        image_height    => IMAGE_HEIGHT,
        image_width     => IMAGE_WIDTH,
        L_max_r         => L_max_r,
        L_max_g         => L_max_g,
        L_max_b         => L_max_b,
        k_width_r       => k_width_r,
        k_width_g       => k_width_g,
        k_width_b       => k_width_b,
        fps_downscale   => 1
    )
    port map(
        resetn          => resetn,
        pclk            => pclk,
        pixel           => pixel,
        href            => href,
        vsync           => vsync,
        new_pixel       => new_pixel,
        valid_data      => valid_data,
        encoded_r       => encoded_r,
        encoded_g       => encoded_g,
        encoded_b       => encoded_b,
        encoded_size_r  => encoded_size_r,
        encoded_size_g  => encoded_size_g,
        encoded_size_b  => encoded_size_b
    );

end Behavioral;
