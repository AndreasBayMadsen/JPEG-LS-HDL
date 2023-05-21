----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/19/2023 03:54:35 PM
-- Design Name: 
-- Module Name: camera_multiplexer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Used to connect/disconnect the camera from the system.
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

entity camera_multiplexer is
    Port (  -- General
            resetn      : in    STD_LOGIC                       := '1';
            -- Camera input port
            pclk        : in    STD_LOGIC                       := '1';             -- NOTE: This should also be lead around the module
            pixel_in    : in    STD_LOGIC_VECTOR(7 downto 0)    := (others=>'0');
            href_in     : in    STD_LOGIC                       := '0';
            vsync_in    : in    STD_LOGIC                       := '0';
            -- Camera output port
            pixel_out   : out   STD_LOGIC_VECTOR(7 downto 0)    := (others=>'0');
            href_out    : out   STD_LOGIC                       := '0';
            vsync_out   : out   STD_LOGIC                       := '0';
            -- Control input port
            connect     : in    STD_LOGIC                       := '0'
            );
end camera_multiplexer;

architecture Behavioral of camera_multiplexer is
    -- Attribute declarations
    attribute ASYNC_REG : STRING;

    -- Signal declarations
    signal connect_sync         : STD_LOGIC := '0';
    attribute ASYNC_REG of connect_sync : signal is "TRUE";
    signal connect_int          : STD_LOGIC := '0';
    
    signal connect_int_latch    : STD_LOGIC := '0';
    
    signal connected            : STD_LOGIC := '0';
begin

    -- Synchronize 'connect' signal
    synchronizer: process(pclk)
    begin
        if rising_edge(pclk) then
            connect_sync    <= connect;
            connect_int     <= connect_sync;
        end if;
    end process;
    
    -- Connect/disconnect between frames
    connector: process(pclk)
        variable connect_int_shift  : STD_LOGIC_VECTOR(1 downto 0)  := (others=>'0');
        variable vsync_shift        : STD_LOGIC_VECTOR(1 downto 0)  := (others=>'0');
    begin
        if rising_edge(pclk) then
            if resetn='0' then
                -- Synchronous reset
                connect_int_latch   <= '0';
                connected           <= '0';
                
                connect_int_shift   := (others=>'0');
                vsync_shift         := (others=>'0');
            else
                connect_int_shift   := connect_int_shift(0) & connect_int;
                vsync_shift         := vsync_shift(0) & vsync_in;
                
                -- Latch request to connect
                if vsync_in = '0' and connect_int_shift = "01" then
                    connect_int_latch <= '1';
                end if;
                
                if vsync_shift = "01" then              -- Apply connection at start of frame
                    if connect_int_latch = '1' then
                        connected           <= '1';
                    end if;
                elsif vsync_shift = "10" then           -- Break connection at end of frame
                    if connect_int_latch = '1' then
                        connect_int_latch <= '0';
                    else
                        connected <= '0';
                    end if;
                end if;
                
            end if;
        end if;
    end process;
    
    -- Signal assignments
    pixel_out   <= pixel_in when connected='1' else (others=>'0');
    href_out    <= href_in when connected='1' else '0';
    vsync_out   <= vsync_in when connected='1' else '0';

end Behavioral;
