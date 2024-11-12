.data  
# start of data section
# put any global or static variables here

.section .rodata
printString: .string "1. Result: %d\n"
printString2: .string "2. Result: %d\n"
printString3: .string "3. Result: %d\n"

# start of read-only data section
# constants here, such as strings
# modifying these during runtime causes a segmentation fault, so be cautious!


.text    
# start of text /code
# everything inside .text is read-only, which includes your code!
.global main        
# required, tells gcc where to begin execution
# === functions here ===

main:             
# start of main() function
# preamble
pushq %rbp
movq %rsp, %rbp

# === main() code here ===

# setting up a & b - hardcoding
movq $6, %rbx  #a = rbx (6)
movq $2, %r12  #b = r12 (2)

# a * 5
movq $5, %rax
mul %rbx  # a(rbx) * 5(rax) in rax 

# print answer (2 * 5)
movq $printString, %rdi    #rdi register for format string 
movq %rax, %rsi          #rsi for print value
xorq %rax, %rax         
Call printf

# (a + b) - (a/b)
movq %r12, %r11  # b in r11    
addq %rbx, %r11  # a + b in r11   
movq %rbx, %rax    # a in rax  
cqto             #sign extends   rdx:rax
idivq %r12       #a/b (rax / rcx) in rax   
subq %rax, %r11 #(a+b) - (a/b) in r11

#print answer
movq $printString2, %rdi    
movq %r11, %rsi          
xorq %rax, %rax         
Call printf

# a = 6, b = 2

# (a-b) + (a*b)
movq %rbx, %r9  # a in r9
movq %r12, %r10  # b in r10
subq %r10, %r9  # a - b = r9
 
movq %rbx, %rax  # a in rax
mulq %r12   # a * b in rax

addq %rax, %r9   # (a-b) + (a*b) in rax

#print answer
movq $printString3, %rdi    
movq %r9, %rsi          
xorq %rax, %rax         
Call printf

# clean up and return
movq $0, %rax       # place return value in rax
leave               # undo preamble, clean up the stack
ret                 # return

