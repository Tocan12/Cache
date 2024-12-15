
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_AddressBreakdown is
end TB_AddressBreakdown;

architecture Behavioral of TB_AddressBreakdown is
    signal address_in : std_logic_vector(15 downto 0);
    signal tag_out    : std_logic_vector(7 downto 0);
    signal index_out  : std_logic_vector(5 downto 0);
    signal offset_out : std_logic_vector(1 downto 0);

    component AddressBreakdown
        Port (
            address_in : in std_logic_vector(15 downto 0);
            tag_out    : out std_logic_vector(7 downto 0);
            index_out  : out std_logic_vector(5 downto 0);
            offset_out : out std_logic_vector(1 downto 0)
        );
    end component;
begin
    UUT: AddressBreakdown
        Port map (
            address_in => address_in,
            tag_out    => tag_out,
            index_out  => index_out,
            offset_out => offset_out
        );

    process
    begin
           address_in <= "1100110011001100"; -- Tag = 11001100, Index = 110011, Offset = 00
        wait for 10 ns;

        address_in <= "0011001100110011"; -- Tag = 00110011, Index = 001100, Offset = 11
        wait for 10 ns;

        address_in <= "1111111100000000"; -- Tag = 11111111, Index = 000000, Offset = 00
        wait for 10 ns;

        wait;
    end process;
end Behavioral;
