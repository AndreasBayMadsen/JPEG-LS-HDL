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
              data_width :      integer;
              k_width :         integer);
        port (pclk       : in std_logic;
              clk        : in std_logic;
              last_data  : in std_logic;
              idx        : in std_logic_vector (8 downto 0);
              error      : in signed (data_width - 1 downto 0);
              error_bias : out signed (data_width - 1 downto 0);
              k          : out std_logic_vector (k_width - 1 downto 0);
              done       : out std_logic);
    end component;
    
    constant data_width : integer := 8;
    constant k_width    : integer := 5;

    signal pclk       : std_logic := '0';
    signal clk        : std_logic := '0';
    signal last_data  : std_logic;
    signal idx        : std_logic_vector (8 downto 0);
    signal error      : signed (data_width - 1 downto 0);
    signal error_bias : signed (data_width - 1 downto 0);
    signal k          : std_logic_vector (k_width - 1 downto 0);
    signal done       : std_logic;

begin

    dut : context_modeller
    generic map ( 
              data_width => data_width,
              k_width    => k_width)
    port map (pclk       => pclk,
              clk        => clk,
              last_data  => last_data,
              idx        => idx,
              error      => error,
              error_bias => error_bias,
              k          => k,
              done       => done);

    stimuli : process
    begin
        
        pclk <= '0';
        last_data <= '0';
        idx <= (others => '0');
        error <= (others => '0');
        
        wait for 20 ns;
        pclk <= '1';
        
        error <= to_signed(5, data_width);
        

        -- EDIT Add stimuli here

        wait;
    end process;
    
    clock : process
    begin
        clk <= not clk;
        wait for 5 ns;
    end process;
    
    pclock : process
    begin
        clk <= not clk;
        wait for 20 ns;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_context_modeller of tb_context_modeller is
    for tb
    end for;
end cfg_tb_context_modeller;