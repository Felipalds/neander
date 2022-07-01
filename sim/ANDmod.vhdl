library ieee;
use ieee.std_logic_1164.all;

entity ANDmod is
    port(
        X : in std_logic_vector(7 downto 0);
        Y : in std_logic_vector(7 downto 0);
        sAND : out std_logic_vector(7 downto 0)
    );
end;

architecture comuta of ANDmod is

begin
    sAND <= X and Y;
end;