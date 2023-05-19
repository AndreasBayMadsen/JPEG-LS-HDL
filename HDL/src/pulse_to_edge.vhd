----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/19/2023 10:07:01 AM
-- Design Name: 
-- Module Name: pulse_to_edge - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: NOTE: This operates in two clock domains
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

entity pulse_to_edge is
    Port (  -- Clock domain 1
            clk_1   : in    STD_LOGIC   := '1';
            in_1    : in    STD_LOGIC   := '0';
            -- Clock domain 2
            clk_2   : in    STD_LOGIC   := '1';
            clear   : in    STD_LOGIC   := '0';
            out_2   : out   STD_LOGIC   := '0'
            );
end pulse_to_edge;

architecture Behavioral of pulse_to_edge is
    -- Attribute declarations
    attribute ASYNC_REG : STRING;

    -- Signal declarations
    signal edge_1       : STD_LOGIC := '0';
    signal edge_2_sync  : STD_LOGIC := '0';
    attribute ASYNC_REG of edge_2_sync : signal is "TRUE";
    
    signal clear_1      : STD_LOGIC := '0';
    signal clear_1_sync : STD_LOGIC := '0';
    attribute ASYNC_REG of clear_1_sync : signal is "TRUE";
    
begin

    edge_generator: process(clk_1)
    begin
        if rising_edge(clk_1) then
            if in_1 = '1' then
                edge_1 <= '1';
            elsif clear_1 = '1' then
                edge_1 <= '0';
            end if;
        end if;
    end process;
    
    clk_1_to_clk_2: process(clk_2)
    begin
        if rising_edge(clk_2) then
            edge_2_sync <= edge_1;
            out_2       <= edge_2_sync;
        end if;
    end process;
    
    clk_2_to_clk_1: process(clk_1)
    begin
        if rising_edge(clk_1) then
            clear_1_sync <= clear;
            clear_1      <= clear_1_sync;
        end if;
    end process;

end Behavioral;
