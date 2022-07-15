library ieee;
use ieee.std_logic_1164.all;

entity HLT is
    port(
        counter    : in std_logic_vector(2 downto 0);
        barr_stuff : out std_logic_vector(10 downto 0)
    );
end entity;

architecture comute of HLT is

begin 

    barr_stuff(10) <= '0';
    barr_stuff(9)  <= '0';
    barr_stuff(8)  <= '0';
    barr_stuff(7)  <= '0';
    barr_stuff(6)  <= '0';
    barr_stuff(5)  <= '0';
    barr_stuff(4)  <= '0';
    barr_stuff(3)  <= '0';
    barr_stuff(2)  <= '0';
    barr_stuff(1)  <= '0';
    barr_stuff(0)  <= '0';

end architecture;