.text
.globl main

main:
    addi x1, x0, 0         

LOOP:
    addi x30, x0, 127
    addi x29, x0, 127
    addi x28, x0, 127

    add x31, x0, x1

    addi x12, x0, 0
    beq  x1, x12, DIG0

    addi x12, x0, 1
    beq  x1, x12, DIG1      

    addi x12, x0, 2
    beq  x1, x12, DIG2

    addi x12, x0, 3
    beq  x1, x12, DIG3

    addi x12, x0, 4
    beq  x1, x12, DIG4

    addi x12, x0, 5
    beq  x1, x12, DIG5

    addi x12, x0, 6
    beq  x1, x12, DIG6

    addi x12, x0, 7
    beq  x1, x12, DIG7

    addi x12, x0, 8
    beq  x1, x12, DIG8

    addi x12, x0, 9
    beq  x1, x12, DIG9

    addi x12, x0, 10
    beq  x1, x12, DIGA

    addi x12, x0, 11
    beq  x1, x12, DIGB

    addi x12, x0, 12
    beq  x1, x12, DIGC

    addi x12, x0, 13
    beq  x1, x12, DIGD

    addi x12, x0, 14
    beq  x1, x12, DIGE

    addi x12, x0, 15
    beq  x1, x12, DIGF

    beq  x0, x0, RESET


# ============================================================
# CÓDIGOS 7 SEGMENTOS
# Activo en bajo
# ============================================================

DIG0:
    addi x27, x0, 64        # 0
    beq  x0, x0, DELAY

DIG1:
    addi x27, x0, 161       # 1
    beq  x0, x0, DELAY

DIG2:
    addi x27, x0, 36        # 2
    beq  x0, x0, DELAY

DIG3:
    addi x27, x0, 48        # 3
    beq  x0, x0, DELAY

DIG4:
    addi x27, x0, 25        # 4
    beq  x0, x0, DELAY

DIG5:
    addi x27, x0, 18        # 5
    beq  x0, x0, DELAY

DIG6:
    addi x27, x0, 2         # 6
    beq  x0, x0, DELAY

DIG7:
    addi x27, x0, 120       # 7
    beq  x0, x0, DELAY

DIG8:
    addi x27, x0, 0         # 8
    beq  x0, x0, DELAY

DIG9:
    addi x27, x0, 16        # 9
    beq  x0, x0, DELAY

DIGA:
    addi x27, x0, 8         # A
    beq  x0, x0, DELAY

DIGB:
    addi x27, x0, 3         # b
    beq  x0, x0, DELAY

DIGC:
    addi x27, x0, 70        # C
    beq  x0, x0, DELAY

DIGD:
    addi x27, x0, 33        # d
    beq  x0, x0, DELAY

DIGE:
    addi x27, x0, 6         # E
    beq  x0, x0, DELAY

DIGF:
    addi x27, x0, 14        # F
    beq  x0, x0, DELAY


# ============================================================
# RETARDO
# Cambiar x5 para modificar la velocidad:
#   addi x5, x0, 10
# ============================================================

DELAY:
    addi x5, x0, 5        # Mayor valor = más lento

RET1:
    addi x6, x0, 2000

RET2:
    addi x7, x0, 2000

RET3:
    addi x7, x7, -1
    beq  x7, x0, RET4
    beq  x0, x0, RET3

RET4:
    addi x6, x6, -1
    beq  x6, x0, RET5
    beq  x0, x0, RET2

RET5:
    addi x5, x5, -1
    beq  x5, x0, NEXT
    beq  x0, x0, RET1


# ============================================================
# INCREMENTO DEL CONTADOR
# ============================================================

NEXT:
    addi x1, x1, 1          # contador = contador + 1

    addi x12, x0, 16
    beq  x1, x12, RESET     # si llega a 16, vuelve a 0

    beq  x0, x0, LOOP


RESET:
    addi x1, x0, 0
    beq  x0, x0, LOOP
