-------------------------------------------------------------
-- File: top.vhd
-- Authors: Eduardo A and Fernando A
-------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY CTop IS
PORT (
   m_dataIn_dsl  : IN  STD_LOGIC;
   m_dataIn_q    : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
   m_writeIn_dsl : IN  STD_LOGIC;
   m_writeIn_q   : IN  STD_LOGIC;
   m_statusOut   : OUT STD_LOGIC;
   m_reset       : IN  STD_LOGIC;
   m_dataOut_dsl : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
   m_dataReady   : OUT STD_LOGIC;
   m_ackIn       : IN  STD_LOGIC;
   m_clock       : IN  STD_LOGIC;
   m_clock2      : IN  STD_LOGIC; 
   m_dataOut_q   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
   m_len         : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
   m_enqueueIn   : IN  STD_LOGIC;
   m_dequeue     : IN  STD_LOGIC
);

END ENTITY;

ARCHITECTURE CTop OF CTop IS -- botar as entradas do queue

BEGIN
   
 
   Deserializador: ENTITY work.CDeserializer PORT MAP (
      m_reset => m_reset,
      m_dataIn => m_dataIn_dsl,
      m_writeIn => m_writeIn_dsl,
      m_clock100 => m_clock,
      m_ackIn => m_ackIn,
      m_statusOut => m_statusOut,
      m_dataOut => m_dataOut_dsl,
      m_dataReady => m_dataReady
   );

 
   Fila: ENTITY work.CFila PORT MAP (
      m_clk       => m_clock2,
      m_reset     => m_reset,
      m_dataIn    => m_dataIn_q,
      m_enqueueIn => m_enqueueIn,
      m_dequeue   => m_dequeue,
      m_lenOut    => m_len,
      m_dataOut   => m_dataOut_q
   );
   
END ARCHITECTURE;
