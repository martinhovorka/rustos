# RISC-V linker script for RustOS on Arty A7-35
# Memory layout for MicroBlaze V soft-core processor

MEMORY
{
  # Flash/ROM - Program memory
  FLASH (rx)  : ORIGIN = 0x00000000, LENGTH = 16M
  
  # RAM - Data memory
  RAM (rwx)   : ORIGIN = 0x80000000, LENGTH = 256K
}

# Entry point
ENTRY(_start)

SECTIONS
{
  # Vector table and startup code
  .text :
  {
    KEEP(*(.text.start));
    *(.text .text.*);
    *(.rodata .rodata.*);
  } > FLASH

  # Data section (initialized data)
  .data :
  {
    . = ALIGN(4);
    _sdata = .;
    *(.data .data.*);
    . = ALIGN(4);
    _edata = .;
  } > RAM AT > FLASH
  
  _sidata = LOADADDR(.data);

  # BSS section (zero-initialized data)
  .bss :
  {
    . = ALIGN(4);
    _sbss = .;
    *(.bss .bss.*);
    *(COMMON);
    . = ALIGN(4);
    _ebss = .;
  } > RAM

  # Stack (grows downward)
  .stack :
  {
    . = ALIGN(16);
    _stack_start = .;
    . = . + 8K;
    . = ALIGN(16);
    _stack_end = .;
  } > RAM

  # Heap (if needed)
  .heap :
  {
    . = ALIGN(4);
    _heap_start = .;
    . = . + 16K;
    . = ALIGN(4);
    _heap_end = .;
  } > RAM

  # Discard exception unwinding information
  /DISCARD/ :
  {
    *(.eh_frame);
    *(.eh_frame_hdr);
  }
}
