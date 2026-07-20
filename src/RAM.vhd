library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM is
    port (
        clk      : in  std_logic;
        reset    : in  std_logic;
        MemWr    : in  std_logic;                      -- Control de escritura (desde la Unidad de Control)
        A        : in  std_logic_vector(31 downto 0);  -- Dirección (proviene del resultado de la ALU)
        WD       : in  std_logic_vector(31 downto 0);  -- Dato a escribir (proviene de RD2 del Banco de Registros)
        RD       : out std_logic_vector(31 downto 0)   -- Dato leído (va hacia el multiplexor de retorno)
    );
end entity;

architecture rtl of RAM is
    -- Definimos un espacio de memoria pequeño y maniobrable para simulación (ej: 64 posiciones de 32 bits)
    type ram_type is array (0 to 63) of std_logic_vector(31 downto 0);
    signal ram_block : ram_type := (others => (others => '0'));
begin

    -- Escritura Síncrona
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                ram_block <= (others => (others => '0'));
            elsif MemWr = '1' then
                -- Convertimos la dirección de bus de 32 bits a un índice entero.
                -- Dividimos entre 4 empleando los bits (7 downto 2) para alineación por palabra (Word Aligned).
                ram_block(to_integer(unsigned(A(7 downto 2)))) <= WD;
            end if;
        end if;
    end process;

    -- Lectura Asíncrona (Combinacional)
    RD <= ram_block(to_integer(unsigned(A(7 downto 2))));

end architecture;