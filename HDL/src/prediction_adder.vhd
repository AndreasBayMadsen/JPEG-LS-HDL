----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2023 02:27:55 PM
-- Design Name: 
-- Module Name: prediction_adder - Behavioral
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

entity prediction_adder is
    Generic (   color_res   : INTEGER   := 5;   -- Number of bits for the given color
                C_size      : INTEGER   := 5    -- Should be the same as 'color_res'
                );
    Port (  -- Inputs
                -- Pixel data
            pixel       : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');
            fixed_pred  : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');
                -- Context data
            sign        : in    STD_LOGIC                       := '0';
            C           : in    SIGNED(C_size-1 downto 0)       := (others=>'0');
                -- Output
            error       : out   SIGNED(color_res-1 downto 0)    := (others=>'0')
            );
end prediction_adder;

architecture Behavioral of prediction_adder is
    -- Constant declarations
    constant alpha  : INTEGER   := 2**color_res;

    -- Signal declarations
    signal pixel_int        : INTEGER   := 0;
    signal fixed_pred_int   : INTEGER   := 0;
    signal C_int            : INTEGER   := 0;
    
    signal corr_pred        : INTEGER   := 0;   -- Bias corrected prediction
    
begin

    -- Correct bias of fixed prediction
    bias_correct: process(fixed_pred_int, C_int, sign)
        variable corr_pred_var  : INTEGER   := 0;
    begin
        -- Fix bias
        if sign = '0' then
            corr_pred_var := fixed_pred_int + C_int;
        else
            corr_pred_var := fixed_pred_int - C_int;
        end if;
        
        -- Clamp to range [0, alpha-1]  NOTE: I am not sure if these expressions are inverting (wrong) in RTL
        if corr_pred_var < 0 then
            corr_pred_var := 0;
        elsif corr_pred_var >= alpha then
            corr_pred_var := alpha-1;
        end if;
        
        corr_pred <= corr_pred_var;
        
    end process;
    
    -- Compute prediction error
    error_calc: process(pixel_int, corr_pred, sign)
        variable err_var    : INTEGER   := 0;
    begin
        err_var := pixel_int - corr_pred;   -- Prediction error
        
        -- Adjust sign to context
        if sign = '1' then  -- NOTE: Not sure if this inverts in RTL (wrong)
            err_var := -err_var;
        end if;
        
        -- Reduce with modulo
        if err_var < 0 then
            err_var := err_var + alpha;
        end if;
        if err_var >= (alpha+1)/2 then  -- NOTE: I don't see this in the RTL view
            err_var := err_var - alpha;
        end if;
        
        error <= to_signed(err_var, error'length);
    end process;

    -- Signal assignments
    pixel_int       <= to_integer(pixel);
    fixed_pred_int  <= to_integer(fixed_pred);
    C_int           <= to_integer(C);

end Behavioral;
