----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2023 11:21:12 AM
-- Design Name: 
-- Module Name: context_modeller - Behavioral
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
use IEEE.MATH_REAL.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity context_modeller is
    Generic (   color_res       : INTEGER   := 5;   -- Number of bits associated with the color
                N_size          : INTEGER   := 7;   -- Set to at least ceil(log2(N_reset+1))
                A_size          : INTEGER   := 11;  -- Set to at least ceil(log2(N_reset) + color_res - 1)
                B_size          : INTEGER   := 12;  -- Set to at least 1 + ceil(log2(N_reset) + color_res - 1)
                C_size          : INTEGER   := 5;   -- Should be the same as 'color_res'
                num_contexts    : INTEGER   := 365  -- Number of contexts to manage
                );
    Port (  -- Global signals
            clk         : in    STD_LOGIC   := '1';
            resetn      : in    STD_LOGIC   := '1';
            -- Read port
            ctxt_idx    : in    UNSIGNED(8 downto 0)        := (others=>'0');
            N_current   : out   UNSIGNED(N_size-1 downto 0) := (others=>'0');
            A_current   : out   UNSIGNED(A_size-1 downto 0) := (others=>'0');
            B_current   : out   SIGNED(b_size-1 downto 0)   := (others=>'0');
            C_current   : out   SIGNED(c_size-1 downto 0)   := (others=>'0');
            -- Write port
            en                  : in    STD_LOGIC                   := '0';
            valid_data          : in    STD_LOGIC                   := '0';
            valid_update_data   : in    STD_LOGIC                   := '0';     -- States whether the data to update is valid
            ctxt_idx_update     : in    UNSIGNED(8 downto 0)        := (others=>'0');
            N_update            : in    UNSIGNED(N_size-1 downto 0) := (others=>'0');
            A_update            : in    UNSIGNED(A_size-1 downto 0) := (others=>'0');
            B_update            : in    SIGNED(B_size-1 downto 0)   := (others=>'0');
            C_update            : in    SIGNED(C_size-1 downto 0)   := (others=>'0')
            );
end context_modeller;

architecture Behavioral of context_modeller is
    -- Component declarations
    component context_modeller_bram
        Port (
            clka    : in STD_LOGIC;
            wea     : in STD_LOGIC_VECTOR(0 downto 0);
            addra   : in STD_LOGIC_VECTOR(8 downto 0);
            dina    : in STD_LOGIC_VECTOR(39 downto 0); -- Fewer bits could be used
            clkb    : in STD_LOGIC;
            addrb   : in STD_LOGIC_VECTOR(8 downto 0);
            doutb   : out STD_LOGIC_VECTOR(39 downto 0) 
        );
    end component;

    -- Constant declarations
    constant mem_N_range_low    : INTEGER   := 0;
    constant mem_N_range_high   : INTEGER   := N_size-1;
    constant mem_A_range_low    : INTEGER   := mem_N_range_high+1;
    constant mem_A_range_high   : INTEGER   := mem_A_range_low+A_size-1;
    constant mem_B_range_low    : INTEGER   := mem_A_range_high+1;
    constant mem_B_range_high   : INTEGER   := mem_B_range_low+B_size-1;
    constant mem_C_range_low    : INTEGER   := mem_B_range_high+1;
    constant mem_C_range_high   : INTEGER   := mem_C_range_low+C_size-1;
    
    constant alpha          : INTEGER   := 2**color_res;
    constant N_reset_int    : INTEGER   := 1;
    constant A_reset_int    : INTEGER   := integer(realmax(2.0, floor((real(alpha) + 32.0) / 64.0)));
    constant B_reset_int    : INTEGER   := 0;
    constant C_reset_int    : INTEGER   := 0;
    
    constant N_reset    : STD_LOGIC_VECTOR(N_size-1 downto 0)   := std_logic_vector(to_unsigned(N_reset_int, N_size));
    constant A_reset    : STD_LOGIC_VECTOR(A_size-1 downto 0)   := std_logic_vector(to_unsigned(A_reset_int, A_size));
    constant B_reset    : STD_LOGIC_VECTOR(B_size-1 downto 0)   := std_logic_vector(to_signed(B_reset_int, B_size));
    constant C_reset    : STD_LOGIC_VECTOR(C_size-1 downto 0)   := std_logic_vector(to_signed(C_reset_int, C_size));
    
    constant util_bits  : INTEGER                                   := N_update'length + A_update'length + B_update'length + C_update'length;
    constant fill_bits  : INTEGER                                   := 40 - util_bits;
    constant fill_vec   : STD_LOGIC_VECTOR(fill_bits-1 downto 0)    := (others=>'0');
    
    -- Type declarations
    type FSM_STATE_TYPE is (ACTIVE, RESET);
    
    -- Signal declarations
    signal fsm_state        : FSM_STATE_TYPE    := RESET;
    
    signal mem_read_addr    : STD_LOGIC_VECTOR(8 downto 0)  := (others=>'0');   -- Must equal BRAM dimensions
    signal mem_read_data    : STD_LOGIC_VECTOR(39 downto 0) := (others=>'0');   -- Must equal BRAM dimensions
    
    signal mem_we           : STD_LOGIC := '0';
    signal mem_we_muxed     : STD_LOGIC := '0'; -- Directly connected to RAM
    signal mem_write_addr   : STD_LOGIC_VECTOR(8 downto 0)  := (others=>'0');
    signal mem_write_data   : STD_LOGIC_VECTOR(39 downto 0) := (others=>'0');
    
    signal mem_reset_addr       : UNSIGNED(8 downto 0)          := (others=>'0');
    signal next_mem_reset_addr  : UNSIGNED(8 downto 0)          := (others=>'0');
    signal mem_reset_flag       : STD_LOGIC                     := '0';
    
    signal N_current_mem    : UNSIGNED(N_size-1 downto 0)   := (others=>'0');
    signal A_current_mem    : UNSIGNED(A_size-1 downto 0)   := (others=>'0');
    signal B_current_mem    : SIGNED(B_size-1 downto 0)     := (others=>'0');
    signal C_current_mem    : SIGNED(C_size-1 downto 0)     := (others=>'0');
    
begin

    -- Component instantiations
    mem: context_modeller_bram
    port map(
        clka    => clk,
        wea(0)  => mem_we_muxed,
        addra   => mem_write_addr,
        dina    => mem_write_data,
        clkb    => clk,
        addrb   => mem_read_addr,
        doutb   => mem_read_data
    );
    
    -- Update context data
    update: process(clk)
    begin
        if rising_edge(clk) then
            if resetn = '0' then
                -- Synchronous reset
                fsm_state   <= RESET;
                mem_we      <= '0';
                
                mem_reset_flag      <= '0';
                mem_reset_addr      <= (others=>'0');
                next_mem_reset_addr <= (others=>'0');
            else
                -- Default values
                mem_we <= '0';
                
                case fsm_state is
                    -- Write new values to RAM
                    when ACTIVE =>
                        if valid_data = '1' then
                            mem_reset_flag <= '0';
                        
                            if en = '1' then
                                mem_we  <= '1';
                            end if;
                        elsif mem_reset_flag = '0' then
                            fsm_state           <= RESET;
                            mem_reset_addr  <= (others=>'0');
                            next_mem_reset_addr <= (others=>'0');
                        end if;
                        
                    -- Reset the RAM
                    when RESET =>
                        mem_reset_addr <= next_mem_reset_addr;
                        if mem_reset_addr <= num_contexts then  -- NOTE: Make sure delay before being able to write at power-on is not a problem
                            mem_we              <= '1';     -- Write reset value
                            next_mem_reset_addr <= next_mem_reset_addr + 1;
                        else
                            fsm_state       <= ACTIVE;
                            mem_reset_flag  <= '1';
                        end if;
                end case;
            end if;
        end if;
    end process;

    -- Signal assignments
        -- Context data read from memory
    mem_read_addr   <= std_logic_vector(ctxt_idx);
    N_current_mem   <= unsigned(mem_read_data(mem_N_range_high downto mem_N_range_low));
    A_current_mem   <= unsigned(mem_read_data(mem_A_range_high downto mem_A_range_low));
    B_current_mem   <= signed(mem_read_data(mem_B_range_high downto mem_B_range_low));
    C_current_mem   <= signed(mem_read_data(mem_C_range_high downto mem_C_range_low));
    
        -- New context data to write to memory
    mem_write_addr  <= std_logic_vector(ctxt_idx_update) when fsm_state=ACTIVE else std_logic_vector(mem_reset_addr);
    mem_write_data  <= fill_vec &
                        std_logic_vector(C_update) &
                        std_logic_vector(B_update) &
                        std_logic_vector(A_update) &
                        std_logic_vector(N_update) when fsm_state=ACTIVE
                        else
                        fill_vec &
                        C_reset &
                        B_reset &
                        A_reset &
                        N_reset;
    mem_we_muxed    <= mem_we when fsm_state=RESET else                             -- Allow writing when resetting
                        mem_we when fsm_state=ACTIVE and valid_update_data='1' else -- Allow writing in ACTIVE when there is valid data
                        '0';

        -- Choose new context data in case of recurring index
    N_current   <= N_current_mem when (ctxt_idx /= ctxt_idx_update or valid_update_data = '0') else N_update;    -- NOTE: This looks like it is inverted (wrong) in RTL view
    A_current   <= A_current_mem when (ctxt_idx /= ctxt_idx_update or valid_update_data = '0') else A_update;
    B_current   <= B_current_mem when (ctxt_idx /= ctxt_idx_update or valid_update_data = '0') else B_update;
    C_current   <= C_current_mem when (ctxt_idx /= ctxt_idx_update or valid_update_data = '0') else C_update;

end Behavioral;
