----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2023 08:15:11 AM
-- Design Name: 
-- Module Name: TB_gradient - Behavioral
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

entity TB_gradient is
--  Port ( );
end TB_gradient;

architecture Behavioral of TB_gradient is
    -- Component declarations
    component gradient
        Generic (   T1          : INTEGER   := 3;
                    T2          : INTEGER   := 7;
                    T3          : INTEGER   := 21;
                    color_res   : INTEGER   := 5);  -- Number of bits in color
        Port (  clk         : in    STD_LOGIC               := '0';
                resetn      : in    STD_LOGIC               := '1';
                A           : in    UNSIGNED(color_res-1 downto 0)   := (others=>'0');
                B           : in    UNSIGNED(color_res-1 downto 0)   := (others=>'0');
                C           : in    UNSIGNED(color_res-1 downto 0)   := (others=>'0');
                D           : in    UNSIGNED(color_res-1 downto 0)   := (others=>'0');
                ctxt_idx    : out   UNSIGNED(8 downto 0)    := (others=>'0');
                sign        : out   STD_LOGIC                       := '0');
    end component;
    
    -- Constant declarations
        -- Base
    constant CLK_FREQ   : REAL  := 24.0;    -- Clock frequency in MHz
    
        -- Derived
    constant CLK_PER    : TIME  := (1.0/CLK_FREQ)*1 us;
    constant CLK_HPER   : TIME  := CLK_PER/2;
    
    -- Signal declarations
    signal clk      : STD_LOGIC             := '1';
    signal resetn   : STD_LOGIC             := '1';
    signal A_uns    : UNSIGNED(4 downto 0)  := (others=>'0');
    signal B_uns    : UNSIGNED(4 downto 0)  := (others=>'0');
    signal C_uns    : UNSIGNED(4 downto 0)  := (others=>'0');
    signal D_uns    : UNSIGNED(4 downto 0)  := (others=>'0');
    signal ctxt_idx : UNSIGNED(8 downto 0)  := (others=>'0');
    
    signal A    : INTEGER   := 0;
    signal B    : INTEGER   := 0;
    signal C    : INTEGER   := 0;
    signal D    : INTEGER   := 0;
    signal sign : STD_LOGIC := '0';
    
begin

    -- Component instantiations
    DUT: gradient
    port map(
        clk         => clk,
        resetn      => resetn,
        A           => A_UNS,
        B           => B_UNS,
        C           => C_UNS,
        D           => D_UNS,
        ctxt_idx    => ctxt_idx,
        sign        => sign
    );
    
    -- Signal assignments
    A_uns   <= to_unsigned(A, A_uns'length);
    B_uns   <= to_unsigned(B, B_uns'length);
    C_uns   <= to_unsigned(C, C_uns'length);
    D_uns   <= to_unsigned(D, D_uns'length);
    
    -- Stimuli
    clk <= not clk after CLK_HPER;
    
    stim: process
    begin
        wait for 5*CLK_PER;
        A  <= 4;
        B  <= 11;
        C  <= 9;
        D  <= 11;
        wait for 5*CLK_PER;
        A  <= 11;
        B  <= 11;
        C  <= 15;
        D  <= 26;
        wait for 5*CLK_PER;
        A  <= 27;
        B  <= 3;
        C  <= 28;
        D  <= 3;
        wait for 5*CLK_PER;
        A  <= 11;
        B  <= 19;
        C  <= 11;
        D  <= 22;
        wait for 5*CLK_PER;
        A  <= 24;
        B  <= 27;
        C  <= 26;
        D  <= 29;
    end process;

end Behavioral;
