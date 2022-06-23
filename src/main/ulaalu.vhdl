-- módulo ula
library ieee;
use ieee.std_logic_1164.all;

entity ulaalu is
    port (
        -- dados
        x, y : in std_logic_vector(7 downto 0);
        s: out std_logic_vector(7 downto 0);

        -- controle
        ula_op : in std_logic_vector(3 downto 0);

        -- status
        flagsNZ: out std_logic_vector(1 downto 0);
    );


end entity;

architecture super_calculator of ula is

    signal s_resultado : std_logic_vector(7 downto 0);

    -- módulo not
    -- módulo and, or
    -- módulo add
    -- u_adder

begin


end architecture;