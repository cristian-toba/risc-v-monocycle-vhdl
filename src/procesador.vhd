library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity Procesador is
    port (
        clk: in  std_logic;
        reset: in  std_logic;
		  leds: out std_logic_vector(7 downto 0); -- Salida LEDs (Reg 31)
		  
			-- conexiones a la FPGA
        switches: in  std_logic_vector(1 downto 0); -- Entrada a los DIP Switches (Reg 26)
        display27: out std_logic_vector(6 downto 0); -- Salida al Display 1 (Reg 27)
        display28: out std_logic_vector(6 downto 0); -- Salida al Display 2 (Reg 28)
        display29: out std_logic_vector(6 downto 0); -- Salida al Display 3 (Reg 29)
        display30: out std_logic_vector(6 downto 0) -- Salida al Display 4 (Reg 30)
	);
end Procesador;

architecture Behavioral of Procesador is

    signal sig_PC_Next, sig_PC_out: std_logic_vector(31 downto 0);
    signal sig_Instruccion: std_logic_vector(31 downto 0);
    signal sig_ExtImm: std_logic_vector(31 downto 0);
    signal sig_RD1, sig_RD2: std_logic_vector(31 downto 0);
    signal sig_WD: std_logic_vector(31 downto 0);
    signal sig_SrcB: std_logic_vector(31 downto 0);
    signal sig_ALUResult: std_logic_vector(31 downto 0);
    signal sig_Zero: std_logic;
    signal sig_ReadData: std_logic_vector(31 downto 0);
    signal sig_PCPlus4: std_logic_vector(31 downto 0);
    signal sig_PCTarget: std_logic_vector(31 downto 0);
    signal sig_RegWrite: std_logic;
    signal sig_ImmSrc: std_logic_vector(1 downto 0);
    signal sig_ALUSrc: std_logic;
    signal sig_ALUControl: std_logic_vector(2 downto 0);
    signal sig_MemWrite: std_logic;
    signal sig_ResultSrc: std_logic_vector(1 downto 0);
    signal sig_PCSrc: std_logic;
	 
	 -- Señales de interconexión de periféricos desde el Banco de Registros
    signal sig_Display27_out: std_logic_vector(6 downto 0);
    signal sig_Display28_out: std_logic_vector(6 downto 0);
    signal sig_Display29_out: std_logic_vector(6 downto 0);
    signal sig_Display30_out: std_logic_vector(6 downto 0);
    signal sig_X31_out: std_logic_vector(7 downto 0); -- Reducido a 8 bits
	 
 
begin

    U_Mux_PC: entity work.Mux_PC
        port map (
            PCPlus4  => sig_PCPlus4,
            PCTarget => sig_PCTarget,
            PCSrc    => sig_PCSrc,
            PC_Next  => sig_PC_Next
        );
		  
    U_PC: entity work.PC
        port map (
            clk=> clk,
            reset=> reset,
            pc_in=> sig_PC_Next,
            pc_out=> sig_PC_out
        );
		  
    U_Sumador_PC4: entity work.Sumador
        port map (
            pc_in=> sig_PC_out,
            pc_out => sig_PCPlus4
        );
		  
    U_ROM: entity work.rom
        port map (
            direccion_rom => sig_PC_out,
            salida_rom=> sig_Instruccion
        );

		  
    U_Control: entity work.Control_unit
        port map (
            op=> sig_Instruccion(6 downto 0),
            funct3=> sig_Instruccion(14 downto 12),
            funct7_5=> sig_Instruccion(30),
            Zero=> sig_Zero,
            RegWrite=> sig_RegWrite,
            ImmSrc=> sig_ImmSrc,
            ALUSrc=> sig_ALUSrc,
            MemWrite=> sig_MemWrite,
            ResultSrc=> sig_ResultSrc,
            ALUControl  => sig_ALUControl,
            PCSrc=> sig_PCSrc
        );

		  
    U_BancoReg: entity work.BancoReg
        port map (
            clk=> clk,
            reset=> reset,
            WE=> sig_RegWrite,
            ra1=> sig_Instruccion(19 downto 15),
            ra2=> sig_Instruccion(24 downto 20),
            wa=> sig_Instruccion(11 downto 7),
            wd=> sig_WD,
            rd1=> sig_RD1,
            rd2=> sig_RD2,
				
				-- Puentes hacia el exterior
            DIP_switches => switches,
            Display_27=> sig_Display27_out,
            Display_28=> sig_Display28_out,
            Display_29=> sig_Display29_out,
            Display_30=> sig_Display30_out,
            LEDS_31=> sig_X31_out
        );
		  
    U_Extensor: entity work.Extensor_Signo
        port map (
            iX => sig_Instruccion(31 downto 0),
            iop=> sig_ImmSrc,
            oZ => sig_ExtImm
        );

    U_Mux_ALU: entity work.MUX_ALU
        port map (
            RD2=> sig_RD2,
            immExt=> sig_ExtImm,
            ALUSrc=> sig_ALUSrc,
            SrcB=> sig_SrcB
        );

     U_ALU: entity work.ALU
        port map (
            A=> sig_RD1,
            B=> sig_SrcB,
            ALUctr=> sig_ALUControl,
            ALUResult=> sig_ALUResult,
            Zero=> sig_Zero
        );

		  
    U_Sumador_Target: entity work.SUM
        port map (
            PC=> sig_PC_out,
            immExt=> sig_ExtImm,
            PCTarget=> sig_PCTarget
        );

    U_RAM: entity work.RAM
        port map (
            clk=> clk,
            MemWr=> sig_MemWrite,
            A=> sig_ALUResult,
            WD=> sig_RD2,
            RD=> sig_ReadData
        );

    U_Mux_Res: entity work.MUX_ResSCR
        port map (
            ALUResult => sig_ALUResult,
            ReadData=> sig_ReadData,
            PCPlus4=> sig_PCPlus4,
            ResSrc=> sig_ResultSrc,
            Result=> sig_WD
        );
	-- Asignaciones finales a los pines de salida 
    display27 <= sig_Display27_out;
    display28 <= sig_Display28_out;
    display29 <= sig_Display29_out;
    display30 <= sig_Display30_out;
    leds      <= sig_X31_out;
end Behavioral;