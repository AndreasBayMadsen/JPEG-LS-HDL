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

entity TB_full_sim_synth is
--  Port ( );
end TB_full_sim_synth;

architecture Behavioral of TB_full_sim_synth is
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
    
    component JPEG_LS_module_top
        Port (  resetn          : in    STD_LOGIC                       := '1';
                pclk            : in    STD_LOGIC                       := '1';
                pixel           : in    STD_LOGIC_VECTOR(7 downto 0)    := (others=>'0');
                href            : in    STD_LOGIC                       := '0';
                vsync           : in    STD_LOGIC                       := '0';
                new_pixel       : out   STD_LOGIC                       := '0';
                valid_data      : out   STD_LOGIC                       := '0';
                encoded_r       : out   STD_LOGIC_VECTOR(19 downto 0)   := (others=>'0');
                encoded_g       : out   STD_LOGIC_VECTOR(23 downto 0)   := (others=>'0');
                encoded_b       : out   STD_LOGIC_VECTOR(19 downto 0)   := (others=>'0');
                encoded_size_r  : out   STD_LOGIC_VECTOR(5 downto 0)    := (others=>'0');
                encoded_size_g  : out   STD_LOGIC_VECTOR(5 downto 0)    := (others=>'0');
                encoded_size_b  : out   STD_LOGIC_VECTOR(5 downto 0)    := (others=>'0')
                );
    end component;
    
    -- Constant declarations
        -- Base
    constant PCLK_FREQ_MHZ  : REAL      := 12.0;
    constant IMAGE_FILE_1   : STRING    := "../../../../../../../kodak_dataset/no_border.ppm";
    constant IMAGE_FILE_2   : STRING    := "../../../../../../../kodak_dataset/kodim01.ppm";
    constant IMAGE_HEIGHT   : INTEGER   := 512;
    constant IMAGE_WIDTH    : INTEGER   := 768;
    
        -- Module settings
    constant L_max_r    : INTEGER   := 20;
    constant L_max_g    : INTEGER   := 24;
    constant L_max_b    : INTEGER   := 20;
    
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
    signal encoded_r        : STD_LOGIC_VECTOR(L_max_r-1 downto 0)  := (others=>'0');
    signal encoded_g        : STD_LOGIC_VECTOR(L_max_g-1 downto 0)  := (others=>'0');
    signal encoded_b        : STD_LOGIC_VECTOR(L_max_b-1 downto 0)  := (others=>'0');
    signal encoded_size_r   : STD_LOGIC_VECTOR(5 downto 0)     := (others=>'0');
    signal encoded_size_g   : STD_LOGIC_VECTOR(5 downto 0)     := (others=>'0');
    signal encoded_size_b   : STD_LOGIC_VECTOR(5 downto 0)     := (others=>'0');
    
    signal size_r_int       : INTEGER   := 0;
    signal size_g_int       : INTEGER   := 0;
    signal size_b_int       : INTEGER   := 0;
    
        -- Management
    signal pixel_count      : INTEGER   := 0;
    
    -- File declarations
    file red_compressed_ascii       : TEXT;
    file green_compressed_ascii     : TEXT;
    file blue_compressed_ascii      : TEXT;
    
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
    
    DUT: JPEG_LS_module_top
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
    
    --- Extract data and write to files
    write_encoded: process
        -- Variable declarations
        variable fstatus    : FILE_OPEN_STATUS;
        variable file_line  : LINE;
        
    begin
        -- IMAGE NUMBER 1
        -- Open files
        file_open(fstatus, red_compressed_ascii, "../../../../../../../kodak_dataset/impl_sim_output_1_red.txt", write_mode);
        file_open(fstatus, green_compressed_ascii, "../../../../../../../kodak_dataset/impl_sim_output_1_green.txt", write_mode);
        file_open(fstatus, blue_compressed_ascii, "../../../../../../../kodak_dataset/impl_sim_output_1_blue.txt", write_mode);
        
        while pixel_count < IMAGE_HEIGHT*IMAGE_WIDTH-1 loop
            wait until rising_edge(new_pixel);
            -- Red
            write(file_line, to_bitvector(encoded_r(size_r_int-1 downto 0)));
            writeline(red_compressed_ascii, file_line);
            
            -- Green
            write(file_line, to_bitvector(encoded_g(size_g_int-1 downto 0)));
            writeline(green_compressed_ascii, file_line);
            
            -- Blue
            write(file_line, to_bitvector(encoded_b(size_b_int-1 downto 0)));
            writeline(blue_compressed_ascii, file_line);
            
            pixel_count <= pixel_count + 1;
        end loop;
        pixel_count <= 0;
        
        -- Close files
        file_close(red_compressed_ascii);
        file_close(green_compressed_ascii);
        file_close(blue_compressed_ascii);
        
        -- Wait for next rising edge (marking end of frame)
        wait until rising_edge(new_pixel);
        
        -- IMAGE NUMBER 2
        -- Open files
        file_open(fstatus, red_compressed_ascii, "../../../../../../../kodak_dataset/impl_sim_output_2_red.txt", write_mode);
        file_open(fstatus, green_compressed_ascii, "../../../../../../../kodak_dataset/impl_sim_output_2_green.txt", write_mode);
        file_open(fstatus, blue_compressed_ascii, "../../../../../../../kodak_dataset/impl_sim_output_2_blue.txt", write_mode);
        
        while pixel_count < IMAGE_HEIGHT*IMAGE_WIDTH-1 loop
            wait until rising_edge(new_pixel);
            -- Red
            write(file_line, to_bitvector(encoded_r(size_r_int-1 downto 0)));
            writeline(red_compressed_ascii, file_line);
            
            -- Green
            write(file_line, to_bitvector(encoded_g(size_g_int-1 downto 0)));
            writeline(green_compressed_ascii, file_line);
            
            -- Blue
            write(file_line, to_bitvector(encoded_b(size_b_int-1 downto 0)));
            writeline(blue_compressed_ascii, file_line);
            
            pixel_count <= pixel_count + 1;
        end loop;
        
        -- Close files
        file_close(red_compressed_ascii);
        file_close(green_compressed_ascii);
        file_close(blue_compressed_ascii);
        
        wait;
    end process;
    
    timing: process
        variable timing_var : BOOLEAN := FALSE;
    begin
        wait for 80838 us;
        timing_var  := TRUE;
    end process;
    
    -- Signal assignments
    resetn      <= '1';
    pixel_vec   <= std_logic_vector(pixel_uns);
    size_r_int  <= to_integer(unsigned(encoded_size_r));
    size_g_int  <= to_integer(unsigned(encoded_size_g));
    size_b_int  <= to_integer(unsigned(encoded_size_b));

end Behavioral;
