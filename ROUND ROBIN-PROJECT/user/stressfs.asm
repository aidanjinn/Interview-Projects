
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dd010113          	add	sp,sp,-560
   4:	22113423          	sd	ra,552(sp)
   8:	22813023          	sd	s0,544(sp)
   c:	20913c23          	sd	s1,536(sp)
  10:	21213823          	sd	s2,528(sp)
  14:	1c00                	add	s0,sp,560
  int fd, i;
  char path[] = "stressfs0";
  16:	00001797          	auipc	a5,0x1
  1a:	93a78793          	add	a5,a5,-1734 # 950 <malloc+0x124>
  1e:	6398                	ld	a4,0(a5)
  20:	fce43823          	sd	a4,-48(s0)
  24:	0087d783          	lhu	a5,8(a5)
  28:	fcf41c23          	sh	a5,-40(s0)
  char data[512];

  printf("stressfs starting\n");
  2c:	00001517          	auipc	a0,0x1
  30:	8f450513          	add	a0,a0,-1804 # 920 <malloc+0xf4>
  34:	00000097          	auipc	ra,0x0
  38:	740080e7          	jalr	1856(ra) # 774 <printf>
  memset(data, 'a', sizeof(data));
  3c:	20000613          	li	a2,512
  40:	06100593          	li	a1,97
  44:	dd040513          	add	a0,s0,-560
  48:	00000097          	auipc	ra,0x0
  4c:	150080e7          	jalr	336(ra) # 198 <memset>

  for(i = 0; i < 4; i++)
  50:	4481                	li	s1,0
  52:	4911                	li	s2,4
    if(fork() > 0)
  54:	00000097          	auipc	ra,0x0
  58:	390080e7          	jalr	912(ra) # 3e4 <fork>
  5c:	00a04563          	bgtz	a0,66 <main+0x66>
  for(i = 0; i < 4; i++)
  60:	2485                	addw	s1,s1,1
  62:	ff2499e3          	bne	s1,s2,54 <main+0x54>
      break;

  printf("write %d\n", i);
  66:	85a6                	mv	a1,s1
  68:	00001517          	auipc	a0,0x1
  6c:	8d050513          	add	a0,a0,-1840 # 938 <malloc+0x10c>
  70:	00000097          	auipc	ra,0x0
  74:	704080e7          	jalr	1796(ra) # 774 <printf>

  path[8] += i;
  78:	fd844783          	lbu	a5,-40(s0)
  7c:	9fa5                	addw	a5,a5,s1
  7e:	fcf40c23          	sb	a5,-40(s0)
  fd = open(path, O_CREATE | O_RDWR);
  82:	20200593          	li	a1,514
  86:	fd040513          	add	a0,s0,-48
  8a:	00000097          	auipc	ra,0x0
  8e:	3a2080e7          	jalr	930(ra) # 42c <open>
  92:	892a                	mv	s2,a0
  94:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  96:	20000613          	li	a2,512
  9a:	dd040593          	add	a1,s0,-560
  9e:	854a                	mv	a0,s2
  a0:	00000097          	auipc	ra,0x0
  a4:	36c080e7          	jalr	876(ra) # 40c <write>
  for(i = 0; i < 20; i++)
  a8:	34fd                	addw	s1,s1,-1
  aa:	f4f5                	bnez	s1,96 <main+0x96>
  close(fd);
  ac:	854a                	mv	a0,s2
  ae:	00000097          	auipc	ra,0x0
  b2:	366080e7          	jalr	870(ra) # 414 <close>

  printf("read\n");
  b6:	00001517          	auipc	a0,0x1
  ba:	89250513          	add	a0,a0,-1902 # 948 <malloc+0x11c>
  be:	00000097          	auipc	ra,0x0
  c2:	6b6080e7          	jalr	1718(ra) # 774 <printf>

  fd = open(path, O_RDONLY);
  c6:	4581                	li	a1,0
  c8:	fd040513          	add	a0,s0,-48
  cc:	00000097          	auipc	ra,0x0
  d0:	360080e7          	jalr	864(ra) # 42c <open>
  d4:	892a                	mv	s2,a0
  d6:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  d8:	20000613          	li	a2,512
  dc:	dd040593          	add	a1,s0,-560
  e0:	854a                	mv	a0,s2
  e2:	00000097          	auipc	ra,0x0
  e6:	322080e7          	jalr	802(ra) # 404 <read>
  for (i = 0; i < 20; i++)
  ea:	34fd                	addw	s1,s1,-1
  ec:	f4f5                	bnez	s1,d8 <main+0xd8>
  close(fd);
  ee:	854a                	mv	a0,s2
  f0:	00000097          	auipc	ra,0x0
  f4:	324080e7          	jalr	804(ra) # 414 <close>

  wait(0);
  f8:	4501                	li	a0,0
  fa:	00000097          	auipc	ra,0x0
  fe:	2fa080e7          	jalr	762(ra) # 3f4 <wait>

  exit(0);
 102:	4501                	li	a0,0
 104:	00000097          	auipc	ra,0x0
 108:	2e8080e7          	jalr	744(ra) # 3ec <exit>

000000000000010c <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 10c:	1141                	add	sp,sp,-16
 10e:	e406                	sd	ra,8(sp)
 110:	e022                	sd	s0,0(sp)
 112:	0800                	add	s0,sp,16
  extern int main();
  main();
 114:	00000097          	auipc	ra,0x0
 118:	eec080e7          	jalr	-276(ra) # 0 <main>
  exit(0);
 11c:	4501                	li	a0,0
 11e:	00000097          	auipc	ra,0x0
 122:	2ce080e7          	jalr	718(ra) # 3ec <exit>

0000000000000126 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 126:	1141                	add	sp,sp,-16
 128:	e422                	sd	s0,8(sp)
 12a:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 12c:	87aa                	mv	a5,a0
 12e:	0585                	add	a1,a1,1
 130:	0785                	add	a5,a5,1
 132:	fff5c703          	lbu	a4,-1(a1)
 136:	fee78fa3          	sb	a4,-1(a5)
 13a:	fb75                	bnez	a4,12e <strcpy+0x8>
    ;
  return os;
}
 13c:	6422                	ld	s0,8(sp)
 13e:	0141                	add	sp,sp,16
 140:	8082                	ret

0000000000000142 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 142:	1141                	add	sp,sp,-16
 144:	e422                	sd	s0,8(sp)
 146:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 148:	00054783          	lbu	a5,0(a0)
 14c:	cb91                	beqz	a5,160 <strcmp+0x1e>
 14e:	0005c703          	lbu	a4,0(a1)
 152:	00f71763          	bne	a4,a5,160 <strcmp+0x1e>
    p++, q++;
 156:	0505                	add	a0,a0,1
 158:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 15a:	00054783          	lbu	a5,0(a0)
 15e:	fbe5                	bnez	a5,14e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 160:	0005c503          	lbu	a0,0(a1)
}
 164:	40a7853b          	subw	a0,a5,a0
 168:	6422                	ld	s0,8(sp)
 16a:	0141                	add	sp,sp,16
 16c:	8082                	ret

000000000000016e <strlen>:

uint
strlen(const char *s)
{
 16e:	1141                	add	sp,sp,-16
 170:	e422                	sd	s0,8(sp)
 172:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 174:	00054783          	lbu	a5,0(a0)
 178:	cf91                	beqz	a5,194 <strlen+0x26>
 17a:	0505                	add	a0,a0,1
 17c:	87aa                	mv	a5,a0
 17e:	86be                	mv	a3,a5
 180:	0785                	add	a5,a5,1
 182:	fff7c703          	lbu	a4,-1(a5)
 186:	ff65                	bnez	a4,17e <strlen+0x10>
 188:	40a6853b          	subw	a0,a3,a0
 18c:	2505                	addw	a0,a0,1
    ;
  return n;
}
 18e:	6422                	ld	s0,8(sp)
 190:	0141                	add	sp,sp,16
 192:	8082                	ret
  for(n = 0; s[n]; n++)
 194:	4501                	li	a0,0
 196:	bfe5                	j	18e <strlen+0x20>

0000000000000198 <memset>:

void*
memset(void *dst, int c, uint n)
{
 198:	1141                	add	sp,sp,-16
 19a:	e422                	sd	s0,8(sp)
 19c:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 19e:	ca19                	beqz	a2,1b4 <memset+0x1c>
 1a0:	87aa                	mv	a5,a0
 1a2:	1602                	sll	a2,a2,0x20
 1a4:	9201                	srl	a2,a2,0x20
 1a6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1aa:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1ae:	0785                	add	a5,a5,1
 1b0:	fee79de3          	bne	a5,a4,1aa <memset+0x12>
  }
  return dst;
}
 1b4:	6422                	ld	s0,8(sp)
 1b6:	0141                	add	sp,sp,16
 1b8:	8082                	ret

00000000000001ba <strchr>:

char*
strchr(const char *s, char c)
{
 1ba:	1141                	add	sp,sp,-16
 1bc:	e422                	sd	s0,8(sp)
 1be:	0800                	add	s0,sp,16
  for(; *s; s++)
 1c0:	00054783          	lbu	a5,0(a0)
 1c4:	cb99                	beqz	a5,1da <strchr+0x20>
    if(*s == c)
 1c6:	00f58763          	beq	a1,a5,1d4 <strchr+0x1a>
  for(; *s; s++)
 1ca:	0505                	add	a0,a0,1
 1cc:	00054783          	lbu	a5,0(a0)
 1d0:	fbfd                	bnez	a5,1c6 <strchr+0xc>
      return (char*)s;
  return 0;
 1d2:	4501                	li	a0,0
}
 1d4:	6422                	ld	s0,8(sp)
 1d6:	0141                	add	sp,sp,16
 1d8:	8082                	ret
  return 0;
 1da:	4501                	li	a0,0
 1dc:	bfe5                	j	1d4 <strchr+0x1a>

00000000000001de <strstr>:

char*
strstr(const char *str, const char *substr)
{
 1de:	1141                	add	sp,sp,-16
 1e0:	e422                	sd	s0,8(sp)
 1e2:	0800                	add	s0,sp,16
  const char *a, *b = substr;
  if (*b == 0)
 1e4:	0005c803          	lbu	a6,0(a1)
 1e8:	02080a63          	beqz	a6,21c <strstr+0x3e>
    return (char*)str;
  for( ; *str != 0; str += 1) {
 1ec:	00054783          	lbu	a5,0(a0)
 1f0:	e799                	bnez	a5,1fe <strstr+0x20>
      if (*a++ != *b++)
        break;
    }
    b = substr;
  }
  return 0;
 1f2:	4501                	li	a0,0
 1f4:	a025                	j	21c <strstr+0x3e>
  for( ; *str != 0; str += 1) {
 1f6:	0505                	add	a0,a0,1
 1f8:	00054783          	lbu	a5,0(a0)
 1fc:	cf99                	beqz	a5,21a <strstr+0x3c>
    if (*str != *b)
 1fe:	fef81ce3          	bne	a6,a5,1f6 <strstr+0x18>
 202:	87ae                	mv	a5,a1
 204:	86aa                	mv	a3,a0
      if (*b == 0)
 206:	0007c703          	lbu	a4,0(a5)
 20a:	cb09                	beqz	a4,21c <strstr+0x3e>
      if (*a++ != *b++)
 20c:	0685                	add	a3,a3,1
 20e:	0785                	add	a5,a5,1
 210:	fff6c603          	lbu	a2,-1(a3)
 214:	fee609e3          	beq	a2,a4,206 <strstr+0x28>
 218:	bff9                	j	1f6 <strstr+0x18>
  return 0;
 21a:	4501                	li	a0,0
}
 21c:	6422                	ld	s0,8(sp)
 21e:	0141                	add	sp,sp,16
 220:	8082                	ret

0000000000000222 <gets>:

char*
gets(char *buf, int max)
{
 222:	711d                	add	sp,sp,-96
 224:	ec86                	sd	ra,88(sp)
 226:	e8a2                	sd	s0,80(sp)
 228:	e4a6                	sd	s1,72(sp)
 22a:	e0ca                	sd	s2,64(sp)
 22c:	fc4e                	sd	s3,56(sp)
 22e:	f852                	sd	s4,48(sp)
 230:	f456                	sd	s5,40(sp)
 232:	f05a                	sd	s6,32(sp)
 234:	ec5e                	sd	s7,24(sp)
 236:	1080                	add	s0,sp,96
 238:	8baa                	mv	s7,a0
 23a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 23c:	892a                	mv	s2,a0
 23e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 240:	4aa9                	li	s5,10
 242:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 244:	89a6                	mv	s3,s1
 246:	2485                	addw	s1,s1,1
 248:	0344d863          	bge	s1,s4,278 <gets+0x56>
    cc = read(0, &c, 1);
 24c:	4605                	li	a2,1
 24e:	faf40593          	add	a1,s0,-81
 252:	4501                	li	a0,0
 254:	00000097          	auipc	ra,0x0
 258:	1b0080e7          	jalr	432(ra) # 404 <read>
    if(cc < 1)
 25c:	00a05e63          	blez	a0,278 <gets+0x56>
    buf[i++] = c;
 260:	faf44783          	lbu	a5,-81(s0)
 264:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 268:	01578763          	beq	a5,s5,276 <gets+0x54>
 26c:	0905                	add	s2,s2,1
 26e:	fd679be3          	bne	a5,s6,244 <gets+0x22>
  for(i=0; i+1 < max; ){
 272:	89a6                	mv	s3,s1
 274:	a011                	j	278 <gets+0x56>
 276:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 278:	99de                	add	s3,s3,s7
 27a:	00098023          	sb	zero,0(s3)
  return buf;
}
 27e:	855e                	mv	a0,s7
 280:	60e6                	ld	ra,88(sp)
 282:	6446                	ld	s0,80(sp)
 284:	64a6                	ld	s1,72(sp)
 286:	6906                	ld	s2,64(sp)
 288:	79e2                	ld	s3,56(sp)
 28a:	7a42                	ld	s4,48(sp)
 28c:	7aa2                	ld	s5,40(sp)
 28e:	7b02                	ld	s6,32(sp)
 290:	6be2                	ld	s7,24(sp)
 292:	6125                	add	sp,sp,96
 294:	8082                	ret

0000000000000296 <stat>:

int
stat(const char *n, struct stat *st)
{
 296:	1101                	add	sp,sp,-32
 298:	ec06                	sd	ra,24(sp)
 29a:	e822                	sd	s0,16(sp)
 29c:	e426                	sd	s1,8(sp)
 29e:	e04a                	sd	s2,0(sp)
 2a0:	1000                	add	s0,sp,32
 2a2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a4:	4581                	li	a1,0
 2a6:	00000097          	auipc	ra,0x0
 2aa:	186080e7          	jalr	390(ra) # 42c <open>
  if(fd < 0)
 2ae:	02054563          	bltz	a0,2d8 <stat+0x42>
 2b2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2b4:	85ca                	mv	a1,s2
 2b6:	00000097          	auipc	ra,0x0
 2ba:	18e080e7          	jalr	398(ra) # 444 <fstat>
 2be:	892a                	mv	s2,a0
  close(fd);
 2c0:	8526                	mv	a0,s1
 2c2:	00000097          	auipc	ra,0x0
 2c6:	152080e7          	jalr	338(ra) # 414 <close>
  return r;
}
 2ca:	854a                	mv	a0,s2
 2cc:	60e2                	ld	ra,24(sp)
 2ce:	6442                	ld	s0,16(sp)
 2d0:	64a2                	ld	s1,8(sp)
 2d2:	6902                	ld	s2,0(sp)
 2d4:	6105                	add	sp,sp,32
 2d6:	8082                	ret
    return -1;
 2d8:	597d                	li	s2,-1
 2da:	bfc5                	j	2ca <stat+0x34>

00000000000002dc <atoi>:

int
atoi(const char *s)
{
 2dc:	1141                	add	sp,sp,-16
 2de:	e422                	sd	s0,8(sp)
 2e0:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2e2:	00054683          	lbu	a3,0(a0)
 2e6:	fd06879b          	addw	a5,a3,-48
 2ea:	0ff7f793          	zext.b	a5,a5
 2ee:	4625                	li	a2,9
 2f0:	02f66863          	bltu	a2,a5,320 <atoi+0x44>
 2f4:	872a                	mv	a4,a0
  n = 0;
 2f6:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2f8:	0705                	add	a4,a4,1
 2fa:	0025179b          	sllw	a5,a0,0x2
 2fe:	9fa9                	addw	a5,a5,a0
 300:	0017979b          	sllw	a5,a5,0x1
 304:	9fb5                	addw	a5,a5,a3
 306:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 30a:	00074683          	lbu	a3,0(a4)
 30e:	fd06879b          	addw	a5,a3,-48
 312:	0ff7f793          	zext.b	a5,a5
 316:	fef671e3          	bgeu	a2,a5,2f8 <atoi+0x1c>
  return n;
}
 31a:	6422                	ld	s0,8(sp)
 31c:	0141                	add	sp,sp,16
 31e:	8082                	ret
  n = 0;
 320:	4501                	li	a0,0
 322:	bfe5                	j	31a <atoi+0x3e>

0000000000000324 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 324:	1141                	add	sp,sp,-16
 326:	e422                	sd	s0,8(sp)
 328:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 32a:	02b57463          	bgeu	a0,a1,352 <memmove+0x2e>
    while(n-- > 0)
 32e:	00c05f63          	blez	a2,34c <memmove+0x28>
 332:	1602                	sll	a2,a2,0x20
 334:	9201                	srl	a2,a2,0x20
 336:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 33a:	872a                	mv	a4,a0
      *dst++ = *src++;
 33c:	0585                	add	a1,a1,1
 33e:	0705                	add	a4,a4,1
 340:	fff5c683          	lbu	a3,-1(a1)
 344:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 348:	fee79ae3          	bne	a5,a4,33c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 34c:	6422                	ld	s0,8(sp)
 34e:	0141                	add	sp,sp,16
 350:	8082                	ret
    dst += n;
 352:	00c50733          	add	a4,a0,a2
    src += n;
 356:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 358:	fec05ae3          	blez	a2,34c <memmove+0x28>
 35c:	fff6079b          	addw	a5,a2,-1
 360:	1782                	sll	a5,a5,0x20
 362:	9381                	srl	a5,a5,0x20
 364:	fff7c793          	not	a5,a5
 368:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 36a:	15fd                	add	a1,a1,-1
 36c:	177d                	add	a4,a4,-1
 36e:	0005c683          	lbu	a3,0(a1)
 372:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 376:	fee79ae3          	bne	a5,a4,36a <memmove+0x46>
 37a:	bfc9                	j	34c <memmove+0x28>

000000000000037c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 37c:	1141                	add	sp,sp,-16
 37e:	e422                	sd	s0,8(sp)
 380:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 382:	ca05                	beqz	a2,3b2 <memcmp+0x36>
 384:	fff6069b          	addw	a3,a2,-1
 388:	1682                	sll	a3,a3,0x20
 38a:	9281                	srl	a3,a3,0x20
 38c:	0685                	add	a3,a3,1
 38e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 390:	00054783          	lbu	a5,0(a0)
 394:	0005c703          	lbu	a4,0(a1)
 398:	00e79863          	bne	a5,a4,3a8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 39c:	0505                	add	a0,a0,1
    p2++;
 39e:	0585                	add	a1,a1,1
  while (n-- > 0) {
 3a0:	fed518e3          	bne	a0,a3,390 <memcmp+0x14>
  }
  return 0;
 3a4:	4501                	li	a0,0
 3a6:	a019                	j	3ac <memcmp+0x30>
      return *p1 - *p2;
 3a8:	40e7853b          	subw	a0,a5,a4
}
 3ac:	6422                	ld	s0,8(sp)
 3ae:	0141                	add	sp,sp,16
 3b0:	8082                	ret
  return 0;
 3b2:	4501                	li	a0,0
 3b4:	bfe5                	j	3ac <memcmp+0x30>

00000000000003b6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3b6:	1141                	add	sp,sp,-16
 3b8:	e406                	sd	ra,8(sp)
 3ba:	e022                	sd	s0,0(sp)
 3bc:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 3be:	00000097          	auipc	ra,0x0
 3c2:	f66080e7          	jalr	-154(ra) # 324 <memmove>
}
 3c6:	60a2                	ld	ra,8(sp)
 3c8:	6402                	ld	s0,0(sp)
 3ca:	0141                	add	sp,sp,16
 3cc:	8082                	ret

00000000000003ce <ugetpid>:

int
ugetpid(void)
{
 3ce:	1141                	add	sp,sp,-16
 3d0:	e422                	sd	s0,8(sp)
 3d2:	0800                	add	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 3d4:	040007b7          	lui	a5,0x4000
}
 3d8:	17f5                	add	a5,a5,-3 # 3fffffd <base+0x3ffefed>
 3da:	07b2                	sll	a5,a5,0xc
 3dc:	4388                	lw	a0,0(a5)
 3de:	6422                	ld	s0,8(sp)
 3e0:	0141                	add	sp,sp,16
 3e2:	8082                	ret

00000000000003e4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3e4:	4885                	li	a7,1
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <exit>:
.global exit
exit:
 li a7, SYS_exit
 3ec:	4889                	li	a7,2
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3f4:	488d                	li	a7,3
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3fc:	4891                	li	a7,4
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <read>:
.global read
read:
 li a7, SYS_read
 404:	4895                	li	a7,5
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <write>:
.global write
write:
 li a7, SYS_write
 40c:	48c1                	li	a7,16
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <close>:
.global close
close:
 li a7, SYS_close
 414:	48d5                	li	a7,21
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <kill>:
.global kill
kill:
 li a7, SYS_kill
 41c:	4899                	li	a7,6
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <exec>:
.global exec
exec:
 li a7, SYS_exec
 424:	489d                	li	a7,7
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <open>:
.global open
open:
 li a7, SYS_open
 42c:	48bd                	li	a7,15
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 434:	48c5                	li	a7,17
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 43c:	48c9                	li	a7,18
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 444:	48a1                	li	a7,8
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <link>:
.global link
link:
 li a7, SYS_link
 44c:	48cd                	li	a7,19
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 454:	48d1                	li	a7,20
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 45c:	48a5                	li	a7,9
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <dup>:
.global dup
dup:
 li a7, SYS_dup
 464:	48a9                	li	a7,10
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 46c:	48ad                	li	a7,11
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 474:	48b1                	li	a7,12
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 47c:	48b5                	li	a7,13
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 484:	48b9                	li	a7,14
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <trace>:
.global trace
trace:
 li a7, SYS_trace
 48c:	48d9                	li	a7,22
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 494:	48dd                	li	a7,23
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 49c:	48e1                	li	a7,24
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <setpriority>:
.global setpriority
setpriority:
 li a7, SYS_setpriority
 4a4:	48e5                	li	a7,25
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4ac:	1101                	add	sp,sp,-32
 4ae:	ec06                	sd	ra,24(sp)
 4b0:	e822                	sd	s0,16(sp)
 4b2:	1000                	add	s0,sp,32
 4b4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4b8:	4605                	li	a2,1
 4ba:	fef40593          	add	a1,s0,-17
 4be:	00000097          	auipc	ra,0x0
 4c2:	f4e080e7          	jalr	-178(ra) # 40c <write>
}
 4c6:	60e2                	ld	ra,24(sp)
 4c8:	6442                	ld	s0,16(sp)
 4ca:	6105                	add	sp,sp,32
 4cc:	8082                	ret

00000000000004ce <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4ce:	7139                	add	sp,sp,-64
 4d0:	fc06                	sd	ra,56(sp)
 4d2:	f822                	sd	s0,48(sp)
 4d4:	f426                	sd	s1,40(sp)
 4d6:	f04a                	sd	s2,32(sp)
 4d8:	ec4e                	sd	s3,24(sp)
 4da:	0080                	add	s0,sp,64
 4dc:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4de:	c299                	beqz	a3,4e4 <printint+0x16>
 4e0:	0805c963          	bltz	a1,572 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4e4:	2581                	sext.w	a1,a1
  neg = 0;
 4e6:	4881                	li	a7,0
 4e8:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 4ec:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4ee:	2601                	sext.w	a2,a2
 4f0:	00000517          	auipc	a0,0x0
 4f4:	4d050513          	add	a0,a0,1232 # 9c0 <digits>
 4f8:	883a                	mv	a6,a4
 4fa:	2705                	addw	a4,a4,1
 4fc:	02c5f7bb          	remuw	a5,a1,a2
 500:	1782                	sll	a5,a5,0x20
 502:	9381                	srl	a5,a5,0x20
 504:	97aa                	add	a5,a5,a0
 506:	0007c783          	lbu	a5,0(a5)
 50a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 50e:	0005879b          	sext.w	a5,a1
 512:	02c5d5bb          	divuw	a1,a1,a2
 516:	0685                	add	a3,a3,1
 518:	fec7f0e3          	bgeu	a5,a2,4f8 <printint+0x2a>
  if(neg)
 51c:	00088c63          	beqz	a7,534 <printint+0x66>
    buf[i++] = '-';
 520:	fd070793          	add	a5,a4,-48
 524:	00878733          	add	a4,a5,s0
 528:	02d00793          	li	a5,45
 52c:	fef70823          	sb	a5,-16(a4)
 530:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 534:	02e05863          	blez	a4,564 <printint+0x96>
 538:	fc040793          	add	a5,s0,-64
 53c:	00e78933          	add	s2,a5,a4
 540:	fff78993          	add	s3,a5,-1
 544:	99ba                	add	s3,s3,a4
 546:	377d                	addw	a4,a4,-1
 548:	1702                	sll	a4,a4,0x20
 54a:	9301                	srl	a4,a4,0x20
 54c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 550:	fff94583          	lbu	a1,-1(s2)
 554:	8526                	mv	a0,s1
 556:	00000097          	auipc	ra,0x0
 55a:	f56080e7          	jalr	-170(ra) # 4ac <putc>
  while(--i >= 0)
 55e:	197d                	add	s2,s2,-1
 560:	ff3918e3          	bne	s2,s3,550 <printint+0x82>
}
 564:	70e2                	ld	ra,56(sp)
 566:	7442                	ld	s0,48(sp)
 568:	74a2                	ld	s1,40(sp)
 56a:	7902                	ld	s2,32(sp)
 56c:	69e2                	ld	s3,24(sp)
 56e:	6121                	add	sp,sp,64
 570:	8082                	ret
    x = -xx;
 572:	40b005bb          	negw	a1,a1
    neg = 1;
 576:	4885                	li	a7,1
    x = -xx;
 578:	bf85                	j	4e8 <printint+0x1a>

000000000000057a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 57a:	715d                	add	sp,sp,-80
 57c:	e486                	sd	ra,72(sp)
 57e:	e0a2                	sd	s0,64(sp)
 580:	fc26                	sd	s1,56(sp)
 582:	f84a                	sd	s2,48(sp)
 584:	f44e                	sd	s3,40(sp)
 586:	f052                	sd	s4,32(sp)
 588:	ec56                	sd	s5,24(sp)
 58a:	e85a                	sd	s6,16(sp)
 58c:	e45e                	sd	s7,8(sp)
 58e:	e062                	sd	s8,0(sp)
 590:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 592:	0005c903          	lbu	s2,0(a1)
 596:	18090c63          	beqz	s2,72e <vprintf+0x1b4>
 59a:	8aaa                	mv	s5,a0
 59c:	8bb2                	mv	s7,a2
 59e:	00158493          	add	s1,a1,1
  state = 0;
 5a2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5a4:	02500a13          	li	s4,37
 5a8:	4b55                	li	s6,21
 5aa:	a839                	j	5c8 <vprintf+0x4e>
        putc(fd, c);
 5ac:	85ca                	mv	a1,s2
 5ae:	8556                	mv	a0,s5
 5b0:	00000097          	auipc	ra,0x0
 5b4:	efc080e7          	jalr	-260(ra) # 4ac <putc>
 5b8:	a019                	j	5be <vprintf+0x44>
    } else if(state == '%'){
 5ba:	01498d63          	beq	s3,s4,5d4 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 5be:	0485                	add	s1,s1,1
 5c0:	fff4c903          	lbu	s2,-1(s1)
 5c4:	16090563          	beqz	s2,72e <vprintf+0x1b4>
    if(state == 0){
 5c8:	fe0999e3          	bnez	s3,5ba <vprintf+0x40>
      if(c == '%'){
 5cc:	ff4910e3          	bne	s2,s4,5ac <vprintf+0x32>
        state = '%';
 5d0:	89d2                	mv	s3,s4
 5d2:	b7f5                	j	5be <vprintf+0x44>
      if(c == 'd'){
 5d4:	13490263          	beq	s2,s4,6f8 <vprintf+0x17e>
 5d8:	f9d9079b          	addw	a5,s2,-99
 5dc:	0ff7f793          	zext.b	a5,a5
 5e0:	12fb6563          	bltu	s6,a5,70a <vprintf+0x190>
 5e4:	f9d9079b          	addw	a5,s2,-99
 5e8:	0ff7f713          	zext.b	a4,a5
 5ec:	10eb6f63          	bltu	s6,a4,70a <vprintf+0x190>
 5f0:	00271793          	sll	a5,a4,0x2
 5f4:	00000717          	auipc	a4,0x0
 5f8:	37470713          	add	a4,a4,884 # 968 <malloc+0x13c>
 5fc:	97ba                	add	a5,a5,a4
 5fe:	439c                	lw	a5,0(a5)
 600:	97ba                	add	a5,a5,a4
 602:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 604:	008b8913          	add	s2,s7,8
 608:	4685                	li	a3,1
 60a:	4629                	li	a2,10
 60c:	000ba583          	lw	a1,0(s7)
 610:	8556                	mv	a0,s5
 612:	00000097          	auipc	ra,0x0
 616:	ebc080e7          	jalr	-324(ra) # 4ce <printint>
 61a:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 61c:	4981                	li	s3,0
 61e:	b745                	j	5be <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 620:	008b8913          	add	s2,s7,8
 624:	4681                	li	a3,0
 626:	4629                	li	a2,10
 628:	000ba583          	lw	a1,0(s7)
 62c:	8556                	mv	a0,s5
 62e:	00000097          	auipc	ra,0x0
 632:	ea0080e7          	jalr	-352(ra) # 4ce <printint>
 636:	8bca                	mv	s7,s2
      state = 0;
 638:	4981                	li	s3,0
 63a:	b751                	j	5be <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 63c:	008b8913          	add	s2,s7,8
 640:	4681                	li	a3,0
 642:	4641                	li	a2,16
 644:	000ba583          	lw	a1,0(s7)
 648:	8556                	mv	a0,s5
 64a:	00000097          	auipc	ra,0x0
 64e:	e84080e7          	jalr	-380(ra) # 4ce <printint>
 652:	8bca                	mv	s7,s2
      state = 0;
 654:	4981                	li	s3,0
 656:	b7a5                	j	5be <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 658:	008b8c13          	add	s8,s7,8
 65c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 660:	03000593          	li	a1,48
 664:	8556                	mv	a0,s5
 666:	00000097          	auipc	ra,0x0
 66a:	e46080e7          	jalr	-442(ra) # 4ac <putc>
  putc(fd, 'x');
 66e:	07800593          	li	a1,120
 672:	8556                	mv	a0,s5
 674:	00000097          	auipc	ra,0x0
 678:	e38080e7          	jalr	-456(ra) # 4ac <putc>
 67c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 67e:	00000b97          	auipc	s7,0x0
 682:	342b8b93          	add	s7,s7,834 # 9c0 <digits>
 686:	03c9d793          	srl	a5,s3,0x3c
 68a:	97de                	add	a5,a5,s7
 68c:	0007c583          	lbu	a1,0(a5)
 690:	8556                	mv	a0,s5
 692:	00000097          	auipc	ra,0x0
 696:	e1a080e7          	jalr	-486(ra) # 4ac <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 69a:	0992                	sll	s3,s3,0x4
 69c:	397d                	addw	s2,s2,-1
 69e:	fe0914e3          	bnez	s2,686 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 6a2:	8be2                	mv	s7,s8
      state = 0;
 6a4:	4981                	li	s3,0
 6a6:	bf21                	j	5be <vprintf+0x44>
        s = va_arg(ap, char*);
 6a8:	008b8993          	add	s3,s7,8
 6ac:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 6b0:	02090163          	beqz	s2,6d2 <vprintf+0x158>
        while(*s != 0){
 6b4:	00094583          	lbu	a1,0(s2)
 6b8:	c9a5                	beqz	a1,728 <vprintf+0x1ae>
          putc(fd, *s);
 6ba:	8556                	mv	a0,s5
 6bc:	00000097          	auipc	ra,0x0
 6c0:	df0080e7          	jalr	-528(ra) # 4ac <putc>
          s++;
 6c4:	0905                	add	s2,s2,1
        while(*s != 0){
 6c6:	00094583          	lbu	a1,0(s2)
 6ca:	f9e5                	bnez	a1,6ba <vprintf+0x140>
        s = va_arg(ap, char*);
 6cc:	8bce                	mv	s7,s3
      state = 0;
 6ce:	4981                	li	s3,0
 6d0:	b5fd                	j	5be <vprintf+0x44>
          s = "(null)";
 6d2:	00000917          	auipc	s2,0x0
 6d6:	28e90913          	add	s2,s2,654 # 960 <malloc+0x134>
        while(*s != 0){
 6da:	02800593          	li	a1,40
 6de:	bff1                	j	6ba <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 6e0:	008b8913          	add	s2,s7,8
 6e4:	000bc583          	lbu	a1,0(s7)
 6e8:	8556                	mv	a0,s5
 6ea:	00000097          	auipc	ra,0x0
 6ee:	dc2080e7          	jalr	-574(ra) # 4ac <putc>
 6f2:	8bca                	mv	s7,s2
      state = 0;
 6f4:	4981                	li	s3,0
 6f6:	b5e1                	j	5be <vprintf+0x44>
        putc(fd, c);
 6f8:	02500593          	li	a1,37
 6fc:	8556                	mv	a0,s5
 6fe:	00000097          	auipc	ra,0x0
 702:	dae080e7          	jalr	-594(ra) # 4ac <putc>
      state = 0;
 706:	4981                	li	s3,0
 708:	bd5d                	j	5be <vprintf+0x44>
        putc(fd, '%');
 70a:	02500593          	li	a1,37
 70e:	8556                	mv	a0,s5
 710:	00000097          	auipc	ra,0x0
 714:	d9c080e7          	jalr	-612(ra) # 4ac <putc>
        putc(fd, c);
 718:	85ca                	mv	a1,s2
 71a:	8556                	mv	a0,s5
 71c:	00000097          	auipc	ra,0x0
 720:	d90080e7          	jalr	-624(ra) # 4ac <putc>
      state = 0;
 724:	4981                	li	s3,0
 726:	bd61                	j	5be <vprintf+0x44>
        s = va_arg(ap, char*);
 728:	8bce                	mv	s7,s3
      state = 0;
 72a:	4981                	li	s3,0
 72c:	bd49                	j	5be <vprintf+0x44>
    }
  }
}
 72e:	60a6                	ld	ra,72(sp)
 730:	6406                	ld	s0,64(sp)
 732:	74e2                	ld	s1,56(sp)
 734:	7942                	ld	s2,48(sp)
 736:	79a2                	ld	s3,40(sp)
 738:	7a02                	ld	s4,32(sp)
 73a:	6ae2                	ld	s5,24(sp)
 73c:	6b42                	ld	s6,16(sp)
 73e:	6ba2                	ld	s7,8(sp)
 740:	6c02                	ld	s8,0(sp)
 742:	6161                	add	sp,sp,80
 744:	8082                	ret

0000000000000746 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 746:	715d                	add	sp,sp,-80
 748:	ec06                	sd	ra,24(sp)
 74a:	e822                	sd	s0,16(sp)
 74c:	1000                	add	s0,sp,32
 74e:	e010                	sd	a2,0(s0)
 750:	e414                	sd	a3,8(s0)
 752:	e818                	sd	a4,16(s0)
 754:	ec1c                	sd	a5,24(s0)
 756:	03043023          	sd	a6,32(s0)
 75a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 75e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 762:	8622                	mv	a2,s0
 764:	00000097          	auipc	ra,0x0
 768:	e16080e7          	jalr	-490(ra) # 57a <vprintf>
}
 76c:	60e2                	ld	ra,24(sp)
 76e:	6442                	ld	s0,16(sp)
 770:	6161                	add	sp,sp,80
 772:	8082                	ret

0000000000000774 <printf>:

void
printf(const char *fmt, ...)
{
 774:	711d                	add	sp,sp,-96
 776:	ec06                	sd	ra,24(sp)
 778:	e822                	sd	s0,16(sp)
 77a:	1000                	add	s0,sp,32
 77c:	e40c                	sd	a1,8(s0)
 77e:	e810                	sd	a2,16(s0)
 780:	ec14                	sd	a3,24(s0)
 782:	f018                	sd	a4,32(s0)
 784:	f41c                	sd	a5,40(s0)
 786:	03043823          	sd	a6,48(s0)
 78a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 78e:	00840613          	add	a2,s0,8
 792:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 796:	85aa                	mv	a1,a0
 798:	4505                	li	a0,1
 79a:	00000097          	auipc	ra,0x0
 79e:	de0080e7          	jalr	-544(ra) # 57a <vprintf>
}
 7a2:	60e2                	ld	ra,24(sp)
 7a4:	6442                	ld	s0,16(sp)
 7a6:	6125                	add	sp,sp,96
 7a8:	8082                	ret

00000000000007aa <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7aa:	1141                	add	sp,sp,-16
 7ac:	e422                	sd	s0,8(sp)
 7ae:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7b0:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b4:	00001797          	auipc	a5,0x1
 7b8:	84c7b783          	ld	a5,-1972(a5) # 1000 <freep>
 7bc:	a02d                	j	7e6 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7be:	4618                	lw	a4,8(a2)
 7c0:	9f2d                	addw	a4,a4,a1
 7c2:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7c6:	6398                	ld	a4,0(a5)
 7c8:	6310                	ld	a2,0(a4)
 7ca:	a83d                	j	808 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7cc:	ff852703          	lw	a4,-8(a0)
 7d0:	9f31                	addw	a4,a4,a2
 7d2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7d4:	ff053683          	ld	a3,-16(a0)
 7d8:	a091                	j	81c <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7da:	6398                	ld	a4,0(a5)
 7dc:	00e7e463          	bltu	a5,a4,7e4 <free+0x3a>
 7e0:	00e6ea63          	bltu	a3,a4,7f4 <free+0x4a>
{
 7e4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e6:	fed7fae3          	bgeu	a5,a3,7da <free+0x30>
 7ea:	6398                	ld	a4,0(a5)
 7ec:	00e6e463          	bltu	a3,a4,7f4 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7f0:	fee7eae3          	bltu	a5,a4,7e4 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 7f4:	ff852583          	lw	a1,-8(a0)
 7f8:	6390                	ld	a2,0(a5)
 7fa:	02059813          	sll	a6,a1,0x20
 7fe:	01c85713          	srl	a4,a6,0x1c
 802:	9736                	add	a4,a4,a3
 804:	fae60de3          	beq	a2,a4,7be <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 808:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 80c:	4790                	lw	a2,8(a5)
 80e:	02061593          	sll	a1,a2,0x20
 812:	01c5d713          	srl	a4,a1,0x1c
 816:	973e                	add	a4,a4,a5
 818:	fae68ae3          	beq	a3,a4,7cc <free+0x22>
    p->s.ptr = bp->s.ptr;
 81c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 81e:	00000717          	auipc	a4,0x0
 822:	7ef73123          	sd	a5,2018(a4) # 1000 <freep>
}
 826:	6422                	ld	s0,8(sp)
 828:	0141                	add	sp,sp,16
 82a:	8082                	ret

000000000000082c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 82c:	7139                	add	sp,sp,-64
 82e:	fc06                	sd	ra,56(sp)
 830:	f822                	sd	s0,48(sp)
 832:	f426                	sd	s1,40(sp)
 834:	f04a                	sd	s2,32(sp)
 836:	ec4e                	sd	s3,24(sp)
 838:	e852                	sd	s4,16(sp)
 83a:	e456                	sd	s5,8(sp)
 83c:	e05a                	sd	s6,0(sp)
 83e:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 840:	02051493          	sll	s1,a0,0x20
 844:	9081                	srl	s1,s1,0x20
 846:	04bd                	add	s1,s1,15
 848:	8091                	srl	s1,s1,0x4
 84a:	0014899b          	addw	s3,s1,1
 84e:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 850:	00000517          	auipc	a0,0x0
 854:	7b053503          	ld	a0,1968(a0) # 1000 <freep>
 858:	c515                	beqz	a0,884 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 85a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 85c:	4798                	lw	a4,8(a5)
 85e:	02977f63          	bgeu	a4,s1,89c <malloc+0x70>
  if(nu < 4096)
 862:	8a4e                	mv	s4,s3
 864:	0009871b          	sext.w	a4,s3
 868:	6685                	lui	a3,0x1
 86a:	00d77363          	bgeu	a4,a3,870 <malloc+0x44>
 86e:	6a05                	lui	s4,0x1
 870:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 874:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 878:	00000917          	auipc	s2,0x0
 87c:	78890913          	add	s2,s2,1928 # 1000 <freep>
  if(p == (char*)-1)
 880:	5afd                	li	s5,-1
 882:	a895                	j	8f6 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 884:	00000797          	auipc	a5,0x0
 888:	78c78793          	add	a5,a5,1932 # 1010 <base>
 88c:	00000717          	auipc	a4,0x0
 890:	76f73a23          	sd	a5,1908(a4) # 1000 <freep>
 894:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 896:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 89a:	b7e1                	j	862 <malloc+0x36>
      if(p->s.size == nunits)
 89c:	02e48c63          	beq	s1,a4,8d4 <malloc+0xa8>
        p->s.size -= nunits;
 8a0:	4137073b          	subw	a4,a4,s3
 8a4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8a6:	02071693          	sll	a3,a4,0x20
 8aa:	01c6d713          	srl	a4,a3,0x1c
 8ae:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8b0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8b4:	00000717          	auipc	a4,0x0
 8b8:	74a73623          	sd	a0,1868(a4) # 1000 <freep>
      return (void*)(p + 1);
 8bc:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8c0:	70e2                	ld	ra,56(sp)
 8c2:	7442                	ld	s0,48(sp)
 8c4:	74a2                	ld	s1,40(sp)
 8c6:	7902                	ld	s2,32(sp)
 8c8:	69e2                	ld	s3,24(sp)
 8ca:	6a42                	ld	s4,16(sp)
 8cc:	6aa2                	ld	s5,8(sp)
 8ce:	6b02                	ld	s6,0(sp)
 8d0:	6121                	add	sp,sp,64
 8d2:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8d4:	6398                	ld	a4,0(a5)
 8d6:	e118                	sd	a4,0(a0)
 8d8:	bff1                	j	8b4 <malloc+0x88>
  hp->s.size = nu;
 8da:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8de:	0541                	add	a0,a0,16
 8e0:	00000097          	auipc	ra,0x0
 8e4:	eca080e7          	jalr	-310(ra) # 7aa <free>
  return freep;
 8e8:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8ec:	d971                	beqz	a0,8c0 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ee:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8f0:	4798                	lw	a4,8(a5)
 8f2:	fa9775e3          	bgeu	a4,s1,89c <malloc+0x70>
    if(p == freep)
 8f6:	00093703          	ld	a4,0(s2)
 8fa:	853e                	mv	a0,a5
 8fc:	fef719e3          	bne	a4,a5,8ee <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 900:	8552                	mv	a0,s4
 902:	00000097          	auipc	ra,0x0
 906:	b72080e7          	jalr	-1166(ra) # 474 <sbrk>
  if(p == (char*)-1)
 90a:	fd5518e3          	bne	a0,s5,8da <malloc+0xae>
        return 0;
 90e:	4501                	li	a0,0
 910:	bf45                	j	8c0 <malloc+0x94>
