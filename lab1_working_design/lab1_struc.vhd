--CEG3155
--Hamidou Nouhoum Cisse
--Gerald Azichoba
--direct implementation of laboratory 1 design in a single file,

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

ENTITY lab1_q is
	port (
	lleft : in std_logic;
	lright : in std_logic;

	greset : in std_logic;

	gclock : in std_logic;
	enable : in std_logic;
	output : out std_logic_vector(7 downto 0));

end lab1_q;

architecture rtl of lab1_q is


	signal display : std_logic_vector(7 downto 0);
	signal lmask : std_logic_vector(7 downto 0):= "00000001";
	signal rmask : std_logic_vector(7 downto 0):= "10000000";
	signal n : std_logic_vector(7 downto 0):= "00000000";
	signal lr : std_logic_vector(7 downto 0);


begin

	display <= lr when (lleft = '1' and lright= '1') else
				  rmask when (lright = '1' and lleft = '0') else
				  lmask when (lright = '0' and lleft = '1') else
				  n;
-- process the left shift operation
	left_ma : process (gclock) is
	begin
		if (greset = '1') then
			lmask <= "00000001";
		elsif (rising_edge(gclock) and lleft='1') then
			lmask <= std_logic_vector(unsigned(lmask) sll 1);
			if (lmask = "00000000") then
					lmask <= "00000001";
			end if;
		else
		end if;
	end process left_ma;
-- process the right shift operation
	right_ma : process (gclock) is
	begin
		if (greset = '1') then
			rmask <= "10000000";
		elsif (rising_edge(gclock) and lright = '1') then
			rmask <= std_logic_vector(unsigned(rmask) srl 1);
			if (rmask = "00000000") then
					rmask <= "10000000";
			end if;
		end if;
	end process right_ma;
	-- load the bitwise OR of both right and left mask if both RIGHT and left
	-- signals are on
	lr_ma : process (gclock) is
	begin
		if (rising_edge(gclock) and lleft = '1' and lright = '1') then
			lr <= lmask or rmask;
		end if;
	end process lr_ma;
-- send the display vector to the LEDs
	displaying : process (gclock) is
	begin
		if (rising_edge(gclock)) then
			output <= display;
		end if;
	end process displaying;

end rtl;
