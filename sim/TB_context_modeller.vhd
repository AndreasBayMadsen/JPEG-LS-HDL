-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 20.2.2023 10:11:24 UTC

library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

entity tb_context_modeller is
end tb_context_modeller;

architecture tb of tb_context_modeller is

    component context_modeller is
        generic ( 
            data_width  :   integer := 8;
            k_width     :   integer := 5;
            n_size      :   integer := 7;
            a_size      :   integer := 15;
            b_size      :   integer := 9;
            c_size      :   integer := 8;
            n_reset     :   integer := 64;
            min_c       :   integer := -128;
            max_c       :   integer := 127;
            no_contexts :   integer := 365;
            alpha       :   integer := 256
            );
        Port (
            pclk :          in  STD_LOGIC; 
            en :          in  STD_LOGIC; 
            valid_data:     in  STD_LOGIC;
            idx :           in  STD_LOGIC_VECTOR    (integer(ceil(log2(real(no_contexts)))) - 1 downto 0);
            error :         in  signed              (data_width - 1 downto 0);
             
            error_bias :    out signed              (data_width - 1 downto 0);
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
    

    signal pclk             : std_logic := '0';
    signal en               : std_logic := '1';
    signal valid_data       : STD_LOGIC;
    signal idx              : std_logic_vector  (8 downto 0);
    signal error_val        : signed            (data_width - 1 downto 0);
    signal error_bias       : signed            (data_width - 1 downto 0);
    signal k                : unsigned          (k_width - 1 downto 0);

begin

    dut : context_modeller
    generic map ( 
                data_width   => data_width ,
                k_width      => k_width    ,
                n_size       => n_size     ,
                a_size       => a_size     ,
                b_size       => b_size     ,
                c_size       => c_size     ,
                n_reset      => n_reset    ,
                min_c        => min_c      ,
                max_c        => max_c      ,
                no_contexts  => no_contexts,
                alpha        => alpha      
              )
    port map (pclk              => pclk,
              en                => en,
              valid_data        => valid_data,
              idx               => idx,
              error             => error_val,
              error_bias        => error_bias,
              k                 => k);

    stimuli : process
    begin
    
        idx <= (others => '0');
        error_val <= (others => '0');
        valid_data <= '0';
        wait for 16 us;
        
        valid_data <= '1';
        error_val <= to_signed(5, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, idx'length));
        wait for 80 ns;
        assert error_bias = to_signed(0, data_width) report "error_bias was not 0 as expected but is " & integer'image(to_integer(error_bias)) severity ERROR;
        assert k = to_unsigned(2, k'length) report "k was not 2 as expected but is " & integer'image(to_integer(k)) severity ERROR;
        
        error_val <= to_signed(5, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, idx'length));
        wait for 80 ns;
        assert error_bias = to_signed(1, data_width) report "error_bias was not 1 as expected but is " & integer'image(to_integer(error_bias)) severity ERROR;
        assert k = to_unsigned(3, k'length) report "k was not 3 as expected but is " & integer'image(to_integer(k)) severity ERROR;
        
        error_val <= to_signed(5, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(1, idx'length));
        wait for 80 ns;
        assert error_bias = to_signed(0, data_width) report "error_bias was not 0 as expected but is " & integer'image(to_integer(error_bias)) severity ERROR;
        assert k = to_unsigned(2, k'length) report "k was not 2 as expected but is " & integer'image(to_integer(k)) severity ERROR;
        
        error_val <= to_signed(-10, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, idx'length));
        wait for 5200 ns;
        assert error_bias = to_signed(-23, data_width) report "error_bias was not -23 as expected but is " & integer'image(to_integer(error_bias)) severity ERROR;
        assert k = to_unsigned(4, k'length) report "k was not 4 as expected but is " & integer'image(to_integer(k)) severity ERROR;
        
        error_val <= to_signed(20, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, idx'length));
        wait for 5200 ns;
        assert error_bias = to_signed(4, data_width) report "error_bias was not 4 as expected but is " & integer'image(to_integer(error_bias)) severity ERROR;
        assert k = to_unsigned(5, k'length) report "k was not 5 as expected but is " & integer'image(to_integer(k)) severity ERROR;
        
        wait for 80 ns;
        valid_data <= '0';
        idx <= (others => '0');
        error_val <= (others => '0');
        
        report "First data test done, starting with reset" severity NOTE;
        
        wait for 16 us;
        
        report "Reset done" severity NOTE;
        
        valid_data <= '1';
        error_val <= to_signed(-5, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, idx'length));
        wait for 80 ns;
        assert error_bias = to_signed(0, data_width) report "error_bias was not 0 as expected but is " & integer'image(to_integer(error_bias)) severity ERROR;
        assert k = to_unsigned(2, k'length) report "k was not 2 as expected but is " & integer'image(to_integer(k)) severity ERROR;
   
        error_val <= to_signed(-5, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, idx'length));
        wait for 80 ns;
        assert error_bias = to_signed(-1, data_width) report "error_bias was not 1 as expected but is " & integer'image(to_integer(error_bias)) severity ERROR;
        assert k = to_unsigned(3, k'length) report "k was not 3 as expected but is " & integer'image(to_integer(k)) severity ERROR;
        
        error_val <= to_signed(-5, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(1, idx'length));
        wait for 80 ns;
        assert error_bias = to_signed(0, data_width) report "error_bias was not 0 as expected but is " & integer'image(to_integer(error_bias)) severity ERROR;
        assert k = to_unsigned(2, k'length) report "k was not 2 as expected but is " & integer'image(to_integer(k)) severity ERROR;
        
        error_val <= to_signed(10, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, idx'length));
        wait for 5200 ns;
        assert error_bias = to_signed(25, data_width) report "error_bias was not 25 as expected but is " & integer'image(to_integer(error_bias)) severity ERROR;
        assert k = to_unsigned(4, k'length) report "k was not 4 as expected but is " & integer'image(to_integer(k)) severity ERROR;
        
        error_val <= to_signed(-20, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, idx'length));
        wait for 5200 ns;
        assert error_bias = to_signed(-1, data_width) report "error_bias was not -1 as expected but is " & integer'image(to_integer(error_bias)) severity ERROR;
        assert k = to_unsigned(5, k'length) report "k was not 5 as expected but is " & integer'image(to_integer(k)) severity ERROR;

        wait for 80 ns;
        valid_data <= '0';
        idx <= (others => '0');
        error_val <= (others => '0');

        report "Second data test done, starting with reset" severity NOTE;
        
        wait for 16 us;
        
        report "Reset done" severity NOTE;
        
        valid_data <= '1';
        error_val <= to_signed(-5, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, idx'length));
        wait for 80 ns;
        assert error_bias = to_signed(0, data_width) report "error_bias was not 0 as expected but is " & integer'image(to_integer(error_bias)) severity ERROR;
        assert k = to_unsigned(2, k'length) report "k was not 2 as expected but is " & integer'image(to_integer(k)) severity ERROR;
   
        error_val <= to_signed(-5, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, idx'length));
        wait for 80 ns;
        assert error_bias = to_signed(-1, data_width) report "error_bias was not 1 as expected but is " & integer'image(to_integer(error_bias)) severity ERROR;
        assert k = to_unsigned(3, k'length) report "k was not 3 as expected but is " & integer'image(to_integer(k)) severity ERROR;
        
        error_val <= to_signed(-5, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(1, idx'length));
        wait for 80 ns;
        assert error_bias = to_signed(0, data_width) report "error_bias was not 0 as expected but is " & integer'image(to_integer(error_bias)) severity ERROR;
        assert k = to_unsigned(2, k'length) report "k was not 2 as expected but is " & integer'image(to_integer(k)) severity ERROR;
        
        error_val <= to_signed(10, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, idx'length));
        wait for 5200 ns;
        assert error_bias = to_signed(25, data_width) report "error_bias was not 25 as expected but is " & integer'image(to_integer(error_bias)) severity ERROR;
        assert k = to_unsigned(4, k'length) report "k was not 4 as expected but is " & integer'image(to_integer(k)) severity ERROR;
        
        en <= '0';
        
        wait for 2600 ns;
        
        en <= '1';
        
        error_val <= to_signed(-20, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, idx'length));
        wait for 5200 ns;
        assert error_bias = to_signed(-1, data_width) report "error_bias was not -1 as expected but is " & integer'image(to_integer(error_bias)) severity ERROR;
        assert k = to_unsigned(5, k'length) report "k was not 5 as expected but is " & integer'image(to_integer(k)) severity ERROR;

        wait for 80 ns;
        valid_data <= '0';
        idx <= (others => '0');
        error_val <= (others => '0');

        report "Final data test done..." severity NOTE;

        wait;
    end process;
    
    pclock : process
    begin
        pclk <= not pclk;
        wait for 20 ns;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_context_modeller of tb_context_modeller is
    for tb
    end for;
end cfg_tb_context_modeller;