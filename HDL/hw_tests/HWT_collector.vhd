----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2023 01:51:06 PM
-- Design Name: 
-- Module Name: HWT_collector - Behavioral
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

entity HWT_collector is
    Port (  clk     : in    STD_LOGIC   := '1';
            rst     : in    STD_LOGIC   := '0';
            step    : in    STD_LOGIC   := '0';
            LED     : out   STD_LOGIC   := '0');
end HWT_collector;

architecture Behavioral of HWT_collector is
    -- Component declarations
    component HWT_collector_clk
        Port
         (
          clk_out1          : out    std_logic;
          clk_in1           : in     std_logic
         );
    end component;
        
    component HWT_collector_bram
        Port (
            clka : IN STD_LOGIC;
            wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            addra : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
            dina : IN STD_LOGIC_VECTOR(79 DOWNTO 0);
            clkb : IN STD_LOGIC;
            addrb : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
            doutb : OUT STD_LOGIC_VECTOR(79 DOWNTO 0) 
        );
    end component;

    component debounce
        Generic (   DEBOUNCE_TIME_MS    : INTEGER   := 10;
                    CLK_FREQ_MHZ        : INTEGER   := 125);
        Port (  clk     : in    STD_LOGIC   := '1';
                sig_in  : in    STD_LOGIC   := '0';
                sig_out : out   STD_LOGIC   := '0');
    end component;
    
    component collector
        Generic (
            image_height    : INTEGER   := 500;
            image_width     : INTEGER   := 500
        );
        Port (
            resetn  : in    STD_LOGIC               := '1';
            -- Camera interface
            pclk    : in    STD_LOGIC               := '0';
            pixel   : in    UNSIGNED(7 downto 0)    := (others=>'0');
            href    : in    STD_LOGIC               := '0';
            vsync   : in    STD_LOGIC               := '0';
            -- Output interface
            A           : out   UNSIGNED(15 downto 0)   := (others=>'0');
            B           : out   UNSIGNED(15 downto 0)   := (others=>'0');
            C           : out   UNSIGNED(15 downto 0)   := (others=>'0');
            D           : out   UNSIGNED(15 downto 0)   := (others=>'0');
            X           : out   UNSIGNED(15 downto 0)   := (others=>'0');
            valid_data  : out   STD_LOGIC               := '0'; -- Is high while a frame is being transmitted
            new_pixel   : out   STD_LOGIC               := '0'  -- Pulses for each new pixel (to drive pipeline)
            );
    end component;
    
    component HWT_collector_ila
        Port (
            clk : IN STD_LOGIC;
            probe0 : IN STD_LOGIC_VECTOR(15 DOWNTO 0); 
            probe1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0); 
            probe2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0); 
            probe3 : IN STD_LOGIC_VECTOR(15 DOWNTO 0); 
            probe4 : IN STD_LOGIC_VECTOR(15 DOWNTO 0); 
            probe5 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
            probe6 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
            probe7 : IN STD_LOGIC_VECTOR(7 DOWNTO 0); 
            probe8 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
            probe9 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            probe10 : IN STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    end component;
    
    -- Type declarations
    constant IMAGE_SIZE : INTEGER := 5;
    type IMAGE_TYPE is array (0 to IMAGE_SIZE-1, 0 to IMAGE_SIZE-1) of UNSIGNED(15 downto 0);
    
    type FSM_TYPE is (WAITING, SET_VSYNC, CLEAR_VSYNC, IN_ROW);
    
    -- Constant declarations
    constant IMAGE  : IMAGE_TYPE    := ((x"0000", x"1111", x"2222", x"3333", x"4444"),
                                        (x"5555", x"6666", x"7777", x"8888", x"9999"),
                                        (x"AAAA", x"BBBB", x"CCCC", x"DDDD", x"EEEE"),
                                        (x"FFFF", x"1212", x"1313", x"1414", x"1515"),
                                        (x"1616", x"1717", x"1818", x"1919", x"1A1A"));
    constant TLINE  : INTEGER       := (IMAGE_SIZE + 144)*2;
    
    -- Signal declarations
    signal resetn       : STD_LOGIC                     := '0';
    signal pclk         : STD_LOGIC                     := '1';
    signal pixel        : UNSIGNED(7 downto 0)          := (others=>'0');
    signal href         : STD_LOGIC                     := '0';
    signal vsync        : STD_LOGIC                     := '0';
    signal A            : UNSIGNED(15 downto 0)         := (others=>'0');
    signal B            : UNSIGNED(15 downto 0)         := (others=>'0');
    signal C            : UNSIGNED(15 downto 0)         := (others=>'0');
    signal D            : UNSIGNED(15 downto 0)         := (others=>'0');
    signal X            : UNSIGNED(15 downto 0)         := (others=>'0');
    signal valid_data   : STD_LOGIC                     := '0';
    signal new_pixel    : STD_LOGIC                     := '0';
    
    signal rst_dbnc     : STD_LOGIC                     := '0';
    signal fsm_state    : FSM_TYPE                      := WAITING;
    signal pclk_count   : INTEGER                       := 0;
    signal wait_time    : INTEGER                       := 10;
    signal next_state   : FSM_TYPE                      := SET_VSYNC;
    signal low_byte     : BOOLEAN                       := TRUE;
    signal row_count    : INTEGER                       := 0;
    signal col_count    : INTEGER                       := 0;
    
    signal write_enable     : STD_LOGIC := '0';
    signal write_addr       : UNSIGNED(6 downto 0)          := (others=>'0');
    signal write_addr_vec   : STD_LOGIC_VECTOR(6 downto 0)  := (others=>'0');
    signal write_data       : UNSIGNED(79 downto 0)         := (others=>'0');
    signal write_data_vec   : STD_LOGIC_VECTOR(79 downto 0) := (others=>'0');
    signal read_addr        : UNSIGNED(6 downto 0)          := (others=>'0');
    signal read_addr_vec    : STD_LOGIC_VECTOR(6 downto 0)  := (others=>'0');
    signal read_data        : UNSIGNED(79 downto 0)         := (others=>'0');
    signal read_data_vec    : STD_LOGIC_VECTOR(79 downto 0) := (others=>'0');
    
    signal done             : STD_LOGIC                     := '0';
    signal step_dbnc        : STD_LOGIC                     := '0';
    
    signal A_replay : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
    signal B_replay : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
    signal C_replay : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
    signal D_replay : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
    signal X_replay : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
    
    signal debug_1      : STD_LOGIC_VECTOR(7 downto 0)  := (others=>'0');
    signal pixel_vec    : STD_LOGIC_VECTOR(7 downto 0)  := (others=>'0');
    
begin

    -- Component instantiations
    clk_gen: HWT_collector_clk
    port map(
        clk_out1    => pclk,
        clk_in1     => clk
    );
    
    bram: HWT_collector_bram
    port map(
        clka    => pclk,
        wea(0)  => write_enable,
        addra   => write_addr_vec,
        dina    => write_data_vec,
        clkb    => pclk,
        addrb   => read_addr_vec,
        doutb   => read_data_vec
    );
    
    reset_debounce: debounce
    port map(
        clk     => pclk,
        sig_in  => rst,
        sig_out => rst_dbnc
    );
    
    step_debounce: debounce
    port map(
        clk     => pclk,
        sig_in  => step,
        sig_out => step_dbnc
    );
    
    ila: HWT_collector_ila
    port map(
        clk         => clk,
        probe0      => A_replay,
        probe1      => B_replay,
        probe2      => C_replay,
        probe3      => D_replay,
        probe4      => X_replay,
        probe5(0)   => vsync,
        probe6(0)   => href,
        probe7      => pixel_vec,
        probe8(0)   => valid_data,
        probe9(0)   => new_pixel,
        probe10     => debug_1
    );
    
    DUT: collector
    generic map(
        image_height    => 5,
        image_width     => 5
    )
    port map(
        resetn      => resetn,
        pclk        => pclk,
        pixel       => pixel,
        href        => href,
        vsync       => vsync,
        A           => A,
        B           => B,
        C           => C,
        D           => D,
        X           => X,
        valid_data  => valid_data,
        new_pixel   => new_pixel
    );
    
    -- Processes
    stim: process(pclk)
    begin
        if falling_edge(pclk) then
            if resetn = '0' then
                -- Synchronous reset
                pixel   <= (others=>'0');
                href    <= '0';
                vsync   <= '0';
                
                fsm_state   <= WAITING;
                pclk_count  <= 0;
                wait_time   <= 10;
                next_state  <= SET_VSYNC;
                low_byte    <= TRUE;
                row_count   <= 0;
                col_count   <= 0;
                done        <= '0';
                
                debug_1     <= (others=>'0');
            else
                -- Default values
                href    <= '0';
                debug_1 <= "00000000";
                
                -- Counters
                pclk_count <= pclk_count + 1;
            
                case fsm_state is
                    when WAITING =>
                        debug_1(0)  <= '1';
                        if pclk_count = wait_time then
                            debug_1(7 downto 4) <= "0001";
                            pclk_count  <= 0;
                            fsm_state   <= next_state;
                        end if;
                        
                    when SET_VSYNC =>
                        debug_1(1)  <= '1';
                        vsync <= '1';
                        
                        pclk_count  <= 0;
                        wait_time   <= 3*TLINE;
                        next_state  <= CLEAR_VSYNC;
                        fsm_state   <= WAITING;
                        
                    when CLEAR_VSYNC =>
                        debug_1(2)  <= '1';
                        vsync <= '0';
                        
                        pclk_count  <= 0;
                        wait_time   <= 17*TLINE;
                        next_state  <= IN_ROW;
                        fsm_state   <= WAITING;
                        
                    when IN_ROW =>
                        debug_1(3)  <= '1';
                        href <= '1';
                        
                        if low_byte then    -- I THINK THE ORDER IS WRONG! IT SHOULD START WITH THE HIGH BYTE!
                            debug_1(7 downto 4) <= "0001";
                            pixel       <= image(row_count, col_count)(7 downto 0);
                            low_byte    <= FALSE;
                        else
                            debug_1(7 downto 4) <= "0010";
                            pixel       <= image(row_count, col_count)(15 downto 8);
                            low_byte    <= TRUE;
                            
                            if col_count < IMAGE_SIZE-1 then
                                -- Normal pixel
                                debug_1(7 downto 4) <= "0011";
                                col_count <= col_count + 1;
                            elsif row_count < IMAGE_SIZE-1 then
                                -- Pixel at end of normal row
                                debug_1(7 downto 4) <= "0100";
                                col_count <= 0;
                                row_count <= row_count + 1;
                                
                                pclk_count  <= 0;
                                wait_time   <= 144*2;
                                next_state  <= IN_ROW;
                                fsm_state   <= WAITING;
                            else
                                -- Pixel at end of last row
                                debug_1(7 downto 4) <= "0101";
                                col_count   <= 0;
                                row_count   <= 0;
                                
                                pclk_count  <= 0;
                                wait_time   <= 10*TLINE;
                                next_state  <= WAITING;     -- Wait forever
                                fsm_state   <= WAITING;
                                
                                done        <= '1';
                            end if;
                        end if;
                        
                end case;
            end if;
        end if;
    end process;
    
    logger: process(pclk)
        variable write_addr_var : UNSIGNED(6 downto 0)  := (others=>'0');
    begin
        if rising_edge(pclk) then
            if resetn = '0' then
                -- Synchronous reset
                write_enable    <= '0';
                write_addr      <= (others=>'0');
                write_data      <= (others=>'0');
                
                write_addr_var  := (others=>'0');
            else
                -- Default values
                write_enable <= '0';
            
                if new_pixel = '1' then
                    write_addr      <= write_addr_var;
                    write_data      <= A & B & C & D & X;
                    write_enable    <= '1';
                    
                    write_addr_var  := write_addr_var + 1;
                end if;
            end if;
        end if;
    end process;
    
    presenter: process(pclk)
        variable step_shift : STD_LOGIC_VECTOR(1 downto 0)  := (others=>'0');
    begin
        if rising_edge(pclk) then
            if resetn = '0' then
                -- Synchronous reset
                read_addr   <= (others=>'0');
                
                step_shift := "00";
            else
                -- Shift registers
                step_shift := step_shift(0) & step_dbnc;
                
                if done = '1' then
                    if step_shift = "01" then
                        read_addr <= read_addr + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;
    
    -- Signal assignments
    resetn          <= not rst_dbnc;
    write_addr_vec  <= std_logic_vector(write_addr);
    write_data_vec  <= std_logic_vector(write_data);
    read_addr_vec   <= std_logic_vector(read_addr);
    read_data       <= unsigned(read_data_vec);
    
    A_replay    <= read_data_vec(79 downto 64);
    B_replay    <= read_data_vec(63 downto 48);
    C_replay    <= read_data_vec(47 downto 32);
    D_replay    <= read_data_vec(31 downto 16);
    X_replay    <= read_data_vec(15 downto 0);
    
    LED         <= done;
    pixel_vec   <= std_logic_vector(pixel);

end Behavioral;
