
user/_rm:     file format elf64-littleriscv


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
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	add	s0,sp,32
  int i;

  if(argc < 2){
   c:	4785                	li	a5,1
   e:	02a7d763          	bge	a5,a0,3c <main+0x3c>
  12:	00858493          	add	s1,a1,8
  16:	ffe5091b          	addw	s2,a0,-2
  1a:	02091793          	sll	a5,s2,0x20
  1e:	01d7d913          	srl	s2,a5,0x1d
  22:	05c1                	add	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "Usage: rm files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
  26:	6088                	ld	a0,0(s1)
  28:	00000097          	auipc	ra,0x0
  2c:	37e080e7          	jalr	894(ra) # 3a6 <unlink>
  30:	02054463          	bltz	a0,58 <main+0x58>
  for(i = 1; i < argc; i++){
  34:	04a1                	add	s1,s1,8
  36:	ff2498e3          	bne	s1,s2,26 <main+0x26>
  3a:	a80d                	j	6c <main+0x6c>
    fprintf(2, "Usage: rm files...\n");
  3c:	00001597          	auipc	a1,0x1
  40:	84458593          	add	a1,a1,-1980 # 880 <malloc+0xea>
  44:	4509                	li	a0,2
  46:	00000097          	auipc	ra,0x0
  4a:	66a080e7          	jalr	1642(ra) # 6b0 <fprintf>
    exit(1);
  4e:	4505                	li	a0,1
  50:	00000097          	auipc	ra,0x0
  54:	306080e7          	jalr	774(ra) # 356 <exit>
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
  58:	6090                	ld	a2,0(s1)
  5a:	00001597          	auipc	a1,0x1
  5e:	83e58593          	add	a1,a1,-1986 # 898 <malloc+0x102>
  62:	4509                	li	a0,2
  64:	00000097          	auipc	ra,0x0
  68:	64c080e7          	jalr	1612(ra) # 6b0 <fprintf>
      break;
    }
  }

  exit(0);
  6c:	4501                	li	a0,0
  6e:	00000097          	auipc	ra,0x0
  72:	2e8080e7          	jalr	744(ra) # 356 <exit>

0000000000000076 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  76:	1141                	add	sp,sp,-16
  78:	e406                	sd	ra,8(sp)
  7a:	e022                	sd	s0,0(sp)
  7c:	0800                	add	s0,sp,16
  extern int main();
  main();
  7e:	00000097          	auipc	ra,0x0
  82:	f82080e7          	jalr	-126(ra) # 0 <main>
  exit(0);
  86:	4501                	li	a0,0
  88:	00000097          	auipc	ra,0x0
  8c:	2ce080e7          	jalr	718(ra) # 356 <exit>

0000000000000090 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  90:	1141                	add	sp,sp,-16
  92:	e422                	sd	s0,8(sp)
  94:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  96:	87aa                	mv	a5,a0
  98:	0585                	add	a1,a1,1
  9a:	0785                	add	a5,a5,1
  9c:	fff5c703          	lbu	a4,-1(a1)
  a0:	fee78fa3          	sb	a4,-1(a5)
  a4:	fb75                	bnez	a4,98 <strcpy+0x8>
    ;
  return os;
}
  a6:	6422                	ld	s0,8(sp)
  a8:	0141                	add	sp,sp,16
  aa:	8082                	ret

00000000000000ac <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ac:	1141                	add	sp,sp,-16
  ae:	e422                	sd	s0,8(sp)
  b0:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  b2:	00054783          	lbu	a5,0(a0)
  b6:	cb91                	beqz	a5,ca <strcmp+0x1e>
  b8:	0005c703          	lbu	a4,0(a1)
  bc:	00f71763          	bne	a4,a5,ca <strcmp+0x1e>
    p++, q++;
  c0:	0505                	add	a0,a0,1
  c2:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  c4:	00054783          	lbu	a5,0(a0)
  c8:	fbe5                	bnez	a5,b8 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  ca:	0005c503          	lbu	a0,0(a1)
}
  ce:	40a7853b          	subw	a0,a5,a0
  d2:	6422                	ld	s0,8(sp)
  d4:	0141                	add	sp,sp,16
  d6:	8082                	ret

00000000000000d8 <strlen>:

uint
strlen(const char *s)
{
  d8:	1141                	add	sp,sp,-16
  da:	e422                	sd	s0,8(sp)
  dc:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  de:	00054783          	lbu	a5,0(a0)
  e2:	cf91                	beqz	a5,fe <strlen+0x26>
  e4:	0505                	add	a0,a0,1
  e6:	87aa                	mv	a5,a0
  e8:	86be                	mv	a3,a5
  ea:	0785                	add	a5,a5,1
  ec:	fff7c703          	lbu	a4,-1(a5)
  f0:	ff65                	bnez	a4,e8 <strlen+0x10>
  f2:	40a6853b          	subw	a0,a3,a0
  f6:	2505                	addw	a0,a0,1
    ;
  return n;
}
  f8:	6422                	ld	s0,8(sp)
  fa:	0141                	add	sp,sp,16
  fc:	8082                	ret
  for(n = 0; s[n]; n++)
  fe:	4501                	li	a0,0
 100:	bfe5                	j	f8 <strlen+0x20>

0000000000000102 <memset>:

void*
memset(void *dst, int c, uint n)
{
 102:	1141                	add	sp,sp,-16
 104:	e422                	sd	s0,8(sp)
 106:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 108:	ca19                	beqz	a2,11e <memset+0x1c>
 10a:	87aa                	mv	a5,a0
 10c:	1602                	sll	a2,a2,0x20
 10e:	9201                	srl	a2,a2,0x20
 110:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 114:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 118:	0785                	add	a5,a5,1
 11a:	fee79de3          	bne	a5,a4,114 <memset+0x12>
  }
  return dst;
}
 11e:	6422                	ld	s0,8(sp)
 120:	0141                	add	sp,sp,16
 122:	8082                	ret

0000000000000124 <strchr>:

char*
strchr(const char *s, char c)
{
 124:	1141                	add	sp,sp,-16
 126:	e422                	sd	s0,8(sp)
 128:	0800                	add	s0,sp,16
  for(; *s; s++)
 12a:	00054783          	lbu	a5,0(a0)
 12e:	cb99                	beqz	a5,144 <strchr+0x20>
    if(*s == c)
 130:	00f58763          	beq	a1,a5,13e <strchr+0x1a>
  for(; *s; s++)
 134:	0505                	add	a0,a0,1
 136:	00054783          	lbu	a5,0(a0)
 13a:	fbfd                	bnez	a5,130 <strchr+0xc>
      return (char*)s;
  return 0;
 13c:	4501                	li	a0,0
}
 13e:	6422                	ld	s0,8(sp)
 140:	0141                	add	sp,sp,16
 142:	8082                	ret
  return 0;
 144:	4501                	li	a0,0
 146:	bfe5                	j	13e <strchr+0x1a>

0000000000000148 <strstr>:

char*
strstr(const char *str, const char *substr)
{
 148:	1141                	add	sp,sp,-16
 14a:	e422                	sd	s0,8(sp)
 14c:	0800                	add	s0,sp,16
  const char *a, *b = substr;
  if (*b == 0)
 14e:	0005c803          	lbu	a6,0(a1)
 152:	02080a63          	beqz	a6,186 <strstr+0x3e>
    return (char*)str;
  for( ; *str != 0; str += 1) {
 156:	00054783          	lbu	a5,0(a0)
 15a:	e799                	bnez	a5,168 <strstr+0x20>
      if (*a++ != *b++)
        break;
    }
    b = substr;
  }
  return 0;
 15c:	4501                	li	a0,0
 15e:	a025                	j	186 <strstr+0x3e>
  for( ; *str != 0; str += 1) {
 160:	0505                	add	a0,a0,1
 162:	00054783          	lbu	a5,0(a0)
 166:	cf99                	beqz	a5,184 <strstr+0x3c>
    if (*str != *b)
 168:	fef81ce3          	bne	a6,a5,160 <strstr+0x18>
 16c:	87ae                	mv	a5,a1
 16e:	86aa                	mv	a3,a0
      if (*b == 0)
 170:	0007c703          	lbu	a4,0(a5)
 174:	cb09                	beqz	a4,186 <strstr+0x3e>
      if (*a++ != *b++)
 176:	0685                	add	a3,a3,1
 178:	0785                	add	a5,a5,1
 17a:	fff6c603          	lbu	a2,-1(a3)
 17e:	fee609e3          	beq	a2,a4,170 <strstr+0x28>
 182:	bff9                	j	160 <strstr+0x18>
  return 0;
 184:	4501                	li	a0,0
}
 186:	6422                	ld	s0,8(sp)
 188:	0141                	add	sp,sp,16
 18a:	8082                	ret

000000000000018c <gets>:

char*
gets(char *buf, int max)
{
 18c:	711d                	add	sp,sp,-96
 18e:	ec86                	sd	ra,88(sp)
 190:	e8a2                	sd	s0,80(sp)
 192:	e4a6                	sd	s1,72(sp)
 194:	e0ca                	sd	s2,64(sp)
 196:	fc4e                	sd	s3,56(sp)
 198:	f852                	sd	s4,48(sp)
 19a:	f456                	sd	s5,40(sp)
 19c:	f05a                	sd	s6,32(sp)
 19e:	ec5e                	sd	s7,24(sp)
 1a0:	1080                	add	s0,sp,96
 1a2:	8baa                	mv	s7,a0
 1a4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a6:	892a                	mv	s2,a0
 1a8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1aa:	4aa9                	li	s5,10
 1ac:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1ae:	89a6                	mv	s3,s1
 1b0:	2485                	addw	s1,s1,1
 1b2:	0344d863          	bge	s1,s4,1e2 <gets+0x56>
    cc = read(0, &c, 1);
 1b6:	4605                	li	a2,1
 1b8:	faf40593          	add	a1,s0,-81
 1bc:	4501                	li	a0,0
 1be:	00000097          	auipc	ra,0x0
 1c2:	1b0080e7          	jalr	432(ra) # 36e <read>
    if(cc < 1)
 1c6:	00a05e63          	blez	a0,1e2 <gets+0x56>
    buf[i++] = c;
 1ca:	faf44783          	lbu	a5,-81(s0)
 1ce:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1d2:	01578763          	beq	a5,s5,1e0 <gets+0x54>
 1d6:	0905                	add	s2,s2,1
 1d8:	fd679be3          	bne	a5,s6,1ae <gets+0x22>
  for(i=0; i+1 < max; ){
 1dc:	89a6                	mv	s3,s1
 1de:	a011                	j	1e2 <gets+0x56>
 1e0:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1e2:	99de                	add	s3,s3,s7
 1e4:	00098023          	sb	zero,0(s3)
  return buf;
}
 1e8:	855e                	mv	a0,s7
 1ea:	60e6                	ld	ra,88(sp)
 1ec:	6446                	ld	s0,80(sp)
 1ee:	64a6                	ld	s1,72(sp)
 1f0:	6906                	ld	s2,64(sp)
 1f2:	79e2                	ld	s3,56(sp)
 1f4:	7a42                	ld	s4,48(sp)
 1f6:	7aa2                	ld	s5,40(sp)
 1f8:	7b02                	ld	s6,32(sp)
 1fa:	6be2                	ld	s7,24(sp)
 1fc:	6125                	add	sp,sp,96
 1fe:	8082                	ret

0000000000000200 <stat>:

int
stat(const char *n, struct stat *st)
{
 200:	1101                	add	sp,sp,-32
 202:	ec06                	sd	ra,24(sp)
 204:	e822                	sd	s0,16(sp)
 206:	e426                	sd	s1,8(sp)
 208:	e04a                	sd	s2,0(sp)
 20a:	1000                	add	s0,sp,32
 20c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 20e:	4581                	li	a1,0
 210:	00000097          	auipc	ra,0x0
 214:	186080e7          	jalr	390(ra) # 396 <open>
  if(fd < 0)
 218:	02054563          	bltz	a0,242 <stat+0x42>
 21c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 21e:	85ca                	mv	a1,s2
 220:	00000097          	auipc	ra,0x0
 224:	18e080e7          	jalr	398(ra) # 3ae <fstat>
 228:	892a                	mv	s2,a0
  close(fd);
 22a:	8526                	mv	a0,s1
 22c:	00000097          	auipc	ra,0x0
 230:	152080e7          	jalr	338(ra) # 37e <close>
  return r;
}
 234:	854a                	mv	a0,s2
 236:	60e2                	ld	ra,24(sp)
 238:	6442                	ld	s0,16(sp)
 23a:	64a2                	ld	s1,8(sp)
 23c:	6902                	ld	s2,0(sp)
 23e:	6105                	add	sp,sp,32
 240:	8082                	ret
    return -1;
 242:	597d                	li	s2,-1
 244:	bfc5                	j	234 <stat+0x34>

0000000000000246 <atoi>:

int
atoi(const char *s)
{
 246:	1141                	add	sp,sp,-16
 248:	e422                	sd	s0,8(sp)
 24a:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 24c:	00054683          	lbu	a3,0(a0)
 250:	fd06879b          	addw	a5,a3,-48
 254:	0ff7f793          	zext.b	a5,a5
 258:	4625                	li	a2,9
 25a:	02f66863          	bltu	a2,a5,28a <atoi+0x44>
 25e:	872a                	mv	a4,a0
  n = 0;
 260:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 262:	0705                	add	a4,a4,1
 264:	0025179b          	sllw	a5,a0,0x2
 268:	9fa9                	addw	a5,a5,a0
 26a:	0017979b          	sllw	a5,a5,0x1
 26e:	9fb5                	addw	a5,a5,a3
 270:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 274:	00074683          	lbu	a3,0(a4)
 278:	fd06879b          	addw	a5,a3,-48
 27c:	0ff7f793          	zext.b	a5,a5
 280:	fef671e3          	bgeu	a2,a5,262 <atoi+0x1c>
  return n;
}
 284:	6422                	ld	s0,8(sp)
 286:	0141                	add	sp,sp,16
 288:	8082                	ret
  n = 0;
 28a:	4501                	li	a0,0
 28c:	bfe5                	j	284 <atoi+0x3e>

000000000000028e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 28e:	1141                	add	sp,sp,-16
 290:	e422                	sd	s0,8(sp)
 292:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 294:	02b57463          	bgeu	a0,a1,2bc <memmove+0x2e>
    while(n-- > 0)
 298:	00c05f63          	blez	a2,2b6 <memmove+0x28>
 29c:	1602                	sll	a2,a2,0x20
 29e:	9201                	srl	a2,a2,0x20
 2a0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2a4:	872a                	mv	a4,a0
      *dst++ = *src++;
 2a6:	0585                	add	a1,a1,1
 2a8:	0705                	add	a4,a4,1
 2aa:	fff5c683          	lbu	a3,-1(a1)
 2ae:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2b2:	fee79ae3          	bne	a5,a4,2a6 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2b6:	6422                	ld	s0,8(sp)
 2b8:	0141                	add	sp,sp,16
 2ba:	8082                	ret
    dst += n;
 2bc:	00c50733          	add	a4,a0,a2
    src += n;
 2c0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2c2:	fec05ae3          	blez	a2,2b6 <memmove+0x28>
 2c6:	fff6079b          	addw	a5,a2,-1
 2ca:	1782                	sll	a5,a5,0x20
 2cc:	9381                	srl	a5,a5,0x20
 2ce:	fff7c793          	not	a5,a5
 2d2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2d4:	15fd                	add	a1,a1,-1
 2d6:	177d                	add	a4,a4,-1
 2d8:	0005c683          	lbu	a3,0(a1)
 2dc:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2e0:	fee79ae3          	bne	a5,a4,2d4 <memmove+0x46>
 2e4:	bfc9                	j	2b6 <memmove+0x28>

00000000000002e6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2e6:	1141                	add	sp,sp,-16
 2e8:	e422                	sd	s0,8(sp)
 2ea:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2ec:	ca05                	beqz	a2,31c <memcmp+0x36>
 2ee:	fff6069b          	addw	a3,a2,-1
 2f2:	1682                	sll	a3,a3,0x20
 2f4:	9281                	srl	a3,a3,0x20
 2f6:	0685                	add	a3,a3,1
 2f8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2fa:	00054783          	lbu	a5,0(a0)
 2fe:	0005c703          	lbu	a4,0(a1)
 302:	00e79863          	bne	a5,a4,312 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 306:	0505                	add	a0,a0,1
    p2++;
 308:	0585                	add	a1,a1,1
  while (n-- > 0) {
 30a:	fed518e3          	bne	a0,a3,2fa <memcmp+0x14>
  }
  return 0;
 30e:	4501                	li	a0,0
 310:	a019                	j	316 <memcmp+0x30>
      return *p1 - *p2;
 312:	40e7853b          	subw	a0,a5,a4
}
 316:	6422                	ld	s0,8(sp)
 318:	0141                	add	sp,sp,16
 31a:	8082                	ret
  return 0;
 31c:	4501                	li	a0,0
 31e:	bfe5                	j	316 <memcmp+0x30>

0000000000000320 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 320:	1141                	add	sp,sp,-16
 322:	e406                	sd	ra,8(sp)
 324:	e022                	sd	s0,0(sp)
 326:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 328:	00000097          	auipc	ra,0x0
 32c:	f66080e7          	jalr	-154(ra) # 28e <memmove>
}
 330:	60a2                	ld	ra,8(sp)
 332:	6402                	ld	s0,0(sp)
 334:	0141                	add	sp,sp,16
 336:	8082                	ret

0000000000000338 <ugetpid>:

int
ugetpid(void)
{
 338:	1141                	add	sp,sp,-16
 33a:	e422                	sd	s0,8(sp)
 33c:	0800                	add	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 33e:	040007b7          	lui	a5,0x4000
}
 342:	17f5                	add	a5,a5,-3 # 3fffffd <base+0x3ffefed>
 344:	07b2                	sll	a5,a5,0xc
 346:	4388                	lw	a0,0(a5)
 348:	6422                	ld	s0,8(sp)
 34a:	0141                	add	sp,sp,16
 34c:	8082                	ret

000000000000034e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 34e:	4885                	li	a7,1
 ecall
 350:	00000073          	ecall
 ret
 354:	8082                	ret

0000000000000356 <exit>:
.global exit
exit:
 li a7, SYS_exit
 356:	4889                	li	a7,2
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <wait>:
.global wait
wait:
 li a7, SYS_wait
 35e:	488d                	li	a7,3
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 366:	4891                	li	a7,4
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <read>:
.global read
read:
 li a7, SYS_read
 36e:	4895                	li	a7,5
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <write>:
.global write
write:
 li a7, SYS_write
 376:	48c1                	li	a7,16
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <close>:
.global close
close:
 li a7, SYS_close
 37e:	48d5                	li	a7,21
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <kill>:
.global kill
kill:
 li a7, SYS_kill
 386:	4899                	li	a7,6
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <exec>:
.global exec
exec:
 li a7, SYS_exec
 38e:	489d                	li	a7,7
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <open>:
.global open
open:
 li a7, SYS_open
 396:	48bd                	li	a7,15
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 39e:	48c5                	li	a7,17
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3a6:	48c9                	li	a7,18
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3ae:	48a1                	li	a7,8
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <link>:
.global link
link:
 li a7, SYS_link
 3b6:	48cd                	li	a7,19
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3be:	48d1                	li	a7,20
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3c6:	48a5                	li	a7,9
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <dup>:
.global dup
dup:
 li a7, SYS_dup
 3ce:	48a9                	li	a7,10
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3d6:	48ad                	li	a7,11
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3de:	48b1                	li	a7,12
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3e6:	48b5                	li	a7,13
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3ee:	48b9                	li	a7,14
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <trace>:
.global trace
trace:
 li a7, SYS_trace
 3f6:	48d9                	li	a7,22
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 3fe:	48dd                	li	a7,23
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 406:	48e1                	li	a7,24
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <setpriority>:
.global setpriority
setpriority:
 li a7, SYS_setpriority
 40e:	48e5                	li	a7,25
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 416:	1101                	add	sp,sp,-32
 418:	ec06                	sd	ra,24(sp)
 41a:	e822                	sd	s0,16(sp)
 41c:	1000                	add	s0,sp,32
 41e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 422:	4605                	li	a2,1
 424:	fef40593          	add	a1,s0,-17
 428:	00000097          	auipc	ra,0x0
 42c:	f4e080e7          	jalr	-178(ra) # 376 <write>
}
 430:	60e2                	ld	ra,24(sp)
 432:	6442                	ld	s0,16(sp)
 434:	6105                	add	sp,sp,32
 436:	8082                	ret

0000000000000438 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 438:	7139                	add	sp,sp,-64
 43a:	fc06                	sd	ra,56(sp)
 43c:	f822                	sd	s0,48(sp)
 43e:	f426                	sd	s1,40(sp)
 440:	f04a                	sd	s2,32(sp)
 442:	ec4e                	sd	s3,24(sp)
 444:	0080                	add	s0,sp,64
 446:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 448:	c299                	beqz	a3,44e <printint+0x16>
 44a:	0805c963          	bltz	a1,4dc <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 44e:	2581                	sext.w	a1,a1
  neg = 0;
 450:	4881                	li	a7,0
 452:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 456:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 458:	2601                	sext.w	a2,a2
 45a:	00000517          	auipc	a0,0x0
 45e:	4be50513          	add	a0,a0,1214 # 918 <digits>
 462:	883a                	mv	a6,a4
 464:	2705                	addw	a4,a4,1
 466:	02c5f7bb          	remuw	a5,a1,a2
 46a:	1782                	sll	a5,a5,0x20
 46c:	9381                	srl	a5,a5,0x20
 46e:	97aa                	add	a5,a5,a0
 470:	0007c783          	lbu	a5,0(a5)
 474:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 478:	0005879b          	sext.w	a5,a1
 47c:	02c5d5bb          	divuw	a1,a1,a2
 480:	0685                	add	a3,a3,1
 482:	fec7f0e3          	bgeu	a5,a2,462 <printint+0x2a>
  if(neg)
 486:	00088c63          	beqz	a7,49e <printint+0x66>
    buf[i++] = '-';
 48a:	fd070793          	add	a5,a4,-48
 48e:	00878733          	add	a4,a5,s0
 492:	02d00793          	li	a5,45
 496:	fef70823          	sb	a5,-16(a4)
 49a:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 49e:	02e05863          	blez	a4,4ce <printint+0x96>
 4a2:	fc040793          	add	a5,s0,-64
 4a6:	00e78933          	add	s2,a5,a4
 4aa:	fff78993          	add	s3,a5,-1
 4ae:	99ba                	add	s3,s3,a4
 4b0:	377d                	addw	a4,a4,-1
 4b2:	1702                	sll	a4,a4,0x20
 4b4:	9301                	srl	a4,a4,0x20
 4b6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4ba:	fff94583          	lbu	a1,-1(s2)
 4be:	8526                	mv	a0,s1
 4c0:	00000097          	auipc	ra,0x0
 4c4:	f56080e7          	jalr	-170(ra) # 416 <putc>
  while(--i >= 0)
 4c8:	197d                	add	s2,s2,-1
 4ca:	ff3918e3          	bne	s2,s3,4ba <printint+0x82>
}
 4ce:	70e2                	ld	ra,56(sp)
 4d0:	7442                	ld	s0,48(sp)
 4d2:	74a2                	ld	s1,40(sp)
 4d4:	7902                	ld	s2,32(sp)
 4d6:	69e2                	ld	s3,24(sp)
 4d8:	6121                	add	sp,sp,64
 4da:	8082                	ret
    x = -xx;
 4dc:	40b005bb          	negw	a1,a1
    neg = 1;
 4e0:	4885                	li	a7,1
    x = -xx;
 4e2:	bf85                	j	452 <printint+0x1a>

00000000000004e4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4e4:	715d                	add	sp,sp,-80
 4e6:	e486                	sd	ra,72(sp)
 4e8:	e0a2                	sd	s0,64(sp)
 4ea:	fc26                	sd	s1,56(sp)
 4ec:	f84a                	sd	s2,48(sp)
 4ee:	f44e                	sd	s3,40(sp)
 4f0:	f052                	sd	s4,32(sp)
 4f2:	ec56                	sd	s5,24(sp)
 4f4:	e85a                	sd	s6,16(sp)
 4f6:	e45e                	sd	s7,8(sp)
 4f8:	e062                	sd	s8,0(sp)
 4fa:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4fc:	0005c903          	lbu	s2,0(a1)
 500:	18090c63          	beqz	s2,698 <vprintf+0x1b4>
 504:	8aaa                	mv	s5,a0
 506:	8bb2                	mv	s7,a2
 508:	00158493          	add	s1,a1,1
  state = 0;
 50c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 50e:	02500a13          	li	s4,37
 512:	4b55                	li	s6,21
 514:	a839                	j	532 <vprintf+0x4e>
        putc(fd, c);
 516:	85ca                	mv	a1,s2
 518:	8556                	mv	a0,s5
 51a:	00000097          	auipc	ra,0x0
 51e:	efc080e7          	jalr	-260(ra) # 416 <putc>
 522:	a019                	j	528 <vprintf+0x44>
    } else if(state == '%'){
 524:	01498d63          	beq	s3,s4,53e <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 528:	0485                	add	s1,s1,1
 52a:	fff4c903          	lbu	s2,-1(s1)
 52e:	16090563          	beqz	s2,698 <vprintf+0x1b4>
    if(state == 0){
 532:	fe0999e3          	bnez	s3,524 <vprintf+0x40>
      if(c == '%'){
 536:	ff4910e3          	bne	s2,s4,516 <vprintf+0x32>
        state = '%';
 53a:	89d2                	mv	s3,s4
 53c:	b7f5                	j	528 <vprintf+0x44>
      if(c == 'd'){
 53e:	13490263          	beq	s2,s4,662 <vprintf+0x17e>
 542:	f9d9079b          	addw	a5,s2,-99
 546:	0ff7f793          	zext.b	a5,a5
 54a:	12fb6563          	bltu	s6,a5,674 <vprintf+0x190>
 54e:	f9d9079b          	addw	a5,s2,-99
 552:	0ff7f713          	zext.b	a4,a5
 556:	10eb6f63          	bltu	s6,a4,674 <vprintf+0x190>
 55a:	00271793          	sll	a5,a4,0x2
 55e:	00000717          	auipc	a4,0x0
 562:	36270713          	add	a4,a4,866 # 8c0 <malloc+0x12a>
 566:	97ba                	add	a5,a5,a4
 568:	439c                	lw	a5,0(a5)
 56a:	97ba                	add	a5,a5,a4
 56c:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 56e:	008b8913          	add	s2,s7,8
 572:	4685                	li	a3,1
 574:	4629                	li	a2,10
 576:	000ba583          	lw	a1,0(s7)
 57a:	8556                	mv	a0,s5
 57c:	00000097          	auipc	ra,0x0
 580:	ebc080e7          	jalr	-324(ra) # 438 <printint>
 584:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 586:	4981                	li	s3,0
 588:	b745                	j	528 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 58a:	008b8913          	add	s2,s7,8
 58e:	4681                	li	a3,0
 590:	4629                	li	a2,10
 592:	000ba583          	lw	a1,0(s7)
 596:	8556                	mv	a0,s5
 598:	00000097          	auipc	ra,0x0
 59c:	ea0080e7          	jalr	-352(ra) # 438 <printint>
 5a0:	8bca                	mv	s7,s2
      state = 0;
 5a2:	4981                	li	s3,0
 5a4:	b751                	j	528 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 5a6:	008b8913          	add	s2,s7,8
 5aa:	4681                	li	a3,0
 5ac:	4641                	li	a2,16
 5ae:	000ba583          	lw	a1,0(s7)
 5b2:	8556                	mv	a0,s5
 5b4:	00000097          	auipc	ra,0x0
 5b8:	e84080e7          	jalr	-380(ra) # 438 <printint>
 5bc:	8bca                	mv	s7,s2
      state = 0;
 5be:	4981                	li	s3,0
 5c0:	b7a5                	j	528 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 5c2:	008b8c13          	add	s8,s7,8
 5c6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 5ca:	03000593          	li	a1,48
 5ce:	8556                	mv	a0,s5
 5d0:	00000097          	auipc	ra,0x0
 5d4:	e46080e7          	jalr	-442(ra) # 416 <putc>
  putc(fd, 'x');
 5d8:	07800593          	li	a1,120
 5dc:	8556                	mv	a0,s5
 5de:	00000097          	auipc	ra,0x0
 5e2:	e38080e7          	jalr	-456(ra) # 416 <putc>
 5e6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5e8:	00000b97          	auipc	s7,0x0
 5ec:	330b8b93          	add	s7,s7,816 # 918 <digits>
 5f0:	03c9d793          	srl	a5,s3,0x3c
 5f4:	97de                	add	a5,a5,s7
 5f6:	0007c583          	lbu	a1,0(a5)
 5fa:	8556                	mv	a0,s5
 5fc:	00000097          	auipc	ra,0x0
 600:	e1a080e7          	jalr	-486(ra) # 416 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 604:	0992                	sll	s3,s3,0x4
 606:	397d                	addw	s2,s2,-1
 608:	fe0914e3          	bnez	s2,5f0 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 60c:	8be2                	mv	s7,s8
      state = 0;
 60e:	4981                	li	s3,0
 610:	bf21                	j	528 <vprintf+0x44>
        s = va_arg(ap, char*);
 612:	008b8993          	add	s3,s7,8
 616:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 61a:	02090163          	beqz	s2,63c <vprintf+0x158>
        while(*s != 0){
 61e:	00094583          	lbu	a1,0(s2)
 622:	c9a5                	beqz	a1,692 <vprintf+0x1ae>
          putc(fd, *s);
 624:	8556                	mv	a0,s5
 626:	00000097          	auipc	ra,0x0
 62a:	df0080e7          	jalr	-528(ra) # 416 <putc>
          s++;
 62e:	0905                	add	s2,s2,1
        while(*s != 0){
 630:	00094583          	lbu	a1,0(s2)
 634:	f9e5                	bnez	a1,624 <vprintf+0x140>
        s = va_arg(ap, char*);
 636:	8bce                	mv	s7,s3
      state = 0;
 638:	4981                	li	s3,0
 63a:	b5fd                	j	528 <vprintf+0x44>
          s = "(null)";
 63c:	00000917          	auipc	s2,0x0
 640:	27c90913          	add	s2,s2,636 # 8b8 <malloc+0x122>
        while(*s != 0){
 644:	02800593          	li	a1,40
 648:	bff1                	j	624 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 64a:	008b8913          	add	s2,s7,8
 64e:	000bc583          	lbu	a1,0(s7)
 652:	8556                	mv	a0,s5
 654:	00000097          	auipc	ra,0x0
 658:	dc2080e7          	jalr	-574(ra) # 416 <putc>
 65c:	8bca                	mv	s7,s2
      state = 0;
 65e:	4981                	li	s3,0
 660:	b5e1                	j	528 <vprintf+0x44>
        putc(fd, c);
 662:	02500593          	li	a1,37
 666:	8556                	mv	a0,s5
 668:	00000097          	auipc	ra,0x0
 66c:	dae080e7          	jalr	-594(ra) # 416 <putc>
      state = 0;
 670:	4981                	li	s3,0
 672:	bd5d                	j	528 <vprintf+0x44>
        putc(fd, '%');
 674:	02500593          	li	a1,37
 678:	8556                	mv	a0,s5
 67a:	00000097          	auipc	ra,0x0
 67e:	d9c080e7          	jalr	-612(ra) # 416 <putc>
        putc(fd, c);
 682:	85ca                	mv	a1,s2
 684:	8556                	mv	a0,s5
 686:	00000097          	auipc	ra,0x0
 68a:	d90080e7          	jalr	-624(ra) # 416 <putc>
      state = 0;
 68e:	4981                	li	s3,0
 690:	bd61                	j	528 <vprintf+0x44>
        s = va_arg(ap, char*);
 692:	8bce                	mv	s7,s3
      state = 0;
 694:	4981                	li	s3,0
 696:	bd49                	j	528 <vprintf+0x44>
    }
  }
}
 698:	60a6                	ld	ra,72(sp)
 69a:	6406                	ld	s0,64(sp)
 69c:	74e2                	ld	s1,56(sp)
 69e:	7942                	ld	s2,48(sp)
 6a0:	79a2                	ld	s3,40(sp)
 6a2:	7a02                	ld	s4,32(sp)
 6a4:	6ae2                	ld	s5,24(sp)
 6a6:	6b42                	ld	s6,16(sp)
 6a8:	6ba2                	ld	s7,8(sp)
 6aa:	6c02                	ld	s8,0(sp)
 6ac:	6161                	add	sp,sp,80
 6ae:	8082                	ret

00000000000006b0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6b0:	715d                	add	sp,sp,-80
 6b2:	ec06                	sd	ra,24(sp)
 6b4:	e822                	sd	s0,16(sp)
 6b6:	1000                	add	s0,sp,32
 6b8:	e010                	sd	a2,0(s0)
 6ba:	e414                	sd	a3,8(s0)
 6bc:	e818                	sd	a4,16(s0)
 6be:	ec1c                	sd	a5,24(s0)
 6c0:	03043023          	sd	a6,32(s0)
 6c4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6c8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6cc:	8622                	mv	a2,s0
 6ce:	00000097          	auipc	ra,0x0
 6d2:	e16080e7          	jalr	-490(ra) # 4e4 <vprintf>
}
 6d6:	60e2                	ld	ra,24(sp)
 6d8:	6442                	ld	s0,16(sp)
 6da:	6161                	add	sp,sp,80
 6dc:	8082                	ret

00000000000006de <printf>:

void
printf(const char *fmt, ...)
{
 6de:	711d                	add	sp,sp,-96
 6e0:	ec06                	sd	ra,24(sp)
 6e2:	e822                	sd	s0,16(sp)
 6e4:	1000                	add	s0,sp,32
 6e6:	e40c                	sd	a1,8(s0)
 6e8:	e810                	sd	a2,16(s0)
 6ea:	ec14                	sd	a3,24(s0)
 6ec:	f018                	sd	a4,32(s0)
 6ee:	f41c                	sd	a5,40(s0)
 6f0:	03043823          	sd	a6,48(s0)
 6f4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6f8:	00840613          	add	a2,s0,8
 6fc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 700:	85aa                	mv	a1,a0
 702:	4505                	li	a0,1
 704:	00000097          	auipc	ra,0x0
 708:	de0080e7          	jalr	-544(ra) # 4e4 <vprintf>
}
 70c:	60e2                	ld	ra,24(sp)
 70e:	6442                	ld	s0,16(sp)
 710:	6125                	add	sp,sp,96
 712:	8082                	ret

0000000000000714 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 714:	1141                	add	sp,sp,-16
 716:	e422                	sd	s0,8(sp)
 718:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 71a:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 71e:	00001797          	auipc	a5,0x1
 722:	8e27b783          	ld	a5,-1822(a5) # 1000 <freep>
 726:	a02d                	j	750 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 728:	4618                	lw	a4,8(a2)
 72a:	9f2d                	addw	a4,a4,a1
 72c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 730:	6398                	ld	a4,0(a5)
 732:	6310                	ld	a2,0(a4)
 734:	a83d                	j	772 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 736:	ff852703          	lw	a4,-8(a0)
 73a:	9f31                	addw	a4,a4,a2
 73c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 73e:	ff053683          	ld	a3,-16(a0)
 742:	a091                	j	786 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 744:	6398                	ld	a4,0(a5)
 746:	00e7e463          	bltu	a5,a4,74e <free+0x3a>
 74a:	00e6ea63          	bltu	a3,a4,75e <free+0x4a>
{
 74e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 750:	fed7fae3          	bgeu	a5,a3,744 <free+0x30>
 754:	6398                	ld	a4,0(a5)
 756:	00e6e463          	bltu	a3,a4,75e <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 75a:	fee7eae3          	bltu	a5,a4,74e <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 75e:	ff852583          	lw	a1,-8(a0)
 762:	6390                	ld	a2,0(a5)
 764:	02059813          	sll	a6,a1,0x20
 768:	01c85713          	srl	a4,a6,0x1c
 76c:	9736                	add	a4,a4,a3
 76e:	fae60de3          	beq	a2,a4,728 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 772:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 776:	4790                	lw	a2,8(a5)
 778:	02061593          	sll	a1,a2,0x20
 77c:	01c5d713          	srl	a4,a1,0x1c
 780:	973e                	add	a4,a4,a5
 782:	fae68ae3          	beq	a3,a4,736 <free+0x22>
    p->s.ptr = bp->s.ptr;
 786:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 788:	00001717          	auipc	a4,0x1
 78c:	86f73c23          	sd	a5,-1928(a4) # 1000 <freep>
}
 790:	6422                	ld	s0,8(sp)
 792:	0141                	add	sp,sp,16
 794:	8082                	ret

0000000000000796 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 796:	7139                	add	sp,sp,-64
 798:	fc06                	sd	ra,56(sp)
 79a:	f822                	sd	s0,48(sp)
 79c:	f426                	sd	s1,40(sp)
 79e:	f04a                	sd	s2,32(sp)
 7a0:	ec4e                	sd	s3,24(sp)
 7a2:	e852                	sd	s4,16(sp)
 7a4:	e456                	sd	s5,8(sp)
 7a6:	e05a                	sd	s6,0(sp)
 7a8:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7aa:	02051493          	sll	s1,a0,0x20
 7ae:	9081                	srl	s1,s1,0x20
 7b0:	04bd                	add	s1,s1,15
 7b2:	8091                	srl	s1,s1,0x4
 7b4:	0014899b          	addw	s3,s1,1
 7b8:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 7ba:	00001517          	auipc	a0,0x1
 7be:	84653503          	ld	a0,-1978(a0) # 1000 <freep>
 7c2:	c515                	beqz	a0,7ee <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7c6:	4798                	lw	a4,8(a5)
 7c8:	02977f63          	bgeu	a4,s1,806 <malloc+0x70>
  if(nu < 4096)
 7cc:	8a4e                	mv	s4,s3
 7ce:	0009871b          	sext.w	a4,s3
 7d2:	6685                	lui	a3,0x1
 7d4:	00d77363          	bgeu	a4,a3,7da <malloc+0x44>
 7d8:	6a05                	lui	s4,0x1
 7da:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7de:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7e2:	00001917          	auipc	s2,0x1
 7e6:	81e90913          	add	s2,s2,-2018 # 1000 <freep>
  if(p == (char*)-1)
 7ea:	5afd                	li	s5,-1
 7ec:	a895                	j	860 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 7ee:	00001797          	auipc	a5,0x1
 7f2:	82278793          	add	a5,a5,-2014 # 1010 <base>
 7f6:	00001717          	auipc	a4,0x1
 7fa:	80f73523          	sd	a5,-2038(a4) # 1000 <freep>
 7fe:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 800:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 804:	b7e1                	j	7cc <malloc+0x36>
      if(p->s.size == nunits)
 806:	02e48c63          	beq	s1,a4,83e <malloc+0xa8>
        p->s.size -= nunits;
 80a:	4137073b          	subw	a4,a4,s3
 80e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 810:	02071693          	sll	a3,a4,0x20
 814:	01c6d713          	srl	a4,a3,0x1c
 818:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 81a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 81e:	00000717          	auipc	a4,0x0
 822:	7ea73123          	sd	a0,2018(a4) # 1000 <freep>
      return (void*)(p + 1);
 826:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 82a:	70e2                	ld	ra,56(sp)
 82c:	7442                	ld	s0,48(sp)
 82e:	74a2                	ld	s1,40(sp)
 830:	7902                	ld	s2,32(sp)
 832:	69e2                	ld	s3,24(sp)
 834:	6a42                	ld	s4,16(sp)
 836:	6aa2                	ld	s5,8(sp)
 838:	6b02                	ld	s6,0(sp)
 83a:	6121                	add	sp,sp,64
 83c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 83e:	6398                	ld	a4,0(a5)
 840:	e118                	sd	a4,0(a0)
 842:	bff1                	j	81e <malloc+0x88>
  hp->s.size = nu;
 844:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 848:	0541                	add	a0,a0,16
 84a:	00000097          	auipc	ra,0x0
 84e:	eca080e7          	jalr	-310(ra) # 714 <free>
  return freep;
 852:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 856:	d971                	beqz	a0,82a <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 858:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 85a:	4798                	lw	a4,8(a5)
 85c:	fa9775e3          	bgeu	a4,s1,806 <malloc+0x70>
    if(p == freep)
 860:	00093703          	ld	a4,0(s2)
 864:	853e                	mv	a0,a5
 866:	fef719e3          	bne	a4,a5,858 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 86a:	8552                	mv	a0,s4
 86c:	00000097          	auipc	ra,0x0
 870:	b72080e7          	jalr	-1166(ra) # 3de <sbrk>
  if(p == (char*)-1)
 874:	fd5518e3          	bne	a0,s5,844 <malloc+0xae>
        return 0;
 878:	4501                	li	a0,0
 87a:	bf45                	j	82a <malloc+0x94>
