#include <stdio.h>
#include <stdlib.h>

#include "xil_printf.h"
#include "xil_cache.h"

#include "platform/platform.h"
#include "platform/performance_counters.h"

#include "interface.h"
#include "sw.h"
#include "hw.h"

///////////////////////////////////////////////////////////
#include "montgomery2.h"
///////////////////////////////////////////////////////////

// These variables are defined and assigned in testvector.c
extern uint32_t M[32],
                N[32],       N_prime[32],
                e[32],
                e_len,
                p[16],       q[16],
                d_p[16],     d_q[16],
                d_p_len, d_q_len,
                x_p[32],     x_q[32],
				Rp[16],		Rq[16],
                R2p[16],     R2q[16],
                R_1024[32],  R2_1024[32],
                One[32];


// Note that these tree CMDs are same as
// they are defined in montgomery_wrapper.v
#define CMD_READ    0
#define CMD_COMPUTE 1
#define CMD_WRITE   2

void test_mp_sub();
void test_mp_add();
void test_mod_add();
void test_mont_mult();
void test_mont_exp();
void printMontExpResult();
void test_hw_mont_mult();
void test_hw_mont_exp();
void test_hw_mont_decrypt();

uint32_t result[32] = {0};
uint32_t size = 32;



// MULTIPLICATION TESTVECTORS
uint32_t A16[16] = 					{0x51977946, 0x7957b1be, 0x9f030fbd, 0x04561a82, 0x1fad9525, 0xab8e0526, 0x05c0a4a8, 0x4dcc3907, 0xc8ae12c7, 0x8b7d54ca, 0x22e43d05, 0x806b8cac, 0x13cbfd6b, 0x36d3028f, 0x52132ef0, 0xc51931a9};
uint32_t B16[16] = 					{0x5fc3d1ef, 0x96dec894, 0x2d5929f7, 0xc0810a9f, 0x8b55af12, 0x3548fef6, 0x3d61e914, 0xc5784013, 0x20669791, 0x154a73de, 0x98e985d3, 0xe3d56445, 0xcb4fba56, 0x5f0012cc, 0xca83b655, 0xb220f8c0};
uint32_t N16[16] = 					{0x0ebd5f75, 0x948cb7ab, 0x58727656, 0x0f02d0b4, 0x6ed897f2, 0x052304af, 0xcea1ed9f, 0x2e3b3a4c, 0xaa19906f, 0x0a3be041, 0x6ae0754b, 0x28470c40, 0xc871a4de, 0x10943525, 0x105d393e, 0xc6bb131b};
uint32_t N_prime16[16] = 			{0x7648c723, 0xdc590cb1, 0xbb4c5143, 0x58be381a, 0x7f1c698f, 0x46297b6c, 0xb991e392, 0x3d7d04c2, 0xa0eb979b, 0x3f231be6, 0x9c6760bf, 0x4ed1e95f, 0x464cc4b6, 0xde39afa8, 0xa1bfa709, 0xed55fac2};
uint32_t expected_output16[16] = 	{0x9e31ea81, 0xe265cbb7, 0x5e453a5a, 0xffe854d5, 0x58b4d35b, 0x5370eae7, 0xfd0d421a, 0x66dd18b8, 0x7b232ec6, 0xb6df247f, 0x3f359f29, 0x4c244688, 0xc901b64c, 0xda554d8d, 0x7e49f069, 0x9712a929};


uint32_t A32[32] = 					{0xf484e847, 0x4ae251f1, 0xedfa617d, 0x58ab6bf4, 0x46bf4848, 0xf67c1061, 0x8811c17a, 0x578fde16, 0x493ee595, 0x1eafc4c3, 0xc4f11a2e, 0x8cb6fba7, 0x724c03a4, 0x2e6c1dbd, 0x57ebc43d, 0x3e6ee260, 0x4089c050, 0xf0384e03, 0x7357f72c, 0x87acb658, 0x7ea2490e, 0x61069112, 0x42e3f8b9, 0x9e778cef, 0x5cdf77c7, 0x10bce41c, 0x1121beec, 0x3db59a36, 0xc34620c5, 0xc6b030ae, 0xe8fc5934, 0x63a0a0cb};
uint32_t B32[32] = 					{0xfeb1b9f4, 0xe91d3bec, 0xfb09354d, 0x07f21d6d, 0x9ece9e1b, 0x18def18b, 0x4119e1e9, 0x55c85f24, 0x60ef0e23, 0x10e8ab54, 0x1e95cdcc, 0x4373912f, 0x6f42204d, 0x7126650d, 0xb61c1c8d, 0x98af9011, 0xa42c03b4, 0xd29e0870, 0x7923cb60, 0xdf87cfe5, 0xde4fffa0, 0x3ce537ca, 0x201040c6, 0x6e54b058, 0x814c53dc, 0xf16243f0, 0x57decf64, 0x8d0d4f37, 0x9b6d93e5, 0x45396d71, 0x615213c4, 0x65f89f9f};
uint32_t N32[32] = 					{0x4aeeb107, 0x5d78aa98, 0x6c55dd05, 0x6f5326c9, 0xf93f738c, 0xc10fa093, 0x20478120, 0x099d6d70, 0x833d9b82, 0x1248f3ed, 0xa43ed737, 0xc1c1da45, 0x9f23e5c7, 0xb17c3598, 0xe8938df6, 0x7ae59036, 0x9f84d87b, 0xc8710dc6, 0x249ee0f8, 0x46eeae2f, 0x66a3bb9b, 0xfeef4c6b, 0xc7b55eae, 0x7951dd0c, 0x0b4391e8, 0x141ad586, 0x1a568588, 0x908293dd, 0x472c0bea, 0x8d00abfe, 0xed17377f, 0x83a01efe};
uint32_t N_prime32[32] = 			{0xe7d41349, 0x0c828dcd, 0x2dc06d90, 0x318f87bf, 0x1992ba09, 0x4b1bef10, 0x011ba664, 0xe3a7d9cf, 0x44449fbd, 0x89714d34, 0x6cd49cc4, 0x49c5b99d, 0xf90435b1, 0x38f037b7, 0xba9720db, 0x9641b106, 0xbca01d2a, 0xfdb82893, 0xbd7ce9c7, 0x372823e1, 0x4901cdde, 0xaa28d457, 0xe9f78c94, 0xb6e1e5b3, 0x5a79f7a6, 0xf5212a83, 0x2b1aab45, 0xa3924b69, 0x3c63a8af, 0x12fa121d, 0x7500bea0, 0xe58878e7};
uint32_t expected_output32[32] = 	{0xeb7e3ef3, 0x40b90c4f, 0xd9c234b1, 0x2461cd34, 0x183481c7, 0x0bc4e5bd, 0x4803996e, 0x755d1777, 0x698f88c7, 0x2e78b03b, 0xa55cfb32, 0x74d1c12a, 0xc6bc8934, 0x581d4714, 0x7d504a58, 0xb29753f1, 0x99ae0c37, 0x65c4cc3a, 0x4153aacb, 0xe0a5c4bf, 0xce0a9c7c, 0x4babfb22, 0x75aa490d, 0x43b6ec25, 0xdcb17a10, 0x47deec3c, 0xd0e2735f, 0x16726b8e, 0x0f486246, 0x0f74d471, 0xe62a3577, 0x065a0397};


/*
// EXPONENTIATION TESTVECTORS
uint32_t X[16] = {0x7b8c972d, 0x8d53e828, 0x32c23195, 0x9372b2a4, 0xe606cb6c, 0xee29ae83, 0x562f9bcf, 0xdd874c23, 0x88eda03c, 0x1896bada, 0x5faeaec0, 0xd8b0d182, 0xeb5c8bc1, 0x3d6506f0, 0xcb7f2e9f, 0xeda6cba4};
uint32_t E[16] = {0x000000a7, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000};
uint32_t M[16] = {0xdcbcbfa9, 0x74224d21, 0x7d83160c, 0xbf60e00d, 0x7b990427, 0xabd5fa2c, 0x4d03f8be, 0xa76cf900, 0x2ec55f9c, 0x96c55c2f, 0x4345b5a2, 0x221ca99c, 0x6f5d1b99, 0xafdbe33d, 0x81c27763, 0x845e3450};
uint32_t EXPECTED[16] = {0xc4e9122c, 0xc6fab26f, 0x084bbdf4, 0x37da30d1, 0x1bd3e172, 0x0695959e, 0xa667d20f, 0x417a5266, 0x455d21ad, 0x780d02dc, 0xad3d8cd4, 0x89cf8bfc, 0x0e3344ae, 0xf3b2e137, 0xf751d796, 0x78460f46};
*/


int main()
{

    //int i;

    init_platform();
    init_performance_counters(1);
    interface_init();

    xil_printf("Startup..\n\r");

    START_TIMING

	// test_dma_transfer();

	// test_mp_add();

	// test_mp_sub();

	// test_mod_add();
    
    test_mont_mult();

    //test_mont_exp();
    //printMontExpResult(32);

	//test_hw_mont_mult();
   // printMontExpResult(16);


	// test_hw_mont_exp();


	//test_hw_mont_decrypt();
    //printMontExpResult(32);

    STOP_TIMING


    ////////////// Test the port-based communication //////////////

	//// --- Create and initialize src array

#if NUMBER_OF_CORES == 1
	// If NUMBER_OF_CORES == 1
	// then all 16 words defined below will be used to communicate with Core 1

	unsigned int src[DMA_TRANSFER_NUMBER_OF_WORDS]={
		0x00000000, 0x00000000, 0x01234567, 0x89abcdef,
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000000};
#else
    // If NUMBER_OF_CORES == 2
    // then 32 words will be defined,
    //      the words  0 to 15 will be used to communicate with Core 1
    //      the words 16 to 31 will be used to communicate with Core 2

    unsigned int src[DMA_TRANSFER_NUMBER_OF_WORDS]={
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x76543210, 0xfedcba98, 0x00000000, 0x00000000,

		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x89abcdef, 0x01234567, 0x00000000, 0x00000000};

    // If you need, you can use the src1 and src2 pointers
    // to access the src array defined above as two individual arrays.
    // src1 for the lower  16-words of the src array and
    // src2 for the higher 16-words
    unsigned int* src1 = src;
    unsigned int* src2 = src+16;
#endif
    //// --- Perform the send operation
//
//    // Start by writing CMD_READ to port1 (command port)
//    xil_printf("PORT1=%x\n\r",CMD_READ);
//    my_montgomery_port[0] = CMD_READ;
//
//    // Transfer the src array to BRAM
//    bram_dma_transfer(dma_config,src,DMA_TRANSFER_NUMBER_OF_WORDS);
//
//    // Wait for done of CMD_READ is done
//    // by waiting for port2 (acknowledgement port)
//    port2_wait_for_done();
//
//
//    //// --- Print BRAM contents
//
//    // For checking if send is successful
//    print_bram_contents();
//
//
////    //// --- Perform the compute operation
////
////    // Start by writing CMD_COMPUTE to port1 (command port)
////    xil_printf("PORT1=%x\n\r",CMD_COMPUTE);
////    my_montgomery_port[0] = CMD_COMPUTE;
////
////    // Wait for done of CMD_COMPUTE is done
////	// by waiting for port2 (aknowledgement port)
////    port2_wait_for_done();
//
//
//    //// --- Perform the read operation
//
//    // Start by writing CMD_WRITE to port1 (command port)
//    xil_printf("PORT1=%x\n\r",CMD_WRITE);
//    my_montgomery_port[0] = 5;
//
//    // Wait for done of CMD_WRITE is done
//    port2_wait_for_done(); //Wait until Port2=1
//
//
//    //// --- Print BRAM contents
//
//    // For receiving the read output of the computation
//    print_bram_contents();

    cleanup_platform();

    return 0;
}

//void test_mp_add() {
//	mp_add(a32, b32, result, 32);
//}
//
//void test_mp_sub() {
//	mp_sub(a32, b32, result, 32);
//}
//
//void test_mod_add() {
//	mod_add(a32, b32, N32, result, 32);
//}

void test_mont_mult() {

#define MULT_TESTVECTOR 1

	#if MULT_TESTVECTOR == 1

	uint32_t a[32] = {0xf484e847, 0x4ae251f1, 0xedfa617d, 0x58ab6bf4, 0x46bf4848, 0xf67c1061, 0x8811c17a, 0x578fde16, 0x493ee595, 0x1eafc4c3, 0xc4f11a2e, 0x8cb6fba7, 0x724c03a4, 0x2e6c1dbd, 0x57ebc43d, 0x3e6ee260, 0x4089c050, 0xf0384e03, 0x7357f72c, 0x87acb658, 0x7ea2490e, 0x61069112, 0x42e3f8b9, 0x9e778cef, 0x5cdf77c7, 0x10bce41c, 0x1121beec, 0x3db59a36, 0xc34620c5, 0xc6b030ae, 0xe8fc5934, 0x63a0a0cb};
	uint32_t b[32] = {0xfeb1b9f4, 0xe91d3bec, 0xfb09354d, 0x07f21d6d, 0x9ece9e1b, 0x18def18b, 0x4119e1e9, 0x55c85f24, 0x60ef0e23, 0x10e8ab54, 0x1e95cdcc, 0x4373912f, 0x6f42204d, 0x7126650d, 0xb61c1c8d, 0x98af9011, 0xa42c03b4, 0xd29e0870, 0x7923cb60, 0xdf87cfe5, 0xde4fffa0, 0x3ce537ca, 0x201040c6, 0x6e54b058, 0x814c53dc, 0xf16243f0, 0x57decf64, 0x8d0d4f37, 0x9b6d93e5, 0x45396d71, 0x615213c4, 0x65f89f9f};
	uint32_t N[32] = {0x4aeeb107, 0x5d78aa98, 0x6c55dd05, 0x6f5326c9, 0xf93f738c, 0xc10fa093, 0x20478120, 0x099d6d70, 0x833d9b82, 0x1248f3ed, 0xa43ed737, 0xc1c1da45, 0x9f23e5c7, 0xb17c3598, 0xe8938df6, 0x7ae59036, 0x9f84d87b, 0xc8710dc6, 0x249ee0f8, 0x46eeae2f, 0x66a3bb9b, 0xfeef4c6b, 0xc7b55eae, 0x7951dd0c, 0x0b4391e8, 0x141ad586, 0x1a568588, 0x908293dd, 0x472c0bea, 0x8d00abfe, 0xed17377f, 0x83a01efe};
	uint32_t n_prime[32] = {0xe7d41349, 0x0c828dcd, 0x2dc06d90, 0x318f87bf, 0x1992ba09, 0x4b1bef10, 0x011ba664, 0xe3a7d9cf, 0x44449fbd, 0x89714d34, 0x6cd49cc4, 0x49c5b99d, 0xf90435b1, 0x38f037b7, 0xba9720db, 0x9641b106, 0xbca01d2a, 0xfdb82893, 0xbd7ce9c7, 0x372823e1, 0x4901cdde, 0xaa28d457, 0xe9f78c94, 0xb6e1e5b3, 0x5a79f7a6, 0xf5212a83, 0x2b1aab45, 0xa3924b69, 0x3c63a8af, 0x12fa121d, 0x7500bea0, 0xe58878e7};
	uint32_t expected_output[32] = {0xeb7e3ef3, 0x40b90c4f, 0xd9c234b1, 0x2461cd34, 0x183481c7, 0x0bc4e5bd, 0x4803996e, 0x755d1777, 0x698f88c7, 0x2e78b03b, 0xa55cfb32, 0x74d1c12a, 0xc6bc8934, 0x581d4714, 0x7d504a58, 0xb29753f1, 0x99ae0c37, 0x65c4cc3a, 0x4153aacb, 0xe0a5c4bf, 0xce0a9c7c, 0x4babfb22, 0x75aa490d, 0x43b6ec25, 0xdcb17a10, 0x47deec3c, 0xd0e2735f, 0x16726b8e, 0x0f486246, 0x0f74d471, 0xe62a3577, 0x065a0397};

	#elif MULT_TESTVECTOR == 2

    uint32_t a[32] = {0x95401e33, 0xf2e5f538, 0xcd340e16, 0x5fe4fd66, 0xac500fe0, 0x748f18fe, 0xdad8575e, 0xce2058bb, 0x00c35266, 0xd51c8064, 0xfefeb38e, 0xc7ed29eb, 0xdb438313, 0x6550e48e, 0x02489732, 0xedaf8b6b, 0x5dd5313d, 0xa328f036, 0x419a784e, 0x23d635bb, 0x25143077, 0x48996382, 0xaa396499, 0xf24a2910, 0xb60ee4dc, 0xdfede44c, 0x69f174f6, 0x917d544c, 0x3c80aecf, 0xc90096c4, 0xc52a6c88, 0x07d92c14};
    uint32_t b[32] = {0xd7040630, 0xc765f25a, 0x4a7230d6, 0x395c2b8b, 0xaec10e86, 0xb62173f6, 0x72096da0, 0xc0ed3b81, 0x240e4293, 0xac5a2199, 0x5d05fed8, 0xadcae3e6, 0x22704082, 0x3b74cdb2, 0x51f0df68, 0xde5b7e6f, 0x66dc5f67, 0x0a836d5e, 0x32edcdb9, 0x4332989f, 0xedef232c, 0x25167785, 0x34d884aa, 0xfdf337de, 0xd7532d14, 0xa4b160f1, 0xf833b81c, 0xaa9589fb, 0xef7f7ade, 0x6ccff27d, 0x747a7bb0, 0x1f8042e7};
    uint32_t N[32] = {0xc6df4c85, 0x08e49be7, 0xe6f266e4, 0x450ca4b0, 0x028def7e, 0x3bdf79cf, 0xd3c65a9b, 0xd278192c, 0x08fd96bf, 0x5d635e17, 0xac3f28b1, 0x8449d487, 0xdd42688c, 0x61419fe8, 0x6b674328, 0x8f6bd9e2, 0x8e47420e, 0x94711c9e, 0x22f7165a, 0x2485755e, 0x61561df6, 0xf664e91d, 0xd97d05ce, 0xf221e0fd, 0xfd772f68, 0xf1856267, 0xe9041ac4, 0x2fd12fc8, 0x34b9220f, 0x695e5d77, 0x6b079c2c, 0x86ad4952};
    uint32_t n_prime[32] = {0x14d333b3, 0xc3b3be8f, 0x02ca4af0, 0xc43aba10, 0xde20e9cb, 0xc88222f9, 0x80860cc0, 0x315e4cf8, 0x0a2cc4f4, 0x16376d50, 0xcc1720b7, 0x8af0c35b, 0xc3ece9e9, 0x8f01dccc, 0x42d96568, 0xc02be3a4, 0x71e50c92, 0xb050887c, 0x4df93c3d, 0x75a13c65, 0xcd504fe2, 0x99ac5e4c, 0xc9f348e7, 0xb95f9a0e, 0xe170a1f0, 0x4769f246, 0x913001b4, 0xfc05df41, 0x63dc5efb, 0x9a863fbe, 0xc1f39f28, 0xf1295524};
    uint32_t expected_output[32] = {0xe4a627f2, 0x44ced61c, 0xb41445b2, 0x1deec41a, 0x00ec59c6, 0x366243e9, 0x8b3a5383, 0x293a279e, 0xb57482b8, 0x28a49995, 0xd5012ddd, 0xa1427bbf, 0xa4586c9c, 0x7df6bde0, 0x923e818c, 0xe215dbb8, 0x3a62ed6c, 0xe0f76529, 0x2d2936f3, 0x54e7fa14, 0x18022409, 0x6d5160c4, 0x998fe1c4, 0x86dab2c2, 0x46eda221, 0x6f93d1e2, 0xe9e57d26, 0xfb42688f, 0x679e9aa1, 0x6b70806a, 0x85d91b9f, 0x6a7decd7};

	#endif

	// Code Jasper semester 2 from montgomery2.c
	mont_mult(a, b, N, n_prime, result, 32);
	xil_printf("\n\r");

	xil_printf("Expected output: ");

	xil_printf("\n\r");

    printMontExpResult(32);

	// Code semester 1 from sw.c
	// montgomery_multiply(A16, B16, N16, N_prime16, result, 16);


}

void test_mont_exp() {

	mod_exp(M, e, e_len, N, N_prime, result);

	xil_printf("\n\r");

}

void test_hw_mont_mult() {
	hw_montgomery_multiply((unsigned int*) A16, (unsigned int*) B16, (unsigned int*) N16, (unsigned int*) result, 16);

}

//void test_hw_mont_exp() {
//	hw_mod_exp(Ct_p,d_p, d_p_len, p, Rp, R2p, result);
//}


void test_hw_mont_decrypt() {
	unsigned int Cp[16];
	unsigned int Cq[16];
	uint32_t Pp[16];
	uint32_t Pq[16];
	reduce_cipher((unsigned int*)result, Cp, Cq);
	uint32_t *nCp = (uint32_t*)Cp;
	uint32_t *nCq = (uint32_t*)Cq;
	hw_mod_exp(nCp, d_p,d_p_len, p, Rp, R2p, Pp);
	hw_mod_exp(nCq, d_q,d_q_len, q, Rq, R2q, Pq);
	combineResult(Pp, Pq, result);
}

void printMontExpResult(uint32_t size)
{
	int i;
	if (result[size-1] != 0) {
		xil_printf("Result:0x%x", result[size-1]);
	} else {
		xil_printf("Result: 0x");
	}
	for (i=size-2; i>=0; i--) {
		xil_printf("%08x", result[i]);
	}
	xil_printf("\n\r");
}
