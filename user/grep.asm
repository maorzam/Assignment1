
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  16:	02e00a13          	li	s4,46
    if(matchhere(re, text))
  1a:	85a6                	mv	a1,s1
  1c:	854e                	mv	a0,s3
  1e:	00000097          	auipc	ra,0x0
  22:	030080e7          	jalr	48(ra) # 4e <matchhere>
  26:	e919                	bnez	a0,3c <matchstar+0x3c>
  }while(*text!='\0' && (*text++==c || c=='.'));
  28:	0004c783          	lbu	a5,0(s1)
  2c:	cb89                	beqz	a5,3e <matchstar+0x3e>
  2e:	0485                	addi	s1,s1,1
  30:	2781                	sext.w	a5,a5
  32:	ff2784e3          	beq	a5,s2,1a <matchstar+0x1a>
  36:	ff4902e3          	beq	s2,s4,1a <matchstar+0x1a>
  3a:	a011                	j	3e <matchstar+0x3e>
      return 1;
  3c:	4505                	li	a0,1
  return 0;
}
  3e:	70a2                	ld	ra,40(sp)
  40:	7402                	ld	s0,32(sp)
  42:	64e2                	ld	s1,24(sp)
  44:	6942                	ld	s2,16(sp)
  46:	69a2                	ld	s3,8(sp)
  48:	6a02                	ld	s4,0(sp)
  4a:	6145                	addi	sp,sp,48
  4c:	8082                	ret

000000000000004e <matchhere>:
  if(re[0] == '\0')
  4e:	00054703          	lbu	a4,0(a0)
  52:	cb3d                	beqz	a4,c8 <matchhere+0x7a>
{
  54:	1141                	addi	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	addi	s0,sp,16
  5c:	87aa                	mv	a5,a0
  if(re[1] == '*')
  5e:	00154683          	lbu	a3,1(a0)
  62:	02a00613          	li	a2,42
  66:	02c68563          	beq	a3,a2,90 <matchhere+0x42>
  if(re[0] == '$' && re[1] == '\0')
  6a:	02400613          	li	a2,36
  6e:	02c70a63          	beq	a4,a2,a2 <matchhere+0x54>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  72:	0005c683          	lbu	a3,0(a1)
  return 0;
  76:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  78:	ca81                	beqz	a3,88 <matchhere+0x3a>
  7a:	02e00613          	li	a2,46
  7e:	02c70d63          	beq	a4,a2,b8 <matchhere+0x6a>
  return 0;
  82:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  84:	02d70a63          	beq	a4,a3,b8 <matchhere+0x6a>
}
  88:	60a2                	ld	ra,8(sp)
  8a:	6402                	ld	s0,0(sp)
  8c:	0141                	addi	sp,sp,16
  8e:	8082                	ret
    return matchstar(re[0], re+2, text);
  90:	862e                	mv	a2,a1
  92:	00250593          	addi	a1,a0,2
  96:	853a                	mv	a0,a4
  98:	00000097          	auipc	ra,0x0
  9c:	f68080e7          	jalr	-152(ra) # 0 <matchstar>
  a0:	b7e5                	j	88 <matchhere+0x3a>
  if(re[0] == '$' && re[1] == '\0')
  a2:	c691                	beqz	a3,ae <matchhere+0x60>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  a4:	0005c683          	lbu	a3,0(a1)
  a8:	fee9                	bnez	a3,82 <matchhere+0x34>
  return 0;
  aa:	4501                	li	a0,0
  ac:	bff1                	j	88 <matchhere+0x3a>
    return *text == '\0';
  ae:	0005c503          	lbu	a0,0(a1)
  b2:	00153513          	seqz	a0,a0
  b6:	bfc9                	j	88 <matchhere+0x3a>
    return matchhere(re+1, text+1);
  b8:	0585                	addi	a1,a1,1
  ba:	00178513          	addi	a0,a5,1
  be:	00000097          	auipc	ra,0x0
  c2:	f90080e7          	jalr	-112(ra) # 4e <matchhere>
  c6:	b7c9                	j	88 <matchhere+0x3a>
    return 1;
  c8:	4505                	li	a0,1
}
  ca:	8082                	ret

00000000000000cc <match>:
{
  cc:	1101                	addi	sp,sp,-32
  ce:	ec06                	sd	ra,24(sp)
  d0:	e822                	sd	s0,16(sp)
  d2:	e426                	sd	s1,8(sp)
  d4:	e04a                	sd	s2,0(sp)
  d6:	1000                	addi	s0,sp,32
  d8:	892a                	mv	s2,a0
  da:	84ae                	mv	s1,a1
  if(re[0] == '^')
  dc:	00054703          	lbu	a4,0(a0)
  e0:	05e00793          	li	a5,94
  e4:	00f70e63          	beq	a4,a5,100 <match+0x34>
    if(matchhere(re, text))
  e8:	85a6                	mv	a1,s1
  ea:	854a                	mv	a0,s2
  ec:	00000097          	auipc	ra,0x0
  f0:	f62080e7          	jalr	-158(ra) # 4e <matchhere>
  f4:	ed01                	bnez	a0,10c <match+0x40>
  }while(*text++ != '\0');
  f6:	0485                	addi	s1,s1,1
  f8:	fff4c783          	lbu	a5,-1(s1)
  fc:	f7f5                	bnez	a5,e8 <match+0x1c>
  fe:	a801                	j	10e <match+0x42>
    return matchhere(re+1, text);
 100:	0505                	addi	a0,a0,1
 102:	00000097          	auipc	ra,0x0
 106:	f4c080e7          	jalr	-180(ra) # 4e <matchhere>
 10a:	a011                	j	10e <match+0x42>
      return 1;
 10c:	4505                	li	a0,1
}
 10e:	60e2                	ld	ra,24(sp)
 110:	6442                	ld	s0,16(sp)
 112:	64a2                	ld	s1,8(sp)
 114:	6902                	ld	s2,0(sp)
 116:	6105                	addi	sp,sp,32
 118:	8082                	ret

000000000000011a <grep>:
{
 11a:	715d                	addi	sp,sp,-80
 11c:	e486                	sd	ra,72(sp)
 11e:	e0a2                	sd	s0,64(sp)
 120:	fc26                	sd	s1,56(sp)
 122:	f84a                	sd	s2,48(sp)
 124:	f44e                	sd	s3,40(sp)
 126:	f052                	sd	s4,32(sp)
 128:	ec56                	sd	s5,24(sp)
 12a:	e85a                	sd	s6,16(sp)
 12c:	e45e                	sd	s7,8(sp)
 12e:	0880                	addi	s0,sp,80
 130:	89aa                	mv	s3,a0
 132:	8b2e                	mv	s6,a1
  m = 0;
 134:	4a01                	li	s4,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 136:	3ff00b93          	li	s7,1023
 13a:	00001a97          	auipc	s5,0x1
 13e:	ed6a8a93          	addi	s5,s5,-298 # 1010 <buf>
 142:	a0a1                	j	18a <grep+0x70>
      p = q+1;
 144:	00148913          	addi	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 148:	45a9                	li	a1,10
 14a:	854a                	mv	a0,s2
 14c:	00000097          	auipc	ra,0x0
 150:	20a080e7          	jalr	522(ra) # 356 <strchr>
 154:	84aa                	mv	s1,a0
 156:	c905                	beqz	a0,186 <grep+0x6c>
      *q = 0;
 158:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
 15c:	85ca                	mv	a1,s2
 15e:	854e                	mv	a0,s3
 160:	00000097          	auipc	ra,0x0
 164:	f6c080e7          	jalr	-148(ra) # cc <match>
 168:	dd71                	beqz	a0,144 <grep+0x2a>
        *q = '\n';
 16a:	47a9                	li	a5,10
 16c:	00f48023          	sb	a5,0(s1)
        write(1, p, q+1 - p);
 170:	00148613          	addi	a2,s1,1
 174:	4126063b          	subw	a2,a2,s2
 178:	85ca                	mv	a1,s2
 17a:	4505                	li	a0,1
 17c:	00000097          	auipc	ra,0x0
 180:	3d4080e7          	jalr	980(ra) # 550 <write>
 184:	b7c1                	j	144 <grep+0x2a>
    if(m > 0){
 186:	03404563          	bgtz	s4,1b0 <grep+0x96>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 18a:	414b863b          	subw	a2,s7,s4
 18e:	014a85b3          	add	a1,s5,s4
 192:	855a                	mv	a0,s6
 194:	00000097          	auipc	ra,0x0
 198:	3b4080e7          	jalr	948(ra) # 548 <read>
 19c:	02a05663          	blez	a0,1c8 <grep+0xae>
    m += n;
 1a0:	00aa0a3b          	addw	s4,s4,a0
    buf[m] = '\0';
 1a4:	014a87b3          	add	a5,s5,s4
 1a8:	00078023          	sb	zero,0(a5)
    p = buf;
 1ac:	8956                	mv	s2,s5
    while((q = strchr(p, '\n')) != 0){
 1ae:	bf69                	j	148 <grep+0x2e>
      m -= p - buf;
 1b0:	415907b3          	sub	a5,s2,s5
 1b4:	40fa0a3b          	subw	s4,s4,a5
      memmove(buf, p, m);
 1b8:	8652                	mv	a2,s4
 1ba:	85ca                	mv	a1,s2
 1bc:	8556                	mv	a0,s5
 1be:	00000097          	auipc	ra,0x0
 1c2:	2c0080e7          	jalr	704(ra) # 47e <memmove>
 1c6:	b7d1                	j	18a <grep+0x70>
}
 1c8:	60a6                	ld	ra,72(sp)
 1ca:	6406                	ld	s0,64(sp)
 1cc:	74e2                	ld	s1,56(sp)
 1ce:	7942                	ld	s2,48(sp)
 1d0:	79a2                	ld	s3,40(sp)
 1d2:	7a02                	ld	s4,32(sp)
 1d4:	6ae2                	ld	s5,24(sp)
 1d6:	6b42                	ld	s6,16(sp)
 1d8:	6ba2                	ld	s7,8(sp)
 1da:	6161                	addi	sp,sp,80
 1dc:	8082                	ret

00000000000001de <main>:
{
 1de:	7139                	addi	sp,sp,-64
 1e0:	fc06                	sd	ra,56(sp)
 1e2:	f822                	sd	s0,48(sp)
 1e4:	f426                	sd	s1,40(sp)
 1e6:	f04a                	sd	s2,32(sp)
 1e8:	ec4e                	sd	s3,24(sp)
 1ea:	e852                	sd	s4,16(sp)
 1ec:	e456                	sd	s5,8(sp)
 1ee:	0080                	addi	s0,sp,64
  if(argc <= 1){
 1f0:	4785                	li	a5,1
 1f2:	04a7df63          	bge	a5,a0,250 <main+0x72>
  pattern = argv[1];
 1f6:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
 1fa:	4789                	li	a5,2
 1fc:	06a7d963          	bge	a5,a0,26e <main+0x90>
 200:	01058913          	addi	s2,a1,16
 204:	ffd5099b          	addiw	s3,a0,-3
 208:	1982                	slli	s3,s3,0x20
 20a:	0209d993          	srli	s3,s3,0x20
 20e:	098e                	slli	s3,s3,0x3
 210:	05e1                	addi	a1,a1,24
 212:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], 0)) < 0){
 214:	4581                	li	a1,0
 216:	00093503          	ld	a0,0(s2)
 21a:	00000097          	auipc	ra,0x0
 21e:	356080e7          	jalr	854(ra) # 570 <open>
 222:	84aa                	mv	s1,a0
 224:	06054163          	bltz	a0,286 <main+0xa8>
    grep(pattern, fd);
 228:	85aa                	mv	a1,a0
 22a:	8552                	mv	a0,s4
 22c:	00000097          	auipc	ra,0x0
 230:	eee080e7          	jalr	-274(ra) # 11a <grep>
    close(fd);
 234:	8526                	mv	a0,s1
 236:	00000097          	auipc	ra,0x0
 23a:	322080e7          	jalr	802(ra) # 558 <close>
  for(i = 2; i < argc; i++){
 23e:	0921                	addi	s2,s2,8
 240:	fd391ae3          	bne	s2,s3,214 <main+0x36>
  exit(0,0);
 244:	4581                	li	a1,0
 246:	4501                	li	a0,0
 248:	00000097          	auipc	ra,0x0
 24c:	2e8080e7          	jalr	744(ra) # 530 <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 250:	00001597          	auipc	a1,0x1
 254:	82058593          	addi	a1,a1,-2016 # a70 <malloc+0xf2>
 258:	4509                	li	a0,2
 25a:	00000097          	auipc	ra,0x0
 25e:	638080e7          	jalr	1592(ra) # 892 <fprintf>
    exit(1,0);
 262:	4581                	li	a1,0
 264:	4505                	li	a0,1
 266:	00000097          	auipc	ra,0x0
 26a:	2ca080e7          	jalr	714(ra) # 530 <exit>
    grep(pattern, 0);
 26e:	4581                	li	a1,0
 270:	8552                	mv	a0,s4
 272:	00000097          	auipc	ra,0x0
 276:	ea8080e7          	jalr	-344(ra) # 11a <grep>
    exit(0,0);
 27a:	4581                	li	a1,0
 27c:	4501                	li	a0,0
 27e:	00000097          	auipc	ra,0x0
 282:	2b2080e7          	jalr	690(ra) # 530 <exit>
      printf("grep: cannot open %s\n", argv[i]);
 286:	00093583          	ld	a1,0(s2)
 28a:	00001517          	auipc	a0,0x1
 28e:	80650513          	addi	a0,a0,-2042 # a90 <malloc+0x112>
 292:	00000097          	auipc	ra,0x0
 296:	62e080e7          	jalr	1582(ra) # 8c0 <printf>
      exit(1,0);
 29a:	4581                	li	a1,0
 29c:	4505                	li	a0,1
 29e:	00000097          	auipc	ra,0x0
 2a2:	292080e7          	jalr	658(ra) # 530 <exit>

00000000000002a6 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 2a6:	1141                	addi	sp,sp,-16
 2a8:	e406                	sd	ra,8(sp)
 2aa:	e022                	sd	s0,0(sp)
 2ac:	0800                	addi	s0,sp,16
  extern int main();
  main();
 2ae:	00000097          	auipc	ra,0x0
 2b2:	f30080e7          	jalr	-208(ra) # 1de <main>
  exit(0,0);
 2b6:	4581                	li	a1,0
 2b8:	4501                	li	a0,0
 2ba:	00000097          	auipc	ra,0x0
 2be:	276080e7          	jalr	630(ra) # 530 <exit>

00000000000002c2 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 2c2:	1141                	addi	sp,sp,-16
 2c4:	e422                	sd	s0,8(sp)
 2c6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2c8:	87aa                	mv	a5,a0
 2ca:	0585                	addi	a1,a1,1
 2cc:	0785                	addi	a5,a5,1
 2ce:	fff5c703          	lbu	a4,-1(a1)
 2d2:	fee78fa3          	sb	a4,-1(a5)
 2d6:	fb75                	bnez	a4,2ca <strcpy+0x8>
    ;
  return os;
}
 2d8:	6422                	ld	s0,8(sp)
 2da:	0141                	addi	sp,sp,16
 2dc:	8082                	ret

00000000000002de <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2de:	1141                	addi	sp,sp,-16
 2e0:	e422                	sd	s0,8(sp)
 2e2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2e4:	00054783          	lbu	a5,0(a0)
 2e8:	cb91                	beqz	a5,2fc <strcmp+0x1e>
 2ea:	0005c703          	lbu	a4,0(a1)
 2ee:	00f71763          	bne	a4,a5,2fc <strcmp+0x1e>
    p++, q++;
 2f2:	0505                	addi	a0,a0,1
 2f4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2f6:	00054783          	lbu	a5,0(a0)
 2fa:	fbe5                	bnez	a5,2ea <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2fc:	0005c503          	lbu	a0,0(a1)
}
 300:	40a7853b          	subw	a0,a5,a0
 304:	6422                	ld	s0,8(sp)
 306:	0141                	addi	sp,sp,16
 308:	8082                	ret

000000000000030a <strlen>:

uint
strlen(const char *s)
{
 30a:	1141                	addi	sp,sp,-16
 30c:	e422                	sd	s0,8(sp)
 30e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 310:	00054783          	lbu	a5,0(a0)
 314:	cf91                	beqz	a5,330 <strlen+0x26>
 316:	0505                	addi	a0,a0,1
 318:	87aa                	mv	a5,a0
 31a:	4685                	li	a3,1
 31c:	9e89                	subw	a3,a3,a0
 31e:	00f6853b          	addw	a0,a3,a5
 322:	0785                	addi	a5,a5,1
 324:	fff7c703          	lbu	a4,-1(a5)
 328:	fb7d                	bnez	a4,31e <strlen+0x14>
    ;
  return n;
}
 32a:	6422                	ld	s0,8(sp)
 32c:	0141                	addi	sp,sp,16
 32e:	8082                	ret
  for(n = 0; s[n]; n++)
 330:	4501                	li	a0,0
 332:	bfe5                	j	32a <strlen+0x20>

0000000000000334 <memset>:

void*
memset(void *dst, int c, uint n)
{
 334:	1141                	addi	sp,sp,-16
 336:	e422                	sd	s0,8(sp)
 338:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 33a:	ca19                	beqz	a2,350 <memset+0x1c>
 33c:	87aa                	mv	a5,a0
 33e:	1602                	slli	a2,a2,0x20
 340:	9201                	srli	a2,a2,0x20
 342:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 346:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 34a:	0785                	addi	a5,a5,1
 34c:	fee79de3          	bne	a5,a4,346 <memset+0x12>
  }
  return dst;
}
 350:	6422                	ld	s0,8(sp)
 352:	0141                	addi	sp,sp,16
 354:	8082                	ret

0000000000000356 <strchr>:

char*
strchr(const char *s, char c)
{
 356:	1141                	addi	sp,sp,-16
 358:	e422                	sd	s0,8(sp)
 35a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 35c:	00054783          	lbu	a5,0(a0)
 360:	cb99                	beqz	a5,376 <strchr+0x20>
    if(*s == c)
 362:	00f58763          	beq	a1,a5,370 <strchr+0x1a>
  for(; *s; s++)
 366:	0505                	addi	a0,a0,1
 368:	00054783          	lbu	a5,0(a0)
 36c:	fbfd                	bnez	a5,362 <strchr+0xc>
      return (char*)s;
  return 0;
 36e:	4501                	li	a0,0
}
 370:	6422                	ld	s0,8(sp)
 372:	0141                	addi	sp,sp,16
 374:	8082                	ret
  return 0;
 376:	4501                	li	a0,0
 378:	bfe5                	j	370 <strchr+0x1a>

000000000000037a <gets>:

char*
gets(char *buf, int max)
{
 37a:	711d                	addi	sp,sp,-96
 37c:	ec86                	sd	ra,88(sp)
 37e:	e8a2                	sd	s0,80(sp)
 380:	e4a6                	sd	s1,72(sp)
 382:	e0ca                	sd	s2,64(sp)
 384:	fc4e                	sd	s3,56(sp)
 386:	f852                	sd	s4,48(sp)
 388:	f456                	sd	s5,40(sp)
 38a:	f05a                	sd	s6,32(sp)
 38c:	ec5e                	sd	s7,24(sp)
 38e:	1080                	addi	s0,sp,96
 390:	8baa                	mv	s7,a0
 392:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 394:	892a                	mv	s2,a0
 396:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 398:	4aa9                	li	s5,10
 39a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 39c:	89a6                	mv	s3,s1
 39e:	2485                	addiw	s1,s1,1
 3a0:	0344d863          	bge	s1,s4,3d0 <gets+0x56>
    cc = read(0, &c, 1);
 3a4:	4605                	li	a2,1
 3a6:	faf40593          	addi	a1,s0,-81
 3aa:	4501                	li	a0,0
 3ac:	00000097          	auipc	ra,0x0
 3b0:	19c080e7          	jalr	412(ra) # 548 <read>
    if(cc < 1)
 3b4:	00a05e63          	blez	a0,3d0 <gets+0x56>
    buf[i++] = c;
 3b8:	faf44783          	lbu	a5,-81(s0)
 3bc:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3c0:	01578763          	beq	a5,s5,3ce <gets+0x54>
 3c4:	0905                	addi	s2,s2,1
 3c6:	fd679be3          	bne	a5,s6,39c <gets+0x22>
  for(i=0; i+1 < max; ){
 3ca:	89a6                	mv	s3,s1
 3cc:	a011                	j	3d0 <gets+0x56>
 3ce:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3d0:	99de                	add	s3,s3,s7
 3d2:	00098023          	sb	zero,0(s3)
  return buf;
}
 3d6:	855e                	mv	a0,s7
 3d8:	60e6                	ld	ra,88(sp)
 3da:	6446                	ld	s0,80(sp)
 3dc:	64a6                	ld	s1,72(sp)
 3de:	6906                	ld	s2,64(sp)
 3e0:	79e2                	ld	s3,56(sp)
 3e2:	7a42                	ld	s4,48(sp)
 3e4:	7aa2                	ld	s5,40(sp)
 3e6:	7b02                	ld	s6,32(sp)
 3e8:	6be2                	ld	s7,24(sp)
 3ea:	6125                	addi	sp,sp,96
 3ec:	8082                	ret

00000000000003ee <stat>:

int
stat(const char *n, struct stat *st)
{
 3ee:	1101                	addi	sp,sp,-32
 3f0:	ec06                	sd	ra,24(sp)
 3f2:	e822                	sd	s0,16(sp)
 3f4:	e426                	sd	s1,8(sp)
 3f6:	e04a                	sd	s2,0(sp)
 3f8:	1000                	addi	s0,sp,32
 3fa:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3fc:	4581                	li	a1,0
 3fe:	00000097          	auipc	ra,0x0
 402:	172080e7          	jalr	370(ra) # 570 <open>
  if(fd < 0)
 406:	02054563          	bltz	a0,430 <stat+0x42>
 40a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 40c:	85ca                	mv	a1,s2
 40e:	00000097          	auipc	ra,0x0
 412:	17a080e7          	jalr	378(ra) # 588 <fstat>
 416:	892a                	mv	s2,a0
  close(fd);
 418:	8526                	mv	a0,s1
 41a:	00000097          	auipc	ra,0x0
 41e:	13e080e7          	jalr	318(ra) # 558 <close>
  return r;
}
 422:	854a                	mv	a0,s2
 424:	60e2                	ld	ra,24(sp)
 426:	6442                	ld	s0,16(sp)
 428:	64a2                	ld	s1,8(sp)
 42a:	6902                	ld	s2,0(sp)
 42c:	6105                	addi	sp,sp,32
 42e:	8082                	ret
    return -1;
 430:	597d                	li	s2,-1
 432:	bfc5                	j	422 <stat+0x34>

0000000000000434 <atoi>:

int
atoi(const char *s)
{
 434:	1141                	addi	sp,sp,-16
 436:	e422                	sd	s0,8(sp)
 438:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 43a:	00054603          	lbu	a2,0(a0)
 43e:	fd06079b          	addiw	a5,a2,-48
 442:	0ff7f793          	andi	a5,a5,255
 446:	4725                	li	a4,9
 448:	02f76963          	bltu	a4,a5,47a <atoi+0x46>
 44c:	86aa                	mv	a3,a0
  n = 0;
 44e:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 450:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 452:	0685                	addi	a3,a3,1
 454:	0025179b          	slliw	a5,a0,0x2
 458:	9fa9                	addw	a5,a5,a0
 45a:	0017979b          	slliw	a5,a5,0x1
 45e:	9fb1                	addw	a5,a5,a2
 460:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 464:	0006c603          	lbu	a2,0(a3)
 468:	fd06071b          	addiw	a4,a2,-48
 46c:	0ff77713          	andi	a4,a4,255
 470:	fee5f1e3          	bgeu	a1,a4,452 <atoi+0x1e>
  return n;
}
 474:	6422                	ld	s0,8(sp)
 476:	0141                	addi	sp,sp,16
 478:	8082                	ret
  n = 0;
 47a:	4501                	li	a0,0
 47c:	bfe5                	j	474 <atoi+0x40>

000000000000047e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 47e:	1141                	addi	sp,sp,-16
 480:	e422                	sd	s0,8(sp)
 482:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 484:	02b57463          	bgeu	a0,a1,4ac <memmove+0x2e>
    while(n-- > 0)
 488:	00c05f63          	blez	a2,4a6 <memmove+0x28>
 48c:	1602                	slli	a2,a2,0x20
 48e:	9201                	srli	a2,a2,0x20
 490:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 494:	872a                	mv	a4,a0
      *dst++ = *src++;
 496:	0585                	addi	a1,a1,1
 498:	0705                	addi	a4,a4,1
 49a:	fff5c683          	lbu	a3,-1(a1)
 49e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4a2:	fee79ae3          	bne	a5,a4,496 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4a6:	6422                	ld	s0,8(sp)
 4a8:	0141                	addi	sp,sp,16
 4aa:	8082                	ret
    dst += n;
 4ac:	00c50733          	add	a4,a0,a2
    src += n;
 4b0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4b2:	fec05ae3          	blez	a2,4a6 <memmove+0x28>
 4b6:	fff6079b          	addiw	a5,a2,-1
 4ba:	1782                	slli	a5,a5,0x20
 4bc:	9381                	srli	a5,a5,0x20
 4be:	fff7c793          	not	a5,a5
 4c2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4c4:	15fd                	addi	a1,a1,-1
 4c6:	177d                	addi	a4,a4,-1
 4c8:	0005c683          	lbu	a3,0(a1)
 4cc:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4d0:	fee79ae3          	bne	a5,a4,4c4 <memmove+0x46>
 4d4:	bfc9                	j	4a6 <memmove+0x28>

00000000000004d6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4d6:	1141                	addi	sp,sp,-16
 4d8:	e422                	sd	s0,8(sp)
 4da:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4dc:	ca05                	beqz	a2,50c <memcmp+0x36>
 4de:	fff6069b          	addiw	a3,a2,-1
 4e2:	1682                	slli	a3,a3,0x20
 4e4:	9281                	srli	a3,a3,0x20
 4e6:	0685                	addi	a3,a3,1
 4e8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4ea:	00054783          	lbu	a5,0(a0)
 4ee:	0005c703          	lbu	a4,0(a1)
 4f2:	00e79863          	bne	a5,a4,502 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4f6:	0505                	addi	a0,a0,1
    p2++;
 4f8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4fa:	fed518e3          	bne	a0,a3,4ea <memcmp+0x14>
  }
  return 0;
 4fe:	4501                	li	a0,0
 500:	a019                	j	506 <memcmp+0x30>
      return *p1 - *p2;
 502:	40e7853b          	subw	a0,a5,a4
}
 506:	6422                	ld	s0,8(sp)
 508:	0141                	addi	sp,sp,16
 50a:	8082                	ret
  return 0;
 50c:	4501                	li	a0,0
 50e:	bfe5                	j	506 <memcmp+0x30>

0000000000000510 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 510:	1141                	addi	sp,sp,-16
 512:	e406                	sd	ra,8(sp)
 514:	e022                	sd	s0,0(sp)
 516:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 518:	00000097          	auipc	ra,0x0
 51c:	f66080e7          	jalr	-154(ra) # 47e <memmove>
}
 520:	60a2                	ld	ra,8(sp)
 522:	6402                	ld	s0,0(sp)
 524:	0141                	addi	sp,sp,16
 526:	8082                	ret

0000000000000528 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 528:	4885                	li	a7,1
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <exit>:
.global exit
exit:
 li a7, SYS_exit
 530:	4889                	li	a7,2
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <wait>:
.global wait
wait:
 li a7, SYS_wait
 538:	488d                	li	a7,3
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 540:	4891                	li	a7,4
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <read>:
.global read
read:
 li a7, SYS_read
 548:	4895                	li	a7,5
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <write>:
.global write
write:
 li a7, SYS_write
 550:	48c1                	li	a7,16
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <close>:
.global close
close:
 li a7, SYS_close
 558:	48d5                	li	a7,21
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <kill>:
.global kill
kill:
 li a7, SYS_kill
 560:	4899                	li	a7,6
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <exec>:
.global exec
exec:
 li a7, SYS_exec
 568:	489d                	li	a7,7
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <open>:
.global open
open:
 li a7, SYS_open
 570:	48bd                	li	a7,15
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 578:	48c5                	li	a7,17
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 580:	48c9                	li	a7,18
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 588:	48a1                	li	a7,8
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <link>:
.global link
link:
 li a7, SYS_link
 590:	48cd                	li	a7,19
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 598:	48d1                	li	a7,20
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5a0:	48a5                	li	a7,9
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5a8:	48a9                	li	a7,10
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5b0:	48ad                	li	a7,11
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5b8:	48b1                	li	a7,12
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5c0:	48b5                	li	a7,13
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5c8:	48b9                	li	a7,14
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <memsize>:
.global memsize
memsize:
 li a7, SYS_memsize
 5d0:	48d9                	li	a7,22
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <set_ps_priority>:
.global set_ps_priority
set_ps_priority:
 li a7, SYS_set_ps_priority
 5d8:	48dd                	li	a7,23
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <set_cfs_priority>:
.global set_cfs_priority
set_cfs_priority:
 li a7, SYS_set_cfs_priority
 5e0:	48e1                	li	a7,24
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5e8:	1101                	addi	sp,sp,-32
 5ea:	ec06                	sd	ra,24(sp)
 5ec:	e822                	sd	s0,16(sp)
 5ee:	1000                	addi	s0,sp,32
 5f0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5f4:	4605                	li	a2,1
 5f6:	fef40593          	addi	a1,s0,-17
 5fa:	00000097          	auipc	ra,0x0
 5fe:	f56080e7          	jalr	-170(ra) # 550 <write>
}
 602:	60e2                	ld	ra,24(sp)
 604:	6442                	ld	s0,16(sp)
 606:	6105                	addi	sp,sp,32
 608:	8082                	ret

000000000000060a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 60a:	7139                	addi	sp,sp,-64
 60c:	fc06                	sd	ra,56(sp)
 60e:	f822                	sd	s0,48(sp)
 610:	f426                	sd	s1,40(sp)
 612:	f04a                	sd	s2,32(sp)
 614:	ec4e                	sd	s3,24(sp)
 616:	0080                	addi	s0,sp,64
 618:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 61a:	c299                	beqz	a3,620 <printint+0x16>
 61c:	0805c863          	bltz	a1,6ac <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 620:	2581                	sext.w	a1,a1
  neg = 0;
 622:	4881                	li	a7,0
 624:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 628:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 62a:	2601                	sext.w	a2,a2
 62c:	00000517          	auipc	a0,0x0
 630:	48450513          	addi	a0,a0,1156 # ab0 <digits>
 634:	883a                	mv	a6,a4
 636:	2705                	addiw	a4,a4,1
 638:	02c5f7bb          	remuw	a5,a1,a2
 63c:	1782                	slli	a5,a5,0x20
 63e:	9381                	srli	a5,a5,0x20
 640:	97aa                	add	a5,a5,a0
 642:	0007c783          	lbu	a5,0(a5)
 646:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 64a:	0005879b          	sext.w	a5,a1
 64e:	02c5d5bb          	divuw	a1,a1,a2
 652:	0685                	addi	a3,a3,1
 654:	fec7f0e3          	bgeu	a5,a2,634 <printint+0x2a>
  if(neg)
 658:	00088b63          	beqz	a7,66e <printint+0x64>
    buf[i++] = '-';
 65c:	fd040793          	addi	a5,s0,-48
 660:	973e                	add	a4,a4,a5
 662:	02d00793          	li	a5,45
 666:	fef70823          	sb	a5,-16(a4)
 66a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 66e:	02e05863          	blez	a4,69e <printint+0x94>
 672:	fc040793          	addi	a5,s0,-64
 676:	00e78933          	add	s2,a5,a4
 67a:	fff78993          	addi	s3,a5,-1
 67e:	99ba                	add	s3,s3,a4
 680:	377d                	addiw	a4,a4,-1
 682:	1702                	slli	a4,a4,0x20
 684:	9301                	srli	a4,a4,0x20
 686:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 68a:	fff94583          	lbu	a1,-1(s2)
 68e:	8526                	mv	a0,s1
 690:	00000097          	auipc	ra,0x0
 694:	f58080e7          	jalr	-168(ra) # 5e8 <putc>
  while(--i >= 0)
 698:	197d                	addi	s2,s2,-1
 69a:	ff3918e3          	bne	s2,s3,68a <printint+0x80>
}
 69e:	70e2                	ld	ra,56(sp)
 6a0:	7442                	ld	s0,48(sp)
 6a2:	74a2                	ld	s1,40(sp)
 6a4:	7902                	ld	s2,32(sp)
 6a6:	69e2                	ld	s3,24(sp)
 6a8:	6121                	addi	sp,sp,64
 6aa:	8082                	ret
    x = -xx;
 6ac:	40b005bb          	negw	a1,a1
    neg = 1;
 6b0:	4885                	li	a7,1
    x = -xx;
 6b2:	bf8d                	j	624 <printint+0x1a>

00000000000006b4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6b4:	7119                	addi	sp,sp,-128
 6b6:	fc86                	sd	ra,120(sp)
 6b8:	f8a2                	sd	s0,112(sp)
 6ba:	f4a6                	sd	s1,104(sp)
 6bc:	f0ca                	sd	s2,96(sp)
 6be:	ecce                	sd	s3,88(sp)
 6c0:	e8d2                	sd	s4,80(sp)
 6c2:	e4d6                	sd	s5,72(sp)
 6c4:	e0da                	sd	s6,64(sp)
 6c6:	fc5e                	sd	s7,56(sp)
 6c8:	f862                	sd	s8,48(sp)
 6ca:	f466                	sd	s9,40(sp)
 6cc:	f06a                	sd	s10,32(sp)
 6ce:	ec6e                	sd	s11,24(sp)
 6d0:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6d2:	0005c903          	lbu	s2,0(a1)
 6d6:	18090f63          	beqz	s2,874 <vprintf+0x1c0>
 6da:	8aaa                	mv	s5,a0
 6dc:	8b32                	mv	s6,a2
 6de:	00158493          	addi	s1,a1,1
  state = 0;
 6e2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6e4:	02500a13          	li	s4,37
      if(c == 'd'){
 6e8:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 6ec:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 6f0:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 6f4:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6f8:	00000b97          	auipc	s7,0x0
 6fc:	3b8b8b93          	addi	s7,s7,952 # ab0 <digits>
 700:	a839                	j	71e <vprintf+0x6a>
        putc(fd, c);
 702:	85ca                	mv	a1,s2
 704:	8556                	mv	a0,s5
 706:	00000097          	auipc	ra,0x0
 70a:	ee2080e7          	jalr	-286(ra) # 5e8 <putc>
 70e:	a019                	j	714 <vprintf+0x60>
    } else if(state == '%'){
 710:	01498f63          	beq	s3,s4,72e <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 714:	0485                	addi	s1,s1,1
 716:	fff4c903          	lbu	s2,-1(s1)
 71a:	14090d63          	beqz	s2,874 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 71e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 722:	fe0997e3          	bnez	s3,710 <vprintf+0x5c>
      if(c == '%'){
 726:	fd479ee3          	bne	a5,s4,702 <vprintf+0x4e>
        state = '%';
 72a:	89be                	mv	s3,a5
 72c:	b7e5                	j	714 <vprintf+0x60>
      if(c == 'd'){
 72e:	05878063          	beq	a5,s8,76e <vprintf+0xba>
      } else if(c == 'l') {
 732:	05978c63          	beq	a5,s9,78a <vprintf+0xd6>
      } else if(c == 'x') {
 736:	07a78863          	beq	a5,s10,7a6 <vprintf+0xf2>
      } else if(c == 'p') {
 73a:	09b78463          	beq	a5,s11,7c2 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 73e:	07300713          	li	a4,115
 742:	0ce78663          	beq	a5,a4,80e <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 746:	06300713          	li	a4,99
 74a:	0ee78e63          	beq	a5,a4,846 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 74e:	11478863          	beq	a5,s4,85e <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 752:	85d2                	mv	a1,s4
 754:	8556                	mv	a0,s5
 756:	00000097          	auipc	ra,0x0
 75a:	e92080e7          	jalr	-366(ra) # 5e8 <putc>
        putc(fd, c);
 75e:	85ca                	mv	a1,s2
 760:	8556                	mv	a0,s5
 762:	00000097          	auipc	ra,0x0
 766:	e86080e7          	jalr	-378(ra) # 5e8 <putc>
      }
      state = 0;
 76a:	4981                	li	s3,0
 76c:	b765                	j	714 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 76e:	008b0913          	addi	s2,s6,8
 772:	4685                	li	a3,1
 774:	4629                	li	a2,10
 776:	000b2583          	lw	a1,0(s6)
 77a:	8556                	mv	a0,s5
 77c:	00000097          	auipc	ra,0x0
 780:	e8e080e7          	jalr	-370(ra) # 60a <printint>
 784:	8b4a                	mv	s6,s2
      state = 0;
 786:	4981                	li	s3,0
 788:	b771                	j	714 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 78a:	008b0913          	addi	s2,s6,8
 78e:	4681                	li	a3,0
 790:	4629                	li	a2,10
 792:	000b2583          	lw	a1,0(s6)
 796:	8556                	mv	a0,s5
 798:	00000097          	auipc	ra,0x0
 79c:	e72080e7          	jalr	-398(ra) # 60a <printint>
 7a0:	8b4a                	mv	s6,s2
      state = 0;
 7a2:	4981                	li	s3,0
 7a4:	bf85                	j	714 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 7a6:	008b0913          	addi	s2,s6,8
 7aa:	4681                	li	a3,0
 7ac:	4641                	li	a2,16
 7ae:	000b2583          	lw	a1,0(s6)
 7b2:	8556                	mv	a0,s5
 7b4:	00000097          	auipc	ra,0x0
 7b8:	e56080e7          	jalr	-426(ra) # 60a <printint>
 7bc:	8b4a                	mv	s6,s2
      state = 0;
 7be:	4981                	li	s3,0
 7c0:	bf91                	j	714 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 7c2:	008b0793          	addi	a5,s6,8
 7c6:	f8f43423          	sd	a5,-120(s0)
 7ca:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7ce:	03000593          	li	a1,48
 7d2:	8556                	mv	a0,s5
 7d4:	00000097          	auipc	ra,0x0
 7d8:	e14080e7          	jalr	-492(ra) # 5e8 <putc>
  putc(fd, 'x');
 7dc:	85ea                	mv	a1,s10
 7de:	8556                	mv	a0,s5
 7e0:	00000097          	auipc	ra,0x0
 7e4:	e08080e7          	jalr	-504(ra) # 5e8 <putc>
 7e8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7ea:	03c9d793          	srli	a5,s3,0x3c
 7ee:	97de                	add	a5,a5,s7
 7f0:	0007c583          	lbu	a1,0(a5)
 7f4:	8556                	mv	a0,s5
 7f6:	00000097          	auipc	ra,0x0
 7fa:	df2080e7          	jalr	-526(ra) # 5e8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7fe:	0992                	slli	s3,s3,0x4
 800:	397d                	addiw	s2,s2,-1
 802:	fe0914e3          	bnez	s2,7ea <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 806:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 80a:	4981                	li	s3,0
 80c:	b721                	j	714 <vprintf+0x60>
        s = va_arg(ap, char*);
 80e:	008b0993          	addi	s3,s6,8
 812:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 816:	02090163          	beqz	s2,838 <vprintf+0x184>
        while(*s != 0){
 81a:	00094583          	lbu	a1,0(s2)
 81e:	c9a1                	beqz	a1,86e <vprintf+0x1ba>
          putc(fd, *s);
 820:	8556                	mv	a0,s5
 822:	00000097          	auipc	ra,0x0
 826:	dc6080e7          	jalr	-570(ra) # 5e8 <putc>
          s++;
 82a:	0905                	addi	s2,s2,1
        while(*s != 0){
 82c:	00094583          	lbu	a1,0(s2)
 830:	f9e5                	bnez	a1,820 <vprintf+0x16c>
        s = va_arg(ap, char*);
 832:	8b4e                	mv	s6,s3
      state = 0;
 834:	4981                	li	s3,0
 836:	bdf9                	j	714 <vprintf+0x60>
          s = "(null)";
 838:	00000917          	auipc	s2,0x0
 83c:	27090913          	addi	s2,s2,624 # aa8 <malloc+0x12a>
        while(*s != 0){
 840:	02800593          	li	a1,40
 844:	bff1                	j	820 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 846:	008b0913          	addi	s2,s6,8
 84a:	000b4583          	lbu	a1,0(s6)
 84e:	8556                	mv	a0,s5
 850:	00000097          	auipc	ra,0x0
 854:	d98080e7          	jalr	-616(ra) # 5e8 <putc>
 858:	8b4a                	mv	s6,s2
      state = 0;
 85a:	4981                	li	s3,0
 85c:	bd65                	j	714 <vprintf+0x60>
        putc(fd, c);
 85e:	85d2                	mv	a1,s4
 860:	8556                	mv	a0,s5
 862:	00000097          	auipc	ra,0x0
 866:	d86080e7          	jalr	-634(ra) # 5e8 <putc>
      state = 0;
 86a:	4981                	li	s3,0
 86c:	b565                	j	714 <vprintf+0x60>
        s = va_arg(ap, char*);
 86e:	8b4e                	mv	s6,s3
      state = 0;
 870:	4981                	li	s3,0
 872:	b54d                	j	714 <vprintf+0x60>
    }
  }
}
 874:	70e6                	ld	ra,120(sp)
 876:	7446                	ld	s0,112(sp)
 878:	74a6                	ld	s1,104(sp)
 87a:	7906                	ld	s2,96(sp)
 87c:	69e6                	ld	s3,88(sp)
 87e:	6a46                	ld	s4,80(sp)
 880:	6aa6                	ld	s5,72(sp)
 882:	6b06                	ld	s6,64(sp)
 884:	7be2                	ld	s7,56(sp)
 886:	7c42                	ld	s8,48(sp)
 888:	7ca2                	ld	s9,40(sp)
 88a:	7d02                	ld	s10,32(sp)
 88c:	6de2                	ld	s11,24(sp)
 88e:	6109                	addi	sp,sp,128
 890:	8082                	ret

0000000000000892 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 892:	715d                	addi	sp,sp,-80
 894:	ec06                	sd	ra,24(sp)
 896:	e822                	sd	s0,16(sp)
 898:	1000                	addi	s0,sp,32
 89a:	e010                	sd	a2,0(s0)
 89c:	e414                	sd	a3,8(s0)
 89e:	e818                	sd	a4,16(s0)
 8a0:	ec1c                	sd	a5,24(s0)
 8a2:	03043023          	sd	a6,32(s0)
 8a6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8aa:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8ae:	8622                	mv	a2,s0
 8b0:	00000097          	auipc	ra,0x0
 8b4:	e04080e7          	jalr	-508(ra) # 6b4 <vprintf>
}
 8b8:	60e2                	ld	ra,24(sp)
 8ba:	6442                	ld	s0,16(sp)
 8bc:	6161                	addi	sp,sp,80
 8be:	8082                	ret

00000000000008c0 <printf>:

void
printf(const char *fmt, ...)
{
 8c0:	711d                	addi	sp,sp,-96
 8c2:	ec06                	sd	ra,24(sp)
 8c4:	e822                	sd	s0,16(sp)
 8c6:	1000                	addi	s0,sp,32
 8c8:	e40c                	sd	a1,8(s0)
 8ca:	e810                	sd	a2,16(s0)
 8cc:	ec14                	sd	a3,24(s0)
 8ce:	f018                	sd	a4,32(s0)
 8d0:	f41c                	sd	a5,40(s0)
 8d2:	03043823          	sd	a6,48(s0)
 8d6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8da:	00840613          	addi	a2,s0,8
 8de:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8e2:	85aa                	mv	a1,a0
 8e4:	4505                	li	a0,1
 8e6:	00000097          	auipc	ra,0x0
 8ea:	dce080e7          	jalr	-562(ra) # 6b4 <vprintf>
}
 8ee:	60e2                	ld	ra,24(sp)
 8f0:	6442                	ld	s0,16(sp)
 8f2:	6125                	addi	sp,sp,96
 8f4:	8082                	ret

00000000000008f6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8f6:	1141                	addi	sp,sp,-16
 8f8:	e422                	sd	s0,8(sp)
 8fa:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8fc:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 900:	00000797          	auipc	a5,0x0
 904:	7007b783          	ld	a5,1792(a5) # 1000 <freep>
 908:	a805                	j	938 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 90a:	4618                	lw	a4,8(a2)
 90c:	9db9                	addw	a1,a1,a4
 90e:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 912:	6398                	ld	a4,0(a5)
 914:	6318                	ld	a4,0(a4)
 916:	fee53823          	sd	a4,-16(a0)
 91a:	a091                	j	95e <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 91c:	ff852703          	lw	a4,-8(a0)
 920:	9e39                	addw	a2,a2,a4
 922:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 924:	ff053703          	ld	a4,-16(a0)
 928:	e398                	sd	a4,0(a5)
 92a:	a099                	j	970 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 92c:	6398                	ld	a4,0(a5)
 92e:	00e7e463          	bltu	a5,a4,936 <free+0x40>
 932:	00e6ea63          	bltu	a3,a4,946 <free+0x50>
{
 936:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 938:	fed7fae3          	bgeu	a5,a3,92c <free+0x36>
 93c:	6398                	ld	a4,0(a5)
 93e:	00e6e463          	bltu	a3,a4,946 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 942:	fee7eae3          	bltu	a5,a4,936 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 946:	ff852583          	lw	a1,-8(a0)
 94a:	6390                	ld	a2,0(a5)
 94c:	02059713          	slli	a4,a1,0x20
 950:	9301                	srli	a4,a4,0x20
 952:	0712                	slli	a4,a4,0x4
 954:	9736                	add	a4,a4,a3
 956:	fae60ae3          	beq	a2,a4,90a <free+0x14>
    bp->s.ptr = p->s.ptr;
 95a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 95e:	4790                	lw	a2,8(a5)
 960:	02061713          	slli	a4,a2,0x20
 964:	9301                	srli	a4,a4,0x20
 966:	0712                	slli	a4,a4,0x4
 968:	973e                	add	a4,a4,a5
 96a:	fae689e3          	beq	a3,a4,91c <free+0x26>
  } else
    p->s.ptr = bp;
 96e:	e394                	sd	a3,0(a5)
  freep = p;
 970:	00000717          	auipc	a4,0x0
 974:	68f73823          	sd	a5,1680(a4) # 1000 <freep>
}
 978:	6422                	ld	s0,8(sp)
 97a:	0141                	addi	sp,sp,16
 97c:	8082                	ret

000000000000097e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 97e:	7139                	addi	sp,sp,-64
 980:	fc06                	sd	ra,56(sp)
 982:	f822                	sd	s0,48(sp)
 984:	f426                	sd	s1,40(sp)
 986:	f04a                	sd	s2,32(sp)
 988:	ec4e                	sd	s3,24(sp)
 98a:	e852                	sd	s4,16(sp)
 98c:	e456                	sd	s5,8(sp)
 98e:	e05a                	sd	s6,0(sp)
 990:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 992:	02051493          	slli	s1,a0,0x20
 996:	9081                	srli	s1,s1,0x20
 998:	04bd                	addi	s1,s1,15
 99a:	8091                	srli	s1,s1,0x4
 99c:	0014899b          	addiw	s3,s1,1
 9a0:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9a2:	00000517          	auipc	a0,0x0
 9a6:	65e53503          	ld	a0,1630(a0) # 1000 <freep>
 9aa:	c515                	beqz	a0,9d6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9ac:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9ae:	4798                	lw	a4,8(a5)
 9b0:	02977f63          	bgeu	a4,s1,9ee <malloc+0x70>
 9b4:	8a4e                	mv	s4,s3
 9b6:	0009871b          	sext.w	a4,s3
 9ba:	6685                	lui	a3,0x1
 9bc:	00d77363          	bgeu	a4,a3,9c2 <malloc+0x44>
 9c0:	6a05                	lui	s4,0x1
 9c2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9c6:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9ca:	00000917          	auipc	s2,0x0
 9ce:	63690913          	addi	s2,s2,1590 # 1000 <freep>
  if(p == (char*)-1)
 9d2:	5afd                	li	s5,-1
 9d4:	a88d                	j	a46 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 9d6:	00001797          	auipc	a5,0x1
 9da:	a3a78793          	addi	a5,a5,-1478 # 1410 <base>
 9de:	00000717          	auipc	a4,0x0
 9e2:	62f73123          	sd	a5,1570(a4) # 1000 <freep>
 9e6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9e8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9ec:	b7e1                	j	9b4 <malloc+0x36>
      if(p->s.size == nunits)
 9ee:	02e48b63          	beq	s1,a4,a24 <malloc+0xa6>
        p->s.size -= nunits;
 9f2:	4137073b          	subw	a4,a4,s3
 9f6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9f8:	1702                	slli	a4,a4,0x20
 9fa:	9301                	srli	a4,a4,0x20
 9fc:	0712                	slli	a4,a4,0x4
 9fe:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a00:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a04:	00000717          	auipc	a4,0x0
 a08:	5ea73e23          	sd	a0,1532(a4) # 1000 <freep>
      return (void*)(p + 1);
 a0c:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a10:	70e2                	ld	ra,56(sp)
 a12:	7442                	ld	s0,48(sp)
 a14:	74a2                	ld	s1,40(sp)
 a16:	7902                	ld	s2,32(sp)
 a18:	69e2                	ld	s3,24(sp)
 a1a:	6a42                	ld	s4,16(sp)
 a1c:	6aa2                	ld	s5,8(sp)
 a1e:	6b02                	ld	s6,0(sp)
 a20:	6121                	addi	sp,sp,64
 a22:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a24:	6398                	ld	a4,0(a5)
 a26:	e118                	sd	a4,0(a0)
 a28:	bff1                	j	a04 <malloc+0x86>
  hp->s.size = nu;
 a2a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a2e:	0541                	addi	a0,a0,16
 a30:	00000097          	auipc	ra,0x0
 a34:	ec6080e7          	jalr	-314(ra) # 8f6 <free>
  return freep;
 a38:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a3c:	d971                	beqz	a0,a10 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a3e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a40:	4798                	lw	a4,8(a5)
 a42:	fa9776e3          	bgeu	a4,s1,9ee <malloc+0x70>
    if(p == freep)
 a46:	00093703          	ld	a4,0(s2)
 a4a:	853e                	mv	a0,a5
 a4c:	fef719e3          	bne	a4,a5,a3e <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 a50:	8552                	mv	a0,s4
 a52:	00000097          	auipc	ra,0x0
 a56:	b66080e7          	jalr	-1178(ra) # 5b8 <sbrk>
  if(p == (char*)-1)
 a5a:	fd5518e3          	bne	a0,s5,a2a <malloc+0xac>
        return 0;
 a5e:	4501                	li	a0,0
 a60:	bf45                	j	a10 <malloc+0x92>
