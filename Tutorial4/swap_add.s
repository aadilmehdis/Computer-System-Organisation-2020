# Compile using gcc -nostdlib swap_add.s
# Usage of stack and procedures

.global _start
.text

_start:
    pushq %rbp            # Save old rbp
    movq  %rsp, %rbp      # Set %rbp as frame pointer
    subq  $24, %rsp       # Allocate 24 bytes on stack
    movl  $534, -4(%rbp)  # Set arg1 to 534
    movl  $1057, -8(%rbp) # Set arg2 to 1057
    leaq  -8(%rbp), %rax  # Compute &arg2
    movq  %rax, 4(%rsp)   # Store on stack
    leaq  -4(%rbp), %rax  # Compute &arg1
    movq  %rax, (%rsp)    # Store on stack
    call swap_add
    movq  -4(%rbp), %rdx
    subq  -8(%rbp), %rdx
    imulq %rdx, %rax     # rax stores the return value from the called function
    mov   $60, %rax      # system call 60 is exit
    xor   %rdi, %rdi     # we want to return code 0
    syscall

swap_add:
    pushq %rbp            # Save old rbp
    movq  %rsp, %rbp      # Set %rbp as frame pointer
    pushq %rbx            # Save %rbx
    movq  8(%rbp), %rdx   # Get xp
    movq  12(%rbp), %rax  # Get yp
    movl  (%rdx), %ebx    # Get x
    movl  (%rax), %eax    # Gey y
    movl  %eax, (%rdx)    # Store y at xp
    movl  %ebx, (%rax)    # Store x at yp
    addl  %ebx, %eax      # Return value = x + y
    popq  %rbx            # Restore rbx
    popq  %rbp            # Restore rbp
    ret
    