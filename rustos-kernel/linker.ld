/* REQ: MEM-001 - Memory layout for MicroBlaze V on Arty A7-35
 * 
 * REQ: MEM-002 - 128 KB BRAM @ 0x0000_0000
 * REQ: ISA-001 - RV32IMAC with B, Zicsr, Zifencei, Zbc extensions
 */

/* Memory regions */
MEMORY
{
    /* REQ: MEM-002 - 128 KB on-chip BRAM */
    RAM (rwx) : ORIGIN = 0x00000000, LENGTH = 128K
}

/* Stack configuration */
_stack_size = 8K;

/* Entry point */
ENTRY(_start)

SECTIONS
{
    /* Code section */
    .text : ALIGN(4)
    {
        _stext = .;
        KEEP(*(.init));
        *(.init.*)
        *(.text .text.*)
        _etext = .;
    } > RAM

    /* Read-only data */
    .rodata : ALIGN(4)
    {
        _srodata = .;
        *(.rodata .rodata.*)
        _erodata = .;
    } > RAM

    /* Trap vector (must be aligned to 4 bytes minimum) */
    .trap : ALIGN(4)
    {
        _strap = .;
        KEEP(*(.trap));
        *(.trap.*)
        _etrap = .;
    } > RAM

    /* Data section */
    .data : ALIGN(4)
    {
        _sdata = .;
        *(.data .data.*)
        *(.sdata .sdata.*)
        . = ALIGN(4);
        _edata = .;
    } > RAM

    /* BSS section */
    .bss : ALIGN(4)
    {
        _sbss = .;
        *(.bss .bss.*)
        *(.sbss .sbss.*)
        *(COMMON)
        . = ALIGN(4);
        _ebss = .;
    } > RAM

    /* Heap (grows upward) */
    . = ALIGN(4);
    _sheap = .;
    _eheap = ORIGIN(RAM) + LENGTH(RAM) - _stack_size;

    /* Stack (grows downward from end of RAM) */
    .stack (NOLOAD) : ALIGN(16)
    {
        . = . + _stack_size;
        _stack_start = .;
    } > RAM

    /* Global pointer for relaxation */
    __global_pointer$ = _sdata + 0x800;

    /* Discard sections */
    /DISCARD/ :
    {
        *(.eh_frame .eh_frame.*)
        *(.ARM.extab.*)
        *(.ARM.exidx.*)
    }
}
