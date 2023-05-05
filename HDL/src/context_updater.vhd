----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2023 04:27:14 PM
-- Design Name: 
-- Module Name: context_updater - Behavioral
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

entity context_updater is
    Generic(    color_res   : INTEGER   := 5;   -- Number of bits associated with the color
                N_reset     : INTEGER   := 64;
                N_size      : INTEGER   := 7;   -- Set to at least ceil(log2(N_reset+1))
                A_size      : INTEGER   := 11;  -- Set to at least ceil(log2(N_reset) + color_res - 1)
                B_size      : INTEGER   := 12;  -- Set to at least 1 + ceil(log2(N_reset) + color_res - 1)
                C_size      : INTEGER   := 5    -- Should be the same as 'color_res'
                );
    Port (  -- Inputs
            valid_data_in   : in    STD_LOGIC   := '0';
                -- Context data
            ctxt_idx    : in    UNSIGNED(8 downto 0)            := (others=>'0');
            N_current   : in    UNSIGNED(N_size-1 downto 0)     := (others=>'0');
            A_current   : in    UNSIGNED(A_size-1 downto 0)     := (others=>'0');
            B_current   : in    SIGNED(b_size-1 downto 0)       := (others=>'0');
            C_current   : in    SIGNED(c_size-1 downto 0)       := (others=>'0');
                -- Algorithm data
            error       : in    SIGNED(color_res-1 downto 0)    := (others=>'0');
            -- Outputs
            valid_data_out  : out   STD_LOGIC                   := '0';
            ctxt_idx_update : out   UNSIGNED(8 downto 0)        := (others=>'0');
            N_update        : out   UNSIGNED(N_size-1 downto 0) := (others=>'0');
            A_update        : out   UNSIGNED(A_size-1 downto 0) := (others=>'0');
            B_update        : out   SIGNED(B_size-1 downto 0)   := (others=>'0');
            C_update        : out   SIGNED(C_size-1 downto 0)   := (others=>'0')
            );
end context_updater;

architecture Behavioral of context_updater is

    -- Constant declarations
    constant alpha  : INTEGER   := 2**color_res;    -- Alphabet size
    constant MIN_C  : INTEGER   := -alpha/2;        -- Minimum value of error bias
    constant MAX_C  : INTEGER   := alpha/2 - 1;     -- Maximum value of error bias

begin

    -- Update context values
    update: process(N_current, A_current, B_current, C_current, error)
        variable N_var  : UNSIGNED(N_current'high downto N_current'low) := (others=>'0');
        variable A_var  : UNSIGNED(A_current'high downto A_current'low) := (others=>'0');
        variable B_var  : SIGNED(B_current'high downto B_current'low)   := (others=>'0');
        variable C_var  : SIGNED(C_current'high downto C_current'low)   := (others=>'0');
    begin
        -- Assign initial values
        N_var := N_current;
        A_var := A_current;
        B_var := B_current;
        C_var := C_current;
        
        -- Calculate updates to A and B
        B_var := B_var + error;
        A_var := A_var + unsigned(abs(error));
        
        -- Halve in case context limit is reached
        if N_var = N_reset then
            A_var := shift_right(A_var, 1);
            B_var := shift_right(B_var, 1);
            N_var := shift_right(N_var, 1);
        end if;
        
        -- Increment context count
        N_var := N_var + 1;
        
        -- Update bias estimate
        if B_var <= - signed('0' & N_var) then
            B_var := B_var + signed('0'& N_var);
            if C_var > MIN_C then
                C_var := C_var -1;
            end if;
            if B_var <= - signed('0' & N_var) then
                B_var := resize(1 - signed('0' & N_var), B_var'length);
            end if;
            
        elsif B_var > 0 then
            B_var := B_var - signed('0' & N_var);
            if C_var < MAX_C then
                C_var := C_var + 1;
            end if;
            if B_var > 0 then
                B_var := (others=>'0');
            end if;
        end if;
        
        -- Assign outputs
        N_update <= N_var;
        A_update <= A_var;
        B_update <= B_var;
        C_update <= C_var;
        
    end process;

    -- Signal assignments
    valid_data_out  <= valid_data_in;
    ctxt_idx_update <= ctxt_idx;
    
end Behavioral;
