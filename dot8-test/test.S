.section .text
.globl _start

_start:
    li t0, 0x0408020605040102
    li t1, 0x0201020402030305

    .word 0x0062838b

    li a7, 93
    mv a0, t2
    ecall


