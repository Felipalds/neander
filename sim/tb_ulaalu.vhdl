library ieee;
use ieee.std_logic_1164.all;

entity tb_ulaalu is
end entity;

architecture banana of tb_ulaalu is
    component ulaalu is
        port (
            -- dados
            x, y : in std_logic_vector(7 downto 0);
            s: out std_logic_vector(7 downto 0);

            -- controle
            ula_op : in std_logic_vector(2 downto 0);

            -- status
            flagsNZ: out std_logic_vector(1 downto 0)
        );
    end component;

    signal x, y, s : std_logic_vector(7 downto 0);
    signal ula_op : std_logic_vector(2 downto 0);
    signal flagsNZ : std_logic_vector(1 downto 0);
begin
    u_ulaalu : ulaalu port map(x, y, s, ula_op, flagsNZ);
    p_ulaalu : process
    begin
        -- 000 = LDA; 001 = ADD; 010 = OR; 011 = AND; 100 = NOT; XXX = Z;
        y <= "00000001";
        ula_op <= "000";
        wait for 20 ns;

        x <= "00000001";
        ula_op <= "001";
        wait for 20 ns;
        
        x <= "00001111";
        y <= "00000000";
        ula_op <= "010";
        wait for 20 ns;
        
        ula_op <= "011";
        wait for 20 ns;

        ula_op <= "100";
        wait for 20 ns;
        
        ula_op <= "111";
        wait for 20 ns;
    end process;
end architecture;