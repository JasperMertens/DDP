#include <stdio.h>
#include <stdlib.h>

#include "xil_printf.h"
#include "xil_cache.h"

#include "platform/platform.h"
#include "platform/performance_counters.h"

#include "interface.h"
#include "sw.h"
#include "hw.h"

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

/*uint32_t a[32] = {0x4b0afbba, 0xb3270d27, 0xfef81247, 0x9c028fde, 0x873a8d9d, 0x74150080, 0x21c3a9a5, 0x04b6f5a7, 0x465ab66a, 0xf0af88c6, 0x4210ad08,
		0x3178b33b, 0x520fa2fe, 0xfabbcfe3, 0x51a66eb0, 0x1c1a6807, 0x57dc7837, 0x651c9e46, 0x21c0b44a, 0xaba36ace, 0x82f4820e, 0xf6a0e49f, 0xf489dab2,
		0x93df7bae, 0x74203419, 0xbd13b6fd, 0x4135e9f9, 0x046d1052, 0xc0a7108c, 0x191a0cc0, 0x607fc341, 0x2c261c9b};
uint32_t b[32] = {0xf1d2b3e2, 0x925c0577, 0x825c7977, 0x0cc1e17c, 0x179e2466, 0x0abf48a4, 0x839b99e3, 0x7b52c351, 0xc643edb7, 0x51c28d81, 0xdb0242ba,
		0x87069825, 0xb4e0aae5, 0x87b90b9b, 0x8026f877, 0xfd3b0911, 0x67498835, 0x9e56065e, 0x634a379e, 0xc2281d7e, 0x7793f6b9, 0x4a15cd7c, 0xd5d7c345,
		0xdf354cd4, 0x5dfdb200, 0x2a7f0547, 0x88da4e10, 0xedf5af44, 0x2982780e, 0x8ac21ffd, 0xb5118fec, 0x63a68886};
uint32_t n[32] = {0x575bb461, 0x1a3042d4, 0x95d708c1, 0x9a02f06b, 0x7582491e, 0x947f45f7, 0x6b785070, 0xa35e54c5, 0xba07c851, 0x29fb66a2, 0xd893feb0,
		0xa2ebe291, 0x08a64bd1, 0x5ab21338, 0xb451c21d, 0x330e7700, 0xa812c547, 0x633354b3, 0x9439c77f, 0x7de168b7, 0xd199da8f, 0x44fdd142, 0x8ce3e7f1,
		0xb807a6ae, 0x5173de8c, 0xe2fe1c98, 0x4d51689c, 0x5cfa7887, 0x54f0f9b9, 0x4b71a0e2, 0xbae33525, 0xb5d738a0};
uint32_t n0[32] = {0x16f2105f, 0xfdddd2ad, 0x95f75ac0, 0xa8c30990, 0xf655e370, 0x8720517c, 0x886839eb, 0xabeb253b, 0xdb6a3b3a, 0x6bf8258a, 0x3a62d68d,
		0x6a346d25, 0x208996eb, 0x217db098, 0xa2f73e93, 0x24b76402, 0xcd4545e4, 0x97a3727b, 0x7ab207b7, 0x913832ef, 0x9996349c, 0xda3718a1, 0xab631b76,
		0x694a7470, 0x93cb8bfa, 0x408f5cc3, 0xd34ef659, 0x57aa7bc7, 0xa1a8404b, 0x6730f4f7, 0xbb489ebf, 0x401b0f1d};*/


//uint32_t a[32] = {0x95401e33, 0xf2e5f538, 0xcd340e16, 0x5fe4fd66, 0xac500fe0, 0x748f18fe, 0xdad8575e, 0xce2058bb, 0x00c35266, 0xd51c8064, 0xfefeb38e,
//		0xc7ed29eb, 0xdb438313, 0x6550e48e, 0x02489732, 0xedaf8b6b, 0x5dd5313d, 0xa328f036, 0x419a784e, 0x23d635bb, 0x25143077, 0x48996382, 0xaa396499,
//		0xf24a2910, 0xb60ee4dc, 0xdfede44c, 0x69f174f6, 0x917d544c, 0x3c80aecf, 0xc90096c4, 0xc52a6c88, 0x07d92c14};
//uint32_t b[32] = {0xd7040630, 0xc765f25a, 0x4a7230d6, 0x395c2b8b, 0xaec10e86, 0xb62173f6, 0x72096da0, 0xc0ed3b81, 0x240e4293, 0xac5a2199, 0x5d05fed8,
//		0xadcae3e6, 0x22704082, 0x3b74cdb2, 0x51f0df68, 0xde5b7e6f, 0x66dc5f67, 0x0a836d5e, 0x32edcdb9, 0x4332989f, 0xedef232c, 0x25167785, 0x34d884aa,
//		0xfdf337de, 0xd7532d14, 0xa4b160f1, 0xf833b81c, 0xaa9589fb, 0xef7f7ade, 0x6ccff27d, 0x747a7bb0, 0x1f8042e7};
//uint32_t n[32] = {0xc6df4c85, 0x08e49be7, 0xe6f266e4, 0x450ca4b0, 0x028def7e, 0x3bdf79cf, 0xd3c65a9b, 0xd278192c, 0x08fd96bf, 0x5d635e17, 0xac3f28b1,
//		0x8449d487, 0xdd42688c, 0x61419fe8, 0x6b674328, 0x8f6bd9e2, 0x8e47420e, 0x94711c9e, 0x22f7165a, 0x2485755e, 0x61561df6, 0xf664e91d, 0xd97d05ce,
//		0xf221e0fd, 0xfd772f68, 0xf1856267, 0xe9041ac4, 0x2fd12fc8, 0x34b9220f, 0x695e5d77, 0x6b079c2c, 0x86ad4952};
//uint32_t n0[32] = {0x14d333b3, 0xc3b3be8f, 0x02ca4af0, 0xc43aba10, 0xde20e9cb, 0xc88222f9, 0x80860cc0, 0x315e4cf8, 0x0a2cc4f4, 0x16376d50, 0xcc1720b7,
//		0x8af0c35b, 0xc3ece9e9, 0x8f01dccc, 0x42d96568, 0xc02be3a4, 0x71e50c92, 0xb050887c, 0x4df93c3d, 0x75a13c65, 0xcd504fe2, 0x99ac5e4c, 0xc9f348e7,
//		0xb95f9a0e, 0xe170a1f0, 0x4769f246, 0x913001b4, 0xfc05df41, 0x63dc5efb, 0x9a863fbe, 0xc1f39f28, 0xf1295524};
//
//uint32_t A16[16] = {0x94e66799, 0x2e4e607b, 0x69f4fad8, 0x59950925, 0x682b963d, 0x9e69b23d, 0xa23d1bd6, 0x9ecc8fc5, 0xbb8a2c96, 0x50e1e2e2, 0xfc672add, 0x4d898bea, 0x6f80426c, 0x5bf3edb7, 0x86017e77, 0xac4dc7bb};
//uint32_t B16[16] = {0x130b66f2, 0xb527439e, 0x6e6b9105, 0xbcc66e92, 0x967964ff, 0x30d384a8, 0xd6e33767, 0xcd2d80ad, 0x1eb8c239, 0x2f765039, 0x90e82697, 0x0a757778, 0x3318a249, 0xd751e345, 0xd4d458dc, 0xc4ab58ff};
//uint32_t M16[16] = {0xe03f2b63, 0x81ced1fd, 0xe6958ab1, 0x9327c6e6, 0x8dfebe6c, 0x675b04b0, 0xdf54698f, 0x221998db, 0xc751ab45, 0xd436b45d, 0x4f28e19c, 0x8c2f3ea9, 0x17d13eec, 0xe2eceed0, 0x0d7d7434, 0xcab66a30};
//
//uint32_t X16[16] = {0xdfb05b9a, 0xd4f73696, 0x6064c433, 0xe2f51752, 0x1eed6717, 0x5bdcd415, 0xa6030b7d, 0xce089203, 0x2e6c07e7, 0xcd345006, 0x7d74adfe, 0x7a1fdb80, 0xd340041b, 0xb82b9c85, 0x7f9b9143, 0xd72e3dc4};
//uint32_t E16[16] = {0x000000c1, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000};
//uint32_t M16[16] = {0xb77c974b, 0xfbbf94ef, 0xe30230cb, 0x3838cc5e, 0x9eb83334, 0x59d2949c, 0x5f8e1b56, 0xdb5f704f, 0xa5a55c74, 0xd14a2d55, 0x92244210, 0xb1996dbe, 0x71d3ee98, 0x2eb58487, 0x078f03f6, 0xe44baeed};

//unsigned int Ciphertext[32] = {0xcf75855c, 0x363d1120, 0xed9bc58c, 0xb7d36d24, 0xdcaf7edb, 0x3a77762b, 0x5fa756f4, 0xccc4a942, 0x658982e1, 0xb1dd71d3, 0xf02b71e0, 0xb7cd5d72, 0x3b6498b9, 0xc71baf06, 0x44296c00, 0x23cf592d, 0xceb10409, 0x6e7d6f88, 0x00a72b34, 0x9cc0d8e6, 0x01f728ad, 0xe5d86b9b, 0x4f6c8138, 0x9946cf86, 0x396192d4, 0x8d5e6893, 0x78a6957b, 0xe64e8b6b, 0xd34040db, 0x94899f17, 0xa505c5af, 0x8a6be576};

//uint32_t A16[16] = {0xceb10409, 0x6e7d6f88, 0x00a72b34, 0x9cc0d8e6, 0x01f728ad, 0xe5d86b9b, 0x4f6c8138, 0x9946cf86, 0x396192d4, 0x8d5e6893, 0x78a6957b, 0xe64e8b6b, 0xd34040db, 0x94899f17, 0xa505c5af, 0x8a6be576};
//uint32_t B16[16] = {0xa4dc06c0, 0x62415ac9, 0x80e24f2f, 0x0478afb4, 0xa3a4a81b, 0xfe97da5b, 0xf36536b3, 0x16881a21, 0xb14eedde, 0x0d64faad, 0x03961e8a, 0xef375017, 0x3ad6ee04, 0xf27429b7, 0xe49e2914, 0x323d568c};
//uint32_t M16[16] = {0x620dd0f1, 0x224245ff, 0xd1147ed9, 0xdab39cdd, 0xa298a7da, 0x0a60a343, 0x83774f81, 0xb41fc8d4, 0x82c309a9, 0xf761eed7, 0x08f6cb25, 0xd37defa1, 0x4e7967cc, 0x5b20f7ff, 0x44d172b7, 0xc908f379};

//uint32_t Ct2l[16] = {0xcf75855c, 0x363d1120, 0xed9bc58c, 0xb7d36d24, 0xdcaf7edb, 0x3a77762b, 0x5fa756f4, 0xccc4a942, 0x658982e1, 0xb1dd71d3, 0xf02b71e0, 0xb7cd5d72, 0x3b6498b9, 0xc71baf06, 0x44296c00, 0x23cf592d};
//
//
//uint32_t a32[32] = {0xf484e847, 0x4ae251f1, 0xedfa617d, 0x58ab6bf4, 0x46bf4848, 0xf67c1061, 0x8811c17a, 0x578fde16, 0x493ee595, 0x1eafc4c3, 0xc4f11a2e, 0x8cb6fba7, 0x724c03a4, 0x2e6c1dbd, 0x57ebc43d, 0x3e6ee260, 0x4089c050, 0xf0384e03, 0x7357f72c, 0x87acb658, 0x7ea2490e, 0x61069112, 0x42e3f8b9, 0x9e778cef, 0x5cdf77c7, 0x10bce41c, 0x1121beec, 0x3db59a36, 0xc34620c5, 0xc6b030ae, 0xe8fc5934, 0x63a0a0cb};
//uint32_t b32[32] = {0xfeb1b9f4, 0xe91d3bec, 0xfb09354d, 0x07f21d6d, 0x9ece9e1b, 0x18def18b, 0x4119e1e9, 0x55c85f24, 0x60ef0e23, 0x10e8ab54, 0x1e95cdcc, 0x4373912f, 0x6f42204d, 0x7126650d, 0xb61c1c8d, 0x98af9011, 0xa42c03b4, 0xd29e0870, 0x7923cb60, 0xdf87cfe5, 0xde4fffa0, 0x3ce537ca, 0x201040c6, 0x6e54b058, 0x814c53dc, 0xf16243f0, 0x57decf64, 0x8d0d4f37, 0x9b6d93e5, 0x45396d71, 0x615213c4, 0x65f89f9f};
//uint32_t N32[32] = {0x4aeeb107, 0x5d78aa98, 0x6c55dd05, 0x6f5326c9, 0xf93f738c, 0xc10fa093, 0x20478120, 0x099d6d70, 0x833d9b82, 0x1248f3ed, 0xa43ed737, 0xc1c1da45, 0x9f23e5c7, 0xb17c3598, 0xe8938df6, 0x7ae59036, 0x9f84d87b, 0xc8710dc6, 0x249ee0f8, 0x46eeae2f, 0x66a3bb9b, 0xfeef4c6b, 0xc7b55eae, 0x7951dd0c, 0x0b4391e8, 0x141ad586, 0x1a568588, 0x908293dd, 0x472c0bea, 0x8d00abfe, 0xed17377f, 0x83a01efe};
//
//uint zero[32] = {0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000};
//
//uint32_t P_p[16] = {0xf386f6af, 0x1f1421bf, 0x73093d67, 0x5ed48386, 0x3b45a729, 0x2692eca4, 0x1763fa16, 0x614c9d55, 0xf7bd15a7, 0x0b2bcd38, 0x597648fe, 0xf670977f, 0x2d24a26b, 0x1feaf8dd, 0x695965c2, 0xa7e01d86};
//uint32_t Ct_p[16] = {0x5d2b54bb, 0x8fedf314, 0x2b521a7b, 0x3f7a1310, 0x9aeb4816, 0x2f173173, 0x56c3684e, 0xb1075bb6, 0xd7cf7067, 0x50d27449, 0x015401c5, 0x0f7aab71, 0xeb85a6f5, 0xa96627c9, 0x57a373bb, 0xae29d398};
//

int main()
{

    int i;

    init_platform();
    init_performance_counters(1);
    interface_init();

    xil_printf("Startup..\n\r");

    START_TIMING

	// test_dma_transfer();

	// test_mp_add();

	// test_mp_sub();

	// test_mod_add();

	// test_mont_mult();

    test_mont_exp();
    printMontExpResult(32);
	// test_hw_mont_mult();

	// test_hw_mont_exp();


	test_hw_mont_decrypt();
    printMontExpResult(32);

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

//void test_mont_mult() {
//
//	montgomery_multiply(a, b, n, n0, result, 32);
//
//	xil_printf("\n\r");
//
//}

void test_mont_exp() {

	mod_exp(M, e, e_len, N, N_prime, result);

	xil_printf("\n\r");

}

//void test_hw_mont_mult() {
//	hw_montgomery_multiply((unsigned int*) B16, (unsigned int*) B16, (unsigned int*) M16, (unsigned int*) result, 16);
//
//}
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
