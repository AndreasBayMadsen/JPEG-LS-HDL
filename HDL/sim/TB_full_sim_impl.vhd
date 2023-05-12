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

use STD.TEXTIO.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_full_sim_impl is
--  Port ( );
end TB_full_sim_impl;

architecture Behavioral of TB_full_sim_impl is
    -- Component declarations
    component camera_simulator
        Generic (
            pclk_freq_MHz   : REAL      := 12.0;
            file_name_1     : STRING    := "../../../../../../kodak_dataset/no_border.ppm";  -- Path to image file
            file_name_2     : STRING    := "../../../../../../kodak_dataset/kodim01.ppm";  -- Path to image file
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
    
    component JPEG_LS_module_top_impl
        Port (  resetn          : in    STD_LOGIC                       := '1';
                pclk            : in    STD_LOGIC                       := '1';
                pixel           : in    STD_LOGIC_VECTOR(7 downto 0)    := (others=>'0');
                href            : in    STD_LOGIC                       := '0';
                vsync           : in    STD_LOGIC                       := '0'
                );
    end component;
    
    -- Constant declarations
        -- Base
    constant PCLK_FREQ_MHZ  : REAL      := 12.0;
    constant IMAGE_FILE_1   : STRING    := "../../../../../../../kodak_dataset/no_border_low_res.ppm";
    constant IMAGE_FILE_2   : STRING    := "../../../../../../../kodak_dataset/no_border_low_res.ppm";
    
    -- Signal declarations
        -- Global signals
    signal resetn       : STD_LOGIC                     := '1';
    
        -- Camera interface
    signal pclk         : STD_LOGIC                     := '0';
    signal pixel_uns    : UNSIGNED(7 downto 0)          := (others=>'0');
    signal pixel_vec    : STD_LOGIC_VECTOR(7 downto 0)  := (others=>'0');
    signal href         : STD_LOGIC                     := '0';
    signal vsync        : STD_LOGIC                     := '0';
    
begin

    -- Component instantiations
    cam: camera_simulator
    generic map(
        pclk_freq_MHz   => PCLK_FREQ_MHZ,
        file_name_1     => IMAGE_FILE_1,
        file_name_2     => IMAGE_FILE_2,
        pre_clocks      => 10
    )
    port map(
        pclk    => pclk,
        pixel   => pixel_uns,
        href    => href,
        vsync   => vsync
    );
    
    DUT: JPEG_LS_module_top_impl
    port map(
        resetn      => resetn,
        pclk        => pclk,
        pixel       => pixel_vec,
        href        => href,
        vsync       => vsync
    );
    
    -- Signal assignments
    resetn      <= '1';
    pixel_vec   <= std_logic_vector(pixel_uns);

end Behavioral;