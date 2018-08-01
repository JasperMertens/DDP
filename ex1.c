#include <stdio.h>
#include <stdint.h>

void customprint(unsigned char* in);

main(){
    int a;
    unsigned char b;
    int *c;				///this is a pointer

    int a_ar[10];
    int b_ar[]={1, 2, 3, 4};

    int i;
    int sum;
    uint64_t mult;

    uint32_t d=0xCC8A79EE;
    uint32_t e=0x12234501;
    uint32_t f[2];

    unsigned char aa[]={0x12, 0x23, 0x45, 0x78};
    unsigned char bb[]={0x9A, 0xBC, 0xDE, 0xF0};
    unsigned char cc[4];

    unsigned char or1[]={0xaa, 0xaa, 0xaa, 0xaa};
    unsigned char or2[]={0xbb, 0xbb, 0xbb, 0xbb};


	/**
	 *  dereference: the * operator returns the value a pointer is pointing at
	 *  reference:   the & operator returns the address of a variable/pointer (location)
	 **/

	printf("value of a =%x\n", a);
 	/**
   * TASK 1: compilation and initializations
   *  Compile the programm:
	*		open the Terminal: assuming you use gedit as editor, click on Terminal (at the very bottom)
	*		type in the Terminal: gcc ex1.c -o main
	*	Run the program:
	*		type in the Terminal: ./main
   *  Why do we get such a weird value for a?
   **/
	
 	/**
   * TASK 2
   * Uncoment the following code.
   * Write code that prints the value and the address of a, b and c.
   * For c also write a statement that prints the value c is pointing at.
   **/
	a = 123;
	b = 0x55;
	c=&a; //c points to a
	printf("a =%d, b =%x, c =%p\n", a,b,c);
	printf("value of c = %d\n", *c);

    /**
     * TASK 3
 	 * 1) initialize a_ar with a_ar[i]=i^2 (use a loop)

	 * 2) calculate the sum of the values in b_ar
     *   You may want to create a extra variable for the sum
     */
	for (i=0; i<10; i++) {
		a_ar[i] = i*i;
	}
	sum=0;
	for (i=0; i<4; i++) {
		sum += b_ar[i];
	}
	printf("sum= %d\n", sum);

    //TASK 4
	/*
	 * Arrays are also pointers.
         * 1) Find out the address of a_ar, b_ar, a_ar[0], and b_ar[0]
         *
	 * 2) Find out where a_ar[1] and b_ar[1] are located (address).
	 * What about the delta between a_ar[0] and a_ar[1] resp. b_ar[0] and b_ar[1]?
	 * 3) Calculate the sum of the values in b_ar without using the square braces '[' or ']'.
	 * use instead the * operator and pointer arithmetic.
	 */
	printf("a_addr= %p, b_addr= %p, a0_addr= %p, b0_addr= %p\n", 
		a_ar, b_ar, &(a_ar[0]), &(b_ar[0]));
	printf("a1_addr= %p, b1_addr= %p\n", &a_ar[1], &b_ar[1]);
	sum=0;
	for (i=0; i<4; i++) {
		sum += *(b_ar + i);
	}
	printf("sum= %d\n", sum);


    //TASK 5
	/**
     * Compute d*e and put lower 32 bits in f[0] and higher 32 bits in f[1]
     * Hint: use casting
	 **/
    mult = (uint64_t)d*(uint64_t)e;
	f[0] = (uint32_t)mult;
	f[1] = mult >> 32;
	printf("mult= %x, lower= %x, higher= %x\n", mult, f[0], f[1]);

    //TASK 6
    /**
     * Write a function sum that calculates the bytewise sum of aa and bb and saves it in cc.
     * You don't have to account for the carry.
     * Print cc with 'customprint' function.

     * */
	for (i=0; i<4; i++) {
		cc[i] = aa[i]+bb[i];
	}
	customprint(cc);
    //TASK 7
    /**
     * Uncomment then compile and run.
     * Explain the values you see in output
     * Use grep:
     *  grep will filetr output and olnly show lines that contain 'aa'
     *  ./main | grep aa
     **/
     for (i = 0; i < 20; i++) {
        printf("or2[%d]=%x\n", i, or2[i]);
     }
}


void customprint(unsigned char *in)
{
    int i;
    printf("\ninput= ");
    for (i = 0; i < 4; i++) {
        printf("%x", in[i]);
    }
    printf("\n");
}
