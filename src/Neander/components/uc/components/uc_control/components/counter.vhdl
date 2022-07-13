library ieee;
use ieee.std_logic_1164.all;

entity contador is
    port(
        clk: in std_logic;
        reset: in std_logic;
        q: out std_logic_vector(3 downto 0)
        );
end entity;

architecture cont of contador is
    component ffjk_process is
	port(
		j, k   : in  std_logic;
		clock  : in  std_logic;
		pr, cl : in  std_logic;
		q, nq  : out std_logic
	);
    end component;

    signal spr: std_logic := '1';
    signal sj, sk : std_logic_vector (3 downto 0);
    signal sq : std_logic_vector (3 downto 0);
    signal snq : std_logic_vector (3 downto 0);

begin 

    u0: ffjk_process port map(sj(0), sk(0), clk, reset, spr, sq(0), snq(0));
    u1: ffjk_process port map(sj(1), sk(1), clk, spr, reset, sq(1), snq(1));
    u2: ffjk_process port map(sj(2), sk(2), clk, spr, reset, sq(2), snq(2));
    u3: ffjk_process port map(sj(3), sk(3), clk, spr, reset, sq(3), snq(3));
    u4: ffjk_process port map(sj(4), sk(4), clk, spr, reset, sq(4), snq(4));
    u5: ffjk_process port map(sj(5), sk(5), clk, spr, reset, sq(5), snq(5));
    u6: ffjk_process port map(sj(6), sk(6), clk, spr, reset, sq(6), snq(6));
    u7: ffjk_process port map(sj(7), sk(7), clk, spr, reset, sq(7), snq(7));


    sj(0) <= snq(3) or sq(2);
    sj(1) <= (snq(3) and sq(0)) or (sq(3) and sq(2) and snq(0));
    sj(2) <= (sq(3) and snq(0)) or (snq(3) and sq(1) and sq(0));
    sj(3) <= (sq(2) and sq(1) and snq(0)) or (snq(2) and sq(1) and sq(0));

    sk(0) <= (snq(3) or sq(2) or snq(1));
    sk(1) <= (snq(3) and sq(0)) or (sq(3) and snq(2)) or (sq(3) and snq(0));
    sk(2) <= sq(3) and snq(1);
    sk(3) <= (sq(2) and snq(1) and sq(0)) or (snq(2) and snq(0));

    q <= sq;

end architecture;
