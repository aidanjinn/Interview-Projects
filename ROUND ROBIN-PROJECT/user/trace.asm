
user/_trace:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	712d                	add	sp,sp,-288
   2:	ee06                	sd	ra,280(sp)
   4:	ea22                	sd	s0,272(sp)
   6:	e626                	sd	s1,264(sp)
   8:	e24a                	sd	s2,256(sp)
   a:	1200                	add	s0,sp,288
   c:	892e                	mv	s2,a1
  int i;
  char *nargv[MAXARG];

  if(argc < 3 || (argv[1][0] < '0' || argv[1][0] > '9')){
   e:	4789                	li	a5,2
  10:	00a7dd63          	bge	a5,a0,2a <main+0x2a>
  14:	84aa                	mv	s1,a0
  16:	6588                	ld	a0,8(a1)
  18:	00054783          	lbu	a5,0(a0)
  1c:	fd07879b          	addw	a5,a5,-48
  20:	0ff7f793          	zext.b	a5,a5
  24:	4725                	li	a4,9
  26:	02f77263          	bgeu	a4,a5,4a <main+0x4a>
    fprintf(2, "Usage: %s mask command\n", argv[0]);
  2a:	00093603          	ld	a2,0(s2)
  2e:	00001597          	auipc	a1,0x1
  32:	8a258593          	add	a1,a1,-1886 # 8d0 <malloc+0xf0>
  36:	4509                	li	a0,2
  38:	00000097          	auipc	ra,0x0
  3c:	6c2080e7          	jalr	1730(ra) # 6fa <fprintf>
    exit(1);
  40:	4505                	li	a0,1
  42:	00000097          	auipc	ra,0x0
  46:	35e080e7          	jalr	862(ra) # 3a0 <exit>
  }

  if (trace(atoi(argv[1])) < 0) {
  4a:	00000097          	auipc	ra,0x0
  4e:	246080e7          	jalr	582(ra) # 290 <atoi>
  52:	00000097          	auipc	ra,0x0
  56:	3ee080e7          	jalr	1006(ra) # 440 <trace>
  5a:	04054363          	bltz	a0,a0 <main+0xa0>
  5e:	01090793          	add	a5,s2,16
  62:	ee040713          	add	a4,s0,-288
  66:	34f5                	addw	s1,s1,-3
  68:	02049693          	sll	a3,s1,0x20
  6c:	01d6d493          	srl	s1,a3,0x1d
  70:	94be                	add	s1,s1,a5
  72:	10090593          	add	a1,s2,256
    fprintf(2, "%s: trace failed\n", argv[0]);
    exit(1);
  }
  
  for(i = 2; i < argc && i < MAXARG; i++){
    nargv[i-2] = argv[i];
  76:	6394                	ld	a3,0(a5)
  78:	e314                	sd	a3,0(a4)
  for(i = 2; i < argc && i < MAXARG; i++){
  7a:	00978663          	beq	a5,s1,86 <main+0x86>
  7e:	07a1                	add	a5,a5,8
  80:	0721                	add	a4,a4,8
  82:	feb79ae3          	bne	a5,a1,76 <main+0x76>
  }
  exec(nargv[0], nargv);
  86:	ee040593          	add	a1,s0,-288
  8a:	ee043503          	ld	a0,-288(s0)
  8e:	00000097          	auipc	ra,0x0
  92:	34a080e7          	jalr	842(ra) # 3d8 <exec>
  exit(0);
  96:	4501                	li	a0,0
  98:	00000097          	auipc	ra,0x0
  9c:	308080e7          	jalr	776(ra) # 3a0 <exit>
    fprintf(2, "%s: trace failed\n", argv[0]);
  a0:	00093603          	ld	a2,0(s2)
  a4:	00001597          	auipc	a1,0x1
  a8:	84458593          	add	a1,a1,-1980 # 8e8 <malloc+0x108>
  ac:	4509                	li	a0,2
  ae:	00000097          	auipc	ra,0x0
  b2:	64c080e7          	jalr	1612(ra) # 6fa <fprintf>
    exit(1);
  b6:	4505                	li	a0,1
  b8:	00000097          	auipc	ra,0x0
  bc:	2e8080e7          	jalr	744(ra) # 3a0 <exit>

00000000000000c0 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  c0:	1141                	add	sp,sp,-16
  c2:	e406                	sd	ra,8(sp)
  c4:	e022                	sd	s0,0(sp)
  c6:	0800                	add	s0,sp,16
  extern int main();
  main();
  c8:	00000097          	auipc	ra,0x0
  cc:	f38080e7          	jalr	-200(ra) # 0 <main>
  exit(0);
  d0:	4501                	li	a0,0
  d2:	00000097          	auipc	ra,0x0
  d6:	2ce080e7          	jalr	718(ra) # 3a0 <exit>

00000000000000da <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  da:	1141                	add	sp,sp,-16
  dc:	e422                	sd	s0,8(sp)
  de:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  e0:	87aa                	mv	a5,a0
  e2:	0585                	add	a1,a1,1
  e4:	0785                	add	a5,a5,1
  e6:	fff5c703          	lbu	a4,-1(a1)
  ea:	fee78fa3          	sb	a4,-1(a5)
  ee:	fb75                	bnez	a4,e2 <strcpy+0x8>
    ;
  return os;
}
  f0:	6422                	ld	s0,8(sp)
  f2:	0141                	add	sp,sp,16
  f4:	8082                	ret

00000000000000f6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f6:	1141                	add	sp,sp,-16
  f8:	e422                	sd	s0,8(sp)
  fa:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  fc:	00054783          	lbu	a5,0(a0)
 100:	cb91                	beqz	a5,114 <strcmp+0x1e>
 102:	0005c703          	lbu	a4,0(a1)
 106:	00f71763          	bne	a4,a5,114 <strcmp+0x1e>
    p++, q++;
 10a:	0505                	add	a0,a0,1
 10c:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 10e:	00054783          	lbu	a5,0(a0)
 112:	fbe5                	bnez	a5,102 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 114:	0005c503          	lbu	a0,0(a1)
}
 118:	40a7853b          	subw	a0,a5,a0
 11c:	6422                	ld	s0,8(sp)
 11e:	0141                	add	sp,sp,16
 120:	8082                	ret

0000000000000122 <strlen>:

uint
strlen(const char *s)
{
 122:	1141                	add	sp,sp,-16
 124:	e422                	sd	s0,8(sp)
 126:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 128:	00054783          	lbu	a5,0(a0)
 12c:	cf91                	beqz	a5,148 <strlen+0x26>
 12e:	0505                	add	a0,a0,1
 130:	87aa                	mv	a5,a0
 132:	86be                	mv	a3,a5
 134:	0785                	add	a5,a5,1
 136:	fff7c703          	lbu	a4,-1(a5)
 13a:	ff65                	bnez	a4,132 <strlen+0x10>
 13c:	40a6853b          	subw	a0,a3,a0
 140:	2505                	addw	a0,a0,1
    ;
  return n;
}
 142:	6422                	ld	s0,8(sp)
 144:	0141                	add	sp,sp,16
 146:	8082                	ret
  for(n = 0; s[n]; n++)
 148:	4501                	li	a0,0
 14a:	bfe5                	j	142 <strlen+0x20>

000000000000014c <memset>:

void*
memset(void *dst, int c, uint n)
{
 14c:	1141                	add	sp,sp,-16
 14e:	e422                	sd	s0,8(sp)
 150:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 152:	ca19                	beqz	a2,168 <memset+0x1c>
 154:	87aa                	mv	a5,a0
 156:	1602                	sll	a2,a2,0x20
 158:	9201                	srl	a2,a2,0x20
 15a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 15e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 162:	0785                	add	a5,a5,1
 164:	fee79de3          	bne	a5,a4,15e <memset+0x12>
  }
  return dst;
}
 168:	6422                	ld	s0,8(sp)
 16a:	0141                	add	sp,sp,16
 16c:	8082                	ret

000000000000016e <strchr>:

char*
strchr(const char *s, char c)
{
 16e:	1141                	add	sp,sp,-16
 170:	e422                	sd	s0,8(sp)
 172:	0800                	add	s0,sp,16
  for(; *s; s++)
 174:	00054783          	lbu	a5,0(a0)
 178:	cb99                	beqz	a5,18e <strchr+0x20>
    if(*s == c)
 17a:	00f58763          	beq	a1,a5,188 <strchr+0x1a>
  for(; *s; s++)
 17e:	0505                	add	a0,a0,1
 180:	00054783          	lbu	a5,0(a0)
 184:	fbfd                	bnez	a5,17a <strchr+0xc>
      return (char*)s;
  return 0;
 186:	4501                	li	a0,0
}
 188:	6422                	ld	s0,8(sp)
 18a:	0141                	add	sp,sp,16
 18c:	8082                	ret
  return 0;
 18e:	4501                	li	a0,0
 190:	bfe5                	j	188 <strchr+0x1a>

0000000000000192 <strstr>:

char*
strstr(const char *str, const char *substr)
{
 192:	1141                	add	sp,sp,-16
 194:	e422                	sd	s0,8(sp)
 196:	0800                	add	s0,sp,16
  const char *a, *b = substr;
  if (*b == 0)
 198:	0005c803          	lbu	a6,0(a1)
 19c:	02080a63          	beqz	a6,1d0 <strstr+0x3e>
    return (char*)str;
  for( ; *str != 0; str += 1) {
 1a0:	00054783          	lbu	a5,0(a0)
 1a4:	e799                	bnez	a5,1b2 <strstr+0x20>
      if (*a++ != *b++)
        break;
    }
    b = substr;
  }
  return 0;
 1a6:	4501                	li	a0,0
 1a8:	a025                	j	1d0 <strstr+0x3e>
  for( ; *str != 0; str += 1) {
 1aa:	0505                	add	a0,a0,1
 1ac:	00054783          	lbu	a5,0(a0)
 1b0:	cf99                	beqz	a5,1ce <strstr+0x3c>
    if (*str != *b)
 1b2:	fef81ce3          	bne	a6,a5,1aa <strstr+0x18>
 1b6:	87ae                	mv	a5,a1
 1b8:	86aa                	mv	a3,a0
      if (*b == 0)
 1ba:	0007c703          	lbu	a4,0(a5)
 1be:	cb09                	beqz	a4,1d0 <strstr+0x3e>
      if (*a++ != *b++)
 1c0:	0685                	add	a3,a3,1
 1c2:	0785                	add	a5,a5,1
 1c4:	fff6c603          	lbu	a2,-1(a3)
 1c8:	fee609e3          	beq	a2,a4,1ba <strstr+0x28>
 1cc:	bff9                	j	1aa <strstr+0x18>
  return 0;
 1ce:	4501                	li	a0,0
}
 1d0:	6422                	ld	s0,8(sp)
 1d2:	0141                	add	sp,sp,16
 1d4:	8082                	ret

00000000000001d6 <gets>:

char*
gets(char *buf, int max)
{
 1d6:	711d                	add	sp,sp,-96
 1d8:	ec86                	sd	ra,88(sp)
 1da:	e8a2                	sd	s0,80(sp)
 1dc:	e4a6                	sd	s1,72(sp)
 1de:	e0ca                	sd	s2,64(sp)
 1e0:	fc4e                	sd	s3,56(sp)
 1e2:	f852                	sd	s4,48(sp)
 1e4:	f456                	sd	s5,40(sp)
 1e6:	f05a                	sd	s6,32(sp)
 1e8:	ec5e                	sd	s7,24(sp)
 1ea:	1080                	add	s0,sp,96
 1ec:	8baa                	mv	s7,a0
 1ee:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f0:	892a                	mv	s2,a0
 1f2:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1f4:	4aa9                	li	s5,10
 1f6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1f8:	89a6                	mv	s3,s1
 1fa:	2485                	addw	s1,s1,1
 1fc:	0344d863          	bge	s1,s4,22c <gets+0x56>
    cc = read(0, &c, 1);
 200:	4605                	li	a2,1
 202:	faf40593          	add	a1,s0,-81
 206:	4501                	li	a0,0
 208:	00000097          	auipc	ra,0x0
 20c:	1b0080e7          	jalr	432(ra) # 3b8 <read>
    if(cc < 1)
 210:	00a05e63          	blez	a0,22c <gets+0x56>
    buf[i++] = c;
 214:	faf44783          	lbu	a5,-81(s0)
 218:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 21c:	01578763          	beq	a5,s5,22a <gets+0x54>
 220:	0905                	add	s2,s2,1
 222:	fd679be3          	bne	a5,s6,1f8 <gets+0x22>
  for(i=0; i+1 < max; ){
 226:	89a6                	mv	s3,s1
 228:	a011                	j	22c <gets+0x56>
 22a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 22c:	99de                	add	s3,s3,s7
 22e:	00098023          	sb	zero,0(s3)
  return buf;
}
 232:	855e                	mv	a0,s7
 234:	60e6                	ld	ra,88(sp)
 236:	6446                	ld	s0,80(sp)
 238:	64a6                	ld	s1,72(sp)
 23a:	6906                	ld	s2,64(sp)
 23c:	79e2                	ld	s3,56(sp)
 23e:	7a42                	ld	s4,48(sp)
 240:	7aa2                	ld	s5,40(sp)
 242:	7b02                	ld	s6,32(sp)
 244:	6be2                	ld	s7,24(sp)
 246:	6125                	add	sp,sp,96
 248:	8082                	ret

000000000000024a <stat>:

int
stat(const char *n, struct stat *st)
{
 24a:	1101                	add	sp,sp,-32
 24c:	ec06                	sd	ra,24(sp)
 24e:	e822                	sd	s0,16(sp)
 250:	e426                	sd	s1,8(sp)
 252:	e04a                	sd	s2,0(sp)
 254:	1000                	add	s0,sp,32
 256:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 258:	4581                	li	a1,0
 25a:	00000097          	auipc	ra,0x0
 25e:	186080e7          	jalr	390(ra) # 3e0 <open>
  if(fd < 0)
 262:	02054563          	bltz	a0,28c <stat+0x42>
 266:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 268:	85ca                	mv	a1,s2
 26a:	00000097          	auipc	ra,0x0
 26e:	18e080e7          	jalr	398(ra) # 3f8 <fstat>
 272:	892a                	mv	s2,a0
  close(fd);
 274:	8526                	mv	a0,s1
 276:	00000097          	auipc	ra,0x0
 27a:	152080e7          	jalr	338(ra) # 3c8 <close>
  return r;
}
 27e:	854a                	mv	a0,s2
 280:	60e2                	ld	ra,24(sp)
 282:	6442                	ld	s0,16(sp)
 284:	64a2                	ld	s1,8(sp)
 286:	6902                	ld	s2,0(sp)
 288:	6105                	add	sp,sp,32
 28a:	8082                	ret
    return -1;
 28c:	597d                	li	s2,-1
 28e:	bfc5                	j	27e <stat+0x34>

0000000000000290 <atoi>:

int
atoi(const char *s)
{
 290:	1141                	add	sp,sp,-16
 292:	e422                	sd	s0,8(sp)
 294:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 296:	00054683          	lbu	a3,0(a0)
 29a:	fd06879b          	addw	a5,a3,-48
 29e:	0ff7f793          	zext.b	a5,a5
 2a2:	4625                	li	a2,9
 2a4:	02f66863          	bltu	a2,a5,2d4 <atoi+0x44>
 2a8:	872a                	mv	a4,a0
  n = 0;
 2aa:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2ac:	0705                	add	a4,a4,1
 2ae:	0025179b          	sllw	a5,a0,0x2
 2b2:	9fa9                	addw	a5,a5,a0
 2b4:	0017979b          	sllw	a5,a5,0x1
 2b8:	9fb5                	addw	a5,a5,a3
 2ba:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2be:	00074683          	lbu	a3,0(a4)
 2c2:	fd06879b          	addw	a5,a3,-48
 2c6:	0ff7f793          	zext.b	a5,a5
 2ca:	fef671e3          	bgeu	a2,a5,2ac <atoi+0x1c>
  return n;
}
 2ce:	6422                	ld	s0,8(sp)
 2d0:	0141                	add	sp,sp,16
 2d2:	8082                	ret
  n = 0;
 2d4:	4501                	li	a0,0
 2d6:	bfe5                	j	2ce <atoi+0x3e>

00000000000002d8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2d8:	1141                	add	sp,sp,-16
 2da:	e422                	sd	s0,8(sp)
 2dc:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2de:	02b57463          	bgeu	a0,a1,306 <memmove+0x2e>
    while(n-- > 0)
 2e2:	00c05f63          	blez	a2,300 <memmove+0x28>
 2e6:	1602                	sll	a2,a2,0x20
 2e8:	9201                	srl	a2,a2,0x20
 2ea:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2ee:	872a                	mv	a4,a0
      *dst++ = *src++;
 2f0:	0585                	add	a1,a1,1
 2f2:	0705                	add	a4,a4,1
 2f4:	fff5c683          	lbu	a3,-1(a1)
 2f8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2fc:	fee79ae3          	bne	a5,a4,2f0 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 300:	6422                	ld	s0,8(sp)
 302:	0141                	add	sp,sp,16
 304:	8082                	ret
    dst += n;
 306:	00c50733          	add	a4,a0,a2
    src += n;
 30a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 30c:	fec05ae3          	blez	a2,300 <memmove+0x28>
 310:	fff6079b          	addw	a5,a2,-1
 314:	1782                	sll	a5,a5,0x20
 316:	9381                	srl	a5,a5,0x20
 318:	fff7c793          	not	a5,a5
 31c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 31e:	15fd                	add	a1,a1,-1
 320:	177d                	add	a4,a4,-1
 322:	0005c683          	lbu	a3,0(a1)
 326:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 32a:	fee79ae3          	bne	a5,a4,31e <memmove+0x46>
 32e:	bfc9                	j	300 <memmove+0x28>

0000000000000330 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 330:	1141                	add	sp,sp,-16
 332:	e422                	sd	s0,8(sp)
 334:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 336:	ca05                	beqz	a2,366 <memcmp+0x36>
 338:	fff6069b          	addw	a3,a2,-1
 33c:	1682                	sll	a3,a3,0x20
 33e:	9281                	srl	a3,a3,0x20
 340:	0685                	add	a3,a3,1
 342:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 344:	00054783          	lbu	a5,0(a0)
 348:	0005c703          	lbu	a4,0(a1)
 34c:	00e79863          	bne	a5,a4,35c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 350:	0505                	add	a0,a0,1
    p2++;
 352:	0585                	add	a1,a1,1
  while (n-- > 0) {
 354:	fed518e3          	bne	a0,a3,344 <memcmp+0x14>
  }
  return 0;
 358:	4501                	li	a0,0
 35a:	a019                	j	360 <memcmp+0x30>
      return *p1 - *p2;
 35c:	40e7853b          	subw	a0,a5,a4
}
 360:	6422                	ld	s0,8(sp)
 362:	0141                	add	sp,sp,16
 364:	8082                	ret
  return 0;
 366:	4501                	li	a0,0
 368:	bfe5                	j	360 <memcmp+0x30>

000000000000036a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 36a:	1141                	add	sp,sp,-16
 36c:	e406                	sd	ra,8(sp)
 36e:	e022                	sd	s0,0(sp)
 370:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 372:	00000097          	auipc	ra,0x0
 376:	f66080e7          	jalr	-154(ra) # 2d8 <memmove>
}
 37a:	60a2                	ld	ra,8(sp)
 37c:	6402                	ld	s0,0(sp)
 37e:	0141                	add	sp,sp,16
 380:	8082                	ret

0000000000000382 <ugetpid>:

int
ugetpid(void)
{
 382:	1141                	add	sp,sp,-16
 384:	e422                	sd	s0,8(sp)
 386:	0800                	add	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 388:	040007b7          	lui	a5,0x4000
}
 38c:	17f5                	add	a5,a5,-3 # 3fffffd <base+0x3ffefed>
 38e:	07b2                	sll	a5,a5,0xc
 390:	4388                	lw	a0,0(a5)
 392:	6422                	ld	s0,8(sp)
 394:	0141                	add	sp,sp,16
 396:	8082                	ret

0000000000000398 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 398:	4885                	li	a7,1
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3a0:	4889                	li	a7,2
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3a8:	488d                	li	a7,3
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3b0:	4891                	li	a7,4
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <read>:
.global read
read:
 li a7, SYS_read
 3b8:	4895                	li	a7,5
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <write>:
.global write
write:
 li a7, SYS_write
 3c0:	48c1                	li	a7,16
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <close>:
.global close
close:
 li a7, SYS_close
 3c8:	48d5                	li	a7,21
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3d0:	4899                	li	a7,6
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3d8:	489d                	li	a7,7
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <open>:
.global open
open:
 li a7, SYS_open
 3e0:	48bd                	li	a7,15
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3e8:	48c5                	li	a7,17
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3f0:	48c9                	li	a7,18
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3f8:	48a1                	li	a7,8
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <link>:
.global link
link:
 li a7, SYS_link
 400:	48cd                	li	a7,19
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 408:	48d1                	li	a7,20
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 410:	48a5                	li	a7,9
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <dup>:
.global dup
dup:
 li a7, SYS_dup
 418:	48a9                	li	a7,10
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 420:	48ad                	li	a7,11
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 428:	48b1                	li	a7,12
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 430:	48b5                	li	a7,13
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 438:	48b9                	li	a7,14
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <trace>:
.global trace
trace:
 li a7, SYS_trace
 440:	48d9                	li	a7,22
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 448:	48dd                	li	a7,23
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 450:	48e1                	li	a7,24
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <setpriority>:
.global setpriority
setpriority:
 li a7, SYS_setpriority
 458:	48e5                	li	a7,25
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 460:	1101                	add	sp,sp,-32
 462:	ec06                	sd	ra,24(sp)
 464:	e822                	sd	s0,16(sp)
 466:	1000                	add	s0,sp,32
 468:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 46c:	4605                	li	a2,1
 46e:	fef40593          	add	a1,s0,-17
 472:	00000097          	auipc	ra,0x0
 476:	f4e080e7          	jalr	-178(ra) # 3c0 <write>
}
 47a:	60e2                	ld	ra,24(sp)
 47c:	6442                	ld	s0,16(sp)
 47e:	6105                	add	sp,sp,32
 480:	8082                	ret

0000000000000482 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 482:	7139                	add	sp,sp,-64
 484:	fc06                	sd	ra,56(sp)
 486:	f822                	sd	s0,48(sp)
 488:	f426                	sd	s1,40(sp)
 48a:	f04a                	sd	s2,32(sp)
 48c:	ec4e                	sd	s3,24(sp)
 48e:	0080                	add	s0,sp,64
 490:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 492:	c299                	beqz	a3,498 <printint+0x16>
 494:	0805c963          	bltz	a1,526 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 498:	2581                	sext.w	a1,a1
  neg = 0;
 49a:	4881                	li	a7,0
 49c:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 4a0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4a2:	2601                	sext.w	a2,a2
 4a4:	00000517          	auipc	a0,0x0
 4a8:	4bc50513          	add	a0,a0,1212 # 960 <digits>
 4ac:	883a                	mv	a6,a4
 4ae:	2705                	addw	a4,a4,1
 4b0:	02c5f7bb          	remuw	a5,a1,a2
 4b4:	1782                	sll	a5,a5,0x20
 4b6:	9381                	srl	a5,a5,0x20
 4b8:	97aa                	add	a5,a5,a0
 4ba:	0007c783          	lbu	a5,0(a5)
 4be:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4c2:	0005879b          	sext.w	a5,a1
 4c6:	02c5d5bb          	divuw	a1,a1,a2
 4ca:	0685                	add	a3,a3,1
 4cc:	fec7f0e3          	bgeu	a5,a2,4ac <printint+0x2a>
  if(neg)
 4d0:	00088c63          	beqz	a7,4e8 <printint+0x66>
    buf[i++] = '-';
 4d4:	fd070793          	add	a5,a4,-48
 4d8:	00878733          	add	a4,a5,s0
 4dc:	02d00793          	li	a5,45
 4e0:	fef70823          	sb	a5,-16(a4)
 4e4:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 4e8:	02e05863          	blez	a4,518 <printint+0x96>
 4ec:	fc040793          	add	a5,s0,-64
 4f0:	00e78933          	add	s2,a5,a4
 4f4:	fff78993          	add	s3,a5,-1
 4f8:	99ba                	add	s3,s3,a4
 4fa:	377d                	addw	a4,a4,-1
 4fc:	1702                	sll	a4,a4,0x20
 4fe:	9301                	srl	a4,a4,0x20
 500:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 504:	fff94583          	lbu	a1,-1(s2)
 508:	8526                	mv	a0,s1
 50a:	00000097          	auipc	ra,0x0
 50e:	f56080e7          	jalr	-170(ra) # 460 <putc>
  while(--i >= 0)
 512:	197d                	add	s2,s2,-1
 514:	ff3918e3          	bne	s2,s3,504 <printint+0x82>
}
 518:	70e2                	ld	ra,56(sp)
 51a:	7442                	ld	s0,48(sp)
 51c:	74a2                	ld	s1,40(sp)
 51e:	7902                	ld	s2,32(sp)
 520:	69e2                	ld	s3,24(sp)
 522:	6121                	add	sp,sp,64
 524:	8082                	ret
    x = -xx;
 526:	40b005bb          	negw	a1,a1
    neg = 1;
 52a:	4885                	li	a7,1
    x = -xx;
 52c:	bf85                	j	49c <printint+0x1a>

000000000000052e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 52e:	715d                	add	sp,sp,-80
 530:	e486                	sd	ra,72(sp)
 532:	e0a2                	sd	s0,64(sp)
 534:	fc26                	sd	s1,56(sp)
 536:	f84a                	sd	s2,48(sp)
 538:	f44e                	sd	s3,40(sp)
 53a:	f052                	sd	s4,32(sp)
 53c:	ec56                	sd	s5,24(sp)
 53e:	e85a                	sd	s6,16(sp)
 540:	e45e                	sd	s7,8(sp)
 542:	e062                	sd	s8,0(sp)
 544:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 546:	0005c903          	lbu	s2,0(a1)
 54a:	18090c63          	beqz	s2,6e2 <vprintf+0x1b4>
 54e:	8aaa                	mv	s5,a0
 550:	8bb2                	mv	s7,a2
 552:	00158493          	add	s1,a1,1
  state = 0;
 556:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 558:	02500a13          	li	s4,37
 55c:	4b55                	li	s6,21
 55e:	a839                	j	57c <vprintf+0x4e>
        putc(fd, c);
 560:	85ca                	mv	a1,s2
 562:	8556                	mv	a0,s5
 564:	00000097          	auipc	ra,0x0
 568:	efc080e7          	jalr	-260(ra) # 460 <putc>
 56c:	a019                	j	572 <vprintf+0x44>
    } else if(state == '%'){
 56e:	01498d63          	beq	s3,s4,588 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 572:	0485                	add	s1,s1,1
 574:	fff4c903          	lbu	s2,-1(s1)
 578:	16090563          	beqz	s2,6e2 <vprintf+0x1b4>
    if(state == 0){
 57c:	fe0999e3          	bnez	s3,56e <vprintf+0x40>
      if(c == '%'){
 580:	ff4910e3          	bne	s2,s4,560 <vprintf+0x32>
        state = '%';
 584:	89d2                	mv	s3,s4
 586:	b7f5                	j	572 <vprintf+0x44>
      if(c == 'd'){
 588:	13490263          	beq	s2,s4,6ac <vprintf+0x17e>
 58c:	f9d9079b          	addw	a5,s2,-99
 590:	0ff7f793          	zext.b	a5,a5
 594:	12fb6563          	bltu	s6,a5,6be <vprintf+0x190>
 598:	f9d9079b          	addw	a5,s2,-99
 59c:	0ff7f713          	zext.b	a4,a5
 5a0:	10eb6f63          	bltu	s6,a4,6be <vprintf+0x190>
 5a4:	00271793          	sll	a5,a4,0x2
 5a8:	00000717          	auipc	a4,0x0
 5ac:	36070713          	add	a4,a4,864 # 908 <malloc+0x128>
 5b0:	97ba                	add	a5,a5,a4
 5b2:	439c                	lw	a5,0(a5)
 5b4:	97ba                	add	a5,a5,a4
 5b6:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 5b8:	008b8913          	add	s2,s7,8
 5bc:	4685                	li	a3,1
 5be:	4629                	li	a2,10
 5c0:	000ba583          	lw	a1,0(s7)
 5c4:	8556                	mv	a0,s5
 5c6:	00000097          	auipc	ra,0x0
 5ca:	ebc080e7          	jalr	-324(ra) # 482 <printint>
 5ce:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5d0:	4981                	li	s3,0
 5d2:	b745                	j	572 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5d4:	008b8913          	add	s2,s7,8
 5d8:	4681                	li	a3,0
 5da:	4629                	li	a2,10
 5dc:	000ba583          	lw	a1,0(s7)
 5e0:	8556                	mv	a0,s5
 5e2:	00000097          	auipc	ra,0x0
 5e6:	ea0080e7          	jalr	-352(ra) # 482 <printint>
 5ea:	8bca                	mv	s7,s2
      state = 0;
 5ec:	4981                	li	s3,0
 5ee:	b751                	j	572 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 5f0:	008b8913          	add	s2,s7,8
 5f4:	4681                	li	a3,0
 5f6:	4641                	li	a2,16
 5f8:	000ba583          	lw	a1,0(s7)
 5fc:	8556                	mv	a0,s5
 5fe:	00000097          	auipc	ra,0x0
 602:	e84080e7          	jalr	-380(ra) # 482 <printint>
 606:	8bca                	mv	s7,s2
      state = 0;
 608:	4981                	li	s3,0
 60a:	b7a5                	j	572 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 60c:	008b8c13          	add	s8,s7,8
 610:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 614:	03000593          	li	a1,48
 618:	8556                	mv	a0,s5
 61a:	00000097          	auipc	ra,0x0
 61e:	e46080e7          	jalr	-442(ra) # 460 <putc>
  putc(fd, 'x');
 622:	07800593          	li	a1,120
 626:	8556                	mv	a0,s5
 628:	00000097          	auipc	ra,0x0
 62c:	e38080e7          	jalr	-456(ra) # 460 <putc>
 630:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 632:	00000b97          	auipc	s7,0x0
 636:	32eb8b93          	add	s7,s7,814 # 960 <digits>
 63a:	03c9d793          	srl	a5,s3,0x3c
 63e:	97de                	add	a5,a5,s7
 640:	0007c583          	lbu	a1,0(a5)
 644:	8556                	mv	a0,s5
 646:	00000097          	auipc	ra,0x0
 64a:	e1a080e7          	jalr	-486(ra) # 460 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 64e:	0992                	sll	s3,s3,0x4
 650:	397d                	addw	s2,s2,-1
 652:	fe0914e3          	bnez	s2,63a <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 656:	8be2                	mv	s7,s8
      state = 0;
 658:	4981                	li	s3,0
 65a:	bf21                	j	572 <vprintf+0x44>
        s = va_arg(ap, char*);
 65c:	008b8993          	add	s3,s7,8
 660:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 664:	02090163          	beqz	s2,686 <vprintf+0x158>
        while(*s != 0){
 668:	00094583          	lbu	a1,0(s2)
 66c:	c9a5                	beqz	a1,6dc <vprintf+0x1ae>
          putc(fd, *s);
 66e:	8556                	mv	a0,s5
 670:	00000097          	auipc	ra,0x0
 674:	df0080e7          	jalr	-528(ra) # 460 <putc>
          s++;
 678:	0905                	add	s2,s2,1
        while(*s != 0){
 67a:	00094583          	lbu	a1,0(s2)
 67e:	f9e5                	bnez	a1,66e <vprintf+0x140>
        s = va_arg(ap, char*);
 680:	8bce                	mv	s7,s3
      state = 0;
 682:	4981                	li	s3,0
 684:	b5fd                	j	572 <vprintf+0x44>
          s = "(null)";
 686:	00000917          	auipc	s2,0x0
 68a:	27a90913          	add	s2,s2,634 # 900 <malloc+0x120>
        while(*s != 0){
 68e:	02800593          	li	a1,40
 692:	bff1                	j	66e <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 694:	008b8913          	add	s2,s7,8
 698:	000bc583          	lbu	a1,0(s7)
 69c:	8556                	mv	a0,s5
 69e:	00000097          	auipc	ra,0x0
 6a2:	dc2080e7          	jalr	-574(ra) # 460 <putc>
 6a6:	8bca                	mv	s7,s2
      state = 0;
 6a8:	4981                	li	s3,0
 6aa:	b5e1                	j	572 <vprintf+0x44>
        putc(fd, c);
 6ac:	02500593          	li	a1,37
 6b0:	8556                	mv	a0,s5
 6b2:	00000097          	auipc	ra,0x0
 6b6:	dae080e7          	jalr	-594(ra) # 460 <putc>
      state = 0;
 6ba:	4981                	li	s3,0
 6bc:	bd5d                	j	572 <vprintf+0x44>
        putc(fd, '%');
 6be:	02500593          	li	a1,37
 6c2:	8556                	mv	a0,s5
 6c4:	00000097          	auipc	ra,0x0
 6c8:	d9c080e7          	jalr	-612(ra) # 460 <putc>
        putc(fd, c);
 6cc:	85ca                	mv	a1,s2
 6ce:	8556                	mv	a0,s5
 6d0:	00000097          	auipc	ra,0x0
 6d4:	d90080e7          	jalr	-624(ra) # 460 <putc>
      state = 0;
 6d8:	4981                	li	s3,0
 6da:	bd61                	j	572 <vprintf+0x44>
        s = va_arg(ap, char*);
 6dc:	8bce                	mv	s7,s3
      state = 0;
 6de:	4981                	li	s3,0
 6e0:	bd49                	j	572 <vprintf+0x44>
    }
  }
}
 6e2:	60a6                	ld	ra,72(sp)
 6e4:	6406                	ld	s0,64(sp)
 6e6:	74e2                	ld	s1,56(sp)
 6e8:	7942                	ld	s2,48(sp)
 6ea:	79a2                	ld	s3,40(sp)
 6ec:	7a02                	ld	s4,32(sp)
 6ee:	6ae2                	ld	s5,24(sp)
 6f0:	6b42                	ld	s6,16(sp)
 6f2:	6ba2                	ld	s7,8(sp)
 6f4:	6c02                	ld	s8,0(sp)
 6f6:	6161                	add	sp,sp,80
 6f8:	8082                	ret

00000000000006fa <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6fa:	715d                	add	sp,sp,-80
 6fc:	ec06                	sd	ra,24(sp)
 6fe:	e822                	sd	s0,16(sp)
 700:	1000                	add	s0,sp,32
 702:	e010                	sd	a2,0(s0)
 704:	e414                	sd	a3,8(s0)
 706:	e818                	sd	a4,16(s0)
 708:	ec1c                	sd	a5,24(s0)
 70a:	03043023          	sd	a6,32(s0)
 70e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 712:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 716:	8622                	mv	a2,s0
 718:	00000097          	auipc	ra,0x0
 71c:	e16080e7          	jalr	-490(ra) # 52e <vprintf>
}
 720:	60e2                	ld	ra,24(sp)
 722:	6442                	ld	s0,16(sp)
 724:	6161                	add	sp,sp,80
 726:	8082                	ret

0000000000000728 <printf>:

void
printf(const char *fmt, ...)
{
 728:	711d                	add	sp,sp,-96
 72a:	ec06                	sd	ra,24(sp)
 72c:	e822                	sd	s0,16(sp)
 72e:	1000                	add	s0,sp,32
 730:	e40c                	sd	a1,8(s0)
 732:	e810                	sd	a2,16(s0)
 734:	ec14                	sd	a3,24(s0)
 736:	f018                	sd	a4,32(s0)
 738:	f41c                	sd	a5,40(s0)
 73a:	03043823          	sd	a6,48(s0)
 73e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 742:	00840613          	add	a2,s0,8
 746:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 74a:	85aa                	mv	a1,a0
 74c:	4505                	li	a0,1
 74e:	00000097          	auipc	ra,0x0
 752:	de0080e7          	jalr	-544(ra) # 52e <vprintf>
}
 756:	60e2                	ld	ra,24(sp)
 758:	6442                	ld	s0,16(sp)
 75a:	6125                	add	sp,sp,96
 75c:	8082                	ret

000000000000075e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 75e:	1141                	add	sp,sp,-16
 760:	e422                	sd	s0,8(sp)
 762:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 764:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 768:	00001797          	auipc	a5,0x1
 76c:	8987b783          	ld	a5,-1896(a5) # 1000 <freep>
 770:	a02d                	j	79a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 772:	4618                	lw	a4,8(a2)
 774:	9f2d                	addw	a4,a4,a1
 776:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 77a:	6398                	ld	a4,0(a5)
 77c:	6310                	ld	a2,0(a4)
 77e:	a83d                	j	7bc <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 780:	ff852703          	lw	a4,-8(a0)
 784:	9f31                	addw	a4,a4,a2
 786:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 788:	ff053683          	ld	a3,-16(a0)
 78c:	a091                	j	7d0 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 78e:	6398                	ld	a4,0(a5)
 790:	00e7e463          	bltu	a5,a4,798 <free+0x3a>
 794:	00e6ea63          	bltu	a3,a4,7a8 <free+0x4a>
{
 798:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 79a:	fed7fae3          	bgeu	a5,a3,78e <free+0x30>
 79e:	6398                	ld	a4,0(a5)
 7a0:	00e6e463          	bltu	a3,a4,7a8 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a4:	fee7eae3          	bltu	a5,a4,798 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 7a8:	ff852583          	lw	a1,-8(a0)
 7ac:	6390                	ld	a2,0(a5)
 7ae:	02059813          	sll	a6,a1,0x20
 7b2:	01c85713          	srl	a4,a6,0x1c
 7b6:	9736                	add	a4,a4,a3
 7b8:	fae60de3          	beq	a2,a4,772 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 7bc:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7c0:	4790                	lw	a2,8(a5)
 7c2:	02061593          	sll	a1,a2,0x20
 7c6:	01c5d713          	srl	a4,a1,0x1c
 7ca:	973e                	add	a4,a4,a5
 7cc:	fae68ae3          	beq	a3,a4,780 <free+0x22>
    p->s.ptr = bp->s.ptr;
 7d0:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7d2:	00001717          	auipc	a4,0x1
 7d6:	82f73723          	sd	a5,-2002(a4) # 1000 <freep>
}
 7da:	6422                	ld	s0,8(sp)
 7dc:	0141                	add	sp,sp,16
 7de:	8082                	ret

00000000000007e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7e0:	7139                	add	sp,sp,-64
 7e2:	fc06                	sd	ra,56(sp)
 7e4:	f822                	sd	s0,48(sp)
 7e6:	f426                	sd	s1,40(sp)
 7e8:	f04a                	sd	s2,32(sp)
 7ea:	ec4e                	sd	s3,24(sp)
 7ec:	e852                	sd	s4,16(sp)
 7ee:	e456                	sd	s5,8(sp)
 7f0:	e05a                	sd	s6,0(sp)
 7f2:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f4:	02051493          	sll	s1,a0,0x20
 7f8:	9081                	srl	s1,s1,0x20
 7fa:	04bd                	add	s1,s1,15
 7fc:	8091                	srl	s1,s1,0x4
 7fe:	0014899b          	addw	s3,s1,1
 802:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 804:	00000517          	auipc	a0,0x0
 808:	7fc53503          	ld	a0,2044(a0) # 1000 <freep>
 80c:	c515                	beqz	a0,838 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 80e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 810:	4798                	lw	a4,8(a5)
 812:	02977f63          	bgeu	a4,s1,850 <malloc+0x70>
  if(nu < 4096)
 816:	8a4e                	mv	s4,s3
 818:	0009871b          	sext.w	a4,s3
 81c:	6685                	lui	a3,0x1
 81e:	00d77363          	bgeu	a4,a3,824 <malloc+0x44>
 822:	6a05                	lui	s4,0x1
 824:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 828:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 82c:	00000917          	auipc	s2,0x0
 830:	7d490913          	add	s2,s2,2004 # 1000 <freep>
  if(p == (char*)-1)
 834:	5afd                	li	s5,-1
 836:	a895                	j	8aa <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 838:	00000797          	auipc	a5,0x0
 83c:	7d878793          	add	a5,a5,2008 # 1010 <base>
 840:	00000717          	auipc	a4,0x0
 844:	7cf73023          	sd	a5,1984(a4) # 1000 <freep>
 848:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 84a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 84e:	b7e1                	j	816 <malloc+0x36>
      if(p->s.size == nunits)
 850:	02e48c63          	beq	s1,a4,888 <malloc+0xa8>
        p->s.size -= nunits;
 854:	4137073b          	subw	a4,a4,s3
 858:	c798                	sw	a4,8(a5)
        p += p->s.size;
 85a:	02071693          	sll	a3,a4,0x20
 85e:	01c6d713          	srl	a4,a3,0x1c
 862:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 864:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 868:	00000717          	auipc	a4,0x0
 86c:	78a73c23          	sd	a0,1944(a4) # 1000 <freep>
      return (void*)(p + 1);
 870:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 874:	70e2                	ld	ra,56(sp)
 876:	7442                	ld	s0,48(sp)
 878:	74a2                	ld	s1,40(sp)
 87a:	7902                	ld	s2,32(sp)
 87c:	69e2                	ld	s3,24(sp)
 87e:	6a42                	ld	s4,16(sp)
 880:	6aa2                	ld	s5,8(sp)
 882:	6b02                	ld	s6,0(sp)
 884:	6121                	add	sp,sp,64
 886:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 888:	6398                	ld	a4,0(a5)
 88a:	e118                	sd	a4,0(a0)
 88c:	bff1                	j	868 <malloc+0x88>
  hp->s.size = nu;
 88e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 892:	0541                	add	a0,a0,16
 894:	00000097          	auipc	ra,0x0
 898:	eca080e7          	jalr	-310(ra) # 75e <free>
  return freep;
 89c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8a0:	d971                	beqz	a0,874 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8a2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8a4:	4798                	lw	a4,8(a5)
 8a6:	fa9775e3          	bgeu	a4,s1,850 <malloc+0x70>
    if(p == freep)
 8aa:	00093703          	ld	a4,0(s2)
 8ae:	853e                	mv	a0,a5
 8b0:	fef719e3          	bne	a4,a5,8a2 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 8b4:	8552                	mv	a0,s4
 8b6:	00000097          	auipc	ra,0x0
 8ba:	b72080e7          	jalr	-1166(ra) # 428 <sbrk>
  if(p == (char*)-1)
 8be:	fd5518e3          	bne	a0,s5,88e <malloc+0xae>
        return 0;
 8c2:	4501                	li	a0,0
 8c4:	bf45                	j	874 <malloc+0x94>
