library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BancoReg is
    Port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        WE      : in  std_logic;
        ra1     : in  std_logic_vector(4 downto 0);
        ra2     : in  std_logic_vector(4 downto 0);
        wa      : in  std_logic_vector(4 downto 0);
        wd      : in  std_logic_vector(31 downto 0);
        rd1     : out std_logic_vector(31 downto 0);
        rd2     : out std_logic_vector(31 downto 0);

		  -- Conexion con la FPGA
        DIP_switches : in  std_logic_vector(1 downto 0);  -- Va a 2 interruptores físicos
        Display_27   : out std_logic_vector(6 downto 0);  -- Al Display 1
        Display_28   : out std_logic_vector(6 downto 0);  -- Al Display 2
        Display_29   : out std_logic_vector(6 downto 0);  -- Al Display 3
        Display_30   : out std_logic_vector(6 downto 0);  -- Al Display 4
        LEDS_31      : out std_logic_vector(7 downto 0)   -- A los 8 LEDs físicos
	);
end BancoReg;

architecture rtl of BancoReg is
    type reg_array is array (0 to 31) of std_logic_vector(31 downto 0);
    signal registers : reg_array := (others => (others => '0'));
    attribute keep : boolean;
    attribute keep of registers : signal is true;
begin

    -- Escritura Sincrona
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                registers <= (others => (others => '0'));
            elsif WE = '1' then
                if wa /= "00000" then
                    registers(to_integer(unsigned(wa))) <= wd;
                end if;
            end if;
        end if;
    end process;
	 

	rd1 <= (31 downto 2 => '0') & DIP_switches when (to_integer(unsigned(ra1)) = 26) else
       registers(to_integer(unsigned(ra1)));

	rd2 <= (31 downto 2 => '0') & DIP_switches when (to_integer(unsigned(ra2)) = 26) else
       registers(to_integer(unsigned(ra2)));

    -- visualización
    LEDS_31 <= registers(31)(7 downto 0);
	 
	 Display_27 <= registers(27)(6 downto 0); 
	 Display_28 <= registers(28)(6 downto 0);
	 Display_29 <= registers(29)(6 downto 0);
	 Display_30 <= registers(30)(6 downto 0);

end architecture;