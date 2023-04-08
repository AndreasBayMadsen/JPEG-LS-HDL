----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2023 09:13:22 AM
-- Design Name: 
-- Module Name: uart_rx_module - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_rx_module is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;  -- clock must be 16x baudrate
           sig : in STD_LOGIC;
           data : out STD_LOGIC_VECTOR (7 downto 0);
           new_data_pulse : out STD_LOGIC);
end uart_rx_module;

architecture Behavioral of uart_rx_module is

    constant data_size : integer := 8;
    
    signal rx_register : STD_LOGIC_VECTOR(data_size + 1 downto 0);
    
    type rx_enum is (WAITING, START, COLLECT, ENDING);
    signal rx_states : rx_enum := WAITING;

begin

    process(clk, rst)
        
        variable rx_cnt : unsigned(3 downto 0) := (others => '0');
        variable total_bits_collected : unsigned(4 downto 0) := (others => '0');
        
    begin
    
        if rst = '1' then
            rx_states <= WAITING;
            rx_cnt := (others => '0');
            total_bits_collected := (others => '0');
            new_data_pulse <= '0';
            rx_register <= (others => '0');
                    
        elsif rising_edge(clk) then
        
            case rx_states is
                when WAITING =>  -- Wait for start bit
                
                    new_data_pulse <= '0';
                    
                    if sig = '0' then
                        rx_states <= START;
                        rx_cnt := (0 => '1', others => '0');
                    end if;
                    
                when START =>   -- Wait half an uart clk cycle, before collecting first bit
                    if rx_cnt = to_unsigned(7,4) then
                        rx_states <= COLLECT;
                        rx_register <= sig & rx_register(data_size + 1 downto 1);
                        rx_cnt := (0 => '1', others => '0');
                        total_bits_collected := (0 => '1', others => '0');
                        
                    else
                        rx_cnt := rx_cnt + 1; 
                    end if;
                
                when COLLECT => -- Keep collecting bits until desired amount is reached
                    if rx_cnt = to_unsigned(15,4) then
                        rx_register <= sig & rx_register(data_size + 1 downto 1);
                        
                        if total_bits_collected = to_unsigned(9, 4) then
                            rx_states <= ENDING;
                        else
                            total_bits_collected := total_bits_collected + 1;
                        end if;
                    end if;
                    
                    rx_cnt := rx_cnt + 1; -- Use overflow to go back to 0
                    
                when ENDING => -- Check if signal was valid and set output if so
                
                    if rx_register(9) = '1' and rx_register(0) = '0' then
                        data <= rx_register(8 downto 1);
                        new_data_pulse <= '1';
                    end if;
                    
                    rx_states <= WAITING;

            end case;        
        end if;
    
    end process;

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

entity uart_tx_module is
    Port (  rst             : in  STD_LOGIC;
            clk             : in  STD_LOGIC; -- clock must be 16x baudrate
            sig             : out STD_LOGIC;
            data            : in  STD_LOGIC_VECTOR (7 downto 0);
            new_data_pulse  : in  STD_LOGIC;
            data_send       : out STD_LOGIC -- Goes high for one clock, when data has been send.
            );
end uart_tx_module;

architecture Behavioral of uart_tx_module is

    constant data_size : integer := 8;
    
    signal tx_register : STD_LOGIC_VECTOR(data_size + 1 downto 0);
    signal tx_idx : unsigned(integer(ceil(log2(real(data_size + 2)))) downto 0) := (others => '0');
    
    type tx_enum is (WAITING, SEND);
    signal tx_states : tx_enum := WAITING;

begin

    process(clk, rst)
        
        variable tx_cnt : unsigned(3 downto 0) := (others => '0');
        
        variable total_bits_sent : unsigned(4 downto 0) := (others => '0');
        variable old_data_flag : STD_LOGIC := '1';
        
    begin
    
        if rst = '1' then
            tx_states <= WAITING;
            sig <= '1';
            tx_cnt := (others => '0');
            tx_idx <= (others => '0');
            total_bits_sent := (others => '0');
            tx_register <= (others => '0');
            data_send <= '0';
            
        elsif rising_edge(clk) then
            
            data_send <= '0';
        
            case tx_states is
                when WAITING =>  -- Wait for start pulse
                
                    sig <= '1';
                
                    if old_data_flag = '0' and new_data_pulse = '1' then
                        tx_states <= SEND;
                        tx_cnt := (0 => '1', others => '0');
                        tx_idx <= (others => '0');
                        
                        tx_register <= "1" & data & "0";
                        
                    end if;
                
                when SEND => -- Send
                    if tx_cnt = to_unsigned(1, 4) then
                        sig <= tx_register(to_integer(tx_idx));
                        
                        tx_idx <= tx_idx + 1;
                        if tx_idx = to_unsigned(data_size + 1, tx_idx'length) then
                            tx_states <= WAITING;
                            data_send <= '1';
                        end if;
                        
                    end if;
                    
                    tx_cnt := tx_cnt + 1; -- Use overflow to go back to 0
            end case;        
                
        old_data_flag := new_data_pulse;

        end if;
    
    end process;

end Behavioral;