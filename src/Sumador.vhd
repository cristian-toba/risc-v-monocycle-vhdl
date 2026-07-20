library ieee;
use ieee.std_logic_1164. all;
use ieee.numeric_std.all;

entity Sumador is
    Port ( 
		pc_in  : in  STD_LOGIC_VECTOR (31 downto 0);  -- Va a la memoria
		pc_out : out STD_LOGIC_VECTOR (31 downto 0)
    );
end sumador;

architecture dataflow of Sumador is
begin
    -- Convertimos el vector a 'unsigned' para poder sumar, 
    -- y luego el resultado lo regresamos a 'std_logic_vector'
    pc_out <= std_logic_vector(unsigned(pc_in) + 4);
end dataflow;