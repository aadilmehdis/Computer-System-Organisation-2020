  .globl _start

  .data
space:   .ascii " "
newline:   .ascii "\n"

  .text

f1:
  xor %rax, %rax                
  movl $64, %ecx
  rep stosb
  ret


f2:
  movl (%rdi),%ecx
  cmpl $0, %ecx
  jz .peek_empty
  dec %ecx
  movq 4(%rdi, %rcx, 4), %rax
  ret
.peek_empty:
  movl $100000, %eax
  ret

f3:
  movl (%rdi),%ebx
  dec %ebx
  movl 4(%rdi, %rbx, 4), %eax   
  movl $0, 4(%rdi, %rbx, 4)     
  mov %ebx, (%rdi)              
  ret

f4:
  movl (%rdi),%ecx
  mov %rsi, 4(%rdi, %rcx, 4)
  inc %ecx
  mov %ecx, (%rdi)
  ret

pt:
  mov %rdi, %rsi
  movl $1, %eax                 
  movl %eax, %edi               
  movl %eax, %edx               
  syscall
  ret

pt2:
  push %rcx                     
  call pt
  mov $space, %rdi
  call pt
  pop %rcx
  ret

pt3:
  mov $newline, %rdi
  call pt
  ret
pt4:
  movl (%rdi), %ecx             
  cmpl $0, %ecx
  jz pt6
  add $4, %rdi                  
  sub $8, %rsp                  
pt5:
  movl (%rdi), %eax             
  addl $'0', %eax               
  mov %rax, (%rsp)              
  mov %rdi, %rbx                
  mov %rsp, %rdi                
  call pt2
  add $4, %rbx
  mov %rbx, %rdi
  loop pt5
  add $8, %rsp                  
pt6:
  call pt3
  ret

pt7:
  mov (%rbp), %rax
  andl $1, %eax
  jz pt8
  lea -64(%rbp), %rdi
  call pt4
  lea -128(%rbp), %rdi
  call pt4
  lea -192(%rbp), %rdi
  call pt4
  call pt3
  ret
pt8:
  lea -64(%rbp), %rdi
  call pt4
  lea -196(%rbp), %rdi
  call pt4
  lea -128(%rbp), %rdi
  call pt4
  call pt3
  ret

f5:
  mov %rdi, %r9
  call f2
  mov %rax, %r10
  mov %rsi, %rdi
  call f2
  mov %r9, %rdi
  cmp %rax, %r10
  jg .less_branch
.greater_branch:
  mov %rdi, %rax
  mov %rsi, %rdi
  mov %rax, %rsi
.less_branch:
  call f3
  push %rdi
  push %rsi
  mov %rsi, %rdi
  mov %rax, %rsi
  call f4
  pop %rsi
  pop %rdi
  jmp pt7

solve:
  push %rdi
  
  sub $64, %rsp
  mov %rsp, %rdi
  call f1

  sub $64, %rsp
  mov %rsp, %rdi
  call f1

  sub $64, %rsp
  mov %rsp, %rdi
  call f1

  lea -64(%rbp), %rax
  mov (%rbp),%rcx
  mov %rcx, (%rax)              
  add $4, %rax

.init_s:
  mov %rcx, (%rax)
  add $4, %rax
  loop .init_s

  call pt7                

  mov (%rbp), %cl               
  mov $1, %r14                  
  shl %cl, %r14                 
  dec %r14                      
  xor %r15,%r15                 

f7:
  lea -64(%rbp), %rdi           
  lea -192(%rbp), %rsi          
  call f5

  inc %r15                      
  cmp %r14, %r15                
  jge f8              

  lea -64(%rbp), %rdi
  lea -128(%rbp), %rsi
  call f5

  inc %r15
  cmp %r14, %r15
  jge f8

  lea -192(%rbp), %rdi
  lea -128(%rbp), %rsi
  call f5

  inc %r15
  cmp %r14, %r15
  jge f8
  jmp f7

f8:
  lea 8(%rbp), %rsp             
  ret

_start:
  movl $3, %edi                 
  cmpl $1, (%rsp)               
  jle .solve
  mov 16(%rsp), %rax            
  movsbl (%rax), %edi           
  subl $'0', %edi               
.solve:
  call solve

  mov $60, %rax                 
  xor %rdi, %rdi
  syscall
