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
 
  --ILA Declaration
  component ila_0 is
  port(
    clk : in std_logic;
    probe0 : in std_logic_vector(0 downto 0); --Note if your port widths are wrong it will not tell you
    probe1 : in std_logic_vector(0 downto 0);
    probe2 : in std_logic_vector(63 downto 0)
   );
  end component;
  
  -- Constants to create the frequencies needed:
  -- Formula is: (25 MHz / 100 Hz * 50% duty cycle)
  -- So for 100 Hz: 25,000,000 / 100 * 0.5 = 125,000
  constant c_CNT_1HZ   : natural := 12500000;
 
 
  -- These signals will be the counters:
  signal r_CNT_1HZ   : natural range 0 to c_CNT_1HZ;
  signal r_CNT_stdvec : std_logic_vector(63 downto 0);
  -- These signals will toggle at the frequencies needed:
  signal r_TOGGLE_1HZ   : std_logic := '0';
 
   signal i_clock_buf :std_logic := '0';
   signal iclock : std_logic := '0';
   
   
begin


 r_CNT_stdvec <= std_logic_vector(to_unsigned(r_CNT_1HZ, r_CNT_stdvec'length));
 
    ila_0_i : ila_0
  port map(
    clk => iclock,
    probe0(0) => iclock,
    probe1(0) => r_Toggle_1HZ,
    probe2(63 to 0) => R_CNT_stdvec

  );
 
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
