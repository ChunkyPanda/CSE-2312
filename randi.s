.global main
.func main
   
main:
    MOV R0, #0
    MOV R5, #0
    MOV R4, #0
writeloop:
    CMP R0, #10 
    BEQ writedone
    PUSH {R0}
    BL _scanf
    CMP R5,R0
    MOVLT R5,R0
    CMP R4,R0
    MOVGT R4,R0
    MOV R7,R0
    POP {R0}
    LDR R1, =a
    LSL R2,R0,#2
    ADD R2,R1,R2
    STR R7,[R2]
    ADD R0,R0,#1
    B   writeloop           @ branch to next loop iteration
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
    BL min
    B _exit                 @ exit if done
min:
   MOV R1,R4
   BL _printmin    
_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall
_printmin:
    PUSH {LR}
    LDR R0, =print_min
    BL printf
    POP {PC}       
_printf:
    PUSH {LR}               @ store the return address
    LDR R0, =printf_str     @ R0 contains formatted string address
    BL printf               @ call printf
    POP {PC}                @ restore the stack pointer and return
_scanf:
    MOV R4, LR              @ store LR since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, =format_str     @ R0 contains address of format string
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    MOV PC, R4              @ retu
   
.data

.balign 4
a:              .skip       40
printf_str:     .asciz      "a[%d] = %d\n"
exit_str:       .ascii      "Terminating program.\n"
format_str:      .ascii      "%d"
print_min:       .ascii       "%d"
