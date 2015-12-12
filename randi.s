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
    B writeloop           @ branch to next loop iteration
writedone:
    MOV R0, #0              @ initialze index variable
readloop:
    CMP R0, #10             @ check to see if we are done iterating
    BEQ readdone            @ exit loop if done
    LDR R1, =a              @ get address of a
    LSL R2, R0, #2          @ multiply index*4 to get array offset
    ADD R2, R1, R2          @ R2 now has the element address
    LDR R1, [R2]            @ read the array at address 
    PUSH {R0}               @ backup register before printf
    PUSH {R1}               @ backup register before printf
    PUSH {R2}               @ backup register before printf
    MOV R2, R1              @ move array value to R2 for printf
    MOV R1, R0              @ move array index to R1 for printf
    BL  _printf             @ branch to print procedure with return
    POP {R2}                @ restore register
    POP {R1}                @ restore register
    POP {R0}                @ restore register
    ADD R0, R0, #1          @ increment index
    B   readloop            @ branch to next loop iteration
readdone:
    MOV R1,R6
    BL _printfmin
    MOV R1,R5
    BL _printfmax
    MOV R1,R8
    BL _printsum
    B _exit                 @ exit if done
_exit:
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall
_printf:
    PUSH {LR}               @ store the return address
    LDR R0, =printf_str     @ R0 contains formatted string address
    BL printf               @ call printf
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
    PUSH {LR}              @ store LR since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, =format_str     @ R0 contains address of format string
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    POP {PC}                @ retu
   
.data

.balign 4
a:              .skip       40
printf_max:     .asciz      "maximum = %d \n"
printf_min:     .asciz      "minimum= %d\n"
print_sum:      .asciz       "sum = %d\n"
printf_str:     .asciz      "a[%d] = %d\n"
format_str:     .ascii      "%d"
