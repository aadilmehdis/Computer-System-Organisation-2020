# Basic push, pop instructions

.global _start

.text

_start:
        mov $15, %rax            # Move the value 15 in %rax
        mov $10, %rbx            # Move the value 15 in %rax
        push %rax                # Push value in %rax into the stack
        push %rbx                # Push value in %rbx into the stack
        pop %rax                 # Pop the top value from the stack in %rax
        pop %rbx                 # Pop the top value from the stack in %rbx
exit:
        mov     $60, %rax               # system call 60 is exit
        xor     %rdi, %rdi              # we want return code 0
        syscall    
