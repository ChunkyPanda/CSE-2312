	.global main
	.func main

main:
	BL _scanf
	PUSH {R0}
	BL _scanf
	POP {R1}
	MOV R2,R0
	MOV R6,R1
	MOV R7,R2
	BL _count_part
	MOV R1, R0
	MOV R2,R6
	MOV R3,R7
	BL _printf
	B main

_count_part:
	PUSH {LR}
	CMP R1,#0
	MOVEQ R0,#1
	POPEQ {PC}
	CMP R1,#0
	MOVLT R0,#0
	POPLT {PC}
	CMP R2,#0
	MOVEQ R0,#0
	POPEQ {PC}
	PUSH {R1}
	PUSH {R2}
	SUB R1,R1,R2
	BL _count_part
	POP {R2}
	POP {R1}
	PUSH {R0}
	PUSH {R1}
	PUSH {R2}
	SUB R2,R2,#1
	BL _count_part
	POP {R2}
	POP {R1}
	POP {R9}
	ADD R0,R0,R9
	POP {PC}
_scanf:
	PUSH {LR}
	SUB SP,SP,#4
	LDR R0,=format_str
	MOV R1,SP
	BL scanf
	LDR R0,[SP]
	ADD SP,SP,#4
	POP {LR}
	MOV PC,LR
_printf:
	PUSH {LR}
	LDR R0,=printf_str
	MOV R1,R1
	BL printf
	POP {LR}
	MOV PC,LR



.data
format_str:         .asciz       "%d"
read_char:          .asciz       " "
printf_str:        .asciz       "There are %d partitions of %d using integers upto %d\n"
