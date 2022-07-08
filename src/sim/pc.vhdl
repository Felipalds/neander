library ieee;
use ieee.std_logic_1164.all;

entity pc is
    port(
        clk, cl : in std_logic;
        nbarrinc : in std_logic;
        barr : in std_logic_vector(7 downto 0);
        rw : in std_logic;
        s_endPC2MEM : out std_logic_vector(7 downto 0)
    );
end entity;

architecture brigadeiros of pc is

    -- Components --

    component ADDmod is
        port(
            A : in std_logic_vector(7 downto 0);
            B : in std_logic_vector(7 downto 0);
            Cin_geral : in std_logic;
            ZOut : out std_logic_vector(7 downto 0);
            Cout_geral : out std_logic
        );
    end component;

    component mux2x8 is
        port(
            mbar : in std_logic_vector(7 downto 0);
            mpc : in std_logic_vector(7 downto 0);
            sel : in std_logic;
            sm : out std_logic_vector(7 downto 0)
        );
    end component;

    component regCarga8bit
        port(
            d      : in  std_logic_vector(7 downto 0);
            clock  : in  std_logic;
            pr, cl : in  std_logic;
            rw    : in  std_logic;
            s      : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Signals --

    signal c_out : std_logic;
    signal sadd : std_logic_vector(7 downto 0);
    signal s_PCatual : std_logic_vector(7 downto 0);

    signal s_mux2pc : std_logic_vector(7 downto 0);


begin

    u_ADD : ADDmod port map("00000001", s_PCatual, '0', sadd, c_out);
    u_mux2x8 : mux2x8 port map(barr, sadd, nbarrinc, s_mux2pc);
    u_PCreg : regCarga8bit port map(s_mux2pc, clk, '1', cl, rw, s_PCatual);

    s_endPC2MEM <= s_PCatual;
end architecture;
