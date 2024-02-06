
user/_ln:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	add	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	add	s0,sp,32
  if(argc != 3){
   a:	478d                	li	a5,3
   c:	02f50063          	beq	a0,a5,2c <main+0x2c>
    fprintf(2, "Usage: ln old new\n");
  10:	00001597          	auipc	a1,0x1
  14:	86058593          	add	a1,a1,-1952 # 870 <malloc+0xf0>
  18:	4509                	li	a0,2
  1a:	00000097          	auipc	ra,0x0
  1e:	680080e7          	jalr	1664(ra) # 69a <fprintf>
    exit(1);
  22:	4505                	li	a0,1
  24:	00000097          	auipc	ra,0x0
  28:	31c080e7          	jalr	796(ra) # 340 <exit>
  2c:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  2e:	698c                	ld	a1,16(a1)
  30:	6488                	ld	a0,8(s1)
  32:	00000097          	auipc	ra,0x0
  36:	36e080e7          	jalr	878(ra) # 3a0 <link>
  3a:	00054763          	bltz	a0,48 <main+0x48>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	300080e7          	jalr	768(ra) # 340 <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  48:	6894                	ld	a3,16(s1)
  4a:	6490                	ld	a2,8(s1)
  4c:	00001597          	auipc	a1,0x1
  50:	83c58593          	add	a1,a1,-1988 # 888 <malloc+0x108>
  54:	4509                	li	a0,2
  56:	00000097          	auipc	ra,0x0
  5a:	644080e7          	jalr	1604(ra) # 69a <fprintf>
  5e:	b7c5                	j	3e <main+0x3e>

0000000000000060 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  60:	1141                	add	sp,sp,-16
  62:	e406                	sd	ra,8(sp)
  64:	e022                	sd	s0,0(sp)
  66:	0800                	add	s0,sp,16
  extern int main();
  main();
  68:	00000097          	auipc	ra,0x0
  6c:	f98080e7          	jalr	-104(ra) # 0 <main>
  exit(0);
  70:	4501                	li	a0,0
  72:	00000097          	auipc	ra,0x0
  76:	2ce080e7          	jalr	718(ra) # 340 <exit>

000000000000007a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  7a:	1141                	add	sp,sp,-16
  7c:	e422                	sd	s0,8(sp)
  7e:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  80:	87aa                	mv	a5,a0
  82:	0585                	add	a1,a1,1
  84:	0785                	add	a5,a5,1
  86:	fff5c703          	lbu	a4,-1(a1)
  8a:	fee78fa3          	sb	a4,-1(a5)
  8e:	fb75                	bnez	a4,82 <strcpy+0x8>
    ;
  return os;
}
  90:	6422                	ld	s0,8(sp)
  92:	0141                	add	sp,sp,16
  94:	8082                	ret

0000000000000096 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  96:	1141                	add	sp,sp,-16
  98:	e422                	sd	s0,8(sp)
  9a:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  9c:	00054783          	lbu	a5,0(a0)
  a0:	cb91                	beqz	a5,b4 <strcmp+0x1e>
  a2:	0005c703          	lbu	a4,0(a1)
  a6:	00f71763          	bne	a4,a5,b4 <strcmp+0x1e>
    p++, q++;
  aa:	0505                	add	a0,a0,1
  ac:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  ae:	00054783          	lbu	a5,0(a0)
  b2:	fbe5                	bnez	a5,a2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  b4:	0005c503          	lbu	a0,0(a1)
}
  b8:	40a7853b          	subw	a0,a5,a0
  bc:	6422                	ld	s0,8(sp)
  be:	0141                	add	sp,sp,16
  c0:	8082                	ret

00000000000000c2 <strlen>:

uint
strlen(const char *s)
{
  c2:	1141                	add	sp,sp,-16
  c4:	e422                	sd	s0,8(sp)
  c6:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  c8:	00054783          	lbu	a5,0(a0)
  cc:	cf91                	beqz	a5,e8 <strlen+0x26>
  ce:	0505                	add	a0,a0,1
  d0:	87aa                	mv	a5,a0
  d2:	86be                	mv	a3,a5
  d4:	0785                	add	a5,a5,1
  d6:	fff7c703          	lbu	a4,-1(a5)
  da:	ff65                	bnez	a4,d2 <strlen+0x10>
  dc:	40a6853b          	subw	a0,a3,a0
  e0:	2505                	addw	a0,a0,1
    ;
  return n;
}
  e2:	6422                	ld	s0,8(sp)
  e4:	0141                	add	sp,sp,16
  e6:	8082                	ret
  for(n = 0; s[n]; n++)
  e8:	4501                	li	a0,0
  ea:	bfe5                	j	e2 <strlen+0x20>

00000000000000ec <memset>:

void*
memset(void *dst, int c, uint n)
{
  ec:	1141                	add	sp,sp,-16
  ee:	e422                	sd	s0,8(sp)
  f0:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  f2:	ca19                	beqz	a2,108 <memset+0x1c>
  f4:	87aa                	mv	a5,a0
  f6:	1602                	sll	a2,a2,0x20
  f8:	9201                	srl	a2,a2,0x20
  fa:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  fe:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 102:	0785                	add	a5,a5,1
 104:	fee79de3          	bne	a5,a4,fe <memset+0x12>
  }
  return dst;
}
 108:	6422                	ld	s0,8(sp)
 10a:	0141                	add	sp,sp,16
 10c:	8082                	ret

000000000000010e <strchr>:

char*
strchr(const char *s, char c)
{
 10e:	1141                	add	sp,sp,-16
 110:	e422                	sd	s0,8(sp)
 112:	0800                	add	s0,sp,16
  for(; *s; s++)
 114:	00054783          	lbu	a5,0(a0)
 118:	cb99                	beqz	a5,12e <strchr+0x20>
    if(*s == c)
 11a:	00f58763          	beq	a1,a5,128 <strchr+0x1a>
  for(; *s; s++)
 11e:	0505                	add	a0,a0,1
 120:	00054783          	lbu	a5,0(a0)
 124:	fbfd                	bnez	a5,11a <strchr+0xc>
      return (char*)s;
  return 0;
 126:	4501                	li	a0,0
}
 128:	6422                	ld	s0,8(sp)
 12a:	0141                	add	sp,sp,16
 12c:	8082                	ret
  return 0;
 12e:	4501                	li	a0,0
 130:	bfe5                	j	128 <strchr+0x1a>

0000000000000132 <strstr>:

char*
strstr(const char *str, const char *substr)
{
 132:	1141                	add	sp,sp,-16
 134:	e422                	sd	s0,8(sp)
 136:	0800                	add	s0,sp,16
  const char *a, *b = substr;
  if (*b == 0)
 138:	0005c803          	lbu	a6,0(a1)
 13c:	02080a63          	beqz	a6,170 <strstr+0x3e>
    return (char*)str;
  for( ; *str != 0; str += 1) {
 140:	00054783          	lbu	a5,0(a0)
 144:	e799                	bnez	a5,152 <strstr+0x20>
      if (*a++ != *b++)
        break;
    }
    b = substr;
  }
  return 0;
 146:	4501                	li	a0,0
 148:	a025                	j	170 <strstr+0x3e>
  for( ; *str != 0; str += 1) {
 14a:	0505                	add	a0,a0,1
 14c:	00054783          	lbu	a5,0(a0)
 150:	cf99                	beqz	a5,16e <strstr+0x3c>
    if (*str != *b)
 152:	fef81ce3          	bne	a6,a5,14a <strstr+0x18>
 156:	87ae                	mv	a5,a1
 158:	86aa                	mv	a3,a0
      if (*b == 0)
 15a:	0007c703          	lbu	a4,0(a5)
 15e:	cb09                	beqz	a4,170 <strstr+0x3e>
      if (*a++ != *b++)
 160:	0685                	add	a3,a3,1
 162:	0785                	add	a5,a5,1
 164:	fff6c603          	lbu	a2,-1(a3)
 168:	fee609e3          	beq	a2,a4,15a <strstr+0x28>
 16c:	bff9                	j	14a <strstr+0x18>
  return 0;
 16e:	4501                	li	a0,0
}
 170:	6422                	ld	s0,8(sp)
 172:	0141                	add	sp,sp,16
 174:	8082                	ret

0000000000000176 <gets>:

char*
gets(char *buf, int max)
{
 176:	711d                	add	sp,sp,-96
 178:	ec86                	sd	ra,88(sp)
 17a:	e8a2                	sd	s0,80(sp)
 17c:	e4a6                	sd	s1,72(sp)
 17e:	e0ca                	sd	s2,64(sp)
 180:	fc4e                	sd	s3,56(sp)
 182:	f852                	sd	s4,48(sp)
 184:	f456                	sd	s5,40(sp)
 186:	f05a                	sd	s6,32(sp)
 188:	ec5e                	sd	s7,24(sp)
 18a:	1080                	add	s0,sp,96
 18c:	8baa                	mv	s7,a0
 18e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 190:	892a                	mv	s2,a0
 192:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 194:	4aa9                	li	s5,10
 196:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 198:	89a6                	mv	s3,s1
 19a:	2485                	addw	s1,s1,1
 19c:	0344d863          	bge	s1,s4,1cc <gets+0x56>
    cc = read(0, &c, 1);
 1a0:	4605                	li	a2,1
 1a2:	faf40593          	add	a1,s0,-81
 1a6:	4501                	li	a0,0
 1a8:	00000097          	auipc	ra,0x0
 1ac:	1b0080e7          	jalr	432(ra) # 358 <read>
    if(cc < 1)
 1b0:	00a05e63          	blez	a0,1cc <gets+0x56>
    buf[i++] = c;
 1b4:	faf44783          	lbu	a5,-81(s0)
 1b8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1bc:	01578763          	beq	a5,s5,1ca <gets+0x54>
 1c0:	0905                	add	s2,s2,1
 1c2:	fd679be3          	bne	a5,s6,198 <gets+0x22>
  for(i=0; i+1 < max; ){
 1c6:	89a6                	mv	s3,s1
 1c8:	a011                	j	1cc <gets+0x56>
 1ca:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1cc:	99de                	add	s3,s3,s7
 1ce:	00098023          	sb	zero,0(s3)
  return buf;
}
 1d2:	855e                	mv	a0,s7
 1d4:	60e6                	ld	ra,88(sp)
 1d6:	6446                	ld	s0,80(sp)
 1d8:	64a6                	ld	s1,72(sp)
 1da:	6906                	ld	s2,64(sp)
 1dc:	79e2                	ld	s3,56(sp)
 1de:	7a42                	ld	s4,48(sp)
 1e0:	7aa2                	ld	s5,40(sp)
 1e2:	7b02                	ld	s6,32(sp)
 1e4:	6be2                	ld	s7,24(sp)
 1e6:	6125                	add	sp,sp,96
 1e8:	8082                	ret

00000000000001ea <stat>:

int
stat(const char *n, struct stat *st)
{
 1ea:	1101                	add	sp,sp,-32
 1ec:	ec06                	sd	ra,24(sp)
 1ee:	e822                	sd	s0,16(sp)
 1f0:	e426                	sd	s1,8(sp)
 1f2:	e04a                	sd	s2,0(sp)
 1f4:	1000                	add	s0,sp,32
 1f6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f8:	4581                	li	a1,0
 1fa:	00000097          	auipc	ra,0x0
 1fe:	186080e7          	jalr	390(ra) # 380 <open>
  if(fd < 0)
 202:	02054563          	bltz	a0,22c <stat+0x42>
 206:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 208:	85ca                	mv	a1,s2
 20a:	00000097          	auipc	ra,0x0
 20e:	18e080e7          	jalr	398(ra) # 398 <fstat>
 212:	892a                	mv	s2,a0
  close(fd);
 214:	8526                	mv	a0,s1
 216:	00000097          	auipc	ra,0x0
 21a:	152080e7          	jalr	338(ra) # 368 <close>
  return r;
}
 21e:	854a                	mv	a0,s2
 220:	60e2                	ld	ra,24(sp)
 222:	6442                	ld	s0,16(sp)
 224:	64a2                	ld	s1,8(sp)
 226:	6902                	ld	s2,0(sp)
 228:	6105                	add	sp,sp,32
 22a:	8082                	ret
    return -1;
 22c:	597d                	li	s2,-1
 22e:	bfc5                	j	21e <stat+0x34>

0000000000000230 <atoi>:

int
atoi(const char *s)
{
 230:	1141                	add	sp,sp,-16
 232:	e422                	sd	s0,8(sp)
 234:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 236:	00054683          	lbu	a3,0(a0)
 23a:	fd06879b          	addw	a5,a3,-48
 23e:	0ff7f793          	zext.b	a5,a5
 242:	4625                	li	a2,9
 244:	02f66863          	bltu	a2,a5,274 <atoi+0x44>
 248:	872a                	mv	a4,a0
  n = 0;
 24a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 24c:	0705                	add	a4,a4,1
 24e:	0025179b          	sllw	a5,a0,0x2
 252:	9fa9                	addw	a5,a5,a0
 254:	0017979b          	sllw	a5,a5,0x1
 258:	9fb5                	addw	a5,a5,a3
 25a:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 25e:	00074683          	lbu	a3,0(a4)
 262:	fd06879b          	addw	a5,a3,-48
 266:	0ff7f793          	zext.b	a5,a5
 26a:	fef671e3          	bgeu	a2,a5,24c <atoi+0x1c>
  return n;
}
 26e:	6422                	ld	s0,8(sp)
 270:	0141                	add	sp,sp,16
 272:	8082                	ret
  n = 0;
 274:	4501                	li	a0,0
 276:	bfe5                	j	26e <atoi+0x3e>

0000000000000278 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 278:	1141                	add	sp,sp,-16
 27a:	e422                	sd	s0,8(sp)
 27c:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 27e:	02b57463          	bgeu	a0,a1,2a6 <memmove+0x2e>
    while(n-- > 0)
 282:	00c05f63          	blez	a2,2a0 <memmove+0x28>
 286:	1602                	sll	a2,a2,0x20
 288:	9201                	srl	a2,a2,0x20
 28a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 28e:	872a                	mv	a4,a0
      *dst++ = *src++;
 290:	0585                	add	a1,a1,1
 292:	0705                	add	a4,a4,1
 294:	fff5c683          	lbu	a3,-1(a1)
 298:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 29c:	fee79ae3          	bne	a5,a4,290 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2a0:	6422                	ld	s0,8(sp)
 2a2:	0141                	add	sp,sp,16
 2a4:	8082                	ret
    dst += n;
 2a6:	00c50733          	add	a4,a0,a2
    src += n;
 2aa:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2ac:	fec05ae3          	blez	a2,2a0 <memmove+0x28>
 2b0:	fff6079b          	addw	a5,a2,-1
 2b4:	1782                	sll	a5,a5,0x20
 2b6:	9381                	srl	a5,a5,0x20
 2b8:	fff7c793          	not	a5,a5
 2bc:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2be:	15fd                	add	a1,a1,-1
 2c0:	177d                	add	a4,a4,-1
 2c2:	0005c683          	lbu	a3,0(a1)
 2c6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2ca:	fee79ae3          	bne	a5,a4,2be <memmove+0x46>
 2ce:	bfc9                	j	2a0 <memmove+0x28>

00000000000002d0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2d0:	1141                	add	sp,sp,-16
 2d2:	e422                	sd	s0,8(sp)
 2d4:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2d6:	ca05                	beqz	a2,306 <memcmp+0x36>
 2d8:	fff6069b          	addw	a3,a2,-1
 2dc:	1682                	sll	a3,a3,0x20
 2de:	9281                	srl	a3,a3,0x20
 2e0:	0685                	add	a3,a3,1
 2e2:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2e4:	00054783          	lbu	a5,0(a0)
 2e8:	0005c703          	lbu	a4,0(a1)
 2ec:	00e79863          	bne	a5,a4,2fc <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2f0:	0505                	add	a0,a0,1
    p2++;
 2f2:	0585                	add	a1,a1,1
  while (n-- > 0) {
 2f4:	fed518e3          	bne	a0,a3,2e4 <memcmp+0x14>
  }
  return 0;
 2f8:	4501                	li	a0,0
 2fa:	a019                	j	300 <memcmp+0x30>
      return *p1 - *p2;
 2fc:	40e7853b          	subw	a0,a5,a4
}
 300:	6422                	ld	s0,8(sp)
 302:	0141                	add	sp,sp,16
 304:	8082                	ret
  return 0;
 306:	4501                	li	a0,0
 308:	bfe5                	j	300 <memcmp+0x30>

000000000000030a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 30a:	1141                	add	sp,sp,-16
 30c:	e406                	sd	ra,8(sp)
 30e:	e022                	sd	s0,0(sp)
 310:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 312:	00000097          	auipc	ra,0x0
 316:	f66080e7          	jalr	-154(ra) # 278 <memmove>
}
 31a:	60a2                	ld	ra,8(sp)
 31c:	6402                	ld	s0,0(sp)
 31e:	0141                	add	sp,sp,16
 320:	8082                	ret

0000000000000322 <ugetpid>:

int
ugetpid(void)
{
 322:	1141                	add	sp,sp,-16
 324:	e422                	sd	s0,8(sp)
 326:	0800                	add	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 328:	040007b7          	lui	a5,0x4000
}
 32c:	17f5                	add	a5,a5,-3 # 3fffffd <base+0x3ffefed>
 32e:	07b2                	sll	a5,a5,0xc
 330:	4388                	lw	a0,0(a5)
 332:	6422                	ld	s0,8(sp)
 334:	0141                	add	sp,sp,16
 336:	8082                	ret

0000000000000338 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 338:	4885                	li	a7,1
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <exit>:
.global exit
exit:
 li a7, SYS_exit
 340:	4889                	li	a7,2
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <wait>:
.global wait
wait:
 li a7, SYS_wait
 348:	488d                	li	a7,3
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 350:	4891                	li	a7,4
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <read>:
.global read
read:
 li a7, SYS_read
 358:	4895                	li	a7,5
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <write>:
.global write
write:
 li a7, SYS_write
 360:	48c1                	li	a7,16
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <close>:
.global close
close:
 li a7, SYS_close
 368:	48d5                	li	a7,21
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <kill>:
.global kill
kill:
 li a7, SYS_kill
 370:	4899                	li	a7,6
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <exec>:
.global exec
exec:
 li a7, SYS_exec
 378:	489d                	li	a7,7
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <open>:
.global open
open:
 li a7, SYS_open
 380:	48bd                	li	a7,15
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 388:	48c5                	li	a7,17
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 390:	48c9                	li	a7,18
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 398:	48a1                	li	a7,8
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <link>:
.global link
link:
 li a7, SYS_link
 3a0:	48cd                	li	a7,19
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3a8:	48d1                	li	a7,20
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3b0:	48a5                	li	a7,9
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3b8:	48a9                	li	a7,10
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3c0:	48ad                	li	a7,11
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3c8:	48b1                	li	a7,12
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3d0:	48b5                	li	a7,13
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3d8:	48b9                	li	a7,14
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <trace>:
.global trace
trace:
 li a7, SYS_trace
 3e0:	48d9                	li	a7,22
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 3e8:	48dd                	li	a7,23
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 3f0:	48e1                	li	a7,24
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <setpriority>:
.global setpriority
setpriority:
 li a7, SYS_setpriority
 3f8:	48e5                	li	a7,25
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 400:	1101                	add	sp,sp,-32
 402:	ec06                	sd	ra,24(sp)
 404:	e822                	sd	s0,16(sp)
 406:	1000                	add	s0,sp,32
 408:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 40c:	4605                	li	a2,1
 40e:	fef40593          	add	a1,s0,-17
 412:	00000097          	auipc	ra,0x0
 416:	f4e080e7          	jalr	-178(ra) # 360 <write>
}
 41a:	60e2                	ld	ra,24(sp)
 41c:	6442                	ld	s0,16(sp)
 41e:	6105                	add	sp,sp,32
 420:	8082                	ret

0000000000000422 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 422:	7139                	add	sp,sp,-64
 424:	fc06                	sd	ra,56(sp)
 426:	f822                	sd	s0,48(sp)
 428:	f426                	sd	s1,40(sp)
 42a:	f04a                	sd	s2,32(sp)
 42c:	ec4e                	sd	s3,24(sp)
 42e:	0080                	add	s0,sp,64
 430:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 432:	c299                	beqz	a3,438 <printint+0x16>
 434:	0805c963          	bltz	a1,4c6 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 438:	2581                	sext.w	a1,a1
  neg = 0;
 43a:	4881                	li	a7,0
 43c:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 440:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 442:	2601                	sext.w	a2,a2
 444:	00000517          	auipc	a0,0x0
 448:	4bc50513          	add	a0,a0,1212 # 900 <digits>
 44c:	883a                	mv	a6,a4
 44e:	2705                	addw	a4,a4,1
 450:	02c5f7bb          	remuw	a5,a1,a2
 454:	1782                	sll	a5,a5,0x20
 456:	9381                	srl	a5,a5,0x20
 458:	97aa                	add	a5,a5,a0
 45a:	0007c783          	lbu	a5,0(a5)
 45e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 462:	0005879b          	sext.w	a5,a1
 466:	02c5d5bb          	divuw	a1,a1,a2
 46a:	0685                	add	a3,a3,1
 46c:	fec7f0e3          	bgeu	a5,a2,44c <printint+0x2a>
  if(neg)
 470:	00088c63          	beqz	a7,488 <printint+0x66>
    buf[i++] = '-';
 474:	fd070793          	add	a5,a4,-48
 478:	00878733          	add	a4,a5,s0
 47c:	02d00793          	li	a5,45
 480:	fef70823          	sb	a5,-16(a4)
 484:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 488:	02e05863          	blez	a4,4b8 <printint+0x96>
 48c:	fc040793          	add	a5,s0,-64
 490:	00e78933          	add	s2,a5,a4
 494:	fff78993          	add	s3,a5,-1
 498:	99ba                	add	s3,s3,a4
 49a:	377d                	addw	a4,a4,-1
 49c:	1702                	sll	a4,a4,0x20
 49e:	9301                	srl	a4,a4,0x20
 4a0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4a4:	fff94583          	lbu	a1,-1(s2)
 4a8:	8526                	mv	a0,s1
 4aa:	00000097          	auipc	ra,0x0
 4ae:	f56080e7          	jalr	-170(ra) # 400 <putc>
  while(--i >= 0)
 4b2:	197d                	add	s2,s2,-1
 4b4:	ff3918e3          	bne	s2,s3,4a4 <printint+0x82>
}
 4b8:	70e2                	ld	ra,56(sp)
 4ba:	7442                	ld	s0,48(sp)
 4bc:	74a2                	ld	s1,40(sp)
 4be:	7902                	ld	s2,32(sp)
 4c0:	69e2                	ld	s3,24(sp)
 4c2:	6121                	add	sp,sp,64
 4c4:	8082                	ret
    x = -xx;
 4c6:	40b005bb          	negw	a1,a1
    neg = 1;
 4ca:	4885                	li	a7,1
    x = -xx;
 4cc:	bf85                	j	43c <printint+0x1a>

00000000000004ce <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4ce:	715d                	add	sp,sp,-80
 4d0:	e486                	sd	ra,72(sp)
 4d2:	e0a2                	sd	s0,64(sp)
 4d4:	fc26                	sd	s1,56(sp)
 4d6:	f84a                	sd	s2,48(sp)
 4d8:	f44e                	sd	s3,40(sp)
 4da:	f052                	sd	s4,32(sp)
 4dc:	ec56                	sd	s5,24(sp)
 4de:	e85a                	sd	s6,16(sp)
 4e0:	e45e                	sd	s7,8(sp)
 4e2:	e062                	sd	s8,0(sp)
 4e4:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4e6:	0005c903          	lbu	s2,0(a1)
 4ea:	18090c63          	beqz	s2,682 <vprintf+0x1b4>
 4ee:	8aaa                	mv	s5,a0
 4f0:	8bb2                	mv	s7,a2
 4f2:	00158493          	add	s1,a1,1
  state = 0;
 4f6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4f8:	02500a13          	li	s4,37
 4fc:	4b55                	li	s6,21
 4fe:	a839                	j	51c <vprintf+0x4e>
        putc(fd, c);
 500:	85ca                	mv	a1,s2
 502:	8556                	mv	a0,s5
 504:	00000097          	auipc	ra,0x0
 508:	efc080e7          	jalr	-260(ra) # 400 <putc>
 50c:	a019                	j	512 <vprintf+0x44>
    } else if(state == '%'){
 50e:	01498d63          	beq	s3,s4,528 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 512:	0485                	add	s1,s1,1
 514:	fff4c903          	lbu	s2,-1(s1)
 518:	16090563          	beqz	s2,682 <vprintf+0x1b4>
    if(state == 0){
 51c:	fe0999e3          	bnez	s3,50e <vprintf+0x40>
      if(c == '%'){
 520:	ff4910e3          	bne	s2,s4,500 <vprintf+0x32>
        state = '%';
 524:	89d2                	mv	s3,s4
 526:	b7f5                	j	512 <vprintf+0x44>
      if(c == 'd'){
 528:	13490263          	beq	s2,s4,64c <vprintf+0x17e>
 52c:	f9d9079b          	addw	a5,s2,-99
 530:	0ff7f793          	zext.b	a5,a5
 534:	12fb6563          	bltu	s6,a5,65e <vprintf+0x190>
 538:	f9d9079b          	addw	a5,s2,-99
 53c:	0ff7f713          	zext.b	a4,a5
 540:	10eb6f63          	bltu	s6,a4,65e <vprintf+0x190>
 544:	00271793          	sll	a5,a4,0x2
 548:	00000717          	auipc	a4,0x0
 54c:	36070713          	add	a4,a4,864 # 8a8 <malloc+0x128>
 550:	97ba                	add	a5,a5,a4
 552:	439c                	lw	a5,0(a5)
 554:	97ba                	add	a5,a5,a4
 556:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 558:	008b8913          	add	s2,s7,8
 55c:	4685                	li	a3,1
 55e:	4629                	li	a2,10
 560:	000ba583          	lw	a1,0(s7)
 564:	8556                	mv	a0,s5
 566:	00000097          	auipc	ra,0x0
 56a:	ebc080e7          	jalr	-324(ra) # 422 <printint>
 56e:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 570:	4981                	li	s3,0
 572:	b745                	j	512 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 574:	008b8913          	add	s2,s7,8
 578:	4681                	li	a3,0
 57a:	4629                	li	a2,10
 57c:	000ba583          	lw	a1,0(s7)
 580:	8556                	mv	a0,s5
 582:	00000097          	auipc	ra,0x0
 586:	ea0080e7          	jalr	-352(ra) # 422 <printint>
 58a:	8bca                	mv	s7,s2
      state = 0;
 58c:	4981                	li	s3,0
 58e:	b751                	j	512 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 590:	008b8913          	add	s2,s7,8
 594:	4681                	li	a3,0
 596:	4641                	li	a2,16
 598:	000ba583          	lw	a1,0(s7)
 59c:	8556                	mv	a0,s5
 59e:	00000097          	auipc	ra,0x0
 5a2:	e84080e7          	jalr	-380(ra) # 422 <printint>
 5a6:	8bca                	mv	s7,s2
      state = 0;
 5a8:	4981                	li	s3,0
 5aa:	b7a5                	j	512 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 5ac:	008b8c13          	add	s8,s7,8
 5b0:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 5b4:	03000593          	li	a1,48
 5b8:	8556                	mv	a0,s5
 5ba:	00000097          	auipc	ra,0x0
 5be:	e46080e7          	jalr	-442(ra) # 400 <putc>
  putc(fd, 'x');
 5c2:	07800593          	li	a1,120
 5c6:	8556                	mv	a0,s5
 5c8:	00000097          	auipc	ra,0x0
 5cc:	e38080e7          	jalr	-456(ra) # 400 <putc>
 5d0:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5d2:	00000b97          	auipc	s7,0x0
 5d6:	32eb8b93          	add	s7,s7,814 # 900 <digits>
 5da:	03c9d793          	srl	a5,s3,0x3c
 5de:	97de                	add	a5,a5,s7
 5e0:	0007c583          	lbu	a1,0(a5)
 5e4:	8556                	mv	a0,s5
 5e6:	00000097          	auipc	ra,0x0
 5ea:	e1a080e7          	jalr	-486(ra) # 400 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5ee:	0992                	sll	s3,s3,0x4
 5f0:	397d                	addw	s2,s2,-1
 5f2:	fe0914e3          	bnez	s2,5da <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 5f6:	8be2                	mv	s7,s8
      state = 0;
 5f8:	4981                	li	s3,0
 5fa:	bf21                	j	512 <vprintf+0x44>
        s = va_arg(ap, char*);
 5fc:	008b8993          	add	s3,s7,8
 600:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 604:	02090163          	beqz	s2,626 <vprintf+0x158>
        while(*s != 0){
 608:	00094583          	lbu	a1,0(s2)
 60c:	c9a5                	beqz	a1,67c <vprintf+0x1ae>
          putc(fd, *s);
 60e:	8556                	mv	a0,s5
 610:	00000097          	auipc	ra,0x0
 614:	df0080e7          	jalr	-528(ra) # 400 <putc>
          s++;
 618:	0905                	add	s2,s2,1
        while(*s != 0){
 61a:	00094583          	lbu	a1,0(s2)
 61e:	f9e5                	bnez	a1,60e <vprintf+0x140>
        s = va_arg(ap, char*);
 620:	8bce                	mv	s7,s3
      state = 0;
 622:	4981                	li	s3,0
 624:	b5fd                	j	512 <vprintf+0x44>
          s = "(null)";
 626:	00000917          	auipc	s2,0x0
 62a:	27a90913          	add	s2,s2,634 # 8a0 <malloc+0x120>
        while(*s != 0){
 62e:	02800593          	li	a1,40
 632:	bff1                	j	60e <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 634:	008b8913          	add	s2,s7,8
 638:	000bc583          	lbu	a1,0(s7)
 63c:	8556                	mv	a0,s5
 63e:	00000097          	auipc	ra,0x0
 642:	dc2080e7          	jalr	-574(ra) # 400 <putc>
 646:	8bca                	mv	s7,s2
      state = 0;
 648:	4981                	li	s3,0
 64a:	b5e1                	j	512 <vprintf+0x44>
        putc(fd, c);
 64c:	02500593          	li	a1,37
 650:	8556                	mv	a0,s5
 652:	00000097          	auipc	ra,0x0
 656:	dae080e7          	jalr	-594(ra) # 400 <putc>
      state = 0;
 65a:	4981                	li	s3,0
 65c:	bd5d                	j	512 <vprintf+0x44>
        putc(fd, '%');
 65e:	02500593          	li	a1,37
 662:	8556                	mv	a0,s5
 664:	00000097          	auipc	ra,0x0
 668:	d9c080e7          	jalr	-612(ra) # 400 <putc>
        putc(fd, c);
 66c:	85ca                	mv	a1,s2
 66e:	8556                	mv	a0,s5
 670:	00000097          	auipc	ra,0x0
 674:	d90080e7          	jalr	-624(ra) # 400 <putc>
      state = 0;
 678:	4981                	li	s3,0
 67a:	bd61                	j	512 <vprintf+0x44>
        s = va_arg(ap, char*);
 67c:	8bce                	mv	s7,s3
      state = 0;
 67e:	4981                	li	s3,0
 680:	bd49                	j	512 <vprintf+0x44>
    }
  }
}
 682:	60a6                	ld	ra,72(sp)
 684:	6406                	ld	s0,64(sp)
 686:	74e2                	ld	s1,56(sp)
 688:	7942                	ld	s2,48(sp)
 68a:	79a2                	ld	s3,40(sp)
 68c:	7a02                	ld	s4,32(sp)
 68e:	6ae2                	ld	s5,24(sp)
 690:	6b42                	ld	s6,16(sp)
 692:	6ba2                	ld	s7,8(sp)
 694:	6c02                	ld	s8,0(sp)
 696:	6161                	add	sp,sp,80
 698:	8082                	ret

000000000000069a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 69a:	715d                	add	sp,sp,-80
 69c:	ec06                	sd	ra,24(sp)
 69e:	e822                	sd	s0,16(sp)
 6a0:	1000                	add	s0,sp,32
 6a2:	e010                	sd	a2,0(s0)
 6a4:	e414                	sd	a3,8(s0)
 6a6:	e818                	sd	a4,16(s0)
 6a8:	ec1c                	sd	a5,24(s0)
 6aa:	03043023          	sd	a6,32(s0)
 6ae:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6b2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6b6:	8622                	mv	a2,s0
 6b8:	00000097          	auipc	ra,0x0
 6bc:	e16080e7          	jalr	-490(ra) # 4ce <vprintf>
}
 6c0:	60e2                	ld	ra,24(sp)
 6c2:	6442                	ld	s0,16(sp)
 6c4:	6161                	add	sp,sp,80
 6c6:	8082                	ret

00000000000006c8 <printf>:

void
printf(const char *fmt, ...)
{
 6c8:	711d                	add	sp,sp,-96
 6ca:	ec06                	sd	ra,24(sp)
 6cc:	e822                	sd	s0,16(sp)
 6ce:	1000                	add	s0,sp,32
 6d0:	e40c                	sd	a1,8(s0)
 6d2:	e810                	sd	a2,16(s0)
 6d4:	ec14                	sd	a3,24(s0)
 6d6:	f018                	sd	a4,32(s0)
 6d8:	f41c                	sd	a5,40(s0)
 6da:	03043823          	sd	a6,48(s0)
 6de:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6e2:	00840613          	add	a2,s0,8
 6e6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6ea:	85aa                	mv	a1,a0
 6ec:	4505                	li	a0,1
 6ee:	00000097          	auipc	ra,0x0
 6f2:	de0080e7          	jalr	-544(ra) # 4ce <vprintf>
}
 6f6:	60e2                	ld	ra,24(sp)
 6f8:	6442                	ld	s0,16(sp)
 6fa:	6125                	add	sp,sp,96
 6fc:	8082                	ret

00000000000006fe <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6fe:	1141                	add	sp,sp,-16
 700:	e422                	sd	s0,8(sp)
 702:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 704:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 708:	00001797          	auipc	a5,0x1
 70c:	8f87b783          	ld	a5,-1800(a5) # 1000 <freep>
 710:	a02d                	j	73a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 712:	4618                	lw	a4,8(a2)
 714:	9f2d                	addw	a4,a4,a1
 716:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 71a:	6398                	ld	a4,0(a5)
 71c:	6310                	ld	a2,0(a4)
 71e:	a83d                	j	75c <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 720:	ff852703          	lw	a4,-8(a0)
 724:	9f31                	addw	a4,a4,a2
 726:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 728:	ff053683          	ld	a3,-16(a0)
 72c:	a091                	j	770 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 72e:	6398                	ld	a4,0(a5)
 730:	00e7e463          	bltu	a5,a4,738 <free+0x3a>
 734:	00e6ea63          	bltu	a3,a4,748 <free+0x4a>
{
 738:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 73a:	fed7fae3          	bgeu	a5,a3,72e <free+0x30>
 73e:	6398                	ld	a4,0(a5)
 740:	00e6e463          	bltu	a3,a4,748 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 744:	fee7eae3          	bltu	a5,a4,738 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 748:	ff852583          	lw	a1,-8(a0)
 74c:	6390                	ld	a2,0(a5)
 74e:	02059813          	sll	a6,a1,0x20
 752:	01c85713          	srl	a4,a6,0x1c
 756:	9736                	add	a4,a4,a3
 758:	fae60de3          	beq	a2,a4,712 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 75c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 760:	4790                	lw	a2,8(a5)
 762:	02061593          	sll	a1,a2,0x20
 766:	01c5d713          	srl	a4,a1,0x1c
 76a:	973e                	add	a4,a4,a5
 76c:	fae68ae3          	beq	a3,a4,720 <free+0x22>
    p->s.ptr = bp->s.ptr;
 770:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 772:	00001717          	auipc	a4,0x1
 776:	88f73723          	sd	a5,-1906(a4) # 1000 <freep>
}
 77a:	6422                	ld	s0,8(sp)
 77c:	0141                	add	sp,sp,16
 77e:	8082                	ret

0000000000000780 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 780:	7139                	add	sp,sp,-64
 782:	fc06                	sd	ra,56(sp)
 784:	f822                	sd	s0,48(sp)
 786:	f426                	sd	s1,40(sp)
 788:	f04a                	sd	s2,32(sp)
 78a:	ec4e                	sd	s3,24(sp)
 78c:	e852                	sd	s4,16(sp)
 78e:	e456                	sd	s5,8(sp)
 790:	e05a                	sd	s6,0(sp)
 792:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 794:	02051493          	sll	s1,a0,0x20
 798:	9081                	srl	s1,s1,0x20
 79a:	04bd                	add	s1,s1,15
 79c:	8091                	srl	s1,s1,0x4
 79e:	0014899b          	addw	s3,s1,1
 7a2:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 7a4:	00001517          	auipc	a0,0x1
 7a8:	85c53503          	ld	a0,-1956(a0) # 1000 <freep>
 7ac:	c515                	beqz	a0,7d8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ae:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7b0:	4798                	lw	a4,8(a5)
 7b2:	02977f63          	bgeu	a4,s1,7f0 <malloc+0x70>
  if(nu < 4096)
 7b6:	8a4e                	mv	s4,s3
 7b8:	0009871b          	sext.w	a4,s3
 7bc:	6685                	lui	a3,0x1
 7be:	00d77363          	bgeu	a4,a3,7c4 <malloc+0x44>
 7c2:	6a05                	lui	s4,0x1
 7c4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7c8:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7cc:	00001917          	auipc	s2,0x1
 7d0:	83490913          	add	s2,s2,-1996 # 1000 <freep>
  if(p == (char*)-1)
 7d4:	5afd                	li	s5,-1
 7d6:	a895                	j	84a <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 7d8:	00001797          	auipc	a5,0x1
 7dc:	83878793          	add	a5,a5,-1992 # 1010 <base>
 7e0:	00001717          	auipc	a4,0x1
 7e4:	82f73023          	sd	a5,-2016(a4) # 1000 <freep>
 7e8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7ea:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7ee:	b7e1                	j	7b6 <malloc+0x36>
      if(p->s.size == nunits)
 7f0:	02e48c63          	beq	s1,a4,828 <malloc+0xa8>
        p->s.size -= nunits;
 7f4:	4137073b          	subw	a4,a4,s3
 7f8:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7fa:	02071693          	sll	a3,a4,0x20
 7fe:	01c6d713          	srl	a4,a3,0x1c
 802:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 804:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 808:	00000717          	auipc	a4,0x0
 80c:	7ea73c23          	sd	a0,2040(a4) # 1000 <freep>
      return (void*)(p + 1);
 810:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 814:	70e2                	ld	ra,56(sp)
 816:	7442                	ld	s0,48(sp)
 818:	74a2                	ld	s1,40(sp)
 81a:	7902                	ld	s2,32(sp)
 81c:	69e2                	ld	s3,24(sp)
 81e:	6a42                	ld	s4,16(sp)
 820:	6aa2                	ld	s5,8(sp)
 822:	6b02                	ld	s6,0(sp)
 824:	6121                	add	sp,sp,64
 826:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 828:	6398                	ld	a4,0(a5)
 82a:	e118                	sd	a4,0(a0)
 82c:	bff1                	j	808 <malloc+0x88>
  hp->s.size = nu;
 82e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 832:	0541                	add	a0,a0,16
 834:	00000097          	auipc	ra,0x0
 838:	eca080e7          	jalr	-310(ra) # 6fe <free>
  return freep;
 83c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 840:	d971                	beqz	a0,814 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 842:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 844:	4798                	lw	a4,8(a5)
 846:	fa9775e3          	bgeu	a4,s1,7f0 <malloc+0x70>
    if(p == freep)
 84a:	00093703          	ld	a4,0(s2)
 84e:	853e                	mv	a0,a5
 850:	fef719e3          	bne	a4,a5,842 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 854:	8552                	mv	a0,s4
 856:	00000097          	auipc	ra,0x0
 85a:	b72080e7          	jalr	-1166(ra) # 3c8 <sbrk>
  if(p == (char*)-1)
 85e:	fd5518e3          	bne	a0,s5,82e <malloc+0xae>
        return 0;
 862:	4501                	li	a0,0
 864:	bf45                	j	814 <malloc+0x94>
