	.global main
	.func main

main:
	BL _scanf
	MOV R7,R0
	MOV R0,#0

_generate:
	CMP R0,#20
	BEQ writedone
	LDR R1,=a_array
	LSL R2,R0,#2
	ADD R2,R1,R2
	ADD R8,R7,R0
	STR R8,[R2]
	ADD R2,R2,#4
	ADD R8,R8,#1
	MOV R12,#0
	SUB R8,R12,R8
	ADD R0,R0,#2
	STR R8,[R2]
	B _generate
	BL _printf
writedone:
	MOV R0,#0
sorting:
	CMP R0,#20
	BEQ sortdone
	LDR R7,=a_array
	LSL R2,R0,#2
	ADD R2,R7,R2
	LDR R1,[R2]
	PUSH {R0}
	PUSH {R1}
	PUSH {R2}
	MOV R2,R1
	MOV R1,R0
	BL _printf
	POP {R2}
	POP {R1}
	POP {R0}
	ADD R0,R0,#1
	B sorting
sortdone:
	B _exit
_exit:
	MOV R7,#4
	MOV R0,#1
	MOV R2,#21
	LDR R1,=exit_str
	SWI 0
	MOV R7,#1
	SWI 0	
_scanf:
	PUSH {LR}
	SUB SP,SP,#4
	LDR R0,=format_str
	MOV R1,SP
	BL scanf
	LDR R0,[SP]
	ADD SP,SP,#4
	POP {PC}

_printf:
	PUSH {LR}
	LDR R0,=printf_str
	BL printf
	POP {PC}



.data
.balign 4
b_array:            .skip        80
a_array:            .skip        80
format_str:         .asciz       "%d"
printf_str:        .asciz       "a[%d] = %d    b=%d "
exit_str:          .ascii       "TErminating program"
