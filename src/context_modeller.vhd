----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2023 09:56:16 AM
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
use IEEE.MATH_REAL.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity context_modeller is
    generic ( 
        data_width  :   integer := 8;
        k_width     :   integer := 5;       -- KUNNE DEN IKKE SÆTTES TIL ceil(log2(data_width-1))?
        n_size      :   integer := 7;       -- KUNNE DEN IKKE SÆTTES TIL ceil(log2(n_reset+1))?
        a_size      :   integer := 15;      -- KUNNE DEN IKKE SÆTTES TIL ceil(log2(n_reset*(2**(data_width-1))))?
        b_size      :   integer := 9;       -- I VÆRSTE FALD KUNNE DEN VEL SÆTTES TIL 1+ceil(log2(n_reset*(2**(data_width-1))))?
        c_size      :   integer := 8;       -- KUNNE DEN IKKE BARE ALTID SÆTTES TIL DATA_WIDTH?
        n_reset     :   integer := 64;
        min_c       :   integer := -128;    -- KUNNE VEL SÆTTES TIL -2**(c_size-1)?
        max_c       :   integer := 127;     -- KUNNE VEL SÆTTES TIL 2**(c_size-1)-1?
        no_contexts :   integer := 365;
        alpha       :   integer := 256      -- KUNNE VEL SÆTTES TIL 2**data_width?
        );
    Port (
        pclk :          in  STD_LOGIC;
        en   :          in  STD_LOGIC; 
        valid_data:     in  STD_LOGIC;
        idx :           in  STD_LOGIC_VECTOR    (integer(ceil(log2(real(no_contexts)))) - 1 downto 0);
        error :         in  signed              (data_width - 1 downto 0);
         
        C :             out signed              (data_width - 1 downto 0);
        B :             out signed              (b_size - 1 downto 0);
        N :             out unsigned            (n_size - 1 downto 0);
        k :             out unsigned            (k_width - 1 downto 0));
end context_modeller;

architecture Behavioral of context_modeller is

    subtype data_type is unsigned (data_width - 1 downto 0);
    
    component context_memory_block
      PORT (
        clka    : IN    STD_LOGIC;
        wea     : IN    STD_LOGIC_VECTOR(0 DOWNTO 0);
        addra   : IN    STD_LOGIC_VECTOR(8 DOWNTO 0);
        dina    : IN    STD_LOGIC_VECTOR(39 DOWNTO 0);
        clkb    : IN    STD_LOGIC;
        addrb   : IN    STD_LOGIC_VECTOR(8 DOWNTO 0);
        doutb   : OUT   STD_LOGIC_VECTOR(39 DOWNTO 0)
      );
    END component;
    
    -- RAM constants
    constant A_offset : integer := 0;
    constant B_offset : integer := a_size;
    constant C_offset : integer := a_size + b_size;
    constant N_offset : integer := a_size + b_size + c_size;
    constant A_def    : unsigned    (a_size - 1 downto 0) := to_unsigned(integer(realmax(2.0, floor((real(alpha) + 32.0) / 64.0))), a_size);
    constant B_def    : signed      (b_size - 1 downto 0) := to_signed(0, b_size);  
    constant C_def    : signed      (c_size - 1 downto 0) := to_signed(0, c_size);
    constant N_def    : unsigned    (n_size - 1 downto 0) := to_unsigned(1, n_size);
    
    
    signal addrin   :   STD_LOGIC_VECTOR(8 DOWNTO 0) := (others => '0');
    signal din      :   STD_LOGIC_VECTOR(39 DOWNTO 0);
    
    signal addrout  :   STD_LOGIC_VECTOR(8 DOWNTO 0);
    signal dout     :   STD_LOGIC_VECTOR(39 DOWNTO 0);
    
    signal wea      :   STD_LOGIC;
    
    signal A_read   : unsigned    (a_size - 1 downto 0);
    signal B_read   : signed      (b_size - 1 downto 0);
    signal C_read   : signed      (c_size - 1 downto 0);
    signal N_read   : unsigned    (n_size - 1 downto 0);
    
    signal A_t1     : unsigned    (a_size - 1 downto 0);
    signal B_t1     : signed      (b_size - 1 downto 0);
    signal C_t1     : signed      (c_size - 1 downto 0);
    signal N_t1     : unsigned    (n_size - 1 downto 0);
    
    signal A_t2     : unsigned    (a_size - 1 downto 0);
    signal B_t2     : signed      (b_size - 1 downto 0);
    signal C_t2     : signed      (c_size - 1 downto 0);
    signal N_t2     : unsigned    (n_size - 1 downto 0);
    
    signal A_t3     : unsigned    (a_size - 1 downto 0);
    signal B_t3     : signed      (b_size - 1 downto 0);
    signal C_t3     : signed      (c_size - 1 downto 0);
    signal N_t3     : unsigned    (n_size - 1 downto 0);
    
    signal N_shift  : unsigned    (a_size downto 0);
    signal k_temp   : unsigned    (k_width - 1 downto 0);
    
    
    constant N_reset_val : unsigned(N_read'high downto N_read'low) := to_unsigned(n_reset, N_read'length);
    
    type context_enum is (WAITING, TASK, RESET);
    signal context_state : context_enum := WAITING;
    
    signal reset_idx : unsigned   (idx'high downto idx'low);
    signal reset_done_flag : STD_LOGIC := '0';

begin
    
    memory_block : context_memory_block
    port map (clka      => pclk,
              wea(0)    => wea,
              addra     => addrout,
              dina      => dout,
              clkb      => pclk,
              addrb     => addrin,
              doutb     => din);
              
              
    -- READ context from RAM.
    A_read <= unsigned(din(a_size - 1 + a_offset downto a_offset));
    B_read <= signed(din(b_size - 1 + b_offset downto b_offset));
    C_read <= signed(din(c_size - 1 + c_offset downto c_offset));
    N_read <= unsigned(din(n_size - 1 + n_offset downto n_offset));
              
    -- Find k value
    N_shift(N_shift'high downto N_read'high + 1) <= (others => '0');
    N_shift(N_read'high downto N_read'low) <= N_read;
    
    process(A_read, N_shift)
    begin
        if A_read <= N_shift then
            k_temp <= to_unsigned(0, k'length);
        end if; 
                
        for ii in 1 to 31 loop
            if A_read <= shift_left(N_shift, ii) and A_read > shift_left(N_shift, ii - 1) then
                k_temp <= to_unsigned(ii, k'length);
            end if; 
        end loop;
    end process;
    
              
    A_t1 <= resize(A_read + unsigned(abs(error)), A_t1'length);
    B_t1 <= resize(B_read + error, B_t1'length);
    C_t1 <= C_read;
    N_t1 <= N_read;
    
    -- Divide when N == N_max
    A_t2 <= shift_right(A_t1, 1) when N_read = N_reset_val else A_t1;
    B_t2 <= shift_right(B_t1, 1) when N_read = N_reset_val else B_t1;
    C_t2 <= C_t1;
    N_t2 <= shift_right(N_t1, 1) + 1 when N_read = N_reset_val else N_t1 + 1;
    
    A_t3 <= A_t2; 
    B_t3 <= resize(- signed('0' & N_t2) + 1, B_t3'length) when (B_t2 + signed('0' & N_t2) <= - signed('0' & N_t2)) and (B_t2 <= - signed('0' & N_t2)) else
            resize(B_t2 + signed('0' & N_t2), B_t3'length) when B_t2 <= - signed('0' & N_t2) else
            to_signed(0, B_t3'length) when (B_t2 - signed('0' & N_t2) > to_signed(0, B_t3'length)) and (B_t2 > to_signed(0, B_t3'length)) else
            resize(B_t2 - signed('0' & N_t2), B_t3'length) when (B_t2 > to_signed(0, B_t3'length)) else
            B_t2; 
    
    C_t3 <= resize(C_t2 - 1, C_t3'length) when (C_t2 > to_signed(min_c, C_t2'length)) and (B_t2 <= - signed('0' & N_t2)) else
            resize(C_t2 + 1, C_t3'length) when (C_t2 < to_signed(max_c, C_t2'length)) and (B_t2 > to_signed(0, B_t2'length)) else
            C_t2;
            
    N_t3 <= N_t2;
    
    -- Set ouputs while valid
    C <= C_read;
    N <= N_read;
    B <= B_read;
    k <= k_temp;
    
    process(pclk)
    begin
        if rising_edge(pclk) then
        
            wea <= '0';
            
            case context_state is
                when WAITING =>
                    
                    if valid_data = '1' then
                        if en = '1' then
                        
                            -- Update RAM values.
                            dout <= (others => '0');
                            dout(a_size - 1 + a_offset downto a_offset) <= STD_LOGIC_VECTOR(A_t3);
                            dout(b_size - 1 + b_offset downto b_offset) <= STD_LOGIC_VECTOR(B_t3);
                            dout(c_size - 1 + c_offset downto c_offset) <= STD_LOGIC_VECTOR(C_t3);
                            dout(n_size - 1 + n_offset downto n_offset) <= STD_LOGIC_VECTOR(N_t3);
                            wea <= '1';
                        
                            context_state <= TASK;
                            
                            -- Get context from RAM
                            addrin <= (others => '0');
                            addrin(idx'high downto idx'low) <= idx;
                       end if;
                    else
                        if reset_done_flag = '0' then
                            context_state <= RESET;
                            reset_idx <= (others => '0');
                        end if;
                    end if;
                    
                when TASK =>
                
                    -- Set address to write.
                    addrout <= (others => '0');
                    addrout(idx'high downto idx'low) <= idx;
                    
                    -- Context has now been edited.
                    reset_done_flag <= '0';
                    
                    context_state <= WAITING;
                    
                when RESET =>
                
                    -- Set default value of RAM.
                    dout <= (others => '0');
                    dout(a_size - 1 + a_offset downto a_offset) <= STD_LOGIC_VECTOR(A_def);
                    dout(b_size - 1 + b_offset downto b_offset) <= STD_LOGIC_VECTOR(B_def);
                    dout(c_size - 1 + c_offset downto c_offset) <= STD_LOGIC_VECTOR(C_def);
                    dout(n_size - 1 + n_offset downto n_offset) <= STD_LOGIC_VECTOR(N_def);
                    wea <= '1';
                    
                    -- Set address to edit.
                    addrout <= (others => '0');
                    addrout(idx'high downto idx'low) <= STD_LOGIC_VECTOR(reset_idx);
                    
                    reset_idx <= reset_idx + 1;
                    
                    -- When last address has been reset
                    if reset_idx = to_unsigned(no_contexts - 1, reset_idx'length) then
                        context_state <= WAITING;
                        reset_done_flag <= '1';
                    end if;
            end case;
        end if;
    end process;
   
end Behavioral;
