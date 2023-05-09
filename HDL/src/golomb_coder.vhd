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
    Port ( pclk         : in STD_LOGIC                          := '1';
           valid_data   : in STD_LOGIC                          := '0';
           k            : in unsigned (k_width - 1 downto 0);
           error        : in unsigned (beta_max - 1 downto 0);
           encoded      : out STD_LOGIC_VECTOR (L_max - 1 downto 0);
           size         : out unsigned (k_width downto 0)
           );
end golomb_coder;

architecture Behavioral of golomb_coder is

    constant unary_limit : integer := L_max - beta_max - 1;

    signal unary_val : unsigned(beta_max - 1 downto 0);
    
begin

    -- Calculate unary encoded value
    unary_val <= shift_right(error, to_integer(k));

    process(k, error, unary_val)
    begin
        
        encoded <= (others => '0');
   
        
        if (unary_val < to_unsigned(unary_limit, unary_val'length)) then    -- Code length within limits
            
            -- Calculate binary-coded value
            for idx in beta_max-1 downto 0 loop
                if idx = k then
                    encoded(idx) <= '1';
                elsif idx < to_integer(k) then
                    encoded(idx) <= error(idx);
                else
                    encoded(idx) <= '0';
                end if;
            end loop;
            
            -- Assign length to code
            size <= resize(k, size'length) + resize(unary_val, size'length) + 1;
        else                                                                -- Code length exceeds limits
            
            -- Produce code
            encoded(beta_max) <= '1';                                                           -- Separator - entire code is binary
            encoded(beta_max - 1 downto 0) <=  STD_LOGIC_VECTOR(resize(error - 1, beta_max));   -- Binary code
            size <= to_unsigned(L_max, size'length);
        end if;
    end process;


end Behavioral;
