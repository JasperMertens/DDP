import helpers
import SW

# Generate two primes (p,q), and modulus
[p,q,N] = helpers.getModuli(512)

# Generate Exponents
[e,d] = helpers.getRandomExponents(p,q) 

#print "Enc exp      = ", hex(e)               # 16-bits
#print "Dec exp      = ", hex(d)               # 1024-bits

# Generate Message
M     = helpers.getRandomMessage(1024,N)

#print "Message      = ", hex(M)               # 512-bits


#print "p            = ", hex(p)               # 512-bits
#print "q            = ", hex(q)               # 512-bits
#print "Modulus      = ", hex(N)               # 1024-bits

R       = 2**1024
R_1024  = R % N
R2_1024 = (R*R) % N

#print "R_1024       = ", hex(R_1024)          # 1024-bits
#print "R2_1024      = ", hex(R2_1024)         # 1024-bits

C = SW.MontMul_1024(M, R2_1024, N)
#print "X_tilde     = ", hex(C)               # 1024-bitszz


# Testvector 1
#X                =  0xb5ae5a31a58bcf344a56f872c5ba985d8a77b00f6c697fc16f11d1e7899f4c96fc86f2c3e4846107363d419155ed6d29c5cd87935cd05020ee8959a49c3c69f4L
#E                =  0xe8
#M                =  0xb955d9c7150e2e03d76bcd39834da958e9023729912b662f8d677e0dbd473bd61aed5391d5f6a936f8215aca4c5746dc076d2a5d2e36be04e6cbced67d946d85L
#expected	  =  0x64ee3fd57fa7ddcd9083bf3ffffad952c693667cd94b23341ac9f64f53df68069486449f92a9155259dc47bac6901639a2d268b2529d982441c2e438f75084c2L

# Testvector 2
#X                =  0x1c836853ffc0b7389a5824e5472d5f9cf5e2e949e805b057d77af168365232bd1b80c645f321f2dae93b3a0ea844ad2f7d90773f79abcdd4cfa2f28ee1e4acacL
#E                =  0x86
#M                =  0xb3688c5d2cc56478044ed0f3d2b070b2355adcd9ea0a26636d5187ccf69d061d0264007a824258be9c1b31c1dbe25735f2af5e4246d46d3e8d90319747bb976dL
#expected	  =  0xab96e8e6f23948c35faed2c71f9b8f85c405fe12099a7a3a2bd8dde217a20e1b6d4cc1cecd7e4c08d0af1219244186b59d66ae39cc05a3a99dcee2dd73138981L

M = helpers.getModulus(1024)
X = helpers.getRandomInt(1024)%M
exp_len = 16
E = helpers.getRandomInt(exp_len)
r = 2**1024                      
M_prime = (r - helpers.Modinv(M, r))

R = 2**1024 % M
R2 = R*R % M

#C = MontExp_512(X, E, M)
C = helpers.Modexp(X, E, M)
D = helpers.Modexp(X, E, M)
e = C - D

#print "X                = ", hex(X)           # 512-bits
#print "E                = ", hex(E)           # 8-bits
#print "M                = ", hex(M)           # 512-bits
#print "R                = ", hex(R)           # 512-bits
#print "R2               = ", hex(R2)          # 512-bits
#print "exp_len		= ", exp_len
#print "expected		= ", hex(C)           # 512-bits
#print "(X^E) mod M      = ", hex(D)           # 512-bits
#print "error            = ", hex(e)   

print
print "uint32_t X[32] = {" + helpers.WriteConstants(X,32) + "};"
print "uint32_t E[1] = {" + helpers.WriteConstants(E,1) + "};"   
print "uint32_t M[32] = {" + helpers.WriteConstants(M,32) + "};"
print "uint32_t M_prime[32] = {" + helpers.WriteConstants(M_prime,32) + "};"
print "uint32_t R[32] = {" + helpers.WriteConstants(R,32) + "};" 
print "uint32_t R2[32] = {" + helpers.WriteConstants(R2,32) + "};"  
print "uint32_t exp_len = ", exp_len, ";"
print "uint32_t expected_output[32] = {" + helpers.WriteConstants(D,32) + "};"
print

