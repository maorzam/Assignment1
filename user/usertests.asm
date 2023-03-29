
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };

  for(int ai = 0; ai < 2; ai++){
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
       8:	20100593          	li	a1,513
       c:	4505                	li	a0,1
       e:	057e                	slli	a0,a0,0x1f
      10:	00006097          	auipc	ra,0x6
      14:	ee8080e7          	jalr	-280(ra) # 5ef8 <open>
    if(fd >= 0){
      18:	02055063          	bgez	a0,38 <copyinstr1+0x38>
    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      1c:	20100593          	li	a1,513
      20:	557d                	li	a0,-1
      22:	00006097          	auipc	ra,0x6
      26:	ed6080e7          	jalr	-298(ra) # 5ef8 <open>
    uint64 addr = addrs[ai];
      2a:	55fd                	li	a1,-1
    if(fd >= 0){
      2c:	00055863          	bgez	a0,3c <copyinstr1+0x3c>
      printf("open(%p) returned %d, not -1\n", addr, fd);
      exit(1,0);
    }
  }
}
      30:	60a2                	ld	ra,8(sp)
      32:	6402                	ld	s0,0(sp)
      34:	0141                	addi	sp,sp,16
      36:	8082                	ret
    uint64 addr = addrs[ai];
      38:	4585                	li	a1,1
      3a:	05fe                	slli	a1,a1,0x1f
      printf("open(%p) returned %d, not -1\n", addr, fd);
      3c:	862a                	mv	a2,a0
      3e:	00006517          	auipc	a0,0x6
      42:	3c250513          	addi	a0,a0,962 # 6400 <malloc+0x10a>
      46:	00006097          	auipc	ra,0x6
      4a:	1f2080e7          	jalr	498(ra) # 6238 <printf>
      exit(1,0);
      4e:	4581                	li	a1,0
      50:	4505                	li	a0,1
      52:	00006097          	auipc	ra,0x6
      56:	e66080e7          	jalr	-410(ra) # 5eb8 <exit>

000000000000005a <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
      5a:	0000a797          	auipc	a5,0xa
      5e:	50e78793          	addi	a5,a5,1294 # a568 <uninit>
      62:	0000d697          	auipc	a3,0xd
      66:	c1668693          	addi	a3,a3,-1002 # cc78 <buf>
    if(uninit[i] != '\0'){
      6a:	0007c703          	lbu	a4,0(a5)
      6e:	e709                	bnez	a4,78 <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      70:	0785                	addi	a5,a5,1
      72:	fed79ce3          	bne	a5,a3,6a <bsstest+0x10>
      76:	8082                	ret
{
      78:	1141                	addi	sp,sp,-16
      7a:	e406                	sd	ra,8(sp)
      7c:	e022                	sd	s0,0(sp)
      7e:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
      80:	85aa                	mv	a1,a0
      82:	00006517          	auipc	a0,0x6
      86:	39e50513          	addi	a0,a0,926 # 6420 <malloc+0x12a>
      8a:	00006097          	auipc	ra,0x6
      8e:	1ae080e7          	jalr	430(ra) # 6238 <printf>
      exit(1,0);
      92:	4581                	li	a1,0
      94:	4505                	li	a0,1
      96:	00006097          	auipc	ra,0x6
      9a:	e22080e7          	jalr	-478(ra) # 5eb8 <exit>

000000000000009e <opentest>:
{
      9e:	1101                	addi	sp,sp,-32
      a0:	ec06                	sd	ra,24(sp)
      a2:	e822                	sd	s0,16(sp)
      a4:	e426                	sd	s1,8(sp)
      a6:	1000                	addi	s0,sp,32
      a8:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      aa:	4581                	li	a1,0
      ac:	00006517          	auipc	a0,0x6
      b0:	38c50513          	addi	a0,a0,908 # 6438 <malloc+0x142>
      b4:	00006097          	auipc	ra,0x6
      b8:	e44080e7          	jalr	-444(ra) # 5ef8 <open>
  if(fd < 0){
      bc:	02054663          	bltz	a0,e8 <opentest+0x4a>
  close(fd);
      c0:	00006097          	auipc	ra,0x6
      c4:	e20080e7          	jalr	-480(ra) # 5ee0 <close>
  fd = open("doesnotexist", 0);
      c8:	4581                	li	a1,0
      ca:	00006517          	auipc	a0,0x6
      ce:	38e50513          	addi	a0,a0,910 # 6458 <malloc+0x162>
      d2:	00006097          	auipc	ra,0x6
      d6:	e26080e7          	jalr	-474(ra) # 5ef8 <open>
  if(fd >= 0){
      da:	02055663          	bgez	a0,106 <opentest+0x68>
}
      de:	60e2                	ld	ra,24(sp)
      e0:	6442                	ld	s0,16(sp)
      e2:	64a2                	ld	s1,8(sp)
      e4:	6105                	addi	sp,sp,32
      e6:	8082                	ret
    printf("%s: open echo failed!\n", s);
      e8:	85a6                	mv	a1,s1
      ea:	00006517          	auipc	a0,0x6
      ee:	35650513          	addi	a0,a0,854 # 6440 <malloc+0x14a>
      f2:	00006097          	auipc	ra,0x6
      f6:	146080e7          	jalr	326(ra) # 6238 <printf>
    exit(1,0);
      fa:	4581                	li	a1,0
      fc:	4505                	li	a0,1
      fe:	00006097          	auipc	ra,0x6
     102:	dba080e7          	jalr	-582(ra) # 5eb8 <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     106:	85a6                	mv	a1,s1
     108:	00006517          	auipc	a0,0x6
     10c:	36050513          	addi	a0,a0,864 # 6468 <malloc+0x172>
     110:	00006097          	auipc	ra,0x6
     114:	128080e7          	jalr	296(ra) # 6238 <printf>
    exit(1,0);
     118:	4581                	li	a1,0
     11a:	4505                	li	a0,1
     11c:	00006097          	auipc	ra,0x6
     120:	d9c080e7          	jalr	-612(ra) # 5eb8 <exit>

0000000000000124 <truncate2>:
{
     124:	7179                	addi	sp,sp,-48
     126:	f406                	sd	ra,40(sp)
     128:	f022                	sd	s0,32(sp)
     12a:	ec26                	sd	s1,24(sp)
     12c:	e84a                	sd	s2,16(sp)
     12e:	e44e                	sd	s3,8(sp)
     130:	1800                	addi	s0,sp,48
     132:	89aa                	mv	s3,a0
  unlink("truncfile");
     134:	00006517          	auipc	a0,0x6
     138:	35c50513          	addi	a0,a0,860 # 6490 <malloc+0x19a>
     13c:	00006097          	auipc	ra,0x6
     140:	dcc080e7          	jalr	-564(ra) # 5f08 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     144:	60100593          	li	a1,1537
     148:	00006517          	auipc	a0,0x6
     14c:	34850513          	addi	a0,a0,840 # 6490 <malloc+0x19a>
     150:	00006097          	auipc	ra,0x6
     154:	da8080e7          	jalr	-600(ra) # 5ef8 <open>
     158:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     15a:	4611                	li	a2,4
     15c:	00006597          	auipc	a1,0x6
     160:	34458593          	addi	a1,a1,836 # 64a0 <malloc+0x1aa>
     164:	00006097          	auipc	ra,0x6
     168:	d74080e7          	jalr	-652(ra) # 5ed8 <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     16c:	40100593          	li	a1,1025
     170:	00006517          	auipc	a0,0x6
     174:	32050513          	addi	a0,a0,800 # 6490 <malloc+0x19a>
     178:	00006097          	auipc	ra,0x6
     17c:	d80080e7          	jalr	-640(ra) # 5ef8 <open>
     180:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     182:	4605                	li	a2,1
     184:	00006597          	auipc	a1,0x6
     188:	32458593          	addi	a1,a1,804 # 64a8 <malloc+0x1b2>
     18c:	8526                	mv	a0,s1
     18e:	00006097          	auipc	ra,0x6
     192:	d4a080e7          	jalr	-694(ra) # 5ed8 <write>
  if(n != -1){
     196:	57fd                	li	a5,-1
     198:	02f51b63          	bne	a0,a5,1ce <truncate2+0xaa>
  unlink("truncfile");
     19c:	00006517          	auipc	a0,0x6
     1a0:	2f450513          	addi	a0,a0,756 # 6490 <malloc+0x19a>
     1a4:	00006097          	auipc	ra,0x6
     1a8:	d64080e7          	jalr	-668(ra) # 5f08 <unlink>
  close(fd1);
     1ac:	8526                	mv	a0,s1
     1ae:	00006097          	auipc	ra,0x6
     1b2:	d32080e7          	jalr	-718(ra) # 5ee0 <close>
  close(fd2);
     1b6:	854a                	mv	a0,s2
     1b8:	00006097          	auipc	ra,0x6
     1bc:	d28080e7          	jalr	-728(ra) # 5ee0 <close>
}
     1c0:	70a2                	ld	ra,40(sp)
     1c2:	7402                	ld	s0,32(sp)
     1c4:	64e2                	ld	s1,24(sp)
     1c6:	6942                	ld	s2,16(sp)
     1c8:	69a2                	ld	s3,8(sp)
     1ca:	6145                	addi	sp,sp,48
     1cc:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1ce:	862a                	mv	a2,a0
     1d0:	85ce                	mv	a1,s3
     1d2:	00006517          	auipc	a0,0x6
     1d6:	2de50513          	addi	a0,a0,734 # 64b0 <malloc+0x1ba>
     1da:	00006097          	auipc	ra,0x6
     1de:	05e080e7          	jalr	94(ra) # 6238 <printf>
    exit(1,0);
     1e2:	4581                	li	a1,0
     1e4:	4505                	li	a0,1
     1e6:	00006097          	auipc	ra,0x6
     1ea:	cd2080e7          	jalr	-814(ra) # 5eb8 <exit>

00000000000001ee <createtest>:
{
     1ee:	7179                	addi	sp,sp,-48
     1f0:	f406                	sd	ra,40(sp)
     1f2:	f022                	sd	s0,32(sp)
     1f4:	ec26                	sd	s1,24(sp)
     1f6:	e84a                	sd	s2,16(sp)
     1f8:	1800                	addi	s0,sp,48
  name[0] = 'a';
     1fa:	06100793          	li	a5,97
     1fe:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     202:	fc040d23          	sb	zero,-38(s0)
     206:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     20a:	06400913          	li	s2,100
    name[1] = '0' + i;
     20e:	fc940ca3          	sb	s1,-39(s0)
    fd = open(name, O_CREATE|O_RDWR);
     212:	20200593          	li	a1,514
     216:	fd840513          	addi	a0,s0,-40
     21a:	00006097          	auipc	ra,0x6
     21e:	cde080e7          	jalr	-802(ra) # 5ef8 <open>
    close(fd);
     222:	00006097          	auipc	ra,0x6
     226:	cbe080e7          	jalr	-834(ra) # 5ee0 <close>
  for(i = 0; i < N; i++){
     22a:	2485                	addiw	s1,s1,1
     22c:	0ff4f493          	andi	s1,s1,255
     230:	fd249fe3          	bne	s1,s2,20e <createtest+0x20>
  name[0] = 'a';
     234:	06100793          	li	a5,97
     238:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     23c:	fc040d23          	sb	zero,-38(s0)
     240:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     244:	06400913          	li	s2,100
    name[1] = '0' + i;
     248:	fc940ca3          	sb	s1,-39(s0)
    unlink(name);
     24c:	fd840513          	addi	a0,s0,-40
     250:	00006097          	auipc	ra,0x6
     254:	cb8080e7          	jalr	-840(ra) # 5f08 <unlink>
  for(i = 0; i < N; i++){
     258:	2485                	addiw	s1,s1,1
     25a:	0ff4f493          	andi	s1,s1,255
     25e:	ff2495e3          	bne	s1,s2,248 <createtest+0x5a>
}
     262:	70a2                	ld	ra,40(sp)
     264:	7402                	ld	s0,32(sp)
     266:	64e2                	ld	s1,24(sp)
     268:	6942                	ld	s2,16(sp)
     26a:	6145                	addi	sp,sp,48
     26c:	8082                	ret

000000000000026e <bigwrite>:
{
     26e:	715d                	addi	sp,sp,-80
     270:	e486                	sd	ra,72(sp)
     272:	e0a2                	sd	s0,64(sp)
     274:	fc26                	sd	s1,56(sp)
     276:	f84a                	sd	s2,48(sp)
     278:	f44e                	sd	s3,40(sp)
     27a:	f052                	sd	s4,32(sp)
     27c:	ec56                	sd	s5,24(sp)
     27e:	e85a                	sd	s6,16(sp)
     280:	e45e                	sd	s7,8(sp)
     282:	0880                	addi	s0,sp,80
     284:	8baa                	mv	s7,a0
  unlink("bigwrite");
     286:	00006517          	auipc	a0,0x6
     28a:	25250513          	addi	a0,a0,594 # 64d8 <malloc+0x1e2>
     28e:	00006097          	auipc	ra,0x6
     292:	c7a080e7          	jalr	-902(ra) # 5f08 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     296:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     29a:	00006a97          	auipc	s5,0x6
     29e:	23ea8a93          	addi	s5,s5,574 # 64d8 <malloc+0x1e2>
      int cc = write(fd, buf, sz);
     2a2:	0000da17          	auipc	s4,0xd
     2a6:	9d6a0a13          	addi	s4,s4,-1578 # cc78 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2aa:	6b0d                	lui	s6,0x3
     2ac:	1c9b0b13          	addi	s6,s6,457 # 31c9 <execout+0xc5>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     2b0:	20200593          	li	a1,514
     2b4:	8556                	mv	a0,s5
     2b6:	00006097          	auipc	ra,0x6
     2ba:	c42080e7          	jalr	-958(ra) # 5ef8 <open>
     2be:	892a                	mv	s2,a0
    if(fd < 0){
     2c0:	04054d63          	bltz	a0,31a <bigwrite+0xac>
      int cc = write(fd, buf, sz);
     2c4:	8626                	mv	a2,s1
     2c6:	85d2                	mv	a1,s4
     2c8:	00006097          	auipc	ra,0x6
     2cc:	c10080e7          	jalr	-1008(ra) # 5ed8 <write>
     2d0:	89aa                	mv	s3,a0
      if(cc != sz){
     2d2:	06a49563          	bne	s1,a0,33c <bigwrite+0xce>
      int cc = write(fd, buf, sz);
     2d6:	8626                	mv	a2,s1
     2d8:	85d2                	mv	a1,s4
     2da:	854a                	mv	a0,s2
     2dc:	00006097          	auipc	ra,0x6
     2e0:	bfc080e7          	jalr	-1028(ra) # 5ed8 <write>
      if(cc != sz){
     2e4:	04951a63          	bne	a0,s1,338 <bigwrite+0xca>
    close(fd);
     2e8:	854a                	mv	a0,s2
     2ea:	00006097          	auipc	ra,0x6
     2ee:	bf6080e7          	jalr	-1034(ra) # 5ee0 <close>
    unlink("bigwrite");
     2f2:	8556                	mv	a0,s5
     2f4:	00006097          	auipc	ra,0x6
     2f8:	c14080e7          	jalr	-1004(ra) # 5f08 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2fc:	1d74849b          	addiw	s1,s1,471
     300:	fb6498e3          	bne	s1,s6,2b0 <bigwrite+0x42>
}
     304:	60a6                	ld	ra,72(sp)
     306:	6406                	ld	s0,64(sp)
     308:	74e2                	ld	s1,56(sp)
     30a:	7942                	ld	s2,48(sp)
     30c:	79a2                	ld	s3,40(sp)
     30e:	7a02                	ld	s4,32(sp)
     310:	6ae2                	ld	s5,24(sp)
     312:	6b42                	ld	s6,16(sp)
     314:	6ba2                	ld	s7,8(sp)
     316:	6161                	addi	sp,sp,80
     318:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     31a:	85de                	mv	a1,s7
     31c:	00006517          	auipc	a0,0x6
     320:	1cc50513          	addi	a0,a0,460 # 64e8 <malloc+0x1f2>
     324:	00006097          	auipc	ra,0x6
     328:	f14080e7          	jalr	-236(ra) # 6238 <printf>
      exit(1,0);
     32c:	4581                	li	a1,0
     32e:	4505                	li	a0,1
     330:	00006097          	auipc	ra,0x6
     334:	b88080e7          	jalr	-1144(ra) # 5eb8 <exit>
     338:	84ce                	mv	s1,s3
      int cc = write(fd, buf, sz);
     33a:	89aa                	mv	s3,a0
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     33c:	86ce                	mv	a3,s3
     33e:	8626                	mv	a2,s1
     340:	85de                	mv	a1,s7
     342:	00006517          	auipc	a0,0x6
     346:	1c650513          	addi	a0,a0,454 # 6508 <malloc+0x212>
     34a:	00006097          	auipc	ra,0x6
     34e:	eee080e7          	jalr	-274(ra) # 6238 <printf>
        exit(1,0);
     352:	4581                	li	a1,0
     354:	4505                	li	a0,1
     356:	00006097          	auipc	ra,0x6
     35a:	b62080e7          	jalr	-1182(ra) # 5eb8 <exit>

000000000000035e <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
     35e:	7179                	addi	sp,sp,-48
     360:	f406                	sd	ra,40(sp)
     362:	f022                	sd	s0,32(sp)
     364:	ec26                	sd	s1,24(sp)
     366:	e84a                	sd	s2,16(sp)
     368:	e44e                	sd	s3,8(sp)
     36a:	e052                	sd	s4,0(sp)
     36c:	1800                	addi	s0,sp,48
  int assumed_free = 600;
  
  unlink("junk");
     36e:	00006517          	auipc	a0,0x6
     372:	1b250513          	addi	a0,a0,434 # 6520 <malloc+0x22a>
     376:	00006097          	auipc	ra,0x6
     37a:	b92080e7          	jalr	-1134(ra) # 5f08 <unlink>
     37e:	25800913          	li	s2,600
  for(int i = 0; i < assumed_free; i++){
    int fd = open("junk", O_CREATE|O_WRONLY);
     382:	00006997          	auipc	s3,0x6
     386:	19e98993          	addi	s3,s3,414 # 6520 <malloc+0x22a>
    if(fd < 0){
      printf("open junk failed\n");
      exit(1,0);
    }
    write(fd, (char*)0xffffffffffL, 1);
     38a:	5a7d                	li	s4,-1
     38c:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
     390:	20100593          	li	a1,513
     394:	854e                	mv	a0,s3
     396:	00006097          	auipc	ra,0x6
     39a:	b62080e7          	jalr	-1182(ra) # 5ef8 <open>
     39e:	84aa                	mv	s1,a0
    if(fd < 0){
     3a0:	06054c63          	bltz	a0,418 <badwrite+0xba>
    write(fd, (char*)0xffffffffffL, 1);
     3a4:	4605                	li	a2,1
     3a6:	85d2                	mv	a1,s4
     3a8:	00006097          	auipc	ra,0x6
     3ac:	b30080e7          	jalr	-1232(ra) # 5ed8 <write>
    close(fd);
     3b0:	8526                	mv	a0,s1
     3b2:	00006097          	auipc	ra,0x6
     3b6:	b2e080e7          	jalr	-1234(ra) # 5ee0 <close>
    unlink("junk");
     3ba:	854e                	mv	a0,s3
     3bc:	00006097          	auipc	ra,0x6
     3c0:	b4c080e7          	jalr	-1204(ra) # 5f08 <unlink>
  for(int i = 0; i < assumed_free; i++){
     3c4:	397d                	addiw	s2,s2,-1
     3c6:	fc0915e3          	bnez	s2,390 <badwrite+0x32>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
     3ca:	20100593          	li	a1,513
     3ce:	00006517          	auipc	a0,0x6
     3d2:	15250513          	addi	a0,a0,338 # 6520 <malloc+0x22a>
     3d6:	00006097          	auipc	ra,0x6
     3da:	b22080e7          	jalr	-1246(ra) # 5ef8 <open>
     3de:	84aa                	mv	s1,a0
  if(fd < 0){
     3e0:	04054a63          	bltz	a0,434 <badwrite+0xd6>
    printf("open junk failed\n");
    exit(1,0);
  }
  if(write(fd, "x", 1) != 1){
     3e4:	4605                	li	a2,1
     3e6:	00006597          	auipc	a1,0x6
     3ea:	0c258593          	addi	a1,a1,194 # 64a8 <malloc+0x1b2>
     3ee:	00006097          	auipc	ra,0x6
     3f2:	aea080e7          	jalr	-1302(ra) # 5ed8 <write>
     3f6:	4785                	li	a5,1
     3f8:	04f50c63          	beq	a0,a5,450 <badwrite+0xf2>
    printf("write failed\n");
     3fc:	00006517          	auipc	a0,0x6
     400:	14450513          	addi	a0,a0,324 # 6540 <malloc+0x24a>
     404:	00006097          	auipc	ra,0x6
     408:	e34080e7          	jalr	-460(ra) # 6238 <printf>
    exit(1,0);
     40c:	4581                	li	a1,0
     40e:	4505                	li	a0,1
     410:	00006097          	auipc	ra,0x6
     414:	aa8080e7          	jalr	-1368(ra) # 5eb8 <exit>
      printf("open junk failed\n");
     418:	00006517          	auipc	a0,0x6
     41c:	11050513          	addi	a0,a0,272 # 6528 <malloc+0x232>
     420:	00006097          	auipc	ra,0x6
     424:	e18080e7          	jalr	-488(ra) # 6238 <printf>
      exit(1,0);
     428:	4581                	li	a1,0
     42a:	4505                	li	a0,1
     42c:	00006097          	auipc	ra,0x6
     430:	a8c080e7          	jalr	-1396(ra) # 5eb8 <exit>
    printf("open junk failed\n");
     434:	00006517          	auipc	a0,0x6
     438:	0f450513          	addi	a0,a0,244 # 6528 <malloc+0x232>
     43c:	00006097          	auipc	ra,0x6
     440:	dfc080e7          	jalr	-516(ra) # 6238 <printf>
    exit(1,0);
     444:	4581                	li	a1,0
     446:	4505                	li	a0,1
     448:	00006097          	auipc	ra,0x6
     44c:	a70080e7          	jalr	-1424(ra) # 5eb8 <exit>
  }
  close(fd);
     450:	8526                	mv	a0,s1
     452:	00006097          	auipc	ra,0x6
     456:	a8e080e7          	jalr	-1394(ra) # 5ee0 <close>
  unlink("junk");
     45a:	00006517          	auipc	a0,0x6
     45e:	0c650513          	addi	a0,a0,198 # 6520 <malloc+0x22a>
     462:	00006097          	auipc	ra,0x6
     466:	aa6080e7          	jalr	-1370(ra) # 5f08 <unlink>

  exit(0,0);
     46a:	4581                	li	a1,0
     46c:	4501                	li	a0,0
     46e:	00006097          	auipc	ra,0x6
     472:	a4a080e7          	jalr	-1462(ra) # 5eb8 <exit>

0000000000000476 <outofinodes>:
  }
}

void
outofinodes(char *s)
{
     476:	715d                	addi	sp,sp,-80
     478:	e486                	sd	ra,72(sp)
     47a:	e0a2                	sd	s0,64(sp)
     47c:	fc26                	sd	s1,56(sp)
     47e:	f84a                	sd	s2,48(sp)
     480:	f44e                	sd	s3,40(sp)
     482:	0880                	addi	s0,sp,80
  int nzz = 32*32;
  for(int i = 0; i < nzz; i++){
     484:	4481                	li	s1,0
    char name[32];
    name[0] = 'z';
     486:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
     48a:	40000993          	li	s3,1024
    name[0] = 'z';
     48e:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     492:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     496:	41f4d79b          	sraiw	a5,s1,0x1f
     49a:	01b7d71b          	srliw	a4,a5,0x1b
     49e:	009707bb          	addw	a5,a4,s1
     4a2:	4057d69b          	sraiw	a3,a5,0x5
     4a6:	0306869b          	addiw	a3,a3,48
     4aa:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     4ae:	8bfd                	andi	a5,a5,31
     4b0:	9f99                	subw	a5,a5,a4
     4b2:	0307879b          	addiw	a5,a5,48
     4b6:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     4ba:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     4be:	fb040513          	addi	a0,s0,-80
     4c2:	00006097          	auipc	ra,0x6
     4c6:	a46080e7          	jalr	-1466(ra) # 5f08 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
     4ca:	60200593          	li	a1,1538
     4ce:	fb040513          	addi	a0,s0,-80
     4d2:	00006097          	auipc	ra,0x6
     4d6:	a26080e7          	jalr	-1498(ra) # 5ef8 <open>
    if(fd < 0){
     4da:	00054963          	bltz	a0,4ec <outofinodes+0x76>
      // failure is eventually expected.
      break;
    }
    close(fd);
     4de:	00006097          	auipc	ra,0x6
     4e2:	a02080e7          	jalr	-1534(ra) # 5ee0 <close>
  for(int i = 0; i < nzz; i++){
     4e6:	2485                	addiw	s1,s1,1
     4e8:	fb3493e3          	bne	s1,s3,48e <outofinodes+0x18>
     4ec:	4481                	li	s1,0
  }

  for(int i = 0; i < nzz; i++){
    char name[32];
    name[0] = 'z';
     4ee:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
     4f2:	40000993          	li	s3,1024
    name[0] = 'z';
     4f6:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     4fa:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     4fe:	41f4d79b          	sraiw	a5,s1,0x1f
     502:	01b7d71b          	srliw	a4,a5,0x1b
     506:	009707bb          	addw	a5,a4,s1
     50a:	4057d69b          	sraiw	a3,a5,0x5
     50e:	0306869b          	addiw	a3,a3,48
     512:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     516:	8bfd                	andi	a5,a5,31
     518:	9f99                	subw	a5,a5,a4
     51a:	0307879b          	addiw	a5,a5,48
     51e:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     522:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     526:	fb040513          	addi	a0,s0,-80
     52a:	00006097          	auipc	ra,0x6
     52e:	9de080e7          	jalr	-1570(ra) # 5f08 <unlink>
  for(int i = 0; i < nzz; i++){
     532:	2485                	addiw	s1,s1,1
     534:	fd3491e3          	bne	s1,s3,4f6 <outofinodes+0x80>
  }
}
     538:	60a6                	ld	ra,72(sp)
     53a:	6406                	ld	s0,64(sp)
     53c:	74e2                	ld	s1,56(sp)
     53e:	7942                	ld	s2,48(sp)
     540:	79a2                	ld	s3,40(sp)
     542:	6161                	addi	sp,sp,80
     544:	8082                	ret

0000000000000546 <copyin>:
{
     546:	715d                	addi	sp,sp,-80
     548:	e486                	sd	ra,72(sp)
     54a:	e0a2                	sd	s0,64(sp)
     54c:	fc26                	sd	s1,56(sp)
     54e:	f84a                	sd	s2,48(sp)
     550:	f44e                	sd	s3,40(sp)
     552:	f052                	sd	s4,32(sp)
     554:	0880                	addi	s0,sp,80
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     556:	4785                	li	a5,1
     558:	07fe                	slli	a5,a5,0x1f
     55a:	fcf43023          	sd	a5,-64(s0)
     55e:	57fd                	li	a5,-1
     560:	fcf43423          	sd	a5,-56(s0)
  for(int ai = 0; ai < 2; ai++){
     564:	fc040913          	addi	s2,s0,-64
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     568:	00006a17          	auipc	s4,0x6
     56c:	fe8a0a13          	addi	s4,s4,-24 # 6550 <malloc+0x25a>
    uint64 addr = addrs[ai];
     570:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     574:	20100593          	li	a1,513
     578:	8552                	mv	a0,s4
     57a:	00006097          	auipc	ra,0x6
     57e:	97e080e7          	jalr	-1666(ra) # 5ef8 <open>
     582:	84aa                	mv	s1,a0
    if(fd < 0){
     584:	08054863          	bltz	a0,614 <copyin+0xce>
    int n = write(fd, (void*)addr, 8192);
     588:	6609                	lui	a2,0x2
     58a:	85ce                	mv	a1,s3
     58c:	00006097          	auipc	ra,0x6
     590:	94c080e7          	jalr	-1716(ra) # 5ed8 <write>
    if(n >= 0){
     594:	08055e63          	bgez	a0,630 <copyin+0xea>
    close(fd);
     598:	8526                	mv	a0,s1
     59a:	00006097          	auipc	ra,0x6
     59e:	946080e7          	jalr	-1722(ra) # 5ee0 <close>
    unlink("copyin1");
     5a2:	8552                	mv	a0,s4
     5a4:	00006097          	auipc	ra,0x6
     5a8:	964080e7          	jalr	-1692(ra) # 5f08 <unlink>
    n = write(1, (char*)addr, 8192);
     5ac:	6609                	lui	a2,0x2
     5ae:	85ce                	mv	a1,s3
     5b0:	4505                	li	a0,1
     5b2:	00006097          	auipc	ra,0x6
     5b6:	926080e7          	jalr	-1754(ra) # 5ed8 <write>
    if(n > 0){
     5ba:	08a04b63          	bgtz	a0,650 <copyin+0x10a>
    if(pipe(fds) < 0){
     5be:	fb840513          	addi	a0,s0,-72
     5c2:	00006097          	auipc	ra,0x6
     5c6:	906080e7          	jalr	-1786(ra) # 5ec8 <pipe>
     5ca:	0a054363          	bltz	a0,670 <copyin+0x12a>
    n = write(fds[1], (char*)addr, 8192);
     5ce:	6609                	lui	a2,0x2
     5d0:	85ce                	mv	a1,s3
     5d2:	fbc42503          	lw	a0,-68(s0)
     5d6:	00006097          	auipc	ra,0x6
     5da:	902080e7          	jalr	-1790(ra) # 5ed8 <write>
    if(n > 0){
     5de:	0aa04763          	bgtz	a0,68c <copyin+0x146>
    close(fds[0]);
     5e2:	fb842503          	lw	a0,-72(s0)
     5e6:	00006097          	auipc	ra,0x6
     5ea:	8fa080e7          	jalr	-1798(ra) # 5ee0 <close>
    close(fds[1]);
     5ee:	fbc42503          	lw	a0,-68(s0)
     5f2:	00006097          	auipc	ra,0x6
     5f6:	8ee080e7          	jalr	-1810(ra) # 5ee0 <close>
  for(int ai = 0; ai < 2; ai++){
     5fa:	0921                	addi	s2,s2,8
     5fc:	fd040793          	addi	a5,s0,-48
     600:	f6f918e3          	bne	s2,a5,570 <copyin+0x2a>
}
     604:	60a6                	ld	ra,72(sp)
     606:	6406                	ld	s0,64(sp)
     608:	74e2                	ld	s1,56(sp)
     60a:	7942                	ld	s2,48(sp)
     60c:	79a2                	ld	s3,40(sp)
     60e:	7a02                	ld	s4,32(sp)
     610:	6161                	addi	sp,sp,80
     612:	8082                	ret
      printf("open(copyin1) failed\n");
     614:	00006517          	auipc	a0,0x6
     618:	f4450513          	addi	a0,a0,-188 # 6558 <malloc+0x262>
     61c:	00006097          	auipc	ra,0x6
     620:	c1c080e7          	jalr	-996(ra) # 6238 <printf>
      exit(1,0);
     624:	4581                	li	a1,0
     626:	4505                	li	a0,1
     628:	00006097          	auipc	ra,0x6
     62c:	890080e7          	jalr	-1904(ra) # 5eb8 <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
     630:	862a                	mv	a2,a0
     632:	85ce                	mv	a1,s3
     634:	00006517          	auipc	a0,0x6
     638:	f3c50513          	addi	a0,a0,-196 # 6570 <malloc+0x27a>
     63c:	00006097          	auipc	ra,0x6
     640:	bfc080e7          	jalr	-1028(ra) # 6238 <printf>
      exit(1,0);
     644:	4581                	li	a1,0
     646:	4505                	li	a0,1
     648:	00006097          	auipc	ra,0x6
     64c:	870080e7          	jalr	-1936(ra) # 5eb8 <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     650:	862a                	mv	a2,a0
     652:	85ce                	mv	a1,s3
     654:	00006517          	auipc	a0,0x6
     658:	f4c50513          	addi	a0,a0,-180 # 65a0 <malloc+0x2aa>
     65c:	00006097          	auipc	ra,0x6
     660:	bdc080e7          	jalr	-1060(ra) # 6238 <printf>
      exit(1,0);
     664:	4581                	li	a1,0
     666:	4505                	li	a0,1
     668:	00006097          	auipc	ra,0x6
     66c:	850080e7          	jalr	-1968(ra) # 5eb8 <exit>
      printf("pipe() failed\n");
     670:	00006517          	auipc	a0,0x6
     674:	f6050513          	addi	a0,a0,-160 # 65d0 <malloc+0x2da>
     678:	00006097          	auipc	ra,0x6
     67c:	bc0080e7          	jalr	-1088(ra) # 6238 <printf>
      exit(1,0);
     680:	4581                	li	a1,0
     682:	4505                	li	a0,1
     684:	00006097          	auipc	ra,0x6
     688:	834080e7          	jalr	-1996(ra) # 5eb8 <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     68c:	862a                	mv	a2,a0
     68e:	85ce                	mv	a1,s3
     690:	00006517          	auipc	a0,0x6
     694:	f5050513          	addi	a0,a0,-176 # 65e0 <malloc+0x2ea>
     698:	00006097          	auipc	ra,0x6
     69c:	ba0080e7          	jalr	-1120(ra) # 6238 <printf>
      exit(1,0);
     6a0:	4581                	li	a1,0
     6a2:	4505                	li	a0,1
     6a4:	00006097          	auipc	ra,0x6
     6a8:	814080e7          	jalr	-2028(ra) # 5eb8 <exit>

00000000000006ac <copyout>:
{
     6ac:	711d                	addi	sp,sp,-96
     6ae:	ec86                	sd	ra,88(sp)
     6b0:	e8a2                	sd	s0,80(sp)
     6b2:	e4a6                	sd	s1,72(sp)
     6b4:	e0ca                	sd	s2,64(sp)
     6b6:	fc4e                	sd	s3,56(sp)
     6b8:	f852                	sd	s4,48(sp)
     6ba:	f456                	sd	s5,40(sp)
     6bc:	1080                	addi	s0,sp,96
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     6be:	4785                	li	a5,1
     6c0:	07fe                	slli	a5,a5,0x1f
     6c2:	faf43823          	sd	a5,-80(s0)
     6c6:	57fd                	li	a5,-1
     6c8:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < 2; ai++){
     6cc:	fb040913          	addi	s2,s0,-80
    int fd = open("README", 0);
     6d0:	00006a17          	auipc	s4,0x6
     6d4:	f40a0a13          	addi	s4,s4,-192 # 6610 <malloc+0x31a>
    n = write(fds[1], "x", 1);
     6d8:	00006a97          	auipc	s5,0x6
     6dc:	dd0a8a93          	addi	s5,s5,-560 # 64a8 <malloc+0x1b2>
    uint64 addr = addrs[ai];
     6e0:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     6e4:	4581                	li	a1,0
     6e6:	8552                	mv	a0,s4
     6e8:	00006097          	auipc	ra,0x6
     6ec:	810080e7          	jalr	-2032(ra) # 5ef8 <open>
     6f0:	84aa                	mv	s1,a0
    if(fd < 0){
     6f2:	08054663          	bltz	a0,77e <copyout+0xd2>
    int n = read(fd, (void*)addr, 8192);
     6f6:	6609                	lui	a2,0x2
     6f8:	85ce                	mv	a1,s3
     6fa:	00005097          	auipc	ra,0x5
     6fe:	7d6080e7          	jalr	2006(ra) # 5ed0 <read>
    if(n > 0){
     702:	08a04c63          	bgtz	a0,79a <copyout+0xee>
    close(fd);
     706:	8526                	mv	a0,s1
     708:	00005097          	auipc	ra,0x5
     70c:	7d8080e7          	jalr	2008(ra) # 5ee0 <close>
    if(pipe(fds) < 0){
     710:	fa840513          	addi	a0,s0,-88
     714:	00005097          	auipc	ra,0x5
     718:	7b4080e7          	jalr	1972(ra) # 5ec8 <pipe>
     71c:	08054f63          	bltz	a0,7ba <copyout+0x10e>
    n = write(fds[1], "x", 1);
     720:	4605                	li	a2,1
     722:	85d6                	mv	a1,s5
     724:	fac42503          	lw	a0,-84(s0)
     728:	00005097          	auipc	ra,0x5
     72c:	7b0080e7          	jalr	1968(ra) # 5ed8 <write>
    if(n != 1){
     730:	4785                	li	a5,1
     732:	0af51263          	bne	a0,a5,7d6 <copyout+0x12a>
    n = read(fds[0], (void*)addr, 8192);
     736:	6609                	lui	a2,0x2
     738:	85ce                	mv	a1,s3
     73a:	fa842503          	lw	a0,-88(s0)
     73e:	00005097          	auipc	ra,0x5
     742:	792080e7          	jalr	1938(ra) # 5ed0 <read>
    if(n > 0){
     746:	0aa04663          	bgtz	a0,7f2 <copyout+0x146>
    close(fds[0]);
     74a:	fa842503          	lw	a0,-88(s0)
     74e:	00005097          	auipc	ra,0x5
     752:	792080e7          	jalr	1938(ra) # 5ee0 <close>
    close(fds[1]);
     756:	fac42503          	lw	a0,-84(s0)
     75a:	00005097          	auipc	ra,0x5
     75e:	786080e7          	jalr	1926(ra) # 5ee0 <close>
  for(int ai = 0; ai < 2; ai++){
     762:	0921                	addi	s2,s2,8
     764:	fc040793          	addi	a5,s0,-64
     768:	f6f91ce3          	bne	s2,a5,6e0 <copyout+0x34>
}
     76c:	60e6                	ld	ra,88(sp)
     76e:	6446                	ld	s0,80(sp)
     770:	64a6                	ld	s1,72(sp)
     772:	6906                	ld	s2,64(sp)
     774:	79e2                	ld	s3,56(sp)
     776:	7a42                	ld	s4,48(sp)
     778:	7aa2                	ld	s5,40(sp)
     77a:	6125                	addi	sp,sp,96
     77c:	8082                	ret
      printf("open(README) failed\n");
     77e:	00006517          	auipc	a0,0x6
     782:	e9a50513          	addi	a0,a0,-358 # 6618 <malloc+0x322>
     786:	00006097          	auipc	ra,0x6
     78a:	ab2080e7          	jalr	-1358(ra) # 6238 <printf>
      exit(1,0);
     78e:	4581                	li	a1,0
     790:	4505                	li	a0,1
     792:	00005097          	auipc	ra,0x5
     796:	726080e7          	jalr	1830(ra) # 5eb8 <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     79a:	862a                	mv	a2,a0
     79c:	85ce                	mv	a1,s3
     79e:	00006517          	auipc	a0,0x6
     7a2:	e9250513          	addi	a0,a0,-366 # 6630 <malloc+0x33a>
     7a6:	00006097          	auipc	ra,0x6
     7aa:	a92080e7          	jalr	-1390(ra) # 6238 <printf>
      exit(1,0);
     7ae:	4581                	li	a1,0
     7b0:	4505                	li	a0,1
     7b2:	00005097          	auipc	ra,0x5
     7b6:	706080e7          	jalr	1798(ra) # 5eb8 <exit>
      printf("pipe() failed\n");
     7ba:	00006517          	auipc	a0,0x6
     7be:	e1650513          	addi	a0,a0,-490 # 65d0 <malloc+0x2da>
     7c2:	00006097          	auipc	ra,0x6
     7c6:	a76080e7          	jalr	-1418(ra) # 6238 <printf>
      exit(1,0);
     7ca:	4581                	li	a1,0
     7cc:	4505                	li	a0,1
     7ce:	00005097          	auipc	ra,0x5
     7d2:	6ea080e7          	jalr	1770(ra) # 5eb8 <exit>
      printf("pipe write failed\n");
     7d6:	00006517          	auipc	a0,0x6
     7da:	e8a50513          	addi	a0,a0,-374 # 6660 <malloc+0x36a>
     7de:	00006097          	auipc	ra,0x6
     7e2:	a5a080e7          	jalr	-1446(ra) # 6238 <printf>
      exit(1,0);
     7e6:	4581                	li	a1,0
     7e8:	4505                	li	a0,1
     7ea:	00005097          	auipc	ra,0x5
     7ee:	6ce080e7          	jalr	1742(ra) # 5eb8 <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     7f2:	862a                	mv	a2,a0
     7f4:	85ce                	mv	a1,s3
     7f6:	00006517          	auipc	a0,0x6
     7fa:	e8250513          	addi	a0,a0,-382 # 6678 <malloc+0x382>
     7fe:	00006097          	auipc	ra,0x6
     802:	a3a080e7          	jalr	-1478(ra) # 6238 <printf>
      exit(1,0);
     806:	4581                	li	a1,0
     808:	4505                	li	a0,1
     80a:	00005097          	auipc	ra,0x5
     80e:	6ae080e7          	jalr	1710(ra) # 5eb8 <exit>

0000000000000812 <truncate1>:
{
     812:	711d                	addi	sp,sp,-96
     814:	ec86                	sd	ra,88(sp)
     816:	e8a2                	sd	s0,80(sp)
     818:	e4a6                	sd	s1,72(sp)
     81a:	e0ca                	sd	s2,64(sp)
     81c:	fc4e                	sd	s3,56(sp)
     81e:	f852                	sd	s4,48(sp)
     820:	f456                	sd	s5,40(sp)
     822:	1080                	addi	s0,sp,96
     824:	8aaa                	mv	s5,a0
  unlink("truncfile");
     826:	00006517          	auipc	a0,0x6
     82a:	c6a50513          	addi	a0,a0,-918 # 6490 <malloc+0x19a>
     82e:	00005097          	auipc	ra,0x5
     832:	6da080e7          	jalr	1754(ra) # 5f08 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     836:	60100593          	li	a1,1537
     83a:	00006517          	auipc	a0,0x6
     83e:	c5650513          	addi	a0,a0,-938 # 6490 <malloc+0x19a>
     842:	00005097          	auipc	ra,0x5
     846:	6b6080e7          	jalr	1718(ra) # 5ef8 <open>
     84a:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     84c:	4611                	li	a2,4
     84e:	00006597          	auipc	a1,0x6
     852:	c5258593          	addi	a1,a1,-942 # 64a0 <malloc+0x1aa>
     856:	00005097          	auipc	ra,0x5
     85a:	682080e7          	jalr	1666(ra) # 5ed8 <write>
  close(fd1);
     85e:	8526                	mv	a0,s1
     860:	00005097          	auipc	ra,0x5
     864:	680080e7          	jalr	1664(ra) # 5ee0 <close>
  int fd2 = open("truncfile", O_RDONLY);
     868:	4581                	li	a1,0
     86a:	00006517          	auipc	a0,0x6
     86e:	c2650513          	addi	a0,a0,-986 # 6490 <malloc+0x19a>
     872:	00005097          	auipc	ra,0x5
     876:	686080e7          	jalr	1670(ra) # 5ef8 <open>
     87a:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     87c:	02000613          	li	a2,32
     880:	fa040593          	addi	a1,s0,-96
     884:	00005097          	auipc	ra,0x5
     888:	64c080e7          	jalr	1612(ra) # 5ed0 <read>
  if(n != 4){
     88c:	4791                	li	a5,4
     88e:	0cf51e63          	bne	a0,a5,96a <truncate1+0x158>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     892:	40100593          	li	a1,1025
     896:	00006517          	auipc	a0,0x6
     89a:	bfa50513          	addi	a0,a0,-1030 # 6490 <malloc+0x19a>
     89e:	00005097          	auipc	ra,0x5
     8a2:	65a080e7          	jalr	1626(ra) # 5ef8 <open>
     8a6:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     8a8:	4581                	li	a1,0
     8aa:	00006517          	auipc	a0,0x6
     8ae:	be650513          	addi	a0,a0,-1050 # 6490 <malloc+0x19a>
     8b2:	00005097          	auipc	ra,0x5
     8b6:	646080e7          	jalr	1606(ra) # 5ef8 <open>
     8ba:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     8bc:	02000613          	li	a2,32
     8c0:	fa040593          	addi	a1,s0,-96
     8c4:	00005097          	auipc	ra,0x5
     8c8:	60c080e7          	jalr	1548(ra) # 5ed0 <read>
     8cc:	8a2a                	mv	s4,a0
  if(n != 0){
     8ce:	ed55                	bnez	a0,98a <truncate1+0x178>
  n = read(fd2, buf, sizeof(buf));
     8d0:	02000613          	li	a2,32
     8d4:	fa040593          	addi	a1,s0,-96
     8d8:	8526                	mv	a0,s1
     8da:	00005097          	auipc	ra,0x5
     8de:	5f6080e7          	jalr	1526(ra) # 5ed0 <read>
     8e2:	8a2a                	mv	s4,a0
  if(n != 0){
     8e4:	ed61                	bnez	a0,9bc <truncate1+0x1aa>
  write(fd1, "abcdef", 6);
     8e6:	4619                	li	a2,6
     8e8:	00006597          	auipc	a1,0x6
     8ec:	e2058593          	addi	a1,a1,-480 # 6708 <malloc+0x412>
     8f0:	854e                	mv	a0,s3
     8f2:	00005097          	auipc	ra,0x5
     8f6:	5e6080e7          	jalr	1510(ra) # 5ed8 <write>
  n = read(fd3, buf, sizeof(buf));
     8fa:	02000613          	li	a2,32
     8fe:	fa040593          	addi	a1,s0,-96
     902:	854a                	mv	a0,s2
     904:	00005097          	auipc	ra,0x5
     908:	5cc080e7          	jalr	1484(ra) # 5ed0 <read>
  if(n != 6){
     90c:	4799                	li	a5,6
     90e:	0ef51063          	bne	a0,a5,9ee <truncate1+0x1dc>
  n = read(fd2, buf, sizeof(buf));
     912:	02000613          	li	a2,32
     916:	fa040593          	addi	a1,s0,-96
     91a:	8526                	mv	a0,s1
     91c:	00005097          	auipc	ra,0x5
     920:	5b4080e7          	jalr	1460(ra) # 5ed0 <read>
  if(n != 2){
     924:	4789                	li	a5,2
     926:	0ef51463          	bne	a0,a5,a0e <truncate1+0x1fc>
  unlink("truncfile");
     92a:	00006517          	auipc	a0,0x6
     92e:	b6650513          	addi	a0,a0,-1178 # 6490 <malloc+0x19a>
     932:	00005097          	auipc	ra,0x5
     936:	5d6080e7          	jalr	1494(ra) # 5f08 <unlink>
  close(fd1);
     93a:	854e                	mv	a0,s3
     93c:	00005097          	auipc	ra,0x5
     940:	5a4080e7          	jalr	1444(ra) # 5ee0 <close>
  close(fd2);
     944:	8526                	mv	a0,s1
     946:	00005097          	auipc	ra,0x5
     94a:	59a080e7          	jalr	1434(ra) # 5ee0 <close>
  close(fd3);
     94e:	854a                	mv	a0,s2
     950:	00005097          	auipc	ra,0x5
     954:	590080e7          	jalr	1424(ra) # 5ee0 <close>
}
     958:	60e6                	ld	ra,88(sp)
     95a:	6446                	ld	s0,80(sp)
     95c:	64a6                	ld	s1,72(sp)
     95e:	6906                	ld	s2,64(sp)
     960:	79e2                	ld	s3,56(sp)
     962:	7a42                	ld	s4,48(sp)
     964:	7aa2                	ld	s5,40(sp)
     966:	6125                	addi	sp,sp,96
     968:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     96a:	862a                	mv	a2,a0
     96c:	85d6                	mv	a1,s5
     96e:	00006517          	auipc	a0,0x6
     972:	d3a50513          	addi	a0,a0,-710 # 66a8 <malloc+0x3b2>
     976:	00006097          	auipc	ra,0x6
     97a:	8c2080e7          	jalr	-1854(ra) # 6238 <printf>
    exit(1,0);
     97e:	4581                	li	a1,0
     980:	4505                	li	a0,1
     982:	00005097          	auipc	ra,0x5
     986:	536080e7          	jalr	1334(ra) # 5eb8 <exit>
    printf("aaa fd3=%d\n", fd3);
     98a:	85ca                	mv	a1,s2
     98c:	00006517          	auipc	a0,0x6
     990:	d3c50513          	addi	a0,a0,-708 # 66c8 <malloc+0x3d2>
     994:	00006097          	auipc	ra,0x6
     998:	8a4080e7          	jalr	-1884(ra) # 6238 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     99c:	8652                	mv	a2,s4
     99e:	85d6                	mv	a1,s5
     9a0:	00006517          	auipc	a0,0x6
     9a4:	d3850513          	addi	a0,a0,-712 # 66d8 <malloc+0x3e2>
     9a8:	00006097          	auipc	ra,0x6
     9ac:	890080e7          	jalr	-1904(ra) # 6238 <printf>
    exit(1,0);
     9b0:	4581                	li	a1,0
     9b2:	4505                	li	a0,1
     9b4:	00005097          	auipc	ra,0x5
     9b8:	504080e7          	jalr	1284(ra) # 5eb8 <exit>
    printf("bbb fd2=%d\n", fd2);
     9bc:	85a6                	mv	a1,s1
     9be:	00006517          	auipc	a0,0x6
     9c2:	d3a50513          	addi	a0,a0,-710 # 66f8 <malloc+0x402>
     9c6:	00006097          	auipc	ra,0x6
     9ca:	872080e7          	jalr	-1934(ra) # 6238 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     9ce:	8652                	mv	a2,s4
     9d0:	85d6                	mv	a1,s5
     9d2:	00006517          	auipc	a0,0x6
     9d6:	d0650513          	addi	a0,a0,-762 # 66d8 <malloc+0x3e2>
     9da:	00006097          	auipc	ra,0x6
     9de:	85e080e7          	jalr	-1954(ra) # 6238 <printf>
    exit(1,0);
     9e2:	4581                	li	a1,0
     9e4:	4505                	li	a0,1
     9e6:	00005097          	auipc	ra,0x5
     9ea:	4d2080e7          	jalr	1234(ra) # 5eb8 <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     9ee:	862a                	mv	a2,a0
     9f0:	85d6                	mv	a1,s5
     9f2:	00006517          	auipc	a0,0x6
     9f6:	d1e50513          	addi	a0,a0,-738 # 6710 <malloc+0x41a>
     9fa:	00006097          	auipc	ra,0x6
     9fe:	83e080e7          	jalr	-1986(ra) # 6238 <printf>
    exit(1,0);
     a02:	4581                	li	a1,0
     a04:	4505                	li	a0,1
     a06:	00005097          	auipc	ra,0x5
     a0a:	4b2080e7          	jalr	1202(ra) # 5eb8 <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     a0e:	862a                	mv	a2,a0
     a10:	85d6                	mv	a1,s5
     a12:	00006517          	auipc	a0,0x6
     a16:	d1e50513          	addi	a0,a0,-738 # 6730 <malloc+0x43a>
     a1a:	00006097          	auipc	ra,0x6
     a1e:	81e080e7          	jalr	-2018(ra) # 6238 <printf>
    exit(1,0);
     a22:	4581                	li	a1,0
     a24:	4505                	li	a0,1
     a26:	00005097          	auipc	ra,0x5
     a2a:	492080e7          	jalr	1170(ra) # 5eb8 <exit>

0000000000000a2e <writetest>:
{
     a2e:	7139                	addi	sp,sp,-64
     a30:	fc06                	sd	ra,56(sp)
     a32:	f822                	sd	s0,48(sp)
     a34:	f426                	sd	s1,40(sp)
     a36:	f04a                	sd	s2,32(sp)
     a38:	ec4e                	sd	s3,24(sp)
     a3a:	e852                	sd	s4,16(sp)
     a3c:	e456                	sd	s5,8(sp)
     a3e:	e05a                	sd	s6,0(sp)
     a40:	0080                	addi	s0,sp,64
     a42:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE|O_RDWR);
     a44:	20200593          	li	a1,514
     a48:	00006517          	auipc	a0,0x6
     a4c:	d0850513          	addi	a0,a0,-760 # 6750 <malloc+0x45a>
     a50:	00005097          	auipc	ra,0x5
     a54:	4a8080e7          	jalr	1192(ra) # 5ef8 <open>
  if(fd < 0){
     a58:	0a054d63          	bltz	a0,b12 <writetest+0xe4>
     a5c:	892a                	mv	s2,a0
     a5e:	4481                	li	s1,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     a60:	00006997          	auipc	s3,0x6
     a64:	d1898993          	addi	s3,s3,-744 # 6778 <malloc+0x482>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     a68:	00006a97          	auipc	s5,0x6
     a6c:	d48a8a93          	addi	s5,s5,-696 # 67b0 <malloc+0x4ba>
  for(i = 0; i < N; i++){
     a70:	06400a13          	li	s4,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     a74:	4629                	li	a2,10
     a76:	85ce                	mv	a1,s3
     a78:	854a                	mv	a0,s2
     a7a:	00005097          	auipc	ra,0x5
     a7e:	45e080e7          	jalr	1118(ra) # 5ed8 <write>
     a82:	47a9                	li	a5,10
     a84:	0af51663          	bne	a0,a5,b30 <writetest+0x102>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     a88:	4629                	li	a2,10
     a8a:	85d6                	mv	a1,s5
     a8c:	854a                	mv	a0,s2
     a8e:	00005097          	auipc	ra,0x5
     a92:	44a080e7          	jalr	1098(ra) # 5ed8 <write>
     a96:	47a9                	li	a5,10
     a98:	0af51c63          	bne	a0,a5,b50 <writetest+0x122>
  for(i = 0; i < N; i++){
     a9c:	2485                	addiw	s1,s1,1
     a9e:	fd449be3          	bne	s1,s4,a74 <writetest+0x46>
  close(fd);
     aa2:	854a                	mv	a0,s2
     aa4:	00005097          	auipc	ra,0x5
     aa8:	43c080e7          	jalr	1084(ra) # 5ee0 <close>
  fd = open("small", O_RDONLY);
     aac:	4581                	li	a1,0
     aae:	00006517          	auipc	a0,0x6
     ab2:	ca250513          	addi	a0,a0,-862 # 6750 <malloc+0x45a>
     ab6:	00005097          	auipc	ra,0x5
     aba:	442080e7          	jalr	1090(ra) # 5ef8 <open>
     abe:	84aa                	mv	s1,a0
  if(fd < 0){
     ac0:	0a054863          	bltz	a0,b70 <writetest+0x142>
  i = read(fd, buf, N*SZ*2);
     ac4:	7d000613          	li	a2,2000
     ac8:	0000c597          	auipc	a1,0xc
     acc:	1b058593          	addi	a1,a1,432 # cc78 <buf>
     ad0:	00005097          	auipc	ra,0x5
     ad4:	400080e7          	jalr	1024(ra) # 5ed0 <read>
  if(i != N*SZ*2){
     ad8:	7d000793          	li	a5,2000
     adc:	0af51963          	bne	a0,a5,b8e <writetest+0x160>
  close(fd);
     ae0:	8526                	mv	a0,s1
     ae2:	00005097          	auipc	ra,0x5
     ae6:	3fe080e7          	jalr	1022(ra) # 5ee0 <close>
  if(unlink("small") < 0){
     aea:	00006517          	auipc	a0,0x6
     aee:	c6650513          	addi	a0,a0,-922 # 6750 <malloc+0x45a>
     af2:	00005097          	auipc	ra,0x5
     af6:	416080e7          	jalr	1046(ra) # 5f08 <unlink>
     afa:	0a054963          	bltz	a0,bac <writetest+0x17e>
}
     afe:	70e2                	ld	ra,56(sp)
     b00:	7442                	ld	s0,48(sp)
     b02:	74a2                	ld	s1,40(sp)
     b04:	7902                	ld	s2,32(sp)
     b06:	69e2                	ld	s3,24(sp)
     b08:	6a42                	ld	s4,16(sp)
     b0a:	6aa2                	ld	s5,8(sp)
     b0c:	6b02                	ld	s6,0(sp)
     b0e:	6121                	addi	sp,sp,64
     b10:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     b12:	85da                	mv	a1,s6
     b14:	00006517          	auipc	a0,0x6
     b18:	c4450513          	addi	a0,a0,-956 # 6758 <malloc+0x462>
     b1c:	00005097          	auipc	ra,0x5
     b20:	71c080e7          	jalr	1820(ra) # 6238 <printf>
    exit(1,0);
     b24:	4581                	li	a1,0
     b26:	4505                	li	a0,1
     b28:	00005097          	auipc	ra,0x5
     b2c:	390080e7          	jalr	912(ra) # 5eb8 <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     b30:	8626                	mv	a2,s1
     b32:	85da                	mv	a1,s6
     b34:	00006517          	auipc	a0,0x6
     b38:	c5450513          	addi	a0,a0,-940 # 6788 <malloc+0x492>
     b3c:	00005097          	auipc	ra,0x5
     b40:	6fc080e7          	jalr	1788(ra) # 6238 <printf>
      exit(1,0);
     b44:	4581                	li	a1,0
     b46:	4505                	li	a0,1
     b48:	00005097          	auipc	ra,0x5
     b4c:	370080e7          	jalr	880(ra) # 5eb8 <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     b50:	8626                	mv	a2,s1
     b52:	85da                	mv	a1,s6
     b54:	00006517          	auipc	a0,0x6
     b58:	c6c50513          	addi	a0,a0,-916 # 67c0 <malloc+0x4ca>
     b5c:	00005097          	auipc	ra,0x5
     b60:	6dc080e7          	jalr	1756(ra) # 6238 <printf>
      exit(1,0);
     b64:	4581                	li	a1,0
     b66:	4505                	li	a0,1
     b68:	00005097          	auipc	ra,0x5
     b6c:	350080e7          	jalr	848(ra) # 5eb8 <exit>
    printf("%s: error: open small failed!\n", s);
     b70:	85da                	mv	a1,s6
     b72:	00006517          	auipc	a0,0x6
     b76:	c7650513          	addi	a0,a0,-906 # 67e8 <malloc+0x4f2>
     b7a:	00005097          	auipc	ra,0x5
     b7e:	6be080e7          	jalr	1726(ra) # 6238 <printf>
    exit(1,0);
     b82:	4581                	li	a1,0
     b84:	4505                	li	a0,1
     b86:	00005097          	auipc	ra,0x5
     b8a:	332080e7          	jalr	818(ra) # 5eb8 <exit>
    printf("%s: read failed\n", s);
     b8e:	85da                	mv	a1,s6
     b90:	00006517          	auipc	a0,0x6
     b94:	c7850513          	addi	a0,a0,-904 # 6808 <malloc+0x512>
     b98:	00005097          	auipc	ra,0x5
     b9c:	6a0080e7          	jalr	1696(ra) # 6238 <printf>
    exit(1,0);
     ba0:	4581                	li	a1,0
     ba2:	4505                	li	a0,1
     ba4:	00005097          	auipc	ra,0x5
     ba8:	314080e7          	jalr	788(ra) # 5eb8 <exit>
    printf("%s: unlink small failed\n", s);
     bac:	85da                	mv	a1,s6
     bae:	00006517          	auipc	a0,0x6
     bb2:	c7250513          	addi	a0,a0,-910 # 6820 <malloc+0x52a>
     bb6:	00005097          	auipc	ra,0x5
     bba:	682080e7          	jalr	1666(ra) # 6238 <printf>
    exit(1,0);
     bbe:	4581                	li	a1,0
     bc0:	4505                	li	a0,1
     bc2:	00005097          	auipc	ra,0x5
     bc6:	2f6080e7          	jalr	758(ra) # 5eb8 <exit>

0000000000000bca <writebig>:
{
     bca:	7139                	addi	sp,sp,-64
     bcc:	fc06                	sd	ra,56(sp)
     bce:	f822                	sd	s0,48(sp)
     bd0:	f426                	sd	s1,40(sp)
     bd2:	f04a                	sd	s2,32(sp)
     bd4:	ec4e                	sd	s3,24(sp)
     bd6:	e852                	sd	s4,16(sp)
     bd8:	e456                	sd	s5,8(sp)
     bda:	0080                	addi	s0,sp,64
     bdc:	8aaa                	mv	s5,a0
  fd = open("big", O_CREATE|O_RDWR);
     bde:	20200593          	li	a1,514
     be2:	00006517          	auipc	a0,0x6
     be6:	c5e50513          	addi	a0,a0,-930 # 6840 <malloc+0x54a>
     bea:	00005097          	auipc	ra,0x5
     bee:	30e080e7          	jalr	782(ra) # 5ef8 <open>
     bf2:	89aa                	mv	s3,a0
  for(i = 0; i < MAXFILE; i++){
     bf4:	4481                	li	s1,0
    ((int*)buf)[0] = i;
     bf6:	0000c917          	auipc	s2,0xc
     bfa:	08290913          	addi	s2,s2,130 # cc78 <buf>
  for(i = 0; i < MAXFILE; i++){
     bfe:	10c00a13          	li	s4,268
  if(fd < 0){
     c02:	06054c63          	bltz	a0,c7a <writebig+0xb0>
    ((int*)buf)[0] = i;
     c06:	00992023          	sw	s1,0(s2)
    if(write(fd, buf, BSIZE) != BSIZE){
     c0a:	40000613          	li	a2,1024
     c0e:	85ca                	mv	a1,s2
     c10:	854e                	mv	a0,s3
     c12:	00005097          	auipc	ra,0x5
     c16:	2c6080e7          	jalr	710(ra) # 5ed8 <write>
     c1a:	40000793          	li	a5,1024
     c1e:	06f51d63          	bne	a0,a5,c98 <writebig+0xce>
  for(i = 0; i < MAXFILE; i++){
     c22:	2485                	addiw	s1,s1,1
     c24:	ff4491e3          	bne	s1,s4,c06 <writebig+0x3c>
  close(fd);
     c28:	854e                	mv	a0,s3
     c2a:	00005097          	auipc	ra,0x5
     c2e:	2b6080e7          	jalr	694(ra) # 5ee0 <close>
  fd = open("big", O_RDONLY);
     c32:	4581                	li	a1,0
     c34:	00006517          	auipc	a0,0x6
     c38:	c0c50513          	addi	a0,a0,-1012 # 6840 <malloc+0x54a>
     c3c:	00005097          	auipc	ra,0x5
     c40:	2bc080e7          	jalr	700(ra) # 5ef8 <open>
     c44:	89aa                	mv	s3,a0
  n = 0;
     c46:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     c48:	0000c917          	auipc	s2,0xc
     c4c:	03090913          	addi	s2,s2,48 # cc78 <buf>
  if(fd < 0){
     c50:	06054463          	bltz	a0,cb8 <writebig+0xee>
    i = read(fd, buf, BSIZE);
     c54:	40000613          	li	a2,1024
     c58:	85ca                	mv	a1,s2
     c5a:	854e                	mv	a0,s3
     c5c:	00005097          	auipc	ra,0x5
     c60:	274080e7          	jalr	628(ra) # 5ed0 <read>
    if(i == 0){
     c64:	c92d                	beqz	a0,cd6 <writebig+0x10c>
    } else if(i != BSIZE){
     c66:	40000793          	li	a5,1024
     c6a:	0cf51363          	bne	a0,a5,d30 <writebig+0x166>
    if(((int*)buf)[0] != n){
     c6e:	00092683          	lw	a3,0(s2)
     c72:	0c969f63          	bne	a3,s1,d50 <writebig+0x186>
    n++;
     c76:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
     c78:	bff1                	j	c54 <writebig+0x8a>
    printf("%s: error: creat big failed!\n", s);
     c7a:	85d6                	mv	a1,s5
     c7c:	00006517          	auipc	a0,0x6
     c80:	bcc50513          	addi	a0,a0,-1076 # 6848 <malloc+0x552>
     c84:	00005097          	auipc	ra,0x5
     c88:	5b4080e7          	jalr	1460(ra) # 6238 <printf>
    exit(1,0);
     c8c:	4581                	li	a1,0
     c8e:	4505                	li	a0,1
     c90:	00005097          	auipc	ra,0x5
     c94:	228080e7          	jalr	552(ra) # 5eb8 <exit>
      printf("%s: error: write big file failed\n", s, i);
     c98:	8626                	mv	a2,s1
     c9a:	85d6                	mv	a1,s5
     c9c:	00006517          	auipc	a0,0x6
     ca0:	bcc50513          	addi	a0,a0,-1076 # 6868 <malloc+0x572>
     ca4:	00005097          	auipc	ra,0x5
     ca8:	594080e7          	jalr	1428(ra) # 6238 <printf>
      exit(1,0);
     cac:	4581                	li	a1,0
     cae:	4505                	li	a0,1
     cb0:	00005097          	auipc	ra,0x5
     cb4:	208080e7          	jalr	520(ra) # 5eb8 <exit>
    printf("%s: error: open big failed!\n", s);
     cb8:	85d6                	mv	a1,s5
     cba:	00006517          	auipc	a0,0x6
     cbe:	bd650513          	addi	a0,a0,-1066 # 6890 <malloc+0x59a>
     cc2:	00005097          	auipc	ra,0x5
     cc6:	576080e7          	jalr	1398(ra) # 6238 <printf>
    exit(1,0);
     cca:	4581                	li	a1,0
     ccc:	4505                	li	a0,1
     cce:	00005097          	auipc	ra,0x5
     cd2:	1ea080e7          	jalr	490(ra) # 5eb8 <exit>
      if(n == MAXFILE - 1){
     cd6:	10b00793          	li	a5,267
     cda:	02f48a63          	beq	s1,a5,d0e <writebig+0x144>
  close(fd);
     cde:	854e                	mv	a0,s3
     ce0:	00005097          	auipc	ra,0x5
     ce4:	200080e7          	jalr	512(ra) # 5ee0 <close>
  if(unlink("big") < 0){
     ce8:	00006517          	auipc	a0,0x6
     cec:	b5850513          	addi	a0,a0,-1192 # 6840 <malloc+0x54a>
     cf0:	00005097          	auipc	ra,0x5
     cf4:	218080e7          	jalr	536(ra) # 5f08 <unlink>
     cf8:	06054c63          	bltz	a0,d70 <writebig+0x1a6>
}
     cfc:	70e2                	ld	ra,56(sp)
     cfe:	7442                	ld	s0,48(sp)
     d00:	74a2                	ld	s1,40(sp)
     d02:	7902                	ld	s2,32(sp)
     d04:	69e2                	ld	s3,24(sp)
     d06:	6a42                	ld	s4,16(sp)
     d08:	6aa2                	ld	s5,8(sp)
     d0a:	6121                	addi	sp,sp,64
     d0c:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     d0e:	10b00613          	li	a2,267
     d12:	85d6                	mv	a1,s5
     d14:	00006517          	auipc	a0,0x6
     d18:	b9c50513          	addi	a0,a0,-1124 # 68b0 <malloc+0x5ba>
     d1c:	00005097          	auipc	ra,0x5
     d20:	51c080e7          	jalr	1308(ra) # 6238 <printf>
        exit(1,0);
     d24:	4581                	li	a1,0
     d26:	4505                	li	a0,1
     d28:	00005097          	auipc	ra,0x5
     d2c:	190080e7          	jalr	400(ra) # 5eb8 <exit>
      printf("%s: read failed %d\n", s, i);
     d30:	862a                	mv	a2,a0
     d32:	85d6                	mv	a1,s5
     d34:	00006517          	auipc	a0,0x6
     d38:	ba450513          	addi	a0,a0,-1116 # 68d8 <malloc+0x5e2>
     d3c:	00005097          	auipc	ra,0x5
     d40:	4fc080e7          	jalr	1276(ra) # 6238 <printf>
      exit(1,0);
     d44:	4581                	li	a1,0
     d46:	4505                	li	a0,1
     d48:	00005097          	auipc	ra,0x5
     d4c:	170080e7          	jalr	368(ra) # 5eb8 <exit>
      printf("%s: read content of block %d is %d\n", s,
     d50:	8626                	mv	a2,s1
     d52:	85d6                	mv	a1,s5
     d54:	00006517          	auipc	a0,0x6
     d58:	b9c50513          	addi	a0,a0,-1124 # 68f0 <malloc+0x5fa>
     d5c:	00005097          	auipc	ra,0x5
     d60:	4dc080e7          	jalr	1244(ra) # 6238 <printf>
      exit(1,0);
     d64:	4581                	li	a1,0
     d66:	4505                	li	a0,1
     d68:	00005097          	auipc	ra,0x5
     d6c:	150080e7          	jalr	336(ra) # 5eb8 <exit>
    printf("%s: unlink big failed\n", s);
     d70:	85d6                	mv	a1,s5
     d72:	00006517          	auipc	a0,0x6
     d76:	ba650513          	addi	a0,a0,-1114 # 6918 <malloc+0x622>
     d7a:	00005097          	auipc	ra,0x5
     d7e:	4be080e7          	jalr	1214(ra) # 6238 <printf>
    exit(1,0);
     d82:	4581                	li	a1,0
     d84:	4505                	li	a0,1
     d86:	00005097          	auipc	ra,0x5
     d8a:	132080e7          	jalr	306(ra) # 5eb8 <exit>

0000000000000d8e <unlinkread>:
{
     d8e:	7179                	addi	sp,sp,-48
     d90:	f406                	sd	ra,40(sp)
     d92:	f022                	sd	s0,32(sp)
     d94:	ec26                	sd	s1,24(sp)
     d96:	e84a                	sd	s2,16(sp)
     d98:	e44e                	sd	s3,8(sp)
     d9a:	1800                	addi	s0,sp,48
     d9c:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     d9e:	20200593          	li	a1,514
     da2:	00006517          	auipc	a0,0x6
     da6:	b8e50513          	addi	a0,a0,-1138 # 6930 <malloc+0x63a>
     daa:	00005097          	auipc	ra,0x5
     dae:	14e080e7          	jalr	334(ra) # 5ef8 <open>
  if(fd < 0){
     db2:	0e054563          	bltz	a0,e9c <unlinkread+0x10e>
     db6:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     db8:	4615                	li	a2,5
     dba:	00006597          	auipc	a1,0x6
     dbe:	ba658593          	addi	a1,a1,-1114 # 6960 <malloc+0x66a>
     dc2:	00005097          	auipc	ra,0x5
     dc6:	116080e7          	jalr	278(ra) # 5ed8 <write>
  close(fd);
     dca:	8526                	mv	a0,s1
     dcc:	00005097          	auipc	ra,0x5
     dd0:	114080e7          	jalr	276(ra) # 5ee0 <close>
  fd = open("unlinkread", O_RDWR);
     dd4:	4589                	li	a1,2
     dd6:	00006517          	auipc	a0,0x6
     dda:	b5a50513          	addi	a0,a0,-1190 # 6930 <malloc+0x63a>
     dde:	00005097          	auipc	ra,0x5
     de2:	11a080e7          	jalr	282(ra) # 5ef8 <open>
     de6:	84aa                	mv	s1,a0
  if(fd < 0){
     de8:	0c054963          	bltz	a0,eba <unlinkread+0x12c>
  if(unlink("unlinkread") != 0){
     dec:	00006517          	auipc	a0,0x6
     df0:	b4450513          	addi	a0,a0,-1212 # 6930 <malloc+0x63a>
     df4:	00005097          	auipc	ra,0x5
     df8:	114080e7          	jalr	276(ra) # 5f08 <unlink>
     dfc:	ed71                	bnez	a0,ed8 <unlinkread+0x14a>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     dfe:	20200593          	li	a1,514
     e02:	00006517          	auipc	a0,0x6
     e06:	b2e50513          	addi	a0,a0,-1234 # 6930 <malloc+0x63a>
     e0a:	00005097          	auipc	ra,0x5
     e0e:	0ee080e7          	jalr	238(ra) # 5ef8 <open>
     e12:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     e14:	460d                	li	a2,3
     e16:	00006597          	auipc	a1,0x6
     e1a:	b9258593          	addi	a1,a1,-1134 # 69a8 <malloc+0x6b2>
     e1e:	00005097          	auipc	ra,0x5
     e22:	0ba080e7          	jalr	186(ra) # 5ed8 <write>
  close(fd1);
     e26:	854a                	mv	a0,s2
     e28:	00005097          	auipc	ra,0x5
     e2c:	0b8080e7          	jalr	184(ra) # 5ee0 <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     e30:	660d                	lui	a2,0x3
     e32:	0000c597          	auipc	a1,0xc
     e36:	e4658593          	addi	a1,a1,-442 # cc78 <buf>
     e3a:	8526                	mv	a0,s1
     e3c:	00005097          	auipc	ra,0x5
     e40:	094080e7          	jalr	148(ra) # 5ed0 <read>
     e44:	4795                	li	a5,5
     e46:	0af51863          	bne	a0,a5,ef6 <unlinkread+0x168>
  if(buf[0] != 'h'){
     e4a:	0000c717          	auipc	a4,0xc
     e4e:	e2e74703          	lbu	a4,-466(a4) # cc78 <buf>
     e52:	06800793          	li	a5,104
     e56:	0af71f63          	bne	a4,a5,f14 <unlinkread+0x186>
  if(write(fd, buf, 10) != 10){
     e5a:	4629                	li	a2,10
     e5c:	0000c597          	auipc	a1,0xc
     e60:	e1c58593          	addi	a1,a1,-484 # cc78 <buf>
     e64:	8526                	mv	a0,s1
     e66:	00005097          	auipc	ra,0x5
     e6a:	072080e7          	jalr	114(ra) # 5ed8 <write>
     e6e:	47a9                	li	a5,10
     e70:	0cf51163          	bne	a0,a5,f32 <unlinkread+0x1a4>
  close(fd);
     e74:	8526                	mv	a0,s1
     e76:	00005097          	auipc	ra,0x5
     e7a:	06a080e7          	jalr	106(ra) # 5ee0 <close>
  unlink("unlinkread");
     e7e:	00006517          	auipc	a0,0x6
     e82:	ab250513          	addi	a0,a0,-1358 # 6930 <malloc+0x63a>
     e86:	00005097          	auipc	ra,0x5
     e8a:	082080e7          	jalr	130(ra) # 5f08 <unlink>
}
     e8e:	70a2                	ld	ra,40(sp)
     e90:	7402                	ld	s0,32(sp)
     e92:	64e2                	ld	s1,24(sp)
     e94:	6942                	ld	s2,16(sp)
     e96:	69a2                	ld	s3,8(sp)
     e98:	6145                	addi	sp,sp,48
     e9a:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     e9c:	85ce                	mv	a1,s3
     e9e:	00006517          	auipc	a0,0x6
     ea2:	aa250513          	addi	a0,a0,-1374 # 6940 <malloc+0x64a>
     ea6:	00005097          	auipc	ra,0x5
     eaa:	392080e7          	jalr	914(ra) # 6238 <printf>
    exit(1,0);
     eae:	4581                	li	a1,0
     eb0:	4505                	li	a0,1
     eb2:	00005097          	auipc	ra,0x5
     eb6:	006080e7          	jalr	6(ra) # 5eb8 <exit>
    printf("%s: open unlinkread failed\n", s);
     eba:	85ce                	mv	a1,s3
     ebc:	00006517          	auipc	a0,0x6
     ec0:	aac50513          	addi	a0,a0,-1364 # 6968 <malloc+0x672>
     ec4:	00005097          	auipc	ra,0x5
     ec8:	374080e7          	jalr	884(ra) # 6238 <printf>
    exit(1,0);
     ecc:	4581                	li	a1,0
     ece:	4505                	li	a0,1
     ed0:	00005097          	auipc	ra,0x5
     ed4:	fe8080e7          	jalr	-24(ra) # 5eb8 <exit>
    printf("%s: unlink unlinkread failed\n", s);
     ed8:	85ce                	mv	a1,s3
     eda:	00006517          	auipc	a0,0x6
     ede:	aae50513          	addi	a0,a0,-1362 # 6988 <malloc+0x692>
     ee2:	00005097          	auipc	ra,0x5
     ee6:	356080e7          	jalr	854(ra) # 6238 <printf>
    exit(1,0);
     eea:	4581                	li	a1,0
     eec:	4505                	li	a0,1
     eee:	00005097          	auipc	ra,0x5
     ef2:	fca080e7          	jalr	-54(ra) # 5eb8 <exit>
    printf("%s: unlinkread read failed", s);
     ef6:	85ce                	mv	a1,s3
     ef8:	00006517          	auipc	a0,0x6
     efc:	ab850513          	addi	a0,a0,-1352 # 69b0 <malloc+0x6ba>
     f00:	00005097          	auipc	ra,0x5
     f04:	338080e7          	jalr	824(ra) # 6238 <printf>
    exit(1,0);
     f08:	4581                	li	a1,0
     f0a:	4505                	li	a0,1
     f0c:	00005097          	auipc	ra,0x5
     f10:	fac080e7          	jalr	-84(ra) # 5eb8 <exit>
    printf("%s: unlinkread wrong data\n", s);
     f14:	85ce                	mv	a1,s3
     f16:	00006517          	auipc	a0,0x6
     f1a:	aba50513          	addi	a0,a0,-1350 # 69d0 <malloc+0x6da>
     f1e:	00005097          	auipc	ra,0x5
     f22:	31a080e7          	jalr	794(ra) # 6238 <printf>
    exit(1,0);
     f26:	4581                	li	a1,0
     f28:	4505                	li	a0,1
     f2a:	00005097          	auipc	ra,0x5
     f2e:	f8e080e7          	jalr	-114(ra) # 5eb8 <exit>
    printf("%s: unlinkread write failed\n", s);
     f32:	85ce                	mv	a1,s3
     f34:	00006517          	auipc	a0,0x6
     f38:	abc50513          	addi	a0,a0,-1348 # 69f0 <malloc+0x6fa>
     f3c:	00005097          	auipc	ra,0x5
     f40:	2fc080e7          	jalr	764(ra) # 6238 <printf>
    exit(1,0);
     f44:	4581                	li	a1,0
     f46:	4505                	li	a0,1
     f48:	00005097          	auipc	ra,0x5
     f4c:	f70080e7          	jalr	-144(ra) # 5eb8 <exit>

0000000000000f50 <linktest>:
{
     f50:	1101                	addi	sp,sp,-32
     f52:	ec06                	sd	ra,24(sp)
     f54:	e822                	sd	s0,16(sp)
     f56:	e426                	sd	s1,8(sp)
     f58:	e04a                	sd	s2,0(sp)
     f5a:	1000                	addi	s0,sp,32
     f5c:	892a                	mv	s2,a0
  unlink("lf1");
     f5e:	00006517          	auipc	a0,0x6
     f62:	ab250513          	addi	a0,a0,-1358 # 6a10 <malloc+0x71a>
     f66:	00005097          	auipc	ra,0x5
     f6a:	fa2080e7          	jalr	-94(ra) # 5f08 <unlink>
  unlink("lf2");
     f6e:	00006517          	auipc	a0,0x6
     f72:	aaa50513          	addi	a0,a0,-1366 # 6a18 <malloc+0x722>
     f76:	00005097          	auipc	ra,0x5
     f7a:	f92080e7          	jalr	-110(ra) # 5f08 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
     f7e:	20200593          	li	a1,514
     f82:	00006517          	auipc	a0,0x6
     f86:	a8e50513          	addi	a0,a0,-1394 # 6a10 <malloc+0x71a>
     f8a:	00005097          	auipc	ra,0x5
     f8e:	f6e080e7          	jalr	-146(ra) # 5ef8 <open>
  if(fd < 0){
     f92:	10054763          	bltz	a0,10a0 <linktest+0x150>
     f96:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
     f98:	4615                	li	a2,5
     f9a:	00006597          	auipc	a1,0x6
     f9e:	9c658593          	addi	a1,a1,-1594 # 6960 <malloc+0x66a>
     fa2:	00005097          	auipc	ra,0x5
     fa6:	f36080e7          	jalr	-202(ra) # 5ed8 <write>
     faa:	4795                	li	a5,5
     fac:	10f51963          	bne	a0,a5,10be <linktest+0x16e>
  close(fd);
     fb0:	8526                	mv	a0,s1
     fb2:	00005097          	auipc	ra,0x5
     fb6:	f2e080e7          	jalr	-210(ra) # 5ee0 <close>
  if(link("lf1", "lf2") < 0){
     fba:	00006597          	auipc	a1,0x6
     fbe:	a5e58593          	addi	a1,a1,-1442 # 6a18 <malloc+0x722>
     fc2:	00006517          	auipc	a0,0x6
     fc6:	a4e50513          	addi	a0,a0,-1458 # 6a10 <malloc+0x71a>
     fca:	00005097          	auipc	ra,0x5
     fce:	f4e080e7          	jalr	-178(ra) # 5f18 <link>
     fd2:	10054563          	bltz	a0,10dc <linktest+0x18c>
  unlink("lf1");
     fd6:	00006517          	auipc	a0,0x6
     fda:	a3a50513          	addi	a0,a0,-1478 # 6a10 <malloc+0x71a>
     fde:	00005097          	auipc	ra,0x5
     fe2:	f2a080e7          	jalr	-214(ra) # 5f08 <unlink>
  if(open("lf1", 0) >= 0){
     fe6:	4581                	li	a1,0
     fe8:	00006517          	auipc	a0,0x6
     fec:	a2850513          	addi	a0,a0,-1496 # 6a10 <malloc+0x71a>
     ff0:	00005097          	auipc	ra,0x5
     ff4:	f08080e7          	jalr	-248(ra) # 5ef8 <open>
     ff8:	10055163          	bgez	a0,10fa <linktest+0x1aa>
  fd = open("lf2", 0);
     ffc:	4581                	li	a1,0
     ffe:	00006517          	auipc	a0,0x6
    1002:	a1a50513          	addi	a0,a0,-1510 # 6a18 <malloc+0x722>
    1006:	00005097          	auipc	ra,0x5
    100a:	ef2080e7          	jalr	-270(ra) # 5ef8 <open>
    100e:	84aa                	mv	s1,a0
  if(fd < 0){
    1010:	10054463          	bltz	a0,1118 <linktest+0x1c8>
  if(read(fd, buf, sizeof(buf)) != SZ){
    1014:	660d                	lui	a2,0x3
    1016:	0000c597          	auipc	a1,0xc
    101a:	c6258593          	addi	a1,a1,-926 # cc78 <buf>
    101e:	00005097          	auipc	ra,0x5
    1022:	eb2080e7          	jalr	-334(ra) # 5ed0 <read>
    1026:	4795                	li	a5,5
    1028:	10f51763          	bne	a0,a5,1136 <linktest+0x1e6>
  close(fd);
    102c:	8526                	mv	a0,s1
    102e:	00005097          	auipc	ra,0x5
    1032:	eb2080e7          	jalr	-334(ra) # 5ee0 <close>
  if(link("lf2", "lf2") >= 0){
    1036:	00006597          	auipc	a1,0x6
    103a:	9e258593          	addi	a1,a1,-1566 # 6a18 <malloc+0x722>
    103e:	852e                	mv	a0,a1
    1040:	00005097          	auipc	ra,0x5
    1044:	ed8080e7          	jalr	-296(ra) # 5f18 <link>
    1048:	10055663          	bgez	a0,1154 <linktest+0x204>
  unlink("lf2");
    104c:	00006517          	auipc	a0,0x6
    1050:	9cc50513          	addi	a0,a0,-1588 # 6a18 <malloc+0x722>
    1054:	00005097          	auipc	ra,0x5
    1058:	eb4080e7          	jalr	-332(ra) # 5f08 <unlink>
  if(link("lf2", "lf1") >= 0){
    105c:	00006597          	auipc	a1,0x6
    1060:	9b458593          	addi	a1,a1,-1612 # 6a10 <malloc+0x71a>
    1064:	00006517          	auipc	a0,0x6
    1068:	9b450513          	addi	a0,a0,-1612 # 6a18 <malloc+0x722>
    106c:	00005097          	auipc	ra,0x5
    1070:	eac080e7          	jalr	-340(ra) # 5f18 <link>
    1074:	0e055f63          	bgez	a0,1172 <linktest+0x222>
  if(link(".", "lf1") >= 0){
    1078:	00006597          	auipc	a1,0x6
    107c:	99858593          	addi	a1,a1,-1640 # 6a10 <malloc+0x71a>
    1080:	00006517          	auipc	a0,0x6
    1084:	aa050513          	addi	a0,a0,-1376 # 6b20 <malloc+0x82a>
    1088:	00005097          	auipc	ra,0x5
    108c:	e90080e7          	jalr	-368(ra) # 5f18 <link>
    1090:	10055063          	bgez	a0,1190 <linktest+0x240>
}
    1094:	60e2                	ld	ra,24(sp)
    1096:	6442                	ld	s0,16(sp)
    1098:	64a2                	ld	s1,8(sp)
    109a:	6902                	ld	s2,0(sp)
    109c:	6105                	addi	sp,sp,32
    109e:	8082                	ret
    printf("%s: create lf1 failed\n", s);
    10a0:	85ca                	mv	a1,s2
    10a2:	00006517          	auipc	a0,0x6
    10a6:	97e50513          	addi	a0,a0,-1666 # 6a20 <malloc+0x72a>
    10aa:	00005097          	auipc	ra,0x5
    10ae:	18e080e7          	jalr	398(ra) # 6238 <printf>
    exit(1,0);
    10b2:	4581                	li	a1,0
    10b4:	4505                	li	a0,1
    10b6:	00005097          	auipc	ra,0x5
    10ba:	e02080e7          	jalr	-510(ra) # 5eb8 <exit>
    printf("%s: write lf1 failed\n", s);
    10be:	85ca                	mv	a1,s2
    10c0:	00006517          	auipc	a0,0x6
    10c4:	97850513          	addi	a0,a0,-1672 # 6a38 <malloc+0x742>
    10c8:	00005097          	auipc	ra,0x5
    10cc:	170080e7          	jalr	368(ra) # 6238 <printf>
    exit(1,0);
    10d0:	4581                	li	a1,0
    10d2:	4505                	li	a0,1
    10d4:	00005097          	auipc	ra,0x5
    10d8:	de4080e7          	jalr	-540(ra) # 5eb8 <exit>
    printf("%s: link lf1 lf2 failed\n", s);
    10dc:	85ca                	mv	a1,s2
    10de:	00006517          	auipc	a0,0x6
    10e2:	97250513          	addi	a0,a0,-1678 # 6a50 <malloc+0x75a>
    10e6:	00005097          	auipc	ra,0x5
    10ea:	152080e7          	jalr	338(ra) # 6238 <printf>
    exit(1,0);
    10ee:	4581                	li	a1,0
    10f0:	4505                	li	a0,1
    10f2:	00005097          	auipc	ra,0x5
    10f6:	dc6080e7          	jalr	-570(ra) # 5eb8 <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
    10fa:	85ca                	mv	a1,s2
    10fc:	00006517          	auipc	a0,0x6
    1100:	97450513          	addi	a0,a0,-1676 # 6a70 <malloc+0x77a>
    1104:	00005097          	auipc	ra,0x5
    1108:	134080e7          	jalr	308(ra) # 6238 <printf>
    exit(1,0);
    110c:	4581                	li	a1,0
    110e:	4505                	li	a0,1
    1110:	00005097          	auipc	ra,0x5
    1114:	da8080e7          	jalr	-600(ra) # 5eb8 <exit>
    printf("%s: open lf2 failed\n", s);
    1118:	85ca                	mv	a1,s2
    111a:	00006517          	auipc	a0,0x6
    111e:	98650513          	addi	a0,a0,-1658 # 6aa0 <malloc+0x7aa>
    1122:	00005097          	auipc	ra,0x5
    1126:	116080e7          	jalr	278(ra) # 6238 <printf>
    exit(1,0);
    112a:	4581                	li	a1,0
    112c:	4505                	li	a0,1
    112e:	00005097          	auipc	ra,0x5
    1132:	d8a080e7          	jalr	-630(ra) # 5eb8 <exit>
    printf("%s: read lf2 failed\n", s);
    1136:	85ca                	mv	a1,s2
    1138:	00006517          	auipc	a0,0x6
    113c:	98050513          	addi	a0,a0,-1664 # 6ab8 <malloc+0x7c2>
    1140:	00005097          	auipc	ra,0x5
    1144:	0f8080e7          	jalr	248(ra) # 6238 <printf>
    exit(1,0);
    1148:	4581                	li	a1,0
    114a:	4505                	li	a0,1
    114c:	00005097          	auipc	ra,0x5
    1150:	d6c080e7          	jalr	-660(ra) # 5eb8 <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
    1154:	85ca                	mv	a1,s2
    1156:	00006517          	auipc	a0,0x6
    115a:	97a50513          	addi	a0,a0,-1670 # 6ad0 <malloc+0x7da>
    115e:	00005097          	auipc	ra,0x5
    1162:	0da080e7          	jalr	218(ra) # 6238 <printf>
    exit(1,0);
    1166:	4581                	li	a1,0
    1168:	4505                	li	a0,1
    116a:	00005097          	auipc	ra,0x5
    116e:	d4e080e7          	jalr	-690(ra) # 5eb8 <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
    1172:	85ca                	mv	a1,s2
    1174:	00006517          	auipc	a0,0x6
    1178:	98450513          	addi	a0,a0,-1660 # 6af8 <malloc+0x802>
    117c:	00005097          	auipc	ra,0x5
    1180:	0bc080e7          	jalr	188(ra) # 6238 <printf>
    exit(1,0);
    1184:	4581                	li	a1,0
    1186:	4505                	li	a0,1
    1188:	00005097          	auipc	ra,0x5
    118c:	d30080e7          	jalr	-720(ra) # 5eb8 <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
    1190:	85ca                	mv	a1,s2
    1192:	00006517          	auipc	a0,0x6
    1196:	99650513          	addi	a0,a0,-1642 # 6b28 <malloc+0x832>
    119a:	00005097          	auipc	ra,0x5
    119e:	09e080e7          	jalr	158(ra) # 6238 <printf>
    exit(1,0);
    11a2:	4581                	li	a1,0
    11a4:	4505                	li	a0,1
    11a6:	00005097          	auipc	ra,0x5
    11aa:	d12080e7          	jalr	-750(ra) # 5eb8 <exit>

00000000000011ae <validatetest>:
{
    11ae:	7139                	addi	sp,sp,-64
    11b0:	fc06                	sd	ra,56(sp)
    11b2:	f822                	sd	s0,48(sp)
    11b4:	f426                	sd	s1,40(sp)
    11b6:	f04a                	sd	s2,32(sp)
    11b8:	ec4e                	sd	s3,24(sp)
    11ba:	e852                	sd	s4,16(sp)
    11bc:	e456                	sd	s5,8(sp)
    11be:	e05a                	sd	s6,0(sp)
    11c0:	0080                	addi	s0,sp,64
    11c2:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    11c4:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
    11c6:	00006997          	auipc	s3,0x6
    11ca:	98298993          	addi	s3,s3,-1662 # 6b48 <malloc+0x852>
    11ce:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    11d0:	6a85                	lui	s5,0x1
    11d2:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
    11d6:	85a6                	mv	a1,s1
    11d8:	854e                	mv	a0,s3
    11da:	00005097          	auipc	ra,0x5
    11de:	d3e080e7          	jalr	-706(ra) # 5f18 <link>
    11e2:	01251f63          	bne	a0,s2,1200 <validatetest+0x52>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    11e6:	94d6                	add	s1,s1,s5
    11e8:	ff4497e3          	bne	s1,s4,11d6 <validatetest+0x28>
}
    11ec:	70e2                	ld	ra,56(sp)
    11ee:	7442                	ld	s0,48(sp)
    11f0:	74a2                	ld	s1,40(sp)
    11f2:	7902                	ld	s2,32(sp)
    11f4:	69e2                	ld	s3,24(sp)
    11f6:	6a42                	ld	s4,16(sp)
    11f8:	6aa2                	ld	s5,8(sp)
    11fa:	6b02                	ld	s6,0(sp)
    11fc:	6121                	addi	sp,sp,64
    11fe:	8082                	ret
      printf("%s: link should not succeed\n", s);
    1200:	85da                	mv	a1,s6
    1202:	00006517          	auipc	a0,0x6
    1206:	95650513          	addi	a0,a0,-1706 # 6b58 <malloc+0x862>
    120a:	00005097          	auipc	ra,0x5
    120e:	02e080e7          	jalr	46(ra) # 6238 <printf>
      exit(1,0);
    1212:	4581                	li	a1,0
    1214:	4505                	li	a0,1
    1216:	00005097          	auipc	ra,0x5
    121a:	ca2080e7          	jalr	-862(ra) # 5eb8 <exit>

000000000000121e <bigdir>:
{
    121e:	715d                	addi	sp,sp,-80
    1220:	e486                	sd	ra,72(sp)
    1222:	e0a2                	sd	s0,64(sp)
    1224:	fc26                	sd	s1,56(sp)
    1226:	f84a                	sd	s2,48(sp)
    1228:	f44e                	sd	s3,40(sp)
    122a:	f052                	sd	s4,32(sp)
    122c:	ec56                	sd	s5,24(sp)
    122e:	e85a                	sd	s6,16(sp)
    1230:	0880                	addi	s0,sp,80
    1232:	89aa                	mv	s3,a0
  unlink("bd");
    1234:	00006517          	auipc	a0,0x6
    1238:	94450513          	addi	a0,a0,-1724 # 6b78 <malloc+0x882>
    123c:	00005097          	auipc	ra,0x5
    1240:	ccc080e7          	jalr	-820(ra) # 5f08 <unlink>
  fd = open("bd", O_CREATE);
    1244:	20000593          	li	a1,512
    1248:	00006517          	auipc	a0,0x6
    124c:	93050513          	addi	a0,a0,-1744 # 6b78 <malloc+0x882>
    1250:	00005097          	auipc	ra,0x5
    1254:	ca8080e7          	jalr	-856(ra) # 5ef8 <open>
  if(fd < 0){
    1258:	0c054963          	bltz	a0,132a <bigdir+0x10c>
  close(fd);
    125c:	00005097          	auipc	ra,0x5
    1260:	c84080e7          	jalr	-892(ra) # 5ee0 <close>
  for(i = 0; i < N; i++){
    1264:	4901                	li	s2,0
    name[0] = 'x';
    1266:	07800a93          	li	s5,120
    if(link("bd", name) != 0){
    126a:	00006a17          	auipc	s4,0x6
    126e:	90ea0a13          	addi	s4,s4,-1778 # 6b78 <malloc+0x882>
  for(i = 0; i < N; i++){
    1272:	1f400b13          	li	s6,500
    name[0] = 'x';
    1276:	fb540823          	sb	s5,-80(s0)
    name[1] = '0' + (i / 64);
    127a:	41f9579b          	sraiw	a5,s2,0x1f
    127e:	01a7d71b          	srliw	a4,a5,0x1a
    1282:	012707bb          	addw	a5,a4,s2
    1286:	4067d69b          	sraiw	a3,a5,0x6
    128a:	0306869b          	addiw	a3,a3,48
    128e:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    1292:	03f7f793          	andi	a5,a5,63
    1296:	9f99                	subw	a5,a5,a4
    1298:	0307879b          	addiw	a5,a5,48
    129c:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    12a0:	fa0409a3          	sb	zero,-77(s0)
    if(link("bd", name) != 0){
    12a4:	fb040593          	addi	a1,s0,-80
    12a8:	8552                	mv	a0,s4
    12aa:	00005097          	auipc	ra,0x5
    12ae:	c6e080e7          	jalr	-914(ra) # 5f18 <link>
    12b2:	84aa                	mv	s1,a0
    12b4:	e951                	bnez	a0,1348 <bigdir+0x12a>
  for(i = 0; i < N; i++){
    12b6:	2905                	addiw	s2,s2,1
    12b8:	fb691fe3          	bne	s2,s6,1276 <bigdir+0x58>
  unlink("bd");
    12bc:	00006517          	auipc	a0,0x6
    12c0:	8bc50513          	addi	a0,a0,-1860 # 6b78 <malloc+0x882>
    12c4:	00005097          	auipc	ra,0x5
    12c8:	c44080e7          	jalr	-956(ra) # 5f08 <unlink>
    name[0] = 'x';
    12cc:	07800913          	li	s2,120
  for(i = 0; i < N; i++){
    12d0:	1f400a13          	li	s4,500
    name[0] = 'x';
    12d4:	fb240823          	sb	s2,-80(s0)
    name[1] = '0' + (i / 64);
    12d8:	41f4d79b          	sraiw	a5,s1,0x1f
    12dc:	01a7d71b          	srliw	a4,a5,0x1a
    12e0:	009707bb          	addw	a5,a4,s1
    12e4:	4067d69b          	sraiw	a3,a5,0x6
    12e8:	0306869b          	addiw	a3,a3,48
    12ec:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    12f0:	03f7f793          	andi	a5,a5,63
    12f4:	9f99                	subw	a5,a5,a4
    12f6:	0307879b          	addiw	a5,a5,48
    12fa:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    12fe:	fa0409a3          	sb	zero,-77(s0)
    if(unlink(name) != 0){
    1302:	fb040513          	addi	a0,s0,-80
    1306:	00005097          	auipc	ra,0x5
    130a:	c02080e7          	jalr	-1022(ra) # 5f08 <unlink>
    130e:	ed31                	bnez	a0,136a <bigdir+0x14c>
  for(i = 0; i < N; i++){
    1310:	2485                	addiw	s1,s1,1
    1312:	fd4491e3          	bne	s1,s4,12d4 <bigdir+0xb6>
}
    1316:	60a6                	ld	ra,72(sp)
    1318:	6406                	ld	s0,64(sp)
    131a:	74e2                	ld	s1,56(sp)
    131c:	7942                	ld	s2,48(sp)
    131e:	79a2                	ld	s3,40(sp)
    1320:	7a02                	ld	s4,32(sp)
    1322:	6ae2                	ld	s5,24(sp)
    1324:	6b42                	ld	s6,16(sp)
    1326:	6161                	addi	sp,sp,80
    1328:	8082                	ret
    printf("%s: bigdir create failed\n", s);
    132a:	85ce                	mv	a1,s3
    132c:	00006517          	auipc	a0,0x6
    1330:	85450513          	addi	a0,a0,-1964 # 6b80 <malloc+0x88a>
    1334:	00005097          	auipc	ra,0x5
    1338:	f04080e7          	jalr	-252(ra) # 6238 <printf>
    exit(1,0);
    133c:	4581                	li	a1,0
    133e:	4505                	li	a0,1
    1340:	00005097          	auipc	ra,0x5
    1344:	b78080e7          	jalr	-1160(ra) # 5eb8 <exit>
      printf("%s: bigdir link(bd, %s) failed\n", s, name);
    1348:	fb040613          	addi	a2,s0,-80
    134c:	85ce                	mv	a1,s3
    134e:	00006517          	auipc	a0,0x6
    1352:	85250513          	addi	a0,a0,-1966 # 6ba0 <malloc+0x8aa>
    1356:	00005097          	auipc	ra,0x5
    135a:	ee2080e7          	jalr	-286(ra) # 6238 <printf>
      exit(1,0);
    135e:	4581                	li	a1,0
    1360:	4505                	li	a0,1
    1362:	00005097          	auipc	ra,0x5
    1366:	b56080e7          	jalr	-1194(ra) # 5eb8 <exit>
      printf("%s: bigdir unlink failed", s);
    136a:	85ce                	mv	a1,s3
    136c:	00006517          	auipc	a0,0x6
    1370:	85450513          	addi	a0,a0,-1964 # 6bc0 <malloc+0x8ca>
    1374:	00005097          	auipc	ra,0x5
    1378:	ec4080e7          	jalr	-316(ra) # 6238 <printf>
      exit(1,0);
    137c:	4581                	li	a1,0
    137e:	4505                	li	a0,1
    1380:	00005097          	auipc	ra,0x5
    1384:	b38080e7          	jalr	-1224(ra) # 5eb8 <exit>

0000000000001388 <pgbug>:
{
    1388:	7179                	addi	sp,sp,-48
    138a:	f406                	sd	ra,40(sp)
    138c:	f022                	sd	s0,32(sp)
    138e:	ec26                	sd	s1,24(sp)
    1390:	1800                	addi	s0,sp,48
  argv[0] = 0;
    1392:	fc043c23          	sd	zero,-40(s0)
  exec(big, argv);
    1396:	00008497          	auipc	s1,0x8
    139a:	c6a48493          	addi	s1,s1,-918 # 9000 <big>
    139e:	fd840593          	addi	a1,s0,-40
    13a2:	6088                	ld	a0,0(s1)
    13a4:	00005097          	auipc	ra,0x5
    13a8:	b4c080e7          	jalr	-1204(ra) # 5ef0 <exec>
  pipe(big);
    13ac:	6088                	ld	a0,0(s1)
    13ae:	00005097          	auipc	ra,0x5
    13b2:	b1a080e7          	jalr	-1254(ra) # 5ec8 <pipe>
  exit(0,0);
    13b6:	4581                	li	a1,0
    13b8:	4501                	li	a0,0
    13ba:	00005097          	auipc	ra,0x5
    13be:	afe080e7          	jalr	-1282(ra) # 5eb8 <exit>

00000000000013c2 <badarg>:
{
    13c2:	7139                	addi	sp,sp,-64
    13c4:	fc06                	sd	ra,56(sp)
    13c6:	f822                	sd	s0,48(sp)
    13c8:	f426                	sd	s1,40(sp)
    13ca:	f04a                	sd	s2,32(sp)
    13cc:	ec4e                	sd	s3,24(sp)
    13ce:	0080                	addi	s0,sp,64
    13d0:	64b1                	lui	s1,0xc
    13d2:	35048493          	addi	s1,s1,848 # c350 <uninit+0x1de8>
    argv[0] = (char*)0xffffffff;
    13d6:	597d                	li	s2,-1
    13d8:	02095913          	srli	s2,s2,0x20
    exec("echo", argv);
    13dc:	00005997          	auipc	s3,0x5
    13e0:	05c98993          	addi	s3,s3,92 # 6438 <malloc+0x142>
    argv[0] = (char*)0xffffffff;
    13e4:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    13e8:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    13ec:	fc040593          	addi	a1,s0,-64
    13f0:	854e                	mv	a0,s3
    13f2:	00005097          	auipc	ra,0x5
    13f6:	afe080e7          	jalr	-1282(ra) # 5ef0 <exec>
  for(int i = 0; i < 50000; i++){
    13fa:	34fd                	addiw	s1,s1,-1
    13fc:	f4e5                	bnez	s1,13e4 <badarg+0x22>
  exit(0,0);
    13fe:	4581                	li	a1,0
    1400:	4501                	li	a0,0
    1402:	00005097          	auipc	ra,0x5
    1406:	ab6080e7          	jalr	-1354(ra) # 5eb8 <exit>

000000000000140a <copyinstr2>:
{
    140a:	7155                	addi	sp,sp,-208
    140c:	e586                	sd	ra,200(sp)
    140e:	e1a2                	sd	s0,192(sp)
    1410:	0980                	addi	s0,sp,208
  for(int i = 0; i < MAXPATH; i++)
    1412:	f6840793          	addi	a5,s0,-152
    1416:	fe840693          	addi	a3,s0,-24
    b[i] = 'x';
    141a:	07800713          	li	a4,120
    141e:	00e78023          	sb	a4,0(a5)
  for(int i = 0; i < MAXPATH; i++)
    1422:	0785                	addi	a5,a5,1
    1424:	fed79de3          	bne	a5,a3,141e <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    1428:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    142c:	f6840513          	addi	a0,s0,-152
    1430:	00005097          	auipc	ra,0x5
    1434:	ad8080e7          	jalr	-1320(ra) # 5f08 <unlink>
  if(ret != -1){
    1438:	57fd                	li	a5,-1
    143a:	0ef51163          	bne	a0,a5,151c <copyinstr2+0x112>
  int fd = open(b, O_CREATE | O_WRONLY);
    143e:	20100593          	li	a1,513
    1442:	f6840513          	addi	a0,s0,-152
    1446:	00005097          	auipc	ra,0x5
    144a:	ab2080e7          	jalr	-1358(ra) # 5ef8 <open>
  if(fd != -1){
    144e:	57fd                	li	a5,-1
    1450:	0ef51763          	bne	a0,a5,153e <copyinstr2+0x134>
  ret = link(b, b);
    1454:	f6840593          	addi	a1,s0,-152
    1458:	852e                	mv	a0,a1
    145a:	00005097          	auipc	ra,0x5
    145e:	abe080e7          	jalr	-1346(ra) # 5f18 <link>
  if(ret != -1){
    1462:	57fd                	li	a5,-1
    1464:	0ef51e63          	bne	a0,a5,1560 <copyinstr2+0x156>
  char *args[] = { "xx", 0 };
    1468:	00007797          	auipc	a5,0x7
    146c:	9b078793          	addi	a5,a5,-1616 # 7e18 <malloc+0x1b22>
    1470:	f4f43c23          	sd	a5,-168(s0)
    1474:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    1478:	f5840593          	addi	a1,s0,-168
    147c:	f6840513          	addi	a0,s0,-152
    1480:	00005097          	auipc	ra,0x5
    1484:	a70080e7          	jalr	-1424(ra) # 5ef0 <exec>
  if(ret != -1){
    1488:	57fd                	li	a5,-1
    148a:	0ef51d63          	bne	a0,a5,1584 <copyinstr2+0x17a>
  int pid = fork();
    148e:	00005097          	auipc	ra,0x5
    1492:	a22080e7          	jalr	-1502(ra) # 5eb0 <fork>
  if(pid < 0){
    1496:	10054863          	bltz	a0,15a6 <copyinstr2+0x19c>
  if(pid == 0){
    149a:	12051b63          	bnez	a0,15d0 <copyinstr2+0x1c6>
    149e:	00008797          	auipc	a5,0x8
    14a2:	0c278793          	addi	a5,a5,194 # 9560 <big.0>
    14a6:	00009697          	auipc	a3,0x9
    14aa:	0ba68693          	addi	a3,a3,186 # a560 <big.0+0x1000>
      big[i] = 'x';
    14ae:	07800713          	li	a4,120
    14b2:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
    14b6:	0785                	addi	a5,a5,1
    14b8:	fed79de3          	bne	a5,a3,14b2 <copyinstr2+0xa8>
    big[PGSIZE] = '\0';
    14bc:	00009797          	auipc	a5,0x9
    14c0:	0a078223          	sb	zero,164(a5) # a560 <big.0+0x1000>
    char *args2[] = { big, big, big, 0 };
    14c4:	00007797          	auipc	a5,0x7
    14c8:	37478793          	addi	a5,a5,884 # 8838 <malloc+0x2542>
    14cc:	6390                	ld	a2,0(a5)
    14ce:	6794                	ld	a3,8(a5)
    14d0:	6b98                	ld	a4,16(a5)
    14d2:	6f9c                	ld	a5,24(a5)
    14d4:	f2c43823          	sd	a2,-208(s0)
    14d8:	f2d43c23          	sd	a3,-200(s0)
    14dc:	f4e43023          	sd	a4,-192(s0)
    14e0:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    14e4:	f3040593          	addi	a1,s0,-208
    14e8:	00005517          	auipc	a0,0x5
    14ec:	f5050513          	addi	a0,a0,-176 # 6438 <malloc+0x142>
    14f0:	00005097          	auipc	ra,0x5
    14f4:	a00080e7          	jalr	-1536(ra) # 5ef0 <exec>
    if(ret != -1){
    14f8:	57fd                	li	a5,-1
    14fa:	0cf50463          	beq	a0,a5,15c2 <copyinstr2+0x1b8>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    14fe:	55fd                	li	a1,-1
    1500:	00005517          	auipc	a0,0x5
    1504:	76850513          	addi	a0,a0,1896 # 6c68 <malloc+0x972>
    1508:	00005097          	auipc	ra,0x5
    150c:	d30080e7          	jalr	-720(ra) # 6238 <printf>
      exit(1,0);
    1510:	4581                	li	a1,0
    1512:	4505                	li	a0,1
    1514:	00005097          	auipc	ra,0x5
    1518:	9a4080e7          	jalr	-1628(ra) # 5eb8 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    151c:	862a                	mv	a2,a0
    151e:	f6840593          	addi	a1,s0,-152
    1522:	00005517          	auipc	a0,0x5
    1526:	6be50513          	addi	a0,a0,1726 # 6be0 <malloc+0x8ea>
    152a:	00005097          	auipc	ra,0x5
    152e:	d0e080e7          	jalr	-754(ra) # 6238 <printf>
    exit(1,0);
    1532:	4581                	li	a1,0
    1534:	4505                	li	a0,1
    1536:	00005097          	auipc	ra,0x5
    153a:	982080e7          	jalr	-1662(ra) # 5eb8 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    153e:	862a                	mv	a2,a0
    1540:	f6840593          	addi	a1,s0,-152
    1544:	00005517          	auipc	a0,0x5
    1548:	6bc50513          	addi	a0,a0,1724 # 6c00 <malloc+0x90a>
    154c:	00005097          	auipc	ra,0x5
    1550:	cec080e7          	jalr	-788(ra) # 6238 <printf>
    exit(1,0);
    1554:	4581                	li	a1,0
    1556:	4505                	li	a0,1
    1558:	00005097          	auipc	ra,0x5
    155c:	960080e7          	jalr	-1696(ra) # 5eb8 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    1560:	86aa                	mv	a3,a0
    1562:	f6840613          	addi	a2,s0,-152
    1566:	85b2                	mv	a1,a2
    1568:	00005517          	auipc	a0,0x5
    156c:	6b850513          	addi	a0,a0,1720 # 6c20 <malloc+0x92a>
    1570:	00005097          	auipc	ra,0x5
    1574:	cc8080e7          	jalr	-824(ra) # 6238 <printf>
    exit(1,0);
    1578:	4581                	li	a1,0
    157a:	4505                	li	a0,1
    157c:	00005097          	auipc	ra,0x5
    1580:	93c080e7          	jalr	-1732(ra) # 5eb8 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    1584:	567d                	li	a2,-1
    1586:	f6840593          	addi	a1,s0,-152
    158a:	00005517          	auipc	a0,0x5
    158e:	6be50513          	addi	a0,a0,1726 # 6c48 <malloc+0x952>
    1592:	00005097          	auipc	ra,0x5
    1596:	ca6080e7          	jalr	-858(ra) # 6238 <printf>
    exit(1,0);
    159a:	4581                	li	a1,0
    159c:	4505                	li	a0,1
    159e:	00005097          	auipc	ra,0x5
    15a2:	91a080e7          	jalr	-1766(ra) # 5eb8 <exit>
    printf("fork failed\n");
    15a6:	00006517          	auipc	a0,0x6
    15aa:	b2250513          	addi	a0,a0,-1246 # 70c8 <malloc+0xdd2>
    15ae:	00005097          	auipc	ra,0x5
    15b2:	c8a080e7          	jalr	-886(ra) # 6238 <printf>
    exit(1,0);
    15b6:	4581                	li	a1,0
    15b8:	4505                	li	a0,1
    15ba:	00005097          	auipc	ra,0x5
    15be:	8fe080e7          	jalr	-1794(ra) # 5eb8 <exit>
    exit(747,0); // OK
    15c2:	4581                	li	a1,0
    15c4:	2eb00513          	li	a0,747
    15c8:	00005097          	auipc	ra,0x5
    15cc:	8f0080e7          	jalr	-1808(ra) # 5eb8 <exit>
  int st = 0;
    15d0:	f4042a23          	sw	zero,-172(s0)
  wait(&st,0);
    15d4:	4581                	li	a1,0
    15d6:	f5440513          	addi	a0,s0,-172
    15da:	00005097          	auipc	ra,0x5
    15de:	8e6080e7          	jalr	-1818(ra) # 5ec0 <wait>
  if(st != 747){
    15e2:	f5442703          	lw	a4,-172(s0)
    15e6:	2eb00793          	li	a5,747
    15ea:	00f71663          	bne	a4,a5,15f6 <copyinstr2+0x1ec>
}
    15ee:	60ae                	ld	ra,200(sp)
    15f0:	640e                	ld	s0,192(sp)
    15f2:	6169                	addi	sp,sp,208
    15f4:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    15f6:	00005517          	auipc	a0,0x5
    15fa:	69a50513          	addi	a0,a0,1690 # 6c90 <malloc+0x99a>
    15fe:	00005097          	auipc	ra,0x5
    1602:	c3a080e7          	jalr	-966(ra) # 6238 <printf>
    exit(1,0);
    1606:	4581                	li	a1,0
    1608:	4505                	li	a0,1
    160a:	00005097          	auipc	ra,0x5
    160e:	8ae080e7          	jalr	-1874(ra) # 5eb8 <exit>

0000000000001612 <truncate3>:
{
    1612:	7159                	addi	sp,sp,-112
    1614:	f486                	sd	ra,104(sp)
    1616:	f0a2                	sd	s0,96(sp)
    1618:	eca6                	sd	s1,88(sp)
    161a:	e8ca                	sd	s2,80(sp)
    161c:	e4ce                	sd	s3,72(sp)
    161e:	e0d2                	sd	s4,64(sp)
    1620:	fc56                	sd	s5,56(sp)
    1622:	1880                	addi	s0,sp,112
    1624:	892a                	mv	s2,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    1626:	60100593          	li	a1,1537
    162a:	00005517          	auipc	a0,0x5
    162e:	e6650513          	addi	a0,a0,-410 # 6490 <malloc+0x19a>
    1632:	00005097          	auipc	ra,0x5
    1636:	8c6080e7          	jalr	-1850(ra) # 5ef8 <open>
    163a:	00005097          	auipc	ra,0x5
    163e:	8a6080e7          	jalr	-1882(ra) # 5ee0 <close>
  pid = fork();
    1642:	00005097          	auipc	ra,0x5
    1646:	86e080e7          	jalr	-1938(ra) # 5eb0 <fork>
  if(pid < 0){
    164a:	08054163          	bltz	a0,16cc <truncate3+0xba>
  if(pid == 0){
    164e:	ed69                	bnez	a0,1728 <truncate3+0x116>
    1650:	06400993          	li	s3,100
      int fd = open("truncfile", O_WRONLY);
    1654:	00005a17          	auipc	s4,0x5
    1658:	e3ca0a13          	addi	s4,s4,-452 # 6490 <malloc+0x19a>
      int n = write(fd, "1234567890", 10);
    165c:	00005a97          	auipc	s5,0x5
    1660:	694a8a93          	addi	s5,s5,1684 # 6cf0 <malloc+0x9fa>
      int fd = open("truncfile", O_WRONLY);
    1664:	4585                	li	a1,1
    1666:	8552                	mv	a0,s4
    1668:	00005097          	auipc	ra,0x5
    166c:	890080e7          	jalr	-1904(ra) # 5ef8 <open>
    1670:	84aa                	mv	s1,a0
      if(fd < 0){
    1672:	06054c63          	bltz	a0,16ea <truncate3+0xd8>
      int n = write(fd, "1234567890", 10);
    1676:	4629                	li	a2,10
    1678:	85d6                	mv	a1,s5
    167a:	00005097          	auipc	ra,0x5
    167e:	85e080e7          	jalr	-1954(ra) # 5ed8 <write>
      if(n != 10){
    1682:	47a9                	li	a5,10
    1684:	08f51263          	bne	a0,a5,1708 <truncate3+0xf6>
      close(fd);
    1688:	8526                	mv	a0,s1
    168a:	00005097          	auipc	ra,0x5
    168e:	856080e7          	jalr	-1962(ra) # 5ee0 <close>
      fd = open("truncfile", O_RDONLY);
    1692:	4581                	li	a1,0
    1694:	8552                	mv	a0,s4
    1696:	00005097          	auipc	ra,0x5
    169a:	862080e7          	jalr	-1950(ra) # 5ef8 <open>
    169e:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    16a0:	02000613          	li	a2,32
    16a4:	f9840593          	addi	a1,s0,-104
    16a8:	00005097          	auipc	ra,0x5
    16ac:	828080e7          	jalr	-2008(ra) # 5ed0 <read>
      close(fd);
    16b0:	8526                	mv	a0,s1
    16b2:	00005097          	auipc	ra,0x5
    16b6:	82e080e7          	jalr	-2002(ra) # 5ee0 <close>
    for(int i = 0; i < 100; i++){
    16ba:	39fd                	addiw	s3,s3,-1
    16bc:	fa0994e3          	bnez	s3,1664 <truncate3+0x52>
    exit(0,0);
    16c0:	4581                	li	a1,0
    16c2:	4501                	li	a0,0
    16c4:	00004097          	auipc	ra,0x4
    16c8:	7f4080e7          	jalr	2036(ra) # 5eb8 <exit>
    printf("%s: fork failed\n", s);
    16cc:	85ca                	mv	a1,s2
    16ce:	00005517          	auipc	a0,0x5
    16d2:	5f250513          	addi	a0,a0,1522 # 6cc0 <malloc+0x9ca>
    16d6:	00005097          	auipc	ra,0x5
    16da:	b62080e7          	jalr	-1182(ra) # 6238 <printf>
    exit(1,0);
    16de:	4581                	li	a1,0
    16e0:	4505                	li	a0,1
    16e2:	00004097          	auipc	ra,0x4
    16e6:	7d6080e7          	jalr	2006(ra) # 5eb8 <exit>
        printf("%s: open failed\n", s);
    16ea:	85ca                	mv	a1,s2
    16ec:	00005517          	auipc	a0,0x5
    16f0:	5ec50513          	addi	a0,a0,1516 # 6cd8 <malloc+0x9e2>
    16f4:	00005097          	auipc	ra,0x5
    16f8:	b44080e7          	jalr	-1212(ra) # 6238 <printf>
        exit(1,0);
    16fc:	4581                	li	a1,0
    16fe:	4505                	li	a0,1
    1700:	00004097          	auipc	ra,0x4
    1704:	7b8080e7          	jalr	1976(ra) # 5eb8 <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    1708:	862a                	mv	a2,a0
    170a:	85ca                	mv	a1,s2
    170c:	00005517          	auipc	a0,0x5
    1710:	5f450513          	addi	a0,a0,1524 # 6d00 <malloc+0xa0a>
    1714:	00005097          	auipc	ra,0x5
    1718:	b24080e7          	jalr	-1244(ra) # 6238 <printf>
        exit(1,0);
    171c:	4581                	li	a1,0
    171e:	4505                	li	a0,1
    1720:	00004097          	auipc	ra,0x4
    1724:	798080e7          	jalr	1944(ra) # 5eb8 <exit>
    1728:	09600993          	li	s3,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    172c:	00005a17          	auipc	s4,0x5
    1730:	d64a0a13          	addi	s4,s4,-668 # 6490 <malloc+0x19a>
    int n = write(fd, "xxx", 3);
    1734:	00005a97          	auipc	s5,0x5
    1738:	5eca8a93          	addi	s5,s5,1516 # 6d20 <malloc+0xa2a>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    173c:	60100593          	li	a1,1537
    1740:	8552                	mv	a0,s4
    1742:	00004097          	auipc	ra,0x4
    1746:	7b6080e7          	jalr	1974(ra) # 5ef8 <open>
    174a:	84aa                	mv	s1,a0
    if(fd < 0){
    174c:	04054963          	bltz	a0,179e <truncate3+0x18c>
    int n = write(fd, "xxx", 3);
    1750:	460d                	li	a2,3
    1752:	85d6                	mv	a1,s5
    1754:	00004097          	auipc	ra,0x4
    1758:	784080e7          	jalr	1924(ra) # 5ed8 <write>
    if(n != 3){
    175c:	478d                	li	a5,3
    175e:	04f51f63          	bne	a0,a5,17bc <truncate3+0x1aa>
    close(fd);
    1762:	8526                	mv	a0,s1
    1764:	00004097          	auipc	ra,0x4
    1768:	77c080e7          	jalr	1916(ra) # 5ee0 <close>
  for(int i = 0; i < 150; i++){
    176c:	39fd                	addiw	s3,s3,-1
    176e:	fc0997e3          	bnez	s3,173c <truncate3+0x12a>
  wait(&xstatus,0);
    1772:	4581                	li	a1,0
    1774:	fbc40513          	addi	a0,s0,-68
    1778:	00004097          	auipc	ra,0x4
    177c:	748080e7          	jalr	1864(ra) # 5ec0 <wait>
  unlink("truncfile");
    1780:	00005517          	auipc	a0,0x5
    1784:	d1050513          	addi	a0,a0,-752 # 6490 <malloc+0x19a>
    1788:	00004097          	auipc	ra,0x4
    178c:	780080e7          	jalr	1920(ra) # 5f08 <unlink>
  exit(xstatus,0);
    1790:	4581                	li	a1,0
    1792:	fbc42503          	lw	a0,-68(s0)
    1796:	00004097          	auipc	ra,0x4
    179a:	722080e7          	jalr	1826(ra) # 5eb8 <exit>
      printf("%s: open failed\n", s);
    179e:	85ca                	mv	a1,s2
    17a0:	00005517          	auipc	a0,0x5
    17a4:	53850513          	addi	a0,a0,1336 # 6cd8 <malloc+0x9e2>
    17a8:	00005097          	auipc	ra,0x5
    17ac:	a90080e7          	jalr	-1392(ra) # 6238 <printf>
      exit(1,0);
    17b0:	4581                	li	a1,0
    17b2:	4505                	li	a0,1
    17b4:	00004097          	auipc	ra,0x4
    17b8:	704080e7          	jalr	1796(ra) # 5eb8 <exit>
      printf("%s: write got %d, expected 3\n", s, n);
    17bc:	862a                	mv	a2,a0
    17be:	85ca                	mv	a1,s2
    17c0:	00005517          	auipc	a0,0x5
    17c4:	56850513          	addi	a0,a0,1384 # 6d28 <malloc+0xa32>
    17c8:	00005097          	auipc	ra,0x5
    17cc:	a70080e7          	jalr	-1424(ra) # 6238 <printf>
      exit(1,0);
    17d0:	4581                	li	a1,0
    17d2:	4505                	li	a0,1
    17d4:	00004097          	auipc	ra,0x4
    17d8:	6e4080e7          	jalr	1764(ra) # 5eb8 <exit>

00000000000017dc <exectest>:
{
    17dc:	715d                	addi	sp,sp,-80
    17de:	e486                	sd	ra,72(sp)
    17e0:	e0a2                	sd	s0,64(sp)
    17e2:	fc26                	sd	s1,56(sp)
    17e4:	f84a                	sd	s2,48(sp)
    17e6:	0880                	addi	s0,sp,80
    17e8:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    17ea:	00005797          	auipc	a5,0x5
    17ee:	c4e78793          	addi	a5,a5,-946 # 6438 <malloc+0x142>
    17f2:	fcf43023          	sd	a5,-64(s0)
    17f6:	00005797          	auipc	a5,0x5
    17fa:	55278793          	addi	a5,a5,1362 # 6d48 <malloc+0xa52>
    17fe:	fcf43423          	sd	a5,-56(s0)
    1802:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    1806:	00005517          	auipc	a0,0x5
    180a:	54a50513          	addi	a0,a0,1354 # 6d50 <malloc+0xa5a>
    180e:	00004097          	auipc	ra,0x4
    1812:	6fa080e7          	jalr	1786(ra) # 5f08 <unlink>
  pid = fork();
    1816:	00004097          	auipc	ra,0x4
    181a:	69a080e7          	jalr	1690(ra) # 5eb0 <fork>
  if(pid < 0) {
    181e:	04054763          	bltz	a0,186c <exectest+0x90>
    1822:	84aa                	mv	s1,a0
  if(pid == 0) {
    1824:	ed51                	bnez	a0,18c0 <exectest+0xe4>
    close(1);
    1826:	4505                	li	a0,1
    1828:	00004097          	auipc	ra,0x4
    182c:	6b8080e7          	jalr	1720(ra) # 5ee0 <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    1830:	20100593          	li	a1,513
    1834:	00005517          	auipc	a0,0x5
    1838:	51c50513          	addi	a0,a0,1308 # 6d50 <malloc+0xa5a>
    183c:	00004097          	auipc	ra,0x4
    1840:	6bc080e7          	jalr	1724(ra) # 5ef8 <open>
    if(fd < 0) {
    1844:	04054363          	bltz	a0,188a <exectest+0xae>
    if(fd != 1) {
    1848:	4785                	li	a5,1
    184a:	04f50f63          	beq	a0,a5,18a8 <exectest+0xcc>
      printf("%s: wrong fd\n", s);
    184e:	85ca                	mv	a1,s2
    1850:	00005517          	auipc	a0,0x5
    1854:	52050513          	addi	a0,a0,1312 # 6d70 <malloc+0xa7a>
    1858:	00005097          	auipc	ra,0x5
    185c:	9e0080e7          	jalr	-1568(ra) # 6238 <printf>
      exit(1,0);
    1860:	4581                	li	a1,0
    1862:	4505                	li	a0,1
    1864:	00004097          	auipc	ra,0x4
    1868:	654080e7          	jalr	1620(ra) # 5eb8 <exit>
     printf("%s: fork failed\n", s);
    186c:	85ca                	mv	a1,s2
    186e:	00005517          	auipc	a0,0x5
    1872:	45250513          	addi	a0,a0,1106 # 6cc0 <malloc+0x9ca>
    1876:	00005097          	auipc	ra,0x5
    187a:	9c2080e7          	jalr	-1598(ra) # 6238 <printf>
     exit(1,0);
    187e:	4581                	li	a1,0
    1880:	4505                	li	a0,1
    1882:	00004097          	auipc	ra,0x4
    1886:	636080e7          	jalr	1590(ra) # 5eb8 <exit>
      printf("%s: create failed\n", s);
    188a:	85ca                	mv	a1,s2
    188c:	00005517          	auipc	a0,0x5
    1890:	4cc50513          	addi	a0,a0,1228 # 6d58 <malloc+0xa62>
    1894:	00005097          	auipc	ra,0x5
    1898:	9a4080e7          	jalr	-1628(ra) # 6238 <printf>
      exit(1,0);
    189c:	4581                	li	a1,0
    189e:	4505                	li	a0,1
    18a0:	00004097          	auipc	ra,0x4
    18a4:	618080e7          	jalr	1560(ra) # 5eb8 <exit>
    if(exec("echo", echoargv) < 0){
    18a8:	fc040593          	addi	a1,s0,-64
    18ac:	00005517          	auipc	a0,0x5
    18b0:	b8c50513          	addi	a0,a0,-1140 # 6438 <malloc+0x142>
    18b4:	00004097          	auipc	ra,0x4
    18b8:	63c080e7          	jalr	1596(ra) # 5ef0 <exec>
    18bc:	02054363          	bltz	a0,18e2 <exectest+0x106>
  if (wait(&xstatus,0) != pid) {
    18c0:	4581                	li	a1,0
    18c2:	fdc40513          	addi	a0,s0,-36
    18c6:	00004097          	auipc	ra,0x4
    18ca:	5fa080e7          	jalr	1530(ra) # 5ec0 <wait>
    18ce:	02951963          	bne	a0,s1,1900 <exectest+0x124>
  if(xstatus != 0)
    18d2:	fdc42503          	lw	a0,-36(s0)
    18d6:	cd1d                	beqz	a0,1914 <exectest+0x138>
    exit(xstatus,0);
    18d8:	4581                	li	a1,0
    18da:	00004097          	auipc	ra,0x4
    18de:	5de080e7          	jalr	1502(ra) # 5eb8 <exit>
      printf("%s: exec echo failed\n", s);
    18e2:	85ca                	mv	a1,s2
    18e4:	00005517          	auipc	a0,0x5
    18e8:	49c50513          	addi	a0,a0,1180 # 6d80 <malloc+0xa8a>
    18ec:	00005097          	auipc	ra,0x5
    18f0:	94c080e7          	jalr	-1716(ra) # 6238 <printf>
      exit(1,0);
    18f4:	4581                	li	a1,0
    18f6:	4505                	li	a0,1
    18f8:	00004097          	auipc	ra,0x4
    18fc:	5c0080e7          	jalr	1472(ra) # 5eb8 <exit>
    printf("%s: wait failed!\n", s);
    1900:	85ca                	mv	a1,s2
    1902:	00005517          	auipc	a0,0x5
    1906:	49650513          	addi	a0,a0,1174 # 6d98 <malloc+0xaa2>
    190a:	00005097          	auipc	ra,0x5
    190e:	92e080e7          	jalr	-1746(ra) # 6238 <printf>
    1912:	b7c1                	j	18d2 <exectest+0xf6>
  fd = open("echo-ok", O_RDONLY);
    1914:	4581                	li	a1,0
    1916:	00005517          	auipc	a0,0x5
    191a:	43a50513          	addi	a0,a0,1082 # 6d50 <malloc+0xa5a>
    191e:	00004097          	auipc	ra,0x4
    1922:	5da080e7          	jalr	1498(ra) # 5ef8 <open>
  if(fd < 0) {
    1926:	02054b63          	bltz	a0,195c <exectest+0x180>
  if (read(fd, buf, 2) != 2) {
    192a:	4609                	li	a2,2
    192c:	fb840593          	addi	a1,s0,-72
    1930:	00004097          	auipc	ra,0x4
    1934:	5a0080e7          	jalr	1440(ra) # 5ed0 <read>
    1938:	4789                	li	a5,2
    193a:	04f50063          	beq	a0,a5,197a <exectest+0x19e>
    printf("%s: read failed\n", s);
    193e:	85ca                	mv	a1,s2
    1940:	00005517          	auipc	a0,0x5
    1944:	ec850513          	addi	a0,a0,-312 # 6808 <malloc+0x512>
    1948:	00005097          	auipc	ra,0x5
    194c:	8f0080e7          	jalr	-1808(ra) # 6238 <printf>
    exit(1,0);
    1950:	4581                	li	a1,0
    1952:	4505                	li	a0,1
    1954:	00004097          	auipc	ra,0x4
    1958:	564080e7          	jalr	1380(ra) # 5eb8 <exit>
    printf("%s: open failed\n", s);
    195c:	85ca                	mv	a1,s2
    195e:	00005517          	auipc	a0,0x5
    1962:	37a50513          	addi	a0,a0,890 # 6cd8 <malloc+0x9e2>
    1966:	00005097          	auipc	ra,0x5
    196a:	8d2080e7          	jalr	-1838(ra) # 6238 <printf>
    exit(1,0);
    196e:	4581                	li	a1,0
    1970:	4505                	li	a0,1
    1972:	00004097          	auipc	ra,0x4
    1976:	546080e7          	jalr	1350(ra) # 5eb8 <exit>
  unlink("echo-ok");
    197a:	00005517          	auipc	a0,0x5
    197e:	3d650513          	addi	a0,a0,982 # 6d50 <malloc+0xa5a>
    1982:	00004097          	auipc	ra,0x4
    1986:	586080e7          	jalr	1414(ra) # 5f08 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    198a:	fb844703          	lbu	a4,-72(s0)
    198e:	04f00793          	li	a5,79
    1992:	00f71863          	bne	a4,a5,19a2 <exectest+0x1c6>
    1996:	fb944703          	lbu	a4,-71(s0)
    199a:	04b00793          	li	a5,75
    199e:	02f70163          	beq	a4,a5,19c0 <exectest+0x1e4>
    printf("%s: wrong output\n", s);
    19a2:	85ca                	mv	a1,s2
    19a4:	00005517          	auipc	a0,0x5
    19a8:	40c50513          	addi	a0,a0,1036 # 6db0 <malloc+0xaba>
    19ac:	00005097          	auipc	ra,0x5
    19b0:	88c080e7          	jalr	-1908(ra) # 6238 <printf>
    exit(1,0);
    19b4:	4581                	li	a1,0
    19b6:	4505                	li	a0,1
    19b8:	00004097          	auipc	ra,0x4
    19bc:	500080e7          	jalr	1280(ra) # 5eb8 <exit>
    exit(0,0);
    19c0:	4581                	li	a1,0
    19c2:	4501                	li	a0,0
    19c4:	00004097          	auipc	ra,0x4
    19c8:	4f4080e7          	jalr	1268(ra) # 5eb8 <exit>

00000000000019cc <pipe1>:
{
    19cc:	711d                	addi	sp,sp,-96
    19ce:	ec86                	sd	ra,88(sp)
    19d0:	e8a2                	sd	s0,80(sp)
    19d2:	e4a6                	sd	s1,72(sp)
    19d4:	e0ca                	sd	s2,64(sp)
    19d6:	fc4e                	sd	s3,56(sp)
    19d8:	f852                	sd	s4,48(sp)
    19da:	f456                	sd	s5,40(sp)
    19dc:	f05a                	sd	s6,32(sp)
    19de:	ec5e                	sd	s7,24(sp)
    19e0:	1080                	addi	s0,sp,96
    19e2:	892a                	mv	s2,a0
  if(pipe(fds) != 0){
    19e4:	fa840513          	addi	a0,s0,-88
    19e8:	00004097          	auipc	ra,0x4
    19ec:	4e0080e7          	jalr	1248(ra) # 5ec8 <pipe>
    19f0:	ed25                	bnez	a0,1a68 <pipe1+0x9c>
    19f2:	84aa                	mv	s1,a0
  pid = fork();
    19f4:	00004097          	auipc	ra,0x4
    19f8:	4bc080e7          	jalr	1212(ra) # 5eb0 <fork>
    19fc:	8a2a                	mv	s4,a0
  if(pid == 0){
    19fe:	c541                	beqz	a0,1a86 <pipe1+0xba>
  } else if(pid > 0){
    1a00:	18a05463          	blez	a0,1b88 <pipe1+0x1bc>
    close(fds[1]);
    1a04:	fac42503          	lw	a0,-84(s0)
    1a08:	00004097          	auipc	ra,0x4
    1a0c:	4d8080e7          	jalr	1240(ra) # 5ee0 <close>
    total = 0;
    1a10:	8a26                	mv	s4,s1
    cc = 1;
    1a12:	4985                	li	s3,1
    while((n = read(fds[0], buf, cc)) > 0){
    1a14:	0000ba97          	auipc	s5,0xb
    1a18:	264a8a93          	addi	s5,s5,612 # cc78 <buf>
      if(cc > sizeof(buf))
    1a1c:	6b0d                	lui	s6,0x3
    while((n = read(fds[0], buf, cc)) > 0){
    1a1e:	864e                	mv	a2,s3
    1a20:	85d6                	mv	a1,s5
    1a22:	fa842503          	lw	a0,-88(s0)
    1a26:	00004097          	auipc	ra,0x4
    1a2a:	4aa080e7          	jalr	1194(ra) # 5ed0 <read>
    1a2e:	10a05563          	blez	a0,1b38 <pipe1+0x16c>
      for(i = 0; i < n; i++){
    1a32:	0000b717          	auipc	a4,0xb
    1a36:	24670713          	addi	a4,a4,582 # cc78 <buf>
    1a3a:	00a4863b          	addw	a2,s1,a0
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1a3e:	00074683          	lbu	a3,0(a4)
    1a42:	0ff4f793          	andi	a5,s1,255
    1a46:	2485                	addiw	s1,s1,1
    1a48:	0cf69463          	bne	a3,a5,1b10 <pipe1+0x144>
      for(i = 0; i < n; i++){
    1a4c:	0705                	addi	a4,a4,1
    1a4e:	fec498e3          	bne	s1,a2,1a3e <pipe1+0x72>
      total += n;
    1a52:	00aa0a3b          	addw	s4,s4,a0
      cc = cc * 2;
    1a56:	0019979b          	slliw	a5,s3,0x1
    1a5a:	0007899b          	sext.w	s3,a5
      if(cc > sizeof(buf))
    1a5e:	013b7363          	bgeu	s6,s3,1a64 <pipe1+0x98>
        cc = sizeof(buf);
    1a62:	89da                	mv	s3,s6
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1a64:	84b2                	mv	s1,a2
    1a66:	bf65                	j	1a1e <pipe1+0x52>
    printf("%s: pipe() failed\n", s);
    1a68:	85ca                	mv	a1,s2
    1a6a:	00005517          	auipc	a0,0x5
    1a6e:	35e50513          	addi	a0,a0,862 # 6dc8 <malloc+0xad2>
    1a72:	00004097          	auipc	ra,0x4
    1a76:	7c6080e7          	jalr	1990(ra) # 6238 <printf>
    exit(1,0);
    1a7a:	4581                	li	a1,0
    1a7c:	4505                	li	a0,1
    1a7e:	00004097          	auipc	ra,0x4
    1a82:	43a080e7          	jalr	1082(ra) # 5eb8 <exit>
    close(fds[0]);
    1a86:	fa842503          	lw	a0,-88(s0)
    1a8a:	00004097          	auipc	ra,0x4
    1a8e:	456080e7          	jalr	1110(ra) # 5ee0 <close>
    for(n = 0; n < N; n++){
    1a92:	0000bb17          	auipc	s6,0xb
    1a96:	1e6b0b13          	addi	s6,s6,486 # cc78 <buf>
    1a9a:	416004bb          	negw	s1,s6
    1a9e:	0ff4f493          	andi	s1,s1,255
    1aa2:	409b0993          	addi	s3,s6,1033
      if(write(fds[1], buf, SZ) != SZ){
    1aa6:	8bda                	mv	s7,s6
    for(n = 0; n < N; n++){
    1aa8:	6a85                	lui	s5,0x1
    1aaa:	42da8a93          	addi	s5,s5,1069 # 142d <copyinstr2+0x23>
{
    1aae:	87da                	mv	a5,s6
        buf[i] = seq++;
    1ab0:	0097873b          	addw	a4,a5,s1
    1ab4:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    1ab8:	0785                	addi	a5,a5,1
    1aba:	fef99be3          	bne	s3,a5,1ab0 <pipe1+0xe4>
        buf[i] = seq++;
    1abe:	409a0a1b          	addiw	s4,s4,1033
      if(write(fds[1], buf, SZ) != SZ){
    1ac2:	40900613          	li	a2,1033
    1ac6:	85de                	mv	a1,s7
    1ac8:	fac42503          	lw	a0,-84(s0)
    1acc:	00004097          	auipc	ra,0x4
    1ad0:	40c080e7          	jalr	1036(ra) # 5ed8 <write>
    1ad4:	40900793          	li	a5,1033
    1ad8:	00f51d63          	bne	a0,a5,1af2 <pipe1+0x126>
    for(n = 0; n < N; n++){
    1adc:	24a5                	addiw	s1,s1,9
    1ade:	0ff4f493          	andi	s1,s1,255
    1ae2:	fd5a16e3          	bne	s4,s5,1aae <pipe1+0xe2>
    exit(0,0);
    1ae6:	4581                	li	a1,0
    1ae8:	4501                	li	a0,0
    1aea:	00004097          	auipc	ra,0x4
    1aee:	3ce080e7          	jalr	974(ra) # 5eb8 <exit>
        printf("%s: pipe1 oops 1\n", s);
    1af2:	85ca                	mv	a1,s2
    1af4:	00005517          	auipc	a0,0x5
    1af8:	2ec50513          	addi	a0,a0,748 # 6de0 <malloc+0xaea>
    1afc:	00004097          	auipc	ra,0x4
    1b00:	73c080e7          	jalr	1852(ra) # 6238 <printf>
        exit(1,0);
    1b04:	4581                	li	a1,0
    1b06:	4505                	li	a0,1
    1b08:	00004097          	auipc	ra,0x4
    1b0c:	3b0080e7          	jalr	944(ra) # 5eb8 <exit>
          printf("%s: pipe1 oops 2\n", s);
    1b10:	85ca                	mv	a1,s2
    1b12:	00005517          	auipc	a0,0x5
    1b16:	2e650513          	addi	a0,a0,742 # 6df8 <malloc+0xb02>
    1b1a:	00004097          	auipc	ra,0x4
    1b1e:	71e080e7          	jalr	1822(ra) # 6238 <printf>
}
    1b22:	60e6                	ld	ra,88(sp)
    1b24:	6446                	ld	s0,80(sp)
    1b26:	64a6                	ld	s1,72(sp)
    1b28:	6906                	ld	s2,64(sp)
    1b2a:	79e2                	ld	s3,56(sp)
    1b2c:	7a42                	ld	s4,48(sp)
    1b2e:	7aa2                	ld	s5,40(sp)
    1b30:	7b02                	ld	s6,32(sp)
    1b32:	6be2                	ld	s7,24(sp)
    1b34:	6125                	addi	sp,sp,96
    1b36:	8082                	ret
    if(total != N * SZ){
    1b38:	6785                	lui	a5,0x1
    1b3a:	42d78793          	addi	a5,a5,1069 # 142d <copyinstr2+0x23>
    1b3e:	02fa0163          	beq	s4,a5,1b60 <pipe1+0x194>
      printf("%s: pipe1 oops 3 total %d\n", total);
    1b42:	85d2                	mv	a1,s4
    1b44:	00005517          	auipc	a0,0x5
    1b48:	2cc50513          	addi	a0,a0,716 # 6e10 <malloc+0xb1a>
    1b4c:	00004097          	auipc	ra,0x4
    1b50:	6ec080e7          	jalr	1772(ra) # 6238 <printf>
      exit(1,0);
    1b54:	4581                	li	a1,0
    1b56:	4505                	li	a0,1
    1b58:	00004097          	auipc	ra,0x4
    1b5c:	360080e7          	jalr	864(ra) # 5eb8 <exit>
    close(fds[0]);
    1b60:	fa842503          	lw	a0,-88(s0)
    1b64:	00004097          	auipc	ra,0x4
    1b68:	37c080e7          	jalr	892(ra) # 5ee0 <close>
    wait(&xstatus,0);
    1b6c:	4581                	li	a1,0
    1b6e:	fa440513          	addi	a0,s0,-92
    1b72:	00004097          	auipc	ra,0x4
    1b76:	34e080e7          	jalr	846(ra) # 5ec0 <wait>
    exit(xstatus,0);
    1b7a:	4581                	li	a1,0
    1b7c:	fa442503          	lw	a0,-92(s0)
    1b80:	00004097          	auipc	ra,0x4
    1b84:	338080e7          	jalr	824(ra) # 5eb8 <exit>
    printf("%s: fork() failed\n", s);
    1b88:	85ca                	mv	a1,s2
    1b8a:	00005517          	auipc	a0,0x5
    1b8e:	2a650513          	addi	a0,a0,678 # 6e30 <malloc+0xb3a>
    1b92:	00004097          	auipc	ra,0x4
    1b96:	6a6080e7          	jalr	1702(ra) # 6238 <printf>
    exit(1,0);
    1b9a:	4581                	li	a1,0
    1b9c:	4505                	li	a0,1
    1b9e:	00004097          	auipc	ra,0x4
    1ba2:	31a080e7          	jalr	794(ra) # 5eb8 <exit>

0000000000001ba6 <exitwait>:
{
    1ba6:	7139                	addi	sp,sp,-64
    1ba8:	fc06                	sd	ra,56(sp)
    1baa:	f822                	sd	s0,48(sp)
    1bac:	f426                	sd	s1,40(sp)
    1bae:	f04a                	sd	s2,32(sp)
    1bb0:	ec4e                	sd	s3,24(sp)
    1bb2:	e852                	sd	s4,16(sp)
    1bb4:	0080                	addi	s0,sp,64
    1bb6:	8a2a                	mv	s4,a0
  for(i = 0; i < 100; i++){
    1bb8:	4901                	li	s2,0
    1bba:	06400993          	li	s3,100
    pid = fork();
    1bbe:	00004097          	auipc	ra,0x4
    1bc2:	2f2080e7          	jalr	754(ra) # 5eb0 <fork>
    1bc6:	84aa                	mv	s1,a0
    if(pid < 0){
    1bc8:	02054b63          	bltz	a0,1bfe <exitwait+0x58>
    if(pid){
    1bcc:	c551                	beqz	a0,1c58 <exitwait+0xb2>
      if(wait(&xstate,0) != pid){
    1bce:	4581                	li	a1,0
    1bd0:	fcc40513          	addi	a0,s0,-52
    1bd4:	00004097          	auipc	ra,0x4
    1bd8:	2ec080e7          	jalr	748(ra) # 5ec0 <wait>
    1bdc:	04951063          	bne	a0,s1,1c1c <exitwait+0x76>
      if(i != xstate) {
    1be0:	fcc42783          	lw	a5,-52(s0)
    1be4:	05279b63          	bne	a5,s2,1c3a <exitwait+0x94>
  for(i = 0; i < 100; i++){
    1be8:	2905                	addiw	s2,s2,1
    1bea:	fd391ae3          	bne	s2,s3,1bbe <exitwait+0x18>
}
    1bee:	70e2                	ld	ra,56(sp)
    1bf0:	7442                	ld	s0,48(sp)
    1bf2:	74a2                	ld	s1,40(sp)
    1bf4:	7902                	ld	s2,32(sp)
    1bf6:	69e2                	ld	s3,24(sp)
    1bf8:	6a42                	ld	s4,16(sp)
    1bfa:	6121                	addi	sp,sp,64
    1bfc:	8082                	ret
      printf("%s: fork failed\n", s);
    1bfe:	85d2                	mv	a1,s4
    1c00:	00005517          	auipc	a0,0x5
    1c04:	0c050513          	addi	a0,a0,192 # 6cc0 <malloc+0x9ca>
    1c08:	00004097          	auipc	ra,0x4
    1c0c:	630080e7          	jalr	1584(ra) # 6238 <printf>
      exit(1,0);
    1c10:	4581                	li	a1,0
    1c12:	4505                	li	a0,1
    1c14:	00004097          	auipc	ra,0x4
    1c18:	2a4080e7          	jalr	676(ra) # 5eb8 <exit>
        printf("%s: wait wrong pid\n", s);
    1c1c:	85d2                	mv	a1,s4
    1c1e:	00005517          	auipc	a0,0x5
    1c22:	22a50513          	addi	a0,a0,554 # 6e48 <malloc+0xb52>
    1c26:	00004097          	auipc	ra,0x4
    1c2a:	612080e7          	jalr	1554(ra) # 6238 <printf>
        exit(1,0);
    1c2e:	4581                	li	a1,0
    1c30:	4505                	li	a0,1
    1c32:	00004097          	auipc	ra,0x4
    1c36:	286080e7          	jalr	646(ra) # 5eb8 <exit>
        printf("%s: wait wrong exit status\n", s);
    1c3a:	85d2                	mv	a1,s4
    1c3c:	00005517          	auipc	a0,0x5
    1c40:	22450513          	addi	a0,a0,548 # 6e60 <malloc+0xb6a>
    1c44:	00004097          	auipc	ra,0x4
    1c48:	5f4080e7          	jalr	1524(ra) # 6238 <printf>
        exit(1,0);
    1c4c:	4581                	li	a1,0
    1c4e:	4505                	li	a0,1
    1c50:	00004097          	auipc	ra,0x4
    1c54:	268080e7          	jalr	616(ra) # 5eb8 <exit>
      exit(i,0);
    1c58:	4581                	li	a1,0
    1c5a:	854a                	mv	a0,s2
    1c5c:	00004097          	auipc	ra,0x4
    1c60:	25c080e7          	jalr	604(ra) # 5eb8 <exit>

0000000000001c64 <twochildren>:
{
    1c64:	1101                	addi	sp,sp,-32
    1c66:	ec06                	sd	ra,24(sp)
    1c68:	e822                	sd	s0,16(sp)
    1c6a:	e426                	sd	s1,8(sp)
    1c6c:	e04a                	sd	s2,0(sp)
    1c6e:	1000                	addi	s0,sp,32
    1c70:	892a                	mv	s2,a0
    1c72:	3e800493          	li	s1,1000
    int pid1 = fork();
    1c76:	00004097          	auipc	ra,0x4
    1c7a:	23a080e7          	jalr	570(ra) # 5eb0 <fork>
    if(pid1 < 0){
    1c7e:	02054e63          	bltz	a0,1cba <twochildren+0x56>
    if(pid1 == 0){
    1c82:	c939                	beqz	a0,1cd8 <twochildren+0x74>
      int pid2 = fork();
    1c84:	00004097          	auipc	ra,0x4
    1c88:	22c080e7          	jalr	556(ra) # 5eb0 <fork>
      if(pid2 < 0){
    1c8c:	04054b63          	bltz	a0,1ce2 <twochildren+0x7e>
      if(pid2 == 0){
    1c90:	c925                	beqz	a0,1d00 <twochildren+0x9c>
        wait(0,0);
    1c92:	4581                	li	a1,0
    1c94:	4501                	li	a0,0
    1c96:	00004097          	auipc	ra,0x4
    1c9a:	22a080e7          	jalr	554(ra) # 5ec0 <wait>
        wait(0,0);
    1c9e:	4581                	li	a1,0
    1ca0:	4501                	li	a0,0
    1ca2:	00004097          	auipc	ra,0x4
    1ca6:	21e080e7          	jalr	542(ra) # 5ec0 <wait>
  for(int i = 0; i < 1000; i++){
    1caa:	34fd                	addiw	s1,s1,-1
    1cac:	f4e9                	bnez	s1,1c76 <twochildren+0x12>
}
    1cae:	60e2                	ld	ra,24(sp)
    1cb0:	6442                	ld	s0,16(sp)
    1cb2:	64a2                	ld	s1,8(sp)
    1cb4:	6902                	ld	s2,0(sp)
    1cb6:	6105                	addi	sp,sp,32
    1cb8:	8082                	ret
      printf("%s: fork failed\n", s);
    1cba:	85ca                	mv	a1,s2
    1cbc:	00005517          	auipc	a0,0x5
    1cc0:	00450513          	addi	a0,a0,4 # 6cc0 <malloc+0x9ca>
    1cc4:	00004097          	auipc	ra,0x4
    1cc8:	574080e7          	jalr	1396(ra) # 6238 <printf>
      exit(1,0);
    1ccc:	4581                	li	a1,0
    1cce:	4505                	li	a0,1
    1cd0:	00004097          	auipc	ra,0x4
    1cd4:	1e8080e7          	jalr	488(ra) # 5eb8 <exit>
      exit(0,0);
    1cd8:	4581                	li	a1,0
    1cda:	00004097          	auipc	ra,0x4
    1cde:	1de080e7          	jalr	478(ra) # 5eb8 <exit>
        printf("%s: fork failed\n", s);
    1ce2:	85ca                	mv	a1,s2
    1ce4:	00005517          	auipc	a0,0x5
    1ce8:	fdc50513          	addi	a0,a0,-36 # 6cc0 <malloc+0x9ca>
    1cec:	00004097          	auipc	ra,0x4
    1cf0:	54c080e7          	jalr	1356(ra) # 6238 <printf>
        exit(1,0);
    1cf4:	4581                	li	a1,0
    1cf6:	4505                	li	a0,1
    1cf8:	00004097          	auipc	ra,0x4
    1cfc:	1c0080e7          	jalr	448(ra) # 5eb8 <exit>
        exit(0,0);
    1d00:	4581                	li	a1,0
    1d02:	00004097          	auipc	ra,0x4
    1d06:	1b6080e7          	jalr	438(ra) # 5eb8 <exit>

0000000000001d0a <forkfork>:
{
    1d0a:	7179                	addi	sp,sp,-48
    1d0c:	f406                	sd	ra,40(sp)
    1d0e:	f022                	sd	s0,32(sp)
    1d10:	ec26                	sd	s1,24(sp)
    1d12:	1800                	addi	s0,sp,48
    1d14:	84aa                	mv	s1,a0
    int pid = fork();
    1d16:	00004097          	auipc	ra,0x4
    1d1a:	19a080e7          	jalr	410(ra) # 5eb0 <fork>
    if(pid < 0){
    1d1e:	04054363          	bltz	a0,1d64 <forkfork+0x5a>
    if(pid == 0){
    1d22:	c125                	beqz	a0,1d82 <forkfork+0x78>
    int pid = fork();
    1d24:	00004097          	auipc	ra,0x4
    1d28:	18c080e7          	jalr	396(ra) # 5eb0 <fork>
    if(pid < 0){
    1d2c:	02054c63          	bltz	a0,1d64 <forkfork+0x5a>
    if(pid == 0){
    1d30:	c929                	beqz	a0,1d82 <forkfork+0x78>
    wait(&xstatus,0);
    1d32:	4581                	li	a1,0
    1d34:	fdc40513          	addi	a0,s0,-36
    1d38:	00004097          	auipc	ra,0x4
    1d3c:	188080e7          	jalr	392(ra) # 5ec0 <wait>
    if(xstatus != 0) {
    1d40:	fdc42783          	lw	a5,-36(s0)
    1d44:	e3c9                	bnez	a5,1dc6 <forkfork+0xbc>
    wait(&xstatus,0);
    1d46:	4581                	li	a1,0
    1d48:	fdc40513          	addi	a0,s0,-36
    1d4c:	00004097          	auipc	ra,0x4
    1d50:	174080e7          	jalr	372(ra) # 5ec0 <wait>
    if(xstatus != 0) {
    1d54:	fdc42783          	lw	a5,-36(s0)
    1d58:	e7bd                	bnez	a5,1dc6 <forkfork+0xbc>
}
    1d5a:	70a2                	ld	ra,40(sp)
    1d5c:	7402                	ld	s0,32(sp)
    1d5e:	64e2                	ld	s1,24(sp)
    1d60:	6145                	addi	sp,sp,48
    1d62:	8082                	ret
      printf("%s: fork failed", s);
    1d64:	85a6                	mv	a1,s1
    1d66:	00005517          	auipc	a0,0x5
    1d6a:	11a50513          	addi	a0,a0,282 # 6e80 <malloc+0xb8a>
    1d6e:	00004097          	auipc	ra,0x4
    1d72:	4ca080e7          	jalr	1226(ra) # 6238 <printf>
      exit(1,0);
    1d76:	4581                	li	a1,0
    1d78:	4505                	li	a0,1
    1d7a:	00004097          	auipc	ra,0x4
    1d7e:	13e080e7          	jalr	318(ra) # 5eb8 <exit>
{
    1d82:	0c800493          	li	s1,200
        int pid1 = fork();
    1d86:	00004097          	auipc	ra,0x4
    1d8a:	12a080e7          	jalr	298(ra) # 5eb0 <fork>
        if(pid1 < 0){
    1d8e:	02054163          	bltz	a0,1db0 <forkfork+0xa6>
        if(pid1 == 0){
    1d92:	c50d                	beqz	a0,1dbc <forkfork+0xb2>
        wait(0,0);
    1d94:	4581                	li	a1,0
    1d96:	4501                	li	a0,0
    1d98:	00004097          	auipc	ra,0x4
    1d9c:	128080e7          	jalr	296(ra) # 5ec0 <wait>
      for(int j = 0; j < 200; j++){
    1da0:	34fd                	addiw	s1,s1,-1
    1da2:	f0f5                	bnez	s1,1d86 <forkfork+0x7c>
      exit(0,0);
    1da4:	4581                	li	a1,0
    1da6:	4501                	li	a0,0
    1da8:	00004097          	auipc	ra,0x4
    1dac:	110080e7          	jalr	272(ra) # 5eb8 <exit>
          exit(1,0);
    1db0:	4581                	li	a1,0
    1db2:	4505                	li	a0,1
    1db4:	00004097          	auipc	ra,0x4
    1db8:	104080e7          	jalr	260(ra) # 5eb8 <exit>
          exit(0,0);
    1dbc:	4581                	li	a1,0
    1dbe:	00004097          	auipc	ra,0x4
    1dc2:	0fa080e7          	jalr	250(ra) # 5eb8 <exit>
      printf("%s: fork in child failed", s);
    1dc6:	85a6                	mv	a1,s1
    1dc8:	00005517          	auipc	a0,0x5
    1dcc:	0c850513          	addi	a0,a0,200 # 6e90 <malloc+0xb9a>
    1dd0:	00004097          	auipc	ra,0x4
    1dd4:	468080e7          	jalr	1128(ra) # 6238 <printf>
      exit(1,0);
    1dd8:	4581                	li	a1,0
    1dda:	4505                	li	a0,1
    1ddc:	00004097          	auipc	ra,0x4
    1de0:	0dc080e7          	jalr	220(ra) # 5eb8 <exit>

0000000000001de4 <reparent2>:
{
    1de4:	1101                	addi	sp,sp,-32
    1de6:	ec06                	sd	ra,24(sp)
    1de8:	e822                	sd	s0,16(sp)
    1dea:	e426                	sd	s1,8(sp)
    1dec:	1000                	addi	s0,sp,32
    1dee:	32000493          	li	s1,800
    int pid1 = fork();
    1df2:	00004097          	auipc	ra,0x4
    1df6:	0be080e7          	jalr	190(ra) # 5eb0 <fork>
    if(pid1 < 0){
    1dfa:	02054163          	bltz	a0,1e1c <reparent2+0x38>
    if(pid1 == 0){
    1dfe:	cd0d                	beqz	a0,1e38 <reparent2+0x54>
    wait(0,0);
    1e00:	4581                	li	a1,0
    1e02:	4501                	li	a0,0
    1e04:	00004097          	auipc	ra,0x4
    1e08:	0bc080e7          	jalr	188(ra) # 5ec0 <wait>
  for(int i = 0; i < 800; i++){
    1e0c:	34fd                	addiw	s1,s1,-1
    1e0e:	f0f5                	bnez	s1,1df2 <reparent2+0xe>
  exit(0,0);
    1e10:	4581                	li	a1,0
    1e12:	4501                	li	a0,0
    1e14:	00004097          	auipc	ra,0x4
    1e18:	0a4080e7          	jalr	164(ra) # 5eb8 <exit>
      printf("fork failed\n");
    1e1c:	00005517          	auipc	a0,0x5
    1e20:	2ac50513          	addi	a0,a0,684 # 70c8 <malloc+0xdd2>
    1e24:	00004097          	auipc	ra,0x4
    1e28:	414080e7          	jalr	1044(ra) # 6238 <printf>
      exit(1,0);
    1e2c:	4581                	li	a1,0
    1e2e:	4505                	li	a0,1
    1e30:	00004097          	auipc	ra,0x4
    1e34:	088080e7          	jalr	136(ra) # 5eb8 <exit>
      fork();
    1e38:	00004097          	auipc	ra,0x4
    1e3c:	078080e7          	jalr	120(ra) # 5eb0 <fork>
      fork();
    1e40:	00004097          	auipc	ra,0x4
    1e44:	070080e7          	jalr	112(ra) # 5eb0 <fork>
      exit(0,0);
    1e48:	4581                	li	a1,0
    1e4a:	4501                	li	a0,0
    1e4c:	00004097          	auipc	ra,0x4
    1e50:	06c080e7          	jalr	108(ra) # 5eb8 <exit>

0000000000001e54 <createdelete>:
{
    1e54:	7175                	addi	sp,sp,-144
    1e56:	e506                	sd	ra,136(sp)
    1e58:	e122                	sd	s0,128(sp)
    1e5a:	fca6                	sd	s1,120(sp)
    1e5c:	f8ca                	sd	s2,112(sp)
    1e5e:	f4ce                	sd	s3,104(sp)
    1e60:	f0d2                	sd	s4,96(sp)
    1e62:	ecd6                	sd	s5,88(sp)
    1e64:	e8da                	sd	s6,80(sp)
    1e66:	e4de                	sd	s7,72(sp)
    1e68:	e0e2                	sd	s8,64(sp)
    1e6a:	fc66                	sd	s9,56(sp)
    1e6c:	0900                	addi	s0,sp,144
    1e6e:	8caa                	mv	s9,a0
  for(pi = 0; pi < NCHILD; pi++){
    1e70:	4901                	li	s2,0
    1e72:	4991                	li	s3,4
    pid = fork();
    1e74:	00004097          	auipc	ra,0x4
    1e78:	03c080e7          	jalr	60(ra) # 5eb0 <fork>
    1e7c:	84aa                	mv	s1,a0
    if(pid < 0){
    1e7e:	04054063          	bltz	a0,1ebe <createdelete+0x6a>
    if(pid == 0){
    1e82:	cd29                	beqz	a0,1edc <createdelete+0x88>
  for(pi = 0; pi < NCHILD; pi++){
    1e84:	2905                	addiw	s2,s2,1
    1e86:	ff3917e3          	bne	s2,s3,1e74 <createdelete+0x20>
    1e8a:	4491                	li	s1,4
    wait(&xstatus,0);
    1e8c:	4581                	li	a1,0
    1e8e:	f7c40513          	addi	a0,s0,-132
    1e92:	00004097          	auipc	ra,0x4
    1e96:	02e080e7          	jalr	46(ra) # 5ec0 <wait>
    if(xstatus != 0)
    1e9a:	f7c42903          	lw	s2,-132(s0)
    1e9e:	0e091663          	bnez	s2,1f8a <createdelete+0x136>
  for(pi = 0; pi < NCHILD; pi++){
    1ea2:	34fd                	addiw	s1,s1,-1
    1ea4:	f4e5                	bnez	s1,1e8c <createdelete+0x38>
  name[0] = name[1] = name[2] = 0;
    1ea6:	f8040123          	sb	zero,-126(s0)
    1eaa:	03000993          	li	s3,48
    1eae:	5a7d                	li	s4,-1
    1eb0:	07000c13          	li	s8,112
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1eb4:	4b21                	li	s6,8
      if((i == 0 || i >= N/2) && fd < 0){
    1eb6:	4ba5                	li	s7,9
    for(pi = 0; pi < NCHILD; pi++){
    1eb8:	07400a93          	li	s5,116
    1ebc:	aa95                	j	2030 <createdelete+0x1dc>
      printf("fork failed\n", s);
    1ebe:	85e6                	mv	a1,s9
    1ec0:	00005517          	auipc	a0,0x5
    1ec4:	20850513          	addi	a0,a0,520 # 70c8 <malloc+0xdd2>
    1ec8:	00004097          	auipc	ra,0x4
    1ecc:	370080e7          	jalr	880(ra) # 6238 <printf>
      exit(1,0);
    1ed0:	4581                	li	a1,0
    1ed2:	4505                	li	a0,1
    1ed4:	00004097          	auipc	ra,0x4
    1ed8:	fe4080e7          	jalr	-28(ra) # 5eb8 <exit>
      name[0] = 'p' + pi;
    1edc:	0709091b          	addiw	s2,s2,112
    1ee0:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
    1ee4:	f8040123          	sb	zero,-126(s0)
      for(i = 0; i < N; i++){
    1ee8:	4951                	li	s2,20
    1eea:	a01d                	j	1f10 <createdelete+0xbc>
          printf("%s: create failed\n", s);
    1eec:	85e6                	mv	a1,s9
    1eee:	00005517          	auipc	a0,0x5
    1ef2:	e6a50513          	addi	a0,a0,-406 # 6d58 <malloc+0xa62>
    1ef6:	00004097          	auipc	ra,0x4
    1efa:	342080e7          	jalr	834(ra) # 6238 <printf>
          exit(1,0);
    1efe:	4581                	li	a1,0
    1f00:	4505                	li	a0,1
    1f02:	00004097          	auipc	ra,0x4
    1f06:	fb6080e7          	jalr	-74(ra) # 5eb8 <exit>
      for(i = 0; i < N; i++){
    1f0a:	2485                	addiw	s1,s1,1
    1f0c:	07248963          	beq	s1,s2,1f7e <createdelete+0x12a>
        name[1] = '0' + i;
    1f10:	0304879b          	addiw	a5,s1,48
    1f14:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1f18:	20200593          	li	a1,514
    1f1c:	f8040513          	addi	a0,s0,-128
    1f20:	00004097          	auipc	ra,0x4
    1f24:	fd8080e7          	jalr	-40(ra) # 5ef8 <open>
        if(fd < 0){
    1f28:	fc0542e3          	bltz	a0,1eec <createdelete+0x98>
        close(fd);
    1f2c:	00004097          	auipc	ra,0x4
    1f30:	fb4080e7          	jalr	-76(ra) # 5ee0 <close>
        if(i > 0 && (i % 2 ) == 0){
    1f34:	fc905be3          	blez	s1,1f0a <createdelete+0xb6>
    1f38:	0014f793          	andi	a5,s1,1
    1f3c:	f7f9                	bnez	a5,1f0a <createdelete+0xb6>
          name[1] = '0' + (i / 2);
    1f3e:	01f4d79b          	srliw	a5,s1,0x1f
    1f42:	9fa5                	addw	a5,a5,s1
    1f44:	4017d79b          	sraiw	a5,a5,0x1
    1f48:	0307879b          	addiw	a5,a5,48
    1f4c:	f8f400a3          	sb	a5,-127(s0)
          if(unlink(name) < 0){
    1f50:	f8040513          	addi	a0,s0,-128
    1f54:	00004097          	auipc	ra,0x4
    1f58:	fb4080e7          	jalr	-76(ra) # 5f08 <unlink>
    1f5c:	fa0557e3          	bgez	a0,1f0a <createdelete+0xb6>
            printf("%s: unlink failed\n", s);
    1f60:	85e6                	mv	a1,s9
    1f62:	00005517          	auipc	a0,0x5
    1f66:	f4e50513          	addi	a0,a0,-178 # 6eb0 <malloc+0xbba>
    1f6a:	00004097          	auipc	ra,0x4
    1f6e:	2ce080e7          	jalr	718(ra) # 6238 <printf>
            exit(1,0);
    1f72:	4581                	li	a1,0
    1f74:	4505                	li	a0,1
    1f76:	00004097          	auipc	ra,0x4
    1f7a:	f42080e7          	jalr	-190(ra) # 5eb8 <exit>
      exit(0,0);
    1f7e:	4581                	li	a1,0
    1f80:	4501                	li	a0,0
    1f82:	00004097          	auipc	ra,0x4
    1f86:	f36080e7          	jalr	-202(ra) # 5eb8 <exit>
      exit(1,0);
    1f8a:	4581                	li	a1,0
    1f8c:	4505                	li	a0,1
    1f8e:	00004097          	auipc	ra,0x4
    1f92:	f2a080e7          	jalr	-214(ra) # 5eb8 <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    1f96:	f8040613          	addi	a2,s0,-128
    1f9a:	85e6                	mv	a1,s9
    1f9c:	00005517          	auipc	a0,0x5
    1fa0:	f2c50513          	addi	a0,a0,-212 # 6ec8 <malloc+0xbd2>
    1fa4:	00004097          	auipc	ra,0x4
    1fa8:	294080e7          	jalr	660(ra) # 6238 <printf>
        exit(1,0);
    1fac:	4581                	li	a1,0
    1fae:	4505                	li	a0,1
    1fb0:	00004097          	auipc	ra,0x4
    1fb4:	f08080e7          	jalr	-248(ra) # 5eb8 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1fb8:	054b7163          	bgeu	s6,s4,1ffa <createdelete+0x1a6>
      if(fd >= 0)
    1fbc:	02055a63          	bgez	a0,1ff0 <createdelete+0x19c>
    for(pi = 0; pi < NCHILD; pi++){
    1fc0:	2485                	addiw	s1,s1,1
    1fc2:	0ff4f493          	andi	s1,s1,255
    1fc6:	05548d63          	beq	s1,s5,2020 <createdelete+0x1cc>
      name[0] = 'p' + pi;
    1fca:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    1fce:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
    1fd2:	4581                	li	a1,0
    1fd4:	f8040513          	addi	a0,s0,-128
    1fd8:	00004097          	auipc	ra,0x4
    1fdc:	f20080e7          	jalr	-224(ra) # 5ef8 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1fe0:	00090463          	beqz	s2,1fe8 <createdelete+0x194>
    1fe4:	fd2bdae3          	bge	s7,s2,1fb8 <createdelete+0x164>
    1fe8:	fa0547e3          	bltz	a0,1f96 <createdelete+0x142>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1fec:	014b7963          	bgeu	s6,s4,1ffe <createdelete+0x1aa>
        close(fd);
    1ff0:	00004097          	auipc	ra,0x4
    1ff4:	ef0080e7          	jalr	-272(ra) # 5ee0 <close>
    1ff8:	b7e1                	j	1fc0 <createdelete+0x16c>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1ffa:	fc0543e3          	bltz	a0,1fc0 <createdelete+0x16c>
        printf("%s: oops createdelete %s did exist\n", s, name);
    1ffe:	f8040613          	addi	a2,s0,-128
    2002:	85e6                	mv	a1,s9
    2004:	00005517          	auipc	a0,0x5
    2008:	eec50513          	addi	a0,a0,-276 # 6ef0 <malloc+0xbfa>
    200c:	00004097          	auipc	ra,0x4
    2010:	22c080e7          	jalr	556(ra) # 6238 <printf>
        exit(1,0);
    2014:	4581                	li	a1,0
    2016:	4505                	li	a0,1
    2018:	00004097          	auipc	ra,0x4
    201c:	ea0080e7          	jalr	-352(ra) # 5eb8 <exit>
  for(i = 0; i < N; i++){
    2020:	2905                	addiw	s2,s2,1
    2022:	2a05                	addiw	s4,s4,1
    2024:	2985                	addiw	s3,s3,1
    2026:	0ff9f993          	andi	s3,s3,255
    202a:	47d1                	li	a5,20
    202c:	02f90a63          	beq	s2,a5,2060 <createdelete+0x20c>
    for(pi = 0; pi < NCHILD; pi++){
    2030:	84e2                	mv	s1,s8
    2032:	bf61                	j	1fca <createdelete+0x176>
  for(i = 0; i < N; i++){
    2034:	2905                	addiw	s2,s2,1
    2036:	0ff97913          	andi	s2,s2,255
    203a:	2985                	addiw	s3,s3,1
    203c:	0ff9f993          	andi	s3,s3,255
    2040:	03490863          	beq	s2,s4,2070 <createdelete+0x21c>
  name[0] = name[1] = name[2] = 0;
    2044:	84d6                	mv	s1,s5
      name[0] = 'p' + i;
    2046:	f9240023          	sb	s2,-128(s0)
      name[1] = '0' + i;
    204a:	f93400a3          	sb	s3,-127(s0)
      unlink(name);
    204e:	f8040513          	addi	a0,s0,-128
    2052:	00004097          	auipc	ra,0x4
    2056:	eb6080e7          	jalr	-330(ra) # 5f08 <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    205a:	34fd                	addiw	s1,s1,-1
    205c:	f4ed                	bnez	s1,2046 <createdelete+0x1f2>
    205e:	bfd9                	j	2034 <createdelete+0x1e0>
    2060:	03000993          	li	s3,48
    2064:	07000913          	li	s2,112
  name[0] = name[1] = name[2] = 0;
    2068:	4a91                	li	s5,4
  for(i = 0; i < N; i++){
    206a:	08400a13          	li	s4,132
    206e:	bfd9                	j	2044 <createdelete+0x1f0>
}
    2070:	60aa                	ld	ra,136(sp)
    2072:	640a                	ld	s0,128(sp)
    2074:	74e6                	ld	s1,120(sp)
    2076:	7946                	ld	s2,112(sp)
    2078:	79a6                	ld	s3,104(sp)
    207a:	7a06                	ld	s4,96(sp)
    207c:	6ae6                	ld	s5,88(sp)
    207e:	6b46                	ld	s6,80(sp)
    2080:	6ba6                	ld	s7,72(sp)
    2082:	6c06                	ld	s8,64(sp)
    2084:	7ce2                	ld	s9,56(sp)
    2086:	6149                	addi	sp,sp,144
    2088:	8082                	ret

000000000000208a <linkunlink>:
{
    208a:	711d                	addi	sp,sp,-96
    208c:	ec86                	sd	ra,88(sp)
    208e:	e8a2                	sd	s0,80(sp)
    2090:	e4a6                	sd	s1,72(sp)
    2092:	e0ca                	sd	s2,64(sp)
    2094:	fc4e                	sd	s3,56(sp)
    2096:	f852                	sd	s4,48(sp)
    2098:	f456                	sd	s5,40(sp)
    209a:	f05a                	sd	s6,32(sp)
    209c:	ec5e                	sd	s7,24(sp)
    209e:	e862                	sd	s8,16(sp)
    20a0:	e466                	sd	s9,8(sp)
    20a2:	1080                	addi	s0,sp,96
    20a4:	84aa                	mv	s1,a0
  unlink("x");
    20a6:	00004517          	auipc	a0,0x4
    20aa:	40250513          	addi	a0,a0,1026 # 64a8 <malloc+0x1b2>
    20ae:	00004097          	auipc	ra,0x4
    20b2:	e5a080e7          	jalr	-422(ra) # 5f08 <unlink>
  pid = fork();
    20b6:	00004097          	auipc	ra,0x4
    20ba:	dfa080e7          	jalr	-518(ra) # 5eb0 <fork>
  if(pid < 0){
    20be:	02054b63          	bltz	a0,20f4 <linkunlink+0x6a>
    20c2:	8c2a                	mv	s8,a0
  unsigned int x = (pid ? 1 : 97);
    20c4:	4c85                	li	s9,1
    20c6:	e119                	bnez	a0,20cc <linkunlink+0x42>
    20c8:	06100c93          	li	s9,97
    20cc:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    20d0:	41c659b7          	lui	s3,0x41c65
    20d4:	e6d9899b          	addiw	s3,s3,-403
    20d8:	690d                	lui	s2,0x3
    20da:	0399091b          	addiw	s2,s2,57
    if((x % 3) == 0){
    20de:	4a0d                	li	s4,3
    } else if((x % 3) == 1){
    20e0:	4b05                	li	s6,1
      unlink("x");
    20e2:	00004a97          	auipc	s5,0x4
    20e6:	3c6a8a93          	addi	s5,s5,966 # 64a8 <malloc+0x1b2>
      link("cat", "x");
    20ea:	00005b97          	auipc	s7,0x5
    20ee:	e2eb8b93          	addi	s7,s7,-466 # 6f18 <malloc+0xc22>
    20f2:	a82d                	j	212c <linkunlink+0xa2>
    printf("%s: fork failed\n", s);
    20f4:	85a6                	mv	a1,s1
    20f6:	00005517          	auipc	a0,0x5
    20fa:	bca50513          	addi	a0,a0,-1078 # 6cc0 <malloc+0x9ca>
    20fe:	00004097          	auipc	ra,0x4
    2102:	13a080e7          	jalr	314(ra) # 6238 <printf>
    exit(1,0);
    2106:	4581                	li	a1,0
    2108:	4505                	li	a0,1
    210a:	00004097          	auipc	ra,0x4
    210e:	dae080e7          	jalr	-594(ra) # 5eb8 <exit>
      close(open("x", O_RDWR | O_CREATE));
    2112:	20200593          	li	a1,514
    2116:	8556                	mv	a0,s5
    2118:	00004097          	auipc	ra,0x4
    211c:	de0080e7          	jalr	-544(ra) # 5ef8 <open>
    2120:	00004097          	auipc	ra,0x4
    2124:	dc0080e7          	jalr	-576(ra) # 5ee0 <close>
  for(i = 0; i < 100; i++){
    2128:	34fd                	addiw	s1,s1,-1
    212a:	c88d                	beqz	s1,215c <linkunlink+0xd2>
    x = x * 1103515245 + 12345;
    212c:	033c87bb          	mulw	a5,s9,s3
    2130:	012787bb          	addw	a5,a5,s2
    2134:	00078c9b          	sext.w	s9,a5
    if((x % 3) == 0){
    2138:	0347f7bb          	remuw	a5,a5,s4
    213c:	dbf9                	beqz	a5,2112 <linkunlink+0x88>
    } else if((x % 3) == 1){
    213e:	01678863          	beq	a5,s6,214e <linkunlink+0xc4>
      unlink("x");
    2142:	8556                	mv	a0,s5
    2144:	00004097          	auipc	ra,0x4
    2148:	dc4080e7          	jalr	-572(ra) # 5f08 <unlink>
    214c:	bff1                	j	2128 <linkunlink+0x9e>
      link("cat", "x");
    214e:	85d6                	mv	a1,s5
    2150:	855e                	mv	a0,s7
    2152:	00004097          	auipc	ra,0x4
    2156:	dc6080e7          	jalr	-570(ra) # 5f18 <link>
    215a:	b7f9                	j	2128 <linkunlink+0x9e>
  if(pid)
    215c:	020c0563          	beqz	s8,2186 <linkunlink+0xfc>
    wait(0,0);
    2160:	4581                	li	a1,0
    2162:	4501                	li	a0,0
    2164:	00004097          	auipc	ra,0x4
    2168:	d5c080e7          	jalr	-676(ra) # 5ec0 <wait>
}
    216c:	60e6                	ld	ra,88(sp)
    216e:	6446                	ld	s0,80(sp)
    2170:	64a6                	ld	s1,72(sp)
    2172:	6906                	ld	s2,64(sp)
    2174:	79e2                	ld	s3,56(sp)
    2176:	7a42                	ld	s4,48(sp)
    2178:	7aa2                	ld	s5,40(sp)
    217a:	7b02                	ld	s6,32(sp)
    217c:	6be2                	ld	s7,24(sp)
    217e:	6c42                	ld	s8,16(sp)
    2180:	6ca2                	ld	s9,8(sp)
    2182:	6125                	addi	sp,sp,96
    2184:	8082                	ret
    exit(0,0);
    2186:	4581                	li	a1,0
    2188:	4501                	li	a0,0
    218a:	00004097          	auipc	ra,0x4
    218e:	d2e080e7          	jalr	-722(ra) # 5eb8 <exit>

0000000000002192 <forktest>:
{
    2192:	7179                	addi	sp,sp,-48
    2194:	f406                	sd	ra,40(sp)
    2196:	f022                	sd	s0,32(sp)
    2198:	ec26                	sd	s1,24(sp)
    219a:	e84a                	sd	s2,16(sp)
    219c:	e44e                	sd	s3,8(sp)
    219e:	1800                	addi	s0,sp,48
    21a0:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    21a2:	4481                	li	s1,0
    21a4:	3e800913          	li	s2,1000
    pid = fork();
    21a8:	00004097          	auipc	ra,0x4
    21ac:	d08080e7          	jalr	-760(ra) # 5eb0 <fork>
    if(pid < 0)
    21b0:	02054a63          	bltz	a0,21e4 <forktest+0x52>
    if(pid == 0)
    21b4:	c11d                	beqz	a0,21da <forktest+0x48>
  for(n=0; n<N; n++){
    21b6:	2485                	addiw	s1,s1,1
    21b8:	ff2498e3          	bne	s1,s2,21a8 <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    21bc:	85ce                	mv	a1,s3
    21be:	00005517          	auipc	a0,0x5
    21c2:	d7a50513          	addi	a0,a0,-646 # 6f38 <malloc+0xc42>
    21c6:	00004097          	auipc	ra,0x4
    21ca:	072080e7          	jalr	114(ra) # 6238 <printf>
    exit(1,0);
    21ce:	4581                	li	a1,0
    21d0:	4505                	li	a0,1
    21d2:	00004097          	auipc	ra,0x4
    21d6:	ce6080e7          	jalr	-794(ra) # 5eb8 <exit>
      exit(0,0);
    21da:	4581                	li	a1,0
    21dc:	00004097          	auipc	ra,0x4
    21e0:	cdc080e7          	jalr	-804(ra) # 5eb8 <exit>
  if (n == 0) {
    21e4:	c0a9                	beqz	s1,2226 <forktest+0x94>
  if(n == N){
    21e6:	3e800793          	li	a5,1000
    21ea:	fcf489e3          	beq	s1,a5,21bc <forktest+0x2a>
  for(; n > 0; n--){
    21ee:	00905c63          	blez	s1,2206 <forktest+0x74>
    if(wait(0,0) < 0){
    21f2:	4581                	li	a1,0
    21f4:	4501                	li	a0,0
    21f6:	00004097          	auipc	ra,0x4
    21fa:	cca080e7          	jalr	-822(ra) # 5ec0 <wait>
    21fe:	04054363          	bltz	a0,2244 <forktest+0xb2>
  for(; n > 0; n--){
    2202:	34fd                	addiw	s1,s1,-1
    2204:	f4fd                	bnez	s1,21f2 <forktest+0x60>
  if(wait(0,0) != -1){
    2206:	4581                	li	a1,0
    2208:	4501                	li	a0,0
    220a:	00004097          	auipc	ra,0x4
    220e:	cb6080e7          	jalr	-842(ra) # 5ec0 <wait>
    2212:	57fd                	li	a5,-1
    2214:	04f51763          	bne	a0,a5,2262 <forktest+0xd0>
}
    2218:	70a2                	ld	ra,40(sp)
    221a:	7402                	ld	s0,32(sp)
    221c:	64e2                	ld	s1,24(sp)
    221e:	6942                	ld	s2,16(sp)
    2220:	69a2                	ld	s3,8(sp)
    2222:	6145                	addi	sp,sp,48
    2224:	8082                	ret
    printf("%s: no fork at all!\n", s);
    2226:	85ce                	mv	a1,s3
    2228:	00005517          	auipc	a0,0x5
    222c:	cf850513          	addi	a0,a0,-776 # 6f20 <malloc+0xc2a>
    2230:	00004097          	auipc	ra,0x4
    2234:	008080e7          	jalr	8(ra) # 6238 <printf>
    exit(1,0);
    2238:	4581                	li	a1,0
    223a:	4505                	li	a0,1
    223c:	00004097          	auipc	ra,0x4
    2240:	c7c080e7          	jalr	-900(ra) # 5eb8 <exit>
      printf("%s: wait stopped early\n", s);
    2244:	85ce                	mv	a1,s3
    2246:	00005517          	auipc	a0,0x5
    224a:	d1a50513          	addi	a0,a0,-742 # 6f60 <malloc+0xc6a>
    224e:	00004097          	auipc	ra,0x4
    2252:	fea080e7          	jalr	-22(ra) # 6238 <printf>
      exit(1,0);
    2256:	4581                	li	a1,0
    2258:	4505                	li	a0,1
    225a:	00004097          	auipc	ra,0x4
    225e:	c5e080e7          	jalr	-930(ra) # 5eb8 <exit>
    printf("%s: wait got too many\n", s);
    2262:	85ce                	mv	a1,s3
    2264:	00005517          	auipc	a0,0x5
    2268:	d1450513          	addi	a0,a0,-748 # 6f78 <malloc+0xc82>
    226c:	00004097          	auipc	ra,0x4
    2270:	fcc080e7          	jalr	-52(ra) # 6238 <printf>
    exit(1,0);
    2274:	4581                	li	a1,0
    2276:	4505                	li	a0,1
    2278:	00004097          	auipc	ra,0x4
    227c:	c40080e7          	jalr	-960(ra) # 5eb8 <exit>

0000000000002280 <kernmem>:
{
    2280:	715d                	addi	sp,sp,-80
    2282:	e486                	sd	ra,72(sp)
    2284:	e0a2                	sd	s0,64(sp)
    2286:	fc26                	sd	s1,56(sp)
    2288:	f84a                	sd	s2,48(sp)
    228a:	f44e                	sd	s3,40(sp)
    228c:	f052                	sd	s4,32(sp)
    228e:	ec56                	sd	s5,24(sp)
    2290:	0880                	addi	s0,sp,80
    2292:	8a2a                	mv	s4,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2294:	4485                	li	s1,1
    2296:	04fe                	slli	s1,s1,0x1f
    if(xstatus != -1)  // did kernel kill child?
    2298:	5afd                	li	s5,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    229a:	69b1                	lui	s3,0xc
    229c:	35098993          	addi	s3,s3,848 # c350 <uninit+0x1de8>
    22a0:	1003d937          	lui	s2,0x1003d
    22a4:	090e                	slli	s2,s2,0x3
    22a6:	48090913          	addi	s2,s2,1152 # 1003d480 <base+0x1002d808>
    pid = fork();
    22aa:	00004097          	auipc	ra,0x4
    22ae:	c06080e7          	jalr	-1018(ra) # 5eb0 <fork>
    if(pid < 0){
    22b2:	02054a63          	bltz	a0,22e6 <kernmem+0x66>
    if(pid == 0){
    22b6:	c539                	beqz	a0,2304 <kernmem+0x84>
    wait(&xstatus,0);
    22b8:	4581                	li	a1,0
    22ba:	fbc40513          	addi	a0,s0,-68
    22be:	00004097          	auipc	ra,0x4
    22c2:	c02080e7          	jalr	-1022(ra) # 5ec0 <wait>
    if(xstatus != -1)  // did kernel kill child?
    22c6:	fbc42783          	lw	a5,-68(s0)
    22ca:	05579f63          	bne	a5,s5,2328 <kernmem+0xa8>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    22ce:	94ce                	add	s1,s1,s3
    22d0:	fd249de3          	bne	s1,s2,22aa <kernmem+0x2a>
}
    22d4:	60a6                	ld	ra,72(sp)
    22d6:	6406                	ld	s0,64(sp)
    22d8:	74e2                	ld	s1,56(sp)
    22da:	7942                	ld	s2,48(sp)
    22dc:	79a2                	ld	s3,40(sp)
    22de:	7a02                	ld	s4,32(sp)
    22e0:	6ae2                	ld	s5,24(sp)
    22e2:	6161                	addi	sp,sp,80
    22e4:	8082                	ret
      printf("%s: fork failed\n", s);
    22e6:	85d2                	mv	a1,s4
    22e8:	00005517          	auipc	a0,0x5
    22ec:	9d850513          	addi	a0,a0,-1576 # 6cc0 <malloc+0x9ca>
    22f0:	00004097          	auipc	ra,0x4
    22f4:	f48080e7          	jalr	-184(ra) # 6238 <printf>
      exit(1,0);
    22f8:	4581                	li	a1,0
    22fa:	4505                	li	a0,1
    22fc:	00004097          	auipc	ra,0x4
    2300:	bbc080e7          	jalr	-1092(ra) # 5eb8 <exit>
      printf("%s: oops could read %x = %x\n", s, a, *a);
    2304:	0004c683          	lbu	a3,0(s1)
    2308:	8626                	mv	a2,s1
    230a:	85d2                	mv	a1,s4
    230c:	00005517          	auipc	a0,0x5
    2310:	c8450513          	addi	a0,a0,-892 # 6f90 <malloc+0xc9a>
    2314:	00004097          	auipc	ra,0x4
    2318:	f24080e7          	jalr	-220(ra) # 6238 <printf>
      exit(1,0);
    231c:	4581                	li	a1,0
    231e:	4505                	li	a0,1
    2320:	00004097          	auipc	ra,0x4
    2324:	b98080e7          	jalr	-1128(ra) # 5eb8 <exit>
      exit(1,0);
    2328:	4581                	li	a1,0
    232a:	4505                	li	a0,1
    232c:	00004097          	auipc	ra,0x4
    2330:	b8c080e7          	jalr	-1140(ra) # 5eb8 <exit>

0000000000002334 <MAXVAplus>:
{
    2334:	7179                	addi	sp,sp,-48
    2336:	f406                	sd	ra,40(sp)
    2338:	f022                	sd	s0,32(sp)
    233a:	ec26                	sd	s1,24(sp)
    233c:	e84a                	sd	s2,16(sp)
    233e:	1800                	addi	s0,sp,48
  volatile uint64 a = MAXVA;
    2340:	4785                	li	a5,1
    2342:	179a                	slli	a5,a5,0x26
    2344:	fcf43c23          	sd	a5,-40(s0)
  for( ; a != 0; a <<= 1){
    2348:	fd843783          	ld	a5,-40(s0)
    234c:	cf8d                	beqz	a5,2386 <MAXVAplus+0x52>
    234e:	892a                	mv	s2,a0
    if(xstatus != -1)  // did kernel kill child?
    2350:	54fd                	li	s1,-1
    pid = fork();
    2352:	00004097          	auipc	ra,0x4
    2356:	b5e080e7          	jalr	-1186(ra) # 5eb0 <fork>
    if(pid < 0){
    235a:	02054c63          	bltz	a0,2392 <MAXVAplus+0x5e>
    if(pid == 0){
    235e:	c929                	beqz	a0,23b0 <MAXVAplus+0x7c>
    wait(&xstatus,0);
    2360:	4581                	li	a1,0
    2362:	fd440513          	addi	a0,s0,-44
    2366:	00004097          	auipc	ra,0x4
    236a:	b5a080e7          	jalr	-1190(ra) # 5ec0 <wait>
    if(xstatus != -1)  // did kernel kill child?
    236e:	fd442783          	lw	a5,-44(s0)
    2372:	06979663          	bne	a5,s1,23de <MAXVAplus+0xaa>
  for( ; a != 0; a <<= 1){
    2376:	fd843783          	ld	a5,-40(s0)
    237a:	0786                	slli	a5,a5,0x1
    237c:	fcf43c23          	sd	a5,-40(s0)
    2380:	fd843783          	ld	a5,-40(s0)
    2384:	f7f9                	bnez	a5,2352 <MAXVAplus+0x1e>
}
    2386:	70a2                	ld	ra,40(sp)
    2388:	7402                	ld	s0,32(sp)
    238a:	64e2                	ld	s1,24(sp)
    238c:	6942                	ld	s2,16(sp)
    238e:	6145                	addi	sp,sp,48
    2390:	8082                	ret
      printf("%s: fork failed\n", s);
    2392:	85ca                	mv	a1,s2
    2394:	00005517          	auipc	a0,0x5
    2398:	92c50513          	addi	a0,a0,-1748 # 6cc0 <malloc+0x9ca>
    239c:	00004097          	auipc	ra,0x4
    23a0:	e9c080e7          	jalr	-356(ra) # 6238 <printf>
      exit(1,0);
    23a4:	4581                	li	a1,0
    23a6:	4505                	li	a0,1
    23a8:	00004097          	auipc	ra,0x4
    23ac:	b10080e7          	jalr	-1264(ra) # 5eb8 <exit>
      *(char*)a = 99;
    23b0:	fd843783          	ld	a5,-40(s0)
    23b4:	06300713          	li	a4,99
    23b8:	00e78023          	sb	a4,0(a5)
      printf("%s: oops wrote %x\n", s, a);
    23bc:	fd843603          	ld	a2,-40(s0)
    23c0:	85ca                	mv	a1,s2
    23c2:	00005517          	auipc	a0,0x5
    23c6:	bee50513          	addi	a0,a0,-1042 # 6fb0 <malloc+0xcba>
    23ca:	00004097          	auipc	ra,0x4
    23ce:	e6e080e7          	jalr	-402(ra) # 6238 <printf>
      exit(1,0);
    23d2:	4581                	li	a1,0
    23d4:	4505                	li	a0,1
    23d6:	00004097          	auipc	ra,0x4
    23da:	ae2080e7          	jalr	-1310(ra) # 5eb8 <exit>
      exit(1,0);
    23de:	4581                	li	a1,0
    23e0:	4505                	li	a0,1
    23e2:	00004097          	auipc	ra,0x4
    23e6:	ad6080e7          	jalr	-1322(ra) # 5eb8 <exit>

00000000000023ea <bigargtest>:
{
    23ea:	7179                	addi	sp,sp,-48
    23ec:	f406                	sd	ra,40(sp)
    23ee:	f022                	sd	s0,32(sp)
    23f0:	ec26                	sd	s1,24(sp)
    23f2:	1800                	addi	s0,sp,48
    23f4:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    23f6:	00005517          	auipc	a0,0x5
    23fa:	bd250513          	addi	a0,a0,-1070 # 6fc8 <malloc+0xcd2>
    23fe:	00004097          	auipc	ra,0x4
    2402:	b0a080e7          	jalr	-1270(ra) # 5f08 <unlink>
  pid = fork();
    2406:	00004097          	auipc	ra,0x4
    240a:	aaa080e7          	jalr	-1366(ra) # 5eb0 <fork>
  if(pid == 0){
    240e:	c129                	beqz	a0,2450 <bigargtest+0x66>
  } else if(pid < 0){
    2410:	0a054263          	bltz	a0,24b4 <bigargtest+0xca>
  wait(&xstatus,0);
    2414:	4581                	li	a1,0
    2416:	fdc40513          	addi	a0,s0,-36
    241a:	00004097          	auipc	ra,0x4
    241e:	aa6080e7          	jalr	-1370(ra) # 5ec0 <wait>
  if(xstatus != 0)
    2422:	fdc42503          	lw	a0,-36(s0)
    2426:	e555                	bnez	a0,24d2 <bigargtest+0xe8>
  fd = open("bigarg-ok", 0);
    2428:	4581                	li	a1,0
    242a:	00005517          	auipc	a0,0x5
    242e:	b9e50513          	addi	a0,a0,-1122 # 6fc8 <malloc+0xcd2>
    2432:	00004097          	auipc	ra,0x4
    2436:	ac6080e7          	jalr	-1338(ra) # 5ef8 <open>
  if(fd < 0){
    243a:	0a054163          	bltz	a0,24dc <bigargtest+0xf2>
  close(fd);
    243e:	00004097          	auipc	ra,0x4
    2442:	aa2080e7          	jalr	-1374(ra) # 5ee0 <close>
}
    2446:	70a2                	ld	ra,40(sp)
    2448:	7402                	ld	s0,32(sp)
    244a:	64e2                	ld	s1,24(sp)
    244c:	6145                	addi	sp,sp,48
    244e:	8082                	ret
    2450:	00007797          	auipc	a5,0x7
    2454:	01078793          	addi	a5,a5,16 # 9460 <args.1>
    2458:	00007697          	auipc	a3,0x7
    245c:	10068693          	addi	a3,a3,256 # 9558 <args.1+0xf8>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    2460:	00005717          	auipc	a4,0x5
    2464:	b7870713          	addi	a4,a4,-1160 # 6fd8 <malloc+0xce2>
    2468:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    246a:	07a1                	addi	a5,a5,8
    246c:	fed79ee3          	bne	a5,a3,2468 <bigargtest+0x7e>
    args[MAXARG-1] = 0;
    2470:	00007597          	auipc	a1,0x7
    2474:	ff058593          	addi	a1,a1,-16 # 9460 <args.1>
    2478:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    247c:	00004517          	auipc	a0,0x4
    2480:	fbc50513          	addi	a0,a0,-68 # 6438 <malloc+0x142>
    2484:	00004097          	auipc	ra,0x4
    2488:	a6c080e7          	jalr	-1428(ra) # 5ef0 <exec>
    fd = open("bigarg-ok", O_CREATE);
    248c:	20000593          	li	a1,512
    2490:	00005517          	auipc	a0,0x5
    2494:	b3850513          	addi	a0,a0,-1224 # 6fc8 <malloc+0xcd2>
    2498:	00004097          	auipc	ra,0x4
    249c:	a60080e7          	jalr	-1440(ra) # 5ef8 <open>
    close(fd);
    24a0:	00004097          	auipc	ra,0x4
    24a4:	a40080e7          	jalr	-1472(ra) # 5ee0 <close>
    exit(0,0);
    24a8:	4581                	li	a1,0
    24aa:	4501                	li	a0,0
    24ac:	00004097          	auipc	ra,0x4
    24b0:	a0c080e7          	jalr	-1524(ra) # 5eb8 <exit>
    printf("%s: bigargtest: fork failed\n", s);
    24b4:	85a6                	mv	a1,s1
    24b6:	00005517          	auipc	a0,0x5
    24ba:	c0250513          	addi	a0,a0,-1022 # 70b8 <malloc+0xdc2>
    24be:	00004097          	auipc	ra,0x4
    24c2:	d7a080e7          	jalr	-646(ra) # 6238 <printf>
    exit(1,0);
    24c6:	4581                	li	a1,0
    24c8:	4505                	li	a0,1
    24ca:	00004097          	auipc	ra,0x4
    24ce:	9ee080e7          	jalr	-1554(ra) # 5eb8 <exit>
    exit(xstatus,0);
    24d2:	4581                	li	a1,0
    24d4:	00004097          	auipc	ra,0x4
    24d8:	9e4080e7          	jalr	-1564(ra) # 5eb8 <exit>
    printf("%s: bigarg test failed!\n", s);
    24dc:	85a6                	mv	a1,s1
    24de:	00005517          	auipc	a0,0x5
    24e2:	bfa50513          	addi	a0,a0,-1030 # 70d8 <malloc+0xde2>
    24e6:	00004097          	auipc	ra,0x4
    24ea:	d52080e7          	jalr	-686(ra) # 6238 <printf>
    exit(1,0);
    24ee:	4581                	li	a1,0
    24f0:	4505                	li	a0,1
    24f2:	00004097          	auipc	ra,0x4
    24f6:	9c6080e7          	jalr	-1594(ra) # 5eb8 <exit>

00000000000024fa <stacktest>:
{
    24fa:	7179                	addi	sp,sp,-48
    24fc:	f406                	sd	ra,40(sp)
    24fe:	f022                	sd	s0,32(sp)
    2500:	ec26                	sd	s1,24(sp)
    2502:	1800                	addi	s0,sp,48
    2504:	84aa                	mv	s1,a0
  pid = fork();
    2506:	00004097          	auipc	ra,0x4
    250a:	9aa080e7          	jalr	-1622(ra) # 5eb0 <fork>
  if(pid == 0) {
    250e:	c505                	beqz	a0,2536 <stacktest+0x3c>
  } else if(pid < 0){
    2510:	04054763          	bltz	a0,255e <stacktest+0x64>
  wait(&xstatus,0);
    2514:	4581                	li	a1,0
    2516:	fdc40513          	addi	a0,s0,-36
    251a:	00004097          	auipc	ra,0x4
    251e:	9a6080e7          	jalr	-1626(ra) # 5ec0 <wait>
  if(xstatus == -1)  // kernel killed child?
    2522:	fdc42503          	lw	a0,-36(s0)
    2526:	57fd                	li	a5,-1
    2528:	04f50a63          	beq	a0,a5,257c <stacktest+0x82>
    exit(xstatus,0);
    252c:	4581                	li	a1,0
    252e:	00004097          	auipc	ra,0x4
    2532:	98a080e7          	jalr	-1654(ra) # 5eb8 <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    2536:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %p\n", s, *sp);
    2538:	77fd                	lui	a5,0xfffff
    253a:	97ba                	add	a5,a5,a4
    253c:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <base+0xfffffffffffef388>
    2540:	85a6                	mv	a1,s1
    2542:	00005517          	auipc	a0,0x5
    2546:	bb650513          	addi	a0,a0,-1098 # 70f8 <malloc+0xe02>
    254a:	00004097          	auipc	ra,0x4
    254e:	cee080e7          	jalr	-786(ra) # 6238 <printf>
    exit(1,0);
    2552:	4581                	li	a1,0
    2554:	4505                	li	a0,1
    2556:	00004097          	auipc	ra,0x4
    255a:	962080e7          	jalr	-1694(ra) # 5eb8 <exit>
    printf("%s: fork failed\n", s);
    255e:	85a6                	mv	a1,s1
    2560:	00004517          	auipc	a0,0x4
    2564:	76050513          	addi	a0,a0,1888 # 6cc0 <malloc+0x9ca>
    2568:	00004097          	auipc	ra,0x4
    256c:	cd0080e7          	jalr	-816(ra) # 6238 <printf>
    exit(1,0);
    2570:	4581                	li	a1,0
    2572:	4505                	li	a0,1
    2574:	00004097          	auipc	ra,0x4
    2578:	944080e7          	jalr	-1724(ra) # 5eb8 <exit>
    exit(0,0);
    257c:	4581                	li	a1,0
    257e:	4501                	li	a0,0
    2580:	00004097          	auipc	ra,0x4
    2584:	938080e7          	jalr	-1736(ra) # 5eb8 <exit>

0000000000002588 <textwrite>:
{
    2588:	7179                	addi	sp,sp,-48
    258a:	f406                	sd	ra,40(sp)
    258c:	f022                	sd	s0,32(sp)
    258e:	ec26                	sd	s1,24(sp)
    2590:	1800                	addi	s0,sp,48
    2592:	84aa                	mv	s1,a0
  pid = fork();
    2594:	00004097          	auipc	ra,0x4
    2598:	91c080e7          	jalr	-1764(ra) # 5eb0 <fork>
  if(pid == 0) {
    259c:	c505                	beqz	a0,25c4 <textwrite+0x3c>
  } else if(pid < 0){
    259e:	02054c63          	bltz	a0,25d6 <textwrite+0x4e>
  wait(&xstatus,0);
    25a2:	4581                	li	a1,0
    25a4:	fdc40513          	addi	a0,s0,-36
    25a8:	00004097          	auipc	ra,0x4
    25ac:	918080e7          	jalr	-1768(ra) # 5ec0 <wait>
  if(xstatus == -1)  // kernel killed child?
    25b0:	fdc42503          	lw	a0,-36(s0)
    25b4:	57fd                	li	a5,-1
    25b6:	02f50f63          	beq	a0,a5,25f4 <textwrite+0x6c>
    exit(xstatus,0);
    25ba:	4581                	li	a1,0
    25bc:	00004097          	auipc	ra,0x4
    25c0:	8fc080e7          	jalr	-1796(ra) # 5eb8 <exit>
    *addr = 10;
    25c4:	47a9                	li	a5,10
    25c6:	00f02023          	sw	a5,0(zero) # 0 <copyinstr1>
    exit(1,0);
    25ca:	4581                	li	a1,0
    25cc:	4505                	li	a0,1
    25ce:	00004097          	auipc	ra,0x4
    25d2:	8ea080e7          	jalr	-1814(ra) # 5eb8 <exit>
    printf("%s: fork failed\n", s);
    25d6:	85a6                	mv	a1,s1
    25d8:	00004517          	auipc	a0,0x4
    25dc:	6e850513          	addi	a0,a0,1768 # 6cc0 <malloc+0x9ca>
    25e0:	00004097          	auipc	ra,0x4
    25e4:	c58080e7          	jalr	-936(ra) # 6238 <printf>
    exit(1,0);
    25e8:	4581                	li	a1,0
    25ea:	4505                	li	a0,1
    25ec:	00004097          	auipc	ra,0x4
    25f0:	8cc080e7          	jalr	-1844(ra) # 5eb8 <exit>
    exit(0,0);
    25f4:	4581                	li	a1,0
    25f6:	4501                	li	a0,0
    25f8:	00004097          	auipc	ra,0x4
    25fc:	8c0080e7          	jalr	-1856(ra) # 5eb8 <exit>

0000000000002600 <manywrites>:
{
    2600:	711d                	addi	sp,sp,-96
    2602:	ec86                	sd	ra,88(sp)
    2604:	e8a2                	sd	s0,80(sp)
    2606:	e4a6                	sd	s1,72(sp)
    2608:	e0ca                	sd	s2,64(sp)
    260a:	fc4e                	sd	s3,56(sp)
    260c:	f852                	sd	s4,48(sp)
    260e:	f456                	sd	s5,40(sp)
    2610:	f05a                	sd	s6,32(sp)
    2612:	ec5e                	sd	s7,24(sp)
    2614:	1080                	addi	s0,sp,96
    2616:	8aaa                	mv	s5,a0
  for(int ci = 0; ci < nchildren; ci++){
    2618:	4981                	li	s3,0
    261a:	4911                	li	s2,4
    int pid = fork();
    261c:	00004097          	auipc	ra,0x4
    2620:	894080e7          	jalr	-1900(ra) # 5eb0 <fork>
    2624:	84aa                	mv	s1,a0
    if(pid < 0){
    2626:	02054c63          	bltz	a0,265e <manywrites+0x5e>
    if(pid == 0){
    262a:	c921                	beqz	a0,267a <manywrites+0x7a>
  for(int ci = 0; ci < nchildren; ci++){
    262c:	2985                	addiw	s3,s3,1
    262e:	ff2997e3          	bne	s3,s2,261c <manywrites+0x1c>
    2632:	4491                	li	s1,4
    int st = 0;
    2634:	fa042423          	sw	zero,-88(s0)
    wait(&st,0);
    2638:	4581                	li	a1,0
    263a:	fa840513          	addi	a0,s0,-88
    263e:	00004097          	auipc	ra,0x4
    2642:	882080e7          	jalr	-1918(ra) # 5ec0 <wait>
    if(st != 0)
    2646:	fa842503          	lw	a0,-88(s0)
    264a:	10051363          	bnez	a0,2750 <manywrites+0x150>
  for(int ci = 0; ci < nchildren; ci++){
    264e:	34fd                	addiw	s1,s1,-1
    2650:	f0f5                	bnez	s1,2634 <manywrites+0x34>
  exit(0,0);
    2652:	4581                	li	a1,0
    2654:	4501                	li	a0,0
    2656:	00004097          	auipc	ra,0x4
    265a:	862080e7          	jalr	-1950(ra) # 5eb8 <exit>
      printf("fork failed\n");
    265e:	00005517          	auipc	a0,0x5
    2662:	a6a50513          	addi	a0,a0,-1430 # 70c8 <malloc+0xdd2>
    2666:	00004097          	auipc	ra,0x4
    266a:	bd2080e7          	jalr	-1070(ra) # 6238 <printf>
      exit(1,0);
    266e:	4581                	li	a1,0
    2670:	4505                	li	a0,1
    2672:	00004097          	auipc	ra,0x4
    2676:	846080e7          	jalr	-1978(ra) # 5eb8 <exit>
      name[0] = 'b';
    267a:	06200793          	li	a5,98
    267e:	faf40423          	sb	a5,-88(s0)
      name[1] = 'a' + ci;
    2682:	0619879b          	addiw	a5,s3,97
    2686:	faf404a3          	sb	a5,-87(s0)
      name[2] = '\0';
    268a:	fa040523          	sb	zero,-86(s0)
      unlink(name);
    268e:	fa840513          	addi	a0,s0,-88
    2692:	00004097          	auipc	ra,0x4
    2696:	876080e7          	jalr	-1930(ra) # 5f08 <unlink>
    269a:	4bf9                	li	s7,30
          int cc = write(fd, buf, sz);
    269c:	0000ab17          	auipc	s6,0xa
    26a0:	5dcb0b13          	addi	s6,s6,1500 # cc78 <buf>
        for(int i = 0; i < ci+1; i++){
    26a4:	8a26                	mv	s4,s1
    26a6:	0209ce63          	bltz	s3,26e2 <manywrites+0xe2>
          int fd = open(name, O_CREATE | O_RDWR);
    26aa:	20200593          	li	a1,514
    26ae:	fa840513          	addi	a0,s0,-88
    26b2:	00004097          	auipc	ra,0x4
    26b6:	846080e7          	jalr	-1978(ra) # 5ef8 <open>
    26ba:	892a                	mv	s2,a0
          if(fd < 0){
    26bc:	04054863          	bltz	a0,270c <manywrites+0x10c>
          int cc = write(fd, buf, sz);
    26c0:	660d                	lui	a2,0x3
    26c2:	85da                	mv	a1,s6
    26c4:	00004097          	auipc	ra,0x4
    26c8:	814080e7          	jalr	-2028(ra) # 5ed8 <write>
          if(cc != sz){
    26cc:	678d                	lui	a5,0x3
    26ce:	06f51063          	bne	a0,a5,272e <manywrites+0x12e>
          close(fd);
    26d2:	854a                	mv	a0,s2
    26d4:	00004097          	auipc	ra,0x4
    26d8:	80c080e7          	jalr	-2036(ra) # 5ee0 <close>
        for(int i = 0; i < ci+1; i++){
    26dc:	2a05                	addiw	s4,s4,1
    26de:	fd49d6e3          	bge	s3,s4,26aa <manywrites+0xaa>
        unlink(name);
    26e2:	fa840513          	addi	a0,s0,-88
    26e6:	00004097          	auipc	ra,0x4
    26ea:	822080e7          	jalr	-2014(ra) # 5f08 <unlink>
      for(int iters = 0; iters < howmany; iters++){
    26ee:	3bfd                	addiw	s7,s7,-1
    26f0:	fa0b9ae3          	bnez	s7,26a4 <manywrites+0xa4>
      unlink(name);
    26f4:	fa840513          	addi	a0,s0,-88
    26f8:	00004097          	auipc	ra,0x4
    26fc:	810080e7          	jalr	-2032(ra) # 5f08 <unlink>
      exit(0,0);
    2700:	4581                	li	a1,0
    2702:	4501                	li	a0,0
    2704:	00003097          	auipc	ra,0x3
    2708:	7b4080e7          	jalr	1972(ra) # 5eb8 <exit>
            printf("%s: cannot create %s\n", s, name);
    270c:	fa840613          	addi	a2,s0,-88
    2710:	85d6                	mv	a1,s5
    2712:	00005517          	auipc	a0,0x5
    2716:	a0e50513          	addi	a0,a0,-1522 # 7120 <malloc+0xe2a>
    271a:	00004097          	auipc	ra,0x4
    271e:	b1e080e7          	jalr	-1250(ra) # 6238 <printf>
            exit(1,0);
    2722:	4581                	li	a1,0
    2724:	4505                	li	a0,1
    2726:	00003097          	auipc	ra,0x3
    272a:	792080e7          	jalr	1938(ra) # 5eb8 <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    272e:	86aa                	mv	a3,a0
    2730:	660d                	lui	a2,0x3
    2732:	85d6                	mv	a1,s5
    2734:	00004517          	auipc	a0,0x4
    2738:	dd450513          	addi	a0,a0,-556 # 6508 <malloc+0x212>
    273c:	00004097          	auipc	ra,0x4
    2740:	afc080e7          	jalr	-1284(ra) # 6238 <printf>
            exit(1,0);
    2744:	4581                	li	a1,0
    2746:	4505                	li	a0,1
    2748:	00003097          	auipc	ra,0x3
    274c:	770080e7          	jalr	1904(ra) # 5eb8 <exit>
      exit(st,0);
    2750:	4581                	li	a1,0
    2752:	00003097          	auipc	ra,0x3
    2756:	766080e7          	jalr	1894(ra) # 5eb8 <exit>

000000000000275a <copyinstr3>:
{
    275a:	7179                	addi	sp,sp,-48
    275c:	f406                	sd	ra,40(sp)
    275e:	f022                	sd	s0,32(sp)
    2760:	ec26                	sd	s1,24(sp)
    2762:	1800                	addi	s0,sp,48
  sbrk(8192);
    2764:	6509                	lui	a0,0x2
    2766:	00003097          	auipc	ra,0x3
    276a:	7da080e7          	jalr	2010(ra) # 5f40 <sbrk>
  uint64 top = (uint64) sbrk(0);
    276e:	4501                	li	a0,0
    2770:	00003097          	auipc	ra,0x3
    2774:	7d0080e7          	jalr	2000(ra) # 5f40 <sbrk>
  if((top % PGSIZE) != 0){
    2778:	03451793          	slli	a5,a0,0x34
    277c:	e3c9                	bnez	a5,27fe <copyinstr3+0xa4>
  top = (uint64) sbrk(0);
    277e:	4501                	li	a0,0
    2780:	00003097          	auipc	ra,0x3
    2784:	7c0080e7          	jalr	1984(ra) # 5f40 <sbrk>
  if(top % PGSIZE){
    2788:	03451793          	slli	a5,a0,0x34
    278c:	e3d9                	bnez	a5,2812 <copyinstr3+0xb8>
  char *b = (char *) (top - 1);
    278e:	fff50493          	addi	s1,a0,-1 # 1fff <createdelete+0x1ab>
  *b = 'x';
    2792:	07800793          	li	a5,120
    2796:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    279a:	8526                	mv	a0,s1
    279c:	00003097          	auipc	ra,0x3
    27a0:	76c080e7          	jalr	1900(ra) # 5f08 <unlink>
  if(ret != -1){
    27a4:	57fd                	li	a5,-1
    27a6:	08f51463          	bne	a0,a5,282e <copyinstr3+0xd4>
  int fd = open(b, O_CREATE | O_WRONLY);
    27aa:	20100593          	li	a1,513
    27ae:	8526                	mv	a0,s1
    27b0:	00003097          	auipc	ra,0x3
    27b4:	748080e7          	jalr	1864(ra) # 5ef8 <open>
  if(fd != -1){
    27b8:	57fd                	li	a5,-1
    27ba:	08f51a63          	bne	a0,a5,284e <copyinstr3+0xf4>
  ret = link(b, b);
    27be:	85a6                	mv	a1,s1
    27c0:	8526                	mv	a0,s1
    27c2:	00003097          	auipc	ra,0x3
    27c6:	756080e7          	jalr	1878(ra) # 5f18 <link>
  if(ret != -1){
    27ca:	57fd                	li	a5,-1
    27cc:	0af51163          	bne	a0,a5,286e <copyinstr3+0x114>
  char *args[] = { "xx", 0 };
    27d0:	00005797          	auipc	a5,0x5
    27d4:	64878793          	addi	a5,a5,1608 # 7e18 <malloc+0x1b22>
    27d8:	fcf43823          	sd	a5,-48(s0)
    27dc:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    27e0:	fd040593          	addi	a1,s0,-48
    27e4:	8526                	mv	a0,s1
    27e6:	00003097          	auipc	ra,0x3
    27ea:	70a080e7          	jalr	1802(ra) # 5ef0 <exec>
  if(ret != -1){
    27ee:	57fd                	li	a5,-1
    27f0:	0af51063          	bne	a0,a5,2890 <copyinstr3+0x136>
}
    27f4:	70a2                	ld	ra,40(sp)
    27f6:	7402                	ld	s0,32(sp)
    27f8:	64e2                	ld	s1,24(sp)
    27fa:	6145                	addi	sp,sp,48
    27fc:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    27fe:	0347d513          	srli	a0,a5,0x34
    2802:	6785                	lui	a5,0x1
    2804:	40a7853b          	subw	a0,a5,a0
    2808:	00003097          	auipc	ra,0x3
    280c:	738080e7          	jalr	1848(ra) # 5f40 <sbrk>
    2810:	b7bd                	j	277e <copyinstr3+0x24>
    printf("oops\n");
    2812:	00005517          	auipc	a0,0x5
    2816:	92650513          	addi	a0,a0,-1754 # 7138 <malloc+0xe42>
    281a:	00004097          	auipc	ra,0x4
    281e:	a1e080e7          	jalr	-1506(ra) # 6238 <printf>
    exit(1,0);
    2822:	4581                	li	a1,0
    2824:	4505                	li	a0,1
    2826:	00003097          	auipc	ra,0x3
    282a:	692080e7          	jalr	1682(ra) # 5eb8 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    282e:	862a                	mv	a2,a0
    2830:	85a6                	mv	a1,s1
    2832:	00004517          	auipc	a0,0x4
    2836:	3ae50513          	addi	a0,a0,942 # 6be0 <malloc+0x8ea>
    283a:	00004097          	auipc	ra,0x4
    283e:	9fe080e7          	jalr	-1538(ra) # 6238 <printf>
    exit(1,0);
    2842:	4581                	li	a1,0
    2844:	4505                	li	a0,1
    2846:	00003097          	auipc	ra,0x3
    284a:	672080e7          	jalr	1650(ra) # 5eb8 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    284e:	862a                	mv	a2,a0
    2850:	85a6                	mv	a1,s1
    2852:	00004517          	auipc	a0,0x4
    2856:	3ae50513          	addi	a0,a0,942 # 6c00 <malloc+0x90a>
    285a:	00004097          	auipc	ra,0x4
    285e:	9de080e7          	jalr	-1570(ra) # 6238 <printf>
    exit(1,0);
    2862:	4581                	li	a1,0
    2864:	4505                	li	a0,1
    2866:	00003097          	auipc	ra,0x3
    286a:	652080e7          	jalr	1618(ra) # 5eb8 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    286e:	86aa                	mv	a3,a0
    2870:	8626                	mv	a2,s1
    2872:	85a6                	mv	a1,s1
    2874:	00004517          	auipc	a0,0x4
    2878:	3ac50513          	addi	a0,a0,940 # 6c20 <malloc+0x92a>
    287c:	00004097          	auipc	ra,0x4
    2880:	9bc080e7          	jalr	-1604(ra) # 6238 <printf>
    exit(1,0);
    2884:	4581                	li	a1,0
    2886:	4505                	li	a0,1
    2888:	00003097          	auipc	ra,0x3
    288c:	630080e7          	jalr	1584(ra) # 5eb8 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    2890:	567d                	li	a2,-1
    2892:	85a6                	mv	a1,s1
    2894:	00004517          	auipc	a0,0x4
    2898:	3b450513          	addi	a0,a0,948 # 6c48 <malloc+0x952>
    289c:	00004097          	auipc	ra,0x4
    28a0:	99c080e7          	jalr	-1636(ra) # 6238 <printf>
    exit(1,0);
    28a4:	4581                	li	a1,0
    28a6:	4505                	li	a0,1
    28a8:	00003097          	auipc	ra,0x3
    28ac:	610080e7          	jalr	1552(ra) # 5eb8 <exit>

00000000000028b0 <rwsbrk>:
{
    28b0:	1101                	addi	sp,sp,-32
    28b2:	ec06                	sd	ra,24(sp)
    28b4:	e822                	sd	s0,16(sp)
    28b6:	e426                	sd	s1,8(sp)
    28b8:	e04a                	sd	s2,0(sp)
    28ba:	1000                	addi	s0,sp,32
  uint64 a = (uint64) sbrk(8192);
    28bc:	6509                	lui	a0,0x2
    28be:	00003097          	auipc	ra,0x3
    28c2:	682080e7          	jalr	1666(ra) # 5f40 <sbrk>
  if(a == 0xffffffffffffffffLL) {
    28c6:	57fd                	li	a5,-1
    28c8:	06f50463          	beq	a0,a5,2930 <rwsbrk+0x80>
    28cc:	84aa                	mv	s1,a0
  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
    28ce:	7579                	lui	a0,0xffffe
    28d0:	00003097          	auipc	ra,0x3
    28d4:	670080e7          	jalr	1648(ra) # 5f40 <sbrk>
    28d8:	57fd                	li	a5,-1
    28da:	06f50963          	beq	a0,a5,294c <rwsbrk+0x9c>
  fd = open("rwsbrk", O_CREATE|O_WRONLY);
    28de:	20100593          	li	a1,513
    28e2:	00005517          	auipc	a0,0x5
    28e6:	89650513          	addi	a0,a0,-1898 # 7178 <malloc+0xe82>
    28ea:	00003097          	auipc	ra,0x3
    28ee:	60e080e7          	jalr	1550(ra) # 5ef8 <open>
    28f2:	892a                	mv	s2,a0
  if(fd < 0){
    28f4:	06054a63          	bltz	a0,2968 <rwsbrk+0xb8>
  n = write(fd, (void*)(a+4096), 1024);
    28f8:	6505                	lui	a0,0x1
    28fa:	94aa                	add	s1,s1,a0
    28fc:	40000613          	li	a2,1024
    2900:	85a6                	mv	a1,s1
    2902:	854a                	mv	a0,s2
    2904:	00003097          	auipc	ra,0x3
    2908:	5d4080e7          	jalr	1492(ra) # 5ed8 <write>
    290c:	862a                	mv	a2,a0
  if(n >= 0){
    290e:	06054b63          	bltz	a0,2984 <rwsbrk+0xd4>
    printf("write(fd, %p, 1024) returned %d, not -1\n", a+4096, n);
    2912:	85a6                	mv	a1,s1
    2914:	00005517          	auipc	a0,0x5
    2918:	88450513          	addi	a0,a0,-1916 # 7198 <malloc+0xea2>
    291c:	00004097          	auipc	ra,0x4
    2920:	91c080e7          	jalr	-1764(ra) # 6238 <printf>
    exit(1,0);
    2924:	4581                	li	a1,0
    2926:	4505                	li	a0,1
    2928:	00003097          	auipc	ra,0x3
    292c:	590080e7          	jalr	1424(ra) # 5eb8 <exit>
    printf("sbrk(rwsbrk) failed\n");
    2930:	00005517          	auipc	a0,0x5
    2934:	81050513          	addi	a0,a0,-2032 # 7140 <malloc+0xe4a>
    2938:	00004097          	auipc	ra,0x4
    293c:	900080e7          	jalr	-1792(ra) # 6238 <printf>
    exit(1,0);
    2940:	4581                	li	a1,0
    2942:	4505                	li	a0,1
    2944:	00003097          	auipc	ra,0x3
    2948:	574080e7          	jalr	1396(ra) # 5eb8 <exit>
    printf("sbrk(rwsbrk) shrink failed\n");
    294c:	00005517          	auipc	a0,0x5
    2950:	80c50513          	addi	a0,a0,-2036 # 7158 <malloc+0xe62>
    2954:	00004097          	auipc	ra,0x4
    2958:	8e4080e7          	jalr	-1820(ra) # 6238 <printf>
    exit(1,0);
    295c:	4581                	li	a1,0
    295e:	4505                	li	a0,1
    2960:	00003097          	auipc	ra,0x3
    2964:	558080e7          	jalr	1368(ra) # 5eb8 <exit>
    printf("open(rwsbrk) failed\n");
    2968:	00005517          	auipc	a0,0x5
    296c:	81850513          	addi	a0,a0,-2024 # 7180 <malloc+0xe8a>
    2970:	00004097          	auipc	ra,0x4
    2974:	8c8080e7          	jalr	-1848(ra) # 6238 <printf>
    exit(1,0);
    2978:	4581                	li	a1,0
    297a:	4505                	li	a0,1
    297c:	00003097          	auipc	ra,0x3
    2980:	53c080e7          	jalr	1340(ra) # 5eb8 <exit>
  close(fd);
    2984:	854a                	mv	a0,s2
    2986:	00003097          	auipc	ra,0x3
    298a:	55a080e7          	jalr	1370(ra) # 5ee0 <close>
  unlink("rwsbrk");
    298e:	00004517          	auipc	a0,0x4
    2992:	7ea50513          	addi	a0,a0,2026 # 7178 <malloc+0xe82>
    2996:	00003097          	auipc	ra,0x3
    299a:	572080e7          	jalr	1394(ra) # 5f08 <unlink>
  fd = open("README", O_RDONLY);
    299e:	4581                	li	a1,0
    29a0:	00004517          	auipc	a0,0x4
    29a4:	c7050513          	addi	a0,a0,-912 # 6610 <malloc+0x31a>
    29a8:	00003097          	auipc	ra,0x3
    29ac:	550080e7          	jalr	1360(ra) # 5ef8 <open>
    29b0:	892a                	mv	s2,a0
  if(fd < 0){
    29b2:	02054a63          	bltz	a0,29e6 <rwsbrk+0x136>
  n = read(fd, (void*)(a+4096), 10);
    29b6:	4629                	li	a2,10
    29b8:	85a6                	mv	a1,s1
    29ba:	00003097          	auipc	ra,0x3
    29be:	516080e7          	jalr	1302(ra) # 5ed0 <read>
    29c2:	862a                	mv	a2,a0
  if(n >= 0){
    29c4:	02054f63          	bltz	a0,2a02 <rwsbrk+0x152>
    printf("read(fd, %p, 10) returned %d, not -1\n", a+4096, n);
    29c8:	85a6                	mv	a1,s1
    29ca:	00004517          	auipc	a0,0x4
    29ce:	7fe50513          	addi	a0,a0,2046 # 71c8 <malloc+0xed2>
    29d2:	00004097          	auipc	ra,0x4
    29d6:	866080e7          	jalr	-1946(ra) # 6238 <printf>
    exit(1,0);
    29da:	4581                	li	a1,0
    29dc:	4505                	li	a0,1
    29de:	00003097          	auipc	ra,0x3
    29e2:	4da080e7          	jalr	1242(ra) # 5eb8 <exit>
    printf("open(rwsbrk) failed\n");
    29e6:	00004517          	auipc	a0,0x4
    29ea:	79a50513          	addi	a0,a0,1946 # 7180 <malloc+0xe8a>
    29ee:	00004097          	auipc	ra,0x4
    29f2:	84a080e7          	jalr	-1974(ra) # 6238 <printf>
    exit(1,0);
    29f6:	4581                	li	a1,0
    29f8:	4505                	li	a0,1
    29fa:	00003097          	auipc	ra,0x3
    29fe:	4be080e7          	jalr	1214(ra) # 5eb8 <exit>
  close(fd);
    2a02:	854a                	mv	a0,s2
    2a04:	00003097          	auipc	ra,0x3
    2a08:	4dc080e7          	jalr	1244(ra) # 5ee0 <close>
  exit(0,0);
    2a0c:	4581                	li	a1,0
    2a0e:	4501                	li	a0,0
    2a10:	00003097          	auipc	ra,0x3
    2a14:	4a8080e7          	jalr	1192(ra) # 5eb8 <exit>

0000000000002a18 <sbrkbasic>:
{
    2a18:	7139                	addi	sp,sp,-64
    2a1a:	fc06                	sd	ra,56(sp)
    2a1c:	f822                	sd	s0,48(sp)
    2a1e:	f426                	sd	s1,40(sp)
    2a20:	f04a                	sd	s2,32(sp)
    2a22:	ec4e                	sd	s3,24(sp)
    2a24:	e852                	sd	s4,16(sp)
    2a26:	0080                	addi	s0,sp,64
    2a28:	8a2a                	mv	s4,a0
  pid = fork();
    2a2a:	00003097          	auipc	ra,0x3
    2a2e:	486080e7          	jalr	1158(ra) # 5eb0 <fork>
  if(pid < 0){
    2a32:	02054d63          	bltz	a0,2a6c <sbrkbasic+0x54>
  if(pid == 0){
    2a36:	ed39                	bnez	a0,2a94 <sbrkbasic+0x7c>
    a = sbrk(TOOMUCH);
    2a38:	40000537          	lui	a0,0x40000
    2a3c:	00003097          	auipc	ra,0x3
    2a40:	504080e7          	jalr	1284(ra) # 5f40 <sbrk>
    if(a == (char*)0xffffffffffffffffL){
    2a44:	57fd                	li	a5,-1
    2a46:	04f50163          	beq	a0,a5,2a88 <sbrkbasic+0x70>
    for(b = a; b < a+TOOMUCH; b += 4096){
    2a4a:	400007b7          	lui	a5,0x40000
    2a4e:	97aa                	add	a5,a5,a0
      *b = 99;
    2a50:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += 4096){
    2a54:	6705                	lui	a4,0x1
      *b = 99;
    2a56:	00d50023          	sb	a3,0(a0) # 40000000 <base+0x3fff0388>
    for(b = a; b < a+TOOMUCH; b += 4096){
    2a5a:	953a                	add	a0,a0,a4
    2a5c:	fef51de3          	bne	a0,a5,2a56 <sbrkbasic+0x3e>
    exit(1,0);
    2a60:	4581                	li	a1,0
    2a62:	4505                	li	a0,1
    2a64:	00003097          	auipc	ra,0x3
    2a68:	454080e7          	jalr	1108(ra) # 5eb8 <exit>
    printf("fork failed in sbrkbasic\n");
    2a6c:	00004517          	auipc	a0,0x4
    2a70:	78450513          	addi	a0,a0,1924 # 71f0 <malloc+0xefa>
    2a74:	00003097          	auipc	ra,0x3
    2a78:	7c4080e7          	jalr	1988(ra) # 6238 <printf>
    exit(1,0);
    2a7c:	4581                	li	a1,0
    2a7e:	4505                	li	a0,1
    2a80:	00003097          	auipc	ra,0x3
    2a84:	438080e7          	jalr	1080(ra) # 5eb8 <exit>
      exit(0,0);
    2a88:	4581                	li	a1,0
    2a8a:	4501                	li	a0,0
    2a8c:	00003097          	auipc	ra,0x3
    2a90:	42c080e7          	jalr	1068(ra) # 5eb8 <exit>
  wait(&xstatus,0);
    2a94:	4581                	li	a1,0
    2a96:	fcc40513          	addi	a0,s0,-52
    2a9a:	00003097          	auipc	ra,0x3
    2a9e:	426080e7          	jalr	1062(ra) # 5ec0 <wait>
  if(xstatus == 1){
    2aa2:	fcc42703          	lw	a4,-52(s0)
    2aa6:	4785                	li	a5,1
    2aa8:	00f70d63          	beq	a4,a5,2ac2 <sbrkbasic+0xaa>
  a = sbrk(0);
    2aac:	4501                	li	a0,0
    2aae:	00003097          	auipc	ra,0x3
    2ab2:	492080e7          	jalr	1170(ra) # 5f40 <sbrk>
    2ab6:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    2ab8:	4901                	li	s2,0
    2aba:	6985                	lui	s3,0x1
    2abc:	38898993          	addi	s3,s3,904 # 1388 <pgbug>
    2ac0:	a00d                	j	2ae2 <sbrkbasic+0xca>
    printf("%s: too much memory allocated!\n", s);
    2ac2:	85d2                	mv	a1,s4
    2ac4:	00004517          	auipc	a0,0x4
    2ac8:	74c50513          	addi	a0,a0,1868 # 7210 <malloc+0xf1a>
    2acc:	00003097          	auipc	ra,0x3
    2ad0:	76c080e7          	jalr	1900(ra) # 6238 <printf>
    exit(1,0);
    2ad4:	4581                	li	a1,0
    2ad6:	4505                	li	a0,1
    2ad8:	00003097          	auipc	ra,0x3
    2adc:	3e0080e7          	jalr	992(ra) # 5eb8 <exit>
    a = b + 1;
    2ae0:	84be                	mv	s1,a5
    b = sbrk(1);
    2ae2:	4505                	li	a0,1
    2ae4:	00003097          	auipc	ra,0x3
    2ae8:	45c080e7          	jalr	1116(ra) # 5f40 <sbrk>
    if(b != a){
    2aec:	04951d63          	bne	a0,s1,2b46 <sbrkbasic+0x12e>
    *b = 1;
    2af0:	4785                	li	a5,1
    2af2:	00f48023          	sb	a5,0(s1)
    a = b + 1;
    2af6:	00148793          	addi	a5,s1,1
  for(i = 0; i < 5000; i++){
    2afa:	2905                	addiw	s2,s2,1
    2afc:	ff3912e3          	bne	s2,s3,2ae0 <sbrkbasic+0xc8>
  pid = fork();
    2b00:	00003097          	auipc	ra,0x3
    2b04:	3b0080e7          	jalr	944(ra) # 5eb0 <fork>
    2b08:	892a                	mv	s2,a0
  if(pid < 0){
    2b0a:	06054063          	bltz	a0,2b6a <sbrkbasic+0x152>
  c = sbrk(1);
    2b0e:	4505                	li	a0,1
    2b10:	00003097          	auipc	ra,0x3
    2b14:	430080e7          	jalr	1072(ra) # 5f40 <sbrk>
  c = sbrk(1);
    2b18:	4505                	li	a0,1
    2b1a:	00003097          	auipc	ra,0x3
    2b1e:	426080e7          	jalr	1062(ra) # 5f40 <sbrk>
  if(c != a + 1){
    2b22:	0489                	addi	s1,s1,2
    2b24:	06a48263          	beq	s1,a0,2b88 <sbrkbasic+0x170>
    printf("%s: sbrk test failed post-fork\n", s);
    2b28:	85d2                	mv	a1,s4
    2b2a:	00004517          	auipc	a0,0x4
    2b2e:	74650513          	addi	a0,a0,1862 # 7270 <malloc+0xf7a>
    2b32:	00003097          	auipc	ra,0x3
    2b36:	706080e7          	jalr	1798(ra) # 6238 <printf>
    exit(1,0);
    2b3a:	4581                	li	a1,0
    2b3c:	4505                	li	a0,1
    2b3e:	00003097          	auipc	ra,0x3
    2b42:	37a080e7          	jalr	890(ra) # 5eb8 <exit>
      printf("%s: sbrk test failed %d %x %x\n", s, i, a, b);
    2b46:	872a                	mv	a4,a0
    2b48:	86a6                	mv	a3,s1
    2b4a:	864a                	mv	a2,s2
    2b4c:	85d2                	mv	a1,s4
    2b4e:	00004517          	auipc	a0,0x4
    2b52:	6e250513          	addi	a0,a0,1762 # 7230 <malloc+0xf3a>
    2b56:	00003097          	auipc	ra,0x3
    2b5a:	6e2080e7          	jalr	1762(ra) # 6238 <printf>
      exit(1,0);
    2b5e:	4581                	li	a1,0
    2b60:	4505                	li	a0,1
    2b62:	00003097          	auipc	ra,0x3
    2b66:	356080e7          	jalr	854(ra) # 5eb8 <exit>
    printf("%s: sbrk test fork failed\n", s);
    2b6a:	85d2                	mv	a1,s4
    2b6c:	00004517          	auipc	a0,0x4
    2b70:	6e450513          	addi	a0,a0,1764 # 7250 <malloc+0xf5a>
    2b74:	00003097          	auipc	ra,0x3
    2b78:	6c4080e7          	jalr	1732(ra) # 6238 <printf>
    exit(1,0);
    2b7c:	4581                	li	a1,0
    2b7e:	4505                	li	a0,1
    2b80:	00003097          	auipc	ra,0x3
    2b84:	338080e7          	jalr	824(ra) # 5eb8 <exit>
  if(pid == 0)
    2b88:	00091863          	bnez	s2,2b98 <sbrkbasic+0x180>
    exit(0,0);
    2b8c:	4581                	li	a1,0
    2b8e:	4501                	li	a0,0
    2b90:	00003097          	auipc	ra,0x3
    2b94:	328080e7          	jalr	808(ra) # 5eb8 <exit>
  wait(&xstatus,0);
    2b98:	4581                	li	a1,0
    2b9a:	fcc40513          	addi	a0,s0,-52
    2b9e:	00003097          	auipc	ra,0x3
    2ba2:	322080e7          	jalr	802(ra) # 5ec0 <wait>
  exit(xstatus,0);
    2ba6:	4581                	li	a1,0
    2ba8:	fcc42503          	lw	a0,-52(s0)
    2bac:	00003097          	auipc	ra,0x3
    2bb0:	30c080e7          	jalr	780(ra) # 5eb8 <exit>

0000000000002bb4 <sbrkmuch>:
{
    2bb4:	7179                	addi	sp,sp,-48
    2bb6:	f406                	sd	ra,40(sp)
    2bb8:	f022                	sd	s0,32(sp)
    2bba:	ec26                	sd	s1,24(sp)
    2bbc:	e84a                	sd	s2,16(sp)
    2bbe:	e44e                	sd	s3,8(sp)
    2bc0:	e052                	sd	s4,0(sp)
    2bc2:	1800                	addi	s0,sp,48
    2bc4:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    2bc6:	4501                	li	a0,0
    2bc8:	00003097          	auipc	ra,0x3
    2bcc:	378080e7          	jalr	888(ra) # 5f40 <sbrk>
    2bd0:	892a                	mv	s2,a0
  a = sbrk(0);
    2bd2:	4501                	li	a0,0
    2bd4:	00003097          	auipc	ra,0x3
    2bd8:	36c080e7          	jalr	876(ra) # 5f40 <sbrk>
    2bdc:	84aa                	mv	s1,a0
  p = sbrk(amt);
    2bde:	06400537          	lui	a0,0x6400
    2be2:	9d05                	subw	a0,a0,s1
    2be4:	00003097          	auipc	ra,0x3
    2be8:	35c080e7          	jalr	860(ra) # 5f40 <sbrk>
  if (p != a) {
    2bec:	0ca49863          	bne	s1,a0,2cbc <sbrkmuch+0x108>
  char *eee = sbrk(0);
    2bf0:	4501                	li	a0,0
    2bf2:	00003097          	auipc	ra,0x3
    2bf6:	34e080e7          	jalr	846(ra) # 5f40 <sbrk>
    2bfa:	87aa                	mv	a5,a0
  for(char *pp = a; pp < eee; pp += 4096)
    2bfc:	00a4f963          	bgeu	s1,a0,2c0e <sbrkmuch+0x5a>
    *pp = 1;
    2c00:	4685                	li	a3,1
  for(char *pp = a; pp < eee; pp += 4096)
    2c02:	6705                	lui	a4,0x1
    *pp = 1;
    2c04:	00d48023          	sb	a3,0(s1)
  for(char *pp = a; pp < eee; pp += 4096)
    2c08:	94ba                	add	s1,s1,a4
    2c0a:	fef4ede3          	bltu	s1,a5,2c04 <sbrkmuch+0x50>
  *lastaddr = 99;
    2c0e:	064007b7          	lui	a5,0x6400
    2c12:	06300713          	li	a4,99
    2c16:	fee78fa3          	sb	a4,-1(a5) # 63fffff <base+0x63f0387>
  a = sbrk(0);
    2c1a:	4501                	li	a0,0
    2c1c:	00003097          	auipc	ra,0x3
    2c20:	324080e7          	jalr	804(ra) # 5f40 <sbrk>
    2c24:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    2c26:	757d                	lui	a0,0xfffff
    2c28:	00003097          	auipc	ra,0x3
    2c2c:	318080e7          	jalr	792(ra) # 5f40 <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    2c30:	57fd                	li	a5,-1
    2c32:	0af50463          	beq	a0,a5,2cda <sbrkmuch+0x126>
  c = sbrk(0);
    2c36:	4501                	li	a0,0
    2c38:	00003097          	auipc	ra,0x3
    2c3c:	308080e7          	jalr	776(ra) # 5f40 <sbrk>
  if(c != a - PGSIZE){
    2c40:	77fd                	lui	a5,0xfffff
    2c42:	97a6                	add	a5,a5,s1
    2c44:	0af51a63          	bne	a0,a5,2cf8 <sbrkmuch+0x144>
  a = sbrk(0);
    2c48:	4501                	li	a0,0
    2c4a:	00003097          	auipc	ra,0x3
    2c4e:	2f6080e7          	jalr	758(ra) # 5f40 <sbrk>
    2c52:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    2c54:	6505                	lui	a0,0x1
    2c56:	00003097          	auipc	ra,0x3
    2c5a:	2ea080e7          	jalr	746(ra) # 5f40 <sbrk>
    2c5e:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    2c60:	0aa49d63          	bne	s1,a0,2d1a <sbrkmuch+0x166>
    2c64:	4501                	li	a0,0
    2c66:	00003097          	auipc	ra,0x3
    2c6a:	2da080e7          	jalr	730(ra) # 5f40 <sbrk>
    2c6e:	6785                	lui	a5,0x1
    2c70:	97a6                	add	a5,a5,s1
    2c72:	0af51463          	bne	a0,a5,2d1a <sbrkmuch+0x166>
  if(*lastaddr == 99){
    2c76:	064007b7          	lui	a5,0x6400
    2c7a:	fff7c703          	lbu	a4,-1(a5) # 63fffff <base+0x63f0387>
    2c7e:	06300793          	li	a5,99
    2c82:	0af70d63          	beq	a4,a5,2d3c <sbrkmuch+0x188>
  a = sbrk(0);
    2c86:	4501                	li	a0,0
    2c88:	00003097          	auipc	ra,0x3
    2c8c:	2b8080e7          	jalr	696(ra) # 5f40 <sbrk>
    2c90:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    2c92:	4501                	li	a0,0
    2c94:	00003097          	auipc	ra,0x3
    2c98:	2ac080e7          	jalr	684(ra) # 5f40 <sbrk>
    2c9c:	40a9053b          	subw	a0,s2,a0
    2ca0:	00003097          	auipc	ra,0x3
    2ca4:	2a0080e7          	jalr	672(ra) # 5f40 <sbrk>
  if(c != a){
    2ca8:	0aa49963          	bne	s1,a0,2d5a <sbrkmuch+0x1a6>
}
    2cac:	70a2                	ld	ra,40(sp)
    2cae:	7402                	ld	s0,32(sp)
    2cb0:	64e2                	ld	s1,24(sp)
    2cb2:	6942                	ld	s2,16(sp)
    2cb4:	69a2                	ld	s3,8(sp)
    2cb6:	6a02                	ld	s4,0(sp)
    2cb8:	6145                	addi	sp,sp,48
    2cba:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    2cbc:	85ce                	mv	a1,s3
    2cbe:	00004517          	auipc	a0,0x4
    2cc2:	5d250513          	addi	a0,a0,1490 # 7290 <malloc+0xf9a>
    2cc6:	00003097          	auipc	ra,0x3
    2cca:	572080e7          	jalr	1394(ra) # 6238 <printf>
    exit(1,0);
    2cce:	4581                	li	a1,0
    2cd0:	4505                	li	a0,1
    2cd2:	00003097          	auipc	ra,0x3
    2cd6:	1e6080e7          	jalr	486(ra) # 5eb8 <exit>
    printf("%s: sbrk could not deallocate\n", s);
    2cda:	85ce                	mv	a1,s3
    2cdc:	00004517          	auipc	a0,0x4
    2ce0:	5fc50513          	addi	a0,a0,1532 # 72d8 <malloc+0xfe2>
    2ce4:	00003097          	auipc	ra,0x3
    2ce8:	554080e7          	jalr	1364(ra) # 6238 <printf>
    exit(1,0);
    2cec:	4581                	li	a1,0
    2cee:	4505                	li	a0,1
    2cf0:	00003097          	auipc	ra,0x3
    2cf4:	1c8080e7          	jalr	456(ra) # 5eb8 <exit>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", s, a, c);
    2cf8:	86aa                	mv	a3,a0
    2cfa:	8626                	mv	a2,s1
    2cfc:	85ce                	mv	a1,s3
    2cfe:	00004517          	auipc	a0,0x4
    2d02:	5fa50513          	addi	a0,a0,1530 # 72f8 <malloc+0x1002>
    2d06:	00003097          	auipc	ra,0x3
    2d0a:	532080e7          	jalr	1330(ra) # 6238 <printf>
    exit(1,0);
    2d0e:	4581                	li	a1,0
    2d10:	4505                	li	a0,1
    2d12:	00003097          	auipc	ra,0x3
    2d16:	1a6080e7          	jalr	422(ra) # 5eb8 <exit>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", s, a, c);
    2d1a:	86d2                	mv	a3,s4
    2d1c:	8626                	mv	a2,s1
    2d1e:	85ce                	mv	a1,s3
    2d20:	00004517          	auipc	a0,0x4
    2d24:	61850513          	addi	a0,a0,1560 # 7338 <malloc+0x1042>
    2d28:	00003097          	auipc	ra,0x3
    2d2c:	510080e7          	jalr	1296(ra) # 6238 <printf>
    exit(1,0);
    2d30:	4581                	li	a1,0
    2d32:	4505                	li	a0,1
    2d34:	00003097          	auipc	ra,0x3
    2d38:	184080e7          	jalr	388(ra) # 5eb8 <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    2d3c:	85ce                	mv	a1,s3
    2d3e:	00004517          	auipc	a0,0x4
    2d42:	62a50513          	addi	a0,a0,1578 # 7368 <malloc+0x1072>
    2d46:	00003097          	auipc	ra,0x3
    2d4a:	4f2080e7          	jalr	1266(ra) # 6238 <printf>
    exit(1,0);
    2d4e:	4581                	li	a1,0
    2d50:	4505                	li	a0,1
    2d52:	00003097          	auipc	ra,0x3
    2d56:	166080e7          	jalr	358(ra) # 5eb8 <exit>
    printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
    2d5a:	86aa                	mv	a3,a0
    2d5c:	8626                	mv	a2,s1
    2d5e:	85ce                	mv	a1,s3
    2d60:	00004517          	auipc	a0,0x4
    2d64:	64050513          	addi	a0,a0,1600 # 73a0 <malloc+0x10aa>
    2d68:	00003097          	auipc	ra,0x3
    2d6c:	4d0080e7          	jalr	1232(ra) # 6238 <printf>
    exit(1,0);
    2d70:	4581                	li	a1,0
    2d72:	4505                	li	a0,1
    2d74:	00003097          	auipc	ra,0x3
    2d78:	144080e7          	jalr	324(ra) # 5eb8 <exit>

0000000000002d7c <sbrkarg>:
{
    2d7c:	7179                	addi	sp,sp,-48
    2d7e:	f406                	sd	ra,40(sp)
    2d80:	f022                	sd	s0,32(sp)
    2d82:	ec26                	sd	s1,24(sp)
    2d84:	e84a                	sd	s2,16(sp)
    2d86:	e44e                	sd	s3,8(sp)
    2d88:	1800                	addi	s0,sp,48
    2d8a:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    2d8c:	6505                	lui	a0,0x1
    2d8e:	00003097          	auipc	ra,0x3
    2d92:	1b2080e7          	jalr	434(ra) # 5f40 <sbrk>
    2d96:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    2d98:	20100593          	li	a1,513
    2d9c:	00004517          	auipc	a0,0x4
    2da0:	62c50513          	addi	a0,a0,1580 # 73c8 <malloc+0x10d2>
    2da4:	00003097          	auipc	ra,0x3
    2da8:	154080e7          	jalr	340(ra) # 5ef8 <open>
    2dac:	84aa                	mv	s1,a0
  unlink("sbrk");
    2dae:	00004517          	auipc	a0,0x4
    2db2:	61a50513          	addi	a0,a0,1562 # 73c8 <malloc+0x10d2>
    2db6:	00003097          	auipc	ra,0x3
    2dba:	152080e7          	jalr	338(ra) # 5f08 <unlink>
  if(fd < 0)  {
    2dbe:	0404c163          	bltz	s1,2e00 <sbrkarg+0x84>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    2dc2:	6605                	lui	a2,0x1
    2dc4:	85ca                	mv	a1,s2
    2dc6:	8526                	mv	a0,s1
    2dc8:	00003097          	auipc	ra,0x3
    2dcc:	110080e7          	jalr	272(ra) # 5ed8 <write>
    2dd0:	04054763          	bltz	a0,2e1e <sbrkarg+0xa2>
  close(fd);
    2dd4:	8526                	mv	a0,s1
    2dd6:	00003097          	auipc	ra,0x3
    2dda:	10a080e7          	jalr	266(ra) # 5ee0 <close>
  a = sbrk(PGSIZE);
    2dde:	6505                	lui	a0,0x1
    2de0:	00003097          	auipc	ra,0x3
    2de4:	160080e7          	jalr	352(ra) # 5f40 <sbrk>
  if(pipe((int *) a) != 0){
    2de8:	00003097          	auipc	ra,0x3
    2dec:	0e0080e7          	jalr	224(ra) # 5ec8 <pipe>
    2df0:	e531                	bnez	a0,2e3c <sbrkarg+0xc0>
}
    2df2:	70a2                	ld	ra,40(sp)
    2df4:	7402                	ld	s0,32(sp)
    2df6:	64e2                	ld	s1,24(sp)
    2df8:	6942                	ld	s2,16(sp)
    2dfa:	69a2                	ld	s3,8(sp)
    2dfc:	6145                	addi	sp,sp,48
    2dfe:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    2e00:	85ce                	mv	a1,s3
    2e02:	00004517          	auipc	a0,0x4
    2e06:	5ce50513          	addi	a0,a0,1486 # 73d0 <malloc+0x10da>
    2e0a:	00003097          	auipc	ra,0x3
    2e0e:	42e080e7          	jalr	1070(ra) # 6238 <printf>
    exit(1,0);
    2e12:	4581                	li	a1,0
    2e14:	4505                	li	a0,1
    2e16:	00003097          	auipc	ra,0x3
    2e1a:	0a2080e7          	jalr	162(ra) # 5eb8 <exit>
    printf("%s: write sbrk failed\n", s);
    2e1e:	85ce                	mv	a1,s3
    2e20:	00004517          	auipc	a0,0x4
    2e24:	5c850513          	addi	a0,a0,1480 # 73e8 <malloc+0x10f2>
    2e28:	00003097          	auipc	ra,0x3
    2e2c:	410080e7          	jalr	1040(ra) # 6238 <printf>
    exit(1,0);
    2e30:	4581                	li	a1,0
    2e32:	4505                	li	a0,1
    2e34:	00003097          	auipc	ra,0x3
    2e38:	084080e7          	jalr	132(ra) # 5eb8 <exit>
    printf("%s: pipe() failed\n", s);
    2e3c:	85ce                	mv	a1,s3
    2e3e:	00004517          	auipc	a0,0x4
    2e42:	f8a50513          	addi	a0,a0,-118 # 6dc8 <malloc+0xad2>
    2e46:	00003097          	auipc	ra,0x3
    2e4a:	3f2080e7          	jalr	1010(ra) # 6238 <printf>
    exit(1,0);
    2e4e:	4581                	li	a1,0
    2e50:	4505                	li	a0,1
    2e52:	00003097          	auipc	ra,0x3
    2e56:	066080e7          	jalr	102(ra) # 5eb8 <exit>

0000000000002e5a <argptest>:
{
    2e5a:	1101                	addi	sp,sp,-32
    2e5c:	ec06                	sd	ra,24(sp)
    2e5e:	e822                	sd	s0,16(sp)
    2e60:	e426                	sd	s1,8(sp)
    2e62:	e04a                	sd	s2,0(sp)
    2e64:	1000                	addi	s0,sp,32
    2e66:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    2e68:	4581                	li	a1,0
    2e6a:	00004517          	auipc	a0,0x4
    2e6e:	59650513          	addi	a0,a0,1430 # 7400 <malloc+0x110a>
    2e72:	00003097          	auipc	ra,0x3
    2e76:	086080e7          	jalr	134(ra) # 5ef8 <open>
  if (fd < 0) {
    2e7a:	02054b63          	bltz	a0,2eb0 <argptest+0x56>
    2e7e:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    2e80:	4501                	li	a0,0
    2e82:	00003097          	auipc	ra,0x3
    2e86:	0be080e7          	jalr	190(ra) # 5f40 <sbrk>
    2e8a:	567d                	li	a2,-1
    2e8c:	fff50593          	addi	a1,a0,-1
    2e90:	8526                	mv	a0,s1
    2e92:	00003097          	auipc	ra,0x3
    2e96:	03e080e7          	jalr	62(ra) # 5ed0 <read>
  close(fd);
    2e9a:	8526                	mv	a0,s1
    2e9c:	00003097          	auipc	ra,0x3
    2ea0:	044080e7          	jalr	68(ra) # 5ee0 <close>
}
    2ea4:	60e2                	ld	ra,24(sp)
    2ea6:	6442                	ld	s0,16(sp)
    2ea8:	64a2                	ld	s1,8(sp)
    2eaa:	6902                	ld	s2,0(sp)
    2eac:	6105                	addi	sp,sp,32
    2eae:	8082                	ret
    printf("%s: open failed\n", s);
    2eb0:	85ca                	mv	a1,s2
    2eb2:	00004517          	auipc	a0,0x4
    2eb6:	e2650513          	addi	a0,a0,-474 # 6cd8 <malloc+0x9e2>
    2eba:	00003097          	auipc	ra,0x3
    2ebe:	37e080e7          	jalr	894(ra) # 6238 <printf>
    exit(1,0);
    2ec2:	4581                	li	a1,0
    2ec4:	4505                	li	a0,1
    2ec6:	00003097          	auipc	ra,0x3
    2eca:	ff2080e7          	jalr	-14(ra) # 5eb8 <exit>

0000000000002ece <sbrkbugs>:
{
    2ece:	1141                	addi	sp,sp,-16
    2ed0:	e406                	sd	ra,8(sp)
    2ed2:	e022                	sd	s0,0(sp)
    2ed4:	0800                	addi	s0,sp,16
  int pid = fork();
    2ed6:	00003097          	auipc	ra,0x3
    2eda:	fda080e7          	jalr	-38(ra) # 5eb0 <fork>
  if(pid < 0){
    2ede:	02054363          	bltz	a0,2f04 <sbrkbugs+0x36>
  if(pid == 0){
    2ee2:	ed1d                	bnez	a0,2f20 <sbrkbugs+0x52>
    int sz = (uint64) sbrk(0);
    2ee4:	00003097          	auipc	ra,0x3
    2ee8:	05c080e7          	jalr	92(ra) # 5f40 <sbrk>
    sbrk(-sz);
    2eec:	40a0053b          	negw	a0,a0
    2ef0:	00003097          	auipc	ra,0x3
    2ef4:	050080e7          	jalr	80(ra) # 5f40 <sbrk>
    exit(0,0);
    2ef8:	4581                	li	a1,0
    2efa:	4501                	li	a0,0
    2efc:	00003097          	auipc	ra,0x3
    2f00:	fbc080e7          	jalr	-68(ra) # 5eb8 <exit>
    printf("fork failed\n");
    2f04:	00004517          	auipc	a0,0x4
    2f08:	1c450513          	addi	a0,a0,452 # 70c8 <malloc+0xdd2>
    2f0c:	00003097          	auipc	ra,0x3
    2f10:	32c080e7          	jalr	812(ra) # 6238 <printf>
    exit(1,0);
    2f14:	4581                	li	a1,0
    2f16:	4505                	li	a0,1
    2f18:	00003097          	auipc	ra,0x3
    2f1c:	fa0080e7          	jalr	-96(ra) # 5eb8 <exit>
  wait(0,0);
    2f20:	4581                	li	a1,0
    2f22:	4501                	li	a0,0
    2f24:	00003097          	auipc	ra,0x3
    2f28:	f9c080e7          	jalr	-100(ra) # 5ec0 <wait>
  pid = fork();
    2f2c:	00003097          	auipc	ra,0x3
    2f30:	f84080e7          	jalr	-124(ra) # 5eb0 <fork>
  if(pid < 0){
    2f34:	02054663          	bltz	a0,2f60 <sbrkbugs+0x92>
  if(pid == 0){
    2f38:	e131                	bnez	a0,2f7c <sbrkbugs+0xae>
    int sz = (uint64) sbrk(0);
    2f3a:	00003097          	auipc	ra,0x3
    2f3e:	006080e7          	jalr	6(ra) # 5f40 <sbrk>
    sbrk(-(sz - 3500));
    2f42:	6785                	lui	a5,0x1
    2f44:	dac7879b          	addiw	a5,a5,-596
    2f48:	40a7853b          	subw	a0,a5,a0
    2f4c:	00003097          	auipc	ra,0x3
    2f50:	ff4080e7          	jalr	-12(ra) # 5f40 <sbrk>
    exit(0,0);
    2f54:	4581                	li	a1,0
    2f56:	4501                	li	a0,0
    2f58:	00003097          	auipc	ra,0x3
    2f5c:	f60080e7          	jalr	-160(ra) # 5eb8 <exit>
    printf("fork failed\n");
    2f60:	00004517          	auipc	a0,0x4
    2f64:	16850513          	addi	a0,a0,360 # 70c8 <malloc+0xdd2>
    2f68:	00003097          	auipc	ra,0x3
    2f6c:	2d0080e7          	jalr	720(ra) # 6238 <printf>
    exit(1,0);
    2f70:	4581                	li	a1,0
    2f72:	4505                	li	a0,1
    2f74:	00003097          	auipc	ra,0x3
    2f78:	f44080e7          	jalr	-188(ra) # 5eb8 <exit>
  wait(0,0);
    2f7c:	4581                	li	a1,0
    2f7e:	4501                	li	a0,0
    2f80:	00003097          	auipc	ra,0x3
    2f84:	f40080e7          	jalr	-192(ra) # 5ec0 <wait>
  pid = fork();
    2f88:	00003097          	auipc	ra,0x3
    2f8c:	f28080e7          	jalr	-216(ra) # 5eb0 <fork>
  if(pid < 0){
    2f90:	02054b63          	bltz	a0,2fc6 <sbrkbugs+0xf8>
  if(pid == 0){
    2f94:	e539                	bnez	a0,2fe2 <sbrkbugs+0x114>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    2f96:	00003097          	auipc	ra,0x3
    2f9a:	faa080e7          	jalr	-86(ra) # 5f40 <sbrk>
    2f9e:	67ad                	lui	a5,0xb
    2fa0:	8007879b          	addiw	a5,a5,-2048
    2fa4:	40a7853b          	subw	a0,a5,a0
    2fa8:	00003097          	auipc	ra,0x3
    2fac:	f98080e7          	jalr	-104(ra) # 5f40 <sbrk>
    sbrk(-10);
    2fb0:	5559                	li	a0,-10
    2fb2:	00003097          	auipc	ra,0x3
    2fb6:	f8e080e7          	jalr	-114(ra) # 5f40 <sbrk>
    exit(0,0);
    2fba:	4581                	li	a1,0
    2fbc:	4501                	li	a0,0
    2fbe:	00003097          	auipc	ra,0x3
    2fc2:	efa080e7          	jalr	-262(ra) # 5eb8 <exit>
    printf("fork failed\n");
    2fc6:	00004517          	auipc	a0,0x4
    2fca:	10250513          	addi	a0,a0,258 # 70c8 <malloc+0xdd2>
    2fce:	00003097          	auipc	ra,0x3
    2fd2:	26a080e7          	jalr	618(ra) # 6238 <printf>
    exit(1,0);
    2fd6:	4581                	li	a1,0
    2fd8:	4505                	li	a0,1
    2fda:	00003097          	auipc	ra,0x3
    2fde:	ede080e7          	jalr	-290(ra) # 5eb8 <exit>
  wait(0,0);
    2fe2:	4581                	li	a1,0
    2fe4:	4501                	li	a0,0
    2fe6:	00003097          	auipc	ra,0x3
    2fea:	eda080e7          	jalr	-294(ra) # 5ec0 <wait>
  exit(0,0);
    2fee:	4581                	li	a1,0
    2ff0:	4501                	li	a0,0
    2ff2:	00003097          	auipc	ra,0x3
    2ff6:	ec6080e7          	jalr	-314(ra) # 5eb8 <exit>

0000000000002ffa <sbrklast>:
{
    2ffa:	7179                	addi	sp,sp,-48
    2ffc:	f406                	sd	ra,40(sp)
    2ffe:	f022                	sd	s0,32(sp)
    3000:	ec26                	sd	s1,24(sp)
    3002:	e84a                	sd	s2,16(sp)
    3004:	e44e                	sd	s3,8(sp)
    3006:	e052                	sd	s4,0(sp)
    3008:	1800                	addi	s0,sp,48
  uint64 top = (uint64) sbrk(0);
    300a:	4501                	li	a0,0
    300c:	00003097          	auipc	ra,0x3
    3010:	f34080e7          	jalr	-204(ra) # 5f40 <sbrk>
  if((top % 4096) != 0)
    3014:	03451793          	slli	a5,a0,0x34
    3018:	ebd9                	bnez	a5,30ae <sbrklast+0xb4>
  sbrk(4096);
    301a:	6505                	lui	a0,0x1
    301c:	00003097          	auipc	ra,0x3
    3020:	f24080e7          	jalr	-220(ra) # 5f40 <sbrk>
  sbrk(10);
    3024:	4529                	li	a0,10
    3026:	00003097          	auipc	ra,0x3
    302a:	f1a080e7          	jalr	-230(ra) # 5f40 <sbrk>
  sbrk(-20);
    302e:	5531                	li	a0,-20
    3030:	00003097          	auipc	ra,0x3
    3034:	f10080e7          	jalr	-240(ra) # 5f40 <sbrk>
  top = (uint64) sbrk(0);
    3038:	4501                	li	a0,0
    303a:	00003097          	auipc	ra,0x3
    303e:	f06080e7          	jalr	-250(ra) # 5f40 <sbrk>
    3042:	84aa                	mv	s1,a0
  char *p = (char *) (top - 64);
    3044:	fc050913          	addi	s2,a0,-64 # fc0 <linktest+0x70>
  p[0] = 'x';
    3048:	07800a13          	li	s4,120
    304c:	fd450023          	sb	s4,-64(a0)
  p[1] = '\0';
    3050:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR|O_CREATE);
    3054:	20200593          	li	a1,514
    3058:	854a                	mv	a0,s2
    305a:	00003097          	auipc	ra,0x3
    305e:	e9e080e7          	jalr	-354(ra) # 5ef8 <open>
    3062:	89aa                	mv	s3,a0
  write(fd, p, 1);
    3064:	4605                	li	a2,1
    3066:	85ca                	mv	a1,s2
    3068:	00003097          	auipc	ra,0x3
    306c:	e70080e7          	jalr	-400(ra) # 5ed8 <write>
  close(fd);
    3070:	854e                	mv	a0,s3
    3072:	00003097          	auipc	ra,0x3
    3076:	e6e080e7          	jalr	-402(ra) # 5ee0 <close>
  fd = open(p, O_RDWR);
    307a:	4589                	li	a1,2
    307c:	854a                	mv	a0,s2
    307e:	00003097          	auipc	ra,0x3
    3082:	e7a080e7          	jalr	-390(ra) # 5ef8 <open>
  p[0] = '\0';
    3086:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    308a:	4605                	li	a2,1
    308c:	85ca                	mv	a1,s2
    308e:	00003097          	auipc	ra,0x3
    3092:	e42080e7          	jalr	-446(ra) # 5ed0 <read>
  if(p[0] != 'x')
    3096:	fc04c783          	lbu	a5,-64(s1)
    309a:	03479463          	bne	a5,s4,30c2 <sbrklast+0xc8>
}
    309e:	70a2                	ld	ra,40(sp)
    30a0:	7402                	ld	s0,32(sp)
    30a2:	64e2                	ld	s1,24(sp)
    30a4:	6942                	ld	s2,16(sp)
    30a6:	69a2                	ld	s3,8(sp)
    30a8:	6a02                	ld	s4,0(sp)
    30aa:	6145                	addi	sp,sp,48
    30ac:	8082                	ret
    sbrk(4096 - (top % 4096));
    30ae:	0347d513          	srli	a0,a5,0x34
    30b2:	6785                	lui	a5,0x1
    30b4:	40a7853b          	subw	a0,a5,a0
    30b8:	00003097          	auipc	ra,0x3
    30bc:	e88080e7          	jalr	-376(ra) # 5f40 <sbrk>
    30c0:	bfa9                	j	301a <sbrklast+0x20>
    exit(1,0);
    30c2:	4581                	li	a1,0
    30c4:	4505                	li	a0,1
    30c6:	00003097          	auipc	ra,0x3
    30ca:	df2080e7          	jalr	-526(ra) # 5eb8 <exit>

00000000000030ce <sbrk8000>:
{
    30ce:	1141                	addi	sp,sp,-16
    30d0:	e406                	sd	ra,8(sp)
    30d2:	e022                	sd	s0,0(sp)
    30d4:	0800                	addi	s0,sp,16
  sbrk(0x80000004);
    30d6:	80000537          	lui	a0,0x80000
    30da:	0511                	addi	a0,a0,4
    30dc:	00003097          	auipc	ra,0x3
    30e0:	e64080e7          	jalr	-412(ra) # 5f40 <sbrk>
  volatile char *top = sbrk(0);
    30e4:	4501                	li	a0,0
    30e6:	00003097          	auipc	ra,0x3
    30ea:	e5a080e7          	jalr	-422(ra) # 5f40 <sbrk>
  *(top-1) = *(top-1) + 1;
    30ee:	fff54783          	lbu	a5,-1(a0) # ffffffff7fffffff <base+0xffffffff7fff0387>
    30f2:	0785                	addi	a5,a5,1
    30f4:	0ff7f793          	andi	a5,a5,255
    30f8:	fef50fa3          	sb	a5,-1(a0)
}
    30fc:	60a2                	ld	ra,8(sp)
    30fe:	6402                	ld	s0,0(sp)
    3100:	0141                	addi	sp,sp,16
    3102:	8082                	ret

0000000000003104 <execout>:
{
    3104:	715d                	addi	sp,sp,-80
    3106:	e486                	sd	ra,72(sp)
    3108:	e0a2                	sd	s0,64(sp)
    310a:	fc26                	sd	s1,56(sp)
    310c:	f84a                	sd	s2,48(sp)
    310e:	f44e                	sd	s3,40(sp)
    3110:	f052                	sd	s4,32(sp)
    3112:	0880                	addi	s0,sp,80
  for(int avail = 0; avail < 15; avail++){
    3114:	4901                	li	s2,0
    3116:	49bd                	li	s3,15
    int pid = fork();
    3118:	00003097          	auipc	ra,0x3
    311c:	d98080e7          	jalr	-616(ra) # 5eb0 <fork>
    3120:	84aa                	mv	s1,a0
    if(pid < 0){
    3122:	02054263          	bltz	a0,3146 <execout+0x42>
    } else if(pid == 0){
    3126:	cd15                	beqz	a0,3162 <execout+0x5e>
      wait((int*)0,0);
    3128:	4581                	li	a1,0
    312a:	4501                	li	a0,0
    312c:	00003097          	auipc	ra,0x3
    3130:	d94080e7          	jalr	-620(ra) # 5ec0 <wait>
  for(int avail = 0; avail < 15; avail++){
    3134:	2905                	addiw	s2,s2,1
    3136:	ff3911e3          	bne	s2,s3,3118 <execout+0x14>
  exit(0,0);
    313a:	4581                	li	a1,0
    313c:	4501                	li	a0,0
    313e:	00003097          	auipc	ra,0x3
    3142:	d7a080e7          	jalr	-646(ra) # 5eb8 <exit>
      printf("fork failed\n");
    3146:	00004517          	auipc	a0,0x4
    314a:	f8250513          	addi	a0,a0,-126 # 70c8 <malloc+0xdd2>
    314e:	00003097          	auipc	ra,0x3
    3152:	0ea080e7          	jalr	234(ra) # 6238 <printf>
      exit(1,0);
    3156:	4581                	li	a1,0
    3158:	4505                	li	a0,1
    315a:	00003097          	auipc	ra,0x3
    315e:	d5e080e7          	jalr	-674(ra) # 5eb8 <exit>
        if(a == 0xffffffffffffffffLL)
    3162:	59fd                	li	s3,-1
        *(char*)(a + 4096 - 1) = 1;
    3164:	4a05                	li	s4,1
        uint64 a = (uint64) sbrk(4096);
    3166:	6505                	lui	a0,0x1
    3168:	00003097          	auipc	ra,0x3
    316c:	dd8080e7          	jalr	-552(ra) # 5f40 <sbrk>
        if(a == 0xffffffffffffffffLL)
    3170:	01350763          	beq	a0,s3,317e <execout+0x7a>
        *(char*)(a + 4096 - 1) = 1;
    3174:	6785                	lui	a5,0x1
    3176:	953e                	add	a0,a0,a5
    3178:	ff450fa3          	sb	s4,-1(a0) # fff <linktest+0xaf>
      while(1){
    317c:	b7ed                	j	3166 <execout+0x62>
      for(int i = 0; i < avail; i++)
    317e:	01205a63          	blez	s2,3192 <execout+0x8e>
        sbrk(-4096);
    3182:	757d                	lui	a0,0xfffff
    3184:	00003097          	auipc	ra,0x3
    3188:	dbc080e7          	jalr	-580(ra) # 5f40 <sbrk>
      for(int i = 0; i < avail; i++)
    318c:	2485                	addiw	s1,s1,1
    318e:	ff249ae3          	bne	s1,s2,3182 <execout+0x7e>
      close(1);
    3192:	4505                	li	a0,1
    3194:	00003097          	auipc	ra,0x3
    3198:	d4c080e7          	jalr	-692(ra) # 5ee0 <close>
      char *args[] = { "echo", "x", 0 };
    319c:	00003517          	auipc	a0,0x3
    31a0:	29c50513          	addi	a0,a0,668 # 6438 <malloc+0x142>
    31a4:	faa43c23          	sd	a0,-72(s0)
    31a8:	00003797          	auipc	a5,0x3
    31ac:	30078793          	addi	a5,a5,768 # 64a8 <malloc+0x1b2>
    31b0:	fcf43023          	sd	a5,-64(s0)
    31b4:	fc043423          	sd	zero,-56(s0)
      exec("echo", args);
    31b8:	fb840593          	addi	a1,s0,-72
    31bc:	00003097          	auipc	ra,0x3
    31c0:	d34080e7          	jalr	-716(ra) # 5ef0 <exec>
      exit(0,0);
    31c4:	4581                	li	a1,0
    31c6:	4501                	li	a0,0
    31c8:	00003097          	auipc	ra,0x3
    31cc:	cf0080e7          	jalr	-784(ra) # 5eb8 <exit>

00000000000031d0 <fourteen>:
{
    31d0:	1101                	addi	sp,sp,-32
    31d2:	ec06                	sd	ra,24(sp)
    31d4:	e822                	sd	s0,16(sp)
    31d6:	e426                	sd	s1,8(sp)
    31d8:	1000                	addi	s0,sp,32
    31da:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    31dc:	00004517          	auipc	a0,0x4
    31e0:	3fc50513          	addi	a0,a0,1020 # 75d8 <malloc+0x12e2>
    31e4:	00003097          	auipc	ra,0x3
    31e8:	d3c080e7          	jalr	-708(ra) # 5f20 <mkdir>
    31ec:	e16d                	bnez	a0,32ce <fourteen+0xfe>
  if(mkdir("12345678901234/123456789012345") != 0){
    31ee:	00004517          	auipc	a0,0x4
    31f2:	24250513          	addi	a0,a0,578 # 7430 <malloc+0x113a>
    31f6:	00003097          	auipc	ra,0x3
    31fa:	d2a080e7          	jalr	-726(ra) # 5f20 <mkdir>
    31fe:	e57d                	bnez	a0,32ec <fourteen+0x11c>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    3200:	20000593          	li	a1,512
    3204:	00004517          	auipc	a0,0x4
    3208:	28450513          	addi	a0,a0,644 # 7488 <malloc+0x1192>
    320c:	00003097          	auipc	ra,0x3
    3210:	cec080e7          	jalr	-788(ra) # 5ef8 <open>
  if(fd < 0){
    3214:	0e054b63          	bltz	a0,330a <fourteen+0x13a>
  close(fd);
    3218:	00003097          	auipc	ra,0x3
    321c:	cc8080e7          	jalr	-824(ra) # 5ee0 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    3220:	4581                	li	a1,0
    3222:	00004517          	auipc	a0,0x4
    3226:	2de50513          	addi	a0,a0,734 # 7500 <malloc+0x120a>
    322a:	00003097          	auipc	ra,0x3
    322e:	cce080e7          	jalr	-818(ra) # 5ef8 <open>
  if(fd < 0){
    3232:	0e054b63          	bltz	a0,3328 <fourteen+0x158>
  close(fd);
    3236:	00003097          	auipc	ra,0x3
    323a:	caa080e7          	jalr	-854(ra) # 5ee0 <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    323e:	00004517          	auipc	a0,0x4
    3242:	33250513          	addi	a0,a0,818 # 7570 <malloc+0x127a>
    3246:	00003097          	auipc	ra,0x3
    324a:	cda080e7          	jalr	-806(ra) # 5f20 <mkdir>
    324e:	cd65                	beqz	a0,3346 <fourteen+0x176>
  if(mkdir("123456789012345/12345678901234") == 0){
    3250:	00004517          	auipc	a0,0x4
    3254:	37850513          	addi	a0,a0,888 # 75c8 <malloc+0x12d2>
    3258:	00003097          	auipc	ra,0x3
    325c:	cc8080e7          	jalr	-824(ra) # 5f20 <mkdir>
    3260:	10050263          	beqz	a0,3364 <fourteen+0x194>
  unlink("123456789012345/12345678901234");
    3264:	00004517          	auipc	a0,0x4
    3268:	36450513          	addi	a0,a0,868 # 75c8 <malloc+0x12d2>
    326c:	00003097          	auipc	ra,0x3
    3270:	c9c080e7          	jalr	-868(ra) # 5f08 <unlink>
  unlink("12345678901234/12345678901234");
    3274:	00004517          	auipc	a0,0x4
    3278:	2fc50513          	addi	a0,a0,764 # 7570 <malloc+0x127a>
    327c:	00003097          	auipc	ra,0x3
    3280:	c8c080e7          	jalr	-884(ra) # 5f08 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    3284:	00004517          	auipc	a0,0x4
    3288:	27c50513          	addi	a0,a0,636 # 7500 <malloc+0x120a>
    328c:	00003097          	auipc	ra,0x3
    3290:	c7c080e7          	jalr	-900(ra) # 5f08 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    3294:	00004517          	auipc	a0,0x4
    3298:	1f450513          	addi	a0,a0,500 # 7488 <malloc+0x1192>
    329c:	00003097          	auipc	ra,0x3
    32a0:	c6c080e7          	jalr	-916(ra) # 5f08 <unlink>
  unlink("12345678901234/123456789012345");
    32a4:	00004517          	auipc	a0,0x4
    32a8:	18c50513          	addi	a0,a0,396 # 7430 <malloc+0x113a>
    32ac:	00003097          	auipc	ra,0x3
    32b0:	c5c080e7          	jalr	-932(ra) # 5f08 <unlink>
  unlink("12345678901234");
    32b4:	00004517          	auipc	a0,0x4
    32b8:	32450513          	addi	a0,a0,804 # 75d8 <malloc+0x12e2>
    32bc:	00003097          	auipc	ra,0x3
    32c0:	c4c080e7          	jalr	-948(ra) # 5f08 <unlink>
}
    32c4:	60e2                	ld	ra,24(sp)
    32c6:	6442                	ld	s0,16(sp)
    32c8:	64a2                	ld	s1,8(sp)
    32ca:	6105                	addi	sp,sp,32
    32cc:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    32ce:	85a6                	mv	a1,s1
    32d0:	00004517          	auipc	a0,0x4
    32d4:	13850513          	addi	a0,a0,312 # 7408 <malloc+0x1112>
    32d8:	00003097          	auipc	ra,0x3
    32dc:	f60080e7          	jalr	-160(ra) # 6238 <printf>
    exit(1,0);
    32e0:	4581                	li	a1,0
    32e2:	4505                	li	a0,1
    32e4:	00003097          	auipc	ra,0x3
    32e8:	bd4080e7          	jalr	-1068(ra) # 5eb8 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    32ec:	85a6                	mv	a1,s1
    32ee:	00004517          	auipc	a0,0x4
    32f2:	16250513          	addi	a0,a0,354 # 7450 <malloc+0x115a>
    32f6:	00003097          	auipc	ra,0x3
    32fa:	f42080e7          	jalr	-190(ra) # 6238 <printf>
    exit(1,0);
    32fe:	4581                	li	a1,0
    3300:	4505                	li	a0,1
    3302:	00003097          	auipc	ra,0x3
    3306:	bb6080e7          	jalr	-1098(ra) # 5eb8 <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    330a:	85a6                	mv	a1,s1
    330c:	00004517          	auipc	a0,0x4
    3310:	1ac50513          	addi	a0,a0,428 # 74b8 <malloc+0x11c2>
    3314:	00003097          	auipc	ra,0x3
    3318:	f24080e7          	jalr	-220(ra) # 6238 <printf>
    exit(1,0);
    331c:	4581                	li	a1,0
    331e:	4505                	li	a0,1
    3320:	00003097          	auipc	ra,0x3
    3324:	b98080e7          	jalr	-1128(ra) # 5eb8 <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    3328:	85a6                	mv	a1,s1
    332a:	00004517          	auipc	a0,0x4
    332e:	20650513          	addi	a0,a0,518 # 7530 <malloc+0x123a>
    3332:	00003097          	auipc	ra,0x3
    3336:	f06080e7          	jalr	-250(ra) # 6238 <printf>
    exit(1,0);
    333a:	4581                	li	a1,0
    333c:	4505                	li	a0,1
    333e:	00003097          	auipc	ra,0x3
    3342:	b7a080e7          	jalr	-1158(ra) # 5eb8 <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    3346:	85a6                	mv	a1,s1
    3348:	00004517          	auipc	a0,0x4
    334c:	24850513          	addi	a0,a0,584 # 7590 <malloc+0x129a>
    3350:	00003097          	auipc	ra,0x3
    3354:	ee8080e7          	jalr	-280(ra) # 6238 <printf>
    exit(1,0);
    3358:	4581                	li	a1,0
    335a:	4505                	li	a0,1
    335c:	00003097          	auipc	ra,0x3
    3360:	b5c080e7          	jalr	-1188(ra) # 5eb8 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    3364:	85a6                	mv	a1,s1
    3366:	00004517          	auipc	a0,0x4
    336a:	28250513          	addi	a0,a0,642 # 75e8 <malloc+0x12f2>
    336e:	00003097          	auipc	ra,0x3
    3372:	eca080e7          	jalr	-310(ra) # 6238 <printf>
    exit(1,0);
    3376:	4581                	li	a1,0
    3378:	4505                	li	a0,1
    337a:	00003097          	auipc	ra,0x3
    337e:	b3e080e7          	jalr	-1218(ra) # 5eb8 <exit>

0000000000003382 <diskfull>:
{
    3382:	b9010113          	addi	sp,sp,-1136
    3386:	46113423          	sd	ra,1128(sp)
    338a:	46813023          	sd	s0,1120(sp)
    338e:	44913c23          	sd	s1,1112(sp)
    3392:	45213823          	sd	s2,1104(sp)
    3396:	45313423          	sd	s3,1096(sp)
    339a:	45413023          	sd	s4,1088(sp)
    339e:	43513c23          	sd	s5,1080(sp)
    33a2:	43613823          	sd	s6,1072(sp)
    33a6:	43713423          	sd	s7,1064(sp)
    33aa:	43813023          	sd	s8,1056(sp)
    33ae:	47010413          	addi	s0,sp,1136
    33b2:	8c2a                	mv	s8,a0
  unlink("diskfulldir");
    33b4:	00004517          	auipc	a0,0x4
    33b8:	26c50513          	addi	a0,a0,620 # 7620 <malloc+0x132a>
    33bc:	00003097          	auipc	ra,0x3
    33c0:	b4c080e7          	jalr	-1204(ra) # 5f08 <unlink>
  for(fi = 0; done == 0; fi++){
    33c4:	4a01                	li	s4,0
    name[0] = 'b';
    33c6:	06200b13          	li	s6,98
    name[1] = 'i';
    33ca:	06900a93          	li	s5,105
    name[2] = 'g';
    33ce:	06700993          	li	s3,103
    33d2:	10c00b93          	li	s7,268
    33d6:	aabd                	j	3554 <diskfull+0x1d2>
      printf("%s: could not create file %s\n", s, name);
    33d8:	b9040613          	addi	a2,s0,-1136
    33dc:	85e2                	mv	a1,s8
    33de:	00004517          	auipc	a0,0x4
    33e2:	25250513          	addi	a0,a0,594 # 7630 <malloc+0x133a>
    33e6:	00003097          	auipc	ra,0x3
    33ea:	e52080e7          	jalr	-430(ra) # 6238 <printf>
      break;
    33ee:	a821                	j	3406 <diskfull+0x84>
        close(fd);
    33f0:	854a                	mv	a0,s2
    33f2:	00003097          	auipc	ra,0x3
    33f6:	aee080e7          	jalr	-1298(ra) # 5ee0 <close>
    close(fd);
    33fa:	854a                	mv	a0,s2
    33fc:	00003097          	auipc	ra,0x3
    3400:	ae4080e7          	jalr	-1308(ra) # 5ee0 <close>
  for(fi = 0; done == 0; fi++){
    3404:	2a05                	addiw	s4,s4,1
  for(int i = 0; i < nzz; i++){
    3406:	4481                	li	s1,0
    name[0] = 'z';
    3408:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    340c:	08000993          	li	s3,128
    name[0] = 'z';
    3410:	bb240823          	sb	s2,-1104(s0)
    name[1] = 'z';
    3414:	bb2408a3          	sb	s2,-1103(s0)
    name[2] = '0' + (i / 32);
    3418:	41f4d79b          	sraiw	a5,s1,0x1f
    341c:	01b7d71b          	srliw	a4,a5,0x1b
    3420:	009707bb          	addw	a5,a4,s1
    3424:	4057d69b          	sraiw	a3,a5,0x5
    3428:	0306869b          	addiw	a3,a3,48
    342c:	bad40923          	sb	a3,-1102(s0)
    name[3] = '0' + (i % 32);
    3430:	8bfd                	andi	a5,a5,31
    3432:	9f99                	subw	a5,a5,a4
    3434:	0307879b          	addiw	a5,a5,48
    3438:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    343c:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    3440:	bb040513          	addi	a0,s0,-1104
    3444:	00003097          	auipc	ra,0x3
    3448:	ac4080e7          	jalr	-1340(ra) # 5f08 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    344c:	60200593          	li	a1,1538
    3450:	bb040513          	addi	a0,s0,-1104
    3454:	00003097          	auipc	ra,0x3
    3458:	aa4080e7          	jalr	-1372(ra) # 5ef8 <open>
    if(fd < 0)
    345c:	00054963          	bltz	a0,346e <diskfull+0xec>
    close(fd);
    3460:	00003097          	auipc	ra,0x3
    3464:	a80080e7          	jalr	-1408(ra) # 5ee0 <close>
  for(int i = 0; i < nzz; i++){
    3468:	2485                	addiw	s1,s1,1
    346a:	fb3493e3          	bne	s1,s3,3410 <diskfull+0x8e>
  if(mkdir("diskfulldir") == 0)
    346e:	00004517          	auipc	a0,0x4
    3472:	1b250513          	addi	a0,a0,434 # 7620 <malloc+0x132a>
    3476:	00003097          	auipc	ra,0x3
    347a:	aaa080e7          	jalr	-1366(ra) # 5f20 <mkdir>
    347e:	12050963          	beqz	a0,35b0 <diskfull+0x22e>
  unlink("diskfulldir");
    3482:	00004517          	auipc	a0,0x4
    3486:	19e50513          	addi	a0,a0,414 # 7620 <malloc+0x132a>
    348a:	00003097          	auipc	ra,0x3
    348e:	a7e080e7          	jalr	-1410(ra) # 5f08 <unlink>
  for(int i = 0; i < nzz; i++){
    3492:	4481                	li	s1,0
    name[0] = 'z';
    3494:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    3498:	08000993          	li	s3,128
    name[0] = 'z';
    349c:	bb240823          	sb	s2,-1104(s0)
    name[1] = 'z';
    34a0:	bb2408a3          	sb	s2,-1103(s0)
    name[2] = '0' + (i / 32);
    34a4:	41f4d79b          	sraiw	a5,s1,0x1f
    34a8:	01b7d71b          	srliw	a4,a5,0x1b
    34ac:	009707bb          	addw	a5,a4,s1
    34b0:	4057d69b          	sraiw	a3,a5,0x5
    34b4:	0306869b          	addiw	a3,a3,48
    34b8:	bad40923          	sb	a3,-1102(s0)
    name[3] = '0' + (i % 32);
    34bc:	8bfd                	andi	a5,a5,31
    34be:	9f99                	subw	a5,a5,a4
    34c0:	0307879b          	addiw	a5,a5,48
    34c4:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    34c8:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    34cc:	bb040513          	addi	a0,s0,-1104
    34d0:	00003097          	auipc	ra,0x3
    34d4:	a38080e7          	jalr	-1480(ra) # 5f08 <unlink>
  for(int i = 0; i < nzz; i++){
    34d8:	2485                	addiw	s1,s1,1
    34da:	fd3491e3          	bne	s1,s3,349c <diskfull+0x11a>
  for(int i = 0; i < fi; i++){
    34de:	03405e63          	blez	s4,351a <diskfull+0x198>
    34e2:	4481                	li	s1,0
    name[0] = 'b';
    34e4:	06200a93          	li	s5,98
    name[1] = 'i';
    34e8:	06900993          	li	s3,105
    name[2] = 'g';
    34ec:	06700913          	li	s2,103
    name[0] = 'b';
    34f0:	bb540823          	sb	s5,-1104(s0)
    name[1] = 'i';
    34f4:	bb3408a3          	sb	s3,-1103(s0)
    name[2] = 'g';
    34f8:	bb240923          	sb	s2,-1102(s0)
    name[3] = '0' + i;
    34fc:	0304879b          	addiw	a5,s1,48
    3500:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    3504:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    3508:	bb040513          	addi	a0,s0,-1104
    350c:	00003097          	auipc	ra,0x3
    3510:	9fc080e7          	jalr	-1540(ra) # 5f08 <unlink>
  for(int i = 0; i < fi; i++){
    3514:	2485                	addiw	s1,s1,1
    3516:	fd449de3          	bne	s1,s4,34f0 <diskfull+0x16e>
}
    351a:	46813083          	ld	ra,1128(sp)
    351e:	46013403          	ld	s0,1120(sp)
    3522:	45813483          	ld	s1,1112(sp)
    3526:	45013903          	ld	s2,1104(sp)
    352a:	44813983          	ld	s3,1096(sp)
    352e:	44013a03          	ld	s4,1088(sp)
    3532:	43813a83          	ld	s5,1080(sp)
    3536:	43013b03          	ld	s6,1072(sp)
    353a:	42813b83          	ld	s7,1064(sp)
    353e:	42013c03          	ld	s8,1056(sp)
    3542:	47010113          	addi	sp,sp,1136
    3546:	8082                	ret
    close(fd);
    3548:	854a                	mv	a0,s2
    354a:	00003097          	auipc	ra,0x3
    354e:	996080e7          	jalr	-1642(ra) # 5ee0 <close>
  for(fi = 0; done == 0; fi++){
    3552:	2a05                	addiw	s4,s4,1
    name[0] = 'b';
    3554:	b9640823          	sb	s6,-1136(s0)
    name[1] = 'i';
    3558:	b95408a3          	sb	s5,-1135(s0)
    name[2] = 'g';
    355c:	b9340923          	sb	s3,-1134(s0)
    name[3] = '0' + fi;
    3560:	030a079b          	addiw	a5,s4,48
    3564:	b8f409a3          	sb	a5,-1133(s0)
    name[4] = '\0';
    3568:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    356c:	b9040513          	addi	a0,s0,-1136
    3570:	00003097          	auipc	ra,0x3
    3574:	998080e7          	jalr	-1640(ra) # 5f08 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    3578:	60200593          	li	a1,1538
    357c:	b9040513          	addi	a0,s0,-1136
    3580:	00003097          	auipc	ra,0x3
    3584:	978080e7          	jalr	-1672(ra) # 5ef8 <open>
    3588:	892a                	mv	s2,a0
    if(fd < 0){
    358a:	e40547e3          	bltz	a0,33d8 <diskfull+0x56>
    358e:	84de                	mv	s1,s7
      if(write(fd, buf, BSIZE) != BSIZE){
    3590:	40000613          	li	a2,1024
    3594:	bb040593          	addi	a1,s0,-1104
    3598:	854a                	mv	a0,s2
    359a:	00003097          	auipc	ra,0x3
    359e:	93e080e7          	jalr	-1730(ra) # 5ed8 <write>
    35a2:	40000793          	li	a5,1024
    35a6:	e4f515e3          	bne	a0,a5,33f0 <diskfull+0x6e>
    for(int i = 0; i < MAXFILE; i++){
    35aa:	34fd                	addiw	s1,s1,-1
    35ac:	f0f5                	bnez	s1,3590 <diskfull+0x20e>
    35ae:	bf69                	j	3548 <diskfull+0x1c6>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n");
    35b0:	00004517          	auipc	a0,0x4
    35b4:	0a050513          	addi	a0,a0,160 # 7650 <malloc+0x135a>
    35b8:	00003097          	auipc	ra,0x3
    35bc:	c80080e7          	jalr	-896(ra) # 6238 <printf>
    35c0:	b5c9                	j	3482 <diskfull+0x100>

00000000000035c2 <iputtest>:
{
    35c2:	1101                	addi	sp,sp,-32
    35c4:	ec06                	sd	ra,24(sp)
    35c6:	e822                	sd	s0,16(sp)
    35c8:	e426                	sd	s1,8(sp)
    35ca:	1000                	addi	s0,sp,32
    35cc:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    35ce:	00004517          	auipc	a0,0x4
    35d2:	0b250513          	addi	a0,a0,178 # 7680 <malloc+0x138a>
    35d6:	00003097          	auipc	ra,0x3
    35da:	94a080e7          	jalr	-1718(ra) # 5f20 <mkdir>
    35de:	04054563          	bltz	a0,3628 <iputtest+0x66>
  if(chdir("iputdir") < 0){
    35e2:	00004517          	auipc	a0,0x4
    35e6:	09e50513          	addi	a0,a0,158 # 7680 <malloc+0x138a>
    35ea:	00003097          	auipc	ra,0x3
    35ee:	93e080e7          	jalr	-1730(ra) # 5f28 <chdir>
    35f2:	04054a63          	bltz	a0,3646 <iputtest+0x84>
  if(unlink("../iputdir") < 0){
    35f6:	00004517          	auipc	a0,0x4
    35fa:	0ca50513          	addi	a0,a0,202 # 76c0 <malloc+0x13ca>
    35fe:	00003097          	auipc	ra,0x3
    3602:	90a080e7          	jalr	-1782(ra) # 5f08 <unlink>
    3606:	04054f63          	bltz	a0,3664 <iputtest+0xa2>
  if(chdir("/") < 0){
    360a:	00004517          	auipc	a0,0x4
    360e:	0e650513          	addi	a0,a0,230 # 76f0 <malloc+0x13fa>
    3612:	00003097          	auipc	ra,0x3
    3616:	916080e7          	jalr	-1770(ra) # 5f28 <chdir>
    361a:	06054463          	bltz	a0,3682 <iputtest+0xc0>
}
    361e:	60e2                	ld	ra,24(sp)
    3620:	6442                	ld	s0,16(sp)
    3622:	64a2                	ld	s1,8(sp)
    3624:	6105                	addi	sp,sp,32
    3626:	8082                	ret
    printf("%s: mkdir failed\n", s);
    3628:	85a6                	mv	a1,s1
    362a:	00004517          	auipc	a0,0x4
    362e:	05e50513          	addi	a0,a0,94 # 7688 <malloc+0x1392>
    3632:	00003097          	auipc	ra,0x3
    3636:	c06080e7          	jalr	-1018(ra) # 6238 <printf>
    exit(1,0);
    363a:	4581                	li	a1,0
    363c:	4505                	li	a0,1
    363e:	00003097          	auipc	ra,0x3
    3642:	87a080e7          	jalr	-1926(ra) # 5eb8 <exit>
    printf("%s: chdir iputdir failed\n", s);
    3646:	85a6                	mv	a1,s1
    3648:	00004517          	auipc	a0,0x4
    364c:	05850513          	addi	a0,a0,88 # 76a0 <malloc+0x13aa>
    3650:	00003097          	auipc	ra,0x3
    3654:	be8080e7          	jalr	-1048(ra) # 6238 <printf>
    exit(1,0);
    3658:	4581                	li	a1,0
    365a:	4505                	li	a0,1
    365c:	00003097          	auipc	ra,0x3
    3660:	85c080e7          	jalr	-1956(ra) # 5eb8 <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    3664:	85a6                	mv	a1,s1
    3666:	00004517          	auipc	a0,0x4
    366a:	06a50513          	addi	a0,a0,106 # 76d0 <malloc+0x13da>
    366e:	00003097          	auipc	ra,0x3
    3672:	bca080e7          	jalr	-1078(ra) # 6238 <printf>
    exit(1,0);
    3676:	4581                	li	a1,0
    3678:	4505                	li	a0,1
    367a:	00003097          	auipc	ra,0x3
    367e:	83e080e7          	jalr	-1986(ra) # 5eb8 <exit>
    printf("%s: chdir / failed\n", s);
    3682:	85a6                	mv	a1,s1
    3684:	00004517          	auipc	a0,0x4
    3688:	07450513          	addi	a0,a0,116 # 76f8 <malloc+0x1402>
    368c:	00003097          	auipc	ra,0x3
    3690:	bac080e7          	jalr	-1108(ra) # 6238 <printf>
    exit(1,0);
    3694:	4581                	li	a1,0
    3696:	4505                	li	a0,1
    3698:	00003097          	auipc	ra,0x3
    369c:	820080e7          	jalr	-2016(ra) # 5eb8 <exit>

00000000000036a0 <exitiputtest>:
{
    36a0:	7179                	addi	sp,sp,-48
    36a2:	f406                	sd	ra,40(sp)
    36a4:	f022                	sd	s0,32(sp)
    36a6:	ec26                	sd	s1,24(sp)
    36a8:	1800                	addi	s0,sp,48
    36aa:	84aa                	mv	s1,a0
  pid = fork();
    36ac:	00003097          	auipc	ra,0x3
    36b0:	804080e7          	jalr	-2044(ra) # 5eb0 <fork>
  if(pid < 0){
    36b4:	04054763          	bltz	a0,3702 <exitiputtest+0x62>
  if(pid == 0){
    36b8:	e169                	bnez	a0,377a <exitiputtest+0xda>
    if(mkdir("iputdir") < 0){
    36ba:	00004517          	auipc	a0,0x4
    36be:	fc650513          	addi	a0,a0,-58 # 7680 <malloc+0x138a>
    36c2:	00003097          	auipc	ra,0x3
    36c6:	85e080e7          	jalr	-1954(ra) # 5f20 <mkdir>
    36ca:	04054b63          	bltz	a0,3720 <exitiputtest+0x80>
    if(chdir("iputdir") < 0){
    36ce:	00004517          	auipc	a0,0x4
    36d2:	fb250513          	addi	a0,a0,-78 # 7680 <malloc+0x138a>
    36d6:	00003097          	auipc	ra,0x3
    36da:	852080e7          	jalr	-1966(ra) # 5f28 <chdir>
    36de:	06054063          	bltz	a0,373e <exitiputtest+0x9e>
    if(unlink("../iputdir") < 0){
    36e2:	00004517          	auipc	a0,0x4
    36e6:	fde50513          	addi	a0,a0,-34 # 76c0 <malloc+0x13ca>
    36ea:	00003097          	auipc	ra,0x3
    36ee:	81e080e7          	jalr	-2018(ra) # 5f08 <unlink>
    36f2:	06054563          	bltz	a0,375c <exitiputtest+0xbc>
    exit(0,0);
    36f6:	4581                	li	a1,0
    36f8:	4501                	li	a0,0
    36fa:	00002097          	auipc	ra,0x2
    36fe:	7be080e7          	jalr	1982(ra) # 5eb8 <exit>
    printf("%s: fork failed\n", s);
    3702:	85a6                	mv	a1,s1
    3704:	00003517          	auipc	a0,0x3
    3708:	5bc50513          	addi	a0,a0,1468 # 6cc0 <malloc+0x9ca>
    370c:	00003097          	auipc	ra,0x3
    3710:	b2c080e7          	jalr	-1236(ra) # 6238 <printf>
    exit(1,0);
    3714:	4581                	li	a1,0
    3716:	4505                	li	a0,1
    3718:	00002097          	auipc	ra,0x2
    371c:	7a0080e7          	jalr	1952(ra) # 5eb8 <exit>
      printf("%s: mkdir failed\n", s);
    3720:	85a6                	mv	a1,s1
    3722:	00004517          	auipc	a0,0x4
    3726:	f6650513          	addi	a0,a0,-154 # 7688 <malloc+0x1392>
    372a:	00003097          	auipc	ra,0x3
    372e:	b0e080e7          	jalr	-1266(ra) # 6238 <printf>
      exit(1,0);
    3732:	4581                	li	a1,0
    3734:	4505                	li	a0,1
    3736:	00002097          	auipc	ra,0x2
    373a:	782080e7          	jalr	1922(ra) # 5eb8 <exit>
      printf("%s: child chdir failed\n", s);
    373e:	85a6                	mv	a1,s1
    3740:	00004517          	auipc	a0,0x4
    3744:	fd050513          	addi	a0,a0,-48 # 7710 <malloc+0x141a>
    3748:	00003097          	auipc	ra,0x3
    374c:	af0080e7          	jalr	-1296(ra) # 6238 <printf>
      exit(1,0);
    3750:	4581                	li	a1,0
    3752:	4505                	li	a0,1
    3754:	00002097          	auipc	ra,0x2
    3758:	764080e7          	jalr	1892(ra) # 5eb8 <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    375c:	85a6                	mv	a1,s1
    375e:	00004517          	auipc	a0,0x4
    3762:	f7250513          	addi	a0,a0,-142 # 76d0 <malloc+0x13da>
    3766:	00003097          	auipc	ra,0x3
    376a:	ad2080e7          	jalr	-1326(ra) # 6238 <printf>
      exit(1,0);
    376e:	4581                	li	a1,0
    3770:	4505                	li	a0,1
    3772:	00002097          	auipc	ra,0x2
    3776:	746080e7          	jalr	1862(ra) # 5eb8 <exit>
  wait(&xstatus,0);
    377a:	4581                	li	a1,0
    377c:	fdc40513          	addi	a0,s0,-36
    3780:	00002097          	auipc	ra,0x2
    3784:	740080e7          	jalr	1856(ra) # 5ec0 <wait>
  exit(xstatus,0);
    3788:	4581                	li	a1,0
    378a:	fdc42503          	lw	a0,-36(s0)
    378e:	00002097          	auipc	ra,0x2
    3792:	72a080e7          	jalr	1834(ra) # 5eb8 <exit>

0000000000003796 <dirtest>:
{
    3796:	1101                	addi	sp,sp,-32
    3798:	ec06                	sd	ra,24(sp)
    379a:	e822                	sd	s0,16(sp)
    379c:	e426                	sd	s1,8(sp)
    379e:	1000                	addi	s0,sp,32
    37a0:	84aa                	mv	s1,a0
  if(mkdir("dir0") < 0){
    37a2:	00004517          	auipc	a0,0x4
    37a6:	f8650513          	addi	a0,a0,-122 # 7728 <malloc+0x1432>
    37aa:	00002097          	auipc	ra,0x2
    37ae:	776080e7          	jalr	1910(ra) # 5f20 <mkdir>
    37b2:	04054563          	bltz	a0,37fc <dirtest+0x66>
  if(chdir("dir0") < 0){
    37b6:	00004517          	auipc	a0,0x4
    37ba:	f7250513          	addi	a0,a0,-142 # 7728 <malloc+0x1432>
    37be:	00002097          	auipc	ra,0x2
    37c2:	76a080e7          	jalr	1898(ra) # 5f28 <chdir>
    37c6:	04054a63          	bltz	a0,381a <dirtest+0x84>
  if(chdir("..") < 0){
    37ca:	00004517          	auipc	a0,0x4
    37ce:	f7e50513          	addi	a0,a0,-130 # 7748 <malloc+0x1452>
    37d2:	00002097          	auipc	ra,0x2
    37d6:	756080e7          	jalr	1878(ra) # 5f28 <chdir>
    37da:	04054f63          	bltz	a0,3838 <dirtest+0xa2>
  if(unlink("dir0") < 0){
    37de:	00004517          	auipc	a0,0x4
    37e2:	f4a50513          	addi	a0,a0,-182 # 7728 <malloc+0x1432>
    37e6:	00002097          	auipc	ra,0x2
    37ea:	722080e7          	jalr	1826(ra) # 5f08 <unlink>
    37ee:	06054463          	bltz	a0,3856 <dirtest+0xc0>
}
    37f2:	60e2                	ld	ra,24(sp)
    37f4:	6442                	ld	s0,16(sp)
    37f6:	64a2                	ld	s1,8(sp)
    37f8:	6105                	addi	sp,sp,32
    37fa:	8082                	ret
    printf("%s: mkdir failed\n", s);
    37fc:	85a6                	mv	a1,s1
    37fe:	00004517          	auipc	a0,0x4
    3802:	e8a50513          	addi	a0,a0,-374 # 7688 <malloc+0x1392>
    3806:	00003097          	auipc	ra,0x3
    380a:	a32080e7          	jalr	-1486(ra) # 6238 <printf>
    exit(1,0);
    380e:	4581                	li	a1,0
    3810:	4505                	li	a0,1
    3812:	00002097          	auipc	ra,0x2
    3816:	6a6080e7          	jalr	1702(ra) # 5eb8 <exit>
    printf("%s: chdir dir0 failed\n", s);
    381a:	85a6                	mv	a1,s1
    381c:	00004517          	auipc	a0,0x4
    3820:	f1450513          	addi	a0,a0,-236 # 7730 <malloc+0x143a>
    3824:	00003097          	auipc	ra,0x3
    3828:	a14080e7          	jalr	-1516(ra) # 6238 <printf>
    exit(1,0);
    382c:	4581                	li	a1,0
    382e:	4505                	li	a0,1
    3830:	00002097          	auipc	ra,0x2
    3834:	688080e7          	jalr	1672(ra) # 5eb8 <exit>
    printf("%s: chdir .. failed\n", s);
    3838:	85a6                	mv	a1,s1
    383a:	00004517          	auipc	a0,0x4
    383e:	f1650513          	addi	a0,a0,-234 # 7750 <malloc+0x145a>
    3842:	00003097          	auipc	ra,0x3
    3846:	9f6080e7          	jalr	-1546(ra) # 6238 <printf>
    exit(1,0);
    384a:	4581                	li	a1,0
    384c:	4505                	li	a0,1
    384e:	00002097          	auipc	ra,0x2
    3852:	66a080e7          	jalr	1642(ra) # 5eb8 <exit>
    printf("%s: unlink dir0 failed\n", s);
    3856:	85a6                	mv	a1,s1
    3858:	00004517          	auipc	a0,0x4
    385c:	f1050513          	addi	a0,a0,-240 # 7768 <malloc+0x1472>
    3860:	00003097          	auipc	ra,0x3
    3864:	9d8080e7          	jalr	-1576(ra) # 6238 <printf>
    exit(1,0);
    3868:	4581                	li	a1,0
    386a:	4505                	li	a0,1
    386c:	00002097          	auipc	ra,0x2
    3870:	64c080e7          	jalr	1612(ra) # 5eb8 <exit>

0000000000003874 <subdir>:
{
    3874:	1101                	addi	sp,sp,-32
    3876:	ec06                	sd	ra,24(sp)
    3878:	e822                	sd	s0,16(sp)
    387a:	e426                	sd	s1,8(sp)
    387c:	e04a                	sd	s2,0(sp)
    387e:	1000                	addi	s0,sp,32
    3880:	892a                	mv	s2,a0
  unlink("ff");
    3882:	00004517          	auipc	a0,0x4
    3886:	02e50513          	addi	a0,a0,46 # 78b0 <malloc+0x15ba>
    388a:	00002097          	auipc	ra,0x2
    388e:	67e080e7          	jalr	1662(ra) # 5f08 <unlink>
  if(mkdir("dd") != 0){
    3892:	00004517          	auipc	a0,0x4
    3896:	eee50513          	addi	a0,a0,-274 # 7780 <malloc+0x148a>
    389a:	00002097          	auipc	ra,0x2
    389e:	686080e7          	jalr	1670(ra) # 5f20 <mkdir>
    38a2:	38051663          	bnez	a0,3c2e <subdir+0x3ba>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    38a6:	20200593          	li	a1,514
    38aa:	00004517          	auipc	a0,0x4
    38ae:	ef650513          	addi	a0,a0,-266 # 77a0 <malloc+0x14aa>
    38b2:	00002097          	auipc	ra,0x2
    38b6:	646080e7          	jalr	1606(ra) # 5ef8 <open>
    38ba:	84aa                	mv	s1,a0
  if(fd < 0){
    38bc:	38054863          	bltz	a0,3c4c <subdir+0x3d8>
  write(fd, "ff", 2);
    38c0:	4609                	li	a2,2
    38c2:	00004597          	auipc	a1,0x4
    38c6:	fee58593          	addi	a1,a1,-18 # 78b0 <malloc+0x15ba>
    38ca:	00002097          	auipc	ra,0x2
    38ce:	60e080e7          	jalr	1550(ra) # 5ed8 <write>
  close(fd);
    38d2:	8526                	mv	a0,s1
    38d4:	00002097          	auipc	ra,0x2
    38d8:	60c080e7          	jalr	1548(ra) # 5ee0 <close>
  if(unlink("dd") >= 0){
    38dc:	00004517          	auipc	a0,0x4
    38e0:	ea450513          	addi	a0,a0,-348 # 7780 <malloc+0x148a>
    38e4:	00002097          	auipc	ra,0x2
    38e8:	624080e7          	jalr	1572(ra) # 5f08 <unlink>
    38ec:	36055f63          	bgez	a0,3c6a <subdir+0x3f6>
  if(mkdir("/dd/dd") != 0){
    38f0:	00004517          	auipc	a0,0x4
    38f4:	f0850513          	addi	a0,a0,-248 # 77f8 <malloc+0x1502>
    38f8:	00002097          	auipc	ra,0x2
    38fc:	628080e7          	jalr	1576(ra) # 5f20 <mkdir>
    3900:	38051463          	bnez	a0,3c88 <subdir+0x414>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    3904:	20200593          	li	a1,514
    3908:	00004517          	auipc	a0,0x4
    390c:	f1850513          	addi	a0,a0,-232 # 7820 <malloc+0x152a>
    3910:	00002097          	auipc	ra,0x2
    3914:	5e8080e7          	jalr	1512(ra) # 5ef8 <open>
    3918:	84aa                	mv	s1,a0
  if(fd < 0){
    391a:	38054663          	bltz	a0,3ca6 <subdir+0x432>
  write(fd, "FF", 2);
    391e:	4609                	li	a2,2
    3920:	00004597          	auipc	a1,0x4
    3924:	f3058593          	addi	a1,a1,-208 # 7850 <malloc+0x155a>
    3928:	00002097          	auipc	ra,0x2
    392c:	5b0080e7          	jalr	1456(ra) # 5ed8 <write>
  close(fd);
    3930:	8526                	mv	a0,s1
    3932:	00002097          	auipc	ra,0x2
    3936:	5ae080e7          	jalr	1454(ra) # 5ee0 <close>
  fd = open("dd/dd/../ff", 0);
    393a:	4581                	li	a1,0
    393c:	00004517          	auipc	a0,0x4
    3940:	f1c50513          	addi	a0,a0,-228 # 7858 <malloc+0x1562>
    3944:	00002097          	auipc	ra,0x2
    3948:	5b4080e7          	jalr	1460(ra) # 5ef8 <open>
    394c:	84aa                	mv	s1,a0
  if(fd < 0){
    394e:	36054b63          	bltz	a0,3cc4 <subdir+0x450>
  cc = read(fd, buf, sizeof(buf));
    3952:	660d                	lui	a2,0x3
    3954:	00009597          	auipc	a1,0x9
    3958:	32458593          	addi	a1,a1,804 # cc78 <buf>
    395c:	00002097          	auipc	ra,0x2
    3960:	574080e7          	jalr	1396(ra) # 5ed0 <read>
  if(cc != 2 || buf[0] != 'f'){
    3964:	4789                	li	a5,2
    3966:	36f51e63          	bne	a0,a5,3ce2 <subdir+0x46e>
    396a:	00009717          	auipc	a4,0x9
    396e:	30e74703          	lbu	a4,782(a4) # cc78 <buf>
    3972:	06600793          	li	a5,102
    3976:	36f71663          	bne	a4,a5,3ce2 <subdir+0x46e>
  close(fd);
    397a:	8526                	mv	a0,s1
    397c:	00002097          	auipc	ra,0x2
    3980:	564080e7          	jalr	1380(ra) # 5ee0 <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    3984:	00004597          	auipc	a1,0x4
    3988:	f2458593          	addi	a1,a1,-220 # 78a8 <malloc+0x15b2>
    398c:	00004517          	auipc	a0,0x4
    3990:	e9450513          	addi	a0,a0,-364 # 7820 <malloc+0x152a>
    3994:	00002097          	auipc	ra,0x2
    3998:	584080e7          	jalr	1412(ra) # 5f18 <link>
    399c:	36051263          	bnez	a0,3d00 <subdir+0x48c>
  if(unlink("dd/dd/ff") != 0){
    39a0:	00004517          	auipc	a0,0x4
    39a4:	e8050513          	addi	a0,a0,-384 # 7820 <malloc+0x152a>
    39a8:	00002097          	auipc	ra,0x2
    39ac:	560080e7          	jalr	1376(ra) # 5f08 <unlink>
    39b0:	36051763          	bnez	a0,3d1e <subdir+0x4aa>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    39b4:	4581                	li	a1,0
    39b6:	00004517          	auipc	a0,0x4
    39ba:	e6a50513          	addi	a0,a0,-406 # 7820 <malloc+0x152a>
    39be:	00002097          	auipc	ra,0x2
    39c2:	53a080e7          	jalr	1338(ra) # 5ef8 <open>
    39c6:	36055b63          	bgez	a0,3d3c <subdir+0x4c8>
  if(chdir("dd") != 0){
    39ca:	00004517          	auipc	a0,0x4
    39ce:	db650513          	addi	a0,a0,-586 # 7780 <malloc+0x148a>
    39d2:	00002097          	auipc	ra,0x2
    39d6:	556080e7          	jalr	1366(ra) # 5f28 <chdir>
    39da:	38051063          	bnez	a0,3d5a <subdir+0x4e6>
  if(chdir("dd/../../dd") != 0){
    39de:	00004517          	auipc	a0,0x4
    39e2:	f6250513          	addi	a0,a0,-158 # 7940 <malloc+0x164a>
    39e6:	00002097          	auipc	ra,0x2
    39ea:	542080e7          	jalr	1346(ra) # 5f28 <chdir>
    39ee:	38051563          	bnez	a0,3d78 <subdir+0x504>
  if(chdir("dd/../../../dd") != 0){
    39f2:	00004517          	auipc	a0,0x4
    39f6:	f7e50513          	addi	a0,a0,-130 # 7970 <malloc+0x167a>
    39fa:	00002097          	auipc	ra,0x2
    39fe:	52e080e7          	jalr	1326(ra) # 5f28 <chdir>
    3a02:	38051a63          	bnez	a0,3d96 <subdir+0x522>
  if(chdir("./..") != 0){
    3a06:	00004517          	auipc	a0,0x4
    3a0a:	f9a50513          	addi	a0,a0,-102 # 79a0 <malloc+0x16aa>
    3a0e:	00002097          	auipc	ra,0x2
    3a12:	51a080e7          	jalr	1306(ra) # 5f28 <chdir>
    3a16:	38051f63          	bnez	a0,3db4 <subdir+0x540>
  fd = open("dd/dd/ffff", 0);
    3a1a:	4581                	li	a1,0
    3a1c:	00004517          	auipc	a0,0x4
    3a20:	e8c50513          	addi	a0,a0,-372 # 78a8 <malloc+0x15b2>
    3a24:	00002097          	auipc	ra,0x2
    3a28:	4d4080e7          	jalr	1236(ra) # 5ef8 <open>
    3a2c:	84aa                	mv	s1,a0
  if(fd < 0){
    3a2e:	3a054263          	bltz	a0,3dd2 <subdir+0x55e>
  if(read(fd, buf, sizeof(buf)) != 2){
    3a32:	660d                	lui	a2,0x3
    3a34:	00009597          	auipc	a1,0x9
    3a38:	24458593          	addi	a1,a1,580 # cc78 <buf>
    3a3c:	00002097          	auipc	ra,0x2
    3a40:	494080e7          	jalr	1172(ra) # 5ed0 <read>
    3a44:	4789                	li	a5,2
    3a46:	3af51563          	bne	a0,a5,3df0 <subdir+0x57c>
  close(fd);
    3a4a:	8526                	mv	a0,s1
    3a4c:	00002097          	auipc	ra,0x2
    3a50:	494080e7          	jalr	1172(ra) # 5ee0 <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    3a54:	4581                	li	a1,0
    3a56:	00004517          	auipc	a0,0x4
    3a5a:	dca50513          	addi	a0,a0,-566 # 7820 <malloc+0x152a>
    3a5e:	00002097          	auipc	ra,0x2
    3a62:	49a080e7          	jalr	1178(ra) # 5ef8 <open>
    3a66:	3a055463          	bgez	a0,3e0e <subdir+0x59a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    3a6a:	20200593          	li	a1,514
    3a6e:	00004517          	auipc	a0,0x4
    3a72:	fc250513          	addi	a0,a0,-62 # 7a30 <malloc+0x173a>
    3a76:	00002097          	auipc	ra,0x2
    3a7a:	482080e7          	jalr	1154(ra) # 5ef8 <open>
    3a7e:	3a055763          	bgez	a0,3e2c <subdir+0x5b8>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    3a82:	20200593          	li	a1,514
    3a86:	00004517          	auipc	a0,0x4
    3a8a:	fda50513          	addi	a0,a0,-38 # 7a60 <malloc+0x176a>
    3a8e:	00002097          	auipc	ra,0x2
    3a92:	46a080e7          	jalr	1130(ra) # 5ef8 <open>
    3a96:	3a055a63          	bgez	a0,3e4a <subdir+0x5d6>
  if(open("dd", O_CREATE) >= 0){
    3a9a:	20000593          	li	a1,512
    3a9e:	00004517          	auipc	a0,0x4
    3aa2:	ce250513          	addi	a0,a0,-798 # 7780 <malloc+0x148a>
    3aa6:	00002097          	auipc	ra,0x2
    3aaa:	452080e7          	jalr	1106(ra) # 5ef8 <open>
    3aae:	3a055d63          	bgez	a0,3e68 <subdir+0x5f4>
  if(open("dd", O_RDWR) >= 0){
    3ab2:	4589                	li	a1,2
    3ab4:	00004517          	auipc	a0,0x4
    3ab8:	ccc50513          	addi	a0,a0,-820 # 7780 <malloc+0x148a>
    3abc:	00002097          	auipc	ra,0x2
    3ac0:	43c080e7          	jalr	1084(ra) # 5ef8 <open>
    3ac4:	3c055163          	bgez	a0,3e86 <subdir+0x612>
  if(open("dd", O_WRONLY) >= 0){
    3ac8:	4585                	li	a1,1
    3aca:	00004517          	auipc	a0,0x4
    3ace:	cb650513          	addi	a0,a0,-842 # 7780 <malloc+0x148a>
    3ad2:	00002097          	auipc	ra,0x2
    3ad6:	426080e7          	jalr	1062(ra) # 5ef8 <open>
    3ada:	3c055563          	bgez	a0,3ea4 <subdir+0x630>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    3ade:	00004597          	auipc	a1,0x4
    3ae2:	01258593          	addi	a1,a1,18 # 7af0 <malloc+0x17fa>
    3ae6:	00004517          	auipc	a0,0x4
    3aea:	f4a50513          	addi	a0,a0,-182 # 7a30 <malloc+0x173a>
    3aee:	00002097          	auipc	ra,0x2
    3af2:	42a080e7          	jalr	1066(ra) # 5f18 <link>
    3af6:	3c050663          	beqz	a0,3ec2 <subdir+0x64e>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    3afa:	00004597          	auipc	a1,0x4
    3afe:	ff658593          	addi	a1,a1,-10 # 7af0 <malloc+0x17fa>
    3b02:	00004517          	auipc	a0,0x4
    3b06:	f5e50513          	addi	a0,a0,-162 # 7a60 <malloc+0x176a>
    3b0a:	00002097          	auipc	ra,0x2
    3b0e:	40e080e7          	jalr	1038(ra) # 5f18 <link>
    3b12:	3c050763          	beqz	a0,3ee0 <subdir+0x66c>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    3b16:	00004597          	auipc	a1,0x4
    3b1a:	d9258593          	addi	a1,a1,-622 # 78a8 <malloc+0x15b2>
    3b1e:	00004517          	auipc	a0,0x4
    3b22:	c8250513          	addi	a0,a0,-894 # 77a0 <malloc+0x14aa>
    3b26:	00002097          	auipc	ra,0x2
    3b2a:	3f2080e7          	jalr	1010(ra) # 5f18 <link>
    3b2e:	3c050863          	beqz	a0,3efe <subdir+0x68a>
  if(mkdir("dd/ff/ff") == 0){
    3b32:	00004517          	auipc	a0,0x4
    3b36:	efe50513          	addi	a0,a0,-258 # 7a30 <malloc+0x173a>
    3b3a:	00002097          	auipc	ra,0x2
    3b3e:	3e6080e7          	jalr	998(ra) # 5f20 <mkdir>
    3b42:	3c050d63          	beqz	a0,3f1c <subdir+0x6a8>
  if(mkdir("dd/xx/ff") == 0){
    3b46:	00004517          	auipc	a0,0x4
    3b4a:	f1a50513          	addi	a0,a0,-230 # 7a60 <malloc+0x176a>
    3b4e:	00002097          	auipc	ra,0x2
    3b52:	3d2080e7          	jalr	978(ra) # 5f20 <mkdir>
    3b56:	3e050263          	beqz	a0,3f3a <subdir+0x6c6>
  if(mkdir("dd/dd/ffff") == 0){
    3b5a:	00004517          	auipc	a0,0x4
    3b5e:	d4e50513          	addi	a0,a0,-690 # 78a8 <malloc+0x15b2>
    3b62:	00002097          	auipc	ra,0x2
    3b66:	3be080e7          	jalr	958(ra) # 5f20 <mkdir>
    3b6a:	3e050763          	beqz	a0,3f58 <subdir+0x6e4>
  if(unlink("dd/xx/ff") == 0){
    3b6e:	00004517          	auipc	a0,0x4
    3b72:	ef250513          	addi	a0,a0,-270 # 7a60 <malloc+0x176a>
    3b76:	00002097          	auipc	ra,0x2
    3b7a:	392080e7          	jalr	914(ra) # 5f08 <unlink>
    3b7e:	3e050c63          	beqz	a0,3f76 <subdir+0x702>
  if(unlink("dd/ff/ff") == 0){
    3b82:	00004517          	auipc	a0,0x4
    3b86:	eae50513          	addi	a0,a0,-338 # 7a30 <malloc+0x173a>
    3b8a:	00002097          	auipc	ra,0x2
    3b8e:	37e080e7          	jalr	894(ra) # 5f08 <unlink>
    3b92:	40050163          	beqz	a0,3f94 <subdir+0x720>
  if(chdir("dd/ff") == 0){
    3b96:	00004517          	auipc	a0,0x4
    3b9a:	c0a50513          	addi	a0,a0,-1014 # 77a0 <malloc+0x14aa>
    3b9e:	00002097          	auipc	ra,0x2
    3ba2:	38a080e7          	jalr	906(ra) # 5f28 <chdir>
    3ba6:	40050663          	beqz	a0,3fb2 <subdir+0x73e>
  if(chdir("dd/xx") == 0){
    3baa:	00004517          	auipc	a0,0x4
    3bae:	09650513          	addi	a0,a0,150 # 7c40 <malloc+0x194a>
    3bb2:	00002097          	auipc	ra,0x2
    3bb6:	376080e7          	jalr	886(ra) # 5f28 <chdir>
    3bba:	40050b63          	beqz	a0,3fd0 <subdir+0x75c>
  if(unlink("dd/dd/ffff") != 0){
    3bbe:	00004517          	auipc	a0,0x4
    3bc2:	cea50513          	addi	a0,a0,-790 # 78a8 <malloc+0x15b2>
    3bc6:	00002097          	auipc	ra,0x2
    3bca:	342080e7          	jalr	834(ra) # 5f08 <unlink>
    3bce:	42051063          	bnez	a0,3fee <subdir+0x77a>
  if(unlink("dd/ff") != 0){
    3bd2:	00004517          	auipc	a0,0x4
    3bd6:	bce50513          	addi	a0,a0,-1074 # 77a0 <malloc+0x14aa>
    3bda:	00002097          	auipc	ra,0x2
    3bde:	32e080e7          	jalr	814(ra) # 5f08 <unlink>
    3be2:	42051563          	bnez	a0,400c <subdir+0x798>
  if(unlink("dd") == 0){
    3be6:	00004517          	auipc	a0,0x4
    3bea:	b9a50513          	addi	a0,a0,-1126 # 7780 <malloc+0x148a>
    3bee:	00002097          	auipc	ra,0x2
    3bf2:	31a080e7          	jalr	794(ra) # 5f08 <unlink>
    3bf6:	42050a63          	beqz	a0,402a <subdir+0x7b6>
  if(unlink("dd/dd") < 0){
    3bfa:	00004517          	auipc	a0,0x4
    3bfe:	0b650513          	addi	a0,a0,182 # 7cb0 <malloc+0x19ba>
    3c02:	00002097          	auipc	ra,0x2
    3c06:	306080e7          	jalr	774(ra) # 5f08 <unlink>
    3c0a:	42054f63          	bltz	a0,4048 <subdir+0x7d4>
  if(unlink("dd") < 0){
    3c0e:	00004517          	auipc	a0,0x4
    3c12:	b7250513          	addi	a0,a0,-1166 # 7780 <malloc+0x148a>
    3c16:	00002097          	auipc	ra,0x2
    3c1a:	2f2080e7          	jalr	754(ra) # 5f08 <unlink>
    3c1e:	44054463          	bltz	a0,4066 <subdir+0x7f2>
}
    3c22:	60e2                	ld	ra,24(sp)
    3c24:	6442                	ld	s0,16(sp)
    3c26:	64a2                	ld	s1,8(sp)
    3c28:	6902                	ld	s2,0(sp)
    3c2a:	6105                	addi	sp,sp,32
    3c2c:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    3c2e:	85ca                	mv	a1,s2
    3c30:	00004517          	auipc	a0,0x4
    3c34:	b5850513          	addi	a0,a0,-1192 # 7788 <malloc+0x1492>
    3c38:	00002097          	auipc	ra,0x2
    3c3c:	600080e7          	jalr	1536(ra) # 6238 <printf>
    exit(1,0);
    3c40:	4581                	li	a1,0
    3c42:	4505                	li	a0,1
    3c44:	00002097          	auipc	ra,0x2
    3c48:	274080e7          	jalr	628(ra) # 5eb8 <exit>
    printf("%s: create dd/ff failed\n", s);
    3c4c:	85ca                	mv	a1,s2
    3c4e:	00004517          	auipc	a0,0x4
    3c52:	b5a50513          	addi	a0,a0,-1190 # 77a8 <malloc+0x14b2>
    3c56:	00002097          	auipc	ra,0x2
    3c5a:	5e2080e7          	jalr	1506(ra) # 6238 <printf>
    exit(1,0);
    3c5e:	4581                	li	a1,0
    3c60:	4505                	li	a0,1
    3c62:	00002097          	auipc	ra,0x2
    3c66:	256080e7          	jalr	598(ra) # 5eb8 <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    3c6a:	85ca                	mv	a1,s2
    3c6c:	00004517          	auipc	a0,0x4
    3c70:	b5c50513          	addi	a0,a0,-1188 # 77c8 <malloc+0x14d2>
    3c74:	00002097          	auipc	ra,0x2
    3c78:	5c4080e7          	jalr	1476(ra) # 6238 <printf>
    exit(1,0);
    3c7c:	4581                	li	a1,0
    3c7e:	4505                	li	a0,1
    3c80:	00002097          	auipc	ra,0x2
    3c84:	238080e7          	jalr	568(ra) # 5eb8 <exit>
    printf("subdir mkdir dd/dd failed\n", s);
    3c88:	85ca                	mv	a1,s2
    3c8a:	00004517          	auipc	a0,0x4
    3c8e:	b7650513          	addi	a0,a0,-1162 # 7800 <malloc+0x150a>
    3c92:	00002097          	auipc	ra,0x2
    3c96:	5a6080e7          	jalr	1446(ra) # 6238 <printf>
    exit(1,0);
    3c9a:	4581                	li	a1,0
    3c9c:	4505                	li	a0,1
    3c9e:	00002097          	auipc	ra,0x2
    3ca2:	21a080e7          	jalr	538(ra) # 5eb8 <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    3ca6:	85ca                	mv	a1,s2
    3ca8:	00004517          	auipc	a0,0x4
    3cac:	b8850513          	addi	a0,a0,-1144 # 7830 <malloc+0x153a>
    3cb0:	00002097          	auipc	ra,0x2
    3cb4:	588080e7          	jalr	1416(ra) # 6238 <printf>
    exit(1,0);
    3cb8:	4581                	li	a1,0
    3cba:	4505                	li	a0,1
    3cbc:	00002097          	auipc	ra,0x2
    3cc0:	1fc080e7          	jalr	508(ra) # 5eb8 <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    3cc4:	85ca                	mv	a1,s2
    3cc6:	00004517          	auipc	a0,0x4
    3cca:	ba250513          	addi	a0,a0,-1118 # 7868 <malloc+0x1572>
    3cce:	00002097          	auipc	ra,0x2
    3cd2:	56a080e7          	jalr	1386(ra) # 6238 <printf>
    exit(1,0);
    3cd6:	4581                	li	a1,0
    3cd8:	4505                	li	a0,1
    3cda:	00002097          	auipc	ra,0x2
    3cde:	1de080e7          	jalr	478(ra) # 5eb8 <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    3ce2:	85ca                	mv	a1,s2
    3ce4:	00004517          	auipc	a0,0x4
    3ce8:	ba450513          	addi	a0,a0,-1116 # 7888 <malloc+0x1592>
    3cec:	00002097          	auipc	ra,0x2
    3cf0:	54c080e7          	jalr	1356(ra) # 6238 <printf>
    exit(1,0);
    3cf4:	4581                	li	a1,0
    3cf6:	4505                	li	a0,1
    3cf8:	00002097          	auipc	ra,0x2
    3cfc:	1c0080e7          	jalr	448(ra) # 5eb8 <exit>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    3d00:	85ca                	mv	a1,s2
    3d02:	00004517          	auipc	a0,0x4
    3d06:	bb650513          	addi	a0,a0,-1098 # 78b8 <malloc+0x15c2>
    3d0a:	00002097          	auipc	ra,0x2
    3d0e:	52e080e7          	jalr	1326(ra) # 6238 <printf>
    exit(1,0);
    3d12:	4581                	li	a1,0
    3d14:	4505                	li	a0,1
    3d16:	00002097          	auipc	ra,0x2
    3d1a:	1a2080e7          	jalr	418(ra) # 5eb8 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3d1e:	85ca                	mv	a1,s2
    3d20:	00004517          	auipc	a0,0x4
    3d24:	bc050513          	addi	a0,a0,-1088 # 78e0 <malloc+0x15ea>
    3d28:	00002097          	auipc	ra,0x2
    3d2c:	510080e7          	jalr	1296(ra) # 6238 <printf>
    exit(1,0);
    3d30:	4581                	li	a1,0
    3d32:	4505                	li	a0,1
    3d34:	00002097          	auipc	ra,0x2
    3d38:	184080e7          	jalr	388(ra) # 5eb8 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    3d3c:	85ca                	mv	a1,s2
    3d3e:	00004517          	auipc	a0,0x4
    3d42:	bc250513          	addi	a0,a0,-1086 # 7900 <malloc+0x160a>
    3d46:	00002097          	auipc	ra,0x2
    3d4a:	4f2080e7          	jalr	1266(ra) # 6238 <printf>
    exit(1,0);
    3d4e:	4581                	li	a1,0
    3d50:	4505                	li	a0,1
    3d52:	00002097          	auipc	ra,0x2
    3d56:	166080e7          	jalr	358(ra) # 5eb8 <exit>
    printf("%s: chdir dd failed\n", s);
    3d5a:	85ca                	mv	a1,s2
    3d5c:	00004517          	auipc	a0,0x4
    3d60:	bcc50513          	addi	a0,a0,-1076 # 7928 <malloc+0x1632>
    3d64:	00002097          	auipc	ra,0x2
    3d68:	4d4080e7          	jalr	1236(ra) # 6238 <printf>
    exit(1,0);
    3d6c:	4581                	li	a1,0
    3d6e:	4505                	li	a0,1
    3d70:	00002097          	auipc	ra,0x2
    3d74:	148080e7          	jalr	328(ra) # 5eb8 <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    3d78:	85ca                	mv	a1,s2
    3d7a:	00004517          	auipc	a0,0x4
    3d7e:	bd650513          	addi	a0,a0,-1066 # 7950 <malloc+0x165a>
    3d82:	00002097          	auipc	ra,0x2
    3d86:	4b6080e7          	jalr	1206(ra) # 6238 <printf>
    exit(1,0);
    3d8a:	4581                	li	a1,0
    3d8c:	4505                	li	a0,1
    3d8e:	00002097          	auipc	ra,0x2
    3d92:	12a080e7          	jalr	298(ra) # 5eb8 <exit>
    printf("chdir dd/../../dd failed\n", s);
    3d96:	85ca                	mv	a1,s2
    3d98:	00004517          	auipc	a0,0x4
    3d9c:	be850513          	addi	a0,a0,-1048 # 7980 <malloc+0x168a>
    3da0:	00002097          	auipc	ra,0x2
    3da4:	498080e7          	jalr	1176(ra) # 6238 <printf>
    exit(1,0);
    3da8:	4581                	li	a1,0
    3daa:	4505                	li	a0,1
    3dac:	00002097          	auipc	ra,0x2
    3db0:	10c080e7          	jalr	268(ra) # 5eb8 <exit>
    printf("%s: chdir ./.. failed\n", s);
    3db4:	85ca                	mv	a1,s2
    3db6:	00004517          	auipc	a0,0x4
    3dba:	bf250513          	addi	a0,a0,-1038 # 79a8 <malloc+0x16b2>
    3dbe:	00002097          	auipc	ra,0x2
    3dc2:	47a080e7          	jalr	1146(ra) # 6238 <printf>
    exit(1,0);
    3dc6:	4581                	li	a1,0
    3dc8:	4505                	li	a0,1
    3dca:	00002097          	auipc	ra,0x2
    3dce:	0ee080e7          	jalr	238(ra) # 5eb8 <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    3dd2:	85ca                	mv	a1,s2
    3dd4:	00004517          	auipc	a0,0x4
    3dd8:	bec50513          	addi	a0,a0,-1044 # 79c0 <malloc+0x16ca>
    3ddc:	00002097          	auipc	ra,0x2
    3de0:	45c080e7          	jalr	1116(ra) # 6238 <printf>
    exit(1,0);
    3de4:	4581                	li	a1,0
    3de6:	4505                	li	a0,1
    3de8:	00002097          	auipc	ra,0x2
    3dec:	0d0080e7          	jalr	208(ra) # 5eb8 <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    3df0:	85ca                	mv	a1,s2
    3df2:	00004517          	auipc	a0,0x4
    3df6:	bee50513          	addi	a0,a0,-1042 # 79e0 <malloc+0x16ea>
    3dfa:	00002097          	auipc	ra,0x2
    3dfe:	43e080e7          	jalr	1086(ra) # 6238 <printf>
    exit(1,0);
    3e02:	4581                	li	a1,0
    3e04:	4505                	li	a0,1
    3e06:	00002097          	auipc	ra,0x2
    3e0a:	0b2080e7          	jalr	178(ra) # 5eb8 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    3e0e:	85ca                	mv	a1,s2
    3e10:	00004517          	auipc	a0,0x4
    3e14:	bf050513          	addi	a0,a0,-1040 # 7a00 <malloc+0x170a>
    3e18:	00002097          	auipc	ra,0x2
    3e1c:	420080e7          	jalr	1056(ra) # 6238 <printf>
    exit(1,0);
    3e20:	4581                	li	a1,0
    3e22:	4505                	li	a0,1
    3e24:	00002097          	auipc	ra,0x2
    3e28:	094080e7          	jalr	148(ra) # 5eb8 <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    3e2c:	85ca                	mv	a1,s2
    3e2e:	00004517          	auipc	a0,0x4
    3e32:	c1250513          	addi	a0,a0,-1006 # 7a40 <malloc+0x174a>
    3e36:	00002097          	auipc	ra,0x2
    3e3a:	402080e7          	jalr	1026(ra) # 6238 <printf>
    exit(1,0);
    3e3e:	4581                	li	a1,0
    3e40:	4505                	li	a0,1
    3e42:	00002097          	auipc	ra,0x2
    3e46:	076080e7          	jalr	118(ra) # 5eb8 <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    3e4a:	85ca                	mv	a1,s2
    3e4c:	00004517          	auipc	a0,0x4
    3e50:	c2450513          	addi	a0,a0,-988 # 7a70 <malloc+0x177a>
    3e54:	00002097          	auipc	ra,0x2
    3e58:	3e4080e7          	jalr	996(ra) # 6238 <printf>
    exit(1,0);
    3e5c:	4581                	li	a1,0
    3e5e:	4505                	li	a0,1
    3e60:	00002097          	auipc	ra,0x2
    3e64:	058080e7          	jalr	88(ra) # 5eb8 <exit>
    printf("%s: create dd succeeded!\n", s);
    3e68:	85ca                	mv	a1,s2
    3e6a:	00004517          	auipc	a0,0x4
    3e6e:	c2650513          	addi	a0,a0,-986 # 7a90 <malloc+0x179a>
    3e72:	00002097          	auipc	ra,0x2
    3e76:	3c6080e7          	jalr	966(ra) # 6238 <printf>
    exit(1,0);
    3e7a:	4581                	li	a1,0
    3e7c:	4505                	li	a0,1
    3e7e:	00002097          	auipc	ra,0x2
    3e82:	03a080e7          	jalr	58(ra) # 5eb8 <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    3e86:	85ca                	mv	a1,s2
    3e88:	00004517          	auipc	a0,0x4
    3e8c:	c2850513          	addi	a0,a0,-984 # 7ab0 <malloc+0x17ba>
    3e90:	00002097          	auipc	ra,0x2
    3e94:	3a8080e7          	jalr	936(ra) # 6238 <printf>
    exit(1,0);
    3e98:	4581                	li	a1,0
    3e9a:	4505                	li	a0,1
    3e9c:	00002097          	auipc	ra,0x2
    3ea0:	01c080e7          	jalr	28(ra) # 5eb8 <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    3ea4:	85ca                	mv	a1,s2
    3ea6:	00004517          	auipc	a0,0x4
    3eaa:	c2a50513          	addi	a0,a0,-982 # 7ad0 <malloc+0x17da>
    3eae:	00002097          	auipc	ra,0x2
    3eb2:	38a080e7          	jalr	906(ra) # 6238 <printf>
    exit(1,0);
    3eb6:	4581                	li	a1,0
    3eb8:	4505                	li	a0,1
    3eba:	00002097          	auipc	ra,0x2
    3ebe:	ffe080e7          	jalr	-2(ra) # 5eb8 <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    3ec2:	85ca                	mv	a1,s2
    3ec4:	00004517          	auipc	a0,0x4
    3ec8:	c3c50513          	addi	a0,a0,-964 # 7b00 <malloc+0x180a>
    3ecc:	00002097          	auipc	ra,0x2
    3ed0:	36c080e7          	jalr	876(ra) # 6238 <printf>
    exit(1,0);
    3ed4:	4581                	li	a1,0
    3ed6:	4505                	li	a0,1
    3ed8:	00002097          	auipc	ra,0x2
    3edc:	fe0080e7          	jalr	-32(ra) # 5eb8 <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    3ee0:	85ca                	mv	a1,s2
    3ee2:	00004517          	auipc	a0,0x4
    3ee6:	c4650513          	addi	a0,a0,-954 # 7b28 <malloc+0x1832>
    3eea:	00002097          	auipc	ra,0x2
    3eee:	34e080e7          	jalr	846(ra) # 6238 <printf>
    exit(1,0);
    3ef2:	4581                	li	a1,0
    3ef4:	4505                	li	a0,1
    3ef6:	00002097          	auipc	ra,0x2
    3efa:	fc2080e7          	jalr	-62(ra) # 5eb8 <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    3efe:	85ca                	mv	a1,s2
    3f00:	00004517          	auipc	a0,0x4
    3f04:	c5050513          	addi	a0,a0,-944 # 7b50 <malloc+0x185a>
    3f08:	00002097          	auipc	ra,0x2
    3f0c:	330080e7          	jalr	816(ra) # 6238 <printf>
    exit(1,0);
    3f10:	4581                	li	a1,0
    3f12:	4505                	li	a0,1
    3f14:	00002097          	auipc	ra,0x2
    3f18:	fa4080e7          	jalr	-92(ra) # 5eb8 <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    3f1c:	85ca                	mv	a1,s2
    3f1e:	00004517          	auipc	a0,0x4
    3f22:	c5a50513          	addi	a0,a0,-934 # 7b78 <malloc+0x1882>
    3f26:	00002097          	auipc	ra,0x2
    3f2a:	312080e7          	jalr	786(ra) # 6238 <printf>
    exit(1,0);
    3f2e:	4581                	li	a1,0
    3f30:	4505                	li	a0,1
    3f32:	00002097          	auipc	ra,0x2
    3f36:	f86080e7          	jalr	-122(ra) # 5eb8 <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    3f3a:	85ca                	mv	a1,s2
    3f3c:	00004517          	auipc	a0,0x4
    3f40:	c5c50513          	addi	a0,a0,-932 # 7b98 <malloc+0x18a2>
    3f44:	00002097          	auipc	ra,0x2
    3f48:	2f4080e7          	jalr	756(ra) # 6238 <printf>
    exit(1,0);
    3f4c:	4581                	li	a1,0
    3f4e:	4505                	li	a0,1
    3f50:	00002097          	auipc	ra,0x2
    3f54:	f68080e7          	jalr	-152(ra) # 5eb8 <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    3f58:	85ca                	mv	a1,s2
    3f5a:	00004517          	auipc	a0,0x4
    3f5e:	c5e50513          	addi	a0,a0,-930 # 7bb8 <malloc+0x18c2>
    3f62:	00002097          	auipc	ra,0x2
    3f66:	2d6080e7          	jalr	726(ra) # 6238 <printf>
    exit(1,0);
    3f6a:	4581                	li	a1,0
    3f6c:	4505                	li	a0,1
    3f6e:	00002097          	auipc	ra,0x2
    3f72:	f4a080e7          	jalr	-182(ra) # 5eb8 <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    3f76:	85ca                	mv	a1,s2
    3f78:	00004517          	auipc	a0,0x4
    3f7c:	c6850513          	addi	a0,a0,-920 # 7be0 <malloc+0x18ea>
    3f80:	00002097          	auipc	ra,0x2
    3f84:	2b8080e7          	jalr	696(ra) # 6238 <printf>
    exit(1,0);
    3f88:	4581                	li	a1,0
    3f8a:	4505                	li	a0,1
    3f8c:	00002097          	auipc	ra,0x2
    3f90:	f2c080e7          	jalr	-212(ra) # 5eb8 <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    3f94:	85ca                	mv	a1,s2
    3f96:	00004517          	auipc	a0,0x4
    3f9a:	c6a50513          	addi	a0,a0,-918 # 7c00 <malloc+0x190a>
    3f9e:	00002097          	auipc	ra,0x2
    3fa2:	29a080e7          	jalr	666(ra) # 6238 <printf>
    exit(1,0);
    3fa6:	4581                	li	a1,0
    3fa8:	4505                	li	a0,1
    3faa:	00002097          	auipc	ra,0x2
    3fae:	f0e080e7          	jalr	-242(ra) # 5eb8 <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    3fb2:	85ca                	mv	a1,s2
    3fb4:	00004517          	auipc	a0,0x4
    3fb8:	c6c50513          	addi	a0,a0,-916 # 7c20 <malloc+0x192a>
    3fbc:	00002097          	auipc	ra,0x2
    3fc0:	27c080e7          	jalr	636(ra) # 6238 <printf>
    exit(1,0);
    3fc4:	4581                	li	a1,0
    3fc6:	4505                	li	a0,1
    3fc8:	00002097          	auipc	ra,0x2
    3fcc:	ef0080e7          	jalr	-272(ra) # 5eb8 <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    3fd0:	85ca                	mv	a1,s2
    3fd2:	00004517          	auipc	a0,0x4
    3fd6:	c7650513          	addi	a0,a0,-906 # 7c48 <malloc+0x1952>
    3fda:	00002097          	auipc	ra,0x2
    3fde:	25e080e7          	jalr	606(ra) # 6238 <printf>
    exit(1,0);
    3fe2:	4581                	li	a1,0
    3fe4:	4505                	li	a0,1
    3fe6:	00002097          	auipc	ra,0x2
    3fea:	ed2080e7          	jalr	-302(ra) # 5eb8 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3fee:	85ca                	mv	a1,s2
    3ff0:	00004517          	auipc	a0,0x4
    3ff4:	8f050513          	addi	a0,a0,-1808 # 78e0 <malloc+0x15ea>
    3ff8:	00002097          	auipc	ra,0x2
    3ffc:	240080e7          	jalr	576(ra) # 6238 <printf>
    exit(1,0);
    4000:	4581                	li	a1,0
    4002:	4505                	li	a0,1
    4004:	00002097          	auipc	ra,0x2
    4008:	eb4080e7          	jalr	-332(ra) # 5eb8 <exit>
    printf("%s: unlink dd/ff failed\n", s);
    400c:	85ca                	mv	a1,s2
    400e:	00004517          	auipc	a0,0x4
    4012:	c5a50513          	addi	a0,a0,-934 # 7c68 <malloc+0x1972>
    4016:	00002097          	auipc	ra,0x2
    401a:	222080e7          	jalr	546(ra) # 6238 <printf>
    exit(1,0);
    401e:	4581                	li	a1,0
    4020:	4505                	li	a0,1
    4022:	00002097          	auipc	ra,0x2
    4026:	e96080e7          	jalr	-362(ra) # 5eb8 <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    402a:	85ca                	mv	a1,s2
    402c:	00004517          	auipc	a0,0x4
    4030:	c5c50513          	addi	a0,a0,-932 # 7c88 <malloc+0x1992>
    4034:	00002097          	auipc	ra,0x2
    4038:	204080e7          	jalr	516(ra) # 6238 <printf>
    exit(1,0);
    403c:	4581                	li	a1,0
    403e:	4505                	li	a0,1
    4040:	00002097          	auipc	ra,0x2
    4044:	e78080e7          	jalr	-392(ra) # 5eb8 <exit>
    printf("%s: unlink dd/dd failed\n", s);
    4048:	85ca                	mv	a1,s2
    404a:	00004517          	auipc	a0,0x4
    404e:	c6e50513          	addi	a0,a0,-914 # 7cb8 <malloc+0x19c2>
    4052:	00002097          	auipc	ra,0x2
    4056:	1e6080e7          	jalr	486(ra) # 6238 <printf>
    exit(1,0);
    405a:	4581                	li	a1,0
    405c:	4505                	li	a0,1
    405e:	00002097          	auipc	ra,0x2
    4062:	e5a080e7          	jalr	-422(ra) # 5eb8 <exit>
    printf("%s: unlink dd failed\n", s);
    4066:	85ca                	mv	a1,s2
    4068:	00004517          	auipc	a0,0x4
    406c:	c7050513          	addi	a0,a0,-912 # 7cd8 <malloc+0x19e2>
    4070:	00002097          	auipc	ra,0x2
    4074:	1c8080e7          	jalr	456(ra) # 6238 <printf>
    exit(1,0);
    4078:	4581                	li	a1,0
    407a:	4505                	li	a0,1
    407c:	00002097          	auipc	ra,0x2
    4080:	e3c080e7          	jalr	-452(ra) # 5eb8 <exit>

0000000000004084 <rmdot>:
{
    4084:	1101                	addi	sp,sp,-32
    4086:	ec06                	sd	ra,24(sp)
    4088:	e822                	sd	s0,16(sp)
    408a:	e426                	sd	s1,8(sp)
    408c:	1000                	addi	s0,sp,32
    408e:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    4090:	00004517          	auipc	a0,0x4
    4094:	c6050513          	addi	a0,a0,-928 # 7cf0 <malloc+0x19fa>
    4098:	00002097          	auipc	ra,0x2
    409c:	e88080e7          	jalr	-376(ra) # 5f20 <mkdir>
    40a0:	e549                	bnez	a0,412a <rmdot+0xa6>
  if(chdir("dots") != 0){
    40a2:	00004517          	auipc	a0,0x4
    40a6:	c4e50513          	addi	a0,a0,-946 # 7cf0 <malloc+0x19fa>
    40aa:	00002097          	auipc	ra,0x2
    40ae:	e7e080e7          	jalr	-386(ra) # 5f28 <chdir>
    40b2:	e959                	bnez	a0,4148 <rmdot+0xc4>
  if(unlink(".") == 0){
    40b4:	00003517          	auipc	a0,0x3
    40b8:	a6c50513          	addi	a0,a0,-1428 # 6b20 <malloc+0x82a>
    40bc:	00002097          	auipc	ra,0x2
    40c0:	e4c080e7          	jalr	-436(ra) # 5f08 <unlink>
    40c4:	c14d                	beqz	a0,4166 <rmdot+0xe2>
  if(unlink("..") == 0){
    40c6:	00003517          	auipc	a0,0x3
    40ca:	68250513          	addi	a0,a0,1666 # 7748 <malloc+0x1452>
    40ce:	00002097          	auipc	ra,0x2
    40d2:	e3a080e7          	jalr	-454(ra) # 5f08 <unlink>
    40d6:	c55d                	beqz	a0,4184 <rmdot+0x100>
  if(chdir("/") != 0){
    40d8:	00003517          	auipc	a0,0x3
    40dc:	61850513          	addi	a0,a0,1560 # 76f0 <malloc+0x13fa>
    40e0:	00002097          	auipc	ra,0x2
    40e4:	e48080e7          	jalr	-440(ra) # 5f28 <chdir>
    40e8:	ed4d                	bnez	a0,41a2 <rmdot+0x11e>
  if(unlink("dots/.") == 0){
    40ea:	00004517          	auipc	a0,0x4
    40ee:	c6e50513          	addi	a0,a0,-914 # 7d58 <malloc+0x1a62>
    40f2:	00002097          	auipc	ra,0x2
    40f6:	e16080e7          	jalr	-490(ra) # 5f08 <unlink>
    40fa:	c179                	beqz	a0,41c0 <rmdot+0x13c>
  if(unlink("dots/..") == 0){
    40fc:	00004517          	auipc	a0,0x4
    4100:	c8450513          	addi	a0,a0,-892 # 7d80 <malloc+0x1a8a>
    4104:	00002097          	auipc	ra,0x2
    4108:	e04080e7          	jalr	-508(ra) # 5f08 <unlink>
    410c:	c969                	beqz	a0,41de <rmdot+0x15a>
  if(unlink("dots") != 0){
    410e:	00004517          	auipc	a0,0x4
    4112:	be250513          	addi	a0,a0,-1054 # 7cf0 <malloc+0x19fa>
    4116:	00002097          	auipc	ra,0x2
    411a:	df2080e7          	jalr	-526(ra) # 5f08 <unlink>
    411e:	ed79                	bnez	a0,41fc <rmdot+0x178>
}
    4120:	60e2                	ld	ra,24(sp)
    4122:	6442                	ld	s0,16(sp)
    4124:	64a2                	ld	s1,8(sp)
    4126:	6105                	addi	sp,sp,32
    4128:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    412a:	85a6                	mv	a1,s1
    412c:	00004517          	auipc	a0,0x4
    4130:	bcc50513          	addi	a0,a0,-1076 # 7cf8 <malloc+0x1a02>
    4134:	00002097          	auipc	ra,0x2
    4138:	104080e7          	jalr	260(ra) # 6238 <printf>
    exit(1,0);
    413c:	4581                	li	a1,0
    413e:	4505                	li	a0,1
    4140:	00002097          	auipc	ra,0x2
    4144:	d78080e7          	jalr	-648(ra) # 5eb8 <exit>
    printf("%s: chdir dots failed\n", s);
    4148:	85a6                	mv	a1,s1
    414a:	00004517          	auipc	a0,0x4
    414e:	bc650513          	addi	a0,a0,-1082 # 7d10 <malloc+0x1a1a>
    4152:	00002097          	auipc	ra,0x2
    4156:	0e6080e7          	jalr	230(ra) # 6238 <printf>
    exit(1,0);
    415a:	4581                	li	a1,0
    415c:	4505                	li	a0,1
    415e:	00002097          	auipc	ra,0x2
    4162:	d5a080e7          	jalr	-678(ra) # 5eb8 <exit>
    printf("%s: rm . worked!\n", s);
    4166:	85a6                	mv	a1,s1
    4168:	00004517          	auipc	a0,0x4
    416c:	bc050513          	addi	a0,a0,-1088 # 7d28 <malloc+0x1a32>
    4170:	00002097          	auipc	ra,0x2
    4174:	0c8080e7          	jalr	200(ra) # 6238 <printf>
    exit(1,0);
    4178:	4581                	li	a1,0
    417a:	4505                	li	a0,1
    417c:	00002097          	auipc	ra,0x2
    4180:	d3c080e7          	jalr	-708(ra) # 5eb8 <exit>
    printf("%s: rm .. worked!\n", s);
    4184:	85a6                	mv	a1,s1
    4186:	00004517          	auipc	a0,0x4
    418a:	bba50513          	addi	a0,a0,-1094 # 7d40 <malloc+0x1a4a>
    418e:	00002097          	auipc	ra,0x2
    4192:	0aa080e7          	jalr	170(ra) # 6238 <printf>
    exit(1,0);
    4196:	4581                	li	a1,0
    4198:	4505                	li	a0,1
    419a:	00002097          	auipc	ra,0x2
    419e:	d1e080e7          	jalr	-738(ra) # 5eb8 <exit>
    printf("%s: chdir / failed\n", s);
    41a2:	85a6                	mv	a1,s1
    41a4:	00003517          	auipc	a0,0x3
    41a8:	55450513          	addi	a0,a0,1364 # 76f8 <malloc+0x1402>
    41ac:	00002097          	auipc	ra,0x2
    41b0:	08c080e7          	jalr	140(ra) # 6238 <printf>
    exit(1,0);
    41b4:	4581                	li	a1,0
    41b6:	4505                	li	a0,1
    41b8:	00002097          	auipc	ra,0x2
    41bc:	d00080e7          	jalr	-768(ra) # 5eb8 <exit>
    printf("%s: unlink dots/. worked!\n", s);
    41c0:	85a6                	mv	a1,s1
    41c2:	00004517          	auipc	a0,0x4
    41c6:	b9e50513          	addi	a0,a0,-1122 # 7d60 <malloc+0x1a6a>
    41ca:	00002097          	auipc	ra,0x2
    41ce:	06e080e7          	jalr	110(ra) # 6238 <printf>
    exit(1,0);
    41d2:	4581                	li	a1,0
    41d4:	4505                	li	a0,1
    41d6:	00002097          	auipc	ra,0x2
    41da:	ce2080e7          	jalr	-798(ra) # 5eb8 <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    41de:	85a6                	mv	a1,s1
    41e0:	00004517          	auipc	a0,0x4
    41e4:	ba850513          	addi	a0,a0,-1112 # 7d88 <malloc+0x1a92>
    41e8:	00002097          	auipc	ra,0x2
    41ec:	050080e7          	jalr	80(ra) # 6238 <printf>
    exit(1,0);
    41f0:	4581                	li	a1,0
    41f2:	4505                	li	a0,1
    41f4:	00002097          	auipc	ra,0x2
    41f8:	cc4080e7          	jalr	-828(ra) # 5eb8 <exit>
    printf("%s: unlink dots failed!\n", s);
    41fc:	85a6                	mv	a1,s1
    41fe:	00004517          	auipc	a0,0x4
    4202:	baa50513          	addi	a0,a0,-1110 # 7da8 <malloc+0x1ab2>
    4206:	00002097          	auipc	ra,0x2
    420a:	032080e7          	jalr	50(ra) # 6238 <printf>
    exit(1,0);
    420e:	4581                	li	a1,0
    4210:	4505                	li	a0,1
    4212:	00002097          	auipc	ra,0x2
    4216:	ca6080e7          	jalr	-858(ra) # 5eb8 <exit>

000000000000421a <dirfile>:
{
    421a:	1101                	addi	sp,sp,-32
    421c:	ec06                	sd	ra,24(sp)
    421e:	e822                	sd	s0,16(sp)
    4220:	e426                	sd	s1,8(sp)
    4222:	e04a                	sd	s2,0(sp)
    4224:	1000                	addi	s0,sp,32
    4226:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    4228:	20000593          	li	a1,512
    422c:	00004517          	auipc	a0,0x4
    4230:	b9c50513          	addi	a0,a0,-1124 # 7dc8 <malloc+0x1ad2>
    4234:	00002097          	auipc	ra,0x2
    4238:	cc4080e7          	jalr	-828(ra) # 5ef8 <open>
  if(fd < 0){
    423c:	0e054d63          	bltz	a0,4336 <dirfile+0x11c>
  close(fd);
    4240:	00002097          	auipc	ra,0x2
    4244:	ca0080e7          	jalr	-864(ra) # 5ee0 <close>
  if(chdir("dirfile") == 0){
    4248:	00004517          	auipc	a0,0x4
    424c:	b8050513          	addi	a0,a0,-1152 # 7dc8 <malloc+0x1ad2>
    4250:	00002097          	auipc	ra,0x2
    4254:	cd8080e7          	jalr	-808(ra) # 5f28 <chdir>
    4258:	cd75                	beqz	a0,4354 <dirfile+0x13a>
  fd = open("dirfile/xx", 0);
    425a:	4581                	li	a1,0
    425c:	00004517          	auipc	a0,0x4
    4260:	bb450513          	addi	a0,a0,-1100 # 7e10 <malloc+0x1b1a>
    4264:	00002097          	auipc	ra,0x2
    4268:	c94080e7          	jalr	-876(ra) # 5ef8 <open>
  if(fd >= 0){
    426c:	10055363          	bgez	a0,4372 <dirfile+0x158>
  fd = open("dirfile/xx", O_CREATE);
    4270:	20000593          	li	a1,512
    4274:	00004517          	auipc	a0,0x4
    4278:	b9c50513          	addi	a0,a0,-1124 # 7e10 <malloc+0x1b1a>
    427c:	00002097          	auipc	ra,0x2
    4280:	c7c080e7          	jalr	-900(ra) # 5ef8 <open>
  if(fd >= 0){
    4284:	10055663          	bgez	a0,4390 <dirfile+0x176>
  if(mkdir("dirfile/xx") == 0){
    4288:	00004517          	auipc	a0,0x4
    428c:	b8850513          	addi	a0,a0,-1144 # 7e10 <malloc+0x1b1a>
    4290:	00002097          	auipc	ra,0x2
    4294:	c90080e7          	jalr	-880(ra) # 5f20 <mkdir>
    4298:	10050b63          	beqz	a0,43ae <dirfile+0x194>
  if(unlink("dirfile/xx") == 0){
    429c:	00004517          	auipc	a0,0x4
    42a0:	b7450513          	addi	a0,a0,-1164 # 7e10 <malloc+0x1b1a>
    42a4:	00002097          	auipc	ra,0x2
    42a8:	c64080e7          	jalr	-924(ra) # 5f08 <unlink>
    42ac:	12050063          	beqz	a0,43cc <dirfile+0x1b2>
  if(link("README", "dirfile/xx") == 0){
    42b0:	00004597          	auipc	a1,0x4
    42b4:	b6058593          	addi	a1,a1,-1184 # 7e10 <malloc+0x1b1a>
    42b8:	00002517          	auipc	a0,0x2
    42bc:	35850513          	addi	a0,a0,856 # 6610 <malloc+0x31a>
    42c0:	00002097          	auipc	ra,0x2
    42c4:	c58080e7          	jalr	-936(ra) # 5f18 <link>
    42c8:	12050163          	beqz	a0,43ea <dirfile+0x1d0>
  if(unlink("dirfile") != 0){
    42cc:	00004517          	auipc	a0,0x4
    42d0:	afc50513          	addi	a0,a0,-1284 # 7dc8 <malloc+0x1ad2>
    42d4:	00002097          	auipc	ra,0x2
    42d8:	c34080e7          	jalr	-972(ra) # 5f08 <unlink>
    42dc:	12051663          	bnez	a0,4408 <dirfile+0x1ee>
  fd = open(".", O_RDWR);
    42e0:	4589                	li	a1,2
    42e2:	00003517          	auipc	a0,0x3
    42e6:	83e50513          	addi	a0,a0,-1986 # 6b20 <malloc+0x82a>
    42ea:	00002097          	auipc	ra,0x2
    42ee:	c0e080e7          	jalr	-1010(ra) # 5ef8 <open>
  if(fd >= 0){
    42f2:	12055a63          	bgez	a0,4426 <dirfile+0x20c>
  fd = open(".", 0);
    42f6:	4581                	li	a1,0
    42f8:	00003517          	auipc	a0,0x3
    42fc:	82850513          	addi	a0,a0,-2008 # 6b20 <malloc+0x82a>
    4300:	00002097          	auipc	ra,0x2
    4304:	bf8080e7          	jalr	-1032(ra) # 5ef8 <open>
    4308:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    430a:	4605                	li	a2,1
    430c:	00002597          	auipc	a1,0x2
    4310:	19c58593          	addi	a1,a1,412 # 64a8 <malloc+0x1b2>
    4314:	00002097          	auipc	ra,0x2
    4318:	bc4080e7          	jalr	-1084(ra) # 5ed8 <write>
    431c:	12a04463          	bgtz	a0,4444 <dirfile+0x22a>
  close(fd);
    4320:	8526                	mv	a0,s1
    4322:	00002097          	auipc	ra,0x2
    4326:	bbe080e7          	jalr	-1090(ra) # 5ee0 <close>
}
    432a:	60e2                	ld	ra,24(sp)
    432c:	6442                	ld	s0,16(sp)
    432e:	64a2                	ld	s1,8(sp)
    4330:	6902                	ld	s2,0(sp)
    4332:	6105                	addi	sp,sp,32
    4334:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    4336:	85ca                	mv	a1,s2
    4338:	00004517          	auipc	a0,0x4
    433c:	a9850513          	addi	a0,a0,-1384 # 7dd0 <malloc+0x1ada>
    4340:	00002097          	auipc	ra,0x2
    4344:	ef8080e7          	jalr	-264(ra) # 6238 <printf>
    exit(1,0);
    4348:	4581                	li	a1,0
    434a:	4505                	li	a0,1
    434c:	00002097          	auipc	ra,0x2
    4350:	b6c080e7          	jalr	-1172(ra) # 5eb8 <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    4354:	85ca                	mv	a1,s2
    4356:	00004517          	auipc	a0,0x4
    435a:	a9a50513          	addi	a0,a0,-1382 # 7df0 <malloc+0x1afa>
    435e:	00002097          	auipc	ra,0x2
    4362:	eda080e7          	jalr	-294(ra) # 6238 <printf>
    exit(1,0);
    4366:	4581                	li	a1,0
    4368:	4505                	li	a0,1
    436a:	00002097          	auipc	ra,0x2
    436e:	b4e080e7          	jalr	-1202(ra) # 5eb8 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4372:	85ca                	mv	a1,s2
    4374:	00004517          	auipc	a0,0x4
    4378:	aac50513          	addi	a0,a0,-1364 # 7e20 <malloc+0x1b2a>
    437c:	00002097          	auipc	ra,0x2
    4380:	ebc080e7          	jalr	-324(ra) # 6238 <printf>
    exit(1,0);
    4384:	4581                	li	a1,0
    4386:	4505                	li	a0,1
    4388:	00002097          	auipc	ra,0x2
    438c:	b30080e7          	jalr	-1232(ra) # 5eb8 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4390:	85ca                	mv	a1,s2
    4392:	00004517          	auipc	a0,0x4
    4396:	a8e50513          	addi	a0,a0,-1394 # 7e20 <malloc+0x1b2a>
    439a:	00002097          	auipc	ra,0x2
    439e:	e9e080e7          	jalr	-354(ra) # 6238 <printf>
    exit(1,0);
    43a2:	4581                	li	a1,0
    43a4:	4505                	li	a0,1
    43a6:	00002097          	auipc	ra,0x2
    43aa:	b12080e7          	jalr	-1262(ra) # 5eb8 <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    43ae:	85ca                	mv	a1,s2
    43b0:	00004517          	auipc	a0,0x4
    43b4:	a9850513          	addi	a0,a0,-1384 # 7e48 <malloc+0x1b52>
    43b8:	00002097          	auipc	ra,0x2
    43bc:	e80080e7          	jalr	-384(ra) # 6238 <printf>
    exit(1,0);
    43c0:	4581                	li	a1,0
    43c2:	4505                	li	a0,1
    43c4:	00002097          	auipc	ra,0x2
    43c8:	af4080e7          	jalr	-1292(ra) # 5eb8 <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    43cc:	85ca                	mv	a1,s2
    43ce:	00004517          	auipc	a0,0x4
    43d2:	aa250513          	addi	a0,a0,-1374 # 7e70 <malloc+0x1b7a>
    43d6:	00002097          	auipc	ra,0x2
    43da:	e62080e7          	jalr	-414(ra) # 6238 <printf>
    exit(1,0);
    43de:	4581                	li	a1,0
    43e0:	4505                	li	a0,1
    43e2:	00002097          	auipc	ra,0x2
    43e6:	ad6080e7          	jalr	-1322(ra) # 5eb8 <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    43ea:	85ca                	mv	a1,s2
    43ec:	00004517          	auipc	a0,0x4
    43f0:	aac50513          	addi	a0,a0,-1364 # 7e98 <malloc+0x1ba2>
    43f4:	00002097          	auipc	ra,0x2
    43f8:	e44080e7          	jalr	-444(ra) # 6238 <printf>
    exit(1,0);
    43fc:	4581                	li	a1,0
    43fe:	4505                	li	a0,1
    4400:	00002097          	auipc	ra,0x2
    4404:	ab8080e7          	jalr	-1352(ra) # 5eb8 <exit>
    printf("%s: unlink dirfile failed!\n", s);
    4408:	85ca                	mv	a1,s2
    440a:	00004517          	auipc	a0,0x4
    440e:	ab650513          	addi	a0,a0,-1354 # 7ec0 <malloc+0x1bca>
    4412:	00002097          	auipc	ra,0x2
    4416:	e26080e7          	jalr	-474(ra) # 6238 <printf>
    exit(1,0);
    441a:	4581                	li	a1,0
    441c:	4505                	li	a0,1
    441e:	00002097          	auipc	ra,0x2
    4422:	a9a080e7          	jalr	-1382(ra) # 5eb8 <exit>
    printf("%s: open . for writing succeeded!\n", s);
    4426:	85ca                	mv	a1,s2
    4428:	00004517          	auipc	a0,0x4
    442c:	ab850513          	addi	a0,a0,-1352 # 7ee0 <malloc+0x1bea>
    4430:	00002097          	auipc	ra,0x2
    4434:	e08080e7          	jalr	-504(ra) # 6238 <printf>
    exit(1,0);
    4438:	4581                	li	a1,0
    443a:	4505                	li	a0,1
    443c:	00002097          	auipc	ra,0x2
    4440:	a7c080e7          	jalr	-1412(ra) # 5eb8 <exit>
    printf("%s: write . succeeded!\n", s);
    4444:	85ca                	mv	a1,s2
    4446:	00004517          	auipc	a0,0x4
    444a:	ac250513          	addi	a0,a0,-1342 # 7f08 <malloc+0x1c12>
    444e:	00002097          	auipc	ra,0x2
    4452:	dea080e7          	jalr	-534(ra) # 6238 <printf>
    exit(1,0);
    4456:	4581                	li	a1,0
    4458:	4505                	li	a0,1
    445a:	00002097          	auipc	ra,0x2
    445e:	a5e080e7          	jalr	-1442(ra) # 5eb8 <exit>

0000000000004462 <iref>:
{
    4462:	7139                	addi	sp,sp,-64
    4464:	fc06                	sd	ra,56(sp)
    4466:	f822                	sd	s0,48(sp)
    4468:	f426                	sd	s1,40(sp)
    446a:	f04a                	sd	s2,32(sp)
    446c:	ec4e                	sd	s3,24(sp)
    446e:	e852                	sd	s4,16(sp)
    4470:	e456                	sd	s5,8(sp)
    4472:	e05a                	sd	s6,0(sp)
    4474:	0080                	addi	s0,sp,64
    4476:	8b2a                	mv	s6,a0
    4478:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    447c:	00004a17          	auipc	s4,0x4
    4480:	aa4a0a13          	addi	s4,s4,-1372 # 7f20 <malloc+0x1c2a>
    mkdir("");
    4484:	00003497          	auipc	s1,0x3
    4488:	5a448493          	addi	s1,s1,1444 # 7a28 <malloc+0x1732>
    link("README", "");
    448c:	00002a97          	auipc	s5,0x2
    4490:	184a8a93          	addi	s5,s5,388 # 6610 <malloc+0x31a>
    fd = open("xx", O_CREATE);
    4494:	00004997          	auipc	s3,0x4
    4498:	98498993          	addi	s3,s3,-1660 # 7e18 <malloc+0x1b22>
    449c:	a8a1                	j	44f4 <iref+0x92>
      printf("%s: mkdir irefd failed\n", s);
    449e:	85da                	mv	a1,s6
    44a0:	00004517          	auipc	a0,0x4
    44a4:	a8850513          	addi	a0,a0,-1400 # 7f28 <malloc+0x1c32>
    44a8:	00002097          	auipc	ra,0x2
    44ac:	d90080e7          	jalr	-624(ra) # 6238 <printf>
      exit(1,0);
    44b0:	4581                	li	a1,0
    44b2:	4505                	li	a0,1
    44b4:	00002097          	auipc	ra,0x2
    44b8:	a04080e7          	jalr	-1532(ra) # 5eb8 <exit>
      printf("%s: chdir irefd failed\n", s);
    44bc:	85da                	mv	a1,s6
    44be:	00004517          	auipc	a0,0x4
    44c2:	a8250513          	addi	a0,a0,-1406 # 7f40 <malloc+0x1c4a>
    44c6:	00002097          	auipc	ra,0x2
    44ca:	d72080e7          	jalr	-654(ra) # 6238 <printf>
      exit(1,0);
    44ce:	4581                	li	a1,0
    44d0:	4505                	li	a0,1
    44d2:	00002097          	auipc	ra,0x2
    44d6:	9e6080e7          	jalr	-1562(ra) # 5eb8 <exit>
      close(fd);
    44da:	00002097          	auipc	ra,0x2
    44de:	a06080e7          	jalr	-1530(ra) # 5ee0 <close>
    44e2:	a889                	j	4534 <iref+0xd2>
    unlink("xx");
    44e4:	854e                	mv	a0,s3
    44e6:	00002097          	auipc	ra,0x2
    44ea:	a22080e7          	jalr	-1502(ra) # 5f08 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    44ee:	397d                	addiw	s2,s2,-1
    44f0:	06090063          	beqz	s2,4550 <iref+0xee>
    if(mkdir("irefd") != 0){
    44f4:	8552                	mv	a0,s4
    44f6:	00002097          	auipc	ra,0x2
    44fa:	a2a080e7          	jalr	-1494(ra) # 5f20 <mkdir>
    44fe:	f145                	bnez	a0,449e <iref+0x3c>
    if(chdir("irefd") != 0){
    4500:	8552                	mv	a0,s4
    4502:	00002097          	auipc	ra,0x2
    4506:	a26080e7          	jalr	-1498(ra) # 5f28 <chdir>
    450a:	f94d                	bnez	a0,44bc <iref+0x5a>
    mkdir("");
    450c:	8526                	mv	a0,s1
    450e:	00002097          	auipc	ra,0x2
    4512:	a12080e7          	jalr	-1518(ra) # 5f20 <mkdir>
    link("README", "");
    4516:	85a6                	mv	a1,s1
    4518:	8556                	mv	a0,s5
    451a:	00002097          	auipc	ra,0x2
    451e:	9fe080e7          	jalr	-1538(ra) # 5f18 <link>
    fd = open("", O_CREATE);
    4522:	20000593          	li	a1,512
    4526:	8526                	mv	a0,s1
    4528:	00002097          	auipc	ra,0x2
    452c:	9d0080e7          	jalr	-1584(ra) # 5ef8 <open>
    if(fd >= 0)
    4530:	fa0555e3          	bgez	a0,44da <iref+0x78>
    fd = open("xx", O_CREATE);
    4534:	20000593          	li	a1,512
    4538:	854e                	mv	a0,s3
    453a:	00002097          	auipc	ra,0x2
    453e:	9be080e7          	jalr	-1602(ra) # 5ef8 <open>
    if(fd >= 0)
    4542:	fa0541e3          	bltz	a0,44e4 <iref+0x82>
      close(fd);
    4546:	00002097          	auipc	ra,0x2
    454a:	99a080e7          	jalr	-1638(ra) # 5ee0 <close>
    454e:	bf59                	j	44e4 <iref+0x82>
    4550:	03300493          	li	s1,51
    chdir("..");
    4554:	00003997          	auipc	s3,0x3
    4558:	1f498993          	addi	s3,s3,500 # 7748 <malloc+0x1452>
    unlink("irefd");
    455c:	00004917          	auipc	s2,0x4
    4560:	9c490913          	addi	s2,s2,-1596 # 7f20 <malloc+0x1c2a>
    chdir("..");
    4564:	854e                	mv	a0,s3
    4566:	00002097          	auipc	ra,0x2
    456a:	9c2080e7          	jalr	-1598(ra) # 5f28 <chdir>
    unlink("irefd");
    456e:	854a                	mv	a0,s2
    4570:	00002097          	auipc	ra,0x2
    4574:	998080e7          	jalr	-1640(ra) # 5f08 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    4578:	34fd                	addiw	s1,s1,-1
    457a:	f4ed                	bnez	s1,4564 <iref+0x102>
  chdir("/");
    457c:	00003517          	auipc	a0,0x3
    4580:	17450513          	addi	a0,a0,372 # 76f0 <malloc+0x13fa>
    4584:	00002097          	auipc	ra,0x2
    4588:	9a4080e7          	jalr	-1628(ra) # 5f28 <chdir>
}
    458c:	70e2                	ld	ra,56(sp)
    458e:	7442                	ld	s0,48(sp)
    4590:	74a2                	ld	s1,40(sp)
    4592:	7902                	ld	s2,32(sp)
    4594:	69e2                	ld	s3,24(sp)
    4596:	6a42                	ld	s4,16(sp)
    4598:	6aa2                	ld	s5,8(sp)
    459a:	6b02                	ld	s6,0(sp)
    459c:	6121                	addi	sp,sp,64
    459e:	8082                	ret

00000000000045a0 <openiputtest>:
{
    45a0:	7179                	addi	sp,sp,-48
    45a2:	f406                	sd	ra,40(sp)
    45a4:	f022                	sd	s0,32(sp)
    45a6:	ec26                	sd	s1,24(sp)
    45a8:	1800                	addi	s0,sp,48
    45aa:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    45ac:	00004517          	auipc	a0,0x4
    45b0:	9ac50513          	addi	a0,a0,-1620 # 7f58 <malloc+0x1c62>
    45b4:	00002097          	auipc	ra,0x2
    45b8:	96c080e7          	jalr	-1684(ra) # 5f20 <mkdir>
    45bc:	04054363          	bltz	a0,4602 <openiputtest+0x62>
  pid = fork();
    45c0:	00002097          	auipc	ra,0x2
    45c4:	8f0080e7          	jalr	-1808(ra) # 5eb0 <fork>
  if(pid < 0){
    45c8:	04054c63          	bltz	a0,4620 <openiputtest+0x80>
  if(pid == 0){
    45cc:	ed3d                	bnez	a0,464a <openiputtest+0xaa>
    int fd = open("oidir", O_RDWR);
    45ce:	4589                	li	a1,2
    45d0:	00004517          	auipc	a0,0x4
    45d4:	98850513          	addi	a0,a0,-1656 # 7f58 <malloc+0x1c62>
    45d8:	00002097          	auipc	ra,0x2
    45dc:	920080e7          	jalr	-1760(ra) # 5ef8 <open>
    if(fd >= 0){
    45e0:	04054f63          	bltz	a0,463e <openiputtest+0x9e>
      printf("%s: open directory for write succeeded\n", s);
    45e4:	85a6                	mv	a1,s1
    45e6:	00004517          	auipc	a0,0x4
    45ea:	99250513          	addi	a0,a0,-1646 # 7f78 <malloc+0x1c82>
    45ee:	00002097          	auipc	ra,0x2
    45f2:	c4a080e7          	jalr	-950(ra) # 6238 <printf>
      exit(1,0);
    45f6:	4581                	li	a1,0
    45f8:	4505                	li	a0,1
    45fa:	00002097          	auipc	ra,0x2
    45fe:	8be080e7          	jalr	-1858(ra) # 5eb8 <exit>
    printf("%s: mkdir oidir failed\n", s);
    4602:	85a6                	mv	a1,s1
    4604:	00004517          	auipc	a0,0x4
    4608:	95c50513          	addi	a0,a0,-1700 # 7f60 <malloc+0x1c6a>
    460c:	00002097          	auipc	ra,0x2
    4610:	c2c080e7          	jalr	-980(ra) # 6238 <printf>
    exit(1,0);
    4614:	4581                	li	a1,0
    4616:	4505                	li	a0,1
    4618:	00002097          	auipc	ra,0x2
    461c:	8a0080e7          	jalr	-1888(ra) # 5eb8 <exit>
    printf("%s: fork failed\n", s);
    4620:	85a6                	mv	a1,s1
    4622:	00002517          	auipc	a0,0x2
    4626:	69e50513          	addi	a0,a0,1694 # 6cc0 <malloc+0x9ca>
    462a:	00002097          	auipc	ra,0x2
    462e:	c0e080e7          	jalr	-1010(ra) # 6238 <printf>
    exit(1,0);
    4632:	4581                	li	a1,0
    4634:	4505                	li	a0,1
    4636:	00002097          	auipc	ra,0x2
    463a:	882080e7          	jalr	-1918(ra) # 5eb8 <exit>
    exit(0,0);
    463e:	4581                	li	a1,0
    4640:	4501                	li	a0,0
    4642:	00002097          	auipc	ra,0x2
    4646:	876080e7          	jalr	-1930(ra) # 5eb8 <exit>
  sleep(1);
    464a:	4505                	li	a0,1
    464c:	00002097          	auipc	ra,0x2
    4650:	8fc080e7          	jalr	-1796(ra) # 5f48 <sleep>
  if(unlink("oidir") != 0){
    4654:	00004517          	auipc	a0,0x4
    4658:	90450513          	addi	a0,a0,-1788 # 7f58 <malloc+0x1c62>
    465c:	00002097          	auipc	ra,0x2
    4660:	8ac080e7          	jalr	-1876(ra) # 5f08 <unlink>
    4664:	c105                	beqz	a0,4684 <openiputtest+0xe4>
    printf("%s: unlink failed\n", s);
    4666:	85a6                	mv	a1,s1
    4668:	00003517          	auipc	a0,0x3
    466c:	84850513          	addi	a0,a0,-1976 # 6eb0 <malloc+0xbba>
    4670:	00002097          	auipc	ra,0x2
    4674:	bc8080e7          	jalr	-1080(ra) # 6238 <printf>
    exit(1,0);
    4678:	4581                	li	a1,0
    467a:	4505                	li	a0,1
    467c:	00002097          	auipc	ra,0x2
    4680:	83c080e7          	jalr	-1988(ra) # 5eb8 <exit>
  wait(&xstatus,0);
    4684:	4581                	li	a1,0
    4686:	fdc40513          	addi	a0,s0,-36
    468a:	00002097          	auipc	ra,0x2
    468e:	836080e7          	jalr	-1994(ra) # 5ec0 <wait>
  exit(xstatus,0);
    4692:	4581                	li	a1,0
    4694:	fdc42503          	lw	a0,-36(s0)
    4698:	00002097          	auipc	ra,0x2
    469c:	820080e7          	jalr	-2016(ra) # 5eb8 <exit>

00000000000046a0 <forkforkfork>:
{
    46a0:	1101                	addi	sp,sp,-32
    46a2:	ec06                	sd	ra,24(sp)
    46a4:	e822                	sd	s0,16(sp)
    46a6:	e426                	sd	s1,8(sp)
    46a8:	1000                	addi	s0,sp,32
    46aa:	84aa                	mv	s1,a0
  unlink("stopforking");
    46ac:	00004517          	auipc	a0,0x4
    46b0:	8f450513          	addi	a0,a0,-1804 # 7fa0 <malloc+0x1caa>
    46b4:	00002097          	auipc	ra,0x2
    46b8:	854080e7          	jalr	-1964(ra) # 5f08 <unlink>
  int pid = fork();
    46bc:	00001097          	auipc	ra,0x1
    46c0:	7f4080e7          	jalr	2036(ra) # 5eb0 <fork>
  if(pid < 0){
    46c4:	04054663          	bltz	a0,4710 <forkforkfork+0x70>
  if(pid == 0){
    46c8:	c13d                	beqz	a0,472e <forkforkfork+0x8e>
  sleep(20); // two seconds
    46ca:	4551                	li	a0,20
    46cc:	00002097          	auipc	ra,0x2
    46d0:	87c080e7          	jalr	-1924(ra) # 5f48 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    46d4:	20200593          	li	a1,514
    46d8:	00004517          	auipc	a0,0x4
    46dc:	8c850513          	addi	a0,a0,-1848 # 7fa0 <malloc+0x1caa>
    46e0:	00002097          	auipc	ra,0x2
    46e4:	818080e7          	jalr	-2024(ra) # 5ef8 <open>
    46e8:	00001097          	auipc	ra,0x1
    46ec:	7f8080e7          	jalr	2040(ra) # 5ee0 <close>
  wait(0,0);
    46f0:	4581                	li	a1,0
    46f2:	4501                	li	a0,0
    46f4:	00001097          	auipc	ra,0x1
    46f8:	7cc080e7          	jalr	1996(ra) # 5ec0 <wait>
  sleep(10); // one second
    46fc:	4529                	li	a0,10
    46fe:	00002097          	auipc	ra,0x2
    4702:	84a080e7          	jalr	-1974(ra) # 5f48 <sleep>
}
    4706:	60e2                	ld	ra,24(sp)
    4708:	6442                	ld	s0,16(sp)
    470a:	64a2                	ld	s1,8(sp)
    470c:	6105                	addi	sp,sp,32
    470e:	8082                	ret
    printf("%s: fork failed", s);
    4710:	85a6                	mv	a1,s1
    4712:	00002517          	auipc	a0,0x2
    4716:	76e50513          	addi	a0,a0,1902 # 6e80 <malloc+0xb8a>
    471a:	00002097          	auipc	ra,0x2
    471e:	b1e080e7          	jalr	-1250(ra) # 6238 <printf>
    exit(1,0);
    4722:	4581                	li	a1,0
    4724:	4505                	li	a0,1
    4726:	00001097          	auipc	ra,0x1
    472a:	792080e7          	jalr	1938(ra) # 5eb8 <exit>
      int fd = open("stopforking", 0);
    472e:	00004497          	auipc	s1,0x4
    4732:	87248493          	addi	s1,s1,-1934 # 7fa0 <malloc+0x1caa>
    4736:	4581                	li	a1,0
    4738:	8526                	mv	a0,s1
    473a:	00001097          	auipc	ra,0x1
    473e:	7be080e7          	jalr	1982(ra) # 5ef8 <open>
      if(fd >= 0){
    4742:	02055463          	bgez	a0,476a <forkforkfork+0xca>
      if(fork() < 0){
    4746:	00001097          	auipc	ra,0x1
    474a:	76a080e7          	jalr	1898(ra) # 5eb0 <fork>
    474e:	fe0554e3          	bgez	a0,4736 <forkforkfork+0x96>
        close(open("stopforking", O_CREATE|O_RDWR));
    4752:	20200593          	li	a1,514
    4756:	8526                	mv	a0,s1
    4758:	00001097          	auipc	ra,0x1
    475c:	7a0080e7          	jalr	1952(ra) # 5ef8 <open>
    4760:	00001097          	auipc	ra,0x1
    4764:	780080e7          	jalr	1920(ra) # 5ee0 <close>
    4768:	b7f9                	j	4736 <forkforkfork+0x96>
        exit(0,0);
    476a:	4581                	li	a1,0
    476c:	4501                	li	a0,0
    476e:	00001097          	auipc	ra,0x1
    4772:	74a080e7          	jalr	1866(ra) # 5eb8 <exit>

0000000000004776 <killstatus>:
{
    4776:	7139                	addi	sp,sp,-64
    4778:	fc06                	sd	ra,56(sp)
    477a:	f822                	sd	s0,48(sp)
    477c:	f426                	sd	s1,40(sp)
    477e:	f04a                	sd	s2,32(sp)
    4780:	ec4e                	sd	s3,24(sp)
    4782:	e852                	sd	s4,16(sp)
    4784:	0080                	addi	s0,sp,64
    4786:	8a2a                	mv	s4,a0
    4788:	06400913          	li	s2,100
    if(xst != -1) {
    478c:	59fd                	li	s3,-1
    int pid1 = fork();
    478e:	00001097          	auipc	ra,0x1
    4792:	722080e7          	jalr	1826(ra) # 5eb0 <fork>
    4796:	84aa                	mv	s1,a0
    if(pid1 < 0){
    4798:	04054163          	bltz	a0,47da <killstatus+0x64>
    if(pid1 == 0){
    479c:	cd31                	beqz	a0,47f8 <killstatus+0x82>
    sleep(1);
    479e:	4505                	li	a0,1
    47a0:	00001097          	auipc	ra,0x1
    47a4:	7a8080e7          	jalr	1960(ra) # 5f48 <sleep>
    kill(pid1);
    47a8:	8526                	mv	a0,s1
    47aa:	00001097          	auipc	ra,0x1
    47ae:	73e080e7          	jalr	1854(ra) # 5ee8 <kill>
    wait(&xst,0);
    47b2:	4581                	li	a1,0
    47b4:	fcc40513          	addi	a0,s0,-52
    47b8:	00001097          	auipc	ra,0x1
    47bc:	708080e7          	jalr	1800(ra) # 5ec0 <wait>
    if(xst != -1) {
    47c0:	fcc42783          	lw	a5,-52(s0)
    47c4:	03379f63          	bne	a5,s3,4802 <killstatus+0x8c>
  for(int i = 0; i < 100; i++){
    47c8:	397d                	addiw	s2,s2,-1
    47ca:	fc0912e3          	bnez	s2,478e <killstatus+0x18>
  exit(0,0);
    47ce:	4581                	li	a1,0
    47d0:	4501                	li	a0,0
    47d2:	00001097          	auipc	ra,0x1
    47d6:	6e6080e7          	jalr	1766(ra) # 5eb8 <exit>
      printf("%s: fork failed\n", s);
    47da:	85d2                	mv	a1,s4
    47dc:	00002517          	auipc	a0,0x2
    47e0:	4e450513          	addi	a0,a0,1252 # 6cc0 <malloc+0x9ca>
    47e4:	00002097          	auipc	ra,0x2
    47e8:	a54080e7          	jalr	-1452(ra) # 6238 <printf>
      exit(1,0);
    47ec:	4581                	li	a1,0
    47ee:	4505                	li	a0,1
    47f0:	00001097          	auipc	ra,0x1
    47f4:	6c8080e7          	jalr	1736(ra) # 5eb8 <exit>
        getpid();
    47f8:	00001097          	auipc	ra,0x1
    47fc:	740080e7          	jalr	1856(ra) # 5f38 <getpid>
      while(1) {
    4800:	bfe5                	j	47f8 <killstatus+0x82>
       printf("%s: status should be -1\n", s);
    4802:	85d2                	mv	a1,s4
    4804:	00003517          	auipc	a0,0x3
    4808:	7ac50513          	addi	a0,a0,1964 # 7fb0 <malloc+0x1cba>
    480c:	00002097          	auipc	ra,0x2
    4810:	a2c080e7          	jalr	-1492(ra) # 6238 <printf>
       exit(1,0);
    4814:	4581                	li	a1,0
    4816:	4505                	li	a0,1
    4818:	00001097          	auipc	ra,0x1
    481c:	6a0080e7          	jalr	1696(ra) # 5eb8 <exit>

0000000000004820 <preempt>:
{
    4820:	7139                	addi	sp,sp,-64
    4822:	fc06                	sd	ra,56(sp)
    4824:	f822                	sd	s0,48(sp)
    4826:	f426                	sd	s1,40(sp)
    4828:	f04a                	sd	s2,32(sp)
    482a:	ec4e                	sd	s3,24(sp)
    482c:	e852                	sd	s4,16(sp)
    482e:	0080                	addi	s0,sp,64
    4830:	892a                	mv	s2,a0
  pid1 = fork();
    4832:	00001097          	auipc	ra,0x1
    4836:	67e080e7          	jalr	1662(ra) # 5eb0 <fork>
  if(pid1 < 0) {
    483a:	00054563          	bltz	a0,4844 <preempt+0x24>
    483e:	84aa                	mv	s1,a0
  if(pid1 == 0)
    4840:	e10d                	bnez	a0,4862 <preempt+0x42>
    for(;;)
    4842:	a001                	j	4842 <preempt+0x22>
    printf("%s: fork failed", s);
    4844:	85ca                	mv	a1,s2
    4846:	00002517          	auipc	a0,0x2
    484a:	63a50513          	addi	a0,a0,1594 # 6e80 <malloc+0xb8a>
    484e:	00002097          	auipc	ra,0x2
    4852:	9ea080e7          	jalr	-1558(ra) # 6238 <printf>
    exit(1,0);
    4856:	4581                	li	a1,0
    4858:	4505                	li	a0,1
    485a:	00001097          	auipc	ra,0x1
    485e:	65e080e7          	jalr	1630(ra) # 5eb8 <exit>
  pid2 = fork();
    4862:	00001097          	auipc	ra,0x1
    4866:	64e080e7          	jalr	1614(ra) # 5eb0 <fork>
    486a:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    486c:	00054463          	bltz	a0,4874 <preempt+0x54>
  if(pid2 == 0)
    4870:	e10d                	bnez	a0,4892 <preempt+0x72>
    for(;;)
    4872:	a001                	j	4872 <preempt+0x52>
    printf("%s: fork failed\n", s);
    4874:	85ca                	mv	a1,s2
    4876:	00002517          	auipc	a0,0x2
    487a:	44a50513          	addi	a0,a0,1098 # 6cc0 <malloc+0x9ca>
    487e:	00002097          	auipc	ra,0x2
    4882:	9ba080e7          	jalr	-1606(ra) # 6238 <printf>
    exit(1,0);
    4886:	4581                	li	a1,0
    4888:	4505                	li	a0,1
    488a:	00001097          	auipc	ra,0x1
    488e:	62e080e7          	jalr	1582(ra) # 5eb8 <exit>
  pipe(pfds);
    4892:	fc840513          	addi	a0,s0,-56
    4896:	00001097          	auipc	ra,0x1
    489a:	632080e7          	jalr	1586(ra) # 5ec8 <pipe>
  pid3 = fork();
    489e:	00001097          	auipc	ra,0x1
    48a2:	612080e7          	jalr	1554(ra) # 5eb0 <fork>
    48a6:	8a2a                	mv	s4,a0
  if(pid3 < 0) {
    48a8:	02054e63          	bltz	a0,48e4 <preempt+0xc4>
  if(pid3 == 0){
    48ac:	e52d                	bnez	a0,4916 <preempt+0xf6>
    close(pfds[0]);
    48ae:	fc842503          	lw	a0,-56(s0)
    48b2:	00001097          	auipc	ra,0x1
    48b6:	62e080e7          	jalr	1582(ra) # 5ee0 <close>
    if(write(pfds[1], "x", 1) != 1)
    48ba:	4605                	li	a2,1
    48bc:	00002597          	auipc	a1,0x2
    48c0:	bec58593          	addi	a1,a1,-1044 # 64a8 <malloc+0x1b2>
    48c4:	fcc42503          	lw	a0,-52(s0)
    48c8:	00001097          	auipc	ra,0x1
    48cc:	610080e7          	jalr	1552(ra) # 5ed8 <write>
    48d0:	4785                	li	a5,1
    48d2:	02f51863          	bne	a0,a5,4902 <preempt+0xe2>
    close(pfds[1]);
    48d6:	fcc42503          	lw	a0,-52(s0)
    48da:	00001097          	auipc	ra,0x1
    48de:	606080e7          	jalr	1542(ra) # 5ee0 <close>
    for(;;)
    48e2:	a001                	j	48e2 <preempt+0xc2>
     printf("%s: fork failed\n", s);
    48e4:	85ca                	mv	a1,s2
    48e6:	00002517          	auipc	a0,0x2
    48ea:	3da50513          	addi	a0,a0,986 # 6cc0 <malloc+0x9ca>
    48ee:	00002097          	auipc	ra,0x2
    48f2:	94a080e7          	jalr	-1718(ra) # 6238 <printf>
     exit(1,0);
    48f6:	4581                	li	a1,0
    48f8:	4505                	li	a0,1
    48fa:	00001097          	auipc	ra,0x1
    48fe:	5be080e7          	jalr	1470(ra) # 5eb8 <exit>
      printf("%s: preempt write error", s);
    4902:	85ca                	mv	a1,s2
    4904:	00003517          	auipc	a0,0x3
    4908:	6cc50513          	addi	a0,a0,1740 # 7fd0 <malloc+0x1cda>
    490c:	00002097          	auipc	ra,0x2
    4910:	92c080e7          	jalr	-1748(ra) # 6238 <printf>
    4914:	b7c9                	j	48d6 <preempt+0xb6>
  close(pfds[1]);
    4916:	fcc42503          	lw	a0,-52(s0)
    491a:	00001097          	auipc	ra,0x1
    491e:	5c6080e7          	jalr	1478(ra) # 5ee0 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    4922:	660d                	lui	a2,0x3
    4924:	00008597          	auipc	a1,0x8
    4928:	35458593          	addi	a1,a1,852 # cc78 <buf>
    492c:	fc842503          	lw	a0,-56(s0)
    4930:	00001097          	auipc	ra,0x1
    4934:	5a0080e7          	jalr	1440(ra) # 5ed0 <read>
    4938:	4785                	li	a5,1
    493a:	02f50363          	beq	a0,a5,4960 <preempt+0x140>
    printf("%s: preempt read error", s);
    493e:	85ca                	mv	a1,s2
    4940:	00003517          	auipc	a0,0x3
    4944:	6a850513          	addi	a0,a0,1704 # 7fe8 <malloc+0x1cf2>
    4948:	00002097          	auipc	ra,0x2
    494c:	8f0080e7          	jalr	-1808(ra) # 6238 <printf>
}
    4950:	70e2                	ld	ra,56(sp)
    4952:	7442                	ld	s0,48(sp)
    4954:	74a2                	ld	s1,40(sp)
    4956:	7902                	ld	s2,32(sp)
    4958:	69e2                	ld	s3,24(sp)
    495a:	6a42                	ld	s4,16(sp)
    495c:	6121                	addi	sp,sp,64
    495e:	8082                	ret
  close(pfds[0]);
    4960:	fc842503          	lw	a0,-56(s0)
    4964:	00001097          	auipc	ra,0x1
    4968:	57c080e7          	jalr	1404(ra) # 5ee0 <close>
  printf("kill... ");
    496c:	00003517          	auipc	a0,0x3
    4970:	69450513          	addi	a0,a0,1684 # 8000 <malloc+0x1d0a>
    4974:	00002097          	auipc	ra,0x2
    4978:	8c4080e7          	jalr	-1852(ra) # 6238 <printf>
  kill(pid1);
    497c:	8526                	mv	a0,s1
    497e:	00001097          	auipc	ra,0x1
    4982:	56a080e7          	jalr	1386(ra) # 5ee8 <kill>
  kill(pid2);
    4986:	854e                	mv	a0,s3
    4988:	00001097          	auipc	ra,0x1
    498c:	560080e7          	jalr	1376(ra) # 5ee8 <kill>
  kill(pid3);
    4990:	8552                	mv	a0,s4
    4992:	00001097          	auipc	ra,0x1
    4996:	556080e7          	jalr	1366(ra) # 5ee8 <kill>
  printf("wait... ");
    499a:	00003517          	auipc	a0,0x3
    499e:	67650513          	addi	a0,a0,1654 # 8010 <malloc+0x1d1a>
    49a2:	00002097          	auipc	ra,0x2
    49a6:	896080e7          	jalr	-1898(ra) # 6238 <printf>
  wait(0,0);
    49aa:	4581                	li	a1,0
    49ac:	4501                	li	a0,0
    49ae:	00001097          	auipc	ra,0x1
    49b2:	512080e7          	jalr	1298(ra) # 5ec0 <wait>
  wait(0,0);
    49b6:	4581                	li	a1,0
    49b8:	4501                	li	a0,0
    49ba:	00001097          	auipc	ra,0x1
    49be:	506080e7          	jalr	1286(ra) # 5ec0 <wait>
  wait(0,0);
    49c2:	4581                	li	a1,0
    49c4:	4501                	li	a0,0
    49c6:	00001097          	auipc	ra,0x1
    49ca:	4fa080e7          	jalr	1274(ra) # 5ec0 <wait>
    49ce:	b749                	j	4950 <preempt+0x130>

00000000000049d0 <reparent>:
{
    49d0:	7179                	addi	sp,sp,-48
    49d2:	f406                	sd	ra,40(sp)
    49d4:	f022                	sd	s0,32(sp)
    49d6:	ec26                	sd	s1,24(sp)
    49d8:	e84a                	sd	s2,16(sp)
    49da:	e44e                	sd	s3,8(sp)
    49dc:	e052                	sd	s4,0(sp)
    49de:	1800                	addi	s0,sp,48
    49e0:	89aa                	mv	s3,a0
  int master_pid = getpid();
    49e2:	00001097          	auipc	ra,0x1
    49e6:	556080e7          	jalr	1366(ra) # 5f38 <getpid>
    49ea:	8a2a                	mv	s4,a0
    49ec:	0c800913          	li	s2,200
    int pid = fork();
    49f0:	00001097          	auipc	ra,0x1
    49f4:	4c0080e7          	jalr	1216(ra) # 5eb0 <fork>
    49f8:	84aa                	mv	s1,a0
    if(pid < 0){
    49fa:	02054463          	bltz	a0,4a22 <reparent+0x52>
    if(pid){
    49fe:	c125                	beqz	a0,4a5e <reparent+0x8e>
      if(wait(0,0) != pid){
    4a00:	4581                	li	a1,0
    4a02:	4501                	li	a0,0
    4a04:	00001097          	auipc	ra,0x1
    4a08:	4bc080e7          	jalr	1212(ra) # 5ec0 <wait>
    4a0c:	02951a63          	bne	a0,s1,4a40 <reparent+0x70>
  for(int i = 0; i < 200; i++){
    4a10:	397d                	addiw	s2,s2,-1
    4a12:	fc091fe3          	bnez	s2,49f0 <reparent+0x20>
  exit(0,0);
    4a16:	4581                	li	a1,0
    4a18:	4501                	li	a0,0
    4a1a:	00001097          	auipc	ra,0x1
    4a1e:	49e080e7          	jalr	1182(ra) # 5eb8 <exit>
      printf("%s: fork failed\n", s);
    4a22:	85ce                	mv	a1,s3
    4a24:	00002517          	auipc	a0,0x2
    4a28:	29c50513          	addi	a0,a0,668 # 6cc0 <malloc+0x9ca>
    4a2c:	00002097          	auipc	ra,0x2
    4a30:	80c080e7          	jalr	-2036(ra) # 6238 <printf>
      exit(1,0);
    4a34:	4581                	li	a1,0
    4a36:	4505                	li	a0,1
    4a38:	00001097          	auipc	ra,0x1
    4a3c:	480080e7          	jalr	1152(ra) # 5eb8 <exit>
        printf("%s: wait wrong pid\n", s);
    4a40:	85ce                	mv	a1,s3
    4a42:	00002517          	auipc	a0,0x2
    4a46:	40650513          	addi	a0,a0,1030 # 6e48 <malloc+0xb52>
    4a4a:	00001097          	auipc	ra,0x1
    4a4e:	7ee080e7          	jalr	2030(ra) # 6238 <printf>
        exit(1,0);
    4a52:	4581                	li	a1,0
    4a54:	4505                	li	a0,1
    4a56:	00001097          	auipc	ra,0x1
    4a5a:	462080e7          	jalr	1122(ra) # 5eb8 <exit>
      int pid2 = fork();
    4a5e:	00001097          	auipc	ra,0x1
    4a62:	452080e7          	jalr	1106(ra) # 5eb0 <fork>
      if(pid2 < 0){
    4a66:	00054863          	bltz	a0,4a76 <reparent+0xa6>
      exit(0,0);
    4a6a:	4581                	li	a1,0
    4a6c:	4501                	li	a0,0
    4a6e:	00001097          	auipc	ra,0x1
    4a72:	44a080e7          	jalr	1098(ra) # 5eb8 <exit>
        kill(master_pid);
    4a76:	8552                	mv	a0,s4
    4a78:	00001097          	auipc	ra,0x1
    4a7c:	470080e7          	jalr	1136(ra) # 5ee8 <kill>
        exit(1,0);
    4a80:	4581                	li	a1,0
    4a82:	4505                	li	a0,1
    4a84:	00001097          	auipc	ra,0x1
    4a88:	434080e7          	jalr	1076(ra) # 5eb8 <exit>

0000000000004a8c <sbrkfail>:
{
    4a8c:	7119                	addi	sp,sp,-128
    4a8e:	fc86                	sd	ra,120(sp)
    4a90:	f8a2                	sd	s0,112(sp)
    4a92:	f4a6                	sd	s1,104(sp)
    4a94:	f0ca                	sd	s2,96(sp)
    4a96:	ecce                	sd	s3,88(sp)
    4a98:	e8d2                	sd	s4,80(sp)
    4a9a:	e4d6                	sd	s5,72(sp)
    4a9c:	0100                	addi	s0,sp,128
    4a9e:	8aaa                	mv	s5,a0
  if(pipe(fds) != 0){
    4aa0:	fb040513          	addi	a0,s0,-80
    4aa4:	00001097          	auipc	ra,0x1
    4aa8:	424080e7          	jalr	1060(ra) # 5ec8 <pipe>
    4aac:	e901                	bnez	a0,4abc <sbrkfail+0x30>
    4aae:	f8040493          	addi	s1,s0,-128
    4ab2:	fa840993          	addi	s3,s0,-88
    4ab6:	8926                	mv	s2,s1
    if(pids[i] != -1)
    4ab8:	5a7d                	li	s4,-1
    4aba:	a08d                	j	4b1c <sbrkfail+0x90>
    printf("%s: pipe() failed\n", s);
    4abc:	85d6                	mv	a1,s5
    4abe:	00002517          	auipc	a0,0x2
    4ac2:	30a50513          	addi	a0,a0,778 # 6dc8 <malloc+0xad2>
    4ac6:	00001097          	auipc	ra,0x1
    4aca:	772080e7          	jalr	1906(ra) # 6238 <printf>
    exit(1,0);
    4ace:	4581                	li	a1,0
    4ad0:	4505                	li	a0,1
    4ad2:	00001097          	auipc	ra,0x1
    4ad6:	3e6080e7          	jalr	998(ra) # 5eb8 <exit>
      sbrk(BIG - (uint64)sbrk(0));
    4ada:	00001097          	auipc	ra,0x1
    4ade:	466080e7          	jalr	1126(ra) # 5f40 <sbrk>
    4ae2:	064007b7          	lui	a5,0x6400
    4ae6:	40a7853b          	subw	a0,a5,a0
    4aea:	00001097          	auipc	ra,0x1
    4aee:	456080e7          	jalr	1110(ra) # 5f40 <sbrk>
      write(fds[1], "x", 1);
    4af2:	4605                	li	a2,1
    4af4:	00002597          	auipc	a1,0x2
    4af8:	9b458593          	addi	a1,a1,-1612 # 64a8 <malloc+0x1b2>
    4afc:	fb442503          	lw	a0,-76(s0)
    4b00:	00001097          	auipc	ra,0x1
    4b04:	3d8080e7          	jalr	984(ra) # 5ed8 <write>
      for(;;) sleep(1000);
    4b08:	3e800513          	li	a0,1000
    4b0c:	00001097          	auipc	ra,0x1
    4b10:	43c080e7          	jalr	1084(ra) # 5f48 <sleep>
    4b14:	bfd5                	j	4b08 <sbrkfail+0x7c>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    4b16:	0911                	addi	s2,s2,4
    4b18:	03390563          	beq	s2,s3,4b42 <sbrkfail+0xb6>
    if((pids[i] = fork()) == 0){
    4b1c:	00001097          	auipc	ra,0x1
    4b20:	394080e7          	jalr	916(ra) # 5eb0 <fork>
    4b24:	00a92023          	sw	a0,0(s2)
    4b28:	d94d                	beqz	a0,4ada <sbrkfail+0x4e>
    if(pids[i] != -1)
    4b2a:	ff4506e3          	beq	a0,s4,4b16 <sbrkfail+0x8a>
      read(fds[0], &scratch, 1);
    4b2e:	4605                	li	a2,1
    4b30:	faf40593          	addi	a1,s0,-81
    4b34:	fb042503          	lw	a0,-80(s0)
    4b38:	00001097          	auipc	ra,0x1
    4b3c:	398080e7          	jalr	920(ra) # 5ed0 <read>
    4b40:	bfd9                	j	4b16 <sbrkfail+0x8a>
  c = sbrk(PGSIZE);
    4b42:	6505                	lui	a0,0x1
    4b44:	00001097          	auipc	ra,0x1
    4b48:	3fc080e7          	jalr	1020(ra) # 5f40 <sbrk>
    4b4c:	8a2a                	mv	s4,a0
    if(pids[i] == -1)
    4b4e:	597d                	li	s2,-1
    4b50:	a021                	j	4b58 <sbrkfail+0xcc>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    4b52:	0491                	addi	s1,s1,4
    4b54:	03348063          	beq	s1,s3,4b74 <sbrkfail+0xe8>
    if(pids[i] == -1)
    4b58:	4088                	lw	a0,0(s1)
    4b5a:	ff250ce3          	beq	a0,s2,4b52 <sbrkfail+0xc6>
    kill(pids[i]);
    4b5e:	00001097          	auipc	ra,0x1
    4b62:	38a080e7          	jalr	906(ra) # 5ee8 <kill>
    wait(0,0);
    4b66:	4581                	li	a1,0
    4b68:	4501                	li	a0,0
    4b6a:	00001097          	auipc	ra,0x1
    4b6e:	356080e7          	jalr	854(ra) # 5ec0 <wait>
    4b72:	b7c5                	j	4b52 <sbrkfail+0xc6>
  if(c == (char*)0xffffffffffffffffL){
    4b74:	57fd                	li	a5,-1
    4b76:	04fa0263          	beq	s4,a5,4bba <sbrkfail+0x12e>
  pid = fork();
    4b7a:	00001097          	auipc	ra,0x1
    4b7e:	336080e7          	jalr	822(ra) # 5eb0 <fork>
    4b82:	84aa                	mv	s1,a0
  if(pid < 0){
    4b84:	04054a63          	bltz	a0,4bd8 <sbrkfail+0x14c>
  if(pid == 0){
    4b88:	c53d                	beqz	a0,4bf6 <sbrkfail+0x16a>
  wait(&xstatus,0);
    4b8a:	4581                	li	a1,0
    4b8c:	fbc40513          	addi	a0,s0,-68
    4b90:	00001097          	auipc	ra,0x1
    4b94:	330080e7          	jalr	816(ra) # 5ec0 <wait>
  if(xstatus != -1 && xstatus != 2)
    4b98:	fbc42783          	lw	a5,-68(s0)
    4b9c:	577d                	li	a4,-1
    4b9e:	00e78563          	beq	a5,a4,4ba8 <sbrkfail+0x11c>
    4ba2:	4709                	li	a4,2
    4ba4:	0ae79063          	bne	a5,a4,4c44 <sbrkfail+0x1b8>
}
    4ba8:	70e6                	ld	ra,120(sp)
    4baa:	7446                	ld	s0,112(sp)
    4bac:	74a6                	ld	s1,104(sp)
    4bae:	7906                	ld	s2,96(sp)
    4bb0:	69e6                	ld	s3,88(sp)
    4bb2:	6a46                	ld	s4,80(sp)
    4bb4:	6aa6                	ld	s5,72(sp)
    4bb6:	6109                	addi	sp,sp,128
    4bb8:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    4bba:	85d6                	mv	a1,s5
    4bbc:	00003517          	auipc	a0,0x3
    4bc0:	46450513          	addi	a0,a0,1124 # 8020 <malloc+0x1d2a>
    4bc4:	00001097          	auipc	ra,0x1
    4bc8:	674080e7          	jalr	1652(ra) # 6238 <printf>
    exit(1,0);
    4bcc:	4581                	li	a1,0
    4bce:	4505                	li	a0,1
    4bd0:	00001097          	auipc	ra,0x1
    4bd4:	2e8080e7          	jalr	744(ra) # 5eb8 <exit>
    printf("%s: fork failed\n", s);
    4bd8:	85d6                	mv	a1,s5
    4bda:	00002517          	auipc	a0,0x2
    4bde:	0e650513          	addi	a0,a0,230 # 6cc0 <malloc+0x9ca>
    4be2:	00001097          	auipc	ra,0x1
    4be6:	656080e7          	jalr	1622(ra) # 6238 <printf>
    exit(1,0);
    4bea:	4581                	li	a1,0
    4bec:	4505                	li	a0,1
    4bee:	00001097          	auipc	ra,0x1
    4bf2:	2ca080e7          	jalr	714(ra) # 5eb8 <exit>
    a = sbrk(0);
    4bf6:	4501                	li	a0,0
    4bf8:	00001097          	auipc	ra,0x1
    4bfc:	348080e7          	jalr	840(ra) # 5f40 <sbrk>
    4c00:	892a                	mv	s2,a0
    sbrk(10*BIG);
    4c02:	3e800537          	lui	a0,0x3e800
    4c06:	00001097          	auipc	ra,0x1
    4c0a:	33a080e7          	jalr	826(ra) # 5f40 <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    4c0e:	87ca                	mv	a5,s2
    4c10:	3e800737          	lui	a4,0x3e800
    4c14:	993a                	add	s2,s2,a4
    4c16:	6705                	lui	a4,0x1
      n += *(a+i);
    4c18:	0007c683          	lbu	a3,0(a5) # 6400000 <base+0x63f0388>
    4c1c:	9cb5                	addw	s1,s1,a3
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    4c1e:	97ba                	add	a5,a5,a4
    4c20:	ff279ce3          	bne	a5,s2,4c18 <sbrkfail+0x18c>
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    4c24:	8626                	mv	a2,s1
    4c26:	85d6                	mv	a1,s5
    4c28:	00003517          	auipc	a0,0x3
    4c2c:	41850513          	addi	a0,a0,1048 # 8040 <malloc+0x1d4a>
    4c30:	00001097          	auipc	ra,0x1
    4c34:	608080e7          	jalr	1544(ra) # 6238 <printf>
    exit(1,0);
    4c38:	4581                	li	a1,0
    4c3a:	4505                	li	a0,1
    4c3c:	00001097          	auipc	ra,0x1
    4c40:	27c080e7          	jalr	636(ra) # 5eb8 <exit>
    exit(1,0);
    4c44:	4581                	li	a1,0
    4c46:	4505                	li	a0,1
    4c48:	00001097          	auipc	ra,0x1
    4c4c:	270080e7          	jalr	624(ra) # 5eb8 <exit>

0000000000004c50 <mem>:
{
    4c50:	7139                	addi	sp,sp,-64
    4c52:	fc06                	sd	ra,56(sp)
    4c54:	f822                	sd	s0,48(sp)
    4c56:	f426                	sd	s1,40(sp)
    4c58:	f04a                	sd	s2,32(sp)
    4c5a:	ec4e                	sd	s3,24(sp)
    4c5c:	0080                	addi	s0,sp,64
    4c5e:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    4c60:	00001097          	auipc	ra,0x1
    4c64:	250080e7          	jalr	592(ra) # 5eb0 <fork>
    m1 = 0;
    4c68:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    4c6a:	6909                	lui	s2,0x2
    4c6c:	71190913          	addi	s2,s2,1809 # 2711 <manywrites+0x111>
  if((pid = fork()) == 0){
    4c70:	c505                	beqz	a0,4c98 <mem+0x48>
    wait(&xstatus,0);
    4c72:	4581                	li	a1,0
    4c74:	fcc40513          	addi	a0,s0,-52
    4c78:	00001097          	auipc	ra,0x1
    4c7c:	248080e7          	jalr	584(ra) # 5ec0 <wait>
    if(xstatus == -1){
    4c80:	fcc42503          	lw	a0,-52(s0)
    4c84:	57fd                	li	a5,-1
    4c86:	06f50663          	beq	a0,a5,4cf2 <mem+0xa2>
    exit(xstatus,0);
    4c8a:	4581                	li	a1,0
    4c8c:	00001097          	auipc	ra,0x1
    4c90:	22c080e7          	jalr	556(ra) # 5eb8 <exit>
      *(char**)m2 = m1;
    4c94:	e104                	sd	s1,0(a0)
      m1 = m2;
    4c96:	84aa                	mv	s1,a0
    while((m2 = malloc(10001)) != 0){
    4c98:	854a                	mv	a0,s2
    4c9a:	00001097          	auipc	ra,0x1
    4c9e:	65c080e7          	jalr	1628(ra) # 62f6 <malloc>
    4ca2:	f96d                	bnez	a0,4c94 <mem+0x44>
    while(m1){
    4ca4:	c881                	beqz	s1,4cb4 <mem+0x64>
      m2 = *(char**)m1;
    4ca6:	8526                	mv	a0,s1
    4ca8:	6084                	ld	s1,0(s1)
      free(m1);
    4caa:	00001097          	auipc	ra,0x1
    4cae:	5c4080e7          	jalr	1476(ra) # 626e <free>
    while(m1){
    4cb2:	f8f5                	bnez	s1,4ca6 <mem+0x56>
    m1 = malloc(1024*20);
    4cb4:	6515                	lui	a0,0x5
    4cb6:	00001097          	auipc	ra,0x1
    4cba:	640080e7          	jalr	1600(ra) # 62f6 <malloc>
    if(m1 == 0){
    4cbe:	c919                	beqz	a0,4cd4 <mem+0x84>
    free(m1);
    4cc0:	00001097          	auipc	ra,0x1
    4cc4:	5ae080e7          	jalr	1454(ra) # 626e <free>
    exit(0,0);
    4cc8:	4581                	li	a1,0
    4cca:	4501                	li	a0,0
    4ccc:	00001097          	auipc	ra,0x1
    4cd0:	1ec080e7          	jalr	492(ra) # 5eb8 <exit>
      printf("couldn't allocate mem?!!\n", s);
    4cd4:	85ce                	mv	a1,s3
    4cd6:	00003517          	auipc	a0,0x3
    4cda:	39a50513          	addi	a0,a0,922 # 8070 <malloc+0x1d7a>
    4cde:	00001097          	auipc	ra,0x1
    4ce2:	55a080e7          	jalr	1370(ra) # 6238 <printf>
      exit(1,0);
    4ce6:	4581                	li	a1,0
    4ce8:	4505                	li	a0,1
    4cea:	00001097          	auipc	ra,0x1
    4cee:	1ce080e7          	jalr	462(ra) # 5eb8 <exit>
      exit(0,0);
    4cf2:	4581                	li	a1,0
    4cf4:	4501                	li	a0,0
    4cf6:	00001097          	auipc	ra,0x1
    4cfa:	1c2080e7          	jalr	450(ra) # 5eb8 <exit>

0000000000004cfe <sharedfd>:
{
    4cfe:	7159                	addi	sp,sp,-112
    4d00:	f486                	sd	ra,104(sp)
    4d02:	f0a2                	sd	s0,96(sp)
    4d04:	eca6                	sd	s1,88(sp)
    4d06:	e8ca                	sd	s2,80(sp)
    4d08:	e4ce                	sd	s3,72(sp)
    4d0a:	e0d2                	sd	s4,64(sp)
    4d0c:	fc56                	sd	s5,56(sp)
    4d0e:	f85a                	sd	s6,48(sp)
    4d10:	f45e                	sd	s7,40(sp)
    4d12:	1880                	addi	s0,sp,112
    4d14:	8a2a                	mv	s4,a0
  unlink("sharedfd");
    4d16:	00003517          	auipc	a0,0x3
    4d1a:	37a50513          	addi	a0,a0,890 # 8090 <malloc+0x1d9a>
    4d1e:	00001097          	auipc	ra,0x1
    4d22:	1ea080e7          	jalr	490(ra) # 5f08 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    4d26:	20200593          	li	a1,514
    4d2a:	00003517          	auipc	a0,0x3
    4d2e:	36650513          	addi	a0,a0,870 # 8090 <malloc+0x1d9a>
    4d32:	00001097          	auipc	ra,0x1
    4d36:	1c6080e7          	jalr	454(ra) # 5ef8 <open>
  if(fd < 0){
    4d3a:	04054b63          	bltz	a0,4d90 <sharedfd+0x92>
    4d3e:	892a                	mv	s2,a0
  pid = fork();
    4d40:	00001097          	auipc	ra,0x1
    4d44:	170080e7          	jalr	368(ra) # 5eb0 <fork>
    4d48:	89aa                	mv	s3,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    4d4a:	06300593          	li	a1,99
    4d4e:	c119                	beqz	a0,4d54 <sharedfd+0x56>
    4d50:	07000593          	li	a1,112
    4d54:	4629                	li	a2,10
    4d56:	fa040513          	addi	a0,s0,-96
    4d5a:	00001097          	auipc	ra,0x1
    4d5e:	f62080e7          	jalr	-158(ra) # 5cbc <memset>
    4d62:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    4d66:	4629                	li	a2,10
    4d68:	fa040593          	addi	a1,s0,-96
    4d6c:	854a                	mv	a0,s2
    4d6e:	00001097          	auipc	ra,0x1
    4d72:	16a080e7          	jalr	362(ra) # 5ed8 <write>
    4d76:	47a9                	li	a5,10
    4d78:	02f51b63          	bne	a0,a5,4dae <sharedfd+0xb0>
  for(i = 0; i < N; i++){
    4d7c:	34fd                	addiw	s1,s1,-1
    4d7e:	f4e5                	bnez	s1,4d66 <sharedfd+0x68>
  if(pid == 0) {
    4d80:	04099663          	bnez	s3,4dcc <sharedfd+0xce>
    exit(0,0);
    4d84:	4581                	li	a1,0
    4d86:	4501                	li	a0,0
    4d88:	00001097          	auipc	ra,0x1
    4d8c:	130080e7          	jalr	304(ra) # 5eb8 <exit>
    printf("%s: cannot open sharedfd for writing", s);
    4d90:	85d2                	mv	a1,s4
    4d92:	00003517          	auipc	a0,0x3
    4d96:	30e50513          	addi	a0,a0,782 # 80a0 <malloc+0x1daa>
    4d9a:	00001097          	auipc	ra,0x1
    4d9e:	49e080e7          	jalr	1182(ra) # 6238 <printf>
    exit(1,0);
    4da2:	4581                	li	a1,0
    4da4:	4505                	li	a0,1
    4da6:	00001097          	auipc	ra,0x1
    4daa:	112080e7          	jalr	274(ra) # 5eb8 <exit>
      printf("%s: write sharedfd failed\n", s);
    4dae:	85d2                	mv	a1,s4
    4db0:	00003517          	auipc	a0,0x3
    4db4:	31850513          	addi	a0,a0,792 # 80c8 <malloc+0x1dd2>
    4db8:	00001097          	auipc	ra,0x1
    4dbc:	480080e7          	jalr	1152(ra) # 6238 <printf>
      exit(1,0);
    4dc0:	4581                	li	a1,0
    4dc2:	4505                	li	a0,1
    4dc4:	00001097          	auipc	ra,0x1
    4dc8:	0f4080e7          	jalr	244(ra) # 5eb8 <exit>
    wait(&xstatus,0);
    4dcc:	4581                	li	a1,0
    4dce:	f9c40513          	addi	a0,s0,-100
    4dd2:	00001097          	auipc	ra,0x1
    4dd6:	0ee080e7          	jalr	238(ra) # 5ec0 <wait>
    if(xstatus != 0)
    4dda:	f9c42983          	lw	s3,-100(s0)
    4dde:	00098863          	beqz	s3,4dee <sharedfd+0xf0>
      exit(xstatus,0);
    4de2:	4581                	li	a1,0
    4de4:	854e                	mv	a0,s3
    4de6:	00001097          	auipc	ra,0x1
    4dea:	0d2080e7          	jalr	210(ra) # 5eb8 <exit>
  close(fd);
    4dee:	854a                	mv	a0,s2
    4df0:	00001097          	auipc	ra,0x1
    4df4:	0f0080e7          	jalr	240(ra) # 5ee0 <close>
  fd = open("sharedfd", 0);
    4df8:	4581                	li	a1,0
    4dfa:	00003517          	auipc	a0,0x3
    4dfe:	29650513          	addi	a0,a0,662 # 8090 <malloc+0x1d9a>
    4e02:	00001097          	auipc	ra,0x1
    4e06:	0f6080e7          	jalr	246(ra) # 5ef8 <open>
    4e0a:	8baa                	mv	s7,a0
  nc = np = 0;
    4e0c:	8ace                	mv	s5,s3
  if(fd < 0){
    4e0e:	02054563          	bltz	a0,4e38 <sharedfd+0x13a>
    4e12:	faa40913          	addi	s2,s0,-86
      if(buf[i] == 'c')
    4e16:	06300493          	li	s1,99
      if(buf[i] == 'p')
    4e1a:	07000b13          	li	s6,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    4e1e:	4629                	li	a2,10
    4e20:	fa040593          	addi	a1,s0,-96
    4e24:	855e                	mv	a0,s7
    4e26:	00001097          	auipc	ra,0x1
    4e2a:	0aa080e7          	jalr	170(ra) # 5ed0 <read>
    4e2e:	04a05063          	blez	a0,4e6e <sharedfd+0x170>
    4e32:	fa040793          	addi	a5,s0,-96
    4e36:	a025                	j	4e5e <sharedfd+0x160>
    printf("%s: cannot open sharedfd for reading\n", s);
    4e38:	85d2                	mv	a1,s4
    4e3a:	00003517          	auipc	a0,0x3
    4e3e:	2ae50513          	addi	a0,a0,686 # 80e8 <malloc+0x1df2>
    4e42:	00001097          	auipc	ra,0x1
    4e46:	3f6080e7          	jalr	1014(ra) # 6238 <printf>
    exit(1,0);
    4e4a:	4581                	li	a1,0
    4e4c:	4505                	li	a0,1
    4e4e:	00001097          	auipc	ra,0x1
    4e52:	06a080e7          	jalr	106(ra) # 5eb8 <exit>
        nc++;
    4e56:	2985                	addiw	s3,s3,1
    for(i = 0; i < sizeof(buf); i++){
    4e58:	0785                	addi	a5,a5,1
    4e5a:	fd2782e3          	beq	a5,s2,4e1e <sharedfd+0x120>
      if(buf[i] == 'c')
    4e5e:	0007c703          	lbu	a4,0(a5)
    4e62:	fe970ae3          	beq	a4,s1,4e56 <sharedfd+0x158>
      if(buf[i] == 'p')
    4e66:	ff6719e3          	bne	a4,s6,4e58 <sharedfd+0x15a>
        np++;
    4e6a:	2a85                	addiw	s5,s5,1
    4e6c:	b7f5                	j	4e58 <sharedfd+0x15a>
  close(fd);
    4e6e:	855e                	mv	a0,s7
    4e70:	00001097          	auipc	ra,0x1
    4e74:	070080e7          	jalr	112(ra) # 5ee0 <close>
  unlink("sharedfd");
    4e78:	00003517          	auipc	a0,0x3
    4e7c:	21850513          	addi	a0,a0,536 # 8090 <malloc+0x1d9a>
    4e80:	00001097          	auipc	ra,0x1
    4e84:	088080e7          	jalr	136(ra) # 5f08 <unlink>
  if(nc == N*SZ && np == N*SZ){
    4e88:	6789                	lui	a5,0x2
    4e8a:	71078793          	addi	a5,a5,1808 # 2710 <manywrites+0x110>
    4e8e:	00f99763          	bne	s3,a5,4e9c <sharedfd+0x19e>
    4e92:	6789                	lui	a5,0x2
    4e94:	71078793          	addi	a5,a5,1808 # 2710 <manywrites+0x110>
    4e98:	02fa8163          	beq	s5,a5,4eba <sharedfd+0x1bc>
    printf("%s: nc/np test fails\n", s);
    4e9c:	85d2                	mv	a1,s4
    4e9e:	00003517          	auipc	a0,0x3
    4ea2:	27250513          	addi	a0,a0,626 # 8110 <malloc+0x1e1a>
    4ea6:	00001097          	auipc	ra,0x1
    4eaa:	392080e7          	jalr	914(ra) # 6238 <printf>
    exit(1,0);
    4eae:	4581                	li	a1,0
    4eb0:	4505                	li	a0,1
    4eb2:	00001097          	auipc	ra,0x1
    4eb6:	006080e7          	jalr	6(ra) # 5eb8 <exit>
    exit(0,0);
    4eba:	4581                	li	a1,0
    4ebc:	4501                	li	a0,0
    4ebe:	00001097          	auipc	ra,0x1
    4ec2:	ffa080e7          	jalr	-6(ra) # 5eb8 <exit>

0000000000004ec6 <fourfiles>:
{
    4ec6:	7171                	addi	sp,sp,-176
    4ec8:	f506                	sd	ra,168(sp)
    4eca:	f122                	sd	s0,160(sp)
    4ecc:	ed26                	sd	s1,152(sp)
    4ece:	e94a                	sd	s2,144(sp)
    4ed0:	e54e                	sd	s3,136(sp)
    4ed2:	e152                	sd	s4,128(sp)
    4ed4:	fcd6                	sd	s5,120(sp)
    4ed6:	f8da                	sd	s6,112(sp)
    4ed8:	f4de                	sd	s7,104(sp)
    4eda:	f0e2                	sd	s8,96(sp)
    4edc:	ece6                	sd	s9,88(sp)
    4ede:	e8ea                	sd	s10,80(sp)
    4ee0:	e4ee                	sd	s11,72(sp)
    4ee2:	1900                	addi	s0,sp,176
    4ee4:	f4a43c23          	sd	a0,-168(s0)
  char *names[] = { "f0", "f1", "f2", "f3" };
    4ee8:	00001797          	auipc	a5,0x1
    4eec:	4f878793          	addi	a5,a5,1272 # 63e0 <malloc+0xea>
    4ef0:	f6f43823          	sd	a5,-144(s0)
    4ef4:	00001797          	auipc	a5,0x1
    4ef8:	4f478793          	addi	a5,a5,1268 # 63e8 <malloc+0xf2>
    4efc:	f6f43c23          	sd	a5,-136(s0)
    4f00:	00001797          	auipc	a5,0x1
    4f04:	4f078793          	addi	a5,a5,1264 # 63f0 <malloc+0xfa>
    4f08:	f8f43023          	sd	a5,-128(s0)
    4f0c:	00001797          	auipc	a5,0x1
    4f10:	4ec78793          	addi	a5,a5,1260 # 63f8 <malloc+0x102>
    4f14:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    4f18:	f7040c13          	addi	s8,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    4f1c:	8962                	mv	s2,s8
  for(pi = 0; pi < NCHILD; pi++){
    4f1e:	4481                	li	s1,0
    4f20:	4a11                	li	s4,4
    fname = names[pi];
    4f22:	00093983          	ld	s3,0(s2)
    unlink(fname);
    4f26:	854e                	mv	a0,s3
    4f28:	00001097          	auipc	ra,0x1
    4f2c:	fe0080e7          	jalr	-32(ra) # 5f08 <unlink>
    pid = fork();
    4f30:	00001097          	auipc	ra,0x1
    4f34:	f80080e7          	jalr	-128(ra) # 5eb0 <fork>
    if(pid < 0){
    4f38:	04054563          	bltz	a0,4f82 <fourfiles+0xbc>
    if(pid == 0){
    4f3c:	c13d                	beqz	a0,4fa2 <fourfiles+0xdc>
  for(pi = 0; pi < NCHILD; pi++){
    4f3e:	2485                	addiw	s1,s1,1
    4f40:	0921                	addi	s2,s2,8
    4f42:	ff4490e3          	bne	s1,s4,4f22 <fourfiles+0x5c>
    4f46:	4491                	li	s1,4
    wait(&xstatus,0);
    4f48:	4581                	li	a1,0
    4f4a:	f6c40513          	addi	a0,s0,-148
    4f4e:	00001097          	auipc	ra,0x1
    4f52:	f72080e7          	jalr	-142(ra) # 5ec0 <wait>
    if(xstatus != 0)
    4f56:	f6c42b03          	lw	s6,-148(s0)
    4f5a:	0e0b1263          	bnez	s6,503e <fourfiles+0x178>
  for(pi = 0; pi < NCHILD; pi++){
    4f5e:	34fd                	addiw	s1,s1,-1
    4f60:	f4e5                	bnez	s1,4f48 <fourfiles+0x82>
    4f62:	03000b93          	li	s7,48
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4f66:	00008a17          	auipc	s4,0x8
    4f6a:	d12a0a13          	addi	s4,s4,-750 # cc78 <buf>
    4f6e:	00008a97          	auipc	s5,0x8
    4f72:	d0ba8a93          	addi	s5,s5,-757 # cc79 <buf+0x1>
    if(total != N*SZ){
    4f76:	6d85                	lui	s11,0x1
    4f78:	770d8d93          	addi	s11,s11,1904 # 1770 <truncate3+0x15e>
  for(i = 0; i < NCHILD; i++){
    4f7c:	03400d13          	li	s10,52
    4f80:	a289                	j	50c2 <fourfiles+0x1fc>
      printf("fork failed\n", s);
    4f82:	f5843583          	ld	a1,-168(s0)
    4f86:	00002517          	auipc	a0,0x2
    4f8a:	14250513          	addi	a0,a0,322 # 70c8 <malloc+0xdd2>
    4f8e:	00001097          	auipc	ra,0x1
    4f92:	2aa080e7          	jalr	682(ra) # 6238 <printf>
      exit(1,0);
    4f96:	4581                	li	a1,0
    4f98:	4505                	li	a0,1
    4f9a:	00001097          	auipc	ra,0x1
    4f9e:	f1e080e7          	jalr	-226(ra) # 5eb8 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    4fa2:	20200593          	li	a1,514
    4fa6:	854e                	mv	a0,s3
    4fa8:	00001097          	auipc	ra,0x1
    4fac:	f50080e7          	jalr	-176(ra) # 5ef8 <open>
    4fb0:	892a                	mv	s2,a0
      if(fd < 0){
    4fb2:	04054863          	bltz	a0,5002 <fourfiles+0x13c>
      memset(buf, '0'+pi, SZ);
    4fb6:	1f400613          	li	a2,500
    4fba:	0304859b          	addiw	a1,s1,48
    4fbe:	00008517          	auipc	a0,0x8
    4fc2:	cba50513          	addi	a0,a0,-838 # cc78 <buf>
    4fc6:	00001097          	auipc	ra,0x1
    4fca:	cf6080e7          	jalr	-778(ra) # 5cbc <memset>
    4fce:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    4fd0:	00008997          	auipc	s3,0x8
    4fd4:	ca898993          	addi	s3,s3,-856 # cc78 <buf>
    4fd8:	1f400613          	li	a2,500
    4fdc:	85ce                	mv	a1,s3
    4fde:	854a                	mv	a0,s2
    4fe0:	00001097          	auipc	ra,0x1
    4fe4:	ef8080e7          	jalr	-264(ra) # 5ed8 <write>
    4fe8:	85aa                	mv	a1,a0
    4fea:	1f400793          	li	a5,500
    4fee:	02f51a63          	bne	a0,a5,5022 <fourfiles+0x15c>
      for(i = 0; i < N; i++){
    4ff2:	34fd                	addiw	s1,s1,-1
    4ff4:	f0f5                	bnez	s1,4fd8 <fourfiles+0x112>
      exit(0,0);
    4ff6:	4581                	li	a1,0
    4ff8:	4501                	li	a0,0
    4ffa:	00001097          	auipc	ra,0x1
    4ffe:	ebe080e7          	jalr	-322(ra) # 5eb8 <exit>
        printf("create failed\n", s);
    5002:	f5843583          	ld	a1,-168(s0)
    5006:	00003517          	auipc	a0,0x3
    500a:	12250513          	addi	a0,a0,290 # 8128 <malloc+0x1e32>
    500e:	00001097          	auipc	ra,0x1
    5012:	22a080e7          	jalr	554(ra) # 6238 <printf>
        exit(1,0);
    5016:	4581                	li	a1,0
    5018:	4505                	li	a0,1
    501a:	00001097          	auipc	ra,0x1
    501e:	e9e080e7          	jalr	-354(ra) # 5eb8 <exit>
          printf("write failed %d\n", n);
    5022:	00003517          	auipc	a0,0x3
    5026:	11650513          	addi	a0,a0,278 # 8138 <malloc+0x1e42>
    502a:	00001097          	auipc	ra,0x1
    502e:	20e080e7          	jalr	526(ra) # 6238 <printf>
          exit(1,0);
    5032:	4581                	li	a1,0
    5034:	4505                	li	a0,1
    5036:	00001097          	auipc	ra,0x1
    503a:	e82080e7          	jalr	-382(ra) # 5eb8 <exit>
      exit(xstatus,0);
    503e:	4581                	li	a1,0
    5040:	855a                	mv	a0,s6
    5042:	00001097          	auipc	ra,0x1
    5046:	e76080e7          	jalr	-394(ra) # 5eb8 <exit>
          printf("wrong char\n", s);
    504a:	f5843583          	ld	a1,-168(s0)
    504e:	00003517          	auipc	a0,0x3
    5052:	10250513          	addi	a0,a0,258 # 8150 <malloc+0x1e5a>
    5056:	00001097          	auipc	ra,0x1
    505a:	1e2080e7          	jalr	482(ra) # 6238 <printf>
          exit(1,0);
    505e:	4581                	li	a1,0
    5060:	4505                	li	a0,1
    5062:	00001097          	auipc	ra,0x1
    5066:	e56080e7          	jalr	-426(ra) # 5eb8 <exit>
      total += n;
    506a:	00a9093b          	addw	s2,s2,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    506e:	660d                	lui	a2,0x3
    5070:	85d2                	mv	a1,s4
    5072:	854e                	mv	a0,s3
    5074:	00001097          	auipc	ra,0x1
    5078:	e5c080e7          	jalr	-420(ra) # 5ed0 <read>
    507c:	02a05363          	blez	a0,50a2 <fourfiles+0x1dc>
    5080:	00008797          	auipc	a5,0x8
    5084:	bf878793          	addi	a5,a5,-1032 # cc78 <buf>
    5088:	fff5069b          	addiw	a3,a0,-1
    508c:	1682                	slli	a3,a3,0x20
    508e:	9281                	srli	a3,a3,0x20
    5090:	96d6                	add	a3,a3,s5
        if(buf[j] != '0'+i){
    5092:	0007c703          	lbu	a4,0(a5)
    5096:	fa971ae3          	bne	a4,s1,504a <fourfiles+0x184>
      for(j = 0; j < n; j++){
    509a:	0785                	addi	a5,a5,1
    509c:	fed79be3          	bne	a5,a3,5092 <fourfiles+0x1cc>
    50a0:	b7e9                	j	506a <fourfiles+0x1a4>
    close(fd);
    50a2:	854e                	mv	a0,s3
    50a4:	00001097          	auipc	ra,0x1
    50a8:	e3c080e7          	jalr	-452(ra) # 5ee0 <close>
    if(total != N*SZ){
    50ac:	03b91863          	bne	s2,s11,50dc <fourfiles+0x216>
    unlink(fname);
    50b0:	8566                	mv	a0,s9
    50b2:	00001097          	auipc	ra,0x1
    50b6:	e56080e7          	jalr	-426(ra) # 5f08 <unlink>
  for(i = 0; i < NCHILD; i++){
    50ba:	0c21                	addi	s8,s8,8
    50bc:	2b85                	addiw	s7,s7,1
    50be:	03ab8e63          	beq	s7,s10,50fa <fourfiles+0x234>
    fname = names[i];
    50c2:	000c3c83          	ld	s9,0(s8)
    fd = open(fname, 0);
    50c6:	4581                	li	a1,0
    50c8:	8566                	mv	a0,s9
    50ca:	00001097          	auipc	ra,0x1
    50ce:	e2e080e7          	jalr	-466(ra) # 5ef8 <open>
    50d2:	89aa                	mv	s3,a0
    total = 0;
    50d4:	895a                	mv	s2,s6
        if(buf[j] != '0'+i){
    50d6:	000b849b          	sext.w	s1,s7
    while((n = read(fd, buf, sizeof(buf))) > 0){
    50da:	bf51                	j	506e <fourfiles+0x1a8>
      printf("wrong length %d\n", total);
    50dc:	85ca                	mv	a1,s2
    50de:	00003517          	auipc	a0,0x3
    50e2:	08250513          	addi	a0,a0,130 # 8160 <malloc+0x1e6a>
    50e6:	00001097          	auipc	ra,0x1
    50ea:	152080e7          	jalr	338(ra) # 6238 <printf>
      exit(1,0);
    50ee:	4581                	li	a1,0
    50f0:	4505                	li	a0,1
    50f2:	00001097          	auipc	ra,0x1
    50f6:	dc6080e7          	jalr	-570(ra) # 5eb8 <exit>
}
    50fa:	70aa                	ld	ra,168(sp)
    50fc:	740a                	ld	s0,160(sp)
    50fe:	64ea                	ld	s1,152(sp)
    5100:	694a                	ld	s2,144(sp)
    5102:	69aa                	ld	s3,136(sp)
    5104:	6a0a                	ld	s4,128(sp)
    5106:	7ae6                	ld	s5,120(sp)
    5108:	7b46                	ld	s6,112(sp)
    510a:	7ba6                	ld	s7,104(sp)
    510c:	7c06                	ld	s8,96(sp)
    510e:	6ce6                	ld	s9,88(sp)
    5110:	6d46                	ld	s10,80(sp)
    5112:	6da6                	ld	s11,72(sp)
    5114:	614d                	addi	sp,sp,176
    5116:	8082                	ret

0000000000005118 <concreate>:
{
    5118:	7135                	addi	sp,sp,-160
    511a:	ed06                	sd	ra,152(sp)
    511c:	e922                	sd	s0,144(sp)
    511e:	e526                	sd	s1,136(sp)
    5120:	e14a                	sd	s2,128(sp)
    5122:	fcce                	sd	s3,120(sp)
    5124:	f8d2                	sd	s4,112(sp)
    5126:	f4d6                	sd	s5,104(sp)
    5128:	f0da                	sd	s6,96(sp)
    512a:	ecde                	sd	s7,88(sp)
    512c:	1100                	addi	s0,sp,160
    512e:	89aa                	mv	s3,a0
  file[0] = 'C';
    5130:	04300793          	li	a5,67
    5134:	faf40423          	sb	a5,-88(s0)
  file[2] = '\0';
    5138:	fa040523          	sb	zero,-86(s0)
  for(i = 0; i < N; i++){
    513c:	4901                	li	s2,0
    if(pid && (i % 3) == 1){
    513e:	4b0d                	li	s6,3
    5140:	4a85                	li	s5,1
      link("C0", file);
    5142:	00003b97          	auipc	s7,0x3
    5146:	036b8b93          	addi	s7,s7,54 # 8178 <malloc+0x1e82>
  for(i = 0; i < N; i++){
    514a:	02800a13          	li	s4,40
    514e:	a4d5                	j	5432 <concreate+0x31a>
      link("C0", file);
    5150:	fa840593          	addi	a1,s0,-88
    5154:	855e                	mv	a0,s7
    5156:	00001097          	auipc	ra,0x1
    515a:	dc2080e7          	jalr	-574(ra) # 5f18 <link>
    if(pid == 0) {
    515e:	ac65                	j	5416 <concreate+0x2fe>
    } else if(pid == 0 && (i % 5) == 1){
    5160:	4795                	li	a5,5
    5162:	02f9693b          	remw	s2,s2,a5
    5166:	4785                	li	a5,1
    5168:	02f90c63          	beq	s2,a5,51a0 <concreate+0x88>
      fd = open(file, O_CREATE | O_RDWR);
    516c:	20200593          	li	a1,514
    5170:	fa840513          	addi	a0,s0,-88
    5174:	00001097          	auipc	ra,0x1
    5178:	d84080e7          	jalr	-636(ra) # 5ef8 <open>
      if(fd < 0){
    517c:	28055463          	bgez	a0,5404 <concreate+0x2ec>
        printf("concreate create %s failed\n", file);
    5180:	fa840593          	addi	a1,s0,-88
    5184:	00003517          	auipc	a0,0x3
    5188:	ffc50513          	addi	a0,a0,-4 # 8180 <malloc+0x1e8a>
    518c:	00001097          	auipc	ra,0x1
    5190:	0ac080e7          	jalr	172(ra) # 6238 <printf>
        exit(1,0);
    5194:	4581                	li	a1,0
    5196:	4505                	li	a0,1
    5198:	00001097          	auipc	ra,0x1
    519c:	d20080e7          	jalr	-736(ra) # 5eb8 <exit>
      link("C0", file);
    51a0:	fa840593          	addi	a1,s0,-88
    51a4:	00003517          	auipc	a0,0x3
    51a8:	fd450513          	addi	a0,a0,-44 # 8178 <malloc+0x1e82>
    51ac:	00001097          	auipc	ra,0x1
    51b0:	d6c080e7          	jalr	-660(ra) # 5f18 <link>
      exit(0,0);
    51b4:	4581                	li	a1,0
    51b6:	4501                	li	a0,0
    51b8:	00001097          	auipc	ra,0x1
    51bc:	d00080e7          	jalr	-768(ra) # 5eb8 <exit>
        exit(1,0);
    51c0:	4581                	li	a1,0
    51c2:	4505                	li	a0,1
    51c4:	00001097          	auipc	ra,0x1
    51c8:	cf4080e7          	jalr	-780(ra) # 5eb8 <exit>
  memset(fa, 0, sizeof(fa));
    51cc:	02800613          	li	a2,40
    51d0:	4581                	li	a1,0
    51d2:	f8040513          	addi	a0,s0,-128
    51d6:	00001097          	auipc	ra,0x1
    51da:	ae6080e7          	jalr	-1306(ra) # 5cbc <memset>
  fd = open(".", 0);
    51de:	4581                	li	a1,0
    51e0:	00002517          	auipc	a0,0x2
    51e4:	94050513          	addi	a0,a0,-1728 # 6b20 <malloc+0x82a>
    51e8:	00001097          	auipc	ra,0x1
    51ec:	d10080e7          	jalr	-752(ra) # 5ef8 <open>
    51f0:	892a                	mv	s2,a0
  n = 0;
    51f2:	8aa6                	mv	s5,s1
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    51f4:	04300a13          	li	s4,67
      if(i < 0 || i >= sizeof(fa)){
    51f8:	02700b13          	li	s6,39
      fa[i] = 1;
    51fc:	4b85                	li	s7,1
  while(read(fd, &de, sizeof(de)) > 0){
    51fe:	4641                	li	a2,16
    5200:	f7040593          	addi	a1,s0,-144
    5204:	854a                	mv	a0,s2
    5206:	00001097          	auipc	ra,0x1
    520a:	cca080e7          	jalr	-822(ra) # 5ed0 <read>
    520e:	08a05363          	blez	a0,5294 <concreate+0x17c>
    if(de.inum == 0)
    5212:	f7045783          	lhu	a5,-144(s0)
    5216:	d7e5                	beqz	a5,51fe <concreate+0xe6>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    5218:	f7244783          	lbu	a5,-142(s0)
    521c:	ff4791e3          	bne	a5,s4,51fe <concreate+0xe6>
    5220:	f7444783          	lbu	a5,-140(s0)
    5224:	ffe9                	bnez	a5,51fe <concreate+0xe6>
      i = de.name[1] - '0';
    5226:	f7344783          	lbu	a5,-141(s0)
    522a:	fd07879b          	addiw	a5,a5,-48
    522e:	0007871b          	sext.w	a4,a5
      if(i < 0 || i >= sizeof(fa)){
    5232:	00eb6f63          	bltu	s6,a4,5250 <concreate+0x138>
      if(fa[i]){
    5236:	fb040793          	addi	a5,s0,-80
    523a:	97ba                	add	a5,a5,a4
    523c:	fd07c783          	lbu	a5,-48(a5)
    5240:	eb8d                	bnez	a5,5272 <concreate+0x15a>
      fa[i] = 1;
    5242:	fb040793          	addi	a5,s0,-80
    5246:	973e                	add	a4,a4,a5
    5248:	fd770823          	sb	s7,-48(a4) # fd0 <linktest+0x80>
      n++;
    524c:	2a85                	addiw	s5,s5,1
    524e:	bf45                	j	51fe <concreate+0xe6>
        printf("%s: concreate weird file %s\n", s, de.name);
    5250:	f7240613          	addi	a2,s0,-142
    5254:	85ce                	mv	a1,s3
    5256:	00003517          	auipc	a0,0x3
    525a:	f4a50513          	addi	a0,a0,-182 # 81a0 <malloc+0x1eaa>
    525e:	00001097          	auipc	ra,0x1
    5262:	fda080e7          	jalr	-38(ra) # 6238 <printf>
        exit(1,0);
    5266:	4581                	li	a1,0
    5268:	4505                	li	a0,1
    526a:	00001097          	auipc	ra,0x1
    526e:	c4e080e7          	jalr	-946(ra) # 5eb8 <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    5272:	f7240613          	addi	a2,s0,-142
    5276:	85ce                	mv	a1,s3
    5278:	00003517          	auipc	a0,0x3
    527c:	f4850513          	addi	a0,a0,-184 # 81c0 <malloc+0x1eca>
    5280:	00001097          	auipc	ra,0x1
    5284:	fb8080e7          	jalr	-72(ra) # 6238 <printf>
        exit(1,0);
    5288:	4581                	li	a1,0
    528a:	4505                	li	a0,1
    528c:	00001097          	auipc	ra,0x1
    5290:	c2c080e7          	jalr	-980(ra) # 5eb8 <exit>
  close(fd);
    5294:	854a                	mv	a0,s2
    5296:	00001097          	auipc	ra,0x1
    529a:	c4a080e7          	jalr	-950(ra) # 5ee0 <close>
  if(n != N){
    529e:	02800793          	li	a5,40
    52a2:	00fa9763          	bne	s5,a5,52b0 <concreate+0x198>
    if(((i % 3) == 0 && pid == 0) ||
    52a6:	4a8d                	li	s5,3
    52a8:	4b05                	li	s6,1
  for(i = 0; i < N; i++){
    52aa:	02800a13          	li	s4,40
    52ae:	a8e1                	j	5386 <concreate+0x26e>
    printf("%s: concreate not enough files in directory listing\n", s);
    52b0:	85ce                	mv	a1,s3
    52b2:	00003517          	auipc	a0,0x3
    52b6:	f3650513          	addi	a0,a0,-202 # 81e8 <malloc+0x1ef2>
    52ba:	00001097          	auipc	ra,0x1
    52be:	f7e080e7          	jalr	-130(ra) # 6238 <printf>
    exit(1,0);
    52c2:	4581                	li	a1,0
    52c4:	4505                	li	a0,1
    52c6:	00001097          	auipc	ra,0x1
    52ca:	bf2080e7          	jalr	-1038(ra) # 5eb8 <exit>
      printf("%s: fork failed\n", s);
    52ce:	85ce                	mv	a1,s3
    52d0:	00002517          	auipc	a0,0x2
    52d4:	9f050513          	addi	a0,a0,-1552 # 6cc0 <malloc+0x9ca>
    52d8:	00001097          	auipc	ra,0x1
    52dc:	f60080e7          	jalr	-160(ra) # 6238 <printf>
      exit(1,0);
    52e0:	4581                	li	a1,0
    52e2:	4505                	li	a0,1
    52e4:	00001097          	auipc	ra,0x1
    52e8:	bd4080e7          	jalr	-1068(ra) # 5eb8 <exit>
      close(open(file, 0));
    52ec:	4581                	li	a1,0
    52ee:	fa840513          	addi	a0,s0,-88
    52f2:	00001097          	auipc	ra,0x1
    52f6:	c06080e7          	jalr	-1018(ra) # 5ef8 <open>
    52fa:	00001097          	auipc	ra,0x1
    52fe:	be6080e7          	jalr	-1050(ra) # 5ee0 <close>
      close(open(file, 0));
    5302:	4581                	li	a1,0
    5304:	fa840513          	addi	a0,s0,-88
    5308:	00001097          	auipc	ra,0x1
    530c:	bf0080e7          	jalr	-1040(ra) # 5ef8 <open>
    5310:	00001097          	auipc	ra,0x1
    5314:	bd0080e7          	jalr	-1072(ra) # 5ee0 <close>
      close(open(file, 0));
    5318:	4581                	li	a1,0
    531a:	fa840513          	addi	a0,s0,-88
    531e:	00001097          	auipc	ra,0x1
    5322:	bda080e7          	jalr	-1062(ra) # 5ef8 <open>
    5326:	00001097          	auipc	ra,0x1
    532a:	bba080e7          	jalr	-1094(ra) # 5ee0 <close>
      close(open(file, 0));
    532e:	4581                	li	a1,0
    5330:	fa840513          	addi	a0,s0,-88
    5334:	00001097          	auipc	ra,0x1
    5338:	bc4080e7          	jalr	-1084(ra) # 5ef8 <open>
    533c:	00001097          	auipc	ra,0x1
    5340:	ba4080e7          	jalr	-1116(ra) # 5ee0 <close>
      close(open(file, 0));
    5344:	4581                	li	a1,0
    5346:	fa840513          	addi	a0,s0,-88
    534a:	00001097          	auipc	ra,0x1
    534e:	bae080e7          	jalr	-1106(ra) # 5ef8 <open>
    5352:	00001097          	auipc	ra,0x1
    5356:	b8e080e7          	jalr	-1138(ra) # 5ee0 <close>
      close(open(file, 0));
    535a:	4581                	li	a1,0
    535c:	fa840513          	addi	a0,s0,-88
    5360:	00001097          	auipc	ra,0x1
    5364:	b98080e7          	jalr	-1128(ra) # 5ef8 <open>
    5368:	00001097          	auipc	ra,0x1
    536c:	b78080e7          	jalr	-1160(ra) # 5ee0 <close>
    if(pid == 0)
    5370:	08090463          	beqz	s2,53f8 <concreate+0x2e0>
      wait(0,0);
    5374:	4581                	li	a1,0
    5376:	4501                	li	a0,0
    5378:	00001097          	auipc	ra,0x1
    537c:	b48080e7          	jalr	-1208(ra) # 5ec0 <wait>
  for(i = 0; i < N; i++){
    5380:	2485                	addiw	s1,s1,1
    5382:	0f448763          	beq	s1,s4,5470 <concreate+0x358>
    file[1] = '0' + i;
    5386:	0304879b          	addiw	a5,s1,48
    538a:	faf404a3          	sb	a5,-87(s0)
    pid = fork();
    538e:	00001097          	auipc	ra,0x1
    5392:	b22080e7          	jalr	-1246(ra) # 5eb0 <fork>
    5396:	892a                	mv	s2,a0
    if(pid < 0){
    5398:	f2054be3          	bltz	a0,52ce <concreate+0x1b6>
    if(((i % 3) == 0 && pid == 0) ||
    539c:	0354e73b          	remw	a4,s1,s5
    53a0:	00a767b3          	or	a5,a4,a0
    53a4:	2781                	sext.w	a5,a5
    53a6:	d3b9                	beqz	a5,52ec <concreate+0x1d4>
    53a8:	01671363          	bne	a4,s6,53ae <concreate+0x296>
       ((i % 3) == 1 && pid != 0)){
    53ac:	f121                	bnez	a0,52ec <concreate+0x1d4>
      unlink(file);
    53ae:	fa840513          	addi	a0,s0,-88
    53b2:	00001097          	auipc	ra,0x1
    53b6:	b56080e7          	jalr	-1194(ra) # 5f08 <unlink>
      unlink(file);
    53ba:	fa840513          	addi	a0,s0,-88
    53be:	00001097          	auipc	ra,0x1
    53c2:	b4a080e7          	jalr	-1206(ra) # 5f08 <unlink>
      unlink(file);
    53c6:	fa840513          	addi	a0,s0,-88
    53ca:	00001097          	auipc	ra,0x1
    53ce:	b3e080e7          	jalr	-1218(ra) # 5f08 <unlink>
      unlink(file);
    53d2:	fa840513          	addi	a0,s0,-88
    53d6:	00001097          	auipc	ra,0x1
    53da:	b32080e7          	jalr	-1230(ra) # 5f08 <unlink>
      unlink(file);
    53de:	fa840513          	addi	a0,s0,-88
    53e2:	00001097          	auipc	ra,0x1
    53e6:	b26080e7          	jalr	-1242(ra) # 5f08 <unlink>
      unlink(file);
    53ea:	fa840513          	addi	a0,s0,-88
    53ee:	00001097          	auipc	ra,0x1
    53f2:	b1a080e7          	jalr	-1254(ra) # 5f08 <unlink>
    53f6:	bfad                	j	5370 <concreate+0x258>
      exit(0,0);
    53f8:	4581                	li	a1,0
    53fa:	4501                	li	a0,0
    53fc:	00001097          	auipc	ra,0x1
    5400:	abc080e7          	jalr	-1348(ra) # 5eb8 <exit>
      close(fd);
    5404:	00001097          	auipc	ra,0x1
    5408:	adc080e7          	jalr	-1316(ra) # 5ee0 <close>
    if(pid == 0) {
    540c:	b365                	j	51b4 <concreate+0x9c>
      close(fd);
    540e:	00001097          	auipc	ra,0x1
    5412:	ad2080e7          	jalr	-1326(ra) # 5ee0 <close>
      wait(&xstatus,0);
    5416:	4581                	li	a1,0
    5418:	f6c40513          	addi	a0,s0,-148
    541c:	00001097          	auipc	ra,0x1
    5420:	aa4080e7          	jalr	-1372(ra) # 5ec0 <wait>
      if(xstatus != 0)
    5424:	f6c42483          	lw	s1,-148(s0)
    5428:	d8049ce3          	bnez	s1,51c0 <concreate+0xa8>
  for(i = 0; i < N; i++){
    542c:	2905                	addiw	s2,s2,1
    542e:	d9490fe3          	beq	s2,s4,51cc <concreate+0xb4>
    file[1] = '0' + i;
    5432:	0309079b          	addiw	a5,s2,48
    5436:	faf404a3          	sb	a5,-87(s0)
    unlink(file);
    543a:	fa840513          	addi	a0,s0,-88
    543e:	00001097          	auipc	ra,0x1
    5442:	aca080e7          	jalr	-1334(ra) # 5f08 <unlink>
    pid = fork();
    5446:	00001097          	auipc	ra,0x1
    544a:	a6a080e7          	jalr	-1430(ra) # 5eb0 <fork>
    if(pid && (i % 3) == 1){
    544e:	d00509e3          	beqz	a0,5160 <concreate+0x48>
    5452:	036967bb          	remw	a5,s2,s6
    5456:	cf578de3          	beq	a5,s5,5150 <concreate+0x38>
      fd = open(file, O_CREATE | O_RDWR);
    545a:	20200593          	li	a1,514
    545e:	fa840513          	addi	a0,s0,-88
    5462:	00001097          	auipc	ra,0x1
    5466:	a96080e7          	jalr	-1386(ra) # 5ef8 <open>
      if(fd < 0){
    546a:	fa0552e3          	bgez	a0,540e <concreate+0x2f6>
    546e:	bb09                	j	5180 <concreate+0x68>
}
    5470:	60ea                	ld	ra,152(sp)
    5472:	644a                	ld	s0,144(sp)
    5474:	64aa                	ld	s1,136(sp)
    5476:	690a                	ld	s2,128(sp)
    5478:	79e6                	ld	s3,120(sp)
    547a:	7a46                	ld	s4,112(sp)
    547c:	7aa6                	ld	s5,104(sp)
    547e:	7b06                	ld	s6,96(sp)
    5480:	6be6                	ld	s7,88(sp)
    5482:	610d                	addi	sp,sp,160
    5484:	8082                	ret

0000000000005486 <bigfile>:
{
    5486:	7139                	addi	sp,sp,-64
    5488:	fc06                	sd	ra,56(sp)
    548a:	f822                	sd	s0,48(sp)
    548c:	f426                	sd	s1,40(sp)
    548e:	f04a                	sd	s2,32(sp)
    5490:	ec4e                	sd	s3,24(sp)
    5492:	e852                	sd	s4,16(sp)
    5494:	e456                	sd	s5,8(sp)
    5496:	0080                	addi	s0,sp,64
    5498:	8aaa                	mv	s5,a0
  unlink("bigfile.dat");
    549a:	00003517          	auipc	a0,0x3
    549e:	d8650513          	addi	a0,a0,-634 # 8220 <malloc+0x1f2a>
    54a2:	00001097          	auipc	ra,0x1
    54a6:	a66080e7          	jalr	-1434(ra) # 5f08 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    54aa:	20200593          	li	a1,514
    54ae:	00003517          	auipc	a0,0x3
    54b2:	d7250513          	addi	a0,a0,-654 # 8220 <malloc+0x1f2a>
    54b6:	00001097          	auipc	ra,0x1
    54ba:	a42080e7          	jalr	-1470(ra) # 5ef8 <open>
    54be:	89aa                	mv	s3,a0
  for(i = 0; i < N; i++){
    54c0:	4481                	li	s1,0
    memset(buf, i, SZ);
    54c2:	00007917          	auipc	s2,0x7
    54c6:	7b690913          	addi	s2,s2,1974 # cc78 <buf>
  for(i = 0; i < N; i++){
    54ca:	4a51                	li	s4,20
  if(fd < 0){
    54cc:	0a054063          	bltz	a0,556c <bigfile+0xe6>
    memset(buf, i, SZ);
    54d0:	25800613          	li	a2,600
    54d4:	85a6                	mv	a1,s1
    54d6:	854a                	mv	a0,s2
    54d8:	00000097          	auipc	ra,0x0
    54dc:	7e4080e7          	jalr	2020(ra) # 5cbc <memset>
    if(write(fd, buf, SZ) != SZ){
    54e0:	25800613          	li	a2,600
    54e4:	85ca                	mv	a1,s2
    54e6:	854e                	mv	a0,s3
    54e8:	00001097          	auipc	ra,0x1
    54ec:	9f0080e7          	jalr	-1552(ra) # 5ed8 <write>
    54f0:	25800793          	li	a5,600
    54f4:	08f51b63          	bne	a0,a5,558a <bigfile+0x104>
  for(i = 0; i < N; i++){
    54f8:	2485                	addiw	s1,s1,1
    54fa:	fd449be3          	bne	s1,s4,54d0 <bigfile+0x4a>
  close(fd);
    54fe:	854e                	mv	a0,s3
    5500:	00001097          	auipc	ra,0x1
    5504:	9e0080e7          	jalr	-1568(ra) # 5ee0 <close>
  fd = open("bigfile.dat", 0);
    5508:	4581                	li	a1,0
    550a:	00003517          	auipc	a0,0x3
    550e:	d1650513          	addi	a0,a0,-746 # 8220 <malloc+0x1f2a>
    5512:	00001097          	auipc	ra,0x1
    5516:	9e6080e7          	jalr	-1562(ra) # 5ef8 <open>
    551a:	8a2a                	mv	s4,a0
  total = 0;
    551c:	4981                	li	s3,0
  for(i = 0; ; i++){
    551e:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    5520:	00007917          	auipc	s2,0x7
    5524:	75890913          	addi	s2,s2,1880 # cc78 <buf>
  if(fd < 0){
    5528:	08054063          	bltz	a0,55a8 <bigfile+0x122>
    cc = read(fd, buf, SZ/2);
    552c:	12c00613          	li	a2,300
    5530:	85ca                	mv	a1,s2
    5532:	8552                	mv	a0,s4
    5534:	00001097          	auipc	ra,0x1
    5538:	99c080e7          	jalr	-1636(ra) # 5ed0 <read>
    if(cc < 0){
    553c:	08054563          	bltz	a0,55c6 <bigfile+0x140>
    if(cc == 0)
    5540:	c165                	beqz	a0,5620 <bigfile+0x19a>
    if(cc != SZ/2){
    5542:	12c00793          	li	a5,300
    5546:	08f51f63          	bne	a0,a5,55e4 <bigfile+0x15e>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    554a:	01f4d79b          	srliw	a5,s1,0x1f
    554e:	9fa5                	addw	a5,a5,s1
    5550:	4017d79b          	sraiw	a5,a5,0x1
    5554:	00094703          	lbu	a4,0(s2)
    5558:	0af71563          	bne	a4,a5,5602 <bigfile+0x17c>
    555c:	12b94703          	lbu	a4,299(s2)
    5560:	0af71163          	bne	a4,a5,5602 <bigfile+0x17c>
    total += cc;
    5564:	12c9899b          	addiw	s3,s3,300
  for(i = 0; ; i++){
    5568:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    556a:	b7c9                	j	552c <bigfile+0xa6>
    printf("%s: cannot create bigfile", s);
    556c:	85d6                	mv	a1,s5
    556e:	00003517          	auipc	a0,0x3
    5572:	cc250513          	addi	a0,a0,-830 # 8230 <malloc+0x1f3a>
    5576:	00001097          	auipc	ra,0x1
    557a:	cc2080e7          	jalr	-830(ra) # 6238 <printf>
    exit(1,0);
    557e:	4581                	li	a1,0
    5580:	4505                	li	a0,1
    5582:	00001097          	auipc	ra,0x1
    5586:	936080e7          	jalr	-1738(ra) # 5eb8 <exit>
      printf("%s: write bigfile failed\n", s);
    558a:	85d6                	mv	a1,s5
    558c:	00003517          	auipc	a0,0x3
    5590:	cc450513          	addi	a0,a0,-828 # 8250 <malloc+0x1f5a>
    5594:	00001097          	auipc	ra,0x1
    5598:	ca4080e7          	jalr	-860(ra) # 6238 <printf>
      exit(1,0);
    559c:	4581                	li	a1,0
    559e:	4505                	li	a0,1
    55a0:	00001097          	auipc	ra,0x1
    55a4:	918080e7          	jalr	-1768(ra) # 5eb8 <exit>
    printf("%s: cannot open bigfile\n", s);
    55a8:	85d6                	mv	a1,s5
    55aa:	00003517          	auipc	a0,0x3
    55ae:	cc650513          	addi	a0,a0,-826 # 8270 <malloc+0x1f7a>
    55b2:	00001097          	auipc	ra,0x1
    55b6:	c86080e7          	jalr	-890(ra) # 6238 <printf>
    exit(1,0);
    55ba:	4581                	li	a1,0
    55bc:	4505                	li	a0,1
    55be:	00001097          	auipc	ra,0x1
    55c2:	8fa080e7          	jalr	-1798(ra) # 5eb8 <exit>
      printf("%s: read bigfile failed\n", s);
    55c6:	85d6                	mv	a1,s5
    55c8:	00003517          	auipc	a0,0x3
    55cc:	cc850513          	addi	a0,a0,-824 # 8290 <malloc+0x1f9a>
    55d0:	00001097          	auipc	ra,0x1
    55d4:	c68080e7          	jalr	-920(ra) # 6238 <printf>
      exit(1,0);
    55d8:	4581                	li	a1,0
    55da:	4505                	li	a0,1
    55dc:	00001097          	auipc	ra,0x1
    55e0:	8dc080e7          	jalr	-1828(ra) # 5eb8 <exit>
      printf("%s: short read bigfile\n", s);
    55e4:	85d6                	mv	a1,s5
    55e6:	00003517          	auipc	a0,0x3
    55ea:	cca50513          	addi	a0,a0,-822 # 82b0 <malloc+0x1fba>
    55ee:	00001097          	auipc	ra,0x1
    55f2:	c4a080e7          	jalr	-950(ra) # 6238 <printf>
      exit(1,0);
    55f6:	4581                	li	a1,0
    55f8:	4505                	li	a0,1
    55fa:	00001097          	auipc	ra,0x1
    55fe:	8be080e7          	jalr	-1858(ra) # 5eb8 <exit>
      printf("%s: read bigfile wrong data\n", s);
    5602:	85d6                	mv	a1,s5
    5604:	00003517          	auipc	a0,0x3
    5608:	cc450513          	addi	a0,a0,-828 # 82c8 <malloc+0x1fd2>
    560c:	00001097          	auipc	ra,0x1
    5610:	c2c080e7          	jalr	-980(ra) # 6238 <printf>
      exit(1,0);
    5614:	4581                	li	a1,0
    5616:	4505                	li	a0,1
    5618:	00001097          	auipc	ra,0x1
    561c:	8a0080e7          	jalr	-1888(ra) # 5eb8 <exit>
  close(fd);
    5620:	8552                	mv	a0,s4
    5622:	00001097          	auipc	ra,0x1
    5626:	8be080e7          	jalr	-1858(ra) # 5ee0 <close>
  if(total != N*SZ){
    562a:	678d                	lui	a5,0x3
    562c:	ee078793          	addi	a5,a5,-288 # 2ee0 <sbrkbugs+0x12>
    5630:	02f99363          	bne	s3,a5,5656 <bigfile+0x1d0>
  unlink("bigfile.dat");
    5634:	00003517          	auipc	a0,0x3
    5638:	bec50513          	addi	a0,a0,-1044 # 8220 <malloc+0x1f2a>
    563c:	00001097          	auipc	ra,0x1
    5640:	8cc080e7          	jalr	-1844(ra) # 5f08 <unlink>
}
    5644:	70e2                	ld	ra,56(sp)
    5646:	7442                	ld	s0,48(sp)
    5648:	74a2                	ld	s1,40(sp)
    564a:	7902                	ld	s2,32(sp)
    564c:	69e2                	ld	s3,24(sp)
    564e:	6a42                	ld	s4,16(sp)
    5650:	6aa2                	ld	s5,8(sp)
    5652:	6121                	addi	sp,sp,64
    5654:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    5656:	85d6                	mv	a1,s5
    5658:	00003517          	auipc	a0,0x3
    565c:	c9050513          	addi	a0,a0,-880 # 82e8 <malloc+0x1ff2>
    5660:	00001097          	auipc	ra,0x1
    5664:	bd8080e7          	jalr	-1064(ra) # 6238 <printf>
    exit(1,0);
    5668:	4581                	li	a1,0
    566a:	4505                	li	a0,1
    566c:	00001097          	auipc	ra,0x1
    5670:	84c080e7          	jalr	-1972(ra) # 5eb8 <exit>

0000000000005674 <fsfull>:
{
    5674:	7171                	addi	sp,sp,-176
    5676:	f506                	sd	ra,168(sp)
    5678:	f122                	sd	s0,160(sp)
    567a:	ed26                	sd	s1,152(sp)
    567c:	e94a                	sd	s2,144(sp)
    567e:	e54e                	sd	s3,136(sp)
    5680:	e152                	sd	s4,128(sp)
    5682:	fcd6                	sd	s5,120(sp)
    5684:	f8da                	sd	s6,112(sp)
    5686:	f4de                	sd	s7,104(sp)
    5688:	f0e2                	sd	s8,96(sp)
    568a:	ece6                	sd	s9,88(sp)
    568c:	e8ea                	sd	s10,80(sp)
    568e:	e4ee                	sd	s11,72(sp)
    5690:	1900                	addi	s0,sp,176
  printf("fsfull test\n");
    5692:	00003517          	auipc	a0,0x3
    5696:	c7650513          	addi	a0,a0,-906 # 8308 <malloc+0x2012>
    569a:	00001097          	auipc	ra,0x1
    569e:	b9e080e7          	jalr	-1122(ra) # 6238 <printf>
  for(nfiles = 0; ; nfiles++){
    56a2:	4481                	li	s1,0
    name[0] = 'f';
    56a4:	06600d13          	li	s10,102
    name[1] = '0' + nfiles / 1000;
    56a8:	3e800c13          	li	s8,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    56ac:	06400b93          	li	s7,100
    name[3] = '0' + (nfiles % 100) / 10;
    56b0:	4b29                	li	s6,10
    printf("writing %s\n", name);
    56b2:	00003c97          	auipc	s9,0x3
    56b6:	c66c8c93          	addi	s9,s9,-922 # 8318 <malloc+0x2022>
    int total = 0;
    56ba:	4d81                	li	s11,0
      int cc = write(fd, buf, BSIZE);
    56bc:	00007a17          	auipc	s4,0x7
    56c0:	5bca0a13          	addi	s4,s4,1468 # cc78 <buf>
    name[0] = 'f';
    56c4:	f5a40823          	sb	s10,-176(s0)
    name[1] = '0' + nfiles / 1000;
    56c8:	0384c7bb          	divw	a5,s1,s8
    56cc:	0307879b          	addiw	a5,a5,48
    56d0:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    56d4:	0384e7bb          	remw	a5,s1,s8
    56d8:	0377c7bb          	divw	a5,a5,s7
    56dc:	0307879b          	addiw	a5,a5,48
    56e0:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    56e4:	0374e7bb          	remw	a5,s1,s7
    56e8:	0367c7bb          	divw	a5,a5,s6
    56ec:	0307879b          	addiw	a5,a5,48
    56f0:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    56f4:	0364e7bb          	remw	a5,s1,s6
    56f8:	0307879b          	addiw	a5,a5,48
    56fc:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    5700:	f4040aa3          	sb	zero,-171(s0)
    printf("writing %s\n", name);
    5704:	f5040593          	addi	a1,s0,-176
    5708:	8566                	mv	a0,s9
    570a:	00001097          	auipc	ra,0x1
    570e:	b2e080e7          	jalr	-1234(ra) # 6238 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    5712:	20200593          	li	a1,514
    5716:	f5040513          	addi	a0,s0,-176
    571a:	00000097          	auipc	ra,0x0
    571e:	7de080e7          	jalr	2014(ra) # 5ef8 <open>
    5722:	892a                	mv	s2,a0
    if(fd < 0){
    5724:	0a055663          	bgez	a0,57d0 <fsfull+0x15c>
      printf("open %s failed\n", name);
    5728:	f5040593          	addi	a1,s0,-176
    572c:	00003517          	auipc	a0,0x3
    5730:	bfc50513          	addi	a0,a0,-1028 # 8328 <malloc+0x2032>
    5734:	00001097          	auipc	ra,0x1
    5738:	b04080e7          	jalr	-1276(ra) # 6238 <printf>
  while(nfiles >= 0){
    573c:	0604c363          	bltz	s1,57a2 <fsfull+0x12e>
    name[0] = 'f';
    5740:	06600b13          	li	s6,102
    name[1] = '0' + nfiles / 1000;
    5744:	3e800a13          	li	s4,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    5748:	06400993          	li	s3,100
    name[3] = '0' + (nfiles % 100) / 10;
    574c:	4929                	li	s2,10
  while(nfiles >= 0){
    574e:	5afd                	li	s5,-1
    name[0] = 'f';
    5750:	f5640823          	sb	s6,-176(s0)
    name[1] = '0' + nfiles / 1000;
    5754:	0344c7bb          	divw	a5,s1,s4
    5758:	0307879b          	addiw	a5,a5,48
    575c:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    5760:	0344e7bb          	remw	a5,s1,s4
    5764:	0337c7bb          	divw	a5,a5,s3
    5768:	0307879b          	addiw	a5,a5,48
    576c:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    5770:	0334e7bb          	remw	a5,s1,s3
    5774:	0327c7bb          	divw	a5,a5,s2
    5778:	0307879b          	addiw	a5,a5,48
    577c:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    5780:	0324e7bb          	remw	a5,s1,s2
    5784:	0307879b          	addiw	a5,a5,48
    5788:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    578c:	f4040aa3          	sb	zero,-171(s0)
    unlink(name);
    5790:	f5040513          	addi	a0,s0,-176
    5794:	00000097          	auipc	ra,0x0
    5798:	774080e7          	jalr	1908(ra) # 5f08 <unlink>
    nfiles--;
    579c:	34fd                	addiw	s1,s1,-1
  while(nfiles >= 0){
    579e:	fb5499e3          	bne	s1,s5,5750 <fsfull+0xdc>
  printf("fsfull test finished\n");
    57a2:	00003517          	auipc	a0,0x3
    57a6:	ba650513          	addi	a0,a0,-1114 # 8348 <malloc+0x2052>
    57aa:	00001097          	auipc	ra,0x1
    57ae:	a8e080e7          	jalr	-1394(ra) # 6238 <printf>
}
    57b2:	70aa                	ld	ra,168(sp)
    57b4:	740a                	ld	s0,160(sp)
    57b6:	64ea                	ld	s1,152(sp)
    57b8:	694a                	ld	s2,144(sp)
    57ba:	69aa                	ld	s3,136(sp)
    57bc:	6a0a                	ld	s4,128(sp)
    57be:	7ae6                	ld	s5,120(sp)
    57c0:	7b46                	ld	s6,112(sp)
    57c2:	7ba6                	ld	s7,104(sp)
    57c4:	7c06                	ld	s8,96(sp)
    57c6:	6ce6                	ld	s9,88(sp)
    57c8:	6d46                	ld	s10,80(sp)
    57ca:	6da6                	ld	s11,72(sp)
    57cc:	614d                	addi	sp,sp,176
    57ce:	8082                	ret
    int total = 0;
    57d0:	89ee                	mv	s3,s11
      if(cc < BSIZE)
    57d2:	3ff00a93          	li	s5,1023
      int cc = write(fd, buf, BSIZE);
    57d6:	40000613          	li	a2,1024
    57da:	85d2                	mv	a1,s4
    57dc:	854a                	mv	a0,s2
    57de:	00000097          	auipc	ra,0x0
    57e2:	6fa080e7          	jalr	1786(ra) # 5ed8 <write>
      if(cc < BSIZE)
    57e6:	00aad563          	bge	s5,a0,57f0 <fsfull+0x17c>
      total += cc;
    57ea:	00a989bb          	addw	s3,s3,a0
    while(1){
    57ee:	b7e5                	j	57d6 <fsfull+0x162>
    printf("wrote %d bytes\n", total);
    57f0:	85ce                	mv	a1,s3
    57f2:	00003517          	auipc	a0,0x3
    57f6:	b4650513          	addi	a0,a0,-1210 # 8338 <malloc+0x2042>
    57fa:	00001097          	auipc	ra,0x1
    57fe:	a3e080e7          	jalr	-1474(ra) # 6238 <printf>
    close(fd);
    5802:	854a                	mv	a0,s2
    5804:	00000097          	auipc	ra,0x0
    5808:	6dc080e7          	jalr	1756(ra) # 5ee0 <close>
    if(total == 0)
    580c:	f20988e3          	beqz	s3,573c <fsfull+0xc8>
  for(nfiles = 0; ; nfiles++){
    5810:	2485                	addiw	s1,s1,1
    5812:	bd4d                	j	56c4 <fsfull+0x50>

0000000000005814 <run>:
//

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    5814:	7179                	addi	sp,sp,-48
    5816:	f406                	sd	ra,40(sp)
    5818:	f022                	sd	s0,32(sp)
    581a:	ec26                	sd	s1,24(sp)
    581c:	e84a                	sd	s2,16(sp)
    581e:	1800                	addi	s0,sp,48
    5820:	84aa                	mv	s1,a0
    5822:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    5824:	00003517          	auipc	a0,0x3
    5828:	b3c50513          	addi	a0,a0,-1220 # 8360 <malloc+0x206a>
    582c:	00001097          	auipc	ra,0x1
    5830:	a0c080e7          	jalr	-1524(ra) # 6238 <printf>
  if((pid = fork()) < 0) {
    5834:	00000097          	auipc	ra,0x0
    5838:	67c080e7          	jalr	1660(ra) # 5eb0 <fork>
    583c:	02054f63          	bltz	a0,587a <run+0x66>
    printf("runtest: fork error\n");
    exit(1,0);
  }
  if(pid == 0) {
    5840:	c939                	beqz	a0,5896 <run+0x82>
    f(s);
    exit(0,0);
  } else {
    wait(&xstatus,0);
    5842:	4581                	li	a1,0
    5844:	fdc40513          	addi	a0,s0,-36
    5848:	00000097          	auipc	ra,0x0
    584c:	678080e7          	jalr	1656(ra) # 5ec0 <wait>
    if(xstatus != 0) 
    5850:	fdc42783          	lw	a5,-36(s0)
    5854:	cba9                	beqz	a5,58a6 <run+0x92>
      printf("FAILED\n");
    5856:	00003517          	auipc	a0,0x3
    585a:	b3250513          	addi	a0,a0,-1230 # 8388 <malloc+0x2092>
    585e:	00001097          	auipc	ra,0x1
    5862:	9da080e7          	jalr	-1574(ra) # 6238 <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    5866:	fdc42503          	lw	a0,-36(s0)
  }
}
    586a:	00153513          	seqz	a0,a0
    586e:	70a2                	ld	ra,40(sp)
    5870:	7402                	ld	s0,32(sp)
    5872:	64e2                	ld	s1,24(sp)
    5874:	6942                	ld	s2,16(sp)
    5876:	6145                	addi	sp,sp,48
    5878:	8082                	ret
    printf("runtest: fork error\n");
    587a:	00003517          	auipc	a0,0x3
    587e:	af650513          	addi	a0,a0,-1290 # 8370 <malloc+0x207a>
    5882:	00001097          	auipc	ra,0x1
    5886:	9b6080e7          	jalr	-1610(ra) # 6238 <printf>
    exit(1,0);
    588a:	4581                	li	a1,0
    588c:	4505                	li	a0,1
    588e:	00000097          	auipc	ra,0x0
    5892:	62a080e7          	jalr	1578(ra) # 5eb8 <exit>
    f(s);
    5896:	854a                	mv	a0,s2
    5898:	9482                	jalr	s1
    exit(0,0);
    589a:	4581                	li	a1,0
    589c:	4501                	li	a0,0
    589e:	00000097          	auipc	ra,0x0
    58a2:	61a080e7          	jalr	1562(ra) # 5eb8 <exit>
      printf("OK\n");
    58a6:	00003517          	auipc	a0,0x3
    58aa:	aea50513          	addi	a0,a0,-1302 # 8390 <malloc+0x209a>
    58ae:	00001097          	auipc	ra,0x1
    58b2:	98a080e7          	jalr	-1654(ra) # 6238 <printf>
    58b6:	bf45                	j	5866 <run+0x52>

00000000000058b8 <runtests>:

int
runtests(struct test *tests, char *justone) {
    58b8:	1101                	addi	sp,sp,-32
    58ba:	ec06                	sd	ra,24(sp)
    58bc:	e822                	sd	s0,16(sp)
    58be:	e426                	sd	s1,8(sp)
    58c0:	e04a                	sd	s2,0(sp)
    58c2:	1000                	addi	s0,sp,32
    58c4:	84aa                	mv	s1,a0
    58c6:	892e                	mv	s2,a1
  for (struct test *t = tests; t->s != 0; t++) {
    58c8:	6508                	ld	a0,8(a0)
    58ca:	ed09                	bnez	a0,58e4 <runtests+0x2c>
        printf("SOME TESTS FAILED\n");
        return 1;
      }
    }
  }
  return 0;
    58cc:	4501                	li	a0,0
    58ce:	a82d                	j	5908 <runtests+0x50>
      if(!run(t->f, t->s)){
    58d0:	648c                	ld	a1,8(s1)
    58d2:	6088                	ld	a0,0(s1)
    58d4:	00000097          	auipc	ra,0x0
    58d8:	f40080e7          	jalr	-192(ra) # 5814 <run>
    58dc:	cd09                	beqz	a0,58f6 <runtests+0x3e>
  for (struct test *t = tests; t->s != 0; t++) {
    58de:	04c1                	addi	s1,s1,16
    58e0:	6488                	ld	a0,8(s1)
    58e2:	c11d                	beqz	a0,5908 <runtests+0x50>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    58e4:	fe0906e3          	beqz	s2,58d0 <runtests+0x18>
    58e8:	85ca                	mv	a1,s2
    58ea:	00000097          	auipc	ra,0x0
    58ee:	37c080e7          	jalr	892(ra) # 5c66 <strcmp>
    58f2:	f575                	bnez	a0,58de <runtests+0x26>
    58f4:	bff1                	j	58d0 <runtests+0x18>
        printf("SOME TESTS FAILED\n");
    58f6:	00003517          	auipc	a0,0x3
    58fa:	aa250513          	addi	a0,a0,-1374 # 8398 <malloc+0x20a2>
    58fe:	00001097          	auipc	ra,0x1
    5902:	93a080e7          	jalr	-1734(ra) # 6238 <printf>
        return 1;
    5906:	4505                	li	a0,1
}
    5908:	60e2                	ld	ra,24(sp)
    590a:	6442                	ld	s0,16(sp)
    590c:	64a2                	ld	s1,8(sp)
    590e:	6902                	ld	s2,0(sp)
    5910:	6105                	addi	sp,sp,32
    5912:	8082                	ret

0000000000005914 <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    5914:	7139                	addi	sp,sp,-64
    5916:	fc06                	sd	ra,56(sp)
    5918:	f822                	sd	s0,48(sp)
    591a:	f426                	sd	s1,40(sp)
    591c:	f04a                	sd	s2,32(sp)
    591e:	ec4e                	sd	s3,24(sp)
    5920:	0080                	addi	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    5922:	fc840513          	addi	a0,s0,-56
    5926:	00000097          	auipc	ra,0x0
    592a:	5a2080e7          	jalr	1442(ra) # 5ec8 <pipe>
    592e:	06054863          	bltz	a0,599e <countfree+0x8a>
    printf("pipe() failed in countfree()\n");
    exit(1,0);
  }
  
  int pid = fork();
    5932:	00000097          	auipc	ra,0x0
    5936:	57e080e7          	jalr	1406(ra) # 5eb0 <fork>

  if(pid < 0){
    593a:	08054063          	bltz	a0,59ba <countfree+0xa6>
    printf("fork failed in countfree()\n");
    exit(1,0);
  }

  if(pid == 0){
    593e:	e155                	bnez	a0,59e2 <countfree+0xce>
    close(fds[0]);
    5940:	fc842503          	lw	a0,-56(s0)
    5944:	00000097          	auipc	ra,0x0
    5948:	59c080e7          	jalr	1436(ra) # 5ee0 <close>
    
    while(1){
      uint64 a = (uint64) sbrk(4096);
      if(a == 0xffffffffffffffff){
    594c:	597d                	li	s2,-1
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    594e:	4485                	li	s1,1

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    5950:	00001997          	auipc	s3,0x1
    5954:	b5898993          	addi	s3,s3,-1192 # 64a8 <malloc+0x1b2>
      uint64 a = (uint64) sbrk(4096);
    5958:	6505                	lui	a0,0x1
    595a:	00000097          	auipc	ra,0x0
    595e:	5e6080e7          	jalr	1510(ra) # 5f40 <sbrk>
      if(a == 0xffffffffffffffff){
    5962:	07250a63          	beq	a0,s2,59d6 <countfree+0xc2>
      *(char *)(a + 4096 - 1) = 1;
    5966:	6785                	lui	a5,0x1
    5968:	953e                	add	a0,a0,a5
    596a:	fe950fa3          	sb	s1,-1(a0) # fff <linktest+0xaf>
      if(write(fds[1], "x", 1) != 1){
    596e:	8626                	mv	a2,s1
    5970:	85ce                	mv	a1,s3
    5972:	fcc42503          	lw	a0,-52(s0)
    5976:	00000097          	auipc	ra,0x0
    597a:	562080e7          	jalr	1378(ra) # 5ed8 <write>
    597e:	fc950de3          	beq	a0,s1,5958 <countfree+0x44>
        printf("write() failed in countfree()\n");
    5982:	00003517          	auipc	a0,0x3
    5986:	a6e50513          	addi	a0,a0,-1426 # 83f0 <malloc+0x20fa>
    598a:	00001097          	auipc	ra,0x1
    598e:	8ae080e7          	jalr	-1874(ra) # 6238 <printf>
        exit(1,0);
    5992:	4581                	li	a1,0
    5994:	4505                	li	a0,1
    5996:	00000097          	auipc	ra,0x0
    599a:	522080e7          	jalr	1314(ra) # 5eb8 <exit>
    printf("pipe() failed in countfree()\n");
    599e:	00003517          	auipc	a0,0x3
    59a2:	a1250513          	addi	a0,a0,-1518 # 83b0 <malloc+0x20ba>
    59a6:	00001097          	auipc	ra,0x1
    59aa:	892080e7          	jalr	-1902(ra) # 6238 <printf>
    exit(1,0);
    59ae:	4581                	li	a1,0
    59b0:	4505                	li	a0,1
    59b2:	00000097          	auipc	ra,0x0
    59b6:	506080e7          	jalr	1286(ra) # 5eb8 <exit>
    printf("fork failed in countfree()\n");
    59ba:	00003517          	auipc	a0,0x3
    59be:	a1650513          	addi	a0,a0,-1514 # 83d0 <malloc+0x20da>
    59c2:	00001097          	auipc	ra,0x1
    59c6:	876080e7          	jalr	-1930(ra) # 6238 <printf>
    exit(1,0);
    59ca:	4581                	li	a1,0
    59cc:	4505                	li	a0,1
    59ce:	00000097          	auipc	ra,0x0
    59d2:	4ea080e7          	jalr	1258(ra) # 5eb8 <exit>
      }
    }

    exit(0,0);
    59d6:	4581                	li	a1,0
    59d8:	4501                	li	a0,0
    59da:	00000097          	auipc	ra,0x0
    59de:	4de080e7          	jalr	1246(ra) # 5eb8 <exit>
  }

  close(fds[1]);
    59e2:	fcc42503          	lw	a0,-52(s0)
    59e6:	00000097          	auipc	ra,0x0
    59ea:	4fa080e7          	jalr	1274(ra) # 5ee0 <close>

  int n = 0;
    59ee:	4481                	li	s1,0
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    59f0:	4605                	li	a2,1
    59f2:	fc740593          	addi	a1,s0,-57
    59f6:	fc842503          	lw	a0,-56(s0)
    59fa:	00000097          	auipc	ra,0x0
    59fe:	4d6080e7          	jalr	1238(ra) # 5ed0 <read>
    if(cc < 0){
    5a02:	00054563          	bltz	a0,5a0c <countfree+0xf8>
      printf("read() failed in countfree()\n");
      exit(1,0);
    }
    if(cc == 0)
    5a06:	c10d                	beqz	a0,5a28 <countfree+0x114>
      break;
    n += 1;
    5a08:	2485                	addiw	s1,s1,1
  while(1){
    5a0a:	b7dd                	j	59f0 <countfree+0xdc>
      printf("read() failed in countfree()\n");
    5a0c:	00003517          	auipc	a0,0x3
    5a10:	a0450513          	addi	a0,a0,-1532 # 8410 <malloc+0x211a>
    5a14:	00001097          	auipc	ra,0x1
    5a18:	824080e7          	jalr	-2012(ra) # 6238 <printf>
      exit(1,0);
    5a1c:	4581                	li	a1,0
    5a1e:	4505                	li	a0,1
    5a20:	00000097          	auipc	ra,0x0
    5a24:	498080e7          	jalr	1176(ra) # 5eb8 <exit>
  }

  close(fds[0]);
    5a28:	fc842503          	lw	a0,-56(s0)
    5a2c:	00000097          	auipc	ra,0x0
    5a30:	4b4080e7          	jalr	1204(ra) # 5ee0 <close>
  wait((int*)0,0);
    5a34:	4581                	li	a1,0
    5a36:	4501                	li	a0,0
    5a38:	00000097          	auipc	ra,0x0
    5a3c:	488080e7          	jalr	1160(ra) # 5ec0 <wait>
  
  return n;
}
    5a40:	8526                	mv	a0,s1
    5a42:	70e2                	ld	ra,56(sp)
    5a44:	7442                	ld	s0,48(sp)
    5a46:	74a2                	ld	s1,40(sp)
    5a48:	7902                	ld	s2,32(sp)
    5a4a:	69e2                	ld	s3,24(sp)
    5a4c:	6121                	addi	sp,sp,64
    5a4e:	8082                	ret

0000000000005a50 <drivetests>:

int
drivetests(int quick, int continuous, char *justone) {
    5a50:	711d                	addi	sp,sp,-96
    5a52:	ec86                	sd	ra,88(sp)
    5a54:	e8a2                	sd	s0,80(sp)
    5a56:	e4a6                	sd	s1,72(sp)
    5a58:	e0ca                	sd	s2,64(sp)
    5a5a:	fc4e                	sd	s3,56(sp)
    5a5c:	f852                	sd	s4,48(sp)
    5a5e:	f456                	sd	s5,40(sp)
    5a60:	f05a                	sd	s6,32(sp)
    5a62:	ec5e                	sd	s7,24(sp)
    5a64:	e862                	sd	s8,16(sp)
    5a66:	e466                	sd	s9,8(sp)
    5a68:	e06a                	sd	s10,0(sp)
    5a6a:	1080                	addi	s0,sp,96
    5a6c:	8a2a                	mv	s4,a0
    5a6e:	89ae                	mv	s3,a1
    5a70:	8932                	mv	s2,a2
  do {
    printf("usertests starting\n");
    5a72:	00003b97          	auipc	s7,0x3
    5a76:	9beb8b93          	addi	s7,s7,-1602 # 8430 <malloc+0x213a>
    int free0 = countfree();
    int free1 = 0;
    if (runtests(quicktests, justone)) {
    5a7a:	00003b17          	auipc	s6,0x3
    5a7e:	596b0b13          	addi	s6,s6,1430 # 9010 <quicktests>
      if(continuous != 2) {
    5a82:	4a89                	li	s5,2
          return 1;
        }
      }
    }
    if((free1 = countfree()) < free0) {
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    5a84:	00003c97          	auipc	s9,0x3
    5a88:	9e4c8c93          	addi	s9,s9,-1564 # 8468 <malloc+0x2172>
      if (runtests(slowtests, justone)) {
    5a8c:	00004c17          	auipc	s8,0x4
    5a90:	954c0c13          	addi	s8,s8,-1708 # 93e0 <slowtests>
        printf("usertests slow tests starting\n");
    5a94:	00003d17          	auipc	s10,0x3
    5a98:	9b4d0d13          	addi	s10,s10,-1612 # 8448 <malloc+0x2152>
    5a9c:	a839                	j	5aba <drivetests+0x6a>
    5a9e:	856a                	mv	a0,s10
    5aa0:	00000097          	auipc	ra,0x0
    5aa4:	798080e7          	jalr	1944(ra) # 6238 <printf>
    5aa8:	a081                	j	5ae8 <drivetests+0x98>
    if((free1 = countfree()) < free0) {
    5aaa:	00000097          	auipc	ra,0x0
    5aae:	e6a080e7          	jalr	-406(ra) # 5914 <countfree>
    5ab2:	06954263          	blt	a0,s1,5b16 <drivetests+0xc6>
      if(continuous != 2) {
        return 1;
      }
    }
  } while(continuous);
    5ab6:	06098f63          	beqz	s3,5b34 <drivetests+0xe4>
    printf("usertests starting\n");
    5aba:	855e                	mv	a0,s7
    5abc:	00000097          	auipc	ra,0x0
    5ac0:	77c080e7          	jalr	1916(ra) # 6238 <printf>
    int free0 = countfree();
    5ac4:	00000097          	auipc	ra,0x0
    5ac8:	e50080e7          	jalr	-432(ra) # 5914 <countfree>
    5acc:	84aa                	mv	s1,a0
    if (runtests(quicktests, justone)) {
    5ace:	85ca                	mv	a1,s2
    5ad0:	855a                	mv	a0,s6
    5ad2:	00000097          	auipc	ra,0x0
    5ad6:	de6080e7          	jalr	-538(ra) # 58b8 <runtests>
    5ada:	c119                	beqz	a0,5ae0 <drivetests+0x90>
      if(continuous != 2) {
    5adc:	05599863          	bne	s3,s5,5b2c <drivetests+0xdc>
    if(!quick) {
    5ae0:	fc0a15e3          	bnez	s4,5aaa <drivetests+0x5a>
      if (justone == 0)
    5ae4:	fa090de3          	beqz	s2,5a9e <drivetests+0x4e>
      if (runtests(slowtests, justone)) {
    5ae8:	85ca                	mv	a1,s2
    5aea:	8562                	mv	a0,s8
    5aec:	00000097          	auipc	ra,0x0
    5af0:	dcc080e7          	jalr	-564(ra) # 58b8 <runtests>
    5af4:	d95d                	beqz	a0,5aaa <drivetests+0x5a>
        if(continuous != 2) {
    5af6:	03599d63          	bne	s3,s5,5b30 <drivetests+0xe0>
    if((free1 = countfree()) < free0) {
    5afa:	00000097          	auipc	ra,0x0
    5afe:	e1a080e7          	jalr	-486(ra) # 5914 <countfree>
    5b02:	fa955ae3          	bge	a0,s1,5ab6 <drivetests+0x66>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    5b06:	8626                	mv	a2,s1
    5b08:	85aa                	mv	a1,a0
    5b0a:	8566                	mv	a0,s9
    5b0c:	00000097          	auipc	ra,0x0
    5b10:	72c080e7          	jalr	1836(ra) # 6238 <printf>
      if(continuous != 2) {
    5b14:	b75d                	j	5aba <drivetests+0x6a>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    5b16:	8626                	mv	a2,s1
    5b18:	85aa                	mv	a1,a0
    5b1a:	8566                	mv	a0,s9
    5b1c:	00000097          	auipc	ra,0x0
    5b20:	71c080e7          	jalr	1820(ra) # 6238 <printf>
      if(continuous != 2) {
    5b24:	f9598be3          	beq	s3,s5,5aba <drivetests+0x6a>
        return 1;
    5b28:	4505                	li	a0,1
    5b2a:	a031                	j	5b36 <drivetests+0xe6>
        return 1;
    5b2c:	4505                	li	a0,1
    5b2e:	a021                	j	5b36 <drivetests+0xe6>
          return 1;
    5b30:	4505                	li	a0,1
    5b32:	a011                	j	5b36 <drivetests+0xe6>
  return 0;
    5b34:	854e                	mv	a0,s3
}
    5b36:	60e6                	ld	ra,88(sp)
    5b38:	6446                	ld	s0,80(sp)
    5b3a:	64a6                	ld	s1,72(sp)
    5b3c:	6906                	ld	s2,64(sp)
    5b3e:	79e2                	ld	s3,56(sp)
    5b40:	7a42                	ld	s4,48(sp)
    5b42:	7aa2                	ld	s5,40(sp)
    5b44:	7b02                	ld	s6,32(sp)
    5b46:	6be2                	ld	s7,24(sp)
    5b48:	6c42                	ld	s8,16(sp)
    5b4a:	6ca2                	ld	s9,8(sp)
    5b4c:	6d02                	ld	s10,0(sp)
    5b4e:	6125                	addi	sp,sp,96
    5b50:	8082                	ret

0000000000005b52 <main>:

int
main(int argc, char *argv[])
{
    5b52:	1101                	addi	sp,sp,-32
    5b54:	ec06                	sd	ra,24(sp)
    5b56:	e822                	sd	s0,16(sp)
    5b58:	e426                	sd	s1,8(sp)
    5b5a:	e04a                	sd	s2,0(sp)
    5b5c:	1000                	addi	s0,sp,32
    5b5e:	84aa                	mv	s1,a0
  int continuous = 0;
  int quick = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    5b60:	4789                	li	a5,2
    5b62:	02f50463          	beq	a0,a5,5b8a <main+0x38>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    5b66:	4785                	li	a5,1
    5b68:	06a7ce63          	blt	a5,a0,5be4 <main+0x92>
  char *justone = 0;
    5b6c:	4601                	li	a2,0
  int quick = 0;
    5b6e:	4501                	li	a0,0
  int continuous = 0;
    5b70:	4481                	li	s1,0
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    exit(1,0);
  }
  if (drivetests(quick, continuous, justone)) {
    5b72:	85a6                	mv	a1,s1
    5b74:	00000097          	auipc	ra,0x0
    5b78:	edc080e7          	jalr	-292(ra) # 5a50 <drivetests>
    5b7c:	c959                	beqz	a0,5c12 <main+0xc0>
    exit(1,0);
    5b7e:	4581                	li	a1,0
    5b80:	4505                	li	a0,1
    5b82:	00000097          	auipc	ra,0x0
    5b86:	336080e7          	jalr	822(ra) # 5eb8 <exit>
    5b8a:	892e                	mv	s2,a1
  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    5b8c:	00003597          	auipc	a1,0x3
    5b90:	90c58593          	addi	a1,a1,-1780 # 8498 <malloc+0x21a2>
    5b94:	00893503          	ld	a0,8(s2)
    5b98:	00000097          	auipc	ra,0x0
    5b9c:	0ce080e7          	jalr	206(ra) # 5c66 <strcmp>
    5ba0:	c125                	beqz	a0,5c00 <main+0xae>
  } else if(argc == 2 && strcmp(argv[1], "-c") == 0){
    5ba2:	00003597          	auipc	a1,0x3
    5ba6:	94e58593          	addi	a1,a1,-1714 # 84f0 <malloc+0x21fa>
    5baa:	00893503          	ld	a0,8(s2)
    5bae:	00000097          	auipc	ra,0x0
    5bb2:	0b8080e7          	jalr	184(ra) # 5c66 <strcmp>
    5bb6:	c939                	beqz	a0,5c0c <main+0xba>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    5bb8:	00003597          	auipc	a1,0x3
    5bbc:	93058593          	addi	a1,a1,-1744 # 84e8 <malloc+0x21f2>
    5bc0:	00893503          	ld	a0,8(s2)
    5bc4:	00000097          	auipc	ra,0x0
    5bc8:	0a2080e7          	jalr	162(ra) # 5c66 <strcmp>
    5bcc:	cd15                	beqz	a0,5c08 <main+0xb6>
  } else if(argc == 2 && argv[1][0] != '-'){
    5bce:	00893603          	ld	a2,8(s2)
    5bd2:	00064703          	lbu	a4,0(a2) # 3000 <sbrklast+0x6>
    5bd6:	02d00793          	li	a5,45
    5bda:	00f70563          	beq	a4,a5,5be4 <main+0x92>
  int quick = 0;
    5bde:	4501                	li	a0,0
  int continuous = 0;
    5be0:	4481                	li	s1,0
    5be2:	bf41                	j	5b72 <main+0x20>
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    5be4:	00003517          	auipc	a0,0x3
    5be8:	8bc50513          	addi	a0,a0,-1860 # 84a0 <malloc+0x21aa>
    5bec:	00000097          	auipc	ra,0x0
    5bf0:	64c080e7          	jalr	1612(ra) # 6238 <printf>
    exit(1,0);
    5bf4:	4581                	li	a1,0
    5bf6:	4505                	li	a0,1
    5bf8:	00000097          	auipc	ra,0x0
    5bfc:	2c0080e7          	jalr	704(ra) # 5eb8 <exit>
  int continuous = 0;
    5c00:	84aa                	mv	s1,a0
  char *justone = 0;
    5c02:	4601                	li	a2,0
    quick = 1;
    5c04:	4505                	li	a0,1
    5c06:	b7b5                	j	5b72 <main+0x20>
  char *justone = 0;
    5c08:	4601                	li	a2,0
    5c0a:	b7a5                	j	5b72 <main+0x20>
    5c0c:	4601                	li	a2,0
    continuous = 1;
    5c0e:	4485                	li	s1,1
    5c10:	b78d                	j	5b72 <main+0x20>
  }
  printf("ALL TESTS PASSED\n");
    5c12:	00003517          	auipc	a0,0x3
    5c16:	8be50513          	addi	a0,a0,-1858 # 84d0 <malloc+0x21da>
    5c1a:	00000097          	auipc	ra,0x0
    5c1e:	61e080e7          	jalr	1566(ra) # 6238 <printf>
  exit(0,0);
    5c22:	4581                	li	a1,0
    5c24:	4501                	li	a0,0
    5c26:	00000097          	auipc	ra,0x0
    5c2a:	292080e7          	jalr	658(ra) # 5eb8 <exit>

0000000000005c2e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    5c2e:	1141                	addi	sp,sp,-16
    5c30:	e406                	sd	ra,8(sp)
    5c32:	e022                	sd	s0,0(sp)
    5c34:	0800                	addi	s0,sp,16
  extern int main();
  main();
    5c36:	00000097          	auipc	ra,0x0
    5c3a:	f1c080e7          	jalr	-228(ra) # 5b52 <main>
  exit(0,0);
    5c3e:	4581                	li	a1,0
    5c40:	4501                	li	a0,0
    5c42:	00000097          	auipc	ra,0x0
    5c46:	276080e7          	jalr	630(ra) # 5eb8 <exit>

0000000000005c4a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    5c4a:	1141                	addi	sp,sp,-16
    5c4c:	e422                	sd	s0,8(sp)
    5c4e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    5c50:	87aa                	mv	a5,a0
    5c52:	0585                	addi	a1,a1,1
    5c54:	0785                	addi	a5,a5,1
    5c56:	fff5c703          	lbu	a4,-1(a1)
    5c5a:	fee78fa3          	sb	a4,-1(a5) # fff <linktest+0xaf>
    5c5e:	fb75                	bnez	a4,5c52 <strcpy+0x8>
    ;
  return os;
}
    5c60:	6422                	ld	s0,8(sp)
    5c62:	0141                	addi	sp,sp,16
    5c64:	8082                	ret

0000000000005c66 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    5c66:	1141                	addi	sp,sp,-16
    5c68:	e422                	sd	s0,8(sp)
    5c6a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    5c6c:	00054783          	lbu	a5,0(a0)
    5c70:	cb91                	beqz	a5,5c84 <strcmp+0x1e>
    5c72:	0005c703          	lbu	a4,0(a1)
    5c76:	00f71763          	bne	a4,a5,5c84 <strcmp+0x1e>
    p++, q++;
    5c7a:	0505                	addi	a0,a0,1
    5c7c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    5c7e:	00054783          	lbu	a5,0(a0)
    5c82:	fbe5                	bnez	a5,5c72 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    5c84:	0005c503          	lbu	a0,0(a1)
}
    5c88:	40a7853b          	subw	a0,a5,a0
    5c8c:	6422                	ld	s0,8(sp)
    5c8e:	0141                	addi	sp,sp,16
    5c90:	8082                	ret

0000000000005c92 <strlen>:

uint
strlen(const char *s)
{
    5c92:	1141                	addi	sp,sp,-16
    5c94:	e422                	sd	s0,8(sp)
    5c96:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    5c98:	00054783          	lbu	a5,0(a0)
    5c9c:	cf91                	beqz	a5,5cb8 <strlen+0x26>
    5c9e:	0505                	addi	a0,a0,1
    5ca0:	87aa                	mv	a5,a0
    5ca2:	4685                	li	a3,1
    5ca4:	9e89                	subw	a3,a3,a0
    5ca6:	00f6853b          	addw	a0,a3,a5
    5caa:	0785                	addi	a5,a5,1
    5cac:	fff7c703          	lbu	a4,-1(a5)
    5cb0:	fb7d                	bnez	a4,5ca6 <strlen+0x14>
    ;
  return n;
}
    5cb2:	6422                	ld	s0,8(sp)
    5cb4:	0141                	addi	sp,sp,16
    5cb6:	8082                	ret
  for(n = 0; s[n]; n++)
    5cb8:	4501                	li	a0,0
    5cba:	bfe5                	j	5cb2 <strlen+0x20>

0000000000005cbc <memset>:

void*
memset(void *dst, int c, uint n)
{
    5cbc:	1141                	addi	sp,sp,-16
    5cbe:	e422                	sd	s0,8(sp)
    5cc0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    5cc2:	ca19                	beqz	a2,5cd8 <memset+0x1c>
    5cc4:	87aa                	mv	a5,a0
    5cc6:	1602                	slli	a2,a2,0x20
    5cc8:	9201                	srli	a2,a2,0x20
    5cca:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    5cce:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    5cd2:	0785                	addi	a5,a5,1
    5cd4:	fee79de3          	bne	a5,a4,5cce <memset+0x12>
  }
  return dst;
}
    5cd8:	6422                	ld	s0,8(sp)
    5cda:	0141                	addi	sp,sp,16
    5cdc:	8082                	ret

0000000000005cde <strchr>:

char*
strchr(const char *s, char c)
{
    5cde:	1141                	addi	sp,sp,-16
    5ce0:	e422                	sd	s0,8(sp)
    5ce2:	0800                	addi	s0,sp,16
  for(; *s; s++)
    5ce4:	00054783          	lbu	a5,0(a0)
    5ce8:	cb99                	beqz	a5,5cfe <strchr+0x20>
    if(*s == c)
    5cea:	00f58763          	beq	a1,a5,5cf8 <strchr+0x1a>
  for(; *s; s++)
    5cee:	0505                	addi	a0,a0,1
    5cf0:	00054783          	lbu	a5,0(a0)
    5cf4:	fbfd                	bnez	a5,5cea <strchr+0xc>
      return (char*)s;
  return 0;
    5cf6:	4501                	li	a0,0
}
    5cf8:	6422                	ld	s0,8(sp)
    5cfa:	0141                	addi	sp,sp,16
    5cfc:	8082                	ret
  return 0;
    5cfe:	4501                	li	a0,0
    5d00:	bfe5                	j	5cf8 <strchr+0x1a>

0000000000005d02 <gets>:

char*
gets(char *buf, int max)
{
    5d02:	711d                	addi	sp,sp,-96
    5d04:	ec86                	sd	ra,88(sp)
    5d06:	e8a2                	sd	s0,80(sp)
    5d08:	e4a6                	sd	s1,72(sp)
    5d0a:	e0ca                	sd	s2,64(sp)
    5d0c:	fc4e                	sd	s3,56(sp)
    5d0e:	f852                	sd	s4,48(sp)
    5d10:	f456                	sd	s5,40(sp)
    5d12:	f05a                	sd	s6,32(sp)
    5d14:	ec5e                	sd	s7,24(sp)
    5d16:	1080                	addi	s0,sp,96
    5d18:	8baa                	mv	s7,a0
    5d1a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    5d1c:	892a                	mv	s2,a0
    5d1e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    5d20:	4aa9                	li	s5,10
    5d22:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    5d24:	89a6                	mv	s3,s1
    5d26:	2485                	addiw	s1,s1,1
    5d28:	0344d863          	bge	s1,s4,5d58 <gets+0x56>
    cc = read(0, &c, 1);
    5d2c:	4605                	li	a2,1
    5d2e:	faf40593          	addi	a1,s0,-81
    5d32:	4501                	li	a0,0
    5d34:	00000097          	auipc	ra,0x0
    5d38:	19c080e7          	jalr	412(ra) # 5ed0 <read>
    if(cc < 1)
    5d3c:	00a05e63          	blez	a0,5d58 <gets+0x56>
    buf[i++] = c;
    5d40:	faf44783          	lbu	a5,-81(s0)
    5d44:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    5d48:	01578763          	beq	a5,s5,5d56 <gets+0x54>
    5d4c:	0905                	addi	s2,s2,1
    5d4e:	fd679be3          	bne	a5,s6,5d24 <gets+0x22>
  for(i=0; i+1 < max; ){
    5d52:	89a6                	mv	s3,s1
    5d54:	a011                	j	5d58 <gets+0x56>
    5d56:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    5d58:	99de                	add	s3,s3,s7
    5d5a:	00098023          	sb	zero,0(s3)
  return buf;
}
    5d5e:	855e                	mv	a0,s7
    5d60:	60e6                	ld	ra,88(sp)
    5d62:	6446                	ld	s0,80(sp)
    5d64:	64a6                	ld	s1,72(sp)
    5d66:	6906                	ld	s2,64(sp)
    5d68:	79e2                	ld	s3,56(sp)
    5d6a:	7a42                	ld	s4,48(sp)
    5d6c:	7aa2                	ld	s5,40(sp)
    5d6e:	7b02                	ld	s6,32(sp)
    5d70:	6be2                	ld	s7,24(sp)
    5d72:	6125                	addi	sp,sp,96
    5d74:	8082                	ret

0000000000005d76 <stat>:

int
stat(const char *n, struct stat *st)
{
    5d76:	1101                	addi	sp,sp,-32
    5d78:	ec06                	sd	ra,24(sp)
    5d7a:	e822                	sd	s0,16(sp)
    5d7c:	e426                	sd	s1,8(sp)
    5d7e:	e04a                	sd	s2,0(sp)
    5d80:	1000                	addi	s0,sp,32
    5d82:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    5d84:	4581                	li	a1,0
    5d86:	00000097          	auipc	ra,0x0
    5d8a:	172080e7          	jalr	370(ra) # 5ef8 <open>
  if(fd < 0)
    5d8e:	02054563          	bltz	a0,5db8 <stat+0x42>
    5d92:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    5d94:	85ca                	mv	a1,s2
    5d96:	00000097          	auipc	ra,0x0
    5d9a:	17a080e7          	jalr	378(ra) # 5f10 <fstat>
    5d9e:	892a                	mv	s2,a0
  close(fd);
    5da0:	8526                	mv	a0,s1
    5da2:	00000097          	auipc	ra,0x0
    5da6:	13e080e7          	jalr	318(ra) # 5ee0 <close>
  return r;
}
    5daa:	854a                	mv	a0,s2
    5dac:	60e2                	ld	ra,24(sp)
    5dae:	6442                	ld	s0,16(sp)
    5db0:	64a2                	ld	s1,8(sp)
    5db2:	6902                	ld	s2,0(sp)
    5db4:	6105                	addi	sp,sp,32
    5db6:	8082                	ret
    return -1;
    5db8:	597d                	li	s2,-1
    5dba:	bfc5                	j	5daa <stat+0x34>

0000000000005dbc <atoi>:

int
atoi(const char *s)
{
    5dbc:	1141                	addi	sp,sp,-16
    5dbe:	e422                	sd	s0,8(sp)
    5dc0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    5dc2:	00054603          	lbu	a2,0(a0)
    5dc6:	fd06079b          	addiw	a5,a2,-48
    5dca:	0ff7f793          	andi	a5,a5,255
    5dce:	4725                	li	a4,9
    5dd0:	02f76963          	bltu	a4,a5,5e02 <atoi+0x46>
    5dd4:	86aa                	mv	a3,a0
  n = 0;
    5dd6:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    5dd8:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    5dda:	0685                	addi	a3,a3,1
    5ddc:	0025179b          	slliw	a5,a0,0x2
    5de0:	9fa9                	addw	a5,a5,a0
    5de2:	0017979b          	slliw	a5,a5,0x1
    5de6:	9fb1                	addw	a5,a5,a2
    5de8:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    5dec:	0006c603          	lbu	a2,0(a3)
    5df0:	fd06071b          	addiw	a4,a2,-48
    5df4:	0ff77713          	andi	a4,a4,255
    5df8:	fee5f1e3          	bgeu	a1,a4,5dda <atoi+0x1e>
  return n;
}
    5dfc:	6422                	ld	s0,8(sp)
    5dfe:	0141                	addi	sp,sp,16
    5e00:	8082                	ret
  n = 0;
    5e02:	4501                	li	a0,0
    5e04:	bfe5                	j	5dfc <atoi+0x40>

0000000000005e06 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    5e06:	1141                	addi	sp,sp,-16
    5e08:	e422                	sd	s0,8(sp)
    5e0a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    5e0c:	02b57463          	bgeu	a0,a1,5e34 <memmove+0x2e>
    while(n-- > 0)
    5e10:	00c05f63          	blez	a2,5e2e <memmove+0x28>
    5e14:	1602                	slli	a2,a2,0x20
    5e16:	9201                	srli	a2,a2,0x20
    5e18:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    5e1c:	872a                	mv	a4,a0
      *dst++ = *src++;
    5e1e:	0585                	addi	a1,a1,1
    5e20:	0705                	addi	a4,a4,1
    5e22:	fff5c683          	lbu	a3,-1(a1)
    5e26:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    5e2a:	fee79ae3          	bne	a5,a4,5e1e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    5e2e:	6422                	ld	s0,8(sp)
    5e30:	0141                	addi	sp,sp,16
    5e32:	8082                	ret
    dst += n;
    5e34:	00c50733          	add	a4,a0,a2
    src += n;
    5e38:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    5e3a:	fec05ae3          	blez	a2,5e2e <memmove+0x28>
    5e3e:	fff6079b          	addiw	a5,a2,-1
    5e42:	1782                	slli	a5,a5,0x20
    5e44:	9381                	srli	a5,a5,0x20
    5e46:	fff7c793          	not	a5,a5
    5e4a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    5e4c:	15fd                	addi	a1,a1,-1
    5e4e:	177d                	addi	a4,a4,-1
    5e50:	0005c683          	lbu	a3,0(a1)
    5e54:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    5e58:	fee79ae3          	bne	a5,a4,5e4c <memmove+0x46>
    5e5c:	bfc9                	j	5e2e <memmove+0x28>

0000000000005e5e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    5e5e:	1141                	addi	sp,sp,-16
    5e60:	e422                	sd	s0,8(sp)
    5e62:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    5e64:	ca05                	beqz	a2,5e94 <memcmp+0x36>
    5e66:	fff6069b          	addiw	a3,a2,-1
    5e6a:	1682                	slli	a3,a3,0x20
    5e6c:	9281                	srli	a3,a3,0x20
    5e6e:	0685                	addi	a3,a3,1
    5e70:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    5e72:	00054783          	lbu	a5,0(a0)
    5e76:	0005c703          	lbu	a4,0(a1)
    5e7a:	00e79863          	bne	a5,a4,5e8a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    5e7e:	0505                	addi	a0,a0,1
    p2++;
    5e80:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    5e82:	fed518e3          	bne	a0,a3,5e72 <memcmp+0x14>
  }
  return 0;
    5e86:	4501                	li	a0,0
    5e88:	a019                	j	5e8e <memcmp+0x30>
      return *p1 - *p2;
    5e8a:	40e7853b          	subw	a0,a5,a4
}
    5e8e:	6422                	ld	s0,8(sp)
    5e90:	0141                	addi	sp,sp,16
    5e92:	8082                	ret
  return 0;
    5e94:	4501                	li	a0,0
    5e96:	bfe5                	j	5e8e <memcmp+0x30>

0000000000005e98 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    5e98:	1141                	addi	sp,sp,-16
    5e9a:	e406                	sd	ra,8(sp)
    5e9c:	e022                	sd	s0,0(sp)
    5e9e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    5ea0:	00000097          	auipc	ra,0x0
    5ea4:	f66080e7          	jalr	-154(ra) # 5e06 <memmove>
}
    5ea8:	60a2                	ld	ra,8(sp)
    5eaa:	6402                	ld	s0,0(sp)
    5eac:	0141                	addi	sp,sp,16
    5eae:	8082                	ret

0000000000005eb0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    5eb0:	4885                	li	a7,1
 ecall
    5eb2:	00000073          	ecall
 ret
    5eb6:	8082                	ret

0000000000005eb8 <exit>:
.global exit
exit:
 li a7, SYS_exit
    5eb8:	4889                	li	a7,2
 ecall
    5eba:	00000073          	ecall
 ret
    5ebe:	8082                	ret

0000000000005ec0 <wait>:
.global wait
wait:
 li a7, SYS_wait
    5ec0:	488d                	li	a7,3
 ecall
    5ec2:	00000073          	ecall
 ret
    5ec6:	8082                	ret

0000000000005ec8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    5ec8:	4891                	li	a7,4
 ecall
    5eca:	00000073          	ecall
 ret
    5ece:	8082                	ret

0000000000005ed0 <read>:
.global read
read:
 li a7, SYS_read
    5ed0:	4895                	li	a7,5
 ecall
    5ed2:	00000073          	ecall
 ret
    5ed6:	8082                	ret

0000000000005ed8 <write>:
.global write
write:
 li a7, SYS_write
    5ed8:	48c1                	li	a7,16
 ecall
    5eda:	00000073          	ecall
 ret
    5ede:	8082                	ret

0000000000005ee0 <close>:
.global close
close:
 li a7, SYS_close
    5ee0:	48d5                	li	a7,21
 ecall
    5ee2:	00000073          	ecall
 ret
    5ee6:	8082                	ret

0000000000005ee8 <kill>:
.global kill
kill:
 li a7, SYS_kill
    5ee8:	4899                	li	a7,6
 ecall
    5eea:	00000073          	ecall
 ret
    5eee:	8082                	ret

0000000000005ef0 <exec>:
.global exec
exec:
 li a7, SYS_exec
    5ef0:	489d                	li	a7,7
 ecall
    5ef2:	00000073          	ecall
 ret
    5ef6:	8082                	ret

0000000000005ef8 <open>:
.global open
open:
 li a7, SYS_open
    5ef8:	48bd                	li	a7,15
 ecall
    5efa:	00000073          	ecall
 ret
    5efe:	8082                	ret

0000000000005f00 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    5f00:	48c5                	li	a7,17
 ecall
    5f02:	00000073          	ecall
 ret
    5f06:	8082                	ret

0000000000005f08 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    5f08:	48c9                	li	a7,18
 ecall
    5f0a:	00000073          	ecall
 ret
    5f0e:	8082                	ret

0000000000005f10 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    5f10:	48a1                	li	a7,8
 ecall
    5f12:	00000073          	ecall
 ret
    5f16:	8082                	ret

0000000000005f18 <link>:
.global link
link:
 li a7, SYS_link
    5f18:	48cd                	li	a7,19
 ecall
    5f1a:	00000073          	ecall
 ret
    5f1e:	8082                	ret

0000000000005f20 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    5f20:	48d1                	li	a7,20
 ecall
    5f22:	00000073          	ecall
 ret
    5f26:	8082                	ret

0000000000005f28 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    5f28:	48a5                	li	a7,9
 ecall
    5f2a:	00000073          	ecall
 ret
    5f2e:	8082                	ret

0000000000005f30 <dup>:
.global dup
dup:
 li a7, SYS_dup
    5f30:	48a9                	li	a7,10
 ecall
    5f32:	00000073          	ecall
 ret
    5f36:	8082                	ret

0000000000005f38 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    5f38:	48ad                	li	a7,11
 ecall
    5f3a:	00000073          	ecall
 ret
    5f3e:	8082                	ret

0000000000005f40 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    5f40:	48b1                	li	a7,12
 ecall
    5f42:	00000073          	ecall
 ret
    5f46:	8082                	ret

0000000000005f48 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    5f48:	48b5                	li	a7,13
 ecall
    5f4a:	00000073          	ecall
 ret
    5f4e:	8082                	ret

0000000000005f50 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    5f50:	48b9                	li	a7,14
 ecall
    5f52:	00000073          	ecall
 ret
    5f56:	8082                	ret

0000000000005f58 <memsize>:
.global memsize
memsize:
 li a7, SYS_memsize
    5f58:	48d9                	li	a7,22
 ecall
    5f5a:	00000073          	ecall
 ret
    5f5e:	8082                	ret

0000000000005f60 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    5f60:	1101                	addi	sp,sp,-32
    5f62:	ec06                	sd	ra,24(sp)
    5f64:	e822                	sd	s0,16(sp)
    5f66:	1000                	addi	s0,sp,32
    5f68:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    5f6c:	4605                	li	a2,1
    5f6e:	fef40593          	addi	a1,s0,-17
    5f72:	00000097          	auipc	ra,0x0
    5f76:	f66080e7          	jalr	-154(ra) # 5ed8 <write>
}
    5f7a:	60e2                	ld	ra,24(sp)
    5f7c:	6442                	ld	s0,16(sp)
    5f7e:	6105                	addi	sp,sp,32
    5f80:	8082                	ret

0000000000005f82 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    5f82:	7139                	addi	sp,sp,-64
    5f84:	fc06                	sd	ra,56(sp)
    5f86:	f822                	sd	s0,48(sp)
    5f88:	f426                	sd	s1,40(sp)
    5f8a:	f04a                	sd	s2,32(sp)
    5f8c:	ec4e                	sd	s3,24(sp)
    5f8e:	0080                	addi	s0,sp,64
    5f90:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    5f92:	c299                	beqz	a3,5f98 <printint+0x16>
    5f94:	0805c863          	bltz	a1,6024 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    5f98:	2581                	sext.w	a1,a1
  neg = 0;
    5f9a:	4881                	li	a7,0
    5f9c:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    5fa0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    5fa2:	2601                	sext.w	a2,a2
    5fa4:	00003517          	auipc	a0,0x3
    5fa8:	8bc50513          	addi	a0,a0,-1860 # 8860 <digits>
    5fac:	883a                	mv	a6,a4
    5fae:	2705                	addiw	a4,a4,1
    5fb0:	02c5f7bb          	remuw	a5,a1,a2
    5fb4:	1782                	slli	a5,a5,0x20
    5fb6:	9381                	srli	a5,a5,0x20
    5fb8:	97aa                	add	a5,a5,a0
    5fba:	0007c783          	lbu	a5,0(a5)
    5fbe:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    5fc2:	0005879b          	sext.w	a5,a1
    5fc6:	02c5d5bb          	divuw	a1,a1,a2
    5fca:	0685                	addi	a3,a3,1
    5fcc:	fec7f0e3          	bgeu	a5,a2,5fac <printint+0x2a>
  if(neg)
    5fd0:	00088b63          	beqz	a7,5fe6 <printint+0x64>
    buf[i++] = '-';
    5fd4:	fd040793          	addi	a5,s0,-48
    5fd8:	973e                	add	a4,a4,a5
    5fda:	02d00793          	li	a5,45
    5fde:	fef70823          	sb	a5,-16(a4)
    5fe2:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    5fe6:	02e05863          	blez	a4,6016 <printint+0x94>
    5fea:	fc040793          	addi	a5,s0,-64
    5fee:	00e78933          	add	s2,a5,a4
    5ff2:	fff78993          	addi	s3,a5,-1
    5ff6:	99ba                	add	s3,s3,a4
    5ff8:	377d                	addiw	a4,a4,-1
    5ffa:	1702                	slli	a4,a4,0x20
    5ffc:	9301                	srli	a4,a4,0x20
    5ffe:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    6002:	fff94583          	lbu	a1,-1(s2)
    6006:	8526                	mv	a0,s1
    6008:	00000097          	auipc	ra,0x0
    600c:	f58080e7          	jalr	-168(ra) # 5f60 <putc>
  while(--i >= 0)
    6010:	197d                	addi	s2,s2,-1
    6012:	ff3918e3          	bne	s2,s3,6002 <printint+0x80>
}
    6016:	70e2                	ld	ra,56(sp)
    6018:	7442                	ld	s0,48(sp)
    601a:	74a2                	ld	s1,40(sp)
    601c:	7902                	ld	s2,32(sp)
    601e:	69e2                	ld	s3,24(sp)
    6020:	6121                	addi	sp,sp,64
    6022:	8082                	ret
    x = -xx;
    6024:	40b005bb          	negw	a1,a1
    neg = 1;
    6028:	4885                	li	a7,1
    x = -xx;
    602a:	bf8d                	j	5f9c <printint+0x1a>

000000000000602c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    602c:	7119                	addi	sp,sp,-128
    602e:	fc86                	sd	ra,120(sp)
    6030:	f8a2                	sd	s0,112(sp)
    6032:	f4a6                	sd	s1,104(sp)
    6034:	f0ca                	sd	s2,96(sp)
    6036:	ecce                	sd	s3,88(sp)
    6038:	e8d2                	sd	s4,80(sp)
    603a:	e4d6                	sd	s5,72(sp)
    603c:	e0da                	sd	s6,64(sp)
    603e:	fc5e                	sd	s7,56(sp)
    6040:	f862                	sd	s8,48(sp)
    6042:	f466                	sd	s9,40(sp)
    6044:	f06a                	sd	s10,32(sp)
    6046:	ec6e                	sd	s11,24(sp)
    6048:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    604a:	0005c903          	lbu	s2,0(a1)
    604e:	18090f63          	beqz	s2,61ec <vprintf+0x1c0>
    6052:	8aaa                	mv	s5,a0
    6054:	8b32                	mv	s6,a2
    6056:	00158493          	addi	s1,a1,1
  state = 0;
    605a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    605c:	02500a13          	li	s4,37
      if(c == 'd'){
    6060:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    6064:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    6068:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    606c:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    6070:	00002b97          	auipc	s7,0x2
    6074:	7f0b8b93          	addi	s7,s7,2032 # 8860 <digits>
    6078:	a839                	j	6096 <vprintf+0x6a>
        putc(fd, c);
    607a:	85ca                	mv	a1,s2
    607c:	8556                	mv	a0,s5
    607e:	00000097          	auipc	ra,0x0
    6082:	ee2080e7          	jalr	-286(ra) # 5f60 <putc>
    6086:	a019                	j	608c <vprintf+0x60>
    } else if(state == '%'){
    6088:	01498f63          	beq	s3,s4,60a6 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    608c:	0485                	addi	s1,s1,1
    608e:	fff4c903          	lbu	s2,-1(s1)
    6092:	14090d63          	beqz	s2,61ec <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    6096:	0009079b          	sext.w	a5,s2
    if(state == 0){
    609a:	fe0997e3          	bnez	s3,6088 <vprintf+0x5c>
      if(c == '%'){
    609e:	fd479ee3          	bne	a5,s4,607a <vprintf+0x4e>
        state = '%';
    60a2:	89be                	mv	s3,a5
    60a4:	b7e5                	j	608c <vprintf+0x60>
      if(c == 'd'){
    60a6:	05878063          	beq	a5,s8,60e6 <vprintf+0xba>
      } else if(c == 'l') {
    60aa:	05978c63          	beq	a5,s9,6102 <vprintf+0xd6>
      } else if(c == 'x') {
    60ae:	07a78863          	beq	a5,s10,611e <vprintf+0xf2>
      } else if(c == 'p') {
    60b2:	09b78463          	beq	a5,s11,613a <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    60b6:	07300713          	li	a4,115
    60ba:	0ce78663          	beq	a5,a4,6186 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    60be:	06300713          	li	a4,99
    60c2:	0ee78e63          	beq	a5,a4,61be <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    60c6:	11478863          	beq	a5,s4,61d6 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    60ca:	85d2                	mv	a1,s4
    60cc:	8556                	mv	a0,s5
    60ce:	00000097          	auipc	ra,0x0
    60d2:	e92080e7          	jalr	-366(ra) # 5f60 <putc>
        putc(fd, c);
    60d6:	85ca                	mv	a1,s2
    60d8:	8556                	mv	a0,s5
    60da:	00000097          	auipc	ra,0x0
    60de:	e86080e7          	jalr	-378(ra) # 5f60 <putc>
      }
      state = 0;
    60e2:	4981                	li	s3,0
    60e4:	b765                	j	608c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    60e6:	008b0913          	addi	s2,s6,8
    60ea:	4685                	li	a3,1
    60ec:	4629                	li	a2,10
    60ee:	000b2583          	lw	a1,0(s6)
    60f2:	8556                	mv	a0,s5
    60f4:	00000097          	auipc	ra,0x0
    60f8:	e8e080e7          	jalr	-370(ra) # 5f82 <printint>
    60fc:	8b4a                	mv	s6,s2
      state = 0;
    60fe:	4981                	li	s3,0
    6100:	b771                	j	608c <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    6102:	008b0913          	addi	s2,s6,8
    6106:	4681                	li	a3,0
    6108:	4629                	li	a2,10
    610a:	000b2583          	lw	a1,0(s6)
    610e:	8556                	mv	a0,s5
    6110:	00000097          	auipc	ra,0x0
    6114:	e72080e7          	jalr	-398(ra) # 5f82 <printint>
    6118:	8b4a                	mv	s6,s2
      state = 0;
    611a:	4981                	li	s3,0
    611c:	bf85                	j	608c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    611e:	008b0913          	addi	s2,s6,8
    6122:	4681                	li	a3,0
    6124:	4641                	li	a2,16
    6126:	000b2583          	lw	a1,0(s6)
    612a:	8556                	mv	a0,s5
    612c:	00000097          	auipc	ra,0x0
    6130:	e56080e7          	jalr	-426(ra) # 5f82 <printint>
    6134:	8b4a                	mv	s6,s2
      state = 0;
    6136:	4981                	li	s3,0
    6138:	bf91                	j	608c <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    613a:	008b0793          	addi	a5,s6,8
    613e:	f8f43423          	sd	a5,-120(s0)
    6142:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    6146:	03000593          	li	a1,48
    614a:	8556                	mv	a0,s5
    614c:	00000097          	auipc	ra,0x0
    6150:	e14080e7          	jalr	-492(ra) # 5f60 <putc>
  putc(fd, 'x');
    6154:	85ea                	mv	a1,s10
    6156:	8556                	mv	a0,s5
    6158:	00000097          	auipc	ra,0x0
    615c:	e08080e7          	jalr	-504(ra) # 5f60 <putc>
    6160:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    6162:	03c9d793          	srli	a5,s3,0x3c
    6166:	97de                	add	a5,a5,s7
    6168:	0007c583          	lbu	a1,0(a5)
    616c:	8556                	mv	a0,s5
    616e:	00000097          	auipc	ra,0x0
    6172:	df2080e7          	jalr	-526(ra) # 5f60 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    6176:	0992                	slli	s3,s3,0x4
    6178:	397d                	addiw	s2,s2,-1
    617a:	fe0914e3          	bnez	s2,6162 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    617e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    6182:	4981                	li	s3,0
    6184:	b721                	j	608c <vprintf+0x60>
        s = va_arg(ap, char*);
    6186:	008b0993          	addi	s3,s6,8
    618a:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    618e:	02090163          	beqz	s2,61b0 <vprintf+0x184>
        while(*s != 0){
    6192:	00094583          	lbu	a1,0(s2)
    6196:	c9a1                	beqz	a1,61e6 <vprintf+0x1ba>
          putc(fd, *s);
    6198:	8556                	mv	a0,s5
    619a:	00000097          	auipc	ra,0x0
    619e:	dc6080e7          	jalr	-570(ra) # 5f60 <putc>
          s++;
    61a2:	0905                	addi	s2,s2,1
        while(*s != 0){
    61a4:	00094583          	lbu	a1,0(s2)
    61a8:	f9e5                	bnez	a1,6198 <vprintf+0x16c>
        s = va_arg(ap, char*);
    61aa:	8b4e                	mv	s6,s3
      state = 0;
    61ac:	4981                	li	s3,0
    61ae:	bdf9                	j	608c <vprintf+0x60>
          s = "(null)";
    61b0:	00002917          	auipc	s2,0x2
    61b4:	6a890913          	addi	s2,s2,1704 # 8858 <malloc+0x2562>
        while(*s != 0){
    61b8:	02800593          	li	a1,40
    61bc:	bff1                	j	6198 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    61be:	008b0913          	addi	s2,s6,8
    61c2:	000b4583          	lbu	a1,0(s6)
    61c6:	8556                	mv	a0,s5
    61c8:	00000097          	auipc	ra,0x0
    61cc:	d98080e7          	jalr	-616(ra) # 5f60 <putc>
    61d0:	8b4a                	mv	s6,s2
      state = 0;
    61d2:	4981                	li	s3,0
    61d4:	bd65                	j	608c <vprintf+0x60>
        putc(fd, c);
    61d6:	85d2                	mv	a1,s4
    61d8:	8556                	mv	a0,s5
    61da:	00000097          	auipc	ra,0x0
    61de:	d86080e7          	jalr	-634(ra) # 5f60 <putc>
      state = 0;
    61e2:	4981                	li	s3,0
    61e4:	b565                	j	608c <vprintf+0x60>
        s = va_arg(ap, char*);
    61e6:	8b4e                	mv	s6,s3
      state = 0;
    61e8:	4981                	li	s3,0
    61ea:	b54d                	j	608c <vprintf+0x60>
    }
  }
}
    61ec:	70e6                	ld	ra,120(sp)
    61ee:	7446                	ld	s0,112(sp)
    61f0:	74a6                	ld	s1,104(sp)
    61f2:	7906                	ld	s2,96(sp)
    61f4:	69e6                	ld	s3,88(sp)
    61f6:	6a46                	ld	s4,80(sp)
    61f8:	6aa6                	ld	s5,72(sp)
    61fa:	6b06                	ld	s6,64(sp)
    61fc:	7be2                	ld	s7,56(sp)
    61fe:	7c42                	ld	s8,48(sp)
    6200:	7ca2                	ld	s9,40(sp)
    6202:	7d02                	ld	s10,32(sp)
    6204:	6de2                	ld	s11,24(sp)
    6206:	6109                	addi	sp,sp,128
    6208:	8082                	ret

000000000000620a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    620a:	715d                	addi	sp,sp,-80
    620c:	ec06                	sd	ra,24(sp)
    620e:	e822                	sd	s0,16(sp)
    6210:	1000                	addi	s0,sp,32
    6212:	e010                	sd	a2,0(s0)
    6214:	e414                	sd	a3,8(s0)
    6216:	e818                	sd	a4,16(s0)
    6218:	ec1c                	sd	a5,24(s0)
    621a:	03043023          	sd	a6,32(s0)
    621e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    6222:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    6226:	8622                	mv	a2,s0
    6228:	00000097          	auipc	ra,0x0
    622c:	e04080e7          	jalr	-508(ra) # 602c <vprintf>
}
    6230:	60e2                	ld	ra,24(sp)
    6232:	6442                	ld	s0,16(sp)
    6234:	6161                	addi	sp,sp,80
    6236:	8082                	ret

0000000000006238 <printf>:

void
printf(const char *fmt, ...)
{
    6238:	711d                	addi	sp,sp,-96
    623a:	ec06                	sd	ra,24(sp)
    623c:	e822                	sd	s0,16(sp)
    623e:	1000                	addi	s0,sp,32
    6240:	e40c                	sd	a1,8(s0)
    6242:	e810                	sd	a2,16(s0)
    6244:	ec14                	sd	a3,24(s0)
    6246:	f018                	sd	a4,32(s0)
    6248:	f41c                	sd	a5,40(s0)
    624a:	03043823          	sd	a6,48(s0)
    624e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    6252:	00840613          	addi	a2,s0,8
    6256:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    625a:	85aa                	mv	a1,a0
    625c:	4505                	li	a0,1
    625e:	00000097          	auipc	ra,0x0
    6262:	dce080e7          	jalr	-562(ra) # 602c <vprintf>
}
    6266:	60e2                	ld	ra,24(sp)
    6268:	6442                	ld	s0,16(sp)
    626a:	6125                	addi	sp,sp,96
    626c:	8082                	ret

000000000000626e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    626e:	1141                	addi	sp,sp,-16
    6270:	e422                	sd	s0,8(sp)
    6272:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    6274:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    6278:	00003797          	auipc	a5,0x3
    627c:	1d87b783          	ld	a5,472(a5) # 9450 <freep>
    6280:	a805                	j	62b0 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    6282:	4618                	lw	a4,8(a2)
    6284:	9db9                	addw	a1,a1,a4
    6286:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    628a:	6398                	ld	a4,0(a5)
    628c:	6318                	ld	a4,0(a4)
    628e:	fee53823          	sd	a4,-16(a0)
    6292:	a091                	j	62d6 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    6294:	ff852703          	lw	a4,-8(a0)
    6298:	9e39                	addw	a2,a2,a4
    629a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    629c:	ff053703          	ld	a4,-16(a0)
    62a0:	e398                	sd	a4,0(a5)
    62a2:	a099                	j	62e8 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    62a4:	6398                	ld	a4,0(a5)
    62a6:	00e7e463          	bltu	a5,a4,62ae <free+0x40>
    62aa:	00e6ea63          	bltu	a3,a4,62be <free+0x50>
{
    62ae:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    62b0:	fed7fae3          	bgeu	a5,a3,62a4 <free+0x36>
    62b4:	6398                	ld	a4,0(a5)
    62b6:	00e6e463          	bltu	a3,a4,62be <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    62ba:	fee7eae3          	bltu	a5,a4,62ae <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    62be:	ff852583          	lw	a1,-8(a0)
    62c2:	6390                	ld	a2,0(a5)
    62c4:	02059713          	slli	a4,a1,0x20
    62c8:	9301                	srli	a4,a4,0x20
    62ca:	0712                	slli	a4,a4,0x4
    62cc:	9736                	add	a4,a4,a3
    62ce:	fae60ae3          	beq	a2,a4,6282 <free+0x14>
    bp->s.ptr = p->s.ptr;
    62d2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    62d6:	4790                	lw	a2,8(a5)
    62d8:	02061713          	slli	a4,a2,0x20
    62dc:	9301                	srli	a4,a4,0x20
    62de:	0712                	slli	a4,a4,0x4
    62e0:	973e                	add	a4,a4,a5
    62e2:	fae689e3          	beq	a3,a4,6294 <free+0x26>
  } else
    p->s.ptr = bp;
    62e6:	e394                	sd	a3,0(a5)
  freep = p;
    62e8:	00003717          	auipc	a4,0x3
    62ec:	16f73423          	sd	a5,360(a4) # 9450 <freep>
}
    62f0:	6422                	ld	s0,8(sp)
    62f2:	0141                	addi	sp,sp,16
    62f4:	8082                	ret

00000000000062f6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    62f6:	7139                	addi	sp,sp,-64
    62f8:	fc06                	sd	ra,56(sp)
    62fa:	f822                	sd	s0,48(sp)
    62fc:	f426                	sd	s1,40(sp)
    62fe:	f04a                	sd	s2,32(sp)
    6300:	ec4e                	sd	s3,24(sp)
    6302:	e852                	sd	s4,16(sp)
    6304:	e456                	sd	s5,8(sp)
    6306:	e05a                	sd	s6,0(sp)
    6308:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    630a:	02051493          	slli	s1,a0,0x20
    630e:	9081                	srli	s1,s1,0x20
    6310:	04bd                	addi	s1,s1,15
    6312:	8091                	srli	s1,s1,0x4
    6314:	0014899b          	addiw	s3,s1,1
    6318:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    631a:	00003517          	auipc	a0,0x3
    631e:	13653503          	ld	a0,310(a0) # 9450 <freep>
    6322:	c515                	beqz	a0,634e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    6324:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    6326:	4798                	lw	a4,8(a5)
    6328:	02977f63          	bgeu	a4,s1,6366 <malloc+0x70>
    632c:	8a4e                	mv	s4,s3
    632e:	0009871b          	sext.w	a4,s3
    6332:	6685                	lui	a3,0x1
    6334:	00d77363          	bgeu	a4,a3,633a <malloc+0x44>
    6338:	6a05                	lui	s4,0x1
    633a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    633e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    6342:	00003917          	auipc	s2,0x3
    6346:	10e90913          	addi	s2,s2,270 # 9450 <freep>
  if(p == (char*)-1)
    634a:	5afd                	li	s5,-1
    634c:	a88d                	j	63be <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    634e:	0000a797          	auipc	a5,0xa
    6352:	92a78793          	addi	a5,a5,-1750 # fc78 <base>
    6356:	00003717          	auipc	a4,0x3
    635a:	0ef73d23          	sd	a5,250(a4) # 9450 <freep>
    635e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    6360:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    6364:	b7e1                	j	632c <malloc+0x36>
      if(p->s.size == nunits)
    6366:	02e48b63          	beq	s1,a4,639c <malloc+0xa6>
        p->s.size -= nunits;
    636a:	4137073b          	subw	a4,a4,s3
    636e:	c798                	sw	a4,8(a5)
        p += p->s.size;
    6370:	1702                	slli	a4,a4,0x20
    6372:	9301                	srli	a4,a4,0x20
    6374:	0712                	slli	a4,a4,0x4
    6376:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    6378:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    637c:	00003717          	auipc	a4,0x3
    6380:	0ca73a23          	sd	a0,212(a4) # 9450 <freep>
      return (void*)(p + 1);
    6384:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    6388:	70e2                	ld	ra,56(sp)
    638a:	7442                	ld	s0,48(sp)
    638c:	74a2                	ld	s1,40(sp)
    638e:	7902                	ld	s2,32(sp)
    6390:	69e2                	ld	s3,24(sp)
    6392:	6a42                	ld	s4,16(sp)
    6394:	6aa2                	ld	s5,8(sp)
    6396:	6b02                	ld	s6,0(sp)
    6398:	6121                	addi	sp,sp,64
    639a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    639c:	6398                	ld	a4,0(a5)
    639e:	e118                	sd	a4,0(a0)
    63a0:	bff1                	j	637c <malloc+0x86>
  hp->s.size = nu;
    63a2:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    63a6:	0541                	addi	a0,a0,16
    63a8:	00000097          	auipc	ra,0x0
    63ac:	ec6080e7          	jalr	-314(ra) # 626e <free>
  return freep;
    63b0:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    63b4:	d971                	beqz	a0,6388 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    63b6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    63b8:	4798                	lw	a4,8(a5)
    63ba:	fa9776e3          	bgeu	a4,s1,6366 <malloc+0x70>
    if(p == freep)
    63be:	00093703          	ld	a4,0(s2)
    63c2:	853e                	mv	a0,a5
    63c4:	fef719e3          	bne	a4,a5,63b6 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    63c8:	8552                	mv	a0,s4
    63ca:	00000097          	auipc	ra,0x0
    63ce:	b76080e7          	jalr	-1162(ra) # 5f40 <sbrk>
  if(p == (char*)-1)
    63d2:	fd5518e3          	bne	a0,s5,63a2 <malloc+0xac>
        return 0;
    63d6:	4501                	li	a0,0
    63d8:	bf45                	j	6388 <malloc+0x92>
