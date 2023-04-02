
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
 12c:	9a850513          	addi	a0,a0,-1624 # ad0 <malloc+0x11c>
 130:	00000097          	auipc	ra,0x0
 134:	7c6080e7          	jalr	1990(ra) # 8f6 <printf>
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
 16a:	93a58593          	addi	a1,a1,-1734 # aa0 <malloc+0xec>
 16e:	4509                	li	a0,2
 170:	00000097          	auipc	ra,0x0
 174:	758080e7          	jalr	1880(ra) # 8c8 <fprintf>
    return;
 178:	b7e9                	j	142 <ls+0x8e>
    fprintf(2, "ls: cannot stat %s\n", path);
 17a:	864a                	mv	a2,s2
 17c:	00001597          	auipc	a1,0x1
 180:	93c58593          	addi	a1,a1,-1732 # ab8 <malloc+0x104>
 184:	4509                	li	a0,2
 186:	00000097          	auipc	ra,0x0
 18a:	742080e7          	jalr	1858(ra) # 8c8 <fprintf>
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
 1b2:	93250513          	addi	a0,a0,-1742 # ae0 <malloc+0x12c>
 1b6:	00000097          	auipc	ra,0x0
 1ba:	740080e7          	jalr	1856(ra) # 8f6 <printf>
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
 1f8:	904a0a13          	addi	s4,s4,-1788 # af8 <malloc+0x144>
        printf("ls: cannot stat %s\n", buf);
 1fc:	00001a97          	auipc	s5,0x1
 200:	8bca8a93          	addi	s5,s5,-1860 # ab8 <malloc+0x104>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 204:	a801                	j	214 <ls+0x160>
        printf("ls: cannot stat %s\n", buf);
 206:	dc040593          	addi	a1,s0,-576
 20a:	8556                	mv	a0,s5
 20c:	00000097          	auipc	ra,0x0
 210:	6ea080e7          	jalr	1770(ra) # 8f6 <printf>
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
 278:	682080e7          	jalr	1666(ra) # 8f6 <printf>
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
 2c4:	84850513          	addi	a0,a0,-1976 # b08 <malloc+0x154>
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

000000000000060e <set_ps_priority>:
.global set_ps_priority
set_ps_priority:
 li a7, SYS_set_ps_priority
 60e:	48dd                	li	a7,23
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <set_cfs_priority>:
.global set_cfs_priority
set_cfs_priority:
 li a7, SYS_set_cfs_priority
 616:	48e1                	li	a7,24
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 61e:	1101                	addi	sp,sp,-32
 620:	ec06                	sd	ra,24(sp)
 622:	e822                	sd	s0,16(sp)
 624:	1000                	addi	s0,sp,32
 626:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 62a:	4605                	li	a2,1
 62c:	fef40593          	addi	a1,s0,-17
 630:	00000097          	auipc	ra,0x0
 634:	f56080e7          	jalr	-170(ra) # 586 <write>
}
 638:	60e2                	ld	ra,24(sp)
 63a:	6442                	ld	s0,16(sp)
 63c:	6105                	addi	sp,sp,32
 63e:	8082                	ret

0000000000000640 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 640:	7139                	addi	sp,sp,-64
 642:	fc06                	sd	ra,56(sp)
 644:	f822                	sd	s0,48(sp)
 646:	f426                	sd	s1,40(sp)
 648:	f04a                	sd	s2,32(sp)
 64a:	ec4e                	sd	s3,24(sp)
 64c:	0080                	addi	s0,sp,64
 64e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 650:	c299                	beqz	a3,656 <printint+0x16>
 652:	0805c863          	bltz	a1,6e2 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 656:	2581                	sext.w	a1,a1
  neg = 0;
 658:	4881                	li	a7,0
 65a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 65e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 660:	2601                	sext.w	a2,a2
 662:	00000517          	auipc	a0,0x0
 666:	4b650513          	addi	a0,a0,1206 # b18 <digits>
 66a:	883a                	mv	a6,a4
 66c:	2705                	addiw	a4,a4,1
 66e:	02c5f7bb          	remuw	a5,a1,a2
 672:	1782                	slli	a5,a5,0x20
 674:	9381                	srli	a5,a5,0x20
 676:	97aa                	add	a5,a5,a0
 678:	0007c783          	lbu	a5,0(a5)
 67c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 680:	0005879b          	sext.w	a5,a1
 684:	02c5d5bb          	divuw	a1,a1,a2
 688:	0685                	addi	a3,a3,1
 68a:	fec7f0e3          	bgeu	a5,a2,66a <printint+0x2a>
  if(neg)
 68e:	00088b63          	beqz	a7,6a4 <printint+0x64>
    buf[i++] = '-';
 692:	fd040793          	addi	a5,s0,-48
 696:	973e                	add	a4,a4,a5
 698:	02d00793          	li	a5,45
 69c:	fef70823          	sb	a5,-16(a4)
 6a0:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 6a4:	02e05863          	blez	a4,6d4 <printint+0x94>
 6a8:	fc040793          	addi	a5,s0,-64
 6ac:	00e78933          	add	s2,a5,a4
 6b0:	fff78993          	addi	s3,a5,-1
 6b4:	99ba                	add	s3,s3,a4
 6b6:	377d                	addiw	a4,a4,-1
 6b8:	1702                	slli	a4,a4,0x20
 6ba:	9301                	srli	a4,a4,0x20
 6bc:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6c0:	fff94583          	lbu	a1,-1(s2)
 6c4:	8526                	mv	a0,s1
 6c6:	00000097          	auipc	ra,0x0
 6ca:	f58080e7          	jalr	-168(ra) # 61e <putc>
  while(--i >= 0)
 6ce:	197d                	addi	s2,s2,-1
 6d0:	ff3918e3          	bne	s2,s3,6c0 <printint+0x80>
}
 6d4:	70e2                	ld	ra,56(sp)
 6d6:	7442                	ld	s0,48(sp)
 6d8:	74a2                	ld	s1,40(sp)
 6da:	7902                	ld	s2,32(sp)
 6dc:	69e2                	ld	s3,24(sp)
 6de:	6121                	addi	sp,sp,64
 6e0:	8082                	ret
    x = -xx;
 6e2:	40b005bb          	negw	a1,a1
    neg = 1;
 6e6:	4885                	li	a7,1
    x = -xx;
 6e8:	bf8d                	j	65a <printint+0x1a>

00000000000006ea <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6ea:	7119                	addi	sp,sp,-128
 6ec:	fc86                	sd	ra,120(sp)
 6ee:	f8a2                	sd	s0,112(sp)
 6f0:	f4a6                	sd	s1,104(sp)
 6f2:	f0ca                	sd	s2,96(sp)
 6f4:	ecce                	sd	s3,88(sp)
 6f6:	e8d2                	sd	s4,80(sp)
 6f8:	e4d6                	sd	s5,72(sp)
 6fa:	e0da                	sd	s6,64(sp)
 6fc:	fc5e                	sd	s7,56(sp)
 6fe:	f862                	sd	s8,48(sp)
 700:	f466                	sd	s9,40(sp)
 702:	f06a                	sd	s10,32(sp)
 704:	ec6e                	sd	s11,24(sp)
 706:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 708:	0005c903          	lbu	s2,0(a1)
 70c:	18090f63          	beqz	s2,8aa <vprintf+0x1c0>
 710:	8aaa                	mv	s5,a0
 712:	8b32                	mv	s6,a2
 714:	00158493          	addi	s1,a1,1
  state = 0;
 718:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 71a:	02500a13          	li	s4,37
      if(c == 'd'){
 71e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 722:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 726:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 72a:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 72e:	00000b97          	auipc	s7,0x0
 732:	3eab8b93          	addi	s7,s7,1002 # b18 <digits>
 736:	a839                	j	754 <vprintf+0x6a>
        putc(fd, c);
 738:	85ca                	mv	a1,s2
 73a:	8556                	mv	a0,s5
 73c:	00000097          	auipc	ra,0x0
 740:	ee2080e7          	jalr	-286(ra) # 61e <putc>
 744:	a019                	j	74a <vprintf+0x60>
    } else if(state == '%'){
 746:	01498f63          	beq	s3,s4,764 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 74a:	0485                	addi	s1,s1,1
 74c:	fff4c903          	lbu	s2,-1(s1)
 750:	14090d63          	beqz	s2,8aa <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 754:	0009079b          	sext.w	a5,s2
    if(state == 0){
 758:	fe0997e3          	bnez	s3,746 <vprintf+0x5c>
      if(c == '%'){
 75c:	fd479ee3          	bne	a5,s4,738 <vprintf+0x4e>
        state = '%';
 760:	89be                	mv	s3,a5
 762:	b7e5                	j	74a <vprintf+0x60>
      if(c == 'd'){
 764:	05878063          	beq	a5,s8,7a4 <vprintf+0xba>
      } else if(c == 'l') {
 768:	05978c63          	beq	a5,s9,7c0 <vprintf+0xd6>
      } else if(c == 'x') {
 76c:	07a78863          	beq	a5,s10,7dc <vprintf+0xf2>
      } else if(c == 'p') {
 770:	09b78463          	beq	a5,s11,7f8 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 774:	07300713          	li	a4,115
 778:	0ce78663          	beq	a5,a4,844 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 77c:	06300713          	li	a4,99
 780:	0ee78e63          	beq	a5,a4,87c <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 784:	11478863          	beq	a5,s4,894 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 788:	85d2                	mv	a1,s4
 78a:	8556                	mv	a0,s5
 78c:	00000097          	auipc	ra,0x0
 790:	e92080e7          	jalr	-366(ra) # 61e <putc>
        putc(fd, c);
 794:	85ca                	mv	a1,s2
 796:	8556                	mv	a0,s5
 798:	00000097          	auipc	ra,0x0
 79c:	e86080e7          	jalr	-378(ra) # 61e <putc>
      }
      state = 0;
 7a0:	4981                	li	s3,0
 7a2:	b765                	j	74a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 7a4:	008b0913          	addi	s2,s6,8
 7a8:	4685                	li	a3,1
 7aa:	4629                	li	a2,10
 7ac:	000b2583          	lw	a1,0(s6)
 7b0:	8556                	mv	a0,s5
 7b2:	00000097          	auipc	ra,0x0
 7b6:	e8e080e7          	jalr	-370(ra) # 640 <printint>
 7ba:	8b4a                	mv	s6,s2
      state = 0;
 7bc:	4981                	li	s3,0
 7be:	b771                	j	74a <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7c0:	008b0913          	addi	s2,s6,8
 7c4:	4681                	li	a3,0
 7c6:	4629                	li	a2,10
 7c8:	000b2583          	lw	a1,0(s6)
 7cc:	8556                	mv	a0,s5
 7ce:	00000097          	auipc	ra,0x0
 7d2:	e72080e7          	jalr	-398(ra) # 640 <printint>
 7d6:	8b4a                	mv	s6,s2
      state = 0;
 7d8:	4981                	li	s3,0
 7da:	bf85                	j	74a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 7dc:	008b0913          	addi	s2,s6,8
 7e0:	4681                	li	a3,0
 7e2:	4641                	li	a2,16
 7e4:	000b2583          	lw	a1,0(s6)
 7e8:	8556                	mv	a0,s5
 7ea:	00000097          	auipc	ra,0x0
 7ee:	e56080e7          	jalr	-426(ra) # 640 <printint>
 7f2:	8b4a                	mv	s6,s2
      state = 0;
 7f4:	4981                	li	s3,0
 7f6:	bf91                	j	74a <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 7f8:	008b0793          	addi	a5,s6,8
 7fc:	f8f43423          	sd	a5,-120(s0)
 800:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 804:	03000593          	li	a1,48
 808:	8556                	mv	a0,s5
 80a:	00000097          	auipc	ra,0x0
 80e:	e14080e7          	jalr	-492(ra) # 61e <putc>
  putc(fd, 'x');
 812:	85ea                	mv	a1,s10
 814:	8556                	mv	a0,s5
 816:	00000097          	auipc	ra,0x0
 81a:	e08080e7          	jalr	-504(ra) # 61e <putc>
 81e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 820:	03c9d793          	srli	a5,s3,0x3c
 824:	97de                	add	a5,a5,s7
 826:	0007c583          	lbu	a1,0(a5)
 82a:	8556                	mv	a0,s5
 82c:	00000097          	auipc	ra,0x0
 830:	df2080e7          	jalr	-526(ra) # 61e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 834:	0992                	slli	s3,s3,0x4
 836:	397d                	addiw	s2,s2,-1
 838:	fe0914e3          	bnez	s2,820 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 83c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 840:	4981                	li	s3,0
 842:	b721                	j	74a <vprintf+0x60>
        s = va_arg(ap, char*);
 844:	008b0993          	addi	s3,s6,8
 848:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 84c:	02090163          	beqz	s2,86e <vprintf+0x184>
        while(*s != 0){
 850:	00094583          	lbu	a1,0(s2)
 854:	c9a1                	beqz	a1,8a4 <vprintf+0x1ba>
          putc(fd, *s);
 856:	8556                	mv	a0,s5
 858:	00000097          	auipc	ra,0x0
 85c:	dc6080e7          	jalr	-570(ra) # 61e <putc>
          s++;
 860:	0905                	addi	s2,s2,1
        while(*s != 0){
 862:	00094583          	lbu	a1,0(s2)
 866:	f9e5                	bnez	a1,856 <vprintf+0x16c>
        s = va_arg(ap, char*);
 868:	8b4e                	mv	s6,s3
      state = 0;
 86a:	4981                	li	s3,0
 86c:	bdf9                	j	74a <vprintf+0x60>
          s = "(null)";
 86e:	00000917          	auipc	s2,0x0
 872:	2a290913          	addi	s2,s2,674 # b10 <malloc+0x15c>
        while(*s != 0){
 876:	02800593          	li	a1,40
 87a:	bff1                	j	856 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 87c:	008b0913          	addi	s2,s6,8
 880:	000b4583          	lbu	a1,0(s6)
 884:	8556                	mv	a0,s5
 886:	00000097          	auipc	ra,0x0
 88a:	d98080e7          	jalr	-616(ra) # 61e <putc>
 88e:	8b4a                	mv	s6,s2
      state = 0;
 890:	4981                	li	s3,0
 892:	bd65                	j	74a <vprintf+0x60>
        putc(fd, c);
 894:	85d2                	mv	a1,s4
 896:	8556                	mv	a0,s5
 898:	00000097          	auipc	ra,0x0
 89c:	d86080e7          	jalr	-634(ra) # 61e <putc>
      state = 0;
 8a0:	4981                	li	s3,0
 8a2:	b565                	j	74a <vprintf+0x60>
        s = va_arg(ap, char*);
 8a4:	8b4e                	mv	s6,s3
      state = 0;
 8a6:	4981                	li	s3,0
 8a8:	b54d                	j	74a <vprintf+0x60>
    }
  }
}
 8aa:	70e6                	ld	ra,120(sp)
 8ac:	7446                	ld	s0,112(sp)
 8ae:	74a6                	ld	s1,104(sp)
 8b0:	7906                	ld	s2,96(sp)
 8b2:	69e6                	ld	s3,88(sp)
 8b4:	6a46                	ld	s4,80(sp)
 8b6:	6aa6                	ld	s5,72(sp)
 8b8:	6b06                	ld	s6,64(sp)
 8ba:	7be2                	ld	s7,56(sp)
 8bc:	7c42                	ld	s8,48(sp)
 8be:	7ca2                	ld	s9,40(sp)
 8c0:	7d02                	ld	s10,32(sp)
 8c2:	6de2                	ld	s11,24(sp)
 8c4:	6109                	addi	sp,sp,128
 8c6:	8082                	ret

00000000000008c8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8c8:	715d                	addi	sp,sp,-80
 8ca:	ec06                	sd	ra,24(sp)
 8cc:	e822                	sd	s0,16(sp)
 8ce:	1000                	addi	s0,sp,32
 8d0:	e010                	sd	a2,0(s0)
 8d2:	e414                	sd	a3,8(s0)
 8d4:	e818                	sd	a4,16(s0)
 8d6:	ec1c                	sd	a5,24(s0)
 8d8:	03043023          	sd	a6,32(s0)
 8dc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8e0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8e4:	8622                	mv	a2,s0
 8e6:	00000097          	auipc	ra,0x0
 8ea:	e04080e7          	jalr	-508(ra) # 6ea <vprintf>
}
 8ee:	60e2                	ld	ra,24(sp)
 8f0:	6442                	ld	s0,16(sp)
 8f2:	6161                	addi	sp,sp,80
 8f4:	8082                	ret

00000000000008f6 <printf>:

void
printf(const char *fmt, ...)
{
 8f6:	711d                	addi	sp,sp,-96
 8f8:	ec06                	sd	ra,24(sp)
 8fa:	e822                	sd	s0,16(sp)
 8fc:	1000                	addi	s0,sp,32
 8fe:	e40c                	sd	a1,8(s0)
 900:	e810                	sd	a2,16(s0)
 902:	ec14                	sd	a3,24(s0)
 904:	f018                	sd	a4,32(s0)
 906:	f41c                	sd	a5,40(s0)
 908:	03043823          	sd	a6,48(s0)
 90c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 910:	00840613          	addi	a2,s0,8
 914:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 918:	85aa                	mv	a1,a0
 91a:	4505                	li	a0,1
 91c:	00000097          	auipc	ra,0x0
 920:	dce080e7          	jalr	-562(ra) # 6ea <vprintf>
}
 924:	60e2                	ld	ra,24(sp)
 926:	6442                	ld	s0,16(sp)
 928:	6125                	addi	sp,sp,96
 92a:	8082                	ret

000000000000092c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 92c:	1141                	addi	sp,sp,-16
 92e:	e422                	sd	s0,8(sp)
 930:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 932:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 936:	00000797          	auipc	a5,0x0
 93a:	6ca7b783          	ld	a5,1738(a5) # 1000 <freep>
 93e:	a805                	j	96e <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 940:	4618                	lw	a4,8(a2)
 942:	9db9                	addw	a1,a1,a4
 944:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 948:	6398                	ld	a4,0(a5)
 94a:	6318                	ld	a4,0(a4)
 94c:	fee53823          	sd	a4,-16(a0)
 950:	a091                	j	994 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 952:	ff852703          	lw	a4,-8(a0)
 956:	9e39                	addw	a2,a2,a4
 958:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 95a:	ff053703          	ld	a4,-16(a0)
 95e:	e398                	sd	a4,0(a5)
 960:	a099                	j	9a6 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 962:	6398                	ld	a4,0(a5)
 964:	00e7e463          	bltu	a5,a4,96c <free+0x40>
 968:	00e6ea63          	bltu	a3,a4,97c <free+0x50>
{
 96c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 96e:	fed7fae3          	bgeu	a5,a3,962 <free+0x36>
 972:	6398                	ld	a4,0(a5)
 974:	00e6e463          	bltu	a3,a4,97c <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 978:	fee7eae3          	bltu	a5,a4,96c <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 97c:	ff852583          	lw	a1,-8(a0)
 980:	6390                	ld	a2,0(a5)
 982:	02059713          	slli	a4,a1,0x20
 986:	9301                	srli	a4,a4,0x20
 988:	0712                	slli	a4,a4,0x4
 98a:	9736                	add	a4,a4,a3
 98c:	fae60ae3          	beq	a2,a4,940 <free+0x14>
    bp->s.ptr = p->s.ptr;
 990:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 994:	4790                	lw	a2,8(a5)
 996:	02061713          	slli	a4,a2,0x20
 99a:	9301                	srli	a4,a4,0x20
 99c:	0712                	slli	a4,a4,0x4
 99e:	973e                	add	a4,a4,a5
 9a0:	fae689e3          	beq	a3,a4,952 <free+0x26>
  } else
    p->s.ptr = bp;
 9a4:	e394                	sd	a3,0(a5)
  freep = p;
 9a6:	00000717          	auipc	a4,0x0
 9aa:	64f73d23          	sd	a5,1626(a4) # 1000 <freep>
}
 9ae:	6422                	ld	s0,8(sp)
 9b0:	0141                	addi	sp,sp,16
 9b2:	8082                	ret

00000000000009b4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9b4:	7139                	addi	sp,sp,-64
 9b6:	fc06                	sd	ra,56(sp)
 9b8:	f822                	sd	s0,48(sp)
 9ba:	f426                	sd	s1,40(sp)
 9bc:	f04a                	sd	s2,32(sp)
 9be:	ec4e                	sd	s3,24(sp)
 9c0:	e852                	sd	s4,16(sp)
 9c2:	e456                	sd	s5,8(sp)
 9c4:	e05a                	sd	s6,0(sp)
 9c6:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9c8:	02051493          	slli	s1,a0,0x20
 9cc:	9081                	srli	s1,s1,0x20
 9ce:	04bd                	addi	s1,s1,15
 9d0:	8091                	srli	s1,s1,0x4
 9d2:	0014899b          	addiw	s3,s1,1
 9d6:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9d8:	00000517          	auipc	a0,0x0
 9dc:	62853503          	ld	a0,1576(a0) # 1000 <freep>
 9e0:	c515                	beqz	a0,a0c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9e4:	4798                	lw	a4,8(a5)
 9e6:	02977f63          	bgeu	a4,s1,a24 <malloc+0x70>
 9ea:	8a4e                	mv	s4,s3
 9ec:	0009871b          	sext.w	a4,s3
 9f0:	6685                	lui	a3,0x1
 9f2:	00d77363          	bgeu	a4,a3,9f8 <malloc+0x44>
 9f6:	6a05                	lui	s4,0x1
 9f8:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9fc:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a00:	00000917          	auipc	s2,0x0
 a04:	60090913          	addi	s2,s2,1536 # 1000 <freep>
  if(p == (char*)-1)
 a08:	5afd                	li	s5,-1
 a0a:	a88d                	j	a7c <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 a0c:	00000797          	auipc	a5,0x0
 a10:	61478793          	addi	a5,a5,1556 # 1020 <base>
 a14:	00000717          	auipc	a4,0x0
 a18:	5ef73623          	sd	a5,1516(a4) # 1000 <freep>
 a1c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a1e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a22:	b7e1                	j	9ea <malloc+0x36>
      if(p->s.size == nunits)
 a24:	02e48b63          	beq	s1,a4,a5a <malloc+0xa6>
        p->s.size -= nunits;
 a28:	4137073b          	subw	a4,a4,s3
 a2c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a2e:	1702                	slli	a4,a4,0x20
 a30:	9301                	srli	a4,a4,0x20
 a32:	0712                	slli	a4,a4,0x4
 a34:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a36:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a3a:	00000717          	auipc	a4,0x0
 a3e:	5ca73323          	sd	a0,1478(a4) # 1000 <freep>
      return (void*)(p + 1);
 a42:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a46:	70e2                	ld	ra,56(sp)
 a48:	7442                	ld	s0,48(sp)
 a4a:	74a2                	ld	s1,40(sp)
 a4c:	7902                	ld	s2,32(sp)
 a4e:	69e2                	ld	s3,24(sp)
 a50:	6a42                	ld	s4,16(sp)
 a52:	6aa2                	ld	s5,8(sp)
 a54:	6b02                	ld	s6,0(sp)
 a56:	6121                	addi	sp,sp,64
 a58:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a5a:	6398                	ld	a4,0(a5)
 a5c:	e118                	sd	a4,0(a0)
 a5e:	bff1                	j	a3a <malloc+0x86>
  hp->s.size = nu;
 a60:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a64:	0541                	addi	a0,a0,16
 a66:	00000097          	auipc	ra,0x0
 a6a:	ec6080e7          	jalr	-314(ra) # 92c <free>
  return freep;
 a6e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a72:	d971                	beqz	a0,a46 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a74:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a76:	4798                	lw	a4,8(a5)
 a78:	fa9776e3          	bgeu	a4,s1,a24 <malloc+0x70>
    if(p == freep)
 a7c:	00093703          	ld	a4,0(s2)
 a80:	853e                	mv	a0,a5
 a82:	fef719e3          	bne	a4,a5,a74 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 a86:	8552                	mv	a0,s4
 a88:	00000097          	auipc	ra,0x0
 a8c:	b66080e7          	jalr	-1178(ra) # 5ee <sbrk>
  if(p == (char*)-1)
 a90:	fd5518e3          	bne	a0,s5,a60 <malloc+0xac>
        return 0;
 a94:	4501                	li	a0,0
 a96:	bf45                	j	a46 <malloc+0x92>
