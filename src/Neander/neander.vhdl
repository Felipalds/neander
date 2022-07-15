library ieee;
use ieee.std_logic_1164.all;

entity neander is
    port(
        cl, clk : in std_logic
    );
end entity;

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

architecture cha_mate of neander is
    component ula is
        port (
            -- dados
            barramento : inout std_logic_vector(7 downto 0);

            -- controle
            rst, clk : in std_logic;
            ac_rw : in std_logic;
            mem_rw: in std_logic;
            ula_op : in std_logic_vector(2 downto 0);

            -- status
            intFlags : out std_logic_vector(1 downto 0)
        );
    end component;

    component memory is
        port(
            cl, clk: in std_logic;
            barr_pc : in std_logic;
            REM_rw : in std_logic;
            MEM_rw : in std_logic;
            RDM_rw : in std_logic;
            END_pc: in std_logic_vector(7 downto 0);
            END_barr: in std_logic_vector(7 downto 0);
            interface_barramento : inout std_logic_vector(7 downto 0)
        );
    end component;

    component pc is
        port(
            clk, cl : in std_logic;
            nbarrinc : in std_logic;
            barr : inout std_logic_vector(7 downto 0);
            pc_rw : in std_logic;
            s_endPC2MEM : out std_logic_vector(7 downto 0);
            s_rirw: in std_logic;
            s_dec2uc : out std_logic_vector(10 downto 0)
        );
    end component;

    component uc_control is
        port(
            dec2uc   : in std_logic_vector(10 downto 0);
            clk, cl  : in std_logic;

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
    end component;

    -- UC Signals
    signal barr_stuff : std_logic_vector(10 downto 0);

    -- ULA Signals
    signal interface_barramento : std_logic_vector(7 downto 0);
    signal ac_rw, mem_rw : std_logic;
    signal ula_op : std_logic_vector(2 downto 0);
    signal intFlags : std_logic_vector(1 downto 0);

    -- Memory Signals
    signal barr_pc, REM_rw, RDM_rw : std_logic;
    signal END_pc, END_barr : std_logic_vector(7 downto 0);

    -- PC Signals
    signal nbarrinc, pc_rw, s_rirw : std_logic;
    signal s_endPC2MEM : std_logic_vector(7 downto 0);
    signal s_dec2uc : std_logic_vector(10 downto 0);
    
begin
    ula_op(2) <= barr_stuff(8);
    ula_op(1) <= barr_stuff(7);
    ula_op(0) <= barr_stuff(6);
    u_ula : ula port map(interface_barramento, cl, clk, barr_stuff(0), barr_stuff(1), ula_op, intFlags);
    u_memory : memory port map(cl, clk, barr_stuff(9), barr_stuff(2), barr_stuff(1), barr_stuff(3), s_endPC2MEM, interface_barramento, interface_barramento);
    u_pc : pc port map(clk, cl, barr_stuff(10), interface_barramento, barr_stuff(5), s_endPC2MEM, barr_stuff(4), s_dec2uc);
    u_uc : uc_control port map(s_dec2uc, clk, cl, barr_stuff);
end architecture;