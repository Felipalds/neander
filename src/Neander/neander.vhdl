library ieee;
use ieee.std_logic_1164.all;

entity neander is
    port(
        cl, clk : in std_logic
    );
end entity;

architecture cha_mate of neander is
    component ula is
        port (
            -- dados
            barramento : inout std_logic_vector(7 downto 0);

            -- controle
            rst, clk : in std_logic;
            ac_rw : in std_logic;
            mem_rw: in std_logic;
            ula_op : in std_logic_vector(2 downto 0);

            -- status
            intFlags : out std_logic_vector(1 downto 0)
        );
    end component;

    component memory is
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
    end component;

    -- ULA Signals
    signal interface_barramento : std_logic_vector(7 downto 0);
    signal ac_rw, mem_rw : std_logic;
    signal ula_op : std_logic_vector(2 downto 0);
    signal intFlags : std_logic_vector(1 downto 0);

    -- Memory Signals
    signal barr_pc, REM_rw, RDM_rw : std_logic;
    signal END_pc, END_barr : std_logic_vector(7 downto 0);

begin
    u_ula : ula port map(interface_barramento, cl, clk, ac_rw, mem_rw, ula_op, intFlags);
    u_memory : memory port map(cl, clk, barr_pc, REM_rw, mem_rw, RDM_rw, END_pc, END_barr, interface_barramento);
end architecture;