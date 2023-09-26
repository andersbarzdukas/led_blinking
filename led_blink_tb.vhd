library ieee;
use ieee.std_logic_1164.all;

entity tutorial_led_blink_tb is
end tutorial_led_blink_tb;

architecture tb of tutorial_led_blink_tb is
	signal clock_p_stim, clock_n_stim : std_logic;  -- inputs
	constant clock_period : time := 3.333 ns;
	signal led_drive : std_logic;  -- outputs
begin
	-- connecting testbench signals with half_adder.vhd
	UUT : entity work.tutorial_led_blink
  	port map (
    	i_clock_p => clock_p_stim,
    	i_clock_n => clock_n_stim,
    	o_led_drive => led_drive
	);

	clock_process : process
  	begin
    	  clock_p_stim <= '1';
    	  clock_n_stim <= '0';
    	  wait for clock_period/2;
    	  clock_p_stim <= '0';
    	  clock_n_stim <= '1';
    	  wait for clock_period/2;
	end process;

end tb ;

