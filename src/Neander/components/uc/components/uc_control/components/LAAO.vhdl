library ieee;
use ieee.std_logic_1164.all;

entity LAAO is
    port(
        dec2uc     : in std_logic_vector(10 downto 0);
        counter    : in std_logic_vector(2 downto 0);

        barr_stuff : out std_logic_vector(10 downto 0)
    );
end entity;

architecture comute of LAAO is

    signal ula_op : std_logic_vector(2 downto 0);

begin

    ula_op <= "000" when dec2uc = "00100000000" else --ok
    "001" when dec2uc = "00010000000" else --ok
    "010" when dec2uc = "00001000000" else
    "011" when dec2uc = "00000100000" else
    (others => 'Z');
    
    barr_stuff(8) <= ula_op(2);
    barr_stuff(7) <= ula_op(1);
    barr_stuff(6) <= ula_op(0);
    
    barr_stuff(10) <= '1';
    barr_stuff(9)  <= not(counter(2)) or counter(1) or not(counter(0));
    barr_stuff(5)  <= not(counter(1)) and (counter(2) xor counter(0));
    barr_stuff(4)  <= not(counter(2)) and counter(1) and not(counter(0));
    barr_stuff(3)  <= (counter(2) and not(counter(0))) or (not(counter(2)) and not(counter(1)) and counter(0));
    barr_stuff(2)  <= (not(counter(1)) and (counter(2) xnor counter(0))) or (not(counter(2)) and counter(1) and counter(0));
    barr_stuff(1)  <= '0';
    barr_stuff(0)  <= counter(2) and counter(1) and counter(0);

end architecture;