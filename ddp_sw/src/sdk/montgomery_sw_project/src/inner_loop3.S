/*
 * inner_loop3.S
 *
 */

.global inner_loop3
.func inner_loop3, inner_loop3
.type inner_loop3, %function

inner_loop3:

//1

//2
push {r4-r11}

ldr r4, [sp, #32]
ldr r5, [sp, #36]
ldr r6, [sp, #40]

mov r8, #1

add r1, r4, r1, lsl#2
//3


start_loop:

add r6, r6, #4



//4
ldr r9,  [r2,#4]!
ldr r10, [r3,#4]!
ldr r11, [r1]

//5
ldr   r4, [r0]
umull r10, r11, r10, r11

//6
adds r9, r9, r4
adc  r11, r11, #0
mov r4, #1

//7
adds r10, r10, r9
adc  r11, r11, #0

//8
cmp r11, #0
beq end_add

start_add:
//9
ldr r9, [r2, r4, lsl#2]

//10
adds r7, r11, r9
mov  r11,  #0
adc  r11,  r11, #0

//11
str r7, [r2, r4, lsl#2]
add r4, r4, #1
cmp r11, #0
bne start_add

end_add:
//12
ldr r7, [r6]

//13
umull r7, r11, r5, r7

//14
adds r10, r7, r10
adc r11, r11, #0
str r11, [r0]

//15
str r10, [r2, #-4]

//16
add r8, r8, #1



cmp r8, #32
bne start_loop


pop {r4-r11}

bx lr
.endfunc










