-- módulo ula
library ieee;
use ieee.std_logic_1164.all;

entity ula is
    port (
        -- dados
        barramento : inout std_logic_vector(7 downto 0),

        -- controle
        rst, clk : in std_logic;
        ac_nrw : in std_logic;
        mem_nrw: in std_logic;
        ula_op : in std_logic_vector(2 downto 0);

        -- status
        flagsNZ : out std_logic_vector(1 downto 0);
    );


end entity;

architecture calculator of ula is

        -- lista de signals
        s_ac2ula, s_ula2ac : std_logic_vector(7 downto 0);
        s_ac2flags : std_logic_vector(1 downto 0);

    component registrador is
        port(
            d      : in  std_logic_vector(7 downto 0);
            clock  : in  std_logic;
            pr, cl : in  std_logic;
            nrw    : in  std_logic;
            s      : out std_logic_vector(7 downto 0)
        );
    end component;
    -- component registrator -> flagsNZ
    -- component ulaalu 

begin
    -- u_AC : reg port map
    -- u_fnz : reg2 port map
    -- u_ulaau: ula alu port map

    -- barramento para mux

end architecture;