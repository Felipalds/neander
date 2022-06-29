library ieee;
use ieee.std_logic_1164.all; 

entity mux5x8 is
port(
	c0 : in std_logic_vector(7 downto 0); -- LDA
	c1 : in std_logic_vector(7 downto 0); -- ADD
	c2 : in std_logic_vector(7 downto 0); -- OR
	c3 : in std_logic_vector(7 downto 0); -- AND
	c4 : in std_logic_vector(7 downto 0); -- NOT
	sel : in std_logic_vector(2 downto 0);
	z : out std_logic_vector(7 downto 0)
	);
end entity;

architecture jorge of mux5x8 is
begin

	 z <= c0 when sel = "000" else
	 c1 when sel = "001" else
	 c2 when sel = "010" else
	 c3 when sel = "011" else
	 c4 when sel = "100" else
	"ZZZZZZZZ";
	  
end architecture;
