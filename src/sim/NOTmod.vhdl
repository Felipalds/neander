library ieee;
use ieee.std_logic_1164.all;

entity NOTmod is
    port(
        X : in std_logic_vector(7 downto 0);
        notX : out std_logic_vector(7 downto 0)
    );
end;

architecture comuta of NOTmod is

begin
    notX(7 downto 0) <= not X(7 downto 0);
end;