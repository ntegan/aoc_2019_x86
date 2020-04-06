.section .rodata
# Read only data

usg_str:          .asciz    "Usage: %s <in_file>\n"
no_file:          .asciz    "Couldn't open file '%s'"
r_m:              .asciz    "r"
out:              .asciz    "%d\n"



.bss
# "Uninit'd Data" global + static
## .asciz == adds \0 to str for you

# .equiv checks if symbol already defined
.equiv BUF_SZ,     4096

# .space == .skip.
##  ", 0" is optional fill value
buf:              .space    BUF_SZ, 0


.text
# fixed size

# make symbol visible to 'ld'
#     .global or .globl
.globl main

main:
# Caller saved registers (i.e. volatile, call-clobbered)
# Callee saved registers (i.e. ~volatile, call-preserved)

# calling functions, registers are used in this order
#   %rdi, rsi, rdx, rcs, r8, r9
#     7th and more arguments push onto stack
#   stack (rsp) must be 16B-aligned?

