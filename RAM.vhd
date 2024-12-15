
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RAM is
    Port (
        clk       : in std_logic;
        reset     : in std_logic;
        index     : in std_logic_vector(5 downto 0);
        offset    : in std_logic_vector(1 downto 0);  -- 2 bits for byte selection (4 bytes total)
        data_in   : in std_logic_vector(31 downto 0); -- 4 bytes (32 bits)
        data_out  : out std_logic_vector(7 downto 0);  -- 1 byte (8 bits)
        write_en  : in std_logic
    );
end RAM;

architecture Behavioral of RAM is
    type DataArray is array (0 to 63) of std_logic_vector(31 downto 0); 
    signal memory : DataArray := (others => (others => '0'));  
begin

    process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                memory <= (others => (others => '0'));
            elsif write_en = '1' then
                memory(to_integer(unsigned(index))) <= data_in;
            end if;
        end if;
    end process;


    data_out <= memory(to_integer(unsigned(index)))(
        to_integer(unsigned(offset)) * 8 + 7 downto to_integer(unsigned(offset)) * 8
    );
end Behavioral;
