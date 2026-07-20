library ieee;
use ieee.std_logic_1164.all;

entity Mux_PC is
    port (
        PCPlus4   : in  std_logic_vector(31 downto 0); -- Entrada 0 (Secuencial)
        PCTarget  : in  std_logic_vector(31 downto 0); -- Entrada 1 (Salto tomado)
        PCSrc     : in  std_logic;                     -- Selector de 1 bit oficial
        PC_Next   : out std_logic_vector(31 downto 0)  -- Va directo a pc_in
    );
end entity;

architecture rtl of Mux_PC is
begin
    with PCSrc select
        PC_Next <= PCPlus4  when '0',
                   PCTarget when '1',
                   (others => '0') when others;
end architecture;