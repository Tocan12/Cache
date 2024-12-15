
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_UC is
end TB_UC;

architecture Behavioral of TB_UC is
    signal clk       : std_logic := '0';
    signal reset     : std_logic := '0';
    signal hit       : std_logic := '0';
    signal update    : std_logic;
    signal read_mem  : std_logic;
    signal write_mem : std_logic;
    signal fsm_state : std_logic_vector(1 downto 0); -- 00: Search, 01: RD/WR, 10: Update

    component UC
        Port (
            clk       : in std_logic;
            reset     : in std_logic;
            hit       : in std_logic;
            update    : out std_logic;
            read_mem  : out std_logic;
            write_mem : out std_logic;
            fsm_state : out std_logic_vector(1 downto 0) -- 00: Search, 01: RD/WR, 10: Update
        );
    end component;

begin
    UUT: UC
        Port map (
            clk       => clk,
            reset     => reset,
            hit       => hit,
            update    => update,
            read_mem  => read_mem,
            write_mem => write_mem,
            fsm_state => fsm_state
        );

    -- Clock generation
    clk_process: process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;


    stimulus: process
    begin
        -- Reset 
        reset <= '1';
        wait for 10 ns;
        reset <= '0';

        -- hit during SEARCH (transition to RD/WR)
        hit <= '1';
        wait for 20 ns;

        --  miss during SEARCH (transition to UPDATE)
        hit <= '0';
        wait for 20 ns;

        --  transition back to SEARCH after UPDATE
        wait for 20 ns;

        --  normal RD/WR cycle transition back to SEARCH
        hit <= '1';
        wait for 20 ns;

        wait;
    end process;
end Behavioral;
