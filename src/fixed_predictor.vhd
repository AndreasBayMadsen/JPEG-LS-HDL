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

    generic ( 
        data_width :    integer := 8);
    Port ( 
        pclk :           in  STD_LOGIC;
        last_data :     in  STD_LOGIC;
        A :             in  unsigned    (data_width - 1 downto 0);
        B :             in  unsigned    (data_width - 1 downto 0);
        C :             in  unsigned    (data_width - 1 downto 0);
           
        x_pred :        out unsigned    (data_width - 1 downto 0);
        done :          out STD_LOGIC);
end fixed_predictor;

architecture Behavioral of fixed_predictor is

    subtype data_type is unsigned (data_width - 1 downto 0);

    signal x_temp :         data_type   := (others=>'0');
    signal largest_temp :   data_type   := (others=>'0');
    signal smallest_temp :  data_type   := (others=>'0');
    signal last_temp :      std_logic;

begin

    process(A, B)
    begin
        if A < B then
            smallest_temp <= A;
            largest_temp <= B;
        else
            smallest_temp <= B;
            largest_temp <= A;
        end if;
    end process;

    x_temp <= smallest_temp when C >= largest_temp else 
         largest_temp when C <= smallest_temp else 
         A + B - C;
    
    last_temp <= last_data;
    
    process(pclk)
    begin
        if rising_edge(pclk) then
            x_pred <= x_temp;
            done <= last_temp;
            
        end if;
    end process;

end Behavioral;
