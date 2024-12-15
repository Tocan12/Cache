library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_TagRAM is
end TB_TagRAM;

architecture Behavioral of TB_TagRAM is
    signal clk       : std_logic := '0';
    signal reset     : std_logic := '0';
    signal index     : std_logic_vector(5 downto 0);
    signal tag_in    : std_logic_vector(7 downto 0);
    signal valid_in  : std_logic;
    signal write_en  : std_logic;
    signal tag_out   : std_logic_vector(7 downto 0);
    signal valid_out : std_logic;

    component TagRAM
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
    end component;

begin
    UUT: TagRAM
        Port map (
            clk       => clk,
            reset     => reset,
            index     => index,
            tag_in    => tag_in,
            valid_in  => valid_in,
            write_en  => write_en,
            tag_out   => tag_out,
            valid_out => valid_out
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

        -- Write tag 0x55 to index 0 with valid bit set
        index <= "000000";
        tag_in <= "01010101";
        valid_in <= '1';
        write_en <= '1';
        wait for 10 ns;

        -- Read the tag from index 0
        write_en <= '0';
        wait for 10 ns;

        -- Write tag 0xAA to index 1 with valid bit set
        index <= "000001";
        tag_in <= "10101010";
        valid_in <= '1';
        write_en <= '1';
        wait for 10 ns;

        -- Read the tag from index 1
        write_en <= '0';
        wait for 10 ns;

        wait;
    end process;
end Behavioral;
