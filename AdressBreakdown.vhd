
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AddressBreakdown is
    Port (
        address_in : in std_logic_vector(15 downto 0);
        tag_out    : out std_logic_vector(7 downto 0);
        index_out  : out std_logic_vector(5 downto 0);
        offset_out : out std_logic_vector(1 downto 0)
    );
end AddressBreakdown;

architecture Behavioral of AddressBreakdown is
begin
    tag_out <= address_in(15 downto 8);
    index_out <= address_in(7 downto 2);
    offset_out <= address_in(1 downto 0);
end Behavioral;
