# Read only data
.section .rodata


# "Uninit'd Data" global + static
.bss

# fixed size
.text

# make symbol visible to 'ld'
#     .global or .globl
.globl main

