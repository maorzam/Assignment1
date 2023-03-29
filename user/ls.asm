
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  10:	00000097          	auipc	ra,0x0
  14:	330080e7          	jalr	816(ra) # 340 <strlen>
  18:	02051793          	slli	a5,a0,0x20
  1c:	9381                	srli	a5,a5,0x20
  1e:	97a6                	add	a5,a5,s1
  20:	02f00693          	li	a3,47
  24:	0097e963          	bltu	a5,s1,36 <fmtname+0x36>
  28:	0007c703          	lbu	a4,0(a5)
  2c:	00d70563          	beq	a4,a3,36 <fmtname+0x36>
  30:	17fd                	addi	a5,a5,-1
  32:	fe97fbe3          	bgeu	a5,s1,28 <fmtname+0x28>
    ;
  p++;
  36:	00178493          	addi	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  3a:	8526                	mv	a0,s1
  3c:	00000097          	auipc	ra,0x0
  40:	304080e7          	jalr	772(ra) # 340 <strlen>
  44:	2501                	sext.w	a0,a0
  46:	47b5                	li	a5,13
  48:	00a7fa63          	bgeu	a5,a0,5c <fmtname+0x5c>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  4c:	8526                	mv	a0,s1
  4e:	70a2                	ld	ra,40(sp)
  50:	7402                	ld	s0,32(sp)
  52:	64e2                	ld	s1,24(sp)
  54:	6942                	ld	s2,16(sp)
  56:	69a2                	ld	s3,8(sp)
  58:	6145                	addi	sp,sp,48
  5a:	8082                	ret
  memmove(buf, p, strlen(p));
  5c:	8526                	mv	a0,s1
  5e:	00000097          	auipc	ra,0x0
  62:	2e2080e7          	jalr	738(ra) # 340 <strlen>
  66:	00001997          	auipc	s3,0x1
  6a:	faa98993          	addi	s3,s3,-86 # 1010 <buf.0>
  6e:	0005061b          	sext.w	a2,a0
  72:	85a6                	mv	a1,s1
  74:	854e                	mv	a0,s3
  76:	00000097          	auipc	ra,0x0
  7a:	43e080e7          	jalr	1086(ra) # 4b4 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  7e:	8526                	mv	a0,s1
  80:	00000097          	auipc	ra,0x0
  84:	2c0080e7          	jalr	704(ra) # 340 <strlen>
  88:	0005091b          	sext.w	s2,a0
  8c:	8526                	mv	a0,s1
  8e:	00000097          	auipc	ra,0x0
  92:	2b2080e7          	jalr	690(ra) # 340 <strlen>
  96:	1902                	slli	s2,s2,0x20
  98:	02095913          	srli	s2,s2,0x20
  9c:	4639                	li	a2,14
  9e:	9e09                	subw	a2,a2,a0
  a0:	02000593          	li	a1,32
  a4:	01298533          	add	a0,s3,s2
  a8:	00000097          	auipc	ra,0x0
  ac:	2c2080e7          	jalr	706(ra) # 36a <memset>
  return buf;
  b0:	84ce                	mv	s1,s3
  b2:	bf69                	j	4c <fmtname+0x4c>

00000000000000b4 <ls>:

void
ls(char *path)
{
  b4:	d9010113          	addi	sp,sp,-624
  b8:	26113423          	sd	ra,616(sp)
  bc:	26813023          	sd	s0,608(sp)
  c0:	24913c23          	sd	s1,600(sp)
  c4:	25213823          	sd	s2,592(sp)
  c8:	25313423          	sd	s3,584(sp)
  cc:	25413023          	sd	s4,576(sp)
  d0:	23513c23          	sd	s5,568(sp)
  d4:	1c80                	addi	s0,sp,624
  d6:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  d8:	4581                	li	a1,0
  da:	00000097          	auipc	ra,0x0
  de:	4cc080e7          	jalr	1228(ra) # 5a6 <open>
  e2:	08054163          	bltz	a0,164 <ls+0xb0>
  e6:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  e8:	d9840593          	addi	a1,s0,-616
  ec:	00000097          	auipc	ra,0x0
  f0:	4d2080e7          	jalr	1234(ra) # 5be <fstat>
  f4:	08054363          	bltz	a0,17a <ls+0xc6>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  f8:	da041783          	lh	a5,-608(s0)
  fc:	0007869b          	sext.w	a3,a5
 100:	4705                	li	a4,1
 102:	08e68c63          	beq	a3,a4,19a <ls+0xe6>
 106:	37f9                	addiw	a5,a5,-2
 108:	17c2                	slli	a5,a5,0x30
 10a:	93c1                	srli	a5,a5,0x30
 10c:	02f76663          	bltu	a4,a5,138 <ls+0x84>
  case T_DEVICE:
  case T_FILE:
    printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
 110:	854a                	mv	a0,s2
 112:	00000097          	auipc	ra,0x0
 116:	eee080e7          	jalr	-274(ra) # 0 <fmtname>
 11a:	85aa                	mv	a1,a0
 11c:	da843703          	ld	a4,-600(s0)
 120:	d9c42683          	lw	a3,-612(s0)
 124:	da041603          	lh	a2,-608(s0)
 128:	00001517          	auipc	a0,0x1
 12c:	99850513          	addi	a0,a0,-1640 # ac0 <malloc+0x11c>
 130:	00000097          	auipc	ra,0x0
 134:	7b6080e7          	jalr	1974(ra) # 8e6 <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 138:	8526                	mv	a0,s1
 13a:	00000097          	auipc	ra,0x0
 13e:	454080e7          	jalr	1108(ra) # 58e <close>
}
 142:	26813083          	ld	ra,616(sp)
 146:	26013403          	ld	s0,608(sp)
 14a:	25813483          	ld	s1,600(sp)
 14e:	25013903          	ld	s2,592(sp)
 152:	24813983          	ld	s3,584(sp)
 156:	24013a03          	ld	s4,576(sp)
 15a:	23813a83          	ld	s5,568(sp)
 15e:	27010113          	addi	sp,sp,624
 162:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
 164:	864a                	mv	a2,s2
 166:	00001597          	auipc	a1,0x1
 16a:	92a58593          	addi	a1,a1,-1750 # a90 <malloc+0xec>
 16e:	4509                	li	a0,2
 170:	00000097          	auipc	ra,0x0
 174:	748080e7          	jalr	1864(ra) # 8b8 <fprintf>
    return;
 178:	b7e9                	j	142 <ls+0x8e>
    fprintf(2, "ls: cannot stat %s\n", path);
 17a:	864a                	mv	a2,s2
 17c:	00001597          	auipc	a1,0x1
 180:	92c58593          	addi	a1,a1,-1748 # aa8 <malloc+0x104>
 184:	4509                	li	a0,2
 186:	00000097          	auipc	ra,0x0
 18a:	732080e7          	jalr	1842(ra) # 8b8 <fprintf>
    close(fd);
 18e:	8526                	mv	a0,s1
 190:	00000097          	auipc	ra,0x0
 194:	3fe080e7          	jalr	1022(ra) # 58e <close>
    return;
 198:	b76d                	j	142 <ls+0x8e>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 19a:	854a                	mv	a0,s2
 19c:	00000097          	auipc	ra,0x0
 1a0:	1a4080e7          	jalr	420(ra) # 340 <strlen>
 1a4:	2541                	addiw	a0,a0,16
 1a6:	20000793          	li	a5,512
 1aa:	00a7fb63          	bgeu	a5,a0,1c0 <ls+0x10c>
      printf("ls: path too long\n");
 1ae:	00001517          	auipc	a0,0x1
 1b2:	92250513          	addi	a0,a0,-1758 # ad0 <malloc+0x12c>
 1b6:	00000097          	auipc	ra,0x0
 1ba:	730080e7          	jalr	1840(ra) # 8e6 <printf>
      break;
 1be:	bfad                	j	138 <ls+0x84>
    strcpy(buf, path);
 1c0:	85ca                	mv	a1,s2
 1c2:	dc040513          	addi	a0,s0,-576
 1c6:	00000097          	auipc	ra,0x0
 1ca:	132080e7          	jalr	306(ra) # 2f8 <strcpy>
    p = buf+strlen(buf);
 1ce:	dc040513          	addi	a0,s0,-576
 1d2:	00000097          	auipc	ra,0x0
 1d6:	16e080e7          	jalr	366(ra) # 340 <strlen>
 1da:	02051913          	slli	s2,a0,0x20
 1de:	02095913          	srli	s2,s2,0x20
 1e2:	dc040793          	addi	a5,s0,-576
 1e6:	993e                	add	s2,s2,a5
    *p++ = '/';
 1e8:	00190993          	addi	s3,s2,1
 1ec:	02f00793          	li	a5,47
 1f0:	00f90023          	sb	a5,0(s2)
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 1f4:	00001a17          	auipc	s4,0x1
 1f8:	8f4a0a13          	addi	s4,s4,-1804 # ae8 <malloc+0x144>
        printf("ls: cannot stat %s\n", buf);
 1fc:	00001a97          	auipc	s5,0x1
 200:	8aca8a93          	addi	s5,s5,-1876 # aa8 <malloc+0x104>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 204:	a801                	j	214 <ls+0x160>
        printf("ls: cannot stat %s\n", buf);
 206:	dc040593          	addi	a1,s0,-576
 20a:	8556                	mv	a0,s5
 20c:	00000097          	auipc	ra,0x0
 210:	6da080e7          	jalr	1754(ra) # 8e6 <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 214:	4641                	li	a2,16
 216:	db040593          	addi	a1,s0,-592
 21a:	8526                	mv	a0,s1
 21c:	00000097          	auipc	ra,0x0
 220:	362080e7          	jalr	866(ra) # 57e <read>
 224:	47c1                	li	a5,16
 226:	f0f519e3          	bne	a0,a5,138 <ls+0x84>
      if(de.inum == 0)
 22a:	db045783          	lhu	a5,-592(s0)
 22e:	d3fd                	beqz	a5,214 <ls+0x160>
      memmove(p, de.name, DIRSIZ);
 230:	4639                	li	a2,14
 232:	db240593          	addi	a1,s0,-590
 236:	854e                	mv	a0,s3
 238:	00000097          	auipc	ra,0x0
 23c:	27c080e7          	jalr	636(ra) # 4b4 <memmove>
      p[DIRSIZ] = 0;
 240:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 244:	d9840593          	addi	a1,s0,-616
 248:	dc040513          	addi	a0,s0,-576
 24c:	00000097          	auipc	ra,0x0
 250:	1d8080e7          	jalr	472(ra) # 424 <stat>
 254:	fa0549e3          	bltz	a0,206 <ls+0x152>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 258:	dc040513          	addi	a0,s0,-576
 25c:	00000097          	auipc	ra,0x0
 260:	da4080e7          	jalr	-604(ra) # 0 <fmtname>
 264:	85aa                	mv	a1,a0
 266:	da843703          	ld	a4,-600(s0)
 26a:	d9c42683          	lw	a3,-612(s0)
 26e:	da041603          	lh	a2,-608(s0)
 272:	8552                	mv	a0,s4
 274:	00000097          	auipc	ra,0x0
 278:	672080e7          	jalr	1650(ra) # 8e6 <printf>
 27c:	bf61                	j	214 <ls+0x160>

000000000000027e <main>:

int
main(int argc, char *argv[])
{
 27e:	1101                	addi	sp,sp,-32
 280:	ec06                	sd	ra,24(sp)
 282:	e822                	sd	s0,16(sp)
 284:	e426                	sd	s1,8(sp)
 286:	e04a                	sd	s2,0(sp)
 288:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
 28a:	4785                	li	a5,1
 28c:	02a7da63          	bge	a5,a0,2c0 <main+0x42>
 290:	00858493          	addi	s1,a1,8
 294:	ffe5091b          	addiw	s2,a0,-2
 298:	1902                	slli	s2,s2,0x20
 29a:	02095913          	srli	s2,s2,0x20
 29e:	090e                	slli	s2,s2,0x3
 2a0:	05c1                	addi	a1,a1,16
 2a2:	992e                	add	s2,s2,a1
    ls(".");
    exit(0,0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 2a4:	6088                	ld	a0,0(s1)
 2a6:	00000097          	auipc	ra,0x0
 2aa:	e0e080e7          	jalr	-498(ra) # b4 <ls>
  for(i=1; i<argc; i++)
 2ae:	04a1                	addi	s1,s1,8
 2b0:	ff249ae3          	bne	s1,s2,2a4 <main+0x26>
  exit(0,0);
 2b4:	4581                	li	a1,0
 2b6:	4501                	li	a0,0
 2b8:	00000097          	auipc	ra,0x0
 2bc:	2ae080e7          	jalr	686(ra) # 566 <exit>
    ls(".");
 2c0:	00001517          	auipc	a0,0x1
 2c4:	83850513          	addi	a0,a0,-1992 # af8 <malloc+0x154>
 2c8:	00000097          	auipc	ra,0x0
 2cc:	dec080e7          	jalr	-532(ra) # b4 <ls>
    exit(0,0);
 2d0:	4581                	li	a1,0
 2d2:	4501                	li	a0,0
 2d4:	00000097          	auipc	ra,0x0
 2d8:	292080e7          	jalr	658(ra) # 566 <exit>

00000000000002dc <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 2dc:	1141                	addi	sp,sp,-16
 2de:	e406                	sd	ra,8(sp)
 2e0:	e022                	sd	s0,0(sp)
 2e2:	0800                	addi	s0,sp,16
  extern int main();
  main();
 2e4:	00000097          	auipc	ra,0x0
 2e8:	f9a080e7          	jalr	-102(ra) # 27e <main>
  exit(0,0);
 2ec:	4581                	li	a1,0
 2ee:	4501                	li	a0,0
 2f0:	00000097          	auipc	ra,0x0
 2f4:	276080e7          	jalr	630(ra) # 566 <exit>

00000000000002f8 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 2f8:	1141                	addi	sp,sp,-16
 2fa:	e422                	sd	s0,8(sp)
 2fc:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2fe:	87aa                	mv	a5,a0
 300:	0585                	addi	a1,a1,1
 302:	0785                	addi	a5,a5,1
 304:	fff5c703          	lbu	a4,-1(a1)
 308:	fee78fa3          	sb	a4,-1(a5)
 30c:	fb75                	bnez	a4,300 <strcpy+0x8>
    ;
  return os;
}
 30e:	6422                	ld	s0,8(sp)
 310:	0141                	addi	sp,sp,16
 312:	8082                	ret

0000000000000314 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 314:	1141                	addi	sp,sp,-16
 316:	e422                	sd	s0,8(sp)
 318:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 31a:	00054783          	lbu	a5,0(a0)
 31e:	cb91                	beqz	a5,332 <strcmp+0x1e>
 320:	0005c703          	lbu	a4,0(a1)
 324:	00f71763          	bne	a4,a5,332 <strcmp+0x1e>
    p++, q++;
 328:	0505                	addi	a0,a0,1
 32a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 32c:	00054783          	lbu	a5,0(a0)
 330:	fbe5                	bnez	a5,320 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 332:	0005c503          	lbu	a0,0(a1)
}
 336:	40a7853b          	subw	a0,a5,a0
 33a:	6422                	ld	s0,8(sp)
 33c:	0141                	addi	sp,sp,16
 33e:	8082                	ret

0000000000000340 <strlen>:

uint
strlen(const char *s)
{
 340:	1141                	addi	sp,sp,-16
 342:	e422                	sd	s0,8(sp)
 344:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 346:	00054783          	lbu	a5,0(a0)
 34a:	cf91                	beqz	a5,366 <strlen+0x26>
 34c:	0505                	addi	a0,a0,1
 34e:	87aa                	mv	a5,a0
 350:	4685                	li	a3,1
 352:	9e89                	subw	a3,a3,a0
 354:	00f6853b          	addw	a0,a3,a5
 358:	0785                	addi	a5,a5,1
 35a:	fff7c703          	lbu	a4,-1(a5)
 35e:	fb7d                	bnez	a4,354 <strlen+0x14>
    ;
  return n;
}
 360:	6422                	ld	s0,8(sp)
 362:	0141                	addi	sp,sp,16
 364:	8082                	ret
  for(n = 0; s[n]; n++)
 366:	4501                	li	a0,0
 368:	bfe5                	j	360 <strlen+0x20>

000000000000036a <memset>:

void*
memset(void *dst, int c, uint n)
{
 36a:	1141                	addi	sp,sp,-16
 36c:	e422                	sd	s0,8(sp)
 36e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 370:	ca19                	beqz	a2,386 <memset+0x1c>
 372:	87aa                	mv	a5,a0
 374:	1602                	slli	a2,a2,0x20
 376:	9201                	srli	a2,a2,0x20
 378:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 37c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 380:	0785                	addi	a5,a5,1
 382:	fee79de3          	bne	a5,a4,37c <memset+0x12>
  }
  return dst;
}
 386:	6422                	ld	s0,8(sp)
 388:	0141                	addi	sp,sp,16
 38a:	8082                	ret

000000000000038c <strchr>:

char*
strchr(const char *s, char c)
{
 38c:	1141                	addi	sp,sp,-16
 38e:	e422                	sd	s0,8(sp)
 390:	0800                	addi	s0,sp,16
  for(; *s; s++)
 392:	00054783          	lbu	a5,0(a0)
 396:	cb99                	beqz	a5,3ac <strchr+0x20>
    if(*s == c)
 398:	00f58763          	beq	a1,a5,3a6 <strchr+0x1a>
  for(; *s; s++)
 39c:	0505                	addi	a0,a0,1
 39e:	00054783          	lbu	a5,0(a0)
 3a2:	fbfd                	bnez	a5,398 <strchr+0xc>
      return (char*)s;
  return 0;
 3a4:	4501                	li	a0,0
}
 3a6:	6422                	ld	s0,8(sp)
 3a8:	0141                	addi	sp,sp,16
 3aa:	8082                	ret
  return 0;
 3ac:	4501                	li	a0,0
 3ae:	bfe5                	j	3a6 <strchr+0x1a>

00000000000003b0 <gets>:

char*
gets(char *buf, int max)
{
 3b0:	711d                	addi	sp,sp,-96
 3b2:	ec86                	sd	ra,88(sp)
 3b4:	e8a2                	sd	s0,80(sp)
 3b6:	e4a6                	sd	s1,72(sp)
 3b8:	e0ca                	sd	s2,64(sp)
 3ba:	fc4e                	sd	s3,56(sp)
 3bc:	f852                	sd	s4,48(sp)
 3be:	f456                	sd	s5,40(sp)
 3c0:	f05a                	sd	s6,32(sp)
 3c2:	ec5e                	sd	s7,24(sp)
 3c4:	1080                	addi	s0,sp,96
 3c6:	8baa                	mv	s7,a0
 3c8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3ca:	892a                	mv	s2,a0
 3cc:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3ce:	4aa9                	li	s5,10
 3d0:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3d2:	89a6                	mv	s3,s1
 3d4:	2485                	addiw	s1,s1,1
 3d6:	0344d863          	bge	s1,s4,406 <gets+0x56>
    cc = read(0, &c, 1);
 3da:	4605                	li	a2,1
 3dc:	faf40593          	addi	a1,s0,-81
 3e0:	4501                	li	a0,0
 3e2:	00000097          	auipc	ra,0x0
 3e6:	19c080e7          	jalr	412(ra) # 57e <read>
    if(cc < 1)
 3ea:	00a05e63          	blez	a0,406 <gets+0x56>
    buf[i++] = c;
 3ee:	faf44783          	lbu	a5,-81(s0)
 3f2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3f6:	01578763          	beq	a5,s5,404 <gets+0x54>
 3fa:	0905                	addi	s2,s2,1
 3fc:	fd679be3          	bne	a5,s6,3d2 <gets+0x22>
  for(i=0; i+1 < max; ){
 400:	89a6                	mv	s3,s1
 402:	a011                	j	406 <gets+0x56>
 404:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 406:	99de                	add	s3,s3,s7
 408:	00098023          	sb	zero,0(s3)
  return buf;
}
 40c:	855e                	mv	a0,s7
 40e:	60e6                	ld	ra,88(sp)
 410:	6446                	ld	s0,80(sp)
 412:	64a6                	ld	s1,72(sp)
 414:	6906                	ld	s2,64(sp)
 416:	79e2                	ld	s3,56(sp)
 418:	7a42                	ld	s4,48(sp)
 41a:	7aa2                	ld	s5,40(sp)
 41c:	7b02                	ld	s6,32(sp)
 41e:	6be2                	ld	s7,24(sp)
 420:	6125                	addi	sp,sp,96
 422:	8082                	ret

0000000000000424 <stat>:

int
stat(const char *n, struct stat *st)
{
 424:	1101                	addi	sp,sp,-32
 426:	ec06                	sd	ra,24(sp)
 428:	e822                	sd	s0,16(sp)
 42a:	e426                	sd	s1,8(sp)
 42c:	e04a                	sd	s2,0(sp)
 42e:	1000                	addi	s0,sp,32
 430:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 432:	4581                	li	a1,0
 434:	00000097          	auipc	ra,0x0
 438:	172080e7          	jalr	370(ra) # 5a6 <open>
  if(fd < 0)
 43c:	02054563          	bltz	a0,466 <stat+0x42>
 440:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 442:	85ca                	mv	a1,s2
 444:	00000097          	auipc	ra,0x0
 448:	17a080e7          	jalr	378(ra) # 5be <fstat>
 44c:	892a                	mv	s2,a0
  close(fd);
 44e:	8526                	mv	a0,s1
 450:	00000097          	auipc	ra,0x0
 454:	13e080e7          	jalr	318(ra) # 58e <close>
  return r;
}
 458:	854a                	mv	a0,s2
 45a:	60e2                	ld	ra,24(sp)
 45c:	6442                	ld	s0,16(sp)
 45e:	64a2                	ld	s1,8(sp)
 460:	6902                	ld	s2,0(sp)
 462:	6105                	addi	sp,sp,32
 464:	8082                	ret
    return -1;
 466:	597d                	li	s2,-1
 468:	bfc5                	j	458 <stat+0x34>

000000000000046a <atoi>:

int
atoi(const char *s)
{
 46a:	1141                	addi	sp,sp,-16
 46c:	e422                	sd	s0,8(sp)
 46e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 470:	00054603          	lbu	a2,0(a0)
 474:	fd06079b          	addiw	a5,a2,-48
 478:	0ff7f793          	andi	a5,a5,255
 47c:	4725                	li	a4,9
 47e:	02f76963          	bltu	a4,a5,4b0 <atoi+0x46>
 482:	86aa                	mv	a3,a0
  n = 0;
 484:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 486:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 488:	0685                	addi	a3,a3,1
 48a:	0025179b          	slliw	a5,a0,0x2
 48e:	9fa9                	addw	a5,a5,a0
 490:	0017979b          	slliw	a5,a5,0x1
 494:	9fb1                	addw	a5,a5,a2
 496:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 49a:	0006c603          	lbu	a2,0(a3)
 49e:	fd06071b          	addiw	a4,a2,-48
 4a2:	0ff77713          	andi	a4,a4,255
 4a6:	fee5f1e3          	bgeu	a1,a4,488 <atoi+0x1e>
  return n;
}
 4aa:	6422                	ld	s0,8(sp)
 4ac:	0141                	addi	sp,sp,16
 4ae:	8082                	ret
  n = 0;
 4b0:	4501                	li	a0,0
 4b2:	bfe5                	j	4aa <atoi+0x40>

00000000000004b4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4b4:	1141                	addi	sp,sp,-16
 4b6:	e422                	sd	s0,8(sp)
 4b8:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4ba:	02b57463          	bgeu	a0,a1,4e2 <memmove+0x2e>
    while(n-- > 0)
 4be:	00c05f63          	blez	a2,4dc <memmove+0x28>
 4c2:	1602                	slli	a2,a2,0x20
 4c4:	9201                	srli	a2,a2,0x20
 4c6:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4ca:	872a                	mv	a4,a0
      *dst++ = *src++;
 4cc:	0585                	addi	a1,a1,1
 4ce:	0705                	addi	a4,a4,1
 4d0:	fff5c683          	lbu	a3,-1(a1)
 4d4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4d8:	fee79ae3          	bne	a5,a4,4cc <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4dc:	6422                	ld	s0,8(sp)
 4de:	0141                	addi	sp,sp,16
 4e0:	8082                	ret
    dst += n;
 4e2:	00c50733          	add	a4,a0,a2
    src += n;
 4e6:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4e8:	fec05ae3          	blez	a2,4dc <memmove+0x28>
 4ec:	fff6079b          	addiw	a5,a2,-1
 4f0:	1782                	slli	a5,a5,0x20
 4f2:	9381                	srli	a5,a5,0x20
 4f4:	fff7c793          	not	a5,a5
 4f8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4fa:	15fd                	addi	a1,a1,-1
 4fc:	177d                	addi	a4,a4,-1
 4fe:	0005c683          	lbu	a3,0(a1)
 502:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 506:	fee79ae3          	bne	a5,a4,4fa <memmove+0x46>
 50a:	bfc9                	j	4dc <memmove+0x28>

000000000000050c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 50c:	1141                	addi	sp,sp,-16
 50e:	e422                	sd	s0,8(sp)
 510:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 512:	ca05                	beqz	a2,542 <memcmp+0x36>
 514:	fff6069b          	addiw	a3,a2,-1
 518:	1682                	slli	a3,a3,0x20
 51a:	9281                	srli	a3,a3,0x20
 51c:	0685                	addi	a3,a3,1
 51e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 520:	00054783          	lbu	a5,0(a0)
 524:	0005c703          	lbu	a4,0(a1)
 528:	00e79863          	bne	a5,a4,538 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 52c:	0505                	addi	a0,a0,1
    p2++;
 52e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 530:	fed518e3          	bne	a0,a3,520 <memcmp+0x14>
  }
  return 0;
 534:	4501                	li	a0,0
 536:	a019                	j	53c <memcmp+0x30>
      return *p1 - *p2;
 538:	40e7853b          	subw	a0,a5,a4
}
 53c:	6422                	ld	s0,8(sp)
 53e:	0141                	addi	sp,sp,16
 540:	8082                	ret
  return 0;
 542:	4501                	li	a0,0
 544:	bfe5                	j	53c <memcmp+0x30>

0000000000000546 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 546:	1141                	addi	sp,sp,-16
 548:	e406                	sd	ra,8(sp)
 54a:	e022                	sd	s0,0(sp)
 54c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 54e:	00000097          	auipc	ra,0x0
 552:	f66080e7          	jalr	-154(ra) # 4b4 <memmove>
}
 556:	60a2                	ld	ra,8(sp)
 558:	6402                	ld	s0,0(sp)
 55a:	0141                	addi	sp,sp,16
 55c:	8082                	ret

000000000000055e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 55e:	4885                	li	a7,1
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <exit>:
.global exit
exit:
 li a7, SYS_exit
 566:	4889                	li	a7,2
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <wait>:
.global wait
wait:
 li a7, SYS_wait
 56e:	488d                	li	a7,3
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 576:	4891                	li	a7,4
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <read>:
.global read
read:
 li a7, SYS_read
 57e:	4895                	li	a7,5
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <write>:
.global write
write:
 li a7, SYS_write
 586:	48c1                	li	a7,16
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <close>:
.global close
close:
 li a7, SYS_close
 58e:	48d5                	li	a7,21
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <kill>:
.global kill
kill:
 li a7, SYS_kill
 596:	4899                	li	a7,6
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <exec>:
.global exec
exec:
 li a7, SYS_exec
 59e:	489d                	li	a7,7
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <open>:
.global open
open:
 li a7, SYS_open
 5a6:	48bd                	li	a7,15
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5ae:	48c5                	li	a7,17
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5b6:	48c9                	li	a7,18
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5be:	48a1                	li	a7,8
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <link>:
.global link
link:
 li a7, SYS_link
 5c6:	48cd                	li	a7,19
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5ce:	48d1                	li	a7,20
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5d6:	48a5                	li	a7,9
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <dup>:
.global dup
dup:
 li a7, SYS_dup
 5de:	48a9                	li	a7,10
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5e6:	48ad                	li	a7,11
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5ee:	48b1                	li	a7,12
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5f6:	48b5                	li	a7,13
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5fe:	48b9                	li	a7,14
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <memsize>:
.global memsize
memsize:
 li a7, SYS_memsize
 606:	48d9                	li	a7,22
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 60e:	1101                	addi	sp,sp,-32
 610:	ec06                	sd	ra,24(sp)
 612:	e822                	sd	s0,16(sp)
 614:	1000                	addi	s0,sp,32
 616:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 61a:	4605                	li	a2,1
 61c:	fef40593          	addi	a1,s0,-17
 620:	00000097          	auipc	ra,0x0
 624:	f66080e7          	jalr	-154(ra) # 586 <write>
}
 628:	60e2                	ld	ra,24(sp)
 62a:	6442                	ld	s0,16(sp)
 62c:	6105                	addi	sp,sp,32
 62e:	8082                	ret

0000000000000630 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 630:	7139                	addi	sp,sp,-64
 632:	fc06                	sd	ra,56(sp)
 634:	f822                	sd	s0,48(sp)
 636:	f426                	sd	s1,40(sp)
 638:	f04a                	sd	s2,32(sp)
 63a:	ec4e                	sd	s3,24(sp)
 63c:	0080                	addi	s0,sp,64
 63e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 640:	c299                	beqz	a3,646 <printint+0x16>
 642:	0805c863          	bltz	a1,6d2 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 646:	2581                	sext.w	a1,a1
  neg = 0;
 648:	4881                	li	a7,0
 64a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 64e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 650:	2601                	sext.w	a2,a2
 652:	00000517          	auipc	a0,0x0
 656:	4b650513          	addi	a0,a0,1206 # b08 <digits>
 65a:	883a                	mv	a6,a4
 65c:	2705                	addiw	a4,a4,1
 65e:	02c5f7bb          	remuw	a5,a1,a2
 662:	1782                	slli	a5,a5,0x20
 664:	9381                	srli	a5,a5,0x20
 666:	97aa                	add	a5,a5,a0
 668:	0007c783          	lbu	a5,0(a5)
 66c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 670:	0005879b          	sext.w	a5,a1
 674:	02c5d5bb          	divuw	a1,a1,a2
 678:	0685                	addi	a3,a3,1
 67a:	fec7f0e3          	bgeu	a5,a2,65a <printint+0x2a>
  if(neg)
 67e:	00088b63          	beqz	a7,694 <printint+0x64>
    buf[i++] = '-';
 682:	fd040793          	addi	a5,s0,-48
 686:	973e                	add	a4,a4,a5
 688:	02d00793          	li	a5,45
 68c:	fef70823          	sb	a5,-16(a4)
 690:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 694:	02e05863          	blez	a4,6c4 <printint+0x94>
 698:	fc040793          	addi	a5,s0,-64
 69c:	00e78933          	add	s2,a5,a4
 6a0:	fff78993          	addi	s3,a5,-1
 6a4:	99ba                	add	s3,s3,a4
 6a6:	377d                	addiw	a4,a4,-1
 6a8:	1702                	slli	a4,a4,0x20
 6aa:	9301                	srli	a4,a4,0x20
 6ac:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6b0:	fff94583          	lbu	a1,-1(s2)
 6b4:	8526                	mv	a0,s1
 6b6:	00000097          	auipc	ra,0x0
 6ba:	f58080e7          	jalr	-168(ra) # 60e <putc>
  while(--i >= 0)
 6be:	197d                	addi	s2,s2,-1
 6c0:	ff3918e3          	bne	s2,s3,6b0 <printint+0x80>
}
 6c4:	70e2                	ld	ra,56(sp)
 6c6:	7442                	ld	s0,48(sp)
 6c8:	74a2                	ld	s1,40(sp)
 6ca:	7902                	ld	s2,32(sp)
 6cc:	69e2                	ld	s3,24(sp)
 6ce:	6121                	addi	sp,sp,64
 6d0:	8082                	ret
    x = -xx;
 6d2:	40b005bb          	negw	a1,a1
    neg = 1;
 6d6:	4885                	li	a7,1
    x = -xx;
 6d8:	bf8d                	j	64a <printint+0x1a>

00000000000006da <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6da:	7119                	addi	sp,sp,-128
 6dc:	fc86                	sd	ra,120(sp)
 6de:	f8a2                	sd	s0,112(sp)
 6e0:	f4a6                	sd	s1,104(sp)
 6e2:	f0ca                	sd	s2,96(sp)
 6e4:	ecce                	sd	s3,88(sp)
 6e6:	e8d2                	sd	s4,80(sp)
 6e8:	e4d6                	sd	s5,72(sp)
 6ea:	e0da                	sd	s6,64(sp)
 6ec:	fc5e                	sd	s7,56(sp)
 6ee:	f862                	sd	s8,48(sp)
 6f0:	f466                	sd	s9,40(sp)
 6f2:	f06a                	sd	s10,32(sp)
 6f4:	ec6e                	sd	s11,24(sp)
 6f6:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6f8:	0005c903          	lbu	s2,0(a1)
 6fc:	18090f63          	beqz	s2,89a <vprintf+0x1c0>
 700:	8aaa                	mv	s5,a0
 702:	8b32                	mv	s6,a2
 704:	00158493          	addi	s1,a1,1
  state = 0;
 708:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 70a:	02500a13          	li	s4,37
      if(c == 'd'){
 70e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 712:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 716:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 71a:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 71e:	00000b97          	auipc	s7,0x0
 722:	3eab8b93          	addi	s7,s7,1002 # b08 <digits>
 726:	a839                	j	744 <vprintf+0x6a>
        putc(fd, c);
 728:	85ca                	mv	a1,s2
 72a:	8556                	mv	a0,s5
 72c:	00000097          	auipc	ra,0x0
 730:	ee2080e7          	jalr	-286(ra) # 60e <putc>
 734:	a019                	j	73a <vprintf+0x60>
    } else if(state == '%'){
 736:	01498f63          	beq	s3,s4,754 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 73a:	0485                	addi	s1,s1,1
 73c:	fff4c903          	lbu	s2,-1(s1)
 740:	14090d63          	beqz	s2,89a <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 744:	0009079b          	sext.w	a5,s2
    if(state == 0){
 748:	fe0997e3          	bnez	s3,736 <vprintf+0x5c>
      if(c == '%'){
 74c:	fd479ee3          	bne	a5,s4,728 <vprintf+0x4e>
        state = '%';
 750:	89be                	mv	s3,a5
 752:	b7e5                	j	73a <vprintf+0x60>
      if(c == 'd'){
 754:	05878063          	beq	a5,s8,794 <vprintf+0xba>
      } else if(c == 'l') {
 758:	05978c63          	beq	a5,s9,7b0 <vprintf+0xd6>
      } else if(c == 'x') {
 75c:	07a78863          	beq	a5,s10,7cc <vprintf+0xf2>
      } else if(c == 'p') {
 760:	09b78463          	beq	a5,s11,7e8 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 764:	07300713          	li	a4,115
 768:	0ce78663          	beq	a5,a4,834 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 76c:	06300713          	li	a4,99
 770:	0ee78e63          	beq	a5,a4,86c <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 774:	11478863          	beq	a5,s4,884 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 778:	85d2                	mv	a1,s4
 77a:	8556                	mv	a0,s5
 77c:	00000097          	auipc	ra,0x0
 780:	e92080e7          	jalr	-366(ra) # 60e <putc>
        putc(fd, c);
 784:	85ca                	mv	a1,s2
 786:	8556                	mv	a0,s5
 788:	00000097          	auipc	ra,0x0
 78c:	e86080e7          	jalr	-378(ra) # 60e <putc>
      }
      state = 0;
 790:	4981                	li	s3,0
 792:	b765                	j	73a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 794:	008b0913          	addi	s2,s6,8
 798:	4685                	li	a3,1
 79a:	4629                	li	a2,10
 79c:	000b2583          	lw	a1,0(s6)
 7a0:	8556                	mv	a0,s5
 7a2:	00000097          	auipc	ra,0x0
 7a6:	e8e080e7          	jalr	-370(ra) # 630 <printint>
 7aa:	8b4a                	mv	s6,s2
      state = 0;
 7ac:	4981                	li	s3,0
 7ae:	b771                	j	73a <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7b0:	008b0913          	addi	s2,s6,8
 7b4:	4681                	li	a3,0
 7b6:	4629                	li	a2,10
 7b8:	000b2583          	lw	a1,0(s6)
 7bc:	8556                	mv	a0,s5
 7be:	00000097          	auipc	ra,0x0
 7c2:	e72080e7          	jalr	-398(ra) # 630 <printint>
 7c6:	8b4a                	mv	s6,s2
      state = 0;
 7c8:	4981                	li	s3,0
 7ca:	bf85                	j	73a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 7cc:	008b0913          	addi	s2,s6,8
 7d0:	4681                	li	a3,0
 7d2:	4641                	li	a2,16
 7d4:	000b2583          	lw	a1,0(s6)
 7d8:	8556                	mv	a0,s5
 7da:	00000097          	auipc	ra,0x0
 7de:	e56080e7          	jalr	-426(ra) # 630 <printint>
 7e2:	8b4a                	mv	s6,s2
      state = 0;
 7e4:	4981                	li	s3,0
 7e6:	bf91                	j	73a <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 7e8:	008b0793          	addi	a5,s6,8
 7ec:	f8f43423          	sd	a5,-120(s0)
 7f0:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7f4:	03000593          	li	a1,48
 7f8:	8556                	mv	a0,s5
 7fa:	00000097          	auipc	ra,0x0
 7fe:	e14080e7          	jalr	-492(ra) # 60e <putc>
  putc(fd, 'x');
 802:	85ea                	mv	a1,s10
 804:	8556                	mv	a0,s5
 806:	00000097          	auipc	ra,0x0
 80a:	e08080e7          	jalr	-504(ra) # 60e <putc>
 80e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 810:	03c9d793          	srli	a5,s3,0x3c
 814:	97de                	add	a5,a5,s7
 816:	0007c583          	lbu	a1,0(a5)
 81a:	8556                	mv	a0,s5
 81c:	00000097          	auipc	ra,0x0
 820:	df2080e7          	jalr	-526(ra) # 60e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 824:	0992                	slli	s3,s3,0x4
 826:	397d                	addiw	s2,s2,-1
 828:	fe0914e3          	bnez	s2,810 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 82c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 830:	4981                	li	s3,0
 832:	b721                	j	73a <vprintf+0x60>
        s = va_arg(ap, char*);
 834:	008b0993          	addi	s3,s6,8
 838:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 83c:	02090163          	beqz	s2,85e <vprintf+0x184>
        while(*s != 0){
 840:	00094583          	lbu	a1,0(s2)
 844:	c9a1                	beqz	a1,894 <vprintf+0x1ba>
          putc(fd, *s);
 846:	8556                	mv	a0,s5
 848:	00000097          	auipc	ra,0x0
 84c:	dc6080e7          	jalr	-570(ra) # 60e <putc>
          s++;
 850:	0905                	addi	s2,s2,1
        while(*s != 0){
 852:	00094583          	lbu	a1,0(s2)
 856:	f9e5                	bnez	a1,846 <vprintf+0x16c>
        s = va_arg(ap, char*);
 858:	8b4e                	mv	s6,s3
      state = 0;
 85a:	4981                	li	s3,0
 85c:	bdf9                	j	73a <vprintf+0x60>
          s = "(null)";
 85e:	00000917          	auipc	s2,0x0
 862:	2a290913          	addi	s2,s2,674 # b00 <malloc+0x15c>
        while(*s != 0){
 866:	02800593          	li	a1,40
 86a:	bff1                	j	846 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 86c:	008b0913          	addi	s2,s6,8
 870:	000b4583          	lbu	a1,0(s6)
 874:	8556                	mv	a0,s5
 876:	00000097          	auipc	ra,0x0
 87a:	d98080e7          	jalr	-616(ra) # 60e <putc>
 87e:	8b4a                	mv	s6,s2
      state = 0;
 880:	4981                	li	s3,0
 882:	bd65                	j	73a <vprintf+0x60>
        putc(fd, c);
 884:	85d2                	mv	a1,s4
 886:	8556                	mv	a0,s5
 888:	00000097          	auipc	ra,0x0
 88c:	d86080e7          	jalr	-634(ra) # 60e <putc>
      state = 0;
 890:	4981                	li	s3,0
 892:	b565                	j	73a <vprintf+0x60>
        s = va_arg(ap, char*);
 894:	8b4e                	mv	s6,s3
      state = 0;
 896:	4981                	li	s3,0
 898:	b54d                	j	73a <vprintf+0x60>
    }
  }
}
 89a:	70e6                	ld	ra,120(sp)
 89c:	7446                	ld	s0,112(sp)
 89e:	74a6                	ld	s1,104(sp)
 8a0:	7906                	ld	s2,96(sp)
 8a2:	69e6                	ld	s3,88(sp)
 8a4:	6a46                	ld	s4,80(sp)
 8a6:	6aa6                	ld	s5,72(sp)
 8a8:	6b06                	ld	s6,64(sp)
 8aa:	7be2                	ld	s7,56(sp)
 8ac:	7c42                	ld	s8,48(sp)
 8ae:	7ca2                	ld	s9,40(sp)
 8b0:	7d02                	ld	s10,32(sp)
 8b2:	6de2                	ld	s11,24(sp)
 8b4:	6109                	addi	sp,sp,128
 8b6:	8082                	ret

00000000000008b8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8b8:	715d                	addi	sp,sp,-80
 8ba:	ec06                	sd	ra,24(sp)
 8bc:	e822                	sd	s0,16(sp)
 8be:	1000                	addi	s0,sp,32
 8c0:	e010                	sd	a2,0(s0)
 8c2:	e414                	sd	a3,8(s0)
 8c4:	e818                	sd	a4,16(s0)
 8c6:	ec1c                	sd	a5,24(s0)
 8c8:	03043023          	sd	a6,32(s0)
 8cc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8d0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8d4:	8622                	mv	a2,s0
 8d6:	00000097          	auipc	ra,0x0
 8da:	e04080e7          	jalr	-508(ra) # 6da <vprintf>
}
 8de:	60e2                	ld	ra,24(sp)
 8e0:	6442                	ld	s0,16(sp)
 8e2:	6161                	addi	sp,sp,80
 8e4:	8082                	ret

00000000000008e6 <printf>:

void
printf(const char *fmt, ...)
{
 8e6:	711d                	addi	sp,sp,-96
 8e8:	ec06                	sd	ra,24(sp)
 8ea:	e822                	sd	s0,16(sp)
 8ec:	1000                	addi	s0,sp,32
 8ee:	e40c                	sd	a1,8(s0)
 8f0:	e810                	sd	a2,16(s0)
 8f2:	ec14                	sd	a3,24(s0)
 8f4:	f018                	sd	a4,32(s0)
 8f6:	f41c                	sd	a5,40(s0)
 8f8:	03043823          	sd	a6,48(s0)
 8fc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 900:	00840613          	addi	a2,s0,8
 904:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 908:	85aa                	mv	a1,a0
 90a:	4505                	li	a0,1
 90c:	00000097          	auipc	ra,0x0
 910:	dce080e7          	jalr	-562(ra) # 6da <vprintf>
}
 914:	60e2                	ld	ra,24(sp)
 916:	6442                	ld	s0,16(sp)
 918:	6125                	addi	sp,sp,96
 91a:	8082                	ret

000000000000091c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 91c:	1141                	addi	sp,sp,-16
 91e:	e422                	sd	s0,8(sp)
 920:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 922:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 926:	00000797          	auipc	a5,0x0
 92a:	6da7b783          	ld	a5,1754(a5) # 1000 <freep>
 92e:	a805                	j	95e <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 930:	4618                	lw	a4,8(a2)
 932:	9db9                	addw	a1,a1,a4
 934:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 938:	6398                	ld	a4,0(a5)
 93a:	6318                	ld	a4,0(a4)
 93c:	fee53823          	sd	a4,-16(a0)
 940:	a091                	j	984 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 942:	ff852703          	lw	a4,-8(a0)
 946:	9e39                	addw	a2,a2,a4
 948:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 94a:	ff053703          	ld	a4,-16(a0)
 94e:	e398                	sd	a4,0(a5)
 950:	a099                	j	996 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 952:	6398                	ld	a4,0(a5)
 954:	00e7e463          	bltu	a5,a4,95c <free+0x40>
 958:	00e6ea63          	bltu	a3,a4,96c <free+0x50>
{
 95c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 95e:	fed7fae3          	bgeu	a5,a3,952 <free+0x36>
 962:	6398                	ld	a4,0(a5)
 964:	00e6e463          	bltu	a3,a4,96c <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 968:	fee7eae3          	bltu	a5,a4,95c <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 96c:	ff852583          	lw	a1,-8(a0)
 970:	6390                	ld	a2,0(a5)
 972:	02059713          	slli	a4,a1,0x20
 976:	9301                	srli	a4,a4,0x20
 978:	0712                	slli	a4,a4,0x4
 97a:	9736                	add	a4,a4,a3
 97c:	fae60ae3          	beq	a2,a4,930 <free+0x14>
    bp->s.ptr = p->s.ptr;
 980:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 984:	4790                	lw	a2,8(a5)
 986:	02061713          	slli	a4,a2,0x20
 98a:	9301                	srli	a4,a4,0x20
 98c:	0712                	slli	a4,a4,0x4
 98e:	973e                	add	a4,a4,a5
 990:	fae689e3          	beq	a3,a4,942 <free+0x26>
  } else
    p->s.ptr = bp;
 994:	e394                	sd	a3,0(a5)
  freep = p;
 996:	00000717          	auipc	a4,0x0
 99a:	66f73523          	sd	a5,1642(a4) # 1000 <freep>
}
 99e:	6422                	ld	s0,8(sp)
 9a0:	0141                	addi	sp,sp,16
 9a2:	8082                	ret

00000000000009a4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9a4:	7139                	addi	sp,sp,-64
 9a6:	fc06                	sd	ra,56(sp)
 9a8:	f822                	sd	s0,48(sp)
 9aa:	f426                	sd	s1,40(sp)
 9ac:	f04a                	sd	s2,32(sp)
 9ae:	ec4e                	sd	s3,24(sp)
 9b0:	e852                	sd	s4,16(sp)
 9b2:	e456                	sd	s5,8(sp)
 9b4:	e05a                	sd	s6,0(sp)
 9b6:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9b8:	02051493          	slli	s1,a0,0x20
 9bc:	9081                	srli	s1,s1,0x20
 9be:	04bd                	addi	s1,s1,15
 9c0:	8091                	srli	s1,s1,0x4
 9c2:	0014899b          	addiw	s3,s1,1
 9c6:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9c8:	00000517          	auipc	a0,0x0
 9cc:	63853503          	ld	a0,1592(a0) # 1000 <freep>
 9d0:	c515                	beqz	a0,9fc <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9d4:	4798                	lw	a4,8(a5)
 9d6:	02977f63          	bgeu	a4,s1,a14 <malloc+0x70>
 9da:	8a4e                	mv	s4,s3
 9dc:	0009871b          	sext.w	a4,s3
 9e0:	6685                	lui	a3,0x1
 9e2:	00d77363          	bgeu	a4,a3,9e8 <malloc+0x44>
 9e6:	6a05                	lui	s4,0x1
 9e8:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9ec:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9f0:	00000917          	auipc	s2,0x0
 9f4:	61090913          	addi	s2,s2,1552 # 1000 <freep>
  if(p == (char*)-1)
 9f8:	5afd                	li	s5,-1
 9fa:	a88d                	j	a6c <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 9fc:	00000797          	auipc	a5,0x0
 a00:	62478793          	addi	a5,a5,1572 # 1020 <base>
 a04:	00000717          	auipc	a4,0x0
 a08:	5ef73e23          	sd	a5,1532(a4) # 1000 <freep>
 a0c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a0e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a12:	b7e1                	j	9da <malloc+0x36>
      if(p->s.size == nunits)
 a14:	02e48b63          	beq	s1,a4,a4a <malloc+0xa6>
        p->s.size -= nunits;
 a18:	4137073b          	subw	a4,a4,s3
 a1c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a1e:	1702                	slli	a4,a4,0x20
 a20:	9301                	srli	a4,a4,0x20
 a22:	0712                	slli	a4,a4,0x4
 a24:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a26:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a2a:	00000717          	auipc	a4,0x0
 a2e:	5ca73b23          	sd	a0,1494(a4) # 1000 <freep>
      return (void*)(p + 1);
 a32:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a36:	70e2                	ld	ra,56(sp)
 a38:	7442                	ld	s0,48(sp)
 a3a:	74a2                	ld	s1,40(sp)
 a3c:	7902                	ld	s2,32(sp)
 a3e:	69e2                	ld	s3,24(sp)
 a40:	6a42                	ld	s4,16(sp)
 a42:	6aa2                	ld	s5,8(sp)
 a44:	6b02                	ld	s6,0(sp)
 a46:	6121                	addi	sp,sp,64
 a48:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a4a:	6398                	ld	a4,0(a5)
 a4c:	e118                	sd	a4,0(a0)
 a4e:	bff1                	j	a2a <malloc+0x86>
  hp->s.size = nu;
 a50:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a54:	0541                	addi	a0,a0,16
 a56:	00000097          	auipc	ra,0x0
 a5a:	ec6080e7          	jalr	-314(ra) # 91c <free>
  return freep;
 a5e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a62:	d971                	beqz	a0,a36 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a64:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a66:	4798                	lw	a4,8(a5)
 a68:	fa9776e3          	bgeu	a4,s1,a14 <malloc+0x70>
    if(p == freep)
 a6c:	00093703          	ld	a4,0(s2)
 a70:	853e                	mv	a0,a5
 a72:	fef719e3          	bne	a4,a5,a64 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 a76:	8552                	mv	a0,s4
 a78:	00000097          	auipc	ra,0x0
 a7c:	b76080e7          	jalr	-1162(ra) # 5ee <sbrk>
  if(p == (char*)-1)
 a80:	fd5518e3          	bne	a0,s5,a50 <malloc+0xac>
        return 0;
 a84:	4501                	li	a0,0
 a86:	bf45                	j	a36 <malloc+0x92>
