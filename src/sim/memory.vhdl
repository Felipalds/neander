library ieee;
use ieee.std_logic_1164.all;

entity memory is
    port(
        cl, clk: in std_logic;
        barr_pc : in std_logic;
        REM_rw : in std_logic;
        MEM_rw : in std_logic;
        RDM_rw : in std_logic;
        END_pc: in std_logic_vector(7 downto 0);
        END_barr: in std_logic_vector(7 downto 0);
        interface_barramento : inout std_logic_vector(7 downto 0)
    );
end entity;


architecture george of memory is

    -- Components --

    component mux2x8 is -- Mux for END_PC and END_BARR
        port(
            mbar : in std_logic_vector(7 downto 0);
            mpc : in std_logic_vector(7 downto 0);
            sel : in std_logic;
            sm : out std_logic_vector(7 downto 0)
        );
    end component;

    component regCarga8bit is -- Registers for REM and RDM
        port(
            d      : in  std_logic_vector(7 downto 0);
            clock  : in  std_logic;
            pr, cl : in  std_logic;
            rw    : in  std_logic;
            s      : out std_logic_vector(7 downto 0)
	    );
    end component;

    component as_ram is -- Internal Static Memory
        port(
            addr  : in    std_logic_vector(7 downto 0);
            data  : inout std_logic_vector(7 downto 0);
            notrw : in    std_logic;
            reset : in    std_logic
        );
    end component;

    -- Signals --

    signal s_rdm2barr : std_logic_vector(7 downto 0);
    signal s_rem2mem : std_logic_vector(7 downto 0);
    signal s_mem2rdm: std_logic_vector(7 downto 0);
    signal s_mux2rem: std_logic_vector(7 downto 0);
    signal s_rdm2barramento : std_logic_vector(7 downto 0);

    begin

        u_mux : mux2x8 port map (END_barr, END_pc, barr_PC, s_mux2rem);
        u_rem : regCarga8bit port map (s_mux2rem, clk, '1', cl, REM_rw, s_rem2mem);
        u_MEMORIA : as_ram port map(s_rem2mem, s_mem2rdm, MEM_rw, cl);
        u_rdm : regCarga8bit port map(s_mem2rdm, clk, '1', cl, RDM_rw, s_rdm2barramento);


        interface_barramento <= s_rdm2barramento when MEM_rw = '0'
        else (others => 'Z');
        s_mem2rdm <= interface_barramento when MEM_rw = '1'
        else (others => 'Z');

end architecture;