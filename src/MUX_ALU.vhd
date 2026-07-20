library ieee;
use ieee.std_logic_1164.all;

entity MUX_ALU is
    port (
        RD2       : in  std_logic_vector(31 downto 0); -- Viene del Banco de Registros
        ImmExt    : in  std_logic_vector(31 downto 0); -- Viene del Extensor de Signo
        ALUSrc    : in  std_logic;                     -- Señal de Control oficial
        SrcB      : out std_logic_vector(31 downto 0)  -- Va directo a la entrada B de la ALU
    );
end entity;

architecture rtl of  MUX_ALU is
begin
    with ALUSrc select
        SrcB <= RD2    when '0',
                ImmExt when '1',
                (others => '0') when others;
end architecture;