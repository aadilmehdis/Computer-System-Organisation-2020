# Compile using gcc -g -nostdlib gcd.s
# Find the gcd of numbers
# Store gcd in rcx

.global _start

.text

_start:
	mov $10, %rax       	# a = 10
	mov $4, %rbx       		# b = 3
	jmp loop

loop:  
	mov %rbx, %rcx			#temp = b
	mov $0, %rdx  			#clear rdx
	idivq %rbx				#Divide a with b
	mov %rdx, %rbx			#b = a%b
	mov %rcx, %rax			#a = temp
	cmp $0, %rbx
	jne loop
	je exit


exit:
	mov     $60, %rax               # system call 60 is exit
	xor     %rdi, %rdi              # we want return code 0
	syscall 
