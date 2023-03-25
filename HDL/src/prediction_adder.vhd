----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2023 03:02:41 PM
-- Design Name: 
-- Module Name: prediction_adder - Behavioral
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
use IEEE.MATH_REAL.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity prediction_adder is
    Generic(
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
end prediction_adder;

architecture Behavioral of prediction_adder is

    -- System constants
    constant alpha  : INTEGER   := 2**color_res;

    constant mod_lim : signed(color_res + 1 downto 0) := to_signed(integer(ceil(real(alpha) / 2.0)), color_res + 2);

    signal pixel_latch           :    unsigned (color_res - 1 downto 0) := (others=>'0');
    signal fixed_pred_latch      :    unsigned (color_res - 1 downto 0) := (others=>'0');
    signal sign_flag_latch       :    STD_LOGIC := '0';

    signal pred_1 : signed(color_res + 1 downto 0);
    signal pred_2 : signed(color_res + 1 downto 0);
    signal pred_3 : signed(color_res + 1 downto 0);
    
    signal pred_er_1 : signed(color_res + 1 downto 0);
    signal pred_er_2 : signed(color_res + 1 downto 0);
    signal pred_er_3 : signed(color_res + 1 downto 0);
    
    signal mapped_0_flag : STD_LOGIC;
    signal error_positive_flag : STD_LOGIC;
    
    signal mapped_er_1 : unsigned(color_res + 1 downto 0);

begin

    process (pclk) 
    begin
        if rising_edge(pclk) and en = '1' then
            pixel_latch <= pixel;
            fixed_pred_latch <= fixed_pred;
            sign_flag_latch <= sign_flag;
        end if;
    end process;

    pred_1 <= signed("00" & fixed_pred_latch);
    pred_2 <= pred_1 + C when sign_flag_latch = '0' else pred_1 - C;
    pred_3 <= to_signed(alpha - 1, pred_3'length) when pred_2 > to_signed(alpha - 1, pred_2'length) else
              to_signed(0, pred_3'length) when pred_2 < to_signed(0, pred_2'length) else
              pred_2;
              
    pred_er_1 <= signed("00" & pixel_latch) - pred_3 when sign_flag_latch = '0' else
                 - signed("00" & pixel_latch) + pred_3;
                 
    pred_er_2 <= pred_er_1 mod alpha;
    
    pred_er_3 <= pred_er_2 when pred_er_2 < mod_lim else pred_er_2 - alpha;
    
    mapped_0_flag <= '1' when (k = to_unsigned(0, k'length) and shift_left(resize(B, B'length + 1), 1) <= -signed('0' & N)) else '0';    -- BURDE DETTE IKKE VÆRE '<='?
    error_positive_flag <= '1' when pred_er_3 >= to_signed(0, pred_er_3'length) else '0';
    
    mapped_er_1 <= unsigned(shift_left(pred_er_3, 1) + 1) when mapped_0_flag = '1' and error_positive_flag = '1' else
                   unsigned(- shift_left(pred_er_3 + 1, 1)) when mapped_0_flag = '1' and error_positive_flag = '0' else
                   unsigned(shift_left(pred_er_3, 1)) when error_positive_flag = '1' else
                   unsigned(- shift_left(pred_er_3, 1) - 1);
       
    error <= resize(pred_er_3, error'length);
    mapped_error <= resize(mapped_er_1, mapped_error'length);
    
end Behavioral;
