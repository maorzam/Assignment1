
user/_goodbye:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main() {
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
   exit(0, "Goodbye World xv6");
   8:	00000597          	auipc	a1,0x0
   c:	7c858593          	addi	a1,a1,1992 # 7d0 <malloc+0xee>
  10:	4501                	li	a0,0
  12:	00000097          	auipc	ra,0x0
  16:	292080e7          	jalr	658(ra) # 2a4 <exit>

000000000000001a <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  1a:	1141                	addi	sp,sp,-16
  1c:	e406                	sd	ra,8(sp)
  1e:	e022                	sd	s0,0(sp)
  20:	0800                	addi	s0,sp,16
  extern int main();
  main();
  22:	00000097          	auipc	ra,0x0
  26:	fde080e7          	jalr	-34(ra) # 0 <main>
  exit(0,0);
  2a:	4581                	li	a1,0
  2c:	4501                	li	a0,0
  2e:	00000097          	auipc	ra,0x0
  32:	276080e7          	jalr	630(ra) # 2a4 <exit>

0000000000000036 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  36:	1141                	addi	sp,sp,-16
  38:	e422                	sd	s0,8(sp)
  3a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  3c:	87aa                	mv	a5,a0
  3e:	0585                	addi	a1,a1,1
  40:	0785                	addi	a5,a5,1
  42:	fff5c703          	lbu	a4,-1(a1)
  46:	fee78fa3          	sb	a4,-1(a5)
  4a:	fb75                	bnez	a4,3e <strcpy+0x8>
    ;
  return os;
}
  4c:	6422                	ld	s0,8(sp)
  4e:	0141                	addi	sp,sp,16
  50:	8082                	ret

0000000000000052 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  52:	1141                	addi	sp,sp,-16
  54:	e422                	sd	s0,8(sp)
  56:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  58:	00054783          	lbu	a5,0(a0)
  5c:	cb91                	beqz	a5,70 <strcmp+0x1e>
  5e:	0005c703          	lbu	a4,0(a1)
  62:	00f71763          	bne	a4,a5,70 <strcmp+0x1e>
    p++, q++;
  66:	0505                	addi	a0,a0,1
  68:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  6a:	00054783          	lbu	a5,0(a0)
  6e:	fbe5                	bnez	a5,5e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  70:	0005c503          	lbu	a0,0(a1)
}
  74:	40a7853b          	subw	a0,a5,a0
  78:	6422                	ld	s0,8(sp)
  7a:	0141                	addi	sp,sp,16
  7c:	8082                	ret

000000000000007e <strlen>:

uint
strlen(const char *s)
{
  7e:	1141                	addi	sp,sp,-16
  80:	e422                	sd	s0,8(sp)
  82:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  84:	00054783          	lbu	a5,0(a0)
  88:	cf91                	beqz	a5,a4 <strlen+0x26>
  8a:	0505                	addi	a0,a0,1
  8c:	87aa                	mv	a5,a0
  8e:	4685                	li	a3,1
  90:	9e89                	subw	a3,a3,a0
  92:	00f6853b          	addw	a0,a3,a5
  96:	0785                	addi	a5,a5,1
  98:	fff7c703          	lbu	a4,-1(a5)
  9c:	fb7d                	bnez	a4,92 <strlen+0x14>
    ;
  return n;
}
  9e:	6422                	ld	s0,8(sp)
  a0:	0141                	addi	sp,sp,16
  a2:	8082                	ret
  for(n = 0; s[n]; n++)
  a4:	4501                	li	a0,0
  a6:	bfe5                	j	9e <strlen+0x20>

00000000000000a8 <memset>:

void*
memset(void *dst, int c, uint n)
{
  a8:	1141                	addi	sp,sp,-16
  aa:	e422                	sd	s0,8(sp)
  ac:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  ae:	ca19                	beqz	a2,c4 <memset+0x1c>
  b0:	87aa                	mv	a5,a0
  b2:	1602                	slli	a2,a2,0x20
  b4:	9201                	srli	a2,a2,0x20
  b6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  ba:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  be:	0785                	addi	a5,a5,1
  c0:	fee79de3          	bne	a5,a4,ba <memset+0x12>
  }
  return dst;
}
  c4:	6422                	ld	s0,8(sp)
  c6:	0141                	addi	sp,sp,16
  c8:	8082                	ret

00000000000000ca <strchr>:

char*
strchr(const char *s, char c)
{
  ca:	1141                	addi	sp,sp,-16
  cc:	e422                	sd	s0,8(sp)
  ce:	0800                	addi	s0,sp,16
  for(; *s; s++)
  d0:	00054783          	lbu	a5,0(a0)
  d4:	cb99                	beqz	a5,ea <strchr+0x20>
    if(*s == c)
  d6:	00f58763          	beq	a1,a5,e4 <strchr+0x1a>
  for(; *s; s++)
  da:	0505                	addi	a0,a0,1
  dc:	00054783          	lbu	a5,0(a0)
  e0:	fbfd                	bnez	a5,d6 <strchr+0xc>
      return (char*)s;
  return 0;
  e2:	4501                	li	a0,0
}
  e4:	6422                	ld	s0,8(sp)
  e6:	0141                	addi	sp,sp,16
  e8:	8082                	ret
  return 0;
  ea:	4501                	li	a0,0
  ec:	bfe5                	j	e4 <strchr+0x1a>

00000000000000ee <gets>:

char*
gets(char *buf, int max)
{
  ee:	711d                	addi	sp,sp,-96
  f0:	ec86                	sd	ra,88(sp)
  f2:	e8a2                	sd	s0,80(sp)
  f4:	e4a6                	sd	s1,72(sp)
  f6:	e0ca                	sd	s2,64(sp)
  f8:	fc4e                	sd	s3,56(sp)
  fa:	f852                	sd	s4,48(sp)
  fc:	f456                	sd	s5,40(sp)
  fe:	f05a                	sd	s6,32(sp)
 100:	ec5e                	sd	s7,24(sp)
 102:	1080                	addi	s0,sp,96
 104:	8baa                	mv	s7,a0
 106:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 108:	892a                	mv	s2,a0
 10a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 10c:	4aa9                	li	s5,10
 10e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 110:	89a6                	mv	s3,s1
 112:	2485                	addiw	s1,s1,1
 114:	0344d863          	bge	s1,s4,144 <gets+0x56>
    cc = read(0, &c, 1);
 118:	4605                	li	a2,1
 11a:	faf40593          	addi	a1,s0,-81
 11e:	4501                	li	a0,0
 120:	00000097          	auipc	ra,0x0
 124:	19c080e7          	jalr	412(ra) # 2bc <read>
    if(cc < 1)
 128:	00a05e63          	blez	a0,144 <gets+0x56>
    buf[i++] = c;
 12c:	faf44783          	lbu	a5,-81(s0)
 130:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 134:	01578763          	beq	a5,s5,142 <gets+0x54>
 138:	0905                	addi	s2,s2,1
 13a:	fd679be3          	bne	a5,s6,110 <gets+0x22>
  for(i=0; i+1 < max; ){
 13e:	89a6                	mv	s3,s1
 140:	a011                	j	144 <gets+0x56>
 142:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 144:	99de                	add	s3,s3,s7
 146:	00098023          	sb	zero,0(s3)
  return buf;
}
 14a:	855e                	mv	a0,s7
 14c:	60e6                	ld	ra,88(sp)
 14e:	6446                	ld	s0,80(sp)
 150:	64a6                	ld	s1,72(sp)
 152:	6906                	ld	s2,64(sp)
 154:	79e2                	ld	s3,56(sp)
 156:	7a42                	ld	s4,48(sp)
 158:	7aa2                	ld	s5,40(sp)
 15a:	7b02                	ld	s6,32(sp)
 15c:	6be2                	ld	s7,24(sp)
 15e:	6125                	addi	sp,sp,96
 160:	8082                	ret

0000000000000162 <stat>:

int
stat(const char *n, struct stat *st)
{
 162:	1101                	addi	sp,sp,-32
 164:	ec06                	sd	ra,24(sp)
 166:	e822                	sd	s0,16(sp)
 168:	e426                	sd	s1,8(sp)
 16a:	e04a                	sd	s2,0(sp)
 16c:	1000                	addi	s0,sp,32
 16e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 170:	4581                	li	a1,0
 172:	00000097          	auipc	ra,0x0
 176:	172080e7          	jalr	370(ra) # 2e4 <open>
  if(fd < 0)
 17a:	02054563          	bltz	a0,1a4 <stat+0x42>
 17e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 180:	85ca                	mv	a1,s2
 182:	00000097          	auipc	ra,0x0
 186:	17a080e7          	jalr	378(ra) # 2fc <fstat>
 18a:	892a                	mv	s2,a0
  close(fd);
 18c:	8526                	mv	a0,s1
 18e:	00000097          	auipc	ra,0x0
 192:	13e080e7          	jalr	318(ra) # 2cc <close>
  return r;
}
 196:	854a                	mv	a0,s2
 198:	60e2                	ld	ra,24(sp)
 19a:	6442                	ld	s0,16(sp)
 19c:	64a2                	ld	s1,8(sp)
 19e:	6902                	ld	s2,0(sp)
 1a0:	6105                	addi	sp,sp,32
 1a2:	8082                	ret
    return -1;
 1a4:	597d                	li	s2,-1
 1a6:	bfc5                	j	196 <stat+0x34>

00000000000001a8 <atoi>:

int
atoi(const char *s)
{
 1a8:	1141                	addi	sp,sp,-16
 1aa:	e422                	sd	s0,8(sp)
 1ac:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1ae:	00054603          	lbu	a2,0(a0)
 1b2:	fd06079b          	addiw	a5,a2,-48
 1b6:	0ff7f793          	andi	a5,a5,255
 1ba:	4725                	li	a4,9
 1bc:	02f76963          	bltu	a4,a5,1ee <atoi+0x46>
 1c0:	86aa                	mv	a3,a0
  n = 0;
 1c2:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 1c4:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 1c6:	0685                	addi	a3,a3,1
 1c8:	0025179b          	slliw	a5,a0,0x2
 1cc:	9fa9                	addw	a5,a5,a0
 1ce:	0017979b          	slliw	a5,a5,0x1
 1d2:	9fb1                	addw	a5,a5,a2
 1d4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1d8:	0006c603          	lbu	a2,0(a3)
 1dc:	fd06071b          	addiw	a4,a2,-48
 1e0:	0ff77713          	andi	a4,a4,255
 1e4:	fee5f1e3          	bgeu	a1,a4,1c6 <atoi+0x1e>
  return n;
}
 1e8:	6422                	ld	s0,8(sp)
 1ea:	0141                	addi	sp,sp,16
 1ec:	8082                	ret
  n = 0;
 1ee:	4501                	li	a0,0
 1f0:	bfe5                	j	1e8 <atoi+0x40>

00000000000001f2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1f2:	1141                	addi	sp,sp,-16
 1f4:	e422                	sd	s0,8(sp)
 1f6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 1f8:	02b57463          	bgeu	a0,a1,220 <memmove+0x2e>
    while(n-- > 0)
 1fc:	00c05f63          	blez	a2,21a <memmove+0x28>
 200:	1602                	slli	a2,a2,0x20
 202:	9201                	srli	a2,a2,0x20
 204:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 208:	872a                	mv	a4,a0
      *dst++ = *src++;
 20a:	0585                	addi	a1,a1,1
 20c:	0705                	addi	a4,a4,1
 20e:	fff5c683          	lbu	a3,-1(a1)
 212:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 216:	fee79ae3          	bne	a5,a4,20a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 21a:	6422                	ld	s0,8(sp)
 21c:	0141                	addi	sp,sp,16
 21e:	8082                	ret
    dst += n;
 220:	00c50733          	add	a4,a0,a2
    src += n;
 224:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 226:	fec05ae3          	blez	a2,21a <memmove+0x28>
 22a:	fff6079b          	addiw	a5,a2,-1
 22e:	1782                	slli	a5,a5,0x20
 230:	9381                	srli	a5,a5,0x20
 232:	fff7c793          	not	a5,a5
 236:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 238:	15fd                	addi	a1,a1,-1
 23a:	177d                	addi	a4,a4,-1
 23c:	0005c683          	lbu	a3,0(a1)
 240:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 244:	fee79ae3          	bne	a5,a4,238 <memmove+0x46>
 248:	bfc9                	j	21a <memmove+0x28>

000000000000024a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 24a:	1141                	addi	sp,sp,-16
 24c:	e422                	sd	s0,8(sp)
 24e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 250:	ca05                	beqz	a2,280 <memcmp+0x36>
 252:	fff6069b          	addiw	a3,a2,-1
 256:	1682                	slli	a3,a3,0x20
 258:	9281                	srli	a3,a3,0x20
 25a:	0685                	addi	a3,a3,1
 25c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 25e:	00054783          	lbu	a5,0(a0)
 262:	0005c703          	lbu	a4,0(a1)
 266:	00e79863          	bne	a5,a4,276 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 26a:	0505                	addi	a0,a0,1
    p2++;
 26c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 26e:	fed518e3          	bne	a0,a3,25e <memcmp+0x14>
  }
  return 0;
 272:	4501                	li	a0,0
 274:	a019                	j	27a <memcmp+0x30>
      return *p1 - *p2;
 276:	40e7853b          	subw	a0,a5,a4
}
 27a:	6422                	ld	s0,8(sp)
 27c:	0141                	addi	sp,sp,16
 27e:	8082                	ret
  return 0;
 280:	4501                	li	a0,0
 282:	bfe5                	j	27a <memcmp+0x30>

0000000000000284 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 284:	1141                	addi	sp,sp,-16
 286:	e406                	sd	ra,8(sp)
 288:	e022                	sd	s0,0(sp)
 28a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 28c:	00000097          	auipc	ra,0x0
 290:	f66080e7          	jalr	-154(ra) # 1f2 <memmove>
}
 294:	60a2                	ld	ra,8(sp)
 296:	6402                	ld	s0,0(sp)
 298:	0141                	addi	sp,sp,16
 29a:	8082                	ret

000000000000029c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 29c:	4885                	li	a7,1
 ecall
 29e:	00000073          	ecall
 ret
 2a2:	8082                	ret

00000000000002a4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2a4:	4889                	li	a7,2
 ecall
 2a6:	00000073          	ecall
 ret
 2aa:	8082                	ret

00000000000002ac <wait>:
.global wait
wait:
 li a7, SYS_wait
 2ac:	488d                	li	a7,3
 ecall
 2ae:	00000073          	ecall
 ret
 2b2:	8082                	ret

00000000000002b4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2b4:	4891                	li	a7,4
 ecall
 2b6:	00000073          	ecall
 ret
 2ba:	8082                	ret

00000000000002bc <read>:
.global read
read:
 li a7, SYS_read
 2bc:	4895                	li	a7,5
 ecall
 2be:	00000073          	ecall
 ret
 2c2:	8082                	ret

00000000000002c4 <write>:
.global write
write:
 li a7, SYS_write
 2c4:	48c1                	li	a7,16
 ecall
 2c6:	00000073          	ecall
 ret
 2ca:	8082                	ret

00000000000002cc <close>:
.global close
close:
 li a7, SYS_close
 2cc:	48d5                	li	a7,21
 ecall
 2ce:	00000073          	ecall
 ret
 2d2:	8082                	ret

00000000000002d4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 2d4:	4899                	li	a7,6
 ecall
 2d6:	00000073          	ecall
 ret
 2da:	8082                	ret

00000000000002dc <exec>:
.global exec
exec:
 li a7, SYS_exec
 2dc:	489d                	li	a7,7
 ecall
 2de:	00000073          	ecall
 ret
 2e2:	8082                	ret

00000000000002e4 <open>:
.global open
open:
 li a7, SYS_open
 2e4:	48bd                	li	a7,15
 ecall
 2e6:	00000073          	ecall
 ret
 2ea:	8082                	ret

00000000000002ec <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 2ec:	48c5                	li	a7,17
 ecall
 2ee:	00000073          	ecall
 ret
 2f2:	8082                	ret

00000000000002f4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 2f4:	48c9                	li	a7,18
 ecall
 2f6:	00000073          	ecall
 ret
 2fa:	8082                	ret

00000000000002fc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 2fc:	48a1                	li	a7,8
 ecall
 2fe:	00000073          	ecall
 ret
 302:	8082                	ret

0000000000000304 <link>:
.global link
link:
 li a7, SYS_link
 304:	48cd                	li	a7,19
 ecall
 306:	00000073          	ecall
 ret
 30a:	8082                	ret

000000000000030c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 30c:	48d1                	li	a7,20
 ecall
 30e:	00000073          	ecall
 ret
 312:	8082                	ret

0000000000000314 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 314:	48a5                	li	a7,9
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <dup>:
.global dup
dup:
 li a7, SYS_dup
 31c:	48a9                	li	a7,10
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 324:	48ad                	li	a7,11
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 32c:	48b1                	li	a7,12
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 334:	48b5                	li	a7,13
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 33c:	48b9                	li	a7,14
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <memsize>:
.global memsize
memsize:
 li a7, SYS_memsize
 344:	48d9                	li	a7,22
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 34c:	1101                	addi	sp,sp,-32
 34e:	ec06                	sd	ra,24(sp)
 350:	e822                	sd	s0,16(sp)
 352:	1000                	addi	s0,sp,32
 354:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 358:	4605                	li	a2,1
 35a:	fef40593          	addi	a1,s0,-17
 35e:	00000097          	auipc	ra,0x0
 362:	f66080e7          	jalr	-154(ra) # 2c4 <write>
}
 366:	60e2                	ld	ra,24(sp)
 368:	6442                	ld	s0,16(sp)
 36a:	6105                	addi	sp,sp,32
 36c:	8082                	ret

000000000000036e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 36e:	7139                	addi	sp,sp,-64
 370:	fc06                	sd	ra,56(sp)
 372:	f822                	sd	s0,48(sp)
 374:	f426                	sd	s1,40(sp)
 376:	f04a                	sd	s2,32(sp)
 378:	ec4e                	sd	s3,24(sp)
 37a:	0080                	addi	s0,sp,64
 37c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 37e:	c299                	beqz	a3,384 <printint+0x16>
 380:	0805c863          	bltz	a1,410 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 384:	2581                	sext.w	a1,a1
  neg = 0;
 386:	4881                	li	a7,0
 388:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 38c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 38e:	2601                	sext.w	a2,a2
 390:	00000517          	auipc	a0,0x0
 394:	46050513          	addi	a0,a0,1120 # 7f0 <digits>
 398:	883a                	mv	a6,a4
 39a:	2705                	addiw	a4,a4,1
 39c:	02c5f7bb          	remuw	a5,a1,a2
 3a0:	1782                	slli	a5,a5,0x20
 3a2:	9381                	srli	a5,a5,0x20
 3a4:	97aa                	add	a5,a5,a0
 3a6:	0007c783          	lbu	a5,0(a5)
 3aa:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3ae:	0005879b          	sext.w	a5,a1
 3b2:	02c5d5bb          	divuw	a1,a1,a2
 3b6:	0685                	addi	a3,a3,1
 3b8:	fec7f0e3          	bgeu	a5,a2,398 <printint+0x2a>
  if(neg)
 3bc:	00088b63          	beqz	a7,3d2 <printint+0x64>
    buf[i++] = '-';
 3c0:	fd040793          	addi	a5,s0,-48
 3c4:	973e                	add	a4,a4,a5
 3c6:	02d00793          	li	a5,45
 3ca:	fef70823          	sb	a5,-16(a4)
 3ce:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 3d2:	02e05863          	blez	a4,402 <printint+0x94>
 3d6:	fc040793          	addi	a5,s0,-64
 3da:	00e78933          	add	s2,a5,a4
 3de:	fff78993          	addi	s3,a5,-1
 3e2:	99ba                	add	s3,s3,a4
 3e4:	377d                	addiw	a4,a4,-1
 3e6:	1702                	slli	a4,a4,0x20
 3e8:	9301                	srli	a4,a4,0x20
 3ea:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 3ee:	fff94583          	lbu	a1,-1(s2)
 3f2:	8526                	mv	a0,s1
 3f4:	00000097          	auipc	ra,0x0
 3f8:	f58080e7          	jalr	-168(ra) # 34c <putc>
  while(--i >= 0)
 3fc:	197d                	addi	s2,s2,-1
 3fe:	ff3918e3          	bne	s2,s3,3ee <printint+0x80>
}
 402:	70e2                	ld	ra,56(sp)
 404:	7442                	ld	s0,48(sp)
 406:	74a2                	ld	s1,40(sp)
 408:	7902                	ld	s2,32(sp)
 40a:	69e2                	ld	s3,24(sp)
 40c:	6121                	addi	sp,sp,64
 40e:	8082                	ret
    x = -xx;
 410:	40b005bb          	negw	a1,a1
    neg = 1;
 414:	4885                	li	a7,1
    x = -xx;
 416:	bf8d                	j	388 <printint+0x1a>

0000000000000418 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 418:	7119                	addi	sp,sp,-128
 41a:	fc86                	sd	ra,120(sp)
 41c:	f8a2                	sd	s0,112(sp)
 41e:	f4a6                	sd	s1,104(sp)
 420:	f0ca                	sd	s2,96(sp)
 422:	ecce                	sd	s3,88(sp)
 424:	e8d2                	sd	s4,80(sp)
 426:	e4d6                	sd	s5,72(sp)
 428:	e0da                	sd	s6,64(sp)
 42a:	fc5e                	sd	s7,56(sp)
 42c:	f862                	sd	s8,48(sp)
 42e:	f466                	sd	s9,40(sp)
 430:	f06a                	sd	s10,32(sp)
 432:	ec6e                	sd	s11,24(sp)
 434:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 436:	0005c903          	lbu	s2,0(a1)
 43a:	18090f63          	beqz	s2,5d8 <vprintf+0x1c0>
 43e:	8aaa                	mv	s5,a0
 440:	8b32                	mv	s6,a2
 442:	00158493          	addi	s1,a1,1
  state = 0;
 446:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 448:	02500a13          	li	s4,37
      if(c == 'd'){
 44c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 450:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 454:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 458:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 45c:	00000b97          	auipc	s7,0x0
 460:	394b8b93          	addi	s7,s7,916 # 7f0 <digits>
 464:	a839                	j	482 <vprintf+0x6a>
        putc(fd, c);
 466:	85ca                	mv	a1,s2
 468:	8556                	mv	a0,s5
 46a:	00000097          	auipc	ra,0x0
 46e:	ee2080e7          	jalr	-286(ra) # 34c <putc>
 472:	a019                	j	478 <vprintf+0x60>
    } else if(state == '%'){
 474:	01498f63          	beq	s3,s4,492 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 478:	0485                	addi	s1,s1,1
 47a:	fff4c903          	lbu	s2,-1(s1)
 47e:	14090d63          	beqz	s2,5d8 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 482:	0009079b          	sext.w	a5,s2
    if(state == 0){
 486:	fe0997e3          	bnez	s3,474 <vprintf+0x5c>
      if(c == '%'){
 48a:	fd479ee3          	bne	a5,s4,466 <vprintf+0x4e>
        state = '%';
 48e:	89be                	mv	s3,a5
 490:	b7e5                	j	478 <vprintf+0x60>
      if(c == 'd'){
 492:	05878063          	beq	a5,s8,4d2 <vprintf+0xba>
      } else if(c == 'l') {
 496:	05978c63          	beq	a5,s9,4ee <vprintf+0xd6>
      } else if(c == 'x') {
 49a:	07a78863          	beq	a5,s10,50a <vprintf+0xf2>
      } else if(c == 'p') {
 49e:	09b78463          	beq	a5,s11,526 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 4a2:	07300713          	li	a4,115
 4a6:	0ce78663          	beq	a5,a4,572 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4aa:	06300713          	li	a4,99
 4ae:	0ee78e63          	beq	a5,a4,5aa <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 4b2:	11478863          	beq	a5,s4,5c2 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 4b6:	85d2                	mv	a1,s4
 4b8:	8556                	mv	a0,s5
 4ba:	00000097          	auipc	ra,0x0
 4be:	e92080e7          	jalr	-366(ra) # 34c <putc>
        putc(fd, c);
 4c2:	85ca                	mv	a1,s2
 4c4:	8556                	mv	a0,s5
 4c6:	00000097          	auipc	ra,0x0
 4ca:	e86080e7          	jalr	-378(ra) # 34c <putc>
      }
      state = 0;
 4ce:	4981                	li	s3,0
 4d0:	b765                	j	478 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 4d2:	008b0913          	addi	s2,s6,8
 4d6:	4685                	li	a3,1
 4d8:	4629                	li	a2,10
 4da:	000b2583          	lw	a1,0(s6)
 4de:	8556                	mv	a0,s5
 4e0:	00000097          	auipc	ra,0x0
 4e4:	e8e080e7          	jalr	-370(ra) # 36e <printint>
 4e8:	8b4a                	mv	s6,s2
      state = 0;
 4ea:	4981                	li	s3,0
 4ec:	b771                	j	478 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 4ee:	008b0913          	addi	s2,s6,8
 4f2:	4681                	li	a3,0
 4f4:	4629                	li	a2,10
 4f6:	000b2583          	lw	a1,0(s6)
 4fa:	8556                	mv	a0,s5
 4fc:	00000097          	auipc	ra,0x0
 500:	e72080e7          	jalr	-398(ra) # 36e <printint>
 504:	8b4a                	mv	s6,s2
      state = 0;
 506:	4981                	li	s3,0
 508:	bf85                	j	478 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 50a:	008b0913          	addi	s2,s6,8
 50e:	4681                	li	a3,0
 510:	4641                	li	a2,16
 512:	000b2583          	lw	a1,0(s6)
 516:	8556                	mv	a0,s5
 518:	00000097          	auipc	ra,0x0
 51c:	e56080e7          	jalr	-426(ra) # 36e <printint>
 520:	8b4a                	mv	s6,s2
      state = 0;
 522:	4981                	li	s3,0
 524:	bf91                	j	478 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 526:	008b0793          	addi	a5,s6,8
 52a:	f8f43423          	sd	a5,-120(s0)
 52e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 532:	03000593          	li	a1,48
 536:	8556                	mv	a0,s5
 538:	00000097          	auipc	ra,0x0
 53c:	e14080e7          	jalr	-492(ra) # 34c <putc>
  putc(fd, 'x');
 540:	85ea                	mv	a1,s10
 542:	8556                	mv	a0,s5
 544:	00000097          	auipc	ra,0x0
 548:	e08080e7          	jalr	-504(ra) # 34c <putc>
 54c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 54e:	03c9d793          	srli	a5,s3,0x3c
 552:	97de                	add	a5,a5,s7
 554:	0007c583          	lbu	a1,0(a5)
 558:	8556                	mv	a0,s5
 55a:	00000097          	auipc	ra,0x0
 55e:	df2080e7          	jalr	-526(ra) # 34c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 562:	0992                	slli	s3,s3,0x4
 564:	397d                	addiw	s2,s2,-1
 566:	fe0914e3          	bnez	s2,54e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 56a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 56e:	4981                	li	s3,0
 570:	b721                	j	478 <vprintf+0x60>
        s = va_arg(ap, char*);
 572:	008b0993          	addi	s3,s6,8
 576:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 57a:	02090163          	beqz	s2,59c <vprintf+0x184>
        while(*s != 0){
 57e:	00094583          	lbu	a1,0(s2)
 582:	c9a1                	beqz	a1,5d2 <vprintf+0x1ba>
          putc(fd, *s);
 584:	8556                	mv	a0,s5
 586:	00000097          	auipc	ra,0x0
 58a:	dc6080e7          	jalr	-570(ra) # 34c <putc>
          s++;
 58e:	0905                	addi	s2,s2,1
        while(*s != 0){
 590:	00094583          	lbu	a1,0(s2)
 594:	f9e5                	bnez	a1,584 <vprintf+0x16c>
        s = va_arg(ap, char*);
 596:	8b4e                	mv	s6,s3
      state = 0;
 598:	4981                	li	s3,0
 59a:	bdf9                	j	478 <vprintf+0x60>
          s = "(null)";
 59c:	00000917          	auipc	s2,0x0
 5a0:	24c90913          	addi	s2,s2,588 # 7e8 <malloc+0x106>
        while(*s != 0){
 5a4:	02800593          	li	a1,40
 5a8:	bff1                	j	584 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 5aa:	008b0913          	addi	s2,s6,8
 5ae:	000b4583          	lbu	a1,0(s6)
 5b2:	8556                	mv	a0,s5
 5b4:	00000097          	auipc	ra,0x0
 5b8:	d98080e7          	jalr	-616(ra) # 34c <putc>
 5bc:	8b4a                	mv	s6,s2
      state = 0;
 5be:	4981                	li	s3,0
 5c0:	bd65                	j	478 <vprintf+0x60>
        putc(fd, c);
 5c2:	85d2                	mv	a1,s4
 5c4:	8556                	mv	a0,s5
 5c6:	00000097          	auipc	ra,0x0
 5ca:	d86080e7          	jalr	-634(ra) # 34c <putc>
      state = 0;
 5ce:	4981                	li	s3,0
 5d0:	b565                	j	478 <vprintf+0x60>
        s = va_arg(ap, char*);
 5d2:	8b4e                	mv	s6,s3
      state = 0;
 5d4:	4981                	li	s3,0
 5d6:	b54d                	j	478 <vprintf+0x60>
    }
  }
}
 5d8:	70e6                	ld	ra,120(sp)
 5da:	7446                	ld	s0,112(sp)
 5dc:	74a6                	ld	s1,104(sp)
 5de:	7906                	ld	s2,96(sp)
 5e0:	69e6                	ld	s3,88(sp)
 5e2:	6a46                	ld	s4,80(sp)
 5e4:	6aa6                	ld	s5,72(sp)
 5e6:	6b06                	ld	s6,64(sp)
 5e8:	7be2                	ld	s7,56(sp)
 5ea:	7c42                	ld	s8,48(sp)
 5ec:	7ca2                	ld	s9,40(sp)
 5ee:	7d02                	ld	s10,32(sp)
 5f0:	6de2                	ld	s11,24(sp)
 5f2:	6109                	addi	sp,sp,128
 5f4:	8082                	ret

00000000000005f6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 5f6:	715d                	addi	sp,sp,-80
 5f8:	ec06                	sd	ra,24(sp)
 5fa:	e822                	sd	s0,16(sp)
 5fc:	1000                	addi	s0,sp,32
 5fe:	e010                	sd	a2,0(s0)
 600:	e414                	sd	a3,8(s0)
 602:	e818                	sd	a4,16(s0)
 604:	ec1c                	sd	a5,24(s0)
 606:	03043023          	sd	a6,32(s0)
 60a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 60e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 612:	8622                	mv	a2,s0
 614:	00000097          	auipc	ra,0x0
 618:	e04080e7          	jalr	-508(ra) # 418 <vprintf>
}
 61c:	60e2                	ld	ra,24(sp)
 61e:	6442                	ld	s0,16(sp)
 620:	6161                	addi	sp,sp,80
 622:	8082                	ret

0000000000000624 <printf>:

void
printf(const char *fmt, ...)
{
 624:	711d                	addi	sp,sp,-96
 626:	ec06                	sd	ra,24(sp)
 628:	e822                	sd	s0,16(sp)
 62a:	1000                	addi	s0,sp,32
 62c:	e40c                	sd	a1,8(s0)
 62e:	e810                	sd	a2,16(s0)
 630:	ec14                	sd	a3,24(s0)
 632:	f018                	sd	a4,32(s0)
 634:	f41c                	sd	a5,40(s0)
 636:	03043823          	sd	a6,48(s0)
 63a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 63e:	00840613          	addi	a2,s0,8
 642:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 646:	85aa                	mv	a1,a0
 648:	4505                	li	a0,1
 64a:	00000097          	auipc	ra,0x0
 64e:	dce080e7          	jalr	-562(ra) # 418 <vprintf>
}
 652:	60e2                	ld	ra,24(sp)
 654:	6442                	ld	s0,16(sp)
 656:	6125                	addi	sp,sp,96
 658:	8082                	ret

000000000000065a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 65a:	1141                	addi	sp,sp,-16
 65c:	e422                	sd	s0,8(sp)
 65e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 660:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 664:	00001797          	auipc	a5,0x1
 668:	99c7b783          	ld	a5,-1636(a5) # 1000 <freep>
 66c:	a805                	j	69c <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 66e:	4618                	lw	a4,8(a2)
 670:	9db9                	addw	a1,a1,a4
 672:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 676:	6398                	ld	a4,0(a5)
 678:	6318                	ld	a4,0(a4)
 67a:	fee53823          	sd	a4,-16(a0)
 67e:	a091                	j	6c2 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 680:	ff852703          	lw	a4,-8(a0)
 684:	9e39                	addw	a2,a2,a4
 686:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 688:	ff053703          	ld	a4,-16(a0)
 68c:	e398                	sd	a4,0(a5)
 68e:	a099                	j	6d4 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 690:	6398                	ld	a4,0(a5)
 692:	00e7e463          	bltu	a5,a4,69a <free+0x40>
 696:	00e6ea63          	bltu	a3,a4,6aa <free+0x50>
{
 69a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 69c:	fed7fae3          	bgeu	a5,a3,690 <free+0x36>
 6a0:	6398                	ld	a4,0(a5)
 6a2:	00e6e463          	bltu	a3,a4,6aa <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a6:	fee7eae3          	bltu	a5,a4,69a <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 6aa:	ff852583          	lw	a1,-8(a0)
 6ae:	6390                	ld	a2,0(a5)
 6b0:	02059713          	slli	a4,a1,0x20
 6b4:	9301                	srli	a4,a4,0x20
 6b6:	0712                	slli	a4,a4,0x4
 6b8:	9736                	add	a4,a4,a3
 6ba:	fae60ae3          	beq	a2,a4,66e <free+0x14>
    bp->s.ptr = p->s.ptr;
 6be:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 6c2:	4790                	lw	a2,8(a5)
 6c4:	02061713          	slli	a4,a2,0x20
 6c8:	9301                	srli	a4,a4,0x20
 6ca:	0712                	slli	a4,a4,0x4
 6cc:	973e                	add	a4,a4,a5
 6ce:	fae689e3          	beq	a3,a4,680 <free+0x26>
  } else
    p->s.ptr = bp;
 6d2:	e394                	sd	a3,0(a5)
  freep = p;
 6d4:	00001717          	auipc	a4,0x1
 6d8:	92f73623          	sd	a5,-1748(a4) # 1000 <freep>
}
 6dc:	6422                	ld	s0,8(sp)
 6de:	0141                	addi	sp,sp,16
 6e0:	8082                	ret

00000000000006e2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6e2:	7139                	addi	sp,sp,-64
 6e4:	fc06                	sd	ra,56(sp)
 6e6:	f822                	sd	s0,48(sp)
 6e8:	f426                	sd	s1,40(sp)
 6ea:	f04a                	sd	s2,32(sp)
 6ec:	ec4e                	sd	s3,24(sp)
 6ee:	e852                	sd	s4,16(sp)
 6f0:	e456                	sd	s5,8(sp)
 6f2:	e05a                	sd	s6,0(sp)
 6f4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f6:	02051493          	slli	s1,a0,0x20
 6fa:	9081                	srli	s1,s1,0x20
 6fc:	04bd                	addi	s1,s1,15
 6fe:	8091                	srli	s1,s1,0x4
 700:	0014899b          	addiw	s3,s1,1
 704:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 706:	00001517          	auipc	a0,0x1
 70a:	8fa53503          	ld	a0,-1798(a0) # 1000 <freep>
 70e:	c515                	beqz	a0,73a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 710:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 712:	4798                	lw	a4,8(a5)
 714:	02977f63          	bgeu	a4,s1,752 <malloc+0x70>
 718:	8a4e                	mv	s4,s3
 71a:	0009871b          	sext.w	a4,s3
 71e:	6685                	lui	a3,0x1
 720:	00d77363          	bgeu	a4,a3,726 <malloc+0x44>
 724:	6a05                	lui	s4,0x1
 726:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 72a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 72e:	00001917          	auipc	s2,0x1
 732:	8d290913          	addi	s2,s2,-1838 # 1000 <freep>
  if(p == (char*)-1)
 736:	5afd                	li	s5,-1
 738:	a88d                	j	7aa <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 73a:	00001797          	auipc	a5,0x1
 73e:	8d678793          	addi	a5,a5,-1834 # 1010 <base>
 742:	00001717          	auipc	a4,0x1
 746:	8af73f23          	sd	a5,-1858(a4) # 1000 <freep>
 74a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 74c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 750:	b7e1                	j	718 <malloc+0x36>
      if(p->s.size == nunits)
 752:	02e48b63          	beq	s1,a4,788 <malloc+0xa6>
        p->s.size -= nunits;
 756:	4137073b          	subw	a4,a4,s3
 75a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 75c:	1702                	slli	a4,a4,0x20
 75e:	9301                	srli	a4,a4,0x20
 760:	0712                	slli	a4,a4,0x4
 762:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 764:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 768:	00001717          	auipc	a4,0x1
 76c:	88a73c23          	sd	a0,-1896(a4) # 1000 <freep>
      return (void*)(p + 1);
 770:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 774:	70e2                	ld	ra,56(sp)
 776:	7442                	ld	s0,48(sp)
 778:	74a2                	ld	s1,40(sp)
 77a:	7902                	ld	s2,32(sp)
 77c:	69e2                	ld	s3,24(sp)
 77e:	6a42                	ld	s4,16(sp)
 780:	6aa2                	ld	s5,8(sp)
 782:	6b02                	ld	s6,0(sp)
 784:	6121                	addi	sp,sp,64
 786:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 788:	6398                	ld	a4,0(a5)
 78a:	e118                	sd	a4,0(a0)
 78c:	bff1                	j	768 <malloc+0x86>
  hp->s.size = nu;
 78e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 792:	0541                	addi	a0,a0,16
 794:	00000097          	auipc	ra,0x0
 798:	ec6080e7          	jalr	-314(ra) # 65a <free>
  return freep;
 79c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 7a0:	d971                	beqz	a0,774 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7a4:	4798                	lw	a4,8(a5)
 7a6:	fa9776e3          	bgeu	a4,s1,752 <malloc+0x70>
    if(p == freep)
 7aa:	00093703          	ld	a4,0(s2)
 7ae:	853e                	mv	a0,a5
 7b0:	fef719e3          	bne	a4,a5,7a2 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 7b4:	8552                	mv	a0,s4
 7b6:	00000097          	auipc	ra,0x0
 7ba:	b76080e7          	jalr	-1162(ra) # 32c <sbrk>
  if(p == (char*)-1)
 7be:	fd5518e3          	bne	a0,s5,78e <malloc+0xac>
        return 0;
 7c2:	4501                	li	a0,0
 7c4:	bf45                	j	774 <malloc+0x92>
