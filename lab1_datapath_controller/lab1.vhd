--CEG3155-lab1
--Hamidou Nouhoum Cisse
--Gerald Azichoba
--Top-level,Controller,datapath implementation
---------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

ENTITY lab1 is
	port (
	lleftG : in std_logic;
	lrightG : in std_logic;

	output : out std_logic_vector(7 downto 0);
	gresetQ : in std_logic;
	gclock : in std_logic);

end lab1;

architecture rtl_str of lab1 is

begin

 --link to the controller using port mapping
			controller: work.lab1_c port map(lleft => lleftG,lright => lrightG,gclockC => gclock ,gresetC => gresetQ,outputC => output);



end rtl_str;
