	.global main
	.func main

main:
	BL _scanf
	MOV R8,R0
	BL _getchar
	MOV R9,R0
	BL _scanf
	MOV R10,R0
	BL _getop
	B main
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
_getchar:
	MOV R7,#3
	MOV R0,#0
	MOV R2,#1
	LDR R1,=read_char
	SWI O
	LDR R0, [R1]
	AND R0, #0xFF
	MOV PC,LR
_getop:
	PUSH {LR}
	CMP R9, #'+'
	BEQ _sum
	CMP R9,#'-'
	BEQ _difference
	CMP R9,#'M'
	BEQ _max
	CMP R9,#'*'
	BEQ _product
	POP {LR}
	MOV PC,LR
_printf:
	LDR R0,=printf_str
	MOV R1,R0
	BL printf
	POP {LR}
	MOV PC,LR
_sum:
	ADD R8,R8,R10
	BL _printf
_difference:
	SUB R8,R8,R10
	BL _printf
_max:
	MOVGE R8,R10
	BL _printf
_product:
	MUL R8,R8,R10
	BL _printf


.data
format_str:         .asciz       "%d"
read_char:          .asciz       " "
printf_str:        .asciz       "%d\n"
