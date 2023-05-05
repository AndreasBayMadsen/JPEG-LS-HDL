----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2023 02:41:23 PM
-- Design Name: 
-- Module Name: error_mapper - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Maps the calculated errors to non-negative values to be Golomb-encoded.
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

entity error_mapper is
    Generic (   color_res   : INTEGER   := 5;   -- Number of bits associated with the color
                N_size      : INTEGER   := 7;
                B_size      : INTEGER   := 5;
                k_width     : INTEGER   := 5
                );
    Port (  -- Inputs
            k               : in    UNSIGNED(k_width-1 downto 0)    := (others=>'0');
            error           : in    SIGNED(color_res-1 downto 0)    := (others=>'0');
                -- Context data
            N               : in    UNSIGNED(N_size-1 downto 0)     := (others=>'0');
            B               : in    SIGNED(B_size-1 downto 0)       := (others=>'0');
            -- Outputs
            mapped_error    : out   UNSIGNED(color_res-1 downto 0)  := (others=>'0')
            );
end error_mapper;

architecture Behavioral of error_mapper is

    -- Signal declarations
    signal N_int            : INTEGER   := 0;
    signal B_int            : INTEGER   := 0;
    signal error_int        : INTEGER   := 0;
    signal mapped_error_int : INTEGER   := 0;
    
begin

    mapper: process(k, error_int, N_int, B_int)
    begin
        if k = 0 and 2*B_int <= -N_int then -- NOTE: This looks like multiplication in RTL
            if error_int >= 0 then
                mapped_error_int <= 2*error_int + 1;
            else
                mapped_error_int <= -2*(error_int + 1);
            end if;
        else
            if error_int >= 0 then
                mapped_error_int <= 2*error_int;
            else
                mapped_error_int <= -2*error_int - 1;
            end if;
        end if;
    end process;
    
    -- Signal assignments
    N_int           <= to_integer(N);
    B_int           <= to_integer(B);
    error_int       <= to_integer(error);
    mapped_error    <= to_unsigned(mapped_error_int, mapped_error'length);

end Behavioral;
