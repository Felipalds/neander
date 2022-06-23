library ieee;
use ieee.std_logic_1164.all;

entity ffd is
	port(
		d      : in  std_logic;
		clock  : in  std_logic;
		pr, cl : in  std_logic;
		q, nq  : out std_logic
	);
end ffd;

architecture ff of ffd is

component ffjk is
	port(
		j, k   : in  std_logic;
		clock  : in  std_logic;
		pr, cl : in  std_logic;
		q, nq  : out std_logic
	);
end component;

signal nd : std_logic;

begin

	nd <= not(d);
	
	u_ffd : ffjk port map(d, nd, clock, pr, cl, q, nq);
	
end architecture;
