----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/26/2023 11:01:41 AM
-- Design Name: 
-- Module Name: HWT_cam_sim - Behavioral
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

--entity my_module is
--  port (

--  <s_en> : in std_logic; -- Chip Enable Signal (optional)
--  <s_dout> : out std_logic_vector(<left_bound> downto 0); -- Data Out Bus (optional)
--  <s_din> : in std_logic_vector(<left_bound> downto 0); -- Data In Bus (optional)
--  <s_we> : in std_logic_vector(<left_bound> downto 0); -- Byte Enables (optional)
--  <s_addr> : in std_logic_vector(<left_bound> downto 0); -- Address Signal (required)
--  <s_clk> : in std_logic; -- Clock Signal (required)
--  <s_rst> : in std_logic; -- Reset Signal (required)
--  --  additional ports here

--  );
--end my_module;
--architecture arch_impl of my_module is

--  ATTRIBUTE X_INTERFACE_INFO : STRING;
--  ATTRIBUTE X_INTERFACE_INFO of <s_en>: SIGNAL is "xilinx.com:interface:bram:1.0 <interface_name> EN";
--  ATTRIBUTE X_INTERFACE_INFO of <s_dout>: SIGNAL is "xilinx.com:interface:bram:1.0 <interface_name> DOUT";
--  ATTRIBUTE X_INTERFACE_INFO of <s_din>: SIGNAL is "xilinx.com:interface:bram:1.0 <interface_name> DIN";
--  ATTRIBUTE X_INTERFACE_INFO of <s_we>: SIGNAL is "xilinx.com:interface:bram:1.0 <interface_name> WE";
--  ATTRIBUTE X_INTERFACE_INFO of <s_addr>: SIGNAL is "xilinx.com:interface:bram:1.0 <interface_name> ADDR";
--  ATTRIBUTE X_INTERFACE_INFO of <s_clk>: SIGNAL is "xilinx.com:interface:bram:1.0 <interface_name> CLK";
--  ATTRIBUTE X_INTERFACE_INFO of <s_rst>: SIGNAL is "xilinx.com:interface:bram:1.0 <interface_name> RST";
--  -- Uncomment the following to set interface specific parameter on the bus interface.
--  --  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
--  --  ATTRIBUTE X_INTERFACE_PARAMETER of <port_name>: SIGNAL is "MASTER_TYPE <value>,MEM_ECC <value>,MEM_WIDTH <value>,MEM_SIZE <value>,READ_WRITE_MODE <value>";


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

entity HWT_cam_sim is
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
end HWT_cam_sim;

architecture Behavioral of HWT_cam_sim is
    -- Component declarations
    component HWT_cam_sim_clk
        Port (
          clk_out1  : out   STD_LOGIC;
          clk_in1   : in    STD_LOGIC
         );
    end component;
    
    -- Attributes
    attribute X_INTERFACE_INFO                      : STRING;
    attribute X_INTERFACE_INFO of ram_reset         : signal is "xilinx.com:interface:bram:1.0 BRAM_interface RST";
    attribute X_INTERFACE_INFO of ram_clk           : signal is "xilinx.com:interface:bram:1.0 BRAM_interface CLK";
    attribute X_INTERFACE_INFO of ram_en            : signal is "xilinx.com:interface:bram:1.0 BRAM_interface EN";
    attribute X_INTERFACE_INFO of ram_addr          : signal is "xilinx.com:interface:bram:1.0 BRAM_interface ADDR";
    attribute X_INTERFACE_INFO of ram_read_data     : signal is "xilinx.com:interface:bram:1.0 BRAM_interface DOUT";
    attribute X_INTERFACE_INFO of ram_write_data    : signal is "xilinx.com:interface:bram:1.0 BRAM_interface DIN";
    attribute X_INTERFACE_INFO of ram_we            : signal is "xilinx.com:interface:bram:1.0 BRAM_interface WE";
        
    -- Type declarations
    type FSM_TYPE is (WAIT_ENABLE, WAITING, SET_VSYNC, CLEAR_VSYNC, IN_ROW);
    
    -- Constant declarations
    constant TP             : INTEGER   := 2;
    constant TLINE          : INTEGER   := (IMAGE_WIDTH + 144)*TP;
    
    -- Signal declarations
        -- General
    signal pclk_int         : STD_LOGIC := '1';
    
        -- Stimuli
    signal fsm_state        : FSM_TYPE      := WAIT_ENABLE;
    signal pclk_count       : INTEGER       := 0;
    signal wait_time        : INTEGER       := 0;
    signal next_state       : FSM_TYPE      := WAIT_ENABLE;
    signal high_byte        : BOOLEAN       := TRUE;
    signal row_count        : INTEGER       := 0;
    signal col_count        : INTEGER       := 0;
    
    signal high_pixel       : BOOLEAN       := TRUE;
    signal fetched_pixel    : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
    signal double_pixel     : STD_LOGIC_VECTOR(31 downto 0)         := (others=>'0');
    
    signal ram_addr_int     : UNSIGNED(ram_addr'length-1 downto 0)  := (others=>'0');
    
begin

    -- Component instantiations
    pclk_gen: HWT_cam_sim_clk
    port map(
        clk_out1    => pclk_int,
        clk_in1     => clk
    );
    
    -- Processes
    stim: process(pclk_int)
    begin
        if falling_edge(pclk_int) then
            if resetn = '0' then
                -- Synchronous reset
                href    <= '0';
                vsync   <= '0';
                
                fsm_state       <= WAIT_ENABLE;
                pclk_count      <= 0;
                wait_time       <= 0;
                next_state      <= WAIT_ENABLE;
                high_byte       <= TRUE;
                row_count       <= 0;
                col_count       <= 0;
                
                high_pixel      <= TRUE;
                fetched_pixel   <= (others=>'0');
                double_pixel    <= (others=>'0');
                ram_addr_int    <= (others=>'0');
            else
                -- Default values
                href    <= '0';
                
                -- Counters
                pclk_count <= pclk_count + 1;
                
                case fsm_state is
                    -- Wait for a triggering enable signal
                    when WAIT_ENABLE =>
                        -- Reset signals
                        high_pixel      <= TRUE;
                        fetched_pixel   <= (others=>'0');
                        double_pixel    <= (others=>'0');
                        ram_addr_int    <= (others=>'0');
                        
                        high_byte       <= TRUE;
                        row_count       <= 0;
                        col_count       <= 0;
                    
                        if enable = '1' then
                            fsm_state   <= SET_VSYNC;
                        end if;
                        
                    -- Wait for specified period of time
                    when WAITING =>
                        if pclk_count = wait_time then
                            pclk_count      <= 0;
                            fsm_state       <= next_state;
                        end if;
                        
                    -- Set the VSYNC signal
                    when SET_VSYNC =>
                        vsync <= '1';
                        
                        pclk_count      <= 0;
                        wait_time       <= 3*TLINE;
                        next_state      <= CLEAR_VSYNC;
                        fsm_state       <= WAITING;
                        
                    -- Clear the VSYNC signal
                    when CLEAR_VSYNC =>
                        vsync <= '0';
                        
                        pclk_count  <= 0;
                        wait_time   <= 17*TLINE;
                        next_state  <= IN_ROW;
                        fsm_state   <= WAITING;
                        
                        -- Get first pair of pixels
                        double_pixel    <= ram_read_data;
                        fetched_pixel   <= ram_read_data(31 downto 16);
                        high_pixel      <= FALSE;
                        ram_addr_int    <= ram_addr_int + 1;
                        
                    -- Transmit pixel values
                    when IN_ROW =>
                        href <= '1';
                        
                        -- Apply outputs
                        if high_byte then
                            pixel       <= fetched_pixel(15 downto 8);
                            high_byte   <= FALSE;
                        else
                            pixel       <= fetched_pixel(7 downto 0);
                            high_byte   <= TRUE;
                            
                            if col_count < IMAGE_WIDTH-1 then
                                -- Normal pixel
                                col_count <= col_count + 1;
                            elsif row_count < IMAGE_HEIGHT-1 then
                                -- Pixel at end of normal row
                                col_count <= 0;
                                row_count <= row_count + 1;
                                
                                pclk_count      <= 0;
                                wait_time       <= 144*TP;
                                next_state      <= IN_ROW;
                                fsm_state       <= WAITING;
                            else
                                -- Pixel at end of last row
                                col_count   <= 0;
                                row_count   <= 0;
                                
                                pclk_count      <= 0;
                                wait_time       <= 10*TLINE;
                                next_state      <= WAIT_ENABLE;
                                fsm_state       <= WAITING;
                            end if;
                        end if;
                        
                        -- Fetch new pixel
                        if not high_byte then
                            if high_pixel then
                                fetched_pixel   <= double_pixel(31 downto 16);
                                high_pixel      <= FALSE;
                            else
                                fetched_pixel   <= double_pixel(15 downto 0);
                                high_pixel      <= TRUE;
                                
                                -- Get new double pixel
                                double_pixel    <= ram_read_data;
                                ram_addr_int    <= ram_addr_int + 1;
                            end if;
                        end if;
                        
                end case;
            end if;
        end if;
    end process;
    
    -- Signal assignments
    pclk    <= pclk_int;
    
    ram_reset       <= '0';
    ram_clk         <= not pclk_int;
    ram_en          <= '1';
    ram_addr        <= std_logic_vector(shift_left(ram_addr_int, 2));
    ram_write_data  <= (others=>'0');
    ram_we          <= (others=>'0');

end Behavioral;
