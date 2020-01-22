# Compile using gcc -g -nostdlib odd_even.s
# Check if a number N is odd or even
# If even store 2 in rbx, else store 3 in rbx

.global _start

.text

_start:
        mov $15, %rax        # N = 15
        and $1, %rax         # N = N&1
        cmp $0, %rax         # Compare value of rax with 0
        je even
        jne odd

even: 
        mov $2, %rbx
        jmp exit

odd: 
        mov $3, %rbx
        jmp exit

exit:
        mov     $60, %rax               # system call 60 is exit
        xor     %rdi, %rdi              # we want return code 0
        syscall    