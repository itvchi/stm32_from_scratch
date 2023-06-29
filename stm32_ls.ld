/* Entry point *//* Entry point */
ENTRY(ResetHandler)

/* Specify the memory areas */
MEMORY
{
    FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 256K
    SRAM (rwx) : ORIGIN = 0x20000000, LENGTH = 64K
}

/* Calculate end address of stack as one adress after RAM -> it will be SP */
_estack = ORIGIN(SRAM) + LENGTH(SRAM);

/* Generate a link error if heap and stack doesn't fit into RAM */
_Min_Heap_Size = 0x400;
_Min_Stack_Size = 0x400;

/* Define output sections */
SECTIONS
{
    /* Place ISR vector at the beginning of FLASH */
    .isr_vector :
    {
        _isr_vector_start = .;
        . = ALIGN(4);
        KEEP(*(.isr_vector))
        . = ALIGN(4);
        _isr_vector_end = .;
    } >FLASH

    /* Program code */
    .text :
    {
        . = ALIGN(4);
        *(.text)
        *(.text*)
        *(.rodata)
        . = ALIGN(4);
        _etext = .;
    } >FLASH

    /* Initialized data section */
    .data :
    {
        . = ALIGN(4);
        _sdata = .;
        *(.data)
        *(.data*)
        . = ALIGN(4);
        _edata = .;
    } >SRAM AT> FLASH

    /* Zero initialized data */
    .bss :
    {
        . = ALIGN(4);
        _sbss = .;
        *(.bss)
        . = ALIGN(4);
        _ebss = .;
    } >SRAM

}