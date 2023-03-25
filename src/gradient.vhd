----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2023 08:14:36 AM
-- Design Name: 
-- Module Name: gradient - Behavioral
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

entity gradient is
    Generic (   T1          : INTEGER   := 3;
                T2          : INTEGER   := 7;
                T3          : INTEGER   := 21;
                color_res   : INTEGER   := 5);  -- Number of bits in color
    Port (  clk         : in    STD_LOGIC                       := '0';
            resetn      : in    STD_LOGIC                       := '1';
            A           : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');   -- Pixels surrounding X
            B           : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');
            C           : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');
            D           : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');
            ctxt_idx    : out   UNSIGNED(8 downto 0)            := (others=>'0');   -- Index of current context
            sign        : out   STD_LOGIC                       := '0'
            );
end gradient;

architecture Behavioral of gradient is
    -- Type declarations
    type GRADIENT is array (0 to 2) of INTEGER;

    -- Signal declarations
    signal G            : GRADIENT              := (others=>0);
    signal Q            : GRADIENT              := (others=>0);
    signal Q_corr       : GRADIENT              := (others=>0); -- Q with sign corrected
    signal ctxt_idx_int : INTEGER               := 0;
    
begin

    -- Signal assignments
    ctxt_idx <= to_unsigned(ctxt_idx_int, ctxt_idx'length);
    
    -- Calculate gradients
    G(0)    <= to_integer(D) - to_integer(B);
    G(1)    <= to_integer(B) - to_integer(C);
    G(2)    <= to_integer(C) - to_integer(A);
    
    -- Quantize gradients
    quantize: process(G)
    begin
        for idx in 0 to G'length-1 loop
            if G(idx) <= -T3 then
                Q(idx) <= -4;
            elsif G(idx) <= -T2 then
                Q(idx) <= -3;
            elsif G(idx) <= -T1 then
                Q(idx) <= -2;
            elsif G(idx) < 0 then
                Q(idx) <= -1;
            elsif G(idx) = 0 then
                Q(idx) <= 0;
            elsif G(idx) < T1 then
                Q(idx) <= 1;
            elsif G(idx) < T2 then
                Q(idx) <= 2;
            elsif G(idx) < T3 then
                Q(idx) <= 3;
            else
                Q(idx) <= 4;
            end if;
        end loop;
    end process;
    
    -- Correct sign of context
    sign_correct: process(Q)
    begin
        if (Q(0) < 0)
            OR (Q(0) = 0 AND Q(1) < 0)
            OR (Q(0) = 0 AND Q(1) = 0 AND Q(2) < 0) then
            Q_corr(0)   <= -Q(0);
            Q_corr(1)   <= -Q(1);
            Q_corr(2)   <= -Q(2);
            sign        <= '1';
         else
            Q_corr(0)   <= Q(0);
            Q_corr(1)   <= Q(1);
            Q_corr(2)   <= Q(2);
            sign        <= '0';
         end if;
    end process;
    
    -- Map context to contex index
    addr_map: process(Q_corr)
    begin
        if Q_corr(0) = 0 then
            if Q_corr(1) = 0 then
                ctxt_idx_int <= 360 + Q_corr(2);
            else
                ctxt_idx_int <= 324 + (Q_corr(1)-1)*9 + (Q_corr(2)+4);
            end if;
        else
            ctxt_idx_int <= (Q_corr(0)-1)*81 + (Q_corr(1)+4)*9 + (Q_corr(2)+4);
        end if;
    end process;
    
end Behavioral;
