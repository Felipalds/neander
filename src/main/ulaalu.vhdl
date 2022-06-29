-- módulo ula
library ieee;
use ieee.std_logic_1164.all;

entity ulaalu is
    port (
        -- dados
        x, y : in std_logic_vector(7 downto 0);
        s: out std_logic_vector(7 downto 0);

        -- controle
        ula_op : in std_logic_vector(2 downto 0);

        -- status
        flagsNZ: out std_logic_vector(1 downto 0)
    );

end entity;

architecture super_calculator of ulaalu is

    signal s_resultado : std_logic_vector(7 downto 0); -- sinal de saida e do detector
        
    signal s_not : std_logic_vector(7 downto 0); -- sinal da not
    signal s_and : std_logic_vector(7 downto 0); -- sinal da and
    signal s_or : std_logic_vector(7 downto 0); -- sinal da or
    
    signal s_add : std_logic_vector(7 downto 0); -- sinal da add
    signal s_cout : std_logic; -- sinal do cout, parte do ADDmod

    -- módulo not
    component NOTmod is
    port(
        X : in std_logic_vector(7 downto 0);
        notX : out std_logic_vector(7 downto 0)
    );
end component;
    
    -- módulo and
 
component ANDmod is
    port(
        X : in std_logic_vector(7 downto 0);
        Y : in std_logic_vector(7 downto 0);
        sAND : out std_logic_vector(7 downto 0)
    );
end component;

    --módulo or

component ORmod is
    port(
        X : in std_logic_vector(7 downto 0);
        Y : in std_logic_vector(7 downto 0);
        sOR : out std_logic_vector(7 downto 0)
    );
end component;

    -- módulo add

component ADDmod is
	port(
		A : in std_logic_vector(7 downto 0);
		B : in std_logic_vector(7 downto 0);
		Cin_geral : in std_logic;
		ZOut : out std_logic_vector(7 downto 0);
		Cout_geral : out std_logic
	);
end component; 

    component mux5x8 is
	port(
        c0 : in std_logic_vector(7 downto 0);
        c1 : in std_logic_vector(7 downto 0);
        c2 : in std_logic_vector(7 downto 0);
        c3 : in std_logic_vector(7 downto 0);
        c4 : in std_logic_vector(7 downto 0);
        sel : in std_logic_vector(2 downto 0);
        z : out std_logic_vector(7 downto 0)
        );
	end component;

begin
	u_not : Notmod port map(x, s_not);
	u_and : ANDmod port map(x, y, s_and);
	u_or : ORmod port map(x, y, s_or);
	u_add : ADDmod port map(x, y, '0', s_add, s_cout);
	u_mux5x8 : mux5x8 port map(y, s_add, s_or, s_and, s_not, ula_op, s_resultado);
	
	flagsNZ(0) <= not(s_resultado(7) or s_resultado(6) or s_resultado(5) or s_resultado(4) or s_resultado(3) or s_resultado(2) or s_resultado(1) or s_resultado(0)); 
    flagsNZ(1) <= s_resultado(7); -- flags

    s <= s_resultado;
end architecture;
