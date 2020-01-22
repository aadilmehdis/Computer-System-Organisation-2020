# Compile using gcc -g -nostdlib Fibonacci.s
# Calculate the Nth Fibonacci number

.global _start

.text

_start:
        mov $1, %rax         # a = 1
        mov $2, %rbx         # b = 2  
        mov $5, %rdx         # n = 5

loop:
    mov %rbx, %rcx           # temp = b  
    add %rax, %rbx           # b = a + b 
    mov %rcx, %rax           # a = temp
    dec %rdx                 # n -= 1
    cmp $0, %rdx             # Compare value of n and 0 
    jne loop                 # if (n > 0), continue the loop 

exit:
        mov     $60, %rax               # system call 60 is exit
        xor     %rdi, %rdi              # we want return code 0
        syscall