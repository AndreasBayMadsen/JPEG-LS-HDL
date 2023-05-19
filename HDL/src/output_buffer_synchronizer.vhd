----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2023 08:41:56 AM
-- Design Name: 
-- Module Name: synchronizer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Synchronization for clock domain crossings. NOTE: Using series FFs
--                  for bus clock domain crossings is discouraged if there is not
--                  simultaneously a handshake signal!
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity output_buffer_synchronizer is
    Port (  -- Clock domain 1 to clock domain 2
            clk_2               : in    STD_LOGIC                       := '1';             -- Synchronizing clock
            read_allowed_1      : in    STD_LOGIC                       := '0';
            dout_1              : in    STD_LOGIC_VECTOR(63 downto 0)   := (others=>'0');
            new_data_ready_1    : in    STD_LOGIC                       := '0';
            end_of_data_1       : in    STD_LOGIC                       := '0';
            read_allowed_2      : out   STD_LOGIC                       := '0';
            dout_2              : out   STD_LOGIC_VECTOR(63 downto 0)   := (others=>'0');
            new_data_ready_2    : out   STD_LOGIC                       := '0';
            end_of_data_2       : out   STD_LOGIC                       := '0';
            -- Clock domain 2 to clock domain 1
            clk_1               : in    STD_LOGIC                       := '1';             -- Synchronizing clock
            request_next_2      : in    STD_LOGIC                       := '0';
            request_next_1      : out   STD_LOGIC                       := '0'
        );
end output_buffer_synchronizer;

architecture Behavioral of output_buffer_synchronizer is
    -- Attribute declarations
    attribute ASYNC_REG         : STRING;

    -- Signal declarations
    signal read_allowed_buf    : STD_LOGIC                      := '0';
    signal dout_buf            : STD_LOGIC_VECTOR(63 downto 0)  := (others=>'0');
    signal new_data_ready_buf  : STD_LOGIC                      := '0';
    signal end_of_data_buf     : STD_LOGIC                      := '0';
    signal request_next_buf    : STD_LOGIC                      := '0';
    
    attribute ASYNC_REG of read_allowed_buf     : signal is "TRUE";
    attribute ASYNC_REG of dout_buf             : signal is "TRUE";
    attribute ASYNC_REG of new_data_ready_buf   : signal is "TRUE";
    attribute ASYNC_REG of end_of_data_buf      : signal is "TRUE";
    attribute ASYNC_REG of request_next_buf     : signal is "TRUE";
    
begin

    sync_1_to_2: process(clk_2)
    begin
        if rising_edge(clk_2) then
            read_allowed_buf    <= read_allowed_1;
            read_allowed_2      <= read_allowed_buf;
            
            dout_buf    <= dout_1;
            dout_2      <= dout_buf;
            
            new_data_ready_buf  <= new_data_ready_1;
            new_data_ready_2    <= new_data_ready_buf;
            
            end_of_data_buf <= end_of_data_1;
            end_of_data_2   <= end_of_data_buf;
        end if;
    end process;
    
    sync_2_to_1: process(clk_1)
    begin
        if rising_edge(clk_1) then
            request_next_buf    <= request_next_2;
            request_next_1      <= request_next_buf;
        end if;
    end process;

end Behavioral;
