----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2023 03:40:26 PM
-- Design Name: 
-- Module Name: golomb_top - Behavioral
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

entity golomb_top is
    Port ( pclk         : in STD_LOGIC;
           valid_data   : in STD_LOGIC;
           k            : in unsigned (5 - 1 downto 0);
           error        : in unsigned (8 - 1 downto 0);
           encoded      : out STD_LOGIC_VECTOR (32 - 1 downto 0);
           size         : out unsigned (5 downto 0)
           );
end golomb_top;

architecture Behavioral of golomb_top is

    component golomb_coder is
        Generic (
            k_width     :   integer := 5;
            beta_max    :   integer := 8;
            L_max       :   integer := 32
        );
        Port ( pclk : in STD_LOGIC;
               valid_data : in STD_LOGIC;
               k : in unsigned (k_width - 1 downto 0);
               error : in unsigned (beta_max - 1 downto 0);
               encoded : out STD_LOGIC_VECTOR (L_max - 1 downto 0);
               size : out unsigned (k_width downto 0));
    end component;

    
    constant k_width : integer := 5;
    constant beta_max : integer := 8;
    constant L_max : integer := 32;

begin

    dut : golomb_coder
        Generic map (
            k_width => k_width,
            beta_max => beta_max,
            L_max => L_max
        )
        Port map ( pclk         =>   pclk      ,
                   valid_data   =>   valid_data,
                   k            =>   k         ,
                   error        =>   error     ,
                   encoded      =>   encoded   ,
                   size         =>   size
           );

end Behavioral;
