-------------------------------------------------------------
-- File: tbQueue.vhd
-- Authors: Eduardo A and Fernando A
-------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity CFila_tb is
end;

architecture tb OF CFila_tb IS
    
    signal clk        : std_logic := '0';
    signal rst        : std_logic := '0';
    signal data_in    : std_logic_vector(7 downto 0) := (others => '0');
    signal enqueue    : std_logic := '0';
    signal dequeue    : std_logic := '0';
    signal data_out   : std_logic_vector(7 downto 0);
    signal len_out    : std_logic_vector(3 downto 0);

    constant clk_period : time := 10 ns;

BEGIN
 
    DUT: entity work.CFila
        port map (
            m_clk       => clk,
            m_reset     => rst,
            m_dataIn    => data_in,
            m_enqueueIn => enqueue,
            m_dequeue   => dequeue,
            m_dataOut   => data_out,
            m_lenOut    => len_out
        );

    
    clk_process : process
    begin
        while TRUE loop
            clk <= '1';
            wait for clk_period / 2;
            clk <= '0';
            wait for clk_period / 2;
        end loop;
    end process;

    teste : process
    begin
        
        rst <= '1';
        wait for 2 * clk_period;
        rst <= '0';
        wait for clk_period;

        ------------------------------------------------------------------
        -- Enqueue
        for i in 0 to 9 loop
            data_in <= std_logic_vector(to_unsigned(i + 1, 8));
            enqueue <= '1';
            wait for clk_period;
            enqueue <= '0';
            wait for clk_period;
        end loop;

        ------------------------------------------------------------------
        -- Dequeue
        for i in 0 to 9 loop
            dequeue <= '1';
            wait for clk_period;
            dequeue <= '0';
            wait for clk_period;
        end loop;
        wait;
      end process;
end architecture;

