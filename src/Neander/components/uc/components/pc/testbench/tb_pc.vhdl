library ieee;
use ieee.std_logic_1164.all;

entity tb_pc is
end entity;

architecture chalaranja of tb_pc is

    -- Components --
    
    component pc is
        port(
            clk, cl : in std_logic;
            nbarrinc : in std_logic;
            barr : in std_logic_vector(7 downto 0);
            rw : in std_logic;
            s_endPC2MEM : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Signals --

    signal clk, cl, nbarrinc : std_logic;
    signal barr : std_logic_vector(7 downto 0);
    signal rw : std_logic;
    signal s_endPC2MEM : std_logic_vector(7 downto 0); 

begin

    u_pc : pc port map(clk, cl, nbarrinc, barr, rw, s_endPC2MEM);

    p_pc : process
    begin
        -- RESET INICIAL
        cl <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
        clk <= '0';
        cl <= '1';

        -- Teste

        wait for 20 ns;

        
        
        wait;
    end process;

end architecture;