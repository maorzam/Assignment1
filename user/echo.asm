
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  int i;

  for(i = 1; i < argc; i++){
  10:	4785                	li	a5,1
  12:	06a7d463          	bge	a5,a0,7a <main+0x7a>
  16:	00858493          	addi	s1,a1,8
  1a:	ffe5099b          	addiw	s3,a0,-2
  1e:	1982                	slli	s3,s3,0x20
  20:	0209d993          	srli	s3,s3,0x20
  24:	098e                	slli	s3,s3,0x3
  26:	05c1                	addi	a1,a1,16
  28:	99ae                	add	s3,s3,a1
    write(1, argv[i], strlen(argv[i]));
    if(i + 1 < argc){
      write(1, " ", 1);
  2a:	00001a17          	auipc	s4,0x1
  2e:	826a0a13          	addi	s4,s4,-2010 # 850 <malloc+0xf2>
    write(1, argv[i], strlen(argv[i]));
  32:	0004b903          	ld	s2,0(s1)
  36:	854a                	mv	a0,s2
  38:	00000097          	auipc	ra,0x0
  3c:	0b2080e7          	jalr	178(ra) # ea <strlen>
  40:	0005061b          	sext.w	a2,a0
  44:	85ca                	mv	a1,s2
  46:	4505                	li	a0,1
  48:	00000097          	auipc	ra,0x0
  4c:	2e8080e7          	jalr	744(ra) # 330 <write>
    if(i + 1 < argc){
  50:	04a1                	addi	s1,s1,8
  52:	01348a63          	beq	s1,s3,66 <main+0x66>
      write(1, " ", 1);
  56:	4605                	li	a2,1
  58:	85d2                	mv	a1,s4
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	2d4080e7          	jalr	724(ra) # 330 <write>
  for(i = 1; i < argc; i++){
  64:	b7f9                	j	32 <main+0x32>
    } else {
      write(1, "\n", 1);
  66:	4605                	li	a2,1
  68:	00000597          	auipc	a1,0x0
  6c:	7f058593          	addi	a1,a1,2032 # 858 <malloc+0xfa>
  70:	4505                	li	a0,1
  72:	00000097          	auipc	ra,0x0
  76:	2be080e7          	jalr	702(ra) # 330 <write>
    }
  }
  exit(0,0);
  7a:	4581                	li	a1,0
  7c:	4501                	li	a0,0
  7e:	00000097          	auipc	ra,0x0
  82:	292080e7          	jalr	658(ra) # 310 <exit>

0000000000000086 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  86:	1141                	addi	sp,sp,-16
  88:	e406                	sd	ra,8(sp)
  8a:	e022                	sd	s0,0(sp)
  8c:	0800                	addi	s0,sp,16
  extern int main();
  main();
  8e:	00000097          	auipc	ra,0x0
  92:	f72080e7          	jalr	-142(ra) # 0 <main>
  exit(0,0);
  96:	4581                	li	a1,0
  98:	4501                	li	a0,0
  9a:	00000097          	auipc	ra,0x0
  9e:	276080e7          	jalr	630(ra) # 310 <exit>

00000000000000a2 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  a2:	1141                	addi	sp,sp,-16
  a4:	e422                	sd	s0,8(sp)
  a6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  a8:	87aa                	mv	a5,a0
  aa:	0585                	addi	a1,a1,1
  ac:	0785                	addi	a5,a5,1
  ae:	fff5c703          	lbu	a4,-1(a1)
  b2:	fee78fa3          	sb	a4,-1(a5)
  b6:	fb75                	bnez	a4,aa <strcpy+0x8>
    ;
  return os;
}
  b8:	6422                	ld	s0,8(sp)
  ba:	0141                	addi	sp,sp,16
  bc:	8082                	ret

00000000000000be <strcmp>:

int
strcmp(const char *p, const char *q)
{
  be:	1141                	addi	sp,sp,-16
  c0:	e422                	sd	s0,8(sp)
  c2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  c4:	00054783          	lbu	a5,0(a0)
  c8:	cb91                	beqz	a5,dc <strcmp+0x1e>
  ca:	0005c703          	lbu	a4,0(a1)
  ce:	00f71763          	bne	a4,a5,dc <strcmp+0x1e>
    p++, q++;
  d2:	0505                	addi	a0,a0,1
  d4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  d6:	00054783          	lbu	a5,0(a0)
  da:	fbe5                	bnez	a5,ca <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  dc:	0005c503          	lbu	a0,0(a1)
}
  e0:	40a7853b          	subw	a0,a5,a0
  e4:	6422                	ld	s0,8(sp)
  e6:	0141                	addi	sp,sp,16
  e8:	8082                	ret

00000000000000ea <strlen>:

uint
strlen(const char *s)
{
  ea:	1141                	addi	sp,sp,-16
  ec:	e422                	sd	s0,8(sp)
  ee:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  f0:	00054783          	lbu	a5,0(a0)
  f4:	cf91                	beqz	a5,110 <strlen+0x26>
  f6:	0505                	addi	a0,a0,1
  f8:	87aa                	mv	a5,a0
  fa:	4685                	li	a3,1
  fc:	9e89                	subw	a3,a3,a0
  fe:	00f6853b          	addw	a0,a3,a5
 102:	0785                	addi	a5,a5,1
 104:	fff7c703          	lbu	a4,-1(a5)
 108:	fb7d                	bnez	a4,fe <strlen+0x14>
    ;
  return n;
}
 10a:	6422                	ld	s0,8(sp)
 10c:	0141                	addi	sp,sp,16
 10e:	8082                	ret
  for(n = 0; s[n]; n++)
 110:	4501                	li	a0,0
 112:	bfe5                	j	10a <strlen+0x20>

0000000000000114 <memset>:

void*
memset(void *dst, int c, uint n)
{
 114:	1141                	addi	sp,sp,-16
 116:	e422                	sd	s0,8(sp)
 118:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 11a:	ca19                	beqz	a2,130 <memset+0x1c>
 11c:	87aa                	mv	a5,a0
 11e:	1602                	slli	a2,a2,0x20
 120:	9201                	srli	a2,a2,0x20
 122:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 126:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 12a:	0785                	addi	a5,a5,1
 12c:	fee79de3          	bne	a5,a4,126 <memset+0x12>
  }
  return dst;
}
 130:	6422                	ld	s0,8(sp)
 132:	0141                	addi	sp,sp,16
 134:	8082                	ret

0000000000000136 <strchr>:

char*
strchr(const char *s, char c)
{
 136:	1141                	addi	sp,sp,-16
 138:	e422                	sd	s0,8(sp)
 13a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 13c:	00054783          	lbu	a5,0(a0)
 140:	cb99                	beqz	a5,156 <strchr+0x20>
    if(*s == c)
 142:	00f58763          	beq	a1,a5,150 <strchr+0x1a>
  for(; *s; s++)
 146:	0505                	addi	a0,a0,1
 148:	00054783          	lbu	a5,0(a0)
 14c:	fbfd                	bnez	a5,142 <strchr+0xc>
      return (char*)s;
  return 0;
 14e:	4501                	li	a0,0
}
 150:	6422                	ld	s0,8(sp)
 152:	0141                	addi	sp,sp,16
 154:	8082                	ret
  return 0;
 156:	4501                	li	a0,0
 158:	bfe5                	j	150 <strchr+0x1a>

000000000000015a <gets>:

char*
gets(char *buf, int max)
{
 15a:	711d                	addi	sp,sp,-96
 15c:	ec86                	sd	ra,88(sp)
 15e:	e8a2                	sd	s0,80(sp)
 160:	e4a6                	sd	s1,72(sp)
 162:	e0ca                	sd	s2,64(sp)
 164:	fc4e                	sd	s3,56(sp)
 166:	f852                	sd	s4,48(sp)
 168:	f456                	sd	s5,40(sp)
 16a:	f05a                	sd	s6,32(sp)
 16c:	ec5e                	sd	s7,24(sp)
 16e:	1080                	addi	s0,sp,96
 170:	8baa                	mv	s7,a0
 172:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 174:	892a                	mv	s2,a0
 176:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 178:	4aa9                	li	s5,10
 17a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 17c:	89a6                	mv	s3,s1
 17e:	2485                	addiw	s1,s1,1
 180:	0344d863          	bge	s1,s4,1b0 <gets+0x56>
    cc = read(0, &c, 1);
 184:	4605                	li	a2,1
 186:	faf40593          	addi	a1,s0,-81
 18a:	4501                	li	a0,0
 18c:	00000097          	auipc	ra,0x0
 190:	19c080e7          	jalr	412(ra) # 328 <read>
    if(cc < 1)
 194:	00a05e63          	blez	a0,1b0 <gets+0x56>
    buf[i++] = c;
 198:	faf44783          	lbu	a5,-81(s0)
 19c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1a0:	01578763          	beq	a5,s5,1ae <gets+0x54>
 1a4:	0905                	addi	s2,s2,1
 1a6:	fd679be3          	bne	a5,s6,17c <gets+0x22>
  for(i=0; i+1 < max; ){
 1aa:	89a6                	mv	s3,s1
 1ac:	a011                	j	1b0 <gets+0x56>
 1ae:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1b0:	99de                	add	s3,s3,s7
 1b2:	00098023          	sb	zero,0(s3)
  return buf;
}
 1b6:	855e                	mv	a0,s7
 1b8:	60e6                	ld	ra,88(sp)
 1ba:	6446                	ld	s0,80(sp)
 1bc:	64a6                	ld	s1,72(sp)
 1be:	6906                	ld	s2,64(sp)
 1c0:	79e2                	ld	s3,56(sp)
 1c2:	7a42                	ld	s4,48(sp)
 1c4:	7aa2                	ld	s5,40(sp)
 1c6:	7b02                	ld	s6,32(sp)
 1c8:	6be2                	ld	s7,24(sp)
 1ca:	6125                	addi	sp,sp,96
 1cc:	8082                	ret

00000000000001ce <stat>:

int
stat(const char *n, struct stat *st)
{
 1ce:	1101                	addi	sp,sp,-32
 1d0:	ec06                	sd	ra,24(sp)
 1d2:	e822                	sd	s0,16(sp)
 1d4:	e426                	sd	s1,8(sp)
 1d6:	e04a                	sd	s2,0(sp)
 1d8:	1000                	addi	s0,sp,32
 1da:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1dc:	4581                	li	a1,0
 1de:	00000097          	auipc	ra,0x0
 1e2:	172080e7          	jalr	370(ra) # 350 <open>
  if(fd < 0)
 1e6:	02054563          	bltz	a0,210 <stat+0x42>
 1ea:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1ec:	85ca                	mv	a1,s2
 1ee:	00000097          	auipc	ra,0x0
 1f2:	17a080e7          	jalr	378(ra) # 368 <fstat>
 1f6:	892a                	mv	s2,a0
  close(fd);
 1f8:	8526                	mv	a0,s1
 1fa:	00000097          	auipc	ra,0x0
 1fe:	13e080e7          	jalr	318(ra) # 338 <close>
  return r;
}
 202:	854a                	mv	a0,s2
 204:	60e2                	ld	ra,24(sp)
 206:	6442                	ld	s0,16(sp)
 208:	64a2                	ld	s1,8(sp)
 20a:	6902                	ld	s2,0(sp)
 20c:	6105                	addi	sp,sp,32
 20e:	8082                	ret
    return -1;
 210:	597d                	li	s2,-1
 212:	bfc5                	j	202 <stat+0x34>

0000000000000214 <atoi>:

int
atoi(const char *s)
{
 214:	1141                	addi	sp,sp,-16
 216:	e422                	sd	s0,8(sp)
 218:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 21a:	00054603          	lbu	a2,0(a0)
 21e:	fd06079b          	addiw	a5,a2,-48
 222:	0ff7f793          	andi	a5,a5,255
 226:	4725                	li	a4,9
 228:	02f76963          	bltu	a4,a5,25a <atoi+0x46>
 22c:	86aa                	mv	a3,a0
  n = 0;
 22e:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 230:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 232:	0685                	addi	a3,a3,1
 234:	0025179b          	slliw	a5,a0,0x2
 238:	9fa9                	addw	a5,a5,a0
 23a:	0017979b          	slliw	a5,a5,0x1
 23e:	9fb1                	addw	a5,a5,a2
 240:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 244:	0006c603          	lbu	a2,0(a3)
 248:	fd06071b          	addiw	a4,a2,-48
 24c:	0ff77713          	andi	a4,a4,255
 250:	fee5f1e3          	bgeu	a1,a4,232 <atoi+0x1e>
  return n;
}
 254:	6422                	ld	s0,8(sp)
 256:	0141                	addi	sp,sp,16
 258:	8082                	ret
  n = 0;
 25a:	4501                	li	a0,0
 25c:	bfe5                	j	254 <atoi+0x40>

000000000000025e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 25e:	1141                	addi	sp,sp,-16
 260:	e422                	sd	s0,8(sp)
 262:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 264:	02b57463          	bgeu	a0,a1,28c <memmove+0x2e>
    while(n-- > 0)
 268:	00c05f63          	blez	a2,286 <memmove+0x28>
 26c:	1602                	slli	a2,a2,0x20
 26e:	9201                	srli	a2,a2,0x20
 270:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 274:	872a                	mv	a4,a0
      *dst++ = *src++;
 276:	0585                	addi	a1,a1,1
 278:	0705                	addi	a4,a4,1
 27a:	fff5c683          	lbu	a3,-1(a1)
 27e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 282:	fee79ae3          	bne	a5,a4,276 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 286:	6422                	ld	s0,8(sp)
 288:	0141                	addi	sp,sp,16
 28a:	8082                	ret
    dst += n;
 28c:	00c50733          	add	a4,a0,a2
    src += n;
 290:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 292:	fec05ae3          	blez	a2,286 <memmove+0x28>
 296:	fff6079b          	addiw	a5,a2,-1
 29a:	1782                	slli	a5,a5,0x20
 29c:	9381                	srli	a5,a5,0x20
 29e:	fff7c793          	not	a5,a5
 2a2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2a4:	15fd                	addi	a1,a1,-1
 2a6:	177d                	addi	a4,a4,-1
 2a8:	0005c683          	lbu	a3,0(a1)
 2ac:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2b0:	fee79ae3          	bne	a5,a4,2a4 <memmove+0x46>
 2b4:	bfc9                	j	286 <memmove+0x28>

00000000000002b6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2b6:	1141                	addi	sp,sp,-16
 2b8:	e422                	sd	s0,8(sp)
 2ba:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2bc:	ca05                	beqz	a2,2ec <memcmp+0x36>
 2be:	fff6069b          	addiw	a3,a2,-1
 2c2:	1682                	slli	a3,a3,0x20
 2c4:	9281                	srli	a3,a3,0x20
 2c6:	0685                	addi	a3,a3,1
 2c8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2ca:	00054783          	lbu	a5,0(a0)
 2ce:	0005c703          	lbu	a4,0(a1)
 2d2:	00e79863          	bne	a5,a4,2e2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2d6:	0505                	addi	a0,a0,1
    p2++;
 2d8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2da:	fed518e3          	bne	a0,a3,2ca <memcmp+0x14>
  }
  return 0;
 2de:	4501                	li	a0,0
 2e0:	a019                	j	2e6 <memcmp+0x30>
      return *p1 - *p2;
 2e2:	40e7853b          	subw	a0,a5,a4
}
 2e6:	6422                	ld	s0,8(sp)
 2e8:	0141                	addi	sp,sp,16
 2ea:	8082                	ret
  return 0;
 2ec:	4501                	li	a0,0
 2ee:	bfe5                	j	2e6 <memcmp+0x30>

00000000000002f0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2f0:	1141                	addi	sp,sp,-16
 2f2:	e406                	sd	ra,8(sp)
 2f4:	e022                	sd	s0,0(sp)
 2f6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2f8:	00000097          	auipc	ra,0x0
 2fc:	f66080e7          	jalr	-154(ra) # 25e <memmove>
}
 300:	60a2                	ld	ra,8(sp)
 302:	6402                	ld	s0,0(sp)
 304:	0141                	addi	sp,sp,16
 306:	8082                	ret

0000000000000308 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 308:	4885                	li	a7,1
 ecall
 30a:	00000073          	ecall
 ret
 30e:	8082                	ret

0000000000000310 <exit>:
.global exit
exit:
 li a7, SYS_exit
 310:	4889                	li	a7,2
 ecall
 312:	00000073          	ecall
 ret
 316:	8082                	ret

0000000000000318 <wait>:
.global wait
wait:
 li a7, SYS_wait
 318:	488d                	li	a7,3
 ecall
 31a:	00000073          	ecall
 ret
 31e:	8082                	ret

0000000000000320 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 320:	4891                	li	a7,4
 ecall
 322:	00000073          	ecall
 ret
 326:	8082                	ret

0000000000000328 <read>:
.global read
read:
 li a7, SYS_read
 328:	4895                	li	a7,5
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <write>:
.global write
write:
 li a7, SYS_write
 330:	48c1                	li	a7,16
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <close>:
.global close
close:
 li a7, SYS_close
 338:	48d5                	li	a7,21
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <kill>:
.global kill
kill:
 li a7, SYS_kill
 340:	4899                	li	a7,6
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <exec>:
.global exec
exec:
 li a7, SYS_exec
 348:	489d                	li	a7,7
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <open>:
.global open
open:
 li a7, SYS_open
 350:	48bd                	li	a7,15
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 358:	48c5                	li	a7,17
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 360:	48c9                	li	a7,18
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 368:	48a1                	li	a7,8
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <link>:
.global link
link:
 li a7, SYS_link
 370:	48cd                	li	a7,19
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 378:	48d1                	li	a7,20
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 380:	48a5                	li	a7,9
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <dup>:
.global dup
dup:
 li a7, SYS_dup
 388:	48a9                	li	a7,10
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 390:	48ad                	li	a7,11
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 398:	48b1                	li	a7,12
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3a0:	48b5                	li	a7,13
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3a8:	48b9                	li	a7,14
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <memsize>:
.global memsize
memsize:
 li a7, SYS_memsize
 3b0:	48d9                	li	a7,22
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <set_ps_priority>:
.global set_ps_priority
set_ps_priority:
 li a7, SYS_set_ps_priority
 3b8:	48dd                	li	a7,23
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <set_cfs_priority>:
.global set_cfs_priority
set_cfs_priority:
 li a7, SYS_set_cfs_priority
 3c0:	48e1                	li	a7,24
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3c8:	1101                	addi	sp,sp,-32
 3ca:	ec06                	sd	ra,24(sp)
 3cc:	e822                	sd	s0,16(sp)
 3ce:	1000                	addi	s0,sp,32
 3d0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3d4:	4605                	li	a2,1
 3d6:	fef40593          	addi	a1,s0,-17
 3da:	00000097          	auipc	ra,0x0
 3de:	f56080e7          	jalr	-170(ra) # 330 <write>
}
 3e2:	60e2                	ld	ra,24(sp)
 3e4:	6442                	ld	s0,16(sp)
 3e6:	6105                	addi	sp,sp,32
 3e8:	8082                	ret

00000000000003ea <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3ea:	7139                	addi	sp,sp,-64
 3ec:	fc06                	sd	ra,56(sp)
 3ee:	f822                	sd	s0,48(sp)
 3f0:	f426                	sd	s1,40(sp)
 3f2:	f04a                	sd	s2,32(sp)
 3f4:	ec4e                	sd	s3,24(sp)
 3f6:	0080                	addi	s0,sp,64
 3f8:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3fa:	c299                	beqz	a3,400 <printint+0x16>
 3fc:	0805c863          	bltz	a1,48c <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 400:	2581                	sext.w	a1,a1
  neg = 0;
 402:	4881                	li	a7,0
 404:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 408:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 40a:	2601                	sext.w	a2,a2
 40c:	00000517          	auipc	a0,0x0
 410:	45c50513          	addi	a0,a0,1116 # 868 <digits>
 414:	883a                	mv	a6,a4
 416:	2705                	addiw	a4,a4,1
 418:	02c5f7bb          	remuw	a5,a1,a2
 41c:	1782                	slli	a5,a5,0x20
 41e:	9381                	srli	a5,a5,0x20
 420:	97aa                	add	a5,a5,a0
 422:	0007c783          	lbu	a5,0(a5)
 426:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 42a:	0005879b          	sext.w	a5,a1
 42e:	02c5d5bb          	divuw	a1,a1,a2
 432:	0685                	addi	a3,a3,1
 434:	fec7f0e3          	bgeu	a5,a2,414 <printint+0x2a>
  if(neg)
 438:	00088b63          	beqz	a7,44e <printint+0x64>
    buf[i++] = '-';
 43c:	fd040793          	addi	a5,s0,-48
 440:	973e                	add	a4,a4,a5
 442:	02d00793          	li	a5,45
 446:	fef70823          	sb	a5,-16(a4)
 44a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 44e:	02e05863          	blez	a4,47e <printint+0x94>
 452:	fc040793          	addi	a5,s0,-64
 456:	00e78933          	add	s2,a5,a4
 45a:	fff78993          	addi	s3,a5,-1
 45e:	99ba                	add	s3,s3,a4
 460:	377d                	addiw	a4,a4,-1
 462:	1702                	slli	a4,a4,0x20
 464:	9301                	srli	a4,a4,0x20
 466:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 46a:	fff94583          	lbu	a1,-1(s2)
 46e:	8526                	mv	a0,s1
 470:	00000097          	auipc	ra,0x0
 474:	f58080e7          	jalr	-168(ra) # 3c8 <putc>
  while(--i >= 0)
 478:	197d                	addi	s2,s2,-1
 47a:	ff3918e3          	bne	s2,s3,46a <printint+0x80>
}
 47e:	70e2                	ld	ra,56(sp)
 480:	7442                	ld	s0,48(sp)
 482:	74a2                	ld	s1,40(sp)
 484:	7902                	ld	s2,32(sp)
 486:	69e2                	ld	s3,24(sp)
 488:	6121                	addi	sp,sp,64
 48a:	8082                	ret
    x = -xx;
 48c:	40b005bb          	negw	a1,a1
    neg = 1;
 490:	4885                	li	a7,1
    x = -xx;
 492:	bf8d                	j	404 <printint+0x1a>

0000000000000494 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 494:	7119                	addi	sp,sp,-128
 496:	fc86                	sd	ra,120(sp)
 498:	f8a2                	sd	s0,112(sp)
 49a:	f4a6                	sd	s1,104(sp)
 49c:	f0ca                	sd	s2,96(sp)
 49e:	ecce                	sd	s3,88(sp)
 4a0:	e8d2                	sd	s4,80(sp)
 4a2:	e4d6                	sd	s5,72(sp)
 4a4:	e0da                	sd	s6,64(sp)
 4a6:	fc5e                	sd	s7,56(sp)
 4a8:	f862                	sd	s8,48(sp)
 4aa:	f466                	sd	s9,40(sp)
 4ac:	f06a                	sd	s10,32(sp)
 4ae:	ec6e                	sd	s11,24(sp)
 4b0:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4b2:	0005c903          	lbu	s2,0(a1)
 4b6:	18090f63          	beqz	s2,654 <vprintf+0x1c0>
 4ba:	8aaa                	mv	s5,a0
 4bc:	8b32                	mv	s6,a2
 4be:	00158493          	addi	s1,a1,1
  state = 0;
 4c2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4c4:	02500a13          	li	s4,37
      if(c == 'd'){
 4c8:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 4cc:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 4d0:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 4d4:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 4d8:	00000b97          	auipc	s7,0x0
 4dc:	390b8b93          	addi	s7,s7,912 # 868 <digits>
 4e0:	a839                	j	4fe <vprintf+0x6a>
        putc(fd, c);
 4e2:	85ca                	mv	a1,s2
 4e4:	8556                	mv	a0,s5
 4e6:	00000097          	auipc	ra,0x0
 4ea:	ee2080e7          	jalr	-286(ra) # 3c8 <putc>
 4ee:	a019                	j	4f4 <vprintf+0x60>
    } else if(state == '%'){
 4f0:	01498f63          	beq	s3,s4,50e <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 4f4:	0485                	addi	s1,s1,1
 4f6:	fff4c903          	lbu	s2,-1(s1)
 4fa:	14090d63          	beqz	s2,654 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 4fe:	0009079b          	sext.w	a5,s2
    if(state == 0){
 502:	fe0997e3          	bnez	s3,4f0 <vprintf+0x5c>
      if(c == '%'){
 506:	fd479ee3          	bne	a5,s4,4e2 <vprintf+0x4e>
        state = '%';
 50a:	89be                	mv	s3,a5
 50c:	b7e5                	j	4f4 <vprintf+0x60>
      if(c == 'd'){
 50e:	05878063          	beq	a5,s8,54e <vprintf+0xba>
      } else if(c == 'l') {
 512:	05978c63          	beq	a5,s9,56a <vprintf+0xd6>
      } else if(c == 'x') {
 516:	07a78863          	beq	a5,s10,586 <vprintf+0xf2>
      } else if(c == 'p') {
 51a:	09b78463          	beq	a5,s11,5a2 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 51e:	07300713          	li	a4,115
 522:	0ce78663          	beq	a5,a4,5ee <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 526:	06300713          	li	a4,99
 52a:	0ee78e63          	beq	a5,a4,626 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 52e:	11478863          	beq	a5,s4,63e <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 532:	85d2                	mv	a1,s4
 534:	8556                	mv	a0,s5
 536:	00000097          	auipc	ra,0x0
 53a:	e92080e7          	jalr	-366(ra) # 3c8 <putc>
        putc(fd, c);
 53e:	85ca                	mv	a1,s2
 540:	8556                	mv	a0,s5
 542:	00000097          	auipc	ra,0x0
 546:	e86080e7          	jalr	-378(ra) # 3c8 <putc>
      }
      state = 0;
 54a:	4981                	li	s3,0
 54c:	b765                	j	4f4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 54e:	008b0913          	addi	s2,s6,8
 552:	4685                	li	a3,1
 554:	4629                	li	a2,10
 556:	000b2583          	lw	a1,0(s6)
 55a:	8556                	mv	a0,s5
 55c:	00000097          	auipc	ra,0x0
 560:	e8e080e7          	jalr	-370(ra) # 3ea <printint>
 564:	8b4a                	mv	s6,s2
      state = 0;
 566:	4981                	li	s3,0
 568:	b771                	j	4f4 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 56a:	008b0913          	addi	s2,s6,8
 56e:	4681                	li	a3,0
 570:	4629                	li	a2,10
 572:	000b2583          	lw	a1,0(s6)
 576:	8556                	mv	a0,s5
 578:	00000097          	auipc	ra,0x0
 57c:	e72080e7          	jalr	-398(ra) # 3ea <printint>
 580:	8b4a                	mv	s6,s2
      state = 0;
 582:	4981                	li	s3,0
 584:	bf85                	j	4f4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 586:	008b0913          	addi	s2,s6,8
 58a:	4681                	li	a3,0
 58c:	4641                	li	a2,16
 58e:	000b2583          	lw	a1,0(s6)
 592:	8556                	mv	a0,s5
 594:	00000097          	auipc	ra,0x0
 598:	e56080e7          	jalr	-426(ra) # 3ea <printint>
 59c:	8b4a                	mv	s6,s2
      state = 0;
 59e:	4981                	li	s3,0
 5a0:	bf91                	j	4f4 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 5a2:	008b0793          	addi	a5,s6,8
 5a6:	f8f43423          	sd	a5,-120(s0)
 5aa:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 5ae:	03000593          	li	a1,48
 5b2:	8556                	mv	a0,s5
 5b4:	00000097          	auipc	ra,0x0
 5b8:	e14080e7          	jalr	-492(ra) # 3c8 <putc>
  putc(fd, 'x');
 5bc:	85ea                	mv	a1,s10
 5be:	8556                	mv	a0,s5
 5c0:	00000097          	auipc	ra,0x0
 5c4:	e08080e7          	jalr	-504(ra) # 3c8 <putc>
 5c8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5ca:	03c9d793          	srli	a5,s3,0x3c
 5ce:	97de                	add	a5,a5,s7
 5d0:	0007c583          	lbu	a1,0(a5)
 5d4:	8556                	mv	a0,s5
 5d6:	00000097          	auipc	ra,0x0
 5da:	df2080e7          	jalr	-526(ra) # 3c8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5de:	0992                	slli	s3,s3,0x4
 5e0:	397d                	addiw	s2,s2,-1
 5e2:	fe0914e3          	bnez	s2,5ca <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 5e6:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 5ea:	4981                	li	s3,0
 5ec:	b721                	j	4f4 <vprintf+0x60>
        s = va_arg(ap, char*);
 5ee:	008b0993          	addi	s3,s6,8
 5f2:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 5f6:	02090163          	beqz	s2,618 <vprintf+0x184>
        while(*s != 0){
 5fa:	00094583          	lbu	a1,0(s2)
 5fe:	c9a1                	beqz	a1,64e <vprintf+0x1ba>
          putc(fd, *s);
 600:	8556                	mv	a0,s5
 602:	00000097          	auipc	ra,0x0
 606:	dc6080e7          	jalr	-570(ra) # 3c8 <putc>
          s++;
 60a:	0905                	addi	s2,s2,1
        while(*s != 0){
 60c:	00094583          	lbu	a1,0(s2)
 610:	f9e5                	bnez	a1,600 <vprintf+0x16c>
        s = va_arg(ap, char*);
 612:	8b4e                	mv	s6,s3
      state = 0;
 614:	4981                	li	s3,0
 616:	bdf9                	j	4f4 <vprintf+0x60>
          s = "(null)";
 618:	00000917          	auipc	s2,0x0
 61c:	24890913          	addi	s2,s2,584 # 860 <malloc+0x102>
        while(*s != 0){
 620:	02800593          	li	a1,40
 624:	bff1                	j	600 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 626:	008b0913          	addi	s2,s6,8
 62a:	000b4583          	lbu	a1,0(s6)
 62e:	8556                	mv	a0,s5
 630:	00000097          	auipc	ra,0x0
 634:	d98080e7          	jalr	-616(ra) # 3c8 <putc>
 638:	8b4a                	mv	s6,s2
      state = 0;
 63a:	4981                	li	s3,0
 63c:	bd65                	j	4f4 <vprintf+0x60>
        putc(fd, c);
 63e:	85d2                	mv	a1,s4
 640:	8556                	mv	a0,s5
 642:	00000097          	auipc	ra,0x0
 646:	d86080e7          	jalr	-634(ra) # 3c8 <putc>
      state = 0;
 64a:	4981                	li	s3,0
 64c:	b565                	j	4f4 <vprintf+0x60>
        s = va_arg(ap, char*);
 64e:	8b4e                	mv	s6,s3
      state = 0;
 650:	4981                	li	s3,0
 652:	b54d                	j	4f4 <vprintf+0x60>
    }
  }
}
 654:	70e6                	ld	ra,120(sp)
 656:	7446                	ld	s0,112(sp)
 658:	74a6                	ld	s1,104(sp)
 65a:	7906                	ld	s2,96(sp)
 65c:	69e6                	ld	s3,88(sp)
 65e:	6a46                	ld	s4,80(sp)
 660:	6aa6                	ld	s5,72(sp)
 662:	6b06                	ld	s6,64(sp)
 664:	7be2                	ld	s7,56(sp)
 666:	7c42                	ld	s8,48(sp)
 668:	7ca2                	ld	s9,40(sp)
 66a:	7d02                	ld	s10,32(sp)
 66c:	6de2                	ld	s11,24(sp)
 66e:	6109                	addi	sp,sp,128
 670:	8082                	ret

0000000000000672 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 672:	715d                	addi	sp,sp,-80
 674:	ec06                	sd	ra,24(sp)
 676:	e822                	sd	s0,16(sp)
 678:	1000                	addi	s0,sp,32
 67a:	e010                	sd	a2,0(s0)
 67c:	e414                	sd	a3,8(s0)
 67e:	e818                	sd	a4,16(s0)
 680:	ec1c                	sd	a5,24(s0)
 682:	03043023          	sd	a6,32(s0)
 686:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 68a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 68e:	8622                	mv	a2,s0
 690:	00000097          	auipc	ra,0x0
 694:	e04080e7          	jalr	-508(ra) # 494 <vprintf>
}
 698:	60e2                	ld	ra,24(sp)
 69a:	6442                	ld	s0,16(sp)
 69c:	6161                	addi	sp,sp,80
 69e:	8082                	ret

00000000000006a0 <printf>:

void
printf(const char *fmt, ...)
{
 6a0:	711d                	addi	sp,sp,-96
 6a2:	ec06                	sd	ra,24(sp)
 6a4:	e822                	sd	s0,16(sp)
 6a6:	1000                	addi	s0,sp,32
 6a8:	e40c                	sd	a1,8(s0)
 6aa:	e810                	sd	a2,16(s0)
 6ac:	ec14                	sd	a3,24(s0)
 6ae:	f018                	sd	a4,32(s0)
 6b0:	f41c                	sd	a5,40(s0)
 6b2:	03043823          	sd	a6,48(s0)
 6b6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6ba:	00840613          	addi	a2,s0,8
 6be:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6c2:	85aa                	mv	a1,a0
 6c4:	4505                	li	a0,1
 6c6:	00000097          	auipc	ra,0x0
 6ca:	dce080e7          	jalr	-562(ra) # 494 <vprintf>
}
 6ce:	60e2                	ld	ra,24(sp)
 6d0:	6442                	ld	s0,16(sp)
 6d2:	6125                	addi	sp,sp,96
 6d4:	8082                	ret

00000000000006d6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d6:	1141                	addi	sp,sp,-16
 6d8:	e422                	sd	s0,8(sp)
 6da:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6dc:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e0:	00001797          	auipc	a5,0x1
 6e4:	9207b783          	ld	a5,-1760(a5) # 1000 <freep>
 6e8:	a805                	j	718 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6ea:	4618                	lw	a4,8(a2)
 6ec:	9db9                	addw	a1,a1,a4
 6ee:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6f2:	6398                	ld	a4,0(a5)
 6f4:	6318                	ld	a4,0(a4)
 6f6:	fee53823          	sd	a4,-16(a0)
 6fa:	a091                	j	73e <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6fc:	ff852703          	lw	a4,-8(a0)
 700:	9e39                	addw	a2,a2,a4
 702:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 704:	ff053703          	ld	a4,-16(a0)
 708:	e398                	sd	a4,0(a5)
 70a:	a099                	j	750 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 70c:	6398                	ld	a4,0(a5)
 70e:	00e7e463          	bltu	a5,a4,716 <free+0x40>
 712:	00e6ea63          	bltu	a3,a4,726 <free+0x50>
{
 716:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 718:	fed7fae3          	bgeu	a5,a3,70c <free+0x36>
 71c:	6398                	ld	a4,0(a5)
 71e:	00e6e463          	bltu	a3,a4,726 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 722:	fee7eae3          	bltu	a5,a4,716 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 726:	ff852583          	lw	a1,-8(a0)
 72a:	6390                	ld	a2,0(a5)
 72c:	02059713          	slli	a4,a1,0x20
 730:	9301                	srli	a4,a4,0x20
 732:	0712                	slli	a4,a4,0x4
 734:	9736                	add	a4,a4,a3
 736:	fae60ae3          	beq	a2,a4,6ea <free+0x14>
    bp->s.ptr = p->s.ptr;
 73a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 73e:	4790                	lw	a2,8(a5)
 740:	02061713          	slli	a4,a2,0x20
 744:	9301                	srli	a4,a4,0x20
 746:	0712                	slli	a4,a4,0x4
 748:	973e                	add	a4,a4,a5
 74a:	fae689e3          	beq	a3,a4,6fc <free+0x26>
  } else
    p->s.ptr = bp;
 74e:	e394                	sd	a3,0(a5)
  freep = p;
 750:	00001717          	auipc	a4,0x1
 754:	8af73823          	sd	a5,-1872(a4) # 1000 <freep>
}
 758:	6422                	ld	s0,8(sp)
 75a:	0141                	addi	sp,sp,16
 75c:	8082                	ret

000000000000075e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 75e:	7139                	addi	sp,sp,-64
 760:	fc06                	sd	ra,56(sp)
 762:	f822                	sd	s0,48(sp)
 764:	f426                	sd	s1,40(sp)
 766:	f04a                	sd	s2,32(sp)
 768:	ec4e                	sd	s3,24(sp)
 76a:	e852                	sd	s4,16(sp)
 76c:	e456                	sd	s5,8(sp)
 76e:	e05a                	sd	s6,0(sp)
 770:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 772:	02051493          	slli	s1,a0,0x20
 776:	9081                	srli	s1,s1,0x20
 778:	04bd                	addi	s1,s1,15
 77a:	8091                	srli	s1,s1,0x4
 77c:	0014899b          	addiw	s3,s1,1
 780:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 782:	00001517          	auipc	a0,0x1
 786:	87e53503          	ld	a0,-1922(a0) # 1000 <freep>
 78a:	c515                	beqz	a0,7b6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 78c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 78e:	4798                	lw	a4,8(a5)
 790:	02977f63          	bgeu	a4,s1,7ce <malloc+0x70>
 794:	8a4e                	mv	s4,s3
 796:	0009871b          	sext.w	a4,s3
 79a:	6685                	lui	a3,0x1
 79c:	00d77363          	bgeu	a4,a3,7a2 <malloc+0x44>
 7a0:	6a05                	lui	s4,0x1
 7a2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7a6:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7aa:	00001917          	auipc	s2,0x1
 7ae:	85690913          	addi	s2,s2,-1962 # 1000 <freep>
  if(p == (char*)-1)
 7b2:	5afd                	li	s5,-1
 7b4:	a88d                	j	826 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 7b6:	00001797          	auipc	a5,0x1
 7ba:	85a78793          	addi	a5,a5,-1958 # 1010 <base>
 7be:	00001717          	auipc	a4,0x1
 7c2:	84f73123          	sd	a5,-1982(a4) # 1000 <freep>
 7c6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7c8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7cc:	b7e1                	j	794 <malloc+0x36>
      if(p->s.size == nunits)
 7ce:	02e48b63          	beq	s1,a4,804 <malloc+0xa6>
        p->s.size -= nunits;
 7d2:	4137073b          	subw	a4,a4,s3
 7d6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7d8:	1702                	slli	a4,a4,0x20
 7da:	9301                	srli	a4,a4,0x20
 7dc:	0712                	slli	a4,a4,0x4
 7de:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7e0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7e4:	00001717          	auipc	a4,0x1
 7e8:	80a73e23          	sd	a0,-2020(a4) # 1000 <freep>
      return (void*)(p + 1);
 7ec:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7f0:	70e2                	ld	ra,56(sp)
 7f2:	7442                	ld	s0,48(sp)
 7f4:	74a2                	ld	s1,40(sp)
 7f6:	7902                	ld	s2,32(sp)
 7f8:	69e2                	ld	s3,24(sp)
 7fa:	6a42                	ld	s4,16(sp)
 7fc:	6aa2                	ld	s5,8(sp)
 7fe:	6b02                	ld	s6,0(sp)
 800:	6121                	addi	sp,sp,64
 802:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 804:	6398                	ld	a4,0(a5)
 806:	e118                	sd	a4,0(a0)
 808:	bff1                	j	7e4 <malloc+0x86>
  hp->s.size = nu;
 80a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 80e:	0541                	addi	a0,a0,16
 810:	00000097          	auipc	ra,0x0
 814:	ec6080e7          	jalr	-314(ra) # 6d6 <free>
  return freep;
 818:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 81c:	d971                	beqz	a0,7f0 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 81e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 820:	4798                	lw	a4,8(a5)
 822:	fa9776e3          	bgeu	a4,s1,7ce <malloc+0x70>
    if(p == freep)
 826:	00093703          	ld	a4,0(s2)
 82a:	853e                	mv	a0,a5
 82c:	fef719e3          	bne	a4,a5,81e <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 830:	8552                	mv	a0,s4
 832:	00000097          	auipc	ra,0x0
 836:	b66080e7          	jalr	-1178(ra) # 398 <sbrk>
  if(p == (char*)-1)
 83a:	fd5518e3          	bne	a0,s5,80a <malloc+0xac>
        return 0;
 83e:	4501                	li	a0,0
 840:	bf45                	j	7f0 <malloc+0x92>
