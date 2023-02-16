----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/13/2023 03:37:41 PM
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

entity TB_full_sim is
--  Port ( );
end TB_full_sim;

architecture Behavioral of TB_full_sim is
    -- Constant declarations
        -- Base
    constant PIXEL_RATE : REAL      := 6.0;     -- Pixel rate in MHz
    constant FILE_NAME  : STRING    := "../../../../../kodak_dataset/kodim01.ppm";  -- Path to image file
    
        -- Derived
    constant PIXEL_PER  : TIME      := (1.0/PIXEL_RATE)*1 us;
    constant PIXEL_HPER : TIME      := PIXEL_PER/2;
    
    -- Signal declarations
        -- Debugging variables
    signal image_width      : INTEGER   := 0;
    signal image_height     : INTEGER   := 0;
    signal row_count_sig    : INTEGER   := 0;
    signal col_count_sig    : INTEGER   := 0;
    
        -- Camera interfacce
    signal pixel    : UNSIGNED(23 downto 0) := (others=>'0');
    signal pclk     : STD_LOGIC := '0';

    -- File declarations
    file image : TEXT;
    
begin
    
    -- Simulate camera
    camera: process
        -- Variable declarations
        variable line_buffer    : LINE;
        variable file_status    : FILE_OPEN_STATUS;
        
        variable image_width_var    : INTEGER               := 0;
        variable image_height_var   : INTEGER               := 0;
        variable intensity_var      : UNSIGNED(7 downto 0)  := (others=>'0');
        
        variable row_count    : INTEGER   := 0;
        variable col_count    : INTEGER   := 0;
        
        -- Procedure definitions
        procedure read_byte (variable   line_buffer : inout LINE;
                             variable   data_out    : out UNSIGNED(7 downto 0)) is
             -- Variable declarations
             variable data_temp     : CHARACTER;
             variable read_good     : BOOLEAN   := TRUE;
        begin
            read(line_buffer, data_temp, read_good);
            
            if read_good then
                data_out := to_unsigned(character'POS(data_temp), 8);
            else
                -- End of line is reached (marked with 0A)
                data_out := x"0A";
                readline(image, line_buffer);
            end if;
        end procedure;
        
    begin
        -- Initialize
            -- Open file
        file_open(file_status, image, FILE_NAME, read_mode);
        
            -- Read header
        readline(image, line_buffer);           -- Magic number
        readline(image, line_buffer);           -- Width and height
        read(line_buffer, image_width_var);
        read(line_buffer, image_height_var);
        image_width       <= image_width_var;
        image_height      <= image_height_var;
        readline(image, line_buffer);           -- MAXVAL
        
        -- Read pixel values
        -- Scan through rows
        readline(image, line_buffer);       -- Read line from file (terminates at first 0A character)
        while row_count < image_height_var
        loop
            -- Scan through columns
            while col_count < image_width_var
            loop
                read_byte(line_buffer, intensity_var);   -- Read R
                pixel(23 downto 16) <= intensity_var;
                read_byte(line_buffer, intensity_var);   -- Read G
                pixel(15 downto 8)  <= intensity_var;
                read_byte(line_buffer, intensity_var);   -- Read B
                pixel(7 downto 0)   <= intensity_var;
                
                wait for PIXEL_HPER;
                pclk        <= '1';
                row_count_sig <= row_count;
                col_count_sig <= col_count;
                col_count   := col_count + 1;
                
                wait for PIXEL_HPER;
                pclk        <= '0';
            end loop;
            
            col_count   := 0;
            row_count   := row_count + 1;
        end loop;
        
        row_count   := 0;
        
        -- Stop simulation
        file_close(image);
        wait;
    end process;

end Behavioral;
