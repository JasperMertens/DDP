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

def MontMul_512(A, B, M):
    # Returns (A*B*Modinv(R,M)) mod M
    C = 0
    for i in range(0,512):
        C = MultiPrecisionAdd(C, helpers.bit(A,i)*B, "add")
	if i < 10:
		print "iteration: ", i, " C: ", format(C, "02x")
        if (C % 2) == 0:
            C = C / 2;
	    if i < 10:
		print "shift: ", format(C, "02x")
        else:
            C = MultiPrecisionAdd(C, M, "add") / 2;
	    if i < 10:
	    	print "addshift: ", format(C, "02x")
    print "C >= M: ", C >= M
    while C >= M:
        C = MultiPrecisionAdd(C, M, "sub")
    return C


in_a = 0xb4d6d951f6532ac13ec6a44addbb552b3eca8fef9a81a1fd095485063c7ee4f89dcf19acf884fa9d0b6ce9c148e6b85af88024189c1da60e534acc6c7969363b
in_b = 0x86eb6f8babc25f0986ba7460e46ffd91f34532c114485075f85ff900d4cf71d918be9ef170e1b84bca67755131efcbb767a2e069ad68c321a1cb985909098399
in_m = 0xfe93fee7fd5d369339166e57cf5f773c1698c44b91a9f9a4be462bee6a82552d982845cd2787e90bc0245b4e781b9e1be10c615e2c814b3d85b78e358fa2c393
expected = 0x949031c785e1767b10ba755667f53317d8d5f1a90f417270509b2b297fbcb536f7e61b05ced28916eba6fedb32920cabbece7750fb6a1a21c943b46b9dad43f9

result = MontMul_512(in_a, in_b, in_m)

print "Result: ", format(result, "02x")
print "Expected: ", format(expected, "02x")
print "Error: ", expected-result
        
