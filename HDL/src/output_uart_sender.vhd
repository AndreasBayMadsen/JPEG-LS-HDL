----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/08/2023 11:37:31 AM
-- Design Name: 
-- Module Name: output_uart_sender - Behavioral
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
library UNISIM;
use UNISIM.VComponents.all;

entity output_uart_sender is
    Port (  
            resetn          : in  STD_LOGIC;
            pclk            : in  STD_LOGIC;
            sig             : out STD_LOGIC;
            
            request_next    : out STD_LOGIC;  -- Set high for getting next value, when it is ready.
            read_allowed    : in  STD_LOGIC;  -- Flag for when clock is connected to logic and BRAM
            dout            : in  STD_LOGIC_VECTOR (63 downto 0); -- Data from BRAM.
            new_data_ready  : in  STD_LOGIC;  -- Flag goes high for one clock, when new data is ready on 'dout'.
            end_of_data     : in  STD_LOGIC   -- Flag goes high when all data for image has been read. Flag goes low when new image/data is available.
            );
end output_uart_sender;

architecture Behavioral of output_uart_sender is

    component uart_tx_module
        Port (  rst             : in  STD_LOGIC;
                clk             : in  STD_LOGIC; -- clock must be 16x baudrate
                sig             : out STD_LOGIC;
                data            : in  STD_LOGIC_VECTOR (7 downto 0);
                new_data_pulse  : in  STD_LOGIC;
                data_send       : out STD_LOGIC -- Goes high for one clock, when data has been send.
                );
    end component;
    
    component clk_divider
        Generic ( base_freq : integer := 125000000;
                  out_freq  : integer := 1843200     -- 115200 baud        
        );  
        Port ( rst : in STD_LOGIC;
               clk : in STD_LOGIC;
               clk_div : out STD_LOGIC);
    end component;
    
    signal data_uart                : STD_LOGIC_VECTOR (7 downto 0);  
    signal clk_uart_temp            : STD_LOGIC;
    signal clk_uart                 : STD_LOGIC;
    signal data_is_send_uart        : STD_LOGIC;
    signal new_data_uart            : STD_LOGIC := '0';
    signal old_data_is_send_uart    : STD_LOGIC := '1';
    signal old_clk_uart             : STD_LOGIC := '1';
    
    signal rising_clk_uart          : STD_LOGIC := '0';
    signal rising_data_send_uart    : STD_LOGIC := '0';
    
    signal buffer_data              : STD_LOGIC_VECTOR (63 downto 0) := (others => '0');
    signal data_byte_idx            : UNSIGNED(2 downto 0) := (others => '0');
    
    type   tx_enum is (WAITING, FETCH, SEND, WAIT_SEND);
    signal tx_states : tx_enum := WAITING;
    
begin

    uart_clk : clk_divider
    Generic map (   base_freq => 12000000,
                    out_freq  => 921600     -- 57600 baud        
                    )  
    Port map (  rst => '0',
                clk => pclk,
                clk_div => clk_uart_temp
                );
                
    BUFG_inst : BUFG
    port map (
       O => clk_uart, -- 1-bit output: Clock output
       I => clk_uart_temp  -- 1-bit input: Clock input
    );

    uart : uart_tx_module
    port map(   rst             => '0',
                clk             => clk_uart,
                sig             => sig,
                data            => data_uart,
                new_data_pulse  => new_data_uart,
                data_send       => data_is_send_uart
                );
                
    rising_clk_uart         <= '1' when old_clk_uart = '0' and clk_uart = '1' else '0';
    rising_data_send_uart   <= '1' when old_data_is_send_uart = '0' and data_is_send_uart = '1' else '0';
    
    process(pclk, resetn)
    begin
    
        if resetn = '0' then
            data_uart              <= (others => '0');
            new_data_uart          <= '0';
            old_data_is_send_uart  <= '0';
            old_clk_uart           <= '0';
            
            buffer_data            <= (others => '0');
            data_byte_idx          <= (others => '0');
            
            tx_states <= WAITING;
        
        elsif rising_edge(pclk) then
            old_data_is_send_uart <= data_is_send_uart;
            old_clk_uart <= clk_uart;
            request_next <= '0';
        
            case tx_states is
                when WAITING =>
                    if end_of_data = '0' and read_allowed = '1' then
                        request_next <= '1';
                        tx_states <= FETCH;
                    end if;
                    
                when FETCH =>
                    if new_data_ready = '1' then
                        buffer_data <= dout;
                        tx_states <= SEND;
                    end if;
                
                when SEND =>
                    if rising_clk_uart = '1' then
                        data_uart <= buffer_data(7 + 8 * to_integer(data_byte_idx) downto 8 * to_integer(data_byte_idx));
                        new_data_uart <= '1';
                        tx_states <= WAIT_SEND;
                    end if;
                    
                when WAIT_SEND =>
                    if rising_clk_uart = '1' then
                        new_data_uart <= '0';
                    end if;
                    if rising_data_send_uart = '1' then
                    
                        if data_byte_idx /= 7 then
                            tx_states <= SEND;
                        else 
                            tx_states <= WAITING;
                        end if;
                        
                        data_byte_idx <= data_byte_idx + 1;
                    end if;
                    
                when others =>
                    tx_states <= WAITING;
            end case;
        end if;
    end process;    

end Behavioral;