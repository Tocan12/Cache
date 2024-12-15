
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TagRAM is
    Port (
        clk       : in std_logic;
        reset     : in std_logic;
        index     : in std_logic_vector(5 downto 0);
        tag_in    : in std_logic_vector(7 downto 0);
        valid_in  : in std_logic;
        write_en  : in std_logic;
        tag_out   : out std_logic_vector(7 downto 0);
        valid_out : out std_logic
    );
end TagRAM;

architecture Behavioral of TagRAM is
    type TagArray is array (0 to 63) of std_logic_vector(8 downto 0); -- 8-bit tag + 1-bit valid
    signal memory : TagArray := (others => (others => '0'));
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                memory <= (others => (others => '0'));
            elsif write_en = '1' then
                memory(to_integer(unsigned(index))) <= tag_in & valid_in;
            end if;
        end if;
    end process;

    tag_out <= memory(to_integer(unsigned(index)))(8 downto 1);
    valid_out <= memory(to_integer(unsigned(index)))(0);
end Behavioral;
