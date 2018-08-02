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

# Testvector 0

#in_a = 0xb4d6d951f6532ac13ec6a44addbb552b3eca8fef9a81a1fd095485063c7ee4f89dcf19acf884fa9d0b6ce9c148e6b85af88024189c1da60e534acc6c7969363b
#in_b = 0x86eb6f8babc25f0986ba7460e46ffd91f34532c114485075f85ff900d4cf71d918be9ef170e1b84bca67755131efcbb767a2e069ad68c321a1cb985909098399
#in_m = 0xfe93fee7fd5d369339166e57cf5f773c1698c44b91a9f9a4be462bee6a82552d982845cd2787e90bc0245b4e781b9e1be10c615e2c814b3d85b78e358fa2c393
#expected = 0x949031c785e1767b10ba755667f53317d8d5f1a90f417270509b2b297fbcb536f7e61b05ced28916eba6fedb32920cabbece7750fb6a1a21c943b46b9dad43f9


# Testvector 2

#in_a = 0xf93e63a31fa57a5fe8e2ecd7cc9657037c1a5e007bcf23e5a60cd041f0ee66f7059efec3ece49feb3dab4bb1ad331ac6fd2c85dd29ea996c94a391033e673a62;
#in_b = 0xabee6fa6ade416c6cf101ccf6926cc8a1d10afbc02d219bcda52ceeaedf880b3e8516ff259d339d051bb54df25a5385e47b05cb4686b4f3231e260b25b024fd9;
#in_m = 0xa0f7d22d90093ce8e7210c4f7a48ba439dba03d40ddc9761161320ce9ff15cdacb07b47b2ef935433c3974fd93334b492eaf4f8a866f037933a18f810f26146f;
#expected = 0x0ab67db87ec68e882eb8c6e5276aaaffedc0ba10a7c427b07dd51b591f8a4d4da95c818f63f8f97d261690ff1cbba1f298e82f80f5a0a5103fe6550358281578;


# Testvector 3
#in_a = 0xc1e7a24fb38065dc02d0169985890870a3dada3d1c1a11f596cdf00309443f6425b7c296011651297587066629142e1d18f9caca158876fa78d999bcd3d975f5;
#in_b = 0xc28c67b947fbda048b61f4a7a8b898a1ec2262323bac7ccbdd4a2945e1278d08603b7ad11fe735d2d4f20dab63706bb69ddc095340a1deedb585983feff60cb8;
#in_m = 0x85043c00a323657b8b1b421888721ddda6fee5b443f4e3920ec0e8d961496ee7c1a6e0edbf97c8186ab20403110d58e3fc32af1f7ef8b302d75bc796ec62a577;
#expected = 0x0d2c7a007de6e0bcd84baa0c8614cb8168afa2004dc70c2e33b76c7b7f2aa091bdaa6004c70e5f40a63f74c43a5ddc95ecb7ac30de4742c452f8135cbb2a7955;

#in_a = helpers.getRandomInt(512)
#in_b = helpers.getRandomInt(512)
#in_m = helpers.getModulus(512)

in_a = 0x2266dfd35b839d9584e9fc9b4e477ea07805aeb64b029710631036650dd36d7730b2d4145d87835824e3ea8d142f7c624585659a308a06c405f1f9511d42803f
in_b = 0x8003892db22eb9a44895c40ff7762ea91dd74f61a794995ad7df83506fc8869d902465117950e42f80fc7d66235fb809c645678d0e6cfffbb4e8e9f7021f8195
in_m = 0x9f229799de5b7470cf4680b94f28b51f53b37c047b684396e1bd2b09c4504bb6deabef2cfe1921d42ccd5b786cb526527d4fecb79de5fd21d3d328e0c7cb40bb

result = MontMul_512_print(in_a, in_b, in_m)

print "in_a     <= 512'h", format(in_a, "02x")
print "in_b     <= 512'h", format(in_b, "02x")
print "in_m     <= 512'h", format(in_m, "02x")
print "expected     <= 512'h", format(result, "02x")

