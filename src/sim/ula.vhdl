-- módulo ula
library ieee;
use ieee.std_logic_1164.all;

entity ula is
    port (
        barramento : inout std_logic_vector(7 downto 0); -- Data

        rst, clk : in std_logic; -- Control
        ac_rw : in std_logic;
        mem_rw: in std_logic;
        ula_op : in std_logic_vector(2 downto 0);

        intFlags : out std_logic_vector(1 downto 0) -- Flags/Status
    );


end entity;

architecture calculator of ula is

    -- Components --

    component ulaalu is -- ULA-ALU
        port (
            x, y : in std_logic_vector(7 downto 0); -- Data
            s: out std_logic_vector(7 downto 0);

            ula_op : in std_logic_vector(2 downto 0); -- Control

            flagsNZ: out std_logic_vector(1 downto 0) -- Flags/Status
        );
    end component;
    
    component regCarga8bit is -- 8 Bits Register -> AC
        port(
            d      : in  std_logic_vector(7 downto 0);
            clock  : in  std_logic;
            pr, cl : in  std_logic;
            rw    : in  std_logic;
            s      : out std_logic_vector(7 downto 0)
        );
    end component regCarga8bit;

    component regCarga2bit is -- 2 Bits Register -> FNZ
        port(
            d      : in  std_logic_vector(1 downto 0);
			clock  : in  std_logic;
			pr, cl : in  std_logic;
			rw    : in  std_logic;
			s      : out std_logic_vector(1 downto 0)
        );
    end component;

    -- Signals --

    signal s_ac2ula, s_ula2ac : std_logic_vector(7 downto 0);
    signal s_ac2flags : std_logic_vector(1 downto 0);

begin
    u_AC : regCarga8bit port map(s_ula2ac, clk, '1', rst, ac_rw, s_ac2ula);
    u_FNZ : regCarga2bit port map(s_ac2flags, clk, '1', rst, ac_rw, intFlags);
    u_ulaalu : ulaalu port map(s_ac2ula, barramento, s_ula2ac, ula_op, s_ac2flags);

    -- Special Mux2x8
    barramento <= s_ac2ula when mem_rw = '1' else (others => 'Z');

end architecture;