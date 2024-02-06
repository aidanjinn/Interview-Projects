
user/_sysinfotest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <sinfo>:
#include "kernel/sysinfo.h"
#include "user/user.h"


void
sinfo(struct sysinfo *info) {
   0:	1141                	add	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	add	s0,sp,16
  if (sysinfo(info) < 0) {
   8:	00000097          	auipc	ra,0x0
   c:	73e080e7          	jalr	1854(ra) # 746 <sysinfo>
  10:	00054663          	bltz	a0,1c <sinfo+0x1c>
    printf("FAIL: sysinfo failed");
    exit(1);
  }
}
  14:	60a2                	ld	ra,8(sp)
  16:	6402                	ld	s0,0(sp)
  18:	0141                	add	sp,sp,16
  1a:	8082                	ret
    printf("FAIL: sysinfo failed");
  1c:	00001517          	auipc	a0,0x1
  20:	bc450513          	add	a0,a0,-1084 # be0 <malloc+0x102>
  24:	00001097          	auipc	ra,0x1
  28:	a02080e7          	jalr	-1534(ra) # a26 <printf>
    exit(1);
  2c:	4505                	li	a0,1
  2e:	00000097          	auipc	ra,0x0
  32:	670080e7          	jalr	1648(ra) # 69e <exit>

0000000000000036 <countfree>:
//
// use sbrk() to count how many free physical memory pages there are.
//
int
countfree()
{
  36:	7139                	add	sp,sp,-64
  38:	fc06                	sd	ra,56(sp)
  3a:	f822                	sd	s0,48(sp)
  3c:	f426                	sd	s1,40(sp)
  3e:	f04a                	sd	s2,32(sp)
  40:	ec4e                	sd	s3,24(sp)
  42:	e852                	sd	s4,16(sp)
  44:	0080                	add	s0,sp,64
  uint64 sz0 = (uint64)sbrk(0);
  46:	4501                	li	a0,0
  48:	00000097          	auipc	ra,0x0
  4c:	6de080e7          	jalr	1758(ra) # 726 <sbrk>
  50:	8a2a                	mv	s4,a0
  struct sysinfo info;
  int n = 0;
  52:	4481                	li	s1,0

  while(1){
    if((uint64)sbrk(PGSIZE) == 0xffffffffffffffff){
  54:	597d                	li	s2,-1
      break;
    }
    n += PGSIZE;
  56:	6985                	lui	s3,0x1
  58:	a019                	j	5e <countfree+0x28>
  5a:	009984bb          	addw	s1,s3,s1
    if((uint64)sbrk(PGSIZE) == 0xffffffffffffffff){
  5e:	6505                	lui	a0,0x1
  60:	00000097          	auipc	ra,0x0
  64:	6c6080e7          	jalr	1734(ra) # 726 <sbrk>
  68:	ff2519e3          	bne	a0,s2,5a <countfree+0x24>
  }
  sinfo(&info);
  6c:	fc040513          	add	a0,s0,-64
  70:	00000097          	auipc	ra,0x0
  74:	f90080e7          	jalr	-112(ra) # 0 <sinfo>
  if (info.freemem != 0) {
  78:	fc043583          	ld	a1,-64(s0)
  7c:	e58d                	bnez	a1,a6 <countfree+0x70>
    printf("FAIL: there is no free mem, but sysinfo.freemem=%d\n",
      info.freemem);
    exit(1);
  }
  sbrk(-((uint64)sbrk(0) - sz0));
  7e:	4501                	li	a0,0
  80:	00000097          	auipc	ra,0x0
  84:	6a6080e7          	jalr	1702(ra) # 726 <sbrk>
  88:	40aa053b          	subw	a0,s4,a0
  8c:	00000097          	auipc	ra,0x0
  90:	69a080e7          	jalr	1690(ra) # 726 <sbrk>
  return n;
}
  94:	8526                	mv	a0,s1
  96:	70e2                	ld	ra,56(sp)
  98:	7442                	ld	s0,48(sp)
  9a:	74a2                	ld	s1,40(sp)
  9c:	7902                	ld	s2,32(sp)
  9e:	69e2                	ld	s3,24(sp)
  a0:	6a42                	ld	s4,16(sp)
  a2:	6121                	add	sp,sp,64
  a4:	8082                	ret
    printf("FAIL: there is no free mem, but sysinfo.freemem=%d\n",
  a6:	00001517          	auipc	a0,0x1
  aa:	b5250513          	add	a0,a0,-1198 # bf8 <malloc+0x11a>
  ae:	00001097          	auipc	ra,0x1
  b2:	978080e7          	jalr	-1672(ra) # a26 <printf>
    exit(1);
  b6:	4505                	li	a0,1
  b8:	00000097          	auipc	ra,0x0
  bc:	5e6080e7          	jalr	1510(ra) # 69e <exit>

00000000000000c0 <testmem>:

void
testmem() {
  c0:	7179                	add	sp,sp,-48
  c2:	f406                	sd	ra,40(sp)
  c4:	f022                	sd	s0,32(sp)
  c6:	ec26                	sd	s1,24(sp)
  c8:	e84a                	sd	s2,16(sp)
  ca:	1800                	add	s0,sp,48
  struct sysinfo info;
  uint64 n = countfree();
  cc:	00000097          	auipc	ra,0x0
  d0:	f6a080e7          	jalr	-150(ra) # 36 <countfree>
  d4:	84aa                	mv	s1,a0
  
  sinfo(&info);
  d6:	fd040513          	add	a0,s0,-48
  da:	00000097          	auipc	ra,0x0
  de:	f26080e7          	jalr	-218(ra) # 0 <sinfo>

  if (info.freemem!= n) {
  e2:	fd043583          	ld	a1,-48(s0)
  e6:	04959e63          	bne	a1,s1,142 <testmem+0x82>
    printf("FAIL: free mem %d (bytes) instead of %d\n", info.freemem, n);
    exit(1);
  }
  
  if((uint64)sbrk(PGSIZE) == 0xffffffffffffffff){
  ea:	6505                	lui	a0,0x1
  ec:	00000097          	auipc	ra,0x0
  f0:	63a080e7          	jalr	1594(ra) # 726 <sbrk>
  f4:	57fd                	li	a5,-1
  f6:	06f50463          	beq	a0,a5,15e <testmem+0x9e>
    printf("sbrk failed");
    exit(1);
  }

  sinfo(&info);
  fa:	fd040513          	add	a0,s0,-48
  fe:	00000097          	auipc	ra,0x0
 102:	f02080e7          	jalr	-254(ra) # 0 <sinfo>
    
  if (info.freemem != n-PGSIZE) {
 106:	fd043603          	ld	a2,-48(s0)
 10a:	75fd                	lui	a1,0xfffff
 10c:	95a6                	add	a1,a1,s1
 10e:	06b61563          	bne	a2,a1,178 <testmem+0xb8>
    printf("FAIL: free mem %d (bytes) instead of %d\n", n-PGSIZE, info.freemem);
    exit(1);
  }
  
  if((uint64)sbrk(-PGSIZE) == 0xffffffffffffffff){
 112:	757d                	lui	a0,0xfffff
 114:	00000097          	auipc	ra,0x0
 118:	612080e7          	jalr	1554(ra) # 726 <sbrk>
 11c:	57fd                	li	a5,-1
 11e:	06f50a63          	beq	a0,a5,192 <testmem+0xd2>
    printf("sbrk failed");
    exit(1);
  }

  sinfo(&info);
 122:	fd040513          	add	a0,s0,-48
 126:	00000097          	auipc	ra,0x0
 12a:	eda080e7          	jalr	-294(ra) # 0 <sinfo>
    
  if (info.freemem != n) {
 12e:	fd043603          	ld	a2,-48(s0)
 132:	06961d63          	bne	a2,s1,1ac <testmem+0xec>
    printf("FAIL: free mem %d (bytes) instead of %d\n", n, info.freemem);
    exit(1);
  }
}
 136:	70a2                	ld	ra,40(sp)
 138:	7402                	ld	s0,32(sp)
 13a:	64e2                	ld	s1,24(sp)
 13c:	6942                	ld	s2,16(sp)
 13e:	6145                	add	sp,sp,48
 140:	8082                	ret
    printf("FAIL: free mem %d (bytes) instead of %d\n", info.freemem, n);
 142:	8626                	mv	a2,s1
 144:	00001517          	auipc	a0,0x1
 148:	aec50513          	add	a0,a0,-1300 # c30 <malloc+0x152>
 14c:	00001097          	auipc	ra,0x1
 150:	8da080e7          	jalr	-1830(ra) # a26 <printf>
    exit(1);
 154:	4505                	li	a0,1
 156:	00000097          	auipc	ra,0x0
 15a:	548080e7          	jalr	1352(ra) # 69e <exit>
    printf("sbrk failed");
 15e:	00001517          	auipc	a0,0x1
 162:	b0250513          	add	a0,a0,-1278 # c60 <malloc+0x182>
 166:	00001097          	auipc	ra,0x1
 16a:	8c0080e7          	jalr	-1856(ra) # a26 <printf>
    exit(1);
 16e:	4505                	li	a0,1
 170:	00000097          	auipc	ra,0x0
 174:	52e080e7          	jalr	1326(ra) # 69e <exit>
    printf("FAIL: free mem %d (bytes) instead of %d\n", n-PGSIZE, info.freemem);
 178:	00001517          	auipc	a0,0x1
 17c:	ab850513          	add	a0,a0,-1352 # c30 <malloc+0x152>
 180:	00001097          	auipc	ra,0x1
 184:	8a6080e7          	jalr	-1882(ra) # a26 <printf>
    exit(1);
 188:	4505                	li	a0,1
 18a:	00000097          	auipc	ra,0x0
 18e:	514080e7          	jalr	1300(ra) # 69e <exit>
    printf("sbrk failed");
 192:	00001517          	auipc	a0,0x1
 196:	ace50513          	add	a0,a0,-1330 # c60 <malloc+0x182>
 19a:	00001097          	auipc	ra,0x1
 19e:	88c080e7          	jalr	-1908(ra) # a26 <printf>
    exit(1);
 1a2:	4505                	li	a0,1
 1a4:	00000097          	auipc	ra,0x0
 1a8:	4fa080e7          	jalr	1274(ra) # 69e <exit>
    printf("FAIL: free mem %d (bytes) instead of %d\n", n, info.freemem);
 1ac:	85a6                	mv	a1,s1
 1ae:	00001517          	auipc	a0,0x1
 1b2:	a8250513          	add	a0,a0,-1406 # c30 <malloc+0x152>
 1b6:	00001097          	auipc	ra,0x1
 1ba:	870080e7          	jalr	-1936(ra) # a26 <printf>
    exit(1);
 1be:	4505                	li	a0,1
 1c0:	00000097          	auipc	ra,0x0
 1c4:	4de080e7          	jalr	1246(ra) # 69e <exit>

00000000000001c8 <testcall>:

void
testcall() {
 1c8:	1101                	add	sp,sp,-32
 1ca:	ec06                	sd	ra,24(sp)
 1cc:	e822                	sd	s0,16(sp)
 1ce:	1000                	add	s0,sp,32
  struct sysinfo info;
  
  if (sysinfo(&info) < 0) {
 1d0:	fe040513          	add	a0,s0,-32
 1d4:	00000097          	auipc	ra,0x0
 1d8:	572080e7          	jalr	1394(ra) # 746 <sysinfo>
 1dc:	02054163          	bltz	a0,1fe <testcall+0x36>
    printf("FAIL: sysinfo failed\n");
    exit(1);
  }

  if (sysinfo((struct sysinfo *) 0xeaeb0b5b00002f5e) !=  0xffffffffffffffff) {
 1e0:	00001517          	auipc	a0,0x1
 1e4:	9f053503          	ld	a0,-1552(a0) # bd0 <malloc+0xf2>
 1e8:	00000097          	auipc	ra,0x0
 1ec:	55e080e7          	jalr	1374(ra) # 746 <sysinfo>
 1f0:	57fd                	li	a5,-1
 1f2:	02f51363          	bne	a0,a5,218 <testcall+0x50>
    printf("FAIL: sysinfo succeeded with bad argument\n");
    exit(1);
  }
}
 1f6:	60e2                	ld	ra,24(sp)
 1f8:	6442                	ld	s0,16(sp)
 1fa:	6105                	add	sp,sp,32
 1fc:	8082                	ret
    printf("FAIL: sysinfo failed\n");
 1fe:	00001517          	auipc	a0,0x1
 202:	a7250513          	add	a0,a0,-1422 # c70 <malloc+0x192>
 206:	00001097          	auipc	ra,0x1
 20a:	820080e7          	jalr	-2016(ra) # a26 <printf>
    exit(1);
 20e:	4505                	li	a0,1
 210:	00000097          	auipc	ra,0x0
 214:	48e080e7          	jalr	1166(ra) # 69e <exit>
    printf("FAIL: sysinfo succeeded with bad argument\n");
 218:	00001517          	auipc	a0,0x1
 21c:	a7050513          	add	a0,a0,-1424 # c88 <malloc+0x1aa>
 220:	00001097          	auipc	ra,0x1
 224:	806080e7          	jalr	-2042(ra) # a26 <printf>
    exit(1);
 228:	4505                	li	a0,1
 22a:	00000097          	auipc	ra,0x0
 22e:	474080e7          	jalr	1140(ra) # 69e <exit>

0000000000000232 <testproc>:

void testproc() {
 232:	7139                	add	sp,sp,-64
 234:	fc06                	sd	ra,56(sp)
 236:	f822                	sd	s0,48(sp)
 238:	f426                	sd	s1,40(sp)
 23a:	0080                	add	s0,sp,64
  struct sysinfo info;
  uint64 nproc;
  int status;
  int pid;
  
  sinfo(&info);
 23c:	fd040513          	add	a0,s0,-48
 240:	00000097          	auipc	ra,0x0
 244:	dc0080e7          	jalr	-576(ra) # 0 <sinfo>
  nproc = info.nproc;
 248:	fd843483          	ld	s1,-40(s0)

  pid = fork();
 24c:	00000097          	auipc	ra,0x0
 250:	44a080e7          	jalr	1098(ra) # 696 <fork>
  if(pid < 0){
 254:	02054c63          	bltz	a0,28c <testproc+0x5a>
    printf("sysinfotest: fork failed\n");
    exit(1);
  }
  if(pid == 0){
 258:	ed21                	bnez	a0,2b0 <testproc+0x7e>
    sinfo(&info);
 25a:	fd040513          	add	a0,s0,-48
 25e:	00000097          	auipc	ra,0x0
 262:	da2080e7          	jalr	-606(ra) # 0 <sinfo>
    if(info.nproc != nproc+1) {
 266:	fd843583          	ld	a1,-40(s0)
 26a:	00148613          	add	a2,s1,1
 26e:	02c58c63          	beq	a1,a2,2a6 <testproc+0x74>
      printf("sysinfotest: FAIL nproc is %d instead of %d\n", info.nproc, nproc+1);
 272:	00001517          	auipc	a0,0x1
 276:	a6650513          	add	a0,a0,-1434 # cd8 <malloc+0x1fa>
 27a:	00000097          	auipc	ra,0x0
 27e:	7ac080e7          	jalr	1964(ra) # a26 <printf>
      exit(1);
 282:	4505                	li	a0,1
 284:	00000097          	auipc	ra,0x0
 288:	41a080e7          	jalr	1050(ra) # 69e <exit>
    printf("sysinfotest: fork failed\n");
 28c:	00001517          	auipc	a0,0x1
 290:	a2c50513          	add	a0,a0,-1492 # cb8 <malloc+0x1da>
 294:	00000097          	auipc	ra,0x0
 298:	792080e7          	jalr	1938(ra) # a26 <printf>
    exit(1);
 29c:	4505                	li	a0,1
 29e:	00000097          	auipc	ra,0x0
 2a2:	400080e7          	jalr	1024(ra) # 69e <exit>
    }
    exit(0);
 2a6:	4501                	li	a0,0
 2a8:	00000097          	auipc	ra,0x0
 2ac:	3f6080e7          	jalr	1014(ra) # 69e <exit>
  }
  wait(&status);
 2b0:	fcc40513          	add	a0,s0,-52
 2b4:	00000097          	auipc	ra,0x0
 2b8:	3f2080e7          	jalr	1010(ra) # 6a6 <wait>
  sinfo(&info);
 2bc:	fd040513          	add	a0,s0,-48
 2c0:	00000097          	auipc	ra,0x0
 2c4:	d40080e7          	jalr	-704(ra) # 0 <sinfo>
  if(info.nproc != nproc) {
 2c8:	fd843583          	ld	a1,-40(s0)
 2cc:	00959763          	bne	a1,s1,2da <testproc+0xa8>
      printf("sysinfotest: FAIL nproc is %d instead of %d\n", info.nproc, nproc);
      exit(1);
  }
}
 2d0:	70e2                	ld	ra,56(sp)
 2d2:	7442                	ld	s0,48(sp)
 2d4:	74a2                	ld	s1,40(sp)
 2d6:	6121                	add	sp,sp,64
 2d8:	8082                	ret
      printf("sysinfotest: FAIL nproc is %d instead of %d\n", info.nproc, nproc);
 2da:	8626                	mv	a2,s1
 2dc:	00001517          	auipc	a0,0x1
 2e0:	9fc50513          	add	a0,a0,-1540 # cd8 <malloc+0x1fa>
 2e4:	00000097          	auipc	ra,0x0
 2e8:	742080e7          	jalr	1858(ra) # a26 <printf>
      exit(1);
 2ec:	4505                	li	a0,1
 2ee:	00000097          	auipc	ra,0x0
 2f2:	3b0080e7          	jalr	944(ra) # 69e <exit>

00000000000002f6 <testbad>:

void testbad() {
 2f6:	1101                	add	sp,sp,-32
 2f8:	ec06                	sd	ra,24(sp)
 2fa:	e822                	sd	s0,16(sp)
 2fc:	1000                	add	s0,sp,32
  int pid = fork();
 2fe:	00000097          	auipc	ra,0x0
 302:	398080e7          	jalr	920(ra) # 696 <fork>
  int xstatus;
  
  if(pid < 0){
 306:	00054c63          	bltz	a0,31e <testbad+0x28>
    printf("sysinfotest: fork failed\n");
    exit(1);
  }
  if(pid == 0){
 30a:	e51d                	bnez	a0,338 <testbad+0x42>
      sinfo(0x0);
 30c:	00000097          	auipc	ra,0x0
 310:	cf4080e7          	jalr	-780(ra) # 0 <sinfo>
      exit(0);
 314:	4501                	li	a0,0
 316:	00000097          	auipc	ra,0x0
 31a:	388080e7          	jalr	904(ra) # 69e <exit>
    printf("sysinfotest: fork failed\n");
 31e:	00001517          	auipc	a0,0x1
 322:	99a50513          	add	a0,a0,-1638 # cb8 <malloc+0x1da>
 326:	00000097          	auipc	ra,0x0
 32a:	700080e7          	jalr	1792(ra) # a26 <printf>
    exit(1);
 32e:	4505                	li	a0,1
 330:	00000097          	auipc	ra,0x0
 334:	36e080e7          	jalr	878(ra) # 69e <exit>
  }
  wait(&xstatus);
 338:	fec40513          	add	a0,s0,-20
 33c:	00000097          	auipc	ra,0x0
 340:	36a080e7          	jalr	874(ra) # 6a6 <wait>
  if(xstatus == -1)  // kernel killed child?
 344:	fec42583          	lw	a1,-20(s0)
 348:	57fd                	li	a5,-1
 34a:	02f58063          	beq	a1,a5,36a <testbad+0x74>
    exit(0);
  else {
    printf("sysinfotest: testbad succeeded %d\n", xstatus);
 34e:	00001517          	auipc	a0,0x1
 352:	9ba50513          	add	a0,a0,-1606 # d08 <malloc+0x22a>
 356:	00000097          	auipc	ra,0x0
 35a:	6d0080e7          	jalr	1744(ra) # a26 <printf>
    exit(xstatus);
 35e:	fec42503          	lw	a0,-20(s0)
 362:	00000097          	auipc	ra,0x0
 366:	33c080e7          	jalr	828(ra) # 69e <exit>
    exit(0);
 36a:	4501                	li	a0,0
 36c:	00000097          	auipc	ra,0x0
 370:	332080e7          	jalr	818(ra) # 69e <exit>

0000000000000374 <main>:
  }
}

int
main(int argc, char *argv[])
{
 374:	1141                	add	sp,sp,-16
 376:	e406                	sd	ra,8(sp)
 378:	e022                	sd	s0,0(sp)
 37a:	0800                	add	s0,sp,16
  printf("sysinfotest: start\n");
 37c:	00001517          	auipc	a0,0x1
 380:	9b450513          	add	a0,a0,-1612 # d30 <malloc+0x252>
 384:	00000097          	auipc	ra,0x0
 388:	6a2080e7          	jalr	1698(ra) # a26 <printf>
  testcall();
 38c:	00000097          	auipc	ra,0x0
 390:	e3c080e7          	jalr	-452(ra) # 1c8 <testcall>
  testmem();
 394:	00000097          	auipc	ra,0x0
 398:	d2c080e7          	jalr	-724(ra) # c0 <testmem>
  testproc();
 39c:	00000097          	auipc	ra,0x0
 3a0:	e96080e7          	jalr	-362(ra) # 232 <testproc>
  printf("sysinfotest: OK\n");
 3a4:	00001517          	auipc	a0,0x1
 3a8:	9a450513          	add	a0,a0,-1628 # d48 <malloc+0x26a>
 3ac:	00000097          	auipc	ra,0x0
 3b0:	67a080e7          	jalr	1658(ra) # a26 <printf>
  exit(0);
 3b4:	4501                	li	a0,0
 3b6:	00000097          	auipc	ra,0x0
 3ba:	2e8080e7          	jalr	744(ra) # 69e <exit>

00000000000003be <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 3be:	1141                	add	sp,sp,-16
 3c0:	e406                	sd	ra,8(sp)
 3c2:	e022                	sd	s0,0(sp)
 3c4:	0800                	add	s0,sp,16
  extern int main();
  main();
 3c6:	00000097          	auipc	ra,0x0
 3ca:	fae080e7          	jalr	-82(ra) # 374 <main>
  exit(0);
 3ce:	4501                	li	a0,0
 3d0:	00000097          	auipc	ra,0x0
 3d4:	2ce080e7          	jalr	718(ra) # 69e <exit>

00000000000003d8 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 3d8:	1141                	add	sp,sp,-16
 3da:	e422                	sd	s0,8(sp)
 3dc:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 3de:	87aa                	mv	a5,a0
 3e0:	0585                	add	a1,a1,1 # fffffffffffff001 <base+0xffffffffffffdff1>
 3e2:	0785                	add	a5,a5,1
 3e4:	fff5c703          	lbu	a4,-1(a1)
 3e8:	fee78fa3          	sb	a4,-1(a5)
 3ec:	fb75                	bnez	a4,3e0 <strcpy+0x8>
    ;
  return os;
}
 3ee:	6422                	ld	s0,8(sp)
 3f0:	0141                	add	sp,sp,16
 3f2:	8082                	ret

00000000000003f4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3f4:	1141                	add	sp,sp,-16
 3f6:	e422                	sd	s0,8(sp)
 3f8:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 3fa:	00054783          	lbu	a5,0(a0)
 3fe:	cb91                	beqz	a5,412 <strcmp+0x1e>
 400:	0005c703          	lbu	a4,0(a1)
 404:	00f71763          	bne	a4,a5,412 <strcmp+0x1e>
    p++, q++;
 408:	0505                	add	a0,a0,1
 40a:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 40c:	00054783          	lbu	a5,0(a0)
 410:	fbe5                	bnez	a5,400 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 412:	0005c503          	lbu	a0,0(a1)
}
 416:	40a7853b          	subw	a0,a5,a0
 41a:	6422                	ld	s0,8(sp)
 41c:	0141                	add	sp,sp,16
 41e:	8082                	ret

0000000000000420 <strlen>:

uint
strlen(const char *s)
{
 420:	1141                	add	sp,sp,-16
 422:	e422                	sd	s0,8(sp)
 424:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 426:	00054783          	lbu	a5,0(a0)
 42a:	cf91                	beqz	a5,446 <strlen+0x26>
 42c:	0505                	add	a0,a0,1
 42e:	87aa                	mv	a5,a0
 430:	86be                	mv	a3,a5
 432:	0785                	add	a5,a5,1
 434:	fff7c703          	lbu	a4,-1(a5)
 438:	ff65                	bnez	a4,430 <strlen+0x10>
 43a:	40a6853b          	subw	a0,a3,a0
 43e:	2505                	addw	a0,a0,1
    ;
  return n;
}
 440:	6422                	ld	s0,8(sp)
 442:	0141                	add	sp,sp,16
 444:	8082                	ret
  for(n = 0; s[n]; n++)
 446:	4501                	li	a0,0
 448:	bfe5                	j	440 <strlen+0x20>

000000000000044a <memset>:

void*
memset(void *dst, int c, uint n)
{
 44a:	1141                	add	sp,sp,-16
 44c:	e422                	sd	s0,8(sp)
 44e:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 450:	ca19                	beqz	a2,466 <memset+0x1c>
 452:	87aa                	mv	a5,a0
 454:	1602                	sll	a2,a2,0x20
 456:	9201                	srl	a2,a2,0x20
 458:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 45c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 460:	0785                	add	a5,a5,1
 462:	fee79de3          	bne	a5,a4,45c <memset+0x12>
  }
  return dst;
}
 466:	6422                	ld	s0,8(sp)
 468:	0141                	add	sp,sp,16
 46a:	8082                	ret

000000000000046c <strchr>:

char*
strchr(const char *s, char c)
{
 46c:	1141                	add	sp,sp,-16
 46e:	e422                	sd	s0,8(sp)
 470:	0800                	add	s0,sp,16
  for(; *s; s++)
 472:	00054783          	lbu	a5,0(a0)
 476:	cb99                	beqz	a5,48c <strchr+0x20>
    if(*s == c)
 478:	00f58763          	beq	a1,a5,486 <strchr+0x1a>
  for(; *s; s++)
 47c:	0505                	add	a0,a0,1
 47e:	00054783          	lbu	a5,0(a0)
 482:	fbfd                	bnez	a5,478 <strchr+0xc>
      return (char*)s;
  return 0;
 484:	4501                	li	a0,0
}
 486:	6422                	ld	s0,8(sp)
 488:	0141                	add	sp,sp,16
 48a:	8082                	ret
  return 0;
 48c:	4501                	li	a0,0
 48e:	bfe5                	j	486 <strchr+0x1a>

0000000000000490 <strstr>:

char*
strstr(const char *str, const char *substr)
{
 490:	1141                	add	sp,sp,-16
 492:	e422                	sd	s0,8(sp)
 494:	0800                	add	s0,sp,16
  const char *a, *b = substr;
  if (*b == 0)
 496:	0005c803          	lbu	a6,0(a1)
 49a:	02080a63          	beqz	a6,4ce <strstr+0x3e>
    return (char*)str;
  for( ; *str != 0; str += 1) {
 49e:	00054783          	lbu	a5,0(a0)
 4a2:	e799                	bnez	a5,4b0 <strstr+0x20>
      if (*a++ != *b++)
        break;
    }
    b = substr;
  }
  return 0;
 4a4:	4501                	li	a0,0
 4a6:	a025                	j	4ce <strstr+0x3e>
  for( ; *str != 0; str += 1) {
 4a8:	0505                	add	a0,a0,1
 4aa:	00054783          	lbu	a5,0(a0)
 4ae:	cf99                	beqz	a5,4cc <strstr+0x3c>
    if (*str != *b)
 4b0:	fef81ce3          	bne	a6,a5,4a8 <strstr+0x18>
 4b4:	87ae                	mv	a5,a1
 4b6:	86aa                	mv	a3,a0
      if (*b == 0)
 4b8:	0007c703          	lbu	a4,0(a5)
 4bc:	cb09                	beqz	a4,4ce <strstr+0x3e>
      if (*a++ != *b++)
 4be:	0685                	add	a3,a3,1
 4c0:	0785                	add	a5,a5,1
 4c2:	fff6c603          	lbu	a2,-1(a3)
 4c6:	fee609e3          	beq	a2,a4,4b8 <strstr+0x28>
 4ca:	bff9                	j	4a8 <strstr+0x18>
  return 0;
 4cc:	4501                	li	a0,0
}
 4ce:	6422                	ld	s0,8(sp)
 4d0:	0141                	add	sp,sp,16
 4d2:	8082                	ret

00000000000004d4 <gets>:

char*
gets(char *buf, int max)
{
 4d4:	711d                	add	sp,sp,-96
 4d6:	ec86                	sd	ra,88(sp)
 4d8:	e8a2                	sd	s0,80(sp)
 4da:	e4a6                	sd	s1,72(sp)
 4dc:	e0ca                	sd	s2,64(sp)
 4de:	fc4e                	sd	s3,56(sp)
 4e0:	f852                	sd	s4,48(sp)
 4e2:	f456                	sd	s5,40(sp)
 4e4:	f05a                	sd	s6,32(sp)
 4e6:	ec5e                	sd	s7,24(sp)
 4e8:	1080                	add	s0,sp,96
 4ea:	8baa                	mv	s7,a0
 4ec:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4ee:	892a                	mv	s2,a0
 4f0:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 4f2:	4aa9                	li	s5,10
 4f4:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 4f6:	89a6                	mv	s3,s1
 4f8:	2485                	addw	s1,s1,1
 4fa:	0344d863          	bge	s1,s4,52a <gets+0x56>
    cc = read(0, &c, 1);
 4fe:	4605                	li	a2,1
 500:	faf40593          	add	a1,s0,-81
 504:	4501                	li	a0,0
 506:	00000097          	auipc	ra,0x0
 50a:	1b0080e7          	jalr	432(ra) # 6b6 <read>
    if(cc < 1)
 50e:	00a05e63          	blez	a0,52a <gets+0x56>
    buf[i++] = c;
 512:	faf44783          	lbu	a5,-81(s0)
 516:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 51a:	01578763          	beq	a5,s5,528 <gets+0x54>
 51e:	0905                	add	s2,s2,1
 520:	fd679be3          	bne	a5,s6,4f6 <gets+0x22>
  for(i=0; i+1 < max; ){
 524:	89a6                	mv	s3,s1
 526:	a011                	j	52a <gets+0x56>
 528:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 52a:	99de                	add	s3,s3,s7
 52c:	00098023          	sb	zero,0(s3) # 1000 <freep>
  return buf;
}
 530:	855e                	mv	a0,s7
 532:	60e6                	ld	ra,88(sp)
 534:	6446                	ld	s0,80(sp)
 536:	64a6                	ld	s1,72(sp)
 538:	6906                	ld	s2,64(sp)
 53a:	79e2                	ld	s3,56(sp)
 53c:	7a42                	ld	s4,48(sp)
 53e:	7aa2                	ld	s5,40(sp)
 540:	7b02                	ld	s6,32(sp)
 542:	6be2                	ld	s7,24(sp)
 544:	6125                	add	sp,sp,96
 546:	8082                	ret

0000000000000548 <stat>:

int
stat(const char *n, struct stat *st)
{
 548:	1101                	add	sp,sp,-32
 54a:	ec06                	sd	ra,24(sp)
 54c:	e822                	sd	s0,16(sp)
 54e:	e426                	sd	s1,8(sp)
 550:	e04a                	sd	s2,0(sp)
 552:	1000                	add	s0,sp,32
 554:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 556:	4581                	li	a1,0
 558:	00000097          	auipc	ra,0x0
 55c:	186080e7          	jalr	390(ra) # 6de <open>
  if(fd < 0)
 560:	02054563          	bltz	a0,58a <stat+0x42>
 564:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 566:	85ca                	mv	a1,s2
 568:	00000097          	auipc	ra,0x0
 56c:	18e080e7          	jalr	398(ra) # 6f6 <fstat>
 570:	892a                	mv	s2,a0
  close(fd);
 572:	8526                	mv	a0,s1
 574:	00000097          	auipc	ra,0x0
 578:	152080e7          	jalr	338(ra) # 6c6 <close>
  return r;
}
 57c:	854a                	mv	a0,s2
 57e:	60e2                	ld	ra,24(sp)
 580:	6442                	ld	s0,16(sp)
 582:	64a2                	ld	s1,8(sp)
 584:	6902                	ld	s2,0(sp)
 586:	6105                	add	sp,sp,32
 588:	8082                	ret
    return -1;
 58a:	597d                	li	s2,-1
 58c:	bfc5                	j	57c <stat+0x34>

000000000000058e <atoi>:

int
atoi(const char *s)
{
 58e:	1141                	add	sp,sp,-16
 590:	e422                	sd	s0,8(sp)
 592:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 594:	00054683          	lbu	a3,0(a0)
 598:	fd06879b          	addw	a5,a3,-48
 59c:	0ff7f793          	zext.b	a5,a5
 5a0:	4625                	li	a2,9
 5a2:	02f66863          	bltu	a2,a5,5d2 <atoi+0x44>
 5a6:	872a                	mv	a4,a0
  n = 0;
 5a8:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 5aa:	0705                	add	a4,a4,1
 5ac:	0025179b          	sllw	a5,a0,0x2
 5b0:	9fa9                	addw	a5,a5,a0
 5b2:	0017979b          	sllw	a5,a5,0x1
 5b6:	9fb5                	addw	a5,a5,a3
 5b8:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 5bc:	00074683          	lbu	a3,0(a4)
 5c0:	fd06879b          	addw	a5,a3,-48
 5c4:	0ff7f793          	zext.b	a5,a5
 5c8:	fef671e3          	bgeu	a2,a5,5aa <atoi+0x1c>
  return n;
}
 5cc:	6422                	ld	s0,8(sp)
 5ce:	0141                	add	sp,sp,16
 5d0:	8082                	ret
  n = 0;
 5d2:	4501                	li	a0,0
 5d4:	bfe5                	j	5cc <atoi+0x3e>

00000000000005d6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5d6:	1141                	add	sp,sp,-16
 5d8:	e422                	sd	s0,8(sp)
 5da:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 5dc:	02b57463          	bgeu	a0,a1,604 <memmove+0x2e>
    while(n-- > 0)
 5e0:	00c05f63          	blez	a2,5fe <memmove+0x28>
 5e4:	1602                	sll	a2,a2,0x20
 5e6:	9201                	srl	a2,a2,0x20
 5e8:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 5ec:	872a                	mv	a4,a0
      *dst++ = *src++;
 5ee:	0585                	add	a1,a1,1
 5f0:	0705                	add	a4,a4,1
 5f2:	fff5c683          	lbu	a3,-1(a1)
 5f6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 5fa:	fee79ae3          	bne	a5,a4,5ee <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 5fe:	6422                	ld	s0,8(sp)
 600:	0141                	add	sp,sp,16
 602:	8082                	ret
    dst += n;
 604:	00c50733          	add	a4,a0,a2
    src += n;
 608:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 60a:	fec05ae3          	blez	a2,5fe <memmove+0x28>
 60e:	fff6079b          	addw	a5,a2,-1
 612:	1782                	sll	a5,a5,0x20
 614:	9381                	srl	a5,a5,0x20
 616:	fff7c793          	not	a5,a5
 61a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 61c:	15fd                	add	a1,a1,-1
 61e:	177d                	add	a4,a4,-1
 620:	0005c683          	lbu	a3,0(a1)
 624:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 628:	fee79ae3          	bne	a5,a4,61c <memmove+0x46>
 62c:	bfc9                	j	5fe <memmove+0x28>

000000000000062e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 62e:	1141                	add	sp,sp,-16
 630:	e422                	sd	s0,8(sp)
 632:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 634:	ca05                	beqz	a2,664 <memcmp+0x36>
 636:	fff6069b          	addw	a3,a2,-1
 63a:	1682                	sll	a3,a3,0x20
 63c:	9281                	srl	a3,a3,0x20
 63e:	0685                	add	a3,a3,1
 640:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 642:	00054783          	lbu	a5,0(a0)
 646:	0005c703          	lbu	a4,0(a1)
 64a:	00e79863          	bne	a5,a4,65a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 64e:	0505                	add	a0,a0,1
    p2++;
 650:	0585                	add	a1,a1,1
  while (n-- > 0) {
 652:	fed518e3          	bne	a0,a3,642 <memcmp+0x14>
  }
  return 0;
 656:	4501                	li	a0,0
 658:	a019                	j	65e <memcmp+0x30>
      return *p1 - *p2;
 65a:	40e7853b          	subw	a0,a5,a4
}
 65e:	6422                	ld	s0,8(sp)
 660:	0141                	add	sp,sp,16
 662:	8082                	ret
  return 0;
 664:	4501                	li	a0,0
 666:	bfe5                	j	65e <memcmp+0x30>

0000000000000668 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 668:	1141                	add	sp,sp,-16
 66a:	e406                	sd	ra,8(sp)
 66c:	e022                	sd	s0,0(sp)
 66e:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 670:	00000097          	auipc	ra,0x0
 674:	f66080e7          	jalr	-154(ra) # 5d6 <memmove>
}
 678:	60a2                	ld	ra,8(sp)
 67a:	6402                	ld	s0,0(sp)
 67c:	0141                	add	sp,sp,16
 67e:	8082                	ret

0000000000000680 <ugetpid>:

int
ugetpid(void)
{
 680:	1141                	add	sp,sp,-16
 682:	e422                	sd	s0,8(sp)
 684:	0800                	add	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 686:	040007b7          	lui	a5,0x4000
}
 68a:	17f5                	add	a5,a5,-3 # 3fffffd <base+0x3ffefed>
 68c:	07b2                	sll	a5,a5,0xc
 68e:	4388                	lw	a0,0(a5)
 690:	6422                	ld	s0,8(sp)
 692:	0141                	add	sp,sp,16
 694:	8082                	ret

0000000000000696 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 696:	4885                	li	a7,1
 ecall
 698:	00000073          	ecall
 ret
 69c:	8082                	ret

000000000000069e <exit>:
.global exit
exit:
 li a7, SYS_exit
 69e:	4889                	li	a7,2
 ecall
 6a0:	00000073          	ecall
 ret
 6a4:	8082                	ret

00000000000006a6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 6a6:	488d                	li	a7,3
 ecall
 6a8:	00000073          	ecall
 ret
 6ac:	8082                	ret

00000000000006ae <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6ae:	4891                	li	a7,4
 ecall
 6b0:	00000073          	ecall
 ret
 6b4:	8082                	ret

00000000000006b6 <read>:
.global read
read:
 li a7, SYS_read
 6b6:	4895                	li	a7,5
 ecall
 6b8:	00000073          	ecall
 ret
 6bc:	8082                	ret

00000000000006be <write>:
.global write
write:
 li a7, SYS_write
 6be:	48c1                	li	a7,16
 ecall
 6c0:	00000073          	ecall
 ret
 6c4:	8082                	ret

00000000000006c6 <close>:
.global close
close:
 li a7, SYS_close
 6c6:	48d5                	li	a7,21
 ecall
 6c8:	00000073          	ecall
 ret
 6cc:	8082                	ret

00000000000006ce <kill>:
.global kill
kill:
 li a7, SYS_kill
 6ce:	4899                	li	a7,6
 ecall
 6d0:	00000073          	ecall
 ret
 6d4:	8082                	ret

00000000000006d6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 6d6:	489d                	li	a7,7
 ecall
 6d8:	00000073          	ecall
 ret
 6dc:	8082                	ret

00000000000006de <open>:
.global open
open:
 li a7, SYS_open
 6de:	48bd                	li	a7,15
 ecall
 6e0:	00000073          	ecall
 ret
 6e4:	8082                	ret

00000000000006e6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6e6:	48c5                	li	a7,17
 ecall
 6e8:	00000073          	ecall
 ret
 6ec:	8082                	ret

00000000000006ee <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6ee:	48c9                	li	a7,18
 ecall
 6f0:	00000073          	ecall
 ret
 6f4:	8082                	ret

00000000000006f6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6f6:	48a1                	li	a7,8
 ecall
 6f8:	00000073          	ecall
 ret
 6fc:	8082                	ret

00000000000006fe <link>:
.global link
link:
 li a7, SYS_link
 6fe:	48cd                	li	a7,19
 ecall
 700:	00000073          	ecall
 ret
 704:	8082                	ret

0000000000000706 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 706:	48d1                	li	a7,20
 ecall
 708:	00000073          	ecall
 ret
 70c:	8082                	ret

000000000000070e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 70e:	48a5                	li	a7,9
 ecall
 710:	00000073          	ecall
 ret
 714:	8082                	ret

0000000000000716 <dup>:
.global dup
dup:
 li a7, SYS_dup
 716:	48a9                	li	a7,10
 ecall
 718:	00000073          	ecall
 ret
 71c:	8082                	ret

000000000000071e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 71e:	48ad                	li	a7,11
 ecall
 720:	00000073          	ecall
 ret
 724:	8082                	ret

0000000000000726 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 726:	48b1                	li	a7,12
 ecall
 728:	00000073          	ecall
 ret
 72c:	8082                	ret

000000000000072e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 72e:	48b5                	li	a7,13
 ecall
 730:	00000073          	ecall
 ret
 734:	8082                	ret

0000000000000736 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 736:	48b9                	li	a7,14
 ecall
 738:	00000073          	ecall
 ret
 73c:	8082                	ret

000000000000073e <trace>:
.global trace
trace:
 li a7, SYS_trace
 73e:	48d9                	li	a7,22
 ecall
 740:	00000073          	ecall
 ret
 744:	8082                	ret

0000000000000746 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 746:	48dd                	li	a7,23
 ecall
 748:	00000073          	ecall
 ret
 74c:	8082                	ret

000000000000074e <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 74e:	48e1                	li	a7,24
 ecall
 750:	00000073          	ecall
 ret
 754:	8082                	ret

0000000000000756 <setpriority>:
.global setpriority
setpriority:
 li a7, SYS_setpriority
 756:	48e5                	li	a7,25
 ecall
 758:	00000073          	ecall
 ret
 75c:	8082                	ret

000000000000075e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 75e:	1101                	add	sp,sp,-32
 760:	ec06                	sd	ra,24(sp)
 762:	e822                	sd	s0,16(sp)
 764:	1000                	add	s0,sp,32
 766:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 76a:	4605                	li	a2,1
 76c:	fef40593          	add	a1,s0,-17
 770:	00000097          	auipc	ra,0x0
 774:	f4e080e7          	jalr	-178(ra) # 6be <write>
}
 778:	60e2                	ld	ra,24(sp)
 77a:	6442                	ld	s0,16(sp)
 77c:	6105                	add	sp,sp,32
 77e:	8082                	ret

0000000000000780 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 780:	7139                	add	sp,sp,-64
 782:	fc06                	sd	ra,56(sp)
 784:	f822                	sd	s0,48(sp)
 786:	f426                	sd	s1,40(sp)
 788:	f04a                	sd	s2,32(sp)
 78a:	ec4e                	sd	s3,24(sp)
 78c:	0080                	add	s0,sp,64
 78e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 790:	c299                	beqz	a3,796 <printint+0x16>
 792:	0805c963          	bltz	a1,824 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 796:	2581                	sext.w	a1,a1
  neg = 0;
 798:	4881                	li	a7,0
 79a:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 79e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7a0:	2601                	sext.w	a2,a2
 7a2:	00000517          	auipc	a0,0x0
 7a6:	61e50513          	add	a0,a0,1566 # dc0 <digits>
 7aa:	883a                	mv	a6,a4
 7ac:	2705                	addw	a4,a4,1
 7ae:	02c5f7bb          	remuw	a5,a1,a2
 7b2:	1782                	sll	a5,a5,0x20
 7b4:	9381                	srl	a5,a5,0x20
 7b6:	97aa                	add	a5,a5,a0
 7b8:	0007c783          	lbu	a5,0(a5)
 7bc:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7c0:	0005879b          	sext.w	a5,a1
 7c4:	02c5d5bb          	divuw	a1,a1,a2
 7c8:	0685                	add	a3,a3,1
 7ca:	fec7f0e3          	bgeu	a5,a2,7aa <printint+0x2a>
  if(neg)
 7ce:	00088c63          	beqz	a7,7e6 <printint+0x66>
    buf[i++] = '-';
 7d2:	fd070793          	add	a5,a4,-48
 7d6:	00878733          	add	a4,a5,s0
 7da:	02d00793          	li	a5,45
 7de:	fef70823          	sb	a5,-16(a4)
 7e2:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 7e6:	02e05863          	blez	a4,816 <printint+0x96>
 7ea:	fc040793          	add	a5,s0,-64
 7ee:	00e78933          	add	s2,a5,a4
 7f2:	fff78993          	add	s3,a5,-1
 7f6:	99ba                	add	s3,s3,a4
 7f8:	377d                	addw	a4,a4,-1
 7fa:	1702                	sll	a4,a4,0x20
 7fc:	9301                	srl	a4,a4,0x20
 7fe:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 802:	fff94583          	lbu	a1,-1(s2)
 806:	8526                	mv	a0,s1
 808:	00000097          	auipc	ra,0x0
 80c:	f56080e7          	jalr	-170(ra) # 75e <putc>
  while(--i >= 0)
 810:	197d                	add	s2,s2,-1
 812:	ff3918e3          	bne	s2,s3,802 <printint+0x82>
}
 816:	70e2                	ld	ra,56(sp)
 818:	7442                	ld	s0,48(sp)
 81a:	74a2                	ld	s1,40(sp)
 81c:	7902                	ld	s2,32(sp)
 81e:	69e2                	ld	s3,24(sp)
 820:	6121                	add	sp,sp,64
 822:	8082                	ret
    x = -xx;
 824:	40b005bb          	negw	a1,a1
    neg = 1;
 828:	4885                	li	a7,1
    x = -xx;
 82a:	bf85                	j	79a <printint+0x1a>

000000000000082c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 82c:	715d                	add	sp,sp,-80
 82e:	e486                	sd	ra,72(sp)
 830:	e0a2                	sd	s0,64(sp)
 832:	fc26                	sd	s1,56(sp)
 834:	f84a                	sd	s2,48(sp)
 836:	f44e                	sd	s3,40(sp)
 838:	f052                	sd	s4,32(sp)
 83a:	ec56                	sd	s5,24(sp)
 83c:	e85a                	sd	s6,16(sp)
 83e:	e45e                	sd	s7,8(sp)
 840:	e062                	sd	s8,0(sp)
 842:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 844:	0005c903          	lbu	s2,0(a1)
 848:	18090c63          	beqz	s2,9e0 <vprintf+0x1b4>
 84c:	8aaa                	mv	s5,a0
 84e:	8bb2                	mv	s7,a2
 850:	00158493          	add	s1,a1,1
  state = 0;
 854:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 856:	02500a13          	li	s4,37
 85a:	4b55                	li	s6,21
 85c:	a839                	j	87a <vprintf+0x4e>
        putc(fd, c);
 85e:	85ca                	mv	a1,s2
 860:	8556                	mv	a0,s5
 862:	00000097          	auipc	ra,0x0
 866:	efc080e7          	jalr	-260(ra) # 75e <putc>
 86a:	a019                	j	870 <vprintf+0x44>
    } else if(state == '%'){
 86c:	01498d63          	beq	s3,s4,886 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 870:	0485                	add	s1,s1,1
 872:	fff4c903          	lbu	s2,-1(s1)
 876:	16090563          	beqz	s2,9e0 <vprintf+0x1b4>
    if(state == 0){
 87a:	fe0999e3          	bnez	s3,86c <vprintf+0x40>
      if(c == '%'){
 87e:	ff4910e3          	bne	s2,s4,85e <vprintf+0x32>
        state = '%';
 882:	89d2                	mv	s3,s4
 884:	b7f5                	j	870 <vprintf+0x44>
      if(c == 'd'){
 886:	13490263          	beq	s2,s4,9aa <vprintf+0x17e>
 88a:	f9d9079b          	addw	a5,s2,-99
 88e:	0ff7f793          	zext.b	a5,a5
 892:	12fb6563          	bltu	s6,a5,9bc <vprintf+0x190>
 896:	f9d9079b          	addw	a5,s2,-99
 89a:	0ff7f713          	zext.b	a4,a5
 89e:	10eb6f63          	bltu	s6,a4,9bc <vprintf+0x190>
 8a2:	00271793          	sll	a5,a4,0x2
 8a6:	00000717          	auipc	a4,0x0
 8aa:	4c270713          	add	a4,a4,1218 # d68 <malloc+0x28a>
 8ae:	97ba                	add	a5,a5,a4
 8b0:	439c                	lw	a5,0(a5)
 8b2:	97ba                	add	a5,a5,a4
 8b4:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 8b6:	008b8913          	add	s2,s7,8
 8ba:	4685                	li	a3,1
 8bc:	4629                	li	a2,10
 8be:	000ba583          	lw	a1,0(s7)
 8c2:	8556                	mv	a0,s5
 8c4:	00000097          	auipc	ra,0x0
 8c8:	ebc080e7          	jalr	-324(ra) # 780 <printint>
 8cc:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8ce:	4981                	li	s3,0
 8d0:	b745                	j	870 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8d2:	008b8913          	add	s2,s7,8
 8d6:	4681                	li	a3,0
 8d8:	4629                	li	a2,10
 8da:	000ba583          	lw	a1,0(s7)
 8de:	8556                	mv	a0,s5
 8e0:	00000097          	auipc	ra,0x0
 8e4:	ea0080e7          	jalr	-352(ra) # 780 <printint>
 8e8:	8bca                	mv	s7,s2
      state = 0;
 8ea:	4981                	li	s3,0
 8ec:	b751                	j	870 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 8ee:	008b8913          	add	s2,s7,8
 8f2:	4681                	li	a3,0
 8f4:	4641                	li	a2,16
 8f6:	000ba583          	lw	a1,0(s7)
 8fa:	8556                	mv	a0,s5
 8fc:	00000097          	auipc	ra,0x0
 900:	e84080e7          	jalr	-380(ra) # 780 <printint>
 904:	8bca                	mv	s7,s2
      state = 0;
 906:	4981                	li	s3,0
 908:	b7a5                	j	870 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 90a:	008b8c13          	add	s8,s7,8
 90e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 912:	03000593          	li	a1,48
 916:	8556                	mv	a0,s5
 918:	00000097          	auipc	ra,0x0
 91c:	e46080e7          	jalr	-442(ra) # 75e <putc>
  putc(fd, 'x');
 920:	07800593          	li	a1,120
 924:	8556                	mv	a0,s5
 926:	00000097          	auipc	ra,0x0
 92a:	e38080e7          	jalr	-456(ra) # 75e <putc>
 92e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 930:	00000b97          	auipc	s7,0x0
 934:	490b8b93          	add	s7,s7,1168 # dc0 <digits>
 938:	03c9d793          	srl	a5,s3,0x3c
 93c:	97de                	add	a5,a5,s7
 93e:	0007c583          	lbu	a1,0(a5)
 942:	8556                	mv	a0,s5
 944:	00000097          	auipc	ra,0x0
 948:	e1a080e7          	jalr	-486(ra) # 75e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 94c:	0992                	sll	s3,s3,0x4
 94e:	397d                	addw	s2,s2,-1
 950:	fe0914e3          	bnez	s2,938 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 954:	8be2                	mv	s7,s8
      state = 0;
 956:	4981                	li	s3,0
 958:	bf21                	j	870 <vprintf+0x44>
        s = va_arg(ap, char*);
 95a:	008b8993          	add	s3,s7,8
 95e:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 962:	02090163          	beqz	s2,984 <vprintf+0x158>
        while(*s != 0){
 966:	00094583          	lbu	a1,0(s2)
 96a:	c9a5                	beqz	a1,9da <vprintf+0x1ae>
          putc(fd, *s);
 96c:	8556                	mv	a0,s5
 96e:	00000097          	auipc	ra,0x0
 972:	df0080e7          	jalr	-528(ra) # 75e <putc>
          s++;
 976:	0905                	add	s2,s2,1
        while(*s != 0){
 978:	00094583          	lbu	a1,0(s2)
 97c:	f9e5                	bnez	a1,96c <vprintf+0x140>
        s = va_arg(ap, char*);
 97e:	8bce                	mv	s7,s3
      state = 0;
 980:	4981                	li	s3,0
 982:	b5fd                	j	870 <vprintf+0x44>
          s = "(null)";
 984:	00000917          	auipc	s2,0x0
 988:	3dc90913          	add	s2,s2,988 # d60 <malloc+0x282>
        while(*s != 0){
 98c:	02800593          	li	a1,40
 990:	bff1                	j	96c <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 992:	008b8913          	add	s2,s7,8
 996:	000bc583          	lbu	a1,0(s7)
 99a:	8556                	mv	a0,s5
 99c:	00000097          	auipc	ra,0x0
 9a0:	dc2080e7          	jalr	-574(ra) # 75e <putc>
 9a4:	8bca                	mv	s7,s2
      state = 0;
 9a6:	4981                	li	s3,0
 9a8:	b5e1                	j	870 <vprintf+0x44>
        putc(fd, c);
 9aa:	02500593          	li	a1,37
 9ae:	8556                	mv	a0,s5
 9b0:	00000097          	auipc	ra,0x0
 9b4:	dae080e7          	jalr	-594(ra) # 75e <putc>
      state = 0;
 9b8:	4981                	li	s3,0
 9ba:	bd5d                	j	870 <vprintf+0x44>
        putc(fd, '%');
 9bc:	02500593          	li	a1,37
 9c0:	8556                	mv	a0,s5
 9c2:	00000097          	auipc	ra,0x0
 9c6:	d9c080e7          	jalr	-612(ra) # 75e <putc>
        putc(fd, c);
 9ca:	85ca                	mv	a1,s2
 9cc:	8556                	mv	a0,s5
 9ce:	00000097          	auipc	ra,0x0
 9d2:	d90080e7          	jalr	-624(ra) # 75e <putc>
      state = 0;
 9d6:	4981                	li	s3,0
 9d8:	bd61                	j	870 <vprintf+0x44>
        s = va_arg(ap, char*);
 9da:	8bce                	mv	s7,s3
      state = 0;
 9dc:	4981                	li	s3,0
 9de:	bd49                	j	870 <vprintf+0x44>
    }
  }
}
 9e0:	60a6                	ld	ra,72(sp)
 9e2:	6406                	ld	s0,64(sp)
 9e4:	74e2                	ld	s1,56(sp)
 9e6:	7942                	ld	s2,48(sp)
 9e8:	79a2                	ld	s3,40(sp)
 9ea:	7a02                	ld	s4,32(sp)
 9ec:	6ae2                	ld	s5,24(sp)
 9ee:	6b42                	ld	s6,16(sp)
 9f0:	6ba2                	ld	s7,8(sp)
 9f2:	6c02                	ld	s8,0(sp)
 9f4:	6161                	add	sp,sp,80
 9f6:	8082                	ret

00000000000009f8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9f8:	715d                	add	sp,sp,-80
 9fa:	ec06                	sd	ra,24(sp)
 9fc:	e822                	sd	s0,16(sp)
 9fe:	1000                	add	s0,sp,32
 a00:	e010                	sd	a2,0(s0)
 a02:	e414                	sd	a3,8(s0)
 a04:	e818                	sd	a4,16(s0)
 a06:	ec1c                	sd	a5,24(s0)
 a08:	03043023          	sd	a6,32(s0)
 a0c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a10:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a14:	8622                	mv	a2,s0
 a16:	00000097          	auipc	ra,0x0
 a1a:	e16080e7          	jalr	-490(ra) # 82c <vprintf>
}
 a1e:	60e2                	ld	ra,24(sp)
 a20:	6442                	ld	s0,16(sp)
 a22:	6161                	add	sp,sp,80
 a24:	8082                	ret

0000000000000a26 <printf>:

void
printf(const char *fmt, ...)
{
 a26:	711d                	add	sp,sp,-96
 a28:	ec06                	sd	ra,24(sp)
 a2a:	e822                	sd	s0,16(sp)
 a2c:	1000                	add	s0,sp,32
 a2e:	e40c                	sd	a1,8(s0)
 a30:	e810                	sd	a2,16(s0)
 a32:	ec14                	sd	a3,24(s0)
 a34:	f018                	sd	a4,32(s0)
 a36:	f41c                	sd	a5,40(s0)
 a38:	03043823          	sd	a6,48(s0)
 a3c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a40:	00840613          	add	a2,s0,8
 a44:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a48:	85aa                	mv	a1,a0
 a4a:	4505                	li	a0,1
 a4c:	00000097          	auipc	ra,0x0
 a50:	de0080e7          	jalr	-544(ra) # 82c <vprintf>
}
 a54:	60e2                	ld	ra,24(sp)
 a56:	6442                	ld	s0,16(sp)
 a58:	6125                	add	sp,sp,96
 a5a:	8082                	ret

0000000000000a5c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a5c:	1141                	add	sp,sp,-16
 a5e:	e422                	sd	s0,8(sp)
 a60:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a62:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a66:	00000797          	auipc	a5,0x0
 a6a:	59a7b783          	ld	a5,1434(a5) # 1000 <freep>
 a6e:	a02d                	j	a98 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a70:	4618                	lw	a4,8(a2)
 a72:	9f2d                	addw	a4,a4,a1
 a74:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a78:	6398                	ld	a4,0(a5)
 a7a:	6310                	ld	a2,0(a4)
 a7c:	a83d                	j	aba <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a7e:	ff852703          	lw	a4,-8(a0)
 a82:	9f31                	addw	a4,a4,a2
 a84:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a86:	ff053683          	ld	a3,-16(a0)
 a8a:	a091                	j	ace <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a8c:	6398                	ld	a4,0(a5)
 a8e:	00e7e463          	bltu	a5,a4,a96 <free+0x3a>
 a92:	00e6ea63          	bltu	a3,a4,aa6 <free+0x4a>
{
 a96:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a98:	fed7fae3          	bgeu	a5,a3,a8c <free+0x30>
 a9c:	6398                	ld	a4,0(a5)
 a9e:	00e6e463          	bltu	a3,a4,aa6 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aa2:	fee7eae3          	bltu	a5,a4,a96 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 aa6:	ff852583          	lw	a1,-8(a0)
 aaa:	6390                	ld	a2,0(a5)
 aac:	02059813          	sll	a6,a1,0x20
 ab0:	01c85713          	srl	a4,a6,0x1c
 ab4:	9736                	add	a4,a4,a3
 ab6:	fae60de3          	beq	a2,a4,a70 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 aba:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 abe:	4790                	lw	a2,8(a5)
 ac0:	02061593          	sll	a1,a2,0x20
 ac4:	01c5d713          	srl	a4,a1,0x1c
 ac8:	973e                	add	a4,a4,a5
 aca:	fae68ae3          	beq	a3,a4,a7e <free+0x22>
    p->s.ptr = bp->s.ptr;
 ace:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 ad0:	00000717          	auipc	a4,0x0
 ad4:	52f73823          	sd	a5,1328(a4) # 1000 <freep>
}
 ad8:	6422                	ld	s0,8(sp)
 ada:	0141                	add	sp,sp,16
 adc:	8082                	ret

0000000000000ade <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ade:	7139                	add	sp,sp,-64
 ae0:	fc06                	sd	ra,56(sp)
 ae2:	f822                	sd	s0,48(sp)
 ae4:	f426                	sd	s1,40(sp)
 ae6:	f04a                	sd	s2,32(sp)
 ae8:	ec4e                	sd	s3,24(sp)
 aea:	e852                	sd	s4,16(sp)
 aec:	e456                	sd	s5,8(sp)
 aee:	e05a                	sd	s6,0(sp)
 af0:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 af2:	02051493          	sll	s1,a0,0x20
 af6:	9081                	srl	s1,s1,0x20
 af8:	04bd                	add	s1,s1,15
 afa:	8091                	srl	s1,s1,0x4
 afc:	0014899b          	addw	s3,s1,1
 b00:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 b02:	00000517          	auipc	a0,0x0
 b06:	4fe53503          	ld	a0,1278(a0) # 1000 <freep>
 b0a:	c515                	beqz	a0,b36 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b0c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b0e:	4798                	lw	a4,8(a5)
 b10:	02977f63          	bgeu	a4,s1,b4e <malloc+0x70>
  if(nu < 4096)
 b14:	8a4e                	mv	s4,s3
 b16:	0009871b          	sext.w	a4,s3
 b1a:	6685                	lui	a3,0x1
 b1c:	00d77363          	bgeu	a4,a3,b22 <malloc+0x44>
 b20:	6a05                	lui	s4,0x1
 b22:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b26:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b2a:	00000917          	auipc	s2,0x0
 b2e:	4d690913          	add	s2,s2,1238 # 1000 <freep>
  if(p == (char*)-1)
 b32:	5afd                	li	s5,-1
 b34:	a895                	j	ba8 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 b36:	00000797          	auipc	a5,0x0
 b3a:	4da78793          	add	a5,a5,1242 # 1010 <base>
 b3e:	00000717          	auipc	a4,0x0
 b42:	4cf73123          	sd	a5,1218(a4) # 1000 <freep>
 b46:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b48:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b4c:	b7e1                	j	b14 <malloc+0x36>
      if(p->s.size == nunits)
 b4e:	02e48c63          	beq	s1,a4,b86 <malloc+0xa8>
        p->s.size -= nunits;
 b52:	4137073b          	subw	a4,a4,s3
 b56:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b58:	02071693          	sll	a3,a4,0x20
 b5c:	01c6d713          	srl	a4,a3,0x1c
 b60:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b62:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b66:	00000717          	auipc	a4,0x0
 b6a:	48a73d23          	sd	a0,1178(a4) # 1000 <freep>
      return (void*)(p + 1);
 b6e:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b72:	70e2                	ld	ra,56(sp)
 b74:	7442                	ld	s0,48(sp)
 b76:	74a2                	ld	s1,40(sp)
 b78:	7902                	ld	s2,32(sp)
 b7a:	69e2                	ld	s3,24(sp)
 b7c:	6a42                	ld	s4,16(sp)
 b7e:	6aa2                	ld	s5,8(sp)
 b80:	6b02                	ld	s6,0(sp)
 b82:	6121                	add	sp,sp,64
 b84:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b86:	6398                	ld	a4,0(a5)
 b88:	e118                	sd	a4,0(a0)
 b8a:	bff1                	j	b66 <malloc+0x88>
  hp->s.size = nu;
 b8c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b90:	0541                	add	a0,a0,16
 b92:	00000097          	auipc	ra,0x0
 b96:	eca080e7          	jalr	-310(ra) # a5c <free>
  return freep;
 b9a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b9e:	d971                	beqz	a0,b72 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ba0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ba2:	4798                	lw	a4,8(a5)
 ba4:	fa9775e3          	bgeu	a4,s1,b4e <malloc+0x70>
    if(p == freep)
 ba8:	00093703          	ld	a4,0(s2)
 bac:	853e                	mv	a0,a5
 bae:	fef719e3          	bne	a4,a5,ba0 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 bb2:	8552                	mv	a0,s4
 bb4:	00000097          	auipc	ra,0x0
 bb8:	b72080e7          	jalr	-1166(ra) # 726 <sbrk>
  if(p == (char*)-1)
 bbc:	fd5518e3          	bne	a0,s5,b8c <malloc+0xae>
        return 0;
 bc0:	4501                	li	a0,0
 bc2:	bf45                	j	b72 <malloc+0x94>
