.data  

 # start of data section
# put any global or static variables here

.section .rodata
printString: .string "The answer is %d\n"
# start of read-only data section
# constants here, such as strings
# modifying these during runtime causes a segmentation fault, so be cautious!


.text    
# start of text /code
# everything inside .text is read-only, which includes your code!
.global _main        # required, tells gcc where to begin execution
# === functions here ===

_main:               # start of main() function
# preamble
pushq %rbp
movq %rsp, %rbp

# === main() code here ===

# setting up a & b
movq $2, %rbx  #a = rbx (2)
movq $3, %rcx  #b = rcx (3)

# a * 5
movq $5, %rax
mul %rbx  # a(rbx) * 5(rax) in rax 

# print answer
movq $printString, %rdi  
movq %rax, %rsi          
xorq %rax, %rax         
Call printf





# clean up and return
movq $0, %rax       # place return value in rax
leave               # undo preamble, clean up the stack
ret                 # return

