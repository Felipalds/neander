library ieee;
use ieee.std_logic_1164.all;

entity neander is
    port(
        cl, clk : in std_logic;
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
    signal interface_barramento : inout std_logic_vector(7 downto 0);
    signal ac_nrw, mem_nrw : std_logic;

begin
    u_ula : ula port map();
    u_memory : memory port map();
end architecture;