
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

char*
fmtname(char *path)
{
   0:	7179                	add	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	add	s0,sp,48
   e:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  10:	00000097          	auipc	ra,0x0
  14:	324080e7          	jalr	804(ra) # 334 <strlen>
  18:	02051793          	sll	a5,a0,0x20
  1c:	9381                	srl	a5,a5,0x20
  1e:	97a6                	add	a5,a5,s1
  20:	02f00693          	li	a3,47
  24:	0097e963          	bltu	a5,s1,36 <fmtname+0x36>
  28:	0007c703          	lbu	a4,0(a5)
  2c:	00d70563          	beq	a4,a3,36 <fmtname+0x36>
  30:	17fd                	add	a5,a5,-1
  32:	fe97fbe3          	bgeu	a5,s1,28 <fmtname+0x28>
    ;
  p++;
  36:	00178493          	add	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  3a:	8526                	mv	a0,s1
  3c:	00000097          	auipc	ra,0x0
  40:	2f8080e7          	jalr	760(ra) # 334 <strlen>
  44:	2501                	sext.w	a0,a0
  46:	47b5                	li	a5,13
  48:	00a7fa63          	bgeu	a5,a0,5c <fmtname+0x5c>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  4c:	8526                	mv	a0,s1
  4e:	70a2                	ld	ra,40(sp)
  50:	7402                	ld	s0,32(sp)
  52:	64e2                	ld	s1,24(sp)
  54:	6942                	ld	s2,16(sp)
  56:	69a2                	ld	s3,8(sp)
  58:	6145                	add	sp,sp,48
  5a:	8082                	ret
  memmove(buf, p, strlen(p));
  5c:	8526                	mv	a0,s1
  5e:	00000097          	auipc	ra,0x0
  62:	2d6080e7          	jalr	726(ra) # 334 <strlen>
  66:	00001997          	auipc	s3,0x1
  6a:	faa98993          	add	s3,s3,-86 # 1010 <buf.0>
  6e:	0005061b          	sext.w	a2,a0
  72:	85a6                	mv	a1,s1
  74:	854e                	mv	a0,s3
  76:	00000097          	auipc	ra,0x0
  7a:	474080e7          	jalr	1140(ra) # 4ea <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  7e:	8526                	mv	a0,s1
  80:	00000097          	auipc	ra,0x0
  84:	2b4080e7          	jalr	692(ra) # 334 <strlen>
  88:	0005091b          	sext.w	s2,a0
  8c:	8526                	mv	a0,s1
  8e:	00000097          	auipc	ra,0x0
  92:	2a6080e7          	jalr	678(ra) # 334 <strlen>
  96:	1902                	sll	s2,s2,0x20
  98:	02095913          	srl	s2,s2,0x20
  9c:	4639                	li	a2,14
  9e:	9e09                	subw	a2,a2,a0
  a0:	02000593          	li	a1,32
  a4:	01298533          	add	a0,s3,s2
  a8:	00000097          	auipc	ra,0x0
  ac:	2b6080e7          	jalr	694(ra) # 35e <memset>
  return buf;
  b0:	84ce                	mv	s1,s3
  b2:	bf69                	j	4c <fmtname+0x4c>

00000000000000b4 <ls>:

void
ls(char *path)
{
  b4:	d9010113          	add	sp,sp,-624
  b8:	26113423          	sd	ra,616(sp)
  bc:	26813023          	sd	s0,608(sp)
  c0:	24913c23          	sd	s1,600(sp)
  c4:	25213823          	sd	s2,592(sp)
  c8:	25313423          	sd	s3,584(sp)
  cc:	25413023          	sd	s4,576(sp)
  d0:	23513c23          	sd	s5,568(sp)
  d4:	1c80                	add	s0,sp,624
  d6:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, O_RDONLY)) < 0){
  d8:	4581                	li	a1,0
  da:	00000097          	auipc	ra,0x0
  de:	518080e7          	jalr	1304(ra) # 5f2 <open>
  e2:	06054f63          	bltz	a0,160 <ls+0xac>
  e6:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  e8:	d9840593          	add	a1,s0,-616
  ec:	00000097          	auipc	ra,0x0
  f0:	51e080e7          	jalr	1310(ra) # 60a <fstat>
  f4:	08054163          	bltz	a0,176 <ls+0xc2>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  f8:	da041783          	lh	a5,-608(s0)
  fc:	4705                	li	a4,1
  fe:	08e78c63          	beq	a5,a4,196 <ls+0xe2>
 102:	37f9                	addw	a5,a5,-2
 104:	17c2                	sll	a5,a5,0x30
 106:	93c1                	srl	a5,a5,0x30
 108:	02f76663          	bltu	a4,a5,134 <ls+0x80>
  case T_DEVICE:
  case T_FILE:
    printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
 10c:	854a                	mv	a0,s2
 10e:	00000097          	auipc	ra,0x0
 112:	ef2080e7          	jalr	-270(ra) # 0 <fmtname>
 116:	85aa                	mv	a1,a0
 118:	da843703          	ld	a4,-600(s0)
 11c:	d9c42683          	lw	a3,-612(s0)
 120:	da041603          	lh	a2,-608(s0)
 124:	00001517          	auipc	a0,0x1
 128:	9ec50513          	add	a0,a0,-1556 # b10 <malloc+0x11e>
 12c:	00001097          	auipc	ra,0x1
 130:	80e080e7          	jalr	-2034(ra) # 93a <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 134:	8526                	mv	a0,s1
 136:	00000097          	auipc	ra,0x0
 13a:	4a4080e7          	jalr	1188(ra) # 5da <close>
}
 13e:	26813083          	ld	ra,616(sp)
 142:	26013403          	ld	s0,608(sp)
 146:	25813483          	ld	s1,600(sp)
 14a:	25013903          	ld	s2,592(sp)
 14e:	24813983          	ld	s3,584(sp)
 152:	24013a03          	ld	s4,576(sp)
 156:	23813a83          	ld	s5,568(sp)
 15a:	27010113          	add	sp,sp,624
 15e:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
 160:	864a                	mv	a2,s2
 162:	00001597          	auipc	a1,0x1
 166:	97e58593          	add	a1,a1,-1666 # ae0 <malloc+0xee>
 16a:	4509                	li	a0,2
 16c:	00000097          	auipc	ra,0x0
 170:	7a0080e7          	jalr	1952(ra) # 90c <fprintf>
    return;
 174:	b7e9                	j	13e <ls+0x8a>
    fprintf(2, "ls: cannot stat %s\n", path);
 176:	864a                	mv	a2,s2
 178:	00001597          	auipc	a1,0x1
 17c:	98058593          	add	a1,a1,-1664 # af8 <malloc+0x106>
 180:	4509                	li	a0,2
 182:	00000097          	auipc	ra,0x0
 186:	78a080e7          	jalr	1930(ra) # 90c <fprintf>
    close(fd);
 18a:	8526                	mv	a0,s1
 18c:	00000097          	auipc	ra,0x0
 190:	44e080e7          	jalr	1102(ra) # 5da <close>
    return;
 194:	b76d                	j	13e <ls+0x8a>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 196:	854a                	mv	a0,s2
 198:	00000097          	auipc	ra,0x0
 19c:	19c080e7          	jalr	412(ra) # 334 <strlen>
 1a0:	2541                	addw	a0,a0,16
 1a2:	20000793          	li	a5,512
 1a6:	00a7fb63          	bgeu	a5,a0,1bc <ls+0x108>
      printf("ls: path too long\n");
 1aa:	00001517          	auipc	a0,0x1
 1ae:	97650513          	add	a0,a0,-1674 # b20 <malloc+0x12e>
 1b2:	00000097          	auipc	ra,0x0
 1b6:	788080e7          	jalr	1928(ra) # 93a <printf>
      break;
 1ba:	bfad                	j	134 <ls+0x80>
    strcpy(buf, path);
 1bc:	85ca                	mv	a1,s2
 1be:	dc040513          	add	a0,s0,-576
 1c2:	00000097          	auipc	ra,0x0
 1c6:	12a080e7          	jalr	298(ra) # 2ec <strcpy>
    p = buf+strlen(buf);
 1ca:	dc040513          	add	a0,s0,-576
 1ce:	00000097          	auipc	ra,0x0
 1d2:	166080e7          	jalr	358(ra) # 334 <strlen>
 1d6:	1502                	sll	a0,a0,0x20
 1d8:	9101                	srl	a0,a0,0x20
 1da:	dc040793          	add	a5,s0,-576
 1de:	00a78933          	add	s2,a5,a0
    *p++ = '/';
 1e2:	00190993          	add	s3,s2,1
 1e6:	02f00793          	li	a5,47
 1ea:	00f90023          	sb	a5,0(s2)
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 1ee:	00001a17          	auipc	s4,0x1
 1f2:	94aa0a13          	add	s4,s4,-1718 # b38 <malloc+0x146>
        printf("ls: cannot stat %s\n", buf);
 1f6:	00001a97          	auipc	s5,0x1
 1fa:	902a8a93          	add	s5,s5,-1790 # af8 <malloc+0x106>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1fe:	a801                	j	20e <ls+0x15a>
        printf("ls: cannot stat %s\n", buf);
 200:	dc040593          	add	a1,s0,-576
 204:	8556                	mv	a0,s5
 206:	00000097          	auipc	ra,0x0
 20a:	734080e7          	jalr	1844(ra) # 93a <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 20e:	4641                	li	a2,16
 210:	db040593          	add	a1,s0,-592
 214:	8526                	mv	a0,s1
 216:	00000097          	auipc	ra,0x0
 21a:	3b4080e7          	jalr	948(ra) # 5ca <read>
 21e:	47c1                	li	a5,16
 220:	f0f51ae3          	bne	a0,a5,134 <ls+0x80>
      if(de.inum == 0)
 224:	db045783          	lhu	a5,-592(s0)
 228:	d3fd                	beqz	a5,20e <ls+0x15a>
      memmove(p, de.name, DIRSIZ);
 22a:	4639                	li	a2,14
 22c:	db240593          	add	a1,s0,-590
 230:	854e                	mv	a0,s3
 232:	00000097          	auipc	ra,0x0
 236:	2b8080e7          	jalr	696(ra) # 4ea <memmove>
      p[DIRSIZ] = 0;
 23a:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 23e:	d9840593          	add	a1,s0,-616
 242:	dc040513          	add	a0,s0,-576
 246:	00000097          	auipc	ra,0x0
 24a:	216080e7          	jalr	534(ra) # 45c <stat>
 24e:	fa0549e3          	bltz	a0,200 <ls+0x14c>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 252:	dc040513          	add	a0,s0,-576
 256:	00000097          	auipc	ra,0x0
 25a:	daa080e7          	jalr	-598(ra) # 0 <fmtname>
 25e:	85aa                	mv	a1,a0
 260:	da843703          	ld	a4,-600(s0)
 264:	d9c42683          	lw	a3,-612(s0)
 268:	da041603          	lh	a2,-608(s0)
 26c:	8552                	mv	a0,s4
 26e:	00000097          	auipc	ra,0x0
 272:	6cc080e7          	jalr	1740(ra) # 93a <printf>
 276:	bf61                	j	20e <ls+0x15a>

0000000000000278 <main>:

int
main(int argc, char *argv[])
{
 278:	1101                	add	sp,sp,-32
 27a:	ec06                	sd	ra,24(sp)
 27c:	e822                	sd	s0,16(sp)
 27e:	e426                	sd	s1,8(sp)
 280:	e04a                	sd	s2,0(sp)
 282:	1000                	add	s0,sp,32
  int i;

  if(argc < 2){
 284:	4785                	li	a5,1
 286:	02a7d963          	bge	a5,a0,2b8 <main+0x40>
 28a:	00858493          	add	s1,a1,8
 28e:	ffe5091b          	addw	s2,a0,-2
 292:	02091793          	sll	a5,s2,0x20
 296:	01d7d913          	srl	s2,a5,0x1d
 29a:	05c1                	add	a1,a1,16
 29c:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 29e:	6088                	ld	a0,0(s1)
 2a0:	00000097          	auipc	ra,0x0
 2a4:	e14080e7          	jalr	-492(ra) # b4 <ls>
  for(i=1; i<argc; i++)
 2a8:	04a1                	add	s1,s1,8
 2aa:	ff249ae3          	bne	s1,s2,29e <main+0x26>
  exit(0);
 2ae:	4501                	li	a0,0
 2b0:	00000097          	auipc	ra,0x0
 2b4:	302080e7          	jalr	770(ra) # 5b2 <exit>
    ls(".");
 2b8:	00001517          	auipc	a0,0x1
 2bc:	89050513          	add	a0,a0,-1904 # b48 <malloc+0x156>
 2c0:	00000097          	auipc	ra,0x0
 2c4:	df4080e7          	jalr	-524(ra) # b4 <ls>
    exit(0);
 2c8:	4501                	li	a0,0
 2ca:	00000097          	auipc	ra,0x0
 2ce:	2e8080e7          	jalr	744(ra) # 5b2 <exit>

00000000000002d2 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 2d2:	1141                	add	sp,sp,-16
 2d4:	e406                	sd	ra,8(sp)
 2d6:	e022                	sd	s0,0(sp)
 2d8:	0800                	add	s0,sp,16
  extern int main();
  main();
 2da:	00000097          	auipc	ra,0x0
 2de:	f9e080e7          	jalr	-98(ra) # 278 <main>
  exit(0);
 2e2:	4501                	li	a0,0
 2e4:	00000097          	auipc	ra,0x0
 2e8:	2ce080e7          	jalr	718(ra) # 5b2 <exit>

00000000000002ec <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 2ec:	1141                	add	sp,sp,-16
 2ee:	e422                	sd	s0,8(sp)
 2f0:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2f2:	87aa                	mv	a5,a0
 2f4:	0585                	add	a1,a1,1
 2f6:	0785                	add	a5,a5,1
 2f8:	fff5c703          	lbu	a4,-1(a1)
 2fc:	fee78fa3          	sb	a4,-1(a5)
 300:	fb75                	bnez	a4,2f4 <strcpy+0x8>
    ;
  return os;
}
 302:	6422                	ld	s0,8(sp)
 304:	0141                	add	sp,sp,16
 306:	8082                	ret

0000000000000308 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 308:	1141                	add	sp,sp,-16
 30a:	e422                	sd	s0,8(sp)
 30c:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 30e:	00054783          	lbu	a5,0(a0)
 312:	cb91                	beqz	a5,326 <strcmp+0x1e>
 314:	0005c703          	lbu	a4,0(a1)
 318:	00f71763          	bne	a4,a5,326 <strcmp+0x1e>
    p++, q++;
 31c:	0505                	add	a0,a0,1
 31e:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 320:	00054783          	lbu	a5,0(a0)
 324:	fbe5                	bnez	a5,314 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 326:	0005c503          	lbu	a0,0(a1)
}
 32a:	40a7853b          	subw	a0,a5,a0
 32e:	6422                	ld	s0,8(sp)
 330:	0141                	add	sp,sp,16
 332:	8082                	ret

0000000000000334 <strlen>:

uint
strlen(const char *s)
{
 334:	1141                	add	sp,sp,-16
 336:	e422                	sd	s0,8(sp)
 338:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 33a:	00054783          	lbu	a5,0(a0)
 33e:	cf91                	beqz	a5,35a <strlen+0x26>
 340:	0505                	add	a0,a0,1
 342:	87aa                	mv	a5,a0
 344:	86be                	mv	a3,a5
 346:	0785                	add	a5,a5,1
 348:	fff7c703          	lbu	a4,-1(a5)
 34c:	ff65                	bnez	a4,344 <strlen+0x10>
 34e:	40a6853b          	subw	a0,a3,a0
 352:	2505                	addw	a0,a0,1
    ;
  return n;
}
 354:	6422                	ld	s0,8(sp)
 356:	0141                	add	sp,sp,16
 358:	8082                	ret
  for(n = 0; s[n]; n++)
 35a:	4501                	li	a0,0
 35c:	bfe5                	j	354 <strlen+0x20>

000000000000035e <memset>:

void*
memset(void *dst, int c, uint n)
{
 35e:	1141                	add	sp,sp,-16
 360:	e422                	sd	s0,8(sp)
 362:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 364:	ca19                	beqz	a2,37a <memset+0x1c>
 366:	87aa                	mv	a5,a0
 368:	1602                	sll	a2,a2,0x20
 36a:	9201                	srl	a2,a2,0x20
 36c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 370:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 374:	0785                	add	a5,a5,1
 376:	fee79de3          	bne	a5,a4,370 <memset+0x12>
  }
  return dst;
}
 37a:	6422                	ld	s0,8(sp)
 37c:	0141                	add	sp,sp,16
 37e:	8082                	ret

0000000000000380 <strchr>:

char*
strchr(const char *s, char c)
{
 380:	1141                	add	sp,sp,-16
 382:	e422                	sd	s0,8(sp)
 384:	0800                	add	s0,sp,16
  for(; *s; s++)
 386:	00054783          	lbu	a5,0(a0)
 38a:	cb99                	beqz	a5,3a0 <strchr+0x20>
    if(*s == c)
 38c:	00f58763          	beq	a1,a5,39a <strchr+0x1a>
  for(; *s; s++)
 390:	0505                	add	a0,a0,1
 392:	00054783          	lbu	a5,0(a0)
 396:	fbfd                	bnez	a5,38c <strchr+0xc>
      return (char*)s;
  return 0;
 398:	4501                	li	a0,0
}
 39a:	6422                	ld	s0,8(sp)
 39c:	0141                	add	sp,sp,16
 39e:	8082                	ret
  return 0;
 3a0:	4501                	li	a0,0
 3a2:	bfe5                	j	39a <strchr+0x1a>

00000000000003a4 <strstr>:

char*
strstr(const char *str, const char *substr)
{
 3a4:	1141                	add	sp,sp,-16
 3a6:	e422                	sd	s0,8(sp)
 3a8:	0800                	add	s0,sp,16
  const char *a, *b = substr;
  if (*b == 0)
 3aa:	0005c803          	lbu	a6,0(a1)
 3ae:	02080a63          	beqz	a6,3e2 <strstr+0x3e>
    return (char*)str;
  for( ; *str != 0; str += 1) {
 3b2:	00054783          	lbu	a5,0(a0)
 3b6:	e799                	bnez	a5,3c4 <strstr+0x20>
      if (*a++ != *b++)
        break;
    }
    b = substr;
  }
  return 0;
 3b8:	4501                	li	a0,0
 3ba:	a025                	j	3e2 <strstr+0x3e>
  for( ; *str != 0; str += 1) {
 3bc:	0505                	add	a0,a0,1
 3be:	00054783          	lbu	a5,0(a0)
 3c2:	cf99                	beqz	a5,3e0 <strstr+0x3c>
    if (*str != *b)
 3c4:	fef81ce3          	bne	a6,a5,3bc <strstr+0x18>
 3c8:	87ae                	mv	a5,a1
 3ca:	86aa                	mv	a3,a0
      if (*b == 0)
 3cc:	0007c703          	lbu	a4,0(a5)
 3d0:	cb09                	beqz	a4,3e2 <strstr+0x3e>
      if (*a++ != *b++)
 3d2:	0685                	add	a3,a3,1
 3d4:	0785                	add	a5,a5,1
 3d6:	fff6c603          	lbu	a2,-1(a3)
 3da:	fee609e3          	beq	a2,a4,3cc <strstr+0x28>
 3de:	bff9                	j	3bc <strstr+0x18>
  return 0;
 3e0:	4501                	li	a0,0
}
 3e2:	6422                	ld	s0,8(sp)
 3e4:	0141                	add	sp,sp,16
 3e6:	8082                	ret

00000000000003e8 <gets>:

char*
gets(char *buf, int max)
{
 3e8:	711d                	add	sp,sp,-96
 3ea:	ec86                	sd	ra,88(sp)
 3ec:	e8a2                	sd	s0,80(sp)
 3ee:	e4a6                	sd	s1,72(sp)
 3f0:	e0ca                	sd	s2,64(sp)
 3f2:	fc4e                	sd	s3,56(sp)
 3f4:	f852                	sd	s4,48(sp)
 3f6:	f456                	sd	s5,40(sp)
 3f8:	f05a                	sd	s6,32(sp)
 3fa:	ec5e                	sd	s7,24(sp)
 3fc:	1080                	add	s0,sp,96
 3fe:	8baa                	mv	s7,a0
 400:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 402:	892a                	mv	s2,a0
 404:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 406:	4aa9                	li	s5,10
 408:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 40a:	89a6                	mv	s3,s1
 40c:	2485                	addw	s1,s1,1
 40e:	0344d863          	bge	s1,s4,43e <gets+0x56>
    cc = read(0, &c, 1);
 412:	4605                	li	a2,1
 414:	faf40593          	add	a1,s0,-81
 418:	4501                	li	a0,0
 41a:	00000097          	auipc	ra,0x0
 41e:	1b0080e7          	jalr	432(ra) # 5ca <read>
    if(cc < 1)
 422:	00a05e63          	blez	a0,43e <gets+0x56>
    buf[i++] = c;
 426:	faf44783          	lbu	a5,-81(s0)
 42a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 42e:	01578763          	beq	a5,s5,43c <gets+0x54>
 432:	0905                	add	s2,s2,1
 434:	fd679be3          	bne	a5,s6,40a <gets+0x22>
  for(i=0; i+1 < max; ){
 438:	89a6                	mv	s3,s1
 43a:	a011                	j	43e <gets+0x56>
 43c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 43e:	99de                	add	s3,s3,s7
 440:	00098023          	sb	zero,0(s3)
  return buf;
}
 444:	855e                	mv	a0,s7
 446:	60e6                	ld	ra,88(sp)
 448:	6446                	ld	s0,80(sp)
 44a:	64a6                	ld	s1,72(sp)
 44c:	6906                	ld	s2,64(sp)
 44e:	79e2                	ld	s3,56(sp)
 450:	7a42                	ld	s4,48(sp)
 452:	7aa2                	ld	s5,40(sp)
 454:	7b02                	ld	s6,32(sp)
 456:	6be2                	ld	s7,24(sp)
 458:	6125                	add	sp,sp,96
 45a:	8082                	ret

000000000000045c <stat>:

int
stat(const char *n, struct stat *st)
{
 45c:	1101                	add	sp,sp,-32
 45e:	ec06                	sd	ra,24(sp)
 460:	e822                	sd	s0,16(sp)
 462:	e426                	sd	s1,8(sp)
 464:	e04a                	sd	s2,0(sp)
 466:	1000                	add	s0,sp,32
 468:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 46a:	4581                	li	a1,0
 46c:	00000097          	auipc	ra,0x0
 470:	186080e7          	jalr	390(ra) # 5f2 <open>
  if(fd < 0)
 474:	02054563          	bltz	a0,49e <stat+0x42>
 478:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 47a:	85ca                	mv	a1,s2
 47c:	00000097          	auipc	ra,0x0
 480:	18e080e7          	jalr	398(ra) # 60a <fstat>
 484:	892a                	mv	s2,a0
  close(fd);
 486:	8526                	mv	a0,s1
 488:	00000097          	auipc	ra,0x0
 48c:	152080e7          	jalr	338(ra) # 5da <close>
  return r;
}
 490:	854a                	mv	a0,s2
 492:	60e2                	ld	ra,24(sp)
 494:	6442                	ld	s0,16(sp)
 496:	64a2                	ld	s1,8(sp)
 498:	6902                	ld	s2,0(sp)
 49a:	6105                	add	sp,sp,32
 49c:	8082                	ret
    return -1;
 49e:	597d                	li	s2,-1
 4a0:	bfc5                	j	490 <stat+0x34>

00000000000004a2 <atoi>:

int
atoi(const char *s)
{
 4a2:	1141                	add	sp,sp,-16
 4a4:	e422                	sd	s0,8(sp)
 4a6:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4a8:	00054683          	lbu	a3,0(a0)
 4ac:	fd06879b          	addw	a5,a3,-48
 4b0:	0ff7f793          	zext.b	a5,a5
 4b4:	4625                	li	a2,9
 4b6:	02f66863          	bltu	a2,a5,4e6 <atoi+0x44>
 4ba:	872a                	mv	a4,a0
  n = 0;
 4bc:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 4be:	0705                	add	a4,a4,1
 4c0:	0025179b          	sllw	a5,a0,0x2
 4c4:	9fa9                	addw	a5,a5,a0
 4c6:	0017979b          	sllw	a5,a5,0x1
 4ca:	9fb5                	addw	a5,a5,a3
 4cc:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4d0:	00074683          	lbu	a3,0(a4)
 4d4:	fd06879b          	addw	a5,a3,-48
 4d8:	0ff7f793          	zext.b	a5,a5
 4dc:	fef671e3          	bgeu	a2,a5,4be <atoi+0x1c>
  return n;
}
 4e0:	6422                	ld	s0,8(sp)
 4e2:	0141                	add	sp,sp,16
 4e4:	8082                	ret
  n = 0;
 4e6:	4501                	li	a0,0
 4e8:	bfe5                	j	4e0 <atoi+0x3e>

00000000000004ea <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4ea:	1141                	add	sp,sp,-16
 4ec:	e422                	sd	s0,8(sp)
 4ee:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4f0:	02b57463          	bgeu	a0,a1,518 <memmove+0x2e>
    while(n-- > 0)
 4f4:	00c05f63          	blez	a2,512 <memmove+0x28>
 4f8:	1602                	sll	a2,a2,0x20
 4fa:	9201                	srl	a2,a2,0x20
 4fc:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 500:	872a                	mv	a4,a0
      *dst++ = *src++;
 502:	0585                	add	a1,a1,1
 504:	0705                	add	a4,a4,1
 506:	fff5c683          	lbu	a3,-1(a1)
 50a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 50e:	fee79ae3          	bne	a5,a4,502 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 512:	6422                	ld	s0,8(sp)
 514:	0141                	add	sp,sp,16
 516:	8082                	ret
    dst += n;
 518:	00c50733          	add	a4,a0,a2
    src += n;
 51c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 51e:	fec05ae3          	blez	a2,512 <memmove+0x28>
 522:	fff6079b          	addw	a5,a2,-1
 526:	1782                	sll	a5,a5,0x20
 528:	9381                	srl	a5,a5,0x20
 52a:	fff7c793          	not	a5,a5
 52e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 530:	15fd                	add	a1,a1,-1
 532:	177d                	add	a4,a4,-1
 534:	0005c683          	lbu	a3,0(a1)
 538:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 53c:	fee79ae3          	bne	a5,a4,530 <memmove+0x46>
 540:	bfc9                	j	512 <memmove+0x28>

0000000000000542 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 542:	1141                	add	sp,sp,-16
 544:	e422                	sd	s0,8(sp)
 546:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 548:	ca05                	beqz	a2,578 <memcmp+0x36>
 54a:	fff6069b          	addw	a3,a2,-1
 54e:	1682                	sll	a3,a3,0x20
 550:	9281                	srl	a3,a3,0x20
 552:	0685                	add	a3,a3,1
 554:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 556:	00054783          	lbu	a5,0(a0)
 55a:	0005c703          	lbu	a4,0(a1)
 55e:	00e79863          	bne	a5,a4,56e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 562:	0505                	add	a0,a0,1
    p2++;
 564:	0585                	add	a1,a1,1
  while (n-- > 0) {
 566:	fed518e3          	bne	a0,a3,556 <memcmp+0x14>
  }
  return 0;
 56a:	4501                	li	a0,0
 56c:	a019                	j	572 <memcmp+0x30>
      return *p1 - *p2;
 56e:	40e7853b          	subw	a0,a5,a4
}
 572:	6422                	ld	s0,8(sp)
 574:	0141                	add	sp,sp,16
 576:	8082                	ret
  return 0;
 578:	4501                	li	a0,0
 57a:	bfe5                	j	572 <memcmp+0x30>

000000000000057c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 57c:	1141                	add	sp,sp,-16
 57e:	e406                	sd	ra,8(sp)
 580:	e022                	sd	s0,0(sp)
 582:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 584:	00000097          	auipc	ra,0x0
 588:	f66080e7          	jalr	-154(ra) # 4ea <memmove>
}
 58c:	60a2                	ld	ra,8(sp)
 58e:	6402                	ld	s0,0(sp)
 590:	0141                	add	sp,sp,16
 592:	8082                	ret

0000000000000594 <ugetpid>:

int
ugetpid(void)
{
 594:	1141                	add	sp,sp,-16
 596:	e422                	sd	s0,8(sp)
 598:	0800                	add	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 59a:	040007b7          	lui	a5,0x4000
}
 59e:	17f5                	add	a5,a5,-3 # 3fffffd <base+0x3ffefdd>
 5a0:	07b2                	sll	a5,a5,0xc
 5a2:	4388                	lw	a0,0(a5)
 5a4:	6422                	ld	s0,8(sp)
 5a6:	0141                	add	sp,sp,16
 5a8:	8082                	ret

00000000000005aa <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5aa:	4885                	li	a7,1
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5b2:	4889                	li	a7,2
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <wait>:
.global wait
wait:
 li a7, SYS_wait
 5ba:	488d                	li	a7,3
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5c2:	4891                	li	a7,4
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <read>:
.global read
read:
 li a7, SYS_read
 5ca:	4895                	li	a7,5
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <write>:
.global write
write:
 li a7, SYS_write
 5d2:	48c1                	li	a7,16
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <close>:
.global close
close:
 li a7, SYS_close
 5da:	48d5                	li	a7,21
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5e2:	4899                	li	a7,6
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <exec>:
.global exec
exec:
 li a7, SYS_exec
 5ea:	489d                	li	a7,7
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <open>:
.global open
open:
 li a7, SYS_open
 5f2:	48bd                	li	a7,15
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5fa:	48c5                	li	a7,17
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 602:	48c9                	li	a7,18
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 60a:	48a1                	li	a7,8
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <link>:
.global link
link:
 li a7, SYS_link
 612:	48cd                	li	a7,19
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 61a:	48d1                	li	a7,20
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 622:	48a5                	li	a7,9
 ecall
 624:	00000073          	ecall
 ret
 628:	8082                	ret

000000000000062a <dup>:
.global dup
dup:
 li a7, SYS_dup
 62a:	48a9                	li	a7,10
 ecall
 62c:	00000073          	ecall
 ret
 630:	8082                	ret

0000000000000632 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 632:	48ad                	li	a7,11
 ecall
 634:	00000073          	ecall
 ret
 638:	8082                	ret

000000000000063a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 63a:	48b1                	li	a7,12
 ecall
 63c:	00000073          	ecall
 ret
 640:	8082                	ret

0000000000000642 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 642:	48b5                	li	a7,13
 ecall
 644:	00000073          	ecall
 ret
 648:	8082                	ret

000000000000064a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 64a:	48b9                	li	a7,14
 ecall
 64c:	00000073          	ecall
 ret
 650:	8082                	ret

0000000000000652 <trace>:
.global trace
trace:
 li a7, SYS_trace
 652:	48d9                	li	a7,22
 ecall
 654:	00000073          	ecall
 ret
 658:	8082                	ret

000000000000065a <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 65a:	48dd                	li	a7,23
 ecall
 65c:	00000073          	ecall
 ret
 660:	8082                	ret

0000000000000662 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 662:	48e1                	li	a7,24
 ecall
 664:	00000073          	ecall
 ret
 668:	8082                	ret

000000000000066a <setpriority>:
.global setpriority
setpriority:
 li a7, SYS_setpriority
 66a:	48e5                	li	a7,25
 ecall
 66c:	00000073          	ecall
 ret
 670:	8082                	ret

0000000000000672 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 672:	1101                	add	sp,sp,-32
 674:	ec06                	sd	ra,24(sp)
 676:	e822                	sd	s0,16(sp)
 678:	1000                	add	s0,sp,32
 67a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 67e:	4605                	li	a2,1
 680:	fef40593          	add	a1,s0,-17
 684:	00000097          	auipc	ra,0x0
 688:	f4e080e7          	jalr	-178(ra) # 5d2 <write>
}
 68c:	60e2                	ld	ra,24(sp)
 68e:	6442                	ld	s0,16(sp)
 690:	6105                	add	sp,sp,32
 692:	8082                	ret

0000000000000694 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 694:	7139                	add	sp,sp,-64
 696:	fc06                	sd	ra,56(sp)
 698:	f822                	sd	s0,48(sp)
 69a:	f426                	sd	s1,40(sp)
 69c:	f04a                	sd	s2,32(sp)
 69e:	ec4e                	sd	s3,24(sp)
 6a0:	0080                	add	s0,sp,64
 6a2:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6a4:	c299                	beqz	a3,6aa <printint+0x16>
 6a6:	0805c963          	bltz	a1,738 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6aa:	2581                	sext.w	a1,a1
  neg = 0;
 6ac:	4881                	li	a7,0
 6ae:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 6b2:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6b4:	2601                	sext.w	a2,a2
 6b6:	00000517          	auipc	a0,0x0
 6ba:	4fa50513          	add	a0,a0,1274 # bb0 <digits>
 6be:	883a                	mv	a6,a4
 6c0:	2705                	addw	a4,a4,1
 6c2:	02c5f7bb          	remuw	a5,a1,a2
 6c6:	1782                	sll	a5,a5,0x20
 6c8:	9381                	srl	a5,a5,0x20
 6ca:	97aa                	add	a5,a5,a0
 6cc:	0007c783          	lbu	a5,0(a5)
 6d0:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6d4:	0005879b          	sext.w	a5,a1
 6d8:	02c5d5bb          	divuw	a1,a1,a2
 6dc:	0685                	add	a3,a3,1
 6de:	fec7f0e3          	bgeu	a5,a2,6be <printint+0x2a>
  if(neg)
 6e2:	00088c63          	beqz	a7,6fa <printint+0x66>
    buf[i++] = '-';
 6e6:	fd070793          	add	a5,a4,-48
 6ea:	00878733          	add	a4,a5,s0
 6ee:	02d00793          	li	a5,45
 6f2:	fef70823          	sb	a5,-16(a4)
 6f6:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 6fa:	02e05863          	blez	a4,72a <printint+0x96>
 6fe:	fc040793          	add	a5,s0,-64
 702:	00e78933          	add	s2,a5,a4
 706:	fff78993          	add	s3,a5,-1
 70a:	99ba                	add	s3,s3,a4
 70c:	377d                	addw	a4,a4,-1
 70e:	1702                	sll	a4,a4,0x20
 710:	9301                	srl	a4,a4,0x20
 712:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 716:	fff94583          	lbu	a1,-1(s2)
 71a:	8526                	mv	a0,s1
 71c:	00000097          	auipc	ra,0x0
 720:	f56080e7          	jalr	-170(ra) # 672 <putc>
  while(--i >= 0)
 724:	197d                	add	s2,s2,-1
 726:	ff3918e3          	bne	s2,s3,716 <printint+0x82>
}
 72a:	70e2                	ld	ra,56(sp)
 72c:	7442                	ld	s0,48(sp)
 72e:	74a2                	ld	s1,40(sp)
 730:	7902                	ld	s2,32(sp)
 732:	69e2                	ld	s3,24(sp)
 734:	6121                	add	sp,sp,64
 736:	8082                	ret
    x = -xx;
 738:	40b005bb          	negw	a1,a1
    neg = 1;
 73c:	4885                	li	a7,1
    x = -xx;
 73e:	bf85                	j	6ae <printint+0x1a>

0000000000000740 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 740:	715d                	add	sp,sp,-80
 742:	e486                	sd	ra,72(sp)
 744:	e0a2                	sd	s0,64(sp)
 746:	fc26                	sd	s1,56(sp)
 748:	f84a                	sd	s2,48(sp)
 74a:	f44e                	sd	s3,40(sp)
 74c:	f052                	sd	s4,32(sp)
 74e:	ec56                	sd	s5,24(sp)
 750:	e85a                	sd	s6,16(sp)
 752:	e45e                	sd	s7,8(sp)
 754:	e062                	sd	s8,0(sp)
 756:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 758:	0005c903          	lbu	s2,0(a1)
 75c:	18090c63          	beqz	s2,8f4 <vprintf+0x1b4>
 760:	8aaa                	mv	s5,a0
 762:	8bb2                	mv	s7,a2
 764:	00158493          	add	s1,a1,1
  state = 0;
 768:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 76a:	02500a13          	li	s4,37
 76e:	4b55                	li	s6,21
 770:	a839                	j	78e <vprintf+0x4e>
        putc(fd, c);
 772:	85ca                	mv	a1,s2
 774:	8556                	mv	a0,s5
 776:	00000097          	auipc	ra,0x0
 77a:	efc080e7          	jalr	-260(ra) # 672 <putc>
 77e:	a019                	j	784 <vprintf+0x44>
    } else if(state == '%'){
 780:	01498d63          	beq	s3,s4,79a <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 784:	0485                	add	s1,s1,1
 786:	fff4c903          	lbu	s2,-1(s1)
 78a:	16090563          	beqz	s2,8f4 <vprintf+0x1b4>
    if(state == 0){
 78e:	fe0999e3          	bnez	s3,780 <vprintf+0x40>
      if(c == '%'){
 792:	ff4910e3          	bne	s2,s4,772 <vprintf+0x32>
        state = '%';
 796:	89d2                	mv	s3,s4
 798:	b7f5                	j	784 <vprintf+0x44>
      if(c == 'd'){
 79a:	13490263          	beq	s2,s4,8be <vprintf+0x17e>
 79e:	f9d9079b          	addw	a5,s2,-99
 7a2:	0ff7f793          	zext.b	a5,a5
 7a6:	12fb6563          	bltu	s6,a5,8d0 <vprintf+0x190>
 7aa:	f9d9079b          	addw	a5,s2,-99
 7ae:	0ff7f713          	zext.b	a4,a5
 7b2:	10eb6f63          	bltu	s6,a4,8d0 <vprintf+0x190>
 7b6:	00271793          	sll	a5,a4,0x2
 7ba:	00000717          	auipc	a4,0x0
 7be:	39e70713          	add	a4,a4,926 # b58 <malloc+0x166>
 7c2:	97ba                	add	a5,a5,a4
 7c4:	439c                	lw	a5,0(a5)
 7c6:	97ba                	add	a5,a5,a4
 7c8:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 7ca:	008b8913          	add	s2,s7,8
 7ce:	4685                	li	a3,1
 7d0:	4629                	li	a2,10
 7d2:	000ba583          	lw	a1,0(s7)
 7d6:	8556                	mv	a0,s5
 7d8:	00000097          	auipc	ra,0x0
 7dc:	ebc080e7          	jalr	-324(ra) # 694 <printint>
 7e0:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7e2:	4981                	li	s3,0
 7e4:	b745                	j	784 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7e6:	008b8913          	add	s2,s7,8
 7ea:	4681                	li	a3,0
 7ec:	4629                	li	a2,10
 7ee:	000ba583          	lw	a1,0(s7)
 7f2:	8556                	mv	a0,s5
 7f4:	00000097          	auipc	ra,0x0
 7f8:	ea0080e7          	jalr	-352(ra) # 694 <printint>
 7fc:	8bca                	mv	s7,s2
      state = 0;
 7fe:	4981                	li	s3,0
 800:	b751                	j	784 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 802:	008b8913          	add	s2,s7,8
 806:	4681                	li	a3,0
 808:	4641                	li	a2,16
 80a:	000ba583          	lw	a1,0(s7)
 80e:	8556                	mv	a0,s5
 810:	00000097          	auipc	ra,0x0
 814:	e84080e7          	jalr	-380(ra) # 694 <printint>
 818:	8bca                	mv	s7,s2
      state = 0;
 81a:	4981                	li	s3,0
 81c:	b7a5                	j	784 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 81e:	008b8c13          	add	s8,s7,8
 822:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 826:	03000593          	li	a1,48
 82a:	8556                	mv	a0,s5
 82c:	00000097          	auipc	ra,0x0
 830:	e46080e7          	jalr	-442(ra) # 672 <putc>
  putc(fd, 'x');
 834:	07800593          	li	a1,120
 838:	8556                	mv	a0,s5
 83a:	00000097          	auipc	ra,0x0
 83e:	e38080e7          	jalr	-456(ra) # 672 <putc>
 842:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 844:	00000b97          	auipc	s7,0x0
 848:	36cb8b93          	add	s7,s7,876 # bb0 <digits>
 84c:	03c9d793          	srl	a5,s3,0x3c
 850:	97de                	add	a5,a5,s7
 852:	0007c583          	lbu	a1,0(a5)
 856:	8556                	mv	a0,s5
 858:	00000097          	auipc	ra,0x0
 85c:	e1a080e7          	jalr	-486(ra) # 672 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 860:	0992                	sll	s3,s3,0x4
 862:	397d                	addw	s2,s2,-1
 864:	fe0914e3          	bnez	s2,84c <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 868:	8be2                	mv	s7,s8
      state = 0;
 86a:	4981                	li	s3,0
 86c:	bf21                	j	784 <vprintf+0x44>
        s = va_arg(ap, char*);
 86e:	008b8993          	add	s3,s7,8
 872:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 876:	02090163          	beqz	s2,898 <vprintf+0x158>
        while(*s != 0){
 87a:	00094583          	lbu	a1,0(s2)
 87e:	c9a5                	beqz	a1,8ee <vprintf+0x1ae>
          putc(fd, *s);
 880:	8556                	mv	a0,s5
 882:	00000097          	auipc	ra,0x0
 886:	df0080e7          	jalr	-528(ra) # 672 <putc>
          s++;
 88a:	0905                	add	s2,s2,1
        while(*s != 0){
 88c:	00094583          	lbu	a1,0(s2)
 890:	f9e5                	bnez	a1,880 <vprintf+0x140>
        s = va_arg(ap, char*);
 892:	8bce                	mv	s7,s3
      state = 0;
 894:	4981                	li	s3,0
 896:	b5fd                	j	784 <vprintf+0x44>
          s = "(null)";
 898:	00000917          	auipc	s2,0x0
 89c:	2b890913          	add	s2,s2,696 # b50 <malloc+0x15e>
        while(*s != 0){
 8a0:	02800593          	li	a1,40
 8a4:	bff1                	j	880 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 8a6:	008b8913          	add	s2,s7,8
 8aa:	000bc583          	lbu	a1,0(s7)
 8ae:	8556                	mv	a0,s5
 8b0:	00000097          	auipc	ra,0x0
 8b4:	dc2080e7          	jalr	-574(ra) # 672 <putc>
 8b8:	8bca                	mv	s7,s2
      state = 0;
 8ba:	4981                	li	s3,0
 8bc:	b5e1                	j	784 <vprintf+0x44>
        putc(fd, c);
 8be:	02500593          	li	a1,37
 8c2:	8556                	mv	a0,s5
 8c4:	00000097          	auipc	ra,0x0
 8c8:	dae080e7          	jalr	-594(ra) # 672 <putc>
      state = 0;
 8cc:	4981                	li	s3,0
 8ce:	bd5d                	j	784 <vprintf+0x44>
        putc(fd, '%');
 8d0:	02500593          	li	a1,37
 8d4:	8556                	mv	a0,s5
 8d6:	00000097          	auipc	ra,0x0
 8da:	d9c080e7          	jalr	-612(ra) # 672 <putc>
        putc(fd, c);
 8de:	85ca                	mv	a1,s2
 8e0:	8556                	mv	a0,s5
 8e2:	00000097          	auipc	ra,0x0
 8e6:	d90080e7          	jalr	-624(ra) # 672 <putc>
      state = 0;
 8ea:	4981                	li	s3,0
 8ec:	bd61                	j	784 <vprintf+0x44>
        s = va_arg(ap, char*);
 8ee:	8bce                	mv	s7,s3
      state = 0;
 8f0:	4981                	li	s3,0
 8f2:	bd49                	j	784 <vprintf+0x44>
    }
  }
}
 8f4:	60a6                	ld	ra,72(sp)
 8f6:	6406                	ld	s0,64(sp)
 8f8:	74e2                	ld	s1,56(sp)
 8fa:	7942                	ld	s2,48(sp)
 8fc:	79a2                	ld	s3,40(sp)
 8fe:	7a02                	ld	s4,32(sp)
 900:	6ae2                	ld	s5,24(sp)
 902:	6b42                	ld	s6,16(sp)
 904:	6ba2                	ld	s7,8(sp)
 906:	6c02                	ld	s8,0(sp)
 908:	6161                	add	sp,sp,80
 90a:	8082                	ret

000000000000090c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 90c:	715d                	add	sp,sp,-80
 90e:	ec06                	sd	ra,24(sp)
 910:	e822                	sd	s0,16(sp)
 912:	1000                	add	s0,sp,32
 914:	e010                	sd	a2,0(s0)
 916:	e414                	sd	a3,8(s0)
 918:	e818                	sd	a4,16(s0)
 91a:	ec1c                	sd	a5,24(s0)
 91c:	03043023          	sd	a6,32(s0)
 920:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 924:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 928:	8622                	mv	a2,s0
 92a:	00000097          	auipc	ra,0x0
 92e:	e16080e7          	jalr	-490(ra) # 740 <vprintf>
}
 932:	60e2                	ld	ra,24(sp)
 934:	6442                	ld	s0,16(sp)
 936:	6161                	add	sp,sp,80
 938:	8082                	ret

000000000000093a <printf>:

void
printf(const char *fmt, ...)
{
 93a:	711d                	add	sp,sp,-96
 93c:	ec06                	sd	ra,24(sp)
 93e:	e822                	sd	s0,16(sp)
 940:	1000                	add	s0,sp,32
 942:	e40c                	sd	a1,8(s0)
 944:	e810                	sd	a2,16(s0)
 946:	ec14                	sd	a3,24(s0)
 948:	f018                	sd	a4,32(s0)
 94a:	f41c                	sd	a5,40(s0)
 94c:	03043823          	sd	a6,48(s0)
 950:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 954:	00840613          	add	a2,s0,8
 958:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 95c:	85aa                	mv	a1,a0
 95e:	4505                	li	a0,1
 960:	00000097          	auipc	ra,0x0
 964:	de0080e7          	jalr	-544(ra) # 740 <vprintf>
}
 968:	60e2                	ld	ra,24(sp)
 96a:	6442                	ld	s0,16(sp)
 96c:	6125                	add	sp,sp,96
 96e:	8082                	ret

0000000000000970 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 970:	1141                	add	sp,sp,-16
 972:	e422                	sd	s0,8(sp)
 974:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 976:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 97a:	00000797          	auipc	a5,0x0
 97e:	6867b783          	ld	a5,1670(a5) # 1000 <freep>
 982:	a02d                	j	9ac <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 984:	4618                	lw	a4,8(a2)
 986:	9f2d                	addw	a4,a4,a1
 988:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 98c:	6398                	ld	a4,0(a5)
 98e:	6310                	ld	a2,0(a4)
 990:	a83d                	j	9ce <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 992:	ff852703          	lw	a4,-8(a0)
 996:	9f31                	addw	a4,a4,a2
 998:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 99a:	ff053683          	ld	a3,-16(a0)
 99e:	a091                	j	9e2 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9a0:	6398                	ld	a4,0(a5)
 9a2:	00e7e463          	bltu	a5,a4,9aa <free+0x3a>
 9a6:	00e6ea63          	bltu	a3,a4,9ba <free+0x4a>
{
 9aa:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9ac:	fed7fae3          	bgeu	a5,a3,9a0 <free+0x30>
 9b0:	6398                	ld	a4,0(a5)
 9b2:	00e6e463          	bltu	a3,a4,9ba <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9b6:	fee7eae3          	bltu	a5,a4,9aa <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 9ba:	ff852583          	lw	a1,-8(a0)
 9be:	6390                	ld	a2,0(a5)
 9c0:	02059813          	sll	a6,a1,0x20
 9c4:	01c85713          	srl	a4,a6,0x1c
 9c8:	9736                	add	a4,a4,a3
 9ca:	fae60de3          	beq	a2,a4,984 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 9ce:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9d2:	4790                	lw	a2,8(a5)
 9d4:	02061593          	sll	a1,a2,0x20
 9d8:	01c5d713          	srl	a4,a1,0x1c
 9dc:	973e                	add	a4,a4,a5
 9de:	fae68ae3          	beq	a3,a4,992 <free+0x22>
    p->s.ptr = bp->s.ptr;
 9e2:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9e4:	00000717          	auipc	a4,0x0
 9e8:	60f73e23          	sd	a5,1564(a4) # 1000 <freep>
}
 9ec:	6422                	ld	s0,8(sp)
 9ee:	0141                	add	sp,sp,16
 9f0:	8082                	ret

00000000000009f2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9f2:	7139                	add	sp,sp,-64
 9f4:	fc06                	sd	ra,56(sp)
 9f6:	f822                	sd	s0,48(sp)
 9f8:	f426                	sd	s1,40(sp)
 9fa:	f04a                	sd	s2,32(sp)
 9fc:	ec4e                	sd	s3,24(sp)
 9fe:	e852                	sd	s4,16(sp)
 a00:	e456                	sd	s5,8(sp)
 a02:	e05a                	sd	s6,0(sp)
 a04:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a06:	02051493          	sll	s1,a0,0x20
 a0a:	9081                	srl	s1,s1,0x20
 a0c:	04bd                	add	s1,s1,15
 a0e:	8091                	srl	s1,s1,0x4
 a10:	0014899b          	addw	s3,s1,1
 a14:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 a16:	00000517          	auipc	a0,0x0
 a1a:	5ea53503          	ld	a0,1514(a0) # 1000 <freep>
 a1e:	c515                	beqz	a0,a4a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a20:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a22:	4798                	lw	a4,8(a5)
 a24:	02977f63          	bgeu	a4,s1,a62 <malloc+0x70>
  if(nu < 4096)
 a28:	8a4e                	mv	s4,s3
 a2a:	0009871b          	sext.w	a4,s3
 a2e:	6685                	lui	a3,0x1
 a30:	00d77363          	bgeu	a4,a3,a36 <malloc+0x44>
 a34:	6a05                	lui	s4,0x1
 a36:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a3a:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a3e:	00000917          	auipc	s2,0x0
 a42:	5c290913          	add	s2,s2,1474 # 1000 <freep>
  if(p == (char*)-1)
 a46:	5afd                	li	s5,-1
 a48:	a895                	j	abc <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 a4a:	00000797          	auipc	a5,0x0
 a4e:	5d678793          	add	a5,a5,1494 # 1020 <base>
 a52:	00000717          	auipc	a4,0x0
 a56:	5af73723          	sd	a5,1454(a4) # 1000 <freep>
 a5a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a5c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a60:	b7e1                	j	a28 <malloc+0x36>
      if(p->s.size == nunits)
 a62:	02e48c63          	beq	s1,a4,a9a <malloc+0xa8>
        p->s.size -= nunits;
 a66:	4137073b          	subw	a4,a4,s3
 a6a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a6c:	02071693          	sll	a3,a4,0x20
 a70:	01c6d713          	srl	a4,a3,0x1c
 a74:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a76:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a7a:	00000717          	auipc	a4,0x0
 a7e:	58a73323          	sd	a0,1414(a4) # 1000 <freep>
      return (void*)(p + 1);
 a82:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a86:	70e2                	ld	ra,56(sp)
 a88:	7442                	ld	s0,48(sp)
 a8a:	74a2                	ld	s1,40(sp)
 a8c:	7902                	ld	s2,32(sp)
 a8e:	69e2                	ld	s3,24(sp)
 a90:	6a42                	ld	s4,16(sp)
 a92:	6aa2                	ld	s5,8(sp)
 a94:	6b02                	ld	s6,0(sp)
 a96:	6121                	add	sp,sp,64
 a98:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a9a:	6398                	ld	a4,0(a5)
 a9c:	e118                	sd	a4,0(a0)
 a9e:	bff1                	j	a7a <malloc+0x88>
  hp->s.size = nu;
 aa0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 aa4:	0541                	add	a0,a0,16
 aa6:	00000097          	auipc	ra,0x0
 aaa:	eca080e7          	jalr	-310(ra) # 970 <free>
  return freep;
 aae:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 ab2:	d971                	beqz	a0,a86 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ab4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ab6:	4798                	lw	a4,8(a5)
 ab8:	fa9775e3          	bgeu	a4,s1,a62 <malloc+0x70>
    if(p == freep)
 abc:	00093703          	ld	a4,0(s2)
 ac0:	853e                	mv	a0,a5
 ac2:	fef719e3          	bne	a4,a5,ab4 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 ac6:	8552                	mv	a0,s4
 ac8:	00000097          	auipc	ra,0x0
 acc:	b72080e7          	jalr	-1166(ra) # 63a <sbrk>
  if(p == (char*)-1)
 ad0:	fd5518e3          	bne	a0,s5,aa0 <malloc+0xae>
        return 0;
 ad4:	4501                	li	a0,0
 ad6:	bf45                	j	a86 <malloc+0x94>
