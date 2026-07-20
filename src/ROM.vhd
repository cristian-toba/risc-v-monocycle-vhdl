library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
    port (
        direccion_rom : in std_logic_vector(31 downto 0); -- 32 posiciones
        salida_rom    : out std_logic_vector(31 downto 0)  -- 3 bits para notas 0-7
    );
end entity;

architecture rtl of rom is
	type RomType is array (0 to 63) of std_logic_vector(31 downto 0);
   constant Data : RomType := (     
        0 => x"00000033", -- Ejemplo: add x0, x0, x0
        1 => x"00100093", -- Ejemplo: li x1, 1
        2 => x"00200113", -- Ejemplo: li x2, 2
        3 => x"001101B3", -- Ejemplo: add x3, x2, x1
        others => x"00000000"
   );
begin
	salida_rom <= Data(to_integer(unsigned(direccion_rom(7 downto 2))));
end architecture;