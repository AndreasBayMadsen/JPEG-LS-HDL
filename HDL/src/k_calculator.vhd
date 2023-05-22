----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2023 03:55:38 PM
-- Design Name: 
-- Module Name: k_calculator - Behavioral
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

entity k_calculator is
    Generic(    N_size          : INTEGER   := 7;   -- Set to at least ceil(log2(N_reset+1))
                A_size          : INTEGER   := 11;  -- Set to at least ceil(log2(N_reset) + color_res - 1)
                k_width         : INTEGER   := 5
                );
    Port (  -- Context data
            N   : in    UNSIGNED(N_size-1 downto 0)     := (others=>'0');
            A   : in    UNSIGNED(A_size-1 downto 0)     := (others=>'0');
            -- Output
            k   : out   UNSIGNED(k_width-1 downto 0)    := (others=>'0')
            );
end k_calculator;

architecture Behavioral of k_calculator is

    -- Constant declarations
    constant MAX_SHIFT  : INTEGER   := 2**k_width - 1; --TODO: MAX_SHIFT should be color_res

    -- Signal declarations
    signal N_shift  : UNSIGNED(N'length+MAX_SHIFT-1 downto 0)   := (others=>'0');

begin

    k_calc: process(N_shift, A)
    begin
        if A <= N_shift then
            k <= to_unsigned(0, k'length);
        end if;
        
        for idx in 1 to MAX_SHIFT loop
            if A <= shift_left(N_shift, idx) and A > shift_left(N_shift, idx-1) then
                k <= to_unsigned(idx, k'length);
            end if;
        end loop;
    end process;
    
    -- Signal assignments
    N_shift(N_shift'high downto N'high+1)   <= (others=>'0');
    N_shift(N'high downto N'low)            <= N;

end Behavioral;
