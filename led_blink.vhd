library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
library unisim;
use unisim.vcomponents.all;
entity tutorial_led_blink is
  port (
    i_clock_p      : in  std_logic;
    i_clock_n 	   : in std_logic;    
o_led_drive  : out std_logic
    );
end tutorial_led_blink;
 
architecture rtl of tutorial_led_blink is
 
  -- Constants to create the frequencies needed:
  -- Formula is: (25 MHz / 100 Hz * 50% duty cycle)
  -- So for 100 Hz: 25,000,000 / 100 * 0.5 = 125,000
  constant c_CNT_1HZ   : natural := 12500000;
 
 
  -- These signals will be the counters:
  signal r_CNT_1HZ   : natural range 0 to c_CNT_1HZ;
   
  -- These signals will toggle at the frequencies needed:
  signal r_TOGGLE_1HZ   : std_logic := '0';
 
   signal i_clock_buf :std_logic := '0';
   signal iclock : std_logic := '0';
begin
 
  u_ibufgds_iclock : IBUFGDS
    port map (
      I => i_clock_p,
      IB => i_clock_N,
      O => i_clock_buf
    );
u_bufg_iclock : BUFG port map (I => i_clock_buf, O => iclock);
-- All processes toggle a specific signal at a different frequency.
  -- They all run continuously even if the switches are
  -- not selecting their particular output.
  p_1_HZ : process (iclock) is
  begin
    if rising_edge(iclock) then
      if r_CNT_1HZ = c_CNT_1HZ-1 then  -- -1, since counter starts at 0
        r_TOGGLE_1HZ <= not r_TOGGLE_1HZ;
        r_CNT_1HZ    <= 0;
      else
        r_CNT_1HZ <= r_CNT_1HZ + 1;
      end if;
    end if;
  end process p_1_HZ;
  o_led_drive <= r_TOGGLE_1HZ;
end rtl;
