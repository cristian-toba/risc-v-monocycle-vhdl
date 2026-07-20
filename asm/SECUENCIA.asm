#  TAREA 3, LABORATORIO 5
# REGISTROS: x26 = Entrada DIP Switches, x31 = Salida 8 LEDs

INICIO:
# Leer los DIP switches (Registro 26) y limpiar bits superiores
addi x5, x26, 0   # x5 = x26 + 0
addi x7, x0, 3    # x7 = 3 
and  x5, x5, x7   # x5 = x5 AND x7

# Selector de secuencias
addi x6, x0, 0         # x6 = 0
beq  x5, x6, SEC_1     # Si x5 == 0, salta a Secuencia 1
    
addi x6, x0, 1         # x6 = 1
beq  x5, x6, SEC_2     # Si x5 == 1, salta a Secuencia 2
    
addi x6, x0, 2         # x6 = 2
beq  x5, x6, SEC_3     # Si x5 == 2, salta a Secuencia 3
    
addi x6, x0, 3         # x6 = 3
beq  x5, x6, SEC_4     # Si x5 == 3, salta a Secuencia 4


# SECUENCIA 1: PING PONG
SEC_1:

# Paso 1   
addi x31, x0, 1

addi x8, x0, 204
DELAY_1A_EXT: addi x7, x0, 2047
DELAY_1A_INT: addi x7, x7, -1
beq  x7, x0, DELAY_1A_DEC
beq  x0, x0, DELAY_1A_INT
DELAY_1A_DEC: addi x8, x8, -1
beq  x8, x0, S1_P2
beq  x0, x0, DELAY_1A_EXT

S1_P2:
# Paso 2
addi x31, x0, 2

addi x8, x0, 204
DELAY_1B_EXT: addi x7, x0, 2047
DELAY_1B_INT: addi x7, x7, -1
beq  x7, x0, DELAY_1B_DEC
beq  x0, x0, DELAY_1B_INT
DELAY_1B_DEC: addi x8, x8, -1
beq  x8, x0, S1_P3
beq  x0, x0, DELAY_1B_EXT

S1_P3:
# Paso 3
addi x31, x0, 4

addi x8, x0, 204
DELAY_1C_EXT: addi x7, x0, 2047
DELAY_1C_INT: addi x7, x7, -1
beq  x7, x0, DELAY_1C_DEC
beq  x0, x0, DELAY_1C_INT
DELAY_1C_DEC: addi x8, x8, -1
beq  x8, x0, S1_P4
beq  x0, x0, DELAY_1C_EXT

S1_P4:
# Paso 4
addi x31, x0, 8

addi x8, x0, 204
DELAY_1D_EXT: addi x7, x0, 2047
DELAY_1D_INT: addi x7, x7, -1
beq  x7, x0, DELAY_1D_DEC
beq  x0, x0, DELAY_1D_INT
DELAY_1D_DEC: addi x8, x8, -1
beq  x8, x0, S1_P5
beq  x0, x0, DELAY_1D_EXT

S1_P5:
# Paso 5
addi x31, x0, 16

addi x8, x0, 204
DELAY_1E_EXT: addi x7, x0, 2047
DELAY_1E_INT: addi x7, x7, -1
beq  x7, x0, DELAY_1E_DEC
beq  x0, x0, DELAY_1E_INT
DELAY_1E_DEC: addi x8, x8, -1
beq  x8, x0, S1_P6
beq  x0, x0, DELAY_1E_EXT

S1_P6:
# Paso 6
addi x31, x0, 32

addi x8, x0, 204
DELAY_1F_EXT: addi x7, x0, 2047
DELAY_1F_INT: addi x7, x7, -1
beq  x7, x0, DELAY_1F_DEC
beq  x0, x0, DELAY_1F_INT
DELAY_1F_DEC: addi x8, x8, -1
beq  x8, x0, S1_P7
beq  x0, x0, DELAY_1F_EXT

S1_P7:
# Paso 7
addi x31, x0, 64

addi x8, x0, 204
DELAY_1G_EXT: addi x7, x0, 2047
DELAY_1G_INT: addi x7, x7, -1
beq  x7, x0, DELAY_1G_DEC
beq  x0, x0, DELAY_1G_INT
DELAY_1G_DEC: addi x8, x8, -1
beq  x8, x0, S1_P8
beq  x0, x0, DELAY_1G_EXT

S1_P8:
# Paso 8
addi x31, x0, 128

addi x8, x0, 204
DELAY_1H_EXT: addi x7, x0, 2047
DELAY_1H_INT: addi x7, x7, -1
beq  x7, x0, DELAY_1H_DEC
beq  x0, x0, DELAY_1H_INT
DELAY_1H_DEC: addi x8, x8, -1
beq  x8, x0, S1_P9
beq  x0, x0, DELAY_1H_EXT

S1_P9:
# Paso 9
addi x31, x0, 64

addi x8, x0, 204
DELAY_1I_EXT: addi x7, x0, 2047
DELAY_1I_INT: addi x7, x7, -1
beq  x7, x0, DELAY_1I_DEC
beq  x0, x0, DELAY_1I_INT
DELAY_1I_DEC: addi x8, x8, -1
beq  x8, x0, S1_P10
beq  x0, x0, DELAY_1I_EXT

S1_P10:
# Paso 10
addi x31, x0, 32

addi x8, x0, 204
DELAY_1J_EXT: addi x7, x0, 2047
DELAY_1J_INT: addi x7, x7, -1
beq  x7, x0, DELAY_1J_DEC
beq  x0, x0, DELAY_1J_INT
DELAY_1J_DEC: addi x8, x8, -1
beq  x8, x0, S1_P11
beq  x0, x0, DELAY_1J_EXT

S1_P11:
# Paso 11
addi x31, x0, 16

addi x8, x0, 204
DELAY_1K_EXT: addi x7, x0, 2047
DELAY_1K_INT: addi x7, x7, -1
beq  x7, x0, DELAY_1K_DEC
beq  x0, x0, DELAY_1K_INT
DELAY_1K_DEC: addi x8, x8, -1
beq  x8, x0, S1_P12
beq  x0, x0, DELAY_1K_EXT

S1_P12:
# Paso 12
addi x31, x0, 8

addi x8, x0, 204
DELAY_1L_EXT: addi x7, x0, 2047
DELAY_1L_INT: addi x7, x7, -1
beq  x7, x0, DELAY_1L_DEC
beq  x0, x0, DELAY_1L_INT
DELAY_1L_DEC: addi x8, x8, -1
beq  x8, x0, S1_P13
beq  x0, x0, DELAY_1L_EXT

S1_P13:
# Paso 13
addi x31, x0, 4

addi x8, x0, 204
DELAY_1M_EXT: addi x7, x0, 2047
DELAY_1M_INT: addi x7, x7, -1
beq  x7, x0, DELAY_1M_DEC
beq  x0, x0, DELAY_1M_INT
DELAY_1M_DEC: addi x8, x8, -1
beq  x8, x0, S1_P14
beq  x0, x0, DELAY_1M_EXT

S1_P14:
# Paso 14
addi x31, x0, 2

addi x8, x0, 204
DELAY_1N_EXT: addi x7, x0, 2047
DELAY_1N_INT: addi x7, x7, -1
beq  x7, x0, DELAY_1N_DEC
beq  x0, x0, DELAY_1N_INT
DELAY_1N_DEC: addi x8, x8, -1
beq  x8, x0, FIN_SEC1
beq  x0, x0, DELAY_1N_EXT

FIN_SEC1:
beq x0, x0, INICIO

# CENTRO AL EXTERIOR
SEC_2:

# Paso 1
addi x31, x0, 24

addi x8, x0, 204
DELAY_2A_EXT:
addi x7, x0, 2047
DELAY_2A_INT:
addi x7, x7, -1
beq x7, x0, DELAY_2A_DEC
beq x0, x0, DELAY_2A_INT
DELAY_2A_DEC:
addi x8, x8, -1
beq x8, x0, S2_P2
beq x0, x0, DELAY_2A_EXT

S2_P2:

# Paso 2
addi x31, x0, 60

addi x8, x0, 204
DELAY_2B_EXT:
addi x7, x0, 2047
DELAY_2B_INT:
addi x7, x7, -1
beq x7, x0, DELAY_2B_DEC
beq x0, x0, DELAY_2B_INT
DELAY_2B_DEC:
addi x8, x8, -1
beq x8, x0, S2_P3
beq x0, x0, DELAY_2B_EXT

S2_P3:

# Paso 3
addi x31, x0, 126

addi x8, x0, 204
DELAY_2C_EXT:
addi x7, x0, 2047
DELAY_2C_INT:
addi x7, x7, -1
beq x7, x0, DELAY_2C_DEC
beq x0, x0, DELAY_2C_INT
DELAY_2C_DEC:
addi x8, x8, -1
beq x8, x0, S2_P4
beq x0, x0, DELAY_2C_EXT

S2_P4:

# Paso 4
addi x31, x0, 255

addi x8, x0, 204
DELAY_2D_EXT:
addi x7, x0, 2047
DELAY_2D_INT:
addi x7, x7, -1
beq x7, x0, DELAY_2D_DEC
beq x0, x0, DELAY_2D_INT
DELAY_2D_DEC:
addi x8, x8, -1
beq x8, x0, S2_P5
beq x0, x0, DELAY_2D_EXT

S2_P5:

# Paso 5
addi x31, x0, 126

addi x8, x0, 204
DELAY_2E_EXT:
addi x7, x0, 2047
DELAY_2E_INT:
addi x7, x7, -1
beq x7, x0, DELAY_2E_DEC
beq x0, x0, DELAY_2E_INT
DELAY_2E_DEC:
addi x8, x8, -1
beq x8, x0, S2_P6
beq x0, x0, DELAY_2E_EXT

S2_P6:

# Paso 6
addi x31, x0, 60

addi x8, x0, 204
DELAY_2F_EXT:
addi x7, x0, 2047
DELAY_2F_INT:
addi x7, x7, -1
beq x7, x0, DELAY_2F_DEC
beq x0, x0, DELAY_2F_INT
DELAY_2F_DEC:
addi x8, x8, -1
beq x8, x0, S2_P7
beq x0, x0, DELAY_2F_EXT

S2_P7:

# Paso 7
addi x31, x0, 24

addi x8, x0, 204
DELAY_2G_EXT:
addi x7, x0, 2047
DELAY_2G_INT:
addi x7, x7, -1
beq x7, x0, DELAY_2G_DEC
beq x0, x0, DELAY_2G_INT
DELAY_2G_DEC:
addi x8, x8, -1
beq x8, x0, S2_P8
beq x0, x0, DELAY_2G_EXT

S2_P8:

# Paso 8
addi x31, x0, 0

addi x8, x0, 204
DELAY_2H_EXT:
addi x7, x0, 2047
DELAY_2H_INT:
addi x7, x7, -1
beq x7, x0, DELAY_2H_DEC
beq x0, x0, DELAY_2H_INT
DELAY_2H_DEC:
addi x8, x8, -1
beq x8, x0, FIN_SEC2
beq x0, x0, DELAY_2H_EXT

FIN_SEC2:
beq x0, x0, INICIO    

# SECUENCIA 3: CHOQUE AL CENTRO 

SEC_3:
# Paso 1: Extremos abiertos (10000001 = Decimal 129)
addi x31, x0, 129    

addi x8, x0, 204          
DELAY_3A_EXT: addi x7, x0, 2047   
DELAY_3A_INT: addi x7, x7, -1        
beq  x7, x0, DELAY_3A_DEC
beq  x0, x0, DELAY_3A_INT
DELAY_3A_DEC: addi x8, x8, -1        
beq  x8, x0, S3_P2
beq  x0, x0, DELAY_3A_EXT

S3_P2:
# Paso 2: Cerrando (01000010 = Decimal 66)
addi x31, x0, 66    
 
addi x8, x0, 204          
DELAY_3B_EXT: addi x7, x0, 2047   
DELAY_3B_INT: addi x7, x7, -1        
beq  x7, x0, DELAY_3B_DEC
beq  x0, x0, DELAY_3B_INT
DELAY_3B_DEC: addi x8, x8, -1        
beq  x8, x0, S3_P3
beq  x0, x0, DELAY_3B_EXT

S3_P3:
# Paso 3: Casi en el centro (00100100 = Decimal 36)
addi x31, x0, 36     

addi x8, x0, 204          
DELAY_3C_EXT: addi x7, x0, 2047   
DELAY_3C_INT: addi x7, x7, -1        
beq  x7, x0, DELAY_3C_DEC
beq  x0, x0, DELAY_3C_INT
DELAY_3C_DEC: addi x8, x8, -1        
beq  x8, x0, S3_P4
beq  x0, x0, DELAY_3C_EXT

S3_P4:
# Paso 4: Centro absoluto (00011000 = Decimal 24)
addi x31, x0, 24     

addi x8, x0, 204          
DELAY_3D_EXT: addi x7, x0, 2047   
DELAY_3D_INT: addi x7, x7, -1        
beq  x7, x0, DELAY_3D_DEC
beq  x0, x0, DELAY_3D_INT
DELAY_3D_DEC: addi x8, x8, -1        
beq  x8, x0, S3_P5
beq  x0, x0, DELAY_3D_EXT

S3_P5:
# Paso 5: Rebotando hacia afuera (00100100 = Decimal 36)
addi x31, x0, 36     

addi x8, x0, 204          
DELAY_3E_EXT: addi x7, x0, 2047   
DELAY_3E_INT: addi x7, x7, -1        
beq  x7, x0, DELAY_3E_DEC
beq  x0, x0, DELAY_3E_INT
DELAY_3E_DEC: addi x8, x8, -1        
beq  x8, x0, S3_P6
beq  x0, x0, DELAY_3E_EXT

S3_P6:
# Paso 6: Abriendo más (01000010 = Decimal 66)
addi x31, x0, 66     

addi x8, x0, 204          
DELAY_3F_EXT: addi x7, x0, 2047   
DELAY_3F_INT: addi x7, x7, -1        
beq  x7, x0, DELAY_3F_DEC
beq  x0, x0, DELAY_3F_INT
DELAY_3F_DEC: addi x8, x8, -1        
beq  x8, x0, FIN_SEC3
beq  x0, x0, DELAY_3F_EXT

FIN_SEC3:
beq  x0, x0, INICIO

# SECUENCIA 4: CONTADOR ASECENDENTE

SEC_4:
# Paso 1: 1 LED Encendido (00000001 = Decimal 1)
addi x31, x0, 1      
  
addi x8, x0, 204          
DELAY_4A_EXT: addi x7, x0, 2047   
DELAY_4A_INT: addi x7, x7, -1        
beq  x7, x0, DELAY_4A_DEC
beq  x0, x0, DELAY_4A_INT
DELAY_4A_DEC: addi x8, x8, -1        
beq  x8, x0, S4_P2
beq  x0, x0, DELAY_4A_EXT

S4_P2:
# Paso 2: 2 LEDs Encendidos (00000011 = Decimal 3)
addi x31, x0, 3       
 
addi x8, x0, 204          
DELAY_4B_EXT: addi x7, x0, 2047   
DELAY_4B_INT: addi x7, x7, -1        
beq  x7, x0, DELAY_4B_DEC
beq  x0, x0, DELAY_4B_INT
DELAY_4B_DEC: addi x8, x8, -1        
beq  x8, x0, S4_P3
beq  x0, x0, DELAY_4B_EXT

S4_P3:
# Paso 3: 3 LEDs Encendidos (00000111 = Decimal 7)
addi x31, x0, 7        

addi x8, x0, 204          
DELAY_4C_EXT: addi x7, x0, 2047   
DELAY_4C_INT: addi x7, x7, -1        
beq  x7, x0, DELAY_4C_DEC
beq  x0, x0, DELAY_4C_INT
DELAY_4C_DEC: addi x8, x8, -1        
beq  x8, x0, S4_P4
beq  x0, x0, DELAY_4C_EXT

S4_P4:
# Paso 4: 4 LEDs Encendidos (00001111 = Decimal 15)
addi x31, x0, 15   
    
addi x8, x0, 204          
DELAY_4D_EXT: addi x7, x0, 2047   
DELAY_4D_INT: addi x7, x7, -1        
beq  x7, x0, DELAY_4D_DEC
beq  x0, x0, DELAY_4D_INT
DELAY_4D_DEC: addi x8, x8, -1        
beq  x8, x0, S4_P5
beq  x0, x0, DELAY_4D_EXT

S4_P5:
# Paso 5: 5 LEDs Encendidos (00011111 = Decimal 31)
addi x31, x0, 31   
    
addi x8, x0, 204          
DELAY_4E_EXT: addi x7, x0, 2047   
DELAY_4E_INT: addi x7, x7, -1        
beq  x7, x0, DELAY_4E_DEC
beq  x0, x0, DELAY_4E_INT
DELAY_4E_DEC: addi x8, x8, -1        
beq  x8, x0, S4_P6
beq  x0, x0, DELAY_4E_EXT

S4_P6:
# Paso 6: 6 LEDs Encendidos (00111111 = Decimal 63)
addi x31, x0, 63   
    
addi x8, x0, 204          
DELAY_4F_EXT: addi x7, x0, 2047   
DELAY_4F_INT: addi x7, x7, -1        
beq  x7, x0, DELAY_4F_DEC
beq  x0, x0, DELAY_4F_INT
DELAY_4F_DEC: addi x8, x8, -1        
beq  x8, x0, S4_P7
beq  x0, x0, DELAY_4F_EXT

S4_P7:
# Paso 7: 7 LEDs Encendidos (01111111 = Decimal 127)
addi x31, x0, 127
      
addi x8, x0, 204          
DELAY_4G_EXT: addi x7, x0, 2047   
DELAY_4G_INT: addi x7, x7, -1        
beq  x7, x0, DELAY_4G_DEC
beq  x0, x0, DELAY_4G_INT
DELAY_4G_DEC: addi x8, x8, -1        
beq  x8, x0, S4_P8
beq  x0, x0, DELAY_4G_EXT

S4_P8:
# Paso 8: Barra Llena (11111111 = Decimal 255)
addi x31, x0, 255      

addi x8, x0, 204          
DELAY_4H_EXT: addi x7, x0, 2047   
DELAY_4H_INT: addi x7, x7, -1        
beq  x7, x0, DELAY_4H_DEC
beq  x0, x0, DELAY_4H_INT
DELAY_4H_DEC: addi x8, x8, -1        
beq  x8, x0, FIN_SEC4
beq  x0, x0, DELAY_4H_EXT

FIN_SEC4:
beq  x0, x0, INICIO