	.global main
	.func main

main:
	BL _scanf
	VMOV S1, R0
	PUSH {R0}
	BL _scanf
	POP {R1}
	VMOV S2, R0
	MOV R2, R0
	BL _print1
	BL _divide
	BL _print2
	B main

_print1:
	PUSH {LR}
	LDR R0, =print_str
	BL printf
	POP {PC}

_print2:
	PUSH {LR}
	LDR R0, =print_float
	BL printf
	POP {PC}

_divide:
	PUSH {LR}
	FSITOS S1, S1
	FSITOS S2, S2
	VDIV.F32 S1, S1, S2
	VCVT.F64.F32 D4, S1
	VMOV R1, R2, D4
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
format_str:
	.asciz	"%d"
print_str:
	.asciz	"%d / %d = "
print_float:
	.asciz	"%f\n"
