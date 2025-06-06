-------------------------------------------------------------
-- File: deserializer.vhd
-- Authors: Eduardo A and Fernando A
-------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CDeserializer is
  port (
    m_dataIn     : in  std_logic;
    m_writeIn    : in  std_logic;
    m_statusOut  : out std_logic := '0';
    m_reset      : in  std_logic;
    m_dataOut    : out std_logic_vector(7 downto 0) := (others => '0');
    m_dataReady  : out std_logic := '0';
    m_ackIn      : in  std_logic := '0';
    m_clock100   : in  std_logic
  );
end entity;

architecture CDeserializer of CDeserializer is
  type DeserializerSTATE is (RECEIVING, DONE, WAITING, RESET);
  signal state       : DeserializerSTATE := RECEIVING;
  signal count       : integer range 0 to 8 := 0;
  signal accumulator : std_logic_vector(7 downto 0) := (others => '0');
begin
  process(m_clock100)
  begin
    if rising_edge(m_clock100) then
      if m_reset = '1' then
        state        <= RESET;
      else
        case state is

          when RECEIVING =>
            m_statusOut <= '0';
            if m_writeIn = '1' then
              accumulator <= accumulator(6 downto 0) & m_dataIn;
              count <= count + 1;
              if count = 7 then
                state <= DONE;
              end if;
            end if;

          when DONE =>
            m_dataOut   <= accumulator;
            m_dataReady <= '1';
            m_statusOut <= '1';
            state       <= WAITING;

          when WAITING =>
            if m_ackIn = '1' then
              m_dataOut    <= (others => '0');
              m_dataReady  <= '0';
              m_statusOut  <= '0';
              count        <= 0;
              state        <= RECEIVING;
            else
              m_statusOut <= '1';
            end if;

          when RESET =>
            m_dataOut    <= (others => '0');
            m_dataReady  <= '0';
            m_statusOut  <= '0';
            accumulator  <= (others => '0');
            count        <= 0;
            state        <= RECEIVING;

        end case;
      end if;
    end if;
  end process;
end architecture;
