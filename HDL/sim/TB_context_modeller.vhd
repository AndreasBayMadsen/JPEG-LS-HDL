-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 20.2.2023 10:11:24 UTC

library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

entity TB_context_modeller is
end TB_context_modeller;

architecture tb of TB_context_modeller is

    component context_modeller is
        generic ( 
            data_width  :   integer := 8;
            k_width     :   integer := 5;
            n_size      :   integer := 7;
            a_size      :   integer := 15;
            b_size      :   integer := 9;
            n_reset     :   integer := 64;
            no_contexts :   integer := 365
            );
        Port (
            pclk :          in  STD_LOGIC; 
            en :          in  STD_LOGIC; 
            valid_data:     in  STD_LOGIC;
            idx :           in  STD_LOGIC_VECTOR    (integer(ceil(log2(real(no_contexts)))) - 1 downto 0);
            error :         in  signed              (data_width - 1 downto 0);
             
            C :             out signed              (data_width - 1 downto 0);
            B :             out signed              (b_size - 1 downto 0);
            N :             out unsigned            (n_size - 1 downto 0);
            k :             out unsigned            (k_width - 1 downto 0));
    end component;
    
    constant data_width  :   integer := 8;
    constant k_width     :   integer := 5;
    constant n_size      :   integer := 7;
    constant a_size      :   integer := 15;
    constant b_size      :   integer := 9;
    constant c_size      :   integer := 8;
    constant n_reset     :   integer := 64;  
    constant min_c       :   integer := -128;
    constant max_c       :   integer := 127; 
    constant no_contexts :   integer := 365; 
    constant alpha       :   integer := 256;
    

    signal pclk             : std_logic := '1';
    signal en               : std_logic := '0';
    signal valid_data       : STD_LOGIC;
    signal idx              : std_logic_vector  (8 downto 0);
    signal error_val        : signed            (data_width - 1 downto 0);
    
    signal disable_en : STD_LOGIC := '1';
    
    signal C :             signed              (data_width - 1 downto 0);
    signal B :             signed              (b_size - 1 downto 0);
    signal N :             unsigned            (n_size - 1 downto 0);
    signal k :             unsigned            (k_width - 1 downto 0);
    
    constant CLK_FREQ   : REAL  := 10.0;    -- Clock frequency in MHz
    
        -- Derived
    constant CLK_PER    : TIME  := (1.0/CLK_FREQ)*1 us;
    constant CLK_HPER   : TIME  := CLK_PER/2;
    
    constant EN_PER     : TIME := 2 * CLK_PER;
    
    procedure set_values(   signal error_val        : out SIGNED(data_width - 1 downto 0);
                            constant error_val_set  : in integer;
                            signal idx              : out std_logic_vector(8 downto 0);
                            constant idx_set        : in natural;
                            constant wait_period    : TIME) is
    begin
    
        wait for CLK_PER + wait_period;
        error_val <= to_signed(error_val_set, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(idx_set, idx'length));
        wait for CLK_PER - wait_period;
    end procedure;
    
    procedure check_values( signal C : in signed    (data_width - 1 downto 0);
                            signal B : in signed    (b_size - 1 downto 0);
                            signal N : in unsigned  (n_size - 1 downto 0);
                            signal k : in unsigned  (k_width - 1 downto 0);
                            constant C_val : in integer;
                            constant B_val : in integer;
                            constant N_val : in integer;
                            constant k_val : in integer ) is
    begin
    
        assert C = to_signed(C_val, data_width) report "error_bias was not " & integer'image(C_val) & " as expected but is " & integer'image(to_integer(C)) severity ERROR;
        assert k = to_unsigned(k_val, k'length) report "k was not " & integer'image(k_val) & " as expected but is " & integer'image(to_integer(k)) severity ERROR;
        assert B = to_signed(B_val, B'length) report "B was not " & integer'image(B_val) & " as expected but is " & integer'image(to_integer(B)) severity ERROR;
        assert N = to_unsigned(N_val, N'length) report "N was not " & integer'image(N_val) & " as expected but is " & integer'image(to_integer(N)) severity ERROR;
    end procedure;

begin

    dut : context_modeller
    generic map ( 
                data_width   => data_width ,
                k_width      => k_width    ,
                n_size       => n_size     ,
                a_size       => a_size     ,
                b_size       => b_size     ,
                n_reset      => n_reset    ,
                no_contexts  => no_contexts
              )
    port map (pclk              => pclk,
              en                => en,
              valid_data        => valid_data,
              idx               => idx,
              error             => error_val,
              C => C,
              B => B,
              N => N,
              k => k
              );

    -- Clock
    pclk <= not pclk after CLK_HPER;

    stimuli : process
    begin
    
        wait for 1 ns;
        idx <= (others => '0');
        error_val <= (others => '0');
        valid_data <= '0';
        wait for 400 * CLK_PER - 2 ns;
        
        valid_data <= '1';
        disable_en <= '0';
        
        wait for 2 ns;
        
        error_val <= to_signed(5, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, idx'length));
        
        wait for 3 * CLK_PER - 2 ns;
        check_values(C, B, N, k, 0, 0, 1, 2);
 
        set_values(error_val, 5, idx, 1, 2 ns);
        check_values(C, B, N, k, 1, 0, 2, 3);
        
        set_values(error_val, -10, idx, 0, 2 ns);
        check_values(C, B, N, k, 0, 0, 1, 2);
        
        wait for 65 * EN_PER;
        check_values(C, B, N, k, -23, -26, 35, 4);

        set_values(error_val, 20, idx, 0, 2 ns);
        wait for 64 * EN_PER;
        check_values(C, B, N, k, 4, -19, 36, 5);
                
        wait for EN_PER;
        valid_data <= '0';
        idx <= (others => '0');
        error_val <= (others => '0');
        disable_en <= '1';
        
        report "First data test done, starting with reset" severity NOTE;
        
        wait for 400 * CLK_PER;
        
        report "Reset done" severity NOTE;
        
        report "Second test with different values after reset" severity NOTE;
        
        valid_data <= '1';
        disable_en <= '0';
        
        wait for 2 ns;
        
        error_val <= to_signed(-5, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, idx'length));
        
        wait for 3 * CLK_PER - 2 ns;
        check_values(C, B, N, k, 0, 0, 1, 2);
 
        set_values(error_val, -5, idx, 1, 2 ns);
        check_values(C, B, N, k, -1, -1, 2, 3);
        
        set_values(error_val, 10, idx, 0, 2 ns);
        check_values(C, B, N, k, 0, 0, 1, 2);
        
        wait for 65 * EN_PER;
        check_values(C, B, N, k, 25, -11, 35, 4);

        set_values(error_val, -20, idx, 0, 2 ns);
        wait for 64 * EN_PER;
        check_values(C, B, N, k, -1, -9, 36, 5);
                
        wait for EN_PER;
        valid_data <= '0';
        idx <= (others => '0');
        error_val <= (others => '0');
        disable_en <= '1';

        report "Second data test done, starting with reset" severity NOTE;
        
        wait for 400 * CLK_PER;
        
        report "Reset done" severity NOTE;
        
        report "Third test with pause in middle" severity NOTE;
        
        valid_data <= '1';
        disable_en <= '0';
        
        wait for 2 ns;
        
        error_val <= to_signed(-5, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, idx'length));
        
        wait for 3 * CLK_PER - 2 ns;
        check_values(C, B, N, k, 0, 0, 1, 2);
 
        set_values(error_val, -5, idx, 1, 2 ns);
        check_values(C, B, N, k, -1, -1, 2, 3);
        
        set_values(error_val, 10, idx, 0, 2 ns);
        check_values(C, B, N, k, 0, 0, 1, 2);
        
        wait for 65 * EN_PER;
        check_values(C, B, N, k, 25, -11, 35, 4);
        
        disable_en <= '1';
        
        wait for 64 * CLK_PER;
        
        disable_en <= '0';
        
        wait for 2 ns;
        error_val <= to_signed(-20, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, idx'length));

        wait for 64 * EN_PER - 2 ns;
        check_values(C, B, N, k, -1, -9, 36, 5);
                
        wait for EN_PER;
        valid_data <= '0';
        idx <= (others => '0');
        error_val <= (others => '0');
        disable_en <= '1';
   
        report "Final data test done..." severity NOTE;

        report "Resetting" severity NOTE;
        
        wait for 400 * CLK_PER;
        
        valid_data <= '1';
        disable_en <= '0';
        
        wait for 2 ns;
        
        error_val <= to_signed(-5, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, idx'length));
        wait for CLK_PER - 2 ns;
 
        set_values(error_val, 5, idx, 1, 2 ns);
        set_values(error_val, 5, idx, 2, 2 ns);
        set_values(error_val, 5, idx, 3, 2 ns);
        set_values(error_val, 5, idx, 4, 2 ns);
        set_values(error_val, 5, idx, 1, 2 ns);
        set_values(error_val, 5, idx, 2, 2 ns);
        set_values(error_val, 5, idx, 3, 2 ns);
        set_values(error_val, 5, idx, 4, 2 ns);
        set_values(error_val, 5, idx, 4, 2 ns);
        set_values(error_val, 5, idx, 4, 2 ns);
        set_values(error_val, 5, idx, 4, 2 ns);
        set_values(error_val, 5, idx, 4, 2 ns);
        
        report "simulation finished successfully" severity FAILURE;

        wait;
    end process;
    
    
    sti : process(pclk)
    begin
        if rising_edge(pclk) then
            en <= '0' after 1 ns;
            if disable_en = '0' then
                en <= not en after 1 ns;
            end if;
        end if;
    end process;

end tb;

