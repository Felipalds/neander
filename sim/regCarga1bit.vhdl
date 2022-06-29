library ieee;
use ieee.std_logic_1164.all;

entity regCarga1bit is
	port(
		d      : in  std_logic;
		clock  : in  std_logic;
		pr, cl : in  std_logic;
		nrw  : in  std_logic;
		s      : out std_logic
	);
end regCarga1bit;

architecture reg1bit of regCarga1bit is

	component ffd is
		port(
			d      : in  std_logic;
			clock  : in  std_logic;
			pr, cl : in  std_logic;
			q, nq  : out std_logic
		);
	end component;
	
	component mux2x1 is 
		port(
			a:   in  std_logic;
			b:   in  std_logic;
			sel: in  std_logic;
			z :  out std_logic
		);
	end component;

signal dataIn, dataOut, snq : std_logic;

begin
	--envio de dataout para saída s
	s <= dataOut;
	
	--mux
	u_mux : mux2x1 port map(dataOut, d, nrw, dataIn);
	
	--instancia do reg
	u_reg : ffd port map(dataIn, clock, pr, cl, dataOut, snq);
	
end architecture;
