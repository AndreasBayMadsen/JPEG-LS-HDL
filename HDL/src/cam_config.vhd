----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/17/2023 02:09:37 PM
-- Design Name: 
-- Module Name: cam_config - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cam_config is
    Generic (-- Interface settings
             CLK_FREQ_MHZ   : INTEGER   := 125;
             SCCB_FREQ_HZ   : INTEGER   := 1000);
    Port (  -- Common
            resetn  : in    STD_LOGIC   := '1';
            clk     : in    STD_LOGIC   := '1';
            -- I2C
            sda     : inout STD_LOGIC   := 'Z';
            scl     : inout STD_LOGIC   := 'Z';
            -- Control
            start   : in    STD_LOGIC   := '0';
            done    : out   STD_LOGIC   := '0'
            );
end cam_config;

architecture Behavioral of cam_config is
    -- Attributes
    attribute PULLTYPE          : STRING;
    attribute PULLTYPE of sda   : signal is "PULLUP";
    attribute PULLTYPE of scl   : signal is "PULLUP";

    -- Component declarations
    component i2c_master
        GENERIC(
            input_clk : INTEGER := 50_000_000; --input clock speed from user logic in Hz
            bus_clk   : INTEGER := 400_000);   --speed the i2c bus (scl) will run at in Hz
        PORT(
            clk       : IN     STD_LOGIC;                    --system clock
            reset_n   : IN     STD_LOGIC;                    --active low reset
            ena       : IN     STD_LOGIC;                    --latch in command
            addr      : IN     STD_LOGIC_VECTOR(6 DOWNTO 0); --address of target slave
            rw        : IN     STD_LOGIC;                    --'0' is write, '1' is read
            data_wr   : IN     STD_LOGIC_VECTOR(7 DOWNTO 0); --data to write to slave
            busy      : OUT    STD_LOGIC;                    --indicates transaction in progress
            data_rd   : OUT    STD_LOGIC_VECTOR(7 DOWNTO 0); --data read from slave
            ack_error : BUFFER STD_LOGIC;                    --flag if improper acknowledge from slave
            sda       : INOUT  STD_LOGIC;                    --serial data output of i2c bus
            scl       : INOUT  STD_LOGIC);                   --serial clock output of i2c bus
    end component;
    
    -- Type declarations
    type COMMAND_LIST is array (0 to 112) of INTEGER;
    type FSM_STATE_TYPE is (IDLE, TRANSMIT_ADDRESS, TRANSMIT_DATA);
    
    -- Constant declarations
    constant SLAVE_ADDRESS  : INTEGER       := 16#21#;  -- SCCB address of the camera module
    
        -- Register addresses
    constant GAIN_ADDR                  : INTEGER   := 16#00#;
    constant VREF_ADDR                  : INTEGER   := 16#03#;
    constant COM3_ADDR                  : INTEGER   := 16#0C#;
    constant COM4_ADDR                  : INTEGER   := 16#0D#;
    constant COM5_ADDR                  : INTEGER   := 16#0E#;
    constant COM6_ADDR                  : INTEGER   := 16#0F#;
    constant AECH_ADDR                  : INTEGER   := 16#10#;
    constant CLKRC_ADDR                 : INTEGER   := 16#11#;
    constant COM7_ADDR                  : INTEGER   := 16#12#;
    constant COM8_ADDR                  : INTEGER   := 16#13#;
    constant COM9_ADDR                  : INTEGER   := 16#14#;
    constant COM10_ADDR                 : INTEGER   := 16#15#;
    constant HSTART_ADDR                : INTEGER   := 16#17#;
    constant HSTOP_ADDR                 : INTEGER   := 16#18#;
    constant VSTART_ADDR                : INTEGER   := 16#19#;
    constant VSTOP_ADDR                 : INTEGER   := 16#1A#;
    constant MVFP_ADDR                  : INTEGER   := 16#1E#;
    constant ADCCTR1_ADDR               : INTEGER   := 16#21#;
    constant ADCCTR2_ADDR               : INTEGER   := 16#22#;
    constant AEW_ADDR                   : INTEGER   := 16#24#;
    constant AEB_ADDR                   : INTEGER   := 16#25#;
    constant VPT_ADDR                   : INTEGER   := 16#26#;
    constant HREF_ADDR                  : INTEGER   := 16#32#;
    constant CHLF_ADDR                  : INTEGER   := 16#33#;
    constant ADC_ADDR                   : INTEGER   := 16#37#;
    constant ACOM_ADDR                  : INTEGER   := 16#38#;
    constant OFON_ADDR                  : INTEGER   := 16#39#;
    constant COM12_ADDR                 : INTEGER   := 16#3C#;
    constant COM14_ADDR                 : INTEGER   := 16#3E#;
    constant TSLB_ADDR                  : INTEGER   := 16#3A#;
    constant COM15_ADDR                 : INTEGER   := 16#40#;
    constant AWBC1_ADDR                 : INTEGER   := 16#43#;
    constant AWBC2_ADDR                 : INTEGER   := 16#44#;
    constant AWBC3_ADDR                 : INTEGER   := 16#45#;
    constant AWBC4_ADDR                 : INTEGER   := 16#46#;
    constant AWBC5_ADDR                 : INTEGER   := 16#47#;
    constant AWBC6_ADDR                 : INTEGER   := 16#48#;
    constant MTX1_ADDR                  : INTEGER   := 16#4F#;
    constant MTX2_ADDR                  : INTEGER   := 16#50#;
    constant MTX3_ADDR                  : INTEGER   := 16#51#;
    constant MTX4_ADDR                  : INTEGER   := 16#52#;
    constant MTX5_ADDR                  : INTEGER   := 16#53#;
    constant MTX6_ADDR                  : INTEGER   := 16#54#;
    constant BRIGHT_ADDR                : INTEGER   := 16#55#;
    constant CONTRAS_ADDR               : INTEGER   := 16#56#;
    constant CONTRAS_CENTER_ADDR        : INTEGER   := 16#57#;
    constant LCC3_ADDR                  : INTEGER   := 16#64#;
    constant LCC4_ADDR                  : INTEGER   := 16#65#;
    constant LCC5_ADDR                  : INTEGER   := 16#66#;
    constant GFIX_ADDR                  : INTEGER   := 16#69#;
    constant AWBCTR3_ADDR               : INTEGER   := 16#6C#;
    constant AWBCTR2_ADDR               : INTEGER   := 16#6D#;
    constant AWBCTR1_ADDR               : INTEGER   := 16#6E#;
    constant AWBCTR0_ADDR               : INTEGER   := 16#6F#;
    constant SCALING_XSC_ADDR           : INTEGER   := 16#70#;
    constant SCALING_YSC_ADDR           : INTEGER   := 16#71#;
    constant SCALING_DCWCTR_ADDR        : INTEGER   := 16#72#;
    constant SCALING_PCLK_DIV_ADDR      : INTEGER   := 16#73#;
    constant REG74_ADDR                 : INTEGER   := 16#74#;
    constant SLOP_ADDR                  : INTEGER   := 16#7A#;
    constant GAM1_ADDR                  : INTEGER   := 16#7B#;
    constant RGB444_ADDR                : INTEGER   := 16#8C#;
    constant DM_LNL_ADDR                : INTEGER   := 16#92#;
    constant LCC6_ADDR                  : INTEGER   := 16#94#;
    constant LCC7_ADDR                  : INTEGER   := 16#95#;
    constant HAECC1_ADDR                : INTEGER   := 16#9F#;
    constant HAECC2_ADDR                : INTEGER   := 16#A0#;
    constant SCALING_PCLK_DELAY_ADDR    : INTEGER   := 16#A2#;
    constant BD50MAX_ADDR               : INTEGER   := 16#A5#;
    constant HAECC3_ADDR                : INTEGER   := 16#A6#;
    constant HAECC4_ADDR                : INTEGER   := 16#A7#;
    constant HAECC5_ADDR                : INTEGER   := 16#A8#;
    constant HAECC6_ADDR                : INTEGER   := 16#A9#;
    constant HAECC7_ADDR                : INTEGER   := 16#AA#;
    constant BD60MAX_ADDR               : INTEGER   := 16#AB#;
    constant ABLC1_ADDR                 : INTEGER   := 16#B1#;
    constant THL_ST_ADDR                : INTEGER   := 16#B3#;
    
        -- SCCB commands
    constant address_list   : COMMAND_LIST  := (COM7_ADDR,      -- Set RGB565
                                                RGB444_ADDR,
                                                COM15_ADDR,
                                                -- General initialization START
                                                TSLB_ADDR,
                                                COM10_ADDR,
                                                SLOP_ADDR,
                                                GAM1_ADDR,
                                                GAM1_ADDR+1,
                                                GAM1_ADDR+2,
                                                GAM1_ADDR+3,
                                                GAM1_ADDR+4,
                                                GAM1_ADDR+5,
                                                GAM1_ADDR+6,
                                                GAM1_ADDR+7,
                                                GAM1_ADDR+8,
                                                GAM1_ADDR+9,
                                                GAM1_ADDR+10,
                                                GAM1_ADDR+11,
                                                GAM1_ADDR+12,
                                                GAM1_ADDR+13,
                                                GAM1_ADDR+14,
                                                COM8_ADDR,
                                                GAIN_ADDR,
                                                AECH_ADDR,
                                                COM4_ADDR,
                                                COM9_ADDR,
                                                BD50MAX_ADDR,
                                                BD60MAX_ADDR,
                                                AEW_ADDR,
                                                AEB_ADDR,
                                                VPT_ADDR,
                                                HAECC1_ADDR,
                                                HAECC2_ADDR,
                                                16#A1#,
                                                HAECC3_ADDR,
                                                HAECC4_ADDR,
                                                HAECC5_ADDR,
                                                HAECC6_ADDR,
                                                HAECC7_ADDR,
                                                COM8_ADDR,
                                                COM5_ADDR,
                                                COM6_ADDR,
                                                16#16#,
                                                MVFP_ADDR,
                                                ADCCTR1_ADDR,
                                                ADCCTR2_ADDR,
                                                16#29#,
                                                CHLF_ADDR,
                                                16#35#,
                                                ADC_ADDR,
                                                ACOM_ADDR,
                                                OFON_ADDR,
                                                COM12_ADDR,
                                                16#4D#,
                                                16#4E#,
                                                GFIX_ADDR,
                                                REG74_ADDR,
                                                16#8D#,
                                                16#8E#,
                                                16#8F#,
                                                16#90#,
                                                16#91#,
                                                DM_LNL_ADDR,
                                                16#96#,
                                                16#9A#,
                                                16#B0#,
                                                ABLC1_ADDR,
                                                16#B2#,
                                                THL_ST_ADDR,
                                                16#B8#,
                                                AWBC1_ADDR,
                                                AWBC2_ADDR,
                                                AWBC3_ADDR,
                                                AWBC4_ADDR,
                                                AWBC5_ADDR,
                                                AWBC6_ADDR,
                                                16#59#,
                                                16#5A#,
                                                16#5B#,
                                                16#5C#,
                                                16#5D#,
                                                16#5E#,
                                                LCC3_ADDR,
                                                LCC4_ADDR,
                                                LCC5_ADDR,
                                                LCC6_ADDR,
                                                LCC7_ADDR,
                                                AWBCTR3_ADDR,
                                                AWBCTR2_ADDR,
                                                MTX1_ADDR,
                                                MTX2_ADDR,
                                                MTX3_ADDR,
                                                MTX4_ADDR,
                                                MTX5_ADDR,
                                                MTX6_ADDR,
                                                AWBCTR1_ADDR,
                                                AWBCTR0_ADDR,
                                                BRIGHT_ADDR,
                                                CONTRAS_ADDR,
                                                CONTRAS_CENTER_ADDR,
                                                -- General initialization STOP
                                                COM3_ADDR,      -- Set image size to QVGA
                                                COM14_ADDR,
                                                SCALING_DCWCTR_ADDR,
                                                SCALING_PCLK_DIV_ADDR,
                                                SCALING_XSC_ADDR,
                                                SCALING_YSC_ADDR,
                                                HSTART_ADDR,
                                                HSTOP_ADDR,
                                                HREF_ADDR,
                                                VSTART_ADDR,
                                                VSTOP_ADDR,
                                                VREF_ADDR,
                                                SCALING_PCLK_DELAY_ADDR);
    constant value_list     : COMMAND_LIST  := (16#04#,         -- Set RGB565
                                                16#00#,
                                                16#D0#,
                                                -- General initialization START
                                                16#04#,
                                                16#00#, -- Set to 0x02 to invert VSYNC
                                                16#20#,
                                                16#1C#,
                                                16#28#,
                                                16#3C#,
                                                16#55#,
                                                16#68#,
                                                16#76#,
                                                16#80#,
                                                16#88#,
                                                16#8F#,
                                                16#96#,
                                                16#A3#,
                                                16#AF#,
                                                16#C4#,
                                                16#D7#,
                                                16#E8#,
                                                16#E0#,
                                                16#00#,
                                                16#00#,
                                                16#00#,
                                                16#20#,
                                                16#05#,
                                                16#07#,
                                                16#75#,
                                                16#63#,
                                                16#A5#,
                                                16#78#,
                                                16#68#,
                                                16#03#,
                                                16#DF#,
                                                16#DF#,
                                                16#F0#,
                                                16#90#,
                                                16#94#,
                                                16#E5#,
                                                16#61#,
                                                16#4B#,
                                                16#02#,
                                                16#07#,
                                                16#02#,
                                                16#91#,
                                                16#07#,
                                                16#0B#,
                                                16#0B#,
                                                16#1D#,
                                                16#71#,
                                                16#2A#,
                                                16#78#,
                                                16#40#,
                                                16#20#,
                                                16#5D#,
                                                16#19#,
                                                16#4F#,
                                                16#00#,
                                                16#00#,
                                                16#00#,
                                                16#00#,
                                                16#00#,
                                                16#00#,
                                                16#80#,
                                                16#84#,
                                                16#0C#,
                                                16#0E#,
                                                16#82#,
                                                16#0A#,
                                                16#14#,
                                                16#F0#,
                                                16#34#,
                                                16#58#,
                                                16#28#,
                                                16#3A#,
                                                16#88#,
                                                16#88#,
                                                16#44#,
                                                16#67#,
                                                16#49#,
                                                16#0E#,
                                                16#04#,
                                                16#20#,
                                                16#05#,
                                                16#04#,
                                                16#08#,
                                                16#0A#,
                                                16#55#,
                                                16#80#,
                                                16#80#,
                                                16#00#,
                                                16#22#,
                                                16#5E#,
                                                16#80#,
                                                16#11#,
                                                16#9F#,
                                                16#00#,
                                                16#40#,
                                                16#80#,
                                                -- General initialization STOP
                                                16#04#,         -- Set image size to QVGA
                                                16#19#, -- Set to 0x19 to scale PCLK by 
                                                16#11#,
                                                16#F1#,
                                                16#20#,
                                                16#20#,
                                                16#15#,
                                                16#03#,
                                                16#36#,
                                                16#02#,
                                                16#7A#,
                                                16#0A#,
                                                16#02#);
    
    -- Signal declarations
    signal fsm_state        : FSM_STATE_TYPE                := IDLE;
    
    signal i2c_ena          : STD_LOGIC                     := '0';
    signal i2c_address      : INTEGER                       := 0;
    signal i2c_rw           : STD_LOGIC                     := '0';
    signal i2c_write_data   : INTEGER                       := 0;
    signal i2c_busy         : STD_LOGIC                     := '0';
    signal i2c_read_data    : INTEGER                       := 0;
    
    signal i2c_address_vec      : STD_LOGIC_VECTOR(6 downto 0)  := (others=>'0');
    signal i2c_write_data_vec   : STD_LOGIC_VECTOR(7 downto 0)  := (others=>'0');
    signal i2c_read_data_vec    : STD_LOGIC_VECTOR(7 downto 0)  := (others=>'0');
    
    signal resetn_sync      : STD_LOGIC := '1';
    attribute ASYNC_REG     : STRING;
    attribute ASYNC_REG of resetn_sync : signal is "TRUE";
    signal resetn_int       : STD_LOGIC := '1';
    
begin

    -- Component instantiations
    i2c_driver: i2c_master
    generic map(
        input_clk   => CLK_FREQ_MHZ*1000000,
        bus_clk     => SCCB_FREQ_HZ
    )
    port map(
        clk         => clk,
        reset_n     => resetn_int,
        ena         => i2c_ena,
        addr        => i2c_address_vec,
        rw          => i2c_rw,
        data_wr     => i2c_write_data_vec,
        busy        => i2c_busy,
        data_rd     => i2c_read_data_vec,
        ack_error   => open,
        sda         => sda,
        scl         => scl
    );
    
    
    -- Synchronize reset signal
    sync: process(clk)
    begin
        if rising_edge(clk) then
            resetn_sync <= resetn;
            resetn_int  <= resetn_sync;
        end if;
    end process;
    
    -- Handle transmissions
    process(clk)
        variable start_shift    : STD_LOGIC_VECTOR(1 downto 0)  := (others=>'0');
        variable busy_shift     : STD_LOGIC_VECTOR(1 downto 0)  := (others=>'0');
        variable command_count  : INTEGER                       := 0;
    begin
        if rising_edge(clk) then
            if resetn_int = '0' then
                -- Synchronous reset
                fsm_state       <= IDLE;
                --next_fsm_state  <= IDLE;
                i2c_address     <= 0;
                i2c_rw          <= '0';
                i2c_write_data  <= 0;
                i2c_ena         <= '0';
                done            <= '0';
                
                start_shift     := (others=>'0');
                busy_shift      := (others=>'0');
                command_count   := 0;
                
            else
            
                -- Shift registers
                start_shift := start_shift(0) & start;
                busy_shift  := busy_shift(0) & i2c_busy;
                
                -- Default values
                i2c_address     <= SLAVE_ADDRESS;
                i2c_rw          <= '0';             -- Only write
                
                case fsm_state is
                    -- Wait for activation
                    when IDLE =>
                        i2c_ena <= '0';
                    
                        if start_shift = "01" then
                            fsm_state   <= TRANSMIT_ADDRESS;
                            done        <= '0';
                        end if;
                        
                    -- Transmit register address
                    when TRANSMIT_ADDRESS =>
                        --i2c_ena <= '0';
                    
                        if i2c_busy = '0' then
                            i2c_write_data  <= address_list(command_count);
                            i2c_ena         <= '1';
                            --next_fsm_state  <= TRANSMIT_DATA;
                            --fsm_state       <= TRANSMIT_DATA;
                        end if;
                        
                        if busy_shift = "01" then
                            fsm_state <= TRANSMIT_DATA;
                        end if;
                        
                    -- Transmit data
                    when TRANSMIT_DATA =>
                        i2c_write_data <= value_list(command_count);
                        
                        if busy_shift = "01" then
                            i2c_ena         <= '0';
                            command_count   := command_count + 1;
                            
                            if command_count >= address_list'length then
                                command_count   := 0;
                                fsm_state       <= IDLE;
                                done            <= '1';
                            else
                                fsm_state       <= TRANSMIT_ADDRESS;
                            end if;
                        end if;
                        
                end case;
            end if;
        end if;
    end process;
    
    -- Signal assignments
    i2c_address_vec     <= std_logic_vector(to_unsigned(i2c_address, i2c_address_vec'length));
    i2c_write_data_vec  <= std_logic_vector(to_unsigned(i2c_write_data, i2c_write_data_vec'length));
    i2c_read_data       <= to_integer(unsigned(i2c_read_data_vec));
    
end Behavioral;
