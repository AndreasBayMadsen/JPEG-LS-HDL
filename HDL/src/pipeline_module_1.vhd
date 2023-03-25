----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2023 07:35:42 PM
-- Design Name: 
-- Module Name: pipine_module_1 - Behavioral
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

entity pipeline_module_1 is
    Generic (   color_res   : INTEGER   := 5);      -- Number of bits for the color
    Port (  -- Global signals
            clk         : in    STD_LOGIC                       := '1';
            resetn      : in    STD_LOGIC                       := '1';
            -- Inputs
            A           : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');   -- Pixels surrounding X
            B           : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');
            C           : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');
            D           : in    UNSIGNED(color_res-1 downto 0)  := (others=>'0');
            -- Outputs
            ctxt_idx    : out   UNSIGNED(8 downto 0)            := (others=>'0');   -- Index of current context
            sign        : out   STD_LOGIC                       := '0';
            X_pred      : out   UNSIGNED(color_res-1 downto 0)  := (others=>'0')    -- Prediction of X
            );
end pipeline_module_1;

architecture Behavioral of pipeline_module_1 is
    -- Component declarations
    component gradient
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
                sign        : out   STD_LOGIC                       := '0');
    end component;
    
    component fixed_predictor
        generic ( 
            color_res   :    INTEGER := 5);
        Port ( 
            pclk :          in  STD_LOGIC;
            A :             in  unsigned    (color_res - 1 downto 0);   -- Pixels surrounding X
            B :             in  unsigned    (color_res - 1 downto 0);
            C :             in  unsigned    (color_res - 1 downto 0);
               
            x_pred :        out unsigned    (color_res - 1 downto 0));  -- Prediction of X
    end component;
    
begin

    -- Component instantiations
    grad: gradient
    generic map(
        color_res   => color_res
    )
    port map(
        clk         => clk,
        resetn      => resetn,
        A           => A,
        B           => B,
        C           => C,
        D           => D,
        ctxt_idx    => ctxt_idx,
        sign        => sign
    );
    
    pred: fixed_predictor
    generic map(
        color_res  => color_res
    )
    port map(
        pclk        => clk,
        A           => A,
        B           => B,
        C           => C,
        x_pred      => X_pred
    );

end Behavioral;
