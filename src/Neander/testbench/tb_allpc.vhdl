library ieee;
use ieee.std_logic_1164.all;

entity tb_allpc is
end entity;

architecture nomesChads of tb_allpc is
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

    component pc is
        port(
            clk, cl : in std_logic;
            nbarrinc : in std_logic;
            barr : in std_logic_vector(7 downto 0);
            rw : in std_logic;
            s_endPC2MEM : out std_logic_vector(7 downto 0);
            s_rirw: in std_logic;
            s_dec2uc : std_logic_vector(10 downto 0)
        );
    end component;

    -- Signals

    signal clk, barr_pc, rem_rw, rdm_rw, ac_rw : std_logic := '0';
    signal mem_rw, cl : std_logic;
    signal s_endPC2MEM, interface_barramento : std_logic_vector(7 downto 0) := (others => '0');
    signal ula_op : std_logic_vector(2 downto 0);
    signal intFlags : std_logic_vector(1 downto 0);

    -- PC

begin

    u_memory : memory port map(cl, clk, barr_pc, rem_rw, mem_rw, rdm_rw, s_endPC2MEM, interface_barramento, interface_barramento);
    u_ula : ula port map (interface_barramento, cl, clk, ac_rw, mem_rw, ula_op, intFlags);
    u_pc : pc port map(clk, cl, nbarrinc, interface_barramento, rw, s_endPC2MEM, s_rirw, s_dec2uc);

    p_sett_chad_do_voli_ap : process
    begin
        -- Reset Inicial
        cl <= '0';
        mem_rw <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
        clk <= '0';
        cl <= '1';

        -- Teste - (Memory / RI)


        wait for 10 ns;
        clk <= '1';
        -- setar o pc
        s_barr <= "00000000";



        wait for 10 ns;
        clk <= '0';

        wait for 10 ns;
        clk <= '1';
        rem_rw <= '1';
        rem_rw <= s_endPC2MEM;


        wait for 10 ns;
        clk <= '0';

        wait for 10 ns;
        clk <= '1';

        wait for 10 ns;
        clk <= '0';

        wait for 10 ns;

        wait;
    end process;

end architecture;