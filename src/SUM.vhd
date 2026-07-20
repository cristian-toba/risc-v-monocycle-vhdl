-----------------------------------------------------------
-- Universidad Pedagógica y Tecnológica de Colombia UPTC
-- Curso: Electronica Digital II
-- Componente: Sumador de Saltos (PC + ImmExt) para RISC-V
-----------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SUM is
    port (
        PC       : in  std_logic_vector(31 downto 0); -- Viene de la salida actual del bloque PC
        ImmExt   : in  std_logic_vector(31 downto 0); -- Viene de la salida del Extensor de Signo
        PCTarget : out std_logic_vector(31 downto 0)  -- Va a la entrada '1' del Mux_PCSrc
    );
end entity;

architecture dataflow of SUM is
begin

    -- Realizamos la suma tratando ambos vectores como valores sin signo 
    -- para calcular la dirección física de destino en la memoria ROM.
    PCTarget <= std_logic_vector(unsigned(PC) + unsigned(ImmExt));

end architecture;