.section .rodata

bad_args: .asciz "Usage: %s <input>\n"
bad_fopen: .asciz "Error opening '%s': %s\n"
read_mode: .asciz "r"
output_answer: .asciz "%d\n"

.bss

.equiv BUFFER_SIZE, 64

buffer: .space BUFFER_SIZE

.text

.global main

main:
    push %rbp               # callee-saved
    push %r12
    push %r13
    push %r14
    push %rbx
    mov %rdi, %r12          # int argc
    mov %rsi, %r13          # char **argv
    cmp $2, %r12            # check for one argument
    je num_args_ok

    # args are not ok

    mov $bad_args, %rdi
    mov (%r13), %rsi        # argv[0]
    xor %rax, %rax
    call printf
    mov $1, %rax
    jmp main_ret

num_args_ok:
    mov 8(%r13), %rdi        # argv[1]
    mov $read_mode, %rsi
    call fopen
    cmp $0, %rax
    je fopen_failed

    # file opened ok
    mov %rax, %r13          # we don't need argv anymore, so reuse r13
    xor %r12, %r12          # zero out for accumulating fuel requirement

line_read_loop:
    mov $buffer, %rdi
    mov $BUFFER_SIZE, %rsi
    mov %r13, %rdx
    call fgets
    cmp $0, %rax
    je calc_done             # we are all done

    # we got a new line
    # convert it to an integer
    mov $buffer, %rdi
    call atoi

    # now let's compute fuel needed
    xor %rdx, %rdx          # zero out for div command
    mov $3, %rbx
    div %rbx
    sub $2, %rax
    add %rax, %r12
    jmp line_read_loop

calc_done:
    mov $output_answer, %rdi
    mov %r12, %rsi
    xor %rax, %rax
    call printf
    xor %rax, %rax
    jmp main_ret

fopen_failed:
    call get_errno
    mov %rax, %rdi
    call strerror
    mov $bad_fopen, %rdi
    mov 8(%r13), %rsi        # argv[1]
    mov %rax, %rdx
    xor %rax, %rax
    call printf
    mov $1, %rax
    jmp main_ret

main_ret:
    pop %rbx
    pop %r14
    pop %r13
    pop %r12
    pop %rbp
    ret
