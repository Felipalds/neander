library ieee;
use ieee.std_logic_1164.all;

entity NOP is
    port(
        counter    : in std_logic_vector(2 downto 0);

        barr_stuff : out std_logic_vector(10 downto 0)
    );
end entity;

architecture comute of NOP is

begin 

    barr_stuff(10) <= '1';  
    barr_stuff(9)  <= not(counter(2)) or (counter(2) and not(counter(1)) and not(counter(0)));
    barr_stuff(8)  <= '0';
    barr_stuff(7)  <= '0';
    barr_stuff(6)  <= '0';
    barr_stuff(5)  <= not(counter(2)) and not(counter(1)) and counter(0);
    barr_stuff(4)  <= not(counter(2)) and not(counter(0)) and counter(1); 
    barr_stuff(3)  <= not(counter(2)) and not(counter(1)) and counter(0);
    barr_stuff(2)  <= not(counter(2)) and not(counter(1)) and not(counter(0));
    barr_stuff(1)  <= '0';
    barr_stuff(0)  <= '0'; 

end architecture;