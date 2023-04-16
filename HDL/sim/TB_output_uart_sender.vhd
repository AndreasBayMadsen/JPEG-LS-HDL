----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/08/2023 01:25:22 PM
-- Design Name: 
-- Module Name: TB_output_uart_sender - Behavioral
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

entity TB_output_uart_sender is
--  Port ( );
end TB_output_uart_sender;

architecture Behavioral of TB_output_uart_sender is

    component output_uart_sender
    Port (  resetn          : in  STD_LOGIC;
            pclk            : in  STD_LOGIC;
            clk             : in  STD_LOGIC;
            sig             : out STD_LOGIC;
            
            request_next    : out STD_LOGIC;  -- Set high for getting next value, when it is ready.
            read_allowed    : in  STD_LOGIC;  -- Flag for when clock is connected to logic and BRAM
            dout            : in  STD_LOGIC_VECTOR (63 downto 0); -- Data from BRAM.
            new_data_ready  : in  STD_LOGIC;  -- Flag goes high for one clock, when new data is ready on 'dout'.
            end_of_data     : in  STD_LOGIC   -- Flag goes high when all data for image has been read. Flag goes low when new image/data is available.
            );
    end component;
    
    constant BASE_CLK_FREQ   : REAL  := 125.0;    -- Clock frequency in MHz
    
        -- Derived
    constant BASE_CLK_PER    : TIME  := (1.0/BASE_CLK_FREQ)*1 us;
    constant BASE_CLK_HPER   : TIME  := BASE_CLK_PER/2;
    
    
    constant CLK_FREQ   : REAL  := 12.0;    -- Clock frequency in MHz
    
        -- Derived
    constant CLK_PER    : TIME  := (1.0/CLK_FREQ)*1 us;
    constant CLK_HPER   : TIME  := CLK_PER/2;
    
    signal pclk            :  STD_LOGIC := '1';
    signal clk             :  STD_LOGIC := '1';                  
    signal sig             :  STD_LOGIC;                     
    signal request_next    :  STD_LOGIC;  
    signal read_allowed    :  STD_LOGIC := '0';  
    signal dout            :  STD_LOGIC_VECTOR (63 downto 0) := (others => '0');
    signal new_data_ready  :  STD_LOGIC := '0';  
    signal end_of_data     :  STD_LOGIC := '0';        

begin

    dut : output_uart_sender
        Port map(   resetn => '1'                   ,
                    pclk           => pclk          ,
                    clk            => clk           ,
                    sig            => sig           ,
                    request_next   => request_next  ,
                    read_allowed   => read_allowed  ,
                    dout           => dout          ,
                    new_data_ready => new_data_ready,
                    end_of_data    => end_of_data
                    );
                    
    -- Clock
    pclk <= not pclk after CLK_HPER;
    clk <= not clk after BASE_CLK_HPER;
                    
    stimuli : process
    begin
        wait for 1 ns;
        
        wait for 200 * CLK_PER;
        
        end_of_data <= '0';
        
        wait for 200 * CLK_PER;
        
        read_allowed <= '1';
        
        while request_next = '0' loop
            wait for CLK_PER;
        end loop;
        
        dout <= x"ffeeddccbbaa9988";
        new_data_ready <= '1';
        wait for CLK_PER;
        new_data_ready <= '0';
        
        while request_next = '0' loop
            wait for CLK_PER;
        end loop;
        
        dout <= x"7766554433221100";
        new_data_ready <= '1';
        wait for CLK_PER;
        new_data_ready <= '0';
        end_of_data <= '1';
        
        wait;
    end process;

end Behavioral;
