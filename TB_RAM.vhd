
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_RAM is
end TB_RAM;

architecture Behavioral of TB_RAM is
    signal clk      : std_logic := '0';
    signal reset    : std_logic := '0';
    signal index    : std_logic_vector(5 downto 0);
    signal offset   : std_logic_vector(1 downto 0):="00";
    signal data_in  : std_logic_vector(31 downto 0);
    signal data_out : std_logic_vector(7 downto 0);
    signal write_en : std_logic;

    component RAM
        Port (
            clk       : in std_logic;
            reset     : in std_logic;
            index     : in std_logic_vector(5 downto 0);
            offset    : in std_logic_vector(1 downto 0);
            data_in   : in std_logic_vector(31 downto 0);
            data_out  : out std_logic_vector(7 downto 0);
            write_en  : in std_logic
        );
    end component;

begin
    UUT: RAM
        Port map (
            clk      => clk,
            reset    => reset,
            index    => index,
            offset   => offset,
            data_in  => data_in,
            data_out => data_out,
            write_en => write_en
        );

    clk_process: process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

    stimulus: process
    begin
        -- Reset the memory
        reset <= '1';
        wait for 10 ns;
        reset <= '0';

        -- Write data 0xDEADBEEF to index 0
        index <= "000000";
        data_in <= x"DEADBEEF";
        write_en <= '1';
        wait for 10 ns;

        -- Read byte 2 from index 0
        write_en <= '0';
        offset <= "10"; -- Select byte 2
        wait for 10 ns;

        wait;
    end process;
end Behavioral;
