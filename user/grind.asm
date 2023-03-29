
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	1141                	addi	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	addi	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       6:	611c                	ld	a5,0(a0)
       8:	80000737          	lui	a4,0x80000
       c:	ffe74713          	xori	a4,a4,-2
      10:	02e7f7b3          	remu	a5,a5,a4
      14:	0785                	addi	a5,a5,1
    hi = x / 127773;
    lo = x % 127773;
      16:	66fd                	lui	a3,0x1f
      18:	31d68693          	addi	a3,a3,797 # 1f31d <base+0x1cf15>
      1c:	02d7e733          	rem	a4,a5,a3
    x = 16807 * lo - 2836 * hi;
      20:	6611                	lui	a2,0x4
      22:	1a760613          	addi	a2,a2,423 # 41a7 <base+0x1d9f>
      26:	02c70733          	mul	a4,a4,a2
    hi = x / 127773;
      2a:	02d7c7b3          	div	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      2e:	76fd                	lui	a3,0xfffff
      30:	4ec68693          	addi	a3,a3,1260 # fffffffffffff4ec <base+0xffffffffffffd0e4>
      34:	02d787b3          	mul	a5,a5,a3
      38:	97ba                	add	a5,a5,a4
    if (x < 0)
      3a:	0007c963          	bltz	a5,4c <do_rand+0x4c>
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      3e:	17fd                	addi	a5,a5,-1
    *ctx = x;
      40:	e11c                	sd	a5,0(a0)
    return (x);
}
      42:	0007851b          	sext.w	a0,a5
      46:	6422                	ld	s0,8(sp)
      48:	0141                	addi	sp,sp,16
      4a:	8082                	ret
        x += 0x7fffffff;
      4c:	80000737          	lui	a4,0x80000
      50:	fff74713          	not	a4,a4
      54:	97ba                	add	a5,a5,a4
      56:	b7e5                	j	3e <do_rand+0x3e>

0000000000000058 <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      58:	1141                	addi	sp,sp,-16
      5a:	e406                	sd	ra,8(sp)
      5c:	e022                	sd	s0,0(sp)
      5e:	0800                	addi	s0,sp,16
    return (do_rand(&rand_next));
      60:	00002517          	auipc	a0,0x2
      64:	fa050513          	addi	a0,a0,-96 # 2000 <rand_next>
      68:	00000097          	auipc	ra,0x0
      6c:	f98080e7          	jalr	-104(ra) # 0 <do_rand>
}
      70:	60a2                	ld	ra,8(sp)
      72:	6402                	ld	s0,0(sp)
      74:	0141                	addi	sp,sp,16
      76:	8082                	ret

0000000000000078 <go>:

void
go(int which_child)
{
      78:	7159                	addi	sp,sp,-112
      7a:	f486                	sd	ra,104(sp)
      7c:	f0a2                	sd	s0,96(sp)
      7e:	eca6                	sd	s1,88(sp)
      80:	e8ca                	sd	s2,80(sp)
      82:	e4ce                	sd	s3,72(sp)
      84:	e0d2                	sd	s4,64(sp)
      86:	fc56                	sd	s5,56(sp)
      88:	f85a                	sd	s6,48(sp)
      8a:	1880                	addi	s0,sp,112
      8c:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      8e:	4501                	li	a0,0
      90:	00001097          	auipc	ra,0x1
      94:	ee8080e7          	jalr	-280(ra) # f78 <sbrk>
      98:	8aaa                	mv	s5,a0
  uint64 iters = 0;

  mkdir("grindir");
      9a:	00001517          	auipc	a0,0x1
      9e:	38650513          	addi	a0,a0,902 # 1420 <malloc+0xf2>
      a2:	00001097          	auipc	ra,0x1
      a6:	eb6080e7          	jalr	-330(ra) # f58 <mkdir>
  if(chdir("grindir") != 0){
      aa:	00001517          	auipc	a0,0x1
      ae:	37650513          	addi	a0,a0,886 # 1420 <malloc+0xf2>
      b2:	00001097          	auipc	ra,0x1
      b6:	eae080e7          	jalr	-338(ra) # f60 <chdir>
      ba:	cd19                	beqz	a0,d8 <go+0x60>
    printf("grind: chdir grindir failed\n");
      bc:	00001517          	auipc	a0,0x1
      c0:	36c50513          	addi	a0,a0,876 # 1428 <malloc+0xfa>
      c4:	00001097          	auipc	ra,0x1
      c8:	1ac080e7          	jalr	428(ra) # 1270 <printf>
    exit(1,0);
      cc:	4581                	li	a1,0
      ce:	4505                	li	a0,1
      d0:	00001097          	auipc	ra,0x1
      d4:	e20080e7          	jalr	-480(ra) # ef0 <exit>
  }
  chdir("/");
      d8:	00001517          	auipc	a0,0x1
      dc:	37050513          	addi	a0,a0,880 # 1448 <malloc+0x11a>
      e0:	00001097          	auipc	ra,0x1
      e4:	e80080e7          	jalr	-384(ra) # f60 <chdir>
  
  while(1){
    iters++;
    if((iters % 500) == 0)
      e8:	00001997          	auipc	s3,0x1
      ec:	37098993          	addi	s3,s3,880 # 1458 <malloc+0x12a>
      f0:	c489                	beqz	s1,fa <go+0x82>
      f2:	00001997          	auipc	s3,0x1
      f6:	35e98993          	addi	s3,s3,862 # 1450 <malloc+0x122>
    iters++;
      fa:	4485                	li	s1,1
  int fd = -1;
      fc:	597d                	li	s2,-1
      close(fd);
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
    } else if(what == 7){
      write(fd, buf, sizeof(buf));
    } else if(what == 8){
      read(fd, buf, sizeof(buf));
      fe:	00002a17          	auipc	s4,0x2
     102:	f22a0a13          	addi	s4,s4,-222 # 2020 <buf.0>
     106:	a825                	j	13e <go+0xc6>
      close(open("grindir/../a", O_CREATE|O_RDWR));
     108:	20200593          	li	a1,514
     10c:	00001517          	auipc	a0,0x1
     110:	35450513          	addi	a0,a0,852 # 1460 <malloc+0x132>
     114:	00001097          	auipc	ra,0x1
     118:	e1c080e7          	jalr	-484(ra) # f30 <open>
     11c:	00001097          	auipc	ra,0x1
     120:	dfc080e7          	jalr	-516(ra) # f18 <close>
    iters++;
     124:	0485                	addi	s1,s1,1
    if((iters % 500) == 0)
     126:	1f400793          	li	a5,500
     12a:	02f4f7b3          	remu	a5,s1,a5
     12e:	eb81                	bnez	a5,13e <go+0xc6>
      write(1, which_child?"B":"A", 1);
     130:	4605                	li	a2,1
     132:	85ce                	mv	a1,s3
     134:	4505                	li	a0,1
     136:	00001097          	auipc	ra,0x1
     13a:	dda080e7          	jalr	-550(ra) # f10 <write>
    int what = rand() % 23;
     13e:	00000097          	auipc	ra,0x0
     142:	f1a080e7          	jalr	-230(ra) # 58 <rand>
     146:	47dd                	li	a5,23
     148:	02f5653b          	remw	a0,a0,a5
    if(what == 1){
     14c:	4785                	li	a5,1
     14e:	faf50de3          	beq	a0,a5,108 <go+0x90>
    } else if(what == 2){
     152:	4789                	li	a5,2
     154:	18f50863          	beq	a0,a5,2e4 <go+0x26c>
    } else if(what == 3){
     158:	478d                	li	a5,3
     15a:	1af50463          	beq	a0,a5,302 <go+0x28a>
    } else if(what == 4){
     15e:	4791                	li	a5,4
     160:	1af50a63          	beq	a0,a5,314 <go+0x29c>
    } else if(what == 5){
     164:	4795                	li	a5,5
     166:	1ef50f63          	beq	a0,a5,364 <go+0x2ec>
    } else if(what == 6){
     16a:	4799                	li	a5,6
     16c:	20f50d63          	beq	a0,a5,386 <go+0x30e>
    } else if(what == 7){
     170:	479d                	li	a5,7
     172:	22f50b63          	beq	a0,a5,3a8 <go+0x330>
    } else if(what == 8){
     176:	47a1                	li	a5,8
     178:	24f50163          	beq	a0,a5,3ba <go+0x342>
    } else if(what == 9){
     17c:	47a5                	li	a5,9
     17e:	24f50763          	beq	a0,a5,3cc <go+0x354>
      mkdir("grindir/../a");
      close(open("a/../a/./a", O_CREATE|O_RDWR));
      unlink("a/a");
    } else if(what == 10){
     182:	47a9                	li	a5,10
     184:	28f50363          	beq	a0,a5,40a <go+0x392>
      mkdir("/../b");
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
      unlink("b/b");
    } else if(what == 11){
     188:	47ad                	li	a5,11
     18a:	2af50f63          	beq	a0,a5,448 <go+0x3d0>
      unlink("b");
      link("../grindir/./../a", "../b");
    } else if(what == 12){
     18e:	47b1                	li	a5,12
     190:	2ef50163          	beq	a0,a5,472 <go+0x3fa>
      unlink("../grindir/../a");
      link(".././b", "/grindir/../a");
    } else if(what == 13){
     194:	47b5                	li	a5,13
     196:	30f50363          	beq	a0,a5,49c <go+0x424>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1,0);
      }
      wait(0,0);
    } else if(what == 14){
     19a:	47b9                	li	a5,14
     19c:	34f50163          	beq	a0,a5,4de <go+0x466>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1,0);
      }
      wait(0,0);
    } else if(what == 15){
     1a0:	47bd                	li	a5,15
     1a2:	38f50863          	beq	a0,a5,532 <go+0x4ba>
      sbrk(6011);
    } else if(what == 16){
     1a6:	47c1                	li	a5,16
     1a8:	38f50d63          	beq	a0,a5,542 <go+0x4ca>
      if(sbrk(0) > break0)
        sbrk(-(sbrk(0) - break0));
    } else if(what == 17){
     1ac:	47c5                	li	a5,17
     1ae:	3af50d63          	beq	a0,a5,568 <go+0x4f0>
        printf("grind: chdir failed\n");
        exit(1,0);
      }
      kill(pid);
      wait(0,0);
    } else if(what == 18){
     1b2:	47c9                	li	a5,18
     1b4:	44f50763          	beq	a0,a5,602 <go+0x58a>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1,0);
      }
      wait(0,0);
    } else if(what == 19){
     1b8:	47cd                	li	a5,19
     1ba:	48f50e63          	beq	a0,a5,656 <go+0x5de>
        exit(1,0);
      }
      close(fds[0]);
      close(fds[1]);
      wait(0,0);
    } else if(what == 20){
     1be:	47d1                	li	a5,20
     1c0:	58f50363          	beq	a0,a5,746 <go+0x6ce>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1,0);
      }
      wait(0,0);
    } else if(what == 21){
     1c4:	47d5                	li	a5,21
     1c6:	62f50463          	beq	a0,a5,7ee <go+0x776>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
        exit(1,0);
      }
      close(fd1);
      unlink("c");
    } else if(what == 22){
     1ca:	47d9                	li	a5,22
     1cc:	f4f51ce3          	bne	a0,a5,124 <go+0xac>
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     1d0:	f9840513          	addi	a0,s0,-104
     1d4:	00001097          	auipc	ra,0x1
     1d8:	d2c080e7          	jalr	-724(ra) # f00 <pipe>
     1dc:	72054263          	bltz	a0,900 <go+0x888>
        fprintf(2, "grind: pipe failed\n");
        exit(1,0);
      }
      if(pipe(bb) < 0){
     1e0:	fa040513          	addi	a0,s0,-96
     1e4:	00001097          	auipc	ra,0x1
     1e8:	d1c080e7          	jalr	-740(ra) # f00 <pipe>
     1ec:	72054963          	bltz	a0,91e <go+0x8a6>
        fprintf(2, "grind: pipe failed\n");
        exit(1,0);
      }
      int pid1 = fork();
     1f0:	00001097          	auipc	ra,0x1
     1f4:	cf8080e7          	jalr	-776(ra) # ee8 <fork>
      if(pid1 == 0){
     1f8:	74050263          	beqz	a0,93c <go+0x8c4>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2,0);
      } else if(pid1 < 0){
     1fc:	7e054c63          	bltz	a0,9f4 <go+0x97c>
        fprintf(2, "grind: fork failed\n");
        exit(3,0);
      }
      int pid2 = fork();
     200:	00001097          	auipc	ra,0x1
     204:	ce8080e7          	jalr	-792(ra) # ee8 <fork>
      if(pid2 == 0){
     208:	000505e3          	beqz	a0,a12 <go+0x99a>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6,0);
      } else if(pid2 < 0){
     20c:	0e0544e3          	bltz	a0,af4 <go+0xa7c>
        fprintf(2, "grind: fork failed\n");
        exit(7,0);
      }
      close(aa[0]);
     210:	f9842503          	lw	a0,-104(s0)
     214:	00001097          	auipc	ra,0x1
     218:	d04080e7          	jalr	-764(ra) # f18 <close>
      close(aa[1]);
     21c:	f9c42503          	lw	a0,-100(s0)
     220:	00001097          	auipc	ra,0x1
     224:	cf8080e7          	jalr	-776(ra) # f18 <close>
      close(bb[1]);
     228:	fa442503          	lw	a0,-92(s0)
     22c:	00001097          	auipc	ra,0x1
     230:	cec080e7          	jalr	-788(ra) # f18 <close>
      char buf[4] = { 0, 0, 0, 0 };
     234:	f8042823          	sw	zero,-112(s0)
      read(bb[0], buf+0, 1);
     238:	4605                	li	a2,1
     23a:	f9040593          	addi	a1,s0,-112
     23e:	fa042503          	lw	a0,-96(s0)
     242:	00001097          	auipc	ra,0x1
     246:	cc6080e7          	jalr	-826(ra) # f08 <read>
      read(bb[0], buf+1, 1);
     24a:	4605                	li	a2,1
     24c:	f9140593          	addi	a1,s0,-111
     250:	fa042503          	lw	a0,-96(s0)
     254:	00001097          	auipc	ra,0x1
     258:	cb4080e7          	jalr	-844(ra) # f08 <read>
      read(bb[0], buf+2, 1);
     25c:	4605                	li	a2,1
     25e:	f9240593          	addi	a1,s0,-110
     262:	fa042503          	lw	a0,-96(s0)
     266:	00001097          	auipc	ra,0x1
     26a:	ca2080e7          	jalr	-862(ra) # f08 <read>
      close(bb[0]);
     26e:	fa042503          	lw	a0,-96(s0)
     272:	00001097          	auipc	ra,0x1
     276:	ca6080e7          	jalr	-858(ra) # f18 <close>
      int st1, st2;
      wait(&st1,0);
     27a:	4581                	li	a1,0
     27c:	f9440513          	addi	a0,s0,-108
     280:	00001097          	auipc	ra,0x1
     284:	c78080e7          	jalr	-904(ra) # ef8 <wait>
      wait(&st2,0);
     288:	4581                	li	a1,0
     28a:	fa840513          	addi	a0,s0,-88
     28e:	00001097          	auipc	ra,0x1
     292:	c6a080e7          	jalr	-918(ra) # ef8 <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     296:	f9442783          	lw	a5,-108(s0)
     29a:	fa842703          	lw	a4,-88(s0)
     29e:	8fd9                	or	a5,a5,a4
     2a0:	2781                	sext.w	a5,a5
     2a2:	ef89                	bnez	a5,2bc <go+0x244>
     2a4:	00001597          	auipc	a1,0x1
     2a8:	43458593          	addi	a1,a1,1076 # 16d8 <malloc+0x3aa>
     2ac:	f9040513          	addi	a0,s0,-112
     2b0:	00001097          	auipc	ra,0x1
     2b4:	9ee080e7          	jalr	-1554(ra) # c9e <strcmp>
     2b8:	e60506e3          	beqz	a0,124 <go+0xac>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     2bc:	f9040693          	addi	a3,s0,-112
     2c0:	fa842603          	lw	a2,-88(s0)
     2c4:	f9442583          	lw	a1,-108(s0)
     2c8:	00001517          	auipc	a0,0x1
     2cc:	41850513          	addi	a0,a0,1048 # 16e0 <malloc+0x3b2>
     2d0:	00001097          	auipc	ra,0x1
     2d4:	fa0080e7          	jalr	-96(ra) # 1270 <printf>
        exit(1,0);
     2d8:	4581                	li	a1,0
     2da:	4505                	li	a0,1
     2dc:	00001097          	auipc	ra,0x1
     2e0:	c14080e7          	jalr	-1004(ra) # ef0 <exit>
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     2e4:	20200593          	li	a1,514
     2e8:	00001517          	auipc	a0,0x1
     2ec:	18850513          	addi	a0,a0,392 # 1470 <malloc+0x142>
     2f0:	00001097          	auipc	ra,0x1
     2f4:	c40080e7          	jalr	-960(ra) # f30 <open>
     2f8:	00001097          	auipc	ra,0x1
     2fc:	c20080e7          	jalr	-992(ra) # f18 <close>
     300:	b515                	j	124 <go+0xac>
      unlink("grindir/../a");
     302:	00001517          	auipc	a0,0x1
     306:	15e50513          	addi	a0,a0,350 # 1460 <malloc+0x132>
     30a:	00001097          	auipc	ra,0x1
     30e:	c36080e7          	jalr	-970(ra) # f40 <unlink>
     312:	bd09                	j	124 <go+0xac>
      if(chdir("grindir") != 0){
     314:	00001517          	auipc	a0,0x1
     318:	10c50513          	addi	a0,a0,268 # 1420 <malloc+0xf2>
     31c:	00001097          	auipc	ra,0x1
     320:	c44080e7          	jalr	-956(ra) # f60 <chdir>
     324:	e115                	bnez	a0,348 <go+0x2d0>
      unlink("../b");
     326:	00001517          	auipc	a0,0x1
     32a:	16250513          	addi	a0,a0,354 # 1488 <malloc+0x15a>
     32e:	00001097          	auipc	ra,0x1
     332:	c12080e7          	jalr	-1006(ra) # f40 <unlink>
      chdir("/");
     336:	00001517          	auipc	a0,0x1
     33a:	11250513          	addi	a0,a0,274 # 1448 <malloc+0x11a>
     33e:	00001097          	auipc	ra,0x1
     342:	c22080e7          	jalr	-990(ra) # f60 <chdir>
     346:	bbf9                	j	124 <go+0xac>
        printf("grind: chdir grindir failed\n");
     348:	00001517          	auipc	a0,0x1
     34c:	0e050513          	addi	a0,a0,224 # 1428 <malloc+0xfa>
     350:	00001097          	auipc	ra,0x1
     354:	f20080e7          	jalr	-224(ra) # 1270 <printf>
        exit(1,0);
     358:	4581                	li	a1,0
     35a:	4505                	li	a0,1
     35c:	00001097          	auipc	ra,0x1
     360:	b94080e7          	jalr	-1132(ra) # ef0 <exit>
      close(fd);
     364:	854a                	mv	a0,s2
     366:	00001097          	auipc	ra,0x1
     36a:	bb2080e7          	jalr	-1102(ra) # f18 <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     36e:	20200593          	li	a1,514
     372:	00001517          	auipc	a0,0x1
     376:	11e50513          	addi	a0,a0,286 # 1490 <malloc+0x162>
     37a:	00001097          	auipc	ra,0x1
     37e:	bb6080e7          	jalr	-1098(ra) # f30 <open>
     382:	892a                	mv	s2,a0
     384:	b345                	j	124 <go+0xac>
      close(fd);
     386:	854a                	mv	a0,s2
     388:	00001097          	auipc	ra,0x1
     38c:	b90080e7          	jalr	-1136(ra) # f18 <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     390:	20200593          	li	a1,514
     394:	00001517          	auipc	a0,0x1
     398:	10c50513          	addi	a0,a0,268 # 14a0 <malloc+0x172>
     39c:	00001097          	auipc	ra,0x1
     3a0:	b94080e7          	jalr	-1132(ra) # f30 <open>
     3a4:	892a                	mv	s2,a0
     3a6:	bbbd                	j	124 <go+0xac>
      write(fd, buf, sizeof(buf));
     3a8:	3e700613          	li	a2,999
     3ac:	85d2                	mv	a1,s4
     3ae:	854a                	mv	a0,s2
     3b0:	00001097          	auipc	ra,0x1
     3b4:	b60080e7          	jalr	-1184(ra) # f10 <write>
     3b8:	b3b5                	j	124 <go+0xac>
      read(fd, buf, sizeof(buf));
     3ba:	3e700613          	li	a2,999
     3be:	85d2                	mv	a1,s4
     3c0:	854a                	mv	a0,s2
     3c2:	00001097          	auipc	ra,0x1
     3c6:	b46080e7          	jalr	-1210(ra) # f08 <read>
     3ca:	bba9                	j	124 <go+0xac>
      mkdir("grindir/../a");
     3cc:	00001517          	auipc	a0,0x1
     3d0:	09450513          	addi	a0,a0,148 # 1460 <malloc+0x132>
     3d4:	00001097          	auipc	ra,0x1
     3d8:	b84080e7          	jalr	-1148(ra) # f58 <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     3dc:	20200593          	li	a1,514
     3e0:	00001517          	auipc	a0,0x1
     3e4:	0d850513          	addi	a0,a0,216 # 14b8 <malloc+0x18a>
     3e8:	00001097          	auipc	ra,0x1
     3ec:	b48080e7          	jalr	-1208(ra) # f30 <open>
     3f0:	00001097          	auipc	ra,0x1
     3f4:	b28080e7          	jalr	-1240(ra) # f18 <close>
      unlink("a/a");
     3f8:	00001517          	auipc	a0,0x1
     3fc:	0d050513          	addi	a0,a0,208 # 14c8 <malloc+0x19a>
     400:	00001097          	auipc	ra,0x1
     404:	b40080e7          	jalr	-1216(ra) # f40 <unlink>
     408:	bb31                	j	124 <go+0xac>
      mkdir("/../b");
     40a:	00001517          	auipc	a0,0x1
     40e:	0c650513          	addi	a0,a0,198 # 14d0 <malloc+0x1a2>
     412:	00001097          	auipc	ra,0x1
     416:	b46080e7          	jalr	-1210(ra) # f58 <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     41a:	20200593          	li	a1,514
     41e:	00001517          	auipc	a0,0x1
     422:	0ba50513          	addi	a0,a0,186 # 14d8 <malloc+0x1aa>
     426:	00001097          	auipc	ra,0x1
     42a:	b0a080e7          	jalr	-1270(ra) # f30 <open>
     42e:	00001097          	auipc	ra,0x1
     432:	aea080e7          	jalr	-1302(ra) # f18 <close>
      unlink("b/b");
     436:	00001517          	auipc	a0,0x1
     43a:	0b250513          	addi	a0,a0,178 # 14e8 <malloc+0x1ba>
     43e:	00001097          	auipc	ra,0x1
     442:	b02080e7          	jalr	-1278(ra) # f40 <unlink>
     446:	b9f9                	j	124 <go+0xac>
      unlink("b");
     448:	00001517          	auipc	a0,0x1
     44c:	06850513          	addi	a0,a0,104 # 14b0 <malloc+0x182>
     450:	00001097          	auipc	ra,0x1
     454:	af0080e7          	jalr	-1296(ra) # f40 <unlink>
      link("../grindir/./../a", "../b");
     458:	00001597          	auipc	a1,0x1
     45c:	03058593          	addi	a1,a1,48 # 1488 <malloc+0x15a>
     460:	00001517          	auipc	a0,0x1
     464:	09050513          	addi	a0,a0,144 # 14f0 <malloc+0x1c2>
     468:	00001097          	auipc	ra,0x1
     46c:	ae8080e7          	jalr	-1304(ra) # f50 <link>
     470:	b955                	j	124 <go+0xac>
      unlink("../grindir/../a");
     472:	00001517          	auipc	a0,0x1
     476:	09650513          	addi	a0,a0,150 # 1508 <malloc+0x1da>
     47a:	00001097          	auipc	ra,0x1
     47e:	ac6080e7          	jalr	-1338(ra) # f40 <unlink>
      link(".././b", "/grindir/../a");
     482:	00001597          	auipc	a1,0x1
     486:	00e58593          	addi	a1,a1,14 # 1490 <malloc+0x162>
     48a:	00001517          	auipc	a0,0x1
     48e:	08e50513          	addi	a0,a0,142 # 1518 <malloc+0x1ea>
     492:	00001097          	auipc	ra,0x1
     496:	abe080e7          	jalr	-1346(ra) # f50 <link>
     49a:	b169                	j	124 <go+0xac>
      int pid = fork();
     49c:	00001097          	auipc	ra,0x1
     4a0:	a4c080e7          	jalr	-1460(ra) # ee8 <fork>
      if(pid == 0){
     4a4:	c911                	beqz	a0,4b8 <go+0x440>
      } else if(pid < 0){
     4a6:	00054e63          	bltz	a0,4c2 <go+0x44a>
      wait(0,0);
     4aa:	4581                	li	a1,0
     4ac:	4501                	li	a0,0
     4ae:	00001097          	auipc	ra,0x1
     4b2:	a4a080e7          	jalr	-1462(ra) # ef8 <wait>
     4b6:	b1bd                	j	124 <go+0xac>
        exit(0,0);
     4b8:	4581                	li	a1,0
     4ba:	00001097          	auipc	ra,0x1
     4be:	a36080e7          	jalr	-1482(ra) # ef0 <exit>
        printf("grind: fork failed\n");
     4c2:	00001517          	auipc	a0,0x1
     4c6:	05e50513          	addi	a0,a0,94 # 1520 <malloc+0x1f2>
     4ca:	00001097          	auipc	ra,0x1
     4ce:	da6080e7          	jalr	-602(ra) # 1270 <printf>
        exit(1,0);
     4d2:	4581                	li	a1,0
     4d4:	4505                	li	a0,1
     4d6:	00001097          	auipc	ra,0x1
     4da:	a1a080e7          	jalr	-1510(ra) # ef0 <exit>
      int pid = fork();
     4de:	00001097          	auipc	ra,0x1
     4e2:	a0a080e7          	jalr	-1526(ra) # ee8 <fork>
      if(pid == 0){
     4e6:	c911                	beqz	a0,4fa <go+0x482>
      } else if(pid < 0){
     4e8:	02054763          	bltz	a0,516 <go+0x49e>
      wait(0,0);
     4ec:	4581                	li	a1,0
     4ee:	4501                	li	a0,0
     4f0:	00001097          	auipc	ra,0x1
     4f4:	a08080e7          	jalr	-1528(ra) # ef8 <wait>
     4f8:	b135                	j	124 <go+0xac>
        fork();
     4fa:	00001097          	auipc	ra,0x1
     4fe:	9ee080e7          	jalr	-1554(ra) # ee8 <fork>
        fork();
     502:	00001097          	auipc	ra,0x1
     506:	9e6080e7          	jalr	-1562(ra) # ee8 <fork>
        exit(0,0);
     50a:	4581                	li	a1,0
     50c:	4501                	li	a0,0
     50e:	00001097          	auipc	ra,0x1
     512:	9e2080e7          	jalr	-1566(ra) # ef0 <exit>
        printf("grind: fork failed\n");
     516:	00001517          	auipc	a0,0x1
     51a:	00a50513          	addi	a0,a0,10 # 1520 <malloc+0x1f2>
     51e:	00001097          	auipc	ra,0x1
     522:	d52080e7          	jalr	-686(ra) # 1270 <printf>
        exit(1,0);
     526:	4581                	li	a1,0
     528:	4505                	li	a0,1
     52a:	00001097          	auipc	ra,0x1
     52e:	9c6080e7          	jalr	-1594(ra) # ef0 <exit>
      sbrk(6011);
     532:	6505                	lui	a0,0x1
     534:	77b50513          	addi	a0,a0,1915 # 177b <digits+0x6b>
     538:	00001097          	auipc	ra,0x1
     53c:	a40080e7          	jalr	-1472(ra) # f78 <sbrk>
     540:	b6d5                	j	124 <go+0xac>
      if(sbrk(0) > break0)
     542:	4501                	li	a0,0
     544:	00001097          	auipc	ra,0x1
     548:	a34080e7          	jalr	-1484(ra) # f78 <sbrk>
     54c:	bcaafce3          	bgeu	s5,a0,124 <go+0xac>
        sbrk(-(sbrk(0) - break0));
     550:	4501                	li	a0,0
     552:	00001097          	auipc	ra,0x1
     556:	a26080e7          	jalr	-1498(ra) # f78 <sbrk>
     55a:	40aa853b          	subw	a0,s5,a0
     55e:	00001097          	auipc	ra,0x1
     562:	a1a080e7          	jalr	-1510(ra) # f78 <sbrk>
     566:	be7d                	j	124 <go+0xac>
      int pid = fork();
     568:	00001097          	auipc	ra,0x1
     56c:	980080e7          	jalr	-1664(ra) # ee8 <fork>
     570:	8b2a                	mv	s6,a0
      if(pid == 0){
     572:	c905                	beqz	a0,5a2 <go+0x52a>
      } else if(pid < 0){
     574:	04054b63          	bltz	a0,5ca <go+0x552>
      if(chdir("../grindir/..") != 0){
     578:	00001517          	auipc	a0,0x1
     57c:	fc050513          	addi	a0,a0,-64 # 1538 <malloc+0x20a>
     580:	00001097          	auipc	ra,0x1
     584:	9e0080e7          	jalr	-1568(ra) # f60 <chdir>
     588:	ed39                	bnez	a0,5e6 <go+0x56e>
      kill(pid);
     58a:	855a                	mv	a0,s6
     58c:	00001097          	auipc	ra,0x1
     590:	994080e7          	jalr	-1644(ra) # f20 <kill>
      wait(0,0);
     594:	4581                	li	a1,0
     596:	4501                	li	a0,0
     598:	00001097          	auipc	ra,0x1
     59c:	960080e7          	jalr	-1696(ra) # ef8 <wait>
     5a0:	b651                	j	124 <go+0xac>
        close(open("a", O_CREATE|O_RDWR));
     5a2:	20200593          	li	a1,514
     5a6:	00001517          	auipc	a0,0x1
     5aa:	f5a50513          	addi	a0,a0,-166 # 1500 <malloc+0x1d2>
     5ae:	00001097          	auipc	ra,0x1
     5b2:	982080e7          	jalr	-1662(ra) # f30 <open>
     5b6:	00001097          	auipc	ra,0x1
     5ba:	962080e7          	jalr	-1694(ra) # f18 <close>
        exit(0,0);
     5be:	4581                	li	a1,0
     5c0:	4501                	li	a0,0
     5c2:	00001097          	auipc	ra,0x1
     5c6:	92e080e7          	jalr	-1746(ra) # ef0 <exit>
        printf("grind: fork failed\n");
     5ca:	00001517          	auipc	a0,0x1
     5ce:	f5650513          	addi	a0,a0,-170 # 1520 <malloc+0x1f2>
     5d2:	00001097          	auipc	ra,0x1
     5d6:	c9e080e7          	jalr	-866(ra) # 1270 <printf>
        exit(1,0);
     5da:	4581                	li	a1,0
     5dc:	4505                	li	a0,1
     5de:	00001097          	auipc	ra,0x1
     5e2:	912080e7          	jalr	-1774(ra) # ef0 <exit>
        printf("grind: chdir failed\n");
     5e6:	00001517          	auipc	a0,0x1
     5ea:	f6250513          	addi	a0,a0,-158 # 1548 <malloc+0x21a>
     5ee:	00001097          	auipc	ra,0x1
     5f2:	c82080e7          	jalr	-894(ra) # 1270 <printf>
        exit(1,0);
     5f6:	4581                	li	a1,0
     5f8:	4505                	li	a0,1
     5fa:	00001097          	auipc	ra,0x1
     5fe:	8f6080e7          	jalr	-1802(ra) # ef0 <exit>
      int pid = fork();
     602:	00001097          	auipc	ra,0x1
     606:	8e6080e7          	jalr	-1818(ra) # ee8 <fork>
      if(pid == 0){
     60a:	c911                	beqz	a0,61e <go+0x5a6>
      } else if(pid < 0){
     60c:	02054763          	bltz	a0,63a <go+0x5c2>
      wait(0,0);
     610:	4581                	li	a1,0
     612:	4501                	li	a0,0
     614:	00001097          	auipc	ra,0x1
     618:	8e4080e7          	jalr	-1820(ra) # ef8 <wait>
     61c:	b621                	j	124 <go+0xac>
        kill(getpid());
     61e:	00001097          	auipc	ra,0x1
     622:	952080e7          	jalr	-1710(ra) # f70 <getpid>
     626:	00001097          	auipc	ra,0x1
     62a:	8fa080e7          	jalr	-1798(ra) # f20 <kill>
        exit(0,0);
     62e:	4581                	li	a1,0
     630:	4501                	li	a0,0
     632:	00001097          	auipc	ra,0x1
     636:	8be080e7          	jalr	-1858(ra) # ef0 <exit>
        printf("grind: fork failed\n");
     63a:	00001517          	auipc	a0,0x1
     63e:	ee650513          	addi	a0,a0,-282 # 1520 <malloc+0x1f2>
     642:	00001097          	auipc	ra,0x1
     646:	c2e080e7          	jalr	-978(ra) # 1270 <printf>
        exit(1,0);
     64a:	4581                	li	a1,0
     64c:	4505                	li	a0,1
     64e:	00001097          	auipc	ra,0x1
     652:	8a2080e7          	jalr	-1886(ra) # ef0 <exit>
      if(pipe(fds) < 0){
     656:	fa840513          	addi	a0,s0,-88
     65a:	00001097          	auipc	ra,0x1
     65e:	8a6080e7          	jalr	-1882(ra) # f00 <pipe>
     662:	02054c63          	bltz	a0,69a <go+0x622>
      int pid = fork();
     666:	00001097          	auipc	ra,0x1
     66a:	882080e7          	jalr	-1918(ra) # ee8 <fork>
      if(pid == 0){
     66e:	c521                	beqz	a0,6b6 <go+0x63e>
      } else if(pid < 0){
     670:	0a054d63          	bltz	a0,72a <go+0x6b2>
      close(fds[0]);
     674:	fa842503          	lw	a0,-88(s0)
     678:	00001097          	auipc	ra,0x1
     67c:	8a0080e7          	jalr	-1888(ra) # f18 <close>
      close(fds[1]);
     680:	fac42503          	lw	a0,-84(s0)
     684:	00001097          	auipc	ra,0x1
     688:	894080e7          	jalr	-1900(ra) # f18 <close>
      wait(0,0);
     68c:	4581                	li	a1,0
     68e:	4501                	li	a0,0
     690:	00001097          	auipc	ra,0x1
     694:	868080e7          	jalr	-1944(ra) # ef8 <wait>
     698:	b471                	j	124 <go+0xac>
        printf("grind: pipe failed\n");
     69a:	00001517          	auipc	a0,0x1
     69e:	ec650513          	addi	a0,a0,-314 # 1560 <malloc+0x232>
     6a2:	00001097          	auipc	ra,0x1
     6a6:	bce080e7          	jalr	-1074(ra) # 1270 <printf>
        exit(1,0);
     6aa:	4581                	li	a1,0
     6ac:	4505                	li	a0,1
     6ae:	00001097          	auipc	ra,0x1
     6b2:	842080e7          	jalr	-1982(ra) # ef0 <exit>
        fork();
     6b6:	00001097          	auipc	ra,0x1
     6ba:	832080e7          	jalr	-1998(ra) # ee8 <fork>
        fork();
     6be:	00001097          	auipc	ra,0x1
     6c2:	82a080e7          	jalr	-2006(ra) # ee8 <fork>
        if(write(fds[1], "x", 1) != 1)
     6c6:	4605                	li	a2,1
     6c8:	00001597          	auipc	a1,0x1
     6cc:	eb058593          	addi	a1,a1,-336 # 1578 <malloc+0x24a>
     6d0:	fac42503          	lw	a0,-84(s0)
     6d4:	00001097          	auipc	ra,0x1
     6d8:	83c080e7          	jalr	-1988(ra) # f10 <write>
     6dc:	4785                	li	a5,1
     6de:	02f51463          	bne	a0,a5,706 <go+0x68e>
        if(read(fds[0], &c, 1) != 1)
     6e2:	4605                	li	a2,1
     6e4:	fa040593          	addi	a1,s0,-96
     6e8:	fa842503          	lw	a0,-88(s0)
     6ec:	00001097          	auipc	ra,0x1
     6f0:	81c080e7          	jalr	-2020(ra) # f08 <read>
     6f4:	4785                	li	a5,1
     6f6:	02f51163          	bne	a0,a5,718 <go+0x6a0>
        exit(0,0);
     6fa:	4581                	li	a1,0
     6fc:	4501                	li	a0,0
     6fe:	00000097          	auipc	ra,0x0
     702:	7f2080e7          	jalr	2034(ra) # ef0 <exit>
          printf("grind: pipe write failed\n");
     706:	00001517          	auipc	a0,0x1
     70a:	e7a50513          	addi	a0,a0,-390 # 1580 <malloc+0x252>
     70e:	00001097          	auipc	ra,0x1
     712:	b62080e7          	jalr	-1182(ra) # 1270 <printf>
     716:	b7f1                	j	6e2 <go+0x66a>
          printf("grind: pipe read failed\n");
     718:	00001517          	auipc	a0,0x1
     71c:	e8850513          	addi	a0,a0,-376 # 15a0 <malloc+0x272>
     720:	00001097          	auipc	ra,0x1
     724:	b50080e7          	jalr	-1200(ra) # 1270 <printf>
     728:	bfc9                	j	6fa <go+0x682>
        printf("grind: fork failed\n");
     72a:	00001517          	auipc	a0,0x1
     72e:	df650513          	addi	a0,a0,-522 # 1520 <malloc+0x1f2>
     732:	00001097          	auipc	ra,0x1
     736:	b3e080e7          	jalr	-1218(ra) # 1270 <printf>
        exit(1,0);
     73a:	4581                	li	a1,0
     73c:	4505                	li	a0,1
     73e:	00000097          	auipc	ra,0x0
     742:	7b2080e7          	jalr	1970(ra) # ef0 <exit>
      int pid = fork();
     746:	00000097          	auipc	ra,0x0
     74a:	7a2080e7          	jalr	1954(ra) # ee8 <fork>
      if(pid == 0){
     74e:	c911                	beqz	a0,762 <go+0x6ea>
      } else if(pid < 0){
     750:	08054163          	bltz	a0,7d2 <go+0x75a>
      wait(0,0);
     754:	4581                	li	a1,0
     756:	4501                	li	a0,0
     758:	00000097          	auipc	ra,0x0
     75c:	7a0080e7          	jalr	1952(ra) # ef8 <wait>
     760:	b2d1                	j	124 <go+0xac>
        unlink("a");
     762:	00001517          	auipc	a0,0x1
     766:	d9e50513          	addi	a0,a0,-610 # 1500 <malloc+0x1d2>
     76a:	00000097          	auipc	ra,0x0
     76e:	7d6080e7          	jalr	2006(ra) # f40 <unlink>
        mkdir("a");
     772:	00001517          	auipc	a0,0x1
     776:	d8e50513          	addi	a0,a0,-626 # 1500 <malloc+0x1d2>
     77a:	00000097          	auipc	ra,0x0
     77e:	7de080e7          	jalr	2014(ra) # f58 <mkdir>
        chdir("a");
     782:	00001517          	auipc	a0,0x1
     786:	d7e50513          	addi	a0,a0,-642 # 1500 <malloc+0x1d2>
     78a:	00000097          	auipc	ra,0x0
     78e:	7d6080e7          	jalr	2006(ra) # f60 <chdir>
        unlink("../a");
     792:	00001517          	auipc	a0,0x1
     796:	cd650513          	addi	a0,a0,-810 # 1468 <malloc+0x13a>
     79a:	00000097          	auipc	ra,0x0
     79e:	7a6080e7          	jalr	1958(ra) # f40 <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     7a2:	20200593          	li	a1,514
     7a6:	00001517          	auipc	a0,0x1
     7aa:	dd250513          	addi	a0,a0,-558 # 1578 <malloc+0x24a>
     7ae:	00000097          	auipc	ra,0x0
     7b2:	782080e7          	jalr	1922(ra) # f30 <open>
        unlink("x");
     7b6:	00001517          	auipc	a0,0x1
     7ba:	dc250513          	addi	a0,a0,-574 # 1578 <malloc+0x24a>
     7be:	00000097          	auipc	ra,0x0
     7c2:	782080e7          	jalr	1922(ra) # f40 <unlink>
        exit(0,0);
     7c6:	4581                	li	a1,0
     7c8:	4501                	li	a0,0
     7ca:	00000097          	auipc	ra,0x0
     7ce:	726080e7          	jalr	1830(ra) # ef0 <exit>
        printf("grind: fork failed\n");
     7d2:	00001517          	auipc	a0,0x1
     7d6:	d4e50513          	addi	a0,a0,-690 # 1520 <malloc+0x1f2>
     7da:	00001097          	auipc	ra,0x1
     7de:	a96080e7          	jalr	-1386(ra) # 1270 <printf>
        exit(1,0);
     7e2:	4581                	li	a1,0
     7e4:	4505                	li	a0,1
     7e6:	00000097          	auipc	ra,0x0
     7ea:	70a080e7          	jalr	1802(ra) # ef0 <exit>
      unlink("c");
     7ee:	00001517          	auipc	a0,0x1
     7f2:	dd250513          	addi	a0,a0,-558 # 15c0 <malloc+0x292>
     7f6:	00000097          	auipc	ra,0x0
     7fa:	74a080e7          	jalr	1866(ra) # f40 <unlink>
      int fd1 = open("c", O_CREATE|O_RDWR);
     7fe:	20200593          	li	a1,514
     802:	00001517          	auipc	a0,0x1
     806:	dbe50513          	addi	a0,a0,-578 # 15c0 <malloc+0x292>
     80a:	00000097          	auipc	ra,0x0
     80e:	726080e7          	jalr	1830(ra) # f30 <open>
     812:	8b2a                	mv	s6,a0
      if(fd1 < 0){
     814:	04054f63          	bltz	a0,872 <go+0x7fa>
      if(write(fd1, "x", 1) != 1){
     818:	4605                	li	a2,1
     81a:	00001597          	auipc	a1,0x1
     81e:	d5e58593          	addi	a1,a1,-674 # 1578 <malloc+0x24a>
     822:	00000097          	auipc	ra,0x0
     826:	6ee080e7          	jalr	1774(ra) # f10 <write>
     82a:	4785                	li	a5,1
     82c:	06f51163          	bne	a0,a5,88e <go+0x816>
      if(fstat(fd1, &st) != 0){
     830:	fa840593          	addi	a1,s0,-88
     834:	855a                	mv	a0,s6
     836:	00000097          	auipc	ra,0x0
     83a:	712080e7          	jalr	1810(ra) # f48 <fstat>
     83e:	e535                	bnez	a0,8aa <go+0x832>
      if(st.size != 1){
     840:	fb843583          	ld	a1,-72(s0)
     844:	4785                	li	a5,1
     846:	08f59063          	bne	a1,a5,8c6 <go+0x84e>
      if(st.ino > 200){
     84a:	fac42583          	lw	a1,-84(s0)
     84e:	0c800793          	li	a5,200
     852:	08b7e963          	bltu	a5,a1,8e4 <go+0x86c>
      close(fd1);
     856:	855a                	mv	a0,s6
     858:	00000097          	auipc	ra,0x0
     85c:	6c0080e7          	jalr	1728(ra) # f18 <close>
      unlink("c");
     860:	00001517          	auipc	a0,0x1
     864:	d6050513          	addi	a0,a0,-672 # 15c0 <malloc+0x292>
     868:	00000097          	auipc	ra,0x0
     86c:	6d8080e7          	jalr	1752(ra) # f40 <unlink>
     870:	b855                	j	124 <go+0xac>
        printf("grind: create c failed\n");
     872:	00001517          	auipc	a0,0x1
     876:	d5650513          	addi	a0,a0,-682 # 15c8 <malloc+0x29a>
     87a:	00001097          	auipc	ra,0x1
     87e:	9f6080e7          	jalr	-1546(ra) # 1270 <printf>
        exit(1,0);
     882:	4581                	li	a1,0
     884:	4505                	li	a0,1
     886:	00000097          	auipc	ra,0x0
     88a:	66a080e7          	jalr	1642(ra) # ef0 <exit>
        printf("grind: write c failed\n");
     88e:	00001517          	auipc	a0,0x1
     892:	d5250513          	addi	a0,a0,-686 # 15e0 <malloc+0x2b2>
     896:	00001097          	auipc	ra,0x1
     89a:	9da080e7          	jalr	-1574(ra) # 1270 <printf>
        exit(1,0);
     89e:	4581                	li	a1,0
     8a0:	4505                	li	a0,1
     8a2:	00000097          	auipc	ra,0x0
     8a6:	64e080e7          	jalr	1614(ra) # ef0 <exit>
        printf("grind: fstat failed\n");
     8aa:	00001517          	auipc	a0,0x1
     8ae:	d4e50513          	addi	a0,a0,-690 # 15f8 <malloc+0x2ca>
     8b2:	00001097          	auipc	ra,0x1
     8b6:	9be080e7          	jalr	-1602(ra) # 1270 <printf>
        exit(1,0);
     8ba:	4581                	li	a1,0
     8bc:	4505                	li	a0,1
     8be:	00000097          	auipc	ra,0x0
     8c2:	632080e7          	jalr	1586(ra) # ef0 <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     8c6:	2581                	sext.w	a1,a1
     8c8:	00001517          	auipc	a0,0x1
     8cc:	d4850513          	addi	a0,a0,-696 # 1610 <malloc+0x2e2>
     8d0:	00001097          	auipc	ra,0x1
     8d4:	9a0080e7          	jalr	-1632(ra) # 1270 <printf>
        exit(1,0);
     8d8:	4581                	li	a1,0
     8da:	4505                	li	a0,1
     8dc:	00000097          	auipc	ra,0x0
     8e0:	614080e7          	jalr	1556(ra) # ef0 <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     8e4:	00001517          	auipc	a0,0x1
     8e8:	d5450513          	addi	a0,a0,-684 # 1638 <malloc+0x30a>
     8ec:	00001097          	auipc	ra,0x1
     8f0:	984080e7          	jalr	-1660(ra) # 1270 <printf>
        exit(1,0);
     8f4:	4581                	li	a1,0
     8f6:	4505                	li	a0,1
     8f8:	00000097          	auipc	ra,0x0
     8fc:	5f8080e7          	jalr	1528(ra) # ef0 <exit>
        fprintf(2, "grind: pipe failed\n");
     900:	00001597          	auipc	a1,0x1
     904:	c6058593          	addi	a1,a1,-928 # 1560 <malloc+0x232>
     908:	4509                	li	a0,2
     90a:	00001097          	auipc	ra,0x1
     90e:	938080e7          	jalr	-1736(ra) # 1242 <fprintf>
        exit(1,0);
     912:	4581                	li	a1,0
     914:	4505                	li	a0,1
     916:	00000097          	auipc	ra,0x0
     91a:	5da080e7          	jalr	1498(ra) # ef0 <exit>
        fprintf(2, "grind: pipe failed\n");
     91e:	00001597          	auipc	a1,0x1
     922:	c4258593          	addi	a1,a1,-958 # 1560 <malloc+0x232>
     926:	4509                	li	a0,2
     928:	00001097          	auipc	ra,0x1
     92c:	91a080e7          	jalr	-1766(ra) # 1242 <fprintf>
        exit(1,0);
     930:	4581                	li	a1,0
     932:	4505                	li	a0,1
     934:	00000097          	auipc	ra,0x0
     938:	5bc080e7          	jalr	1468(ra) # ef0 <exit>
        close(bb[0]);
     93c:	fa042503          	lw	a0,-96(s0)
     940:	00000097          	auipc	ra,0x0
     944:	5d8080e7          	jalr	1496(ra) # f18 <close>
        close(bb[1]);
     948:	fa442503          	lw	a0,-92(s0)
     94c:	00000097          	auipc	ra,0x0
     950:	5cc080e7          	jalr	1484(ra) # f18 <close>
        close(aa[0]);
     954:	f9842503          	lw	a0,-104(s0)
     958:	00000097          	auipc	ra,0x0
     95c:	5c0080e7          	jalr	1472(ra) # f18 <close>
        close(1);
     960:	4505                	li	a0,1
     962:	00000097          	auipc	ra,0x0
     966:	5b6080e7          	jalr	1462(ra) # f18 <close>
        if(dup(aa[1]) != 1){
     96a:	f9c42503          	lw	a0,-100(s0)
     96e:	00000097          	auipc	ra,0x0
     972:	5fa080e7          	jalr	1530(ra) # f68 <dup>
     976:	4785                	li	a5,1
     978:	02f50163          	beq	a0,a5,99a <go+0x922>
          fprintf(2, "grind: dup failed\n");
     97c:	00001597          	auipc	a1,0x1
     980:	ce458593          	addi	a1,a1,-796 # 1660 <malloc+0x332>
     984:	4509                	li	a0,2
     986:	00001097          	auipc	ra,0x1
     98a:	8bc080e7          	jalr	-1860(ra) # 1242 <fprintf>
          exit(1,0);
     98e:	4581                	li	a1,0
     990:	4505                	li	a0,1
     992:	00000097          	auipc	ra,0x0
     996:	55e080e7          	jalr	1374(ra) # ef0 <exit>
        close(aa[1]);
     99a:	f9c42503          	lw	a0,-100(s0)
     99e:	00000097          	auipc	ra,0x0
     9a2:	57a080e7          	jalr	1402(ra) # f18 <close>
        char *args[3] = { "echo", "hi", 0 };
     9a6:	00001797          	auipc	a5,0x1
     9aa:	cd278793          	addi	a5,a5,-814 # 1678 <malloc+0x34a>
     9ae:	faf43423          	sd	a5,-88(s0)
     9b2:	00001797          	auipc	a5,0x1
     9b6:	cce78793          	addi	a5,a5,-818 # 1680 <malloc+0x352>
     9ba:	faf43823          	sd	a5,-80(s0)
     9be:	fa043c23          	sd	zero,-72(s0)
        exec("grindir/../echo", args);
     9c2:	fa840593          	addi	a1,s0,-88
     9c6:	00001517          	auipc	a0,0x1
     9ca:	cc250513          	addi	a0,a0,-830 # 1688 <malloc+0x35a>
     9ce:	00000097          	auipc	ra,0x0
     9d2:	55a080e7          	jalr	1370(ra) # f28 <exec>
        fprintf(2, "grind: echo: not found\n");
     9d6:	00001597          	auipc	a1,0x1
     9da:	cc258593          	addi	a1,a1,-830 # 1698 <malloc+0x36a>
     9de:	4509                	li	a0,2
     9e0:	00001097          	auipc	ra,0x1
     9e4:	862080e7          	jalr	-1950(ra) # 1242 <fprintf>
        exit(2,0);
     9e8:	4581                	li	a1,0
     9ea:	4509                	li	a0,2
     9ec:	00000097          	auipc	ra,0x0
     9f0:	504080e7          	jalr	1284(ra) # ef0 <exit>
        fprintf(2, "grind: fork failed\n");
     9f4:	00001597          	auipc	a1,0x1
     9f8:	b2c58593          	addi	a1,a1,-1236 # 1520 <malloc+0x1f2>
     9fc:	4509                	li	a0,2
     9fe:	00001097          	auipc	ra,0x1
     a02:	844080e7          	jalr	-1980(ra) # 1242 <fprintf>
        exit(3,0);
     a06:	4581                	li	a1,0
     a08:	450d                	li	a0,3
     a0a:	00000097          	auipc	ra,0x0
     a0e:	4e6080e7          	jalr	1254(ra) # ef0 <exit>
        close(aa[1]);
     a12:	f9c42503          	lw	a0,-100(s0)
     a16:	00000097          	auipc	ra,0x0
     a1a:	502080e7          	jalr	1282(ra) # f18 <close>
        close(bb[0]);
     a1e:	fa042503          	lw	a0,-96(s0)
     a22:	00000097          	auipc	ra,0x0
     a26:	4f6080e7          	jalr	1270(ra) # f18 <close>
        close(0);
     a2a:	4501                	li	a0,0
     a2c:	00000097          	auipc	ra,0x0
     a30:	4ec080e7          	jalr	1260(ra) # f18 <close>
        if(dup(aa[0]) != 0){
     a34:	f9842503          	lw	a0,-104(s0)
     a38:	00000097          	auipc	ra,0x0
     a3c:	530080e7          	jalr	1328(ra) # f68 <dup>
     a40:	c105                	beqz	a0,a60 <go+0x9e8>
          fprintf(2, "grind: dup failed\n");
     a42:	00001597          	auipc	a1,0x1
     a46:	c1e58593          	addi	a1,a1,-994 # 1660 <malloc+0x332>
     a4a:	4509                	li	a0,2
     a4c:	00000097          	auipc	ra,0x0
     a50:	7f6080e7          	jalr	2038(ra) # 1242 <fprintf>
          exit(4,0);
     a54:	4581                	li	a1,0
     a56:	4511                	li	a0,4
     a58:	00000097          	auipc	ra,0x0
     a5c:	498080e7          	jalr	1176(ra) # ef0 <exit>
        close(aa[0]);
     a60:	f9842503          	lw	a0,-104(s0)
     a64:	00000097          	auipc	ra,0x0
     a68:	4b4080e7          	jalr	1204(ra) # f18 <close>
        close(1);
     a6c:	4505                	li	a0,1
     a6e:	00000097          	auipc	ra,0x0
     a72:	4aa080e7          	jalr	1194(ra) # f18 <close>
        if(dup(bb[1]) != 1){
     a76:	fa442503          	lw	a0,-92(s0)
     a7a:	00000097          	auipc	ra,0x0
     a7e:	4ee080e7          	jalr	1262(ra) # f68 <dup>
     a82:	4785                	li	a5,1
     a84:	02f50163          	beq	a0,a5,aa6 <go+0xa2e>
          fprintf(2, "grind: dup failed\n");
     a88:	00001597          	auipc	a1,0x1
     a8c:	bd858593          	addi	a1,a1,-1064 # 1660 <malloc+0x332>
     a90:	4509                	li	a0,2
     a92:	00000097          	auipc	ra,0x0
     a96:	7b0080e7          	jalr	1968(ra) # 1242 <fprintf>
          exit(5,0);
     a9a:	4581                	li	a1,0
     a9c:	4515                	li	a0,5
     a9e:	00000097          	auipc	ra,0x0
     aa2:	452080e7          	jalr	1106(ra) # ef0 <exit>
        close(bb[1]);
     aa6:	fa442503          	lw	a0,-92(s0)
     aaa:	00000097          	auipc	ra,0x0
     aae:	46e080e7          	jalr	1134(ra) # f18 <close>
        char *args[2] = { "cat", 0 };
     ab2:	00001797          	auipc	a5,0x1
     ab6:	bfe78793          	addi	a5,a5,-1026 # 16b0 <malloc+0x382>
     aba:	faf43423          	sd	a5,-88(s0)
     abe:	fa043823          	sd	zero,-80(s0)
        exec("/cat", args);
     ac2:	fa840593          	addi	a1,s0,-88
     ac6:	00001517          	auipc	a0,0x1
     aca:	bf250513          	addi	a0,a0,-1038 # 16b8 <malloc+0x38a>
     ace:	00000097          	auipc	ra,0x0
     ad2:	45a080e7          	jalr	1114(ra) # f28 <exec>
        fprintf(2, "grind: cat: not found\n");
     ad6:	00001597          	auipc	a1,0x1
     ada:	bea58593          	addi	a1,a1,-1046 # 16c0 <malloc+0x392>
     ade:	4509                	li	a0,2
     ae0:	00000097          	auipc	ra,0x0
     ae4:	762080e7          	jalr	1890(ra) # 1242 <fprintf>
        exit(6,0);
     ae8:	4581                	li	a1,0
     aea:	4519                	li	a0,6
     aec:	00000097          	auipc	ra,0x0
     af0:	404080e7          	jalr	1028(ra) # ef0 <exit>
        fprintf(2, "grind: fork failed\n");
     af4:	00001597          	auipc	a1,0x1
     af8:	a2c58593          	addi	a1,a1,-1492 # 1520 <malloc+0x1f2>
     afc:	4509                	li	a0,2
     afe:	00000097          	auipc	ra,0x0
     b02:	744080e7          	jalr	1860(ra) # 1242 <fprintf>
        exit(7,0);
     b06:	4581                	li	a1,0
     b08:	451d                	li	a0,7
     b0a:	00000097          	auipc	ra,0x0
     b0e:	3e6080e7          	jalr	998(ra) # ef0 <exit>

0000000000000b12 <iter>:
  }
}

void
iter()
{
     b12:	7179                	addi	sp,sp,-48
     b14:	f406                	sd	ra,40(sp)
     b16:	f022                	sd	s0,32(sp)
     b18:	ec26                	sd	s1,24(sp)
     b1a:	e84a                	sd	s2,16(sp)
     b1c:	1800                	addi	s0,sp,48
  unlink("a");
     b1e:	00001517          	auipc	a0,0x1
     b22:	9e250513          	addi	a0,a0,-1566 # 1500 <malloc+0x1d2>
     b26:	00000097          	auipc	ra,0x0
     b2a:	41a080e7          	jalr	1050(ra) # f40 <unlink>
  unlink("b");
     b2e:	00001517          	auipc	a0,0x1
     b32:	98250513          	addi	a0,a0,-1662 # 14b0 <malloc+0x182>
     b36:	00000097          	auipc	ra,0x0
     b3a:	40a080e7          	jalr	1034(ra) # f40 <unlink>
  
  int pid1 = fork();
     b3e:	00000097          	auipc	ra,0x0
     b42:	3aa080e7          	jalr	938(ra) # ee8 <fork>
  if(pid1 < 0){
     b46:	02054163          	bltz	a0,b68 <iter+0x56>
     b4a:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1,0);
  }
  if(pid1 == 0){
     b4c:	ed05                	bnez	a0,b84 <iter+0x72>
    rand_next ^= 31;
     b4e:	00001717          	auipc	a4,0x1
     b52:	4b270713          	addi	a4,a4,1202 # 2000 <rand_next>
     b56:	631c                	ld	a5,0(a4)
     b58:	01f7c793          	xori	a5,a5,31
     b5c:	e31c                	sd	a5,0(a4)
    go(0);
     b5e:	4501                	li	a0,0
     b60:	fffff097          	auipc	ra,0xfffff
     b64:	518080e7          	jalr	1304(ra) # 78 <go>
    printf("grind: fork failed\n");
     b68:	00001517          	auipc	a0,0x1
     b6c:	9b850513          	addi	a0,a0,-1608 # 1520 <malloc+0x1f2>
     b70:	00000097          	auipc	ra,0x0
     b74:	700080e7          	jalr	1792(ra) # 1270 <printf>
    exit(1,0);
     b78:	4581                	li	a1,0
     b7a:	4505                	li	a0,1
     b7c:	00000097          	auipc	ra,0x0
     b80:	374080e7          	jalr	884(ra) # ef0 <exit>
    exit(0,0);
  }

  int pid2 = fork();
     b84:	00000097          	auipc	ra,0x0
     b88:	364080e7          	jalr	868(ra) # ee8 <fork>
     b8c:	892a                	mv	s2,a0
  if(pid2 < 0){
     b8e:	02054263          	bltz	a0,bb2 <iter+0xa0>
    printf("grind: fork failed\n");
    exit(1,0);
  }
  if(pid2 == 0){
     b92:	ed15                	bnez	a0,bce <iter+0xbc>
    rand_next ^= 7177;
     b94:	00001697          	auipc	a3,0x1
     b98:	46c68693          	addi	a3,a3,1132 # 2000 <rand_next>
     b9c:	629c                	ld	a5,0(a3)
     b9e:	6709                	lui	a4,0x2
     ba0:	c0970713          	addi	a4,a4,-1015 # 1c09 <digits+0x4f9>
     ba4:	8fb9                	xor	a5,a5,a4
     ba6:	e29c                	sd	a5,0(a3)
    go(1);
     ba8:	4505                	li	a0,1
     baa:	fffff097          	auipc	ra,0xfffff
     bae:	4ce080e7          	jalr	1230(ra) # 78 <go>
    printf("grind: fork failed\n");
     bb2:	00001517          	auipc	a0,0x1
     bb6:	96e50513          	addi	a0,a0,-1682 # 1520 <malloc+0x1f2>
     bba:	00000097          	auipc	ra,0x0
     bbe:	6b6080e7          	jalr	1718(ra) # 1270 <printf>
    exit(1,0);
     bc2:	4581                	li	a1,0
     bc4:	4505                	li	a0,1
     bc6:	00000097          	auipc	ra,0x0
     bca:	32a080e7          	jalr	810(ra) # ef0 <exit>
    exit(0,0);
  }

  int st1 = -1;
     bce:	57fd                	li	a5,-1
     bd0:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1,0);
     bd4:	4581                	li	a1,0
     bd6:	fdc40513          	addi	a0,s0,-36
     bda:	00000097          	auipc	ra,0x0
     bde:	31e080e7          	jalr	798(ra) # ef8 <wait>
  if(st1 != 0){
     be2:	fdc42783          	lw	a5,-36(s0)
     be6:	e38d                	bnez	a5,c08 <iter+0xf6>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     be8:	57fd                	li	a5,-1
     bea:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2,0);
     bee:	4581                	li	a1,0
     bf0:	fd840513          	addi	a0,s0,-40
     bf4:	00000097          	auipc	ra,0x0
     bf8:	304080e7          	jalr	772(ra) # ef8 <wait>

  exit(0,0);
     bfc:	4581                	li	a1,0
     bfe:	4501                	li	a0,0
     c00:	00000097          	auipc	ra,0x0
     c04:	2f0080e7          	jalr	752(ra) # ef0 <exit>
    kill(pid1);
     c08:	8526                	mv	a0,s1
     c0a:	00000097          	auipc	ra,0x0
     c0e:	316080e7          	jalr	790(ra) # f20 <kill>
    kill(pid2);
     c12:	854a                	mv	a0,s2
     c14:	00000097          	auipc	ra,0x0
     c18:	30c080e7          	jalr	780(ra) # f20 <kill>
     c1c:	b7f1                	j	be8 <iter+0xd6>

0000000000000c1e <main>:
}

int
main()
{
     c1e:	1101                	addi	sp,sp,-32
     c20:	ec06                	sd	ra,24(sp)
     c22:	e822                	sd	s0,16(sp)
     c24:	e426                	sd	s1,8(sp)
     c26:	1000                	addi	s0,sp,32
    }
    if(pid > 0){
      wait(0,0);
    }
    sleep(20);
    rand_next += 1;
     c28:	00001497          	auipc	s1,0x1
     c2c:	3d848493          	addi	s1,s1,984 # 2000 <rand_next>
     c30:	a829                	j	c4a <main+0x2c>
      iter();
     c32:	00000097          	auipc	ra,0x0
     c36:	ee0080e7          	jalr	-288(ra) # b12 <iter>
    sleep(20);
     c3a:	4551                	li	a0,20
     c3c:	00000097          	auipc	ra,0x0
     c40:	344080e7          	jalr	836(ra) # f80 <sleep>
    rand_next += 1;
     c44:	609c                	ld	a5,0(s1)
     c46:	0785                	addi	a5,a5,1
     c48:	e09c                	sd	a5,0(s1)
    int pid = fork();
     c4a:	00000097          	auipc	ra,0x0
     c4e:	29e080e7          	jalr	670(ra) # ee8 <fork>
    if(pid == 0){
     c52:	d165                	beqz	a0,c32 <main+0x14>
    if(pid > 0){
     c54:	fea053e3          	blez	a0,c3a <main+0x1c>
      wait(0,0);
     c58:	4581                	li	a1,0
     c5a:	4501                	li	a0,0
     c5c:	00000097          	auipc	ra,0x0
     c60:	29c080e7          	jalr	668(ra) # ef8 <wait>
     c64:	bfd9                	j	c3a <main+0x1c>

0000000000000c66 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
     c66:	1141                	addi	sp,sp,-16
     c68:	e406                	sd	ra,8(sp)
     c6a:	e022                	sd	s0,0(sp)
     c6c:	0800                	addi	s0,sp,16
  extern int main();
  main();
     c6e:	00000097          	auipc	ra,0x0
     c72:	fb0080e7          	jalr	-80(ra) # c1e <main>
  exit(0,0);
     c76:	4581                	li	a1,0
     c78:	4501                	li	a0,0
     c7a:	00000097          	auipc	ra,0x0
     c7e:	276080e7          	jalr	630(ra) # ef0 <exit>

0000000000000c82 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     c82:	1141                	addi	sp,sp,-16
     c84:	e422                	sd	s0,8(sp)
     c86:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     c88:	87aa                	mv	a5,a0
     c8a:	0585                	addi	a1,a1,1
     c8c:	0785                	addi	a5,a5,1
     c8e:	fff5c703          	lbu	a4,-1(a1)
     c92:	fee78fa3          	sb	a4,-1(a5)
     c96:	fb75                	bnez	a4,c8a <strcpy+0x8>
    ;
  return os;
}
     c98:	6422                	ld	s0,8(sp)
     c9a:	0141                	addi	sp,sp,16
     c9c:	8082                	ret

0000000000000c9e <strcmp>:

int
strcmp(const char *p, const char *q)
{
     c9e:	1141                	addi	sp,sp,-16
     ca0:	e422                	sd	s0,8(sp)
     ca2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     ca4:	00054783          	lbu	a5,0(a0)
     ca8:	cb91                	beqz	a5,cbc <strcmp+0x1e>
     caa:	0005c703          	lbu	a4,0(a1)
     cae:	00f71763          	bne	a4,a5,cbc <strcmp+0x1e>
    p++, q++;
     cb2:	0505                	addi	a0,a0,1
     cb4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     cb6:	00054783          	lbu	a5,0(a0)
     cba:	fbe5                	bnez	a5,caa <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     cbc:	0005c503          	lbu	a0,0(a1)
}
     cc0:	40a7853b          	subw	a0,a5,a0
     cc4:	6422                	ld	s0,8(sp)
     cc6:	0141                	addi	sp,sp,16
     cc8:	8082                	ret

0000000000000cca <strlen>:

uint
strlen(const char *s)
{
     cca:	1141                	addi	sp,sp,-16
     ccc:	e422                	sd	s0,8(sp)
     cce:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     cd0:	00054783          	lbu	a5,0(a0)
     cd4:	cf91                	beqz	a5,cf0 <strlen+0x26>
     cd6:	0505                	addi	a0,a0,1
     cd8:	87aa                	mv	a5,a0
     cda:	4685                	li	a3,1
     cdc:	9e89                	subw	a3,a3,a0
     cde:	00f6853b          	addw	a0,a3,a5
     ce2:	0785                	addi	a5,a5,1
     ce4:	fff7c703          	lbu	a4,-1(a5)
     ce8:	fb7d                	bnez	a4,cde <strlen+0x14>
    ;
  return n;
}
     cea:	6422                	ld	s0,8(sp)
     cec:	0141                	addi	sp,sp,16
     cee:	8082                	ret
  for(n = 0; s[n]; n++)
     cf0:	4501                	li	a0,0
     cf2:	bfe5                	j	cea <strlen+0x20>

0000000000000cf4 <memset>:

void*
memset(void *dst, int c, uint n)
{
     cf4:	1141                	addi	sp,sp,-16
     cf6:	e422                	sd	s0,8(sp)
     cf8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     cfa:	ca19                	beqz	a2,d10 <memset+0x1c>
     cfc:	87aa                	mv	a5,a0
     cfe:	1602                	slli	a2,a2,0x20
     d00:	9201                	srli	a2,a2,0x20
     d02:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     d06:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     d0a:	0785                	addi	a5,a5,1
     d0c:	fee79de3          	bne	a5,a4,d06 <memset+0x12>
  }
  return dst;
}
     d10:	6422                	ld	s0,8(sp)
     d12:	0141                	addi	sp,sp,16
     d14:	8082                	ret

0000000000000d16 <strchr>:

char*
strchr(const char *s, char c)
{
     d16:	1141                	addi	sp,sp,-16
     d18:	e422                	sd	s0,8(sp)
     d1a:	0800                	addi	s0,sp,16
  for(; *s; s++)
     d1c:	00054783          	lbu	a5,0(a0)
     d20:	cb99                	beqz	a5,d36 <strchr+0x20>
    if(*s == c)
     d22:	00f58763          	beq	a1,a5,d30 <strchr+0x1a>
  for(; *s; s++)
     d26:	0505                	addi	a0,a0,1
     d28:	00054783          	lbu	a5,0(a0)
     d2c:	fbfd                	bnez	a5,d22 <strchr+0xc>
      return (char*)s;
  return 0;
     d2e:	4501                	li	a0,0
}
     d30:	6422                	ld	s0,8(sp)
     d32:	0141                	addi	sp,sp,16
     d34:	8082                	ret
  return 0;
     d36:	4501                	li	a0,0
     d38:	bfe5                	j	d30 <strchr+0x1a>

0000000000000d3a <gets>:

char*
gets(char *buf, int max)
{
     d3a:	711d                	addi	sp,sp,-96
     d3c:	ec86                	sd	ra,88(sp)
     d3e:	e8a2                	sd	s0,80(sp)
     d40:	e4a6                	sd	s1,72(sp)
     d42:	e0ca                	sd	s2,64(sp)
     d44:	fc4e                	sd	s3,56(sp)
     d46:	f852                	sd	s4,48(sp)
     d48:	f456                	sd	s5,40(sp)
     d4a:	f05a                	sd	s6,32(sp)
     d4c:	ec5e                	sd	s7,24(sp)
     d4e:	1080                	addi	s0,sp,96
     d50:	8baa                	mv	s7,a0
     d52:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     d54:	892a                	mv	s2,a0
     d56:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     d58:	4aa9                	li	s5,10
     d5a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     d5c:	89a6                	mv	s3,s1
     d5e:	2485                	addiw	s1,s1,1
     d60:	0344d863          	bge	s1,s4,d90 <gets+0x56>
    cc = read(0, &c, 1);
     d64:	4605                	li	a2,1
     d66:	faf40593          	addi	a1,s0,-81
     d6a:	4501                	li	a0,0
     d6c:	00000097          	auipc	ra,0x0
     d70:	19c080e7          	jalr	412(ra) # f08 <read>
    if(cc < 1)
     d74:	00a05e63          	blez	a0,d90 <gets+0x56>
    buf[i++] = c;
     d78:	faf44783          	lbu	a5,-81(s0)
     d7c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     d80:	01578763          	beq	a5,s5,d8e <gets+0x54>
     d84:	0905                	addi	s2,s2,1
     d86:	fd679be3          	bne	a5,s6,d5c <gets+0x22>
  for(i=0; i+1 < max; ){
     d8a:	89a6                	mv	s3,s1
     d8c:	a011                	j	d90 <gets+0x56>
     d8e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     d90:	99de                	add	s3,s3,s7
     d92:	00098023          	sb	zero,0(s3)
  return buf;
}
     d96:	855e                	mv	a0,s7
     d98:	60e6                	ld	ra,88(sp)
     d9a:	6446                	ld	s0,80(sp)
     d9c:	64a6                	ld	s1,72(sp)
     d9e:	6906                	ld	s2,64(sp)
     da0:	79e2                	ld	s3,56(sp)
     da2:	7a42                	ld	s4,48(sp)
     da4:	7aa2                	ld	s5,40(sp)
     da6:	7b02                	ld	s6,32(sp)
     da8:	6be2                	ld	s7,24(sp)
     daa:	6125                	addi	sp,sp,96
     dac:	8082                	ret

0000000000000dae <stat>:

int
stat(const char *n, struct stat *st)
{
     dae:	1101                	addi	sp,sp,-32
     db0:	ec06                	sd	ra,24(sp)
     db2:	e822                	sd	s0,16(sp)
     db4:	e426                	sd	s1,8(sp)
     db6:	e04a                	sd	s2,0(sp)
     db8:	1000                	addi	s0,sp,32
     dba:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     dbc:	4581                	li	a1,0
     dbe:	00000097          	auipc	ra,0x0
     dc2:	172080e7          	jalr	370(ra) # f30 <open>
  if(fd < 0)
     dc6:	02054563          	bltz	a0,df0 <stat+0x42>
     dca:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     dcc:	85ca                	mv	a1,s2
     dce:	00000097          	auipc	ra,0x0
     dd2:	17a080e7          	jalr	378(ra) # f48 <fstat>
     dd6:	892a                	mv	s2,a0
  close(fd);
     dd8:	8526                	mv	a0,s1
     dda:	00000097          	auipc	ra,0x0
     dde:	13e080e7          	jalr	318(ra) # f18 <close>
  return r;
}
     de2:	854a                	mv	a0,s2
     de4:	60e2                	ld	ra,24(sp)
     de6:	6442                	ld	s0,16(sp)
     de8:	64a2                	ld	s1,8(sp)
     dea:	6902                	ld	s2,0(sp)
     dec:	6105                	addi	sp,sp,32
     dee:	8082                	ret
    return -1;
     df0:	597d                	li	s2,-1
     df2:	bfc5                	j	de2 <stat+0x34>

0000000000000df4 <atoi>:

int
atoi(const char *s)
{
     df4:	1141                	addi	sp,sp,-16
     df6:	e422                	sd	s0,8(sp)
     df8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     dfa:	00054603          	lbu	a2,0(a0)
     dfe:	fd06079b          	addiw	a5,a2,-48
     e02:	0ff7f793          	andi	a5,a5,255
     e06:	4725                	li	a4,9
     e08:	02f76963          	bltu	a4,a5,e3a <atoi+0x46>
     e0c:	86aa                	mv	a3,a0
  n = 0;
     e0e:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
     e10:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
     e12:	0685                	addi	a3,a3,1
     e14:	0025179b          	slliw	a5,a0,0x2
     e18:	9fa9                	addw	a5,a5,a0
     e1a:	0017979b          	slliw	a5,a5,0x1
     e1e:	9fb1                	addw	a5,a5,a2
     e20:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     e24:	0006c603          	lbu	a2,0(a3)
     e28:	fd06071b          	addiw	a4,a2,-48
     e2c:	0ff77713          	andi	a4,a4,255
     e30:	fee5f1e3          	bgeu	a1,a4,e12 <atoi+0x1e>
  return n;
}
     e34:	6422                	ld	s0,8(sp)
     e36:	0141                	addi	sp,sp,16
     e38:	8082                	ret
  n = 0;
     e3a:	4501                	li	a0,0
     e3c:	bfe5                	j	e34 <atoi+0x40>

0000000000000e3e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     e3e:	1141                	addi	sp,sp,-16
     e40:	e422                	sd	s0,8(sp)
     e42:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     e44:	02b57463          	bgeu	a0,a1,e6c <memmove+0x2e>
    while(n-- > 0)
     e48:	00c05f63          	blez	a2,e66 <memmove+0x28>
     e4c:	1602                	slli	a2,a2,0x20
     e4e:	9201                	srli	a2,a2,0x20
     e50:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     e54:	872a                	mv	a4,a0
      *dst++ = *src++;
     e56:	0585                	addi	a1,a1,1
     e58:	0705                	addi	a4,a4,1
     e5a:	fff5c683          	lbu	a3,-1(a1)
     e5e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     e62:	fee79ae3          	bne	a5,a4,e56 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     e66:	6422                	ld	s0,8(sp)
     e68:	0141                	addi	sp,sp,16
     e6a:	8082                	ret
    dst += n;
     e6c:	00c50733          	add	a4,a0,a2
    src += n;
     e70:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     e72:	fec05ae3          	blez	a2,e66 <memmove+0x28>
     e76:	fff6079b          	addiw	a5,a2,-1
     e7a:	1782                	slli	a5,a5,0x20
     e7c:	9381                	srli	a5,a5,0x20
     e7e:	fff7c793          	not	a5,a5
     e82:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     e84:	15fd                	addi	a1,a1,-1
     e86:	177d                	addi	a4,a4,-1
     e88:	0005c683          	lbu	a3,0(a1)
     e8c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     e90:	fee79ae3          	bne	a5,a4,e84 <memmove+0x46>
     e94:	bfc9                	j	e66 <memmove+0x28>

0000000000000e96 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     e96:	1141                	addi	sp,sp,-16
     e98:	e422                	sd	s0,8(sp)
     e9a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     e9c:	ca05                	beqz	a2,ecc <memcmp+0x36>
     e9e:	fff6069b          	addiw	a3,a2,-1
     ea2:	1682                	slli	a3,a3,0x20
     ea4:	9281                	srli	a3,a3,0x20
     ea6:	0685                	addi	a3,a3,1
     ea8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     eaa:	00054783          	lbu	a5,0(a0)
     eae:	0005c703          	lbu	a4,0(a1)
     eb2:	00e79863          	bne	a5,a4,ec2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     eb6:	0505                	addi	a0,a0,1
    p2++;
     eb8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     eba:	fed518e3          	bne	a0,a3,eaa <memcmp+0x14>
  }
  return 0;
     ebe:	4501                	li	a0,0
     ec0:	a019                	j	ec6 <memcmp+0x30>
      return *p1 - *p2;
     ec2:	40e7853b          	subw	a0,a5,a4
}
     ec6:	6422                	ld	s0,8(sp)
     ec8:	0141                	addi	sp,sp,16
     eca:	8082                	ret
  return 0;
     ecc:	4501                	li	a0,0
     ece:	bfe5                	j	ec6 <memcmp+0x30>

0000000000000ed0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     ed0:	1141                	addi	sp,sp,-16
     ed2:	e406                	sd	ra,8(sp)
     ed4:	e022                	sd	s0,0(sp)
     ed6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     ed8:	00000097          	auipc	ra,0x0
     edc:	f66080e7          	jalr	-154(ra) # e3e <memmove>
}
     ee0:	60a2                	ld	ra,8(sp)
     ee2:	6402                	ld	s0,0(sp)
     ee4:	0141                	addi	sp,sp,16
     ee6:	8082                	ret

0000000000000ee8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     ee8:	4885                	li	a7,1
 ecall
     eea:	00000073          	ecall
 ret
     eee:	8082                	ret

0000000000000ef0 <exit>:
.global exit
exit:
 li a7, SYS_exit
     ef0:	4889                	li	a7,2
 ecall
     ef2:	00000073          	ecall
 ret
     ef6:	8082                	ret

0000000000000ef8 <wait>:
.global wait
wait:
 li a7, SYS_wait
     ef8:	488d                	li	a7,3
 ecall
     efa:	00000073          	ecall
 ret
     efe:	8082                	ret

0000000000000f00 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     f00:	4891                	li	a7,4
 ecall
     f02:	00000073          	ecall
 ret
     f06:	8082                	ret

0000000000000f08 <read>:
.global read
read:
 li a7, SYS_read
     f08:	4895                	li	a7,5
 ecall
     f0a:	00000073          	ecall
 ret
     f0e:	8082                	ret

0000000000000f10 <write>:
.global write
write:
 li a7, SYS_write
     f10:	48c1                	li	a7,16
 ecall
     f12:	00000073          	ecall
 ret
     f16:	8082                	ret

0000000000000f18 <close>:
.global close
close:
 li a7, SYS_close
     f18:	48d5                	li	a7,21
 ecall
     f1a:	00000073          	ecall
 ret
     f1e:	8082                	ret

0000000000000f20 <kill>:
.global kill
kill:
 li a7, SYS_kill
     f20:	4899                	li	a7,6
 ecall
     f22:	00000073          	ecall
 ret
     f26:	8082                	ret

0000000000000f28 <exec>:
.global exec
exec:
 li a7, SYS_exec
     f28:	489d                	li	a7,7
 ecall
     f2a:	00000073          	ecall
 ret
     f2e:	8082                	ret

0000000000000f30 <open>:
.global open
open:
 li a7, SYS_open
     f30:	48bd                	li	a7,15
 ecall
     f32:	00000073          	ecall
 ret
     f36:	8082                	ret

0000000000000f38 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     f38:	48c5                	li	a7,17
 ecall
     f3a:	00000073          	ecall
 ret
     f3e:	8082                	ret

0000000000000f40 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     f40:	48c9                	li	a7,18
 ecall
     f42:	00000073          	ecall
 ret
     f46:	8082                	ret

0000000000000f48 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     f48:	48a1                	li	a7,8
 ecall
     f4a:	00000073          	ecall
 ret
     f4e:	8082                	ret

0000000000000f50 <link>:
.global link
link:
 li a7, SYS_link
     f50:	48cd                	li	a7,19
 ecall
     f52:	00000073          	ecall
 ret
     f56:	8082                	ret

0000000000000f58 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     f58:	48d1                	li	a7,20
 ecall
     f5a:	00000073          	ecall
 ret
     f5e:	8082                	ret

0000000000000f60 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     f60:	48a5                	li	a7,9
 ecall
     f62:	00000073          	ecall
 ret
     f66:	8082                	ret

0000000000000f68 <dup>:
.global dup
dup:
 li a7, SYS_dup
     f68:	48a9                	li	a7,10
 ecall
     f6a:	00000073          	ecall
 ret
     f6e:	8082                	ret

0000000000000f70 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     f70:	48ad                	li	a7,11
 ecall
     f72:	00000073          	ecall
 ret
     f76:	8082                	ret

0000000000000f78 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     f78:	48b1                	li	a7,12
 ecall
     f7a:	00000073          	ecall
 ret
     f7e:	8082                	ret

0000000000000f80 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     f80:	48b5                	li	a7,13
 ecall
     f82:	00000073          	ecall
 ret
     f86:	8082                	ret

0000000000000f88 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     f88:	48b9                	li	a7,14
 ecall
     f8a:	00000073          	ecall
 ret
     f8e:	8082                	ret

0000000000000f90 <memsize>:
.global memsize
memsize:
 li a7, SYS_memsize
     f90:	48d9                	li	a7,22
 ecall
     f92:	00000073          	ecall
 ret
     f96:	8082                	ret

0000000000000f98 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     f98:	1101                	addi	sp,sp,-32
     f9a:	ec06                	sd	ra,24(sp)
     f9c:	e822                	sd	s0,16(sp)
     f9e:	1000                	addi	s0,sp,32
     fa0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     fa4:	4605                	li	a2,1
     fa6:	fef40593          	addi	a1,s0,-17
     faa:	00000097          	auipc	ra,0x0
     fae:	f66080e7          	jalr	-154(ra) # f10 <write>
}
     fb2:	60e2                	ld	ra,24(sp)
     fb4:	6442                	ld	s0,16(sp)
     fb6:	6105                	addi	sp,sp,32
     fb8:	8082                	ret

0000000000000fba <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     fba:	7139                	addi	sp,sp,-64
     fbc:	fc06                	sd	ra,56(sp)
     fbe:	f822                	sd	s0,48(sp)
     fc0:	f426                	sd	s1,40(sp)
     fc2:	f04a                	sd	s2,32(sp)
     fc4:	ec4e                	sd	s3,24(sp)
     fc6:	0080                	addi	s0,sp,64
     fc8:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     fca:	c299                	beqz	a3,fd0 <printint+0x16>
     fcc:	0805c863          	bltz	a1,105c <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     fd0:	2581                	sext.w	a1,a1
  neg = 0;
     fd2:	4881                	li	a7,0
     fd4:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
     fd8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     fda:	2601                	sext.w	a2,a2
     fdc:	00000517          	auipc	a0,0x0
     fe0:	73450513          	addi	a0,a0,1844 # 1710 <digits>
     fe4:	883a                	mv	a6,a4
     fe6:	2705                	addiw	a4,a4,1
     fe8:	02c5f7bb          	remuw	a5,a1,a2
     fec:	1782                	slli	a5,a5,0x20
     fee:	9381                	srli	a5,a5,0x20
     ff0:	97aa                	add	a5,a5,a0
     ff2:	0007c783          	lbu	a5,0(a5)
     ff6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     ffa:	0005879b          	sext.w	a5,a1
     ffe:	02c5d5bb          	divuw	a1,a1,a2
    1002:	0685                	addi	a3,a3,1
    1004:	fec7f0e3          	bgeu	a5,a2,fe4 <printint+0x2a>
  if(neg)
    1008:	00088b63          	beqz	a7,101e <printint+0x64>
    buf[i++] = '-';
    100c:	fd040793          	addi	a5,s0,-48
    1010:	973e                	add	a4,a4,a5
    1012:	02d00793          	li	a5,45
    1016:	fef70823          	sb	a5,-16(a4)
    101a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    101e:	02e05863          	blez	a4,104e <printint+0x94>
    1022:	fc040793          	addi	a5,s0,-64
    1026:	00e78933          	add	s2,a5,a4
    102a:	fff78993          	addi	s3,a5,-1
    102e:	99ba                	add	s3,s3,a4
    1030:	377d                	addiw	a4,a4,-1
    1032:	1702                	slli	a4,a4,0x20
    1034:	9301                	srli	a4,a4,0x20
    1036:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    103a:	fff94583          	lbu	a1,-1(s2)
    103e:	8526                	mv	a0,s1
    1040:	00000097          	auipc	ra,0x0
    1044:	f58080e7          	jalr	-168(ra) # f98 <putc>
  while(--i >= 0)
    1048:	197d                	addi	s2,s2,-1
    104a:	ff3918e3          	bne	s2,s3,103a <printint+0x80>
}
    104e:	70e2                	ld	ra,56(sp)
    1050:	7442                	ld	s0,48(sp)
    1052:	74a2                	ld	s1,40(sp)
    1054:	7902                	ld	s2,32(sp)
    1056:	69e2                	ld	s3,24(sp)
    1058:	6121                	addi	sp,sp,64
    105a:	8082                	ret
    x = -xx;
    105c:	40b005bb          	negw	a1,a1
    neg = 1;
    1060:	4885                	li	a7,1
    x = -xx;
    1062:	bf8d                	j	fd4 <printint+0x1a>

0000000000001064 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    1064:	7119                	addi	sp,sp,-128
    1066:	fc86                	sd	ra,120(sp)
    1068:	f8a2                	sd	s0,112(sp)
    106a:	f4a6                	sd	s1,104(sp)
    106c:	f0ca                	sd	s2,96(sp)
    106e:	ecce                	sd	s3,88(sp)
    1070:	e8d2                	sd	s4,80(sp)
    1072:	e4d6                	sd	s5,72(sp)
    1074:	e0da                	sd	s6,64(sp)
    1076:	fc5e                	sd	s7,56(sp)
    1078:	f862                	sd	s8,48(sp)
    107a:	f466                	sd	s9,40(sp)
    107c:	f06a                	sd	s10,32(sp)
    107e:	ec6e                	sd	s11,24(sp)
    1080:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    1082:	0005c903          	lbu	s2,0(a1)
    1086:	18090f63          	beqz	s2,1224 <vprintf+0x1c0>
    108a:	8aaa                	mv	s5,a0
    108c:	8b32                	mv	s6,a2
    108e:	00158493          	addi	s1,a1,1
  state = 0;
    1092:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1094:	02500a13          	li	s4,37
      if(c == 'd'){
    1098:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    109c:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    10a0:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    10a4:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    10a8:	00000b97          	auipc	s7,0x0
    10ac:	668b8b93          	addi	s7,s7,1640 # 1710 <digits>
    10b0:	a839                	j	10ce <vprintf+0x6a>
        putc(fd, c);
    10b2:	85ca                	mv	a1,s2
    10b4:	8556                	mv	a0,s5
    10b6:	00000097          	auipc	ra,0x0
    10ba:	ee2080e7          	jalr	-286(ra) # f98 <putc>
    10be:	a019                	j	10c4 <vprintf+0x60>
    } else if(state == '%'){
    10c0:	01498f63          	beq	s3,s4,10de <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    10c4:	0485                	addi	s1,s1,1
    10c6:	fff4c903          	lbu	s2,-1(s1)
    10ca:	14090d63          	beqz	s2,1224 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    10ce:	0009079b          	sext.w	a5,s2
    if(state == 0){
    10d2:	fe0997e3          	bnez	s3,10c0 <vprintf+0x5c>
      if(c == '%'){
    10d6:	fd479ee3          	bne	a5,s4,10b2 <vprintf+0x4e>
        state = '%';
    10da:	89be                	mv	s3,a5
    10dc:	b7e5                	j	10c4 <vprintf+0x60>
      if(c == 'd'){
    10de:	05878063          	beq	a5,s8,111e <vprintf+0xba>
      } else if(c == 'l') {
    10e2:	05978c63          	beq	a5,s9,113a <vprintf+0xd6>
      } else if(c == 'x') {
    10e6:	07a78863          	beq	a5,s10,1156 <vprintf+0xf2>
      } else if(c == 'p') {
    10ea:	09b78463          	beq	a5,s11,1172 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    10ee:	07300713          	li	a4,115
    10f2:	0ce78663          	beq	a5,a4,11be <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    10f6:	06300713          	li	a4,99
    10fa:	0ee78e63          	beq	a5,a4,11f6 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    10fe:	11478863          	beq	a5,s4,120e <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1102:	85d2                	mv	a1,s4
    1104:	8556                	mv	a0,s5
    1106:	00000097          	auipc	ra,0x0
    110a:	e92080e7          	jalr	-366(ra) # f98 <putc>
        putc(fd, c);
    110e:	85ca                	mv	a1,s2
    1110:	8556                	mv	a0,s5
    1112:	00000097          	auipc	ra,0x0
    1116:	e86080e7          	jalr	-378(ra) # f98 <putc>
      }
      state = 0;
    111a:	4981                	li	s3,0
    111c:	b765                	j	10c4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    111e:	008b0913          	addi	s2,s6,8
    1122:	4685                	li	a3,1
    1124:	4629                	li	a2,10
    1126:	000b2583          	lw	a1,0(s6)
    112a:	8556                	mv	a0,s5
    112c:	00000097          	auipc	ra,0x0
    1130:	e8e080e7          	jalr	-370(ra) # fba <printint>
    1134:	8b4a                	mv	s6,s2
      state = 0;
    1136:	4981                	li	s3,0
    1138:	b771                	j	10c4 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    113a:	008b0913          	addi	s2,s6,8
    113e:	4681                	li	a3,0
    1140:	4629                	li	a2,10
    1142:	000b2583          	lw	a1,0(s6)
    1146:	8556                	mv	a0,s5
    1148:	00000097          	auipc	ra,0x0
    114c:	e72080e7          	jalr	-398(ra) # fba <printint>
    1150:	8b4a                	mv	s6,s2
      state = 0;
    1152:	4981                	li	s3,0
    1154:	bf85                	j	10c4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    1156:	008b0913          	addi	s2,s6,8
    115a:	4681                	li	a3,0
    115c:	4641                	li	a2,16
    115e:	000b2583          	lw	a1,0(s6)
    1162:	8556                	mv	a0,s5
    1164:	00000097          	auipc	ra,0x0
    1168:	e56080e7          	jalr	-426(ra) # fba <printint>
    116c:	8b4a                	mv	s6,s2
      state = 0;
    116e:	4981                	li	s3,0
    1170:	bf91                	j	10c4 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    1172:	008b0793          	addi	a5,s6,8
    1176:	f8f43423          	sd	a5,-120(s0)
    117a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    117e:	03000593          	li	a1,48
    1182:	8556                	mv	a0,s5
    1184:	00000097          	auipc	ra,0x0
    1188:	e14080e7          	jalr	-492(ra) # f98 <putc>
  putc(fd, 'x');
    118c:	85ea                	mv	a1,s10
    118e:	8556                	mv	a0,s5
    1190:	00000097          	auipc	ra,0x0
    1194:	e08080e7          	jalr	-504(ra) # f98 <putc>
    1198:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    119a:	03c9d793          	srli	a5,s3,0x3c
    119e:	97de                	add	a5,a5,s7
    11a0:	0007c583          	lbu	a1,0(a5)
    11a4:	8556                	mv	a0,s5
    11a6:	00000097          	auipc	ra,0x0
    11aa:	df2080e7          	jalr	-526(ra) # f98 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    11ae:	0992                	slli	s3,s3,0x4
    11b0:	397d                	addiw	s2,s2,-1
    11b2:	fe0914e3          	bnez	s2,119a <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    11b6:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    11ba:	4981                	li	s3,0
    11bc:	b721                	j	10c4 <vprintf+0x60>
        s = va_arg(ap, char*);
    11be:	008b0993          	addi	s3,s6,8
    11c2:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    11c6:	02090163          	beqz	s2,11e8 <vprintf+0x184>
        while(*s != 0){
    11ca:	00094583          	lbu	a1,0(s2)
    11ce:	c9a1                	beqz	a1,121e <vprintf+0x1ba>
          putc(fd, *s);
    11d0:	8556                	mv	a0,s5
    11d2:	00000097          	auipc	ra,0x0
    11d6:	dc6080e7          	jalr	-570(ra) # f98 <putc>
          s++;
    11da:	0905                	addi	s2,s2,1
        while(*s != 0){
    11dc:	00094583          	lbu	a1,0(s2)
    11e0:	f9e5                	bnez	a1,11d0 <vprintf+0x16c>
        s = va_arg(ap, char*);
    11e2:	8b4e                	mv	s6,s3
      state = 0;
    11e4:	4981                	li	s3,0
    11e6:	bdf9                	j	10c4 <vprintf+0x60>
          s = "(null)";
    11e8:	00000917          	auipc	s2,0x0
    11ec:	52090913          	addi	s2,s2,1312 # 1708 <malloc+0x3da>
        while(*s != 0){
    11f0:	02800593          	li	a1,40
    11f4:	bff1                	j	11d0 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    11f6:	008b0913          	addi	s2,s6,8
    11fa:	000b4583          	lbu	a1,0(s6)
    11fe:	8556                	mv	a0,s5
    1200:	00000097          	auipc	ra,0x0
    1204:	d98080e7          	jalr	-616(ra) # f98 <putc>
    1208:	8b4a                	mv	s6,s2
      state = 0;
    120a:	4981                	li	s3,0
    120c:	bd65                	j	10c4 <vprintf+0x60>
        putc(fd, c);
    120e:	85d2                	mv	a1,s4
    1210:	8556                	mv	a0,s5
    1212:	00000097          	auipc	ra,0x0
    1216:	d86080e7          	jalr	-634(ra) # f98 <putc>
      state = 0;
    121a:	4981                	li	s3,0
    121c:	b565                	j	10c4 <vprintf+0x60>
        s = va_arg(ap, char*);
    121e:	8b4e                	mv	s6,s3
      state = 0;
    1220:	4981                	li	s3,0
    1222:	b54d                	j	10c4 <vprintf+0x60>
    }
  }
}
    1224:	70e6                	ld	ra,120(sp)
    1226:	7446                	ld	s0,112(sp)
    1228:	74a6                	ld	s1,104(sp)
    122a:	7906                	ld	s2,96(sp)
    122c:	69e6                	ld	s3,88(sp)
    122e:	6a46                	ld	s4,80(sp)
    1230:	6aa6                	ld	s5,72(sp)
    1232:	6b06                	ld	s6,64(sp)
    1234:	7be2                	ld	s7,56(sp)
    1236:	7c42                	ld	s8,48(sp)
    1238:	7ca2                	ld	s9,40(sp)
    123a:	7d02                	ld	s10,32(sp)
    123c:	6de2                	ld	s11,24(sp)
    123e:	6109                	addi	sp,sp,128
    1240:	8082                	ret

0000000000001242 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1242:	715d                	addi	sp,sp,-80
    1244:	ec06                	sd	ra,24(sp)
    1246:	e822                	sd	s0,16(sp)
    1248:	1000                	addi	s0,sp,32
    124a:	e010                	sd	a2,0(s0)
    124c:	e414                	sd	a3,8(s0)
    124e:	e818                	sd	a4,16(s0)
    1250:	ec1c                	sd	a5,24(s0)
    1252:	03043023          	sd	a6,32(s0)
    1256:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    125a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    125e:	8622                	mv	a2,s0
    1260:	00000097          	auipc	ra,0x0
    1264:	e04080e7          	jalr	-508(ra) # 1064 <vprintf>
}
    1268:	60e2                	ld	ra,24(sp)
    126a:	6442                	ld	s0,16(sp)
    126c:	6161                	addi	sp,sp,80
    126e:	8082                	ret

0000000000001270 <printf>:

void
printf(const char *fmt, ...)
{
    1270:	711d                	addi	sp,sp,-96
    1272:	ec06                	sd	ra,24(sp)
    1274:	e822                	sd	s0,16(sp)
    1276:	1000                	addi	s0,sp,32
    1278:	e40c                	sd	a1,8(s0)
    127a:	e810                	sd	a2,16(s0)
    127c:	ec14                	sd	a3,24(s0)
    127e:	f018                	sd	a4,32(s0)
    1280:	f41c                	sd	a5,40(s0)
    1282:	03043823          	sd	a6,48(s0)
    1286:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    128a:	00840613          	addi	a2,s0,8
    128e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1292:	85aa                	mv	a1,a0
    1294:	4505                	li	a0,1
    1296:	00000097          	auipc	ra,0x0
    129a:	dce080e7          	jalr	-562(ra) # 1064 <vprintf>
}
    129e:	60e2                	ld	ra,24(sp)
    12a0:	6442                	ld	s0,16(sp)
    12a2:	6125                	addi	sp,sp,96
    12a4:	8082                	ret

00000000000012a6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    12a6:	1141                	addi	sp,sp,-16
    12a8:	e422                	sd	s0,8(sp)
    12aa:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    12ac:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    12b0:	00001797          	auipc	a5,0x1
    12b4:	d607b783          	ld	a5,-672(a5) # 2010 <freep>
    12b8:	a805                	j	12e8 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    12ba:	4618                	lw	a4,8(a2)
    12bc:	9db9                	addw	a1,a1,a4
    12be:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    12c2:	6398                	ld	a4,0(a5)
    12c4:	6318                	ld	a4,0(a4)
    12c6:	fee53823          	sd	a4,-16(a0)
    12ca:	a091                	j	130e <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    12cc:	ff852703          	lw	a4,-8(a0)
    12d0:	9e39                	addw	a2,a2,a4
    12d2:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    12d4:	ff053703          	ld	a4,-16(a0)
    12d8:	e398                	sd	a4,0(a5)
    12da:	a099                	j	1320 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    12dc:	6398                	ld	a4,0(a5)
    12de:	00e7e463          	bltu	a5,a4,12e6 <free+0x40>
    12e2:	00e6ea63          	bltu	a3,a4,12f6 <free+0x50>
{
    12e6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    12e8:	fed7fae3          	bgeu	a5,a3,12dc <free+0x36>
    12ec:	6398                	ld	a4,0(a5)
    12ee:	00e6e463          	bltu	a3,a4,12f6 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    12f2:	fee7eae3          	bltu	a5,a4,12e6 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    12f6:	ff852583          	lw	a1,-8(a0)
    12fa:	6390                	ld	a2,0(a5)
    12fc:	02059713          	slli	a4,a1,0x20
    1300:	9301                	srli	a4,a4,0x20
    1302:	0712                	slli	a4,a4,0x4
    1304:	9736                	add	a4,a4,a3
    1306:	fae60ae3          	beq	a2,a4,12ba <free+0x14>
    bp->s.ptr = p->s.ptr;
    130a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    130e:	4790                	lw	a2,8(a5)
    1310:	02061713          	slli	a4,a2,0x20
    1314:	9301                	srli	a4,a4,0x20
    1316:	0712                	slli	a4,a4,0x4
    1318:	973e                	add	a4,a4,a5
    131a:	fae689e3          	beq	a3,a4,12cc <free+0x26>
  } else
    p->s.ptr = bp;
    131e:	e394                	sd	a3,0(a5)
  freep = p;
    1320:	00001717          	auipc	a4,0x1
    1324:	cef73823          	sd	a5,-784(a4) # 2010 <freep>
}
    1328:	6422                	ld	s0,8(sp)
    132a:	0141                	addi	sp,sp,16
    132c:	8082                	ret

000000000000132e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    132e:	7139                	addi	sp,sp,-64
    1330:	fc06                	sd	ra,56(sp)
    1332:	f822                	sd	s0,48(sp)
    1334:	f426                	sd	s1,40(sp)
    1336:	f04a                	sd	s2,32(sp)
    1338:	ec4e                	sd	s3,24(sp)
    133a:	e852                	sd	s4,16(sp)
    133c:	e456                	sd	s5,8(sp)
    133e:	e05a                	sd	s6,0(sp)
    1340:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1342:	02051493          	slli	s1,a0,0x20
    1346:	9081                	srli	s1,s1,0x20
    1348:	04bd                	addi	s1,s1,15
    134a:	8091                	srli	s1,s1,0x4
    134c:	0014899b          	addiw	s3,s1,1
    1350:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    1352:	00001517          	auipc	a0,0x1
    1356:	cbe53503          	ld	a0,-834(a0) # 2010 <freep>
    135a:	c515                	beqz	a0,1386 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    135c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    135e:	4798                	lw	a4,8(a5)
    1360:	02977f63          	bgeu	a4,s1,139e <malloc+0x70>
    1364:	8a4e                	mv	s4,s3
    1366:	0009871b          	sext.w	a4,s3
    136a:	6685                	lui	a3,0x1
    136c:	00d77363          	bgeu	a4,a3,1372 <malloc+0x44>
    1370:	6a05                	lui	s4,0x1
    1372:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1376:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    137a:	00001917          	auipc	s2,0x1
    137e:	c9690913          	addi	s2,s2,-874 # 2010 <freep>
  if(p == (char*)-1)
    1382:	5afd                	li	s5,-1
    1384:	a88d                	j	13f6 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    1386:	00001797          	auipc	a5,0x1
    138a:	08278793          	addi	a5,a5,130 # 2408 <base>
    138e:	00001717          	auipc	a4,0x1
    1392:	c8f73123          	sd	a5,-894(a4) # 2010 <freep>
    1396:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1398:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    139c:	b7e1                	j	1364 <malloc+0x36>
      if(p->s.size == nunits)
    139e:	02e48b63          	beq	s1,a4,13d4 <malloc+0xa6>
        p->s.size -= nunits;
    13a2:	4137073b          	subw	a4,a4,s3
    13a6:	c798                	sw	a4,8(a5)
        p += p->s.size;
    13a8:	1702                	slli	a4,a4,0x20
    13aa:	9301                	srli	a4,a4,0x20
    13ac:	0712                	slli	a4,a4,0x4
    13ae:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    13b0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    13b4:	00001717          	auipc	a4,0x1
    13b8:	c4a73e23          	sd	a0,-932(a4) # 2010 <freep>
      return (void*)(p + 1);
    13bc:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    13c0:	70e2                	ld	ra,56(sp)
    13c2:	7442                	ld	s0,48(sp)
    13c4:	74a2                	ld	s1,40(sp)
    13c6:	7902                	ld	s2,32(sp)
    13c8:	69e2                	ld	s3,24(sp)
    13ca:	6a42                	ld	s4,16(sp)
    13cc:	6aa2                	ld	s5,8(sp)
    13ce:	6b02                	ld	s6,0(sp)
    13d0:	6121                	addi	sp,sp,64
    13d2:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    13d4:	6398                	ld	a4,0(a5)
    13d6:	e118                	sd	a4,0(a0)
    13d8:	bff1                	j	13b4 <malloc+0x86>
  hp->s.size = nu;
    13da:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    13de:	0541                	addi	a0,a0,16
    13e0:	00000097          	auipc	ra,0x0
    13e4:	ec6080e7          	jalr	-314(ra) # 12a6 <free>
  return freep;
    13e8:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    13ec:	d971                	beqz	a0,13c0 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13ee:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    13f0:	4798                	lw	a4,8(a5)
    13f2:	fa9776e3          	bgeu	a4,s1,139e <malloc+0x70>
    if(p == freep)
    13f6:	00093703          	ld	a4,0(s2)
    13fa:	853e                	mv	a0,a5
    13fc:	fef719e3          	bne	a4,a5,13ee <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    1400:	8552                	mv	a0,s4
    1402:	00000097          	auipc	ra,0x0
    1406:	b76080e7          	jalr	-1162(ra) # f78 <sbrk>
  if(p == (char*)-1)
    140a:	fd5518e3          	bne	a0,s5,13da <malloc+0xac>
        return 0;
    140e:	4501                	li	a0,0
    1410:	bf45                	j	13c0 <malloc+0x92>
