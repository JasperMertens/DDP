#include "hw.h"
#include "sw.h"
#include "interface.h"

#include <stdint.h>
#include "xil_printf.h"

// These variables are defined and assigned in testvector.c
extern uint32_t M[32],
                N[32],       N_prime[32],
                e[32],
                e_len,
                p[16],       q[16],
                d_p[16],     d_q[16],
                d_p_len, d_q_len,
                x_p[32],     x_q[32],
                R2p[16],     R2q[16],
                R_1024[32],  R2_1024[32],
                One[32];
#define SIZEA 32

#define CMD_IDLE           	 0x0;
#define CMD_READ_A           0x1;
#define CMD_READ_B           0x2;
#define CMD_READ_M           0x3;
#define CMD_COMPUTE          0x4;
#define CMD_WRITE            0x5;


void reduce_cipher(unsigned int *cipher, unsigned int *Cp, unsigned int *Cq) {
	unsigned int *Ch = cipher + 16;

	hw_montgomery_multiply_first(Ch, (unsigned int *) R2p, (unsigned int *) p, Cp, 16);
	mod_add((uint32_t *)Cp, (uint32_t *)cipher, p, (uint32_t *)Cp, 16);
	hw_montgomery_multiply_first(Ch, (unsigned int *) R2q, (unsigned int *) q, Cq, 16);
	mod_add((uint32_t *)Cq, (uint32_t *)cipher, q, (uint32_t *)Cq, 16);
}


void hw_mod_exp(uint32_t *msg, uint32_t *exp, uint32_t exp_len, uint32_t *n, uint32_t *R ,uint32_t *R2, uint32_t *res) {
	int i;
	int bit;

	unsigned int  x_tilde[16];
	unsigned int *A = (unsigned int *)res;

	// Calculate x_tilde = MontMul(x, R^2 mod m)
	//   R2_1024 is defined in global.h
	hw_montgomery_multiply_first((unsigned int *) msg, (unsigned int *)R2, (unsigned int *)n, x_tilde, 16);

	// Copy R to A
	//   R_1024 is defined in global.h
	for(i = 0; i < 16; i++)
	    A[i] = R[i];
	hw_montgomery_multiply_no_mod(A, A, A, 16); // To have A as the last montgomery multiplication result

	while(exp_len>0)
	{
		exp_len--;
		bit = (exp[exp_len/32] >> (exp_len%32)) & 1;
		//xil_printf("Bit[%d] of exponent is: %d\n\r", exp_len, bit);
		// Calculate A = MontMul(A, A)
		hw_montgomery_square_prev(A, 16);
		if(bit)
		{
			// Calculate A = MontMul(A, x_tilde)
			hw_montgomery_multiply_no_mod(A, x_tilde, A, 16);
		}
	}

	// Calculate A = MontMul(A, 1)
	//   One is defined in global.h
	hw_montgomery_multiply_no_mod(A, (unsigned int *)One, A, 16);

}

// Executes montgomery multiplication A*B/R % N on the hardware
void hw_montgomery_multiply_first(unsigned int  *a, unsigned int  *b, unsigned int  *n, unsigned int  *res, unsigned int SIZE) {

	my_montgomery_port[0] = CMD_READ_A;
	bram_dma_transfer(dma_config,a,SIZE);
	port2_wait_for_done();

	my_montgomery_port[0] = CMD_READ_B;
	bram_dma_transfer(dma_config,b,SIZE);
	port2_wait_for_done();

	my_montgomery_port[0] = CMD_READ_M;
	bram_dma_transfer(dma_config,n,SIZE);
	port2_wait_for_done();

	my_montgomery_port[0] = CMD_COMPUTE;
	port2_wait_for_done();

	my_montgomery_port[0] = CMD_WRITE;
	port2_wait_for_done();

	copy_bram_to(res, SIZE);
}

// Executes montgomery squaring A*A/R % N on the hardware of the last montgomery multiplication output
// and with the last used modulus
void hw_montgomery_square_prev(unsigned int  *res, unsigned int SIZE) {

	my_montgomery_port[0] = CMD_COMPUTE;
	port2_wait_for_done();

	my_montgomery_port[0] = CMD_WRITE;
	port2_wait_for_done();

	copy_bram_to(res, SIZE);
}

// Executes montgomery multiplication A*B/R % N on the hardware with the last used modulus
void hw_montgomery_multiply_no_mod_no_res(unsigned int  *a, unsigned int  *b, unsigned int SIZE) {

	my_montgomery_port[0] = CMD_READ_A;
	bram_dma_transfer(dma_config,a,SIZE);
	port2_wait_for_done();

	my_montgomery_port[0] = CMD_READ_B;
	bram_dma_transfer(dma_config,b,SIZE);
	port2_wait_for_done();

	my_montgomery_port[0] = CMD_COMPUTE;
	port2_wait_for_done();
}

// Executes montgomery multiplication A*B/R % N on the hardware with the last used modulus
void hw_montgomery_multiply_no_mod_no_res_no_a(unsigned int  *b, unsigned int SIZE) {

	my_montgomery_port[0] = CMD_READ_B;
	bram_dma_transfer(dma_config,b,SIZE);
	port2_wait_for_done();

	my_montgomery_port[0] = CMD_COMPUTE;
	port2_wait_for_done();
}

// Executes montgomery multiplication A*B/R % N on the hardware with the last used modulus
void hw_montgomery_multiply_no_mod(unsigned int  *a, unsigned int  *b, unsigned int  *res, unsigned int SIZE) {

	my_montgomery_port[0] = CMD_READ_A;
	bram_dma_transfer(dma_config,a,SIZE);
	port2_wait_for_done();

	my_montgomery_port[0] = CMD_READ_B;
	bram_dma_transfer(dma_config,b,SIZE);
	port2_wait_for_done();

	my_montgomery_port[0] = CMD_COMPUTE;
	port2_wait_for_done();

	my_montgomery_port[0] = CMD_WRITE;
	port2_wait_for_done();

	copy_bram_to(res, SIZE);
}

void copy_bram_to(unsigned int *result, unsigned int SIZE) {
	int i;
	for (i=0; i<SIZE; i++) {
		result[i] = my_montgomery_data[i];
	}
}

