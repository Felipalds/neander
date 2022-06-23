library ieee;
use ieee.std_logic_1164.all;

entity mux5x8 is
port(
        sy : in std_logic_vector(7 downto 0);
        sadd : in std_logic_vector(7 downto 0);
        sor : in std_logic_vector(7 downto 0);
        sand : in std_logic_vector(7 downto 0);
        snot : in std_logic_vector(7 downto 0);
        sel : in std_logic_vector(2 downto 0);
        smux : out std_logic_vector(7 downto 0)
        );
end entity;

architecture jorge of mux5x8 is
begin

         smux <= sy when sel = "000" else
         sadd when sel = "001" else
         sor when sel = "010" else
         sand when sel = "011" else
         snot when sel = "100";

end architecture;