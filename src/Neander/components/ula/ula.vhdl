-- módulo ula
library ieee;
use ieee.std_logic_1164.all;

entity ula is
    port (
        -- dados
        barramento : inout std_logic_vector(7 downto 0);

        -- controle
        rst, clk : in std_logic;
        ac_nrw : in std_logic;
        mem_nrw: in std_logic;
        ula_op : in std_logic_vector(2 downto 0);

        -- status
        intFlags : out std_logic_vector(1 downto 0)
    );


end entity;

architecture calculator of ula is
    -- Constantes
    constant CLK_PERIOD : time := 20 ns;

    -- ULA (ALU)
    component ulaalu is
        port (
            -- dados
            x, y : in std_logic_vector(7 downto 0);
            s: out std_logic_vector(7 downto 0);

            -- controle
            ula_op : in std_logic_vector(2 downto 0);

            -- status
            flagsNZ: out std_logic_vector(1 downto 0)
        );
    end component;
    
    -- Registrador 8 Bits -> AC
    component regCarga8bit is
        port(
            d      : in  std_logic_vector(7 downto 0);
            clock  : in  std_logic;
            pr, cl : in  std_logic;
            nrw    : in  std_logic;
            s      : out std_logic_vector(7 downto 0)
        );
    end component regCarga8bit;

    -- Registrador 2 Bits -> FNZ
    component regCarga2bit is
        port(
            d      : in  std_logic_vector(1 downto 0);
			clock  : in  std_logic;
			pr, cl : in  std_logic;
			nrw    : in  std_logic;
			s      : out std_logic_vector(1 downto 0)
        );
    end component;

    -- Lista de Signals 
    signal s_ac2ula, s_ula2ac : std_logic_vector(7 downto 0);
    signal s_ac2flags : std_logic_vector(1 downto 0);
begin
    -- Unidades/Componentes
    u_AC : regCarga8bit port map(s_ula2ac, clk, '1', rst, ac_nrw, s_ac2ula);
    u_FNZ : regCarga2bit port map(s_ac2flags, clk, '1', rst, ac_nrw, intFlags); -- Componente FLAGS
    u_ulaalu : ulaalu port map(s_ac2ula, barramento, s_ula2ac, ula_op, s_ac2flags);

    -- Mux Especial 2x8
    barramento <= s_ac2ula when mem_nrw = '1' else (others => 'Z');

end architecture;