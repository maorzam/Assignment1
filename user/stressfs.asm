
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dd010113          	addi	sp,sp,-560
   4:	22113423          	sd	ra,552(sp)
   8:	22813023          	sd	s0,544(sp)
   c:	20913c23          	sd	s1,536(sp)
  10:	21213823          	sd	s2,528(sp)
  14:	1c00                	addi	s0,sp,560
  int fd, i;
  char path[] = "stressfs0";
  16:	00001797          	auipc	a5,0x1
  1a:	8ea78793          	addi	a5,a5,-1814 # 900 <malloc+0x118>
  1e:	6398                	ld	a4,0(a5)
  20:	fce43823          	sd	a4,-48(s0)
  24:	0087d783          	lhu	a5,8(a5)
  28:	fcf41c23          	sh	a5,-40(s0)
  char data[512];

  printf("stressfs starting\n");
  2c:	00001517          	auipc	a0,0x1
  30:	8a450513          	addi	a0,a0,-1884 # 8d0 <malloc+0xe8>
  34:	00000097          	auipc	ra,0x0
  38:	6f6080e7          	jalr	1782(ra) # 72a <printf>
  memset(data, 'a', sizeof(data));
  3c:	20000613          	li	a2,512
  40:	06100593          	li	a1,97
  44:	dd040513          	addi	a0,s0,-560
  48:	00000097          	auipc	ra,0x0
  4c:	156080e7          	jalr	342(ra) # 19e <memset>

  for(i = 0; i < 4; i++)
  50:	4481                	li	s1,0
  52:	4911                	li	s2,4
    if(fork() > 0)
  54:	00000097          	auipc	ra,0x0
  58:	33e080e7          	jalr	830(ra) # 392 <fork>
  5c:	00a04563          	bgtz	a0,66 <main+0x66>
  for(i = 0; i < 4; i++)
  60:	2485                	addiw	s1,s1,1
  62:	ff2499e3          	bne	s1,s2,54 <main+0x54>
      break;

  printf("write %d\n", i);
  66:	85a6                	mv	a1,s1
  68:	00001517          	auipc	a0,0x1
  6c:	88050513          	addi	a0,a0,-1920 # 8e8 <malloc+0x100>
  70:	00000097          	auipc	ra,0x0
  74:	6ba080e7          	jalr	1722(ra) # 72a <printf>

  path[8] += i;
  78:	fd844783          	lbu	a5,-40(s0)
  7c:	9cbd                	addw	s1,s1,a5
  7e:	fc940c23          	sb	s1,-40(s0)
  fd = open(path, O_CREATE | O_RDWR);
  82:	20200593          	li	a1,514
  86:	fd040513          	addi	a0,s0,-48
  8a:	00000097          	auipc	ra,0x0
  8e:	350080e7          	jalr	848(ra) # 3da <open>
  92:	892a                	mv	s2,a0
  94:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  96:	20000613          	li	a2,512
  9a:	dd040593          	addi	a1,s0,-560
  9e:	854a                	mv	a0,s2
  a0:	00000097          	auipc	ra,0x0
  a4:	31a080e7          	jalr	794(ra) # 3ba <write>
  for(i = 0; i < 20; i++)
  a8:	34fd                	addiw	s1,s1,-1
  aa:	f4f5                	bnez	s1,96 <main+0x96>
  close(fd);
  ac:	854a                	mv	a0,s2
  ae:	00000097          	auipc	ra,0x0
  b2:	314080e7          	jalr	788(ra) # 3c2 <close>

  printf("read\n");
  b6:	00001517          	auipc	a0,0x1
  ba:	84250513          	addi	a0,a0,-1982 # 8f8 <malloc+0x110>
  be:	00000097          	auipc	ra,0x0
  c2:	66c080e7          	jalr	1644(ra) # 72a <printf>

  fd = open(path, O_RDONLY);
  c6:	4581                	li	a1,0
  c8:	fd040513          	addi	a0,s0,-48
  cc:	00000097          	auipc	ra,0x0
  d0:	30e080e7          	jalr	782(ra) # 3da <open>
  d4:	892a                	mv	s2,a0
  d6:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  d8:	20000613          	li	a2,512
  dc:	dd040593          	addi	a1,s0,-560
  e0:	854a                	mv	a0,s2
  e2:	00000097          	auipc	ra,0x0
  e6:	2d0080e7          	jalr	720(ra) # 3b2 <read>
  for (i = 0; i < 20; i++)
  ea:	34fd                	addiw	s1,s1,-1
  ec:	f4f5                	bnez	s1,d8 <main+0xd8>
  close(fd);
  ee:	854a                	mv	a0,s2
  f0:	00000097          	auipc	ra,0x0
  f4:	2d2080e7          	jalr	722(ra) # 3c2 <close>

  wait(0,0);
  f8:	4581                	li	a1,0
  fa:	4501                	li	a0,0
  fc:	00000097          	auipc	ra,0x0
 100:	2a6080e7          	jalr	678(ra) # 3a2 <wait>

  exit(0,0);
 104:	4581                	li	a1,0
 106:	4501                	li	a0,0
 108:	00000097          	auipc	ra,0x0
 10c:	292080e7          	jalr	658(ra) # 39a <exit>

0000000000000110 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 110:	1141                	addi	sp,sp,-16
 112:	e406                	sd	ra,8(sp)
 114:	e022                	sd	s0,0(sp)
 116:	0800                	addi	s0,sp,16
  extern int main();
  main();
 118:	00000097          	auipc	ra,0x0
 11c:	ee8080e7          	jalr	-280(ra) # 0 <main>
  exit(0,0);
 120:	4581                	li	a1,0
 122:	4501                	li	a0,0
 124:	00000097          	auipc	ra,0x0
 128:	276080e7          	jalr	630(ra) # 39a <exit>

000000000000012c <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 12c:	1141                	addi	sp,sp,-16
 12e:	e422                	sd	s0,8(sp)
 130:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 132:	87aa                	mv	a5,a0
 134:	0585                	addi	a1,a1,1
 136:	0785                	addi	a5,a5,1
 138:	fff5c703          	lbu	a4,-1(a1)
 13c:	fee78fa3          	sb	a4,-1(a5)
 140:	fb75                	bnez	a4,134 <strcpy+0x8>
    ;
  return os;
}
 142:	6422                	ld	s0,8(sp)
 144:	0141                	addi	sp,sp,16
 146:	8082                	ret

0000000000000148 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 148:	1141                	addi	sp,sp,-16
 14a:	e422                	sd	s0,8(sp)
 14c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 14e:	00054783          	lbu	a5,0(a0)
 152:	cb91                	beqz	a5,166 <strcmp+0x1e>
 154:	0005c703          	lbu	a4,0(a1)
 158:	00f71763          	bne	a4,a5,166 <strcmp+0x1e>
    p++, q++;
 15c:	0505                	addi	a0,a0,1
 15e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 160:	00054783          	lbu	a5,0(a0)
 164:	fbe5                	bnez	a5,154 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 166:	0005c503          	lbu	a0,0(a1)
}
 16a:	40a7853b          	subw	a0,a5,a0
 16e:	6422                	ld	s0,8(sp)
 170:	0141                	addi	sp,sp,16
 172:	8082                	ret

0000000000000174 <strlen>:

uint
strlen(const char *s)
{
 174:	1141                	addi	sp,sp,-16
 176:	e422                	sd	s0,8(sp)
 178:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 17a:	00054783          	lbu	a5,0(a0)
 17e:	cf91                	beqz	a5,19a <strlen+0x26>
 180:	0505                	addi	a0,a0,1
 182:	87aa                	mv	a5,a0
 184:	4685                	li	a3,1
 186:	9e89                	subw	a3,a3,a0
 188:	00f6853b          	addw	a0,a3,a5
 18c:	0785                	addi	a5,a5,1
 18e:	fff7c703          	lbu	a4,-1(a5)
 192:	fb7d                	bnez	a4,188 <strlen+0x14>
    ;
  return n;
}
 194:	6422                	ld	s0,8(sp)
 196:	0141                	addi	sp,sp,16
 198:	8082                	ret
  for(n = 0; s[n]; n++)
 19a:	4501                	li	a0,0
 19c:	bfe5                	j	194 <strlen+0x20>

000000000000019e <memset>:

void*
memset(void *dst, int c, uint n)
{
 19e:	1141                	addi	sp,sp,-16
 1a0:	e422                	sd	s0,8(sp)
 1a2:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1a4:	ca19                	beqz	a2,1ba <memset+0x1c>
 1a6:	87aa                	mv	a5,a0
 1a8:	1602                	slli	a2,a2,0x20
 1aa:	9201                	srli	a2,a2,0x20
 1ac:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1b0:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1b4:	0785                	addi	a5,a5,1
 1b6:	fee79de3          	bne	a5,a4,1b0 <memset+0x12>
  }
  return dst;
}
 1ba:	6422                	ld	s0,8(sp)
 1bc:	0141                	addi	sp,sp,16
 1be:	8082                	ret

00000000000001c0 <strchr>:

char*
strchr(const char *s, char c)
{
 1c0:	1141                	addi	sp,sp,-16
 1c2:	e422                	sd	s0,8(sp)
 1c4:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1c6:	00054783          	lbu	a5,0(a0)
 1ca:	cb99                	beqz	a5,1e0 <strchr+0x20>
    if(*s == c)
 1cc:	00f58763          	beq	a1,a5,1da <strchr+0x1a>
  for(; *s; s++)
 1d0:	0505                	addi	a0,a0,1
 1d2:	00054783          	lbu	a5,0(a0)
 1d6:	fbfd                	bnez	a5,1cc <strchr+0xc>
      return (char*)s;
  return 0;
 1d8:	4501                	li	a0,0
}
 1da:	6422                	ld	s0,8(sp)
 1dc:	0141                	addi	sp,sp,16
 1de:	8082                	ret
  return 0;
 1e0:	4501                	li	a0,0
 1e2:	bfe5                	j	1da <strchr+0x1a>

00000000000001e4 <gets>:

char*
gets(char *buf, int max)
{
 1e4:	711d                	addi	sp,sp,-96
 1e6:	ec86                	sd	ra,88(sp)
 1e8:	e8a2                	sd	s0,80(sp)
 1ea:	e4a6                	sd	s1,72(sp)
 1ec:	e0ca                	sd	s2,64(sp)
 1ee:	fc4e                	sd	s3,56(sp)
 1f0:	f852                	sd	s4,48(sp)
 1f2:	f456                	sd	s5,40(sp)
 1f4:	f05a                	sd	s6,32(sp)
 1f6:	ec5e                	sd	s7,24(sp)
 1f8:	1080                	addi	s0,sp,96
 1fa:	8baa                	mv	s7,a0
 1fc:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1fe:	892a                	mv	s2,a0
 200:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 202:	4aa9                	li	s5,10
 204:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 206:	89a6                	mv	s3,s1
 208:	2485                	addiw	s1,s1,1
 20a:	0344d863          	bge	s1,s4,23a <gets+0x56>
    cc = read(0, &c, 1);
 20e:	4605                	li	a2,1
 210:	faf40593          	addi	a1,s0,-81
 214:	4501                	li	a0,0
 216:	00000097          	auipc	ra,0x0
 21a:	19c080e7          	jalr	412(ra) # 3b2 <read>
    if(cc < 1)
 21e:	00a05e63          	blez	a0,23a <gets+0x56>
    buf[i++] = c;
 222:	faf44783          	lbu	a5,-81(s0)
 226:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 22a:	01578763          	beq	a5,s5,238 <gets+0x54>
 22e:	0905                	addi	s2,s2,1
 230:	fd679be3          	bne	a5,s6,206 <gets+0x22>
  for(i=0; i+1 < max; ){
 234:	89a6                	mv	s3,s1
 236:	a011                	j	23a <gets+0x56>
 238:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 23a:	99de                	add	s3,s3,s7
 23c:	00098023          	sb	zero,0(s3)
  return buf;
}
 240:	855e                	mv	a0,s7
 242:	60e6                	ld	ra,88(sp)
 244:	6446                	ld	s0,80(sp)
 246:	64a6                	ld	s1,72(sp)
 248:	6906                	ld	s2,64(sp)
 24a:	79e2                	ld	s3,56(sp)
 24c:	7a42                	ld	s4,48(sp)
 24e:	7aa2                	ld	s5,40(sp)
 250:	7b02                	ld	s6,32(sp)
 252:	6be2                	ld	s7,24(sp)
 254:	6125                	addi	sp,sp,96
 256:	8082                	ret

0000000000000258 <stat>:

int
stat(const char *n, struct stat *st)
{
 258:	1101                	addi	sp,sp,-32
 25a:	ec06                	sd	ra,24(sp)
 25c:	e822                	sd	s0,16(sp)
 25e:	e426                	sd	s1,8(sp)
 260:	e04a                	sd	s2,0(sp)
 262:	1000                	addi	s0,sp,32
 264:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 266:	4581                	li	a1,0
 268:	00000097          	auipc	ra,0x0
 26c:	172080e7          	jalr	370(ra) # 3da <open>
  if(fd < 0)
 270:	02054563          	bltz	a0,29a <stat+0x42>
 274:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 276:	85ca                	mv	a1,s2
 278:	00000097          	auipc	ra,0x0
 27c:	17a080e7          	jalr	378(ra) # 3f2 <fstat>
 280:	892a                	mv	s2,a0
  close(fd);
 282:	8526                	mv	a0,s1
 284:	00000097          	auipc	ra,0x0
 288:	13e080e7          	jalr	318(ra) # 3c2 <close>
  return r;
}
 28c:	854a                	mv	a0,s2
 28e:	60e2                	ld	ra,24(sp)
 290:	6442                	ld	s0,16(sp)
 292:	64a2                	ld	s1,8(sp)
 294:	6902                	ld	s2,0(sp)
 296:	6105                	addi	sp,sp,32
 298:	8082                	ret
    return -1;
 29a:	597d                	li	s2,-1
 29c:	bfc5                	j	28c <stat+0x34>

000000000000029e <atoi>:

int
atoi(const char *s)
{
 29e:	1141                	addi	sp,sp,-16
 2a0:	e422                	sd	s0,8(sp)
 2a2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2a4:	00054603          	lbu	a2,0(a0)
 2a8:	fd06079b          	addiw	a5,a2,-48
 2ac:	0ff7f793          	andi	a5,a5,255
 2b0:	4725                	li	a4,9
 2b2:	02f76963          	bltu	a4,a5,2e4 <atoi+0x46>
 2b6:	86aa                	mv	a3,a0
  n = 0;
 2b8:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 2ba:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2bc:	0685                	addi	a3,a3,1
 2be:	0025179b          	slliw	a5,a0,0x2
 2c2:	9fa9                	addw	a5,a5,a0
 2c4:	0017979b          	slliw	a5,a5,0x1
 2c8:	9fb1                	addw	a5,a5,a2
 2ca:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2ce:	0006c603          	lbu	a2,0(a3)
 2d2:	fd06071b          	addiw	a4,a2,-48
 2d6:	0ff77713          	andi	a4,a4,255
 2da:	fee5f1e3          	bgeu	a1,a4,2bc <atoi+0x1e>
  return n;
}
 2de:	6422                	ld	s0,8(sp)
 2e0:	0141                	addi	sp,sp,16
 2e2:	8082                	ret
  n = 0;
 2e4:	4501                	li	a0,0
 2e6:	bfe5                	j	2de <atoi+0x40>

00000000000002e8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2e8:	1141                	addi	sp,sp,-16
 2ea:	e422                	sd	s0,8(sp)
 2ec:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2ee:	02b57463          	bgeu	a0,a1,316 <memmove+0x2e>
    while(n-- > 0)
 2f2:	00c05f63          	blez	a2,310 <memmove+0x28>
 2f6:	1602                	slli	a2,a2,0x20
 2f8:	9201                	srli	a2,a2,0x20
 2fa:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2fe:	872a                	mv	a4,a0
      *dst++ = *src++;
 300:	0585                	addi	a1,a1,1
 302:	0705                	addi	a4,a4,1
 304:	fff5c683          	lbu	a3,-1(a1)
 308:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 30c:	fee79ae3          	bne	a5,a4,300 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 310:	6422                	ld	s0,8(sp)
 312:	0141                	addi	sp,sp,16
 314:	8082                	ret
    dst += n;
 316:	00c50733          	add	a4,a0,a2
    src += n;
 31a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 31c:	fec05ae3          	blez	a2,310 <memmove+0x28>
 320:	fff6079b          	addiw	a5,a2,-1
 324:	1782                	slli	a5,a5,0x20
 326:	9381                	srli	a5,a5,0x20
 328:	fff7c793          	not	a5,a5
 32c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 32e:	15fd                	addi	a1,a1,-1
 330:	177d                	addi	a4,a4,-1
 332:	0005c683          	lbu	a3,0(a1)
 336:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 33a:	fee79ae3          	bne	a5,a4,32e <memmove+0x46>
 33e:	bfc9                	j	310 <memmove+0x28>

0000000000000340 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 340:	1141                	addi	sp,sp,-16
 342:	e422                	sd	s0,8(sp)
 344:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 346:	ca05                	beqz	a2,376 <memcmp+0x36>
 348:	fff6069b          	addiw	a3,a2,-1
 34c:	1682                	slli	a3,a3,0x20
 34e:	9281                	srli	a3,a3,0x20
 350:	0685                	addi	a3,a3,1
 352:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 354:	00054783          	lbu	a5,0(a0)
 358:	0005c703          	lbu	a4,0(a1)
 35c:	00e79863          	bne	a5,a4,36c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 360:	0505                	addi	a0,a0,1
    p2++;
 362:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 364:	fed518e3          	bne	a0,a3,354 <memcmp+0x14>
  }
  return 0;
 368:	4501                	li	a0,0
 36a:	a019                	j	370 <memcmp+0x30>
      return *p1 - *p2;
 36c:	40e7853b          	subw	a0,a5,a4
}
 370:	6422                	ld	s0,8(sp)
 372:	0141                	addi	sp,sp,16
 374:	8082                	ret
  return 0;
 376:	4501                	li	a0,0
 378:	bfe5                	j	370 <memcmp+0x30>

000000000000037a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 37a:	1141                	addi	sp,sp,-16
 37c:	e406                	sd	ra,8(sp)
 37e:	e022                	sd	s0,0(sp)
 380:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 382:	00000097          	auipc	ra,0x0
 386:	f66080e7          	jalr	-154(ra) # 2e8 <memmove>
}
 38a:	60a2                	ld	ra,8(sp)
 38c:	6402                	ld	s0,0(sp)
 38e:	0141                	addi	sp,sp,16
 390:	8082                	ret

0000000000000392 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 392:	4885                	li	a7,1
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <exit>:
.global exit
exit:
 li a7, SYS_exit
 39a:	4889                	li	a7,2
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3a2:	488d                	li	a7,3
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3aa:	4891                	li	a7,4
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <read>:
.global read
read:
 li a7, SYS_read
 3b2:	4895                	li	a7,5
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <write>:
.global write
write:
 li a7, SYS_write
 3ba:	48c1                	li	a7,16
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <close>:
.global close
close:
 li a7, SYS_close
 3c2:	48d5                	li	a7,21
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <kill>:
.global kill
kill:
 li a7, SYS_kill
 3ca:	4899                	li	a7,6
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3d2:	489d                	li	a7,7
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <open>:
.global open
open:
 li a7, SYS_open
 3da:	48bd                	li	a7,15
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3e2:	48c5                	li	a7,17
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3ea:	48c9                	li	a7,18
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3f2:	48a1                	li	a7,8
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <link>:
.global link
link:
 li a7, SYS_link
 3fa:	48cd                	li	a7,19
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 402:	48d1                	li	a7,20
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 40a:	48a5                	li	a7,9
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <dup>:
.global dup
dup:
 li a7, SYS_dup
 412:	48a9                	li	a7,10
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 41a:	48ad                	li	a7,11
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 422:	48b1                	li	a7,12
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 42a:	48b5                	li	a7,13
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 432:	48b9                	li	a7,14
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <memsize>:
.global memsize
memsize:
 li a7, SYS_memsize
 43a:	48d9                	li	a7,22
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <set_ps_priority>:
.global set_ps_priority
set_ps_priority:
 li a7, SYS_set_ps_priority
 442:	48dd                	li	a7,23
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <set_cfs_priority>:
.global set_cfs_priority
set_cfs_priority:
 li a7, SYS_set_cfs_priority
 44a:	48e1                	li	a7,24
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 452:	1101                	addi	sp,sp,-32
 454:	ec06                	sd	ra,24(sp)
 456:	e822                	sd	s0,16(sp)
 458:	1000                	addi	s0,sp,32
 45a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 45e:	4605                	li	a2,1
 460:	fef40593          	addi	a1,s0,-17
 464:	00000097          	auipc	ra,0x0
 468:	f56080e7          	jalr	-170(ra) # 3ba <write>
}
 46c:	60e2                	ld	ra,24(sp)
 46e:	6442                	ld	s0,16(sp)
 470:	6105                	addi	sp,sp,32
 472:	8082                	ret

0000000000000474 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 474:	7139                	addi	sp,sp,-64
 476:	fc06                	sd	ra,56(sp)
 478:	f822                	sd	s0,48(sp)
 47a:	f426                	sd	s1,40(sp)
 47c:	f04a                	sd	s2,32(sp)
 47e:	ec4e                	sd	s3,24(sp)
 480:	0080                	addi	s0,sp,64
 482:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 484:	c299                	beqz	a3,48a <printint+0x16>
 486:	0805c863          	bltz	a1,516 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 48a:	2581                	sext.w	a1,a1
  neg = 0;
 48c:	4881                	li	a7,0
 48e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 492:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 494:	2601                	sext.w	a2,a2
 496:	00000517          	auipc	a0,0x0
 49a:	48250513          	addi	a0,a0,1154 # 918 <digits>
 49e:	883a                	mv	a6,a4
 4a0:	2705                	addiw	a4,a4,1
 4a2:	02c5f7bb          	remuw	a5,a1,a2
 4a6:	1782                	slli	a5,a5,0x20
 4a8:	9381                	srli	a5,a5,0x20
 4aa:	97aa                	add	a5,a5,a0
 4ac:	0007c783          	lbu	a5,0(a5)
 4b0:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4b4:	0005879b          	sext.w	a5,a1
 4b8:	02c5d5bb          	divuw	a1,a1,a2
 4bc:	0685                	addi	a3,a3,1
 4be:	fec7f0e3          	bgeu	a5,a2,49e <printint+0x2a>
  if(neg)
 4c2:	00088b63          	beqz	a7,4d8 <printint+0x64>
    buf[i++] = '-';
 4c6:	fd040793          	addi	a5,s0,-48
 4ca:	973e                	add	a4,a4,a5
 4cc:	02d00793          	li	a5,45
 4d0:	fef70823          	sb	a5,-16(a4)
 4d4:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4d8:	02e05863          	blez	a4,508 <printint+0x94>
 4dc:	fc040793          	addi	a5,s0,-64
 4e0:	00e78933          	add	s2,a5,a4
 4e4:	fff78993          	addi	s3,a5,-1
 4e8:	99ba                	add	s3,s3,a4
 4ea:	377d                	addiw	a4,a4,-1
 4ec:	1702                	slli	a4,a4,0x20
 4ee:	9301                	srli	a4,a4,0x20
 4f0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4f4:	fff94583          	lbu	a1,-1(s2)
 4f8:	8526                	mv	a0,s1
 4fa:	00000097          	auipc	ra,0x0
 4fe:	f58080e7          	jalr	-168(ra) # 452 <putc>
  while(--i >= 0)
 502:	197d                	addi	s2,s2,-1
 504:	ff3918e3          	bne	s2,s3,4f4 <printint+0x80>
}
 508:	70e2                	ld	ra,56(sp)
 50a:	7442                	ld	s0,48(sp)
 50c:	74a2                	ld	s1,40(sp)
 50e:	7902                	ld	s2,32(sp)
 510:	69e2                	ld	s3,24(sp)
 512:	6121                	addi	sp,sp,64
 514:	8082                	ret
    x = -xx;
 516:	40b005bb          	negw	a1,a1
    neg = 1;
 51a:	4885                	li	a7,1
    x = -xx;
 51c:	bf8d                	j	48e <printint+0x1a>

000000000000051e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 51e:	7119                	addi	sp,sp,-128
 520:	fc86                	sd	ra,120(sp)
 522:	f8a2                	sd	s0,112(sp)
 524:	f4a6                	sd	s1,104(sp)
 526:	f0ca                	sd	s2,96(sp)
 528:	ecce                	sd	s3,88(sp)
 52a:	e8d2                	sd	s4,80(sp)
 52c:	e4d6                	sd	s5,72(sp)
 52e:	e0da                	sd	s6,64(sp)
 530:	fc5e                	sd	s7,56(sp)
 532:	f862                	sd	s8,48(sp)
 534:	f466                	sd	s9,40(sp)
 536:	f06a                	sd	s10,32(sp)
 538:	ec6e                	sd	s11,24(sp)
 53a:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 53c:	0005c903          	lbu	s2,0(a1)
 540:	18090f63          	beqz	s2,6de <vprintf+0x1c0>
 544:	8aaa                	mv	s5,a0
 546:	8b32                	mv	s6,a2
 548:	00158493          	addi	s1,a1,1
  state = 0;
 54c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 54e:	02500a13          	li	s4,37
      if(c == 'd'){
 552:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 556:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 55a:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 55e:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 562:	00000b97          	auipc	s7,0x0
 566:	3b6b8b93          	addi	s7,s7,950 # 918 <digits>
 56a:	a839                	j	588 <vprintf+0x6a>
        putc(fd, c);
 56c:	85ca                	mv	a1,s2
 56e:	8556                	mv	a0,s5
 570:	00000097          	auipc	ra,0x0
 574:	ee2080e7          	jalr	-286(ra) # 452 <putc>
 578:	a019                	j	57e <vprintf+0x60>
    } else if(state == '%'){
 57a:	01498f63          	beq	s3,s4,598 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 57e:	0485                	addi	s1,s1,1
 580:	fff4c903          	lbu	s2,-1(s1)
 584:	14090d63          	beqz	s2,6de <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 588:	0009079b          	sext.w	a5,s2
    if(state == 0){
 58c:	fe0997e3          	bnez	s3,57a <vprintf+0x5c>
      if(c == '%'){
 590:	fd479ee3          	bne	a5,s4,56c <vprintf+0x4e>
        state = '%';
 594:	89be                	mv	s3,a5
 596:	b7e5                	j	57e <vprintf+0x60>
      if(c == 'd'){
 598:	05878063          	beq	a5,s8,5d8 <vprintf+0xba>
      } else if(c == 'l') {
 59c:	05978c63          	beq	a5,s9,5f4 <vprintf+0xd6>
      } else if(c == 'x') {
 5a0:	07a78863          	beq	a5,s10,610 <vprintf+0xf2>
      } else if(c == 'p') {
 5a4:	09b78463          	beq	a5,s11,62c <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 5a8:	07300713          	li	a4,115
 5ac:	0ce78663          	beq	a5,a4,678 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5b0:	06300713          	li	a4,99
 5b4:	0ee78e63          	beq	a5,a4,6b0 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 5b8:	11478863          	beq	a5,s4,6c8 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5bc:	85d2                	mv	a1,s4
 5be:	8556                	mv	a0,s5
 5c0:	00000097          	auipc	ra,0x0
 5c4:	e92080e7          	jalr	-366(ra) # 452 <putc>
        putc(fd, c);
 5c8:	85ca                	mv	a1,s2
 5ca:	8556                	mv	a0,s5
 5cc:	00000097          	auipc	ra,0x0
 5d0:	e86080e7          	jalr	-378(ra) # 452 <putc>
      }
      state = 0;
 5d4:	4981                	li	s3,0
 5d6:	b765                	j	57e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 5d8:	008b0913          	addi	s2,s6,8
 5dc:	4685                	li	a3,1
 5de:	4629                	li	a2,10
 5e0:	000b2583          	lw	a1,0(s6)
 5e4:	8556                	mv	a0,s5
 5e6:	00000097          	auipc	ra,0x0
 5ea:	e8e080e7          	jalr	-370(ra) # 474 <printint>
 5ee:	8b4a                	mv	s6,s2
      state = 0;
 5f0:	4981                	li	s3,0
 5f2:	b771                	j	57e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5f4:	008b0913          	addi	s2,s6,8
 5f8:	4681                	li	a3,0
 5fa:	4629                	li	a2,10
 5fc:	000b2583          	lw	a1,0(s6)
 600:	8556                	mv	a0,s5
 602:	00000097          	auipc	ra,0x0
 606:	e72080e7          	jalr	-398(ra) # 474 <printint>
 60a:	8b4a                	mv	s6,s2
      state = 0;
 60c:	4981                	li	s3,0
 60e:	bf85                	j	57e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 610:	008b0913          	addi	s2,s6,8
 614:	4681                	li	a3,0
 616:	4641                	li	a2,16
 618:	000b2583          	lw	a1,0(s6)
 61c:	8556                	mv	a0,s5
 61e:	00000097          	auipc	ra,0x0
 622:	e56080e7          	jalr	-426(ra) # 474 <printint>
 626:	8b4a                	mv	s6,s2
      state = 0;
 628:	4981                	li	s3,0
 62a:	bf91                	j	57e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 62c:	008b0793          	addi	a5,s6,8
 630:	f8f43423          	sd	a5,-120(s0)
 634:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 638:	03000593          	li	a1,48
 63c:	8556                	mv	a0,s5
 63e:	00000097          	auipc	ra,0x0
 642:	e14080e7          	jalr	-492(ra) # 452 <putc>
  putc(fd, 'x');
 646:	85ea                	mv	a1,s10
 648:	8556                	mv	a0,s5
 64a:	00000097          	auipc	ra,0x0
 64e:	e08080e7          	jalr	-504(ra) # 452 <putc>
 652:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 654:	03c9d793          	srli	a5,s3,0x3c
 658:	97de                	add	a5,a5,s7
 65a:	0007c583          	lbu	a1,0(a5)
 65e:	8556                	mv	a0,s5
 660:	00000097          	auipc	ra,0x0
 664:	df2080e7          	jalr	-526(ra) # 452 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 668:	0992                	slli	s3,s3,0x4
 66a:	397d                	addiw	s2,s2,-1
 66c:	fe0914e3          	bnez	s2,654 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 670:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 674:	4981                	li	s3,0
 676:	b721                	j	57e <vprintf+0x60>
        s = va_arg(ap, char*);
 678:	008b0993          	addi	s3,s6,8
 67c:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 680:	02090163          	beqz	s2,6a2 <vprintf+0x184>
        while(*s != 0){
 684:	00094583          	lbu	a1,0(s2)
 688:	c9a1                	beqz	a1,6d8 <vprintf+0x1ba>
          putc(fd, *s);
 68a:	8556                	mv	a0,s5
 68c:	00000097          	auipc	ra,0x0
 690:	dc6080e7          	jalr	-570(ra) # 452 <putc>
          s++;
 694:	0905                	addi	s2,s2,1
        while(*s != 0){
 696:	00094583          	lbu	a1,0(s2)
 69a:	f9e5                	bnez	a1,68a <vprintf+0x16c>
        s = va_arg(ap, char*);
 69c:	8b4e                	mv	s6,s3
      state = 0;
 69e:	4981                	li	s3,0
 6a0:	bdf9                	j	57e <vprintf+0x60>
          s = "(null)";
 6a2:	00000917          	auipc	s2,0x0
 6a6:	26e90913          	addi	s2,s2,622 # 910 <malloc+0x128>
        while(*s != 0){
 6aa:	02800593          	li	a1,40
 6ae:	bff1                	j	68a <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 6b0:	008b0913          	addi	s2,s6,8
 6b4:	000b4583          	lbu	a1,0(s6)
 6b8:	8556                	mv	a0,s5
 6ba:	00000097          	auipc	ra,0x0
 6be:	d98080e7          	jalr	-616(ra) # 452 <putc>
 6c2:	8b4a                	mv	s6,s2
      state = 0;
 6c4:	4981                	li	s3,0
 6c6:	bd65                	j	57e <vprintf+0x60>
        putc(fd, c);
 6c8:	85d2                	mv	a1,s4
 6ca:	8556                	mv	a0,s5
 6cc:	00000097          	auipc	ra,0x0
 6d0:	d86080e7          	jalr	-634(ra) # 452 <putc>
      state = 0;
 6d4:	4981                	li	s3,0
 6d6:	b565                	j	57e <vprintf+0x60>
        s = va_arg(ap, char*);
 6d8:	8b4e                	mv	s6,s3
      state = 0;
 6da:	4981                	li	s3,0
 6dc:	b54d                	j	57e <vprintf+0x60>
    }
  }
}
 6de:	70e6                	ld	ra,120(sp)
 6e0:	7446                	ld	s0,112(sp)
 6e2:	74a6                	ld	s1,104(sp)
 6e4:	7906                	ld	s2,96(sp)
 6e6:	69e6                	ld	s3,88(sp)
 6e8:	6a46                	ld	s4,80(sp)
 6ea:	6aa6                	ld	s5,72(sp)
 6ec:	6b06                	ld	s6,64(sp)
 6ee:	7be2                	ld	s7,56(sp)
 6f0:	7c42                	ld	s8,48(sp)
 6f2:	7ca2                	ld	s9,40(sp)
 6f4:	7d02                	ld	s10,32(sp)
 6f6:	6de2                	ld	s11,24(sp)
 6f8:	6109                	addi	sp,sp,128
 6fa:	8082                	ret

00000000000006fc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6fc:	715d                	addi	sp,sp,-80
 6fe:	ec06                	sd	ra,24(sp)
 700:	e822                	sd	s0,16(sp)
 702:	1000                	addi	s0,sp,32
 704:	e010                	sd	a2,0(s0)
 706:	e414                	sd	a3,8(s0)
 708:	e818                	sd	a4,16(s0)
 70a:	ec1c                	sd	a5,24(s0)
 70c:	03043023          	sd	a6,32(s0)
 710:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 714:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 718:	8622                	mv	a2,s0
 71a:	00000097          	auipc	ra,0x0
 71e:	e04080e7          	jalr	-508(ra) # 51e <vprintf>
}
 722:	60e2                	ld	ra,24(sp)
 724:	6442                	ld	s0,16(sp)
 726:	6161                	addi	sp,sp,80
 728:	8082                	ret

000000000000072a <printf>:

void
printf(const char *fmt, ...)
{
 72a:	711d                	addi	sp,sp,-96
 72c:	ec06                	sd	ra,24(sp)
 72e:	e822                	sd	s0,16(sp)
 730:	1000                	addi	s0,sp,32
 732:	e40c                	sd	a1,8(s0)
 734:	e810                	sd	a2,16(s0)
 736:	ec14                	sd	a3,24(s0)
 738:	f018                	sd	a4,32(s0)
 73a:	f41c                	sd	a5,40(s0)
 73c:	03043823          	sd	a6,48(s0)
 740:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 744:	00840613          	addi	a2,s0,8
 748:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 74c:	85aa                	mv	a1,a0
 74e:	4505                	li	a0,1
 750:	00000097          	auipc	ra,0x0
 754:	dce080e7          	jalr	-562(ra) # 51e <vprintf>
}
 758:	60e2                	ld	ra,24(sp)
 75a:	6442                	ld	s0,16(sp)
 75c:	6125                	addi	sp,sp,96
 75e:	8082                	ret

0000000000000760 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 760:	1141                	addi	sp,sp,-16
 762:	e422                	sd	s0,8(sp)
 764:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 766:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 76a:	00001797          	auipc	a5,0x1
 76e:	8967b783          	ld	a5,-1898(a5) # 1000 <freep>
 772:	a805                	j	7a2 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 774:	4618                	lw	a4,8(a2)
 776:	9db9                	addw	a1,a1,a4
 778:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 77c:	6398                	ld	a4,0(a5)
 77e:	6318                	ld	a4,0(a4)
 780:	fee53823          	sd	a4,-16(a0)
 784:	a091                	j	7c8 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 786:	ff852703          	lw	a4,-8(a0)
 78a:	9e39                	addw	a2,a2,a4
 78c:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 78e:	ff053703          	ld	a4,-16(a0)
 792:	e398                	sd	a4,0(a5)
 794:	a099                	j	7da <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 796:	6398                	ld	a4,0(a5)
 798:	00e7e463          	bltu	a5,a4,7a0 <free+0x40>
 79c:	00e6ea63          	bltu	a3,a4,7b0 <free+0x50>
{
 7a0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a2:	fed7fae3          	bgeu	a5,a3,796 <free+0x36>
 7a6:	6398                	ld	a4,0(a5)
 7a8:	00e6e463          	bltu	a3,a4,7b0 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ac:	fee7eae3          	bltu	a5,a4,7a0 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 7b0:	ff852583          	lw	a1,-8(a0)
 7b4:	6390                	ld	a2,0(a5)
 7b6:	02059713          	slli	a4,a1,0x20
 7ba:	9301                	srli	a4,a4,0x20
 7bc:	0712                	slli	a4,a4,0x4
 7be:	9736                	add	a4,a4,a3
 7c0:	fae60ae3          	beq	a2,a4,774 <free+0x14>
    bp->s.ptr = p->s.ptr;
 7c4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7c8:	4790                	lw	a2,8(a5)
 7ca:	02061713          	slli	a4,a2,0x20
 7ce:	9301                	srli	a4,a4,0x20
 7d0:	0712                	slli	a4,a4,0x4
 7d2:	973e                	add	a4,a4,a5
 7d4:	fae689e3          	beq	a3,a4,786 <free+0x26>
  } else
    p->s.ptr = bp;
 7d8:	e394                	sd	a3,0(a5)
  freep = p;
 7da:	00001717          	auipc	a4,0x1
 7de:	82f73323          	sd	a5,-2010(a4) # 1000 <freep>
}
 7e2:	6422                	ld	s0,8(sp)
 7e4:	0141                	addi	sp,sp,16
 7e6:	8082                	ret

00000000000007e8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7e8:	7139                	addi	sp,sp,-64
 7ea:	fc06                	sd	ra,56(sp)
 7ec:	f822                	sd	s0,48(sp)
 7ee:	f426                	sd	s1,40(sp)
 7f0:	f04a                	sd	s2,32(sp)
 7f2:	ec4e                	sd	s3,24(sp)
 7f4:	e852                	sd	s4,16(sp)
 7f6:	e456                	sd	s5,8(sp)
 7f8:	e05a                	sd	s6,0(sp)
 7fa:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7fc:	02051493          	slli	s1,a0,0x20
 800:	9081                	srli	s1,s1,0x20
 802:	04bd                	addi	s1,s1,15
 804:	8091                	srli	s1,s1,0x4
 806:	0014899b          	addiw	s3,s1,1
 80a:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 80c:	00000517          	auipc	a0,0x0
 810:	7f453503          	ld	a0,2036(a0) # 1000 <freep>
 814:	c515                	beqz	a0,840 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 816:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 818:	4798                	lw	a4,8(a5)
 81a:	02977f63          	bgeu	a4,s1,858 <malloc+0x70>
 81e:	8a4e                	mv	s4,s3
 820:	0009871b          	sext.w	a4,s3
 824:	6685                	lui	a3,0x1
 826:	00d77363          	bgeu	a4,a3,82c <malloc+0x44>
 82a:	6a05                	lui	s4,0x1
 82c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 830:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 834:	00000917          	auipc	s2,0x0
 838:	7cc90913          	addi	s2,s2,1996 # 1000 <freep>
  if(p == (char*)-1)
 83c:	5afd                	li	s5,-1
 83e:	a88d                	j	8b0 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 840:	00000797          	auipc	a5,0x0
 844:	7d078793          	addi	a5,a5,2000 # 1010 <base>
 848:	00000717          	auipc	a4,0x0
 84c:	7af73c23          	sd	a5,1976(a4) # 1000 <freep>
 850:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 852:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 856:	b7e1                	j	81e <malloc+0x36>
      if(p->s.size == nunits)
 858:	02e48b63          	beq	s1,a4,88e <malloc+0xa6>
        p->s.size -= nunits;
 85c:	4137073b          	subw	a4,a4,s3
 860:	c798                	sw	a4,8(a5)
        p += p->s.size;
 862:	1702                	slli	a4,a4,0x20
 864:	9301                	srli	a4,a4,0x20
 866:	0712                	slli	a4,a4,0x4
 868:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 86a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 86e:	00000717          	auipc	a4,0x0
 872:	78a73923          	sd	a0,1938(a4) # 1000 <freep>
      return (void*)(p + 1);
 876:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 87a:	70e2                	ld	ra,56(sp)
 87c:	7442                	ld	s0,48(sp)
 87e:	74a2                	ld	s1,40(sp)
 880:	7902                	ld	s2,32(sp)
 882:	69e2                	ld	s3,24(sp)
 884:	6a42                	ld	s4,16(sp)
 886:	6aa2                	ld	s5,8(sp)
 888:	6b02                	ld	s6,0(sp)
 88a:	6121                	addi	sp,sp,64
 88c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 88e:	6398                	ld	a4,0(a5)
 890:	e118                	sd	a4,0(a0)
 892:	bff1                	j	86e <malloc+0x86>
  hp->s.size = nu;
 894:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 898:	0541                	addi	a0,a0,16
 89a:	00000097          	auipc	ra,0x0
 89e:	ec6080e7          	jalr	-314(ra) # 760 <free>
  return freep;
 8a2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8a6:	d971                	beqz	a0,87a <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8a8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8aa:	4798                	lw	a4,8(a5)
 8ac:	fa9776e3          	bgeu	a4,s1,858 <malloc+0x70>
    if(p == freep)
 8b0:	00093703          	ld	a4,0(s2)
 8b4:	853e                	mv	a0,a5
 8b6:	fef719e3          	bne	a4,a5,8a8 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 8ba:	8552                	mv	a0,s4
 8bc:	00000097          	auipc	ra,0x0
 8c0:	b66080e7          	jalr	-1178(ra) # 422 <sbrk>
  if(p == (char*)-1)
 8c4:	fd5518e3          	bne	a0,s5,894 <malloc+0xac>
        return 0;
 8c8:	4501                	li	a0,0
 8ca:	bf45                	j	87a <malloc+0x92>
