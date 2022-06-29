library ieee;
use ieee.std_logic_1164.all;

entity regCarga2bit is
	port(
		d      : in  std_logic_vector(1 downto 0);
		clock  : in  std_logic;
		pr, cl : in  std_logic;
		nrw    : in  std_logic;
		s      : out std_logic_vector(1 downto 0)
	);
end entity regCarga2bit;

architecture reg2bit of regCarga2bit is

	component regCarga1bit is
		port(
			d      : in  std_logic;
			clock  : in  std_logic;
			pr, cl : in  std_logic;
			nrw    : in  std_logic;
			s      : out std_logic
		);
	end component regCarga1bit;

	--signal ss, sd : std_logic_vector(7 downto 0);
begin
	
	
	gen_regCarga8bit : for i in 0 to 1 generate
		
		u_reg : regCarga1bit port map(d(i), clock, pr, cl, nrw, s(i));

	end generate gen_regCarga8bit;
	
end architecture;