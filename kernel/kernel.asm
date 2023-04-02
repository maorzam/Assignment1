
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	8a013103          	ld	sp,-1888(sp) # 800088a0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	078000ef          	jal	ra,8000008e <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <timerinit>:
// at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    8000001c:	1141                	addi	sp,sp,-16
    8000001e:	e422                	sd	s0,8(sp)
    80000020:	0800                	addi	s0,sp,16
// which hart (core) is this?
static inline uint64
r_mhartid()
{
  uint64 x;
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80000022:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80000026:	0007869b          	sext.w	a3,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    8000002a:	0037979b          	slliw	a5,a5,0x3
    8000002e:	02004737          	lui	a4,0x2004
    80000032:	97ba                	add	a5,a5,a4
    80000034:	0200c737          	lui	a4,0x200c
    80000038:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000003c:	000f4637          	lui	a2,0xf4
    80000040:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80000044:	95b2                	add	a1,a1,a2
    80000046:	e38c                	sd	a1,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    80000048:	00269713          	slli	a4,a3,0x2
    8000004c:	9736                	add	a4,a4,a3
    8000004e:	00371693          	slli	a3,a4,0x3
    80000052:	00009717          	auipc	a4,0x9
    80000056:	8ae70713          	addi	a4,a4,-1874 # 80008900 <timer_scratch>
    8000005a:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    8000005c:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    8000005e:	f310                	sd	a2,32(a4)
}

static inline void 
w_mscratch(uint64 x)
{
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80000060:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    80000064:	00006797          	auipc	a5,0x6
    80000068:	d1c78793          	addi	a5,a5,-740 # 80005d80 <timervec>
    8000006c:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80000070:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80000074:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80000078:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    8000007c:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80000080:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80000084:	30479073          	csrw	mie,a5
}
    80000088:	6422                	ld	s0,8(sp)
    8000008a:	0141                	addi	sp,sp,16
    8000008c:	8082                	ret

000000008000008e <start>:
{
    8000008e:	1141                	addi	sp,sp,-16
    80000090:	e406                	sd	ra,8(sp)
    80000092:	e022                	sd	s0,0(sp)
    80000094:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80000096:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    8000009a:	7779                	lui	a4,0xffffe
    8000009c:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffdb88f>
    800000a0:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    800000a2:	6705                	lui	a4,0x1
    800000a4:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800000a8:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    800000aa:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    800000ae:	00001797          	auipc	a5,0x1
    800000b2:	dca78793          	addi	a5,a5,-566 # 80000e78 <main>
    800000b6:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    800000ba:	4781                	li	a5,0
    800000bc:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    800000c0:	67c1                	lui	a5,0x10
    800000c2:	17fd                	addi	a5,a5,-1
    800000c4:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    800000c8:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    800000cc:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    800000d0:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    800000d4:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    800000d8:	57fd                	li	a5,-1
    800000da:	83a9                	srli	a5,a5,0xa
    800000dc:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    800000e0:	47bd                	li	a5,15
    800000e2:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    800000e6:	00000097          	auipc	ra,0x0
    800000ea:	f36080e7          	jalr	-202(ra) # 8000001c <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800000ee:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    800000f2:	2781                	sext.w	a5,a5
}

static inline void 
w_tp(uint64 x)
{
  asm volatile("mv tp, %0" : : "r" (x));
    800000f4:	823e                	mv	tp,a5
  asm volatile("mret");
    800000f6:	30200073          	mret
}
    800000fa:	60a2                	ld	ra,8(sp)
    800000fc:	6402                	ld	s0,0(sp)
    800000fe:	0141                	addi	sp,sp,16
    80000100:	8082                	ret

0000000080000102 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80000102:	715d                	addi	sp,sp,-80
    80000104:	e486                	sd	ra,72(sp)
    80000106:	e0a2                	sd	s0,64(sp)
    80000108:	fc26                	sd	s1,56(sp)
    8000010a:	f84a                	sd	s2,48(sp)
    8000010c:	f44e                	sd	s3,40(sp)
    8000010e:	f052                	sd	s4,32(sp)
    80000110:	ec56                	sd	s5,24(sp)
    80000112:	0880                	addi	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    80000114:	04c05663          	blez	a2,80000160 <consolewrite+0x5e>
    80000118:	8a2a                	mv	s4,a0
    8000011a:	84ae                	mv	s1,a1
    8000011c:	89b2                	mv	s3,a2
    8000011e:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80000120:	5afd                	li	s5,-1
    80000122:	4685                	li	a3,1
    80000124:	8626                	mv	a2,s1
    80000126:	85d2                	mv	a1,s4
    80000128:	fbf40513          	addi	a0,s0,-65
    8000012c:	00002097          	auipc	ra,0x2
    80000130:	4c4080e7          	jalr	1220(ra) # 800025f0 <either_copyin>
    80000134:	01550c63          	beq	a0,s5,8000014c <consolewrite+0x4a>
      break;
    uartputc(c);
    80000138:	fbf44503          	lbu	a0,-65(s0)
    8000013c:	00000097          	auipc	ra,0x0
    80000140:	780080e7          	jalr	1920(ra) # 800008bc <uartputc>
  for(i = 0; i < n; i++){
    80000144:	2905                	addiw	s2,s2,1
    80000146:	0485                	addi	s1,s1,1
    80000148:	fd299de3          	bne	s3,s2,80000122 <consolewrite+0x20>
  }

  return i;
}
    8000014c:	854a                	mv	a0,s2
    8000014e:	60a6                	ld	ra,72(sp)
    80000150:	6406                	ld	s0,64(sp)
    80000152:	74e2                	ld	s1,56(sp)
    80000154:	7942                	ld	s2,48(sp)
    80000156:	79a2                	ld	s3,40(sp)
    80000158:	7a02                	ld	s4,32(sp)
    8000015a:	6ae2                	ld	s5,24(sp)
    8000015c:	6161                	addi	sp,sp,80
    8000015e:	8082                	ret
  for(i = 0; i < n; i++){
    80000160:	4901                	li	s2,0
    80000162:	b7ed                	j	8000014c <consolewrite+0x4a>

0000000080000164 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80000164:	7159                	addi	sp,sp,-112
    80000166:	f486                	sd	ra,104(sp)
    80000168:	f0a2                	sd	s0,96(sp)
    8000016a:	eca6                	sd	s1,88(sp)
    8000016c:	e8ca                	sd	s2,80(sp)
    8000016e:	e4ce                	sd	s3,72(sp)
    80000170:	e0d2                	sd	s4,64(sp)
    80000172:	fc56                	sd	s5,56(sp)
    80000174:	f85a                	sd	s6,48(sp)
    80000176:	f45e                	sd	s7,40(sp)
    80000178:	f062                	sd	s8,32(sp)
    8000017a:	ec66                	sd	s9,24(sp)
    8000017c:	e86a                	sd	s10,16(sp)
    8000017e:	1880                	addi	s0,sp,112
    80000180:	8aaa                	mv	s5,a0
    80000182:	8a2e                	mv	s4,a1
    80000184:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80000186:	00060b1b          	sext.w	s6,a2
  acquire(&cons.lock);
    8000018a:	00011517          	auipc	a0,0x11
    8000018e:	8b650513          	addi	a0,a0,-1866 # 80010a40 <cons>
    80000192:	00001097          	auipc	ra,0x1
    80000196:	a44080e7          	jalr	-1468(ra) # 80000bd6 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    8000019a:	00011497          	auipc	s1,0x11
    8000019e:	8a648493          	addi	s1,s1,-1882 # 80010a40 <cons>
      if(killed(myproc())){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    800001a2:	00011917          	auipc	s2,0x11
    800001a6:	93690913          	addi	s2,s2,-1738 # 80010ad8 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];

    if(c == C('D')){  // end-of-file
    800001aa:	4b91                	li	s7,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    800001ac:	5c7d                	li	s8,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    800001ae:	4ca9                	li	s9,10
  while(n > 0){
    800001b0:	07305b63          	blez	s3,80000226 <consoleread+0xc2>
    while(cons.r == cons.w){
    800001b4:	0984a783          	lw	a5,152(s1)
    800001b8:	09c4a703          	lw	a4,156(s1)
    800001bc:	02f71763          	bne	a4,a5,800001ea <consoleread+0x86>
      if(killed(myproc())){
    800001c0:	00001097          	auipc	ra,0x1
    800001c4:	7fc080e7          	jalr	2044(ra) # 800019bc <myproc>
    800001c8:	00002097          	auipc	ra,0x2
    800001cc:	230080e7          	jalr	560(ra) # 800023f8 <killed>
    800001d0:	e535                	bnez	a0,8000023c <consoleread+0xd8>
      sleep(&cons.r, &cons.lock);
    800001d2:	85a6                	mv	a1,s1
    800001d4:	854a                	mv	a0,s2
    800001d6:	00002097          	auipc	ra,0x2
    800001da:	f52080e7          	jalr	-174(ra) # 80002128 <sleep>
    while(cons.r == cons.w){
    800001de:	0984a783          	lw	a5,152(s1)
    800001e2:	09c4a703          	lw	a4,156(s1)
    800001e6:	fcf70de3          	beq	a4,a5,800001c0 <consoleread+0x5c>
    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    800001ea:	0017871b          	addiw	a4,a5,1
    800001ee:	08e4ac23          	sw	a4,152(s1)
    800001f2:	07f7f713          	andi	a4,a5,127
    800001f6:	9726                	add	a4,a4,s1
    800001f8:	01874703          	lbu	a4,24(a4)
    800001fc:	00070d1b          	sext.w	s10,a4
    if(c == C('D')){  // end-of-file
    80000200:	077d0563          	beq	s10,s7,8000026a <consoleread+0x106>
    cbuf = c;
    80000204:	f8e40fa3          	sb	a4,-97(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80000208:	4685                	li	a3,1
    8000020a:	f9f40613          	addi	a2,s0,-97
    8000020e:	85d2                	mv	a1,s4
    80000210:	8556                	mv	a0,s5
    80000212:	00002097          	auipc	ra,0x2
    80000216:	388080e7          	jalr	904(ra) # 8000259a <either_copyout>
    8000021a:	01850663          	beq	a0,s8,80000226 <consoleread+0xc2>
    dst++;
    8000021e:	0a05                	addi	s4,s4,1
    --n;
    80000220:	39fd                	addiw	s3,s3,-1
    if(c == '\n'){
    80000222:	f99d17e3          	bne	s10,s9,800001b0 <consoleread+0x4c>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80000226:	00011517          	auipc	a0,0x11
    8000022a:	81a50513          	addi	a0,a0,-2022 # 80010a40 <cons>
    8000022e:	00001097          	auipc	ra,0x1
    80000232:	a5c080e7          	jalr	-1444(ra) # 80000c8a <release>

  return target - n;
    80000236:	413b053b          	subw	a0,s6,s3
    8000023a:	a811                	j	8000024e <consoleread+0xea>
        release(&cons.lock);
    8000023c:	00011517          	auipc	a0,0x11
    80000240:	80450513          	addi	a0,a0,-2044 # 80010a40 <cons>
    80000244:	00001097          	auipc	ra,0x1
    80000248:	a46080e7          	jalr	-1466(ra) # 80000c8a <release>
        return -1;
    8000024c:	557d                	li	a0,-1
}
    8000024e:	70a6                	ld	ra,104(sp)
    80000250:	7406                	ld	s0,96(sp)
    80000252:	64e6                	ld	s1,88(sp)
    80000254:	6946                	ld	s2,80(sp)
    80000256:	69a6                	ld	s3,72(sp)
    80000258:	6a06                	ld	s4,64(sp)
    8000025a:	7ae2                	ld	s5,56(sp)
    8000025c:	7b42                	ld	s6,48(sp)
    8000025e:	7ba2                	ld	s7,40(sp)
    80000260:	7c02                	ld	s8,32(sp)
    80000262:	6ce2                	ld	s9,24(sp)
    80000264:	6d42                	ld	s10,16(sp)
    80000266:	6165                	addi	sp,sp,112
    80000268:	8082                	ret
      if(n < target){
    8000026a:	0009871b          	sext.w	a4,s3
    8000026e:	fb677ce3          	bgeu	a4,s6,80000226 <consoleread+0xc2>
        cons.r--;
    80000272:	00011717          	auipc	a4,0x11
    80000276:	86f72323          	sw	a5,-1946(a4) # 80010ad8 <cons+0x98>
    8000027a:	b775                	j	80000226 <consoleread+0xc2>

000000008000027c <consputc>:
{
    8000027c:	1141                	addi	sp,sp,-16
    8000027e:	e406                	sd	ra,8(sp)
    80000280:	e022                	sd	s0,0(sp)
    80000282:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80000284:	10000793          	li	a5,256
    80000288:	00f50a63          	beq	a0,a5,8000029c <consputc+0x20>
    uartputc_sync(c);
    8000028c:	00000097          	auipc	ra,0x0
    80000290:	55e080e7          	jalr	1374(ra) # 800007ea <uartputc_sync>
}
    80000294:	60a2                	ld	ra,8(sp)
    80000296:	6402                	ld	s0,0(sp)
    80000298:	0141                	addi	sp,sp,16
    8000029a:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    8000029c:	4521                	li	a0,8
    8000029e:	00000097          	auipc	ra,0x0
    800002a2:	54c080e7          	jalr	1356(ra) # 800007ea <uartputc_sync>
    800002a6:	02000513          	li	a0,32
    800002aa:	00000097          	auipc	ra,0x0
    800002ae:	540080e7          	jalr	1344(ra) # 800007ea <uartputc_sync>
    800002b2:	4521                	li	a0,8
    800002b4:	00000097          	auipc	ra,0x0
    800002b8:	536080e7          	jalr	1334(ra) # 800007ea <uartputc_sync>
    800002bc:	bfe1                	j	80000294 <consputc+0x18>

00000000800002be <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800002be:	1101                	addi	sp,sp,-32
    800002c0:	ec06                	sd	ra,24(sp)
    800002c2:	e822                	sd	s0,16(sp)
    800002c4:	e426                	sd	s1,8(sp)
    800002c6:	e04a                	sd	s2,0(sp)
    800002c8:	1000                	addi	s0,sp,32
    800002ca:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    800002cc:	00010517          	auipc	a0,0x10
    800002d0:	77450513          	addi	a0,a0,1908 # 80010a40 <cons>
    800002d4:	00001097          	auipc	ra,0x1
    800002d8:	902080e7          	jalr	-1790(ra) # 80000bd6 <acquire>

  switch(c){
    800002dc:	47d5                	li	a5,21
    800002de:	0af48663          	beq	s1,a5,8000038a <consoleintr+0xcc>
    800002e2:	0297ca63          	blt	a5,s1,80000316 <consoleintr+0x58>
    800002e6:	47a1                	li	a5,8
    800002e8:	0ef48763          	beq	s1,a5,800003d6 <consoleintr+0x118>
    800002ec:	47c1                	li	a5,16
    800002ee:	10f49a63          	bne	s1,a5,80000402 <consoleintr+0x144>
  case C('P'):  // Print process list.
    procdump();
    800002f2:	00002097          	auipc	ra,0x2
    800002f6:	354080e7          	jalr	852(ra) # 80002646 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    800002fa:	00010517          	auipc	a0,0x10
    800002fe:	74650513          	addi	a0,a0,1862 # 80010a40 <cons>
    80000302:	00001097          	auipc	ra,0x1
    80000306:	988080e7          	jalr	-1656(ra) # 80000c8a <release>
}
    8000030a:	60e2                	ld	ra,24(sp)
    8000030c:	6442                	ld	s0,16(sp)
    8000030e:	64a2                	ld	s1,8(sp)
    80000310:	6902                	ld	s2,0(sp)
    80000312:	6105                	addi	sp,sp,32
    80000314:	8082                	ret
  switch(c){
    80000316:	07f00793          	li	a5,127
    8000031a:	0af48e63          	beq	s1,a5,800003d6 <consoleintr+0x118>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    8000031e:	00010717          	auipc	a4,0x10
    80000322:	72270713          	addi	a4,a4,1826 # 80010a40 <cons>
    80000326:	0a072783          	lw	a5,160(a4)
    8000032a:	09872703          	lw	a4,152(a4)
    8000032e:	9f99                	subw	a5,a5,a4
    80000330:	07f00713          	li	a4,127
    80000334:	fcf763e3          	bltu	a4,a5,800002fa <consoleintr+0x3c>
      c = (c == '\r') ? '\n' : c;
    80000338:	47b5                	li	a5,13
    8000033a:	0cf48763          	beq	s1,a5,80000408 <consoleintr+0x14a>
      consputc(c);
    8000033e:	8526                	mv	a0,s1
    80000340:	00000097          	auipc	ra,0x0
    80000344:	f3c080e7          	jalr	-196(ra) # 8000027c <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80000348:	00010797          	auipc	a5,0x10
    8000034c:	6f878793          	addi	a5,a5,1784 # 80010a40 <cons>
    80000350:	0a07a683          	lw	a3,160(a5)
    80000354:	0016871b          	addiw	a4,a3,1
    80000358:	0007061b          	sext.w	a2,a4
    8000035c:	0ae7a023          	sw	a4,160(a5)
    80000360:	07f6f693          	andi	a3,a3,127
    80000364:	97b6                	add	a5,a5,a3
    80000366:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    8000036a:	47a9                	li	a5,10
    8000036c:	0cf48563          	beq	s1,a5,80000436 <consoleintr+0x178>
    80000370:	4791                	li	a5,4
    80000372:	0cf48263          	beq	s1,a5,80000436 <consoleintr+0x178>
    80000376:	00010797          	auipc	a5,0x10
    8000037a:	7627a783          	lw	a5,1890(a5) # 80010ad8 <cons+0x98>
    8000037e:	9f1d                	subw	a4,a4,a5
    80000380:	08000793          	li	a5,128
    80000384:	f6f71be3          	bne	a4,a5,800002fa <consoleintr+0x3c>
    80000388:	a07d                	j	80000436 <consoleintr+0x178>
    while(cons.e != cons.w &&
    8000038a:	00010717          	auipc	a4,0x10
    8000038e:	6b670713          	addi	a4,a4,1718 # 80010a40 <cons>
    80000392:	0a072783          	lw	a5,160(a4)
    80000396:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    8000039a:	00010497          	auipc	s1,0x10
    8000039e:	6a648493          	addi	s1,s1,1702 # 80010a40 <cons>
    while(cons.e != cons.w &&
    800003a2:	4929                	li	s2,10
    800003a4:	f4f70be3          	beq	a4,a5,800002fa <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    800003a8:	37fd                	addiw	a5,a5,-1
    800003aa:	07f7f713          	andi	a4,a5,127
    800003ae:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    800003b0:	01874703          	lbu	a4,24(a4)
    800003b4:	f52703e3          	beq	a4,s2,800002fa <consoleintr+0x3c>
      cons.e--;
    800003b8:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    800003bc:	10000513          	li	a0,256
    800003c0:	00000097          	auipc	ra,0x0
    800003c4:	ebc080e7          	jalr	-324(ra) # 8000027c <consputc>
    while(cons.e != cons.w &&
    800003c8:	0a04a783          	lw	a5,160(s1)
    800003cc:	09c4a703          	lw	a4,156(s1)
    800003d0:	fcf71ce3          	bne	a4,a5,800003a8 <consoleintr+0xea>
    800003d4:	b71d                	j	800002fa <consoleintr+0x3c>
    if(cons.e != cons.w){
    800003d6:	00010717          	auipc	a4,0x10
    800003da:	66a70713          	addi	a4,a4,1642 # 80010a40 <cons>
    800003de:	0a072783          	lw	a5,160(a4)
    800003e2:	09c72703          	lw	a4,156(a4)
    800003e6:	f0f70ae3          	beq	a4,a5,800002fa <consoleintr+0x3c>
      cons.e--;
    800003ea:	37fd                	addiw	a5,a5,-1
    800003ec:	00010717          	auipc	a4,0x10
    800003f0:	6ef72a23          	sw	a5,1780(a4) # 80010ae0 <cons+0xa0>
      consputc(BACKSPACE);
    800003f4:	10000513          	li	a0,256
    800003f8:	00000097          	auipc	ra,0x0
    800003fc:	e84080e7          	jalr	-380(ra) # 8000027c <consputc>
    80000400:	bded                	j	800002fa <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80000402:	ee048ce3          	beqz	s1,800002fa <consoleintr+0x3c>
    80000406:	bf21                	j	8000031e <consoleintr+0x60>
      consputc(c);
    80000408:	4529                	li	a0,10
    8000040a:	00000097          	auipc	ra,0x0
    8000040e:	e72080e7          	jalr	-398(ra) # 8000027c <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80000412:	00010797          	auipc	a5,0x10
    80000416:	62e78793          	addi	a5,a5,1582 # 80010a40 <cons>
    8000041a:	0a07a703          	lw	a4,160(a5)
    8000041e:	0017069b          	addiw	a3,a4,1
    80000422:	0006861b          	sext.w	a2,a3
    80000426:	0ad7a023          	sw	a3,160(a5)
    8000042a:	07f77713          	andi	a4,a4,127
    8000042e:	97ba                	add	a5,a5,a4
    80000430:	4729                	li	a4,10
    80000432:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80000436:	00010797          	auipc	a5,0x10
    8000043a:	6ac7a323          	sw	a2,1702(a5) # 80010adc <cons+0x9c>
        wakeup(&cons.r);
    8000043e:	00010517          	auipc	a0,0x10
    80000442:	69a50513          	addi	a0,a0,1690 # 80010ad8 <cons+0x98>
    80000446:	00002097          	auipc	ra,0x2
    8000044a:	d46080e7          	jalr	-698(ra) # 8000218c <wakeup>
    8000044e:	b575                	j	800002fa <consoleintr+0x3c>

0000000080000450 <consoleinit>:

void
consoleinit(void)
{
    80000450:	1141                	addi	sp,sp,-16
    80000452:	e406                	sd	ra,8(sp)
    80000454:	e022                	sd	s0,0(sp)
    80000456:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80000458:	00008597          	auipc	a1,0x8
    8000045c:	bb858593          	addi	a1,a1,-1096 # 80008010 <etext+0x10>
    80000460:	00010517          	auipc	a0,0x10
    80000464:	5e050513          	addi	a0,a0,1504 # 80010a40 <cons>
    80000468:	00000097          	auipc	ra,0x0
    8000046c:	6de080e7          	jalr	1758(ra) # 80000b46 <initlock>

  uartinit();
    80000470:	00000097          	auipc	ra,0x0
    80000474:	32a080e7          	jalr	810(ra) # 8000079a <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80000478:	00022797          	auipc	a5,0x22
    8000047c:	96078793          	addi	a5,a5,-1696 # 80021dd8 <devsw>
    80000480:	00000717          	auipc	a4,0x0
    80000484:	ce470713          	addi	a4,a4,-796 # 80000164 <consoleread>
    80000488:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    8000048a:	00000717          	auipc	a4,0x0
    8000048e:	c7870713          	addi	a4,a4,-904 # 80000102 <consolewrite>
    80000492:	ef98                	sd	a4,24(a5)
}
    80000494:	60a2                	ld	ra,8(sp)
    80000496:	6402                	ld	s0,0(sp)
    80000498:	0141                	addi	sp,sp,16
    8000049a:	8082                	ret

000000008000049c <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    8000049c:	7179                	addi	sp,sp,-48
    8000049e:	f406                	sd	ra,40(sp)
    800004a0:	f022                	sd	s0,32(sp)
    800004a2:	ec26                	sd	s1,24(sp)
    800004a4:	e84a                	sd	s2,16(sp)
    800004a6:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    800004a8:	c219                	beqz	a2,800004ae <printint+0x12>
    800004aa:	08054663          	bltz	a0,80000536 <printint+0x9a>
    x = -xx;
  else
    x = xx;
    800004ae:	2501                	sext.w	a0,a0
    800004b0:	4881                	li	a7,0
    800004b2:	fd040693          	addi	a3,s0,-48

  i = 0;
    800004b6:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    800004b8:	2581                	sext.w	a1,a1
    800004ba:	00008617          	auipc	a2,0x8
    800004be:	b8660613          	addi	a2,a2,-1146 # 80008040 <digits>
    800004c2:	883a                	mv	a6,a4
    800004c4:	2705                	addiw	a4,a4,1
    800004c6:	02b577bb          	remuw	a5,a0,a1
    800004ca:	1782                	slli	a5,a5,0x20
    800004cc:	9381                	srli	a5,a5,0x20
    800004ce:	97b2                	add	a5,a5,a2
    800004d0:	0007c783          	lbu	a5,0(a5)
    800004d4:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    800004d8:	0005079b          	sext.w	a5,a0
    800004dc:	02b5553b          	divuw	a0,a0,a1
    800004e0:	0685                	addi	a3,a3,1
    800004e2:	feb7f0e3          	bgeu	a5,a1,800004c2 <printint+0x26>

  if(sign)
    800004e6:	00088b63          	beqz	a7,800004fc <printint+0x60>
    buf[i++] = '-';
    800004ea:	fe040793          	addi	a5,s0,-32
    800004ee:	973e                	add	a4,a4,a5
    800004f0:	02d00793          	li	a5,45
    800004f4:	fef70823          	sb	a5,-16(a4)
    800004f8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    800004fc:	02e05763          	blez	a4,8000052a <printint+0x8e>
    80000500:	fd040793          	addi	a5,s0,-48
    80000504:	00e784b3          	add	s1,a5,a4
    80000508:	fff78913          	addi	s2,a5,-1
    8000050c:	993a                	add	s2,s2,a4
    8000050e:	377d                	addiw	a4,a4,-1
    80000510:	1702                	slli	a4,a4,0x20
    80000512:	9301                	srli	a4,a4,0x20
    80000514:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80000518:	fff4c503          	lbu	a0,-1(s1)
    8000051c:	00000097          	auipc	ra,0x0
    80000520:	d60080e7          	jalr	-672(ra) # 8000027c <consputc>
  while(--i >= 0)
    80000524:	14fd                	addi	s1,s1,-1
    80000526:	ff2499e3          	bne	s1,s2,80000518 <printint+0x7c>
}
    8000052a:	70a2                	ld	ra,40(sp)
    8000052c:	7402                	ld	s0,32(sp)
    8000052e:	64e2                	ld	s1,24(sp)
    80000530:	6942                	ld	s2,16(sp)
    80000532:	6145                	addi	sp,sp,48
    80000534:	8082                	ret
    x = -xx;
    80000536:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    8000053a:	4885                	li	a7,1
    x = -xx;
    8000053c:	bf9d                	j	800004b2 <printint+0x16>

000000008000053e <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    8000053e:	1101                	addi	sp,sp,-32
    80000540:	ec06                	sd	ra,24(sp)
    80000542:	e822                	sd	s0,16(sp)
    80000544:	e426                	sd	s1,8(sp)
    80000546:	1000                	addi	s0,sp,32
    80000548:	84aa                	mv	s1,a0
  pr.locking = 0;
    8000054a:	00010797          	auipc	a5,0x10
    8000054e:	5a07ab23          	sw	zero,1462(a5) # 80010b00 <pr+0x18>
  printf("panic: ");
    80000552:	00008517          	auipc	a0,0x8
    80000556:	ac650513          	addi	a0,a0,-1338 # 80008018 <etext+0x18>
    8000055a:	00000097          	auipc	ra,0x0
    8000055e:	02e080e7          	jalr	46(ra) # 80000588 <printf>
  printf(s);
    80000562:	8526                	mv	a0,s1
    80000564:	00000097          	auipc	ra,0x0
    80000568:	024080e7          	jalr	36(ra) # 80000588 <printf>
  printf("\n");
    8000056c:	00008517          	auipc	a0,0x8
    80000570:	b5c50513          	addi	a0,a0,-1188 # 800080c8 <digits+0x88>
    80000574:	00000097          	auipc	ra,0x0
    80000578:	014080e7          	jalr	20(ra) # 80000588 <printf>
  panicked = 1; // freeze uart output from other CPUs
    8000057c:	4785                	li	a5,1
    8000057e:	00008717          	auipc	a4,0x8
    80000582:	34f72123          	sw	a5,834(a4) # 800088c0 <panicked>
  for(;;)
    80000586:	a001                	j	80000586 <panic+0x48>

0000000080000588 <printf>:
{
    80000588:	7131                	addi	sp,sp,-192
    8000058a:	fc86                	sd	ra,120(sp)
    8000058c:	f8a2                	sd	s0,112(sp)
    8000058e:	f4a6                	sd	s1,104(sp)
    80000590:	f0ca                	sd	s2,96(sp)
    80000592:	ecce                	sd	s3,88(sp)
    80000594:	e8d2                	sd	s4,80(sp)
    80000596:	e4d6                	sd	s5,72(sp)
    80000598:	e0da                	sd	s6,64(sp)
    8000059a:	fc5e                	sd	s7,56(sp)
    8000059c:	f862                	sd	s8,48(sp)
    8000059e:	f466                	sd	s9,40(sp)
    800005a0:	f06a                	sd	s10,32(sp)
    800005a2:	ec6e                	sd	s11,24(sp)
    800005a4:	0100                	addi	s0,sp,128
    800005a6:	8a2a                	mv	s4,a0
    800005a8:	e40c                	sd	a1,8(s0)
    800005aa:	e810                	sd	a2,16(s0)
    800005ac:	ec14                	sd	a3,24(s0)
    800005ae:	f018                	sd	a4,32(s0)
    800005b0:	f41c                	sd	a5,40(s0)
    800005b2:	03043823          	sd	a6,48(s0)
    800005b6:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    800005ba:	00010d97          	auipc	s11,0x10
    800005be:	546dad83          	lw	s11,1350(s11) # 80010b00 <pr+0x18>
  if(locking)
    800005c2:	020d9b63          	bnez	s11,800005f8 <printf+0x70>
  if (fmt == 0)
    800005c6:	040a0263          	beqz	s4,8000060a <printf+0x82>
  va_start(ap, fmt);
    800005ca:	00840793          	addi	a5,s0,8
    800005ce:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    800005d2:	000a4503          	lbu	a0,0(s4)
    800005d6:	14050f63          	beqz	a0,80000734 <printf+0x1ac>
    800005da:	4981                	li	s3,0
    if(c != '%'){
    800005dc:	02500a93          	li	s5,37
    switch(c){
    800005e0:	07000b93          	li	s7,112
  consputc('x');
    800005e4:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800005e6:	00008b17          	auipc	s6,0x8
    800005ea:	a5ab0b13          	addi	s6,s6,-1446 # 80008040 <digits>
    switch(c){
    800005ee:	07300c93          	li	s9,115
    800005f2:	06400c13          	li	s8,100
    800005f6:	a82d                	j	80000630 <printf+0xa8>
    acquire(&pr.lock);
    800005f8:	00010517          	auipc	a0,0x10
    800005fc:	4f050513          	addi	a0,a0,1264 # 80010ae8 <pr>
    80000600:	00000097          	auipc	ra,0x0
    80000604:	5d6080e7          	jalr	1494(ra) # 80000bd6 <acquire>
    80000608:	bf7d                	j	800005c6 <printf+0x3e>
    panic("null fmt");
    8000060a:	00008517          	auipc	a0,0x8
    8000060e:	a1e50513          	addi	a0,a0,-1506 # 80008028 <etext+0x28>
    80000612:	00000097          	auipc	ra,0x0
    80000616:	f2c080e7          	jalr	-212(ra) # 8000053e <panic>
      consputc(c);
    8000061a:	00000097          	auipc	ra,0x0
    8000061e:	c62080e7          	jalr	-926(ra) # 8000027c <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80000622:	2985                	addiw	s3,s3,1
    80000624:	013a07b3          	add	a5,s4,s3
    80000628:	0007c503          	lbu	a0,0(a5)
    8000062c:	10050463          	beqz	a0,80000734 <printf+0x1ac>
    if(c != '%'){
    80000630:	ff5515e3          	bne	a0,s5,8000061a <printf+0x92>
    c = fmt[++i] & 0xff;
    80000634:	2985                	addiw	s3,s3,1
    80000636:	013a07b3          	add	a5,s4,s3
    8000063a:	0007c783          	lbu	a5,0(a5)
    8000063e:	0007849b          	sext.w	s1,a5
    if(c == 0)
    80000642:	cbed                	beqz	a5,80000734 <printf+0x1ac>
    switch(c){
    80000644:	05778a63          	beq	a5,s7,80000698 <printf+0x110>
    80000648:	02fbf663          	bgeu	s7,a5,80000674 <printf+0xec>
    8000064c:	09978863          	beq	a5,s9,800006dc <printf+0x154>
    80000650:	07800713          	li	a4,120
    80000654:	0ce79563          	bne	a5,a4,8000071e <printf+0x196>
      printint(va_arg(ap, int), 16, 1);
    80000658:	f8843783          	ld	a5,-120(s0)
    8000065c:	00878713          	addi	a4,a5,8
    80000660:	f8e43423          	sd	a4,-120(s0)
    80000664:	4605                	li	a2,1
    80000666:	85ea                	mv	a1,s10
    80000668:	4388                	lw	a0,0(a5)
    8000066a:	00000097          	auipc	ra,0x0
    8000066e:	e32080e7          	jalr	-462(ra) # 8000049c <printint>
      break;
    80000672:	bf45                	j	80000622 <printf+0x9a>
    switch(c){
    80000674:	09578f63          	beq	a5,s5,80000712 <printf+0x18a>
    80000678:	0b879363          	bne	a5,s8,8000071e <printf+0x196>
      printint(va_arg(ap, int), 10, 1);
    8000067c:	f8843783          	ld	a5,-120(s0)
    80000680:	00878713          	addi	a4,a5,8
    80000684:	f8e43423          	sd	a4,-120(s0)
    80000688:	4605                	li	a2,1
    8000068a:	45a9                	li	a1,10
    8000068c:	4388                	lw	a0,0(a5)
    8000068e:	00000097          	auipc	ra,0x0
    80000692:	e0e080e7          	jalr	-498(ra) # 8000049c <printint>
      break;
    80000696:	b771                	j	80000622 <printf+0x9a>
      printptr(va_arg(ap, uint64));
    80000698:	f8843783          	ld	a5,-120(s0)
    8000069c:	00878713          	addi	a4,a5,8
    800006a0:	f8e43423          	sd	a4,-120(s0)
    800006a4:	0007b903          	ld	s2,0(a5)
  consputc('0');
    800006a8:	03000513          	li	a0,48
    800006ac:	00000097          	auipc	ra,0x0
    800006b0:	bd0080e7          	jalr	-1072(ra) # 8000027c <consputc>
  consputc('x');
    800006b4:	07800513          	li	a0,120
    800006b8:	00000097          	auipc	ra,0x0
    800006bc:	bc4080e7          	jalr	-1084(ra) # 8000027c <consputc>
    800006c0:	84ea                	mv	s1,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800006c2:	03c95793          	srli	a5,s2,0x3c
    800006c6:	97da                	add	a5,a5,s6
    800006c8:	0007c503          	lbu	a0,0(a5)
    800006cc:	00000097          	auipc	ra,0x0
    800006d0:	bb0080e7          	jalr	-1104(ra) # 8000027c <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800006d4:	0912                	slli	s2,s2,0x4
    800006d6:	34fd                	addiw	s1,s1,-1
    800006d8:	f4ed                	bnez	s1,800006c2 <printf+0x13a>
    800006da:	b7a1                	j	80000622 <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    800006dc:	f8843783          	ld	a5,-120(s0)
    800006e0:	00878713          	addi	a4,a5,8
    800006e4:	f8e43423          	sd	a4,-120(s0)
    800006e8:	6384                	ld	s1,0(a5)
    800006ea:	cc89                	beqz	s1,80000704 <printf+0x17c>
      for(; *s; s++)
    800006ec:	0004c503          	lbu	a0,0(s1)
    800006f0:	d90d                	beqz	a0,80000622 <printf+0x9a>
        consputc(*s);
    800006f2:	00000097          	auipc	ra,0x0
    800006f6:	b8a080e7          	jalr	-1142(ra) # 8000027c <consputc>
      for(; *s; s++)
    800006fa:	0485                	addi	s1,s1,1
    800006fc:	0004c503          	lbu	a0,0(s1)
    80000700:	f96d                	bnez	a0,800006f2 <printf+0x16a>
    80000702:	b705                	j	80000622 <printf+0x9a>
        s = "(null)";
    80000704:	00008497          	auipc	s1,0x8
    80000708:	91c48493          	addi	s1,s1,-1764 # 80008020 <etext+0x20>
      for(; *s; s++)
    8000070c:	02800513          	li	a0,40
    80000710:	b7cd                	j	800006f2 <printf+0x16a>
      consputc('%');
    80000712:	8556                	mv	a0,s5
    80000714:	00000097          	auipc	ra,0x0
    80000718:	b68080e7          	jalr	-1176(ra) # 8000027c <consputc>
      break;
    8000071c:	b719                	j	80000622 <printf+0x9a>
      consputc('%');
    8000071e:	8556                	mv	a0,s5
    80000720:	00000097          	auipc	ra,0x0
    80000724:	b5c080e7          	jalr	-1188(ra) # 8000027c <consputc>
      consputc(c);
    80000728:	8526                	mv	a0,s1
    8000072a:	00000097          	auipc	ra,0x0
    8000072e:	b52080e7          	jalr	-1198(ra) # 8000027c <consputc>
      break;
    80000732:	bdc5                	j	80000622 <printf+0x9a>
  if(locking)
    80000734:	020d9163          	bnez	s11,80000756 <printf+0x1ce>
}
    80000738:	70e6                	ld	ra,120(sp)
    8000073a:	7446                	ld	s0,112(sp)
    8000073c:	74a6                	ld	s1,104(sp)
    8000073e:	7906                	ld	s2,96(sp)
    80000740:	69e6                	ld	s3,88(sp)
    80000742:	6a46                	ld	s4,80(sp)
    80000744:	6aa6                	ld	s5,72(sp)
    80000746:	6b06                	ld	s6,64(sp)
    80000748:	7be2                	ld	s7,56(sp)
    8000074a:	7c42                	ld	s8,48(sp)
    8000074c:	7ca2                	ld	s9,40(sp)
    8000074e:	7d02                	ld	s10,32(sp)
    80000750:	6de2                	ld	s11,24(sp)
    80000752:	6129                	addi	sp,sp,192
    80000754:	8082                	ret
    release(&pr.lock);
    80000756:	00010517          	auipc	a0,0x10
    8000075a:	39250513          	addi	a0,a0,914 # 80010ae8 <pr>
    8000075e:	00000097          	auipc	ra,0x0
    80000762:	52c080e7          	jalr	1324(ra) # 80000c8a <release>
}
    80000766:	bfc9                	j	80000738 <printf+0x1b0>

0000000080000768 <printfinit>:
    ;
}

void
printfinit(void)
{
    80000768:	1101                	addi	sp,sp,-32
    8000076a:	ec06                	sd	ra,24(sp)
    8000076c:	e822                	sd	s0,16(sp)
    8000076e:	e426                	sd	s1,8(sp)
    80000770:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    80000772:	00010497          	auipc	s1,0x10
    80000776:	37648493          	addi	s1,s1,886 # 80010ae8 <pr>
    8000077a:	00008597          	auipc	a1,0x8
    8000077e:	8be58593          	addi	a1,a1,-1858 # 80008038 <etext+0x38>
    80000782:	8526                	mv	a0,s1
    80000784:	00000097          	auipc	ra,0x0
    80000788:	3c2080e7          	jalr	962(ra) # 80000b46 <initlock>
  pr.locking = 1;
    8000078c:	4785                	li	a5,1
    8000078e:	cc9c                	sw	a5,24(s1)
}
    80000790:	60e2                	ld	ra,24(sp)
    80000792:	6442                	ld	s0,16(sp)
    80000794:	64a2                	ld	s1,8(sp)
    80000796:	6105                	addi	sp,sp,32
    80000798:	8082                	ret

000000008000079a <uartinit>:

void uartstart();

void
uartinit(void)
{
    8000079a:	1141                	addi	sp,sp,-16
    8000079c:	e406                	sd	ra,8(sp)
    8000079e:	e022                	sd	s0,0(sp)
    800007a0:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    800007a2:	100007b7          	lui	a5,0x10000
    800007a6:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    800007aa:	f8000713          	li	a4,-128
    800007ae:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    800007b2:	470d                	li	a4,3
    800007b4:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    800007b8:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    800007bc:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    800007c0:	469d                	li	a3,7
    800007c2:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    800007c6:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    800007ca:	00008597          	auipc	a1,0x8
    800007ce:	88e58593          	addi	a1,a1,-1906 # 80008058 <digits+0x18>
    800007d2:	00010517          	auipc	a0,0x10
    800007d6:	33650513          	addi	a0,a0,822 # 80010b08 <uart_tx_lock>
    800007da:	00000097          	auipc	ra,0x0
    800007de:	36c080e7          	jalr	876(ra) # 80000b46 <initlock>
}
    800007e2:	60a2                	ld	ra,8(sp)
    800007e4:	6402                	ld	s0,0(sp)
    800007e6:	0141                	addi	sp,sp,16
    800007e8:	8082                	ret

00000000800007ea <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    800007ea:	1101                	addi	sp,sp,-32
    800007ec:	ec06                	sd	ra,24(sp)
    800007ee:	e822                	sd	s0,16(sp)
    800007f0:	e426                	sd	s1,8(sp)
    800007f2:	1000                	addi	s0,sp,32
    800007f4:	84aa                	mv	s1,a0
  push_off();
    800007f6:	00000097          	auipc	ra,0x0
    800007fa:	394080e7          	jalr	916(ra) # 80000b8a <push_off>

  if(panicked){
    800007fe:	00008797          	auipc	a5,0x8
    80000802:	0c27a783          	lw	a5,194(a5) # 800088c0 <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80000806:	10000737          	lui	a4,0x10000
  if(panicked){
    8000080a:	c391                	beqz	a5,8000080e <uartputc_sync+0x24>
    for(;;)
    8000080c:	a001                	j	8000080c <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    8000080e:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80000812:	0207f793          	andi	a5,a5,32
    80000816:	dfe5                	beqz	a5,8000080e <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    80000818:	0ff4f513          	andi	a0,s1,255
    8000081c:	100007b7          	lui	a5,0x10000
    80000820:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    80000824:	00000097          	auipc	ra,0x0
    80000828:	406080e7          	jalr	1030(ra) # 80000c2a <pop_off>
}
    8000082c:	60e2                	ld	ra,24(sp)
    8000082e:	6442                	ld	s0,16(sp)
    80000830:	64a2                	ld	s1,8(sp)
    80000832:	6105                	addi	sp,sp,32
    80000834:	8082                	ret

0000000080000836 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    80000836:	00008797          	auipc	a5,0x8
    8000083a:	0927b783          	ld	a5,146(a5) # 800088c8 <uart_tx_r>
    8000083e:	00008717          	auipc	a4,0x8
    80000842:	09273703          	ld	a4,146(a4) # 800088d0 <uart_tx_w>
    80000846:	06f70a63          	beq	a4,a5,800008ba <uartstart+0x84>
{
    8000084a:	7139                	addi	sp,sp,-64
    8000084c:	fc06                	sd	ra,56(sp)
    8000084e:	f822                	sd	s0,48(sp)
    80000850:	f426                	sd	s1,40(sp)
    80000852:	f04a                	sd	s2,32(sp)
    80000854:	ec4e                	sd	s3,24(sp)
    80000856:	e852                	sd	s4,16(sp)
    80000858:	e456                	sd	s5,8(sp)
    8000085a:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    8000085c:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80000860:	00010a17          	auipc	s4,0x10
    80000864:	2a8a0a13          	addi	s4,s4,680 # 80010b08 <uart_tx_lock>
    uart_tx_r += 1;
    80000868:	00008497          	auipc	s1,0x8
    8000086c:	06048493          	addi	s1,s1,96 # 800088c8 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    80000870:	00008997          	auipc	s3,0x8
    80000874:	06098993          	addi	s3,s3,96 # 800088d0 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80000878:	00594703          	lbu	a4,5(s2) # 10000005 <_entry-0x6ffffffb>
    8000087c:	02077713          	andi	a4,a4,32
    80000880:	c705                	beqz	a4,800008a8 <uartstart+0x72>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80000882:	01f7f713          	andi	a4,a5,31
    80000886:	9752                	add	a4,a4,s4
    80000888:	01874a83          	lbu	s5,24(a4)
    uart_tx_r += 1;
    8000088c:	0785                	addi	a5,a5,1
    8000088e:	e09c                	sd	a5,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    80000890:	8526                	mv	a0,s1
    80000892:	00002097          	auipc	ra,0x2
    80000896:	8fa080e7          	jalr	-1798(ra) # 8000218c <wakeup>
    
    WriteReg(THR, c);
    8000089a:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    8000089e:	609c                	ld	a5,0(s1)
    800008a0:	0009b703          	ld	a4,0(s3)
    800008a4:	fcf71ae3          	bne	a4,a5,80000878 <uartstart+0x42>
  }
}
    800008a8:	70e2                	ld	ra,56(sp)
    800008aa:	7442                	ld	s0,48(sp)
    800008ac:	74a2                	ld	s1,40(sp)
    800008ae:	7902                	ld	s2,32(sp)
    800008b0:	69e2                	ld	s3,24(sp)
    800008b2:	6a42                	ld	s4,16(sp)
    800008b4:	6aa2                	ld	s5,8(sp)
    800008b6:	6121                	addi	sp,sp,64
    800008b8:	8082                	ret
    800008ba:	8082                	ret

00000000800008bc <uartputc>:
{
    800008bc:	7179                	addi	sp,sp,-48
    800008be:	f406                	sd	ra,40(sp)
    800008c0:	f022                	sd	s0,32(sp)
    800008c2:	ec26                	sd	s1,24(sp)
    800008c4:	e84a                	sd	s2,16(sp)
    800008c6:	e44e                	sd	s3,8(sp)
    800008c8:	e052                	sd	s4,0(sp)
    800008ca:	1800                	addi	s0,sp,48
    800008cc:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    800008ce:	00010517          	auipc	a0,0x10
    800008d2:	23a50513          	addi	a0,a0,570 # 80010b08 <uart_tx_lock>
    800008d6:	00000097          	auipc	ra,0x0
    800008da:	300080e7          	jalr	768(ra) # 80000bd6 <acquire>
  if(panicked){
    800008de:	00008797          	auipc	a5,0x8
    800008e2:	fe27a783          	lw	a5,-30(a5) # 800088c0 <panicked>
    800008e6:	e7c9                	bnez	a5,80000970 <uartputc+0xb4>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800008e8:	00008717          	auipc	a4,0x8
    800008ec:	fe873703          	ld	a4,-24(a4) # 800088d0 <uart_tx_w>
    800008f0:	00008797          	auipc	a5,0x8
    800008f4:	fd87b783          	ld	a5,-40(a5) # 800088c8 <uart_tx_r>
    800008f8:	02078793          	addi	a5,a5,32
    sleep(&uart_tx_r, &uart_tx_lock);
    800008fc:	00010997          	auipc	s3,0x10
    80000900:	20c98993          	addi	s3,s3,524 # 80010b08 <uart_tx_lock>
    80000904:	00008497          	auipc	s1,0x8
    80000908:	fc448493          	addi	s1,s1,-60 # 800088c8 <uart_tx_r>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000090c:	00008917          	auipc	s2,0x8
    80000910:	fc490913          	addi	s2,s2,-60 # 800088d0 <uart_tx_w>
    80000914:	00e79f63          	bne	a5,a4,80000932 <uartputc+0x76>
    sleep(&uart_tx_r, &uart_tx_lock);
    80000918:	85ce                	mv	a1,s3
    8000091a:	8526                	mv	a0,s1
    8000091c:	00002097          	auipc	ra,0x2
    80000920:	80c080e7          	jalr	-2036(ra) # 80002128 <sleep>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80000924:	00093703          	ld	a4,0(s2)
    80000928:	609c                	ld	a5,0(s1)
    8000092a:	02078793          	addi	a5,a5,32
    8000092e:	fee785e3          	beq	a5,a4,80000918 <uartputc+0x5c>
  uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80000932:	00010497          	auipc	s1,0x10
    80000936:	1d648493          	addi	s1,s1,470 # 80010b08 <uart_tx_lock>
    8000093a:	01f77793          	andi	a5,a4,31
    8000093e:	97a6                	add	a5,a5,s1
    80000940:	01478c23          	sb	s4,24(a5)
  uart_tx_w += 1;
    80000944:	0705                	addi	a4,a4,1
    80000946:	00008797          	auipc	a5,0x8
    8000094a:	f8e7b523          	sd	a4,-118(a5) # 800088d0 <uart_tx_w>
  uartstart();
    8000094e:	00000097          	auipc	ra,0x0
    80000952:	ee8080e7          	jalr	-280(ra) # 80000836 <uartstart>
  release(&uart_tx_lock);
    80000956:	8526                	mv	a0,s1
    80000958:	00000097          	auipc	ra,0x0
    8000095c:	332080e7          	jalr	818(ra) # 80000c8a <release>
}
    80000960:	70a2                	ld	ra,40(sp)
    80000962:	7402                	ld	s0,32(sp)
    80000964:	64e2                	ld	s1,24(sp)
    80000966:	6942                	ld	s2,16(sp)
    80000968:	69a2                	ld	s3,8(sp)
    8000096a:	6a02                	ld	s4,0(sp)
    8000096c:	6145                	addi	sp,sp,48
    8000096e:	8082                	ret
    for(;;)
    80000970:	a001                	j	80000970 <uartputc+0xb4>

0000000080000972 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80000972:	1141                	addi	sp,sp,-16
    80000974:	e422                	sd	s0,8(sp)
    80000976:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80000978:	100007b7          	lui	a5,0x10000
    8000097c:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80000980:	8b85                	andi	a5,a5,1
    80000982:	cb91                	beqz	a5,80000996 <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    80000984:	100007b7          	lui	a5,0x10000
    80000988:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
    8000098c:	0ff57513          	andi	a0,a0,255
  } else {
    return -1;
  }
}
    80000990:	6422                	ld	s0,8(sp)
    80000992:	0141                	addi	sp,sp,16
    80000994:	8082                	ret
    return -1;
    80000996:	557d                	li	a0,-1
    80000998:	bfe5                	j	80000990 <uartgetc+0x1e>

000000008000099a <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    8000099a:	1101                	addi	sp,sp,-32
    8000099c:	ec06                	sd	ra,24(sp)
    8000099e:	e822                	sd	s0,16(sp)
    800009a0:	e426                	sd	s1,8(sp)
    800009a2:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    800009a4:	54fd                	li	s1,-1
    800009a6:	a029                	j	800009b0 <uartintr+0x16>
      break;
    consoleintr(c);
    800009a8:	00000097          	auipc	ra,0x0
    800009ac:	916080e7          	jalr	-1770(ra) # 800002be <consoleintr>
    int c = uartgetc();
    800009b0:	00000097          	auipc	ra,0x0
    800009b4:	fc2080e7          	jalr	-62(ra) # 80000972 <uartgetc>
    if(c == -1)
    800009b8:	fe9518e3          	bne	a0,s1,800009a8 <uartintr+0xe>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    800009bc:	00010497          	auipc	s1,0x10
    800009c0:	14c48493          	addi	s1,s1,332 # 80010b08 <uart_tx_lock>
    800009c4:	8526                	mv	a0,s1
    800009c6:	00000097          	auipc	ra,0x0
    800009ca:	210080e7          	jalr	528(ra) # 80000bd6 <acquire>
  uartstart();
    800009ce:	00000097          	auipc	ra,0x0
    800009d2:	e68080e7          	jalr	-408(ra) # 80000836 <uartstart>
  release(&uart_tx_lock);
    800009d6:	8526                	mv	a0,s1
    800009d8:	00000097          	auipc	ra,0x0
    800009dc:	2b2080e7          	jalr	690(ra) # 80000c8a <release>
}
    800009e0:	60e2                	ld	ra,24(sp)
    800009e2:	6442                	ld	s0,16(sp)
    800009e4:	64a2                	ld	s1,8(sp)
    800009e6:	6105                	addi	sp,sp,32
    800009e8:	8082                	ret

00000000800009ea <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    800009ea:	1101                	addi	sp,sp,-32
    800009ec:	ec06                	sd	ra,24(sp)
    800009ee:	e822                	sd	s0,16(sp)
    800009f0:	e426                	sd	s1,8(sp)
    800009f2:	e04a                	sd	s2,0(sp)
    800009f4:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    800009f6:	03451793          	slli	a5,a0,0x34
    800009fa:	ebb9                	bnez	a5,80000a50 <kfree+0x66>
    800009fc:	84aa                	mv	s1,a0
    800009fe:	00022797          	auipc	a5,0x22
    80000a02:	57278793          	addi	a5,a5,1394 # 80022f70 <end>
    80000a06:	04f56563          	bltu	a0,a5,80000a50 <kfree+0x66>
    80000a0a:	47c5                	li	a5,17
    80000a0c:	07ee                	slli	a5,a5,0x1b
    80000a0e:	04f57163          	bgeu	a0,a5,80000a50 <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000a12:	6605                	lui	a2,0x1
    80000a14:	4585                	li	a1,1
    80000a16:	00000097          	auipc	ra,0x0
    80000a1a:	2bc080e7          	jalr	700(ra) # 80000cd2 <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000a1e:	00010917          	auipc	s2,0x10
    80000a22:	12290913          	addi	s2,s2,290 # 80010b40 <kmem>
    80000a26:	854a                	mv	a0,s2
    80000a28:	00000097          	auipc	ra,0x0
    80000a2c:	1ae080e7          	jalr	430(ra) # 80000bd6 <acquire>
  r->next = kmem.freelist;
    80000a30:	01893783          	ld	a5,24(s2)
    80000a34:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000a36:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    80000a3a:	854a                	mv	a0,s2
    80000a3c:	00000097          	auipc	ra,0x0
    80000a40:	24e080e7          	jalr	590(ra) # 80000c8a <release>
}
    80000a44:	60e2                	ld	ra,24(sp)
    80000a46:	6442                	ld	s0,16(sp)
    80000a48:	64a2                	ld	s1,8(sp)
    80000a4a:	6902                	ld	s2,0(sp)
    80000a4c:	6105                	addi	sp,sp,32
    80000a4e:	8082                	ret
    panic("kfree");
    80000a50:	00007517          	auipc	a0,0x7
    80000a54:	61050513          	addi	a0,a0,1552 # 80008060 <digits+0x20>
    80000a58:	00000097          	auipc	ra,0x0
    80000a5c:	ae6080e7          	jalr	-1306(ra) # 8000053e <panic>

0000000080000a60 <freerange>:
{
    80000a60:	7179                	addi	sp,sp,-48
    80000a62:	f406                	sd	ra,40(sp)
    80000a64:	f022                	sd	s0,32(sp)
    80000a66:	ec26                	sd	s1,24(sp)
    80000a68:	e84a                	sd	s2,16(sp)
    80000a6a:	e44e                	sd	s3,8(sp)
    80000a6c:	e052                	sd	s4,0(sp)
    80000a6e:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    80000a70:	6785                	lui	a5,0x1
    80000a72:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80000a76:	94aa                	add	s1,s1,a0
    80000a78:	757d                	lui	a0,0xfffff
    80000a7a:	8ce9                	and	s1,s1,a0
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000a7c:	94be                	add	s1,s1,a5
    80000a7e:	0095ee63          	bltu	a1,s1,80000a9a <freerange+0x3a>
    80000a82:	892e                	mv	s2,a1
    kfree(p);
    80000a84:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000a86:	6985                	lui	s3,0x1
    kfree(p);
    80000a88:	01448533          	add	a0,s1,s4
    80000a8c:	00000097          	auipc	ra,0x0
    80000a90:	f5e080e7          	jalr	-162(ra) # 800009ea <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000a94:	94ce                	add	s1,s1,s3
    80000a96:	fe9979e3          	bgeu	s2,s1,80000a88 <freerange+0x28>
}
    80000a9a:	70a2                	ld	ra,40(sp)
    80000a9c:	7402                	ld	s0,32(sp)
    80000a9e:	64e2                	ld	s1,24(sp)
    80000aa0:	6942                	ld	s2,16(sp)
    80000aa2:	69a2                	ld	s3,8(sp)
    80000aa4:	6a02                	ld	s4,0(sp)
    80000aa6:	6145                	addi	sp,sp,48
    80000aa8:	8082                	ret

0000000080000aaa <kinit>:
{
    80000aaa:	1141                	addi	sp,sp,-16
    80000aac:	e406                	sd	ra,8(sp)
    80000aae:	e022                	sd	s0,0(sp)
    80000ab0:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    80000ab2:	00007597          	auipc	a1,0x7
    80000ab6:	5b658593          	addi	a1,a1,1462 # 80008068 <digits+0x28>
    80000aba:	00010517          	auipc	a0,0x10
    80000abe:	08650513          	addi	a0,a0,134 # 80010b40 <kmem>
    80000ac2:	00000097          	auipc	ra,0x0
    80000ac6:	084080e7          	jalr	132(ra) # 80000b46 <initlock>
  freerange(end, (void*)PHYSTOP);
    80000aca:	45c5                	li	a1,17
    80000acc:	05ee                	slli	a1,a1,0x1b
    80000ace:	00022517          	auipc	a0,0x22
    80000ad2:	4a250513          	addi	a0,a0,1186 # 80022f70 <end>
    80000ad6:	00000097          	auipc	ra,0x0
    80000ada:	f8a080e7          	jalr	-118(ra) # 80000a60 <freerange>
}
    80000ade:	60a2                	ld	ra,8(sp)
    80000ae0:	6402                	ld	s0,0(sp)
    80000ae2:	0141                	addi	sp,sp,16
    80000ae4:	8082                	ret

0000000080000ae6 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000ae6:	1101                	addi	sp,sp,-32
    80000ae8:	ec06                	sd	ra,24(sp)
    80000aea:	e822                	sd	s0,16(sp)
    80000aec:	e426                	sd	s1,8(sp)
    80000aee:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000af0:	00010497          	auipc	s1,0x10
    80000af4:	05048493          	addi	s1,s1,80 # 80010b40 <kmem>
    80000af8:	8526                	mv	a0,s1
    80000afa:	00000097          	auipc	ra,0x0
    80000afe:	0dc080e7          	jalr	220(ra) # 80000bd6 <acquire>
  r = kmem.freelist;
    80000b02:	6c84                	ld	s1,24(s1)
  if(r)
    80000b04:	c885                	beqz	s1,80000b34 <kalloc+0x4e>
    kmem.freelist = r->next;
    80000b06:	609c                	ld	a5,0(s1)
    80000b08:	00010517          	auipc	a0,0x10
    80000b0c:	03850513          	addi	a0,a0,56 # 80010b40 <kmem>
    80000b10:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000b12:	00000097          	auipc	ra,0x0
    80000b16:	178080e7          	jalr	376(ra) # 80000c8a <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    80000b1a:	6605                	lui	a2,0x1
    80000b1c:	4595                	li	a1,5
    80000b1e:	8526                	mv	a0,s1
    80000b20:	00000097          	auipc	ra,0x0
    80000b24:	1b2080e7          	jalr	434(ra) # 80000cd2 <memset>
  return (void*)r;
}
    80000b28:	8526                	mv	a0,s1
    80000b2a:	60e2                	ld	ra,24(sp)
    80000b2c:	6442                	ld	s0,16(sp)
    80000b2e:	64a2                	ld	s1,8(sp)
    80000b30:	6105                	addi	sp,sp,32
    80000b32:	8082                	ret
  release(&kmem.lock);
    80000b34:	00010517          	auipc	a0,0x10
    80000b38:	00c50513          	addi	a0,a0,12 # 80010b40 <kmem>
    80000b3c:	00000097          	auipc	ra,0x0
    80000b40:	14e080e7          	jalr	334(ra) # 80000c8a <release>
  if(r)
    80000b44:	b7d5                	j	80000b28 <kalloc+0x42>

0000000080000b46 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80000b46:	1141                	addi	sp,sp,-16
    80000b48:	e422                	sd	s0,8(sp)
    80000b4a:	0800                	addi	s0,sp,16
  lk->name = name;
    80000b4c:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80000b4e:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80000b52:	00053823          	sd	zero,16(a0)
}
    80000b56:	6422                	ld	s0,8(sp)
    80000b58:	0141                	addi	sp,sp,16
    80000b5a:	8082                	ret

0000000080000b5c <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80000b5c:	411c                	lw	a5,0(a0)
    80000b5e:	e399                	bnez	a5,80000b64 <holding+0x8>
    80000b60:	4501                	li	a0,0
  return r;
}
    80000b62:	8082                	ret
{
    80000b64:	1101                	addi	sp,sp,-32
    80000b66:	ec06                	sd	ra,24(sp)
    80000b68:	e822                	sd	s0,16(sp)
    80000b6a:	e426                	sd	s1,8(sp)
    80000b6c:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80000b6e:	6904                	ld	s1,16(a0)
    80000b70:	00001097          	auipc	ra,0x1
    80000b74:	e30080e7          	jalr	-464(ra) # 800019a0 <mycpu>
    80000b78:	40a48533          	sub	a0,s1,a0
    80000b7c:	00153513          	seqz	a0,a0
}
    80000b80:	60e2                	ld	ra,24(sp)
    80000b82:	6442                	ld	s0,16(sp)
    80000b84:	64a2                	ld	s1,8(sp)
    80000b86:	6105                	addi	sp,sp,32
    80000b88:	8082                	ret

0000000080000b8a <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80000b8a:	1101                	addi	sp,sp,-32
    80000b8c:	ec06                	sd	ra,24(sp)
    80000b8e:	e822                	sd	s0,16(sp)
    80000b90:	e426                	sd	s1,8(sp)
    80000b92:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000b94:	100024f3          	csrr	s1,sstatus
    80000b98:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80000b9c:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000b9e:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    80000ba2:	00001097          	auipc	ra,0x1
    80000ba6:	dfe080e7          	jalr	-514(ra) # 800019a0 <mycpu>
    80000baa:	5d3c                	lw	a5,120(a0)
    80000bac:	cf89                	beqz	a5,80000bc6 <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80000bae:	00001097          	auipc	ra,0x1
    80000bb2:	df2080e7          	jalr	-526(ra) # 800019a0 <mycpu>
    80000bb6:	5d3c                	lw	a5,120(a0)
    80000bb8:	2785                	addiw	a5,a5,1
    80000bba:	dd3c                	sw	a5,120(a0)
}
    80000bbc:	60e2                	ld	ra,24(sp)
    80000bbe:	6442                	ld	s0,16(sp)
    80000bc0:	64a2                	ld	s1,8(sp)
    80000bc2:	6105                	addi	sp,sp,32
    80000bc4:	8082                	ret
    mycpu()->intena = old;
    80000bc6:	00001097          	auipc	ra,0x1
    80000bca:	dda080e7          	jalr	-550(ra) # 800019a0 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80000bce:	8085                	srli	s1,s1,0x1
    80000bd0:	8885                	andi	s1,s1,1
    80000bd2:	dd64                	sw	s1,124(a0)
    80000bd4:	bfe9                	j	80000bae <push_off+0x24>

0000000080000bd6 <acquire>:
{
    80000bd6:	1101                	addi	sp,sp,-32
    80000bd8:	ec06                	sd	ra,24(sp)
    80000bda:	e822                	sd	s0,16(sp)
    80000bdc:	e426                	sd	s1,8(sp)
    80000bde:	1000                	addi	s0,sp,32
    80000be0:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80000be2:	00000097          	auipc	ra,0x0
    80000be6:	fa8080e7          	jalr	-88(ra) # 80000b8a <push_off>
  if(holding(lk))
    80000bea:	8526                	mv	a0,s1
    80000bec:	00000097          	auipc	ra,0x0
    80000bf0:	f70080e7          	jalr	-144(ra) # 80000b5c <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80000bf4:	4705                	li	a4,1
  if(holding(lk))
    80000bf6:	e115                	bnez	a0,80000c1a <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80000bf8:	87ba                	mv	a5,a4
    80000bfa:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80000bfe:	2781                	sext.w	a5,a5
    80000c00:	ffe5                	bnez	a5,80000bf8 <acquire+0x22>
  __sync_synchronize();
    80000c02:	0ff0000f          	fence
  lk->cpu = mycpu();
    80000c06:	00001097          	auipc	ra,0x1
    80000c0a:	d9a080e7          	jalr	-614(ra) # 800019a0 <mycpu>
    80000c0e:	e888                	sd	a0,16(s1)
}
    80000c10:	60e2                	ld	ra,24(sp)
    80000c12:	6442                	ld	s0,16(sp)
    80000c14:	64a2                	ld	s1,8(sp)
    80000c16:	6105                	addi	sp,sp,32
    80000c18:	8082                	ret
    panic("acquire");
    80000c1a:	00007517          	auipc	a0,0x7
    80000c1e:	45650513          	addi	a0,a0,1110 # 80008070 <digits+0x30>
    80000c22:	00000097          	auipc	ra,0x0
    80000c26:	91c080e7          	jalr	-1764(ra) # 8000053e <panic>

0000000080000c2a <pop_off>:

void
pop_off(void)
{
    80000c2a:	1141                	addi	sp,sp,-16
    80000c2c:	e406                	sd	ra,8(sp)
    80000c2e:	e022                	sd	s0,0(sp)
    80000c30:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80000c32:	00001097          	auipc	ra,0x1
    80000c36:	d6e080e7          	jalr	-658(ra) # 800019a0 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000c3a:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80000c3e:	8b89                	andi	a5,a5,2
  if(intr_get())
    80000c40:	e78d                	bnez	a5,80000c6a <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80000c42:	5d3c                	lw	a5,120(a0)
    80000c44:	02f05b63          	blez	a5,80000c7a <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    80000c48:	37fd                	addiw	a5,a5,-1
    80000c4a:	0007871b          	sext.w	a4,a5
    80000c4e:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80000c50:	eb09                	bnez	a4,80000c62 <pop_off+0x38>
    80000c52:	5d7c                	lw	a5,124(a0)
    80000c54:	c799                	beqz	a5,80000c62 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000c56:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80000c5a:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000c5e:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80000c62:	60a2                	ld	ra,8(sp)
    80000c64:	6402                	ld	s0,0(sp)
    80000c66:	0141                	addi	sp,sp,16
    80000c68:	8082                	ret
    panic("pop_off - interruptible");
    80000c6a:	00007517          	auipc	a0,0x7
    80000c6e:	40e50513          	addi	a0,a0,1038 # 80008078 <digits+0x38>
    80000c72:	00000097          	auipc	ra,0x0
    80000c76:	8cc080e7          	jalr	-1844(ra) # 8000053e <panic>
    panic("pop_off");
    80000c7a:	00007517          	auipc	a0,0x7
    80000c7e:	41650513          	addi	a0,a0,1046 # 80008090 <digits+0x50>
    80000c82:	00000097          	auipc	ra,0x0
    80000c86:	8bc080e7          	jalr	-1860(ra) # 8000053e <panic>

0000000080000c8a <release>:
{
    80000c8a:	1101                	addi	sp,sp,-32
    80000c8c:	ec06                	sd	ra,24(sp)
    80000c8e:	e822                	sd	s0,16(sp)
    80000c90:	e426                	sd	s1,8(sp)
    80000c92:	1000                	addi	s0,sp,32
    80000c94:	84aa                	mv	s1,a0
  if(!holding(lk))
    80000c96:	00000097          	auipc	ra,0x0
    80000c9a:	ec6080e7          	jalr	-314(ra) # 80000b5c <holding>
    80000c9e:	c115                	beqz	a0,80000cc2 <release+0x38>
  lk->cpu = 0;
    80000ca0:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80000ca4:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    80000ca8:	0f50000f          	fence	iorw,ow
    80000cac:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    80000cb0:	00000097          	auipc	ra,0x0
    80000cb4:	f7a080e7          	jalr	-134(ra) # 80000c2a <pop_off>
}
    80000cb8:	60e2                	ld	ra,24(sp)
    80000cba:	6442                	ld	s0,16(sp)
    80000cbc:	64a2                	ld	s1,8(sp)
    80000cbe:	6105                	addi	sp,sp,32
    80000cc0:	8082                	ret
    panic("release");
    80000cc2:	00007517          	auipc	a0,0x7
    80000cc6:	3d650513          	addi	a0,a0,982 # 80008098 <digits+0x58>
    80000cca:	00000097          	auipc	ra,0x0
    80000cce:	874080e7          	jalr	-1932(ra) # 8000053e <panic>

0000000080000cd2 <memset>:
    80000cd2:	1141                	addi	sp,sp,-16
    80000cd4:	e422                	sd	s0,8(sp)
    80000cd6:	0800                	addi	s0,sp,16
    80000cd8:	ca19                	beqz	a2,80000cee <memset+0x1c>
    80000cda:	87aa                	mv	a5,a0
    80000cdc:	1602                	slli	a2,a2,0x20
    80000cde:	9201                	srli	a2,a2,0x20
    80000ce0:	00a60733          	add	a4,a2,a0
    80000ce4:	00b78023          	sb	a1,0(a5)
    80000ce8:	0785                	addi	a5,a5,1
    80000cea:	fee79de3          	bne	a5,a4,80000ce4 <memset+0x12>
    80000cee:	6422                	ld	s0,8(sp)
    80000cf0:	0141                	addi	sp,sp,16
    80000cf2:	8082                	ret

0000000080000cf4 <memcmp>:
    80000cf4:	1141                	addi	sp,sp,-16
    80000cf6:	e422                	sd	s0,8(sp)
    80000cf8:	0800                	addi	s0,sp,16
    80000cfa:	ca05                	beqz	a2,80000d2a <memcmp+0x36>
    80000cfc:	fff6069b          	addiw	a3,a2,-1
    80000d00:	1682                	slli	a3,a3,0x20
    80000d02:	9281                	srli	a3,a3,0x20
    80000d04:	0685                	addi	a3,a3,1
    80000d06:	96aa                	add	a3,a3,a0
    80000d08:	00054783          	lbu	a5,0(a0)
    80000d0c:	0005c703          	lbu	a4,0(a1)
    80000d10:	00e79863          	bne	a5,a4,80000d20 <memcmp+0x2c>
    80000d14:	0505                	addi	a0,a0,1
    80000d16:	0585                	addi	a1,a1,1
    80000d18:	fed518e3          	bne	a0,a3,80000d08 <memcmp+0x14>
    80000d1c:	4501                	li	a0,0
    80000d1e:	a019                	j	80000d24 <memcmp+0x30>
    80000d20:	40e7853b          	subw	a0,a5,a4
    80000d24:	6422                	ld	s0,8(sp)
    80000d26:	0141                	addi	sp,sp,16
    80000d28:	8082                	ret
    80000d2a:	4501                	li	a0,0
    80000d2c:	bfe5                	j	80000d24 <memcmp+0x30>

0000000080000d2e <memmove>:
    80000d2e:	1141                	addi	sp,sp,-16
    80000d30:	e422                	sd	s0,8(sp)
    80000d32:	0800                	addi	s0,sp,16
    80000d34:	c205                	beqz	a2,80000d54 <memmove+0x26>
    80000d36:	02a5e263          	bltu	a1,a0,80000d5a <memmove+0x2c>
    80000d3a:	1602                	slli	a2,a2,0x20
    80000d3c:	9201                	srli	a2,a2,0x20
    80000d3e:	00c587b3          	add	a5,a1,a2
    80000d42:	872a                	mv	a4,a0
    80000d44:	0585                	addi	a1,a1,1
    80000d46:	0705                	addi	a4,a4,1
    80000d48:	fff5c683          	lbu	a3,-1(a1)
    80000d4c:	fed70fa3          	sb	a3,-1(a4)
    80000d50:	fef59ae3          	bne	a1,a5,80000d44 <memmove+0x16>
    80000d54:	6422                	ld	s0,8(sp)
    80000d56:	0141                	addi	sp,sp,16
    80000d58:	8082                	ret
    80000d5a:	02061693          	slli	a3,a2,0x20
    80000d5e:	9281                	srli	a3,a3,0x20
    80000d60:	00d58733          	add	a4,a1,a3
    80000d64:	fce57be3          	bgeu	a0,a4,80000d3a <memmove+0xc>
    80000d68:	96aa                	add	a3,a3,a0
    80000d6a:	fff6079b          	addiw	a5,a2,-1
    80000d6e:	1782                	slli	a5,a5,0x20
    80000d70:	9381                	srli	a5,a5,0x20
    80000d72:	fff7c793          	not	a5,a5
    80000d76:	97ba                	add	a5,a5,a4
    80000d78:	177d                	addi	a4,a4,-1
    80000d7a:	16fd                	addi	a3,a3,-1
    80000d7c:	00074603          	lbu	a2,0(a4)
    80000d80:	00c68023          	sb	a2,0(a3)
    80000d84:	fee79ae3          	bne	a5,a4,80000d78 <memmove+0x4a>
    80000d88:	b7f1                	j	80000d54 <memmove+0x26>

0000000080000d8a <memcpy>:
    80000d8a:	1141                	addi	sp,sp,-16
    80000d8c:	e406                	sd	ra,8(sp)
    80000d8e:	e022                	sd	s0,0(sp)
    80000d90:	0800                	addi	s0,sp,16
    80000d92:	00000097          	auipc	ra,0x0
    80000d96:	f9c080e7          	jalr	-100(ra) # 80000d2e <memmove>
    80000d9a:	60a2                	ld	ra,8(sp)
    80000d9c:	6402                	ld	s0,0(sp)
    80000d9e:	0141                	addi	sp,sp,16
    80000da0:	8082                	ret

0000000080000da2 <strncmp>:
    80000da2:	1141                	addi	sp,sp,-16
    80000da4:	e422                	sd	s0,8(sp)
    80000da6:	0800                	addi	s0,sp,16
    80000da8:	ce11                	beqz	a2,80000dc4 <strncmp+0x22>
    80000daa:	00054783          	lbu	a5,0(a0)
    80000dae:	cf89                	beqz	a5,80000dc8 <strncmp+0x26>
    80000db0:	0005c703          	lbu	a4,0(a1)
    80000db4:	00f71a63          	bne	a4,a5,80000dc8 <strncmp+0x26>
    80000db8:	367d                	addiw	a2,a2,-1
    80000dba:	0505                	addi	a0,a0,1
    80000dbc:	0585                	addi	a1,a1,1
    80000dbe:	f675                	bnez	a2,80000daa <strncmp+0x8>
    80000dc0:	4501                	li	a0,0
    80000dc2:	a809                	j	80000dd4 <strncmp+0x32>
    80000dc4:	4501                	li	a0,0
    80000dc6:	a039                	j	80000dd4 <strncmp+0x32>
    80000dc8:	ca09                	beqz	a2,80000dda <strncmp+0x38>
    80000dca:	00054503          	lbu	a0,0(a0)
    80000dce:	0005c783          	lbu	a5,0(a1)
    80000dd2:	9d1d                	subw	a0,a0,a5
    80000dd4:	6422                	ld	s0,8(sp)
    80000dd6:	0141                	addi	sp,sp,16
    80000dd8:	8082                	ret
    80000dda:	4501                	li	a0,0
    80000ddc:	bfe5                	j	80000dd4 <strncmp+0x32>

0000000080000dde <strncpy>:
    80000dde:	1141                	addi	sp,sp,-16
    80000de0:	e422                	sd	s0,8(sp)
    80000de2:	0800                	addi	s0,sp,16
    80000de4:	872a                	mv	a4,a0
    80000de6:	8832                	mv	a6,a2
    80000de8:	367d                	addiw	a2,a2,-1
    80000dea:	01005963          	blez	a6,80000dfc <strncpy+0x1e>
    80000dee:	0705                	addi	a4,a4,1
    80000df0:	0005c783          	lbu	a5,0(a1)
    80000df4:	fef70fa3          	sb	a5,-1(a4)
    80000df8:	0585                	addi	a1,a1,1
    80000dfa:	f7f5                	bnez	a5,80000de6 <strncpy+0x8>
    80000dfc:	86ba                	mv	a3,a4
    80000dfe:	00c05c63          	blez	a2,80000e16 <strncpy+0x38>
    80000e02:	0685                	addi	a3,a3,1
    80000e04:	fe068fa3          	sb	zero,-1(a3)
    80000e08:	fff6c793          	not	a5,a3
    80000e0c:	9fb9                	addw	a5,a5,a4
    80000e0e:	010787bb          	addw	a5,a5,a6
    80000e12:	fef048e3          	bgtz	a5,80000e02 <strncpy+0x24>
    80000e16:	6422                	ld	s0,8(sp)
    80000e18:	0141                	addi	sp,sp,16
    80000e1a:	8082                	ret

0000000080000e1c <safestrcpy>:
    80000e1c:	1141                	addi	sp,sp,-16
    80000e1e:	e422                	sd	s0,8(sp)
    80000e20:	0800                	addi	s0,sp,16
    80000e22:	02c05363          	blez	a2,80000e48 <safestrcpy+0x2c>
    80000e26:	fff6069b          	addiw	a3,a2,-1
    80000e2a:	1682                	slli	a3,a3,0x20
    80000e2c:	9281                	srli	a3,a3,0x20
    80000e2e:	96ae                	add	a3,a3,a1
    80000e30:	87aa                	mv	a5,a0
    80000e32:	00d58963          	beq	a1,a3,80000e44 <safestrcpy+0x28>
    80000e36:	0585                	addi	a1,a1,1
    80000e38:	0785                	addi	a5,a5,1
    80000e3a:	fff5c703          	lbu	a4,-1(a1)
    80000e3e:	fee78fa3          	sb	a4,-1(a5)
    80000e42:	fb65                	bnez	a4,80000e32 <safestrcpy+0x16>
    80000e44:	00078023          	sb	zero,0(a5)
    80000e48:	6422                	ld	s0,8(sp)
    80000e4a:	0141                	addi	sp,sp,16
    80000e4c:	8082                	ret

0000000080000e4e <strlen>:
    80000e4e:	1141                	addi	sp,sp,-16
    80000e50:	e422                	sd	s0,8(sp)
    80000e52:	0800                	addi	s0,sp,16
    80000e54:	00054783          	lbu	a5,0(a0)
    80000e58:	cf91                	beqz	a5,80000e74 <strlen+0x26>
    80000e5a:	0505                	addi	a0,a0,1
    80000e5c:	87aa                	mv	a5,a0
    80000e5e:	4685                	li	a3,1
    80000e60:	9e89                	subw	a3,a3,a0
    80000e62:	00f6853b          	addw	a0,a3,a5
    80000e66:	0785                	addi	a5,a5,1
    80000e68:	fff7c703          	lbu	a4,-1(a5)
    80000e6c:	fb7d                	bnez	a4,80000e62 <strlen+0x14>
    80000e6e:	6422                	ld	s0,8(sp)
    80000e70:	0141                	addi	sp,sp,16
    80000e72:	8082                	ret
    80000e74:	4501                	li	a0,0
    80000e76:	bfe5                	j	80000e6e <strlen+0x20>

0000000080000e78 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000e78:	1141                	addi	sp,sp,-16
    80000e7a:	e406                	sd	ra,8(sp)
    80000e7c:	e022                	sd	s0,0(sp)
    80000e7e:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    80000e80:	00001097          	auipc	ra,0x1
    80000e84:	b10080e7          	jalr	-1264(ra) # 80001990 <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000e88:	00008717          	auipc	a4,0x8
    80000e8c:	a5070713          	addi	a4,a4,-1456 # 800088d8 <started>
  if(cpuid() == 0){
    80000e90:	c521                	beqz	a0,80000ed8 <main+0x60>
    while(started == 0)
    80000e92:	431c                	lw	a5,0(a4)
    80000e94:	2781                	sext.w	a5,a5
    80000e96:	dff5                	beqz	a5,80000e92 <main+0x1a>
      ;
    __sync_synchronize();
    80000e98:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    80000e9c:	00001097          	auipc	ra,0x1
    80000ea0:	af4080e7          	jalr	-1292(ra) # 80001990 <cpuid>
    80000ea4:	85aa                	mv	a1,a0
    80000ea6:	00007517          	auipc	a0,0x7
    80000eaa:	21250513          	addi	a0,a0,530 # 800080b8 <digits+0x78>
    80000eae:	fffff097          	auipc	ra,0xfffff
    80000eb2:	6da080e7          	jalr	1754(ra) # 80000588 <printf>
    kvminithart();    // turn on paging
    80000eb6:	00000097          	auipc	ra,0x0
    80000eba:	0da080e7          	jalr	218(ra) # 80000f90 <kvminithart>
    trapinithart();   // install kernel trap vector
    80000ebe:	00002097          	auipc	ra,0x2
    80000ec2:	8c8080e7          	jalr	-1848(ra) # 80002786 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000ec6:	00005097          	auipc	ra,0x5
    80000eca:	efa080e7          	jalr	-262(ra) # 80005dc0 <plicinithart>
  }

  scheduler(1);        
    80000ece:	4505                	li	a0,1
    80000ed0:	00001097          	auipc	ra,0x1
    80000ed4:	068080e7          	jalr	104(ra) # 80001f38 <scheduler>
    consoleinit();
    80000ed8:	fffff097          	auipc	ra,0xfffff
    80000edc:	578080e7          	jalr	1400(ra) # 80000450 <consoleinit>
    printfinit();
    80000ee0:	00000097          	auipc	ra,0x0
    80000ee4:	888080e7          	jalr	-1912(ra) # 80000768 <printfinit>
    printf("\n");
    80000ee8:	00007517          	auipc	a0,0x7
    80000eec:	1e050513          	addi	a0,a0,480 # 800080c8 <digits+0x88>
    80000ef0:	fffff097          	auipc	ra,0xfffff
    80000ef4:	698080e7          	jalr	1688(ra) # 80000588 <printf>
    printf("xv6 kernel is booting\n");
    80000ef8:	00007517          	auipc	a0,0x7
    80000efc:	1a850513          	addi	a0,a0,424 # 800080a0 <digits+0x60>
    80000f00:	fffff097          	auipc	ra,0xfffff
    80000f04:	688080e7          	jalr	1672(ra) # 80000588 <printf>
    printf("\n");
    80000f08:	00007517          	auipc	a0,0x7
    80000f0c:	1c050513          	addi	a0,a0,448 # 800080c8 <digits+0x88>
    80000f10:	fffff097          	auipc	ra,0xfffff
    80000f14:	678080e7          	jalr	1656(ra) # 80000588 <printf>
    kinit();         // physical page allocator
    80000f18:	00000097          	auipc	ra,0x0
    80000f1c:	b92080e7          	jalr	-1134(ra) # 80000aaa <kinit>
    kvminit();       // create kernel page table
    80000f20:	00000097          	auipc	ra,0x0
    80000f24:	326080e7          	jalr	806(ra) # 80001246 <kvminit>
    kvminithart();   // turn on paging
    80000f28:	00000097          	auipc	ra,0x0
    80000f2c:	068080e7          	jalr	104(ra) # 80000f90 <kvminithart>
    procinit();      // process table
    80000f30:	00001097          	auipc	ra,0x1
    80000f34:	99e080e7          	jalr	-1634(ra) # 800018ce <procinit>
    trapinit();      // trap vectors
    80000f38:	00002097          	auipc	ra,0x2
    80000f3c:	826080e7          	jalr	-2010(ra) # 8000275e <trapinit>
    trapinithart();  // install kernel trap vector
    80000f40:	00002097          	auipc	ra,0x2
    80000f44:	846080e7          	jalr	-1978(ra) # 80002786 <trapinithart>
    plicinit();      // set up interrupt controller
    80000f48:	00005097          	auipc	ra,0x5
    80000f4c:	e62080e7          	jalr	-414(ra) # 80005daa <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80000f50:	00005097          	auipc	ra,0x5
    80000f54:	e70080e7          	jalr	-400(ra) # 80005dc0 <plicinithart>
    binit();         // buffer cache
    80000f58:	00002097          	auipc	ra,0x2
    80000f5c:	fb4080e7          	jalr	-76(ra) # 80002f0c <binit>
    iinit();         // inode table
    80000f60:	00002097          	auipc	ra,0x2
    80000f64:	658080e7          	jalr	1624(ra) # 800035b8 <iinit>
    fileinit();      // file table
    80000f68:	00003097          	auipc	ra,0x3
    80000f6c:	5f6080e7          	jalr	1526(ra) # 8000455e <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000f70:	00005097          	auipc	ra,0x5
    80000f74:	f58080e7          	jalr	-168(ra) # 80005ec8 <virtio_disk_init>
    userinit();      // first user process
    80000f78:	00001097          	auipc	ra,0x1
    80000f7c:	d24080e7          	jalr	-732(ra) # 80001c9c <userinit>
    __sync_synchronize();
    80000f80:	0ff0000f          	fence
    started = 1;
    80000f84:	4785                	li	a5,1
    80000f86:	00008717          	auipc	a4,0x8
    80000f8a:	94f72923          	sw	a5,-1710(a4) # 800088d8 <started>
    80000f8e:	b781                	j	80000ece <main+0x56>

0000000080000f90 <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80000f90:	1141                	addi	sp,sp,-16
    80000f92:	e422                	sd	s0,8(sp)
    80000f94:	0800                	addi	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80000f96:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    80000f9a:	00008797          	auipc	a5,0x8
    80000f9e:	9467b783          	ld	a5,-1722(a5) # 800088e0 <kernel_pagetable>
    80000fa2:	83b1                	srli	a5,a5,0xc
    80000fa4:	577d                	li	a4,-1
    80000fa6:	177e                	slli	a4,a4,0x3f
    80000fa8:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    80000faa:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    80000fae:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    80000fb2:	6422                	ld	s0,8(sp)
    80000fb4:	0141                	addi	sp,sp,16
    80000fb6:	8082                	ret

0000000080000fb8 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80000fb8:	7139                	addi	sp,sp,-64
    80000fba:	fc06                	sd	ra,56(sp)
    80000fbc:	f822                	sd	s0,48(sp)
    80000fbe:	f426                	sd	s1,40(sp)
    80000fc0:	f04a                	sd	s2,32(sp)
    80000fc2:	ec4e                	sd	s3,24(sp)
    80000fc4:	e852                	sd	s4,16(sp)
    80000fc6:	e456                	sd	s5,8(sp)
    80000fc8:	e05a                	sd	s6,0(sp)
    80000fca:	0080                	addi	s0,sp,64
    80000fcc:	84aa                	mv	s1,a0
    80000fce:	89ae                	mv	s3,a1
    80000fd0:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    80000fd2:	57fd                	li	a5,-1
    80000fd4:	83e9                	srli	a5,a5,0x1a
    80000fd6:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80000fd8:	4b31                	li	s6,12
  if(va >= MAXVA)
    80000fda:	04b7f263          	bgeu	a5,a1,8000101e <walk+0x66>
    panic("walk");
    80000fde:	00007517          	auipc	a0,0x7
    80000fe2:	0f250513          	addi	a0,a0,242 # 800080d0 <digits+0x90>
    80000fe6:	fffff097          	auipc	ra,0xfffff
    80000fea:	558080e7          	jalr	1368(ra) # 8000053e <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80000fee:	060a8663          	beqz	s5,8000105a <walk+0xa2>
    80000ff2:	00000097          	auipc	ra,0x0
    80000ff6:	af4080e7          	jalr	-1292(ra) # 80000ae6 <kalloc>
    80000ffa:	84aa                	mv	s1,a0
    80000ffc:	c529                	beqz	a0,80001046 <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    80000ffe:	6605                	lui	a2,0x1
    80001000:	4581                	li	a1,0
    80001002:	00000097          	auipc	ra,0x0
    80001006:	cd0080e7          	jalr	-816(ra) # 80000cd2 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    8000100a:	00c4d793          	srli	a5,s1,0xc
    8000100e:	07aa                	slli	a5,a5,0xa
    80001010:	0017e793          	ori	a5,a5,1
    80001014:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    80001018:	3a5d                	addiw	s4,s4,-9
    8000101a:	036a0063          	beq	s4,s6,8000103a <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    8000101e:	0149d933          	srl	s2,s3,s4
    80001022:	1ff97913          	andi	s2,s2,511
    80001026:	090e                	slli	s2,s2,0x3
    80001028:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    8000102a:	00093483          	ld	s1,0(s2)
    8000102e:	0014f793          	andi	a5,s1,1
    80001032:	dfd5                	beqz	a5,80000fee <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80001034:	80a9                	srli	s1,s1,0xa
    80001036:	04b2                	slli	s1,s1,0xc
    80001038:	b7c5                	j	80001018 <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    8000103a:	00c9d513          	srli	a0,s3,0xc
    8000103e:	1ff57513          	andi	a0,a0,511
    80001042:	050e                	slli	a0,a0,0x3
    80001044:	9526                	add	a0,a0,s1
}
    80001046:	70e2                	ld	ra,56(sp)
    80001048:	7442                	ld	s0,48(sp)
    8000104a:	74a2                	ld	s1,40(sp)
    8000104c:	7902                	ld	s2,32(sp)
    8000104e:	69e2                	ld	s3,24(sp)
    80001050:	6a42                	ld	s4,16(sp)
    80001052:	6aa2                	ld	s5,8(sp)
    80001054:	6b02                	ld	s6,0(sp)
    80001056:	6121                	addi	sp,sp,64
    80001058:	8082                	ret
        return 0;
    8000105a:	4501                	li	a0,0
    8000105c:	b7ed                	j	80001046 <walk+0x8e>

000000008000105e <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    8000105e:	57fd                	li	a5,-1
    80001060:	83e9                	srli	a5,a5,0x1a
    80001062:	00b7f463          	bgeu	a5,a1,8000106a <walkaddr+0xc>
    return 0;
    80001066:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80001068:	8082                	ret
{
    8000106a:	1141                	addi	sp,sp,-16
    8000106c:	e406                	sd	ra,8(sp)
    8000106e:	e022                	sd	s0,0(sp)
    80001070:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    80001072:	4601                	li	a2,0
    80001074:	00000097          	auipc	ra,0x0
    80001078:	f44080e7          	jalr	-188(ra) # 80000fb8 <walk>
  if(pte == 0)
    8000107c:	c105                	beqz	a0,8000109c <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    8000107e:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    80001080:	0117f693          	andi	a3,a5,17
    80001084:	4745                	li	a4,17
    return 0;
    80001086:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    80001088:	00e68663          	beq	a3,a4,80001094 <walkaddr+0x36>
}
    8000108c:	60a2                	ld	ra,8(sp)
    8000108e:	6402                	ld	s0,0(sp)
    80001090:	0141                	addi	sp,sp,16
    80001092:	8082                	ret
  pa = PTE2PA(*pte);
    80001094:	00a7d513          	srli	a0,a5,0xa
    80001098:	0532                	slli	a0,a0,0xc
  return pa;
    8000109a:	bfcd                	j	8000108c <walkaddr+0x2e>
    return 0;
    8000109c:	4501                	li	a0,0
    8000109e:	b7fd                	j	8000108c <walkaddr+0x2e>

00000000800010a0 <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    800010a0:	715d                	addi	sp,sp,-80
    800010a2:	e486                	sd	ra,72(sp)
    800010a4:	e0a2                	sd	s0,64(sp)
    800010a6:	fc26                	sd	s1,56(sp)
    800010a8:	f84a                	sd	s2,48(sp)
    800010aa:	f44e                	sd	s3,40(sp)
    800010ac:	f052                	sd	s4,32(sp)
    800010ae:	ec56                	sd	s5,24(sp)
    800010b0:	e85a                	sd	s6,16(sp)
    800010b2:	e45e                	sd	s7,8(sp)
    800010b4:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    800010b6:	c639                	beqz	a2,80001104 <mappages+0x64>
    800010b8:	8aaa                	mv	s5,a0
    800010ba:	8b3a                	mv	s6,a4
    panic("mappages: size");
  
  a = PGROUNDDOWN(va);
    800010bc:	77fd                	lui	a5,0xfffff
    800010be:	00f5fa33          	and	s4,a1,a5
  last = PGROUNDDOWN(va + size - 1);
    800010c2:	15fd                	addi	a1,a1,-1
    800010c4:	00c589b3          	add	s3,a1,a2
    800010c8:	00f9f9b3          	and	s3,s3,a5
  a = PGROUNDDOWN(va);
    800010cc:	8952                	mv	s2,s4
    800010ce:	41468a33          	sub	s4,a3,s4
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    800010d2:	6b85                	lui	s7,0x1
    800010d4:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    800010d8:	4605                	li	a2,1
    800010da:	85ca                	mv	a1,s2
    800010dc:	8556                	mv	a0,s5
    800010de:	00000097          	auipc	ra,0x0
    800010e2:	eda080e7          	jalr	-294(ra) # 80000fb8 <walk>
    800010e6:	cd1d                	beqz	a0,80001124 <mappages+0x84>
    if(*pte & PTE_V)
    800010e8:	611c                	ld	a5,0(a0)
    800010ea:	8b85                	andi	a5,a5,1
    800010ec:	e785                	bnez	a5,80001114 <mappages+0x74>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800010ee:	80b1                	srli	s1,s1,0xc
    800010f0:	04aa                	slli	s1,s1,0xa
    800010f2:	0164e4b3          	or	s1,s1,s6
    800010f6:	0014e493          	ori	s1,s1,1
    800010fa:	e104                	sd	s1,0(a0)
    if(a == last)
    800010fc:	05390063          	beq	s2,s3,8000113c <mappages+0x9c>
    a += PGSIZE;
    80001100:	995e                	add	s2,s2,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    80001102:	bfc9                	j	800010d4 <mappages+0x34>
    panic("mappages: size");
    80001104:	00007517          	auipc	a0,0x7
    80001108:	fd450513          	addi	a0,a0,-44 # 800080d8 <digits+0x98>
    8000110c:	fffff097          	auipc	ra,0xfffff
    80001110:	432080e7          	jalr	1074(ra) # 8000053e <panic>
      panic("mappages: remap");
    80001114:	00007517          	auipc	a0,0x7
    80001118:	fd450513          	addi	a0,a0,-44 # 800080e8 <digits+0xa8>
    8000111c:	fffff097          	auipc	ra,0xfffff
    80001120:	422080e7          	jalr	1058(ra) # 8000053e <panic>
      return -1;
    80001124:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    80001126:	60a6                	ld	ra,72(sp)
    80001128:	6406                	ld	s0,64(sp)
    8000112a:	74e2                	ld	s1,56(sp)
    8000112c:	7942                	ld	s2,48(sp)
    8000112e:	79a2                	ld	s3,40(sp)
    80001130:	7a02                	ld	s4,32(sp)
    80001132:	6ae2                	ld	s5,24(sp)
    80001134:	6b42                	ld	s6,16(sp)
    80001136:	6ba2                	ld	s7,8(sp)
    80001138:	6161                	addi	sp,sp,80
    8000113a:	8082                	ret
  return 0;
    8000113c:	4501                	li	a0,0
    8000113e:	b7e5                	j	80001126 <mappages+0x86>

0000000080001140 <kvmmap>:
{
    80001140:	1141                	addi	sp,sp,-16
    80001142:	e406                	sd	ra,8(sp)
    80001144:	e022                	sd	s0,0(sp)
    80001146:	0800                	addi	s0,sp,16
    80001148:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    8000114a:	86b2                	mv	a3,a2
    8000114c:	863e                	mv	a2,a5
    8000114e:	00000097          	auipc	ra,0x0
    80001152:	f52080e7          	jalr	-174(ra) # 800010a0 <mappages>
    80001156:	e509                	bnez	a0,80001160 <kvmmap+0x20>
}
    80001158:	60a2                	ld	ra,8(sp)
    8000115a:	6402                	ld	s0,0(sp)
    8000115c:	0141                	addi	sp,sp,16
    8000115e:	8082                	ret
    panic("kvmmap");
    80001160:	00007517          	auipc	a0,0x7
    80001164:	f9850513          	addi	a0,a0,-104 # 800080f8 <digits+0xb8>
    80001168:	fffff097          	auipc	ra,0xfffff
    8000116c:	3d6080e7          	jalr	982(ra) # 8000053e <panic>

0000000080001170 <kvmmake>:
{
    80001170:	1101                	addi	sp,sp,-32
    80001172:	ec06                	sd	ra,24(sp)
    80001174:	e822                	sd	s0,16(sp)
    80001176:	e426                	sd	s1,8(sp)
    80001178:	e04a                	sd	s2,0(sp)
    8000117a:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    8000117c:	00000097          	auipc	ra,0x0
    80001180:	96a080e7          	jalr	-1686(ra) # 80000ae6 <kalloc>
    80001184:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    80001186:	6605                	lui	a2,0x1
    80001188:	4581                	li	a1,0
    8000118a:	00000097          	auipc	ra,0x0
    8000118e:	b48080e7          	jalr	-1208(ra) # 80000cd2 <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80001192:	4719                	li	a4,6
    80001194:	6685                	lui	a3,0x1
    80001196:	10000637          	lui	a2,0x10000
    8000119a:	100005b7          	lui	a1,0x10000
    8000119e:	8526                	mv	a0,s1
    800011a0:	00000097          	auipc	ra,0x0
    800011a4:	fa0080e7          	jalr	-96(ra) # 80001140 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    800011a8:	4719                	li	a4,6
    800011aa:	6685                	lui	a3,0x1
    800011ac:	10001637          	lui	a2,0x10001
    800011b0:	100015b7          	lui	a1,0x10001
    800011b4:	8526                	mv	a0,s1
    800011b6:	00000097          	auipc	ra,0x0
    800011ba:	f8a080e7          	jalr	-118(ra) # 80001140 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    800011be:	4719                	li	a4,6
    800011c0:	004006b7          	lui	a3,0x400
    800011c4:	0c000637          	lui	a2,0xc000
    800011c8:	0c0005b7          	lui	a1,0xc000
    800011cc:	8526                	mv	a0,s1
    800011ce:	00000097          	auipc	ra,0x0
    800011d2:	f72080e7          	jalr	-142(ra) # 80001140 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800011d6:	00007917          	auipc	s2,0x7
    800011da:	e2a90913          	addi	s2,s2,-470 # 80008000 <etext>
    800011de:	4729                	li	a4,10
    800011e0:	80007697          	auipc	a3,0x80007
    800011e4:	e2068693          	addi	a3,a3,-480 # 8000 <_entry-0x7fff8000>
    800011e8:	4605                	li	a2,1
    800011ea:	067e                	slli	a2,a2,0x1f
    800011ec:	85b2                	mv	a1,a2
    800011ee:	8526                	mv	a0,s1
    800011f0:	00000097          	auipc	ra,0x0
    800011f4:	f50080e7          	jalr	-176(ra) # 80001140 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800011f8:	4719                	li	a4,6
    800011fa:	46c5                	li	a3,17
    800011fc:	06ee                	slli	a3,a3,0x1b
    800011fe:	412686b3          	sub	a3,a3,s2
    80001202:	864a                	mv	a2,s2
    80001204:	85ca                	mv	a1,s2
    80001206:	8526                	mv	a0,s1
    80001208:	00000097          	auipc	ra,0x0
    8000120c:	f38080e7          	jalr	-200(ra) # 80001140 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    80001210:	4729                	li	a4,10
    80001212:	6685                	lui	a3,0x1
    80001214:	00006617          	auipc	a2,0x6
    80001218:	dec60613          	addi	a2,a2,-532 # 80007000 <_trampoline>
    8000121c:	040005b7          	lui	a1,0x4000
    80001220:	15fd                	addi	a1,a1,-1
    80001222:	05b2                	slli	a1,a1,0xc
    80001224:	8526                	mv	a0,s1
    80001226:	00000097          	auipc	ra,0x0
    8000122a:	f1a080e7          	jalr	-230(ra) # 80001140 <kvmmap>
  proc_mapstacks(kpgtbl);
    8000122e:	8526                	mv	a0,s1
    80001230:	00000097          	auipc	ra,0x0
    80001234:	608080e7          	jalr	1544(ra) # 80001838 <proc_mapstacks>
}
    80001238:	8526                	mv	a0,s1
    8000123a:	60e2                	ld	ra,24(sp)
    8000123c:	6442                	ld	s0,16(sp)
    8000123e:	64a2                	ld	s1,8(sp)
    80001240:	6902                	ld	s2,0(sp)
    80001242:	6105                	addi	sp,sp,32
    80001244:	8082                	ret

0000000080001246 <kvminit>:
{
    80001246:	1141                	addi	sp,sp,-16
    80001248:	e406                	sd	ra,8(sp)
    8000124a:	e022                	sd	s0,0(sp)
    8000124c:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    8000124e:	00000097          	auipc	ra,0x0
    80001252:	f22080e7          	jalr	-222(ra) # 80001170 <kvmmake>
    80001256:	00007797          	auipc	a5,0x7
    8000125a:	68a7b523          	sd	a0,1674(a5) # 800088e0 <kernel_pagetable>
}
    8000125e:	60a2                	ld	ra,8(sp)
    80001260:	6402                	ld	s0,0(sp)
    80001262:	0141                	addi	sp,sp,16
    80001264:	8082                	ret

0000000080001266 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80001266:	715d                	addi	sp,sp,-80
    80001268:	e486                	sd	ra,72(sp)
    8000126a:	e0a2                	sd	s0,64(sp)
    8000126c:	fc26                	sd	s1,56(sp)
    8000126e:	f84a                	sd	s2,48(sp)
    80001270:	f44e                	sd	s3,40(sp)
    80001272:	f052                	sd	s4,32(sp)
    80001274:	ec56                	sd	s5,24(sp)
    80001276:	e85a                	sd	s6,16(sp)
    80001278:	e45e                	sd	s7,8(sp)
    8000127a:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    8000127c:	03459793          	slli	a5,a1,0x34
    80001280:	e795                	bnez	a5,800012ac <uvmunmap+0x46>
    80001282:	8a2a                	mv	s4,a0
    80001284:	892e                	mv	s2,a1
    80001286:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001288:	0632                	slli	a2,a2,0xc
    8000128a:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    8000128e:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001290:	6b05                	lui	s6,0x1
    80001292:	0735e263          	bltu	a1,s3,800012f6 <uvmunmap+0x90>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    80001296:	60a6                	ld	ra,72(sp)
    80001298:	6406                	ld	s0,64(sp)
    8000129a:	74e2                	ld	s1,56(sp)
    8000129c:	7942                	ld	s2,48(sp)
    8000129e:	79a2                	ld	s3,40(sp)
    800012a0:	7a02                	ld	s4,32(sp)
    800012a2:	6ae2                	ld	s5,24(sp)
    800012a4:	6b42                	ld	s6,16(sp)
    800012a6:	6ba2                	ld	s7,8(sp)
    800012a8:	6161                	addi	sp,sp,80
    800012aa:	8082                	ret
    panic("uvmunmap: not aligned");
    800012ac:	00007517          	auipc	a0,0x7
    800012b0:	e5450513          	addi	a0,a0,-428 # 80008100 <digits+0xc0>
    800012b4:	fffff097          	auipc	ra,0xfffff
    800012b8:	28a080e7          	jalr	650(ra) # 8000053e <panic>
      panic("uvmunmap: walk");
    800012bc:	00007517          	auipc	a0,0x7
    800012c0:	e5c50513          	addi	a0,a0,-420 # 80008118 <digits+0xd8>
    800012c4:	fffff097          	auipc	ra,0xfffff
    800012c8:	27a080e7          	jalr	634(ra) # 8000053e <panic>
      panic("uvmunmap: not mapped");
    800012cc:	00007517          	auipc	a0,0x7
    800012d0:	e5c50513          	addi	a0,a0,-420 # 80008128 <digits+0xe8>
    800012d4:	fffff097          	auipc	ra,0xfffff
    800012d8:	26a080e7          	jalr	618(ra) # 8000053e <panic>
      panic("uvmunmap: not a leaf");
    800012dc:	00007517          	auipc	a0,0x7
    800012e0:	e6450513          	addi	a0,a0,-412 # 80008140 <digits+0x100>
    800012e4:	fffff097          	auipc	ra,0xfffff
    800012e8:	25a080e7          	jalr	602(ra) # 8000053e <panic>
    *pte = 0;
    800012ec:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800012f0:	995a                	add	s2,s2,s6
    800012f2:	fb3972e3          	bgeu	s2,s3,80001296 <uvmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    800012f6:	4601                	li	a2,0
    800012f8:	85ca                	mv	a1,s2
    800012fa:	8552                	mv	a0,s4
    800012fc:	00000097          	auipc	ra,0x0
    80001300:	cbc080e7          	jalr	-836(ra) # 80000fb8 <walk>
    80001304:	84aa                	mv	s1,a0
    80001306:	d95d                	beqz	a0,800012bc <uvmunmap+0x56>
    if((*pte & PTE_V) == 0)
    80001308:	6108                	ld	a0,0(a0)
    8000130a:	00157793          	andi	a5,a0,1
    8000130e:	dfdd                	beqz	a5,800012cc <uvmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V)
    80001310:	3ff57793          	andi	a5,a0,1023
    80001314:	fd7784e3          	beq	a5,s7,800012dc <uvmunmap+0x76>
    if(do_free){
    80001318:	fc0a8ae3          	beqz	s5,800012ec <uvmunmap+0x86>
      uint64 pa = PTE2PA(*pte);
    8000131c:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    8000131e:	0532                	slli	a0,a0,0xc
    80001320:	fffff097          	auipc	ra,0xfffff
    80001324:	6ca080e7          	jalr	1738(ra) # 800009ea <kfree>
    80001328:	b7d1                	j	800012ec <uvmunmap+0x86>

000000008000132a <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    8000132a:	1101                	addi	sp,sp,-32
    8000132c:	ec06                	sd	ra,24(sp)
    8000132e:	e822                	sd	s0,16(sp)
    80001330:	e426                	sd	s1,8(sp)
    80001332:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80001334:	fffff097          	auipc	ra,0xfffff
    80001338:	7b2080e7          	jalr	1970(ra) # 80000ae6 <kalloc>
    8000133c:	84aa                	mv	s1,a0
  if(pagetable == 0)
    8000133e:	c519                	beqz	a0,8000134c <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    80001340:	6605                	lui	a2,0x1
    80001342:	4581                	li	a1,0
    80001344:	00000097          	auipc	ra,0x0
    80001348:	98e080e7          	jalr	-1650(ra) # 80000cd2 <memset>
  return pagetable;
}
    8000134c:	8526                	mv	a0,s1
    8000134e:	60e2                	ld	ra,24(sp)
    80001350:	6442                	ld	s0,16(sp)
    80001352:	64a2                	ld	s1,8(sp)
    80001354:	6105                	addi	sp,sp,32
    80001356:	8082                	ret

0000000080001358 <uvmfirst>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvmfirst(pagetable_t pagetable, uchar *src, uint sz)
{
    80001358:	7179                	addi	sp,sp,-48
    8000135a:	f406                	sd	ra,40(sp)
    8000135c:	f022                	sd	s0,32(sp)
    8000135e:	ec26                	sd	s1,24(sp)
    80001360:	e84a                	sd	s2,16(sp)
    80001362:	e44e                	sd	s3,8(sp)
    80001364:	e052                	sd	s4,0(sp)
    80001366:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    80001368:	6785                	lui	a5,0x1
    8000136a:	04f67863          	bgeu	a2,a5,800013ba <uvmfirst+0x62>
    8000136e:	8a2a                	mv	s4,a0
    80001370:	89ae                	mv	s3,a1
    80001372:	84b2                	mv	s1,a2
    panic("uvmfirst: more than a page");
  mem = kalloc();
    80001374:	fffff097          	auipc	ra,0xfffff
    80001378:	772080e7          	jalr	1906(ra) # 80000ae6 <kalloc>
    8000137c:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    8000137e:	6605                	lui	a2,0x1
    80001380:	4581                	li	a1,0
    80001382:	00000097          	auipc	ra,0x0
    80001386:	950080e7          	jalr	-1712(ra) # 80000cd2 <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    8000138a:	4779                	li	a4,30
    8000138c:	86ca                	mv	a3,s2
    8000138e:	6605                	lui	a2,0x1
    80001390:	4581                	li	a1,0
    80001392:	8552                	mv	a0,s4
    80001394:	00000097          	auipc	ra,0x0
    80001398:	d0c080e7          	jalr	-756(ra) # 800010a0 <mappages>
  memmove(mem, src, sz);
    8000139c:	8626                	mv	a2,s1
    8000139e:	85ce                	mv	a1,s3
    800013a0:	854a                	mv	a0,s2
    800013a2:	00000097          	auipc	ra,0x0
    800013a6:	98c080e7          	jalr	-1652(ra) # 80000d2e <memmove>
}
    800013aa:	70a2                	ld	ra,40(sp)
    800013ac:	7402                	ld	s0,32(sp)
    800013ae:	64e2                	ld	s1,24(sp)
    800013b0:	6942                	ld	s2,16(sp)
    800013b2:	69a2                	ld	s3,8(sp)
    800013b4:	6a02                	ld	s4,0(sp)
    800013b6:	6145                	addi	sp,sp,48
    800013b8:	8082                	ret
    panic("uvmfirst: more than a page");
    800013ba:	00007517          	auipc	a0,0x7
    800013be:	d9e50513          	addi	a0,a0,-610 # 80008158 <digits+0x118>
    800013c2:	fffff097          	auipc	ra,0xfffff
    800013c6:	17c080e7          	jalr	380(ra) # 8000053e <panic>

00000000800013ca <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    800013ca:	1101                	addi	sp,sp,-32
    800013cc:	ec06                	sd	ra,24(sp)
    800013ce:	e822                	sd	s0,16(sp)
    800013d0:	e426                	sd	s1,8(sp)
    800013d2:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    800013d4:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    800013d6:	00b67d63          	bgeu	a2,a1,800013f0 <uvmdealloc+0x26>
    800013da:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    800013dc:	6785                	lui	a5,0x1
    800013de:	17fd                	addi	a5,a5,-1
    800013e0:	00f60733          	add	a4,a2,a5
    800013e4:	767d                	lui	a2,0xfffff
    800013e6:	8f71                	and	a4,a4,a2
    800013e8:	97ae                	add	a5,a5,a1
    800013ea:	8ff1                	and	a5,a5,a2
    800013ec:	00f76863          	bltu	a4,a5,800013fc <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    800013f0:	8526                	mv	a0,s1
    800013f2:	60e2                	ld	ra,24(sp)
    800013f4:	6442                	ld	s0,16(sp)
    800013f6:	64a2                	ld	s1,8(sp)
    800013f8:	6105                	addi	sp,sp,32
    800013fa:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    800013fc:	8f99                	sub	a5,a5,a4
    800013fe:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    80001400:	4685                	li	a3,1
    80001402:	0007861b          	sext.w	a2,a5
    80001406:	85ba                	mv	a1,a4
    80001408:	00000097          	auipc	ra,0x0
    8000140c:	e5e080e7          	jalr	-418(ra) # 80001266 <uvmunmap>
    80001410:	b7c5                	j	800013f0 <uvmdealloc+0x26>

0000000080001412 <uvmalloc>:
  if(newsz < oldsz)
    80001412:	0ab66563          	bltu	a2,a1,800014bc <uvmalloc+0xaa>
{
    80001416:	7139                	addi	sp,sp,-64
    80001418:	fc06                	sd	ra,56(sp)
    8000141a:	f822                	sd	s0,48(sp)
    8000141c:	f426                	sd	s1,40(sp)
    8000141e:	f04a                	sd	s2,32(sp)
    80001420:	ec4e                	sd	s3,24(sp)
    80001422:	e852                	sd	s4,16(sp)
    80001424:	e456                	sd	s5,8(sp)
    80001426:	e05a                	sd	s6,0(sp)
    80001428:	0080                	addi	s0,sp,64
    8000142a:	8aaa                	mv	s5,a0
    8000142c:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    8000142e:	6985                	lui	s3,0x1
    80001430:	19fd                	addi	s3,s3,-1
    80001432:	95ce                	add	a1,a1,s3
    80001434:	79fd                	lui	s3,0xfffff
    80001436:	0135f9b3          	and	s3,a1,s3
  for(a = oldsz; a < newsz; a += PGSIZE){
    8000143a:	08c9f363          	bgeu	s3,a2,800014c0 <uvmalloc+0xae>
    8000143e:	894e                	mv	s2,s3
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80001440:	0126eb13          	ori	s6,a3,18
    mem = kalloc();
    80001444:	fffff097          	auipc	ra,0xfffff
    80001448:	6a2080e7          	jalr	1698(ra) # 80000ae6 <kalloc>
    8000144c:	84aa                	mv	s1,a0
    if(mem == 0){
    8000144e:	c51d                	beqz	a0,8000147c <uvmalloc+0x6a>
    memset(mem, 0, PGSIZE);
    80001450:	6605                	lui	a2,0x1
    80001452:	4581                	li	a1,0
    80001454:	00000097          	auipc	ra,0x0
    80001458:	87e080e7          	jalr	-1922(ra) # 80000cd2 <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    8000145c:	875a                	mv	a4,s6
    8000145e:	86a6                	mv	a3,s1
    80001460:	6605                	lui	a2,0x1
    80001462:	85ca                	mv	a1,s2
    80001464:	8556                	mv	a0,s5
    80001466:	00000097          	auipc	ra,0x0
    8000146a:	c3a080e7          	jalr	-966(ra) # 800010a0 <mappages>
    8000146e:	e90d                	bnez	a0,800014a0 <uvmalloc+0x8e>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80001470:	6785                	lui	a5,0x1
    80001472:	993e                	add	s2,s2,a5
    80001474:	fd4968e3          	bltu	s2,s4,80001444 <uvmalloc+0x32>
  return newsz;
    80001478:	8552                	mv	a0,s4
    8000147a:	a809                	j	8000148c <uvmalloc+0x7a>
      uvmdealloc(pagetable, a, oldsz);
    8000147c:	864e                	mv	a2,s3
    8000147e:	85ca                	mv	a1,s2
    80001480:	8556                	mv	a0,s5
    80001482:	00000097          	auipc	ra,0x0
    80001486:	f48080e7          	jalr	-184(ra) # 800013ca <uvmdealloc>
      return 0;
    8000148a:	4501                	li	a0,0
}
    8000148c:	70e2                	ld	ra,56(sp)
    8000148e:	7442                	ld	s0,48(sp)
    80001490:	74a2                	ld	s1,40(sp)
    80001492:	7902                	ld	s2,32(sp)
    80001494:	69e2                	ld	s3,24(sp)
    80001496:	6a42                	ld	s4,16(sp)
    80001498:	6aa2                	ld	s5,8(sp)
    8000149a:	6b02                	ld	s6,0(sp)
    8000149c:	6121                	addi	sp,sp,64
    8000149e:	8082                	ret
      kfree(mem);
    800014a0:	8526                	mv	a0,s1
    800014a2:	fffff097          	auipc	ra,0xfffff
    800014a6:	548080e7          	jalr	1352(ra) # 800009ea <kfree>
      uvmdealloc(pagetable, a, oldsz);
    800014aa:	864e                	mv	a2,s3
    800014ac:	85ca                	mv	a1,s2
    800014ae:	8556                	mv	a0,s5
    800014b0:	00000097          	auipc	ra,0x0
    800014b4:	f1a080e7          	jalr	-230(ra) # 800013ca <uvmdealloc>
      return 0;
    800014b8:	4501                	li	a0,0
    800014ba:	bfc9                	j	8000148c <uvmalloc+0x7a>
    return oldsz;
    800014bc:	852e                	mv	a0,a1
}
    800014be:	8082                	ret
  return newsz;
    800014c0:	8532                	mv	a0,a2
    800014c2:	b7e9                	j	8000148c <uvmalloc+0x7a>

00000000800014c4 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    800014c4:	7179                	addi	sp,sp,-48
    800014c6:	f406                	sd	ra,40(sp)
    800014c8:	f022                	sd	s0,32(sp)
    800014ca:	ec26                	sd	s1,24(sp)
    800014cc:	e84a                	sd	s2,16(sp)
    800014ce:	e44e                	sd	s3,8(sp)
    800014d0:	e052                	sd	s4,0(sp)
    800014d2:	1800                	addi	s0,sp,48
    800014d4:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    800014d6:	84aa                	mv	s1,a0
    800014d8:	6905                	lui	s2,0x1
    800014da:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800014dc:	4985                	li	s3,1
    800014de:	a821                	j	800014f6 <freewalk+0x32>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    800014e0:	8129                	srli	a0,a0,0xa
      freewalk((pagetable_t)child);
    800014e2:	0532                	slli	a0,a0,0xc
    800014e4:	00000097          	auipc	ra,0x0
    800014e8:	fe0080e7          	jalr	-32(ra) # 800014c4 <freewalk>
      pagetable[i] = 0;
    800014ec:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    800014f0:	04a1                	addi	s1,s1,8
    800014f2:	03248163          	beq	s1,s2,80001514 <freewalk+0x50>
    pte_t pte = pagetable[i];
    800014f6:	6088                	ld	a0,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800014f8:	00f57793          	andi	a5,a0,15
    800014fc:	ff3782e3          	beq	a5,s3,800014e0 <freewalk+0x1c>
    } else if(pte & PTE_V){
    80001500:	8905                	andi	a0,a0,1
    80001502:	d57d                	beqz	a0,800014f0 <freewalk+0x2c>
      panic("freewalk: leaf");
    80001504:	00007517          	auipc	a0,0x7
    80001508:	c7450513          	addi	a0,a0,-908 # 80008178 <digits+0x138>
    8000150c:	fffff097          	auipc	ra,0xfffff
    80001510:	032080e7          	jalr	50(ra) # 8000053e <panic>
    }
  }
  kfree((void*)pagetable);
    80001514:	8552                	mv	a0,s4
    80001516:	fffff097          	auipc	ra,0xfffff
    8000151a:	4d4080e7          	jalr	1236(ra) # 800009ea <kfree>
}
    8000151e:	70a2                	ld	ra,40(sp)
    80001520:	7402                	ld	s0,32(sp)
    80001522:	64e2                	ld	s1,24(sp)
    80001524:	6942                	ld	s2,16(sp)
    80001526:	69a2                	ld	s3,8(sp)
    80001528:	6a02                	ld	s4,0(sp)
    8000152a:	6145                	addi	sp,sp,48
    8000152c:	8082                	ret

000000008000152e <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    8000152e:	1101                	addi	sp,sp,-32
    80001530:	ec06                	sd	ra,24(sp)
    80001532:	e822                	sd	s0,16(sp)
    80001534:	e426                	sd	s1,8(sp)
    80001536:	1000                	addi	s0,sp,32
    80001538:	84aa                	mv	s1,a0
  if(sz > 0)
    8000153a:	e999                	bnez	a1,80001550 <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    8000153c:	8526                	mv	a0,s1
    8000153e:	00000097          	auipc	ra,0x0
    80001542:	f86080e7          	jalr	-122(ra) # 800014c4 <freewalk>
}
    80001546:	60e2                	ld	ra,24(sp)
    80001548:	6442                	ld	s0,16(sp)
    8000154a:	64a2                	ld	s1,8(sp)
    8000154c:	6105                	addi	sp,sp,32
    8000154e:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80001550:	6605                	lui	a2,0x1
    80001552:	167d                	addi	a2,a2,-1
    80001554:	962e                	add	a2,a2,a1
    80001556:	4685                	li	a3,1
    80001558:	8231                	srli	a2,a2,0xc
    8000155a:	4581                	li	a1,0
    8000155c:	00000097          	auipc	ra,0x0
    80001560:	d0a080e7          	jalr	-758(ra) # 80001266 <uvmunmap>
    80001564:	bfe1                	j	8000153c <uvmfree+0xe>

0000000080001566 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80001566:	c679                	beqz	a2,80001634 <uvmcopy+0xce>
{
    80001568:	715d                	addi	sp,sp,-80
    8000156a:	e486                	sd	ra,72(sp)
    8000156c:	e0a2                	sd	s0,64(sp)
    8000156e:	fc26                	sd	s1,56(sp)
    80001570:	f84a                	sd	s2,48(sp)
    80001572:	f44e                	sd	s3,40(sp)
    80001574:	f052                	sd	s4,32(sp)
    80001576:	ec56                	sd	s5,24(sp)
    80001578:	e85a                	sd	s6,16(sp)
    8000157a:	e45e                	sd	s7,8(sp)
    8000157c:	0880                	addi	s0,sp,80
    8000157e:	8b2a                	mv	s6,a0
    80001580:	8aae                	mv	s5,a1
    80001582:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    80001584:	4981                	li	s3,0
    if((pte = walk(old, i, 0)) == 0)
    80001586:	4601                	li	a2,0
    80001588:	85ce                	mv	a1,s3
    8000158a:	855a                	mv	a0,s6
    8000158c:	00000097          	auipc	ra,0x0
    80001590:	a2c080e7          	jalr	-1492(ra) # 80000fb8 <walk>
    80001594:	c531                	beqz	a0,800015e0 <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    80001596:	6118                	ld	a4,0(a0)
    80001598:	00177793          	andi	a5,a4,1
    8000159c:	cbb1                	beqz	a5,800015f0 <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    8000159e:	00a75593          	srli	a1,a4,0xa
    800015a2:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    800015a6:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    800015aa:	fffff097          	auipc	ra,0xfffff
    800015ae:	53c080e7          	jalr	1340(ra) # 80000ae6 <kalloc>
    800015b2:	892a                	mv	s2,a0
    800015b4:	c939                	beqz	a0,8000160a <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    800015b6:	6605                	lui	a2,0x1
    800015b8:	85de                	mv	a1,s7
    800015ba:	fffff097          	auipc	ra,0xfffff
    800015be:	774080e7          	jalr	1908(ra) # 80000d2e <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    800015c2:	8726                	mv	a4,s1
    800015c4:	86ca                	mv	a3,s2
    800015c6:	6605                	lui	a2,0x1
    800015c8:	85ce                	mv	a1,s3
    800015ca:	8556                	mv	a0,s5
    800015cc:	00000097          	auipc	ra,0x0
    800015d0:	ad4080e7          	jalr	-1324(ra) # 800010a0 <mappages>
    800015d4:	e515                	bnez	a0,80001600 <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    800015d6:	6785                	lui	a5,0x1
    800015d8:	99be                	add	s3,s3,a5
    800015da:	fb49e6e3          	bltu	s3,s4,80001586 <uvmcopy+0x20>
    800015de:	a081                	j	8000161e <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    800015e0:	00007517          	auipc	a0,0x7
    800015e4:	ba850513          	addi	a0,a0,-1112 # 80008188 <digits+0x148>
    800015e8:	fffff097          	auipc	ra,0xfffff
    800015ec:	f56080e7          	jalr	-170(ra) # 8000053e <panic>
      panic("uvmcopy: page not present");
    800015f0:	00007517          	auipc	a0,0x7
    800015f4:	bb850513          	addi	a0,a0,-1096 # 800081a8 <digits+0x168>
    800015f8:	fffff097          	auipc	ra,0xfffff
    800015fc:	f46080e7          	jalr	-186(ra) # 8000053e <panic>
      kfree(mem);
    80001600:	854a                	mv	a0,s2
    80001602:	fffff097          	auipc	ra,0xfffff
    80001606:	3e8080e7          	jalr	1000(ra) # 800009ea <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    8000160a:	4685                	li	a3,1
    8000160c:	00c9d613          	srli	a2,s3,0xc
    80001610:	4581                	li	a1,0
    80001612:	8556                	mv	a0,s5
    80001614:	00000097          	auipc	ra,0x0
    80001618:	c52080e7          	jalr	-942(ra) # 80001266 <uvmunmap>
  return -1;
    8000161c:	557d                	li	a0,-1
}
    8000161e:	60a6                	ld	ra,72(sp)
    80001620:	6406                	ld	s0,64(sp)
    80001622:	74e2                	ld	s1,56(sp)
    80001624:	7942                	ld	s2,48(sp)
    80001626:	79a2                	ld	s3,40(sp)
    80001628:	7a02                	ld	s4,32(sp)
    8000162a:	6ae2                	ld	s5,24(sp)
    8000162c:	6b42                	ld	s6,16(sp)
    8000162e:	6ba2                	ld	s7,8(sp)
    80001630:	6161                	addi	sp,sp,80
    80001632:	8082                	ret
  return 0;
    80001634:	4501                	li	a0,0
}
    80001636:	8082                	ret

0000000080001638 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80001638:	1141                	addi	sp,sp,-16
    8000163a:	e406                	sd	ra,8(sp)
    8000163c:	e022                	sd	s0,0(sp)
    8000163e:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80001640:	4601                	li	a2,0
    80001642:	00000097          	auipc	ra,0x0
    80001646:	976080e7          	jalr	-1674(ra) # 80000fb8 <walk>
  if(pte == 0)
    8000164a:	c901                	beqz	a0,8000165a <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    8000164c:	611c                	ld	a5,0(a0)
    8000164e:	9bbd                	andi	a5,a5,-17
    80001650:	e11c                	sd	a5,0(a0)
}
    80001652:	60a2                	ld	ra,8(sp)
    80001654:	6402                	ld	s0,0(sp)
    80001656:	0141                	addi	sp,sp,16
    80001658:	8082                	ret
    panic("uvmclear");
    8000165a:	00007517          	auipc	a0,0x7
    8000165e:	b6e50513          	addi	a0,a0,-1170 # 800081c8 <digits+0x188>
    80001662:	fffff097          	auipc	ra,0xfffff
    80001666:	edc080e7          	jalr	-292(ra) # 8000053e <panic>

000000008000166a <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    8000166a:	c6bd                	beqz	a3,800016d8 <copyout+0x6e>
{
    8000166c:	715d                	addi	sp,sp,-80
    8000166e:	e486                	sd	ra,72(sp)
    80001670:	e0a2                	sd	s0,64(sp)
    80001672:	fc26                	sd	s1,56(sp)
    80001674:	f84a                	sd	s2,48(sp)
    80001676:	f44e                	sd	s3,40(sp)
    80001678:	f052                	sd	s4,32(sp)
    8000167a:	ec56                	sd	s5,24(sp)
    8000167c:	e85a                	sd	s6,16(sp)
    8000167e:	e45e                	sd	s7,8(sp)
    80001680:	e062                	sd	s8,0(sp)
    80001682:	0880                	addi	s0,sp,80
    80001684:	8b2a                	mv	s6,a0
    80001686:	8c2e                	mv	s8,a1
    80001688:	8a32                	mv	s4,a2
    8000168a:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    8000168c:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    8000168e:	6a85                	lui	s5,0x1
    80001690:	a015                	j	800016b4 <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80001692:	9562                	add	a0,a0,s8
    80001694:	0004861b          	sext.w	a2,s1
    80001698:	85d2                	mv	a1,s4
    8000169a:	41250533          	sub	a0,a0,s2
    8000169e:	fffff097          	auipc	ra,0xfffff
    800016a2:	690080e7          	jalr	1680(ra) # 80000d2e <memmove>

    len -= n;
    800016a6:	409989b3          	sub	s3,s3,s1
    src += n;
    800016aa:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    800016ac:	01590c33          	add	s8,s2,s5
  while(len > 0){
    800016b0:	02098263          	beqz	s3,800016d4 <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    800016b4:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    800016b8:	85ca                	mv	a1,s2
    800016ba:	855a                	mv	a0,s6
    800016bc:	00000097          	auipc	ra,0x0
    800016c0:	9a2080e7          	jalr	-1630(ra) # 8000105e <walkaddr>
    if(pa0 == 0)
    800016c4:	cd01                	beqz	a0,800016dc <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    800016c6:	418904b3          	sub	s1,s2,s8
    800016ca:	94d6                	add	s1,s1,s5
    if(n > len)
    800016cc:	fc99f3e3          	bgeu	s3,s1,80001692 <copyout+0x28>
    800016d0:	84ce                	mv	s1,s3
    800016d2:	b7c1                	j	80001692 <copyout+0x28>
  }
  return 0;
    800016d4:	4501                	li	a0,0
    800016d6:	a021                	j	800016de <copyout+0x74>
    800016d8:	4501                	li	a0,0
}
    800016da:	8082                	ret
      return -1;
    800016dc:	557d                	li	a0,-1
}
    800016de:	60a6                	ld	ra,72(sp)
    800016e0:	6406                	ld	s0,64(sp)
    800016e2:	74e2                	ld	s1,56(sp)
    800016e4:	7942                	ld	s2,48(sp)
    800016e6:	79a2                	ld	s3,40(sp)
    800016e8:	7a02                	ld	s4,32(sp)
    800016ea:	6ae2                	ld	s5,24(sp)
    800016ec:	6b42                	ld	s6,16(sp)
    800016ee:	6ba2                	ld	s7,8(sp)
    800016f0:	6c02                	ld	s8,0(sp)
    800016f2:	6161                	addi	sp,sp,80
    800016f4:	8082                	ret

00000000800016f6 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    800016f6:	caa5                	beqz	a3,80001766 <copyin+0x70>
{
    800016f8:	715d                	addi	sp,sp,-80
    800016fa:	e486                	sd	ra,72(sp)
    800016fc:	e0a2                	sd	s0,64(sp)
    800016fe:	fc26                	sd	s1,56(sp)
    80001700:	f84a                	sd	s2,48(sp)
    80001702:	f44e                	sd	s3,40(sp)
    80001704:	f052                	sd	s4,32(sp)
    80001706:	ec56                	sd	s5,24(sp)
    80001708:	e85a                	sd	s6,16(sp)
    8000170a:	e45e                	sd	s7,8(sp)
    8000170c:	e062                	sd	s8,0(sp)
    8000170e:	0880                	addi	s0,sp,80
    80001710:	8b2a                	mv	s6,a0
    80001712:	8a2e                	mv	s4,a1
    80001714:	8c32                	mv	s8,a2
    80001716:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80001718:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    8000171a:	6a85                	lui	s5,0x1
    8000171c:	a01d                	j	80001742 <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    8000171e:	018505b3          	add	a1,a0,s8
    80001722:	0004861b          	sext.w	a2,s1
    80001726:	412585b3          	sub	a1,a1,s2
    8000172a:	8552                	mv	a0,s4
    8000172c:	fffff097          	auipc	ra,0xfffff
    80001730:	602080e7          	jalr	1538(ra) # 80000d2e <memmove>

    len -= n;
    80001734:	409989b3          	sub	s3,s3,s1
    dst += n;
    80001738:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    8000173a:	01590c33          	add	s8,s2,s5
  while(len > 0){
    8000173e:	02098263          	beqz	s3,80001762 <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    80001742:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80001746:	85ca                	mv	a1,s2
    80001748:	855a                	mv	a0,s6
    8000174a:	00000097          	auipc	ra,0x0
    8000174e:	914080e7          	jalr	-1772(ra) # 8000105e <walkaddr>
    if(pa0 == 0)
    80001752:	cd01                	beqz	a0,8000176a <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80001754:	418904b3          	sub	s1,s2,s8
    80001758:	94d6                	add	s1,s1,s5
    if(n > len)
    8000175a:	fc99f2e3          	bgeu	s3,s1,8000171e <copyin+0x28>
    8000175e:	84ce                	mv	s1,s3
    80001760:	bf7d                	j	8000171e <copyin+0x28>
  }
  return 0;
    80001762:	4501                	li	a0,0
    80001764:	a021                	j	8000176c <copyin+0x76>
    80001766:	4501                	li	a0,0
}
    80001768:	8082                	ret
      return -1;
    8000176a:	557d                	li	a0,-1
}
    8000176c:	60a6                	ld	ra,72(sp)
    8000176e:	6406                	ld	s0,64(sp)
    80001770:	74e2                	ld	s1,56(sp)
    80001772:	7942                	ld	s2,48(sp)
    80001774:	79a2                	ld	s3,40(sp)
    80001776:	7a02                	ld	s4,32(sp)
    80001778:	6ae2                	ld	s5,24(sp)
    8000177a:	6b42                	ld	s6,16(sp)
    8000177c:	6ba2                	ld	s7,8(sp)
    8000177e:	6c02                	ld	s8,0(sp)
    80001780:	6161                	addi	sp,sp,80
    80001782:	8082                	ret

0000000080001784 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80001784:	c6c5                	beqz	a3,8000182c <copyinstr+0xa8>
{
    80001786:	715d                	addi	sp,sp,-80
    80001788:	e486                	sd	ra,72(sp)
    8000178a:	e0a2                	sd	s0,64(sp)
    8000178c:	fc26                	sd	s1,56(sp)
    8000178e:	f84a                	sd	s2,48(sp)
    80001790:	f44e                	sd	s3,40(sp)
    80001792:	f052                	sd	s4,32(sp)
    80001794:	ec56                	sd	s5,24(sp)
    80001796:	e85a                	sd	s6,16(sp)
    80001798:	e45e                	sd	s7,8(sp)
    8000179a:	0880                	addi	s0,sp,80
    8000179c:	8a2a                	mv	s4,a0
    8000179e:	8b2e                	mv	s6,a1
    800017a0:	8bb2                	mv	s7,a2
    800017a2:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    800017a4:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    800017a6:	6985                	lui	s3,0x1
    800017a8:	a035                	j	800017d4 <copyinstr+0x50>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    800017aa:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    800017ae:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    800017b0:	0017b793          	seqz	a5,a5
    800017b4:	40f00533          	neg	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    800017b8:	60a6                	ld	ra,72(sp)
    800017ba:	6406                	ld	s0,64(sp)
    800017bc:	74e2                	ld	s1,56(sp)
    800017be:	7942                	ld	s2,48(sp)
    800017c0:	79a2                	ld	s3,40(sp)
    800017c2:	7a02                	ld	s4,32(sp)
    800017c4:	6ae2                	ld	s5,24(sp)
    800017c6:	6b42                	ld	s6,16(sp)
    800017c8:	6ba2                	ld	s7,8(sp)
    800017ca:	6161                	addi	sp,sp,80
    800017cc:	8082                	ret
    srcva = va0 + PGSIZE;
    800017ce:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    800017d2:	c8a9                	beqz	s1,80001824 <copyinstr+0xa0>
    va0 = PGROUNDDOWN(srcva);
    800017d4:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    800017d8:	85ca                	mv	a1,s2
    800017da:	8552                	mv	a0,s4
    800017dc:	00000097          	auipc	ra,0x0
    800017e0:	882080e7          	jalr	-1918(ra) # 8000105e <walkaddr>
    if(pa0 == 0)
    800017e4:	c131                	beqz	a0,80001828 <copyinstr+0xa4>
    n = PGSIZE - (srcva - va0);
    800017e6:	41790833          	sub	a6,s2,s7
    800017ea:	984e                	add	a6,a6,s3
    if(n > max)
    800017ec:	0104f363          	bgeu	s1,a6,800017f2 <copyinstr+0x6e>
    800017f0:	8826                	mv	a6,s1
    char *p = (char *) (pa0 + (srcva - va0));
    800017f2:	955e                	add	a0,a0,s7
    800017f4:	41250533          	sub	a0,a0,s2
    while(n > 0){
    800017f8:	fc080be3          	beqz	a6,800017ce <copyinstr+0x4a>
    800017fc:	985a                	add	a6,a6,s6
    800017fe:	87da                	mv	a5,s6
      if(*p == '\0'){
    80001800:	41650633          	sub	a2,a0,s6
    80001804:	14fd                	addi	s1,s1,-1
    80001806:	9b26                	add	s6,s6,s1
    80001808:	00f60733          	add	a4,a2,a5
    8000180c:	00074703          	lbu	a4,0(a4)
    80001810:	df49                	beqz	a4,800017aa <copyinstr+0x26>
        *dst = *p;
    80001812:	00e78023          	sb	a4,0(a5)
      --max;
    80001816:	40fb04b3          	sub	s1,s6,a5
      dst++;
    8000181a:	0785                	addi	a5,a5,1
    while(n > 0){
    8000181c:	ff0796e3          	bne	a5,a6,80001808 <copyinstr+0x84>
      dst++;
    80001820:	8b42                	mv	s6,a6
    80001822:	b775                	j	800017ce <copyinstr+0x4a>
    80001824:	4781                	li	a5,0
    80001826:	b769                	j	800017b0 <copyinstr+0x2c>
      return -1;
    80001828:	557d                	li	a0,-1
    8000182a:	b779                	j	800017b8 <copyinstr+0x34>
  int got_null = 0;
    8000182c:	4781                	li	a5,0
  if(got_null){
    8000182e:	0017b793          	seqz	a5,a5
    80001832:	40f00533          	neg	a0,a5
}
    80001836:	8082                	ret

0000000080001838 <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    80001838:	7139                	addi	sp,sp,-64
    8000183a:	fc06                	sd	ra,56(sp)
    8000183c:	f822                	sd	s0,48(sp)
    8000183e:	f426                	sd	s1,40(sp)
    80001840:	f04a                	sd	s2,32(sp)
    80001842:	ec4e                	sd	s3,24(sp)
    80001844:	e852                	sd	s4,16(sp)
    80001846:	e456                	sd	s5,8(sp)
    80001848:	e05a                	sd	s6,0(sp)
    8000184a:	0080                	addi	s0,sp,64
    8000184c:	89aa                	mv	s3,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    8000184e:	0000f497          	auipc	s1,0xf
    80001852:	74248493          	addi	s1,s1,1858 # 80010f90 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80001856:	8b26                	mv	s6,s1
    80001858:	00006a97          	auipc	s5,0x6
    8000185c:	7a8a8a93          	addi	s5,s5,1960 # 80008000 <etext>
    80001860:	04000937          	lui	s2,0x4000
    80001864:	197d                	addi	s2,s2,-1
    80001866:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80001868:	00016a17          	auipc	s4,0x16
    8000186c:	328a0a13          	addi	s4,s4,808 # 80017b90 <tickslock>
    char *pa = kalloc();
    80001870:	fffff097          	auipc	ra,0xfffff
    80001874:	276080e7          	jalr	630(ra) # 80000ae6 <kalloc>
    80001878:	862a                	mv	a2,a0
    if(pa == 0)
    8000187a:	c131                	beqz	a0,800018be <proc_mapstacks+0x86>
    uint64 va = KSTACK((int) (p - proc));
    8000187c:	416485b3          	sub	a1,s1,s6
    80001880:	8591                	srai	a1,a1,0x4
    80001882:	000ab783          	ld	a5,0(s5)
    80001886:	02f585b3          	mul	a1,a1,a5
    8000188a:	2585                	addiw	a1,a1,1
    8000188c:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80001890:	4719                	li	a4,6
    80001892:	6685                	lui	a3,0x1
    80001894:	40b905b3          	sub	a1,s2,a1
    80001898:	854e                	mv	a0,s3
    8000189a:	00000097          	auipc	ra,0x0
    8000189e:	8a6080e7          	jalr	-1882(ra) # 80001140 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    800018a2:	1b048493          	addi	s1,s1,432
    800018a6:	fd4495e3          	bne	s1,s4,80001870 <proc_mapstacks+0x38>
  }
}
    800018aa:	70e2                	ld	ra,56(sp)
    800018ac:	7442                	ld	s0,48(sp)
    800018ae:	74a2                	ld	s1,40(sp)
    800018b0:	7902                	ld	s2,32(sp)
    800018b2:	69e2                	ld	s3,24(sp)
    800018b4:	6a42                	ld	s4,16(sp)
    800018b6:	6aa2                	ld	s5,8(sp)
    800018b8:	6b02                	ld	s6,0(sp)
    800018ba:	6121                	addi	sp,sp,64
    800018bc:	8082                	ret
      panic("kalloc");
    800018be:	00007517          	auipc	a0,0x7
    800018c2:	91a50513          	addi	a0,a0,-1766 # 800081d8 <digits+0x198>
    800018c6:	fffff097          	auipc	ra,0xfffff
    800018ca:	c78080e7          	jalr	-904(ra) # 8000053e <panic>

00000000800018ce <procinit>:

// initialize the proc table.
void
procinit(void)
{
    800018ce:	715d                	addi	sp,sp,-80
    800018d0:	e486                	sd	ra,72(sp)
    800018d2:	e0a2                	sd	s0,64(sp)
    800018d4:	fc26                	sd	s1,56(sp)
    800018d6:	f84a                	sd	s2,48(sp)
    800018d8:	f44e                	sd	s3,40(sp)
    800018da:	f052                	sd	s4,32(sp)
    800018dc:	ec56                	sd	s5,24(sp)
    800018de:	e85a                	sd	s6,16(sp)
    800018e0:	e45e                	sd	s7,8(sp)
    800018e2:	0880                	addi	s0,sp,80
  struct proc *p;

  initlock(&pid_lock, "nextpid");
    800018e4:	00007597          	auipc	a1,0x7
    800018e8:	8fc58593          	addi	a1,a1,-1796 # 800081e0 <digits+0x1a0>
    800018ec:	0000f517          	auipc	a0,0xf
    800018f0:	27450513          	addi	a0,a0,628 # 80010b60 <pid_lock>
    800018f4:	fffff097          	auipc	ra,0xfffff
    800018f8:	252080e7          	jalr	594(ra) # 80000b46 <initlock>
  initlock(&wait_lock, "wait_lock");
    800018fc:	00007597          	auipc	a1,0x7
    80001900:	8ec58593          	addi	a1,a1,-1812 # 800081e8 <digits+0x1a8>
    80001904:	0000f517          	auipc	a0,0xf
    80001908:	27450513          	addi	a0,a0,628 # 80010b78 <wait_lock>
    8000190c:	fffff097          	auipc	ra,0xfffff
    80001910:	23a080e7          	jalr	570(ra) # 80000b46 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001914:	0000f497          	auipc	s1,0xf
    80001918:	67c48493          	addi	s1,s1,1660 # 80010f90 <proc>
      initlock(&p->lock, "proc");
    8000191c:	00007b97          	auipc	s7,0x7
    80001920:	8dcb8b93          	addi	s7,s7,-1828 # 800081f8 <digits+0x1b8>
      p->state = UNUSED;
      p->kstack = KSTACK((int) (p - proc));
    80001924:	8b26                	mv	s6,s1
    80001926:	00006a97          	auipc	s5,0x6
    8000192a:	6daa8a93          	addi	s5,s5,1754 # 80008000 <etext>
    8000192e:	04000937          	lui	s2,0x4000
    80001932:	197d                	addi	s2,s2,-1
    80001934:	0932                	slli	s2,s2,0xc
      p->ps_priority = 0;
      p->accumulator = -1;
    80001936:	5a7d                	li	s4,-1
  for(p = proc; p < &proc[NPROC]; p++) {
    80001938:	00016997          	auipc	s3,0x16
    8000193c:	25898993          	addi	s3,s3,600 # 80017b90 <tickslock>
      initlock(&p->lock, "proc");
    80001940:	85de                	mv	a1,s7
    80001942:	8526                	mv	a0,s1
    80001944:	fffff097          	auipc	ra,0xfffff
    80001948:	202080e7          	jalr	514(ra) # 80000b46 <initlock>
      p->state = UNUSED;
    8000194c:	0004ac23          	sw	zero,24(s1)
      p->kstack = KSTACK((int) (p - proc));
    80001950:	416487b3          	sub	a5,s1,s6
    80001954:	8791                	srai	a5,a5,0x4
    80001956:	000ab703          	ld	a4,0(s5)
    8000195a:	02e787b3          	mul	a5,a5,a4
    8000195e:	2785                	addiw	a5,a5,1
    80001960:	00d7979b          	slliw	a5,a5,0xd
    80001964:	40f907b3          	sub	a5,s2,a5
    80001968:	e4dc                	sd	a5,136(s1)
      p->ps_priority = 0;
    8000196a:	0604a023          	sw	zero,96(s1)
      p->accumulator = -1;
    8000196e:	0544bc23          	sd	s4,88(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80001972:	1b048493          	addi	s1,s1,432
    80001976:	fd3495e3          	bne	s1,s3,80001940 <procinit+0x72>
  }
}
    8000197a:	60a6                	ld	ra,72(sp)
    8000197c:	6406                	ld	s0,64(sp)
    8000197e:	74e2                	ld	s1,56(sp)
    80001980:	7942                	ld	s2,48(sp)
    80001982:	79a2                	ld	s3,40(sp)
    80001984:	7a02                	ld	s4,32(sp)
    80001986:	6ae2                	ld	s5,24(sp)
    80001988:	6b42                	ld	s6,16(sp)
    8000198a:	6ba2                	ld	s7,8(sp)
    8000198c:	6161                	addi	sp,sp,80
    8000198e:	8082                	ret

0000000080001990 <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80001990:	1141                	addi	sp,sp,-16
    80001992:	e422                	sd	s0,8(sp)
    80001994:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80001996:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80001998:	2501                	sext.w	a0,a0
    8000199a:	6422                	ld	s0,8(sp)
    8000199c:	0141                	addi	sp,sp,16
    8000199e:	8082                	ret

00000000800019a0 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    800019a0:	1141                	addi	sp,sp,-16
    800019a2:	e422                	sd	s0,8(sp)
    800019a4:	0800                	addi	s0,sp,16
    800019a6:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    800019a8:	2781                	sext.w	a5,a5
    800019aa:	079e                	slli	a5,a5,0x7
  return c;
}
    800019ac:	0000f517          	auipc	a0,0xf
    800019b0:	1e450513          	addi	a0,a0,484 # 80010b90 <cpus>
    800019b4:	953e                	add	a0,a0,a5
    800019b6:	6422                	ld	s0,8(sp)
    800019b8:	0141                	addi	sp,sp,16
    800019ba:	8082                	ret

00000000800019bc <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    800019bc:	1101                	addi	sp,sp,-32
    800019be:	ec06                	sd	ra,24(sp)
    800019c0:	e822                	sd	s0,16(sp)
    800019c2:	e426                	sd	s1,8(sp)
    800019c4:	1000                	addi	s0,sp,32
  push_off();
    800019c6:	fffff097          	auipc	ra,0xfffff
    800019ca:	1c4080e7          	jalr	452(ra) # 80000b8a <push_off>
    800019ce:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    800019d0:	2781                	sext.w	a5,a5
    800019d2:	079e                	slli	a5,a5,0x7
    800019d4:	0000f717          	auipc	a4,0xf
    800019d8:	18c70713          	addi	a4,a4,396 # 80010b60 <pid_lock>
    800019dc:	97ba                	add	a5,a5,a4
    800019de:	7b84                	ld	s1,48(a5)
  pop_off();
    800019e0:	fffff097          	auipc	ra,0xfffff
    800019e4:	24a080e7          	jalr	586(ra) # 80000c2a <pop_off>
  return p;
}
    800019e8:	8526                	mv	a0,s1
    800019ea:	60e2                	ld	ra,24(sp)
    800019ec:	6442                	ld	s0,16(sp)
    800019ee:	64a2                	ld	s1,8(sp)
    800019f0:	6105                	addi	sp,sp,32
    800019f2:	8082                	ret

00000000800019f4 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    800019f4:	1141                	addi	sp,sp,-16
    800019f6:	e406                	sd	ra,8(sp)
    800019f8:	e022                	sd	s0,0(sp)
    800019fa:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    800019fc:	00000097          	auipc	ra,0x0
    80001a00:	fc0080e7          	jalr	-64(ra) # 800019bc <myproc>
    80001a04:	fffff097          	auipc	ra,0xfffff
    80001a08:	286080e7          	jalr	646(ra) # 80000c8a <release>

  if (first) {
    80001a0c:	00007797          	auipc	a5,0x7
    80001a10:	e447a783          	lw	a5,-444(a5) # 80008850 <first.1>
    80001a14:	eb89                	bnez	a5,80001a26 <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    80001a16:	00001097          	auipc	ra,0x1
    80001a1a:	d88080e7          	jalr	-632(ra) # 8000279e <usertrapret>
}
    80001a1e:	60a2                	ld	ra,8(sp)
    80001a20:	6402                	ld	s0,0(sp)
    80001a22:	0141                	addi	sp,sp,16
    80001a24:	8082                	ret
    first = 0;
    80001a26:	00007797          	auipc	a5,0x7
    80001a2a:	e207a523          	sw	zero,-470(a5) # 80008850 <first.1>
    fsinit(ROOTDEV);
    80001a2e:	4505                	li	a0,1
    80001a30:	00002097          	auipc	ra,0x2
    80001a34:	b08080e7          	jalr	-1272(ra) # 80003538 <fsinit>
    80001a38:	bff9                	j	80001a16 <forkret+0x22>

0000000080001a3a <allocpid>:
{
    80001a3a:	1101                	addi	sp,sp,-32
    80001a3c:	ec06                	sd	ra,24(sp)
    80001a3e:	e822                	sd	s0,16(sp)
    80001a40:	e426                	sd	s1,8(sp)
    80001a42:	e04a                	sd	s2,0(sp)
    80001a44:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80001a46:	0000f917          	auipc	s2,0xf
    80001a4a:	11a90913          	addi	s2,s2,282 # 80010b60 <pid_lock>
    80001a4e:	854a                	mv	a0,s2
    80001a50:	fffff097          	auipc	ra,0xfffff
    80001a54:	186080e7          	jalr	390(ra) # 80000bd6 <acquire>
  pid = nextpid;
    80001a58:	00007797          	auipc	a5,0x7
    80001a5c:	dfc78793          	addi	a5,a5,-516 # 80008854 <nextpid>
    80001a60:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80001a62:	0014871b          	addiw	a4,s1,1
    80001a66:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80001a68:	854a                	mv	a0,s2
    80001a6a:	fffff097          	auipc	ra,0xfffff
    80001a6e:	220080e7          	jalr	544(ra) # 80000c8a <release>
}
    80001a72:	8526                	mv	a0,s1
    80001a74:	60e2                	ld	ra,24(sp)
    80001a76:	6442                	ld	s0,16(sp)
    80001a78:	64a2                	ld	s1,8(sp)
    80001a7a:	6902                	ld	s2,0(sp)
    80001a7c:	6105                	addi	sp,sp,32
    80001a7e:	8082                	ret

0000000080001a80 <proc_pagetable>:
{
    80001a80:	1101                	addi	sp,sp,-32
    80001a82:	ec06                	sd	ra,24(sp)
    80001a84:	e822                	sd	s0,16(sp)
    80001a86:	e426                	sd	s1,8(sp)
    80001a88:	e04a                	sd	s2,0(sp)
    80001a8a:	1000                	addi	s0,sp,32
    80001a8c:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80001a8e:	00000097          	auipc	ra,0x0
    80001a92:	89c080e7          	jalr	-1892(ra) # 8000132a <uvmcreate>
    80001a96:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80001a98:	c121                	beqz	a0,80001ad8 <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80001a9a:	4729                	li	a4,10
    80001a9c:	00005697          	auipc	a3,0x5
    80001aa0:	56468693          	addi	a3,a3,1380 # 80007000 <_trampoline>
    80001aa4:	6605                	lui	a2,0x1
    80001aa6:	040005b7          	lui	a1,0x4000
    80001aaa:	15fd                	addi	a1,a1,-1
    80001aac:	05b2                	slli	a1,a1,0xc
    80001aae:	fffff097          	auipc	ra,0xfffff
    80001ab2:	5f2080e7          	jalr	1522(ra) # 800010a0 <mappages>
    80001ab6:	02054863          	bltz	a0,80001ae6 <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80001aba:	4719                	li	a4,6
    80001abc:	0a093683          	ld	a3,160(s2)
    80001ac0:	6605                	lui	a2,0x1
    80001ac2:	020005b7          	lui	a1,0x2000
    80001ac6:	15fd                	addi	a1,a1,-1
    80001ac8:	05b6                	slli	a1,a1,0xd
    80001aca:	8526                	mv	a0,s1
    80001acc:	fffff097          	auipc	ra,0xfffff
    80001ad0:	5d4080e7          	jalr	1492(ra) # 800010a0 <mappages>
    80001ad4:	02054163          	bltz	a0,80001af6 <proc_pagetable+0x76>
}
    80001ad8:	8526                	mv	a0,s1
    80001ada:	60e2                	ld	ra,24(sp)
    80001adc:	6442                	ld	s0,16(sp)
    80001ade:	64a2                	ld	s1,8(sp)
    80001ae0:	6902                	ld	s2,0(sp)
    80001ae2:	6105                	addi	sp,sp,32
    80001ae4:	8082                	ret
    uvmfree(pagetable, 0);
    80001ae6:	4581                	li	a1,0
    80001ae8:	8526                	mv	a0,s1
    80001aea:	00000097          	auipc	ra,0x0
    80001aee:	a44080e7          	jalr	-1468(ra) # 8000152e <uvmfree>
    return 0;
    80001af2:	4481                	li	s1,0
    80001af4:	b7d5                	j	80001ad8 <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001af6:	4681                	li	a3,0
    80001af8:	4605                	li	a2,1
    80001afa:	040005b7          	lui	a1,0x4000
    80001afe:	15fd                	addi	a1,a1,-1
    80001b00:	05b2                	slli	a1,a1,0xc
    80001b02:	8526                	mv	a0,s1
    80001b04:	fffff097          	auipc	ra,0xfffff
    80001b08:	762080e7          	jalr	1890(ra) # 80001266 <uvmunmap>
    uvmfree(pagetable, 0);
    80001b0c:	4581                	li	a1,0
    80001b0e:	8526                	mv	a0,s1
    80001b10:	00000097          	auipc	ra,0x0
    80001b14:	a1e080e7          	jalr	-1506(ra) # 8000152e <uvmfree>
    return 0;
    80001b18:	4481                	li	s1,0
    80001b1a:	bf7d                	j	80001ad8 <proc_pagetable+0x58>

0000000080001b1c <proc_freepagetable>:
{
    80001b1c:	1101                	addi	sp,sp,-32
    80001b1e:	ec06                	sd	ra,24(sp)
    80001b20:	e822                	sd	s0,16(sp)
    80001b22:	e426                	sd	s1,8(sp)
    80001b24:	e04a                	sd	s2,0(sp)
    80001b26:	1000                	addi	s0,sp,32
    80001b28:	84aa                	mv	s1,a0
    80001b2a:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001b2c:	4681                	li	a3,0
    80001b2e:	4605                	li	a2,1
    80001b30:	040005b7          	lui	a1,0x4000
    80001b34:	15fd                	addi	a1,a1,-1
    80001b36:	05b2                	slli	a1,a1,0xc
    80001b38:	fffff097          	auipc	ra,0xfffff
    80001b3c:	72e080e7          	jalr	1838(ra) # 80001266 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80001b40:	4681                	li	a3,0
    80001b42:	4605                	li	a2,1
    80001b44:	020005b7          	lui	a1,0x2000
    80001b48:	15fd                	addi	a1,a1,-1
    80001b4a:	05b6                	slli	a1,a1,0xd
    80001b4c:	8526                	mv	a0,s1
    80001b4e:	fffff097          	auipc	ra,0xfffff
    80001b52:	718080e7          	jalr	1816(ra) # 80001266 <uvmunmap>
  uvmfree(pagetable, sz);
    80001b56:	85ca                	mv	a1,s2
    80001b58:	8526                	mv	a0,s1
    80001b5a:	00000097          	auipc	ra,0x0
    80001b5e:	9d4080e7          	jalr	-1580(ra) # 8000152e <uvmfree>
}
    80001b62:	60e2                	ld	ra,24(sp)
    80001b64:	6442                	ld	s0,16(sp)
    80001b66:	64a2                	ld	s1,8(sp)
    80001b68:	6902                	ld	s2,0(sp)
    80001b6a:	6105                	addi	sp,sp,32
    80001b6c:	8082                	ret

0000000080001b6e <freeproc>:
{
    80001b6e:	1101                	addi	sp,sp,-32
    80001b70:	ec06                	sd	ra,24(sp)
    80001b72:	e822                	sd	s0,16(sp)
    80001b74:	e426                	sd	s1,8(sp)
    80001b76:	1000                	addi	s0,sp,32
    80001b78:	84aa                	mv	s1,a0
  if(p->trapframe)
    80001b7a:	7148                	ld	a0,160(a0)
    80001b7c:	c509                	beqz	a0,80001b86 <freeproc+0x18>
    kfree((void*)p->trapframe);
    80001b7e:	fffff097          	auipc	ra,0xfffff
    80001b82:	e6c080e7          	jalr	-404(ra) # 800009ea <kfree>
  p->trapframe = 0;
    80001b86:	0a04b023          	sd	zero,160(s1)
  if(p->pagetable)
    80001b8a:	6cc8                	ld	a0,152(s1)
    80001b8c:	c511                	beqz	a0,80001b98 <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    80001b8e:	68cc                	ld	a1,144(s1)
    80001b90:	00000097          	auipc	ra,0x0
    80001b94:	f8c080e7          	jalr	-116(ra) # 80001b1c <proc_freepagetable>
  p->pagetable = 0;
    80001b98:	0804bc23          	sd	zero,152(s1)
  p->sz = 0;
    80001b9c:	0804b823          	sd	zero,144(s1)
  p->pid = 0;
    80001ba0:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80001ba4:	0804b023          	sd	zero,128(s1)
  p->name[0] = 0;
    80001ba8:	1a048023          	sb	zero,416(s1)
  p->chan = 0;
    80001bac:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80001bb0:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80001bb4:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80001bb8:	0004ac23          	sw	zero,24(s1)
  p->accumulator = -1;
    80001bbc:	57fd                	li	a5,-1
    80001bbe:	ecbc                	sd	a5,88(s1)
  p->ps_priority = 0;
    80001bc0:	0604a023          	sw	zero,96(s1)
}
    80001bc4:	60e2                	ld	ra,24(sp)
    80001bc6:	6442                	ld	s0,16(sp)
    80001bc8:	64a2                	ld	s1,8(sp)
    80001bca:	6105                	addi	sp,sp,32
    80001bcc:	8082                	ret

0000000080001bce <allocproc>:
{
    80001bce:	1101                	addi	sp,sp,-32
    80001bd0:	ec06                	sd	ra,24(sp)
    80001bd2:	e822                	sd	s0,16(sp)
    80001bd4:	e426                	sd	s1,8(sp)
    80001bd6:	e04a                	sd	s2,0(sp)
    80001bd8:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80001bda:	0000f497          	auipc	s1,0xf
    80001bde:	3b648493          	addi	s1,s1,950 # 80010f90 <proc>
    80001be2:	00016917          	auipc	s2,0x16
    80001be6:	fae90913          	addi	s2,s2,-82 # 80017b90 <tickslock>
    acquire(&p->lock);
    80001bea:	8526                	mv	a0,s1
    80001bec:	fffff097          	auipc	ra,0xfffff
    80001bf0:	fea080e7          	jalr	-22(ra) # 80000bd6 <acquire>
    if(p->state == UNUSED) {
    80001bf4:	4c9c                	lw	a5,24(s1)
    80001bf6:	cf81                	beqz	a5,80001c0e <allocproc+0x40>
      release(&p->lock);
    80001bf8:	8526                	mv	a0,s1
    80001bfa:	fffff097          	auipc	ra,0xfffff
    80001bfe:	090080e7          	jalr	144(ra) # 80000c8a <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001c02:	1b048493          	addi	s1,s1,432
    80001c06:	ff2492e3          	bne	s1,s2,80001bea <allocproc+0x1c>
  return 0;
    80001c0a:	4481                	li	s1,0
    80001c0c:	a889                	j	80001c5e <allocproc+0x90>
  p->pid = allocpid();
    80001c0e:	00000097          	auipc	ra,0x0
    80001c12:	e2c080e7          	jalr	-468(ra) # 80001a3a <allocpid>
    80001c16:	d888                	sw	a0,48(s1)
  p->state = USED;
    80001c18:	4785                	li	a5,1
    80001c1a:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80001c1c:	fffff097          	auipc	ra,0xfffff
    80001c20:	eca080e7          	jalr	-310(ra) # 80000ae6 <kalloc>
    80001c24:	892a                	mv	s2,a0
    80001c26:	f0c8                	sd	a0,160(s1)
    80001c28:	c131                	beqz	a0,80001c6c <allocproc+0x9e>
  p->pagetable = proc_pagetable(p);
    80001c2a:	8526                	mv	a0,s1
    80001c2c:	00000097          	auipc	ra,0x0
    80001c30:	e54080e7          	jalr	-428(ra) # 80001a80 <proc_pagetable>
    80001c34:	892a                	mv	s2,a0
    80001c36:	ecc8                	sd	a0,152(s1)
  if(p->pagetable == 0){
    80001c38:	c531                	beqz	a0,80001c84 <allocproc+0xb6>
  memset(&p->context, 0, sizeof(p->context));
    80001c3a:	07000613          	li	a2,112
    80001c3e:	4581                	li	a1,0
    80001c40:	0a848513          	addi	a0,s1,168
    80001c44:	fffff097          	auipc	ra,0xfffff
    80001c48:	08e080e7          	jalr	142(ra) # 80000cd2 <memset>
  p->context.ra = (uint64)forkret;
    80001c4c:	00000797          	auipc	a5,0x0
    80001c50:	da878793          	addi	a5,a5,-600 # 800019f4 <forkret>
    80001c54:	f4dc                	sd	a5,168(s1)
  p->context.sp = p->kstack + PGSIZE;
    80001c56:	64dc                	ld	a5,136(s1)
    80001c58:	6705                	lui	a4,0x1
    80001c5a:	97ba                	add	a5,a5,a4
    80001c5c:	f8dc                	sd	a5,176(s1)
}
    80001c5e:	8526                	mv	a0,s1
    80001c60:	60e2                	ld	ra,24(sp)
    80001c62:	6442                	ld	s0,16(sp)
    80001c64:	64a2                	ld	s1,8(sp)
    80001c66:	6902                	ld	s2,0(sp)
    80001c68:	6105                	addi	sp,sp,32
    80001c6a:	8082                	ret
    freeproc(p);
    80001c6c:	8526                	mv	a0,s1
    80001c6e:	00000097          	auipc	ra,0x0
    80001c72:	f00080e7          	jalr	-256(ra) # 80001b6e <freeproc>
    release(&p->lock);
    80001c76:	8526                	mv	a0,s1
    80001c78:	fffff097          	auipc	ra,0xfffff
    80001c7c:	012080e7          	jalr	18(ra) # 80000c8a <release>
    return 0;
    80001c80:	84ca                	mv	s1,s2
    80001c82:	bff1                	j	80001c5e <allocproc+0x90>
    freeproc(p);
    80001c84:	8526                	mv	a0,s1
    80001c86:	00000097          	auipc	ra,0x0
    80001c8a:	ee8080e7          	jalr	-280(ra) # 80001b6e <freeproc>
    release(&p->lock);
    80001c8e:	8526                	mv	a0,s1
    80001c90:	fffff097          	auipc	ra,0xfffff
    80001c94:	ffa080e7          	jalr	-6(ra) # 80000c8a <release>
    return 0;
    80001c98:	84ca                	mv	s1,s2
    80001c9a:	b7d1                	j	80001c5e <allocproc+0x90>

0000000080001c9c <userinit>:
{
    80001c9c:	1101                	addi	sp,sp,-32
    80001c9e:	ec06                	sd	ra,24(sp)
    80001ca0:	e822                	sd	s0,16(sp)
    80001ca2:	e426                	sd	s1,8(sp)
    80001ca4:	1000                	addi	s0,sp,32
  p = allocproc();
    80001ca6:	00000097          	auipc	ra,0x0
    80001caa:	f28080e7          	jalr	-216(ra) # 80001bce <allocproc>
    80001cae:	84aa                	mv	s1,a0
  initproc = p;
    80001cb0:	00007797          	auipc	a5,0x7
    80001cb4:	c2a7bc23          	sd	a0,-968(a5) # 800088e8 <initproc>
  uvmfirst(p->pagetable, initcode, sizeof(initcode));
    80001cb8:	03400613          	li	a2,52
    80001cbc:	00007597          	auipc	a1,0x7
    80001cc0:	ba458593          	addi	a1,a1,-1116 # 80008860 <initcode>
    80001cc4:	6d48                	ld	a0,152(a0)
    80001cc6:	fffff097          	auipc	ra,0xfffff
    80001cca:	692080e7          	jalr	1682(ra) # 80001358 <uvmfirst>
  p->sz = PGSIZE;
    80001cce:	6785                	lui	a5,0x1
    80001cd0:	e8dc                	sd	a5,144(s1)
  p->trapframe->epc = 0;      // user program counter
    80001cd2:	70d8                	ld	a4,160(s1)
    80001cd4:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80001cd8:	70d8                	ld	a4,160(s1)
    80001cda:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001cdc:	4641                	li	a2,16
    80001cde:	00006597          	auipc	a1,0x6
    80001ce2:	52258593          	addi	a1,a1,1314 # 80008200 <digits+0x1c0>
    80001ce6:	1a048513          	addi	a0,s1,416
    80001cea:	fffff097          	auipc	ra,0xfffff
    80001cee:	132080e7          	jalr	306(ra) # 80000e1c <safestrcpy>
  p->cwd = namei("/");
    80001cf2:	00006517          	auipc	a0,0x6
    80001cf6:	51e50513          	addi	a0,a0,1310 # 80008210 <digits+0x1d0>
    80001cfa:	00002097          	auipc	ra,0x2
    80001cfe:	260080e7          	jalr	608(ra) # 80003f5a <namei>
    80001d02:	18a4bc23          	sd	a0,408(s1)
  p->state = RUNNABLE;
    80001d06:	478d                	li	a5,3
    80001d08:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    80001d0a:	8526                	mv	a0,s1
    80001d0c:	fffff097          	auipc	ra,0xfffff
    80001d10:	f7e080e7          	jalr	-130(ra) # 80000c8a <release>
}
    80001d14:	60e2                	ld	ra,24(sp)
    80001d16:	6442                	ld	s0,16(sp)
    80001d18:	64a2                	ld	s1,8(sp)
    80001d1a:	6105                	addi	sp,sp,32
    80001d1c:	8082                	ret

0000000080001d1e <growproc>:
{
    80001d1e:	1101                	addi	sp,sp,-32
    80001d20:	ec06                	sd	ra,24(sp)
    80001d22:	e822                	sd	s0,16(sp)
    80001d24:	e426                	sd	s1,8(sp)
    80001d26:	e04a                	sd	s2,0(sp)
    80001d28:	1000                	addi	s0,sp,32
    80001d2a:	892a                	mv	s2,a0
  struct proc *p = myproc();
    80001d2c:	00000097          	auipc	ra,0x0
    80001d30:	c90080e7          	jalr	-880(ra) # 800019bc <myproc>
    80001d34:	84aa                	mv	s1,a0
  sz = p->sz;
    80001d36:	694c                	ld	a1,144(a0)
  if(n > 0){
    80001d38:	01204c63          	bgtz	s2,80001d50 <growproc+0x32>
  } else if(n < 0){
    80001d3c:	02094663          	bltz	s2,80001d68 <growproc+0x4a>
  p->sz = sz;
    80001d40:	e8cc                	sd	a1,144(s1)
  return 0;
    80001d42:	4501                	li	a0,0
}
    80001d44:	60e2                	ld	ra,24(sp)
    80001d46:	6442                	ld	s0,16(sp)
    80001d48:	64a2                	ld	s1,8(sp)
    80001d4a:	6902                	ld	s2,0(sp)
    80001d4c:	6105                	addi	sp,sp,32
    80001d4e:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    80001d50:	4691                	li	a3,4
    80001d52:	00b90633          	add	a2,s2,a1
    80001d56:	6d48                	ld	a0,152(a0)
    80001d58:	fffff097          	auipc	ra,0xfffff
    80001d5c:	6ba080e7          	jalr	1722(ra) # 80001412 <uvmalloc>
    80001d60:	85aa                	mv	a1,a0
    80001d62:	fd79                	bnez	a0,80001d40 <growproc+0x22>
      return -1;
    80001d64:	557d                	li	a0,-1
    80001d66:	bff9                	j	80001d44 <growproc+0x26>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80001d68:	00b90633          	add	a2,s2,a1
    80001d6c:	6d48                	ld	a0,152(a0)
    80001d6e:	fffff097          	auipc	ra,0xfffff
    80001d72:	65c080e7          	jalr	1628(ra) # 800013ca <uvmdealloc>
    80001d76:	85aa                	mv	a1,a0
    80001d78:	b7e1                	j	80001d40 <growproc+0x22>

0000000080001d7a <set_accumulator>:
void set_accumulator(struct proc *np) {
    80001d7a:	1141                	addi	sp,sp,-16
    80001d7c:	e422                	sd	s0,8(sp)
    80001d7e:	0800                	addi	s0,sp,16
    np->accumulator = INT_MAX;
    80001d80:	800007b7          	lui	a5,0x80000
    80001d84:	fff7c793          	not	a5,a5
    80001d88:	ed3c                	sd	a5,88(a0)
    for(j = proc; j < &proc[NPROC]; j++) {
    80001d8a:	0000f797          	auipc	a5,0xf
    80001d8e:	20678793          	addi	a5,a5,518 # 80010f90 <proc>
      if (((j->state == RUNNABLE) | (j->state == RUNNING)) && (j->accumulator < np->accumulator) )
    80001d92:	4605                	li	a2,1
    for(j = proc; j < &proc[NPROC]; j++) {
    80001d94:	00016697          	auipc	a3,0x16
    80001d98:	dfc68693          	addi	a3,a3,-516 # 80017b90 <tickslock>
    80001d9c:	a029                	j	80001da6 <set_accumulator+0x2c>
    80001d9e:	1b078793          	addi	a5,a5,432
    80001da2:	00d78c63          	beq	a5,a3,80001dba <set_accumulator+0x40>
      if (((j->state == RUNNABLE) | (j->state == RUNNING)) && (j->accumulator < np->accumulator) )
    80001da6:	4f98                	lw	a4,24(a5)
    80001da8:	3775                	addiw	a4,a4,-3
    80001daa:	fee66ae3          	bltu	a2,a4,80001d9e <set_accumulator+0x24>
    80001dae:	6fb8                	ld	a4,88(a5)
    80001db0:	6d2c                	ld	a1,88(a0)
    80001db2:	feb756e3          	bge	a4,a1,80001d9e <set_accumulator+0x24>
        np->accumulator = j->accumulator;
    80001db6:	ed38                	sd	a4,88(a0)
    80001db8:	b7dd                	j	80001d9e <set_accumulator+0x24>
    if (np->accumulator == INT_MAX)
    80001dba:	6d38                	ld	a4,88(a0)
    80001dbc:	800007b7          	lui	a5,0x80000
    80001dc0:	fff7c793          	not	a5,a5
    80001dc4:	00f70563          	beq	a4,a5,80001dce <set_accumulator+0x54>
}
    80001dc8:	6422                	ld	s0,8(sp)
    80001dca:	0141                	addi	sp,sp,16
    80001dcc:	8082                	ret
      np->accumulator = 0;
    80001dce:	04053c23          	sd	zero,88(a0)
}
    80001dd2:	bfdd                	j	80001dc8 <set_accumulator+0x4e>

0000000080001dd4 <fork>:
{
    80001dd4:	7139                	addi	sp,sp,-64
    80001dd6:	fc06                	sd	ra,56(sp)
    80001dd8:	f822                	sd	s0,48(sp)
    80001dda:	f426                	sd	s1,40(sp)
    80001ddc:	f04a                	sd	s2,32(sp)
    80001dde:	ec4e                	sd	s3,24(sp)
    80001de0:	e852                	sd	s4,16(sp)
    80001de2:	e456                	sd	s5,8(sp)
    80001de4:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    80001de6:	00000097          	auipc	ra,0x0
    80001dea:	bd6080e7          	jalr	-1066(ra) # 800019bc <myproc>
    80001dee:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    80001df0:	00000097          	auipc	ra,0x0
    80001df4:	dde080e7          	jalr	-546(ra) # 80001bce <allocproc>
    80001df8:	12050e63          	beqz	a0,80001f34 <fork+0x160>
    80001dfc:	89aa                	mv	s3,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80001dfe:	090ab603          	ld	a2,144(s5)
    80001e02:	6d4c                	ld	a1,152(a0)
    80001e04:	098ab503          	ld	a0,152(s5)
    80001e08:	fffff097          	auipc	ra,0xfffff
    80001e0c:	75e080e7          	jalr	1886(ra) # 80001566 <uvmcopy>
    80001e10:	04054863          	bltz	a0,80001e60 <fork+0x8c>
  np->sz = p->sz;
    80001e14:	090ab783          	ld	a5,144(s5)
    80001e18:	08f9b823          	sd	a5,144(s3)
  *(np->trapframe) = *(p->trapframe);
    80001e1c:	0a0ab683          	ld	a3,160(s5)
    80001e20:	87b6                	mv	a5,a3
    80001e22:	0a09b703          	ld	a4,160(s3)
    80001e26:	12068693          	addi	a3,a3,288
    80001e2a:	0007b803          	ld	a6,0(a5) # ffffffff80000000 <end+0xfffffffefffdd090>
    80001e2e:	6788                	ld	a0,8(a5)
    80001e30:	6b8c                	ld	a1,16(a5)
    80001e32:	6f90                	ld	a2,24(a5)
    80001e34:	01073023          	sd	a6,0(a4)
    80001e38:	e708                	sd	a0,8(a4)
    80001e3a:	eb0c                	sd	a1,16(a4)
    80001e3c:	ef10                	sd	a2,24(a4)
    80001e3e:	02078793          	addi	a5,a5,32
    80001e42:	02070713          	addi	a4,a4,32
    80001e46:	fed792e3          	bne	a5,a3,80001e2a <fork+0x56>
  np->trapframe->a0 = 0;
    80001e4a:	0a09b783          	ld	a5,160(s3)
    80001e4e:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    80001e52:	118a8493          	addi	s1,s5,280
    80001e56:	11898913          	addi	s2,s3,280
    80001e5a:	198a8a13          	addi	s4,s5,408
    80001e5e:	a00d                	j	80001e80 <fork+0xac>
    freeproc(np);
    80001e60:	854e                	mv	a0,s3
    80001e62:	00000097          	auipc	ra,0x0
    80001e66:	d0c080e7          	jalr	-756(ra) # 80001b6e <freeproc>
    release(&np->lock);
    80001e6a:	854e                	mv	a0,s3
    80001e6c:	fffff097          	auipc	ra,0xfffff
    80001e70:	e1e080e7          	jalr	-482(ra) # 80000c8a <release>
    return -1;
    80001e74:	597d                	li	s2,-1
    80001e76:	a06d                	j	80001f20 <fork+0x14c>
  for(i = 0; i < NOFILE; i++)
    80001e78:	04a1                	addi	s1,s1,8
    80001e7a:	0921                	addi	s2,s2,8
    80001e7c:	01448b63          	beq	s1,s4,80001e92 <fork+0xbe>
    if(p->ofile[i])
    80001e80:	6088                	ld	a0,0(s1)
    80001e82:	d97d                	beqz	a0,80001e78 <fork+0xa4>
      np->ofile[i] = filedup(p->ofile[i]);
    80001e84:	00002097          	auipc	ra,0x2
    80001e88:	76c080e7          	jalr	1900(ra) # 800045f0 <filedup>
    80001e8c:	00a93023          	sd	a0,0(s2)
    80001e90:	b7e5                	j	80001e78 <fork+0xa4>
  np->cwd = idup(p->cwd);
    80001e92:	198ab503          	ld	a0,408(s5)
    80001e96:	00002097          	auipc	ra,0x2
    80001e9a:	8e0080e7          	jalr	-1824(ra) # 80003776 <idup>
    80001e9e:	18a9bc23          	sd	a0,408(s3)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001ea2:	4641                	li	a2,16
    80001ea4:	1a0a8593          	addi	a1,s5,416
    80001ea8:	1a098513          	addi	a0,s3,416
    80001eac:	fffff097          	auipc	ra,0xfffff
    80001eb0:	f70080e7          	jalr	-144(ra) # 80000e1c <safestrcpy>
  pid = np->pid;
    80001eb4:	0309a903          	lw	s2,48(s3)
  release(&np->lock);
    80001eb8:	854e                	mv	a0,s3
    80001eba:	fffff097          	auipc	ra,0xfffff
    80001ebe:	dd0080e7          	jalr	-560(ra) # 80000c8a <release>
  acquire(&wait_lock);
    80001ec2:	0000f497          	auipc	s1,0xf
    80001ec6:	cb648493          	addi	s1,s1,-842 # 80010b78 <wait_lock>
    80001eca:	8526                	mv	a0,s1
    80001ecc:	fffff097          	auipc	ra,0xfffff
    80001ed0:	d0a080e7          	jalr	-758(ra) # 80000bd6 <acquire>
  np->parent = p;
    80001ed4:	0959b023          	sd	s5,128(s3)
  release(&wait_lock);
    80001ed8:	8526                	mv	a0,s1
    80001eda:	fffff097          	auipc	ra,0xfffff
    80001ede:	db0080e7          	jalr	-592(ra) # 80000c8a <release>
  acquire(&np->lock);
    80001ee2:	854e                	mv	a0,s3
    80001ee4:	fffff097          	auipc	ra,0xfffff
    80001ee8:	cf2080e7          	jalr	-782(ra) # 80000bd6 <acquire>
  np->ps_priority = 5;
    80001eec:	4795                	li	a5,5
    80001eee:	06f9a023          	sw	a5,96(s3)
  set_accumulator(np);
    80001ef2:	854e                	mv	a0,s3
    80001ef4:	00000097          	auipc	ra,0x0
    80001ef8:	e86080e7          	jalr	-378(ra) # 80001d7a <set_accumulator>
  np->retime = 0;
    80001efc:	0609bc23          	sd	zero,120(s3)
  np->rtime = 0;
    80001f00:	0609b423          	sd	zero,104(s3)
  np->stime = 0;
    80001f04:	0609b823          	sd	zero,112(s3)
  np -> cfs_priority = p->cfs_priority;
    80001f08:	064aa783          	lw	a5,100(s5)
    80001f0c:	06f9a223          	sw	a5,100(s3)
  np->state = RUNNABLE;
    80001f10:	478d                	li	a5,3
    80001f12:	00f9ac23          	sw	a5,24(s3)
  release(&np->lock);
    80001f16:	854e                	mv	a0,s3
    80001f18:	fffff097          	auipc	ra,0xfffff
    80001f1c:	d72080e7          	jalr	-654(ra) # 80000c8a <release>
}
    80001f20:	854a                	mv	a0,s2
    80001f22:	70e2                	ld	ra,56(sp)
    80001f24:	7442                	ld	s0,48(sp)
    80001f26:	74a2                	ld	s1,40(sp)
    80001f28:	7902                	ld	s2,32(sp)
    80001f2a:	69e2                	ld	s3,24(sp)
    80001f2c:	6a42                	ld	s4,16(sp)
    80001f2e:	6aa2                	ld	s5,8(sp)
    80001f30:	6121                	addi	sp,sp,64
    80001f32:	8082                	ret
    return -1;
    80001f34:	597d                	li	s2,-1
    80001f36:	b7ed                	j	80001f20 <fork+0x14c>

0000000080001f38 <scheduler>:
{
    80001f38:	715d                	addi	sp,sp,-80
    80001f3a:	e486                	sd	ra,72(sp)
    80001f3c:	e0a2                	sd	s0,64(sp)
    80001f3e:	fc26                	sd	s1,56(sp)
    80001f40:	f84a                	sd	s2,48(sp)
    80001f42:	f44e                	sd	s3,40(sp)
    80001f44:	f052                	sd	s4,32(sp)
    80001f46:	ec56                	sd	s5,24(sp)
    80001f48:	e85a                	sd	s6,16(sp)
    80001f4a:	e45e                	sd	s7,8(sp)
    80001f4c:	e062                	sd	s8,0(sp)
    80001f4e:	0880                	addi	s0,sp,80
    80001f50:	8792                	mv	a5,tp
  int id = r_tp();
    80001f52:	2781                	sext.w	a5,a5
      c->proc = 0;
    80001f54:	00779c13          	slli	s8,a5,0x7
    80001f58:	0000f717          	auipc	a4,0xf
    80001f5c:	c0870713          	addi	a4,a4,-1016 # 80010b60 <pid_lock>
    80001f60:	9762                	add	a4,a4,s8
    80001f62:	02073823          	sd	zero,48(a4)
          swtch(&c->context, &toRun->context);
    80001f66:	0000f717          	auipc	a4,0xf
    80001f6a:	c3270713          	addi	a4,a4,-974 # 80010b98 <cpus+0x8>
    80001f6e:	9c3a                	add	s8,s8,a4
        struct proc *toRun = NULL;
    80001f70:	4b81                	li	s7,0
        int minAcc = INT_MAX;
    80001f72:	80000b37          	lui	s6,0x80000
    80001f76:	fffb4b13          	not	s6,s6
          if (((p->state == RUNNABLE) |(p->state == RUNNING)) && (p->accumulator < minAcc)){
    80001f7a:	4905                	li	s2,1
        for(p = proc; p < &proc[NPROC]; p++) {
    80001f7c:	00016997          	auipc	s3,0x16
    80001f80:	c1498993          	addi	s3,s3,-1004 # 80017b90 <tickslock>
          c->proc = toRun;
    80001f84:	079e                	slli	a5,a5,0x7
    80001f86:	0000fa97          	auipc	s5,0xf
    80001f8a:	bdaa8a93          	addi	s5,s5,-1062 # 80010b60 <pid_lock>
    80001f8e:	9abe                	add	s5,s5,a5
    80001f90:	a095                	j	80001ff4 <scheduler+0xbc>
        for(p = proc; p < &proc[NPROC]; p++) {
    80001f92:	8a36                	mv	s4,a3
    80001f94:	a80d                	j	80001fc6 <scheduler+0x8e>
    80001f96:	0334f663          	bgeu	s1,s3,80001fc2 <scheduler+0x8a>
    80001f9a:	1b078793          	addi	a5,a5,432
    80001f9e:	e5078693          	addi	a3,a5,-432
          if (((p->state == RUNNABLE) |(p->state == RUNNING)) && (p->accumulator < minAcc)){
    80001fa2:	84be                	mv	s1,a5
    80001fa4:	e687a703          	lw	a4,-408(a5)
    80001fa8:	3775                	addiw	a4,a4,-3
    80001faa:	fee966e3          	bltu	s2,a4,80001f96 <scheduler+0x5e>
    80001fae:	ea87b703          	ld	a4,-344(a5)
    80001fb2:	fec752e3          	bge	a4,a2,80001f96 <scheduler+0x5e>
            minAcc = p->accumulator;
    80001fb6:	0007061b          	sext.w	a2,a4
        for(p = proc; p < &proc[NPROC]; p++) {
    80001fba:	fd37fce3          	bgeu	a5,s3,80001f92 <scheduler+0x5a>
    80001fbe:	8a36                	mv	s4,a3
    80001fc0:	bfe9                	j	80001f9a <scheduler+0x62>
        if (toRun != NULL) {
    80001fc2:	020a0963          	beqz	s4,80001ff4 <scheduler+0xbc>
          acquire(&toRun->lock);
    80001fc6:	8552                	mv	a0,s4
    80001fc8:	fffff097          	auipc	ra,0xfffff
    80001fcc:	c0e080e7          	jalr	-1010(ra) # 80000bd6 <acquire>
          p->state = RUNNING;
    80001fd0:	4791                	li	a5,4
    80001fd2:	cc9c                	sw	a5,24(s1)
          c->proc = toRun;
    80001fd4:	034ab823          	sd	s4,48(s5)
          swtch(&c->context, &toRun->context);
    80001fd8:	0a8a0593          	addi	a1,s4,168
    80001fdc:	8562                	mv	a0,s8
    80001fde:	00000097          	auipc	ra,0x0
    80001fe2:	716080e7          	jalr	1814(ra) # 800026f4 <swtch>
          c->proc = 0;
    80001fe6:	020ab823          	sd	zero,48(s5)
          release(&p->lock);
    80001fea:	8526                	mv	a0,s1
    80001fec:	fffff097          	auipc	ra,0xfffff
    80001ff0:	c9e080e7          	jalr	-866(ra) # 80000c8a <release>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001ff4:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001ff8:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001ffc:	10079073          	csrw	sstatus,a5
        for(p = proc; p < &proc[NPROC]; p++) {
    80002000:	0000f797          	auipc	a5,0xf
    80002004:	14078793          	addi	a5,a5,320 # 80011140 <proc+0x1b0>
        struct proc *toRun = NULL;
    80002008:	8a5e                	mv	s4,s7
        int minAcc = INT_MAX;
    8000200a:	865a                	mv	a2,s6
    8000200c:	bf49                	j	80001f9e <scheduler+0x66>

000000008000200e <sched>:
{
    8000200e:	7179                	addi	sp,sp,-48
    80002010:	f406                	sd	ra,40(sp)
    80002012:	f022                	sd	s0,32(sp)
    80002014:	ec26                	sd	s1,24(sp)
    80002016:	e84a                	sd	s2,16(sp)
    80002018:	e44e                	sd	s3,8(sp)
    8000201a:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    8000201c:	00000097          	auipc	ra,0x0
    80002020:	9a0080e7          	jalr	-1632(ra) # 800019bc <myproc>
    80002024:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80002026:	fffff097          	auipc	ra,0xfffff
    8000202a:	b36080e7          	jalr	-1226(ra) # 80000b5c <holding>
    8000202e:	c93d                	beqz	a0,800020a4 <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    80002030:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    80002032:	2781                	sext.w	a5,a5
    80002034:	079e                	slli	a5,a5,0x7
    80002036:	0000f717          	auipc	a4,0xf
    8000203a:	b2a70713          	addi	a4,a4,-1238 # 80010b60 <pid_lock>
    8000203e:	97ba                	add	a5,a5,a4
    80002040:	0a87a703          	lw	a4,168(a5)
    80002044:	4785                	li	a5,1
    80002046:	06f71763          	bne	a4,a5,800020b4 <sched+0xa6>
  if(p->state == RUNNING)
    8000204a:	4c98                	lw	a4,24(s1)
    8000204c:	4791                	li	a5,4
    8000204e:	06f70b63          	beq	a4,a5,800020c4 <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002052:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80002056:	8b89                	andi	a5,a5,2
  if(intr_get())
    80002058:	efb5                	bnez	a5,800020d4 <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    8000205a:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    8000205c:	0000f917          	auipc	s2,0xf
    80002060:	b0490913          	addi	s2,s2,-1276 # 80010b60 <pid_lock>
    80002064:	2781                	sext.w	a5,a5
    80002066:	079e                	slli	a5,a5,0x7
    80002068:	97ca                	add	a5,a5,s2
    8000206a:	0ac7a983          	lw	s3,172(a5)
    8000206e:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    80002070:	2781                	sext.w	a5,a5
    80002072:	079e                	slli	a5,a5,0x7
    80002074:	0000f597          	auipc	a1,0xf
    80002078:	b2458593          	addi	a1,a1,-1244 # 80010b98 <cpus+0x8>
    8000207c:	95be                	add	a1,a1,a5
    8000207e:	0a848513          	addi	a0,s1,168
    80002082:	00000097          	auipc	ra,0x0
    80002086:	672080e7          	jalr	1650(ra) # 800026f4 <swtch>
    8000208a:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    8000208c:	2781                	sext.w	a5,a5
    8000208e:	079e                	slli	a5,a5,0x7
    80002090:	97ca                	add	a5,a5,s2
    80002092:	0b37a623          	sw	s3,172(a5)
}
    80002096:	70a2                	ld	ra,40(sp)
    80002098:	7402                	ld	s0,32(sp)
    8000209a:	64e2                	ld	s1,24(sp)
    8000209c:	6942                	ld	s2,16(sp)
    8000209e:	69a2                	ld	s3,8(sp)
    800020a0:	6145                	addi	sp,sp,48
    800020a2:	8082                	ret
    panic("sched p->lock");
    800020a4:	00006517          	auipc	a0,0x6
    800020a8:	17450513          	addi	a0,a0,372 # 80008218 <digits+0x1d8>
    800020ac:	ffffe097          	auipc	ra,0xffffe
    800020b0:	492080e7          	jalr	1170(ra) # 8000053e <panic>
    panic("sched locks");
    800020b4:	00006517          	auipc	a0,0x6
    800020b8:	17450513          	addi	a0,a0,372 # 80008228 <digits+0x1e8>
    800020bc:	ffffe097          	auipc	ra,0xffffe
    800020c0:	482080e7          	jalr	1154(ra) # 8000053e <panic>
    panic("sched running");
    800020c4:	00006517          	auipc	a0,0x6
    800020c8:	17450513          	addi	a0,a0,372 # 80008238 <digits+0x1f8>
    800020cc:	ffffe097          	auipc	ra,0xffffe
    800020d0:	472080e7          	jalr	1138(ra) # 8000053e <panic>
    panic("sched interruptible");
    800020d4:	00006517          	auipc	a0,0x6
    800020d8:	17450513          	addi	a0,a0,372 # 80008248 <digits+0x208>
    800020dc:	ffffe097          	auipc	ra,0xffffe
    800020e0:	462080e7          	jalr	1122(ra) # 8000053e <panic>

00000000800020e4 <yield>:
{
    800020e4:	1101                	addi	sp,sp,-32
    800020e6:	ec06                	sd	ra,24(sp)
    800020e8:	e822                	sd	s0,16(sp)
    800020ea:	e426                	sd	s1,8(sp)
    800020ec:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    800020ee:	00000097          	auipc	ra,0x0
    800020f2:	8ce080e7          	jalr	-1842(ra) # 800019bc <myproc>
    800020f6:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800020f8:	fffff097          	auipc	ra,0xfffff
    800020fc:	ade080e7          	jalr	-1314(ra) # 80000bd6 <acquire>
  p->state = RUNNABLE;
    80002100:	478d                	li	a5,3
    80002102:	cc9c                	sw	a5,24(s1)
  p->accumulator += p->ps_priority;
    80002104:	50b8                	lw	a4,96(s1)
    80002106:	6cbc                	ld	a5,88(s1)
    80002108:	97ba                	add	a5,a5,a4
    8000210a:	ecbc                	sd	a5,88(s1)
  sched();
    8000210c:	00000097          	auipc	ra,0x0
    80002110:	f02080e7          	jalr	-254(ra) # 8000200e <sched>
  release(&p->lock);
    80002114:	8526                	mv	a0,s1
    80002116:	fffff097          	auipc	ra,0xfffff
    8000211a:	b74080e7          	jalr	-1164(ra) # 80000c8a <release>
}
    8000211e:	60e2                	ld	ra,24(sp)
    80002120:	6442                	ld	s0,16(sp)
    80002122:	64a2                	ld	s1,8(sp)
    80002124:	6105                	addi	sp,sp,32
    80002126:	8082                	ret

0000000080002128 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80002128:	7179                	addi	sp,sp,-48
    8000212a:	f406                	sd	ra,40(sp)
    8000212c:	f022                	sd	s0,32(sp)
    8000212e:	ec26                	sd	s1,24(sp)
    80002130:	e84a                	sd	s2,16(sp)
    80002132:	e44e                	sd	s3,8(sp)
    80002134:	1800                	addi	s0,sp,48
    80002136:	89aa                	mv	s3,a0
    80002138:	892e                	mv	s2,a1
  struct proc *p = myproc();
    8000213a:	00000097          	auipc	ra,0x0
    8000213e:	882080e7          	jalr	-1918(ra) # 800019bc <myproc>
    80002142:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    80002144:	fffff097          	auipc	ra,0xfffff
    80002148:	a92080e7          	jalr	-1390(ra) # 80000bd6 <acquire>
  release(lk);
    8000214c:	854a                	mv	a0,s2
    8000214e:	fffff097          	auipc	ra,0xfffff
    80002152:	b3c080e7          	jalr	-1220(ra) # 80000c8a <release>

  // Go to sleep.
  p->chan = chan;
    80002156:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    8000215a:	4789                	li	a5,2
    8000215c:	cc9c                	sw	a5,24(s1)

  sched();
    8000215e:	00000097          	auipc	ra,0x0
    80002162:	eb0080e7          	jalr	-336(ra) # 8000200e <sched>

  // Tidy up.
  p->chan = 0;
    80002166:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    8000216a:	8526                	mv	a0,s1
    8000216c:	fffff097          	auipc	ra,0xfffff
    80002170:	b1e080e7          	jalr	-1250(ra) # 80000c8a <release>
  acquire(lk);
    80002174:	854a                	mv	a0,s2
    80002176:	fffff097          	auipc	ra,0xfffff
    8000217a:	a60080e7          	jalr	-1440(ra) # 80000bd6 <acquire>
}
    8000217e:	70a2                	ld	ra,40(sp)
    80002180:	7402                	ld	s0,32(sp)
    80002182:	64e2                	ld	s1,24(sp)
    80002184:	6942                	ld	s2,16(sp)
    80002186:	69a2                	ld	s3,8(sp)
    80002188:	6145                	addi	sp,sp,48
    8000218a:	8082                	ret

000000008000218c <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    8000218c:	7139                	addi	sp,sp,-64
    8000218e:	fc06                	sd	ra,56(sp)
    80002190:	f822                	sd	s0,48(sp)
    80002192:	f426                	sd	s1,40(sp)
    80002194:	f04a                	sd	s2,32(sp)
    80002196:	ec4e                	sd	s3,24(sp)
    80002198:	e852                	sd	s4,16(sp)
    8000219a:	e456                	sd	s5,8(sp)
    8000219c:	0080                	addi	s0,sp,64
    8000219e:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800021a0:	0000f497          	auipc	s1,0xf
    800021a4:	df048493          	addi	s1,s1,-528 # 80010f90 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    800021a8:	4989                	li	s3,2
        p->state = RUNNABLE;
    800021aa:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    800021ac:	00016917          	auipc	s2,0x16
    800021b0:	9e490913          	addi	s2,s2,-1564 # 80017b90 <tickslock>
    800021b4:	a811                	j	800021c8 <wakeup+0x3c>
        set_accumulator(p);
      }
      release(&p->lock);
    800021b6:	8526                	mv	a0,s1
    800021b8:	fffff097          	auipc	ra,0xfffff
    800021bc:	ad2080e7          	jalr	-1326(ra) # 80000c8a <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800021c0:	1b048493          	addi	s1,s1,432
    800021c4:	03248b63          	beq	s1,s2,800021fa <wakeup+0x6e>
    if(p != myproc()){
    800021c8:	fffff097          	auipc	ra,0xfffff
    800021cc:	7f4080e7          	jalr	2036(ra) # 800019bc <myproc>
    800021d0:	fea488e3          	beq	s1,a0,800021c0 <wakeup+0x34>
      acquire(&p->lock);
    800021d4:	8526                	mv	a0,s1
    800021d6:	fffff097          	auipc	ra,0xfffff
    800021da:	a00080e7          	jalr	-1536(ra) # 80000bd6 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    800021de:	4c9c                	lw	a5,24(s1)
    800021e0:	fd379be3          	bne	a5,s3,800021b6 <wakeup+0x2a>
    800021e4:	709c                	ld	a5,32(s1)
    800021e6:	fd4798e3          	bne	a5,s4,800021b6 <wakeup+0x2a>
        p->state = RUNNABLE;
    800021ea:	0154ac23          	sw	s5,24(s1)
        set_accumulator(p);
    800021ee:	8526                	mv	a0,s1
    800021f0:	00000097          	auipc	ra,0x0
    800021f4:	b8a080e7          	jalr	-1142(ra) # 80001d7a <set_accumulator>
    800021f8:	bf7d                	j	800021b6 <wakeup+0x2a>
    }
  }
}
    800021fa:	70e2                	ld	ra,56(sp)
    800021fc:	7442                	ld	s0,48(sp)
    800021fe:	74a2                	ld	s1,40(sp)
    80002200:	7902                	ld	s2,32(sp)
    80002202:	69e2                	ld	s3,24(sp)
    80002204:	6a42                	ld	s4,16(sp)
    80002206:	6aa2                	ld	s5,8(sp)
    80002208:	6121                	addi	sp,sp,64
    8000220a:	8082                	ret

000000008000220c <reparent>:
{
    8000220c:	7179                	addi	sp,sp,-48
    8000220e:	f406                	sd	ra,40(sp)
    80002210:	f022                	sd	s0,32(sp)
    80002212:	ec26                	sd	s1,24(sp)
    80002214:	e84a                	sd	s2,16(sp)
    80002216:	e44e                	sd	s3,8(sp)
    80002218:	e052                	sd	s4,0(sp)
    8000221a:	1800                	addi	s0,sp,48
    8000221c:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    8000221e:	0000f497          	auipc	s1,0xf
    80002222:	d7248493          	addi	s1,s1,-654 # 80010f90 <proc>
      pp->parent = initproc;
    80002226:	00006a17          	auipc	s4,0x6
    8000222a:	6c2a0a13          	addi	s4,s4,1730 # 800088e8 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    8000222e:	00016997          	auipc	s3,0x16
    80002232:	96298993          	addi	s3,s3,-1694 # 80017b90 <tickslock>
    80002236:	a029                	j	80002240 <reparent+0x34>
    80002238:	1b048493          	addi	s1,s1,432
    8000223c:	01348d63          	beq	s1,s3,80002256 <reparent+0x4a>
    if(pp->parent == p){
    80002240:	60dc                	ld	a5,128(s1)
    80002242:	ff279be3          	bne	a5,s2,80002238 <reparent+0x2c>
      pp->parent = initproc;
    80002246:	000a3503          	ld	a0,0(s4)
    8000224a:	e0c8                	sd	a0,128(s1)
      wakeup(initproc);
    8000224c:	00000097          	auipc	ra,0x0
    80002250:	f40080e7          	jalr	-192(ra) # 8000218c <wakeup>
    80002254:	b7d5                	j	80002238 <reparent+0x2c>
}
    80002256:	70a2                	ld	ra,40(sp)
    80002258:	7402                	ld	s0,32(sp)
    8000225a:	64e2                	ld	s1,24(sp)
    8000225c:	6942                	ld	s2,16(sp)
    8000225e:	69a2                	ld	s3,8(sp)
    80002260:	6a02                	ld	s4,0(sp)
    80002262:	6145                	addi	sp,sp,48
    80002264:	8082                	ret

0000000080002266 <exit>:
{
    80002266:	7139                	addi	sp,sp,-64
    80002268:	fc06                	sd	ra,56(sp)
    8000226a:	f822                	sd	s0,48(sp)
    8000226c:	f426                	sd	s1,40(sp)
    8000226e:	f04a                	sd	s2,32(sp)
    80002270:	ec4e                	sd	s3,24(sp)
    80002272:	e852                	sd	s4,16(sp)
    80002274:	e456                	sd	s5,8(sp)
    80002276:	0080                	addi	s0,sp,64
    80002278:	8a2a                	mv	s4,a0
    8000227a:	8aae                	mv	s5,a1
  struct proc *p = myproc();
    8000227c:	fffff097          	auipc	ra,0xfffff
    80002280:	740080e7          	jalr	1856(ra) # 800019bc <myproc>
    80002284:	89aa                	mv	s3,a0
  if(p == initproc)
    80002286:	00006797          	auipc	a5,0x6
    8000228a:	6627b783          	ld	a5,1634(a5) # 800088e8 <initproc>
    8000228e:	11850493          	addi	s1,a0,280
    80002292:	19850913          	addi	s2,a0,408
    80002296:	02a79363          	bne	a5,a0,800022bc <exit+0x56>
    panic("init exiting");
    8000229a:	00006517          	auipc	a0,0x6
    8000229e:	fc650513          	addi	a0,a0,-58 # 80008260 <digits+0x220>
    800022a2:	ffffe097          	auipc	ra,0xffffe
    800022a6:	29c080e7          	jalr	668(ra) # 8000053e <panic>
      fileclose(f);
    800022aa:	00002097          	auipc	ra,0x2
    800022ae:	398080e7          	jalr	920(ra) # 80004642 <fileclose>
      p->ofile[fd] = 0;
    800022b2:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    800022b6:	04a1                	addi	s1,s1,8
    800022b8:	01248563          	beq	s1,s2,800022c2 <exit+0x5c>
    if(p->ofile[fd]){
    800022bc:	6088                	ld	a0,0(s1)
    800022be:	f575                	bnez	a0,800022aa <exit+0x44>
    800022c0:	bfdd                	j	800022b6 <exit+0x50>
  begin_op();
    800022c2:	00002097          	auipc	ra,0x2
    800022c6:	eb4080e7          	jalr	-332(ra) # 80004176 <begin_op>
  iput(p->cwd);
    800022ca:	1989b503          	ld	a0,408(s3)
    800022ce:	00001097          	auipc	ra,0x1
    800022d2:	6a0080e7          	jalr	1696(ra) # 8000396e <iput>
  end_op();
    800022d6:	00002097          	auipc	ra,0x2
    800022da:	f20080e7          	jalr	-224(ra) # 800041f6 <end_op>
  p->cwd = 0;
    800022de:	1809bc23          	sd	zero,408(s3)
  acquire(&wait_lock);
    800022e2:	0000f497          	auipc	s1,0xf
    800022e6:	89648493          	addi	s1,s1,-1898 # 80010b78 <wait_lock>
    800022ea:	8526                	mv	a0,s1
    800022ec:	fffff097          	auipc	ra,0xfffff
    800022f0:	8ea080e7          	jalr	-1814(ra) # 80000bd6 <acquire>
  reparent(p);
    800022f4:	854e                	mv	a0,s3
    800022f6:	00000097          	auipc	ra,0x0
    800022fa:	f16080e7          	jalr	-234(ra) # 8000220c <reparent>
  wakeup(p->parent);
    800022fe:	0809b503          	ld	a0,128(s3)
    80002302:	00000097          	auipc	ra,0x0
    80002306:	e8a080e7          	jalr	-374(ra) # 8000218c <wakeup>
  acquire(&p->lock);
    8000230a:	854e                	mv	a0,s3
    8000230c:	fffff097          	auipc	ra,0xfffff
    80002310:	8ca080e7          	jalr	-1846(ra) # 80000bd6 <acquire>
  strncpy(p->exit_msg, msg, 32);
    80002314:	02000613          	li	a2,32
    80002318:	85d6                	mv	a1,s5
    8000231a:	03498513          	addi	a0,s3,52
    8000231e:	fffff097          	auipc	ra,0xfffff
    80002322:	ac0080e7          	jalr	-1344(ra) # 80000dde <strncpy>
  p->xstate = status;
    80002326:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    8000232a:	4795                	li	a5,5
    8000232c:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    80002330:	8526                	mv	a0,s1
    80002332:	fffff097          	auipc	ra,0xfffff
    80002336:	958080e7          	jalr	-1704(ra) # 80000c8a <release>
  sched();
    8000233a:	00000097          	auipc	ra,0x0
    8000233e:	cd4080e7          	jalr	-812(ra) # 8000200e <sched>
  panic("zombie exit");
    80002342:	00006517          	auipc	a0,0x6
    80002346:	f2e50513          	addi	a0,a0,-210 # 80008270 <digits+0x230>
    8000234a:	ffffe097          	auipc	ra,0xffffe
    8000234e:	1f4080e7          	jalr	500(ra) # 8000053e <panic>

0000000080002352 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80002352:	7179                	addi	sp,sp,-48
    80002354:	f406                	sd	ra,40(sp)
    80002356:	f022                	sd	s0,32(sp)
    80002358:	ec26                	sd	s1,24(sp)
    8000235a:	e84a                	sd	s2,16(sp)
    8000235c:	e44e                	sd	s3,8(sp)
    8000235e:	1800                	addi	s0,sp,48
    80002360:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80002362:	0000f497          	auipc	s1,0xf
    80002366:	c2e48493          	addi	s1,s1,-978 # 80010f90 <proc>
    8000236a:	00016997          	auipc	s3,0x16
    8000236e:	82698993          	addi	s3,s3,-2010 # 80017b90 <tickslock>
    acquire(&p->lock);
    80002372:	8526                	mv	a0,s1
    80002374:	fffff097          	auipc	ra,0xfffff
    80002378:	862080e7          	jalr	-1950(ra) # 80000bd6 <acquire>
    if(p->pid == pid){
    8000237c:	589c                	lw	a5,48(s1)
    8000237e:	01278d63          	beq	a5,s2,80002398 <kill+0x46>
        p->accumulator += p->ps_priority;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80002382:	8526                	mv	a0,s1
    80002384:	fffff097          	auipc	ra,0xfffff
    80002388:	906080e7          	jalr	-1786(ra) # 80000c8a <release>
  for(p = proc; p < &proc[NPROC]; p++){
    8000238c:	1b048493          	addi	s1,s1,432
    80002390:	ff3491e3          	bne	s1,s3,80002372 <kill+0x20>
  }
  return -1;
    80002394:	557d                	li	a0,-1
    80002396:	a829                	j	800023b0 <kill+0x5e>
      p->killed = 1;
    80002398:	4785                	li	a5,1
    8000239a:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    8000239c:	4c98                	lw	a4,24(s1)
    8000239e:	4789                	li	a5,2
    800023a0:	00f70f63          	beq	a4,a5,800023be <kill+0x6c>
      release(&p->lock);
    800023a4:	8526                	mv	a0,s1
    800023a6:	fffff097          	auipc	ra,0xfffff
    800023aa:	8e4080e7          	jalr	-1820(ra) # 80000c8a <release>
      return 0;
    800023ae:	4501                	li	a0,0
}
    800023b0:	70a2                	ld	ra,40(sp)
    800023b2:	7402                	ld	s0,32(sp)
    800023b4:	64e2                	ld	s1,24(sp)
    800023b6:	6942                	ld	s2,16(sp)
    800023b8:	69a2                	ld	s3,8(sp)
    800023ba:	6145                	addi	sp,sp,48
    800023bc:	8082                	ret
        p->state = RUNNABLE;
    800023be:	478d                	li	a5,3
    800023c0:	cc9c                	sw	a5,24(s1)
        p->accumulator += p->ps_priority;
    800023c2:	50b8                	lw	a4,96(s1)
    800023c4:	6cbc                	ld	a5,88(s1)
    800023c6:	97ba                	add	a5,a5,a4
    800023c8:	ecbc                	sd	a5,88(s1)
    800023ca:	bfe9                	j	800023a4 <kill+0x52>

00000000800023cc <setkilled>:

void
setkilled(struct proc *p)
{
    800023cc:	1101                	addi	sp,sp,-32
    800023ce:	ec06                	sd	ra,24(sp)
    800023d0:	e822                	sd	s0,16(sp)
    800023d2:	e426                	sd	s1,8(sp)
    800023d4:	1000                	addi	s0,sp,32
    800023d6:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800023d8:	ffffe097          	auipc	ra,0xffffe
    800023dc:	7fe080e7          	jalr	2046(ra) # 80000bd6 <acquire>
  p->killed = 1;
    800023e0:	4785                	li	a5,1
    800023e2:	d49c                	sw	a5,40(s1)
  release(&p->lock);
    800023e4:	8526                	mv	a0,s1
    800023e6:	fffff097          	auipc	ra,0xfffff
    800023ea:	8a4080e7          	jalr	-1884(ra) # 80000c8a <release>
}
    800023ee:	60e2                	ld	ra,24(sp)
    800023f0:	6442                	ld	s0,16(sp)
    800023f2:	64a2                	ld	s1,8(sp)
    800023f4:	6105                	addi	sp,sp,32
    800023f6:	8082                	ret

00000000800023f8 <killed>:

int
killed(struct proc *p)
{
    800023f8:	1101                	addi	sp,sp,-32
    800023fa:	ec06                	sd	ra,24(sp)
    800023fc:	e822                	sd	s0,16(sp)
    800023fe:	e426                	sd	s1,8(sp)
    80002400:	e04a                	sd	s2,0(sp)
    80002402:	1000                	addi	s0,sp,32
    80002404:	84aa                	mv	s1,a0
  int k;
  
  acquire(&p->lock);
    80002406:	ffffe097          	auipc	ra,0xffffe
    8000240a:	7d0080e7          	jalr	2000(ra) # 80000bd6 <acquire>
  k = p->killed;
    8000240e:	0284a903          	lw	s2,40(s1)
  release(&p->lock);
    80002412:	8526                	mv	a0,s1
    80002414:	fffff097          	auipc	ra,0xfffff
    80002418:	876080e7          	jalr	-1930(ra) # 80000c8a <release>
  return k;
}
    8000241c:	854a                	mv	a0,s2
    8000241e:	60e2                	ld	ra,24(sp)
    80002420:	6442                	ld	s0,16(sp)
    80002422:	64a2                	ld	s1,8(sp)
    80002424:	6902                	ld	s2,0(sp)
    80002426:	6105                	addi	sp,sp,32
    80002428:	8082                	ret

000000008000242a <wait>:
{
    8000242a:	7119                	addi	sp,sp,-128
    8000242c:	fc86                	sd	ra,120(sp)
    8000242e:	f8a2                	sd	s0,112(sp)
    80002430:	f4a6                	sd	s1,104(sp)
    80002432:	f0ca                	sd	s2,96(sp)
    80002434:	ecce                	sd	s3,88(sp)
    80002436:	e8d2                	sd	s4,80(sp)
    80002438:	e4d6                	sd	s5,72(sp)
    8000243a:	e0da                	sd	s6,64(sp)
    8000243c:	fc5e                	sd	s7,56(sp)
    8000243e:	f862                	sd	s8,48(sp)
    80002440:	f466                	sd	s9,40(sp)
    80002442:	f06a                	sd	s10,32(sp)
    80002444:	ec6e                	sd	s11,24(sp)
    80002446:	0100                	addi	s0,sp,128
    80002448:	f8a43423          	sd	a0,-120(s0)
    8000244c:	8bae                	mv	s7,a1
  struct proc *p = myproc();
    8000244e:	fffff097          	auipc	ra,0xfffff
    80002452:	56e080e7          	jalr	1390(ra) # 800019bc <myproc>
    80002456:	892a                	mv	s2,a0
  acquire(&wait_lock);
    80002458:	0000e517          	auipc	a0,0xe
    8000245c:	72050513          	addi	a0,a0,1824 # 80010b78 <wait_lock>
    80002460:	ffffe097          	auipc	ra,0xffffe
    80002464:	776080e7          	jalr	1910(ra) # 80000bd6 <acquire>
        if(pp->state == ZOMBIE){
    80002468:	4c15                	li	s8,5
        havekids = 1;
    8000246a:	4c85                	li	s9,1
          printf("error\n");
    8000246c:	00006d17          	auipc	s10,0x6
    80002470:	e14d0d13          	addi	s10,s10,-492 # 80008280 <digits+0x240>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80002474:	00015997          	auipc	s3,0x15
    80002478:	71c98993          	addi	s3,s3,1820 # 80017b90 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    8000247c:	0000ed97          	auipc	s11,0xe
    80002480:	6fcd8d93          	addi	s11,s11,1788 # 80010b78 <wait_lock>
    havekids = 0;
    80002484:	4701                	li	a4,0
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80002486:	0000f497          	auipc	s1,0xf
    8000248a:	b0a48493          	addi	s1,s1,-1270 # 80010f90 <proc>
    8000248e:	a831                	j	800024aa <wait+0x80>
        if(pp->state == ZOMBIE){
    80002490:	4c9c                	lw	a5,24(s1)
    80002492:	05878f63          	beq	a5,s8,800024f0 <wait+0xc6>
        release(&pp->lock);
    80002496:	8526                	mv	a0,s1
    80002498:	ffffe097          	auipc	ra,0xffffe
    8000249c:	7f2080e7          	jalr	2034(ra) # 80000c8a <release>
        havekids = 1;
    800024a0:	8766                	mv	a4,s9
    for(pp = proc; pp < &proc[NPROC]; pp++){
    800024a2:	1b048493          	addi	s1,s1,432
    800024a6:	0b348363          	beq	s1,s3,8000254c <wait+0x122>
      if(pp->parent == p){
    800024aa:	60dc                	ld	a5,128(s1)
    800024ac:	ff279be3          	bne	a5,s2,800024a2 <wait+0x78>
        acquire(&pp->lock);
    800024b0:	8526                	mv	a0,s1
    800024b2:	ffffe097          	auipc	ra,0xffffe
    800024b6:	724080e7          	jalr	1828(ra) # 80000bd6 <acquire>
        if (copyout(p->pagetable, *msg , (char*) &pp->exit_msg, strlen(pp->exit_msg)) < 0)
    800024ba:	09893a83          	ld	s5,152(s2)
    800024be:	000bcb03          	lbu	s6,0(s7)
    800024c2:	03448a13          	addi	s4,s1,52
    800024c6:	8552                	mv	a0,s4
    800024c8:	fffff097          	auipc	ra,0xfffff
    800024cc:	986080e7          	jalr	-1658(ra) # 80000e4e <strlen>
    800024d0:	86aa                	mv	a3,a0
    800024d2:	8652                	mv	a2,s4
    800024d4:	85da                	mv	a1,s6
    800024d6:	8556                	mv	a0,s5
    800024d8:	fffff097          	auipc	ra,0xfffff
    800024dc:	192080e7          	jalr	402(ra) # 8000166a <copyout>
    800024e0:	fa0558e3          	bgez	a0,80002490 <wait+0x66>
          printf("error\n");
    800024e4:	856a                	mv	a0,s10
    800024e6:	ffffe097          	auipc	ra,0xffffe
    800024ea:	0a2080e7          	jalr	162(ra) # 80000588 <printf>
    800024ee:	b74d                	j	80002490 <wait+0x66>
          pid = pp->pid;
    800024f0:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    800024f4:	f8843783          	ld	a5,-120(s0)
    800024f8:	cf89                	beqz	a5,80002512 <wait+0xe8>
    800024fa:	4691                	li	a3,4
    800024fc:	02c48613          	addi	a2,s1,44
    80002500:	85be                	mv	a1,a5
    80002502:	09893503          	ld	a0,152(s2)
    80002506:	fffff097          	auipc	ra,0xfffff
    8000250a:	164080e7          	jalr	356(ra) # 8000166a <copyout>
    8000250e:	02054063          	bltz	a0,8000252e <wait+0x104>
          release(&pp->lock);
    80002512:	8526                	mv	a0,s1
    80002514:	ffffe097          	auipc	ra,0xffffe
    80002518:	776080e7          	jalr	1910(ra) # 80000c8a <release>
          release(&wait_lock);
    8000251c:	0000e517          	auipc	a0,0xe
    80002520:	65c50513          	addi	a0,a0,1628 # 80010b78 <wait_lock>
    80002524:	ffffe097          	auipc	ra,0xffffe
    80002528:	766080e7          	jalr	1894(ra) # 80000c8a <release>
          return pid;
    8000252c:	a081                	j	8000256c <wait+0x142>
            release(&pp->lock);
    8000252e:	8526                	mv	a0,s1
    80002530:	ffffe097          	auipc	ra,0xffffe
    80002534:	75a080e7          	jalr	1882(ra) # 80000c8a <release>
            release(&wait_lock);
    80002538:	0000e517          	auipc	a0,0xe
    8000253c:	64050513          	addi	a0,a0,1600 # 80010b78 <wait_lock>
    80002540:	ffffe097          	auipc	ra,0xffffe
    80002544:	74a080e7          	jalr	1866(ra) # 80000c8a <release>
            return -1;
    80002548:	59fd                	li	s3,-1
    8000254a:	a00d                	j	8000256c <wait+0x142>
    if(!havekids || killed(p)){
    8000254c:	c719                	beqz	a4,8000255a <wait+0x130>
    8000254e:	854a                	mv	a0,s2
    80002550:	00000097          	auipc	ra,0x0
    80002554:	ea8080e7          	jalr	-344(ra) # 800023f8 <killed>
    80002558:	c915                	beqz	a0,8000258c <wait+0x162>
      release(&wait_lock);
    8000255a:	0000e517          	auipc	a0,0xe
    8000255e:	61e50513          	addi	a0,a0,1566 # 80010b78 <wait_lock>
    80002562:	ffffe097          	auipc	ra,0xffffe
    80002566:	728080e7          	jalr	1832(ra) # 80000c8a <release>
      return -1;
    8000256a:	59fd                	li	s3,-1
}
    8000256c:	854e                	mv	a0,s3
    8000256e:	70e6                	ld	ra,120(sp)
    80002570:	7446                	ld	s0,112(sp)
    80002572:	74a6                	ld	s1,104(sp)
    80002574:	7906                	ld	s2,96(sp)
    80002576:	69e6                	ld	s3,88(sp)
    80002578:	6a46                	ld	s4,80(sp)
    8000257a:	6aa6                	ld	s5,72(sp)
    8000257c:	6b06                	ld	s6,64(sp)
    8000257e:	7be2                	ld	s7,56(sp)
    80002580:	7c42                	ld	s8,48(sp)
    80002582:	7ca2                	ld	s9,40(sp)
    80002584:	7d02                	ld	s10,32(sp)
    80002586:	6de2                	ld	s11,24(sp)
    80002588:	6109                	addi	sp,sp,128
    8000258a:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    8000258c:	85ee                	mv	a1,s11
    8000258e:	854a                	mv	a0,s2
    80002590:	00000097          	auipc	ra,0x0
    80002594:	b98080e7          	jalr	-1128(ra) # 80002128 <sleep>
    havekids = 0;
    80002598:	b5f5                	j	80002484 <wait+0x5a>

000000008000259a <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    8000259a:	7179                	addi	sp,sp,-48
    8000259c:	f406                	sd	ra,40(sp)
    8000259e:	f022                	sd	s0,32(sp)
    800025a0:	ec26                	sd	s1,24(sp)
    800025a2:	e84a                	sd	s2,16(sp)
    800025a4:	e44e                	sd	s3,8(sp)
    800025a6:	e052                	sd	s4,0(sp)
    800025a8:	1800                	addi	s0,sp,48
    800025aa:	84aa                	mv	s1,a0
    800025ac:	892e                	mv	s2,a1
    800025ae:	89b2                	mv	s3,a2
    800025b0:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800025b2:	fffff097          	auipc	ra,0xfffff
    800025b6:	40a080e7          	jalr	1034(ra) # 800019bc <myproc>
  if(user_dst){
    800025ba:	c08d                	beqz	s1,800025dc <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    800025bc:	86d2                	mv	a3,s4
    800025be:	864e                	mv	a2,s3
    800025c0:	85ca                	mv	a1,s2
    800025c2:	6d48                	ld	a0,152(a0)
    800025c4:	fffff097          	auipc	ra,0xfffff
    800025c8:	0a6080e7          	jalr	166(ra) # 8000166a <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    800025cc:	70a2                	ld	ra,40(sp)
    800025ce:	7402                	ld	s0,32(sp)
    800025d0:	64e2                	ld	s1,24(sp)
    800025d2:	6942                	ld	s2,16(sp)
    800025d4:	69a2                	ld	s3,8(sp)
    800025d6:	6a02                	ld	s4,0(sp)
    800025d8:	6145                	addi	sp,sp,48
    800025da:	8082                	ret
    memmove((char *)dst, src, len);
    800025dc:	000a061b          	sext.w	a2,s4
    800025e0:	85ce                	mv	a1,s3
    800025e2:	854a                	mv	a0,s2
    800025e4:	ffffe097          	auipc	ra,0xffffe
    800025e8:	74a080e7          	jalr	1866(ra) # 80000d2e <memmove>
    return 0;
    800025ec:	8526                	mv	a0,s1
    800025ee:	bff9                	j	800025cc <either_copyout+0x32>

00000000800025f0 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    800025f0:	7179                	addi	sp,sp,-48
    800025f2:	f406                	sd	ra,40(sp)
    800025f4:	f022                	sd	s0,32(sp)
    800025f6:	ec26                	sd	s1,24(sp)
    800025f8:	e84a                	sd	s2,16(sp)
    800025fa:	e44e                	sd	s3,8(sp)
    800025fc:	e052                	sd	s4,0(sp)
    800025fe:	1800                	addi	s0,sp,48
    80002600:	892a                	mv	s2,a0
    80002602:	84ae                	mv	s1,a1
    80002604:	89b2                	mv	s3,a2
    80002606:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80002608:	fffff097          	auipc	ra,0xfffff
    8000260c:	3b4080e7          	jalr	948(ra) # 800019bc <myproc>
  if(user_src){
    80002610:	c08d                	beqz	s1,80002632 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80002612:	86d2                	mv	a3,s4
    80002614:	864e                	mv	a2,s3
    80002616:	85ca                	mv	a1,s2
    80002618:	6d48                	ld	a0,152(a0)
    8000261a:	fffff097          	auipc	ra,0xfffff
    8000261e:	0dc080e7          	jalr	220(ra) # 800016f6 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80002622:	70a2                	ld	ra,40(sp)
    80002624:	7402                	ld	s0,32(sp)
    80002626:	64e2                	ld	s1,24(sp)
    80002628:	6942                	ld	s2,16(sp)
    8000262a:	69a2                	ld	s3,8(sp)
    8000262c:	6a02                	ld	s4,0(sp)
    8000262e:	6145                	addi	sp,sp,48
    80002630:	8082                	ret
    memmove(dst, (char*)src, len);
    80002632:	000a061b          	sext.w	a2,s4
    80002636:	85ce                	mv	a1,s3
    80002638:	854a                	mv	a0,s2
    8000263a:	ffffe097          	auipc	ra,0xffffe
    8000263e:	6f4080e7          	jalr	1780(ra) # 80000d2e <memmove>
    return 0;
    80002642:	8526                	mv	a0,s1
    80002644:	bff9                	j	80002622 <either_copyin+0x32>

0000000080002646 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80002646:	715d                	addi	sp,sp,-80
    80002648:	e486                	sd	ra,72(sp)
    8000264a:	e0a2                	sd	s0,64(sp)
    8000264c:	fc26                	sd	s1,56(sp)
    8000264e:	f84a                	sd	s2,48(sp)
    80002650:	f44e                	sd	s3,40(sp)
    80002652:	f052                	sd	s4,32(sp)
    80002654:	ec56                	sd	s5,24(sp)
    80002656:	e85a                	sd	s6,16(sp)
    80002658:	e45e                	sd	s7,8(sp)
    8000265a:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    8000265c:	00006517          	auipc	a0,0x6
    80002660:	a6c50513          	addi	a0,a0,-1428 # 800080c8 <digits+0x88>
    80002664:	ffffe097          	auipc	ra,0xffffe
    80002668:	f24080e7          	jalr	-220(ra) # 80000588 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    8000266c:	0000f497          	auipc	s1,0xf
    80002670:	ac448493          	addi	s1,s1,-1340 # 80011130 <proc+0x1a0>
    80002674:	00015917          	auipc	s2,0x15
    80002678:	6bc90913          	addi	s2,s2,1724 # 80017d30 <bcache+0x188>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    8000267c:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    8000267e:	00006997          	auipc	s3,0x6
    80002682:	c0a98993          	addi	s3,s3,-1014 # 80008288 <digits+0x248>
    printf("%d %s %s", p->pid, state, p->name);
    80002686:	00006a97          	auipc	s5,0x6
    8000268a:	c0aa8a93          	addi	s5,s5,-1014 # 80008290 <digits+0x250>
    printf("\n");
    8000268e:	00006a17          	auipc	s4,0x6
    80002692:	a3aa0a13          	addi	s4,s4,-1478 # 800080c8 <digits+0x88>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002696:	00006b97          	auipc	s7,0x6
    8000269a:	c3ab8b93          	addi	s7,s7,-966 # 800082d0 <states.0>
    8000269e:	a00d                	j	800026c0 <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    800026a0:	e906a583          	lw	a1,-368(a3)
    800026a4:	8556                	mv	a0,s5
    800026a6:	ffffe097          	auipc	ra,0xffffe
    800026aa:	ee2080e7          	jalr	-286(ra) # 80000588 <printf>
    printf("\n");
    800026ae:	8552                	mv	a0,s4
    800026b0:	ffffe097          	auipc	ra,0xffffe
    800026b4:	ed8080e7          	jalr	-296(ra) # 80000588 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    800026b8:	1b048493          	addi	s1,s1,432
    800026bc:	03248163          	beq	s1,s2,800026de <procdump+0x98>
    if(p->state == UNUSED)
    800026c0:	86a6                	mv	a3,s1
    800026c2:	e784a783          	lw	a5,-392(s1)
    800026c6:	dbed                	beqz	a5,800026b8 <procdump+0x72>
      state = "???";
    800026c8:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800026ca:	fcfb6be3          	bltu	s6,a5,800026a0 <procdump+0x5a>
    800026ce:	1782                	slli	a5,a5,0x20
    800026d0:	9381                	srli	a5,a5,0x20
    800026d2:	078e                	slli	a5,a5,0x3
    800026d4:	97de                	add	a5,a5,s7
    800026d6:	6390                	ld	a2,0(a5)
    800026d8:	f661                	bnez	a2,800026a0 <procdump+0x5a>
      state = "???";
    800026da:	864e                	mv	a2,s3
    800026dc:	b7d1                	j	800026a0 <procdump+0x5a>
  }
}
    800026de:	60a6                	ld	ra,72(sp)
    800026e0:	6406                	ld	s0,64(sp)
    800026e2:	74e2                	ld	s1,56(sp)
    800026e4:	7942                	ld	s2,48(sp)
    800026e6:	79a2                	ld	s3,40(sp)
    800026e8:	7a02                	ld	s4,32(sp)
    800026ea:	6ae2                	ld	s5,24(sp)
    800026ec:	6b42                	ld	s6,16(sp)
    800026ee:	6ba2                	ld	s7,8(sp)
    800026f0:	6161                	addi	sp,sp,80
    800026f2:	8082                	ret

00000000800026f4 <swtch>:
    800026f4:	00153023          	sd	ra,0(a0)
    800026f8:	00253423          	sd	sp,8(a0)
    800026fc:	e900                	sd	s0,16(a0)
    800026fe:	ed04                	sd	s1,24(a0)
    80002700:	03253023          	sd	s2,32(a0)
    80002704:	03353423          	sd	s3,40(a0)
    80002708:	03453823          	sd	s4,48(a0)
    8000270c:	03553c23          	sd	s5,56(a0)
    80002710:	05653023          	sd	s6,64(a0)
    80002714:	05753423          	sd	s7,72(a0)
    80002718:	05853823          	sd	s8,80(a0)
    8000271c:	05953c23          	sd	s9,88(a0)
    80002720:	07a53023          	sd	s10,96(a0)
    80002724:	07b53423          	sd	s11,104(a0)
    80002728:	0005b083          	ld	ra,0(a1)
    8000272c:	0085b103          	ld	sp,8(a1)
    80002730:	6980                	ld	s0,16(a1)
    80002732:	6d84                	ld	s1,24(a1)
    80002734:	0205b903          	ld	s2,32(a1)
    80002738:	0285b983          	ld	s3,40(a1)
    8000273c:	0305ba03          	ld	s4,48(a1)
    80002740:	0385ba83          	ld	s5,56(a1)
    80002744:	0405bb03          	ld	s6,64(a1)
    80002748:	0485bb83          	ld	s7,72(a1)
    8000274c:	0505bc03          	ld	s8,80(a1)
    80002750:	0585bc83          	ld	s9,88(a1)
    80002754:	0605bd03          	ld	s10,96(a1)
    80002758:	0685bd83          	ld	s11,104(a1)
    8000275c:	8082                	ret

000000008000275e <trapinit>:

extern int devintr();

void
trapinit(void)
{
    8000275e:	1141                	addi	sp,sp,-16
    80002760:	e406                	sd	ra,8(sp)
    80002762:	e022                	sd	s0,0(sp)
    80002764:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80002766:	00006597          	auipc	a1,0x6
    8000276a:	b9a58593          	addi	a1,a1,-1126 # 80008300 <states.0+0x30>
    8000276e:	00015517          	auipc	a0,0x15
    80002772:	42250513          	addi	a0,a0,1058 # 80017b90 <tickslock>
    80002776:	ffffe097          	auipc	ra,0xffffe
    8000277a:	3d0080e7          	jalr	976(ra) # 80000b46 <initlock>
}
    8000277e:	60a2                	ld	ra,8(sp)
    80002780:	6402                	ld	s0,0(sp)
    80002782:	0141                	addi	sp,sp,16
    80002784:	8082                	ret

0000000080002786 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80002786:	1141                	addi	sp,sp,-16
    80002788:	e422                	sd	s0,8(sp)
    8000278a:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    8000278c:	00003797          	auipc	a5,0x3
    80002790:	56478793          	addi	a5,a5,1380 # 80005cf0 <kernelvec>
    80002794:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80002798:	6422                	ld	s0,8(sp)
    8000279a:	0141                	addi	sp,sp,16
    8000279c:	8082                	ret

000000008000279e <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    8000279e:	1141                	addi	sp,sp,-16
    800027a0:	e406                	sd	ra,8(sp)
    800027a2:	e022                	sd	s0,0(sp)
    800027a4:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    800027a6:	fffff097          	auipc	ra,0xfffff
    800027aa:	216080e7          	jalr	534(ra) # 800019bc <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800027ae:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800027b2:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800027b4:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    800027b8:	00005617          	auipc	a2,0x5
    800027bc:	84860613          	addi	a2,a2,-1976 # 80007000 <_trampoline>
    800027c0:	00005697          	auipc	a3,0x5
    800027c4:	84068693          	addi	a3,a3,-1984 # 80007000 <_trampoline>
    800027c8:	8e91                	sub	a3,a3,a2
    800027ca:	040007b7          	lui	a5,0x4000
    800027ce:	17fd                	addi	a5,a5,-1
    800027d0:	07b2                	slli	a5,a5,0xc
    800027d2:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    800027d4:	10569073          	csrw	stvec,a3
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    800027d8:	7158                	ld	a4,160(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    800027da:	180026f3          	csrr	a3,satp
    800027de:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    800027e0:	7158                	ld	a4,160(a0)
    800027e2:	6554                	ld	a3,136(a0)
    800027e4:	6585                	lui	a1,0x1
    800027e6:	96ae                	add	a3,a3,a1
    800027e8:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    800027ea:	7158                	ld	a4,160(a0)
    800027ec:	00000697          	auipc	a3,0x0
    800027f0:	13068693          	addi	a3,a3,304 # 8000291c <usertrap>
    800027f4:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    800027f6:	7158                	ld	a4,160(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    800027f8:	8692                	mv	a3,tp
    800027fa:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800027fc:	100026f3          	csrr	a3,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80002800:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80002804:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002808:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    8000280c:	7158                	ld	a4,160(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    8000280e:	6f18                	ld	a4,24(a4)
    80002810:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80002814:	6d48                	ld	a0,152(a0)
    80002816:	8131                	srli	a0,a0,0xc

  // jump to userret in trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80002818:	00005717          	auipc	a4,0x5
    8000281c:	88470713          	addi	a4,a4,-1916 # 8000709c <userret>
    80002820:	8f11                	sub	a4,a4,a2
    80002822:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    80002824:	577d                	li	a4,-1
    80002826:	177e                	slli	a4,a4,0x3f
    80002828:	8d59                	or	a0,a0,a4
    8000282a:	9782                	jalr	a5
}
    8000282c:	60a2                	ld	ra,8(sp)
    8000282e:	6402                	ld	s0,0(sp)
    80002830:	0141                	addi	sp,sp,16
    80002832:	8082                	ret

0000000080002834 <clockintr>:

// struct proc proc[NPROC];

void
clockintr()
{
    80002834:	1101                	addi	sp,sp,-32
    80002836:	ec06                	sd	ra,24(sp)
    80002838:	e822                	sd	s0,16(sp)
    8000283a:	e426                	sd	s1,8(sp)
    8000283c:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    8000283e:	00015497          	auipc	s1,0x15
    80002842:	35248493          	addi	s1,s1,850 # 80017b90 <tickslock>
    80002846:	8526                	mv	a0,s1
    80002848:	ffffe097          	auipc	ra,0xffffe
    8000284c:	38e080e7          	jalr	910(ra) # 80000bd6 <acquire>
  ticks++;
    80002850:	00006517          	auipc	a0,0x6
    80002854:	0a050513          	addi	a0,a0,160 # 800088f0 <ticks>
    80002858:	411c                	lw	a5,0(a0)
    8000285a:	2785                	addiw	a5,a5,1
    8000285c:	c11c                	sw	a5,0(a0)
  //     p->stime++;
  //   else if (p->state == RUNNABLE)
  //     p->retime++;      
  // }

  wakeup(&ticks);
    8000285e:	00000097          	auipc	ra,0x0
    80002862:	92e080e7          	jalr	-1746(ra) # 8000218c <wakeup>
  release(&tickslock);
    80002866:	8526                	mv	a0,s1
    80002868:	ffffe097          	auipc	ra,0xffffe
    8000286c:	422080e7          	jalr	1058(ra) # 80000c8a <release>
}
    80002870:	60e2                	ld	ra,24(sp)
    80002872:	6442                	ld	s0,16(sp)
    80002874:	64a2                	ld	s1,8(sp)
    80002876:	6105                	addi	sp,sp,32
    80002878:	8082                	ret

000000008000287a <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    8000287a:	1101                	addi	sp,sp,-32
    8000287c:	ec06                	sd	ra,24(sp)
    8000287e:	e822                	sd	s0,16(sp)
    80002880:	e426                	sd	s1,8(sp)
    80002882:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002884:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    80002888:	00074d63          	bltz	a4,800028a2 <devintr+0x28>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000001L){
    8000288c:	57fd                	li	a5,-1
    8000288e:	17fe                	slli	a5,a5,0x3f
    80002890:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80002892:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80002894:	06f70363          	beq	a4,a5,800028fa <devintr+0x80>
  }
}
    80002898:	60e2                	ld	ra,24(sp)
    8000289a:	6442                	ld	s0,16(sp)
    8000289c:	64a2                	ld	s1,8(sp)
    8000289e:	6105                	addi	sp,sp,32
    800028a0:	8082                	ret
     (scause & 0xff) == 9){
    800028a2:	0ff77793          	andi	a5,a4,255
  if((scause & 0x8000000000000000L) &&
    800028a6:	46a5                	li	a3,9
    800028a8:	fed792e3          	bne	a5,a3,8000288c <devintr+0x12>
    int irq = plic_claim();
    800028ac:	00003097          	auipc	ra,0x3
    800028b0:	54c080e7          	jalr	1356(ra) # 80005df8 <plic_claim>
    800028b4:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    800028b6:	47a9                	li	a5,10
    800028b8:	02f50763          	beq	a0,a5,800028e6 <devintr+0x6c>
    } else if(irq == VIRTIO0_IRQ){
    800028bc:	4785                	li	a5,1
    800028be:	02f50963          	beq	a0,a5,800028f0 <devintr+0x76>
    return 1;
    800028c2:	4505                	li	a0,1
    } else if(irq){
    800028c4:	d8f1                	beqz	s1,80002898 <devintr+0x1e>
      printf("unexpected interrupt irq=%d\n", irq);
    800028c6:	85a6                	mv	a1,s1
    800028c8:	00006517          	auipc	a0,0x6
    800028cc:	a4050513          	addi	a0,a0,-1472 # 80008308 <states.0+0x38>
    800028d0:	ffffe097          	auipc	ra,0xffffe
    800028d4:	cb8080e7          	jalr	-840(ra) # 80000588 <printf>
      plic_complete(irq);
    800028d8:	8526                	mv	a0,s1
    800028da:	00003097          	auipc	ra,0x3
    800028de:	542080e7          	jalr	1346(ra) # 80005e1c <plic_complete>
    return 1;
    800028e2:	4505                	li	a0,1
    800028e4:	bf55                	j	80002898 <devintr+0x1e>
      uartintr();
    800028e6:	ffffe097          	auipc	ra,0xffffe
    800028ea:	0b4080e7          	jalr	180(ra) # 8000099a <uartintr>
    800028ee:	b7ed                	j	800028d8 <devintr+0x5e>
      virtio_disk_intr();
    800028f0:	00004097          	auipc	ra,0x4
    800028f4:	9f8080e7          	jalr	-1544(ra) # 800062e8 <virtio_disk_intr>
    800028f8:	b7c5                	j	800028d8 <devintr+0x5e>
    if(cpuid() == 0){
    800028fa:	fffff097          	auipc	ra,0xfffff
    800028fe:	096080e7          	jalr	150(ra) # 80001990 <cpuid>
    80002902:	c901                	beqz	a0,80002912 <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80002904:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80002908:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    8000290a:	14479073          	csrw	sip,a5
    return 2;
    8000290e:	4509                	li	a0,2
    80002910:	b761                	j	80002898 <devintr+0x1e>
      clockintr();
    80002912:	00000097          	auipc	ra,0x0
    80002916:	f22080e7          	jalr	-222(ra) # 80002834 <clockintr>
    8000291a:	b7ed                	j	80002904 <devintr+0x8a>

000000008000291c <usertrap>:
{
    8000291c:	1101                	addi	sp,sp,-32
    8000291e:	ec06                	sd	ra,24(sp)
    80002920:	e822                	sd	s0,16(sp)
    80002922:	e426                	sd	s1,8(sp)
    80002924:	e04a                	sd	s2,0(sp)
    80002926:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002928:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    8000292c:	1007f793          	andi	a5,a5,256
    80002930:	e3b1                	bnez	a5,80002974 <usertrap+0x58>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002932:	00003797          	auipc	a5,0x3
    80002936:	3be78793          	addi	a5,a5,958 # 80005cf0 <kernelvec>
    8000293a:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    8000293e:	fffff097          	auipc	ra,0xfffff
    80002942:	07e080e7          	jalr	126(ra) # 800019bc <myproc>
    80002946:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80002948:	715c                	ld	a5,160(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    8000294a:	14102773          	csrr	a4,sepc
    8000294e:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002950:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80002954:	47a1                	li	a5,8
    80002956:	02f70763          	beq	a4,a5,80002984 <usertrap+0x68>
  } else if((which_dev = devintr()) != 0){
    8000295a:	00000097          	auipc	ra,0x0
    8000295e:	f20080e7          	jalr	-224(ra) # 8000287a <devintr>
    80002962:	892a                	mv	s2,a0
    80002964:	c541                	beqz	a0,800029ec <usertrap+0xd0>
  if(killed(p))
    80002966:	8526                	mv	a0,s1
    80002968:	00000097          	auipc	ra,0x0
    8000296c:	a90080e7          	jalr	-1392(ra) # 800023f8 <killed>
    80002970:	c931                	beqz	a0,800029c4 <usertrap+0xa8>
    80002972:	a099                	j	800029b8 <usertrap+0x9c>
    panic("usertrap: not from user mode");
    80002974:	00006517          	auipc	a0,0x6
    80002978:	9b450513          	addi	a0,a0,-1612 # 80008328 <states.0+0x58>
    8000297c:	ffffe097          	auipc	ra,0xffffe
    80002980:	bc2080e7          	jalr	-1086(ra) # 8000053e <panic>
    if(killed(p))
    80002984:	00000097          	auipc	ra,0x0
    80002988:	a74080e7          	jalr	-1420(ra) # 800023f8 <killed>
    8000298c:	e929                	bnez	a0,800029de <usertrap+0xc2>
    p->trapframe->epc += 4;
    8000298e:	70d8                	ld	a4,160(s1)
    80002990:	6f1c                	ld	a5,24(a4)
    80002992:	0791                	addi	a5,a5,4
    80002994:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002996:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000299a:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000299e:	10079073          	csrw	sstatus,a5
    syscall();
    800029a2:	00000097          	auipc	ra,0x0
    800029a6:	2d8080e7          	jalr	728(ra) # 80002c7a <syscall>
  if(killed(p))
    800029aa:	8526                	mv	a0,s1
    800029ac:	00000097          	auipc	ra,0x0
    800029b0:	a4c080e7          	jalr	-1460(ra) # 800023f8 <killed>
    800029b4:	c919                	beqz	a0,800029ca <usertrap+0xae>
    800029b6:	4901                	li	s2,0
    exit(-1,0);
    800029b8:	4581                	li	a1,0
    800029ba:	557d                	li	a0,-1
    800029bc:	00000097          	auipc	ra,0x0
    800029c0:	8aa080e7          	jalr	-1878(ra) # 80002266 <exit>
  if(which_dev == 2)
    800029c4:	4789                	li	a5,2
    800029c6:	06f90063          	beq	s2,a5,80002a26 <usertrap+0x10a>
  usertrapret();
    800029ca:	00000097          	auipc	ra,0x0
    800029ce:	dd4080e7          	jalr	-556(ra) # 8000279e <usertrapret>
}
    800029d2:	60e2                	ld	ra,24(sp)
    800029d4:	6442                	ld	s0,16(sp)
    800029d6:	64a2                	ld	s1,8(sp)
    800029d8:	6902                	ld	s2,0(sp)
    800029da:	6105                	addi	sp,sp,32
    800029dc:	8082                	ret
      exit(-1,0);
    800029de:	4581                	li	a1,0
    800029e0:	557d                	li	a0,-1
    800029e2:	00000097          	auipc	ra,0x0
    800029e6:	884080e7          	jalr	-1916(ra) # 80002266 <exit>
    800029ea:	b755                	j	8000298e <usertrap+0x72>
  asm volatile("csrr %0, scause" : "=r" (x) );
    800029ec:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    800029f0:	5890                	lw	a2,48(s1)
    800029f2:	00006517          	auipc	a0,0x6
    800029f6:	95650513          	addi	a0,a0,-1706 # 80008348 <states.0+0x78>
    800029fa:	ffffe097          	auipc	ra,0xffffe
    800029fe:	b8e080e7          	jalr	-1138(ra) # 80000588 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002a02:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002a06:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002a0a:	00006517          	auipc	a0,0x6
    80002a0e:	96e50513          	addi	a0,a0,-1682 # 80008378 <states.0+0xa8>
    80002a12:	ffffe097          	auipc	ra,0xffffe
    80002a16:	b76080e7          	jalr	-1162(ra) # 80000588 <printf>
    setkilled(p);
    80002a1a:	8526                	mv	a0,s1
    80002a1c:	00000097          	auipc	ra,0x0
    80002a20:	9b0080e7          	jalr	-1616(ra) # 800023cc <setkilled>
    80002a24:	b759                	j	800029aa <usertrap+0x8e>
    yield();
    80002a26:	fffff097          	auipc	ra,0xfffff
    80002a2a:	6be080e7          	jalr	1726(ra) # 800020e4 <yield>
    80002a2e:	bf71                	j	800029ca <usertrap+0xae>

0000000080002a30 <kerneltrap>:
{
    80002a30:	7179                	addi	sp,sp,-48
    80002a32:	f406                	sd	ra,40(sp)
    80002a34:	f022                	sd	s0,32(sp)
    80002a36:	ec26                	sd	s1,24(sp)
    80002a38:	e84a                	sd	s2,16(sp)
    80002a3a:	e44e                	sd	s3,8(sp)
    80002a3c:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002a3e:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002a42:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002a46:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80002a4a:	1004f793          	andi	a5,s1,256
    80002a4e:	cb85                	beqz	a5,80002a7e <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002a50:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80002a54:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80002a56:	ef85                	bnez	a5,80002a8e <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80002a58:	00000097          	auipc	ra,0x0
    80002a5c:	e22080e7          	jalr	-478(ra) # 8000287a <devintr>
    80002a60:	cd1d                	beqz	a0,80002a9e <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002a62:	4789                	li	a5,2
    80002a64:	06f50a63          	beq	a0,a5,80002ad8 <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80002a68:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002a6c:	10049073          	csrw	sstatus,s1
}
    80002a70:	70a2                	ld	ra,40(sp)
    80002a72:	7402                	ld	s0,32(sp)
    80002a74:	64e2                	ld	s1,24(sp)
    80002a76:	6942                	ld	s2,16(sp)
    80002a78:	69a2                	ld	s3,8(sp)
    80002a7a:	6145                	addi	sp,sp,48
    80002a7c:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80002a7e:	00006517          	auipc	a0,0x6
    80002a82:	91a50513          	addi	a0,a0,-1766 # 80008398 <states.0+0xc8>
    80002a86:	ffffe097          	auipc	ra,0xffffe
    80002a8a:	ab8080e7          	jalr	-1352(ra) # 8000053e <panic>
    panic("kerneltrap: interrupts enabled");
    80002a8e:	00006517          	auipc	a0,0x6
    80002a92:	93250513          	addi	a0,a0,-1742 # 800083c0 <states.0+0xf0>
    80002a96:	ffffe097          	auipc	ra,0xffffe
    80002a9a:	aa8080e7          	jalr	-1368(ra) # 8000053e <panic>
    printf("scause %p\n", scause);
    80002a9e:	85ce                	mv	a1,s3
    80002aa0:	00006517          	auipc	a0,0x6
    80002aa4:	94050513          	addi	a0,a0,-1728 # 800083e0 <states.0+0x110>
    80002aa8:	ffffe097          	auipc	ra,0xffffe
    80002aac:	ae0080e7          	jalr	-1312(ra) # 80000588 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002ab0:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002ab4:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002ab8:	00006517          	auipc	a0,0x6
    80002abc:	93850513          	addi	a0,a0,-1736 # 800083f0 <states.0+0x120>
    80002ac0:	ffffe097          	auipc	ra,0xffffe
    80002ac4:	ac8080e7          	jalr	-1336(ra) # 80000588 <printf>
    panic("kerneltrap");
    80002ac8:	00006517          	auipc	a0,0x6
    80002acc:	94050513          	addi	a0,a0,-1728 # 80008408 <states.0+0x138>
    80002ad0:	ffffe097          	auipc	ra,0xffffe
    80002ad4:	a6e080e7          	jalr	-1426(ra) # 8000053e <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002ad8:	fffff097          	auipc	ra,0xfffff
    80002adc:	ee4080e7          	jalr	-284(ra) # 800019bc <myproc>
    80002ae0:	d541                	beqz	a0,80002a68 <kerneltrap+0x38>
    80002ae2:	fffff097          	auipc	ra,0xfffff
    80002ae6:	eda080e7          	jalr	-294(ra) # 800019bc <myproc>
    80002aea:	4d18                	lw	a4,24(a0)
    80002aec:	4791                	li	a5,4
    80002aee:	f6f71de3          	bne	a4,a5,80002a68 <kerneltrap+0x38>
    yield();
    80002af2:	fffff097          	auipc	ra,0xfffff
    80002af6:	5f2080e7          	jalr	1522(ra) # 800020e4 <yield>
    80002afa:	b7bd                	j	80002a68 <kerneltrap+0x38>

0000000080002afc <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80002afc:	1101                	addi	sp,sp,-32
    80002afe:	ec06                	sd	ra,24(sp)
    80002b00:	e822                	sd	s0,16(sp)
    80002b02:	e426                	sd	s1,8(sp)
    80002b04:	1000                	addi	s0,sp,32
    80002b06:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80002b08:	fffff097          	auipc	ra,0xfffff
    80002b0c:	eb4080e7          	jalr	-332(ra) # 800019bc <myproc>
  switch (n) {
    80002b10:	4795                	li	a5,5
    80002b12:	0497e163          	bltu	a5,s1,80002b54 <argraw+0x58>
    80002b16:	048a                	slli	s1,s1,0x2
    80002b18:	00006717          	auipc	a4,0x6
    80002b1c:	92870713          	addi	a4,a4,-1752 # 80008440 <states.0+0x170>
    80002b20:	94ba                	add	s1,s1,a4
    80002b22:	409c                	lw	a5,0(s1)
    80002b24:	97ba                	add	a5,a5,a4
    80002b26:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80002b28:	715c                	ld	a5,160(a0)
    80002b2a:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80002b2c:	60e2                	ld	ra,24(sp)
    80002b2e:	6442                	ld	s0,16(sp)
    80002b30:	64a2                	ld	s1,8(sp)
    80002b32:	6105                	addi	sp,sp,32
    80002b34:	8082                	ret
    return p->trapframe->a1;
    80002b36:	715c                	ld	a5,160(a0)
    80002b38:	7fa8                	ld	a0,120(a5)
    80002b3a:	bfcd                	j	80002b2c <argraw+0x30>
    return p->trapframe->a2;
    80002b3c:	715c                	ld	a5,160(a0)
    80002b3e:	63c8                	ld	a0,128(a5)
    80002b40:	b7f5                	j	80002b2c <argraw+0x30>
    return p->trapframe->a3;
    80002b42:	715c                	ld	a5,160(a0)
    80002b44:	67c8                	ld	a0,136(a5)
    80002b46:	b7dd                	j	80002b2c <argraw+0x30>
    return p->trapframe->a4;
    80002b48:	715c                	ld	a5,160(a0)
    80002b4a:	6bc8                	ld	a0,144(a5)
    80002b4c:	b7c5                	j	80002b2c <argraw+0x30>
    return p->trapframe->a5;
    80002b4e:	715c                	ld	a5,160(a0)
    80002b50:	6fc8                	ld	a0,152(a5)
    80002b52:	bfe9                	j	80002b2c <argraw+0x30>
  panic("argraw");
    80002b54:	00006517          	auipc	a0,0x6
    80002b58:	8c450513          	addi	a0,a0,-1852 # 80008418 <states.0+0x148>
    80002b5c:	ffffe097          	auipc	ra,0xffffe
    80002b60:	9e2080e7          	jalr	-1566(ra) # 8000053e <panic>

0000000080002b64 <fetchaddr>:
{
    80002b64:	1101                	addi	sp,sp,-32
    80002b66:	ec06                	sd	ra,24(sp)
    80002b68:	e822                	sd	s0,16(sp)
    80002b6a:	e426                	sd	s1,8(sp)
    80002b6c:	e04a                	sd	s2,0(sp)
    80002b6e:	1000                	addi	s0,sp,32
    80002b70:	84aa                	mv	s1,a0
    80002b72:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80002b74:	fffff097          	auipc	ra,0xfffff
    80002b78:	e48080e7          	jalr	-440(ra) # 800019bc <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    80002b7c:	695c                	ld	a5,144(a0)
    80002b7e:	02f4f863          	bgeu	s1,a5,80002bae <fetchaddr+0x4a>
    80002b82:	00848713          	addi	a4,s1,8
    80002b86:	02e7e663          	bltu	a5,a4,80002bb2 <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80002b8a:	46a1                	li	a3,8
    80002b8c:	8626                	mv	a2,s1
    80002b8e:	85ca                	mv	a1,s2
    80002b90:	6d48                	ld	a0,152(a0)
    80002b92:	fffff097          	auipc	ra,0xfffff
    80002b96:	b64080e7          	jalr	-1180(ra) # 800016f6 <copyin>
    80002b9a:	00a03533          	snez	a0,a0
    80002b9e:	40a00533          	neg	a0,a0
}
    80002ba2:	60e2                	ld	ra,24(sp)
    80002ba4:	6442                	ld	s0,16(sp)
    80002ba6:	64a2                	ld	s1,8(sp)
    80002ba8:	6902                	ld	s2,0(sp)
    80002baa:	6105                	addi	sp,sp,32
    80002bac:	8082                	ret
    return -1;
    80002bae:	557d                	li	a0,-1
    80002bb0:	bfcd                	j	80002ba2 <fetchaddr+0x3e>
    80002bb2:	557d                	li	a0,-1
    80002bb4:	b7fd                	j	80002ba2 <fetchaddr+0x3e>

0000000080002bb6 <fetchstr>:
{
    80002bb6:	7179                	addi	sp,sp,-48
    80002bb8:	f406                	sd	ra,40(sp)
    80002bba:	f022                	sd	s0,32(sp)
    80002bbc:	ec26                	sd	s1,24(sp)
    80002bbe:	e84a                	sd	s2,16(sp)
    80002bc0:	e44e                	sd	s3,8(sp)
    80002bc2:	1800                	addi	s0,sp,48
    80002bc4:	892a                	mv	s2,a0
    80002bc6:	84ae                	mv	s1,a1
    80002bc8:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80002bca:	fffff097          	auipc	ra,0xfffff
    80002bce:	df2080e7          	jalr	-526(ra) # 800019bc <myproc>
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    80002bd2:	86ce                	mv	a3,s3
    80002bd4:	864a                	mv	a2,s2
    80002bd6:	85a6                	mv	a1,s1
    80002bd8:	6d48                	ld	a0,152(a0)
    80002bda:	fffff097          	auipc	ra,0xfffff
    80002bde:	baa080e7          	jalr	-1110(ra) # 80001784 <copyinstr>
    80002be2:	00054e63          	bltz	a0,80002bfe <fetchstr+0x48>
  return strlen(buf);
    80002be6:	8526                	mv	a0,s1
    80002be8:	ffffe097          	auipc	ra,0xffffe
    80002bec:	266080e7          	jalr	614(ra) # 80000e4e <strlen>
}
    80002bf0:	70a2                	ld	ra,40(sp)
    80002bf2:	7402                	ld	s0,32(sp)
    80002bf4:	64e2                	ld	s1,24(sp)
    80002bf6:	6942                	ld	s2,16(sp)
    80002bf8:	69a2                	ld	s3,8(sp)
    80002bfa:	6145                	addi	sp,sp,48
    80002bfc:	8082                	ret
    return -1;
    80002bfe:	557d                	li	a0,-1
    80002c00:	bfc5                	j	80002bf0 <fetchstr+0x3a>

0000000080002c02 <argint>:

// Fetch the nth 32-bit system call argument.
void
argint(int n, int *ip)
{
    80002c02:	1101                	addi	sp,sp,-32
    80002c04:	ec06                	sd	ra,24(sp)
    80002c06:	e822                	sd	s0,16(sp)
    80002c08:	e426                	sd	s1,8(sp)
    80002c0a:	1000                	addi	s0,sp,32
    80002c0c:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002c0e:	00000097          	auipc	ra,0x0
    80002c12:	eee080e7          	jalr	-274(ra) # 80002afc <argraw>
    80002c16:	c088                	sw	a0,0(s1)
}
    80002c18:	60e2                	ld	ra,24(sp)
    80002c1a:	6442                	ld	s0,16(sp)
    80002c1c:	64a2                	ld	s1,8(sp)
    80002c1e:	6105                	addi	sp,sp,32
    80002c20:	8082                	ret

0000000080002c22 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr(int n, uint64 *ip)
{
    80002c22:	1101                	addi	sp,sp,-32
    80002c24:	ec06                	sd	ra,24(sp)
    80002c26:	e822                	sd	s0,16(sp)
    80002c28:	e426                	sd	s1,8(sp)
    80002c2a:	1000                	addi	s0,sp,32
    80002c2c:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002c2e:	00000097          	auipc	ra,0x0
    80002c32:	ece080e7          	jalr	-306(ra) # 80002afc <argraw>
    80002c36:	e088                	sd	a0,0(s1)
}
    80002c38:	60e2                	ld	ra,24(sp)
    80002c3a:	6442                	ld	s0,16(sp)
    80002c3c:	64a2                	ld	s1,8(sp)
    80002c3e:	6105                	addi	sp,sp,32
    80002c40:	8082                	ret

0000000080002c42 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80002c42:	7179                	addi	sp,sp,-48
    80002c44:	f406                	sd	ra,40(sp)
    80002c46:	f022                	sd	s0,32(sp)
    80002c48:	ec26                	sd	s1,24(sp)
    80002c4a:	e84a                	sd	s2,16(sp)
    80002c4c:	1800                	addi	s0,sp,48
    80002c4e:	84ae                	mv	s1,a1
    80002c50:	8932                	mv	s2,a2
  uint64 addr;
  argaddr(n, &addr);
    80002c52:	fd840593          	addi	a1,s0,-40
    80002c56:	00000097          	auipc	ra,0x0
    80002c5a:	fcc080e7          	jalr	-52(ra) # 80002c22 <argaddr>
  return fetchstr(addr, buf, max);
    80002c5e:	864a                	mv	a2,s2
    80002c60:	85a6                	mv	a1,s1
    80002c62:	fd843503          	ld	a0,-40(s0)
    80002c66:	00000097          	auipc	ra,0x0
    80002c6a:	f50080e7          	jalr	-176(ra) # 80002bb6 <fetchstr>
}
    80002c6e:	70a2                	ld	ra,40(sp)
    80002c70:	7402                	ld	s0,32(sp)
    80002c72:	64e2                	ld	s1,24(sp)
    80002c74:	6942                	ld	s2,16(sp)
    80002c76:	6145                	addi	sp,sp,48
    80002c78:	8082                	ret

0000000080002c7a <syscall>:
//   [SYS_set_cfs_priority]   sys_set_cfs_priority,
// };

void
syscall(void)
{
    80002c7a:	1101                	addi	sp,sp,-32
    80002c7c:	ec06                	sd	ra,24(sp)
    80002c7e:	e822                	sd	s0,16(sp)
    80002c80:	e426                	sd	s1,8(sp)
    80002c82:	e04a                	sd	s2,0(sp)
    80002c84:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80002c86:	fffff097          	auipc	ra,0xfffff
    80002c8a:	d36080e7          	jalr	-714(ra) # 800019bc <myproc>
    80002c8e:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80002c90:	0a053903          	ld	s2,160(a0)
    80002c94:	0a893783          	ld	a5,168(s2)
    80002c98:	0007869b          	sext.w	a3,a5


  // if (num ==23 | num == 24){
    if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002c9c:	37fd                	addiw	a5,a5,-1
    80002c9e:	4755                	li	a4,21
    80002ca0:	00f76f63          	bltu	a4,a5,80002cbe <syscall+0x44>
    80002ca4:	00369713          	slli	a4,a3,0x3
    80002ca8:	00005797          	auipc	a5,0x5
    80002cac:	7b078793          	addi	a5,a5,1968 # 80008458 <syscalls>
    80002cb0:	97ba                	add	a5,a5,a4
    80002cb2:	639c                	ld	a5,0(a5)
    80002cb4:	c789                	beqz	a5,80002cbe <syscall+0x44>
      // Use num to lookup the system call function for num, call it,
      // and store its return value in p->trapframe->a0
      p->trapframe->a0 = syscalls[num]();
    80002cb6:	9782                	jalr	a5
    80002cb8:	06a93823          	sd	a0,112(s2)
    80002cbc:	a839                	j	80002cda <syscall+0x60>
    } else {
      printf("%d %s: unknown sys call %d\n",
    80002cbe:	1a048613          	addi	a2,s1,416
    80002cc2:	588c                	lw	a1,48(s1)
    80002cc4:	00005517          	auipc	a0,0x5
    80002cc8:	75c50513          	addi	a0,a0,1884 # 80008420 <states.0+0x150>
    80002ccc:	ffffe097          	auipc	ra,0xffffe
    80002cd0:	8bc080e7          	jalr	-1860(ra) # 80000588 <printf>
              p->pid, p->name, num);
      p->trapframe->a0 = -1;
    80002cd4:	70dc                	ld	a5,160(s1)
    80002cd6:	577d                	li	a4,-1
    80002cd8:	fbb8                	sd	a4,112(a5)
  //     printf("%d %s: unknown sys call %d\n",
  //             p->pid, p->name, num);
  //     p->trapframe->a0 = -1;
  //   }
  // }
}
    80002cda:	60e2                	ld	ra,24(sp)
    80002cdc:	6442                	ld	s0,16(sp)
    80002cde:	64a2                	ld	s1,8(sp)
    80002ce0:	6902                	ld	s2,0(sp)
    80002ce2:	6105                	addi	sp,sp,32
    80002ce4:	8082                	ret

0000000080002ce6 <sys_exit>:
#include "proc.h"


uint64
sys_exit(void)
{
    80002ce6:	7139                	addi	sp,sp,-64
    80002ce8:	fc06                	sd	ra,56(sp)
    80002cea:	f822                	sd	s0,48(sp)
    80002cec:	0080                	addi	s0,sp,64
  int n;
  argint(0, &n);
    80002cee:	fec40593          	addi	a1,s0,-20
    80002cf2:	4501                	li	a0,0
    80002cf4:	00000097          	auipc	ra,0x0
    80002cf8:	f0e080e7          	jalr	-242(ra) # 80002c02 <argint>
  char buff[32];
  argstr(1, buff, 32);
    80002cfc:	02000613          	li	a2,32
    80002d00:	fc840593          	addi	a1,s0,-56
    80002d04:	4505                	li	a0,1
    80002d06:	00000097          	auipc	ra,0x0
    80002d0a:	f3c080e7          	jalr	-196(ra) # 80002c42 <argstr>
  exit(n, buff);
    80002d0e:	fc840593          	addi	a1,s0,-56
    80002d12:	fec42503          	lw	a0,-20(s0)
    80002d16:	fffff097          	auipc	ra,0xfffff
    80002d1a:	550080e7          	jalr	1360(ra) # 80002266 <exit>
  return 0;  // not reached
}
    80002d1e:	4501                	li	a0,0
    80002d20:	70e2                	ld	ra,56(sp)
    80002d22:	7442                	ld	s0,48(sp)
    80002d24:	6121                	addi	sp,sp,64
    80002d26:	8082                	ret

0000000080002d28 <sys_getpid>:

uint64
sys_getpid(void)
{
    80002d28:	1141                	addi	sp,sp,-16
    80002d2a:	e406                	sd	ra,8(sp)
    80002d2c:	e022                	sd	s0,0(sp)
    80002d2e:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80002d30:	fffff097          	auipc	ra,0xfffff
    80002d34:	c8c080e7          	jalr	-884(ra) # 800019bc <myproc>
}
    80002d38:	5908                	lw	a0,48(a0)
    80002d3a:	60a2                	ld	ra,8(sp)
    80002d3c:	6402                	ld	s0,0(sp)
    80002d3e:	0141                	addi	sp,sp,16
    80002d40:	8082                	ret

0000000080002d42 <sys_fork>:

uint64
sys_fork(void)
{
    80002d42:	1141                	addi	sp,sp,-16
    80002d44:	e406                	sd	ra,8(sp)
    80002d46:	e022                	sd	s0,0(sp)
    80002d48:	0800                	addi	s0,sp,16
  return fork();
    80002d4a:	fffff097          	auipc	ra,0xfffff
    80002d4e:	08a080e7          	jalr	138(ra) # 80001dd4 <fork>
}
    80002d52:	60a2                	ld	ra,8(sp)
    80002d54:	6402                	ld	s0,0(sp)
    80002d56:	0141                	addi	sp,sp,16
    80002d58:	8082                	ret

0000000080002d5a <sys_wait>:

uint64
sys_wait(void)
{
    80002d5a:	7139                	addi	sp,sp,-64
    80002d5c:	fc06                	sd	ra,56(sp)
    80002d5e:	f822                	sd	s0,48(sp)
    80002d60:	0080                	addi	s0,sp,64
  uint64 p;
  argaddr(0, &p);
    80002d62:	fe840593          	addi	a1,s0,-24
    80002d66:	4501                	li	a0,0
    80002d68:	00000097          	auipc	ra,0x0
    80002d6c:	eba080e7          	jalr	-326(ra) # 80002c22 <argaddr>
  char buff[32];
  argstr(1, buff, 32);
    80002d70:	02000613          	li	a2,32
    80002d74:	fc840593          	addi	a1,s0,-56
    80002d78:	4505                	li	a0,1
    80002d7a:	00000097          	auipc	ra,0x0
    80002d7e:	ec8080e7          	jalr	-312(ra) # 80002c42 <argstr>
  return wait(p, buff);
    80002d82:	fc840593          	addi	a1,s0,-56
    80002d86:	fe843503          	ld	a0,-24(s0)
    80002d8a:	fffff097          	auipc	ra,0xfffff
    80002d8e:	6a0080e7          	jalr	1696(ra) # 8000242a <wait>
} 
    80002d92:	70e2                	ld	ra,56(sp)
    80002d94:	7442                	ld	s0,48(sp)
    80002d96:	6121                	addi	sp,sp,64
    80002d98:	8082                	ret

0000000080002d9a <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80002d9a:	7179                	addi	sp,sp,-48
    80002d9c:	f406                	sd	ra,40(sp)
    80002d9e:	f022                	sd	s0,32(sp)
    80002da0:	ec26                	sd	s1,24(sp)
    80002da2:	1800                	addi	s0,sp,48
  uint64 addr;
  int n;

  argint(0, &n);
    80002da4:	fdc40593          	addi	a1,s0,-36
    80002da8:	4501                	li	a0,0
    80002daa:	00000097          	auipc	ra,0x0
    80002dae:	e58080e7          	jalr	-424(ra) # 80002c02 <argint>
  addr = myproc()->sz;
    80002db2:	fffff097          	auipc	ra,0xfffff
    80002db6:	c0a080e7          	jalr	-1014(ra) # 800019bc <myproc>
    80002dba:	6944                	ld	s1,144(a0)
  if(growproc(n) < 0)
    80002dbc:	fdc42503          	lw	a0,-36(s0)
    80002dc0:	fffff097          	auipc	ra,0xfffff
    80002dc4:	f5e080e7          	jalr	-162(ra) # 80001d1e <growproc>
    80002dc8:	00054863          	bltz	a0,80002dd8 <sys_sbrk+0x3e>
    return -1;
  return addr;
}
    80002dcc:	8526                	mv	a0,s1
    80002dce:	70a2                	ld	ra,40(sp)
    80002dd0:	7402                	ld	s0,32(sp)
    80002dd2:	64e2                	ld	s1,24(sp)
    80002dd4:	6145                	addi	sp,sp,48
    80002dd6:	8082                	ret
    return -1;
    80002dd8:	54fd                	li	s1,-1
    80002dda:	bfcd                	j	80002dcc <sys_sbrk+0x32>

0000000080002ddc <sys_sleep>:

uint64
sys_sleep(void)
{
    80002ddc:	7139                	addi	sp,sp,-64
    80002dde:	fc06                	sd	ra,56(sp)
    80002de0:	f822                	sd	s0,48(sp)
    80002de2:	f426                	sd	s1,40(sp)
    80002de4:	f04a                	sd	s2,32(sp)
    80002de6:	ec4e                	sd	s3,24(sp)
    80002de8:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  argint(0, &n);
    80002dea:	fcc40593          	addi	a1,s0,-52
    80002dee:	4501                	li	a0,0
    80002df0:	00000097          	auipc	ra,0x0
    80002df4:	e12080e7          	jalr	-494(ra) # 80002c02 <argint>
  acquire(&tickslock);
    80002df8:	00015517          	auipc	a0,0x15
    80002dfc:	d9850513          	addi	a0,a0,-616 # 80017b90 <tickslock>
    80002e00:	ffffe097          	auipc	ra,0xffffe
    80002e04:	dd6080e7          	jalr	-554(ra) # 80000bd6 <acquire>
  ticks0 = ticks;
    80002e08:	00006917          	auipc	s2,0x6
    80002e0c:	ae892903          	lw	s2,-1304(s2) # 800088f0 <ticks>
  while(ticks - ticks0 < n){
    80002e10:	fcc42783          	lw	a5,-52(s0)
    80002e14:	cf9d                	beqz	a5,80002e52 <sys_sleep+0x76>
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80002e16:	00015997          	auipc	s3,0x15
    80002e1a:	d7a98993          	addi	s3,s3,-646 # 80017b90 <tickslock>
    80002e1e:	00006497          	auipc	s1,0x6
    80002e22:	ad248493          	addi	s1,s1,-1326 # 800088f0 <ticks>
    if(killed(myproc())){
    80002e26:	fffff097          	auipc	ra,0xfffff
    80002e2a:	b96080e7          	jalr	-1130(ra) # 800019bc <myproc>
    80002e2e:	fffff097          	auipc	ra,0xfffff
    80002e32:	5ca080e7          	jalr	1482(ra) # 800023f8 <killed>
    80002e36:	ed15                	bnez	a0,80002e72 <sys_sleep+0x96>
    sleep(&ticks, &tickslock);
    80002e38:	85ce                	mv	a1,s3
    80002e3a:	8526                	mv	a0,s1
    80002e3c:	fffff097          	auipc	ra,0xfffff
    80002e40:	2ec080e7          	jalr	748(ra) # 80002128 <sleep>
  while(ticks - ticks0 < n){
    80002e44:	409c                	lw	a5,0(s1)
    80002e46:	412787bb          	subw	a5,a5,s2
    80002e4a:	fcc42703          	lw	a4,-52(s0)
    80002e4e:	fce7ece3          	bltu	a5,a4,80002e26 <sys_sleep+0x4a>
  }
  release(&tickslock);
    80002e52:	00015517          	auipc	a0,0x15
    80002e56:	d3e50513          	addi	a0,a0,-706 # 80017b90 <tickslock>
    80002e5a:	ffffe097          	auipc	ra,0xffffe
    80002e5e:	e30080e7          	jalr	-464(ra) # 80000c8a <release>
  return 0;
    80002e62:	4501                	li	a0,0
}
    80002e64:	70e2                	ld	ra,56(sp)
    80002e66:	7442                	ld	s0,48(sp)
    80002e68:	74a2                	ld	s1,40(sp)
    80002e6a:	7902                	ld	s2,32(sp)
    80002e6c:	69e2                	ld	s3,24(sp)
    80002e6e:	6121                	addi	sp,sp,64
    80002e70:	8082                	ret
      release(&tickslock);
    80002e72:	00015517          	auipc	a0,0x15
    80002e76:	d1e50513          	addi	a0,a0,-738 # 80017b90 <tickslock>
    80002e7a:	ffffe097          	auipc	ra,0xffffe
    80002e7e:	e10080e7          	jalr	-496(ra) # 80000c8a <release>
      return -1;
    80002e82:	557d                	li	a0,-1
    80002e84:	b7c5                	j	80002e64 <sys_sleep+0x88>

0000000080002e86 <sys_kill>:

uint64
sys_kill(void)
{
    80002e86:	1101                	addi	sp,sp,-32
    80002e88:	ec06                	sd	ra,24(sp)
    80002e8a:	e822                	sd	s0,16(sp)
    80002e8c:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    80002e8e:	fec40593          	addi	a1,s0,-20
    80002e92:	4501                	li	a0,0
    80002e94:	00000097          	auipc	ra,0x0
    80002e98:	d6e080e7          	jalr	-658(ra) # 80002c02 <argint>
  return kill(pid);
    80002e9c:	fec42503          	lw	a0,-20(s0)
    80002ea0:	fffff097          	auipc	ra,0xfffff
    80002ea4:	4b2080e7          	jalr	1202(ra) # 80002352 <kill>
}
    80002ea8:	60e2                	ld	ra,24(sp)
    80002eaa:	6442                	ld	s0,16(sp)
    80002eac:	6105                	addi	sp,sp,32
    80002eae:	8082                	ret

0000000080002eb0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80002eb0:	1101                	addi	sp,sp,-32
    80002eb2:	ec06                	sd	ra,24(sp)
    80002eb4:	e822                	sd	s0,16(sp)
    80002eb6:	e426                	sd	s1,8(sp)
    80002eb8:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80002eba:	00015517          	auipc	a0,0x15
    80002ebe:	cd650513          	addi	a0,a0,-810 # 80017b90 <tickslock>
    80002ec2:	ffffe097          	auipc	ra,0xffffe
    80002ec6:	d14080e7          	jalr	-748(ra) # 80000bd6 <acquire>
  xticks = ticks;
    80002eca:	00006497          	auipc	s1,0x6
    80002ece:	a264a483          	lw	s1,-1498(s1) # 800088f0 <ticks>
  release(&tickslock);
    80002ed2:	00015517          	auipc	a0,0x15
    80002ed6:	cbe50513          	addi	a0,a0,-834 # 80017b90 <tickslock>
    80002eda:	ffffe097          	auipc	ra,0xffffe
    80002ede:	db0080e7          	jalr	-592(ra) # 80000c8a <release>
  return xticks;
}
    80002ee2:	02049513          	slli	a0,s1,0x20
    80002ee6:	9101                	srli	a0,a0,0x20
    80002ee8:	60e2                	ld	ra,24(sp)
    80002eea:	6442                	ld	s0,16(sp)
    80002eec:	64a2                	ld	s1,8(sp)
    80002eee:	6105                	addi	sp,sp,32
    80002ef0:	8082                	ret

0000000080002ef2 <sys_memsize>:

uint64
sys_memsize(void){
    80002ef2:	1141                	addi	sp,sp,-16
    80002ef4:	e406                	sd	ra,8(sp)
    80002ef6:	e022                	sd	s0,0(sp)
    80002ef8:	0800                	addi	s0,sp,16
  return myproc()->sz;;
    80002efa:	fffff097          	auipc	ra,0xfffff
    80002efe:	ac2080e7          	jalr	-1342(ra) # 800019bc <myproc>
}
    80002f02:	6948                	ld	a0,144(a0)
    80002f04:	60a2                	ld	ra,8(sp)
    80002f06:	6402                	ld	s0,0(sp)
    80002f08:	0141                	addi	sp,sp,16
    80002f0a:	8082                	ret

0000000080002f0c <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80002f0c:	7179                	addi	sp,sp,-48
    80002f0e:	f406                	sd	ra,40(sp)
    80002f10:	f022                	sd	s0,32(sp)
    80002f12:	ec26                	sd	s1,24(sp)
    80002f14:	e84a                	sd	s2,16(sp)
    80002f16:	e44e                	sd	s3,8(sp)
    80002f18:	e052                	sd	s4,0(sp)
    80002f1a:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80002f1c:	00005597          	auipc	a1,0x5
    80002f20:	5f458593          	addi	a1,a1,1524 # 80008510 <syscalls+0xb8>
    80002f24:	00015517          	auipc	a0,0x15
    80002f28:	c8450513          	addi	a0,a0,-892 # 80017ba8 <bcache>
    80002f2c:	ffffe097          	auipc	ra,0xffffe
    80002f30:	c1a080e7          	jalr	-998(ra) # 80000b46 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80002f34:	0001d797          	auipc	a5,0x1d
    80002f38:	c7478793          	addi	a5,a5,-908 # 8001fba8 <bcache+0x8000>
    80002f3c:	0001d717          	auipc	a4,0x1d
    80002f40:	ed470713          	addi	a4,a4,-300 # 8001fe10 <bcache+0x8268>
    80002f44:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    80002f48:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002f4c:	00015497          	auipc	s1,0x15
    80002f50:	c7448493          	addi	s1,s1,-908 # 80017bc0 <bcache+0x18>
    b->next = bcache.head.next;
    80002f54:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80002f56:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80002f58:	00005a17          	auipc	s4,0x5
    80002f5c:	5c0a0a13          	addi	s4,s4,1472 # 80008518 <syscalls+0xc0>
    b->next = bcache.head.next;
    80002f60:	2b893783          	ld	a5,696(s2)
    80002f64:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80002f66:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80002f6a:	85d2                	mv	a1,s4
    80002f6c:	01048513          	addi	a0,s1,16
    80002f70:	00001097          	auipc	ra,0x1
    80002f74:	4c4080e7          	jalr	1220(ra) # 80004434 <initsleeplock>
    bcache.head.next->prev = b;
    80002f78:	2b893783          	ld	a5,696(s2)
    80002f7c:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80002f7e:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002f82:	45848493          	addi	s1,s1,1112
    80002f86:	fd349de3          	bne	s1,s3,80002f60 <binit+0x54>
  }
}
    80002f8a:	70a2                	ld	ra,40(sp)
    80002f8c:	7402                	ld	s0,32(sp)
    80002f8e:	64e2                	ld	s1,24(sp)
    80002f90:	6942                	ld	s2,16(sp)
    80002f92:	69a2                	ld	s3,8(sp)
    80002f94:	6a02                	ld	s4,0(sp)
    80002f96:	6145                	addi	sp,sp,48
    80002f98:	8082                	ret

0000000080002f9a <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80002f9a:	7179                	addi	sp,sp,-48
    80002f9c:	f406                	sd	ra,40(sp)
    80002f9e:	f022                	sd	s0,32(sp)
    80002fa0:	ec26                	sd	s1,24(sp)
    80002fa2:	e84a                	sd	s2,16(sp)
    80002fa4:	e44e                	sd	s3,8(sp)
    80002fa6:	1800                	addi	s0,sp,48
    80002fa8:	892a                	mv	s2,a0
    80002faa:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    80002fac:	00015517          	auipc	a0,0x15
    80002fb0:	bfc50513          	addi	a0,a0,-1028 # 80017ba8 <bcache>
    80002fb4:	ffffe097          	auipc	ra,0xffffe
    80002fb8:	c22080e7          	jalr	-990(ra) # 80000bd6 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80002fbc:	0001d497          	auipc	s1,0x1d
    80002fc0:	ea44b483          	ld	s1,-348(s1) # 8001fe60 <bcache+0x82b8>
    80002fc4:	0001d797          	auipc	a5,0x1d
    80002fc8:	e4c78793          	addi	a5,a5,-436 # 8001fe10 <bcache+0x8268>
    80002fcc:	02f48f63          	beq	s1,a5,8000300a <bread+0x70>
    80002fd0:	873e                	mv	a4,a5
    80002fd2:	a021                	j	80002fda <bread+0x40>
    80002fd4:	68a4                	ld	s1,80(s1)
    80002fd6:	02e48a63          	beq	s1,a4,8000300a <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    80002fda:	449c                	lw	a5,8(s1)
    80002fdc:	ff279ce3          	bne	a5,s2,80002fd4 <bread+0x3a>
    80002fe0:	44dc                	lw	a5,12(s1)
    80002fe2:	ff3799e3          	bne	a5,s3,80002fd4 <bread+0x3a>
      b->refcnt++;
    80002fe6:	40bc                	lw	a5,64(s1)
    80002fe8:	2785                	addiw	a5,a5,1
    80002fea:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002fec:	00015517          	auipc	a0,0x15
    80002ff0:	bbc50513          	addi	a0,a0,-1092 # 80017ba8 <bcache>
    80002ff4:	ffffe097          	auipc	ra,0xffffe
    80002ff8:	c96080e7          	jalr	-874(ra) # 80000c8a <release>
      acquiresleep(&b->lock);
    80002ffc:	01048513          	addi	a0,s1,16
    80003000:	00001097          	auipc	ra,0x1
    80003004:	46e080e7          	jalr	1134(ra) # 8000446e <acquiresleep>
      return b;
    80003008:	a8b9                	j	80003066 <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    8000300a:	0001d497          	auipc	s1,0x1d
    8000300e:	e4e4b483          	ld	s1,-434(s1) # 8001fe58 <bcache+0x82b0>
    80003012:	0001d797          	auipc	a5,0x1d
    80003016:	dfe78793          	addi	a5,a5,-514 # 8001fe10 <bcache+0x8268>
    8000301a:	00f48863          	beq	s1,a5,8000302a <bread+0x90>
    8000301e:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    80003020:	40bc                	lw	a5,64(s1)
    80003022:	cf81                	beqz	a5,8000303a <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80003024:	64a4                	ld	s1,72(s1)
    80003026:	fee49de3          	bne	s1,a4,80003020 <bread+0x86>
  panic("bget: no buffers");
    8000302a:	00005517          	auipc	a0,0x5
    8000302e:	4f650513          	addi	a0,a0,1270 # 80008520 <syscalls+0xc8>
    80003032:	ffffd097          	auipc	ra,0xffffd
    80003036:	50c080e7          	jalr	1292(ra) # 8000053e <panic>
      b->dev = dev;
    8000303a:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    8000303e:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    80003042:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80003046:	4785                	li	a5,1
    80003048:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    8000304a:	00015517          	auipc	a0,0x15
    8000304e:	b5e50513          	addi	a0,a0,-1186 # 80017ba8 <bcache>
    80003052:	ffffe097          	auipc	ra,0xffffe
    80003056:	c38080e7          	jalr	-968(ra) # 80000c8a <release>
      acquiresleep(&b->lock);
    8000305a:	01048513          	addi	a0,s1,16
    8000305e:	00001097          	auipc	ra,0x1
    80003062:	410080e7          	jalr	1040(ra) # 8000446e <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80003066:	409c                	lw	a5,0(s1)
    80003068:	cb89                	beqz	a5,8000307a <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    8000306a:	8526                	mv	a0,s1
    8000306c:	70a2                	ld	ra,40(sp)
    8000306e:	7402                	ld	s0,32(sp)
    80003070:	64e2                	ld	s1,24(sp)
    80003072:	6942                	ld	s2,16(sp)
    80003074:	69a2                	ld	s3,8(sp)
    80003076:	6145                	addi	sp,sp,48
    80003078:	8082                	ret
    virtio_disk_rw(b, 0);
    8000307a:	4581                	li	a1,0
    8000307c:	8526                	mv	a0,s1
    8000307e:	00003097          	auipc	ra,0x3
    80003082:	036080e7          	jalr	54(ra) # 800060b4 <virtio_disk_rw>
    b->valid = 1;
    80003086:	4785                	li	a5,1
    80003088:	c09c                	sw	a5,0(s1)
  return b;
    8000308a:	b7c5                	j	8000306a <bread+0xd0>

000000008000308c <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    8000308c:	1101                	addi	sp,sp,-32
    8000308e:	ec06                	sd	ra,24(sp)
    80003090:	e822                	sd	s0,16(sp)
    80003092:	e426                	sd	s1,8(sp)
    80003094:	1000                	addi	s0,sp,32
    80003096:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80003098:	0541                	addi	a0,a0,16
    8000309a:	00001097          	auipc	ra,0x1
    8000309e:	46e080e7          	jalr	1134(ra) # 80004508 <holdingsleep>
    800030a2:	cd01                	beqz	a0,800030ba <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    800030a4:	4585                	li	a1,1
    800030a6:	8526                	mv	a0,s1
    800030a8:	00003097          	auipc	ra,0x3
    800030ac:	00c080e7          	jalr	12(ra) # 800060b4 <virtio_disk_rw>
}
    800030b0:	60e2                	ld	ra,24(sp)
    800030b2:	6442                	ld	s0,16(sp)
    800030b4:	64a2                	ld	s1,8(sp)
    800030b6:	6105                	addi	sp,sp,32
    800030b8:	8082                	ret
    panic("bwrite");
    800030ba:	00005517          	auipc	a0,0x5
    800030be:	47e50513          	addi	a0,a0,1150 # 80008538 <syscalls+0xe0>
    800030c2:	ffffd097          	auipc	ra,0xffffd
    800030c6:	47c080e7          	jalr	1148(ra) # 8000053e <panic>

00000000800030ca <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    800030ca:	1101                	addi	sp,sp,-32
    800030cc:	ec06                	sd	ra,24(sp)
    800030ce:	e822                	sd	s0,16(sp)
    800030d0:	e426                	sd	s1,8(sp)
    800030d2:	e04a                	sd	s2,0(sp)
    800030d4:	1000                	addi	s0,sp,32
    800030d6:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800030d8:	01050913          	addi	s2,a0,16
    800030dc:	854a                	mv	a0,s2
    800030de:	00001097          	auipc	ra,0x1
    800030e2:	42a080e7          	jalr	1066(ra) # 80004508 <holdingsleep>
    800030e6:	c92d                	beqz	a0,80003158 <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    800030e8:	854a                	mv	a0,s2
    800030ea:	00001097          	auipc	ra,0x1
    800030ee:	3da080e7          	jalr	986(ra) # 800044c4 <releasesleep>

  acquire(&bcache.lock);
    800030f2:	00015517          	auipc	a0,0x15
    800030f6:	ab650513          	addi	a0,a0,-1354 # 80017ba8 <bcache>
    800030fa:	ffffe097          	auipc	ra,0xffffe
    800030fe:	adc080e7          	jalr	-1316(ra) # 80000bd6 <acquire>
  b->refcnt--;
    80003102:	40bc                	lw	a5,64(s1)
    80003104:	37fd                	addiw	a5,a5,-1
    80003106:	0007871b          	sext.w	a4,a5
    8000310a:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    8000310c:	eb05                	bnez	a4,8000313c <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    8000310e:	68bc                	ld	a5,80(s1)
    80003110:	64b8                	ld	a4,72(s1)
    80003112:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    80003114:	64bc                	ld	a5,72(s1)
    80003116:	68b8                	ld	a4,80(s1)
    80003118:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    8000311a:	0001d797          	auipc	a5,0x1d
    8000311e:	a8e78793          	addi	a5,a5,-1394 # 8001fba8 <bcache+0x8000>
    80003122:	2b87b703          	ld	a4,696(a5)
    80003126:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    80003128:	0001d717          	auipc	a4,0x1d
    8000312c:	ce870713          	addi	a4,a4,-792 # 8001fe10 <bcache+0x8268>
    80003130:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80003132:	2b87b703          	ld	a4,696(a5)
    80003136:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    80003138:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    8000313c:	00015517          	auipc	a0,0x15
    80003140:	a6c50513          	addi	a0,a0,-1428 # 80017ba8 <bcache>
    80003144:	ffffe097          	auipc	ra,0xffffe
    80003148:	b46080e7          	jalr	-1210(ra) # 80000c8a <release>
}
    8000314c:	60e2                	ld	ra,24(sp)
    8000314e:	6442                	ld	s0,16(sp)
    80003150:	64a2                	ld	s1,8(sp)
    80003152:	6902                	ld	s2,0(sp)
    80003154:	6105                	addi	sp,sp,32
    80003156:	8082                	ret
    panic("brelse");
    80003158:	00005517          	auipc	a0,0x5
    8000315c:	3e850513          	addi	a0,a0,1000 # 80008540 <syscalls+0xe8>
    80003160:	ffffd097          	auipc	ra,0xffffd
    80003164:	3de080e7          	jalr	990(ra) # 8000053e <panic>

0000000080003168 <bpin>:

void
bpin(struct buf *b) {
    80003168:	1101                	addi	sp,sp,-32
    8000316a:	ec06                	sd	ra,24(sp)
    8000316c:	e822                	sd	s0,16(sp)
    8000316e:	e426                	sd	s1,8(sp)
    80003170:	1000                	addi	s0,sp,32
    80003172:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80003174:	00015517          	auipc	a0,0x15
    80003178:	a3450513          	addi	a0,a0,-1484 # 80017ba8 <bcache>
    8000317c:	ffffe097          	auipc	ra,0xffffe
    80003180:	a5a080e7          	jalr	-1446(ra) # 80000bd6 <acquire>
  b->refcnt++;
    80003184:	40bc                	lw	a5,64(s1)
    80003186:	2785                	addiw	a5,a5,1
    80003188:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8000318a:	00015517          	auipc	a0,0x15
    8000318e:	a1e50513          	addi	a0,a0,-1506 # 80017ba8 <bcache>
    80003192:	ffffe097          	auipc	ra,0xffffe
    80003196:	af8080e7          	jalr	-1288(ra) # 80000c8a <release>
}
    8000319a:	60e2                	ld	ra,24(sp)
    8000319c:	6442                	ld	s0,16(sp)
    8000319e:	64a2                	ld	s1,8(sp)
    800031a0:	6105                	addi	sp,sp,32
    800031a2:	8082                	ret

00000000800031a4 <bunpin>:

void
bunpin(struct buf *b) {
    800031a4:	1101                	addi	sp,sp,-32
    800031a6:	ec06                	sd	ra,24(sp)
    800031a8:	e822                	sd	s0,16(sp)
    800031aa:	e426                	sd	s1,8(sp)
    800031ac:	1000                	addi	s0,sp,32
    800031ae:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800031b0:	00015517          	auipc	a0,0x15
    800031b4:	9f850513          	addi	a0,a0,-1544 # 80017ba8 <bcache>
    800031b8:	ffffe097          	auipc	ra,0xffffe
    800031bc:	a1e080e7          	jalr	-1506(ra) # 80000bd6 <acquire>
  b->refcnt--;
    800031c0:	40bc                	lw	a5,64(s1)
    800031c2:	37fd                	addiw	a5,a5,-1
    800031c4:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800031c6:	00015517          	auipc	a0,0x15
    800031ca:	9e250513          	addi	a0,a0,-1566 # 80017ba8 <bcache>
    800031ce:	ffffe097          	auipc	ra,0xffffe
    800031d2:	abc080e7          	jalr	-1348(ra) # 80000c8a <release>
}
    800031d6:	60e2                	ld	ra,24(sp)
    800031d8:	6442                	ld	s0,16(sp)
    800031da:	64a2                	ld	s1,8(sp)
    800031dc:	6105                	addi	sp,sp,32
    800031de:	8082                	ret

00000000800031e0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    800031e0:	1101                	addi	sp,sp,-32
    800031e2:	ec06                	sd	ra,24(sp)
    800031e4:	e822                	sd	s0,16(sp)
    800031e6:	e426                	sd	s1,8(sp)
    800031e8:	e04a                	sd	s2,0(sp)
    800031ea:	1000                	addi	s0,sp,32
    800031ec:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    800031ee:	00d5d59b          	srliw	a1,a1,0xd
    800031f2:	0001d797          	auipc	a5,0x1d
    800031f6:	0927a783          	lw	a5,146(a5) # 80020284 <sb+0x1c>
    800031fa:	9dbd                	addw	a1,a1,a5
    800031fc:	00000097          	auipc	ra,0x0
    80003200:	d9e080e7          	jalr	-610(ra) # 80002f9a <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    80003204:	0074f713          	andi	a4,s1,7
    80003208:	4785                	li	a5,1
    8000320a:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    8000320e:	14ce                	slli	s1,s1,0x33
    80003210:	90d9                	srli	s1,s1,0x36
    80003212:	00950733          	add	a4,a0,s1
    80003216:	05874703          	lbu	a4,88(a4)
    8000321a:	00e7f6b3          	and	a3,a5,a4
    8000321e:	c69d                	beqz	a3,8000324c <bfree+0x6c>
    80003220:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    80003222:	94aa                	add	s1,s1,a0
    80003224:	fff7c793          	not	a5,a5
    80003228:	8ff9                	and	a5,a5,a4
    8000322a:	04f48c23          	sb	a5,88(s1)
  log_write(bp);
    8000322e:	00001097          	auipc	ra,0x1
    80003232:	120080e7          	jalr	288(ra) # 8000434e <log_write>
  brelse(bp);
    80003236:	854a                	mv	a0,s2
    80003238:	00000097          	auipc	ra,0x0
    8000323c:	e92080e7          	jalr	-366(ra) # 800030ca <brelse>
}
    80003240:	60e2                	ld	ra,24(sp)
    80003242:	6442                	ld	s0,16(sp)
    80003244:	64a2                	ld	s1,8(sp)
    80003246:	6902                	ld	s2,0(sp)
    80003248:	6105                	addi	sp,sp,32
    8000324a:	8082                	ret
    panic("freeing free block");
    8000324c:	00005517          	auipc	a0,0x5
    80003250:	2fc50513          	addi	a0,a0,764 # 80008548 <syscalls+0xf0>
    80003254:	ffffd097          	auipc	ra,0xffffd
    80003258:	2ea080e7          	jalr	746(ra) # 8000053e <panic>

000000008000325c <balloc>:
{
    8000325c:	711d                	addi	sp,sp,-96
    8000325e:	ec86                	sd	ra,88(sp)
    80003260:	e8a2                	sd	s0,80(sp)
    80003262:	e4a6                	sd	s1,72(sp)
    80003264:	e0ca                	sd	s2,64(sp)
    80003266:	fc4e                	sd	s3,56(sp)
    80003268:	f852                	sd	s4,48(sp)
    8000326a:	f456                	sd	s5,40(sp)
    8000326c:	f05a                	sd	s6,32(sp)
    8000326e:	ec5e                	sd	s7,24(sp)
    80003270:	e862                	sd	s8,16(sp)
    80003272:	e466                	sd	s9,8(sp)
    80003274:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80003276:	0001d797          	auipc	a5,0x1d
    8000327a:	ff67a783          	lw	a5,-10(a5) # 8002026c <sb+0x4>
    8000327e:	10078163          	beqz	a5,80003380 <balloc+0x124>
    80003282:	8baa                	mv	s7,a0
    80003284:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80003286:	0001db17          	auipc	s6,0x1d
    8000328a:	fe2b0b13          	addi	s6,s6,-30 # 80020268 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000328e:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    80003290:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003292:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80003294:	6c89                	lui	s9,0x2
    80003296:	a061                	j	8000331e <balloc+0xc2>
        bp->data[bi/8] |= m;  // Mark block in use.
    80003298:	974a                	add	a4,a4,s2
    8000329a:	8fd5                	or	a5,a5,a3
    8000329c:	04f70c23          	sb	a5,88(a4)
        log_write(bp);
    800032a0:	854a                	mv	a0,s2
    800032a2:	00001097          	auipc	ra,0x1
    800032a6:	0ac080e7          	jalr	172(ra) # 8000434e <log_write>
        brelse(bp);
    800032aa:	854a                	mv	a0,s2
    800032ac:	00000097          	auipc	ra,0x0
    800032b0:	e1e080e7          	jalr	-482(ra) # 800030ca <brelse>
  bp = bread(dev, bno);
    800032b4:	85a6                	mv	a1,s1
    800032b6:	855e                	mv	a0,s7
    800032b8:	00000097          	auipc	ra,0x0
    800032bc:	ce2080e7          	jalr	-798(ra) # 80002f9a <bread>
    800032c0:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    800032c2:	40000613          	li	a2,1024
    800032c6:	4581                	li	a1,0
    800032c8:	05850513          	addi	a0,a0,88
    800032cc:	ffffe097          	auipc	ra,0xffffe
    800032d0:	a06080e7          	jalr	-1530(ra) # 80000cd2 <memset>
  log_write(bp);
    800032d4:	854a                	mv	a0,s2
    800032d6:	00001097          	auipc	ra,0x1
    800032da:	078080e7          	jalr	120(ra) # 8000434e <log_write>
  brelse(bp);
    800032de:	854a                	mv	a0,s2
    800032e0:	00000097          	auipc	ra,0x0
    800032e4:	dea080e7          	jalr	-534(ra) # 800030ca <brelse>
}
    800032e8:	8526                	mv	a0,s1
    800032ea:	60e6                	ld	ra,88(sp)
    800032ec:	6446                	ld	s0,80(sp)
    800032ee:	64a6                	ld	s1,72(sp)
    800032f0:	6906                	ld	s2,64(sp)
    800032f2:	79e2                	ld	s3,56(sp)
    800032f4:	7a42                	ld	s4,48(sp)
    800032f6:	7aa2                	ld	s5,40(sp)
    800032f8:	7b02                	ld	s6,32(sp)
    800032fa:	6be2                	ld	s7,24(sp)
    800032fc:	6c42                	ld	s8,16(sp)
    800032fe:	6ca2                	ld	s9,8(sp)
    80003300:	6125                	addi	sp,sp,96
    80003302:	8082                	ret
    brelse(bp);
    80003304:	854a                	mv	a0,s2
    80003306:	00000097          	auipc	ra,0x0
    8000330a:	dc4080e7          	jalr	-572(ra) # 800030ca <brelse>
  for(b = 0; b < sb.size; b += BPB){
    8000330e:	015c87bb          	addw	a5,s9,s5
    80003312:	00078a9b          	sext.w	s5,a5
    80003316:	004b2703          	lw	a4,4(s6)
    8000331a:	06eaf363          	bgeu	s5,a4,80003380 <balloc+0x124>
    bp = bread(dev, BBLOCK(b, sb));
    8000331e:	41fad79b          	sraiw	a5,s5,0x1f
    80003322:	0137d79b          	srliw	a5,a5,0x13
    80003326:	015787bb          	addw	a5,a5,s5
    8000332a:	40d7d79b          	sraiw	a5,a5,0xd
    8000332e:	01cb2583          	lw	a1,28(s6)
    80003332:	9dbd                	addw	a1,a1,a5
    80003334:	855e                	mv	a0,s7
    80003336:	00000097          	auipc	ra,0x0
    8000333a:	c64080e7          	jalr	-924(ra) # 80002f9a <bread>
    8000333e:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003340:	004b2503          	lw	a0,4(s6)
    80003344:	000a849b          	sext.w	s1,s5
    80003348:	8662                	mv	a2,s8
    8000334a:	faa4fde3          	bgeu	s1,a0,80003304 <balloc+0xa8>
      m = 1 << (bi % 8);
    8000334e:	41f6579b          	sraiw	a5,a2,0x1f
    80003352:	01d7d69b          	srliw	a3,a5,0x1d
    80003356:	00c6873b          	addw	a4,a3,a2
    8000335a:	00777793          	andi	a5,a4,7
    8000335e:	9f95                	subw	a5,a5,a3
    80003360:	00f997bb          	sllw	a5,s3,a5
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80003364:	4037571b          	sraiw	a4,a4,0x3
    80003368:	00e906b3          	add	a3,s2,a4
    8000336c:	0586c683          	lbu	a3,88(a3)
    80003370:	00d7f5b3          	and	a1,a5,a3
    80003374:	d195                	beqz	a1,80003298 <balloc+0x3c>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003376:	2605                	addiw	a2,a2,1
    80003378:	2485                	addiw	s1,s1,1
    8000337a:	fd4618e3          	bne	a2,s4,8000334a <balloc+0xee>
    8000337e:	b759                	j	80003304 <balloc+0xa8>
  printf("balloc: out of blocks\n");
    80003380:	00005517          	auipc	a0,0x5
    80003384:	1e050513          	addi	a0,a0,480 # 80008560 <syscalls+0x108>
    80003388:	ffffd097          	auipc	ra,0xffffd
    8000338c:	200080e7          	jalr	512(ra) # 80000588 <printf>
  return 0;
    80003390:	4481                	li	s1,0
    80003392:	bf99                	j	800032e8 <balloc+0x8c>

0000000080003394 <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    80003394:	7179                	addi	sp,sp,-48
    80003396:	f406                	sd	ra,40(sp)
    80003398:	f022                	sd	s0,32(sp)
    8000339a:	ec26                	sd	s1,24(sp)
    8000339c:	e84a                	sd	s2,16(sp)
    8000339e:	e44e                	sd	s3,8(sp)
    800033a0:	e052                	sd	s4,0(sp)
    800033a2:	1800                	addi	s0,sp,48
    800033a4:	89aa                	mv	s3,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    800033a6:	47ad                	li	a5,11
    800033a8:	02b7e763          	bltu	a5,a1,800033d6 <bmap+0x42>
    if((addr = ip->addrs[bn]) == 0){
    800033ac:	02059493          	slli	s1,a1,0x20
    800033b0:	9081                	srli	s1,s1,0x20
    800033b2:	048a                	slli	s1,s1,0x2
    800033b4:	94aa                	add	s1,s1,a0
    800033b6:	0504a903          	lw	s2,80(s1)
    800033ba:	06091e63          	bnez	s2,80003436 <bmap+0xa2>
      addr = balloc(ip->dev);
    800033be:	4108                	lw	a0,0(a0)
    800033c0:	00000097          	auipc	ra,0x0
    800033c4:	e9c080e7          	jalr	-356(ra) # 8000325c <balloc>
    800033c8:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    800033cc:	06090563          	beqz	s2,80003436 <bmap+0xa2>
        return 0;
      ip->addrs[bn] = addr;
    800033d0:	0524a823          	sw	s2,80(s1)
    800033d4:	a08d                	j	80003436 <bmap+0xa2>
    }
    return addr;
  }
  bn -= NDIRECT;
    800033d6:	ff45849b          	addiw	s1,a1,-12
    800033da:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    800033de:	0ff00793          	li	a5,255
    800033e2:	08e7e563          	bltu	a5,a4,8000346c <bmap+0xd8>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    800033e6:	08052903          	lw	s2,128(a0)
    800033ea:	00091d63          	bnez	s2,80003404 <bmap+0x70>
      addr = balloc(ip->dev);
    800033ee:	4108                	lw	a0,0(a0)
    800033f0:	00000097          	auipc	ra,0x0
    800033f4:	e6c080e7          	jalr	-404(ra) # 8000325c <balloc>
    800033f8:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    800033fc:	02090d63          	beqz	s2,80003436 <bmap+0xa2>
        return 0;
      ip->addrs[NDIRECT] = addr;
    80003400:	0929a023          	sw	s2,128(s3)
    }
    bp = bread(ip->dev, addr);
    80003404:	85ca                	mv	a1,s2
    80003406:	0009a503          	lw	a0,0(s3)
    8000340a:	00000097          	auipc	ra,0x0
    8000340e:	b90080e7          	jalr	-1136(ra) # 80002f9a <bread>
    80003412:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80003414:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    80003418:	02049593          	slli	a1,s1,0x20
    8000341c:	9181                	srli	a1,a1,0x20
    8000341e:	058a                	slli	a1,a1,0x2
    80003420:	00b784b3          	add	s1,a5,a1
    80003424:	0004a903          	lw	s2,0(s1)
    80003428:	02090063          	beqz	s2,80003448 <bmap+0xb4>
      if(addr){
        a[bn] = addr;
        log_write(bp);
      }
    }
    brelse(bp);
    8000342c:	8552                	mv	a0,s4
    8000342e:	00000097          	auipc	ra,0x0
    80003432:	c9c080e7          	jalr	-868(ra) # 800030ca <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    80003436:	854a                	mv	a0,s2
    80003438:	70a2                	ld	ra,40(sp)
    8000343a:	7402                	ld	s0,32(sp)
    8000343c:	64e2                	ld	s1,24(sp)
    8000343e:	6942                	ld	s2,16(sp)
    80003440:	69a2                	ld	s3,8(sp)
    80003442:	6a02                	ld	s4,0(sp)
    80003444:	6145                	addi	sp,sp,48
    80003446:	8082                	ret
      addr = balloc(ip->dev);
    80003448:	0009a503          	lw	a0,0(s3)
    8000344c:	00000097          	auipc	ra,0x0
    80003450:	e10080e7          	jalr	-496(ra) # 8000325c <balloc>
    80003454:	0005091b          	sext.w	s2,a0
      if(addr){
    80003458:	fc090ae3          	beqz	s2,8000342c <bmap+0x98>
        a[bn] = addr;
    8000345c:	0124a023          	sw	s2,0(s1)
        log_write(bp);
    80003460:	8552                	mv	a0,s4
    80003462:	00001097          	auipc	ra,0x1
    80003466:	eec080e7          	jalr	-276(ra) # 8000434e <log_write>
    8000346a:	b7c9                	j	8000342c <bmap+0x98>
  panic("bmap: out of range");
    8000346c:	00005517          	auipc	a0,0x5
    80003470:	10c50513          	addi	a0,a0,268 # 80008578 <syscalls+0x120>
    80003474:	ffffd097          	auipc	ra,0xffffd
    80003478:	0ca080e7          	jalr	202(ra) # 8000053e <panic>

000000008000347c <iget>:
{
    8000347c:	7179                	addi	sp,sp,-48
    8000347e:	f406                	sd	ra,40(sp)
    80003480:	f022                	sd	s0,32(sp)
    80003482:	ec26                	sd	s1,24(sp)
    80003484:	e84a                	sd	s2,16(sp)
    80003486:	e44e                	sd	s3,8(sp)
    80003488:	e052                	sd	s4,0(sp)
    8000348a:	1800                	addi	s0,sp,48
    8000348c:	89aa                	mv	s3,a0
    8000348e:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    80003490:	0001d517          	auipc	a0,0x1d
    80003494:	df850513          	addi	a0,a0,-520 # 80020288 <itable>
    80003498:	ffffd097          	auipc	ra,0xffffd
    8000349c:	73e080e7          	jalr	1854(ra) # 80000bd6 <acquire>
  empty = 0;
    800034a0:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    800034a2:	0001d497          	auipc	s1,0x1d
    800034a6:	dfe48493          	addi	s1,s1,-514 # 800202a0 <itable+0x18>
    800034aa:	0001f697          	auipc	a3,0x1f
    800034ae:	88668693          	addi	a3,a3,-1914 # 80021d30 <log>
    800034b2:	a039                	j	800034c0 <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800034b4:	02090b63          	beqz	s2,800034ea <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    800034b8:	08848493          	addi	s1,s1,136
    800034bc:	02d48a63          	beq	s1,a3,800034f0 <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    800034c0:	449c                	lw	a5,8(s1)
    800034c2:	fef059e3          	blez	a5,800034b4 <iget+0x38>
    800034c6:	4098                	lw	a4,0(s1)
    800034c8:	ff3716e3          	bne	a4,s3,800034b4 <iget+0x38>
    800034cc:	40d8                	lw	a4,4(s1)
    800034ce:	ff4713e3          	bne	a4,s4,800034b4 <iget+0x38>
      ip->ref++;
    800034d2:	2785                	addiw	a5,a5,1
    800034d4:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    800034d6:	0001d517          	auipc	a0,0x1d
    800034da:	db250513          	addi	a0,a0,-590 # 80020288 <itable>
    800034de:	ffffd097          	auipc	ra,0xffffd
    800034e2:	7ac080e7          	jalr	1964(ra) # 80000c8a <release>
      return ip;
    800034e6:	8926                	mv	s2,s1
    800034e8:	a03d                	j	80003516 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800034ea:	f7f9                	bnez	a5,800034b8 <iget+0x3c>
    800034ec:	8926                	mv	s2,s1
    800034ee:	b7e9                	j	800034b8 <iget+0x3c>
  if(empty == 0)
    800034f0:	02090c63          	beqz	s2,80003528 <iget+0xac>
  ip->dev = dev;
    800034f4:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    800034f8:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    800034fc:	4785                	li	a5,1
    800034fe:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80003502:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80003506:	0001d517          	auipc	a0,0x1d
    8000350a:	d8250513          	addi	a0,a0,-638 # 80020288 <itable>
    8000350e:	ffffd097          	auipc	ra,0xffffd
    80003512:	77c080e7          	jalr	1916(ra) # 80000c8a <release>
}
    80003516:	854a                	mv	a0,s2
    80003518:	70a2                	ld	ra,40(sp)
    8000351a:	7402                	ld	s0,32(sp)
    8000351c:	64e2                	ld	s1,24(sp)
    8000351e:	6942                	ld	s2,16(sp)
    80003520:	69a2                	ld	s3,8(sp)
    80003522:	6a02                	ld	s4,0(sp)
    80003524:	6145                	addi	sp,sp,48
    80003526:	8082                	ret
    panic("iget: no inodes");
    80003528:	00005517          	auipc	a0,0x5
    8000352c:	06850513          	addi	a0,a0,104 # 80008590 <syscalls+0x138>
    80003530:	ffffd097          	auipc	ra,0xffffd
    80003534:	00e080e7          	jalr	14(ra) # 8000053e <panic>

0000000080003538 <fsinit>:
fsinit(int dev) {
    80003538:	7179                	addi	sp,sp,-48
    8000353a:	f406                	sd	ra,40(sp)
    8000353c:	f022                	sd	s0,32(sp)
    8000353e:	ec26                	sd	s1,24(sp)
    80003540:	e84a                	sd	s2,16(sp)
    80003542:	e44e                	sd	s3,8(sp)
    80003544:	1800                	addi	s0,sp,48
    80003546:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80003548:	4585                	li	a1,1
    8000354a:	00000097          	auipc	ra,0x0
    8000354e:	a50080e7          	jalr	-1456(ra) # 80002f9a <bread>
    80003552:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80003554:	0001d997          	auipc	s3,0x1d
    80003558:	d1498993          	addi	s3,s3,-748 # 80020268 <sb>
    8000355c:	02000613          	li	a2,32
    80003560:	05850593          	addi	a1,a0,88
    80003564:	854e                	mv	a0,s3
    80003566:	ffffd097          	auipc	ra,0xffffd
    8000356a:	7c8080e7          	jalr	1992(ra) # 80000d2e <memmove>
  brelse(bp);
    8000356e:	8526                	mv	a0,s1
    80003570:	00000097          	auipc	ra,0x0
    80003574:	b5a080e7          	jalr	-1190(ra) # 800030ca <brelse>
  if(sb.magic != FSMAGIC)
    80003578:	0009a703          	lw	a4,0(s3)
    8000357c:	102037b7          	lui	a5,0x10203
    80003580:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80003584:	02f71263          	bne	a4,a5,800035a8 <fsinit+0x70>
  initlog(dev, &sb);
    80003588:	0001d597          	auipc	a1,0x1d
    8000358c:	ce058593          	addi	a1,a1,-800 # 80020268 <sb>
    80003590:	854a                	mv	a0,s2
    80003592:	00001097          	auipc	ra,0x1
    80003596:	b40080e7          	jalr	-1216(ra) # 800040d2 <initlog>
}
    8000359a:	70a2                	ld	ra,40(sp)
    8000359c:	7402                	ld	s0,32(sp)
    8000359e:	64e2                	ld	s1,24(sp)
    800035a0:	6942                	ld	s2,16(sp)
    800035a2:	69a2                	ld	s3,8(sp)
    800035a4:	6145                	addi	sp,sp,48
    800035a6:	8082                	ret
    panic("invalid file system");
    800035a8:	00005517          	auipc	a0,0x5
    800035ac:	ff850513          	addi	a0,a0,-8 # 800085a0 <syscalls+0x148>
    800035b0:	ffffd097          	auipc	ra,0xffffd
    800035b4:	f8e080e7          	jalr	-114(ra) # 8000053e <panic>

00000000800035b8 <iinit>:
{
    800035b8:	7179                	addi	sp,sp,-48
    800035ba:	f406                	sd	ra,40(sp)
    800035bc:	f022                	sd	s0,32(sp)
    800035be:	ec26                	sd	s1,24(sp)
    800035c0:	e84a                	sd	s2,16(sp)
    800035c2:	e44e                	sd	s3,8(sp)
    800035c4:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    800035c6:	00005597          	auipc	a1,0x5
    800035ca:	ff258593          	addi	a1,a1,-14 # 800085b8 <syscalls+0x160>
    800035ce:	0001d517          	auipc	a0,0x1d
    800035d2:	cba50513          	addi	a0,a0,-838 # 80020288 <itable>
    800035d6:	ffffd097          	auipc	ra,0xffffd
    800035da:	570080e7          	jalr	1392(ra) # 80000b46 <initlock>
  for(i = 0; i < NINODE; i++) {
    800035de:	0001d497          	auipc	s1,0x1d
    800035e2:	cd248493          	addi	s1,s1,-814 # 800202b0 <itable+0x28>
    800035e6:	0001e997          	auipc	s3,0x1e
    800035ea:	75a98993          	addi	s3,s3,1882 # 80021d40 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    800035ee:	00005917          	auipc	s2,0x5
    800035f2:	fd290913          	addi	s2,s2,-46 # 800085c0 <syscalls+0x168>
    800035f6:	85ca                	mv	a1,s2
    800035f8:	8526                	mv	a0,s1
    800035fa:	00001097          	auipc	ra,0x1
    800035fe:	e3a080e7          	jalr	-454(ra) # 80004434 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80003602:	08848493          	addi	s1,s1,136
    80003606:	ff3498e3          	bne	s1,s3,800035f6 <iinit+0x3e>
}
    8000360a:	70a2                	ld	ra,40(sp)
    8000360c:	7402                	ld	s0,32(sp)
    8000360e:	64e2                	ld	s1,24(sp)
    80003610:	6942                	ld	s2,16(sp)
    80003612:	69a2                	ld	s3,8(sp)
    80003614:	6145                	addi	sp,sp,48
    80003616:	8082                	ret

0000000080003618 <ialloc>:
{
    80003618:	715d                	addi	sp,sp,-80
    8000361a:	e486                	sd	ra,72(sp)
    8000361c:	e0a2                	sd	s0,64(sp)
    8000361e:	fc26                	sd	s1,56(sp)
    80003620:	f84a                	sd	s2,48(sp)
    80003622:	f44e                	sd	s3,40(sp)
    80003624:	f052                	sd	s4,32(sp)
    80003626:	ec56                	sd	s5,24(sp)
    80003628:	e85a                	sd	s6,16(sp)
    8000362a:	e45e                	sd	s7,8(sp)
    8000362c:	0880                	addi	s0,sp,80
  for(inum = 1; inum < sb.ninodes; inum++){
    8000362e:	0001d717          	auipc	a4,0x1d
    80003632:	c4672703          	lw	a4,-954(a4) # 80020274 <sb+0xc>
    80003636:	4785                	li	a5,1
    80003638:	04e7fa63          	bgeu	a5,a4,8000368c <ialloc+0x74>
    8000363c:	8aaa                	mv	s5,a0
    8000363e:	8bae                	mv	s7,a1
    80003640:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    80003642:	0001da17          	auipc	s4,0x1d
    80003646:	c26a0a13          	addi	s4,s4,-986 # 80020268 <sb>
    8000364a:	00048b1b          	sext.w	s6,s1
    8000364e:	0044d793          	srli	a5,s1,0x4
    80003652:	018a2583          	lw	a1,24(s4)
    80003656:	9dbd                	addw	a1,a1,a5
    80003658:	8556                	mv	a0,s5
    8000365a:	00000097          	auipc	ra,0x0
    8000365e:	940080e7          	jalr	-1728(ra) # 80002f9a <bread>
    80003662:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80003664:	05850993          	addi	s3,a0,88
    80003668:	00f4f793          	andi	a5,s1,15
    8000366c:	079a                	slli	a5,a5,0x6
    8000366e:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80003670:	00099783          	lh	a5,0(s3)
    80003674:	c3a1                	beqz	a5,800036b4 <ialloc+0x9c>
    brelse(bp);
    80003676:	00000097          	auipc	ra,0x0
    8000367a:	a54080e7          	jalr	-1452(ra) # 800030ca <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    8000367e:	0485                	addi	s1,s1,1
    80003680:	00ca2703          	lw	a4,12(s4)
    80003684:	0004879b          	sext.w	a5,s1
    80003688:	fce7e1e3          	bltu	a5,a4,8000364a <ialloc+0x32>
  printf("ialloc: no inodes\n");
    8000368c:	00005517          	auipc	a0,0x5
    80003690:	f3c50513          	addi	a0,a0,-196 # 800085c8 <syscalls+0x170>
    80003694:	ffffd097          	auipc	ra,0xffffd
    80003698:	ef4080e7          	jalr	-268(ra) # 80000588 <printf>
  return 0;
    8000369c:	4501                	li	a0,0
}
    8000369e:	60a6                	ld	ra,72(sp)
    800036a0:	6406                	ld	s0,64(sp)
    800036a2:	74e2                	ld	s1,56(sp)
    800036a4:	7942                	ld	s2,48(sp)
    800036a6:	79a2                	ld	s3,40(sp)
    800036a8:	7a02                	ld	s4,32(sp)
    800036aa:	6ae2                	ld	s5,24(sp)
    800036ac:	6b42                	ld	s6,16(sp)
    800036ae:	6ba2                	ld	s7,8(sp)
    800036b0:	6161                	addi	sp,sp,80
    800036b2:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    800036b4:	04000613          	li	a2,64
    800036b8:	4581                	li	a1,0
    800036ba:	854e                	mv	a0,s3
    800036bc:	ffffd097          	auipc	ra,0xffffd
    800036c0:	616080e7          	jalr	1558(ra) # 80000cd2 <memset>
      dip->type = type;
    800036c4:	01799023          	sh	s7,0(s3)
      log_write(bp);   // mark it allocated on the disk
    800036c8:	854a                	mv	a0,s2
    800036ca:	00001097          	auipc	ra,0x1
    800036ce:	c84080e7          	jalr	-892(ra) # 8000434e <log_write>
      brelse(bp);
    800036d2:	854a                	mv	a0,s2
    800036d4:	00000097          	auipc	ra,0x0
    800036d8:	9f6080e7          	jalr	-1546(ra) # 800030ca <brelse>
      return iget(dev, inum);
    800036dc:	85da                	mv	a1,s6
    800036de:	8556                	mv	a0,s5
    800036e0:	00000097          	auipc	ra,0x0
    800036e4:	d9c080e7          	jalr	-612(ra) # 8000347c <iget>
    800036e8:	bf5d                	j	8000369e <ialloc+0x86>

00000000800036ea <iupdate>:
{
    800036ea:	1101                	addi	sp,sp,-32
    800036ec:	ec06                	sd	ra,24(sp)
    800036ee:	e822                	sd	s0,16(sp)
    800036f0:	e426                	sd	s1,8(sp)
    800036f2:	e04a                	sd	s2,0(sp)
    800036f4:	1000                	addi	s0,sp,32
    800036f6:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    800036f8:	415c                	lw	a5,4(a0)
    800036fa:	0047d79b          	srliw	a5,a5,0x4
    800036fe:	0001d597          	auipc	a1,0x1d
    80003702:	b825a583          	lw	a1,-1150(a1) # 80020280 <sb+0x18>
    80003706:	9dbd                	addw	a1,a1,a5
    80003708:	4108                	lw	a0,0(a0)
    8000370a:	00000097          	auipc	ra,0x0
    8000370e:	890080e7          	jalr	-1904(ra) # 80002f9a <bread>
    80003712:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80003714:	05850793          	addi	a5,a0,88
    80003718:	40c8                	lw	a0,4(s1)
    8000371a:	893d                	andi	a0,a0,15
    8000371c:	051a                	slli	a0,a0,0x6
    8000371e:	953e                	add	a0,a0,a5
  dip->type = ip->type;
    80003720:	04449703          	lh	a4,68(s1)
    80003724:	00e51023          	sh	a4,0(a0)
  dip->major = ip->major;
    80003728:	04649703          	lh	a4,70(s1)
    8000372c:	00e51123          	sh	a4,2(a0)
  dip->minor = ip->minor;
    80003730:	04849703          	lh	a4,72(s1)
    80003734:	00e51223          	sh	a4,4(a0)
  dip->nlink = ip->nlink;
    80003738:	04a49703          	lh	a4,74(s1)
    8000373c:	00e51323          	sh	a4,6(a0)
  dip->size = ip->size;
    80003740:	44f8                	lw	a4,76(s1)
    80003742:	c518                	sw	a4,8(a0)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80003744:	03400613          	li	a2,52
    80003748:	05048593          	addi	a1,s1,80
    8000374c:	0531                	addi	a0,a0,12
    8000374e:	ffffd097          	auipc	ra,0xffffd
    80003752:	5e0080e7          	jalr	1504(ra) # 80000d2e <memmove>
  log_write(bp);
    80003756:	854a                	mv	a0,s2
    80003758:	00001097          	auipc	ra,0x1
    8000375c:	bf6080e7          	jalr	-1034(ra) # 8000434e <log_write>
  brelse(bp);
    80003760:	854a                	mv	a0,s2
    80003762:	00000097          	auipc	ra,0x0
    80003766:	968080e7          	jalr	-1688(ra) # 800030ca <brelse>
}
    8000376a:	60e2                	ld	ra,24(sp)
    8000376c:	6442                	ld	s0,16(sp)
    8000376e:	64a2                	ld	s1,8(sp)
    80003770:	6902                	ld	s2,0(sp)
    80003772:	6105                	addi	sp,sp,32
    80003774:	8082                	ret

0000000080003776 <idup>:
{
    80003776:	1101                	addi	sp,sp,-32
    80003778:	ec06                	sd	ra,24(sp)
    8000377a:	e822                	sd	s0,16(sp)
    8000377c:	e426                	sd	s1,8(sp)
    8000377e:	1000                	addi	s0,sp,32
    80003780:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80003782:	0001d517          	auipc	a0,0x1d
    80003786:	b0650513          	addi	a0,a0,-1274 # 80020288 <itable>
    8000378a:	ffffd097          	auipc	ra,0xffffd
    8000378e:	44c080e7          	jalr	1100(ra) # 80000bd6 <acquire>
  ip->ref++;
    80003792:	449c                	lw	a5,8(s1)
    80003794:	2785                	addiw	a5,a5,1
    80003796:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80003798:	0001d517          	auipc	a0,0x1d
    8000379c:	af050513          	addi	a0,a0,-1296 # 80020288 <itable>
    800037a0:	ffffd097          	auipc	ra,0xffffd
    800037a4:	4ea080e7          	jalr	1258(ra) # 80000c8a <release>
}
    800037a8:	8526                	mv	a0,s1
    800037aa:	60e2                	ld	ra,24(sp)
    800037ac:	6442                	ld	s0,16(sp)
    800037ae:	64a2                	ld	s1,8(sp)
    800037b0:	6105                	addi	sp,sp,32
    800037b2:	8082                	ret

00000000800037b4 <ilock>:
{
    800037b4:	1101                	addi	sp,sp,-32
    800037b6:	ec06                	sd	ra,24(sp)
    800037b8:	e822                	sd	s0,16(sp)
    800037ba:	e426                	sd	s1,8(sp)
    800037bc:	e04a                	sd	s2,0(sp)
    800037be:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    800037c0:	c115                	beqz	a0,800037e4 <ilock+0x30>
    800037c2:	84aa                	mv	s1,a0
    800037c4:	451c                	lw	a5,8(a0)
    800037c6:	00f05f63          	blez	a5,800037e4 <ilock+0x30>
  acquiresleep(&ip->lock);
    800037ca:	0541                	addi	a0,a0,16
    800037cc:	00001097          	auipc	ra,0x1
    800037d0:	ca2080e7          	jalr	-862(ra) # 8000446e <acquiresleep>
  if(ip->valid == 0){
    800037d4:	40bc                	lw	a5,64(s1)
    800037d6:	cf99                	beqz	a5,800037f4 <ilock+0x40>
}
    800037d8:	60e2                	ld	ra,24(sp)
    800037da:	6442                	ld	s0,16(sp)
    800037dc:	64a2                	ld	s1,8(sp)
    800037de:	6902                	ld	s2,0(sp)
    800037e0:	6105                	addi	sp,sp,32
    800037e2:	8082                	ret
    panic("ilock");
    800037e4:	00005517          	auipc	a0,0x5
    800037e8:	dfc50513          	addi	a0,a0,-516 # 800085e0 <syscalls+0x188>
    800037ec:	ffffd097          	auipc	ra,0xffffd
    800037f0:	d52080e7          	jalr	-686(ra) # 8000053e <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    800037f4:	40dc                	lw	a5,4(s1)
    800037f6:	0047d79b          	srliw	a5,a5,0x4
    800037fa:	0001d597          	auipc	a1,0x1d
    800037fe:	a865a583          	lw	a1,-1402(a1) # 80020280 <sb+0x18>
    80003802:	9dbd                	addw	a1,a1,a5
    80003804:	4088                	lw	a0,0(s1)
    80003806:	fffff097          	auipc	ra,0xfffff
    8000380a:	794080e7          	jalr	1940(ra) # 80002f9a <bread>
    8000380e:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80003810:	05850593          	addi	a1,a0,88
    80003814:	40dc                	lw	a5,4(s1)
    80003816:	8bbd                	andi	a5,a5,15
    80003818:	079a                	slli	a5,a5,0x6
    8000381a:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    8000381c:	00059783          	lh	a5,0(a1)
    80003820:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80003824:	00259783          	lh	a5,2(a1)
    80003828:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    8000382c:	00459783          	lh	a5,4(a1)
    80003830:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80003834:	00659783          	lh	a5,6(a1)
    80003838:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    8000383c:	459c                	lw	a5,8(a1)
    8000383e:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80003840:	03400613          	li	a2,52
    80003844:	05b1                	addi	a1,a1,12
    80003846:	05048513          	addi	a0,s1,80
    8000384a:	ffffd097          	auipc	ra,0xffffd
    8000384e:	4e4080e7          	jalr	1252(ra) # 80000d2e <memmove>
    brelse(bp);
    80003852:	854a                	mv	a0,s2
    80003854:	00000097          	auipc	ra,0x0
    80003858:	876080e7          	jalr	-1930(ra) # 800030ca <brelse>
    ip->valid = 1;
    8000385c:	4785                	li	a5,1
    8000385e:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80003860:	04449783          	lh	a5,68(s1)
    80003864:	fbb5                	bnez	a5,800037d8 <ilock+0x24>
      panic("ilock: no type");
    80003866:	00005517          	auipc	a0,0x5
    8000386a:	d8250513          	addi	a0,a0,-638 # 800085e8 <syscalls+0x190>
    8000386e:	ffffd097          	auipc	ra,0xffffd
    80003872:	cd0080e7          	jalr	-816(ra) # 8000053e <panic>

0000000080003876 <iunlock>:
{
    80003876:	1101                	addi	sp,sp,-32
    80003878:	ec06                	sd	ra,24(sp)
    8000387a:	e822                	sd	s0,16(sp)
    8000387c:	e426                	sd	s1,8(sp)
    8000387e:	e04a                	sd	s2,0(sp)
    80003880:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80003882:	c905                	beqz	a0,800038b2 <iunlock+0x3c>
    80003884:	84aa                	mv	s1,a0
    80003886:	01050913          	addi	s2,a0,16
    8000388a:	854a                	mv	a0,s2
    8000388c:	00001097          	auipc	ra,0x1
    80003890:	c7c080e7          	jalr	-900(ra) # 80004508 <holdingsleep>
    80003894:	cd19                	beqz	a0,800038b2 <iunlock+0x3c>
    80003896:	449c                	lw	a5,8(s1)
    80003898:	00f05d63          	blez	a5,800038b2 <iunlock+0x3c>
  releasesleep(&ip->lock);
    8000389c:	854a                	mv	a0,s2
    8000389e:	00001097          	auipc	ra,0x1
    800038a2:	c26080e7          	jalr	-986(ra) # 800044c4 <releasesleep>
}
    800038a6:	60e2                	ld	ra,24(sp)
    800038a8:	6442                	ld	s0,16(sp)
    800038aa:	64a2                	ld	s1,8(sp)
    800038ac:	6902                	ld	s2,0(sp)
    800038ae:	6105                	addi	sp,sp,32
    800038b0:	8082                	ret
    panic("iunlock");
    800038b2:	00005517          	auipc	a0,0x5
    800038b6:	d4650513          	addi	a0,a0,-698 # 800085f8 <syscalls+0x1a0>
    800038ba:	ffffd097          	auipc	ra,0xffffd
    800038be:	c84080e7          	jalr	-892(ra) # 8000053e <panic>

00000000800038c2 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    800038c2:	7179                	addi	sp,sp,-48
    800038c4:	f406                	sd	ra,40(sp)
    800038c6:	f022                	sd	s0,32(sp)
    800038c8:	ec26                	sd	s1,24(sp)
    800038ca:	e84a                	sd	s2,16(sp)
    800038cc:	e44e                	sd	s3,8(sp)
    800038ce:	e052                	sd	s4,0(sp)
    800038d0:	1800                	addi	s0,sp,48
    800038d2:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    800038d4:	05050493          	addi	s1,a0,80
    800038d8:	08050913          	addi	s2,a0,128
    800038dc:	a021                	j	800038e4 <itrunc+0x22>
    800038de:	0491                	addi	s1,s1,4
    800038e0:	01248d63          	beq	s1,s2,800038fa <itrunc+0x38>
    if(ip->addrs[i]){
    800038e4:	408c                	lw	a1,0(s1)
    800038e6:	dde5                	beqz	a1,800038de <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    800038e8:	0009a503          	lw	a0,0(s3)
    800038ec:	00000097          	auipc	ra,0x0
    800038f0:	8f4080e7          	jalr	-1804(ra) # 800031e0 <bfree>
      ip->addrs[i] = 0;
    800038f4:	0004a023          	sw	zero,0(s1)
    800038f8:	b7dd                	j	800038de <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    800038fa:	0809a583          	lw	a1,128(s3)
    800038fe:	e185                	bnez	a1,8000391e <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80003900:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80003904:	854e                	mv	a0,s3
    80003906:	00000097          	auipc	ra,0x0
    8000390a:	de4080e7          	jalr	-540(ra) # 800036ea <iupdate>
}
    8000390e:	70a2                	ld	ra,40(sp)
    80003910:	7402                	ld	s0,32(sp)
    80003912:	64e2                	ld	s1,24(sp)
    80003914:	6942                	ld	s2,16(sp)
    80003916:	69a2                	ld	s3,8(sp)
    80003918:	6a02                	ld	s4,0(sp)
    8000391a:	6145                	addi	sp,sp,48
    8000391c:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    8000391e:	0009a503          	lw	a0,0(s3)
    80003922:	fffff097          	auipc	ra,0xfffff
    80003926:	678080e7          	jalr	1656(ra) # 80002f9a <bread>
    8000392a:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    8000392c:	05850493          	addi	s1,a0,88
    80003930:	45850913          	addi	s2,a0,1112
    80003934:	a021                	j	8000393c <itrunc+0x7a>
    80003936:	0491                	addi	s1,s1,4
    80003938:	01248b63          	beq	s1,s2,8000394e <itrunc+0x8c>
      if(a[j])
    8000393c:	408c                	lw	a1,0(s1)
    8000393e:	dde5                	beqz	a1,80003936 <itrunc+0x74>
        bfree(ip->dev, a[j]);
    80003940:	0009a503          	lw	a0,0(s3)
    80003944:	00000097          	auipc	ra,0x0
    80003948:	89c080e7          	jalr	-1892(ra) # 800031e0 <bfree>
    8000394c:	b7ed                	j	80003936 <itrunc+0x74>
    brelse(bp);
    8000394e:	8552                	mv	a0,s4
    80003950:	fffff097          	auipc	ra,0xfffff
    80003954:	77a080e7          	jalr	1914(ra) # 800030ca <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80003958:	0809a583          	lw	a1,128(s3)
    8000395c:	0009a503          	lw	a0,0(s3)
    80003960:	00000097          	auipc	ra,0x0
    80003964:	880080e7          	jalr	-1920(ra) # 800031e0 <bfree>
    ip->addrs[NDIRECT] = 0;
    80003968:	0809a023          	sw	zero,128(s3)
    8000396c:	bf51                	j	80003900 <itrunc+0x3e>

000000008000396e <iput>:
{
    8000396e:	1101                	addi	sp,sp,-32
    80003970:	ec06                	sd	ra,24(sp)
    80003972:	e822                	sd	s0,16(sp)
    80003974:	e426                	sd	s1,8(sp)
    80003976:	e04a                	sd	s2,0(sp)
    80003978:	1000                	addi	s0,sp,32
    8000397a:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    8000397c:	0001d517          	auipc	a0,0x1d
    80003980:	90c50513          	addi	a0,a0,-1780 # 80020288 <itable>
    80003984:	ffffd097          	auipc	ra,0xffffd
    80003988:	252080e7          	jalr	594(ra) # 80000bd6 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    8000398c:	4498                	lw	a4,8(s1)
    8000398e:	4785                	li	a5,1
    80003990:	02f70363          	beq	a4,a5,800039b6 <iput+0x48>
  ip->ref--;
    80003994:	449c                	lw	a5,8(s1)
    80003996:	37fd                	addiw	a5,a5,-1
    80003998:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    8000399a:	0001d517          	auipc	a0,0x1d
    8000399e:	8ee50513          	addi	a0,a0,-1810 # 80020288 <itable>
    800039a2:	ffffd097          	auipc	ra,0xffffd
    800039a6:	2e8080e7          	jalr	744(ra) # 80000c8a <release>
}
    800039aa:	60e2                	ld	ra,24(sp)
    800039ac:	6442                	ld	s0,16(sp)
    800039ae:	64a2                	ld	s1,8(sp)
    800039b0:	6902                	ld	s2,0(sp)
    800039b2:	6105                	addi	sp,sp,32
    800039b4:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    800039b6:	40bc                	lw	a5,64(s1)
    800039b8:	dff1                	beqz	a5,80003994 <iput+0x26>
    800039ba:	04a49783          	lh	a5,74(s1)
    800039be:	fbf9                	bnez	a5,80003994 <iput+0x26>
    acquiresleep(&ip->lock);
    800039c0:	01048913          	addi	s2,s1,16
    800039c4:	854a                	mv	a0,s2
    800039c6:	00001097          	auipc	ra,0x1
    800039ca:	aa8080e7          	jalr	-1368(ra) # 8000446e <acquiresleep>
    release(&itable.lock);
    800039ce:	0001d517          	auipc	a0,0x1d
    800039d2:	8ba50513          	addi	a0,a0,-1862 # 80020288 <itable>
    800039d6:	ffffd097          	auipc	ra,0xffffd
    800039da:	2b4080e7          	jalr	692(ra) # 80000c8a <release>
    itrunc(ip);
    800039de:	8526                	mv	a0,s1
    800039e0:	00000097          	auipc	ra,0x0
    800039e4:	ee2080e7          	jalr	-286(ra) # 800038c2 <itrunc>
    ip->type = 0;
    800039e8:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    800039ec:	8526                	mv	a0,s1
    800039ee:	00000097          	auipc	ra,0x0
    800039f2:	cfc080e7          	jalr	-772(ra) # 800036ea <iupdate>
    ip->valid = 0;
    800039f6:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    800039fa:	854a                	mv	a0,s2
    800039fc:	00001097          	auipc	ra,0x1
    80003a00:	ac8080e7          	jalr	-1336(ra) # 800044c4 <releasesleep>
    acquire(&itable.lock);
    80003a04:	0001d517          	auipc	a0,0x1d
    80003a08:	88450513          	addi	a0,a0,-1916 # 80020288 <itable>
    80003a0c:	ffffd097          	auipc	ra,0xffffd
    80003a10:	1ca080e7          	jalr	458(ra) # 80000bd6 <acquire>
    80003a14:	b741                	j	80003994 <iput+0x26>

0000000080003a16 <iunlockput>:
{
    80003a16:	1101                	addi	sp,sp,-32
    80003a18:	ec06                	sd	ra,24(sp)
    80003a1a:	e822                	sd	s0,16(sp)
    80003a1c:	e426                	sd	s1,8(sp)
    80003a1e:	1000                	addi	s0,sp,32
    80003a20:	84aa                	mv	s1,a0
  iunlock(ip);
    80003a22:	00000097          	auipc	ra,0x0
    80003a26:	e54080e7          	jalr	-428(ra) # 80003876 <iunlock>
  iput(ip);
    80003a2a:	8526                	mv	a0,s1
    80003a2c:	00000097          	auipc	ra,0x0
    80003a30:	f42080e7          	jalr	-190(ra) # 8000396e <iput>
}
    80003a34:	60e2                	ld	ra,24(sp)
    80003a36:	6442                	ld	s0,16(sp)
    80003a38:	64a2                	ld	s1,8(sp)
    80003a3a:	6105                	addi	sp,sp,32
    80003a3c:	8082                	ret

0000000080003a3e <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80003a3e:	1141                	addi	sp,sp,-16
    80003a40:	e422                	sd	s0,8(sp)
    80003a42:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80003a44:	411c                	lw	a5,0(a0)
    80003a46:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80003a48:	415c                	lw	a5,4(a0)
    80003a4a:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80003a4c:	04451783          	lh	a5,68(a0)
    80003a50:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80003a54:	04a51783          	lh	a5,74(a0)
    80003a58:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80003a5c:	04c56783          	lwu	a5,76(a0)
    80003a60:	e99c                	sd	a5,16(a1)
}
    80003a62:	6422                	ld	s0,8(sp)
    80003a64:	0141                	addi	sp,sp,16
    80003a66:	8082                	ret

0000000080003a68 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003a68:	457c                	lw	a5,76(a0)
    80003a6a:	0ed7e963          	bltu	a5,a3,80003b5c <readi+0xf4>
{
    80003a6e:	7159                	addi	sp,sp,-112
    80003a70:	f486                	sd	ra,104(sp)
    80003a72:	f0a2                	sd	s0,96(sp)
    80003a74:	eca6                	sd	s1,88(sp)
    80003a76:	e8ca                	sd	s2,80(sp)
    80003a78:	e4ce                	sd	s3,72(sp)
    80003a7a:	e0d2                	sd	s4,64(sp)
    80003a7c:	fc56                	sd	s5,56(sp)
    80003a7e:	f85a                	sd	s6,48(sp)
    80003a80:	f45e                	sd	s7,40(sp)
    80003a82:	f062                	sd	s8,32(sp)
    80003a84:	ec66                	sd	s9,24(sp)
    80003a86:	e86a                	sd	s10,16(sp)
    80003a88:	e46e                	sd	s11,8(sp)
    80003a8a:	1880                	addi	s0,sp,112
    80003a8c:	8b2a                	mv	s6,a0
    80003a8e:	8bae                	mv	s7,a1
    80003a90:	8a32                	mv	s4,a2
    80003a92:	84b6                	mv	s1,a3
    80003a94:	8aba                	mv	s5,a4
  if(off > ip->size || off + n < off)
    80003a96:	9f35                	addw	a4,a4,a3
    return 0;
    80003a98:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80003a9a:	0ad76063          	bltu	a4,a3,80003b3a <readi+0xd2>
  if(off + n > ip->size)
    80003a9e:	00e7f463          	bgeu	a5,a4,80003aa6 <readi+0x3e>
    n = ip->size - off;
    80003aa2:	40d78abb          	subw	s5,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003aa6:	0a0a8963          	beqz	s5,80003b58 <readi+0xf0>
    80003aaa:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80003aac:	40000c93          	li	s9,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80003ab0:	5c7d                	li	s8,-1
    80003ab2:	a82d                	j	80003aec <readi+0x84>
    80003ab4:	020d1d93          	slli	s11,s10,0x20
    80003ab8:	020ddd93          	srli	s11,s11,0x20
    80003abc:	05890793          	addi	a5,s2,88
    80003ac0:	86ee                	mv	a3,s11
    80003ac2:	963e                	add	a2,a2,a5
    80003ac4:	85d2                	mv	a1,s4
    80003ac6:	855e                	mv	a0,s7
    80003ac8:	fffff097          	auipc	ra,0xfffff
    80003acc:	ad2080e7          	jalr	-1326(ra) # 8000259a <either_copyout>
    80003ad0:	05850d63          	beq	a0,s8,80003b2a <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80003ad4:	854a                	mv	a0,s2
    80003ad6:	fffff097          	auipc	ra,0xfffff
    80003ada:	5f4080e7          	jalr	1524(ra) # 800030ca <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003ade:	013d09bb          	addw	s3,s10,s3
    80003ae2:	009d04bb          	addw	s1,s10,s1
    80003ae6:	9a6e                	add	s4,s4,s11
    80003ae8:	0559f763          	bgeu	s3,s5,80003b36 <readi+0xce>
    uint addr = bmap(ip, off/BSIZE);
    80003aec:	00a4d59b          	srliw	a1,s1,0xa
    80003af0:	855a                	mv	a0,s6
    80003af2:	00000097          	auipc	ra,0x0
    80003af6:	8a2080e7          	jalr	-1886(ra) # 80003394 <bmap>
    80003afa:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    80003afe:	cd85                	beqz	a1,80003b36 <readi+0xce>
    bp = bread(ip->dev, addr);
    80003b00:	000b2503          	lw	a0,0(s6)
    80003b04:	fffff097          	auipc	ra,0xfffff
    80003b08:	496080e7          	jalr	1174(ra) # 80002f9a <bread>
    80003b0c:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003b0e:	3ff4f613          	andi	a2,s1,1023
    80003b12:	40cc87bb          	subw	a5,s9,a2
    80003b16:	413a873b          	subw	a4,s5,s3
    80003b1a:	8d3e                	mv	s10,a5
    80003b1c:	2781                	sext.w	a5,a5
    80003b1e:	0007069b          	sext.w	a3,a4
    80003b22:	f8f6f9e3          	bgeu	a3,a5,80003ab4 <readi+0x4c>
    80003b26:	8d3a                	mv	s10,a4
    80003b28:	b771                	j	80003ab4 <readi+0x4c>
      brelse(bp);
    80003b2a:	854a                	mv	a0,s2
    80003b2c:	fffff097          	auipc	ra,0xfffff
    80003b30:	59e080e7          	jalr	1438(ra) # 800030ca <brelse>
      tot = -1;
    80003b34:	59fd                	li	s3,-1
  }
  return tot;
    80003b36:	0009851b          	sext.w	a0,s3
}
    80003b3a:	70a6                	ld	ra,104(sp)
    80003b3c:	7406                	ld	s0,96(sp)
    80003b3e:	64e6                	ld	s1,88(sp)
    80003b40:	6946                	ld	s2,80(sp)
    80003b42:	69a6                	ld	s3,72(sp)
    80003b44:	6a06                	ld	s4,64(sp)
    80003b46:	7ae2                	ld	s5,56(sp)
    80003b48:	7b42                	ld	s6,48(sp)
    80003b4a:	7ba2                	ld	s7,40(sp)
    80003b4c:	7c02                	ld	s8,32(sp)
    80003b4e:	6ce2                	ld	s9,24(sp)
    80003b50:	6d42                	ld	s10,16(sp)
    80003b52:	6da2                	ld	s11,8(sp)
    80003b54:	6165                	addi	sp,sp,112
    80003b56:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003b58:	89d6                	mv	s3,s5
    80003b5a:	bff1                	j	80003b36 <readi+0xce>
    return 0;
    80003b5c:	4501                	li	a0,0
}
    80003b5e:	8082                	ret

0000000080003b60 <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003b60:	457c                	lw	a5,76(a0)
    80003b62:	10d7e863          	bltu	a5,a3,80003c72 <writei+0x112>
{
    80003b66:	7159                	addi	sp,sp,-112
    80003b68:	f486                	sd	ra,104(sp)
    80003b6a:	f0a2                	sd	s0,96(sp)
    80003b6c:	eca6                	sd	s1,88(sp)
    80003b6e:	e8ca                	sd	s2,80(sp)
    80003b70:	e4ce                	sd	s3,72(sp)
    80003b72:	e0d2                	sd	s4,64(sp)
    80003b74:	fc56                	sd	s5,56(sp)
    80003b76:	f85a                	sd	s6,48(sp)
    80003b78:	f45e                	sd	s7,40(sp)
    80003b7a:	f062                	sd	s8,32(sp)
    80003b7c:	ec66                	sd	s9,24(sp)
    80003b7e:	e86a                	sd	s10,16(sp)
    80003b80:	e46e                	sd	s11,8(sp)
    80003b82:	1880                	addi	s0,sp,112
    80003b84:	8aaa                	mv	s5,a0
    80003b86:	8bae                	mv	s7,a1
    80003b88:	8a32                	mv	s4,a2
    80003b8a:	8936                	mv	s2,a3
    80003b8c:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80003b8e:	00e687bb          	addw	a5,a3,a4
    80003b92:	0ed7e263          	bltu	a5,a3,80003c76 <writei+0x116>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80003b96:	00043737          	lui	a4,0x43
    80003b9a:	0ef76063          	bltu	a4,a5,80003c7a <writei+0x11a>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003b9e:	0c0b0863          	beqz	s6,80003c6e <writei+0x10e>
    80003ba2:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80003ba4:	40000c93          	li	s9,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80003ba8:	5c7d                	li	s8,-1
    80003baa:	a091                	j	80003bee <writei+0x8e>
    80003bac:	020d1d93          	slli	s11,s10,0x20
    80003bb0:	020ddd93          	srli	s11,s11,0x20
    80003bb4:	05848793          	addi	a5,s1,88
    80003bb8:	86ee                	mv	a3,s11
    80003bba:	8652                	mv	a2,s4
    80003bbc:	85de                	mv	a1,s7
    80003bbe:	953e                	add	a0,a0,a5
    80003bc0:	fffff097          	auipc	ra,0xfffff
    80003bc4:	a30080e7          	jalr	-1488(ra) # 800025f0 <either_copyin>
    80003bc8:	07850263          	beq	a0,s8,80003c2c <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    80003bcc:	8526                	mv	a0,s1
    80003bce:	00000097          	auipc	ra,0x0
    80003bd2:	780080e7          	jalr	1920(ra) # 8000434e <log_write>
    brelse(bp);
    80003bd6:	8526                	mv	a0,s1
    80003bd8:	fffff097          	auipc	ra,0xfffff
    80003bdc:	4f2080e7          	jalr	1266(ra) # 800030ca <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003be0:	013d09bb          	addw	s3,s10,s3
    80003be4:	012d093b          	addw	s2,s10,s2
    80003be8:	9a6e                	add	s4,s4,s11
    80003bea:	0569f663          	bgeu	s3,s6,80003c36 <writei+0xd6>
    uint addr = bmap(ip, off/BSIZE);
    80003bee:	00a9559b          	srliw	a1,s2,0xa
    80003bf2:	8556                	mv	a0,s5
    80003bf4:	fffff097          	auipc	ra,0xfffff
    80003bf8:	7a0080e7          	jalr	1952(ra) # 80003394 <bmap>
    80003bfc:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    80003c00:	c99d                	beqz	a1,80003c36 <writei+0xd6>
    bp = bread(ip->dev, addr);
    80003c02:	000aa503          	lw	a0,0(s5)
    80003c06:	fffff097          	auipc	ra,0xfffff
    80003c0a:	394080e7          	jalr	916(ra) # 80002f9a <bread>
    80003c0e:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003c10:	3ff97513          	andi	a0,s2,1023
    80003c14:	40ac87bb          	subw	a5,s9,a0
    80003c18:	413b073b          	subw	a4,s6,s3
    80003c1c:	8d3e                	mv	s10,a5
    80003c1e:	2781                	sext.w	a5,a5
    80003c20:	0007069b          	sext.w	a3,a4
    80003c24:	f8f6f4e3          	bgeu	a3,a5,80003bac <writei+0x4c>
    80003c28:	8d3a                	mv	s10,a4
    80003c2a:	b749                	j	80003bac <writei+0x4c>
      brelse(bp);
    80003c2c:	8526                	mv	a0,s1
    80003c2e:	fffff097          	auipc	ra,0xfffff
    80003c32:	49c080e7          	jalr	1180(ra) # 800030ca <brelse>
  }

  if(off > ip->size)
    80003c36:	04caa783          	lw	a5,76(s5)
    80003c3a:	0127f463          	bgeu	a5,s2,80003c42 <writei+0xe2>
    ip->size = off;
    80003c3e:	052aa623          	sw	s2,76(s5)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80003c42:	8556                	mv	a0,s5
    80003c44:	00000097          	auipc	ra,0x0
    80003c48:	aa6080e7          	jalr	-1370(ra) # 800036ea <iupdate>

  return tot;
    80003c4c:	0009851b          	sext.w	a0,s3
}
    80003c50:	70a6                	ld	ra,104(sp)
    80003c52:	7406                	ld	s0,96(sp)
    80003c54:	64e6                	ld	s1,88(sp)
    80003c56:	6946                	ld	s2,80(sp)
    80003c58:	69a6                	ld	s3,72(sp)
    80003c5a:	6a06                	ld	s4,64(sp)
    80003c5c:	7ae2                	ld	s5,56(sp)
    80003c5e:	7b42                	ld	s6,48(sp)
    80003c60:	7ba2                	ld	s7,40(sp)
    80003c62:	7c02                	ld	s8,32(sp)
    80003c64:	6ce2                	ld	s9,24(sp)
    80003c66:	6d42                	ld	s10,16(sp)
    80003c68:	6da2                	ld	s11,8(sp)
    80003c6a:	6165                	addi	sp,sp,112
    80003c6c:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003c6e:	89da                	mv	s3,s6
    80003c70:	bfc9                	j	80003c42 <writei+0xe2>
    return -1;
    80003c72:	557d                	li	a0,-1
}
    80003c74:	8082                	ret
    return -1;
    80003c76:	557d                	li	a0,-1
    80003c78:	bfe1                	j	80003c50 <writei+0xf0>
    return -1;
    80003c7a:	557d                	li	a0,-1
    80003c7c:	bfd1                	j	80003c50 <writei+0xf0>

0000000080003c7e <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80003c7e:	1141                	addi	sp,sp,-16
    80003c80:	e406                	sd	ra,8(sp)
    80003c82:	e022                	sd	s0,0(sp)
    80003c84:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80003c86:	4639                	li	a2,14
    80003c88:	ffffd097          	auipc	ra,0xffffd
    80003c8c:	11a080e7          	jalr	282(ra) # 80000da2 <strncmp>
}
    80003c90:	60a2                	ld	ra,8(sp)
    80003c92:	6402                	ld	s0,0(sp)
    80003c94:	0141                	addi	sp,sp,16
    80003c96:	8082                	ret

0000000080003c98 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80003c98:	7139                	addi	sp,sp,-64
    80003c9a:	fc06                	sd	ra,56(sp)
    80003c9c:	f822                	sd	s0,48(sp)
    80003c9e:	f426                	sd	s1,40(sp)
    80003ca0:	f04a                	sd	s2,32(sp)
    80003ca2:	ec4e                	sd	s3,24(sp)
    80003ca4:	e852                	sd	s4,16(sp)
    80003ca6:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80003ca8:	04451703          	lh	a4,68(a0)
    80003cac:	4785                	li	a5,1
    80003cae:	00f71a63          	bne	a4,a5,80003cc2 <dirlookup+0x2a>
    80003cb2:	892a                	mv	s2,a0
    80003cb4:	89ae                	mv	s3,a1
    80003cb6:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80003cb8:	457c                	lw	a5,76(a0)
    80003cba:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80003cbc:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003cbe:	e79d                	bnez	a5,80003cec <dirlookup+0x54>
    80003cc0:	a8a5                	j	80003d38 <dirlookup+0xa0>
    panic("dirlookup not DIR");
    80003cc2:	00005517          	auipc	a0,0x5
    80003cc6:	93e50513          	addi	a0,a0,-1730 # 80008600 <syscalls+0x1a8>
    80003cca:	ffffd097          	auipc	ra,0xffffd
    80003cce:	874080e7          	jalr	-1932(ra) # 8000053e <panic>
      panic("dirlookup read");
    80003cd2:	00005517          	auipc	a0,0x5
    80003cd6:	94650513          	addi	a0,a0,-1722 # 80008618 <syscalls+0x1c0>
    80003cda:	ffffd097          	auipc	ra,0xffffd
    80003cde:	864080e7          	jalr	-1948(ra) # 8000053e <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003ce2:	24c1                	addiw	s1,s1,16
    80003ce4:	04c92783          	lw	a5,76(s2)
    80003ce8:	04f4f763          	bgeu	s1,a5,80003d36 <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003cec:	4741                	li	a4,16
    80003cee:	86a6                	mv	a3,s1
    80003cf0:	fc040613          	addi	a2,s0,-64
    80003cf4:	4581                	li	a1,0
    80003cf6:	854a                	mv	a0,s2
    80003cf8:	00000097          	auipc	ra,0x0
    80003cfc:	d70080e7          	jalr	-656(ra) # 80003a68 <readi>
    80003d00:	47c1                	li	a5,16
    80003d02:	fcf518e3          	bne	a0,a5,80003cd2 <dirlookup+0x3a>
    if(de.inum == 0)
    80003d06:	fc045783          	lhu	a5,-64(s0)
    80003d0a:	dfe1                	beqz	a5,80003ce2 <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    80003d0c:	fc240593          	addi	a1,s0,-62
    80003d10:	854e                	mv	a0,s3
    80003d12:	00000097          	auipc	ra,0x0
    80003d16:	f6c080e7          	jalr	-148(ra) # 80003c7e <namecmp>
    80003d1a:	f561                	bnez	a0,80003ce2 <dirlookup+0x4a>
      if(poff)
    80003d1c:	000a0463          	beqz	s4,80003d24 <dirlookup+0x8c>
        *poff = off;
    80003d20:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    80003d24:	fc045583          	lhu	a1,-64(s0)
    80003d28:	00092503          	lw	a0,0(s2)
    80003d2c:	fffff097          	auipc	ra,0xfffff
    80003d30:	750080e7          	jalr	1872(ra) # 8000347c <iget>
    80003d34:	a011                	j	80003d38 <dirlookup+0xa0>
  return 0;
    80003d36:	4501                	li	a0,0
}
    80003d38:	70e2                	ld	ra,56(sp)
    80003d3a:	7442                	ld	s0,48(sp)
    80003d3c:	74a2                	ld	s1,40(sp)
    80003d3e:	7902                	ld	s2,32(sp)
    80003d40:	69e2                	ld	s3,24(sp)
    80003d42:	6a42                	ld	s4,16(sp)
    80003d44:	6121                	addi	sp,sp,64
    80003d46:	8082                	ret

0000000080003d48 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80003d48:	711d                	addi	sp,sp,-96
    80003d4a:	ec86                	sd	ra,88(sp)
    80003d4c:	e8a2                	sd	s0,80(sp)
    80003d4e:	e4a6                	sd	s1,72(sp)
    80003d50:	e0ca                	sd	s2,64(sp)
    80003d52:	fc4e                	sd	s3,56(sp)
    80003d54:	f852                	sd	s4,48(sp)
    80003d56:	f456                	sd	s5,40(sp)
    80003d58:	f05a                	sd	s6,32(sp)
    80003d5a:	ec5e                	sd	s7,24(sp)
    80003d5c:	e862                	sd	s8,16(sp)
    80003d5e:	e466                	sd	s9,8(sp)
    80003d60:	1080                	addi	s0,sp,96
    80003d62:	84aa                	mv	s1,a0
    80003d64:	8aae                	mv	s5,a1
    80003d66:	8a32                	mv	s4,a2
  struct inode *ip, *next;

  if(*path == '/')
    80003d68:	00054703          	lbu	a4,0(a0)
    80003d6c:	02f00793          	li	a5,47
    80003d70:	02f70363          	beq	a4,a5,80003d96 <namex+0x4e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80003d74:	ffffe097          	auipc	ra,0xffffe
    80003d78:	c48080e7          	jalr	-952(ra) # 800019bc <myproc>
    80003d7c:	19853503          	ld	a0,408(a0)
    80003d80:	00000097          	auipc	ra,0x0
    80003d84:	9f6080e7          	jalr	-1546(ra) # 80003776 <idup>
    80003d88:	89aa                	mv	s3,a0
  while(*path == '/')
    80003d8a:	02f00913          	li	s2,47
  len = path - s;
    80003d8e:	4b01                	li	s6,0
  if(len >= DIRSIZ)
    80003d90:	4c35                	li	s8,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80003d92:	4b85                	li	s7,1
    80003d94:	a865                	j	80003e4c <namex+0x104>
    ip = iget(ROOTDEV, ROOTINO);
    80003d96:	4585                	li	a1,1
    80003d98:	4505                	li	a0,1
    80003d9a:	fffff097          	auipc	ra,0xfffff
    80003d9e:	6e2080e7          	jalr	1762(ra) # 8000347c <iget>
    80003da2:	89aa                	mv	s3,a0
    80003da4:	b7dd                	j	80003d8a <namex+0x42>
      iunlockput(ip);
    80003da6:	854e                	mv	a0,s3
    80003da8:	00000097          	auipc	ra,0x0
    80003dac:	c6e080e7          	jalr	-914(ra) # 80003a16 <iunlockput>
      return 0;
    80003db0:	4981                	li	s3,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80003db2:	854e                	mv	a0,s3
    80003db4:	60e6                	ld	ra,88(sp)
    80003db6:	6446                	ld	s0,80(sp)
    80003db8:	64a6                	ld	s1,72(sp)
    80003dba:	6906                	ld	s2,64(sp)
    80003dbc:	79e2                	ld	s3,56(sp)
    80003dbe:	7a42                	ld	s4,48(sp)
    80003dc0:	7aa2                	ld	s5,40(sp)
    80003dc2:	7b02                	ld	s6,32(sp)
    80003dc4:	6be2                	ld	s7,24(sp)
    80003dc6:	6c42                	ld	s8,16(sp)
    80003dc8:	6ca2                	ld	s9,8(sp)
    80003dca:	6125                	addi	sp,sp,96
    80003dcc:	8082                	ret
      iunlock(ip);
    80003dce:	854e                	mv	a0,s3
    80003dd0:	00000097          	auipc	ra,0x0
    80003dd4:	aa6080e7          	jalr	-1370(ra) # 80003876 <iunlock>
      return ip;
    80003dd8:	bfe9                	j	80003db2 <namex+0x6a>
      iunlockput(ip);
    80003dda:	854e                	mv	a0,s3
    80003ddc:	00000097          	auipc	ra,0x0
    80003de0:	c3a080e7          	jalr	-966(ra) # 80003a16 <iunlockput>
      return 0;
    80003de4:	89e6                	mv	s3,s9
    80003de6:	b7f1                	j	80003db2 <namex+0x6a>
  len = path - s;
    80003de8:	40b48633          	sub	a2,s1,a1
    80003dec:	00060c9b          	sext.w	s9,a2
  if(len >= DIRSIZ)
    80003df0:	099c5463          	bge	s8,s9,80003e78 <namex+0x130>
    memmove(name, s, DIRSIZ);
    80003df4:	4639                	li	a2,14
    80003df6:	8552                	mv	a0,s4
    80003df8:	ffffd097          	auipc	ra,0xffffd
    80003dfc:	f36080e7          	jalr	-202(ra) # 80000d2e <memmove>
  while(*path == '/')
    80003e00:	0004c783          	lbu	a5,0(s1)
    80003e04:	01279763          	bne	a5,s2,80003e12 <namex+0xca>
    path++;
    80003e08:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003e0a:	0004c783          	lbu	a5,0(s1)
    80003e0e:	ff278de3          	beq	a5,s2,80003e08 <namex+0xc0>
    ilock(ip);
    80003e12:	854e                	mv	a0,s3
    80003e14:	00000097          	auipc	ra,0x0
    80003e18:	9a0080e7          	jalr	-1632(ra) # 800037b4 <ilock>
    if(ip->type != T_DIR){
    80003e1c:	04499783          	lh	a5,68(s3)
    80003e20:	f97793e3          	bne	a5,s7,80003da6 <namex+0x5e>
    if(nameiparent && *path == '\0'){
    80003e24:	000a8563          	beqz	s5,80003e2e <namex+0xe6>
    80003e28:	0004c783          	lbu	a5,0(s1)
    80003e2c:	d3cd                	beqz	a5,80003dce <namex+0x86>
    if((next = dirlookup(ip, name, 0)) == 0){
    80003e2e:	865a                	mv	a2,s6
    80003e30:	85d2                	mv	a1,s4
    80003e32:	854e                	mv	a0,s3
    80003e34:	00000097          	auipc	ra,0x0
    80003e38:	e64080e7          	jalr	-412(ra) # 80003c98 <dirlookup>
    80003e3c:	8caa                	mv	s9,a0
    80003e3e:	dd51                	beqz	a0,80003dda <namex+0x92>
    iunlockput(ip);
    80003e40:	854e                	mv	a0,s3
    80003e42:	00000097          	auipc	ra,0x0
    80003e46:	bd4080e7          	jalr	-1068(ra) # 80003a16 <iunlockput>
    ip = next;
    80003e4a:	89e6                	mv	s3,s9
  while(*path == '/')
    80003e4c:	0004c783          	lbu	a5,0(s1)
    80003e50:	05279763          	bne	a5,s2,80003e9e <namex+0x156>
    path++;
    80003e54:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003e56:	0004c783          	lbu	a5,0(s1)
    80003e5a:	ff278de3          	beq	a5,s2,80003e54 <namex+0x10c>
  if(*path == 0)
    80003e5e:	c79d                	beqz	a5,80003e8c <namex+0x144>
    path++;
    80003e60:	85a6                	mv	a1,s1
  len = path - s;
    80003e62:	8cda                	mv	s9,s6
    80003e64:	865a                	mv	a2,s6
  while(*path != '/' && *path != 0)
    80003e66:	01278963          	beq	a5,s2,80003e78 <namex+0x130>
    80003e6a:	dfbd                	beqz	a5,80003de8 <namex+0xa0>
    path++;
    80003e6c:	0485                	addi	s1,s1,1
  while(*path != '/' && *path != 0)
    80003e6e:	0004c783          	lbu	a5,0(s1)
    80003e72:	ff279ce3          	bne	a5,s2,80003e6a <namex+0x122>
    80003e76:	bf8d                	j	80003de8 <namex+0xa0>
    memmove(name, s, len);
    80003e78:	2601                	sext.w	a2,a2
    80003e7a:	8552                	mv	a0,s4
    80003e7c:	ffffd097          	auipc	ra,0xffffd
    80003e80:	eb2080e7          	jalr	-334(ra) # 80000d2e <memmove>
    name[len] = 0;
    80003e84:	9cd2                	add	s9,s9,s4
    80003e86:	000c8023          	sb	zero,0(s9) # 2000 <_entry-0x7fffe000>
    80003e8a:	bf9d                	j	80003e00 <namex+0xb8>
  if(nameiparent){
    80003e8c:	f20a83e3          	beqz	s5,80003db2 <namex+0x6a>
    iput(ip);
    80003e90:	854e                	mv	a0,s3
    80003e92:	00000097          	auipc	ra,0x0
    80003e96:	adc080e7          	jalr	-1316(ra) # 8000396e <iput>
    return 0;
    80003e9a:	4981                	li	s3,0
    80003e9c:	bf19                	j	80003db2 <namex+0x6a>
  if(*path == 0)
    80003e9e:	d7fd                	beqz	a5,80003e8c <namex+0x144>
  while(*path != '/' && *path != 0)
    80003ea0:	0004c783          	lbu	a5,0(s1)
    80003ea4:	85a6                	mv	a1,s1
    80003ea6:	b7d1                	j	80003e6a <namex+0x122>

0000000080003ea8 <dirlink>:
{
    80003ea8:	7139                	addi	sp,sp,-64
    80003eaa:	fc06                	sd	ra,56(sp)
    80003eac:	f822                	sd	s0,48(sp)
    80003eae:	f426                	sd	s1,40(sp)
    80003eb0:	f04a                	sd	s2,32(sp)
    80003eb2:	ec4e                	sd	s3,24(sp)
    80003eb4:	e852                	sd	s4,16(sp)
    80003eb6:	0080                	addi	s0,sp,64
    80003eb8:	892a                	mv	s2,a0
    80003eba:	8a2e                	mv	s4,a1
    80003ebc:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80003ebe:	4601                	li	a2,0
    80003ec0:	00000097          	auipc	ra,0x0
    80003ec4:	dd8080e7          	jalr	-552(ra) # 80003c98 <dirlookup>
    80003ec8:	e93d                	bnez	a0,80003f3e <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003eca:	04c92483          	lw	s1,76(s2)
    80003ece:	c49d                	beqz	s1,80003efc <dirlink+0x54>
    80003ed0:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003ed2:	4741                	li	a4,16
    80003ed4:	86a6                	mv	a3,s1
    80003ed6:	fc040613          	addi	a2,s0,-64
    80003eda:	4581                	li	a1,0
    80003edc:	854a                	mv	a0,s2
    80003ede:	00000097          	auipc	ra,0x0
    80003ee2:	b8a080e7          	jalr	-1142(ra) # 80003a68 <readi>
    80003ee6:	47c1                	li	a5,16
    80003ee8:	06f51163          	bne	a0,a5,80003f4a <dirlink+0xa2>
    if(de.inum == 0)
    80003eec:	fc045783          	lhu	a5,-64(s0)
    80003ef0:	c791                	beqz	a5,80003efc <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003ef2:	24c1                	addiw	s1,s1,16
    80003ef4:	04c92783          	lw	a5,76(s2)
    80003ef8:	fcf4ede3          	bltu	s1,a5,80003ed2 <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    80003efc:	4639                	li	a2,14
    80003efe:	85d2                	mv	a1,s4
    80003f00:	fc240513          	addi	a0,s0,-62
    80003f04:	ffffd097          	auipc	ra,0xffffd
    80003f08:	eda080e7          	jalr	-294(ra) # 80000dde <strncpy>
  de.inum = inum;
    80003f0c:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003f10:	4741                	li	a4,16
    80003f12:	86a6                	mv	a3,s1
    80003f14:	fc040613          	addi	a2,s0,-64
    80003f18:	4581                	li	a1,0
    80003f1a:	854a                	mv	a0,s2
    80003f1c:	00000097          	auipc	ra,0x0
    80003f20:	c44080e7          	jalr	-956(ra) # 80003b60 <writei>
    80003f24:	1541                	addi	a0,a0,-16
    80003f26:	00a03533          	snez	a0,a0
    80003f2a:	40a00533          	neg	a0,a0
}
    80003f2e:	70e2                	ld	ra,56(sp)
    80003f30:	7442                	ld	s0,48(sp)
    80003f32:	74a2                	ld	s1,40(sp)
    80003f34:	7902                	ld	s2,32(sp)
    80003f36:	69e2                	ld	s3,24(sp)
    80003f38:	6a42                	ld	s4,16(sp)
    80003f3a:	6121                	addi	sp,sp,64
    80003f3c:	8082                	ret
    iput(ip);
    80003f3e:	00000097          	auipc	ra,0x0
    80003f42:	a30080e7          	jalr	-1488(ra) # 8000396e <iput>
    return -1;
    80003f46:	557d                	li	a0,-1
    80003f48:	b7dd                	j	80003f2e <dirlink+0x86>
      panic("dirlink read");
    80003f4a:	00004517          	auipc	a0,0x4
    80003f4e:	6de50513          	addi	a0,a0,1758 # 80008628 <syscalls+0x1d0>
    80003f52:	ffffc097          	auipc	ra,0xffffc
    80003f56:	5ec080e7          	jalr	1516(ra) # 8000053e <panic>

0000000080003f5a <namei>:

struct inode*
namei(char *path)
{
    80003f5a:	1101                	addi	sp,sp,-32
    80003f5c:	ec06                	sd	ra,24(sp)
    80003f5e:	e822                	sd	s0,16(sp)
    80003f60:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80003f62:	fe040613          	addi	a2,s0,-32
    80003f66:	4581                	li	a1,0
    80003f68:	00000097          	auipc	ra,0x0
    80003f6c:	de0080e7          	jalr	-544(ra) # 80003d48 <namex>
}
    80003f70:	60e2                	ld	ra,24(sp)
    80003f72:	6442                	ld	s0,16(sp)
    80003f74:	6105                	addi	sp,sp,32
    80003f76:	8082                	ret

0000000080003f78 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80003f78:	1141                	addi	sp,sp,-16
    80003f7a:	e406                	sd	ra,8(sp)
    80003f7c:	e022                	sd	s0,0(sp)
    80003f7e:	0800                	addi	s0,sp,16
    80003f80:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80003f82:	4585                	li	a1,1
    80003f84:	00000097          	auipc	ra,0x0
    80003f88:	dc4080e7          	jalr	-572(ra) # 80003d48 <namex>
}
    80003f8c:	60a2                	ld	ra,8(sp)
    80003f8e:	6402                	ld	s0,0(sp)
    80003f90:	0141                	addi	sp,sp,16
    80003f92:	8082                	ret

0000000080003f94 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80003f94:	1101                	addi	sp,sp,-32
    80003f96:	ec06                	sd	ra,24(sp)
    80003f98:	e822                	sd	s0,16(sp)
    80003f9a:	e426                	sd	s1,8(sp)
    80003f9c:	e04a                	sd	s2,0(sp)
    80003f9e:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80003fa0:	0001e917          	auipc	s2,0x1e
    80003fa4:	d9090913          	addi	s2,s2,-624 # 80021d30 <log>
    80003fa8:	01892583          	lw	a1,24(s2)
    80003fac:	02892503          	lw	a0,40(s2)
    80003fb0:	fffff097          	auipc	ra,0xfffff
    80003fb4:	fea080e7          	jalr	-22(ra) # 80002f9a <bread>
    80003fb8:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    80003fba:	02c92683          	lw	a3,44(s2)
    80003fbe:	cd34                	sw	a3,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80003fc0:	02d05763          	blez	a3,80003fee <write_head+0x5a>
    80003fc4:	0001e797          	auipc	a5,0x1e
    80003fc8:	d9c78793          	addi	a5,a5,-612 # 80021d60 <log+0x30>
    80003fcc:	05c50713          	addi	a4,a0,92
    80003fd0:	36fd                	addiw	a3,a3,-1
    80003fd2:	1682                	slli	a3,a3,0x20
    80003fd4:	9281                	srli	a3,a3,0x20
    80003fd6:	068a                	slli	a3,a3,0x2
    80003fd8:	0001e617          	auipc	a2,0x1e
    80003fdc:	d8c60613          	addi	a2,a2,-628 # 80021d64 <log+0x34>
    80003fe0:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    80003fe2:	4390                	lw	a2,0(a5)
    80003fe4:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80003fe6:	0791                	addi	a5,a5,4
    80003fe8:	0711                	addi	a4,a4,4
    80003fea:	fed79ce3          	bne	a5,a3,80003fe2 <write_head+0x4e>
  }
  bwrite(buf);
    80003fee:	8526                	mv	a0,s1
    80003ff0:	fffff097          	auipc	ra,0xfffff
    80003ff4:	09c080e7          	jalr	156(ra) # 8000308c <bwrite>
  brelse(buf);
    80003ff8:	8526                	mv	a0,s1
    80003ffa:	fffff097          	auipc	ra,0xfffff
    80003ffe:	0d0080e7          	jalr	208(ra) # 800030ca <brelse>
}
    80004002:	60e2                	ld	ra,24(sp)
    80004004:	6442                	ld	s0,16(sp)
    80004006:	64a2                	ld	s1,8(sp)
    80004008:	6902                	ld	s2,0(sp)
    8000400a:	6105                	addi	sp,sp,32
    8000400c:	8082                	ret

000000008000400e <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    8000400e:	0001e797          	auipc	a5,0x1e
    80004012:	d4e7a783          	lw	a5,-690(a5) # 80021d5c <log+0x2c>
    80004016:	0af05d63          	blez	a5,800040d0 <install_trans+0xc2>
{
    8000401a:	7139                	addi	sp,sp,-64
    8000401c:	fc06                	sd	ra,56(sp)
    8000401e:	f822                	sd	s0,48(sp)
    80004020:	f426                	sd	s1,40(sp)
    80004022:	f04a                	sd	s2,32(sp)
    80004024:	ec4e                	sd	s3,24(sp)
    80004026:	e852                	sd	s4,16(sp)
    80004028:	e456                	sd	s5,8(sp)
    8000402a:	e05a                	sd	s6,0(sp)
    8000402c:	0080                	addi	s0,sp,64
    8000402e:	8b2a                	mv	s6,a0
    80004030:	0001ea97          	auipc	s5,0x1e
    80004034:	d30a8a93          	addi	s5,s5,-720 # 80021d60 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    80004038:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    8000403a:	0001e997          	auipc	s3,0x1e
    8000403e:	cf698993          	addi	s3,s3,-778 # 80021d30 <log>
    80004042:	a00d                	j	80004064 <install_trans+0x56>
    brelse(lbuf);
    80004044:	854a                	mv	a0,s2
    80004046:	fffff097          	auipc	ra,0xfffff
    8000404a:	084080e7          	jalr	132(ra) # 800030ca <brelse>
    brelse(dbuf);
    8000404e:	8526                	mv	a0,s1
    80004050:	fffff097          	auipc	ra,0xfffff
    80004054:	07a080e7          	jalr	122(ra) # 800030ca <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80004058:	2a05                	addiw	s4,s4,1
    8000405a:	0a91                	addi	s5,s5,4
    8000405c:	02c9a783          	lw	a5,44(s3)
    80004060:	04fa5e63          	bge	s4,a5,800040bc <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80004064:	0189a583          	lw	a1,24(s3)
    80004068:	014585bb          	addw	a1,a1,s4
    8000406c:	2585                	addiw	a1,a1,1
    8000406e:	0289a503          	lw	a0,40(s3)
    80004072:	fffff097          	auipc	ra,0xfffff
    80004076:	f28080e7          	jalr	-216(ra) # 80002f9a <bread>
    8000407a:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    8000407c:	000aa583          	lw	a1,0(s5)
    80004080:	0289a503          	lw	a0,40(s3)
    80004084:	fffff097          	auipc	ra,0xfffff
    80004088:	f16080e7          	jalr	-234(ra) # 80002f9a <bread>
    8000408c:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    8000408e:	40000613          	li	a2,1024
    80004092:	05890593          	addi	a1,s2,88
    80004096:	05850513          	addi	a0,a0,88
    8000409a:	ffffd097          	auipc	ra,0xffffd
    8000409e:	c94080e7          	jalr	-876(ra) # 80000d2e <memmove>
    bwrite(dbuf);  // write dst to disk
    800040a2:	8526                	mv	a0,s1
    800040a4:	fffff097          	auipc	ra,0xfffff
    800040a8:	fe8080e7          	jalr	-24(ra) # 8000308c <bwrite>
    if(recovering == 0)
    800040ac:	f80b1ce3          	bnez	s6,80004044 <install_trans+0x36>
      bunpin(dbuf);
    800040b0:	8526                	mv	a0,s1
    800040b2:	fffff097          	auipc	ra,0xfffff
    800040b6:	0f2080e7          	jalr	242(ra) # 800031a4 <bunpin>
    800040ba:	b769                	j	80004044 <install_trans+0x36>
}
    800040bc:	70e2                	ld	ra,56(sp)
    800040be:	7442                	ld	s0,48(sp)
    800040c0:	74a2                	ld	s1,40(sp)
    800040c2:	7902                	ld	s2,32(sp)
    800040c4:	69e2                	ld	s3,24(sp)
    800040c6:	6a42                	ld	s4,16(sp)
    800040c8:	6aa2                	ld	s5,8(sp)
    800040ca:	6b02                	ld	s6,0(sp)
    800040cc:	6121                	addi	sp,sp,64
    800040ce:	8082                	ret
    800040d0:	8082                	ret

00000000800040d2 <initlog>:
{
    800040d2:	7179                	addi	sp,sp,-48
    800040d4:	f406                	sd	ra,40(sp)
    800040d6:	f022                	sd	s0,32(sp)
    800040d8:	ec26                	sd	s1,24(sp)
    800040da:	e84a                	sd	s2,16(sp)
    800040dc:	e44e                	sd	s3,8(sp)
    800040de:	1800                	addi	s0,sp,48
    800040e0:	892a                	mv	s2,a0
    800040e2:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    800040e4:	0001e497          	auipc	s1,0x1e
    800040e8:	c4c48493          	addi	s1,s1,-948 # 80021d30 <log>
    800040ec:	00004597          	auipc	a1,0x4
    800040f0:	54c58593          	addi	a1,a1,1356 # 80008638 <syscalls+0x1e0>
    800040f4:	8526                	mv	a0,s1
    800040f6:	ffffd097          	auipc	ra,0xffffd
    800040fa:	a50080e7          	jalr	-1456(ra) # 80000b46 <initlock>
  log.start = sb->logstart;
    800040fe:	0149a583          	lw	a1,20(s3)
    80004102:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    80004104:	0109a783          	lw	a5,16(s3)
    80004108:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    8000410a:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    8000410e:	854a                	mv	a0,s2
    80004110:	fffff097          	auipc	ra,0xfffff
    80004114:	e8a080e7          	jalr	-374(ra) # 80002f9a <bread>
  log.lh.n = lh->n;
    80004118:	4d34                	lw	a3,88(a0)
    8000411a:	d4d4                	sw	a3,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    8000411c:	02d05563          	blez	a3,80004146 <initlog+0x74>
    80004120:	05c50793          	addi	a5,a0,92
    80004124:	0001e717          	auipc	a4,0x1e
    80004128:	c3c70713          	addi	a4,a4,-964 # 80021d60 <log+0x30>
    8000412c:	36fd                	addiw	a3,a3,-1
    8000412e:	1682                	slli	a3,a3,0x20
    80004130:	9281                	srli	a3,a3,0x20
    80004132:	068a                	slli	a3,a3,0x2
    80004134:	06050613          	addi	a2,a0,96
    80004138:	96b2                	add	a3,a3,a2
    log.lh.block[i] = lh->block[i];
    8000413a:	4390                	lw	a2,0(a5)
    8000413c:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    8000413e:	0791                	addi	a5,a5,4
    80004140:	0711                	addi	a4,a4,4
    80004142:	fed79ce3          	bne	a5,a3,8000413a <initlog+0x68>
  brelse(buf);
    80004146:	fffff097          	auipc	ra,0xfffff
    8000414a:	f84080e7          	jalr	-124(ra) # 800030ca <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    8000414e:	4505                	li	a0,1
    80004150:	00000097          	auipc	ra,0x0
    80004154:	ebe080e7          	jalr	-322(ra) # 8000400e <install_trans>
  log.lh.n = 0;
    80004158:	0001e797          	auipc	a5,0x1e
    8000415c:	c007a223          	sw	zero,-1020(a5) # 80021d5c <log+0x2c>
  write_head(); // clear the log
    80004160:	00000097          	auipc	ra,0x0
    80004164:	e34080e7          	jalr	-460(ra) # 80003f94 <write_head>
}
    80004168:	70a2                	ld	ra,40(sp)
    8000416a:	7402                	ld	s0,32(sp)
    8000416c:	64e2                	ld	s1,24(sp)
    8000416e:	6942                	ld	s2,16(sp)
    80004170:	69a2                	ld	s3,8(sp)
    80004172:	6145                	addi	sp,sp,48
    80004174:	8082                	ret

0000000080004176 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80004176:	1101                	addi	sp,sp,-32
    80004178:	ec06                	sd	ra,24(sp)
    8000417a:	e822                	sd	s0,16(sp)
    8000417c:	e426                	sd	s1,8(sp)
    8000417e:	e04a                	sd	s2,0(sp)
    80004180:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    80004182:	0001e517          	auipc	a0,0x1e
    80004186:	bae50513          	addi	a0,a0,-1106 # 80021d30 <log>
    8000418a:	ffffd097          	auipc	ra,0xffffd
    8000418e:	a4c080e7          	jalr	-1460(ra) # 80000bd6 <acquire>
  while(1){
    if(log.committing){
    80004192:	0001e497          	auipc	s1,0x1e
    80004196:	b9e48493          	addi	s1,s1,-1122 # 80021d30 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    8000419a:	4979                	li	s2,30
    8000419c:	a039                	j	800041aa <begin_op+0x34>
      sleep(&log, &log.lock);
    8000419e:	85a6                	mv	a1,s1
    800041a0:	8526                	mv	a0,s1
    800041a2:	ffffe097          	auipc	ra,0xffffe
    800041a6:	f86080e7          	jalr	-122(ra) # 80002128 <sleep>
    if(log.committing){
    800041aa:	50dc                	lw	a5,36(s1)
    800041ac:	fbed                	bnez	a5,8000419e <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    800041ae:	509c                	lw	a5,32(s1)
    800041b0:	0017871b          	addiw	a4,a5,1
    800041b4:	0007069b          	sext.w	a3,a4
    800041b8:	0027179b          	slliw	a5,a4,0x2
    800041bc:	9fb9                	addw	a5,a5,a4
    800041be:	0017979b          	slliw	a5,a5,0x1
    800041c2:	54d8                	lw	a4,44(s1)
    800041c4:	9fb9                	addw	a5,a5,a4
    800041c6:	00f95963          	bge	s2,a5,800041d8 <begin_op+0x62>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    800041ca:	85a6                	mv	a1,s1
    800041cc:	8526                	mv	a0,s1
    800041ce:	ffffe097          	auipc	ra,0xffffe
    800041d2:	f5a080e7          	jalr	-166(ra) # 80002128 <sleep>
    800041d6:	bfd1                	j	800041aa <begin_op+0x34>
    } else {
      log.outstanding += 1;
    800041d8:	0001e517          	auipc	a0,0x1e
    800041dc:	b5850513          	addi	a0,a0,-1192 # 80021d30 <log>
    800041e0:	d114                	sw	a3,32(a0)
      release(&log.lock);
    800041e2:	ffffd097          	auipc	ra,0xffffd
    800041e6:	aa8080e7          	jalr	-1368(ra) # 80000c8a <release>
      break;
    }
  }
}
    800041ea:	60e2                	ld	ra,24(sp)
    800041ec:	6442                	ld	s0,16(sp)
    800041ee:	64a2                	ld	s1,8(sp)
    800041f0:	6902                	ld	s2,0(sp)
    800041f2:	6105                	addi	sp,sp,32
    800041f4:	8082                	ret

00000000800041f6 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    800041f6:	7139                	addi	sp,sp,-64
    800041f8:	fc06                	sd	ra,56(sp)
    800041fa:	f822                	sd	s0,48(sp)
    800041fc:	f426                	sd	s1,40(sp)
    800041fe:	f04a                	sd	s2,32(sp)
    80004200:	ec4e                	sd	s3,24(sp)
    80004202:	e852                	sd	s4,16(sp)
    80004204:	e456                	sd	s5,8(sp)
    80004206:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80004208:	0001e497          	auipc	s1,0x1e
    8000420c:	b2848493          	addi	s1,s1,-1240 # 80021d30 <log>
    80004210:	8526                	mv	a0,s1
    80004212:	ffffd097          	auipc	ra,0xffffd
    80004216:	9c4080e7          	jalr	-1596(ra) # 80000bd6 <acquire>
  log.outstanding -= 1;
    8000421a:	509c                	lw	a5,32(s1)
    8000421c:	37fd                	addiw	a5,a5,-1
    8000421e:	0007891b          	sext.w	s2,a5
    80004222:	d09c                	sw	a5,32(s1)
  if(log.committing)
    80004224:	50dc                	lw	a5,36(s1)
    80004226:	e7b9                	bnez	a5,80004274 <end_op+0x7e>
    panic("log.committing");
  if(log.outstanding == 0){
    80004228:	04091e63          	bnez	s2,80004284 <end_op+0x8e>
    do_commit = 1;
    log.committing = 1;
    8000422c:	0001e497          	auipc	s1,0x1e
    80004230:	b0448493          	addi	s1,s1,-1276 # 80021d30 <log>
    80004234:	4785                	li	a5,1
    80004236:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    80004238:	8526                	mv	a0,s1
    8000423a:	ffffd097          	auipc	ra,0xffffd
    8000423e:	a50080e7          	jalr	-1456(ra) # 80000c8a <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    80004242:	54dc                	lw	a5,44(s1)
    80004244:	06f04763          	bgtz	a5,800042b2 <end_op+0xbc>
    acquire(&log.lock);
    80004248:	0001e497          	auipc	s1,0x1e
    8000424c:	ae848493          	addi	s1,s1,-1304 # 80021d30 <log>
    80004250:	8526                	mv	a0,s1
    80004252:	ffffd097          	auipc	ra,0xffffd
    80004256:	984080e7          	jalr	-1660(ra) # 80000bd6 <acquire>
    log.committing = 0;
    8000425a:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    8000425e:	8526                	mv	a0,s1
    80004260:	ffffe097          	auipc	ra,0xffffe
    80004264:	f2c080e7          	jalr	-212(ra) # 8000218c <wakeup>
    release(&log.lock);
    80004268:	8526                	mv	a0,s1
    8000426a:	ffffd097          	auipc	ra,0xffffd
    8000426e:	a20080e7          	jalr	-1504(ra) # 80000c8a <release>
}
    80004272:	a03d                	j	800042a0 <end_op+0xaa>
    panic("log.committing");
    80004274:	00004517          	auipc	a0,0x4
    80004278:	3cc50513          	addi	a0,a0,972 # 80008640 <syscalls+0x1e8>
    8000427c:	ffffc097          	auipc	ra,0xffffc
    80004280:	2c2080e7          	jalr	706(ra) # 8000053e <panic>
    wakeup(&log);
    80004284:	0001e497          	auipc	s1,0x1e
    80004288:	aac48493          	addi	s1,s1,-1364 # 80021d30 <log>
    8000428c:	8526                	mv	a0,s1
    8000428e:	ffffe097          	auipc	ra,0xffffe
    80004292:	efe080e7          	jalr	-258(ra) # 8000218c <wakeup>
  release(&log.lock);
    80004296:	8526                	mv	a0,s1
    80004298:	ffffd097          	auipc	ra,0xffffd
    8000429c:	9f2080e7          	jalr	-1550(ra) # 80000c8a <release>
}
    800042a0:	70e2                	ld	ra,56(sp)
    800042a2:	7442                	ld	s0,48(sp)
    800042a4:	74a2                	ld	s1,40(sp)
    800042a6:	7902                	ld	s2,32(sp)
    800042a8:	69e2                	ld	s3,24(sp)
    800042aa:	6a42                	ld	s4,16(sp)
    800042ac:	6aa2                	ld	s5,8(sp)
    800042ae:	6121                	addi	sp,sp,64
    800042b0:	8082                	ret
  for (tail = 0; tail < log.lh.n; tail++) {
    800042b2:	0001ea97          	auipc	s5,0x1e
    800042b6:	aaea8a93          	addi	s5,s5,-1362 # 80021d60 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    800042ba:	0001ea17          	auipc	s4,0x1e
    800042be:	a76a0a13          	addi	s4,s4,-1418 # 80021d30 <log>
    800042c2:	018a2583          	lw	a1,24(s4)
    800042c6:	012585bb          	addw	a1,a1,s2
    800042ca:	2585                	addiw	a1,a1,1
    800042cc:	028a2503          	lw	a0,40(s4)
    800042d0:	fffff097          	auipc	ra,0xfffff
    800042d4:	cca080e7          	jalr	-822(ra) # 80002f9a <bread>
    800042d8:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    800042da:	000aa583          	lw	a1,0(s5)
    800042de:	028a2503          	lw	a0,40(s4)
    800042e2:	fffff097          	auipc	ra,0xfffff
    800042e6:	cb8080e7          	jalr	-840(ra) # 80002f9a <bread>
    800042ea:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    800042ec:	40000613          	li	a2,1024
    800042f0:	05850593          	addi	a1,a0,88
    800042f4:	05848513          	addi	a0,s1,88
    800042f8:	ffffd097          	auipc	ra,0xffffd
    800042fc:	a36080e7          	jalr	-1482(ra) # 80000d2e <memmove>
    bwrite(to);  // write the log
    80004300:	8526                	mv	a0,s1
    80004302:	fffff097          	auipc	ra,0xfffff
    80004306:	d8a080e7          	jalr	-630(ra) # 8000308c <bwrite>
    brelse(from);
    8000430a:	854e                	mv	a0,s3
    8000430c:	fffff097          	auipc	ra,0xfffff
    80004310:	dbe080e7          	jalr	-578(ra) # 800030ca <brelse>
    brelse(to);
    80004314:	8526                	mv	a0,s1
    80004316:	fffff097          	auipc	ra,0xfffff
    8000431a:	db4080e7          	jalr	-588(ra) # 800030ca <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000431e:	2905                	addiw	s2,s2,1
    80004320:	0a91                	addi	s5,s5,4
    80004322:	02ca2783          	lw	a5,44(s4)
    80004326:	f8f94ee3          	blt	s2,a5,800042c2 <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    8000432a:	00000097          	auipc	ra,0x0
    8000432e:	c6a080e7          	jalr	-918(ra) # 80003f94 <write_head>
    install_trans(0); // Now install writes to home locations
    80004332:	4501                	li	a0,0
    80004334:	00000097          	auipc	ra,0x0
    80004338:	cda080e7          	jalr	-806(ra) # 8000400e <install_trans>
    log.lh.n = 0;
    8000433c:	0001e797          	auipc	a5,0x1e
    80004340:	a207a023          	sw	zero,-1504(a5) # 80021d5c <log+0x2c>
    write_head();    // Erase the transaction from the log
    80004344:	00000097          	auipc	ra,0x0
    80004348:	c50080e7          	jalr	-944(ra) # 80003f94 <write_head>
    8000434c:	bdf5                	j	80004248 <end_op+0x52>

000000008000434e <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    8000434e:	1101                	addi	sp,sp,-32
    80004350:	ec06                	sd	ra,24(sp)
    80004352:	e822                	sd	s0,16(sp)
    80004354:	e426                	sd	s1,8(sp)
    80004356:	e04a                	sd	s2,0(sp)
    80004358:	1000                	addi	s0,sp,32
    8000435a:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    8000435c:	0001e917          	auipc	s2,0x1e
    80004360:	9d490913          	addi	s2,s2,-1580 # 80021d30 <log>
    80004364:	854a                	mv	a0,s2
    80004366:	ffffd097          	auipc	ra,0xffffd
    8000436a:	870080e7          	jalr	-1936(ra) # 80000bd6 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    8000436e:	02c92603          	lw	a2,44(s2)
    80004372:	47f5                	li	a5,29
    80004374:	06c7c563          	blt	a5,a2,800043de <log_write+0x90>
    80004378:	0001e797          	auipc	a5,0x1e
    8000437c:	9d47a783          	lw	a5,-1580(a5) # 80021d4c <log+0x1c>
    80004380:	37fd                	addiw	a5,a5,-1
    80004382:	04f65e63          	bge	a2,a5,800043de <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    80004386:	0001e797          	auipc	a5,0x1e
    8000438a:	9ca7a783          	lw	a5,-1590(a5) # 80021d50 <log+0x20>
    8000438e:	06f05063          	blez	a5,800043ee <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    80004392:	4781                	li	a5,0
    80004394:	06c05563          	blez	a2,800043fe <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80004398:	44cc                	lw	a1,12(s1)
    8000439a:	0001e717          	auipc	a4,0x1e
    8000439e:	9c670713          	addi	a4,a4,-1594 # 80021d60 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    800043a2:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    800043a4:	4314                	lw	a3,0(a4)
    800043a6:	04b68c63          	beq	a3,a1,800043fe <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    800043aa:	2785                	addiw	a5,a5,1
    800043ac:	0711                	addi	a4,a4,4
    800043ae:	fef61be3          	bne	a2,a5,800043a4 <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    800043b2:	0621                	addi	a2,a2,8
    800043b4:	060a                	slli	a2,a2,0x2
    800043b6:	0001e797          	auipc	a5,0x1e
    800043ba:	97a78793          	addi	a5,a5,-1670 # 80021d30 <log>
    800043be:	963e                	add	a2,a2,a5
    800043c0:	44dc                	lw	a5,12(s1)
    800043c2:	ca1c                	sw	a5,16(a2)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    800043c4:	8526                	mv	a0,s1
    800043c6:	fffff097          	auipc	ra,0xfffff
    800043ca:	da2080e7          	jalr	-606(ra) # 80003168 <bpin>
    log.lh.n++;
    800043ce:	0001e717          	auipc	a4,0x1e
    800043d2:	96270713          	addi	a4,a4,-1694 # 80021d30 <log>
    800043d6:	575c                	lw	a5,44(a4)
    800043d8:	2785                	addiw	a5,a5,1
    800043da:	d75c                	sw	a5,44(a4)
    800043dc:	a835                	j	80004418 <log_write+0xca>
    panic("too big a transaction");
    800043de:	00004517          	auipc	a0,0x4
    800043e2:	27250513          	addi	a0,a0,626 # 80008650 <syscalls+0x1f8>
    800043e6:	ffffc097          	auipc	ra,0xffffc
    800043ea:	158080e7          	jalr	344(ra) # 8000053e <panic>
    panic("log_write outside of trans");
    800043ee:	00004517          	auipc	a0,0x4
    800043f2:	27a50513          	addi	a0,a0,634 # 80008668 <syscalls+0x210>
    800043f6:	ffffc097          	auipc	ra,0xffffc
    800043fa:	148080e7          	jalr	328(ra) # 8000053e <panic>
  log.lh.block[i] = b->blockno;
    800043fe:	00878713          	addi	a4,a5,8
    80004402:	00271693          	slli	a3,a4,0x2
    80004406:	0001e717          	auipc	a4,0x1e
    8000440a:	92a70713          	addi	a4,a4,-1750 # 80021d30 <log>
    8000440e:	9736                	add	a4,a4,a3
    80004410:	44d4                	lw	a3,12(s1)
    80004412:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    80004414:	faf608e3          	beq	a2,a5,800043c4 <log_write+0x76>
  }
  release(&log.lock);
    80004418:	0001e517          	auipc	a0,0x1e
    8000441c:	91850513          	addi	a0,a0,-1768 # 80021d30 <log>
    80004420:	ffffd097          	auipc	ra,0xffffd
    80004424:	86a080e7          	jalr	-1942(ra) # 80000c8a <release>
}
    80004428:	60e2                	ld	ra,24(sp)
    8000442a:	6442                	ld	s0,16(sp)
    8000442c:	64a2                	ld	s1,8(sp)
    8000442e:	6902                	ld	s2,0(sp)
    80004430:	6105                	addi	sp,sp,32
    80004432:	8082                	ret

0000000080004434 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80004434:	1101                	addi	sp,sp,-32
    80004436:	ec06                	sd	ra,24(sp)
    80004438:	e822                	sd	s0,16(sp)
    8000443a:	e426                	sd	s1,8(sp)
    8000443c:	e04a                	sd	s2,0(sp)
    8000443e:	1000                	addi	s0,sp,32
    80004440:	84aa                	mv	s1,a0
    80004442:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80004444:	00004597          	auipc	a1,0x4
    80004448:	24458593          	addi	a1,a1,580 # 80008688 <syscalls+0x230>
    8000444c:	0521                	addi	a0,a0,8
    8000444e:	ffffc097          	auipc	ra,0xffffc
    80004452:	6f8080e7          	jalr	1784(ra) # 80000b46 <initlock>
  lk->name = name;
    80004456:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    8000445a:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    8000445e:	0204a423          	sw	zero,40(s1)
}
    80004462:	60e2                	ld	ra,24(sp)
    80004464:	6442                	ld	s0,16(sp)
    80004466:	64a2                	ld	s1,8(sp)
    80004468:	6902                	ld	s2,0(sp)
    8000446a:	6105                	addi	sp,sp,32
    8000446c:	8082                	ret

000000008000446e <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    8000446e:	1101                	addi	sp,sp,-32
    80004470:	ec06                	sd	ra,24(sp)
    80004472:	e822                	sd	s0,16(sp)
    80004474:	e426                	sd	s1,8(sp)
    80004476:	e04a                	sd	s2,0(sp)
    80004478:	1000                	addi	s0,sp,32
    8000447a:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    8000447c:	00850913          	addi	s2,a0,8
    80004480:	854a                	mv	a0,s2
    80004482:	ffffc097          	auipc	ra,0xffffc
    80004486:	754080e7          	jalr	1876(ra) # 80000bd6 <acquire>
  while (lk->locked) {
    8000448a:	409c                	lw	a5,0(s1)
    8000448c:	cb89                	beqz	a5,8000449e <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    8000448e:	85ca                	mv	a1,s2
    80004490:	8526                	mv	a0,s1
    80004492:	ffffe097          	auipc	ra,0xffffe
    80004496:	c96080e7          	jalr	-874(ra) # 80002128 <sleep>
  while (lk->locked) {
    8000449a:	409c                	lw	a5,0(s1)
    8000449c:	fbed                	bnez	a5,8000448e <acquiresleep+0x20>
  }
  lk->locked = 1;
    8000449e:	4785                	li	a5,1
    800044a0:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    800044a2:	ffffd097          	auipc	ra,0xffffd
    800044a6:	51a080e7          	jalr	1306(ra) # 800019bc <myproc>
    800044aa:	591c                	lw	a5,48(a0)
    800044ac:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    800044ae:	854a                	mv	a0,s2
    800044b0:	ffffc097          	auipc	ra,0xffffc
    800044b4:	7da080e7          	jalr	2010(ra) # 80000c8a <release>
}
    800044b8:	60e2                	ld	ra,24(sp)
    800044ba:	6442                	ld	s0,16(sp)
    800044bc:	64a2                	ld	s1,8(sp)
    800044be:	6902                	ld	s2,0(sp)
    800044c0:	6105                	addi	sp,sp,32
    800044c2:	8082                	ret

00000000800044c4 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    800044c4:	1101                	addi	sp,sp,-32
    800044c6:	ec06                	sd	ra,24(sp)
    800044c8:	e822                	sd	s0,16(sp)
    800044ca:	e426                	sd	s1,8(sp)
    800044cc:	e04a                	sd	s2,0(sp)
    800044ce:	1000                	addi	s0,sp,32
    800044d0:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800044d2:	00850913          	addi	s2,a0,8
    800044d6:	854a                	mv	a0,s2
    800044d8:	ffffc097          	auipc	ra,0xffffc
    800044dc:	6fe080e7          	jalr	1790(ra) # 80000bd6 <acquire>
  lk->locked = 0;
    800044e0:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800044e4:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    800044e8:	8526                	mv	a0,s1
    800044ea:	ffffe097          	auipc	ra,0xffffe
    800044ee:	ca2080e7          	jalr	-862(ra) # 8000218c <wakeup>
  release(&lk->lk);
    800044f2:	854a                	mv	a0,s2
    800044f4:	ffffc097          	auipc	ra,0xffffc
    800044f8:	796080e7          	jalr	1942(ra) # 80000c8a <release>
}
    800044fc:	60e2                	ld	ra,24(sp)
    800044fe:	6442                	ld	s0,16(sp)
    80004500:	64a2                	ld	s1,8(sp)
    80004502:	6902                	ld	s2,0(sp)
    80004504:	6105                	addi	sp,sp,32
    80004506:	8082                	ret

0000000080004508 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80004508:	7179                	addi	sp,sp,-48
    8000450a:	f406                	sd	ra,40(sp)
    8000450c:	f022                	sd	s0,32(sp)
    8000450e:	ec26                	sd	s1,24(sp)
    80004510:	e84a                	sd	s2,16(sp)
    80004512:	e44e                	sd	s3,8(sp)
    80004514:	1800                	addi	s0,sp,48
    80004516:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80004518:	00850913          	addi	s2,a0,8
    8000451c:	854a                	mv	a0,s2
    8000451e:	ffffc097          	auipc	ra,0xffffc
    80004522:	6b8080e7          	jalr	1720(ra) # 80000bd6 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80004526:	409c                	lw	a5,0(s1)
    80004528:	ef99                	bnez	a5,80004546 <holdingsleep+0x3e>
    8000452a:	4481                	li	s1,0
  release(&lk->lk);
    8000452c:	854a                	mv	a0,s2
    8000452e:	ffffc097          	auipc	ra,0xffffc
    80004532:	75c080e7          	jalr	1884(ra) # 80000c8a <release>
  return r;
}
    80004536:	8526                	mv	a0,s1
    80004538:	70a2                	ld	ra,40(sp)
    8000453a:	7402                	ld	s0,32(sp)
    8000453c:	64e2                	ld	s1,24(sp)
    8000453e:	6942                	ld	s2,16(sp)
    80004540:	69a2                	ld	s3,8(sp)
    80004542:	6145                	addi	sp,sp,48
    80004544:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    80004546:	0284a983          	lw	s3,40(s1)
    8000454a:	ffffd097          	auipc	ra,0xffffd
    8000454e:	472080e7          	jalr	1138(ra) # 800019bc <myproc>
    80004552:	5904                	lw	s1,48(a0)
    80004554:	413484b3          	sub	s1,s1,s3
    80004558:	0014b493          	seqz	s1,s1
    8000455c:	bfc1                	j	8000452c <holdingsleep+0x24>

000000008000455e <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    8000455e:	1141                	addi	sp,sp,-16
    80004560:	e406                	sd	ra,8(sp)
    80004562:	e022                	sd	s0,0(sp)
    80004564:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80004566:	00004597          	auipc	a1,0x4
    8000456a:	13258593          	addi	a1,a1,306 # 80008698 <syscalls+0x240>
    8000456e:	0001e517          	auipc	a0,0x1e
    80004572:	90a50513          	addi	a0,a0,-1782 # 80021e78 <ftable>
    80004576:	ffffc097          	auipc	ra,0xffffc
    8000457a:	5d0080e7          	jalr	1488(ra) # 80000b46 <initlock>
}
    8000457e:	60a2                	ld	ra,8(sp)
    80004580:	6402                	ld	s0,0(sp)
    80004582:	0141                	addi	sp,sp,16
    80004584:	8082                	ret

0000000080004586 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80004586:	1101                	addi	sp,sp,-32
    80004588:	ec06                	sd	ra,24(sp)
    8000458a:	e822                	sd	s0,16(sp)
    8000458c:	e426                	sd	s1,8(sp)
    8000458e:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80004590:	0001e517          	auipc	a0,0x1e
    80004594:	8e850513          	addi	a0,a0,-1816 # 80021e78 <ftable>
    80004598:	ffffc097          	auipc	ra,0xffffc
    8000459c:	63e080e7          	jalr	1598(ra) # 80000bd6 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800045a0:	0001e497          	auipc	s1,0x1e
    800045a4:	8f048493          	addi	s1,s1,-1808 # 80021e90 <ftable+0x18>
    800045a8:	0001f717          	auipc	a4,0x1f
    800045ac:	88870713          	addi	a4,a4,-1912 # 80022e30 <disk>
    if(f->ref == 0){
    800045b0:	40dc                	lw	a5,4(s1)
    800045b2:	cf99                	beqz	a5,800045d0 <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800045b4:	02848493          	addi	s1,s1,40
    800045b8:	fee49ce3          	bne	s1,a4,800045b0 <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    800045bc:	0001e517          	auipc	a0,0x1e
    800045c0:	8bc50513          	addi	a0,a0,-1860 # 80021e78 <ftable>
    800045c4:	ffffc097          	auipc	ra,0xffffc
    800045c8:	6c6080e7          	jalr	1734(ra) # 80000c8a <release>
  return 0;
    800045cc:	4481                	li	s1,0
    800045ce:	a819                	j	800045e4 <filealloc+0x5e>
      f->ref = 1;
    800045d0:	4785                	li	a5,1
    800045d2:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    800045d4:	0001e517          	auipc	a0,0x1e
    800045d8:	8a450513          	addi	a0,a0,-1884 # 80021e78 <ftable>
    800045dc:	ffffc097          	auipc	ra,0xffffc
    800045e0:	6ae080e7          	jalr	1710(ra) # 80000c8a <release>
}
    800045e4:	8526                	mv	a0,s1
    800045e6:	60e2                	ld	ra,24(sp)
    800045e8:	6442                	ld	s0,16(sp)
    800045ea:	64a2                	ld	s1,8(sp)
    800045ec:	6105                	addi	sp,sp,32
    800045ee:	8082                	ret

00000000800045f0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    800045f0:	1101                	addi	sp,sp,-32
    800045f2:	ec06                	sd	ra,24(sp)
    800045f4:	e822                	sd	s0,16(sp)
    800045f6:	e426                	sd	s1,8(sp)
    800045f8:	1000                	addi	s0,sp,32
    800045fa:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    800045fc:	0001e517          	auipc	a0,0x1e
    80004600:	87c50513          	addi	a0,a0,-1924 # 80021e78 <ftable>
    80004604:	ffffc097          	auipc	ra,0xffffc
    80004608:	5d2080e7          	jalr	1490(ra) # 80000bd6 <acquire>
  if(f->ref < 1)
    8000460c:	40dc                	lw	a5,4(s1)
    8000460e:	02f05263          	blez	a5,80004632 <filedup+0x42>
    panic("filedup");
  f->ref++;
    80004612:	2785                	addiw	a5,a5,1
    80004614:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80004616:	0001e517          	auipc	a0,0x1e
    8000461a:	86250513          	addi	a0,a0,-1950 # 80021e78 <ftable>
    8000461e:	ffffc097          	auipc	ra,0xffffc
    80004622:	66c080e7          	jalr	1644(ra) # 80000c8a <release>
  return f;
}
    80004626:	8526                	mv	a0,s1
    80004628:	60e2                	ld	ra,24(sp)
    8000462a:	6442                	ld	s0,16(sp)
    8000462c:	64a2                	ld	s1,8(sp)
    8000462e:	6105                	addi	sp,sp,32
    80004630:	8082                	ret
    panic("filedup");
    80004632:	00004517          	auipc	a0,0x4
    80004636:	06e50513          	addi	a0,a0,110 # 800086a0 <syscalls+0x248>
    8000463a:	ffffc097          	auipc	ra,0xffffc
    8000463e:	f04080e7          	jalr	-252(ra) # 8000053e <panic>

0000000080004642 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80004642:	7139                	addi	sp,sp,-64
    80004644:	fc06                	sd	ra,56(sp)
    80004646:	f822                	sd	s0,48(sp)
    80004648:	f426                	sd	s1,40(sp)
    8000464a:	f04a                	sd	s2,32(sp)
    8000464c:	ec4e                	sd	s3,24(sp)
    8000464e:	e852                	sd	s4,16(sp)
    80004650:	e456                	sd	s5,8(sp)
    80004652:	0080                	addi	s0,sp,64
    80004654:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80004656:	0001e517          	auipc	a0,0x1e
    8000465a:	82250513          	addi	a0,a0,-2014 # 80021e78 <ftable>
    8000465e:	ffffc097          	auipc	ra,0xffffc
    80004662:	578080e7          	jalr	1400(ra) # 80000bd6 <acquire>
  if(f->ref < 1)
    80004666:	40dc                	lw	a5,4(s1)
    80004668:	06f05163          	blez	a5,800046ca <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    8000466c:	37fd                	addiw	a5,a5,-1
    8000466e:	0007871b          	sext.w	a4,a5
    80004672:	c0dc                	sw	a5,4(s1)
    80004674:	06e04363          	bgtz	a4,800046da <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80004678:	0004a903          	lw	s2,0(s1)
    8000467c:	0094ca83          	lbu	s5,9(s1)
    80004680:	0104ba03          	ld	s4,16(s1)
    80004684:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80004688:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    8000468c:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80004690:	0001d517          	auipc	a0,0x1d
    80004694:	7e850513          	addi	a0,a0,2024 # 80021e78 <ftable>
    80004698:	ffffc097          	auipc	ra,0xffffc
    8000469c:	5f2080e7          	jalr	1522(ra) # 80000c8a <release>

  if(ff.type == FD_PIPE){
    800046a0:	4785                	li	a5,1
    800046a2:	04f90d63          	beq	s2,a5,800046fc <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    800046a6:	3979                	addiw	s2,s2,-2
    800046a8:	4785                	li	a5,1
    800046aa:	0527e063          	bltu	a5,s2,800046ea <fileclose+0xa8>
    begin_op();
    800046ae:	00000097          	auipc	ra,0x0
    800046b2:	ac8080e7          	jalr	-1336(ra) # 80004176 <begin_op>
    iput(ff.ip);
    800046b6:	854e                	mv	a0,s3
    800046b8:	fffff097          	auipc	ra,0xfffff
    800046bc:	2b6080e7          	jalr	694(ra) # 8000396e <iput>
    end_op();
    800046c0:	00000097          	auipc	ra,0x0
    800046c4:	b36080e7          	jalr	-1226(ra) # 800041f6 <end_op>
    800046c8:	a00d                	j	800046ea <fileclose+0xa8>
    panic("fileclose");
    800046ca:	00004517          	auipc	a0,0x4
    800046ce:	fde50513          	addi	a0,a0,-34 # 800086a8 <syscalls+0x250>
    800046d2:	ffffc097          	auipc	ra,0xffffc
    800046d6:	e6c080e7          	jalr	-404(ra) # 8000053e <panic>
    release(&ftable.lock);
    800046da:	0001d517          	auipc	a0,0x1d
    800046de:	79e50513          	addi	a0,a0,1950 # 80021e78 <ftable>
    800046e2:	ffffc097          	auipc	ra,0xffffc
    800046e6:	5a8080e7          	jalr	1448(ra) # 80000c8a <release>
  }
}
    800046ea:	70e2                	ld	ra,56(sp)
    800046ec:	7442                	ld	s0,48(sp)
    800046ee:	74a2                	ld	s1,40(sp)
    800046f0:	7902                	ld	s2,32(sp)
    800046f2:	69e2                	ld	s3,24(sp)
    800046f4:	6a42                	ld	s4,16(sp)
    800046f6:	6aa2                	ld	s5,8(sp)
    800046f8:	6121                	addi	sp,sp,64
    800046fa:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    800046fc:	85d6                	mv	a1,s5
    800046fe:	8552                	mv	a0,s4
    80004700:	00000097          	auipc	ra,0x0
    80004704:	34c080e7          	jalr	844(ra) # 80004a4c <pipeclose>
    80004708:	b7cd                	j	800046ea <fileclose+0xa8>

000000008000470a <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    8000470a:	715d                	addi	sp,sp,-80
    8000470c:	e486                	sd	ra,72(sp)
    8000470e:	e0a2                	sd	s0,64(sp)
    80004710:	fc26                	sd	s1,56(sp)
    80004712:	f84a                	sd	s2,48(sp)
    80004714:	f44e                	sd	s3,40(sp)
    80004716:	0880                	addi	s0,sp,80
    80004718:	84aa                	mv	s1,a0
    8000471a:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    8000471c:	ffffd097          	auipc	ra,0xffffd
    80004720:	2a0080e7          	jalr	672(ra) # 800019bc <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80004724:	409c                	lw	a5,0(s1)
    80004726:	37f9                	addiw	a5,a5,-2
    80004728:	4705                	li	a4,1
    8000472a:	04f76763          	bltu	a4,a5,80004778 <filestat+0x6e>
    8000472e:	892a                	mv	s2,a0
    ilock(f->ip);
    80004730:	6c88                	ld	a0,24(s1)
    80004732:	fffff097          	auipc	ra,0xfffff
    80004736:	082080e7          	jalr	130(ra) # 800037b4 <ilock>
    stati(f->ip, &st);
    8000473a:	fb840593          	addi	a1,s0,-72
    8000473e:	6c88                	ld	a0,24(s1)
    80004740:	fffff097          	auipc	ra,0xfffff
    80004744:	2fe080e7          	jalr	766(ra) # 80003a3e <stati>
    iunlock(f->ip);
    80004748:	6c88                	ld	a0,24(s1)
    8000474a:	fffff097          	auipc	ra,0xfffff
    8000474e:	12c080e7          	jalr	300(ra) # 80003876 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80004752:	46e1                	li	a3,24
    80004754:	fb840613          	addi	a2,s0,-72
    80004758:	85ce                	mv	a1,s3
    8000475a:	09893503          	ld	a0,152(s2)
    8000475e:	ffffd097          	auipc	ra,0xffffd
    80004762:	f0c080e7          	jalr	-244(ra) # 8000166a <copyout>
    80004766:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    8000476a:	60a6                	ld	ra,72(sp)
    8000476c:	6406                	ld	s0,64(sp)
    8000476e:	74e2                	ld	s1,56(sp)
    80004770:	7942                	ld	s2,48(sp)
    80004772:	79a2                	ld	s3,40(sp)
    80004774:	6161                	addi	sp,sp,80
    80004776:	8082                	ret
  return -1;
    80004778:	557d                	li	a0,-1
    8000477a:	bfc5                	j	8000476a <filestat+0x60>

000000008000477c <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    8000477c:	7179                	addi	sp,sp,-48
    8000477e:	f406                	sd	ra,40(sp)
    80004780:	f022                	sd	s0,32(sp)
    80004782:	ec26                	sd	s1,24(sp)
    80004784:	e84a                	sd	s2,16(sp)
    80004786:	e44e                	sd	s3,8(sp)
    80004788:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    8000478a:	00854783          	lbu	a5,8(a0)
    8000478e:	c3d5                	beqz	a5,80004832 <fileread+0xb6>
    80004790:	84aa                	mv	s1,a0
    80004792:	89ae                	mv	s3,a1
    80004794:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80004796:	411c                	lw	a5,0(a0)
    80004798:	4705                	li	a4,1
    8000479a:	04e78963          	beq	a5,a4,800047ec <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    8000479e:	470d                	li	a4,3
    800047a0:	04e78d63          	beq	a5,a4,800047fa <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    800047a4:	4709                	li	a4,2
    800047a6:	06e79e63          	bne	a5,a4,80004822 <fileread+0xa6>
    ilock(f->ip);
    800047aa:	6d08                	ld	a0,24(a0)
    800047ac:	fffff097          	auipc	ra,0xfffff
    800047b0:	008080e7          	jalr	8(ra) # 800037b4 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    800047b4:	874a                	mv	a4,s2
    800047b6:	5094                	lw	a3,32(s1)
    800047b8:	864e                	mv	a2,s3
    800047ba:	4585                	li	a1,1
    800047bc:	6c88                	ld	a0,24(s1)
    800047be:	fffff097          	auipc	ra,0xfffff
    800047c2:	2aa080e7          	jalr	682(ra) # 80003a68 <readi>
    800047c6:	892a                	mv	s2,a0
    800047c8:	00a05563          	blez	a0,800047d2 <fileread+0x56>
      f->off += r;
    800047cc:	509c                	lw	a5,32(s1)
    800047ce:	9fa9                	addw	a5,a5,a0
    800047d0:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    800047d2:	6c88                	ld	a0,24(s1)
    800047d4:	fffff097          	auipc	ra,0xfffff
    800047d8:	0a2080e7          	jalr	162(ra) # 80003876 <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    800047dc:	854a                	mv	a0,s2
    800047de:	70a2                	ld	ra,40(sp)
    800047e0:	7402                	ld	s0,32(sp)
    800047e2:	64e2                	ld	s1,24(sp)
    800047e4:	6942                	ld	s2,16(sp)
    800047e6:	69a2                	ld	s3,8(sp)
    800047e8:	6145                	addi	sp,sp,48
    800047ea:	8082                	ret
    r = piperead(f->pipe, addr, n);
    800047ec:	6908                	ld	a0,16(a0)
    800047ee:	00000097          	auipc	ra,0x0
    800047f2:	3c6080e7          	jalr	966(ra) # 80004bb4 <piperead>
    800047f6:	892a                	mv	s2,a0
    800047f8:	b7d5                	j	800047dc <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    800047fa:	02451783          	lh	a5,36(a0)
    800047fe:	03079693          	slli	a3,a5,0x30
    80004802:	92c1                	srli	a3,a3,0x30
    80004804:	4725                	li	a4,9
    80004806:	02d76863          	bltu	a4,a3,80004836 <fileread+0xba>
    8000480a:	0792                	slli	a5,a5,0x4
    8000480c:	0001d717          	auipc	a4,0x1d
    80004810:	5cc70713          	addi	a4,a4,1484 # 80021dd8 <devsw>
    80004814:	97ba                	add	a5,a5,a4
    80004816:	639c                	ld	a5,0(a5)
    80004818:	c38d                	beqz	a5,8000483a <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    8000481a:	4505                	li	a0,1
    8000481c:	9782                	jalr	a5
    8000481e:	892a                	mv	s2,a0
    80004820:	bf75                	j	800047dc <fileread+0x60>
    panic("fileread");
    80004822:	00004517          	auipc	a0,0x4
    80004826:	e9650513          	addi	a0,a0,-362 # 800086b8 <syscalls+0x260>
    8000482a:	ffffc097          	auipc	ra,0xffffc
    8000482e:	d14080e7          	jalr	-748(ra) # 8000053e <panic>
    return -1;
    80004832:	597d                	li	s2,-1
    80004834:	b765                	j	800047dc <fileread+0x60>
      return -1;
    80004836:	597d                	li	s2,-1
    80004838:	b755                	j	800047dc <fileread+0x60>
    8000483a:	597d                	li	s2,-1
    8000483c:	b745                	j	800047dc <fileread+0x60>

000000008000483e <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    8000483e:	715d                	addi	sp,sp,-80
    80004840:	e486                	sd	ra,72(sp)
    80004842:	e0a2                	sd	s0,64(sp)
    80004844:	fc26                	sd	s1,56(sp)
    80004846:	f84a                	sd	s2,48(sp)
    80004848:	f44e                	sd	s3,40(sp)
    8000484a:	f052                	sd	s4,32(sp)
    8000484c:	ec56                	sd	s5,24(sp)
    8000484e:	e85a                	sd	s6,16(sp)
    80004850:	e45e                	sd	s7,8(sp)
    80004852:	e062                	sd	s8,0(sp)
    80004854:	0880                	addi	s0,sp,80
  int r, ret = 0;

  if(f->writable == 0)
    80004856:	00954783          	lbu	a5,9(a0)
    8000485a:	10078663          	beqz	a5,80004966 <filewrite+0x128>
    8000485e:	892a                	mv	s2,a0
    80004860:	8aae                	mv	s5,a1
    80004862:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    80004864:	411c                	lw	a5,0(a0)
    80004866:	4705                	li	a4,1
    80004868:	02e78263          	beq	a5,a4,8000488c <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    8000486c:	470d                	li	a4,3
    8000486e:	02e78663          	beq	a5,a4,8000489a <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80004872:	4709                	li	a4,2
    80004874:	0ee79163          	bne	a5,a4,80004956 <filewrite+0x118>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80004878:	0ac05d63          	blez	a2,80004932 <filewrite+0xf4>
    int i = 0;
    8000487c:	4981                	li	s3,0
    8000487e:	6b05                	lui	s6,0x1
    80004880:	c00b0b13          	addi	s6,s6,-1024 # c00 <_entry-0x7ffff400>
    80004884:	6b85                	lui	s7,0x1
    80004886:	c00b8b9b          	addiw	s7,s7,-1024
    8000488a:	a861                	j	80004922 <filewrite+0xe4>
    ret = pipewrite(f->pipe, addr, n);
    8000488c:	6908                	ld	a0,16(a0)
    8000488e:	00000097          	auipc	ra,0x0
    80004892:	22e080e7          	jalr	558(ra) # 80004abc <pipewrite>
    80004896:	8a2a                	mv	s4,a0
    80004898:	a045                	j	80004938 <filewrite+0xfa>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    8000489a:	02451783          	lh	a5,36(a0)
    8000489e:	03079693          	slli	a3,a5,0x30
    800048a2:	92c1                	srli	a3,a3,0x30
    800048a4:	4725                	li	a4,9
    800048a6:	0cd76263          	bltu	a4,a3,8000496a <filewrite+0x12c>
    800048aa:	0792                	slli	a5,a5,0x4
    800048ac:	0001d717          	auipc	a4,0x1d
    800048b0:	52c70713          	addi	a4,a4,1324 # 80021dd8 <devsw>
    800048b4:	97ba                	add	a5,a5,a4
    800048b6:	679c                	ld	a5,8(a5)
    800048b8:	cbdd                	beqz	a5,8000496e <filewrite+0x130>
    ret = devsw[f->major].write(1, addr, n);
    800048ba:	4505                	li	a0,1
    800048bc:	9782                	jalr	a5
    800048be:	8a2a                	mv	s4,a0
    800048c0:	a8a5                	j	80004938 <filewrite+0xfa>
    800048c2:	00048c1b          	sext.w	s8,s1
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
    800048c6:	00000097          	auipc	ra,0x0
    800048ca:	8b0080e7          	jalr	-1872(ra) # 80004176 <begin_op>
      ilock(f->ip);
    800048ce:	01893503          	ld	a0,24(s2)
    800048d2:	fffff097          	auipc	ra,0xfffff
    800048d6:	ee2080e7          	jalr	-286(ra) # 800037b4 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    800048da:	8762                	mv	a4,s8
    800048dc:	02092683          	lw	a3,32(s2)
    800048e0:	01598633          	add	a2,s3,s5
    800048e4:	4585                	li	a1,1
    800048e6:	01893503          	ld	a0,24(s2)
    800048ea:	fffff097          	auipc	ra,0xfffff
    800048ee:	276080e7          	jalr	630(ra) # 80003b60 <writei>
    800048f2:	84aa                	mv	s1,a0
    800048f4:	00a05763          	blez	a0,80004902 <filewrite+0xc4>
        f->off += r;
    800048f8:	02092783          	lw	a5,32(s2)
    800048fc:	9fa9                	addw	a5,a5,a0
    800048fe:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80004902:	01893503          	ld	a0,24(s2)
    80004906:	fffff097          	auipc	ra,0xfffff
    8000490a:	f70080e7          	jalr	-144(ra) # 80003876 <iunlock>
      end_op();
    8000490e:	00000097          	auipc	ra,0x0
    80004912:	8e8080e7          	jalr	-1816(ra) # 800041f6 <end_op>

      if(r != n1){
    80004916:	009c1f63          	bne	s8,s1,80004934 <filewrite+0xf6>
        // error from writei
        break;
      }
      i += r;
    8000491a:	013489bb          	addw	s3,s1,s3
    while(i < n){
    8000491e:	0149db63          	bge	s3,s4,80004934 <filewrite+0xf6>
      int n1 = n - i;
    80004922:	413a07bb          	subw	a5,s4,s3
      if(n1 > max)
    80004926:	84be                	mv	s1,a5
    80004928:	2781                	sext.w	a5,a5
    8000492a:	f8fb5ce3          	bge	s6,a5,800048c2 <filewrite+0x84>
    8000492e:	84de                	mv	s1,s7
    80004930:	bf49                	j	800048c2 <filewrite+0x84>
    int i = 0;
    80004932:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    80004934:	013a1f63          	bne	s4,s3,80004952 <filewrite+0x114>
  } else {
    panic("filewrite");
  }

  return ret;
}
    80004938:	8552                	mv	a0,s4
    8000493a:	60a6                	ld	ra,72(sp)
    8000493c:	6406                	ld	s0,64(sp)
    8000493e:	74e2                	ld	s1,56(sp)
    80004940:	7942                	ld	s2,48(sp)
    80004942:	79a2                	ld	s3,40(sp)
    80004944:	7a02                	ld	s4,32(sp)
    80004946:	6ae2                	ld	s5,24(sp)
    80004948:	6b42                	ld	s6,16(sp)
    8000494a:	6ba2                	ld	s7,8(sp)
    8000494c:	6c02                	ld	s8,0(sp)
    8000494e:	6161                	addi	sp,sp,80
    80004950:	8082                	ret
    ret = (i == n ? n : -1);
    80004952:	5a7d                	li	s4,-1
    80004954:	b7d5                	j	80004938 <filewrite+0xfa>
    panic("filewrite");
    80004956:	00004517          	auipc	a0,0x4
    8000495a:	d7250513          	addi	a0,a0,-654 # 800086c8 <syscalls+0x270>
    8000495e:	ffffc097          	auipc	ra,0xffffc
    80004962:	be0080e7          	jalr	-1056(ra) # 8000053e <panic>
    return -1;
    80004966:	5a7d                	li	s4,-1
    80004968:	bfc1                	j	80004938 <filewrite+0xfa>
      return -1;
    8000496a:	5a7d                	li	s4,-1
    8000496c:	b7f1                	j	80004938 <filewrite+0xfa>
    8000496e:	5a7d                	li	s4,-1
    80004970:	b7e1                	j	80004938 <filewrite+0xfa>

0000000080004972 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80004972:	7179                	addi	sp,sp,-48
    80004974:	f406                	sd	ra,40(sp)
    80004976:	f022                	sd	s0,32(sp)
    80004978:	ec26                	sd	s1,24(sp)
    8000497a:	e84a                	sd	s2,16(sp)
    8000497c:	e44e                	sd	s3,8(sp)
    8000497e:	e052                	sd	s4,0(sp)
    80004980:	1800                	addi	s0,sp,48
    80004982:	84aa                	mv	s1,a0
    80004984:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80004986:	0005b023          	sd	zero,0(a1)
    8000498a:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    8000498e:	00000097          	auipc	ra,0x0
    80004992:	bf8080e7          	jalr	-1032(ra) # 80004586 <filealloc>
    80004996:	e088                	sd	a0,0(s1)
    80004998:	c551                	beqz	a0,80004a24 <pipealloc+0xb2>
    8000499a:	00000097          	auipc	ra,0x0
    8000499e:	bec080e7          	jalr	-1044(ra) # 80004586 <filealloc>
    800049a2:	00aa3023          	sd	a0,0(s4)
    800049a6:	c92d                	beqz	a0,80004a18 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    800049a8:	ffffc097          	auipc	ra,0xffffc
    800049ac:	13e080e7          	jalr	318(ra) # 80000ae6 <kalloc>
    800049b0:	892a                	mv	s2,a0
    800049b2:	c125                	beqz	a0,80004a12 <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    800049b4:	4985                	li	s3,1
    800049b6:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    800049ba:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    800049be:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    800049c2:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    800049c6:	00004597          	auipc	a1,0x4
    800049ca:	d1258593          	addi	a1,a1,-750 # 800086d8 <syscalls+0x280>
    800049ce:	ffffc097          	auipc	ra,0xffffc
    800049d2:	178080e7          	jalr	376(ra) # 80000b46 <initlock>
  (*f0)->type = FD_PIPE;
    800049d6:	609c                	ld	a5,0(s1)
    800049d8:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    800049dc:	609c                	ld	a5,0(s1)
    800049de:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    800049e2:	609c                	ld	a5,0(s1)
    800049e4:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    800049e8:	609c                	ld	a5,0(s1)
    800049ea:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    800049ee:	000a3783          	ld	a5,0(s4)
    800049f2:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    800049f6:	000a3783          	ld	a5,0(s4)
    800049fa:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    800049fe:	000a3783          	ld	a5,0(s4)
    80004a02:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80004a06:	000a3783          	ld	a5,0(s4)
    80004a0a:	0127b823          	sd	s2,16(a5)
  return 0;
    80004a0e:	4501                	li	a0,0
    80004a10:	a025                	j	80004a38 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80004a12:	6088                	ld	a0,0(s1)
    80004a14:	e501                	bnez	a0,80004a1c <pipealloc+0xaa>
    80004a16:	a039                	j	80004a24 <pipealloc+0xb2>
    80004a18:	6088                	ld	a0,0(s1)
    80004a1a:	c51d                	beqz	a0,80004a48 <pipealloc+0xd6>
    fileclose(*f0);
    80004a1c:	00000097          	auipc	ra,0x0
    80004a20:	c26080e7          	jalr	-986(ra) # 80004642 <fileclose>
  if(*f1)
    80004a24:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80004a28:	557d                	li	a0,-1
  if(*f1)
    80004a2a:	c799                	beqz	a5,80004a38 <pipealloc+0xc6>
    fileclose(*f1);
    80004a2c:	853e                	mv	a0,a5
    80004a2e:	00000097          	auipc	ra,0x0
    80004a32:	c14080e7          	jalr	-1004(ra) # 80004642 <fileclose>
  return -1;
    80004a36:	557d                	li	a0,-1
}
    80004a38:	70a2                	ld	ra,40(sp)
    80004a3a:	7402                	ld	s0,32(sp)
    80004a3c:	64e2                	ld	s1,24(sp)
    80004a3e:	6942                	ld	s2,16(sp)
    80004a40:	69a2                	ld	s3,8(sp)
    80004a42:	6a02                	ld	s4,0(sp)
    80004a44:	6145                	addi	sp,sp,48
    80004a46:	8082                	ret
  return -1;
    80004a48:	557d                	li	a0,-1
    80004a4a:	b7fd                	j	80004a38 <pipealloc+0xc6>

0000000080004a4c <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80004a4c:	1101                	addi	sp,sp,-32
    80004a4e:	ec06                	sd	ra,24(sp)
    80004a50:	e822                	sd	s0,16(sp)
    80004a52:	e426                	sd	s1,8(sp)
    80004a54:	e04a                	sd	s2,0(sp)
    80004a56:	1000                	addi	s0,sp,32
    80004a58:	84aa                	mv	s1,a0
    80004a5a:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80004a5c:	ffffc097          	auipc	ra,0xffffc
    80004a60:	17a080e7          	jalr	378(ra) # 80000bd6 <acquire>
  if(writable){
    80004a64:	02090d63          	beqz	s2,80004a9e <pipeclose+0x52>
    pi->writeopen = 0;
    80004a68:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80004a6c:	21848513          	addi	a0,s1,536
    80004a70:	ffffd097          	auipc	ra,0xffffd
    80004a74:	71c080e7          	jalr	1820(ra) # 8000218c <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80004a78:	2204b783          	ld	a5,544(s1)
    80004a7c:	eb95                	bnez	a5,80004ab0 <pipeclose+0x64>
    release(&pi->lock);
    80004a7e:	8526                	mv	a0,s1
    80004a80:	ffffc097          	auipc	ra,0xffffc
    80004a84:	20a080e7          	jalr	522(ra) # 80000c8a <release>
    kfree((char*)pi);
    80004a88:	8526                	mv	a0,s1
    80004a8a:	ffffc097          	auipc	ra,0xffffc
    80004a8e:	f60080e7          	jalr	-160(ra) # 800009ea <kfree>
  } else
    release(&pi->lock);
}
    80004a92:	60e2                	ld	ra,24(sp)
    80004a94:	6442                	ld	s0,16(sp)
    80004a96:	64a2                	ld	s1,8(sp)
    80004a98:	6902                	ld	s2,0(sp)
    80004a9a:	6105                	addi	sp,sp,32
    80004a9c:	8082                	ret
    pi->readopen = 0;
    80004a9e:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80004aa2:	21c48513          	addi	a0,s1,540
    80004aa6:	ffffd097          	auipc	ra,0xffffd
    80004aaa:	6e6080e7          	jalr	1766(ra) # 8000218c <wakeup>
    80004aae:	b7e9                	j	80004a78 <pipeclose+0x2c>
    release(&pi->lock);
    80004ab0:	8526                	mv	a0,s1
    80004ab2:	ffffc097          	auipc	ra,0xffffc
    80004ab6:	1d8080e7          	jalr	472(ra) # 80000c8a <release>
}
    80004aba:	bfe1                	j	80004a92 <pipeclose+0x46>

0000000080004abc <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80004abc:	711d                	addi	sp,sp,-96
    80004abe:	ec86                	sd	ra,88(sp)
    80004ac0:	e8a2                	sd	s0,80(sp)
    80004ac2:	e4a6                	sd	s1,72(sp)
    80004ac4:	e0ca                	sd	s2,64(sp)
    80004ac6:	fc4e                	sd	s3,56(sp)
    80004ac8:	f852                	sd	s4,48(sp)
    80004aca:	f456                	sd	s5,40(sp)
    80004acc:	f05a                	sd	s6,32(sp)
    80004ace:	ec5e                	sd	s7,24(sp)
    80004ad0:	e862                	sd	s8,16(sp)
    80004ad2:	1080                	addi	s0,sp,96
    80004ad4:	84aa                	mv	s1,a0
    80004ad6:	8aae                	mv	s5,a1
    80004ad8:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80004ada:	ffffd097          	auipc	ra,0xffffd
    80004ade:	ee2080e7          	jalr	-286(ra) # 800019bc <myproc>
    80004ae2:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80004ae4:	8526                	mv	a0,s1
    80004ae6:	ffffc097          	auipc	ra,0xffffc
    80004aea:	0f0080e7          	jalr	240(ra) # 80000bd6 <acquire>
  while(i < n){
    80004aee:	0b405663          	blez	s4,80004b9a <pipewrite+0xde>
  int i = 0;
    80004af2:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004af4:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80004af6:	21848c13          	addi	s8,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80004afa:	21c48b93          	addi	s7,s1,540
    80004afe:	a089                	j	80004b40 <pipewrite+0x84>
      release(&pi->lock);
    80004b00:	8526                	mv	a0,s1
    80004b02:	ffffc097          	auipc	ra,0xffffc
    80004b06:	188080e7          	jalr	392(ra) # 80000c8a <release>
      return -1;
    80004b0a:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80004b0c:	854a                	mv	a0,s2
    80004b0e:	60e6                	ld	ra,88(sp)
    80004b10:	6446                	ld	s0,80(sp)
    80004b12:	64a6                	ld	s1,72(sp)
    80004b14:	6906                	ld	s2,64(sp)
    80004b16:	79e2                	ld	s3,56(sp)
    80004b18:	7a42                	ld	s4,48(sp)
    80004b1a:	7aa2                	ld	s5,40(sp)
    80004b1c:	7b02                	ld	s6,32(sp)
    80004b1e:	6be2                	ld	s7,24(sp)
    80004b20:	6c42                	ld	s8,16(sp)
    80004b22:	6125                	addi	sp,sp,96
    80004b24:	8082                	ret
      wakeup(&pi->nread);
    80004b26:	8562                	mv	a0,s8
    80004b28:	ffffd097          	auipc	ra,0xffffd
    80004b2c:	664080e7          	jalr	1636(ra) # 8000218c <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80004b30:	85a6                	mv	a1,s1
    80004b32:	855e                	mv	a0,s7
    80004b34:	ffffd097          	auipc	ra,0xffffd
    80004b38:	5f4080e7          	jalr	1524(ra) # 80002128 <sleep>
  while(i < n){
    80004b3c:	07495063          	bge	s2,s4,80004b9c <pipewrite+0xe0>
    if(pi->readopen == 0 || killed(pr)){
    80004b40:	2204a783          	lw	a5,544(s1)
    80004b44:	dfd5                	beqz	a5,80004b00 <pipewrite+0x44>
    80004b46:	854e                	mv	a0,s3
    80004b48:	ffffe097          	auipc	ra,0xffffe
    80004b4c:	8b0080e7          	jalr	-1872(ra) # 800023f8 <killed>
    80004b50:	f945                	bnez	a0,80004b00 <pipewrite+0x44>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80004b52:	2184a783          	lw	a5,536(s1)
    80004b56:	21c4a703          	lw	a4,540(s1)
    80004b5a:	2007879b          	addiw	a5,a5,512
    80004b5e:	fcf704e3          	beq	a4,a5,80004b26 <pipewrite+0x6a>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004b62:	4685                	li	a3,1
    80004b64:	01590633          	add	a2,s2,s5
    80004b68:	faf40593          	addi	a1,s0,-81
    80004b6c:	0989b503          	ld	a0,152(s3)
    80004b70:	ffffd097          	auipc	ra,0xffffd
    80004b74:	b86080e7          	jalr	-1146(ra) # 800016f6 <copyin>
    80004b78:	03650263          	beq	a0,s6,80004b9c <pipewrite+0xe0>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80004b7c:	21c4a783          	lw	a5,540(s1)
    80004b80:	0017871b          	addiw	a4,a5,1
    80004b84:	20e4ae23          	sw	a4,540(s1)
    80004b88:	1ff7f793          	andi	a5,a5,511
    80004b8c:	97a6                	add	a5,a5,s1
    80004b8e:	faf44703          	lbu	a4,-81(s0)
    80004b92:	00e78c23          	sb	a4,24(a5)
      i++;
    80004b96:	2905                	addiw	s2,s2,1
    80004b98:	b755                	j	80004b3c <pipewrite+0x80>
  int i = 0;
    80004b9a:	4901                	li	s2,0
  wakeup(&pi->nread);
    80004b9c:	21848513          	addi	a0,s1,536
    80004ba0:	ffffd097          	auipc	ra,0xffffd
    80004ba4:	5ec080e7          	jalr	1516(ra) # 8000218c <wakeup>
  release(&pi->lock);
    80004ba8:	8526                	mv	a0,s1
    80004baa:	ffffc097          	auipc	ra,0xffffc
    80004bae:	0e0080e7          	jalr	224(ra) # 80000c8a <release>
  return i;
    80004bb2:	bfa9                	j	80004b0c <pipewrite+0x50>

0000000080004bb4 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80004bb4:	715d                	addi	sp,sp,-80
    80004bb6:	e486                	sd	ra,72(sp)
    80004bb8:	e0a2                	sd	s0,64(sp)
    80004bba:	fc26                	sd	s1,56(sp)
    80004bbc:	f84a                	sd	s2,48(sp)
    80004bbe:	f44e                	sd	s3,40(sp)
    80004bc0:	f052                	sd	s4,32(sp)
    80004bc2:	ec56                	sd	s5,24(sp)
    80004bc4:	e85a                	sd	s6,16(sp)
    80004bc6:	0880                	addi	s0,sp,80
    80004bc8:	84aa                	mv	s1,a0
    80004bca:	892e                	mv	s2,a1
    80004bcc:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80004bce:	ffffd097          	auipc	ra,0xffffd
    80004bd2:	dee080e7          	jalr	-530(ra) # 800019bc <myproc>
    80004bd6:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80004bd8:	8526                	mv	a0,s1
    80004bda:	ffffc097          	auipc	ra,0xffffc
    80004bde:	ffc080e7          	jalr	-4(ra) # 80000bd6 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004be2:	2184a703          	lw	a4,536(s1)
    80004be6:	21c4a783          	lw	a5,540(s1)
    if(killed(pr)){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004bea:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004bee:	02f71763          	bne	a4,a5,80004c1c <piperead+0x68>
    80004bf2:	2244a783          	lw	a5,548(s1)
    80004bf6:	c39d                	beqz	a5,80004c1c <piperead+0x68>
    if(killed(pr)){
    80004bf8:	8552                	mv	a0,s4
    80004bfa:	ffffd097          	auipc	ra,0xffffd
    80004bfe:	7fe080e7          	jalr	2046(ra) # 800023f8 <killed>
    80004c02:	e941                	bnez	a0,80004c92 <piperead+0xde>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004c04:	85a6                	mv	a1,s1
    80004c06:	854e                	mv	a0,s3
    80004c08:	ffffd097          	auipc	ra,0xffffd
    80004c0c:	520080e7          	jalr	1312(ra) # 80002128 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004c10:	2184a703          	lw	a4,536(s1)
    80004c14:	21c4a783          	lw	a5,540(s1)
    80004c18:	fcf70de3          	beq	a4,a5,80004bf2 <piperead+0x3e>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004c1c:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004c1e:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004c20:	05505363          	blez	s5,80004c66 <piperead+0xb2>
    if(pi->nread == pi->nwrite)
    80004c24:	2184a783          	lw	a5,536(s1)
    80004c28:	21c4a703          	lw	a4,540(s1)
    80004c2c:	02f70d63          	beq	a4,a5,80004c66 <piperead+0xb2>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80004c30:	0017871b          	addiw	a4,a5,1
    80004c34:	20e4ac23          	sw	a4,536(s1)
    80004c38:	1ff7f793          	andi	a5,a5,511
    80004c3c:	97a6                	add	a5,a5,s1
    80004c3e:	0187c783          	lbu	a5,24(a5)
    80004c42:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004c46:	4685                	li	a3,1
    80004c48:	fbf40613          	addi	a2,s0,-65
    80004c4c:	85ca                	mv	a1,s2
    80004c4e:	098a3503          	ld	a0,152(s4)
    80004c52:	ffffd097          	auipc	ra,0xffffd
    80004c56:	a18080e7          	jalr	-1512(ra) # 8000166a <copyout>
    80004c5a:	01650663          	beq	a0,s6,80004c66 <piperead+0xb2>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004c5e:	2985                	addiw	s3,s3,1
    80004c60:	0905                	addi	s2,s2,1
    80004c62:	fd3a91e3          	bne	s5,s3,80004c24 <piperead+0x70>
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80004c66:	21c48513          	addi	a0,s1,540
    80004c6a:	ffffd097          	auipc	ra,0xffffd
    80004c6e:	522080e7          	jalr	1314(ra) # 8000218c <wakeup>
  release(&pi->lock);
    80004c72:	8526                	mv	a0,s1
    80004c74:	ffffc097          	auipc	ra,0xffffc
    80004c78:	016080e7          	jalr	22(ra) # 80000c8a <release>
  return i;
}
    80004c7c:	854e                	mv	a0,s3
    80004c7e:	60a6                	ld	ra,72(sp)
    80004c80:	6406                	ld	s0,64(sp)
    80004c82:	74e2                	ld	s1,56(sp)
    80004c84:	7942                	ld	s2,48(sp)
    80004c86:	79a2                	ld	s3,40(sp)
    80004c88:	7a02                	ld	s4,32(sp)
    80004c8a:	6ae2                	ld	s5,24(sp)
    80004c8c:	6b42                	ld	s6,16(sp)
    80004c8e:	6161                	addi	sp,sp,80
    80004c90:	8082                	ret
      release(&pi->lock);
    80004c92:	8526                	mv	a0,s1
    80004c94:	ffffc097          	auipc	ra,0xffffc
    80004c98:	ff6080e7          	jalr	-10(ra) # 80000c8a <release>
      return -1;
    80004c9c:	59fd                	li	s3,-1
    80004c9e:	bff9                	j	80004c7c <piperead+0xc8>

0000000080004ca0 <flags2perm>:
#include "elf.h"

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

int flags2perm(int flags)
{
    80004ca0:	1141                	addi	sp,sp,-16
    80004ca2:	e422                	sd	s0,8(sp)
    80004ca4:	0800                	addi	s0,sp,16
    80004ca6:	87aa                	mv	a5,a0
    int perm = 0;
    if(flags & 0x1)
    80004ca8:	8905                	andi	a0,a0,1
    80004caa:	c111                	beqz	a0,80004cae <flags2perm+0xe>
      perm = PTE_X;
    80004cac:	4521                	li	a0,8
    if(flags & 0x2)
    80004cae:	8b89                	andi	a5,a5,2
    80004cb0:	c399                	beqz	a5,80004cb6 <flags2perm+0x16>
      perm |= PTE_W;
    80004cb2:	00456513          	ori	a0,a0,4
    return perm;
}
    80004cb6:	6422                	ld	s0,8(sp)
    80004cb8:	0141                	addi	sp,sp,16
    80004cba:	8082                	ret

0000000080004cbc <exec>:

int
exec(char *path, char **argv)
{
    80004cbc:	de010113          	addi	sp,sp,-544
    80004cc0:	20113c23          	sd	ra,536(sp)
    80004cc4:	20813823          	sd	s0,528(sp)
    80004cc8:	20913423          	sd	s1,520(sp)
    80004ccc:	21213023          	sd	s2,512(sp)
    80004cd0:	ffce                	sd	s3,504(sp)
    80004cd2:	fbd2                	sd	s4,496(sp)
    80004cd4:	f7d6                	sd	s5,488(sp)
    80004cd6:	f3da                	sd	s6,480(sp)
    80004cd8:	efde                	sd	s7,472(sp)
    80004cda:	ebe2                	sd	s8,464(sp)
    80004cdc:	e7e6                	sd	s9,456(sp)
    80004cde:	e3ea                	sd	s10,448(sp)
    80004ce0:	ff6e                	sd	s11,440(sp)
    80004ce2:	1400                	addi	s0,sp,544
    80004ce4:	892a                	mv	s2,a0
    80004ce6:	dea43423          	sd	a0,-536(s0)
    80004cea:	deb43823          	sd	a1,-528(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80004cee:	ffffd097          	auipc	ra,0xffffd
    80004cf2:	cce080e7          	jalr	-818(ra) # 800019bc <myproc>
    80004cf6:	84aa                	mv	s1,a0

  begin_op();
    80004cf8:	fffff097          	auipc	ra,0xfffff
    80004cfc:	47e080e7          	jalr	1150(ra) # 80004176 <begin_op>

  if((ip = namei(path)) == 0){
    80004d00:	854a                	mv	a0,s2
    80004d02:	fffff097          	auipc	ra,0xfffff
    80004d06:	258080e7          	jalr	600(ra) # 80003f5a <namei>
    80004d0a:	c93d                	beqz	a0,80004d80 <exec+0xc4>
    80004d0c:	8aaa                	mv	s5,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80004d0e:	fffff097          	auipc	ra,0xfffff
    80004d12:	aa6080e7          	jalr	-1370(ra) # 800037b4 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80004d16:	04000713          	li	a4,64
    80004d1a:	4681                	li	a3,0
    80004d1c:	e5040613          	addi	a2,s0,-432
    80004d20:	4581                	li	a1,0
    80004d22:	8556                	mv	a0,s5
    80004d24:	fffff097          	auipc	ra,0xfffff
    80004d28:	d44080e7          	jalr	-700(ra) # 80003a68 <readi>
    80004d2c:	04000793          	li	a5,64
    80004d30:	00f51a63          	bne	a0,a5,80004d44 <exec+0x88>
    goto bad;

  if(elf.magic != ELF_MAGIC)
    80004d34:	e5042703          	lw	a4,-432(s0)
    80004d38:	464c47b7          	lui	a5,0x464c4
    80004d3c:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80004d40:	04f70663          	beq	a4,a5,80004d8c <exec+0xd0>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80004d44:	8556                	mv	a0,s5
    80004d46:	fffff097          	auipc	ra,0xfffff
    80004d4a:	cd0080e7          	jalr	-816(ra) # 80003a16 <iunlockput>
    end_op();
    80004d4e:	fffff097          	auipc	ra,0xfffff
    80004d52:	4a8080e7          	jalr	1192(ra) # 800041f6 <end_op>
  }
  return -1;
    80004d56:	557d                	li	a0,-1
}
    80004d58:	21813083          	ld	ra,536(sp)
    80004d5c:	21013403          	ld	s0,528(sp)
    80004d60:	20813483          	ld	s1,520(sp)
    80004d64:	20013903          	ld	s2,512(sp)
    80004d68:	79fe                	ld	s3,504(sp)
    80004d6a:	7a5e                	ld	s4,496(sp)
    80004d6c:	7abe                	ld	s5,488(sp)
    80004d6e:	7b1e                	ld	s6,480(sp)
    80004d70:	6bfe                	ld	s7,472(sp)
    80004d72:	6c5e                	ld	s8,464(sp)
    80004d74:	6cbe                	ld	s9,456(sp)
    80004d76:	6d1e                	ld	s10,448(sp)
    80004d78:	7dfa                	ld	s11,440(sp)
    80004d7a:	22010113          	addi	sp,sp,544
    80004d7e:	8082                	ret
    end_op();
    80004d80:	fffff097          	auipc	ra,0xfffff
    80004d84:	476080e7          	jalr	1142(ra) # 800041f6 <end_op>
    return -1;
    80004d88:	557d                	li	a0,-1
    80004d8a:	b7f9                	j	80004d58 <exec+0x9c>
  if((pagetable = proc_pagetable(p)) == 0)
    80004d8c:	8526                	mv	a0,s1
    80004d8e:	ffffd097          	auipc	ra,0xffffd
    80004d92:	cf2080e7          	jalr	-782(ra) # 80001a80 <proc_pagetable>
    80004d96:	8b2a                	mv	s6,a0
    80004d98:	d555                	beqz	a0,80004d44 <exec+0x88>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004d9a:	e7042783          	lw	a5,-400(s0)
    80004d9e:	e8845703          	lhu	a4,-376(s0)
    80004da2:	c735                	beqz	a4,80004e0e <exec+0x152>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004da4:	4901                	li	s2,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004da6:	e0043423          	sd	zero,-504(s0)
    if(ph.vaddr % PGSIZE != 0)
    80004daa:	6a05                	lui	s4,0x1
    80004dac:	fffa0713          	addi	a4,s4,-1 # fff <_entry-0x7ffff001>
    80004db0:	dee43023          	sd	a4,-544(s0)
loadseg(pagetable_t pagetable, uint64 va, struct inode *ip, uint offset, uint sz)
{
  uint i, n;
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    80004db4:	6d85                	lui	s11,0x1
    80004db6:	7d7d                	lui	s10,0xfffff
    80004db8:	a481                	j	80004ff8 <exec+0x33c>
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    80004dba:	00004517          	auipc	a0,0x4
    80004dbe:	92650513          	addi	a0,a0,-1754 # 800086e0 <syscalls+0x288>
    80004dc2:	ffffb097          	auipc	ra,0xffffb
    80004dc6:	77c080e7          	jalr	1916(ra) # 8000053e <panic>
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80004dca:	874a                	mv	a4,s2
    80004dcc:	009c86bb          	addw	a3,s9,s1
    80004dd0:	4581                	li	a1,0
    80004dd2:	8556                	mv	a0,s5
    80004dd4:	fffff097          	auipc	ra,0xfffff
    80004dd8:	c94080e7          	jalr	-876(ra) # 80003a68 <readi>
    80004ddc:	2501                	sext.w	a0,a0
    80004dde:	1aa91a63          	bne	s2,a0,80004f92 <exec+0x2d6>
  for(i = 0; i < sz; i += PGSIZE){
    80004de2:	009d84bb          	addw	s1,s11,s1
    80004de6:	013d09bb          	addw	s3,s10,s3
    80004dea:	1f74f763          	bgeu	s1,s7,80004fd8 <exec+0x31c>
    pa = walkaddr(pagetable, va + i);
    80004dee:	02049593          	slli	a1,s1,0x20
    80004df2:	9181                	srli	a1,a1,0x20
    80004df4:	95e2                	add	a1,a1,s8
    80004df6:	855a                	mv	a0,s6
    80004df8:	ffffc097          	auipc	ra,0xffffc
    80004dfc:	266080e7          	jalr	614(ra) # 8000105e <walkaddr>
    80004e00:	862a                	mv	a2,a0
    if(pa == 0)
    80004e02:	dd45                	beqz	a0,80004dba <exec+0xfe>
      n = PGSIZE;
    80004e04:	8952                	mv	s2,s4
    if(sz - i < PGSIZE)
    80004e06:	fd49f2e3          	bgeu	s3,s4,80004dca <exec+0x10e>
      n = sz - i;
    80004e0a:	894e                	mv	s2,s3
    80004e0c:	bf7d                	j	80004dca <exec+0x10e>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004e0e:	4901                	li	s2,0
  iunlockput(ip);
    80004e10:	8556                	mv	a0,s5
    80004e12:	fffff097          	auipc	ra,0xfffff
    80004e16:	c04080e7          	jalr	-1020(ra) # 80003a16 <iunlockput>
  end_op();
    80004e1a:	fffff097          	auipc	ra,0xfffff
    80004e1e:	3dc080e7          	jalr	988(ra) # 800041f6 <end_op>
  p = myproc();
    80004e22:	ffffd097          	auipc	ra,0xffffd
    80004e26:	b9a080e7          	jalr	-1126(ra) # 800019bc <myproc>
    80004e2a:	8baa                	mv	s7,a0
  uint64 oldsz = p->sz;
    80004e2c:	09053d03          	ld	s10,144(a0)
  sz = PGROUNDUP(sz);
    80004e30:	6785                	lui	a5,0x1
    80004e32:	17fd                	addi	a5,a5,-1
    80004e34:	993e                	add	s2,s2,a5
    80004e36:	77fd                	lui	a5,0xfffff
    80004e38:	00f977b3          	and	a5,s2,a5
    80004e3c:	def43c23          	sd	a5,-520(s0)
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
    80004e40:	4691                	li	a3,4
    80004e42:	6609                	lui	a2,0x2
    80004e44:	963e                	add	a2,a2,a5
    80004e46:	85be                	mv	a1,a5
    80004e48:	855a                	mv	a0,s6
    80004e4a:	ffffc097          	auipc	ra,0xffffc
    80004e4e:	5c8080e7          	jalr	1480(ra) # 80001412 <uvmalloc>
    80004e52:	8c2a                	mv	s8,a0
  ip = 0;
    80004e54:	4a81                	li	s5,0
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
    80004e56:	12050e63          	beqz	a0,80004f92 <exec+0x2d6>
  uvmclear(pagetable, sz-2*PGSIZE);
    80004e5a:	75f9                	lui	a1,0xffffe
    80004e5c:	95aa                	add	a1,a1,a0
    80004e5e:	855a                	mv	a0,s6
    80004e60:	ffffc097          	auipc	ra,0xffffc
    80004e64:	7d8080e7          	jalr	2008(ra) # 80001638 <uvmclear>
  stackbase = sp - PGSIZE;
    80004e68:	7afd                	lui	s5,0xfffff
    80004e6a:	9ae2                	add	s5,s5,s8
  for(argc = 0; argv[argc]; argc++) {
    80004e6c:	df043783          	ld	a5,-528(s0)
    80004e70:	6388                	ld	a0,0(a5)
    80004e72:	c925                	beqz	a0,80004ee2 <exec+0x226>
    80004e74:	e9040993          	addi	s3,s0,-368
    80004e78:	f9040c93          	addi	s9,s0,-112
  sp = sz;
    80004e7c:	8962                	mv	s2,s8
  for(argc = 0; argv[argc]; argc++) {
    80004e7e:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    80004e80:	ffffc097          	auipc	ra,0xffffc
    80004e84:	fce080e7          	jalr	-50(ra) # 80000e4e <strlen>
    80004e88:	0015079b          	addiw	a5,a0,1
    80004e8c:	40f90933          	sub	s2,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80004e90:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    80004e94:	13596663          	bltu	s2,s5,80004fc0 <exec+0x304>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80004e98:	df043d83          	ld	s11,-528(s0)
    80004e9c:	000dba03          	ld	s4,0(s11) # 1000 <_entry-0x7ffff000>
    80004ea0:	8552                	mv	a0,s4
    80004ea2:	ffffc097          	auipc	ra,0xffffc
    80004ea6:	fac080e7          	jalr	-84(ra) # 80000e4e <strlen>
    80004eaa:	0015069b          	addiw	a3,a0,1
    80004eae:	8652                	mv	a2,s4
    80004eb0:	85ca                	mv	a1,s2
    80004eb2:	855a                	mv	a0,s6
    80004eb4:	ffffc097          	auipc	ra,0xffffc
    80004eb8:	7b6080e7          	jalr	1974(ra) # 8000166a <copyout>
    80004ebc:	10054663          	bltz	a0,80004fc8 <exec+0x30c>
    ustack[argc] = sp;
    80004ec0:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    80004ec4:	0485                	addi	s1,s1,1
    80004ec6:	008d8793          	addi	a5,s11,8
    80004eca:	def43823          	sd	a5,-528(s0)
    80004ece:	008db503          	ld	a0,8(s11)
    80004ed2:	c911                	beqz	a0,80004ee6 <exec+0x22a>
    if(argc >= MAXARG)
    80004ed4:	09a1                	addi	s3,s3,8
    80004ed6:	fb3c95e3          	bne	s9,s3,80004e80 <exec+0x1c4>
  sz = sz1;
    80004eda:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004ede:	4a81                	li	s5,0
    80004ee0:	a84d                	j	80004f92 <exec+0x2d6>
  sp = sz;
    80004ee2:	8962                	mv	s2,s8
  for(argc = 0; argv[argc]; argc++) {
    80004ee4:	4481                	li	s1,0
  ustack[argc] = 0;
    80004ee6:	00349793          	slli	a5,s1,0x3
    80004eea:	f9040713          	addi	a4,s0,-112
    80004eee:	97ba                	add	a5,a5,a4
    80004ef0:	f007b023          	sd	zero,-256(a5) # ffffffffffffef00 <end+0xffffffff7ffdbf90>
  sp -= (argc+1) * sizeof(uint64);
    80004ef4:	00148693          	addi	a3,s1,1
    80004ef8:	068e                	slli	a3,a3,0x3
    80004efa:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80004efe:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    80004f02:	01597663          	bgeu	s2,s5,80004f0e <exec+0x252>
  sz = sz1;
    80004f06:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004f0a:	4a81                	li	s5,0
    80004f0c:	a059                	j	80004f92 <exec+0x2d6>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80004f0e:	e9040613          	addi	a2,s0,-368
    80004f12:	85ca                	mv	a1,s2
    80004f14:	855a                	mv	a0,s6
    80004f16:	ffffc097          	auipc	ra,0xffffc
    80004f1a:	754080e7          	jalr	1876(ra) # 8000166a <copyout>
    80004f1e:	0a054963          	bltz	a0,80004fd0 <exec+0x314>
  p->trapframe->a1 = sp;
    80004f22:	0a0bb783          	ld	a5,160(s7) # 10a0 <_entry-0x7fffef60>
    80004f26:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80004f2a:	de843783          	ld	a5,-536(s0)
    80004f2e:	0007c703          	lbu	a4,0(a5)
    80004f32:	cf11                	beqz	a4,80004f4e <exec+0x292>
    80004f34:	0785                	addi	a5,a5,1
    if(*s == '/')
    80004f36:	02f00693          	li	a3,47
    80004f3a:	a039                	j	80004f48 <exec+0x28c>
      last = s+1;
    80004f3c:	def43423          	sd	a5,-536(s0)
  for(last=s=path; *s; s++)
    80004f40:	0785                	addi	a5,a5,1
    80004f42:	fff7c703          	lbu	a4,-1(a5)
    80004f46:	c701                	beqz	a4,80004f4e <exec+0x292>
    if(*s == '/')
    80004f48:	fed71ce3          	bne	a4,a3,80004f40 <exec+0x284>
    80004f4c:	bfc5                	j	80004f3c <exec+0x280>
  safestrcpy(p->name, last, sizeof(p->name));
    80004f4e:	4641                	li	a2,16
    80004f50:	de843583          	ld	a1,-536(s0)
    80004f54:	1a0b8513          	addi	a0,s7,416
    80004f58:	ffffc097          	auipc	ra,0xffffc
    80004f5c:	ec4080e7          	jalr	-316(ra) # 80000e1c <safestrcpy>
  oldpagetable = p->pagetable;
    80004f60:	098bb503          	ld	a0,152(s7)
  p->pagetable = pagetable;
    80004f64:	096bbc23          	sd	s6,152(s7)
  p->sz = sz;
    80004f68:	098bb823          	sd	s8,144(s7)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80004f6c:	0a0bb783          	ld	a5,160(s7)
    80004f70:	e6843703          	ld	a4,-408(s0)
    80004f74:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80004f76:	0a0bb783          	ld	a5,160(s7)
    80004f7a:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80004f7e:	85ea                	mv	a1,s10
    80004f80:	ffffd097          	auipc	ra,0xffffd
    80004f84:	b9c080e7          	jalr	-1124(ra) # 80001b1c <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80004f88:	0004851b          	sext.w	a0,s1
    80004f8c:	b3f1                	j	80004d58 <exec+0x9c>
    80004f8e:	df243c23          	sd	s2,-520(s0)
    proc_freepagetable(pagetable, sz);
    80004f92:	df843583          	ld	a1,-520(s0)
    80004f96:	855a                	mv	a0,s6
    80004f98:	ffffd097          	auipc	ra,0xffffd
    80004f9c:	b84080e7          	jalr	-1148(ra) # 80001b1c <proc_freepagetable>
  if(ip){
    80004fa0:	da0a92e3          	bnez	s5,80004d44 <exec+0x88>
  return -1;
    80004fa4:	557d                	li	a0,-1
    80004fa6:	bb4d                	j	80004d58 <exec+0x9c>
    80004fa8:	df243c23          	sd	s2,-520(s0)
    80004fac:	b7dd                	j	80004f92 <exec+0x2d6>
    80004fae:	df243c23          	sd	s2,-520(s0)
    80004fb2:	b7c5                	j	80004f92 <exec+0x2d6>
    80004fb4:	df243c23          	sd	s2,-520(s0)
    80004fb8:	bfe9                	j	80004f92 <exec+0x2d6>
    80004fba:	df243c23          	sd	s2,-520(s0)
    80004fbe:	bfd1                	j	80004f92 <exec+0x2d6>
  sz = sz1;
    80004fc0:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004fc4:	4a81                	li	s5,0
    80004fc6:	b7f1                	j	80004f92 <exec+0x2d6>
  sz = sz1;
    80004fc8:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004fcc:	4a81                	li	s5,0
    80004fce:	b7d1                	j	80004f92 <exec+0x2d6>
  sz = sz1;
    80004fd0:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004fd4:	4a81                	li	s5,0
    80004fd6:	bf75                	j	80004f92 <exec+0x2d6>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80004fd8:	df843903          	ld	s2,-520(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004fdc:	e0843783          	ld	a5,-504(s0)
    80004fe0:	0017869b          	addiw	a3,a5,1
    80004fe4:	e0d43423          	sd	a3,-504(s0)
    80004fe8:	e0043783          	ld	a5,-512(s0)
    80004fec:	0387879b          	addiw	a5,a5,56
    80004ff0:	e8845703          	lhu	a4,-376(s0)
    80004ff4:	e0e6dee3          	bge	a3,a4,80004e10 <exec+0x154>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80004ff8:	2781                	sext.w	a5,a5
    80004ffa:	e0f43023          	sd	a5,-512(s0)
    80004ffe:	03800713          	li	a4,56
    80005002:	86be                	mv	a3,a5
    80005004:	e1840613          	addi	a2,s0,-488
    80005008:	4581                	li	a1,0
    8000500a:	8556                	mv	a0,s5
    8000500c:	fffff097          	auipc	ra,0xfffff
    80005010:	a5c080e7          	jalr	-1444(ra) # 80003a68 <readi>
    80005014:	03800793          	li	a5,56
    80005018:	f6f51be3          	bne	a0,a5,80004f8e <exec+0x2d2>
    if(ph.type != ELF_PROG_LOAD)
    8000501c:	e1842783          	lw	a5,-488(s0)
    80005020:	4705                	li	a4,1
    80005022:	fae79de3          	bne	a5,a4,80004fdc <exec+0x320>
    if(ph.memsz < ph.filesz)
    80005026:	e4043483          	ld	s1,-448(s0)
    8000502a:	e3843783          	ld	a5,-456(s0)
    8000502e:	f6f4ede3          	bltu	s1,a5,80004fa8 <exec+0x2ec>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80005032:	e2843783          	ld	a5,-472(s0)
    80005036:	94be                	add	s1,s1,a5
    80005038:	f6f4ebe3          	bltu	s1,a5,80004fae <exec+0x2f2>
    if(ph.vaddr % PGSIZE != 0)
    8000503c:	de043703          	ld	a4,-544(s0)
    80005040:	8ff9                	and	a5,a5,a4
    80005042:	fbad                	bnez	a5,80004fb4 <exec+0x2f8>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80005044:	e1c42503          	lw	a0,-484(s0)
    80005048:	00000097          	auipc	ra,0x0
    8000504c:	c58080e7          	jalr	-936(ra) # 80004ca0 <flags2perm>
    80005050:	86aa                	mv	a3,a0
    80005052:	8626                	mv	a2,s1
    80005054:	85ca                	mv	a1,s2
    80005056:	855a                	mv	a0,s6
    80005058:	ffffc097          	auipc	ra,0xffffc
    8000505c:	3ba080e7          	jalr	954(ra) # 80001412 <uvmalloc>
    80005060:	dea43c23          	sd	a0,-520(s0)
    80005064:	d939                	beqz	a0,80004fba <exec+0x2fe>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80005066:	e2843c03          	ld	s8,-472(s0)
    8000506a:	e2042c83          	lw	s9,-480(s0)
    8000506e:	e3842b83          	lw	s7,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80005072:	f60b83e3          	beqz	s7,80004fd8 <exec+0x31c>
    80005076:	89de                	mv	s3,s7
    80005078:	4481                	li	s1,0
    8000507a:	bb95                	j	80004dee <exec+0x132>

000000008000507c <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    8000507c:	7179                	addi	sp,sp,-48
    8000507e:	f406                	sd	ra,40(sp)
    80005080:	f022                	sd	s0,32(sp)
    80005082:	ec26                	sd	s1,24(sp)
    80005084:	e84a                	sd	s2,16(sp)
    80005086:	1800                	addi	s0,sp,48
    80005088:	892e                	mv	s2,a1
    8000508a:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    8000508c:	fdc40593          	addi	a1,s0,-36
    80005090:	ffffe097          	auipc	ra,0xffffe
    80005094:	b72080e7          	jalr	-1166(ra) # 80002c02 <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80005098:	fdc42703          	lw	a4,-36(s0)
    8000509c:	47bd                	li	a5,15
    8000509e:	02e7eb63          	bltu	a5,a4,800050d4 <argfd+0x58>
    800050a2:	ffffd097          	auipc	ra,0xffffd
    800050a6:	91a080e7          	jalr	-1766(ra) # 800019bc <myproc>
    800050aa:	fdc42703          	lw	a4,-36(s0)
    800050ae:	02270793          	addi	a5,a4,34
    800050b2:	078e                	slli	a5,a5,0x3
    800050b4:	953e                	add	a0,a0,a5
    800050b6:	651c                	ld	a5,8(a0)
    800050b8:	c385                	beqz	a5,800050d8 <argfd+0x5c>
    return -1;
  if(pfd)
    800050ba:	00090463          	beqz	s2,800050c2 <argfd+0x46>
    *pfd = fd;
    800050be:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    800050c2:	4501                	li	a0,0
  if(pf)
    800050c4:	c091                	beqz	s1,800050c8 <argfd+0x4c>
    *pf = f;
    800050c6:	e09c                	sd	a5,0(s1)
}
    800050c8:	70a2                	ld	ra,40(sp)
    800050ca:	7402                	ld	s0,32(sp)
    800050cc:	64e2                	ld	s1,24(sp)
    800050ce:	6942                	ld	s2,16(sp)
    800050d0:	6145                	addi	sp,sp,48
    800050d2:	8082                	ret
    return -1;
    800050d4:	557d                	li	a0,-1
    800050d6:	bfcd                	j	800050c8 <argfd+0x4c>
    800050d8:	557d                	li	a0,-1
    800050da:	b7fd                	j	800050c8 <argfd+0x4c>

00000000800050dc <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    800050dc:	1101                	addi	sp,sp,-32
    800050de:	ec06                	sd	ra,24(sp)
    800050e0:	e822                	sd	s0,16(sp)
    800050e2:	e426                	sd	s1,8(sp)
    800050e4:	1000                	addi	s0,sp,32
    800050e6:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    800050e8:	ffffd097          	auipc	ra,0xffffd
    800050ec:	8d4080e7          	jalr	-1836(ra) # 800019bc <myproc>
    800050f0:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    800050f2:	11850793          	addi	a5,a0,280
    800050f6:	4501                	li	a0,0
    800050f8:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    800050fa:	6398                	ld	a4,0(a5)
    800050fc:	cb19                	beqz	a4,80005112 <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    800050fe:	2505                	addiw	a0,a0,1
    80005100:	07a1                	addi	a5,a5,8
    80005102:	fed51ce3          	bne	a0,a3,800050fa <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80005106:	557d                	li	a0,-1
}
    80005108:	60e2                	ld	ra,24(sp)
    8000510a:	6442                	ld	s0,16(sp)
    8000510c:	64a2                	ld	s1,8(sp)
    8000510e:	6105                	addi	sp,sp,32
    80005110:	8082                	ret
      p->ofile[fd] = f;
    80005112:	02250793          	addi	a5,a0,34
    80005116:	078e                	slli	a5,a5,0x3
    80005118:	963e                	add	a2,a2,a5
    8000511a:	e604                	sd	s1,8(a2)
      return fd;
    8000511c:	b7f5                	j	80005108 <fdalloc+0x2c>

000000008000511e <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    8000511e:	715d                	addi	sp,sp,-80
    80005120:	e486                	sd	ra,72(sp)
    80005122:	e0a2                	sd	s0,64(sp)
    80005124:	fc26                	sd	s1,56(sp)
    80005126:	f84a                	sd	s2,48(sp)
    80005128:	f44e                	sd	s3,40(sp)
    8000512a:	f052                	sd	s4,32(sp)
    8000512c:	ec56                	sd	s5,24(sp)
    8000512e:	e85a                	sd	s6,16(sp)
    80005130:	0880                	addi	s0,sp,80
    80005132:	8b2e                	mv	s6,a1
    80005134:	89b2                	mv	s3,a2
    80005136:	8936                	mv	s2,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80005138:	fb040593          	addi	a1,s0,-80
    8000513c:	fffff097          	auipc	ra,0xfffff
    80005140:	e3c080e7          	jalr	-452(ra) # 80003f78 <nameiparent>
    80005144:	84aa                	mv	s1,a0
    80005146:	14050f63          	beqz	a0,800052a4 <create+0x186>
    return 0;

  ilock(dp);
    8000514a:	ffffe097          	auipc	ra,0xffffe
    8000514e:	66a080e7          	jalr	1642(ra) # 800037b4 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80005152:	4601                	li	a2,0
    80005154:	fb040593          	addi	a1,s0,-80
    80005158:	8526                	mv	a0,s1
    8000515a:	fffff097          	auipc	ra,0xfffff
    8000515e:	b3e080e7          	jalr	-1218(ra) # 80003c98 <dirlookup>
    80005162:	8aaa                	mv	s5,a0
    80005164:	c931                	beqz	a0,800051b8 <create+0x9a>
    iunlockput(dp);
    80005166:	8526                	mv	a0,s1
    80005168:	fffff097          	auipc	ra,0xfffff
    8000516c:	8ae080e7          	jalr	-1874(ra) # 80003a16 <iunlockput>
    ilock(ip);
    80005170:	8556                	mv	a0,s5
    80005172:	ffffe097          	auipc	ra,0xffffe
    80005176:	642080e7          	jalr	1602(ra) # 800037b4 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    8000517a:	000b059b          	sext.w	a1,s6
    8000517e:	4789                	li	a5,2
    80005180:	02f59563          	bne	a1,a5,800051aa <create+0x8c>
    80005184:	044ad783          	lhu	a5,68(s5) # fffffffffffff044 <end+0xffffffff7ffdc0d4>
    80005188:	37f9                	addiw	a5,a5,-2
    8000518a:	17c2                	slli	a5,a5,0x30
    8000518c:	93c1                	srli	a5,a5,0x30
    8000518e:	4705                	li	a4,1
    80005190:	00f76d63          	bltu	a4,a5,800051aa <create+0x8c>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    80005194:	8556                	mv	a0,s5
    80005196:	60a6                	ld	ra,72(sp)
    80005198:	6406                	ld	s0,64(sp)
    8000519a:	74e2                	ld	s1,56(sp)
    8000519c:	7942                	ld	s2,48(sp)
    8000519e:	79a2                	ld	s3,40(sp)
    800051a0:	7a02                	ld	s4,32(sp)
    800051a2:	6ae2                	ld	s5,24(sp)
    800051a4:	6b42                	ld	s6,16(sp)
    800051a6:	6161                	addi	sp,sp,80
    800051a8:	8082                	ret
    iunlockput(ip);
    800051aa:	8556                	mv	a0,s5
    800051ac:	fffff097          	auipc	ra,0xfffff
    800051b0:	86a080e7          	jalr	-1942(ra) # 80003a16 <iunlockput>
    return 0;
    800051b4:	4a81                	li	s5,0
    800051b6:	bff9                	j	80005194 <create+0x76>
  if((ip = ialloc(dp->dev, type)) == 0){
    800051b8:	85da                	mv	a1,s6
    800051ba:	4088                	lw	a0,0(s1)
    800051bc:	ffffe097          	auipc	ra,0xffffe
    800051c0:	45c080e7          	jalr	1116(ra) # 80003618 <ialloc>
    800051c4:	8a2a                	mv	s4,a0
    800051c6:	c539                	beqz	a0,80005214 <create+0xf6>
  ilock(ip);
    800051c8:	ffffe097          	auipc	ra,0xffffe
    800051cc:	5ec080e7          	jalr	1516(ra) # 800037b4 <ilock>
  ip->major = major;
    800051d0:	053a1323          	sh	s3,70(s4)
  ip->minor = minor;
    800051d4:	052a1423          	sh	s2,72(s4)
  ip->nlink = 1;
    800051d8:	4905                	li	s2,1
    800051da:	052a1523          	sh	s2,74(s4)
  iupdate(ip);
    800051de:	8552                	mv	a0,s4
    800051e0:	ffffe097          	auipc	ra,0xffffe
    800051e4:	50a080e7          	jalr	1290(ra) # 800036ea <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    800051e8:	000b059b          	sext.w	a1,s6
    800051ec:	03258b63          	beq	a1,s2,80005222 <create+0x104>
  if(dirlink(dp, name, ip->inum) < 0)
    800051f0:	004a2603          	lw	a2,4(s4)
    800051f4:	fb040593          	addi	a1,s0,-80
    800051f8:	8526                	mv	a0,s1
    800051fa:	fffff097          	auipc	ra,0xfffff
    800051fe:	cae080e7          	jalr	-850(ra) # 80003ea8 <dirlink>
    80005202:	06054f63          	bltz	a0,80005280 <create+0x162>
  iunlockput(dp);
    80005206:	8526                	mv	a0,s1
    80005208:	fffff097          	auipc	ra,0xfffff
    8000520c:	80e080e7          	jalr	-2034(ra) # 80003a16 <iunlockput>
  return ip;
    80005210:	8ad2                	mv	s5,s4
    80005212:	b749                	j	80005194 <create+0x76>
    iunlockput(dp);
    80005214:	8526                	mv	a0,s1
    80005216:	fffff097          	auipc	ra,0xfffff
    8000521a:	800080e7          	jalr	-2048(ra) # 80003a16 <iunlockput>
    return 0;
    8000521e:	8ad2                	mv	s5,s4
    80005220:	bf95                	j	80005194 <create+0x76>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80005222:	004a2603          	lw	a2,4(s4)
    80005226:	00003597          	auipc	a1,0x3
    8000522a:	4da58593          	addi	a1,a1,1242 # 80008700 <syscalls+0x2a8>
    8000522e:	8552                	mv	a0,s4
    80005230:	fffff097          	auipc	ra,0xfffff
    80005234:	c78080e7          	jalr	-904(ra) # 80003ea8 <dirlink>
    80005238:	04054463          	bltz	a0,80005280 <create+0x162>
    8000523c:	40d0                	lw	a2,4(s1)
    8000523e:	00003597          	auipc	a1,0x3
    80005242:	4ca58593          	addi	a1,a1,1226 # 80008708 <syscalls+0x2b0>
    80005246:	8552                	mv	a0,s4
    80005248:	fffff097          	auipc	ra,0xfffff
    8000524c:	c60080e7          	jalr	-928(ra) # 80003ea8 <dirlink>
    80005250:	02054863          	bltz	a0,80005280 <create+0x162>
  if(dirlink(dp, name, ip->inum) < 0)
    80005254:	004a2603          	lw	a2,4(s4)
    80005258:	fb040593          	addi	a1,s0,-80
    8000525c:	8526                	mv	a0,s1
    8000525e:	fffff097          	auipc	ra,0xfffff
    80005262:	c4a080e7          	jalr	-950(ra) # 80003ea8 <dirlink>
    80005266:	00054d63          	bltz	a0,80005280 <create+0x162>
    dp->nlink++;  // for ".."
    8000526a:	04a4d783          	lhu	a5,74(s1)
    8000526e:	2785                	addiw	a5,a5,1
    80005270:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80005274:	8526                	mv	a0,s1
    80005276:	ffffe097          	auipc	ra,0xffffe
    8000527a:	474080e7          	jalr	1140(ra) # 800036ea <iupdate>
    8000527e:	b761                	j	80005206 <create+0xe8>
  ip->nlink = 0;
    80005280:	040a1523          	sh	zero,74(s4)
  iupdate(ip);
    80005284:	8552                	mv	a0,s4
    80005286:	ffffe097          	auipc	ra,0xffffe
    8000528a:	464080e7          	jalr	1124(ra) # 800036ea <iupdate>
  iunlockput(ip);
    8000528e:	8552                	mv	a0,s4
    80005290:	ffffe097          	auipc	ra,0xffffe
    80005294:	786080e7          	jalr	1926(ra) # 80003a16 <iunlockput>
  iunlockput(dp);
    80005298:	8526                	mv	a0,s1
    8000529a:	ffffe097          	auipc	ra,0xffffe
    8000529e:	77c080e7          	jalr	1916(ra) # 80003a16 <iunlockput>
  return 0;
    800052a2:	bdcd                	j	80005194 <create+0x76>
    return 0;
    800052a4:	8aaa                	mv	s5,a0
    800052a6:	b5fd                	j	80005194 <create+0x76>

00000000800052a8 <sys_dup>:
{
    800052a8:	7179                	addi	sp,sp,-48
    800052aa:	f406                	sd	ra,40(sp)
    800052ac:	f022                	sd	s0,32(sp)
    800052ae:	ec26                	sd	s1,24(sp)
    800052b0:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    800052b2:	fd840613          	addi	a2,s0,-40
    800052b6:	4581                	li	a1,0
    800052b8:	4501                	li	a0,0
    800052ba:	00000097          	auipc	ra,0x0
    800052be:	dc2080e7          	jalr	-574(ra) # 8000507c <argfd>
    return -1;
    800052c2:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    800052c4:	02054363          	bltz	a0,800052ea <sys_dup+0x42>
  if((fd=fdalloc(f)) < 0)
    800052c8:	fd843503          	ld	a0,-40(s0)
    800052cc:	00000097          	auipc	ra,0x0
    800052d0:	e10080e7          	jalr	-496(ra) # 800050dc <fdalloc>
    800052d4:	84aa                	mv	s1,a0
    return -1;
    800052d6:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    800052d8:	00054963          	bltz	a0,800052ea <sys_dup+0x42>
  filedup(f);
    800052dc:	fd843503          	ld	a0,-40(s0)
    800052e0:	fffff097          	auipc	ra,0xfffff
    800052e4:	310080e7          	jalr	784(ra) # 800045f0 <filedup>
  return fd;
    800052e8:	87a6                	mv	a5,s1
}
    800052ea:	853e                	mv	a0,a5
    800052ec:	70a2                	ld	ra,40(sp)
    800052ee:	7402                	ld	s0,32(sp)
    800052f0:	64e2                	ld	s1,24(sp)
    800052f2:	6145                	addi	sp,sp,48
    800052f4:	8082                	ret

00000000800052f6 <sys_read>:
{
    800052f6:	7179                	addi	sp,sp,-48
    800052f8:	f406                	sd	ra,40(sp)
    800052fa:	f022                	sd	s0,32(sp)
    800052fc:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    800052fe:	fd840593          	addi	a1,s0,-40
    80005302:	4505                	li	a0,1
    80005304:	ffffe097          	auipc	ra,0xffffe
    80005308:	91e080e7          	jalr	-1762(ra) # 80002c22 <argaddr>
  argint(2, &n);
    8000530c:	fe440593          	addi	a1,s0,-28
    80005310:	4509                	li	a0,2
    80005312:	ffffe097          	auipc	ra,0xffffe
    80005316:	8f0080e7          	jalr	-1808(ra) # 80002c02 <argint>
  if(argfd(0, 0, &f) < 0)
    8000531a:	fe840613          	addi	a2,s0,-24
    8000531e:	4581                	li	a1,0
    80005320:	4501                	li	a0,0
    80005322:	00000097          	auipc	ra,0x0
    80005326:	d5a080e7          	jalr	-678(ra) # 8000507c <argfd>
    8000532a:	87aa                	mv	a5,a0
    return -1;
    8000532c:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    8000532e:	0007cc63          	bltz	a5,80005346 <sys_read+0x50>
  return fileread(f, p, n);
    80005332:	fe442603          	lw	a2,-28(s0)
    80005336:	fd843583          	ld	a1,-40(s0)
    8000533a:	fe843503          	ld	a0,-24(s0)
    8000533e:	fffff097          	auipc	ra,0xfffff
    80005342:	43e080e7          	jalr	1086(ra) # 8000477c <fileread>
}
    80005346:	70a2                	ld	ra,40(sp)
    80005348:	7402                	ld	s0,32(sp)
    8000534a:	6145                	addi	sp,sp,48
    8000534c:	8082                	ret

000000008000534e <sys_write>:
{
    8000534e:	7179                	addi	sp,sp,-48
    80005350:	f406                	sd	ra,40(sp)
    80005352:	f022                	sd	s0,32(sp)
    80005354:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80005356:	fd840593          	addi	a1,s0,-40
    8000535a:	4505                	li	a0,1
    8000535c:	ffffe097          	auipc	ra,0xffffe
    80005360:	8c6080e7          	jalr	-1850(ra) # 80002c22 <argaddr>
  argint(2, &n);
    80005364:	fe440593          	addi	a1,s0,-28
    80005368:	4509                	li	a0,2
    8000536a:	ffffe097          	auipc	ra,0xffffe
    8000536e:	898080e7          	jalr	-1896(ra) # 80002c02 <argint>
  if(argfd(0, 0, &f) < 0)
    80005372:	fe840613          	addi	a2,s0,-24
    80005376:	4581                	li	a1,0
    80005378:	4501                	li	a0,0
    8000537a:	00000097          	auipc	ra,0x0
    8000537e:	d02080e7          	jalr	-766(ra) # 8000507c <argfd>
    80005382:	87aa                	mv	a5,a0
    return -1;
    80005384:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80005386:	0007cc63          	bltz	a5,8000539e <sys_write+0x50>
  return filewrite(f, p, n);
    8000538a:	fe442603          	lw	a2,-28(s0)
    8000538e:	fd843583          	ld	a1,-40(s0)
    80005392:	fe843503          	ld	a0,-24(s0)
    80005396:	fffff097          	auipc	ra,0xfffff
    8000539a:	4a8080e7          	jalr	1192(ra) # 8000483e <filewrite>
}
    8000539e:	70a2                	ld	ra,40(sp)
    800053a0:	7402                	ld	s0,32(sp)
    800053a2:	6145                	addi	sp,sp,48
    800053a4:	8082                	ret

00000000800053a6 <sys_close>:
{
    800053a6:	1101                	addi	sp,sp,-32
    800053a8:	ec06                	sd	ra,24(sp)
    800053aa:	e822                	sd	s0,16(sp)
    800053ac:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    800053ae:	fe040613          	addi	a2,s0,-32
    800053b2:	fec40593          	addi	a1,s0,-20
    800053b6:	4501                	li	a0,0
    800053b8:	00000097          	auipc	ra,0x0
    800053bc:	cc4080e7          	jalr	-828(ra) # 8000507c <argfd>
    return -1;
    800053c0:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    800053c2:	02054563          	bltz	a0,800053ec <sys_close+0x46>
  myproc()->ofile[fd] = 0;
    800053c6:	ffffc097          	auipc	ra,0xffffc
    800053ca:	5f6080e7          	jalr	1526(ra) # 800019bc <myproc>
    800053ce:	fec42783          	lw	a5,-20(s0)
    800053d2:	02278793          	addi	a5,a5,34
    800053d6:	078e                	slli	a5,a5,0x3
    800053d8:	97aa                	add	a5,a5,a0
    800053da:	0007b423          	sd	zero,8(a5)
  fileclose(f);
    800053de:	fe043503          	ld	a0,-32(s0)
    800053e2:	fffff097          	auipc	ra,0xfffff
    800053e6:	260080e7          	jalr	608(ra) # 80004642 <fileclose>
  return 0;
    800053ea:	4781                	li	a5,0
}
    800053ec:	853e                	mv	a0,a5
    800053ee:	60e2                	ld	ra,24(sp)
    800053f0:	6442                	ld	s0,16(sp)
    800053f2:	6105                	addi	sp,sp,32
    800053f4:	8082                	ret

00000000800053f6 <sys_fstat>:
{
    800053f6:	1101                	addi	sp,sp,-32
    800053f8:	ec06                	sd	ra,24(sp)
    800053fa:	e822                	sd	s0,16(sp)
    800053fc:	1000                	addi	s0,sp,32
  argaddr(1, &st);
    800053fe:	fe040593          	addi	a1,s0,-32
    80005402:	4505                	li	a0,1
    80005404:	ffffe097          	auipc	ra,0xffffe
    80005408:	81e080e7          	jalr	-2018(ra) # 80002c22 <argaddr>
  if(argfd(0, 0, &f) < 0)
    8000540c:	fe840613          	addi	a2,s0,-24
    80005410:	4581                	li	a1,0
    80005412:	4501                	li	a0,0
    80005414:	00000097          	auipc	ra,0x0
    80005418:	c68080e7          	jalr	-920(ra) # 8000507c <argfd>
    8000541c:	87aa                	mv	a5,a0
    return -1;
    8000541e:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80005420:	0007ca63          	bltz	a5,80005434 <sys_fstat+0x3e>
  return filestat(f, st);
    80005424:	fe043583          	ld	a1,-32(s0)
    80005428:	fe843503          	ld	a0,-24(s0)
    8000542c:	fffff097          	auipc	ra,0xfffff
    80005430:	2de080e7          	jalr	734(ra) # 8000470a <filestat>
}
    80005434:	60e2                	ld	ra,24(sp)
    80005436:	6442                	ld	s0,16(sp)
    80005438:	6105                	addi	sp,sp,32
    8000543a:	8082                	ret

000000008000543c <sys_link>:
{
    8000543c:	7169                	addi	sp,sp,-304
    8000543e:	f606                	sd	ra,296(sp)
    80005440:	f222                	sd	s0,288(sp)
    80005442:	ee26                	sd	s1,280(sp)
    80005444:	ea4a                	sd	s2,272(sp)
    80005446:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80005448:	08000613          	li	a2,128
    8000544c:	ed040593          	addi	a1,s0,-304
    80005450:	4501                	li	a0,0
    80005452:	ffffd097          	auipc	ra,0xffffd
    80005456:	7f0080e7          	jalr	2032(ra) # 80002c42 <argstr>
    return -1;
    8000545a:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000545c:	10054e63          	bltz	a0,80005578 <sys_link+0x13c>
    80005460:	08000613          	li	a2,128
    80005464:	f5040593          	addi	a1,s0,-176
    80005468:	4505                	li	a0,1
    8000546a:	ffffd097          	auipc	ra,0xffffd
    8000546e:	7d8080e7          	jalr	2008(ra) # 80002c42 <argstr>
    return -1;
    80005472:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80005474:	10054263          	bltz	a0,80005578 <sys_link+0x13c>
  begin_op();
    80005478:	fffff097          	auipc	ra,0xfffff
    8000547c:	cfe080e7          	jalr	-770(ra) # 80004176 <begin_op>
  if((ip = namei(old)) == 0){
    80005480:	ed040513          	addi	a0,s0,-304
    80005484:	fffff097          	auipc	ra,0xfffff
    80005488:	ad6080e7          	jalr	-1322(ra) # 80003f5a <namei>
    8000548c:	84aa                	mv	s1,a0
    8000548e:	c551                	beqz	a0,8000551a <sys_link+0xde>
  ilock(ip);
    80005490:	ffffe097          	auipc	ra,0xffffe
    80005494:	324080e7          	jalr	804(ra) # 800037b4 <ilock>
  if(ip->type == T_DIR){
    80005498:	04449703          	lh	a4,68(s1)
    8000549c:	4785                	li	a5,1
    8000549e:	08f70463          	beq	a4,a5,80005526 <sys_link+0xea>
  ip->nlink++;
    800054a2:	04a4d783          	lhu	a5,74(s1)
    800054a6:	2785                	addiw	a5,a5,1
    800054a8:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800054ac:	8526                	mv	a0,s1
    800054ae:	ffffe097          	auipc	ra,0xffffe
    800054b2:	23c080e7          	jalr	572(ra) # 800036ea <iupdate>
  iunlock(ip);
    800054b6:	8526                	mv	a0,s1
    800054b8:	ffffe097          	auipc	ra,0xffffe
    800054bc:	3be080e7          	jalr	958(ra) # 80003876 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    800054c0:	fd040593          	addi	a1,s0,-48
    800054c4:	f5040513          	addi	a0,s0,-176
    800054c8:	fffff097          	auipc	ra,0xfffff
    800054cc:	ab0080e7          	jalr	-1360(ra) # 80003f78 <nameiparent>
    800054d0:	892a                	mv	s2,a0
    800054d2:	c935                	beqz	a0,80005546 <sys_link+0x10a>
  ilock(dp);
    800054d4:	ffffe097          	auipc	ra,0xffffe
    800054d8:	2e0080e7          	jalr	736(ra) # 800037b4 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    800054dc:	00092703          	lw	a4,0(s2)
    800054e0:	409c                	lw	a5,0(s1)
    800054e2:	04f71d63          	bne	a4,a5,8000553c <sys_link+0x100>
    800054e6:	40d0                	lw	a2,4(s1)
    800054e8:	fd040593          	addi	a1,s0,-48
    800054ec:	854a                	mv	a0,s2
    800054ee:	fffff097          	auipc	ra,0xfffff
    800054f2:	9ba080e7          	jalr	-1606(ra) # 80003ea8 <dirlink>
    800054f6:	04054363          	bltz	a0,8000553c <sys_link+0x100>
  iunlockput(dp);
    800054fa:	854a                	mv	a0,s2
    800054fc:	ffffe097          	auipc	ra,0xffffe
    80005500:	51a080e7          	jalr	1306(ra) # 80003a16 <iunlockput>
  iput(ip);
    80005504:	8526                	mv	a0,s1
    80005506:	ffffe097          	auipc	ra,0xffffe
    8000550a:	468080e7          	jalr	1128(ra) # 8000396e <iput>
  end_op();
    8000550e:	fffff097          	auipc	ra,0xfffff
    80005512:	ce8080e7          	jalr	-792(ra) # 800041f6 <end_op>
  return 0;
    80005516:	4781                	li	a5,0
    80005518:	a085                	j	80005578 <sys_link+0x13c>
    end_op();
    8000551a:	fffff097          	auipc	ra,0xfffff
    8000551e:	cdc080e7          	jalr	-804(ra) # 800041f6 <end_op>
    return -1;
    80005522:	57fd                	li	a5,-1
    80005524:	a891                	j	80005578 <sys_link+0x13c>
    iunlockput(ip);
    80005526:	8526                	mv	a0,s1
    80005528:	ffffe097          	auipc	ra,0xffffe
    8000552c:	4ee080e7          	jalr	1262(ra) # 80003a16 <iunlockput>
    end_op();
    80005530:	fffff097          	auipc	ra,0xfffff
    80005534:	cc6080e7          	jalr	-826(ra) # 800041f6 <end_op>
    return -1;
    80005538:	57fd                	li	a5,-1
    8000553a:	a83d                	j	80005578 <sys_link+0x13c>
    iunlockput(dp);
    8000553c:	854a                	mv	a0,s2
    8000553e:	ffffe097          	auipc	ra,0xffffe
    80005542:	4d8080e7          	jalr	1240(ra) # 80003a16 <iunlockput>
  ilock(ip);
    80005546:	8526                	mv	a0,s1
    80005548:	ffffe097          	auipc	ra,0xffffe
    8000554c:	26c080e7          	jalr	620(ra) # 800037b4 <ilock>
  ip->nlink--;
    80005550:	04a4d783          	lhu	a5,74(s1)
    80005554:	37fd                	addiw	a5,a5,-1
    80005556:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    8000555a:	8526                	mv	a0,s1
    8000555c:	ffffe097          	auipc	ra,0xffffe
    80005560:	18e080e7          	jalr	398(ra) # 800036ea <iupdate>
  iunlockput(ip);
    80005564:	8526                	mv	a0,s1
    80005566:	ffffe097          	auipc	ra,0xffffe
    8000556a:	4b0080e7          	jalr	1200(ra) # 80003a16 <iunlockput>
  end_op();
    8000556e:	fffff097          	auipc	ra,0xfffff
    80005572:	c88080e7          	jalr	-888(ra) # 800041f6 <end_op>
  return -1;
    80005576:	57fd                	li	a5,-1
}
    80005578:	853e                	mv	a0,a5
    8000557a:	70b2                	ld	ra,296(sp)
    8000557c:	7412                	ld	s0,288(sp)
    8000557e:	64f2                	ld	s1,280(sp)
    80005580:	6952                	ld	s2,272(sp)
    80005582:	6155                	addi	sp,sp,304
    80005584:	8082                	ret

0000000080005586 <sys_unlink>:
{
    80005586:	7151                	addi	sp,sp,-240
    80005588:	f586                	sd	ra,232(sp)
    8000558a:	f1a2                	sd	s0,224(sp)
    8000558c:	eda6                	sd	s1,216(sp)
    8000558e:	e9ca                	sd	s2,208(sp)
    80005590:	e5ce                	sd	s3,200(sp)
    80005592:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80005594:	08000613          	li	a2,128
    80005598:	f3040593          	addi	a1,s0,-208
    8000559c:	4501                	li	a0,0
    8000559e:	ffffd097          	auipc	ra,0xffffd
    800055a2:	6a4080e7          	jalr	1700(ra) # 80002c42 <argstr>
    800055a6:	18054163          	bltz	a0,80005728 <sys_unlink+0x1a2>
  begin_op();
    800055aa:	fffff097          	auipc	ra,0xfffff
    800055ae:	bcc080e7          	jalr	-1076(ra) # 80004176 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    800055b2:	fb040593          	addi	a1,s0,-80
    800055b6:	f3040513          	addi	a0,s0,-208
    800055ba:	fffff097          	auipc	ra,0xfffff
    800055be:	9be080e7          	jalr	-1602(ra) # 80003f78 <nameiparent>
    800055c2:	84aa                	mv	s1,a0
    800055c4:	c979                	beqz	a0,8000569a <sys_unlink+0x114>
  ilock(dp);
    800055c6:	ffffe097          	auipc	ra,0xffffe
    800055ca:	1ee080e7          	jalr	494(ra) # 800037b4 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    800055ce:	00003597          	auipc	a1,0x3
    800055d2:	13258593          	addi	a1,a1,306 # 80008700 <syscalls+0x2a8>
    800055d6:	fb040513          	addi	a0,s0,-80
    800055da:	ffffe097          	auipc	ra,0xffffe
    800055de:	6a4080e7          	jalr	1700(ra) # 80003c7e <namecmp>
    800055e2:	14050a63          	beqz	a0,80005736 <sys_unlink+0x1b0>
    800055e6:	00003597          	auipc	a1,0x3
    800055ea:	12258593          	addi	a1,a1,290 # 80008708 <syscalls+0x2b0>
    800055ee:	fb040513          	addi	a0,s0,-80
    800055f2:	ffffe097          	auipc	ra,0xffffe
    800055f6:	68c080e7          	jalr	1676(ra) # 80003c7e <namecmp>
    800055fa:	12050e63          	beqz	a0,80005736 <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    800055fe:	f2c40613          	addi	a2,s0,-212
    80005602:	fb040593          	addi	a1,s0,-80
    80005606:	8526                	mv	a0,s1
    80005608:	ffffe097          	auipc	ra,0xffffe
    8000560c:	690080e7          	jalr	1680(ra) # 80003c98 <dirlookup>
    80005610:	892a                	mv	s2,a0
    80005612:	12050263          	beqz	a0,80005736 <sys_unlink+0x1b0>
  ilock(ip);
    80005616:	ffffe097          	auipc	ra,0xffffe
    8000561a:	19e080e7          	jalr	414(ra) # 800037b4 <ilock>
  if(ip->nlink < 1)
    8000561e:	04a91783          	lh	a5,74(s2)
    80005622:	08f05263          	blez	a5,800056a6 <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80005626:	04491703          	lh	a4,68(s2)
    8000562a:	4785                	li	a5,1
    8000562c:	08f70563          	beq	a4,a5,800056b6 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    80005630:	4641                	li	a2,16
    80005632:	4581                	li	a1,0
    80005634:	fc040513          	addi	a0,s0,-64
    80005638:	ffffb097          	auipc	ra,0xffffb
    8000563c:	69a080e7          	jalr	1690(ra) # 80000cd2 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005640:	4741                	li	a4,16
    80005642:	f2c42683          	lw	a3,-212(s0)
    80005646:	fc040613          	addi	a2,s0,-64
    8000564a:	4581                	li	a1,0
    8000564c:	8526                	mv	a0,s1
    8000564e:	ffffe097          	auipc	ra,0xffffe
    80005652:	512080e7          	jalr	1298(ra) # 80003b60 <writei>
    80005656:	47c1                	li	a5,16
    80005658:	0af51563          	bne	a0,a5,80005702 <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    8000565c:	04491703          	lh	a4,68(s2)
    80005660:	4785                	li	a5,1
    80005662:	0af70863          	beq	a4,a5,80005712 <sys_unlink+0x18c>
  iunlockput(dp);
    80005666:	8526                	mv	a0,s1
    80005668:	ffffe097          	auipc	ra,0xffffe
    8000566c:	3ae080e7          	jalr	942(ra) # 80003a16 <iunlockput>
  ip->nlink--;
    80005670:	04a95783          	lhu	a5,74(s2)
    80005674:	37fd                	addiw	a5,a5,-1
    80005676:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    8000567a:	854a                	mv	a0,s2
    8000567c:	ffffe097          	auipc	ra,0xffffe
    80005680:	06e080e7          	jalr	110(ra) # 800036ea <iupdate>
  iunlockput(ip);
    80005684:	854a                	mv	a0,s2
    80005686:	ffffe097          	auipc	ra,0xffffe
    8000568a:	390080e7          	jalr	912(ra) # 80003a16 <iunlockput>
  end_op();
    8000568e:	fffff097          	auipc	ra,0xfffff
    80005692:	b68080e7          	jalr	-1176(ra) # 800041f6 <end_op>
  return 0;
    80005696:	4501                	li	a0,0
    80005698:	a84d                	j	8000574a <sys_unlink+0x1c4>
    end_op();
    8000569a:	fffff097          	auipc	ra,0xfffff
    8000569e:	b5c080e7          	jalr	-1188(ra) # 800041f6 <end_op>
    return -1;
    800056a2:	557d                	li	a0,-1
    800056a4:	a05d                	j	8000574a <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    800056a6:	00003517          	auipc	a0,0x3
    800056aa:	06a50513          	addi	a0,a0,106 # 80008710 <syscalls+0x2b8>
    800056ae:	ffffb097          	auipc	ra,0xffffb
    800056b2:	e90080e7          	jalr	-368(ra) # 8000053e <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    800056b6:	04c92703          	lw	a4,76(s2)
    800056ba:	02000793          	li	a5,32
    800056be:	f6e7f9e3          	bgeu	a5,a4,80005630 <sys_unlink+0xaa>
    800056c2:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800056c6:	4741                	li	a4,16
    800056c8:	86ce                	mv	a3,s3
    800056ca:	f1840613          	addi	a2,s0,-232
    800056ce:	4581                	li	a1,0
    800056d0:	854a                	mv	a0,s2
    800056d2:	ffffe097          	auipc	ra,0xffffe
    800056d6:	396080e7          	jalr	918(ra) # 80003a68 <readi>
    800056da:	47c1                	li	a5,16
    800056dc:	00f51b63          	bne	a0,a5,800056f2 <sys_unlink+0x16c>
    if(de.inum != 0)
    800056e0:	f1845783          	lhu	a5,-232(s0)
    800056e4:	e7a1                	bnez	a5,8000572c <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    800056e6:	29c1                	addiw	s3,s3,16
    800056e8:	04c92783          	lw	a5,76(s2)
    800056ec:	fcf9ede3          	bltu	s3,a5,800056c6 <sys_unlink+0x140>
    800056f0:	b781                	j	80005630 <sys_unlink+0xaa>
      panic("isdirempty: readi");
    800056f2:	00003517          	auipc	a0,0x3
    800056f6:	03650513          	addi	a0,a0,54 # 80008728 <syscalls+0x2d0>
    800056fa:	ffffb097          	auipc	ra,0xffffb
    800056fe:	e44080e7          	jalr	-444(ra) # 8000053e <panic>
    panic("unlink: writei");
    80005702:	00003517          	auipc	a0,0x3
    80005706:	03e50513          	addi	a0,a0,62 # 80008740 <syscalls+0x2e8>
    8000570a:	ffffb097          	auipc	ra,0xffffb
    8000570e:	e34080e7          	jalr	-460(ra) # 8000053e <panic>
    dp->nlink--;
    80005712:	04a4d783          	lhu	a5,74(s1)
    80005716:	37fd                	addiw	a5,a5,-1
    80005718:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    8000571c:	8526                	mv	a0,s1
    8000571e:	ffffe097          	auipc	ra,0xffffe
    80005722:	fcc080e7          	jalr	-52(ra) # 800036ea <iupdate>
    80005726:	b781                	j	80005666 <sys_unlink+0xe0>
    return -1;
    80005728:	557d                	li	a0,-1
    8000572a:	a005                	j	8000574a <sys_unlink+0x1c4>
    iunlockput(ip);
    8000572c:	854a                	mv	a0,s2
    8000572e:	ffffe097          	auipc	ra,0xffffe
    80005732:	2e8080e7          	jalr	744(ra) # 80003a16 <iunlockput>
  iunlockput(dp);
    80005736:	8526                	mv	a0,s1
    80005738:	ffffe097          	auipc	ra,0xffffe
    8000573c:	2de080e7          	jalr	734(ra) # 80003a16 <iunlockput>
  end_op();
    80005740:	fffff097          	auipc	ra,0xfffff
    80005744:	ab6080e7          	jalr	-1354(ra) # 800041f6 <end_op>
  return -1;
    80005748:	557d                	li	a0,-1
}
    8000574a:	70ae                	ld	ra,232(sp)
    8000574c:	740e                	ld	s0,224(sp)
    8000574e:	64ee                	ld	s1,216(sp)
    80005750:	694e                	ld	s2,208(sp)
    80005752:	69ae                	ld	s3,200(sp)
    80005754:	616d                	addi	sp,sp,240
    80005756:	8082                	ret

0000000080005758 <sys_open>:

uint64
sys_open(void)
{
    80005758:	7131                	addi	sp,sp,-192
    8000575a:	fd06                	sd	ra,184(sp)
    8000575c:	f922                	sd	s0,176(sp)
    8000575e:	f526                	sd	s1,168(sp)
    80005760:	f14a                	sd	s2,160(sp)
    80005762:	ed4e                	sd	s3,152(sp)
    80005764:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    80005766:	f4c40593          	addi	a1,s0,-180
    8000576a:	4505                	li	a0,1
    8000576c:	ffffd097          	auipc	ra,0xffffd
    80005770:	496080e7          	jalr	1174(ra) # 80002c02 <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    80005774:	08000613          	li	a2,128
    80005778:	f5040593          	addi	a1,s0,-176
    8000577c:	4501                	li	a0,0
    8000577e:	ffffd097          	auipc	ra,0xffffd
    80005782:	4c4080e7          	jalr	1220(ra) # 80002c42 <argstr>
    80005786:	87aa                	mv	a5,a0
    return -1;
    80005788:	557d                	li	a0,-1
  if((n = argstr(0, path, MAXPATH)) < 0)
    8000578a:	0a07c963          	bltz	a5,8000583c <sys_open+0xe4>

  begin_op();
    8000578e:	fffff097          	auipc	ra,0xfffff
    80005792:	9e8080e7          	jalr	-1560(ra) # 80004176 <begin_op>

  if(omode & O_CREATE){
    80005796:	f4c42783          	lw	a5,-180(s0)
    8000579a:	2007f793          	andi	a5,a5,512
    8000579e:	cfc5                	beqz	a5,80005856 <sys_open+0xfe>
    ip = create(path, T_FILE, 0, 0);
    800057a0:	4681                	li	a3,0
    800057a2:	4601                	li	a2,0
    800057a4:	4589                	li	a1,2
    800057a6:	f5040513          	addi	a0,s0,-176
    800057aa:	00000097          	auipc	ra,0x0
    800057ae:	974080e7          	jalr	-1676(ra) # 8000511e <create>
    800057b2:	84aa                	mv	s1,a0
    if(ip == 0){
    800057b4:	c959                	beqz	a0,8000584a <sys_open+0xf2>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    800057b6:	04449703          	lh	a4,68(s1)
    800057ba:	478d                	li	a5,3
    800057bc:	00f71763          	bne	a4,a5,800057ca <sys_open+0x72>
    800057c0:	0464d703          	lhu	a4,70(s1)
    800057c4:	47a5                	li	a5,9
    800057c6:	0ce7ed63          	bltu	a5,a4,800058a0 <sys_open+0x148>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    800057ca:	fffff097          	auipc	ra,0xfffff
    800057ce:	dbc080e7          	jalr	-580(ra) # 80004586 <filealloc>
    800057d2:	89aa                	mv	s3,a0
    800057d4:	10050363          	beqz	a0,800058da <sys_open+0x182>
    800057d8:	00000097          	auipc	ra,0x0
    800057dc:	904080e7          	jalr	-1788(ra) # 800050dc <fdalloc>
    800057e0:	892a                	mv	s2,a0
    800057e2:	0e054763          	bltz	a0,800058d0 <sys_open+0x178>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    800057e6:	04449703          	lh	a4,68(s1)
    800057ea:	478d                	li	a5,3
    800057ec:	0cf70563          	beq	a4,a5,800058b6 <sys_open+0x15e>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    800057f0:	4789                	li	a5,2
    800057f2:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    800057f6:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    800057fa:	0099bc23          	sd	s1,24(s3)
  f->readable = !(omode & O_WRONLY);
    800057fe:	f4c42783          	lw	a5,-180(s0)
    80005802:	0017c713          	xori	a4,a5,1
    80005806:	8b05                	andi	a4,a4,1
    80005808:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    8000580c:	0037f713          	andi	a4,a5,3
    80005810:	00e03733          	snez	a4,a4
    80005814:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80005818:	4007f793          	andi	a5,a5,1024
    8000581c:	c791                	beqz	a5,80005828 <sys_open+0xd0>
    8000581e:	04449703          	lh	a4,68(s1)
    80005822:	4789                	li	a5,2
    80005824:	0af70063          	beq	a4,a5,800058c4 <sys_open+0x16c>
    itrunc(ip);
  }

  iunlock(ip);
    80005828:	8526                	mv	a0,s1
    8000582a:	ffffe097          	auipc	ra,0xffffe
    8000582e:	04c080e7          	jalr	76(ra) # 80003876 <iunlock>
  end_op();
    80005832:	fffff097          	auipc	ra,0xfffff
    80005836:	9c4080e7          	jalr	-1596(ra) # 800041f6 <end_op>

  return fd;
    8000583a:	854a                	mv	a0,s2
}
    8000583c:	70ea                	ld	ra,184(sp)
    8000583e:	744a                	ld	s0,176(sp)
    80005840:	74aa                	ld	s1,168(sp)
    80005842:	790a                	ld	s2,160(sp)
    80005844:	69ea                	ld	s3,152(sp)
    80005846:	6129                	addi	sp,sp,192
    80005848:	8082                	ret
      end_op();
    8000584a:	fffff097          	auipc	ra,0xfffff
    8000584e:	9ac080e7          	jalr	-1620(ra) # 800041f6 <end_op>
      return -1;
    80005852:	557d                	li	a0,-1
    80005854:	b7e5                	j	8000583c <sys_open+0xe4>
    if((ip = namei(path)) == 0){
    80005856:	f5040513          	addi	a0,s0,-176
    8000585a:	ffffe097          	auipc	ra,0xffffe
    8000585e:	700080e7          	jalr	1792(ra) # 80003f5a <namei>
    80005862:	84aa                	mv	s1,a0
    80005864:	c905                	beqz	a0,80005894 <sys_open+0x13c>
    ilock(ip);
    80005866:	ffffe097          	auipc	ra,0xffffe
    8000586a:	f4e080e7          	jalr	-178(ra) # 800037b4 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    8000586e:	04449703          	lh	a4,68(s1)
    80005872:	4785                	li	a5,1
    80005874:	f4f711e3          	bne	a4,a5,800057b6 <sys_open+0x5e>
    80005878:	f4c42783          	lw	a5,-180(s0)
    8000587c:	d7b9                	beqz	a5,800057ca <sys_open+0x72>
      iunlockput(ip);
    8000587e:	8526                	mv	a0,s1
    80005880:	ffffe097          	auipc	ra,0xffffe
    80005884:	196080e7          	jalr	406(ra) # 80003a16 <iunlockput>
      end_op();
    80005888:	fffff097          	auipc	ra,0xfffff
    8000588c:	96e080e7          	jalr	-1682(ra) # 800041f6 <end_op>
      return -1;
    80005890:	557d                	li	a0,-1
    80005892:	b76d                	j	8000583c <sys_open+0xe4>
      end_op();
    80005894:	fffff097          	auipc	ra,0xfffff
    80005898:	962080e7          	jalr	-1694(ra) # 800041f6 <end_op>
      return -1;
    8000589c:	557d                	li	a0,-1
    8000589e:	bf79                	j	8000583c <sys_open+0xe4>
    iunlockput(ip);
    800058a0:	8526                	mv	a0,s1
    800058a2:	ffffe097          	auipc	ra,0xffffe
    800058a6:	174080e7          	jalr	372(ra) # 80003a16 <iunlockput>
    end_op();
    800058aa:	fffff097          	auipc	ra,0xfffff
    800058ae:	94c080e7          	jalr	-1716(ra) # 800041f6 <end_op>
    return -1;
    800058b2:	557d                	li	a0,-1
    800058b4:	b761                	j	8000583c <sys_open+0xe4>
    f->type = FD_DEVICE;
    800058b6:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    800058ba:	04649783          	lh	a5,70(s1)
    800058be:	02f99223          	sh	a5,36(s3)
    800058c2:	bf25                	j	800057fa <sys_open+0xa2>
    itrunc(ip);
    800058c4:	8526                	mv	a0,s1
    800058c6:	ffffe097          	auipc	ra,0xffffe
    800058ca:	ffc080e7          	jalr	-4(ra) # 800038c2 <itrunc>
    800058ce:	bfa9                	j	80005828 <sys_open+0xd0>
      fileclose(f);
    800058d0:	854e                	mv	a0,s3
    800058d2:	fffff097          	auipc	ra,0xfffff
    800058d6:	d70080e7          	jalr	-656(ra) # 80004642 <fileclose>
    iunlockput(ip);
    800058da:	8526                	mv	a0,s1
    800058dc:	ffffe097          	auipc	ra,0xffffe
    800058e0:	13a080e7          	jalr	314(ra) # 80003a16 <iunlockput>
    end_op();
    800058e4:	fffff097          	auipc	ra,0xfffff
    800058e8:	912080e7          	jalr	-1774(ra) # 800041f6 <end_op>
    return -1;
    800058ec:	557d                	li	a0,-1
    800058ee:	b7b9                	j	8000583c <sys_open+0xe4>

00000000800058f0 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    800058f0:	7175                	addi	sp,sp,-144
    800058f2:	e506                	sd	ra,136(sp)
    800058f4:	e122                	sd	s0,128(sp)
    800058f6:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    800058f8:	fffff097          	auipc	ra,0xfffff
    800058fc:	87e080e7          	jalr	-1922(ra) # 80004176 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80005900:	08000613          	li	a2,128
    80005904:	f7040593          	addi	a1,s0,-144
    80005908:	4501                	li	a0,0
    8000590a:	ffffd097          	auipc	ra,0xffffd
    8000590e:	338080e7          	jalr	824(ra) # 80002c42 <argstr>
    80005912:	02054963          	bltz	a0,80005944 <sys_mkdir+0x54>
    80005916:	4681                	li	a3,0
    80005918:	4601                	li	a2,0
    8000591a:	4585                	li	a1,1
    8000591c:	f7040513          	addi	a0,s0,-144
    80005920:	fffff097          	auipc	ra,0xfffff
    80005924:	7fe080e7          	jalr	2046(ra) # 8000511e <create>
    80005928:	cd11                	beqz	a0,80005944 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    8000592a:	ffffe097          	auipc	ra,0xffffe
    8000592e:	0ec080e7          	jalr	236(ra) # 80003a16 <iunlockput>
  end_op();
    80005932:	fffff097          	auipc	ra,0xfffff
    80005936:	8c4080e7          	jalr	-1852(ra) # 800041f6 <end_op>
  return 0;
    8000593a:	4501                	li	a0,0
}
    8000593c:	60aa                	ld	ra,136(sp)
    8000593e:	640a                	ld	s0,128(sp)
    80005940:	6149                	addi	sp,sp,144
    80005942:	8082                	ret
    end_op();
    80005944:	fffff097          	auipc	ra,0xfffff
    80005948:	8b2080e7          	jalr	-1870(ra) # 800041f6 <end_op>
    return -1;
    8000594c:	557d                	li	a0,-1
    8000594e:	b7fd                	j	8000593c <sys_mkdir+0x4c>

0000000080005950 <sys_mknod>:

uint64
sys_mknod(void)
{
    80005950:	7135                	addi	sp,sp,-160
    80005952:	ed06                	sd	ra,152(sp)
    80005954:	e922                	sd	s0,144(sp)
    80005956:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80005958:	fffff097          	auipc	ra,0xfffff
    8000595c:	81e080e7          	jalr	-2018(ra) # 80004176 <begin_op>
  argint(1, &major);
    80005960:	f6c40593          	addi	a1,s0,-148
    80005964:	4505                	li	a0,1
    80005966:	ffffd097          	auipc	ra,0xffffd
    8000596a:	29c080e7          	jalr	668(ra) # 80002c02 <argint>
  argint(2, &minor);
    8000596e:	f6840593          	addi	a1,s0,-152
    80005972:	4509                	li	a0,2
    80005974:	ffffd097          	auipc	ra,0xffffd
    80005978:	28e080e7          	jalr	654(ra) # 80002c02 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    8000597c:	08000613          	li	a2,128
    80005980:	f7040593          	addi	a1,s0,-144
    80005984:	4501                	li	a0,0
    80005986:	ffffd097          	auipc	ra,0xffffd
    8000598a:	2bc080e7          	jalr	700(ra) # 80002c42 <argstr>
    8000598e:	02054b63          	bltz	a0,800059c4 <sys_mknod+0x74>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80005992:	f6841683          	lh	a3,-152(s0)
    80005996:	f6c41603          	lh	a2,-148(s0)
    8000599a:	458d                	li	a1,3
    8000599c:	f7040513          	addi	a0,s0,-144
    800059a0:	fffff097          	auipc	ra,0xfffff
    800059a4:	77e080e7          	jalr	1918(ra) # 8000511e <create>
  if((argstr(0, path, MAXPATH)) < 0 ||
    800059a8:	cd11                	beqz	a0,800059c4 <sys_mknod+0x74>
    end_op();
    return -1;
  }
  iunlockput(ip);
    800059aa:	ffffe097          	auipc	ra,0xffffe
    800059ae:	06c080e7          	jalr	108(ra) # 80003a16 <iunlockput>
  end_op();
    800059b2:	fffff097          	auipc	ra,0xfffff
    800059b6:	844080e7          	jalr	-1980(ra) # 800041f6 <end_op>
  return 0;
    800059ba:	4501                	li	a0,0
}
    800059bc:	60ea                	ld	ra,152(sp)
    800059be:	644a                	ld	s0,144(sp)
    800059c0:	610d                	addi	sp,sp,160
    800059c2:	8082                	ret
    end_op();
    800059c4:	fffff097          	auipc	ra,0xfffff
    800059c8:	832080e7          	jalr	-1998(ra) # 800041f6 <end_op>
    return -1;
    800059cc:	557d                	li	a0,-1
    800059ce:	b7fd                	j	800059bc <sys_mknod+0x6c>

00000000800059d0 <sys_chdir>:

uint64
sys_chdir(void)
{
    800059d0:	7135                	addi	sp,sp,-160
    800059d2:	ed06                	sd	ra,152(sp)
    800059d4:	e922                	sd	s0,144(sp)
    800059d6:	e526                	sd	s1,136(sp)
    800059d8:	e14a                	sd	s2,128(sp)
    800059da:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    800059dc:	ffffc097          	auipc	ra,0xffffc
    800059e0:	fe0080e7          	jalr	-32(ra) # 800019bc <myproc>
    800059e4:	892a                	mv	s2,a0
  
  begin_op();
    800059e6:	ffffe097          	auipc	ra,0xffffe
    800059ea:	790080e7          	jalr	1936(ra) # 80004176 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    800059ee:	08000613          	li	a2,128
    800059f2:	f6040593          	addi	a1,s0,-160
    800059f6:	4501                	li	a0,0
    800059f8:	ffffd097          	auipc	ra,0xffffd
    800059fc:	24a080e7          	jalr	586(ra) # 80002c42 <argstr>
    80005a00:	04054b63          	bltz	a0,80005a56 <sys_chdir+0x86>
    80005a04:	f6040513          	addi	a0,s0,-160
    80005a08:	ffffe097          	auipc	ra,0xffffe
    80005a0c:	552080e7          	jalr	1362(ra) # 80003f5a <namei>
    80005a10:	84aa                	mv	s1,a0
    80005a12:	c131                	beqz	a0,80005a56 <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80005a14:	ffffe097          	auipc	ra,0xffffe
    80005a18:	da0080e7          	jalr	-608(ra) # 800037b4 <ilock>
  if(ip->type != T_DIR){
    80005a1c:	04449703          	lh	a4,68(s1)
    80005a20:	4785                	li	a5,1
    80005a22:	04f71063          	bne	a4,a5,80005a62 <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80005a26:	8526                	mv	a0,s1
    80005a28:	ffffe097          	auipc	ra,0xffffe
    80005a2c:	e4e080e7          	jalr	-434(ra) # 80003876 <iunlock>
  iput(p->cwd);
    80005a30:	19893503          	ld	a0,408(s2)
    80005a34:	ffffe097          	auipc	ra,0xffffe
    80005a38:	f3a080e7          	jalr	-198(ra) # 8000396e <iput>
  end_op();
    80005a3c:	ffffe097          	auipc	ra,0xffffe
    80005a40:	7ba080e7          	jalr	1978(ra) # 800041f6 <end_op>
  p->cwd = ip;
    80005a44:	18993c23          	sd	s1,408(s2)
  return 0;
    80005a48:	4501                	li	a0,0
}
    80005a4a:	60ea                	ld	ra,152(sp)
    80005a4c:	644a                	ld	s0,144(sp)
    80005a4e:	64aa                	ld	s1,136(sp)
    80005a50:	690a                	ld	s2,128(sp)
    80005a52:	610d                	addi	sp,sp,160
    80005a54:	8082                	ret
    end_op();
    80005a56:	ffffe097          	auipc	ra,0xffffe
    80005a5a:	7a0080e7          	jalr	1952(ra) # 800041f6 <end_op>
    return -1;
    80005a5e:	557d                	li	a0,-1
    80005a60:	b7ed                	j	80005a4a <sys_chdir+0x7a>
    iunlockput(ip);
    80005a62:	8526                	mv	a0,s1
    80005a64:	ffffe097          	auipc	ra,0xffffe
    80005a68:	fb2080e7          	jalr	-78(ra) # 80003a16 <iunlockput>
    end_op();
    80005a6c:	ffffe097          	auipc	ra,0xffffe
    80005a70:	78a080e7          	jalr	1930(ra) # 800041f6 <end_op>
    return -1;
    80005a74:	557d                	li	a0,-1
    80005a76:	bfd1                	j	80005a4a <sys_chdir+0x7a>

0000000080005a78 <sys_exec>:

uint64
sys_exec(void)
{
    80005a78:	7145                	addi	sp,sp,-464
    80005a7a:	e786                	sd	ra,456(sp)
    80005a7c:	e3a2                	sd	s0,448(sp)
    80005a7e:	ff26                	sd	s1,440(sp)
    80005a80:	fb4a                	sd	s2,432(sp)
    80005a82:	f74e                	sd	s3,424(sp)
    80005a84:	f352                	sd	s4,416(sp)
    80005a86:	ef56                	sd	s5,408(sp)
    80005a88:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    80005a8a:	e3840593          	addi	a1,s0,-456
    80005a8e:	4505                	li	a0,1
    80005a90:	ffffd097          	auipc	ra,0xffffd
    80005a94:	192080e7          	jalr	402(ra) # 80002c22 <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    80005a98:	08000613          	li	a2,128
    80005a9c:	f4040593          	addi	a1,s0,-192
    80005aa0:	4501                	li	a0,0
    80005aa2:	ffffd097          	auipc	ra,0xffffd
    80005aa6:	1a0080e7          	jalr	416(ra) # 80002c42 <argstr>
    80005aaa:	87aa                	mv	a5,a0
    return -1;
    80005aac:	557d                	li	a0,-1
  if(argstr(0, path, MAXPATH) < 0) {
    80005aae:	0c07c263          	bltz	a5,80005b72 <sys_exec+0xfa>
  }
  memset(argv, 0, sizeof(argv));
    80005ab2:	10000613          	li	a2,256
    80005ab6:	4581                	li	a1,0
    80005ab8:	e4040513          	addi	a0,s0,-448
    80005abc:	ffffb097          	auipc	ra,0xffffb
    80005ac0:	216080e7          	jalr	534(ra) # 80000cd2 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80005ac4:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    80005ac8:	89a6                	mv	s3,s1
    80005aca:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    80005acc:	02000a13          	li	s4,32
    80005ad0:	00090a9b          	sext.w	s5,s2
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80005ad4:	00391793          	slli	a5,s2,0x3
    80005ad8:	e3040593          	addi	a1,s0,-464
    80005adc:	e3843503          	ld	a0,-456(s0)
    80005ae0:	953e                	add	a0,a0,a5
    80005ae2:	ffffd097          	auipc	ra,0xffffd
    80005ae6:	082080e7          	jalr	130(ra) # 80002b64 <fetchaddr>
    80005aea:	02054a63          	bltz	a0,80005b1e <sys_exec+0xa6>
      goto bad;
    }
    if(uarg == 0){
    80005aee:	e3043783          	ld	a5,-464(s0)
    80005af2:	c3b9                	beqz	a5,80005b38 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80005af4:	ffffb097          	auipc	ra,0xffffb
    80005af8:	ff2080e7          	jalr	-14(ra) # 80000ae6 <kalloc>
    80005afc:	85aa                	mv	a1,a0
    80005afe:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80005b02:	cd11                	beqz	a0,80005b1e <sys_exec+0xa6>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80005b04:	6605                	lui	a2,0x1
    80005b06:	e3043503          	ld	a0,-464(s0)
    80005b0a:	ffffd097          	auipc	ra,0xffffd
    80005b0e:	0ac080e7          	jalr	172(ra) # 80002bb6 <fetchstr>
    80005b12:	00054663          	bltz	a0,80005b1e <sys_exec+0xa6>
    if(i >= NELEM(argv)){
    80005b16:	0905                	addi	s2,s2,1
    80005b18:	09a1                	addi	s3,s3,8
    80005b1a:	fb491be3          	bne	s2,s4,80005ad0 <sys_exec+0x58>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005b1e:	10048913          	addi	s2,s1,256
    80005b22:	6088                	ld	a0,0(s1)
    80005b24:	c531                	beqz	a0,80005b70 <sys_exec+0xf8>
    kfree(argv[i]);
    80005b26:	ffffb097          	auipc	ra,0xffffb
    80005b2a:	ec4080e7          	jalr	-316(ra) # 800009ea <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005b2e:	04a1                	addi	s1,s1,8
    80005b30:	ff2499e3          	bne	s1,s2,80005b22 <sys_exec+0xaa>
  return -1;
    80005b34:	557d                	li	a0,-1
    80005b36:	a835                	j	80005b72 <sys_exec+0xfa>
      argv[i] = 0;
    80005b38:	0a8e                	slli	s5,s5,0x3
    80005b3a:	fc040793          	addi	a5,s0,-64
    80005b3e:	9abe                	add	s5,s5,a5
    80005b40:	e80ab023          	sd	zero,-384(s5)
  int ret = exec(path, argv);
    80005b44:	e4040593          	addi	a1,s0,-448
    80005b48:	f4040513          	addi	a0,s0,-192
    80005b4c:	fffff097          	auipc	ra,0xfffff
    80005b50:	170080e7          	jalr	368(ra) # 80004cbc <exec>
    80005b54:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005b56:	10048993          	addi	s3,s1,256
    80005b5a:	6088                	ld	a0,0(s1)
    80005b5c:	c901                	beqz	a0,80005b6c <sys_exec+0xf4>
    kfree(argv[i]);
    80005b5e:	ffffb097          	auipc	ra,0xffffb
    80005b62:	e8c080e7          	jalr	-372(ra) # 800009ea <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005b66:	04a1                	addi	s1,s1,8
    80005b68:	ff3499e3          	bne	s1,s3,80005b5a <sys_exec+0xe2>
  return ret;
    80005b6c:	854a                	mv	a0,s2
    80005b6e:	a011                	j	80005b72 <sys_exec+0xfa>
  return -1;
    80005b70:	557d                	li	a0,-1
}
    80005b72:	60be                	ld	ra,456(sp)
    80005b74:	641e                	ld	s0,448(sp)
    80005b76:	74fa                	ld	s1,440(sp)
    80005b78:	795a                	ld	s2,432(sp)
    80005b7a:	79ba                	ld	s3,424(sp)
    80005b7c:	7a1a                	ld	s4,416(sp)
    80005b7e:	6afa                	ld	s5,408(sp)
    80005b80:	6179                	addi	sp,sp,464
    80005b82:	8082                	ret

0000000080005b84 <sys_pipe>:

uint64
sys_pipe(void)
{
    80005b84:	7139                	addi	sp,sp,-64
    80005b86:	fc06                	sd	ra,56(sp)
    80005b88:	f822                	sd	s0,48(sp)
    80005b8a:	f426                	sd	s1,40(sp)
    80005b8c:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80005b8e:	ffffc097          	auipc	ra,0xffffc
    80005b92:	e2e080e7          	jalr	-466(ra) # 800019bc <myproc>
    80005b96:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    80005b98:	fd840593          	addi	a1,s0,-40
    80005b9c:	4501                	li	a0,0
    80005b9e:	ffffd097          	auipc	ra,0xffffd
    80005ba2:	084080e7          	jalr	132(ra) # 80002c22 <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    80005ba6:	fc840593          	addi	a1,s0,-56
    80005baa:	fd040513          	addi	a0,s0,-48
    80005bae:	fffff097          	auipc	ra,0xfffff
    80005bb2:	dc4080e7          	jalr	-572(ra) # 80004972 <pipealloc>
    return -1;
    80005bb6:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80005bb8:	0c054763          	bltz	a0,80005c86 <sys_pipe+0x102>
  fd0 = -1;
    80005bbc:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80005bc0:	fd043503          	ld	a0,-48(s0)
    80005bc4:	fffff097          	auipc	ra,0xfffff
    80005bc8:	518080e7          	jalr	1304(ra) # 800050dc <fdalloc>
    80005bcc:	fca42223          	sw	a0,-60(s0)
    80005bd0:	08054e63          	bltz	a0,80005c6c <sys_pipe+0xe8>
    80005bd4:	fc843503          	ld	a0,-56(s0)
    80005bd8:	fffff097          	auipc	ra,0xfffff
    80005bdc:	504080e7          	jalr	1284(ra) # 800050dc <fdalloc>
    80005be0:	fca42023          	sw	a0,-64(s0)
    80005be4:	06054a63          	bltz	a0,80005c58 <sys_pipe+0xd4>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005be8:	4691                	li	a3,4
    80005bea:	fc440613          	addi	a2,s0,-60
    80005bee:	fd843583          	ld	a1,-40(s0)
    80005bf2:	6cc8                	ld	a0,152(s1)
    80005bf4:	ffffc097          	auipc	ra,0xffffc
    80005bf8:	a76080e7          	jalr	-1418(ra) # 8000166a <copyout>
    80005bfc:	02054063          	bltz	a0,80005c1c <sys_pipe+0x98>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80005c00:	4691                	li	a3,4
    80005c02:	fc040613          	addi	a2,s0,-64
    80005c06:	fd843583          	ld	a1,-40(s0)
    80005c0a:	0591                	addi	a1,a1,4
    80005c0c:	6cc8                	ld	a0,152(s1)
    80005c0e:	ffffc097          	auipc	ra,0xffffc
    80005c12:	a5c080e7          	jalr	-1444(ra) # 8000166a <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80005c16:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005c18:	06055763          	bgez	a0,80005c86 <sys_pipe+0x102>
    p->ofile[fd0] = 0;
    80005c1c:	fc442783          	lw	a5,-60(s0)
    80005c20:	02278793          	addi	a5,a5,34
    80005c24:	078e                	slli	a5,a5,0x3
    80005c26:	97a6                	add	a5,a5,s1
    80005c28:	0007b423          	sd	zero,8(a5)
    p->ofile[fd1] = 0;
    80005c2c:	fc042503          	lw	a0,-64(s0)
    80005c30:	02250513          	addi	a0,a0,34
    80005c34:	050e                	slli	a0,a0,0x3
    80005c36:	94aa                	add	s1,s1,a0
    80005c38:	0004b423          	sd	zero,8(s1)
    fileclose(rf);
    80005c3c:	fd043503          	ld	a0,-48(s0)
    80005c40:	fffff097          	auipc	ra,0xfffff
    80005c44:	a02080e7          	jalr	-1534(ra) # 80004642 <fileclose>
    fileclose(wf);
    80005c48:	fc843503          	ld	a0,-56(s0)
    80005c4c:	fffff097          	auipc	ra,0xfffff
    80005c50:	9f6080e7          	jalr	-1546(ra) # 80004642 <fileclose>
    return -1;
    80005c54:	57fd                	li	a5,-1
    80005c56:	a805                	j	80005c86 <sys_pipe+0x102>
    if(fd0 >= 0)
    80005c58:	fc442783          	lw	a5,-60(s0)
    80005c5c:	0007c863          	bltz	a5,80005c6c <sys_pipe+0xe8>
      p->ofile[fd0] = 0;
    80005c60:	02278793          	addi	a5,a5,34
    80005c64:	078e                	slli	a5,a5,0x3
    80005c66:	94be                	add	s1,s1,a5
    80005c68:	0004b423          	sd	zero,8(s1)
    fileclose(rf);
    80005c6c:	fd043503          	ld	a0,-48(s0)
    80005c70:	fffff097          	auipc	ra,0xfffff
    80005c74:	9d2080e7          	jalr	-1582(ra) # 80004642 <fileclose>
    fileclose(wf);
    80005c78:	fc843503          	ld	a0,-56(s0)
    80005c7c:	fffff097          	auipc	ra,0xfffff
    80005c80:	9c6080e7          	jalr	-1594(ra) # 80004642 <fileclose>
    return -1;
    80005c84:	57fd                	li	a5,-1
}
    80005c86:	853e                	mv	a0,a5
    80005c88:	70e2                	ld	ra,56(sp)
    80005c8a:	7442                	ld	s0,48(sp)
    80005c8c:	74a2                	ld	s1,40(sp)
    80005c8e:	6121                	addi	sp,sp,64
    80005c90:	8082                	ret

0000000080005c92 <sys_set_ps_priority>:

uint64
sys_set_ps_priority(int n)
{
  if ((n>=1) & (n<=10)){
    80005c92:	fff5071b          	addiw	a4,a0,-1
    80005c96:	47a5                	li	a5,9
    80005c98:	00e7f463          	bgeu	a5,a4,80005ca0 <sys_set_ps_priority+0xe>
    struct proc *p = myproc();
    p->ps_priority = n;
    return 0;
  }
  return -1;
    80005c9c:	557d                	li	a0,-1
}
    80005c9e:	8082                	ret
{
    80005ca0:	1101                	addi	sp,sp,-32
    80005ca2:	ec06                	sd	ra,24(sp)
    80005ca4:	e822                	sd	s0,16(sp)
    80005ca6:	e426                	sd	s1,8(sp)
    80005ca8:	1000                	addi	s0,sp,32
    80005caa:	84aa                	mv	s1,a0
    struct proc *p = myproc();
    80005cac:	ffffc097          	auipc	ra,0xffffc
    80005cb0:	d10080e7          	jalr	-752(ra) # 800019bc <myproc>
    p->ps_priority = n;
    80005cb4:	d124                	sw	s1,96(a0)
    return 0;
    80005cb6:	4501                	li	a0,0
}
    80005cb8:	60e2                	ld	ra,24(sp)
    80005cba:	6442                	ld	s0,16(sp)
    80005cbc:	64a2                	ld	s1,8(sp)
    80005cbe:	6105                	addi	sp,sp,32
    80005cc0:	8082                	ret

0000000080005cc2 <sys_set_cfs_priority>:

uint64
sys_set_cfs_priority(int n)
{
  if ((n>=0) & (n<=2)){
    80005cc2:	4789                	li	a5,2
    80005cc4:	00a7f463          	bgeu	a5,a0,80005ccc <sys_set_cfs_priority+0xa>
    struct proc *p = myproc();
    p->cfs_priority = n;
    return 0;
  }
  return -1;
    80005cc8:	557d                	li	a0,-1
    80005cca:	8082                	ret
{
    80005ccc:	1101                	addi	sp,sp,-32
    80005cce:	ec06                	sd	ra,24(sp)
    80005cd0:	e822                	sd	s0,16(sp)
    80005cd2:	e426                	sd	s1,8(sp)
    80005cd4:	1000                	addi	s0,sp,32
    80005cd6:	84aa                	mv	s1,a0
    struct proc *p = myproc();
    80005cd8:	ffffc097          	auipc	ra,0xffffc
    80005cdc:	ce4080e7          	jalr	-796(ra) # 800019bc <myproc>
    p->cfs_priority = n;
    80005ce0:	d164                	sw	s1,100(a0)
    return 0;
    80005ce2:	4501                	li	a0,0
    80005ce4:	60e2                	ld	ra,24(sp)
    80005ce6:	6442                	ld	s0,16(sp)
    80005ce8:	64a2                	ld	s1,8(sp)
    80005cea:	6105                	addi	sp,sp,32
    80005cec:	8082                	ret
	...

0000000080005cf0 <kernelvec>:
    80005cf0:	7111                	addi	sp,sp,-256
    80005cf2:	e006                	sd	ra,0(sp)
    80005cf4:	e40a                	sd	sp,8(sp)
    80005cf6:	e80e                	sd	gp,16(sp)
    80005cf8:	ec12                	sd	tp,24(sp)
    80005cfa:	f016                	sd	t0,32(sp)
    80005cfc:	f41a                	sd	t1,40(sp)
    80005cfe:	f81e                	sd	t2,48(sp)
    80005d00:	fc22                	sd	s0,56(sp)
    80005d02:	e0a6                	sd	s1,64(sp)
    80005d04:	e4aa                	sd	a0,72(sp)
    80005d06:	e8ae                	sd	a1,80(sp)
    80005d08:	ecb2                	sd	a2,88(sp)
    80005d0a:	f0b6                	sd	a3,96(sp)
    80005d0c:	f4ba                	sd	a4,104(sp)
    80005d0e:	f8be                	sd	a5,112(sp)
    80005d10:	fcc2                	sd	a6,120(sp)
    80005d12:	e146                	sd	a7,128(sp)
    80005d14:	e54a                	sd	s2,136(sp)
    80005d16:	e94e                	sd	s3,144(sp)
    80005d18:	ed52                	sd	s4,152(sp)
    80005d1a:	f156                	sd	s5,160(sp)
    80005d1c:	f55a                	sd	s6,168(sp)
    80005d1e:	f95e                	sd	s7,176(sp)
    80005d20:	fd62                	sd	s8,184(sp)
    80005d22:	e1e6                	sd	s9,192(sp)
    80005d24:	e5ea                	sd	s10,200(sp)
    80005d26:	e9ee                	sd	s11,208(sp)
    80005d28:	edf2                	sd	t3,216(sp)
    80005d2a:	f1f6                	sd	t4,224(sp)
    80005d2c:	f5fa                	sd	t5,232(sp)
    80005d2e:	f9fe                	sd	t6,240(sp)
    80005d30:	d01fc0ef          	jal	ra,80002a30 <kerneltrap>
    80005d34:	6082                	ld	ra,0(sp)
    80005d36:	6122                	ld	sp,8(sp)
    80005d38:	61c2                	ld	gp,16(sp)
    80005d3a:	7282                	ld	t0,32(sp)
    80005d3c:	7322                	ld	t1,40(sp)
    80005d3e:	73c2                	ld	t2,48(sp)
    80005d40:	7462                	ld	s0,56(sp)
    80005d42:	6486                	ld	s1,64(sp)
    80005d44:	6526                	ld	a0,72(sp)
    80005d46:	65c6                	ld	a1,80(sp)
    80005d48:	6666                	ld	a2,88(sp)
    80005d4a:	7686                	ld	a3,96(sp)
    80005d4c:	7726                	ld	a4,104(sp)
    80005d4e:	77c6                	ld	a5,112(sp)
    80005d50:	7866                	ld	a6,120(sp)
    80005d52:	688a                	ld	a7,128(sp)
    80005d54:	692a                	ld	s2,136(sp)
    80005d56:	69ca                	ld	s3,144(sp)
    80005d58:	6a6a                	ld	s4,152(sp)
    80005d5a:	7a8a                	ld	s5,160(sp)
    80005d5c:	7b2a                	ld	s6,168(sp)
    80005d5e:	7bca                	ld	s7,176(sp)
    80005d60:	7c6a                	ld	s8,184(sp)
    80005d62:	6c8e                	ld	s9,192(sp)
    80005d64:	6d2e                	ld	s10,200(sp)
    80005d66:	6dce                	ld	s11,208(sp)
    80005d68:	6e6e                	ld	t3,216(sp)
    80005d6a:	7e8e                	ld	t4,224(sp)
    80005d6c:	7f2e                	ld	t5,232(sp)
    80005d6e:	7fce                	ld	t6,240(sp)
    80005d70:	6111                	addi	sp,sp,256
    80005d72:	10200073          	sret
    80005d76:	00000013          	nop
    80005d7a:	00000013          	nop
    80005d7e:	0001                	nop

0000000080005d80 <timervec>:
    80005d80:	34051573          	csrrw	a0,mscratch,a0
    80005d84:	e10c                	sd	a1,0(a0)
    80005d86:	e510                	sd	a2,8(a0)
    80005d88:	e914                	sd	a3,16(a0)
    80005d8a:	6d0c                	ld	a1,24(a0)
    80005d8c:	7110                	ld	a2,32(a0)
    80005d8e:	6194                	ld	a3,0(a1)
    80005d90:	96b2                	add	a3,a3,a2
    80005d92:	e194                	sd	a3,0(a1)
    80005d94:	4589                	li	a1,2
    80005d96:	14459073          	csrw	sip,a1
    80005d9a:	6914                	ld	a3,16(a0)
    80005d9c:	6510                	ld	a2,8(a0)
    80005d9e:	610c                	ld	a1,0(a0)
    80005da0:	34051573          	csrrw	a0,mscratch,a0
    80005da4:	30200073          	mret
	...

0000000080005daa <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    80005daa:	1141                	addi	sp,sp,-16
    80005dac:	e422                	sd	s0,8(sp)
    80005dae:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80005db0:	0c0007b7          	lui	a5,0xc000
    80005db4:	4705                	li	a4,1
    80005db6:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80005db8:	c3d8                	sw	a4,4(a5)
}
    80005dba:	6422                	ld	s0,8(sp)
    80005dbc:	0141                	addi	sp,sp,16
    80005dbe:	8082                	ret

0000000080005dc0 <plicinithart>:

void
plicinithart(void)
{
    80005dc0:	1141                	addi	sp,sp,-16
    80005dc2:	e406                	sd	ra,8(sp)
    80005dc4:	e022                	sd	s0,0(sp)
    80005dc6:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005dc8:	ffffc097          	auipc	ra,0xffffc
    80005dcc:	bc8080e7          	jalr	-1080(ra) # 80001990 <cpuid>
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005dd0:	0085171b          	slliw	a4,a0,0x8
    80005dd4:	0c0027b7          	lui	a5,0xc002
    80005dd8:	97ba                	add	a5,a5,a4
    80005dda:	40200713          	li	a4,1026
    80005dde:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005de2:	00d5151b          	slliw	a0,a0,0xd
    80005de6:	0c2017b7          	lui	a5,0xc201
    80005dea:	953e                	add	a0,a0,a5
    80005dec:	00052023          	sw	zero,0(a0)
}
    80005df0:	60a2                	ld	ra,8(sp)
    80005df2:	6402                	ld	s0,0(sp)
    80005df4:	0141                	addi	sp,sp,16
    80005df6:	8082                	ret

0000000080005df8 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80005df8:	1141                	addi	sp,sp,-16
    80005dfa:	e406                	sd	ra,8(sp)
    80005dfc:	e022                	sd	s0,0(sp)
    80005dfe:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005e00:	ffffc097          	auipc	ra,0xffffc
    80005e04:	b90080e7          	jalr	-1136(ra) # 80001990 <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80005e08:	00d5179b          	slliw	a5,a0,0xd
    80005e0c:	0c201537          	lui	a0,0xc201
    80005e10:	953e                	add	a0,a0,a5
  return irq;
}
    80005e12:	4148                	lw	a0,4(a0)
    80005e14:	60a2                	ld	ra,8(sp)
    80005e16:	6402                	ld	s0,0(sp)
    80005e18:	0141                	addi	sp,sp,16
    80005e1a:	8082                	ret

0000000080005e1c <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80005e1c:	1101                	addi	sp,sp,-32
    80005e1e:	ec06                	sd	ra,24(sp)
    80005e20:	e822                	sd	s0,16(sp)
    80005e22:	e426                	sd	s1,8(sp)
    80005e24:	1000                	addi	s0,sp,32
    80005e26:	84aa                	mv	s1,a0
  int hart = cpuid();
    80005e28:	ffffc097          	auipc	ra,0xffffc
    80005e2c:	b68080e7          	jalr	-1176(ra) # 80001990 <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80005e30:	00d5151b          	slliw	a0,a0,0xd
    80005e34:	0c2017b7          	lui	a5,0xc201
    80005e38:	97aa                	add	a5,a5,a0
    80005e3a:	c3c4                	sw	s1,4(a5)
}
    80005e3c:	60e2                	ld	ra,24(sp)
    80005e3e:	6442                	ld	s0,16(sp)
    80005e40:	64a2                	ld	s1,8(sp)
    80005e42:	6105                	addi	sp,sp,32
    80005e44:	8082                	ret

0000000080005e46 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80005e46:	1141                	addi	sp,sp,-16
    80005e48:	e406                	sd	ra,8(sp)
    80005e4a:	e022                	sd	s0,0(sp)
    80005e4c:	0800                	addi	s0,sp,16
  if(i >= NUM)
    80005e4e:	479d                	li	a5,7
    80005e50:	04a7cc63          	blt	a5,a0,80005ea8 <free_desc+0x62>
    panic("free_desc 1");
  if(disk.free[i])
    80005e54:	0001d797          	auipc	a5,0x1d
    80005e58:	fdc78793          	addi	a5,a5,-36 # 80022e30 <disk>
    80005e5c:	97aa                	add	a5,a5,a0
    80005e5e:	0187c783          	lbu	a5,24(a5)
    80005e62:	ebb9                	bnez	a5,80005eb8 <free_desc+0x72>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80005e64:	00451613          	slli	a2,a0,0x4
    80005e68:	0001d797          	auipc	a5,0x1d
    80005e6c:	fc878793          	addi	a5,a5,-56 # 80022e30 <disk>
    80005e70:	6394                	ld	a3,0(a5)
    80005e72:	96b2                	add	a3,a3,a2
    80005e74:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    80005e78:	6398                	ld	a4,0(a5)
    80005e7a:	9732                	add	a4,a4,a2
    80005e7c:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    80005e80:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    80005e84:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    80005e88:	953e                	add	a0,a0,a5
    80005e8a:	4785                	li	a5,1
    80005e8c:	00f50c23          	sb	a5,24(a0) # c201018 <_entry-0x73dfefe8>
  wakeup(&disk.free[0]);
    80005e90:	0001d517          	auipc	a0,0x1d
    80005e94:	fb850513          	addi	a0,a0,-72 # 80022e48 <disk+0x18>
    80005e98:	ffffc097          	auipc	ra,0xffffc
    80005e9c:	2f4080e7          	jalr	756(ra) # 8000218c <wakeup>
}
    80005ea0:	60a2                	ld	ra,8(sp)
    80005ea2:	6402                	ld	s0,0(sp)
    80005ea4:	0141                	addi	sp,sp,16
    80005ea6:	8082                	ret
    panic("free_desc 1");
    80005ea8:	00003517          	auipc	a0,0x3
    80005eac:	8a850513          	addi	a0,a0,-1880 # 80008750 <syscalls+0x2f8>
    80005eb0:	ffffa097          	auipc	ra,0xffffa
    80005eb4:	68e080e7          	jalr	1678(ra) # 8000053e <panic>
    panic("free_desc 2");
    80005eb8:	00003517          	auipc	a0,0x3
    80005ebc:	8a850513          	addi	a0,a0,-1880 # 80008760 <syscalls+0x308>
    80005ec0:	ffffa097          	auipc	ra,0xffffa
    80005ec4:	67e080e7          	jalr	1662(ra) # 8000053e <panic>

0000000080005ec8 <virtio_disk_init>:
{
    80005ec8:	1101                	addi	sp,sp,-32
    80005eca:	ec06                	sd	ra,24(sp)
    80005ecc:	e822                	sd	s0,16(sp)
    80005ece:	e426                	sd	s1,8(sp)
    80005ed0:	e04a                	sd	s2,0(sp)
    80005ed2:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    80005ed4:	00003597          	auipc	a1,0x3
    80005ed8:	89c58593          	addi	a1,a1,-1892 # 80008770 <syscalls+0x318>
    80005edc:	0001d517          	auipc	a0,0x1d
    80005ee0:	07c50513          	addi	a0,a0,124 # 80022f58 <disk+0x128>
    80005ee4:	ffffb097          	auipc	ra,0xffffb
    80005ee8:	c62080e7          	jalr	-926(ra) # 80000b46 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005eec:	100017b7          	lui	a5,0x10001
    80005ef0:	4398                	lw	a4,0(a5)
    80005ef2:	2701                	sext.w	a4,a4
    80005ef4:	747277b7          	lui	a5,0x74727
    80005ef8:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80005efc:	14f71c63          	bne	a4,a5,80006054 <virtio_disk_init+0x18c>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80005f00:	100017b7          	lui	a5,0x10001
    80005f04:	43dc                	lw	a5,4(a5)
    80005f06:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005f08:	4709                	li	a4,2
    80005f0a:	14e79563          	bne	a5,a4,80006054 <virtio_disk_init+0x18c>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005f0e:	100017b7          	lui	a5,0x10001
    80005f12:	479c                	lw	a5,8(a5)
    80005f14:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80005f16:	12e79f63          	bne	a5,a4,80006054 <virtio_disk_init+0x18c>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80005f1a:	100017b7          	lui	a5,0x10001
    80005f1e:	47d8                	lw	a4,12(a5)
    80005f20:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005f22:	554d47b7          	lui	a5,0x554d4
    80005f26:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80005f2a:	12f71563          	bne	a4,a5,80006054 <virtio_disk_init+0x18c>
  *R(VIRTIO_MMIO_STATUS) = status;
    80005f2e:	100017b7          	lui	a5,0x10001
    80005f32:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    80005f36:	4705                	li	a4,1
    80005f38:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005f3a:	470d                	li	a4,3
    80005f3c:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80005f3e:	4b94                	lw	a3,16(a5)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80005f40:	c7ffe737          	lui	a4,0xc7ffe
    80005f44:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fdb7ef>
    80005f48:	8f75                	and	a4,a4,a3
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80005f4a:	2701                	sext.w	a4,a4
    80005f4c:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005f4e:	472d                	li	a4,11
    80005f50:	dbb8                	sw	a4,112(a5)
  status = *R(VIRTIO_MMIO_STATUS);
    80005f52:	5bbc                	lw	a5,112(a5)
    80005f54:	0007891b          	sext.w	s2,a5
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    80005f58:	8ba1                	andi	a5,a5,8
    80005f5a:	10078563          	beqz	a5,80006064 <virtio_disk_init+0x19c>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80005f5e:	100017b7          	lui	a5,0x10001
    80005f62:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    80005f66:	43fc                	lw	a5,68(a5)
    80005f68:	2781                	sext.w	a5,a5
    80005f6a:	10079563          	bnez	a5,80006074 <virtio_disk_init+0x1ac>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80005f6e:	100017b7          	lui	a5,0x10001
    80005f72:	5bdc                	lw	a5,52(a5)
    80005f74:	2781                	sext.w	a5,a5
  if(max == 0)
    80005f76:	10078763          	beqz	a5,80006084 <virtio_disk_init+0x1bc>
  if(max < NUM)
    80005f7a:	471d                	li	a4,7
    80005f7c:	10f77c63          	bgeu	a4,a5,80006094 <virtio_disk_init+0x1cc>
  disk.desc = kalloc();
    80005f80:	ffffb097          	auipc	ra,0xffffb
    80005f84:	b66080e7          	jalr	-1178(ra) # 80000ae6 <kalloc>
    80005f88:	0001d497          	auipc	s1,0x1d
    80005f8c:	ea848493          	addi	s1,s1,-344 # 80022e30 <disk>
    80005f90:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    80005f92:	ffffb097          	auipc	ra,0xffffb
    80005f96:	b54080e7          	jalr	-1196(ra) # 80000ae6 <kalloc>
    80005f9a:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    80005f9c:	ffffb097          	auipc	ra,0xffffb
    80005fa0:	b4a080e7          	jalr	-1206(ra) # 80000ae6 <kalloc>
    80005fa4:	87aa                	mv	a5,a0
    80005fa6:	e888                	sd	a0,16(s1)
  if(!disk.desc || !disk.avail || !disk.used)
    80005fa8:	6088                	ld	a0,0(s1)
    80005faa:	cd6d                	beqz	a0,800060a4 <virtio_disk_init+0x1dc>
    80005fac:	0001d717          	auipc	a4,0x1d
    80005fb0:	e8c73703          	ld	a4,-372(a4) # 80022e38 <disk+0x8>
    80005fb4:	cb65                	beqz	a4,800060a4 <virtio_disk_init+0x1dc>
    80005fb6:	c7fd                	beqz	a5,800060a4 <virtio_disk_init+0x1dc>
  memset(disk.desc, 0, PGSIZE);
    80005fb8:	6605                	lui	a2,0x1
    80005fba:	4581                	li	a1,0
    80005fbc:	ffffb097          	auipc	ra,0xffffb
    80005fc0:	d16080e7          	jalr	-746(ra) # 80000cd2 <memset>
  memset(disk.avail, 0, PGSIZE);
    80005fc4:	0001d497          	auipc	s1,0x1d
    80005fc8:	e6c48493          	addi	s1,s1,-404 # 80022e30 <disk>
    80005fcc:	6605                	lui	a2,0x1
    80005fce:	4581                	li	a1,0
    80005fd0:	6488                	ld	a0,8(s1)
    80005fd2:	ffffb097          	auipc	ra,0xffffb
    80005fd6:	d00080e7          	jalr	-768(ra) # 80000cd2 <memset>
  memset(disk.used, 0, PGSIZE);
    80005fda:	6605                	lui	a2,0x1
    80005fdc:	4581                	li	a1,0
    80005fde:	6888                	ld	a0,16(s1)
    80005fe0:	ffffb097          	auipc	ra,0xffffb
    80005fe4:	cf2080e7          	jalr	-782(ra) # 80000cd2 <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80005fe8:	100017b7          	lui	a5,0x10001
    80005fec:	4721                	li	a4,8
    80005fee:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    80005ff0:	4098                	lw	a4,0(s1)
    80005ff2:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    80005ff6:	40d8                	lw	a4,4(s1)
    80005ff8:	08e7a223          	sw	a4,132(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    80005ffc:	6498                	ld	a4,8(s1)
    80005ffe:	0007069b          	sext.w	a3,a4
    80006002:	08d7a823          	sw	a3,144(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    80006006:	9701                	srai	a4,a4,0x20
    80006008:	08e7aa23          	sw	a4,148(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    8000600c:	6898                	ld	a4,16(s1)
    8000600e:	0007069b          	sext.w	a3,a4
    80006012:	0ad7a023          	sw	a3,160(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    80006016:	9701                	srai	a4,a4,0x20
    80006018:	0ae7a223          	sw	a4,164(a5)
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    8000601c:	4705                	li	a4,1
    8000601e:	c3f8                	sw	a4,68(a5)
    disk.free[i] = 1;
    80006020:	00e48c23          	sb	a4,24(s1)
    80006024:	00e48ca3          	sb	a4,25(s1)
    80006028:	00e48d23          	sb	a4,26(s1)
    8000602c:	00e48da3          	sb	a4,27(s1)
    80006030:	00e48e23          	sb	a4,28(s1)
    80006034:	00e48ea3          	sb	a4,29(s1)
    80006038:	00e48f23          	sb	a4,30(s1)
    8000603c:	00e48fa3          	sb	a4,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    80006040:	00496913          	ori	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    80006044:	0727a823          	sw	s2,112(a5)
}
    80006048:	60e2                	ld	ra,24(sp)
    8000604a:	6442                	ld	s0,16(sp)
    8000604c:	64a2                	ld	s1,8(sp)
    8000604e:	6902                	ld	s2,0(sp)
    80006050:	6105                	addi	sp,sp,32
    80006052:	8082                	ret
    panic("could not find virtio disk");
    80006054:	00002517          	auipc	a0,0x2
    80006058:	72c50513          	addi	a0,a0,1836 # 80008780 <syscalls+0x328>
    8000605c:	ffffa097          	auipc	ra,0xffffa
    80006060:	4e2080e7          	jalr	1250(ra) # 8000053e <panic>
    panic("virtio disk FEATURES_OK unset");
    80006064:	00002517          	auipc	a0,0x2
    80006068:	73c50513          	addi	a0,a0,1852 # 800087a0 <syscalls+0x348>
    8000606c:	ffffa097          	auipc	ra,0xffffa
    80006070:	4d2080e7          	jalr	1234(ra) # 8000053e <panic>
    panic("virtio disk should not be ready");
    80006074:	00002517          	auipc	a0,0x2
    80006078:	74c50513          	addi	a0,a0,1868 # 800087c0 <syscalls+0x368>
    8000607c:	ffffa097          	auipc	ra,0xffffa
    80006080:	4c2080e7          	jalr	1218(ra) # 8000053e <panic>
    panic("virtio disk has no queue 0");
    80006084:	00002517          	auipc	a0,0x2
    80006088:	75c50513          	addi	a0,a0,1884 # 800087e0 <syscalls+0x388>
    8000608c:	ffffa097          	auipc	ra,0xffffa
    80006090:	4b2080e7          	jalr	1202(ra) # 8000053e <panic>
    panic("virtio disk max queue too short");
    80006094:	00002517          	auipc	a0,0x2
    80006098:	76c50513          	addi	a0,a0,1900 # 80008800 <syscalls+0x3a8>
    8000609c:	ffffa097          	auipc	ra,0xffffa
    800060a0:	4a2080e7          	jalr	1186(ra) # 8000053e <panic>
    panic("virtio disk kalloc");
    800060a4:	00002517          	auipc	a0,0x2
    800060a8:	77c50513          	addi	a0,a0,1916 # 80008820 <syscalls+0x3c8>
    800060ac:	ffffa097          	auipc	ra,0xffffa
    800060b0:	492080e7          	jalr	1170(ra) # 8000053e <panic>

00000000800060b4 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    800060b4:	7119                	addi	sp,sp,-128
    800060b6:	fc86                	sd	ra,120(sp)
    800060b8:	f8a2                	sd	s0,112(sp)
    800060ba:	f4a6                	sd	s1,104(sp)
    800060bc:	f0ca                	sd	s2,96(sp)
    800060be:	ecce                	sd	s3,88(sp)
    800060c0:	e8d2                	sd	s4,80(sp)
    800060c2:	e4d6                	sd	s5,72(sp)
    800060c4:	e0da                	sd	s6,64(sp)
    800060c6:	fc5e                	sd	s7,56(sp)
    800060c8:	f862                	sd	s8,48(sp)
    800060ca:	f466                	sd	s9,40(sp)
    800060cc:	f06a                	sd	s10,32(sp)
    800060ce:	ec6e                	sd	s11,24(sp)
    800060d0:	0100                	addi	s0,sp,128
    800060d2:	8aaa                	mv	s5,a0
    800060d4:	8c2e                	mv	s8,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    800060d6:	00c52d03          	lw	s10,12(a0)
    800060da:	001d1d1b          	slliw	s10,s10,0x1
    800060de:	1d02                	slli	s10,s10,0x20
    800060e0:	020d5d13          	srli	s10,s10,0x20

  acquire(&disk.vdisk_lock);
    800060e4:	0001d517          	auipc	a0,0x1d
    800060e8:	e7450513          	addi	a0,a0,-396 # 80022f58 <disk+0x128>
    800060ec:	ffffb097          	auipc	ra,0xffffb
    800060f0:	aea080e7          	jalr	-1302(ra) # 80000bd6 <acquire>
  for(int i = 0; i < 3; i++){
    800060f4:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    800060f6:	44a1                	li	s1,8
      disk.free[i] = 0;
    800060f8:	0001db97          	auipc	s7,0x1d
    800060fc:	d38b8b93          	addi	s7,s7,-712 # 80022e30 <disk>
  for(int i = 0; i < 3; i++){
    80006100:	4b0d                	li	s6,3
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80006102:	0001dc97          	auipc	s9,0x1d
    80006106:	e56c8c93          	addi	s9,s9,-426 # 80022f58 <disk+0x128>
    8000610a:	a08d                	j	8000616c <virtio_disk_rw+0xb8>
      disk.free[i] = 0;
    8000610c:	00fb8733          	add	a4,s7,a5
    80006110:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    80006114:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    80006116:	0207c563          	bltz	a5,80006140 <virtio_disk_rw+0x8c>
  for(int i = 0; i < 3; i++){
    8000611a:	2905                	addiw	s2,s2,1
    8000611c:	0611                	addi	a2,a2,4
    8000611e:	05690c63          	beq	s2,s6,80006176 <virtio_disk_rw+0xc2>
    idx[i] = alloc_desc();
    80006122:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    80006124:	0001d717          	auipc	a4,0x1d
    80006128:	d0c70713          	addi	a4,a4,-756 # 80022e30 <disk>
    8000612c:	87ce                	mv	a5,s3
    if(disk.free[i]){
    8000612e:	01874683          	lbu	a3,24(a4)
    80006132:	fee9                	bnez	a3,8000610c <virtio_disk_rw+0x58>
  for(int i = 0; i < NUM; i++){
    80006134:	2785                	addiw	a5,a5,1
    80006136:	0705                	addi	a4,a4,1
    80006138:	fe979be3          	bne	a5,s1,8000612e <virtio_disk_rw+0x7a>
    idx[i] = alloc_desc();
    8000613c:	57fd                	li	a5,-1
    8000613e:	c19c                	sw	a5,0(a1)
      for(int j = 0; j < i; j++)
    80006140:	01205d63          	blez	s2,8000615a <virtio_disk_rw+0xa6>
    80006144:	8dce                	mv	s11,s3
        free_desc(idx[j]);
    80006146:	000a2503          	lw	a0,0(s4)
    8000614a:	00000097          	auipc	ra,0x0
    8000614e:	cfc080e7          	jalr	-772(ra) # 80005e46 <free_desc>
      for(int j = 0; j < i; j++)
    80006152:	2d85                	addiw	s11,s11,1
    80006154:	0a11                	addi	s4,s4,4
    80006156:	ffb918e3          	bne	s2,s11,80006146 <virtio_disk_rw+0x92>
    sleep(&disk.free[0], &disk.vdisk_lock);
    8000615a:	85e6                	mv	a1,s9
    8000615c:	0001d517          	auipc	a0,0x1d
    80006160:	cec50513          	addi	a0,a0,-788 # 80022e48 <disk+0x18>
    80006164:	ffffc097          	auipc	ra,0xffffc
    80006168:	fc4080e7          	jalr	-60(ra) # 80002128 <sleep>
  for(int i = 0; i < 3; i++){
    8000616c:	f8040a13          	addi	s4,s0,-128
{
    80006170:	8652                	mv	a2,s4
  for(int i = 0; i < 3; i++){
    80006172:	894e                	mv	s2,s3
    80006174:	b77d                	j	80006122 <virtio_disk_rw+0x6e>
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80006176:	f8042583          	lw	a1,-128(s0)
    8000617a:	00a58793          	addi	a5,a1,10
    8000617e:	0792                	slli	a5,a5,0x4

  if(write)
    80006180:	0001d617          	auipc	a2,0x1d
    80006184:	cb060613          	addi	a2,a2,-848 # 80022e30 <disk>
    80006188:	00f60733          	add	a4,a2,a5
    8000618c:	018036b3          	snez	a3,s8
    80006190:	c714                	sw	a3,8(a4)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    80006192:	00072623          	sw	zero,12(a4)
  buf0->sector = sector;
    80006196:	01a73823          	sd	s10,16(a4)

  disk.desc[idx[0]].addr = (uint64) buf0;
    8000619a:	f6078693          	addi	a3,a5,-160
    8000619e:	6218                	ld	a4,0(a2)
    800061a0:	9736                	add	a4,a4,a3
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800061a2:	00878513          	addi	a0,a5,8
    800061a6:	9532                	add	a0,a0,a2
  disk.desc[idx[0]].addr = (uint64) buf0;
    800061a8:	e308                	sd	a0,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    800061aa:	6208                	ld	a0,0(a2)
    800061ac:	96aa                	add	a3,a3,a0
    800061ae:	4741                	li	a4,16
    800061b0:	c698                	sw	a4,8(a3)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    800061b2:	4705                	li	a4,1
    800061b4:	00e69623          	sh	a4,12(a3)
  disk.desc[idx[0]].next = idx[1];
    800061b8:	f8442703          	lw	a4,-124(s0)
    800061bc:	00e69723          	sh	a4,14(a3)

  disk.desc[idx[1]].addr = (uint64) b->data;
    800061c0:	0712                	slli	a4,a4,0x4
    800061c2:	953a                	add	a0,a0,a4
    800061c4:	058a8693          	addi	a3,s5,88
    800061c8:	e114                	sd	a3,0(a0)
  disk.desc[idx[1]].len = BSIZE;
    800061ca:	6208                	ld	a0,0(a2)
    800061cc:	972a                	add	a4,a4,a0
    800061ce:	40000693          	li	a3,1024
    800061d2:	c714                	sw	a3,8(a4)
  if(write)
    disk.desc[idx[1]].flags = 0; // device reads b->data
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    800061d4:	001c3c13          	seqz	s8,s8
    800061d8:	0c06                	slli	s8,s8,0x1
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    800061da:	001c6c13          	ori	s8,s8,1
    800061de:	01871623          	sh	s8,12(a4)
  disk.desc[idx[1]].next = idx[2];
    800061e2:	f8842603          	lw	a2,-120(s0)
    800061e6:	00c71723          	sh	a2,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    800061ea:	0001d697          	auipc	a3,0x1d
    800061ee:	c4668693          	addi	a3,a3,-954 # 80022e30 <disk>
    800061f2:	00258713          	addi	a4,a1,2
    800061f6:	0712                	slli	a4,a4,0x4
    800061f8:	9736                	add	a4,a4,a3
    800061fa:	587d                	li	a6,-1
    800061fc:	01070823          	sb	a6,16(a4)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80006200:	0612                	slli	a2,a2,0x4
    80006202:	9532                	add	a0,a0,a2
    80006204:	f9078793          	addi	a5,a5,-112
    80006208:	97b6                	add	a5,a5,a3
    8000620a:	e11c                	sd	a5,0(a0)
  disk.desc[idx[2]].len = 1;
    8000620c:	629c                	ld	a5,0(a3)
    8000620e:	97b2                	add	a5,a5,a2
    80006210:	4605                	li	a2,1
    80006212:	c790                	sw	a2,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80006214:	4509                	li	a0,2
    80006216:	00a79623          	sh	a0,12(a5)
  disk.desc[idx[2]].next = 0;
    8000621a:	00079723          	sh	zero,14(a5)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    8000621e:	00caa223          	sw	a2,4(s5)
  disk.info[idx[0]].b = b;
    80006222:	01573423          	sd	s5,8(a4)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80006226:	6698                	ld	a4,8(a3)
    80006228:	00275783          	lhu	a5,2(a4)
    8000622c:	8b9d                	andi	a5,a5,7
    8000622e:	0786                	slli	a5,a5,0x1
    80006230:	97ba                	add	a5,a5,a4
    80006232:	00b79223          	sh	a1,4(a5)

  __sync_synchronize();
    80006236:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    8000623a:	6698                	ld	a4,8(a3)
    8000623c:	00275783          	lhu	a5,2(a4)
    80006240:	2785                	addiw	a5,a5,1
    80006242:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80006246:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    8000624a:	100017b7          	lui	a5,0x10001
    8000624e:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80006252:	004aa783          	lw	a5,4(s5)
    80006256:	02c79163          	bne	a5,a2,80006278 <virtio_disk_rw+0x1c4>
    sleep(b, &disk.vdisk_lock);
    8000625a:	0001d917          	auipc	s2,0x1d
    8000625e:	cfe90913          	addi	s2,s2,-770 # 80022f58 <disk+0x128>
  while(b->disk == 1) {
    80006262:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    80006264:	85ca                	mv	a1,s2
    80006266:	8556                	mv	a0,s5
    80006268:	ffffc097          	auipc	ra,0xffffc
    8000626c:	ec0080e7          	jalr	-320(ra) # 80002128 <sleep>
  while(b->disk == 1) {
    80006270:	004aa783          	lw	a5,4(s5)
    80006274:	fe9788e3          	beq	a5,s1,80006264 <virtio_disk_rw+0x1b0>
  }

  disk.info[idx[0]].b = 0;
    80006278:	f8042903          	lw	s2,-128(s0)
    8000627c:	00290793          	addi	a5,s2,2
    80006280:	00479713          	slli	a4,a5,0x4
    80006284:	0001d797          	auipc	a5,0x1d
    80006288:	bac78793          	addi	a5,a5,-1108 # 80022e30 <disk>
    8000628c:	97ba                	add	a5,a5,a4
    8000628e:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    80006292:	0001d997          	auipc	s3,0x1d
    80006296:	b9e98993          	addi	s3,s3,-1122 # 80022e30 <disk>
    8000629a:	00491713          	slli	a4,s2,0x4
    8000629e:	0009b783          	ld	a5,0(s3)
    800062a2:	97ba                	add	a5,a5,a4
    800062a4:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    800062a8:	854a                	mv	a0,s2
    800062aa:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    800062ae:	00000097          	auipc	ra,0x0
    800062b2:	b98080e7          	jalr	-1128(ra) # 80005e46 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    800062b6:	8885                	andi	s1,s1,1
    800062b8:	f0ed                	bnez	s1,8000629a <virtio_disk_rw+0x1e6>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    800062ba:	0001d517          	auipc	a0,0x1d
    800062be:	c9e50513          	addi	a0,a0,-866 # 80022f58 <disk+0x128>
    800062c2:	ffffb097          	auipc	ra,0xffffb
    800062c6:	9c8080e7          	jalr	-1592(ra) # 80000c8a <release>
}
    800062ca:	70e6                	ld	ra,120(sp)
    800062cc:	7446                	ld	s0,112(sp)
    800062ce:	74a6                	ld	s1,104(sp)
    800062d0:	7906                	ld	s2,96(sp)
    800062d2:	69e6                	ld	s3,88(sp)
    800062d4:	6a46                	ld	s4,80(sp)
    800062d6:	6aa6                	ld	s5,72(sp)
    800062d8:	6b06                	ld	s6,64(sp)
    800062da:	7be2                	ld	s7,56(sp)
    800062dc:	7c42                	ld	s8,48(sp)
    800062de:	7ca2                	ld	s9,40(sp)
    800062e0:	7d02                	ld	s10,32(sp)
    800062e2:	6de2                	ld	s11,24(sp)
    800062e4:	6109                	addi	sp,sp,128
    800062e6:	8082                	ret

00000000800062e8 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    800062e8:	1101                	addi	sp,sp,-32
    800062ea:	ec06                	sd	ra,24(sp)
    800062ec:	e822                	sd	s0,16(sp)
    800062ee:	e426                	sd	s1,8(sp)
    800062f0:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    800062f2:	0001d497          	auipc	s1,0x1d
    800062f6:	b3e48493          	addi	s1,s1,-1218 # 80022e30 <disk>
    800062fa:	0001d517          	auipc	a0,0x1d
    800062fe:	c5e50513          	addi	a0,a0,-930 # 80022f58 <disk+0x128>
    80006302:	ffffb097          	auipc	ra,0xffffb
    80006306:	8d4080e7          	jalr	-1836(ra) # 80000bd6 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    8000630a:	10001737          	lui	a4,0x10001
    8000630e:	533c                	lw	a5,96(a4)
    80006310:	8b8d                	andi	a5,a5,3
    80006312:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    80006314:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80006318:	689c                	ld	a5,16(s1)
    8000631a:	0204d703          	lhu	a4,32(s1)
    8000631e:	0027d783          	lhu	a5,2(a5)
    80006322:	04f70863          	beq	a4,a5,80006372 <virtio_disk_intr+0x8a>
    __sync_synchronize();
    80006326:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    8000632a:	6898                	ld	a4,16(s1)
    8000632c:	0204d783          	lhu	a5,32(s1)
    80006330:	8b9d                	andi	a5,a5,7
    80006332:	078e                	slli	a5,a5,0x3
    80006334:	97ba                	add	a5,a5,a4
    80006336:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80006338:	00278713          	addi	a4,a5,2
    8000633c:	0712                	slli	a4,a4,0x4
    8000633e:	9726                	add	a4,a4,s1
    80006340:	01074703          	lbu	a4,16(a4) # 10001010 <_entry-0x6fffeff0>
    80006344:	e721                	bnez	a4,8000638c <virtio_disk_intr+0xa4>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80006346:	0789                	addi	a5,a5,2
    80006348:	0792                	slli	a5,a5,0x4
    8000634a:	97a6                	add	a5,a5,s1
    8000634c:	6788                	ld	a0,8(a5)
    b->disk = 0;   // disk is done with buf
    8000634e:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80006352:	ffffc097          	auipc	ra,0xffffc
    80006356:	e3a080e7          	jalr	-454(ra) # 8000218c <wakeup>

    disk.used_idx += 1;
    8000635a:	0204d783          	lhu	a5,32(s1)
    8000635e:	2785                	addiw	a5,a5,1
    80006360:	17c2                	slli	a5,a5,0x30
    80006362:	93c1                	srli	a5,a5,0x30
    80006364:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80006368:	6898                	ld	a4,16(s1)
    8000636a:	00275703          	lhu	a4,2(a4)
    8000636e:	faf71ce3          	bne	a4,a5,80006326 <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    80006372:	0001d517          	auipc	a0,0x1d
    80006376:	be650513          	addi	a0,a0,-1050 # 80022f58 <disk+0x128>
    8000637a:	ffffb097          	auipc	ra,0xffffb
    8000637e:	910080e7          	jalr	-1776(ra) # 80000c8a <release>
}
    80006382:	60e2                	ld	ra,24(sp)
    80006384:	6442                	ld	s0,16(sp)
    80006386:	64a2                	ld	s1,8(sp)
    80006388:	6105                	addi	sp,sp,32
    8000638a:	8082                	ret
      panic("virtio_disk_intr status");
    8000638c:	00002517          	auipc	a0,0x2
    80006390:	4ac50513          	addi	a0,a0,1196 # 80008838 <syscalls+0x3e0>
    80006394:	ffffa097          	auipc	ra,0xffffa
    80006398:	1aa080e7          	jalr	426(ra) # 8000053e <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051073          	csrw	sscratch,a0
    80007004:	02000537          	lui	a0,0x2000
    80007008:	357d                	addiw	a0,a0,-1
    8000700a:	0536                	slli	a0,a0,0xd
    8000700c:	02153423          	sd	ra,40(a0) # 2000028 <_entry-0x7dffffd8>
    80007010:	02253823          	sd	sp,48(a0)
    80007014:	02353c23          	sd	gp,56(a0)
    80007018:	04453023          	sd	tp,64(a0)
    8000701c:	04553423          	sd	t0,72(a0)
    80007020:	04653823          	sd	t1,80(a0)
    80007024:	04753c23          	sd	t2,88(a0)
    80007028:	f120                	sd	s0,96(a0)
    8000702a:	f524                	sd	s1,104(a0)
    8000702c:	fd2c                	sd	a1,120(a0)
    8000702e:	e150                	sd	a2,128(a0)
    80007030:	e554                	sd	a3,136(a0)
    80007032:	e958                	sd	a4,144(a0)
    80007034:	ed5c                	sd	a5,152(a0)
    80007036:	0b053023          	sd	a6,160(a0)
    8000703a:	0b153423          	sd	a7,168(a0)
    8000703e:	0b253823          	sd	s2,176(a0)
    80007042:	0b353c23          	sd	s3,184(a0)
    80007046:	0d453023          	sd	s4,192(a0)
    8000704a:	0d553423          	sd	s5,200(a0)
    8000704e:	0d653823          	sd	s6,208(a0)
    80007052:	0d753c23          	sd	s7,216(a0)
    80007056:	0f853023          	sd	s8,224(a0)
    8000705a:	0f953423          	sd	s9,232(a0)
    8000705e:	0fa53823          	sd	s10,240(a0)
    80007062:	0fb53c23          	sd	s11,248(a0)
    80007066:	11c53023          	sd	t3,256(a0)
    8000706a:	11d53423          	sd	t4,264(a0)
    8000706e:	11e53823          	sd	t5,272(a0)
    80007072:	11f53c23          	sd	t6,280(a0)
    80007076:	140022f3          	csrr	t0,sscratch
    8000707a:	06553823          	sd	t0,112(a0)
    8000707e:	00853103          	ld	sp,8(a0)
    80007082:	02053203          	ld	tp,32(a0)
    80007086:	01053283          	ld	t0,16(a0)
    8000708a:	00053303          	ld	t1,0(a0)
    8000708e:	12000073          	sfence.vma
    80007092:	18031073          	csrw	satp,t1
    80007096:	12000073          	sfence.vma
    8000709a:	8282                	jr	t0

000000008000709c <userret>:
    8000709c:	12000073          	sfence.vma
    800070a0:	18051073          	csrw	satp,a0
    800070a4:	12000073          	sfence.vma
    800070a8:	02000537          	lui	a0,0x2000
    800070ac:	357d                	addiw	a0,a0,-1
    800070ae:	0536                	slli	a0,a0,0xd
    800070b0:	02853083          	ld	ra,40(a0) # 2000028 <_entry-0x7dffffd8>
    800070b4:	03053103          	ld	sp,48(a0)
    800070b8:	03853183          	ld	gp,56(a0)
    800070bc:	04053203          	ld	tp,64(a0)
    800070c0:	04853283          	ld	t0,72(a0)
    800070c4:	05053303          	ld	t1,80(a0)
    800070c8:	05853383          	ld	t2,88(a0)
    800070cc:	7120                	ld	s0,96(a0)
    800070ce:	7524                	ld	s1,104(a0)
    800070d0:	7d2c                	ld	a1,120(a0)
    800070d2:	6150                	ld	a2,128(a0)
    800070d4:	6554                	ld	a3,136(a0)
    800070d6:	6958                	ld	a4,144(a0)
    800070d8:	6d5c                	ld	a5,152(a0)
    800070da:	0a053803          	ld	a6,160(a0)
    800070de:	0a853883          	ld	a7,168(a0)
    800070e2:	0b053903          	ld	s2,176(a0)
    800070e6:	0b853983          	ld	s3,184(a0)
    800070ea:	0c053a03          	ld	s4,192(a0)
    800070ee:	0c853a83          	ld	s5,200(a0)
    800070f2:	0d053b03          	ld	s6,208(a0)
    800070f6:	0d853b83          	ld	s7,216(a0)
    800070fa:	0e053c03          	ld	s8,224(a0)
    800070fe:	0e853c83          	ld	s9,232(a0)
    80007102:	0f053d03          	ld	s10,240(a0)
    80007106:	0f853d83          	ld	s11,248(a0)
    8000710a:	10053e03          	ld	t3,256(a0)
    8000710e:	10853e83          	ld	t4,264(a0)
    80007112:	11053f03          	ld	t5,272(a0)
    80007116:	11853f83          	ld	t6,280(a0)
    8000711a:	7928                	ld	a0,112(a0)
    8000711c:	10200073          	sret
	...
