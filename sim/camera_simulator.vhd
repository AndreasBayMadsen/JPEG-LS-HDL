----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2023 12:28:31 PM
-- Design Name: 
-- Module Name: camera_simulator - Behavioral
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

entity camera_simulator is
    Generic (
        pclk_freq_MHz   : REAL      := 6.0;
        file_name       : STRING    := "../../../../../kodak_dataset/kodim01.ppm";  -- Path to image file
        format          : STRING    := "RGB565";
        pre_clocks      : INTEGER   := 0    -- Number of clocks before image
    );
    Port (
        pclk    : out   STD_LOGIC               := '0';
        pixel   : out   UNSIGNED(7 downto 0)    := (others=>'0');
        href    : out   STD_LOGIC               := '0';
        vsync   : out   STD_LOGIC               := '0'
        );
end camera_simulator;

architecture Behavioral of camera_simulator is
    -- Constant declarations
        -- Derived
    constant TPCLK      : TIME      := (1.0/pclk_freq_MHz)*1 us;
    constant TP         : TIME      := 2*TPCLK;
    constant PIXEL_HPER : TIME      := TPCLK/2;

    -- Signal declarations
        -- Debugging variables
    signal image_width      : INTEGER   := 0;
    signal image_height     : INTEGER   := 0;
    signal row_count_sig    : INTEGER   := 0;
    signal col_count_sig    : INTEGER   := 0;
    
    signal pclk_int : STD_LOGIC := '0';
    
    -- File declarations
    file image : TEXT;
    
begin

    pclk        <= pclk_int;
    pclk_int    <= not pclk_int after PIXEL_HPER;
    
    -- Simulate camera
    camera: process
        -- Variable declarations
        variable line_buffer    : LINE;
        variable file_status    : FILE_OPEN_STATUS;
        
        variable image_width_var    : INTEGER               := 0;
        variable image_height_var   : INTEGER               := 0;
        variable R_var              : UNSIGNED(7 downto 0)  := (others=>'0');
        variable G_var              : UNSIGNED(7 downto 0)  := (others=>'0');
        variable B_var              : UNSIGNED(7 downto 0)  := (others=>'0');
        
        variable row_count      : INTEGER   := 0;
        variable col_count      : INTEGER   := 0;
        
        variable TLINE          : TIME;
        
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
        
        TLINE   := (image_width_var + 144)*TP;  -- Time per row
        
        wait for pre_clocks*TPCLK;  -- Wait pre-clock period before starting
        
        -- Read pixel values
        vsync   <= '1';
        wait for 3*TLINE;
        vsync   <= '0';
        wait for 17*TLINE;
        
        -- Scan through rows
        readline(image, line_buffer);       -- Read line from file (terminates at first 0A character)
        while row_count < image_height_var
        loop
            -- Scan through columns
            href    <= '1';
            while col_count < image_width_var
            loop
                -- Read pixel
                read_byte(line_buffer, R_var);
                read_byte(line_buffer, G_var);
                read_byte(line_buffer, B_var);
                
                -- Transmit byte 1
                pixel   <= (others=>'0');
                case FORMAT is
                    when "RGB565" =>    -- RGB565
                        pixel(7 downto 3)   <= R_var(7 downto 3);
                        pixel(2 downto 0)   <= G_var(7 downto 5);
                    when others =>      -- RGB555
                        pixel(6 downto 2)   <= R_var(7 downto 3);
                        pixel(1 downto 0)   <= G_var(7 downto 6);
                end case;
                
                wait for TPCLK;
                
                -- Transmit byte 2
                pixel   <= (others=>'0');
                case FORMAT is
                    when "RGB565" =>    -- RGB565
                        pixel(7 downto 5)   <= G_var(4 downto 2);
                        pixel(4 downto 0)   <= B_var(7 downto 3);
                    when others =>      -- RGB555
                        pixel(7 downto 5)   <= G_var(5 downto 3);
                        pixel(4 downto 0)   <= B_var(7 downto 3);
                end case;

                wait for PIXEL_HPER;
                -- DEBUGGING
                row_count_sig <= row_count;
                col_count_sig <= col_count;
                -- DEBUGGING
                col_count   := col_count + 1;
                wait for PIXEL_HPER;
            end loop;
            
            href    <= '0';
            
            col_count   := 0;
            row_count   := row_count + 1;
            
            wait for 144*TP;
        end loop;
        
        row_count   := 0;
        
        file_close(image);
        wait for 10*TLINE;  -- Time between frames
        wait;
    end process;

end Behavioral;
