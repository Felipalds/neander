library ieee;
use ieee.std_logic_1164.all;

entity f_ADDER is
	port(
		A : in std_logic;
		B : in std_logic;
		Cin : in std_logic;
		Z : out std_logic;
		Cout : out std_logic
	);
end;

architecture comuta of f_ADDER is

begin
	Z <= (A xor B) xor Cin;
	Cout <= (Cin and (a or b)) or (a and b);
end;