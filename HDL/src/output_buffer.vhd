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
            encoded_size_r  : in    UNSIGNED (k_width_r downto 0);
            encoded_size_g  : in    UNSIGNED (k_width_g downto 0);
            encoded_size_b  : in    UNSIGNED (k_width_b downto 0);
            
            request_next    : in    STD_LOGIC;  -- Set high for getting next value, when it is ready.
            read_allowed    : out   STD_LOGIC;  -- Flag for when clock is connected to logic and BRAM
            dout            : out   STD_LOGIC_VECTOR (63 downto 0); -- Data from BRAM.
            new_data_ready  : out   STD_LOGIC;  -- Flag goes high for one clock, when new data is ready on 'dout'.
            end_of_data     : out   STD_LOGIC   -- Flag goes high when all data for image has been read. Flag goes low when new image/data is available.
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
    
    signal addr_written     : STD_LOGIC;
    signal ram_waiting      : STD_LOGIC;
    
    -- LOGIC signals
    
    signal reg_end_temp     : UNSIGNED(integer(ceil(log2(real(reg_width + 1)))) - 1 downto 0)         := (others => '0');
    signal reg_end          : UNSIGNED(integer(ceil(log2(real(reg_width + 1)))) - 1 downto 0)         := (others => '0');
    signal reg_shift_end    : UNSIGNED(integer(ceil(log2(real(reg_width + 1)))) - 1 downto 0)         := (others => '0');
    signal reg_temp         : STD_LOGIC_VECTOR(reg_width - 1 downto 0) := (others => '0');
    signal reg              : STD_LOGIC_VECTOR(reg_width - 1 downto 0) := (others => '0');
    signal reg_shift        : STD_LOGIC_VECTOR(reg_width - 1 downto 0) := (others => '0');
    
    signal read_allow       : STD_LOGIC := '0'; -- Writer sets this high, when reader process can continue. Reader process must stop immedietly, when this goes low again.
    signal reg_empty        : STD_LOGIC;
        
    type writer_enum is (WAITING_WRITE, UPDATE_REG);
    signal writer_state : writer_enum;
    
begin

    memory_block : output_buffer_bram 
        Port Map(   clka    => pclk,
                    wea(0)     => we,
                    addra   => bram_addr,
                    dina    => bram_din,
                    douta   => bram_dout
                    );
                    
    bram_addr <= write_addr when read_allow = '0' else read_addr;
    
    reg_end_temp  <= resize(encoded_size_r, reg_end_temp'length) + encoded_size_g + encoded_size_b + reg_end;
    
    reg_empty <= '1' when reg_end = 0 else '0';
    
    reg_shift <= (reg_width - 1 downto bram_width => '0') & reg(reg_width - 1 downto bram_width);
    
    reg_shift_end <= reg_end - bram_width 
                     when reg_end > bram_width else
                     (others => '0');
    
    writer : process(pclk)
    begin
        
        if rising_edge(pclk) then
            if resetn = '0' then
                we <= '0';
                read_allow <= '0';
                bram_din <= (others => '0');
                write_addr <= (others => '0');
                write_pointer <= (others => '0');
                reg <= (others => '0');
                reg_end <= (others => '0');
                writer_state <= WAITING_WRITE;
            
            else
            
                we <= '0';
                read_allow <= '0';
                
                case writer_state is
                    when WAITING_WRITE =>
                    
                        -- Write to RAM and from temp
                        if reg_end >= bram_width or (valid_data = '0' and reg_empty = '0') then
                            bram_din <= reg(bram_width - 1 downto 0);
                            we <= '1';
                            
                            -- Set address;
                            write_addr <= (others => '0');
                            write_addr(write_pointer'range) <= STD_LOGIC_VECTOR(write_pointer);
                            write_pointer <= write_pointer + 1;
                            
                            -- Register should shift.
                            reg <= reg_shift;
                            reg_end <= reg_shift_end;
                        end if;
                    
                        if (new_pixel = '1' and valid_data = '1') then
                            
                            writer_state <= UPDATE_REG;
                        end if;
                       
                        if valid_data = '0' and reg_empty = '1' then
                            read_allow <= '1';
                        end if;
                           
                    when UPDATE_REG =>
                        
                        -- Update only from input if data is valid.
                        if valid_data = '1' then
                        
                            reg_end <= reg_end_temp;
                            
                            reg <= (others => '0');
                        
                            if reg_empty = '0' then
                                reg(to_integer(reg_end_temp) downto 0) <= encoded_b(to_integer(encoded_size_b - to_unsigned(1, encoded_size_b'length)) downto 0)
                                & encoded_g(to_integer(encoded_size_g - to_unsigned(1, encoded_size_g'length)) downto 0)
                                & encoded_r(to_integer(encoded_size_r - to_unsigned(1, encoded_size_r'length)) downto 0)
                                & reg(to_integer(reg_end - to_unsigned(1, reg_end'length)) downto 0);
                            else
                                reg(to_integer(reg_end_temp) downto 0) <= encoded_b(to_integer(encoded_size_b - to_unsigned(1, encoded_size_b'length)) downto 0)
                                & encoded_g(to_integer(encoded_size_g - to_unsigned(1, encoded_size_g'length)) downto 0)
                                & encoded_r(to_integer(encoded_size_r - to_unsigned(1, encoded_size_r'length)) downto 0);
                            end if;
                        end if;
                        
                        writer_state <= WAITING_WRITE;
                        
                    when others =>
                        writer_state <= WAITING_WRITE;
                end case;
            end if;
        end if;
    end process;
    
    read_allowed <= read_allow;
    
    data_available <= '0' when write_pointer = read_pointer else '1';
    
    reader : process(pclk)
    begin
        if resetn = '0' then
            new_data_ready <= '0';
            end_of_data <= '1';
            ram_waiting <= '0';
            dout <= (others => '0');
            addr_written <= '0';
            read_addr <= (others => '0');
            read_pointer <= (others => '0');
        
        elsif rising_edge(pclk) then
        
            new_data_ready <= '0';
                
            if data_available = '1' then
                end_of_data <= '0';
            end if;
            
            -- Read data from RAM.
            if ram_waiting = '1' then
                ram_waiting <= '0';
                dout <= bram_dout;
                new_data_ready <= '1';
                
                if valid_data = '0' and data_available = '0' then
                    end_of_data <= '1';
                end if;
            end if;
        
            -- Wait a clock;
            if addr_written = '1' then
                addr_written <= '0';
                ram_waiting <= '1';
            end if;
            
            if read_allow = '1' and data_available = '1' and request_next = '1' then
                
                read_addr <= (others => '0');
                read_addr(read_pointer'range) <= STD_LOGIC_VECTOR(read_pointer);
                read_pointer <= read_pointer + 1;
                
                addr_written <= '1';
            end if;
        end if;
    end process;

end Behavioral;
