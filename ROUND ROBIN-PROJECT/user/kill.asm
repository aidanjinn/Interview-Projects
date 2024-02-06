
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
   0:	1101                	add	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	add	s0,sp,32
  int i;

  if(argc < 2){
   c:	4785                	li	a5,1
   e:	02a7dd63          	bge	a5,a0,48 <main+0x48>
  12:	00858493          	add	s1,a1,8
  16:	ffe5091b          	addw	s2,a0,-2
  1a:	02091793          	sll	a5,s2,0x20
  1e:	01d7d913          	srl	s2,a5,0x1d
  22:	05c1                	add	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "usage: kill pid...\n");
    exit(1);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  26:	6088                	ld	a0,0(s1)
  28:	00000097          	auipc	ra,0x0
  2c:	20c080e7          	jalr	524(ra) # 234 <atoi>
  30:	00000097          	auipc	ra,0x0
  34:	344080e7          	jalr	836(ra) # 374 <kill>
  for(i=1; i<argc; i++)
  38:	04a1                	add	s1,s1,8
  3a:	ff2496e3          	bne	s1,s2,26 <main+0x26>
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	304080e7          	jalr	772(ra) # 344 <exit>
    fprintf(2, "usage: kill pid...\n");
  48:	00001597          	auipc	a1,0x1
  4c:	82858593          	add	a1,a1,-2008 # 870 <malloc+0xec>
  50:	4509                	li	a0,2
  52:	00000097          	auipc	ra,0x0
  56:	64c080e7          	jalr	1612(ra) # 69e <fprintf>
    exit(1);
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	2e8080e7          	jalr	744(ra) # 344 <exit>

0000000000000064 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  64:	1141                	add	sp,sp,-16
  66:	e406                	sd	ra,8(sp)
  68:	e022                	sd	s0,0(sp)
  6a:	0800                	add	s0,sp,16
  extern int main();
  main();
  6c:	00000097          	auipc	ra,0x0
  70:	f94080e7          	jalr	-108(ra) # 0 <main>
  exit(0);
  74:	4501                	li	a0,0
  76:	00000097          	auipc	ra,0x0
  7a:	2ce080e7          	jalr	718(ra) # 344 <exit>

000000000000007e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  7e:	1141                	add	sp,sp,-16
  80:	e422                	sd	s0,8(sp)
  82:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  84:	87aa                	mv	a5,a0
  86:	0585                	add	a1,a1,1
  88:	0785                	add	a5,a5,1
  8a:	fff5c703          	lbu	a4,-1(a1)
  8e:	fee78fa3          	sb	a4,-1(a5)
  92:	fb75                	bnez	a4,86 <strcpy+0x8>
    ;
  return os;
}
  94:	6422                	ld	s0,8(sp)
  96:	0141                	add	sp,sp,16
  98:	8082                	ret

000000000000009a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  9a:	1141                	add	sp,sp,-16
  9c:	e422                	sd	s0,8(sp)
  9e:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  a0:	00054783          	lbu	a5,0(a0)
  a4:	cb91                	beqz	a5,b8 <strcmp+0x1e>
  a6:	0005c703          	lbu	a4,0(a1)
  aa:	00f71763          	bne	a4,a5,b8 <strcmp+0x1e>
    p++, q++;
  ae:	0505                	add	a0,a0,1
  b0:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  b2:	00054783          	lbu	a5,0(a0)
  b6:	fbe5                	bnez	a5,a6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  b8:	0005c503          	lbu	a0,0(a1)
}
  bc:	40a7853b          	subw	a0,a5,a0
  c0:	6422                	ld	s0,8(sp)
  c2:	0141                	add	sp,sp,16
  c4:	8082                	ret

00000000000000c6 <strlen>:

uint
strlen(const char *s)
{
  c6:	1141                	add	sp,sp,-16
  c8:	e422                	sd	s0,8(sp)
  ca:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  cc:	00054783          	lbu	a5,0(a0)
  d0:	cf91                	beqz	a5,ec <strlen+0x26>
  d2:	0505                	add	a0,a0,1
  d4:	87aa                	mv	a5,a0
  d6:	86be                	mv	a3,a5
  d8:	0785                	add	a5,a5,1
  da:	fff7c703          	lbu	a4,-1(a5)
  de:	ff65                	bnez	a4,d6 <strlen+0x10>
  e0:	40a6853b          	subw	a0,a3,a0
  e4:	2505                	addw	a0,a0,1
    ;
  return n;
}
  e6:	6422                	ld	s0,8(sp)
  e8:	0141                	add	sp,sp,16
  ea:	8082                	ret
  for(n = 0; s[n]; n++)
  ec:	4501                	li	a0,0
  ee:	bfe5                	j	e6 <strlen+0x20>

00000000000000f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f0:	1141                	add	sp,sp,-16
  f2:	e422                	sd	s0,8(sp)
  f4:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  f6:	ca19                	beqz	a2,10c <memset+0x1c>
  f8:	87aa                	mv	a5,a0
  fa:	1602                	sll	a2,a2,0x20
  fc:	9201                	srl	a2,a2,0x20
  fe:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 102:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 106:	0785                	add	a5,a5,1
 108:	fee79de3          	bne	a5,a4,102 <memset+0x12>
  }
  return dst;
}
 10c:	6422                	ld	s0,8(sp)
 10e:	0141                	add	sp,sp,16
 110:	8082                	ret

0000000000000112 <strchr>:

char*
strchr(const char *s, char c)
{
 112:	1141                	add	sp,sp,-16
 114:	e422                	sd	s0,8(sp)
 116:	0800                	add	s0,sp,16
  for(; *s; s++)
 118:	00054783          	lbu	a5,0(a0)
 11c:	cb99                	beqz	a5,132 <strchr+0x20>
    if(*s == c)
 11e:	00f58763          	beq	a1,a5,12c <strchr+0x1a>
  for(; *s; s++)
 122:	0505                	add	a0,a0,1
 124:	00054783          	lbu	a5,0(a0)
 128:	fbfd                	bnez	a5,11e <strchr+0xc>
      return (char*)s;
  return 0;
 12a:	4501                	li	a0,0
}
 12c:	6422                	ld	s0,8(sp)
 12e:	0141                	add	sp,sp,16
 130:	8082                	ret
  return 0;
 132:	4501                	li	a0,0
 134:	bfe5                	j	12c <strchr+0x1a>

0000000000000136 <strstr>:

char*
strstr(const char *str, const char *substr)
{
 136:	1141                	add	sp,sp,-16
 138:	e422                	sd	s0,8(sp)
 13a:	0800                	add	s0,sp,16
  const char *a, *b = substr;
  if (*b == 0)
 13c:	0005c803          	lbu	a6,0(a1)
 140:	02080a63          	beqz	a6,174 <strstr+0x3e>
    return (char*)str;
  for( ; *str != 0; str += 1) {
 144:	00054783          	lbu	a5,0(a0)
 148:	e799                	bnez	a5,156 <strstr+0x20>
      if (*a++ != *b++)
        break;
    }
    b = substr;
  }
  return 0;
 14a:	4501                	li	a0,0
 14c:	a025                	j	174 <strstr+0x3e>
  for( ; *str != 0; str += 1) {
 14e:	0505                	add	a0,a0,1
 150:	00054783          	lbu	a5,0(a0)
 154:	cf99                	beqz	a5,172 <strstr+0x3c>
    if (*str != *b)
 156:	fef81ce3          	bne	a6,a5,14e <strstr+0x18>
 15a:	87ae                	mv	a5,a1
 15c:	86aa                	mv	a3,a0
      if (*b == 0)
 15e:	0007c703          	lbu	a4,0(a5)
 162:	cb09                	beqz	a4,174 <strstr+0x3e>
      if (*a++ != *b++)
 164:	0685                	add	a3,a3,1
 166:	0785                	add	a5,a5,1
 168:	fff6c603          	lbu	a2,-1(a3)
 16c:	fee609e3          	beq	a2,a4,15e <strstr+0x28>
 170:	bff9                	j	14e <strstr+0x18>
  return 0;
 172:	4501                	li	a0,0
}
 174:	6422                	ld	s0,8(sp)
 176:	0141                	add	sp,sp,16
 178:	8082                	ret

000000000000017a <gets>:

char*
gets(char *buf, int max)
{
 17a:	711d                	add	sp,sp,-96
 17c:	ec86                	sd	ra,88(sp)
 17e:	e8a2                	sd	s0,80(sp)
 180:	e4a6                	sd	s1,72(sp)
 182:	e0ca                	sd	s2,64(sp)
 184:	fc4e                	sd	s3,56(sp)
 186:	f852                	sd	s4,48(sp)
 188:	f456                	sd	s5,40(sp)
 18a:	f05a                	sd	s6,32(sp)
 18c:	ec5e                	sd	s7,24(sp)
 18e:	1080                	add	s0,sp,96
 190:	8baa                	mv	s7,a0
 192:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 194:	892a                	mv	s2,a0
 196:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 198:	4aa9                	li	s5,10
 19a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 19c:	89a6                	mv	s3,s1
 19e:	2485                	addw	s1,s1,1
 1a0:	0344d863          	bge	s1,s4,1d0 <gets+0x56>
    cc = read(0, &c, 1);
 1a4:	4605                	li	a2,1
 1a6:	faf40593          	add	a1,s0,-81
 1aa:	4501                	li	a0,0
 1ac:	00000097          	auipc	ra,0x0
 1b0:	1b0080e7          	jalr	432(ra) # 35c <read>
    if(cc < 1)
 1b4:	00a05e63          	blez	a0,1d0 <gets+0x56>
    buf[i++] = c;
 1b8:	faf44783          	lbu	a5,-81(s0)
 1bc:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1c0:	01578763          	beq	a5,s5,1ce <gets+0x54>
 1c4:	0905                	add	s2,s2,1
 1c6:	fd679be3          	bne	a5,s6,19c <gets+0x22>
  for(i=0; i+1 < max; ){
 1ca:	89a6                	mv	s3,s1
 1cc:	a011                	j	1d0 <gets+0x56>
 1ce:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1d0:	99de                	add	s3,s3,s7
 1d2:	00098023          	sb	zero,0(s3)
  return buf;
}
 1d6:	855e                	mv	a0,s7
 1d8:	60e6                	ld	ra,88(sp)
 1da:	6446                	ld	s0,80(sp)
 1dc:	64a6                	ld	s1,72(sp)
 1de:	6906                	ld	s2,64(sp)
 1e0:	79e2                	ld	s3,56(sp)
 1e2:	7a42                	ld	s4,48(sp)
 1e4:	7aa2                	ld	s5,40(sp)
 1e6:	7b02                	ld	s6,32(sp)
 1e8:	6be2                	ld	s7,24(sp)
 1ea:	6125                	add	sp,sp,96
 1ec:	8082                	ret

00000000000001ee <stat>:

int
stat(const char *n, struct stat *st)
{
 1ee:	1101                	add	sp,sp,-32
 1f0:	ec06                	sd	ra,24(sp)
 1f2:	e822                	sd	s0,16(sp)
 1f4:	e426                	sd	s1,8(sp)
 1f6:	e04a                	sd	s2,0(sp)
 1f8:	1000                	add	s0,sp,32
 1fa:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1fc:	4581                	li	a1,0
 1fe:	00000097          	auipc	ra,0x0
 202:	186080e7          	jalr	390(ra) # 384 <open>
  if(fd < 0)
 206:	02054563          	bltz	a0,230 <stat+0x42>
 20a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 20c:	85ca                	mv	a1,s2
 20e:	00000097          	auipc	ra,0x0
 212:	18e080e7          	jalr	398(ra) # 39c <fstat>
 216:	892a                	mv	s2,a0
  close(fd);
 218:	8526                	mv	a0,s1
 21a:	00000097          	auipc	ra,0x0
 21e:	152080e7          	jalr	338(ra) # 36c <close>
  return r;
}
 222:	854a                	mv	a0,s2
 224:	60e2                	ld	ra,24(sp)
 226:	6442                	ld	s0,16(sp)
 228:	64a2                	ld	s1,8(sp)
 22a:	6902                	ld	s2,0(sp)
 22c:	6105                	add	sp,sp,32
 22e:	8082                	ret
    return -1;
 230:	597d                	li	s2,-1
 232:	bfc5                	j	222 <stat+0x34>

0000000000000234 <atoi>:

int
atoi(const char *s)
{
 234:	1141                	add	sp,sp,-16
 236:	e422                	sd	s0,8(sp)
 238:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 23a:	00054683          	lbu	a3,0(a0)
 23e:	fd06879b          	addw	a5,a3,-48
 242:	0ff7f793          	zext.b	a5,a5
 246:	4625                	li	a2,9
 248:	02f66863          	bltu	a2,a5,278 <atoi+0x44>
 24c:	872a                	mv	a4,a0
  n = 0;
 24e:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 250:	0705                	add	a4,a4,1
 252:	0025179b          	sllw	a5,a0,0x2
 256:	9fa9                	addw	a5,a5,a0
 258:	0017979b          	sllw	a5,a5,0x1
 25c:	9fb5                	addw	a5,a5,a3
 25e:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 262:	00074683          	lbu	a3,0(a4)
 266:	fd06879b          	addw	a5,a3,-48
 26a:	0ff7f793          	zext.b	a5,a5
 26e:	fef671e3          	bgeu	a2,a5,250 <atoi+0x1c>
  return n;
}
 272:	6422                	ld	s0,8(sp)
 274:	0141                	add	sp,sp,16
 276:	8082                	ret
  n = 0;
 278:	4501                	li	a0,0
 27a:	bfe5                	j	272 <atoi+0x3e>

000000000000027c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 27c:	1141                	add	sp,sp,-16
 27e:	e422                	sd	s0,8(sp)
 280:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 282:	02b57463          	bgeu	a0,a1,2aa <memmove+0x2e>
    while(n-- > 0)
 286:	00c05f63          	blez	a2,2a4 <memmove+0x28>
 28a:	1602                	sll	a2,a2,0x20
 28c:	9201                	srl	a2,a2,0x20
 28e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 292:	872a                	mv	a4,a0
      *dst++ = *src++;
 294:	0585                	add	a1,a1,1
 296:	0705                	add	a4,a4,1
 298:	fff5c683          	lbu	a3,-1(a1)
 29c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2a0:	fee79ae3          	bne	a5,a4,294 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2a4:	6422                	ld	s0,8(sp)
 2a6:	0141                	add	sp,sp,16
 2a8:	8082                	ret
    dst += n;
 2aa:	00c50733          	add	a4,a0,a2
    src += n;
 2ae:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2b0:	fec05ae3          	blez	a2,2a4 <memmove+0x28>
 2b4:	fff6079b          	addw	a5,a2,-1
 2b8:	1782                	sll	a5,a5,0x20
 2ba:	9381                	srl	a5,a5,0x20
 2bc:	fff7c793          	not	a5,a5
 2c0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2c2:	15fd                	add	a1,a1,-1
 2c4:	177d                	add	a4,a4,-1
 2c6:	0005c683          	lbu	a3,0(a1)
 2ca:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2ce:	fee79ae3          	bne	a5,a4,2c2 <memmove+0x46>
 2d2:	bfc9                	j	2a4 <memmove+0x28>

00000000000002d4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2d4:	1141                	add	sp,sp,-16
 2d6:	e422                	sd	s0,8(sp)
 2d8:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2da:	ca05                	beqz	a2,30a <memcmp+0x36>
 2dc:	fff6069b          	addw	a3,a2,-1
 2e0:	1682                	sll	a3,a3,0x20
 2e2:	9281                	srl	a3,a3,0x20
 2e4:	0685                	add	a3,a3,1
 2e6:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2e8:	00054783          	lbu	a5,0(a0)
 2ec:	0005c703          	lbu	a4,0(a1)
 2f0:	00e79863          	bne	a5,a4,300 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2f4:	0505                	add	a0,a0,1
    p2++;
 2f6:	0585                	add	a1,a1,1
  while (n-- > 0) {
 2f8:	fed518e3          	bne	a0,a3,2e8 <memcmp+0x14>
  }
  return 0;
 2fc:	4501                	li	a0,0
 2fe:	a019                	j	304 <memcmp+0x30>
      return *p1 - *p2;
 300:	40e7853b          	subw	a0,a5,a4
}
 304:	6422                	ld	s0,8(sp)
 306:	0141                	add	sp,sp,16
 308:	8082                	ret
  return 0;
 30a:	4501                	li	a0,0
 30c:	bfe5                	j	304 <memcmp+0x30>

000000000000030e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 30e:	1141                	add	sp,sp,-16
 310:	e406                	sd	ra,8(sp)
 312:	e022                	sd	s0,0(sp)
 314:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 316:	00000097          	auipc	ra,0x0
 31a:	f66080e7          	jalr	-154(ra) # 27c <memmove>
}
 31e:	60a2                	ld	ra,8(sp)
 320:	6402                	ld	s0,0(sp)
 322:	0141                	add	sp,sp,16
 324:	8082                	ret

0000000000000326 <ugetpid>:

int
ugetpid(void)
{
 326:	1141                	add	sp,sp,-16
 328:	e422                	sd	s0,8(sp)
 32a:	0800                	add	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 32c:	040007b7          	lui	a5,0x4000
}
 330:	17f5                	add	a5,a5,-3 # 3fffffd <base+0x3ffefed>
 332:	07b2                	sll	a5,a5,0xc
 334:	4388                	lw	a0,0(a5)
 336:	6422                	ld	s0,8(sp)
 338:	0141                	add	sp,sp,16
 33a:	8082                	ret

000000000000033c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 33c:	4885                	li	a7,1
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <exit>:
.global exit
exit:
 li a7, SYS_exit
 344:	4889                	li	a7,2
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <wait>:
.global wait
wait:
 li a7, SYS_wait
 34c:	488d                	li	a7,3
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 354:	4891                	li	a7,4
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <read>:
.global read
read:
 li a7, SYS_read
 35c:	4895                	li	a7,5
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <write>:
.global write
write:
 li a7, SYS_write
 364:	48c1                	li	a7,16
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <close>:
.global close
close:
 li a7, SYS_close
 36c:	48d5                	li	a7,21
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <kill>:
.global kill
kill:
 li a7, SYS_kill
 374:	4899                	li	a7,6
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <exec>:
.global exec
exec:
 li a7, SYS_exec
 37c:	489d                	li	a7,7
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <open>:
.global open
open:
 li a7, SYS_open
 384:	48bd                	li	a7,15
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 38c:	48c5                	li	a7,17
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 394:	48c9                	li	a7,18
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 39c:	48a1                	li	a7,8
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <link>:
.global link
link:
 li a7, SYS_link
 3a4:	48cd                	li	a7,19
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3ac:	48d1                	li	a7,20
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3b4:	48a5                	li	a7,9
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <dup>:
.global dup
dup:
 li a7, SYS_dup
 3bc:	48a9                	li	a7,10
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3c4:	48ad                	li	a7,11
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3cc:	48b1                	li	a7,12
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3d4:	48b5                	li	a7,13
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3dc:	48b9                	li	a7,14
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <trace>:
.global trace
trace:
 li a7, SYS_trace
 3e4:	48d9                	li	a7,22
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 3ec:	48dd                	li	a7,23
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 3f4:	48e1                	li	a7,24
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <setpriority>:
.global setpriority
setpriority:
 li a7, SYS_setpriority
 3fc:	48e5                	li	a7,25
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 404:	1101                	add	sp,sp,-32
 406:	ec06                	sd	ra,24(sp)
 408:	e822                	sd	s0,16(sp)
 40a:	1000                	add	s0,sp,32
 40c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 410:	4605                	li	a2,1
 412:	fef40593          	add	a1,s0,-17
 416:	00000097          	auipc	ra,0x0
 41a:	f4e080e7          	jalr	-178(ra) # 364 <write>
}
 41e:	60e2                	ld	ra,24(sp)
 420:	6442                	ld	s0,16(sp)
 422:	6105                	add	sp,sp,32
 424:	8082                	ret

0000000000000426 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 426:	7139                	add	sp,sp,-64
 428:	fc06                	sd	ra,56(sp)
 42a:	f822                	sd	s0,48(sp)
 42c:	f426                	sd	s1,40(sp)
 42e:	f04a                	sd	s2,32(sp)
 430:	ec4e                	sd	s3,24(sp)
 432:	0080                	add	s0,sp,64
 434:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 436:	c299                	beqz	a3,43c <printint+0x16>
 438:	0805c963          	bltz	a1,4ca <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 43c:	2581                	sext.w	a1,a1
  neg = 0;
 43e:	4881                	li	a7,0
 440:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 444:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 446:	2601                	sext.w	a2,a2
 448:	00000517          	auipc	a0,0x0
 44c:	4a050513          	add	a0,a0,1184 # 8e8 <digits>
 450:	883a                	mv	a6,a4
 452:	2705                	addw	a4,a4,1
 454:	02c5f7bb          	remuw	a5,a1,a2
 458:	1782                	sll	a5,a5,0x20
 45a:	9381                	srl	a5,a5,0x20
 45c:	97aa                	add	a5,a5,a0
 45e:	0007c783          	lbu	a5,0(a5)
 462:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 466:	0005879b          	sext.w	a5,a1
 46a:	02c5d5bb          	divuw	a1,a1,a2
 46e:	0685                	add	a3,a3,1
 470:	fec7f0e3          	bgeu	a5,a2,450 <printint+0x2a>
  if(neg)
 474:	00088c63          	beqz	a7,48c <printint+0x66>
    buf[i++] = '-';
 478:	fd070793          	add	a5,a4,-48
 47c:	00878733          	add	a4,a5,s0
 480:	02d00793          	li	a5,45
 484:	fef70823          	sb	a5,-16(a4)
 488:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 48c:	02e05863          	blez	a4,4bc <printint+0x96>
 490:	fc040793          	add	a5,s0,-64
 494:	00e78933          	add	s2,a5,a4
 498:	fff78993          	add	s3,a5,-1
 49c:	99ba                	add	s3,s3,a4
 49e:	377d                	addw	a4,a4,-1
 4a0:	1702                	sll	a4,a4,0x20
 4a2:	9301                	srl	a4,a4,0x20
 4a4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4a8:	fff94583          	lbu	a1,-1(s2)
 4ac:	8526                	mv	a0,s1
 4ae:	00000097          	auipc	ra,0x0
 4b2:	f56080e7          	jalr	-170(ra) # 404 <putc>
  while(--i >= 0)
 4b6:	197d                	add	s2,s2,-1
 4b8:	ff3918e3          	bne	s2,s3,4a8 <printint+0x82>
}
 4bc:	70e2                	ld	ra,56(sp)
 4be:	7442                	ld	s0,48(sp)
 4c0:	74a2                	ld	s1,40(sp)
 4c2:	7902                	ld	s2,32(sp)
 4c4:	69e2                	ld	s3,24(sp)
 4c6:	6121                	add	sp,sp,64
 4c8:	8082                	ret
    x = -xx;
 4ca:	40b005bb          	negw	a1,a1
    neg = 1;
 4ce:	4885                	li	a7,1
    x = -xx;
 4d0:	bf85                	j	440 <printint+0x1a>

00000000000004d2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4d2:	715d                	add	sp,sp,-80
 4d4:	e486                	sd	ra,72(sp)
 4d6:	e0a2                	sd	s0,64(sp)
 4d8:	fc26                	sd	s1,56(sp)
 4da:	f84a                	sd	s2,48(sp)
 4dc:	f44e                	sd	s3,40(sp)
 4de:	f052                	sd	s4,32(sp)
 4e0:	ec56                	sd	s5,24(sp)
 4e2:	e85a                	sd	s6,16(sp)
 4e4:	e45e                	sd	s7,8(sp)
 4e6:	e062                	sd	s8,0(sp)
 4e8:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4ea:	0005c903          	lbu	s2,0(a1)
 4ee:	18090c63          	beqz	s2,686 <vprintf+0x1b4>
 4f2:	8aaa                	mv	s5,a0
 4f4:	8bb2                	mv	s7,a2
 4f6:	00158493          	add	s1,a1,1
  state = 0;
 4fa:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4fc:	02500a13          	li	s4,37
 500:	4b55                	li	s6,21
 502:	a839                	j	520 <vprintf+0x4e>
        putc(fd, c);
 504:	85ca                	mv	a1,s2
 506:	8556                	mv	a0,s5
 508:	00000097          	auipc	ra,0x0
 50c:	efc080e7          	jalr	-260(ra) # 404 <putc>
 510:	a019                	j	516 <vprintf+0x44>
    } else if(state == '%'){
 512:	01498d63          	beq	s3,s4,52c <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 516:	0485                	add	s1,s1,1
 518:	fff4c903          	lbu	s2,-1(s1)
 51c:	16090563          	beqz	s2,686 <vprintf+0x1b4>
    if(state == 0){
 520:	fe0999e3          	bnez	s3,512 <vprintf+0x40>
      if(c == '%'){
 524:	ff4910e3          	bne	s2,s4,504 <vprintf+0x32>
        state = '%';
 528:	89d2                	mv	s3,s4
 52a:	b7f5                	j	516 <vprintf+0x44>
      if(c == 'd'){
 52c:	13490263          	beq	s2,s4,650 <vprintf+0x17e>
 530:	f9d9079b          	addw	a5,s2,-99
 534:	0ff7f793          	zext.b	a5,a5
 538:	12fb6563          	bltu	s6,a5,662 <vprintf+0x190>
 53c:	f9d9079b          	addw	a5,s2,-99
 540:	0ff7f713          	zext.b	a4,a5
 544:	10eb6f63          	bltu	s6,a4,662 <vprintf+0x190>
 548:	00271793          	sll	a5,a4,0x2
 54c:	00000717          	auipc	a4,0x0
 550:	34470713          	add	a4,a4,836 # 890 <malloc+0x10c>
 554:	97ba                	add	a5,a5,a4
 556:	439c                	lw	a5,0(a5)
 558:	97ba                	add	a5,a5,a4
 55a:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 55c:	008b8913          	add	s2,s7,8
 560:	4685                	li	a3,1
 562:	4629                	li	a2,10
 564:	000ba583          	lw	a1,0(s7)
 568:	8556                	mv	a0,s5
 56a:	00000097          	auipc	ra,0x0
 56e:	ebc080e7          	jalr	-324(ra) # 426 <printint>
 572:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 574:	4981                	li	s3,0
 576:	b745                	j	516 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 578:	008b8913          	add	s2,s7,8
 57c:	4681                	li	a3,0
 57e:	4629                	li	a2,10
 580:	000ba583          	lw	a1,0(s7)
 584:	8556                	mv	a0,s5
 586:	00000097          	auipc	ra,0x0
 58a:	ea0080e7          	jalr	-352(ra) # 426 <printint>
 58e:	8bca                	mv	s7,s2
      state = 0;
 590:	4981                	li	s3,0
 592:	b751                	j	516 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 594:	008b8913          	add	s2,s7,8
 598:	4681                	li	a3,0
 59a:	4641                	li	a2,16
 59c:	000ba583          	lw	a1,0(s7)
 5a0:	8556                	mv	a0,s5
 5a2:	00000097          	auipc	ra,0x0
 5a6:	e84080e7          	jalr	-380(ra) # 426 <printint>
 5aa:	8bca                	mv	s7,s2
      state = 0;
 5ac:	4981                	li	s3,0
 5ae:	b7a5                	j	516 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 5b0:	008b8c13          	add	s8,s7,8
 5b4:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 5b8:	03000593          	li	a1,48
 5bc:	8556                	mv	a0,s5
 5be:	00000097          	auipc	ra,0x0
 5c2:	e46080e7          	jalr	-442(ra) # 404 <putc>
  putc(fd, 'x');
 5c6:	07800593          	li	a1,120
 5ca:	8556                	mv	a0,s5
 5cc:	00000097          	auipc	ra,0x0
 5d0:	e38080e7          	jalr	-456(ra) # 404 <putc>
 5d4:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5d6:	00000b97          	auipc	s7,0x0
 5da:	312b8b93          	add	s7,s7,786 # 8e8 <digits>
 5de:	03c9d793          	srl	a5,s3,0x3c
 5e2:	97de                	add	a5,a5,s7
 5e4:	0007c583          	lbu	a1,0(a5)
 5e8:	8556                	mv	a0,s5
 5ea:	00000097          	auipc	ra,0x0
 5ee:	e1a080e7          	jalr	-486(ra) # 404 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5f2:	0992                	sll	s3,s3,0x4
 5f4:	397d                	addw	s2,s2,-1
 5f6:	fe0914e3          	bnez	s2,5de <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 5fa:	8be2                	mv	s7,s8
      state = 0;
 5fc:	4981                	li	s3,0
 5fe:	bf21                	j	516 <vprintf+0x44>
        s = va_arg(ap, char*);
 600:	008b8993          	add	s3,s7,8
 604:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 608:	02090163          	beqz	s2,62a <vprintf+0x158>
        while(*s != 0){
 60c:	00094583          	lbu	a1,0(s2)
 610:	c9a5                	beqz	a1,680 <vprintf+0x1ae>
          putc(fd, *s);
 612:	8556                	mv	a0,s5
 614:	00000097          	auipc	ra,0x0
 618:	df0080e7          	jalr	-528(ra) # 404 <putc>
          s++;
 61c:	0905                	add	s2,s2,1
        while(*s != 0){
 61e:	00094583          	lbu	a1,0(s2)
 622:	f9e5                	bnez	a1,612 <vprintf+0x140>
        s = va_arg(ap, char*);
 624:	8bce                	mv	s7,s3
      state = 0;
 626:	4981                	li	s3,0
 628:	b5fd                	j	516 <vprintf+0x44>
          s = "(null)";
 62a:	00000917          	auipc	s2,0x0
 62e:	25e90913          	add	s2,s2,606 # 888 <malloc+0x104>
        while(*s != 0){
 632:	02800593          	li	a1,40
 636:	bff1                	j	612 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 638:	008b8913          	add	s2,s7,8
 63c:	000bc583          	lbu	a1,0(s7)
 640:	8556                	mv	a0,s5
 642:	00000097          	auipc	ra,0x0
 646:	dc2080e7          	jalr	-574(ra) # 404 <putc>
 64a:	8bca                	mv	s7,s2
      state = 0;
 64c:	4981                	li	s3,0
 64e:	b5e1                	j	516 <vprintf+0x44>
        putc(fd, c);
 650:	02500593          	li	a1,37
 654:	8556                	mv	a0,s5
 656:	00000097          	auipc	ra,0x0
 65a:	dae080e7          	jalr	-594(ra) # 404 <putc>
      state = 0;
 65e:	4981                	li	s3,0
 660:	bd5d                	j	516 <vprintf+0x44>
        putc(fd, '%');
 662:	02500593          	li	a1,37
 666:	8556                	mv	a0,s5
 668:	00000097          	auipc	ra,0x0
 66c:	d9c080e7          	jalr	-612(ra) # 404 <putc>
        putc(fd, c);
 670:	85ca                	mv	a1,s2
 672:	8556                	mv	a0,s5
 674:	00000097          	auipc	ra,0x0
 678:	d90080e7          	jalr	-624(ra) # 404 <putc>
      state = 0;
 67c:	4981                	li	s3,0
 67e:	bd61                	j	516 <vprintf+0x44>
        s = va_arg(ap, char*);
 680:	8bce                	mv	s7,s3
      state = 0;
 682:	4981                	li	s3,0
 684:	bd49                	j	516 <vprintf+0x44>
    }
  }
}
 686:	60a6                	ld	ra,72(sp)
 688:	6406                	ld	s0,64(sp)
 68a:	74e2                	ld	s1,56(sp)
 68c:	7942                	ld	s2,48(sp)
 68e:	79a2                	ld	s3,40(sp)
 690:	7a02                	ld	s4,32(sp)
 692:	6ae2                	ld	s5,24(sp)
 694:	6b42                	ld	s6,16(sp)
 696:	6ba2                	ld	s7,8(sp)
 698:	6c02                	ld	s8,0(sp)
 69a:	6161                	add	sp,sp,80
 69c:	8082                	ret

000000000000069e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 69e:	715d                	add	sp,sp,-80
 6a0:	ec06                	sd	ra,24(sp)
 6a2:	e822                	sd	s0,16(sp)
 6a4:	1000                	add	s0,sp,32
 6a6:	e010                	sd	a2,0(s0)
 6a8:	e414                	sd	a3,8(s0)
 6aa:	e818                	sd	a4,16(s0)
 6ac:	ec1c                	sd	a5,24(s0)
 6ae:	03043023          	sd	a6,32(s0)
 6b2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6b6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6ba:	8622                	mv	a2,s0
 6bc:	00000097          	auipc	ra,0x0
 6c0:	e16080e7          	jalr	-490(ra) # 4d2 <vprintf>
}
 6c4:	60e2                	ld	ra,24(sp)
 6c6:	6442                	ld	s0,16(sp)
 6c8:	6161                	add	sp,sp,80
 6ca:	8082                	ret

00000000000006cc <printf>:

void
printf(const char *fmt, ...)
{
 6cc:	711d                	add	sp,sp,-96
 6ce:	ec06                	sd	ra,24(sp)
 6d0:	e822                	sd	s0,16(sp)
 6d2:	1000                	add	s0,sp,32
 6d4:	e40c                	sd	a1,8(s0)
 6d6:	e810                	sd	a2,16(s0)
 6d8:	ec14                	sd	a3,24(s0)
 6da:	f018                	sd	a4,32(s0)
 6dc:	f41c                	sd	a5,40(s0)
 6de:	03043823          	sd	a6,48(s0)
 6e2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6e6:	00840613          	add	a2,s0,8
 6ea:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6ee:	85aa                	mv	a1,a0
 6f0:	4505                	li	a0,1
 6f2:	00000097          	auipc	ra,0x0
 6f6:	de0080e7          	jalr	-544(ra) # 4d2 <vprintf>
}
 6fa:	60e2                	ld	ra,24(sp)
 6fc:	6442                	ld	s0,16(sp)
 6fe:	6125                	add	sp,sp,96
 700:	8082                	ret

0000000000000702 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 702:	1141                	add	sp,sp,-16
 704:	e422                	sd	s0,8(sp)
 706:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 708:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 70c:	00001797          	auipc	a5,0x1
 710:	8f47b783          	ld	a5,-1804(a5) # 1000 <freep>
 714:	a02d                	j	73e <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 716:	4618                	lw	a4,8(a2)
 718:	9f2d                	addw	a4,a4,a1
 71a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 71e:	6398                	ld	a4,0(a5)
 720:	6310                	ld	a2,0(a4)
 722:	a83d                	j	760 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 724:	ff852703          	lw	a4,-8(a0)
 728:	9f31                	addw	a4,a4,a2
 72a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 72c:	ff053683          	ld	a3,-16(a0)
 730:	a091                	j	774 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 732:	6398                	ld	a4,0(a5)
 734:	00e7e463          	bltu	a5,a4,73c <free+0x3a>
 738:	00e6ea63          	bltu	a3,a4,74c <free+0x4a>
{
 73c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 73e:	fed7fae3          	bgeu	a5,a3,732 <free+0x30>
 742:	6398                	ld	a4,0(a5)
 744:	00e6e463          	bltu	a3,a4,74c <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 748:	fee7eae3          	bltu	a5,a4,73c <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 74c:	ff852583          	lw	a1,-8(a0)
 750:	6390                	ld	a2,0(a5)
 752:	02059813          	sll	a6,a1,0x20
 756:	01c85713          	srl	a4,a6,0x1c
 75a:	9736                	add	a4,a4,a3
 75c:	fae60de3          	beq	a2,a4,716 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 760:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 764:	4790                	lw	a2,8(a5)
 766:	02061593          	sll	a1,a2,0x20
 76a:	01c5d713          	srl	a4,a1,0x1c
 76e:	973e                	add	a4,a4,a5
 770:	fae68ae3          	beq	a3,a4,724 <free+0x22>
    p->s.ptr = bp->s.ptr;
 774:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 776:	00001717          	auipc	a4,0x1
 77a:	88f73523          	sd	a5,-1910(a4) # 1000 <freep>
}
 77e:	6422                	ld	s0,8(sp)
 780:	0141                	add	sp,sp,16
 782:	8082                	ret

0000000000000784 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 784:	7139                	add	sp,sp,-64
 786:	fc06                	sd	ra,56(sp)
 788:	f822                	sd	s0,48(sp)
 78a:	f426                	sd	s1,40(sp)
 78c:	f04a                	sd	s2,32(sp)
 78e:	ec4e                	sd	s3,24(sp)
 790:	e852                	sd	s4,16(sp)
 792:	e456                	sd	s5,8(sp)
 794:	e05a                	sd	s6,0(sp)
 796:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 798:	02051493          	sll	s1,a0,0x20
 79c:	9081                	srl	s1,s1,0x20
 79e:	04bd                	add	s1,s1,15
 7a0:	8091                	srl	s1,s1,0x4
 7a2:	0014899b          	addw	s3,s1,1
 7a6:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 7a8:	00001517          	auipc	a0,0x1
 7ac:	85853503          	ld	a0,-1960(a0) # 1000 <freep>
 7b0:	c515                	beqz	a0,7dc <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7b4:	4798                	lw	a4,8(a5)
 7b6:	02977f63          	bgeu	a4,s1,7f4 <malloc+0x70>
  if(nu < 4096)
 7ba:	8a4e                	mv	s4,s3
 7bc:	0009871b          	sext.w	a4,s3
 7c0:	6685                	lui	a3,0x1
 7c2:	00d77363          	bgeu	a4,a3,7c8 <malloc+0x44>
 7c6:	6a05                	lui	s4,0x1
 7c8:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7cc:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7d0:	00001917          	auipc	s2,0x1
 7d4:	83090913          	add	s2,s2,-2000 # 1000 <freep>
  if(p == (char*)-1)
 7d8:	5afd                	li	s5,-1
 7da:	a895                	j	84e <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 7dc:	00001797          	auipc	a5,0x1
 7e0:	83478793          	add	a5,a5,-1996 # 1010 <base>
 7e4:	00001717          	auipc	a4,0x1
 7e8:	80f73e23          	sd	a5,-2020(a4) # 1000 <freep>
 7ec:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7ee:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7f2:	b7e1                	j	7ba <malloc+0x36>
      if(p->s.size == nunits)
 7f4:	02e48c63          	beq	s1,a4,82c <malloc+0xa8>
        p->s.size -= nunits;
 7f8:	4137073b          	subw	a4,a4,s3
 7fc:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7fe:	02071693          	sll	a3,a4,0x20
 802:	01c6d713          	srl	a4,a3,0x1c
 806:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 808:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 80c:	00000717          	auipc	a4,0x0
 810:	7ea73a23          	sd	a0,2036(a4) # 1000 <freep>
      return (void*)(p + 1);
 814:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 818:	70e2                	ld	ra,56(sp)
 81a:	7442                	ld	s0,48(sp)
 81c:	74a2                	ld	s1,40(sp)
 81e:	7902                	ld	s2,32(sp)
 820:	69e2                	ld	s3,24(sp)
 822:	6a42                	ld	s4,16(sp)
 824:	6aa2                	ld	s5,8(sp)
 826:	6b02                	ld	s6,0(sp)
 828:	6121                	add	sp,sp,64
 82a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 82c:	6398                	ld	a4,0(a5)
 82e:	e118                	sd	a4,0(a0)
 830:	bff1                	j	80c <malloc+0x88>
  hp->s.size = nu;
 832:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 836:	0541                	add	a0,a0,16
 838:	00000097          	auipc	ra,0x0
 83c:	eca080e7          	jalr	-310(ra) # 702 <free>
  return freep;
 840:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 844:	d971                	beqz	a0,818 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 846:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 848:	4798                	lw	a4,8(a5)
 84a:	fa9775e3          	bgeu	a4,s1,7f4 <malloc+0x70>
    if(p == freep)
 84e:	00093703          	ld	a4,0(s2)
 852:	853e                	mv	a0,a5
 854:	fef719e3          	bne	a4,a5,846 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 858:	8552                	mv	a0,s4
 85a:	00000097          	auipc	ra,0x0
 85e:	b72080e7          	jalr	-1166(ra) # 3cc <sbrk>
  if(p == (char*)-1)
 862:	fd5518e3          	bne	a0,s5,832 <malloc+0xae>
        return 0;
 866:	4501                	li	a0,0
 868:	bf45                	j	818 <malloc+0x94>
