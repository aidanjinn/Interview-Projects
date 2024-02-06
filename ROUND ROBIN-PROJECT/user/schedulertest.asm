
user/_schedulertest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <testdefault>:
#include "kernel/sysinfo.h"
#include "user/user.h"


void
testdefault() {
   0:	1141                	add	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	add	s0,sp,16
  printf("testdefault: OK\n");
   8:	00001517          	auipc	a0,0x1
   c:	c8850513          	add	a0,a0,-888 # c90 <malloc+0xe6>
  10:	00001097          	auipc	ra,0x1
  14:	ae2080e7          	jalr	-1310(ra) # af2 <printf>
}
  18:	60a2                	ld	ra,8(sp)
  1a:	6402                	ld	s0,0(sp)
  1c:	0141                	add	sp,sp,16
  1e:	8082                	ret

0000000000000020 <testsyscall>:

void
testsyscall() {
  20:	1141                	add	sp,sp,-16
  22:	e406                	sd	ra,8(sp)
  24:	e022                	sd	s0,0(sp)
  26:	0800                	add	s0,sp,16
  if (setpriority(10)) {
  28:	4529                	li	a0,10
  2a:	00000097          	auipc	ra,0x0
  2e:	7f8080e7          	jalr	2040(ra) # 822 <setpriority>
  32:	e929                	bnez	a0,84 <testsyscall+0x64>
    printf("schedulertest: setpriority 10 failed\n");
    exit(1);
  }
  if (setpriority(1)) {
  34:	4505                	li	a0,1
  36:	00000097          	auipc	ra,0x0
  3a:	7ec080e7          	jalr	2028(ra) # 822 <setpriority>
  3e:	e125                	bnez	a0,9e <testsyscall+0x7e>
    printf("schedulertest: setpriority 1 failed\n");
    exit(1);
  }
  if (setpriority(0) != -1) {
  40:	4501                	li	a0,0
  42:	00000097          	auipc	ra,0x0
  46:	7e0080e7          	jalr	2016(ra) # 822 <setpriority>
  4a:	57fd                	li	a5,-1
  4c:	06f51663          	bne	a0,a5,b8 <testsyscall+0x98>
    printf("schedulertest: setpriority 0 failed\n");
    exit(1);
  }
  if (setpriority(11) != -1) {
  50:	452d                	li	a0,11
  52:	00000097          	auipc	ra,0x0
  56:	7d0080e7          	jalr	2000(ra) # 822 <setpriority>
  5a:	57fd                	li	a5,-1
  5c:	06f51b63          	bne	a0,a5,d2 <testsyscall+0xb2>
    printf("schedulertest: setpriority 11 failed\n");
    exit(1);
  }
  if (setpriority(5)) {
  60:	4515                	li	a0,5
  62:	00000097          	auipc	ra,0x0
  66:	7c0080e7          	jalr	1984(ra) # 822 <setpriority>
  6a:	e149                	bnez	a0,ec <testsyscall+0xcc>
    printf("schedulertest: setpriority 5 failed\n");
    exit(1);
  }
  printf("testsyscall: OK\n");
  6c:	00001517          	auipc	a0,0x1
  70:	d0450513          	add	a0,a0,-764 # d70 <malloc+0x1c6>
  74:	00001097          	auipc	ra,0x1
  78:	a7e080e7          	jalr	-1410(ra) # af2 <printf>
}
  7c:	60a2                	ld	ra,8(sp)
  7e:	6402                	ld	s0,0(sp)
  80:	0141                	add	sp,sp,16
  82:	8082                	ret
    printf("schedulertest: setpriority 10 failed\n");
  84:	00001517          	auipc	a0,0x1
  88:	c2450513          	add	a0,a0,-988 # ca8 <malloc+0xfe>
  8c:	00001097          	auipc	ra,0x1
  90:	a66080e7          	jalr	-1434(ra) # af2 <printf>
    exit(1);
  94:	4505                	li	a0,1
  96:	00000097          	auipc	ra,0x0
  9a:	6d4080e7          	jalr	1748(ra) # 76a <exit>
    printf("schedulertest: setpriority 1 failed\n");
  9e:	00001517          	auipc	a0,0x1
  a2:	c3250513          	add	a0,a0,-974 # cd0 <malloc+0x126>
  a6:	00001097          	auipc	ra,0x1
  aa:	a4c080e7          	jalr	-1460(ra) # af2 <printf>
    exit(1);
  ae:	4505                	li	a0,1
  b0:	00000097          	auipc	ra,0x0
  b4:	6ba080e7          	jalr	1722(ra) # 76a <exit>
    printf("schedulertest: setpriority 0 failed\n");
  b8:	00001517          	auipc	a0,0x1
  bc:	c4050513          	add	a0,a0,-960 # cf8 <malloc+0x14e>
  c0:	00001097          	auipc	ra,0x1
  c4:	a32080e7          	jalr	-1486(ra) # af2 <printf>
    exit(1);
  c8:	4505                	li	a0,1
  ca:	00000097          	auipc	ra,0x0
  ce:	6a0080e7          	jalr	1696(ra) # 76a <exit>
    printf("schedulertest: setpriority 11 failed\n");
  d2:	00001517          	auipc	a0,0x1
  d6:	c4e50513          	add	a0,a0,-946 # d20 <malloc+0x176>
  da:	00001097          	auipc	ra,0x1
  de:	a18080e7          	jalr	-1512(ra) # af2 <printf>
    exit(1);
  e2:	4505                	li	a0,1
  e4:	00000097          	auipc	ra,0x0
  e8:	686080e7          	jalr	1670(ra) # 76a <exit>
    printf("schedulertest: setpriority 5 failed\n");
  ec:	00001517          	auipc	a0,0x1
  f0:	c5c50513          	add	a0,a0,-932 # d48 <malloc+0x19e>
  f4:	00001097          	auipc	ra,0x1
  f8:	9fe080e7          	jalr	-1538(ra) # af2 <printf>
    exit(1);
  fc:	4505                	li	a0,1
  fe:	00000097          	auipc	ra,0x0
 102:	66c080e7          	jalr	1644(ra) # 76a <exit>

0000000000000106 <testprocspriority>:

void testprocspriority() {
 106:	7139                	add	sp,sp,-64
 108:	fc06                	sd	ra,56(sp)
 10a:	f822                	sd	s0,48(sp)
 10c:	f426                	sd	s1,40(sp)
 10e:	f04a                	sd	s2,32(sp)
 110:	ec4e                	sd	s3,24(sp)
 112:	0080                	add	s0,sp,64
  setpriority(10);
 114:	4529                	li	a0,10
 116:	00000097          	auipc	ra,0x0
 11a:	70c080e7          	jalr	1804(ra) # 822 <setpriority>
  int child_elapsed_time = uptime(), parent_elapsed_time = uptime();
 11e:	00000097          	auipc	ra,0x0
 122:	6e4080e7          	jalr	1764(ra) # 802 <uptime>
 126:	fca42623          	sw	a0,-52(s0)
 12a:	00000097          	auipc	ra,0x0
 12e:	6d8080e7          	jalr	1752(ra) # 802 <uptime>
 132:	89aa                	mv	s3,a0
  int pid = fork();
 134:	00000097          	auipc	ra,0x0
 138:	62e080e7          	jalr	1582(ra) # 762 <fork>
  if(pid < 0){
 13c:	06054763          	bltz	a0,1aa <testprocspriority+0xa4>
    printf("procspriority: fork failed\n");
    exit(1);
  }
  if(pid == 0){
 140:	c151                	beqz	a0,1c4 <testprocspriority+0xbe>
    setpriority(5);
    for (int i = 0; i < 7000; ++i)
      printf(" \b");
    exit(uptime() - child_elapsed_time);
  }
  sleep(1);
 142:	4505                	li	a0,1
 144:	00000097          	auipc	ra,0x0
 148:	6b6080e7          	jalr	1718(ra) # 7fa <sleep>
 14c:	6489                	lui	s1,0x2
 14e:	b5848493          	add	s1,s1,-1192 # 1b58 <base+0xb48>
  for (int i = 0; i < 7000; ++i)
      printf(" \b");
 152:	00001917          	auipc	s2,0x1
 156:	c5690913          	add	s2,s2,-938 # da8 <malloc+0x1fe>
 15a:	854a                	mv	a0,s2
 15c:	00001097          	auipc	ra,0x1
 160:	996080e7          	jalr	-1642(ra) # af2 <printf>
  for (int i = 0; i < 7000; ++i)
 164:	34fd                	addw	s1,s1,-1
 166:	f8f5                	bnez	s1,15a <testprocspriority+0x54>
  parent_elapsed_time = uptime() - parent_elapsed_time;
 168:	00000097          	auipc	ra,0x0
 16c:	69a080e7          	jalr	1690(ra) # 802 <uptime>
 170:	413504bb          	subw	s1,a0,s3
  wait(&child_elapsed_time);
 174:	fcc40513          	add	a0,s0,-52
 178:	00000097          	auipc	ra,0x0
 17c:	5fa080e7          	jalr	1530(ra) # 772 <wait>
  int time_diff = parent_elapsed_time - child_elapsed_time;
 180:	fcc42783          	lw	a5,-52(s0)
  if (time_diff <= 3) {
 184:	9c9d                	subw	s1,s1,a5
 186:	478d                	li	a5,3
 188:	0697dc63          	bge	a5,s1,200 <testprocspriority+0xfa>
    printf("\nprocspriority: failed\n");
    exit(1);
  }
  printf("\nprocspriority: OK\n");
 18c:	00001517          	auipc	a0,0x1
 190:	c3c50513          	add	a0,a0,-964 # dc8 <malloc+0x21e>
 194:	00001097          	auipc	ra,0x1
 198:	95e080e7          	jalr	-1698(ra) # af2 <printf>
}
 19c:	70e2                	ld	ra,56(sp)
 19e:	7442                	ld	s0,48(sp)
 1a0:	74a2                	ld	s1,40(sp)
 1a2:	7902                	ld	s2,32(sp)
 1a4:	69e2                	ld	s3,24(sp)
 1a6:	6121                	add	sp,sp,64
 1a8:	8082                	ret
    printf("procspriority: fork failed\n");
 1aa:	00001517          	auipc	a0,0x1
 1ae:	bde50513          	add	a0,a0,-1058 # d88 <malloc+0x1de>
 1b2:	00001097          	auipc	ra,0x1
 1b6:	940080e7          	jalr	-1728(ra) # af2 <printf>
    exit(1);
 1ba:	4505                	li	a0,1
 1bc:	00000097          	auipc	ra,0x0
 1c0:	5ae080e7          	jalr	1454(ra) # 76a <exit>
    setpriority(5);
 1c4:	4515                	li	a0,5
 1c6:	00000097          	auipc	ra,0x0
 1ca:	65c080e7          	jalr	1628(ra) # 822 <setpriority>
 1ce:	6489                	lui	s1,0x2
 1d0:	b5848493          	add	s1,s1,-1192 # 1b58 <base+0xb48>
      printf(" \b");
 1d4:	00001917          	auipc	s2,0x1
 1d8:	bd490913          	add	s2,s2,-1068 # da8 <malloc+0x1fe>
 1dc:	854a                	mv	a0,s2
 1de:	00001097          	auipc	ra,0x1
 1e2:	914080e7          	jalr	-1772(ra) # af2 <printf>
    for (int i = 0; i < 7000; ++i)
 1e6:	34fd                	addw	s1,s1,-1
 1e8:	f8f5                	bnez	s1,1dc <testprocspriority+0xd6>
    exit(uptime() - child_elapsed_time);
 1ea:	00000097          	auipc	ra,0x0
 1ee:	618080e7          	jalr	1560(ra) # 802 <uptime>
 1f2:	fcc42783          	lw	a5,-52(s0)
 1f6:	9d1d                	subw	a0,a0,a5
 1f8:	00000097          	auipc	ra,0x0
 1fc:	572080e7          	jalr	1394(ra) # 76a <exit>
    printf("\nprocspriority: failed\n");
 200:	00001517          	auipc	a0,0x1
 204:	bb050513          	add	a0,a0,-1104 # db0 <malloc+0x206>
 208:	00001097          	auipc	ra,0x1
 20c:	8ea080e7          	jalr	-1814(ra) # af2 <printf>
    exit(1);
 210:	4505                	li	a0,1
 212:	00000097          	auipc	ra,0x0
 216:	558080e7          	jalr	1368(ra) # 76a <exit>

000000000000021a <testprocspriorityinverted>:

void testprocspriorityinverted() {
 21a:	7139                	add	sp,sp,-64
 21c:	fc06                	sd	ra,56(sp)
 21e:	f822                	sd	s0,48(sp)
 220:	f426                	sd	s1,40(sp)
 222:	f04a                	sd	s2,32(sp)
 224:	ec4e                	sd	s3,24(sp)
 226:	0080                	add	s0,sp,64
  setpriority(5);
 228:	4515                	li	a0,5
 22a:	00000097          	auipc	ra,0x0
 22e:	5f8080e7          	jalr	1528(ra) # 822 <setpriority>
  int child_elapsed_time = uptime(), parent_elapsed_time = uptime();
 232:	00000097          	auipc	ra,0x0
 236:	5d0080e7          	jalr	1488(ra) # 802 <uptime>
 23a:	fca42623          	sw	a0,-52(s0)
 23e:	00000097          	auipc	ra,0x0
 242:	5c4080e7          	jalr	1476(ra) # 802 <uptime>
 246:	89aa                	mv	s3,a0
  int pid = fork();
 248:	00000097          	auipc	ra,0x0
 24c:	51a080e7          	jalr	1306(ra) # 762 <fork>
  if(pid < 0){
 250:	06054863          	bltz	a0,2c0 <testprocspriorityinverted+0xa6>
    printf("procspriorityinverted: fork failed\n");
    exit(1);
  }
  if(pid == 0){
 254:	c159                	beqz	a0,2da <testprocspriorityinverted+0xc0>
    setpriority(10);
    for (int i = 0; i < 7000; ++i)
      printf(" \b");
    exit(uptime() - child_elapsed_time);
  }
  sleep(1);
 256:	4505                	li	a0,1
 258:	00000097          	auipc	ra,0x0
 25c:	5a2080e7          	jalr	1442(ra) # 7fa <sleep>
 260:	6489                	lui	s1,0x2
 262:	b5848493          	add	s1,s1,-1192 # 1b58 <base+0xb48>
  for (int i = 0; i < 7000; ++i)
      printf(" \b");
 266:	00001917          	auipc	s2,0x1
 26a:	b4290913          	add	s2,s2,-1214 # da8 <malloc+0x1fe>
 26e:	854a                	mv	a0,s2
 270:	00001097          	auipc	ra,0x1
 274:	882080e7          	jalr	-1918(ra) # af2 <printf>
  for (int i = 0; i < 7000; ++i)
 278:	34fd                	addw	s1,s1,-1
 27a:	f8f5                	bnez	s1,26e <testprocspriorityinverted+0x54>
  parent_elapsed_time = uptime() - parent_elapsed_time;
 27c:	00000097          	auipc	ra,0x0
 280:	586080e7          	jalr	1414(ra) # 802 <uptime>
 284:	413509bb          	subw	s3,a0,s3
  wait(&child_elapsed_time);
 288:	fcc40513          	add	a0,s0,-52
 28c:	00000097          	auipc	ra,0x0
 290:	4e6080e7          	jalr	1254(ra) # 772 <wait>
  int time_diff = child_elapsed_time - parent_elapsed_time;
 294:	fcc42783          	lw	a5,-52(s0)
  if (time_diff <= 3) {
 298:	413787bb          	subw	a5,a5,s3
 29c:	470d                	li	a4,3
 29e:	06f75c63          	bge	a4,a5,316 <testprocspriorityinverted+0xfc>
    printf("\nprocspriorityinverted: failed\n");
    exit(1);
  }
  printf("\nprocspriorityinverted: OK\n");
 2a2:	00001517          	auipc	a0,0x1
 2a6:	b8650513          	add	a0,a0,-1146 # e28 <malloc+0x27e>
 2aa:	00001097          	auipc	ra,0x1
 2ae:	848080e7          	jalr	-1976(ra) # af2 <printf>
}
 2b2:	70e2                	ld	ra,56(sp)
 2b4:	7442                	ld	s0,48(sp)
 2b6:	74a2                	ld	s1,40(sp)
 2b8:	7902                	ld	s2,32(sp)
 2ba:	69e2                	ld	s3,24(sp)
 2bc:	6121                	add	sp,sp,64
 2be:	8082                	ret
    printf("procspriorityinverted: fork failed\n");
 2c0:	00001517          	auipc	a0,0x1
 2c4:	b2050513          	add	a0,a0,-1248 # de0 <malloc+0x236>
 2c8:	00001097          	auipc	ra,0x1
 2cc:	82a080e7          	jalr	-2006(ra) # af2 <printf>
    exit(1);
 2d0:	4505                	li	a0,1
 2d2:	00000097          	auipc	ra,0x0
 2d6:	498080e7          	jalr	1176(ra) # 76a <exit>
    setpriority(10);
 2da:	4529                	li	a0,10
 2dc:	00000097          	auipc	ra,0x0
 2e0:	546080e7          	jalr	1350(ra) # 822 <setpriority>
 2e4:	6489                	lui	s1,0x2
 2e6:	b5848493          	add	s1,s1,-1192 # 1b58 <base+0xb48>
      printf(" \b");
 2ea:	00001917          	auipc	s2,0x1
 2ee:	abe90913          	add	s2,s2,-1346 # da8 <malloc+0x1fe>
 2f2:	854a                	mv	a0,s2
 2f4:	00000097          	auipc	ra,0x0
 2f8:	7fe080e7          	jalr	2046(ra) # af2 <printf>
    for (int i = 0; i < 7000; ++i)
 2fc:	34fd                	addw	s1,s1,-1
 2fe:	f8f5                	bnez	s1,2f2 <testprocspriorityinverted+0xd8>
    exit(uptime() - child_elapsed_time);
 300:	00000097          	auipc	ra,0x0
 304:	502080e7          	jalr	1282(ra) # 802 <uptime>
 308:	fcc42783          	lw	a5,-52(s0)
 30c:	9d1d                	subw	a0,a0,a5
 30e:	00000097          	auipc	ra,0x0
 312:	45c080e7          	jalr	1116(ra) # 76a <exit>
    printf("\nprocspriorityinverted: failed\n");
 316:	00001517          	auipc	a0,0x1
 31a:	af250513          	add	a0,a0,-1294 # e08 <malloc+0x25e>
 31e:	00000097          	auipc	ra,0x0
 322:	7d4080e7          	jalr	2004(ra) # af2 <printf>
    exit(1);
 326:	4505                	li	a0,1
 328:	00000097          	auipc	ra,0x0
 32c:	442080e7          	jalr	1090(ra) # 76a <exit>

0000000000000330 <testprocsequal>:

void testprocsequal() {
 330:	7139                	add	sp,sp,-64
 332:	fc06                	sd	ra,56(sp)
 334:	f822                	sd	s0,48(sp)
 336:	f426                	sd	s1,40(sp)
 338:	f04a                	sd	s2,32(sp)
 33a:	ec4e                	sd	s3,24(sp)
 33c:	0080                	add	s0,sp,64
  int child_elapsed_time = uptime(), parent_elapsed_time = uptime();
 33e:	00000097          	auipc	ra,0x0
 342:	4c4080e7          	jalr	1220(ra) # 802 <uptime>
 346:	fca42623          	sw	a0,-52(s0)
 34a:	00000097          	auipc	ra,0x0
 34e:	4b8080e7          	jalr	1208(ra) # 802 <uptime>
 352:	89aa                	mv	s3,a0
  int pid = fork();
 354:	00000097          	auipc	ra,0x0
 358:	40e080e7          	jalr	1038(ra) # 762 <fork>
  if(pid < 0){
 35c:	06054c63          	bltz	a0,3d4 <testprocsequal+0xa4>
    printf("procsequal: fork failed\n");
    exit(1);
  }
  if(pid == 0){
 360:	c559                	beqz	a0,3ee <testprocsequal+0xbe>
    for (int i = 0; i < 7000; ++i)
      printf(" \b");
    exit(uptime() - child_elapsed_time);
  }
  sleep(1);
 362:	4505                	li	a0,1
 364:	00000097          	auipc	ra,0x0
 368:	496080e7          	jalr	1174(ra) # 7fa <sleep>
 36c:	6489                	lui	s1,0x2
 36e:	b5848493          	add	s1,s1,-1192 # 1b58 <base+0xb48>
  for (int i = 0; i < 7000; ++i)
      printf(" \b");
 372:	00001917          	auipc	s2,0x1
 376:	a3690913          	add	s2,s2,-1482 # da8 <malloc+0x1fe>
 37a:	854a                	mv	a0,s2
 37c:	00000097          	auipc	ra,0x0
 380:	776080e7          	jalr	1910(ra) # af2 <printf>
  for (int i = 0; i < 7000; ++i)
 384:	34fd                	addw	s1,s1,-1
 386:	f8f5                	bnez	s1,37a <testprocsequal+0x4a>
  parent_elapsed_time = uptime() - parent_elapsed_time;
 388:	00000097          	auipc	ra,0x0
 38c:	47a080e7          	jalr	1146(ra) # 802 <uptime>
 390:	413509bb          	subw	s3,a0,s3
 394:	0009891b          	sext.w	s2,s3
  wait(&child_elapsed_time);
 398:	fcc40513          	add	a0,s0,-52
 39c:	00000097          	auipc	ra,0x0
 3a0:	3d6080e7          	jalr	982(ra) # 772 <wait>
  int time_diff = (parent_elapsed_time > child_elapsed_time) ?
 3a4:	fcc42783          	lw	a5,-52(s0)
    parent_elapsed_time - child_elapsed_time :
 3a8:	0727dc63          	bge	a5,s2,420 <testprocsequal+0xf0>
 3ac:	40f987bb          	subw	a5,s3,a5
    child_elapsed_time - parent_elapsed_time;
  if (time_diff > 3) {
 3b0:	470d                	li	a4,3
 3b2:	06f74a63          	blt	a4,a5,426 <testprocsequal+0xf6>
    printf("\nprocsequal: failed:\n");
    exit(1);
  }
  printf("\nprocsequal: OK\n");
 3b6:	00001517          	auipc	a0,0x1
 3ba:	aca50513          	add	a0,a0,-1334 # e80 <malloc+0x2d6>
 3be:	00000097          	auipc	ra,0x0
 3c2:	734080e7          	jalr	1844(ra) # af2 <printf>
}
 3c6:	70e2                	ld	ra,56(sp)
 3c8:	7442                	ld	s0,48(sp)
 3ca:	74a2                	ld	s1,40(sp)
 3cc:	7902                	ld	s2,32(sp)
 3ce:	69e2                	ld	s3,24(sp)
 3d0:	6121                	add	sp,sp,64
 3d2:	8082                	ret
    printf("procsequal: fork failed\n");
 3d4:	00001517          	auipc	a0,0x1
 3d8:	a7450513          	add	a0,a0,-1420 # e48 <malloc+0x29e>
 3dc:	00000097          	auipc	ra,0x0
 3e0:	716080e7          	jalr	1814(ra) # af2 <printf>
    exit(1);
 3e4:	4505                	li	a0,1
 3e6:	00000097          	auipc	ra,0x0
 3ea:	384080e7          	jalr	900(ra) # 76a <exit>
 3ee:	6489                	lui	s1,0x2
 3f0:	b5848493          	add	s1,s1,-1192 # 1b58 <base+0xb48>
      printf(" \b");
 3f4:	00001917          	auipc	s2,0x1
 3f8:	9b490913          	add	s2,s2,-1612 # da8 <malloc+0x1fe>
 3fc:	854a                	mv	a0,s2
 3fe:	00000097          	auipc	ra,0x0
 402:	6f4080e7          	jalr	1780(ra) # af2 <printf>
    for (int i = 0; i < 7000; ++i)
 406:	34fd                	addw	s1,s1,-1
 408:	f8f5                	bnez	s1,3fc <testprocsequal+0xcc>
    exit(uptime() - child_elapsed_time);
 40a:	00000097          	auipc	ra,0x0
 40e:	3f8080e7          	jalr	1016(ra) # 802 <uptime>
 412:	fcc42783          	lw	a5,-52(s0)
 416:	9d1d                	subw	a0,a0,a5
 418:	00000097          	auipc	ra,0x0
 41c:	352080e7          	jalr	850(ra) # 76a <exit>
    parent_elapsed_time - child_elapsed_time :
 420:	413787bb          	subw	a5,a5,s3
 424:	b771                	j	3b0 <testprocsequal+0x80>
    printf("\nprocsequal: failed:\n");
 426:	00001517          	auipc	a0,0x1
 42a:	a4250513          	add	a0,a0,-1470 # e68 <malloc+0x2be>
 42e:	00000097          	auipc	ra,0x0
 432:	6c4080e7          	jalr	1732(ra) # af2 <printf>
    exit(1);
 436:	4505                	li	a0,1
 438:	00000097          	auipc	ra,0x0
 43c:	332080e7          	jalr	818(ra) # 76a <exit>

0000000000000440 <main>:

int
main(int argc, char *argv[])
{
 440:	1141                	add	sp,sp,-16
 442:	e406                	sd	ra,8(sp)
 444:	e022                	sd	s0,0(sp)
 446:	0800                	add	s0,sp,16
  printf("schedulertest: start\n");
 448:	00001517          	auipc	a0,0x1
 44c:	a5050513          	add	a0,a0,-1456 # e98 <malloc+0x2ee>
 450:	00000097          	auipc	ra,0x0
 454:	6a2080e7          	jalr	1698(ra) # af2 <printf>
  testdefault();
 458:	00000097          	auipc	ra,0x0
 45c:	ba8080e7          	jalr	-1112(ra) # 0 <testdefault>
  testsyscall();
 460:	00000097          	auipc	ra,0x0
 464:	bc0080e7          	jalr	-1088(ra) # 20 <testsyscall>
#if defined(_NCPUS) && (_NCPUS == 1)
  testprocspriority();
  testprocspriorityinverted();
#else
  testprocsequal();
 468:	00000097          	auipc	ra,0x0
 46c:	ec8080e7          	jalr	-312(ra) # 330 <testprocsequal>
#endif
  printf("schedulertest: OK\n");
 470:	00001517          	auipc	a0,0x1
 474:	a4050513          	add	a0,a0,-1472 # eb0 <malloc+0x306>
 478:	00000097          	auipc	ra,0x0
 47c:	67a080e7          	jalr	1658(ra) # af2 <printf>
  exit(0);
 480:	4501                	li	a0,0
 482:	00000097          	auipc	ra,0x0
 486:	2e8080e7          	jalr	744(ra) # 76a <exit>

000000000000048a <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 48a:	1141                	add	sp,sp,-16
 48c:	e406                	sd	ra,8(sp)
 48e:	e022                	sd	s0,0(sp)
 490:	0800                	add	s0,sp,16
  extern int main();
  main();
 492:	00000097          	auipc	ra,0x0
 496:	fae080e7          	jalr	-82(ra) # 440 <main>
  exit(0);
 49a:	4501                	li	a0,0
 49c:	00000097          	auipc	ra,0x0
 4a0:	2ce080e7          	jalr	718(ra) # 76a <exit>

00000000000004a4 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 4a4:	1141                	add	sp,sp,-16
 4a6:	e422                	sd	s0,8(sp)
 4a8:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 4aa:	87aa                	mv	a5,a0
 4ac:	0585                	add	a1,a1,1
 4ae:	0785                	add	a5,a5,1
 4b0:	fff5c703          	lbu	a4,-1(a1)
 4b4:	fee78fa3          	sb	a4,-1(a5)
 4b8:	fb75                	bnez	a4,4ac <strcpy+0x8>
    ;
  return os;
}
 4ba:	6422                	ld	s0,8(sp)
 4bc:	0141                	add	sp,sp,16
 4be:	8082                	ret

00000000000004c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 4c0:	1141                	add	sp,sp,-16
 4c2:	e422                	sd	s0,8(sp)
 4c4:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 4c6:	00054783          	lbu	a5,0(a0)
 4ca:	cb91                	beqz	a5,4de <strcmp+0x1e>
 4cc:	0005c703          	lbu	a4,0(a1)
 4d0:	00f71763          	bne	a4,a5,4de <strcmp+0x1e>
    p++, q++;
 4d4:	0505                	add	a0,a0,1
 4d6:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 4d8:	00054783          	lbu	a5,0(a0)
 4dc:	fbe5                	bnez	a5,4cc <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 4de:	0005c503          	lbu	a0,0(a1)
}
 4e2:	40a7853b          	subw	a0,a5,a0
 4e6:	6422                	ld	s0,8(sp)
 4e8:	0141                	add	sp,sp,16
 4ea:	8082                	ret

00000000000004ec <strlen>:

uint
strlen(const char *s)
{
 4ec:	1141                	add	sp,sp,-16
 4ee:	e422                	sd	s0,8(sp)
 4f0:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 4f2:	00054783          	lbu	a5,0(a0)
 4f6:	cf91                	beqz	a5,512 <strlen+0x26>
 4f8:	0505                	add	a0,a0,1
 4fa:	87aa                	mv	a5,a0
 4fc:	86be                	mv	a3,a5
 4fe:	0785                	add	a5,a5,1
 500:	fff7c703          	lbu	a4,-1(a5)
 504:	ff65                	bnez	a4,4fc <strlen+0x10>
 506:	40a6853b          	subw	a0,a3,a0
 50a:	2505                	addw	a0,a0,1
    ;
  return n;
}
 50c:	6422                	ld	s0,8(sp)
 50e:	0141                	add	sp,sp,16
 510:	8082                	ret
  for(n = 0; s[n]; n++)
 512:	4501                	li	a0,0
 514:	bfe5                	j	50c <strlen+0x20>

0000000000000516 <memset>:

void*
memset(void *dst, int c, uint n)
{
 516:	1141                	add	sp,sp,-16
 518:	e422                	sd	s0,8(sp)
 51a:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 51c:	ca19                	beqz	a2,532 <memset+0x1c>
 51e:	87aa                	mv	a5,a0
 520:	1602                	sll	a2,a2,0x20
 522:	9201                	srl	a2,a2,0x20
 524:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 528:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 52c:	0785                	add	a5,a5,1
 52e:	fee79de3          	bne	a5,a4,528 <memset+0x12>
  }
  return dst;
}
 532:	6422                	ld	s0,8(sp)
 534:	0141                	add	sp,sp,16
 536:	8082                	ret

0000000000000538 <strchr>:

char*
strchr(const char *s, char c)
{
 538:	1141                	add	sp,sp,-16
 53a:	e422                	sd	s0,8(sp)
 53c:	0800                	add	s0,sp,16
  for(; *s; s++)
 53e:	00054783          	lbu	a5,0(a0)
 542:	cb99                	beqz	a5,558 <strchr+0x20>
    if(*s == c)
 544:	00f58763          	beq	a1,a5,552 <strchr+0x1a>
  for(; *s; s++)
 548:	0505                	add	a0,a0,1
 54a:	00054783          	lbu	a5,0(a0)
 54e:	fbfd                	bnez	a5,544 <strchr+0xc>
      return (char*)s;
  return 0;
 550:	4501                	li	a0,0
}
 552:	6422                	ld	s0,8(sp)
 554:	0141                	add	sp,sp,16
 556:	8082                	ret
  return 0;
 558:	4501                	li	a0,0
 55a:	bfe5                	j	552 <strchr+0x1a>

000000000000055c <strstr>:

char*
strstr(const char *str, const char *substr)
{
 55c:	1141                	add	sp,sp,-16
 55e:	e422                	sd	s0,8(sp)
 560:	0800                	add	s0,sp,16
  const char *a, *b = substr;
  if (*b == 0)
 562:	0005c803          	lbu	a6,0(a1)
 566:	02080a63          	beqz	a6,59a <strstr+0x3e>
    return (char*)str;
  for( ; *str != 0; str += 1) {
 56a:	00054783          	lbu	a5,0(a0)
 56e:	e799                	bnez	a5,57c <strstr+0x20>
      if (*a++ != *b++)
        break;
    }
    b = substr;
  }
  return 0;
 570:	4501                	li	a0,0
 572:	a025                	j	59a <strstr+0x3e>
  for( ; *str != 0; str += 1) {
 574:	0505                	add	a0,a0,1
 576:	00054783          	lbu	a5,0(a0)
 57a:	cf99                	beqz	a5,598 <strstr+0x3c>
    if (*str != *b)
 57c:	fef81ce3          	bne	a6,a5,574 <strstr+0x18>
 580:	87ae                	mv	a5,a1
 582:	86aa                	mv	a3,a0
      if (*b == 0)
 584:	0007c703          	lbu	a4,0(a5)
 588:	cb09                	beqz	a4,59a <strstr+0x3e>
      if (*a++ != *b++)
 58a:	0685                	add	a3,a3,1
 58c:	0785                	add	a5,a5,1
 58e:	fff6c603          	lbu	a2,-1(a3)
 592:	fee609e3          	beq	a2,a4,584 <strstr+0x28>
 596:	bff9                	j	574 <strstr+0x18>
  return 0;
 598:	4501                	li	a0,0
}
 59a:	6422                	ld	s0,8(sp)
 59c:	0141                	add	sp,sp,16
 59e:	8082                	ret

00000000000005a0 <gets>:

char*
gets(char *buf, int max)
{
 5a0:	711d                	add	sp,sp,-96
 5a2:	ec86                	sd	ra,88(sp)
 5a4:	e8a2                	sd	s0,80(sp)
 5a6:	e4a6                	sd	s1,72(sp)
 5a8:	e0ca                	sd	s2,64(sp)
 5aa:	fc4e                	sd	s3,56(sp)
 5ac:	f852                	sd	s4,48(sp)
 5ae:	f456                	sd	s5,40(sp)
 5b0:	f05a                	sd	s6,32(sp)
 5b2:	ec5e                	sd	s7,24(sp)
 5b4:	1080                	add	s0,sp,96
 5b6:	8baa                	mv	s7,a0
 5b8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 5ba:	892a                	mv	s2,a0
 5bc:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 5be:	4aa9                	li	s5,10
 5c0:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 5c2:	89a6                	mv	s3,s1
 5c4:	2485                	addw	s1,s1,1
 5c6:	0344d863          	bge	s1,s4,5f6 <gets+0x56>
    cc = read(0, &c, 1);
 5ca:	4605                	li	a2,1
 5cc:	faf40593          	add	a1,s0,-81
 5d0:	4501                	li	a0,0
 5d2:	00000097          	auipc	ra,0x0
 5d6:	1b0080e7          	jalr	432(ra) # 782 <read>
    if(cc < 1)
 5da:	00a05e63          	blez	a0,5f6 <gets+0x56>
    buf[i++] = c;
 5de:	faf44783          	lbu	a5,-81(s0)
 5e2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 5e6:	01578763          	beq	a5,s5,5f4 <gets+0x54>
 5ea:	0905                	add	s2,s2,1
 5ec:	fd679be3          	bne	a5,s6,5c2 <gets+0x22>
  for(i=0; i+1 < max; ){
 5f0:	89a6                	mv	s3,s1
 5f2:	a011                	j	5f6 <gets+0x56>
 5f4:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 5f6:	99de                	add	s3,s3,s7
 5f8:	00098023          	sb	zero,0(s3)
  return buf;
}
 5fc:	855e                	mv	a0,s7
 5fe:	60e6                	ld	ra,88(sp)
 600:	6446                	ld	s0,80(sp)
 602:	64a6                	ld	s1,72(sp)
 604:	6906                	ld	s2,64(sp)
 606:	79e2                	ld	s3,56(sp)
 608:	7a42                	ld	s4,48(sp)
 60a:	7aa2                	ld	s5,40(sp)
 60c:	7b02                	ld	s6,32(sp)
 60e:	6be2                	ld	s7,24(sp)
 610:	6125                	add	sp,sp,96
 612:	8082                	ret

0000000000000614 <stat>:

int
stat(const char *n, struct stat *st)
{
 614:	1101                	add	sp,sp,-32
 616:	ec06                	sd	ra,24(sp)
 618:	e822                	sd	s0,16(sp)
 61a:	e426                	sd	s1,8(sp)
 61c:	e04a                	sd	s2,0(sp)
 61e:	1000                	add	s0,sp,32
 620:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 622:	4581                	li	a1,0
 624:	00000097          	auipc	ra,0x0
 628:	186080e7          	jalr	390(ra) # 7aa <open>
  if(fd < 0)
 62c:	02054563          	bltz	a0,656 <stat+0x42>
 630:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 632:	85ca                	mv	a1,s2
 634:	00000097          	auipc	ra,0x0
 638:	18e080e7          	jalr	398(ra) # 7c2 <fstat>
 63c:	892a                	mv	s2,a0
  close(fd);
 63e:	8526                	mv	a0,s1
 640:	00000097          	auipc	ra,0x0
 644:	152080e7          	jalr	338(ra) # 792 <close>
  return r;
}
 648:	854a                	mv	a0,s2
 64a:	60e2                	ld	ra,24(sp)
 64c:	6442                	ld	s0,16(sp)
 64e:	64a2                	ld	s1,8(sp)
 650:	6902                	ld	s2,0(sp)
 652:	6105                	add	sp,sp,32
 654:	8082                	ret
    return -1;
 656:	597d                	li	s2,-1
 658:	bfc5                	j	648 <stat+0x34>

000000000000065a <atoi>:

int
atoi(const char *s)
{
 65a:	1141                	add	sp,sp,-16
 65c:	e422                	sd	s0,8(sp)
 65e:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 660:	00054683          	lbu	a3,0(a0)
 664:	fd06879b          	addw	a5,a3,-48
 668:	0ff7f793          	zext.b	a5,a5
 66c:	4625                	li	a2,9
 66e:	02f66863          	bltu	a2,a5,69e <atoi+0x44>
 672:	872a                	mv	a4,a0
  n = 0;
 674:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 676:	0705                	add	a4,a4,1
 678:	0025179b          	sllw	a5,a0,0x2
 67c:	9fa9                	addw	a5,a5,a0
 67e:	0017979b          	sllw	a5,a5,0x1
 682:	9fb5                	addw	a5,a5,a3
 684:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 688:	00074683          	lbu	a3,0(a4)
 68c:	fd06879b          	addw	a5,a3,-48
 690:	0ff7f793          	zext.b	a5,a5
 694:	fef671e3          	bgeu	a2,a5,676 <atoi+0x1c>
  return n;
}
 698:	6422                	ld	s0,8(sp)
 69a:	0141                	add	sp,sp,16
 69c:	8082                	ret
  n = 0;
 69e:	4501                	li	a0,0
 6a0:	bfe5                	j	698 <atoi+0x3e>

00000000000006a2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 6a2:	1141                	add	sp,sp,-16
 6a4:	e422                	sd	s0,8(sp)
 6a6:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 6a8:	02b57463          	bgeu	a0,a1,6d0 <memmove+0x2e>
    while(n-- > 0)
 6ac:	00c05f63          	blez	a2,6ca <memmove+0x28>
 6b0:	1602                	sll	a2,a2,0x20
 6b2:	9201                	srl	a2,a2,0x20
 6b4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 6b8:	872a                	mv	a4,a0
      *dst++ = *src++;
 6ba:	0585                	add	a1,a1,1
 6bc:	0705                	add	a4,a4,1
 6be:	fff5c683          	lbu	a3,-1(a1)
 6c2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 6c6:	fee79ae3          	bne	a5,a4,6ba <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 6ca:	6422                	ld	s0,8(sp)
 6cc:	0141                	add	sp,sp,16
 6ce:	8082                	ret
    dst += n;
 6d0:	00c50733          	add	a4,a0,a2
    src += n;
 6d4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 6d6:	fec05ae3          	blez	a2,6ca <memmove+0x28>
 6da:	fff6079b          	addw	a5,a2,-1
 6de:	1782                	sll	a5,a5,0x20
 6e0:	9381                	srl	a5,a5,0x20
 6e2:	fff7c793          	not	a5,a5
 6e6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 6e8:	15fd                	add	a1,a1,-1
 6ea:	177d                	add	a4,a4,-1
 6ec:	0005c683          	lbu	a3,0(a1)
 6f0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 6f4:	fee79ae3          	bne	a5,a4,6e8 <memmove+0x46>
 6f8:	bfc9                	j	6ca <memmove+0x28>

00000000000006fa <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 6fa:	1141                	add	sp,sp,-16
 6fc:	e422                	sd	s0,8(sp)
 6fe:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 700:	ca05                	beqz	a2,730 <memcmp+0x36>
 702:	fff6069b          	addw	a3,a2,-1
 706:	1682                	sll	a3,a3,0x20
 708:	9281                	srl	a3,a3,0x20
 70a:	0685                	add	a3,a3,1
 70c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 70e:	00054783          	lbu	a5,0(a0)
 712:	0005c703          	lbu	a4,0(a1)
 716:	00e79863          	bne	a5,a4,726 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 71a:	0505                	add	a0,a0,1
    p2++;
 71c:	0585                	add	a1,a1,1
  while (n-- > 0) {
 71e:	fed518e3          	bne	a0,a3,70e <memcmp+0x14>
  }
  return 0;
 722:	4501                	li	a0,0
 724:	a019                	j	72a <memcmp+0x30>
      return *p1 - *p2;
 726:	40e7853b          	subw	a0,a5,a4
}
 72a:	6422                	ld	s0,8(sp)
 72c:	0141                	add	sp,sp,16
 72e:	8082                	ret
  return 0;
 730:	4501                	li	a0,0
 732:	bfe5                	j	72a <memcmp+0x30>

0000000000000734 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 734:	1141                	add	sp,sp,-16
 736:	e406                	sd	ra,8(sp)
 738:	e022                	sd	s0,0(sp)
 73a:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 73c:	00000097          	auipc	ra,0x0
 740:	f66080e7          	jalr	-154(ra) # 6a2 <memmove>
}
 744:	60a2                	ld	ra,8(sp)
 746:	6402                	ld	s0,0(sp)
 748:	0141                	add	sp,sp,16
 74a:	8082                	ret

000000000000074c <ugetpid>:

int
ugetpid(void)
{
 74c:	1141                	add	sp,sp,-16
 74e:	e422                	sd	s0,8(sp)
 750:	0800                	add	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 752:	040007b7          	lui	a5,0x4000
}
 756:	17f5                	add	a5,a5,-3 # 3fffffd <base+0x3ffefed>
 758:	07b2                	sll	a5,a5,0xc
 75a:	4388                	lw	a0,0(a5)
 75c:	6422                	ld	s0,8(sp)
 75e:	0141                	add	sp,sp,16
 760:	8082                	ret

0000000000000762 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 762:	4885                	li	a7,1
 ecall
 764:	00000073          	ecall
 ret
 768:	8082                	ret

000000000000076a <exit>:
.global exit
exit:
 li a7, SYS_exit
 76a:	4889                	li	a7,2
 ecall
 76c:	00000073          	ecall
 ret
 770:	8082                	ret

0000000000000772 <wait>:
.global wait
wait:
 li a7, SYS_wait
 772:	488d                	li	a7,3
 ecall
 774:	00000073          	ecall
 ret
 778:	8082                	ret

000000000000077a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 77a:	4891                	li	a7,4
 ecall
 77c:	00000073          	ecall
 ret
 780:	8082                	ret

0000000000000782 <read>:
.global read
read:
 li a7, SYS_read
 782:	4895                	li	a7,5
 ecall
 784:	00000073          	ecall
 ret
 788:	8082                	ret

000000000000078a <write>:
.global write
write:
 li a7, SYS_write
 78a:	48c1                	li	a7,16
 ecall
 78c:	00000073          	ecall
 ret
 790:	8082                	ret

0000000000000792 <close>:
.global close
close:
 li a7, SYS_close
 792:	48d5                	li	a7,21
 ecall
 794:	00000073          	ecall
 ret
 798:	8082                	ret

000000000000079a <kill>:
.global kill
kill:
 li a7, SYS_kill
 79a:	4899                	li	a7,6
 ecall
 79c:	00000073          	ecall
 ret
 7a0:	8082                	ret

00000000000007a2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 7a2:	489d                	li	a7,7
 ecall
 7a4:	00000073          	ecall
 ret
 7a8:	8082                	ret

00000000000007aa <open>:
.global open
open:
 li a7, SYS_open
 7aa:	48bd                	li	a7,15
 ecall
 7ac:	00000073          	ecall
 ret
 7b0:	8082                	ret

00000000000007b2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 7b2:	48c5                	li	a7,17
 ecall
 7b4:	00000073          	ecall
 ret
 7b8:	8082                	ret

00000000000007ba <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 7ba:	48c9                	li	a7,18
 ecall
 7bc:	00000073          	ecall
 ret
 7c0:	8082                	ret

00000000000007c2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 7c2:	48a1                	li	a7,8
 ecall
 7c4:	00000073          	ecall
 ret
 7c8:	8082                	ret

00000000000007ca <link>:
.global link
link:
 li a7, SYS_link
 7ca:	48cd                	li	a7,19
 ecall
 7cc:	00000073          	ecall
 ret
 7d0:	8082                	ret

00000000000007d2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7d2:	48d1                	li	a7,20
 ecall
 7d4:	00000073          	ecall
 ret
 7d8:	8082                	ret

00000000000007da <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7da:	48a5                	li	a7,9
 ecall
 7dc:	00000073          	ecall
 ret
 7e0:	8082                	ret

00000000000007e2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 7e2:	48a9                	li	a7,10
 ecall
 7e4:	00000073          	ecall
 ret
 7e8:	8082                	ret

00000000000007ea <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7ea:	48ad                	li	a7,11
 ecall
 7ec:	00000073          	ecall
 ret
 7f0:	8082                	ret

00000000000007f2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7f2:	48b1                	li	a7,12
 ecall
 7f4:	00000073          	ecall
 ret
 7f8:	8082                	ret

00000000000007fa <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7fa:	48b5                	li	a7,13
 ecall
 7fc:	00000073          	ecall
 ret
 800:	8082                	ret

0000000000000802 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 802:	48b9                	li	a7,14
 ecall
 804:	00000073          	ecall
 ret
 808:	8082                	ret

000000000000080a <trace>:
.global trace
trace:
 li a7, SYS_trace
 80a:	48d9                	li	a7,22
 ecall
 80c:	00000073          	ecall
 ret
 810:	8082                	ret

0000000000000812 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 812:	48dd                	li	a7,23
 ecall
 814:	00000073          	ecall
 ret
 818:	8082                	ret

000000000000081a <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 81a:	48e1                	li	a7,24
 ecall
 81c:	00000073          	ecall
 ret
 820:	8082                	ret

0000000000000822 <setpriority>:
.global setpriority
setpriority:
 li a7, SYS_setpriority
 822:	48e5                	li	a7,25
 ecall
 824:	00000073          	ecall
 ret
 828:	8082                	ret

000000000000082a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 82a:	1101                	add	sp,sp,-32
 82c:	ec06                	sd	ra,24(sp)
 82e:	e822                	sd	s0,16(sp)
 830:	1000                	add	s0,sp,32
 832:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 836:	4605                	li	a2,1
 838:	fef40593          	add	a1,s0,-17
 83c:	00000097          	auipc	ra,0x0
 840:	f4e080e7          	jalr	-178(ra) # 78a <write>
}
 844:	60e2                	ld	ra,24(sp)
 846:	6442                	ld	s0,16(sp)
 848:	6105                	add	sp,sp,32
 84a:	8082                	ret

000000000000084c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 84c:	7139                	add	sp,sp,-64
 84e:	fc06                	sd	ra,56(sp)
 850:	f822                	sd	s0,48(sp)
 852:	f426                	sd	s1,40(sp)
 854:	f04a                	sd	s2,32(sp)
 856:	ec4e                	sd	s3,24(sp)
 858:	0080                	add	s0,sp,64
 85a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 85c:	c299                	beqz	a3,862 <printint+0x16>
 85e:	0805c963          	bltz	a1,8f0 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 862:	2581                	sext.w	a1,a1
  neg = 0;
 864:	4881                	li	a7,0
 866:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 86a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 86c:	2601                	sext.w	a2,a2
 86e:	00000517          	auipc	a0,0x0
 872:	6ba50513          	add	a0,a0,1722 # f28 <digits>
 876:	883a                	mv	a6,a4
 878:	2705                	addw	a4,a4,1
 87a:	02c5f7bb          	remuw	a5,a1,a2
 87e:	1782                	sll	a5,a5,0x20
 880:	9381                	srl	a5,a5,0x20
 882:	97aa                	add	a5,a5,a0
 884:	0007c783          	lbu	a5,0(a5)
 888:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 88c:	0005879b          	sext.w	a5,a1
 890:	02c5d5bb          	divuw	a1,a1,a2
 894:	0685                	add	a3,a3,1
 896:	fec7f0e3          	bgeu	a5,a2,876 <printint+0x2a>
  if(neg)
 89a:	00088c63          	beqz	a7,8b2 <printint+0x66>
    buf[i++] = '-';
 89e:	fd070793          	add	a5,a4,-48
 8a2:	00878733          	add	a4,a5,s0
 8a6:	02d00793          	li	a5,45
 8aa:	fef70823          	sb	a5,-16(a4)
 8ae:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 8b2:	02e05863          	blez	a4,8e2 <printint+0x96>
 8b6:	fc040793          	add	a5,s0,-64
 8ba:	00e78933          	add	s2,a5,a4
 8be:	fff78993          	add	s3,a5,-1
 8c2:	99ba                	add	s3,s3,a4
 8c4:	377d                	addw	a4,a4,-1
 8c6:	1702                	sll	a4,a4,0x20
 8c8:	9301                	srl	a4,a4,0x20
 8ca:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8ce:	fff94583          	lbu	a1,-1(s2)
 8d2:	8526                	mv	a0,s1
 8d4:	00000097          	auipc	ra,0x0
 8d8:	f56080e7          	jalr	-170(ra) # 82a <putc>
  while(--i >= 0)
 8dc:	197d                	add	s2,s2,-1
 8de:	ff3918e3          	bne	s2,s3,8ce <printint+0x82>
}
 8e2:	70e2                	ld	ra,56(sp)
 8e4:	7442                	ld	s0,48(sp)
 8e6:	74a2                	ld	s1,40(sp)
 8e8:	7902                	ld	s2,32(sp)
 8ea:	69e2                	ld	s3,24(sp)
 8ec:	6121                	add	sp,sp,64
 8ee:	8082                	ret
    x = -xx;
 8f0:	40b005bb          	negw	a1,a1
    neg = 1;
 8f4:	4885                	li	a7,1
    x = -xx;
 8f6:	bf85                	j	866 <printint+0x1a>

00000000000008f8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8f8:	715d                	add	sp,sp,-80
 8fa:	e486                	sd	ra,72(sp)
 8fc:	e0a2                	sd	s0,64(sp)
 8fe:	fc26                	sd	s1,56(sp)
 900:	f84a                	sd	s2,48(sp)
 902:	f44e                	sd	s3,40(sp)
 904:	f052                	sd	s4,32(sp)
 906:	ec56                	sd	s5,24(sp)
 908:	e85a                	sd	s6,16(sp)
 90a:	e45e                	sd	s7,8(sp)
 90c:	e062                	sd	s8,0(sp)
 90e:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 910:	0005c903          	lbu	s2,0(a1)
 914:	18090c63          	beqz	s2,aac <vprintf+0x1b4>
 918:	8aaa                	mv	s5,a0
 91a:	8bb2                	mv	s7,a2
 91c:	00158493          	add	s1,a1,1
  state = 0;
 920:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 922:	02500a13          	li	s4,37
 926:	4b55                	li	s6,21
 928:	a839                	j	946 <vprintf+0x4e>
        putc(fd, c);
 92a:	85ca                	mv	a1,s2
 92c:	8556                	mv	a0,s5
 92e:	00000097          	auipc	ra,0x0
 932:	efc080e7          	jalr	-260(ra) # 82a <putc>
 936:	a019                	j	93c <vprintf+0x44>
    } else if(state == '%'){
 938:	01498d63          	beq	s3,s4,952 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 93c:	0485                	add	s1,s1,1
 93e:	fff4c903          	lbu	s2,-1(s1)
 942:	16090563          	beqz	s2,aac <vprintf+0x1b4>
    if(state == 0){
 946:	fe0999e3          	bnez	s3,938 <vprintf+0x40>
      if(c == '%'){
 94a:	ff4910e3          	bne	s2,s4,92a <vprintf+0x32>
        state = '%';
 94e:	89d2                	mv	s3,s4
 950:	b7f5                	j	93c <vprintf+0x44>
      if(c == 'd'){
 952:	13490263          	beq	s2,s4,a76 <vprintf+0x17e>
 956:	f9d9079b          	addw	a5,s2,-99
 95a:	0ff7f793          	zext.b	a5,a5
 95e:	12fb6563          	bltu	s6,a5,a88 <vprintf+0x190>
 962:	f9d9079b          	addw	a5,s2,-99
 966:	0ff7f713          	zext.b	a4,a5
 96a:	10eb6f63          	bltu	s6,a4,a88 <vprintf+0x190>
 96e:	00271793          	sll	a5,a4,0x2
 972:	00000717          	auipc	a4,0x0
 976:	55e70713          	add	a4,a4,1374 # ed0 <malloc+0x326>
 97a:	97ba                	add	a5,a5,a4
 97c:	439c                	lw	a5,0(a5)
 97e:	97ba                	add	a5,a5,a4
 980:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 982:	008b8913          	add	s2,s7,8
 986:	4685                	li	a3,1
 988:	4629                	li	a2,10
 98a:	000ba583          	lw	a1,0(s7)
 98e:	8556                	mv	a0,s5
 990:	00000097          	auipc	ra,0x0
 994:	ebc080e7          	jalr	-324(ra) # 84c <printint>
 998:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 99a:	4981                	li	s3,0
 99c:	b745                	j	93c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 99e:	008b8913          	add	s2,s7,8
 9a2:	4681                	li	a3,0
 9a4:	4629                	li	a2,10
 9a6:	000ba583          	lw	a1,0(s7)
 9aa:	8556                	mv	a0,s5
 9ac:	00000097          	auipc	ra,0x0
 9b0:	ea0080e7          	jalr	-352(ra) # 84c <printint>
 9b4:	8bca                	mv	s7,s2
      state = 0;
 9b6:	4981                	li	s3,0
 9b8:	b751                	j	93c <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 9ba:	008b8913          	add	s2,s7,8
 9be:	4681                	li	a3,0
 9c0:	4641                	li	a2,16
 9c2:	000ba583          	lw	a1,0(s7)
 9c6:	8556                	mv	a0,s5
 9c8:	00000097          	auipc	ra,0x0
 9cc:	e84080e7          	jalr	-380(ra) # 84c <printint>
 9d0:	8bca                	mv	s7,s2
      state = 0;
 9d2:	4981                	li	s3,0
 9d4:	b7a5                	j	93c <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 9d6:	008b8c13          	add	s8,s7,8
 9da:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 9de:	03000593          	li	a1,48
 9e2:	8556                	mv	a0,s5
 9e4:	00000097          	auipc	ra,0x0
 9e8:	e46080e7          	jalr	-442(ra) # 82a <putc>
  putc(fd, 'x');
 9ec:	07800593          	li	a1,120
 9f0:	8556                	mv	a0,s5
 9f2:	00000097          	auipc	ra,0x0
 9f6:	e38080e7          	jalr	-456(ra) # 82a <putc>
 9fa:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9fc:	00000b97          	auipc	s7,0x0
 a00:	52cb8b93          	add	s7,s7,1324 # f28 <digits>
 a04:	03c9d793          	srl	a5,s3,0x3c
 a08:	97de                	add	a5,a5,s7
 a0a:	0007c583          	lbu	a1,0(a5)
 a0e:	8556                	mv	a0,s5
 a10:	00000097          	auipc	ra,0x0
 a14:	e1a080e7          	jalr	-486(ra) # 82a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a18:	0992                	sll	s3,s3,0x4
 a1a:	397d                	addw	s2,s2,-1
 a1c:	fe0914e3          	bnez	s2,a04 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 a20:	8be2                	mv	s7,s8
      state = 0;
 a22:	4981                	li	s3,0
 a24:	bf21                	j	93c <vprintf+0x44>
        s = va_arg(ap, char*);
 a26:	008b8993          	add	s3,s7,8
 a2a:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 a2e:	02090163          	beqz	s2,a50 <vprintf+0x158>
        while(*s != 0){
 a32:	00094583          	lbu	a1,0(s2)
 a36:	c9a5                	beqz	a1,aa6 <vprintf+0x1ae>
          putc(fd, *s);
 a38:	8556                	mv	a0,s5
 a3a:	00000097          	auipc	ra,0x0
 a3e:	df0080e7          	jalr	-528(ra) # 82a <putc>
          s++;
 a42:	0905                	add	s2,s2,1
        while(*s != 0){
 a44:	00094583          	lbu	a1,0(s2)
 a48:	f9e5                	bnez	a1,a38 <vprintf+0x140>
        s = va_arg(ap, char*);
 a4a:	8bce                	mv	s7,s3
      state = 0;
 a4c:	4981                	li	s3,0
 a4e:	b5fd                	j	93c <vprintf+0x44>
          s = "(null)";
 a50:	00000917          	auipc	s2,0x0
 a54:	47890913          	add	s2,s2,1144 # ec8 <malloc+0x31e>
        while(*s != 0){
 a58:	02800593          	li	a1,40
 a5c:	bff1                	j	a38 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 a5e:	008b8913          	add	s2,s7,8
 a62:	000bc583          	lbu	a1,0(s7)
 a66:	8556                	mv	a0,s5
 a68:	00000097          	auipc	ra,0x0
 a6c:	dc2080e7          	jalr	-574(ra) # 82a <putc>
 a70:	8bca                	mv	s7,s2
      state = 0;
 a72:	4981                	li	s3,0
 a74:	b5e1                	j	93c <vprintf+0x44>
        putc(fd, c);
 a76:	02500593          	li	a1,37
 a7a:	8556                	mv	a0,s5
 a7c:	00000097          	auipc	ra,0x0
 a80:	dae080e7          	jalr	-594(ra) # 82a <putc>
      state = 0;
 a84:	4981                	li	s3,0
 a86:	bd5d                	j	93c <vprintf+0x44>
        putc(fd, '%');
 a88:	02500593          	li	a1,37
 a8c:	8556                	mv	a0,s5
 a8e:	00000097          	auipc	ra,0x0
 a92:	d9c080e7          	jalr	-612(ra) # 82a <putc>
        putc(fd, c);
 a96:	85ca                	mv	a1,s2
 a98:	8556                	mv	a0,s5
 a9a:	00000097          	auipc	ra,0x0
 a9e:	d90080e7          	jalr	-624(ra) # 82a <putc>
      state = 0;
 aa2:	4981                	li	s3,0
 aa4:	bd61                	j	93c <vprintf+0x44>
        s = va_arg(ap, char*);
 aa6:	8bce                	mv	s7,s3
      state = 0;
 aa8:	4981                	li	s3,0
 aaa:	bd49                	j	93c <vprintf+0x44>
    }
  }
}
 aac:	60a6                	ld	ra,72(sp)
 aae:	6406                	ld	s0,64(sp)
 ab0:	74e2                	ld	s1,56(sp)
 ab2:	7942                	ld	s2,48(sp)
 ab4:	79a2                	ld	s3,40(sp)
 ab6:	7a02                	ld	s4,32(sp)
 ab8:	6ae2                	ld	s5,24(sp)
 aba:	6b42                	ld	s6,16(sp)
 abc:	6ba2                	ld	s7,8(sp)
 abe:	6c02                	ld	s8,0(sp)
 ac0:	6161                	add	sp,sp,80
 ac2:	8082                	ret

0000000000000ac4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 ac4:	715d                	add	sp,sp,-80
 ac6:	ec06                	sd	ra,24(sp)
 ac8:	e822                	sd	s0,16(sp)
 aca:	1000                	add	s0,sp,32
 acc:	e010                	sd	a2,0(s0)
 ace:	e414                	sd	a3,8(s0)
 ad0:	e818                	sd	a4,16(s0)
 ad2:	ec1c                	sd	a5,24(s0)
 ad4:	03043023          	sd	a6,32(s0)
 ad8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 adc:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 ae0:	8622                	mv	a2,s0
 ae2:	00000097          	auipc	ra,0x0
 ae6:	e16080e7          	jalr	-490(ra) # 8f8 <vprintf>
}
 aea:	60e2                	ld	ra,24(sp)
 aec:	6442                	ld	s0,16(sp)
 aee:	6161                	add	sp,sp,80
 af0:	8082                	ret

0000000000000af2 <printf>:

void
printf(const char *fmt, ...)
{
 af2:	711d                	add	sp,sp,-96
 af4:	ec06                	sd	ra,24(sp)
 af6:	e822                	sd	s0,16(sp)
 af8:	1000                	add	s0,sp,32
 afa:	e40c                	sd	a1,8(s0)
 afc:	e810                	sd	a2,16(s0)
 afe:	ec14                	sd	a3,24(s0)
 b00:	f018                	sd	a4,32(s0)
 b02:	f41c                	sd	a5,40(s0)
 b04:	03043823          	sd	a6,48(s0)
 b08:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b0c:	00840613          	add	a2,s0,8
 b10:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b14:	85aa                	mv	a1,a0
 b16:	4505                	li	a0,1
 b18:	00000097          	auipc	ra,0x0
 b1c:	de0080e7          	jalr	-544(ra) # 8f8 <vprintf>
}
 b20:	60e2                	ld	ra,24(sp)
 b22:	6442                	ld	s0,16(sp)
 b24:	6125                	add	sp,sp,96
 b26:	8082                	ret

0000000000000b28 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b28:	1141                	add	sp,sp,-16
 b2a:	e422                	sd	s0,8(sp)
 b2c:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b2e:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b32:	00000797          	auipc	a5,0x0
 b36:	4ce7b783          	ld	a5,1230(a5) # 1000 <freep>
 b3a:	a02d                	j	b64 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b3c:	4618                	lw	a4,8(a2)
 b3e:	9f2d                	addw	a4,a4,a1
 b40:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b44:	6398                	ld	a4,0(a5)
 b46:	6310                	ld	a2,0(a4)
 b48:	a83d                	j	b86 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b4a:	ff852703          	lw	a4,-8(a0)
 b4e:	9f31                	addw	a4,a4,a2
 b50:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b52:	ff053683          	ld	a3,-16(a0)
 b56:	a091                	j	b9a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b58:	6398                	ld	a4,0(a5)
 b5a:	00e7e463          	bltu	a5,a4,b62 <free+0x3a>
 b5e:	00e6ea63          	bltu	a3,a4,b72 <free+0x4a>
{
 b62:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b64:	fed7fae3          	bgeu	a5,a3,b58 <free+0x30>
 b68:	6398                	ld	a4,0(a5)
 b6a:	00e6e463          	bltu	a3,a4,b72 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b6e:	fee7eae3          	bltu	a5,a4,b62 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 b72:	ff852583          	lw	a1,-8(a0)
 b76:	6390                	ld	a2,0(a5)
 b78:	02059813          	sll	a6,a1,0x20
 b7c:	01c85713          	srl	a4,a6,0x1c
 b80:	9736                	add	a4,a4,a3
 b82:	fae60de3          	beq	a2,a4,b3c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 b86:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 b8a:	4790                	lw	a2,8(a5)
 b8c:	02061593          	sll	a1,a2,0x20
 b90:	01c5d713          	srl	a4,a1,0x1c
 b94:	973e                	add	a4,a4,a5
 b96:	fae68ae3          	beq	a3,a4,b4a <free+0x22>
    p->s.ptr = bp->s.ptr;
 b9a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 b9c:	00000717          	auipc	a4,0x0
 ba0:	46f73223          	sd	a5,1124(a4) # 1000 <freep>
}
 ba4:	6422                	ld	s0,8(sp)
 ba6:	0141                	add	sp,sp,16
 ba8:	8082                	ret

0000000000000baa <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 baa:	7139                	add	sp,sp,-64
 bac:	fc06                	sd	ra,56(sp)
 bae:	f822                	sd	s0,48(sp)
 bb0:	f426                	sd	s1,40(sp)
 bb2:	f04a                	sd	s2,32(sp)
 bb4:	ec4e                	sd	s3,24(sp)
 bb6:	e852                	sd	s4,16(sp)
 bb8:	e456                	sd	s5,8(sp)
 bba:	e05a                	sd	s6,0(sp)
 bbc:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bbe:	02051493          	sll	s1,a0,0x20
 bc2:	9081                	srl	s1,s1,0x20
 bc4:	04bd                	add	s1,s1,15
 bc6:	8091                	srl	s1,s1,0x4
 bc8:	0014899b          	addw	s3,s1,1
 bcc:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 bce:	00000517          	auipc	a0,0x0
 bd2:	43253503          	ld	a0,1074(a0) # 1000 <freep>
 bd6:	c515                	beqz	a0,c02 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bd8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bda:	4798                	lw	a4,8(a5)
 bdc:	02977f63          	bgeu	a4,s1,c1a <malloc+0x70>
  if(nu < 4096)
 be0:	8a4e                	mv	s4,s3
 be2:	0009871b          	sext.w	a4,s3
 be6:	6685                	lui	a3,0x1
 be8:	00d77363          	bgeu	a4,a3,bee <malloc+0x44>
 bec:	6a05                	lui	s4,0x1
 bee:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 bf2:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bf6:	00000917          	auipc	s2,0x0
 bfa:	40a90913          	add	s2,s2,1034 # 1000 <freep>
  if(p == (char*)-1)
 bfe:	5afd                	li	s5,-1
 c00:	a895                	j	c74 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 c02:	00000797          	auipc	a5,0x0
 c06:	40e78793          	add	a5,a5,1038 # 1010 <base>
 c0a:	00000717          	auipc	a4,0x0
 c0e:	3ef73b23          	sd	a5,1014(a4) # 1000 <freep>
 c12:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 c14:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 c18:	b7e1                	j	be0 <malloc+0x36>
      if(p->s.size == nunits)
 c1a:	02e48c63          	beq	s1,a4,c52 <malloc+0xa8>
        p->s.size -= nunits;
 c1e:	4137073b          	subw	a4,a4,s3
 c22:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c24:	02071693          	sll	a3,a4,0x20
 c28:	01c6d713          	srl	a4,a3,0x1c
 c2c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c2e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c32:	00000717          	auipc	a4,0x0
 c36:	3ca73723          	sd	a0,974(a4) # 1000 <freep>
      return (void*)(p + 1);
 c3a:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 c3e:	70e2                	ld	ra,56(sp)
 c40:	7442                	ld	s0,48(sp)
 c42:	74a2                	ld	s1,40(sp)
 c44:	7902                	ld	s2,32(sp)
 c46:	69e2                	ld	s3,24(sp)
 c48:	6a42                	ld	s4,16(sp)
 c4a:	6aa2                	ld	s5,8(sp)
 c4c:	6b02                	ld	s6,0(sp)
 c4e:	6121                	add	sp,sp,64
 c50:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 c52:	6398                	ld	a4,0(a5)
 c54:	e118                	sd	a4,0(a0)
 c56:	bff1                	j	c32 <malloc+0x88>
  hp->s.size = nu;
 c58:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c5c:	0541                	add	a0,a0,16
 c5e:	00000097          	auipc	ra,0x0
 c62:	eca080e7          	jalr	-310(ra) # b28 <free>
  return freep;
 c66:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 c6a:	d971                	beqz	a0,c3e <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c6c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c6e:	4798                	lw	a4,8(a5)
 c70:	fa9775e3          	bgeu	a4,s1,c1a <malloc+0x70>
    if(p == freep)
 c74:	00093703          	ld	a4,0(s2)
 c78:	853e                	mv	a0,a5
 c7a:	fef719e3          	bne	a4,a5,c6c <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 c7e:	8552                	mv	a0,s4
 c80:	00000097          	auipc	ra,0x0
 c84:	b72080e7          	jalr	-1166(ra) # 7f2 <sbrk>
  if(p == (char*)-1)
 c88:	fd5518e3          	bne	a0,s5,c58 <malloc+0xae>
        return 0;
 c8c:	4501                	li	a0,0
 c8e:	bf45                	j	c3e <malloc+0x94>
