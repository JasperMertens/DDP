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

in_a = 0xb4d6d951f6532ac13ec6a44addbb552b3eca8fef9a81a1fd095485063c7ee4f89dcf19acf884fa9d0b6ce9c148e6b85af88024189c1da60e534acc6c7969363b
in_b = 0x86eb6f8babc25f0986ba7460e46ffd91f34532c114485075f85ff900d4cf71d918be9ef170e1b84bca67755131efcbb767a2e069ad68c321a1cb985909098399
in_m = 0xfe93fee7fd5d369339166e57cf5f773c1698c44b91a9f9a4be462bee6a82552d982845cd2787e90bc0245b4e781b9e1be10c615e2c814b3d85b78e358fa2c393
expected = 0x949031c785e1767b10ba755667f53317d8d5f1a90f417270509b2b297fbcb536f7e61b05ced28916eba6fedb32920cabbece7750fb6a1a21c943b46b9dad43f9

# Testvector 1

#in_a = 0xa84ff2f71071936d568335f4e31da1c104c831dc18d7b9199f5d96b9df7315bd0fa8db7a6201cf9ae0842c7f6797a025684296de2089f536c18b7a583c7a9fc5
#in_b = 0xb9cf554dbc2f7d876274c0895b10c21a0322d9435a2cd1af43a483a61f7cfb92f984df1a0d9357bc796f8e582427a609d99348f8079de7731fc8a31b3eea6c6e
#in_m = 0xef449a8c29c1266af559bdb8d0c42c042b9a46f619b28d7094369f2842ebe42175eb00442338301d1a509aef69043c1dee3bc1f3a06da74e54d094bc7e4ec49b
#expected = 0x989c4842b4d4e09c463ce7eb282963433113fc4f59dd86fc94ae85db3a992a9da4d38f4aaf9c263810e38ba8969c21e32857163a64deb38db64bb0c957fd0578



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

# Testvector 5
#in_a = 0x2266dfd35b839d9584e9fc9b4e477ea07805aeb64b029710631036650dd36d7730b2d4145d87835824e3ea8d142f7c624585659a308a06c405f1f9511d42803f
#in_b = 0x8003892db22eb9a44895c40ff7762ea91dd74f61a794995ad7df83506fc8869d902465117950e42f80fc7d66235fb809c645678d0e6cfffbb4e8e9f7021f8195
#in_m = 0x9f229799de5b7470cf4680b94f28b51f53b37c047b684396e1bd2b09c4504bb6deabef2cfe1921d42ccd5b786cb526527d4fecb79de5fd21d3d328e0c7cb40bb
#expected = 0x28656b6ac06697daea4f6457ecfe574b6ffdb6a23c207f3ccf1505a68369b89a6525d5abb19da641a64b33059a5ff0196204bcc35a39bd6b7c02b0c0aab8e1a

#Testvector 6 (as in main.c)
#in_a = 0xC51931A952132EF036D3028F13CBFD6B806B8CAC22E43D058B7D54CAC8AE12C74DCC390705C0A4A8AB8E05261FAD952504561A829F030FBD7957B1BE51977946
#in_b = 0xB220F8C0CA83B6555F0012CCCB4FBA56E3D5644598E985D3154A73DE20669791C57840133D61E9143548FEF68B55AF12C0810A9F2D5929F796DEC8945FC3D1EF
#in_m = 0xC6BB131B105D393E10943525C871A4DE28470C406AE0754B0A3BE041AA19906F2E3B3A4CCEA1ED9F052304AF6ED897F20F02D0B458727656948CB7AB0EBD5F75
#expected = 0x9712A9297E49F069DA554D8DC901B64C4C2446883F359F29B6DF247F7B232EC666DD18B8FD0D421A5370EAE758B4D35BFFE854D55E453A5AE265CBB79E31EA81

# Testvector 7
#in_a = 0x8e99981827cc58bec9022bad1285dd240b1ff924f0acb0d06ac46232a53b20f07786425f65f0c2fce8a63fffb0fd3fa70995e07acc848d93f9c07fe3e99c0d36
#in_b = 0x3e1fc5f4b106897bb3e733d32c51e12a91d6c518d5da2b1a639149e8b944284d38fb80ffa26b94efef68d1958585f2178b28a43acdeba809a7cce3ca33ffe466
#in_m = 0x92c96dcdf75c45342c660ebce79e52ca8a239ec453f8d7e4fc80b8e2a151284d26f54d7b1220cd68f8f5314a247ff2703aebb0f7aed3b9a8947ab35ca51a5baf
#expected = 0x54dd8102a63a4a1d79851fe0e51aa7ed9965143d6152e22c3082e129a5f3c3cb3db0199a7dca7d3616017e18498d19ad85c59cd41ac62a8ee96cb8ec597ef324

# Testvector 8
#in_a = 0x87bd031a5fe5cb6dc1cecdb8bd7b2a75fbc9aae06d4fe65b3f8de91ee315b4eeab17e8f03020227b365a6cac95550e29d8bf767f0dae4f33d48382abaf3f13d
#in_b = 0x3028f0f258466ec853b4af0fe6bed6c4ddf8edb143850a94869a6eaa2e27c64fc70a562756b5fea1d5f918ea9f6e1d338e5d2526c0e64b2cfb1b4be2b406a1f
#in_m = 0xf47bc3b53d770d4020bc0ad81c44ba80c9a5235cf674df8f5ea047b9a1c1a53dc567882a5c5083d70548c94863559705e3ab778720b9da4b7a6e2ad90fbe29d3
#expected = 0x7fa6e8248a5628f457069fecb4fea621a6c39779a09de9ef0f93708f80ff4f406b20710594933ce599f734c8f3df736e577230ac974e2f8eb8b8219c5c99333f

# Testvector 9
#in_a = 0xae8a151477a26eee3d23d751289bc924cf3c9f9a85ee3e98965705bf6dd116daf75e26b4b5f0eb8c66a29154a6734271353809632e0ae82e0ac85ad8394bb869
#in_b = 0x96952c757f3da325b9718beac7c5b2df1715b57465750b157b2307690fa09f2eaadcaea17d07f88c8acbeab9cb8d25a456032052d153e4f3184b0dad521da139
#in_m = 0xafd40356369d990228cfadda9a083ca2c86622f7b80efcda5ebe1521b459a4a240855018749fe9d878fb7a784d6b648ae9f5a682dd8a0cf7062825573a5a2fe1
#expected = 0x600d37587bc22ac2ad1020f28cccf3bf6d895c9f13583024dcde67cffeeb7ed4c12627f11ba9a7eff5434089b0f1d1dcbb265a05c020d2e8b4316f86965eae17



#in_m = helpers.getModulus(512)
#in_a = helpers.getRandomInt(512) % in_m
#in_b = helpers.getRandomInt(512) % in_m
#expected = 0


result = MontMul_512_print(in_a, in_b, in_m)

print
print "in_a     <= 512'h" + format(in_a, "02x") + ";"
print "in_b     <= 512'h" + format(in_b, "02x") + ";"
print "in_m     <= 512'h" + format(in_m, "02x") + ";"
print "expected <= 512'h" + format(result, "02x") + ";"
print
print "uint32_t A16[16]       = {" + helpers.WriteConstants(in_a,16) + "};"
print "uint32_t B16[16]       = {" + helpers.WriteConstants(in_b,16) + "};"
print "uint32_t N16[16]       = {" + helpers.WriteConstants(in_m,16) + "};"
print "uint32_t expected_output[16]       = {" + helpers.WriteConstants(result,16) + "};"
print
print "in_a = 0x" + format(in_a, "02x")
print "in_b = 0x" + format(in_b, "02x")
print "in_m = 0x" + format(in_m, "02x")
print "expected = 0x" + format(result, "02x")
print
print "error =", result-expected

