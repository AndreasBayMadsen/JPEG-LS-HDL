----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2023 09:56:16 AM
-- Design Name: 
-- Module Name: context_modeller - Behavioral
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

entity context_modeller is
    generic ( 
        data_width  :   integer := 8;
        k_width     :   integer := 5;
        n_size      :   integer := 6;
        a_size      :   integer := 15;
        b_size      :   integer := 9;
        c_size      :   integer := 8
        );
    Port (
        pclk :          in  STD_LOGIC; 
        clk :           in  STD_LOGIC;
        valid_data:     in  STD_LOGIC;
        neg_error_flag: in  STD_LOGIC;
        idx :           in  STD_LOGIC_VECTOR    (8 downto 0);
        error :         in  signed              (data_width - 1 downto 0);
         
        error_bias :    out signed              (data_width - 1 downto 0);
        k :             out unsigned            (k_width - 1 downto 0));
end context_modeller;

architecture Behavioral of context_modeller is

    subtype data_type is unsigned (data_width - 1 downto 0);

begin

end Behavioral;
