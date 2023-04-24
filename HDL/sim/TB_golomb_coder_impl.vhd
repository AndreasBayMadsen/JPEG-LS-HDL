----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2023 04:12:15 PM
-- Design Name: 
-- Module Name: TB_golomb_coder - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_golomb_coder_impl is
--  Port ( );
end TB_golomb_coder_impl;

architecture tb of TB_golomb_coder_impl is

    constant k_width : integer := 5;
    constant beta_max : integer := 8;
    constant L_max : integer := 32;

    component golomb_coder is
        Port ( pclk : in STD_LOGIC;
               en : in STD_LOGIC;
               valid_data : in STD_LOGIC;
               k : in STD_LOGIC_vector (k_width - 1 downto 0);
               error : in STD_LOGIC_vector (beta_max - 1 downto 0);
               encoded : out STD_LOGIC_VECTOR (L_max - 1 downto 0);
               size : out STD_LOGIC_vector (k_width downto 0));
    end component;
    
    signal pclk : STD_LOGIC := '1';
    signal en : STD_LOGIC;
    signal valid_data : STD_LOGIC;
    signal k : unsigned (k_width - 1 downto 0);
    signal error_val : unsigned (beta_max - 1 downto 0);
    signal encoded : STD_LOGIC_VECTOR (L_max - 1 downto 0);
    
    signal size_temp : STD_LOGIC_VECTOR (k_width downto 0);
    signal size : unsigned (k_width downto 0);

begin

    dut : golomb_coder
        Port map ( pclk         =>   pclk      ,
                   en           =>   en        ,
                   valid_data   =>   valid_data,
                   k            =>   STD_LOGIC_VECTOR(k)         ,
                   error        =>   STD_LOGIC_VECTOR(error_val)     ,
                   encoded      =>   encoded   ,
                   size         =>   size_temp
                   );
    size <= unsigned(size_temp);
    
    stimuli : process
    begin
    
        en <= '1';
        valid_data <= '0';
    
        report "First test with same error and different values of k starting..." severity NOTE;
    
        wait for 80 ns;
        valid_data <= '1';
        
        error_val <= x"45";
        k <= to_unsigned(3, k'length);
        wait for 80 ns;
        assert unsigned(encoded) = x"000D" report "encoded was not 13 as expected but is " & integer'image(to_integer(unsigned(encoded))) severity ERROR;
        assert size = to_unsigned(12, size'length) report "size was not 12 as expected but is " & integer'image(to_integer(size)) severity ERROR;
        
        error_val <= x"45";
        k <= to_unsigned(0, k'length);
        wait for 80 ns;
        assert unsigned(encoded) = x"0144" report "encoded was not 324 as expected but is " & integer'image(to_integer(unsigned(encoded))) severity ERROR;
        assert size = to_unsigned(32, size'length) report "size was not 32 as expected but is " & integer'image(to_integer(size)) severity ERROR;

        error_val <= x"45";
        k <= to_unsigned(2, k'length);
        wait for 80 ns;
        assert unsigned(encoded) = x"0005" report "encoded was not 5 as expected but is " & integer'image(to_integer(unsigned(encoded))) severity ERROR;
        assert size = to_unsigned(20, size'length) report "size was not 20 as expected but is " & integer'image(to_integer(size)) severity ERROR;
  
        error_val <= x"45";
        k <= to_unsigned(5, k'length);
        wait for 80 ns;
        assert unsigned(encoded) = x"0025" report "encoded was not 37 as expected but is " & integer'image(to_integer(unsigned(encoded))) severity ERROR;
        assert size = to_unsigned(8, size'length) report "size was not 8 as expected but is " & integer'image(to_integer(size)) severity ERROR;

        
        report "First test with same error and different values of k done..." severity NOTE;
        valid_data <= '0';
        wait for 160 ns;
        
        report "Second test with different error and same values of k starting..." severity NOTE;
        valid_data <= '1';
        error_val <= x"01";
        k <= to_unsigned(4, k'length);
        wait for 80 ns;
        assert unsigned(encoded) = x"0011" report "encoded was not 17 as expected but is " & integer'image(to_integer(unsigned(encoded))) severity ERROR;
        assert size = to_unsigned(5, size'length) report "size was not 5 as expected but is " & integer'image(to_integer(size)) severity ERROR;

        error_val <= x"10";
        k <= to_unsigned(4, k'length);
        wait for 80 ns;
        assert unsigned(encoded) = x"0010" report "encoded was not 16 as expected but is " & integer'image(to_integer(unsigned(encoded))) severity ERROR;
        assert size = to_unsigned(6, size'length) report "size was not 6 as expected but is " & integer'image(to_integer(size)) severity ERROR;

        error_val <= x"1F";
        k <= to_unsigned(4, k'length);
        wait for 80 ns;
        assert unsigned(encoded) = x"001F" report "encoded was not 31 as expected but is " & integer'image(to_integer(unsigned(encoded))) severity ERROR;
        assert size = to_unsigned(6, size'length) report "size was not 6 as expected but is " & integer'image(to_integer(size)) severity ERROR;

        error_val <= x"CC";
        k <= to_unsigned(4, k'length);
        wait for 80 ns;
        assert unsigned(encoded) = x"001C" report "encoded was not 28 as expected but is " & integer'image(to_integer(unsigned(encoded))) severity ERROR;
        assert size = to_unsigned(17, size'length) report "size was not 17 as expected but is " & integer'image(to_integer(size)) severity ERROR;

        report "Second test with different error and same values of k done..." severity NOTE;
        
        wait;
    end process;

    pclock : process
    begin
        pclk <= not pclk;
        wait for 20 ns;
    end process;



end tb;
