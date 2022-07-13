library ieee;
use ieee.std_logic_1164.all;

entity tb_memory is
end entity;

architecture zaz of tb_memory is
    -- Components --

    
    component memory is -- Memory Module
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

    -- Signals --

    signal clk, barr_pc, rem_rw, rdm_rw : std_logic := '0';
    signal mem_rw, cl : std_logic;
    signal END_pc, END_barr : std_logic_vector(7 downto 0) := (others => '0');
    signal interface_barramento : std_logic_vector(7 downto 0);

begin
    u_memory : memory port map(cl, clk, barr_pc, rem_rw, mem_rw, rdm_rw, END_pc, END_barr, interface_barramento);
    p_main : process
    begin

        -- Initial Reset --

        cl <= '0';
        mem_rw <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns; -- Clock 1
        clk <= '0';

        cl <= '1'; -- End of Reset

        -- Process 1 - I.R "0000 0000"

        END_pc <= "00000000"; -- Mux
        barr_pc <= '1';
        rem_rw <= '1'; -- REM

        wait for 10 ns;
        clk <= '1';
        wait for 10 ns; -- Clock 2
        clk <= '0';

        rem_rw <= '0'; -- REM
        rdm_rw <= '1'; -- RDM
        
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns; -- Clock 3
        clk <= '0'; 

        -- Process 2 - D.W 180 -> "0000 0000"

        END_barr <= "10110100"; -- Mux -> 180
        barr_pc <= '0';
        rem_rw <= '1'; -- REM
        rdm_rw <= '0'; -- RDM

        wait for 10 ns;
        clk <= '1';
        wait for 10 ns; -- Clock 4
        clk <= '0'; 

        rem_rw <= '0'; -- REM
        mem_rw <= '1'; -- Memory
        
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns; -- Clock 5
        clk <= '0';

        mem_rw <= '0';

        -- Process 3 - I.R "0000 0001"

        END_pc <= "00000001"; -- Mux
        barr_pc <= '1';
        rem_rw <= '1'; -- REM
        rdm_rw <= '0'; -- RDM

        wait for 10 ns;
        clk <= '1';
        wait for 10 ns; -- Clock 6
        clk <= '0'; 

        rem_rw <= '0';
        rdm_rw <= '1';

        wait for 10 ns;
        clk <= '1';
        wait for 10 ns; -- Clock 7
        clk <= '0'; 

        -- Process 4 - I.R "0000 0000"

        END_pc <= "00000000"; -- Mux
        rem_rw <= '1'; -- REM
        rdm_rw <= '0'; -- RDM

        wait for 10 ns;
        clk <= '1';
        wait for 10 ns; -- Clock 8
        clk <= '0'; 

        rem_rw <= '0';
        rdm_rw <= '1';

        wait for 10 ns;
        clk <= '1';
        wait for 10 ns; -- Clock 9
        clk <= '0';       
        
        wait; -- ?
    end process;
end architecture;