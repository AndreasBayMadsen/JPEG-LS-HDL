-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 20.2.2023 10:11:24 UTC

library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity tb_context_modeller is
end tb_context_modeller;

architecture tb of tb_context_modeller is

    component context_modeller
        generic ( 
              data_width  :   integer;
              k_width     :   integer;
              n_size      :   integer;
              a_size      :   integer;
              b_size      :   integer;
              c_size      :   integer);
        port (pclk              : in std_logic;
              clk               : in std_logic;
              valid_data        : in STD_LOGIC;
              neg_error_flag    : in std_logic;
              idx               : in std_logic_vector   (8 downto 0);
              error             : in signed             (data_width - 1 downto 0);
              error_bias        : out signed            (data_width - 1 downto 0);
              k                 : out unsigned          (k_width - 1 downto 0));
    end component;
    
    constant data_width  :   integer := 8;
    constant k_width     :   integer := 5;
    constant n_size      :   integer := 6;
    constant a_size      :   integer := 15;
    constant b_size      :   integer := 9;
    constant c_size      :   integer := 8;

    signal pclk             : std_logic := '0';
    signal clk              : std_logic := '0';
    signal neg_error_flag   : std_logic;
    signal valid_data       : STD_LOGIC;
    signal idx              : std_logic_vector  (8 downto 0);
    signal error            : signed            (data_width - 1 downto 0);
    signal error_bias       : signed            (data_width - 1 downto 0);
    signal k                : unsigned          (k_width - 1 downto 0);

begin

    dut : context_modeller
    generic map ( 
              data_width        => data_width,
              k_width           => k_width,
              n_size            => n_size,
              a_size            => a_size,
              b_size            => b_size,
              c_size            => c_size)
    port map (pclk              => pclk,
              clk               => clk,
              valid_data        => valid_data,
              neg_error_flag    => neg_error_flag,
              idx               => idx,
              error             => error,
              error_bias        => error_bias,
              k                 => k);

    stimuli : process
    begin
       
        neg_error_flag <= '0';
        idx <= (others => '0');
        error <= (others => '0');
        valid_data <= '0';
        wait for 40 ns;
        
        valid_data <= '1';
        error <= to_signed(5, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, 9));
        wait for 40 ns;
        assert error_bias = to_signed(0, data_width) report "error_bias was not 0 as expected" severity ERROR;
        assert k = to_signed(3, data_width) report "k was not 3 as expected" severity ERROR;
   
        error <= to_signed(5, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, 9));
        wait for 40 ns;
        assert error_bias = to_signed(1, data_width) report "error_bias was not 1 as expected" severity ERROR;
        assert k = to_signed(3, data_width) report "k was not 3 as expected" severity ERROR;
        
        error <= to_signed(5, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(1, 9));
        wait for 40 ns;
        assert error_bias = to_signed(0, data_width) report "error_bias was not 0 as expected" severity ERROR;
        assert k = to_signed(3, data_width) report "k was not 3 as expected" severity ERROR;
        
        error <= to_signed(-10, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, 9));
        wait for 2600 ns;
        assert error_bias = to_signed(-23, data_width) report "error_bias was not -23 as expected" severity ERROR;
        assert k = to_signed(4, data_width) report "k was not 4 as expected" severity ERROR;
        
        error <= to_signed(20, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, 9));
        wait for 2600 ns;
        assert error_bias = to_signed(4, data_width) report "error_bias was not 4 as expected" severity ERROR;
        assert k = to_signed(5, data_width) report "k was not 5 as expected" severity ERROR;
        
        wait for 40 ns;
        valid_data <= '0';
        
        report "First data test done, starting with reset" severity NOTE;
        
        wait for 30 us;
        
        neg_error_flag <= '1';
        idx <= (others => '0');
        error <= (others => '0');
        wait for 40 ns;
        
        valid_data <= '1';
        error <= to_signed(5, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, 9));
        wait for 40 ns;
        assert error_bias = to_signed(0, data_width) report "error_bias was not 0 as expected" severity ERROR;
        assert k = to_signed(3, data_width) report "k was not 3 as expected" severity ERROR;
   
        error <= to_signed(5, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, 9));
        wait for 40 ns;
        assert error_bias = to_signed(-1, data_width) report "error_bias was not 1 as expected" severity ERROR;
        assert k = to_signed(3, data_width) report "k was not 3 as expected" severity ERROR;
        
        error <= to_signed(5, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(1, 9));
        wait for 40 ns;
        assert error_bias = to_signed(0, data_width) report "error_bias was not 0 as expected" severity ERROR;
        assert k = to_signed(3, data_width) report "k was not 3 as expected" severity ERROR;
        
        error <= to_signed(-10, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, 9));
        wait for 2600 ns;
        assert error_bias = to_signed(-23, data_width) report "error_bias was not -23 as expected" severity ERROR;
        assert k = to_signed(4, data_width) report "k was not 4 as expected" severity ERROR;
        
        error <= to_signed(20, data_width);
        idx <= STD_LOGIC_VECTOR(to_unsigned(0, 9));
        wait for 2600 ns;
        assert error_bias = to_signed(4, data_width) report "error_bias was not 4 as expected" severity ERROR;
        assert k = to_signed(5, data_width) report "k was not 5 as expected" severity ERROR;

        wait;
    end process;
    
    clock : process
    begin
        clk <= not clk;
        wait for 5 ns;
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