--CEG3155-lab1
--Hamidou Nouhoum Cisse
--Gerald Azichoba
--Top-level,Controller,datapath implementation

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

ENTITY lab1_c is
	port (
	lleft : in std_logic;
	lright : in std_logic;

	outputC : out std_logic_vector(7 downto 0);

	gclockC : in std_logic;
	gresetC : in std_logic);

end lab1_c;

architecture rtl_str of lab1_c is

	signal sC: std_logic_vector(3 downto 0);



begin


 --d flip-flops mapping with the inputs from the control path diagram
			state1: work.dFF_2 port map (i_d =>(lright  and lleft), i_clock =>gclockC , o_q => sC(0));
			state2: work.dFF_2 port map (i_d =>( (not lright)  and lleft) , i_clock =>gclockC , o_q => sC(1));
			state3: work.dFF_2 port map (i_d =>(lright  and (not lleft)) , i_clock =>gclockC , o_q => sC(2));
			state4: work.dFF_2 port map (i_d =>( (not lright)  and (not lleft)) , i_clock =>gclockC , o_q => sC(3));


	-- transfert link from the controller to the datapath and back
			datapath: work.lab1_dtpath port map(greset => gresetC,s => sC,
				gclockW => gclockC,
				shiftr => lright,
				shiftl => lleft,
				outa => outputC);

end rtl_str;
