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

-- TODO:
-- * Use additional camera signals (new row when href goes low, use vsync etc.)
-- * Error handling (e.g. throw away frame when href goes low before last pixel in row)

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
        -- Camera interface
        pclk    : in    STD_LOGIC               := '0';
        pixel   : in    UNSIGNED(7 downto 0)    := (others=>'0');
        href    : in    STD_LOGIC               := '0';
        vsync   : in    STD_LOGIC               := '0';
        -- Output interface
        clk         : in    STD_LOGIC               := '0';
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
    
    -- Attribute declarations
    attribute ASYNC_REG : STRING;
    
    -- Type declarations
    type DESERIALIZER_FSM_TYPE is (IDLE, RUNNING);
    type MEMORY_READER_FSM_TYPE is (IDLE, LOAD_A, LOAD_B, LOAD_C, LOAD_D, OUTPUT_X, READ_NEXT_B);
    type MEMORY_WRITER_FSM_TYPE is (IDLE, STORE_X, UPDATE_POINTERS, WRITE_D0, WRITE_A0);
    
    -- Signal declarations
    signal resetn_int       : STD_LOGIC := '1';
    
        -- Receiving of bytes
    signal deserializer_state   : DESERIALIZER_FSM_TYPE := IDLE;
    signal first_byte           : STD_LOGIC := '1';
    signal pixel_received       : STD_LOGIC := '0';
    signal X_buffer             : UNSIGNED(15 downto 0) := (others=>'0');
    
        -- Memory
    signal pointer_mutex        : BOOLEAN                       := FALSE;   -- Allows updating buffer pointers
    signal pointer_mutex_reader : BOOLEAN                       := FALSE;
    signal pointer_mutex_writer : BOOLEAN                       := FALSE;
    signal write_enable     : STD_LOGIC                     := '0';
    signal write_addr_vector    : STD_LOGIC_VECTOR(9 downto 0)  := (others=>'0');
    signal write_addr       : UNSIGNED(write_addr_vector'high downto write_addr_vector'low) := (others=>'0');
    signal write_data_vector    : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
    signal write_data       : UNSIGNED(15 downto 0)         := (others=>'0');
    signal read_addr_vector : STD_LOGIC_VECTOR(9 downto 0)  := (others=>'0');
    signal read_addr        : UNSIGNED(read_addr_vector'high downto read_addr_vector'low) := (others=>'0');
    signal read_data        : UNSIGNED(15 downto 0)         := (others=>'0');
    signal read_data_vector : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
    signal memory_reader_fsm_state  : MEMORY_READER_FSM_TYPE    := IDLE;
    signal memory_writer_fsm_state  : MEMORY_WRITER_FSM_TYPE    := IDLE;
    
    signal tail_pointer : UNSIGNED(read_addr_vector'high downto read_addr_vector'low)   := (others=>'0');
    signal head_pointer : UNSIGNED(read_addr_vector'high downto read_addr_vector'low)   := to_unsigned(image_width+3, read_addr_vector'length);   -- NOTE: Includes pixel on either side of image and X itself
    signal row_counter  : INTEGER   := 0;
    signal col_counter  : INTEGER   := 0;
    signal next_B       : UNSIGNED(B'high downto B'low) := (others=>'0');
    signal A_buffer     : UNSIGNED(15 downto 0)   := (others=>'0');
    signal B_buffer     : UNSIGNED(15 downto 0)   := (others=>'0');
    signal C_buffer     : UNSIGNED(15 downto 0)   := (others=>'0');
        
            -- Synchronization
    signal pixel_presynced  : UNSIGNED(7 downto 0)  := (others=>'0');
    signal pixel_synced     : UNSIGNED(7 downto 0)  := (others=>'0');
    attribute ASYNC_REG of pixel_presynced  : SIGNAL is "TRUE";

    signal pclk_presynced   : STD_LOGIC := '0';
    signal pclk_synced      : STD_LOGIC := '0';
    attribute ASYNC_REG of pclk_presynced   : SIGNAL is "TRUE";
    
    signal href_presynced   : STD_LOGIC := '0';
    signal href_synced      : STD_LOGIC := '0';
    attribute ASYNC_REG of href_synced  : SIGNAL is "TRUE";
    
    signal vsync_presynced  : STD_LOGIC := '0';
    signal vsync_synced     : STD_LOGIC := '0';
    attribute ASYNC_REG of vsync_synced : SIGNAL is "TRUE";

begin

    -- Component instantiations
    mem: collector_bram
    port map(
        clka    => clk,
        wea(0)  => write_enable,
        addra   => write_addr_vector,
        dina    => write_data_vector,
        clkb    => clk,
        addrb   => read_addr_vector,
        doutb   => read_data_vector
    );

    -- Signal assignments
    read_addr_vector    <= std_logic_vector(read_addr);
    read_data           <= unsigned(read_data_vector);
    write_addr_vector   <= std_logic_vector(write_addr);
    write_data_vector   <= std_logic_vector(write_data);
    pointer_mutex       <= pointer_mutex_reader XOR pointer_mutex_writer;
    new_pixel           <= pixel_received;

    sync: process(clk)
    begin
        if rising_edge(clk) then
            pixel_presynced <= pixel;
            pixel_synced    <= pixel_presynced;
            
            pclk_presynced  <= pclk;
            pclk_synced     <= pclk_presynced;
            
            href_presynced  <= href;
            href_synced     <= href_presynced;
            
            vsync_presynced <= vsync;
            vsync_synced    <= vsync_presynced;
        end if;
    end process;

    deserializer: process(clk)
        variable pclk_shift     : STD_LOGIC_VECTOR(1 downto 0)  := (others=>'0');
        variable vsync_shift    : STD_LOGIC_VECTOR(1 downto 0)  := (others=>'0');
    begin
        if rising_edge(clk) then
            if resetn_int = '0' then
                -- Synchronous reset
                pixel_received  <= '0';
                first_byte      <= '1';
                X_buffer        <= (others=>'0');
                deserializer_state  <= IDLE;
                valid_data      <= '0';
                
                pclk_shift := "00";
            else
                -- Default values
                pixel_received  <= '0';
            
                -- Shift registers
                pclk_shift  := pclk_shift(0) & pclk_synced;
                vsync_shift := vsync_shift(0) & vsync_synced;
                
                case deserializer_state is
                    when IDLE =>
                        valid_data  <= '0';
                        if vsync_shift = "10" then
                            valid_data <= '1';
                            deserializer_state <= RUNNING;
                        end if;
                        
                    -- vsync has been received, frame is starting
                    when RUNNING =>
                        -- New pixel incoming
                        valid_data <= '1';
                        if href_synced = '1' AND (pclk_shift = "01") then
                            if first_byte = '1' then
                                X_buffer(15 downto 8)   <= pixel_synced;
                                first_byte              <= '0';
                            else
                                X_buffer(7 downto 0)    <= pixel_synced;
                                pixel_received          <= '1';
                                first_byte              <= '1';
                            end if;
                        end if;
                end case;
            end if;
        end if;
    end process;
    
    -- Returns current values of A, B, C, D and X
    memory_reader: process(clk)
    begin
        if rising_edge(clk) then
            if resetn_int = '0' then
                -- Synchronous reset
                memory_reader_fsm_state <= IDLE;
                read_addr               <= (others=>'0');
                A                       <= (others=>'0');
                B                       <= (others=>'0');
                C                       <= (others=>'0');
                D                       <= (others=>'0');
                X                       <= (others=>'0');
                pointer_mutex_reader    <= FALSE;
                next_B                  <= (others=>'0');
                A_buffer                <= (others=>'0');
                B_buffer                <= (others=>'0');
                C_buffer                <= (others=>'0');
            else
                case memory_reader_fsm_state is
                    -- Wait for new pixel
                    when IDLE =>
                        if pixel_received = '1' then
                            -- Set new A, B, C, D and X
                            read_addr <= head_pointer - 1;      -- Address for A
                            memory_reader_fsm_state <= LOAD_A;
                        end if;
                        
                    -- Load A value
                    when LOAD_A =>
                        read_addr <= tail_pointer + 1;          -- Address for B
                        memory_reader_fsm_state <= LOAD_B;
                        
                    -- Load B value
                    when LOAD_B =>
                        A_buffer    <= read_data;
                        read_addr   <= tail_pointer;            -- Address for C
                        memory_reader_fsm_state <= LOAD_C;
                        
                    -- Load C value
                    when LOAD_C =>
                        B_buffer    <= read_data;
                        read_addr   <= tail_pointer + 2;        -- Address for D
                        memory_reader_fsm_state <= LOAD_D;
                        
                    -- Load D value
                    when LOAD_D =>
                        C_buffer    <= read_data;
                        read_addr   <= head_pointer - to_unsigned(image_width, head_pointer'length) + 1;  -- Next B in case of new row
                        memory_reader_fsm_state <= OUTPUT_X;
                        
                    -- Output X value
                    when OUTPUT_X =>
                        A   <= A_buffer;
                        B   <= B_buffer;
                        C   <= C_buffer;
                        D   <= read_data;
                        X   <= X_buffer;
                        
                        if col_counter < (image_width-1) then   -- Normal column
                            pointer_mutex_reader <= not pointer_mutex_reader;
                            memory_reader_fsm_state <= IDLE;
                        else                                    -- Last column
                            memory_reader_fsm_state <= READ_NEXT_B;
                        end if;
                        
                    -- New row - Read next value of B
                    when READ_NEXT_B =>
                        next_B <= read_data;
                        pointer_mutex_reader <= not pointer_mutex_reader;
                        memory_reader_fsm_state <= IDLE;
                end case;
            end if;
        end if;
    end process;
    
    -- Updates memory
    memory_writer: process(clk)
    begin
        if rising_edge(clk) then
            if resetn_int = '0' then
                -- Synchronous reset
                write_enable            <= '0';
                memory_writer_fsm_state <= IDLE;
                write_addr              <= (others=>'0');
                write_data              <= (others=>'0');
                head_pointer            <= to_unsigned(image_width+3, head_pointer'length);
                tail_pointer            <= (others=>'0');
                col_counter             <= 0;
                pointer_mutex_writer    <= FALSE;
                row_counter             <= 0;
            else
                -- Default values
                write_enable <= '0';
            
                case memory_writer_fsm_state is
                    -- Wait for new pixel
                    when IDLE =>
                        if pixel_received = '1' then
                            memory_writer_fsm_state <= STORE_X;
                        end if;
                        
                    -- Store new X in memory
                    when STORE_X =>
                        write_enable    <= '1';
                        write_addr      <= head_pointer;
                        write_data      <= X_buffer;
                        memory_writer_fsm_state <= UPDATE_POINTERS;
                        
                    -- Update buffer pointers
                    when UPDATE_POINTERS =>
                        if pointer_mutex then
                            head_pointer    <= head_pointer + 1;
                            tail_pointer    <= tail_pointer + 1;
                            
                            -- Update location counters and write pixels outside image
                            if col_counter < (image_width-1) then   -- Normal column
                                col_counter <= col_counter + 1;
                                memory_writer_fsm_state <= IDLE;
                                pointer_mutex_writer    <= not pointer_mutex_writer;
                            else                                    -- Last column
                                col_counter <= col_counter + 1;
                                memory_writer_fsm_state <= WRITE_D0;
                            end if;
                        end if;
                        
                    -- Write D0 to the right of image
                    when write_D0 =>
                        write_enable    <= '1';
                        write_addr      <= head_pointer;
                        write_data      <= X_buffer;
                        col_counter     <= -1;
                        row_counter     <= row_counter + 1;
                        
                        head_pointer    <= head_pointer + 1;
                        tail_pointer    <= tail_pointer + 1;
                        
                        memory_writer_fsm_state <= WRITE_A0;
                        
                    -- Write A0 to the left of image
                    when WRITE_A0 =>
                        write_enable    <= '1';
                        write_addr      <= head_pointer;
                        write_data      <= next_B;
                        memory_writer_fsm_state <= UPDATE_POINTERS;
                end case;
            end if;
        end if;
    end process;
    
    reset_handler: process(clk)
    begin
        if rising_edge(clk) then
            -- Default values
            resetn_int <= '1';
        
            if row_counter = (image_height-1) AND
                col_counter = image_width then
                resetn_int <= '0';
            end if;
        end if;
    end process;

end Behavioral;
