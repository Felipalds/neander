library ieee;
use ieee.std_logic_1164.all;

entity pc is
    port(
        clk, cl : in std_logic;
        nbarrinc : in std_logic;
        barr : in std_logic_vector(7 downto 0);
        pc_rw : in std_logic;
        s_endPC2MEM : out std_logic_vector(7 downto 0);
        s_rirw: in std_logic;
        s_dec2uc : out std_logic_vector(10 downto 0)
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
    signal s_ri2dec: std_logic_vector(7 downto 0);

    signal s_mux2pc : std_logic_vector(7 downto 0);


begin

    u_ADD : ADDmod port map("00000001", s_PCatual, '0', sadd, c_out);
    u_mux2x8 : mux2x8 port map(barr, sadd, nbarrinc, s_mux2pc);
    u_PCreg : regCarga8bit port map(s_mux2pc, clk, '1', cl, pc_rw, s_PCatual);

    u_RI : regCarga8bit port map(barr, clk, '1', cl, s_rirw, s_ri2dec);

    s_dec2uc <= "10000000000" when s_ri2dec = "00000000" else
                "01000000000" when s_ri2dec = "00010000" else
                "00100000000" when s_ri2dec = "00100000" else
                "00010000000" when s_ri2dec = "00110000" else
                "00001000000" when s_ri2dec = "01000000" else
                "01000100000" when s_ri2dec = "01010000" else
                "00000010000" when s_ri2dec = "01100000" else
                "00000001000" when s_ri2dec = "10000000" else
                "00000000100" when s_ri2dec = "10010000" else
                "00000000010" when s_ri2dec = "10100000" else
                "00000000001" when s_ri2dec = "11110000" else
                (others => 'Z');


    s_endPC2MEM <= s_PCatual;
end architecture;
