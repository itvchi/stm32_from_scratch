.syntax unified /* needed for ldr instruction of SP */
.cpu cortex-m4
.thumb

.word _etext
.word _sdata
.word _edata
.word _sbss
.word _ebss

.global ResetHandler

.section .text

ResetHandler:
    ldr   sp, =_estack      /* set stack pointer */
    b   main

.section .isr_vector,"a" /* a - ignored flag (without it .text overrides .isr_vector) */
    .word   _estack
    .word   ResetHandler
