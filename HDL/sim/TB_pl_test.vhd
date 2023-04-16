----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2023 11:03:57 AM
-- Design Name: 
-- Module Name: TB_pl_test - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_pl_test is
--  Port ( );
end TB_pl_test;

architecture Behavioral of TB_pl_test is
    component BD_pl_test_wrapper
      port (
        LED0        : out STD_LOGIC;
        LED1        : out STD_LOGIC;
        LED2        : out STD_LOGIC;
        LED3        : out STD_LOGIC;
        clk         : in STD_LOGIC;
        en          : in STD_LOGIC;
        rst         : in STD_LOGIC;
        uart_tx     : out STD_LOGIC
      );
    end component;
    
    signal LED0      : STD_LOGIC;
    signal LED1      : STD_LOGIC;
    signal LED2      : STD_LOGIC;
    signal LED3      : STD_LOGIC;
    signal clk       : STD_LOGIC := '1';
    signal en        : STD_LOGIC := '0';
    signal rst       : STD_LOGIC := '0';
    signal uart_tx   : STD_LOGIC;
    
    constant CLK_FREQ   : REAL  := 125.0;    -- Clock frequency in MHz
    
        -- Derived
    constant CLK_PER    : TIME  := (1.0/CLK_FREQ)*1 us;
    constant CLK_HPER   : TIME  := CLK_PER/2;
    
begin

    dut : component BD_pl_test_wrapper
      port map(
        LED0        => LED0   ,
        LED1        => LED1   ,
        LED2        => LED2   ,
        LED3        => LED3   ,
        clk         => clk   ,
        en          => en     ,
        rst         => rst    ,
        uart_tx     => uart_tx
      );

    clk <= not clk after CLK_HPER;

    stimuli : process
    begin
        wait for 1 ms;
        en <= '1';
        wait for 1 ms;
        en <= '0';
        
        wait;
    end process;

end Behavioral;
