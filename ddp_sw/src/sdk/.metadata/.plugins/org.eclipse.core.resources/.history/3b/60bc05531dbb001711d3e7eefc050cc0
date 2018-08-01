.text

.global asm_sum_1
.func asm_sum_1, asm_sum_1
.type asm_sum_1, %function

ASM_SUM_1:
push {r4-r5}
ldr r2, [r2]	//t[j]
ldr r3, [r3]	//a[j]
ldr r4, [r4]	//b[i]
ldr r5, [r0]	//r5 <- c

umull r3,r4,r3,r4	// a[j]*b[i]
			// r3: lower, r4: higher
adds r3,r2,r3		// t[j] + a[j]*b[i]
addcs r4, r4, #1	// carry in higher
adds r3, r3, r5		// lower + C
addcs r4, r4, #1	// carry in higher

str r3, [r1]
str r4, [r0]

pop {r4-r5}
bx lr
.endfunc


.text

.global asm_add
.func asm_add, asm_add
.type asm_add, %function
ASM_ADD:
ldr r0, [r0]	//r0 <-C
cmp r0, #0	//C!=0
beq END_ASM_ADD

ldr r2, [r1]		// r2 <- t[j]
adds r0, r0, r2		// C + t[j]
str r0, [r1], #4	// save result in t[j]
bcc END_ASM_ADD

ASM_ADD_LOOP:
ldr r2, [r1]
adds r0, r2, #1
str r0, [r1], #4
bcs ASM_ADD_LOOP

END_ASM_ADD:
bx lr
.endfunc


.text

.global asm_sum_2
.func asm_sum_2, asm_sum_2
.type asm_sum_2, %function

ASM_SUM_2:
push {r4-r5}
ldr r4, [r4]	// n[j]
ldr r5, [r1]	// r5 <-S
umull r3, r4, r3, r4	// m*n[j]
			// r3: lower, r4: higher
adds r3, r3, r5		// S + m*n[j] in lower
adc r4, r4, #1		// carry in higher

str r3, [r2, #-12]	// t[j-1] <- lower
str r4, [r0]		// C <- higher

pop {r4-r5}
bx lr
.endfunc

.text

.global inner_loop2
.func inner_loop2, inner_loop2
.type inner_loop2, %function

inner_loop2:

push {r4-r8, lr}

add r4, r4, r7, lsl #2 // *b -> *b+i*4
						// r7 is now free

LOOP:
add r2, r2, #4 // *t -> *t+4
add r3, r3, #4 // *a -> *a+4
add r6, r6, #4 // *n -> *n+4

push {r2, r3}	// save *t[j+1] and *a[j+1]

bl ASM_SUM_1

mov r7, r1		// temporarily save *S in r7
pop {r1, r3}		// store *t[j+1] in r1 and restore *a[j+1] to r3

bl ASM_ADD

push {r3,r4,r5}	// save *a[j+1], *b[j+1] and m
mov r3, r1		// clear r2, store *t[j+1] in r3
mov r1, r7		// get *S back in r1
mov r2, r1		// get *t[j+1] back in r2
mov r3, r5		// get m in r3
mov r4, r6		// get *n[j+1] in r4

bl ASM_SUM_2

mov r6, r4		// get *n back in r6
pop {r3,r4,r5}	// restore *a[j+1], *b[j+1] and m


subs r8, r8, #1

bne LOOP
bx lr
.endfunc
