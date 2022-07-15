library ieee;
use ieee.std_logic_1164.all;

entity uc_control is
    port(
        dec2uc   : in std_logic_vector(10 downto 0);
        clk, cl  : in std_logic;
        intFlags : in std_logic_vector(1 downto 0);

        barr_stuff : out std_logic_vector(10 downto 0)

        --barr_inc : out std_logic;
        --barr_pc  : out std_logic;
        --ula_op   : out std_logic_vector(2 downto 0);  
        --pc_rw    : out std_logic;
        --ri_rw    : out std_logic;
        --rdm_rw   : out std_logic;
        --rem_rw   : out std_logic;
        --mem_rw   : out std_logic;
        --ac_rw    : out std_logic
    );
end entity;

architecture varusAp of uc_control is

    -- barr_stuff (10 downto 0) CHEAT:
    -- 10 = barr_inc
    -- 9 = barr_pc
    -- 8 = ula_op2
    -- 7 = ula_op1
    -- 6 = ula_op0
    -- 5 = pc_rw
    -- 4 = ri_rw
    -- 3 = rdm_rw
    -- 2 = rem_rw
    -- 1 = mem_rw
    -- 0 = ac_rw

    -- Components --

    component counter is
        port(
            clk: in std_logic;
            reset: in std_logic;
            q: out std_logic_vector(2 downto 0)
        );
    end component;

    component NOP is
        port(
            counter    : in std_logic_vector(2 downto 0);

            barr_stuff : out std_logic_vector(10 downto 0)
        );
    end component;

    component STA is
        port(
            counter    : in std_logic_vector(2 downto 0);

            barr_stuff : out std_logic_vector(10 downto 0)
        );
    end component;

    component LAAO is
        port(
            dec2uc     : in std_logic_vector(10 downto 0);
            counter    : in std_logic_vector(2 downto 0);

            barr_stuff : out std_logic_vector(10 downto 0)
        );
    end component;

    component NOTT is
        port(
            counter    : in std_logic_vector(2 downto 0);
            barr_stuff : out std_logic_vector(10 downto 0)
        );
    end component;

    component HLT is
        port(
            counter : in std_logic_vector(2 downto 0);
            barr_stuff : out std_logic_vector(10 downto 0)
        );
    end component;

    component JMP is
        port(
            counter    : in std_logic_vector(2 downto 0);
            intFlags   : in std_logic_vector(1 downto 0);
            barr_stuff : out std_logic_vector(10 downto 0)
        );
    end component;

    -- Signals --

    signal s_counter : std_logic_vector (2 downto 0);
    signal NOP_out, STA_out, LAAO_out, NOT_out, HLT_out, JMP_out : std_logic_vector(10 downto 0);
    
begin
    u_counter : counter port map(clk, cl, s_counter);
    u_NOP : NOP port map(s_counter, NOP_out);
    u_STA : STA port map(s_counter, STA_out);
    u_LAAO : LAAO port map(dec2uc, s_counter, LAAO_out);
    u_NOT : NOTT port map(s_counter, NOT_out);
    u_HLT : HLT port map(s_counter, HLT_out);
    u_JMP : JMP port map(s_counter, intFlags, JMP_out);


    barr_stuff <= NOP_out when dec2uc = "10000000000" else
    STA_out when dec2uc = "01000000000" else
    LAAO_out when dec2uc = "00100000000" or dec2uc = "00010000000" or dec2uc = "00001000000" or dec2uc = "00000100000" else
    NOT_out when dec2uc = "00000010000" else
    HLT_out when dec2uc = "00000000001" else
    (others => 'Z');

    


end architecture;