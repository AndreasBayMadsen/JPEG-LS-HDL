----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2023 02:37:39 PM
-- Design Name: 
-- Module Name: pipeline_module_4 - Behavioral
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

entity pipeline_module_4 is
    Generic (   color_res   : INTEGER   := 5;   -- Number of bits associated with the color
                N_size      : INTEGER   := 7;
                B_size      : INTEGER   := 5;
                k_width     : INTEGER   := 5;
                L_max       : INTEGER   := 32   -- Maximum allowable code length
            );
    Port (  -- Inputs
            k               : in    UNSIGNED(k_width-1 downto 0)        := (others=>'0');
            error           : in    SIGNED(color_res-1 downto 0)        := (others=>'0');
                -- Context data
            N               : in    UNSIGNED(N_size-1 downto 0)         := (others=>'0');
            B               : in    SIGNED(B_size-1 downto 0)           := (others=>'0');
            -- Outputs
            encoded         : out STD_LOGIC_VECTOR (L_max - 1 downto 0) := (others=>'0');
            size            : out UNSIGNED(k_width downto 0)            := (others=>'0')
            );
end pipeline_module_4;

architecture Behavioral of pipeline_module_4 is
    -- Component declarations
    component error_mapper
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
    end component;
    
    component golomb_coder
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
    end component;
    
    -- Signal declarations
    signal mapped_error : UNSIGNED(color_res-1 downto 0)    := (others=>'0');
    
begin

    -- Component instantiations
    mapper: error_mapper
    generic map(
        color_res   => color_res,
        N_size      => N_size,
        B_size      => B_size,
        k_width     => k_width
    )
    port map(
        k               => k,
        error           => error,
        N               => N,
        B               => B,
        mapped_error    => mapped_error
    );
    
    encoder: golomb_coder
    generic map(
        k_width     => k_width,
        beta_max    => color_res,
        L_max       => L_max
    )
    port map(
        pclk        => open,
        valid_data  => open,
        k           => k,
        error       => mapped_error,
        encoded     => encoded,
        size        => size
    );


end Behavioral;
