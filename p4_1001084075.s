	.global main
	.func main

main:
	BL _scanf
	VMOV S0, R0
	PUSH {R0}
	BL _scanf
	POP {R1}
	VMOV S1, R0
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
	LDR R0, =print_f
	BL printf
	POP {PC}

_divide:
	PUSH {LR}
	FSITOS S0, S0
	FSITOS S1, S1
	VDIV.F32 S0, S0, S1
	VCVT.F64.F32 D4, S0
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
print_f:
	.asciz	"%f\n"
