library ieee;
use ieee.std_logic_1164.all;

entity tb_mem2ula is
end entity;

architecture motelDoGarzon of tb_mem2ula is
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

    -- Signals

    signal clk, barr_pc, rem_rw, rdm_rw, ac_rw : std_logic := '0';
    signal mem_rw, cl : std_logic;
    signal END_pc, END_barr : std_logic_vector(7 downto 0) := (others => '0');
    signal interface_barramento : std_logic_vector(7 downto 0);
    signal ula_op : std_logic_vector(2 downto 0);
    signal intFlags : std_logic_vector(1 downto 0);

begin

    u_memory : memory port map(cl, clk, barr_pc, rem_rw, mem_rw, rdm_rw, END_pc, END_barr, interface_barramento);
    u_ula : ula port map (interface_barramento, cl, clk, ac_rw, mem_rw, ula_op, intFlags);

    p_jooj : process
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

        END_pc <= "11110111";
        END_barr <= "11111111";

        barr_pc <= '1';
        rem_rw <= '1';
        mem_rw <= '0';
        rdm_rw <= '0';

        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
        clk <= '0';

        rem_rw <= '0';
        rdm_rw <= '1';
        wait for 10 ns;

        clk <= '1';
        wait for 10 ns;
        clk <= '0';

        rdm_rw <= '0';
        wait for 10 ns;

        clk <= '1';
        wait for 10 ns;
        clk <= '0';
        wait for 10 ns;


        -- Teste - (ULA / LDA)

        ula_op <= "000";
        ac_rw <= '1';
        mem_rw <= '0';

        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;

        ac_rw <= '0';
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    -- Teste - (Memory / RI)

        clk <= '0';
        wait for 10 ns;
        END_pc <= "11111000";
        END_barr <= "11111111";

        barr_pc <= '1';
        rem_rw <= '1';
        mem_rw <= '0';
        rdm_rw <= '0';
        wait for 10 ns;

    
        clk <= '1';
        wait for 10 ns;

        rem_rw <= '0';
        rdm_rw <= '1';

        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;

        clk <= '0';
        rdm_rw <= '0';
        wait for 10 ns;

        
        clk <= '1';
        wait for 10 ns;

        -- Teste - (ULA / ADD)

        ula_op <= "001";
        ac_rw <= '1';
        mem_rw <= '0';
 
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
 
        ac_rw <= '0';
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;

        -- Teste - (Memory / RI)

        clk <= '0';
        wait for 10 ns;
        END_pc <= "11111000";
        END_barr <= "11111111";

        barr_pc <= '0';
        rem_rw <= '1';
        mem_rw <= '0';
        rdm_rw <= '0';
        wait for 10 ns;

    
        clk <= '1';
        wait for 10 ns;

        rem_rw <= '0';
        mem_rw <= '1';

        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;

        clk <= '0';
        mem_rw <= '0';
        wait for 10 ns;

        
        clk <= '1';
        wait for 10 ns;




        wait;
    end process;

end architecture;