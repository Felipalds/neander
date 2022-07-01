library ieee;
use ieee.std_logic_1164.all;

entity tb_memory is
end entity;

architecture zaz of tb_memory is
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

    -- Signals

    signal cl, clk, barr_pc, rem_rw, mem_rw, rdm_rw : std_logic := '0';
    signal END_pc, END_barr : std_logic_vector(7 downto 0);
    signal interface_barramento : std_logic_vector(7 downto 0);

    
begin
    u_memory : memory port map(cl, clk, barr_pc, rem_rw, mem_rw, rdm_rw, END_pc, END_barr, interface_barramento);
    p_main : process
    begin

-- Reset( nice pratice)

        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
        cl <= '0';
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        cl <= '1';
        wait for 10 ns;

        -- 1

        clk <= '0';

        END_pc <= "11110000";
        END_barr <= "11111111";

	barr_pc <= '1';
	rem_rw <= '1';
        mem_rw <= '0';
        rdm_rw <= '0';

        wait for 10 ns;
        -- 2

        clk <= '1';

        wait for 10 ns;
        -- 3

        clk <= '0';

        rem_rw <= '0';
        rdm_rw <= '1';

        wait for 10 ns;
        -- 4

        clk <= '1';

        wait for 10 ns;
        -- 5

        clk <= '0';

        rdm_rw <= '0';
	
	wait for 10 ns;
	-- 6
	
	clk <= '1';

	wait for 10 ns;

-- proximo teste

	clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
        cl <= '0';
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        cl <= '1';
        wait for 10 ns;

	-- 1

        clk <= '0';


	barr_pc <= '0';
	rem_rw <= '1';
        mem_rw <= '0';
        rdm_rw <= '0';

        wait for 10 ns;
        -- 2

        clk <= '1';

        wait for 10 ns;
        -- 3

        clk <= '0';

        rem_rw <= '0';
        rdm_rw <= '1';

        wait for 10 ns;
        -- 4

        clk <= '1';

        wait for 10 ns;
        -- 5

        clk <= '0';

        rdm_rw <= '0';
	
	wait for 10 ns;
	-- 6
	
	clk <= '1';

	wait for 10 ns;

-- proximo teste

	clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
        cl <= '0';
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        cl <= '1';
        wait for 10 ns;
	-- 1

	clk <= '0';

	barr_pc <= '0';
	rem_rw <= '1';
        mem_rw <= '0';
        rdm_rw <= '0';

        wait for 10 ns;
        -- 2

        clk <= '1';

        wait for 10 ns;
        -- 3

        clk <= '0';

        rem_rw <= '0';
        mem_rw <= '1';

        wait for 10 ns;
        -- 4

        clk <= '1';

        wait for 10 ns;
        -- 5

        clk <= '0';

        mem_rw <= '0';
	
	wait for 10 ns;
	-- 6
	
	clk <= '1';

	wait for 10 ns;
	

wait for  10 ns;
end process;




	




















end architecture;