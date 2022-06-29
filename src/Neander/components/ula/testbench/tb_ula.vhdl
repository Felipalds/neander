library ieee;
use ieee.std_logic_1164.all;

entity tb_ula is
end entity;

architecture rogerio of tb_ula is
    --constant CLK_PERIOD : time := 20 ns;

    component ula is
        port (
            -- dados
            barramento : inout std_logic_vector(7 downto 0);

            -- controle
            rst, clk : in std_logic;
            ac_nrw : in std_logic;
            mem_nrw: in std_logic;
            ula_op : in std_logic_vector(2 downto 0);

            -- status
            intFlags : out std_logic_vector(1 downto 0)
        );
    end component;
    signal barramento : std_logic_vector(7 downto 0);
    signal clk : std_logic := '1';
    signal rst : std_logic := '0';
    signal ac_nrw : std_logic := '0'; 
    signal mem_nrw : std_logic;
    signal ula_op : std_logic_vector(2 downto 0);
    signal intFlags : std_logic_vector(1 downto 0);

begin
    u_ula : ula port map(barramento, rst, clk, ac_nrw, mem_nrw, ula_op, intFlags);
    --p_clk : process
    --begin
        --clk <= not(clk);
	--wait for CLK_PERIOD/2;
    --end process;

    p_ula : process
    begin

 -- reset inicial

	clk <= '0';
	wait for 10 ns;
	clk <= '1';
	wait for 10 ns;	
    rst <= '0';
    clk <= '0';
	wait for 10 ns;
	clk <= '1';
    rst <= '1';
	wait for 10 ns;	
	

    -- LDA
    ula_op <= "000";
    ac_nrw <= '1';
    mem_nrw <= '0';
    barramento <= "01010100";

	clk <= '0';
	wait for 10 ns;
	clk <= '1';
	wait for 10 ns;

    ac_nrw <= '0';
    clk <= '0';
	wait for 10 ns;
	clk <= '1';
	wait for 10 ns;
    
    -- ADD
    ula_op <= "001";
    barramento <= "00000001";
    ac_nrw <= '1';
    clk <= '0';
    wait for 10 ns;
	clk <= '1';
	wait for 10 ns;

    ac_nrw <= '0';
    clk <= '0';
    wait for 10 ns;
	clk <= '1';
	wait for 10 ns;


    -- OR
    ac_nrw <= '1';
    ula_op <= "010";
    barramento <= "00000010";
    clk <= '0';
    wait for 10 ns;
	clk <= '1';
	wait for 10 ns;

    ac_nrw <= '0';
    clk <= '0';
    wait for 10 ns;
	clk <= '1';
	wait for 10 ns;

    -- AND
    ac_nrw <= '1';
    ula_op <= "011";
    barramento <= "01010100";
    clk <= '0';
    wait for 10 ns;
	clk <= '1';
	wait for 10 ns;

    ac_nrw <= '0';
    clk <= '0';
    wait for 10 ns;
	clk <= '1';
	wait for 10 ns;

    -- not
    ac_nrw <= '1';
    ula_op <= "100";
    clk <= '0';
    wait for 10 ns;
	clk <= '1';
	wait for 10 ns;

    ac_nrw <= '0';
    clk <= '0';
    wait for 10 ns;
	clk <= '1';
	wait for 10 ns;

    -- flags
    ac_nrw <= '1';
    ula_op <= "011";
    barramento <= "00000000";
    clk <= '0';
    wait for 10 ns;
	clk <= '1';
	wait for 10 ns;

    ac_nrw <= '0';
    clk <= '0';
    wait for 10 ns;
	clk <= '1';
	wait for 10 ns;
    
    ac_nrw <= '0';
    clk <= '0';
    wait for 10 ns;
	clk <= '1';
	wait for 10 ns;
    wait; 
    end process;
end architecture;