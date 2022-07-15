library ieee;
use ieee.std_logic_1164.all;

entity tb_counter is
end tb_counter;

architecture test of tb_counter is
    constant CLK_PERIOD : time := 20 ns;

    component contador is
        port(
            clk: in std_logic;
            reset: in std_logic;
            q: out std_logic_vector(2 downto 0)
            );
    end component;

    signal sq, snq : std_logic_vector(2 downto 0);
    signal sreset : std_logic;
    signal sclk : std_logic := '1';

begin
    -- instancia de JK e port map
    u_counter : contador port map(sclk, sreset, sq);
    -- process
    tbp : process
    begin
        -- passo 0
        sclk <= not sclk;
        wait for CLK_PERIOD/2;
    end process;

    tbc : process
    begin
        sreset <= '0';
        wait for CLK_PERIOD;
        
        sreset <= '1';
        wait for CLK_PERIOD;
       
        wait;
    end process;

end architecture;
