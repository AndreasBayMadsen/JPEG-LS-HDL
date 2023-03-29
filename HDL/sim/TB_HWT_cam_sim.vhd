----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2023 11:12:12 AM
-- Design Name: 
-- Module Name: TB_HWT_cam_sim - Behavioral
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

entity TB_HWT_cam_sim is
--  Port ( );
end TB_HWT_cam_sim;

architecture Behavioral of TB_HWT_cam_sim is
    -- Component declarations
    component HWT_cam_sim
        Generic (   -- Image info
                    image_height    : INTEGER   := 500; -- NOTE: Must be set according to test images
                    image_width     : INTEGER   := 500;
                    -- RAM interface
                    ram_addr_width  : INTEGER   := 32;
                    ram_data_width  : INTEGER   := 32;
                    ram_we_width    : INTEGER   := 4);
        Port (  -- General signals
                resetn  : in    STD_LOGIC           := '1'; -- Active LOW reset
                clk     : in    STD_LOGIC           := '1'; -- High frequency clock
                enable  : in    STD_LOGIC           := '0'; -- A pulse enables the module
                -- Camera interface
                pclk            : out   STD_LOGIC                                   := '1';
                pixel           : out   STD_LOGIC_VECTOR(7 downto 0)                := (others=>'0');
                href            : out   STD_LOGIC                                   := '0';
                vsync           : out   STD_LOGIC                                   := '0';
                -- RAM interface
                ram_reset       : out   STD_LOGIC                                   := '0';
                ram_clk         : out   STD_LOGIC                                   := '1';
                ram_en          : out   STD_LOGIC                                   := '0';
                ram_addr        : out   STD_LOGIC_VECTOR(ram_addr_width-1 downto 0) := (others=>'0');
                ram_read_data   : in    STD_LOGIC_VECTOR(ram_data_width-1 downto 0) := (others=>'0');
                ram_write_data  : out   STD_LOGIC_VECTOR(ram_data_width-1 downto 0) := (others=>'0');
                ram_we          : out   STD_LOGIC_VECTOR(ram_we_width-1 downto 0)   := (others=>'0')
        );
    end component;
    
    component TB_HWT_cam_sim_bram
        Port (
            clka        : IN STD_LOGIC;
            rsta        : IN STD_LOGIC;
            ena         : IN STD_LOGIC;
            wea         : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            addra       : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            dina        : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            douta       : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            rsta_busy   : OUT STD_LOGIC 
        );
    end component;
    
    -- Constant declarations
        -- Base
    constant IMAGE_HEIGHT   : INTEGER   := 240;
    constant IMAGE_WIDTH    : INTEGER   := 320;
    constant CLK_FREQ_MHZ   : INTEGER   := 125;
    
    constant TP             : INTEGER   := 2;
    constant TLINE          : INTEGER   := (IMAGE_WIDTH + 144)*TP;
    
        -- Derived
    constant CLK_PER        : TIME      := (1.0/real(CLK_FREQ_MHZ))*1us;
    constant CLK_HPER       : TIME      := CLK_PER/2;
    
    -- Signal declarations
    signal clk      : STD_LOGIC := '1';
    
    signal enable           : STD_LOGIC                     := '0';
    signal pclk             : STD_LOGIC                     := '1';
    signal pixel            : STD_LOGIC_VECTOR(7 downto 0)  := (others=>'0');
    signal href             : STD_LOGIC                     := '0';
    signal vsync            : STD_LOGIC                     := '0';
    signal ram_reset        : STD_LOGIC                     := '0';
    signal ram_clk          : STD_LOGIC                     := '1';
    signal ram_en           : STD_LOGIC                     := '0';
    signal ram_addr         : STD_LOGIC_VECTOR(31 downto 0) := (others=>'0');
    signal ram_read_data    : STD_LOGIC_VECTOR(31 downto 0) := (others=>'0');
    signal ram_write_data   : STD_LOGIC_VECTOR(31 downto 0) := (others=>'0');
    signal ram_we           : STD_LOGIC_VECTOR(3 downto 0)  := (others=>'0');
    
begin

    -- Component instantiations
    DUT: HWT_cam_sim
    generic map(
        image_height    => IMAGE_HEIGHT,
        image_width     => IMAGE_WIDTH
    )
    port map(
        resetn          => '1',
        clk             => clk,
        enable          => enable,
        pclk            => pclk,
        pixel           => pixel,
        href            => href,
        vsync           => vsync,
        ram_reset       => ram_reset,
        ram_clk         => ram_clk,
        ram_en          => ram_en,
        ram_addr        => ram_addr,
        ram_read_data   => ram_read_data,
        ram_write_data  => ram_write_data,
        ram_we          => ram_we
    );
    
    BRAM: TB_HWT_cam_sim_bram
    port map(
        clka        => ram_clk,
        rsta        => ram_reset,
        ena         => ram_en,
        wea         => ram_we,
        addra       => ram_addr,
        dina        => ram_write_data,
        douta       => ram_read_data,
        rsta_busy   => open
    );
    
    -- Stimuli
    clk <= not clk after CLK_HPER;
    
    stim: process
        variable pclk_count : INTEGER   := 0;
    begin
        wait for 10*CLK_PER;
        wait until rising_edge(pclk);
        enable <= '1';
        wait until rising_edge(pclk);
        enable <= '0';
        
        while pclk_count < 2*IMAGE_HEIGHT*TLINE loop
            wait until rising_edge(pclk);
            pclk_count := pclk_count + 1;
        end loop;
        wait until rising_edge(pclk);
        enable <= '1';
        wait until rising_edge(pclk);
        enable <= '0';
        
        wait;
    end process;
    
end Behavioral;
