library ieee;
use ieee.std_logic_1164.all;

entity tb_ula is
end entity;

architecture rogerio of tb_ula is
    constant CLK_PERIOD : time := 20 ns;

    component ula is
        port (
            -- dados
            barramento : inout std_logic_vector(7 downto 0),
    
            -- controle
            rst, clk : in std_logic;
            ac_nrw : in std_logic;
            mem_nrw: in std_logic;
            ula_op : in std_logic_vector(2 downto 0);
    
            -- status
            flagsNZ : out std_logic_vector(1 downto 0);
        );
    end component;
    signal barramento : std_logic_vector(7 downto 0);
    signal clk : std_logic := '1';
    signal rst : std_logic := '0';
    signal ac_nrw, mem_nrw : std_logic;
    signal ula_op : std_logic_vector(1 downto 0);
    signal flagsNZ : std_logic_vector(1 downto 0);
begin
    u_ula : ula port map(barramento, rst, clk, ac_nrw, ula_op, flagsNZ);
    p_clk : process
    begin
        clk <= not(clk);
        wait for CLK_PERIOD/2;
    end process;

    p_ula : process
    begin
        
    end process;
end architecture;