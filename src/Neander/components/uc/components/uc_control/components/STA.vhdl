library ieee;
use ieee.std_logic_1164.all;

entity STA is
    port(
        counter  : in std_logic_vector(2 downto 0);

        barr_inc : out std_logic;
        barr_pc  : out std_logic;
        ula_op   : out std_logic_vector(2 downto 0);  
        pc_rw    : out std_logic;
        ri_rw    : out std_logic;
        rdm_rw   : out std_logic;
        rem_rw   : out std_logic;
        mem_rw   : out std_logic;
        ac_rw    : out std_logic
    );
end entity;

architecture comute of STA is

begin 

    barr_inc <= '1';  
    barr_pc  <= not(counter(2)) or (counter(2) and not(counter(1)) and not(counter(0)));
    ula_op   <= out std_logic_vector(2 downto 0);  
    pc_rw    <= not(counter(2)) and not(counter(1)) and counter(0);
    ri_rw    <= not(counter(2)) and not(counter(0)) and counter(1); 
    rdm_rw   <= not(counter(2)) and not(counter(1)) and counter(0);
    rem_rw   <= not(counter(2)) and not(counter(1)) and not(counter(0));
    mem_rw   <= '0';
    ac_rw    <= '0';

end architecture;