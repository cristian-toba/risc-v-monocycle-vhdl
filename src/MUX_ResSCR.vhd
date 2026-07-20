library ieee;
use ieee.std_logic_1164.all;

entity MUX_ResSCR is
    port (
        ALUResult : in  std_logic_vector(31 downto 0); -- Entrada 0
        ReadData  : in  std_logic_vector(31 downto 0); -- Entrada 1
        PCPlus4   : in  std_logic_vector(31 downto 0); -- Entrada 2 (para JAL)
        ResSrc : in  std_logic_vector(1 downto 0);  -- Selector de 2 bits oficial
        Result    : out std_logic_vector(31 downto 0)  -- Va a la entrada WD del Banco de Registros
    );
end entity;

architecture rtl of MUX_ResSCR is
begin
    with ResSrc select
        Result <= ALUResult when "00",
                  ReadData  when "01",
                  PCPlus4   when "10",
                  (others => '0') when others;
end architecture;