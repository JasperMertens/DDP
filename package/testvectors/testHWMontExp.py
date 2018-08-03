import helpers

# Here we implement the three functions 
# that we implement in the hardware lab sessions.

# The mongomery multiplication, and exponentiation
# follow the pseudo code given in the slides,
# so that if needed students can debug
# their code by printing the intermediate values.

def MultiPrecisionAdd(A, B, addsub):
    # returns (A + B) mod 2^514 if   addsub == "add"
    #         (A - B) mod 2^514 else
    
    mask514  = 2**514 - 1
    mask515  = 2**515 - 1

    am     = A & mask514
    bm     = B & mask514

    if addsub == "add": 
        r = (am + bm) 
    else:
        r = (am - bm)
    
    return r & mask515  

def MontMul_512_print(A, B, M):
    # Returns (A*B*Modinv(R,M)) mod M
    C = 0
    for i in range(0,512):
        C = MultiPrecisionAdd(C, helpers.bit(A,i)*B, "add")
	if i < 10 or i == 511:
		print "iteration: ", i, " C: ", format(C, "02x")
        if (C % 2) == 0:
            C = C / 2;
	    if i < 10 or i == 511:
		print "shift: ", format(C, "02x")
        else:
            C = MultiPrecisionAdd(C, M, "add") / 2;
	    if i < 10 or i == 511:
	    	print "addshift: ", format(C, "02x")
    print "C >= M: ", C >= M
    if C >= M:
        C = MultiPrecisionAdd(C, M, "sub")
    return C

def MontMul_512(A, B, M):
    # Returns (A*B*Modinv(R,M)) mod M
    C = 0
    for i in range(0,512):
        C = MultiPrecisionAdd(C, helpers.bit(A,i)*B, "add")
        if (C % 2) == 0:
            C = C / 2;
        else:
            C = MultiPrecisionAdd(C, M, "add") / 2;
    if C >= M:
        C = MultiPrecisionAdd(C, M, "sub")
    return C

def MontExp_512(X, E, M):
    # Returns (X^E) mod M
    R  = 2**512
    R2 = (R*R) % M;
    A  = R % M;
    X_tilde = MontMul_512(X,R2,M)
    t = helpers.bitlen(E)
    for i in range(0,t):
        A = MontMul_512(A,A,M)
        if helpers.bit(E,t-i-1) == 1:
            A = MontMul_512(A,X_tilde,M)
	#if i >= 505:
    	#print "uint32_t A_test = {" + helpers.WriteConstants(A,16) + "};"
	#print " "
    A = MontMul_512(A,1,M)
    return A

# Testvector 1
#X                =  0xb5ae5a31a58bcf344a56f872c5ba985d8a77b00f6c697fc16f11d1e7899f4c96fc86f2c3e4846107363d419155ed6d29c5cd87935cd05020ee8959a49c3c69f4L
#E                =  0xe8
#M                =  0xb955d9c7150e2e03d76bcd39834da958e9023729912b662f8d677e0dbd473bd61aed5391d5f6a936f8215aca4c5746dc076d2a5d2e36be04e6cbced67d946d85L
#expected	  =  0x64ee3fd57fa7ddcd9083bf3ffffad952c693667cd94b23341ac9f64f53df68069486449f92a9155259dc47bac6901639a2d268b2529d982441c2e438f75084c2L

# Testvector 2
X                =  0x1c836853ffc0b7389a5824e5472d5f9cf5e2e949e805b057d77af168365232bd1b80c645f321f2dae93b3a0ea844ad2f7d90773f79abcdd4cfa2f28ee1e4acacL
E                =  0x86
M                =  0xb3688c5d2cc56478044ed0f3d2b070b2355adcd9ea0a26636d5187ccf69d061d0264007a824258be9c1b31c1dbe25735f2af5e4246d46d3e8d90319747bb976dL
expected	  =  0xab96e8e6f23948c35faed2c71f9b8f85c405fe12099a7a3a2bd8dde217a20e1b6d4cc1cecd7e4c08d0af1219244186b59d66ae39cc05a3a99dcee2dd73138981L

#M = helpers.getModulus(512)
#X = helpers.getRandomInt(512)%M
exp_len = 8
#E = helpers.getRandomInt(exp_len)

R = 2**512 % M
R2 = R*R % M

C = MontExp_512(X, E, M)
D = helpers.Modexp(X, E, M)
e = C - D

print "X                = ", hex(X)           # 512-bits
print "E                = ", hex(E)           # 8-bits
print "M                = ", hex(M)           # 512-bits
print "R                = ", hex(R)           # 512-bits
print "R2               = ", hex(R2)          # 512-bits
print "exp_len		= ", exp_len
print "expected		= ", hex(C)           # 512-bits
print "(X^E) mod M      = ", hex(D)           # 512-bits
print "error            = ", hex(e)   


print "uint32_t X[16] = {" + helpers.WriteConstants(X,16) + "};"
print "uint32_t E[16] = {" + helpers.WriteConstants(E,16) + "};"   
print "uint32_t M[16] = {" + helpers.WriteConstants(M,16) + "};"
print "uint32_t R[16] = {" + helpers.WriteConstants(R,16) + "};" 
print "uint32_t R2[16] = {" + helpers.WriteConstants(R2,16) + "};"  
print "uint32_t exp_len = ", exp_len, ";"
print "uint32_t expected[16] = {" + helpers.WriteConstants(D,16) + "};"

