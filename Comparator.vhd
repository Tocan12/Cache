
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Comparator is
    Port (
        tag_cache : in std_logic_vector(7 downto 0);
        tag_cpu   : in std_logic_vector(7 downto 0);
        valid     : in std_logic;
        hit       : out std_logic
    );
end Comparator;

architecture Behavioral of Comparator is
begin
    hit <= '1' when (tag_cache = tag_cpu and valid = '1') else '0';
end Behavioral;
