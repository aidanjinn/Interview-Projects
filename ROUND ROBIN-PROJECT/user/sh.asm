
user/_sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <pushback>:
struct cmd *parsecmd(char*);
void runcmd(struct cmd*) __attribute__((noreturn));

void
pushback(struct strlist *list, const char *string)
{
       0:	7179                	add	sp,sp,-48
       2:	f406                	sd	ra,40(sp)
       4:	f022                	sd	s0,32(sp)
       6:	ec26                	sd	s1,24(sp)
       8:	e84a                	sd	s2,16(sp)
       a:	e44e                	sd	s3,8(sp)
       c:	e052                	sd	s4,0(sp)
       e:	1800                	add	s0,sp,48
      10:	84aa                	mv	s1,a0
      12:	89ae                	mv	s3,a1
  char **newMemory = (char**)malloc((1 + list->length) * sizeof(char*));
      14:	4108                	lw	a0,0(a0)
      16:	2505                	addw	a0,a0,1
      18:	0035151b          	sllw	a0,a0,0x3
      1c:	00002097          	auipc	ra,0x2
      20:	822080e7          	jalr	-2014(ra) # 183e <malloc>
      24:	892a                	mv	s2,a0
  for (int i = 0; i < list->length; ++i)
      26:	409c                	lw	a5,0(s1)
      28:	02f05163          	blez	a5,4a <pushback+0x4a>
      2c:	86aa                	mv	a3,a0
      2e:	4781                	li	a5,0
    newMemory[i] = list->strings[i];
      30:	6498                	ld	a4,8(s1)
      32:	00379613          	sll	a2,a5,0x3
      36:	9732                	add	a4,a4,a2
      38:	6318                	ld	a4,0(a4)
      3a:	e298                	sd	a4,0(a3)
  for (int i = 0; i < list->length; ++i)
      3c:	0785                	add	a5,a5,1
      3e:	06a1                	add	a3,a3,8
      40:	4090                	lw	a2,0(s1)
      42:	0007871b          	sext.w	a4,a5
      46:	fec745e3          	blt	a4,a2,30 <pushback+0x30>
  newMemory[list->length] = (char*)malloc(1 + strlen(string));
      4a:	854e                	mv	a0,s3
      4c:	00001097          	auipc	ra,0x1
      50:	134080e7          	jalr	308(ra) # 1180 <strlen>
      54:	0004aa03          	lw	s4,0(s1)
      58:	0a0e                	sll	s4,s4,0x3
      5a:	9a4a                	add	s4,s4,s2
      5c:	2505                	addw	a0,a0,1
      5e:	00001097          	auipc	ra,0x1
      62:	7e0080e7          	jalr	2016(ra) # 183e <malloc>
      66:	00aa3023          	sd	a0,0(s4)
  memcpy(newMemory[list->length], string, 1 + strlen(string));
      6a:	409c                	lw	a5,0(s1)
      6c:	078e                	sll	a5,a5,0x3
      6e:	97ca                	add	a5,a5,s2
      70:	0007ba03          	ld	s4,0(a5)
      74:	854e                	mv	a0,s3
      76:	00001097          	auipc	ra,0x1
      7a:	10a080e7          	jalr	266(ra) # 1180 <strlen>
      7e:	0015061b          	addw	a2,a0,1
      82:	85ce                	mv	a1,s3
      84:	8552                	mv	a0,s4
      86:	00001097          	auipc	ra,0x1
      8a:	342080e7          	jalr	834(ra) # 13c8 <memcpy>
  if (list->strings)
      8e:	6488                	ld	a0,8(s1)
      90:	c509                	beqz	a0,9a <pushback+0x9a>
    free(list->strings);
      92:	00001097          	auipc	ra,0x1
      96:	72a080e7          	jalr	1834(ra) # 17bc <free>
  list->strings = newMemory;
      9a:	0124b423          	sd	s2,8(s1)
  list->length += 1;
      9e:	409c                	lw	a5,0(s1)
      a0:	2785                	addw	a5,a5,1
      a2:	c09c                	sw	a5,0(s1)
}
      a4:	70a2                	ld	ra,40(sp)
      a6:	7402                	ld	s0,32(sp)
      a8:	64e2                	ld	s1,24(sp)
      aa:	6942                	ld	s2,16(sp)
      ac:	69a2                	ld	s3,8(sp)
      ae:	6a02                	ld	s4,0(sp)
      b0:	6145                	add	sp,sp,48
      b2:	8082                	ret

00000000000000b4 <findcmds>:
  exit(0);
}

void
findcmds(struct strlist *cmds)
{
      b4:	715d                	add	sp,sp,-80
      b6:	e486                	sd	ra,72(sp)
      b8:	e0a2                	sd	s0,64(sp)
      ba:	fc26                	sd	s1,56(sp)
      bc:	f84a                	sd	s2,48(sp)
      be:	0880                	add	s0,sp,80
      c0:	892a                	mv	s2,a0
  struct stat st;
  struct dirent de;
  int fd = open(".", 0);
      c2:	4581                	li	a1,0
      c4:	00002517          	auipc	a0,0x2
      c8:	86c50513          	add	a0,a0,-1940 # 1930 <malloc+0xf2>
      cc:	00001097          	auipc	ra,0x1
      d0:	372080e7          	jalr	882(ra) # 143e <open>
      d4:	84aa                	mv	s1,a0
  while (read(fd, &de, sizeof(de)) == sizeof(de)) {
      d6:	4641                	li	a2,16
      d8:	fb840593          	add	a1,s0,-72
      dc:	8526                	mv	a0,s1
      de:	00001097          	auipc	ra,0x1
      e2:	338080e7          	jalr	824(ra) # 1416 <read>
      e6:	47c1                	li	a5,16
      e8:	06f51263          	bne	a0,a5,14c <findcmds+0x98>
    if (de.inum && strcmp(de.name, ".") && strcmp(de.name, "..") && (stat(de.name, &st) >= 0) && (st.type == T_FILE))
      ec:	fb845783          	lhu	a5,-72(s0)
      f0:	d3fd                	beqz	a5,d6 <findcmds+0x22>
      f2:	00002597          	auipc	a1,0x2
      f6:	83e58593          	add	a1,a1,-1986 # 1930 <malloc+0xf2>
      fa:	fba40513          	add	a0,s0,-70
      fe:	00001097          	auipc	ra,0x1
     102:	056080e7          	jalr	86(ra) # 1154 <strcmp>
     106:	d961                	beqz	a0,d6 <findcmds+0x22>
     108:	00002597          	auipc	a1,0x2
     10c:	83058593          	add	a1,a1,-2000 # 1938 <malloc+0xfa>
     110:	fba40513          	add	a0,s0,-70
     114:	00001097          	auipc	ra,0x1
     118:	040080e7          	jalr	64(ra) # 1154 <strcmp>
     11c:	dd4d                	beqz	a0,d6 <findcmds+0x22>
     11e:	fc840593          	add	a1,s0,-56
     122:	fba40513          	add	a0,s0,-70
     126:	00001097          	auipc	ra,0x1
     12a:	182080e7          	jalr	386(ra) # 12a8 <stat>
     12e:	fa0544e3          	bltz	a0,d6 <findcmds+0x22>
     132:	fd041703          	lh	a4,-48(s0)
     136:	4789                	li	a5,2
     138:	f8f71fe3          	bne	a4,a5,d6 <findcmds+0x22>
      pushback(cmds, de.name);
     13c:	fba40593          	add	a1,s0,-70
     140:	854a                	mv	a0,s2
     142:	00000097          	auipc	ra,0x0
     146:	ebe080e7          	jalr	-322(ra) # 0 <pushback>
     14a:	b771                	j	d6 <findcmds+0x22>
  }
  close(fd);
     14c:	8526                	mv	a0,s1
     14e:	00001097          	auipc	ra,0x1
     152:	2d8080e7          	jalr	728(ra) # 1426 <close>
}
     156:	60a6                	ld	ra,72(sp)
     158:	6406                	ld	s0,64(sp)
     15a:	74e2                	ld	s1,56(sp)
     15c:	7942                	ld	s2,48(sp)
     15e:	6161                	add	sp,sp,80
     160:	8082                	ret

0000000000000162 <gets_or_tab>:

char
gets_or_tab(struct strlist *history, char *buf, int max)
{
     162:	7151                	add	sp,sp,-240
     164:	f586                	sd	ra,232(sp)
     166:	f1a2                	sd	s0,224(sp)
     168:	eda6                	sd	s1,216(sp)
     16a:	e9ca                	sd	s2,208(sp)
     16c:	e5ce                	sd	s3,200(sp)
     16e:	e1d2                	sd	s4,192(sp)
     170:	fd56                	sd	s5,184(sp)
     172:	f95a                	sd	s6,176(sp)
     174:	f55e                	sd	s7,168(sp)
     176:	f162                	sd	s8,160(sp)
     178:	ed66                	sd	s9,152(sp)
     17a:	e96a                	sd	s10,144(sp)
     17c:	e56e                	sd	s11,136(sp)
     17e:	1980                	add	s0,sp,240
     180:	f0a43823          	sd	a0,-240(s0)
     184:	8bae                	mv	s7,a1
     186:	8ab2                	mv	s5,a2
  int cc, historyidx = -1;
  char c, tab = 0, curbuf[100];

  for (int i = strlen(buf); i+1 < max; ){
     188:	852e                	mv	a0,a1
     18a:	00001097          	auipc	ra,0x1
     18e:	ff6080e7          	jalr	-10(ra) # 1180 <strlen>
     192:	0005049b          	sext.w	s1,a0
  int cc, historyidx = -1;
     196:	57fd                	li	a5,-1
     198:	f0f43c23          	sd	a5,-232(s0)
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    if(c == '\t')
     19c:	4b25                	li	s6,9
     19e:	08f00a13          	li	s4,143
    }
    else if((c == '\n') || (c == '\r'))
      buf[strlen(buf)] = c;
    else
      buf[i++] = c;
    if(c == '\n' || c == '\r' || c == '\t')
     1a2:	49b5                	li	s3,13
     1a4:	0af00d93          	li	s11,175
     1a8:	0bf00d13          	li	s10,191
     1ac:	09f00c93          	li	s9,159
     1b0:	07f00c13          	li	s8,127
  for (int i = strlen(buf); i+1 < max; ){
     1b4:	a085                	j	214 <gets_or_tab+0xb2>
     1b6:	03378863          	beq	a5,s3,1e6 <gets_or_tab+0x84>
     1ba:	02f9f063          	bgeu	s3,a5,1da <gets_or_tab+0x78>
     1be:	25879163          	bne	a5,s8,400 <gets_or_tab+0x29e>
      if (i > 0) {
     1c2:	12904963          	bgtz	s1,2f4 <gets_or_tab+0x192>
    if(c == '\n' || c == '\r' || c == '\t')
     1c6:	f8f44783          	lbu	a5,-113(s0)
     1ca:	37dd                	addw	a5,a5,-9
     1cc:	0ff7f793          	zext.b	a5,a5
     1d0:	4705                	li	a4,1
     1d2:	04f76163          	bltu	a4,a5,214 <gets_or_tab+0xb2>
     1d6:	4501                	li	a0,0
      break;
  }
  return tab;
     1d8:	ac35                	j	414 <gets_or_tab+0x2b2>
     1da:	4721                	li	a4,8
     1dc:	fee783e3          	beq	a5,a4,1c2 <gets_or_tab+0x60>
     1e0:	4729                	li	a4,10
     1e2:	20e79f63          	bne	a5,a4,400 <gets_or_tab+0x29e>
      buf[strlen(buf)] = c;
     1e6:	855e                	mv	a0,s7
     1e8:	00001097          	auipc	ra,0x1
     1ec:	f98080e7          	jalr	-104(ra) # 1180 <strlen>
     1f0:	1502                	sll	a0,a0,0x20
     1f2:	9101                	srl	a0,a0,0x20
     1f4:	955e                	add	a0,a0,s7
     1f6:	f8f44783          	lbu	a5,-113(s0)
     1fa:	00f50023          	sb	a5,0(a0)
    if(c == '\n' || c == '\r' || c == '\t')
     1fe:	f8f44703          	lbu	a4,-113(s0)
     202:	ff77079b          	addw	a5,a4,-9
     206:	0ff7f793          	zext.b	a5,a5
     20a:	4685                	li	a3,1
     20c:	22f6f363          	bgeu	a3,a5,432 <gets_or_tab+0x2d0>
     210:	23370363          	beq	a4,s3,436 <gets_or_tab+0x2d4>
  for (int i = strlen(buf); i+1 < max; ){
     214:	0014891b          	addw	s2,s1,1
     218:	1f595963          	bge	s2,s5,40a <gets_or_tab+0x2a8>
    cc = read(0, &c, 1);
     21c:	4605                	li	a2,1
     21e:	f8f40593          	add	a1,s0,-113
     222:	4501                	li	a0,0
     224:	00001097          	auipc	ra,0x1
     228:	1f2080e7          	jalr	498(ra) # 1416 <read>
    if(cc < 1)
     22c:	1ea05163          	blez	a0,40e <gets_or_tab+0x2ac>
    if(c == '\t')
     230:	f8f44783          	lbu	a5,-113(s0)
     234:	1d678f63          	beq	a5,s6,412 <gets_or_tab+0x2b0>
    else if(c == '\x7f' || c == ('H' - '@')) {
     238:	0d478c63          	beq	a5,s4,310 <gets_or_tab+0x1ae>
     23c:	f6fa7de3          	bgeu	s4,a5,1b6 <gets_or_tab+0x54>
     240:	19b78363          	beq	a5,s11,3c6 <gets_or_tab+0x264>
     244:	03a79663          	bne	a5,s10,270 <gets_or_tab+0x10e>
      if (i) {
     248:	d4f1                	beqz	s1,214 <gets_or_tab+0xb2>
        char code[3] = { 0x1b, 0x5b, 0x44 };
     24a:	6799                	lui	a5,0x6
     24c:	b1b78793          	add	a5,a5,-1253 # 5b1b <base+0x3a93>
     250:	f2f41023          	sh	a5,-224(s0)
     254:	04400793          	li	a5,68
     258:	f2f40123          	sb	a5,-222(s0)
        write(2, code, 3);
     25c:	460d                	li	a2,3
     25e:	f2040593          	add	a1,s0,-224
     262:	4509                	li	a0,2
     264:	00001097          	auipc	ra,0x1
     268:	1ba080e7          	jalr	442(ra) # 141e <write>
        --i;
     26c:	34fd                	addw	s1,s1,-1
     26e:	bf41                	j	1fe <gets_or_tab+0x9c>
     270:	19979863          	bne	a5,s9,400 <gets_or_tab+0x29e>
      if (historyidx >= 0) {
     274:	f1843783          	ld	a5,-232(s0)
     278:	f807cee3          	bltz	a5,214 <gets_or_tab+0xb2>
        memset(buf, 0, i);
     27c:	0004861b          	sext.w	a2,s1
     280:	4581                	li	a1,0
     282:	855e                	mv	a0,s7
     284:	00001097          	auipc	ra,0x1
     288:	f26080e7          	jalr	-218(ra) # 11aa <memset>
        while (i) {
     28c:	cc81                	beqz	s1,2a4 <gets_or_tab+0x142>
          printf("\b \b");
     28e:	00001917          	auipc	s2,0x1
     292:	6b290913          	add	s2,s2,1714 # 1940 <malloc+0x102>
     296:	854a                	mv	a0,s2
     298:	00001097          	auipc	ra,0x1
     29c:	4ee080e7          	jalr	1262(ra) # 1786 <printf>
          --i;
     2a0:	34fd                	addw	s1,s1,-1
        while (i) {
     2a2:	f8f5                	bnez	s1,296 <gets_or_tab+0x134>
        if (--historyidx < 0)
     2a4:	f1843783          	ld	a5,-232(s0)
     2a8:	fff7891b          	addw	s2,a5,-1
     2ac:	10094563          	bltz	s2,3b6 <gets_or_tab+0x254>
          strcpy(buf, history->strings[history->length - 1 - historyidx]);
     2b0:	f1043703          	ld	a4,-240(s0)
     2b4:	431c                	lw	a5,0(a4)
     2b6:	f1843683          	ld	a3,-232(s0)
     2ba:	9f95                	subw	a5,a5,a3
     2bc:	6718                	ld	a4,8(a4)
     2be:	078e                	sll	a5,a5,0x3
     2c0:	97ba                	add	a5,a5,a4
     2c2:	638c                	ld	a1,0(a5)
     2c4:	855e                	mv	a0,s7
     2c6:	00001097          	auipc	ra,0x1
     2ca:	e72080e7          	jalr	-398(ra) # 1138 <strcpy>
        printf("%s", buf);
     2ce:	85de                	mv	a1,s7
     2d0:	00001517          	auipc	a0,0x1
     2d4:	67850513          	add	a0,a0,1656 # 1948 <malloc+0x10a>
     2d8:	00001097          	auipc	ra,0x1
     2dc:	4ae080e7          	jalr	1198(ra) # 1786 <printf>
        i = strlen(buf);
     2e0:	855e                	mv	a0,s7
     2e2:	00001097          	auipc	ra,0x1
     2e6:	e9e080e7          	jalr	-354(ra) # 1180 <strlen>
     2ea:	0005049b          	sext.w	s1,a0
        if (--historyidx < 0)
     2ee:	f1243c23          	sd	s2,-232(s0)
     2f2:	b731                	j	1fe <gets_or_tab+0x9c>
        buf[--i] = '\0';
     2f4:	34fd                	addw	s1,s1,-1
     2f6:	009b87b3          	add	a5,s7,s1
     2fa:	00078023          	sb	zero,0(a5)
        printf("\b \b");
     2fe:	00001517          	auipc	a0,0x1
     302:	64250513          	add	a0,a0,1602 # 1940 <malloc+0x102>
     306:	00001097          	auipc	ra,0x1
     30a:	480080e7          	jalr	1152(ra) # 1786 <printf>
     30e:	bdc5                	j	1fe <gets_or_tab+0x9c>
      if (historyidx < 0)
     310:	f1843783          	ld	a5,-232(s0)
     314:	0807c063          	bltz	a5,394 <gets_or_tab+0x232>
      if (historyidx + 1 < history->length) {
     318:	f1843783          	ld	a5,-232(s0)
     31c:	0017891b          	addw	s2,a5,1
     320:	f1043783          	ld	a5,-240(s0)
     324:	439c                	lw	a5,0(a5)
     326:	eef957e3          	bge	s2,a5,214 <gets_or_tab+0xb2>
        memset(buf, 0, i);
     32a:	0004861b          	sext.w	a2,s1
     32e:	4581                	li	a1,0
     330:	855e                	mv	a0,s7
     332:	00001097          	auipc	ra,0x1
     336:	e78080e7          	jalr	-392(ra) # 11aa <memset>
        while (i) {
     33a:	c899                	beqz	s1,350 <gets_or_tab+0x1ee>
          printf("\b \b");
     33c:	00001517          	auipc	a0,0x1
     340:	60450513          	add	a0,a0,1540 # 1940 <malloc+0x102>
     344:	00001097          	auipc	ra,0x1
     348:	442080e7          	jalr	1090(ra) # 1786 <printf>
          --i;
     34c:	34fd                	addw	s1,s1,-1
        while (i) {
     34e:	f4fd                	bnez	s1,33c <gets_or_tab+0x1da>
        strcpy(buf, history->strings[history->length - 1 - ++historyidx]);
     350:	f1043703          	ld	a4,-240(s0)
     354:	431c                	lw	a5,0(a4)
     356:	37fd                	addw	a5,a5,-1
     358:	412787bb          	subw	a5,a5,s2
     35c:	6718                	ld	a4,8(a4)
     35e:	078e                	sll	a5,a5,0x3
     360:	97ba                	add	a5,a5,a4
     362:	638c                	ld	a1,0(a5)
     364:	855e                	mv	a0,s7
     366:	00001097          	auipc	ra,0x1
     36a:	dd2080e7          	jalr	-558(ra) # 1138 <strcpy>
        printf("%s", buf);
     36e:	85de                	mv	a1,s7
     370:	00001517          	auipc	a0,0x1
     374:	5d850513          	add	a0,a0,1496 # 1948 <malloc+0x10a>
     378:	00001097          	auipc	ra,0x1
     37c:	40e080e7          	jalr	1038(ra) # 1786 <printf>
        i = strlen(buf);
     380:	855e                	mv	a0,s7
     382:	00001097          	auipc	ra,0x1
     386:	dfe080e7          	jalr	-514(ra) # 1180 <strlen>
     38a:	0005049b          	sext.w	s1,a0
     38e:	f1243c23          	sd	s2,-232(s0)
     392:	b5b5                	j	1fe <gets_or_tab+0x9c>
        strcpy(curbuf, buf);
     394:	85de                	mv	a1,s7
     396:	f2840513          	add	a0,s0,-216
     39a:	00001097          	auipc	ra,0x1
     39e:	d9e080e7          	jalr	-610(ra) # 1138 <strcpy>
      if (historyidx + 1 < history->length) {
     3a2:	f1843783          	ld	a5,-232(s0)
     3a6:	0017891b          	addw	s2,a5,1
     3aa:	f1043783          	ld	a5,-240(s0)
     3ae:	439c                	lw	a5,0(a5)
     3b0:	e4f957e3          	bge	s2,a5,1fe <gets_or_tab+0x9c>
     3b4:	bf9d                	j	32a <gets_or_tab+0x1c8>
          strcpy(buf, curbuf);
     3b6:	f2840593          	add	a1,s0,-216
     3ba:	855e                	mv	a0,s7
     3bc:	00001097          	auipc	ra,0x1
     3c0:	d7c080e7          	jalr	-644(ra) # 1138 <strcpy>
     3c4:	b729                	j	2ce <gets_or_tab+0x16c>
      if (i < strlen(buf)) {
     3c6:	855e                	mv	a0,s7
     3c8:	00001097          	auipc	ra,0x1
     3cc:	db8080e7          	jalr	-584(ra) # 1180 <strlen>
     3d0:	2501                	sext.w	a0,a0
     3d2:	0004879b          	sext.w	a5,s1
     3d6:	e2a7f4e3          	bgeu	a5,a0,1fe <gets_or_tab+0x9c>
        char code[3] = { 0x1b, 0x5b, 0x43 };
     3da:	6799                	lui	a5,0x6
     3dc:	b1b78793          	add	a5,a5,-1253 # 5b1b <base+0x3a93>
     3e0:	f2f41023          	sh	a5,-224(s0)
     3e4:	04300793          	li	a5,67
     3e8:	f2f40123          	sb	a5,-222(s0)
        write(2, code, 3);
     3ec:	460d                	li	a2,3
     3ee:	f2040593          	add	a1,s0,-224
     3f2:	4509                	li	a0,2
     3f4:	00001097          	auipc	ra,0x1
     3f8:	02a080e7          	jalr	42(ra) # 141e <write>
        ++i;
     3fc:	84ca                	mv	s1,s2
     3fe:	b501                	j	1fe <gets_or_tab+0x9c>
      buf[i++] = c;
     400:	94de                	add	s1,s1,s7
     402:	00f48023          	sb	a5,0(s1)
     406:	84ca                	mv	s1,s2
     408:	bbdd                	j	1fe <gets_or_tab+0x9c>
     40a:	4501                	li	a0,0
     40c:	a021                	j	414 <gets_or_tab+0x2b2>
     40e:	4501                	li	a0,0
     410:	a011                	j	414 <gets_or_tab+0x2b2>
      tab = 1;
     412:	4505                	li	a0,1
}
     414:	70ae                	ld	ra,232(sp)
     416:	740e                	ld	s0,224(sp)
     418:	64ee                	ld	s1,216(sp)
     41a:	694e                	ld	s2,208(sp)
     41c:	69ae                	ld	s3,200(sp)
     41e:	6a0e                	ld	s4,192(sp)
     420:	7aea                	ld	s5,184(sp)
     422:	7b4a                	ld	s6,176(sp)
     424:	7baa                	ld	s7,168(sp)
     426:	7c0a                	ld	s8,160(sp)
     428:	6cea                	ld	s9,152(sp)
     42a:	6d4a                	ld	s10,144(sp)
     42c:	6daa                	ld	s11,136(sp)
     42e:	616d                	add	sp,sp,240
     430:	8082                	ret
     432:	4501                	li	a0,0
     434:	b7c5                	j	414 <gets_or_tab+0x2b2>
     436:	4501                	li	a0,0
     438:	bff1                	j	414 <gets_or_tab+0x2b2>

000000000000043a <getcmd>:

int
getcmd(struct strlist *cmds, struct strlist *history, char *buf, int nbuf)
{
     43a:	7159                	add	sp,sp,-112
     43c:	f486                	sd	ra,104(sp)
     43e:	f0a2                	sd	s0,96(sp)
     440:	eca6                	sd	s1,88(sp)
     442:	e8ca                	sd	s2,80(sp)
     444:	e4ce                	sd	s3,72(sp)
     446:	e0d2                	sd	s4,64(sp)
     448:	fc56                	sd	s5,56(sp)
     44a:	f85a                	sd	s6,48(sp)
     44c:	f45e                	sd	s7,40(sp)
     44e:	f062                	sd	s8,32(sp)
     450:	ec66                	sd	s9,24(sp)
     452:	e86a                	sd	s10,16(sp)
     454:	e46e                	sd	s11,8(sp)
     456:	1880                	add	s0,sp,112
     458:	892a                	mv	s2,a0
     45a:	8dae                	mv	s11,a1
     45c:	8bb2                	mv	s7,a2
     45e:	8d36                	mv	s10,a3
  write(2, "$ ", 2);
     460:	4609                	li	a2,2
     462:	00001597          	auipc	a1,0x1
     466:	4ee58593          	add	a1,a1,1262 # 1950 <malloc+0x112>
     46a:	4509                	li	a0,2
     46c:	00001097          	auipc	ra,0x1
     470:	fb2080e7          	jalr	-78(ra) # 141e <write>
  memset(buf, 0, nbuf);
     474:	866a                	mv	a2,s10
     476:	4581                	li	a1,0
     478:	855e                	mv	a0,s7
     47a:	00001097          	auipc	ra,0x1
     47e:	d30080e7          	jalr	-720(ra) # 11aa <memset>
  char *testcmd = 0;
  int tabidx = 0, cmdidx = 0;
     482:	4481                	li	s1,0
     484:	4c01                	li	s8,0
  char *testcmd = 0;
     486:	4c81                	li	s9,0
  while (gets_or_tab(history, buf, nbuf)) {
    if (!testcmd || (strlen(buf) - strlen(testcmd))) {
      cmdidx = 0;
     488:	4b01                	li	s6,0
    else {
      memset(buf + tabidx, 0, strlen(buf) - tabidx);
      for (int i = strlen(testcmd) - tabidx; testcmd && i > 0; --i)
        printf("\b \b");
    }
    for (int loop = 0 ; loop < 2; ) {
     48a:	4a85                	li	s5,1
  while (gets_or_tab(history, buf, nbuf)) {
     48c:	a871                	j	528 <getcmd+0xee>
      memset(buf + tabidx, 0, strlen(buf) - tabidx);
     48e:	018b89b3          	add	s3,s7,s8
     492:	855e                	mv	a0,s7
     494:	00001097          	auipc	ra,0x1
     498:	cec080e7          	jalr	-788(ra) # 1180 <strlen>
     49c:	000c0a1b          	sext.w	s4,s8
     4a0:	4185063b          	subw	a2,a0,s8
     4a4:	4581                	li	a1,0
     4a6:	854e                	mv	a0,s3
     4a8:	00001097          	auipc	ra,0x1
     4ac:	d02080e7          	jalr	-766(ra) # 11aa <memset>
      for (int i = strlen(testcmd) - tabidx; testcmd && i > 0; --i)
     4b0:	8566                	mv	a0,s9
     4b2:	00001097          	auipc	ra,0x1
     4b6:	cce080e7          	jalr	-818(ra) # 1180 <strlen>
     4ba:	414509bb          	subw	s3,a0,s4
     4be:	0b305663          	blez	s3,56a <getcmd+0x130>
        printf("\b \b");
     4c2:	00001a17          	auipc	s4,0x1
     4c6:	47ea0a13          	add	s4,s4,1150 # 1940 <malloc+0x102>
     4ca:	8552                	mv	a0,s4
     4cc:	00001097          	auipc	ra,0x1
     4d0:	2ba080e7          	jalr	698(ra) # 1786 <printf>
      for (int i = strlen(testcmd) - tabidx; testcmd && i > 0; --i)
     4d4:	39fd                	addw	s3,s3,-1
     4d6:	fe099ae3          	bnez	s3,4ca <getcmd+0x90>
     4da:	a841                	j	56a <getcmd+0x130>
      if ((cmdidx < cmds->length) && (strstr(cmds->strings[cmdidx], buf) == cmds->strings[cmdidx])) {
     4dc:	00349a13          	sll	s4,s1,0x3
     4e0:	00893783          	ld	a5,8(s2)
     4e4:	97d2                	add	a5,a5,s4
     4e6:	85de                	mv	a1,s7
     4e8:	6388                	ld	a0,0(a5)
     4ea:	00001097          	auipc	ra,0x1
     4ee:	d06080e7          	jalr	-762(ra) # 11f0 <strstr>
     4f2:	00893783          	ld	a5,8(s2)
     4f6:	97d2                	add	a5,a5,s4
     4f8:	0007ba03          	ld	s4,0(a5)
     4fc:	06aa1f63          	bne	s4,a0,57a <getcmd+0x140>
        testcmd = cmds->strings[cmdidx++];
     500:	2485                	addw	s1,s1,1
        strcpy(buf + tabidx, testcmd + tabidx);
     502:	018a09b3          	add	s3,s4,s8
     506:	85ce                	mv	a1,s3
     508:	018b8533          	add	a0,s7,s8
     50c:	00001097          	auipc	ra,0x1
     510:	c2c080e7          	jalr	-980(ra) # 1138 <strcpy>
        printf("%s", testcmd + tabidx);
     514:	85ce                	mv	a1,s3
     516:	00001517          	auipc	a0,0x1
     51a:	43250513          	add	a0,a0,1074 # 1948 <malloc+0x10a>
     51e:	00001097          	auipc	ra,0x1
     522:	268080e7          	jalr	616(ra) # 1786 <printf>
      if ((cmdidx < cmds->length) && (strstr(cmds->strings[cmdidx], buf) == cmds->strings[cmdidx])) {
     526:	8cd2                	mv	s9,s4
  while (gets_or_tab(history, buf, nbuf)) {
     528:	866a                	mv	a2,s10
     52a:	85de                	mv	a1,s7
     52c:	856e                	mv	a0,s11
     52e:	00000097          	auipc	ra,0x0
     532:	c34080e7          	jalr	-972(ra) # 162 <gets_or_tab>
     536:	c931                	beqz	a0,58a <getcmd+0x150>
    if (!testcmd || (strlen(buf) - strlen(testcmd))) {
     538:	020c8163          	beqz	s9,55a <getcmd+0x120>
     53c:	855e                	mv	a0,s7
     53e:	00001097          	auipc	ra,0x1
     542:	c42080e7          	jalr	-958(ra) # 1180 <strlen>
     546:	0005099b          	sext.w	s3,a0
     54a:	8566                	mv	a0,s9
     54c:	00001097          	auipc	ra,0x1
     550:	c34080e7          	jalr	-972(ra) # 1180 <strlen>
     554:	2501                	sext.w	a0,a0
     556:	f2a98ce3          	beq	s3,a0,48e <getcmd+0x54>
      tabidx = strlen(buf);
     55a:	855e                	mv	a0,s7
     55c:	00001097          	auipc	ra,0x1
     560:	c24080e7          	jalr	-988(ra) # 1180 <strlen>
     564:	00050c1b          	sext.w	s8,a0
      cmdidx = 0;
     568:	84da                	mv	s1,s6
    for (int loop = 0 ; loop < 2; ) {
     56a:	89da                	mv	s3,s6
     56c:	a019                	j	572 <getcmd+0x138>
     56e:	fb3acde3          	blt	s5,s3,528 <getcmd+0xee>
      if ((cmdidx < cmds->length) && (strstr(cmds->strings[cmdidx], buf) == cmds->strings[cmdidx])) {
     572:	00092783          	lw	a5,0(s2)
     576:	f6f4c3e3          	blt	s1,a5,4dc <getcmd+0xa2>
        break;
      }
      else if (++cmdidx >= cmds->length) {
     57a:	2485                	addw	s1,s1,1
     57c:	00092783          	lw	a5,0(s2)
     580:	fef4c7e3          	blt	s1,a5,56e <getcmd+0x134>
        cmdidx = 0;
        ++loop;
     584:	2985                	addw	s3,s3,1
        cmdidx = 0;
     586:	84da                	mv	s1,s6
     588:	b7dd                	j	56e <getcmd+0x134>
      }
    }
  }
  if(buf[0] == 0) // EOF
     58a:	000bc783          	lbu	a5,0(s7)
     58e:	c7b9                	beqz	a5,5dc <getcmd+0x1a2>
    return -1;
  if(buf[0] != '\n') {
     590:	4729                	li	a4,10
     592:	02e79163          	bne	a5,a4,5b4 <getcmd+0x17a>
    buf[strlen(buf)-1] = '\0';
    pushback(history, buf);
  }
  return 0;
}
     596:	70a6                	ld	ra,104(sp)
     598:	7406                	ld	s0,96(sp)
     59a:	64e6                	ld	s1,88(sp)
     59c:	6946                	ld	s2,80(sp)
     59e:	69a6                	ld	s3,72(sp)
     5a0:	6a06                	ld	s4,64(sp)
     5a2:	7ae2                	ld	s5,56(sp)
     5a4:	7b42                	ld	s6,48(sp)
     5a6:	7ba2                	ld	s7,40(sp)
     5a8:	7c02                	ld	s8,32(sp)
     5aa:	6ce2                	ld	s9,24(sp)
     5ac:	6d42                	ld	s10,16(sp)
     5ae:	6da2                	ld	s11,8(sp)
     5b0:	6165                	add	sp,sp,112
     5b2:	8082                	ret
    buf[strlen(buf)-1] = '\0';
     5b4:	855e                	mv	a0,s7
     5b6:	00001097          	auipc	ra,0x1
     5ba:	bca080e7          	jalr	-1078(ra) # 1180 <strlen>
     5be:	fff5079b          	addw	a5,a0,-1
     5c2:	1782                	sll	a5,a5,0x20
     5c4:	9381                	srl	a5,a5,0x20
     5c6:	97de                	add	a5,a5,s7
     5c8:	00078023          	sb	zero,0(a5)
    pushback(history, buf);
     5cc:	85de                	mv	a1,s7
     5ce:	856e                	mv	a0,s11
     5d0:	00000097          	auipc	ra,0x0
     5d4:	a30080e7          	jalr	-1488(ra) # 0 <pushback>
  return 0;
     5d8:	4501                	li	a0,0
     5da:	bf75                	j	596 <getcmd+0x15c>
    return -1;
     5dc:	557d                	li	a0,-1
     5de:	bf65                	j	596 <getcmd+0x15c>

00000000000005e0 <panic>:
  exit(0);
}

void
panic(char *s)
{
     5e0:	1141                	add	sp,sp,-16
     5e2:	e406                	sd	ra,8(sp)
     5e4:	e022                	sd	s0,0(sp)
     5e6:	0800                	add	s0,sp,16
     5e8:	862a                	mv	a2,a0
  fprintf(2, "%s\n", s);
     5ea:	00001597          	auipc	a1,0x1
     5ee:	36e58593          	add	a1,a1,878 # 1958 <malloc+0x11a>
     5f2:	4509                	li	a0,2
     5f4:	00001097          	auipc	ra,0x1
     5f8:	164080e7          	jalr	356(ra) # 1758 <fprintf>
  exit(1);
     5fc:	4505                	li	a0,1
     5fe:	00001097          	auipc	ra,0x1
     602:	e00080e7          	jalr	-512(ra) # 13fe <exit>

0000000000000606 <fork1>:
}

int
fork1(void)
{
     606:	1141                	add	sp,sp,-16
     608:	e406                	sd	ra,8(sp)
     60a:	e022                	sd	s0,0(sp)
     60c:	0800                	add	s0,sp,16
  int pid;

  pid = fork();
     60e:	00001097          	auipc	ra,0x1
     612:	de8080e7          	jalr	-536(ra) # 13f6 <fork>
  if(pid == -1)
     616:	57fd                	li	a5,-1
     618:	00f50663          	beq	a0,a5,624 <fork1+0x1e>
    panic("fork");
  return pid;
}
     61c:	60a2                	ld	ra,8(sp)
     61e:	6402                	ld	s0,0(sp)
     620:	0141                	add	sp,sp,16
     622:	8082                	ret
    panic("fork");
     624:	00001517          	auipc	a0,0x1
     628:	33c50513          	add	a0,a0,828 # 1960 <malloc+0x122>
     62c:	00000097          	auipc	ra,0x0
     630:	fb4080e7          	jalr	-76(ra) # 5e0 <panic>

0000000000000634 <runcmd>:
{
     634:	7179                	add	sp,sp,-48
     636:	f406                	sd	ra,40(sp)
     638:	f022                	sd	s0,32(sp)
     63a:	ec26                	sd	s1,24(sp)
     63c:	1800                	add	s0,sp,48
  if(cmd == 0)
     63e:	c10d                	beqz	a0,660 <runcmd+0x2c>
     640:	84aa                	mv	s1,a0
  switch(cmd->type){
     642:	4118                	lw	a4,0(a0)
     644:	4795                	li	a5,5
     646:	02e7e263          	bltu	a5,a4,66a <runcmd+0x36>
     64a:	00056783          	lwu	a5,0(a0)
     64e:	078a                	sll	a5,a5,0x2
     650:	00001717          	auipc	a4,0x1
     654:	41070713          	add	a4,a4,1040 # 1a60 <malloc+0x222>
     658:	97ba                	add	a5,a5,a4
     65a:	439c                	lw	a5,0(a5)
     65c:	97ba                	add	a5,a5,a4
     65e:	8782                	jr	a5
    exit(1);
     660:	4505                	li	a0,1
     662:	00001097          	auipc	ra,0x1
     666:	d9c080e7          	jalr	-612(ra) # 13fe <exit>
    panic("runcmd");
     66a:	00001517          	auipc	a0,0x1
     66e:	2fe50513          	add	a0,a0,766 # 1968 <malloc+0x12a>
     672:	00000097          	auipc	ra,0x0
     676:	f6e080e7          	jalr	-146(ra) # 5e0 <panic>
    if(ecmd->argv[0] == 0)
     67a:	6508                	ld	a0,8(a0)
     67c:	c515                	beqz	a0,6a8 <runcmd+0x74>
    exec(ecmd->argv[0], ecmd->argv);
     67e:	00848593          	add	a1,s1,8
     682:	00001097          	auipc	ra,0x1
     686:	db4080e7          	jalr	-588(ra) # 1436 <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
     68a:	6490                	ld	a2,8(s1)
     68c:	00001597          	auipc	a1,0x1
     690:	2e458593          	add	a1,a1,740 # 1970 <malloc+0x132>
     694:	4509                	li	a0,2
     696:	00001097          	auipc	ra,0x1
     69a:	0c2080e7          	jalr	194(ra) # 1758 <fprintf>
  exit(0);
     69e:	4501                	li	a0,0
     6a0:	00001097          	auipc	ra,0x1
     6a4:	d5e080e7          	jalr	-674(ra) # 13fe <exit>
      exit(1);
     6a8:	4505                	li	a0,1
     6aa:	00001097          	auipc	ra,0x1
     6ae:	d54080e7          	jalr	-684(ra) # 13fe <exit>
    close(rcmd->fd);
     6b2:	5148                	lw	a0,36(a0)
     6b4:	00001097          	auipc	ra,0x1
     6b8:	d72080e7          	jalr	-654(ra) # 1426 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     6bc:	508c                	lw	a1,32(s1)
     6be:	6888                	ld	a0,16(s1)
     6c0:	00001097          	auipc	ra,0x1
     6c4:	d7e080e7          	jalr	-642(ra) # 143e <open>
     6c8:	00054763          	bltz	a0,6d6 <runcmd+0xa2>
    runcmd(rcmd->cmd);
     6cc:	6488                	ld	a0,8(s1)
     6ce:	00000097          	auipc	ra,0x0
     6d2:	f66080e7          	jalr	-154(ra) # 634 <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     6d6:	6890                	ld	a2,16(s1)
     6d8:	00001597          	auipc	a1,0x1
     6dc:	2a858593          	add	a1,a1,680 # 1980 <malloc+0x142>
     6e0:	4509                	li	a0,2
     6e2:	00001097          	auipc	ra,0x1
     6e6:	076080e7          	jalr	118(ra) # 1758 <fprintf>
      exit(1);
     6ea:	4505                	li	a0,1
     6ec:	00001097          	auipc	ra,0x1
     6f0:	d12080e7          	jalr	-750(ra) # 13fe <exit>
    if(fork1() == 0)
     6f4:	00000097          	auipc	ra,0x0
     6f8:	f12080e7          	jalr	-238(ra) # 606 <fork1>
     6fc:	e511                	bnez	a0,708 <runcmd+0xd4>
      runcmd(lcmd->left);
     6fe:	6488                	ld	a0,8(s1)
     700:	00000097          	auipc	ra,0x0
     704:	f34080e7          	jalr	-204(ra) # 634 <runcmd>
    wait(0);
     708:	4501                	li	a0,0
     70a:	00001097          	auipc	ra,0x1
     70e:	cfc080e7          	jalr	-772(ra) # 1406 <wait>
    runcmd(lcmd->right);
     712:	6888                	ld	a0,16(s1)
     714:	00000097          	auipc	ra,0x0
     718:	f20080e7          	jalr	-224(ra) # 634 <runcmd>
    if(pipe(p) < 0)
     71c:	fd840513          	add	a0,s0,-40
     720:	00001097          	auipc	ra,0x1
     724:	cee080e7          	jalr	-786(ra) # 140e <pipe>
     728:	04054363          	bltz	a0,76e <runcmd+0x13a>
    if(fork1() == 0){
     72c:	00000097          	auipc	ra,0x0
     730:	eda080e7          	jalr	-294(ra) # 606 <fork1>
     734:	e529                	bnez	a0,77e <runcmd+0x14a>
      close(1);
     736:	4505                	li	a0,1
     738:	00001097          	auipc	ra,0x1
     73c:	cee080e7          	jalr	-786(ra) # 1426 <close>
      dup(p[1]);
     740:	fdc42503          	lw	a0,-36(s0)
     744:	00001097          	auipc	ra,0x1
     748:	d32080e7          	jalr	-718(ra) # 1476 <dup>
      close(p[0]);
     74c:	fd842503          	lw	a0,-40(s0)
     750:	00001097          	auipc	ra,0x1
     754:	cd6080e7          	jalr	-810(ra) # 1426 <close>
      close(p[1]);
     758:	fdc42503          	lw	a0,-36(s0)
     75c:	00001097          	auipc	ra,0x1
     760:	cca080e7          	jalr	-822(ra) # 1426 <close>
      runcmd(pcmd->left);
     764:	6488                	ld	a0,8(s1)
     766:	00000097          	auipc	ra,0x0
     76a:	ece080e7          	jalr	-306(ra) # 634 <runcmd>
      panic("pipe");
     76e:	00001517          	auipc	a0,0x1
     772:	22250513          	add	a0,a0,546 # 1990 <malloc+0x152>
     776:	00000097          	auipc	ra,0x0
     77a:	e6a080e7          	jalr	-406(ra) # 5e0 <panic>
    if(fork1() == 0){
     77e:	00000097          	auipc	ra,0x0
     782:	e88080e7          	jalr	-376(ra) # 606 <fork1>
     786:	ed05                	bnez	a0,7be <runcmd+0x18a>
      close(0);
     788:	00001097          	auipc	ra,0x1
     78c:	c9e080e7          	jalr	-866(ra) # 1426 <close>
      dup(p[0]);
     790:	fd842503          	lw	a0,-40(s0)
     794:	00001097          	auipc	ra,0x1
     798:	ce2080e7          	jalr	-798(ra) # 1476 <dup>
      close(p[0]);
     79c:	fd842503          	lw	a0,-40(s0)
     7a0:	00001097          	auipc	ra,0x1
     7a4:	c86080e7          	jalr	-890(ra) # 1426 <close>
      close(p[1]);
     7a8:	fdc42503          	lw	a0,-36(s0)
     7ac:	00001097          	auipc	ra,0x1
     7b0:	c7a080e7          	jalr	-902(ra) # 1426 <close>
      runcmd(pcmd->right);
     7b4:	6888                	ld	a0,16(s1)
     7b6:	00000097          	auipc	ra,0x0
     7ba:	e7e080e7          	jalr	-386(ra) # 634 <runcmd>
    close(p[0]);
     7be:	fd842503          	lw	a0,-40(s0)
     7c2:	00001097          	auipc	ra,0x1
     7c6:	c64080e7          	jalr	-924(ra) # 1426 <close>
    close(p[1]);
     7ca:	fdc42503          	lw	a0,-36(s0)
     7ce:	00001097          	auipc	ra,0x1
     7d2:	c58080e7          	jalr	-936(ra) # 1426 <close>
    wait(0);
     7d6:	4501                	li	a0,0
     7d8:	00001097          	auipc	ra,0x1
     7dc:	c2e080e7          	jalr	-978(ra) # 1406 <wait>
    wait(0);
     7e0:	4501                	li	a0,0
     7e2:	00001097          	auipc	ra,0x1
     7e6:	c24080e7          	jalr	-988(ra) # 1406 <wait>
    break;
     7ea:	bd55                	j	69e <runcmd+0x6a>
    if(fork1() == 0)
     7ec:	00000097          	auipc	ra,0x0
     7f0:	e1a080e7          	jalr	-486(ra) # 606 <fork1>
     7f4:	ea0515e3          	bnez	a0,69e <runcmd+0x6a>
      runcmd(bcmd->cmd);
     7f8:	6488                	ld	a0,8(s1)
     7fa:	00000097          	auipc	ra,0x0
     7fe:	e3a080e7          	jalr	-454(ra) # 634 <runcmd>

0000000000000802 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     802:	1101                	add	sp,sp,-32
     804:	ec06                	sd	ra,24(sp)
     806:	e822                	sd	s0,16(sp)
     808:	e426                	sd	s1,8(sp)
     80a:	1000                	add	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     80c:	0a800513          	li	a0,168
     810:	00001097          	auipc	ra,0x1
     814:	02e080e7          	jalr	46(ra) # 183e <malloc>
     818:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     81a:	0a800613          	li	a2,168
     81e:	4581                	li	a1,0
     820:	00001097          	auipc	ra,0x1
     824:	98a080e7          	jalr	-1654(ra) # 11aa <memset>
  cmd->type = EXEC;
     828:	4785                	li	a5,1
     82a:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
     82c:	8526                	mv	a0,s1
     82e:	60e2                	ld	ra,24(sp)
     830:	6442                	ld	s0,16(sp)
     832:	64a2                	ld	s1,8(sp)
     834:	6105                	add	sp,sp,32
     836:	8082                	ret

0000000000000838 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     838:	7139                	add	sp,sp,-64
     83a:	fc06                	sd	ra,56(sp)
     83c:	f822                	sd	s0,48(sp)
     83e:	f426                	sd	s1,40(sp)
     840:	f04a                	sd	s2,32(sp)
     842:	ec4e                	sd	s3,24(sp)
     844:	e852                	sd	s4,16(sp)
     846:	e456                	sd	s5,8(sp)
     848:	e05a                	sd	s6,0(sp)
     84a:	0080                	add	s0,sp,64
     84c:	8b2a                	mv	s6,a0
     84e:	8aae                	mv	s5,a1
     850:	8a32                	mv	s4,a2
     852:	89b6                	mv	s3,a3
     854:	893a                	mv	s2,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     856:	02800513          	li	a0,40
     85a:	00001097          	auipc	ra,0x1
     85e:	fe4080e7          	jalr	-28(ra) # 183e <malloc>
     862:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     864:	02800613          	li	a2,40
     868:	4581                	li	a1,0
     86a:	00001097          	auipc	ra,0x1
     86e:	940080e7          	jalr	-1728(ra) # 11aa <memset>
  cmd->type = REDIR;
     872:	4789                	li	a5,2
     874:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     876:	0164b423          	sd	s6,8(s1)
  cmd->file = file;
     87a:	0154b823          	sd	s5,16(s1)
  cmd->efile = efile;
     87e:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
     882:	0334a023          	sw	s3,32(s1)
  cmd->fd = fd;
     886:	0324a223          	sw	s2,36(s1)
  return (struct cmd*)cmd;
}
     88a:	8526                	mv	a0,s1
     88c:	70e2                	ld	ra,56(sp)
     88e:	7442                	ld	s0,48(sp)
     890:	74a2                	ld	s1,40(sp)
     892:	7902                	ld	s2,32(sp)
     894:	69e2                	ld	s3,24(sp)
     896:	6a42                	ld	s4,16(sp)
     898:	6aa2                	ld	s5,8(sp)
     89a:	6b02                	ld	s6,0(sp)
     89c:	6121                	add	sp,sp,64
     89e:	8082                	ret

00000000000008a0 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     8a0:	7179                	add	sp,sp,-48
     8a2:	f406                	sd	ra,40(sp)
     8a4:	f022                	sd	s0,32(sp)
     8a6:	ec26                	sd	s1,24(sp)
     8a8:	e84a                	sd	s2,16(sp)
     8aa:	e44e                	sd	s3,8(sp)
     8ac:	1800                	add	s0,sp,48
     8ae:	89aa                	mv	s3,a0
     8b0:	892e                	mv	s2,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     8b2:	4561                	li	a0,24
     8b4:	00001097          	auipc	ra,0x1
     8b8:	f8a080e7          	jalr	-118(ra) # 183e <malloc>
     8bc:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     8be:	4661                	li	a2,24
     8c0:	4581                	li	a1,0
     8c2:	00001097          	auipc	ra,0x1
     8c6:	8e8080e7          	jalr	-1816(ra) # 11aa <memset>
  cmd->type = PIPE;
     8ca:	478d                	li	a5,3
     8cc:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     8ce:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     8d2:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     8d6:	8526                	mv	a0,s1
     8d8:	70a2                	ld	ra,40(sp)
     8da:	7402                	ld	s0,32(sp)
     8dc:	64e2                	ld	s1,24(sp)
     8de:	6942                	ld	s2,16(sp)
     8e0:	69a2                	ld	s3,8(sp)
     8e2:	6145                	add	sp,sp,48
     8e4:	8082                	ret

00000000000008e6 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     8e6:	7179                	add	sp,sp,-48
     8e8:	f406                	sd	ra,40(sp)
     8ea:	f022                	sd	s0,32(sp)
     8ec:	ec26                	sd	s1,24(sp)
     8ee:	e84a                	sd	s2,16(sp)
     8f0:	e44e                	sd	s3,8(sp)
     8f2:	1800                	add	s0,sp,48
     8f4:	89aa                	mv	s3,a0
     8f6:	892e                	mv	s2,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     8f8:	4561                	li	a0,24
     8fa:	00001097          	auipc	ra,0x1
     8fe:	f44080e7          	jalr	-188(ra) # 183e <malloc>
     902:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     904:	4661                	li	a2,24
     906:	4581                	li	a1,0
     908:	00001097          	auipc	ra,0x1
     90c:	8a2080e7          	jalr	-1886(ra) # 11aa <memset>
  cmd->type = LIST;
     910:	4791                	li	a5,4
     912:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     914:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     918:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     91c:	8526                	mv	a0,s1
     91e:	70a2                	ld	ra,40(sp)
     920:	7402                	ld	s0,32(sp)
     922:	64e2                	ld	s1,24(sp)
     924:	6942                	ld	s2,16(sp)
     926:	69a2                	ld	s3,8(sp)
     928:	6145                	add	sp,sp,48
     92a:	8082                	ret

000000000000092c <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     92c:	1101                	add	sp,sp,-32
     92e:	ec06                	sd	ra,24(sp)
     930:	e822                	sd	s0,16(sp)
     932:	e426                	sd	s1,8(sp)
     934:	e04a                	sd	s2,0(sp)
     936:	1000                	add	s0,sp,32
     938:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     93a:	4541                	li	a0,16
     93c:	00001097          	auipc	ra,0x1
     940:	f02080e7          	jalr	-254(ra) # 183e <malloc>
     944:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     946:	4641                	li	a2,16
     948:	4581                	li	a1,0
     94a:	00001097          	auipc	ra,0x1
     94e:	860080e7          	jalr	-1952(ra) # 11aa <memset>
  cmd->type = BACK;
     952:	4795                	li	a5,5
     954:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     956:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
     95a:	8526                	mv	a0,s1
     95c:	60e2                	ld	ra,24(sp)
     95e:	6442                	ld	s0,16(sp)
     960:	64a2                	ld	s1,8(sp)
     962:	6902                	ld	s2,0(sp)
     964:	6105                	add	sp,sp,32
     966:	8082                	ret

0000000000000968 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     968:	7139                	add	sp,sp,-64
     96a:	fc06                	sd	ra,56(sp)
     96c:	f822                	sd	s0,48(sp)
     96e:	f426                	sd	s1,40(sp)
     970:	f04a                	sd	s2,32(sp)
     972:	ec4e                	sd	s3,24(sp)
     974:	e852                	sd	s4,16(sp)
     976:	e456                	sd	s5,8(sp)
     978:	e05a                	sd	s6,0(sp)
     97a:	0080                	add	s0,sp,64
     97c:	8a2a                	mv	s4,a0
     97e:	892e                	mv	s2,a1
     980:	8ab2                	mv	s5,a2
     982:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
     984:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     986:	00001997          	auipc	s3,0x1
     98a:	68298993          	add	s3,s3,1666 # 2008 <whitespace>
     98e:	00b4fe63          	bgeu	s1,a1,9aa <gettoken+0x42>
     992:	0004c583          	lbu	a1,0(s1)
     996:	854e                	mv	a0,s3
     998:	00001097          	auipc	ra,0x1
     99c:	834080e7          	jalr	-1996(ra) # 11cc <strchr>
     9a0:	c509                	beqz	a0,9aa <gettoken+0x42>
    s++;
     9a2:	0485                	add	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     9a4:	fe9917e3          	bne	s2,s1,992 <gettoken+0x2a>
    s++;
     9a8:	84ca                	mv	s1,s2
  if(q)
     9aa:	000a8463          	beqz	s5,9b2 <gettoken+0x4a>
    *q = s;
     9ae:	009ab023          	sd	s1,0(s5)
  ret = *s;
     9b2:	0004c783          	lbu	a5,0(s1)
     9b6:	00078a9b          	sext.w	s5,a5
  switch(*s){
     9ba:	03c00713          	li	a4,60
     9be:	06f76663          	bltu	a4,a5,a2a <gettoken+0xc2>
     9c2:	03a00713          	li	a4,58
     9c6:	00f76e63          	bltu	a4,a5,9e2 <gettoken+0x7a>
     9ca:	cf89                	beqz	a5,9e4 <gettoken+0x7c>
     9cc:	02600713          	li	a4,38
     9d0:	00e78963          	beq	a5,a4,9e2 <gettoken+0x7a>
     9d4:	fd87879b          	addw	a5,a5,-40
     9d8:	0ff7f793          	zext.b	a5,a5
     9dc:	4705                	li	a4,1
     9de:	06f76d63          	bltu	a4,a5,a58 <gettoken+0xf0>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     9e2:	0485                	add	s1,s1,1
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     9e4:	000b0463          	beqz	s6,9ec <gettoken+0x84>
    *eq = s;
     9e8:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
     9ec:	00001997          	auipc	s3,0x1
     9f0:	61c98993          	add	s3,s3,1564 # 2008 <whitespace>
     9f4:	0124fe63          	bgeu	s1,s2,a10 <gettoken+0xa8>
     9f8:	0004c583          	lbu	a1,0(s1)
     9fc:	854e                	mv	a0,s3
     9fe:	00000097          	auipc	ra,0x0
     a02:	7ce080e7          	jalr	1998(ra) # 11cc <strchr>
     a06:	c509                	beqz	a0,a10 <gettoken+0xa8>
    s++;
     a08:	0485                	add	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     a0a:	fe9917e3          	bne	s2,s1,9f8 <gettoken+0x90>
    s++;
     a0e:	84ca                	mv	s1,s2
  *ps = s;
     a10:	009a3023          	sd	s1,0(s4)
  return ret;
}
     a14:	8556                	mv	a0,s5
     a16:	70e2                	ld	ra,56(sp)
     a18:	7442                	ld	s0,48(sp)
     a1a:	74a2                	ld	s1,40(sp)
     a1c:	7902                	ld	s2,32(sp)
     a1e:	69e2                	ld	s3,24(sp)
     a20:	6a42                	ld	s4,16(sp)
     a22:	6aa2                	ld	s5,8(sp)
     a24:	6b02                	ld	s6,0(sp)
     a26:	6121                	add	sp,sp,64
     a28:	8082                	ret
  switch(*s){
     a2a:	03e00713          	li	a4,62
     a2e:	02e79163          	bne	a5,a4,a50 <gettoken+0xe8>
    s++;
     a32:	00148693          	add	a3,s1,1
    if(*s == '>'){
     a36:	0014c703          	lbu	a4,1(s1)
     a3a:	03e00793          	li	a5,62
      s++;
     a3e:	0489                	add	s1,s1,2
      ret = '+';
     a40:	02b00a93          	li	s5,43
    if(*s == '>'){
     a44:	faf700e3          	beq	a4,a5,9e4 <gettoken+0x7c>
    s++;
     a48:	84b6                	mv	s1,a3
  ret = *s;
     a4a:	03e00a93          	li	s5,62
     a4e:	bf59                	j	9e4 <gettoken+0x7c>
  switch(*s){
     a50:	07c00713          	li	a4,124
     a54:	f8e787e3          	beq	a5,a4,9e2 <gettoken+0x7a>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     a58:	00001997          	auipc	s3,0x1
     a5c:	5b098993          	add	s3,s3,1456 # 2008 <whitespace>
     a60:	00001a97          	auipc	s5,0x1
     a64:	5a0a8a93          	add	s5,s5,1440 # 2000 <symbols>
     a68:	0524f163          	bgeu	s1,s2,aaa <gettoken+0x142>
     a6c:	0004c583          	lbu	a1,0(s1)
     a70:	854e                	mv	a0,s3
     a72:	00000097          	auipc	ra,0x0
     a76:	75a080e7          	jalr	1882(ra) # 11cc <strchr>
     a7a:	e50d                	bnez	a0,aa4 <gettoken+0x13c>
     a7c:	0004c583          	lbu	a1,0(s1)
     a80:	8556                	mv	a0,s5
     a82:	00000097          	auipc	ra,0x0
     a86:	74a080e7          	jalr	1866(ra) # 11cc <strchr>
     a8a:	e911                	bnez	a0,a9e <gettoken+0x136>
      s++;
     a8c:	0485                	add	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     a8e:	fc991fe3          	bne	s2,s1,a6c <gettoken+0x104>
      s++;
     a92:	84ca                	mv	s1,s2
    ret = 'a';
     a94:	06100a93          	li	s5,97
  if(eq)
     a98:	f40b18e3          	bnez	s6,9e8 <gettoken+0x80>
     a9c:	bf95                	j	a10 <gettoken+0xa8>
    ret = 'a';
     a9e:	06100a93          	li	s5,97
     aa2:	b789                	j	9e4 <gettoken+0x7c>
     aa4:	06100a93          	li	s5,97
     aa8:	bf35                	j	9e4 <gettoken+0x7c>
     aaa:	06100a93          	li	s5,97
  if(eq)
     aae:	f20b1de3          	bnez	s6,9e8 <gettoken+0x80>
     ab2:	bfb9                	j	a10 <gettoken+0xa8>

0000000000000ab4 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     ab4:	7139                	add	sp,sp,-64
     ab6:	fc06                	sd	ra,56(sp)
     ab8:	f822                	sd	s0,48(sp)
     aba:	f426                	sd	s1,40(sp)
     abc:	f04a                	sd	s2,32(sp)
     abe:	ec4e                	sd	s3,24(sp)
     ac0:	e852                	sd	s4,16(sp)
     ac2:	e456                	sd	s5,8(sp)
     ac4:	0080                	add	s0,sp,64
     ac6:	8a2a                	mv	s4,a0
     ac8:	892e                	mv	s2,a1
     aca:	8ab2                	mv	s5,a2
  char *s;

  s = *ps;
     acc:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     ace:	00001997          	auipc	s3,0x1
     ad2:	53a98993          	add	s3,s3,1338 # 2008 <whitespace>
     ad6:	00b4fe63          	bgeu	s1,a1,af2 <peek+0x3e>
     ada:	0004c583          	lbu	a1,0(s1)
     ade:	854e                	mv	a0,s3
     ae0:	00000097          	auipc	ra,0x0
     ae4:	6ec080e7          	jalr	1772(ra) # 11cc <strchr>
     ae8:	c509                	beqz	a0,af2 <peek+0x3e>
    s++;
     aea:	0485                	add	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     aec:	fe9917e3          	bne	s2,s1,ada <peek+0x26>
    s++;
     af0:	84ca                	mv	s1,s2
  *ps = s;
     af2:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
     af6:	0004c583          	lbu	a1,0(s1)
     afa:	4501                	li	a0,0
     afc:	e991                	bnez	a1,b10 <peek+0x5c>
}
     afe:	70e2                	ld	ra,56(sp)
     b00:	7442                	ld	s0,48(sp)
     b02:	74a2                	ld	s1,40(sp)
     b04:	7902                	ld	s2,32(sp)
     b06:	69e2                	ld	s3,24(sp)
     b08:	6a42                	ld	s4,16(sp)
     b0a:	6aa2                	ld	s5,8(sp)
     b0c:	6121                	add	sp,sp,64
     b0e:	8082                	ret
  return *s && strchr(toks, *s);
     b10:	8556                	mv	a0,s5
     b12:	00000097          	auipc	ra,0x0
     b16:	6ba080e7          	jalr	1722(ra) # 11cc <strchr>
     b1a:	00a03533          	snez	a0,a0
     b1e:	b7c5                	j	afe <peek+0x4a>

0000000000000b20 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     b20:	7159                	add	sp,sp,-112
     b22:	f486                	sd	ra,104(sp)
     b24:	f0a2                	sd	s0,96(sp)
     b26:	eca6                	sd	s1,88(sp)
     b28:	e8ca                	sd	s2,80(sp)
     b2a:	e4ce                	sd	s3,72(sp)
     b2c:	e0d2                	sd	s4,64(sp)
     b2e:	fc56                	sd	s5,56(sp)
     b30:	f85a                	sd	s6,48(sp)
     b32:	f45e                	sd	s7,40(sp)
     b34:	f062                	sd	s8,32(sp)
     b36:	ec66                	sd	s9,24(sp)
     b38:	1880                	add	s0,sp,112
     b3a:	8a2a                	mv	s4,a0
     b3c:	89ae                	mv	s3,a1
     b3e:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     b40:	00001b97          	auipc	s7,0x1
     b44:	e78b8b93          	add	s7,s7,-392 # 19b8 <malloc+0x17a>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     b48:	06100c13          	li	s8,97
      panic("missing file for redirection");
    switch(tok){
     b4c:	03c00c93          	li	s9,60
  while(peek(ps, es, "<>")){
     b50:	a02d                	j	b7a <parseredirs+0x5a>
      panic("missing file for redirection");
     b52:	00001517          	auipc	a0,0x1
     b56:	e4650513          	add	a0,a0,-442 # 1998 <malloc+0x15a>
     b5a:	00000097          	auipc	ra,0x0
     b5e:	a86080e7          	jalr	-1402(ra) # 5e0 <panic>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     b62:	4701                	li	a4,0
     b64:	4681                	li	a3,0
     b66:	f9043603          	ld	a2,-112(s0)
     b6a:	f9843583          	ld	a1,-104(s0)
     b6e:	8552                	mv	a0,s4
     b70:	00000097          	auipc	ra,0x0
     b74:	cc8080e7          	jalr	-824(ra) # 838 <redircmd>
     b78:	8a2a                	mv	s4,a0
    switch(tok){
     b7a:	03e00b13          	li	s6,62
     b7e:	02b00a93          	li	s5,43
  while(peek(ps, es, "<>")){
     b82:	865e                	mv	a2,s7
     b84:	85ca                	mv	a1,s2
     b86:	854e                	mv	a0,s3
     b88:	00000097          	auipc	ra,0x0
     b8c:	f2c080e7          	jalr	-212(ra) # ab4 <peek>
     b90:	c925                	beqz	a0,c00 <parseredirs+0xe0>
    tok = gettoken(ps, es, 0, 0);
     b92:	4681                	li	a3,0
     b94:	4601                	li	a2,0
     b96:	85ca                	mv	a1,s2
     b98:	854e                	mv	a0,s3
     b9a:	00000097          	auipc	ra,0x0
     b9e:	dce080e7          	jalr	-562(ra) # 968 <gettoken>
     ba2:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
     ba4:	f9040693          	add	a3,s0,-112
     ba8:	f9840613          	add	a2,s0,-104
     bac:	85ca                	mv	a1,s2
     bae:	854e                	mv	a0,s3
     bb0:	00000097          	auipc	ra,0x0
     bb4:	db8080e7          	jalr	-584(ra) # 968 <gettoken>
     bb8:	f9851de3          	bne	a0,s8,b52 <parseredirs+0x32>
    switch(tok){
     bbc:	fb9483e3          	beq	s1,s9,b62 <parseredirs+0x42>
     bc0:	03648263          	beq	s1,s6,be4 <parseredirs+0xc4>
     bc4:	fb549fe3          	bne	s1,s5,b82 <parseredirs+0x62>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     bc8:	4705                	li	a4,1
     bca:	20100693          	li	a3,513
     bce:	f9043603          	ld	a2,-112(s0)
     bd2:	f9843583          	ld	a1,-104(s0)
     bd6:	8552                	mv	a0,s4
     bd8:	00000097          	auipc	ra,0x0
     bdc:	c60080e7          	jalr	-928(ra) # 838 <redircmd>
     be0:	8a2a                	mv	s4,a0
      break;
     be2:	bf61                	j	b7a <parseredirs+0x5a>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     be4:	4705                	li	a4,1
     be6:	60100693          	li	a3,1537
     bea:	f9043603          	ld	a2,-112(s0)
     bee:	f9843583          	ld	a1,-104(s0)
     bf2:	8552                	mv	a0,s4
     bf4:	00000097          	auipc	ra,0x0
     bf8:	c44080e7          	jalr	-956(ra) # 838 <redircmd>
     bfc:	8a2a                	mv	s4,a0
      break;
     bfe:	bfb5                	j	b7a <parseredirs+0x5a>
    }
  }
  return cmd;
}
     c00:	8552                	mv	a0,s4
     c02:	70a6                	ld	ra,104(sp)
     c04:	7406                	ld	s0,96(sp)
     c06:	64e6                	ld	s1,88(sp)
     c08:	6946                	ld	s2,80(sp)
     c0a:	69a6                	ld	s3,72(sp)
     c0c:	6a06                	ld	s4,64(sp)
     c0e:	7ae2                	ld	s5,56(sp)
     c10:	7b42                	ld	s6,48(sp)
     c12:	7ba2                	ld	s7,40(sp)
     c14:	7c02                	ld	s8,32(sp)
     c16:	6ce2                	ld	s9,24(sp)
     c18:	6165                	add	sp,sp,112
     c1a:	8082                	ret

0000000000000c1c <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     c1c:	7159                	add	sp,sp,-112
     c1e:	f486                	sd	ra,104(sp)
     c20:	f0a2                	sd	s0,96(sp)
     c22:	eca6                	sd	s1,88(sp)
     c24:	e8ca                	sd	s2,80(sp)
     c26:	e4ce                	sd	s3,72(sp)
     c28:	e0d2                	sd	s4,64(sp)
     c2a:	fc56                	sd	s5,56(sp)
     c2c:	f85a                	sd	s6,48(sp)
     c2e:	f45e                	sd	s7,40(sp)
     c30:	f062                	sd	s8,32(sp)
     c32:	ec66                	sd	s9,24(sp)
     c34:	1880                	add	s0,sp,112
     c36:	8a2a                	mv	s4,a0
     c38:	8aae                	mv	s5,a1
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     c3a:	00001617          	auipc	a2,0x1
     c3e:	d8660613          	add	a2,a2,-634 # 19c0 <malloc+0x182>
     c42:	00000097          	auipc	ra,0x0
     c46:	e72080e7          	jalr	-398(ra) # ab4 <peek>
     c4a:	e905                	bnez	a0,c7a <parseexec+0x5e>
     c4c:	89aa                	mv	s3,a0
    return parseblock(ps, es);

  ret = execcmd();
     c4e:	00000097          	auipc	ra,0x0
     c52:	bb4080e7          	jalr	-1100(ra) # 802 <execcmd>
     c56:	8c2a                	mv	s8,a0
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     c58:	8656                	mv	a2,s5
     c5a:	85d2                	mv	a1,s4
     c5c:	00000097          	auipc	ra,0x0
     c60:	ec4080e7          	jalr	-316(ra) # b20 <parseredirs>
     c64:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     c66:	008c0913          	add	s2,s8,8
     c6a:	00001b17          	auipc	s6,0x1
     c6e:	d76b0b13          	add	s6,s6,-650 # 19e0 <malloc+0x1a2>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
     c72:	06100c93          	li	s9,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
     c76:	4ba9                	li	s7,10
  while(!peek(ps, es, "|)&;")){
     c78:	a0b1                	j	cc4 <parseexec+0xa8>
    return parseblock(ps, es);
     c7a:	85d6                	mv	a1,s5
     c7c:	8552                	mv	a0,s4
     c7e:	00000097          	auipc	ra,0x0
     c82:	1bc080e7          	jalr	444(ra) # e3a <parseblock>
     c86:	84aa                	mv	s1,a0
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     c88:	8526                	mv	a0,s1
     c8a:	70a6                	ld	ra,104(sp)
     c8c:	7406                	ld	s0,96(sp)
     c8e:	64e6                	ld	s1,88(sp)
     c90:	6946                	ld	s2,80(sp)
     c92:	69a6                	ld	s3,72(sp)
     c94:	6a06                	ld	s4,64(sp)
     c96:	7ae2                	ld	s5,56(sp)
     c98:	7b42                	ld	s6,48(sp)
     c9a:	7ba2                	ld	s7,40(sp)
     c9c:	7c02                	ld	s8,32(sp)
     c9e:	6ce2                	ld	s9,24(sp)
     ca0:	6165                	add	sp,sp,112
     ca2:	8082                	ret
      panic("syntax");
     ca4:	00001517          	auipc	a0,0x1
     ca8:	d2450513          	add	a0,a0,-732 # 19c8 <malloc+0x18a>
     cac:	00000097          	auipc	ra,0x0
     cb0:	934080e7          	jalr	-1740(ra) # 5e0 <panic>
    ret = parseredirs(ret, ps, es);
     cb4:	8656                	mv	a2,s5
     cb6:	85d2                	mv	a1,s4
     cb8:	8526                	mv	a0,s1
     cba:	00000097          	auipc	ra,0x0
     cbe:	e66080e7          	jalr	-410(ra) # b20 <parseredirs>
     cc2:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     cc4:	865a                	mv	a2,s6
     cc6:	85d6                	mv	a1,s5
     cc8:	8552                	mv	a0,s4
     cca:	00000097          	auipc	ra,0x0
     cce:	dea080e7          	jalr	-534(ra) # ab4 <peek>
     cd2:	e131                	bnez	a0,d16 <parseexec+0xfa>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     cd4:	f9040693          	add	a3,s0,-112
     cd8:	f9840613          	add	a2,s0,-104
     cdc:	85d6                	mv	a1,s5
     cde:	8552                	mv	a0,s4
     ce0:	00000097          	auipc	ra,0x0
     ce4:	c88080e7          	jalr	-888(ra) # 968 <gettoken>
     ce8:	c51d                	beqz	a0,d16 <parseexec+0xfa>
    if(tok != 'a')
     cea:	fb951de3          	bne	a0,s9,ca4 <parseexec+0x88>
    cmd->argv[argc] = q;
     cee:	f9843783          	ld	a5,-104(s0)
     cf2:	00f93023          	sd	a5,0(s2)
    cmd->eargv[argc] = eq;
     cf6:	f9043783          	ld	a5,-112(s0)
     cfa:	04f93823          	sd	a5,80(s2)
    argc++;
     cfe:	2985                	addw	s3,s3,1
    if(argc >= MAXARGS)
     d00:	0921                	add	s2,s2,8
     d02:	fb7999e3          	bne	s3,s7,cb4 <parseexec+0x98>
      panic("too many args");
     d06:	00001517          	auipc	a0,0x1
     d0a:	cca50513          	add	a0,a0,-822 # 19d0 <malloc+0x192>
     d0e:	00000097          	auipc	ra,0x0
     d12:	8d2080e7          	jalr	-1838(ra) # 5e0 <panic>
  cmd->argv[argc] = 0;
     d16:	098e                	sll	s3,s3,0x3
     d18:	9c4e                	add	s8,s8,s3
     d1a:	000c3423          	sd	zero,8(s8)
  cmd->eargv[argc] = 0;
     d1e:	040c3c23          	sd	zero,88(s8)
  return ret;
     d22:	b79d                	j	c88 <parseexec+0x6c>

0000000000000d24 <parsepipe>:
{
     d24:	7179                	add	sp,sp,-48
     d26:	f406                	sd	ra,40(sp)
     d28:	f022                	sd	s0,32(sp)
     d2a:	ec26                	sd	s1,24(sp)
     d2c:	e84a                	sd	s2,16(sp)
     d2e:	e44e                	sd	s3,8(sp)
     d30:	1800                	add	s0,sp,48
     d32:	892a                	mv	s2,a0
     d34:	89ae                	mv	s3,a1
  cmd = parseexec(ps, es);
     d36:	00000097          	auipc	ra,0x0
     d3a:	ee6080e7          	jalr	-282(ra) # c1c <parseexec>
     d3e:	84aa                	mv	s1,a0
  if(peek(ps, es, "|")){
     d40:	00001617          	auipc	a2,0x1
     d44:	ca860613          	add	a2,a2,-856 # 19e8 <malloc+0x1aa>
     d48:	85ce                	mv	a1,s3
     d4a:	854a                	mv	a0,s2
     d4c:	00000097          	auipc	ra,0x0
     d50:	d68080e7          	jalr	-664(ra) # ab4 <peek>
     d54:	e909                	bnez	a0,d66 <parsepipe+0x42>
}
     d56:	8526                	mv	a0,s1
     d58:	70a2                	ld	ra,40(sp)
     d5a:	7402                	ld	s0,32(sp)
     d5c:	64e2                	ld	s1,24(sp)
     d5e:	6942                	ld	s2,16(sp)
     d60:	69a2                	ld	s3,8(sp)
     d62:	6145                	add	sp,sp,48
     d64:	8082                	ret
    gettoken(ps, es, 0, 0);
     d66:	4681                	li	a3,0
     d68:	4601                	li	a2,0
     d6a:	85ce                	mv	a1,s3
     d6c:	854a                	mv	a0,s2
     d6e:	00000097          	auipc	ra,0x0
     d72:	bfa080e7          	jalr	-1030(ra) # 968 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     d76:	85ce                	mv	a1,s3
     d78:	854a                	mv	a0,s2
     d7a:	00000097          	auipc	ra,0x0
     d7e:	faa080e7          	jalr	-86(ra) # d24 <parsepipe>
     d82:	85aa                	mv	a1,a0
     d84:	8526                	mv	a0,s1
     d86:	00000097          	auipc	ra,0x0
     d8a:	b1a080e7          	jalr	-1254(ra) # 8a0 <pipecmd>
     d8e:	84aa                	mv	s1,a0
  return cmd;
     d90:	b7d9                	j	d56 <parsepipe+0x32>

0000000000000d92 <parseline>:
{
     d92:	7179                	add	sp,sp,-48
     d94:	f406                	sd	ra,40(sp)
     d96:	f022                	sd	s0,32(sp)
     d98:	ec26                	sd	s1,24(sp)
     d9a:	e84a                	sd	s2,16(sp)
     d9c:	e44e                	sd	s3,8(sp)
     d9e:	e052                	sd	s4,0(sp)
     da0:	1800                	add	s0,sp,48
     da2:	892a                	mv	s2,a0
     da4:	89ae                	mv	s3,a1
  cmd = parsepipe(ps, es);
     da6:	00000097          	auipc	ra,0x0
     daa:	f7e080e7          	jalr	-130(ra) # d24 <parsepipe>
     dae:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     db0:	00001a17          	auipc	s4,0x1
     db4:	c40a0a13          	add	s4,s4,-960 # 19f0 <malloc+0x1b2>
     db8:	a839                	j	dd6 <parseline+0x44>
    gettoken(ps, es, 0, 0);
     dba:	4681                	li	a3,0
     dbc:	4601                	li	a2,0
     dbe:	85ce                	mv	a1,s3
     dc0:	854a                	mv	a0,s2
     dc2:	00000097          	auipc	ra,0x0
     dc6:	ba6080e7          	jalr	-1114(ra) # 968 <gettoken>
    cmd = backcmd(cmd);
     dca:	8526                	mv	a0,s1
     dcc:	00000097          	auipc	ra,0x0
     dd0:	b60080e7          	jalr	-1184(ra) # 92c <backcmd>
     dd4:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     dd6:	8652                	mv	a2,s4
     dd8:	85ce                	mv	a1,s3
     dda:	854a                	mv	a0,s2
     ddc:	00000097          	auipc	ra,0x0
     de0:	cd8080e7          	jalr	-808(ra) # ab4 <peek>
     de4:	f979                	bnez	a0,dba <parseline+0x28>
  if(peek(ps, es, ";")){
     de6:	00001617          	auipc	a2,0x1
     dea:	c1260613          	add	a2,a2,-1006 # 19f8 <malloc+0x1ba>
     dee:	85ce                	mv	a1,s3
     df0:	854a                	mv	a0,s2
     df2:	00000097          	auipc	ra,0x0
     df6:	cc2080e7          	jalr	-830(ra) # ab4 <peek>
     dfa:	e911                	bnez	a0,e0e <parseline+0x7c>
}
     dfc:	8526                	mv	a0,s1
     dfe:	70a2                	ld	ra,40(sp)
     e00:	7402                	ld	s0,32(sp)
     e02:	64e2                	ld	s1,24(sp)
     e04:	6942                	ld	s2,16(sp)
     e06:	69a2                	ld	s3,8(sp)
     e08:	6a02                	ld	s4,0(sp)
     e0a:	6145                	add	sp,sp,48
     e0c:	8082                	ret
    gettoken(ps, es, 0, 0);
     e0e:	4681                	li	a3,0
     e10:	4601                	li	a2,0
     e12:	85ce                	mv	a1,s3
     e14:	854a                	mv	a0,s2
     e16:	00000097          	auipc	ra,0x0
     e1a:	b52080e7          	jalr	-1198(ra) # 968 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     e1e:	85ce                	mv	a1,s3
     e20:	854a                	mv	a0,s2
     e22:	00000097          	auipc	ra,0x0
     e26:	f70080e7          	jalr	-144(ra) # d92 <parseline>
     e2a:	85aa                	mv	a1,a0
     e2c:	8526                	mv	a0,s1
     e2e:	00000097          	auipc	ra,0x0
     e32:	ab8080e7          	jalr	-1352(ra) # 8e6 <listcmd>
     e36:	84aa                	mv	s1,a0
  return cmd;
     e38:	b7d1                	j	dfc <parseline+0x6a>

0000000000000e3a <parseblock>:
{
     e3a:	7179                	add	sp,sp,-48
     e3c:	f406                	sd	ra,40(sp)
     e3e:	f022                	sd	s0,32(sp)
     e40:	ec26                	sd	s1,24(sp)
     e42:	e84a                	sd	s2,16(sp)
     e44:	e44e                	sd	s3,8(sp)
     e46:	1800                	add	s0,sp,48
     e48:	84aa                	mv	s1,a0
     e4a:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
     e4c:	00001617          	auipc	a2,0x1
     e50:	b7460613          	add	a2,a2,-1164 # 19c0 <malloc+0x182>
     e54:	00000097          	auipc	ra,0x0
     e58:	c60080e7          	jalr	-928(ra) # ab4 <peek>
     e5c:	c12d                	beqz	a0,ebe <parseblock+0x84>
  gettoken(ps, es, 0, 0);
     e5e:	4681                	li	a3,0
     e60:	4601                	li	a2,0
     e62:	85ca                	mv	a1,s2
     e64:	8526                	mv	a0,s1
     e66:	00000097          	auipc	ra,0x0
     e6a:	b02080e7          	jalr	-1278(ra) # 968 <gettoken>
  cmd = parseline(ps, es);
     e6e:	85ca                	mv	a1,s2
     e70:	8526                	mv	a0,s1
     e72:	00000097          	auipc	ra,0x0
     e76:	f20080e7          	jalr	-224(ra) # d92 <parseline>
     e7a:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
     e7c:	00001617          	auipc	a2,0x1
     e80:	b9460613          	add	a2,a2,-1132 # 1a10 <malloc+0x1d2>
     e84:	85ca                	mv	a1,s2
     e86:	8526                	mv	a0,s1
     e88:	00000097          	auipc	ra,0x0
     e8c:	c2c080e7          	jalr	-980(ra) # ab4 <peek>
     e90:	cd1d                	beqz	a0,ece <parseblock+0x94>
  gettoken(ps, es, 0, 0);
     e92:	4681                	li	a3,0
     e94:	4601                	li	a2,0
     e96:	85ca                	mv	a1,s2
     e98:	8526                	mv	a0,s1
     e9a:	00000097          	auipc	ra,0x0
     e9e:	ace080e7          	jalr	-1330(ra) # 968 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     ea2:	864a                	mv	a2,s2
     ea4:	85a6                	mv	a1,s1
     ea6:	854e                	mv	a0,s3
     ea8:	00000097          	auipc	ra,0x0
     eac:	c78080e7          	jalr	-904(ra) # b20 <parseredirs>
}
     eb0:	70a2                	ld	ra,40(sp)
     eb2:	7402                	ld	s0,32(sp)
     eb4:	64e2                	ld	s1,24(sp)
     eb6:	6942                	ld	s2,16(sp)
     eb8:	69a2                	ld	s3,8(sp)
     eba:	6145                	add	sp,sp,48
     ebc:	8082                	ret
    panic("parseblock");
     ebe:	00001517          	auipc	a0,0x1
     ec2:	b4250513          	add	a0,a0,-1214 # 1a00 <malloc+0x1c2>
     ec6:	fffff097          	auipc	ra,0xfffff
     eca:	71a080e7          	jalr	1818(ra) # 5e0 <panic>
    panic("syntax - missing )");
     ece:	00001517          	auipc	a0,0x1
     ed2:	b4a50513          	add	a0,a0,-1206 # 1a18 <malloc+0x1da>
     ed6:	fffff097          	auipc	ra,0xfffff
     eda:	70a080e7          	jalr	1802(ra) # 5e0 <panic>

0000000000000ede <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     ede:	1101                	add	sp,sp,-32
     ee0:	ec06                	sd	ra,24(sp)
     ee2:	e822                	sd	s0,16(sp)
     ee4:	e426                	sd	s1,8(sp)
     ee6:	1000                	add	s0,sp,32
     ee8:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     eea:	c521                	beqz	a0,f32 <nulterminate+0x54>
    return 0;

  switch(cmd->type){
     eec:	4118                	lw	a4,0(a0)
     eee:	4795                	li	a5,5
     ef0:	04e7e163          	bltu	a5,a4,f32 <nulterminate+0x54>
     ef4:	00056783          	lwu	a5,0(a0)
     ef8:	078a                	sll	a5,a5,0x2
     efa:	00001717          	auipc	a4,0x1
     efe:	b7e70713          	add	a4,a4,-1154 # 1a78 <malloc+0x23a>
     f02:	97ba                	add	a5,a5,a4
     f04:	439c                	lw	a5,0(a5)
     f06:	97ba                	add	a5,a5,a4
     f08:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     f0a:	651c                	ld	a5,8(a0)
     f0c:	c39d                	beqz	a5,f32 <nulterminate+0x54>
     f0e:	01050793          	add	a5,a0,16
      *ecmd->eargv[i] = 0;
     f12:	67b8                	ld	a4,72(a5)
     f14:	00070023          	sb	zero,0(a4)
    for(i=0; ecmd->argv[i]; i++)
     f18:	07a1                	add	a5,a5,8
     f1a:	ff87b703          	ld	a4,-8(a5)
     f1e:	fb75                	bnez	a4,f12 <nulterminate+0x34>
     f20:	a809                	j	f32 <nulterminate+0x54>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     f22:	6508                	ld	a0,8(a0)
     f24:	00000097          	auipc	ra,0x0
     f28:	fba080e7          	jalr	-70(ra) # ede <nulterminate>
    *rcmd->efile = 0;
     f2c:	6c9c                	ld	a5,24(s1)
     f2e:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     f32:	8526                	mv	a0,s1
     f34:	60e2                	ld	ra,24(sp)
     f36:	6442                	ld	s0,16(sp)
     f38:	64a2                	ld	s1,8(sp)
     f3a:	6105                	add	sp,sp,32
     f3c:	8082                	ret
    nulterminate(pcmd->left);
     f3e:	6508                	ld	a0,8(a0)
     f40:	00000097          	auipc	ra,0x0
     f44:	f9e080e7          	jalr	-98(ra) # ede <nulterminate>
    nulterminate(pcmd->right);
     f48:	6888                	ld	a0,16(s1)
     f4a:	00000097          	auipc	ra,0x0
     f4e:	f94080e7          	jalr	-108(ra) # ede <nulterminate>
    break;
     f52:	b7c5                	j	f32 <nulterminate+0x54>
    nulterminate(lcmd->left);
     f54:	6508                	ld	a0,8(a0)
     f56:	00000097          	auipc	ra,0x0
     f5a:	f88080e7          	jalr	-120(ra) # ede <nulterminate>
    nulterminate(lcmd->right);
     f5e:	6888                	ld	a0,16(s1)
     f60:	00000097          	auipc	ra,0x0
     f64:	f7e080e7          	jalr	-130(ra) # ede <nulterminate>
    break;
     f68:	b7e9                	j	f32 <nulterminate+0x54>
    nulterminate(bcmd->cmd);
     f6a:	6508                	ld	a0,8(a0)
     f6c:	00000097          	auipc	ra,0x0
     f70:	f72080e7          	jalr	-142(ra) # ede <nulterminate>
    break;
     f74:	bf7d                	j	f32 <nulterminate+0x54>

0000000000000f76 <parsecmd>:
{
     f76:	7179                	add	sp,sp,-48
     f78:	f406                	sd	ra,40(sp)
     f7a:	f022                	sd	s0,32(sp)
     f7c:	ec26                	sd	s1,24(sp)
     f7e:	e84a                	sd	s2,16(sp)
     f80:	1800                	add	s0,sp,48
     f82:	fca43c23          	sd	a0,-40(s0)
  es = s + strlen(s);
     f86:	84aa                	mv	s1,a0
     f88:	00000097          	auipc	ra,0x0
     f8c:	1f8080e7          	jalr	504(ra) # 1180 <strlen>
     f90:	1502                	sll	a0,a0,0x20
     f92:	9101                	srl	a0,a0,0x20
     f94:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
     f96:	85a6                	mv	a1,s1
     f98:	fd840513          	add	a0,s0,-40
     f9c:	00000097          	auipc	ra,0x0
     fa0:	df6080e7          	jalr	-522(ra) # d92 <parseline>
     fa4:	892a                	mv	s2,a0
  peek(&s, es, "");
     fa6:	00001617          	auipc	a2,0x1
     faa:	a8a60613          	add	a2,a2,-1398 # 1a30 <malloc+0x1f2>
     fae:	85a6                	mv	a1,s1
     fb0:	fd840513          	add	a0,s0,-40
     fb4:	00000097          	auipc	ra,0x0
     fb8:	b00080e7          	jalr	-1280(ra) # ab4 <peek>
  if(s != es){
     fbc:	fd843603          	ld	a2,-40(s0)
     fc0:	00961e63          	bne	a2,s1,fdc <parsecmd+0x66>
  nulterminate(cmd);
     fc4:	854a                	mv	a0,s2
     fc6:	00000097          	auipc	ra,0x0
     fca:	f18080e7          	jalr	-232(ra) # ede <nulterminate>
}
     fce:	854a                	mv	a0,s2
     fd0:	70a2                	ld	ra,40(sp)
     fd2:	7402                	ld	s0,32(sp)
     fd4:	64e2                	ld	s1,24(sp)
     fd6:	6942                	ld	s2,16(sp)
     fd8:	6145                	add	sp,sp,48
     fda:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
     fdc:	00001597          	auipc	a1,0x1
     fe0:	a5c58593          	add	a1,a1,-1444 # 1a38 <malloc+0x1fa>
     fe4:	4509                	li	a0,2
     fe6:	00000097          	auipc	ra,0x0
     fea:	772080e7          	jalr	1906(ra) # 1758 <fprintf>
    panic("syntax");
     fee:	00001517          	auipc	a0,0x1
     ff2:	9da50513          	add	a0,a0,-1574 # 19c8 <malloc+0x18a>
     ff6:	fffff097          	auipc	ra,0xfffff
     ffa:	5ea080e7          	jalr	1514(ra) # 5e0 <panic>

0000000000000ffe <main>:
{
     ffe:	715d                	add	sp,sp,-80
    1000:	e486                	sd	ra,72(sp)
    1002:	e0a2                	sd	s0,64(sp)
    1004:	fc26                	sd	s1,56(sp)
    1006:	f84a                	sd	s2,48(sp)
    1008:	f44e                	sd	s3,40(sp)
    100a:	f052                	sd	s4,32(sp)
    100c:	0880                	add	s0,sp,80
  struct strlist cmds = { .length = 0, .strings = 0 };
    100e:	fc042023          	sw	zero,-64(s0)
    1012:	fc043423          	sd	zero,-56(s0)
  struct strlist history = { .length = 0, .strings = 0 };
    1016:	fa042823          	sw	zero,-80(s0)
    101a:	fa043c23          	sd	zero,-72(s0)
  while((fd = open("console", O_RDWR)) >= 0){
    101e:	00001497          	auipc	s1,0x1
    1022:	a2a48493          	add	s1,s1,-1494 # 1a48 <malloc+0x20a>
    1026:	4589                	li	a1,2
    1028:	8526                	mv	a0,s1
    102a:	00000097          	auipc	ra,0x0
    102e:	414080e7          	jalr	1044(ra) # 143e <open>
    1032:	00054963          	bltz	a0,1044 <main+0x46>
    if(fd >= 3){
    1036:	4789                	li	a5,2
    1038:	fea7d7e3          	bge	a5,a0,1026 <main+0x28>
      close(fd);
    103c:	00000097          	auipc	ra,0x0
    1040:	3ea080e7          	jalr	1002(ra) # 1426 <close>
  findcmds(&cmds);
    1044:	fc040513          	add	a0,s0,-64
    1048:	fffff097          	auipc	ra,0xfffff
    104c:	06c080e7          	jalr	108(ra) # b4 <findcmds>
  while(getcmd(&cmds, &history, buf, sizeof(buf)) >= 0){
    1050:	00001497          	auipc	s1,0x1
    1054:	fd048493          	add	s1,s1,-48 # 2020 <buf.0>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
    1058:	06300913          	li	s2,99
    105c:	02000993          	li	s3,32
  while(getcmd(&cmds, &history, buf, sizeof(buf)) >= 0){
    1060:	a819                	j	1076 <main+0x78>
    if(fork1() == 0)
    1062:	fffff097          	auipc	ra,0xfffff
    1066:	5a4080e7          	jalr	1444(ra) # 606 <fork1>
    106a:	c949                	beqz	a0,10fc <main+0xfe>
    wait(0);
    106c:	4501                	li	a0,0
    106e:	00000097          	auipc	ra,0x0
    1072:	398080e7          	jalr	920(ra) # 1406 <wait>
  while(getcmd(&cmds, &history, buf, sizeof(buf)) >= 0){
    1076:	06400693          	li	a3,100
    107a:	8626                	mv	a2,s1
    107c:	fb040593          	add	a1,s0,-80
    1080:	fc040513          	add	a0,s0,-64
    1084:	fffff097          	auipc	ra,0xfffff
    1088:	3b6080e7          	jalr	950(ra) # 43a <getcmd>
    108c:	08054463          	bltz	a0,1114 <main+0x116>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
    1090:	0004c783          	lbu	a5,0(s1)
    1094:	fd2797e3          	bne	a5,s2,1062 <main+0x64>
    1098:	0014c703          	lbu	a4,1(s1)
    109c:	06400793          	li	a5,100
    10a0:	fcf711e3          	bne	a4,a5,1062 <main+0x64>
    10a4:	0024c783          	lbu	a5,2(s1)
    10a8:	fb379de3          	bne	a5,s3,1062 <main+0x64>
      buf[strlen(buf)-1] = 0;  // chop \n
    10ac:	00001a17          	auipc	s4,0x1
    10b0:	f74a0a13          	add	s4,s4,-140 # 2020 <buf.0>
    10b4:	8552                	mv	a0,s4
    10b6:	00000097          	auipc	ra,0x0
    10ba:	0ca080e7          	jalr	202(ra) # 1180 <strlen>
    10be:	fff5079b          	addw	a5,a0,-1
    10c2:	1782                	sll	a5,a5,0x20
    10c4:	9381                	srl	a5,a5,0x20
    10c6:	9a3e                	add	s4,s4,a5
    10c8:	000a0023          	sb	zero,0(s4)
      if(chdir(buf+3) < 0)
    10cc:	00001517          	auipc	a0,0x1
    10d0:	f5750513          	add	a0,a0,-169 # 2023 <buf.0+0x3>
    10d4:	00000097          	auipc	ra,0x0
    10d8:	39a080e7          	jalr	922(ra) # 146e <chdir>
    10dc:	f8055de3          	bgez	a0,1076 <main+0x78>
        fprintf(2, "cannot cd %s\n", buf+3);
    10e0:	00001617          	auipc	a2,0x1
    10e4:	f4360613          	add	a2,a2,-189 # 2023 <buf.0+0x3>
    10e8:	00001597          	auipc	a1,0x1
    10ec:	96858593          	add	a1,a1,-1688 # 1a50 <malloc+0x212>
    10f0:	4509                	li	a0,2
    10f2:	00000097          	auipc	ra,0x0
    10f6:	666080e7          	jalr	1638(ra) # 1758 <fprintf>
    10fa:	bfb5                	j	1076 <main+0x78>
      runcmd(parsecmd(buf));
    10fc:	00001517          	auipc	a0,0x1
    1100:	f2450513          	add	a0,a0,-220 # 2020 <buf.0>
    1104:	00000097          	auipc	ra,0x0
    1108:	e72080e7          	jalr	-398(ra) # f76 <parsecmd>
    110c:	fffff097          	auipc	ra,0xfffff
    1110:	528080e7          	jalr	1320(ra) # 634 <runcmd>
  exit(0);
    1114:	4501                	li	a0,0
    1116:	00000097          	auipc	ra,0x0
    111a:	2e8080e7          	jalr	744(ra) # 13fe <exit>

000000000000111e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    111e:	1141                	add	sp,sp,-16
    1120:	e406                	sd	ra,8(sp)
    1122:	e022                	sd	s0,0(sp)
    1124:	0800                	add	s0,sp,16
  extern int main();
  main();
    1126:	00000097          	auipc	ra,0x0
    112a:	ed8080e7          	jalr	-296(ra) # ffe <main>
  exit(0);
    112e:	4501                	li	a0,0
    1130:	00000097          	auipc	ra,0x0
    1134:	2ce080e7          	jalr	718(ra) # 13fe <exit>

0000000000001138 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    1138:	1141                	add	sp,sp,-16
    113a:	e422                	sd	s0,8(sp)
    113c:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    113e:	87aa                	mv	a5,a0
    1140:	0585                	add	a1,a1,1
    1142:	0785                	add	a5,a5,1
    1144:	fff5c703          	lbu	a4,-1(a1)
    1148:	fee78fa3          	sb	a4,-1(a5)
    114c:	fb75                	bnez	a4,1140 <strcpy+0x8>
    ;
  return os;
}
    114e:	6422                	ld	s0,8(sp)
    1150:	0141                	add	sp,sp,16
    1152:	8082                	ret

0000000000001154 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1154:	1141                	add	sp,sp,-16
    1156:	e422                	sd	s0,8(sp)
    1158:	0800                	add	s0,sp,16
  while(*p && *p == *q)
    115a:	00054783          	lbu	a5,0(a0)
    115e:	cb91                	beqz	a5,1172 <strcmp+0x1e>
    1160:	0005c703          	lbu	a4,0(a1)
    1164:	00f71763          	bne	a4,a5,1172 <strcmp+0x1e>
    p++, q++;
    1168:	0505                	add	a0,a0,1
    116a:	0585                	add	a1,a1,1
  while(*p && *p == *q)
    116c:	00054783          	lbu	a5,0(a0)
    1170:	fbe5                	bnez	a5,1160 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    1172:	0005c503          	lbu	a0,0(a1)
}
    1176:	40a7853b          	subw	a0,a5,a0
    117a:	6422                	ld	s0,8(sp)
    117c:	0141                	add	sp,sp,16
    117e:	8082                	ret

0000000000001180 <strlen>:

uint
strlen(const char *s)
{
    1180:	1141                	add	sp,sp,-16
    1182:	e422                	sd	s0,8(sp)
    1184:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    1186:	00054783          	lbu	a5,0(a0)
    118a:	cf91                	beqz	a5,11a6 <strlen+0x26>
    118c:	0505                	add	a0,a0,1
    118e:	87aa                	mv	a5,a0
    1190:	86be                	mv	a3,a5
    1192:	0785                	add	a5,a5,1
    1194:	fff7c703          	lbu	a4,-1(a5)
    1198:	ff65                	bnez	a4,1190 <strlen+0x10>
    119a:	40a6853b          	subw	a0,a3,a0
    119e:	2505                	addw	a0,a0,1
    ;
  return n;
}
    11a0:	6422                	ld	s0,8(sp)
    11a2:	0141                	add	sp,sp,16
    11a4:	8082                	ret
  for(n = 0; s[n]; n++)
    11a6:	4501                	li	a0,0
    11a8:	bfe5                	j	11a0 <strlen+0x20>

00000000000011aa <memset>:

void*
memset(void *dst, int c, uint n)
{
    11aa:	1141                	add	sp,sp,-16
    11ac:	e422                	sd	s0,8(sp)
    11ae:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    11b0:	ca19                	beqz	a2,11c6 <memset+0x1c>
    11b2:	87aa                	mv	a5,a0
    11b4:	1602                	sll	a2,a2,0x20
    11b6:	9201                	srl	a2,a2,0x20
    11b8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    11bc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    11c0:	0785                	add	a5,a5,1
    11c2:	fee79de3          	bne	a5,a4,11bc <memset+0x12>
  }
  return dst;
}
    11c6:	6422                	ld	s0,8(sp)
    11c8:	0141                	add	sp,sp,16
    11ca:	8082                	ret

00000000000011cc <strchr>:

char*
strchr(const char *s, char c)
{
    11cc:	1141                	add	sp,sp,-16
    11ce:	e422                	sd	s0,8(sp)
    11d0:	0800                	add	s0,sp,16
  for(; *s; s++)
    11d2:	00054783          	lbu	a5,0(a0)
    11d6:	cb99                	beqz	a5,11ec <strchr+0x20>
    if(*s == c)
    11d8:	00f58763          	beq	a1,a5,11e6 <strchr+0x1a>
  for(; *s; s++)
    11dc:	0505                	add	a0,a0,1
    11de:	00054783          	lbu	a5,0(a0)
    11e2:	fbfd                	bnez	a5,11d8 <strchr+0xc>
      return (char*)s;
  return 0;
    11e4:	4501                	li	a0,0
}
    11e6:	6422                	ld	s0,8(sp)
    11e8:	0141                	add	sp,sp,16
    11ea:	8082                	ret
  return 0;
    11ec:	4501                	li	a0,0
    11ee:	bfe5                	j	11e6 <strchr+0x1a>

00000000000011f0 <strstr>:

char*
strstr(const char *str, const char *substr)
{
    11f0:	1141                	add	sp,sp,-16
    11f2:	e422                	sd	s0,8(sp)
    11f4:	0800                	add	s0,sp,16
  const char *a, *b = substr;
  if (*b == 0)
    11f6:	0005c803          	lbu	a6,0(a1)
    11fa:	02080a63          	beqz	a6,122e <strstr+0x3e>
    return (char*)str;
  for( ; *str != 0; str += 1) {
    11fe:	00054783          	lbu	a5,0(a0)
    1202:	e799                	bnez	a5,1210 <strstr+0x20>
      if (*a++ != *b++)
        break;
    }
    b = substr;
  }
  return 0;
    1204:	4501                	li	a0,0
    1206:	a025                	j	122e <strstr+0x3e>
  for( ; *str != 0; str += 1) {
    1208:	0505                	add	a0,a0,1
    120a:	00054783          	lbu	a5,0(a0)
    120e:	cf99                	beqz	a5,122c <strstr+0x3c>
    if (*str != *b)
    1210:	fef81ce3          	bne	a6,a5,1208 <strstr+0x18>
    1214:	87ae                	mv	a5,a1
    1216:	86aa                	mv	a3,a0
      if (*b == 0)
    1218:	0007c703          	lbu	a4,0(a5)
    121c:	cb09                	beqz	a4,122e <strstr+0x3e>
      if (*a++ != *b++)
    121e:	0685                	add	a3,a3,1
    1220:	0785                	add	a5,a5,1
    1222:	fff6c603          	lbu	a2,-1(a3)
    1226:	fee609e3          	beq	a2,a4,1218 <strstr+0x28>
    122a:	bff9                	j	1208 <strstr+0x18>
  return 0;
    122c:	4501                	li	a0,0
}
    122e:	6422                	ld	s0,8(sp)
    1230:	0141                	add	sp,sp,16
    1232:	8082                	ret

0000000000001234 <gets>:

char*
gets(char *buf, int max)
{
    1234:	711d                	add	sp,sp,-96
    1236:	ec86                	sd	ra,88(sp)
    1238:	e8a2                	sd	s0,80(sp)
    123a:	e4a6                	sd	s1,72(sp)
    123c:	e0ca                	sd	s2,64(sp)
    123e:	fc4e                	sd	s3,56(sp)
    1240:	f852                	sd	s4,48(sp)
    1242:	f456                	sd	s5,40(sp)
    1244:	f05a                	sd	s6,32(sp)
    1246:	ec5e                	sd	s7,24(sp)
    1248:	1080                	add	s0,sp,96
    124a:	8baa                	mv	s7,a0
    124c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    124e:	892a                	mv	s2,a0
    1250:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    1252:	4aa9                	li	s5,10
    1254:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    1256:	89a6                	mv	s3,s1
    1258:	2485                	addw	s1,s1,1
    125a:	0344d863          	bge	s1,s4,128a <gets+0x56>
    cc = read(0, &c, 1);
    125e:	4605                	li	a2,1
    1260:	faf40593          	add	a1,s0,-81
    1264:	4501                	li	a0,0
    1266:	00000097          	auipc	ra,0x0
    126a:	1b0080e7          	jalr	432(ra) # 1416 <read>
    if(cc < 1)
    126e:	00a05e63          	blez	a0,128a <gets+0x56>
    buf[i++] = c;
    1272:	faf44783          	lbu	a5,-81(s0)
    1276:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    127a:	01578763          	beq	a5,s5,1288 <gets+0x54>
    127e:	0905                	add	s2,s2,1
    1280:	fd679be3          	bne	a5,s6,1256 <gets+0x22>
  for(i=0; i+1 < max; ){
    1284:	89a6                	mv	s3,s1
    1286:	a011                	j	128a <gets+0x56>
    1288:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    128a:	99de                	add	s3,s3,s7
    128c:	00098023          	sb	zero,0(s3)
  return buf;
}
    1290:	855e                	mv	a0,s7
    1292:	60e6                	ld	ra,88(sp)
    1294:	6446                	ld	s0,80(sp)
    1296:	64a6                	ld	s1,72(sp)
    1298:	6906                	ld	s2,64(sp)
    129a:	79e2                	ld	s3,56(sp)
    129c:	7a42                	ld	s4,48(sp)
    129e:	7aa2                	ld	s5,40(sp)
    12a0:	7b02                	ld	s6,32(sp)
    12a2:	6be2                	ld	s7,24(sp)
    12a4:	6125                	add	sp,sp,96
    12a6:	8082                	ret

00000000000012a8 <stat>:

int
stat(const char *n, struct stat *st)
{
    12a8:	1101                	add	sp,sp,-32
    12aa:	ec06                	sd	ra,24(sp)
    12ac:	e822                	sd	s0,16(sp)
    12ae:	e426                	sd	s1,8(sp)
    12b0:	e04a                	sd	s2,0(sp)
    12b2:	1000                	add	s0,sp,32
    12b4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12b6:	4581                	li	a1,0
    12b8:	00000097          	auipc	ra,0x0
    12bc:	186080e7          	jalr	390(ra) # 143e <open>
  if(fd < 0)
    12c0:	02054563          	bltz	a0,12ea <stat+0x42>
    12c4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    12c6:	85ca                	mv	a1,s2
    12c8:	00000097          	auipc	ra,0x0
    12cc:	18e080e7          	jalr	398(ra) # 1456 <fstat>
    12d0:	892a                	mv	s2,a0
  close(fd);
    12d2:	8526                	mv	a0,s1
    12d4:	00000097          	auipc	ra,0x0
    12d8:	152080e7          	jalr	338(ra) # 1426 <close>
  return r;
}
    12dc:	854a                	mv	a0,s2
    12de:	60e2                	ld	ra,24(sp)
    12e0:	6442                	ld	s0,16(sp)
    12e2:	64a2                	ld	s1,8(sp)
    12e4:	6902                	ld	s2,0(sp)
    12e6:	6105                	add	sp,sp,32
    12e8:	8082                	ret
    return -1;
    12ea:	597d                	li	s2,-1
    12ec:	bfc5                	j	12dc <stat+0x34>

00000000000012ee <atoi>:

int
atoi(const char *s)
{
    12ee:	1141                	add	sp,sp,-16
    12f0:	e422                	sd	s0,8(sp)
    12f2:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    12f4:	00054683          	lbu	a3,0(a0)
    12f8:	fd06879b          	addw	a5,a3,-48
    12fc:	0ff7f793          	zext.b	a5,a5
    1300:	4625                	li	a2,9
    1302:	02f66863          	bltu	a2,a5,1332 <atoi+0x44>
    1306:	872a                	mv	a4,a0
  n = 0;
    1308:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
    130a:	0705                	add	a4,a4,1
    130c:	0025179b          	sllw	a5,a0,0x2
    1310:	9fa9                	addw	a5,a5,a0
    1312:	0017979b          	sllw	a5,a5,0x1
    1316:	9fb5                	addw	a5,a5,a3
    1318:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    131c:	00074683          	lbu	a3,0(a4)
    1320:	fd06879b          	addw	a5,a3,-48
    1324:	0ff7f793          	zext.b	a5,a5
    1328:	fef671e3          	bgeu	a2,a5,130a <atoi+0x1c>
  return n;
}
    132c:	6422                	ld	s0,8(sp)
    132e:	0141                	add	sp,sp,16
    1330:	8082                	ret
  n = 0;
    1332:	4501                	li	a0,0
    1334:	bfe5                	j	132c <atoi+0x3e>

0000000000001336 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1336:	1141                	add	sp,sp,-16
    1338:	e422                	sd	s0,8(sp)
    133a:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    133c:	02b57463          	bgeu	a0,a1,1364 <memmove+0x2e>
    while(n-- > 0)
    1340:	00c05f63          	blez	a2,135e <memmove+0x28>
    1344:	1602                	sll	a2,a2,0x20
    1346:	9201                	srl	a2,a2,0x20
    1348:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    134c:	872a                	mv	a4,a0
      *dst++ = *src++;
    134e:	0585                	add	a1,a1,1
    1350:	0705                	add	a4,a4,1
    1352:	fff5c683          	lbu	a3,-1(a1)
    1356:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    135a:	fee79ae3          	bne	a5,a4,134e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    135e:	6422                	ld	s0,8(sp)
    1360:	0141                	add	sp,sp,16
    1362:	8082                	ret
    dst += n;
    1364:	00c50733          	add	a4,a0,a2
    src += n;
    1368:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    136a:	fec05ae3          	blez	a2,135e <memmove+0x28>
    136e:	fff6079b          	addw	a5,a2,-1
    1372:	1782                	sll	a5,a5,0x20
    1374:	9381                	srl	a5,a5,0x20
    1376:	fff7c793          	not	a5,a5
    137a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    137c:	15fd                	add	a1,a1,-1
    137e:	177d                	add	a4,a4,-1
    1380:	0005c683          	lbu	a3,0(a1)
    1384:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    1388:	fee79ae3          	bne	a5,a4,137c <memmove+0x46>
    138c:	bfc9                	j	135e <memmove+0x28>

000000000000138e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    138e:	1141                	add	sp,sp,-16
    1390:	e422                	sd	s0,8(sp)
    1392:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    1394:	ca05                	beqz	a2,13c4 <memcmp+0x36>
    1396:	fff6069b          	addw	a3,a2,-1
    139a:	1682                	sll	a3,a3,0x20
    139c:	9281                	srl	a3,a3,0x20
    139e:	0685                	add	a3,a3,1
    13a0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    13a2:	00054783          	lbu	a5,0(a0)
    13a6:	0005c703          	lbu	a4,0(a1)
    13aa:	00e79863          	bne	a5,a4,13ba <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    13ae:	0505                	add	a0,a0,1
    p2++;
    13b0:	0585                	add	a1,a1,1
  while (n-- > 0) {
    13b2:	fed518e3          	bne	a0,a3,13a2 <memcmp+0x14>
  }
  return 0;
    13b6:	4501                	li	a0,0
    13b8:	a019                	j	13be <memcmp+0x30>
      return *p1 - *p2;
    13ba:	40e7853b          	subw	a0,a5,a4
}
    13be:	6422                	ld	s0,8(sp)
    13c0:	0141                	add	sp,sp,16
    13c2:	8082                	ret
  return 0;
    13c4:	4501                	li	a0,0
    13c6:	bfe5                	j	13be <memcmp+0x30>

00000000000013c8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    13c8:	1141                	add	sp,sp,-16
    13ca:	e406                	sd	ra,8(sp)
    13cc:	e022                	sd	s0,0(sp)
    13ce:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
    13d0:	00000097          	auipc	ra,0x0
    13d4:	f66080e7          	jalr	-154(ra) # 1336 <memmove>
}
    13d8:	60a2                	ld	ra,8(sp)
    13da:	6402                	ld	s0,0(sp)
    13dc:	0141                	add	sp,sp,16
    13de:	8082                	ret

00000000000013e0 <ugetpid>:

int
ugetpid(void)
{
    13e0:	1141                	add	sp,sp,-16
    13e2:	e422                	sd	s0,8(sp)
    13e4:	0800                	add	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
    13e6:	040007b7          	lui	a5,0x4000
}
    13ea:	17f5                	add	a5,a5,-3 # 3fffffd <base+0x3ffdf75>
    13ec:	07b2                	sll	a5,a5,0xc
    13ee:	4388                	lw	a0,0(a5)
    13f0:	6422                	ld	s0,8(sp)
    13f2:	0141                	add	sp,sp,16
    13f4:	8082                	ret

00000000000013f6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    13f6:	4885                	li	a7,1
 ecall
    13f8:	00000073          	ecall
 ret
    13fc:	8082                	ret

00000000000013fe <exit>:
.global exit
exit:
 li a7, SYS_exit
    13fe:	4889                	li	a7,2
 ecall
    1400:	00000073          	ecall
 ret
    1404:	8082                	ret

0000000000001406 <wait>:
.global wait
wait:
 li a7, SYS_wait
    1406:	488d                	li	a7,3
 ecall
    1408:	00000073          	ecall
 ret
    140c:	8082                	ret

000000000000140e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    140e:	4891                	li	a7,4
 ecall
    1410:	00000073          	ecall
 ret
    1414:	8082                	ret

0000000000001416 <read>:
.global read
read:
 li a7, SYS_read
    1416:	4895                	li	a7,5
 ecall
    1418:	00000073          	ecall
 ret
    141c:	8082                	ret

000000000000141e <write>:
.global write
write:
 li a7, SYS_write
    141e:	48c1                	li	a7,16
 ecall
    1420:	00000073          	ecall
 ret
    1424:	8082                	ret

0000000000001426 <close>:
.global close
close:
 li a7, SYS_close
    1426:	48d5                	li	a7,21
 ecall
    1428:	00000073          	ecall
 ret
    142c:	8082                	ret

000000000000142e <kill>:
.global kill
kill:
 li a7, SYS_kill
    142e:	4899                	li	a7,6
 ecall
    1430:	00000073          	ecall
 ret
    1434:	8082                	ret

0000000000001436 <exec>:
.global exec
exec:
 li a7, SYS_exec
    1436:	489d                	li	a7,7
 ecall
    1438:	00000073          	ecall
 ret
    143c:	8082                	ret

000000000000143e <open>:
.global open
open:
 li a7, SYS_open
    143e:	48bd                	li	a7,15
 ecall
    1440:	00000073          	ecall
 ret
    1444:	8082                	ret

0000000000001446 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    1446:	48c5                	li	a7,17
 ecall
    1448:	00000073          	ecall
 ret
    144c:	8082                	ret

000000000000144e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    144e:	48c9                	li	a7,18
 ecall
    1450:	00000073          	ecall
 ret
    1454:	8082                	ret

0000000000001456 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    1456:	48a1                	li	a7,8
 ecall
    1458:	00000073          	ecall
 ret
    145c:	8082                	ret

000000000000145e <link>:
.global link
link:
 li a7, SYS_link
    145e:	48cd                	li	a7,19
 ecall
    1460:	00000073          	ecall
 ret
    1464:	8082                	ret

0000000000001466 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    1466:	48d1                	li	a7,20
 ecall
    1468:	00000073          	ecall
 ret
    146c:	8082                	ret

000000000000146e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    146e:	48a5                	li	a7,9
 ecall
    1470:	00000073          	ecall
 ret
    1474:	8082                	ret

0000000000001476 <dup>:
.global dup
dup:
 li a7, SYS_dup
    1476:	48a9                	li	a7,10
 ecall
    1478:	00000073          	ecall
 ret
    147c:	8082                	ret

000000000000147e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    147e:	48ad                	li	a7,11
 ecall
    1480:	00000073          	ecall
 ret
    1484:	8082                	ret

0000000000001486 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    1486:	48b1                	li	a7,12
 ecall
    1488:	00000073          	ecall
 ret
    148c:	8082                	ret

000000000000148e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    148e:	48b5                	li	a7,13
 ecall
    1490:	00000073          	ecall
 ret
    1494:	8082                	ret

0000000000001496 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    1496:	48b9                	li	a7,14
 ecall
    1498:	00000073          	ecall
 ret
    149c:	8082                	ret

000000000000149e <trace>:
.global trace
trace:
 li a7, SYS_trace
    149e:	48d9                	li	a7,22
 ecall
    14a0:	00000073          	ecall
 ret
    14a4:	8082                	ret

00000000000014a6 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
    14a6:	48dd                	li	a7,23
 ecall
    14a8:	00000073          	ecall
 ret
    14ac:	8082                	ret

00000000000014ae <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
    14ae:	48e1                	li	a7,24
 ecall
    14b0:	00000073          	ecall
 ret
    14b4:	8082                	ret

00000000000014b6 <setpriority>:
.global setpriority
setpriority:
 li a7, SYS_setpriority
    14b6:	48e5                	li	a7,25
 ecall
    14b8:	00000073          	ecall
 ret
    14bc:	8082                	ret

00000000000014be <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    14be:	1101                	add	sp,sp,-32
    14c0:	ec06                	sd	ra,24(sp)
    14c2:	e822                	sd	s0,16(sp)
    14c4:	1000                	add	s0,sp,32
    14c6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    14ca:	4605                	li	a2,1
    14cc:	fef40593          	add	a1,s0,-17
    14d0:	00000097          	auipc	ra,0x0
    14d4:	f4e080e7          	jalr	-178(ra) # 141e <write>
}
    14d8:	60e2                	ld	ra,24(sp)
    14da:	6442                	ld	s0,16(sp)
    14dc:	6105                	add	sp,sp,32
    14de:	8082                	ret

00000000000014e0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    14e0:	7139                	add	sp,sp,-64
    14e2:	fc06                	sd	ra,56(sp)
    14e4:	f822                	sd	s0,48(sp)
    14e6:	f426                	sd	s1,40(sp)
    14e8:	f04a                	sd	s2,32(sp)
    14ea:	ec4e                	sd	s3,24(sp)
    14ec:	0080                	add	s0,sp,64
    14ee:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    14f0:	c299                	beqz	a3,14f6 <printint+0x16>
    14f2:	0805c963          	bltz	a1,1584 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    14f6:	2581                	sext.w	a1,a1
  neg = 0;
    14f8:	4881                	li	a7,0
    14fa:	fc040693          	add	a3,s0,-64
  }

  i = 0;
    14fe:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    1500:	2601                	sext.w	a2,a2
    1502:	00000517          	auipc	a0,0x0
    1506:	5ee50513          	add	a0,a0,1518 # 1af0 <digits>
    150a:	883a                	mv	a6,a4
    150c:	2705                	addw	a4,a4,1
    150e:	02c5f7bb          	remuw	a5,a1,a2
    1512:	1782                	sll	a5,a5,0x20
    1514:	9381                	srl	a5,a5,0x20
    1516:	97aa                	add	a5,a5,a0
    1518:	0007c783          	lbu	a5,0(a5)
    151c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    1520:	0005879b          	sext.w	a5,a1
    1524:	02c5d5bb          	divuw	a1,a1,a2
    1528:	0685                	add	a3,a3,1
    152a:	fec7f0e3          	bgeu	a5,a2,150a <printint+0x2a>
  if(neg)
    152e:	00088c63          	beqz	a7,1546 <printint+0x66>
    buf[i++] = '-';
    1532:	fd070793          	add	a5,a4,-48
    1536:	00878733          	add	a4,a5,s0
    153a:	02d00793          	li	a5,45
    153e:	fef70823          	sb	a5,-16(a4)
    1542:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
    1546:	02e05863          	blez	a4,1576 <printint+0x96>
    154a:	fc040793          	add	a5,s0,-64
    154e:	00e78933          	add	s2,a5,a4
    1552:	fff78993          	add	s3,a5,-1
    1556:	99ba                	add	s3,s3,a4
    1558:	377d                	addw	a4,a4,-1
    155a:	1702                	sll	a4,a4,0x20
    155c:	9301                	srl	a4,a4,0x20
    155e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    1562:	fff94583          	lbu	a1,-1(s2)
    1566:	8526                	mv	a0,s1
    1568:	00000097          	auipc	ra,0x0
    156c:	f56080e7          	jalr	-170(ra) # 14be <putc>
  while(--i >= 0)
    1570:	197d                	add	s2,s2,-1
    1572:	ff3918e3          	bne	s2,s3,1562 <printint+0x82>
}
    1576:	70e2                	ld	ra,56(sp)
    1578:	7442                	ld	s0,48(sp)
    157a:	74a2                	ld	s1,40(sp)
    157c:	7902                	ld	s2,32(sp)
    157e:	69e2                	ld	s3,24(sp)
    1580:	6121                	add	sp,sp,64
    1582:	8082                	ret
    x = -xx;
    1584:	40b005bb          	negw	a1,a1
    neg = 1;
    1588:	4885                	li	a7,1
    x = -xx;
    158a:	bf85                	j	14fa <printint+0x1a>

000000000000158c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    158c:	715d                	add	sp,sp,-80
    158e:	e486                	sd	ra,72(sp)
    1590:	e0a2                	sd	s0,64(sp)
    1592:	fc26                	sd	s1,56(sp)
    1594:	f84a                	sd	s2,48(sp)
    1596:	f44e                	sd	s3,40(sp)
    1598:	f052                	sd	s4,32(sp)
    159a:	ec56                	sd	s5,24(sp)
    159c:	e85a                	sd	s6,16(sp)
    159e:	e45e                	sd	s7,8(sp)
    15a0:	e062                	sd	s8,0(sp)
    15a2:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    15a4:	0005c903          	lbu	s2,0(a1)
    15a8:	18090c63          	beqz	s2,1740 <vprintf+0x1b4>
    15ac:	8aaa                	mv	s5,a0
    15ae:	8bb2                	mv	s7,a2
    15b0:	00158493          	add	s1,a1,1
  state = 0;
    15b4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    15b6:	02500a13          	li	s4,37
    15ba:	4b55                	li	s6,21
    15bc:	a839                	j	15da <vprintf+0x4e>
        putc(fd, c);
    15be:	85ca                	mv	a1,s2
    15c0:	8556                	mv	a0,s5
    15c2:	00000097          	auipc	ra,0x0
    15c6:	efc080e7          	jalr	-260(ra) # 14be <putc>
    15ca:	a019                	j	15d0 <vprintf+0x44>
    } else if(state == '%'){
    15cc:	01498d63          	beq	s3,s4,15e6 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
    15d0:	0485                	add	s1,s1,1
    15d2:	fff4c903          	lbu	s2,-1(s1)
    15d6:	16090563          	beqz	s2,1740 <vprintf+0x1b4>
    if(state == 0){
    15da:	fe0999e3          	bnez	s3,15cc <vprintf+0x40>
      if(c == '%'){
    15de:	ff4910e3          	bne	s2,s4,15be <vprintf+0x32>
        state = '%';
    15e2:	89d2                	mv	s3,s4
    15e4:	b7f5                	j	15d0 <vprintf+0x44>
      if(c == 'd'){
    15e6:	13490263          	beq	s2,s4,170a <vprintf+0x17e>
    15ea:	f9d9079b          	addw	a5,s2,-99
    15ee:	0ff7f793          	zext.b	a5,a5
    15f2:	12fb6563          	bltu	s6,a5,171c <vprintf+0x190>
    15f6:	f9d9079b          	addw	a5,s2,-99
    15fa:	0ff7f713          	zext.b	a4,a5
    15fe:	10eb6f63          	bltu	s6,a4,171c <vprintf+0x190>
    1602:	00271793          	sll	a5,a4,0x2
    1606:	00000717          	auipc	a4,0x0
    160a:	49270713          	add	a4,a4,1170 # 1a98 <malloc+0x25a>
    160e:	97ba                	add	a5,a5,a4
    1610:	439c                	lw	a5,0(a5)
    1612:	97ba                	add	a5,a5,a4
    1614:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    1616:	008b8913          	add	s2,s7,8
    161a:	4685                	li	a3,1
    161c:	4629                	li	a2,10
    161e:	000ba583          	lw	a1,0(s7)
    1622:	8556                	mv	a0,s5
    1624:	00000097          	auipc	ra,0x0
    1628:	ebc080e7          	jalr	-324(ra) # 14e0 <printint>
    162c:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    162e:	4981                	li	s3,0
    1630:	b745                	j	15d0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1632:	008b8913          	add	s2,s7,8
    1636:	4681                	li	a3,0
    1638:	4629                	li	a2,10
    163a:	000ba583          	lw	a1,0(s7)
    163e:	8556                	mv	a0,s5
    1640:	00000097          	auipc	ra,0x0
    1644:	ea0080e7          	jalr	-352(ra) # 14e0 <printint>
    1648:	8bca                	mv	s7,s2
      state = 0;
    164a:	4981                	li	s3,0
    164c:	b751                	j	15d0 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
    164e:	008b8913          	add	s2,s7,8
    1652:	4681                	li	a3,0
    1654:	4641                	li	a2,16
    1656:	000ba583          	lw	a1,0(s7)
    165a:	8556                	mv	a0,s5
    165c:	00000097          	auipc	ra,0x0
    1660:	e84080e7          	jalr	-380(ra) # 14e0 <printint>
    1664:	8bca                	mv	s7,s2
      state = 0;
    1666:	4981                	li	s3,0
    1668:	b7a5                	j	15d0 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
    166a:	008b8c13          	add	s8,s7,8
    166e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    1672:	03000593          	li	a1,48
    1676:	8556                	mv	a0,s5
    1678:	00000097          	auipc	ra,0x0
    167c:	e46080e7          	jalr	-442(ra) # 14be <putc>
  putc(fd, 'x');
    1680:	07800593          	li	a1,120
    1684:	8556                	mv	a0,s5
    1686:	00000097          	auipc	ra,0x0
    168a:	e38080e7          	jalr	-456(ra) # 14be <putc>
    168e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1690:	00000b97          	auipc	s7,0x0
    1694:	460b8b93          	add	s7,s7,1120 # 1af0 <digits>
    1698:	03c9d793          	srl	a5,s3,0x3c
    169c:	97de                	add	a5,a5,s7
    169e:	0007c583          	lbu	a1,0(a5)
    16a2:	8556                	mv	a0,s5
    16a4:	00000097          	auipc	ra,0x0
    16a8:	e1a080e7          	jalr	-486(ra) # 14be <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    16ac:	0992                	sll	s3,s3,0x4
    16ae:	397d                	addw	s2,s2,-1
    16b0:	fe0914e3          	bnez	s2,1698 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
    16b4:	8be2                	mv	s7,s8
      state = 0;
    16b6:	4981                	li	s3,0
    16b8:	bf21                	j	15d0 <vprintf+0x44>
        s = va_arg(ap, char*);
    16ba:	008b8993          	add	s3,s7,8
    16be:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    16c2:	02090163          	beqz	s2,16e4 <vprintf+0x158>
        while(*s != 0){
    16c6:	00094583          	lbu	a1,0(s2)
    16ca:	c9a5                	beqz	a1,173a <vprintf+0x1ae>
          putc(fd, *s);
    16cc:	8556                	mv	a0,s5
    16ce:	00000097          	auipc	ra,0x0
    16d2:	df0080e7          	jalr	-528(ra) # 14be <putc>
          s++;
    16d6:	0905                	add	s2,s2,1
        while(*s != 0){
    16d8:	00094583          	lbu	a1,0(s2)
    16dc:	f9e5                	bnez	a1,16cc <vprintf+0x140>
        s = va_arg(ap, char*);
    16de:	8bce                	mv	s7,s3
      state = 0;
    16e0:	4981                	li	s3,0
    16e2:	b5fd                	j	15d0 <vprintf+0x44>
          s = "(null)";
    16e4:	00000917          	auipc	s2,0x0
    16e8:	3ac90913          	add	s2,s2,940 # 1a90 <malloc+0x252>
        while(*s != 0){
    16ec:	02800593          	li	a1,40
    16f0:	bff1                	j	16cc <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
    16f2:	008b8913          	add	s2,s7,8
    16f6:	000bc583          	lbu	a1,0(s7)
    16fa:	8556                	mv	a0,s5
    16fc:	00000097          	auipc	ra,0x0
    1700:	dc2080e7          	jalr	-574(ra) # 14be <putc>
    1704:	8bca                	mv	s7,s2
      state = 0;
    1706:	4981                	li	s3,0
    1708:	b5e1                	j	15d0 <vprintf+0x44>
        putc(fd, c);
    170a:	02500593          	li	a1,37
    170e:	8556                	mv	a0,s5
    1710:	00000097          	auipc	ra,0x0
    1714:	dae080e7          	jalr	-594(ra) # 14be <putc>
      state = 0;
    1718:	4981                	li	s3,0
    171a:	bd5d                	j	15d0 <vprintf+0x44>
        putc(fd, '%');
    171c:	02500593          	li	a1,37
    1720:	8556                	mv	a0,s5
    1722:	00000097          	auipc	ra,0x0
    1726:	d9c080e7          	jalr	-612(ra) # 14be <putc>
        putc(fd, c);
    172a:	85ca                	mv	a1,s2
    172c:	8556                	mv	a0,s5
    172e:	00000097          	auipc	ra,0x0
    1732:	d90080e7          	jalr	-624(ra) # 14be <putc>
      state = 0;
    1736:	4981                	li	s3,0
    1738:	bd61                	j	15d0 <vprintf+0x44>
        s = va_arg(ap, char*);
    173a:	8bce                	mv	s7,s3
      state = 0;
    173c:	4981                	li	s3,0
    173e:	bd49                	j	15d0 <vprintf+0x44>
    }
  }
}
    1740:	60a6                	ld	ra,72(sp)
    1742:	6406                	ld	s0,64(sp)
    1744:	74e2                	ld	s1,56(sp)
    1746:	7942                	ld	s2,48(sp)
    1748:	79a2                	ld	s3,40(sp)
    174a:	7a02                	ld	s4,32(sp)
    174c:	6ae2                	ld	s5,24(sp)
    174e:	6b42                	ld	s6,16(sp)
    1750:	6ba2                	ld	s7,8(sp)
    1752:	6c02                	ld	s8,0(sp)
    1754:	6161                	add	sp,sp,80
    1756:	8082                	ret

0000000000001758 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1758:	715d                	add	sp,sp,-80
    175a:	ec06                	sd	ra,24(sp)
    175c:	e822                	sd	s0,16(sp)
    175e:	1000                	add	s0,sp,32
    1760:	e010                	sd	a2,0(s0)
    1762:	e414                	sd	a3,8(s0)
    1764:	e818                	sd	a4,16(s0)
    1766:	ec1c                	sd	a5,24(s0)
    1768:	03043023          	sd	a6,32(s0)
    176c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1770:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1774:	8622                	mv	a2,s0
    1776:	00000097          	auipc	ra,0x0
    177a:	e16080e7          	jalr	-490(ra) # 158c <vprintf>
}
    177e:	60e2                	ld	ra,24(sp)
    1780:	6442                	ld	s0,16(sp)
    1782:	6161                	add	sp,sp,80
    1784:	8082                	ret

0000000000001786 <printf>:

void
printf(const char *fmt, ...)
{
    1786:	711d                	add	sp,sp,-96
    1788:	ec06                	sd	ra,24(sp)
    178a:	e822                	sd	s0,16(sp)
    178c:	1000                	add	s0,sp,32
    178e:	e40c                	sd	a1,8(s0)
    1790:	e810                	sd	a2,16(s0)
    1792:	ec14                	sd	a3,24(s0)
    1794:	f018                	sd	a4,32(s0)
    1796:	f41c                	sd	a5,40(s0)
    1798:	03043823          	sd	a6,48(s0)
    179c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    17a0:	00840613          	add	a2,s0,8
    17a4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    17a8:	85aa                	mv	a1,a0
    17aa:	4505                	li	a0,1
    17ac:	00000097          	auipc	ra,0x0
    17b0:	de0080e7          	jalr	-544(ra) # 158c <vprintf>
}
    17b4:	60e2                	ld	ra,24(sp)
    17b6:	6442                	ld	s0,16(sp)
    17b8:	6125                	add	sp,sp,96
    17ba:	8082                	ret

00000000000017bc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    17bc:	1141                	add	sp,sp,-16
    17be:	e422                	sd	s0,8(sp)
    17c0:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    17c2:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17c6:	00001797          	auipc	a5,0x1
    17ca:	84a7b783          	ld	a5,-1974(a5) # 2010 <freep>
    17ce:	a02d                	j	17f8 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    17d0:	4618                	lw	a4,8(a2)
    17d2:	9f2d                	addw	a4,a4,a1
    17d4:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    17d8:	6398                	ld	a4,0(a5)
    17da:	6310                	ld	a2,0(a4)
    17dc:	a83d                	j	181a <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    17de:	ff852703          	lw	a4,-8(a0)
    17e2:	9f31                	addw	a4,a4,a2
    17e4:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    17e6:	ff053683          	ld	a3,-16(a0)
    17ea:	a091                	j	182e <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    17ec:	6398                	ld	a4,0(a5)
    17ee:	00e7e463          	bltu	a5,a4,17f6 <free+0x3a>
    17f2:	00e6ea63          	bltu	a3,a4,1806 <free+0x4a>
{
    17f6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17f8:	fed7fae3          	bgeu	a5,a3,17ec <free+0x30>
    17fc:	6398                	ld	a4,0(a5)
    17fe:	00e6e463          	bltu	a3,a4,1806 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1802:	fee7eae3          	bltu	a5,a4,17f6 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    1806:	ff852583          	lw	a1,-8(a0)
    180a:	6390                	ld	a2,0(a5)
    180c:	02059813          	sll	a6,a1,0x20
    1810:	01c85713          	srl	a4,a6,0x1c
    1814:	9736                	add	a4,a4,a3
    1816:	fae60de3          	beq	a2,a4,17d0 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    181a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    181e:	4790                	lw	a2,8(a5)
    1820:	02061593          	sll	a1,a2,0x20
    1824:	01c5d713          	srl	a4,a1,0x1c
    1828:	973e                	add	a4,a4,a5
    182a:	fae68ae3          	beq	a3,a4,17de <free+0x22>
    p->s.ptr = bp->s.ptr;
    182e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    1830:	00000717          	auipc	a4,0x0
    1834:	7ef73023          	sd	a5,2016(a4) # 2010 <freep>
}
    1838:	6422                	ld	s0,8(sp)
    183a:	0141                	add	sp,sp,16
    183c:	8082                	ret

000000000000183e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    183e:	7139                	add	sp,sp,-64
    1840:	fc06                	sd	ra,56(sp)
    1842:	f822                	sd	s0,48(sp)
    1844:	f426                	sd	s1,40(sp)
    1846:	f04a                	sd	s2,32(sp)
    1848:	ec4e                	sd	s3,24(sp)
    184a:	e852                	sd	s4,16(sp)
    184c:	e456                	sd	s5,8(sp)
    184e:	e05a                	sd	s6,0(sp)
    1850:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1852:	02051493          	sll	s1,a0,0x20
    1856:	9081                	srl	s1,s1,0x20
    1858:	04bd                	add	s1,s1,15
    185a:	8091                	srl	s1,s1,0x4
    185c:	0014899b          	addw	s3,s1,1
    1860:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    1862:	00000517          	auipc	a0,0x0
    1866:	7ae53503          	ld	a0,1966(a0) # 2010 <freep>
    186a:	c515                	beqz	a0,1896 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    186c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    186e:	4798                	lw	a4,8(a5)
    1870:	02977f63          	bgeu	a4,s1,18ae <malloc+0x70>
  if(nu < 4096)
    1874:	8a4e                	mv	s4,s3
    1876:	0009871b          	sext.w	a4,s3
    187a:	6685                	lui	a3,0x1
    187c:	00d77363          	bgeu	a4,a3,1882 <malloc+0x44>
    1880:	6a05                	lui	s4,0x1
    1882:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1886:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    188a:	00000917          	auipc	s2,0x0
    188e:	78690913          	add	s2,s2,1926 # 2010 <freep>
  if(p == (char*)-1)
    1892:	5afd                	li	s5,-1
    1894:	a895                	j	1908 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
    1896:	00000797          	auipc	a5,0x0
    189a:	7f278793          	add	a5,a5,2034 # 2088 <base>
    189e:	00000717          	auipc	a4,0x0
    18a2:	76f73923          	sd	a5,1906(a4) # 2010 <freep>
    18a6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    18a8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    18ac:	b7e1                	j	1874 <malloc+0x36>
      if(p->s.size == nunits)
    18ae:	02e48c63          	beq	s1,a4,18e6 <malloc+0xa8>
        p->s.size -= nunits;
    18b2:	4137073b          	subw	a4,a4,s3
    18b6:	c798                	sw	a4,8(a5)
        p += p->s.size;
    18b8:	02071693          	sll	a3,a4,0x20
    18bc:	01c6d713          	srl	a4,a3,0x1c
    18c0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    18c2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    18c6:	00000717          	auipc	a4,0x0
    18ca:	74a73523          	sd	a0,1866(a4) # 2010 <freep>
      return (void*)(p + 1);
    18ce:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    18d2:	70e2                	ld	ra,56(sp)
    18d4:	7442                	ld	s0,48(sp)
    18d6:	74a2                	ld	s1,40(sp)
    18d8:	7902                	ld	s2,32(sp)
    18da:	69e2                	ld	s3,24(sp)
    18dc:	6a42                	ld	s4,16(sp)
    18de:	6aa2                	ld	s5,8(sp)
    18e0:	6b02                	ld	s6,0(sp)
    18e2:	6121                	add	sp,sp,64
    18e4:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    18e6:	6398                	ld	a4,0(a5)
    18e8:	e118                	sd	a4,0(a0)
    18ea:	bff1                	j	18c6 <malloc+0x88>
  hp->s.size = nu;
    18ec:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    18f0:	0541                	add	a0,a0,16
    18f2:	00000097          	auipc	ra,0x0
    18f6:	eca080e7          	jalr	-310(ra) # 17bc <free>
  return freep;
    18fa:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    18fe:	d971                	beqz	a0,18d2 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1900:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1902:	4798                	lw	a4,8(a5)
    1904:	fa9775e3          	bgeu	a4,s1,18ae <malloc+0x70>
    if(p == freep)
    1908:	00093703          	ld	a4,0(s2)
    190c:	853e                	mv	a0,a5
    190e:	fef719e3          	bne	a4,a5,1900 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
    1912:	8552                	mv	a0,s4
    1914:	00000097          	auipc	ra,0x0
    1918:	b72080e7          	jalr	-1166(ra) # 1486 <sbrk>
  if(p == (char*)-1)
    191c:	fd5518e3          	bne	a0,s5,18ec <malloc+0xae>
        return 0;
    1920:	4501                	li	a0,0
    1922:	bf45                	j	18d2 <malloc+0x94>
