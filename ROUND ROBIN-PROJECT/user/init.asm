
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	1101                	add	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	add	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   c:	4589                	li	a1,2
   e:	00001517          	auipc	a0,0x1
  12:	8f250513          	add	a0,a0,-1806 # 900 <malloc+0xe8>
  16:	00000097          	auipc	ra,0x0
  1a:	402080e7          	jalr	1026(ra) # 418 <open>
  1e:	06054363          	bltz	a0,84 <main+0x84>
    mknod("console", CONSOLE, 0);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  22:	4501                	li	a0,0
  24:	00000097          	auipc	ra,0x0
  28:	42c080e7          	jalr	1068(ra) # 450 <dup>
  dup(0);  // stderr
  2c:	4501                	li	a0,0
  2e:	00000097          	auipc	ra,0x0
  32:	422080e7          	jalr	1058(ra) # 450 <dup>

  for(;;){
    printf("init: starting sh\n");
  36:	00001917          	auipc	s2,0x1
  3a:	8d290913          	add	s2,s2,-1838 # 908 <malloc+0xf0>
  3e:	854a                	mv	a0,s2
  40:	00000097          	auipc	ra,0x0
  44:	720080e7          	jalr	1824(ra) # 760 <printf>
    pid = fork();
  48:	00000097          	auipc	ra,0x0
  4c:	388080e7          	jalr	904(ra) # 3d0 <fork>
  50:	84aa                	mv	s1,a0
    if(pid < 0){
  52:	04054d63          	bltz	a0,ac <main+0xac>
      printf("init: fork failed\n");
      exit(1);
    }
    if(pid == 0){
  56:	c925                	beqz	a0,c6 <main+0xc6>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  58:	4501                	li	a0,0
  5a:	00000097          	auipc	ra,0x0
  5e:	386080e7          	jalr	902(ra) # 3e0 <wait>
      if(wpid == pid){
  62:	fca48ee3          	beq	s1,a0,3e <main+0x3e>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  66:	fe0559e3          	bgez	a0,58 <main+0x58>
        printf("init: wait returned an error\n");
  6a:	00001517          	auipc	a0,0x1
  6e:	8ee50513          	add	a0,a0,-1810 # 958 <malloc+0x140>
  72:	00000097          	auipc	ra,0x0
  76:	6ee080e7          	jalr	1774(ra) # 760 <printf>
        exit(1);
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	35c080e7          	jalr	860(ra) # 3d8 <exit>
    mknod("console", CONSOLE, 0);
  84:	4601                	li	a2,0
  86:	4585                	li	a1,1
  88:	00001517          	auipc	a0,0x1
  8c:	87850513          	add	a0,a0,-1928 # 900 <malloc+0xe8>
  90:	00000097          	auipc	ra,0x0
  94:	390080e7          	jalr	912(ra) # 420 <mknod>
    open("console", O_RDWR);
  98:	4589                	li	a1,2
  9a:	00001517          	auipc	a0,0x1
  9e:	86650513          	add	a0,a0,-1946 # 900 <malloc+0xe8>
  a2:	00000097          	auipc	ra,0x0
  a6:	376080e7          	jalr	886(ra) # 418 <open>
  aa:	bfa5                	j	22 <main+0x22>
      printf("init: fork failed\n");
  ac:	00001517          	auipc	a0,0x1
  b0:	87450513          	add	a0,a0,-1932 # 920 <malloc+0x108>
  b4:	00000097          	auipc	ra,0x0
  b8:	6ac080e7          	jalr	1708(ra) # 760 <printf>
      exit(1);
  bc:	4505                	li	a0,1
  be:	00000097          	auipc	ra,0x0
  c2:	31a080e7          	jalr	794(ra) # 3d8 <exit>
      exec("sh", argv);
  c6:	00001597          	auipc	a1,0x1
  ca:	f3a58593          	add	a1,a1,-198 # 1000 <argv>
  ce:	00001517          	auipc	a0,0x1
  d2:	86a50513          	add	a0,a0,-1942 # 938 <malloc+0x120>
  d6:	00000097          	auipc	ra,0x0
  da:	33a080e7          	jalr	826(ra) # 410 <exec>
      printf("init: exec sh failed\n");
  de:	00001517          	auipc	a0,0x1
  e2:	86250513          	add	a0,a0,-1950 # 940 <malloc+0x128>
  e6:	00000097          	auipc	ra,0x0
  ea:	67a080e7          	jalr	1658(ra) # 760 <printf>
      exit(1);
  ee:	4505                	li	a0,1
  f0:	00000097          	auipc	ra,0x0
  f4:	2e8080e7          	jalr	744(ra) # 3d8 <exit>

00000000000000f8 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  f8:	1141                	add	sp,sp,-16
  fa:	e406                	sd	ra,8(sp)
  fc:	e022                	sd	s0,0(sp)
  fe:	0800                	add	s0,sp,16
  extern int main();
  main();
 100:	00000097          	auipc	ra,0x0
 104:	f00080e7          	jalr	-256(ra) # 0 <main>
  exit(0);
 108:	4501                	li	a0,0
 10a:	00000097          	auipc	ra,0x0
 10e:	2ce080e7          	jalr	718(ra) # 3d8 <exit>

0000000000000112 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 112:	1141                	add	sp,sp,-16
 114:	e422                	sd	s0,8(sp)
 116:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 118:	87aa                	mv	a5,a0
 11a:	0585                	add	a1,a1,1
 11c:	0785                	add	a5,a5,1
 11e:	fff5c703          	lbu	a4,-1(a1)
 122:	fee78fa3          	sb	a4,-1(a5)
 126:	fb75                	bnez	a4,11a <strcpy+0x8>
    ;
  return os;
}
 128:	6422                	ld	s0,8(sp)
 12a:	0141                	add	sp,sp,16
 12c:	8082                	ret

000000000000012e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 12e:	1141                	add	sp,sp,-16
 130:	e422                	sd	s0,8(sp)
 132:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 134:	00054783          	lbu	a5,0(a0)
 138:	cb91                	beqz	a5,14c <strcmp+0x1e>
 13a:	0005c703          	lbu	a4,0(a1)
 13e:	00f71763          	bne	a4,a5,14c <strcmp+0x1e>
    p++, q++;
 142:	0505                	add	a0,a0,1
 144:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 146:	00054783          	lbu	a5,0(a0)
 14a:	fbe5                	bnez	a5,13a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 14c:	0005c503          	lbu	a0,0(a1)
}
 150:	40a7853b          	subw	a0,a5,a0
 154:	6422                	ld	s0,8(sp)
 156:	0141                	add	sp,sp,16
 158:	8082                	ret

000000000000015a <strlen>:

uint
strlen(const char *s)
{
 15a:	1141                	add	sp,sp,-16
 15c:	e422                	sd	s0,8(sp)
 15e:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 160:	00054783          	lbu	a5,0(a0)
 164:	cf91                	beqz	a5,180 <strlen+0x26>
 166:	0505                	add	a0,a0,1
 168:	87aa                	mv	a5,a0
 16a:	86be                	mv	a3,a5
 16c:	0785                	add	a5,a5,1
 16e:	fff7c703          	lbu	a4,-1(a5)
 172:	ff65                	bnez	a4,16a <strlen+0x10>
 174:	40a6853b          	subw	a0,a3,a0
 178:	2505                	addw	a0,a0,1
    ;
  return n;
}
 17a:	6422                	ld	s0,8(sp)
 17c:	0141                	add	sp,sp,16
 17e:	8082                	ret
  for(n = 0; s[n]; n++)
 180:	4501                	li	a0,0
 182:	bfe5                	j	17a <strlen+0x20>

0000000000000184 <memset>:

void*
memset(void *dst, int c, uint n)
{
 184:	1141                	add	sp,sp,-16
 186:	e422                	sd	s0,8(sp)
 188:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 18a:	ca19                	beqz	a2,1a0 <memset+0x1c>
 18c:	87aa                	mv	a5,a0
 18e:	1602                	sll	a2,a2,0x20
 190:	9201                	srl	a2,a2,0x20
 192:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 196:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 19a:	0785                	add	a5,a5,1
 19c:	fee79de3          	bne	a5,a4,196 <memset+0x12>
  }
  return dst;
}
 1a0:	6422                	ld	s0,8(sp)
 1a2:	0141                	add	sp,sp,16
 1a4:	8082                	ret

00000000000001a6 <strchr>:

char*
strchr(const char *s, char c)
{
 1a6:	1141                	add	sp,sp,-16
 1a8:	e422                	sd	s0,8(sp)
 1aa:	0800                	add	s0,sp,16
  for(; *s; s++)
 1ac:	00054783          	lbu	a5,0(a0)
 1b0:	cb99                	beqz	a5,1c6 <strchr+0x20>
    if(*s == c)
 1b2:	00f58763          	beq	a1,a5,1c0 <strchr+0x1a>
  for(; *s; s++)
 1b6:	0505                	add	a0,a0,1
 1b8:	00054783          	lbu	a5,0(a0)
 1bc:	fbfd                	bnez	a5,1b2 <strchr+0xc>
      return (char*)s;
  return 0;
 1be:	4501                	li	a0,0
}
 1c0:	6422                	ld	s0,8(sp)
 1c2:	0141                	add	sp,sp,16
 1c4:	8082                	ret
  return 0;
 1c6:	4501                	li	a0,0
 1c8:	bfe5                	j	1c0 <strchr+0x1a>

00000000000001ca <strstr>:

char*
strstr(const char *str, const char *substr)
{
 1ca:	1141                	add	sp,sp,-16
 1cc:	e422                	sd	s0,8(sp)
 1ce:	0800                	add	s0,sp,16
  const char *a, *b = substr;
  if (*b == 0)
 1d0:	0005c803          	lbu	a6,0(a1)
 1d4:	02080a63          	beqz	a6,208 <strstr+0x3e>
    return (char*)str;
  for( ; *str != 0; str += 1) {
 1d8:	00054783          	lbu	a5,0(a0)
 1dc:	e799                	bnez	a5,1ea <strstr+0x20>
      if (*a++ != *b++)
        break;
    }
    b = substr;
  }
  return 0;
 1de:	4501                	li	a0,0
 1e0:	a025                	j	208 <strstr+0x3e>
  for( ; *str != 0; str += 1) {
 1e2:	0505                	add	a0,a0,1
 1e4:	00054783          	lbu	a5,0(a0)
 1e8:	cf99                	beqz	a5,206 <strstr+0x3c>
    if (*str != *b)
 1ea:	fef81ce3          	bne	a6,a5,1e2 <strstr+0x18>
 1ee:	87ae                	mv	a5,a1
 1f0:	86aa                	mv	a3,a0
      if (*b == 0)
 1f2:	0007c703          	lbu	a4,0(a5)
 1f6:	cb09                	beqz	a4,208 <strstr+0x3e>
      if (*a++ != *b++)
 1f8:	0685                	add	a3,a3,1
 1fa:	0785                	add	a5,a5,1
 1fc:	fff6c603          	lbu	a2,-1(a3)
 200:	fee609e3          	beq	a2,a4,1f2 <strstr+0x28>
 204:	bff9                	j	1e2 <strstr+0x18>
  return 0;
 206:	4501                	li	a0,0
}
 208:	6422                	ld	s0,8(sp)
 20a:	0141                	add	sp,sp,16
 20c:	8082                	ret

000000000000020e <gets>:

char*
gets(char *buf, int max)
{
 20e:	711d                	add	sp,sp,-96
 210:	ec86                	sd	ra,88(sp)
 212:	e8a2                	sd	s0,80(sp)
 214:	e4a6                	sd	s1,72(sp)
 216:	e0ca                	sd	s2,64(sp)
 218:	fc4e                	sd	s3,56(sp)
 21a:	f852                	sd	s4,48(sp)
 21c:	f456                	sd	s5,40(sp)
 21e:	f05a                	sd	s6,32(sp)
 220:	ec5e                	sd	s7,24(sp)
 222:	1080                	add	s0,sp,96
 224:	8baa                	mv	s7,a0
 226:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 228:	892a                	mv	s2,a0
 22a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 22c:	4aa9                	li	s5,10
 22e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 230:	89a6                	mv	s3,s1
 232:	2485                	addw	s1,s1,1
 234:	0344d863          	bge	s1,s4,264 <gets+0x56>
    cc = read(0, &c, 1);
 238:	4605                	li	a2,1
 23a:	faf40593          	add	a1,s0,-81
 23e:	4501                	li	a0,0
 240:	00000097          	auipc	ra,0x0
 244:	1b0080e7          	jalr	432(ra) # 3f0 <read>
    if(cc < 1)
 248:	00a05e63          	blez	a0,264 <gets+0x56>
    buf[i++] = c;
 24c:	faf44783          	lbu	a5,-81(s0)
 250:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 254:	01578763          	beq	a5,s5,262 <gets+0x54>
 258:	0905                	add	s2,s2,1
 25a:	fd679be3          	bne	a5,s6,230 <gets+0x22>
  for(i=0; i+1 < max; ){
 25e:	89a6                	mv	s3,s1
 260:	a011                	j	264 <gets+0x56>
 262:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 264:	99de                	add	s3,s3,s7
 266:	00098023          	sb	zero,0(s3)
  return buf;
}
 26a:	855e                	mv	a0,s7
 26c:	60e6                	ld	ra,88(sp)
 26e:	6446                	ld	s0,80(sp)
 270:	64a6                	ld	s1,72(sp)
 272:	6906                	ld	s2,64(sp)
 274:	79e2                	ld	s3,56(sp)
 276:	7a42                	ld	s4,48(sp)
 278:	7aa2                	ld	s5,40(sp)
 27a:	7b02                	ld	s6,32(sp)
 27c:	6be2                	ld	s7,24(sp)
 27e:	6125                	add	sp,sp,96
 280:	8082                	ret

0000000000000282 <stat>:

int
stat(const char *n, struct stat *st)
{
 282:	1101                	add	sp,sp,-32
 284:	ec06                	sd	ra,24(sp)
 286:	e822                	sd	s0,16(sp)
 288:	e426                	sd	s1,8(sp)
 28a:	e04a                	sd	s2,0(sp)
 28c:	1000                	add	s0,sp,32
 28e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 290:	4581                	li	a1,0
 292:	00000097          	auipc	ra,0x0
 296:	186080e7          	jalr	390(ra) # 418 <open>
  if(fd < 0)
 29a:	02054563          	bltz	a0,2c4 <stat+0x42>
 29e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2a0:	85ca                	mv	a1,s2
 2a2:	00000097          	auipc	ra,0x0
 2a6:	18e080e7          	jalr	398(ra) # 430 <fstat>
 2aa:	892a                	mv	s2,a0
  close(fd);
 2ac:	8526                	mv	a0,s1
 2ae:	00000097          	auipc	ra,0x0
 2b2:	152080e7          	jalr	338(ra) # 400 <close>
  return r;
}
 2b6:	854a                	mv	a0,s2
 2b8:	60e2                	ld	ra,24(sp)
 2ba:	6442                	ld	s0,16(sp)
 2bc:	64a2                	ld	s1,8(sp)
 2be:	6902                	ld	s2,0(sp)
 2c0:	6105                	add	sp,sp,32
 2c2:	8082                	ret
    return -1;
 2c4:	597d                	li	s2,-1
 2c6:	bfc5                	j	2b6 <stat+0x34>

00000000000002c8 <atoi>:

int
atoi(const char *s)
{
 2c8:	1141                	add	sp,sp,-16
 2ca:	e422                	sd	s0,8(sp)
 2cc:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2ce:	00054683          	lbu	a3,0(a0)
 2d2:	fd06879b          	addw	a5,a3,-48
 2d6:	0ff7f793          	zext.b	a5,a5
 2da:	4625                	li	a2,9
 2dc:	02f66863          	bltu	a2,a5,30c <atoi+0x44>
 2e0:	872a                	mv	a4,a0
  n = 0;
 2e2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2e4:	0705                	add	a4,a4,1
 2e6:	0025179b          	sllw	a5,a0,0x2
 2ea:	9fa9                	addw	a5,a5,a0
 2ec:	0017979b          	sllw	a5,a5,0x1
 2f0:	9fb5                	addw	a5,a5,a3
 2f2:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2f6:	00074683          	lbu	a3,0(a4)
 2fa:	fd06879b          	addw	a5,a3,-48
 2fe:	0ff7f793          	zext.b	a5,a5
 302:	fef671e3          	bgeu	a2,a5,2e4 <atoi+0x1c>
  return n;
}
 306:	6422                	ld	s0,8(sp)
 308:	0141                	add	sp,sp,16
 30a:	8082                	ret
  n = 0;
 30c:	4501                	li	a0,0
 30e:	bfe5                	j	306 <atoi+0x3e>

0000000000000310 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 310:	1141                	add	sp,sp,-16
 312:	e422                	sd	s0,8(sp)
 314:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 316:	02b57463          	bgeu	a0,a1,33e <memmove+0x2e>
    while(n-- > 0)
 31a:	00c05f63          	blez	a2,338 <memmove+0x28>
 31e:	1602                	sll	a2,a2,0x20
 320:	9201                	srl	a2,a2,0x20
 322:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 326:	872a                	mv	a4,a0
      *dst++ = *src++;
 328:	0585                	add	a1,a1,1
 32a:	0705                	add	a4,a4,1
 32c:	fff5c683          	lbu	a3,-1(a1)
 330:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 334:	fee79ae3          	bne	a5,a4,328 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 338:	6422                	ld	s0,8(sp)
 33a:	0141                	add	sp,sp,16
 33c:	8082                	ret
    dst += n;
 33e:	00c50733          	add	a4,a0,a2
    src += n;
 342:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 344:	fec05ae3          	blez	a2,338 <memmove+0x28>
 348:	fff6079b          	addw	a5,a2,-1
 34c:	1782                	sll	a5,a5,0x20
 34e:	9381                	srl	a5,a5,0x20
 350:	fff7c793          	not	a5,a5
 354:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 356:	15fd                	add	a1,a1,-1
 358:	177d                	add	a4,a4,-1
 35a:	0005c683          	lbu	a3,0(a1)
 35e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 362:	fee79ae3          	bne	a5,a4,356 <memmove+0x46>
 366:	bfc9                	j	338 <memmove+0x28>

0000000000000368 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 368:	1141                	add	sp,sp,-16
 36a:	e422                	sd	s0,8(sp)
 36c:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 36e:	ca05                	beqz	a2,39e <memcmp+0x36>
 370:	fff6069b          	addw	a3,a2,-1
 374:	1682                	sll	a3,a3,0x20
 376:	9281                	srl	a3,a3,0x20
 378:	0685                	add	a3,a3,1
 37a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 37c:	00054783          	lbu	a5,0(a0)
 380:	0005c703          	lbu	a4,0(a1)
 384:	00e79863          	bne	a5,a4,394 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 388:	0505                	add	a0,a0,1
    p2++;
 38a:	0585                	add	a1,a1,1
  while (n-- > 0) {
 38c:	fed518e3          	bne	a0,a3,37c <memcmp+0x14>
  }
  return 0;
 390:	4501                	li	a0,0
 392:	a019                	j	398 <memcmp+0x30>
      return *p1 - *p2;
 394:	40e7853b          	subw	a0,a5,a4
}
 398:	6422                	ld	s0,8(sp)
 39a:	0141                	add	sp,sp,16
 39c:	8082                	ret
  return 0;
 39e:	4501                	li	a0,0
 3a0:	bfe5                	j	398 <memcmp+0x30>

00000000000003a2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3a2:	1141                	add	sp,sp,-16
 3a4:	e406                	sd	ra,8(sp)
 3a6:	e022                	sd	s0,0(sp)
 3a8:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 3aa:	00000097          	auipc	ra,0x0
 3ae:	f66080e7          	jalr	-154(ra) # 310 <memmove>
}
 3b2:	60a2                	ld	ra,8(sp)
 3b4:	6402                	ld	s0,0(sp)
 3b6:	0141                	add	sp,sp,16
 3b8:	8082                	ret

00000000000003ba <ugetpid>:

int
ugetpid(void)
{
 3ba:	1141                	add	sp,sp,-16
 3bc:	e422                	sd	s0,8(sp)
 3be:	0800                	add	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 3c0:	040007b7          	lui	a5,0x4000
}
 3c4:	17f5                	add	a5,a5,-3 # 3fffffd <base+0x3ffefdd>
 3c6:	07b2                	sll	a5,a5,0xc
 3c8:	4388                	lw	a0,0(a5)
 3ca:	6422                	ld	s0,8(sp)
 3cc:	0141                	add	sp,sp,16
 3ce:	8082                	ret

00000000000003d0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3d0:	4885                	li	a7,1
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3d8:	4889                	li	a7,2
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3e0:	488d                	li	a7,3
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3e8:	4891                	li	a7,4
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <read>:
.global read
read:
 li a7, SYS_read
 3f0:	4895                	li	a7,5
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <write>:
.global write
write:
 li a7, SYS_write
 3f8:	48c1                	li	a7,16
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <close>:
.global close
close:
 li a7, SYS_close
 400:	48d5                	li	a7,21
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <kill>:
.global kill
kill:
 li a7, SYS_kill
 408:	4899                	li	a7,6
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <exec>:
.global exec
exec:
 li a7, SYS_exec
 410:	489d                	li	a7,7
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <open>:
.global open
open:
 li a7, SYS_open
 418:	48bd                	li	a7,15
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 420:	48c5                	li	a7,17
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 428:	48c9                	li	a7,18
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 430:	48a1                	li	a7,8
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <link>:
.global link
link:
 li a7, SYS_link
 438:	48cd                	li	a7,19
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 440:	48d1                	li	a7,20
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 448:	48a5                	li	a7,9
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <dup>:
.global dup
dup:
 li a7, SYS_dup
 450:	48a9                	li	a7,10
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 458:	48ad                	li	a7,11
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 460:	48b1                	li	a7,12
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 468:	48b5                	li	a7,13
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 470:	48b9                	li	a7,14
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <trace>:
.global trace
trace:
 li a7, SYS_trace
 478:	48d9                	li	a7,22
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 480:	48dd                	li	a7,23
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 488:	48e1                	li	a7,24
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <setpriority>:
.global setpriority
setpriority:
 li a7, SYS_setpriority
 490:	48e5                	li	a7,25
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 498:	1101                	add	sp,sp,-32
 49a:	ec06                	sd	ra,24(sp)
 49c:	e822                	sd	s0,16(sp)
 49e:	1000                	add	s0,sp,32
 4a0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4a4:	4605                	li	a2,1
 4a6:	fef40593          	add	a1,s0,-17
 4aa:	00000097          	auipc	ra,0x0
 4ae:	f4e080e7          	jalr	-178(ra) # 3f8 <write>
}
 4b2:	60e2                	ld	ra,24(sp)
 4b4:	6442                	ld	s0,16(sp)
 4b6:	6105                	add	sp,sp,32
 4b8:	8082                	ret

00000000000004ba <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4ba:	7139                	add	sp,sp,-64
 4bc:	fc06                	sd	ra,56(sp)
 4be:	f822                	sd	s0,48(sp)
 4c0:	f426                	sd	s1,40(sp)
 4c2:	f04a                	sd	s2,32(sp)
 4c4:	ec4e                	sd	s3,24(sp)
 4c6:	0080                	add	s0,sp,64
 4c8:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4ca:	c299                	beqz	a3,4d0 <printint+0x16>
 4cc:	0805c963          	bltz	a1,55e <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4d0:	2581                	sext.w	a1,a1
  neg = 0;
 4d2:	4881                	li	a7,0
 4d4:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 4d8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4da:	2601                	sext.w	a2,a2
 4dc:	00000517          	auipc	a0,0x0
 4e0:	4fc50513          	add	a0,a0,1276 # 9d8 <digits>
 4e4:	883a                	mv	a6,a4
 4e6:	2705                	addw	a4,a4,1
 4e8:	02c5f7bb          	remuw	a5,a1,a2
 4ec:	1782                	sll	a5,a5,0x20
 4ee:	9381                	srl	a5,a5,0x20
 4f0:	97aa                	add	a5,a5,a0
 4f2:	0007c783          	lbu	a5,0(a5)
 4f6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4fa:	0005879b          	sext.w	a5,a1
 4fe:	02c5d5bb          	divuw	a1,a1,a2
 502:	0685                	add	a3,a3,1
 504:	fec7f0e3          	bgeu	a5,a2,4e4 <printint+0x2a>
  if(neg)
 508:	00088c63          	beqz	a7,520 <printint+0x66>
    buf[i++] = '-';
 50c:	fd070793          	add	a5,a4,-48
 510:	00878733          	add	a4,a5,s0
 514:	02d00793          	li	a5,45
 518:	fef70823          	sb	a5,-16(a4)
 51c:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 520:	02e05863          	blez	a4,550 <printint+0x96>
 524:	fc040793          	add	a5,s0,-64
 528:	00e78933          	add	s2,a5,a4
 52c:	fff78993          	add	s3,a5,-1
 530:	99ba                	add	s3,s3,a4
 532:	377d                	addw	a4,a4,-1
 534:	1702                	sll	a4,a4,0x20
 536:	9301                	srl	a4,a4,0x20
 538:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 53c:	fff94583          	lbu	a1,-1(s2)
 540:	8526                	mv	a0,s1
 542:	00000097          	auipc	ra,0x0
 546:	f56080e7          	jalr	-170(ra) # 498 <putc>
  while(--i >= 0)
 54a:	197d                	add	s2,s2,-1
 54c:	ff3918e3          	bne	s2,s3,53c <printint+0x82>
}
 550:	70e2                	ld	ra,56(sp)
 552:	7442                	ld	s0,48(sp)
 554:	74a2                	ld	s1,40(sp)
 556:	7902                	ld	s2,32(sp)
 558:	69e2                	ld	s3,24(sp)
 55a:	6121                	add	sp,sp,64
 55c:	8082                	ret
    x = -xx;
 55e:	40b005bb          	negw	a1,a1
    neg = 1;
 562:	4885                	li	a7,1
    x = -xx;
 564:	bf85                	j	4d4 <printint+0x1a>

0000000000000566 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 566:	715d                	add	sp,sp,-80
 568:	e486                	sd	ra,72(sp)
 56a:	e0a2                	sd	s0,64(sp)
 56c:	fc26                	sd	s1,56(sp)
 56e:	f84a                	sd	s2,48(sp)
 570:	f44e                	sd	s3,40(sp)
 572:	f052                	sd	s4,32(sp)
 574:	ec56                	sd	s5,24(sp)
 576:	e85a                	sd	s6,16(sp)
 578:	e45e                	sd	s7,8(sp)
 57a:	e062                	sd	s8,0(sp)
 57c:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 57e:	0005c903          	lbu	s2,0(a1)
 582:	18090c63          	beqz	s2,71a <vprintf+0x1b4>
 586:	8aaa                	mv	s5,a0
 588:	8bb2                	mv	s7,a2
 58a:	00158493          	add	s1,a1,1
  state = 0;
 58e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 590:	02500a13          	li	s4,37
 594:	4b55                	li	s6,21
 596:	a839                	j	5b4 <vprintf+0x4e>
        putc(fd, c);
 598:	85ca                	mv	a1,s2
 59a:	8556                	mv	a0,s5
 59c:	00000097          	auipc	ra,0x0
 5a0:	efc080e7          	jalr	-260(ra) # 498 <putc>
 5a4:	a019                	j	5aa <vprintf+0x44>
    } else if(state == '%'){
 5a6:	01498d63          	beq	s3,s4,5c0 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 5aa:	0485                	add	s1,s1,1
 5ac:	fff4c903          	lbu	s2,-1(s1)
 5b0:	16090563          	beqz	s2,71a <vprintf+0x1b4>
    if(state == 0){
 5b4:	fe0999e3          	bnez	s3,5a6 <vprintf+0x40>
      if(c == '%'){
 5b8:	ff4910e3          	bne	s2,s4,598 <vprintf+0x32>
        state = '%';
 5bc:	89d2                	mv	s3,s4
 5be:	b7f5                	j	5aa <vprintf+0x44>
      if(c == 'd'){
 5c0:	13490263          	beq	s2,s4,6e4 <vprintf+0x17e>
 5c4:	f9d9079b          	addw	a5,s2,-99
 5c8:	0ff7f793          	zext.b	a5,a5
 5cc:	12fb6563          	bltu	s6,a5,6f6 <vprintf+0x190>
 5d0:	f9d9079b          	addw	a5,s2,-99
 5d4:	0ff7f713          	zext.b	a4,a5
 5d8:	10eb6f63          	bltu	s6,a4,6f6 <vprintf+0x190>
 5dc:	00271793          	sll	a5,a4,0x2
 5e0:	00000717          	auipc	a4,0x0
 5e4:	3a070713          	add	a4,a4,928 # 980 <malloc+0x168>
 5e8:	97ba                	add	a5,a5,a4
 5ea:	439c                	lw	a5,0(a5)
 5ec:	97ba                	add	a5,a5,a4
 5ee:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 5f0:	008b8913          	add	s2,s7,8
 5f4:	4685                	li	a3,1
 5f6:	4629                	li	a2,10
 5f8:	000ba583          	lw	a1,0(s7)
 5fc:	8556                	mv	a0,s5
 5fe:	00000097          	auipc	ra,0x0
 602:	ebc080e7          	jalr	-324(ra) # 4ba <printint>
 606:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 608:	4981                	li	s3,0
 60a:	b745                	j	5aa <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 60c:	008b8913          	add	s2,s7,8
 610:	4681                	li	a3,0
 612:	4629                	li	a2,10
 614:	000ba583          	lw	a1,0(s7)
 618:	8556                	mv	a0,s5
 61a:	00000097          	auipc	ra,0x0
 61e:	ea0080e7          	jalr	-352(ra) # 4ba <printint>
 622:	8bca                	mv	s7,s2
      state = 0;
 624:	4981                	li	s3,0
 626:	b751                	j	5aa <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 628:	008b8913          	add	s2,s7,8
 62c:	4681                	li	a3,0
 62e:	4641                	li	a2,16
 630:	000ba583          	lw	a1,0(s7)
 634:	8556                	mv	a0,s5
 636:	00000097          	auipc	ra,0x0
 63a:	e84080e7          	jalr	-380(ra) # 4ba <printint>
 63e:	8bca                	mv	s7,s2
      state = 0;
 640:	4981                	li	s3,0
 642:	b7a5                	j	5aa <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 644:	008b8c13          	add	s8,s7,8
 648:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 64c:	03000593          	li	a1,48
 650:	8556                	mv	a0,s5
 652:	00000097          	auipc	ra,0x0
 656:	e46080e7          	jalr	-442(ra) # 498 <putc>
  putc(fd, 'x');
 65a:	07800593          	li	a1,120
 65e:	8556                	mv	a0,s5
 660:	00000097          	auipc	ra,0x0
 664:	e38080e7          	jalr	-456(ra) # 498 <putc>
 668:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 66a:	00000b97          	auipc	s7,0x0
 66e:	36eb8b93          	add	s7,s7,878 # 9d8 <digits>
 672:	03c9d793          	srl	a5,s3,0x3c
 676:	97de                	add	a5,a5,s7
 678:	0007c583          	lbu	a1,0(a5)
 67c:	8556                	mv	a0,s5
 67e:	00000097          	auipc	ra,0x0
 682:	e1a080e7          	jalr	-486(ra) # 498 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 686:	0992                	sll	s3,s3,0x4
 688:	397d                	addw	s2,s2,-1
 68a:	fe0914e3          	bnez	s2,672 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 68e:	8be2                	mv	s7,s8
      state = 0;
 690:	4981                	li	s3,0
 692:	bf21                	j	5aa <vprintf+0x44>
        s = va_arg(ap, char*);
 694:	008b8993          	add	s3,s7,8
 698:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 69c:	02090163          	beqz	s2,6be <vprintf+0x158>
        while(*s != 0){
 6a0:	00094583          	lbu	a1,0(s2)
 6a4:	c9a5                	beqz	a1,714 <vprintf+0x1ae>
          putc(fd, *s);
 6a6:	8556                	mv	a0,s5
 6a8:	00000097          	auipc	ra,0x0
 6ac:	df0080e7          	jalr	-528(ra) # 498 <putc>
          s++;
 6b0:	0905                	add	s2,s2,1
        while(*s != 0){
 6b2:	00094583          	lbu	a1,0(s2)
 6b6:	f9e5                	bnez	a1,6a6 <vprintf+0x140>
        s = va_arg(ap, char*);
 6b8:	8bce                	mv	s7,s3
      state = 0;
 6ba:	4981                	li	s3,0
 6bc:	b5fd                	j	5aa <vprintf+0x44>
          s = "(null)";
 6be:	00000917          	auipc	s2,0x0
 6c2:	2ba90913          	add	s2,s2,698 # 978 <malloc+0x160>
        while(*s != 0){
 6c6:	02800593          	li	a1,40
 6ca:	bff1                	j	6a6 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 6cc:	008b8913          	add	s2,s7,8
 6d0:	000bc583          	lbu	a1,0(s7)
 6d4:	8556                	mv	a0,s5
 6d6:	00000097          	auipc	ra,0x0
 6da:	dc2080e7          	jalr	-574(ra) # 498 <putc>
 6de:	8bca                	mv	s7,s2
      state = 0;
 6e0:	4981                	li	s3,0
 6e2:	b5e1                	j	5aa <vprintf+0x44>
        putc(fd, c);
 6e4:	02500593          	li	a1,37
 6e8:	8556                	mv	a0,s5
 6ea:	00000097          	auipc	ra,0x0
 6ee:	dae080e7          	jalr	-594(ra) # 498 <putc>
      state = 0;
 6f2:	4981                	li	s3,0
 6f4:	bd5d                	j	5aa <vprintf+0x44>
        putc(fd, '%');
 6f6:	02500593          	li	a1,37
 6fa:	8556                	mv	a0,s5
 6fc:	00000097          	auipc	ra,0x0
 700:	d9c080e7          	jalr	-612(ra) # 498 <putc>
        putc(fd, c);
 704:	85ca                	mv	a1,s2
 706:	8556                	mv	a0,s5
 708:	00000097          	auipc	ra,0x0
 70c:	d90080e7          	jalr	-624(ra) # 498 <putc>
      state = 0;
 710:	4981                	li	s3,0
 712:	bd61                	j	5aa <vprintf+0x44>
        s = va_arg(ap, char*);
 714:	8bce                	mv	s7,s3
      state = 0;
 716:	4981                	li	s3,0
 718:	bd49                	j	5aa <vprintf+0x44>
    }
  }
}
 71a:	60a6                	ld	ra,72(sp)
 71c:	6406                	ld	s0,64(sp)
 71e:	74e2                	ld	s1,56(sp)
 720:	7942                	ld	s2,48(sp)
 722:	79a2                	ld	s3,40(sp)
 724:	7a02                	ld	s4,32(sp)
 726:	6ae2                	ld	s5,24(sp)
 728:	6b42                	ld	s6,16(sp)
 72a:	6ba2                	ld	s7,8(sp)
 72c:	6c02                	ld	s8,0(sp)
 72e:	6161                	add	sp,sp,80
 730:	8082                	ret

0000000000000732 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 732:	715d                	add	sp,sp,-80
 734:	ec06                	sd	ra,24(sp)
 736:	e822                	sd	s0,16(sp)
 738:	1000                	add	s0,sp,32
 73a:	e010                	sd	a2,0(s0)
 73c:	e414                	sd	a3,8(s0)
 73e:	e818                	sd	a4,16(s0)
 740:	ec1c                	sd	a5,24(s0)
 742:	03043023          	sd	a6,32(s0)
 746:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 74a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 74e:	8622                	mv	a2,s0
 750:	00000097          	auipc	ra,0x0
 754:	e16080e7          	jalr	-490(ra) # 566 <vprintf>
}
 758:	60e2                	ld	ra,24(sp)
 75a:	6442                	ld	s0,16(sp)
 75c:	6161                	add	sp,sp,80
 75e:	8082                	ret

0000000000000760 <printf>:

void
printf(const char *fmt, ...)
{
 760:	711d                	add	sp,sp,-96
 762:	ec06                	sd	ra,24(sp)
 764:	e822                	sd	s0,16(sp)
 766:	1000                	add	s0,sp,32
 768:	e40c                	sd	a1,8(s0)
 76a:	e810                	sd	a2,16(s0)
 76c:	ec14                	sd	a3,24(s0)
 76e:	f018                	sd	a4,32(s0)
 770:	f41c                	sd	a5,40(s0)
 772:	03043823          	sd	a6,48(s0)
 776:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 77a:	00840613          	add	a2,s0,8
 77e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 782:	85aa                	mv	a1,a0
 784:	4505                	li	a0,1
 786:	00000097          	auipc	ra,0x0
 78a:	de0080e7          	jalr	-544(ra) # 566 <vprintf>
}
 78e:	60e2                	ld	ra,24(sp)
 790:	6442                	ld	s0,16(sp)
 792:	6125                	add	sp,sp,96
 794:	8082                	ret

0000000000000796 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 796:	1141                	add	sp,sp,-16
 798:	e422                	sd	s0,8(sp)
 79a:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 79c:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a0:	00001797          	auipc	a5,0x1
 7a4:	8707b783          	ld	a5,-1936(a5) # 1010 <freep>
 7a8:	a02d                	j	7d2 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7aa:	4618                	lw	a4,8(a2)
 7ac:	9f2d                	addw	a4,a4,a1
 7ae:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7b2:	6398                	ld	a4,0(a5)
 7b4:	6310                	ld	a2,0(a4)
 7b6:	a83d                	j	7f4 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7b8:	ff852703          	lw	a4,-8(a0)
 7bc:	9f31                	addw	a4,a4,a2
 7be:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7c0:	ff053683          	ld	a3,-16(a0)
 7c4:	a091                	j	808 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7c6:	6398                	ld	a4,0(a5)
 7c8:	00e7e463          	bltu	a5,a4,7d0 <free+0x3a>
 7cc:	00e6ea63          	bltu	a3,a4,7e0 <free+0x4a>
{
 7d0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d2:	fed7fae3          	bgeu	a5,a3,7c6 <free+0x30>
 7d6:	6398                	ld	a4,0(a5)
 7d8:	00e6e463          	bltu	a3,a4,7e0 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7dc:	fee7eae3          	bltu	a5,a4,7d0 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 7e0:	ff852583          	lw	a1,-8(a0)
 7e4:	6390                	ld	a2,0(a5)
 7e6:	02059813          	sll	a6,a1,0x20
 7ea:	01c85713          	srl	a4,a6,0x1c
 7ee:	9736                	add	a4,a4,a3
 7f0:	fae60de3          	beq	a2,a4,7aa <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 7f4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7f8:	4790                	lw	a2,8(a5)
 7fa:	02061593          	sll	a1,a2,0x20
 7fe:	01c5d713          	srl	a4,a1,0x1c
 802:	973e                	add	a4,a4,a5
 804:	fae68ae3          	beq	a3,a4,7b8 <free+0x22>
    p->s.ptr = bp->s.ptr;
 808:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 80a:	00001717          	auipc	a4,0x1
 80e:	80f73323          	sd	a5,-2042(a4) # 1010 <freep>
}
 812:	6422                	ld	s0,8(sp)
 814:	0141                	add	sp,sp,16
 816:	8082                	ret

0000000000000818 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 818:	7139                	add	sp,sp,-64
 81a:	fc06                	sd	ra,56(sp)
 81c:	f822                	sd	s0,48(sp)
 81e:	f426                	sd	s1,40(sp)
 820:	f04a                	sd	s2,32(sp)
 822:	ec4e                	sd	s3,24(sp)
 824:	e852                	sd	s4,16(sp)
 826:	e456                	sd	s5,8(sp)
 828:	e05a                	sd	s6,0(sp)
 82a:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 82c:	02051493          	sll	s1,a0,0x20
 830:	9081                	srl	s1,s1,0x20
 832:	04bd                	add	s1,s1,15
 834:	8091                	srl	s1,s1,0x4
 836:	0014899b          	addw	s3,s1,1
 83a:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 83c:	00000517          	auipc	a0,0x0
 840:	7d453503          	ld	a0,2004(a0) # 1010 <freep>
 844:	c515                	beqz	a0,870 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 846:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 848:	4798                	lw	a4,8(a5)
 84a:	02977f63          	bgeu	a4,s1,888 <malloc+0x70>
  if(nu < 4096)
 84e:	8a4e                	mv	s4,s3
 850:	0009871b          	sext.w	a4,s3
 854:	6685                	lui	a3,0x1
 856:	00d77363          	bgeu	a4,a3,85c <malloc+0x44>
 85a:	6a05                	lui	s4,0x1
 85c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 860:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 864:	00000917          	auipc	s2,0x0
 868:	7ac90913          	add	s2,s2,1964 # 1010 <freep>
  if(p == (char*)-1)
 86c:	5afd                	li	s5,-1
 86e:	a895                	j	8e2 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 870:	00000797          	auipc	a5,0x0
 874:	7b078793          	add	a5,a5,1968 # 1020 <base>
 878:	00000717          	auipc	a4,0x0
 87c:	78f73c23          	sd	a5,1944(a4) # 1010 <freep>
 880:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 882:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 886:	b7e1                	j	84e <malloc+0x36>
      if(p->s.size == nunits)
 888:	02e48c63          	beq	s1,a4,8c0 <malloc+0xa8>
        p->s.size -= nunits;
 88c:	4137073b          	subw	a4,a4,s3
 890:	c798                	sw	a4,8(a5)
        p += p->s.size;
 892:	02071693          	sll	a3,a4,0x20
 896:	01c6d713          	srl	a4,a3,0x1c
 89a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 89c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8a0:	00000717          	auipc	a4,0x0
 8a4:	76a73823          	sd	a0,1904(a4) # 1010 <freep>
      return (void*)(p + 1);
 8a8:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8ac:	70e2                	ld	ra,56(sp)
 8ae:	7442                	ld	s0,48(sp)
 8b0:	74a2                	ld	s1,40(sp)
 8b2:	7902                	ld	s2,32(sp)
 8b4:	69e2                	ld	s3,24(sp)
 8b6:	6a42                	ld	s4,16(sp)
 8b8:	6aa2                	ld	s5,8(sp)
 8ba:	6b02                	ld	s6,0(sp)
 8bc:	6121                	add	sp,sp,64
 8be:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8c0:	6398                	ld	a4,0(a5)
 8c2:	e118                	sd	a4,0(a0)
 8c4:	bff1                	j	8a0 <malloc+0x88>
  hp->s.size = nu;
 8c6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8ca:	0541                	add	a0,a0,16
 8cc:	00000097          	auipc	ra,0x0
 8d0:	eca080e7          	jalr	-310(ra) # 796 <free>
  return freep;
 8d4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8d8:	d971                	beqz	a0,8ac <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8da:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8dc:	4798                	lw	a4,8(a5)
 8de:	fa9775e3          	bgeu	a4,s1,888 <malloc+0x70>
    if(p == freep)
 8e2:	00093703          	ld	a4,0(s2)
 8e6:	853e                	mv	a0,a5
 8e8:	fef719e3          	bne	a4,a5,8da <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 8ec:	8552                	mv	a0,s4
 8ee:	00000097          	auipc	ra,0x0
 8f2:	b72080e7          	jalr	-1166(ra) # 460 <sbrk>
  if(p == (char*)-1)
 8f6:	fd5518e3          	bne	a0,s5,8c6 <malloc+0xae>
        return 0;
 8fa:	4501                	li	a0,0
 8fc:	bf45                	j	8ac <malloc+0x94>
