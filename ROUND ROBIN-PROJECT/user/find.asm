
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <find>:
#include "kernel/stat.h"
#include "kernel/fs.h"
#include "user/user.h"

void find(char *path, const char *name)
{
   0:	7159                	add	sp,sp,-112
   2:	f486                	sd	ra,104(sp)
   4:	f0a2                	sd	s0,96(sp)
   6:	eca6                	sd	s1,88(sp)
   8:	e8ca                	sd	s2,80(sp)
   a:	e4ce                	sd	s3,72(sp)
   c:	e0d2                	sd	s4,64(sp)
   e:	fc56                	sd	s5,56(sp)
  10:	f85a                	sd	s6,48(sp)
  12:	1880                	add	s0,sp,112
  14:	892a                	mv	s2,a0
  16:	89ae                	mv	s3,a1
  int fd;
  struct stat st;
  struct dirent de;
  char *p, *buf = 0;

  if ((fd = open(path, 0)) < 0) {
  18:	4581                	li	a1,0
  1a:	00000097          	auipc	ra,0x0
  1e:	50e080e7          	jalr	1294(ra) # 528 <open>
  22:	06054e63          	bltz	a0,9e <find+0x9e>
  26:	84aa                	mv	s1,a0
    fprintf(2, "find: cannot open %s\n", path);
    return;
  }
  if (fstat(fd, &st) < 0) {
  28:	fa840593          	add	a1,s0,-88
  2c:	00000097          	auipc	ra,0x0
  30:	514080e7          	jalr	1300(ra) # 540 <fstat>
  34:	08054063          	bltz	a0,b4 <find+0xb4>
    fprintf(2, "find: cannot stat %s\n", path);
    return;
  }

  switch (st.type) {
  38:	fb041783          	lh	a5,-80(s0)
  3c:	4705                	li	a4,1
  3e:	0ae78063          	beq	a5,a4,de <find+0xde>
  42:	4709                	li	a4,2
  44:	02e79e63          	bne	a5,a4,80 <find+0x80>
    case T_FILE:
      for (p = path + strlen(path); p >= path && *p != '/'; --p);
  48:	854a                	mv	a0,s2
  4a:	00000097          	auipc	ra,0x0
  4e:	220080e7          	jalr	544(ra) # 26a <strlen>
  52:	02051793          	sll	a5,a0,0x20
  56:	9381                	srl	a5,a5,0x20
  58:	97ca                	add	a5,a5,s2
  5a:	02f00693          	li	a3,47
  5e:	0127e963          	bltu	a5,s2,70 <find+0x70>
  62:	0007c703          	lbu	a4,0(a5)
  66:	00d70563          	beq	a4,a3,70 <find+0x70>
  6a:	17fd                	add	a5,a5,-1
  6c:	ff27fbe3          	bgeu	a5,s2,62 <find+0x62>
      if (strcmp(p+1, name) == 0)
  70:	85ce                	mv	a1,s3
  72:	00178513          	add	a0,a5,1
  76:	00000097          	auipc	ra,0x0
  7a:	1c8080e7          	jalr	456(ra) # 23e <strcmp>
  7e:	c531                	beqz	a0,ca <find+0xca>
      break;
  }

  if (buf)
    free(buf);
  close(fd);
  80:	8526                	mv	a0,s1
  82:	00000097          	auipc	ra,0x0
  86:	48e080e7          	jalr	1166(ra) # 510 <close>
}
  8a:	70a6                	ld	ra,104(sp)
  8c:	7406                	ld	s0,96(sp)
  8e:	64e6                	ld	s1,88(sp)
  90:	6946                	ld	s2,80(sp)
  92:	69a6                	ld	s3,72(sp)
  94:	6a06                	ld	s4,64(sp)
  96:	7ae2                	ld	s5,56(sp)
  98:	7b42                	ld	s6,48(sp)
  9a:	6165                	add	sp,sp,112
  9c:	8082                	ret
    fprintf(2, "find: cannot open %s\n", path);
  9e:	864a                	mv	a2,s2
  a0:	00001597          	auipc	a1,0x1
  a4:	97058593          	add	a1,a1,-1680 # a10 <malloc+0xe8>
  a8:	4509                	li	a0,2
  aa:	00000097          	auipc	ra,0x0
  ae:	798080e7          	jalr	1944(ra) # 842 <fprintf>
    return;
  b2:	bfe1                	j	8a <find+0x8a>
    fprintf(2, "find: cannot stat %s\n", path);
  b4:	864a                	mv	a2,s2
  b6:	00001597          	auipc	a1,0x1
  ba:	97258593          	add	a1,a1,-1678 # a28 <malloc+0x100>
  be:	4509                	li	a0,2
  c0:	00000097          	auipc	ra,0x0
  c4:	782080e7          	jalr	1922(ra) # 842 <fprintf>
    return;
  c8:	b7c9                	j	8a <find+0x8a>
        printf("%s\n", path);
  ca:	85ca                	mv	a1,s2
  cc:	00001517          	auipc	a0,0x1
  d0:	97450513          	add	a0,a0,-1676 # a40 <malloc+0x118>
  d4:	00000097          	auipc	ra,0x0
  d8:	79c080e7          	jalr	1948(ra) # 870 <printf>
  if (buf)
  dc:	b755                	j	80 <find+0x80>
      buf = (char*)malloc(strlen(path) + 1 + DIRSIZ + 1);
  de:	854a                	mv	a0,s2
  e0:	00000097          	auipc	ra,0x0
  e4:	18a080e7          	jalr	394(ra) # 26a <strlen>
  e8:	2541                	addw	a0,a0,16
  ea:	00001097          	auipc	ra,0x1
  ee:	83e080e7          	jalr	-1986(ra) # 928 <malloc>
  f2:	8a2a                	mv	s4,a0
      strcpy(buf, path);
  f4:	85ca                	mv	a1,s2
  f6:	00000097          	auipc	ra,0x0
  fa:	12c080e7          	jalr	300(ra) # 222 <strcpy>
      p = buf + strlen(buf);
  fe:	8552                	mv	a0,s4
 100:	00000097          	auipc	ra,0x0
 104:	16a080e7          	jalr	362(ra) # 26a <strlen>
 108:	02051913          	sll	s2,a0,0x20
 10c:	02095913          	srl	s2,s2,0x20
 110:	9952                	add	s2,s2,s4
      *p++ = '/';
 112:	00190a93          	add	s5,s2,1
 116:	02f00793          	li	a5,47
 11a:	00f90023          	sb	a5,0(s2)
        if (strcmp(de.name, ".") && strcmp(de.name, ".."))
 11e:	00001b17          	auipc	s6,0x1
 122:	92ab0b13          	add	s6,s6,-1750 # a48 <malloc+0x120>
      while (read(fd, &de, sizeof(de)) == sizeof(de)) {
 126:	4641                	li	a2,16
 128:	f9840593          	add	a1,s0,-104
 12c:	8526                	mv	a0,s1
 12e:	00000097          	auipc	ra,0x0
 132:	3d2080e7          	jalr	978(ra) # 500 <read>
 136:	47c1                	li	a5,16
 138:	06f51d63          	bne	a0,a5,1b2 <find+0x1b2>
        if (de.inum == 0)
 13c:	f9845783          	lhu	a5,-104(s0)
 140:	d3fd                	beqz	a5,126 <find+0x126>
        memmove(p, de.name, DIRSIZ);
 142:	4639                	li	a2,14
 144:	f9a40593          	add	a1,s0,-102
 148:	8556                	mv	a0,s5
 14a:	00000097          	auipc	ra,0x0
 14e:	2d6080e7          	jalr	726(ra) # 420 <memmove>
        p[DIRSIZ] = 0;
 152:	000907a3          	sb	zero,15(s2)
        if (stat(buf, &st) < 0) {
 156:	fa840593          	add	a1,s0,-88
 15a:	8552                	mv	a0,s4
 15c:	00000097          	auipc	ra,0x0
 160:	236080e7          	jalr	566(ra) # 392 <stat>
 164:	02054c63          	bltz	a0,19c <find+0x19c>
        if (strcmp(de.name, ".") && strcmp(de.name, ".."))
 168:	85da                	mv	a1,s6
 16a:	f9a40513          	add	a0,s0,-102
 16e:	00000097          	auipc	ra,0x0
 172:	0d0080e7          	jalr	208(ra) # 23e <strcmp>
 176:	d945                	beqz	a0,126 <find+0x126>
 178:	00001597          	auipc	a1,0x1
 17c:	8d858593          	add	a1,a1,-1832 # a50 <malloc+0x128>
 180:	f9a40513          	add	a0,s0,-102
 184:	00000097          	auipc	ra,0x0
 188:	0ba080e7          	jalr	186(ra) # 23e <strcmp>
 18c:	dd49                	beqz	a0,126 <find+0x126>
          find(buf, name);
 18e:	85ce                	mv	a1,s3
 190:	8552                	mv	a0,s4
 192:	00000097          	auipc	ra,0x0
 196:	e6e080e7          	jalr	-402(ra) # 0 <find>
 19a:	b771                	j	126 <find+0x126>
          fprintf(2, "find: cannot stat %s\n", buf);
 19c:	8652                	mv	a2,s4
 19e:	00001597          	auipc	a1,0x1
 1a2:	88a58593          	add	a1,a1,-1910 # a28 <malloc+0x100>
 1a6:	4509                	li	a0,2
 1a8:	00000097          	auipc	ra,0x0
 1ac:	69a080e7          	jalr	1690(ra) # 842 <fprintf>
          continue;
 1b0:	bf9d                	j	126 <find+0x126>
  if (buf)
 1b2:	ec0a07e3          	beqz	s4,80 <find+0x80>
    free(buf);
 1b6:	8552                	mv	a0,s4
 1b8:	00000097          	auipc	ra,0x0
 1bc:	6ee080e7          	jalr	1774(ra) # 8a6 <free>
 1c0:	b5c1                	j	80 <find+0x80>

00000000000001c2 <main>:

int main(int argc, char *argv[])
{
 1c2:	1141                	add	sp,sp,-16
 1c4:	e406                	sd	ra,8(sp)
 1c6:	e022                	sd	s0,0(sp)
 1c8:	0800                	add	s0,sp,16
  if (argc != 3) {
 1ca:	470d                	li	a4,3
 1cc:	02e50263          	beq	a0,a4,1f0 <main+0x2e>
    write(2, "error: incorrect arguments - usage: find [path] [pattern]\n", 58);
 1d0:	03a00613          	li	a2,58
 1d4:	00001597          	auipc	a1,0x1
 1d8:	88458593          	add	a1,a1,-1916 # a58 <malloc+0x130>
 1dc:	4509                	li	a0,2
 1de:	00000097          	auipc	ra,0x0
 1e2:	32a080e7          	jalr	810(ra) # 508 <write>
    exit(-1);
 1e6:	557d                	li	a0,-1
 1e8:	00000097          	auipc	ra,0x0
 1ec:	300080e7          	jalr	768(ra) # 4e8 <exit>
 1f0:	87ae                	mv	a5,a1
  }
  find(argv[1], argv[2]);
 1f2:	698c                	ld	a1,16(a1)
 1f4:	6788                	ld	a0,8(a5)
 1f6:	00000097          	auipc	ra,0x0
 1fa:	e0a080e7          	jalr	-502(ra) # 0 <find>
  exit(0);
 1fe:	4501                	li	a0,0
 200:	00000097          	auipc	ra,0x0
 204:	2e8080e7          	jalr	744(ra) # 4e8 <exit>

0000000000000208 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 208:	1141                	add	sp,sp,-16
 20a:	e406                	sd	ra,8(sp)
 20c:	e022                	sd	s0,0(sp)
 20e:	0800                	add	s0,sp,16
  extern int main();
  main();
 210:	00000097          	auipc	ra,0x0
 214:	fb2080e7          	jalr	-78(ra) # 1c2 <main>
  exit(0);
 218:	4501                	li	a0,0
 21a:	00000097          	auipc	ra,0x0
 21e:	2ce080e7          	jalr	718(ra) # 4e8 <exit>

0000000000000222 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 222:	1141                	add	sp,sp,-16
 224:	e422                	sd	s0,8(sp)
 226:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 228:	87aa                	mv	a5,a0
 22a:	0585                	add	a1,a1,1
 22c:	0785                	add	a5,a5,1
 22e:	fff5c703          	lbu	a4,-1(a1)
 232:	fee78fa3          	sb	a4,-1(a5)
 236:	fb75                	bnez	a4,22a <strcpy+0x8>
    ;
  return os;
}
 238:	6422                	ld	s0,8(sp)
 23a:	0141                	add	sp,sp,16
 23c:	8082                	ret

000000000000023e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 23e:	1141                	add	sp,sp,-16
 240:	e422                	sd	s0,8(sp)
 242:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 244:	00054783          	lbu	a5,0(a0)
 248:	cb91                	beqz	a5,25c <strcmp+0x1e>
 24a:	0005c703          	lbu	a4,0(a1)
 24e:	00f71763          	bne	a4,a5,25c <strcmp+0x1e>
    p++, q++;
 252:	0505                	add	a0,a0,1
 254:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 256:	00054783          	lbu	a5,0(a0)
 25a:	fbe5                	bnez	a5,24a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 25c:	0005c503          	lbu	a0,0(a1)
}
 260:	40a7853b          	subw	a0,a5,a0
 264:	6422                	ld	s0,8(sp)
 266:	0141                	add	sp,sp,16
 268:	8082                	ret

000000000000026a <strlen>:

uint
strlen(const char *s)
{
 26a:	1141                	add	sp,sp,-16
 26c:	e422                	sd	s0,8(sp)
 26e:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 270:	00054783          	lbu	a5,0(a0)
 274:	cf91                	beqz	a5,290 <strlen+0x26>
 276:	0505                	add	a0,a0,1
 278:	87aa                	mv	a5,a0
 27a:	86be                	mv	a3,a5
 27c:	0785                	add	a5,a5,1
 27e:	fff7c703          	lbu	a4,-1(a5)
 282:	ff65                	bnez	a4,27a <strlen+0x10>
 284:	40a6853b          	subw	a0,a3,a0
 288:	2505                	addw	a0,a0,1
    ;
  return n;
}
 28a:	6422                	ld	s0,8(sp)
 28c:	0141                	add	sp,sp,16
 28e:	8082                	ret
  for(n = 0; s[n]; n++)
 290:	4501                	li	a0,0
 292:	bfe5                	j	28a <strlen+0x20>

0000000000000294 <memset>:

void*
memset(void *dst, int c, uint n)
{
 294:	1141                	add	sp,sp,-16
 296:	e422                	sd	s0,8(sp)
 298:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 29a:	ca19                	beqz	a2,2b0 <memset+0x1c>
 29c:	87aa                	mv	a5,a0
 29e:	1602                	sll	a2,a2,0x20
 2a0:	9201                	srl	a2,a2,0x20
 2a2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2a6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2aa:	0785                	add	a5,a5,1
 2ac:	fee79de3          	bne	a5,a4,2a6 <memset+0x12>
  }
  return dst;
}
 2b0:	6422                	ld	s0,8(sp)
 2b2:	0141                	add	sp,sp,16
 2b4:	8082                	ret

00000000000002b6 <strchr>:

char*
strchr(const char *s, char c)
{
 2b6:	1141                	add	sp,sp,-16
 2b8:	e422                	sd	s0,8(sp)
 2ba:	0800                	add	s0,sp,16
  for(; *s; s++)
 2bc:	00054783          	lbu	a5,0(a0)
 2c0:	cb99                	beqz	a5,2d6 <strchr+0x20>
    if(*s == c)
 2c2:	00f58763          	beq	a1,a5,2d0 <strchr+0x1a>
  for(; *s; s++)
 2c6:	0505                	add	a0,a0,1
 2c8:	00054783          	lbu	a5,0(a0)
 2cc:	fbfd                	bnez	a5,2c2 <strchr+0xc>
      return (char*)s;
  return 0;
 2ce:	4501                	li	a0,0
}
 2d0:	6422                	ld	s0,8(sp)
 2d2:	0141                	add	sp,sp,16
 2d4:	8082                	ret
  return 0;
 2d6:	4501                	li	a0,0
 2d8:	bfe5                	j	2d0 <strchr+0x1a>

00000000000002da <strstr>:

char*
strstr(const char *str, const char *substr)
{
 2da:	1141                	add	sp,sp,-16
 2dc:	e422                	sd	s0,8(sp)
 2de:	0800                	add	s0,sp,16
  const char *a, *b = substr;
  if (*b == 0)
 2e0:	0005c803          	lbu	a6,0(a1)
 2e4:	02080a63          	beqz	a6,318 <strstr+0x3e>
    return (char*)str;
  for( ; *str != 0; str += 1) {
 2e8:	00054783          	lbu	a5,0(a0)
 2ec:	e799                	bnez	a5,2fa <strstr+0x20>
      if (*a++ != *b++)
        break;
    }
    b = substr;
  }
  return 0;
 2ee:	4501                	li	a0,0
 2f0:	a025                	j	318 <strstr+0x3e>
  for( ; *str != 0; str += 1) {
 2f2:	0505                	add	a0,a0,1
 2f4:	00054783          	lbu	a5,0(a0)
 2f8:	cf99                	beqz	a5,316 <strstr+0x3c>
    if (*str != *b)
 2fa:	fef81ce3          	bne	a6,a5,2f2 <strstr+0x18>
 2fe:	87ae                	mv	a5,a1
 300:	86aa                	mv	a3,a0
      if (*b == 0)
 302:	0007c703          	lbu	a4,0(a5)
 306:	cb09                	beqz	a4,318 <strstr+0x3e>
      if (*a++ != *b++)
 308:	0685                	add	a3,a3,1
 30a:	0785                	add	a5,a5,1
 30c:	fff6c603          	lbu	a2,-1(a3)
 310:	fee609e3          	beq	a2,a4,302 <strstr+0x28>
 314:	bff9                	j	2f2 <strstr+0x18>
  return 0;
 316:	4501                	li	a0,0
}
 318:	6422                	ld	s0,8(sp)
 31a:	0141                	add	sp,sp,16
 31c:	8082                	ret

000000000000031e <gets>:

char*
gets(char *buf, int max)
{
 31e:	711d                	add	sp,sp,-96
 320:	ec86                	sd	ra,88(sp)
 322:	e8a2                	sd	s0,80(sp)
 324:	e4a6                	sd	s1,72(sp)
 326:	e0ca                	sd	s2,64(sp)
 328:	fc4e                	sd	s3,56(sp)
 32a:	f852                	sd	s4,48(sp)
 32c:	f456                	sd	s5,40(sp)
 32e:	f05a                	sd	s6,32(sp)
 330:	ec5e                	sd	s7,24(sp)
 332:	1080                	add	s0,sp,96
 334:	8baa                	mv	s7,a0
 336:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 338:	892a                	mv	s2,a0
 33a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 33c:	4aa9                	li	s5,10
 33e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 340:	89a6                	mv	s3,s1
 342:	2485                	addw	s1,s1,1
 344:	0344d863          	bge	s1,s4,374 <gets+0x56>
    cc = read(0, &c, 1);
 348:	4605                	li	a2,1
 34a:	faf40593          	add	a1,s0,-81
 34e:	4501                	li	a0,0
 350:	00000097          	auipc	ra,0x0
 354:	1b0080e7          	jalr	432(ra) # 500 <read>
    if(cc < 1)
 358:	00a05e63          	blez	a0,374 <gets+0x56>
    buf[i++] = c;
 35c:	faf44783          	lbu	a5,-81(s0)
 360:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 364:	01578763          	beq	a5,s5,372 <gets+0x54>
 368:	0905                	add	s2,s2,1
 36a:	fd679be3          	bne	a5,s6,340 <gets+0x22>
  for(i=0; i+1 < max; ){
 36e:	89a6                	mv	s3,s1
 370:	a011                	j	374 <gets+0x56>
 372:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 374:	99de                	add	s3,s3,s7
 376:	00098023          	sb	zero,0(s3)
  return buf;
}
 37a:	855e                	mv	a0,s7
 37c:	60e6                	ld	ra,88(sp)
 37e:	6446                	ld	s0,80(sp)
 380:	64a6                	ld	s1,72(sp)
 382:	6906                	ld	s2,64(sp)
 384:	79e2                	ld	s3,56(sp)
 386:	7a42                	ld	s4,48(sp)
 388:	7aa2                	ld	s5,40(sp)
 38a:	7b02                	ld	s6,32(sp)
 38c:	6be2                	ld	s7,24(sp)
 38e:	6125                	add	sp,sp,96
 390:	8082                	ret

0000000000000392 <stat>:

int
stat(const char *n, struct stat *st)
{
 392:	1101                	add	sp,sp,-32
 394:	ec06                	sd	ra,24(sp)
 396:	e822                	sd	s0,16(sp)
 398:	e426                	sd	s1,8(sp)
 39a:	e04a                	sd	s2,0(sp)
 39c:	1000                	add	s0,sp,32
 39e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3a0:	4581                	li	a1,0
 3a2:	00000097          	auipc	ra,0x0
 3a6:	186080e7          	jalr	390(ra) # 528 <open>
  if(fd < 0)
 3aa:	02054563          	bltz	a0,3d4 <stat+0x42>
 3ae:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3b0:	85ca                	mv	a1,s2
 3b2:	00000097          	auipc	ra,0x0
 3b6:	18e080e7          	jalr	398(ra) # 540 <fstat>
 3ba:	892a                	mv	s2,a0
  close(fd);
 3bc:	8526                	mv	a0,s1
 3be:	00000097          	auipc	ra,0x0
 3c2:	152080e7          	jalr	338(ra) # 510 <close>
  return r;
}
 3c6:	854a                	mv	a0,s2
 3c8:	60e2                	ld	ra,24(sp)
 3ca:	6442                	ld	s0,16(sp)
 3cc:	64a2                	ld	s1,8(sp)
 3ce:	6902                	ld	s2,0(sp)
 3d0:	6105                	add	sp,sp,32
 3d2:	8082                	ret
    return -1;
 3d4:	597d                	li	s2,-1
 3d6:	bfc5                	j	3c6 <stat+0x34>

00000000000003d8 <atoi>:

int
atoi(const char *s)
{
 3d8:	1141                	add	sp,sp,-16
 3da:	e422                	sd	s0,8(sp)
 3dc:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3de:	00054683          	lbu	a3,0(a0)
 3e2:	fd06879b          	addw	a5,a3,-48
 3e6:	0ff7f793          	zext.b	a5,a5
 3ea:	4625                	li	a2,9
 3ec:	02f66863          	bltu	a2,a5,41c <atoi+0x44>
 3f0:	872a                	mv	a4,a0
  n = 0;
 3f2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3f4:	0705                	add	a4,a4,1
 3f6:	0025179b          	sllw	a5,a0,0x2
 3fa:	9fa9                	addw	a5,a5,a0
 3fc:	0017979b          	sllw	a5,a5,0x1
 400:	9fb5                	addw	a5,a5,a3
 402:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 406:	00074683          	lbu	a3,0(a4)
 40a:	fd06879b          	addw	a5,a3,-48
 40e:	0ff7f793          	zext.b	a5,a5
 412:	fef671e3          	bgeu	a2,a5,3f4 <atoi+0x1c>
  return n;
}
 416:	6422                	ld	s0,8(sp)
 418:	0141                	add	sp,sp,16
 41a:	8082                	ret
  n = 0;
 41c:	4501                	li	a0,0
 41e:	bfe5                	j	416 <atoi+0x3e>

0000000000000420 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 420:	1141                	add	sp,sp,-16
 422:	e422                	sd	s0,8(sp)
 424:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 426:	02b57463          	bgeu	a0,a1,44e <memmove+0x2e>
    while(n-- > 0)
 42a:	00c05f63          	blez	a2,448 <memmove+0x28>
 42e:	1602                	sll	a2,a2,0x20
 430:	9201                	srl	a2,a2,0x20
 432:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 436:	872a                	mv	a4,a0
      *dst++ = *src++;
 438:	0585                	add	a1,a1,1
 43a:	0705                	add	a4,a4,1
 43c:	fff5c683          	lbu	a3,-1(a1)
 440:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 444:	fee79ae3          	bne	a5,a4,438 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 448:	6422                	ld	s0,8(sp)
 44a:	0141                	add	sp,sp,16
 44c:	8082                	ret
    dst += n;
 44e:	00c50733          	add	a4,a0,a2
    src += n;
 452:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 454:	fec05ae3          	blez	a2,448 <memmove+0x28>
 458:	fff6079b          	addw	a5,a2,-1
 45c:	1782                	sll	a5,a5,0x20
 45e:	9381                	srl	a5,a5,0x20
 460:	fff7c793          	not	a5,a5
 464:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 466:	15fd                	add	a1,a1,-1
 468:	177d                	add	a4,a4,-1
 46a:	0005c683          	lbu	a3,0(a1)
 46e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 472:	fee79ae3          	bne	a5,a4,466 <memmove+0x46>
 476:	bfc9                	j	448 <memmove+0x28>

0000000000000478 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 478:	1141                	add	sp,sp,-16
 47a:	e422                	sd	s0,8(sp)
 47c:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 47e:	ca05                	beqz	a2,4ae <memcmp+0x36>
 480:	fff6069b          	addw	a3,a2,-1
 484:	1682                	sll	a3,a3,0x20
 486:	9281                	srl	a3,a3,0x20
 488:	0685                	add	a3,a3,1
 48a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 48c:	00054783          	lbu	a5,0(a0)
 490:	0005c703          	lbu	a4,0(a1)
 494:	00e79863          	bne	a5,a4,4a4 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 498:	0505                	add	a0,a0,1
    p2++;
 49a:	0585                	add	a1,a1,1
  while (n-- > 0) {
 49c:	fed518e3          	bne	a0,a3,48c <memcmp+0x14>
  }
  return 0;
 4a0:	4501                	li	a0,0
 4a2:	a019                	j	4a8 <memcmp+0x30>
      return *p1 - *p2;
 4a4:	40e7853b          	subw	a0,a5,a4
}
 4a8:	6422                	ld	s0,8(sp)
 4aa:	0141                	add	sp,sp,16
 4ac:	8082                	ret
  return 0;
 4ae:	4501                	li	a0,0
 4b0:	bfe5                	j	4a8 <memcmp+0x30>

00000000000004b2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4b2:	1141                	add	sp,sp,-16
 4b4:	e406                	sd	ra,8(sp)
 4b6:	e022                	sd	s0,0(sp)
 4b8:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 4ba:	00000097          	auipc	ra,0x0
 4be:	f66080e7          	jalr	-154(ra) # 420 <memmove>
}
 4c2:	60a2                	ld	ra,8(sp)
 4c4:	6402                	ld	s0,0(sp)
 4c6:	0141                	add	sp,sp,16
 4c8:	8082                	ret

00000000000004ca <ugetpid>:

int
ugetpid(void)
{
 4ca:	1141                	add	sp,sp,-16
 4cc:	e422                	sd	s0,8(sp)
 4ce:	0800                	add	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 4d0:	040007b7          	lui	a5,0x4000
}
 4d4:	17f5                	add	a5,a5,-3 # 3fffffd <base+0x3ffefed>
 4d6:	07b2                	sll	a5,a5,0xc
 4d8:	4388                	lw	a0,0(a5)
 4da:	6422                	ld	s0,8(sp)
 4dc:	0141                	add	sp,sp,16
 4de:	8082                	ret

00000000000004e0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4e0:	4885                	li	a7,1
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4e8:	4889                	li	a7,2
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4f0:	488d                	li	a7,3
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4f8:	4891                	li	a7,4
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <read>:
.global read
read:
 li a7, SYS_read
 500:	4895                	li	a7,5
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <write>:
.global write
write:
 li a7, SYS_write
 508:	48c1                	li	a7,16
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <close>:
.global close
close:
 li a7, SYS_close
 510:	48d5                	li	a7,21
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <kill>:
.global kill
kill:
 li a7, SYS_kill
 518:	4899                	li	a7,6
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <exec>:
.global exec
exec:
 li a7, SYS_exec
 520:	489d                	li	a7,7
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <open>:
.global open
open:
 li a7, SYS_open
 528:	48bd                	li	a7,15
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 530:	48c5                	li	a7,17
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 538:	48c9                	li	a7,18
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 540:	48a1                	li	a7,8
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <link>:
.global link
link:
 li a7, SYS_link
 548:	48cd                	li	a7,19
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 550:	48d1                	li	a7,20
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 558:	48a5                	li	a7,9
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <dup>:
.global dup
dup:
 li a7, SYS_dup
 560:	48a9                	li	a7,10
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 568:	48ad                	li	a7,11
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 570:	48b1                	li	a7,12
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 578:	48b5                	li	a7,13
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 580:	48b9                	li	a7,14
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <trace>:
.global trace
trace:
 li a7, SYS_trace
 588:	48d9                	li	a7,22
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 590:	48dd                	li	a7,23
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 598:	48e1                	li	a7,24
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <setpriority>:
.global setpriority
setpriority:
 li a7, SYS_setpriority
 5a0:	48e5                	li	a7,25
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5a8:	1101                	add	sp,sp,-32
 5aa:	ec06                	sd	ra,24(sp)
 5ac:	e822                	sd	s0,16(sp)
 5ae:	1000                	add	s0,sp,32
 5b0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5b4:	4605                	li	a2,1
 5b6:	fef40593          	add	a1,s0,-17
 5ba:	00000097          	auipc	ra,0x0
 5be:	f4e080e7          	jalr	-178(ra) # 508 <write>
}
 5c2:	60e2                	ld	ra,24(sp)
 5c4:	6442                	ld	s0,16(sp)
 5c6:	6105                	add	sp,sp,32
 5c8:	8082                	ret

00000000000005ca <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5ca:	7139                	add	sp,sp,-64
 5cc:	fc06                	sd	ra,56(sp)
 5ce:	f822                	sd	s0,48(sp)
 5d0:	f426                	sd	s1,40(sp)
 5d2:	f04a                	sd	s2,32(sp)
 5d4:	ec4e                	sd	s3,24(sp)
 5d6:	0080                	add	s0,sp,64
 5d8:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5da:	c299                	beqz	a3,5e0 <printint+0x16>
 5dc:	0805c963          	bltz	a1,66e <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5e0:	2581                	sext.w	a1,a1
  neg = 0;
 5e2:	4881                	li	a7,0
 5e4:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 5e8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5ea:	2601                	sext.w	a2,a2
 5ec:	00000517          	auipc	a0,0x0
 5f0:	50c50513          	add	a0,a0,1292 # af8 <digits>
 5f4:	883a                	mv	a6,a4
 5f6:	2705                	addw	a4,a4,1
 5f8:	02c5f7bb          	remuw	a5,a1,a2
 5fc:	1782                	sll	a5,a5,0x20
 5fe:	9381                	srl	a5,a5,0x20
 600:	97aa                	add	a5,a5,a0
 602:	0007c783          	lbu	a5,0(a5)
 606:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 60a:	0005879b          	sext.w	a5,a1
 60e:	02c5d5bb          	divuw	a1,a1,a2
 612:	0685                	add	a3,a3,1
 614:	fec7f0e3          	bgeu	a5,a2,5f4 <printint+0x2a>
  if(neg)
 618:	00088c63          	beqz	a7,630 <printint+0x66>
    buf[i++] = '-';
 61c:	fd070793          	add	a5,a4,-48
 620:	00878733          	add	a4,a5,s0
 624:	02d00793          	li	a5,45
 628:	fef70823          	sb	a5,-16(a4)
 62c:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 630:	02e05863          	blez	a4,660 <printint+0x96>
 634:	fc040793          	add	a5,s0,-64
 638:	00e78933          	add	s2,a5,a4
 63c:	fff78993          	add	s3,a5,-1
 640:	99ba                	add	s3,s3,a4
 642:	377d                	addw	a4,a4,-1
 644:	1702                	sll	a4,a4,0x20
 646:	9301                	srl	a4,a4,0x20
 648:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 64c:	fff94583          	lbu	a1,-1(s2)
 650:	8526                	mv	a0,s1
 652:	00000097          	auipc	ra,0x0
 656:	f56080e7          	jalr	-170(ra) # 5a8 <putc>
  while(--i >= 0)
 65a:	197d                	add	s2,s2,-1
 65c:	ff3918e3          	bne	s2,s3,64c <printint+0x82>
}
 660:	70e2                	ld	ra,56(sp)
 662:	7442                	ld	s0,48(sp)
 664:	74a2                	ld	s1,40(sp)
 666:	7902                	ld	s2,32(sp)
 668:	69e2                	ld	s3,24(sp)
 66a:	6121                	add	sp,sp,64
 66c:	8082                	ret
    x = -xx;
 66e:	40b005bb          	negw	a1,a1
    neg = 1;
 672:	4885                	li	a7,1
    x = -xx;
 674:	bf85                	j	5e4 <printint+0x1a>

0000000000000676 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 676:	715d                	add	sp,sp,-80
 678:	e486                	sd	ra,72(sp)
 67a:	e0a2                	sd	s0,64(sp)
 67c:	fc26                	sd	s1,56(sp)
 67e:	f84a                	sd	s2,48(sp)
 680:	f44e                	sd	s3,40(sp)
 682:	f052                	sd	s4,32(sp)
 684:	ec56                	sd	s5,24(sp)
 686:	e85a                	sd	s6,16(sp)
 688:	e45e                	sd	s7,8(sp)
 68a:	e062                	sd	s8,0(sp)
 68c:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 68e:	0005c903          	lbu	s2,0(a1)
 692:	18090c63          	beqz	s2,82a <vprintf+0x1b4>
 696:	8aaa                	mv	s5,a0
 698:	8bb2                	mv	s7,a2
 69a:	00158493          	add	s1,a1,1
  state = 0;
 69e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6a0:	02500a13          	li	s4,37
 6a4:	4b55                	li	s6,21
 6a6:	a839                	j	6c4 <vprintf+0x4e>
        putc(fd, c);
 6a8:	85ca                	mv	a1,s2
 6aa:	8556                	mv	a0,s5
 6ac:	00000097          	auipc	ra,0x0
 6b0:	efc080e7          	jalr	-260(ra) # 5a8 <putc>
 6b4:	a019                	j	6ba <vprintf+0x44>
    } else if(state == '%'){
 6b6:	01498d63          	beq	s3,s4,6d0 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 6ba:	0485                	add	s1,s1,1
 6bc:	fff4c903          	lbu	s2,-1(s1)
 6c0:	16090563          	beqz	s2,82a <vprintf+0x1b4>
    if(state == 0){
 6c4:	fe0999e3          	bnez	s3,6b6 <vprintf+0x40>
      if(c == '%'){
 6c8:	ff4910e3          	bne	s2,s4,6a8 <vprintf+0x32>
        state = '%';
 6cc:	89d2                	mv	s3,s4
 6ce:	b7f5                	j	6ba <vprintf+0x44>
      if(c == 'd'){
 6d0:	13490263          	beq	s2,s4,7f4 <vprintf+0x17e>
 6d4:	f9d9079b          	addw	a5,s2,-99
 6d8:	0ff7f793          	zext.b	a5,a5
 6dc:	12fb6563          	bltu	s6,a5,806 <vprintf+0x190>
 6e0:	f9d9079b          	addw	a5,s2,-99
 6e4:	0ff7f713          	zext.b	a4,a5
 6e8:	10eb6f63          	bltu	s6,a4,806 <vprintf+0x190>
 6ec:	00271793          	sll	a5,a4,0x2
 6f0:	00000717          	auipc	a4,0x0
 6f4:	3b070713          	add	a4,a4,944 # aa0 <malloc+0x178>
 6f8:	97ba                	add	a5,a5,a4
 6fa:	439c                	lw	a5,0(a5)
 6fc:	97ba                	add	a5,a5,a4
 6fe:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 700:	008b8913          	add	s2,s7,8
 704:	4685                	li	a3,1
 706:	4629                	li	a2,10
 708:	000ba583          	lw	a1,0(s7)
 70c:	8556                	mv	a0,s5
 70e:	00000097          	auipc	ra,0x0
 712:	ebc080e7          	jalr	-324(ra) # 5ca <printint>
 716:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 718:	4981                	li	s3,0
 71a:	b745                	j	6ba <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 71c:	008b8913          	add	s2,s7,8
 720:	4681                	li	a3,0
 722:	4629                	li	a2,10
 724:	000ba583          	lw	a1,0(s7)
 728:	8556                	mv	a0,s5
 72a:	00000097          	auipc	ra,0x0
 72e:	ea0080e7          	jalr	-352(ra) # 5ca <printint>
 732:	8bca                	mv	s7,s2
      state = 0;
 734:	4981                	li	s3,0
 736:	b751                	j	6ba <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 738:	008b8913          	add	s2,s7,8
 73c:	4681                	li	a3,0
 73e:	4641                	li	a2,16
 740:	000ba583          	lw	a1,0(s7)
 744:	8556                	mv	a0,s5
 746:	00000097          	auipc	ra,0x0
 74a:	e84080e7          	jalr	-380(ra) # 5ca <printint>
 74e:	8bca                	mv	s7,s2
      state = 0;
 750:	4981                	li	s3,0
 752:	b7a5                	j	6ba <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 754:	008b8c13          	add	s8,s7,8
 758:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 75c:	03000593          	li	a1,48
 760:	8556                	mv	a0,s5
 762:	00000097          	auipc	ra,0x0
 766:	e46080e7          	jalr	-442(ra) # 5a8 <putc>
  putc(fd, 'x');
 76a:	07800593          	li	a1,120
 76e:	8556                	mv	a0,s5
 770:	00000097          	auipc	ra,0x0
 774:	e38080e7          	jalr	-456(ra) # 5a8 <putc>
 778:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 77a:	00000b97          	auipc	s7,0x0
 77e:	37eb8b93          	add	s7,s7,894 # af8 <digits>
 782:	03c9d793          	srl	a5,s3,0x3c
 786:	97de                	add	a5,a5,s7
 788:	0007c583          	lbu	a1,0(a5)
 78c:	8556                	mv	a0,s5
 78e:	00000097          	auipc	ra,0x0
 792:	e1a080e7          	jalr	-486(ra) # 5a8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 796:	0992                	sll	s3,s3,0x4
 798:	397d                	addw	s2,s2,-1
 79a:	fe0914e3          	bnez	s2,782 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 79e:	8be2                	mv	s7,s8
      state = 0;
 7a0:	4981                	li	s3,0
 7a2:	bf21                	j	6ba <vprintf+0x44>
        s = va_arg(ap, char*);
 7a4:	008b8993          	add	s3,s7,8
 7a8:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 7ac:	02090163          	beqz	s2,7ce <vprintf+0x158>
        while(*s != 0){
 7b0:	00094583          	lbu	a1,0(s2)
 7b4:	c9a5                	beqz	a1,824 <vprintf+0x1ae>
          putc(fd, *s);
 7b6:	8556                	mv	a0,s5
 7b8:	00000097          	auipc	ra,0x0
 7bc:	df0080e7          	jalr	-528(ra) # 5a8 <putc>
          s++;
 7c0:	0905                	add	s2,s2,1
        while(*s != 0){
 7c2:	00094583          	lbu	a1,0(s2)
 7c6:	f9e5                	bnez	a1,7b6 <vprintf+0x140>
        s = va_arg(ap, char*);
 7c8:	8bce                	mv	s7,s3
      state = 0;
 7ca:	4981                	li	s3,0
 7cc:	b5fd                	j	6ba <vprintf+0x44>
          s = "(null)";
 7ce:	00000917          	auipc	s2,0x0
 7d2:	2ca90913          	add	s2,s2,714 # a98 <malloc+0x170>
        while(*s != 0){
 7d6:	02800593          	li	a1,40
 7da:	bff1                	j	7b6 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 7dc:	008b8913          	add	s2,s7,8
 7e0:	000bc583          	lbu	a1,0(s7)
 7e4:	8556                	mv	a0,s5
 7e6:	00000097          	auipc	ra,0x0
 7ea:	dc2080e7          	jalr	-574(ra) # 5a8 <putc>
 7ee:	8bca                	mv	s7,s2
      state = 0;
 7f0:	4981                	li	s3,0
 7f2:	b5e1                	j	6ba <vprintf+0x44>
        putc(fd, c);
 7f4:	02500593          	li	a1,37
 7f8:	8556                	mv	a0,s5
 7fa:	00000097          	auipc	ra,0x0
 7fe:	dae080e7          	jalr	-594(ra) # 5a8 <putc>
      state = 0;
 802:	4981                	li	s3,0
 804:	bd5d                	j	6ba <vprintf+0x44>
        putc(fd, '%');
 806:	02500593          	li	a1,37
 80a:	8556                	mv	a0,s5
 80c:	00000097          	auipc	ra,0x0
 810:	d9c080e7          	jalr	-612(ra) # 5a8 <putc>
        putc(fd, c);
 814:	85ca                	mv	a1,s2
 816:	8556                	mv	a0,s5
 818:	00000097          	auipc	ra,0x0
 81c:	d90080e7          	jalr	-624(ra) # 5a8 <putc>
      state = 0;
 820:	4981                	li	s3,0
 822:	bd61                	j	6ba <vprintf+0x44>
        s = va_arg(ap, char*);
 824:	8bce                	mv	s7,s3
      state = 0;
 826:	4981                	li	s3,0
 828:	bd49                	j	6ba <vprintf+0x44>
    }
  }
}
 82a:	60a6                	ld	ra,72(sp)
 82c:	6406                	ld	s0,64(sp)
 82e:	74e2                	ld	s1,56(sp)
 830:	7942                	ld	s2,48(sp)
 832:	79a2                	ld	s3,40(sp)
 834:	7a02                	ld	s4,32(sp)
 836:	6ae2                	ld	s5,24(sp)
 838:	6b42                	ld	s6,16(sp)
 83a:	6ba2                	ld	s7,8(sp)
 83c:	6c02                	ld	s8,0(sp)
 83e:	6161                	add	sp,sp,80
 840:	8082                	ret

0000000000000842 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 842:	715d                	add	sp,sp,-80
 844:	ec06                	sd	ra,24(sp)
 846:	e822                	sd	s0,16(sp)
 848:	1000                	add	s0,sp,32
 84a:	e010                	sd	a2,0(s0)
 84c:	e414                	sd	a3,8(s0)
 84e:	e818                	sd	a4,16(s0)
 850:	ec1c                	sd	a5,24(s0)
 852:	03043023          	sd	a6,32(s0)
 856:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 85a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 85e:	8622                	mv	a2,s0
 860:	00000097          	auipc	ra,0x0
 864:	e16080e7          	jalr	-490(ra) # 676 <vprintf>
}
 868:	60e2                	ld	ra,24(sp)
 86a:	6442                	ld	s0,16(sp)
 86c:	6161                	add	sp,sp,80
 86e:	8082                	ret

0000000000000870 <printf>:

void
printf(const char *fmt, ...)
{
 870:	711d                	add	sp,sp,-96
 872:	ec06                	sd	ra,24(sp)
 874:	e822                	sd	s0,16(sp)
 876:	1000                	add	s0,sp,32
 878:	e40c                	sd	a1,8(s0)
 87a:	e810                	sd	a2,16(s0)
 87c:	ec14                	sd	a3,24(s0)
 87e:	f018                	sd	a4,32(s0)
 880:	f41c                	sd	a5,40(s0)
 882:	03043823          	sd	a6,48(s0)
 886:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 88a:	00840613          	add	a2,s0,8
 88e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 892:	85aa                	mv	a1,a0
 894:	4505                	li	a0,1
 896:	00000097          	auipc	ra,0x0
 89a:	de0080e7          	jalr	-544(ra) # 676 <vprintf>
}
 89e:	60e2                	ld	ra,24(sp)
 8a0:	6442                	ld	s0,16(sp)
 8a2:	6125                	add	sp,sp,96
 8a4:	8082                	ret

00000000000008a6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8a6:	1141                	add	sp,sp,-16
 8a8:	e422                	sd	s0,8(sp)
 8aa:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8ac:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b0:	00000797          	auipc	a5,0x0
 8b4:	7507b783          	ld	a5,1872(a5) # 1000 <freep>
 8b8:	a02d                	j	8e2 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8ba:	4618                	lw	a4,8(a2)
 8bc:	9f2d                	addw	a4,a4,a1
 8be:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8c2:	6398                	ld	a4,0(a5)
 8c4:	6310                	ld	a2,0(a4)
 8c6:	a83d                	j	904 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8c8:	ff852703          	lw	a4,-8(a0)
 8cc:	9f31                	addw	a4,a4,a2
 8ce:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8d0:	ff053683          	ld	a3,-16(a0)
 8d4:	a091                	j	918 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d6:	6398                	ld	a4,0(a5)
 8d8:	00e7e463          	bltu	a5,a4,8e0 <free+0x3a>
 8dc:	00e6ea63          	bltu	a3,a4,8f0 <free+0x4a>
{
 8e0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e2:	fed7fae3          	bgeu	a5,a3,8d6 <free+0x30>
 8e6:	6398                	ld	a4,0(a5)
 8e8:	00e6e463          	bltu	a3,a4,8f0 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ec:	fee7eae3          	bltu	a5,a4,8e0 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8f0:	ff852583          	lw	a1,-8(a0)
 8f4:	6390                	ld	a2,0(a5)
 8f6:	02059813          	sll	a6,a1,0x20
 8fa:	01c85713          	srl	a4,a6,0x1c
 8fe:	9736                	add	a4,a4,a3
 900:	fae60de3          	beq	a2,a4,8ba <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 904:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 908:	4790                	lw	a2,8(a5)
 90a:	02061593          	sll	a1,a2,0x20
 90e:	01c5d713          	srl	a4,a1,0x1c
 912:	973e                	add	a4,a4,a5
 914:	fae68ae3          	beq	a3,a4,8c8 <free+0x22>
    p->s.ptr = bp->s.ptr;
 918:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 91a:	00000717          	auipc	a4,0x0
 91e:	6ef73323          	sd	a5,1766(a4) # 1000 <freep>
}
 922:	6422                	ld	s0,8(sp)
 924:	0141                	add	sp,sp,16
 926:	8082                	ret

0000000000000928 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 928:	7139                	add	sp,sp,-64
 92a:	fc06                	sd	ra,56(sp)
 92c:	f822                	sd	s0,48(sp)
 92e:	f426                	sd	s1,40(sp)
 930:	f04a                	sd	s2,32(sp)
 932:	ec4e                	sd	s3,24(sp)
 934:	e852                	sd	s4,16(sp)
 936:	e456                	sd	s5,8(sp)
 938:	e05a                	sd	s6,0(sp)
 93a:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 93c:	02051493          	sll	s1,a0,0x20
 940:	9081                	srl	s1,s1,0x20
 942:	04bd                	add	s1,s1,15
 944:	8091                	srl	s1,s1,0x4
 946:	0014899b          	addw	s3,s1,1
 94a:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 94c:	00000517          	auipc	a0,0x0
 950:	6b453503          	ld	a0,1716(a0) # 1000 <freep>
 954:	c515                	beqz	a0,980 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 956:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 958:	4798                	lw	a4,8(a5)
 95a:	02977f63          	bgeu	a4,s1,998 <malloc+0x70>
  if(nu < 4096)
 95e:	8a4e                	mv	s4,s3
 960:	0009871b          	sext.w	a4,s3
 964:	6685                	lui	a3,0x1
 966:	00d77363          	bgeu	a4,a3,96c <malloc+0x44>
 96a:	6a05                	lui	s4,0x1
 96c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 970:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 974:	00000917          	auipc	s2,0x0
 978:	68c90913          	add	s2,s2,1676 # 1000 <freep>
  if(p == (char*)-1)
 97c:	5afd                	li	s5,-1
 97e:	a895                	j	9f2 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 980:	00000797          	auipc	a5,0x0
 984:	69078793          	add	a5,a5,1680 # 1010 <base>
 988:	00000717          	auipc	a4,0x0
 98c:	66f73c23          	sd	a5,1656(a4) # 1000 <freep>
 990:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 992:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 996:	b7e1                	j	95e <malloc+0x36>
      if(p->s.size == nunits)
 998:	02e48c63          	beq	s1,a4,9d0 <malloc+0xa8>
        p->s.size -= nunits;
 99c:	4137073b          	subw	a4,a4,s3
 9a0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9a2:	02071693          	sll	a3,a4,0x20
 9a6:	01c6d713          	srl	a4,a3,0x1c
 9aa:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9ac:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9b0:	00000717          	auipc	a4,0x0
 9b4:	64a73823          	sd	a0,1616(a4) # 1000 <freep>
      return (void*)(p + 1);
 9b8:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9bc:	70e2                	ld	ra,56(sp)
 9be:	7442                	ld	s0,48(sp)
 9c0:	74a2                	ld	s1,40(sp)
 9c2:	7902                	ld	s2,32(sp)
 9c4:	69e2                	ld	s3,24(sp)
 9c6:	6a42                	ld	s4,16(sp)
 9c8:	6aa2                	ld	s5,8(sp)
 9ca:	6b02                	ld	s6,0(sp)
 9cc:	6121                	add	sp,sp,64
 9ce:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9d0:	6398                	ld	a4,0(a5)
 9d2:	e118                	sd	a4,0(a0)
 9d4:	bff1                	j	9b0 <malloc+0x88>
  hp->s.size = nu;
 9d6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9da:	0541                	add	a0,a0,16
 9dc:	00000097          	auipc	ra,0x0
 9e0:	eca080e7          	jalr	-310(ra) # 8a6 <free>
  return freep;
 9e4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9e8:	d971                	beqz	a0,9bc <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9ea:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9ec:	4798                	lw	a4,8(a5)
 9ee:	fa9775e3          	bgeu	a4,s1,998 <malloc+0x70>
    if(p == freep)
 9f2:	00093703          	ld	a4,0(s2)
 9f6:	853e                	mv	a0,a5
 9f8:	fef719e3          	bne	a4,a5,9ea <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 9fc:	8552                	mv	a0,s4
 9fe:	00000097          	auipc	ra,0x0
 a02:	b72080e7          	jalr	-1166(ra) # 570 <sbrk>
  if(p == (char*)-1)
 a06:	fd5518e3          	bne	a0,s5,9d6 <malloc+0xae>
        return 0;
 a0a:	4501                	li	a0,0
 a0c:	bf45                	j	9bc <malloc+0x94>
