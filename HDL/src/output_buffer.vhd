----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2023 02:42:36 PM
-- Design Name: 
-- Module Name: output_buffer - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity output_buffer is
    Generic (   L_max_r     : integer   := 20;
                L_max_g     : integer   := 24;
                L_max_b     : integer   := 20;
                k_width_r     : integer := 5;
                k_width_g     : integer := 5;
                k_width_b     : integer := 5
    );
    Port (  resetn          : in    STD_LOGIC;
            pclk            : in    STD_LOGIC;
            new_pixel       : in    STD_LOGIC;
            valid_data      : in    STD_LOGIC;
            encoded_r       : in    STD_LOGIC_VECTOR (L_max_r - 1 downto 0);
            encoded_g       : in    STD_LOGIC_VECTOR (L_max_g - 1 downto 0);
            encoded_b       : in    STD_LOGIC_VECTOR (L_max_b - 1 downto 0);
            encoded_size_r  : in    STD_LOGIC_VECTOR (k_width_r downto 0);
            encoded_size_g  : in    STD_LOGIC_VECTOR (k_width_g downto 0);
            encoded_size_b  : in    STD_LOGIC_VECTOR (k_width_b downto 0);
            
            request_next    : in    STD_LOGIC;  -- Set high for getting next value, when it is ready.
            read_allowed    : out   STD_LOGIC;  -- Flag for when clock is connected to logic and BRAM
            dout            : out   STD_LOGIC_VECTOR (63 downto 0) := (others => '0'); -- Data from BRAM.
            new_data_ready  : out   STD_LOGIC := '0';  -- Flag goes high for one clock, when new data is ready on 'dout'.
            end_of_data     : out   STD_LOGIC := '1'  -- Flag goes high when all data for image has been read. Flag goes low when new image/data is available.
           );
end output_buffer;

architecture Behavioral of output_buffer is

    component output_buffer_bram
      port (
        clka    : IN STD_LOGIC;
        wea     : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        addra   : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
        dina    : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        douta   : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
      );
    end component;
    
    constant ptr_len        : integer   := 14;
    constant bram_width     : integer   := 64;
    constant reg_width      : integer   := 2 * bram_width;
    
    -- RAM signal
    
    signal bram_din         : STD_LOGIC_VECTOR(63 DOWNTO 0);
    signal bram_addr        : STD_LOGIC_VECTOR(13 DOWNTO 0);
    signal bram_dout        : STD_LOGIC_VECTOR(63 downto 0);
    signal we               : STD_LOGIC := '0';

    signal write_addr       : STD_LOGIC_VECTOR(13 DOWNTO 0);
    signal read_addr        : STD_LOGIC_VECTOR(13 DOWNTO 0);

    signal write_pointer    : UNSIGNED(ptr_len - 1 downto 0) := to_unsigned(0, ptr_len);
    signal read_pointer     : UNSIGNED(ptr_len - 1 downto 0) := to_unsigned(0, ptr_len);
    
    signal data_available   : STD_LOGIC;
    
    -- READ LOGIC FLAGS.
    
    signal addr_written     : STD_LOGIC := '0';
    signal ram_waiting      : STD_LOGIC := '0';
    
    -- LOGIC signals
    
    signal reg_size_left        : INTEGER RANGE 0 to BRAM_WIDTH := 0;-- UNSIGNED(integer(ceil(log2(real(bram_width + 1)))) - 1 downto 0) := (others => '0'); -- Number of valid bits in left part of reg_int
    signal reg_size_right_com   : INTEGER RANGE 0 to BRAM_WIDTH := 0; --UNSIGNED(integer(ceil(log2(real(bram_width + 1)))) - 1 downto 0) := (others => '0'); -- Number of valid bits in right part of reg_int accoring to input
    signal reg_size_right       : INTEGER RANGE 0 to BRAM_WIDTH := 0; --UNSIGNED(integer(ceil(log2(real(bram_width + 1)))) - 1 downto 0) := (others => '0'); -- Number of valid bits in right part of reg_int
    signal reg_int              : STD_LOGIC_VECTOR(reg_width + bram_width - 1 downto 0) := (others => '0');
    
    signal reg_size_overflow    : STD_LOGIC; -- Goes high when reg_size_left + reg_size_right is higher than bram_width.
    signal reg_empty            : STD_LOGIC;
    
    signal read_allow           : STD_LOGIC := '0'; -- Writer sets this high, when reader process can continue. Reader process must stop immedietly, when this goes low again.
    
        
    type writer_enum is (WAIT_NEW_INPUT, UPDATE);
    signal writer_state : writer_enum;
    
    
    -- Convert STD_LOGIC_VECTOR to UNSIGNED.
    signal encoded_size_r_int : UNSIGNED(k_width_r downto 0);
    signal encoded_size_g_int : UNSIGNED(k_width_g downto 0);
    signal encoded_size_b_int : UNSIGNED(k_width_b downto 0);
    
begin

    encoded_size_r_int <= UNSIGNED(encoded_size_r);
    encoded_size_g_int <= UNSIGNED(encoded_size_g);
    encoded_size_b_int <= UNSIGNED(encoded_size_b);

    memory_block : output_buffer_bram 
        Port Map(   clka    => pclk,
                    wea(0)     => we,
                    addra   => bram_addr,
                    dina    => bram_din,
                    douta   => bram_dout
                    );
                    
    bram_addr <= write_addr when read_allow = '0' else read_addr;
    
    reg_empty <= '1' when reg_size_right + reg_size_left = 0 else '0';
    
    reg_size_right_com  <= to_integer(encoded_size_r_int) + to_integer(encoded_size_g_int) + to_integer(encoded_size_b_int);
    
    reg_size_overflow <= '1' when bram_width < reg_size_right + reg_size_left else '0';
    
    writer : process(pclk)
    begin
        
        if rising_edge(pclk) then
            if resetn = '0' then
                we <= '0';
                read_allow <= '0';
                bram_din <= (others => '0');
                write_addr <= (others => '0');
                write_pointer <= (others => '0');
                reg_int <= (others => '0');
                writer_state <= WAIT_NEW_INPUT;
            
            else
            
                we <= '0';
                read_allow <= '0';
                
                case writer_state is
                    when WAIT_NEW_INPUT =>
                    
                        if (new_pixel = '1' and valid_data = '1') or (valid_data = '0' and reg_empty = '0') then
                        
                            if reg_size_right > 0 and reg_size_left < bram_width then
                            
                                -- Shift from right to left part.
                                reg_int <= (others => '0');
                                if reg_size_overflow = '1' then
                                    
                                    reg_int(reg_int'high downto bram_width) <= reg_int(2 * bram_width + reg_size_left - 1 downto reg_size_left);
                                    
                                    reg_int(2 * bram_width - (reg_size_right - (bram_width - reg_size_left)) - 1 downto 0) <= (others => '0');
                                    
                                    reg_size_left <= bram_width;
                                    reg_size_right <= reg_size_right - (bram_width - reg_size_left);
                                    
                                    if valid_data = '0' then
                                        reg_size_right <= bram_width;
                                    end if;
                                
                                elsif valid_data = '1' then
                                    
                                    reg_int(reg_int'high downto bram_width) <= reg_int(reg_int'high - reg_size_right downto bram_width - reg_size_right);
                                    
                                    reg_int(reg_int'high downto reg_size_right + reg_size_left + 2 * bram_width) <= (others => '0');
                                    reg_int(2 * bram_width - 1 downto 0) <= (others => '0');
                                    
                                    reg_size_left <= reg_size_right + reg_size_left;
                                    reg_size_right <= 0;
                                    
                                else
                                
                                    reg_int(reg_int'high downto 2 * bram_width) <= reg_int(2 * bram_width + reg_size_left - 1 downto bram_width + reg_size_left);
                                    reg_int(2 * bram_width - 1 downto 0) <= (others => '0');
                                    
                                    reg_size_left <= bram_width;
                                    reg_size_right <= 0;

                                end if;
                            end if;
                            writer_state <= UPDATE;
                        end if;
                       
                        if valid_data = '0' and reg_empty = '1' then
                            read_allow <= '1';
                        end if;
                           
                    when UPDATE =>
                    
                        -- Write to RAM and from temp
                        if reg_size_left = bram_width then
                            bram_din <= reg_int(reg_int'length - 1 downto reg_int'length - bram_width);
                            we <= '1';
                            
                            -- Set address;
                            write_addr <= (others => '0');
                            write_addr(write_pointer'range) <= STD_LOGIC_VECTOR(write_pointer);
                            write_pointer <= write_pointer + 1;
                            
                            -- Shift register.
                            reg_int <= (others => '0');
                            
                            
                            reg_int(reg_int'high downto bram_width) <= reg_int(reg_int'high - reg_size_right downto bram_width - reg_size_right);
                            reg_int(reg_int'high downto reg_int'length - reg_size_right) <= (others => '0');
                            
                            reg_size_left <= reg_size_right;
                            
                        end if;
                        
                        -- Load encoded into register.
                        if valid_data = '1' then
                        
                            reg_int(L_max_b + 2 * bram_width - (to_integer(encoded_size_r_int) + to_integer(encoded_size_g_int) + to_integer(encoded_size_b_int)) - 1 downto 2 * bram_width - (to_integer(encoded_size_r_int) + to_integer(encoded_size_g_int) + to_integer(encoded_size_b_int)))
                            <= encoded_b;
                            reg_int(L_max_g + 2 * bram_width - (to_integer(encoded_size_r_int) + to_integer(encoded_size_g_int)) - 1 downto 2 * bram_width - (to_integer(encoded_size_r_int) + to_integer(encoded_size_g_int)))
                            <= encoded_g;
                            reg_int(L_max_r + 2 * bram_width - to_integer(encoded_size_r_int) - 1 downto 2 * bram_width - to_integer(encoded_size_r_int))
                            <= encoded_r;
                            
                            reg_int(reg_int'high downto 2 * bram_width) <= reg_int(reg_int'high downto 2 * bram_width);
                        
                            reg_size_right <= reg_size_right_com;
                        else
                            reg_size_right <= 0;
                        end if;
                        
                        writer_state <= WAIT_NEW_INPUT;
                        
                    when others =>
                        writer_state <= WAIT_NEW_INPUT;
                end case;
            end if;
        end if;
    end process;
    
    read_allowed <= read_allow;
    
    data_available <= '0' when write_pointer = read_pointer else '1';
    
    reader : process(pclk)
    begin
        
        if rising_edge(pclk) then
            if resetn = '0' then
                new_data_ready <= '0';
                end_of_data <= '1';
                ram_waiting <= '0';
                dout <= (others => '0');
                addr_written <= '0';
                read_addr <= (others => '0');
                read_pointer <= (others => '0');
            else
            
                new_data_ready <= '0';
                ram_waiting <= '0';
                addr_written <= '0';
                    
                if data_available = '1' then
                    end_of_data <= '0';
                end if;
                
                -- Read data from RAM.
                if ram_waiting = '1' then
                    dout <= bram_dout;
                    new_data_ready <= '1';
                    
                    if valid_data = '0' and data_available = '0' then
                        end_of_data <= '1';
                    end if;
                end if;
            
                -- Wait a clock;
                if addr_written = '1' then
                    ram_waiting <= '1';
                end if;
                
                if read_allow = '1' and data_available = '1' and request_next = '1' then
                    
                    read_addr <= (others => '0');
                    read_addr(read_pointer'range) <= STD_LOGIC_VECTOR(read_pointer);
                    read_pointer <= read_pointer + 1;
                    
                    addr_written <= '1';
                end if;
            end if;
        end if;
    end process;

end Behavioral;
