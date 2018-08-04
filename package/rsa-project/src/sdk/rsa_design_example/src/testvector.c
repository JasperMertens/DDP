#include <stdint.h>                                              
                                                                 
// This file's content is created by the testvector generator    
// python script for seed = 2017.3                    
//                                                               
//  The variables are defined for the RSA                        
// encryption and decryption operations. And they are assigned   
// by the script for the generated testvector. Do not create a   
// new variable in this file.                                    
//                                                               
// When you are submitting your results, be careful to verify    
// the test vectors created for seed = 2017.1, to 2017.5         
// To create them, run your script as:                           
//   $ python testvectors.py crtrsa 2017.1                       
                                                                 
// message                                                       
uint32_t M[32] = {0x6e739c22, 0xdbe16ed2, 0xa644a957, 0x40f5be28, 0xf23afbdb, 0x5662ec2b, 0x8c3d657e, 0x4a372f4c, 0x1a549146, 0x3c8ab66d, 0x46734d3a, 0x5ea17988, 0xd755c531, 0xfb880604, 0x11f9d0e4, 0xcce8093a, 0x1ceafa7a, 0x59fd0a27, 0xadea3d19, 0xda82ed4d, 0x6e5a2040, 0x961d7797, 0x5b60be9f, 0xb60e6c87, 0x9a273777, 0x13542145, 0x9e91b142, 0x629166c9, 0x1a7063db, 0x7faac25b, 0xa947fa08, 0x8460bf08};                 
                                                                 
// prime p and q                                                 
uint32_t p[16] = {0xc1ee023b, 0x6098c025, 0x251f41b3, 0xa0abd045, 0x0da8eb9e, 0x98c0fd80, 0x7613d922, 0xa1eda428, 0x20abd55a, 0xfb9f5284, 0x2db2a2a4, 0x83e1da2b, 0x6a484bbc, 0x9212b0f1, 0x5c73d816, 0xec861af5};                 
uint32_t q[16] = {0xa2d5817f, 0xf0a0a54a, 0x8737259d, 0xf116a7f6, 0xa706aee9, 0xb58811b0, 0xb6593c76, 0x5ea06244, 0xc79518a6, 0x1dbbd459, 0x9b18c44c, 0x47e4ec17, 0xe2f79e20, 0x29fae7ce, 0x904fbedf, 0x95d3f2b6};                 
                                                                 
// modulus                                                       
uint32_t N[32]       = {0x5549d645, 0xd3d9fdf3, 0x225c2149, 0x4c531e80, 0xd5b7299c, 0xd76da169, 0x820de4c1, 0xc9bff8b4, 0x235cef54, 0x08411cbf, 0xfa43d001, 0xc3ddfd73, 0x13ba236c, 0xf65601a1, 0xa2501e4e, 0xf1e43ac6, 0xba296be0, 0xb636e116, 0xa6457545, 0xca3bc8ca, 0xaeb4ea14, 0xc2e8e45d, 0x2ff40aaa, 0xbf6bb67e, 0x8adeecdb, 0x0209c92a, 0xb2f6520f, 0x56d6d7c9, 0x8a2b5d07, 0x8795cf9f, 0x7932d8fb, 0x8a6de078};           
uint32_t N_prime[32] = {0x42613373, 0x16fbf2bf, 0x755c6f84, 0x8af35835, 0xf3478c5e, 0xe5064d5c, 0x0e6835d9, 0xbab1330b, 0x69303fb3, 0x407ac480, 0xee4ec7a6, 0xefa554cb, 0x651b3556, 0xd9bc3256, 0xd2d001db, 0xa5bde1b1, 0x329d7adc, 0x6e7bfde0, 0x4cb20a53, 0xa6b29a21, 0x7d8cb659, 0x776db4d8, 0xe5d6c8cf, 0xa6efcdfa, 0xb84ed2c7, 0xd8db3f0c, 0xbf57ea0e, 0xda1afdd2, 0xa730c0d2, 0x6a1f2423, 0x3cec9e63, 0x8e43b411};     
                                                                 
// encryption exponent                                           
uint32_t e[32] = {0x0000de4f};                  
uint32_t e_len = 16;                                             
                                                                 
// decryption exponent, reduced to p and q                       
uint32_t d_p[16] = {0x066fd801, 0x8c023677, 0xeaf8a045, 0x3944403c, 0x76e52e4b, 0x15d29718, 0x0fa5467d, 0x6efddff7, 0x836e7bc6, 0x583aa15a, 0x085119ca, 0x1e4032e9, 0x546f7aef, 0xf05141a6, 0xade9e4ee, 0x8ea5be2c};             
uint32_t d_q[16] = {0xe671d411, 0x1a82d79c, 0x4f1d1889, 0x3b1139f5, 0x4e593ad2, 0xbb75b7ad, 0x50c88ff7, 0x68cef825, 0xe09bac23, 0xdc99ef52, 0x0d2864e4, 0x677df3f7, 0xdbd12bce, 0x69ee5be5, 0xc4446fbf, 0x00c2c687};             
uint32_t d_p_len =  512;
uint32_t d_q_len =  504;
                                                                 
// x_p and x_q                                                   
uint32_t x_p[32] = {0x96ba9d2a, 0x6a05ec87, 0xd209efcf, 0xccc9ac26, 0x89e7f3de, 0x9d948c25, 0x3a62817b, 0x1847fd0a, 0x2ddfb836, 0xc9f6b1b5, 0xa6b28506, 0x27ff645f, 0x6a3c997c, 0xedbcd79f, 0x71e8a502, 0xdf91554c, 0xb47d7a8f, 0xf9cc584d, 0x809f68ab, 0x537472d6, 0x2b0d638e, 0xb15a9245, 0x44aa8690, 0x2d345631, 0xcd85ca06, 0xeb48d3c1, 0x877ac57c, 0x1202496f, 0x60f03b4f, 0x3d569746, 0xcdd268e3, 0x0274cdd5};             
uint32_t x_q[32] = {0xbe8f391c, 0x69d4116b, 0x5052317a, 0x7f897259, 0x4bcf35bd, 0x39d91544, 0x47ab6346, 0xb177fbaa, 0xf57d371e, 0x3e4a6b09, 0x53914afa, 0x9bde9914, 0xa97d89f0, 0x08992a01, 0x3067794c, 0x1252e57a, 0x05abf151, 0xbc6a88c9, 0x25a60c99, 0x76c755f4, 0x83a78686, 0x118e5218, 0xeb49841a, 0x9237604c, 0xbd5922d5, 0x16c0f568, 0x2b7b8c92, 0x44d48e5a, 0x293b21b8, 0x4a3f3859, 0xab607018, 0x87f912a2};             
                                                                 
// R mod p, and R mod q, (R = 2^512)                             
uint32_t Rp[16] = {0x3e11fdc5, 0x9f673fda, 0xdae0be4c, 0x5f542fba, 0xf2571461, 0x673f027f, 0x89ec26dd, 0x5e125bd7, 0xdf542aa5, 0x0460ad7b, 0xd24d5d5b, 0x7c1e25d4, 0x95b7b443, 0x6ded4f0e, 0xa38c27e9, 0x1379e50a};               
uint32_t Rq[16] = {0x5d2a7e81, 0x0f5f5ab5, 0x78c8da62, 0x0ee95809, 0x58f95116, 0x4a77ee4f, 0x49a6c389, 0xa15f9dbb, 0x386ae759, 0xe2442ba6, 0x64e73bb3, 0xb81b13e8, 0x1d0861df, 0xd6051831, 0x6fb04120, 0x6a2c0d49};               
                                                                 
// R^2 mod p, and R^2 mod q, (R = 2^512)                         
uint32_t R2p[16] = {0x88db05cb, 0xcb758dc7, 0x3222f2b3, 0xe0b1d82a, 0xbc7e4dba, 0x04fa82c3, 0xea5f5169, 0x36dd4a99, 0x31b79254, 0x279750e9, 0x6b4b0901, 0x29c9c804, 0x59c36709, 0x223e9ed2, 0xbe052e02, 0x31026ee3};             
uint32_t R2q[16] = {0xa317b51e, 0x3a090a62, 0x3a9e600a, 0xefc5eca9, 0xb0093520, 0xd3a08ddc, 0x63f65d84, 0x2d47d284, 0x5d15908a, 0xa9db254e, 0xad5c5894, 0x9a055342, 0x1d9d6363, 0x2f543f58, 0xb01b19a2, 0x32a3f86b};             
                                                                 
// R mod N, and R^2 mod N, (R = 2^1024)                          
uint32_t R_1024[32]  = {0xaab629bb, 0x2c26020c, 0xdda3deb6, 0xb3ace17f, 0x2a48d663, 0x28925e96, 0x7df21b3e, 0x3640074b, 0xdca310ab, 0xf7bee340, 0x05bc2ffe, 0x3c22028c, 0xec45dc93, 0x09a9fe5e, 0x5dafe1b1, 0x0e1bc539, 0x45d6941f, 0x49c91ee9, 0x59ba8aba, 0x35c43735, 0x514b15eb, 0x3d171ba2, 0xd00bf555, 0x40944981, 0x75211324, 0xfdf636d5, 0x4d09adf0, 0xa9292836, 0x75d4a2f8, 0x786a3060, 0x86cd2704, 0x75921f87};     
uint32_t R2_1024[32] = {0xa2f16189, 0x3aa0407e, 0xebec4b87, 0xacc21419, 0x4e9d5a98, 0x3dabad50, 0x9a7c1aba, 0xf5cca7c9, 0xd0c6d597, 0xdfe040fc, 0xf74d6160, 0x2bf4cb41, 0x5546a2af, 0x3bbad324, 0x1671c5c4, 0x9d6dbe0a, 0xcec947e4, 0xaf2dd772, 0x95443cbb, 0x5f20e82d, 0x98ea1e42, 0xd3b6473e, 0x22fdebd3, 0xc7eaddd9, 0x8912afc8, 0x83841b0a, 0x0854d2f0, 0x73802596, 0x55eb2e55, 0x5f24288c, 0x64048141, 0x157a58e5};     
                                                                 
// One                                                           
uint32_t One[32] = {1,0};                                        
                                                                 
///////////////// FOR VERIFICATION //////////////////            
                                                                 
// Ciphertext, input of hardware decryption                      
uint32_t Ciphertext[32]  = {0x5c4ae7ef, 0x7818120d, 0xc9f59bfb, 0x9de26703, 0x640cfe7c, 0x71117d89, 0x7fa54ad8, 0xf6f88d5d, 0x1aae2b25, 0xfba46d79, 0x97b92856, 0x4552ed66, 0x132f651a, 0x28bb3a2e, 0xc28deeb4, 0x47c735a3, 0xb5416dc2, 0xe5b8dc22, 0xe00a3116, 0xa968a6e1, 0x39b79cbb, 0x7155ca59, 0xe1973c8b, 0x6d10b6d5, 0x7392aa3f, 0x4ce8fce7, 0x61588928, 0xf04a038b, 0xf8d389d3, 0xf1360f67, 0xc1fde623, 0x74c25c39};     
                                                                 
// Ciphertext_p and Ciphertext_q, output of reduction            
uint32_t Ciphertext_p[16]  = {0xe3b12a17, 0x907675c6, 0x25d4b63e, 0x9b0cbdca, 0x497c264f, 0x71e82ae8, 0x51802565, 0xb2384ef2, 0x8568d20f, 0xc3f420a1, 0x4abee6ae, 0x29f002bc, 0x8574e0b7, 0xbcd3d845, 0x3975a426, 0xe01a3a03};  
uint32_t Ciphertext_q[16] = {0xf6da99b1, 0xf2d1d674, 0x75cd8200, 0xeffe1776, 0xe629fa6d, 0xa5944e17, 0xd6869501, 0x5c94efbd, 0x5ef7ffaf, 0x99c7864c, 0xb171d1d5, 0x8aadf50b, 0x55766800, 0x72153c0f, 0x93a84cb9, 0x0d5a9909};   
                                                                 
// Plaintext_p and Plaintext_q, output of exponentiation         
// (needs to be allocate space for 32 words to combine correctly)
uint32_t Plaintext_p[32]  = {0x1f368c40, 0x968ae47f, 0x2171c538, 0x251b448d, 0x63882a87, 0xa22a339a, 0x5f68d368, 0x0eee29f8, 0xf41bd6a4, 0xd3d16cc1, 0x308d4a5d, 0x2145b41b, 0x8d970b3b, 0x3d580057, 0xa3746fbd, 0xebd43e67};    
uint32_t Plaintext_q[32] = {0x91523e17, 0x3384ae39, 0x72fd7dd1, 0x6a54c05a, 0x64b0c7f6, 0x63be5065, 0xaaffc941, 0x47facb12, 0xbe4f8511, 0xcf170b83, 0xb3167bc8, 0xf473289f, 0x5bac3729, 0xe51b917a, 0x2149f9ac, 0x35f7f182};     
                                                                 
// Plaintext, output of hardware decryption                      
uint32_t Plaintext[32]  = {0x6e739c22, 0xdbe16ed2, 0xa644a957, 0x40f5be28, 0xf23afbdb, 0x5662ec2b, 0x8c3d657e, 0x4a372f4c, 0x1a549146, 0x3c8ab66d, 0x46734d3a, 0x5ea17988, 0xd755c531, 0xfb880604, 0x11f9d0e4, 0xcce8093a, 0x1ceafa7a, 0x59fd0a27, 0xadea3d19, 0xda82ed4d, 0x6e5a2040, 0x961d7797, 0x5b60be9f, 0xb60e6c87, 0x9a273777, 0x13542145, 0x9e91b142, 0x629166c9, 0x1a7063db, 0x7faac25b, 0xa947fa08, 0x8460bf08};        