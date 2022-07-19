library ieee;
use ieee.std_logic_1164.all;

entity counter is
    port(
        clk: in std_logic;
        reset: in std_logic;
        q: out std_logic_vector(2 downto 0)
        );
end entity;

architecture cont of counter is
    component FFJK is
	port(
		j, k   : in  std_logic;
		clock  : in  std_logic;
		pr, cl : in  std_logic;
		q, nq  : out std_logic
	);
    end component;

    signal spr: std_logic := '1';
    signal sj, sk : std_logic_vector (2 downto 0);
    signal sq : std_logic_vector (2 downto 0);
    signal snq : std_logic_vector (2 downto 0);

begin 

    u0: FFJK port map(sj(0), sk(0), clk, reset, spr, sq(0), snq(0));
    u1: FFJK port map(sj(1), sk(1), clk, reset, spr, sq(1), snq(1));
    u2: FFJK port map(sj(2), sk(2), clk, reset, spr, sq(2), snq(2));
   
    sj(0) <= '1';
    sk(0) <= '1';
    sj(1) <= sq(0);
    sk(1) <= sq(0);
    sj(2) <= sq(1) and sq(0);
    sk(2) <= sq(1) and sq(0);

    q <= sq;

end architecture;