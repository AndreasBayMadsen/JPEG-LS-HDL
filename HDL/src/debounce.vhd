----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2023 02:10:07 PM
-- Design Name: 
-- Module Name: debounce - Behavioral
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

entity debounce is
    Generic (   DEBOUNCE_TIME_MS    : INTEGER   := 10;
                CLK_FREQ_MHZ        : INTEGER   := 125);
    Port (  clk     : in    STD_LOGIC   := '1';
            sig_in  : in    STD_LOGIC   := '0';
            sig_out : out   STD_LOGIC   := '0');
end debounce;

architecture Behavioral of debounce is
    -- Constant declarations
    constant DBNC_COUNT_MAX : INTEGER   := DEBOUNCE_TIME_MS*CLK_FREQ_MHZ*1000;
    
    -- Signal declarations
    signal sig_out_buf  : STD_LOGIC := '0';
    signal dbnc_count   : INTEGER   := 0;
    
begin

    -- Signal assignments
    sig_out <= sig_out_buf;

    dbnc: process(clk)
    begin
        if rising_edge(clk) then
            if sig_out_buf /= sig_in then
                dbnc_count <= dbnc_count + 1;
                
                if dbnc_count = DBNC_COUNT_MAX then
                    sig_out_buf <= sig_in;
                end if;
            else
                dbnc_count <= 0;
            end if;
        end if;
    end process;

end Behavioral;
