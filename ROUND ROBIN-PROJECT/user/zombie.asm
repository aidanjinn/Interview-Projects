
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	add	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	add	s0,sp,16
  if(fork() > 0)
   8:	00000097          	auipc	ra,0x0
   c:	2fa080e7          	jalr	762(ra) # 302 <fork>
  10:	00a04763          	bgtz	a0,1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  exit(0);
  14:	4501                	li	a0,0
  16:	00000097          	auipc	ra,0x0
  1a:	2f4080e7          	jalr	756(ra) # 30a <exit>
    sleep(5);  // Let child exit before parent.
  1e:	4515                	li	a0,5
  20:	00000097          	auipc	ra,0x0
  24:	37a080e7          	jalr	890(ra) # 39a <sleep>
  28:	b7f5                	j	14 <main+0x14>

000000000000002a <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  2a:	1141                	add	sp,sp,-16
  2c:	e406                	sd	ra,8(sp)
  2e:	e022                	sd	s0,0(sp)
  30:	0800                	add	s0,sp,16
  extern int main();
  main();
  32:	00000097          	auipc	ra,0x0
  36:	fce080e7          	jalr	-50(ra) # 0 <main>
  exit(0);
  3a:	4501                	li	a0,0
  3c:	00000097          	auipc	ra,0x0
  40:	2ce080e7          	jalr	718(ra) # 30a <exit>

0000000000000044 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  44:	1141                	add	sp,sp,-16
  46:	e422                	sd	s0,8(sp)
  48:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  4a:	87aa                	mv	a5,a0
  4c:	0585                	add	a1,a1,1
  4e:	0785                	add	a5,a5,1
  50:	fff5c703          	lbu	a4,-1(a1)
  54:	fee78fa3          	sb	a4,-1(a5)
  58:	fb75                	bnez	a4,4c <strcpy+0x8>
    ;
  return os;
}
  5a:	6422                	ld	s0,8(sp)
  5c:	0141                	add	sp,sp,16
  5e:	8082                	ret

0000000000000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	1141                	add	sp,sp,-16
  62:	e422                	sd	s0,8(sp)
  64:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  66:	00054783          	lbu	a5,0(a0)
  6a:	cb91                	beqz	a5,7e <strcmp+0x1e>
  6c:	0005c703          	lbu	a4,0(a1)
  70:	00f71763          	bne	a4,a5,7e <strcmp+0x1e>
    p++, q++;
  74:	0505                	add	a0,a0,1
  76:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  78:	00054783          	lbu	a5,0(a0)
  7c:	fbe5                	bnez	a5,6c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  7e:	0005c503          	lbu	a0,0(a1)
}
  82:	40a7853b          	subw	a0,a5,a0
  86:	6422                	ld	s0,8(sp)
  88:	0141                	add	sp,sp,16
  8a:	8082                	ret

000000000000008c <strlen>:

uint
strlen(const char *s)
{
  8c:	1141                	add	sp,sp,-16
  8e:	e422                	sd	s0,8(sp)
  90:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  92:	00054783          	lbu	a5,0(a0)
  96:	cf91                	beqz	a5,b2 <strlen+0x26>
  98:	0505                	add	a0,a0,1
  9a:	87aa                	mv	a5,a0
  9c:	86be                	mv	a3,a5
  9e:	0785                	add	a5,a5,1
  a0:	fff7c703          	lbu	a4,-1(a5)
  a4:	ff65                	bnez	a4,9c <strlen+0x10>
  a6:	40a6853b          	subw	a0,a3,a0
  aa:	2505                	addw	a0,a0,1
    ;
  return n;
}
  ac:	6422                	ld	s0,8(sp)
  ae:	0141                	add	sp,sp,16
  b0:	8082                	ret
  for(n = 0; s[n]; n++)
  b2:	4501                	li	a0,0
  b4:	bfe5                	j	ac <strlen+0x20>

00000000000000b6 <memset>:

void*
memset(void *dst, int c, uint n)
{
  b6:	1141                	add	sp,sp,-16
  b8:	e422                	sd	s0,8(sp)
  ba:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  bc:	ca19                	beqz	a2,d2 <memset+0x1c>
  be:	87aa                	mv	a5,a0
  c0:	1602                	sll	a2,a2,0x20
  c2:	9201                	srl	a2,a2,0x20
  c4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  c8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  cc:	0785                	add	a5,a5,1
  ce:	fee79de3          	bne	a5,a4,c8 <memset+0x12>
  }
  return dst;
}
  d2:	6422                	ld	s0,8(sp)
  d4:	0141                	add	sp,sp,16
  d6:	8082                	ret

00000000000000d8 <strchr>:

char*
strchr(const char *s, char c)
{
  d8:	1141                	add	sp,sp,-16
  da:	e422                	sd	s0,8(sp)
  dc:	0800                	add	s0,sp,16
  for(; *s; s++)
  de:	00054783          	lbu	a5,0(a0)
  e2:	cb99                	beqz	a5,f8 <strchr+0x20>
    if(*s == c)
  e4:	00f58763          	beq	a1,a5,f2 <strchr+0x1a>
  for(; *s; s++)
  e8:	0505                	add	a0,a0,1
  ea:	00054783          	lbu	a5,0(a0)
  ee:	fbfd                	bnez	a5,e4 <strchr+0xc>
      return (char*)s;
  return 0;
  f0:	4501                	li	a0,0
}
  f2:	6422                	ld	s0,8(sp)
  f4:	0141                	add	sp,sp,16
  f6:	8082                	ret
  return 0;
  f8:	4501                	li	a0,0
  fa:	bfe5                	j	f2 <strchr+0x1a>

00000000000000fc <strstr>:

char*
strstr(const char *str, const char *substr)
{
  fc:	1141                	add	sp,sp,-16
  fe:	e422                	sd	s0,8(sp)
 100:	0800                	add	s0,sp,16
  const char *a, *b = substr;
  if (*b == 0)
 102:	0005c803          	lbu	a6,0(a1)
 106:	02080a63          	beqz	a6,13a <strstr+0x3e>
    return (char*)str;
  for( ; *str != 0; str += 1) {
 10a:	00054783          	lbu	a5,0(a0)
 10e:	e799                	bnez	a5,11c <strstr+0x20>
      if (*a++ != *b++)
        break;
    }
    b = substr;
  }
  return 0;
 110:	4501                	li	a0,0
 112:	a025                	j	13a <strstr+0x3e>
  for( ; *str != 0; str += 1) {
 114:	0505                	add	a0,a0,1
 116:	00054783          	lbu	a5,0(a0)
 11a:	cf99                	beqz	a5,138 <strstr+0x3c>
    if (*str != *b)
 11c:	fef81ce3          	bne	a6,a5,114 <strstr+0x18>
 120:	87ae                	mv	a5,a1
 122:	86aa                	mv	a3,a0
      if (*b == 0)
 124:	0007c703          	lbu	a4,0(a5)
 128:	cb09                	beqz	a4,13a <strstr+0x3e>
      if (*a++ != *b++)
 12a:	0685                	add	a3,a3,1
 12c:	0785                	add	a5,a5,1
 12e:	fff6c603          	lbu	a2,-1(a3)
 132:	fee609e3          	beq	a2,a4,124 <strstr+0x28>
 136:	bff9                	j	114 <strstr+0x18>
  return 0;
 138:	4501                	li	a0,0
}
 13a:	6422                	ld	s0,8(sp)
 13c:	0141                	add	sp,sp,16
 13e:	8082                	ret

0000000000000140 <gets>:

char*
gets(char *buf, int max)
{
 140:	711d                	add	sp,sp,-96
 142:	ec86                	sd	ra,88(sp)
 144:	e8a2                	sd	s0,80(sp)
 146:	e4a6                	sd	s1,72(sp)
 148:	e0ca                	sd	s2,64(sp)
 14a:	fc4e                	sd	s3,56(sp)
 14c:	f852                	sd	s4,48(sp)
 14e:	f456                	sd	s5,40(sp)
 150:	f05a                	sd	s6,32(sp)
 152:	ec5e                	sd	s7,24(sp)
 154:	1080                	add	s0,sp,96
 156:	8baa                	mv	s7,a0
 158:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 15a:	892a                	mv	s2,a0
 15c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 15e:	4aa9                	li	s5,10
 160:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 162:	89a6                	mv	s3,s1
 164:	2485                	addw	s1,s1,1
 166:	0344d863          	bge	s1,s4,196 <gets+0x56>
    cc = read(0, &c, 1);
 16a:	4605                	li	a2,1
 16c:	faf40593          	add	a1,s0,-81
 170:	4501                	li	a0,0
 172:	00000097          	auipc	ra,0x0
 176:	1b0080e7          	jalr	432(ra) # 322 <read>
    if(cc < 1)
 17a:	00a05e63          	blez	a0,196 <gets+0x56>
    buf[i++] = c;
 17e:	faf44783          	lbu	a5,-81(s0)
 182:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 186:	01578763          	beq	a5,s5,194 <gets+0x54>
 18a:	0905                	add	s2,s2,1
 18c:	fd679be3          	bne	a5,s6,162 <gets+0x22>
  for(i=0; i+1 < max; ){
 190:	89a6                	mv	s3,s1
 192:	a011                	j	196 <gets+0x56>
 194:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 196:	99de                	add	s3,s3,s7
 198:	00098023          	sb	zero,0(s3)
  return buf;
}
 19c:	855e                	mv	a0,s7
 19e:	60e6                	ld	ra,88(sp)
 1a0:	6446                	ld	s0,80(sp)
 1a2:	64a6                	ld	s1,72(sp)
 1a4:	6906                	ld	s2,64(sp)
 1a6:	79e2                	ld	s3,56(sp)
 1a8:	7a42                	ld	s4,48(sp)
 1aa:	7aa2                	ld	s5,40(sp)
 1ac:	7b02                	ld	s6,32(sp)
 1ae:	6be2                	ld	s7,24(sp)
 1b0:	6125                	add	sp,sp,96
 1b2:	8082                	ret

00000000000001b4 <stat>:

int
stat(const char *n, struct stat *st)
{
 1b4:	1101                	add	sp,sp,-32
 1b6:	ec06                	sd	ra,24(sp)
 1b8:	e822                	sd	s0,16(sp)
 1ba:	e426                	sd	s1,8(sp)
 1bc:	e04a                	sd	s2,0(sp)
 1be:	1000                	add	s0,sp,32
 1c0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c2:	4581                	li	a1,0
 1c4:	00000097          	auipc	ra,0x0
 1c8:	186080e7          	jalr	390(ra) # 34a <open>
  if(fd < 0)
 1cc:	02054563          	bltz	a0,1f6 <stat+0x42>
 1d0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1d2:	85ca                	mv	a1,s2
 1d4:	00000097          	auipc	ra,0x0
 1d8:	18e080e7          	jalr	398(ra) # 362 <fstat>
 1dc:	892a                	mv	s2,a0
  close(fd);
 1de:	8526                	mv	a0,s1
 1e0:	00000097          	auipc	ra,0x0
 1e4:	152080e7          	jalr	338(ra) # 332 <close>
  return r;
}
 1e8:	854a                	mv	a0,s2
 1ea:	60e2                	ld	ra,24(sp)
 1ec:	6442                	ld	s0,16(sp)
 1ee:	64a2                	ld	s1,8(sp)
 1f0:	6902                	ld	s2,0(sp)
 1f2:	6105                	add	sp,sp,32
 1f4:	8082                	ret
    return -1;
 1f6:	597d                	li	s2,-1
 1f8:	bfc5                	j	1e8 <stat+0x34>

00000000000001fa <atoi>:

int
atoi(const char *s)
{
 1fa:	1141                	add	sp,sp,-16
 1fc:	e422                	sd	s0,8(sp)
 1fe:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 200:	00054683          	lbu	a3,0(a0)
 204:	fd06879b          	addw	a5,a3,-48
 208:	0ff7f793          	zext.b	a5,a5
 20c:	4625                	li	a2,9
 20e:	02f66863          	bltu	a2,a5,23e <atoi+0x44>
 212:	872a                	mv	a4,a0
  n = 0;
 214:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 216:	0705                	add	a4,a4,1
 218:	0025179b          	sllw	a5,a0,0x2
 21c:	9fa9                	addw	a5,a5,a0
 21e:	0017979b          	sllw	a5,a5,0x1
 222:	9fb5                	addw	a5,a5,a3
 224:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 228:	00074683          	lbu	a3,0(a4)
 22c:	fd06879b          	addw	a5,a3,-48
 230:	0ff7f793          	zext.b	a5,a5
 234:	fef671e3          	bgeu	a2,a5,216 <atoi+0x1c>
  return n;
}
 238:	6422                	ld	s0,8(sp)
 23a:	0141                	add	sp,sp,16
 23c:	8082                	ret
  n = 0;
 23e:	4501                	li	a0,0
 240:	bfe5                	j	238 <atoi+0x3e>

0000000000000242 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 242:	1141                	add	sp,sp,-16
 244:	e422                	sd	s0,8(sp)
 246:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 248:	02b57463          	bgeu	a0,a1,270 <memmove+0x2e>
    while(n-- > 0)
 24c:	00c05f63          	blez	a2,26a <memmove+0x28>
 250:	1602                	sll	a2,a2,0x20
 252:	9201                	srl	a2,a2,0x20
 254:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 258:	872a                	mv	a4,a0
      *dst++ = *src++;
 25a:	0585                	add	a1,a1,1
 25c:	0705                	add	a4,a4,1
 25e:	fff5c683          	lbu	a3,-1(a1)
 262:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 266:	fee79ae3          	bne	a5,a4,25a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 26a:	6422                	ld	s0,8(sp)
 26c:	0141                	add	sp,sp,16
 26e:	8082                	ret
    dst += n;
 270:	00c50733          	add	a4,a0,a2
    src += n;
 274:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 276:	fec05ae3          	blez	a2,26a <memmove+0x28>
 27a:	fff6079b          	addw	a5,a2,-1
 27e:	1782                	sll	a5,a5,0x20
 280:	9381                	srl	a5,a5,0x20
 282:	fff7c793          	not	a5,a5
 286:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 288:	15fd                	add	a1,a1,-1
 28a:	177d                	add	a4,a4,-1
 28c:	0005c683          	lbu	a3,0(a1)
 290:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 294:	fee79ae3          	bne	a5,a4,288 <memmove+0x46>
 298:	bfc9                	j	26a <memmove+0x28>

000000000000029a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 29a:	1141                	add	sp,sp,-16
 29c:	e422                	sd	s0,8(sp)
 29e:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2a0:	ca05                	beqz	a2,2d0 <memcmp+0x36>
 2a2:	fff6069b          	addw	a3,a2,-1
 2a6:	1682                	sll	a3,a3,0x20
 2a8:	9281                	srl	a3,a3,0x20
 2aa:	0685                	add	a3,a3,1
 2ac:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2ae:	00054783          	lbu	a5,0(a0)
 2b2:	0005c703          	lbu	a4,0(a1)
 2b6:	00e79863          	bne	a5,a4,2c6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2ba:	0505                	add	a0,a0,1
    p2++;
 2bc:	0585                	add	a1,a1,1
  while (n-- > 0) {
 2be:	fed518e3          	bne	a0,a3,2ae <memcmp+0x14>
  }
  return 0;
 2c2:	4501                	li	a0,0
 2c4:	a019                	j	2ca <memcmp+0x30>
      return *p1 - *p2;
 2c6:	40e7853b          	subw	a0,a5,a4
}
 2ca:	6422                	ld	s0,8(sp)
 2cc:	0141                	add	sp,sp,16
 2ce:	8082                	ret
  return 0;
 2d0:	4501                	li	a0,0
 2d2:	bfe5                	j	2ca <memcmp+0x30>

00000000000002d4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2d4:	1141                	add	sp,sp,-16
 2d6:	e406                	sd	ra,8(sp)
 2d8:	e022                	sd	s0,0(sp)
 2da:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 2dc:	00000097          	auipc	ra,0x0
 2e0:	f66080e7          	jalr	-154(ra) # 242 <memmove>
}
 2e4:	60a2                	ld	ra,8(sp)
 2e6:	6402                	ld	s0,0(sp)
 2e8:	0141                	add	sp,sp,16
 2ea:	8082                	ret

00000000000002ec <ugetpid>:

int
ugetpid(void)
{
 2ec:	1141                	add	sp,sp,-16
 2ee:	e422                	sd	s0,8(sp)
 2f0:	0800                	add	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 2f2:	040007b7          	lui	a5,0x4000
}
 2f6:	17f5                	add	a5,a5,-3 # 3fffffd <base+0x3ffefed>
 2f8:	07b2                	sll	a5,a5,0xc
 2fa:	4388                	lw	a0,0(a5)
 2fc:	6422                	ld	s0,8(sp)
 2fe:	0141                	add	sp,sp,16
 300:	8082                	ret

0000000000000302 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 302:	4885                	li	a7,1
 ecall
 304:	00000073          	ecall
 ret
 308:	8082                	ret

000000000000030a <exit>:
.global exit
exit:
 li a7, SYS_exit
 30a:	4889                	li	a7,2
 ecall
 30c:	00000073          	ecall
 ret
 310:	8082                	ret

0000000000000312 <wait>:
.global wait
wait:
 li a7, SYS_wait
 312:	488d                	li	a7,3
 ecall
 314:	00000073          	ecall
 ret
 318:	8082                	ret

000000000000031a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 31a:	4891                	li	a7,4
 ecall
 31c:	00000073          	ecall
 ret
 320:	8082                	ret

0000000000000322 <read>:
.global read
read:
 li a7, SYS_read
 322:	4895                	li	a7,5
 ecall
 324:	00000073          	ecall
 ret
 328:	8082                	ret

000000000000032a <write>:
.global write
write:
 li a7, SYS_write
 32a:	48c1                	li	a7,16
 ecall
 32c:	00000073          	ecall
 ret
 330:	8082                	ret

0000000000000332 <close>:
.global close
close:
 li a7, SYS_close
 332:	48d5                	li	a7,21
 ecall
 334:	00000073          	ecall
 ret
 338:	8082                	ret

000000000000033a <kill>:
.global kill
kill:
 li a7, SYS_kill
 33a:	4899                	li	a7,6
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <exec>:
.global exec
exec:
 li a7, SYS_exec
 342:	489d                	li	a7,7
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <open>:
.global open
open:
 li a7, SYS_open
 34a:	48bd                	li	a7,15
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 352:	48c5                	li	a7,17
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 35a:	48c9                	li	a7,18
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 362:	48a1                	li	a7,8
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <link>:
.global link
link:
 li a7, SYS_link
 36a:	48cd                	li	a7,19
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 372:	48d1                	li	a7,20
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 37a:	48a5                	li	a7,9
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <dup>:
.global dup
dup:
 li a7, SYS_dup
 382:	48a9                	li	a7,10
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 38a:	48ad                	li	a7,11
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 392:	48b1                	li	a7,12
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 39a:	48b5                	li	a7,13
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3a2:	48b9                	li	a7,14
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <trace>:
.global trace
trace:
 li a7, SYS_trace
 3aa:	48d9                	li	a7,22
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 3b2:	48dd                	li	a7,23
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 3ba:	48e1                	li	a7,24
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <setpriority>:
.global setpriority
setpriority:
 li a7, SYS_setpriority
 3c2:	48e5                	li	a7,25
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3ca:	1101                	add	sp,sp,-32
 3cc:	ec06                	sd	ra,24(sp)
 3ce:	e822                	sd	s0,16(sp)
 3d0:	1000                	add	s0,sp,32
 3d2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3d6:	4605                	li	a2,1
 3d8:	fef40593          	add	a1,s0,-17
 3dc:	00000097          	auipc	ra,0x0
 3e0:	f4e080e7          	jalr	-178(ra) # 32a <write>
}
 3e4:	60e2                	ld	ra,24(sp)
 3e6:	6442                	ld	s0,16(sp)
 3e8:	6105                	add	sp,sp,32
 3ea:	8082                	ret

00000000000003ec <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3ec:	7139                	add	sp,sp,-64
 3ee:	fc06                	sd	ra,56(sp)
 3f0:	f822                	sd	s0,48(sp)
 3f2:	f426                	sd	s1,40(sp)
 3f4:	f04a                	sd	s2,32(sp)
 3f6:	ec4e                	sd	s3,24(sp)
 3f8:	0080                	add	s0,sp,64
 3fa:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3fc:	c299                	beqz	a3,402 <printint+0x16>
 3fe:	0805c963          	bltz	a1,490 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 402:	2581                	sext.w	a1,a1
  neg = 0;
 404:	4881                	li	a7,0
 406:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 40a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 40c:	2601                	sext.w	a2,a2
 40e:	00000517          	auipc	a0,0x0
 412:	48250513          	add	a0,a0,1154 # 890 <digits>
 416:	883a                	mv	a6,a4
 418:	2705                	addw	a4,a4,1
 41a:	02c5f7bb          	remuw	a5,a1,a2
 41e:	1782                	sll	a5,a5,0x20
 420:	9381                	srl	a5,a5,0x20
 422:	97aa                	add	a5,a5,a0
 424:	0007c783          	lbu	a5,0(a5)
 428:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 42c:	0005879b          	sext.w	a5,a1
 430:	02c5d5bb          	divuw	a1,a1,a2
 434:	0685                	add	a3,a3,1
 436:	fec7f0e3          	bgeu	a5,a2,416 <printint+0x2a>
  if(neg)
 43a:	00088c63          	beqz	a7,452 <printint+0x66>
    buf[i++] = '-';
 43e:	fd070793          	add	a5,a4,-48
 442:	00878733          	add	a4,a5,s0
 446:	02d00793          	li	a5,45
 44a:	fef70823          	sb	a5,-16(a4)
 44e:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 452:	02e05863          	blez	a4,482 <printint+0x96>
 456:	fc040793          	add	a5,s0,-64
 45a:	00e78933          	add	s2,a5,a4
 45e:	fff78993          	add	s3,a5,-1
 462:	99ba                	add	s3,s3,a4
 464:	377d                	addw	a4,a4,-1
 466:	1702                	sll	a4,a4,0x20
 468:	9301                	srl	a4,a4,0x20
 46a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 46e:	fff94583          	lbu	a1,-1(s2)
 472:	8526                	mv	a0,s1
 474:	00000097          	auipc	ra,0x0
 478:	f56080e7          	jalr	-170(ra) # 3ca <putc>
  while(--i >= 0)
 47c:	197d                	add	s2,s2,-1
 47e:	ff3918e3          	bne	s2,s3,46e <printint+0x82>
}
 482:	70e2                	ld	ra,56(sp)
 484:	7442                	ld	s0,48(sp)
 486:	74a2                	ld	s1,40(sp)
 488:	7902                	ld	s2,32(sp)
 48a:	69e2                	ld	s3,24(sp)
 48c:	6121                	add	sp,sp,64
 48e:	8082                	ret
    x = -xx;
 490:	40b005bb          	negw	a1,a1
    neg = 1;
 494:	4885                	li	a7,1
    x = -xx;
 496:	bf85                	j	406 <printint+0x1a>

0000000000000498 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 498:	715d                	add	sp,sp,-80
 49a:	e486                	sd	ra,72(sp)
 49c:	e0a2                	sd	s0,64(sp)
 49e:	fc26                	sd	s1,56(sp)
 4a0:	f84a                	sd	s2,48(sp)
 4a2:	f44e                	sd	s3,40(sp)
 4a4:	f052                	sd	s4,32(sp)
 4a6:	ec56                	sd	s5,24(sp)
 4a8:	e85a                	sd	s6,16(sp)
 4aa:	e45e                	sd	s7,8(sp)
 4ac:	e062                	sd	s8,0(sp)
 4ae:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4b0:	0005c903          	lbu	s2,0(a1)
 4b4:	18090c63          	beqz	s2,64c <vprintf+0x1b4>
 4b8:	8aaa                	mv	s5,a0
 4ba:	8bb2                	mv	s7,a2
 4bc:	00158493          	add	s1,a1,1
  state = 0;
 4c0:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4c2:	02500a13          	li	s4,37
 4c6:	4b55                	li	s6,21
 4c8:	a839                	j	4e6 <vprintf+0x4e>
        putc(fd, c);
 4ca:	85ca                	mv	a1,s2
 4cc:	8556                	mv	a0,s5
 4ce:	00000097          	auipc	ra,0x0
 4d2:	efc080e7          	jalr	-260(ra) # 3ca <putc>
 4d6:	a019                	j	4dc <vprintf+0x44>
    } else if(state == '%'){
 4d8:	01498d63          	beq	s3,s4,4f2 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 4dc:	0485                	add	s1,s1,1
 4de:	fff4c903          	lbu	s2,-1(s1)
 4e2:	16090563          	beqz	s2,64c <vprintf+0x1b4>
    if(state == 0){
 4e6:	fe0999e3          	bnez	s3,4d8 <vprintf+0x40>
      if(c == '%'){
 4ea:	ff4910e3          	bne	s2,s4,4ca <vprintf+0x32>
        state = '%';
 4ee:	89d2                	mv	s3,s4
 4f0:	b7f5                	j	4dc <vprintf+0x44>
      if(c == 'd'){
 4f2:	13490263          	beq	s2,s4,616 <vprintf+0x17e>
 4f6:	f9d9079b          	addw	a5,s2,-99
 4fa:	0ff7f793          	zext.b	a5,a5
 4fe:	12fb6563          	bltu	s6,a5,628 <vprintf+0x190>
 502:	f9d9079b          	addw	a5,s2,-99
 506:	0ff7f713          	zext.b	a4,a5
 50a:	10eb6f63          	bltu	s6,a4,628 <vprintf+0x190>
 50e:	00271793          	sll	a5,a4,0x2
 512:	00000717          	auipc	a4,0x0
 516:	32670713          	add	a4,a4,806 # 838 <malloc+0xee>
 51a:	97ba                	add	a5,a5,a4
 51c:	439c                	lw	a5,0(a5)
 51e:	97ba                	add	a5,a5,a4
 520:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 522:	008b8913          	add	s2,s7,8
 526:	4685                	li	a3,1
 528:	4629                	li	a2,10
 52a:	000ba583          	lw	a1,0(s7)
 52e:	8556                	mv	a0,s5
 530:	00000097          	auipc	ra,0x0
 534:	ebc080e7          	jalr	-324(ra) # 3ec <printint>
 538:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 53a:	4981                	li	s3,0
 53c:	b745                	j	4dc <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 53e:	008b8913          	add	s2,s7,8
 542:	4681                	li	a3,0
 544:	4629                	li	a2,10
 546:	000ba583          	lw	a1,0(s7)
 54a:	8556                	mv	a0,s5
 54c:	00000097          	auipc	ra,0x0
 550:	ea0080e7          	jalr	-352(ra) # 3ec <printint>
 554:	8bca                	mv	s7,s2
      state = 0;
 556:	4981                	li	s3,0
 558:	b751                	j	4dc <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 55a:	008b8913          	add	s2,s7,8
 55e:	4681                	li	a3,0
 560:	4641                	li	a2,16
 562:	000ba583          	lw	a1,0(s7)
 566:	8556                	mv	a0,s5
 568:	00000097          	auipc	ra,0x0
 56c:	e84080e7          	jalr	-380(ra) # 3ec <printint>
 570:	8bca                	mv	s7,s2
      state = 0;
 572:	4981                	li	s3,0
 574:	b7a5                	j	4dc <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 576:	008b8c13          	add	s8,s7,8
 57a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 57e:	03000593          	li	a1,48
 582:	8556                	mv	a0,s5
 584:	00000097          	auipc	ra,0x0
 588:	e46080e7          	jalr	-442(ra) # 3ca <putc>
  putc(fd, 'x');
 58c:	07800593          	li	a1,120
 590:	8556                	mv	a0,s5
 592:	00000097          	auipc	ra,0x0
 596:	e38080e7          	jalr	-456(ra) # 3ca <putc>
 59a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 59c:	00000b97          	auipc	s7,0x0
 5a0:	2f4b8b93          	add	s7,s7,756 # 890 <digits>
 5a4:	03c9d793          	srl	a5,s3,0x3c
 5a8:	97de                	add	a5,a5,s7
 5aa:	0007c583          	lbu	a1,0(a5)
 5ae:	8556                	mv	a0,s5
 5b0:	00000097          	auipc	ra,0x0
 5b4:	e1a080e7          	jalr	-486(ra) # 3ca <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5b8:	0992                	sll	s3,s3,0x4
 5ba:	397d                	addw	s2,s2,-1
 5bc:	fe0914e3          	bnez	s2,5a4 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 5c0:	8be2                	mv	s7,s8
      state = 0;
 5c2:	4981                	li	s3,0
 5c4:	bf21                	j	4dc <vprintf+0x44>
        s = va_arg(ap, char*);
 5c6:	008b8993          	add	s3,s7,8
 5ca:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 5ce:	02090163          	beqz	s2,5f0 <vprintf+0x158>
        while(*s != 0){
 5d2:	00094583          	lbu	a1,0(s2)
 5d6:	c9a5                	beqz	a1,646 <vprintf+0x1ae>
          putc(fd, *s);
 5d8:	8556                	mv	a0,s5
 5da:	00000097          	auipc	ra,0x0
 5de:	df0080e7          	jalr	-528(ra) # 3ca <putc>
          s++;
 5e2:	0905                	add	s2,s2,1
        while(*s != 0){
 5e4:	00094583          	lbu	a1,0(s2)
 5e8:	f9e5                	bnez	a1,5d8 <vprintf+0x140>
        s = va_arg(ap, char*);
 5ea:	8bce                	mv	s7,s3
      state = 0;
 5ec:	4981                	li	s3,0
 5ee:	b5fd                	j	4dc <vprintf+0x44>
          s = "(null)";
 5f0:	00000917          	auipc	s2,0x0
 5f4:	24090913          	add	s2,s2,576 # 830 <malloc+0xe6>
        while(*s != 0){
 5f8:	02800593          	li	a1,40
 5fc:	bff1                	j	5d8 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 5fe:	008b8913          	add	s2,s7,8
 602:	000bc583          	lbu	a1,0(s7)
 606:	8556                	mv	a0,s5
 608:	00000097          	auipc	ra,0x0
 60c:	dc2080e7          	jalr	-574(ra) # 3ca <putc>
 610:	8bca                	mv	s7,s2
      state = 0;
 612:	4981                	li	s3,0
 614:	b5e1                	j	4dc <vprintf+0x44>
        putc(fd, c);
 616:	02500593          	li	a1,37
 61a:	8556                	mv	a0,s5
 61c:	00000097          	auipc	ra,0x0
 620:	dae080e7          	jalr	-594(ra) # 3ca <putc>
      state = 0;
 624:	4981                	li	s3,0
 626:	bd5d                	j	4dc <vprintf+0x44>
        putc(fd, '%');
 628:	02500593          	li	a1,37
 62c:	8556                	mv	a0,s5
 62e:	00000097          	auipc	ra,0x0
 632:	d9c080e7          	jalr	-612(ra) # 3ca <putc>
        putc(fd, c);
 636:	85ca                	mv	a1,s2
 638:	8556                	mv	a0,s5
 63a:	00000097          	auipc	ra,0x0
 63e:	d90080e7          	jalr	-624(ra) # 3ca <putc>
      state = 0;
 642:	4981                	li	s3,0
 644:	bd61                	j	4dc <vprintf+0x44>
        s = va_arg(ap, char*);
 646:	8bce                	mv	s7,s3
      state = 0;
 648:	4981                	li	s3,0
 64a:	bd49                	j	4dc <vprintf+0x44>
    }
  }
}
 64c:	60a6                	ld	ra,72(sp)
 64e:	6406                	ld	s0,64(sp)
 650:	74e2                	ld	s1,56(sp)
 652:	7942                	ld	s2,48(sp)
 654:	79a2                	ld	s3,40(sp)
 656:	7a02                	ld	s4,32(sp)
 658:	6ae2                	ld	s5,24(sp)
 65a:	6b42                	ld	s6,16(sp)
 65c:	6ba2                	ld	s7,8(sp)
 65e:	6c02                	ld	s8,0(sp)
 660:	6161                	add	sp,sp,80
 662:	8082                	ret

0000000000000664 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 664:	715d                	add	sp,sp,-80
 666:	ec06                	sd	ra,24(sp)
 668:	e822                	sd	s0,16(sp)
 66a:	1000                	add	s0,sp,32
 66c:	e010                	sd	a2,0(s0)
 66e:	e414                	sd	a3,8(s0)
 670:	e818                	sd	a4,16(s0)
 672:	ec1c                	sd	a5,24(s0)
 674:	03043023          	sd	a6,32(s0)
 678:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 67c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 680:	8622                	mv	a2,s0
 682:	00000097          	auipc	ra,0x0
 686:	e16080e7          	jalr	-490(ra) # 498 <vprintf>
}
 68a:	60e2                	ld	ra,24(sp)
 68c:	6442                	ld	s0,16(sp)
 68e:	6161                	add	sp,sp,80
 690:	8082                	ret

0000000000000692 <printf>:

void
printf(const char *fmt, ...)
{
 692:	711d                	add	sp,sp,-96
 694:	ec06                	sd	ra,24(sp)
 696:	e822                	sd	s0,16(sp)
 698:	1000                	add	s0,sp,32
 69a:	e40c                	sd	a1,8(s0)
 69c:	e810                	sd	a2,16(s0)
 69e:	ec14                	sd	a3,24(s0)
 6a0:	f018                	sd	a4,32(s0)
 6a2:	f41c                	sd	a5,40(s0)
 6a4:	03043823          	sd	a6,48(s0)
 6a8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6ac:	00840613          	add	a2,s0,8
 6b0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6b4:	85aa                	mv	a1,a0
 6b6:	4505                	li	a0,1
 6b8:	00000097          	auipc	ra,0x0
 6bc:	de0080e7          	jalr	-544(ra) # 498 <vprintf>
}
 6c0:	60e2                	ld	ra,24(sp)
 6c2:	6442                	ld	s0,16(sp)
 6c4:	6125                	add	sp,sp,96
 6c6:	8082                	ret

00000000000006c8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c8:	1141                	add	sp,sp,-16
 6ca:	e422                	sd	s0,8(sp)
 6cc:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6ce:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d2:	00001797          	auipc	a5,0x1
 6d6:	92e7b783          	ld	a5,-1746(a5) # 1000 <freep>
 6da:	a02d                	j	704 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6dc:	4618                	lw	a4,8(a2)
 6de:	9f2d                	addw	a4,a4,a1
 6e0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6e4:	6398                	ld	a4,0(a5)
 6e6:	6310                	ld	a2,0(a4)
 6e8:	a83d                	j	726 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6ea:	ff852703          	lw	a4,-8(a0)
 6ee:	9f31                	addw	a4,a4,a2
 6f0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 6f2:	ff053683          	ld	a3,-16(a0)
 6f6:	a091                	j	73a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f8:	6398                	ld	a4,0(a5)
 6fa:	00e7e463          	bltu	a5,a4,702 <free+0x3a>
 6fe:	00e6ea63          	bltu	a3,a4,712 <free+0x4a>
{
 702:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 704:	fed7fae3          	bgeu	a5,a3,6f8 <free+0x30>
 708:	6398                	ld	a4,0(a5)
 70a:	00e6e463          	bltu	a3,a4,712 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 70e:	fee7eae3          	bltu	a5,a4,702 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 712:	ff852583          	lw	a1,-8(a0)
 716:	6390                	ld	a2,0(a5)
 718:	02059813          	sll	a6,a1,0x20
 71c:	01c85713          	srl	a4,a6,0x1c
 720:	9736                	add	a4,a4,a3
 722:	fae60de3          	beq	a2,a4,6dc <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 726:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 72a:	4790                	lw	a2,8(a5)
 72c:	02061593          	sll	a1,a2,0x20
 730:	01c5d713          	srl	a4,a1,0x1c
 734:	973e                	add	a4,a4,a5
 736:	fae68ae3          	beq	a3,a4,6ea <free+0x22>
    p->s.ptr = bp->s.ptr;
 73a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 73c:	00001717          	auipc	a4,0x1
 740:	8cf73223          	sd	a5,-1852(a4) # 1000 <freep>
}
 744:	6422                	ld	s0,8(sp)
 746:	0141                	add	sp,sp,16
 748:	8082                	ret

000000000000074a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 74a:	7139                	add	sp,sp,-64
 74c:	fc06                	sd	ra,56(sp)
 74e:	f822                	sd	s0,48(sp)
 750:	f426                	sd	s1,40(sp)
 752:	f04a                	sd	s2,32(sp)
 754:	ec4e                	sd	s3,24(sp)
 756:	e852                	sd	s4,16(sp)
 758:	e456                	sd	s5,8(sp)
 75a:	e05a                	sd	s6,0(sp)
 75c:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 75e:	02051493          	sll	s1,a0,0x20
 762:	9081                	srl	s1,s1,0x20
 764:	04bd                	add	s1,s1,15
 766:	8091                	srl	s1,s1,0x4
 768:	0014899b          	addw	s3,s1,1
 76c:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 76e:	00001517          	auipc	a0,0x1
 772:	89253503          	ld	a0,-1902(a0) # 1000 <freep>
 776:	c515                	beqz	a0,7a2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 778:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 77a:	4798                	lw	a4,8(a5)
 77c:	02977f63          	bgeu	a4,s1,7ba <malloc+0x70>
  if(nu < 4096)
 780:	8a4e                	mv	s4,s3
 782:	0009871b          	sext.w	a4,s3
 786:	6685                	lui	a3,0x1
 788:	00d77363          	bgeu	a4,a3,78e <malloc+0x44>
 78c:	6a05                	lui	s4,0x1
 78e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 792:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 796:	00001917          	auipc	s2,0x1
 79a:	86a90913          	add	s2,s2,-1942 # 1000 <freep>
  if(p == (char*)-1)
 79e:	5afd                	li	s5,-1
 7a0:	a895                	j	814 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 7a2:	00001797          	auipc	a5,0x1
 7a6:	86e78793          	add	a5,a5,-1938 # 1010 <base>
 7aa:	00001717          	auipc	a4,0x1
 7ae:	84f73b23          	sd	a5,-1962(a4) # 1000 <freep>
 7b2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7b4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7b8:	b7e1                	j	780 <malloc+0x36>
      if(p->s.size == nunits)
 7ba:	02e48c63          	beq	s1,a4,7f2 <malloc+0xa8>
        p->s.size -= nunits;
 7be:	4137073b          	subw	a4,a4,s3
 7c2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7c4:	02071693          	sll	a3,a4,0x20
 7c8:	01c6d713          	srl	a4,a3,0x1c
 7cc:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7ce:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7d2:	00001717          	auipc	a4,0x1
 7d6:	82a73723          	sd	a0,-2002(a4) # 1000 <freep>
      return (void*)(p + 1);
 7da:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7de:	70e2                	ld	ra,56(sp)
 7e0:	7442                	ld	s0,48(sp)
 7e2:	74a2                	ld	s1,40(sp)
 7e4:	7902                	ld	s2,32(sp)
 7e6:	69e2                	ld	s3,24(sp)
 7e8:	6a42                	ld	s4,16(sp)
 7ea:	6aa2                	ld	s5,8(sp)
 7ec:	6b02                	ld	s6,0(sp)
 7ee:	6121                	add	sp,sp,64
 7f0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 7f2:	6398                	ld	a4,0(a5)
 7f4:	e118                	sd	a4,0(a0)
 7f6:	bff1                	j	7d2 <malloc+0x88>
  hp->s.size = nu;
 7f8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 7fc:	0541                	add	a0,a0,16
 7fe:	00000097          	auipc	ra,0x0
 802:	eca080e7          	jalr	-310(ra) # 6c8 <free>
  return freep;
 806:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 80a:	d971                	beqz	a0,7de <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 80c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 80e:	4798                	lw	a4,8(a5)
 810:	fa9775e3          	bgeu	a4,s1,7ba <malloc+0x70>
    if(p == freep)
 814:	00093703          	ld	a4,0(s2)
 818:	853e                	mv	a0,a5
 81a:	fef719e3          	bne	a4,a5,80c <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 81e:	8552                	mv	a0,s4
 820:	00000097          	auipc	ra,0x0
 824:	b72080e7          	jalr	-1166(ra) # 392 <sbrk>
  if(p == (char*)-1)
 828:	fd5518e3          	bne	a0,s5,7f8 <malloc+0xae>
        return 0;
 82c:	4501                	li	a0,0
 82e:	bf45                	j	7de <malloc+0x94>
