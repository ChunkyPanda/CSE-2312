.global main
	.func main

main:
	BL _scanf
	MOV R3,R0
	MOV R0,#0
generate:
	CMP R0,#20
	BEQ writedone
	LDR R1,=array_a
	LDR R6,=array_b
	LSL R2,R0,#2
	LSL R8,R0,#2
	ADD R2,R1,R2
	ADD R8,R6,R8
	ADD R4,R3,R0
	STR R4,[R2]
	STR R4,[R8]
	ADD R2,R2,#4
	ADD R8,R8,#4
	ADD R4,R4,#1
	MOV R5,#0
	SUB R4,R5,R4
	STR R4,[R2]
	STR R4,[R8]
	ADD R0,R0,#2
	B generate
writedone:
	MOV R0,#0
sort:
	CMP R0,#19
	BEQ sortdone
	LDR R1, =array_b
	LSL R2,R0,#2
	ADD R2,R1,R2
	LDR R1,[R2]
	ADD R0,R0,#1
	PUSH {R0}
	PUSH {R1}
	PUSH {R2}
	MOV R3,R2
	BL startsort
	POP {R2}
	POP {R1}
	POP {R0}
	CMP R2,R3
	BEQ sort
	LDR R4,[R2]
	LDR R5,[R3]
	STR R5,[R2]
	STR R4,[R3]
	B sort
startsort:
	PUSH {LR}
sortLoop:
	CMP R0,#20
	POPEQ {PC}
	LDR R4,=array_b
	LSL R5,R0,#2
	ADD R5,R4,R5
	LDR R4,[R5]
	CMP R4,R1
	MOVLT R3,R5
	CMP R4,R1
	MOVLT R1,R4
	ADD R0,R0,#1
	B sortLoop
sortdone:
	MOV R0,#0
readLoop:
	CMP R0,#20
	BEQ readDone
	LDR R1,=array_a
	LDR R3,=array_b
	LSL R2,R0,#2
	LSL R4,R0,#2
	ADD R2,R1,R2
	ADD R4,R3,R4
	LDR R1,[R2]
	LDR R3,[R4]
	PUSH {R0}
	PUSH {R1}
	PUSH {R2}
	PUSH {R3}
	MOV R2,R1
	MOV R1,R0
	BL _printf
	POP {R3}
	POP {R2}
	POP {R1}
	POP {R0}
	ADD R0,R0,#1
	B readLoop
readDone:
	B main


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
array_a:            .skip        80
array_b:            .skip		80
format_str:         .asciz       "%d"
printf_str:        .asciz       "array_a[%d]       array_b=%d\n"
