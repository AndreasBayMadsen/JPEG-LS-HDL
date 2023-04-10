----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2023 12:08:19 PM
-- Design Name: 
-- Module Name: TB_collector - Behavioral
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

entity TB_collector is
--  Port ( );
end TB_collector;

architecture Behavioral of TB_collector is
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
    
    component collector
        Generic (
            image_height    : INTEGER   := 500;
            image_width     : INTEGER   := 500
        );
        Port (
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
            valid_data  : out   STD_LOGIC               := '0';
            new_pixel   : out   STD_LOGIC               := '0'  -- Pulses for each new pixel (to drive pipeline)
            );
    end component;
    
    -- Constant declarations
        -- Base
    constant PCLK_FREQ_MHZ  : REAL  := 12.0;
    
    -- Signal declarations
        -- Camera interface
    signal pclk     : STD_LOGIC             := '0';
    signal pixel    : UNSIGNED(7 downto 0)  := (others=>'0');
    signal href     : STD_LOGIC             := '0';
    signal vsync    : STD_LOGIC             := '0';
    
        -- Output interface
    signal A       : UNSIGNED(15 downto 0)   := (others=>'0');
    signal B       : UNSIGNED(15 downto 0)   := (others=>'0');
    signal C       : UNSIGNED(15 downto 0)   := (others=>'0');
    signal D       : UNSIGNED(15 downto 0)   := (others=>'0');
    signal X       : UNSIGNED(15 downto 0)   := (others=>'0');
    signal valid_data   : STD_LOGIC         := '0';
    signal new_pixel    : STD_LOGIC         := '0';
    
begin
    -- Component instantiations
    cam: camera_simulator
    generic map(
        pclk_freq_MHz   => PCLK_FREQ_MHZ,
        pre_clocks      => 10
    )
    port map(
        pclk    => pclk,
        pixel   => pixel,
        href    => href,
        vsync   => vsync
    );
    
    DUT: collector
    generic map(
        image_height    => 512,
        image_width     => 768
    )
    port map(
        pclk    => pclk,
        pixel   => pixel,
        href    => href,
        vsync   => vsync,
        A       => A,
        B       => B,
        C       => C,
        D       => D,
        X       => X,
        valid_data  => valid_data,
        new_pixel   => new_pixel
    );
    
end Behavioral;
