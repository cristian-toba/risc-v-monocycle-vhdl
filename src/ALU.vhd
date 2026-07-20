library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
    port (
        A  : in  std_logic_vector(31 downto 0); 
        B  : in  std_logic_vector(31 downto 0);
        ALUctr : in  std_logic_vector(2 downto 0); 
        ALUResult : out std_logic_vector(31 downto 0);
        Zero : out std_logic    
    );
end entity;

architecture behavioral of ALU is
    signal operacion : std_logic_vector(31 downto 0);
begin

    process(A, B, ALUctr)
    begin
        case ALUctr is
            when "010" => -- AND
                operacion <= A and B;
            when "011" => -- OR
                operacion <= A or B;
            when "000" => -- ADD 
                operacion <= std_logic_vector(signed(A) + signed(B));
            when "001" => -- SUB
                operacion <= std_logic_vector(signed(A) - signed(B));
            when "101" => -- Comparacion 
                if (signed(A) < signed(B)) then
                    operacion <= x"00000001";
                else
                    operacion <= x"00000000";
                end if;
            when others =>
                operacion <= (others => '0');
        end case;
    end process;

    ALUResult <= operacion;

    Zero <= '1' when (operacion = x"00000000") else '0';

end architecture;