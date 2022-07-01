library ieee;
use ieee.std_logic_1164.all;

entity mux2x8 is
port(
        mbar : in std_logic_vector(7 downto 0);
        mpc : in std_logic_vector(7 downto 0);
        sel : in std_logic;
        sm : out std_logic_vector(7 downto 0)
        );
end entity;

architecture roger of mux2x8 is
begin

         sm <= mbar when sel = '0' else
         mpc when sel = '1';

end architecture;