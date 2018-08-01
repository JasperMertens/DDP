.global inner_loop
.func inner_loop, inner_loop
.type inner_loop, %function

inner_loop:

push {r4-r12}

/////  1  /////

ldr r4, [sp, #36]
ldr r5, [sp, #40]
ldr r6, [sp, #44]
ldr r7, [sp, #48]
ldr r8, [sp, #52]

/////  2  /////

add r2,r2,r8, lsl #2	// *t[j]
add r3,r3,r8, lsl #2	// *a[j]
add r4,r4,r7, lsl #2	// *b[i]
add r6,r6,r8, lsl #2	// *n[j]

ldr r11, [r4]			// r11: b[i], r4: *b[i]

mov r4, r0				// r4:  *C
ldr r0, [r4]			// r0:  C
//mov r14, r1				// r14: *S
//ldr r1, [r14]			// r1:  S


begin_loop:

ldr r9,  [r2] ,#4		// r9:  t[j], r2: *t[j+1]
ldr r10, [r3] ,#4		// r10: a[j], r3: *a[j+1]
ldr r12, [r6] ,#4		// r12: n[j], r6: *n[j+1]

//mult_c

umull r10,r11,r10,r11	// r11,r10: a[j]*b[i] (MSB, LSB)
adds r9,r9,r0			// r9:  t[j] + C (onthoud carry), r0: C
//addcs r11,r11,#1		// r11: MSBs + carry
adc r11,r11,#0
adds r10,r10,r9			// r10:  LSBs + t[j] + C (onthoud carry), r10: LSBs, r9: t[j] + C
//addcs r11,r11,#1		// r11: MSBs + carry
adc r11,r11,#0
mov r0,r11				// r0:  MSBs + carrys

//add_c

sub r11, r2, #8			// r11: r2 - 8 : *t[j-1]
cmp r0,#0		
beq end_add_c			// jump to end if C = 0

ldr r9,[r2]				// r9: t[j+1], r2: *t[j+1]
adds r1,r9,r0			// r1: t[j+1] + C, r9: t[j+1], r0: C
str r1,[r2],#4			// r2: *t[j+2] (= t[j+1] + C = S),
bcc end_add_c			// jump to end if carry is zero (C = 0)

add_c_loop:
ldr r1,[r2]				// r1: t[j+2] (or higher, depending on the increment of *t)
adds r1,r1,#1			// r1: t[j+2] + 1
str r1,[r2],#4
bcs add_c_loop 			// if carry set, go to beginning of loop

end_add_c:

add r2, r11, #8			// restore r2 = *t[j+1]

umull r5,r12,r5,r12		// r5,r12:  C,S = m*n[j]
adds r1,r10,r5			// r1:      S = S + LSB
//addcs r12,r12,#1		// r12:     C = C + carry
adc r12,r12,#0

str r12, [r4]			// r4: *C, C = C
str r1, [r11]			// t[j-1] = S = LSB(sum) = LSB(S + m*n[j])

add r8,r8,#1			// r8: r8 + 1, (j = j + 1)
cmp r8, #32
bne begin_loop			// loop if j < SIZE

pop {r4-r12}

bx lr
.endfunc









