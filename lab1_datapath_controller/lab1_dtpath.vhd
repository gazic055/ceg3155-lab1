--CEG3155-lab1
--Hamidou Nouhoum Cisse
--Gerald Azichoba
--Top-level,Controller,datapath implementation

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

ENTITY lab1_dtpath is
	port (

	greset : in std_logic;
	s : in std_logic_vector(3 downto 0);
	shiftr: in std_logic;
	shiftl: in std_logic;


	gclockW : in std_logic;
	outa : out std_logic_vector(7 downto 0));

end lab1_dtpath;

architecture rtl of lab1_dtpath is


	signal display : std_logic_vector(7 downto 0);
	signal lmask : std_logic_vector(7 downto 0):= "00000001";
	signal rmask : std_logic_vector(7 downto 0):= "10000000";
	signal n : std_logic_vector(7 downto 0):= "00000000";
	signal error: std_logic_vector(7 downto 0):= "11111111";
	signal lr : std_logic_vector(7 downto 0);


begin
--compute the select input and chose the correct display mode
	load_ds : process (gclockW) is
	begin
		if (s(0) = '1') then
			display <= lr;
		elsif (s(1) = '1') then
			display <= lmask;
		elsif (s(2) = '1') then
			display <= rmask;
		elsif (s(3) = '1') then
			display <= n;
		else
			display <= error;
		end if;
	end process load_ds;
-- process the left shift operation
	left_ma : process (gclockW) is
	begin
		if (greset = '1') then
			lmask <= "00000001";
			--wait for 2 sec;
		elsif (rising_edge(gclockW) and shiftl = '1') then
			lmask <= std_logic_vector(unsigned(lmask) sll 1);
			if (lmask = "00000000") then
					lmask <= "00000001";
			end if;
		else

		end if;
	end process left_ma;
-- process the right shift operation
	right_ma : process (gclockW) is
	begin
		if (greset = '1') then
			rmask <= "10000000";
			--wait for 2 sec;
		elsif (rising_edge(gclockW) and shiftr = '1') then
			rmask <= std_logic_vector(unsigned(rmask) srl 1);
			if (rmask = "00000000") then
					rmask <= "10000000";
			end if;
		end if;
	end process right_ma;
-- load the bitwise OR of both right and left mask if both RIGHT and left
-- signals are on
	lr_ma : process (gclockW) is
	begin
		if (rising_edge(gclockW) and shiftr = '1' and shiftl = '1') then
			lr <= lmask or rmask;
		end if;
	end process lr_ma;
-- send the display vector to the output, the controller will receive it
	displaying : process (gclockW) is
	begin
		if (rising_edge(gclockW)) then
			outa <= display;
		end if;
	end process displaying;

end rtl;
