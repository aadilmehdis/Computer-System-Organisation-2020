# Compile using gcc -g -nostdlib gcd.s
# Find the sum of first n even natural numbers
# Store result in rcx
.global _start

.text

.data


_start:
    mov $6, %rax                    # n=6
    mov $0, %rbx
    mov $0, %rcx

loop:
    add $1, %rbx
    mov %rbx, %rdx
    and $1, %rdx
    cmp $0, %rdx
    je add
    jne loop

add:
    add %rbx, %rcx
    sub $1, %rax
    cmp $0, %rax
    je exit
    jne loop


exit:
	mov     $60, %rax               # system call 60 is exit
	xor     %rdi, %rdi              # we want return code 0
	syscall 
