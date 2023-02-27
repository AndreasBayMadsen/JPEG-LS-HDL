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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity golomb_coder is
    Generic (
        alpha : integer := 256
    );
    Port ( pclk : in STD_LOGIC;
           en : in STD_LOGIC;
           valid_data : in STD_LOGIC;
           k : in STD_LOGIC;
           error : in STD_LOGIC_VECTOR (2 downto 0);
           encoded : out STD_LOGIC_VECTOR (20 downto 0);
           size : out STD_LOGIC_VECTOR (6 downto 0));
end golomb_coder;

architecture Behavioral of golomb_coder is

    constant beta : integer := integer(realmax(2.0, ceil(log2(real(alpha)))));

    constant L_max : integer := integer(2.0 * beta_max + realmax(8.0, real(beta)))

begin


end Behavioral;
