library ieee;
use ieee.std_logic_1164.all;

entity Control_unit is
    port (
        op          : in  std_logic_vector(6 downto 0);  -- Instruccion(6 downto 0)
        funct3      : in  std_logic_vector(2 downto 0);  -- Instruccion(14 downto 12)
        funct7_5    : in  std_logic;                     -- Instruccion(30)
        Zero        : in  std_logic;                     -- Bandera Zero de la ALU
        -- Señales de salida oficiales hacia el Datapath
        RegWrite    : out std_logic;
        ImmSrc      : out std_logic_vector(1 downto 0);
        ALUSrc      : out std_logic;
        MemWrite    : out std_logic;
        ResultSrc   : out std_logic_vector(1 downto 0);
        ALUControl  : out std_logic_vector(2 downto 0);  -- Va al ALUctr de tu ALU
        PCSrc       : out std_logic
    );
end entity;

architecture rtl of Control_unit is
    -- Señales internas para conectar los decodificadores internos
    signal ALUOp  : std_logic_vector(1 downto 0);
    signal Branch : std_logic;
    signal Jump   : std_logic;
begin
    process(op)
    begin
        -- Valores por defecto seguros para evitar Latches
        RegWrite  <= '0';
        ImmSrc    <= "00";
        ALUSrc    <= '0';
        MemWrite  <= '0';
        ResultSrc <= "00";
        ALUOp     <= "00";
        Branch    <= '0';
        Jump      <= '0';

        case op is
            when "0000011" => -- lw (Tipo I)
                RegWrite  <= '1';
                ImmSrc    <= "00";
                ALUSrc    <= '1';
                MemWrite  <= '0';
                ResultSrc <= "01"; -- Lee de la RAM
                ALUOp     <= "00"; -- Suma para dirección

            when "0100011" => -- sw (Tipo S)
                RegWrite  <= '0';
                ImmSrc    <= "01";
                ALUSrc    <= '1';
                MemWrite  <= '1';  -- Habilita escritura en RAM
                ALUOp     <= "00"; -- Suma para dirección

            when "0110011" => -- Operaciones Tipo R (add, sub, slt, or, and)
                RegWrite  <= '1';
                ALUSrc    <= '0';  -- Usa el registro RD2
                MemWrite  <= '0';
                ResultSrc <= "00"; -- Resultado directo de la ALU
                ALUOp     <= "10"; -- Operación depende de funct3 y funct7

            when "0010011" => -- Operaciones Tipo I Inmediatos (addi, slti, ori, andi)
                RegWrite  <= '1';
                ImmSrc    <= "00";
                ALUSrc    <= '1';  -- Usa el inmediato extendido
                MemWrite  <= '0';
                ResultSrc <= "00"; -- Resultado directo de la ALU
                ALUOp     <= "11"; -- Tipo I extendido

            when "1100011" => -- beq (Tipo B)
                RegWrite  <= '0';
                ImmSrc    <= "10";
                ALUSrc    <= '0';
                MemWrite  <= '0';
                Branch    <= '1';  -- Habilita lógica de salto condicional
                ALUOp     <= "01"; -- Resta en la ALU para comparar

            when "1101111" => -- jal (Tipo J)
                RegWrite  <= '1';
                ImmSrc    <= "11";
                MemWrite  <= '0';
                ResultSrc <= "10"; -- Guarda PC+4 en el registro rd
                Jump      <= '1';  -- Salto incondicional activo

            when others =>
                -- Cualquier instrucción no soportada deja todo apagado
                null;
        end case;
    end process;


    -----------------------------------------------------------------
    -- 2. DECODIFICADOR DE LA ALU (Basado en la tabla ALUOp / functs)
    -----------------------------------------------------------------
    process(ALUOp, funct3, funct7_5)
    begin
        case ALUOp is
            when "00" => 
                ALUControl <= "000"; -- ADD obligatorio (para lw y sw)
                
            when "01" => 
                ALUControl <= "001"; -- SUB obligatorio (para beq)
                
            when "10" => -- Tipo R
                case funct3 is
                    when "000" => 
                        if funct7_5 = '1' then
                            ALUControl <= "001"; -- sub
                        else
                            ALUControl <= "000"; -- add
                        end if;
                    when "010" => ALUControl <= "101"; -- slt
                    when "110" => ALUControl <= "011"; -- or
                    when "111" => ALUControl <= "010"; -- and
                    when others => ALUControl <= "000";
                end case;

            when "11" => -- Tipo I (Inmediatos)
                case funct3 is
                    when "000" => ALUControl <= "000"; -- addi
                    when "010" => ALUControl <= "101"; -- slti
                    when "110" => ALUControl <= "011"; -- ori
                    when "111" => ALUControl <= "010"; -- andi
                    when others => ALUControl <= "000";
                end case;
                
            when others => 
                ALUControl <= "000";
        end case;
    end process;

    PCSrc <= Jump or (Branch and Zero);

end architecture;