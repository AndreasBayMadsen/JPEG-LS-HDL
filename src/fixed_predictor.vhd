----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/13/2023 03:04:44 PM
-- Design Name: 
-- Module Name: fixed_predictor - Behavioral
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

entity fixed_predictor is
    Port ( clk :        in  STD_LOGIC;
           last_data :  in STD_LOGIC;
           A :          in  unsigned    (7 downto 0);
           B :          in  unsigned    (7 downto 0);
           C :          in  unsigned    (7 downto 0);
           x_pred :     out unsigned    (7 downto 0);
           done :       out STD_LOGIC);
end fixed_predictor;

architecture Behavioral of fixed_predictor is

    signal x_temp :         unsigned    (7 downto 0)    := (others=>'0');
    signal largest_temp :   unsigned    (7 downto 0)    := (others=>'0');
    signal smallest_temp :  unsigned    (7 downto 0)    := (others=>'0');

begin


process(clk)
begin


smallest_temp <= A when A < B else B;
    

    x_temp <= A when (C > B and C > A) else 
	 "0100" when a = "01" else 
	 "0010" when a = "10" else 
	 "0001" when a = "11";



    if rising_edge(clk) then
            
    
    end if;

end process;


end Behavioral;
