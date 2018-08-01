/*
 * montgomery.c
 *
 */

#include "montgomery.h"
#include "asm_add.h"
#include "inner_loop.h"
#include "inner_loop3.h"

void add(uint32_t *t, uint32_t i, uint32_t C);
void sub_cond(uint32_t *t, uint32_t *n, uint32_t *p);

#define SIZE2 32

void mont(uint32_t *a, uint32_t *b, uint32_t *n, uint32_t *n0, uint32_t *res, uint32_t SIZE) {
	uint32_t t[SIZE2+2] = {0};
	uint32_t i;
	//uint64_t sum=0;
	uint32_t C=0;
	uint32_t S=0;
	uint32_t m=0;
	//i=1;
	for(i=0 ; i<SIZE ; i++) {
	asm_sum1(&C, &S, t, a, b, i);
	add_c(t,1,C);
	m = (uint32_t)(S*(*n0));
	asm_sum2(&C, S, n0, n);
	inner_loop3(&C, i, t, a, b, m, n);
	asm_end(C, t+SIZE);

	}
	sub_cond(t,n, res);
}


void add(uint32_t *t, uint32_t i, uint32_t C){
	uint64_t sum = 0;
	uint32_t S;
	while(C!=0) {
		sum = (uint64_t)t[i] + (uint64_t)C;
		C = (sum>>32); 				//(uint32_t)
		S = (uint32_t)(sum);
		t[i] = S;
		i++;
	}
}



void sub_cond(uint32_t *u, uint32_t *n, uint32_t *p){
	uint32_t B = 0;
	uint32_t t[SIZE2] = {0};
	uint32_t sub = 0;
	uint32_t i;
	for(i=0 ; i<SIZE2 ; i++) {
		sub = u[i] - n[i] - B;
		if(u[i] >= n[i] + B){
			B = 0;
		} else {
			B = 1;
		}
		t[i] = sub;
	}
	if(B == 0){
		for (i=0; i<SIZE2; i++) {
			p[i] = t[i];
		}
	} else {
		for (i=0; i<SIZE2; i++) {
			p[i] = u[i];
		}
	}
}

/*for(j=1; j<SIZE ; j++) {
			sum = (uint64_t)t[j] + (uint64_t)a[j]*(uint64_t)b[i] + C;
			C = (sum>>32);
			S = (uint32_t)(sum);
			//asm_sum(&C, &S, t, a, b, C, i, j);
			add_c(t,j+1,C);
			sum = (uint64_t)S + (uint64_t)m*(uint64_t)n[j];
			C = (sum>>32);
			S = (uint32_t)(sum);
			//asm_sum3(&C, &S, S, &m, n, j);
			t[j-1] = S;
		}*/
