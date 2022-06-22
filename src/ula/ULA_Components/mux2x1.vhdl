library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is 
port(
    a:   in  std_logic;
    b:   in  std_logic;
    sel: in  std_logic;
    z :  out std_logic
);
end entity mux2x1;

architecture bhvr of mux2x1 is

    begin

    z <= a when sel='0' else b;

    end architecture;
