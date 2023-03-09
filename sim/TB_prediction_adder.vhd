----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2023 04:39:23 PM
-- Design Name: 
-- Module Name: TB_prediction_adder - Behavioral
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

entity TB_prediction_adder is
--  Port ( );
end TB_prediction_adder;

architecture Behavioral of TB_prediction_adder is

    component prediction_adder is
        Generic(
            alpha           :   INTEGER := 256;
            color_res       :   INTEGER := 8;
            n_size          :   integer := 7;
            a_size          :   integer := 15;
            b_size          :   integer := 9;
            c_size          :   integer := 8;
            k_size          :   integer := 5
        );
        Port ( 
            pclk            : in    STD_LOGIC;
            en              : in    STD_LOGIC;
            valid_data      : in    STD_LOGIC;
            sign_flag       : in    STD_LOGIC;
            pixel           : in    unsigned (color_res - 1 downto 0);
            fixed_pred      : in    unsigned (color_res - 1 downto 0);
            C               : in    signed (c_size - 1 downto 0);
            B               : in    signed (b_size - 1 downto 0);
            N               : in    unsigned (n_size - 1 downto 0);
            k               : in    unsigned (k_size -1 downto 0);
            error           : out   signed (color_res - 1 downto 0);
            mapped_error    : out   unsigned (color_res - 1 downto 0));
    end component;
    
    constant alpha           :   INTEGER := 256;
    constant color_res       :   INTEGER := 8;
    constant n_size          :   integer := 7;
    constant a_size          :   integer := 15;
    constant b_size          :   integer := 9;
    constant c_size          :   integer := 8;
    constant k_size          :   integer := 5;
    
    
    signal pclk            :    STD_LOGIC := '1';                         
    signal en              :    STD_LOGIC := '1';                         
    signal valid_data      :    STD_LOGIC := '0';                         
    signal sign_flag       :    STD_LOGIC;                         
    signal pixel           :    unsigned (color_res - 1 downto 0); 
    signal fixed_pred      :    unsigned (color_res - 1 downto 0); 
    signal C               :    signed (c_size - 1 downto 0);      
    signal B               :    signed (b_size - 1 downto 0);      
    signal N               :    unsigned (n_size - 1 downto 0);
    signal k               :    unsigned (k_size - 1 downto 0);    
    signal error_val       :    signed (color_res - 1 downto 0);   
    signal mapped_error    :    unsigned (color_res - 1 downto 0);    

begin

    dut : prediction_adder
        Generic map (
            alpha      =>   alpha,
            color_res  =>   color_res,
            n_size     =>   n_size   ,
            a_size     =>   a_size   ,
            b_size     =>   b_size   ,
            c_size     =>   c_size   ,
            k_size     =>   k_size
        )
        Port map( 
            pclk            =>   pclk        ,
            en              =>   en          ,
            valid_data      =>   valid_data  ,
            sign_flag       =>   sign_flag   ,
            pixel           =>   pixel       ,
            fixed_pred      =>   fixed_pred  ,
            C               =>   C           ,
            B               =>   B           ,
            N               =>   N           ,
            k               =>   k           ,
            error           =>   error_val   ,
            mapped_error    =>   mapped_error);
            
            
    stimuli : process
    begin
        wait for 80 ns;
        valid_data <= '1';
        
        report "Starting tests..." severity NOTE;
        
        sign_flag <= '0';
        pixel     <= to_unsigned(100, pixel'length);
        fixed_pred<= to_unsigned(150, fixed_pred'length);
        C         <= to_signed(1, C'length);
        B         <= to_signed(1, B'length);
        N         <= to_unsigned(1, N'length);
        k         <= to_unsigned(3, k'length);
        wait for 80 ns;
        assert error_val = to_signed(-51, error_val'length) report "error was not -51 as expected but is " & integer'image(to_integer(error_val)) severity ERROR;
        assert mapped_error = to_unsigned(101, mapped_error'length) report "mapped_error was not 101 as expected but is " & integer'image(to_integer(mapped_error)) severity ERROR;

        sign_flag <= '0';
        pixel     <= to_unsigned(200, pixel'length);
        fixed_pred<= to_unsigned(150, fixed_pred'length);
        C         <= to_signed(1, C'length);
        B         <= to_signed(1, B'length);
        N         <= to_unsigned(1, N'length);
        k         <= to_unsigned(3, k'length);
        wait for 80 ns;
        assert error_val = to_signed(49, error_val'length) report "error was not 49 as expected but is " & integer'image(to_integer(error_val)) severity ERROR;
        assert mapped_error = to_unsigned(98, mapped_error'length) report "mapped_error was not 98 as expected but is " & integer'image(to_integer(mapped_error)) severity ERROR;
        
        sign_flag <= '0';
        pixel     <= to_unsigned(200, pixel'length);
        fixed_pred<= to_unsigned(150, fixed_pred'length);
        C         <= to_signed(2, C'length);
        B         <= to_signed(1, B'length);
        N         <= to_unsigned(1, N'length);
        k         <= to_unsigned(3, k'length);
        wait for 80 ns;
        assert error_val = to_signed(48, error_val'length) report "error was not 48 as expected but is " & integer'image(to_integer(error_val)) severity ERROR;
        assert mapped_error = to_unsigned(96, mapped_error'length) report "mapped_error was not 96 as expected but is " & integer'image(to_integer(mapped_error)) severity ERROR;
        
        sign_flag <= '0';
        pixel     <= to_unsigned(200, pixel'length);
        fixed_pred<= to_unsigned(150, fixed_pred'length);
        C         <= to_signed(-2, C'length);
        B         <= to_signed(1, B'length);
        N         <= to_unsigned(1, N'length);
        k         <= to_unsigned(3, k'length);
        wait for 80 ns;
        assert error_val = to_signed(52, error_val'length) report "error was not 52 as expected but is " & integer'image(to_integer(error_val)) severity ERROR;
        assert mapped_error = to_unsigned(104, mapped_error'length) report "mapped_error was not 104 as expected but is " & integer'image(to_integer(mapped_error)) severity ERROR;
        
        sign_flag <= '0';
        pixel     <= to_unsigned(200, pixel'length);
        fixed_pred<= to_unsigned(150, fixed_pred'length);
        C         <= to_signed(-2, C'length);
        B         <= to_signed(2, B'length);
        N         <= to_unsigned(1, N'length);
        k         <= to_unsigned(3, k'length);
        wait for 80 ns;
        assert error_val = to_signed(52, error_val'length) report "error was not 52 as expected but is " & integer'image(to_integer(error_val)) severity ERROR;
        assert mapped_error = to_unsigned(104, mapped_error'length) report "mapped_error was not 104 as expected but is " & integer'image(to_integer(mapped_error)) severity ERROR;
        
        sign_flag <= '0';
        pixel     <= to_unsigned(200, pixel'length);
        fixed_pred<= to_unsigned(150, fixed_pred'length);
        C         <= to_signed(-2, C'length);
        B         <= to_signed(-2, B'length);
        N         <= to_unsigned(1, N'length);
        k         <= to_unsigned(3, k'length);
        wait for 80 ns;
        assert error_val = to_signed(52, error_val'length) report "error was not 52 as expected but is " & integer'image(to_integer(error_val)) severity ERROR;
        assert mapped_error = to_unsigned(104, mapped_error'length) report "mapped_error was not 104 as expected but is " & integer'image(to_integer(mapped_error)) severity ERROR;
        
        sign_flag <= '1';
        pixel     <= to_unsigned(200, pixel'length);
        fixed_pred<= to_unsigned(150, fixed_pred'length);
        C         <= to_signed(-2, C'length);
        B         <= to_signed(-2, B'length);
        N         <= to_unsigned(2, N'length);
        k         <= to_unsigned(3, k'length);
        wait for 80 ns;
        assert error_val = to_signed(-48, error_val'length) report "error was not -48 as expected but is " & integer'image(to_integer(error_val)) severity ERROR;
        assert mapped_error = to_unsigned(95, mapped_error'length) report "mapped_error was not 95 as expected but is " & integer'image(to_integer(mapped_error)) severity ERROR;
        
        sign_flag <= '0';
        pixel     <= to_unsigned(200, pixel'length);
        fixed_pred<= to_unsigned(255, fixed_pred'length);
        C         <= to_signed(10, C'length);
        B         <= to_signed(-2, B'length);
        N         <= to_unsigned(2, N'length);
        k         <= to_unsigned(3, k'length);
        wait for 80 ns;
        assert error_val = to_signed(-55, error_val'length) report "error was not -55 as expected but is " & integer'image(to_integer(error_val)) severity ERROR;
        assert mapped_error = to_unsigned(109, mapped_error'length) report "mapped_error was not 109 as expected but is " & integer'image(to_integer(mapped_error)) severity ERROR;
        
        sign_flag <= '0';
        pixel     <= to_unsigned(5, pixel'length);
        fixed_pred<= to_unsigned(255, fixed_pred'length);
        C         <= to_signed(10, C'length);
        B         <= to_signed(-2, B'length);
        N         <= to_unsigned(2, N'length);
        k         <= to_unsigned(3, k'length);
        wait for 80 ns;
        assert error_val = to_signed(6, error_val'length) report "error was not 6 as expected but is " & integer'image(to_integer(error_val)) severity ERROR;
        assert mapped_error = to_unsigned(12, mapped_error'length) report "mapped_error was not 12 as expected but is " & integer'image(to_integer(mapped_error)) severity ERROR;
        
        sign_flag <= '0';
        pixel     <= to_unsigned(200, pixel'length);
        fixed_pred<= to_unsigned(150, fixed_pred'length);
        C         <= to_signed(-2, C'length);
        B         <= to_signed(-2, B'length);
        N         <= to_unsigned(1, N'length);
        k         <= to_unsigned(0, k'length);
        wait for 80 ns;
        assert error_val = to_signed(52, error_val'length) report "error was not 52 as expected but is " & integer'image(to_integer(error_val)) severity ERROR;
        assert mapped_error = to_unsigned(105, mapped_error'length) report "mapped_error was not 12 as expected but is " & integer'image(to_integer(mapped_error)) severity ERROR;
        
        sign_flag <= '1';
        pixel     <= to_unsigned(200, pixel'length);
        fixed_pred<= to_unsigned(150, fixed_pred'length);
        C         <= to_signed(-2, C'length);
        B         <= to_signed(-2, B'length);
        N         <= to_unsigned(1, N'length);
        k         <= to_unsigned(0, k'length);
        wait for 80 ns;
        assert error_val = to_signed(-48, error_val'length) report "error was not -48 as expected but is " & integer'image(to_integer(error_val)) severity ERROR;
        assert mapped_error = to_unsigned(94, mapped_error'length) report "mapped_error was not 94 as expected but is " & integer'image(to_integer(mapped_error)) severity ERROR;
    
        report "Tests done..." severity NOTE;
    
        wait;
    end process;
            
    pclock : process
    begin
        pclk <= not pclk;
        wait for 20 ns;
    end process;



end Behavioral;
