----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2023 10:57:03 AM
-- Design Name: 
-- Module Name: TB_output_buffer - Behavioral
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

entity TB_output_buffer_synth is
--  Port ( );
end TB_output_buffer_synth;

architecture Behavioral of TB_output_buffer_synth is

    component output_buffer
        Port (  resetn          : in    STD_LOGIC;
                pclk            : in    STD_LOGIC;
                new_pixel       : in    STD_LOGIC;
                valid_data      : in    STD_LOGIC;
                encoded_r       : in    STD_LOGIC_VECTOR (20 - 1 downto 0);
                encoded_g       : in    STD_LOGIC_VECTOR (24 - 1 downto 0);
                encoded_b       : in    STD_LOGIC_VECTOR (20 - 1 downto 0);
                encoded_size_r  : in    STD_LOGIC_VECTOR (5 downto 0);
                encoded_size_g  : in    STD_LOGIC_VECTOR (5 downto 0);
                encoded_size_b  : in    STD_LOGIC_VECTOR (5 downto 0);
                
                request_next    : in    STD_LOGIC;  -- Set high for getting next value, when it is ready.
                read_allowed    : out   STD_LOGIC;  -- Flag for when clock is connected to logic and BRAM
                dout            : out   STD_LOGIC_VECTOR (63 downto 0); -- Data from BRAM.
                new_data_ready  : out   STD_LOGIC;  -- Flag goes high for one clock, when new data is ready on 'dout'.
                end_of_data     : out   STD_LOGIC   -- Flag goes high when all data for image has been read. Flag goes low when new image/data is available.
               );
    end component;

    constant CLK_FREQ   : REAL  := 12.0;    -- Clock frequency in MHz
    
        -- Derived
    constant CLK_PER    : TIME  := (1.0/CLK_FREQ)*1 us;
    constant CLK_HPER   : TIME  := CLK_PER/2;
    
    constant L_max_r       : integer   := 20;
    constant L_max_g       : integer   := 24;
    constant L_max_b       : integer   := 20;
    constant k_width_r     : integer := 5; 
    constant k_width_g     : integer := 5; 
    constant k_width_b     : integer := 5;  
    
    
    signal pclk            :   STD_LOGIC := '1';                            
    signal en              :   STD_LOGIC := '0';                              
    signal valid_data      :   STD_LOGIC := '0';                              
    signal encoded_r       :   STD_LOGIC_VECTOR (L_max_r - 1 downto 0);
    signal encoded_g       :   STD_LOGIC_VECTOR (L_max_g - 1 downto 0);
    signal encoded_b       :   STD_LOGIC_VECTOR (L_max_b - 1 downto 0);
    signal encoded_size_r  :   UNSIGNED (k_width_r downto 0) := (others => '0');          
    signal encoded_size_g  :   UNSIGNED (k_width_g downto 0) := (others => '0');          
    signal encoded_size_b  :   UNSIGNED (k_width_b downto 0) := (others => '0');          

    signal request_next    :   STD_LOGIC := '0';  -- Set high for getting next
    signal read_allowed    :   STD_LOGIC;  -- Flag for when clock is co
    signal dout            :   STD_LOGIC_VECTOR (63 downto 0); -- Data 
    signal new_data_ready  :   STD_LOGIC;  -- Flag goes high for one cl
    signal end_of_data     :   STD_LOGIC;   -- Flag goes high when all d    

begin

    DUT : output_buffer
        Port Map(
        resetn           =>  '1'            ,
        pclk             =>  pclk           ,
        new_pixel        =>  en             ,
        valid_data       =>  valid_data     ,
        encoded_r        =>  encoded_r      ,
        encoded_g        =>  encoded_g      ,
        encoded_b        =>  encoded_b      ,
        encoded_size_r   =>  STD_LOGIC_VECTOR(encoded_size_r) ,
        encoded_size_g   =>  STD_LOGIC_VECTOR(encoded_size_g) ,
        encoded_size_b   =>  STD_LOGIC_VECTOR(encoded_size_b) ,

        request_next     =>  request_next   ,
        read_allowed     =>  read_allowed   ,
        dout             =>  dout           ,
        new_data_ready   =>  new_data_ready ,
        end_of_data      =>  end_of_data
        );
        
    -- Clock
    pclk <= not pclk after CLK_HPER;
    
    stimuli : process
        variable n : integer := 0;
    begin
        
        wait for 1 ns;
        
        -- Enable stream,
        en <= '1';
        valid_data <= '1';
        
        
        -- Set data        
        encoded_r <= x"11111";
        encoded_g <= x"222222";
        encoded_b <= x"33333";
        
        encoded_size_r <= to_unsigned(8, encoded_size_r'length);
        encoded_size_g <= to_unsigned(8, encoded_size_g'length);
        encoded_size_b <= to_unsigned(8, encoded_size_b'length);
        
        wait for CLK_PER; en <= not en; wait for CLK_PER;
        
        encoded_r <= x"44444";
        encoded_g <= x"555555";
        encoded_b <= x"66666";
        
        encoded_size_r <= to_unsigned(16, encoded_size_r'length);
        encoded_size_g <= to_unsigned(16, encoded_size_g'length);
        encoded_size_b <= to_unsigned(16, encoded_size_b'length);
        
        en <= not en; wait for CLK_PER; en <= not en; wait for CLK_PER;
        
        encoded_r <= x"77777";
        encoded_g <= x"888888";
        encoded_b <= x"99999";
        
        encoded_size_r <= to_unsigned(20, encoded_size_r'length);
        encoded_size_g <= to_unsigned(24, encoded_size_g'length);
        encoded_size_b <= to_unsigned(20, encoded_size_b'length);
        
        en <= not en; wait for CLK_PER; en <= not en; wait for CLK_PER; 
        
        wait for 4 * CLK_PER;
        
        valid_data <= '0';
        
        en <= not en; wait for CLK_PER; en <= not en; wait for CLK_PER;   
        
        
        wait for 3 * CLK_PER;
        request_next <= '1';
        wait for CLK_PER;
        request_next <= '0';
        wait for CLK_PER;
        request_next <= '1';
        wait for 5 * CLK_PER;
        wait for CLK_PER;
        request_next <= '0';
        
        
        -- Enable stream,
        en <= '1';
        valid_data <= '1';
        
        
        -- Set data        
        encoded_r <= x"11111";
        encoded_g <= x"222222";
        encoded_b <= x"33333";
        
        encoded_size_r <= to_unsigned(8, encoded_size_r'length);
        encoded_size_g <= to_unsigned(8, encoded_size_g'length);
        encoded_size_b <= to_unsigned(8, encoded_size_b'length);
        
        wait for CLK_PER; en <= not en; wait for CLK_PER;
        
        encoded_r <= x"44444";
        encoded_g <= x"555555";
        encoded_b <= x"66666";
        
        encoded_size_r <= to_unsigned(16, encoded_size_r'length);
        encoded_size_g <= to_unsigned(16, encoded_size_g'length);
        encoded_size_b <= to_unsigned(16, encoded_size_b'length);
        
        en <= not en; wait for CLK_PER; en <= not en; wait for CLK_PER;
        
        encoded_r <= x"77777";
        encoded_g <= x"888888";
        encoded_b <= x"99999";
        
        encoded_size_r <= to_unsigned(4, encoded_size_r'length);
        encoded_size_g <= to_unsigned(4, encoded_size_g'length);
        encoded_size_b <= to_unsigned(4, encoded_size_b'length);
        
        en <= not en; wait for CLK_PER; en <= not en; wait for CLK_PER; 
        
        wait for 4 * CLK_PER;
        
        valid_data <= '0';
        
        en <= not en; wait for CLK_PER; en <= not en; wait for CLK_PER;   
        
        
        wait for 3 * CLK_PER;
        request_next <= '1';
        wait for CLK_PER;
        request_next <= '0';
        wait for CLK_PER;
        request_next <= '1';
        wait for 5 * CLK_PER;
        wait for CLK_PER;
        request_next <= '0';
        
        
        -- Enable stream,
        en <= '1';
        valid_data <= '1';
        
        -- Set data        
        encoded_r <= x"11111";
        encoded_g <= x"222222";
        encoded_b <= x"33333";
        
        encoded_size_r <= to_unsigned(20, encoded_size_r'length);
        encoded_size_g <= to_unsigned(20, encoded_size_g'length);
        encoded_size_b <= to_unsigned(20, encoded_size_b'length);
        
        while n < 33000 loop
            wait for CLK_PER; en <= not en; wait for CLK_PER;
            n := n + 1;
        end loop;
        
        wait;
    end process;


end Behavioral;
