
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
      16:	34e58593          	addi	a1,a1,846 # 1360 <malloc+0xf2>
      1a:	4509                	li	a0,2
      1c:	00001097          	auipc	ra,0x1
      20:	e34080e7          	jalr	-460(ra) # e50 <write>
  memset(buf, 0, nbuf);
      24:	864a                	mv	a2,s2
      26:	4581                	li	a1,0
      28:	8526                	mv	a0,s1
      2a:	00001097          	auipc	ra,0x1
      2e:	c0a080e7          	jalr	-1014(ra) # c34 <memset>
  gets(buf, nbuf);
      32:	85ca                	mv	a1,s2
      34:	8526                	mv	a0,s1
      36:	00001097          	auipc	ra,0x1
      3a:	c44080e7          	jalr	-956(ra) # c7a <gets>
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
      64:	36058593          	addi	a1,a1,864 # 13c0 <malloc+0x152>
      68:	4509                	li	a0,2
      6a:	00001097          	auipc	ra,0x1
      6e:	118080e7          	jalr	280(ra) # 1182 <fprintf>
  exit(1,0);
      72:	4581                	li	a1,0
      74:	4505                	li	a0,1
      76:	00001097          	auipc	ra,0x1
      7a:	dba080e7          	jalr	-582(ra) # e30 <exit>

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
      8a:	da2080e7          	jalr	-606(ra) # e28 <fork>
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
      a0:	2cc50513          	addi	a0,a0,716 # 1368 <malloc+0xfa>
      a4:	00000097          	auipc	ra,0x0
      a8:	fb2080e7          	jalr	-78(ra) # 56 <panic>

00000000000000ac <runcmd>:
{
      ac:	715d                	addi	sp,sp,-80
      ae:	e486                	sd	ra,72(sp)
      b0:	e0a2                	sd	s0,64(sp)
      b2:	fc26                	sd	s1,56(sp)
      b4:	0880                	addi	s0,sp,80
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
      cc:	3c870713          	addi	a4,a4,968 # 1490 <malloc+0x222>
      d0:	97ba                	add	a5,a5,a4
      d2:	439c                	lw	a5,0(a5)
      d4:	97ba                	add	a5,a5,a4
      d6:	8782                	jr	a5
    exit(1,0);
      d8:	4581                	li	a1,0
      da:	4505                	li	a0,1
      dc:	00001097          	auipc	ra,0x1
      e0:	d54080e7          	jalr	-684(ra) # e30 <exit>
    panic("runcmd");
      e4:	00001517          	auipc	a0,0x1
      e8:	28c50513          	addi	a0,a0,652 # 1370 <malloc+0x102>
      ec:	00000097          	auipc	ra,0x0
      f0:	f6a080e7          	jalr	-150(ra) # 56 <panic>
    if(ecmd->argv[0] == 0)
      f4:	6508                	ld	a0,8(a0)
      f6:	c91d                	beqz	a0,12c <runcmd+0x80>
    exec(ecmd->argv[0], ecmd->argv);
      f8:	00848593          	addi	a1,s1,8
      fc:	00001097          	auipc	ra,0x1
     100:	d6c080e7          	jalr	-660(ra) # e68 <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
     104:	6490                	ld	a2,8(s1)
     106:	00001597          	auipc	a1,0x1
     10a:	27258593          	addi	a1,a1,626 # 1378 <malloc+0x10a>
     10e:	4509                	li	a0,2
     110:	00001097          	auipc	ra,0x1
     114:	072080e7          	jalr	114(ra) # 1182 <fprintf>
  if (cmd->type != BACK) {
     118:	4098                	lw	a4,0(s1)
     11a:	4795                	li	a5,5
     11c:	16f71a63          	bne	a4,a5,290 <runcmd+0x1e4>
  exit(0,0);
     120:	4581                	li	a1,0
     122:	4501                	li	a0,0
     124:	00001097          	auipc	ra,0x1
     128:	d0c080e7          	jalr	-756(ra) # e30 <exit>
      exit(1,0);
     12c:	4581                	li	a1,0
     12e:	4505                	li	a0,1
     130:	00001097          	auipc	ra,0x1
     134:	d00080e7          	jalr	-768(ra) # e30 <exit>
    close(rcmd->fd);
     138:	5148                	lw	a0,36(a0)
     13a:	00001097          	auipc	ra,0x1
     13e:	d1e080e7          	jalr	-738(ra) # e58 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     142:	508c                	lw	a1,32(s1)
     144:	6888                	ld	a0,16(s1)
     146:	00001097          	auipc	ra,0x1
     14a:	d2a080e7          	jalr	-726(ra) # e70 <open>
     14e:	00054763          	bltz	a0,15c <runcmd+0xb0>
    runcmd(rcmd->cmd);
     152:	6488                	ld	a0,8(s1)
     154:	00000097          	auipc	ra,0x0
     158:	f58080e7          	jalr	-168(ra) # ac <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     15c:	6890                	ld	a2,16(s1)
     15e:	00001597          	auipc	a1,0x1
     162:	22a58593          	addi	a1,a1,554 # 1388 <malloc+0x11a>
     166:	4509                	li	a0,2
     168:	00001097          	auipc	ra,0x1
     16c:	01a080e7          	jalr	26(ra) # 1182 <fprintf>
      exit(1,0);
     170:	4581                	li	a1,0
     172:	4505                	li	a0,1
     174:	00001097          	auipc	ra,0x1
     178:	cbc080e7          	jalr	-836(ra) # e30 <exit>
    if(fork1() == 0)
     17c:	00000097          	auipc	ra,0x0
     180:	f02080e7          	jalr	-254(ra) # 7e <fork1>
     184:	e511                	bnez	a0,190 <runcmd+0xe4>
      runcmd(lcmd->left);
     186:	6488                	ld	a0,8(s1)
     188:	00000097          	auipc	ra,0x0
     18c:	f24080e7          	jalr	-220(ra) # ac <runcmd>
    wait(0,0);
     190:	4581                	li	a1,0
     192:	4501                	li	a0,0
     194:	00001097          	auipc	ra,0x1
     198:	ca4080e7          	jalr	-860(ra) # e38 <wait>
    runcmd(lcmd->right);
     19c:	6888                	ld	a0,16(s1)
     19e:	00000097          	auipc	ra,0x0
     1a2:	f0e080e7          	jalr	-242(ra) # ac <runcmd>
    if(pipe(p) < 0)
     1a6:	fd840513          	addi	a0,s0,-40
     1aa:	00001097          	auipc	ra,0x1
     1ae:	c96080e7          	jalr	-874(ra) # e40 <pipe>
     1b2:	04054363          	bltz	a0,1f8 <runcmd+0x14c>
    if(fork1() == 0){
     1b6:	00000097          	auipc	ra,0x0
     1ba:	ec8080e7          	jalr	-312(ra) # 7e <fork1>
     1be:	e529                	bnez	a0,208 <runcmd+0x15c>
      close(1);
     1c0:	4505                	li	a0,1
     1c2:	00001097          	auipc	ra,0x1
     1c6:	c96080e7          	jalr	-874(ra) # e58 <close>
      dup(p[1]);
     1ca:	fdc42503          	lw	a0,-36(s0)
     1ce:	00001097          	auipc	ra,0x1
     1d2:	cda080e7          	jalr	-806(ra) # ea8 <dup>
      close(p[0]);
     1d6:	fd842503          	lw	a0,-40(s0)
     1da:	00001097          	auipc	ra,0x1
     1de:	c7e080e7          	jalr	-898(ra) # e58 <close>
      close(p[1]);
     1e2:	fdc42503          	lw	a0,-36(s0)
     1e6:	00001097          	auipc	ra,0x1
     1ea:	c72080e7          	jalr	-910(ra) # e58 <close>
      runcmd(pcmd->left);
     1ee:	6488                	ld	a0,8(s1)
     1f0:	00000097          	auipc	ra,0x0
     1f4:	ebc080e7          	jalr	-324(ra) # ac <runcmd>
      panic("pipe");
     1f8:	00001517          	auipc	a0,0x1
     1fc:	1a050513          	addi	a0,a0,416 # 1398 <malloc+0x12a>
     200:	00000097          	auipc	ra,0x0
     204:	e56080e7          	jalr	-426(ra) # 56 <panic>
    if(fork1() == 0){
     208:	00000097          	auipc	ra,0x0
     20c:	e76080e7          	jalr	-394(ra) # 7e <fork1>
     210:	ed05                	bnez	a0,248 <runcmd+0x19c>
      close(0);
     212:	00001097          	auipc	ra,0x1
     216:	c46080e7          	jalr	-954(ra) # e58 <close>
      dup(p[0]);
     21a:	fd842503          	lw	a0,-40(s0)
     21e:	00001097          	auipc	ra,0x1
     222:	c8a080e7          	jalr	-886(ra) # ea8 <dup>
      close(p[0]);
     226:	fd842503          	lw	a0,-40(s0)
     22a:	00001097          	auipc	ra,0x1
     22e:	c2e080e7          	jalr	-978(ra) # e58 <close>
      close(p[1]);
     232:	fdc42503          	lw	a0,-36(s0)
     236:	00001097          	auipc	ra,0x1
     23a:	c22080e7          	jalr	-990(ra) # e58 <close>
      runcmd(pcmd->right);
     23e:	6888                	ld	a0,16(s1)
     240:	00000097          	auipc	ra,0x0
     244:	e6c080e7          	jalr	-404(ra) # ac <runcmd>
    close(p[0]);
     248:	fd842503          	lw	a0,-40(s0)
     24c:	00001097          	auipc	ra,0x1
     250:	c0c080e7          	jalr	-1012(ra) # e58 <close>
    close(p[1]);
     254:	fdc42503          	lw	a0,-36(s0)
     258:	00001097          	auipc	ra,0x1
     25c:	c00080e7          	jalr	-1024(ra) # e58 <close>
    wait(0,0);
     260:	4581                	li	a1,0
     262:	4501                	li	a0,0
     264:	00001097          	auipc	ra,0x1
     268:	bd4080e7          	jalr	-1068(ra) # e38 <wait>
    wait(0,0);
     26c:	4581                	li	a1,0
     26e:	4501                	li	a0,0
     270:	00001097          	auipc	ra,0x1
     274:	bc8080e7          	jalr	-1080(ra) # e38 <wait>
    break;
     278:	b545                	j	118 <runcmd+0x6c>
    if(fork1() == 0)
     27a:	00000097          	auipc	ra,0x0
     27e:	e04080e7          	jalr	-508(ra) # 7e <fork1>
     282:	e8051be3          	bnez	a0,118 <runcmd+0x6c>
      runcmd(bcmd->cmd);
     286:	6488                	ld	a0,8(s1)
     288:	00000097          	auipc	ra,0x0
     28c:	e24080e7          	jalr	-476(ra) # ac <runcmd>
        int pid = wait(&status, message);
     290:	fb840593          	addi	a1,s0,-72
     294:	fb440513          	addi	a0,s0,-76
     298:	00001097          	auipc	ra,0x1
     29c:	ba0080e7          	jalr	-1120(ra) # e38 <wait>
        if (pid > 0 && message[0] != '\0') {
     2a0:	e8a050e3          	blez	a0,120 <runcmd+0x74>
     2a4:	fb844783          	lbu	a5,-72(s0)
     2a8:	e6078ce3          	beqz	a5,120 <runcmd+0x74>
            printf("Process %d exited with message: %s\n", pid, message);
     2ac:	fb840613          	addi	a2,s0,-72
     2b0:	85aa                	mv	a1,a0
     2b2:	00001517          	auipc	a0,0x1
     2b6:	0ee50513          	addi	a0,a0,238 # 13a0 <malloc+0x132>
     2ba:	00001097          	auipc	ra,0x1
     2be:	ef6080e7          	jalr	-266(ra) # 11b0 <printf>
     2c2:	bdb9                	j	120 <runcmd+0x74>

00000000000002c4 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     2c4:	1101                	addi	sp,sp,-32
     2c6:	ec06                	sd	ra,24(sp)
     2c8:	e822                	sd	s0,16(sp)
     2ca:	e426                	sd	s1,8(sp)
     2cc:	1000                	addi	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2ce:	0a800513          	li	a0,168
     2d2:	00001097          	auipc	ra,0x1
     2d6:	f9c080e7          	jalr	-100(ra) # 126e <malloc>
     2da:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2dc:	0a800613          	li	a2,168
     2e0:	4581                	li	a1,0
     2e2:	00001097          	auipc	ra,0x1
     2e6:	952080e7          	jalr	-1710(ra) # c34 <memset>
  cmd->type = EXEC;
     2ea:	4785                	li	a5,1
     2ec:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
     2ee:	8526                	mv	a0,s1
     2f0:	60e2                	ld	ra,24(sp)
     2f2:	6442                	ld	s0,16(sp)
     2f4:	64a2                	ld	s1,8(sp)
     2f6:	6105                	addi	sp,sp,32
     2f8:	8082                	ret

00000000000002fa <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     2fa:	7139                	addi	sp,sp,-64
     2fc:	fc06                	sd	ra,56(sp)
     2fe:	f822                	sd	s0,48(sp)
     300:	f426                	sd	s1,40(sp)
     302:	f04a                	sd	s2,32(sp)
     304:	ec4e                	sd	s3,24(sp)
     306:	e852                	sd	s4,16(sp)
     308:	e456                	sd	s5,8(sp)
     30a:	e05a                	sd	s6,0(sp)
     30c:	0080                	addi	s0,sp,64
     30e:	8b2a                	mv	s6,a0
     310:	8aae                	mv	s5,a1
     312:	8a32                	mv	s4,a2
     314:	89b6                	mv	s3,a3
     316:	893a                	mv	s2,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     318:	02800513          	li	a0,40
     31c:	00001097          	auipc	ra,0x1
     320:	f52080e7          	jalr	-174(ra) # 126e <malloc>
     324:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     326:	02800613          	li	a2,40
     32a:	4581                	li	a1,0
     32c:	00001097          	auipc	ra,0x1
     330:	908080e7          	jalr	-1784(ra) # c34 <memset>
  cmd->type = REDIR;
     334:	4789                	li	a5,2
     336:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     338:	0164b423          	sd	s6,8(s1)
  cmd->file = file;
     33c:	0154b823          	sd	s5,16(s1)
  cmd->efile = efile;
     340:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
     344:	0334a023          	sw	s3,32(s1)
  cmd->fd = fd;
     348:	0324a223          	sw	s2,36(s1)
  return (struct cmd*)cmd;
}
     34c:	8526                	mv	a0,s1
     34e:	70e2                	ld	ra,56(sp)
     350:	7442                	ld	s0,48(sp)
     352:	74a2                	ld	s1,40(sp)
     354:	7902                	ld	s2,32(sp)
     356:	69e2                	ld	s3,24(sp)
     358:	6a42                	ld	s4,16(sp)
     35a:	6aa2                	ld	s5,8(sp)
     35c:	6b02                	ld	s6,0(sp)
     35e:	6121                	addi	sp,sp,64
     360:	8082                	ret

0000000000000362 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     362:	7179                	addi	sp,sp,-48
     364:	f406                	sd	ra,40(sp)
     366:	f022                	sd	s0,32(sp)
     368:	ec26                	sd	s1,24(sp)
     36a:	e84a                	sd	s2,16(sp)
     36c:	e44e                	sd	s3,8(sp)
     36e:	1800                	addi	s0,sp,48
     370:	89aa                	mv	s3,a0
     372:	892e                	mv	s2,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     374:	4561                	li	a0,24
     376:	00001097          	auipc	ra,0x1
     37a:	ef8080e7          	jalr	-264(ra) # 126e <malloc>
     37e:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     380:	4661                	li	a2,24
     382:	4581                	li	a1,0
     384:	00001097          	auipc	ra,0x1
     388:	8b0080e7          	jalr	-1872(ra) # c34 <memset>
  cmd->type = PIPE;
     38c:	478d                	li	a5,3
     38e:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     390:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     394:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     398:	8526                	mv	a0,s1
     39a:	70a2                	ld	ra,40(sp)
     39c:	7402                	ld	s0,32(sp)
     39e:	64e2                	ld	s1,24(sp)
     3a0:	6942                	ld	s2,16(sp)
     3a2:	69a2                	ld	s3,8(sp)
     3a4:	6145                	addi	sp,sp,48
     3a6:	8082                	ret

00000000000003a8 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     3a8:	7179                	addi	sp,sp,-48
     3aa:	f406                	sd	ra,40(sp)
     3ac:	f022                	sd	s0,32(sp)
     3ae:	ec26                	sd	s1,24(sp)
     3b0:	e84a                	sd	s2,16(sp)
     3b2:	e44e                	sd	s3,8(sp)
     3b4:	1800                	addi	s0,sp,48
     3b6:	89aa                	mv	s3,a0
     3b8:	892e                	mv	s2,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3ba:	4561                	li	a0,24
     3bc:	00001097          	auipc	ra,0x1
     3c0:	eb2080e7          	jalr	-334(ra) # 126e <malloc>
     3c4:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     3c6:	4661                	li	a2,24
     3c8:	4581                	li	a1,0
     3ca:	00001097          	auipc	ra,0x1
     3ce:	86a080e7          	jalr	-1942(ra) # c34 <memset>
  cmd->type = LIST;
     3d2:	4791                	li	a5,4
     3d4:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     3d6:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     3da:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     3de:	8526                	mv	a0,s1
     3e0:	70a2                	ld	ra,40(sp)
     3e2:	7402                	ld	s0,32(sp)
     3e4:	64e2                	ld	s1,24(sp)
     3e6:	6942                	ld	s2,16(sp)
     3e8:	69a2                	ld	s3,8(sp)
     3ea:	6145                	addi	sp,sp,48
     3ec:	8082                	ret

00000000000003ee <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     3ee:	1101                	addi	sp,sp,-32
     3f0:	ec06                	sd	ra,24(sp)
     3f2:	e822                	sd	s0,16(sp)
     3f4:	e426                	sd	s1,8(sp)
     3f6:	e04a                	sd	s2,0(sp)
     3f8:	1000                	addi	s0,sp,32
     3fa:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3fc:	4541                	li	a0,16
     3fe:	00001097          	auipc	ra,0x1
     402:	e70080e7          	jalr	-400(ra) # 126e <malloc>
     406:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     408:	4641                	li	a2,16
     40a:	4581                	li	a1,0
     40c:	00001097          	auipc	ra,0x1
     410:	828080e7          	jalr	-2008(ra) # c34 <memset>
  cmd->type = BACK;
     414:	4795                	li	a5,5
     416:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     418:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
     41c:	8526                	mv	a0,s1
     41e:	60e2                	ld	ra,24(sp)
     420:	6442                	ld	s0,16(sp)
     422:	64a2                	ld	s1,8(sp)
     424:	6902                	ld	s2,0(sp)
     426:	6105                	addi	sp,sp,32
     428:	8082                	ret

000000000000042a <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     42a:	7139                	addi	sp,sp,-64
     42c:	fc06                	sd	ra,56(sp)
     42e:	f822                	sd	s0,48(sp)
     430:	f426                	sd	s1,40(sp)
     432:	f04a                	sd	s2,32(sp)
     434:	ec4e                	sd	s3,24(sp)
     436:	e852                	sd	s4,16(sp)
     438:	e456                	sd	s5,8(sp)
     43a:	e05a                	sd	s6,0(sp)
     43c:	0080                	addi	s0,sp,64
     43e:	8a2a                	mv	s4,a0
     440:	892e                	mv	s2,a1
     442:	8ab2                	mv	s5,a2
     444:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
     446:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     448:	00002997          	auipc	s3,0x2
     44c:	bc098993          	addi	s3,s3,-1088 # 2008 <whitespace>
     450:	00b4fd63          	bgeu	s1,a1,46a <gettoken+0x40>
     454:	0004c583          	lbu	a1,0(s1)
     458:	854e                	mv	a0,s3
     45a:	00000097          	auipc	ra,0x0
     45e:	7fc080e7          	jalr	2044(ra) # c56 <strchr>
     462:	c501                	beqz	a0,46a <gettoken+0x40>
    s++;
     464:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     466:	fe9917e3          	bne	s2,s1,454 <gettoken+0x2a>
  if(q)
     46a:	000a8463          	beqz	s5,472 <gettoken+0x48>
    *q = s;
     46e:	009ab023          	sd	s1,0(s5)
  ret = *s;
     472:	0004c783          	lbu	a5,0(s1)
     476:	00078a9b          	sext.w	s5,a5
  switch(*s){
     47a:	03c00713          	li	a4,60
     47e:	06f76563          	bltu	a4,a5,4e8 <gettoken+0xbe>
     482:	03a00713          	li	a4,58
     486:	00f76e63          	bltu	a4,a5,4a2 <gettoken+0x78>
     48a:	cf89                	beqz	a5,4a4 <gettoken+0x7a>
     48c:	02600713          	li	a4,38
     490:	00e78963          	beq	a5,a4,4a2 <gettoken+0x78>
     494:	fd87879b          	addiw	a5,a5,-40
     498:	0ff7f793          	andi	a5,a5,255
     49c:	4705                	li	a4,1
     49e:	06f76c63          	bltu	a4,a5,516 <gettoken+0xec>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     4a2:	0485                	addi	s1,s1,1
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     4a4:	000b0463          	beqz	s6,4ac <gettoken+0x82>
    *eq = s;
     4a8:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
     4ac:	00002997          	auipc	s3,0x2
     4b0:	b5c98993          	addi	s3,s3,-1188 # 2008 <whitespace>
     4b4:	0124fd63          	bgeu	s1,s2,4ce <gettoken+0xa4>
     4b8:	0004c583          	lbu	a1,0(s1)
     4bc:	854e                	mv	a0,s3
     4be:	00000097          	auipc	ra,0x0
     4c2:	798080e7          	jalr	1944(ra) # c56 <strchr>
     4c6:	c501                	beqz	a0,4ce <gettoken+0xa4>
    s++;
     4c8:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     4ca:	fe9917e3          	bne	s2,s1,4b8 <gettoken+0x8e>
  *ps = s;
     4ce:	009a3023          	sd	s1,0(s4)
  return ret;
}
     4d2:	8556                	mv	a0,s5
     4d4:	70e2                	ld	ra,56(sp)
     4d6:	7442                	ld	s0,48(sp)
     4d8:	74a2                	ld	s1,40(sp)
     4da:	7902                	ld	s2,32(sp)
     4dc:	69e2                	ld	s3,24(sp)
     4de:	6a42                	ld	s4,16(sp)
     4e0:	6aa2                	ld	s5,8(sp)
     4e2:	6b02                	ld	s6,0(sp)
     4e4:	6121                	addi	sp,sp,64
     4e6:	8082                	ret
  switch(*s){
     4e8:	03e00713          	li	a4,62
     4ec:	02e79163          	bne	a5,a4,50e <gettoken+0xe4>
    s++;
     4f0:	00148693          	addi	a3,s1,1
    if(*s == '>'){
     4f4:	0014c703          	lbu	a4,1(s1)
     4f8:	03e00793          	li	a5,62
      s++;
     4fc:	0489                	addi	s1,s1,2
      ret = '+';
     4fe:	02b00a93          	li	s5,43
    if(*s == '>'){
     502:	faf701e3          	beq	a4,a5,4a4 <gettoken+0x7a>
    s++;
     506:	84b6                	mv	s1,a3
  ret = *s;
     508:	03e00a93          	li	s5,62
     50c:	bf61                	j	4a4 <gettoken+0x7a>
  switch(*s){
     50e:	07c00713          	li	a4,124
     512:	f8e788e3          	beq	a5,a4,4a2 <gettoken+0x78>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     516:	00002997          	auipc	s3,0x2
     51a:	af298993          	addi	s3,s3,-1294 # 2008 <whitespace>
     51e:	00002a97          	auipc	s5,0x2
     522:	ae2a8a93          	addi	s5,s5,-1310 # 2000 <symbols>
     526:	0324f563          	bgeu	s1,s2,550 <gettoken+0x126>
     52a:	0004c583          	lbu	a1,0(s1)
     52e:	854e                	mv	a0,s3
     530:	00000097          	auipc	ra,0x0
     534:	726080e7          	jalr	1830(ra) # c56 <strchr>
     538:	e505                	bnez	a0,560 <gettoken+0x136>
     53a:	0004c583          	lbu	a1,0(s1)
     53e:	8556                	mv	a0,s5
     540:	00000097          	auipc	ra,0x0
     544:	716080e7          	jalr	1814(ra) # c56 <strchr>
     548:	e909                	bnez	a0,55a <gettoken+0x130>
      s++;
     54a:	0485                	addi	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     54c:	fc991fe3          	bne	s2,s1,52a <gettoken+0x100>
  if(eq)
     550:	06100a93          	li	s5,97
     554:	f40b1ae3          	bnez	s6,4a8 <gettoken+0x7e>
     558:	bf9d                	j	4ce <gettoken+0xa4>
    ret = 'a';
     55a:	06100a93          	li	s5,97
     55e:	b799                	j	4a4 <gettoken+0x7a>
     560:	06100a93          	li	s5,97
     564:	b781                	j	4a4 <gettoken+0x7a>

0000000000000566 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     566:	7139                	addi	sp,sp,-64
     568:	fc06                	sd	ra,56(sp)
     56a:	f822                	sd	s0,48(sp)
     56c:	f426                	sd	s1,40(sp)
     56e:	f04a                	sd	s2,32(sp)
     570:	ec4e                	sd	s3,24(sp)
     572:	e852                	sd	s4,16(sp)
     574:	e456                	sd	s5,8(sp)
     576:	0080                	addi	s0,sp,64
     578:	8a2a                	mv	s4,a0
     57a:	892e                	mv	s2,a1
     57c:	8ab2                	mv	s5,a2
  char *s;

  s = *ps;
     57e:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     580:	00002997          	auipc	s3,0x2
     584:	a8898993          	addi	s3,s3,-1400 # 2008 <whitespace>
     588:	00b4fd63          	bgeu	s1,a1,5a2 <peek+0x3c>
     58c:	0004c583          	lbu	a1,0(s1)
     590:	854e                	mv	a0,s3
     592:	00000097          	auipc	ra,0x0
     596:	6c4080e7          	jalr	1732(ra) # c56 <strchr>
     59a:	c501                	beqz	a0,5a2 <peek+0x3c>
    s++;
     59c:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     59e:	fe9917e3          	bne	s2,s1,58c <peek+0x26>
  *ps = s;
     5a2:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
     5a6:	0004c583          	lbu	a1,0(s1)
     5aa:	4501                	li	a0,0
     5ac:	e991                	bnez	a1,5c0 <peek+0x5a>
}
     5ae:	70e2                	ld	ra,56(sp)
     5b0:	7442                	ld	s0,48(sp)
     5b2:	74a2                	ld	s1,40(sp)
     5b4:	7902                	ld	s2,32(sp)
     5b6:	69e2                	ld	s3,24(sp)
     5b8:	6a42                	ld	s4,16(sp)
     5ba:	6aa2                	ld	s5,8(sp)
     5bc:	6121                	addi	sp,sp,64
     5be:	8082                	ret
  return *s && strchr(toks, *s);
     5c0:	8556                	mv	a0,s5
     5c2:	00000097          	auipc	ra,0x0
     5c6:	694080e7          	jalr	1684(ra) # c56 <strchr>
     5ca:	00a03533          	snez	a0,a0
     5ce:	b7c5                	j	5ae <peek+0x48>

00000000000005d0 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     5d0:	7159                	addi	sp,sp,-112
     5d2:	f486                	sd	ra,104(sp)
     5d4:	f0a2                	sd	s0,96(sp)
     5d6:	eca6                	sd	s1,88(sp)
     5d8:	e8ca                	sd	s2,80(sp)
     5da:	e4ce                	sd	s3,72(sp)
     5dc:	e0d2                	sd	s4,64(sp)
     5de:	fc56                	sd	s5,56(sp)
     5e0:	f85a                	sd	s6,48(sp)
     5e2:	f45e                	sd	s7,40(sp)
     5e4:	f062                	sd	s8,32(sp)
     5e6:	ec66                	sd	s9,24(sp)
     5e8:	1880                	addi	s0,sp,112
     5ea:	8a2a                	mv	s4,a0
     5ec:	89ae                	mv	s3,a1
     5ee:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     5f0:	00001b97          	auipc	s7,0x1
     5f4:	df8b8b93          	addi	s7,s7,-520 # 13e8 <malloc+0x17a>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     5f8:	06100c13          	li	s8,97
      panic("missing file for redirection");
    switch(tok){
     5fc:	03c00c93          	li	s9,60
  while(peek(ps, es, "<>")){
     600:	a02d                	j	62a <parseredirs+0x5a>
      panic("missing file for redirection");
     602:	00001517          	auipc	a0,0x1
     606:	dc650513          	addi	a0,a0,-570 # 13c8 <malloc+0x15a>
     60a:	00000097          	auipc	ra,0x0
     60e:	a4c080e7          	jalr	-1460(ra) # 56 <panic>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     612:	4701                	li	a4,0
     614:	4681                	li	a3,0
     616:	f9043603          	ld	a2,-112(s0)
     61a:	f9843583          	ld	a1,-104(s0)
     61e:	8552                	mv	a0,s4
     620:	00000097          	auipc	ra,0x0
     624:	cda080e7          	jalr	-806(ra) # 2fa <redircmd>
     628:	8a2a                	mv	s4,a0
    switch(tok){
     62a:	03e00b13          	li	s6,62
     62e:	02b00a93          	li	s5,43
  while(peek(ps, es, "<>")){
     632:	865e                	mv	a2,s7
     634:	85ca                	mv	a1,s2
     636:	854e                	mv	a0,s3
     638:	00000097          	auipc	ra,0x0
     63c:	f2e080e7          	jalr	-210(ra) # 566 <peek>
     640:	c925                	beqz	a0,6b0 <parseredirs+0xe0>
    tok = gettoken(ps, es, 0, 0);
     642:	4681                	li	a3,0
     644:	4601                	li	a2,0
     646:	85ca                	mv	a1,s2
     648:	854e                	mv	a0,s3
     64a:	00000097          	auipc	ra,0x0
     64e:	de0080e7          	jalr	-544(ra) # 42a <gettoken>
     652:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
     654:	f9040693          	addi	a3,s0,-112
     658:	f9840613          	addi	a2,s0,-104
     65c:	85ca                	mv	a1,s2
     65e:	854e                	mv	a0,s3
     660:	00000097          	auipc	ra,0x0
     664:	dca080e7          	jalr	-566(ra) # 42a <gettoken>
     668:	f9851de3          	bne	a0,s8,602 <parseredirs+0x32>
    switch(tok){
     66c:	fb9483e3          	beq	s1,s9,612 <parseredirs+0x42>
     670:	03648263          	beq	s1,s6,694 <parseredirs+0xc4>
     674:	fb549fe3          	bne	s1,s5,632 <parseredirs+0x62>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     678:	4705                	li	a4,1
     67a:	20100693          	li	a3,513
     67e:	f9043603          	ld	a2,-112(s0)
     682:	f9843583          	ld	a1,-104(s0)
     686:	8552                	mv	a0,s4
     688:	00000097          	auipc	ra,0x0
     68c:	c72080e7          	jalr	-910(ra) # 2fa <redircmd>
     690:	8a2a                	mv	s4,a0
      break;
     692:	bf61                	j	62a <parseredirs+0x5a>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     694:	4705                	li	a4,1
     696:	60100693          	li	a3,1537
     69a:	f9043603          	ld	a2,-112(s0)
     69e:	f9843583          	ld	a1,-104(s0)
     6a2:	8552                	mv	a0,s4
     6a4:	00000097          	auipc	ra,0x0
     6a8:	c56080e7          	jalr	-938(ra) # 2fa <redircmd>
     6ac:	8a2a                	mv	s4,a0
      break;
     6ae:	bfb5                	j	62a <parseredirs+0x5a>
    }
  }
  return cmd;
}
     6b0:	8552                	mv	a0,s4
     6b2:	70a6                	ld	ra,104(sp)
     6b4:	7406                	ld	s0,96(sp)
     6b6:	64e6                	ld	s1,88(sp)
     6b8:	6946                	ld	s2,80(sp)
     6ba:	69a6                	ld	s3,72(sp)
     6bc:	6a06                	ld	s4,64(sp)
     6be:	7ae2                	ld	s5,56(sp)
     6c0:	7b42                	ld	s6,48(sp)
     6c2:	7ba2                	ld	s7,40(sp)
     6c4:	7c02                	ld	s8,32(sp)
     6c6:	6ce2                	ld	s9,24(sp)
     6c8:	6165                	addi	sp,sp,112
     6ca:	8082                	ret

00000000000006cc <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     6cc:	7159                	addi	sp,sp,-112
     6ce:	f486                	sd	ra,104(sp)
     6d0:	f0a2                	sd	s0,96(sp)
     6d2:	eca6                	sd	s1,88(sp)
     6d4:	e8ca                	sd	s2,80(sp)
     6d6:	e4ce                	sd	s3,72(sp)
     6d8:	e0d2                	sd	s4,64(sp)
     6da:	fc56                	sd	s5,56(sp)
     6dc:	f85a                	sd	s6,48(sp)
     6de:	f45e                	sd	s7,40(sp)
     6e0:	f062                	sd	s8,32(sp)
     6e2:	ec66                	sd	s9,24(sp)
     6e4:	1880                	addi	s0,sp,112
     6e6:	8a2a                	mv	s4,a0
     6e8:	8aae                	mv	s5,a1
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     6ea:	00001617          	auipc	a2,0x1
     6ee:	d0660613          	addi	a2,a2,-762 # 13f0 <malloc+0x182>
     6f2:	00000097          	auipc	ra,0x0
     6f6:	e74080e7          	jalr	-396(ra) # 566 <peek>
     6fa:	e905                	bnez	a0,72a <parseexec+0x5e>
     6fc:	89aa                	mv	s3,a0
    return parseblock(ps, es);

  ret = execcmd();
     6fe:	00000097          	auipc	ra,0x0
     702:	bc6080e7          	jalr	-1082(ra) # 2c4 <execcmd>
     706:	8c2a                	mv	s8,a0
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     708:	8656                	mv	a2,s5
     70a:	85d2                	mv	a1,s4
     70c:	00000097          	auipc	ra,0x0
     710:	ec4080e7          	jalr	-316(ra) # 5d0 <parseredirs>
     714:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     716:	008c0913          	addi	s2,s8,8
     71a:	00001b17          	auipc	s6,0x1
     71e:	cf6b0b13          	addi	s6,s6,-778 # 1410 <malloc+0x1a2>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
     722:	06100c93          	li	s9,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
     726:	4ba9                	li	s7,10
  while(!peek(ps, es, "|)&;")){
     728:	a0b1                	j	774 <parseexec+0xa8>
    return parseblock(ps, es);
     72a:	85d6                	mv	a1,s5
     72c:	8552                	mv	a0,s4
     72e:	00000097          	auipc	ra,0x0
     732:	1bc080e7          	jalr	444(ra) # 8ea <parseblock>
     736:	84aa                	mv	s1,a0
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     738:	8526                	mv	a0,s1
     73a:	70a6                	ld	ra,104(sp)
     73c:	7406                	ld	s0,96(sp)
     73e:	64e6                	ld	s1,88(sp)
     740:	6946                	ld	s2,80(sp)
     742:	69a6                	ld	s3,72(sp)
     744:	6a06                	ld	s4,64(sp)
     746:	7ae2                	ld	s5,56(sp)
     748:	7b42                	ld	s6,48(sp)
     74a:	7ba2                	ld	s7,40(sp)
     74c:	7c02                	ld	s8,32(sp)
     74e:	6ce2                	ld	s9,24(sp)
     750:	6165                	addi	sp,sp,112
     752:	8082                	ret
      panic("syntax");
     754:	00001517          	auipc	a0,0x1
     758:	ca450513          	addi	a0,a0,-860 # 13f8 <malloc+0x18a>
     75c:	00000097          	auipc	ra,0x0
     760:	8fa080e7          	jalr	-1798(ra) # 56 <panic>
    ret = parseredirs(ret, ps, es);
     764:	8656                	mv	a2,s5
     766:	85d2                	mv	a1,s4
     768:	8526                	mv	a0,s1
     76a:	00000097          	auipc	ra,0x0
     76e:	e66080e7          	jalr	-410(ra) # 5d0 <parseredirs>
     772:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     774:	865a                	mv	a2,s6
     776:	85d6                	mv	a1,s5
     778:	8552                	mv	a0,s4
     77a:	00000097          	auipc	ra,0x0
     77e:	dec080e7          	jalr	-532(ra) # 566 <peek>
     782:	e131                	bnez	a0,7c6 <parseexec+0xfa>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     784:	f9040693          	addi	a3,s0,-112
     788:	f9840613          	addi	a2,s0,-104
     78c:	85d6                	mv	a1,s5
     78e:	8552                	mv	a0,s4
     790:	00000097          	auipc	ra,0x0
     794:	c9a080e7          	jalr	-870(ra) # 42a <gettoken>
     798:	c51d                	beqz	a0,7c6 <parseexec+0xfa>
    if(tok != 'a')
     79a:	fb951de3          	bne	a0,s9,754 <parseexec+0x88>
    cmd->argv[argc] = q;
     79e:	f9843783          	ld	a5,-104(s0)
     7a2:	00f93023          	sd	a5,0(s2)
    cmd->eargv[argc] = eq;
     7a6:	f9043783          	ld	a5,-112(s0)
     7aa:	04f93823          	sd	a5,80(s2)
    argc++;
     7ae:	2985                	addiw	s3,s3,1
    if(argc >= MAXARGS)
     7b0:	0921                	addi	s2,s2,8
     7b2:	fb7999e3          	bne	s3,s7,764 <parseexec+0x98>
      panic("too many args");
     7b6:	00001517          	auipc	a0,0x1
     7ba:	c4a50513          	addi	a0,a0,-950 # 1400 <malloc+0x192>
     7be:	00000097          	auipc	ra,0x0
     7c2:	898080e7          	jalr	-1896(ra) # 56 <panic>
  cmd->argv[argc] = 0;
     7c6:	098e                	slli	s3,s3,0x3
     7c8:	99e2                	add	s3,s3,s8
     7ca:	0009b423          	sd	zero,8(s3)
  cmd->eargv[argc] = 0;
     7ce:	0409bc23          	sd	zero,88(s3)
  return ret;
     7d2:	b79d                	j	738 <parseexec+0x6c>

00000000000007d4 <parsepipe>:
{
     7d4:	7179                	addi	sp,sp,-48
     7d6:	f406                	sd	ra,40(sp)
     7d8:	f022                	sd	s0,32(sp)
     7da:	ec26                	sd	s1,24(sp)
     7dc:	e84a                	sd	s2,16(sp)
     7de:	e44e                	sd	s3,8(sp)
     7e0:	1800                	addi	s0,sp,48
     7e2:	892a                	mv	s2,a0
     7e4:	89ae                	mv	s3,a1
  cmd = parseexec(ps, es);
     7e6:	00000097          	auipc	ra,0x0
     7ea:	ee6080e7          	jalr	-282(ra) # 6cc <parseexec>
     7ee:	84aa                	mv	s1,a0
  if(peek(ps, es, "|")){
     7f0:	00001617          	auipc	a2,0x1
     7f4:	c2860613          	addi	a2,a2,-984 # 1418 <malloc+0x1aa>
     7f8:	85ce                	mv	a1,s3
     7fa:	854a                	mv	a0,s2
     7fc:	00000097          	auipc	ra,0x0
     800:	d6a080e7          	jalr	-662(ra) # 566 <peek>
     804:	e909                	bnez	a0,816 <parsepipe+0x42>
}
     806:	8526                	mv	a0,s1
     808:	70a2                	ld	ra,40(sp)
     80a:	7402                	ld	s0,32(sp)
     80c:	64e2                	ld	s1,24(sp)
     80e:	6942                	ld	s2,16(sp)
     810:	69a2                	ld	s3,8(sp)
     812:	6145                	addi	sp,sp,48
     814:	8082                	ret
    gettoken(ps, es, 0, 0);
     816:	4681                	li	a3,0
     818:	4601                	li	a2,0
     81a:	85ce                	mv	a1,s3
     81c:	854a                	mv	a0,s2
     81e:	00000097          	auipc	ra,0x0
     822:	c0c080e7          	jalr	-1012(ra) # 42a <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     826:	85ce                	mv	a1,s3
     828:	854a                	mv	a0,s2
     82a:	00000097          	auipc	ra,0x0
     82e:	faa080e7          	jalr	-86(ra) # 7d4 <parsepipe>
     832:	85aa                	mv	a1,a0
     834:	8526                	mv	a0,s1
     836:	00000097          	auipc	ra,0x0
     83a:	b2c080e7          	jalr	-1236(ra) # 362 <pipecmd>
     83e:	84aa                	mv	s1,a0
  return cmd;
     840:	b7d9                	j	806 <parsepipe+0x32>

0000000000000842 <parseline>:
{
     842:	7179                	addi	sp,sp,-48
     844:	f406                	sd	ra,40(sp)
     846:	f022                	sd	s0,32(sp)
     848:	ec26                	sd	s1,24(sp)
     84a:	e84a                	sd	s2,16(sp)
     84c:	e44e                	sd	s3,8(sp)
     84e:	e052                	sd	s4,0(sp)
     850:	1800                	addi	s0,sp,48
     852:	892a                	mv	s2,a0
     854:	89ae                	mv	s3,a1
  cmd = parsepipe(ps, es);
     856:	00000097          	auipc	ra,0x0
     85a:	f7e080e7          	jalr	-130(ra) # 7d4 <parsepipe>
     85e:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     860:	00001a17          	auipc	s4,0x1
     864:	bc0a0a13          	addi	s4,s4,-1088 # 1420 <malloc+0x1b2>
     868:	a839                	j	886 <parseline+0x44>
    gettoken(ps, es, 0, 0);
     86a:	4681                	li	a3,0
     86c:	4601                	li	a2,0
     86e:	85ce                	mv	a1,s3
     870:	854a                	mv	a0,s2
     872:	00000097          	auipc	ra,0x0
     876:	bb8080e7          	jalr	-1096(ra) # 42a <gettoken>
    cmd = backcmd(cmd);
     87a:	8526                	mv	a0,s1
     87c:	00000097          	auipc	ra,0x0
     880:	b72080e7          	jalr	-1166(ra) # 3ee <backcmd>
     884:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     886:	8652                	mv	a2,s4
     888:	85ce                	mv	a1,s3
     88a:	854a                	mv	a0,s2
     88c:	00000097          	auipc	ra,0x0
     890:	cda080e7          	jalr	-806(ra) # 566 <peek>
     894:	f979                	bnez	a0,86a <parseline+0x28>
  if(peek(ps, es, ";")){
     896:	00001617          	auipc	a2,0x1
     89a:	b9260613          	addi	a2,a2,-1134 # 1428 <malloc+0x1ba>
     89e:	85ce                	mv	a1,s3
     8a0:	854a                	mv	a0,s2
     8a2:	00000097          	auipc	ra,0x0
     8a6:	cc4080e7          	jalr	-828(ra) # 566 <peek>
     8aa:	e911                	bnez	a0,8be <parseline+0x7c>
}
     8ac:	8526                	mv	a0,s1
     8ae:	70a2                	ld	ra,40(sp)
     8b0:	7402                	ld	s0,32(sp)
     8b2:	64e2                	ld	s1,24(sp)
     8b4:	6942                	ld	s2,16(sp)
     8b6:	69a2                	ld	s3,8(sp)
     8b8:	6a02                	ld	s4,0(sp)
     8ba:	6145                	addi	sp,sp,48
     8bc:	8082                	ret
    gettoken(ps, es, 0, 0);
     8be:	4681                	li	a3,0
     8c0:	4601                	li	a2,0
     8c2:	85ce                	mv	a1,s3
     8c4:	854a                	mv	a0,s2
     8c6:	00000097          	auipc	ra,0x0
     8ca:	b64080e7          	jalr	-1180(ra) # 42a <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     8ce:	85ce                	mv	a1,s3
     8d0:	854a                	mv	a0,s2
     8d2:	00000097          	auipc	ra,0x0
     8d6:	f70080e7          	jalr	-144(ra) # 842 <parseline>
     8da:	85aa                	mv	a1,a0
     8dc:	8526                	mv	a0,s1
     8de:	00000097          	auipc	ra,0x0
     8e2:	aca080e7          	jalr	-1334(ra) # 3a8 <listcmd>
     8e6:	84aa                	mv	s1,a0
  return cmd;
     8e8:	b7d1                	j	8ac <parseline+0x6a>

00000000000008ea <parseblock>:
{
     8ea:	7179                	addi	sp,sp,-48
     8ec:	f406                	sd	ra,40(sp)
     8ee:	f022                	sd	s0,32(sp)
     8f0:	ec26                	sd	s1,24(sp)
     8f2:	e84a                	sd	s2,16(sp)
     8f4:	e44e                	sd	s3,8(sp)
     8f6:	1800                	addi	s0,sp,48
     8f8:	84aa                	mv	s1,a0
     8fa:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
     8fc:	00001617          	auipc	a2,0x1
     900:	af460613          	addi	a2,a2,-1292 # 13f0 <malloc+0x182>
     904:	00000097          	auipc	ra,0x0
     908:	c62080e7          	jalr	-926(ra) # 566 <peek>
     90c:	c12d                	beqz	a0,96e <parseblock+0x84>
  gettoken(ps, es, 0, 0);
     90e:	4681                	li	a3,0
     910:	4601                	li	a2,0
     912:	85ca                	mv	a1,s2
     914:	8526                	mv	a0,s1
     916:	00000097          	auipc	ra,0x0
     91a:	b14080e7          	jalr	-1260(ra) # 42a <gettoken>
  cmd = parseline(ps, es);
     91e:	85ca                	mv	a1,s2
     920:	8526                	mv	a0,s1
     922:	00000097          	auipc	ra,0x0
     926:	f20080e7          	jalr	-224(ra) # 842 <parseline>
     92a:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
     92c:	00001617          	auipc	a2,0x1
     930:	b1460613          	addi	a2,a2,-1260 # 1440 <malloc+0x1d2>
     934:	85ca                	mv	a1,s2
     936:	8526                	mv	a0,s1
     938:	00000097          	auipc	ra,0x0
     93c:	c2e080e7          	jalr	-978(ra) # 566 <peek>
     940:	cd1d                	beqz	a0,97e <parseblock+0x94>
  gettoken(ps, es, 0, 0);
     942:	4681                	li	a3,0
     944:	4601                	li	a2,0
     946:	85ca                	mv	a1,s2
     948:	8526                	mv	a0,s1
     94a:	00000097          	auipc	ra,0x0
     94e:	ae0080e7          	jalr	-1312(ra) # 42a <gettoken>
  cmd = parseredirs(cmd, ps, es);
     952:	864a                	mv	a2,s2
     954:	85a6                	mv	a1,s1
     956:	854e                	mv	a0,s3
     958:	00000097          	auipc	ra,0x0
     95c:	c78080e7          	jalr	-904(ra) # 5d0 <parseredirs>
}
     960:	70a2                	ld	ra,40(sp)
     962:	7402                	ld	s0,32(sp)
     964:	64e2                	ld	s1,24(sp)
     966:	6942                	ld	s2,16(sp)
     968:	69a2                	ld	s3,8(sp)
     96a:	6145                	addi	sp,sp,48
     96c:	8082                	ret
    panic("parseblock");
     96e:	00001517          	auipc	a0,0x1
     972:	ac250513          	addi	a0,a0,-1342 # 1430 <malloc+0x1c2>
     976:	fffff097          	auipc	ra,0xfffff
     97a:	6e0080e7          	jalr	1760(ra) # 56 <panic>
    panic("syntax - missing )");
     97e:	00001517          	auipc	a0,0x1
     982:	aca50513          	addi	a0,a0,-1334 # 1448 <malloc+0x1da>
     986:	fffff097          	auipc	ra,0xfffff
     98a:	6d0080e7          	jalr	1744(ra) # 56 <panic>

000000000000098e <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     98e:	1101                	addi	sp,sp,-32
     990:	ec06                	sd	ra,24(sp)
     992:	e822                	sd	s0,16(sp)
     994:	e426                	sd	s1,8(sp)
     996:	1000                	addi	s0,sp,32
     998:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     99a:	c521                	beqz	a0,9e2 <nulterminate+0x54>
    return 0;

  switch(cmd->type){
     99c:	4118                	lw	a4,0(a0)
     99e:	4795                	li	a5,5
     9a0:	04e7e163          	bltu	a5,a4,9e2 <nulterminate+0x54>
     9a4:	00056783          	lwu	a5,0(a0)
     9a8:	078a                	slli	a5,a5,0x2
     9aa:	00001717          	auipc	a4,0x1
     9ae:	afe70713          	addi	a4,a4,-1282 # 14a8 <malloc+0x23a>
     9b2:	97ba                	add	a5,a5,a4
     9b4:	439c                	lw	a5,0(a5)
     9b6:	97ba                	add	a5,a5,a4
     9b8:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     9ba:	651c                	ld	a5,8(a0)
     9bc:	c39d                	beqz	a5,9e2 <nulterminate+0x54>
     9be:	01050793          	addi	a5,a0,16
      *ecmd->eargv[i] = 0;
     9c2:	67b8                	ld	a4,72(a5)
     9c4:	00070023          	sb	zero,0(a4)
    for(i=0; ecmd->argv[i]; i++)
     9c8:	07a1                	addi	a5,a5,8
     9ca:	ff87b703          	ld	a4,-8(a5)
     9ce:	fb75                	bnez	a4,9c2 <nulterminate+0x34>
     9d0:	a809                	j	9e2 <nulterminate+0x54>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     9d2:	6508                	ld	a0,8(a0)
     9d4:	00000097          	auipc	ra,0x0
     9d8:	fba080e7          	jalr	-70(ra) # 98e <nulterminate>
    *rcmd->efile = 0;
     9dc:	6c9c                	ld	a5,24(s1)
     9de:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     9e2:	8526                	mv	a0,s1
     9e4:	60e2                	ld	ra,24(sp)
     9e6:	6442                	ld	s0,16(sp)
     9e8:	64a2                	ld	s1,8(sp)
     9ea:	6105                	addi	sp,sp,32
     9ec:	8082                	ret
    nulterminate(pcmd->left);
     9ee:	6508                	ld	a0,8(a0)
     9f0:	00000097          	auipc	ra,0x0
     9f4:	f9e080e7          	jalr	-98(ra) # 98e <nulterminate>
    nulterminate(pcmd->right);
     9f8:	6888                	ld	a0,16(s1)
     9fa:	00000097          	auipc	ra,0x0
     9fe:	f94080e7          	jalr	-108(ra) # 98e <nulterminate>
    break;
     a02:	b7c5                	j	9e2 <nulterminate+0x54>
    nulterminate(lcmd->left);
     a04:	6508                	ld	a0,8(a0)
     a06:	00000097          	auipc	ra,0x0
     a0a:	f88080e7          	jalr	-120(ra) # 98e <nulterminate>
    nulterminate(lcmd->right);
     a0e:	6888                	ld	a0,16(s1)
     a10:	00000097          	auipc	ra,0x0
     a14:	f7e080e7          	jalr	-130(ra) # 98e <nulterminate>
    break;
     a18:	b7e9                	j	9e2 <nulterminate+0x54>
    nulterminate(bcmd->cmd);
     a1a:	6508                	ld	a0,8(a0)
     a1c:	00000097          	auipc	ra,0x0
     a20:	f72080e7          	jalr	-142(ra) # 98e <nulterminate>
    break;
     a24:	bf7d                	j	9e2 <nulterminate+0x54>

0000000000000a26 <parsecmd>:
{
     a26:	7179                	addi	sp,sp,-48
     a28:	f406                	sd	ra,40(sp)
     a2a:	f022                	sd	s0,32(sp)
     a2c:	ec26                	sd	s1,24(sp)
     a2e:	e84a                	sd	s2,16(sp)
     a30:	1800                	addi	s0,sp,48
     a32:	fca43c23          	sd	a0,-40(s0)
  es = s + strlen(s);
     a36:	84aa                	mv	s1,a0
     a38:	00000097          	auipc	ra,0x0
     a3c:	1d2080e7          	jalr	466(ra) # c0a <strlen>
     a40:	1502                	slli	a0,a0,0x20
     a42:	9101                	srli	a0,a0,0x20
     a44:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
     a46:	85a6                	mv	a1,s1
     a48:	fd840513          	addi	a0,s0,-40
     a4c:	00000097          	auipc	ra,0x0
     a50:	df6080e7          	jalr	-522(ra) # 842 <parseline>
     a54:	892a                	mv	s2,a0
  peek(&s, es, "");
     a56:	00001617          	auipc	a2,0x1
     a5a:	a0a60613          	addi	a2,a2,-1526 # 1460 <malloc+0x1f2>
     a5e:	85a6                	mv	a1,s1
     a60:	fd840513          	addi	a0,s0,-40
     a64:	00000097          	auipc	ra,0x0
     a68:	b02080e7          	jalr	-1278(ra) # 566 <peek>
  if(s != es){
     a6c:	fd843603          	ld	a2,-40(s0)
     a70:	00961e63          	bne	a2,s1,a8c <parsecmd+0x66>
  nulterminate(cmd);
     a74:	854a                	mv	a0,s2
     a76:	00000097          	auipc	ra,0x0
     a7a:	f18080e7          	jalr	-232(ra) # 98e <nulterminate>
}
     a7e:	854a                	mv	a0,s2
     a80:	70a2                	ld	ra,40(sp)
     a82:	7402                	ld	s0,32(sp)
     a84:	64e2                	ld	s1,24(sp)
     a86:	6942                	ld	s2,16(sp)
     a88:	6145                	addi	sp,sp,48
     a8a:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
     a8c:	00001597          	auipc	a1,0x1
     a90:	9dc58593          	addi	a1,a1,-1572 # 1468 <malloc+0x1fa>
     a94:	4509                	li	a0,2
     a96:	00000097          	auipc	ra,0x0
     a9a:	6ec080e7          	jalr	1772(ra) # 1182 <fprintf>
    panic("syntax");
     a9e:	00001517          	auipc	a0,0x1
     aa2:	95a50513          	addi	a0,a0,-1702 # 13f8 <malloc+0x18a>
     aa6:	fffff097          	auipc	ra,0xfffff
     aaa:	5b0080e7          	jalr	1456(ra) # 56 <panic>

0000000000000aae <main>:
{
     aae:	7139                	addi	sp,sp,-64
     ab0:	fc06                	sd	ra,56(sp)
     ab2:	f822                	sd	s0,48(sp)
     ab4:	f426                	sd	s1,40(sp)
     ab6:	f04a                	sd	s2,32(sp)
     ab8:	ec4e                	sd	s3,24(sp)
     aba:	e852                	sd	s4,16(sp)
     abc:	e456                	sd	s5,8(sp)
     abe:	0080                	addi	s0,sp,64
  while((fd = open("console", O_RDWR)) >= 0){
     ac0:	00001497          	auipc	s1,0x1
     ac4:	9b848493          	addi	s1,s1,-1608 # 1478 <malloc+0x20a>
     ac8:	4589                	li	a1,2
     aca:	8526                	mv	a0,s1
     acc:	00000097          	auipc	ra,0x0
     ad0:	3a4080e7          	jalr	932(ra) # e70 <open>
     ad4:	00054963          	bltz	a0,ae6 <main+0x38>
    if(fd >= 3){
     ad8:	4789                	li	a5,2
     ada:	fea7d7e3          	bge	a5,a0,ac8 <main+0x1a>
      close(fd);
     ade:	00000097          	auipc	ra,0x0
     ae2:	37a080e7          	jalr	890(ra) # e58 <close>
  while(getcmd(buf, sizeof(buf)) >= 0){
     ae6:	00001497          	auipc	s1,0x1
     aea:	53a48493          	addi	s1,s1,1338 # 2020 <buf.0>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     aee:	06300913          	li	s2,99
     af2:	02000993          	li	s3,32
      if(chdir(buf+3) < 0)
     af6:	00001a17          	auipc	s4,0x1
     afa:	52da0a13          	addi	s4,s4,1325 # 2023 <buf.0+0x3>
        fprintf(2, "cannot cd %s\n", buf+3);
     afe:	00001a97          	auipc	s5,0x1
     b02:	982a8a93          	addi	s5,s5,-1662 # 1480 <malloc+0x212>
     b06:	a821                	j	b1e <main+0x70>
    if(fork1() == 0)
     b08:	fffff097          	auipc	ra,0xfffff
     b0c:	576080e7          	jalr	1398(ra) # 7e <fork1>
     b10:	c92d                	beqz	a0,b82 <main+0xd4>
    wait(0,0);
     b12:	4581                	li	a1,0
     b14:	4501                	li	a0,0
     b16:	00000097          	auipc	ra,0x0
     b1a:	322080e7          	jalr	802(ra) # e38 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
     b1e:	06400593          	li	a1,100
     b22:	8526                	mv	a0,s1
     b24:	fffff097          	auipc	ra,0xfffff
     b28:	4dc080e7          	jalr	1244(ra) # 0 <getcmd>
     b2c:	06054763          	bltz	a0,b9a <main+0xec>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     b30:	0004c783          	lbu	a5,0(s1)
     b34:	fd279ae3          	bne	a5,s2,b08 <main+0x5a>
     b38:	0014c703          	lbu	a4,1(s1)
     b3c:	06400793          	li	a5,100
     b40:	fcf714e3          	bne	a4,a5,b08 <main+0x5a>
     b44:	0024c783          	lbu	a5,2(s1)
     b48:	fd3790e3          	bne	a5,s3,b08 <main+0x5a>
      buf[strlen(buf)-1] = 0;  // chop \n
     b4c:	8526                	mv	a0,s1
     b4e:	00000097          	auipc	ra,0x0
     b52:	0bc080e7          	jalr	188(ra) # c0a <strlen>
     b56:	fff5079b          	addiw	a5,a0,-1
     b5a:	1782                	slli	a5,a5,0x20
     b5c:	9381                	srli	a5,a5,0x20
     b5e:	97a6                	add	a5,a5,s1
     b60:	00078023          	sb	zero,0(a5)
      if(chdir(buf+3) < 0)
     b64:	8552                	mv	a0,s4
     b66:	00000097          	auipc	ra,0x0
     b6a:	33a080e7          	jalr	826(ra) # ea0 <chdir>
     b6e:	fa0558e3          	bgez	a0,b1e <main+0x70>
        fprintf(2, "cannot cd %s\n", buf+3);
     b72:	8652                	mv	a2,s4
     b74:	85d6                	mv	a1,s5
     b76:	4509                	li	a0,2
     b78:	00000097          	auipc	ra,0x0
     b7c:	60a080e7          	jalr	1546(ra) # 1182 <fprintf>
     b80:	bf79                	j	b1e <main+0x70>
      runcmd(parsecmd(buf));
     b82:	00001517          	auipc	a0,0x1
     b86:	49e50513          	addi	a0,a0,1182 # 2020 <buf.0>
     b8a:	00000097          	auipc	ra,0x0
     b8e:	e9c080e7          	jalr	-356(ra) # a26 <parsecmd>
     b92:	fffff097          	auipc	ra,0xfffff
     b96:	51a080e7          	jalr	1306(ra) # ac <runcmd>
  exit(0,0);
     b9a:	4581                	li	a1,0
     b9c:	4501                	li	a0,0
     b9e:	00000097          	auipc	ra,0x0
     ba2:	292080e7          	jalr	658(ra) # e30 <exit>

0000000000000ba6 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
     ba6:	1141                	addi	sp,sp,-16
     ba8:	e406                	sd	ra,8(sp)
     baa:	e022                	sd	s0,0(sp)
     bac:	0800                	addi	s0,sp,16
  extern int main();
  main();
     bae:	00000097          	auipc	ra,0x0
     bb2:	f00080e7          	jalr	-256(ra) # aae <main>
  exit(0,0);
     bb6:	4581                	li	a1,0
     bb8:	4501                	li	a0,0
     bba:	00000097          	auipc	ra,0x0
     bbe:	276080e7          	jalr	630(ra) # e30 <exit>

0000000000000bc2 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     bc2:	1141                	addi	sp,sp,-16
     bc4:	e422                	sd	s0,8(sp)
     bc6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     bc8:	87aa                	mv	a5,a0
     bca:	0585                	addi	a1,a1,1
     bcc:	0785                	addi	a5,a5,1
     bce:	fff5c703          	lbu	a4,-1(a1)
     bd2:	fee78fa3          	sb	a4,-1(a5)
     bd6:	fb75                	bnez	a4,bca <strcpy+0x8>
    ;
  return os;
}
     bd8:	6422                	ld	s0,8(sp)
     bda:	0141                	addi	sp,sp,16
     bdc:	8082                	ret

0000000000000bde <strcmp>:

int
strcmp(const char *p, const char *q)
{
     bde:	1141                	addi	sp,sp,-16
     be0:	e422                	sd	s0,8(sp)
     be2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     be4:	00054783          	lbu	a5,0(a0)
     be8:	cb91                	beqz	a5,bfc <strcmp+0x1e>
     bea:	0005c703          	lbu	a4,0(a1)
     bee:	00f71763          	bne	a4,a5,bfc <strcmp+0x1e>
    p++, q++;
     bf2:	0505                	addi	a0,a0,1
     bf4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     bf6:	00054783          	lbu	a5,0(a0)
     bfa:	fbe5                	bnez	a5,bea <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     bfc:	0005c503          	lbu	a0,0(a1)
}
     c00:	40a7853b          	subw	a0,a5,a0
     c04:	6422                	ld	s0,8(sp)
     c06:	0141                	addi	sp,sp,16
     c08:	8082                	ret

0000000000000c0a <strlen>:

uint
strlen(const char *s)
{
     c0a:	1141                	addi	sp,sp,-16
     c0c:	e422                	sd	s0,8(sp)
     c0e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     c10:	00054783          	lbu	a5,0(a0)
     c14:	cf91                	beqz	a5,c30 <strlen+0x26>
     c16:	0505                	addi	a0,a0,1
     c18:	87aa                	mv	a5,a0
     c1a:	4685                	li	a3,1
     c1c:	9e89                	subw	a3,a3,a0
     c1e:	00f6853b          	addw	a0,a3,a5
     c22:	0785                	addi	a5,a5,1
     c24:	fff7c703          	lbu	a4,-1(a5)
     c28:	fb7d                	bnez	a4,c1e <strlen+0x14>
    ;
  return n;
}
     c2a:	6422                	ld	s0,8(sp)
     c2c:	0141                	addi	sp,sp,16
     c2e:	8082                	ret
  for(n = 0; s[n]; n++)
     c30:	4501                	li	a0,0
     c32:	bfe5                	j	c2a <strlen+0x20>

0000000000000c34 <memset>:

void*
memset(void *dst, int c, uint n)
{
     c34:	1141                	addi	sp,sp,-16
     c36:	e422                	sd	s0,8(sp)
     c38:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     c3a:	ca19                	beqz	a2,c50 <memset+0x1c>
     c3c:	87aa                	mv	a5,a0
     c3e:	1602                	slli	a2,a2,0x20
     c40:	9201                	srli	a2,a2,0x20
     c42:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     c46:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     c4a:	0785                	addi	a5,a5,1
     c4c:	fee79de3          	bne	a5,a4,c46 <memset+0x12>
  }
  return dst;
}
     c50:	6422                	ld	s0,8(sp)
     c52:	0141                	addi	sp,sp,16
     c54:	8082                	ret

0000000000000c56 <strchr>:

char*
strchr(const char *s, char c)
{
     c56:	1141                	addi	sp,sp,-16
     c58:	e422                	sd	s0,8(sp)
     c5a:	0800                	addi	s0,sp,16
  for(; *s; s++)
     c5c:	00054783          	lbu	a5,0(a0)
     c60:	cb99                	beqz	a5,c76 <strchr+0x20>
    if(*s == c)
     c62:	00f58763          	beq	a1,a5,c70 <strchr+0x1a>
  for(; *s; s++)
     c66:	0505                	addi	a0,a0,1
     c68:	00054783          	lbu	a5,0(a0)
     c6c:	fbfd                	bnez	a5,c62 <strchr+0xc>
      return (char*)s;
  return 0;
     c6e:	4501                	li	a0,0
}
     c70:	6422                	ld	s0,8(sp)
     c72:	0141                	addi	sp,sp,16
     c74:	8082                	ret
  return 0;
     c76:	4501                	li	a0,0
     c78:	bfe5                	j	c70 <strchr+0x1a>

0000000000000c7a <gets>:

char*
gets(char *buf, int max)
{
     c7a:	711d                	addi	sp,sp,-96
     c7c:	ec86                	sd	ra,88(sp)
     c7e:	e8a2                	sd	s0,80(sp)
     c80:	e4a6                	sd	s1,72(sp)
     c82:	e0ca                	sd	s2,64(sp)
     c84:	fc4e                	sd	s3,56(sp)
     c86:	f852                	sd	s4,48(sp)
     c88:	f456                	sd	s5,40(sp)
     c8a:	f05a                	sd	s6,32(sp)
     c8c:	ec5e                	sd	s7,24(sp)
     c8e:	1080                	addi	s0,sp,96
     c90:	8baa                	mv	s7,a0
     c92:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c94:	892a                	mv	s2,a0
     c96:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     c98:	4aa9                	li	s5,10
     c9a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     c9c:	89a6                	mv	s3,s1
     c9e:	2485                	addiw	s1,s1,1
     ca0:	0344d863          	bge	s1,s4,cd0 <gets+0x56>
    cc = read(0, &c, 1);
     ca4:	4605                	li	a2,1
     ca6:	faf40593          	addi	a1,s0,-81
     caa:	4501                	li	a0,0
     cac:	00000097          	auipc	ra,0x0
     cb0:	19c080e7          	jalr	412(ra) # e48 <read>
    if(cc < 1)
     cb4:	00a05e63          	blez	a0,cd0 <gets+0x56>
    buf[i++] = c;
     cb8:	faf44783          	lbu	a5,-81(s0)
     cbc:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     cc0:	01578763          	beq	a5,s5,cce <gets+0x54>
     cc4:	0905                	addi	s2,s2,1
     cc6:	fd679be3          	bne	a5,s6,c9c <gets+0x22>
  for(i=0; i+1 < max; ){
     cca:	89a6                	mv	s3,s1
     ccc:	a011                	j	cd0 <gets+0x56>
     cce:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     cd0:	99de                	add	s3,s3,s7
     cd2:	00098023          	sb	zero,0(s3)
  return buf;
}
     cd6:	855e                	mv	a0,s7
     cd8:	60e6                	ld	ra,88(sp)
     cda:	6446                	ld	s0,80(sp)
     cdc:	64a6                	ld	s1,72(sp)
     cde:	6906                	ld	s2,64(sp)
     ce0:	79e2                	ld	s3,56(sp)
     ce2:	7a42                	ld	s4,48(sp)
     ce4:	7aa2                	ld	s5,40(sp)
     ce6:	7b02                	ld	s6,32(sp)
     ce8:	6be2                	ld	s7,24(sp)
     cea:	6125                	addi	sp,sp,96
     cec:	8082                	ret

0000000000000cee <stat>:

int
stat(const char *n, struct stat *st)
{
     cee:	1101                	addi	sp,sp,-32
     cf0:	ec06                	sd	ra,24(sp)
     cf2:	e822                	sd	s0,16(sp)
     cf4:	e426                	sd	s1,8(sp)
     cf6:	e04a                	sd	s2,0(sp)
     cf8:	1000                	addi	s0,sp,32
     cfa:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     cfc:	4581                	li	a1,0
     cfe:	00000097          	auipc	ra,0x0
     d02:	172080e7          	jalr	370(ra) # e70 <open>
  if(fd < 0)
     d06:	02054563          	bltz	a0,d30 <stat+0x42>
     d0a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     d0c:	85ca                	mv	a1,s2
     d0e:	00000097          	auipc	ra,0x0
     d12:	17a080e7          	jalr	378(ra) # e88 <fstat>
     d16:	892a                	mv	s2,a0
  close(fd);
     d18:	8526                	mv	a0,s1
     d1a:	00000097          	auipc	ra,0x0
     d1e:	13e080e7          	jalr	318(ra) # e58 <close>
  return r;
}
     d22:	854a                	mv	a0,s2
     d24:	60e2                	ld	ra,24(sp)
     d26:	6442                	ld	s0,16(sp)
     d28:	64a2                	ld	s1,8(sp)
     d2a:	6902                	ld	s2,0(sp)
     d2c:	6105                	addi	sp,sp,32
     d2e:	8082                	ret
    return -1;
     d30:	597d                	li	s2,-1
     d32:	bfc5                	j	d22 <stat+0x34>

0000000000000d34 <atoi>:

int
atoi(const char *s)
{
     d34:	1141                	addi	sp,sp,-16
     d36:	e422                	sd	s0,8(sp)
     d38:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     d3a:	00054603          	lbu	a2,0(a0)
     d3e:	fd06079b          	addiw	a5,a2,-48
     d42:	0ff7f793          	andi	a5,a5,255
     d46:	4725                	li	a4,9
     d48:	02f76963          	bltu	a4,a5,d7a <atoi+0x46>
     d4c:	86aa                	mv	a3,a0
  n = 0;
     d4e:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
     d50:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
     d52:	0685                	addi	a3,a3,1
     d54:	0025179b          	slliw	a5,a0,0x2
     d58:	9fa9                	addw	a5,a5,a0
     d5a:	0017979b          	slliw	a5,a5,0x1
     d5e:	9fb1                	addw	a5,a5,a2
     d60:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     d64:	0006c603          	lbu	a2,0(a3)
     d68:	fd06071b          	addiw	a4,a2,-48
     d6c:	0ff77713          	andi	a4,a4,255
     d70:	fee5f1e3          	bgeu	a1,a4,d52 <atoi+0x1e>
  return n;
}
     d74:	6422                	ld	s0,8(sp)
     d76:	0141                	addi	sp,sp,16
     d78:	8082                	ret
  n = 0;
     d7a:	4501                	li	a0,0
     d7c:	bfe5                	j	d74 <atoi+0x40>

0000000000000d7e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     d7e:	1141                	addi	sp,sp,-16
     d80:	e422                	sd	s0,8(sp)
     d82:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     d84:	02b57463          	bgeu	a0,a1,dac <memmove+0x2e>
    while(n-- > 0)
     d88:	00c05f63          	blez	a2,da6 <memmove+0x28>
     d8c:	1602                	slli	a2,a2,0x20
     d8e:	9201                	srli	a2,a2,0x20
     d90:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     d94:	872a                	mv	a4,a0
      *dst++ = *src++;
     d96:	0585                	addi	a1,a1,1
     d98:	0705                	addi	a4,a4,1
     d9a:	fff5c683          	lbu	a3,-1(a1)
     d9e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     da2:	fee79ae3          	bne	a5,a4,d96 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     da6:	6422                	ld	s0,8(sp)
     da8:	0141                	addi	sp,sp,16
     daa:	8082                	ret
    dst += n;
     dac:	00c50733          	add	a4,a0,a2
    src += n;
     db0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     db2:	fec05ae3          	blez	a2,da6 <memmove+0x28>
     db6:	fff6079b          	addiw	a5,a2,-1
     dba:	1782                	slli	a5,a5,0x20
     dbc:	9381                	srli	a5,a5,0x20
     dbe:	fff7c793          	not	a5,a5
     dc2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     dc4:	15fd                	addi	a1,a1,-1
     dc6:	177d                	addi	a4,a4,-1
     dc8:	0005c683          	lbu	a3,0(a1)
     dcc:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     dd0:	fee79ae3          	bne	a5,a4,dc4 <memmove+0x46>
     dd4:	bfc9                	j	da6 <memmove+0x28>

0000000000000dd6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     dd6:	1141                	addi	sp,sp,-16
     dd8:	e422                	sd	s0,8(sp)
     dda:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     ddc:	ca05                	beqz	a2,e0c <memcmp+0x36>
     dde:	fff6069b          	addiw	a3,a2,-1
     de2:	1682                	slli	a3,a3,0x20
     de4:	9281                	srli	a3,a3,0x20
     de6:	0685                	addi	a3,a3,1
     de8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     dea:	00054783          	lbu	a5,0(a0)
     dee:	0005c703          	lbu	a4,0(a1)
     df2:	00e79863          	bne	a5,a4,e02 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     df6:	0505                	addi	a0,a0,1
    p2++;
     df8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     dfa:	fed518e3          	bne	a0,a3,dea <memcmp+0x14>
  }
  return 0;
     dfe:	4501                	li	a0,0
     e00:	a019                	j	e06 <memcmp+0x30>
      return *p1 - *p2;
     e02:	40e7853b          	subw	a0,a5,a4
}
     e06:	6422                	ld	s0,8(sp)
     e08:	0141                	addi	sp,sp,16
     e0a:	8082                	ret
  return 0;
     e0c:	4501                	li	a0,0
     e0e:	bfe5                	j	e06 <memcmp+0x30>

0000000000000e10 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     e10:	1141                	addi	sp,sp,-16
     e12:	e406                	sd	ra,8(sp)
     e14:	e022                	sd	s0,0(sp)
     e16:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     e18:	00000097          	auipc	ra,0x0
     e1c:	f66080e7          	jalr	-154(ra) # d7e <memmove>
}
     e20:	60a2                	ld	ra,8(sp)
     e22:	6402                	ld	s0,0(sp)
     e24:	0141                	addi	sp,sp,16
     e26:	8082                	ret

0000000000000e28 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     e28:	4885                	li	a7,1
 ecall
     e2a:	00000073          	ecall
 ret
     e2e:	8082                	ret

0000000000000e30 <exit>:
.global exit
exit:
 li a7, SYS_exit
     e30:	4889                	li	a7,2
 ecall
     e32:	00000073          	ecall
 ret
     e36:	8082                	ret

0000000000000e38 <wait>:
.global wait
wait:
 li a7, SYS_wait
     e38:	488d                	li	a7,3
 ecall
     e3a:	00000073          	ecall
 ret
     e3e:	8082                	ret

0000000000000e40 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     e40:	4891                	li	a7,4
 ecall
     e42:	00000073          	ecall
 ret
     e46:	8082                	ret

0000000000000e48 <read>:
.global read
read:
 li a7, SYS_read
     e48:	4895                	li	a7,5
 ecall
     e4a:	00000073          	ecall
 ret
     e4e:	8082                	ret

0000000000000e50 <write>:
.global write
write:
 li a7, SYS_write
     e50:	48c1                	li	a7,16
 ecall
     e52:	00000073          	ecall
 ret
     e56:	8082                	ret

0000000000000e58 <close>:
.global close
close:
 li a7, SYS_close
     e58:	48d5                	li	a7,21
 ecall
     e5a:	00000073          	ecall
 ret
     e5e:	8082                	ret

0000000000000e60 <kill>:
.global kill
kill:
 li a7, SYS_kill
     e60:	4899                	li	a7,6
 ecall
     e62:	00000073          	ecall
 ret
     e66:	8082                	ret

0000000000000e68 <exec>:
.global exec
exec:
 li a7, SYS_exec
     e68:	489d                	li	a7,7
 ecall
     e6a:	00000073          	ecall
 ret
     e6e:	8082                	ret

0000000000000e70 <open>:
.global open
open:
 li a7, SYS_open
     e70:	48bd                	li	a7,15
 ecall
     e72:	00000073          	ecall
 ret
     e76:	8082                	ret

0000000000000e78 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     e78:	48c5                	li	a7,17
 ecall
     e7a:	00000073          	ecall
 ret
     e7e:	8082                	ret

0000000000000e80 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     e80:	48c9                	li	a7,18
 ecall
     e82:	00000073          	ecall
 ret
     e86:	8082                	ret

0000000000000e88 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     e88:	48a1                	li	a7,8
 ecall
     e8a:	00000073          	ecall
 ret
     e8e:	8082                	ret

0000000000000e90 <link>:
.global link
link:
 li a7, SYS_link
     e90:	48cd                	li	a7,19
 ecall
     e92:	00000073          	ecall
 ret
     e96:	8082                	ret

0000000000000e98 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     e98:	48d1                	li	a7,20
 ecall
     e9a:	00000073          	ecall
 ret
     e9e:	8082                	ret

0000000000000ea0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     ea0:	48a5                	li	a7,9
 ecall
     ea2:	00000073          	ecall
 ret
     ea6:	8082                	ret

0000000000000ea8 <dup>:
.global dup
dup:
 li a7, SYS_dup
     ea8:	48a9                	li	a7,10
 ecall
     eaa:	00000073          	ecall
 ret
     eae:	8082                	ret

0000000000000eb0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     eb0:	48ad                	li	a7,11
 ecall
     eb2:	00000073          	ecall
 ret
     eb6:	8082                	ret

0000000000000eb8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     eb8:	48b1                	li	a7,12
 ecall
     eba:	00000073          	ecall
 ret
     ebe:	8082                	ret

0000000000000ec0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     ec0:	48b5                	li	a7,13
 ecall
     ec2:	00000073          	ecall
 ret
     ec6:	8082                	ret

0000000000000ec8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     ec8:	48b9                	li	a7,14
 ecall
     eca:	00000073          	ecall
 ret
     ece:	8082                	ret

0000000000000ed0 <memsize>:
.global memsize
memsize:
 li a7, SYS_memsize
     ed0:	48d9                	li	a7,22
 ecall
     ed2:	00000073          	ecall
 ret
     ed6:	8082                	ret

0000000000000ed8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     ed8:	1101                	addi	sp,sp,-32
     eda:	ec06                	sd	ra,24(sp)
     edc:	e822                	sd	s0,16(sp)
     ede:	1000                	addi	s0,sp,32
     ee0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     ee4:	4605                	li	a2,1
     ee6:	fef40593          	addi	a1,s0,-17
     eea:	00000097          	auipc	ra,0x0
     eee:	f66080e7          	jalr	-154(ra) # e50 <write>
}
     ef2:	60e2                	ld	ra,24(sp)
     ef4:	6442                	ld	s0,16(sp)
     ef6:	6105                	addi	sp,sp,32
     ef8:	8082                	ret

0000000000000efa <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     efa:	7139                	addi	sp,sp,-64
     efc:	fc06                	sd	ra,56(sp)
     efe:	f822                	sd	s0,48(sp)
     f00:	f426                	sd	s1,40(sp)
     f02:	f04a                	sd	s2,32(sp)
     f04:	ec4e                	sd	s3,24(sp)
     f06:	0080                	addi	s0,sp,64
     f08:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     f0a:	c299                	beqz	a3,f10 <printint+0x16>
     f0c:	0805c863          	bltz	a1,f9c <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     f10:	2581                	sext.w	a1,a1
  neg = 0;
     f12:	4881                	li	a7,0
     f14:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
     f18:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     f1a:	2601                	sext.w	a2,a2
     f1c:	00000517          	auipc	a0,0x0
     f20:	5ac50513          	addi	a0,a0,1452 # 14c8 <digits>
     f24:	883a                	mv	a6,a4
     f26:	2705                	addiw	a4,a4,1
     f28:	02c5f7bb          	remuw	a5,a1,a2
     f2c:	1782                	slli	a5,a5,0x20
     f2e:	9381                	srli	a5,a5,0x20
     f30:	97aa                	add	a5,a5,a0
     f32:	0007c783          	lbu	a5,0(a5)
     f36:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     f3a:	0005879b          	sext.w	a5,a1
     f3e:	02c5d5bb          	divuw	a1,a1,a2
     f42:	0685                	addi	a3,a3,1
     f44:	fec7f0e3          	bgeu	a5,a2,f24 <printint+0x2a>
  if(neg)
     f48:	00088b63          	beqz	a7,f5e <printint+0x64>
    buf[i++] = '-';
     f4c:	fd040793          	addi	a5,s0,-48
     f50:	973e                	add	a4,a4,a5
     f52:	02d00793          	li	a5,45
     f56:	fef70823          	sb	a5,-16(a4)
     f5a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
     f5e:	02e05863          	blez	a4,f8e <printint+0x94>
     f62:	fc040793          	addi	a5,s0,-64
     f66:	00e78933          	add	s2,a5,a4
     f6a:	fff78993          	addi	s3,a5,-1
     f6e:	99ba                	add	s3,s3,a4
     f70:	377d                	addiw	a4,a4,-1
     f72:	1702                	slli	a4,a4,0x20
     f74:	9301                	srli	a4,a4,0x20
     f76:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     f7a:	fff94583          	lbu	a1,-1(s2)
     f7e:	8526                	mv	a0,s1
     f80:	00000097          	auipc	ra,0x0
     f84:	f58080e7          	jalr	-168(ra) # ed8 <putc>
  while(--i >= 0)
     f88:	197d                	addi	s2,s2,-1
     f8a:	ff3918e3          	bne	s2,s3,f7a <printint+0x80>
}
     f8e:	70e2                	ld	ra,56(sp)
     f90:	7442                	ld	s0,48(sp)
     f92:	74a2                	ld	s1,40(sp)
     f94:	7902                	ld	s2,32(sp)
     f96:	69e2                	ld	s3,24(sp)
     f98:	6121                	addi	sp,sp,64
     f9a:	8082                	ret
    x = -xx;
     f9c:	40b005bb          	negw	a1,a1
    neg = 1;
     fa0:	4885                	li	a7,1
    x = -xx;
     fa2:	bf8d                	j	f14 <printint+0x1a>

0000000000000fa4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     fa4:	7119                	addi	sp,sp,-128
     fa6:	fc86                	sd	ra,120(sp)
     fa8:	f8a2                	sd	s0,112(sp)
     faa:	f4a6                	sd	s1,104(sp)
     fac:	f0ca                	sd	s2,96(sp)
     fae:	ecce                	sd	s3,88(sp)
     fb0:	e8d2                	sd	s4,80(sp)
     fb2:	e4d6                	sd	s5,72(sp)
     fb4:	e0da                	sd	s6,64(sp)
     fb6:	fc5e                	sd	s7,56(sp)
     fb8:	f862                	sd	s8,48(sp)
     fba:	f466                	sd	s9,40(sp)
     fbc:	f06a                	sd	s10,32(sp)
     fbe:	ec6e                	sd	s11,24(sp)
     fc0:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     fc2:	0005c903          	lbu	s2,0(a1)
     fc6:	18090f63          	beqz	s2,1164 <vprintf+0x1c0>
     fca:	8aaa                	mv	s5,a0
     fcc:	8b32                	mv	s6,a2
     fce:	00158493          	addi	s1,a1,1
  state = 0;
     fd2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     fd4:	02500a13          	li	s4,37
      if(c == 'd'){
     fd8:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
     fdc:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
     fe0:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
     fe4:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     fe8:	00000b97          	auipc	s7,0x0
     fec:	4e0b8b93          	addi	s7,s7,1248 # 14c8 <digits>
     ff0:	a839                	j	100e <vprintf+0x6a>
        putc(fd, c);
     ff2:	85ca                	mv	a1,s2
     ff4:	8556                	mv	a0,s5
     ff6:	00000097          	auipc	ra,0x0
     ffa:	ee2080e7          	jalr	-286(ra) # ed8 <putc>
     ffe:	a019                	j	1004 <vprintf+0x60>
    } else if(state == '%'){
    1000:	01498f63          	beq	s3,s4,101e <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    1004:	0485                	addi	s1,s1,1
    1006:	fff4c903          	lbu	s2,-1(s1)
    100a:	14090d63          	beqz	s2,1164 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    100e:	0009079b          	sext.w	a5,s2
    if(state == 0){
    1012:	fe0997e3          	bnez	s3,1000 <vprintf+0x5c>
      if(c == '%'){
    1016:	fd479ee3          	bne	a5,s4,ff2 <vprintf+0x4e>
        state = '%';
    101a:	89be                	mv	s3,a5
    101c:	b7e5                	j	1004 <vprintf+0x60>
      if(c == 'd'){
    101e:	05878063          	beq	a5,s8,105e <vprintf+0xba>
      } else if(c == 'l') {
    1022:	05978c63          	beq	a5,s9,107a <vprintf+0xd6>
      } else if(c == 'x') {
    1026:	07a78863          	beq	a5,s10,1096 <vprintf+0xf2>
      } else if(c == 'p') {
    102a:	09b78463          	beq	a5,s11,10b2 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    102e:	07300713          	li	a4,115
    1032:	0ce78663          	beq	a5,a4,10fe <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1036:	06300713          	li	a4,99
    103a:	0ee78e63          	beq	a5,a4,1136 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    103e:	11478863          	beq	a5,s4,114e <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1042:	85d2                	mv	a1,s4
    1044:	8556                	mv	a0,s5
    1046:	00000097          	auipc	ra,0x0
    104a:	e92080e7          	jalr	-366(ra) # ed8 <putc>
        putc(fd, c);
    104e:	85ca                	mv	a1,s2
    1050:	8556                	mv	a0,s5
    1052:	00000097          	auipc	ra,0x0
    1056:	e86080e7          	jalr	-378(ra) # ed8 <putc>
      }
      state = 0;
    105a:	4981                	li	s3,0
    105c:	b765                	j	1004 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    105e:	008b0913          	addi	s2,s6,8
    1062:	4685                	li	a3,1
    1064:	4629                	li	a2,10
    1066:	000b2583          	lw	a1,0(s6)
    106a:	8556                	mv	a0,s5
    106c:	00000097          	auipc	ra,0x0
    1070:	e8e080e7          	jalr	-370(ra) # efa <printint>
    1074:	8b4a                	mv	s6,s2
      state = 0;
    1076:	4981                	li	s3,0
    1078:	b771                	j	1004 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    107a:	008b0913          	addi	s2,s6,8
    107e:	4681                	li	a3,0
    1080:	4629                	li	a2,10
    1082:	000b2583          	lw	a1,0(s6)
    1086:	8556                	mv	a0,s5
    1088:	00000097          	auipc	ra,0x0
    108c:	e72080e7          	jalr	-398(ra) # efa <printint>
    1090:	8b4a                	mv	s6,s2
      state = 0;
    1092:	4981                	li	s3,0
    1094:	bf85                	j	1004 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    1096:	008b0913          	addi	s2,s6,8
    109a:	4681                	li	a3,0
    109c:	4641                	li	a2,16
    109e:	000b2583          	lw	a1,0(s6)
    10a2:	8556                	mv	a0,s5
    10a4:	00000097          	auipc	ra,0x0
    10a8:	e56080e7          	jalr	-426(ra) # efa <printint>
    10ac:	8b4a                	mv	s6,s2
      state = 0;
    10ae:	4981                	li	s3,0
    10b0:	bf91                	j	1004 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    10b2:	008b0793          	addi	a5,s6,8
    10b6:	f8f43423          	sd	a5,-120(s0)
    10ba:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    10be:	03000593          	li	a1,48
    10c2:	8556                	mv	a0,s5
    10c4:	00000097          	auipc	ra,0x0
    10c8:	e14080e7          	jalr	-492(ra) # ed8 <putc>
  putc(fd, 'x');
    10cc:	85ea                	mv	a1,s10
    10ce:	8556                	mv	a0,s5
    10d0:	00000097          	auipc	ra,0x0
    10d4:	e08080e7          	jalr	-504(ra) # ed8 <putc>
    10d8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    10da:	03c9d793          	srli	a5,s3,0x3c
    10de:	97de                	add	a5,a5,s7
    10e0:	0007c583          	lbu	a1,0(a5)
    10e4:	8556                	mv	a0,s5
    10e6:	00000097          	auipc	ra,0x0
    10ea:	df2080e7          	jalr	-526(ra) # ed8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    10ee:	0992                	slli	s3,s3,0x4
    10f0:	397d                	addiw	s2,s2,-1
    10f2:	fe0914e3          	bnez	s2,10da <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    10f6:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    10fa:	4981                	li	s3,0
    10fc:	b721                	j	1004 <vprintf+0x60>
        s = va_arg(ap, char*);
    10fe:	008b0993          	addi	s3,s6,8
    1102:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    1106:	02090163          	beqz	s2,1128 <vprintf+0x184>
        while(*s != 0){
    110a:	00094583          	lbu	a1,0(s2)
    110e:	c9a1                	beqz	a1,115e <vprintf+0x1ba>
          putc(fd, *s);
    1110:	8556                	mv	a0,s5
    1112:	00000097          	auipc	ra,0x0
    1116:	dc6080e7          	jalr	-570(ra) # ed8 <putc>
          s++;
    111a:	0905                	addi	s2,s2,1
        while(*s != 0){
    111c:	00094583          	lbu	a1,0(s2)
    1120:	f9e5                	bnez	a1,1110 <vprintf+0x16c>
        s = va_arg(ap, char*);
    1122:	8b4e                	mv	s6,s3
      state = 0;
    1124:	4981                	li	s3,0
    1126:	bdf9                	j	1004 <vprintf+0x60>
          s = "(null)";
    1128:	00000917          	auipc	s2,0x0
    112c:	39890913          	addi	s2,s2,920 # 14c0 <malloc+0x252>
        while(*s != 0){
    1130:	02800593          	li	a1,40
    1134:	bff1                	j	1110 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    1136:	008b0913          	addi	s2,s6,8
    113a:	000b4583          	lbu	a1,0(s6)
    113e:	8556                	mv	a0,s5
    1140:	00000097          	auipc	ra,0x0
    1144:	d98080e7          	jalr	-616(ra) # ed8 <putc>
    1148:	8b4a                	mv	s6,s2
      state = 0;
    114a:	4981                	li	s3,0
    114c:	bd65                	j	1004 <vprintf+0x60>
        putc(fd, c);
    114e:	85d2                	mv	a1,s4
    1150:	8556                	mv	a0,s5
    1152:	00000097          	auipc	ra,0x0
    1156:	d86080e7          	jalr	-634(ra) # ed8 <putc>
      state = 0;
    115a:	4981                	li	s3,0
    115c:	b565                	j	1004 <vprintf+0x60>
        s = va_arg(ap, char*);
    115e:	8b4e                	mv	s6,s3
      state = 0;
    1160:	4981                	li	s3,0
    1162:	b54d                	j	1004 <vprintf+0x60>
    }
  }
}
    1164:	70e6                	ld	ra,120(sp)
    1166:	7446                	ld	s0,112(sp)
    1168:	74a6                	ld	s1,104(sp)
    116a:	7906                	ld	s2,96(sp)
    116c:	69e6                	ld	s3,88(sp)
    116e:	6a46                	ld	s4,80(sp)
    1170:	6aa6                	ld	s5,72(sp)
    1172:	6b06                	ld	s6,64(sp)
    1174:	7be2                	ld	s7,56(sp)
    1176:	7c42                	ld	s8,48(sp)
    1178:	7ca2                	ld	s9,40(sp)
    117a:	7d02                	ld	s10,32(sp)
    117c:	6de2                	ld	s11,24(sp)
    117e:	6109                	addi	sp,sp,128
    1180:	8082                	ret

0000000000001182 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1182:	715d                	addi	sp,sp,-80
    1184:	ec06                	sd	ra,24(sp)
    1186:	e822                	sd	s0,16(sp)
    1188:	1000                	addi	s0,sp,32
    118a:	e010                	sd	a2,0(s0)
    118c:	e414                	sd	a3,8(s0)
    118e:	e818                	sd	a4,16(s0)
    1190:	ec1c                	sd	a5,24(s0)
    1192:	03043023          	sd	a6,32(s0)
    1196:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    119a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    119e:	8622                	mv	a2,s0
    11a0:	00000097          	auipc	ra,0x0
    11a4:	e04080e7          	jalr	-508(ra) # fa4 <vprintf>
}
    11a8:	60e2                	ld	ra,24(sp)
    11aa:	6442                	ld	s0,16(sp)
    11ac:	6161                	addi	sp,sp,80
    11ae:	8082                	ret

00000000000011b0 <printf>:

void
printf(const char *fmt, ...)
{
    11b0:	711d                	addi	sp,sp,-96
    11b2:	ec06                	sd	ra,24(sp)
    11b4:	e822                	sd	s0,16(sp)
    11b6:	1000                	addi	s0,sp,32
    11b8:	e40c                	sd	a1,8(s0)
    11ba:	e810                	sd	a2,16(s0)
    11bc:	ec14                	sd	a3,24(s0)
    11be:	f018                	sd	a4,32(s0)
    11c0:	f41c                	sd	a5,40(s0)
    11c2:	03043823          	sd	a6,48(s0)
    11c6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    11ca:	00840613          	addi	a2,s0,8
    11ce:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    11d2:	85aa                	mv	a1,a0
    11d4:	4505                	li	a0,1
    11d6:	00000097          	auipc	ra,0x0
    11da:	dce080e7          	jalr	-562(ra) # fa4 <vprintf>
}
    11de:	60e2                	ld	ra,24(sp)
    11e0:	6442                	ld	s0,16(sp)
    11e2:	6125                	addi	sp,sp,96
    11e4:	8082                	ret

00000000000011e6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    11e6:	1141                	addi	sp,sp,-16
    11e8:	e422                	sd	s0,8(sp)
    11ea:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    11ec:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11f0:	00001797          	auipc	a5,0x1
    11f4:	e207b783          	ld	a5,-480(a5) # 2010 <freep>
    11f8:	a805                	j	1228 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    11fa:	4618                	lw	a4,8(a2)
    11fc:	9db9                	addw	a1,a1,a4
    11fe:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1202:	6398                	ld	a4,0(a5)
    1204:	6318                	ld	a4,0(a4)
    1206:	fee53823          	sd	a4,-16(a0)
    120a:	a091                	j	124e <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    120c:	ff852703          	lw	a4,-8(a0)
    1210:	9e39                	addw	a2,a2,a4
    1212:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    1214:	ff053703          	ld	a4,-16(a0)
    1218:	e398                	sd	a4,0(a5)
    121a:	a099                	j	1260 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    121c:	6398                	ld	a4,0(a5)
    121e:	00e7e463          	bltu	a5,a4,1226 <free+0x40>
    1222:	00e6ea63          	bltu	a3,a4,1236 <free+0x50>
{
    1226:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1228:	fed7fae3          	bgeu	a5,a3,121c <free+0x36>
    122c:	6398                	ld	a4,0(a5)
    122e:	00e6e463          	bltu	a3,a4,1236 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1232:	fee7eae3          	bltu	a5,a4,1226 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    1236:	ff852583          	lw	a1,-8(a0)
    123a:	6390                	ld	a2,0(a5)
    123c:	02059713          	slli	a4,a1,0x20
    1240:	9301                	srli	a4,a4,0x20
    1242:	0712                	slli	a4,a4,0x4
    1244:	9736                	add	a4,a4,a3
    1246:	fae60ae3          	beq	a2,a4,11fa <free+0x14>
    bp->s.ptr = p->s.ptr;
    124a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    124e:	4790                	lw	a2,8(a5)
    1250:	02061713          	slli	a4,a2,0x20
    1254:	9301                	srli	a4,a4,0x20
    1256:	0712                	slli	a4,a4,0x4
    1258:	973e                	add	a4,a4,a5
    125a:	fae689e3          	beq	a3,a4,120c <free+0x26>
  } else
    p->s.ptr = bp;
    125e:	e394                	sd	a3,0(a5)
  freep = p;
    1260:	00001717          	auipc	a4,0x1
    1264:	daf73823          	sd	a5,-592(a4) # 2010 <freep>
}
    1268:	6422                	ld	s0,8(sp)
    126a:	0141                	addi	sp,sp,16
    126c:	8082                	ret

000000000000126e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    126e:	7139                	addi	sp,sp,-64
    1270:	fc06                	sd	ra,56(sp)
    1272:	f822                	sd	s0,48(sp)
    1274:	f426                	sd	s1,40(sp)
    1276:	f04a                	sd	s2,32(sp)
    1278:	ec4e                	sd	s3,24(sp)
    127a:	e852                	sd	s4,16(sp)
    127c:	e456                	sd	s5,8(sp)
    127e:	e05a                	sd	s6,0(sp)
    1280:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1282:	02051493          	slli	s1,a0,0x20
    1286:	9081                	srli	s1,s1,0x20
    1288:	04bd                	addi	s1,s1,15
    128a:	8091                	srli	s1,s1,0x4
    128c:	0014899b          	addiw	s3,s1,1
    1290:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    1292:	00001517          	auipc	a0,0x1
    1296:	d7e53503          	ld	a0,-642(a0) # 2010 <freep>
    129a:	c515                	beqz	a0,12c6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    129c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    129e:	4798                	lw	a4,8(a5)
    12a0:	02977f63          	bgeu	a4,s1,12de <malloc+0x70>
    12a4:	8a4e                	mv	s4,s3
    12a6:	0009871b          	sext.w	a4,s3
    12aa:	6685                	lui	a3,0x1
    12ac:	00d77363          	bgeu	a4,a3,12b2 <malloc+0x44>
    12b0:	6a05                	lui	s4,0x1
    12b2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    12b6:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    12ba:	00001917          	auipc	s2,0x1
    12be:	d5690913          	addi	s2,s2,-682 # 2010 <freep>
  if(p == (char*)-1)
    12c2:	5afd                	li	s5,-1
    12c4:	a88d                	j	1336 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    12c6:	00001797          	auipc	a5,0x1
    12ca:	dc278793          	addi	a5,a5,-574 # 2088 <base>
    12ce:	00001717          	auipc	a4,0x1
    12d2:	d4f73123          	sd	a5,-702(a4) # 2010 <freep>
    12d6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    12d8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    12dc:	b7e1                	j	12a4 <malloc+0x36>
      if(p->s.size == nunits)
    12de:	02e48b63          	beq	s1,a4,1314 <malloc+0xa6>
        p->s.size -= nunits;
    12e2:	4137073b          	subw	a4,a4,s3
    12e6:	c798                	sw	a4,8(a5)
        p += p->s.size;
    12e8:	1702                	slli	a4,a4,0x20
    12ea:	9301                	srli	a4,a4,0x20
    12ec:	0712                	slli	a4,a4,0x4
    12ee:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    12f0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    12f4:	00001717          	auipc	a4,0x1
    12f8:	d0a73e23          	sd	a0,-740(a4) # 2010 <freep>
      return (void*)(p + 1);
    12fc:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1300:	70e2                	ld	ra,56(sp)
    1302:	7442                	ld	s0,48(sp)
    1304:	74a2                	ld	s1,40(sp)
    1306:	7902                	ld	s2,32(sp)
    1308:	69e2                	ld	s3,24(sp)
    130a:	6a42                	ld	s4,16(sp)
    130c:	6aa2                	ld	s5,8(sp)
    130e:	6b02                	ld	s6,0(sp)
    1310:	6121                	addi	sp,sp,64
    1312:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    1314:	6398                	ld	a4,0(a5)
    1316:	e118                	sd	a4,0(a0)
    1318:	bff1                	j	12f4 <malloc+0x86>
  hp->s.size = nu;
    131a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    131e:	0541                	addi	a0,a0,16
    1320:	00000097          	auipc	ra,0x0
    1324:	ec6080e7          	jalr	-314(ra) # 11e6 <free>
  return freep;
    1328:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    132c:	d971                	beqz	a0,1300 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    132e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1330:	4798                	lw	a4,8(a5)
    1332:	fa9776e3          	bgeu	a4,s1,12de <malloc+0x70>
    if(p == freep)
    1336:	00093703          	ld	a4,0(s2)
    133a:	853e                	mv	a0,a5
    133c:	fef719e3          	bne	a4,a5,132e <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    1340:	8552                	mv	a0,s4
    1342:	00000097          	auipc	ra,0x0
    1346:	b76080e7          	jalr	-1162(ra) # eb8 <sbrk>
  if(p == (char*)-1)
    134a:	fd5518e3          	bne	a0,s5,131a <malloc+0xac>
        return 0;
    134e:	4501                	li	a0,0
    1350:	bf45                	j	1300 <malloc+0x92>
