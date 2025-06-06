-------------------------------------------------------------
-- File: tbDeserializer.vhd
-- Authors: Eduardo A and Fernando A
-------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_deserializer is
end entity;

architecture tb of tb_deserializer is

    signal clk        : std_logic := '0';
    signal rst        : std_logic := '1';
    signal data_in    : std_logic := '0';
    signal write_in   : std_logic := '0';
    signal ack_in     : std_logic := '0';
    signal data_out   : std_logic_vector(7 downto 0);
    signal data_ready : std_logic;
    signal status_out : std_logic;

begin
    DUT: entity work.CDeserializer
        port map (
            m_clock100   => clk,
            m_reset      => rst,
            m_dataIn     => data_in,
            m_writeIn    => write_in,
            m_ackIn      => ack_in,
            m_dataOut    => data_out,
            m_dataReady  => data_ready,
            m_statusOut  => status_out
        );

    -- Gera clock de 100kHz
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        end loop;
    end process;

    -- teste do caso ruim (travamento)
    teste: process
    begin
        rst <= '1';
        wait for 40 ns;
        rst <= '0';
        wait for 40 ns;

        data_in <= '1'; write_in <= '1'; wait for 20 ns;
        data_in <= '0'; write_in <= '1'; wait for 20 ns;
        data_in <= '1'; write_in <= '1'; wait for 20 ns;
        data_in <= '0'; write_in <= '1'; wait for 20 ns;
        data_in <= '0'; write_in <= '1'; wait for 20 ns;
        data_in <= '1'; write_in <= '1'; wait for 20 ns;
        data_in <= '0'; write_in <= '1'; wait for 20 ns;
        data_in <= '1'; write_in <= '1'; wait for 20 ns;

        write_in <= '0';
        wait for 40 ns;

        data_in <= '1';
        write_in <= '1';
        wait for 20 ns;
        write_in <= '0';
        wait for 100 ns;

        ack_in <= '1';
        wait for 20 ns;
        ack_in <= '0';
        wait for 80 ns;

        wait;
    end process;
end architecture;

