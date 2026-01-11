/* REQ: MEM-020 - Linker Script for RustOS
 * REQ: BUILD-010 - Memory layout for RISC-V RV32IMAC
 * 
 * Target: MicroBlaze V RISC-V (rv32imacb_zicsr_zifencei_zbc)
 * Board: Digilent Arty A7-35
 */

/* REQ: MEM-001, MEM-002 - Memory regions */
MEMORY
{
    /* REQ: HW-004 - 128 KB local BRAM at 0x00000000 */
    RAM (rwx) : ORIGIN = 0x00000000, LENGTH = 128K
}

/* REQ: INIT-014 - Reset vector at 0x00000000 */
ENTRY(_start)

/* REQ: CTX-007 - Stack alignment (16 bytes) */
PROVIDE(_stack_size = 4K);

SECTIONS
{
    /* REQ: MEM-021 - Vector table and reset vector */
    .init : ALIGN(4)
    {
        KEEP(*(.init));
        KEEP(*(.init.*));
    } > RAM

    /* REQ: MEM-022 - Text section (executable code) */
    .text : ALIGN(4)
    {
        *(.trap);
        *(.trap.*);
        *(.text);
        *(.text.*);
    } > RAM

    /* REQ: MEM-023 - Read-only data */
    .rodata : ALIGN(4)
    {
        *(.rodata);
        *(.rodata.*);
        *(.srodata);
        *(.srodata.*);
    } > RAM

    /* REQ: MEM-024 - Initialized data */
    .data : ALIGN(4)
    {
        _sdata = .;
        *(.data);
        *(.data.*);
        *(.sdata);
        *(.sdata.*);
        . = ALIGN(4);
        _edata = .;
    } > RAM

    /* REQ: INIT-005 - Global pointer for linker relaxation */
    __global_pointer$ = MIN(_sdata + 0x800, MAX(_sdata + 0x800, _ebss - 0x800));

    /* REQ: MEM-025 - Uninitialized data (BSS) */
    .bss (NOLOAD) : ALIGN(4)
    {
        _sbss = .;
        *(.bss);
        *(.bss.*);
        *(.sbss);
        *(.sbss.*);
        . = ALIGN(4);
        _ebss = .;
    } > RAM

    /* REQ: MEM-026 - Heap (not used, but reserved) */
    .heap (NOLOAD) : ALIGN(4)
    {
        _sheap = .;
        . = . + 0;  /* No heap allocation */
        _eheap = .;
    } > RAM

    /* REQ: MEM-027, INIT-004 - Stack */
    .stack (NOLOAD) : ALIGN(16)
    {
        _estack = .;
        . = . + _stack_size;
        _stack_start = .;
    } > RAM

    /* REQ: MEM-028 - Discard unwanted sections */
    /DISCARD/ :
    {
        *(.eh_frame);
        *(.eh_frame_hdr);
    }
}

/* REQ: BUILD-011 - Assert memory constraints */
ASSERT(_stack_start <= ORIGIN(RAM) + LENGTH(RAM), "Stack overflow into RAM boundary");
ASSERT(_eheap <= _estack, "Heap-stack collision");
