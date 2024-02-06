
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	7119                	add	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	f4a6                	sd	s1,104(sp)
   8:	f0ca                	sd	s2,96(sp)
   a:	ecce                	sd	s3,88(sp)
   c:	e8d2                	sd	s4,80(sp)
   e:	e4d6                	sd	s5,72(sp)
  10:	e0da                	sd	s6,64(sp)
  12:	fc5e                	sd	s7,56(sp)
  14:	f862                	sd	s8,48(sp)
  16:	f466                	sd	s9,40(sp)
  18:	f06a                	sd	s10,32(sp)
  1a:	ec6e                	sd	s11,24(sp)
  1c:	0100                	add	s0,sp,128
  1e:	f8a43423          	sd	a0,-120(s0)
  22:	f8b43023          	sd	a1,-128(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  26:	4901                	li	s2,0
  l = w = c = 0;
  28:	4d01                	li	s10,0
  2a:	4c81                	li	s9,0
  2c:	4c01                	li	s8,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  2e:	00001d97          	auipc	s11,0x1
  32:	fe2d8d93          	add	s11,s11,-30 # 1010 <buf>
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  36:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  38:	00001a17          	auipc	s4,0x1
  3c:	958a0a13          	add	s4,s4,-1704 # 990 <malloc+0xe6>
        inword = 0;
  40:	4b81                	li	s7,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  42:	a805                	j	72 <wc+0x72>
      if(strchr(" \r\t\n\v", buf[i]))
  44:	8552                	mv	a0,s4
  46:	00000097          	auipc	ra,0x0
  4a:	1f2080e7          	jalr	498(ra) # 238 <strchr>
  4e:	c919                	beqz	a0,64 <wc+0x64>
        inword = 0;
  50:	895e                	mv	s2,s7
    for(i=0; i<n; i++){
  52:	0485                	add	s1,s1,1
  54:	00998d63          	beq	s3,s1,6e <wc+0x6e>
      if(buf[i] == '\n')
  58:	0004c583          	lbu	a1,0(s1)
  5c:	ff5594e3          	bne	a1,s5,44 <wc+0x44>
        l++;
  60:	2c05                	addw	s8,s8,1
  62:	b7cd                	j	44 <wc+0x44>
      else if(!inword){
  64:	fe0917e3          	bnez	s2,52 <wc+0x52>
        w++;
  68:	2c85                	addw	s9,s9,1
        inword = 1;
  6a:	4905                	li	s2,1
  6c:	b7dd                	j	52 <wc+0x52>
      c++;
  6e:	01ab0d3b          	addw	s10,s6,s10
  while((n = read(fd, buf, sizeof(buf))) > 0){
  72:	20000613          	li	a2,512
  76:	85ee                	mv	a1,s11
  78:	f8843503          	ld	a0,-120(s0)
  7c:	00000097          	auipc	ra,0x0
  80:	406080e7          	jalr	1030(ra) # 482 <read>
  84:	8b2a                	mv	s6,a0
  86:	00a05963          	blez	a0,98 <wc+0x98>
    for(i=0; i<n; i++){
  8a:	00001497          	auipc	s1,0x1
  8e:	f8648493          	add	s1,s1,-122 # 1010 <buf>
  92:	009509b3          	add	s3,a0,s1
  96:	b7c9                	j	58 <wc+0x58>
      }
    }
  }
  if(n < 0){
  98:	02054e63          	bltz	a0,d4 <wc+0xd4>
    printf("wc: read error\n");
    exit(1);
  }
  printf("%d %d %d %s\n", l, w, c, name);
  9c:	f8043703          	ld	a4,-128(s0)
  a0:	86ea                	mv	a3,s10
  a2:	8666                	mv	a2,s9
  a4:	85e2                	mv	a1,s8
  a6:	00001517          	auipc	a0,0x1
  aa:	90250513          	add	a0,a0,-1790 # 9a8 <malloc+0xfe>
  ae:	00000097          	auipc	ra,0x0
  b2:	744080e7          	jalr	1860(ra) # 7f2 <printf>
}
  b6:	70e6                	ld	ra,120(sp)
  b8:	7446                	ld	s0,112(sp)
  ba:	74a6                	ld	s1,104(sp)
  bc:	7906                	ld	s2,96(sp)
  be:	69e6                	ld	s3,88(sp)
  c0:	6a46                	ld	s4,80(sp)
  c2:	6aa6                	ld	s5,72(sp)
  c4:	6b06                	ld	s6,64(sp)
  c6:	7be2                	ld	s7,56(sp)
  c8:	7c42                	ld	s8,48(sp)
  ca:	7ca2                	ld	s9,40(sp)
  cc:	7d02                	ld	s10,32(sp)
  ce:	6de2                	ld	s11,24(sp)
  d0:	6109                	add	sp,sp,128
  d2:	8082                	ret
    printf("wc: read error\n");
  d4:	00001517          	auipc	a0,0x1
  d8:	8c450513          	add	a0,a0,-1852 # 998 <malloc+0xee>
  dc:	00000097          	auipc	ra,0x0
  e0:	716080e7          	jalr	1814(ra) # 7f2 <printf>
    exit(1);
  e4:	4505                	li	a0,1
  e6:	00000097          	auipc	ra,0x0
  ea:	384080e7          	jalr	900(ra) # 46a <exit>

00000000000000ee <main>:

int
main(int argc, char *argv[])
{
  ee:	7179                	add	sp,sp,-48
  f0:	f406                	sd	ra,40(sp)
  f2:	f022                	sd	s0,32(sp)
  f4:	ec26                	sd	s1,24(sp)
  f6:	e84a                	sd	s2,16(sp)
  f8:	e44e                	sd	s3,8(sp)
  fa:	1800                	add	s0,sp,48
  int fd, i;

  if(argc <= 1){
  fc:	4785                	li	a5,1
  fe:	04a7d963          	bge	a5,a0,150 <main+0x62>
 102:	00858913          	add	s2,a1,8
 106:	ffe5099b          	addw	s3,a0,-2
 10a:	02099793          	sll	a5,s3,0x20
 10e:	01d7d993          	srl	s3,a5,0x1d
 112:	05c1                	add	a1,a1,16
 114:	99ae                	add	s3,s3,a1
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], O_RDONLY)) < 0){
 116:	4581                	li	a1,0
 118:	00093503          	ld	a0,0(s2)
 11c:	00000097          	auipc	ra,0x0
 120:	38e080e7          	jalr	910(ra) # 4aa <open>
 124:	84aa                	mv	s1,a0
 126:	04054363          	bltz	a0,16c <main+0x7e>
      printf("wc: cannot open %s\n", argv[i]);
      exit(1);
    }
    wc(fd, argv[i]);
 12a:	00093583          	ld	a1,0(s2)
 12e:	00000097          	auipc	ra,0x0
 132:	ed2080e7          	jalr	-302(ra) # 0 <wc>
    close(fd);
 136:	8526                	mv	a0,s1
 138:	00000097          	auipc	ra,0x0
 13c:	35a080e7          	jalr	858(ra) # 492 <close>
  for(i = 1; i < argc; i++){
 140:	0921                	add	s2,s2,8
 142:	fd391ae3          	bne	s2,s3,116 <main+0x28>
  }
  exit(0);
 146:	4501                	li	a0,0
 148:	00000097          	auipc	ra,0x0
 14c:	322080e7          	jalr	802(ra) # 46a <exit>
    wc(0, "");
 150:	00001597          	auipc	a1,0x1
 154:	86858593          	add	a1,a1,-1944 # 9b8 <malloc+0x10e>
 158:	4501                	li	a0,0
 15a:	00000097          	auipc	ra,0x0
 15e:	ea6080e7          	jalr	-346(ra) # 0 <wc>
    exit(0);
 162:	4501                	li	a0,0
 164:	00000097          	auipc	ra,0x0
 168:	306080e7          	jalr	774(ra) # 46a <exit>
      printf("wc: cannot open %s\n", argv[i]);
 16c:	00093583          	ld	a1,0(s2)
 170:	00001517          	auipc	a0,0x1
 174:	85050513          	add	a0,a0,-1968 # 9c0 <malloc+0x116>
 178:	00000097          	auipc	ra,0x0
 17c:	67a080e7          	jalr	1658(ra) # 7f2 <printf>
      exit(1);
 180:	4505                	li	a0,1
 182:	00000097          	auipc	ra,0x0
 186:	2e8080e7          	jalr	744(ra) # 46a <exit>

000000000000018a <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 18a:	1141                	add	sp,sp,-16
 18c:	e406                	sd	ra,8(sp)
 18e:	e022                	sd	s0,0(sp)
 190:	0800                	add	s0,sp,16
  extern int main();
  main();
 192:	00000097          	auipc	ra,0x0
 196:	f5c080e7          	jalr	-164(ra) # ee <main>
  exit(0);
 19a:	4501                	li	a0,0
 19c:	00000097          	auipc	ra,0x0
 1a0:	2ce080e7          	jalr	718(ra) # 46a <exit>

00000000000001a4 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1a4:	1141                	add	sp,sp,-16
 1a6:	e422                	sd	s0,8(sp)
 1a8:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1aa:	87aa                	mv	a5,a0
 1ac:	0585                	add	a1,a1,1
 1ae:	0785                	add	a5,a5,1
 1b0:	fff5c703          	lbu	a4,-1(a1)
 1b4:	fee78fa3          	sb	a4,-1(a5)
 1b8:	fb75                	bnez	a4,1ac <strcpy+0x8>
    ;
  return os;
}
 1ba:	6422                	ld	s0,8(sp)
 1bc:	0141                	add	sp,sp,16
 1be:	8082                	ret

00000000000001c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1c0:	1141                	add	sp,sp,-16
 1c2:	e422                	sd	s0,8(sp)
 1c4:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 1c6:	00054783          	lbu	a5,0(a0)
 1ca:	cb91                	beqz	a5,1de <strcmp+0x1e>
 1cc:	0005c703          	lbu	a4,0(a1)
 1d0:	00f71763          	bne	a4,a5,1de <strcmp+0x1e>
    p++, q++;
 1d4:	0505                	add	a0,a0,1
 1d6:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 1d8:	00054783          	lbu	a5,0(a0)
 1dc:	fbe5                	bnez	a5,1cc <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1de:	0005c503          	lbu	a0,0(a1)
}
 1e2:	40a7853b          	subw	a0,a5,a0
 1e6:	6422                	ld	s0,8(sp)
 1e8:	0141                	add	sp,sp,16
 1ea:	8082                	ret

00000000000001ec <strlen>:

uint
strlen(const char *s)
{
 1ec:	1141                	add	sp,sp,-16
 1ee:	e422                	sd	s0,8(sp)
 1f0:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1f2:	00054783          	lbu	a5,0(a0)
 1f6:	cf91                	beqz	a5,212 <strlen+0x26>
 1f8:	0505                	add	a0,a0,1
 1fa:	87aa                	mv	a5,a0
 1fc:	86be                	mv	a3,a5
 1fe:	0785                	add	a5,a5,1
 200:	fff7c703          	lbu	a4,-1(a5)
 204:	ff65                	bnez	a4,1fc <strlen+0x10>
 206:	40a6853b          	subw	a0,a3,a0
 20a:	2505                	addw	a0,a0,1
    ;
  return n;
}
 20c:	6422                	ld	s0,8(sp)
 20e:	0141                	add	sp,sp,16
 210:	8082                	ret
  for(n = 0; s[n]; n++)
 212:	4501                	li	a0,0
 214:	bfe5                	j	20c <strlen+0x20>

0000000000000216 <memset>:

void*
memset(void *dst, int c, uint n)
{
 216:	1141                	add	sp,sp,-16
 218:	e422                	sd	s0,8(sp)
 21a:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 21c:	ca19                	beqz	a2,232 <memset+0x1c>
 21e:	87aa                	mv	a5,a0
 220:	1602                	sll	a2,a2,0x20
 222:	9201                	srl	a2,a2,0x20
 224:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 228:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 22c:	0785                	add	a5,a5,1
 22e:	fee79de3          	bne	a5,a4,228 <memset+0x12>
  }
  return dst;
}
 232:	6422                	ld	s0,8(sp)
 234:	0141                	add	sp,sp,16
 236:	8082                	ret

0000000000000238 <strchr>:

char*
strchr(const char *s, char c)
{
 238:	1141                	add	sp,sp,-16
 23a:	e422                	sd	s0,8(sp)
 23c:	0800                	add	s0,sp,16
  for(; *s; s++)
 23e:	00054783          	lbu	a5,0(a0)
 242:	cb99                	beqz	a5,258 <strchr+0x20>
    if(*s == c)
 244:	00f58763          	beq	a1,a5,252 <strchr+0x1a>
  for(; *s; s++)
 248:	0505                	add	a0,a0,1
 24a:	00054783          	lbu	a5,0(a0)
 24e:	fbfd                	bnez	a5,244 <strchr+0xc>
      return (char*)s;
  return 0;
 250:	4501                	li	a0,0
}
 252:	6422                	ld	s0,8(sp)
 254:	0141                	add	sp,sp,16
 256:	8082                	ret
  return 0;
 258:	4501                	li	a0,0
 25a:	bfe5                	j	252 <strchr+0x1a>

000000000000025c <strstr>:

char*
strstr(const char *str, const char *substr)
{
 25c:	1141                	add	sp,sp,-16
 25e:	e422                	sd	s0,8(sp)
 260:	0800                	add	s0,sp,16
  const char *a, *b = substr;
  if (*b == 0)
 262:	0005c803          	lbu	a6,0(a1)
 266:	02080a63          	beqz	a6,29a <strstr+0x3e>
    return (char*)str;
  for( ; *str != 0; str += 1) {
 26a:	00054783          	lbu	a5,0(a0)
 26e:	e799                	bnez	a5,27c <strstr+0x20>
      if (*a++ != *b++)
        break;
    }
    b = substr;
  }
  return 0;
 270:	4501                	li	a0,0
 272:	a025                	j	29a <strstr+0x3e>
  for( ; *str != 0; str += 1) {
 274:	0505                	add	a0,a0,1
 276:	00054783          	lbu	a5,0(a0)
 27a:	cf99                	beqz	a5,298 <strstr+0x3c>
    if (*str != *b)
 27c:	fef81ce3          	bne	a6,a5,274 <strstr+0x18>
 280:	87ae                	mv	a5,a1
 282:	86aa                	mv	a3,a0
      if (*b == 0)
 284:	0007c703          	lbu	a4,0(a5)
 288:	cb09                	beqz	a4,29a <strstr+0x3e>
      if (*a++ != *b++)
 28a:	0685                	add	a3,a3,1
 28c:	0785                	add	a5,a5,1
 28e:	fff6c603          	lbu	a2,-1(a3)
 292:	fee609e3          	beq	a2,a4,284 <strstr+0x28>
 296:	bff9                	j	274 <strstr+0x18>
  return 0;
 298:	4501                	li	a0,0
}
 29a:	6422                	ld	s0,8(sp)
 29c:	0141                	add	sp,sp,16
 29e:	8082                	ret

00000000000002a0 <gets>:

char*
gets(char *buf, int max)
{
 2a0:	711d                	add	sp,sp,-96
 2a2:	ec86                	sd	ra,88(sp)
 2a4:	e8a2                	sd	s0,80(sp)
 2a6:	e4a6                	sd	s1,72(sp)
 2a8:	e0ca                	sd	s2,64(sp)
 2aa:	fc4e                	sd	s3,56(sp)
 2ac:	f852                	sd	s4,48(sp)
 2ae:	f456                	sd	s5,40(sp)
 2b0:	f05a                	sd	s6,32(sp)
 2b2:	ec5e                	sd	s7,24(sp)
 2b4:	1080                	add	s0,sp,96
 2b6:	8baa                	mv	s7,a0
 2b8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2ba:	892a                	mv	s2,a0
 2bc:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2be:	4aa9                	li	s5,10
 2c0:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2c2:	89a6                	mv	s3,s1
 2c4:	2485                	addw	s1,s1,1
 2c6:	0344d863          	bge	s1,s4,2f6 <gets+0x56>
    cc = read(0, &c, 1);
 2ca:	4605                	li	a2,1
 2cc:	faf40593          	add	a1,s0,-81
 2d0:	4501                	li	a0,0
 2d2:	00000097          	auipc	ra,0x0
 2d6:	1b0080e7          	jalr	432(ra) # 482 <read>
    if(cc < 1)
 2da:	00a05e63          	blez	a0,2f6 <gets+0x56>
    buf[i++] = c;
 2de:	faf44783          	lbu	a5,-81(s0)
 2e2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2e6:	01578763          	beq	a5,s5,2f4 <gets+0x54>
 2ea:	0905                	add	s2,s2,1
 2ec:	fd679be3          	bne	a5,s6,2c2 <gets+0x22>
  for(i=0; i+1 < max; ){
 2f0:	89a6                	mv	s3,s1
 2f2:	a011                	j	2f6 <gets+0x56>
 2f4:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2f6:	99de                	add	s3,s3,s7
 2f8:	00098023          	sb	zero,0(s3)
  return buf;
}
 2fc:	855e                	mv	a0,s7
 2fe:	60e6                	ld	ra,88(sp)
 300:	6446                	ld	s0,80(sp)
 302:	64a6                	ld	s1,72(sp)
 304:	6906                	ld	s2,64(sp)
 306:	79e2                	ld	s3,56(sp)
 308:	7a42                	ld	s4,48(sp)
 30a:	7aa2                	ld	s5,40(sp)
 30c:	7b02                	ld	s6,32(sp)
 30e:	6be2                	ld	s7,24(sp)
 310:	6125                	add	sp,sp,96
 312:	8082                	ret

0000000000000314 <stat>:

int
stat(const char *n, struct stat *st)
{
 314:	1101                	add	sp,sp,-32
 316:	ec06                	sd	ra,24(sp)
 318:	e822                	sd	s0,16(sp)
 31a:	e426                	sd	s1,8(sp)
 31c:	e04a                	sd	s2,0(sp)
 31e:	1000                	add	s0,sp,32
 320:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 322:	4581                	li	a1,0
 324:	00000097          	auipc	ra,0x0
 328:	186080e7          	jalr	390(ra) # 4aa <open>
  if(fd < 0)
 32c:	02054563          	bltz	a0,356 <stat+0x42>
 330:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 332:	85ca                	mv	a1,s2
 334:	00000097          	auipc	ra,0x0
 338:	18e080e7          	jalr	398(ra) # 4c2 <fstat>
 33c:	892a                	mv	s2,a0
  close(fd);
 33e:	8526                	mv	a0,s1
 340:	00000097          	auipc	ra,0x0
 344:	152080e7          	jalr	338(ra) # 492 <close>
  return r;
}
 348:	854a                	mv	a0,s2
 34a:	60e2                	ld	ra,24(sp)
 34c:	6442                	ld	s0,16(sp)
 34e:	64a2                	ld	s1,8(sp)
 350:	6902                	ld	s2,0(sp)
 352:	6105                	add	sp,sp,32
 354:	8082                	ret
    return -1;
 356:	597d                	li	s2,-1
 358:	bfc5                	j	348 <stat+0x34>

000000000000035a <atoi>:

int
atoi(const char *s)
{
 35a:	1141                	add	sp,sp,-16
 35c:	e422                	sd	s0,8(sp)
 35e:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 360:	00054683          	lbu	a3,0(a0)
 364:	fd06879b          	addw	a5,a3,-48
 368:	0ff7f793          	zext.b	a5,a5
 36c:	4625                	li	a2,9
 36e:	02f66863          	bltu	a2,a5,39e <atoi+0x44>
 372:	872a                	mv	a4,a0
  n = 0;
 374:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 376:	0705                	add	a4,a4,1
 378:	0025179b          	sllw	a5,a0,0x2
 37c:	9fa9                	addw	a5,a5,a0
 37e:	0017979b          	sllw	a5,a5,0x1
 382:	9fb5                	addw	a5,a5,a3
 384:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 388:	00074683          	lbu	a3,0(a4)
 38c:	fd06879b          	addw	a5,a3,-48
 390:	0ff7f793          	zext.b	a5,a5
 394:	fef671e3          	bgeu	a2,a5,376 <atoi+0x1c>
  return n;
}
 398:	6422                	ld	s0,8(sp)
 39a:	0141                	add	sp,sp,16
 39c:	8082                	ret
  n = 0;
 39e:	4501                	li	a0,0
 3a0:	bfe5                	j	398 <atoi+0x3e>

00000000000003a2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3a2:	1141                	add	sp,sp,-16
 3a4:	e422                	sd	s0,8(sp)
 3a6:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3a8:	02b57463          	bgeu	a0,a1,3d0 <memmove+0x2e>
    while(n-- > 0)
 3ac:	00c05f63          	blez	a2,3ca <memmove+0x28>
 3b0:	1602                	sll	a2,a2,0x20
 3b2:	9201                	srl	a2,a2,0x20
 3b4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3b8:	872a                	mv	a4,a0
      *dst++ = *src++;
 3ba:	0585                	add	a1,a1,1
 3bc:	0705                	add	a4,a4,1
 3be:	fff5c683          	lbu	a3,-1(a1)
 3c2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3c6:	fee79ae3          	bne	a5,a4,3ba <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3ca:	6422                	ld	s0,8(sp)
 3cc:	0141                	add	sp,sp,16
 3ce:	8082                	ret
    dst += n;
 3d0:	00c50733          	add	a4,a0,a2
    src += n;
 3d4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3d6:	fec05ae3          	blez	a2,3ca <memmove+0x28>
 3da:	fff6079b          	addw	a5,a2,-1
 3de:	1782                	sll	a5,a5,0x20
 3e0:	9381                	srl	a5,a5,0x20
 3e2:	fff7c793          	not	a5,a5
 3e6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3e8:	15fd                	add	a1,a1,-1
 3ea:	177d                	add	a4,a4,-1
 3ec:	0005c683          	lbu	a3,0(a1)
 3f0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3f4:	fee79ae3          	bne	a5,a4,3e8 <memmove+0x46>
 3f8:	bfc9                	j	3ca <memmove+0x28>

00000000000003fa <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3fa:	1141                	add	sp,sp,-16
 3fc:	e422                	sd	s0,8(sp)
 3fe:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 400:	ca05                	beqz	a2,430 <memcmp+0x36>
 402:	fff6069b          	addw	a3,a2,-1
 406:	1682                	sll	a3,a3,0x20
 408:	9281                	srl	a3,a3,0x20
 40a:	0685                	add	a3,a3,1
 40c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 40e:	00054783          	lbu	a5,0(a0)
 412:	0005c703          	lbu	a4,0(a1)
 416:	00e79863          	bne	a5,a4,426 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 41a:	0505                	add	a0,a0,1
    p2++;
 41c:	0585                	add	a1,a1,1
  while (n-- > 0) {
 41e:	fed518e3          	bne	a0,a3,40e <memcmp+0x14>
  }
  return 0;
 422:	4501                	li	a0,0
 424:	a019                	j	42a <memcmp+0x30>
      return *p1 - *p2;
 426:	40e7853b          	subw	a0,a5,a4
}
 42a:	6422                	ld	s0,8(sp)
 42c:	0141                	add	sp,sp,16
 42e:	8082                	ret
  return 0;
 430:	4501                	li	a0,0
 432:	bfe5                	j	42a <memcmp+0x30>

0000000000000434 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 434:	1141                	add	sp,sp,-16
 436:	e406                	sd	ra,8(sp)
 438:	e022                	sd	s0,0(sp)
 43a:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 43c:	00000097          	auipc	ra,0x0
 440:	f66080e7          	jalr	-154(ra) # 3a2 <memmove>
}
 444:	60a2                	ld	ra,8(sp)
 446:	6402                	ld	s0,0(sp)
 448:	0141                	add	sp,sp,16
 44a:	8082                	ret

000000000000044c <ugetpid>:

int
ugetpid(void)
{
 44c:	1141                	add	sp,sp,-16
 44e:	e422                	sd	s0,8(sp)
 450:	0800                	add	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 452:	040007b7          	lui	a5,0x4000
}
 456:	17f5                	add	a5,a5,-3 # 3fffffd <base+0x3ffeded>
 458:	07b2                	sll	a5,a5,0xc
 45a:	4388                	lw	a0,0(a5)
 45c:	6422                	ld	s0,8(sp)
 45e:	0141                	add	sp,sp,16
 460:	8082                	ret

0000000000000462 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 462:	4885                	li	a7,1
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <exit>:
.global exit
exit:
 li a7, SYS_exit
 46a:	4889                	li	a7,2
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <wait>:
.global wait
wait:
 li a7, SYS_wait
 472:	488d                	li	a7,3
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 47a:	4891                	li	a7,4
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <read>:
.global read
read:
 li a7, SYS_read
 482:	4895                	li	a7,5
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <write>:
.global write
write:
 li a7, SYS_write
 48a:	48c1                	li	a7,16
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <close>:
.global close
close:
 li a7, SYS_close
 492:	48d5                	li	a7,21
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <kill>:
.global kill
kill:
 li a7, SYS_kill
 49a:	4899                	li	a7,6
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4a2:	489d                	li	a7,7
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <open>:
.global open
open:
 li a7, SYS_open
 4aa:	48bd                	li	a7,15
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4b2:	48c5                	li	a7,17
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4ba:	48c9                	li	a7,18
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4c2:	48a1                	li	a7,8
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <link>:
.global link
link:
 li a7, SYS_link
 4ca:	48cd                	li	a7,19
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4d2:	48d1                	li	a7,20
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4da:	48a5                	li	a7,9
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4e2:	48a9                	li	a7,10
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4ea:	48ad                	li	a7,11
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4f2:	48b1                	li	a7,12
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4fa:	48b5                	li	a7,13
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 502:	48b9                	li	a7,14
 ecall
 504:	00000073          	ecall
 ret
 508:	8082                	ret

000000000000050a <trace>:
.global trace
trace:
 li a7, SYS_trace
 50a:	48d9                	li	a7,22
 ecall
 50c:	00000073          	ecall
 ret
 510:	8082                	ret

0000000000000512 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 512:	48dd                	li	a7,23
 ecall
 514:	00000073          	ecall
 ret
 518:	8082                	ret

000000000000051a <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 51a:	48e1                	li	a7,24
 ecall
 51c:	00000073          	ecall
 ret
 520:	8082                	ret

0000000000000522 <setpriority>:
.global setpriority
setpriority:
 li a7, SYS_setpriority
 522:	48e5                	li	a7,25
 ecall
 524:	00000073          	ecall
 ret
 528:	8082                	ret

000000000000052a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 52a:	1101                	add	sp,sp,-32
 52c:	ec06                	sd	ra,24(sp)
 52e:	e822                	sd	s0,16(sp)
 530:	1000                	add	s0,sp,32
 532:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 536:	4605                	li	a2,1
 538:	fef40593          	add	a1,s0,-17
 53c:	00000097          	auipc	ra,0x0
 540:	f4e080e7          	jalr	-178(ra) # 48a <write>
}
 544:	60e2                	ld	ra,24(sp)
 546:	6442                	ld	s0,16(sp)
 548:	6105                	add	sp,sp,32
 54a:	8082                	ret

000000000000054c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 54c:	7139                	add	sp,sp,-64
 54e:	fc06                	sd	ra,56(sp)
 550:	f822                	sd	s0,48(sp)
 552:	f426                	sd	s1,40(sp)
 554:	f04a                	sd	s2,32(sp)
 556:	ec4e                	sd	s3,24(sp)
 558:	0080                	add	s0,sp,64
 55a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 55c:	c299                	beqz	a3,562 <printint+0x16>
 55e:	0805c963          	bltz	a1,5f0 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 562:	2581                	sext.w	a1,a1
  neg = 0;
 564:	4881                	li	a7,0
 566:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 56a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 56c:	2601                	sext.w	a2,a2
 56e:	00000517          	auipc	a0,0x0
 572:	4ca50513          	add	a0,a0,1226 # a38 <digits>
 576:	883a                	mv	a6,a4
 578:	2705                	addw	a4,a4,1
 57a:	02c5f7bb          	remuw	a5,a1,a2
 57e:	1782                	sll	a5,a5,0x20
 580:	9381                	srl	a5,a5,0x20
 582:	97aa                	add	a5,a5,a0
 584:	0007c783          	lbu	a5,0(a5)
 588:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 58c:	0005879b          	sext.w	a5,a1
 590:	02c5d5bb          	divuw	a1,a1,a2
 594:	0685                	add	a3,a3,1
 596:	fec7f0e3          	bgeu	a5,a2,576 <printint+0x2a>
  if(neg)
 59a:	00088c63          	beqz	a7,5b2 <printint+0x66>
    buf[i++] = '-';
 59e:	fd070793          	add	a5,a4,-48
 5a2:	00878733          	add	a4,a5,s0
 5a6:	02d00793          	li	a5,45
 5aa:	fef70823          	sb	a5,-16(a4)
 5ae:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 5b2:	02e05863          	blez	a4,5e2 <printint+0x96>
 5b6:	fc040793          	add	a5,s0,-64
 5ba:	00e78933          	add	s2,a5,a4
 5be:	fff78993          	add	s3,a5,-1
 5c2:	99ba                	add	s3,s3,a4
 5c4:	377d                	addw	a4,a4,-1
 5c6:	1702                	sll	a4,a4,0x20
 5c8:	9301                	srl	a4,a4,0x20
 5ca:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5ce:	fff94583          	lbu	a1,-1(s2)
 5d2:	8526                	mv	a0,s1
 5d4:	00000097          	auipc	ra,0x0
 5d8:	f56080e7          	jalr	-170(ra) # 52a <putc>
  while(--i >= 0)
 5dc:	197d                	add	s2,s2,-1
 5de:	ff3918e3          	bne	s2,s3,5ce <printint+0x82>
}
 5e2:	70e2                	ld	ra,56(sp)
 5e4:	7442                	ld	s0,48(sp)
 5e6:	74a2                	ld	s1,40(sp)
 5e8:	7902                	ld	s2,32(sp)
 5ea:	69e2                	ld	s3,24(sp)
 5ec:	6121                	add	sp,sp,64
 5ee:	8082                	ret
    x = -xx;
 5f0:	40b005bb          	negw	a1,a1
    neg = 1;
 5f4:	4885                	li	a7,1
    x = -xx;
 5f6:	bf85                	j	566 <printint+0x1a>

00000000000005f8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5f8:	715d                	add	sp,sp,-80
 5fa:	e486                	sd	ra,72(sp)
 5fc:	e0a2                	sd	s0,64(sp)
 5fe:	fc26                	sd	s1,56(sp)
 600:	f84a                	sd	s2,48(sp)
 602:	f44e                	sd	s3,40(sp)
 604:	f052                	sd	s4,32(sp)
 606:	ec56                	sd	s5,24(sp)
 608:	e85a                	sd	s6,16(sp)
 60a:	e45e                	sd	s7,8(sp)
 60c:	e062                	sd	s8,0(sp)
 60e:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 610:	0005c903          	lbu	s2,0(a1)
 614:	18090c63          	beqz	s2,7ac <vprintf+0x1b4>
 618:	8aaa                	mv	s5,a0
 61a:	8bb2                	mv	s7,a2
 61c:	00158493          	add	s1,a1,1
  state = 0;
 620:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 622:	02500a13          	li	s4,37
 626:	4b55                	li	s6,21
 628:	a839                	j	646 <vprintf+0x4e>
        putc(fd, c);
 62a:	85ca                	mv	a1,s2
 62c:	8556                	mv	a0,s5
 62e:	00000097          	auipc	ra,0x0
 632:	efc080e7          	jalr	-260(ra) # 52a <putc>
 636:	a019                	j	63c <vprintf+0x44>
    } else if(state == '%'){
 638:	01498d63          	beq	s3,s4,652 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 63c:	0485                	add	s1,s1,1
 63e:	fff4c903          	lbu	s2,-1(s1)
 642:	16090563          	beqz	s2,7ac <vprintf+0x1b4>
    if(state == 0){
 646:	fe0999e3          	bnez	s3,638 <vprintf+0x40>
      if(c == '%'){
 64a:	ff4910e3          	bne	s2,s4,62a <vprintf+0x32>
        state = '%';
 64e:	89d2                	mv	s3,s4
 650:	b7f5                	j	63c <vprintf+0x44>
      if(c == 'd'){
 652:	13490263          	beq	s2,s4,776 <vprintf+0x17e>
 656:	f9d9079b          	addw	a5,s2,-99
 65a:	0ff7f793          	zext.b	a5,a5
 65e:	12fb6563          	bltu	s6,a5,788 <vprintf+0x190>
 662:	f9d9079b          	addw	a5,s2,-99
 666:	0ff7f713          	zext.b	a4,a5
 66a:	10eb6f63          	bltu	s6,a4,788 <vprintf+0x190>
 66e:	00271793          	sll	a5,a4,0x2
 672:	00000717          	auipc	a4,0x0
 676:	36e70713          	add	a4,a4,878 # 9e0 <malloc+0x136>
 67a:	97ba                	add	a5,a5,a4
 67c:	439c                	lw	a5,0(a5)
 67e:	97ba                	add	a5,a5,a4
 680:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 682:	008b8913          	add	s2,s7,8
 686:	4685                	li	a3,1
 688:	4629                	li	a2,10
 68a:	000ba583          	lw	a1,0(s7)
 68e:	8556                	mv	a0,s5
 690:	00000097          	auipc	ra,0x0
 694:	ebc080e7          	jalr	-324(ra) # 54c <printint>
 698:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 69a:	4981                	li	s3,0
 69c:	b745                	j	63c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 69e:	008b8913          	add	s2,s7,8
 6a2:	4681                	li	a3,0
 6a4:	4629                	li	a2,10
 6a6:	000ba583          	lw	a1,0(s7)
 6aa:	8556                	mv	a0,s5
 6ac:	00000097          	auipc	ra,0x0
 6b0:	ea0080e7          	jalr	-352(ra) # 54c <printint>
 6b4:	8bca                	mv	s7,s2
      state = 0;
 6b6:	4981                	li	s3,0
 6b8:	b751                	j	63c <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 6ba:	008b8913          	add	s2,s7,8
 6be:	4681                	li	a3,0
 6c0:	4641                	li	a2,16
 6c2:	000ba583          	lw	a1,0(s7)
 6c6:	8556                	mv	a0,s5
 6c8:	00000097          	auipc	ra,0x0
 6cc:	e84080e7          	jalr	-380(ra) # 54c <printint>
 6d0:	8bca                	mv	s7,s2
      state = 0;
 6d2:	4981                	li	s3,0
 6d4:	b7a5                	j	63c <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 6d6:	008b8c13          	add	s8,s7,8
 6da:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6de:	03000593          	li	a1,48
 6e2:	8556                	mv	a0,s5
 6e4:	00000097          	auipc	ra,0x0
 6e8:	e46080e7          	jalr	-442(ra) # 52a <putc>
  putc(fd, 'x');
 6ec:	07800593          	li	a1,120
 6f0:	8556                	mv	a0,s5
 6f2:	00000097          	auipc	ra,0x0
 6f6:	e38080e7          	jalr	-456(ra) # 52a <putc>
 6fa:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6fc:	00000b97          	auipc	s7,0x0
 700:	33cb8b93          	add	s7,s7,828 # a38 <digits>
 704:	03c9d793          	srl	a5,s3,0x3c
 708:	97de                	add	a5,a5,s7
 70a:	0007c583          	lbu	a1,0(a5)
 70e:	8556                	mv	a0,s5
 710:	00000097          	auipc	ra,0x0
 714:	e1a080e7          	jalr	-486(ra) # 52a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 718:	0992                	sll	s3,s3,0x4
 71a:	397d                	addw	s2,s2,-1
 71c:	fe0914e3          	bnez	s2,704 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 720:	8be2                	mv	s7,s8
      state = 0;
 722:	4981                	li	s3,0
 724:	bf21                	j	63c <vprintf+0x44>
        s = va_arg(ap, char*);
 726:	008b8993          	add	s3,s7,8
 72a:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 72e:	02090163          	beqz	s2,750 <vprintf+0x158>
        while(*s != 0){
 732:	00094583          	lbu	a1,0(s2)
 736:	c9a5                	beqz	a1,7a6 <vprintf+0x1ae>
          putc(fd, *s);
 738:	8556                	mv	a0,s5
 73a:	00000097          	auipc	ra,0x0
 73e:	df0080e7          	jalr	-528(ra) # 52a <putc>
          s++;
 742:	0905                	add	s2,s2,1
        while(*s != 0){
 744:	00094583          	lbu	a1,0(s2)
 748:	f9e5                	bnez	a1,738 <vprintf+0x140>
        s = va_arg(ap, char*);
 74a:	8bce                	mv	s7,s3
      state = 0;
 74c:	4981                	li	s3,0
 74e:	b5fd                	j	63c <vprintf+0x44>
          s = "(null)";
 750:	00000917          	auipc	s2,0x0
 754:	28890913          	add	s2,s2,648 # 9d8 <malloc+0x12e>
        while(*s != 0){
 758:	02800593          	li	a1,40
 75c:	bff1                	j	738 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 75e:	008b8913          	add	s2,s7,8
 762:	000bc583          	lbu	a1,0(s7)
 766:	8556                	mv	a0,s5
 768:	00000097          	auipc	ra,0x0
 76c:	dc2080e7          	jalr	-574(ra) # 52a <putc>
 770:	8bca                	mv	s7,s2
      state = 0;
 772:	4981                	li	s3,0
 774:	b5e1                	j	63c <vprintf+0x44>
        putc(fd, c);
 776:	02500593          	li	a1,37
 77a:	8556                	mv	a0,s5
 77c:	00000097          	auipc	ra,0x0
 780:	dae080e7          	jalr	-594(ra) # 52a <putc>
      state = 0;
 784:	4981                	li	s3,0
 786:	bd5d                	j	63c <vprintf+0x44>
        putc(fd, '%');
 788:	02500593          	li	a1,37
 78c:	8556                	mv	a0,s5
 78e:	00000097          	auipc	ra,0x0
 792:	d9c080e7          	jalr	-612(ra) # 52a <putc>
        putc(fd, c);
 796:	85ca                	mv	a1,s2
 798:	8556                	mv	a0,s5
 79a:	00000097          	auipc	ra,0x0
 79e:	d90080e7          	jalr	-624(ra) # 52a <putc>
      state = 0;
 7a2:	4981                	li	s3,0
 7a4:	bd61                	j	63c <vprintf+0x44>
        s = va_arg(ap, char*);
 7a6:	8bce                	mv	s7,s3
      state = 0;
 7a8:	4981                	li	s3,0
 7aa:	bd49                	j	63c <vprintf+0x44>
    }
  }
}
 7ac:	60a6                	ld	ra,72(sp)
 7ae:	6406                	ld	s0,64(sp)
 7b0:	74e2                	ld	s1,56(sp)
 7b2:	7942                	ld	s2,48(sp)
 7b4:	79a2                	ld	s3,40(sp)
 7b6:	7a02                	ld	s4,32(sp)
 7b8:	6ae2                	ld	s5,24(sp)
 7ba:	6b42                	ld	s6,16(sp)
 7bc:	6ba2                	ld	s7,8(sp)
 7be:	6c02                	ld	s8,0(sp)
 7c0:	6161                	add	sp,sp,80
 7c2:	8082                	ret

00000000000007c4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7c4:	715d                	add	sp,sp,-80
 7c6:	ec06                	sd	ra,24(sp)
 7c8:	e822                	sd	s0,16(sp)
 7ca:	1000                	add	s0,sp,32
 7cc:	e010                	sd	a2,0(s0)
 7ce:	e414                	sd	a3,8(s0)
 7d0:	e818                	sd	a4,16(s0)
 7d2:	ec1c                	sd	a5,24(s0)
 7d4:	03043023          	sd	a6,32(s0)
 7d8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7dc:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7e0:	8622                	mv	a2,s0
 7e2:	00000097          	auipc	ra,0x0
 7e6:	e16080e7          	jalr	-490(ra) # 5f8 <vprintf>
}
 7ea:	60e2                	ld	ra,24(sp)
 7ec:	6442                	ld	s0,16(sp)
 7ee:	6161                	add	sp,sp,80
 7f0:	8082                	ret

00000000000007f2 <printf>:

void
printf(const char *fmt, ...)
{
 7f2:	711d                	add	sp,sp,-96
 7f4:	ec06                	sd	ra,24(sp)
 7f6:	e822                	sd	s0,16(sp)
 7f8:	1000                	add	s0,sp,32
 7fa:	e40c                	sd	a1,8(s0)
 7fc:	e810                	sd	a2,16(s0)
 7fe:	ec14                	sd	a3,24(s0)
 800:	f018                	sd	a4,32(s0)
 802:	f41c                	sd	a5,40(s0)
 804:	03043823          	sd	a6,48(s0)
 808:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 80c:	00840613          	add	a2,s0,8
 810:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 814:	85aa                	mv	a1,a0
 816:	4505                	li	a0,1
 818:	00000097          	auipc	ra,0x0
 81c:	de0080e7          	jalr	-544(ra) # 5f8 <vprintf>
}
 820:	60e2                	ld	ra,24(sp)
 822:	6442                	ld	s0,16(sp)
 824:	6125                	add	sp,sp,96
 826:	8082                	ret

0000000000000828 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 828:	1141                	add	sp,sp,-16
 82a:	e422                	sd	s0,8(sp)
 82c:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 82e:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 832:	00000797          	auipc	a5,0x0
 836:	7ce7b783          	ld	a5,1998(a5) # 1000 <freep>
 83a:	a02d                	j	864 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 83c:	4618                	lw	a4,8(a2)
 83e:	9f2d                	addw	a4,a4,a1
 840:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 844:	6398                	ld	a4,0(a5)
 846:	6310                	ld	a2,0(a4)
 848:	a83d                	j	886 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 84a:	ff852703          	lw	a4,-8(a0)
 84e:	9f31                	addw	a4,a4,a2
 850:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 852:	ff053683          	ld	a3,-16(a0)
 856:	a091                	j	89a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 858:	6398                	ld	a4,0(a5)
 85a:	00e7e463          	bltu	a5,a4,862 <free+0x3a>
 85e:	00e6ea63          	bltu	a3,a4,872 <free+0x4a>
{
 862:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 864:	fed7fae3          	bgeu	a5,a3,858 <free+0x30>
 868:	6398                	ld	a4,0(a5)
 86a:	00e6e463          	bltu	a3,a4,872 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 86e:	fee7eae3          	bltu	a5,a4,862 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 872:	ff852583          	lw	a1,-8(a0)
 876:	6390                	ld	a2,0(a5)
 878:	02059813          	sll	a6,a1,0x20
 87c:	01c85713          	srl	a4,a6,0x1c
 880:	9736                	add	a4,a4,a3
 882:	fae60de3          	beq	a2,a4,83c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 886:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 88a:	4790                	lw	a2,8(a5)
 88c:	02061593          	sll	a1,a2,0x20
 890:	01c5d713          	srl	a4,a1,0x1c
 894:	973e                	add	a4,a4,a5
 896:	fae68ae3          	beq	a3,a4,84a <free+0x22>
    p->s.ptr = bp->s.ptr;
 89a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 89c:	00000717          	auipc	a4,0x0
 8a0:	76f73223          	sd	a5,1892(a4) # 1000 <freep>
}
 8a4:	6422                	ld	s0,8(sp)
 8a6:	0141                	add	sp,sp,16
 8a8:	8082                	ret

00000000000008aa <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8aa:	7139                	add	sp,sp,-64
 8ac:	fc06                	sd	ra,56(sp)
 8ae:	f822                	sd	s0,48(sp)
 8b0:	f426                	sd	s1,40(sp)
 8b2:	f04a                	sd	s2,32(sp)
 8b4:	ec4e                	sd	s3,24(sp)
 8b6:	e852                	sd	s4,16(sp)
 8b8:	e456                	sd	s5,8(sp)
 8ba:	e05a                	sd	s6,0(sp)
 8bc:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8be:	02051493          	sll	s1,a0,0x20
 8c2:	9081                	srl	s1,s1,0x20
 8c4:	04bd                	add	s1,s1,15
 8c6:	8091                	srl	s1,s1,0x4
 8c8:	0014899b          	addw	s3,s1,1
 8cc:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 8ce:	00000517          	auipc	a0,0x0
 8d2:	73253503          	ld	a0,1842(a0) # 1000 <freep>
 8d6:	c515                	beqz	a0,902 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8da:	4798                	lw	a4,8(a5)
 8dc:	02977f63          	bgeu	a4,s1,91a <malloc+0x70>
  if(nu < 4096)
 8e0:	8a4e                	mv	s4,s3
 8e2:	0009871b          	sext.w	a4,s3
 8e6:	6685                	lui	a3,0x1
 8e8:	00d77363          	bgeu	a4,a3,8ee <malloc+0x44>
 8ec:	6a05                	lui	s4,0x1
 8ee:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8f2:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8f6:	00000917          	auipc	s2,0x0
 8fa:	70a90913          	add	s2,s2,1802 # 1000 <freep>
  if(p == (char*)-1)
 8fe:	5afd                	li	s5,-1
 900:	a895                	j	974 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 902:	00001797          	auipc	a5,0x1
 906:	90e78793          	add	a5,a5,-1778 # 1210 <base>
 90a:	00000717          	auipc	a4,0x0
 90e:	6ef73b23          	sd	a5,1782(a4) # 1000 <freep>
 912:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 914:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 918:	b7e1                	j	8e0 <malloc+0x36>
      if(p->s.size == nunits)
 91a:	02e48c63          	beq	s1,a4,952 <malloc+0xa8>
        p->s.size -= nunits;
 91e:	4137073b          	subw	a4,a4,s3
 922:	c798                	sw	a4,8(a5)
        p += p->s.size;
 924:	02071693          	sll	a3,a4,0x20
 928:	01c6d713          	srl	a4,a3,0x1c
 92c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 92e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 932:	00000717          	auipc	a4,0x0
 936:	6ca73723          	sd	a0,1742(a4) # 1000 <freep>
      return (void*)(p + 1);
 93a:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 93e:	70e2                	ld	ra,56(sp)
 940:	7442                	ld	s0,48(sp)
 942:	74a2                	ld	s1,40(sp)
 944:	7902                	ld	s2,32(sp)
 946:	69e2                	ld	s3,24(sp)
 948:	6a42                	ld	s4,16(sp)
 94a:	6aa2                	ld	s5,8(sp)
 94c:	6b02                	ld	s6,0(sp)
 94e:	6121                	add	sp,sp,64
 950:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 952:	6398                	ld	a4,0(a5)
 954:	e118                	sd	a4,0(a0)
 956:	bff1                	j	932 <malloc+0x88>
  hp->s.size = nu;
 958:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 95c:	0541                	add	a0,a0,16
 95e:	00000097          	auipc	ra,0x0
 962:	eca080e7          	jalr	-310(ra) # 828 <free>
  return freep;
 966:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 96a:	d971                	beqz	a0,93e <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 96c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 96e:	4798                	lw	a4,8(a5)
 970:	fa9775e3          	bgeu	a4,s1,91a <malloc+0x70>
    if(p == freep)
 974:	00093703          	ld	a4,0(s2)
 978:	853e                	mv	a0,a5
 97a:	fef719e3          	bne	a4,a5,96c <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 97e:	8552                	mv	a0,s4
 980:	00000097          	auipc	ra,0x0
 984:	b72080e7          	jalr	-1166(ra) # 4f2 <sbrk>
  if(p == (char*)-1)
 988:	fd5518e3          	bne	a0,s5,958 <malloc+0xae>
        return 0;
 98c:	4501                	li	a0,0
 98e:	bf45                	j	93e <malloc+0x94>
