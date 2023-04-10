----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2023 09:13:22 AM
-- Design Name: 
-- Module Name: clk_divider - Behavioral
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
use IEEE.MATH_REAL.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_divider is
    Generic ( base_freq : integer := 125000000;
              out_freq  : integer := 1843200     -- 115200 baud        
    );  
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           clk_div : out STD_LOGIC);
end clk_divider;

architecture Behavioral of clk_divider is

constant cnt_val : integer := integer(round(real(base_freq) / (2.0 * real(out_freq))) - 1.0);

constant cnt_len : integer := integer(ceil(log2(real(cnt_val))));

signal clk_temp : STD_LOGIC := '1';

begin

    process(clk, rst)
        variable counter : unsigned(cnt_len - 0 downto 0) := (others => '0');
    begin
        if(rst='1') then
        counter := (others=>'0');
        elsif(rising_edge(clk))then
            if(counter = to_unsigned(cnt_val, cnt_len))then
                clk_temp<=not(clk_temp);
                counter := (others=>'0');
            else
                counter := counter + 1;
             end if;
         end if;
     end process;
  clk_div<=clk_temp;

end Behavioral;
