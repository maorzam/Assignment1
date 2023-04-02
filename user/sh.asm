
user/_sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <getcmd>:
  exit(0,0);
}

int
getcmd(char *buf, int nbuf)
{
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	e426                	sd	s1,8(sp)
       8:	e04a                	sd	s2,0(sp)
       a:	1000                	addi	s0,sp,32
       c:	84aa                	mv	s1,a0
       e:	892e                	mv	s2,a1
  write(2, "$ ", 2);
      10:	4609                	li	a2,2
      12:	00001597          	auipc	a1,0x1
      16:	32e58593          	addi	a1,a1,814 # 1340 <malloc+0xe4>
      1a:	4509                	li	a0,2
      1c:	00001097          	auipc	ra,0x1
      20:	e12080e7          	jalr	-494(ra) # e2e <write>
  memset(buf, 0, nbuf);
      24:	864a                	mv	a2,s2
      26:	4581                	li	a1,0
      28:	8526                	mv	a0,s1
      2a:	00001097          	auipc	ra,0x1
      2e:	be8080e7          	jalr	-1048(ra) # c12 <memset>
  gets(buf, nbuf);
      32:	85ca                	mv	a1,s2
      34:	8526                	mv	a0,s1
      36:	00001097          	auipc	ra,0x1
      3a:	c22080e7          	jalr	-990(ra) # c58 <gets>
  if(buf[0] == 0) // EOF
      3e:	0004c503          	lbu	a0,0(s1)
      42:	00153513          	seqz	a0,a0
    return -1;
  return 0;
}
      46:	40a00533          	neg	a0,a0
      4a:	60e2                	ld	ra,24(sp)
      4c:	6442                	ld	s0,16(sp)
      4e:	64a2                	ld	s1,8(sp)
      50:	6902                	ld	s2,0(sp)
      52:	6105                	addi	sp,sp,32
      54:	8082                	ret

0000000000000056 <panic>:
  exit(0,0);
}

void
panic(char *s)
{
      56:	1141                	addi	sp,sp,-16
      58:	e406                	sd	ra,8(sp)
      5a:	e022                	sd	s0,0(sp)
      5c:	0800                	addi	s0,sp,16
      5e:	862a                	mv	a2,a0
  fprintf(2, "%s\n", s);
      60:	00001597          	auipc	a1,0x1
      64:	2e858593          	addi	a1,a1,744 # 1348 <malloc+0xec>
      68:	4509                	li	a0,2
      6a:	00001097          	auipc	ra,0x1
      6e:	106080e7          	jalr	262(ra) # 1170 <fprintf>
  exit(1,0);
      72:	4581                	li	a1,0
      74:	4505                	li	a0,1
      76:	00001097          	auipc	ra,0x1
      7a:	d98080e7          	jalr	-616(ra) # e0e <exit>

000000000000007e <fork1>:
}

int
fork1(void)
{
      7e:	1141                	addi	sp,sp,-16
      80:	e406                	sd	ra,8(sp)
      82:	e022                	sd	s0,0(sp)
      84:	0800                	addi	s0,sp,16
  int pid;

  pid = fork();
      86:	00001097          	auipc	ra,0x1
      8a:	d80080e7          	jalr	-640(ra) # e06 <fork>
  if(pid == -1)
      8e:	57fd                	li	a5,-1
      90:	00f50663          	beq	a0,a5,9c <fork1+0x1e>
    panic("fork");
  return pid;
}
      94:	60a2                	ld	ra,8(sp)
      96:	6402                	ld	s0,0(sp)
      98:	0141                	addi	sp,sp,16
      9a:	8082                	ret
    panic("fork");
      9c:	00001517          	auipc	a0,0x1
      a0:	2b450513          	addi	a0,a0,692 # 1350 <malloc+0xf4>
      a4:	00000097          	auipc	ra,0x0
      a8:	fb2080e7          	jalr	-78(ra) # 56 <panic>

00000000000000ac <runcmd>:
{
      ac:	7179                	addi	sp,sp,-48
      ae:	f406                	sd	ra,40(sp)
      b0:	f022                	sd	s0,32(sp)
      b2:	ec26                	sd	s1,24(sp)
      b4:	1800                	addi	s0,sp,48
  if(cmd == 0)
      b6:	c10d                	beqz	a0,d8 <runcmd+0x2c>
      b8:	84aa                	mv	s1,a0
  switch(cmd->type){
      ba:	4118                	lw	a4,0(a0)
      bc:	4795                	li	a5,5
      be:	02e7e363          	bltu	a5,a4,e4 <runcmd+0x38>
      c2:	00056783          	lwu	a5,0(a0)
      c6:	078a                	slli	a5,a5,0x2
      c8:	00001717          	auipc	a4,0x1
      cc:	38870713          	addi	a4,a4,904 # 1450 <malloc+0x1f4>
      d0:	97ba                	add	a5,a5,a4
      d2:	439c                	lw	a5,0(a5)
      d4:	97ba                	add	a5,a5,a4
      d6:	8782                	jr	a5
    exit(1,0);
      d8:	4581                	li	a1,0
      da:	4505                	li	a0,1
      dc:	00001097          	auipc	ra,0x1
      e0:	d32080e7          	jalr	-718(ra) # e0e <exit>
    panic("runcmd");
      e4:	00001517          	auipc	a0,0x1
      e8:	27450513          	addi	a0,a0,628 # 1358 <malloc+0xfc>
      ec:	00000097          	auipc	ra,0x0
      f0:	f6a080e7          	jalr	-150(ra) # 56 <panic>
    if(ecmd->argv[0] == 0)
      f4:	6508                	ld	a0,8(a0)
      f6:	c51d                	beqz	a0,124 <runcmd+0x78>
    exec(ecmd->argv[0], ecmd->argv);
      f8:	00848593          	addi	a1,s1,8
      fc:	00001097          	auipc	ra,0x1
     100:	d4a080e7          	jalr	-694(ra) # e46 <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
     104:	6490                	ld	a2,8(s1)
     106:	00001597          	auipc	a1,0x1
     10a:	25a58593          	addi	a1,a1,602 # 1360 <malloc+0x104>
     10e:	4509                	li	a0,2
     110:	00001097          	auipc	ra,0x1
     114:	060080e7          	jalr	96(ra) # 1170 <fprintf>
  exit(0,0);
     118:	4581                	li	a1,0
     11a:	4501                	li	a0,0
     11c:	00001097          	auipc	ra,0x1
     120:	cf2080e7          	jalr	-782(ra) # e0e <exit>
      exit(1,0);
     124:	4581                	li	a1,0
     126:	4505                	li	a0,1
     128:	00001097          	auipc	ra,0x1
     12c:	ce6080e7          	jalr	-794(ra) # e0e <exit>
    close(rcmd->fd);
     130:	5148                	lw	a0,36(a0)
     132:	00001097          	auipc	ra,0x1
     136:	d04080e7          	jalr	-764(ra) # e36 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     13a:	508c                	lw	a1,32(s1)
     13c:	6888                	ld	a0,16(s1)
     13e:	00001097          	auipc	ra,0x1
     142:	d10080e7          	jalr	-752(ra) # e4e <open>
     146:	00054763          	bltz	a0,154 <runcmd+0xa8>
    runcmd(rcmd->cmd);
     14a:	6488                	ld	a0,8(s1)
     14c:	00000097          	auipc	ra,0x0
     150:	f60080e7          	jalr	-160(ra) # ac <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     154:	6890                	ld	a2,16(s1)
     156:	00001597          	auipc	a1,0x1
     15a:	21a58593          	addi	a1,a1,538 # 1370 <malloc+0x114>
     15e:	4509                	li	a0,2
     160:	00001097          	auipc	ra,0x1
     164:	010080e7          	jalr	16(ra) # 1170 <fprintf>
      exit(1,0);
     168:	4581                	li	a1,0
     16a:	4505                	li	a0,1
     16c:	00001097          	auipc	ra,0x1
     170:	ca2080e7          	jalr	-862(ra) # e0e <exit>
    if(fork1() == 0)
     174:	00000097          	auipc	ra,0x0
     178:	f0a080e7          	jalr	-246(ra) # 7e <fork1>
     17c:	e511                	bnez	a0,188 <runcmd+0xdc>
      runcmd(lcmd->left);
     17e:	6488                	ld	a0,8(s1)
     180:	00000097          	auipc	ra,0x0
     184:	f2c080e7          	jalr	-212(ra) # ac <runcmd>
    wait(0,0);
     188:	4581                	li	a1,0
     18a:	4501                	li	a0,0
     18c:	00001097          	auipc	ra,0x1
     190:	c8a080e7          	jalr	-886(ra) # e16 <wait>
    runcmd(lcmd->right);
     194:	6888                	ld	a0,16(s1)
     196:	00000097          	auipc	ra,0x0
     19a:	f16080e7          	jalr	-234(ra) # ac <runcmd>
    if(pipe(p) < 0)
     19e:	fd840513          	addi	a0,s0,-40
     1a2:	00001097          	auipc	ra,0x1
     1a6:	c7c080e7          	jalr	-900(ra) # e1e <pipe>
     1aa:	04054363          	bltz	a0,1f0 <runcmd+0x144>
    if(fork1() == 0){
     1ae:	00000097          	auipc	ra,0x0
     1b2:	ed0080e7          	jalr	-304(ra) # 7e <fork1>
     1b6:	e529                	bnez	a0,200 <runcmd+0x154>
      close(1);
     1b8:	4505                	li	a0,1
     1ba:	00001097          	auipc	ra,0x1
     1be:	c7c080e7          	jalr	-900(ra) # e36 <close>
      dup(p[1]);
     1c2:	fdc42503          	lw	a0,-36(s0)
     1c6:	00001097          	auipc	ra,0x1
     1ca:	cc0080e7          	jalr	-832(ra) # e86 <dup>
      close(p[0]);
     1ce:	fd842503          	lw	a0,-40(s0)
     1d2:	00001097          	auipc	ra,0x1
     1d6:	c64080e7          	jalr	-924(ra) # e36 <close>
      close(p[1]);
     1da:	fdc42503          	lw	a0,-36(s0)
     1de:	00001097          	auipc	ra,0x1
     1e2:	c58080e7          	jalr	-936(ra) # e36 <close>
      runcmd(pcmd->left);
     1e6:	6488                	ld	a0,8(s1)
     1e8:	00000097          	auipc	ra,0x0
     1ec:	ec4080e7          	jalr	-316(ra) # ac <runcmd>
      panic("pipe");
     1f0:	00001517          	auipc	a0,0x1
     1f4:	19050513          	addi	a0,a0,400 # 1380 <malloc+0x124>
     1f8:	00000097          	auipc	ra,0x0
     1fc:	e5e080e7          	jalr	-418(ra) # 56 <panic>
    if(fork1() == 0){
     200:	00000097          	auipc	ra,0x0
     204:	e7e080e7          	jalr	-386(ra) # 7e <fork1>
     208:	ed05                	bnez	a0,240 <runcmd+0x194>
      close(0);
     20a:	00001097          	auipc	ra,0x1
     20e:	c2c080e7          	jalr	-980(ra) # e36 <close>
      dup(p[0]);
     212:	fd842503          	lw	a0,-40(s0)
     216:	00001097          	auipc	ra,0x1
     21a:	c70080e7          	jalr	-912(ra) # e86 <dup>
      close(p[0]);
     21e:	fd842503          	lw	a0,-40(s0)
     222:	00001097          	auipc	ra,0x1
     226:	c14080e7          	jalr	-1004(ra) # e36 <close>
      close(p[1]);
     22a:	fdc42503          	lw	a0,-36(s0)
     22e:	00001097          	auipc	ra,0x1
     232:	c08080e7          	jalr	-1016(ra) # e36 <close>
      runcmd(pcmd->right);
     236:	6888                	ld	a0,16(s1)
     238:	00000097          	auipc	ra,0x0
     23c:	e74080e7          	jalr	-396(ra) # ac <runcmd>
    close(p[0]);
     240:	fd842503          	lw	a0,-40(s0)
     244:	00001097          	auipc	ra,0x1
     248:	bf2080e7          	jalr	-1038(ra) # e36 <close>
    close(p[1]);
     24c:	fdc42503          	lw	a0,-36(s0)
     250:	00001097          	auipc	ra,0x1
     254:	be6080e7          	jalr	-1050(ra) # e36 <close>
    wait(0,0);
     258:	4581                	li	a1,0
     25a:	4501                	li	a0,0
     25c:	00001097          	auipc	ra,0x1
     260:	bba080e7          	jalr	-1094(ra) # e16 <wait>
    wait(0,0);
     264:	4581                	li	a1,0
     266:	4501                	li	a0,0
     268:	00001097          	auipc	ra,0x1
     26c:	bae080e7          	jalr	-1106(ra) # e16 <wait>
    break;
     270:	b565                	j	118 <runcmd+0x6c>
    if(fork1() == 0)
     272:	00000097          	auipc	ra,0x0
     276:	e0c080e7          	jalr	-500(ra) # 7e <fork1>
     27a:	e8051fe3          	bnez	a0,118 <runcmd+0x6c>
      runcmd(bcmd->cmd);
     27e:	6488                	ld	a0,8(s1)
     280:	00000097          	auipc	ra,0x0
     284:	e2c080e7          	jalr	-468(ra) # ac <runcmd>

0000000000000288 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     288:	1101                	addi	sp,sp,-32
     28a:	ec06                	sd	ra,24(sp)
     28c:	e822                	sd	s0,16(sp)
     28e:	e426                	sd	s1,8(sp)
     290:	1000                	addi	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     292:	0a800513          	li	a0,168
     296:	00001097          	auipc	ra,0x1
     29a:	fc6080e7          	jalr	-58(ra) # 125c <malloc>
     29e:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2a0:	0a800613          	li	a2,168
     2a4:	4581                	li	a1,0
     2a6:	00001097          	auipc	ra,0x1
     2aa:	96c080e7          	jalr	-1684(ra) # c12 <memset>
  cmd->type = EXEC;
     2ae:	4785                	li	a5,1
     2b0:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
     2b2:	8526                	mv	a0,s1
     2b4:	60e2                	ld	ra,24(sp)
     2b6:	6442                	ld	s0,16(sp)
     2b8:	64a2                	ld	s1,8(sp)
     2ba:	6105                	addi	sp,sp,32
     2bc:	8082                	ret

00000000000002be <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     2be:	7139                	addi	sp,sp,-64
     2c0:	fc06                	sd	ra,56(sp)
     2c2:	f822                	sd	s0,48(sp)
     2c4:	f426                	sd	s1,40(sp)
     2c6:	f04a                	sd	s2,32(sp)
     2c8:	ec4e                	sd	s3,24(sp)
     2ca:	e852                	sd	s4,16(sp)
     2cc:	e456                	sd	s5,8(sp)
     2ce:	e05a                	sd	s6,0(sp)
     2d0:	0080                	addi	s0,sp,64
     2d2:	8b2a                	mv	s6,a0
     2d4:	8aae                	mv	s5,a1
     2d6:	8a32                	mv	s4,a2
     2d8:	89b6                	mv	s3,a3
     2da:	893a                	mv	s2,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2dc:	02800513          	li	a0,40
     2e0:	00001097          	auipc	ra,0x1
     2e4:	f7c080e7          	jalr	-132(ra) # 125c <malloc>
     2e8:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2ea:	02800613          	li	a2,40
     2ee:	4581                	li	a1,0
     2f0:	00001097          	auipc	ra,0x1
     2f4:	922080e7          	jalr	-1758(ra) # c12 <memset>
  cmd->type = REDIR;
     2f8:	4789                	li	a5,2
     2fa:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     2fc:	0164b423          	sd	s6,8(s1)
  cmd->file = file;
     300:	0154b823          	sd	s5,16(s1)
  cmd->efile = efile;
     304:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
     308:	0334a023          	sw	s3,32(s1)
  cmd->fd = fd;
     30c:	0324a223          	sw	s2,36(s1)
  return (struct cmd*)cmd;
}
     310:	8526                	mv	a0,s1
     312:	70e2                	ld	ra,56(sp)
     314:	7442                	ld	s0,48(sp)
     316:	74a2                	ld	s1,40(sp)
     318:	7902                	ld	s2,32(sp)
     31a:	69e2                	ld	s3,24(sp)
     31c:	6a42                	ld	s4,16(sp)
     31e:	6aa2                	ld	s5,8(sp)
     320:	6b02                	ld	s6,0(sp)
     322:	6121                	addi	sp,sp,64
     324:	8082                	ret

0000000000000326 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     326:	7179                	addi	sp,sp,-48
     328:	f406                	sd	ra,40(sp)
     32a:	f022                	sd	s0,32(sp)
     32c:	ec26                	sd	s1,24(sp)
     32e:	e84a                	sd	s2,16(sp)
     330:	e44e                	sd	s3,8(sp)
     332:	1800                	addi	s0,sp,48
     334:	89aa                	mv	s3,a0
     336:	892e                	mv	s2,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     338:	4561                	li	a0,24
     33a:	00001097          	auipc	ra,0x1
     33e:	f22080e7          	jalr	-222(ra) # 125c <malloc>
     342:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     344:	4661                	li	a2,24
     346:	4581                	li	a1,0
     348:	00001097          	auipc	ra,0x1
     34c:	8ca080e7          	jalr	-1846(ra) # c12 <memset>
  cmd->type = PIPE;
     350:	478d                	li	a5,3
     352:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     354:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     358:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     35c:	8526                	mv	a0,s1
     35e:	70a2                	ld	ra,40(sp)
     360:	7402                	ld	s0,32(sp)
     362:	64e2                	ld	s1,24(sp)
     364:	6942                	ld	s2,16(sp)
     366:	69a2                	ld	s3,8(sp)
     368:	6145                	addi	sp,sp,48
     36a:	8082                	ret

000000000000036c <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     36c:	7179                	addi	sp,sp,-48
     36e:	f406                	sd	ra,40(sp)
     370:	f022                	sd	s0,32(sp)
     372:	ec26                	sd	s1,24(sp)
     374:	e84a                	sd	s2,16(sp)
     376:	e44e                	sd	s3,8(sp)
     378:	1800                	addi	s0,sp,48
     37a:	89aa                	mv	s3,a0
     37c:	892e                	mv	s2,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     37e:	4561                	li	a0,24
     380:	00001097          	auipc	ra,0x1
     384:	edc080e7          	jalr	-292(ra) # 125c <malloc>
     388:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     38a:	4661                	li	a2,24
     38c:	4581                	li	a1,0
     38e:	00001097          	auipc	ra,0x1
     392:	884080e7          	jalr	-1916(ra) # c12 <memset>
  cmd->type = LIST;
     396:	4791                	li	a5,4
     398:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     39a:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     39e:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     3a2:	8526                	mv	a0,s1
     3a4:	70a2                	ld	ra,40(sp)
     3a6:	7402                	ld	s0,32(sp)
     3a8:	64e2                	ld	s1,24(sp)
     3aa:	6942                	ld	s2,16(sp)
     3ac:	69a2                	ld	s3,8(sp)
     3ae:	6145                	addi	sp,sp,48
     3b0:	8082                	ret

00000000000003b2 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     3b2:	1101                	addi	sp,sp,-32
     3b4:	ec06                	sd	ra,24(sp)
     3b6:	e822                	sd	s0,16(sp)
     3b8:	e426                	sd	s1,8(sp)
     3ba:	e04a                	sd	s2,0(sp)
     3bc:	1000                	addi	s0,sp,32
     3be:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3c0:	4541                	li	a0,16
     3c2:	00001097          	auipc	ra,0x1
     3c6:	e9a080e7          	jalr	-358(ra) # 125c <malloc>
     3ca:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     3cc:	4641                	li	a2,16
     3ce:	4581                	li	a1,0
     3d0:	00001097          	auipc	ra,0x1
     3d4:	842080e7          	jalr	-1982(ra) # c12 <memset>
  cmd->type = BACK;
     3d8:	4795                	li	a5,5
     3da:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     3dc:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
     3e0:	8526                	mv	a0,s1
     3e2:	60e2                	ld	ra,24(sp)
     3e4:	6442                	ld	s0,16(sp)
     3e6:	64a2                	ld	s1,8(sp)
     3e8:	6902                	ld	s2,0(sp)
     3ea:	6105                	addi	sp,sp,32
     3ec:	8082                	ret

00000000000003ee <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     3ee:	7139                	addi	sp,sp,-64
     3f0:	fc06                	sd	ra,56(sp)
     3f2:	f822                	sd	s0,48(sp)
     3f4:	f426                	sd	s1,40(sp)
     3f6:	f04a                	sd	s2,32(sp)
     3f8:	ec4e                	sd	s3,24(sp)
     3fa:	e852                	sd	s4,16(sp)
     3fc:	e456                	sd	s5,8(sp)
     3fe:	e05a                	sd	s6,0(sp)
     400:	0080                	addi	s0,sp,64
     402:	8a2a                	mv	s4,a0
     404:	892e                	mv	s2,a1
     406:	8ab2                	mv	s5,a2
     408:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
     40a:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     40c:	00002997          	auipc	s3,0x2
     410:	bfc98993          	addi	s3,s3,-1028 # 2008 <whitespace>
     414:	00b4fd63          	bgeu	s1,a1,42e <gettoken+0x40>
     418:	0004c583          	lbu	a1,0(s1)
     41c:	854e                	mv	a0,s3
     41e:	00001097          	auipc	ra,0x1
     422:	816080e7          	jalr	-2026(ra) # c34 <strchr>
     426:	c501                	beqz	a0,42e <gettoken+0x40>
    s++;
     428:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     42a:	fe9917e3          	bne	s2,s1,418 <gettoken+0x2a>
  if(q)
     42e:	000a8463          	beqz	s5,436 <gettoken+0x48>
    *q = s;
     432:	009ab023          	sd	s1,0(s5)
  ret = *s;
     436:	0004c783          	lbu	a5,0(s1)
     43a:	00078a9b          	sext.w	s5,a5
  switch(*s){
     43e:	03c00713          	li	a4,60
     442:	06f76563          	bltu	a4,a5,4ac <gettoken+0xbe>
     446:	03a00713          	li	a4,58
     44a:	00f76e63          	bltu	a4,a5,466 <gettoken+0x78>
     44e:	cf89                	beqz	a5,468 <gettoken+0x7a>
     450:	02600713          	li	a4,38
     454:	00e78963          	beq	a5,a4,466 <gettoken+0x78>
     458:	fd87879b          	addiw	a5,a5,-40
     45c:	0ff7f793          	andi	a5,a5,255
     460:	4705                	li	a4,1
     462:	06f76c63          	bltu	a4,a5,4da <gettoken+0xec>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     466:	0485                	addi	s1,s1,1
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     468:	000b0463          	beqz	s6,470 <gettoken+0x82>
    *eq = s;
     46c:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
     470:	00002997          	auipc	s3,0x2
     474:	b9898993          	addi	s3,s3,-1128 # 2008 <whitespace>
     478:	0124fd63          	bgeu	s1,s2,492 <gettoken+0xa4>
     47c:	0004c583          	lbu	a1,0(s1)
     480:	854e                	mv	a0,s3
     482:	00000097          	auipc	ra,0x0
     486:	7b2080e7          	jalr	1970(ra) # c34 <strchr>
     48a:	c501                	beqz	a0,492 <gettoken+0xa4>
    s++;
     48c:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     48e:	fe9917e3          	bne	s2,s1,47c <gettoken+0x8e>
  *ps = s;
     492:	009a3023          	sd	s1,0(s4)
  return ret;
}
     496:	8556                	mv	a0,s5
     498:	70e2                	ld	ra,56(sp)
     49a:	7442                	ld	s0,48(sp)
     49c:	74a2                	ld	s1,40(sp)
     49e:	7902                	ld	s2,32(sp)
     4a0:	69e2                	ld	s3,24(sp)
     4a2:	6a42                	ld	s4,16(sp)
     4a4:	6aa2                	ld	s5,8(sp)
     4a6:	6b02                	ld	s6,0(sp)
     4a8:	6121                	addi	sp,sp,64
     4aa:	8082                	ret
  switch(*s){
     4ac:	03e00713          	li	a4,62
     4b0:	02e79163          	bne	a5,a4,4d2 <gettoken+0xe4>
    s++;
     4b4:	00148693          	addi	a3,s1,1
    if(*s == '>'){
     4b8:	0014c703          	lbu	a4,1(s1)
     4bc:	03e00793          	li	a5,62
      s++;
     4c0:	0489                	addi	s1,s1,2
      ret = '+';
     4c2:	02b00a93          	li	s5,43
    if(*s == '>'){
     4c6:	faf701e3          	beq	a4,a5,468 <gettoken+0x7a>
    s++;
     4ca:	84b6                	mv	s1,a3
  ret = *s;
     4cc:	03e00a93          	li	s5,62
     4d0:	bf61                	j	468 <gettoken+0x7a>
  switch(*s){
     4d2:	07c00713          	li	a4,124
     4d6:	f8e788e3          	beq	a5,a4,466 <gettoken+0x78>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     4da:	00002997          	auipc	s3,0x2
     4de:	b2e98993          	addi	s3,s3,-1234 # 2008 <whitespace>
     4e2:	00002a97          	auipc	s5,0x2
     4e6:	b1ea8a93          	addi	s5,s5,-1250 # 2000 <symbols>
     4ea:	0324f563          	bgeu	s1,s2,514 <gettoken+0x126>
     4ee:	0004c583          	lbu	a1,0(s1)
     4f2:	854e                	mv	a0,s3
     4f4:	00000097          	auipc	ra,0x0
     4f8:	740080e7          	jalr	1856(ra) # c34 <strchr>
     4fc:	e505                	bnez	a0,524 <gettoken+0x136>
     4fe:	0004c583          	lbu	a1,0(s1)
     502:	8556                	mv	a0,s5
     504:	00000097          	auipc	ra,0x0
     508:	730080e7          	jalr	1840(ra) # c34 <strchr>
     50c:	e909                	bnez	a0,51e <gettoken+0x130>
      s++;
     50e:	0485                	addi	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     510:	fc991fe3          	bne	s2,s1,4ee <gettoken+0x100>
  if(eq)
     514:	06100a93          	li	s5,97
     518:	f40b1ae3          	bnez	s6,46c <gettoken+0x7e>
     51c:	bf9d                	j	492 <gettoken+0xa4>
    ret = 'a';
     51e:	06100a93          	li	s5,97
     522:	b799                	j	468 <gettoken+0x7a>
     524:	06100a93          	li	s5,97
     528:	b781                	j	468 <gettoken+0x7a>

000000000000052a <peek>:

int
peek(char **ps, char *es, char *toks)
{
     52a:	7139                	addi	sp,sp,-64
     52c:	fc06                	sd	ra,56(sp)
     52e:	f822                	sd	s0,48(sp)
     530:	f426                	sd	s1,40(sp)
     532:	f04a                	sd	s2,32(sp)
     534:	ec4e                	sd	s3,24(sp)
     536:	e852                	sd	s4,16(sp)
     538:	e456                	sd	s5,8(sp)
     53a:	0080                	addi	s0,sp,64
     53c:	8a2a                	mv	s4,a0
     53e:	892e                	mv	s2,a1
     540:	8ab2                	mv	s5,a2
  char *s;

  s = *ps;
     542:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     544:	00002997          	auipc	s3,0x2
     548:	ac498993          	addi	s3,s3,-1340 # 2008 <whitespace>
     54c:	00b4fd63          	bgeu	s1,a1,566 <peek+0x3c>
     550:	0004c583          	lbu	a1,0(s1)
     554:	854e                	mv	a0,s3
     556:	00000097          	auipc	ra,0x0
     55a:	6de080e7          	jalr	1758(ra) # c34 <strchr>
     55e:	c501                	beqz	a0,566 <peek+0x3c>
    s++;
     560:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     562:	fe9917e3          	bne	s2,s1,550 <peek+0x26>
  *ps = s;
     566:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
     56a:	0004c583          	lbu	a1,0(s1)
     56e:	4501                	li	a0,0
     570:	e991                	bnez	a1,584 <peek+0x5a>
}
     572:	70e2                	ld	ra,56(sp)
     574:	7442                	ld	s0,48(sp)
     576:	74a2                	ld	s1,40(sp)
     578:	7902                	ld	s2,32(sp)
     57a:	69e2                	ld	s3,24(sp)
     57c:	6a42                	ld	s4,16(sp)
     57e:	6aa2                	ld	s5,8(sp)
     580:	6121                	addi	sp,sp,64
     582:	8082                	ret
  return *s && strchr(toks, *s);
     584:	8556                	mv	a0,s5
     586:	00000097          	auipc	ra,0x0
     58a:	6ae080e7          	jalr	1710(ra) # c34 <strchr>
     58e:	00a03533          	snez	a0,a0
     592:	b7c5                	j	572 <peek+0x48>

0000000000000594 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     594:	7159                	addi	sp,sp,-112
     596:	f486                	sd	ra,104(sp)
     598:	f0a2                	sd	s0,96(sp)
     59a:	eca6                	sd	s1,88(sp)
     59c:	e8ca                	sd	s2,80(sp)
     59e:	e4ce                	sd	s3,72(sp)
     5a0:	e0d2                	sd	s4,64(sp)
     5a2:	fc56                	sd	s5,56(sp)
     5a4:	f85a                	sd	s6,48(sp)
     5a6:	f45e                	sd	s7,40(sp)
     5a8:	f062                	sd	s8,32(sp)
     5aa:	ec66                	sd	s9,24(sp)
     5ac:	1880                	addi	s0,sp,112
     5ae:	8a2a                	mv	s4,a0
     5b0:	89ae                	mv	s3,a1
     5b2:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     5b4:	00001b97          	auipc	s7,0x1
     5b8:	df4b8b93          	addi	s7,s7,-524 # 13a8 <malloc+0x14c>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     5bc:	06100c13          	li	s8,97
      panic("missing file for redirection");
    switch(tok){
     5c0:	03c00c93          	li	s9,60
  while(peek(ps, es, "<>")){
     5c4:	a02d                	j	5ee <parseredirs+0x5a>
      panic("missing file for redirection");
     5c6:	00001517          	auipc	a0,0x1
     5ca:	dc250513          	addi	a0,a0,-574 # 1388 <malloc+0x12c>
     5ce:	00000097          	auipc	ra,0x0
     5d2:	a88080e7          	jalr	-1400(ra) # 56 <panic>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     5d6:	4701                	li	a4,0
     5d8:	4681                	li	a3,0
     5da:	f9043603          	ld	a2,-112(s0)
     5de:	f9843583          	ld	a1,-104(s0)
     5e2:	8552                	mv	a0,s4
     5e4:	00000097          	auipc	ra,0x0
     5e8:	cda080e7          	jalr	-806(ra) # 2be <redircmd>
     5ec:	8a2a                	mv	s4,a0
    switch(tok){
     5ee:	03e00b13          	li	s6,62
     5f2:	02b00a93          	li	s5,43
  while(peek(ps, es, "<>")){
     5f6:	865e                	mv	a2,s7
     5f8:	85ca                	mv	a1,s2
     5fa:	854e                	mv	a0,s3
     5fc:	00000097          	auipc	ra,0x0
     600:	f2e080e7          	jalr	-210(ra) # 52a <peek>
     604:	c925                	beqz	a0,674 <parseredirs+0xe0>
    tok = gettoken(ps, es, 0, 0);
     606:	4681                	li	a3,0
     608:	4601                	li	a2,0
     60a:	85ca                	mv	a1,s2
     60c:	854e                	mv	a0,s3
     60e:	00000097          	auipc	ra,0x0
     612:	de0080e7          	jalr	-544(ra) # 3ee <gettoken>
     616:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
     618:	f9040693          	addi	a3,s0,-112
     61c:	f9840613          	addi	a2,s0,-104
     620:	85ca                	mv	a1,s2
     622:	854e                	mv	a0,s3
     624:	00000097          	auipc	ra,0x0
     628:	dca080e7          	jalr	-566(ra) # 3ee <gettoken>
     62c:	f9851de3          	bne	a0,s8,5c6 <parseredirs+0x32>
    switch(tok){
     630:	fb9483e3          	beq	s1,s9,5d6 <parseredirs+0x42>
     634:	03648263          	beq	s1,s6,658 <parseredirs+0xc4>
     638:	fb549fe3          	bne	s1,s5,5f6 <parseredirs+0x62>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     63c:	4705                	li	a4,1
     63e:	20100693          	li	a3,513
     642:	f9043603          	ld	a2,-112(s0)
     646:	f9843583          	ld	a1,-104(s0)
     64a:	8552                	mv	a0,s4
     64c:	00000097          	auipc	ra,0x0
     650:	c72080e7          	jalr	-910(ra) # 2be <redircmd>
     654:	8a2a                	mv	s4,a0
      break;
     656:	bf61                	j	5ee <parseredirs+0x5a>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     658:	4705                	li	a4,1
     65a:	60100693          	li	a3,1537
     65e:	f9043603          	ld	a2,-112(s0)
     662:	f9843583          	ld	a1,-104(s0)
     666:	8552                	mv	a0,s4
     668:	00000097          	auipc	ra,0x0
     66c:	c56080e7          	jalr	-938(ra) # 2be <redircmd>
     670:	8a2a                	mv	s4,a0
      break;
     672:	bfb5                	j	5ee <parseredirs+0x5a>
    }
  }
  return cmd;
}
     674:	8552                	mv	a0,s4
     676:	70a6                	ld	ra,104(sp)
     678:	7406                	ld	s0,96(sp)
     67a:	64e6                	ld	s1,88(sp)
     67c:	6946                	ld	s2,80(sp)
     67e:	69a6                	ld	s3,72(sp)
     680:	6a06                	ld	s4,64(sp)
     682:	7ae2                	ld	s5,56(sp)
     684:	7b42                	ld	s6,48(sp)
     686:	7ba2                	ld	s7,40(sp)
     688:	7c02                	ld	s8,32(sp)
     68a:	6ce2                	ld	s9,24(sp)
     68c:	6165                	addi	sp,sp,112
     68e:	8082                	ret

0000000000000690 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     690:	7159                	addi	sp,sp,-112
     692:	f486                	sd	ra,104(sp)
     694:	f0a2                	sd	s0,96(sp)
     696:	eca6                	sd	s1,88(sp)
     698:	e8ca                	sd	s2,80(sp)
     69a:	e4ce                	sd	s3,72(sp)
     69c:	e0d2                	sd	s4,64(sp)
     69e:	fc56                	sd	s5,56(sp)
     6a0:	f85a                	sd	s6,48(sp)
     6a2:	f45e                	sd	s7,40(sp)
     6a4:	f062                	sd	s8,32(sp)
     6a6:	ec66                	sd	s9,24(sp)
     6a8:	1880                	addi	s0,sp,112
     6aa:	8a2a                	mv	s4,a0
     6ac:	8aae                	mv	s5,a1
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     6ae:	00001617          	auipc	a2,0x1
     6b2:	d0260613          	addi	a2,a2,-766 # 13b0 <malloc+0x154>
     6b6:	00000097          	auipc	ra,0x0
     6ba:	e74080e7          	jalr	-396(ra) # 52a <peek>
     6be:	e905                	bnez	a0,6ee <parseexec+0x5e>
     6c0:	89aa                	mv	s3,a0
    return parseblock(ps, es);

  ret = execcmd();
     6c2:	00000097          	auipc	ra,0x0
     6c6:	bc6080e7          	jalr	-1082(ra) # 288 <execcmd>
     6ca:	8c2a                	mv	s8,a0
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     6cc:	8656                	mv	a2,s5
     6ce:	85d2                	mv	a1,s4
     6d0:	00000097          	auipc	ra,0x0
     6d4:	ec4080e7          	jalr	-316(ra) # 594 <parseredirs>
     6d8:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     6da:	008c0913          	addi	s2,s8,8
     6de:	00001b17          	auipc	s6,0x1
     6e2:	cf2b0b13          	addi	s6,s6,-782 # 13d0 <malloc+0x174>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
     6e6:	06100c93          	li	s9,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
     6ea:	4ba9                	li	s7,10
  while(!peek(ps, es, "|)&;")){
     6ec:	a0b1                	j	738 <parseexec+0xa8>
    return parseblock(ps, es);
     6ee:	85d6                	mv	a1,s5
     6f0:	8552                	mv	a0,s4
     6f2:	00000097          	auipc	ra,0x0
     6f6:	1bc080e7          	jalr	444(ra) # 8ae <parseblock>
     6fa:	84aa                	mv	s1,a0
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     6fc:	8526                	mv	a0,s1
     6fe:	70a6                	ld	ra,104(sp)
     700:	7406                	ld	s0,96(sp)
     702:	64e6                	ld	s1,88(sp)
     704:	6946                	ld	s2,80(sp)
     706:	69a6                	ld	s3,72(sp)
     708:	6a06                	ld	s4,64(sp)
     70a:	7ae2                	ld	s5,56(sp)
     70c:	7b42                	ld	s6,48(sp)
     70e:	7ba2                	ld	s7,40(sp)
     710:	7c02                	ld	s8,32(sp)
     712:	6ce2                	ld	s9,24(sp)
     714:	6165                	addi	sp,sp,112
     716:	8082                	ret
      panic("syntax");
     718:	00001517          	auipc	a0,0x1
     71c:	ca050513          	addi	a0,a0,-864 # 13b8 <malloc+0x15c>
     720:	00000097          	auipc	ra,0x0
     724:	936080e7          	jalr	-1738(ra) # 56 <panic>
    ret = parseredirs(ret, ps, es);
     728:	8656                	mv	a2,s5
     72a:	85d2                	mv	a1,s4
     72c:	8526                	mv	a0,s1
     72e:	00000097          	auipc	ra,0x0
     732:	e66080e7          	jalr	-410(ra) # 594 <parseredirs>
     736:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     738:	865a                	mv	a2,s6
     73a:	85d6                	mv	a1,s5
     73c:	8552                	mv	a0,s4
     73e:	00000097          	auipc	ra,0x0
     742:	dec080e7          	jalr	-532(ra) # 52a <peek>
     746:	e131                	bnez	a0,78a <parseexec+0xfa>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     748:	f9040693          	addi	a3,s0,-112
     74c:	f9840613          	addi	a2,s0,-104
     750:	85d6                	mv	a1,s5
     752:	8552                	mv	a0,s4
     754:	00000097          	auipc	ra,0x0
     758:	c9a080e7          	jalr	-870(ra) # 3ee <gettoken>
     75c:	c51d                	beqz	a0,78a <parseexec+0xfa>
    if(tok != 'a')
     75e:	fb951de3          	bne	a0,s9,718 <parseexec+0x88>
    cmd->argv[argc] = q;
     762:	f9843783          	ld	a5,-104(s0)
     766:	00f93023          	sd	a5,0(s2)
    cmd->eargv[argc] = eq;
     76a:	f9043783          	ld	a5,-112(s0)
     76e:	04f93823          	sd	a5,80(s2)
    argc++;
     772:	2985                	addiw	s3,s3,1
    if(argc >= MAXARGS)
     774:	0921                	addi	s2,s2,8
     776:	fb7999e3          	bne	s3,s7,728 <parseexec+0x98>
      panic("too many args");
     77a:	00001517          	auipc	a0,0x1
     77e:	c4650513          	addi	a0,a0,-954 # 13c0 <malloc+0x164>
     782:	00000097          	auipc	ra,0x0
     786:	8d4080e7          	jalr	-1836(ra) # 56 <panic>
  cmd->argv[argc] = 0;
     78a:	098e                	slli	s3,s3,0x3
     78c:	99e2                	add	s3,s3,s8
     78e:	0009b423          	sd	zero,8(s3)
  cmd->eargv[argc] = 0;
     792:	0409bc23          	sd	zero,88(s3)
  return ret;
     796:	b79d                	j	6fc <parseexec+0x6c>

0000000000000798 <parsepipe>:
{
     798:	7179                	addi	sp,sp,-48
     79a:	f406                	sd	ra,40(sp)
     79c:	f022                	sd	s0,32(sp)
     79e:	ec26                	sd	s1,24(sp)
     7a0:	e84a                	sd	s2,16(sp)
     7a2:	e44e                	sd	s3,8(sp)
     7a4:	1800                	addi	s0,sp,48
     7a6:	892a                	mv	s2,a0
     7a8:	89ae                	mv	s3,a1
  cmd = parseexec(ps, es);
     7aa:	00000097          	auipc	ra,0x0
     7ae:	ee6080e7          	jalr	-282(ra) # 690 <parseexec>
     7b2:	84aa                	mv	s1,a0
  if(peek(ps, es, "|")){
     7b4:	00001617          	auipc	a2,0x1
     7b8:	c2460613          	addi	a2,a2,-988 # 13d8 <malloc+0x17c>
     7bc:	85ce                	mv	a1,s3
     7be:	854a                	mv	a0,s2
     7c0:	00000097          	auipc	ra,0x0
     7c4:	d6a080e7          	jalr	-662(ra) # 52a <peek>
     7c8:	e909                	bnez	a0,7da <parsepipe+0x42>
}
     7ca:	8526                	mv	a0,s1
     7cc:	70a2                	ld	ra,40(sp)
     7ce:	7402                	ld	s0,32(sp)
     7d0:	64e2                	ld	s1,24(sp)
     7d2:	6942                	ld	s2,16(sp)
     7d4:	69a2                	ld	s3,8(sp)
     7d6:	6145                	addi	sp,sp,48
     7d8:	8082                	ret
    gettoken(ps, es, 0, 0);
     7da:	4681                	li	a3,0
     7dc:	4601                	li	a2,0
     7de:	85ce                	mv	a1,s3
     7e0:	854a                	mv	a0,s2
     7e2:	00000097          	auipc	ra,0x0
     7e6:	c0c080e7          	jalr	-1012(ra) # 3ee <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     7ea:	85ce                	mv	a1,s3
     7ec:	854a                	mv	a0,s2
     7ee:	00000097          	auipc	ra,0x0
     7f2:	faa080e7          	jalr	-86(ra) # 798 <parsepipe>
     7f6:	85aa                	mv	a1,a0
     7f8:	8526                	mv	a0,s1
     7fa:	00000097          	auipc	ra,0x0
     7fe:	b2c080e7          	jalr	-1236(ra) # 326 <pipecmd>
     802:	84aa                	mv	s1,a0
  return cmd;
     804:	b7d9                	j	7ca <parsepipe+0x32>

0000000000000806 <parseline>:
{
     806:	7179                	addi	sp,sp,-48
     808:	f406                	sd	ra,40(sp)
     80a:	f022                	sd	s0,32(sp)
     80c:	ec26                	sd	s1,24(sp)
     80e:	e84a                	sd	s2,16(sp)
     810:	e44e                	sd	s3,8(sp)
     812:	e052                	sd	s4,0(sp)
     814:	1800                	addi	s0,sp,48
     816:	892a                	mv	s2,a0
     818:	89ae                	mv	s3,a1
  cmd = parsepipe(ps, es);
     81a:	00000097          	auipc	ra,0x0
     81e:	f7e080e7          	jalr	-130(ra) # 798 <parsepipe>
     822:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     824:	00001a17          	auipc	s4,0x1
     828:	bbca0a13          	addi	s4,s4,-1092 # 13e0 <malloc+0x184>
     82c:	a839                	j	84a <parseline+0x44>
    gettoken(ps, es, 0, 0);
     82e:	4681                	li	a3,0
     830:	4601                	li	a2,0
     832:	85ce                	mv	a1,s3
     834:	854a                	mv	a0,s2
     836:	00000097          	auipc	ra,0x0
     83a:	bb8080e7          	jalr	-1096(ra) # 3ee <gettoken>
    cmd = backcmd(cmd);
     83e:	8526                	mv	a0,s1
     840:	00000097          	auipc	ra,0x0
     844:	b72080e7          	jalr	-1166(ra) # 3b2 <backcmd>
     848:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     84a:	8652                	mv	a2,s4
     84c:	85ce                	mv	a1,s3
     84e:	854a                	mv	a0,s2
     850:	00000097          	auipc	ra,0x0
     854:	cda080e7          	jalr	-806(ra) # 52a <peek>
     858:	f979                	bnez	a0,82e <parseline+0x28>
  if(peek(ps, es, ";")){
     85a:	00001617          	auipc	a2,0x1
     85e:	b8e60613          	addi	a2,a2,-1138 # 13e8 <malloc+0x18c>
     862:	85ce                	mv	a1,s3
     864:	854a                	mv	a0,s2
     866:	00000097          	auipc	ra,0x0
     86a:	cc4080e7          	jalr	-828(ra) # 52a <peek>
     86e:	e911                	bnez	a0,882 <parseline+0x7c>
}
     870:	8526                	mv	a0,s1
     872:	70a2                	ld	ra,40(sp)
     874:	7402                	ld	s0,32(sp)
     876:	64e2                	ld	s1,24(sp)
     878:	6942                	ld	s2,16(sp)
     87a:	69a2                	ld	s3,8(sp)
     87c:	6a02                	ld	s4,0(sp)
     87e:	6145                	addi	sp,sp,48
     880:	8082                	ret
    gettoken(ps, es, 0, 0);
     882:	4681                	li	a3,0
     884:	4601                	li	a2,0
     886:	85ce                	mv	a1,s3
     888:	854a                	mv	a0,s2
     88a:	00000097          	auipc	ra,0x0
     88e:	b64080e7          	jalr	-1180(ra) # 3ee <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     892:	85ce                	mv	a1,s3
     894:	854a                	mv	a0,s2
     896:	00000097          	auipc	ra,0x0
     89a:	f70080e7          	jalr	-144(ra) # 806 <parseline>
     89e:	85aa                	mv	a1,a0
     8a0:	8526                	mv	a0,s1
     8a2:	00000097          	auipc	ra,0x0
     8a6:	aca080e7          	jalr	-1334(ra) # 36c <listcmd>
     8aa:	84aa                	mv	s1,a0
  return cmd;
     8ac:	b7d1                	j	870 <parseline+0x6a>

00000000000008ae <parseblock>:
{
     8ae:	7179                	addi	sp,sp,-48
     8b0:	f406                	sd	ra,40(sp)
     8b2:	f022                	sd	s0,32(sp)
     8b4:	ec26                	sd	s1,24(sp)
     8b6:	e84a                	sd	s2,16(sp)
     8b8:	e44e                	sd	s3,8(sp)
     8ba:	1800                	addi	s0,sp,48
     8bc:	84aa                	mv	s1,a0
     8be:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
     8c0:	00001617          	auipc	a2,0x1
     8c4:	af060613          	addi	a2,a2,-1296 # 13b0 <malloc+0x154>
     8c8:	00000097          	auipc	ra,0x0
     8cc:	c62080e7          	jalr	-926(ra) # 52a <peek>
     8d0:	c12d                	beqz	a0,932 <parseblock+0x84>
  gettoken(ps, es, 0, 0);
     8d2:	4681                	li	a3,0
     8d4:	4601                	li	a2,0
     8d6:	85ca                	mv	a1,s2
     8d8:	8526                	mv	a0,s1
     8da:	00000097          	auipc	ra,0x0
     8de:	b14080e7          	jalr	-1260(ra) # 3ee <gettoken>
  cmd = parseline(ps, es);
     8e2:	85ca                	mv	a1,s2
     8e4:	8526                	mv	a0,s1
     8e6:	00000097          	auipc	ra,0x0
     8ea:	f20080e7          	jalr	-224(ra) # 806 <parseline>
     8ee:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
     8f0:	00001617          	auipc	a2,0x1
     8f4:	b1060613          	addi	a2,a2,-1264 # 1400 <malloc+0x1a4>
     8f8:	85ca                	mv	a1,s2
     8fa:	8526                	mv	a0,s1
     8fc:	00000097          	auipc	ra,0x0
     900:	c2e080e7          	jalr	-978(ra) # 52a <peek>
     904:	cd1d                	beqz	a0,942 <parseblock+0x94>
  gettoken(ps, es, 0, 0);
     906:	4681                	li	a3,0
     908:	4601                	li	a2,0
     90a:	85ca                	mv	a1,s2
     90c:	8526                	mv	a0,s1
     90e:	00000097          	auipc	ra,0x0
     912:	ae0080e7          	jalr	-1312(ra) # 3ee <gettoken>
  cmd = parseredirs(cmd, ps, es);
     916:	864a                	mv	a2,s2
     918:	85a6                	mv	a1,s1
     91a:	854e                	mv	a0,s3
     91c:	00000097          	auipc	ra,0x0
     920:	c78080e7          	jalr	-904(ra) # 594 <parseredirs>
}
     924:	70a2                	ld	ra,40(sp)
     926:	7402                	ld	s0,32(sp)
     928:	64e2                	ld	s1,24(sp)
     92a:	6942                	ld	s2,16(sp)
     92c:	69a2                	ld	s3,8(sp)
     92e:	6145                	addi	sp,sp,48
     930:	8082                	ret
    panic("parseblock");
     932:	00001517          	auipc	a0,0x1
     936:	abe50513          	addi	a0,a0,-1346 # 13f0 <malloc+0x194>
     93a:	fffff097          	auipc	ra,0xfffff
     93e:	71c080e7          	jalr	1820(ra) # 56 <panic>
    panic("syntax - missing )");
     942:	00001517          	auipc	a0,0x1
     946:	ac650513          	addi	a0,a0,-1338 # 1408 <malloc+0x1ac>
     94a:	fffff097          	auipc	ra,0xfffff
     94e:	70c080e7          	jalr	1804(ra) # 56 <panic>

0000000000000952 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     952:	1101                	addi	sp,sp,-32
     954:	ec06                	sd	ra,24(sp)
     956:	e822                	sd	s0,16(sp)
     958:	e426                	sd	s1,8(sp)
     95a:	1000                	addi	s0,sp,32
     95c:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     95e:	c521                	beqz	a0,9a6 <nulterminate+0x54>
    return 0;

  switch(cmd->type){
     960:	4118                	lw	a4,0(a0)
     962:	4795                	li	a5,5
     964:	04e7e163          	bltu	a5,a4,9a6 <nulterminate+0x54>
     968:	00056783          	lwu	a5,0(a0)
     96c:	078a                	slli	a5,a5,0x2
     96e:	00001717          	auipc	a4,0x1
     972:	afa70713          	addi	a4,a4,-1286 # 1468 <malloc+0x20c>
     976:	97ba                	add	a5,a5,a4
     978:	439c                	lw	a5,0(a5)
     97a:	97ba                	add	a5,a5,a4
     97c:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     97e:	651c                	ld	a5,8(a0)
     980:	c39d                	beqz	a5,9a6 <nulterminate+0x54>
     982:	01050793          	addi	a5,a0,16
      *ecmd->eargv[i] = 0;
     986:	67b8                	ld	a4,72(a5)
     988:	00070023          	sb	zero,0(a4)
    for(i=0; ecmd->argv[i]; i++)
     98c:	07a1                	addi	a5,a5,8
     98e:	ff87b703          	ld	a4,-8(a5)
     992:	fb75                	bnez	a4,986 <nulterminate+0x34>
     994:	a809                	j	9a6 <nulterminate+0x54>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     996:	6508                	ld	a0,8(a0)
     998:	00000097          	auipc	ra,0x0
     99c:	fba080e7          	jalr	-70(ra) # 952 <nulterminate>
    *rcmd->efile = 0;
     9a0:	6c9c                	ld	a5,24(s1)
     9a2:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     9a6:	8526                	mv	a0,s1
     9a8:	60e2                	ld	ra,24(sp)
     9aa:	6442                	ld	s0,16(sp)
     9ac:	64a2                	ld	s1,8(sp)
     9ae:	6105                	addi	sp,sp,32
     9b0:	8082                	ret
    nulterminate(pcmd->left);
     9b2:	6508                	ld	a0,8(a0)
     9b4:	00000097          	auipc	ra,0x0
     9b8:	f9e080e7          	jalr	-98(ra) # 952 <nulterminate>
    nulterminate(pcmd->right);
     9bc:	6888                	ld	a0,16(s1)
     9be:	00000097          	auipc	ra,0x0
     9c2:	f94080e7          	jalr	-108(ra) # 952 <nulterminate>
    break;
     9c6:	b7c5                	j	9a6 <nulterminate+0x54>
    nulterminate(lcmd->left);
     9c8:	6508                	ld	a0,8(a0)
     9ca:	00000097          	auipc	ra,0x0
     9ce:	f88080e7          	jalr	-120(ra) # 952 <nulterminate>
    nulterminate(lcmd->right);
     9d2:	6888                	ld	a0,16(s1)
     9d4:	00000097          	auipc	ra,0x0
     9d8:	f7e080e7          	jalr	-130(ra) # 952 <nulterminate>
    break;
     9dc:	b7e9                	j	9a6 <nulterminate+0x54>
    nulterminate(bcmd->cmd);
     9de:	6508                	ld	a0,8(a0)
     9e0:	00000097          	auipc	ra,0x0
     9e4:	f72080e7          	jalr	-142(ra) # 952 <nulterminate>
    break;
     9e8:	bf7d                	j	9a6 <nulterminate+0x54>

00000000000009ea <parsecmd>:
{
     9ea:	7179                	addi	sp,sp,-48
     9ec:	f406                	sd	ra,40(sp)
     9ee:	f022                	sd	s0,32(sp)
     9f0:	ec26                	sd	s1,24(sp)
     9f2:	e84a                	sd	s2,16(sp)
     9f4:	1800                	addi	s0,sp,48
     9f6:	fca43c23          	sd	a0,-40(s0)
  es = s + strlen(s);
     9fa:	84aa                	mv	s1,a0
     9fc:	00000097          	auipc	ra,0x0
     a00:	1ec080e7          	jalr	492(ra) # be8 <strlen>
     a04:	1502                	slli	a0,a0,0x20
     a06:	9101                	srli	a0,a0,0x20
     a08:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
     a0a:	85a6                	mv	a1,s1
     a0c:	fd840513          	addi	a0,s0,-40
     a10:	00000097          	auipc	ra,0x0
     a14:	df6080e7          	jalr	-522(ra) # 806 <parseline>
     a18:	892a                	mv	s2,a0
  peek(&s, es, "");
     a1a:	00001617          	auipc	a2,0x1
     a1e:	a0660613          	addi	a2,a2,-1530 # 1420 <malloc+0x1c4>
     a22:	85a6                	mv	a1,s1
     a24:	fd840513          	addi	a0,s0,-40
     a28:	00000097          	auipc	ra,0x0
     a2c:	b02080e7          	jalr	-1278(ra) # 52a <peek>
  if(s != es){
     a30:	fd843603          	ld	a2,-40(s0)
     a34:	00961e63          	bne	a2,s1,a50 <parsecmd+0x66>
  nulterminate(cmd);
     a38:	854a                	mv	a0,s2
     a3a:	00000097          	auipc	ra,0x0
     a3e:	f18080e7          	jalr	-232(ra) # 952 <nulterminate>
}
     a42:	854a                	mv	a0,s2
     a44:	70a2                	ld	ra,40(sp)
     a46:	7402                	ld	s0,32(sp)
     a48:	64e2                	ld	s1,24(sp)
     a4a:	6942                	ld	s2,16(sp)
     a4c:	6145                	addi	sp,sp,48
     a4e:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
     a50:	00001597          	auipc	a1,0x1
     a54:	9d858593          	addi	a1,a1,-1576 # 1428 <malloc+0x1cc>
     a58:	4509                	li	a0,2
     a5a:	00000097          	auipc	ra,0x0
     a5e:	716080e7          	jalr	1814(ra) # 1170 <fprintf>
    panic("syntax");
     a62:	00001517          	auipc	a0,0x1
     a66:	95650513          	addi	a0,a0,-1706 # 13b8 <malloc+0x15c>
     a6a:	fffff097          	auipc	ra,0xfffff
     a6e:	5ec080e7          	jalr	1516(ra) # 56 <panic>

0000000000000a72 <main>:
{
     a72:	711d                	addi	sp,sp,-96
     a74:	ec86                	sd	ra,88(sp)
     a76:	e8a2                	sd	s0,80(sp)
     a78:	e4a6                	sd	s1,72(sp)
     a7a:	e0ca                	sd	s2,64(sp)
     a7c:	fc4e                	sd	s3,56(sp)
     a7e:	f852                	sd	s4,48(sp)
     a80:	f456                	sd	s5,40(sp)
     a82:	f05a                	sd	s6,32(sp)
     a84:	1080                	addi	s0,sp,96
  while((fd = open("console", O_RDWR)) >= 0){
     a86:	00001497          	auipc	s1,0x1
     a8a:	9b248493          	addi	s1,s1,-1614 # 1438 <malloc+0x1dc>
     a8e:	4589                	li	a1,2
     a90:	8526                	mv	a0,s1
     a92:	00000097          	auipc	ra,0x0
     a96:	3bc080e7          	jalr	956(ra) # e4e <open>
     a9a:	00054963          	bltz	a0,aac <main+0x3a>
    if(fd >= 3){
     a9e:	4789                	li	a5,2
     aa0:	fea7d7e3          	bge	a5,a0,a8e <main+0x1c>
      close(fd);
     aa4:	00000097          	auipc	ra,0x0
     aa8:	392080e7          	jalr	914(ra) # e36 <close>
  while(getcmd(buf, sizeof(buf)) >= 0){
     aac:	00001497          	auipc	s1,0x1
     ab0:	57448493          	addi	s1,s1,1396 # 2020 <buf.0>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     ab4:	06300913          	li	s2,99
    printf("%s\n",msg);
     ab8:	00001997          	auipc	s3,0x1
     abc:	89098993          	addi	s3,s3,-1904 # 1348 <malloc+0xec>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     ac0:	02000a13          	li	s4,32
      if(chdir(buf+3) < 0)
     ac4:	00001a97          	auipc	s5,0x1
     ac8:	55fa8a93          	addi	s5,s5,1375 # 2023 <buf.0+0x3>
        fprintf(2, "cannot cd %s\n", buf+3);
     acc:	00001b17          	auipc	s6,0x1
     ad0:	974b0b13          	addi	s6,s6,-1676 # 1440 <malloc+0x1e4>
     ad4:	a025                	j	afc <main+0x8a>
    if(fork1() == 0)
     ad6:	fffff097          	auipc	ra,0xfffff
     ada:	5a8080e7          	jalr	1448(ra) # 7e <fork1>
     ade:	c149                	beqz	a0,b60 <main+0xee>
    wait(0,msg);
     ae0:	fa040593          	addi	a1,s0,-96
     ae4:	4501                	li	a0,0
     ae6:	00000097          	auipc	ra,0x0
     aea:	330080e7          	jalr	816(ra) # e16 <wait>
    printf("%s\n",msg);
     aee:	fa040593          	addi	a1,s0,-96
     af2:	854e                	mv	a0,s3
     af4:	00000097          	auipc	ra,0x0
     af8:	6aa080e7          	jalr	1706(ra) # 119e <printf>
  while(getcmd(buf, sizeof(buf)) >= 0){
     afc:	06400593          	li	a1,100
     b00:	8526                	mv	a0,s1
     b02:	fffff097          	auipc	ra,0xfffff
     b06:	4fe080e7          	jalr	1278(ra) # 0 <getcmd>
     b0a:	06054763          	bltz	a0,b78 <main+0x106>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     b0e:	0004c783          	lbu	a5,0(s1)
     b12:	fd2792e3          	bne	a5,s2,ad6 <main+0x64>
     b16:	0014c703          	lbu	a4,1(s1)
     b1a:	06400793          	li	a5,100
     b1e:	faf71ce3          	bne	a4,a5,ad6 <main+0x64>
     b22:	0024c783          	lbu	a5,2(s1)
     b26:	fb4798e3          	bne	a5,s4,ad6 <main+0x64>
      buf[strlen(buf)-1] = 0;  // chop \n
     b2a:	8526                	mv	a0,s1
     b2c:	00000097          	auipc	ra,0x0
     b30:	0bc080e7          	jalr	188(ra) # be8 <strlen>
     b34:	fff5079b          	addiw	a5,a0,-1
     b38:	1782                	slli	a5,a5,0x20
     b3a:	9381                	srli	a5,a5,0x20
     b3c:	97a6                	add	a5,a5,s1
     b3e:	00078023          	sb	zero,0(a5)
      if(chdir(buf+3) < 0)
     b42:	8556                	mv	a0,s5
     b44:	00000097          	auipc	ra,0x0
     b48:	33a080e7          	jalr	826(ra) # e7e <chdir>
     b4c:	fa0558e3          	bgez	a0,afc <main+0x8a>
        fprintf(2, "cannot cd %s\n", buf+3);
     b50:	8656                	mv	a2,s5
     b52:	85da                	mv	a1,s6
     b54:	4509                	li	a0,2
     b56:	00000097          	auipc	ra,0x0
     b5a:	61a080e7          	jalr	1562(ra) # 1170 <fprintf>
      continue;
     b5e:	bf79                	j	afc <main+0x8a>
      runcmd(parsecmd(buf));
     b60:	00001517          	auipc	a0,0x1
     b64:	4c050513          	addi	a0,a0,1216 # 2020 <buf.0>
     b68:	00000097          	auipc	ra,0x0
     b6c:	e82080e7          	jalr	-382(ra) # 9ea <parsecmd>
     b70:	fffff097          	auipc	ra,0xfffff
     b74:	53c080e7          	jalr	1340(ra) # ac <runcmd>
  exit(0,0);
     b78:	4581                	li	a1,0
     b7a:	4501                	li	a0,0
     b7c:	00000097          	auipc	ra,0x0
     b80:	292080e7          	jalr	658(ra) # e0e <exit>

0000000000000b84 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
     b84:	1141                	addi	sp,sp,-16
     b86:	e406                	sd	ra,8(sp)
     b88:	e022                	sd	s0,0(sp)
     b8a:	0800                	addi	s0,sp,16
  extern int main();
  main();
     b8c:	00000097          	auipc	ra,0x0
     b90:	ee6080e7          	jalr	-282(ra) # a72 <main>
  exit(0,0);
     b94:	4581                	li	a1,0
     b96:	4501                	li	a0,0
     b98:	00000097          	auipc	ra,0x0
     b9c:	276080e7          	jalr	630(ra) # e0e <exit>

0000000000000ba0 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     ba0:	1141                	addi	sp,sp,-16
     ba2:	e422                	sd	s0,8(sp)
     ba4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     ba6:	87aa                	mv	a5,a0
     ba8:	0585                	addi	a1,a1,1
     baa:	0785                	addi	a5,a5,1
     bac:	fff5c703          	lbu	a4,-1(a1)
     bb0:	fee78fa3          	sb	a4,-1(a5)
     bb4:	fb75                	bnez	a4,ba8 <strcpy+0x8>
    ;
  return os;
}
     bb6:	6422                	ld	s0,8(sp)
     bb8:	0141                	addi	sp,sp,16
     bba:	8082                	ret

0000000000000bbc <strcmp>:

int
strcmp(const char *p, const char *q)
{
     bbc:	1141                	addi	sp,sp,-16
     bbe:	e422                	sd	s0,8(sp)
     bc0:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     bc2:	00054783          	lbu	a5,0(a0)
     bc6:	cb91                	beqz	a5,bda <strcmp+0x1e>
     bc8:	0005c703          	lbu	a4,0(a1)
     bcc:	00f71763          	bne	a4,a5,bda <strcmp+0x1e>
    p++, q++;
     bd0:	0505                	addi	a0,a0,1
     bd2:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     bd4:	00054783          	lbu	a5,0(a0)
     bd8:	fbe5                	bnez	a5,bc8 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     bda:	0005c503          	lbu	a0,0(a1)
}
     bde:	40a7853b          	subw	a0,a5,a0
     be2:	6422                	ld	s0,8(sp)
     be4:	0141                	addi	sp,sp,16
     be6:	8082                	ret

0000000000000be8 <strlen>:

uint
strlen(const char *s)
{
     be8:	1141                	addi	sp,sp,-16
     bea:	e422                	sd	s0,8(sp)
     bec:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     bee:	00054783          	lbu	a5,0(a0)
     bf2:	cf91                	beqz	a5,c0e <strlen+0x26>
     bf4:	0505                	addi	a0,a0,1
     bf6:	87aa                	mv	a5,a0
     bf8:	4685                	li	a3,1
     bfa:	9e89                	subw	a3,a3,a0
     bfc:	00f6853b          	addw	a0,a3,a5
     c00:	0785                	addi	a5,a5,1
     c02:	fff7c703          	lbu	a4,-1(a5)
     c06:	fb7d                	bnez	a4,bfc <strlen+0x14>
    ;
  return n;
}
     c08:	6422                	ld	s0,8(sp)
     c0a:	0141                	addi	sp,sp,16
     c0c:	8082                	ret
  for(n = 0; s[n]; n++)
     c0e:	4501                	li	a0,0
     c10:	bfe5                	j	c08 <strlen+0x20>

0000000000000c12 <memset>:

void*
memset(void *dst, int c, uint n)
{
     c12:	1141                	addi	sp,sp,-16
     c14:	e422                	sd	s0,8(sp)
     c16:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     c18:	ca19                	beqz	a2,c2e <memset+0x1c>
     c1a:	87aa                	mv	a5,a0
     c1c:	1602                	slli	a2,a2,0x20
     c1e:	9201                	srli	a2,a2,0x20
     c20:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     c24:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     c28:	0785                	addi	a5,a5,1
     c2a:	fee79de3          	bne	a5,a4,c24 <memset+0x12>
  }
  return dst;
}
     c2e:	6422                	ld	s0,8(sp)
     c30:	0141                	addi	sp,sp,16
     c32:	8082                	ret

0000000000000c34 <strchr>:

char*
strchr(const char *s, char c)
{
     c34:	1141                	addi	sp,sp,-16
     c36:	e422                	sd	s0,8(sp)
     c38:	0800                	addi	s0,sp,16
  for(; *s; s++)
     c3a:	00054783          	lbu	a5,0(a0)
     c3e:	cb99                	beqz	a5,c54 <strchr+0x20>
    if(*s == c)
     c40:	00f58763          	beq	a1,a5,c4e <strchr+0x1a>
  for(; *s; s++)
     c44:	0505                	addi	a0,a0,1
     c46:	00054783          	lbu	a5,0(a0)
     c4a:	fbfd                	bnez	a5,c40 <strchr+0xc>
      return (char*)s;
  return 0;
     c4c:	4501                	li	a0,0
}
     c4e:	6422                	ld	s0,8(sp)
     c50:	0141                	addi	sp,sp,16
     c52:	8082                	ret
  return 0;
     c54:	4501                	li	a0,0
     c56:	bfe5                	j	c4e <strchr+0x1a>

0000000000000c58 <gets>:

char*
gets(char *buf, int max)
{
     c58:	711d                	addi	sp,sp,-96
     c5a:	ec86                	sd	ra,88(sp)
     c5c:	e8a2                	sd	s0,80(sp)
     c5e:	e4a6                	sd	s1,72(sp)
     c60:	e0ca                	sd	s2,64(sp)
     c62:	fc4e                	sd	s3,56(sp)
     c64:	f852                	sd	s4,48(sp)
     c66:	f456                	sd	s5,40(sp)
     c68:	f05a                	sd	s6,32(sp)
     c6a:	ec5e                	sd	s7,24(sp)
     c6c:	1080                	addi	s0,sp,96
     c6e:	8baa                	mv	s7,a0
     c70:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c72:	892a                	mv	s2,a0
     c74:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     c76:	4aa9                	li	s5,10
     c78:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     c7a:	89a6                	mv	s3,s1
     c7c:	2485                	addiw	s1,s1,1
     c7e:	0344d863          	bge	s1,s4,cae <gets+0x56>
    cc = read(0, &c, 1);
     c82:	4605                	li	a2,1
     c84:	faf40593          	addi	a1,s0,-81
     c88:	4501                	li	a0,0
     c8a:	00000097          	auipc	ra,0x0
     c8e:	19c080e7          	jalr	412(ra) # e26 <read>
    if(cc < 1)
     c92:	00a05e63          	blez	a0,cae <gets+0x56>
    buf[i++] = c;
     c96:	faf44783          	lbu	a5,-81(s0)
     c9a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     c9e:	01578763          	beq	a5,s5,cac <gets+0x54>
     ca2:	0905                	addi	s2,s2,1
     ca4:	fd679be3          	bne	a5,s6,c7a <gets+0x22>
  for(i=0; i+1 < max; ){
     ca8:	89a6                	mv	s3,s1
     caa:	a011                	j	cae <gets+0x56>
     cac:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     cae:	99de                	add	s3,s3,s7
     cb0:	00098023          	sb	zero,0(s3)
  return buf;
}
     cb4:	855e                	mv	a0,s7
     cb6:	60e6                	ld	ra,88(sp)
     cb8:	6446                	ld	s0,80(sp)
     cba:	64a6                	ld	s1,72(sp)
     cbc:	6906                	ld	s2,64(sp)
     cbe:	79e2                	ld	s3,56(sp)
     cc0:	7a42                	ld	s4,48(sp)
     cc2:	7aa2                	ld	s5,40(sp)
     cc4:	7b02                	ld	s6,32(sp)
     cc6:	6be2                	ld	s7,24(sp)
     cc8:	6125                	addi	sp,sp,96
     cca:	8082                	ret

0000000000000ccc <stat>:

int
stat(const char *n, struct stat *st)
{
     ccc:	1101                	addi	sp,sp,-32
     cce:	ec06                	sd	ra,24(sp)
     cd0:	e822                	sd	s0,16(sp)
     cd2:	e426                	sd	s1,8(sp)
     cd4:	e04a                	sd	s2,0(sp)
     cd6:	1000                	addi	s0,sp,32
     cd8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     cda:	4581                	li	a1,0
     cdc:	00000097          	auipc	ra,0x0
     ce0:	172080e7          	jalr	370(ra) # e4e <open>
  if(fd < 0)
     ce4:	02054563          	bltz	a0,d0e <stat+0x42>
     ce8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     cea:	85ca                	mv	a1,s2
     cec:	00000097          	auipc	ra,0x0
     cf0:	17a080e7          	jalr	378(ra) # e66 <fstat>
     cf4:	892a                	mv	s2,a0
  close(fd);
     cf6:	8526                	mv	a0,s1
     cf8:	00000097          	auipc	ra,0x0
     cfc:	13e080e7          	jalr	318(ra) # e36 <close>
  return r;
}
     d00:	854a                	mv	a0,s2
     d02:	60e2                	ld	ra,24(sp)
     d04:	6442                	ld	s0,16(sp)
     d06:	64a2                	ld	s1,8(sp)
     d08:	6902                	ld	s2,0(sp)
     d0a:	6105                	addi	sp,sp,32
     d0c:	8082                	ret
    return -1;
     d0e:	597d                	li	s2,-1
     d10:	bfc5                	j	d00 <stat+0x34>

0000000000000d12 <atoi>:

int
atoi(const char *s)
{
     d12:	1141                	addi	sp,sp,-16
     d14:	e422                	sd	s0,8(sp)
     d16:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     d18:	00054603          	lbu	a2,0(a0)
     d1c:	fd06079b          	addiw	a5,a2,-48
     d20:	0ff7f793          	andi	a5,a5,255
     d24:	4725                	li	a4,9
     d26:	02f76963          	bltu	a4,a5,d58 <atoi+0x46>
     d2a:	86aa                	mv	a3,a0
  n = 0;
     d2c:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
     d2e:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
     d30:	0685                	addi	a3,a3,1
     d32:	0025179b          	slliw	a5,a0,0x2
     d36:	9fa9                	addw	a5,a5,a0
     d38:	0017979b          	slliw	a5,a5,0x1
     d3c:	9fb1                	addw	a5,a5,a2
     d3e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     d42:	0006c603          	lbu	a2,0(a3)
     d46:	fd06071b          	addiw	a4,a2,-48
     d4a:	0ff77713          	andi	a4,a4,255
     d4e:	fee5f1e3          	bgeu	a1,a4,d30 <atoi+0x1e>
  return n;
}
     d52:	6422                	ld	s0,8(sp)
     d54:	0141                	addi	sp,sp,16
     d56:	8082                	ret
  n = 0;
     d58:	4501                	li	a0,0
     d5a:	bfe5                	j	d52 <atoi+0x40>

0000000000000d5c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     d5c:	1141                	addi	sp,sp,-16
     d5e:	e422                	sd	s0,8(sp)
     d60:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     d62:	02b57463          	bgeu	a0,a1,d8a <memmove+0x2e>
    while(n-- > 0)
     d66:	00c05f63          	blez	a2,d84 <memmove+0x28>
     d6a:	1602                	slli	a2,a2,0x20
     d6c:	9201                	srli	a2,a2,0x20
     d6e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     d72:	872a                	mv	a4,a0
      *dst++ = *src++;
     d74:	0585                	addi	a1,a1,1
     d76:	0705                	addi	a4,a4,1
     d78:	fff5c683          	lbu	a3,-1(a1)
     d7c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     d80:	fee79ae3          	bne	a5,a4,d74 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     d84:	6422                	ld	s0,8(sp)
     d86:	0141                	addi	sp,sp,16
     d88:	8082                	ret
    dst += n;
     d8a:	00c50733          	add	a4,a0,a2
    src += n;
     d8e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     d90:	fec05ae3          	blez	a2,d84 <memmove+0x28>
     d94:	fff6079b          	addiw	a5,a2,-1
     d98:	1782                	slli	a5,a5,0x20
     d9a:	9381                	srli	a5,a5,0x20
     d9c:	fff7c793          	not	a5,a5
     da0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     da2:	15fd                	addi	a1,a1,-1
     da4:	177d                	addi	a4,a4,-1
     da6:	0005c683          	lbu	a3,0(a1)
     daa:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     dae:	fee79ae3          	bne	a5,a4,da2 <memmove+0x46>
     db2:	bfc9                	j	d84 <memmove+0x28>

0000000000000db4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     db4:	1141                	addi	sp,sp,-16
     db6:	e422                	sd	s0,8(sp)
     db8:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     dba:	ca05                	beqz	a2,dea <memcmp+0x36>
     dbc:	fff6069b          	addiw	a3,a2,-1
     dc0:	1682                	slli	a3,a3,0x20
     dc2:	9281                	srli	a3,a3,0x20
     dc4:	0685                	addi	a3,a3,1
     dc6:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     dc8:	00054783          	lbu	a5,0(a0)
     dcc:	0005c703          	lbu	a4,0(a1)
     dd0:	00e79863          	bne	a5,a4,de0 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     dd4:	0505                	addi	a0,a0,1
    p2++;
     dd6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     dd8:	fed518e3          	bne	a0,a3,dc8 <memcmp+0x14>
  }
  return 0;
     ddc:	4501                	li	a0,0
     dde:	a019                	j	de4 <memcmp+0x30>
      return *p1 - *p2;
     de0:	40e7853b          	subw	a0,a5,a4
}
     de4:	6422                	ld	s0,8(sp)
     de6:	0141                	addi	sp,sp,16
     de8:	8082                	ret
  return 0;
     dea:	4501                	li	a0,0
     dec:	bfe5                	j	de4 <memcmp+0x30>

0000000000000dee <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     dee:	1141                	addi	sp,sp,-16
     df0:	e406                	sd	ra,8(sp)
     df2:	e022                	sd	s0,0(sp)
     df4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     df6:	00000097          	auipc	ra,0x0
     dfa:	f66080e7          	jalr	-154(ra) # d5c <memmove>
}
     dfe:	60a2                	ld	ra,8(sp)
     e00:	6402                	ld	s0,0(sp)
     e02:	0141                	addi	sp,sp,16
     e04:	8082                	ret

0000000000000e06 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     e06:	4885                	li	a7,1
 ecall
     e08:	00000073          	ecall
 ret
     e0c:	8082                	ret

0000000000000e0e <exit>:
.global exit
exit:
 li a7, SYS_exit
     e0e:	4889                	li	a7,2
 ecall
     e10:	00000073          	ecall
 ret
     e14:	8082                	ret

0000000000000e16 <wait>:
.global wait
wait:
 li a7, SYS_wait
     e16:	488d                	li	a7,3
 ecall
     e18:	00000073          	ecall
 ret
     e1c:	8082                	ret

0000000000000e1e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     e1e:	4891                	li	a7,4
 ecall
     e20:	00000073          	ecall
 ret
     e24:	8082                	ret

0000000000000e26 <read>:
.global read
read:
 li a7, SYS_read
     e26:	4895                	li	a7,5
 ecall
     e28:	00000073          	ecall
 ret
     e2c:	8082                	ret

0000000000000e2e <write>:
.global write
write:
 li a7, SYS_write
     e2e:	48c1                	li	a7,16
 ecall
     e30:	00000073          	ecall
 ret
     e34:	8082                	ret

0000000000000e36 <close>:
.global close
close:
 li a7, SYS_close
     e36:	48d5                	li	a7,21
 ecall
     e38:	00000073          	ecall
 ret
     e3c:	8082                	ret

0000000000000e3e <kill>:
.global kill
kill:
 li a7, SYS_kill
     e3e:	4899                	li	a7,6
 ecall
     e40:	00000073          	ecall
 ret
     e44:	8082                	ret

0000000000000e46 <exec>:
.global exec
exec:
 li a7, SYS_exec
     e46:	489d                	li	a7,7
 ecall
     e48:	00000073          	ecall
 ret
     e4c:	8082                	ret

0000000000000e4e <open>:
.global open
open:
 li a7, SYS_open
     e4e:	48bd                	li	a7,15
 ecall
     e50:	00000073          	ecall
 ret
     e54:	8082                	ret

0000000000000e56 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     e56:	48c5                	li	a7,17
 ecall
     e58:	00000073          	ecall
 ret
     e5c:	8082                	ret

0000000000000e5e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     e5e:	48c9                	li	a7,18
 ecall
     e60:	00000073          	ecall
 ret
     e64:	8082                	ret

0000000000000e66 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     e66:	48a1                	li	a7,8
 ecall
     e68:	00000073          	ecall
 ret
     e6c:	8082                	ret

0000000000000e6e <link>:
.global link
link:
 li a7, SYS_link
     e6e:	48cd                	li	a7,19
 ecall
     e70:	00000073          	ecall
 ret
     e74:	8082                	ret

0000000000000e76 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     e76:	48d1                	li	a7,20
 ecall
     e78:	00000073          	ecall
 ret
     e7c:	8082                	ret

0000000000000e7e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     e7e:	48a5                	li	a7,9
 ecall
     e80:	00000073          	ecall
 ret
     e84:	8082                	ret

0000000000000e86 <dup>:
.global dup
dup:
 li a7, SYS_dup
     e86:	48a9                	li	a7,10
 ecall
     e88:	00000073          	ecall
 ret
     e8c:	8082                	ret

0000000000000e8e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     e8e:	48ad                	li	a7,11
 ecall
     e90:	00000073          	ecall
 ret
     e94:	8082                	ret

0000000000000e96 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     e96:	48b1                	li	a7,12
 ecall
     e98:	00000073          	ecall
 ret
     e9c:	8082                	ret

0000000000000e9e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     e9e:	48b5                	li	a7,13
 ecall
     ea0:	00000073          	ecall
 ret
     ea4:	8082                	ret

0000000000000ea6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     ea6:	48b9                	li	a7,14
 ecall
     ea8:	00000073          	ecall
 ret
     eac:	8082                	ret

0000000000000eae <memsize>:
.global memsize
memsize:
 li a7, SYS_memsize
     eae:	48d9                	li	a7,22
 ecall
     eb0:	00000073          	ecall
 ret
     eb4:	8082                	ret

0000000000000eb6 <set_ps_priority>:
.global set_ps_priority
set_ps_priority:
 li a7, SYS_set_ps_priority
     eb6:	48dd                	li	a7,23
 ecall
     eb8:	00000073          	ecall
 ret
     ebc:	8082                	ret

0000000000000ebe <set_cfs_priority>:
.global set_cfs_priority
set_cfs_priority:
 li a7, SYS_set_cfs_priority
     ebe:	48e1                	li	a7,24
 ecall
     ec0:	00000073          	ecall
 ret
     ec4:	8082                	ret

0000000000000ec6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     ec6:	1101                	addi	sp,sp,-32
     ec8:	ec06                	sd	ra,24(sp)
     eca:	e822                	sd	s0,16(sp)
     ecc:	1000                	addi	s0,sp,32
     ece:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     ed2:	4605                	li	a2,1
     ed4:	fef40593          	addi	a1,s0,-17
     ed8:	00000097          	auipc	ra,0x0
     edc:	f56080e7          	jalr	-170(ra) # e2e <write>
}
     ee0:	60e2                	ld	ra,24(sp)
     ee2:	6442                	ld	s0,16(sp)
     ee4:	6105                	addi	sp,sp,32
     ee6:	8082                	ret

0000000000000ee8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     ee8:	7139                	addi	sp,sp,-64
     eea:	fc06                	sd	ra,56(sp)
     eec:	f822                	sd	s0,48(sp)
     eee:	f426                	sd	s1,40(sp)
     ef0:	f04a                	sd	s2,32(sp)
     ef2:	ec4e                	sd	s3,24(sp)
     ef4:	0080                	addi	s0,sp,64
     ef6:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     ef8:	c299                	beqz	a3,efe <printint+0x16>
     efa:	0805c863          	bltz	a1,f8a <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     efe:	2581                	sext.w	a1,a1
  neg = 0;
     f00:	4881                	li	a7,0
     f02:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
     f06:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     f08:	2601                	sext.w	a2,a2
     f0a:	00000517          	auipc	a0,0x0
     f0e:	57e50513          	addi	a0,a0,1406 # 1488 <digits>
     f12:	883a                	mv	a6,a4
     f14:	2705                	addiw	a4,a4,1
     f16:	02c5f7bb          	remuw	a5,a1,a2
     f1a:	1782                	slli	a5,a5,0x20
     f1c:	9381                	srli	a5,a5,0x20
     f1e:	97aa                	add	a5,a5,a0
     f20:	0007c783          	lbu	a5,0(a5)
     f24:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     f28:	0005879b          	sext.w	a5,a1
     f2c:	02c5d5bb          	divuw	a1,a1,a2
     f30:	0685                	addi	a3,a3,1
     f32:	fec7f0e3          	bgeu	a5,a2,f12 <printint+0x2a>
  if(neg)
     f36:	00088b63          	beqz	a7,f4c <printint+0x64>
    buf[i++] = '-';
     f3a:	fd040793          	addi	a5,s0,-48
     f3e:	973e                	add	a4,a4,a5
     f40:	02d00793          	li	a5,45
     f44:	fef70823          	sb	a5,-16(a4)
     f48:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
     f4c:	02e05863          	blez	a4,f7c <printint+0x94>
     f50:	fc040793          	addi	a5,s0,-64
     f54:	00e78933          	add	s2,a5,a4
     f58:	fff78993          	addi	s3,a5,-1
     f5c:	99ba                	add	s3,s3,a4
     f5e:	377d                	addiw	a4,a4,-1
     f60:	1702                	slli	a4,a4,0x20
     f62:	9301                	srli	a4,a4,0x20
     f64:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     f68:	fff94583          	lbu	a1,-1(s2)
     f6c:	8526                	mv	a0,s1
     f6e:	00000097          	auipc	ra,0x0
     f72:	f58080e7          	jalr	-168(ra) # ec6 <putc>
  while(--i >= 0)
     f76:	197d                	addi	s2,s2,-1
     f78:	ff3918e3          	bne	s2,s3,f68 <printint+0x80>
}
     f7c:	70e2                	ld	ra,56(sp)
     f7e:	7442                	ld	s0,48(sp)
     f80:	74a2                	ld	s1,40(sp)
     f82:	7902                	ld	s2,32(sp)
     f84:	69e2                	ld	s3,24(sp)
     f86:	6121                	addi	sp,sp,64
     f88:	8082                	ret
    x = -xx;
     f8a:	40b005bb          	negw	a1,a1
    neg = 1;
     f8e:	4885                	li	a7,1
    x = -xx;
     f90:	bf8d                	j	f02 <printint+0x1a>

0000000000000f92 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     f92:	7119                	addi	sp,sp,-128
     f94:	fc86                	sd	ra,120(sp)
     f96:	f8a2                	sd	s0,112(sp)
     f98:	f4a6                	sd	s1,104(sp)
     f9a:	f0ca                	sd	s2,96(sp)
     f9c:	ecce                	sd	s3,88(sp)
     f9e:	e8d2                	sd	s4,80(sp)
     fa0:	e4d6                	sd	s5,72(sp)
     fa2:	e0da                	sd	s6,64(sp)
     fa4:	fc5e                	sd	s7,56(sp)
     fa6:	f862                	sd	s8,48(sp)
     fa8:	f466                	sd	s9,40(sp)
     faa:	f06a                	sd	s10,32(sp)
     fac:	ec6e                	sd	s11,24(sp)
     fae:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     fb0:	0005c903          	lbu	s2,0(a1)
     fb4:	18090f63          	beqz	s2,1152 <vprintf+0x1c0>
     fb8:	8aaa                	mv	s5,a0
     fba:	8b32                	mv	s6,a2
     fbc:	00158493          	addi	s1,a1,1
  state = 0;
     fc0:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     fc2:	02500a13          	li	s4,37
      if(c == 'd'){
     fc6:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
     fca:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
     fce:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
     fd2:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     fd6:	00000b97          	auipc	s7,0x0
     fda:	4b2b8b93          	addi	s7,s7,1202 # 1488 <digits>
     fde:	a839                	j	ffc <vprintf+0x6a>
        putc(fd, c);
     fe0:	85ca                	mv	a1,s2
     fe2:	8556                	mv	a0,s5
     fe4:	00000097          	auipc	ra,0x0
     fe8:	ee2080e7          	jalr	-286(ra) # ec6 <putc>
     fec:	a019                	j	ff2 <vprintf+0x60>
    } else if(state == '%'){
     fee:	01498f63          	beq	s3,s4,100c <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
     ff2:	0485                	addi	s1,s1,1
     ff4:	fff4c903          	lbu	s2,-1(s1)
     ff8:	14090d63          	beqz	s2,1152 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
     ffc:	0009079b          	sext.w	a5,s2
    if(state == 0){
    1000:	fe0997e3          	bnez	s3,fee <vprintf+0x5c>
      if(c == '%'){
    1004:	fd479ee3          	bne	a5,s4,fe0 <vprintf+0x4e>
        state = '%';
    1008:	89be                	mv	s3,a5
    100a:	b7e5                	j	ff2 <vprintf+0x60>
      if(c == 'd'){
    100c:	05878063          	beq	a5,s8,104c <vprintf+0xba>
      } else if(c == 'l') {
    1010:	05978c63          	beq	a5,s9,1068 <vprintf+0xd6>
      } else if(c == 'x') {
    1014:	07a78863          	beq	a5,s10,1084 <vprintf+0xf2>
      } else if(c == 'p') {
    1018:	09b78463          	beq	a5,s11,10a0 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    101c:	07300713          	li	a4,115
    1020:	0ce78663          	beq	a5,a4,10ec <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1024:	06300713          	li	a4,99
    1028:	0ee78e63          	beq	a5,a4,1124 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    102c:	11478863          	beq	a5,s4,113c <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1030:	85d2                	mv	a1,s4
    1032:	8556                	mv	a0,s5
    1034:	00000097          	auipc	ra,0x0
    1038:	e92080e7          	jalr	-366(ra) # ec6 <putc>
        putc(fd, c);
    103c:	85ca                	mv	a1,s2
    103e:	8556                	mv	a0,s5
    1040:	00000097          	auipc	ra,0x0
    1044:	e86080e7          	jalr	-378(ra) # ec6 <putc>
      }
      state = 0;
    1048:	4981                	li	s3,0
    104a:	b765                	j	ff2 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    104c:	008b0913          	addi	s2,s6,8
    1050:	4685                	li	a3,1
    1052:	4629                	li	a2,10
    1054:	000b2583          	lw	a1,0(s6)
    1058:	8556                	mv	a0,s5
    105a:	00000097          	auipc	ra,0x0
    105e:	e8e080e7          	jalr	-370(ra) # ee8 <printint>
    1062:	8b4a                	mv	s6,s2
      state = 0;
    1064:	4981                	li	s3,0
    1066:	b771                	j	ff2 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1068:	008b0913          	addi	s2,s6,8
    106c:	4681                	li	a3,0
    106e:	4629                	li	a2,10
    1070:	000b2583          	lw	a1,0(s6)
    1074:	8556                	mv	a0,s5
    1076:	00000097          	auipc	ra,0x0
    107a:	e72080e7          	jalr	-398(ra) # ee8 <printint>
    107e:	8b4a                	mv	s6,s2
      state = 0;
    1080:	4981                	li	s3,0
    1082:	bf85                	j	ff2 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    1084:	008b0913          	addi	s2,s6,8
    1088:	4681                	li	a3,0
    108a:	4641                	li	a2,16
    108c:	000b2583          	lw	a1,0(s6)
    1090:	8556                	mv	a0,s5
    1092:	00000097          	auipc	ra,0x0
    1096:	e56080e7          	jalr	-426(ra) # ee8 <printint>
    109a:	8b4a                	mv	s6,s2
      state = 0;
    109c:	4981                	li	s3,0
    109e:	bf91                	j	ff2 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    10a0:	008b0793          	addi	a5,s6,8
    10a4:	f8f43423          	sd	a5,-120(s0)
    10a8:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    10ac:	03000593          	li	a1,48
    10b0:	8556                	mv	a0,s5
    10b2:	00000097          	auipc	ra,0x0
    10b6:	e14080e7          	jalr	-492(ra) # ec6 <putc>
  putc(fd, 'x');
    10ba:	85ea                	mv	a1,s10
    10bc:	8556                	mv	a0,s5
    10be:	00000097          	auipc	ra,0x0
    10c2:	e08080e7          	jalr	-504(ra) # ec6 <putc>
    10c6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    10c8:	03c9d793          	srli	a5,s3,0x3c
    10cc:	97de                	add	a5,a5,s7
    10ce:	0007c583          	lbu	a1,0(a5)
    10d2:	8556                	mv	a0,s5
    10d4:	00000097          	auipc	ra,0x0
    10d8:	df2080e7          	jalr	-526(ra) # ec6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    10dc:	0992                	slli	s3,s3,0x4
    10de:	397d                	addiw	s2,s2,-1
    10e0:	fe0914e3          	bnez	s2,10c8 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    10e4:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    10e8:	4981                	li	s3,0
    10ea:	b721                	j	ff2 <vprintf+0x60>
        s = va_arg(ap, char*);
    10ec:	008b0993          	addi	s3,s6,8
    10f0:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    10f4:	02090163          	beqz	s2,1116 <vprintf+0x184>
        while(*s != 0){
    10f8:	00094583          	lbu	a1,0(s2)
    10fc:	c9a1                	beqz	a1,114c <vprintf+0x1ba>
          putc(fd, *s);
    10fe:	8556                	mv	a0,s5
    1100:	00000097          	auipc	ra,0x0
    1104:	dc6080e7          	jalr	-570(ra) # ec6 <putc>
          s++;
    1108:	0905                	addi	s2,s2,1
        while(*s != 0){
    110a:	00094583          	lbu	a1,0(s2)
    110e:	f9e5                	bnez	a1,10fe <vprintf+0x16c>
        s = va_arg(ap, char*);
    1110:	8b4e                	mv	s6,s3
      state = 0;
    1112:	4981                	li	s3,0
    1114:	bdf9                	j	ff2 <vprintf+0x60>
          s = "(null)";
    1116:	00000917          	auipc	s2,0x0
    111a:	36a90913          	addi	s2,s2,874 # 1480 <malloc+0x224>
        while(*s != 0){
    111e:	02800593          	li	a1,40
    1122:	bff1                	j	10fe <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    1124:	008b0913          	addi	s2,s6,8
    1128:	000b4583          	lbu	a1,0(s6)
    112c:	8556                	mv	a0,s5
    112e:	00000097          	auipc	ra,0x0
    1132:	d98080e7          	jalr	-616(ra) # ec6 <putc>
    1136:	8b4a                	mv	s6,s2
      state = 0;
    1138:	4981                	li	s3,0
    113a:	bd65                	j	ff2 <vprintf+0x60>
        putc(fd, c);
    113c:	85d2                	mv	a1,s4
    113e:	8556                	mv	a0,s5
    1140:	00000097          	auipc	ra,0x0
    1144:	d86080e7          	jalr	-634(ra) # ec6 <putc>
      state = 0;
    1148:	4981                	li	s3,0
    114a:	b565                	j	ff2 <vprintf+0x60>
        s = va_arg(ap, char*);
    114c:	8b4e                	mv	s6,s3
      state = 0;
    114e:	4981                	li	s3,0
    1150:	b54d                	j	ff2 <vprintf+0x60>
    }
  }
}
    1152:	70e6                	ld	ra,120(sp)
    1154:	7446                	ld	s0,112(sp)
    1156:	74a6                	ld	s1,104(sp)
    1158:	7906                	ld	s2,96(sp)
    115a:	69e6                	ld	s3,88(sp)
    115c:	6a46                	ld	s4,80(sp)
    115e:	6aa6                	ld	s5,72(sp)
    1160:	6b06                	ld	s6,64(sp)
    1162:	7be2                	ld	s7,56(sp)
    1164:	7c42                	ld	s8,48(sp)
    1166:	7ca2                	ld	s9,40(sp)
    1168:	7d02                	ld	s10,32(sp)
    116a:	6de2                	ld	s11,24(sp)
    116c:	6109                	addi	sp,sp,128
    116e:	8082                	ret

0000000000001170 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1170:	715d                	addi	sp,sp,-80
    1172:	ec06                	sd	ra,24(sp)
    1174:	e822                	sd	s0,16(sp)
    1176:	1000                	addi	s0,sp,32
    1178:	e010                	sd	a2,0(s0)
    117a:	e414                	sd	a3,8(s0)
    117c:	e818                	sd	a4,16(s0)
    117e:	ec1c                	sd	a5,24(s0)
    1180:	03043023          	sd	a6,32(s0)
    1184:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1188:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    118c:	8622                	mv	a2,s0
    118e:	00000097          	auipc	ra,0x0
    1192:	e04080e7          	jalr	-508(ra) # f92 <vprintf>
}
    1196:	60e2                	ld	ra,24(sp)
    1198:	6442                	ld	s0,16(sp)
    119a:	6161                	addi	sp,sp,80
    119c:	8082                	ret

000000000000119e <printf>:

void
printf(const char *fmt, ...)
{
    119e:	711d                	addi	sp,sp,-96
    11a0:	ec06                	sd	ra,24(sp)
    11a2:	e822                	sd	s0,16(sp)
    11a4:	1000                	addi	s0,sp,32
    11a6:	e40c                	sd	a1,8(s0)
    11a8:	e810                	sd	a2,16(s0)
    11aa:	ec14                	sd	a3,24(s0)
    11ac:	f018                	sd	a4,32(s0)
    11ae:	f41c                	sd	a5,40(s0)
    11b0:	03043823          	sd	a6,48(s0)
    11b4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    11b8:	00840613          	addi	a2,s0,8
    11bc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    11c0:	85aa                	mv	a1,a0
    11c2:	4505                	li	a0,1
    11c4:	00000097          	auipc	ra,0x0
    11c8:	dce080e7          	jalr	-562(ra) # f92 <vprintf>
}
    11cc:	60e2                	ld	ra,24(sp)
    11ce:	6442                	ld	s0,16(sp)
    11d0:	6125                	addi	sp,sp,96
    11d2:	8082                	ret

00000000000011d4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    11d4:	1141                	addi	sp,sp,-16
    11d6:	e422                	sd	s0,8(sp)
    11d8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    11da:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11de:	00001797          	auipc	a5,0x1
    11e2:	e327b783          	ld	a5,-462(a5) # 2010 <freep>
    11e6:	a805                	j	1216 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    11e8:	4618                	lw	a4,8(a2)
    11ea:	9db9                	addw	a1,a1,a4
    11ec:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    11f0:	6398                	ld	a4,0(a5)
    11f2:	6318                	ld	a4,0(a4)
    11f4:	fee53823          	sd	a4,-16(a0)
    11f8:	a091                	j	123c <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    11fa:	ff852703          	lw	a4,-8(a0)
    11fe:	9e39                	addw	a2,a2,a4
    1200:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    1202:	ff053703          	ld	a4,-16(a0)
    1206:	e398                	sd	a4,0(a5)
    1208:	a099                	j	124e <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    120a:	6398                	ld	a4,0(a5)
    120c:	00e7e463          	bltu	a5,a4,1214 <free+0x40>
    1210:	00e6ea63          	bltu	a3,a4,1224 <free+0x50>
{
    1214:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1216:	fed7fae3          	bgeu	a5,a3,120a <free+0x36>
    121a:	6398                	ld	a4,0(a5)
    121c:	00e6e463          	bltu	a3,a4,1224 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1220:	fee7eae3          	bltu	a5,a4,1214 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    1224:	ff852583          	lw	a1,-8(a0)
    1228:	6390                	ld	a2,0(a5)
    122a:	02059713          	slli	a4,a1,0x20
    122e:	9301                	srli	a4,a4,0x20
    1230:	0712                	slli	a4,a4,0x4
    1232:	9736                	add	a4,a4,a3
    1234:	fae60ae3          	beq	a2,a4,11e8 <free+0x14>
    bp->s.ptr = p->s.ptr;
    1238:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    123c:	4790                	lw	a2,8(a5)
    123e:	02061713          	slli	a4,a2,0x20
    1242:	9301                	srli	a4,a4,0x20
    1244:	0712                	slli	a4,a4,0x4
    1246:	973e                	add	a4,a4,a5
    1248:	fae689e3          	beq	a3,a4,11fa <free+0x26>
  } else
    p->s.ptr = bp;
    124c:	e394                	sd	a3,0(a5)
  freep = p;
    124e:	00001717          	auipc	a4,0x1
    1252:	dcf73123          	sd	a5,-574(a4) # 2010 <freep>
}
    1256:	6422                	ld	s0,8(sp)
    1258:	0141                	addi	sp,sp,16
    125a:	8082                	ret

000000000000125c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    125c:	7139                	addi	sp,sp,-64
    125e:	fc06                	sd	ra,56(sp)
    1260:	f822                	sd	s0,48(sp)
    1262:	f426                	sd	s1,40(sp)
    1264:	f04a                	sd	s2,32(sp)
    1266:	ec4e                	sd	s3,24(sp)
    1268:	e852                	sd	s4,16(sp)
    126a:	e456                	sd	s5,8(sp)
    126c:	e05a                	sd	s6,0(sp)
    126e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1270:	02051493          	slli	s1,a0,0x20
    1274:	9081                	srli	s1,s1,0x20
    1276:	04bd                	addi	s1,s1,15
    1278:	8091                	srli	s1,s1,0x4
    127a:	0014899b          	addiw	s3,s1,1
    127e:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    1280:	00001517          	auipc	a0,0x1
    1284:	d9053503          	ld	a0,-624(a0) # 2010 <freep>
    1288:	c515                	beqz	a0,12b4 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    128a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    128c:	4798                	lw	a4,8(a5)
    128e:	02977f63          	bgeu	a4,s1,12cc <malloc+0x70>
    1292:	8a4e                	mv	s4,s3
    1294:	0009871b          	sext.w	a4,s3
    1298:	6685                	lui	a3,0x1
    129a:	00d77363          	bgeu	a4,a3,12a0 <malloc+0x44>
    129e:	6a05                	lui	s4,0x1
    12a0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    12a4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    12a8:	00001917          	auipc	s2,0x1
    12ac:	d6890913          	addi	s2,s2,-664 # 2010 <freep>
  if(p == (char*)-1)
    12b0:	5afd                	li	s5,-1
    12b2:	a88d                	j	1324 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    12b4:	00001797          	auipc	a5,0x1
    12b8:	dd478793          	addi	a5,a5,-556 # 2088 <base>
    12bc:	00001717          	auipc	a4,0x1
    12c0:	d4f73a23          	sd	a5,-684(a4) # 2010 <freep>
    12c4:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    12c6:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    12ca:	b7e1                	j	1292 <malloc+0x36>
      if(p->s.size == nunits)
    12cc:	02e48b63          	beq	s1,a4,1302 <malloc+0xa6>
        p->s.size -= nunits;
    12d0:	4137073b          	subw	a4,a4,s3
    12d4:	c798                	sw	a4,8(a5)
        p += p->s.size;
    12d6:	1702                	slli	a4,a4,0x20
    12d8:	9301                	srli	a4,a4,0x20
    12da:	0712                	slli	a4,a4,0x4
    12dc:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    12de:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    12e2:	00001717          	auipc	a4,0x1
    12e6:	d2a73723          	sd	a0,-722(a4) # 2010 <freep>
      return (void*)(p + 1);
    12ea:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    12ee:	70e2                	ld	ra,56(sp)
    12f0:	7442                	ld	s0,48(sp)
    12f2:	74a2                	ld	s1,40(sp)
    12f4:	7902                	ld	s2,32(sp)
    12f6:	69e2                	ld	s3,24(sp)
    12f8:	6a42                	ld	s4,16(sp)
    12fa:	6aa2                	ld	s5,8(sp)
    12fc:	6b02                	ld	s6,0(sp)
    12fe:	6121                	addi	sp,sp,64
    1300:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    1302:	6398                	ld	a4,0(a5)
    1304:	e118                	sd	a4,0(a0)
    1306:	bff1                	j	12e2 <malloc+0x86>
  hp->s.size = nu;
    1308:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    130c:	0541                	addi	a0,a0,16
    130e:	00000097          	auipc	ra,0x0
    1312:	ec6080e7          	jalr	-314(ra) # 11d4 <free>
  return freep;
    1316:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    131a:	d971                	beqz	a0,12ee <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    131c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    131e:	4798                	lw	a4,8(a5)
    1320:	fa9776e3          	bgeu	a4,s1,12cc <malloc+0x70>
    if(p == freep)
    1324:	00093703          	ld	a4,0(s2)
    1328:	853e                	mv	a0,a5
    132a:	fef719e3          	bne	a4,a5,131c <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    132e:	8552                	mv	a0,s4
    1330:	00000097          	auipc	ra,0x0
    1334:	b66080e7          	jalr	-1178(ra) # e96 <sbrk>
  if(p == (char*)-1)
    1338:	fd5518e3          	bne	a0,s5,1308 <malloc+0xac>
        return 0;
    133c:	4501                	li	a0,0
    133e:	bf45                	j	12ee <malloc+0x92>
