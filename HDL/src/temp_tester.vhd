----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2023 01:21:39 PM
-- Design Name: 
-- Module Name: temp_tester - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity temp_tester is
    Port (  pclk    : in    STD_LOGIC                       := '1';
            href    : in    STD_LOGIC                       := '0';
            count   : out   STD_LOGIC_VECTOR(15 downto 0)   := (others=>'0'));
end temp_tester;

architecture Behavioral of temp_tester is
    signal count_int    : UNSIGNED(15 downto 0) := (others=>'0');
    
begin

    counter: process(pclk)
    begin
        if rising_edge(pclk) then
            if href = '1' then
                count_int <= count_int + 1;
            end if;
        end if;
    end process;
    
    count <= std_logic_vector(count_int);

end Behavioral;
