
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	7119                	addi	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	f4a6                	sd	s1,104(sp)
   8:	f0ca                	sd	s2,96(sp)
   a:	ecce                	sd	s3,88(sp)
   c:	e8d2                	sd	s4,80(sp)
   e:	e4d6                	sd	s5,72(sp)
  10:	e0da                	sd	s6,64(sp)
  12:	fc5e                	sd	s7,56(sp)
  14:	f862                	sd	s8,48(sp)
  16:	f466                	sd	s9,40(sp)
  18:	f06a                	sd	s10,32(sp)
  1a:	ec6e                	sd	s11,24(sp)
  1c:	0100                	addi	s0,sp,128
  1e:	f8a43423          	sd	a0,-120(s0)
  22:	f8b43023          	sd	a1,-128(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  26:	4981                	li	s3,0
  l = w = c = 0;
  28:	4c81                	li	s9,0
  2a:	4c01                	li	s8,0
  2c:	4b81                	li	s7,0
  2e:	00001d97          	auipc	s11,0x1
  32:	fe3d8d93          	addi	s11,s11,-29 # 1011 <buf+0x1>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  36:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  38:	00001a17          	auipc	s4,0x1
  3c:	918a0a13          	addi	s4,s4,-1768 # 950 <malloc+0xea>
        inword = 0;
  40:	4b01                	li	s6,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  42:	a805                	j	72 <wc+0x72>
      if(strchr(" \r\t\n\v", buf[i]))
  44:	8552                	mv	a0,s4
  46:	00000097          	auipc	ra,0x0
  4a:	208080e7          	jalr	520(ra) # 24e <strchr>
  4e:	c919                	beqz	a0,64 <wc+0x64>
        inword = 0;
  50:	89da                	mv	s3,s6
    for(i=0; i<n; i++){
  52:	0485                	addi	s1,s1,1
  54:	01248d63          	beq	s1,s2,6e <wc+0x6e>
      if(buf[i] == '\n')
  58:	0004c583          	lbu	a1,0(s1)
  5c:	ff5594e3          	bne	a1,s5,44 <wc+0x44>
        l++;
  60:	2b85                	addiw	s7,s7,1
  62:	b7cd                	j	44 <wc+0x44>
      else if(!inword){
  64:	fe0997e3          	bnez	s3,52 <wc+0x52>
        w++;
  68:	2c05                	addiw	s8,s8,1
        inword = 1;
  6a:	4985                	li	s3,1
  6c:	b7dd                	j	52 <wc+0x52>
      c++;
  6e:	01ac8cbb          	addw	s9,s9,s10
  while((n = read(fd, buf, sizeof(buf))) > 0){
  72:	20000613          	li	a2,512
  76:	00001597          	auipc	a1,0x1
  7a:	f9a58593          	addi	a1,a1,-102 # 1010 <buf>
  7e:	f8843503          	ld	a0,-120(s0)
  82:	00000097          	auipc	ra,0x0
  86:	3be080e7          	jalr	958(ra) # 440 <read>
  8a:	00a05f63          	blez	a0,a8 <wc+0xa8>
    for(i=0; i<n; i++){
  8e:	00001497          	auipc	s1,0x1
  92:	f8248493          	addi	s1,s1,-126 # 1010 <buf>
  96:	00050d1b          	sext.w	s10,a0
  9a:	fff5091b          	addiw	s2,a0,-1
  9e:	1902                	slli	s2,s2,0x20
  a0:	02095913          	srli	s2,s2,0x20
  a4:	996e                	add	s2,s2,s11
  a6:	bf4d                	j	58 <wc+0x58>
      }
    }
  }
  if(n < 0){
  a8:	02054e63          	bltz	a0,e4 <wc+0xe4>
    printf("wc: read error\n");
    exit(1,0);
  }
  printf("%d %d %d %s\n", l, w, c, name);
  ac:	f8043703          	ld	a4,-128(s0)
  b0:	86e6                	mv	a3,s9
  b2:	8662                	mv	a2,s8
  b4:	85de                	mv	a1,s7
  b6:	00001517          	auipc	a0,0x1
  ba:	8b250513          	addi	a0,a0,-1870 # 968 <malloc+0x102>
  be:	00000097          	auipc	ra,0x0
  c2:	6ea080e7          	jalr	1770(ra) # 7a8 <printf>
}
  c6:	70e6                	ld	ra,120(sp)
  c8:	7446                	ld	s0,112(sp)
  ca:	74a6                	ld	s1,104(sp)
  cc:	7906                	ld	s2,96(sp)
  ce:	69e6                	ld	s3,88(sp)
  d0:	6a46                	ld	s4,80(sp)
  d2:	6aa6                	ld	s5,72(sp)
  d4:	6b06                	ld	s6,64(sp)
  d6:	7be2                	ld	s7,56(sp)
  d8:	7c42                	ld	s8,48(sp)
  da:	7ca2                	ld	s9,40(sp)
  dc:	7d02                	ld	s10,32(sp)
  de:	6de2                	ld	s11,24(sp)
  e0:	6109                	addi	sp,sp,128
  e2:	8082                	ret
    printf("wc: read error\n");
  e4:	00001517          	auipc	a0,0x1
  e8:	87450513          	addi	a0,a0,-1932 # 958 <malloc+0xf2>
  ec:	00000097          	auipc	ra,0x0
  f0:	6bc080e7          	jalr	1724(ra) # 7a8 <printf>
    exit(1,0);
  f4:	4581                	li	a1,0
  f6:	4505                	li	a0,1
  f8:	00000097          	auipc	ra,0x0
  fc:	330080e7          	jalr	816(ra) # 428 <exit>

0000000000000100 <main>:

int
main(int argc, char *argv[])
{
 100:	7179                	addi	sp,sp,-48
 102:	f406                	sd	ra,40(sp)
 104:	f022                	sd	s0,32(sp)
 106:	ec26                	sd	s1,24(sp)
 108:	e84a                	sd	s2,16(sp)
 10a:	e44e                	sd	s3,8(sp)
 10c:	e052                	sd	s4,0(sp)
 10e:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
 110:	4785                	li	a5,1
 112:	04a7d863          	bge	a5,a0,162 <main+0x62>
 116:	00858493          	addi	s1,a1,8
 11a:	ffe5099b          	addiw	s3,a0,-2
 11e:	1982                	slli	s3,s3,0x20
 120:	0209d993          	srli	s3,s3,0x20
 124:	098e                	slli	s3,s3,0x3
 126:	05c1                	addi	a1,a1,16
 128:	99ae                	add	s3,s3,a1
    wc(0, "");
    exit(0,0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
 12a:	4581                	li	a1,0
 12c:	6088                	ld	a0,0(s1)
 12e:	00000097          	auipc	ra,0x0
 132:	33a080e7          	jalr	826(ra) # 468 <open>
 136:	892a                	mv	s2,a0
 138:	04054463          	bltz	a0,180 <main+0x80>
      printf("wc: cannot open %s\n", argv[i]);
      exit(1,0);
    }
    wc(fd, argv[i]);
 13c:	608c                	ld	a1,0(s1)
 13e:	00000097          	auipc	ra,0x0
 142:	ec2080e7          	jalr	-318(ra) # 0 <wc>
    close(fd);
 146:	854a                	mv	a0,s2
 148:	00000097          	auipc	ra,0x0
 14c:	308080e7          	jalr	776(ra) # 450 <close>
  for(i = 1; i < argc; i++){
 150:	04a1                	addi	s1,s1,8
 152:	fd349ce3          	bne	s1,s3,12a <main+0x2a>
  }
  exit(0,0);
 156:	4581                	li	a1,0
 158:	4501                	li	a0,0
 15a:	00000097          	auipc	ra,0x0
 15e:	2ce080e7          	jalr	718(ra) # 428 <exit>
    wc(0, "");
 162:	00001597          	auipc	a1,0x1
 166:	81658593          	addi	a1,a1,-2026 # 978 <malloc+0x112>
 16a:	4501                	li	a0,0
 16c:	00000097          	auipc	ra,0x0
 170:	e94080e7          	jalr	-364(ra) # 0 <wc>
    exit(0,0);
 174:	4581                	li	a1,0
 176:	4501                	li	a0,0
 178:	00000097          	auipc	ra,0x0
 17c:	2b0080e7          	jalr	688(ra) # 428 <exit>
      printf("wc: cannot open %s\n", argv[i]);
 180:	608c                	ld	a1,0(s1)
 182:	00000517          	auipc	a0,0x0
 186:	7fe50513          	addi	a0,a0,2046 # 980 <malloc+0x11a>
 18a:	00000097          	auipc	ra,0x0
 18e:	61e080e7          	jalr	1566(ra) # 7a8 <printf>
      exit(1,0);
 192:	4581                	li	a1,0
 194:	4505                	li	a0,1
 196:	00000097          	auipc	ra,0x0
 19a:	292080e7          	jalr	658(ra) # 428 <exit>

000000000000019e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 19e:	1141                	addi	sp,sp,-16
 1a0:	e406                	sd	ra,8(sp)
 1a2:	e022                	sd	s0,0(sp)
 1a4:	0800                	addi	s0,sp,16
  extern int main();
  main();
 1a6:	00000097          	auipc	ra,0x0
 1aa:	f5a080e7          	jalr	-166(ra) # 100 <main>
  exit(0,0);
 1ae:	4581                	li	a1,0
 1b0:	4501                	li	a0,0
 1b2:	00000097          	auipc	ra,0x0
 1b6:	276080e7          	jalr	630(ra) # 428 <exit>

00000000000001ba <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1ba:	1141                	addi	sp,sp,-16
 1bc:	e422                	sd	s0,8(sp)
 1be:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1c0:	87aa                	mv	a5,a0
 1c2:	0585                	addi	a1,a1,1
 1c4:	0785                	addi	a5,a5,1
 1c6:	fff5c703          	lbu	a4,-1(a1)
 1ca:	fee78fa3          	sb	a4,-1(a5)
 1ce:	fb75                	bnez	a4,1c2 <strcpy+0x8>
    ;
  return os;
}
 1d0:	6422                	ld	s0,8(sp)
 1d2:	0141                	addi	sp,sp,16
 1d4:	8082                	ret

00000000000001d6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1d6:	1141                	addi	sp,sp,-16
 1d8:	e422                	sd	s0,8(sp)
 1da:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1dc:	00054783          	lbu	a5,0(a0)
 1e0:	cb91                	beqz	a5,1f4 <strcmp+0x1e>
 1e2:	0005c703          	lbu	a4,0(a1)
 1e6:	00f71763          	bne	a4,a5,1f4 <strcmp+0x1e>
    p++, q++;
 1ea:	0505                	addi	a0,a0,1
 1ec:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1ee:	00054783          	lbu	a5,0(a0)
 1f2:	fbe5                	bnez	a5,1e2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1f4:	0005c503          	lbu	a0,0(a1)
}
 1f8:	40a7853b          	subw	a0,a5,a0
 1fc:	6422                	ld	s0,8(sp)
 1fe:	0141                	addi	sp,sp,16
 200:	8082                	ret

0000000000000202 <strlen>:

uint
strlen(const char *s)
{
 202:	1141                	addi	sp,sp,-16
 204:	e422                	sd	s0,8(sp)
 206:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 208:	00054783          	lbu	a5,0(a0)
 20c:	cf91                	beqz	a5,228 <strlen+0x26>
 20e:	0505                	addi	a0,a0,1
 210:	87aa                	mv	a5,a0
 212:	4685                	li	a3,1
 214:	9e89                	subw	a3,a3,a0
 216:	00f6853b          	addw	a0,a3,a5
 21a:	0785                	addi	a5,a5,1
 21c:	fff7c703          	lbu	a4,-1(a5)
 220:	fb7d                	bnez	a4,216 <strlen+0x14>
    ;
  return n;
}
 222:	6422                	ld	s0,8(sp)
 224:	0141                	addi	sp,sp,16
 226:	8082                	ret
  for(n = 0; s[n]; n++)
 228:	4501                	li	a0,0
 22a:	bfe5                	j	222 <strlen+0x20>

000000000000022c <memset>:

void*
memset(void *dst, int c, uint n)
{
 22c:	1141                	addi	sp,sp,-16
 22e:	e422                	sd	s0,8(sp)
 230:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 232:	ca19                	beqz	a2,248 <memset+0x1c>
 234:	87aa                	mv	a5,a0
 236:	1602                	slli	a2,a2,0x20
 238:	9201                	srli	a2,a2,0x20
 23a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 23e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 242:	0785                	addi	a5,a5,1
 244:	fee79de3          	bne	a5,a4,23e <memset+0x12>
  }
  return dst;
}
 248:	6422                	ld	s0,8(sp)
 24a:	0141                	addi	sp,sp,16
 24c:	8082                	ret

000000000000024e <strchr>:

char*
strchr(const char *s, char c)
{
 24e:	1141                	addi	sp,sp,-16
 250:	e422                	sd	s0,8(sp)
 252:	0800                	addi	s0,sp,16
  for(; *s; s++)
 254:	00054783          	lbu	a5,0(a0)
 258:	cb99                	beqz	a5,26e <strchr+0x20>
    if(*s == c)
 25a:	00f58763          	beq	a1,a5,268 <strchr+0x1a>
  for(; *s; s++)
 25e:	0505                	addi	a0,a0,1
 260:	00054783          	lbu	a5,0(a0)
 264:	fbfd                	bnez	a5,25a <strchr+0xc>
      return (char*)s;
  return 0;
 266:	4501                	li	a0,0
}
 268:	6422                	ld	s0,8(sp)
 26a:	0141                	addi	sp,sp,16
 26c:	8082                	ret
  return 0;
 26e:	4501                	li	a0,0
 270:	bfe5                	j	268 <strchr+0x1a>

0000000000000272 <gets>:

char*
gets(char *buf, int max)
{
 272:	711d                	addi	sp,sp,-96
 274:	ec86                	sd	ra,88(sp)
 276:	e8a2                	sd	s0,80(sp)
 278:	e4a6                	sd	s1,72(sp)
 27a:	e0ca                	sd	s2,64(sp)
 27c:	fc4e                	sd	s3,56(sp)
 27e:	f852                	sd	s4,48(sp)
 280:	f456                	sd	s5,40(sp)
 282:	f05a                	sd	s6,32(sp)
 284:	ec5e                	sd	s7,24(sp)
 286:	1080                	addi	s0,sp,96
 288:	8baa                	mv	s7,a0
 28a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 28c:	892a                	mv	s2,a0
 28e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 290:	4aa9                	li	s5,10
 292:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 294:	89a6                	mv	s3,s1
 296:	2485                	addiw	s1,s1,1
 298:	0344d863          	bge	s1,s4,2c8 <gets+0x56>
    cc = read(0, &c, 1);
 29c:	4605                	li	a2,1
 29e:	faf40593          	addi	a1,s0,-81
 2a2:	4501                	li	a0,0
 2a4:	00000097          	auipc	ra,0x0
 2a8:	19c080e7          	jalr	412(ra) # 440 <read>
    if(cc < 1)
 2ac:	00a05e63          	blez	a0,2c8 <gets+0x56>
    buf[i++] = c;
 2b0:	faf44783          	lbu	a5,-81(s0)
 2b4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2b8:	01578763          	beq	a5,s5,2c6 <gets+0x54>
 2bc:	0905                	addi	s2,s2,1
 2be:	fd679be3          	bne	a5,s6,294 <gets+0x22>
  for(i=0; i+1 < max; ){
 2c2:	89a6                	mv	s3,s1
 2c4:	a011                	j	2c8 <gets+0x56>
 2c6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2c8:	99de                	add	s3,s3,s7
 2ca:	00098023          	sb	zero,0(s3)
  return buf;
}
 2ce:	855e                	mv	a0,s7
 2d0:	60e6                	ld	ra,88(sp)
 2d2:	6446                	ld	s0,80(sp)
 2d4:	64a6                	ld	s1,72(sp)
 2d6:	6906                	ld	s2,64(sp)
 2d8:	79e2                	ld	s3,56(sp)
 2da:	7a42                	ld	s4,48(sp)
 2dc:	7aa2                	ld	s5,40(sp)
 2de:	7b02                	ld	s6,32(sp)
 2e0:	6be2                	ld	s7,24(sp)
 2e2:	6125                	addi	sp,sp,96
 2e4:	8082                	ret

00000000000002e6 <stat>:

int
stat(const char *n, struct stat *st)
{
 2e6:	1101                	addi	sp,sp,-32
 2e8:	ec06                	sd	ra,24(sp)
 2ea:	e822                	sd	s0,16(sp)
 2ec:	e426                	sd	s1,8(sp)
 2ee:	e04a                	sd	s2,0(sp)
 2f0:	1000                	addi	s0,sp,32
 2f2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f4:	4581                	li	a1,0
 2f6:	00000097          	auipc	ra,0x0
 2fa:	172080e7          	jalr	370(ra) # 468 <open>
  if(fd < 0)
 2fe:	02054563          	bltz	a0,328 <stat+0x42>
 302:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 304:	85ca                	mv	a1,s2
 306:	00000097          	auipc	ra,0x0
 30a:	17a080e7          	jalr	378(ra) # 480 <fstat>
 30e:	892a                	mv	s2,a0
  close(fd);
 310:	8526                	mv	a0,s1
 312:	00000097          	auipc	ra,0x0
 316:	13e080e7          	jalr	318(ra) # 450 <close>
  return r;
}
 31a:	854a                	mv	a0,s2
 31c:	60e2                	ld	ra,24(sp)
 31e:	6442                	ld	s0,16(sp)
 320:	64a2                	ld	s1,8(sp)
 322:	6902                	ld	s2,0(sp)
 324:	6105                	addi	sp,sp,32
 326:	8082                	ret
    return -1;
 328:	597d                	li	s2,-1
 32a:	bfc5                	j	31a <stat+0x34>

000000000000032c <atoi>:

int
atoi(const char *s)
{
 32c:	1141                	addi	sp,sp,-16
 32e:	e422                	sd	s0,8(sp)
 330:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 332:	00054603          	lbu	a2,0(a0)
 336:	fd06079b          	addiw	a5,a2,-48
 33a:	0ff7f793          	andi	a5,a5,255
 33e:	4725                	li	a4,9
 340:	02f76963          	bltu	a4,a5,372 <atoi+0x46>
 344:	86aa                	mv	a3,a0
  n = 0;
 346:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 348:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 34a:	0685                	addi	a3,a3,1
 34c:	0025179b          	slliw	a5,a0,0x2
 350:	9fa9                	addw	a5,a5,a0
 352:	0017979b          	slliw	a5,a5,0x1
 356:	9fb1                	addw	a5,a5,a2
 358:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 35c:	0006c603          	lbu	a2,0(a3)
 360:	fd06071b          	addiw	a4,a2,-48
 364:	0ff77713          	andi	a4,a4,255
 368:	fee5f1e3          	bgeu	a1,a4,34a <atoi+0x1e>
  return n;
}
 36c:	6422                	ld	s0,8(sp)
 36e:	0141                	addi	sp,sp,16
 370:	8082                	ret
  n = 0;
 372:	4501                	li	a0,0
 374:	bfe5                	j	36c <atoi+0x40>

0000000000000376 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 376:	1141                	addi	sp,sp,-16
 378:	e422                	sd	s0,8(sp)
 37a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 37c:	02b57463          	bgeu	a0,a1,3a4 <memmove+0x2e>
    while(n-- > 0)
 380:	00c05f63          	blez	a2,39e <memmove+0x28>
 384:	1602                	slli	a2,a2,0x20
 386:	9201                	srli	a2,a2,0x20
 388:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 38c:	872a                	mv	a4,a0
      *dst++ = *src++;
 38e:	0585                	addi	a1,a1,1
 390:	0705                	addi	a4,a4,1
 392:	fff5c683          	lbu	a3,-1(a1)
 396:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 39a:	fee79ae3          	bne	a5,a4,38e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 39e:	6422                	ld	s0,8(sp)
 3a0:	0141                	addi	sp,sp,16
 3a2:	8082                	ret
    dst += n;
 3a4:	00c50733          	add	a4,a0,a2
    src += n;
 3a8:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3aa:	fec05ae3          	blez	a2,39e <memmove+0x28>
 3ae:	fff6079b          	addiw	a5,a2,-1
 3b2:	1782                	slli	a5,a5,0x20
 3b4:	9381                	srli	a5,a5,0x20
 3b6:	fff7c793          	not	a5,a5
 3ba:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3bc:	15fd                	addi	a1,a1,-1
 3be:	177d                	addi	a4,a4,-1
 3c0:	0005c683          	lbu	a3,0(a1)
 3c4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3c8:	fee79ae3          	bne	a5,a4,3bc <memmove+0x46>
 3cc:	bfc9                	j	39e <memmove+0x28>

00000000000003ce <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3ce:	1141                	addi	sp,sp,-16
 3d0:	e422                	sd	s0,8(sp)
 3d2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3d4:	ca05                	beqz	a2,404 <memcmp+0x36>
 3d6:	fff6069b          	addiw	a3,a2,-1
 3da:	1682                	slli	a3,a3,0x20
 3dc:	9281                	srli	a3,a3,0x20
 3de:	0685                	addi	a3,a3,1
 3e0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3e2:	00054783          	lbu	a5,0(a0)
 3e6:	0005c703          	lbu	a4,0(a1)
 3ea:	00e79863          	bne	a5,a4,3fa <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3ee:	0505                	addi	a0,a0,1
    p2++;
 3f0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3f2:	fed518e3          	bne	a0,a3,3e2 <memcmp+0x14>
  }
  return 0;
 3f6:	4501                	li	a0,0
 3f8:	a019                	j	3fe <memcmp+0x30>
      return *p1 - *p2;
 3fa:	40e7853b          	subw	a0,a5,a4
}
 3fe:	6422                	ld	s0,8(sp)
 400:	0141                	addi	sp,sp,16
 402:	8082                	ret
  return 0;
 404:	4501                	li	a0,0
 406:	bfe5                	j	3fe <memcmp+0x30>

0000000000000408 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 408:	1141                	addi	sp,sp,-16
 40a:	e406                	sd	ra,8(sp)
 40c:	e022                	sd	s0,0(sp)
 40e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 410:	00000097          	auipc	ra,0x0
 414:	f66080e7          	jalr	-154(ra) # 376 <memmove>
}
 418:	60a2                	ld	ra,8(sp)
 41a:	6402                	ld	s0,0(sp)
 41c:	0141                	addi	sp,sp,16
 41e:	8082                	ret

0000000000000420 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 420:	4885                	li	a7,1
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <exit>:
.global exit
exit:
 li a7, SYS_exit
 428:	4889                	li	a7,2
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <wait>:
.global wait
wait:
 li a7, SYS_wait
 430:	488d                	li	a7,3
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 438:	4891                	li	a7,4
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <read>:
.global read
read:
 li a7, SYS_read
 440:	4895                	li	a7,5
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <write>:
.global write
write:
 li a7, SYS_write
 448:	48c1                	li	a7,16
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <close>:
.global close
close:
 li a7, SYS_close
 450:	48d5                	li	a7,21
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <kill>:
.global kill
kill:
 li a7, SYS_kill
 458:	4899                	li	a7,6
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <exec>:
.global exec
exec:
 li a7, SYS_exec
 460:	489d                	li	a7,7
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <open>:
.global open
open:
 li a7, SYS_open
 468:	48bd                	li	a7,15
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 470:	48c5                	li	a7,17
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 478:	48c9                	li	a7,18
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 480:	48a1                	li	a7,8
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <link>:
.global link
link:
 li a7, SYS_link
 488:	48cd                	li	a7,19
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 490:	48d1                	li	a7,20
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 498:	48a5                	li	a7,9
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4a0:	48a9                	li	a7,10
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4a8:	48ad                	li	a7,11
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4b0:	48b1                	li	a7,12
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4b8:	48b5                	li	a7,13
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4c0:	48b9                	li	a7,14
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <memsize>:
.global memsize
memsize:
 li a7, SYS_memsize
 4c8:	48d9                	li	a7,22
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4d0:	1101                	addi	sp,sp,-32
 4d2:	ec06                	sd	ra,24(sp)
 4d4:	e822                	sd	s0,16(sp)
 4d6:	1000                	addi	s0,sp,32
 4d8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4dc:	4605                	li	a2,1
 4de:	fef40593          	addi	a1,s0,-17
 4e2:	00000097          	auipc	ra,0x0
 4e6:	f66080e7          	jalr	-154(ra) # 448 <write>
}
 4ea:	60e2                	ld	ra,24(sp)
 4ec:	6442                	ld	s0,16(sp)
 4ee:	6105                	addi	sp,sp,32
 4f0:	8082                	ret

00000000000004f2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4f2:	7139                	addi	sp,sp,-64
 4f4:	fc06                	sd	ra,56(sp)
 4f6:	f822                	sd	s0,48(sp)
 4f8:	f426                	sd	s1,40(sp)
 4fa:	f04a                	sd	s2,32(sp)
 4fc:	ec4e                	sd	s3,24(sp)
 4fe:	0080                	addi	s0,sp,64
 500:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 502:	c299                	beqz	a3,508 <printint+0x16>
 504:	0805c863          	bltz	a1,594 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 508:	2581                	sext.w	a1,a1
  neg = 0;
 50a:	4881                	li	a7,0
 50c:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 510:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 512:	2601                	sext.w	a2,a2
 514:	00000517          	auipc	a0,0x0
 518:	48c50513          	addi	a0,a0,1164 # 9a0 <digits>
 51c:	883a                	mv	a6,a4
 51e:	2705                	addiw	a4,a4,1
 520:	02c5f7bb          	remuw	a5,a1,a2
 524:	1782                	slli	a5,a5,0x20
 526:	9381                	srli	a5,a5,0x20
 528:	97aa                	add	a5,a5,a0
 52a:	0007c783          	lbu	a5,0(a5)
 52e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 532:	0005879b          	sext.w	a5,a1
 536:	02c5d5bb          	divuw	a1,a1,a2
 53a:	0685                	addi	a3,a3,1
 53c:	fec7f0e3          	bgeu	a5,a2,51c <printint+0x2a>
  if(neg)
 540:	00088b63          	beqz	a7,556 <printint+0x64>
    buf[i++] = '-';
 544:	fd040793          	addi	a5,s0,-48
 548:	973e                	add	a4,a4,a5
 54a:	02d00793          	li	a5,45
 54e:	fef70823          	sb	a5,-16(a4)
 552:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 556:	02e05863          	blez	a4,586 <printint+0x94>
 55a:	fc040793          	addi	a5,s0,-64
 55e:	00e78933          	add	s2,a5,a4
 562:	fff78993          	addi	s3,a5,-1
 566:	99ba                	add	s3,s3,a4
 568:	377d                	addiw	a4,a4,-1
 56a:	1702                	slli	a4,a4,0x20
 56c:	9301                	srli	a4,a4,0x20
 56e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 572:	fff94583          	lbu	a1,-1(s2)
 576:	8526                	mv	a0,s1
 578:	00000097          	auipc	ra,0x0
 57c:	f58080e7          	jalr	-168(ra) # 4d0 <putc>
  while(--i >= 0)
 580:	197d                	addi	s2,s2,-1
 582:	ff3918e3          	bne	s2,s3,572 <printint+0x80>
}
 586:	70e2                	ld	ra,56(sp)
 588:	7442                	ld	s0,48(sp)
 58a:	74a2                	ld	s1,40(sp)
 58c:	7902                	ld	s2,32(sp)
 58e:	69e2                	ld	s3,24(sp)
 590:	6121                	addi	sp,sp,64
 592:	8082                	ret
    x = -xx;
 594:	40b005bb          	negw	a1,a1
    neg = 1;
 598:	4885                	li	a7,1
    x = -xx;
 59a:	bf8d                	j	50c <printint+0x1a>

000000000000059c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 59c:	7119                	addi	sp,sp,-128
 59e:	fc86                	sd	ra,120(sp)
 5a0:	f8a2                	sd	s0,112(sp)
 5a2:	f4a6                	sd	s1,104(sp)
 5a4:	f0ca                	sd	s2,96(sp)
 5a6:	ecce                	sd	s3,88(sp)
 5a8:	e8d2                	sd	s4,80(sp)
 5aa:	e4d6                	sd	s5,72(sp)
 5ac:	e0da                	sd	s6,64(sp)
 5ae:	fc5e                	sd	s7,56(sp)
 5b0:	f862                	sd	s8,48(sp)
 5b2:	f466                	sd	s9,40(sp)
 5b4:	f06a                	sd	s10,32(sp)
 5b6:	ec6e                	sd	s11,24(sp)
 5b8:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5ba:	0005c903          	lbu	s2,0(a1)
 5be:	18090f63          	beqz	s2,75c <vprintf+0x1c0>
 5c2:	8aaa                	mv	s5,a0
 5c4:	8b32                	mv	s6,a2
 5c6:	00158493          	addi	s1,a1,1
  state = 0;
 5ca:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5cc:	02500a13          	li	s4,37
      if(c == 'd'){
 5d0:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 5d4:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 5d8:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 5dc:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5e0:	00000b97          	auipc	s7,0x0
 5e4:	3c0b8b93          	addi	s7,s7,960 # 9a0 <digits>
 5e8:	a839                	j	606 <vprintf+0x6a>
        putc(fd, c);
 5ea:	85ca                	mv	a1,s2
 5ec:	8556                	mv	a0,s5
 5ee:	00000097          	auipc	ra,0x0
 5f2:	ee2080e7          	jalr	-286(ra) # 4d0 <putc>
 5f6:	a019                	j	5fc <vprintf+0x60>
    } else if(state == '%'){
 5f8:	01498f63          	beq	s3,s4,616 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 5fc:	0485                	addi	s1,s1,1
 5fe:	fff4c903          	lbu	s2,-1(s1)
 602:	14090d63          	beqz	s2,75c <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 606:	0009079b          	sext.w	a5,s2
    if(state == 0){
 60a:	fe0997e3          	bnez	s3,5f8 <vprintf+0x5c>
      if(c == '%'){
 60e:	fd479ee3          	bne	a5,s4,5ea <vprintf+0x4e>
        state = '%';
 612:	89be                	mv	s3,a5
 614:	b7e5                	j	5fc <vprintf+0x60>
      if(c == 'd'){
 616:	05878063          	beq	a5,s8,656 <vprintf+0xba>
      } else if(c == 'l') {
 61a:	05978c63          	beq	a5,s9,672 <vprintf+0xd6>
      } else if(c == 'x') {
 61e:	07a78863          	beq	a5,s10,68e <vprintf+0xf2>
      } else if(c == 'p') {
 622:	09b78463          	beq	a5,s11,6aa <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 626:	07300713          	li	a4,115
 62a:	0ce78663          	beq	a5,a4,6f6 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 62e:	06300713          	li	a4,99
 632:	0ee78e63          	beq	a5,a4,72e <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 636:	11478863          	beq	a5,s4,746 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 63a:	85d2                	mv	a1,s4
 63c:	8556                	mv	a0,s5
 63e:	00000097          	auipc	ra,0x0
 642:	e92080e7          	jalr	-366(ra) # 4d0 <putc>
        putc(fd, c);
 646:	85ca                	mv	a1,s2
 648:	8556                	mv	a0,s5
 64a:	00000097          	auipc	ra,0x0
 64e:	e86080e7          	jalr	-378(ra) # 4d0 <putc>
      }
      state = 0;
 652:	4981                	li	s3,0
 654:	b765                	j	5fc <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 656:	008b0913          	addi	s2,s6,8
 65a:	4685                	li	a3,1
 65c:	4629                	li	a2,10
 65e:	000b2583          	lw	a1,0(s6)
 662:	8556                	mv	a0,s5
 664:	00000097          	auipc	ra,0x0
 668:	e8e080e7          	jalr	-370(ra) # 4f2 <printint>
 66c:	8b4a                	mv	s6,s2
      state = 0;
 66e:	4981                	li	s3,0
 670:	b771                	j	5fc <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 672:	008b0913          	addi	s2,s6,8
 676:	4681                	li	a3,0
 678:	4629                	li	a2,10
 67a:	000b2583          	lw	a1,0(s6)
 67e:	8556                	mv	a0,s5
 680:	00000097          	auipc	ra,0x0
 684:	e72080e7          	jalr	-398(ra) # 4f2 <printint>
 688:	8b4a                	mv	s6,s2
      state = 0;
 68a:	4981                	li	s3,0
 68c:	bf85                	j	5fc <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 68e:	008b0913          	addi	s2,s6,8
 692:	4681                	li	a3,0
 694:	4641                	li	a2,16
 696:	000b2583          	lw	a1,0(s6)
 69a:	8556                	mv	a0,s5
 69c:	00000097          	auipc	ra,0x0
 6a0:	e56080e7          	jalr	-426(ra) # 4f2 <printint>
 6a4:	8b4a                	mv	s6,s2
      state = 0;
 6a6:	4981                	li	s3,0
 6a8:	bf91                	j	5fc <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6aa:	008b0793          	addi	a5,s6,8
 6ae:	f8f43423          	sd	a5,-120(s0)
 6b2:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6b6:	03000593          	li	a1,48
 6ba:	8556                	mv	a0,s5
 6bc:	00000097          	auipc	ra,0x0
 6c0:	e14080e7          	jalr	-492(ra) # 4d0 <putc>
  putc(fd, 'x');
 6c4:	85ea                	mv	a1,s10
 6c6:	8556                	mv	a0,s5
 6c8:	00000097          	auipc	ra,0x0
 6cc:	e08080e7          	jalr	-504(ra) # 4d0 <putc>
 6d0:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6d2:	03c9d793          	srli	a5,s3,0x3c
 6d6:	97de                	add	a5,a5,s7
 6d8:	0007c583          	lbu	a1,0(a5)
 6dc:	8556                	mv	a0,s5
 6de:	00000097          	auipc	ra,0x0
 6e2:	df2080e7          	jalr	-526(ra) # 4d0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6e6:	0992                	slli	s3,s3,0x4
 6e8:	397d                	addiw	s2,s2,-1
 6ea:	fe0914e3          	bnez	s2,6d2 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 6ee:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6f2:	4981                	li	s3,0
 6f4:	b721                	j	5fc <vprintf+0x60>
        s = va_arg(ap, char*);
 6f6:	008b0993          	addi	s3,s6,8
 6fa:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 6fe:	02090163          	beqz	s2,720 <vprintf+0x184>
        while(*s != 0){
 702:	00094583          	lbu	a1,0(s2)
 706:	c9a1                	beqz	a1,756 <vprintf+0x1ba>
          putc(fd, *s);
 708:	8556                	mv	a0,s5
 70a:	00000097          	auipc	ra,0x0
 70e:	dc6080e7          	jalr	-570(ra) # 4d0 <putc>
          s++;
 712:	0905                	addi	s2,s2,1
        while(*s != 0){
 714:	00094583          	lbu	a1,0(s2)
 718:	f9e5                	bnez	a1,708 <vprintf+0x16c>
        s = va_arg(ap, char*);
 71a:	8b4e                	mv	s6,s3
      state = 0;
 71c:	4981                	li	s3,0
 71e:	bdf9                	j	5fc <vprintf+0x60>
          s = "(null)";
 720:	00000917          	auipc	s2,0x0
 724:	27890913          	addi	s2,s2,632 # 998 <malloc+0x132>
        while(*s != 0){
 728:	02800593          	li	a1,40
 72c:	bff1                	j	708 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 72e:	008b0913          	addi	s2,s6,8
 732:	000b4583          	lbu	a1,0(s6)
 736:	8556                	mv	a0,s5
 738:	00000097          	auipc	ra,0x0
 73c:	d98080e7          	jalr	-616(ra) # 4d0 <putc>
 740:	8b4a                	mv	s6,s2
      state = 0;
 742:	4981                	li	s3,0
 744:	bd65                	j	5fc <vprintf+0x60>
        putc(fd, c);
 746:	85d2                	mv	a1,s4
 748:	8556                	mv	a0,s5
 74a:	00000097          	auipc	ra,0x0
 74e:	d86080e7          	jalr	-634(ra) # 4d0 <putc>
      state = 0;
 752:	4981                	li	s3,0
 754:	b565                	j	5fc <vprintf+0x60>
        s = va_arg(ap, char*);
 756:	8b4e                	mv	s6,s3
      state = 0;
 758:	4981                	li	s3,0
 75a:	b54d                	j	5fc <vprintf+0x60>
    }
  }
}
 75c:	70e6                	ld	ra,120(sp)
 75e:	7446                	ld	s0,112(sp)
 760:	74a6                	ld	s1,104(sp)
 762:	7906                	ld	s2,96(sp)
 764:	69e6                	ld	s3,88(sp)
 766:	6a46                	ld	s4,80(sp)
 768:	6aa6                	ld	s5,72(sp)
 76a:	6b06                	ld	s6,64(sp)
 76c:	7be2                	ld	s7,56(sp)
 76e:	7c42                	ld	s8,48(sp)
 770:	7ca2                	ld	s9,40(sp)
 772:	7d02                	ld	s10,32(sp)
 774:	6de2                	ld	s11,24(sp)
 776:	6109                	addi	sp,sp,128
 778:	8082                	ret

000000000000077a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 77a:	715d                	addi	sp,sp,-80
 77c:	ec06                	sd	ra,24(sp)
 77e:	e822                	sd	s0,16(sp)
 780:	1000                	addi	s0,sp,32
 782:	e010                	sd	a2,0(s0)
 784:	e414                	sd	a3,8(s0)
 786:	e818                	sd	a4,16(s0)
 788:	ec1c                	sd	a5,24(s0)
 78a:	03043023          	sd	a6,32(s0)
 78e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 792:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 796:	8622                	mv	a2,s0
 798:	00000097          	auipc	ra,0x0
 79c:	e04080e7          	jalr	-508(ra) # 59c <vprintf>
}
 7a0:	60e2                	ld	ra,24(sp)
 7a2:	6442                	ld	s0,16(sp)
 7a4:	6161                	addi	sp,sp,80
 7a6:	8082                	ret

00000000000007a8 <printf>:

void
printf(const char *fmt, ...)
{
 7a8:	711d                	addi	sp,sp,-96
 7aa:	ec06                	sd	ra,24(sp)
 7ac:	e822                	sd	s0,16(sp)
 7ae:	1000                	addi	s0,sp,32
 7b0:	e40c                	sd	a1,8(s0)
 7b2:	e810                	sd	a2,16(s0)
 7b4:	ec14                	sd	a3,24(s0)
 7b6:	f018                	sd	a4,32(s0)
 7b8:	f41c                	sd	a5,40(s0)
 7ba:	03043823          	sd	a6,48(s0)
 7be:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7c2:	00840613          	addi	a2,s0,8
 7c6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7ca:	85aa                	mv	a1,a0
 7cc:	4505                	li	a0,1
 7ce:	00000097          	auipc	ra,0x0
 7d2:	dce080e7          	jalr	-562(ra) # 59c <vprintf>
}
 7d6:	60e2                	ld	ra,24(sp)
 7d8:	6442                	ld	s0,16(sp)
 7da:	6125                	addi	sp,sp,96
 7dc:	8082                	ret

00000000000007de <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7de:	1141                	addi	sp,sp,-16
 7e0:	e422                	sd	s0,8(sp)
 7e2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7e4:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e8:	00001797          	auipc	a5,0x1
 7ec:	8187b783          	ld	a5,-2024(a5) # 1000 <freep>
 7f0:	a805                	j	820 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7f2:	4618                	lw	a4,8(a2)
 7f4:	9db9                	addw	a1,a1,a4
 7f6:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7fa:	6398                	ld	a4,0(a5)
 7fc:	6318                	ld	a4,0(a4)
 7fe:	fee53823          	sd	a4,-16(a0)
 802:	a091                	j	846 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 804:	ff852703          	lw	a4,-8(a0)
 808:	9e39                	addw	a2,a2,a4
 80a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 80c:	ff053703          	ld	a4,-16(a0)
 810:	e398                	sd	a4,0(a5)
 812:	a099                	j	858 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 814:	6398                	ld	a4,0(a5)
 816:	00e7e463          	bltu	a5,a4,81e <free+0x40>
 81a:	00e6ea63          	bltu	a3,a4,82e <free+0x50>
{
 81e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 820:	fed7fae3          	bgeu	a5,a3,814 <free+0x36>
 824:	6398                	ld	a4,0(a5)
 826:	00e6e463          	bltu	a3,a4,82e <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 82a:	fee7eae3          	bltu	a5,a4,81e <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 82e:	ff852583          	lw	a1,-8(a0)
 832:	6390                	ld	a2,0(a5)
 834:	02059713          	slli	a4,a1,0x20
 838:	9301                	srli	a4,a4,0x20
 83a:	0712                	slli	a4,a4,0x4
 83c:	9736                	add	a4,a4,a3
 83e:	fae60ae3          	beq	a2,a4,7f2 <free+0x14>
    bp->s.ptr = p->s.ptr;
 842:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 846:	4790                	lw	a2,8(a5)
 848:	02061713          	slli	a4,a2,0x20
 84c:	9301                	srli	a4,a4,0x20
 84e:	0712                	slli	a4,a4,0x4
 850:	973e                	add	a4,a4,a5
 852:	fae689e3          	beq	a3,a4,804 <free+0x26>
  } else
    p->s.ptr = bp;
 856:	e394                	sd	a3,0(a5)
  freep = p;
 858:	00000717          	auipc	a4,0x0
 85c:	7af73423          	sd	a5,1960(a4) # 1000 <freep>
}
 860:	6422                	ld	s0,8(sp)
 862:	0141                	addi	sp,sp,16
 864:	8082                	ret

0000000000000866 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 866:	7139                	addi	sp,sp,-64
 868:	fc06                	sd	ra,56(sp)
 86a:	f822                	sd	s0,48(sp)
 86c:	f426                	sd	s1,40(sp)
 86e:	f04a                	sd	s2,32(sp)
 870:	ec4e                	sd	s3,24(sp)
 872:	e852                	sd	s4,16(sp)
 874:	e456                	sd	s5,8(sp)
 876:	e05a                	sd	s6,0(sp)
 878:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 87a:	02051493          	slli	s1,a0,0x20
 87e:	9081                	srli	s1,s1,0x20
 880:	04bd                	addi	s1,s1,15
 882:	8091                	srli	s1,s1,0x4
 884:	0014899b          	addiw	s3,s1,1
 888:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 88a:	00000517          	auipc	a0,0x0
 88e:	77653503          	ld	a0,1910(a0) # 1000 <freep>
 892:	c515                	beqz	a0,8be <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 894:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 896:	4798                	lw	a4,8(a5)
 898:	02977f63          	bgeu	a4,s1,8d6 <malloc+0x70>
 89c:	8a4e                	mv	s4,s3
 89e:	0009871b          	sext.w	a4,s3
 8a2:	6685                	lui	a3,0x1
 8a4:	00d77363          	bgeu	a4,a3,8aa <malloc+0x44>
 8a8:	6a05                	lui	s4,0x1
 8aa:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8ae:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8b2:	00000917          	auipc	s2,0x0
 8b6:	74e90913          	addi	s2,s2,1870 # 1000 <freep>
  if(p == (char*)-1)
 8ba:	5afd                	li	s5,-1
 8bc:	a88d                	j	92e <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 8be:	00001797          	auipc	a5,0x1
 8c2:	95278793          	addi	a5,a5,-1710 # 1210 <base>
 8c6:	00000717          	auipc	a4,0x0
 8ca:	72f73d23          	sd	a5,1850(a4) # 1000 <freep>
 8ce:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8d0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8d4:	b7e1                	j	89c <malloc+0x36>
      if(p->s.size == nunits)
 8d6:	02e48b63          	beq	s1,a4,90c <malloc+0xa6>
        p->s.size -= nunits;
 8da:	4137073b          	subw	a4,a4,s3
 8de:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8e0:	1702                	slli	a4,a4,0x20
 8e2:	9301                	srli	a4,a4,0x20
 8e4:	0712                	slli	a4,a4,0x4
 8e6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8e8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8ec:	00000717          	auipc	a4,0x0
 8f0:	70a73a23          	sd	a0,1812(a4) # 1000 <freep>
      return (void*)(p + 1);
 8f4:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8f8:	70e2                	ld	ra,56(sp)
 8fa:	7442                	ld	s0,48(sp)
 8fc:	74a2                	ld	s1,40(sp)
 8fe:	7902                	ld	s2,32(sp)
 900:	69e2                	ld	s3,24(sp)
 902:	6a42                	ld	s4,16(sp)
 904:	6aa2                	ld	s5,8(sp)
 906:	6b02                	ld	s6,0(sp)
 908:	6121                	addi	sp,sp,64
 90a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 90c:	6398                	ld	a4,0(a5)
 90e:	e118                	sd	a4,0(a0)
 910:	bff1                	j	8ec <malloc+0x86>
  hp->s.size = nu;
 912:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 916:	0541                	addi	a0,a0,16
 918:	00000097          	auipc	ra,0x0
 91c:	ec6080e7          	jalr	-314(ra) # 7de <free>
  return freep;
 920:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 924:	d971                	beqz	a0,8f8 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 926:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 928:	4798                	lw	a4,8(a5)
 92a:	fa9776e3          	bgeu	a4,s1,8d6 <malloc+0x70>
    if(p == freep)
 92e:	00093703          	ld	a4,0(s2)
 932:	853e                	mv	a0,a5
 934:	fef719e3          	bne	a4,a5,926 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 938:	8552                	mv	a0,s4
 93a:	00000097          	auipc	ra,0x0
 93e:	b76080e7          	jalr	-1162(ra) # 4b0 <sbrk>
  if(p == (char*)-1)
 942:	fd5518e3          	bne	a0,s5,912 <malloc+0xac>
        return 0;
 946:	4501                	li	a0,0
 948:	bf45                	j	8f8 <malloc+0x92>
