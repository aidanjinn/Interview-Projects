
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	1141                	add	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	add	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       6:	611c                	ld	a5,0(a0)
       8:	80000737          	lui	a4,0x80000
       c:	ffe74713          	xor	a4,a4,-2
      10:	02e7f7b3          	remu	a5,a5,a4
      14:	0785                	add	a5,a5,1
    hi = x / 127773;
    lo = x % 127773;
      16:	66fd                	lui	a3,0x1f
      18:	31d68693          	add	a3,a3,797 # 1f31d <base+0x1cf15>
      1c:	02d7e733          	rem	a4,a5,a3
    x = 16807 * lo - 2836 * hi;
      20:	6611                	lui	a2,0x4
      22:	1a760613          	add	a2,a2,423 # 41a7 <base+0x1d9f>
      26:	02c70733          	mul	a4,a4,a2
    hi = x / 127773;
      2a:	02d7c7b3          	div	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      2e:	76fd                	lui	a3,0xfffff
      30:	4ec68693          	add	a3,a3,1260 # fffffffffffff4ec <base+0xffffffffffffd0e4>
      34:	02d787b3          	mul	a5,a5,a3
      38:	97ba                	add	a5,a5,a4
    if (x < 0)
      3a:	0007c963          	bltz	a5,4c <do_rand+0x4c>
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      3e:	17fd                	add	a5,a5,-1
    *ctx = x;
      40:	e11c                	sd	a5,0(a0)
    return (x);
}
      42:	0007851b          	sext.w	a0,a5
      46:	6422                	ld	s0,8(sp)
      48:	0141                	add	sp,sp,16
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
      58:	1141                	add	sp,sp,-16
      5a:	e406                	sd	ra,8(sp)
      5c:	e022                	sd	s0,0(sp)
      5e:	0800                	add	s0,sp,16
    return (do_rand(&rand_next));
      60:	00002517          	auipc	a0,0x2
      64:	fa050513          	add	a0,a0,-96 # 2000 <rand_next>
      68:	00000097          	auipc	ra,0x0
      6c:	f98080e7          	jalr	-104(ra) # 0 <do_rand>
}
      70:	60a2                	ld	ra,8(sp)
      72:	6402                	ld	s0,0(sp)
      74:	0141                	add	sp,sp,16
      76:	8082                	ret

0000000000000078 <go>:

void
go(int which_child)
{
      78:	7159                	add	sp,sp,-112
      7a:	f486                	sd	ra,104(sp)
      7c:	f0a2                	sd	s0,96(sp)
      7e:	eca6                	sd	s1,88(sp)
      80:	e8ca                	sd	s2,80(sp)
      82:	e4ce                	sd	s3,72(sp)
      84:	e0d2                	sd	s4,64(sp)
      86:	fc56                	sd	s5,56(sp)
      88:	f85a                	sd	s6,48(sp)
      8a:	1880                	add	s0,sp,112
      8c:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      8e:	4501                	li	a0,0
      90:	00001097          	auipc	ra,0x1
      94:	e80080e7          	jalr	-384(ra) # f10 <sbrk>
      98:	8aaa                	mv	s5,a0
  uint64 iters = 0;

  mkdir("grindir");
      9a:	00001517          	auipc	a0,0x1
      9e:	31650513          	add	a0,a0,790 # 13b0 <malloc+0xe8>
      a2:	00001097          	auipc	ra,0x1
      a6:	e4e080e7          	jalr	-434(ra) # ef0 <mkdir>
  if(chdir("grindir") != 0){
      aa:	00001517          	auipc	a0,0x1
      ae:	30650513          	add	a0,a0,774 # 13b0 <malloc+0xe8>
      b2:	00001097          	auipc	ra,0x1
      b6:	e46080e7          	jalr	-442(ra) # ef8 <chdir>
      ba:	cd11                	beqz	a0,d6 <go+0x5e>
    printf("grind: chdir grindir failed\n");
      bc:	00001517          	auipc	a0,0x1
      c0:	2fc50513          	add	a0,a0,764 # 13b8 <malloc+0xf0>
      c4:	00001097          	auipc	ra,0x1
      c8:	14c080e7          	jalr	332(ra) # 1210 <printf>
    exit(1);
      cc:	4505                	li	a0,1
      ce:	00001097          	auipc	ra,0x1
      d2:	dba080e7          	jalr	-582(ra) # e88 <exit>
  }
  chdir("/");
      d6:	00001517          	auipc	a0,0x1
      da:	30250513          	add	a0,a0,770 # 13d8 <malloc+0x110>
      de:	00001097          	auipc	ra,0x1
      e2:	e1a080e7          	jalr	-486(ra) # ef8 <chdir>
      e6:	00001997          	auipc	s3,0x1
      ea:	30298993          	add	s3,s3,770 # 13e8 <malloc+0x120>
      ee:	c489                	beqz	s1,f8 <go+0x80>
      f0:	00001997          	auipc	s3,0x1
      f4:	2f098993          	add	s3,s3,752 # 13e0 <malloc+0x118>
  uint64 iters = 0;
      f8:	4481                	li	s1,0
  int fd = -1;
      fa:	5a7d                	li	s4,-1
      fc:	00001917          	auipc	s2,0x1
     100:	59c90913          	add	s2,s2,1436 # 1698 <malloc+0x3d0>
     104:	a839                	j	122 <go+0xaa>
    iters++;
    if((iters % 500) == 0)
      write(1, which_child?"B":"A", 1);
    int what = rand() % 23;
    if(what == 1){
      close(open("grindir/../a", O_CREATE|O_RDWR));
     106:	20200593          	li	a1,514
     10a:	00001517          	auipc	a0,0x1
     10e:	2e650513          	add	a0,a0,742 # 13f0 <malloc+0x128>
     112:	00001097          	auipc	ra,0x1
     116:	db6080e7          	jalr	-586(ra) # ec8 <open>
     11a:	00001097          	auipc	ra,0x1
     11e:	d96080e7          	jalr	-618(ra) # eb0 <close>
    iters++;
     122:	0485                	add	s1,s1,1
    if((iters % 500) == 0)
     124:	1f400793          	li	a5,500
     128:	02f4f7b3          	remu	a5,s1,a5
     12c:	eb81                	bnez	a5,13c <go+0xc4>
      write(1, which_child?"B":"A", 1);
     12e:	4605                	li	a2,1
     130:	85ce                	mv	a1,s3
     132:	4505                	li	a0,1
     134:	00001097          	auipc	ra,0x1
     138:	d74080e7          	jalr	-652(ra) # ea8 <write>
    int what = rand() % 23;
     13c:	00000097          	auipc	ra,0x0
     140:	f1c080e7          	jalr	-228(ra) # 58 <rand>
     144:	47dd                	li	a5,23
     146:	02f5653b          	remw	a0,a0,a5
    if(what == 1){
     14a:	4785                	li	a5,1
     14c:	faf50de3          	beq	a0,a5,106 <go+0x8e>
    } else if(what == 2){
     150:	47d9                	li	a5,22
     152:	fca7e8e3          	bltu	a5,a0,122 <go+0xaa>
     156:	050a                	sll	a0,a0,0x2
     158:	954a                	add	a0,a0,s2
     15a:	411c                	lw	a5,0(a0)
     15c:	97ca                	add	a5,a5,s2
     15e:	8782                	jr	a5
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     160:	20200593          	li	a1,514
     164:	00001517          	auipc	a0,0x1
     168:	29c50513          	add	a0,a0,668 # 1400 <malloc+0x138>
     16c:	00001097          	auipc	ra,0x1
     170:	d5c080e7          	jalr	-676(ra) # ec8 <open>
     174:	00001097          	auipc	ra,0x1
     178:	d3c080e7          	jalr	-708(ra) # eb0 <close>
     17c:	b75d                	j	122 <go+0xaa>
    } else if(what == 3){
      unlink("grindir/../a");
     17e:	00001517          	auipc	a0,0x1
     182:	27250513          	add	a0,a0,626 # 13f0 <malloc+0x128>
     186:	00001097          	auipc	ra,0x1
     18a:	d52080e7          	jalr	-686(ra) # ed8 <unlink>
     18e:	bf51                	j	122 <go+0xaa>
    } else if(what == 4){
      if(chdir("grindir") != 0){
     190:	00001517          	auipc	a0,0x1
     194:	22050513          	add	a0,a0,544 # 13b0 <malloc+0xe8>
     198:	00001097          	auipc	ra,0x1
     19c:	d60080e7          	jalr	-672(ra) # ef8 <chdir>
     1a0:	e115                	bnez	a0,1c4 <go+0x14c>
        printf("grind: chdir grindir failed\n");
        exit(1);
      }
      unlink("../b");
     1a2:	00001517          	auipc	a0,0x1
     1a6:	27650513          	add	a0,a0,630 # 1418 <malloc+0x150>
     1aa:	00001097          	auipc	ra,0x1
     1ae:	d2e080e7          	jalr	-722(ra) # ed8 <unlink>
      chdir("/");
     1b2:	00001517          	auipc	a0,0x1
     1b6:	22650513          	add	a0,a0,550 # 13d8 <malloc+0x110>
     1ba:	00001097          	auipc	ra,0x1
     1be:	d3e080e7          	jalr	-706(ra) # ef8 <chdir>
     1c2:	b785                	j	122 <go+0xaa>
        printf("grind: chdir grindir failed\n");
     1c4:	00001517          	auipc	a0,0x1
     1c8:	1f450513          	add	a0,a0,500 # 13b8 <malloc+0xf0>
     1cc:	00001097          	auipc	ra,0x1
     1d0:	044080e7          	jalr	68(ra) # 1210 <printf>
        exit(1);
     1d4:	4505                	li	a0,1
     1d6:	00001097          	auipc	ra,0x1
     1da:	cb2080e7          	jalr	-846(ra) # e88 <exit>
    } else if(what == 5){
      close(fd);
     1de:	8552                	mv	a0,s4
     1e0:	00001097          	auipc	ra,0x1
     1e4:	cd0080e7          	jalr	-816(ra) # eb0 <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     1e8:	20200593          	li	a1,514
     1ec:	00001517          	auipc	a0,0x1
     1f0:	23450513          	add	a0,a0,564 # 1420 <malloc+0x158>
     1f4:	00001097          	auipc	ra,0x1
     1f8:	cd4080e7          	jalr	-812(ra) # ec8 <open>
     1fc:	8a2a                	mv	s4,a0
     1fe:	b715                	j	122 <go+0xaa>
    } else if(what == 6){
      close(fd);
     200:	8552                	mv	a0,s4
     202:	00001097          	auipc	ra,0x1
     206:	cae080e7          	jalr	-850(ra) # eb0 <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     20a:	20200593          	li	a1,514
     20e:	00001517          	auipc	a0,0x1
     212:	22250513          	add	a0,a0,546 # 1430 <malloc+0x168>
     216:	00001097          	auipc	ra,0x1
     21a:	cb2080e7          	jalr	-846(ra) # ec8 <open>
     21e:	8a2a                	mv	s4,a0
     220:	b709                	j	122 <go+0xaa>
    } else if(what == 7){
      write(fd, buf, sizeof(buf));
     222:	3e700613          	li	a2,999
     226:	00002597          	auipc	a1,0x2
     22a:	dfa58593          	add	a1,a1,-518 # 2020 <buf.0>
     22e:	8552                	mv	a0,s4
     230:	00001097          	auipc	ra,0x1
     234:	c78080e7          	jalr	-904(ra) # ea8 <write>
     238:	b5ed                	j	122 <go+0xaa>
    } else if(what == 8){
      read(fd, buf, sizeof(buf));
     23a:	3e700613          	li	a2,999
     23e:	00002597          	auipc	a1,0x2
     242:	de258593          	add	a1,a1,-542 # 2020 <buf.0>
     246:	8552                	mv	a0,s4
     248:	00001097          	auipc	ra,0x1
     24c:	c58080e7          	jalr	-936(ra) # ea0 <read>
     250:	bdc9                	j	122 <go+0xaa>
    } else if(what == 9){
      mkdir("grindir/../a");
     252:	00001517          	auipc	a0,0x1
     256:	19e50513          	add	a0,a0,414 # 13f0 <malloc+0x128>
     25a:	00001097          	auipc	ra,0x1
     25e:	c96080e7          	jalr	-874(ra) # ef0 <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     262:	20200593          	li	a1,514
     266:	00001517          	auipc	a0,0x1
     26a:	1e250513          	add	a0,a0,482 # 1448 <malloc+0x180>
     26e:	00001097          	auipc	ra,0x1
     272:	c5a080e7          	jalr	-934(ra) # ec8 <open>
     276:	00001097          	auipc	ra,0x1
     27a:	c3a080e7          	jalr	-966(ra) # eb0 <close>
      unlink("a/a");
     27e:	00001517          	auipc	a0,0x1
     282:	1da50513          	add	a0,a0,474 # 1458 <malloc+0x190>
     286:	00001097          	auipc	ra,0x1
     28a:	c52080e7          	jalr	-942(ra) # ed8 <unlink>
     28e:	bd51                	j	122 <go+0xaa>
    } else if(what == 10){
      mkdir("/../b");
     290:	00001517          	auipc	a0,0x1
     294:	1d050513          	add	a0,a0,464 # 1460 <malloc+0x198>
     298:	00001097          	auipc	ra,0x1
     29c:	c58080e7          	jalr	-936(ra) # ef0 <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     2a0:	20200593          	li	a1,514
     2a4:	00001517          	auipc	a0,0x1
     2a8:	1c450513          	add	a0,a0,452 # 1468 <malloc+0x1a0>
     2ac:	00001097          	auipc	ra,0x1
     2b0:	c1c080e7          	jalr	-996(ra) # ec8 <open>
     2b4:	00001097          	auipc	ra,0x1
     2b8:	bfc080e7          	jalr	-1028(ra) # eb0 <close>
      unlink("b/b");
     2bc:	00001517          	auipc	a0,0x1
     2c0:	1bc50513          	add	a0,a0,444 # 1478 <malloc+0x1b0>
     2c4:	00001097          	auipc	ra,0x1
     2c8:	c14080e7          	jalr	-1004(ra) # ed8 <unlink>
     2cc:	bd99                	j	122 <go+0xaa>
    } else if(what == 11){
      unlink("b");
     2ce:	00001517          	auipc	a0,0x1
     2d2:	17250513          	add	a0,a0,370 # 1440 <malloc+0x178>
     2d6:	00001097          	auipc	ra,0x1
     2da:	c02080e7          	jalr	-1022(ra) # ed8 <unlink>
      link("../grindir/./../a", "../b");
     2de:	00001597          	auipc	a1,0x1
     2e2:	13a58593          	add	a1,a1,314 # 1418 <malloc+0x150>
     2e6:	00001517          	auipc	a0,0x1
     2ea:	19a50513          	add	a0,a0,410 # 1480 <malloc+0x1b8>
     2ee:	00001097          	auipc	ra,0x1
     2f2:	bfa080e7          	jalr	-1030(ra) # ee8 <link>
     2f6:	b535                	j	122 <go+0xaa>
    } else if(what == 12){
      unlink("../grindir/../a");
     2f8:	00001517          	auipc	a0,0x1
     2fc:	1a050513          	add	a0,a0,416 # 1498 <malloc+0x1d0>
     300:	00001097          	auipc	ra,0x1
     304:	bd8080e7          	jalr	-1064(ra) # ed8 <unlink>
      link(".././b", "/grindir/../a");
     308:	00001597          	auipc	a1,0x1
     30c:	11858593          	add	a1,a1,280 # 1420 <malloc+0x158>
     310:	00001517          	auipc	a0,0x1
     314:	19850513          	add	a0,a0,408 # 14a8 <malloc+0x1e0>
     318:	00001097          	auipc	ra,0x1
     31c:	bd0080e7          	jalr	-1072(ra) # ee8 <link>
     320:	b509                	j	122 <go+0xaa>
    } else if(what == 13){
      int pid = fork();
     322:	00001097          	auipc	ra,0x1
     326:	b5e080e7          	jalr	-1186(ra) # e80 <fork>
      if(pid == 0){
     32a:	c909                	beqz	a0,33c <go+0x2c4>
        exit(0);
      } else if(pid < 0){
     32c:	00054c63          	bltz	a0,344 <go+0x2cc>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     330:	4501                	li	a0,0
     332:	00001097          	auipc	ra,0x1
     336:	b5e080e7          	jalr	-1186(ra) # e90 <wait>
     33a:	b3e5                	j	122 <go+0xaa>
        exit(0);
     33c:	00001097          	auipc	ra,0x1
     340:	b4c080e7          	jalr	-1204(ra) # e88 <exit>
        printf("grind: fork failed\n");
     344:	00001517          	auipc	a0,0x1
     348:	16c50513          	add	a0,a0,364 # 14b0 <malloc+0x1e8>
     34c:	00001097          	auipc	ra,0x1
     350:	ec4080e7          	jalr	-316(ra) # 1210 <printf>
        exit(1);
     354:	4505                	li	a0,1
     356:	00001097          	auipc	ra,0x1
     35a:	b32080e7          	jalr	-1230(ra) # e88 <exit>
    } else if(what == 14){
      int pid = fork();
     35e:	00001097          	auipc	ra,0x1
     362:	b22080e7          	jalr	-1246(ra) # e80 <fork>
      if(pid == 0){
     366:	c909                	beqz	a0,378 <go+0x300>
        fork();
        fork();
        exit(0);
      } else if(pid < 0){
     368:	02054563          	bltz	a0,392 <go+0x31a>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     36c:	4501                	li	a0,0
     36e:	00001097          	auipc	ra,0x1
     372:	b22080e7          	jalr	-1246(ra) # e90 <wait>
     376:	b375                	j	122 <go+0xaa>
        fork();
     378:	00001097          	auipc	ra,0x1
     37c:	b08080e7          	jalr	-1272(ra) # e80 <fork>
        fork();
     380:	00001097          	auipc	ra,0x1
     384:	b00080e7          	jalr	-1280(ra) # e80 <fork>
        exit(0);
     388:	4501                	li	a0,0
     38a:	00001097          	auipc	ra,0x1
     38e:	afe080e7          	jalr	-1282(ra) # e88 <exit>
        printf("grind: fork failed\n");
     392:	00001517          	auipc	a0,0x1
     396:	11e50513          	add	a0,a0,286 # 14b0 <malloc+0x1e8>
     39a:	00001097          	auipc	ra,0x1
     39e:	e76080e7          	jalr	-394(ra) # 1210 <printf>
        exit(1);
     3a2:	4505                	li	a0,1
     3a4:	00001097          	auipc	ra,0x1
     3a8:	ae4080e7          	jalr	-1308(ra) # e88 <exit>
    } else if(what == 15){
      sbrk(6011);
     3ac:	6505                	lui	a0,0x1
     3ae:	77b50513          	add	a0,a0,1915 # 177b <digits+0x23>
     3b2:	00001097          	auipc	ra,0x1
     3b6:	b5e080e7          	jalr	-1186(ra) # f10 <sbrk>
     3ba:	b3a5                	j	122 <go+0xaa>
    } else if(what == 16){
      if(sbrk(0) > break0)
     3bc:	4501                	li	a0,0
     3be:	00001097          	auipc	ra,0x1
     3c2:	b52080e7          	jalr	-1198(ra) # f10 <sbrk>
     3c6:	d4aafee3          	bgeu	s5,a0,122 <go+0xaa>
        sbrk(-(sbrk(0) - break0));
     3ca:	4501                	li	a0,0
     3cc:	00001097          	auipc	ra,0x1
     3d0:	b44080e7          	jalr	-1212(ra) # f10 <sbrk>
     3d4:	40aa853b          	subw	a0,s5,a0
     3d8:	00001097          	auipc	ra,0x1
     3dc:	b38080e7          	jalr	-1224(ra) # f10 <sbrk>
     3e0:	b389                	j	122 <go+0xaa>
    } else if(what == 17){
      int pid = fork();
     3e2:	00001097          	auipc	ra,0x1
     3e6:	a9e080e7          	jalr	-1378(ra) # e80 <fork>
     3ea:	8b2a                	mv	s6,a0
      if(pid == 0){
     3ec:	c51d                	beqz	a0,41a <go+0x3a2>
        close(open("a", O_CREATE|O_RDWR));
        exit(0);
      } else if(pid < 0){
     3ee:	04054963          	bltz	a0,440 <go+0x3c8>
        printf("grind: fork failed\n");
        exit(1);
      }
      if(chdir("../grindir/..") != 0){
     3f2:	00001517          	auipc	a0,0x1
     3f6:	0d650513          	add	a0,a0,214 # 14c8 <malloc+0x200>
     3fa:	00001097          	auipc	ra,0x1
     3fe:	afe080e7          	jalr	-1282(ra) # ef8 <chdir>
     402:	ed21                	bnez	a0,45a <go+0x3e2>
        printf("grind: chdir failed\n");
        exit(1);
      }
      kill(pid);
     404:	855a                	mv	a0,s6
     406:	00001097          	auipc	ra,0x1
     40a:	ab2080e7          	jalr	-1358(ra) # eb8 <kill>
      wait(0);
     40e:	4501                	li	a0,0
     410:	00001097          	auipc	ra,0x1
     414:	a80080e7          	jalr	-1408(ra) # e90 <wait>
     418:	b329                	j	122 <go+0xaa>
        close(open("a", O_CREATE|O_RDWR));
     41a:	20200593          	li	a1,514
     41e:	00001517          	auipc	a0,0x1
     422:	07250513          	add	a0,a0,114 # 1490 <malloc+0x1c8>
     426:	00001097          	auipc	ra,0x1
     42a:	aa2080e7          	jalr	-1374(ra) # ec8 <open>
     42e:	00001097          	auipc	ra,0x1
     432:	a82080e7          	jalr	-1406(ra) # eb0 <close>
        exit(0);
     436:	4501                	li	a0,0
     438:	00001097          	auipc	ra,0x1
     43c:	a50080e7          	jalr	-1456(ra) # e88 <exit>
        printf("grind: fork failed\n");
     440:	00001517          	auipc	a0,0x1
     444:	07050513          	add	a0,a0,112 # 14b0 <malloc+0x1e8>
     448:	00001097          	auipc	ra,0x1
     44c:	dc8080e7          	jalr	-568(ra) # 1210 <printf>
        exit(1);
     450:	4505                	li	a0,1
     452:	00001097          	auipc	ra,0x1
     456:	a36080e7          	jalr	-1482(ra) # e88 <exit>
        printf("grind: chdir failed\n");
     45a:	00001517          	auipc	a0,0x1
     45e:	07e50513          	add	a0,a0,126 # 14d8 <malloc+0x210>
     462:	00001097          	auipc	ra,0x1
     466:	dae080e7          	jalr	-594(ra) # 1210 <printf>
        exit(1);
     46a:	4505                	li	a0,1
     46c:	00001097          	auipc	ra,0x1
     470:	a1c080e7          	jalr	-1508(ra) # e88 <exit>
    } else if(what == 18){
      int pid = fork();
     474:	00001097          	auipc	ra,0x1
     478:	a0c080e7          	jalr	-1524(ra) # e80 <fork>
      if(pid == 0){
     47c:	c909                	beqz	a0,48e <go+0x416>
        kill(getpid());
        exit(0);
      } else if(pid < 0){
     47e:	02054563          	bltz	a0,4a8 <go+0x430>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     482:	4501                	li	a0,0
     484:	00001097          	auipc	ra,0x1
     488:	a0c080e7          	jalr	-1524(ra) # e90 <wait>
     48c:	b959                	j	122 <go+0xaa>
        kill(getpid());
     48e:	00001097          	auipc	ra,0x1
     492:	a7a080e7          	jalr	-1414(ra) # f08 <getpid>
     496:	00001097          	auipc	ra,0x1
     49a:	a22080e7          	jalr	-1502(ra) # eb8 <kill>
        exit(0);
     49e:	4501                	li	a0,0
     4a0:	00001097          	auipc	ra,0x1
     4a4:	9e8080e7          	jalr	-1560(ra) # e88 <exit>
        printf("grind: fork failed\n");
     4a8:	00001517          	auipc	a0,0x1
     4ac:	00850513          	add	a0,a0,8 # 14b0 <malloc+0x1e8>
     4b0:	00001097          	auipc	ra,0x1
     4b4:	d60080e7          	jalr	-672(ra) # 1210 <printf>
        exit(1);
     4b8:	4505                	li	a0,1
     4ba:	00001097          	auipc	ra,0x1
     4be:	9ce080e7          	jalr	-1586(ra) # e88 <exit>
    } else if(what == 19){
      int fds[2];
      if(pipe(fds) < 0){
     4c2:	fa840513          	add	a0,s0,-88
     4c6:	00001097          	auipc	ra,0x1
     4ca:	9d2080e7          	jalr	-1582(ra) # e98 <pipe>
     4ce:	02054b63          	bltz	a0,504 <go+0x48c>
        printf("grind: pipe failed\n");
        exit(1);
      }
      int pid = fork();
     4d2:	00001097          	auipc	ra,0x1
     4d6:	9ae080e7          	jalr	-1618(ra) # e80 <fork>
      if(pid == 0){
     4da:	c131                	beqz	a0,51e <go+0x4a6>
          printf("grind: pipe write failed\n");
        char c;
        if(read(fds[0], &c, 1) != 1)
          printf("grind: pipe read failed\n");
        exit(0);
      } else if(pid < 0){
     4dc:	0a054a63          	bltz	a0,590 <go+0x518>
        printf("grind: fork failed\n");
        exit(1);
      }
      close(fds[0]);
     4e0:	fa842503          	lw	a0,-88(s0)
     4e4:	00001097          	auipc	ra,0x1
     4e8:	9cc080e7          	jalr	-1588(ra) # eb0 <close>
      close(fds[1]);
     4ec:	fac42503          	lw	a0,-84(s0)
     4f0:	00001097          	auipc	ra,0x1
     4f4:	9c0080e7          	jalr	-1600(ra) # eb0 <close>
      wait(0);
     4f8:	4501                	li	a0,0
     4fa:	00001097          	auipc	ra,0x1
     4fe:	996080e7          	jalr	-1642(ra) # e90 <wait>
     502:	b105                	j	122 <go+0xaa>
        printf("grind: pipe failed\n");
     504:	00001517          	auipc	a0,0x1
     508:	fec50513          	add	a0,a0,-20 # 14f0 <malloc+0x228>
     50c:	00001097          	auipc	ra,0x1
     510:	d04080e7          	jalr	-764(ra) # 1210 <printf>
        exit(1);
     514:	4505                	li	a0,1
     516:	00001097          	auipc	ra,0x1
     51a:	972080e7          	jalr	-1678(ra) # e88 <exit>
        fork();
     51e:	00001097          	auipc	ra,0x1
     522:	962080e7          	jalr	-1694(ra) # e80 <fork>
        fork();
     526:	00001097          	auipc	ra,0x1
     52a:	95a080e7          	jalr	-1702(ra) # e80 <fork>
        if(write(fds[1], "x", 1) != 1)
     52e:	4605                	li	a2,1
     530:	00001597          	auipc	a1,0x1
     534:	fd858593          	add	a1,a1,-40 # 1508 <malloc+0x240>
     538:	fac42503          	lw	a0,-84(s0)
     53c:	00001097          	auipc	ra,0x1
     540:	96c080e7          	jalr	-1684(ra) # ea8 <write>
     544:	4785                	li	a5,1
     546:	02f51363          	bne	a0,a5,56c <go+0x4f4>
        if(read(fds[0], &c, 1) != 1)
     54a:	4605                	li	a2,1
     54c:	fa040593          	add	a1,s0,-96
     550:	fa842503          	lw	a0,-88(s0)
     554:	00001097          	auipc	ra,0x1
     558:	94c080e7          	jalr	-1716(ra) # ea0 <read>
     55c:	4785                	li	a5,1
     55e:	02f51063          	bne	a0,a5,57e <go+0x506>
        exit(0);
     562:	4501                	li	a0,0
     564:	00001097          	auipc	ra,0x1
     568:	924080e7          	jalr	-1756(ra) # e88 <exit>
          printf("grind: pipe write failed\n");
     56c:	00001517          	auipc	a0,0x1
     570:	fa450513          	add	a0,a0,-92 # 1510 <malloc+0x248>
     574:	00001097          	auipc	ra,0x1
     578:	c9c080e7          	jalr	-868(ra) # 1210 <printf>
     57c:	b7f9                	j	54a <go+0x4d2>
          printf("grind: pipe read failed\n");
     57e:	00001517          	auipc	a0,0x1
     582:	fb250513          	add	a0,a0,-78 # 1530 <malloc+0x268>
     586:	00001097          	auipc	ra,0x1
     58a:	c8a080e7          	jalr	-886(ra) # 1210 <printf>
     58e:	bfd1                	j	562 <go+0x4ea>
        printf("grind: fork failed\n");
     590:	00001517          	auipc	a0,0x1
     594:	f2050513          	add	a0,a0,-224 # 14b0 <malloc+0x1e8>
     598:	00001097          	auipc	ra,0x1
     59c:	c78080e7          	jalr	-904(ra) # 1210 <printf>
        exit(1);
     5a0:	4505                	li	a0,1
     5a2:	00001097          	auipc	ra,0x1
     5a6:	8e6080e7          	jalr	-1818(ra) # e88 <exit>
    } else if(what == 20){
      int pid = fork();
     5aa:	00001097          	auipc	ra,0x1
     5ae:	8d6080e7          	jalr	-1834(ra) # e80 <fork>
      if(pid == 0){
     5b2:	c909                	beqz	a0,5c4 <go+0x54c>
        chdir("a");
        unlink("../a");
        fd = open("x", O_CREATE|O_RDWR);
        unlink("x");
        exit(0);
      } else if(pid < 0){
     5b4:	06054f63          	bltz	a0,632 <go+0x5ba>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     5b8:	4501                	li	a0,0
     5ba:	00001097          	auipc	ra,0x1
     5be:	8d6080e7          	jalr	-1834(ra) # e90 <wait>
     5c2:	b685                	j	122 <go+0xaa>
        unlink("a");
     5c4:	00001517          	auipc	a0,0x1
     5c8:	ecc50513          	add	a0,a0,-308 # 1490 <malloc+0x1c8>
     5cc:	00001097          	auipc	ra,0x1
     5d0:	90c080e7          	jalr	-1780(ra) # ed8 <unlink>
        mkdir("a");
     5d4:	00001517          	auipc	a0,0x1
     5d8:	ebc50513          	add	a0,a0,-324 # 1490 <malloc+0x1c8>
     5dc:	00001097          	auipc	ra,0x1
     5e0:	914080e7          	jalr	-1772(ra) # ef0 <mkdir>
        chdir("a");
     5e4:	00001517          	auipc	a0,0x1
     5e8:	eac50513          	add	a0,a0,-340 # 1490 <malloc+0x1c8>
     5ec:	00001097          	auipc	ra,0x1
     5f0:	90c080e7          	jalr	-1780(ra) # ef8 <chdir>
        unlink("../a");
     5f4:	00001517          	auipc	a0,0x1
     5f8:	e0450513          	add	a0,a0,-508 # 13f8 <malloc+0x130>
     5fc:	00001097          	auipc	ra,0x1
     600:	8dc080e7          	jalr	-1828(ra) # ed8 <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     604:	20200593          	li	a1,514
     608:	00001517          	auipc	a0,0x1
     60c:	f0050513          	add	a0,a0,-256 # 1508 <malloc+0x240>
     610:	00001097          	auipc	ra,0x1
     614:	8b8080e7          	jalr	-1864(ra) # ec8 <open>
        unlink("x");
     618:	00001517          	auipc	a0,0x1
     61c:	ef050513          	add	a0,a0,-272 # 1508 <malloc+0x240>
     620:	00001097          	auipc	ra,0x1
     624:	8b8080e7          	jalr	-1864(ra) # ed8 <unlink>
        exit(0);
     628:	4501                	li	a0,0
     62a:	00001097          	auipc	ra,0x1
     62e:	85e080e7          	jalr	-1954(ra) # e88 <exit>
        printf("grind: fork failed\n");
     632:	00001517          	auipc	a0,0x1
     636:	e7e50513          	add	a0,a0,-386 # 14b0 <malloc+0x1e8>
     63a:	00001097          	auipc	ra,0x1
     63e:	bd6080e7          	jalr	-1066(ra) # 1210 <printf>
        exit(1);
     642:	4505                	li	a0,1
     644:	00001097          	auipc	ra,0x1
     648:	844080e7          	jalr	-1980(ra) # e88 <exit>
    } else if(what == 21){
      unlink("c");
     64c:	00001517          	auipc	a0,0x1
     650:	f0450513          	add	a0,a0,-252 # 1550 <malloc+0x288>
     654:	00001097          	auipc	ra,0x1
     658:	884080e7          	jalr	-1916(ra) # ed8 <unlink>
      // should always succeed. check that there are free i-nodes,
      // file descriptors, blocks.
      int fd1 = open("c", O_CREATE|O_RDWR);
     65c:	20200593          	li	a1,514
     660:	00001517          	auipc	a0,0x1
     664:	ef050513          	add	a0,a0,-272 # 1550 <malloc+0x288>
     668:	00001097          	auipc	ra,0x1
     66c:	860080e7          	jalr	-1952(ra) # ec8 <open>
     670:	8b2a                	mv	s6,a0
      if(fd1 < 0){
     672:	04054f63          	bltz	a0,6d0 <go+0x658>
        printf("grind: create c failed\n");
        exit(1);
      }
      if(write(fd1, "x", 1) != 1){
     676:	4605                	li	a2,1
     678:	00001597          	auipc	a1,0x1
     67c:	e9058593          	add	a1,a1,-368 # 1508 <malloc+0x240>
     680:	00001097          	auipc	ra,0x1
     684:	828080e7          	jalr	-2008(ra) # ea8 <write>
     688:	4785                	li	a5,1
     68a:	06f51063          	bne	a0,a5,6ea <go+0x672>
        printf("grind: write c failed\n");
        exit(1);
      }
      struct stat st;
      if(fstat(fd1, &st) != 0){
     68e:	fa840593          	add	a1,s0,-88
     692:	855a                	mv	a0,s6
     694:	00001097          	auipc	ra,0x1
     698:	84c080e7          	jalr	-1972(ra) # ee0 <fstat>
     69c:	e525                	bnez	a0,704 <go+0x68c>
        printf("grind: fstat failed\n");
        exit(1);
      }
      if(st.size != 1){
     69e:	fb843583          	ld	a1,-72(s0)
     6a2:	4785                	li	a5,1
     6a4:	06f59d63          	bne	a1,a5,71e <go+0x6a6>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
        exit(1);
      }
      if(st.ino > 200){
     6a8:	fac42583          	lw	a1,-84(s0)
     6ac:	0c800793          	li	a5,200
     6b0:	08b7e563          	bltu	a5,a1,73a <go+0x6c2>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
        exit(1);
      }
      close(fd1);
     6b4:	855a                	mv	a0,s6
     6b6:	00000097          	auipc	ra,0x0
     6ba:	7fa080e7          	jalr	2042(ra) # eb0 <close>
      unlink("c");
     6be:	00001517          	auipc	a0,0x1
     6c2:	e9250513          	add	a0,a0,-366 # 1550 <malloc+0x288>
     6c6:	00001097          	auipc	ra,0x1
     6ca:	812080e7          	jalr	-2030(ra) # ed8 <unlink>
     6ce:	bc91                	j	122 <go+0xaa>
        printf("grind: create c failed\n");
     6d0:	00001517          	auipc	a0,0x1
     6d4:	e8850513          	add	a0,a0,-376 # 1558 <malloc+0x290>
     6d8:	00001097          	auipc	ra,0x1
     6dc:	b38080e7          	jalr	-1224(ra) # 1210 <printf>
        exit(1);
     6e0:	4505                	li	a0,1
     6e2:	00000097          	auipc	ra,0x0
     6e6:	7a6080e7          	jalr	1958(ra) # e88 <exit>
        printf("grind: write c failed\n");
     6ea:	00001517          	auipc	a0,0x1
     6ee:	e8650513          	add	a0,a0,-378 # 1570 <malloc+0x2a8>
     6f2:	00001097          	auipc	ra,0x1
     6f6:	b1e080e7          	jalr	-1250(ra) # 1210 <printf>
        exit(1);
     6fa:	4505                	li	a0,1
     6fc:	00000097          	auipc	ra,0x0
     700:	78c080e7          	jalr	1932(ra) # e88 <exit>
        printf("grind: fstat failed\n");
     704:	00001517          	auipc	a0,0x1
     708:	e8450513          	add	a0,a0,-380 # 1588 <malloc+0x2c0>
     70c:	00001097          	auipc	ra,0x1
     710:	b04080e7          	jalr	-1276(ra) # 1210 <printf>
        exit(1);
     714:	4505                	li	a0,1
     716:	00000097          	auipc	ra,0x0
     71a:	772080e7          	jalr	1906(ra) # e88 <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     71e:	2581                	sext.w	a1,a1
     720:	00001517          	auipc	a0,0x1
     724:	e8050513          	add	a0,a0,-384 # 15a0 <malloc+0x2d8>
     728:	00001097          	auipc	ra,0x1
     72c:	ae8080e7          	jalr	-1304(ra) # 1210 <printf>
        exit(1);
     730:	4505                	li	a0,1
     732:	00000097          	auipc	ra,0x0
     736:	756080e7          	jalr	1878(ra) # e88 <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     73a:	00001517          	auipc	a0,0x1
     73e:	e8e50513          	add	a0,a0,-370 # 15c8 <malloc+0x300>
     742:	00001097          	auipc	ra,0x1
     746:	ace080e7          	jalr	-1330(ra) # 1210 <printf>
        exit(1);
     74a:	4505                	li	a0,1
     74c:	00000097          	auipc	ra,0x0
     750:	73c080e7          	jalr	1852(ra) # e88 <exit>
    } else if(what == 22){
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     754:	f9840513          	add	a0,s0,-104
     758:	00000097          	auipc	ra,0x0
     75c:	740080e7          	jalr	1856(ra) # e98 <pipe>
     760:	10054063          	bltz	a0,860 <go+0x7e8>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     764:	fa040513          	add	a0,s0,-96
     768:	00000097          	auipc	ra,0x0
     76c:	730080e7          	jalr	1840(ra) # e98 <pipe>
     770:	10054663          	bltz	a0,87c <go+0x804>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     774:	00000097          	auipc	ra,0x0
     778:	70c080e7          	jalr	1804(ra) # e80 <fork>
      if(pid1 == 0){
     77c:	10050e63          	beqz	a0,898 <go+0x820>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     780:	1c054663          	bltz	a0,94c <go+0x8d4>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     784:	00000097          	auipc	ra,0x0
     788:	6fc080e7          	jalr	1788(ra) # e80 <fork>
      if(pid2 == 0){
     78c:	1c050e63          	beqz	a0,968 <go+0x8f0>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     790:	2a054a63          	bltz	a0,a44 <go+0x9cc>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     794:	f9842503          	lw	a0,-104(s0)
     798:	00000097          	auipc	ra,0x0
     79c:	718080e7          	jalr	1816(ra) # eb0 <close>
      close(aa[1]);
     7a0:	f9c42503          	lw	a0,-100(s0)
     7a4:	00000097          	auipc	ra,0x0
     7a8:	70c080e7          	jalr	1804(ra) # eb0 <close>
      close(bb[1]);
     7ac:	fa442503          	lw	a0,-92(s0)
     7b0:	00000097          	auipc	ra,0x0
     7b4:	700080e7          	jalr	1792(ra) # eb0 <close>
      char buf[4] = { 0, 0, 0, 0 };
     7b8:	f8042823          	sw	zero,-112(s0)
      read(bb[0], buf+0, 1);
     7bc:	4605                	li	a2,1
     7be:	f9040593          	add	a1,s0,-112
     7c2:	fa042503          	lw	a0,-96(s0)
     7c6:	00000097          	auipc	ra,0x0
     7ca:	6da080e7          	jalr	1754(ra) # ea0 <read>
      read(bb[0], buf+1, 1);
     7ce:	4605                	li	a2,1
     7d0:	f9140593          	add	a1,s0,-111
     7d4:	fa042503          	lw	a0,-96(s0)
     7d8:	00000097          	auipc	ra,0x0
     7dc:	6c8080e7          	jalr	1736(ra) # ea0 <read>
      read(bb[0], buf+2, 1);
     7e0:	4605                	li	a2,1
     7e2:	f9240593          	add	a1,s0,-110
     7e6:	fa042503          	lw	a0,-96(s0)
     7ea:	00000097          	auipc	ra,0x0
     7ee:	6b6080e7          	jalr	1718(ra) # ea0 <read>
      close(bb[0]);
     7f2:	fa042503          	lw	a0,-96(s0)
     7f6:	00000097          	auipc	ra,0x0
     7fa:	6ba080e7          	jalr	1722(ra) # eb0 <close>
      int st1, st2;
      wait(&st1);
     7fe:	f9440513          	add	a0,s0,-108
     802:	00000097          	auipc	ra,0x0
     806:	68e080e7          	jalr	1678(ra) # e90 <wait>
      wait(&st2);
     80a:	fa840513          	add	a0,s0,-88
     80e:	00000097          	auipc	ra,0x0
     812:	682080e7          	jalr	1666(ra) # e90 <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     816:	f9442783          	lw	a5,-108(s0)
     81a:	fa842703          	lw	a4,-88(s0)
     81e:	8fd9                	or	a5,a5,a4
     820:	ef89                	bnez	a5,83a <go+0x7c2>
     822:	00001597          	auipc	a1,0x1
     826:	e4658593          	add	a1,a1,-442 # 1668 <malloc+0x3a0>
     82a:	f9040513          	add	a0,s0,-112
     82e:	00000097          	auipc	ra,0x0
     832:	3b0080e7          	jalr	944(ra) # bde <strcmp>
     836:	8e0506e3          	beqz	a0,122 <go+0xaa>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     83a:	f9040693          	add	a3,s0,-112
     83e:	fa842603          	lw	a2,-88(s0)
     842:	f9442583          	lw	a1,-108(s0)
     846:	00001517          	auipc	a0,0x1
     84a:	e2a50513          	add	a0,a0,-470 # 1670 <malloc+0x3a8>
     84e:	00001097          	auipc	ra,0x1
     852:	9c2080e7          	jalr	-1598(ra) # 1210 <printf>
        exit(1);
     856:	4505                	li	a0,1
     858:	00000097          	auipc	ra,0x0
     85c:	630080e7          	jalr	1584(ra) # e88 <exit>
        fprintf(2, "grind: pipe failed\n");
     860:	00001597          	auipc	a1,0x1
     864:	c9058593          	add	a1,a1,-880 # 14f0 <malloc+0x228>
     868:	4509                	li	a0,2
     86a:	00001097          	auipc	ra,0x1
     86e:	978080e7          	jalr	-1672(ra) # 11e2 <fprintf>
        exit(1);
     872:	4505                	li	a0,1
     874:	00000097          	auipc	ra,0x0
     878:	614080e7          	jalr	1556(ra) # e88 <exit>
        fprintf(2, "grind: pipe failed\n");
     87c:	00001597          	auipc	a1,0x1
     880:	c7458593          	add	a1,a1,-908 # 14f0 <malloc+0x228>
     884:	4509                	li	a0,2
     886:	00001097          	auipc	ra,0x1
     88a:	95c080e7          	jalr	-1700(ra) # 11e2 <fprintf>
        exit(1);
     88e:	4505                	li	a0,1
     890:	00000097          	auipc	ra,0x0
     894:	5f8080e7          	jalr	1528(ra) # e88 <exit>
        close(bb[0]);
     898:	fa042503          	lw	a0,-96(s0)
     89c:	00000097          	auipc	ra,0x0
     8a0:	614080e7          	jalr	1556(ra) # eb0 <close>
        close(bb[1]);
     8a4:	fa442503          	lw	a0,-92(s0)
     8a8:	00000097          	auipc	ra,0x0
     8ac:	608080e7          	jalr	1544(ra) # eb0 <close>
        close(aa[0]);
     8b0:	f9842503          	lw	a0,-104(s0)
     8b4:	00000097          	auipc	ra,0x0
     8b8:	5fc080e7          	jalr	1532(ra) # eb0 <close>
        close(1);
     8bc:	4505                	li	a0,1
     8be:	00000097          	auipc	ra,0x0
     8c2:	5f2080e7          	jalr	1522(ra) # eb0 <close>
        if(dup(aa[1]) != 1){
     8c6:	f9c42503          	lw	a0,-100(s0)
     8ca:	00000097          	auipc	ra,0x0
     8ce:	636080e7          	jalr	1590(ra) # f00 <dup>
     8d2:	4785                	li	a5,1
     8d4:	02f50063          	beq	a0,a5,8f4 <go+0x87c>
          fprintf(2, "grind: dup failed\n");
     8d8:	00001597          	auipc	a1,0x1
     8dc:	d1858593          	add	a1,a1,-744 # 15f0 <malloc+0x328>
     8e0:	4509                	li	a0,2
     8e2:	00001097          	auipc	ra,0x1
     8e6:	900080e7          	jalr	-1792(ra) # 11e2 <fprintf>
          exit(1);
     8ea:	4505                	li	a0,1
     8ec:	00000097          	auipc	ra,0x0
     8f0:	59c080e7          	jalr	1436(ra) # e88 <exit>
        close(aa[1]);
     8f4:	f9c42503          	lw	a0,-100(s0)
     8f8:	00000097          	auipc	ra,0x0
     8fc:	5b8080e7          	jalr	1464(ra) # eb0 <close>
        char *args[3] = { "echo", "hi", 0 };
     900:	00001797          	auipc	a5,0x1
     904:	d0878793          	add	a5,a5,-760 # 1608 <malloc+0x340>
     908:	faf43423          	sd	a5,-88(s0)
     90c:	00001797          	auipc	a5,0x1
     910:	d0478793          	add	a5,a5,-764 # 1610 <malloc+0x348>
     914:	faf43823          	sd	a5,-80(s0)
     918:	fa043c23          	sd	zero,-72(s0)
        exec("grindir/../echo", args);
     91c:	fa840593          	add	a1,s0,-88
     920:	00001517          	auipc	a0,0x1
     924:	cf850513          	add	a0,a0,-776 # 1618 <malloc+0x350>
     928:	00000097          	auipc	ra,0x0
     92c:	598080e7          	jalr	1432(ra) # ec0 <exec>
        fprintf(2, "grind: echo: not found\n");
     930:	00001597          	auipc	a1,0x1
     934:	cf858593          	add	a1,a1,-776 # 1628 <malloc+0x360>
     938:	4509                	li	a0,2
     93a:	00001097          	auipc	ra,0x1
     93e:	8a8080e7          	jalr	-1880(ra) # 11e2 <fprintf>
        exit(2);
     942:	4509                	li	a0,2
     944:	00000097          	auipc	ra,0x0
     948:	544080e7          	jalr	1348(ra) # e88 <exit>
        fprintf(2, "grind: fork failed\n");
     94c:	00001597          	auipc	a1,0x1
     950:	b6458593          	add	a1,a1,-1180 # 14b0 <malloc+0x1e8>
     954:	4509                	li	a0,2
     956:	00001097          	auipc	ra,0x1
     95a:	88c080e7          	jalr	-1908(ra) # 11e2 <fprintf>
        exit(3);
     95e:	450d                	li	a0,3
     960:	00000097          	auipc	ra,0x0
     964:	528080e7          	jalr	1320(ra) # e88 <exit>
        close(aa[1]);
     968:	f9c42503          	lw	a0,-100(s0)
     96c:	00000097          	auipc	ra,0x0
     970:	544080e7          	jalr	1348(ra) # eb0 <close>
        close(bb[0]);
     974:	fa042503          	lw	a0,-96(s0)
     978:	00000097          	auipc	ra,0x0
     97c:	538080e7          	jalr	1336(ra) # eb0 <close>
        close(0);
     980:	4501                	li	a0,0
     982:	00000097          	auipc	ra,0x0
     986:	52e080e7          	jalr	1326(ra) # eb0 <close>
        if(dup(aa[0]) != 0){
     98a:	f9842503          	lw	a0,-104(s0)
     98e:	00000097          	auipc	ra,0x0
     992:	572080e7          	jalr	1394(ra) # f00 <dup>
     996:	cd19                	beqz	a0,9b4 <go+0x93c>
          fprintf(2, "grind: dup failed\n");
     998:	00001597          	auipc	a1,0x1
     99c:	c5858593          	add	a1,a1,-936 # 15f0 <malloc+0x328>
     9a0:	4509                	li	a0,2
     9a2:	00001097          	auipc	ra,0x1
     9a6:	840080e7          	jalr	-1984(ra) # 11e2 <fprintf>
          exit(4);
     9aa:	4511                	li	a0,4
     9ac:	00000097          	auipc	ra,0x0
     9b0:	4dc080e7          	jalr	1244(ra) # e88 <exit>
        close(aa[0]);
     9b4:	f9842503          	lw	a0,-104(s0)
     9b8:	00000097          	auipc	ra,0x0
     9bc:	4f8080e7          	jalr	1272(ra) # eb0 <close>
        close(1);
     9c0:	4505                	li	a0,1
     9c2:	00000097          	auipc	ra,0x0
     9c6:	4ee080e7          	jalr	1262(ra) # eb0 <close>
        if(dup(bb[1]) != 1){
     9ca:	fa442503          	lw	a0,-92(s0)
     9ce:	00000097          	auipc	ra,0x0
     9d2:	532080e7          	jalr	1330(ra) # f00 <dup>
     9d6:	4785                	li	a5,1
     9d8:	02f50063          	beq	a0,a5,9f8 <go+0x980>
          fprintf(2, "grind: dup failed\n");
     9dc:	00001597          	auipc	a1,0x1
     9e0:	c1458593          	add	a1,a1,-1004 # 15f0 <malloc+0x328>
     9e4:	4509                	li	a0,2
     9e6:	00000097          	auipc	ra,0x0
     9ea:	7fc080e7          	jalr	2044(ra) # 11e2 <fprintf>
          exit(5);
     9ee:	4515                	li	a0,5
     9f0:	00000097          	auipc	ra,0x0
     9f4:	498080e7          	jalr	1176(ra) # e88 <exit>
        close(bb[1]);
     9f8:	fa442503          	lw	a0,-92(s0)
     9fc:	00000097          	auipc	ra,0x0
     a00:	4b4080e7          	jalr	1204(ra) # eb0 <close>
        char *args[2] = { "cat", 0 };
     a04:	00001797          	auipc	a5,0x1
     a08:	c3c78793          	add	a5,a5,-964 # 1640 <malloc+0x378>
     a0c:	faf43423          	sd	a5,-88(s0)
     a10:	fa043823          	sd	zero,-80(s0)
        exec("/cat", args);
     a14:	fa840593          	add	a1,s0,-88
     a18:	00001517          	auipc	a0,0x1
     a1c:	c3050513          	add	a0,a0,-976 # 1648 <malloc+0x380>
     a20:	00000097          	auipc	ra,0x0
     a24:	4a0080e7          	jalr	1184(ra) # ec0 <exec>
        fprintf(2, "grind: cat: not found\n");
     a28:	00001597          	auipc	a1,0x1
     a2c:	c2858593          	add	a1,a1,-984 # 1650 <malloc+0x388>
     a30:	4509                	li	a0,2
     a32:	00000097          	auipc	ra,0x0
     a36:	7b0080e7          	jalr	1968(ra) # 11e2 <fprintf>
        exit(6);
     a3a:	4519                	li	a0,6
     a3c:	00000097          	auipc	ra,0x0
     a40:	44c080e7          	jalr	1100(ra) # e88 <exit>
        fprintf(2, "grind: fork failed\n");
     a44:	00001597          	auipc	a1,0x1
     a48:	a6c58593          	add	a1,a1,-1428 # 14b0 <malloc+0x1e8>
     a4c:	4509                	li	a0,2
     a4e:	00000097          	auipc	ra,0x0
     a52:	794080e7          	jalr	1940(ra) # 11e2 <fprintf>
        exit(7);
     a56:	451d                	li	a0,7
     a58:	00000097          	auipc	ra,0x0
     a5c:	430080e7          	jalr	1072(ra) # e88 <exit>

0000000000000a60 <iter>:
  }
}

void
iter()
{
     a60:	7179                	add	sp,sp,-48
     a62:	f406                	sd	ra,40(sp)
     a64:	f022                	sd	s0,32(sp)
     a66:	ec26                	sd	s1,24(sp)
     a68:	e84a                	sd	s2,16(sp)
     a6a:	1800                	add	s0,sp,48
  unlink("a");
     a6c:	00001517          	auipc	a0,0x1
     a70:	a2450513          	add	a0,a0,-1500 # 1490 <malloc+0x1c8>
     a74:	00000097          	auipc	ra,0x0
     a78:	464080e7          	jalr	1124(ra) # ed8 <unlink>
  unlink("b");
     a7c:	00001517          	auipc	a0,0x1
     a80:	9c450513          	add	a0,a0,-1596 # 1440 <malloc+0x178>
     a84:	00000097          	auipc	ra,0x0
     a88:	454080e7          	jalr	1108(ra) # ed8 <unlink>
  
  int pid1 = fork();
     a8c:	00000097          	auipc	ra,0x0
     a90:	3f4080e7          	jalr	1012(ra) # e80 <fork>
  if(pid1 < 0){
     a94:	02054163          	bltz	a0,ab6 <iter+0x56>
     a98:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     a9a:	e91d                	bnez	a0,ad0 <iter+0x70>
    rand_next ^= 31;
     a9c:	00001717          	auipc	a4,0x1
     aa0:	56470713          	add	a4,a4,1380 # 2000 <rand_next>
     aa4:	631c                	ld	a5,0(a4)
     aa6:	01f7c793          	xor	a5,a5,31
     aaa:	e31c                	sd	a5,0(a4)
    go(0);
     aac:	4501                	li	a0,0
     aae:	fffff097          	auipc	ra,0xfffff
     ab2:	5ca080e7          	jalr	1482(ra) # 78 <go>
    printf("grind: fork failed\n");
     ab6:	00001517          	auipc	a0,0x1
     aba:	9fa50513          	add	a0,a0,-1542 # 14b0 <malloc+0x1e8>
     abe:	00000097          	auipc	ra,0x0
     ac2:	752080e7          	jalr	1874(ra) # 1210 <printf>
    exit(1);
     ac6:	4505                	li	a0,1
     ac8:	00000097          	auipc	ra,0x0
     acc:	3c0080e7          	jalr	960(ra) # e88 <exit>
    exit(0);
  }

  int pid2 = fork();
     ad0:	00000097          	auipc	ra,0x0
     ad4:	3b0080e7          	jalr	944(ra) # e80 <fork>
     ad8:	892a                	mv	s2,a0
  if(pid2 < 0){
     ada:	02054263          	bltz	a0,afe <iter+0x9e>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     ade:	ed0d                	bnez	a0,b18 <iter+0xb8>
    rand_next ^= 7177;
     ae0:	00001697          	auipc	a3,0x1
     ae4:	52068693          	add	a3,a3,1312 # 2000 <rand_next>
     ae8:	629c                	ld	a5,0(a3)
     aea:	6709                	lui	a4,0x2
     aec:	c0970713          	add	a4,a4,-1015 # 1c09 <digits+0x4b1>
     af0:	8fb9                	xor	a5,a5,a4
     af2:	e29c                	sd	a5,0(a3)
    go(1);
     af4:	4505                	li	a0,1
     af6:	fffff097          	auipc	ra,0xfffff
     afa:	582080e7          	jalr	1410(ra) # 78 <go>
    printf("grind: fork failed\n");
     afe:	00001517          	auipc	a0,0x1
     b02:	9b250513          	add	a0,a0,-1614 # 14b0 <malloc+0x1e8>
     b06:	00000097          	auipc	ra,0x0
     b0a:	70a080e7          	jalr	1802(ra) # 1210 <printf>
    exit(1);
     b0e:	4505                	li	a0,1
     b10:	00000097          	auipc	ra,0x0
     b14:	378080e7          	jalr	888(ra) # e88 <exit>
    exit(0);
  }

  int st1 = -1;
     b18:	57fd                	li	a5,-1
     b1a:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     b1e:	fdc40513          	add	a0,s0,-36
     b22:	00000097          	auipc	ra,0x0
     b26:	36e080e7          	jalr	878(ra) # e90 <wait>
  if(st1 != 0){
     b2a:	fdc42783          	lw	a5,-36(s0)
     b2e:	ef99                	bnez	a5,b4c <iter+0xec>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     b30:	57fd                	li	a5,-1
     b32:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
     b36:	fd840513          	add	a0,s0,-40
     b3a:	00000097          	auipc	ra,0x0
     b3e:	356080e7          	jalr	854(ra) # e90 <wait>

  exit(0);
     b42:	4501                	li	a0,0
     b44:	00000097          	auipc	ra,0x0
     b48:	344080e7          	jalr	836(ra) # e88 <exit>
    kill(pid1);
     b4c:	8526                	mv	a0,s1
     b4e:	00000097          	auipc	ra,0x0
     b52:	36a080e7          	jalr	874(ra) # eb8 <kill>
    kill(pid2);
     b56:	854a                	mv	a0,s2
     b58:	00000097          	auipc	ra,0x0
     b5c:	360080e7          	jalr	864(ra) # eb8 <kill>
     b60:	bfc1                	j	b30 <iter+0xd0>

0000000000000b62 <main>:
}

int
main()
{
     b62:	1101                	add	sp,sp,-32
     b64:	ec06                	sd	ra,24(sp)
     b66:	e822                	sd	s0,16(sp)
     b68:	e426                	sd	s1,8(sp)
     b6a:	1000                	add	s0,sp,32
    }
    if(pid > 0){
      wait(0);
    }
    sleep(20);
    rand_next += 1;
     b6c:	00001497          	auipc	s1,0x1
     b70:	49448493          	add	s1,s1,1172 # 2000 <rand_next>
     b74:	a829                	j	b8e <main+0x2c>
      iter();
     b76:	00000097          	auipc	ra,0x0
     b7a:	eea080e7          	jalr	-278(ra) # a60 <iter>
    sleep(20);
     b7e:	4551                	li	a0,20
     b80:	00000097          	auipc	ra,0x0
     b84:	398080e7          	jalr	920(ra) # f18 <sleep>
    rand_next += 1;
     b88:	609c                	ld	a5,0(s1)
     b8a:	0785                	add	a5,a5,1
     b8c:	e09c                	sd	a5,0(s1)
    int pid = fork();
     b8e:	00000097          	auipc	ra,0x0
     b92:	2f2080e7          	jalr	754(ra) # e80 <fork>
    if(pid == 0){
     b96:	d165                	beqz	a0,b76 <main+0x14>
    if(pid > 0){
     b98:	fea053e3          	blez	a0,b7e <main+0x1c>
      wait(0);
     b9c:	4501                	li	a0,0
     b9e:	00000097          	auipc	ra,0x0
     ba2:	2f2080e7          	jalr	754(ra) # e90 <wait>
     ba6:	bfe1                	j	b7e <main+0x1c>

0000000000000ba8 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
     ba8:	1141                	add	sp,sp,-16
     baa:	e406                	sd	ra,8(sp)
     bac:	e022                	sd	s0,0(sp)
     bae:	0800                	add	s0,sp,16
  extern int main();
  main();
     bb0:	00000097          	auipc	ra,0x0
     bb4:	fb2080e7          	jalr	-78(ra) # b62 <main>
  exit(0);
     bb8:	4501                	li	a0,0
     bba:	00000097          	auipc	ra,0x0
     bbe:	2ce080e7          	jalr	718(ra) # e88 <exit>

0000000000000bc2 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     bc2:	1141                	add	sp,sp,-16
     bc4:	e422                	sd	s0,8(sp)
     bc6:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     bc8:	87aa                	mv	a5,a0
     bca:	0585                	add	a1,a1,1
     bcc:	0785                	add	a5,a5,1
     bce:	fff5c703          	lbu	a4,-1(a1)
     bd2:	fee78fa3          	sb	a4,-1(a5)
     bd6:	fb75                	bnez	a4,bca <strcpy+0x8>
    ;
  return os;
}
     bd8:	6422                	ld	s0,8(sp)
     bda:	0141                	add	sp,sp,16
     bdc:	8082                	ret

0000000000000bde <strcmp>:

int
strcmp(const char *p, const char *q)
{
     bde:	1141                	add	sp,sp,-16
     be0:	e422                	sd	s0,8(sp)
     be2:	0800                	add	s0,sp,16
  while(*p && *p == *q)
     be4:	00054783          	lbu	a5,0(a0)
     be8:	cb91                	beqz	a5,bfc <strcmp+0x1e>
     bea:	0005c703          	lbu	a4,0(a1)
     bee:	00f71763          	bne	a4,a5,bfc <strcmp+0x1e>
    p++, q++;
     bf2:	0505                	add	a0,a0,1
     bf4:	0585                	add	a1,a1,1
  while(*p && *p == *q)
     bf6:	00054783          	lbu	a5,0(a0)
     bfa:	fbe5                	bnez	a5,bea <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     bfc:	0005c503          	lbu	a0,0(a1)
}
     c00:	40a7853b          	subw	a0,a5,a0
     c04:	6422                	ld	s0,8(sp)
     c06:	0141                	add	sp,sp,16
     c08:	8082                	ret

0000000000000c0a <strlen>:

uint
strlen(const char *s)
{
     c0a:	1141                	add	sp,sp,-16
     c0c:	e422                	sd	s0,8(sp)
     c0e:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     c10:	00054783          	lbu	a5,0(a0)
     c14:	cf91                	beqz	a5,c30 <strlen+0x26>
     c16:	0505                	add	a0,a0,1
     c18:	87aa                	mv	a5,a0
     c1a:	86be                	mv	a3,a5
     c1c:	0785                	add	a5,a5,1
     c1e:	fff7c703          	lbu	a4,-1(a5)
     c22:	ff65                	bnez	a4,c1a <strlen+0x10>
     c24:	40a6853b          	subw	a0,a3,a0
     c28:	2505                	addw	a0,a0,1
    ;
  return n;
}
     c2a:	6422                	ld	s0,8(sp)
     c2c:	0141                	add	sp,sp,16
     c2e:	8082                	ret
  for(n = 0; s[n]; n++)
     c30:	4501                	li	a0,0
     c32:	bfe5                	j	c2a <strlen+0x20>

0000000000000c34 <memset>:

void*
memset(void *dst, int c, uint n)
{
     c34:	1141                	add	sp,sp,-16
     c36:	e422                	sd	s0,8(sp)
     c38:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     c3a:	ca19                	beqz	a2,c50 <memset+0x1c>
     c3c:	87aa                	mv	a5,a0
     c3e:	1602                	sll	a2,a2,0x20
     c40:	9201                	srl	a2,a2,0x20
     c42:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     c46:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     c4a:	0785                	add	a5,a5,1
     c4c:	fee79de3          	bne	a5,a4,c46 <memset+0x12>
  }
  return dst;
}
     c50:	6422                	ld	s0,8(sp)
     c52:	0141                	add	sp,sp,16
     c54:	8082                	ret

0000000000000c56 <strchr>:

char*
strchr(const char *s, char c)
{
     c56:	1141                	add	sp,sp,-16
     c58:	e422                	sd	s0,8(sp)
     c5a:	0800                	add	s0,sp,16
  for(; *s; s++)
     c5c:	00054783          	lbu	a5,0(a0)
     c60:	cb99                	beqz	a5,c76 <strchr+0x20>
    if(*s == c)
     c62:	00f58763          	beq	a1,a5,c70 <strchr+0x1a>
  for(; *s; s++)
     c66:	0505                	add	a0,a0,1
     c68:	00054783          	lbu	a5,0(a0)
     c6c:	fbfd                	bnez	a5,c62 <strchr+0xc>
      return (char*)s;
  return 0;
     c6e:	4501                	li	a0,0
}
     c70:	6422                	ld	s0,8(sp)
     c72:	0141                	add	sp,sp,16
     c74:	8082                	ret
  return 0;
     c76:	4501                	li	a0,0
     c78:	bfe5                	j	c70 <strchr+0x1a>

0000000000000c7a <strstr>:

char*
strstr(const char *str, const char *substr)
{
     c7a:	1141                	add	sp,sp,-16
     c7c:	e422                	sd	s0,8(sp)
     c7e:	0800                	add	s0,sp,16
  const char *a, *b = substr;
  if (*b == 0)
     c80:	0005c803          	lbu	a6,0(a1)
     c84:	02080a63          	beqz	a6,cb8 <strstr+0x3e>
    return (char*)str;
  for( ; *str != 0; str += 1) {
     c88:	00054783          	lbu	a5,0(a0)
     c8c:	e799                	bnez	a5,c9a <strstr+0x20>
      if (*a++ != *b++)
        break;
    }
    b = substr;
  }
  return 0;
     c8e:	4501                	li	a0,0
     c90:	a025                	j	cb8 <strstr+0x3e>
  for( ; *str != 0; str += 1) {
     c92:	0505                	add	a0,a0,1
     c94:	00054783          	lbu	a5,0(a0)
     c98:	cf99                	beqz	a5,cb6 <strstr+0x3c>
    if (*str != *b)
     c9a:	fef81ce3          	bne	a6,a5,c92 <strstr+0x18>
     c9e:	87ae                	mv	a5,a1
     ca0:	86aa                	mv	a3,a0
      if (*b == 0)
     ca2:	0007c703          	lbu	a4,0(a5)
     ca6:	cb09                	beqz	a4,cb8 <strstr+0x3e>
      if (*a++ != *b++)
     ca8:	0685                	add	a3,a3,1
     caa:	0785                	add	a5,a5,1
     cac:	fff6c603          	lbu	a2,-1(a3)
     cb0:	fee609e3          	beq	a2,a4,ca2 <strstr+0x28>
     cb4:	bff9                	j	c92 <strstr+0x18>
  return 0;
     cb6:	4501                	li	a0,0
}
     cb8:	6422                	ld	s0,8(sp)
     cba:	0141                	add	sp,sp,16
     cbc:	8082                	ret

0000000000000cbe <gets>:

char*
gets(char *buf, int max)
{
     cbe:	711d                	add	sp,sp,-96
     cc0:	ec86                	sd	ra,88(sp)
     cc2:	e8a2                	sd	s0,80(sp)
     cc4:	e4a6                	sd	s1,72(sp)
     cc6:	e0ca                	sd	s2,64(sp)
     cc8:	fc4e                	sd	s3,56(sp)
     cca:	f852                	sd	s4,48(sp)
     ccc:	f456                	sd	s5,40(sp)
     cce:	f05a                	sd	s6,32(sp)
     cd0:	ec5e                	sd	s7,24(sp)
     cd2:	1080                	add	s0,sp,96
     cd4:	8baa                	mv	s7,a0
     cd6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     cd8:	892a                	mv	s2,a0
     cda:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     cdc:	4aa9                	li	s5,10
     cde:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     ce0:	89a6                	mv	s3,s1
     ce2:	2485                	addw	s1,s1,1
     ce4:	0344d863          	bge	s1,s4,d14 <gets+0x56>
    cc = read(0, &c, 1);
     ce8:	4605                	li	a2,1
     cea:	faf40593          	add	a1,s0,-81
     cee:	4501                	li	a0,0
     cf0:	00000097          	auipc	ra,0x0
     cf4:	1b0080e7          	jalr	432(ra) # ea0 <read>
    if(cc < 1)
     cf8:	00a05e63          	blez	a0,d14 <gets+0x56>
    buf[i++] = c;
     cfc:	faf44783          	lbu	a5,-81(s0)
     d00:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     d04:	01578763          	beq	a5,s5,d12 <gets+0x54>
     d08:	0905                	add	s2,s2,1
     d0a:	fd679be3          	bne	a5,s6,ce0 <gets+0x22>
  for(i=0; i+1 < max; ){
     d0e:	89a6                	mv	s3,s1
     d10:	a011                	j	d14 <gets+0x56>
     d12:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     d14:	99de                	add	s3,s3,s7
     d16:	00098023          	sb	zero,0(s3)
  return buf;
}
     d1a:	855e                	mv	a0,s7
     d1c:	60e6                	ld	ra,88(sp)
     d1e:	6446                	ld	s0,80(sp)
     d20:	64a6                	ld	s1,72(sp)
     d22:	6906                	ld	s2,64(sp)
     d24:	79e2                	ld	s3,56(sp)
     d26:	7a42                	ld	s4,48(sp)
     d28:	7aa2                	ld	s5,40(sp)
     d2a:	7b02                	ld	s6,32(sp)
     d2c:	6be2                	ld	s7,24(sp)
     d2e:	6125                	add	sp,sp,96
     d30:	8082                	ret

0000000000000d32 <stat>:

int
stat(const char *n, struct stat *st)
{
     d32:	1101                	add	sp,sp,-32
     d34:	ec06                	sd	ra,24(sp)
     d36:	e822                	sd	s0,16(sp)
     d38:	e426                	sd	s1,8(sp)
     d3a:	e04a                	sd	s2,0(sp)
     d3c:	1000                	add	s0,sp,32
     d3e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     d40:	4581                	li	a1,0
     d42:	00000097          	auipc	ra,0x0
     d46:	186080e7          	jalr	390(ra) # ec8 <open>
  if(fd < 0)
     d4a:	02054563          	bltz	a0,d74 <stat+0x42>
     d4e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     d50:	85ca                	mv	a1,s2
     d52:	00000097          	auipc	ra,0x0
     d56:	18e080e7          	jalr	398(ra) # ee0 <fstat>
     d5a:	892a                	mv	s2,a0
  close(fd);
     d5c:	8526                	mv	a0,s1
     d5e:	00000097          	auipc	ra,0x0
     d62:	152080e7          	jalr	338(ra) # eb0 <close>
  return r;
}
     d66:	854a                	mv	a0,s2
     d68:	60e2                	ld	ra,24(sp)
     d6a:	6442                	ld	s0,16(sp)
     d6c:	64a2                	ld	s1,8(sp)
     d6e:	6902                	ld	s2,0(sp)
     d70:	6105                	add	sp,sp,32
     d72:	8082                	ret
    return -1;
     d74:	597d                	li	s2,-1
     d76:	bfc5                	j	d66 <stat+0x34>

0000000000000d78 <atoi>:

int
atoi(const char *s)
{
     d78:	1141                	add	sp,sp,-16
     d7a:	e422                	sd	s0,8(sp)
     d7c:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     d7e:	00054683          	lbu	a3,0(a0)
     d82:	fd06879b          	addw	a5,a3,-48
     d86:	0ff7f793          	zext.b	a5,a5
     d8a:	4625                	li	a2,9
     d8c:	02f66863          	bltu	a2,a5,dbc <atoi+0x44>
     d90:	872a                	mv	a4,a0
  n = 0;
     d92:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     d94:	0705                	add	a4,a4,1
     d96:	0025179b          	sllw	a5,a0,0x2
     d9a:	9fa9                	addw	a5,a5,a0
     d9c:	0017979b          	sllw	a5,a5,0x1
     da0:	9fb5                	addw	a5,a5,a3
     da2:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     da6:	00074683          	lbu	a3,0(a4)
     daa:	fd06879b          	addw	a5,a3,-48
     dae:	0ff7f793          	zext.b	a5,a5
     db2:	fef671e3          	bgeu	a2,a5,d94 <atoi+0x1c>
  return n;
}
     db6:	6422                	ld	s0,8(sp)
     db8:	0141                	add	sp,sp,16
     dba:	8082                	ret
  n = 0;
     dbc:	4501                	li	a0,0
     dbe:	bfe5                	j	db6 <atoi+0x3e>

0000000000000dc0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     dc0:	1141                	add	sp,sp,-16
     dc2:	e422                	sd	s0,8(sp)
     dc4:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     dc6:	02b57463          	bgeu	a0,a1,dee <memmove+0x2e>
    while(n-- > 0)
     dca:	00c05f63          	blez	a2,de8 <memmove+0x28>
     dce:	1602                	sll	a2,a2,0x20
     dd0:	9201                	srl	a2,a2,0x20
     dd2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     dd6:	872a                	mv	a4,a0
      *dst++ = *src++;
     dd8:	0585                	add	a1,a1,1
     dda:	0705                	add	a4,a4,1
     ddc:	fff5c683          	lbu	a3,-1(a1)
     de0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     de4:	fee79ae3          	bne	a5,a4,dd8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     de8:	6422                	ld	s0,8(sp)
     dea:	0141                	add	sp,sp,16
     dec:	8082                	ret
    dst += n;
     dee:	00c50733          	add	a4,a0,a2
    src += n;
     df2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     df4:	fec05ae3          	blez	a2,de8 <memmove+0x28>
     df8:	fff6079b          	addw	a5,a2,-1
     dfc:	1782                	sll	a5,a5,0x20
     dfe:	9381                	srl	a5,a5,0x20
     e00:	fff7c793          	not	a5,a5
     e04:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     e06:	15fd                	add	a1,a1,-1
     e08:	177d                	add	a4,a4,-1
     e0a:	0005c683          	lbu	a3,0(a1)
     e0e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     e12:	fee79ae3          	bne	a5,a4,e06 <memmove+0x46>
     e16:	bfc9                	j	de8 <memmove+0x28>

0000000000000e18 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     e18:	1141                	add	sp,sp,-16
     e1a:	e422                	sd	s0,8(sp)
     e1c:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     e1e:	ca05                	beqz	a2,e4e <memcmp+0x36>
     e20:	fff6069b          	addw	a3,a2,-1
     e24:	1682                	sll	a3,a3,0x20
     e26:	9281                	srl	a3,a3,0x20
     e28:	0685                	add	a3,a3,1
     e2a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     e2c:	00054783          	lbu	a5,0(a0)
     e30:	0005c703          	lbu	a4,0(a1)
     e34:	00e79863          	bne	a5,a4,e44 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     e38:	0505                	add	a0,a0,1
    p2++;
     e3a:	0585                	add	a1,a1,1
  while (n-- > 0) {
     e3c:	fed518e3          	bne	a0,a3,e2c <memcmp+0x14>
  }
  return 0;
     e40:	4501                	li	a0,0
     e42:	a019                	j	e48 <memcmp+0x30>
      return *p1 - *p2;
     e44:	40e7853b          	subw	a0,a5,a4
}
     e48:	6422                	ld	s0,8(sp)
     e4a:	0141                	add	sp,sp,16
     e4c:	8082                	ret
  return 0;
     e4e:	4501                	li	a0,0
     e50:	bfe5                	j	e48 <memcmp+0x30>

0000000000000e52 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     e52:	1141                	add	sp,sp,-16
     e54:	e406                	sd	ra,8(sp)
     e56:	e022                	sd	s0,0(sp)
     e58:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
     e5a:	00000097          	auipc	ra,0x0
     e5e:	f66080e7          	jalr	-154(ra) # dc0 <memmove>
}
     e62:	60a2                	ld	ra,8(sp)
     e64:	6402                	ld	s0,0(sp)
     e66:	0141                	add	sp,sp,16
     e68:	8082                	ret

0000000000000e6a <ugetpid>:

int
ugetpid(void)
{
     e6a:	1141                	add	sp,sp,-16
     e6c:	e422                	sd	s0,8(sp)
     e6e:	0800                	add	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
     e70:	040007b7          	lui	a5,0x4000
}
     e74:	17f5                	add	a5,a5,-3 # 3fffffd <base+0x3ffdbf5>
     e76:	07b2                	sll	a5,a5,0xc
     e78:	4388                	lw	a0,0(a5)
     e7a:	6422                	ld	s0,8(sp)
     e7c:	0141                	add	sp,sp,16
     e7e:	8082                	ret

0000000000000e80 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     e80:	4885                	li	a7,1
 ecall
     e82:	00000073          	ecall
 ret
     e86:	8082                	ret

0000000000000e88 <exit>:
.global exit
exit:
 li a7, SYS_exit
     e88:	4889                	li	a7,2
 ecall
     e8a:	00000073          	ecall
 ret
     e8e:	8082                	ret

0000000000000e90 <wait>:
.global wait
wait:
 li a7, SYS_wait
     e90:	488d                	li	a7,3
 ecall
     e92:	00000073          	ecall
 ret
     e96:	8082                	ret

0000000000000e98 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     e98:	4891                	li	a7,4
 ecall
     e9a:	00000073          	ecall
 ret
     e9e:	8082                	ret

0000000000000ea0 <read>:
.global read
read:
 li a7, SYS_read
     ea0:	4895                	li	a7,5
 ecall
     ea2:	00000073          	ecall
 ret
     ea6:	8082                	ret

0000000000000ea8 <write>:
.global write
write:
 li a7, SYS_write
     ea8:	48c1                	li	a7,16
 ecall
     eaa:	00000073          	ecall
 ret
     eae:	8082                	ret

0000000000000eb0 <close>:
.global close
close:
 li a7, SYS_close
     eb0:	48d5                	li	a7,21
 ecall
     eb2:	00000073          	ecall
 ret
     eb6:	8082                	ret

0000000000000eb8 <kill>:
.global kill
kill:
 li a7, SYS_kill
     eb8:	4899                	li	a7,6
 ecall
     eba:	00000073          	ecall
 ret
     ebe:	8082                	ret

0000000000000ec0 <exec>:
.global exec
exec:
 li a7, SYS_exec
     ec0:	489d                	li	a7,7
 ecall
     ec2:	00000073          	ecall
 ret
     ec6:	8082                	ret

0000000000000ec8 <open>:
.global open
open:
 li a7, SYS_open
     ec8:	48bd                	li	a7,15
 ecall
     eca:	00000073          	ecall
 ret
     ece:	8082                	ret

0000000000000ed0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     ed0:	48c5                	li	a7,17
 ecall
     ed2:	00000073          	ecall
 ret
     ed6:	8082                	ret

0000000000000ed8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     ed8:	48c9                	li	a7,18
 ecall
     eda:	00000073          	ecall
 ret
     ede:	8082                	ret

0000000000000ee0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     ee0:	48a1                	li	a7,8
 ecall
     ee2:	00000073          	ecall
 ret
     ee6:	8082                	ret

0000000000000ee8 <link>:
.global link
link:
 li a7, SYS_link
     ee8:	48cd                	li	a7,19
 ecall
     eea:	00000073          	ecall
 ret
     eee:	8082                	ret

0000000000000ef0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     ef0:	48d1                	li	a7,20
 ecall
     ef2:	00000073          	ecall
 ret
     ef6:	8082                	ret

0000000000000ef8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     ef8:	48a5                	li	a7,9
 ecall
     efa:	00000073          	ecall
 ret
     efe:	8082                	ret

0000000000000f00 <dup>:
.global dup
dup:
 li a7, SYS_dup
     f00:	48a9                	li	a7,10
 ecall
     f02:	00000073          	ecall
 ret
     f06:	8082                	ret

0000000000000f08 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     f08:	48ad                	li	a7,11
 ecall
     f0a:	00000073          	ecall
 ret
     f0e:	8082                	ret

0000000000000f10 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     f10:	48b1                	li	a7,12
 ecall
     f12:	00000073          	ecall
 ret
     f16:	8082                	ret

0000000000000f18 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     f18:	48b5                	li	a7,13
 ecall
     f1a:	00000073          	ecall
 ret
     f1e:	8082                	ret

0000000000000f20 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     f20:	48b9                	li	a7,14
 ecall
     f22:	00000073          	ecall
 ret
     f26:	8082                	ret

0000000000000f28 <trace>:
.global trace
trace:
 li a7, SYS_trace
     f28:	48d9                	li	a7,22
 ecall
     f2a:	00000073          	ecall
 ret
     f2e:	8082                	ret

0000000000000f30 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
     f30:	48dd                	li	a7,23
 ecall
     f32:	00000073          	ecall
 ret
     f36:	8082                	ret

0000000000000f38 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
     f38:	48e1                	li	a7,24
 ecall
     f3a:	00000073          	ecall
 ret
     f3e:	8082                	ret

0000000000000f40 <setpriority>:
.global setpriority
setpriority:
 li a7, SYS_setpriority
     f40:	48e5                	li	a7,25
 ecall
     f42:	00000073          	ecall
 ret
     f46:	8082                	ret

0000000000000f48 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     f48:	1101                	add	sp,sp,-32
     f4a:	ec06                	sd	ra,24(sp)
     f4c:	e822                	sd	s0,16(sp)
     f4e:	1000                	add	s0,sp,32
     f50:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     f54:	4605                	li	a2,1
     f56:	fef40593          	add	a1,s0,-17
     f5a:	00000097          	auipc	ra,0x0
     f5e:	f4e080e7          	jalr	-178(ra) # ea8 <write>
}
     f62:	60e2                	ld	ra,24(sp)
     f64:	6442                	ld	s0,16(sp)
     f66:	6105                	add	sp,sp,32
     f68:	8082                	ret

0000000000000f6a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     f6a:	7139                	add	sp,sp,-64
     f6c:	fc06                	sd	ra,56(sp)
     f6e:	f822                	sd	s0,48(sp)
     f70:	f426                	sd	s1,40(sp)
     f72:	f04a                	sd	s2,32(sp)
     f74:	ec4e                	sd	s3,24(sp)
     f76:	0080                	add	s0,sp,64
     f78:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     f7a:	c299                	beqz	a3,f80 <printint+0x16>
     f7c:	0805c963          	bltz	a1,100e <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     f80:	2581                	sext.w	a1,a1
  neg = 0;
     f82:	4881                	li	a7,0
     f84:	fc040693          	add	a3,s0,-64
  }

  i = 0;
     f88:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     f8a:	2601                	sext.w	a2,a2
     f8c:	00000517          	auipc	a0,0x0
     f90:	7cc50513          	add	a0,a0,1996 # 1758 <digits>
     f94:	883a                	mv	a6,a4
     f96:	2705                	addw	a4,a4,1
     f98:	02c5f7bb          	remuw	a5,a1,a2
     f9c:	1782                	sll	a5,a5,0x20
     f9e:	9381                	srl	a5,a5,0x20
     fa0:	97aa                	add	a5,a5,a0
     fa2:	0007c783          	lbu	a5,0(a5)
     fa6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     faa:	0005879b          	sext.w	a5,a1
     fae:	02c5d5bb          	divuw	a1,a1,a2
     fb2:	0685                	add	a3,a3,1
     fb4:	fec7f0e3          	bgeu	a5,a2,f94 <printint+0x2a>
  if(neg)
     fb8:	00088c63          	beqz	a7,fd0 <printint+0x66>
    buf[i++] = '-';
     fbc:	fd070793          	add	a5,a4,-48
     fc0:	00878733          	add	a4,a5,s0
     fc4:	02d00793          	li	a5,45
     fc8:	fef70823          	sb	a5,-16(a4)
     fcc:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
     fd0:	02e05863          	blez	a4,1000 <printint+0x96>
     fd4:	fc040793          	add	a5,s0,-64
     fd8:	00e78933          	add	s2,a5,a4
     fdc:	fff78993          	add	s3,a5,-1
     fe0:	99ba                	add	s3,s3,a4
     fe2:	377d                	addw	a4,a4,-1
     fe4:	1702                	sll	a4,a4,0x20
     fe6:	9301                	srl	a4,a4,0x20
     fe8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     fec:	fff94583          	lbu	a1,-1(s2)
     ff0:	8526                	mv	a0,s1
     ff2:	00000097          	auipc	ra,0x0
     ff6:	f56080e7          	jalr	-170(ra) # f48 <putc>
  while(--i >= 0)
     ffa:	197d                	add	s2,s2,-1
     ffc:	ff3918e3          	bne	s2,s3,fec <printint+0x82>
}
    1000:	70e2                	ld	ra,56(sp)
    1002:	7442                	ld	s0,48(sp)
    1004:	74a2                	ld	s1,40(sp)
    1006:	7902                	ld	s2,32(sp)
    1008:	69e2                	ld	s3,24(sp)
    100a:	6121                	add	sp,sp,64
    100c:	8082                	ret
    x = -xx;
    100e:	40b005bb          	negw	a1,a1
    neg = 1;
    1012:	4885                	li	a7,1
    x = -xx;
    1014:	bf85                	j	f84 <printint+0x1a>

0000000000001016 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    1016:	715d                	add	sp,sp,-80
    1018:	e486                	sd	ra,72(sp)
    101a:	e0a2                	sd	s0,64(sp)
    101c:	fc26                	sd	s1,56(sp)
    101e:	f84a                	sd	s2,48(sp)
    1020:	f44e                	sd	s3,40(sp)
    1022:	f052                	sd	s4,32(sp)
    1024:	ec56                	sd	s5,24(sp)
    1026:	e85a                	sd	s6,16(sp)
    1028:	e45e                	sd	s7,8(sp)
    102a:	e062                	sd	s8,0(sp)
    102c:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    102e:	0005c903          	lbu	s2,0(a1)
    1032:	18090c63          	beqz	s2,11ca <vprintf+0x1b4>
    1036:	8aaa                	mv	s5,a0
    1038:	8bb2                	mv	s7,a2
    103a:	00158493          	add	s1,a1,1
  state = 0;
    103e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1040:	02500a13          	li	s4,37
    1044:	4b55                	li	s6,21
    1046:	a839                	j	1064 <vprintf+0x4e>
        putc(fd, c);
    1048:	85ca                	mv	a1,s2
    104a:	8556                	mv	a0,s5
    104c:	00000097          	auipc	ra,0x0
    1050:	efc080e7          	jalr	-260(ra) # f48 <putc>
    1054:	a019                	j	105a <vprintf+0x44>
    } else if(state == '%'){
    1056:	01498d63          	beq	s3,s4,1070 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
    105a:	0485                	add	s1,s1,1
    105c:	fff4c903          	lbu	s2,-1(s1)
    1060:	16090563          	beqz	s2,11ca <vprintf+0x1b4>
    if(state == 0){
    1064:	fe0999e3          	bnez	s3,1056 <vprintf+0x40>
      if(c == '%'){
    1068:	ff4910e3          	bne	s2,s4,1048 <vprintf+0x32>
        state = '%';
    106c:	89d2                	mv	s3,s4
    106e:	b7f5                	j	105a <vprintf+0x44>
      if(c == 'd'){
    1070:	13490263          	beq	s2,s4,1194 <vprintf+0x17e>
    1074:	f9d9079b          	addw	a5,s2,-99
    1078:	0ff7f793          	zext.b	a5,a5
    107c:	12fb6563          	bltu	s6,a5,11a6 <vprintf+0x190>
    1080:	f9d9079b          	addw	a5,s2,-99
    1084:	0ff7f713          	zext.b	a4,a5
    1088:	10eb6f63          	bltu	s6,a4,11a6 <vprintf+0x190>
    108c:	00271793          	sll	a5,a4,0x2
    1090:	00000717          	auipc	a4,0x0
    1094:	67070713          	add	a4,a4,1648 # 1700 <malloc+0x438>
    1098:	97ba                	add	a5,a5,a4
    109a:	439c                	lw	a5,0(a5)
    109c:	97ba                	add	a5,a5,a4
    109e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    10a0:	008b8913          	add	s2,s7,8
    10a4:	4685                	li	a3,1
    10a6:	4629                	li	a2,10
    10a8:	000ba583          	lw	a1,0(s7)
    10ac:	8556                	mv	a0,s5
    10ae:	00000097          	auipc	ra,0x0
    10b2:	ebc080e7          	jalr	-324(ra) # f6a <printint>
    10b6:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    10b8:	4981                	li	s3,0
    10ba:	b745                	j	105a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    10bc:	008b8913          	add	s2,s7,8
    10c0:	4681                	li	a3,0
    10c2:	4629                	li	a2,10
    10c4:	000ba583          	lw	a1,0(s7)
    10c8:	8556                	mv	a0,s5
    10ca:	00000097          	auipc	ra,0x0
    10ce:	ea0080e7          	jalr	-352(ra) # f6a <printint>
    10d2:	8bca                	mv	s7,s2
      state = 0;
    10d4:	4981                	li	s3,0
    10d6:	b751                	j	105a <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
    10d8:	008b8913          	add	s2,s7,8
    10dc:	4681                	li	a3,0
    10de:	4641                	li	a2,16
    10e0:	000ba583          	lw	a1,0(s7)
    10e4:	8556                	mv	a0,s5
    10e6:	00000097          	auipc	ra,0x0
    10ea:	e84080e7          	jalr	-380(ra) # f6a <printint>
    10ee:	8bca                	mv	s7,s2
      state = 0;
    10f0:	4981                	li	s3,0
    10f2:	b7a5                	j	105a <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
    10f4:	008b8c13          	add	s8,s7,8
    10f8:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    10fc:	03000593          	li	a1,48
    1100:	8556                	mv	a0,s5
    1102:	00000097          	auipc	ra,0x0
    1106:	e46080e7          	jalr	-442(ra) # f48 <putc>
  putc(fd, 'x');
    110a:	07800593          	li	a1,120
    110e:	8556                	mv	a0,s5
    1110:	00000097          	auipc	ra,0x0
    1114:	e38080e7          	jalr	-456(ra) # f48 <putc>
    1118:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    111a:	00000b97          	auipc	s7,0x0
    111e:	63eb8b93          	add	s7,s7,1598 # 1758 <digits>
    1122:	03c9d793          	srl	a5,s3,0x3c
    1126:	97de                	add	a5,a5,s7
    1128:	0007c583          	lbu	a1,0(a5)
    112c:	8556                	mv	a0,s5
    112e:	00000097          	auipc	ra,0x0
    1132:	e1a080e7          	jalr	-486(ra) # f48 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1136:	0992                	sll	s3,s3,0x4
    1138:	397d                	addw	s2,s2,-1
    113a:	fe0914e3          	bnez	s2,1122 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
    113e:	8be2                	mv	s7,s8
      state = 0;
    1140:	4981                	li	s3,0
    1142:	bf21                	j	105a <vprintf+0x44>
        s = va_arg(ap, char*);
    1144:	008b8993          	add	s3,s7,8
    1148:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    114c:	02090163          	beqz	s2,116e <vprintf+0x158>
        while(*s != 0){
    1150:	00094583          	lbu	a1,0(s2)
    1154:	c9a5                	beqz	a1,11c4 <vprintf+0x1ae>
          putc(fd, *s);
    1156:	8556                	mv	a0,s5
    1158:	00000097          	auipc	ra,0x0
    115c:	df0080e7          	jalr	-528(ra) # f48 <putc>
          s++;
    1160:	0905                	add	s2,s2,1
        while(*s != 0){
    1162:	00094583          	lbu	a1,0(s2)
    1166:	f9e5                	bnez	a1,1156 <vprintf+0x140>
        s = va_arg(ap, char*);
    1168:	8bce                	mv	s7,s3
      state = 0;
    116a:	4981                	li	s3,0
    116c:	b5fd                	j	105a <vprintf+0x44>
          s = "(null)";
    116e:	00000917          	auipc	s2,0x0
    1172:	58a90913          	add	s2,s2,1418 # 16f8 <malloc+0x430>
        while(*s != 0){
    1176:	02800593          	li	a1,40
    117a:	bff1                	j	1156 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
    117c:	008b8913          	add	s2,s7,8
    1180:	000bc583          	lbu	a1,0(s7)
    1184:	8556                	mv	a0,s5
    1186:	00000097          	auipc	ra,0x0
    118a:	dc2080e7          	jalr	-574(ra) # f48 <putc>
    118e:	8bca                	mv	s7,s2
      state = 0;
    1190:	4981                	li	s3,0
    1192:	b5e1                	j	105a <vprintf+0x44>
        putc(fd, c);
    1194:	02500593          	li	a1,37
    1198:	8556                	mv	a0,s5
    119a:	00000097          	auipc	ra,0x0
    119e:	dae080e7          	jalr	-594(ra) # f48 <putc>
      state = 0;
    11a2:	4981                	li	s3,0
    11a4:	bd5d                	j	105a <vprintf+0x44>
        putc(fd, '%');
    11a6:	02500593          	li	a1,37
    11aa:	8556                	mv	a0,s5
    11ac:	00000097          	auipc	ra,0x0
    11b0:	d9c080e7          	jalr	-612(ra) # f48 <putc>
        putc(fd, c);
    11b4:	85ca                	mv	a1,s2
    11b6:	8556                	mv	a0,s5
    11b8:	00000097          	auipc	ra,0x0
    11bc:	d90080e7          	jalr	-624(ra) # f48 <putc>
      state = 0;
    11c0:	4981                	li	s3,0
    11c2:	bd61                	j	105a <vprintf+0x44>
        s = va_arg(ap, char*);
    11c4:	8bce                	mv	s7,s3
      state = 0;
    11c6:	4981                	li	s3,0
    11c8:	bd49                	j	105a <vprintf+0x44>
    }
  }
}
    11ca:	60a6                	ld	ra,72(sp)
    11cc:	6406                	ld	s0,64(sp)
    11ce:	74e2                	ld	s1,56(sp)
    11d0:	7942                	ld	s2,48(sp)
    11d2:	79a2                	ld	s3,40(sp)
    11d4:	7a02                	ld	s4,32(sp)
    11d6:	6ae2                	ld	s5,24(sp)
    11d8:	6b42                	ld	s6,16(sp)
    11da:	6ba2                	ld	s7,8(sp)
    11dc:	6c02                	ld	s8,0(sp)
    11de:	6161                	add	sp,sp,80
    11e0:	8082                	ret

00000000000011e2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    11e2:	715d                	add	sp,sp,-80
    11e4:	ec06                	sd	ra,24(sp)
    11e6:	e822                	sd	s0,16(sp)
    11e8:	1000                	add	s0,sp,32
    11ea:	e010                	sd	a2,0(s0)
    11ec:	e414                	sd	a3,8(s0)
    11ee:	e818                	sd	a4,16(s0)
    11f0:	ec1c                	sd	a5,24(s0)
    11f2:	03043023          	sd	a6,32(s0)
    11f6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    11fa:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    11fe:	8622                	mv	a2,s0
    1200:	00000097          	auipc	ra,0x0
    1204:	e16080e7          	jalr	-490(ra) # 1016 <vprintf>
}
    1208:	60e2                	ld	ra,24(sp)
    120a:	6442                	ld	s0,16(sp)
    120c:	6161                	add	sp,sp,80
    120e:	8082                	ret

0000000000001210 <printf>:

void
printf(const char *fmt, ...)
{
    1210:	711d                	add	sp,sp,-96
    1212:	ec06                	sd	ra,24(sp)
    1214:	e822                	sd	s0,16(sp)
    1216:	1000                	add	s0,sp,32
    1218:	e40c                	sd	a1,8(s0)
    121a:	e810                	sd	a2,16(s0)
    121c:	ec14                	sd	a3,24(s0)
    121e:	f018                	sd	a4,32(s0)
    1220:	f41c                	sd	a5,40(s0)
    1222:	03043823          	sd	a6,48(s0)
    1226:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    122a:	00840613          	add	a2,s0,8
    122e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1232:	85aa                	mv	a1,a0
    1234:	4505                	li	a0,1
    1236:	00000097          	auipc	ra,0x0
    123a:	de0080e7          	jalr	-544(ra) # 1016 <vprintf>
}
    123e:	60e2                	ld	ra,24(sp)
    1240:	6442                	ld	s0,16(sp)
    1242:	6125                	add	sp,sp,96
    1244:	8082                	ret

0000000000001246 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1246:	1141                	add	sp,sp,-16
    1248:	e422                	sd	s0,8(sp)
    124a:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    124c:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1250:	00001797          	auipc	a5,0x1
    1254:	dc07b783          	ld	a5,-576(a5) # 2010 <freep>
    1258:	a02d                	j	1282 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    125a:	4618                	lw	a4,8(a2)
    125c:	9f2d                	addw	a4,a4,a1
    125e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1262:	6398                	ld	a4,0(a5)
    1264:	6310                	ld	a2,0(a4)
    1266:	a83d                	j	12a4 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1268:	ff852703          	lw	a4,-8(a0)
    126c:	9f31                	addw	a4,a4,a2
    126e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1270:	ff053683          	ld	a3,-16(a0)
    1274:	a091                	j	12b8 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1276:	6398                	ld	a4,0(a5)
    1278:	00e7e463          	bltu	a5,a4,1280 <free+0x3a>
    127c:	00e6ea63          	bltu	a3,a4,1290 <free+0x4a>
{
    1280:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1282:	fed7fae3          	bgeu	a5,a3,1276 <free+0x30>
    1286:	6398                	ld	a4,0(a5)
    1288:	00e6e463          	bltu	a3,a4,1290 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    128c:	fee7eae3          	bltu	a5,a4,1280 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    1290:	ff852583          	lw	a1,-8(a0)
    1294:	6390                	ld	a2,0(a5)
    1296:	02059813          	sll	a6,a1,0x20
    129a:	01c85713          	srl	a4,a6,0x1c
    129e:	9736                	add	a4,a4,a3
    12a0:	fae60de3          	beq	a2,a4,125a <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    12a4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    12a8:	4790                	lw	a2,8(a5)
    12aa:	02061593          	sll	a1,a2,0x20
    12ae:	01c5d713          	srl	a4,a1,0x1c
    12b2:	973e                	add	a4,a4,a5
    12b4:	fae68ae3          	beq	a3,a4,1268 <free+0x22>
    p->s.ptr = bp->s.ptr;
    12b8:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    12ba:	00001717          	auipc	a4,0x1
    12be:	d4f73b23          	sd	a5,-682(a4) # 2010 <freep>
}
    12c2:	6422                	ld	s0,8(sp)
    12c4:	0141                	add	sp,sp,16
    12c6:	8082                	ret

00000000000012c8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    12c8:	7139                	add	sp,sp,-64
    12ca:	fc06                	sd	ra,56(sp)
    12cc:	f822                	sd	s0,48(sp)
    12ce:	f426                	sd	s1,40(sp)
    12d0:	f04a                	sd	s2,32(sp)
    12d2:	ec4e                	sd	s3,24(sp)
    12d4:	e852                	sd	s4,16(sp)
    12d6:	e456                	sd	s5,8(sp)
    12d8:	e05a                	sd	s6,0(sp)
    12da:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    12dc:	02051493          	sll	s1,a0,0x20
    12e0:	9081                	srl	s1,s1,0x20
    12e2:	04bd                	add	s1,s1,15
    12e4:	8091                	srl	s1,s1,0x4
    12e6:	0014899b          	addw	s3,s1,1
    12ea:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    12ec:	00001517          	auipc	a0,0x1
    12f0:	d2453503          	ld	a0,-732(a0) # 2010 <freep>
    12f4:	c515                	beqz	a0,1320 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    12f6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    12f8:	4798                	lw	a4,8(a5)
    12fa:	02977f63          	bgeu	a4,s1,1338 <malloc+0x70>
  if(nu < 4096)
    12fe:	8a4e                	mv	s4,s3
    1300:	0009871b          	sext.w	a4,s3
    1304:	6685                	lui	a3,0x1
    1306:	00d77363          	bgeu	a4,a3,130c <malloc+0x44>
    130a:	6a05                	lui	s4,0x1
    130c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1310:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1314:	00001917          	auipc	s2,0x1
    1318:	cfc90913          	add	s2,s2,-772 # 2010 <freep>
  if(p == (char*)-1)
    131c:	5afd                	li	s5,-1
    131e:	a895                	j	1392 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
    1320:	00001797          	auipc	a5,0x1
    1324:	0e878793          	add	a5,a5,232 # 2408 <base>
    1328:	00001717          	auipc	a4,0x1
    132c:	cef73423          	sd	a5,-792(a4) # 2010 <freep>
    1330:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1332:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    1336:	b7e1                	j	12fe <malloc+0x36>
      if(p->s.size == nunits)
    1338:	02e48c63          	beq	s1,a4,1370 <malloc+0xa8>
        p->s.size -= nunits;
    133c:	4137073b          	subw	a4,a4,s3
    1340:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1342:	02071693          	sll	a3,a4,0x20
    1346:	01c6d713          	srl	a4,a3,0x1c
    134a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    134c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    1350:	00001717          	auipc	a4,0x1
    1354:	cca73023          	sd	a0,-832(a4) # 2010 <freep>
      return (void*)(p + 1);
    1358:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    135c:	70e2                	ld	ra,56(sp)
    135e:	7442                	ld	s0,48(sp)
    1360:	74a2                	ld	s1,40(sp)
    1362:	7902                	ld	s2,32(sp)
    1364:	69e2                	ld	s3,24(sp)
    1366:	6a42                	ld	s4,16(sp)
    1368:	6aa2                	ld	s5,8(sp)
    136a:	6b02                	ld	s6,0(sp)
    136c:	6121                	add	sp,sp,64
    136e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    1370:	6398                	ld	a4,0(a5)
    1372:	e118                	sd	a4,0(a0)
    1374:	bff1                	j	1350 <malloc+0x88>
  hp->s.size = nu;
    1376:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    137a:	0541                	add	a0,a0,16
    137c:	00000097          	auipc	ra,0x0
    1380:	eca080e7          	jalr	-310(ra) # 1246 <free>
  return freep;
    1384:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    1388:	d971                	beqz	a0,135c <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    138a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    138c:	4798                	lw	a4,8(a5)
    138e:	fa9775e3          	bgeu	a4,s1,1338 <malloc+0x70>
    if(p == freep)
    1392:	00093703          	ld	a4,0(s2)
    1396:	853e                	mv	a0,a5
    1398:	fef719e3          	bne	a4,a5,138a <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
    139c:	8552                	mv	a0,s4
    139e:	00000097          	auipc	ra,0x0
    13a2:	b72080e7          	jalr	-1166(ra) # f10 <sbrk>
  if(p == (char*)-1)
    13a6:	fd5518e3          	bne	a0,s5,1376 <malloc+0xae>
        return 0;
    13aa:	4501                	li	a0,0
    13ac:	bf45                	j	135c <malloc+0x94>
