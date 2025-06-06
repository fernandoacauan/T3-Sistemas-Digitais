-------------------------------------------------------------
-- File: queue.vhd
-- Authors: Eduardo A and Fernando A
-------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CFila is
    port (
        m_clk       : in  std_logic;  
        m_reset     : in  std_logic;
        m_dataIn    : in  std_logic_vector(7 downto 0);
        m_enqueueIn : in  std_logic;
        m_dequeue   : in  std_logic;
        m_dataOut   : out std_logic_vector(7 downto 0); -- := (others => '0');
        m_lenOut    : out std_logic_vector(3 downto 0);
        m_dataReady : out std_logic 
    );
end entity;

architecture fila of CFila is
    type mem is array (0 to 7) of std_logic_vector(7 downto 0);
    signal buff     : mem := (others => (others => '0'));
    signal inicio   : integer := 0;
    signal fim      : integer := 0;
    signal size     : integer := 0;
begin
    m_lenOut  <= std_logic_vector(to_unsigned(size, 4));

    process(m_clk)
    begin
        if rising_edge(m_clk) then
            if (m_reset = '1') then
                       inicio     <= 0;
                       fim        <= 0;
                       size       <= 0;
                       m_dataOut   <= (others => '0');
                       m_dataReady <= '0';
	    end if;
            if (m_enqueueIn = '1') then
                      if(size < 8) then
                          buff(fim) <= m_dataIn;

                          if fim = 7 then
                            fim <= 0;
                          else
                            fim <= fim + 1;
                          end if;

                          size <= size + 1;
                      end if;
	     end if;
             if (m_dequeue = '1') then
                      if(size > 0) then
                          m_dataOut <= buff(inicio);
                          m_dataReady <= '1';

                          if inicio = 7 then
                              inicio <= 0;
                          else
                              inicio <= inicio + 1;
                          end if;

                          size <= size - 1;
                      end if;
            end if;
        end if;
    end process;
end architecture;

