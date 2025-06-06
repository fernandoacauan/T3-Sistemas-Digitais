-------------------------------------------------------------
-- File: tb.vhd
-- Authors: Eduardo A and Fernando A
-------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb is
end entity;

architecture tb of tb is
    signal reset         : std_logic := '0';
    signal clk           : std_logic := '0';
    signal clk2          : std_logic := '0';
    signal dataIn_dsl    : std_logic := '0';
    signal dataIn_q      : std_logic_vector(7 downto 0) := (others => '0');
    signal writeIn_dsl   : std_logic := '0';
    signal writeIn_q     : std_logic := '0';
    signal statusOut     : std_logic;
    signal dataOut_dsl   : std_logic_vector(7 downto 0);
    signal dataReady     : std_logic;
    signal ackIn         : std_logic := '0';
    signal dataOut_q     : std_logic_vector(7 downto 0);
    signal len           : std_logic_vector(3 downto 0);
    signal enqueueIn     : std_logic := '0';
    signal dequeue       : std_logic := '0';

begin
    DUT: entity work.CTop
        port map (
            m_dataIn_dsl  => dataIn_dsl,
            m_dataIn_q    => dataIn_q,
            m_writeIn_dsl => writeIn_dsl,
            m_writeIn_q   => writeIn_q,
            m_statusOut   => statusOut,
            m_reset       => reset,
            m_dataOut_dsl => dataOut_dsl,
            m_dataReady   => dataReady,
            m_ackIn       => ackIn,
            m_clock       => clk,
            m_clock2      => clk2,
            m_dataOut_q   => dataOut_q,
            m_len         => len,
            m_enqueueIn   => enqueueIn,
            m_dequeue     => dequeue
        );

    -- Clock de 100kHz
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 5000 ns;
            clk <= '1';
            wait for 5000 ns;
        end loop;
    end process;

    -- Clock de 10kHz
    clk2_process : process
    begin
        while true loop
            clk2 <= '0';
            wait for 50000 ns;
            clk2 <= '1';
            wait for 50000 ns;
        end loop;
    end process;

 
    teste : process
    begin
        reset <= '1';
        wait for 20000 ns;
        reset <= '0';
        wait for 20000 ns;

        -- entrada do deserializador
        for i in 0 to 7 loop
            if (i mod 2) = 0 then
                dataIn_dsl <= '1';
            else
                dataIn_dsl <= '0';
            end if;
            writeIn_dsl <= '1';
            wait for 10000 ns; 
            writeIn_dsl <= '0';
            wait for 10000 ns;
        end loop;

        
        wait for 50000 ns;
        ackIn <= '1';
        wait for 20000 ns;
        ackIn <= '0';

        
        wait until rising_edge(clk2);
        wait until rising_edge(clk2);
	
        -- entrada fila
	FOR i IN 0 TO 7 LOOP
            dataIn_q <= std_logic_vector(to_unsigned(i + 1, 8));
            wait until rising_edge(clk2);
	    enqueueIn <= '1';
            wait until rising_edge(clk2);
            enqueueIn <= '0';
        END LOOP;

       
        wait until rising_edge(clk2);
        wait until rising_edge(clk2);

        -- dequeue da fila
        FOR i IN 0 TO 7 LOOP
            wait until rising_edge(clk2);
            dequeue <= '1';
            wait until rising_edge(clk2);
            dequeue <= '0';
        END LOOP;

      
        wait until rising_edge(clk2);
        wait until rising_edge(clk2);

        wait;
    end process;

end architecture;
