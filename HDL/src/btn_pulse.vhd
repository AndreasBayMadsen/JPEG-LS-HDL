----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2023 06:22:45 PM
-- Design Name: 
-- Module Name: btn_pulse - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity btn_pulse is
    Port ( clk : in STD_LOGIC;
           in1 : in STD_LOGIC;
           out1 : out STD_LOGIC);
end btn_pulse;

architecture Behavioral of btn_pulse is

    signal in_shift : STD_LOGIC_VECTOR(1 downto 0) := (others => '1');

begin

    out1 <= '1' when in_shift = "01" else '0';

    process(clk)
    begin
        if rising_edge(clk) then
            in_shift <= in_shift(0) & in1;            
        end if;
    end process;

end Behavioral;
