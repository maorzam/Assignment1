
user/_forktest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print>:

#define N  1000

void
print(const char *s)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84aa                	mv	s1,a0
  write(1, s, strlen(s));
   c:	00000097          	auipc	ra,0x0
  10:	184080e7          	jalr	388(ra) # 190 <strlen>
  14:	0005061b          	sext.w	a2,a0
  18:	85a6                	mv	a1,s1
  1a:	4505                	li	a0,1
  1c:	00000097          	auipc	ra,0x0
  20:	3ba080e7          	jalr	954(ra) # 3d6 <write>
}
  24:	60e2                	ld	ra,24(sp)
  26:	6442                	ld	s0,16(sp)
  28:	64a2                	ld	s1,8(sp)
  2a:	6105                	addi	sp,sp,32
  2c:	8082                	ret

000000000000002e <forktest>:

void
forktest(void)
{
  2e:	1101                	addi	sp,sp,-32
  30:	ec06                	sd	ra,24(sp)
  32:	e822                	sd	s0,16(sp)
  34:	e426                	sd	s1,8(sp)
  36:	e04a                	sd	s2,0(sp)
  38:	1000                	addi	s0,sp,32
  int n, pid;

  print("fork test\n");
  3a:	00000517          	auipc	a0,0x0
  3e:	42650513          	addi	a0,a0,1062 # 460 <memsize+0xa>
  42:	00000097          	auipc	ra,0x0
  46:	fbe080e7          	jalr	-66(ra) # 0 <print>

  for(n=0; n<N; n++){
  4a:	4481                	li	s1,0
  4c:	3e800913          	li	s2,1000
    pid = fork();
  50:	00000097          	auipc	ra,0x0
  54:	35e080e7          	jalr	862(ra) # 3ae <fork>
    if(pid < 0)
  58:	02054963          	bltz	a0,8a <forktest+0x5c>
      break;
    if(pid == 0)
  5c:	c115                	beqz	a0,80 <forktest+0x52>
  for(n=0; n<N; n++){
  5e:	2485                	addiw	s1,s1,1
  60:	ff2498e3          	bne	s1,s2,50 <forktest+0x22>
      exit(0,0);
  }

  if(n == N){
    print("fork claimed to work N times!\n");
  64:	00000517          	auipc	a0,0x0
  68:	40c50513          	addi	a0,a0,1036 # 470 <memsize+0x1a>
  6c:	00000097          	auipc	ra,0x0
  70:	f94080e7          	jalr	-108(ra) # 0 <print>
    exit(1,0);
  74:	4581                	li	a1,0
  76:	4505                	li	a0,1
  78:	00000097          	auipc	ra,0x0
  7c:	33e080e7          	jalr	830(ra) # 3b6 <exit>
      exit(0,0);
  80:	4581                	li	a1,0
  82:	00000097          	auipc	ra,0x0
  86:	334080e7          	jalr	820(ra) # 3b6 <exit>
  if(n == N){
  8a:	3e800793          	li	a5,1000
  8e:	fcf48be3          	beq	s1,a5,64 <forktest+0x36>
  }

  for(; n > 0; n--){
  92:	00905c63          	blez	s1,aa <forktest+0x7c>
    if(wait(0,0) < 0){
  96:	4581                	li	a1,0
  98:	4501                	li	a0,0
  9a:	00000097          	auipc	ra,0x0
  9e:	324080e7          	jalr	804(ra) # 3be <wait>
  a2:	02054b63          	bltz	a0,d8 <forktest+0xaa>
  for(; n > 0; n--){
  a6:	34fd                	addiw	s1,s1,-1
  a8:	f4fd                	bnez	s1,96 <forktest+0x68>
      print("wait stopped early\n");
      exit(1,0);
    }
  }

  if(wait(0,0) != -1){
  aa:	4581                	li	a1,0
  ac:	4501                	li	a0,0
  ae:	00000097          	auipc	ra,0x0
  b2:	310080e7          	jalr	784(ra) # 3be <wait>
  b6:	57fd                	li	a5,-1
  b8:	02f51e63          	bne	a0,a5,f4 <forktest+0xc6>
    print("wait got too many\n");
    exit(1,0);
  }

  print("fork test OK\n");
  bc:	00000517          	auipc	a0,0x0
  c0:	40450513          	addi	a0,a0,1028 # 4c0 <memsize+0x6a>
  c4:	00000097          	auipc	ra,0x0
  c8:	f3c080e7          	jalr	-196(ra) # 0 <print>
}
  cc:	60e2                	ld	ra,24(sp)
  ce:	6442                	ld	s0,16(sp)
  d0:	64a2                	ld	s1,8(sp)
  d2:	6902                	ld	s2,0(sp)
  d4:	6105                	addi	sp,sp,32
  d6:	8082                	ret
      print("wait stopped early\n");
  d8:	00000517          	auipc	a0,0x0
  dc:	3b850513          	addi	a0,a0,952 # 490 <memsize+0x3a>
  e0:	00000097          	auipc	ra,0x0
  e4:	f20080e7          	jalr	-224(ra) # 0 <print>
      exit(1,0);
  e8:	4581                	li	a1,0
  ea:	4505                	li	a0,1
  ec:	00000097          	auipc	ra,0x0
  f0:	2ca080e7          	jalr	714(ra) # 3b6 <exit>
    print("wait got too many\n");
  f4:	00000517          	auipc	a0,0x0
  f8:	3b450513          	addi	a0,a0,948 # 4a8 <memsize+0x52>
  fc:	00000097          	auipc	ra,0x0
 100:	f04080e7          	jalr	-252(ra) # 0 <print>
    exit(1,0);
 104:	4581                	li	a1,0
 106:	4505                	li	a0,1
 108:	00000097          	auipc	ra,0x0
 10c:	2ae080e7          	jalr	686(ra) # 3b6 <exit>

0000000000000110 <main>:

int
main(void)
{
 110:	1141                	addi	sp,sp,-16
 112:	e406                	sd	ra,8(sp)
 114:	e022                	sd	s0,0(sp)
 116:	0800                	addi	s0,sp,16
  forktest();
 118:	00000097          	auipc	ra,0x0
 11c:	f16080e7          	jalr	-234(ra) # 2e <forktest>
  exit(0,0);
 120:	4581                	li	a1,0
 122:	4501                	li	a0,0
 124:	00000097          	auipc	ra,0x0
 128:	292080e7          	jalr	658(ra) # 3b6 <exit>

000000000000012c <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 12c:	1141                	addi	sp,sp,-16
 12e:	e406                	sd	ra,8(sp)
 130:	e022                	sd	s0,0(sp)
 132:	0800                	addi	s0,sp,16
  extern int main();
  main();
 134:	00000097          	auipc	ra,0x0
 138:	fdc080e7          	jalr	-36(ra) # 110 <main>
  exit(0,0);
 13c:	4581                	li	a1,0
 13e:	4501                	li	a0,0
 140:	00000097          	auipc	ra,0x0
 144:	276080e7          	jalr	630(ra) # 3b6 <exit>

0000000000000148 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 148:	1141                	addi	sp,sp,-16
 14a:	e422                	sd	s0,8(sp)
 14c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 14e:	87aa                	mv	a5,a0
 150:	0585                	addi	a1,a1,1
 152:	0785                	addi	a5,a5,1
 154:	fff5c703          	lbu	a4,-1(a1)
 158:	fee78fa3          	sb	a4,-1(a5)
 15c:	fb75                	bnez	a4,150 <strcpy+0x8>
    ;
  return os;
}
 15e:	6422                	ld	s0,8(sp)
 160:	0141                	addi	sp,sp,16
 162:	8082                	ret

0000000000000164 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 164:	1141                	addi	sp,sp,-16
 166:	e422                	sd	s0,8(sp)
 168:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 16a:	00054783          	lbu	a5,0(a0)
 16e:	cb91                	beqz	a5,182 <strcmp+0x1e>
 170:	0005c703          	lbu	a4,0(a1)
 174:	00f71763          	bne	a4,a5,182 <strcmp+0x1e>
    p++, q++;
 178:	0505                	addi	a0,a0,1
 17a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 17c:	00054783          	lbu	a5,0(a0)
 180:	fbe5                	bnez	a5,170 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 182:	0005c503          	lbu	a0,0(a1)
}
 186:	40a7853b          	subw	a0,a5,a0
 18a:	6422                	ld	s0,8(sp)
 18c:	0141                	addi	sp,sp,16
 18e:	8082                	ret

0000000000000190 <strlen>:

uint
strlen(const char *s)
{
 190:	1141                	addi	sp,sp,-16
 192:	e422                	sd	s0,8(sp)
 194:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 196:	00054783          	lbu	a5,0(a0)
 19a:	cf91                	beqz	a5,1b6 <strlen+0x26>
 19c:	0505                	addi	a0,a0,1
 19e:	87aa                	mv	a5,a0
 1a0:	4685                	li	a3,1
 1a2:	9e89                	subw	a3,a3,a0
 1a4:	00f6853b          	addw	a0,a3,a5
 1a8:	0785                	addi	a5,a5,1
 1aa:	fff7c703          	lbu	a4,-1(a5)
 1ae:	fb7d                	bnez	a4,1a4 <strlen+0x14>
    ;
  return n;
}
 1b0:	6422                	ld	s0,8(sp)
 1b2:	0141                	addi	sp,sp,16
 1b4:	8082                	ret
  for(n = 0; s[n]; n++)
 1b6:	4501                	li	a0,0
 1b8:	bfe5                	j	1b0 <strlen+0x20>

00000000000001ba <memset>:

void*
memset(void *dst, int c, uint n)
{
 1ba:	1141                	addi	sp,sp,-16
 1bc:	e422                	sd	s0,8(sp)
 1be:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1c0:	ca19                	beqz	a2,1d6 <memset+0x1c>
 1c2:	87aa                	mv	a5,a0
 1c4:	1602                	slli	a2,a2,0x20
 1c6:	9201                	srli	a2,a2,0x20
 1c8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1cc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1d0:	0785                	addi	a5,a5,1
 1d2:	fee79de3          	bne	a5,a4,1cc <memset+0x12>
  }
  return dst;
}
 1d6:	6422                	ld	s0,8(sp)
 1d8:	0141                	addi	sp,sp,16
 1da:	8082                	ret

00000000000001dc <strchr>:

char*
strchr(const char *s, char c)
{
 1dc:	1141                	addi	sp,sp,-16
 1de:	e422                	sd	s0,8(sp)
 1e0:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1e2:	00054783          	lbu	a5,0(a0)
 1e6:	cb99                	beqz	a5,1fc <strchr+0x20>
    if(*s == c)
 1e8:	00f58763          	beq	a1,a5,1f6 <strchr+0x1a>
  for(; *s; s++)
 1ec:	0505                	addi	a0,a0,1
 1ee:	00054783          	lbu	a5,0(a0)
 1f2:	fbfd                	bnez	a5,1e8 <strchr+0xc>
      return (char*)s;
  return 0;
 1f4:	4501                	li	a0,0
}
 1f6:	6422                	ld	s0,8(sp)
 1f8:	0141                	addi	sp,sp,16
 1fa:	8082                	ret
  return 0;
 1fc:	4501                	li	a0,0
 1fe:	bfe5                	j	1f6 <strchr+0x1a>

0000000000000200 <gets>:

char*
gets(char *buf, int max)
{
 200:	711d                	addi	sp,sp,-96
 202:	ec86                	sd	ra,88(sp)
 204:	e8a2                	sd	s0,80(sp)
 206:	e4a6                	sd	s1,72(sp)
 208:	e0ca                	sd	s2,64(sp)
 20a:	fc4e                	sd	s3,56(sp)
 20c:	f852                	sd	s4,48(sp)
 20e:	f456                	sd	s5,40(sp)
 210:	f05a                	sd	s6,32(sp)
 212:	ec5e                	sd	s7,24(sp)
 214:	1080                	addi	s0,sp,96
 216:	8baa                	mv	s7,a0
 218:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 21a:	892a                	mv	s2,a0
 21c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 21e:	4aa9                	li	s5,10
 220:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 222:	89a6                	mv	s3,s1
 224:	2485                	addiw	s1,s1,1
 226:	0344d863          	bge	s1,s4,256 <gets+0x56>
    cc = read(0, &c, 1);
 22a:	4605                	li	a2,1
 22c:	faf40593          	addi	a1,s0,-81
 230:	4501                	li	a0,0
 232:	00000097          	auipc	ra,0x0
 236:	19c080e7          	jalr	412(ra) # 3ce <read>
    if(cc < 1)
 23a:	00a05e63          	blez	a0,256 <gets+0x56>
    buf[i++] = c;
 23e:	faf44783          	lbu	a5,-81(s0)
 242:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 246:	01578763          	beq	a5,s5,254 <gets+0x54>
 24a:	0905                	addi	s2,s2,1
 24c:	fd679be3          	bne	a5,s6,222 <gets+0x22>
  for(i=0; i+1 < max; ){
 250:	89a6                	mv	s3,s1
 252:	a011                	j	256 <gets+0x56>
 254:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 256:	99de                	add	s3,s3,s7
 258:	00098023          	sb	zero,0(s3)
  return buf;
}
 25c:	855e                	mv	a0,s7
 25e:	60e6                	ld	ra,88(sp)
 260:	6446                	ld	s0,80(sp)
 262:	64a6                	ld	s1,72(sp)
 264:	6906                	ld	s2,64(sp)
 266:	79e2                	ld	s3,56(sp)
 268:	7a42                	ld	s4,48(sp)
 26a:	7aa2                	ld	s5,40(sp)
 26c:	7b02                	ld	s6,32(sp)
 26e:	6be2                	ld	s7,24(sp)
 270:	6125                	addi	sp,sp,96
 272:	8082                	ret

0000000000000274 <stat>:

int
stat(const char *n, struct stat *st)
{
 274:	1101                	addi	sp,sp,-32
 276:	ec06                	sd	ra,24(sp)
 278:	e822                	sd	s0,16(sp)
 27a:	e426                	sd	s1,8(sp)
 27c:	e04a                	sd	s2,0(sp)
 27e:	1000                	addi	s0,sp,32
 280:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 282:	4581                	li	a1,0
 284:	00000097          	auipc	ra,0x0
 288:	172080e7          	jalr	370(ra) # 3f6 <open>
  if(fd < 0)
 28c:	02054563          	bltz	a0,2b6 <stat+0x42>
 290:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 292:	85ca                	mv	a1,s2
 294:	00000097          	auipc	ra,0x0
 298:	17a080e7          	jalr	378(ra) # 40e <fstat>
 29c:	892a                	mv	s2,a0
  close(fd);
 29e:	8526                	mv	a0,s1
 2a0:	00000097          	auipc	ra,0x0
 2a4:	13e080e7          	jalr	318(ra) # 3de <close>
  return r;
}
 2a8:	854a                	mv	a0,s2
 2aa:	60e2                	ld	ra,24(sp)
 2ac:	6442                	ld	s0,16(sp)
 2ae:	64a2                	ld	s1,8(sp)
 2b0:	6902                	ld	s2,0(sp)
 2b2:	6105                	addi	sp,sp,32
 2b4:	8082                	ret
    return -1;
 2b6:	597d                	li	s2,-1
 2b8:	bfc5                	j	2a8 <stat+0x34>

00000000000002ba <atoi>:

int
atoi(const char *s)
{
 2ba:	1141                	addi	sp,sp,-16
 2bc:	e422                	sd	s0,8(sp)
 2be:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2c0:	00054603          	lbu	a2,0(a0)
 2c4:	fd06079b          	addiw	a5,a2,-48
 2c8:	0ff7f793          	andi	a5,a5,255
 2cc:	4725                	li	a4,9
 2ce:	02f76963          	bltu	a4,a5,300 <atoi+0x46>
 2d2:	86aa                	mv	a3,a0
  n = 0;
 2d4:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 2d6:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2d8:	0685                	addi	a3,a3,1
 2da:	0025179b          	slliw	a5,a0,0x2
 2de:	9fa9                	addw	a5,a5,a0
 2e0:	0017979b          	slliw	a5,a5,0x1
 2e4:	9fb1                	addw	a5,a5,a2
 2e6:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2ea:	0006c603          	lbu	a2,0(a3)
 2ee:	fd06071b          	addiw	a4,a2,-48
 2f2:	0ff77713          	andi	a4,a4,255
 2f6:	fee5f1e3          	bgeu	a1,a4,2d8 <atoi+0x1e>
  return n;
}
 2fa:	6422                	ld	s0,8(sp)
 2fc:	0141                	addi	sp,sp,16
 2fe:	8082                	ret
  n = 0;
 300:	4501                	li	a0,0
 302:	bfe5                	j	2fa <atoi+0x40>

0000000000000304 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 304:	1141                	addi	sp,sp,-16
 306:	e422                	sd	s0,8(sp)
 308:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 30a:	02b57463          	bgeu	a0,a1,332 <memmove+0x2e>
    while(n-- > 0)
 30e:	00c05f63          	blez	a2,32c <memmove+0x28>
 312:	1602                	slli	a2,a2,0x20
 314:	9201                	srli	a2,a2,0x20
 316:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 31a:	872a                	mv	a4,a0
      *dst++ = *src++;
 31c:	0585                	addi	a1,a1,1
 31e:	0705                	addi	a4,a4,1
 320:	fff5c683          	lbu	a3,-1(a1)
 324:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 328:	fee79ae3          	bne	a5,a4,31c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 32c:	6422                	ld	s0,8(sp)
 32e:	0141                	addi	sp,sp,16
 330:	8082                	ret
    dst += n;
 332:	00c50733          	add	a4,a0,a2
    src += n;
 336:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 338:	fec05ae3          	blez	a2,32c <memmove+0x28>
 33c:	fff6079b          	addiw	a5,a2,-1
 340:	1782                	slli	a5,a5,0x20
 342:	9381                	srli	a5,a5,0x20
 344:	fff7c793          	not	a5,a5
 348:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 34a:	15fd                	addi	a1,a1,-1
 34c:	177d                	addi	a4,a4,-1
 34e:	0005c683          	lbu	a3,0(a1)
 352:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 356:	fee79ae3          	bne	a5,a4,34a <memmove+0x46>
 35a:	bfc9                	j	32c <memmove+0x28>

000000000000035c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 35c:	1141                	addi	sp,sp,-16
 35e:	e422                	sd	s0,8(sp)
 360:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 362:	ca05                	beqz	a2,392 <memcmp+0x36>
 364:	fff6069b          	addiw	a3,a2,-1
 368:	1682                	slli	a3,a3,0x20
 36a:	9281                	srli	a3,a3,0x20
 36c:	0685                	addi	a3,a3,1
 36e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 370:	00054783          	lbu	a5,0(a0)
 374:	0005c703          	lbu	a4,0(a1)
 378:	00e79863          	bne	a5,a4,388 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 37c:	0505                	addi	a0,a0,1
    p2++;
 37e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 380:	fed518e3          	bne	a0,a3,370 <memcmp+0x14>
  }
  return 0;
 384:	4501                	li	a0,0
 386:	a019                	j	38c <memcmp+0x30>
      return *p1 - *p2;
 388:	40e7853b          	subw	a0,a5,a4
}
 38c:	6422                	ld	s0,8(sp)
 38e:	0141                	addi	sp,sp,16
 390:	8082                	ret
  return 0;
 392:	4501                	li	a0,0
 394:	bfe5                	j	38c <memcmp+0x30>

0000000000000396 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 396:	1141                	addi	sp,sp,-16
 398:	e406                	sd	ra,8(sp)
 39a:	e022                	sd	s0,0(sp)
 39c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 39e:	00000097          	auipc	ra,0x0
 3a2:	f66080e7          	jalr	-154(ra) # 304 <memmove>
}
 3a6:	60a2                	ld	ra,8(sp)
 3a8:	6402                	ld	s0,0(sp)
 3aa:	0141                	addi	sp,sp,16
 3ac:	8082                	ret

00000000000003ae <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3ae:	4885                	li	a7,1
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3b6:	4889                	li	a7,2
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <wait>:
.global wait
wait:
 li a7, SYS_wait
 3be:	488d                	li	a7,3
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3c6:	4891                	li	a7,4
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <read>:
.global read
read:
 li a7, SYS_read
 3ce:	4895                	li	a7,5
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <write>:
.global write
write:
 li a7, SYS_write
 3d6:	48c1                	li	a7,16
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <close>:
.global close
close:
 li a7, SYS_close
 3de:	48d5                	li	a7,21
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3e6:	4899                	li	a7,6
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <exec>:
.global exec
exec:
 li a7, SYS_exec
 3ee:	489d                	li	a7,7
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <open>:
.global open
open:
 li a7, SYS_open
 3f6:	48bd                	li	a7,15
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3fe:	48c5                	li	a7,17
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 406:	48c9                	li	a7,18
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 40e:	48a1                	li	a7,8
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <link>:
.global link
link:
 li a7, SYS_link
 416:	48cd                	li	a7,19
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 41e:	48d1                	li	a7,20
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 426:	48a5                	li	a7,9
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <dup>:
.global dup
dup:
 li a7, SYS_dup
 42e:	48a9                	li	a7,10
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 436:	48ad                	li	a7,11
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 43e:	48b1                	li	a7,12
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 446:	48b5                	li	a7,13
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 44e:	48b9                	li	a7,14
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <memsize>:
.global memsize
memsize:
 li a7, SYS_memsize
 456:	48d9                	li	a7,22
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret
