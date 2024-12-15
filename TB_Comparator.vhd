
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Comparator is
end TB_Comparator;

architecture Behavioral of TB_Comparator is
    signal tag_cache : std_logic_vector(7 downto 0);
    signal tag_cpu   : std_logic_vector(7 downto 0);
    signal valid     : std_logic;
    signal hit       : std_logic;

    component Comparator
        Port (
            tag_cache : in std_logic_vector(7 downto 0);
            tag_cpu   : in std_logic_vector(7 downto 0);
            valid     : in std_logic;
            hit       : out std_logic
        );
    end component;

begin
    UUT: Comparator
        Port map (
            tag_cache => tag_cache,
            tag_cpu   => tag_cpu,
            valid     => valid,
            hit       => hit
        );

    process
    begin
        -- Test case 1: Hit
        tag_cache <= "10101010";
        tag_cpu <= "10101010";
        valid <= '1';
        wait for 10 ns;

        -- Test case 2: Miss (tag mismatch)
        tag_cache <= "10101010";
        tag_cpu <= "01010101";
        valid <= '1';
        wait for 10 ns;

        -- Test case 3: Miss (invalid)
        tag_cache <= "10101010";
        tag_cpu <= "10101010";
        valid <= '0';
        wait for 10 ns;

        wait;
    end process;
end Behavioral;
