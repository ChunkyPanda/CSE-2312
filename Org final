.global main
.func main
   
main:
    MOV R0, #0
    MOV R6, #255
    MOV R5, #-255
    MOV R8,#0
writeloop:
    CMP R0, #10 
    BEQ writedone
    PUSH {R0}
    BL _scanf
    MOV R7,R0
    CMP R5,R7
    MOVLT R5,R7
    CMP R6,R7
    MOVGT R6,R7
    ADD R8,R7,R8
    POP {R0}
    LDR R1, =a
    LSL R2,R0,#2
    ADD R2,R1,R2
    STR R7,[R2]
    ADD R0,R0,#1
    B writeloop           
writedone:
    MOV R0, #0              
readloop:
    CMP R0, #10             
    BEQ readdone            
    LDR R1, =a              
    LSL R2, R0, #2          
    ADD R2, R1, R2          
    LDR R1, [R2]             
    PUSH {R0}               
    PUSH {R1}               
    PUSH {R2}               
    MOV R2, R1              
    MOV R1, R0              
    BL  _printf             
    POP {R2}                
    POP {R1}                
    POP {R0}                
    ADD R0, R0, #1          
    B   readloop            
readdone:
    MOV R1,R6
    BL _printfmin
    MOV R1,R5
    BL _printfmax
    MOV R1,R8
    BL _printsum
    B _exit                 
_exit:
    MOV R7, #4              
    MOV R0, #1              
    MOV R2, #21             
    SWI 0                   
    MOV R7, #1              
    SWI 0                   
_printf:
    PUSH {LR}               
    LDR R0, =printf_str     
    BL printf               
    POP {PC}
_printsum:
   PUSH {LR}
   LDR R0, =print_sum
   BL printf
   POP {PC}
_printfmax:
    PUSH {LR}
    LDR R0,=printf_max
    BL printf
    POP {PC}
_printfmin:
    PUSH {LR}
    LDR R0, =printf_min
    BL printf
    POP {PC}
_scanf:
    PUSH {LR}              
    SUB SP, SP, #4          
    LDR R0, =format_str     
    MOV R1, SP              
    BL scanf                
    LDR R0, [SP]            
    ADD SP, SP, #4          
    POP {PC}                
   
.data

.balign 4
a:              .skip       40
printf_max:     .asciz      "maximum = %d \n"
printf_min:     .asciz      "minimum= %d\n"
print_sum:      .asciz       "sum = %d\n"
printf_str:     .asciz      "a[%d] = %d\n"
format_str:     .ascii      "%d"
