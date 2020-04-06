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



.globl main
# make symbol visible to 'ld'
#     .global or .globl

