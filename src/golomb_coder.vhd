----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2023 04:11:40 PM
-- Design Name: 
-- Module Name: golomb_coder - Behavioral
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

entity golomb_coder is
    Generic (
        k_width     :   integer := 5;
        beta_max    :   integer := 8;
        L_max       :   integer := 32
    );
    Port ( pclk : in STD_LOGIC;
           en : in STD_LOGIC;
           valid_data : in STD_LOGIC;
           k : in unsigned (k_width - 1 downto 0);
           error : in unsigned (beta_max - 1 downto 0);
           encoded : out STD_LOGIC_VECTOR (L_max - 1 downto 0);
           size : out unsigned (k_width downto 0));
end golomb_coder;

architecture Behavioral of golomb_coder is

    -- constant beta_max : integer := integer(realmax(2.0, ceil(log2(real(alpha)))));
    -- constant L_max : integer := integer(2.0 * real(beta) + realmax(8.0, real(beta)));

    constant unary_limit : integer := L_max - beta_max - 1;

    signal unary_val : unsigned(beta_max - 1 downto 0);
    
begin

    unary_val <= shift_right(error, to_integer(k));

    process(k, error, unary_val)
    begin
        
        encoded <= (others => '0');
    
        if (unary_val < to_unsigned(unary_limit, unary_val'length)) then
            
            encoded(beta_max - 1 downto 0) <= STD_LOGIC_VECTOR(resize(error(to_integer(k) - 1 downto 0), beta_max));
            encoded(to_integer(k)) <= '1';
            size <= resize(k, size'length) + resize(unary_val, size'length) + 1;
        else
            
            encoded(beta_max) <= '1';
            encoded(beta_max - 1 downto 0) <=  STD_LOGIC_VECTOR(resize(error - 1, beta_max)); 
            size <= to_unsigned(L_max, size'length);
        end if;
    end process;


end Behavioral;
