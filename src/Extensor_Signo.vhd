-----------------------------------------------------------
-- Universidad Pedagógica y Tecnológica de Colombia UPTC
-- Curso: Electronica Digital II
-- Tema: Implementación de Procesadores RISC
-- Profesor: Ing. Wilson Javier Perez Holguin, D.Eng.
-----------------------------------------------------------
-- Extensor de signo en VHDL para el proceador RISC-V 
-- reducido estudiado en clase.
-- Autor: Ing. Wilson Javier Perez Holguin, D.Eng.
-- Fecha: 04/10/2025
-----------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity Extensor_Signo is
	port(
		iX  :  in std_logic_vector(31 downto 0);
		iOp :  in std_logic_vector( 1 downto 0);
		oZ  : out std_logic_vector(31 downto 0)
	);
end entity;

architecture RTL of Extensor_Signo is
	signal z31_z20 : std_logic_vector(11 downto 0);
	signal z31_z12 : std_logic_vector(19 downto 0);	
	signal z31_z11 : std_logic_vector(20 downto 0);
	signal z19_z12 : std_logic_vector(7 downto 0);
	signal z11d    : std_logic;
	signal z11t    : std_logic;
	signal z10_z5  : std_logic_vector(5 downto 0);
	signal z10_z1  : std_logic_vector(9 downto 0);
	signal z10_z0  : std_logic_vector(10 downto 0);
	signal z4_z1   : std_logic_vector(3 downto 0);
	signal z4_z0   : std_logic_vector(4 downto 0);	
begin	
	z31_z11 <= (others => iX(31));
	z31_z12 <= (others => iX(31));
	z31_z20 <= (others => iX(31));
	z19_z12 <= iX(19 downto 12);
	z11d 	  <= iX(7);
	z11t 	  <= iX(20);
	z10_z5  <= iX(30 downto 25);
	z10_z1  <= iX(30 downto 21);
	z10_z0  <= iX(30 downto 20);
	z4_z1   <= iX(11 downto 8);
	z4_z0   <= iX(11 downto 7);

	with iOp select
		     oZ <= (z31_z11 & z10_z0) 				when "00",
			   (z31_z11 & z10_z5 & z4_z0) 			when "01",
			   (z31_z12 & z11d & z10_z5 & z4_z1 & '0')	when "10",
			   (z31_z20 & z19_z12 & z11t & z10_z1 & '0')    when "11",
			   (others => '0') when others;
end architecture;

--	 Operación	Tipo	ImmSrc
--		lw		 	 |	 	  00
--		sw		 	 S	  	  01
--				 	 |	  	  00
--				 	 R	  	  --
--		beq	 	 B	  	  10
--		j 		 	 J	  	  11