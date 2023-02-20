-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 20.2.2023 07:37:15 UTC

library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity tb_fixed_predictor is
end tb_fixed_predictor;

architecture tb of tb_fixed_predictor is

    component fixed_predictor
        generic ( 
            data_width :    integer);
        port (
            pclk       :     in  std_logic;
            last_data :     in  std_logic;
            A         :     in  unsigned    (data_width - 1 downto 0);
            B         :     in  unsigned    (data_width - 1 downto 0);
            C         :     in  unsigned    (data_width - 1 downto 0);
            x_pred    :     out unsigned    (data_width - 1 downto 0);
            done      :     out std_logic);
    end component;

    constant data_width : integer := 8;
    subtype data_type is unsigned (data_width - 1 downto 0);
    
    signal pclk       :  std_logic := '1';
    signal last_data :  std_logic;
    signal A         :  data_type;
    signal B         :  data_type;
    signal C         :  data_type;
    signal x_pred    :  data_type;
    signal done      :  std_logic;
    
begin

    dut : fixed_predictor
    generic map(
        data_width => data_width)
    port map (
        pclk       => pclk,
        last_data => last_data,
        A         => A,
        B         => B,
        C         => C,
        x_pred    => x_pred,
        done      => done);

    stimuli : process
    begin
    
        last_data <= '0';
        A <= (others => '0');
        B <= (others => '0');
        C <= (others => '0');
        
        wait for 20 ns;
        assert done = '0' report "Done flag unexpectedly raised" severity ERROR;    
        assert x_pred = to_unsigned(0, 8) report "x_pred was not 0 as expected" severity ERROR;
        
        A <= to_unsigned(30, 8);
        B <= to_unsigned(40, 8);
        wait for 20 ns;
        assert x_pred = to_unsigned(40, 8) report "x_pred was not 40 as expected" severity ERROR;
        
        A <= to_unsigned(50, 8);
        wait for 20 ns;
        assert x_pred = to_unsigned(50, 8) report "x_pred was not 50 as expected" severity ERROR;

        C <= to_unsigned(60, 8);
        wait for 20 ns;
        assert x_pred = to_unsigned(40, 8) report "x_pred was not 40 as expected" severity ERROR;
        
        B <= to_unsigned(55, 8);
        wait for 20 ns;
        assert x_pred = to_unsigned(50, 8) report "x_pred was not 50 as expected" severity ERROR;
        
        B <= to_unsigned(70, 8);
        wait for 20 ns;
        assert x_pred = to_unsigned(60, 8) report "x_pred was not 50 as expected" severity ERROR;

        
        A <= to_unsigned(65, 8);
        B <= to_unsigned(50, 8);
        last_data <= '1';
        wait for 20 ns;
        assert x_pred = to_unsigned(55, 8) report "x_pred was not 55 as expected" severity ERROR;
        assert done = '1' report "Done flag not raised" severity ERROR;    

        
        wait;
    end process;
    
    clock : process
    begin
        wait for 5 ns;
        pclk <= not pclk;
        
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_fixed_predictor of tb_fixed_predictor is
    for tb
    end for;
end cfg_tb_fixed_predictor;