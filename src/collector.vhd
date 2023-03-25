----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2023 12:06:35 PM
-- Design Name: 
-- Module Name: collector - Behavioral
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

entity collector is
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
end collector;

architecture Behavioral of collector is
    -- Component declarations
    component collector_bram
      PORT (
        clka    : in    STD_LOGIC;
        wea     : in    STD_LOGIC_VECTOR(0 DOWNTO 0);
        addra   : in    STD_LOGIC_VECTOR(9 DOWNTO 0);
        dina    : in    STD_LOGIC_VECTOR(15 DOWNTO 0);
        clkb    : in    STD_LOGIC;
        addrb   : in    STD_LOGIC_VECTOR(9 DOWNTO 0);
        doutb   : out   STD_LOGIC_VECTOR(15 DOWNTO 0) 
      );
    end component;
    
    -- Type declarations
    type DESERIALIZER_FSM_TYPE is (IDLE, RUNNING, END_OF_LINE);
    type FIFO_FSM_TYPE is (RUNNING, RESET);
    
    -- Signal declarations
    signal resetn_int           : STD_LOGIC := '1';
    
        -- Receiving of bytes
    signal deserializer_state   : DESERIALIZER_FSM_TYPE := IDLE;
    signal first_byte           : STD_LOGIC := '1';
    signal pixel_received       : STD_LOGIC := '0';
    signal X_buffer             : UNSIGNED(15 downto 0) := (others=>'0');
    signal border_fill_count    : INTEGER range 0 to 3  := 0;
    
        -- FIFO
    signal write_enable         : STD_LOGIC                     := '0';
    signal write_addr_vector    : STD_LOGIC_VECTOR(9 downto 0)  := (others=>'0');
    signal write_addr           : UNSIGNED(write_addr_vector'high downto write_addr_vector'low) := (others=>'0');
    signal write_data_vector    : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
    signal write_data           : UNSIGNED(15 downto 0)         := (others=>'0');
    signal read_addr_vector     : STD_LOGIC_VECTOR(9 downto 0)  := (others=>'0');
    signal read_addr            : UNSIGNED(read_addr_vector'high downto read_addr_vector'low) := (others=>'0');
    signal read_data            : UNSIGNED(15 downto 0)         := (others=>'0');
    signal read_data_vector     : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
    signal fifo_state           : FIFO_FSM_TYPE                 := RUNNING;
    signal last_pulse           : BOOLEAN                       := TRUE;    -- Last 'new pixel' is sent after valid_data is set low
    
    signal tail_pointer : UNSIGNED(read_addr_vector'high downto read_addr_vector'low)   := (others=>'0');
    signal head_pointer : UNSIGNED(read_addr_vector'high downto read_addr_vector'low)   := to_unsigned(image_width-2, read_addr_vector'length);   -- NOTE: Includes pixel on either side of image
    signal A_buffer     : UNSIGNED(15 downto 0) := (others=>'0');
    signal B_buffer     : UNSIGNED(15 downto 0) := (others=>'0');
    signal C_buffer     : UNSIGNED(15 downto 0) := (others=>'0');
    signal D_buffer     : UNSIGNED(15 downto 0) := (others=>'0');
    signal row_counter  : INTEGER   := 0;
    signal col_counter  : INTEGER   := 0;
        
    -- Constant declarations
    constant NUM_ADDR   : INTEGER   := 2**write_addr'length;  -- Number of addresses in the FIFO
begin

    -- Component instantiations
    mem: collector_bram
    port map(
        clka    => pclk,
        wea(0)  => write_enable,
        addra   => write_addr_vector,
        dina    => write_data_vector,
        clkb    => pclk,
        addrb   => read_addr_vector,
        doutb   => read_data_vector
    );

    -- Signal assignments
    read_addr_vector    <= std_logic_vector(read_addr);
    read_data           <= unsigned(read_data_vector);
    write_addr_vector   <= std_logic_vector(write_addr);
    write_data_vector   <= std_logic_vector(write_data);

    -- Combines high and low bytes received
    deserializer: process(pclk)
        -- Variable declarations
        variable vsync_shift    : STD_LOGIC_VECTOR(1 downto 0)  := (others=>'0');
        variable href_shift     : STD_LOGIC_VECTOR(1 downto 0)  := (others=>'0');
    begin
        if rising_edge(pclk) then
            if resetn_int = '0' OR resetn = '0' then
                -- Synchronous reset
                pixel_received      <= '0';
                deserializer_state  <= IDLE;
                valid_data          <= '0';
                first_byte          <= '1';
                X_buffer            <= (others=>'0');
                col_counter         <= 0;
                row_counter         <= 0;
                border_fill_count   <= 0;
                resetn_int          <= '1';
                
                vsync_shift := "00";
                href_shift  := "00";
            else
                -- Default values
                pixel_received  <= '0';
                resetn_int      <= '1';                
                vsync_shift := vsync_shift(0) & vsync;
                href_shift  := href_shift(0) & href;
                
                case deserializer_state is
                    when IDLE =>
                        valid_data <= '0';
                        if vsync_shift = "10" then
                            valid_data <= '1';
                            deserializer_state <= RUNNING;
                        end if;
                        
                    -- vsync has been received, frame is starting
                    when RUNNING =>
                        -- New pixel incoming
                        valid_data <= '1';
                        if href = '1' then
                            if first_byte = '1' then
                                X_buffer(15 downto 8)   <= pixel;
                                first_byte              <= '0';
                            else
                                X_buffer(7 downto 0)    <= pixel;
                                pixel_received          <= '1';
                                first_byte              <= '1';
                                col_counter <= col_counter + 1;
                                
                            end if;
                        elsif href_shift = "10" then
                            row_counter <= row_counter + 1;
                            col_counter <= 0;
                            deserializer_state <= END_OF_LINE;
                            
                        elsif vsync_shift = "01" then
                            resetn_int <= '0';
                        end if;
                        
                    -- End of line has been reached - write to pixels around image and move to next row
                    when END_OF_LINE =>
                        if border_fill_count = 0 then       -- Pixel to the right of row
                            pixel_received      <= '1';
                            border_fill_count   <= 1;
                        elsif border_fill_count = 1 then    -- Wait
                            border_fill_count   <= 2;
                        elsif border_fill_count = 2 then    -- Pixel to the left of next row
                            X_buffer            <= D_buffer;
                            pixel_received      <= '1';
                            border_fill_count   <= 3;
                        else
                            border_fill_count   <= 0;
                            deserializer_state  <= RUNNING;
                        end if;
                        
                end case;
            end if;
        end if;
    end process;
    
    -- Implements a FIFO for the pixels
    fifo: process(pclk)
        -- Variable declarations
        variable tail_pointer_var   : UNSIGNED(read_addr_vector'high downto read_addr_vector'low)   := (others=>'0');
        variable head_pointer_var   : UNSIGNED(read_addr_vector'high downto read_addr_vector'low)   := to_unsigned(image_width-2, read_addr_vector'length);
        variable write_addr_var     : UNSIGNED(write_addr'high downto write_addr'low)               := (others=>'0');
    begin
        if rising_edge(pclk) then
            if resetn_int = '0' or resetn = '0' then
                -- Synchronous reset
                A               <= (others=>'0');
                B               <= (others=>'0');
                C               <= (others=>'0');
                D               <= (others=>'0');
                A_buffer        <= (others=>'0');
                B_buffer        <= (others=>'0');
                C_buffer        <= (others=>'0');
                D_buffer        <= (others=>'0');
                tail_pointer    <= (others=>'0');
                head_pointer    <= to_unsigned(image_width-2, head_pointer'length);
                write_enable    <= '0';
                write_addr      <= (others=>'0');
                write_data      <= (others=>'0');
                read_addr       <= (others=>'0');
                fifo_state      <= RESET;
                new_pixel       <= '0';
                last_pulse      <= TRUE;
                
                tail_pointer_var    := (others=>'0');
                head_pointer_var    := to_unsigned(image_width-2, read_addr_vector'length);
                write_addr_var      := (others=>'0');
            else
                -- Default values
                write_enable    <= '0';
                new_pixel       <= '0';
            
                case fifo_state is
                    -- Active operation 
                    when RUNNING =>
                        if pixel_received = '1' then
                            -- Latch current data before storing new
                            A <= A_buffer;
                            B <= B_buffer;
                            C <= C_buffer;
                            D <= D_buffer;
                            X <= X_buffer;
                            
                            if deserializer_state /= END_OF_LINE then
                                new_pixel <= '1';
                            end if;
                            
                            -- Update data
                            C_buffer <= B_buffer;
                            B_buffer <= D_buffer;
                            D_buffer <= read_data;
                            A_buffer <= X_buffer;
                            
                            write_enable    <= '1';
                            write_addr      <= head_pointer_var + 1;
                            write_data      <= A_buffer;
                            
                            tail_pointer_var := tail_pointer_var + 1;
                            head_pointer_var := head_pointer_var + 1;
                            tail_pointer    <= tail_pointer_var;
                            head_pointer    <= head_pointer_var;
                        end if;
                        read_addr   <= tail_pointer_var;
                        
                    -- Reset FIFO
                    when RESET =>
                        if last_pulse then
                            new_pixel   <= '1';
                            last_pulse  <= FALSE;
                        end if;
                    
                        -- Clear all memory addresses
                        write_enable    <= '1';
                        write_data      <= (others=>'0');
                        write_addr      <= write_addr_var;
                        
                        if write_addr_var = NUM_ADDR-1 then
                            fifo_state      <= RUNNING;
                        end if;
                        
                        write_addr_var  := write_addr_var + 1;
                end case;
            end if;
        end if;
    end process;
    
end Behavioral;
