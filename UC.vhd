
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity UC is
    Port (
        clk       : in std_logic;
        reset     : in std_logic;
        hit       : in std_logic;
        update    : out std_logic;  
        read_mem  : out std_logic;
        write_mem : out std_logic;
        fsm_state : out std_logic_vector(1 downto 0)  -- the state
    );
end UC;

architecture Behavioral of UC is

    type StateType is (SEARCH, RD_WR, UPDATE);
    signal state : StateType := SEARCH;  
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                state <= SEARCH; 
            else
                case state is
                    when SEARCH =>
                        if hit = '1' then
                            state <= RD_WR;  
                        else
                            state <= UPDATE;  
                        end if;

                    when RD_WR =>
                        state <= SEARCH;  

                    when UPDATE =>
                        state <= SEARCH;  
                end case;
            end if;
        end if;
    end process;

    fsm_state <= "00" when state = SEARCH else
                 "01" when state = RD_WR else
                 "10";

    update <= '1' when state = UPDATE else '0'; 
    read_mem <= '1' when state = UPDATE else '0';  
    write_mem <= '1' when state = RD_WR else '0';  

end Behavioral;
