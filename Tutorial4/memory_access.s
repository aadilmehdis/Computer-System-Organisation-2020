.global _start

.text

_start:

	movq $0, %r8
    movq $10, %r9
    call write
    movq $15, %r9
    inc %r8
    call write

exit:
    mov     $60, %rax               # system call 60 is exit
    xor     %rdi, %rdi
    syscall

write:                          # write a value at the ith index , mem[base+8*index] = value (using 8byte integer)
	movq %r9, (%rcx, %r8, 8)    # r8 -> index   r9 -> value  rcx -> base address           
	ret 

read:                           # read a value at the ith index into a register , reg = mem[base+8*index]  (using 8byte integer)
	movq (%rcx, %r8, 8), %r11   # r8 -> index   r11 -> output register  rcx -> base address
	ret
	