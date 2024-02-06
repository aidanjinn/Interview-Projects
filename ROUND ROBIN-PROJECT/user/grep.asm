
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	7179                	add	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	add	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  16:	02e00a13          	li	s4,46
    if(matchhere(re, text))
  1a:	85a6                	mv	a1,s1
  1c:	854e                	mv	a0,s3
  1e:	00000097          	auipc	ra,0x0
  22:	030080e7          	jalr	48(ra) # 4e <matchhere>
  26:	e919                	bnez	a0,3c <matchstar+0x3c>
  }while(*text!='\0' && (*text++==c || c=='.'));
  28:	0004c783          	lbu	a5,0(s1)
  2c:	cb89                	beqz	a5,3e <matchstar+0x3e>
  2e:	0485                	add	s1,s1,1
  30:	2781                	sext.w	a5,a5
  32:	ff2784e3          	beq	a5,s2,1a <matchstar+0x1a>
  36:	ff4902e3          	beq	s2,s4,1a <matchstar+0x1a>
  3a:	a011                	j	3e <matchstar+0x3e>
      return 1;
  3c:	4505                	li	a0,1
  return 0;
}
  3e:	70a2                	ld	ra,40(sp)
  40:	7402                	ld	s0,32(sp)
  42:	64e2                	ld	s1,24(sp)
  44:	6942                	ld	s2,16(sp)
  46:	69a2                	ld	s3,8(sp)
  48:	6a02                	ld	s4,0(sp)
  4a:	6145                	add	sp,sp,48
  4c:	8082                	ret

000000000000004e <matchhere>:
  if(re[0] == '\0')
  4e:	00054703          	lbu	a4,0(a0)
  52:	cb3d                	beqz	a4,c8 <matchhere+0x7a>
{
  54:	1141                	add	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	add	s0,sp,16
  5c:	87aa                	mv	a5,a0
  if(re[1] == '*')
  5e:	00154683          	lbu	a3,1(a0)
  62:	02a00613          	li	a2,42
  66:	02c68563          	beq	a3,a2,90 <matchhere+0x42>
  if(re[0] == '$' && re[1] == '\0')
  6a:	02400613          	li	a2,36
  6e:	02c70a63          	beq	a4,a2,a2 <matchhere+0x54>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  72:	0005c683          	lbu	a3,0(a1)
  return 0;
  76:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  78:	ca81                	beqz	a3,88 <matchhere+0x3a>
  7a:	02e00613          	li	a2,46
  7e:	02c70d63          	beq	a4,a2,b8 <matchhere+0x6a>
  return 0;
  82:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  84:	02d70a63          	beq	a4,a3,b8 <matchhere+0x6a>
}
  88:	60a2                	ld	ra,8(sp)
  8a:	6402                	ld	s0,0(sp)
  8c:	0141                	add	sp,sp,16
  8e:	8082                	ret
    return matchstar(re[0], re+2, text);
  90:	862e                	mv	a2,a1
  92:	00250593          	add	a1,a0,2
  96:	853a                	mv	a0,a4
  98:	00000097          	auipc	ra,0x0
  9c:	f68080e7          	jalr	-152(ra) # 0 <matchstar>
  a0:	b7e5                	j	88 <matchhere+0x3a>
  if(re[0] == '$' && re[1] == '\0')
  a2:	c691                	beqz	a3,ae <matchhere+0x60>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  a4:	0005c683          	lbu	a3,0(a1)
  a8:	fee9                	bnez	a3,82 <matchhere+0x34>
  return 0;
  aa:	4501                	li	a0,0
  ac:	bff1                	j	88 <matchhere+0x3a>
    return *text == '\0';
  ae:	0005c503          	lbu	a0,0(a1)
  b2:	00153513          	seqz	a0,a0
  b6:	bfc9                	j	88 <matchhere+0x3a>
    return matchhere(re+1, text+1);
  b8:	0585                	add	a1,a1,1
  ba:	00178513          	add	a0,a5,1
  be:	00000097          	auipc	ra,0x0
  c2:	f90080e7          	jalr	-112(ra) # 4e <matchhere>
  c6:	b7c9                	j	88 <matchhere+0x3a>
    return 1;
  c8:	4505                	li	a0,1
}
  ca:	8082                	ret

00000000000000cc <match>:
{
  cc:	1101                	add	sp,sp,-32
  ce:	ec06                	sd	ra,24(sp)
  d0:	e822                	sd	s0,16(sp)
  d2:	e426                	sd	s1,8(sp)
  d4:	e04a                	sd	s2,0(sp)
  d6:	1000                	add	s0,sp,32
  d8:	892a                	mv	s2,a0
  da:	84ae                	mv	s1,a1
  if(re[0] == '^')
  dc:	00054703          	lbu	a4,0(a0)
  e0:	05e00793          	li	a5,94
  e4:	00f70e63          	beq	a4,a5,100 <match+0x34>
    if(matchhere(re, text))
  e8:	85a6                	mv	a1,s1
  ea:	854a                	mv	a0,s2
  ec:	00000097          	auipc	ra,0x0
  f0:	f62080e7          	jalr	-158(ra) # 4e <matchhere>
  f4:	ed01                	bnez	a0,10c <match+0x40>
  }while(*text++ != '\0');
  f6:	0485                	add	s1,s1,1
  f8:	fff4c783          	lbu	a5,-1(s1)
  fc:	f7f5                	bnez	a5,e8 <match+0x1c>
  fe:	a801                	j	10e <match+0x42>
    return matchhere(re+1, text);
 100:	0505                	add	a0,a0,1
 102:	00000097          	auipc	ra,0x0
 106:	f4c080e7          	jalr	-180(ra) # 4e <matchhere>
 10a:	a011                	j	10e <match+0x42>
      return 1;
 10c:	4505                	li	a0,1
}
 10e:	60e2                	ld	ra,24(sp)
 110:	6442                	ld	s0,16(sp)
 112:	64a2                	ld	s1,8(sp)
 114:	6902                	ld	s2,0(sp)
 116:	6105                	add	sp,sp,32
 118:	8082                	ret

000000000000011a <grep>:
{
 11a:	715d                	add	sp,sp,-80
 11c:	e486                	sd	ra,72(sp)
 11e:	e0a2                	sd	s0,64(sp)
 120:	fc26                	sd	s1,56(sp)
 122:	f84a                	sd	s2,48(sp)
 124:	f44e                	sd	s3,40(sp)
 126:	f052                	sd	s4,32(sp)
 128:	ec56                	sd	s5,24(sp)
 12a:	e85a                	sd	s6,16(sp)
 12c:	e45e                	sd	s7,8(sp)
 12e:	e062                	sd	s8,0(sp)
 130:	0880                	add	s0,sp,80
 132:	89aa                	mv	s3,a0
 134:	8b2e                	mv	s6,a1
  m = 0;
 136:	4a01                	li	s4,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 138:	3ff00b93          	li	s7,1023
 13c:	00001a97          	auipc	s5,0x1
 140:	ed4a8a93          	add	s5,s5,-300 # 1010 <buf>
 144:	a0a1                	j	18c <grep+0x72>
      p = q+1;
 146:	00148913          	add	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 14a:	45a9                	li	a1,10
 14c:	854a                	mv	a0,s2
 14e:	00000097          	auipc	ra,0x0
 152:	20a080e7          	jalr	522(ra) # 358 <strchr>
 156:	84aa                	mv	s1,a0
 158:	c905                	beqz	a0,188 <grep+0x6e>
      *q = 0;
 15a:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
 15e:	85ca                	mv	a1,s2
 160:	854e                	mv	a0,s3
 162:	00000097          	auipc	ra,0x0
 166:	f6a080e7          	jalr	-150(ra) # cc <match>
 16a:	dd71                	beqz	a0,146 <grep+0x2c>
        *q = '\n';
 16c:	47a9                	li	a5,10
 16e:	00f48023          	sb	a5,0(s1)
        write(1, p, q+1 - p);
 172:	00148613          	add	a2,s1,1
 176:	4126063b          	subw	a2,a2,s2
 17a:	85ca                	mv	a1,s2
 17c:	4505                	li	a0,1
 17e:	00000097          	auipc	ra,0x0
 182:	42c080e7          	jalr	1068(ra) # 5aa <write>
 186:	b7c1                	j	146 <grep+0x2c>
    if(m > 0){
 188:	03404763          	bgtz	s4,1b6 <grep+0x9c>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 18c:	414b863b          	subw	a2,s7,s4
 190:	014a85b3          	add	a1,s5,s4
 194:	855a                	mv	a0,s6
 196:	00000097          	auipc	ra,0x0
 19a:	40c080e7          	jalr	1036(ra) # 5a2 <read>
 19e:	02a05b63          	blez	a0,1d4 <grep+0xba>
    m += n;
 1a2:	00aa0c3b          	addw	s8,s4,a0
 1a6:	000c0a1b          	sext.w	s4,s8
    buf[m] = '\0';
 1aa:	014a87b3          	add	a5,s5,s4
 1ae:	00078023          	sb	zero,0(a5)
    p = buf;
 1b2:	8956                	mv	s2,s5
    while((q = strchr(p, '\n')) != 0){
 1b4:	bf59                	j	14a <grep+0x30>
      m -= p - buf;
 1b6:	00001517          	auipc	a0,0x1
 1ba:	e5a50513          	add	a0,a0,-422 # 1010 <buf>
 1be:	40a90a33          	sub	s4,s2,a0
 1c2:	414c0a3b          	subw	s4,s8,s4
      memmove(buf, p, m);
 1c6:	8652                	mv	a2,s4
 1c8:	85ca                	mv	a1,s2
 1ca:	00000097          	auipc	ra,0x0
 1ce:	2f8080e7          	jalr	760(ra) # 4c2 <memmove>
 1d2:	bf6d                	j	18c <grep+0x72>
}
 1d4:	60a6                	ld	ra,72(sp)
 1d6:	6406                	ld	s0,64(sp)
 1d8:	74e2                	ld	s1,56(sp)
 1da:	7942                	ld	s2,48(sp)
 1dc:	79a2                	ld	s3,40(sp)
 1de:	7a02                	ld	s4,32(sp)
 1e0:	6ae2                	ld	s5,24(sp)
 1e2:	6b42                	ld	s6,16(sp)
 1e4:	6ba2                	ld	s7,8(sp)
 1e6:	6c02                	ld	s8,0(sp)
 1e8:	6161                	add	sp,sp,80
 1ea:	8082                	ret

00000000000001ec <main>:
{
 1ec:	7179                	add	sp,sp,-48
 1ee:	f406                	sd	ra,40(sp)
 1f0:	f022                	sd	s0,32(sp)
 1f2:	ec26                	sd	s1,24(sp)
 1f4:	e84a                	sd	s2,16(sp)
 1f6:	e44e                	sd	s3,8(sp)
 1f8:	e052                	sd	s4,0(sp)
 1fa:	1800                	add	s0,sp,48
  if(argc <= 1){
 1fc:	4785                	li	a5,1
 1fe:	04a7de63          	bge	a5,a0,25a <main+0x6e>
  pattern = argv[1];
 202:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
 206:	4789                	li	a5,2
 208:	06a7d763          	bge	a5,a0,276 <main+0x8a>
 20c:	01058913          	add	s2,a1,16
 210:	ffd5099b          	addw	s3,a0,-3
 214:	02099793          	sll	a5,s3,0x20
 218:	01d7d993          	srl	s3,a5,0x1d
 21c:	05e1                	add	a1,a1,24
 21e:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], O_RDONLY)) < 0){
 220:	4581                	li	a1,0
 222:	00093503          	ld	a0,0(s2)
 226:	00000097          	auipc	ra,0x0
 22a:	3a4080e7          	jalr	932(ra) # 5ca <open>
 22e:	84aa                	mv	s1,a0
 230:	04054e63          	bltz	a0,28c <main+0xa0>
    grep(pattern, fd);
 234:	85aa                	mv	a1,a0
 236:	8552                	mv	a0,s4
 238:	00000097          	auipc	ra,0x0
 23c:	ee2080e7          	jalr	-286(ra) # 11a <grep>
    close(fd);
 240:	8526                	mv	a0,s1
 242:	00000097          	auipc	ra,0x0
 246:	370080e7          	jalr	880(ra) # 5b2 <close>
  for(i = 2; i < argc; i++){
 24a:	0921                	add	s2,s2,8
 24c:	fd391ae3          	bne	s2,s3,220 <main+0x34>
  exit(0);
 250:	4501                	li	a0,0
 252:	00000097          	auipc	ra,0x0
 256:	338080e7          	jalr	824(ra) # 58a <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 25a:	00001597          	auipc	a1,0x1
 25e:	85658593          	add	a1,a1,-1962 # ab0 <malloc+0xe6>
 262:	4509                	li	a0,2
 264:	00000097          	auipc	ra,0x0
 268:	680080e7          	jalr	1664(ra) # 8e4 <fprintf>
    exit(1);
 26c:	4505                	li	a0,1
 26e:	00000097          	auipc	ra,0x0
 272:	31c080e7          	jalr	796(ra) # 58a <exit>
    grep(pattern, 0);
 276:	4581                	li	a1,0
 278:	8552                	mv	a0,s4
 27a:	00000097          	auipc	ra,0x0
 27e:	ea0080e7          	jalr	-352(ra) # 11a <grep>
    exit(0);
 282:	4501                	li	a0,0
 284:	00000097          	auipc	ra,0x0
 288:	306080e7          	jalr	774(ra) # 58a <exit>
      printf("grep: cannot open %s\n", argv[i]);
 28c:	00093583          	ld	a1,0(s2)
 290:	00001517          	auipc	a0,0x1
 294:	84050513          	add	a0,a0,-1984 # ad0 <malloc+0x106>
 298:	00000097          	auipc	ra,0x0
 29c:	67a080e7          	jalr	1658(ra) # 912 <printf>
      exit(1);
 2a0:	4505                	li	a0,1
 2a2:	00000097          	auipc	ra,0x0
 2a6:	2e8080e7          	jalr	744(ra) # 58a <exit>

00000000000002aa <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 2aa:	1141                	add	sp,sp,-16
 2ac:	e406                	sd	ra,8(sp)
 2ae:	e022                	sd	s0,0(sp)
 2b0:	0800                	add	s0,sp,16
  extern int main();
  main();
 2b2:	00000097          	auipc	ra,0x0
 2b6:	f3a080e7          	jalr	-198(ra) # 1ec <main>
  exit(0);
 2ba:	4501                	li	a0,0
 2bc:	00000097          	auipc	ra,0x0
 2c0:	2ce080e7          	jalr	718(ra) # 58a <exit>

00000000000002c4 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 2c4:	1141                	add	sp,sp,-16
 2c6:	e422                	sd	s0,8(sp)
 2c8:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2ca:	87aa                	mv	a5,a0
 2cc:	0585                	add	a1,a1,1
 2ce:	0785                	add	a5,a5,1
 2d0:	fff5c703          	lbu	a4,-1(a1)
 2d4:	fee78fa3          	sb	a4,-1(a5)
 2d8:	fb75                	bnez	a4,2cc <strcpy+0x8>
    ;
  return os;
}
 2da:	6422                	ld	s0,8(sp)
 2dc:	0141                	add	sp,sp,16
 2de:	8082                	ret

00000000000002e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2e0:	1141                	add	sp,sp,-16
 2e2:	e422                	sd	s0,8(sp)
 2e4:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 2e6:	00054783          	lbu	a5,0(a0)
 2ea:	cb91                	beqz	a5,2fe <strcmp+0x1e>
 2ec:	0005c703          	lbu	a4,0(a1)
 2f0:	00f71763          	bne	a4,a5,2fe <strcmp+0x1e>
    p++, q++;
 2f4:	0505                	add	a0,a0,1
 2f6:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 2f8:	00054783          	lbu	a5,0(a0)
 2fc:	fbe5                	bnez	a5,2ec <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2fe:	0005c503          	lbu	a0,0(a1)
}
 302:	40a7853b          	subw	a0,a5,a0
 306:	6422                	ld	s0,8(sp)
 308:	0141                	add	sp,sp,16
 30a:	8082                	ret

000000000000030c <strlen>:

uint
strlen(const char *s)
{
 30c:	1141                	add	sp,sp,-16
 30e:	e422                	sd	s0,8(sp)
 310:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 312:	00054783          	lbu	a5,0(a0)
 316:	cf91                	beqz	a5,332 <strlen+0x26>
 318:	0505                	add	a0,a0,1
 31a:	87aa                	mv	a5,a0
 31c:	86be                	mv	a3,a5
 31e:	0785                	add	a5,a5,1
 320:	fff7c703          	lbu	a4,-1(a5)
 324:	ff65                	bnez	a4,31c <strlen+0x10>
 326:	40a6853b          	subw	a0,a3,a0
 32a:	2505                	addw	a0,a0,1
    ;
  return n;
}
 32c:	6422                	ld	s0,8(sp)
 32e:	0141                	add	sp,sp,16
 330:	8082                	ret
  for(n = 0; s[n]; n++)
 332:	4501                	li	a0,0
 334:	bfe5                	j	32c <strlen+0x20>

0000000000000336 <memset>:

void*
memset(void *dst, int c, uint n)
{
 336:	1141                	add	sp,sp,-16
 338:	e422                	sd	s0,8(sp)
 33a:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 33c:	ca19                	beqz	a2,352 <memset+0x1c>
 33e:	87aa                	mv	a5,a0
 340:	1602                	sll	a2,a2,0x20
 342:	9201                	srl	a2,a2,0x20
 344:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 348:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 34c:	0785                	add	a5,a5,1
 34e:	fee79de3          	bne	a5,a4,348 <memset+0x12>
  }
  return dst;
}
 352:	6422                	ld	s0,8(sp)
 354:	0141                	add	sp,sp,16
 356:	8082                	ret

0000000000000358 <strchr>:

char*
strchr(const char *s, char c)
{
 358:	1141                	add	sp,sp,-16
 35a:	e422                	sd	s0,8(sp)
 35c:	0800                	add	s0,sp,16
  for(; *s; s++)
 35e:	00054783          	lbu	a5,0(a0)
 362:	cb99                	beqz	a5,378 <strchr+0x20>
    if(*s == c)
 364:	00f58763          	beq	a1,a5,372 <strchr+0x1a>
  for(; *s; s++)
 368:	0505                	add	a0,a0,1
 36a:	00054783          	lbu	a5,0(a0)
 36e:	fbfd                	bnez	a5,364 <strchr+0xc>
      return (char*)s;
  return 0;
 370:	4501                	li	a0,0
}
 372:	6422                	ld	s0,8(sp)
 374:	0141                	add	sp,sp,16
 376:	8082                	ret
  return 0;
 378:	4501                	li	a0,0
 37a:	bfe5                	j	372 <strchr+0x1a>

000000000000037c <strstr>:

char*
strstr(const char *str, const char *substr)
{
 37c:	1141                	add	sp,sp,-16
 37e:	e422                	sd	s0,8(sp)
 380:	0800                	add	s0,sp,16
  const char *a, *b = substr;
  if (*b == 0)
 382:	0005c803          	lbu	a6,0(a1)
 386:	02080a63          	beqz	a6,3ba <strstr+0x3e>
    return (char*)str;
  for( ; *str != 0; str += 1) {
 38a:	00054783          	lbu	a5,0(a0)
 38e:	e799                	bnez	a5,39c <strstr+0x20>
      if (*a++ != *b++)
        break;
    }
    b = substr;
  }
  return 0;
 390:	4501                	li	a0,0
 392:	a025                	j	3ba <strstr+0x3e>
  for( ; *str != 0; str += 1) {
 394:	0505                	add	a0,a0,1
 396:	00054783          	lbu	a5,0(a0)
 39a:	cf99                	beqz	a5,3b8 <strstr+0x3c>
    if (*str != *b)
 39c:	fef81ce3          	bne	a6,a5,394 <strstr+0x18>
 3a0:	87ae                	mv	a5,a1
 3a2:	86aa                	mv	a3,a0
      if (*b == 0)
 3a4:	0007c703          	lbu	a4,0(a5)
 3a8:	cb09                	beqz	a4,3ba <strstr+0x3e>
      if (*a++ != *b++)
 3aa:	0685                	add	a3,a3,1
 3ac:	0785                	add	a5,a5,1
 3ae:	fff6c603          	lbu	a2,-1(a3)
 3b2:	fee609e3          	beq	a2,a4,3a4 <strstr+0x28>
 3b6:	bff9                	j	394 <strstr+0x18>
  return 0;
 3b8:	4501                	li	a0,0
}
 3ba:	6422                	ld	s0,8(sp)
 3bc:	0141                	add	sp,sp,16
 3be:	8082                	ret

00000000000003c0 <gets>:

char*
gets(char *buf, int max)
{
 3c0:	711d                	add	sp,sp,-96
 3c2:	ec86                	sd	ra,88(sp)
 3c4:	e8a2                	sd	s0,80(sp)
 3c6:	e4a6                	sd	s1,72(sp)
 3c8:	e0ca                	sd	s2,64(sp)
 3ca:	fc4e                	sd	s3,56(sp)
 3cc:	f852                	sd	s4,48(sp)
 3ce:	f456                	sd	s5,40(sp)
 3d0:	f05a                	sd	s6,32(sp)
 3d2:	ec5e                	sd	s7,24(sp)
 3d4:	1080                	add	s0,sp,96
 3d6:	8baa                	mv	s7,a0
 3d8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3da:	892a                	mv	s2,a0
 3dc:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3de:	4aa9                	li	s5,10
 3e0:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3e2:	89a6                	mv	s3,s1
 3e4:	2485                	addw	s1,s1,1
 3e6:	0344d863          	bge	s1,s4,416 <gets+0x56>
    cc = read(0, &c, 1);
 3ea:	4605                	li	a2,1
 3ec:	faf40593          	add	a1,s0,-81
 3f0:	4501                	li	a0,0
 3f2:	00000097          	auipc	ra,0x0
 3f6:	1b0080e7          	jalr	432(ra) # 5a2 <read>
    if(cc < 1)
 3fa:	00a05e63          	blez	a0,416 <gets+0x56>
    buf[i++] = c;
 3fe:	faf44783          	lbu	a5,-81(s0)
 402:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 406:	01578763          	beq	a5,s5,414 <gets+0x54>
 40a:	0905                	add	s2,s2,1
 40c:	fd679be3          	bne	a5,s6,3e2 <gets+0x22>
  for(i=0; i+1 < max; ){
 410:	89a6                	mv	s3,s1
 412:	a011                	j	416 <gets+0x56>
 414:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 416:	99de                	add	s3,s3,s7
 418:	00098023          	sb	zero,0(s3)
  return buf;
}
 41c:	855e                	mv	a0,s7
 41e:	60e6                	ld	ra,88(sp)
 420:	6446                	ld	s0,80(sp)
 422:	64a6                	ld	s1,72(sp)
 424:	6906                	ld	s2,64(sp)
 426:	79e2                	ld	s3,56(sp)
 428:	7a42                	ld	s4,48(sp)
 42a:	7aa2                	ld	s5,40(sp)
 42c:	7b02                	ld	s6,32(sp)
 42e:	6be2                	ld	s7,24(sp)
 430:	6125                	add	sp,sp,96
 432:	8082                	ret

0000000000000434 <stat>:

int
stat(const char *n, struct stat *st)
{
 434:	1101                	add	sp,sp,-32
 436:	ec06                	sd	ra,24(sp)
 438:	e822                	sd	s0,16(sp)
 43a:	e426                	sd	s1,8(sp)
 43c:	e04a                	sd	s2,0(sp)
 43e:	1000                	add	s0,sp,32
 440:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 442:	4581                	li	a1,0
 444:	00000097          	auipc	ra,0x0
 448:	186080e7          	jalr	390(ra) # 5ca <open>
  if(fd < 0)
 44c:	02054563          	bltz	a0,476 <stat+0x42>
 450:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 452:	85ca                	mv	a1,s2
 454:	00000097          	auipc	ra,0x0
 458:	18e080e7          	jalr	398(ra) # 5e2 <fstat>
 45c:	892a                	mv	s2,a0
  close(fd);
 45e:	8526                	mv	a0,s1
 460:	00000097          	auipc	ra,0x0
 464:	152080e7          	jalr	338(ra) # 5b2 <close>
  return r;
}
 468:	854a                	mv	a0,s2
 46a:	60e2                	ld	ra,24(sp)
 46c:	6442                	ld	s0,16(sp)
 46e:	64a2                	ld	s1,8(sp)
 470:	6902                	ld	s2,0(sp)
 472:	6105                	add	sp,sp,32
 474:	8082                	ret
    return -1;
 476:	597d                	li	s2,-1
 478:	bfc5                	j	468 <stat+0x34>

000000000000047a <atoi>:

int
atoi(const char *s)
{
 47a:	1141                	add	sp,sp,-16
 47c:	e422                	sd	s0,8(sp)
 47e:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 480:	00054683          	lbu	a3,0(a0)
 484:	fd06879b          	addw	a5,a3,-48
 488:	0ff7f793          	zext.b	a5,a5
 48c:	4625                	li	a2,9
 48e:	02f66863          	bltu	a2,a5,4be <atoi+0x44>
 492:	872a                	mv	a4,a0
  n = 0;
 494:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 496:	0705                	add	a4,a4,1
 498:	0025179b          	sllw	a5,a0,0x2
 49c:	9fa9                	addw	a5,a5,a0
 49e:	0017979b          	sllw	a5,a5,0x1
 4a2:	9fb5                	addw	a5,a5,a3
 4a4:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4a8:	00074683          	lbu	a3,0(a4)
 4ac:	fd06879b          	addw	a5,a3,-48
 4b0:	0ff7f793          	zext.b	a5,a5
 4b4:	fef671e3          	bgeu	a2,a5,496 <atoi+0x1c>
  return n;
}
 4b8:	6422                	ld	s0,8(sp)
 4ba:	0141                	add	sp,sp,16
 4bc:	8082                	ret
  n = 0;
 4be:	4501                	li	a0,0
 4c0:	bfe5                	j	4b8 <atoi+0x3e>

00000000000004c2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4c2:	1141                	add	sp,sp,-16
 4c4:	e422                	sd	s0,8(sp)
 4c6:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4c8:	02b57463          	bgeu	a0,a1,4f0 <memmove+0x2e>
    while(n-- > 0)
 4cc:	00c05f63          	blez	a2,4ea <memmove+0x28>
 4d0:	1602                	sll	a2,a2,0x20
 4d2:	9201                	srl	a2,a2,0x20
 4d4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4d8:	872a                	mv	a4,a0
      *dst++ = *src++;
 4da:	0585                	add	a1,a1,1
 4dc:	0705                	add	a4,a4,1
 4de:	fff5c683          	lbu	a3,-1(a1)
 4e2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4e6:	fee79ae3          	bne	a5,a4,4da <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4ea:	6422                	ld	s0,8(sp)
 4ec:	0141                	add	sp,sp,16
 4ee:	8082                	ret
    dst += n;
 4f0:	00c50733          	add	a4,a0,a2
    src += n;
 4f4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4f6:	fec05ae3          	blez	a2,4ea <memmove+0x28>
 4fa:	fff6079b          	addw	a5,a2,-1
 4fe:	1782                	sll	a5,a5,0x20
 500:	9381                	srl	a5,a5,0x20
 502:	fff7c793          	not	a5,a5
 506:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 508:	15fd                	add	a1,a1,-1
 50a:	177d                	add	a4,a4,-1
 50c:	0005c683          	lbu	a3,0(a1)
 510:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 514:	fee79ae3          	bne	a5,a4,508 <memmove+0x46>
 518:	bfc9                	j	4ea <memmove+0x28>

000000000000051a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 51a:	1141                	add	sp,sp,-16
 51c:	e422                	sd	s0,8(sp)
 51e:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 520:	ca05                	beqz	a2,550 <memcmp+0x36>
 522:	fff6069b          	addw	a3,a2,-1
 526:	1682                	sll	a3,a3,0x20
 528:	9281                	srl	a3,a3,0x20
 52a:	0685                	add	a3,a3,1
 52c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 52e:	00054783          	lbu	a5,0(a0)
 532:	0005c703          	lbu	a4,0(a1)
 536:	00e79863          	bne	a5,a4,546 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 53a:	0505                	add	a0,a0,1
    p2++;
 53c:	0585                	add	a1,a1,1
  while (n-- > 0) {
 53e:	fed518e3          	bne	a0,a3,52e <memcmp+0x14>
  }
  return 0;
 542:	4501                	li	a0,0
 544:	a019                	j	54a <memcmp+0x30>
      return *p1 - *p2;
 546:	40e7853b          	subw	a0,a5,a4
}
 54a:	6422                	ld	s0,8(sp)
 54c:	0141                	add	sp,sp,16
 54e:	8082                	ret
  return 0;
 550:	4501                	li	a0,0
 552:	bfe5                	j	54a <memcmp+0x30>

0000000000000554 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 554:	1141                	add	sp,sp,-16
 556:	e406                	sd	ra,8(sp)
 558:	e022                	sd	s0,0(sp)
 55a:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 55c:	00000097          	auipc	ra,0x0
 560:	f66080e7          	jalr	-154(ra) # 4c2 <memmove>
}
 564:	60a2                	ld	ra,8(sp)
 566:	6402                	ld	s0,0(sp)
 568:	0141                	add	sp,sp,16
 56a:	8082                	ret

000000000000056c <ugetpid>:

int
ugetpid(void)
{
 56c:	1141                	add	sp,sp,-16
 56e:	e422                	sd	s0,8(sp)
 570:	0800                	add	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 572:	040007b7          	lui	a5,0x4000
}
 576:	17f5                	add	a5,a5,-3 # 3fffffd <base+0x3ffebed>
 578:	07b2                	sll	a5,a5,0xc
 57a:	4388                	lw	a0,0(a5)
 57c:	6422                	ld	s0,8(sp)
 57e:	0141                	add	sp,sp,16
 580:	8082                	ret

0000000000000582 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 582:	4885                	li	a7,1
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <exit>:
.global exit
exit:
 li a7, SYS_exit
 58a:	4889                	li	a7,2
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <wait>:
.global wait
wait:
 li a7, SYS_wait
 592:	488d                	li	a7,3
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 59a:	4891                	li	a7,4
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <read>:
.global read
read:
 li a7, SYS_read
 5a2:	4895                	li	a7,5
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <write>:
.global write
write:
 li a7, SYS_write
 5aa:	48c1                	li	a7,16
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <close>:
.global close
close:
 li a7, SYS_close
 5b2:	48d5                	li	a7,21
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <kill>:
.global kill
kill:
 li a7, SYS_kill
 5ba:	4899                	li	a7,6
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5c2:	489d                	li	a7,7
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <open>:
.global open
open:
 li a7, SYS_open
 5ca:	48bd                	li	a7,15
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5d2:	48c5                	li	a7,17
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5da:	48c9                	li	a7,18
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5e2:	48a1                	li	a7,8
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <link>:
.global link
link:
 li a7, SYS_link
 5ea:	48cd                	li	a7,19
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5f2:	48d1                	li	a7,20
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5fa:	48a5                	li	a7,9
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <dup>:
.global dup
dup:
 li a7, SYS_dup
 602:	48a9                	li	a7,10
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 60a:	48ad                	li	a7,11
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 612:	48b1                	li	a7,12
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 61a:	48b5                	li	a7,13
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 622:	48b9                	li	a7,14
 ecall
 624:	00000073          	ecall
 ret
 628:	8082                	ret

000000000000062a <trace>:
.global trace
trace:
 li a7, SYS_trace
 62a:	48d9                	li	a7,22
 ecall
 62c:	00000073          	ecall
 ret
 630:	8082                	ret

0000000000000632 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 632:	48dd                	li	a7,23
 ecall
 634:	00000073          	ecall
 ret
 638:	8082                	ret

000000000000063a <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 63a:	48e1                	li	a7,24
 ecall
 63c:	00000073          	ecall
 ret
 640:	8082                	ret

0000000000000642 <setpriority>:
.global setpriority
setpriority:
 li a7, SYS_setpriority
 642:	48e5                	li	a7,25
 ecall
 644:	00000073          	ecall
 ret
 648:	8082                	ret

000000000000064a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 64a:	1101                	add	sp,sp,-32
 64c:	ec06                	sd	ra,24(sp)
 64e:	e822                	sd	s0,16(sp)
 650:	1000                	add	s0,sp,32
 652:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 656:	4605                	li	a2,1
 658:	fef40593          	add	a1,s0,-17
 65c:	00000097          	auipc	ra,0x0
 660:	f4e080e7          	jalr	-178(ra) # 5aa <write>
}
 664:	60e2                	ld	ra,24(sp)
 666:	6442                	ld	s0,16(sp)
 668:	6105                	add	sp,sp,32
 66a:	8082                	ret

000000000000066c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 66c:	7139                	add	sp,sp,-64
 66e:	fc06                	sd	ra,56(sp)
 670:	f822                	sd	s0,48(sp)
 672:	f426                	sd	s1,40(sp)
 674:	f04a                	sd	s2,32(sp)
 676:	ec4e                	sd	s3,24(sp)
 678:	0080                	add	s0,sp,64
 67a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 67c:	c299                	beqz	a3,682 <printint+0x16>
 67e:	0805c963          	bltz	a1,710 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 682:	2581                	sext.w	a1,a1
  neg = 0;
 684:	4881                	li	a7,0
 686:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 68a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 68c:	2601                	sext.w	a2,a2
 68e:	00000517          	auipc	a0,0x0
 692:	4ba50513          	add	a0,a0,1210 # b48 <digits>
 696:	883a                	mv	a6,a4
 698:	2705                	addw	a4,a4,1
 69a:	02c5f7bb          	remuw	a5,a1,a2
 69e:	1782                	sll	a5,a5,0x20
 6a0:	9381                	srl	a5,a5,0x20
 6a2:	97aa                	add	a5,a5,a0
 6a4:	0007c783          	lbu	a5,0(a5)
 6a8:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6ac:	0005879b          	sext.w	a5,a1
 6b0:	02c5d5bb          	divuw	a1,a1,a2
 6b4:	0685                	add	a3,a3,1
 6b6:	fec7f0e3          	bgeu	a5,a2,696 <printint+0x2a>
  if(neg)
 6ba:	00088c63          	beqz	a7,6d2 <printint+0x66>
    buf[i++] = '-';
 6be:	fd070793          	add	a5,a4,-48
 6c2:	00878733          	add	a4,a5,s0
 6c6:	02d00793          	li	a5,45
 6ca:	fef70823          	sb	a5,-16(a4)
 6ce:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 6d2:	02e05863          	blez	a4,702 <printint+0x96>
 6d6:	fc040793          	add	a5,s0,-64
 6da:	00e78933          	add	s2,a5,a4
 6de:	fff78993          	add	s3,a5,-1
 6e2:	99ba                	add	s3,s3,a4
 6e4:	377d                	addw	a4,a4,-1
 6e6:	1702                	sll	a4,a4,0x20
 6e8:	9301                	srl	a4,a4,0x20
 6ea:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6ee:	fff94583          	lbu	a1,-1(s2)
 6f2:	8526                	mv	a0,s1
 6f4:	00000097          	auipc	ra,0x0
 6f8:	f56080e7          	jalr	-170(ra) # 64a <putc>
  while(--i >= 0)
 6fc:	197d                	add	s2,s2,-1
 6fe:	ff3918e3          	bne	s2,s3,6ee <printint+0x82>
}
 702:	70e2                	ld	ra,56(sp)
 704:	7442                	ld	s0,48(sp)
 706:	74a2                	ld	s1,40(sp)
 708:	7902                	ld	s2,32(sp)
 70a:	69e2                	ld	s3,24(sp)
 70c:	6121                	add	sp,sp,64
 70e:	8082                	ret
    x = -xx;
 710:	40b005bb          	negw	a1,a1
    neg = 1;
 714:	4885                	li	a7,1
    x = -xx;
 716:	bf85                	j	686 <printint+0x1a>

0000000000000718 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 718:	715d                	add	sp,sp,-80
 71a:	e486                	sd	ra,72(sp)
 71c:	e0a2                	sd	s0,64(sp)
 71e:	fc26                	sd	s1,56(sp)
 720:	f84a                	sd	s2,48(sp)
 722:	f44e                	sd	s3,40(sp)
 724:	f052                	sd	s4,32(sp)
 726:	ec56                	sd	s5,24(sp)
 728:	e85a                	sd	s6,16(sp)
 72a:	e45e                	sd	s7,8(sp)
 72c:	e062                	sd	s8,0(sp)
 72e:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 730:	0005c903          	lbu	s2,0(a1)
 734:	18090c63          	beqz	s2,8cc <vprintf+0x1b4>
 738:	8aaa                	mv	s5,a0
 73a:	8bb2                	mv	s7,a2
 73c:	00158493          	add	s1,a1,1
  state = 0;
 740:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 742:	02500a13          	li	s4,37
 746:	4b55                	li	s6,21
 748:	a839                	j	766 <vprintf+0x4e>
        putc(fd, c);
 74a:	85ca                	mv	a1,s2
 74c:	8556                	mv	a0,s5
 74e:	00000097          	auipc	ra,0x0
 752:	efc080e7          	jalr	-260(ra) # 64a <putc>
 756:	a019                	j	75c <vprintf+0x44>
    } else if(state == '%'){
 758:	01498d63          	beq	s3,s4,772 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 75c:	0485                	add	s1,s1,1
 75e:	fff4c903          	lbu	s2,-1(s1)
 762:	16090563          	beqz	s2,8cc <vprintf+0x1b4>
    if(state == 0){
 766:	fe0999e3          	bnez	s3,758 <vprintf+0x40>
      if(c == '%'){
 76a:	ff4910e3          	bne	s2,s4,74a <vprintf+0x32>
        state = '%';
 76e:	89d2                	mv	s3,s4
 770:	b7f5                	j	75c <vprintf+0x44>
      if(c == 'd'){
 772:	13490263          	beq	s2,s4,896 <vprintf+0x17e>
 776:	f9d9079b          	addw	a5,s2,-99
 77a:	0ff7f793          	zext.b	a5,a5
 77e:	12fb6563          	bltu	s6,a5,8a8 <vprintf+0x190>
 782:	f9d9079b          	addw	a5,s2,-99
 786:	0ff7f713          	zext.b	a4,a5
 78a:	10eb6f63          	bltu	s6,a4,8a8 <vprintf+0x190>
 78e:	00271793          	sll	a5,a4,0x2
 792:	00000717          	auipc	a4,0x0
 796:	35e70713          	add	a4,a4,862 # af0 <malloc+0x126>
 79a:	97ba                	add	a5,a5,a4
 79c:	439c                	lw	a5,0(a5)
 79e:	97ba                	add	a5,a5,a4
 7a0:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 7a2:	008b8913          	add	s2,s7,8
 7a6:	4685                	li	a3,1
 7a8:	4629                	li	a2,10
 7aa:	000ba583          	lw	a1,0(s7)
 7ae:	8556                	mv	a0,s5
 7b0:	00000097          	auipc	ra,0x0
 7b4:	ebc080e7          	jalr	-324(ra) # 66c <printint>
 7b8:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7ba:	4981                	li	s3,0
 7bc:	b745                	j	75c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7be:	008b8913          	add	s2,s7,8
 7c2:	4681                	li	a3,0
 7c4:	4629                	li	a2,10
 7c6:	000ba583          	lw	a1,0(s7)
 7ca:	8556                	mv	a0,s5
 7cc:	00000097          	auipc	ra,0x0
 7d0:	ea0080e7          	jalr	-352(ra) # 66c <printint>
 7d4:	8bca                	mv	s7,s2
      state = 0;
 7d6:	4981                	li	s3,0
 7d8:	b751                	j	75c <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 7da:	008b8913          	add	s2,s7,8
 7de:	4681                	li	a3,0
 7e0:	4641                	li	a2,16
 7e2:	000ba583          	lw	a1,0(s7)
 7e6:	8556                	mv	a0,s5
 7e8:	00000097          	auipc	ra,0x0
 7ec:	e84080e7          	jalr	-380(ra) # 66c <printint>
 7f0:	8bca                	mv	s7,s2
      state = 0;
 7f2:	4981                	li	s3,0
 7f4:	b7a5                	j	75c <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 7f6:	008b8c13          	add	s8,s7,8
 7fa:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7fe:	03000593          	li	a1,48
 802:	8556                	mv	a0,s5
 804:	00000097          	auipc	ra,0x0
 808:	e46080e7          	jalr	-442(ra) # 64a <putc>
  putc(fd, 'x');
 80c:	07800593          	li	a1,120
 810:	8556                	mv	a0,s5
 812:	00000097          	auipc	ra,0x0
 816:	e38080e7          	jalr	-456(ra) # 64a <putc>
 81a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 81c:	00000b97          	auipc	s7,0x0
 820:	32cb8b93          	add	s7,s7,812 # b48 <digits>
 824:	03c9d793          	srl	a5,s3,0x3c
 828:	97de                	add	a5,a5,s7
 82a:	0007c583          	lbu	a1,0(a5)
 82e:	8556                	mv	a0,s5
 830:	00000097          	auipc	ra,0x0
 834:	e1a080e7          	jalr	-486(ra) # 64a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 838:	0992                	sll	s3,s3,0x4
 83a:	397d                	addw	s2,s2,-1
 83c:	fe0914e3          	bnez	s2,824 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 840:	8be2                	mv	s7,s8
      state = 0;
 842:	4981                	li	s3,0
 844:	bf21                	j	75c <vprintf+0x44>
        s = va_arg(ap, char*);
 846:	008b8993          	add	s3,s7,8
 84a:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 84e:	02090163          	beqz	s2,870 <vprintf+0x158>
        while(*s != 0){
 852:	00094583          	lbu	a1,0(s2)
 856:	c9a5                	beqz	a1,8c6 <vprintf+0x1ae>
          putc(fd, *s);
 858:	8556                	mv	a0,s5
 85a:	00000097          	auipc	ra,0x0
 85e:	df0080e7          	jalr	-528(ra) # 64a <putc>
          s++;
 862:	0905                	add	s2,s2,1
        while(*s != 0){
 864:	00094583          	lbu	a1,0(s2)
 868:	f9e5                	bnez	a1,858 <vprintf+0x140>
        s = va_arg(ap, char*);
 86a:	8bce                	mv	s7,s3
      state = 0;
 86c:	4981                	li	s3,0
 86e:	b5fd                	j	75c <vprintf+0x44>
          s = "(null)";
 870:	00000917          	auipc	s2,0x0
 874:	27890913          	add	s2,s2,632 # ae8 <malloc+0x11e>
        while(*s != 0){
 878:	02800593          	li	a1,40
 87c:	bff1                	j	858 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 87e:	008b8913          	add	s2,s7,8
 882:	000bc583          	lbu	a1,0(s7)
 886:	8556                	mv	a0,s5
 888:	00000097          	auipc	ra,0x0
 88c:	dc2080e7          	jalr	-574(ra) # 64a <putc>
 890:	8bca                	mv	s7,s2
      state = 0;
 892:	4981                	li	s3,0
 894:	b5e1                	j	75c <vprintf+0x44>
        putc(fd, c);
 896:	02500593          	li	a1,37
 89a:	8556                	mv	a0,s5
 89c:	00000097          	auipc	ra,0x0
 8a0:	dae080e7          	jalr	-594(ra) # 64a <putc>
      state = 0;
 8a4:	4981                	li	s3,0
 8a6:	bd5d                	j	75c <vprintf+0x44>
        putc(fd, '%');
 8a8:	02500593          	li	a1,37
 8ac:	8556                	mv	a0,s5
 8ae:	00000097          	auipc	ra,0x0
 8b2:	d9c080e7          	jalr	-612(ra) # 64a <putc>
        putc(fd, c);
 8b6:	85ca                	mv	a1,s2
 8b8:	8556                	mv	a0,s5
 8ba:	00000097          	auipc	ra,0x0
 8be:	d90080e7          	jalr	-624(ra) # 64a <putc>
      state = 0;
 8c2:	4981                	li	s3,0
 8c4:	bd61                	j	75c <vprintf+0x44>
        s = va_arg(ap, char*);
 8c6:	8bce                	mv	s7,s3
      state = 0;
 8c8:	4981                	li	s3,0
 8ca:	bd49                	j	75c <vprintf+0x44>
    }
  }
}
 8cc:	60a6                	ld	ra,72(sp)
 8ce:	6406                	ld	s0,64(sp)
 8d0:	74e2                	ld	s1,56(sp)
 8d2:	7942                	ld	s2,48(sp)
 8d4:	79a2                	ld	s3,40(sp)
 8d6:	7a02                	ld	s4,32(sp)
 8d8:	6ae2                	ld	s5,24(sp)
 8da:	6b42                	ld	s6,16(sp)
 8dc:	6ba2                	ld	s7,8(sp)
 8de:	6c02                	ld	s8,0(sp)
 8e0:	6161                	add	sp,sp,80
 8e2:	8082                	ret

00000000000008e4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8e4:	715d                	add	sp,sp,-80
 8e6:	ec06                	sd	ra,24(sp)
 8e8:	e822                	sd	s0,16(sp)
 8ea:	1000                	add	s0,sp,32
 8ec:	e010                	sd	a2,0(s0)
 8ee:	e414                	sd	a3,8(s0)
 8f0:	e818                	sd	a4,16(s0)
 8f2:	ec1c                	sd	a5,24(s0)
 8f4:	03043023          	sd	a6,32(s0)
 8f8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8fc:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 900:	8622                	mv	a2,s0
 902:	00000097          	auipc	ra,0x0
 906:	e16080e7          	jalr	-490(ra) # 718 <vprintf>
}
 90a:	60e2                	ld	ra,24(sp)
 90c:	6442                	ld	s0,16(sp)
 90e:	6161                	add	sp,sp,80
 910:	8082                	ret

0000000000000912 <printf>:

void
printf(const char *fmt, ...)
{
 912:	711d                	add	sp,sp,-96
 914:	ec06                	sd	ra,24(sp)
 916:	e822                	sd	s0,16(sp)
 918:	1000                	add	s0,sp,32
 91a:	e40c                	sd	a1,8(s0)
 91c:	e810                	sd	a2,16(s0)
 91e:	ec14                	sd	a3,24(s0)
 920:	f018                	sd	a4,32(s0)
 922:	f41c                	sd	a5,40(s0)
 924:	03043823          	sd	a6,48(s0)
 928:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 92c:	00840613          	add	a2,s0,8
 930:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 934:	85aa                	mv	a1,a0
 936:	4505                	li	a0,1
 938:	00000097          	auipc	ra,0x0
 93c:	de0080e7          	jalr	-544(ra) # 718 <vprintf>
}
 940:	60e2                	ld	ra,24(sp)
 942:	6442                	ld	s0,16(sp)
 944:	6125                	add	sp,sp,96
 946:	8082                	ret

0000000000000948 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 948:	1141                	add	sp,sp,-16
 94a:	e422                	sd	s0,8(sp)
 94c:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 94e:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 952:	00000797          	auipc	a5,0x0
 956:	6ae7b783          	ld	a5,1710(a5) # 1000 <freep>
 95a:	a02d                	j	984 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 95c:	4618                	lw	a4,8(a2)
 95e:	9f2d                	addw	a4,a4,a1
 960:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 964:	6398                	ld	a4,0(a5)
 966:	6310                	ld	a2,0(a4)
 968:	a83d                	j	9a6 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 96a:	ff852703          	lw	a4,-8(a0)
 96e:	9f31                	addw	a4,a4,a2
 970:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 972:	ff053683          	ld	a3,-16(a0)
 976:	a091                	j	9ba <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 978:	6398                	ld	a4,0(a5)
 97a:	00e7e463          	bltu	a5,a4,982 <free+0x3a>
 97e:	00e6ea63          	bltu	a3,a4,992 <free+0x4a>
{
 982:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 984:	fed7fae3          	bgeu	a5,a3,978 <free+0x30>
 988:	6398                	ld	a4,0(a5)
 98a:	00e6e463          	bltu	a3,a4,992 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 98e:	fee7eae3          	bltu	a5,a4,982 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 992:	ff852583          	lw	a1,-8(a0)
 996:	6390                	ld	a2,0(a5)
 998:	02059813          	sll	a6,a1,0x20
 99c:	01c85713          	srl	a4,a6,0x1c
 9a0:	9736                	add	a4,a4,a3
 9a2:	fae60de3          	beq	a2,a4,95c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 9a6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9aa:	4790                	lw	a2,8(a5)
 9ac:	02061593          	sll	a1,a2,0x20
 9b0:	01c5d713          	srl	a4,a1,0x1c
 9b4:	973e                	add	a4,a4,a5
 9b6:	fae68ae3          	beq	a3,a4,96a <free+0x22>
    p->s.ptr = bp->s.ptr;
 9ba:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9bc:	00000717          	auipc	a4,0x0
 9c0:	64f73223          	sd	a5,1604(a4) # 1000 <freep>
}
 9c4:	6422                	ld	s0,8(sp)
 9c6:	0141                	add	sp,sp,16
 9c8:	8082                	ret

00000000000009ca <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9ca:	7139                	add	sp,sp,-64
 9cc:	fc06                	sd	ra,56(sp)
 9ce:	f822                	sd	s0,48(sp)
 9d0:	f426                	sd	s1,40(sp)
 9d2:	f04a                	sd	s2,32(sp)
 9d4:	ec4e                	sd	s3,24(sp)
 9d6:	e852                	sd	s4,16(sp)
 9d8:	e456                	sd	s5,8(sp)
 9da:	e05a                	sd	s6,0(sp)
 9dc:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9de:	02051493          	sll	s1,a0,0x20
 9e2:	9081                	srl	s1,s1,0x20
 9e4:	04bd                	add	s1,s1,15
 9e6:	8091                	srl	s1,s1,0x4
 9e8:	0014899b          	addw	s3,s1,1
 9ec:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 9ee:	00000517          	auipc	a0,0x0
 9f2:	61253503          	ld	a0,1554(a0) # 1000 <freep>
 9f6:	c515                	beqz	a0,a22 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9f8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9fa:	4798                	lw	a4,8(a5)
 9fc:	02977f63          	bgeu	a4,s1,a3a <malloc+0x70>
  if(nu < 4096)
 a00:	8a4e                	mv	s4,s3
 a02:	0009871b          	sext.w	a4,s3
 a06:	6685                	lui	a3,0x1
 a08:	00d77363          	bgeu	a4,a3,a0e <malloc+0x44>
 a0c:	6a05                	lui	s4,0x1
 a0e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a12:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a16:	00000917          	auipc	s2,0x0
 a1a:	5ea90913          	add	s2,s2,1514 # 1000 <freep>
  if(p == (char*)-1)
 a1e:	5afd                	li	s5,-1
 a20:	a895                	j	a94 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 a22:	00001797          	auipc	a5,0x1
 a26:	9ee78793          	add	a5,a5,-1554 # 1410 <base>
 a2a:	00000717          	auipc	a4,0x0
 a2e:	5cf73b23          	sd	a5,1494(a4) # 1000 <freep>
 a32:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a34:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a38:	b7e1                	j	a00 <malloc+0x36>
      if(p->s.size == nunits)
 a3a:	02e48c63          	beq	s1,a4,a72 <malloc+0xa8>
        p->s.size -= nunits;
 a3e:	4137073b          	subw	a4,a4,s3
 a42:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a44:	02071693          	sll	a3,a4,0x20
 a48:	01c6d713          	srl	a4,a3,0x1c
 a4c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a4e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a52:	00000717          	auipc	a4,0x0
 a56:	5aa73723          	sd	a0,1454(a4) # 1000 <freep>
      return (void*)(p + 1);
 a5a:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a5e:	70e2                	ld	ra,56(sp)
 a60:	7442                	ld	s0,48(sp)
 a62:	74a2                	ld	s1,40(sp)
 a64:	7902                	ld	s2,32(sp)
 a66:	69e2                	ld	s3,24(sp)
 a68:	6a42                	ld	s4,16(sp)
 a6a:	6aa2                	ld	s5,8(sp)
 a6c:	6b02                	ld	s6,0(sp)
 a6e:	6121                	add	sp,sp,64
 a70:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a72:	6398                	ld	a4,0(a5)
 a74:	e118                	sd	a4,0(a0)
 a76:	bff1                	j	a52 <malloc+0x88>
  hp->s.size = nu;
 a78:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a7c:	0541                	add	a0,a0,16
 a7e:	00000097          	auipc	ra,0x0
 a82:	eca080e7          	jalr	-310(ra) # 948 <free>
  return freep;
 a86:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a8a:	d971                	beqz	a0,a5e <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a8c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a8e:	4798                	lw	a4,8(a5)
 a90:	fa9775e3          	bgeu	a4,s1,a3a <malloc+0x70>
    if(p == freep)
 a94:	00093703          	ld	a4,0(s2)
 a98:	853e                	mv	a0,a5
 a9a:	fef719e3          	bne	a4,a5,a8c <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 a9e:	8552                	mv	a0,s4
 aa0:	00000097          	auipc	ra,0x0
 aa4:	b72080e7          	jalr	-1166(ra) # 612 <sbrk>
  if(p == (char*)-1)
 aa8:	fd5518e3          	bne	a0,s5,a78 <malloc+0xae>
        return 0;
 aac:	4501                	li	a0,0
 aae:	bf45                	j	a5e <malloc+0x94>
