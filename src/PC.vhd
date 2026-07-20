library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity pc is
	port (
	 clk : in std_logic;
	 reset : in std_logic;
	 pc_in: in std_logic_vector(32 downto 0); -- Del sumador
	 pc_out: out std_logic_vector(32 downto 0) -- A la Memoria ROM
	);
end entity;

architecture behavioral  of pc is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            pc_out <= (others => '0');
        elsif rising_edge(clk) then
            pc_out <= pc_in;
        end if;
    end process;
end behavioral ;