
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0001a117          	auipc	sp,0x1a
    80000004:	26010113          	add	sp,sp,608 # 8001a260 <stack0>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	add	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	361050ef          	jal	80005b76 <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8000001c:	1101                	add	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	e426                	sd	s1,8(sp)
    80000024:	e04a                	sd	s2,0(sp)
    80000026:	1000                	add	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000028:	03451793          	sll	a5,a0,0x34
    8000002c:	ebb9                	bnez	a5,80000082 <kfree+0x66>
    8000002e:	84aa                	mv	s1,a0
    80000030:	00022797          	auipc	a5,0x22
    80000034:	33078793          	add	a5,a5,816 # 80022360 <end>
    80000038:	04f56563          	bltu	a0,a5,80000082 <kfree+0x66>
    8000003c:	47c5                	li	a5,17
    8000003e:	07ee                	sll	a5,a5,0x1b
    80000040:	04f57163          	bgeu	a0,a5,80000082 <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000044:	6605                	lui	a2,0x1
    80000046:	4585                	li	a1,1
    80000048:	00000097          	auipc	ra,0x0
    8000004c:	17c080e7          	jalr	380(ra) # 800001c4 <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000050:	00009917          	auipc	s2,0x9
    80000054:	a8090913          	add	s2,s2,-1408 # 80008ad0 <kmem>
    80000058:	854a                	mv	a0,s2
    8000005a:	00006097          	auipc	ra,0x6
    8000005e:	5be080e7          	jalr	1470(ra) # 80006618 <acquire>
  r->next = kmem.freelist;
    80000062:	01893783          	ld	a5,24(s2)
    80000066:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000068:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    8000006c:	854a                	mv	a0,s2
    8000006e:	00006097          	auipc	ra,0x6
    80000072:	65e080e7          	jalr	1630(ra) # 800066cc <release>
}
    80000076:	60e2                	ld	ra,24(sp)
    80000078:	6442                	ld	s0,16(sp)
    8000007a:	64a2                	ld	s1,8(sp)
    8000007c:	6902                	ld	s2,0(sp)
    8000007e:	6105                	add	sp,sp,32
    80000080:	8082                	ret
    panic("kfree");
    80000082:	00008517          	auipc	a0,0x8
    80000086:	f8e50513          	add	a0,a0,-114 # 80008010 <etext+0x10>
    8000008a:	00006097          	auipc	ra,0x6
    8000008e:	056080e7          	jalr	86(ra) # 800060e0 <panic>

0000000080000092 <freerange>:
{
    80000092:	7179                	add	sp,sp,-48
    80000094:	f406                	sd	ra,40(sp)
    80000096:	f022                	sd	s0,32(sp)
    80000098:	ec26                	sd	s1,24(sp)
    8000009a:	e84a                	sd	s2,16(sp)
    8000009c:	e44e                	sd	s3,8(sp)
    8000009e:	e052                	sd	s4,0(sp)
    800000a0:	1800                	add	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    800000a2:	6785                	lui	a5,0x1
    800000a4:	fff78713          	add	a4,a5,-1 # fff <_entry-0x7ffff001>
    800000a8:	00e504b3          	add	s1,a0,a4
    800000ac:	777d                	lui	a4,0xfffff
    800000ae:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000b0:	94be                	add	s1,s1,a5
    800000b2:	0095ee63          	bltu	a1,s1,800000ce <freerange+0x3c>
    800000b6:	892e                	mv	s2,a1
    kfree(p);
    800000b8:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000ba:	6985                	lui	s3,0x1
    kfree(p);
    800000bc:	01448533          	add	a0,s1,s4
    800000c0:	00000097          	auipc	ra,0x0
    800000c4:	f5c080e7          	jalr	-164(ra) # 8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000c8:	94ce                	add	s1,s1,s3
    800000ca:	fe9979e3          	bgeu	s2,s1,800000bc <freerange+0x2a>
}
    800000ce:	70a2                	ld	ra,40(sp)
    800000d0:	7402                	ld	s0,32(sp)
    800000d2:	64e2                	ld	s1,24(sp)
    800000d4:	6942                	ld	s2,16(sp)
    800000d6:	69a2                	ld	s3,8(sp)
    800000d8:	6a02                	ld	s4,0(sp)
    800000da:	6145                	add	sp,sp,48
    800000dc:	8082                	ret

00000000800000de <kinit>:
{
    800000de:	1141                	add	sp,sp,-16
    800000e0:	e406                	sd	ra,8(sp)
    800000e2:	e022                	sd	s0,0(sp)
    800000e4:	0800                	add	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800000e6:	00008597          	auipc	a1,0x8
    800000ea:	f3258593          	add	a1,a1,-206 # 80008018 <etext+0x18>
    800000ee:	00009517          	auipc	a0,0x9
    800000f2:	9e250513          	add	a0,a0,-1566 # 80008ad0 <kmem>
    800000f6:	00006097          	auipc	ra,0x6
    800000fa:	492080e7          	jalr	1170(ra) # 80006588 <initlock>
  freerange(end, (void*)PHYSTOP);
    800000fe:	45c5                	li	a1,17
    80000100:	05ee                	sll	a1,a1,0x1b
    80000102:	00022517          	auipc	a0,0x22
    80000106:	25e50513          	add	a0,a0,606 # 80022360 <end>
    8000010a:	00000097          	auipc	ra,0x0
    8000010e:	f88080e7          	jalr	-120(ra) # 80000092 <freerange>
}
    80000112:	60a2                	ld	ra,8(sp)
    80000114:	6402                	ld	s0,0(sp)
    80000116:	0141                	add	sp,sp,16
    80000118:	8082                	ret

000000008000011a <kfreesize>:

// Returns the number of bytes of free memory
uint64
kfreesize(void)
{
    8000011a:	1101                	add	sp,sp,-32
    8000011c:	ec06                	sd	ra,24(sp)
    8000011e:	e822                	sd	s0,16(sp)
    80000120:	e426                	sd	s1,8(sp)
    80000122:	1000                	add	s0,sp,32
  struct run *r;
  uint64 freemem = 0;

  acquire(&kmem.lock);
    80000124:	00009497          	auipc	s1,0x9
    80000128:	9ac48493          	add	s1,s1,-1620 # 80008ad0 <kmem>
    8000012c:	8526                	mv	a0,s1
    8000012e:	00006097          	auipc	ra,0x6
    80000132:	4ea080e7          	jalr	1258(ra) # 80006618 <acquire>
  r = kmem.freelist;
    80000136:	6c9c                	ld	a5,24(s1)
  while (r) {
    80000138:	c785                	beqz	a5,80000160 <kfreesize+0x46>
  uint64 freemem = 0;
    8000013a:	4481                	li	s1,0
    freemem += PGSIZE;
    8000013c:	6705                	lui	a4,0x1
    8000013e:	94ba                	add	s1,s1,a4
    r = r->next;
    80000140:	639c                	ld	a5,0(a5)
  while (r) {
    80000142:	fff5                	bnez	a5,8000013e <kfreesize+0x24>
  }
  release(&kmem.lock);
    80000144:	00009517          	auipc	a0,0x9
    80000148:	98c50513          	add	a0,a0,-1652 # 80008ad0 <kmem>
    8000014c:	00006097          	auipc	ra,0x6
    80000150:	580080e7          	jalr	1408(ra) # 800066cc <release>

  return freemem;
}
    80000154:	8526                	mv	a0,s1
    80000156:	60e2                	ld	ra,24(sp)
    80000158:	6442                	ld	s0,16(sp)
    8000015a:	64a2                	ld	s1,8(sp)
    8000015c:	6105                	add	sp,sp,32
    8000015e:	8082                	ret
  uint64 freemem = 0;
    80000160:	4481                	li	s1,0
    80000162:	b7cd                	j	80000144 <kfreesize+0x2a>

0000000080000164 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000164:	1101                	add	sp,sp,-32
    80000166:	ec06                	sd	ra,24(sp)
    80000168:	e822                	sd	s0,16(sp)
    8000016a:	e426                	sd	s1,8(sp)
    8000016c:	1000                	add	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    8000016e:	00009497          	auipc	s1,0x9
    80000172:	96248493          	add	s1,s1,-1694 # 80008ad0 <kmem>
    80000176:	8526                	mv	a0,s1
    80000178:	00006097          	auipc	ra,0x6
    8000017c:	4a0080e7          	jalr	1184(ra) # 80006618 <acquire>
  r = kmem.freelist;
    80000180:	6c84                	ld	s1,24(s1)
  if(r)
    80000182:	c885                	beqz	s1,800001b2 <kalloc+0x4e>
    kmem.freelist = r->next;
    80000184:	609c                	ld	a5,0(s1)
    80000186:	00009517          	auipc	a0,0x9
    8000018a:	94a50513          	add	a0,a0,-1718 # 80008ad0 <kmem>
    8000018e:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000190:	00006097          	auipc	ra,0x6
    80000194:	53c080e7          	jalr	1340(ra) # 800066cc <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    80000198:	6605                	lui	a2,0x1
    8000019a:	4595                	li	a1,5
    8000019c:	8526                	mv	a0,s1
    8000019e:	00000097          	auipc	ra,0x0
    800001a2:	026080e7          	jalr	38(ra) # 800001c4 <memset>
  return (void*)r;
}
    800001a6:	8526                	mv	a0,s1
    800001a8:	60e2                	ld	ra,24(sp)
    800001aa:	6442                	ld	s0,16(sp)
    800001ac:	64a2                	ld	s1,8(sp)
    800001ae:	6105                	add	sp,sp,32
    800001b0:	8082                	ret
  release(&kmem.lock);
    800001b2:	00009517          	auipc	a0,0x9
    800001b6:	91e50513          	add	a0,a0,-1762 # 80008ad0 <kmem>
    800001ba:	00006097          	auipc	ra,0x6
    800001be:	512080e7          	jalr	1298(ra) # 800066cc <release>
  if(r)
    800001c2:	b7d5                	j	800001a6 <kalloc+0x42>

00000000800001c4 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    800001c4:	1141                	add	sp,sp,-16
    800001c6:	e422                	sd	s0,8(sp)
    800001c8:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    800001ca:	ca19                	beqz	a2,800001e0 <memset+0x1c>
    800001cc:	87aa                	mv	a5,a0
    800001ce:	1602                	sll	a2,a2,0x20
    800001d0:	9201                	srl	a2,a2,0x20
    800001d2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    800001d6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    800001da:	0785                	add	a5,a5,1
    800001dc:	fee79de3          	bne	a5,a4,800001d6 <memset+0x12>
  }
  return dst;
}
    800001e0:	6422                	ld	s0,8(sp)
    800001e2:	0141                	add	sp,sp,16
    800001e4:	8082                	ret

00000000800001e6 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    800001e6:	1141                	add	sp,sp,-16
    800001e8:	e422                	sd	s0,8(sp)
    800001ea:	0800                	add	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    800001ec:	ca05                	beqz	a2,8000021c <memcmp+0x36>
    800001ee:	fff6069b          	addw	a3,a2,-1 # fff <_entry-0x7ffff001>
    800001f2:	1682                	sll	a3,a3,0x20
    800001f4:	9281                	srl	a3,a3,0x20
    800001f6:	0685                	add	a3,a3,1
    800001f8:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    800001fa:	00054783          	lbu	a5,0(a0)
    800001fe:	0005c703          	lbu	a4,0(a1)
    80000202:	00e79863          	bne	a5,a4,80000212 <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    80000206:	0505                	add	a0,a0,1
    80000208:	0585                	add	a1,a1,1
  while(n-- > 0){
    8000020a:	fed518e3          	bne	a0,a3,800001fa <memcmp+0x14>
  }

  return 0;
    8000020e:	4501                	li	a0,0
    80000210:	a019                	j	80000216 <memcmp+0x30>
      return *s1 - *s2;
    80000212:	40e7853b          	subw	a0,a5,a4
}
    80000216:	6422                	ld	s0,8(sp)
    80000218:	0141                	add	sp,sp,16
    8000021a:	8082                	ret
  return 0;
    8000021c:	4501                	li	a0,0
    8000021e:	bfe5                	j	80000216 <memcmp+0x30>

0000000080000220 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    80000220:	1141                	add	sp,sp,-16
    80000222:	e422                	sd	s0,8(sp)
    80000224:	0800                	add	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    80000226:	c205                	beqz	a2,80000246 <memmove+0x26>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    80000228:	02a5e263          	bltu	a1,a0,8000024c <memmove+0x2c>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    8000022c:	1602                	sll	a2,a2,0x20
    8000022e:	9201                	srl	a2,a2,0x20
    80000230:	00c587b3          	add	a5,a1,a2
{
    80000234:	872a                	mv	a4,a0
      *d++ = *s++;
    80000236:	0585                	add	a1,a1,1
    80000238:	0705                	add	a4,a4,1 # 1001 <_entry-0x7fffefff>
    8000023a:	fff5c683          	lbu	a3,-1(a1)
    8000023e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    80000242:	fef59ae3          	bne	a1,a5,80000236 <memmove+0x16>

  return dst;
}
    80000246:	6422                	ld	s0,8(sp)
    80000248:	0141                	add	sp,sp,16
    8000024a:	8082                	ret
  if(s < d && s + n > d){
    8000024c:	02061693          	sll	a3,a2,0x20
    80000250:	9281                	srl	a3,a3,0x20
    80000252:	00d58733          	add	a4,a1,a3
    80000256:	fce57be3          	bgeu	a0,a4,8000022c <memmove+0xc>
    d += n;
    8000025a:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    8000025c:	fff6079b          	addw	a5,a2,-1
    80000260:	1782                	sll	a5,a5,0x20
    80000262:	9381                	srl	a5,a5,0x20
    80000264:	fff7c793          	not	a5,a5
    80000268:	97ba                	add	a5,a5,a4
      *--d = *--s;
    8000026a:	177d                	add	a4,a4,-1
    8000026c:	16fd                	add	a3,a3,-1
    8000026e:	00074603          	lbu	a2,0(a4)
    80000272:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    80000276:	fee79ae3          	bne	a5,a4,8000026a <memmove+0x4a>
    8000027a:	b7f1                	j	80000246 <memmove+0x26>

000000008000027c <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    8000027c:	1141                	add	sp,sp,-16
    8000027e:	e406                	sd	ra,8(sp)
    80000280:	e022                	sd	s0,0(sp)
    80000282:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
    80000284:	00000097          	auipc	ra,0x0
    80000288:	f9c080e7          	jalr	-100(ra) # 80000220 <memmove>
}
    8000028c:	60a2                	ld	ra,8(sp)
    8000028e:	6402                	ld	s0,0(sp)
    80000290:	0141                	add	sp,sp,16
    80000292:	8082                	ret

0000000080000294 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000294:	1141                	add	sp,sp,-16
    80000296:	e422                	sd	s0,8(sp)
    80000298:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q)
    8000029a:	ce11                	beqz	a2,800002b6 <strncmp+0x22>
    8000029c:	00054783          	lbu	a5,0(a0)
    800002a0:	cf89                	beqz	a5,800002ba <strncmp+0x26>
    800002a2:	0005c703          	lbu	a4,0(a1)
    800002a6:	00f71a63          	bne	a4,a5,800002ba <strncmp+0x26>
    n--, p++, q++;
    800002aa:	367d                	addw	a2,a2,-1
    800002ac:	0505                	add	a0,a0,1
    800002ae:	0585                	add	a1,a1,1
  while(n > 0 && *p && *p == *q)
    800002b0:	f675                	bnez	a2,8000029c <strncmp+0x8>
  if(n == 0)
    return 0;
    800002b2:	4501                	li	a0,0
    800002b4:	a809                	j	800002c6 <strncmp+0x32>
    800002b6:	4501                	li	a0,0
    800002b8:	a039                	j	800002c6 <strncmp+0x32>
  if(n == 0)
    800002ba:	ca09                	beqz	a2,800002cc <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    800002bc:	00054503          	lbu	a0,0(a0)
    800002c0:	0005c783          	lbu	a5,0(a1)
    800002c4:	9d1d                	subw	a0,a0,a5
}
    800002c6:	6422                	ld	s0,8(sp)
    800002c8:	0141                	add	sp,sp,16
    800002ca:	8082                	ret
    return 0;
    800002cc:	4501                	li	a0,0
    800002ce:	bfe5                	j	800002c6 <strncmp+0x32>

00000000800002d0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    800002d0:	1141                	add	sp,sp,-16
    800002d2:	e422                	sd	s0,8(sp)
    800002d4:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    800002d6:	87aa                	mv	a5,a0
    800002d8:	86b2                	mv	a3,a2
    800002da:	367d                	addw	a2,a2,-1
    800002dc:	00d05963          	blez	a3,800002ee <strncpy+0x1e>
    800002e0:	0785                	add	a5,a5,1
    800002e2:	0005c703          	lbu	a4,0(a1)
    800002e6:	fee78fa3          	sb	a4,-1(a5)
    800002ea:	0585                	add	a1,a1,1
    800002ec:	f775                	bnez	a4,800002d8 <strncpy+0x8>
    ;
  while(n-- > 0)
    800002ee:	873e                	mv	a4,a5
    800002f0:	9fb5                	addw	a5,a5,a3
    800002f2:	37fd                	addw	a5,a5,-1
    800002f4:	00c05963          	blez	a2,80000306 <strncpy+0x36>
    *s++ = 0;
    800002f8:	0705                	add	a4,a4,1
    800002fa:	fe070fa3          	sb	zero,-1(a4)
  while(n-- > 0)
    800002fe:	40e786bb          	subw	a3,a5,a4
    80000302:	fed04be3          	bgtz	a3,800002f8 <strncpy+0x28>
  return os;
}
    80000306:	6422                	ld	s0,8(sp)
    80000308:	0141                	add	sp,sp,16
    8000030a:	8082                	ret

000000008000030c <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    8000030c:	1141                	add	sp,sp,-16
    8000030e:	e422                	sd	s0,8(sp)
    80000310:	0800                	add	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    80000312:	02c05363          	blez	a2,80000338 <safestrcpy+0x2c>
    80000316:	fff6069b          	addw	a3,a2,-1
    8000031a:	1682                	sll	a3,a3,0x20
    8000031c:	9281                	srl	a3,a3,0x20
    8000031e:	96ae                	add	a3,a3,a1
    80000320:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    80000322:	00d58963          	beq	a1,a3,80000334 <safestrcpy+0x28>
    80000326:	0585                	add	a1,a1,1
    80000328:	0785                	add	a5,a5,1
    8000032a:	fff5c703          	lbu	a4,-1(a1)
    8000032e:	fee78fa3          	sb	a4,-1(a5)
    80000332:	fb65                	bnez	a4,80000322 <safestrcpy+0x16>
    ;
  *s = 0;
    80000334:	00078023          	sb	zero,0(a5)
  return os;
}
    80000338:	6422                	ld	s0,8(sp)
    8000033a:	0141                	add	sp,sp,16
    8000033c:	8082                	ret

000000008000033e <strlen>:

int
strlen(const char *s)
{
    8000033e:	1141                	add	sp,sp,-16
    80000340:	e422                	sd	s0,8(sp)
    80000342:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    80000344:	00054783          	lbu	a5,0(a0)
    80000348:	cf91                	beqz	a5,80000364 <strlen+0x26>
    8000034a:	0505                	add	a0,a0,1
    8000034c:	87aa                	mv	a5,a0
    8000034e:	86be                	mv	a3,a5
    80000350:	0785                	add	a5,a5,1
    80000352:	fff7c703          	lbu	a4,-1(a5)
    80000356:	ff65                	bnez	a4,8000034e <strlen+0x10>
    80000358:	40a6853b          	subw	a0,a3,a0
    8000035c:	2505                	addw	a0,a0,1
    ;
  return n;
}
    8000035e:	6422                	ld	s0,8(sp)
    80000360:	0141                	add	sp,sp,16
    80000362:	8082                	ret
  for(n = 0; s[n]; n++)
    80000364:	4501                	li	a0,0
    80000366:	bfe5                	j	8000035e <strlen+0x20>

0000000080000368 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000368:	1141                	add	sp,sp,-16
    8000036a:	e406                	sd	ra,8(sp)
    8000036c:	e022                	sd	s0,0(sp)
    8000036e:	0800                	add	s0,sp,16
  if(cpuid() == 0){
    80000370:	00001097          	auipc	ra,0x1
    80000374:	c2e080e7          	jalr	-978(ra) # 80000f9e <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000378:	00008717          	auipc	a4,0x8
    8000037c:	71870713          	add	a4,a4,1816 # 80008a90 <started>
  if(cpuid() == 0){
    80000380:	c139                	beqz	a0,800003c6 <main+0x5e>
    while(started == 0)
    80000382:	431c                	lw	a5,0(a4)
    80000384:	2781                	sext.w	a5,a5
    80000386:	dff5                	beqz	a5,80000382 <main+0x1a>
      ;
    __sync_synchronize();
    80000388:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    8000038c:	00001097          	auipc	ra,0x1
    80000390:	c12080e7          	jalr	-1006(ra) # 80000f9e <cpuid>
    80000394:	85aa                	mv	a1,a0
    80000396:	00008517          	auipc	a0,0x8
    8000039a:	ca250513          	add	a0,a0,-862 # 80008038 <etext+0x38>
    8000039e:	00006097          	auipc	ra,0x6
    800003a2:	d8c080e7          	jalr	-628(ra) # 8000612a <printf>
    kvminithart();    // turn on paging
    800003a6:	00000097          	auipc	ra,0x0
    800003aa:	0d8080e7          	jalr	216(ra) # 8000047e <kvminithart>
    trapinithart();   // install kernel trap vector
    800003ae:	00002097          	auipc	ra,0x2
    800003b2:	a64080e7          	jalr	-1436(ra) # 80001e12 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    800003b6:	00005097          	auipc	ra,0x5
    800003ba:	17a080e7          	jalr	378(ra) # 80005530 <plicinithart>
  }

  scheduler();        
    800003be:	00001097          	auipc	ra,0x1
    800003c2:	1ca080e7          	jalr	458(ra) # 80001588 <scheduler>
    consoleinit();
    800003c6:	00006097          	auipc	ra,0x6
    800003ca:	c2a080e7          	jalr	-982(ra) # 80005ff0 <consoleinit>
    printfinit();
    800003ce:	00006097          	auipc	ra,0x6
    800003d2:	f3c080e7          	jalr	-196(ra) # 8000630a <printfinit>
    printf("\n");
    800003d6:	00008517          	auipc	a0,0x8
    800003da:	c7250513          	add	a0,a0,-910 # 80008048 <etext+0x48>
    800003de:	00006097          	auipc	ra,0x6
    800003e2:	d4c080e7          	jalr	-692(ra) # 8000612a <printf>
    printf("xv6 kernel is booting\n");
    800003e6:	00008517          	auipc	a0,0x8
    800003ea:	c3a50513          	add	a0,a0,-966 # 80008020 <etext+0x20>
    800003ee:	00006097          	auipc	ra,0x6
    800003f2:	d3c080e7          	jalr	-708(ra) # 8000612a <printf>
    printf("\n");
    800003f6:	00008517          	auipc	a0,0x8
    800003fa:	c5250513          	add	a0,a0,-942 # 80008048 <etext+0x48>
    800003fe:	00006097          	auipc	ra,0x6
    80000402:	d2c080e7          	jalr	-724(ra) # 8000612a <printf>
    kinit();         // physical page allocator
    80000406:	00000097          	auipc	ra,0x0
    8000040a:	cd8080e7          	jalr	-808(ra) # 800000de <kinit>
    kvminit();       // create kernel page table
    8000040e:	00000097          	auipc	ra,0x0
    80000412:	326080e7          	jalr	806(ra) # 80000734 <kvminit>
    kvminithart();   // turn on paging
    80000416:	00000097          	auipc	ra,0x0
    8000041a:	068080e7          	jalr	104(ra) # 8000047e <kvminithart>
    procinit();      // process table
    8000041e:	00001097          	auipc	ra,0x1
    80000422:	ace080e7          	jalr	-1330(ra) # 80000eec <procinit>
    trapinit();      // trap vectors
    80000426:	00002097          	auipc	ra,0x2
    8000042a:	9c4080e7          	jalr	-1596(ra) # 80001dea <trapinit>
    trapinithart();  // install kernel trap vector
    8000042e:	00002097          	auipc	ra,0x2
    80000432:	9e4080e7          	jalr	-1564(ra) # 80001e12 <trapinithart>
    plicinit();      // set up interrupt controller
    80000436:	00005097          	auipc	ra,0x5
    8000043a:	0e4080e7          	jalr	228(ra) # 8000551a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    8000043e:	00005097          	auipc	ra,0x5
    80000442:	0f2080e7          	jalr	242(ra) # 80005530 <plicinithart>
    binit();         // buffer cache
    80000446:	00002097          	auipc	ra,0x2
    8000044a:	2f2080e7          	jalr	754(ra) # 80002738 <binit>
    iinit();         // inode table
    8000044e:	00003097          	auipc	ra,0x3
    80000452:	990080e7          	jalr	-1648(ra) # 80002dde <iinit>
    fileinit();      // file table
    80000456:	00004097          	auipc	ra,0x4
    8000045a:	906080e7          	jalr	-1786(ra) # 80003d5c <fileinit>
    virtio_disk_init(); // emulated hard disk
    8000045e:	00005097          	auipc	ra,0x5
    80000462:	1da080e7          	jalr	474(ra) # 80005638 <virtio_disk_init>
    userinit();      // first user process
    80000466:	00001097          	auipc	ra,0x1
    8000046a:	eea080e7          	jalr	-278(ra) # 80001350 <userinit>
    __sync_synchronize();
    8000046e:	0ff0000f          	fence
    started = 1;
    80000472:	4785                	li	a5,1
    80000474:	00008717          	auipc	a4,0x8
    80000478:	60f72e23          	sw	a5,1564(a4) # 80008a90 <started>
    8000047c:	b789                	j	800003be <main+0x56>

000000008000047e <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    8000047e:	1141                	add	sp,sp,-16
    80000480:	e422                	sd	s0,8(sp)
    80000482:	0800                	add	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80000484:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    80000488:	00008797          	auipc	a5,0x8
    8000048c:	6107b783          	ld	a5,1552(a5) # 80008a98 <kernel_pagetable>
    80000490:	83b1                	srl	a5,a5,0xc
    80000492:	577d                	li	a4,-1
    80000494:	177e                	sll	a4,a4,0x3f
    80000496:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    80000498:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    8000049c:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    800004a0:	6422                	ld	s0,8(sp)
    800004a2:	0141                	add	sp,sp,16
    800004a4:	8082                	ret

00000000800004a6 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    800004a6:	7139                	add	sp,sp,-64
    800004a8:	fc06                	sd	ra,56(sp)
    800004aa:	f822                	sd	s0,48(sp)
    800004ac:	f426                	sd	s1,40(sp)
    800004ae:	f04a                	sd	s2,32(sp)
    800004b0:	ec4e                	sd	s3,24(sp)
    800004b2:	e852                	sd	s4,16(sp)
    800004b4:	e456                	sd	s5,8(sp)
    800004b6:	e05a                	sd	s6,0(sp)
    800004b8:	0080                	add	s0,sp,64
    800004ba:	84aa                	mv	s1,a0
    800004bc:	89ae                	mv	s3,a1
    800004be:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    800004c0:	57fd                	li	a5,-1
    800004c2:	83e9                	srl	a5,a5,0x1a
    800004c4:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    800004c6:	4b31                	li	s6,12
  if(va >= MAXVA)
    800004c8:	04b7f263          	bgeu	a5,a1,8000050c <walk+0x66>
    panic("walk");
    800004cc:	00008517          	auipc	a0,0x8
    800004d0:	b8450513          	add	a0,a0,-1148 # 80008050 <etext+0x50>
    800004d4:	00006097          	auipc	ra,0x6
    800004d8:	c0c080e7          	jalr	-1012(ra) # 800060e0 <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    800004dc:	060a8663          	beqz	s5,80000548 <walk+0xa2>
    800004e0:	00000097          	auipc	ra,0x0
    800004e4:	c84080e7          	jalr	-892(ra) # 80000164 <kalloc>
    800004e8:	84aa                	mv	s1,a0
    800004ea:	c529                	beqz	a0,80000534 <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    800004ec:	6605                	lui	a2,0x1
    800004ee:	4581                	li	a1,0
    800004f0:	00000097          	auipc	ra,0x0
    800004f4:	cd4080e7          	jalr	-812(ra) # 800001c4 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    800004f8:	00c4d793          	srl	a5,s1,0xc
    800004fc:	07aa                	sll	a5,a5,0xa
    800004fe:	0017e793          	or	a5,a5,1
    80000502:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    80000506:	3a5d                	addw	s4,s4,-9 # ffffffffffffeff7 <end+0xffffffff7ffdcc97>
    80000508:	036a0063          	beq	s4,s6,80000528 <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    8000050c:	0149d933          	srl	s2,s3,s4
    80000510:	1ff97913          	and	s2,s2,511
    80000514:	090e                	sll	s2,s2,0x3
    80000516:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    80000518:	00093483          	ld	s1,0(s2)
    8000051c:	0014f793          	and	a5,s1,1
    80000520:	dfd5                	beqz	a5,800004dc <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80000522:	80a9                	srl	s1,s1,0xa
    80000524:	04b2                	sll	s1,s1,0xc
    80000526:	b7c5                	j	80000506 <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    80000528:	00c9d513          	srl	a0,s3,0xc
    8000052c:	1ff57513          	and	a0,a0,511
    80000530:	050e                	sll	a0,a0,0x3
    80000532:	9526                	add	a0,a0,s1
}
    80000534:	70e2                	ld	ra,56(sp)
    80000536:	7442                	ld	s0,48(sp)
    80000538:	74a2                	ld	s1,40(sp)
    8000053a:	7902                	ld	s2,32(sp)
    8000053c:	69e2                	ld	s3,24(sp)
    8000053e:	6a42                	ld	s4,16(sp)
    80000540:	6aa2                	ld	s5,8(sp)
    80000542:	6b02                	ld	s6,0(sp)
    80000544:	6121                	add	sp,sp,64
    80000546:	8082                	ret
        return 0;
    80000548:	4501                	li	a0,0
    8000054a:	b7ed                	j	80000534 <walk+0x8e>

000000008000054c <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    8000054c:	57fd                	li	a5,-1
    8000054e:	83e9                	srl	a5,a5,0x1a
    80000550:	00b7f463          	bgeu	a5,a1,80000558 <walkaddr+0xc>
    return 0;
    80000554:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80000556:	8082                	ret
{
    80000558:	1141                	add	sp,sp,-16
    8000055a:	e406                	sd	ra,8(sp)
    8000055c:	e022                	sd	s0,0(sp)
    8000055e:	0800                	add	s0,sp,16
  pte = walk(pagetable, va, 0);
    80000560:	4601                	li	a2,0
    80000562:	00000097          	auipc	ra,0x0
    80000566:	f44080e7          	jalr	-188(ra) # 800004a6 <walk>
  if(pte == 0)
    8000056a:	c105                	beqz	a0,8000058a <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    8000056c:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    8000056e:	0117f693          	and	a3,a5,17
    80000572:	4745                	li	a4,17
    return 0;
    80000574:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    80000576:	00e68663          	beq	a3,a4,80000582 <walkaddr+0x36>
}
    8000057a:	60a2                	ld	ra,8(sp)
    8000057c:	6402                	ld	s0,0(sp)
    8000057e:	0141                	add	sp,sp,16
    80000580:	8082                	ret
  pa = PTE2PA(*pte);
    80000582:	83a9                	srl	a5,a5,0xa
    80000584:	00c79513          	sll	a0,a5,0xc
  return pa;
    80000588:	bfcd                	j	8000057a <walkaddr+0x2e>
    return 0;
    8000058a:	4501                	li	a0,0
    8000058c:	b7fd                	j	8000057a <walkaddr+0x2e>

000000008000058e <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    8000058e:	715d                	add	sp,sp,-80
    80000590:	e486                	sd	ra,72(sp)
    80000592:	e0a2                	sd	s0,64(sp)
    80000594:	fc26                	sd	s1,56(sp)
    80000596:	f84a                	sd	s2,48(sp)
    80000598:	f44e                	sd	s3,40(sp)
    8000059a:	f052                	sd	s4,32(sp)
    8000059c:	ec56                	sd	s5,24(sp)
    8000059e:	e85a                	sd	s6,16(sp)
    800005a0:	e45e                	sd	s7,8(sp)
    800005a2:	0880                	add	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    800005a4:	c639                	beqz	a2,800005f2 <mappages+0x64>
    800005a6:	8aaa                	mv	s5,a0
    800005a8:	8b3a                	mv	s6,a4
    panic("mappages: size");
  
  a = PGROUNDDOWN(va);
    800005aa:	777d                	lui	a4,0xfffff
    800005ac:	00e5f7b3          	and	a5,a1,a4
  last = PGROUNDDOWN(va + size - 1);
    800005b0:	fff58993          	add	s3,a1,-1
    800005b4:	99b2                	add	s3,s3,a2
    800005b6:	00e9f9b3          	and	s3,s3,a4
  a = PGROUNDDOWN(va);
    800005ba:	893e                	mv	s2,a5
    800005bc:	40f68a33          	sub	s4,a3,a5
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    800005c0:	6b85                	lui	s7,0x1
    800005c2:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    800005c6:	4605                	li	a2,1
    800005c8:	85ca                	mv	a1,s2
    800005ca:	8556                	mv	a0,s5
    800005cc:	00000097          	auipc	ra,0x0
    800005d0:	eda080e7          	jalr	-294(ra) # 800004a6 <walk>
    800005d4:	cd1d                	beqz	a0,80000612 <mappages+0x84>
    if(*pte & PTE_V)
    800005d6:	611c                	ld	a5,0(a0)
    800005d8:	8b85                	and	a5,a5,1
    800005da:	e785                	bnez	a5,80000602 <mappages+0x74>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800005dc:	80b1                	srl	s1,s1,0xc
    800005de:	04aa                	sll	s1,s1,0xa
    800005e0:	0164e4b3          	or	s1,s1,s6
    800005e4:	0014e493          	or	s1,s1,1
    800005e8:	e104                	sd	s1,0(a0)
    if(a == last)
    800005ea:	05390063          	beq	s2,s3,8000062a <mappages+0x9c>
    a += PGSIZE;
    800005ee:	995e                	add	s2,s2,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    800005f0:	bfc9                	j	800005c2 <mappages+0x34>
    panic("mappages: size");
    800005f2:	00008517          	auipc	a0,0x8
    800005f6:	a6650513          	add	a0,a0,-1434 # 80008058 <etext+0x58>
    800005fa:	00006097          	auipc	ra,0x6
    800005fe:	ae6080e7          	jalr	-1306(ra) # 800060e0 <panic>
      panic("mappages: remap");
    80000602:	00008517          	auipc	a0,0x8
    80000606:	a6650513          	add	a0,a0,-1434 # 80008068 <etext+0x68>
    8000060a:	00006097          	auipc	ra,0x6
    8000060e:	ad6080e7          	jalr	-1322(ra) # 800060e0 <panic>
      return -1;
    80000612:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    80000614:	60a6                	ld	ra,72(sp)
    80000616:	6406                	ld	s0,64(sp)
    80000618:	74e2                	ld	s1,56(sp)
    8000061a:	7942                	ld	s2,48(sp)
    8000061c:	79a2                	ld	s3,40(sp)
    8000061e:	7a02                	ld	s4,32(sp)
    80000620:	6ae2                	ld	s5,24(sp)
    80000622:	6b42                	ld	s6,16(sp)
    80000624:	6ba2                	ld	s7,8(sp)
    80000626:	6161                	add	sp,sp,80
    80000628:	8082                	ret
  return 0;
    8000062a:	4501                	li	a0,0
    8000062c:	b7e5                	j	80000614 <mappages+0x86>

000000008000062e <kvmmap>:
{
    8000062e:	1141                	add	sp,sp,-16
    80000630:	e406                	sd	ra,8(sp)
    80000632:	e022                	sd	s0,0(sp)
    80000634:	0800                	add	s0,sp,16
    80000636:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80000638:	86b2                	mv	a3,a2
    8000063a:	863e                	mv	a2,a5
    8000063c:	00000097          	auipc	ra,0x0
    80000640:	f52080e7          	jalr	-174(ra) # 8000058e <mappages>
    80000644:	e509                	bnez	a0,8000064e <kvmmap+0x20>
}
    80000646:	60a2                	ld	ra,8(sp)
    80000648:	6402                	ld	s0,0(sp)
    8000064a:	0141                	add	sp,sp,16
    8000064c:	8082                	ret
    panic("kvmmap");
    8000064e:	00008517          	auipc	a0,0x8
    80000652:	a2a50513          	add	a0,a0,-1494 # 80008078 <etext+0x78>
    80000656:	00006097          	auipc	ra,0x6
    8000065a:	a8a080e7          	jalr	-1398(ra) # 800060e0 <panic>

000000008000065e <kvmmake>:
{
    8000065e:	1101                	add	sp,sp,-32
    80000660:	ec06                	sd	ra,24(sp)
    80000662:	e822                	sd	s0,16(sp)
    80000664:	e426                	sd	s1,8(sp)
    80000666:	e04a                	sd	s2,0(sp)
    80000668:	1000                	add	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    8000066a:	00000097          	auipc	ra,0x0
    8000066e:	afa080e7          	jalr	-1286(ra) # 80000164 <kalloc>
    80000672:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    80000674:	6605                	lui	a2,0x1
    80000676:	4581                	li	a1,0
    80000678:	00000097          	auipc	ra,0x0
    8000067c:	b4c080e7          	jalr	-1204(ra) # 800001c4 <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80000680:	4719                	li	a4,6
    80000682:	6685                	lui	a3,0x1
    80000684:	10000637          	lui	a2,0x10000
    80000688:	100005b7          	lui	a1,0x10000
    8000068c:	8526                	mv	a0,s1
    8000068e:	00000097          	auipc	ra,0x0
    80000692:	fa0080e7          	jalr	-96(ra) # 8000062e <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    80000696:	4719                	li	a4,6
    80000698:	6685                	lui	a3,0x1
    8000069a:	10001637          	lui	a2,0x10001
    8000069e:	100015b7          	lui	a1,0x10001
    800006a2:	8526                	mv	a0,s1
    800006a4:	00000097          	auipc	ra,0x0
    800006a8:	f8a080e7          	jalr	-118(ra) # 8000062e <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    800006ac:	4719                	li	a4,6
    800006ae:	004006b7          	lui	a3,0x400
    800006b2:	0c000637          	lui	a2,0xc000
    800006b6:	0c0005b7          	lui	a1,0xc000
    800006ba:	8526                	mv	a0,s1
    800006bc:	00000097          	auipc	ra,0x0
    800006c0:	f72080e7          	jalr	-142(ra) # 8000062e <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800006c4:	00008917          	auipc	s2,0x8
    800006c8:	93c90913          	add	s2,s2,-1732 # 80008000 <etext>
    800006cc:	4729                	li	a4,10
    800006ce:	80008697          	auipc	a3,0x80008
    800006d2:	93268693          	add	a3,a3,-1742 # 8000 <_entry-0x7fff8000>
    800006d6:	4605                	li	a2,1
    800006d8:	067e                	sll	a2,a2,0x1f
    800006da:	85b2                	mv	a1,a2
    800006dc:	8526                	mv	a0,s1
    800006de:	00000097          	auipc	ra,0x0
    800006e2:	f50080e7          	jalr	-176(ra) # 8000062e <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800006e6:	4719                	li	a4,6
    800006e8:	46c5                	li	a3,17
    800006ea:	06ee                	sll	a3,a3,0x1b
    800006ec:	412686b3          	sub	a3,a3,s2
    800006f0:	864a                	mv	a2,s2
    800006f2:	85ca                	mv	a1,s2
    800006f4:	8526                	mv	a0,s1
    800006f6:	00000097          	auipc	ra,0x0
    800006fa:	f38080e7          	jalr	-200(ra) # 8000062e <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800006fe:	4729                	li	a4,10
    80000700:	6685                	lui	a3,0x1
    80000702:	00007617          	auipc	a2,0x7
    80000706:	8fe60613          	add	a2,a2,-1794 # 80007000 <_trampoline>
    8000070a:	040005b7          	lui	a1,0x4000
    8000070e:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000710:	05b2                	sll	a1,a1,0xc
    80000712:	8526                	mv	a0,s1
    80000714:	00000097          	auipc	ra,0x0
    80000718:	f1a080e7          	jalr	-230(ra) # 8000062e <kvmmap>
  proc_mapstacks(kpgtbl);
    8000071c:	8526                	mv	a0,s1
    8000071e:	00000097          	auipc	ra,0x0
    80000722:	73a080e7          	jalr	1850(ra) # 80000e58 <proc_mapstacks>
}
    80000726:	8526                	mv	a0,s1
    80000728:	60e2                	ld	ra,24(sp)
    8000072a:	6442                	ld	s0,16(sp)
    8000072c:	64a2                	ld	s1,8(sp)
    8000072e:	6902                	ld	s2,0(sp)
    80000730:	6105                	add	sp,sp,32
    80000732:	8082                	ret

0000000080000734 <kvminit>:
{
    80000734:	1141                	add	sp,sp,-16
    80000736:	e406                	sd	ra,8(sp)
    80000738:	e022                	sd	s0,0(sp)
    8000073a:	0800                	add	s0,sp,16
  kernel_pagetable = kvmmake();
    8000073c:	00000097          	auipc	ra,0x0
    80000740:	f22080e7          	jalr	-222(ra) # 8000065e <kvmmake>
    80000744:	00008797          	auipc	a5,0x8
    80000748:	34a7ba23          	sd	a0,852(a5) # 80008a98 <kernel_pagetable>
}
    8000074c:	60a2                	ld	ra,8(sp)
    8000074e:	6402                	ld	s0,0(sp)
    80000750:	0141                	add	sp,sp,16
    80000752:	8082                	ret

0000000080000754 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80000754:	715d                	add	sp,sp,-80
    80000756:	e486                	sd	ra,72(sp)
    80000758:	e0a2                	sd	s0,64(sp)
    8000075a:	fc26                	sd	s1,56(sp)
    8000075c:	f84a                	sd	s2,48(sp)
    8000075e:	f44e                	sd	s3,40(sp)
    80000760:	f052                	sd	s4,32(sp)
    80000762:	ec56                	sd	s5,24(sp)
    80000764:	e85a                	sd	s6,16(sp)
    80000766:	e45e                	sd	s7,8(sp)
    80000768:	0880                	add	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    8000076a:	03459793          	sll	a5,a1,0x34
    8000076e:	e795                	bnez	a5,8000079a <uvmunmap+0x46>
    80000770:	8a2a                	mv	s4,a0
    80000772:	892e                	mv	s2,a1
    80000774:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000776:	0632                	sll	a2,a2,0xc
    80000778:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    8000077c:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    8000077e:	6b05                	lui	s6,0x1
    80000780:	0735e263          	bltu	a1,s3,800007e4 <uvmunmap+0x90>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    80000784:	60a6                	ld	ra,72(sp)
    80000786:	6406                	ld	s0,64(sp)
    80000788:	74e2                	ld	s1,56(sp)
    8000078a:	7942                	ld	s2,48(sp)
    8000078c:	79a2                	ld	s3,40(sp)
    8000078e:	7a02                	ld	s4,32(sp)
    80000790:	6ae2                	ld	s5,24(sp)
    80000792:	6b42                	ld	s6,16(sp)
    80000794:	6ba2                	ld	s7,8(sp)
    80000796:	6161                	add	sp,sp,80
    80000798:	8082                	ret
    panic("uvmunmap: not aligned");
    8000079a:	00008517          	auipc	a0,0x8
    8000079e:	8e650513          	add	a0,a0,-1818 # 80008080 <etext+0x80>
    800007a2:	00006097          	auipc	ra,0x6
    800007a6:	93e080e7          	jalr	-1730(ra) # 800060e0 <panic>
      panic("uvmunmap: walk");
    800007aa:	00008517          	auipc	a0,0x8
    800007ae:	8ee50513          	add	a0,a0,-1810 # 80008098 <etext+0x98>
    800007b2:	00006097          	auipc	ra,0x6
    800007b6:	92e080e7          	jalr	-1746(ra) # 800060e0 <panic>
      panic("uvmunmap: not mapped");
    800007ba:	00008517          	auipc	a0,0x8
    800007be:	8ee50513          	add	a0,a0,-1810 # 800080a8 <etext+0xa8>
    800007c2:	00006097          	auipc	ra,0x6
    800007c6:	91e080e7          	jalr	-1762(ra) # 800060e0 <panic>
      panic("uvmunmap: not a leaf");
    800007ca:	00008517          	auipc	a0,0x8
    800007ce:	8f650513          	add	a0,a0,-1802 # 800080c0 <etext+0xc0>
    800007d2:	00006097          	auipc	ra,0x6
    800007d6:	90e080e7          	jalr	-1778(ra) # 800060e0 <panic>
    *pte = 0;
    800007da:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800007de:	995a                	add	s2,s2,s6
    800007e0:	fb3972e3          	bgeu	s2,s3,80000784 <uvmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    800007e4:	4601                	li	a2,0
    800007e6:	85ca                	mv	a1,s2
    800007e8:	8552                	mv	a0,s4
    800007ea:	00000097          	auipc	ra,0x0
    800007ee:	cbc080e7          	jalr	-836(ra) # 800004a6 <walk>
    800007f2:	84aa                	mv	s1,a0
    800007f4:	d95d                	beqz	a0,800007aa <uvmunmap+0x56>
    if((*pte & PTE_V) == 0)
    800007f6:	6108                	ld	a0,0(a0)
    800007f8:	00157793          	and	a5,a0,1
    800007fc:	dfdd                	beqz	a5,800007ba <uvmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V)
    800007fe:	3ff57793          	and	a5,a0,1023
    80000802:	fd7784e3          	beq	a5,s7,800007ca <uvmunmap+0x76>
    if(do_free){
    80000806:	fc0a8ae3          	beqz	s5,800007da <uvmunmap+0x86>
      uint64 pa = PTE2PA(*pte);
    8000080a:	8129                	srl	a0,a0,0xa
      kfree((void*)pa);
    8000080c:	0532                	sll	a0,a0,0xc
    8000080e:	00000097          	auipc	ra,0x0
    80000812:	80e080e7          	jalr	-2034(ra) # 8000001c <kfree>
    80000816:	b7d1                	j	800007da <uvmunmap+0x86>

0000000080000818 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80000818:	1101                	add	sp,sp,-32
    8000081a:	ec06                	sd	ra,24(sp)
    8000081c:	e822                	sd	s0,16(sp)
    8000081e:	e426                	sd	s1,8(sp)
    80000820:	1000                	add	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80000822:	00000097          	auipc	ra,0x0
    80000826:	942080e7          	jalr	-1726(ra) # 80000164 <kalloc>
    8000082a:	84aa                	mv	s1,a0
  if(pagetable == 0)
    8000082c:	c519                	beqz	a0,8000083a <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    8000082e:	6605                	lui	a2,0x1
    80000830:	4581                	li	a1,0
    80000832:	00000097          	auipc	ra,0x0
    80000836:	992080e7          	jalr	-1646(ra) # 800001c4 <memset>
  return pagetable;
}
    8000083a:	8526                	mv	a0,s1
    8000083c:	60e2                	ld	ra,24(sp)
    8000083e:	6442                	ld	s0,16(sp)
    80000840:	64a2                	ld	s1,8(sp)
    80000842:	6105                	add	sp,sp,32
    80000844:	8082                	ret

0000000080000846 <uvmfirst>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvmfirst(pagetable_t pagetable, uchar *src, uint sz)
{
    80000846:	7179                	add	sp,sp,-48
    80000848:	f406                	sd	ra,40(sp)
    8000084a:	f022                	sd	s0,32(sp)
    8000084c:	ec26                	sd	s1,24(sp)
    8000084e:	e84a                	sd	s2,16(sp)
    80000850:	e44e                	sd	s3,8(sp)
    80000852:	e052                	sd	s4,0(sp)
    80000854:	1800                	add	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    80000856:	6785                	lui	a5,0x1
    80000858:	04f67863          	bgeu	a2,a5,800008a8 <uvmfirst+0x62>
    8000085c:	8a2a                	mv	s4,a0
    8000085e:	89ae                	mv	s3,a1
    80000860:	84b2                	mv	s1,a2
    panic("uvmfirst: more than a page");
  mem = kalloc();
    80000862:	00000097          	auipc	ra,0x0
    80000866:	902080e7          	jalr	-1790(ra) # 80000164 <kalloc>
    8000086a:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    8000086c:	6605                	lui	a2,0x1
    8000086e:	4581                	li	a1,0
    80000870:	00000097          	auipc	ra,0x0
    80000874:	954080e7          	jalr	-1708(ra) # 800001c4 <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80000878:	4779                	li	a4,30
    8000087a:	86ca                	mv	a3,s2
    8000087c:	6605                	lui	a2,0x1
    8000087e:	4581                	li	a1,0
    80000880:	8552                	mv	a0,s4
    80000882:	00000097          	auipc	ra,0x0
    80000886:	d0c080e7          	jalr	-756(ra) # 8000058e <mappages>
  memmove(mem, src, sz);
    8000088a:	8626                	mv	a2,s1
    8000088c:	85ce                	mv	a1,s3
    8000088e:	854a                	mv	a0,s2
    80000890:	00000097          	auipc	ra,0x0
    80000894:	990080e7          	jalr	-1648(ra) # 80000220 <memmove>
}
    80000898:	70a2                	ld	ra,40(sp)
    8000089a:	7402                	ld	s0,32(sp)
    8000089c:	64e2                	ld	s1,24(sp)
    8000089e:	6942                	ld	s2,16(sp)
    800008a0:	69a2                	ld	s3,8(sp)
    800008a2:	6a02                	ld	s4,0(sp)
    800008a4:	6145                	add	sp,sp,48
    800008a6:	8082                	ret
    panic("uvmfirst: more than a page");
    800008a8:	00008517          	auipc	a0,0x8
    800008ac:	83050513          	add	a0,a0,-2000 # 800080d8 <etext+0xd8>
    800008b0:	00006097          	auipc	ra,0x6
    800008b4:	830080e7          	jalr	-2000(ra) # 800060e0 <panic>

00000000800008b8 <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    800008b8:	1101                	add	sp,sp,-32
    800008ba:	ec06                	sd	ra,24(sp)
    800008bc:	e822                	sd	s0,16(sp)
    800008be:	e426                	sd	s1,8(sp)
    800008c0:	1000                	add	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    800008c2:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    800008c4:	00b67d63          	bgeu	a2,a1,800008de <uvmdealloc+0x26>
    800008c8:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    800008ca:	6785                	lui	a5,0x1
    800008cc:	17fd                	add	a5,a5,-1 # fff <_entry-0x7ffff001>
    800008ce:	00f60733          	add	a4,a2,a5
    800008d2:	76fd                	lui	a3,0xfffff
    800008d4:	8f75                	and	a4,a4,a3
    800008d6:	97ae                	add	a5,a5,a1
    800008d8:	8ff5                	and	a5,a5,a3
    800008da:	00f76863          	bltu	a4,a5,800008ea <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    800008de:	8526                	mv	a0,s1
    800008e0:	60e2                	ld	ra,24(sp)
    800008e2:	6442                	ld	s0,16(sp)
    800008e4:	64a2                	ld	s1,8(sp)
    800008e6:	6105                	add	sp,sp,32
    800008e8:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    800008ea:	8f99                	sub	a5,a5,a4
    800008ec:	83b1                	srl	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800008ee:	4685                	li	a3,1
    800008f0:	0007861b          	sext.w	a2,a5
    800008f4:	85ba                	mv	a1,a4
    800008f6:	00000097          	auipc	ra,0x0
    800008fa:	e5e080e7          	jalr	-418(ra) # 80000754 <uvmunmap>
    800008fe:	b7c5                	j	800008de <uvmdealloc+0x26>

0000000080000900 <uvmalloc>:
  if(newsz < oldsz)
    80000900:	0ab66563          	bltu	a2,a1,800009aa <uvmalloc+0xaa>
{
    80000904:	7139                	add	sp,sp,-64
    80000906:	fc06                	sd	ra,56(sp)
    80000908:	f822                	sd	s0,48(sp)
    8000090a:	f426                	sd	s1,40(sp)
    8000090c:	f04a                	sd	s2,32(sp)
    8000090e:	ec4e                	sd	s3,24(sp)
    80000910:	e852                	sd	s4,16(sp)
    80000912:	e456                	sd	s5,8(sp)
    80000914:	e05a                	sd	s6,0(sp)
    80000916:	0080                	add	s0,sp,64
    80000918:	8aaa                	mv	s5,a0
    8000091a:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    8000091c:	6785                	lui	a5,0x1
    8000091e:	17fd                	add	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000920:	95be                	add	a1,a1,a5
    80000922:	77fd                	lui	a5,0xfffff
    80000924:	00f5f9b3          	and	s3,a1,a5
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000928:	08c9f363          	bgeu	s3,a2,800009ae <uvmalloc+0xae>
    8000092c:	894e                	mv	s2,s3
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    8000092e:	0126eb13          	or	s6,a3,18
    mem = kalloc();
    80000932:	00000097          	auipc	ra,0x0
    80000936:	832080e7          	jalr	-1998(ra) # 80000164 <kalloc>
    8000093a:	84aa                	mv	s1,a0
    if(mem == 0){
    8000093c:	c51d                	beqz	a0,8000096a <uvmalloc+0x6a>
    memset(mem, 0, PGSIZE);
    8000093e:	6605                	lui	a2,0x1
    80000940:	4581                	li	a1,0
    80000942:	00000097          	auipc	ra,0x0
    80000946:	882080e7          	jalr	-1918(ra) # 800001c4 <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    8000094a:	875a                	mv	a4,s6
    8000094c:	86a6                	mv	a3,s1
    8000094e:	6605                	lui	a2,0x1
    80000950:	85ca                	mv	a1,s2
    80000952:	8556                	mv	a0,s5
    80000954:	00000097          	auipc	ra,0x0
    80000958:	c3a080e7          	jalr	-966(ra) # 8000058e <mappages>
    8000095c:	e90d                	bnez	a0,8000098e <uvmalloc+0x8e>
  for(a = oldsz; a < newsz; a += PGSIZE){
    8000095e:	6785                	lui	a5,0x1
    80000960:	993e                	add	s2,s2,a5
    80000962:	fd4968e3          	bltu	s2,s4,80000932 <uvmalloc+0x32>
  return newsz;
    80000966:	8552                	mv	a0,s4
    80000968:	a809                	j	8000097a <uvmalloc+0x7a>
      uvmdealloc(pagetable, a, oldsz);
    8000096a:	864e                	mv	a2,s3
    8000096c:	85ca                	mv	a1,s2
    8000096e:	8556                	mv	a0,s5
    80000970:	00000097          	auipc	ra,0x0
    80000974:	f48080e7          	jalr	-184(ra) # 800008b8 <uvmdealloc>
      return 0;
    80000978:	4501                	li	a0,0
}
    8000097a:	70e2                	ld	ra,56(sp)
    8000097c:	7442                	ld	s0,48(sp)
    8000097e:	74a2                	ld	s1,40(sp)
    80000980:	7902                	ld	s2,32(sp)
    80000982:	69e2                	ld	s3,24(sp)
    80000984:	6a42                	ld	s4,16(sp)
    80000986:	6aa2                	ld	s5,8(sp)
    80000988:	6b02                	ld	s6,0(sp)
    8000098a:	6121                	add	sp,sp,64
    8000098c:	8082                	ret
      kfree(mem);
    8000098e:	8526                	mv	a0,s1
    80000990:	fffff097          	auipc	ra,0xfffff
    80000994:	68c080e7          	jalr	1676(ra) # 8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80000998:	864e                	mv	a2,s3
    8000099a:	85ca                	mv	a1,s2
    8000099c:	8556                	mv	a0,s5
    8000099e:	00000097          	auipc	ra,0x0
    800009a2:	f1a080e7          	jalr	-230(ra) # 800008b8 <uvmdealloc>
      return 0;
    800009a6:	4501                	li	a0,0
    800009a8:	bfc9                	j	8000097a <uvmalloc+0x7a>
    return oldsz;
    800009aa:	852e                	mv	a0,a1
}
    800009ac:	8082                	ret
  return newsz;
    800009ae:	8532                	mv	a0,a2
    800009b0:	b7e9                	j	8000097a <uvmalloc+0x7a>

00000000800009b2 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    800009b2:	7179                	add	sp,sp,-48
    800009b4:	f406                	sd	ra,40(sp)
    800009b6:	f022                	sd	s0,32(sp)
    800009b8:	ec26                	sd	s1,24(sp)
    800009ba:	e84a                	sd	s2,16(sp)
    800009bc:	e44e                	sd	s3,8(sp)
    800009be:	e052                	sd	s4,0(sp)
    800009c0:	1800                	add	s0,sp,48
    800009c2:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    800009c4:	84aa                	mv	s1,a0
    800009c6:	6905                	lui	s2,0x1
    800009c8:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800009ca:	4985                	li	s3,1
    800009cc:	a829                	j	800009e6 <freewalk+0x34>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    800009ce:	83a9                	srl	a5,a5,0xa
      freewalk((pagetable_t)child);
    800009d0:	00c79513          	sll	a0,a5,0xc
    800009d4:	00000097          	auipc	ra,0x0
    800009d8:	fde080e7          	jalr	-34(ra) # 800009b2 <freewalk>
      pagetable[i] = 0;
    800009dc:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    800009e0:	04a1                	add	s1,s1,8
    800009e2:	03248163          	beq	s1,s2,80000a04 <freewalk+0x52>
    pte_t pte = pagetable[i];
    800009e6:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800009e8:	00f7f713          	and	a4,a5,15
    800009ec:	ff3701e3          	beq	a4,s3,800009ce <freewalk+0x1c>
    } else if(pte & PTE_V){
    800009f0:	8b85                	and	a5,a5,1
    800009f2:	d7fd                	beqz	a5,800009e0 <freewalk+0x2e>
      panic("freewalk: leaf");
    800009f4:	00007517          	auipc	a0,0x7
    800009f8:	70450513          	add	a0,a0,1796 # 800080f8 <etext+0xf8>
    800009fc:	00005097          	auipc	ra,0x5
    80000a00:	6e4080e7          	jalr	1764(ra) # 800060e0 <panic>
    }
  }
  kfree((void*)pagetable);
    80000a04:	8552                	mv	a0,s4
    80000a06:	fffff097          	auipc	ra,0xfffff
    80000a0a:	616080e7          	jalr	1558(ra) # 8000001c <kfree>
}
    80000a0e:	70a2                	ld	ra,40(sp)
    80000a10:	7402                	ld	s0,32(sp)
    80000a12:	64e2                	ld	s1,24(sp)
    80000a14:	6942                	ld	s2,16(sp)
    80000a16:	69a2                	ld	s3,8(sp)
    80000a18:	6a02                	ld	s4,0(sp)
    80000a1a:	6145                	add	sp,sp,48
    80000a1c:	8082                	ret

0000000080000a1e <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80000a1e:	1101                	add	sp,sp,-32
    80000a20:	ec06                	sd	ra,24(sp)
    80000a22:	e822                	sd	s0,16(sp)
    80000a24:	e426                	sd	s1,8(sp)
    80000a26:	1000                	add	s0,sp,32
    80000a28:	84aa                	mv	s1,a0
  if(sz > 0)
    80000a2a:	e999                	bnez	a1,80000a40 <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80000a2c:	8526                	mv	a0,s1
    80000a2e:	00000097          	auipc	ra,0x0
    80000a32:	f84080e7          	jalr	-124(ra) # 800009b2 <freewalk>
}
    80000a36:	60e2                	ld	ra,24(sp)
    80000a38:	6442                	ld	s0,16(sp)
    80000a3a:	64a2                	ld	s1,8(sp)
    80000a3c:	6105                	add	sp,sp,32
    80000a3e:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80000a40:	6785                	lui	a5,0x1
    80000a42:	17fd                	add	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000a44:	95be                	add	a1,a1,a5
    80000a46:	4685                	li	a3,1
    80000a48:	00c5d613          	srl	a2,a1,0xc
    80000a4c:	4581                	li	a1,0
    80000a4e:	00000097          	auipc	ra,0x0
    80000a52:	d06080e7          	jalr	-762(ra) # 80000754 <uvmunmap>
    80000a56:	bfd9                	j	80000a2c <uvmfree+0xe>

0000000080000a58 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80000a58:	c679                	beqz	a2,80000b26 <uvmcopy+0xce>
{
    80000a5a:	715d                	add	sp,sp,-80
    80000a5c:	e486                	sd	ra,72(sp)
    80000a5e:	e0a2                	sd	s0,64(sp)
    80000a60:	fc26                	sd	s1,56(sp)
    80000a62:	f84a                	sd	s2,48(sp)
    80000a64:	f44e                	sd	s3,40(sp)
    80000a66:	f052                	sd	s4,32(sp)
    80000a68:	ec56                	sd	s5,24(sp)
    80000a6a:	e85a                	sd	s6,16(sp)
    80000a6c:	e45e                	sd	s7,8(sp)
    80000a6e:	0880                	add	s0,sp,80
    80000a70:	8b2a                	mv	s6,a0
    80000a72:	8aae                	mv	s5,a1
    80000a74:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    80000a76:	4981                	li	s3,0
    if((pte = walk(old, i, 0)) == 0)
    80000a78:	4601                	li	a2,0
    80000a7a:	85ce                	mv	a1,s3
    80000a7c:	855a                	mv	a0,s6
    80000a7e:	00000097          	auipc	ra,0x0
    80000a82:	a28080e7          	jalr	-1496(ra) # 800004a6 <walk>
    80000a86:	c531                	beqz	a0,80000ad2 <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    80000a88:	6118                	ld	a4,0(a0)
    80000a8a:	00177793          	and	a5,a4,1
    80000a8e:	cbb1                	beqz	a5,80000ae2 <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    80000a90:	00a75593          	srl	a1,a4,0xa
    80000a94:	00c59b93          	sll	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    80000a98:	3ff77493          	and	s1,a4,1023
    if((mem = kalloc()) == 0)
    80000a9c:	fffff097          	auipc	ra,0xfffff
    80000aa0:	6c8080e7          	jalr	1736(ra) # 80000164 <kalloc>
    80000aa4:	892a                	mv	s2,a0
    80000aa6:	c939                	beqz	a0,80000afc <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    80000aa8:	6605                	lui	a2,0x1
    80000aaa:	85de                	mv	a1,s7
    80000aac:	fffff097          	auipc	ra,0xfffff
    80000ab0:	774080e7          	jalr	1908(ra) # 80000220 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80000ab4:	8726                	mv	a4,s1
    80000ab6:	86ca                	mv	a3,s2
    80000ab8:	6605                	lui	a2,0x1
    80000aba:	85ce                	mv	a1,s3
    80000abc:	8556                	mv	a0,s5
    80000abe:	00000097          	auipc	ra,0x0
    80000ac2:	ad0080e7          	jalr	-1328(ra) # 8000058e <mappages>
    80000ac6:	e515                	bnez	a0,80000af2 <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    80000ac8:	6785                	lui	a5,0x1
    80000aca:	99be                	add	s3,s3,a5
    80000acc:	fb49e6e3          	bltu	s3,s4,80000a78 <uvmcopy+0x20>
    80000ad0:	a081                	j	80000b10 <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    80000ad2:	00007517          	auipc	a0,0x7
    80000ad6:	63650513          	add	a0,a0,1590 # 80008108 <etext+0x108>
    80000ada:	00005097          	auipc	ra,0x5
    80000ade:	606080e7          	jalr	1542(ra) # 800060e0 <panic>
      panic("uvmcopy: page not present");
    80000ae2:	00007517          	auipc	a0,0x7
    80000ae6:	64650513          	add	a0,a0,1606 # 80008128 <etext+0x128>
    80000aea:	00005097          	auipc	ra,0x5
    80000aee:	5f6080e7          	jalr	1526(ra) # 800060e0 <panic>
      kfree(mem);
    80000af2:	854a                	mv	a0,s2
    80000af4:	fffff097          	auipc	ra,0xfffff
    80000af8:	528080e7          	jalr	1320(ra) # 8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80000afc:	4685                	li	a3,1
    80000afe:	00c9d613          	srl	a2,s3,0xc
    80000b02:	4581                	li	a1,0
    80000b04:	8556                	mv	a0,s5
    80000b06:	00000097          	auipc	ra,0x0
    80000b0a:	c4e080e7          	jalr	-946(ra) # 80000754 <uvmunmap>
  return -1;
    80000b0e:	557d                	li	a0,-1
}
    80000b10:	60a6                	ld	ra,72(sp)
    80000b12:	6406                	ld	s0,64(sp)
    80000b14:	74e2                	ld	s1,56(sp)
    80000b16:	7942                	ld	s2,48(sp)
    80000b18:	79a2                	ld	s3,40(sp)
    80000b1a:	7a02                	ld	s4,32(sp)
    80000b1c:	6ae2                	ld	s5,24(sp)
    80000b1e:	6b42                	ld	s6,16(sp)
    80000b20:	6ba2                	ld	s7,8(sp)
    80000b22:	6161                	add	sp,sp,80
    80000b24:	8082                	ret
  return 0;
    80000b26:	4501                	li	a0,0
}
    80000b28:	8082                	ret

0000000080000b2a <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80000b2a:	1141                	add	sp,sp,-16
    80000b2c:	e406                	sd	ra,8(sp)
    80000b2e:	e022                	sd	s0,0(sp)
    80000b30:	0800                	add	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80000b32:	4601                	li	a2,0
    80000b34:	00000097          	auipc	ra,0x0
    80000b38:	972080e7          	jalr	-1678(ra) # 800004a6 <walk>
  if(pte == 0)
    80000b3c:	c901                	beqz	a0,80000b4c <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000b3e:	611c                	ld	a5,0(a0)
    80000b40:	9bbd                	and	a5,a5,-17
    80000b42:	e11c                	sd	a5,0(a0)
}
    80000b44:	60a2                	ld	ra,8(sp)
    80000b46:	6402                	ld	s0,0(sp)
    80000b48:	0141                	add	sp,sp,16
    80000b4a:	8082                	ret
    panic("uvmclear");
    80000b4c:	00007517          	auipc	a0,0x7
    80000b50:	5fc50513          	add	a0,a0,1532 # 80008148 <etext+0x148>
    80000b54:	00005097          	auipc	ra,0x5
    80000b58:	58c080e7          	jalr	1420(ra) # 800060e0 <panic>

0000000080000b5c <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000b5c:	c6bd                	beqz	a3,80000bca <copyout+0x6e>
{
    80000b5e:	715d                	add	sp,sp,-80
    80000b60:	e486                	sd	ra,72(sp)
    80000b62:	e0a2                	sd	s0,64(sp)
    80000b64:	fc26                	sd	s1,56(sp)
    80000b66:	f84a                	sd	s2,48(sp)
    80000b68:	f44e                	sd	s3,40(sp)
    80000b6a:	f052                	sd	s4,32(sp)
    80000b6c:	ec56                	sd	s5,24(sp)
    80000b6e:	e85a                	sd	s6,16(sp)
    80000b70:	e45e                	sd	s7,8(sp)
    80000b72:	e062                	sd	s8,0(sp)
    80000b74:	0880                	add	s0,sp,80
    80000b76:	8b2a                	mv	s6,a0
    80000b78:	8c2e                	mv	s8,a1
    80000b7a:	8a32                	mv	s4,a2
    80000b7c:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80000b7e:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    80000b80:	6a85                	lui	s5,0x1
    80000b82:	a015                	j	80000ba6 <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000b84:	9562                	add	a0,a0,s8
    80000b86:	0004861b          	sext.w	a2,s1
    80000b8a:	85d2                	mv	a1,s4
    80000b8c:	41250533          	sub	a0,a0,s2
    80000b90:	fffff097          	auipc	ra,0xfffff
    80000b94:	690080e7          	jalr	1680(ra) # 80000220 <memmove>

    len -= n;
    80000b98:	409989b3          	sub	s3,s3,s1
    src += n;
    80000b9c:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    80000b9e:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000ba2:	02098263          	beqz	s3,80000bc6 <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    80000ba6:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000baa:	85ca                	mv	a1,s2
    80000bac:	855a                	mv	a0,s6
    80000bae:	00000097          	auipc	ra,0x0
    80000bb2:	99e080e7          	jalr	-1634(ra) # 8000054c <walkaddr>
    if(pa0 == 0)
    80000bb6:	cd01                	beqz	a0,80000bce <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    80000bb8:	418904b3          	sub	s1,s2,s8
    80000bbc:	94d6                	add	s1,s1,s5
    80000bbe:	fc99f3e3          	bgeu	s3,s1,80000b84 <copyout+0x28>
    80000bc2:	84ce                	mv	s1,s3
    80000bc4:	b7c1                	j	80000b84 <copyout+0x28>
  }
  return 0;
    80000bc6:	4501                	li	a0,0
    80000bc8:	a021                	j	80000bd0 <copyout+0x74>
    80000bca:	4501                	li	a0,0
}
    80000bcc:	8082                	ret
      return -1;
    80000bce:	557d                	li	a0,-1
}
    80000bd0:	60a6                	ld	ra,72(sp)
    80000bd2:	6406                	ld	s0,64(sp)
    80000bd4:	74e2                	ld	s1,56(sp)
    80000bd6:	7942                	ld	s2,48(sp)
    80000bd8:	79a2                	ld	s3,40(sp)
    80000bda:	7a02                	ld	s4,32(sp)
    80000bdc:	6ae2                	ld	s5,24(sp)
    80000bde:	6b42                	ld	s6,16(sp)
    80000be0:	6ba2                	ld	s7,8(sp)
    80000be2:	6c02                	ld	s8,0(sp)
    80000be4:	6161                	add	sp,sp,80
    80000be6:	8082                	ret

0000000080000be8 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000be8:	caa5                	beqz	a3,80000c58 <copyin+0x70>
{
    80000bea:	715d                	add	sp,sp,-80
    80000bec:	e486                	sd	ra,72(sp)
    80000bee:	e0a2                	sd	s0,64(sp)
    80000bf0:	fc26                	sd	s1,56(sp)
    80000bf2:	f84a                	sd	s2,48(sp)
    80000bf4:	f44e                	sd	s3,40(sp)
    80000bf6:	f052                	sd	s4,32(sp)
    80000bf8:	ec56                	sd	s5,24(sp)
    80000bfa:	e85a                	sd	s6,16(sp)
    80000bfc:	e45e                	sd	s7,8(sp)
    80000bfe:	e062                	sd	s8,0(sp)
    80000c00:	0880                	add	s0,sp,80
    80000c02:	8b2a                	mv	s6,a0
    80000c04:	8a2e                	mv	s4,a1
    80000c06:	8c32                	mv	s8,a2
    80000c08:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000c0a:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000c0c:	6a85                	lui	s5,0x1
    80000c0e:	a01d                	j	80000c34 <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000c10:	018505b3          	add	a1,a0,s8
    80000c14:	0004861b          	sext.w	a2,s1
    80000c18:	412585b3          	sub	a1,a1,s2
    80000c1c:	8552                	mv	a0,s4
    80000c1e:	fffff097          	auipc	ra,0xfffff
    80000c22:	602080e7          	jalr	1538(ra) # 80000220 <memmove>

    len -= n;
    80000c26:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000c2a:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80000c2c:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000c30:	02098263          	beqz	s3,80000c54 <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    80000c34:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000c38:	85ca                	mv	a1,s2
    80000c3a:	855a                	mv	a0,s6
    80000c3c:	00000097          	auipc	ra,0x0
    80000c40:	910080e7          	jalr	-1776(ra) # 8000054c <walkaddr>
    if(pa0 == 0)
    80000c44:	cd01                	beqz	a0,80000c5c <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80000c46:	418904b3          	sub	s1,s2,s8
    80000c4a:	94d6                	add	s1,s1,s5
    80000c4c:	fc99f2e3          	bgeu	s3,s1,80000c10 <copyin+0x28>
    80000c50:	84ce                	mv	s1,s3
    80000c52:	bf7d                	j	80000c10 <copyin+0x28>
  }
  return 0;
    80000c54:	4501                	li	a0,0
    80000c56:	a021                	j	80000c5e <copyin+0x76>
    80000c58:	4501                	li	a0,0
}
    80000c5a:	8082                	ret
      return -1;
    80000c5c:	557d                	li	a0,-1
}
    80000c5e:	60a6                	ld	ra,72(sp)
    80000c60:	6406                	ld	s0,64(sp)
    80000c62:	74e2                	ld	s1,56(sp)
    80000c64:	7942                	ld	s2,48(sp)
    80000c66:	79a2                	ld	s3,40(sp)
    80000c68:	7a02                	ld	s4,32(sp)
    80000c6a:	6ae2                	ld	s5,24(sp)
    80000c6c:	6b42                	ld	s6,16(sp)
    80000c6e:	6ba2                	ld	s7,8(sp)
    80000c70:	6c02                	ld	s8,0(sp)
    80000c72:	6161                	add	sp,sp,80
    80000c74:	8082                	ret

0000000080000c76 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80000c76:	c2dd                	beqz	a3,80000d1c <copyinstr+0xa6>
{
    80000c78:	715d                	add	sp,sp,-80
    80000c7a:	e486                	sd	ra,72(sp)
    80000c7c:	e0a2                	sd	s0,64(sp)
    80000c7e:	fc26                	sd	s1,56(sp)
    80000c80:	f84a                	sd	s2,48(sp)
    80000c82:	f44e                	sd	s3,40(sp)
    80000c84:	f052                	sd	s4,32(sp)
    80000c86:	ec56                	sd	s5,24(sp)
    80000c88:	e85a                	sd	s6,16(sp)
    80000c8a:	e45e                	sd	s7,8(sp)
    80000c8c:	0880                	add	s0,sp,80
    80000c8e:	8a2a                	mv	s4,a0
    80000c90:	8b2e                	mv	s6,a1
    80000c92:	8bb2                	mv	s7,a2
    80000c94:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    80000c96:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000c98:	6985                	lui	s3,0x1
    80000c9a:	a02d                	j	80000cc4 <copyinstr+0x4e>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000c9c:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    80000ca0:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80000ca2:	37fd                	addw	a5,a5,-1
    80000ca4:	0007851b          	sext.w	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000ca8:	60a6                	ld	ra,72(sp)
    80000caa:	6406                	ld	s0,64(sp)
    80000cac:	74e2                	ld	s1,56(sp)
    80000cae:	7942                	ld	s2,48(sp)
    80000cb0:	79a2                	ld	s3,40(sp)
    80000cb2:	7a02                	ld	s4,32(sp)
    80000cb4:	6ae2                	ld	s5,24(sp)
    80000cb6:	6b42                	ld	s6,16(sp)
    80000cb8:	6ba2                	ld	s7,8(sp)
    80000cba:	6161                	add	sp,sp,80
    80000cbc:	8082                	ret
    srcva = va0 + PGSIZE;
    80000cbe:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    80000cc2:	c8a9                	beqz	s1,80000d14 <copyinstr+0x9e>
    va0 = PGROUNDDOWN(srcva);
    80000cc4:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    80000cc8:	85ca                	mv	a1,s2
    80000cca:	8552                	mv	a0,s4
    80000ccc:	00000097          	auipc	ra,0x0
    80000cd0:	880080e7          	jalr	-1920(ra) # 8000054c <walkaddr>
    if(pa0 == 0)
    80000cd4:	c131                	beqz	a0,80000d18 <copyinstr+0xa2>
    n = PGSIZE - (srcva - va0);
    80000cd6:	417906b3          	sub	a3,s2,s7
    80000cda:	96ce                	add	a3,a3,s3
    80000cdc:	00d4f363          	bgeu	s1,a3,80000ce2 <copyinstr+0x6c>
    80000ce0:	86a6                	mv	a3,s1
    char *p = (char *) (pa0 + (srcva - va0));
    80000ce2:	955e                	add	a0,a0,s7
    80000ce4:	41250533          	sub	a0,a0,s2
    while(n > 0){
    80000ce8:	daf9                	beqz	a3,80000cbe <copyinstr+0x48>
    80000cea:	87da                	mv	a5,s6
    80000cec:	885a                	mv	a6,s6
      if(*p == '\0'){
    80000cee:	41650633          	sub	a2,a0,s6
    while(n > 0){
    80000cf2:	96da                	add	a3,a3,s6
    80000cf4:	85be                	mv	a1,a5
      if(*p == '\0'){
    80000cf6:	00f60733          	add	a4,a2,a5
    80000cfa:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <end+0xffffffff7ffdcca0>
    80000cfe:	df59                	beqz	a4,80000c9c <copyinstr+0x26>
        *dst = *p;
    80000d00:	00e78023          	sb	a4,0(a5)
      dst++;
    80000d04:	0785                	add	a5,a5,1
    while(n > 0){
    80000d06:	fed797e3          	bne	a5,a3,80000cf4 <copyinstr+0x7e>
    80000d0a:	14fd                	add	s1,s1,-1
    80000d0c:	94c2                	add	s1,s1,a6
      --max;
    80000d0e:	8c8d                	sub	s1,s1,a1
      dst++;
    80000d10:	8b3e                	mv	s6,a5
    80000d12:	b775                	j	80000cbe <copyinstr+0x48>
    80000d14:	4781                	li	a5,0
    80000d16:	b771                	j	80000ca2 <copyinstr+0x2c>
      return -1;
    80000d18:	557d                	li	a0,-1
    80000d1a:	b779                	j	80000ca8 <copyinstr+0x32>
  int got_null = 0;
    80000d1c:	4781                	li	a5,0
  if(got_null){
    80000d1e:	37fd                	addw	a5,a5,-1
    80000d20:	0007851b          	sext.w	a0,a5
}
    80000d24:	8082                	ret

0000000080000d26 <printpte>:

void
printpte(pagetable_t pagetable, int idx, int depth)
{
    80000d26:	7139                	add	sp,sp,-64
    80000d28:	fc06                	sd	ra,56(sp)
    80000d2a:	f822                	sd	s0,48(sp)
    80000d2c:	f426                	sd	s1,40(sp)
    80000d2e:	f04a                	sd	s2,32(sp)
    80000d30:	ec4e                	sd	s3,24(sp)
    80000d32:	e852                	sd	s4,16(sp)
    80000d34:	e456                	sd	s5,8(sp)
    80000d36:	0080                	add	s0,sp,64
    80000d38:	8a2a                	mv	s4,a0
    80000d3a:	8aae                	mv	s5,a1
    80000d3c:	8932                	mv	s2,a2
  printf("..");
    80000d3e:	00007517          	auipc	a0,0x7
    80000d42:	41a50513          	add	a0,a0,1050 # 80008158 <etext+0x158>
    80000d46:	00005097          	auipc	ra,0x5
    80000d4a:	3e4080e7          	jalr	996(ra) # 8000612a <printf>
  for (int i = 0; i < depth; ++i)
    80000d4e:	01205f63          	blez	s2,80000d6c <printpte+0x46>
    80000d52:	4481                	li	s1,0
    printf(" ..");
    80000d54:	00007997          	auipc	s3,0x7
    80000d58:	40c98993          	add	s3,s3,1036 # 80008160 <etext+0x160>
    80000d5c:	854e                	mv	a0,s3
    80000d5e:	00005097          	auipc	ra,0x5
    80000d62:	3cc080e7          	jalr	972(ra) # 8000612a <printf>
  for (int i = 0; i < depth; ++i)
    80000d66:	2485                	addw	s1,s1,1
    80000d68:	fe991ae3          	bne	s2,s1,80000d5c <printpte+0x36>
  printf("%d: pte %p pa %p\n", idx, pagetable[idx], PTE2PA(pagetable[idx]));
    80000d6c:	003a9793          	sll	a5,s5,0x3
    80000d70:	9a3e                	add	s4,s4,a5
    80000d72:	000a3603          	ld	a2,0(s4)
    80000d76:	00a65693          	srl	a3,a2,0xa
    80000d7a:	06b2                	sll	a3,a3,0xc
    80000d7c:	85d6                	mv	a1,s5
    80000d7e:	00007517          	auipc	a0,0x7
    80000d82:	3ea50513          	add	a0,a0,1002 # 80008168 <etext+0x168>
    80000d86:	00005097          	auipc	ra,0x5
    80000d8a:	3a4080e7          	jalr	932(ra) # 8000612a <printf>
}
    80000d8e:	70e2                	ld	ra,56(sp)
    80000d90:	7442                	ld	s0,48(sp)
    80000d92:	74a2                	ld	s1,40(sp)
    80000d94:	7902                	ld	s2,32(sp)
    80000d96:	69e2                	ld	s3,24(sp)
    80000d98:	6a42                	ld	s4,16(sp)
    80000d9a:	6aa2                	ld	s5,8(sp)
    80000d9c:	6121                	add	sp,sp,64
    80000d9e:	8082                	ret

0000000080000da0 <vmprint_depth>:

void
vmprint_depth(pagetable_t pagetable, int depth)
{
    80000da0:	715d                	add	sp,sp,-80
    80000da2:	e486                	sd	ra,72(sp)
    80000da4:	e0a2                	sd	s0,64(sp)
    80000da6:	fc26                	sd	s1,56(sp)
    80000da8:	f84a                	sd	s2,48(sp)
    80000daa:	f44e                	sd	s3,40(sp)
    80000dac:	f052                	sd	s4,32(sp)
    80000dae:	ec56                	sd	s5,24(sp)
    80000db0:	e85a                	sd	s6,16(sp)
    80000db2:	e45e                	sd	s7,8(sp)
    80000db4:	0880                	add	s0,sp,80
    80000db6:	8b2a                	mv	s6,a0
    80000db8:	8bae                	mv	s7,a1
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80000dba:	89aa                	mv	s3,a0
    80000dbc:	4901                	li	s2,0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000dbe:	4a85                	li	s5,1
  for(int i = 0; i < 512; i++){
    80000dc0:	20000a13          	li	s4,512
    80000dc4:	a02d                	j	80000dee <vmprint_depth+0x4e>
      // this PTE points to a lower-level page table.
      printpte(pagetable, i, depth);
    80000dc6:	865e                	mv	a2,s7
    80000dc8:	85ca                	mv	a1,s2
    80000dca:	855a                	mv	a0,s6
    80000dcc:	00000097          	auipc	ra,0x0
    80000dd0:	f5a080e7          	jalr	-166(ra) # 80000d26 <printpte>
      uint64 child = PTE2PA(pte);
    80000dd4:	80a9                	srl	s1,s1,0xa
      vmprint_depth((pagetable_t)child, depth+1);
    80000dd6:	001b859b          	addw	a1,s7,1 # fffffffffffff001 <end+0xffffffff7ffdcca1>
    80000dda:	00c49513          	sll	a0,s1,0xc
    80000dde:	00000097          	auipc	ra,0x0
    80000de2:	fc2080e7          	jalr	-62(ra) # 80000da0 <vmprint_depth>
  for(int i = 0; i < 512; i++){
    80000de6:	2905                	addw	s2,s2,1 # 1001 <_entry-0x7fffefff>
    80000de8:	09a1                	add	s3,s3,8
    80000dea:	03490263          	beq	s2,s4,80000e0e <vmprint_depth+0x6e>
    pte_t pte = pagetable[i];
    80000dee:	0009b483          	ld	s1,0(s3)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000df2:	00f4f793          	and	a5,s1,15
    80000df6:	fd5788e3          	beq	a5,s5,80000dc6 <vmprint_depth+0x26>
    } else if(pte & PTE_V){
    80000dfa:	8885                	and	s1,s1,1
    80000dfc:	d4ed                	beqz	s1,80000de6 <vmprint_depth+0x46>
      printpte(pagetable, i, depth);
    80000dfe:	865e                	mv	a2,s7
    80000e00:	85ca                	mv	a1,s2
    80000e02:	855a                	mv	a0,s6
    80000e04:	00000097          	auipc	ra,0x0
    80000e08:	f22080e7          	jalr	-222(ra) # 80000d26 <printpte>
    80000e0c:	bfe9                	j	80000de6 <vmprint_depth+0x46>
    }
  }
}
    80000e0e:	60a6                	ld	ra,72(sp)
    80000e10:	6406                	ld	s0,64(sp)
    80000e12:	74e2                	ld	s1,56(sp)
    80000e14:	7942                	ld	s2,48(sp)
    80000e16:	79a2                	ld	s3,40(sp)
    80000e18:	7a02                	ld	s4,32(sp)
    80000e1a:	6ae2                	ld	s5,24(sp)
    80000e1c:	6b42                	ld	s6,16(sp)
    80000e1e:	6ba2                	ld	s7,8(sp)
    80000e20:	6161                	add	sp,sp,80
    80000e22:	8082                	ret

0000000080000e24 <vmprint>:

void
vmprint(pagetable_t pagetable)
{
    80000e24:	1101                	add	sp,sp,-32
    80000e26:	ec06                	sd	ra,24(sp)
    80000e28:	e822                	sd	s0,16(sp)
    80000e2a:	e426                	sd	s1,8(sp)
    80000e2c:	1000                	add	s0,sp,32
    80000e2e:	84aa                	mv	s1,a0
  printf("page table %p\n", pagetable);
    80000e30:	85aa                	mv	a1,a0
    80000e32:	00007517          	auipc	a0,0x7
    80000e36:	34e50513          	add	a0,a0,846 # 80008180 <etext+0x180>
    80000e3a:	00005097          	auipc	ra,0x5
    80000e3e:	2f0080e7          	jalr	752(ra) # 8000612a <printf>
  vmprint_depth(pagetable, 0);
    80000e42:	4581                	li	a1,0
    80000e44:	8526                	mv	a0,s1
    80000e46:	00000097          	auipc	ra,0x0
    80000e4a:	f5a080e7          	jalr	-166(ra) # 80000da0 <vmprint_depth>
}
    80000e4e:	60e2                	ld	ra,24(sp)
    80000e50:	6442                	ld	s0,16(sp)
    80000e52:	64a2                	ld	s1,8(sp)
    80000e54:	6105                	add	sp,sp,32
    80000e56:	8082                	ret

0000000080000e58 <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    80000e58:	7139                	add	sp,sp,-64
    80000e5a:	fc06                	sd	ra,56(sp)
    80000e5c:	f822                	sd	s0,48(sp)
    80000e5e:	f426                	sd	s1,40(sp)
    80000e60:	f04a                	sd	s2,32(sp)
    80000e62:	ec4e                	sd	s3,24(sp)
    80000e64:	e852                	sd	s4,16(sp)
    80000e66:	e456                	sd	s5,8(sp)
    80000e68:	e05a                	sd	s6,0(sp)
    80000e6a:	0080                	add	s0,sp,64
    80000e6c:	89aa                	mv	s3,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e6e:	00008497          	auipc	s1,0x8
    80000e72:	0ca48493          	add	s1,s1,202 # 80008f38 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000e76:	8b26                	mv	s6,s1
    80000e78:	00007a97          	auipc	s5,0x7
    80000e7c:	188a8a93          	add	s5,s5,392 # 80008000 <etext>
    80000e80:	01000937          	lui	s2,0x1000
    80000e84:	197d                	add	s2,s2,-1 # ffffff <_entry-0x7f000001>
    80000e86:	093a                	sll	s2,s2,0xe
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e88:	0000ea17          	auipc	s4,0xe
    80000e8c:	eb0a0a13          	add	s4,s4,-336 # 8000ed38 <tickslock>
    char *pa = kalloc();
    80000e90:	fffff097          	auipc	ra,0xfffff
    80000e94:	2d4080e7          	jalr	724(ra) # 80000164 <kalloc>
    80000e98:	862a                	mv	a2,a0
    if(pa == 0)
    80000e9a:	c129                	beqz	a0,80000edc <proc_mapstacks+0x84>
    uint64 va = KSTACK((int) (p - proc));
    80000e9c:	416485b3          	sub	a1,s1,s6
    80000ea0:	858d                	sra	a1,a1,0x3
    80000ea2:	000ab783          	ld	a5,0(s5)
    80000ea6:	02f585b3          	mul	a1,a1,a5
    80000eaa:	00d5959b          	sllw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000eae:	4719                	li	a4,6
    80000eb0:	6685                	lui	a3,0x1
    80000eb2:	40b905b3          	sub	a1,s2,a1
    80000eb6:	854e                	mv	a0,s3
    80000eb8:	fffff097          	auipc	ra,0xfffff
    80000ebc:	776080e7          	jalr	1910(ra) # 8000062e <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000ec0:	17848493          	add	s1,s1,376
    80000ec4:	fd4496e3          	bne	s1,s4,80000e90 <proc_mapstacks+0x38>
  }
}
    80000ec8:	70e2                	ld	ra,56(sp)
    80000eca:	7442                	ld	s0,48(sp)
    80000ecc:	74a2                	ld	s1,40(sp)
    80000ece:	7902                	ld	s2,32(sp)
    80000ed0:	69e2                	ld	s3,24(sp)
    80000ed2:	6a42                	ld	s4,16(sp)
    80000ed4:	6aa2                	ld	s5,8(sp)
    80000ed6:	6b02                	ld	s6,0(sp)
    80000ed8:	6121                	add	sp,sp,64
    80000eda:	8082                	ret
      panic("kalloc");
    80000edc:	00007517          	auipc	a0,0x7
    80000ee0:	2b450513          	add	a0,a0,692 # 80008190 <etext+0x190>
    80000ee4:	00005097          	auipc	ra,0x5
    80000ee8:	1fc080e7          	jalr	508(ra) # 800060e0 <panic>

0000000080000eec <procinit>:

// initialize the proc table.
void
procinit(void)
{
    80000eec:	7139                	add	sp,sp,-64
    80000eee:	fc06                	sd	ra,56(sp)
    80000ef0:	f822                	sd	s0,48(sp)
    80000ef2:	f426                	sd	s1,40(sp)
    80000ef4:	f04a                	sd	s2,32(sp)
    80000ef6:	ec4e                	sd	s3,24(sp)
    80000ef8:	e852                	sd	s4,16(sp)
    80000efa:	e456                	sd	s5,8(sp)
    80000efc:	e05a                	sd	s6,0(sp)
    80000efe:	0080                	add	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80000f00:	00007597          	auipc	a1,0x7
    80000f04:	29858593          	add	a1,a1,664 # 80008198 <etext+0x198>
    80000f08:	00008517          	auipc	a0,0x8
    80000f0c:	be850513          	add	a0,a0,-1048 # 80008af0 <pid_lock>
    80000f10:	00005097          	auipc	ra,0x5
    80000f14:	678080e7          	jalr	1656(ra) # 80006588 <initlock>
  initlock(&wait_lock, "wait_lock");
    80000f18:	00007597          	auipc	a1,0x7
    80000f1c:	28858593          	add	a1,a1,648 # 800081a0 <etext+0x1a0>
    80000f20:	00008517          	auipc	a0,0x8
    80000f24:	be850513          	add	a0,a0,-1048 # 80008b08 <wait_lock>
    80000f28:	00005097          	auipc	ra,0x5
    80000f2c:	660080e7          	jalr	1632(ra) # 80006588 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000f30:	00008497          	auipc	s1,0x8
    80000f34:	00848493          	add	s1,s1,8 # 80008f38 <proc>
      initlock(&p->lock, "proc");
    80000f38:	00007b17          	auipc	s6,0x7
    80000f3c:	278b0b13          	add	s6,s6,632 # 800081b0 <etext+0x1b0>
      p->state = UNUSED;
      p->kstack = KSTACK((int) (p - proc));
    80000f40:	8aa6                	mv	s5,s1
    80000f42:	00007a17          	auipc	s4,0x7
    80000f46:	0bea0a13          	add	s4,s4,190 # 80008000 <etext>
    80000f4a:	01000937          	lui	s2,0x1000
    80000f4e:	197d                	add	s2,s2,-1 # ffffff <_entry-0x7f000001>
    80000f50:	093a                	sll	s2,s2,0xe
  for(p = proc; p < &proc[NPROC]; p++) {
    80000f52:	0000e997          	auipc	s3,0xe
    80000f56:	de698993          	add	s3,s3,-538 # 8000ed38 <tickslock>
      initlock(&p->lock, "proc");
    80000f5a:	85da                	mv	a1,s6
    80000f5c:	8526                	mv	a0,s1
    80000f5e:	00005097          	auipc	ra,0x5
    80000f62:	62a080e7          	jalr	1578(ra) # 80006588 <initlock>
      p->state = UNUSED;
    80000f66:	0004ac23          	sw	zero,24(s1)
      p->kstack = KSTACK((int) (p - proc));
    80000f6a:	415487b3          	sub	a5,s1,s5
    80000f6e:	878d                	sra	a5,a5,0x3
    80000f70:	000a3703          	ld	a4,0(s4)
    80000f74:	02e787b3          	mul	a5,a5,a4
    80000f78:	00d7979b          	sllw	a5,a5,0xd
    80000f7c:	40f907b3          	sub	a5,s2,a5
    80000f80:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80000f82:	17848493          	add	s1,s1,376
    80000f86:	fd349ae3          	bne	s1,s3,80000f5a <procinit+0x6e>
  }
}
    80000f8a:	70e2                	ld	ra,56(sp)
    80000f8c:	7442                	ld	s0,48(sp)
    80000f8e:	74a2                	ld	s1,40(sp)
    80000f90:	7902                	ld	s2,32(sp)
    80000f92:	69e2                	ld	s3,24(sp)
    80000f94:	6a42                	ld	s4,16(sp)
    80000f96:	6aa2                	ld	s5,8(sp)
    80000f98:	6b02                	ld	s6,0(sp)
    80000f9a:	6121                	add	sp,sp,64
    80000f9c:	8082                	ret

0000000080000f9e <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80000f9e:	1141                	add	sp,sp,-16
    80000fa0:	e422                	sd	s0,8(sp)
    80000fa2:	0800                	add	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80000fa4:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80000fa6:	2501                	sext.w	a0,a0
    80000fa8:	6422                	ld	s0,8(sp)
    80000faa:	0141                	add	sp,sp,16
    80000fac:	8082                	ret

0000000080000fae <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    80000fae:	1141                	add	sp,sp,-16
    80000fb0:	e422                	sd	s0,8(sp)
    80000fb2:	0800                	add	s0,sp,16
    80000fb4:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80000fb6:	2781                	sext.w	a5,a5
    80000fb8:	079e                	sll	a5,a5,0x7
  return c;
}
    80000fba:	00008517          	auipc	a0,0x8
    80000fbe:	b6650513          	add	a0,a0,-1178 # 80008b20 <cpus>
    80000fc2:	953e                	add	a0,a0,a5
    80000fc4:	6422                	ld	s0,8(sp)
    80000fc6:	0141                	add	sp,sp,16
    80000fc8:	8082                	ret

0000000080000fca <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    80000fca:	1101                	add	sp,sp,-32
    80000fcc:	ec06                	sd	ra,24(sp)
    80000fce:	e822                	sd	s0,16(sp)
    80000fd0:	e426                	sd	s1,8(sp)
    80000fd2:	1000                	add	s0,sp,32
  push_off();
    80000fd4:	00005097          	auipc	ra,0x5
    80000fd8:	5f8080e7          	jalr	1528(ra) # 800065cc <push_off>
    80000fdc:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80000fde:	2781                	sext.w	a5,a5
    80000fe0:	079e                	sll	a5,a5,0x7
    80000fe2:	00008717          	auipc	a4,0x8
    80000fe6:	b0e70713          	add	a4,a4,-1266 # 80008af0 <pid_lock>
    80000fea:	97ba                	add	a5,a5,a4
    80000fec:	7b84                	ld	s1,48(a5)
  pop_off();
    80000fee:	00005097          	auipc	ra,0x5
    80000ff2:	67e080e7          	jalr	1662(ra) # 8000666c <pop_off>
  return p;
}
    80000ff6:	8526                	mv	a0,s1
    80000ff8:	60e2                	ld	ra,24(sp)
    80000ffa:	6442                	ld	s0,16(sp)
    80000ffc:	64a2                	ld	s1,8(sp)
    80000ffe:	6105                	add	sp,sp,32
    80001000:	8082                	ret

0000000080001002 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80001002:	1141                	add	sp,sp,-16
    80001004:	e406                	sd	ra,8(sp)
    80001006:	e022                	sd	s0,0(sp)
    80001008:	0800                	add	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    8000100a:	00000097          	auipc	ra,0x0
    8000100e:	fc0080e7          	jalr	-64(ra) # 80000fca <myproc>
    80001012:	00005097          	auipc	ra,0x5
    80001016:	6ba080e7          	jalr	1722(ra) # 800066cc <release>

  if (first) {
    8000101a:	00008797          	auipc	a5,0x8
    8000101e:	a267a783          	lw	a5,-1498(a5) # 80008a40 <first.1>
    80001022:	eb89                	bnez	a5,80001034 <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    80001024:	00001097          	auipc	ra,0x1
    80001028:	e06080e7          	jalr	-506(ra) # 80001e2a <usertrapret>
}
    8000102c:	60a2                	ld	ra,8(sp)
    8000102e:	6402                	ld	s0,0(sp)
    80001030:	0141                	add	sp,sp,16
    80001032:	8082                	ret
    first = 0;
    80001034:	00008797          	auipc	a5,0x8
    80001038:	a007a623          	sw	zero,-1524(a5) # 80008a40 <first.1>
    fsinit(ROOTDEV);
    8000103c:	4505                	li	a0,1
    8000103e:	00002097          	auipc	ra,0x2
    80001042:	d20080e7          	jalr	-736(ra) # 80002d5e <fsinit>
    80001046:	bff9                	j	80001024 <forkret+0x22>

0000000080001048 <allocpid>:
{
    80001048:	1101                	add	sp,sp,-32
    8000104a:	ec06                	sd	ra,24(sp)
    8000104c:	e822                	sd	s0,16(sp)
    8000104e:	e426                	sd	s1,8(sp)
    80001050:	e04a                	sd	s2,0(sp)
    80001052:	1000                	add	s0,sp,32
  acquire(&pid_lock);
    80001054:	00008917          	auipc	s2,0x8
    80001058:	a9c90913          	add	s2,s2,-1380 # 80008af0 <pid_lock>
    8000105c:	854a                	mv	a0,s2
    8000105e:	00005097          	auipc	ra,0x5
    80001062:	5ba080e7          	jalr	1466(ra) # 80006618 <acquire>
  pid = nextpid;
    80001066:	00008797          	auipc	a5,0x8
    8000106a:	9de78793          	add	a5,a5,-1570 # 80008a44 <nextpid>
    8000106e:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80001070:	0014871b          	addw	a4,s1,1
    80001074:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80001076:	854a                	mv	a0,s2
    80001078:	00005097          	auipc	ra,0x5
    8000107c:	654080e7          	jalr	1620(ra) # 800066cc <release>
}
    80001080:	8526                	mv	a0,s1
    80001082:	60e2                	ld	ra,24(sp)
    80001084:	6442                	ld	s0,16(sp)
    80001086:	64a2                	ld	s1,8(sp)
    80001088:	6902                	ld	s2,0(sp)
    8000108a:	6105                	add	sp,sp,32
    8000108c:	8082                	ret

000000008000108e <proc_pagetable>:
{
    8000108e:	1101                	add	sp,sp,-32
    80001090:	ec06                	sd	ra,24(sp)
    80001092:	e822                	sd	s0,16(sp)
    80001094:	e426                	sd	s1,8(sp)
    80001096:	e04a                	sd	s2,0(sp)
    80001098:	1000                	add	s0,sp,32
    8000109a:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    8000109c:	fffff097          	auipc	ra,0xfffff
    800010a0:	77c080e7          	jalr	1916(ra) # 80000818 <uvmcreate>
    800010a4:	84aa                	mv	s1,a0
  if(pagetable == 0)
    800010a6:	cd39                	beqz	a0,80001104 <proc_pagetable+0x76>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    800010a8:	4729                	li	a4,10
    800010aa:	00006697          	auipc	a3,0x6
    800010ae:	f5668693          	add	a3,a3,-170 # 80007000 <_trampoline>
    800010b2:	6605                	lui	a2,0x1
    800010b4:	040005b7          	lui	a1,0x4000
    800010b8:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    800010ba:	05b2                	sll	a1,a1,0xc
    800010bc:	fffff097          	auipc	ra,0xfffff
    800010c0:	4d2080e7          	jalr	1234(ra) # 8000058e <mappages>
    800010c4:	04054763          	bltz	a0,80001112 <proc_pagetable+0x84>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    800010c8:	4719                	li	a4,6
    800010ca:	06093683          	ld	a3,96(s2)
    800010ce:	6605                	lui	a2,0x1
    800010d0:	020005b7          	lui	a1,0x2000
    800010d4:	15fd                	add	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    800010d6:	05b6                	sll	a1,a1,0xd
    800010d8:	8526                	mv	a0,s1
    800010da:	fffff097          	auipc	ra,0xfffff
    800010de:	4b4080e7          	jalr	1204(ra) # 8000058e <mappages>
    800010e2:	04054063          	bltz	a0,80001122 <proc_pagetable+0x94>
  if(mappages(pagetable, USYSCALL, PGSIZE,
    800010e6:	4749                	li	a4,18
    800010e8:	05893683          	ld	a3,88(s2)
    800010ec:	6605                	lui	a2,0x1
    800010ee:	040005b7          	lui	a1,0x4000
    800010f2:	15f5                	add	a1,a1,-3 # 3fffffd <_entry-0x7c000003>
    800010f4:	05b2                	sll	a1,a1,0xc
    800010f6:	8526                	mv	a0,s1
    800010f8:	fffff097          	auipc	ra,0xfffff
    800010fc:	496080e7          	jalr	1174(ra) # 8000058e <mappages>
    80001100:	04054463          	bltz	a0,80001148 <proc_pagetable+0xba>
}
    80001104:	8526                	mv	a0,s1
    80001106:	60e2                	ld	ra,24(sp)
    80001108:	6442                	ld	s0,16(sp)
    8000110a:	64a2                	ld	s1,8(sp)
    8000110c:	6902                	ld	s2,0(sp)
    8000110e:	6105                	add	sp,sp,32
    80001110:	8082                	ret
    uvmfree(pagetable, 0);
    80001112:	4581                	li	a1,0
    80001114:	8526                	mv	a0,s1
    80001116:	00000097          	auipc	ra,0x0
    8000111a:	908080e7          	jalr	-1784(ra) # 80000a1e <uvmfree>
    return 0;
    8000111e:	4481                	li	s1,0
    80001120:	b7d5                	j	80001104 <proc_pagetable+0x76>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001122:	4681                	li	a3,0
    80001124:	4605                	li	a2,1
    80001126:	040005b7          	lui	a1,0x4000
    8000112a:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    8000112c:	05b2                	sll	a1,a1,0xc
    8000112e:	8526                	mv	a0,s1
    80001130:	fffff097          	auipc	ra,0xfffff
    80001134:	624080e7          	jalr	1572(ra) # 80000754 <uvmunmap>
    uvmfree(pagetable, 0);
    80001138:	4581                	li	a1,0
    8000113a:	8526                	mv	a0,s1
    8000113c:	00000097          	auipc	ra,0x0
    80001140:	8e2080e7          	jalr	-1822(ra) # 80000a1e <uvmfree>
    return 0;
    80001144:	4481                	li	s1,0
    80001146:	bf7d                	j	80001104 <proc_pagetable+0x76>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001148:	4681                	li	a3,0
    8000114a:	4605                	li	a2,1
    8000114c:	040005b7          	lui	a1,0x4000
    80001150:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001152:	05b2                	sll	a1,a1,0xc
    80001154:	8526                	mv	a0,s1
    80001156:	fffff097          	auipc	ra,0xfffff
    8000115a:	5fe080e7          	jalr	1534(ra) # 80000754 <uvmunmap>
    uvmunmap(pagetable, TRAPFRAME, 1, 0);
    8000115e:	4681                	li	a3,0
    80001160:	4605                	li	a2,1
    80001162:	020005b7          	lui	a1,0x2000
    80001166:	15fd                	add	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80001168:	05b6                	sll	a1,a1,0xd
    8000116a:	8526                	mv	a0,s1
    8000116c:	fffff097          	auipc	ra,0xfffff
    80001170:	5e8080e7          	jalr	1512(ra) # 80000754 <uvmunmap>
    uvmfree(pagetable, 0);
    80001174:	4581                	li	a1,0
    80001176:	8526                	mv	a0,s1
    80001178:	00000097          	auipc	ra,0x0
    8000117c:	8a6080e7          	jalr	-1882(ra) # 80000a1e <uvmfree>
    80001180:	b751                	j	80001104 <proc_pagetable+0x76>

0000000080001182 <proc_freepagetable>:
{
    80001182:	7179                	add	sp,sp,-48
    80001184:	f406                	sd	ra,40(sp)
    80001186:	f022                	sd	s0,32(sp)
    80001188:	ec26                	sd	s1,24(sp)
    8000118a:	e84a                	sd	s2,16(sp)
    8000118c:	e44e                	sd	s3,8(sp)
    8000118e:	1800                	add	s0,sp,48
    80001190:	84aa                	mv	s1,a0
    80001192:	89ae                	mv	s3,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001194:	4681                	li	a3,0
    80001196:	4605                	li	a2,1
    80001198:	04000937          	lui	s2,0x4000
    8000119c:	fff90593          	add	a1,s2,-1 # 3ffffff <_entry-0x7c000001>
    800011a0:	05b2                	sll	a1,a1,0xc
    800011a2:	fffff097          	auipc	ra,0xfffff
    800011a6:	5b2080e7          	jalr	1458(ra) # 80000754 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    800011aa:	4681                	li	a3,0
    800011ac:	4605                	li	a2,1
    800011ae:	020005b7          	lui	a1,0x2000
    800011b2:	15fd                	add	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    800011b4:	05b6                	sll	a1,a1,0xd
    800011b6:	8526                	mv	a0,s1
    800011b8:	fffff097          	auipc	ra,0xfffff
    800011bc:	59c080e7          	jalr	1436(ra) # 80000754 <uvmunmap>
  uvmunmap(pagetable, USYSCALL, 1, 0);
    800011c0:	4681                	li	a3,0
    800011c2:	4605                	li	a2,1
    800011c4:	1975                	add	s2,s2,-3
    800011c6:	00c91593          	sll	a1,s2,0xc
    800011ca:	8526                	mv	a0,s1
    800011cc:	fffff097          	auipc	ra,0xfffff
    800011d0:	588080e7          	jalr	1416(ra) # 80000754 <uvmunmap>
  uvmfree(pagetable, sz);
    800011d4:	85ce                	mv	a1,s3
    800011d6:	8526                	mv	a0,s1
    800011d8:	00000097          	auipc	ra,0x0
    800011dc:	846080e7          	jalr	-1978(ra) # 80000a1e <uvmfree>
}
    800011e0:	70a2                	ld	ra,40(sp)
    800011e2:	7402                	ld	s0,32(sp)
    800011e4:	64e2                	ld	s1,24(sp)
    800011e6:	6942                	ld	s2,16(sp)
    800011e8:	69a2                	ld	s3,8(sp)
    800011ea:	6145                	add	sp,sp,48
    800011ec:	8082                	ret

00000000800011ee <freeproc>:
{
    800011ee:	1101                	add	sp,sp,-32
    800011f0:	ec06                	sd	ra,24(sp)
    800011f2:	e822                	sd	s0,16(sp)
    800011f4:	e426                	sd	s1,8(sp)
    800011f6:	1000                	add	s0,sp,32
    800011f8:	84aa                	mv	s1,a0
  if(p->shareddata)
    800011fa:	6d28                	ld	a0,88(a0)
    800011fc:	c509                	beqz	a0,80001206 <freeproc+0x18>
    kfree((void*)p->shareddata);
    800011fe:	fffff097          	auipc	ra,0xfffff
    80001202:	e1e080e7          	jalr	-482(ra) # 8000001c <kfree>
  p->shareddata = 0;
    80001206:	0404bc23          	sd	zero,88(s1)
  if(p->trapframe)
    8000120a:	70a8                	ld	a0,96(s1)
    8000120c:	c509                	beqz	a0,80001216 <freeproc+0x28>
    kfree((void*)p->trapframe);
    8000120e:	fffff097          	auipc	ra,0xfffff
    80001212:	e0e080e7          	jalr	-498(ra) # 8000001c <kfree>
  p->trapframe = 0;
    80001216:	0604b023          	sd	zero,96(s1)
  if(p->pagetable)
    8000121a:	68a8                	ld	a0,80(s1)
    8000121c:	c511                	beqz	a0,80001228 <freeproc+0x3a>
    proc_freepagetable(p->pagetable, p->sz);
    8000121e:	64ac                	ld	a1,72(s1)
    80001220:	00000097          	auipc	ra,0x0
    80001224:	f62080e7          	jalr	-158(ra) # 80001182 <proc_freepagetable>
  p->pagetable = 0;
    80001228:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    8000122c:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80001230:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80001234:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    80001238:	16048023          	sb	zero,352(s1)
  p->chan = 0;
    8000123c:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80001240:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80001244:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80001248:	0004ac23          	sw	zero,24(s1)
}
    8000124c:	60e2                	ld	ra,24(sp)
    8000124e:	6442                	ld	s0,16(sp)
    80001250:	64a2                	ld	s1,8(sp)
    80001252:	6105                	add	sp,sp,32
    80001254:	8082                	ret

0000000080001256 <allocproc>:
{
    80001256:	1101                	add	sp,sp,-32
    80001258:	ec06                	sd	ra,24(sp)
    8000125a:	e822                	sd	s0,16(sp)
    8000125c:	e426                	sd	s1,8(sp)
    8000125e:	e04a                	sd	s2,0(sp)
    80001260:	1000                	add	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80001262:	00008497          	auipc	s1,0x8
    80001266:	cd648493          	add	s1,s1,-810 # 80008f38 <proc>
    8000126a:	0000e917          	auipc	s2,0xe
    8000126e:	ace90913          	add	s2,s2,-1330 # 8000ed38 <tickslock>
    acquire(&p->lock);
    80001272:	8526                	mv	a0,s1
    80001274:	00005097          	auipc	ra,0x5
    80001278:	3a4080e7          	jalr	932(ra) # 80006618 <acquire>
    if(p->state == UNUSED) {
    8000127c:	4c9c                	lw	a5,24(s1)
    8000127e:	cf81                	beqz	a5,80001296 <allocproc+0x40>
      release(&p->lock);
    80001280:	8526                	mv	a0,s1
    80001282:	00005097          	auipc	ra,0x5
    80001286:	44a080e7          	jalr	1098(ra) # 800066cc <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    8000128a:	17848493          	add	s1,s1,376
    8000128e:	ff2492e3          	bne	s1,s2,80001272 <allocproc+0x1c>
  return 0;
    80001292:	4481                	li	s1,0
    80001294:	a09d                	j	800012fa <allocproc+0xa4>
  p->pid = allocpid();
    80001296:	00000097          	auipc	ra,0x0
    8000129a:	db2080e7          	jalr	-590(ra) # 80001048 <allocpid>
    8000129e:	d888                	sw	a0,48(s1)
  p->state = USED;
    800012a0:	4785                	li	a5,1
    800012a2:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    800012a4:	fffff097          	auipc	ra,0xfffff
    800012a8:	ec0080e7          	jalr	-320(ra) # 80000164 <kalloc>
    800012ac:	892a                	mv	s2,a0
    800012ae:	f0a8                	sd	a0,96(s1)
    800012b0:	cd21                	beqz	a0,80001308 <allocproc+0xb2>
  if((p->shareddata = (struct usyscall *)kalloc()) == 0){
    800012b2:	fffff097          	auipc	ra,0xfffff
    800012b6:	eb2080e7          	jalr	-334(ra) # 80000164 <kalloc>
    800012ba:	892a                	mv	s2,a0
    800012bc:	eca8                	sd	a0,88(s1)
    800012be:	c12d                	beqz	a0,80001320 <allocproc+0xca>
  p->pagetable = proc_pagetable(p);
    800012c0:	8526                	mv	a0,s1
    800012c2:	00000097          	auipc	ra,0x0
    800012c6:	dcc080e7          	jalr	-564(ra) # 8000108e <proc_pagetable>
    800012ca:	892a                	mv	s2,a0
    800012cc:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    800012ce:	c52d                	beqz	a0,80001338 <allocproc+0xe2>
  p->priority = 5;
    800012d0:	4795                	li	a5,5
    800012d2:	16f4aa23          	sw	a5,372(s1)
  memset(&p->context, 0, sizeof(p->context));
    800012d6:	07000613          	li	a2,112
    800012da:	4581                	li	a1,0
    800012dc:	06848513          	add	a0,s1,104
    800012e0:	fffff097          	auipc	ra,0xfffff
    800012e4:	ee4080e7          	jalr	-284(ra) # 800001c4 <memset>
  p->context.ra = (uint64)forkret;
    800012e8:	00000797          	auipc	a5,0x0
    800012ec:	d1a78793          	add	a5,a5,-742 # 80001002 <forkret>
    800012f0:	f4bc                	sd	a5,104(s1)
  p->context.sp = p->kstack + PGSIZE;
    800012f2:	60bc                	ld	a5,64(s1)
    800012f4:	6705                	lui	a4,0x1
    800012f6:	97ba                	add	a5,a5,a4
    800012f8:	f8bc                	sd	a5,112(s1)
}
    800012fa:	8526                	mv	a0,s1
    800012fc:	60e2                	ld	ra,24(sp)
    800012fe:	6442                	ld	s0,16(sp)
    80001300:	64a2                	ld	s1,8(sp)
    80001302:	6902                	ld	s2,0(sp)
    80001304:	6105                	add	sp,sp,32
    80001306:	8082                	ret
    freeproc(p);
    80001308:	8526                	mv	a0,s1
    8000130a:	00000097          	auipc	ra,0x0
    8000130e:	ee4080e7          	jalr	-284(ra) # 800011ee <freeproc>
    release(&p->lock);
    80001312:	8526                	mv	a0,s1
    80001314:	00005097          	auipc	ra,0x5
    80001318:	3b8080e7          	jalr	952(ra) # 800066cc <release>
    return 0;
    8000131c:	84ca                	mv	s1,s2
    8000131e:	bff1                	j	800012fa <allocproc+0xa4>
    freeproc(p);
    80001320:	8526                	mv	a0,s1
    80001322:	00000097          	auipc	ra,0x0
    80001326:	ecc080e7          	jalr	-308(ra) # 800011ee <freeproc>
    release(&p->lock);
    8000132a:	8526                	mv	a0,s1
    8000132c:	00005097          	auipc	ra,0x5
    80001330:	3a0080e7          	jalr	928(ra) # 800066cc <release>
    return 0;
    80001334:	84ca                	mv	s1,s2
    80001336:	b7d1                	j	800012fa <allocproc+0xa4>
    freeproc(p);
    80001338:	8526                	mv	a0,s1
    8000133a:	00000097          	auipc	ra,0x0
    8000133e:	eb4080e7          	jalr	-332(ra) # 800011ee <freeproc>
    release(&p->lock);
    80001342:	8526                	mv	a0,s1
    80001344:	00005097          	auipc	ra,0x5
    80001348:	388080e7          	jalr	904(ra) # 800066cc <release>
    return 0;
    8000134c:	84ca                	mv	s1,s2
    8000134e:	b775                	j	800012fa <allocproc+0xa4>

0000000080001350 <userinit>:
{
    80001350:	1101                	add	sp,sp,-32
    80001352:	ec06                	sd	ra,24(sp)
    80001354:	e822                	sd	s0,16(sp)
    80001356:	e426                	sd	s1,8(sp)
    80001358:	1000                	add	s0,sp,32
  p = allocproc();
    8000135a:	00000097          	auipc	ra,0x0
    8000135e:	efc080e7          	jalr	-260(ra) # 80001256 <allocproc>
    80001362:	84aa                	mv	s1,a0
  initproc = p;
    80001364:	00007797          	auipc	a5,0x7
    80001368:	72a7be23          	sd	a0,1852(a5) # 80008aa0 <initproc>
  uvmfirst(p->pagetable, initcode, sizeof(initcode));
    8000136c:	03400613          	li	a2,52
    80001370:	00007597          	auipc	a1,0x7
    80001374:	6e058593          	add	a1,a1,1760 # 80008a50 <initcode>
    80001378:	6928                	ld	a0,80(a0)
    8000137a:	fffff097          	auipc	ra,0xfffff
    8000137e:	4cc080e7          	jalr	1228(ra) # 80000846 <uvmfirst>
  p->sz = PGSIZE;
    80001382:	6785                	lui	a5,0x1
    80001384:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    80001386:	70b8                	ld	a4,96(s1)
    80001388:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    8000138c:	70b8                	ld	a4,96(s1)
    8000138e:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001390:	4641                	li	a2,16
    80001392:	00007597          	auipc	a1,0x7
    80001396:	e2658593          	add	a1,a1,-474 # 800081b8 <etext+0x1b8>
    8000139a:	16048513          	add	a0,s1,352
    8000139e:	fffff097          	auipc	ra,0xfffff
    800013a2:	f6e080e7          	jalr	-146(ra) # 8000030c <safestrcpy>
  p->cwd = namei("/");
    800013a6:	00007517          	auipc	a0,0x7
    800013aa:	e2250513          	add	a0,a0,-478 # 800081c8 <etext+0x1c8>
    800013ae:	00002097          	auipc	ra,0x2
    800013b2:	3ce080e7          	jalr	974(ra) # 8000377c <namei>
    800013b6:	14a4bc23          	sd	a0,344(s1)
  p->state = RUNNABLE;
    800013ba:	478d                	li	a5,3
    800013bc:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    800013be:	8526                	mv	a0,s1
    800013c0:	00005097          	auipc	ra,0x5
    800013c4:	30c080e7          	jalr	780(ra) # 800066cc <release>
}
    800013c8:	60e2                	ld	ra,24(sp)
    800013ca:	6442                	ld	s0,16(sp)
    800013cc:	64a2                	ld	s1,8(sp)
    800013ce:	6105                	add	sp,sp,32
    800013d0:	8082                	ret

00000000800013d2 <growproc>:
{
    800013d2:	1101                	add	sp,sp,-32
    800013d4:	ec06                	sd	ra,24(sp)
    800013d6:	e822                	sd	s0,16(sp)
    800013d8:	e426                	sd	s1,8(sp)
    800013da:	e04a                	sd	s2,0(sp)
    800013dc:	1000                	add	s0,sp,32
    800013de:	892a                	mv	s2,a0
  struct proc *p = myproc();
    800013e0:	00000097          	auipc	ra,0x0
    800013e4:	bea080e7          	jalr	-1046(ra) # 80000fca <myproc>
    800013e8:	84aa                	mv	s1,a0
  sz = p->sz;
    800013ea:	652c                	ld	a1,72(a0)
  if(n > 0){
    800013ec:	01204c63          	bgtz	s2,80001404 <growproc+0x32>
  } else if(n < 0){
    800013f0:	02094663          	bltz	s2,8000141c <growproc+0x4a>
  p->sz = sz;
    800013f4:	e4ac                	sd	a1,72(s1)
  return 0;
    800013f6:	4501                	li	a0,0
}
    800013f8:	60e2                	ld	ra,24(sp)
    800013fa:	6442                	ld	s0,16(sp)
    800013fc:	64a2                	ld	s1,8(sp)
    800013fe:	6902                	ld	s2,0(sp)
    80001400:	6105                	add	sp,sp,32
    80001402:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    80001404:	4691                	li	a3,4
    80001406:	00b90633          	add	a2,s2,a1
    8000140a:	6928                	ld	a0,80(a0)
    8000140c:	fffff097          	auipc	ra,0xfffff
    80001410:	4f4080e7          	jalr	1268(ra) # 80000900 <uvmalloc>
    80001414:	85aa                	mv	a1,a0
    80001416:	fd79                	bnez	a0,800013f4 <growproc+0x22>
      return -1;
    80001418:	557d                	li	a0,-1
    8000141a:	bff9                	j	800013f8 <growproc+0x26>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    8000141c:	00b90633          	add	a2,s2,a1
    80001420:	6928                	ld	a0,80(a0)
    80001422:	fffff097          	auipc	ra,0xfffff
    80001426:	496080e7          	jalr	1174(ra) # 800008b8 <uvmdealloc>
    8000142a:	85aa                	mv	a1,a0
    8000142c:	b7e1                	j	800013f4 <growproc+0x22>

000000008000142e <fork>:
{
    8000142e:	7139                	add	sp,sp,-64
    80001430:	fc06                	sd	ra,56(sp)
    80001432:	f822                	sd	s0,48(sp)
    80001434:	f426                	sd	s1,40(sp)
    80001436:	f04a                	sd	s2,32(sp)
    80001438:	ec4e                	sd	s3,24(sp)
    8000143a:	e852                	sd	s4,16(sp)
    8000143c:	e456                	sd	s5,8(sp)
    8000143e:	0080                	add	s0,sp,64
  struct proc *p = myproc();
    80001440:	00000097          	auipc	ra,0x0
    80001444:	b8a080e7          	jalr	-1142(ra) # 80000fca <myproc>
    80001448:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    8000144a:	00000097          	auipc	ra,0x0
    8000144e:	e0c080e7          	jalr	-500(ra) # 80001256 <allocproc>
    80001452:	12050963          	beqz	a0,80001584 <fork+0x156>
    80001456:	89aa                	mv	s3,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80001458:	048ab603          	ld	a2,72(s5)
    8000145c:	692c                	ld	a1,80(a0)
    8000145e:	050ab503          	ld	a0,80(s5)
    80001462:	fffff097          	auipc	ra,0xfffff
    80001466:	5f6080e7          	jalr	1526(ra) # 80000a58 <uvmcopy>
    8000146a:	06054563          	bltz	a0,800014d4 <fork+0xa6>
  np->sz = p->sz;
    8000146e:	048ab783          	ld	a5,72(s5)
    80001472:	04f9b423          	sd	a5,72(s3)
  np->tracemask = p->tracemask;
    80001476:	170aa783          	lw	a5,368(s5)
    8000147a:	16f9a823          	sw	a5,368(s3)
  np->shareddata->pid = np->pid;
    8000147e:	0589b783          	ld	a5,88(s3)
    80001482:	0309a703          	lw	a4,48(s3)
    80001486:	c398                	sw	a4,0(a5)
  np->priority = p->priority;
    80001488:	174aa783          	lw	a5,372(s5)
    8000148c:	16f9aa23          	sw	a5,372(s3)
  *(np->trapframe) = *(p->trapframe);
    80001490:	060ab683          	ld	a3,96(s5)
    80001494:	87b6                	mv	a5,a3
    80001496:	0609b703          	ld	a4,96(s3)
    8000149a:	12068693          	add	a3,a3,288
    8000149e:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    800014a2:	6788                	ld	a0,8(a5)
    800014a4:	6b8c                	ld	a1,16(a5)
    800014a6:	6f90                	ld	a2,24(a5)
    800014a8:	01073023          	sd	a6,0(a4)
    800014ac:	e708                	sd	a0,8(a4)
    800014ae:	eb0c                	sd	a1,16(a4)
    800014b0:	ef10                	sd	a2,24(a4)
    800014b2:	02078793          	add	a5,a5,32
    800014b6:	02070713          	add	a4,a4,32
    800014ba:	fed792e3          	bne	a5,a3,8000149e <fork+0x70>
  np->trapframe->a0 = 0;
    800014be:	0609b783          	ld	a5,96(s3)
    800014c2:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    800014c6:	0d8a8493          	add	s1,s5,216
    800014ca:	0d898913          	add	s2,s3,216
    800014ce:	158a8a13          	add	s4,s5,344
    800014d2:	a00d                	j	800014f4 <fork+0xc6>
    freeproc(np);
    800014d4:	854e                	mv	a0,s3
    800014d6:	00000097          	auipc	ra,0x0
    800014da:	d18080e7          	jalr	-744(ra) # 800011ee <freeproc>
    release(&np->lock);
    800014de:	854e                	mv	a0,s3
    800014e0:	00005097          	auipc	ra,0x5
    800014e4:	1ec080e7          	jalr	492(ra) # 800066cc <release>
    return -1;
    800014e8:	597d                	li	s2,-1
    800014ea:	a059                	j	80001570 <fork+0x142>
  for(i = 0; i < NOFILE; i++)
    800014ec:	04a1                	add	s1,s1,8
    800014ee:	0921                	add	s2,s2,8
    800014f0:	01448b63          	beq	s1,s4,80001506 <fork+0xd8>
    if(p->ofile[i])
    800014f4:	6088                	ld	a0,0(s1)
    800014f6:	d97d                	beqz	a0,800014ec <fork+0xbe>
      np->ofile[i] = filedup(p->ofile[i]);
    800014f8:	00003097          	auipc	ra,0x3
    800014fc:	8f6080e7          	jalr	-1802(ra) # 80003dee <filedup>
    80001500:	00a93023          	sd	a0,0(s2)
    80001504:	b7e5                	j	800014ec <fork+0xbe>
  np->cwd = idup(p->cwd);
    80001506:	158ab503          	ld	a0,344(s5)
    8000150a:	00002097          	auipc	ra,0x2
    8000150e:	a8e080e7          	jalr	-1394(ra) # 80002f98 <idup>
    80001512:	14a9bc23          	sd	a0,344(s3)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001516:	4641                	li	a2,16
    80001518:	160a8593          	add	a1,s5,352
    8000151c:	16098513          	add	a0,s3,352
    80001520:	fffff097          	auipc	ra,0xfffff
    80001524:	dec080e7          	jalr	-532(ra) # 8000030c <safestrcpy>
  pid = np->pid;
    80001528:	0309a903          	lw	s2,48(s3)
  release(&np->lock);
    8000152c:	854e                	mv	a0,s3
    8000152e:	00005097          	auipc	ra,0x5
    80001532:	19e080e7          	jalr	414(ra) # 800066cc <release>
  acquire(&wait_lock);
    80001536:	00007497          	auipc	s1,0x7
    8000153a:	5d248493          	add	s1,s1,1490 # 80008b08 <wait_lock>
    8000153e:	8526                	mv	a0,s1
    80001540:	00005097          	auipc	ra,0x5
    80001544:	0d8080e7          	jalr	216(ra) # 80006618 <acquire>
  np->parent = p;
    80001548:	0359bc23          	sd	s5,56(s3)
  release(&wait_lock);
    8000154c:	8526                	mv	a0,s1
    8000154e:	00005097          	auipc	ra,0x5
    80001552:	17e080e7          	jalr	382(ra) # 800066cc <release>
  acquire(&np->lock);
    80001556:	854e                	mv	a0,s3
    80001558:	00005097          	auipc	ra,0x5
    8000155c:	0c0080e7          	jalr	192(ra) # 80006618 <acquire>
  np->state = RUNNABLE;
    80001560:	478d                	li	a5,3
    80001562:	00f9ac23          	sw	a5,24(s3)
  release(&np->lock);
    80001566:	854e                	mv	a0,s3
    80001568:	00005097          	auipc	ra,0x5
    8000156c:	164080e7          	jalr	356(ra) # 800066cc <release>
}
    80001570:	854a                	mv	a0,s2
    80001572:	70e2                	ld	ra,56(sp)
    80001574:	7442                	ld	s0,48(sp)
    80001576:	74a2                	ld	s1,40(sp)
    80001578:	7902                	ld	s2,32(sp)
    8000157a:	69e2                	ld	s3,24(sp)
    8000157c:	6a42                	ld	s4,16(sp)
    8000157e:	6aa2                	ld	s5,8(sp)
    80001580:	6121                	add	sp,sp,64
    80001582:	8082                	ret
    return -1;
    80001584:	597d                	li	s2,-1
    80001586:	b7ed                	j	80001570 <fork+0x142>

0000000080001588 <scheduler>:
{
    80001588:	711d                	add	sp,sp,-96
    8000158a:	ec86                	sd	ra,88(sp)
    8000158c:	e8a2                	sd	s0,80(sp)
    8000158e:	e4a6                	sd	s1,72(sp)
    80001590:	e0ca                	sd	s2,64(sp)
    80001592:	fc4e                	sd	s3,56(sp)
    80001594:	f852                	sd	s4,48(sp)
    80001596:	f456                	sd	s5,40(sp)
    80001598:	f05a                	sd	s6,32(sp)
    8000159a:	ec5e                	sd	s7,24(sp)
    8000159c:	e862                	sd	s8,16(sp)
    8000159e:	e466                	sd	s9,8(sp)
    800015a0:	1080                	add	s0,sp,96
    800015a2:	8792                	mv	a5,tp
  int id = r_tp();
    800015a4:	2781                	sext.w	a5,a5
  c->proc = 0;
    800015a6:	00779c13          	sll	s8,a5,0x7
    800015aa:	00007717          	auipc	a4,0x7
    800015ae:	54670713          	add	a4,a4,1350 # 80008af0 <pid_lock>
    800015b2:	9762                	add	a4,a4,s8
    800015b4:	02073823          	sd	zero,48(a4)
          swtch(&c->context, &p->context);
    800015b8:	00007717          	auipc	a4,0x7
    800015bc:	57070713          	add	a4,a4,1392 # 80008b28 <cpus+0x8>
    800015c0:	9c3a                	add	s8,s8,a4
      acquire(&proc_lock);
    800015c2:	00008a97          	auipc	s5,0x8
    800015c6:	95ea8a93          	add	s5,s5,-1698 # 80008f20 <proc_lock>
      p = 0;  // Reset the selected process to ensure a fair selection.
    800015ca:	4b81                	li	s7,0
          if (q->state == RUNNABLE) {
    800015cc:	498d                	li	s3,3
      for (q = proc; q < &proc[NPROC]; q++) {
    800015ce:	0000d917          	auipc	s2,0xd
    800015d2:	76a90913          	add	s2,s2,1898 # 8000ed38 <tickslock>
          p->state = RUNNING;
    800015d6:	4c91                	li	s9,4
          c->proc = p;
    800015d8:	079e                	sll	a5,a5,0x7
    800015da:	00007b17          	auipc	s6,0x7
    800015de:	516b0b13          	add	s6,s6,1302 # 80008af0 <pid_lock>
    800015e2:	9b3e                	add	s6,s6,a5
    800015e4:	a89d                	j	8000165a <scheduler+0xd2>
    800015e6:	8a26                	mv	s4,s1
          release(&q->lock);
    800015e8:	8526                	mv	a0,s1
    800015ea:	00005097          	auipc	ra,0x5
    800015ee:	0e2080e7          	jalr	226(ra) # 800066cc <release>
      for (q = proc; q < &proc[NPROC]; q++) {
    800015f2:	17848493          	add	s1,s1,376
    800015f6:	03248463          	beq	s1,s2,8000161e <scheduler+0x96>
          acquire(&q->lock);
    800015fa:	8526                	mv	a0,s1
    800015fc:	00005097          	auipc	ra,0x5
    80001600:	01c080e7          	jalr	28(ra) # 80006618 <acquire>
          if (q->state == RUNNABLE) {
    80001604:	4c9c                	lw	a5,24(s1)
    80001606:	ff3791e3          	bne	a5,s3,800015e8 <scheduler+0x60>
              if (!p || q->priority < p->priority) {
    8000160a:	fc0a0ee3          	beqz	s4,800015e6 <scheduler+0x5e>
    8000160e:	1744a703          	lw	a4,372(s1)
    80001612:	174a2783          	lw	a5,372(s4)
    80001616:	fcf759e3          	bge	a4,a5,800015e8 <scheduler+0x60>
    8000161a:	8a26                	mv	s4,s1
    8000161c:	b7f1                	j	800015e8 <scheduler+0x60>
      if (p) {
    8000161e:	040a0f63          	beqz	s4,8000167c <scheduler+0xf4>
          acquire(&p->lock);
    80001622:	8552                	mv	a0,s4
    80001624:	00005097          	auipc	ra,0x5
    80001628:	ff4080e7          	jalr	-12(ra) # 80006618 <acquire>
          p->state = RUNNING;
    8000162c:	019a2c23          	sw	s9,24(s4)
          release(&proc_lock);
    80001630:	8556                	mv	a0,s5
    80001632:	00005097          	auipc	ra,0x5
    80001636:	09a080e7          	jalr	154(ra) # 800066cc <release>
          c->proc = p;
    8000163a:	034b3823          	sd	s4,48(s6)
          swtch(&c->context, &p->context);
    8000163e:	068a0593          	add	a1,s4,104
    80001642:	8562                	mv	a0,s8
    80001644:	00000097          	auipc	ra,0x0
    80001648:	73c080e7          	jalr	1852(ra) # 80001d80 <swtch>
          c->proc = 0;
    8000164c:	020b3823          	sd	zero,48(s6)
          release(&p->lock);
    80001650:	8552                	mv	a0,s4
    80001652:	00005097          	auipc	ra,0x5
    80001656:	07a080e7          	jalr	122(ra) # 800066cc <release>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000165a:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000165e:	0027e793          	or	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001662:	10079073          	csrw	sstatus,a5
      acquire(&proc_lock);
    80001666:	8556                	mv	a0,s5
    80001668:	00005097          	auipc	ra,0x5
    8000166c:	fb0080e7          	jalr	-80(ra) # 80006618 <acquire>
      for (q = proc; q < &proc[NPROC]; q++) {
    80001670:	00008497          	auipc	s1,0x8
    80001674:	8c848493          	add	s1,s1,-1848 # 80008f38 <proc>
      p = 0;  // Reset the selected process to ensure a fair selection.
    80001678:	8a5e                	mv	s4,s7
    8000167a:	b741                	j	800015fa <scheduler+0x72>
          release(&proc_lock);
    8000167c:	8556                	mv	a0,s5
    8000167e:	00005097          	auipc	ra,0x5
    80001682:	04e080e7          	jalr	78(ra) # 800066cc <release>
    80001686:	bfd1                	j	8000165a <scheduler+0xd2>

0000000080001688 <sched>:
{
    80001688:	7179                	add	sp,sp,-48
    8000168a:	f406                	sd	ra,40(sp)
    8000168c:	f022                	sd	s0,32(sp)
    8000168e:	ec26                	sd	s1,24(sp)
    80001690:	e84a                	sd	s2,16(sp)
    80001692:	e44e                	sd	s3,8(sp)
    80001694:	1800                	add	s0,sp,48
  struct proc *p = myproc();
    80001696:	00000097          	auipc	ra,0x0
    8000169a:	934080e7          	jalr	-1740(ra) # 80000fca <myproc>
    8000169e:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    800016a0:	00005097          	auipc	ra,0x5
    800016a4:	efe080e7          	jalr	-258(ra) # 8000659e <holding>
    800016a8:	c93d                	beqz	a0,8000171e <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    800016aa:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    800016ac:	2781                	sext.w	a5,a5
    800016ae:	079e                	sll	a5,a5,0x7
    800016b0:	00007717          	auipc	a4,0x7
    800016b4:	44070713          	add	a4,a4,1088 # 80008af0 <pid_lock>
    800016b8:	97ba                	add	a5,a5,a4
    800016ba:	0a87a703          	lw	a4,168(a5)
    800016be:	4785                	li	a5,1
    800016c0:	06f71763          	bne	a4,a5,8000172e <sched+0xa6>
  if(p->state == RUNNING)
    800016c4:	4c98                	lw	a4,24(s1)
    800016c6:	4791                	li	a5,4
    800016c8:	06f70b63          	beq	a4,a5,8000173e <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800016cc:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800016d0:	8b89                	and	a5,a5,2
  if(intr_get())
    800016d2:	efb5                	bnez	a5,8000174e <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    800016d4:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    800016d6:	00007917          	auipc	s2,0x7
    800016da:	41a90913          	add	s2,s2,1050 # 80008af0 <pid_lock>
    800016de:	2781                	sext.w	a5,a5
    800016e0:	079e                	sll	a5,a5,0x7
    800016e2:	97ca                	add	a5,a5,s2
    800016e4:	0ac7a983          	lw	s3,172(a5)
    800016e8:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    800016ea:	2781                	sext.w	a5,a5
    800016ec:	079e                	sll	a5,a5,0x7
    800016ee:	00007597          	auipc	a1,0x7
    800016f2:	43a58593          	add	a1,a1,1082 # 80008b28 <cpus+0x8>
    800016f6:	95be                	add	a1,a1,a5
    800016f8:	06848513          	add	a0,s1,104
    800016fc:	00000097          	auipc	ra,0x0
    80001700:	684080e7          	jalr	1668(ra) # 80001d80 <swtch>
    80001704:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80001706:	2781                	sext.w	a5,a5
    80001708:	079e                	sll	a5,a5,0x7
    8000170a:	993e                	add	s2,s2,a5
    8000170c:	0b392623          	sw	s3,172(s2)
}
    80001710:	70a2                	ld	ra,40(sp)
    80001712:	7402                	ld	s0,32(sp)
    80001714:	64e2                	ld	s1,24(sp)
    80001716:	6942                	ld	s2,16(sp)
    80001718:	69a2                	ld	s3,8(sp)
    8000171a:	6145                	add	sp,sp,48
    8000171c:	8082                	ret
    panic("sched p->lock");
    8000171e:	00007517          	auipc	a0,0x7
    80001722:	ab250513          	add	a0,a0,-1358 # 800081d0 <etext+0x1d0>
    80001726:	00005097          	auipc	ra,0x5
    8000172a:	9ba080e7          	jalr	-1606(ra) # 800060e0 <panic>
    panic("sched locks");
    8000172e:	00007517          	auipc	a0,0x7
    80001732:	ab250513          	add	a0,a0,-1358 # 800081e0 <etext+0x1e0>
    80001736:	00005097          	auipc	ra,0x5
    8000173a:	9aa080e7          	jalr	-1622(ra) # 800060e0 <panic>
    panic("sched running");
    8000173e:	00007517          	auipc	a0,0x7
    80001742:	ab250513          	add	a0,a0,-1358 # 800081f0 <etext+0x1f0>
    80001746:	00005097          	auipc	ra,0x5
    8000174a:	99a080e7          	jalr	-1638(ra) # 800060e0 <panic>
    panic("sched interruptible");
    8000174e:	00007517          	auipc	a0,0x7
    80001752:	ab250513          	add	a0,a0,-1358 # 80008200 <etext+0x200>
    80001756:	00005097          	auipc	ra,0x5
    8000175a:	98a080e7          	jalr	-1654(ra) # 800060e0 <panic>

000000008000175e <yield>:
{
    8000175e:	1101                	add	sp,sp,-32
    80001760:	ec06                	sd	ra,24(sp)
    80001762:	e822                	sd	s0,16(sp)
    80001764:	e426                	sd	s1,8(sp)
    80001766:	1000                	add	s0,sp,32
  struct proc *p = myproc();
    80001768:	00000097          	auipc	ra,0x0
    8000176c:	862080e7          	jalr	-1950(ra) # 80000fca <myproc>
    80001770:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80001772:	00005097          	auipc	ra,0x5
    80001776:	ea6080e7          	jalr	-346(ra) # 80006618 <acquire>
  p->state = RUNNABLE;
    8000177a:	478d                	li	a5,3
    8000177c:	cc9c                	sw	a5,24(s1)
  sched();
    8000177e:	00000097          	auipc	ra,0x0
    80001782:	f0a080e7          	jalr	-246(ra) # 80001688 <sched>
  release(&p->lock);
    80001786:	8526                	mv	a0,s1
    80001788:	00005097          	auipc	ra,0x5
    8000178c:	f44080e7          	jalr	-188(ra) # 800066cc <release>
}
    80001790:	60e2                	ld	ra,24(sp)
    80001792:	6442                	ld	s0,16(sp)
    80001794:	64a2                	ld	s1,8(sp)
    80001796:	6105                	add	sp,sp,32
    80001798:	8082                	ret

000000008000179a <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    8000179a:	7179                	add	sp,sp,-48
    8000179c:	f406                	sd	ra,40(sp)
    8000179e:	f022                	sd	s0,32(sp)
    800017a0:	ec26                	sd	s1,24(sp)
    800017a2:	e84a                	sd	s2,16(sp)
    800017a4:	e44e                	sd	s3,8(sp)
    800017a6:	1800                	add	s0,sp,48
    800017a8:	89aa                	mv	s3,a0
    800017aa:	892e                	mv	s2,a1
  struct proc *p = myproc();
    800017ac:	00000097          	auipc	ra,0x0
    800017b0:	81e080e7          	jalr	-2018(ra) # 80000fca <myproc>
    800017b4:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    800017b6:	00005097          	auipc	ra,0x5
    800017ba:	e62080e7          	jalr	-414(ra) # 80006618 <acquire>
  release(lk);
    800017be:	854a                	mv	a0,s2
    800017c0:	00005097          	auipc	ra,0x5
    800017c4:	f0c080e7          	jalr	-244(ra) # 800066cc <release>

  // Go to sleep.
  p->chan = chan;
    800017c8:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    800017cc:	4789                	li	a5,2
    800017ce:	cc9c                	sw	a5,24(s1)

  sched();
    800017d0:	00000097          	auipc	ra,0x0
    800017d4:	eb8080e7          	jalr	-328(ra) # 80001688 <sched>

  // Tidy up.
  p->chan = 0;
    800017d8:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    800017dc:	8526                	mv	a0,s1
    800017de:	00005097          	auipc	ra,0x5
    800017e2:	eee080e7          	jalr	-274(ra) # 800066cc <release>
  acquire(lk);
    800017e6:	854a                	mv	a0,s2
    800017e8:	00005097          	auipc	ra,0x5
    800017ec:	e30080e7          	jalr	-464(ra) # 80006618 <acquire>
}
    800017f0:	70a2                	ld	ra,40(sp)
    800017f2:	7402                	ld	s0,32(sp)
    800017f4:	64e2                	ld	s1,24(sp)
    800017f6:	6942                	ld	s2,16(sp)
    800017f8:	69a2                	ld	s3,8(sp)
    800017fa:	6145                	add	sp,sp,48
    800017fc:	8082                	ret

00000000800017fe <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    800017fe:	7139                	add	sp,sp,-64
    80001800:	fc06                	sd	ra,56(sp)
    80001802:	f822                	sd	s0,48(sp)
    80001804:	f426                	sd	s1,40(sp)
    80001806:	f04a                	sd	s2,32(sp)
    80001808:	ec4e                	sd	s3,24(sp)
    8000180a:	e852                	sd	s4,16(sp)
    8000180c:	e456                	sd	s5,8(sp)
    8000180e:	0080                	add	s0,sp,64
    80001810:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    80001812:	00007497          	auipc	s1,0x7
    80001816:	72648493          	add	s1,s1,1830 # 80008f38 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    8000181a:	4989                	li	s3,2
        p->state = RUNNABLE;
    8000181c:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    8000181e:	0000d917          	auipc	s2,0xd
    80001822:	51a90913          	add	s2,s2,1306 # 8000ed38 <tickslock>
    80001826:	a811                	j	8000183a <wakeup+0x3c>
      }
      release(&p->lock);
    80001828:	8526                	mv	a0,s1
    8000182a:	00005097          	auipc	ra,0x5
    8000182e:	ea2080e7          	jalr	-350(ra) # 800066cc <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001832:	17848493          	add	s1,s1,376
    80001836:	03248663          	beq	s1,s2,80001862 <wakeup+0x64>
    if(p != myproc()){
    8000183a:	fffff097          	auipc	ra,0xfffff
    8000183e:	790080e7          	jalr	1936(ra) # 80000fca <myproc>
    80001842:	fea488e3          	beq	s1,a0,80001832 <wakeup+0x34>
      acquire(&p->lock);
    80001846:	8526                	mv	a0,s1
    80001848:	00005097          	auipc	ra,0x5
    8000184c:	dd0080e7          	jalr	-560(ra) # 80006618 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    80001850:	4c9c                	lw	a5,24(s1)
    80001852:	fd379be3          	bne	a5,s3,80001828 <wakeup+0x2a>
    80001856:	709c                	ld	a5,32(s1)
    80001858:	fd4798e3          	bne	a5,s4,80001828 <wakeup+0x2a>
        p->state = RUNNABLE;
    8000185c:	0154ac23          	sw	s5,24(s1)
    80001860:	b7e1                	j	80001828 <wakeup+0x2a>
    }
  }
}
    80001862:	70e2                	ld	ra,56(sp)
    80001864:	7442                	ld	s0,48(sp)
    80001866:	74a2                	ld	s1,40(sp)
    80001868:	7902                	ld	s2,32(sp)
    8000186a:	69e2                	ld	s3,24(sp)
    8000186c:	6a42                	ld	s4,16(sp)
    8000186e:	6aa2                	ld	s5,8(sp)
    80001870:	6121                	add	sp,sp,64
    80001872:	8082                	ret

0000000080001874 <reparent>:
{
    80001874:	7179                	add	sp,sp,-48
    80001876:	f406                	sd	ra,40(sp)
    80001878:	f022                	sd	s0,32(sp)
    8000187a:	ec26                	sd	s1,24(sp)
    8000187c:	e84a                	sd	s2,16(sp)
    8000187e:	e44e                	sd	s3,8(sp)
    80001880:	e052                	sd	s4,0(sp)
    80001882:	1800                	add	s0,sp,48
    80001884:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001886:	00007497          	auipc	s1,0x7
    8000188a:	6b248493          	add	s1,s1,1714 # 80008f38 <proc>
      pp->parent = initproc;
    8000188e:	00007a17          	auipc	s4,0x7
    80001892:	212a0a13          	add	s4,s4,530 # 80008aa0 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001896:	0000d997          	auipc	s3,0xd
    8000189a:	4a298993          	add	s3,s3,1186 # 8000ed38 <tickslock>
    8000189e:	a029                	j	800018a8 <reparent+0x34>
    800018a0:	17848493          	add	s1,s1,376
    800018a4:	01348d63          	beq	s1,s3,800018be <reparent+0x4a>
    if(pp->parent == p){
    800018a8:	7c9c                	ld	a5,56(s1)
    800018aa:	ff279be3          	bne	a5,s2,800018a0 <reparent+0x2c>
      pp->parent = initproc;
    800018ae:	000a3503          	ld	a0,0(s4)
    800018b2:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    800018b4:	00000097          	auipc	ra,0x0
    800018b8:	f4a080e7          	jalr	-182(ra) # 800017fe <wakeup>
    800018bc:	b7d5                	j	800018a0 <reparent+0x2c>
}
    800018be:	70a2                	ld	ra,40(sp)
    800018c0:	7402                	ld	s0,32(sp)
    800018c2:	64e2                	ld	s1,24(sp)
    800018c4:	6942                	ld	s2,16(sp)
    800018c6:	69a2                	ld	s3,8(sp)
    800018c8:	6a02                	ld	s4,0(sp)
    800018ca:	6145                	add	sp,sp,48
    800018cc:	8082                	ret

00000000800018ce <exit>:
{
    800018ce:	7179                	add	sp,sp,-48
    800018d0:	f406                	sd	ra,40(sp)
    800018d2:	f022                	sd	s0,32(sp)
    800018d4:	ec26                	sd	s1,24(sp)
    800018d6:	e84a                	sd	s2,16(sp)
    800018d8:	e44e                	sd	s3,8(sp)
    800018da:	e052                	sd	s4,0(sp)
    800018dc:	1800                	add	s0,sp,48
    800018de:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    800018e0:	fffff097          	auipc	ra,0xfffff
    800018e4:	6ea080e7          	jalr	1770(ra) # 80000fca <myproc>
    800018e8:	89aa                	mv	s3,a0
  if(p == initproc)
    800018ea:	00007797          	auipc	a5,0x7
    800018ee:	1b67b783          	ld	a5,438(a5) # 80008aa0 <initproc>
    800018f2:	0d850493          	add	s1,a0,216
    800018f6:	15850913          	add	s2,a0,344
    800018fa:	02a79363          	bne	a5,a0,80001920 <exit+0x52>
    panic("init exiting");
    800018fe:	00007517          	auipc	a0,0x7
    80001902:	91a50513          	add	a0,a0,-1766 # 80008218 <etext+0x218>
    80001906:	00004097          	auipc	ra,0x4
    8000190a:	7da080e7          	jalr	2010(ra) # 800060e0 <panic>
      fileclose(f);
    8000190e:	00002097          	auipc	ra,0x2
    80001912:	532080e7          	jalr	1330(ra) # 80003e40 <fileclose>
      p->ofile[fd] = 0;
    80001916:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    8000191a:	04a1                	add	s1,s1,8
    8000191c:	01248563          	beq	s1,s2,80001926 <exit+0x58>
    if(p->ofile[fd]){
    80001920:	6088                	ld	a0,0(s1)
    80001922:	f575                	bnez	a0,8000190e <exit+0x40>
    80001924:	bfdd                	j	8000191a <exit+0x4c>
  begin_op();
    80001926:	00002097          	auipc	ra,0x2
    8000192a:	056080e7          	jalr	86(ra) # 8000397c <begin_op>
  iput(p->cwd);
    8000192e:	1589b503          	ld	a0,344(s3)
    80001932:	00002097          	auipc	ra,0x2
    80001936:	85e080e7          	jalr	-1954(ra) # 80003190 <iput>
  end_op();
    8000193a:	00002097          	auipc	ra,0x2
    8000193e:	0bc080e7          	jalr	188(ra) # 800039f6 <end_op>
  p->cwd = 0;
    80001942:	1409bc23          	sd	zero,344(s3)
  acquire(&wait_lock);
    80001946:	00007497          	auipc	s1,0x7
    8000194a:	1c248493          	add	s1,s1,450 # 80008b08 <wait_lock>
    8000194e:	8526                	mv	a0,s1
    80001950:	00005097          	auipc	ra,0x5
    80001954:	cc8080e7          	jalr	-824(ra) # 80006618 <acquire>
  reparent(p);
    80001958:	854e                	mv	a0,s3
    8000195a:	00000097          	auipc	ra,0x0
    8000195e:	f1a080e7          	jalr	-230(ra) # 80001874 <reparent>
  wakeup(p->parent);
    80001962:	0389b503          	ld	a0,56(s3)
    80001966:	00000097          	auipc	ra,0x0
    8000196a:	e98080e7          	jalr	-360(ra) # 800017fe <wakeup>
  acquire(&p->lock);
    8000196e:	854e                	mv	a0,s3
    80001970:	00005097          	auipc	ra,0x5
    80001974:	ca8080e7          	jalr	-856(ra) # 80006618 <acquire>
  p->xstate = status;
    80001978:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    8000197c:	4795                	li	a5,5
    8000197e:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    80001982:	8526                	mv	a0,s1
    80001984:	00005097          	auipc	ra,0x5
    80001988:	d48080e7          	jalr	-696(ra) # 800066cc <release>
  sched();
    8000198c:	00000097          	auipc	ra,0x0
    80001990:	cfc080e7          	jalr	-772(ra) # 80001688 <sched>
  panic("zombie exit");
    80001994:	00007517          	auipc	a0,0x7
    80001998:	89450513          	add	a0,a0,-1900 # 80008228 <etext+0x228>
    8000199c:	00004097          	auipc	ra,0x4
    800019a0:	744080e7          	jalr	1860(ra) # 800060e0 <panic>

00000000800019a4 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    800019a4:	7179                	add	sp,sp,-48
    800019a6:	f406                	sd	ra,40(sp)
    800019a8:	f022                	sd	s0,32(sp)
    800019aa:	ec26                	sd	s1,24(sp)
    800019ac:	e84a                	sd	s2,16(sp)
    800019ae:	e44e                	sd	s3,8(sp)
    800019b0:	1800                	add	s0,sp,48
    800019b2:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    800019b4:	00007497          	auipc	s1,0x7
    800019b8:	58448493          	add	s1,s1,1412 # 80008f38 <proc>
    800019bc:	0000d997          	auipc	s3,0xd
    800019c0:	37c98993          	add	s3,s3,892 # 8000ed38 <tickslock>
    acquire(&p->lock);
    800019c4:	8526                	mv	a0,s1
    800019c6:	00005097          	auipc	ra,0x5
    800019ca:	c52080e7          	jalr	-942(ra) # 80006618 <acquire>
    if(p->pid == pid){
    800019ce:	589c                	lw	a5,48(s1)
    800019d0:	01278d63          	beq	a5,s2,800019ea <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    800019d4:	8526                	mv	a0,s1
    800019d6:	00005097          	auipc	ra,0x5
    800019da:	cf6080e7          	jalr	-778(ra) # 800066cc <release>
  for(p = proc; p < &proc[NPROC]; p++){
    800019de:	17848493          	add	s1,s1,376
    800019e2:	ff3491e3          	bne	s1,s3,800019c4 <kill+0x20>
  }
  return -1;
    800019e6:	557d                	li	a0,-1
    800019e8:	a829                	j	80001a02 <kill+0x5e>
      p->killed = 1;
    800019ea:	4785                	li	a5,1
    800019ec:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    800019ee:	4c98                	lw	a4,24(s1)
    800019f0:	4789                	li	a5,2
    800019f2:	00f70f63          	beq	a4,a5,80001a10 <kill+0x6c>
      release(&p->lock);
    800019f6:	8526                	mv	a0,s1
    800019f8:	00005097          	auipc	ra,0x5
    800019fc:	cd4080e7          	jalr	-812(ra) # 800066cc <release>
      return 0;
    80001a00:	4501                	li	a0,0
}
    80001a02:	70a2                	ld	ra,40(sp)
    80001a04:	7402                	ld	s0,32(sp)
    80001a06:	64e2                	ld	s1,24(sp)
    80001a08:	6942                	ld	s2,16(sp)
    80001a0a:	69a2                	ld	s3,8(sp)
    80001a0c:	6145                	add	sp,sp,48
    80001a0e:	8082                	ret
        p->state = RUNNABLE;
    80001a10:	478d                	li	a5,3
    80001a12:	cc9c                	sw	a5,24(s1)
    80001a14:	b7cd                	j	800019f6 <kill+0x52>

0000000080001a16 <setkilled>:

void
setkilled(struct proc *p)
{
    80001a16:	1101                	add	sp,sp,-32
    80001a18:	ec06                	sd	ra,24(sp)
    80001a1a:	e822                	sd	s0,16(sp)
    80001a1c:	e426                	sd	s1,8(sp)
    80001a1e:	1000                	add	s0,sp,32
    80001a20:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80001a22:	00005097          	auipc	ra,0x5
    80001a26:	bf6080e7          	jalr	-1034(ra) # 80006618 <acquire>
  p->killed = 1;
    80001a2a:	4785                	li	a5,1
    80001a2c:	d49c                	sw	a5,40(s1)
  release(&p->lock);
    80001a2e:	8526                	mv	a0,s1
    80001a30:	00005097          	auipc	ra,0x5
    80001a34:	c9c080e7          	jalr	-868(ra) # 800066cc <release>
}
    80001a38:	60e2                	ld	ra,24(sp)
    80001a3a:	6442                	ld	s0,16(sp)
    80001a3c:	64a2                	ld	s1,8(sp)
    80001a3e:	6105                	add	sp,sp,32
    80001a40:	8082                	ret

0000000080001a42 <killed>:

int
killed(struct proc *p)
{
    80001a42:	1101                	add	sp,sp,-32
    80001a44:	ec06                	sd	ra,24(sp)
    80001a46:	e822                	sd	s0,16(sp)
    80001a48:	e426                	sd	s1,8(sp)
    80001a4a:	e04a                	sd	s2,0(sp)
    80001a4c:	1000                	add	s0,sp,32
    80001a4e:	84aa                	mv	s1,a0
  int k;
  
  acquire(&p->lock);
    80001a50:	00005097          	auipc	ra,0x5
    80001a54:	bc8080e7          	jalr	-1080(ra) # 80006618 <acquire>
  k = p->killed;
    80001a58:	0284a903          	lw	s2,40(s1)
  release(&p->lock);
    80001a5c:	8526                	mv	a0,s1
    80001a5e:	00005097          	auipc	ra,0x5
    80001a62:	c6e080e7          	jalr	-914(ra) # 800066cc <release>
  return k;
}
    80001a66:	854a                	mv	a0,s2
    80001a68:	60e2                	ld	ra,24(sp)
    80001a6a:	6442                	ld	s0,16(sp)
    80001a6c:	64a2                	ld	s1,8(sp)
    80001a6e:	6902                	ld	s2,0(sp)
    80001a70:	6105                	add	sp,sp,32
    80001a72:	8082                	ret

0000000080001a74 <wait>:
{
    80001a74:	715d                	add	sp,sp,-80
    80001a76:	e486                	sd	ra,72(sp)
    80001a78:	e0a2                	sd	s0,64(sp)
    80001a7a:	fc26                	sd	s1,56(sp)
    80001a7c:	f84a                	sd	s2,48(sp)
    80001a7e:	f44e                	sd	s3,40(sp)
    80001a80:	f052                	sd	s4,32(sp)
    80001a82:	ec56                	sd	s5,24(sp)
    80001a84:	e85a                	sd	s6,16(sp)
    80001a86:	e45e                	sd	s7,8(sp)
    80001a88:	e062                	sd	s8,0(sp)
    80001a8a:	0880                	add	s0,sp,80
    80001a8c:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    80001a8e:	fffff097          	auipc	ra,0xfffff
    80001a92:	53c080e7          	jalr	1340(ra) # 80000fca <myproc>
    80001a96:	892a                	mv	s2,a0
  acquire(&wait_lock);
    80001a98:	00007517          	auipc	a0,0x7
    80001a9c:	07050513          	add	a0,a0,112 # 80008b08 <wait_lock>
    80001aa0:	00005097          	auipc	ra,0x5
    80001aa4:	b78080e7          	jalr	-1160(ra) # 80006618 <acquire>
    havekids = 0;
    80001aa8:	4b81                	li	s7,0
        if(pp->state == ZOMBIE){
    80001aaa:	4a15                	li	s4,5
        havekids = 1;
    80001aac:	4a85                	li	s5,1
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001aae:	0000d997          	auipc	s3,0xd
    80001ab2:	28a98993          	add	s3,s3,650 # 8000ed38 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001ab6:	00007c17          	auipc	s8,0x7
    80001aba:	052c0c13          	add	s8,s8,82 # 80008b08 <wait_lock>
    80001abe:	a0d1                	j	80001b82 <wait+0x10e>
          pid = pp->pid;
    80001ac0:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    80001ac4:	000b0e63          	beqz	s6,80001ae0 <wait+0x6c>
    80001ac8:	4691                	li	a3,4
    80001aca:	02c48613          	add	a2,s1,44
    80001ace:	85da                	mv	a1,s6
    80001ad0:	05093503          	ld	a0,80(s2)
    80001ad4:	fffff097          	auipc	ra,0xfffff
    80001ad8:	088080e7          	jalr	136(ra) # 80000b5c <copyout>
    80001adc:	04054163          	bltz	a0,80001b1e <wait+0xaa>
          freeproc(pp);
    80001ae0:	8526                	mv	a0,s1
    80001ae2:	fffff097          	auipc	ra,0xfffff
    80001ae6:	70c080e7          	jalr	1804(ra) # 800011ee <freeproc>
          release(&pp->lock);
    80001aea:	8526                	mv	a0,s1
    80001aec:	00005097          	auipc	ra,0x5
    80001af0:	be0080e7          	jalr	-1056(ra) # 800066cc <release>
          release(&wait_lock);
    80001af4:	00007517          	auipc	a0,0x7
    80001af8:	01450513          	add	a0,a0,20 # 80008b08 <wait_lock>
    80001afc:	00005097          	auipc	ra,0x5
    80001b00:	bd0080e7          	jalr	-1072(ra) # 800066cc <release>
}
    80001b04:	854e                	mv	a0,s3
    80001b06:	60a6                	ld	ra,72(sp)
    80001b08:	6406                	ld	s0,64(sp)
    80001b0a:	74e2                	ld	s1,56(sp)
    80001b0c:	7942                	ld	s2,48(sp)
    80001b0e:	79a2                	ld	s3,40(sp)
    80001b10:	7a02                	ld	s4,32(sp)
    80001b12:	6ae2                	ld	s5,24(sp)
    80001b14:	6b42                	ld	s6,16(sp)
    80001b16:	6ba2                	ld	s7,8(sp)
    80001b18:	6c02                	ld	s8,0(sp)
    80001b1a:	6161                	add	sp,sp,80
    80001b1c:	8082                	ret
            release(&pp->lock);
    80001b1e:	8526                	mv	a0,s1
    80001b20:	00005097          	auipc	ra,0x5
    80001b24:	bac080e7          	jalr	-1108(ra) # 800066cc <release>
            release(&wait_lock);
    80001b28:	00007517          	auipc	a0,0x7
    80001b2c:	fe050513          	add	a0,a0,-32 # 80008b08 <wait_lock>
    80001b30:	00005097          	auipc	ra,0x5
    80001b34:	b9c080e7          	jalr	-1124(ra) # 800066cc <release>
            return -1;
    80001b38:	59fd                	li	s3,-1
    80001b3a:	b7e9                	j	80001b04 <wait+0x90>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001b3c:	17848493          	add	s1,s1,376
    80001b40:	03348463          	beq	s1,s3,80001b68 <wait+0xf4>
      if(pp->parent == p){
    80001b44:	7c9c                	ld	a5,56(s1)
    80001b46:	ff279be3          	bne	a5,s2,80001b3c <wait+0xc8>
        acquire(&pp->lock);
    80001b4a:	8526                	mv	a0,s1
    80001b4c:	00005097          	auipc	ra,0x5
    80001b50:	acc080e7          	jalr	-1332(ra) # 80006618 <acquire>
        if(pp->state == ZOMBIE){
    80001b54:	4c9c                	lw	a5,24(s1)
    80001b56:	f74785e3          	beq	a5,s4,80001ac0 <wait+0x4c>
        release(&pp->lock);
    80001b5a:	8526                	mv	a0,s1
    80001b5c:	00005097          	auipc	ra,0x5
    80001b60:	b70080e7          	jalr	-1168(ra) # 800066cc <release>
        havekids = 1;
    80001b64:	8756                	mv	a4,s5
    80001b66:	bfd9                	j	80001b3c <wait+0xc8>
    if(!havekids || killed(p)){
    80001b68:	c31d                	beqz	a4,80001b8e <wait+0x11a>
    80001b6a:	854a                	mv	a0,s2
    80001b6c:	00000097          	auipc	ra,0x0
    80001b70:	ed6080e7          	jalr	-298(ra) # 80001a42 <killed>
    80001b74:	ed09                	bnez	a0,80001b8e <wait+0x11a>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001b76:	85e2                	mv	a1,s8
    80001b78:	854a                	mv	a0,s2
    80001b7a:	00000097          	auipc	ra,0x0
    80001b7e:	c20080e7          	jalr	-992(ra) # 8000179a <sleep>
    havekids = 0;
    80001b82:	875e                	mv	a4,s7
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001b84:	00007497          	auipc	s1,0x7
    80001b88:	3b448493          	add	s1,s1,948 # 80008f38 <proc>
    80001b8c:	bf65                	j	80001b44 <wait+0xd0>
      release(&wait_lock);
    80001b8e:	00007517          	auipc	a0,0x7
    80001b92:	f7a50513          	add	a0,a0,-134 # 80008b08 <wait_lock>
    80001b96:	00005097          	auipc	ra,0x5
    80001b9a:	b36080e7          	jalr	-1226(ra) # 800066cc <release>
      return -1;
    80001b9e:	59fd                	li	s3,-1
    80001ba0:	b795                	j	80001b04 <wait+0x90>

0000000080001ba2 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80001ba2:	7179                	add	sp,sp,-48
    80001ba4:	f406                	sd	ra,40(sp)
    80001ba6:	f022                	sd	s0,32(sp)
    80001ba8:	ec26                	sd	s1,24(sp)
    80001baa:	e84a                	sd	s2,16(sp)
    80001bac:	e44e                	sd	s3,8(sp)
    80001bae:	e052                	sd	s4,0(sp)
    80001bb0:	1800                	add	s0,sp,48
    80001bb2:	84aa                	mv	s1,a0
    80001bb4:	892e                	mv	s2,a1
    80001bb6:	89b2                	mv	s3,a2
    80001bb8:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001bba:	fffff097          	auipc	ra,0xfffff
    80001bbe:	410080e7          	jalr	1040(ra) # 80000fca <myproc>
  if(user_dst){
    80001bc2:	c08d                	beqz	s1,80001be4 <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    80001bc4:	86d2                	mv	a3,s4
    80001bc6:	864e                	mv	a2,s3
    80001bc8:	85ca                	mv	a1,s2
    80001bca:	6928                	ld	a0,80(a0)
    80001bcc:	fffff097          	auipc	ra,0xfffff
    80001bd0:	f90080e7          	jalr	-112(ra) # 80000b5c <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    80001bd4:	70a2                	ld	ra,40(sp)
    80001bd6:	7402                	ld	s0,32(sp)
    80001bd8:	64e2                	ld	s1,24(sp)
    80001bda:	6942                	ld	s2,16(sp)
    80001bdc:	69a2                	ld	s3,8(sp)
    80001bde:	6a02                	ld	s4,0(sp)
    80001be0:	6145                	add	sp,sp,48
    80001be2:	8082                	ret
    memmove((char *)dst, src, len);
    80001be4:	000a061b          	sext.w	a2,s4
    80001be8:	85ce                	mv	a1,s3
    80001bea:	854a                	mv	a0,s2
    80001bec:	ffffe097          	auipc	ra,0xffffe
    80001bf0:	634080e7          	jalr	1588(ra) # 80000220 <memmove>
    return 0;
    80001bf4:	8526                	mv	a0,s1
    80001bf6:	bff9                	j	80001bd4 <either_copyout+0x32>

0000000080001bf8 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80001bf8:	7179                	add	sp,sp,-48
    80001bfa:	f406                	sd	ra,40(sp)
    80001bfc:	f022                	sd	s0,32(sp)
    80001bfe:	ec26                	sd	s1,24(sp)
    80001c00:	e84a                	sd	s2,16(sp)
    80001c02:	e44e                	sd	s3,8(sp)
    80001c04:	e052                	sd	s4,0(sp)
    80001c06:	1800                	add	s0,sp,48
    80001c08:	892a                	mv	s2,a0
    80001c0a:	84ae                	mv	s1,a1
    80001c0c:	89b2                	mv	s3,a2
    80001c0e:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001c10:	fffff097          	auipc	ra,0xfffff
    80001c14:	3ba080e7          	jalr	954(ra) # 80000fca <myproc>
  if(user_src){
    80001c18:	c08d                	beqz	s1,80001c3a <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80001c1a:	86d2                	mv	a3,s4
    80001c1c:	864e                	mv	a2,s3
    80001c1e:	85ca                	mv	a1,s2
    80001c20:	6928                	ld	a0,80(a0)
    80001c22:	fffff097          	auipc	ra,0xfffff
    80001c26:	fc6080e7          	jalr	-58(ra) # 80000be8 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80001c2a:	70a2                	ld	ra,40(sp)
    80001c2c:	7402                	ld	s0,32(sp)
    80001c2e:	64e2                	ld	s1,24(sp)
    80001c30:	6942                	ld	s2,16(sp)
    80001c32:	69a2                	ld	s3,8(sp)
    80001c34:	6a02                	ld	s4,0(sp)
    80001c36:	6145                	add	sp,sp,48
    80001c38:	8082                	ret
    memmove(dst, (char*)src, len);
    80001c3a:	000a061b          	sext.w	a2,s4
    80001c3e:	85ce                	mv	a1,s3
    80001c40:	854a                	mv	a0,s2
    80001c42:	ffffe097          	auipc	ra,0xffffe
    80001c46:	5de080e7          	jalr	1502(ra) # 80000220 <memmove>
    return 0;
    80001c4a:	8526                	mv	a0,s1
    80001c4c:	bff9                	j	80001c2a <either_copyin+0x32>

0000000080001c4e <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80001c4e:	715d                	add	sp,sp,-80
    80001c50:	e486                	sd	ra,72(sp)
    80001c52:	e0a2                	sd	s0,64(sp)
    80001c54:	fc26                	sd	s1,56(sp)
    80001c56:	f84a                	sd	s2,48(sp)
    80001c58:	f44e                	sd	s3,40(sp)
    80001c5a:	f052                	sd	s4,32(sp)
    80001c5c:	ec56                	sd	s5,24(sp)
    80001c5e:	e85a                	sd	s6,16(sp)
    80001c60:	e45e                	sd	s7,8(sp)
    80001c62:	0880                	add	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80001c64:	00006517          	auipc	a0,0x6
    80001c68:	3e450513          	add	a0,a0,996 # 80008048 <etext+0x48>
    80001c6c:	00004097          	auipc	ra,0x4
    80001c70:	4be080e7          	jalr	1214(ra) # 8000612a <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001c74:	00007497          	auipc	s1,0x7
    80001c78:	42448493          	add	s1,s1,1060 # 80009098 <proc+0x160>
    80001c7c:	0000d917          	auipc	s2,0xd
    80001c80:	21c90913          	add	s2,s2,540 # 8000ee98 <bcache+0x148>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001c84:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80001c86:	00006997          	auipc	s3,0x6
    80001c8a:	5b298993          	add	s3,s3,1458 # 80008238 <etext+0x238>
    printf("%d %s %s", p->pid, state, p->name);
    80001c8e:	00006a97          	auipc	s5,0x6
    80001c92:	5b2a8a93          	add	s5,s5,1458 # 80008240 <etext+0x240>
    printf("\n");
    80001c96:	00006a17          	auipc	s4,0x6
    80001c9a:	3b2a0a13          	add	s4,s4,946 # 80008048 <etext+0x48>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001c9e:	00006b97          	auipc	s7,0x6
    80001ca2:	5e2b8b93          	add	s7,s7,1506 # 80008280 <states.0>
    80001ca6:	a00d                	j	80001cc8 <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    80001ca8:	ed06a583          	lw	a1,-304(a3)
    80001cac:	8556                	mv	a0,s5
    80001cae:	00004097          	auipc	ra,0x4
    80001cb2:	47c080e7          	jalr	1148(ra) # 8000612a <printf>
    printf("\n");
    80001cb6:	8552                	mv	a0,s4
    80001cb8:	00004097          	auipc	ra,0x4
    80001cbc:	472080e7          	jalr	1138(ra) # 8000612a <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001cc0:	17848493          	add	s1,s1,376
    80001cc4:	03248263          	beq	s1,s2,80001ce8 <procdump+0x9a>
    if(p->state == UNUSED)
    80001cc8:	86a6                	mv	a3,s1
    80001cca:	eb84a783          	lw	a5,-328(s1)
    80001cce:	dbed                	beqz	a5,80001cc0 <procdump+0x72>
      state = "???";
    80001cd0:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001cd2:	fcfb6be3          	bltu	s6,a5,80001ca8 <procdump+0x5a>
    80001cd6:	02079713          	sll	a4,a5,0x20
    80001cda:	01d75793          	srl	a5,a4,0x1d
    80001cde:	97de                	add	a5,a5,s7
    80001ce0:	6390                	ld	a2,0(a5)
    80001ce2:	f279                	bnez	a2,80001ca8 <procdump+0x5a>
      state = "???";
    80001ce4:	864e                	mv	a2,s3
    80001ce6:	b7c9                	j	80001ca8 <procdump+0x5a>
  }
}
    80001ce8:	60a6                	ld	ra,72(sp)
    80001cea:	6406                	ld	s0,64(sp)
    80001cec:	74e2                	ld	s1,56(sp)
    80001cee:	7942                	ld	s2,48(sp)
    80001cf0:	79a2                	ld	s3,40(sp)
    80001cf2:	7a02                	ld	s4,32(sp)
    80001cf4:	6ae2                	ld	s5,24(sp)
    80001cf6:	6b42                	ld	s6,16(sp)
    80001cf8:	6ba2                	ld	s7,8(sp)
    80001cfa:	6161                	add	sp,sp,80
    80001cfc:	8082                	ret

0000000080001cfe <procsinuse>:

// Returns the number of processes whose state is not UNUSED
uint64
procsinuse(void)
{
    80001cfe:	1141                	add	sp,sp,-16
    80001d00:	e422                	sd	s0,8(sp)
    80001d02:	0800                	add	s0,sp,16
  struct proc *p;
  uint64 num_procs = 0;
    80001d04:	4501                	li	a0,0
  for(p = proc; p < &proc[NPROC]; p++){
    80001d06:	00007797          	auipc	a5,0x7
    80001d0a:	23278793          	add	a5,a5,562 # 80008f38 <proc>
    80001d0e:	0000d697          	auipc	a3,0xd
    80001d12:	02a68693          	add	a3,a3,42 # 8000ed38 <tickslock>
    if(p->state != UNUSED)
    80001d16:	4f98                	lw	a4,24(a5)
      num_procs++;
    80001d18:	00e03733          	snez	a4,a4
    80001d1c:	953a                	add	a0,a0,a4
  for(p = proc; p < &proc[NPROC]; p++){
    80001d1e:	17878793          	add	a5,a5,376
    80001d22:	fed79ae3          	bne	a5,a3,80001d16 <procsinuse+0x18>
  }
  return num_procs;
}
    80001d26:	6422                	ld	s0,8(sp)
    80001d28:	0141                	add	sp,sp,16
    80001d2a:	8082                	ret

0000000080001d2c <setpriority>:

uint64
setpriority(int priority)
{
    80001d2c:	1101                	add	sp,sp,-32
    80001d2e:	ec06                	sd	ra,24(sp)
    80001d30:	e822                	sd	s0,16(sp)
    80001d32:	e426                	sd	s1,8(sp)
    80001d34:	e04a                	sd	s2,0(sp)
    80001d36:	1000                	add	s0,sp,32
    80001d38:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001d3a:	fffff097          	auipc	ra,0xfffff
    80001d3e:	290080e7          	jalr	656(ra) # 80000fca <myproc>
    80001d42:	892a                	mv	s2,a0
  acquire(&p->lock);
    80001d44:	00005097          	auipc	ra,0x5
    80001d48:	8d4080e7          	jalr	-1836(ra) # 80006618 <acquire>

  if (priority < 1 || priority > 10) {
    80001d4c:	fff4871b          	addw	a4,s1,-1
    80001d50:	47a5                	li	a5,9
    80001d52:	02e7e063          	bltu	a5,a4,80001d72 <setpriority+0x46>
      release(&p->lock);
      return -1;
  }

  p->priority = priority;
    80001d56:	16992a23          	sw	s1,372(s2)
  release(&p->lock);
    80001d5a:	854a                	mv	a0,s2
    80001d5c:	00005097          	auipc	ra,0x5
    80001d60:	970080e7          	jalr	-1680(ra) # 800066cc <release>
  return 0;
    80001d64:	4501                	li	a0,0
    80001d66:	60e2                	ld	ra,24(sp)
    80001d68:	6442                	ld	s0,16(sp)
    80001d6a:	64a2                	ld	s1,8(sp)
    80001d6c:	6902                	ld	s2,0(sp)
    80001d6e:	6105                	add	sp,sp,32
    80001d70:	8082                	ret
      release(&p->lock);
    80001d72:	854a                	mv	a0,s2
    80001d74:	00005097          	auipc	ra,0x5
    80001d78:	958080e7          	jalr	-1704(ra) # 800066cc <release>
      return -1;
    80001d7c:	557d                	li	a0,-1
    80001d7e:	b7e5                	j	80001d66 <setpriority+0x3a>

0000000080001d80 <swtch>:
    80001d80:	00153023          	sd	ra,0(a0)
    80001d84:	00253423          	sd	sp,8(a0)
    80001d88:	e900                	sd	s0,16(a0)
    80001d8a:	ed04                	sd	s1,24(a0)
    80001d8c:	03253023          	sd	s2,32(a0)
    80001d90:	03353423          	sd	s3,40(a0)
    80001d94:	03453823          	sd	s4,48(a0)
    80001d98:	03553c23          	sd	s5,56(a0)
    80001d9c:	05653023          	sd	s6,64(a0)
    80001da0:	05753423          	sd	s7,72(a0)
    80001da4:	05853823          	sd	s8,80(a0)
    80001da8:	05953c23          	sd	s9,88(a0)
    80001dac:	07a53023          	sd	s10,96(a0)
    80001db0:	07b53423          	sd	s11,104(a0)
    80001db4:	0005b083          	ld	ra,0(a1)
    80001db8:	0085b103          	ld	sp,8(a1)
    80001dbc:	6980                	ld	s0,16(a1)
    80001dbe:	6d84                	ld	s1,24(a1)
    80001dc0:	0205b903          	ld	s2,32(a1)
    80001dc4:	0285b983          	ld	s3,40(a1)
    80001dc8:	0305ba03          	ld	s4,48(a1)
    80001dcc:	0385ba83          	ld	s5,56(a1)
    80001dd0:	0405bb03          	ld	s6,64(a1)
    80001dd4:	0485bb83          	ld	s7,72(a1)
    80001dd8:	0505bc03          	ld	s8,80(a1)
    80001ddc:	0585bc83          	ld	s9,88(a1)
    80001de0:	0605bd03          	ld	s10,96(a1)
    80001de4:	0685bd83          	ld	s11,104(a1)
    80001de8:	8082                	ret

0000000080001dea <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001dea:	1141                	add	sp,sp,-16
    80001dec:	e406                	sd	ra,8(sp)
    80001dee:	e022                	sd	s0,0(sp)
    80001df0:	0800                	add	s0,sp,16
  initlock(&tickslock, "time");
    80001df2:	00006597          	auipc	a1,0x6
    80001df6:	4be58593          	add	a1,a1,1214 # 800082b0 <states.0+0x30>
    80001dfa:	0000d517          	auipc	a0,0xd
    80001dfe:	f3e50513          	add	a0,a0,-194 # 8000ed38 <tickslock>
    80001e02:	00004097          	auipc	ra,0x4
    80001e06:	786080e7          	jalr	1926(ra) # 80006588 <initlock>
}
    80001e0a:	60a2                	ld	ra,8(sp)
    80001e0c:	6402                	ld	s0,0(sp)
    80001e0e:	0141                	add	sp,sp,16
    80001e10:	8082                	ret

0000000080001e12 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001e12:	1141                	add	sp,sp,-16
    80001e14:	e422                	sd	s0,8(sp)
    80001e16:	0800                	add	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001e18:	00003797          	auipc	a5,0x3
    80001e1c:	64878793          	add	a5,a5,1608 # 80005460 <kernelvec>
    80001e20:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001e24:	6422                	ld	s0,8(sp)
    80001e26:	0141                	add	sp,sp,16
    80001e28:	8082                	ret

0000000080001e2a <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001e2a:	1141                	add	sp,sp,-16
    80001e2c:	e406                	sd	ra,8(sp)
    80001e2e:	e022                	sd	s0,0(sp)
    80001e30:	0800                	add	s0,sp,16
  struct proc *p = myproc();
    80001e32:	fffff097          	auipc	ra,0xfffff
    80001e36:	198080e7          	jalr	408(ra) # 80000fca <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001e3a:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001e3e:	9bf5                	and	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001e40:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    80001e44:	00005697          	auipc	a3,0x5
    80001e48:	1bc68693          	add	a3,a3,444 # 80007000 <_trampoline>
    80001e4c:	00005717          	auipc	a4,0x5
    80001e50:	1b470713          	add	a4,a4,436 # 80007000 <_trampoline>
    80001e54:	8f15                	sub	a4,a4,a3
    80001e56:	040007b7          	lui	a5,0x4000
    80001e5a:	17fd                	add	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80001e5c:	07b2                	sll	a5,a5,0xc
    80001e5e:	973e                	add	a4,a4,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001e60:	10571073          	csrw	stvec,a4
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80001e64:	7138                	ld	a4,96(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80001e66:	18002673          	csrr	a2,satp
    80001e6a:	e310                	sd	a2,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001e6c:	7130                	ld	a2,96(a0)
    80001e6e:	6138                	ld	a4,64(a0)
    80001e70:	6585                	lui	a1,0x1
    80001e72:	972e                	add	a4,a4,a1
    80001e74:	e618                	sd	a4,8(a2)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001e76:	7138                	ld	a4,96(a0)
    80001e78:	00000617          	auipc	a2,0x0
    80001e7c:	13460613          	add	a2,a2,308 # 80001fac <usertrap>
    80001e80:	eb10                	sd	a2,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80001e82:	7138                	ld	a4,96(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80001e84:	8612                	mv	a2,tp
    80001e86:	f310                	sd	a2,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001e88:	10002773          	csrr	a4,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80001e8c:	eff77713          	and	a4,a4,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001e90:	02076713          	or	a4,a4,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001e94:	10071073          	csrw	sstatus,a4
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001e98:	7138                	ld	a4,96(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001e9a:	6f18                	ld	a4,24(a4)
    80001e9c:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80001ea0:	6928                	ld	a0,80(a0)
    80001ea2:	8131                	srl	a0,a0,0xc

  // jump to userret in trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80001ea4:	00005717          	auipc	a4,0x5
    80001ea8:	1f870713          	add	a4,a4,504 # 8000709c <userret>
    80001eac:	8f15                	sub	a4,a4,a3
    80001eae:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    80001eb0:	577d                	li	a4,-1
    80001eb2:	177e                	sll	a4,a4,0x3f
    80001eb4:	8d59                	or	a0,a0,a4
    80001eb6:	9782                	jalr	a5
}
    80001eb8:	60a2                	ld	ra,8(sp)
    80001eba:	6402                	ld	s0,0(sp)
    80001ebc:	0141                	add	sp,sp,16
    80001ebe:	8082                	ret

0000000080001ec0 <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80001ec0:	1101                	add	sp,sp,-32
    80001ec2:	ec06                	sd	ra,24(sp)
    80001ec4:	e822                	sd	s0,16(sp)
    80001ec6:	e426                	sd	s1,8(sp)
    80001ec8:	1000                	add	s0,sp,32
  acquire(&tickslock);
    80001eca:	0000d497          	auipc	s1,0xd
    80001ece:	e6e48493          	add	s1,s1,-402 # 8000ed38 <tickslock>
    80001ed2:	8526                	mv	a0,s1
    80001ed4:	00004097          	auipc	ra,0x4
    80001ed8:	744080e7          	jalr	1860(ra) # 80006618 <acquire>
  ticks++;
    80001edc:	00007517          	auipc	a0,0x7
    80001ee0:	bcc50513          	add	a0,a0,-1076 # 80008aa8 <ticks>
    80001ee4:	411c                	lw	a5,0(a0)
    80001ee6:	2785                	addw	a5,a5,1
    80001ee8:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80001eea:	00000097          	auipc	ra,0x0
    80001eee:	914080e7          	jalr	-1772(ra) # 800017fe <wakeup>
  release(&tickslock);
    80001ef2:	8526                	mv	a0,s1
    80001ef4:	00004097          	auipc	ra,0x4
    80001ef8:	7d8080e7          	jalr	2008(ra) # 800066cc <release>
}
    80001efc:	60e2                	ld	ra,24(sp)
    80001efe:	6442                	ld	s0,16(sp)
    80001f00:	64a2                	ld	s1,8(sp)
    80001f02:	6105                	add	sp,sp,32
    80001f04:	8082                	ret

0000000080001f06 <devintr>:
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001f06:	142027f3          	csrr	a5,scause
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80001f0a:	4501                	li	a0,0
  if((scause & 0x8000000000000000L) &&
    80001f0c:	0807df63          	bgez	a5,80001faa <devintr+0xa4>
{
    80001f10:	1101                	add	sp,sp,-32
    80001f12:	ec06                	sd	ra,24(sp)
    80001f14:	e822                	sd	s0,16(sp)
    80001f16:	e426                	sd	s1,8(sp)
    80001f18:	1000                	add	s0,sp,32
     (scause & 0xff) == 9){
    80001f1a:	0ff7f713          	zext.b	a4,a5
  if((scause & 0x8000000000000000L) &&
    80001f1e:	46a5                	li	a3,9
    80001f20:	00d70d63          	beq	a4,a3,80001f3a <devintr+0x34>
  } else if(scause == 0x8000000000000001L){
    80001f24:	577d                	li	a4,-1
    80001f26:	177e                	sll	a4,a4,0x3f
    80001f28:	0705                	add	a4,a4,1
    return 0;
    80001f2a:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80001f2c:	04e78e63          	beq	a5,a4,80001f88 <devintr+0x82>
  }
}
    80001f30:	60e2                	ld	ra,24(sp)
    80001f32:	6442                	ld	s0,16(sp)
    80001f34:	64a2                	ld	s1,8(sp)
    80001f36:	6105                	add	sp,sp,32
    80001f38:	8082                	ret
    int irq = plic_claim();
    80001f3a:	00003097          	auipc	ra,0x3
    80001f3e:	62e080e7          	jalr	1582(ra) # 80005568 <plic_claim>
    80001f42:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001f44:	47a9                	li	a5,10
    80001f46:	02f50763          	beq	a0,a5,80001f74 <devintr+0x6e>
    } else if(irq == VIRTIO0_IRQ){
    80001f4a:	4785                	li	a5,1
    80001f4c:	02f50963          	beq	a0,a5,80001f7e <devintr+0x78>
    return 1;
    80001f50:	4505                	li	a0,1
    } else if(irq){
    80001f52:	dcf9                	beqz	s1,80001f30 <devintr+0x2a>
      printf("unexpected interrupt irq=%d\n", irq);
    80001f54:	85a6                	mv	a1,s1
    80001f56:	00006517          	auipc	a0,0x6
    80001f5a:	36250513          	add	a0,a0,866 # 800082b8 <states.0+0x38>
    80001f5e:	00004097          	auipc	ra,0x4
    80001f62:	1cc080e7          	jalr	460(ra) # 8000612a <printf>
      plic_complete(irq);
    80001f66:	8526                	mv	a0,s1
    80001f68:	00003097          	auipc	ra,0x3
    80001f6c:	624080e7          	jalr	1572(ra) # 8000558c <plic_complete>
    return 1;
    80001f70:	4505                	li	a0,1
    80001f72:	bf7d                	j	80001f30 <devintr+0x2a>
      uartintr();
    80001f74:	00004097          	auipc	ra,0x4
    80001f78:	5c4080e7          	jalr	1476(ra) # 80006538 <uartintr>
    if(irq)
    80001f7c:	b7ed                	j	80001f66 <devintr+0x60>
      virtio_disk_intr();
    80001f7e:	00004097          	auipc	ra,0x4
    80001f82:	ad4080e7          	jalr	-1324(ra) # 80005a52 <virtio_disk_intr>
    if(irq)
    80001f86:	b7c5                	j	80001f66 <devintr+0x60>
    if(cpuid() == 0){
    80001f88:	fffff097          	auipc	ra,0xfffff
    80001f8c:	016080e7          	jalr	22(ra) # 80000f9e <cpuid>
    80001f90:	c901                	beqz	a0,80001fa0 <devintr+0x9a>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80001f92:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80001f96:	9bf5                	and	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80001f98:	14479073          	csrw	sip,a5
    return 2;
    80001f9c:	4509                	li	a0,2
    80001f9e:	bf49                	j	80001f30 <devintr+0x2a>
      clockintr();
    80001fa0:	00000097          	auipc	ra,0x0
    80001fa4:	f20080e7          	jalr	-224(ra) # 80001ec0 <clockintr>
    80001fa8:	b7ed                	j	80001f92 <devintr+0x8c>
}
    80001faa:	8082                	ret

0000000080001fac <usertrap>:
{
    80001fac:	1101                	add	sp,sp,-32
    80001fae:	ec06                	sd	ra,24(sp)
    80001fb0:	e822                	sd	s0,16(sp)
    80001fb2:	e426                	sd	s1,8(sp)
    80001fb4:	e04a                	sd	s2,0(sp)
    80001fb6:	1000                	add	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001fb8:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80001fbc:	1007f793          	and	a5,a5,256
    80001fc0:	e3b1                	bnez	a5,80002004 <usertrap+0x58>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001fc2:	00003797          	auipc	a5,0x3
    80001fc6:	49e78793          	add	a5,a5,1182 # 80005460 <kernelvec>
    80001fca:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001fce:	fffff097          	auipc	ra,0xfffff
    80001fd2:	ffc080e7          	jalr	-4(ra) # 80000fca <myproc>
    80001fd6:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001fd8:	713c                	ld	a5,96(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001fda:	14102773          	csrr	a4,sepc
    80001fde:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001fe0:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80001fe4:	47a1                	li	a5,8
    80001fe6:	02f70763          	beq	a4,a5,80002014 <usertrap+0x68>
  } else if((which_dev = devintr()) != 0){
    80001fea:	00000097          	auipc	ra,0x0
    80001fee:	f1c080e7          	jalr	-228(ra) # 80001f06 <devintr>
    80001ff2:	892a                	mv	s2,a0
    80001ff4:	c151                	beqz	a0,80002078 <usertrap+0xcc>
  if(killed(p))
    80001ff6:	8526                	mv	a0,s1
    80001ff8:	00000097          	auipc	ra,0x0
    80001ffc:	a4a080e7          	jalr	-1462(ra) # 80001a42 <killed>
    80002000:	c929                	beqz	a0,80002052 <usertrap+0xa6>
    80002002:	a099                	j	80002048 <usertrap+0x9c>
    panic("usertrap: not from user mode");
    80002004:	00006517          	auipc	a0,0x6
    80002008:	2d450513          	add	a0,a0,724 # 800082d8 <states.0+0x58>
    8000200c:	00004097          	auipc	ra,0x4
    80002010:	0d4080e7          	jalr	212(ra) # 800060e0 <panic>
    if(killed(p))
    80002014:	00000097          	auipc	ra,0x0
    80002018:	a2e080e7          	jalr	-1490(ra) # 80001a42 <killed>
    8000201c:	e921                	bnez	a0,8000206c <usertrap+0xc0>
    p->trapframe->epc += 4;
    8000201e:	70b8                	ld	a4,96(s1)
    80002020:	6f1c                	ld	a5,24(a4)
    80002022:	0791                	add	a5,a5,4
    80002024:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002026:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000202a:	0027e793          	or	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000202e:	10079073          	csrw	sstatus,a5
    syscall();
    80002032:	00000097          	auipc	ra,0x0
    80002036:	2d4080e7          	jalr	724(ra) # 80002306 <syscall>
  if(killed(p))
    8000203a:	8526                	mv	a0,s1
    8000203c:	00000097          	auipc	ra,0x0
    80002040:	a06080e7          	jalr	-1530(ra) # 80001a42 <killed>
    80002044:	c911                	beqz	a0,80002058 <usertrap+0xac>
    80002046:	4901                	li	s2,0
    exit(-1);
    80002048:	557d                	li	a0,-1
    8000204a:	00000097          	auipc	ra,0x0
    8000204e:	884080e7          	jalr	-1916(ra) # 800018ce <exit>
  if(which_dev == 2)
    80002052:	4789                	li	a5,2
    80002054:	04f90f63          	beq	s2,a5,800020b2 <usertrap+0x106>
  usertrapret();
    80002058:	00000097          	auipc	ra,0x0
    8000205c:	dd2080e7          	jalr	-558(ra) # 80001e2a <usertrapret>
}
    80002060:	60e2                	ld	ra,24(sp)
    80002062:	6442                	ld	s0,16(sp)
    80002064:	64a2                	ld	s1,8(sp)
    80002066:	6902                	ld	s2,0(sp)
    80002068:	6105                	add	sp,sp,32
    8000206a:	8082                	ret
      exit(-1);
    8000206c:	557d                	li	a0,-1
    8000206e:	00000097          	auipc	ra,0x0
    80002072:	860080e7          	jalr	-1952(ra) # 800018ce <exit>
    80002076:	b765                	j	8000201e <usertrap+0x72>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002078:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    8000207c:	5890                	lw	a2,48(s1)
    8000207e:	00006517          	auipc	a0,0x6
    80002082:	27a50513          	add	a0,a0,634 # 800082f8 <states.0+0x78>
    80002086:	00004097          	auipc	ra,0x4
    8000208a:	0a4080e7          	jalr	164(ra) # 8000612a <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    8000208e:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002092:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002096:	00006517          	auipc	a0,0x6
    8000209a:	29250513          	add	a0,a0,658 # 80008328 <states.0+0xa8>
    8000209e:	00004097          	auipc	ra,0x4
    800020a2:	08c080e7          	jalr	140(ra) # 8000612a <printf>
    setkilled(p);
    800020a6:	8526                	mv	a0,s1
    800020a8:	00000097          	auipc	ra,0x0
    800020ac:	96e080e7          	jalr	-1682(ra) # 80001a16 <setkilled>
    800020b0:	b769                	j	8000203a <usertrap+0x8e>
    yield();
    800020b2:	fffff097          	auipc	ra,0xfffff
    800020b6:	6ac080e7          	jalr	1708(ra) # 8000175e <yield>
    800020ba:	bf79                	j	80002058 <usertrap+0xac>

00000000800020bc <kerneltrap>:
{
    800020bc:	7179                	add	sp,sp,-48
    800020be:	f406                	sd	ra,40(sp)
    800020c0:	f022                	sd	s0,32(sp)
    800020c2:	ec26                	sd	s1,24(sp)
    800020c4:	e84a                	sd	s2,16(sp)
    800020c6:	e44e                	sd	s3,8(sp)
    800020c8:	1800                	add	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800020ca:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800020ce:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    800020d2:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    800020d6:	1004f793          	and	a5,s1,256
    800020da:	cb85                	beqz	a5,8000210a <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800020dc:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800020e0:	8b89                	and	a5,a5,2
  if(intr_get() != 0)
    800020e2:	ef85                	bnez	a5,8000211a <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    800020e4:	00000097          	auipc	ra,0x0
    800020e8:	e22080e7          	jalr	-478(ra) # 80001f06 <devintr>
    800020ec:	cd1d                	beqz	a0,8000212a <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    800020ee:	4789                	li	a5,2
    800020f0:	06f50a63          	beq	a0,a5,80002164 <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    800020f4:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800020f8:	10049073          	csrw	sstatus,s1
}
    800020fc:	70a2                	ld	ra,40(sp)
    800020fe:	7402                	ld	s0,32(sp)
    80002100:	64e2                	ld	s1,24(sp)
    80002102:	6942                	ld	s2,16(sp)
    80002104:	69a2                	ld	s3,8(sp)
    80002106:	6145                	add	sp,sp,48
    80002108:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    8000210a:	00006517          	auipc	a0,0x6
    8000210e:	23e50513          	add	a0,a0,574 # 80008348 <states.0+0xc8>
    80002112:	00004097          	auipc	ra,0x4
    80002116:	fce080e7          	jalr	-50(ra) # 800060e0 <panic>
    panic("kerneltrap: interrupts enabled");
    8000211a:	00006517          	auipc	a0,0x6
    8000211e:	25650513          	add	a0,a0,598 # 80008370 <states.0+0xf0>
    80002122:	00004097          	auipc	ra,0x4
    80002126:	fbe080e7          	jalr	-66(ra) # 800060e0 <panic>
    printf("scause %p\n", scause);
    8000212a:	85ce                	mv	a1,s3
    8000212c:	00006517          	auipc	a0,0x6
    80002130:	26450513          	add	a0,a0,612 # 80008390 <states.0+0x110>
    80002134:	00004097          	auipc	ra,0x4
    80002138:	ff6080e7          	jalr	-10(ra) # 8000612a <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    8000213c:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002140:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002144:	00006517          	auipc	a0,0x6
    80002148:	25c50513          	add	a0,a0,604 # 800083a0 <states.0+0x120>
    8000214c:	00004097          	auipc	ra,0x4
    80002150:	fde080e7          	jalr	-34(ra) # 8000612a <printf>
    panic("kerneltrap");
    80002154:	00006517          	auipc	a0,0x6
    80002158:	26450513          	add	a0,a0,612 # 800083b8 <states.0+0x138>
    8000215c:	00004097          	auipc	ra,0x4
    80002160:	f84080e7          	jalr	-124(ra) # 800060e0 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002164:	fffff097          	auipc	ra,0xfffff
    80002168:	e66080e7          	jalr	-410(ra) # 80000fca <myproc>
    8000216c:	d541                	beqz	a0,800020f4 <kerneltrap+0x38>
    8000216e:	fffff097          	auipc	ra,0xfffff
    80002172:	e5c080e7          	jalr	-420(ra) # 80000fca <myproc>
    80002176:	4d18                	lw	a4,24(a0)
    80002178:	4791                	li	a5,4
    8000217a:	f6f71de3          	bne	a4,a5,800020f4 <kerneltrap+0x38>
    yield();
    8000217e:	fffff097          	auipc	ra,0xfffff
    80002182:	5e0080e7          	jalr	1504(ra) # 8000175e <yield>
    80002186:	b7bd                	j	800020f4 <kerneltrap+0x38>

0000000080002188 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80002188:	1101                	add	sp,sp,-32
    8000218a:	ec06                	sd	ra,24(sp)
    8000218c:	e822                	sd	s0,16(sp)
    8000218e:	e426                	sd	s1,8(sp)
    80002190:	1000                	add	s0,sp,32
    80002192:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80002194:	fffff097          	auipc	ra,0xfffff
    80002198:	e36080e7          	jalr	-458(ra) # 80000fca <myproc>
  switch (n) {
    8000219c:	4795                	li	a5,5
    8000219e:	0497e163          	bltu	a5,s1,800021e0 <argraw+0x58>
    800021a2:	048a                	sll	s1,s1,0x2
    800021a4:	00006717          	auipc	a4,0x6
    800021a8:	33470713          	add	a4,a4,820 # 800084d8 <states.0+0x258>
    800021ac:	94ba                	add	s1,s1,a4
    800021ae:	409c                	lw	a5,0(s1)
    800021b0:	97ba                	add	a5,a5,a4
    800021b2:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    800021b4:	713c                	ld	a5,96(a0)
    800021b6:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    800021b8:	60e2                	ld	ra,24(sp)
    800021ba:	6442                	ld	s0,16(sp)
    800021bc:	64a2                	ld	s1,8(sp)
    800021be:	6105                	add	sp,sp,32
    800021c0:	8082                	ret
    return p->trapframe->a1;
    800021c2:	713c                	ld	a5,96(a0)
    800021c4:	7fa8                	ld	a0,120(a5)
    800021c6:	bfcd                	j	800021b8 <argraw+0x30>
    return p->trapframe->a2;
    800021c8:	713c                	ld	a5,96(a0)
    800021ca:	63c8                	ld	a0,128(a5)
    800021cc:	b7f5                	j	800021b8 <argraw+0x30>
    return p->trapframe->a3;
    800021ce:	713c                	ld	a5,96(a0)
    800021d0:	67c8                	ld	a0,136(a5)
    800021d2:	b7dd                	j	800021b8 <argraw+0x30>
    return p->trapframe->a4;
    800021d4:	713c                	ld	a5,96(a0)
    800021d6:	6bc8                	ld	a0,144(a5)
    800021d8:	b7c5                	j	800021b8 <argraw+0x30>
    return p->trapframe->a5;
    800021da:	713c                	ld	a5,96(a0)
    800021dc:	6fc8                	ld	a0,152(a5)
    800021de:	bfe9                	j	800021b8 <argraw+0x30>
  panic("argraw");
    800021e0:	00006517          	auipc	a0,0x6
    800021e4:	1e850513          	add	a0,a0,488 # 800083c8 <states.0+0x148>
    800021e8:	00004097          	auipc	ra,0x4
    800021ec:	ef8080e7          	jalr	-264(ra) # 800060e0 <panic>

00000000800021f0 <fetchaddr>:
{
    800021f0:	1101                	add	sp,sp,-32
    800021f2:	ec06                	sd	ra,24(sp)
    800021f4:	e822                	sd	s0,16(sp)
    800021f6:	e426                	sd	s1,8(sp)
    800021f8:	e04a                	sd	s2,0(sp)
    800021fa:	1000                	add	s0,sp,32
    800021fc:	84aa                	mv	s1,a0
    800021fe:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80002200:	fffff097          	auipc	ra,0xfffff
    80002204:	dca080e7          	jalr	-566(ra) # 80000fca <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    80002208:	653c                	ld	a5,72(a0)
    8000220a:	02f4f863          	bgeu	s1,a5,8000223a <fetchaddr+0x4a>
    8000220e:	00848713          	add	a4,s1,8
    80002212:	02e7e663          	bltu	a5,a4,8000223e <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80002216:	46a1                	li	a3,8
    80002218:	8626                	mv	a2,s1
    8000221a:	85ca                	mv	a1,s2
    8000221c:	6928                	ld	a0,80(a0)
    8000221e:	fffff097          	auipc	ra,0xfffff
    80002222:	9ca080e7          	jalr	-1590(ra) # 80000be8 <copyin>
    80002226:	00a03533          	snez	a0,a0
    8000222a:	40a00533          	neg	a0,a0
}
    8000222e:	60e2                	ld	ra,24(sp)
    80002230:	6442                	ld	s0,16(sp)
    80002232:	64a2                	ld	s1,8(sp)
    80002234:	6902                	ld	s2,0(sp)
    80002236:	6105                	add	sp,sp,32
    80002238:	8082                	ret
    return -1;
    8000223a:	557d                	li	a0,-1
    8000223c:	bfcd                	j	8000222e <fetchaddr+0x3e>
    8000223e:	557d                	li	a0,-1
    80002240:	b7fd                	j	8000222e <fetchaddr+0x3e>

0000000080002242 <fetchstr>:
{
    80002242:	7179                	add	sp,sp,-48
    80002244:	f406                	sd	ra,40(sp)
    80002246:	f022                	sd	s0,32(sp)
    80002248:	ec26                	sd	s1,24(sp)
    8000224a:	e84a                	sd	s2,16(sp)
    8000224c:	e44e                	sd	s3,8(sp)
    8000224e:	1800                	add	s0,sp,48
    80002250:	892a                	mv	s2,a0
    80002252:	84ae                	mv	s1,a1
    80002254:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80002256:	fffff097          	auipc	ra,0xfffff
    8000225a:	d74080e7          	jalr	-652(ra) # 80000fca <myproc>
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    8000225e:	86ce                	mv	a3,s3
    80002260:	864a                	mv	a2,s2
    80002262:	85a6                	mv	a1,s1
    80002264:	6928                	ld	a0,80(a0)
    80002266:	fffff097          	auipc	ra,0xfffff
    8000226a:	a10080e7          	jalr	-1520(ra) # 80000c76 <copyinstr>
    8000226e:	00054e63          	bltz	a0,8000228a <fetchstr+0x48>
  return strlen(buf);
    80002272:	8526                	mv	a0,s1
    80002274:	ffffe097          	auipc	ra,0xffffe
    80002278:	0ca080e7          	jalr	202(ra) # 8000033e <strlen>
}
    8000227c:	70a2                	ld	ra,40(sp)
    8000227e:	7402                	ld	s0,32(sp)
    80002280:	64e2                	ld	s1,24(sp)
    80002282:	6942                	ld	s2,16(sp)
    80002284:	69a2                	ld	s3,8(sp)
    80002286:	6145                	add	sp,sp,48
    80002288:	8082                	ret
    return -1;
    8000228a:	557d                	li	a0,-1
    8000228c:	bfc5                	j	8000227c <fetchstr+0x3a>

000000008000228e <argint>:

// Fetch the nth 32-bit system call argument.
void
argint(int n, int *ip)
{
    8000228e:	1101                	add	sp,sp,-32
    80002290:	ec06                	sd	ra,24(sp)
    80002292:	e822                	sd	s0,16(sp)
    80002294:	e426                	sd	s1,8(sp)
    80002296:	1000                	add	s0,sp,32
    80002298:	84ae                	mv	s1,a1
  *ip = argraw(n);
    8000229a:	00000097          	auipc	ra,0x0
    8000229e:	eee080e7          	jalr	-274(ra) # 80002188 <argraw>
    800022a2:	c088                	sw	a0,0(s1)
}
    800022a4:	60e2                	ld	ra,24(sp)
    800022a6:	6442                	ld	s0,16(sp)
    800022a8:	64a2                	ld	s1,8(sp)
    800022aa:	6105                	add	sp,sp,32
    800022ac:	8082                	ret

00000000800022ae <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr(int n, uint64 *ip)
{
    800022ae:	1101                	add	sp,sp,-32
    800022b0:	ec06                	sd	ra,24(sp)
    800022b2:	e822                	sd	s0,16(sp)
    800022b4:	e426                	sd	s1,8(sp)
    800022b6:	1000                	add	s0,sp,32
    800022b8:	84ae                	mv	s1,a1
  *ip = argraw(n);
    800022ba:	00000097          	auipc	ra,0x0
    800022be:	ece080e7          	jalr	-306(ra) # 80002188 <argraw>
    800022c2:	e088                	sd	a0,0(s1)
}
    800022c4:	60e2                	ld	ra,24(sp)
    800022c6:	6442                	ld	s0,16(sp)
    800022c8:	64a2                	ld	s1,8(sp)
    800022ca:	6105                	add	sp,sp,32
    800022cc:	8082                	ret

00000000800022ce <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    800022ce:	7179                	add	sp,sp,-48
    800022d0:	f406                	sd	ra,40(sp)
    800022d2:	f022                	sd	s0,32(sp)
    800022d4:	ec26                	sd	s1,24(sp)
    800022d6:	e84a                	sd	s2,16(sp)
    800022d8:	1800                	add	s0,sp,48
    800022da:	84ae                	mv	s1,a1
    800022dc:	8932                	mv	s2,a2
  uint64 addr;
  argaddr(n, &addr);
    800022de:	fd840593          	add	a1,s0,-40
    800022e2:	00000097          	auipc	ra,0x0
    800022e6:	fcc080e7          	jalr	-52(ra) # 800022ae <argaddr>
  return fetchstr(addr, buf, max);
    800022ea:	864a                	mv	a2,s2
    800022ec:	85a6                	mv	a1,s1
    800022ee:	fd843503          	ld	a0,-40(s0)
    800022f2:	00000097          	auipc	ra,0x0
    800022f6:	f50080e7          	jalr	-176(ra) # 80002242 <fetchstr>
}
    800022fa:	70a2                	ld	ra,40(sp)
    800022fc:	7402                	ld	s0,32(sp)
    800022fe:	64e2                	ld	s1,24(sp)
    80002300:	6942                	ld	s2,16(sp)
    80002302:	6145                	add	sp,sp,48
    80002304:	8082                	ret

0000000080002306 <syscall>:
  "setpriority",
};

void
syscall(void)
{
    80002306:	7179                	add	sp,sp,-48
    80002308:	f406                	sd	ra,40(sp)
    8000230a:	f022                	sd	s0,32(sp)
    8000230c:	ec26                	sd	s1,24(sp)
    8000230e:	e84a                	sd	s2,16(sp)
    80002310:	e44e                	sd	s3,8(sp)
    80002312:	1800                	add	s0,sp,48
  int num;
  struct proc *p = myproc();
    80002314:	fffff097          	auipc	ra,0xfffff
    80002318:	cb6080e7          	jalr	-842(ra) # 80000fca <myproc>
    8000231c:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    8000231e:	06053903          	ld	s2,96(a0)
    80002322:	0a893783          	ld	a5,168(s2)
    80002326:	0007899b          	sext.w	s3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    8000232a:	37fd                	addw	a5,a5,-1
    8000232c:	4761                	li	a4,24
    8000232e:	04f76763          	bltu	a4,a5,8000237c <syscall+0x76>
    80002332:	00399713          	sll	a4,s3,0x3
    80002336:	00006797          	auipc	a5,0x6
    8000233a:	1ba78793          	add	a5,a5,442 # 800084f0 <syscalls>
    8000233e:	97ba                	add	a5,a5,a4
    80002340:	639c                	ld	a5,0(a5)
    80002342:	cf8d                	beqz	a5,8000237c <syscall+0x76>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    80002344:	9782                	jalr	a5
    80002346:	06a93823          	sd	a0,112(s2)
    if (p->tracemask & (1 << num))
    8000234a:	1704a783          	lw	a5,368(s1)
    8000234e:	4137d7bb          	sraw	a5,a5,s3
    80002352:	8b85                	and	a5,a5,1
    80002354:	c3b9                	beqz	a5,8000239a <syscall+0x94>
      printf("%d: syscall %s -> %d\n", p->pid, syscallnames[num], (int)p->trapframe->a0);
    80002356:	70b8                	ld	a4,96(s1)
    80002358:	098e                	sll	s3,s3,0x3
    8000235a:	00006797          	auipc	a5,0x6
    8000235e:	19678793          	add	a5,a5,406 # 800084f0 <syscalls>
    80002362:	97ce                	add	a5,a5,s3
    80002364:	5b34                	lw	a3,112(a4)
    80002366:	6bf0                	ld	a2,208(a5)
    80002368:	588c                	lw	a1,48(s1)
    8000236a:	00006517          	auipc	a0,0x6
    8000236e:	06650513          	add	a0,a0,102 # 800083d0 <states.0+0x150>
    80002372:	00004097          	auipc	ra,0x4
    80002376:	db8080e7          	jalr	-584(ra) # 8000612a <printf>
    8000237a:	a005                	j	8000239a <syscall+0x94>
  } else {
    printf("%d %s: unknown sys call %d\n",
    8000237c:	86ce                	mv	a3,s3
    8000237e:	16048613          	add	a2,s1,352
    80002382:	588c                	lw	a1,48(s1)
    80002384:	00006517          	auipc	a0,0x6
    80002388:	06450513          	add	a0,a0,100 # 800083e8 <states.0+0x168>
    8000238c:	00004097          	auipc	ra,0x4
    80002390:	d9e080e7          	jalr	-610(ra) # 8000612a <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    80002394:	70bc                	ld	a5,96(s1)
    80002396:	577d                	li	a4,-1
    80002398:	fbb8                	sd	a4,112(a5)
  }
}
    8000239a:	70a2                	ld	ra,40(sp)
    8000239c:	7402                	ld	s0,32(sp)
    8000239e:	64e2                	ld	s1,24(sp)
    800023a0:	6942                	ld	s2,16(sp)
    800023a2:	69a2                	ld	s3,8(sp)
    800023a4:	6145                	add	sp,sp,48
    800023a6:	8082                	ret

00000000800023a8 <sys_exit>:
#include "sysinfo.h"
#include "proc.h"

uint64
sys_exit(void)
{
    800023a8:	1101                	add	sp,sp,-32
    800023aa:	ec06                	sd	ra,24(sp)
    800023ac:	e822                	sd	s0,16(sp)
    800023ae:	1000                	add	s0,sp,32
  int n;
  argint(0, &n);
    800023b0:	fec40593          	add	a1,s0,-20
    800023b4:	4501                	li	a0,0
    800023b6:	00000097          	auipc	ra,0x0
    800023ba:	ed8080e7          	jalr	-296(ra) # 8000228e <argint>
  exit(n);
    800023be:	fec42503          	lw	a0,-20(s0)
    800023c2:	fffff097          	auipc	ra,0xfffff
    800023c6:	50c080e7          	jalr	1292(ra) # 800018ce <exit>
  return 0;  // not reached
}
    800023ca:	4501                	li	a0,0
    800023cc:	60e2                	ld	ra,24(sp)
    800023ce:	6442                	ld	s0,16(sp)
    800023d0:	6105                	add	sp,sp,32
    800023d2:	8082                	ret

00000000800023d4 <sys_getpid>:

uint64
sys_getpid(void)
{
    800023d4:	1141                	add	sp,sp,-16
    800023d6:	e406                	sd	ra,8(sp)
    800023d8:	e022                	sd	s0,0(sp)
    800023da:	0800                	add	s0,sp,16
  return myproc()->pid;
    800023dc:	fffff097          	auipc	ra,0xfffff
    800023e0:	bee080e7          	jalr	-1042(ra) # 80000fca <myproc>
}
    800023e4:	5908                	lw	a0,48(a0)
    800023e6:	60a2                	ld	ra,8(sp)
    800023e8:	6402                	ld	s0,0(sp)
    800023ea:	0141                	add	sp,sp,16
    800023ec:	8082                	ret

00000000800023ee <sys_fork>:

uint64
sys_fork(void)
{
    800023ee:	1141                	add	sp,sp,-16
    800023f0:	e406                	sd	ra,8(sp)
    800023f2:	e022                	sd	s0,0(sp)
    800023f4:	0800                	add	s0,sp,16
  return fork();
    800023f6:	fffff097          	auipc	ra,0xfffff
    800023fa:	038080e7          	jalr	56(ra) # 8000142e <fork>
}
    800023fe:	60a2                	ld	ra,8(sp)
    80002400:	6402                	ld	s0,0(sp)
    80002402:	0141                	add	sp,sp,16
    80002404:	8082                	ret

0000000080002406 <sys_wait>:

uint64
sys_wait(void)
{
    80002406:	1101                	add	sp,sp,-32
    80002408:	ec06                	sd	ra,24(sp)
    8000240a:	e822                	sd	s0,16(sp)
    8000240c:	1000                	add	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    8000240e:	fe840593          	add	a1,s0,-24
    80002412:	4501                	li	a0,0
    80002414:	00000097          	auipc	ra,0x0
    80002418:	e9a080e7          	jalr	-358(ra) # 800022ae <argaddr>
  return wait(p);
    8000241c:	fe843503          	ld	a0,-24(s0)
    80002420:	fffff097          	auipc	ra,0xfffff
    80002424:	654080e7          	jalr	1620(ra) # 80001a74 <wait>
}
    80002428:	60e2                	ld	ra,24(sp)
    8000242a:	6442                	ld	s0,16(sp)
    8000242c:	6105                	add	sp,sp,32
    8000242e:	8082                	ret

0000000080002430 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80002430:	7179                	add	sp,sp,-48
    80002432:	f406                	sd	ra,40(sp)
    80002434:	f022                	sd	s0,32(sp)
    80002436:	ec26                	sd	s1,24(sp)
    80002438:	1800                	add	s0,sp,48
  uint64 addr;
  int n;

  argint(0, &n);
    8000243a:	fdc40593          	add	a1,s0,-36
    8000243e:	4501                	li	a0,0
    80002440:	00000097          	auipc	ra,0x0
    80002444:	e4e080e7          	jalr	-434(ra) # 8000228e <argint>
  addr = myproc()->sz;
    80002448:	fffff097          	auipc	ra,0xfffff
    8000244c:	b82080e7          	jalr	-1150(ra) # 80000fca <myproc>
    80002450:	6524                	ld	s1,72(a0)
  if(growproc(n) < 0)
    80002452:	fdc42503          	lw	a0,-36(s0)
    80002456:	fffff097          	auipc	ra,0xfffff
    8000245a:	f7c080e7          	jalr	-132(ra) # 800013d2 <growproc>
    8000245e:	00054863          	bltz	a0,8000246e <sys_sbrk+0x3e>
    return -1;
  return addr;
}
    80002462:	8526                	mv	a0,s1
    80002464:	70a2                	ld	ra,40(sp)
    80002466:	7402                	ld	s0,32(sp)
    80002468:	64e2                	ld	s1,24(sp)
    8000246a:	6145                	add	sp,sp,48
    8000246c:	8082                	ret
    return -1;
    8000246e:	54fd                	li	s1,-1
    80002470:	bfcd                	j	80002462 <sys_sbrk+0x32>

0000000080002472 <sys_sleep>:

uint64
sys_sleep(void)
{
    80002472:	7139                	add	sp,sp,-64
    80002474:	fc06                	sd	ra,56(sp)
    80002476:	f822                	sd	s0,48(sp)
    80002478:	f426                	sd	s1,40(sp)
    8000247a:	f04a                	sd	s2,32(sp)
    8000247c:	ec4e                	sd	s3,24(sp)
    8000247e:	0080                	add	s0,sp,64
  int n;
  uint ticks0;

  argint(0, &n);
    80002480:	fcc40593          	add	a1,s0,-52
    80002484:	4501                	li	a0,0
    80002486:	00000097          	auipc	ra,0x0
    8000248a:	e08080e7          	jalr	-504(ra) # 8000228e <argint>
  if(n < 0)
    8000248e:	fcc42783          	lw	a5,-52(s0)
    80002492:	0607cf63          	bltz	a5,80002510 <sys_sleep+0x9e>
    n = 0;
  acquire(&tickslock);
    80002496:	0000d517          	auipc	a0,0xd
    8000249a:	8a250513          	add	a0,a0,-1886 # 8000ed38 <tickslock>
    8000249e:	00004097          	auipc	ra,0x4
    800024a2:	17a080e7          	jalr	378(ra) # 80006618 <acquire>
  ticks0 = ticks;
    800024a6:	00006917          	auipc	s2,0x6
    800024aa:	60292903          	lw	s2,1538(s2) # 80008aa8 <ticks>
  while(ticks - ticks0 < n){
    800024ae:	fcc42783          	lw	a5,-52(s0)
    800024b2:	cf9d                	beqz	a5,800024f0 <sys_sleep+0x7e>
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    800024b4:	0000d997          	auipc	s3,0xd
    800024b8:	88498993          	add	s3,s3,-1916 # 8000ed38 <tickslock>
    800024bc:	00006497          	auipc	s1,0x6
    800024c0:	5ec48493          	add	s1,s1,1516 # 80008aa8 <ticks>
    if(killed(myproc())){
    800024c4:	fffff097          	auipc	ra,0xfffff
    800024c8:	b06080e7          	jalr	-1274(ra) # 80000fca <myproc>
    800024cc:	fffff097          	auipc	ra,0xfffff
    800024d0:	576080e7          	jalr	1398(ra) # 80001a42 <killed>
    800024d4:	e129                	bnez	a0,80002516 <sys_sleep+0xa4>
    sleep(&ticks, &tickslock);
    800024d6:	85ce                	mv	a1,s3
    800024d8:	8526                	mv	a0,s1
    800024da:	fffff097          	auipc	ra,0xfffff
    800024de:	2c0080e7          	jalr	704(ra) # 8000179a <sleep>
  while(ticks - ticks0 < n){
    800024e2:	409c                	lw	a5,0(s1)
    800024e4:	412787bb          	subw	a5,a5,s2
    800024e8:	fcc42703          	lw	a4,-52(s0)
    800024ec:	fce7ece3          	bltu	a5,a4,800024c4 <sys_sleep+0x52>
  }
  release(&tickslock);
    800024f0:	0000d517          	auipc	a0,0xd
    800024f4:	84850513          	add	a0,a0,-1976 # 8000ed38 <tickslock>
    800024f8:	00004097          	auipc	ra,0x4
    800024fc:	1d4080e7          	jalr	468(ra) # 800066cc <release>
  return 0;
    80002500:	4501                	li	a0,0
}
    80002502:	70e2                	ld	ra,56(sp)
    80002504:	7442                	ld	s0,48(sp)
    80002506:	74a2                	ld	s1,40(sp)
    80002508:	7902                	ld	s2,32(sp)
    8000250a:	69e2                	ld	s3,24(sp)
    8000250c:	6121                	add	sp,sp,64
    8000250e:	8082                	ret
    n = 0;
    80002510:	fc042623          	sw	zero,-52(s0)
    80002514:	b749                	j	80002496 <sys_sleep+0x24>
      release(&tickslock);
    80002516:	0000d517          	auipc	a0,0xd
    8000251a:	82250513          	add	a0,a0,-2014 # 8000ed38 <tickslock>
    8000251e:	00004097          	auipc	ra,0x4
    80002522:	1ae080e7          	jalr	430(ra) # 800066cc <release>
      return -1;
    80002526:	557d                	li	a0,-1
    80002528:	bfe9                	j	80002502 <sys_sleep+0x90>

000000008000252a <sys_pgaccess>:

int
sys_pgaccess(void)
{
    8000252a:	715d                	add	sp,sp,-80
    8000252c:	e486                	sd	ra,72(sp)
    8000252e:	e0a2                	sd	s0,64(sp)
    80002530:	fc26                	sd	s1,56(sp)
    80002532:	f84a                	sd	s2,48(sp)
    80002534:	f44e                	sd	s3,40(sp)
    80002536:	0880                	add	s0,sp,80
  struct proc *p = myproc();
    80002538:	fffff097          	auipc	ra,0xfffff
    8000253c:	a92080e7          	jalr	-1390(ra) # 80000fca <myproc>
    80002540:	892a                	mv	s2,a0
  uint64 va, res, bitmask = 0;
    80002542:	fa043c23          	sd	zero,-72(s0)
  int n;

  argaddr(0, &va);
    80002546:	fc840593          	add	a1,s0,-56
    8000254a:	4501                	li	a0,0
    8000254c:	00000097          	auipc	ra,0x0
    80002550:	d62080e7          	jalr	-670(ra) # 800022ae <argaddr>
  argint(1,  &n);
    80002554:	fb440593          	add	a1,s0,-76
    80002558:	4505                	li	a0,1
    8000255a:	00000097          	auipc	ra,0x0
    8000255e:	d34080e7          	jalr	-716(ra) # 8000228e <argint>
  argaddr(2, &res);
    80002562:	fc040593          	add	a1,s0,-64
    80002566:	4509                	li	a0,2
    80002568:	00000097          	auipc	ra,0x0
    8000256c:	d46080e7          	jalr	-698(ra) # 800022ae <argaddr>
  va = PGROUNDDOWN(va);
    80002570:	77fd                	lui	a5,0xfffff
    80002572:	fc843703          	ld	a4,-56(s0)
    80002576:	8ff9                	and	a5,a5,a4
    80002578:	fcf43423          	sd	a5,-56(s0)
  if((n > 64) || (va + (n * PGSIZE) >= MAXVA))
    8000257c:	fb442703          	lw	a4,-76(s0)
    80002580:	04000693          	li	a3,64
    80002584:	08e6c663          	blt	a3,a4,80002610 <sys_pgaccess+0xe6>
    80002588:	00c7169b          	sllw	a3,a4,0xc
    8000258c:	96be                	add	a3,a3,a5
    8000258e:	57fd                	li	a5,-1
    80002590:	83e9                	srl	a5,a5,0x1a
    80002592:	08d7e163          	bltu	a5,a3,80002614 <sys_pgaccess+0xea>
    return -1;
  
  for (int i = 0; i < n; ++i) {
    80002596:	04e05963          	blez	a4,800025e8 <sys_pgaccess+0xbe>
    8000259a:	4481                	li	s1,0
    pte_t *pte = walk(p->pagetable, va + (i * PGSIZE), 0);
    if(pte){
      if(*pte & PTE_A)
        bitmask |= (1L << i);
    8000259c:	4985                	li	s3,1
    8000259e:	a821                	j	800025b6 <sys_pgaccess+0x8c>
      *pte &= ~PTE_A;
    800025a0:	611c                	ld	a5,0(a0)
    800025a2:	fbf7f793          	and	a5,a5,-65
    800025a6:	e11c                	sd	a5,0(a0)
  for (int i = 0; i < n; ++i) {
    800025a8:	0485                	add	s1,s1,1
    800025aa:	fb442703          	lw	a4,-76(s0)
    800025ae:	0004879b          	sext.w	a5,s1
    800025b2:	02e7db63          	bge	a5,a4,800025e8 <sys_pgaccess+0xbe>
    pte_t *pte = walk(p->pagetable, va + (i * PGSIZE), 0);
    800025b6:	00c49593          	sll	a1,s1,0xc
    800025ba:	4601                	li	a2,0
    800025bc:	fc843783          	ld	a5,-56(s0)
    800025c0:	95be                	add	a1,a1,a5
    800025c2:	05093503          	ld	a0,80(s2)
    800025c6:	ffffe097          	auipc	ra,0xffffe
    800025ca:	ee0080e7          	jalr	-288(ra) # 800004a6 <walk>
    if(pte){
    800025ce:	dd69                	beqz	a0,800025a8 <sys_pgaccess+0x7e>
      if(*pte & PTE_A)
    800025d0:	611c                	ld	a5,0(a0)
    800025d2:	0407f793          	and	a5,a5,64
    800025d6:	d7e9                	beqz	a5,800025a0 <sys_pgaccess+0x76>
        bitmask |= (1L << i);
    800025d8:	00999733          	sll	a4,s3,s1
    800025dc:	fb843783          	ld	a5,-72(s0)
    800025e0:	8fd9                	or	a5,a5,a4
    800025e2:	faf43c23          	sd	a5,-72(s0)
    800025e6:	bf6d                	j	800025a0 <sys_pgaccess+0x76>
    }
  }

  if(copyout(p->pagetable, res, (char*)&bitmask, sizeof(bitmask)) < 0)
    800025e8:	46a1                	li	a3,8
    800025ea:	fb840613          	add	a2,s0,-72
    800025ee:	fc043583          	ld	a1,-64(s0)
    800025f2:	05093503          	ld	a0,80(s2)
    800025f6:	ffffe097          	auipc	ra,0xffffe
    800025fa:	566080e7          	jalr	1382(ra) # 80000b5c <copyout>
    800025fe:	41f5551b          	sraw	a0,a0,0x1f
    return -1;
  return 0;
}
    80002602:	60a6                	ld	ra,72(sp)
    80002604:	6406                	ld	s0,64(sp)
    80002606:	74e2                	ld	s1,56(sp)
    80002608:	7942                	ld	s2,48(sp)
    8000260a:	79a2                	ld	s3,40(sp)
    8000260c:	6161                	add	sp,sp,80
    8000260e:	8082                	ret
    return -1;
    80002610:	557d                	li	a0,-1
    80002612:	bfc5                	j	80002602 <sys_pgaccess+0xd8>
    80002614:	557d                	li	a0,-1
    80002616:	b7f5                	j	80002602 <sys_pgaccess+0xd8>

0000000080002618 <sys_kill>:

uint64
sys_kill(void)
{
    80002618:	1101                	add	sp,sp,-32
    8000261a:	ec06                	sd	ra,24(sp)
    8000261c:	e822                	sd	s0,16(sp)
    8000261e:	1000                	add	s0,sp,32
  int pid;

  argint(0, &pid);
    80002620:	fec40593          	add	a1,s0,-20
    80002624:	4501                	li	a0,0
    80002626:	00000097          	auipc	ra,0x0
    8000262a:	c68080e7          	jalr	-920(ra) # 8000228e <argint>
  return kill(pid);
    8000262e:	fec42503          	lw	a0,-20(s0)
    80002632:	fffff097          	auipc	ra,0xfffff
    80002636:	372080e7          	jalr	882(ra) # 800019a4 <kill>
}
    8000263a:	60e2                	ld	ra,24(sp)
    8000263c:	6442                	ld	s0,16(sp)
    8000263e:	6105                	add	sp,sp,32
    80002640:	8082                	ret

0000000080002642 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80002642:	1101                	add	sp,sp,-32
    80002644:	ec06                	sd	ra,24(sp)
    80002646:	e822                	sd	s0,16(sp)
    80002648:	e426                	sd	s1,8(sp)
    8000264a:	1000                	add	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    8000264c:	0000c517          	auipc	a0,0xc
    80002650:	6ec50513          	add	a0,a0,1772 # 8000ed38 <tickslock>
    80002654:	00004097          	auipc	ra,0x4
    80002658:	fc4080e7          	jalr	-60(ra) # 80006618 <acquire>
  xticks = ticks;
    8000265c:	00006497          	auipc	s1,0x6
    80002660:	44c4a483          	lw	s1,1100(s1) # 80008aa8 <ticks>
  release(&tickslock);
    80002664:	0000c517          	auipc	a0,0xc
    80002668:	6d450513          	add	a0,a0,1748 # 8000ed38 <tickslock>
    8000266c:	00004097          	auipc	ra,0x4
    80002670:	060080e7          	jalr	96(ra) # 800066cc <release>
  return xticks;
}
    80002674:	02049513          	sll	a0,s1,0x20
    80002678:	9101                	srl	a0,a0,0x20
    8000267a:	60e2                	ld	ra,24(sp)
    8000267c:	6442                	ld	s0,16(sp)
    8000267e:	64a2                	ld	s1,8(sp)
    80002680:	6105                	add	sp,sp,32
    80002682:	8082                	ret

0000000080002684 <sys_trace>:

uint64
sys_trace(void)
{
    80002684:	1101                	add	sp,sp,-32
    80002686:	ec06                	sd	ra,24(sp)
    80002688:	e822                	sd	s0,16(sp)
    8000268a:	1000                	add	s0,sp,32
  int mask;

  argint(0, &mask);
    8000268c:	fec40593          	add	a1,s0,-20
    80002690:	4501                	li	a0,0
    80002692:	00000097          	auipc	ra,0x0
    80002696:	bfc080e7          	jalr	-1028(ra) # 8000228e <argint>
  myproc()->tracemask = mask;
    8000269a:	fffff097          	auipc	ra,0xfffff
    8000269e:	930080e7          	jalr	-1744(ra) # 80000fca <myproc>
    800026a2:	fec42783          	lw	a5,-20(s0)
    800026a6:	16f52823          	sw	a5,368(a0)
  return 0;
}
    800026aa:	4501                	li	a0,0
    800026ac:	60e2                	ld	ra,24(sp)
    800026ae:	6442                	ld	s0,16(sp)
    800026b0:	6105                	add	sp,sp,32
    800026b2:	8082                	ret

00000000800026b4 <sys_sysinfo>:

uint64
sys_sysinfo(void)
{
    800026b4:	7139                	add	sp,sp,-64
    800026b6:	fc06                	sd	ra,56(sp)
    800026b8:	f822                	sd	s0,48(sp)
    800026ba:	f426                	sd	s1,40(sp)
    800026bc:	0080                	add	s0,sp,64
  struct proc *p = myproc();
    800026be:	fffff097          	auipc	ra,0xfffff
    800026c2:	90c080e7          	jalr	-1780(ra) # 80000fca <myproc>
    800026c6:	84aa                	mv	s1,a0
  uint64 infoaddr; // user pointer to struct sysinfo
  struct sysinfo info = { .freemem = kfreesize(), .nproc = procsinuse() };
    800026c8:	ffffe097          	auipc	ra,0xffffe
    800026cc:	a52080e7          	jalr	-1454(ra) # 8000011a <kfreesize>
    800026d0:	fca43423          	sd	a0,-56(s0)
    800026d4:	fffff097          	auipc	ra,0xfffff
    800026d8:	62a080e7          	jalr	1578(ra) # 80001cfe <procsinuse>
    800026dc:	fca43823          	sd	a0,-48(s0)

  argaddr(0, &infoaddr);
    800026e0:	fd840593          	add	a1,s0,-40
    800026e4:	4501                	li	a0,0
    800026e6:	00000097          	auipc	ra,0x0
    800026ea:	bc8080e7          	jalr	-1080(ra) # 800022ae <argaddr>
  if(copyout(p->pagetable, infoaddr, (char*)&info, sizeof(info)) < 0)
    800026ee:	46c1                	li	a3,16
    800026f0:	fc840613          	add	a2,s0,-56
    800026f4:	fd843583          	ld	a1,-40(s0)
    800026f8:	68a8                	ld	a0,80(s1)
    800026fa:	ffffe097          	auipc	ra,0xffffe
    800026fe:	462080e7          	jalr	1122(ra) # 80000b5c <copyout>
    return -1;
  return 0;
}
    80002702:	957d                	sra	a0,a0,0x3f
    80002704:	70e2                	ld	ra,56(sp)
    80002706:	7442                	ld	s0,48(sp)
    80002708:	74a2                	ld	s1,40(sp)
    8000270a:	6121                	add	sp,sp,64
    8000270c:	8082                	ret

000000008000270e <sys_setpriority>:

uint64
sys_setpriority(void)
{
    8000270e:	1101                	add	sp,sp,-32
    80002710:	ec06                	sd	ra,24(sp)
    80002712:	e822                	sd	s0,16(sp)
    80002714:	1000                	add	s0,sp,32
  int priority;
  argint(0, &priority);
    80002716:	fec40593          	add	a1,s0,-20
    8000271a:	4501                	li	a0,0
    8000271c:	00000097          	auipc	ra,0x0
    80002720:	b72080e7          	jalr	-1166(ra) # 8000228e <argint>
  return setpriority(priority);
    80002724:	fec42503          	lw	a0,-20(s0)
    80002728:	fffff097          	auipc	ra,0xfffff
    8000272c:	604080e7          	jalr	1540(ra) # 80001d2c <setpriority>
}
    80002730:	60e2                	ld	ra,24(sp)
    80002732:	6442                	ld	s0,16(sp)
    80002734:	6105                	add	sp,sp,32
    80002736:	8082                	ret

0000000080002738 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80002738:	7179                	add	sp,sp,-48
    8000273a:	f406                	sd	ra,40(sp)
    8000273c:	f022                	sd	s0,32(sp)
    8000273e:	ec26                	sd	s1,24(sp)
    80002740:	e84a                	sd	s2,16(sp)
    80002742:	e44e                	sd	s3,8(sp)
    80002744:	e052                	sd	s4,0(sp)
    80002746:	1800                	add	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80002748:	00006597          	auipc	a1,0x6
    8000274c:	f4858593          	add	a1,a1,-184 # 80008690 <syscallnames+0xd0>
    80002750:	0000c517          	auipc	a0,0xc
    80002754:	60050513          	add	a0,a0,1536 # 8000ed50 <bcache>
    80002758:	00004097          	auipc	ra,0x4
    8000275c:	e30080e7          	jalr	-464(ra) # 80006588 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80002760:	00014797          	auipc	a5,0x14
    80002764:	5f078793          	add	a5,a5,1520 # 80016d50 <bcache+0x8000>
    80002768:	00015717          	auipc	a4,0x15
    8000276c:	85070713          	add	a4,a4,-1968 # 80016fb8 <bcache+0x8268>
    80002770:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    80002774:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002778:	0000c497          	auipc	s1,0xc
    8000277c:	5f048493          	add	s1,s1,1520 # 8000ed68 <bcache+0x18>
    b->next = bcache.head.next;
    80002780:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80002782:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80002784:	00006a17          	auipc	s4,0x6
    80002788:	f14a0a13          	add	s4,s4,-236 # 80008698 <syscallnames+0xd8>
    b->next = bcache.head.next;
    8000278c:	2b893783          	ld	a5,696(s2)
    80002790:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80002792:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80002796:	85d2                	mv	a1,s4
    80002798:	01048513          	add	a0,s1,16
    8000279c:	00001097          	auipc	ra,0x1
    800027a0:	496080e7          	jalr	1174(ra) # 80003c32 <initsleeplock>
    bcache.head.next->prev = b;
    800027a4:	2b893783          	ld	a5,696(s2)
    800027a8:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    800027aa:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800027ae:	45848493          	add	s1,s1,1112
    800027b2:	fd349de3          	bne	s1,s3,8000278c <binit+0x54>
  }
}
    800027b6:	70a2                	ld	ra,40(sp)
    800027b8:	7402                	ld	s0,32(sp)
    800027ba:	64e2                	ld	s1,24(sp)
    800027bc:	6942                	ld	s2,16(sp)
    800027be:	69a2                	ld	s3,8(sp)
    800027c0:	6a02                	ld	s4,0(sp)
    800027c2:	6145                	add	sp,sp,48
    800027c4:	8082                	ret

00000000800027c6 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    800027c6:	7179                	add	sp,sp,-48
    800027c8:	f406                	sd	ra,40(sp)
    800027ca:	f022                	sd	s0,32(sp)
    800027cc:	ec26                	sd	s1,24(sp)
    800027ce:	e84a                	sd	s2,16(sp)
    800027d0:	e44e                	sd	s3,8(sp)
    800027d2:	1800                	add	s0,sp,48
    800027d4:	892a                	mv	s2,a0
    800027d6:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    800027d8:	0000c517          	auipc	a0,0xc
    800027dc:	57850513          	add	a0,a0,1400 # 8000ed50 <bcache>
    800027e0:	00004097          	auipc	ra,0x4
    800027e4:	e38080e7          	jalr	-456(ra) # 80006618 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    800027e8:	00015497          	auipc	s1,0x15
    800027ec:	8204b483          	ld	s1,-2016(s1) # 80017008 <bcache+0x82b8>
    800027f0:	00014797          	auipc	a5,0x14
    800027f4:	7c878793          	add	a5,a5,1992 # 80016fb8 <bcache+0x8268>
    800027f8:	02f48f63          	beq	s1,a5,80002836 <bread+0x70>
    800027fc:	873e                	mv	a4,a5
    800027fe:	a021                	j	80002806 <bread+0x40>
    80002800:	68a4                	ld	s1,80(s1)
    80002802:	02e48a63          	beq	s1,a4,80002836 <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    80002806:	449c                	lw	a5,8(s1)
    80002808:	ff279ce3          	bne	a5,s2,80002800 <bread+0x3a>
    8000280c:	44dc                	lw	a5,12(s1)
    8000280e:	ff3799e3          	bne	a5,s3,80002800 <bread+0x3a>
      b->refcnt++;
    80002812:	40bc                	lw	a5,64(s1)
    80002814:	2785                	addw	a5,a5,1
    80002816:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002818:	0000c517          	auipc	a0,0xc
    8000281c:	53850513          	add	a0,a0,1336 # 8000ed50 <bcache>
    80002820:	00004097          	auipc	ra,0x4
    80002824:	eac080e7          	jalr	-340(ra) # 800066cc <release>
      acquiresleep(&b->lock);
    80002828:	01048513          	add	a0,s1,16
    8000282c:	00001097          	auipc	ra,0x1
    80002830:	440080e7          	jalr	1088(ra) # 80003c6c <acquiresleep>
      return b;
    80002834:	a8b9                	j	80002892 <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002836:	00014497          	auipc	s1,0x14
    8000283a:	7ca4b483          	ld	s1,1994(s1) # 80017000 <bcache+0x82b0>
    8000283e:	00014797          	auipc	a5,0x14
    80002842:	77a78793          	add	a5,a5,1914 # 80016fb8 <bcache+0x8268>
    80002846:	00f48863          	beq	s1,a5,80002856 <bread+0x90>
    8000284a:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    8000284c:	40bc                	lw	a5,64(s1)
    8000284e:	cf81                	beqz	a5,80002866 <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002850:	64a4                	ld	s1,72(s1)
    80002852:	fee49de3          	bne	s1,a4,8000284c <bread+0x86>
  panic("bget: no buffers");
    80002856:	00006517          	auipc	a0,0x6
    8000285a:	e4a50513          	add	a0,a0,-438 # 800086a0 <syscallnames+0xe0>
    8000285e:	00004097          	auipc	ra,0x4
    80002862:	882080e7          	jalr	-1918(ra) # 800060e0 <panic>
      b->dev = dev;
    80002866:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    8000286a:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    8000286e:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80002872:	4785                	li	a5,1
    80002874:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002876:	0000c517          	auipc	a0,0xc
    8000287a:	4da50513          	add	a0,a0,1242 # 8000ed50 <bcache>
    8000287e:	00004097          	auipc	ra,0x4
    80002882:	e4e080e7          	jalr	-434(ra) # 800066cc <release>
      acquiresleep(&b->lock);
    80002886:	01048513          	add	a0,s1,16
    8000288a:	00001097          	auipc	ra,0x1
    8000288e:	3e2080e7          	jalr	994(ra) # 80003c6c <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80002892:	409c                	lw	a5,0(s1)
    80002894:	cb89                	beqz	a5,800028a6 <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    80002896:	8526                	mv	a0,s1
    80002898:	70a2                	ld	ra,40(sp)
    8000289a:	7402                	ld	s0,32(sp)
    8000289c:	64e2                	ld	s1,24(sp)
    8000289e:	6942                	ld	s2,16(sp)
    800028a0:	69a2                	ld	s3,8(sp)
    800028a2:	6145                	add	sp,sp,48
    800028a4:	8082                	ret
    virtio_disk_rw(b, 0);
    800028a6:	4581                	li	a1,0
    800028a8:	8526                	mv	a0,s1
    800028aa:	00003097          	auipc	ra,0x3
    800028ae:	f78080e7          	jalr	-136(ra) # 80005822 <virtio_disk_rw>
    b->valid = 1;
    800028b2:	4785                	li	a5,1
    800028b4:	c09c                	sw	a5,0(s1)
  return b;
    800028b6:	b7c5                	j	80002896 <bread+0xd0>

00000000800028b8 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    800028b8:	1101                	add	sp,sp,-32
    800028ba:	ec06                	sd	ra,24(sp)
    800028bc:	e822                	sd	s0,16(sp)
    800028be:	e426                	sd	s1,8(sp)
    800028c0:	1000                	add	s0,sp,32
    800028c2:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800028c4:	0541                	add	a0,a0,16
    800028c6:	00001097          	auipc	ra,0x1
    800028ca:	440080e7          	jalr	1088(ra) # 80003d06 <holdingsleep>
    800028ce:	cd01                	beqz	a0,800028e6 <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    800028d0:	4585                	li	a1,1
    800028d2:	8526                	mv	a0,s1
    800028d4:	00003097          	auipc	ra,0x3
    800028d8:	f4e080e7          	jalr	-178(ra) # 80005822 <virtio_disk_rw>
}
    800028dc:	60e2                	ld	ra,24(sp)
    800028de:	6442                	ld	s0,16(sp)
    800028e0:	64a2                	ld	s1,8(sp)
    800028e2:	6105                	add	sp,sp,32
    800028e4:	8082                	ret
    panic("bwrite");
    800028e6:	00006517          	auipc	a0,0x6
    800028ea:	dd250513          	add	a0,a0,-558 # 800086b8 <syscallnames+0xf8>
    800028ee:	00003097          	auipc	ra,0x3
    800028f2:	7f2080e7          	jalr	2034(ra) # 800060e0 <panic>

00000000800028f6 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    800028f6:	1101                	add	sp,sp,-32
    800028f8:	ec06                	sd	ra,24(sp)
    800028fa:	e822                	sd	s0,16(sp)
    800028fc:	e426                	sd	s1,8(sp)
    800028fe:	e04a                	sd	s2,0(sp)
    80002900:	1000                	add	s0,sp,32
    80002902:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002904:	01050913          	add	s2,a0,16
    80002908:	854a                	mv	a0,s2
    8000290a:	00001097          	auipc	ra,0x1
    8000290e:	3fc080e7          	jalr	1020(ra) # 80003d06 <holdingsleep>
    80002912:	c925                	beqz	a0,80002982 <brelse+0x8c>
    panic("brelse");

  releasesleep(&b->lock);
    80002914:	854a                	mv	a0,s2
    80002916:	00001097          	auipc	ra,0x1
    8000291a:	3ac080e7          	jalr	940(ra) # 80003cc2 <releasesleep>

  acquire(&bcache.lock);
    8000291e:	0000c517          	auipc	a0,0xc
    80002922:	43250513          	add	a0,a0,1074 # 8000ed50 <bcache>
    80002926:	00004097          	auipc	ra,0x4
    8000292a:	cf2080e7          	jalr	-782(ra) # 80006618 <acquire>
  b->refcnt--;
    8000292e:	40bc                	lw	a5,64(s1)
    80002930:	37fd                	addw	a5,a5,-1
    80002932:	0007871b          	sext.w	a4,a5
    80002936:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    80002938:	e71d                	bnez	a4,80002966 <brelse+0x70>
    // no one is waiting for it.
    b->next->prev = b->prev;
    8000293a:	68b8                	ld	a4,80(s1)
    8000293c:	64bc                	ld	a5,72(s1)
    8000293e:	e73c                	sd	a5,72(a4)
    b->prev->next = b->next;
    80002940:	68b8                	ld	a4,80(s1)
    80002942:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80002944:	00014797          	auipc	a5,0x14
    80002948:	40c78793          	add	a5,a5,1036 # 80016d50 <bcache+0x8000>
    8000294c:	2b87b703          	ld	a4,696(a5)
    80002950:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    80002952:	00014717          	auipc	a4,0x14
    80002956:	66670713          	add	a4,a4,1638 # 80016fb8 <bcache+0x8268>
    8000295a:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    8000295c:	2b87b703          	ld	a4,696(a5)
    80002960:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    80002962:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    80002966:	0000c517          	auipc	a0,0xc
    8000296a:	3ea50513          	add	a0,a0,1002 # 8000ed50 <bcache>
    8000296e:	00004097          	auipc	ra,0x4
    80002972:	d5e080e7          	jalr	-674(ra) # 800066cc <release>
}
    80002976:	60e2                	ld	ra,24(sp)
    80002978:	6442                	ld	s0,16(sp)
    8000297a:	64a2                	ld	s1,8(sp)
    8000297c:	6902                	ld	s2,0(sp)
    8000297e:	6105                	add	sp,sp,32
    80002980:	8082                	ret
    panic("brelse");
    80002982:	00006517          	auipc	a0,0x6
    80002986:	d3e50513          	add	a0,a0,-706 # 800086c0 <syscallnames+0x100>
    8000298a:	00003097          	auipc	ra,0x3
    8000298e:	756080e7          	jalr	1878(ra) # 800060e0 <panic>

0000000080002992 <bpin>:

void
bpin(struct buf *b) {
    80002992:	1101                	add	sp,sp,-32
    80002994:	ec06                	sd	ra,24(sp)
    80002996:	e822                	sd	s0,16(sp)
    80002998:	e426                	sd	s1,8(sp)
    8000299a:	1000                	add	s0,sp,32
    8000299c:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    8000299e:	0000c517          	auipc	a0,0xc
    800029a2:	3b250513          	add	a0,a0,946 # 8000ed50 <bcache>
    800029a6:	00004097          	auipc	ra,0x4
    800029aa:	c72080e7          	jalr	-910(ra) # 80006618 <acquire>
  b->refcnt++;
    800029ae:	40bc                	lw	a5,64(s1)
    800029b0:	2785                	addw	a5,a5,1
    800029b2:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800029b4:	0000c517          	auipc	a0,0xc
    800029b8:	39c50513          	add	a0,a0,924 # 8000ed50 <bcache>
    800029bc:	00004097          	auipc	ra,0x4
    800029c0:	d10080e7          	jalr	-752(ra) # 800066cc <release>
}
    800029c4:	60e2                	ld	ra,24(sp)
    800029c6:	6442                	ld	s0,16(sp)
    800029c8:	64a2                	ld	s1,8(sp)
    800029ca:	6105                	add	sp,sp,32
    800029cc:	8082                	ret

00000000800029ce <bunpin>:

void
bunpin(struct buf *b) {
    800029ce:	1101                	add	sp,sp,-32
    800029d0:	ec06                	sd	ra,24(sp)
    800029d2:	e822                	sd	s0,16(sp)
    800029d4:	e426                	sd	s1,8(sp)
    800029d6:	1000                	add	s0,sp,32
    800029d8:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800029da:	0000c517          	auipc	a0,0xc
    800029de:	37650513          	add	a0,a0,886 # 8000ed50 <bcache>
    800029e2:	00004097          	auipc	ra,0x4
    800029e6:	c36080e7          	jalr	-970(ra) # 80006618 <acquire>
  b->refcnt--;
    800029ea:	40bc                	lw	a5,64(s1)
    800029ec:	37fd                	addw	a5,a5,-1
    800029ee:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800029f0:	0000c517          	auipc	a0,0xc
    800029f4:	36050513          	add	a0,a0,864 # 8000ed50 <bcache>
    800029f8:	00004097          	auipc	ra,0x4
    800029fc:	cd4080e7          	jalr	-812(ra) # 800066cc <release>
}
    80002a00:	60e2                	ld	ra,24(sp)
    80002a02:	6442                	ld	s0,16(sp)
    80002a04:	64a2                	ld	s1,8(sp)
    80002a06:	6105                	add	sp,sp,32
    80002a08:	8082                	ret

0000000080002a0a <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80002a0a:	1101                	add	sp,sp,-32
    80002a0c:	ec06                	sd	ra,24(sp)
    80002a0e:	e822                	sd	s0,16(sp)
    80002a10:	e426                	sd	s1,8(sp)
    80002a12:	e04a                	sd	s2,0(sp)
    80002a14:	1000                	add	s0,sp,32
    80002a16:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80002a18:	00d5d59b          	srlw	a1,a1,0xd
    80002a1c:	00015797          	auipc	a5,0x15
    80002a20:	a107a783          	lw	a5,-1520(a5) # 8001742c <sb+0x1c>
    80002a24:	9dbd                	addw	a1,a1,a5
    80002a26:	00000097          	auipc	ra,0x0
    80002a2a:	da0080e7          	jalr	-608(ra) # 800027c6 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    80002a2e:	0074f713          	and	a4,s1,7
    80002a32:	4785                	li	a5,1
    80002a34:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    80002a38:	14ce                	sll	s1,s1,0x33
    80002a3a:	90d9                	srl	s1,s1,0x36
    80002a3c:	00950733          	add	a4,a0,s1
    80002a40:	05874703          	lbu	a4,88(a4)
    80002a44:	00e7f6b3          	and	a3,a5,a4
    80002a48:	c69d                	beqz	a3,80002a76 <bfree+0x6c>
    80002a4a:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    80002a4c:	94aa                	add	s1,s1,a0
    80002a4e:	fff7c793          	not	a5,a5
    80002a52:	8f7d                	and	a4,a4,a5
    80002a54:	04e48c23          	sb	a4,88(s1)
  log_write(bp);
    80002a58:	00001097          	auipc	ra,0x1
    80002a5c:	0f6080e7          	jalr	246(ra) # 80003b4e <log_write>
  brelse(bp);
    80002a60:	854a                	mv	a0,s2
    80002a62:	00000097          	auipc	ra,0x0
    80002a66:	e94080e7          	jalr	-364(ra) # 800028f6 <brelse>
}
    80002a6a:	60e2                	ld	ra,24(sp)
    80002a6c:	6442                	ld	s0,16(sp)
    80002a6e:	64a2                	ld	s1,8(sp)
    80002a70:	6902                	ld	s2,0(sp)
    80002a72:	6105                	add	sp,sp,32
    80002a74:	8082                	ret
    panic("freeing free block");
    80002a76:	00006517          	auipc	a0,0x6
    80002a7a:	c5250513          	add	a0,a0,-942 # 800086c8 <syscallnames+0x108>
    80002a7e:	00003097          	auipc	ra,0x3
    80002a82:	662080e7          	jalr	1634(ra) # 800060e0 <panic>

0000000080002a86 <balloc>:
{
    80002a86:	711d                	add	sp,sp,-96
    80002a88:	ec86                	sd	ra,88(sp)
    80002a8a:	e8a2                	sd	s0,80(sp)
    80002a8c:	e4a6                	sd	s1,72(sp)
    80002a8e:	e0ca                	sd	s2,64(sp)
    80002a90:	fc4e                	sd	s3,56(sp)
    80002a92:	f852                	sd	s4,48(sp)
    80002a94:	f456                	sd	s5,40(sp)
    80002a96:	f05a                	sd	s6,32(sp)
    80002a98:	ec5e                	sd	s7,24(sp)
    80002a9a:	e862                	sd	s8,16(sp)
    80002a9c:	e466                	sd	s9,8(sp)
    80002a9e:	1080                	add	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80002aa0:	00015797          	auipc	a5,0x15
    80002aa4:	9747a783          	lw	a5,-1676(a5) # 80017414 <sb+0x4>
    80002aa8:	cff5                	beqz	a5,80002ba4 <balloc+0x11e>
    80002aaa:	8baa                	mv	s7,a0
    80002aac:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80002aae:	00015b17          	auipc	s6,0x15
    80002ab2:	962b0b13          	add	s6,s6,-1694 # 80017410 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002ab6:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    80002ab8:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002aba:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80002abc:	6c89                	lui	s9,0x2
    80002abe:	a061                	j	80002b46 <balloc+0xc0>
        bp->data[bi/8] |= m;  // Mark block in use.
    80002ac0:	97ca                	add	a5,a5,s2
    80002ac2:	8e55                	or	a2,a2,a3
    80002ac4:	04c78c23          	sb	a2,88(a5)
        log_write(bp);
    80002ac8:	854a                	mv	a0,s2
    80002aca:	00001097          	auipc	ra,0x1
    80002ace:	084080e7          	jalr	132(ra) # 80003b4e <log_write>
        brelse(bp);
    80002ad2:	854a                	mv	a0,s2
    80002ad4:	00000097          	auipc	ra,0x0
    80002ad8:	e22080e7          	jalr	-478(ra) # 800028f6 <brelse>
  bp = bread(dev, bno);
    80002adc:	85a6                	mv	a1,s1
    80002ade:	855e                	mv	a0,s7
    80002ae0:	00000097          	auipc	ra,0x0
    80002ae4:	ce6080e7          	jalr	-794(ra) # 800027c6 <bread>
    80002ae8:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    80002aea:	40000613          	li	a2,1024
    80002aee:	4581                	li	a1,0
    80002af0:	05850513          	add	a0,a0,88
    80002af4:	ffffd097          	auipc	ra,0xffffd
    80002af8:	6d0080e7          	jalr	1744(ra) # 800001c4 <memset>
  log_write(bp);
    80002afc:	854a                	mv	a0,s2
    80002afe:	00001097          	auipc	ra,0x1
    80002b02:	050080e7          	jalr	80(ra) # 80003b4e <log_write>
  brelse(bp);
    80002b06:	854a                	mv	a0,s2
    80002b08:	00000097          	auipc	ra,0x0
    80002b0c:	dee080e7          	jalr	-530(ra) # 800028f6 <brelse>
}
    80002b10:	8526                	mv	a0,s1
    80002b12:	60e6                	ld	ra,88(sp)
    80002b14:	6446                	ld	s0,80(sp)
    80002b16:	64a6                	ld	s1,72(sp)
    80002b18:	6906                	ld	s2,64(sp)
    80002b1a:	79e2                	ld	s3,56(sp)
    80002b1c:	7a42                	ld	s4,48(sp)
    80002b1e:	7aa2                	ld	s5,40(sp)
    80002b20:	7b02                	ld	s6,32(sp)
    80002b22:	6be2                	ld	s7,24(sp)
    80002b24:	6c42                	ld	s8,16(sp)
    80002b26:	6ca2                	ld	s9,8(sp)
    80002b28:	6125                	add	sp,sp,96
    80002b2a:	8082                	ret
    brelse(bp);
    80002b2c:	854a                	mv	a0,s2
    80002b2e:	00000097          	auipc	ra,0x0
    80002b32:	dc8080e7          	jalr	-568(ra) # 800028f6 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80002b36:	015c87bb          	addw	a5,s9,s5
    80002b3a:	00078a9b          	sext.w	s5,a5
    80002b3e:	004b2703          	lw	a4,4(s6)
    80002b42:	06eaf163          	bgeu	s5,a4,80002ba4 <balloc+0x11e>
    bp = bread(dev, BBLOCK(b, sb));
    80002b46:	41fad79b          	sraw	a5,s5,0x1f
    80002b4a:	0137d79b          	srlw	a5,a5,0x13
    80002b4e:	015787bb          	addw	a5,a5,s5
    80002b52:	40d7d79b          	sraw	a5,a5,0xd
    80002b56:	01cb2583          	lw	a1,28(s6)
    80002b5a:	9dbd                	addw	a1,a1,a5
    80002b5c:	855e                	mv	a0,s7
    80002b5e:	00000097          	auipc	ra,0x0
    80002b62:	c68080e7          	jalr	-920(ra) # 800027c6 <bread>
    80002b66:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002b68:	004b2503          	lw	a0,4(s6)
    80002b6c:	000a849b          	sext.w	s1,s5
    80002b70:	8762                	mv	a4,s8
    80002b72:	faa4fde3          	bgeu	s1,a0,80002b2c <balloc+0xa6>
      m = 1 << (bi % 8);
    80002b76:	00777693          	and	a3,a4,7
    80002b7a:	00d996bb          	sllw	a3,s3,a3
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80002b7e:	41f7579b          	sraw	a5,a4,0x1f
    80002b82:	01d7d79b          	srlw	a5,a5,0x1d
    80002b86:	9fb9                	addw	a5,a5,a4
    80002b88:	4037d79b          	sraw	a5,a5,0x3
    80002b8c:	00f90633          	add	a2,s2,a5
    80002b90:	05864603          	lbu	a2,88(a2)
    80002b94:	00c6f5b3          	and	a1,a3,a2
    80002b98:	d585                	beqz	a1,80002ac0 <balloc+0x3a>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002b9a:	2705                	addw	a4,a4,1
    80002b9c:	2485                	addw	s1,s1,1
    80002b9e:	fd471ae3          	bne	a4,s4,80002b72 <balloc+0xec>
    80002ba2:	b769                	j	80002b2c <balloc+0xa6>
  printf("balloc: out of blocks\n");
    80002ba4:	00006517          	auipc	a0,0x6
    80002ba8:	b3c50513          	add	a0,a0,-1220 # 800086e0 <syscallnames+0x120>
    80002bac:	00003097          	auipc	ra,0x3
    80002bb0:	57e080e7          	jalr	1406(ra) # 8000612a <printf>
  return 0;
    80002bb4:	4481                	li	s1,0
    80002bb6:	bfa9                	j	80002b10 <balloc+0x8a>

0000000080002bb8 <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    80002bb8:	7179                	add	sp,sp,-48
    80002bba:	f406                	sd	ra,40(sp)
    80002bbc:	f022                	sd	s0,32(sp)
    80002bbe:	ec26                	sd	s1,24(sp)
    80002bc0:	e84a                	sd	s2,16(sp)
    80002bc2:	e44e                	sd	s3,8(sp)
    80002bc4:	e052                	sd	s4,0(sp)
    80002bc6:	1800                	add	s0,sp,48
    80002bc8:	89aa                	mv	s3,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80002bca:	47ad                	li	a5,11
    80002bcc:	02b7e863          	bltu	a5,a1,80002bfc <bmap+0x44>
    if((addr = ip->addrs[bn]) == 0){
    80002bd0:	02059793          	sll	a5,a1,0x20
    80002bd4:	01e7d593          	srl	a1,a5,0x1e
    80002bd8:	00b504b3          	add	s1,a0,a1
    80002bdc:	0504a903          	lw	s2,80(s1)
    80002be0:	06091e63          	bnez	s2,80002c5c <bmap+0xa4>
      addr = balloc(ip->dev);
    80002be4:	4108                	lw	a0,0(a0)
    80002be6:	00000097          	auipc	ra,0x0
    80002bea:	ea0080e7          	jalr	-352(ra) # 80002a86 <balloc>
    80002bee:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    80002bf2:	06090563          	beqz	s2,80002c5c <bmap+0xa4>
        return 0;
      ip->addrs[bn] = addr;
    80002bf6:	0524a823          	sw	s2,80(s1)
    80002bfa:	a08d                	j	80002c5c <bmap+0xa4>
    }
    return addr;
  }
  bn -= NDIRECT;
    80002bfc:	ff45849b          	addw	s1,a1,-12
    80002c00:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    80002c04:	0ff00793          	li	a5,255
    80002c08:	08e7e563          	bltu	a5,a4,80002c92 <bmap+0xda>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    80002c0c:	08052903          	lw	s2,128(a0)
    80002c10:	00091d63          	bnez	s2,80002c2a <bmap+0x72>
      addr = balloc(ip->dev);
    80002c14:	4108                	lw	a0,0(a0)
    80002c16:	00000097          	auipc	ra,0x0
    80002c1a:	e70080e7          	jalr	-400(ra) # 80002a86 <balloc>
    80002c1e:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    80002c22:	02090d63          	beqz	s2,80002c5c <bmap+0xa4>
        return 0;
      ip->addrs[NDIRECT] = addr;
    80002c26:	0929a023          	sw	s2,128(s3)
    }
    bp = bread(ip->dev, addr);
    80002c2a:	85ca                	mv	a1,s2
    80002c2c:	0009a503          	lw	a0,0(s3)
    80002c30:	00000097          	auipc	ra,0x0
    80002c34:	b96080e7          	jalr	-1130(ra) # 800027c6 <bread>
    80002c38:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80002c3a:	05850793          	add	a5,a0,88
    if((addr = a[bn]) == 0){
    80002c3e:	02049713          	sll	a4,s1,0x20
    80002c42:	01e75593          	srl	a1,a4,0x1e
    80002c46:	00b784b3          	add	s1,a5,a1
    80002c4a:	0004a903          	lw	s2,0(s1)
    80002c4e:	02090063          	beqz	s2,80002c6e <bmap+0xb6>
      if(addr){
        a[bn] = addr;
        log_write(bp);
      }
    }
    brelse(bp);
    80002c52:	8552                	mv	a0,s4
    80002c54:	00000097          	auipc	ra,0x0
    80002c58:	ca2080e7          	jalr	-862(ra) # 800028f6 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    80002c5c:	854a                	mv	a0,s2
    80002c5e:	70a2                	ld	ra,40(sp)
    80002c60:	7402                	ld	s0,32(sp)
    80002c62:	64e2                	ld	s1,24(sp)
    80002c64:	6942                	ld	s2,16(sp)
    80002c66:	69a2                	ld	s3,8(sp)
    80002c68:	6a02                	ld	s4,0(sp)
    80002c6a:	6145                	add	sp,sp,48
    80002c6c:	8082                	ret
      addr = balloc(ip->dev);
    80002c6e:	0009a503          	lw	a0,0(s3)
    80002c72:	00000097          	auipc	ra,0x0
    80002c76:	e14080e7          	jalr	-492(ra) # 80002a86 <balloc>
    80002c7a:	0005091b          	sext.w	s2,a0
      if(addr){
    80002c7e:	fc090ae3          	beqz	s2,80002c52 <bmap+0x9a>
        a[bn] = addr;
    80002c82:	0124a023          	sw	s2,0(s1)
        log_write(bp);
    80002c86:	8552                	mv	a0,s4
    80002c88:	00001097          	auipc	ra,0x1
    80002c8c:	ec6080e7          	jalr	-314(ra) # 80003b4e <log_write>
    80002c90:	b7c9                	j	80002c52 <bmap+0x9a>
  panic("bmap: out of range");
    80002c92:	00006517          	auipc	a0,0x6
    80002c96:	a6650513          	add	a0,a0,-1434 # 800086f8 <syscallnames+0x138>
    80002c9a:	00003097          	auipc	ra,0x3
    80002c9e:	446080e7          	jalr	1094(ra) # 800060e0 <panic>

0000000080002ca2 <iget>:
{
    80002ca2:	7179                	add	sp,sp,-48
    80002ca4:	f406                	sd	ra,40(sp)
    80002ca6:	f022                	sd	s0,32(sp)
    80002ca8:	ec26                	sd	s1,24(sp)
    80002caa:	e84a                	sd	s2,16(sp)
    80002cac:	e44e                	sd	s3,8(sp)
    80002cae:	e052                	sd	s4,0(sp)
    80002cb0:	1800                	add	s0,sp,48
    80002cb2:	89aa                	mv	s3,a0
    80002cb4:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    80002cb6:	00014517          	auipc	a0,0x14
    80002cba:	77a50513          	add	a0,a0,1914 # 80017430 <itable>
    80002cbe:	00004097          	auipc	ra,0x4
    80002cc2:	95a080e7          	jalr	-1702(ra) # 80006618 <acquire>
  empty = 0;
    80002cc6:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002cc8:	00014497          	auipc	s1,0x14
    80002ccc:	78048493          	add	s1,s1,1920 # 80017448 <itable+0x18>
    80002cd0:	00016697          	auipc	a3,0x16
    80002cd4:	20868693          	add	a3,a3,520 # 80018ed8 <log>
    80002cd8:	a039                	j	80002ce6 <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002cda:	02090b63          	beqz	s2,80002d10 <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002cde:	08848493          	add	s1,s1,136
    80002ce2:	02d48a63          	beq	s1,a3,80002d16 <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80002ce6:	449c                	lw	a5,8(s1)
    80002ce8:	fef059e3          	blez	a5,80002cda <iget+0x38>
    80002cec:	4098                	lw	a4,0(s1)
    80002cee:	ff3716e3          	bne	a4,s3,80002cda <iget+0x38>
    80002cf2:	40d8                	lw	a4,4(s1)
    80002cf4:	ff4713e3          	bne	a4,s4,80002cda <iget+0x38>
      ip->ref++;
    80002cf8:	2785                	addw	a5,a5,1
    80002cfa:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80002cfc:	00014517          	auipc	a0,0x14
    80002d00:	73450513          	add	a0,a0,1844 # 80017430 <itable>
    80002d04:	00004097          	auipc	ra,0x4
    80002d08:	9c8080e7          	jalr	-1592(ra) # 800066cc <release>
      return ip;
    80002d0c:	8926                	mv	s2,s1
    80002d0e:	a03d                	j	80002d3c <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002d10:	f7f9                	bnez	a5,80002cde <iget+0x3c>
    80002d12:	8926                	mv	s2,s1
    80002d14:	b7e9                	j	80002cde <iget+0x3c>
  if(empty == 0)
    80002d16:	02090c63          	beqz	s2,80002d4e <iget+0xac>
  ip->dev = dev;
    80002d1a:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80002d1e:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    80002d22:	4785                	li	a5,1
    80002d24:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80002d28:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80002d2c:	00014517          	auipc	a0,0x14
    80002d30:	70450513          	add	a0,a0,1796 # 80017430 <itable>
    80002d34:	00004097          	auipc	ra,0x4
    80002d38:	998080e7          	jalr	-1640(ra) # 800066cc <release>
}
    80002d3c:	854a                	mv	a0,s2
    80002d3e:	70a2                	ld	ra,40(sp)
    80002d40:	7402                	ld	s0,32(sp)
    80002d42:	64e2                	ld	s1,24(sp)
    80002d44:	6942                	ld	s2,16(sp)
    80002d46:	69a2                	ld	s3,8(sp)
    80002d48:	6a02                	ld	s4,0(sp)
    80002d4a:	6145                	add	sp,sp,48
    80002d4c:	8082                	ret
    panic("iget: no inodes");
    80002d4e:	00006517          	auipc	a0,0x6
    80002d52:	9c250513          	add	a0,a0,-1598 # 80008710 <syscallnames+0x150>
    80002d56:	00003097          	auipc	ra,0x3
    80002d5a:	38a080e7          	jalr	906(ra) # 800060e0 <panic>

0000000080002d5e <fsinit>:
fsinit(int dev) {
    80002d5e:	7179                	add	sp,sp,-48
    80002d60:	f406                	sd	ra,40(sp)
    80002d62:	f022                	sd	s0,32(sp)
    80002d64:	ec26                	sd	s1,24(sp)
    80002d66:	e84a                	sd	s2,16(sp)
    80002d68:	e44e                	sd	s3,8(sp)
    80002d6a:	1800                	add	s0,sp,48
    80002d6c:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80002d6e:	4585                	li	a1,1
    80002d70:	00000097          	auipc	ra,0x0
    80002d74:	a56080e7          	jalr	-1450(ra) # 800027c6 <bread>
    80002d78:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80002d7a:	00014997          	auipc	s3,0x14
    80002d7e:	69698993          	add	s3,s3,1686 # 80017410 <sb>
    80002d82:	02000613          	li	a2,32
    80002d86:	05850593          	add	a1,a0,88
    80002d8a:	854e                	mv	a0,s3
    80002d8c:	ffffd097          	auipc	ra,0xffffd
    80002d90:	494080e7          	jalr	1172(ra) # 80000220 <memmove>
  brelse(bp);
    80002d94:	8526                	mv	a0,s1
    80002d96:	00000097          	auipc	ra,0x0
    80002d9a:	b60080e7          	jalr	-1184(ra) # 800028f6 <brelse>
  if(sb.magic != FSMAGIC)
    80002d9e:	0009a703          	lw	a4,0(s3)
    80002da2:	102037b7          	lui	a5,0x10203
    80002da6:	04078793          	add	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80002daa:	02f71263          	bne	a4,a5,80002dce <fsinit+0x70>
  initlog(dev, &sb);
    80002dae:	00014597          	auipc	a1,0x14
    80002db2:	66258593          	add	a1,a1,1634 # 80017410 <sb>
    80002db6:	854a                	mv	a0,s2
    80002db8:	00001097          	auipc	ra,0x1
    80002dbc:	b2c080e7          	jalr	-1236(ra) # 800038e4 <initlog>
}
    80002dc0:	70a2                	ld	ra,40(sp)
    80002dc2:	7402                	ld	s0,32(sp)
    80002dc4:	64e2                	ld	s1,24(sp)
    80002dc6:	6942                	ld	s2,16(sp)
    80002dc8:	69a2                	ld	s3,8(sp)
    80002dca:	6145                	add	sp,sp,48
    80002dcc:	8082                	ret
    panic("invalid file system");
    80002dce:	00006517          	auipc	a0,0x6
    80002dd2:	95250513          	add	a0,a0,-1710 # 80008720 <syscallnames+0x160>
    80002dd6:	00003097          	auipc	ra,0x3
    80002dda:	30a080e7          	jalr	778(ra) # 800060e0 <panic>

0000000080002dde <iinit>:
{
    80002dde:	7179                	add	sp,sp,-48
    80002de0:	f406                	sd	ra,40(sp)
    80002de2:	f022                	sd	s0,32(sp)
    80002de4:	ec26                	sd	s1,24(sp)
    80002de6:	e84a                	sd	s2,16(sp)
    80002de8:	e44e                	sd	s3,8(sp)
    80002dea:	1800                	add	s0,sp,48
  initlock(&itable.lock, "itable");
    80002dec:	00006597          	auipc	a1,0x6
    80002df0:	94c58593          	add	a1,a1,-1716 # 80008738 <syscallnames+0x178>
    80002df4:	00014517          	auipc	a0,0x14
    80002df8:	63c50513          	add	a0,a0,1596 # 80017430 <itable>
    80002dfc:	00003097          	auipc	ra,0x3
    80002e00:	78c080e7          	jalr	1932(ra) # 80006588 <initlock>
  for(i = 0; i < NINODE; i++) {
    80002e04:	00014497          	auipc	s1,0x14
    80002e08:	65448493          	add	s1,s1,1620 # 80017458 <itable+0x28>
    80002e0c:	00016997          	auipc	s3,0x16
    80002e10:	0dc98993          	add	s3,s3,220 # 80018ee8 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80002e14:	00006917          	auipc	s2,0x6
    80002e18:	92c90913          	add	s2,s2,-1748 # 80008740 <syscallnames+0x180>
    80002e1c:	85ca                	mv	a1,s2
    80002e1e:	8526                	mv	a0,s1
    80002e20:	00001097          	auipc	ra,0x1
    80002e24:	e12080e7          	jalr	-494(ra) # 80003c32 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80002e28:	08848493          	add	s1,s1,136
    80002e2c:	ff3498e3          	bne	s1,s3,80002e1c <iinit+0x3e>
}
    80002e30:	70a2                	ld	ra,40(sp)
    80002e32:	7402                	ld	s0,32(sp)
    80002e34:	64e2                	ld	s1,24(sp)
    80002e36:	6942                	ld	s2,16(sp)
    80002e38:	69a2                	ld	s3,8(sp)
    80002e3a:	6145                	add	sp,sp,48
    80002e3c:	8082                	ret

0000000080002e3e <ialloc>:
{
    80002e3e:	7139                	add	sp,sp,-64
    80002e40:	fc06                	sd	ra,56(sp)
    80002e42:	f822                	sd	s0,48(sp)
    80002e44:	f426                	sd	s1,40(sp)
    80002e46:	f04a                	sd	s2,32(sp)
    80002e48:	ec4e                	sd	s3,24(sp)
    80002e4a:	e852                	sd	s4,16(sp)
    80002e4c:	e456                	sd	s5,8(sp)
    80002e4e:	e05a                	sd	s6,0(sp)
    80002e50:	0080                	add	s0,sp,64
  for(inum = 1; inum < sb.ninodes; inum++){
    80002e52:	00014717          	auipc	a4,0x14
    80002e56:	5ca72703          	lw	a4,1482(a4) # 8001741c <sb+0xc>
    80002e5a:	4785                	li	a5,1
    80002e5c:	04e7f863          	bgeu	a5,a4,80002eac <ialloc+0x6e>
    80002e60:	8aaa                	mv	s5,a0
    80002e62:	8b2e                	mv	s6,a1
    80002e64:	4905                	li	s2,1
    bp = bread(dev, IBLOCK(inum, sb));
    80002e66:	00014a17          	auipc	s4,0x14
    80002e6a:	5aaa0a13          	add	s4,s4,1450 # 80017410 <sb>
    80002e6e:	00495593          	srl	a1,s2,0x4
    80002e72:	018a2783          	lw	a5,24(s4)
    80002e76:	9dbd                	addw	a1,a1,a5
    80002e78:	8556                	mv	a0,s5
    80002e7a:	00000097          	auipc	ra,0x0
    80002e7e:	94c080e7          	jalr	-1716(ra) # 800027c6 <bread>
    80002e82:	84aa                	mv	s1,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002e84:	05850993          	add	s3,a0,88
    80002e88:	00f97793          	and	a5,s2,15
    80002e8c:	079a                	sll	a5,a5,0x6
    80002e8e:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80002e90:	00099783          	lh	a5,0(s3)
    80002e94:	cf9d                	beqz	a5,80002ed2 <ialloc+0x94>
    brelse(bp);
    80002e96:	00000097          	auipc	ra,0x0
    80002e9a:	a60080e7          	jalr	-1440(ra) # 800028f6 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80002e9e:	0905                	add	s2,s2,1
    80002ea0:	00ca2703          	lw	a4,12(s4)
    80002ea4:	0009079b          	sext.w	a5,s2
    80002ea8:	fce7e3e3          	bltu	a5,a4,80002e6e <ialloc+0x30>
  printf("ialloc: no inodes\n");
    80002eac:	00006517          	auipc	a0,0x6
    80002eb0:	89c50513          	add	a0,a0,-1892 # 80008748 <syscallnames+0x188>
    80002eb4:	00003097          	auipc	ra,0x3
    80002eb8:	276080e7          	jalr	630(ra) # 8000612a <printf>
  return 0;
    80002ebc:	4501                	li	a0,0
}
    80002ebe:	70e2                	ld	ra,56(sp)
    80002ec0:	7442                	ld	s0,48(sp)
    80002ec2:	74a2                	ld	s1,40(sp)
    80002ec4:	7902                	ld	s2,32(sp)
    80002ec6:	69e2                	ld	s3,24(sp)
    80002ec8:	6a42                	ld	s4,16(sp)
    80002eca:	6aa2                	ld	s5,8(sp)
    80002ecc:	6b02                	ld	s6,0(sp)
    80002ece:	6121                	add	sp,sp,64
    80002ed0:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    80002ed2:	04000613          	li	a2,64
    80002ed6:	4581                	li	a1,0
    80002ed8:	854e                	mv	a0,s3
    80002eda:	ffffd097          	auipc	ra,0xffffd
    80002ede:	2ea080e7          	jalr	746(ra) # 800001c4 <memset>
      dip->type = type;
    80002ee2:	01699023          	sh	s6,0(s3)
      log_write(bp);   // mark it allocated on the disk
    80002ee6:	8526                	mv	a0,s1
    80002ee8:	00001097          	auipc	ra,0x1
    80002eec:	c66080e7          	jalr	-922(ra) # 80003b4e <log_write>
      brelse(bp);
    80002ef0:	8526                	mv	a0,s1
    80002ef2:	00000097          	auipc	ra,0x0
    80002ef6:	a04080e7          	jalr	-1532(ra) # 800028f6 <brelse>
      return iget(dev, inum);
    80002efa:	0009059b          	sext.w	a1,s2
    80002efe:	8556                	mv	a0,s5
    80002f00:	00000097          	auipc	ra,0x0
    80002f04:	da2080e7          	jalr	-606(ra) # 80002ca2 <iget>
    80002f08:	bf5d                	j	80002ebe <ialloc+0x80>

0000000080002f0a <iupdate>:
{
    80002f0a:	1101                	add	sp,sp,-32
    80002f0c:	ec06                	sd	ra,24(sp)
    80002f0e:	e822                	sd	s0,16(sp)
    80002f10:	e426                	sd	s1,8(sp)
    80002f12:	e04a                	sd	s2,0(sp)
    80002f14:	1000                	add	s0,sp,32
    80002f16:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002f18:	415c                	lw	a5,4(a0)
    80002f1a:	0047d79b          	srlw	a5,a5,0x4
    80002f1e:	00014597          	auipc	a1,0x14
    80002f22:	50a5a583          	lw	a1,1290(a1) # 80017428 <sb+0x18>
    80002f26:	9dbd                	addw	a1,a1,a5
    80002f28:	4108                	lw	a0,0(a0)
    80002f2a:	00000097          	auipc	ra,0x0
    80002f2e:	89c080e7          	jalr	-1892(ra) # 800027c6 <bread>
    80002f32:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002f34:	05850793          	add	a5,a0,88
    80002f38:	40d8                	lw	a4,4(s1)
    80002f3a:	8b3d                	and	a4,a4,15
    80002f3c:	071a                	sll	a4,a4,0x6
    80002f3e:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    80002f40:	04449703          	lh	a4,68(s1)
    80002f44:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80002f48:	04649703          	lh	a4,70(s1)
    80002f4c:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80002f50:	04849703          	lh	a4,72(s1)
    80002f54:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80002f58:	04a49703          	lh	a4,74(s1)
    80002f5c:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80002f60:	44f8                	lw	a4,76(s1)
    80002f62:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002f64:	03400613          	li	a2,52
    80002f68:	05048593          	add	a1,s1,80
    80002f6c:	00c78513          	add	a0,a5,12
    80002f70:	ffffd097          	auipc	ra,0xffffd
    80002f74:	2b0080e7          	jalr	688(ra) # 80000220 <memmove>
  log_write(bp);
    80002f78:	854a                	mv	a0,s2
    80002f7a:	00001097          	auipc	ra,0x1
    80002f7e:	bd4080e7          	jalr	-1068(ra) # 80003b4e <log_write>
  brelse(bp);
    80002f82:	854a                	mv	a0,s2
    80002f84:	00000097          	auipc	ra,0x0
    80002f88:	972080e7          	jalr	-1678(ra) # 800028f6 <brelse>
}
    80002f8c:	60e2                	ld	ra,24(sp)
    80002f8e:	6442                	ld	s0,16(sp)
    80002f90:	64a2                	ld	s1,8(sp)
    80002f92:	6902                	ld	s2,0(sp)
    80002f94:	6105                	add	sp,sp,32
    80002f96:	8082                	ret

0000000080002f98 <idup>:
{
    80002f98:	1101                	add	sp,sp,-32
    80002f9a:	ec06                	sd	ra,24(sp)
    80002f9c:	e822                	sd	s0,16(sp)
    80002f9e:	e426                	sd	s1,8(sp)
    80002fa0:	1000                	add	s0,sp,32
    80002fa2:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002fa4:	00014517          	auipc	a0,0x14
    80002fa8:	48c50513          	add	a0,a0,1164 # 80017430 <itable>
    80002fac:	00003097          	auipc	ra,0x3
    80002fb0:	66c080e7          	jalr	1644(ra) # 80006618 <acquire>
  ip->ref++;
    80002fb4:	449c                	lw	a5,8(s1)
    80002fb6:	2785                	addw	a5,a5,1
    80002fb8:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002fba:	00014517          	auipc	a0,0x14
    80002fbe:	47650513          	add	a0,a0,1142 # 80017430 <itable>
    80002fc2:	00003097          	auipc	ra,0x3
    80002fc6:	70a080e7          	jalr	1802(ra) # 800066cc <release>
}
    80002fca:	8526                	mv	a0,s1
    80002fcc:	60e2                	ld	ra,24(sp)
    80002fce:	6442                	ld	s0,16(sp)
    80002fd0:	64a2                	ld	s1,8(sp)
    80002fd2:	6105                	add	sp,sp,32
    80002fd4:	8082                	ret

0000000080002fd6 <ilock>:
{
    80002fd6:	1101                	add	sp,sp,-32
    80002fd8:	ec06                	sd	ra,24(sp)
    80002fda:	e822                	sd	s0,16(sp)
    80002fdc:	e426                	sd	s1,8(sp)
    80002fde:	e04a                	sd	s2,0(sp)
    80002fe0:	1000                	add	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80002fe2:	c115                	beqz	a0,80003006 <ilock+0x30>
    80002fe4:	84aa                	mv	s1,a0
    80002fe6:	451c                	lw	a5,8(a0)
    80002fe8:	00f05f63          	blez	a5,80003006 <ilock+0x30>
  acquiresleep(&ip->lock);
    80002fec:	0541                	add	a0,a0,16
    80002fee:	00001097          	auipc	ra,0x1
    80002ff2:	c7e080e7          	jalr	-898(ra) # 80003c6c <acquiresleep>
  if(ip->valid == 0){
    80002ff6:	40bc                	lw	a5,64(s1)
    80002ff8:	cf99                	beqz	a5,80003016 <ilock+0x40>
}
    80002ffa:	60e2                	ld	ra,24(sp)
    80002ffc:	6442                	ld	s0,16(sp)
    80002ffe:	64a2                	ld	s1,8(sp)
    80003000:	6902                	ld	s2,0(sp)
    80003002:	6105                	add	sp,sp,32
    80003004:	8082                	ret
    panic("ilock");
    80003006:	00005517          	auipc	a0,0x5
    8000300a:	75a50513          	add	a0,a0,1882 # 80008760 <syscallnames+0x1a0>
    8000300e:	00003097          	auipc	ra,0x3
    80003012:	0d2080e7          	jalr	210(ra) # 800060e0 <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003016:	40dc                	lw	a5,4(s1)
    80003018:	0047d79b          	srlw	a5,a5,0x4
    8000301c:	00014597          	auipc	a1,0x14
    80003020:	40c5a583          	lw	a1,1036(a1) # 80017428 <sb+0x18>
    80003024:	9dbd                	addw	a1,a1,a5
    80003026:	4088                	lw	a0,0(s1)
    80003028:	fffff097          	auipc	ra,0xfffff
    8000302c:	79e080e7          	jalr	1950(ra) # 800027c6 <bread>
    80003030:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80003032:	05850593          	add	a1,a0,88
    80003036:	40dc                	lw	a5,4(s1)
    80003038:	8bbd                	and	a5,a5,15
    8000303a:	079a                	sll	a5,a5,0x6
    8000303c:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    8000303e:	00059783          	lh	a5,0(a1)
    80003042:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80003046:	00259783          	lh	a5,2(a1)
    8000304a:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    8000304e:	00459783          	lh	a5,4(a1)
    80003052:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80003056:	00659783          	lh	a5,6(a1)
    8000305a:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    8000305e:	459c                	lw	a5,8(a1)
    80003060:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80003062:	03400613          	li	a2,52
    80003066:	05b1                	add	a1,a1,12
    80003068:	05048513          	add	a0,s1,80
    8000306c:	ffffd097          	auipc	ra,0xffffd
    80003070:	1b4080e7          	jalr	436(ra) # 80000220 <memmove>
    brelse(bp);
    80003074:	854a                	mv	a0,s2
    80003076:	00000097          	auipc	ra,0x0
    8000307a:	880080e7          	jalr	-1920(ra) # 800028f6 <brelse>
    ip->valid = 1;
    8000307e:	4785                	li	a5,1
    80003080:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80003082:	04449783          	lh	a5,68(s1)
    80003086:	fbb5                	bnez	a5,80002ffa <ilock+0x24>
      panic("ilock: no type");
    80003088:	00005517          	auipc	a0,0x5
    8000308c:	6e050513          	add	a0,a0,1760 # 80008768 <syscallnames+0x1a8>
    80003090:	00003097          	auipc	ra,0x3
    80003094:	050080e7          	jalr	80(ra) # 800060e0 <panic>

0000000080003098 <iunlock>:
{
    80003098:	1101                	add	sp,sp,-32
    8000309a:	ec06                	sd	ra,24(sp)
    8000309c:	e822                	sd	s0,16(sp)
    8000309e:	e426                	sd	s1,8(sp)
    800030a0:	e04a                	sd	s2,0(sp)
    800030a2:	1000                	add	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    800030a4:	c905                	beqz	a0,800030d4 <iunlock+0x3c>
    800030a6:	84aa                	mv	s1,a0
    800030a8:	01050913          	add	s2,a0,16
    800030ac:	854a                	mv	a0,s2
    800030ae:	00001097          	auipc	ra,0x1
    800030b2:	c58080e7          	jalr	-936(ra) # 80003d06 <holdingsleep>
    800030b6:	cd19                	beqz	a0,800030d4 <iunlock+0x3c>
    800030b8:	449c                	lw	a5,8(s1)
    800030ba:	00f05d63          	blez	a5,800030d4 <iunlock+0x3c>
  releasesleep(&ip->lock);
    800030be:	854a                	mv	a0,s2
    800030c0:	00001097          	auipc	ra,0x1
    800030c4:	c02080e7          	jalr	-1022(ra) # 80003cc2 <releasesleep>
}
    800030c8:	60e2                	ld	ra,24(sp)
    800030ca:	6442                	ld	s0,16(sp)
    800030cc:	64a2                	ld	s1,8(sp)
    800030ce:	6902                	ld	s2,0(sp)
    800030d0:	6105                	add	sp,sp,32
    800030d2:	8082                	ret
    panic("iunlock");
    800030d4:	00005517          	auipc	a0,0x5
    800030d8:	6a450513          	add	a0,a0,1700 # 80008778 <syscallnames+0x1b8>
    800030dc:	00003097          	auipc	ra,0x3
    800030e0:	004080e7          	jalr	4(ra) # 800060e0 <panic>

00000000800030e4 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    800030e4:	7179                	add	sp,sp,-48
    800030e6:	f406                	sd	ra,40(sp)
    800030e8:	f022                	sd	s0,32(sp)
    800030ea:	ec26                	sd	s1,24(sp)
    800030ec:	e84a                	sd	s2,16(sp)
    800030ee:	e44e                	sd	s3,8(sp)
    800030f0:	e052                	sd	s4,0(sp)
    800030f2:	1800                	add	s0,sp,48
    800030f4:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    800030f6:	05050493          	add	s1,a0,80
    800030fa:	08050913          	add	s2,a0,128
    800030fe:	a021                	j	80003106 <itrunc+0x22>
    80003100:	0491                	add	s1,s1,4
    80003102:	01248d63          	beq	s1,s2,8000311c <itrunc+0x38>
    if(ip->addrs[i]){
    80003106:	408c                	lw	a1,0(s1)
    80003108:	dde5                	beqz	a1,80003100 <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    8000310a:	0009a503          	lw	a0,0(s3)
    8000310e:	00000097          	auipc	ra,0x0
    80003112:	8fc080e7          	jalr	-1796(ra) # 80002a0a <bfree>
      ip->addrs[i] = 0;
    80003116:	0004a023          	sw	zero,0(s1)
    8000311a:	b7dd                	j	80003100 <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    8000311c:	0809a583          	lw	a1,128(s3)
    80003120:	e185                	bnez	a1,80003140 <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80003122:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80003126:	854e                	mv	a0,s3
    80003128:	00000097          	auipc	ra,0x0
    8000312c:	de2080e7          	jalr	-542(ra) # 80002f0a <iupdate>
}
    80003130:	70a2                	ld	ra,40(sp)
    80003132:	7402                	ld	s0,32(sp)
    80003134:	64e2                	ld	s1,24(sp)
    80003136:	6942                	ld	s2,16(sp)
    80003138:	69a2                	ld	s3,8(sp)
    8000313a:	6a02                	ld	s4,0(sp)
    8000313c:	6145                	add	sp,sp,48
    8000313e:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80003140:	0009a503          	lw	a0,0(s3)
    80003144:	fffff097          	auipc	ra,0xfffff
    80003148:	682080e7          	jalr	1666(ra) # 800027c6 <bread>
    8000314c:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    8000314e:	05850493          	add	s1,a0,88
    80003152:	45850913          	add	s2,a0,1112
    80003156:	a021                	j	8000315e <itrunc+0x7a>
    80003158:	0491                	add	s1,s1,4
    8000315a:	01248b63          	beq	s1,s2,80003170 <itrunc+0x8c>
      if(a[j])
    8000315e:	408c                	lw	a1,0(s1)
    80003160:	dde5                	beqz	a1,80003158 <itrunc+0x74>
        bfree(ip->dev, a[j]);
    80003162:	0009a503          	lw	a0,0(s3)
    80003166:	00000097          	auipc	ra,0x0
    8000316a:	8a4080e7          	jalr	-1884(ra) # 80002a0a <bfree>
    8000316e:	b7ed                	j	80003158 <itrunc+0x74>
    brelse(bp);
    80003170:	8552                	mv	a0,s4
    80003172:	fffff097          	auipc	ra,0xfffff
    80003176:	784080e7          	jalr	1924(ra) # 800028f6 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    8000317a:	0809a583          	lw	a1,128(s3)
    8000317e:	0009a503          	lw	a0,0(s3)
    80003182:	00000097          	auipc	ra,0x0
    80003186:	888080e7          	jalr	-1912(ra) # 80002a0a <bfree>
    ip->addrs[NDIRECT] = 0;
    8000318a:	0809a023          	sw	zero,128(s3)
    8000318e:	bf51                	j	80003122 <itrunc+0x3e>

0000000080003190 <iput>:
{
    80003190:	1101                	add	sp,sp,-32
    80003192:	ec06                	sd	ra,24(sp)
    80003194:	e822                	sd	s0,16(sp)
    80003196:	e426                	sd	s1,8(sp)
    80003198:	e04a                	sd	s2,0(sp)
    8000319a:	1000                	add	s0,sp,32
    8000319c:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    8000319e:	00014517          	auipc	a0,0x14
    800031a2:	29250513          	add	a0,a0,658 # 80017430 <itable>
    800031a6:	00003097          	auipc	ra,0x3
    800031aa:	472080e7          	jalr	1138(ra) # 80006618 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    800031ae:	4498                	lw	a4,8(s1)
    800031b0:	4785                	li	a5,1
    800031b2:	02f70363          	beq	a4,a5,800031d8 <iput+0x48>
  ip->ref--;
    800031b6:	449c                	lw	a5,8(s1)
    800031b8:	37fd                	addw	a5,a5,-1
    800031ba:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    800031bc:	00014517          	auipc	a0,0x14
    800031c0:	27450513          	add	a0,a0,628 # 80017430 <itable>
    800031c4:	00003097          	auipc	ra,0x3
    800031c8:	508080e7          	jalr	1288(ra) # 800066cc <release>
}
    800031cc:	60e2                	ld	ra,24(sp)
    800031ce:	6442                	ld	s0,16(sp)
    800031d0:	64a2                	ld	s1,8(sp)
    800031d2:	6902                	ld	s2,0(sp)
    800031d4:	6105                	add	sp,sp,32
    800031d6:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    800031d8:	40bc                	lw	a5,64(s1)
    800031da:	dff1                	beqz	a5,800031b6 <iput+0x26>
    800031dc:	04a49783          	lh	a5,74(s1)
    800031e0:	fbf9                	bnez	a5,800031b6 <iput+0x26>
    acquiresleep(&ip->lock);
    800031e2:	01048913          	add	s2,s1,16
    800031e6:	854a                	mv	a0,s2
    800031e8:	00001097          	auipc	ra,0x1
    800031ec:	a84080e7          	jalr	-1404(ra) # 80003c6c <acquiresleep>
    release(&itable.lock);
    800031f0:	00014517          	auipc	a0,0x14
    800031f4:	24050513          	add	a0,a0,576 # 80017430 <itable>
    800031f8:	00003097          	auipc	ra,0x3
    800031fc:	4d4080e7          	jalr	1236(ra) # 800066cc <release>
    itrunc(ip);
    80003200:	8526                	mv	a0,s1
    80003202:	00000097          	auipc	ra,0x0
    80003206:	ee2080e7          	jalr	-286(ra) # 800030e4 <itrunc>
    ip->type = 0;
    8000320a:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    8000320e:	8526                	mv	a0,s1
    80003210:	00000097          	auipc	ra,0x0
    80003214:	cfa080e7          	jalr	-774(ra) # 80002f0a <iupdate>
    ip->valid = 0;
    80003218:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    8000321c:	854a                	mv	a0,s2
    8000321e:	00001097          	auipc	ra,0x1
    80003222:	aa4080e7          	jalr	-1372(ra) # 80003cc2 <releasesleep>
    acquire(&itable.lock);
    80003226:	00014517          	auipc	a0,0x14
    8000322a:	20a50513          	add	a0,a0,522 # 80017430 <itable>
    8000322e:	00003097          	auipc	ra,0x3
    80003232:	3ea080e7          	jalr	1002(ra) # 80006618 <acquire>
    80003236:	b741                	j	800031b6 <iput+0x26>

0000000080003238 <iunlockput>:
{
    80003238:	1101                	add	sp,sp,-32
    8000323a:	ec06                	sd	ra,24(sp)
    8000323c:	e822                	sd	s0,16(sp)
    8000323e:	e426                	sd	s1,8(sp)
    80003240:	1000                	add	s0,sp,32
    80003242:	84aa                	mv	s1,a0
  iunlock(ip);
    80003244:	00000097          	auipc	ra,0x0
    80003248:	e54080e7          	jalr	-428(ra) # 80003098 <iunlock>
  iput(ip);
    8000324c:	8526                	mv	a0,s1
    8000324e:	00000097          	auipc	ra,0x0
    80003252:	f42080e7          	jalr	-190(ra) # 80003190 <iput>
}
    80003256:	60e2                	ld	ra,24(sp)
    80003258:	6442                	ld	s0,16(sp)
    8000325a:	64a2                	ld	s1,8(sp)
    8000325c:	6105                	add	sp,sp,32
    8000325e:	8082                	ret

0000000080003260 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80003260:	1141                	add	sp,sp,-16
    80003262:	e422                	sd	s0,8(sp)
    80003264:	0800                	add	s0,sp,16
  st->dev = ip->dev;
    80003266:	411c                	lw	a5,0(a0)
    80003268:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    8000326a:	415c                	lw	a5,4(a0)
    8000326c:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    8000326e:	04451783          	lh	a5,68(a0)
    80003272:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80003276:	04a51783          	lh	a5,74(a0)
    8000327a:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    8000327e:	04c56783          	lwu	a5,76(a0)
    80003282:	e99c                	sd	a5,16(a1)
}
    80003284:	6422                	ld	s0,8(sp)
    80003286:	0141                	add	sp,sp,16
    80003288:	8082                	ret

000000008000328a <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    8000328a:	457c                	lw	a5,76(a0)
    8000328c:	0ed7e963          	bltu	a5,a3,8000337e <readi+0xf4>
{
    80003290:	7159                	add	sp,sp,-112
    80003292:	f486                	sd	ra,104(sp)
    80003294:	f0a2                	sd	s0,96(sp)
    80003296:	eca6                	sd	s1,88(sp)
    80003298:	e8ca                	sd	s2,80(sp)
    8000329a:	e4ce                	sd	s3,72(sp)
    8000329c:	e0d2                	sd	s4,64(sp)
    8000329e:	fc56                	sd	s5,56(sp)
    800032a0:	f85a                	sd	s6,48(sp)
    800032a2:	f45e                	sd	s7,40(sp)
    800032a4:	f062                	sd	s8,32(sp)
    800032a6:	ec66                	sd	s9,24(sp)
    800032a8:	e86a                	sd	s10,16(sp)
    800032aa:	e46e                	sd	s11,8(sp)
    800032ac:	1880                	add	s0,sp,112
    800032ae:	8b2a                	mv	s6,a0
    800032b0:	8bae                	mv	s7,a1
    800032b2:	8a32                	mv	s4,a2
    800032b4:	84b6                	mv	s1,a3
    800032b6:	8aba                	mv	s5,a4
  if(off > ip->size || off + n < off)
    800032b8:	9f35                	addw	a4,a4,a3
    return 0;
    800032ba:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    800032bc:	0ad76063          	bltu	a4,a3,8000335c <readi+0xd2>
  if(off + n > ip->size)
    800032c0:	00e7f463          	bgeu	a5,a4,800032c8 <readi+0x3e>
    n = ip->size - off;
    800032c4:	40d78abb          	subw	s5,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800032c8:	0a0a8963          	beqz	s5,8000337a <readi+0xf0>
    800032cc:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    800032ce:	40000c93          	li	s9,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    800032d2:	5c7d                	li	s8,-1
    800032d4:	a82d                	j	8000330e <readi+0x84>
    800032d6:	020d1d93          	sll	s11,s10,0x20
    800032da:	020ddd93          	srl	s11,s11,0x20
    800032de:	05890613          	add	a2,s2,88
    800032e2:	86ee                	mv	a3,s11
    800032e4:	963a                	add	a2,a2,a4
    800032e6:	85d2                	mv	a1,s4
    800032e8:	855e                	mv	a0,s7
    800032ea:	fffff097          	auipc	ra,0xfffff
    800032ee:	8b8080e7          	jalr	-1864(ra) # 80001ba2 <either_copyout>
    800032f2:	05850d63          	beq	a0,s8,8000334c <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    800032f6:	854a                	mv	a0,s2
    800032f8:	fffff097          	auipc	ra,0xfffff
    800032fc:	5fe080e7          	jalr	1534(ra) # 800028f6 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003300:	013d09bb          	addw	s3,s10,s3
    80003304:	009d04bb          	addw	s1,s10,s1
    80003308:	9a6e                	add	s4,s4,s11
    8000330a:	0559f763          	bgeu	s3,s5,80003358 <readi+0xce>
    uint addr = bmap(ip, off/BSIZE);
    8000330e:	00a4d59b          	srlw	a1,s1,0xa
    80003312:	855a                	mv	a0,s6
    80003314:	00000097          	auipc	ra,0x0
    80003318:	8a4080e7          	jalr	-1884(ra) # 80002bb8 <bmap>
    8000331c:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    80003320:	cd85                	beqz	a1,80003358 <readi+0xce>
    bp = bread(ip->dev, addr);
    80003322:	000b2503          	lw	a0,0(s6)
    80003326:	fffff097          	auipc	ra,0xfffff
    8000332a:	4a0080e7          	jalr	1184(ra) # 800027c6 <bread>
    8000332e:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003330:	3ff4f713          	and	a4,s1,1023
    80003334:	40ec87bb          	subw	a5,s9,a4
    80003338:	413a86bb          	subw	a3,s5,s3
    8000333c:	8d3e                	mv	s10,a5
    8000333e:	2781                	sext.w	a5,a5
    80003340:	0006861b          	sext.w	a2,a3
    80003344:	f8f679e3          	bgeu	a2,a5,800032d6 <readi+0x4c>
    80003348:	8d36                	mv	s10,a3
    8000334a:	b771                	j	800032d6 <readi+0x4c>
      brelse(bp);
    8000334c:	854a                	mv	a0,s2
    8000334e:	fffff097          	auipc	ra,0xfffff
    80003352:	5a8080e7          	jalr	1448(ra) # 800028f6 <brelse>
      tot = -1;
    80003356:	59fd                	li	s3,-1
  }
  return tot;
    80003358:	0009851b          	sext.w	a0,s3
}
    8000335c:	70a6                	ld	ra,104(sp)
    8000335e:	7406                	ld	s0,96(sp)
    80003360:	64e6                	ld	s1,88(sp)
    80003362:	6946                	ld	s2,80(sp)
    80003364:	69a6                	ld	s3,72(sp)
    80003366:	6a06                	ld	s4,64(sp)
    80003368:	7ae2                	ld	s5,56(sp)
    8000336a:	7b42                	ld	s6,48(sp)
    8000336c:	7ba2                	ld	s7,40(sp)
    8000336e:	7c02                	ld	s8,32(sp)
    80003370:	6ce2                	ld	s9,24(sp)
    80003372:	6d42                	ld	s10,16(sp)
    80003374:	6da2                	ld	s11,8(sp)
    80003376:	6165                	add	sp,sp,112
    80003378:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    8000337a:	89d6                	mv	s3,s5
    8000337c:	bff1                	j	80003358 <readi+0xce>
    return 0;
    8000337e:	4501                	li	a0,0
}
    80003380:	8082                	ret

0000000080003382 <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003382:	457c                	lw	a5,76(a0)
    80003384:	10d7e863          	bltu	a5,a3,80003494 <writei+0x112>
{
    80003388:	7159                	add	sp,sp,-112
    8000338a:	f486                	sd	ra,104(sp)
    8000338c:	f0a2                	sd	s0,96(sp)
    8000338e:	eca6                	sd	s1,88(sp)
    80003390:	e8ca                	sd	s2,80(sp)
    80003392:	e4ce                	sd	s3,72(sp)
    80003394:	e0d2                	sd	s4,64(sp)
    80003396:	fc56                	sd	s5,56(sp)
    80003398:	f85a                	sd	s6,48(sp)
    8000339a:	f45e                	sd	s7,40(sp)
    8000339c:	f062                	sd	s8,32(sp)
    8000339e:	ec66                	sd	s9,24(sp)
    800033a0:	e86a                	sd	s10,16(sp)
    800033a2:	e46e                	sd	s11,8(sp)
    800033a4:	1880                	add	s0,sp,112
    800033a6:	8aaa                	mv	s5,a0
    800033a8:	8bae                	mv	s7,a1
    800033aa:	8a32                	mv	s4,a2
    800033ac:	8936                	mv	s2,a3
    800033ae:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    800033b0:	00e687bb          	addw	a5,a3,a4
    800033b4:	0ed7e263          	bltu	a5,a3,80003498 <writei+0x116>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    800033b8:	00043737          	lui	a4,0x43
    800033bc:	0ef76063          	bltu	a4,a5,8000349c <writei+0x11a>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800033c0:	0c0b0863          	beqz	s6,80003490 <writei+0x10e>
    800033c4:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    800033c6:	40000c93          	li	s9,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    800033ca:	5c7d                	li	s8,-1
    800033cc:	a091                	j	80003410 <writei+0x8e>
    800033ce:	020d1d93          	sll	s11,s10,0x20
    800033d2:	020ddd93          	srl	s11,s11,0x20
    800033d6:	05848513          	add	a0,s1,88
    800033da:	86ee                	mv	a3,s11
    800033dc:	8652                	mv	a2,s4
    800033de:	85de                	mv	a1,s7
    800033e0:	953a                	add	a0,a0,a4
    800033e2:	fffff097          	auipc	ra,0xfffff
    800033e6:	816080e7          	jalr	-2026(ra) # 80001bf8 <either_copyin>
    800033ea:	07850263          	beq	a0,s8,8000344e <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    800033ee:	8526                	mv	a0,s1
    800033f0:	00000097          	auipc	ra,0x0
    800033f4:	75e080e7          	jalr	1886(ra) # 80003b4e <log_write>
    brelse(bp);
    800033f8:	8526                	mv	a0,s1
    800033fa:	fffff097          	auipc	ra,0xfffff
    800033fe:	4fc080e7          	jalr	1276(ra) # 800028f6 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003402:	013d09bb          	addw	s3,s10,s3
    80003406:	012d093b          	addw	s2,s10,s2
    8000340a:	9a6e                	add	s4,s4,s11
    8000340c:	0569f663          	bgeu	s3,s6,80003458 <writei+0xd6>
    uint addr = bmap(ip, off/BSIZE);
    80003410:	00a9559b          	srlw	a1,s2,0xa
    80003414:	8556                	mv	a0,s5
    80003416:	fffff097          	auipc	ra,0xfffff
    8000341a:	7a2080e7          	jalr	1954(ra) # 80002bb8 <bmap>
    8000341e:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    80003422:	c99d                	beqz	a1,80003458 <writei+0xd6>
    bp = bread(ip->dev, addr);
    80003424:	000aa503          	lw	a0,0(s5)
    80003428:	fffff097          	auipc	ra,0xfffff
    8000342c:	39e080e7          	jalr	926(ra) # 800027c6 <bread>
    80003430:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003432:	3ff97713          	and	a4,s2,1023
    80003436:	40ec87bb          	subw	a5,s9,a4
    8000343a:	413b06bb          	subw	a3,s6,s3
    8000343e:	8d3e                	mv	s10,a5
    80003440:	2781                	sext.w	a5,a5
    80003442:	0006861b          	sext.w	a2,a3
    80003446:	f8f674e3          	bgeu	a2,a5,800033ce <writei+0x4c>
    8000344a:	8d36                	mv	s10,a3
    8000344c:	b749                	j	800033ce <writei+0x4c>
      brelse(bp);
    8000344e:	8526                	mv	a0,s1
    80003450:	fffff097          	auipc	ra,0xfffff
    80003454:	4a6080e7          	jalr	1190(ra) # 800028f6 <brelse>
  }

  if(off > ip->size)
    80003458:	04caa783          	lw	a5,76(s5)
    8000345c:	0127f463          	bgeu	a5,s2,80003464 <writei+0xe2>
    ip->size = off;
    80003460:	052aa623          	sw	s2,76(s5)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80003464:	8556                	mv	a0,s5
    80003466:	00000097          	auipc	ra,0x0
    8000346a:	aa4080e7          	jalr	-1372(ra) # 80002f0a <iupdate>

  return tot;
    8000346e:	0009851b          	sext.w	a0,s3
}
    80003472:	70a6                	ld	ra,104(sp)
    80003474:	7406                	ld	s0,96(sp)
    80003476:	64e6                	ld	s1,88(sp)
    80003478:	6946                	ld	s2,80(sp)
    8000347a:	69a6                	ld	s3,72(sp)
    8000347c:	6a06                	ld	s4,64(sp)
    8000347e:	7ae2                	ld	s5,56(sp)
    80003480:	7b42                	ld	s6,48(sp)
    80003482:	7ba2                	ld	s7,40(sp)
    80003484:	7c02                	ld	s8,32(sp)
    80003486:	6ce2                	ld	s9,24(sp)
    80003488:	6d42                	ld	s10,16(sp)
    8000348a:	6da2                	ld	s11,8(sp)
    8000348c:	6165                	add	sp,sp,112
    8000348e:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003490:	89da                	mv	s3,s6
    80003492:	bfc9                	j	80003464 <writei+0xe2>
    return -1;
    80003494:	557d                	li	a0,-1
}
    80003496:	8082                	ret
    return -1;
    80003498:	557d                	li	a0,-1
    8000349a:	bfe1                	j	80003472 <writei+0xf0>
    return -1;
    8000349c:	557d                	li	a0,-1
    8000349e:	bfd1                	j	80003472 <writei+0xf0>

00000000800034a0 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    800034a0:	1141                	add	sp,sp,-16
    800034a2:	e406                	sd	ra,8(sp)
    800034a4:	e022                	sd	s0,0(sp)
    800034a6:	0800                	add	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    800034a8:	4639                	li	a2,14
    800034aa:	ffffd097          	auipc	ra,0xffffd
    800034ae:	dea080e7          	jalr	-534(ra) # 80000294 <strncmp>
}
    800034b2:	60a2                	ld	ra,8(sp)
    800034b4:	6402                	ld	s0,0(sp)
    800034b6:	0141                	add	sp,sp,16
    800034b8:	8082                	ret

00000000800034ba <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    800034ba:	7139                	add	sp,sp,-64
    800034bc:	fc06                	sd	ra,56(sp)
    800034be:	f822                	sd	s0,48(sp)
    800034c0:	f426                	sd	s1,40(sp)
    800034c2:	f04a                	sd	s2,32(sp)
    800034c4:	ec4e                	sd	s3,24(sp)
    800034c6:	e852                	sd	s4,16(sp)
    800034c8:	0080                	add	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    800034ca:	04451703          	lh	a4,68(a0)
    800034ce:	4785                	li	a5,1
    800034d0:	00f71a63          	bne	a4,a5,800034e4 <dirlookup+0x2a>
    800034d4:	892a                	mv	s2,a0
    800034d6:	89ae                	mv	s3,a1
    800034d8:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    800034da:	457c                	lw	a5,76(a0)
    800034dc:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    800034de:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    800034e0:	e79d                	bnez	a5,8000350e <dirlookup+0x54>
    800034e2:	a8a5                	j	8000355a <dirlookup+0xa0>
    panic("dirlookup not DIR");
    800034e4:	00005517          	auipc	a0,0x5
    800034e8:	29c50513          	add	a0,a0,668 # 80008780 <syscallnames+0x1c0>
    800034ec:	00003097          	auipc	ra,0x3
    800034f0:	bf4080e7          	jalr	-1036(ra) # 800060e0 <panic>
      panic("dirlookup read");
    800034f4:	00005517          	auipc	a0,0x5
    800034f8:	2a450513          	add	a0,a0,676 # 80008798 <syscallnames+0x1d8>
    800034fc:	00003097          	auipc	ra,0x3
    80003500:	be4080e7          	jalr	-1052(ra) # 800060e0 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003504:	24c1                	addw	s1,s1,16
    80003506:	04c92783          	lw	a5,76(s2)
    8000350a:	04f4f763          	bgeu	s1,a5,80003558 <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000350e:	4741                	li	a4,16
    80003510:	86a6                	mv	a3,s1
    80003512:	fc040613          	add	a2,s0,-64
    80003516:	4581                	li	a1,0
    80003518:	854a                	mv	a0,s2
    8000351a:	00000097          	auipc	ra,0x0
    8000351e:	d70080e7          	jalr	-656(ra) # 8000328a <readi>
    80003522:	47c1                	li	a5,16
    80003524:	fcf518e3          	bne	a0,a5,800034f4 <dirlookup+0x3a>
    if(de.inum == 0)
    80003528:	fc045783          	lhu	a5,-64(s0)
    8000352c:	dfe1                	beqz	a5,80003504 <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    8000352e:	fc240593          	add	a1,s0,-62
    80003532:	854e                	mv	a0,s3
    80003534:	00000097          	auipc	ra,0x0
    80003538:	f6c080e7          	jalr	-148(ra) # 800034a0 <namecmp>
    8000353c:	f561                	bnez	a0,80003504 <dirlookup+0x4a>
      if(poff)
    8000353e:	000a0463          	beqz	s4,80003546 <dirlookup+0x8c>
        *poff = off;
    80003542:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    80003546:	fc045583          	lhu	a1,-64(s0)
    8000354a:	00092503          	lw	a0,0(s2)
    8000354e:	fffff097          	auipc	ra,0xfffff
    80003552:	754080e7          	jalr	1876(ra) # 80002ca2 <iget>
    80003556:	a011                	j	8000355a <dirlookup+0xa0>
  return 0;
    80003558:	4501                	li	a0,0
}
    8000355a:	70e2                	ld	ra,56(sp)
    8000355c:	7442                	ld	s0,48(sp)
    8000355e:	74a2                	ld	s1,40(sp)
    80003560:	7902                	ld	s2,32(sp)
    80003562:	69e2                	ld	s3,24(sp)
    80003564:	6a42                	ld	s4,16(sp)
    80003566:	6121                	add	sp,sp,64
    80003568:	8082                	ret

000000008000356a <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    8000356a:	711d                	add	sp,sp,-96
    8000356c:	ec86                	sd	ra,88(sp)
    8000356e:	e8a2                	sd	s0,80(sp)
    80003570:	e4a6                	sd	s1,72(sp)
    80003572:	e0ca                	sd	s2,64(sp)
    80003574:	fc4e                	sd	s3,56(sp)
    80003576:	f852                	sd	s4,48(sp)
    80003578:	f456                	sd	s5,40(sp)
    8000357a:	f05a                	sd	s6,32(sp)
    8000357c:	ec5e                	sd	s7,24(sp)
    8000357e:	e862                	sd	s8,16(sp)
    80003580:	e466                	sd	s9,8(sp)
    80003582:	1080                	add	s0,sp,96
    80003584:	84aa                	mv	s1,a0
    80003586:	8b2e                	mv	s6,a1
    80003588:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    8000358a:	00054703          	lbu	a4,0(a0)
    8000358e:	02f00793          	li	a5,47
    80003592:	02f70263          	beq	a4,a5,800035b6 <namex+0x4c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80003596:	ffffe097          	auipc	ra,0xffffe
    8000359a:	a34080e7          	jalr	-1484(ra) # 80000fca <myproc>
    8000359e:	15853503          	ld	a0,344(a0)
    800035a2:	00000097          	auipc	ra,0x0
    800035a6:	9f6080e7          	jalr	-1546(ra) # 80002f98 <idup>
    800035aa:	8a2a                	mv	s4,a0
  while(*path == '/')
    800035ac:	02f00913          	li	s2,47
  if(len >= DIRSIZ)
    800035b0:	4c35                	li	s8,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    800035b2:	4b85                	li	s7,1
    800035b4:	a875                	j	80003670 <namex+0x106>
    ip = iget(ROOTDEV, ROOTINO);
    800035b6:	4585                	li	a1,1
    800035b8:	4505                	li	a0,1
    800035ba:	fffff097          	auipc	ra,0xfffff
    800035be:	6e8080e7          	jalr	1768(ra) # 80002ca2 <iget>
    800035c2:	8a2a                	mv	s4,a0
    800035c4:	b7e5                	j	800035ac <namex+0x42>
      iunlockput(ip);
    800035c6:	8552                	mv	a0,s4
    800035c8:	00000097          	auipc	ra,0x0
    800035cc:	c70080e7          	jalr	-912(ra) # 80003238 <iunlockput>
      return 0;
    800035d0:	4a01                	li	s4,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    800035d2:	8552                	mv	a0,s4
    800035d4:	60e6                	ld	ra,88(sp)
    800035d6:	6446                	ld	s0,80(sp)
    800035d8:	64a6                	ld	s1,72(sp)
    800035da:	6906                	ld	s2,64(sp)
    800035dc:	79e2                	ld	s3,56(sp)
    800035de:	7a42                	ld	s4,48(sp)
    800035e0:	7aa2                	ld	s5,40(sp)
    800035e2:	7b02                	ld	s6,32(sp)
    800035e4:	6be2                	ld	s7,24(sp)
    800035e6:	6c42                	ld	s8,16(sp)
    800035e8:	6ca2                	ld	s9,8(sp)
    800035ea:	6125                	add	sp,sp,96
    800035ec:	8082                	ret
      iunlock(ip);
    800035ee:	8552                	mv	a0,s4
    800035f0:	00000097          	auipc	ra,0x0
    800035f4:	aa8080e7          	jalr	-1368(ra) # 80003098 <iunlock>
      return ip;
    800035f8:	bfe9                	j	800035d2 <namex+0x68>
      iunlockput(ip);
    800035fa:	8552                	mv	a0,s4
    800035fc:	00000097          	auipc	ra,0x0
    80003600:	c3c080e7          	jalr	-964(ra) # 80003238 <iunlockput>
      return 0;
    80003604:	8a4e                	mv	s4,s3
    80003606:	b7f1                	j	800035d2 <namex+0x68>
  len = path - s;
    80003608:	40998633          	sub	a2,s3,s1
    8000360c:	00060c9b          	sext.w	s9,a2
  if(len >= DIRSIZ)
    80003610:	099c5863          	bge	s8,s9,800036a0 <namex+0x136>
    memmove(name, s, DIRSIZ);
    80003614:	4639                	li	a2,14
    80003616:	85a6                	mv	a1,s1
    80003618:	8556                	mv	a0,s5
    8000361a:	ffffd097          	auipc	ra,0xffffd
    8000361e:	c06080e7          	jalr	-1018(ra) # 80000220 <memmove>
    80003622:	84ce                	mv	s1,s3
  while(*path == '/')
    80003624:	0004c783          	lbu	a5,0(s1)
    80003628:	01279763          	bne	a5,s2,80003636 <namex+0xcc>
    path++;
    8000362c:	0485                	add	s1,s1,1
  while(*path == '/')
    8000362e:	0004c783          	lbu	a5,0(s1)
    80003632:	ff278de3          	beq	a5,s2,8000362c <namex+0xc2>
    ilock(ip);
    80003636:	8552                	mv	a0,s4
    80003638:	00000097          	auipc	ra,0x0
    8000363c:	99e080e7          	jalr	-1634(ra) # 80002fd6 <ilock>
    if(ip->type != T_DIR){
    80003640:	044a1783          	lh	a5,68(s4)
    80003644:	f97791e3          	bne	a5,s7,800035c6 <namex+0x5c>
    if(nameiparent && *path == '\0'){
    80003648:	000b0563          	beqz	s6,80003652 <namex+0xe8>
    8000364c:	0004c783          	lbu	a5,0(s1)
    80003650:	dfd9                	beqz	a5,800035ee <namex+0x84>
    if((next = dirlookup(ip, name, 0)) == 0){
    80003652:	4601                	li	a2,0
    80003654:	85d6                	mv	a1,s5
    80003656:	8552                	mv	a0,s4
    80003658:	00000097          	auipc	ra,0x0
    8000365c:	e62080e7          	jalr	-414(ra) # 800034ba <dirlookup>
    80003660:	89aa                	mv	s3,a0
    80003662:	dd41                	beqz	a0,800035fa <namex+0x90>
    iunlockput(ip);
    80003664:	8552                	mv	a0,s4
    80003666:	00000097          	auipc	ra,0x0
    8000366a:	bd2080e7          	jalr	-1070(ra) # 80003238 <iunlockput>
    ip = next;
    8000366e:	8a4e                	mv	s4,s3
  while(*path == '/')
    80003670:	0004c783          	lbu	a5,0(s1)
    80003674:	01279763          	bne	a5,s2,80003682 <namex+0x118>
    path++;
    80003678:	0485                	add	s1,s1,1
  while(*path == '/')
    8000367a:	0004c783          	lbu	a5,0(s1)
    8000367e:	ff278de3          	beq	a5,s2,80003678 <namex+0x10e>
  if(*path == 0)
    80003682:	cb9d                	beqz	a5,800036b8 <namex+0x14e>
  while(*path != '/' && *path != 0)
    80003684:	0004c783          	lbu	a5,0(s1)
    80003688:	89a6                	mv	s3,s1
  len = path - s;
    8000368a:	4c81                	li	s9,0
    8000368c:	4601                	li	a2,0
  while(*path != '/' && *path != 0)
    8000368e:	01278963          	beq	a5,s2,800036a0 <namex+0x136>
    80003692:	dbbd                	beqz	a5,80003608 <namex+0x9e>
    path++;
    80003694:	0985                	add	s3,s3,1
  while(*path != '/' && *path != 0)
    80003696:	0009c783          	lbu	a5,0(s3)
    8000369a:	ff279ce3          	bne	a5,s2,80003692 <namex+0x128>
    8000369e:	b7ad                	j	80003608 <namex+0x9e>
    memmove(name, s, len);
    800036a0:	2601                	sext.w	a2,a2
    800036a2:	85a6                	mv	a1,s1
    800036a4:	8556                	mv	a0,s5
    800036a6:	ffffd097          	auipc	ra,0xffffd
    800036aa:	b7a080e7          	jalr	-1158(ra) # 80000220 <memmove>
    name[len] = 0;
    800036ae:	9cd6                	add	s9,s9,s5
    800036b0:	000c8023          	sb	zero,0(s9) # 2000 <_entry-0x7fffe000>
    800036b4:	84ce                	mv	s1,s3
    800036b6:	b7bd                	j	80003624 <namex+0xba>
  if(nameiparent){
    800036b8:	f00b0de3          	beqz	s6,800035d2 <namex+0x68>
    iput(ip);
    800036bc:	8552                	mv	a0,s4
    800036be:	00000097          	auipc	ra,0x0
    800036c2:	ad2080e7          	jalr	-1326(ra) # 80003190 <iput>
    return 0;
    800036c6:	4a01                	li	s4,0
    800036c8:	b729                	j	800035d2 <namex+0x68>

00000000800036ca <dirlink>:
{
    800036ca:	7139                	add	sp,sp,-64
    800036cc:	fc06                	sd	ra,56(sp)
    800036ce:	f822                	sd	s0,48(sp)
    800036d0:	f426                	sd	s1,40(sp)
    800036d2:	f04a                	sd	s2,32(sp)
    800036d4:	ec4e                	sd	s3,24(sp)
    800036d6:	e852                	sd	s4,16(sp)
    800036d8:	0080                	add	s0,sp,64
    800036da:	892a                	mv	s2,a0
    800036dc:	8a2e                	mv	s4,a1
    800036de:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    800036e0:	4601                	li	a2,0
    800036e2:	00000097          	auipc	ra,0x0
    800036e6:	dd8080e7          	jalr	-552(ra) # 800034ba <dirlookup>
    800036ea:	e93d                	bnez	a0,80003760 <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800036ec:	04c92483          	lw	s1,76(s2)
    800036f0:	c49d                	beqz	s1,8000371e <dirlink+0x54>
    800036f2:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800036f4:	4741                	li	a4,16
    800036f6:	86a6                	mv	a3,s1
    800036f8:	fc040613          	add	a2,s0,-64
    800036fc:	4581                	li	a1,0
    800036fe:	854a                	mv	a0,s2
    80003700:	00000097          	auipc	ra,0x0
    80003704:	b8a080e7          	jalr	-1142(ra) # 8000328a <readi>
    80003708:	47c1                	li	a5,16
    8000370a:	06f51163          	bne	a0,a5,8000376c <dirlink+0xa2>
    if(de.inum == 0)
    8000370e:	fc045783          	lhu	a5,-64(s0)
    80003712:	c791                	beqz	a5,8000371e <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003714:	24c1                	addw	s1,s1,16
    80003716:	04c92783          	lw	a5,76(s2)
    8000371a:	fcf4ede3          	bltu	s1,a5,800036f4 <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    8000371e:	4639                	li	a2,14
    80003720:	85d2                	mv	a1,s4
    80003722:	fc240513          	add	a0,s0,-62
    80003726:	ffffd097          	auipc	ra,0xffffd
    8000372a:	baa080e7          	jalr	-1110(ra) # 800002d0 <strncpy>
  de.inum = inum;
    8000372e:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003732:	4741                	li	a4,16
    80003734:	86a6                	mv	a3,s1
    80003736:	fc040613          	add	a2,s0,-64
    8000373a:	4581                	li	a1,0
    8000373c:	854a                	mv	a0,s2
    8000373e:	00000097          	auipc	ra,0x0
    80003742:	c44080e7          	jalr	-956(ra) # 80003382 <writei>
    80003746:	1541                	add	a0,a0,-16
    80003748:	00a03533          	snez	a0,a0
    8000374c:	40a00533          	neg	a0,a0
}
    80003750:	70e2                	ld	ra,56(sp)
    80003752:	7442                	ld	s0,48(sp)
    80003754:	74a2                	ld	s1,40(sp)
    80003756:	7902                	ld	s2,32(sp)
    80003758:	69e2                	ld	s3,24(sp)
    8000375a:	6a42                	ld	s4,16(sp)
    8000375c:	6121                	add	sp,sp,64
    8000375e:	8082                	ret
    iput(ip);
    80003760:	00000097          	auipc	ra,0x0
    80003764:	a30080e7          	jalr	-1488(ra) # 80003190 <iput>
    return -1;
    80003768:	557d                	li	a0,-1
    8000376a:	b7dd                	j	80003750 <dirlink+0x86>
      panic("dirlink read");
    8000376c:	00005517          	auipc	a0,0x5
    80003770:	03c50513          	add	a0,a0,60 # 800087a8 <syscallnames+0x1e8>
    80003774:	00003097          	auipc	ra,0x3
    80003778:	96c080e7          	jalr	-1684(ra) # 800060e0 <panic>

000000008000377c <namei>:

struct inode*
namei(char *path)
{
    8000377c:	1101                	add	sp,sp,-32
    8000377e:	ec06                	sd	ra,24(sp)
    80003780:	e822                	sd	s0,16(sp)
    80003782:	1000                	add	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80003784:	fe040613          	add	a2,s0,-32
    80003788:	4581                	li	a1,0
    8000378a:	00000097          	auipc	ra,0x0
    8000378e:	de0080e7          	jalr	-544(ra) # 8000356a <namex>
}
    80003792:	60e2                	ld	ra,24(sp)
    80003794:	6442                	ld	s0,16(sp)
    80003796:	6105                	add	sp,sp,32
    80003798:	8082                	ret

000000008000379a <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    8000379a:	1141                	add	sp,sp,-16
    8000379c:	e406                	sd	ra,8(sp)
    8000379e:	e022                	sd	s0,0(sp)
    800037a0:	0800                	add	s0,sp,16
    800037a2:	862e                	mv	a2,a1
  return namex(path, 1, name);
    800037a4:	4585                	li	a1,1
    800037a6:	00000097          	auipc	ra,0x0
    800037aa:	dc4080e7          	jalr	-572(ra) # 8000356a <namex>
}
    800037ae:	60a2                	ld	ra,8(sp)
    800037b0:	6402                	ld	s0,0(sp)
    800037b2:	0141                	add	sp,sp,16
    800037b4:	8082                	ret

00000000800037b6 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    800037b6:	1101                	add	sp,sp,-32
    800037b8:	ec06                	sd	ra,24(sp)
    800037ba:	e822                	sd	s0,16(sp)
    800037bc:	e426                	sd	s1,8(sp)
    800037be:	e04a                	sd	s2,0(sp)
    800037c0:	1000                	add	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    800037c2:	00015917          	auipc	s2,0x15
    800037c6:	71690913          	add	s2,s2,1814 # 80018ed8 <log>
    800037ca:	01892583          	lw	a1,24(s2)
    800037ce:	02892503          	lw	a0,40(s2)
    800037d2:	fffff097          	auipc	ra,0xfffff
    800037d6:	ff4080e7          	jalr	-12(ra) # 800027c6 <bread>
    800037da:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    800037dc:	02c92603          	lw	a2,44(s2)
    800037e0:	cd30                	sw	a2,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    800037e2:	00c05f63          	blez	a2,80003800 <write_head+0x4a>
    800037e6:	00015717          	auipc	a4,0x15
    800037ea:	72270713          	add	a4,a4,1826 # 80018f08 <log+0x30>
    800037ee:	87aa                	mv	a5,a0
    800037f0:	060a                	sll	a2,a2,0x2
    800037f2:	962a                	add	a2,a2,a0
    hb->block[i] = log.lh.block[i];
    800037f4:	4314                	lw	a3,0(a4)
    800037f6:	cff4                	sw	a3,92(a5)
  for (i = 0; i < log.lh.n; i++) {
    800037f8:	0711                	add	a4,a4,4
    800037fa:	0791                	add	a5,a5,4
    800037fc:	fec79ce3          	bne	a5,a2,800037f4 <write_head+0x3e>
  }
  bwrite(buf);
    80003800:	8526                	mv	a0,s1
    80003802:	fffff097          	auipc	ra,0xfffff
    80003806:	0b6080e7          	jalr	182(ra) # 800028b8 <bwrite>
  brelse(buf);
    8000380a:	8526                	mv	a0,s1
    8000380c:	fffff097          	auipc	ra,0xfffff
    80003810:	0ea080e7          	jalr	234(ra) # 800028f6 <brelse>
}
    80003814:	60e2                	ld	ra,24(sp)
    80003816:	6442                	ld	s0,16(sp)
    80003818:	64a2                	ld	s1,8(sp)
    8000381a:	6902                	ld	s2,0(sp)
    8000381c:	6105                	add	sp,sp,32
    8000381e:	8082                	ret

0000000080003820 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    80003820:	00015797          	auipc	a5,0x15
    80003824:	6e47a783          	lw	a5,1764(a5) # 80018f04 <log+0x2c>
    80003828:	0af05d63          	blez	a5,800038e2 <install_trans+0xc2>
{
    8000382c:	7139                	add	sp,sp,-64
    8000382e:	fc06                	sd	ra,56(sp)
    80003830:	f822                	sd	s0,48(sp)
    80003832:	f426                	sd	s1,40(sp)
    80003834:	f04a                	sd	s2,32(sp)
    80003836:	ec4e                	sd	s3,24(sp)
    80003838:	e852                	sd	s4,16(sp)
    8000383a:	e456                	sd	s5,8(sp)
    8000383c:	e05a                	sd	s6,0(sp)
    8000383e:	0080                	add	s0,sp,64
    80003840:	8b2a                	mv	s6,a0
    80003842:	00015a97          	auipc	s5,0x15
    80003846:	6c6a8a93          	add	s5,s5,1734 # 80018f08 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000384a:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    8000384c:	00015997          	auipc	s3,0x15
    80003850:	68c98993          	add	s3,s3,1676 # 80018ed8 <log>
    80003854:	a00d                	j	80003876 <install_trans+0x56>
    brelse(lbuf);
    80003856:	854a                	mv	a0,s2
    80003858:	fffff097          	auipc	ra,0xfffff
    8000385c:	09e080e7          	jalr	158(ra) # 800028f6 <brelse>
    brelse(dbuf);
    80003860:	8526                	mv	a0,s1
    80003862:	fffff097          	auipc	ra,0xfffff
    80003866:	094080e7          	jalr	148(ra) # 800028f6 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000386a:	2a05                	addw	s4,s4,1
    8000386c:	0a91                	add	s5,s5,4
    8000386e:	02c9a783          	lw	a5,44(s3)
    80003872:	04fa5e63          	bge	s4,a5,800038ce <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003876:	0189a583          	lw	a1,24(s3)
    8000387a:	014585bb          	addw	a1,a1,s4
    8000387e:	2585                	addw	a1,a1,1
    80003880:	0289a503          	lw	a0,40(s3)
    80003884:	fffff097          	auipc	ra,0xfffff
    80003888:	f42080e7          	jalr	-190(ra) # 800027c6 <bread>
    8000388c:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    8000388e:	000aa583          	lw	a1,0(s5)
    80003892:	0289a503          	lw	a0,40(s3)
    80003896:	fffff097          	auipc	ra,0xfffff
    8000389a:	f30080e7          	jalr	-208(ra) # 800027c6 <bread>
    8000389e:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    800038a0:	40000613          	li	a2,1024
    800038a4:	05890593          	add	a1,s2,88
    800038a8:	05850513          	add	a0,a0,88
    800038ac:	ffffd097          	auipc	ra,0xffffd
    800038b0:	974080e7          	jalr	-1676(ra) # 80000220 <memmove>
    bwrite(dbuf);  // write dst to disk
    800038b4:	8526                	mv	a0,s1
    800038b6:	fffff097          	auipc	ra,0xfffff
    800038ba:	002080e7          	jalr	2(ra) # 800028b8 <bwrite>
    if(recovering == 0)
    800038be:	f80b1ce3          	bnez	s6,80003856 <install_trans+0x36>
      bunpin(dbuf);
    800038c2:	8526                	mv	a0,s1
    800038c4:	fffff097          	auipc	ra,0xfffff
    800038c8:	10a080e7          	jalr	266(ra) # 800029ce <bunpin>
    800038cc:	b769                	j	80003856 <install_trans+0x36>
}
    800038ce:	70e2                	ld	ra,56(sp)
    800038d0:	7442                	ld	s0,48(sp)
    800038d2:	74a2                	ld	s1,40(sp)
    800038d4:	7902                	ld	s2,32(sp)
    800038d6:	69e2                	ld	s3,24(sp)
    800038d8:	6a42                	ld	s4,16(sp)
    800038da:	6aa2                	ld	s5,8(sp)
    800038dc:	6b02                	ld	s6,0(sp)
    800038de:	6121                	add	sp,sp,64
    800038e0:	8082                	ret
    800038e2:	8082                	ret

00000000800038e4 <initlog>:
{
    800038e4:	7179                	add	sp,sp,-48
    800038e6:	f406                	sd	ra,40(sp)
    800038e8:	f022                	sd	s0,32(sp)
    800038ea:	ec26                	sd	s1,24(sp)
    800038ec:	e84a                	sd	s2,16(sp)
    800038ee:	e44e                	sd	s3,8(sp)
    800038f0:	1800                	add	s0,sp,48
    800038f2:	892a                	mv	s2,a0
    800038f4:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    800038f6:	00015497          	auipc	s1,0x15
    800038fa:	5e248493          	add	s1,s1,1506 # 80018ed8 <log>
    800038fe:	00005597          	auipc	a1,0x5
    80003902:	eba58593          	add	a1,a1,-326 # 800087b8 <syscallnames+0x1f8>
    80003906:	8526                	mv	a0,s1
    80003908:	00003097          	auipc	ra,0x3
    8000390c:	c80080e7          	jalr	-896(ra) # 80006588 <initlock>
  log.start = sb->logstart;
    80003910:	0149a583          	lw	a1,20(s3)
    80003914:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    80003916:	0109a783          	lw	a5,16(s3)
    8000391a:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    8000391c:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    80003920:	854a                	mv	a0,s2
    80003922:	fffff097          	auipc	ra,0xfffff
    80003926:	ea4080e7          	jalr	-348(ra) # 800027c6 <bread>
  log.lh.n = lh->n;
    8000392a:	4d30                	lw	a2,88(a0)
    8000392c:	d4d0                	sw	a2,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    8000392e:	00c05f63          	blez	a2,8000394c <initlog+0x68>
    80003932:	87aa                	mv	a5,a0
    80003934:	00015717          	auipc	a4,0x15
    80003938:	5d470713          	add	a4,a4,1492 # 80018f08 <log+0x30>
    8000393c:	060a                	sll	a2,a2,0x2
    8000393e:	962a                	add	a2,a2,a0
    log.lh.block[i] = lh->block[i];
    80003940:	4ff4                	lw	a3,92(a5)
    80003942:	c314                	sw	a3,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80003944:	0791                	add	a5,a5,4
    80003946:	0711                	add	a4,a4,4
    80003948:	fec79ce3          	bne	a5,a2,80003940 <initlog+0x5c>
  brelse(buf);
    8000394c:	fffff097          	auipc	ra,0xfffff
    80003950:	faa080e7          	jalr	-86(ra) # 800028f6 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    80003954:	4505                	li	a0,1
    80003956:	00000097          	auipc	ra,0x0
    8000395a:	eca080e7          	jalr	-310(ra) # 80003820 <install_trans>
  log.lh.n = 0;
    8000395e:	00015797          	auipc	a5,0x15
    80003962:	5a07a323          	sw	zero,1446(a5) # 80018f04 <log+0x2c>
  write_head(); // clear the log
    80003966:	00000097          	auipc	ra,0x0
    8000396a:	e50080e7          	jalr	-432(ra) # 800037b6 <write_head>
}
    8000396e:	70a2                	ld	ra,40(sp)
    80003970:	7402                	ld	s0,32(sp)
    80003972:	64e2                	ld	s1,24(sp)
    80003974:	6942                	ld	s2,16(sp)
    80003976:	69a2                	ld	s3,8(sp)
    80003978:	6145                	add	sp,sp,48
    8000397a:	8082                	ret

000000008000397c <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    8000397c:	1101                	add	sp,sp,-32
    8000397e:	ec06                	sd	ra,24(sp)
    80003980:	e822                	sd	s0,16(sp)
    80003982:	e426                	sd	s1,8(sp)
    80003984:	e04a                	sd	s2,0(sp)
    80003986:	1000                	add	s0,sp,32
  acquire(&log.lock);
    80003988:	00015517          	auipc	a0,0x15
    8000398c:	55050513          	add	a0,a0,1360 # 80018ed8 <log>
    80003990:	00003097          	auipc	ra,0x3
    80003994:	c88080e7          	jalr	-888(ra) # 80006618 <acquire>
  while(1){
    if(log.committing){
    80003998:	00015497          	auipc	s1,0x15
    8000399c:	54048493          	add	s1,s1,1344 # 80018ed8 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    800039a0:	4979                	li	s2,30
    800039a2:	a039                	j	800039b0 <begin_op+0x34>
      sleep(&log, &log.lock);
    800039a4:	85a6                	mv	a1,s1
    800039a6:	8526                	mv	a0,s1
    800039a8:	ffffe097          	auipc	ra,0xffffe
    800039ac:	df2080e7          	jalr	-526(ra) # 8000179a <sleep>
    if(log.committing){
    800039b0:	50dc                	lw	a5,36(s1)
    800039b2:	fbed                	bnez	a5,800039a4 <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    800039b4:	5098                	lw	a4,32(s1)
    800039b6:	2705                	addw	a4,a4,1
    800039b8:	0027179b          	sllw	a5,a4,0x2
    800039bc:	9fb9                	addw	a5,a5,a4
    800039be:	0017979b          	sllw	a5,a5,0x1
    800039c2:	54d4                	lw	a3,44(s1)
    800039c4:	9fb5                	addw	a5,a5,a3
    800039c6:	00f95963          	bge	s2,a5,800039d8 <begin_op+0x5c>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    800039ca:	85a6                	mv	a1,s1
    800039cc:	8526                	mv	a0,s1
    800039ce:	ffffe097          	auipc	ra,0xffffe
    800039d2:	dcc080e7          	jalr	-564(ra) # 8000179a <sleep>
    800039d6:	bfe9                	j	800039b0 <begin_op+0x34>
    } else {
      log.outstanding += 1;
    800039d8:	00015517          	auipc	a0,0x15
    800039dc:	50050513          	add	a0,a0,1280 # 80018ed8 <log>
    800039e0:	d118                	sw	a4,32(a0)
      release(&log.lock);
    800039e2:	00003097          	auipc	ra,0x3
    800039e6:	cea080e7          	jalr	-790(ra) # 800066cc <release>
      break;
    }
  }
}
    800039ea:	60e2                	ld	ra,24(sp)
    800039ec:	6442                	ld	s0,16(sp)
    800039ee:	64a2                	ld	s1,8(sp)
    800039f0:	6902                	ld	s2,0(sp)
    800039f2:	6105                	add	sp,sp,32
    800039f4:	8082                	ret

00000000800039f6 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    800039f6:	7139                	add	sp,sp,-64
    800039f8:	fc06                	sd	ra,56(sp)
    800039fa:	f822                	sd	s0,48(sp)
    800039fc:	f426                	sd	s1,40(sp)
    800039fe:	f04a                	sd	s2,32(sp)
    80003a00:	ec4e                	sd	s3,24(sp)
    80003a02:	e852                	sd	s4,16(sp)
    80003a04:	e456                	sd	s5,8(sp)
    80003a06:	0080                	add	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80003a08:	00015497          	auipc	s1,0x15
    80003a0c:	4d048493          	add	s1,s1,1232 # 80018ed8 <log>
    80003a10:	8526                	mv	a0,s1
    80003a12:	00003097          	auipc	ra,0x3
    80003a16:	c06080e7          	jalr	-1018(ra) # 80006618 <acquire>
  log.outstanding -= 1;
    80003a1a:	509c                	lw	a5,32(s1)
    80003a1c:	37fd                	addw	a5,a5,-1
    80003a1e:	0007891b          	sext.w	s2,a5
    80003a22:	d09c                	sw	a5,32(s1)
  if(log.committing)
    80003a24:	50dc                	lw	a5,36(s1)
    80003a26:	e7b9                	bnez	a5,80003a74 <end_op+0x7e>
    panic("log.committing");
  if(log.outstanding == 0){
    80003a28:	04091e63          	bnez	s2,80003a84 <end_op+0x8e>
    do_commit = 1;
    log.committing = 1;
    80003a2c:	00015497          	auipc	s1,0x15
    80003a30:	4ac48493          	add	s1,s1,1196 # 80018ed8 <log>
    80003a34:	4785                	li	a5,1
    80003a36:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    80003a38:	8526                	mv	a0,s1
    80003a3a:	00003097          	auipc	ra,0x3
    80003a3e:	c92080e7          	jalr	-878(ra) # 800066cc <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    80003a42:	54dc                	lw	a5,44(s1)
    80003a44:	06f04763          	bgtz	a5,80003ab2 <end_op+0xbc>
    acquire(&log.lock);
    80003a48:	00015497          	auipc	s1,0x15
    80003a4c:	49048493          	add	s1,s1,1168 # 80018ed8 <log>
    80003a50:	8526                	mv	a0,s1
    80003a52:	00003097          	auipc	ra,0x3
    80003a56:	bc6080e7          	jalr	-1082(ra) # 80006618 <acquire>
    log.committing = 0;
    80003a5a:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    80003a5e:	8526                	mv	a0,s1
    80003a60:	ffffe097          	auipc	ra,0xffffe
    80003a64:	d9e080e7          	jalr	-610(ra) # 800017fe <wakeup>
    release(&log.lock);
    80003a68:	8526                	mv	a0,s1
    80003a6a:	00003097          	auipc	ra,0x3
    80003a6e:	c62080e7          	jalr	-926(ra) # 800066cc <release>
}
    80003a72:	a03d                	j	80003aa0 <end_op+0xaa>
    panic("log.committing");
    80003a74:	00005517          	auipc	a0,0x5
    80003a78:	d4c50513          	add	a0,a0,-692 # 800087c0 <syscallnames+0x200>
    80003a7c:	00002097          	auipc	ra,0x2
    80003a80:	664080e7          	jalr	1636(ra) # 800060e0 <panic>
    wakeup(&log);
    80003a84:	00015497          	auipc	s1,0x15
    80003a88:	45448493          	add	s1,s1,1108 # 80018ed8 <log>
    80003a8c:	8526                	mv	a0,s1
    80003a8e:	ffffe097          	auipc	ra,0xffffe
    80003a92:	d70080e7          	jalr	-656(ra) # 800017fe <wakeup>
  release(&log.lock);
    80003a96:	8526                	mv	a0,s1
    80003a98:	00003097          	auipc	ra,0x3
    80003a9c:	c34080e7          	jalr	-972(ra) # 800066cc <release>
}
    80003aa0:	70e2                	ld	ra,56(sp)
    80003aa2:	7442                	ld	s0,48(sp)
    80003aa4:	74a2                	ld	s1,40(sp)
    80003aa6:	7902                	ld	s2,32(sp)
    80003aa8:	69e2                	ld	s3,24(sp)
    80003aaa:	6a42                	ld	s4,16(sp)
    80003aac:	6aa2                	ld	s5,8(sp)
    80003aae:	6121                	add	sp,sp,64
    80003ab0:	8082                	ret
  for (tail = 0; tail < log.lh.n; tail++) {
    80003ab2:	00015a97          	auipc	s5,0x15
    80003ab6:	456a8a93          	add	s5,s5,1110 # 80018f08 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80003aba:	00015a17          	auipc	s4,0x15
    80003abe:	41ea0a13          	add	s4,s4,1054 # 80018ed8 <log>
    80003ac2:	018a2583          	lw	a1,24(s4)
    80003ac6:	012585bb          	addw	a1,a1,s2
    80003aca:	2585                	addw	a1,a1,1
    80003acc:	028a2503          	lw	a0,40(s4)
    80003ad0:	fffff097          	auipc	ra,0xfffff
    80003ad4:	cf6080e7          	jalr	-778(ra) # 800027c6 <bread>
    80003ad8:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80003ada:	000aa583          	lw	a1,0(s5)
    80003ade:	028a2503          	lw	a0,40(s4)
    80003ae2:	fffff097          	auipc	ra,0xfffff
    80003ae6:	ce4080e7          	jalr	-796(ra) # 800027c6 <bread>
    80003aea:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    80003aec:	40000613          	li	a2,1024
    80003af0:	05850593          	add	a1,a0,88
    80003af4:	05848513          	add	a0,s1,88
    80003af8:	ffffc097          	auipc	ra,0xffffc
    80003afc:	728080e7          	jalr	1832(ra) # 80000220 <memmove>
    bwrite(to);  // write the log
    80003b00:	8526                	mv	a0,s1
    80003b02:	fffff097          	auipc	ra,0xfffff
    80003b06:	db6080e7          	jalr	-586(ra) # 800028b8 <bwrite>
    brelse(from);
    80003b0a:	854e                	mv	a0,s3
    80003b0c:	fffff097          	auipc	ra,0xfffff
    80003b10:	dea080e7          	jalr	-534(ra) # 800028f6 <brelse>
    brelse(to);
    80003b14:	8526                	mv	a0,s1
    80003b16:	fffff097          	auipc	ra,0xfffff
    80003b1a:	de0080e7          	jalr	-544(ra) # 800028f6 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003b1e:	2905                	addw	s2,s2,1
    80003b20:	0a91                	add	s5,s5,4
    80003b22:	02ca2783          	lw	a5,44(s4)
    80003b26:	f8f94ee3          	blt	s2,a5,80003ac2 <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    80003b2a:	00000097          	auipc	ra,0x0
    80003b2e:	c8c080e7          	jalr	-884(ra) # 800037b6 <write_head>
    install_trans(0); // Now install writes to home locations
    80003b32:	4501                	li	a0,0
    80003b34:	00000097          	auipc	ra,0x0
    80003b38:	cec080e7          	jalr	-788(ra) # 80003820 <install_trans>
    log.lh.n = 0;
    80003b3c:	00015797          	auipc	a5,0x15
    80003b40:	3c07a423          	sw	zero,968(a5) # 80018f04 <log+0x2c>
    write_head();    // Erase the transaction from the log
    80003b44:	00000097          	auipc	ra,0x0
    80003b48:	c72080e7          	jalr	-910(ra) # 800037b6 <write_head>
    80003b4c:	bdf5                	j	80003a48 <end_op+0x52>

0000000080003b4e <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    80003b4e:	1101                	add	sp,sp,-32
    80003b50:	ec06                	sd	ra,24(sp)
    80003b52:	e822                	sd	s0,16(sp)
    80003b54:	e426                	sd	s1,8(sp)
    80003b56:	e04a                	sd	s2,0(sp)
    80003b58:	1000                	add	s0,sp,32
    80003b5a:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    80003b5c:	00015917          	auipc	s2,0x15
    80003b60:	37c90913          	add	s2,s2,892 # 80018ed8 <log>
    80003b64:	854a                	mv	a0,s2
    80003b66:	00003097          	auipc	ra,0x3
    80003b6a:	ab2080e7          	jalr	-1358(ra) # 80006618 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80003b6e:	02c92603          	lw	a2,44(s2)
    80003b72:	47f5                	li	a5,29
    80003b74:	06c7c563          	blt	a5,a2,80003bde <log_write+0x90>
    80003b78:	00015797          	auipc	a5,0x15
    80003b7c:	37c7a783          	lw	a5,892(a5) # 80018ef4 <log+0x1c>
    80003b80:	37fd                	addw	a5,a5,-1
    80003b82:	04f65e63          	bge	a2,a5,80003bde <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    80003b86:	00015797          	auipc	a5,0x15
    80003b8a:	3727a783          	lw	a5,882(a5) # 80018ef8 <log+0x20>
    80003b8e:	06f05063          	blez	a5,80003bee <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    80003b92:	4781                	li	a5,0
    80003b94:	06c05563          	blez	a2,80003bfe <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003b98:	44cc                	lw	a1,12(s1)
    80003b9a:	00015717          	auipc	a4,0x15
    80003b9e:	36e70713          	add	a4,a4,878 # 80018f08 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    80003ba2:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003ba4:	4314                	lw	a3,0(a4)
    80003ba6:	04b68c63          	beq	a3,a1,80003bfe <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    80003baa:	2785                	addw	a5,a5,1
    80003bac:	0711                	add	a4,a4,4
    80003bae:	fef61be3          	bne	a2,a5,80003ba4 <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    80003bb2:	0621                	add	a2,a2,8
    80003bb4:	060a                	sll	a2,a2,0x2
    80003bb6:	00015797          	auipc	a5,0x15
    80003bba:	32278793          	add	a5,a5,802 # 80018ed8 <log>
    80003bbe:	97b2                	add	a5,a5,a2
    80003bc0:	44d8                	lw	a4,12(s1)
    80003bc2:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    80003bc4:	8526                	mv	a0,s1
    80003bc6:	fffff097          	auipc	ra,0xfffff
    80003bca:	dcc080e7          	jalr	-564(ra) # 80002992 <bpin>
    log.lh.n++;
    80003bce:	00015717          	auipc	a4,0x15
    80003bd2:	30a70713          	add	a4,a4,778 # 80018ed8 <log>
    80003bd6:	575c                	lw	a5,44(a4)
    80003bd8:	2785                	addw	a5,a5,1
    80003bda:	d75c                	sw	a5,44(a4)
    80003bdc:	a82d                	j	80003c16 <log_write+0xc8>
    panic("too big a transaction");
    80003bde:	00005517          	auipc	a0,0x5
    80003be2:	bf250513          	add	a0,a0,-1038 # 800087d0 <syscallnames+0x210>
    80003be6:	00002097          	auipc	ra,0x2
    80003bea:	4fa080e7          	jalr	1274(ra) # 800060e0 <panic>
    panic("log_write outside of trans");
    80003bee:	00005517          	auipc	a0,0x5
    80003bf2:	bfa50513          	add	a0,a0,-1030 # 800087e8 <syscallnames+0x228>
    80003bf6:	00002097          	auipc	ra,0x2
    80003bfa:	4ea080e7          	jalr	1258(ra) # 800060e0 <panic>
  log.lh.block[i] = b->blockno;
    80003bfe:	00878693          	add	a3,a5,8
    80003c02:	068a                	sll	a3,a3,0x2
    80003c04:	00015717          	auipc	a4,0x15
    80003c08:	2d470713          	add	a4,a4,724 # 80018ed8 <log>
    80003c0c:	9736                	add	a4,a4,a3
    80003c0e:	44d4                	lw	a3,12(s1)
    80003c10:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    80003c12:	faf609e3          	beq	a2,a5,80003bc4 <log_write+0x76>
  }
  release(&log.lock);
    80003c16:	00015517          	auipc	a0,0x15
    80003c1a:	2c250513          	add	a0,a0,706 # 80018ed8 <log>
    80003c1e:	00003097          	auipc	ra,0x3
    80003c22:	aae080e7          	jalr	-1362(ra) # 800066cc <release>
}
    80003c26:	60e2                	ld	ra,24(sp)
    80003c28:	6442                	ld	s0,16(sp)
    80003c2a:	64a2                	ld	s1,8(sp)
    80003c2c:	6902                	ld	s2,0(sp)
    80003c2e:	6105                	add	sp,sp,32
    80003c30:	8082                	ret

0000000080003c32 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80003c32:	1101                	add	sp,sp,-32
    80003c34:	ec06                	sd	ra,24(sp)
    80003c36:	e822                	sd	s0,16(sp)
    80003c38:	e426                	sd	s1,8(sp)
    80003c3a:	e04a                	sd	s2,0(sp)
    80003c3c:	1000                	add	s0,sp,32
    80003c3e:	84aa                	mv	s1,a0
    80003c40:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80003c42:	00005597          	auipc	a1,0x5
    80003c46:	bc658593          	add	a1,a1,-1082 # 80008808 <syscallnames+0x248>
    80003c4a:	0521                	add	a0,a0,8
    80003c4c:	00003097          	auipc	ra,0x3
    80003c50:	93c080e7          	jalr	-1732(ra) # 80006588 <initlock>
  lk->name = name;
    80003c54:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    80003c58:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003c5c:	0204a423          	sw	zero,40(s1)
}
    80003c60:	60e2                	ld	ra,24(sp)
    80003c62:	6442                	ld	s0,16(sp)
    80003c64:	64a2                	ld	s1,8(sp)
    80003c66:	6902                	ld	s2,0(sp)
    80003c68:	6105                	add	sp,sp,32
    80003c6a:	8082                	ret

0000000080003c6c <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80003c6c:	1101                	add	sp,sp,-32
    80003c6e:	ec06                	sd	ra,24(sp)
    80003c70:	e822                	sd	s0,16(sp)
    80003c72:	e426                	sd	s1,8(sp)
    80003c74:	e04a                	sd	s2,0(sp)
    80003c76:	1000                	add	s0,sp,32
    80003c78:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003c7a:	00850913          	add	s2,a0,8
    80003c7e:	854a                	mv	a0,s2
    80003c80:	00003097          	auipc	ra,0x3
    80003c84:	998080e7          	jalr	-1640(ra) # 80006618 <acquire>
  while (lk->locked) {
    80003c88:	409c                	lw	a5,0(s1)
    80003c8a:	cb89                	beqz	a5,80003c9c <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    80003c8c:	85ca                	mv	a1,s2
    80003c8e:	8526                	mv	a0,s1
    80003c90:	ffffe097          	auipc	ra,0xffffe
    80003c94:	b0a080e7          	jalr	-1270(ra) # 8000179a <sleep>
  while (lk->locked) {
    80003c98:	409c                	lw	a5,0(s1)
    80003c9a:	fbed                	bnez	a5,80003c8c <acquiresleep+0x20>
  }
  lk->locked = 1;
    80003c9c:	4785                	li	a5,1
    80003c9e:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80003ca0:	ffffd097          	auipc	ra,0xffffd
    80003ca4:	32a080e7          	jalr	810(ra) # 80000fca <myproc>
    80003ca8:	591c                	lw	a5,48(a0)
    80003caa:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    80003cac:	854a                	mv	a0,s2
    80003cae:	00003097          	auipc	ra,0x3
    80003cb2:	a1e080e7          	jalr	-1506(ra) # 800066cc <release>
}
    80003cb6:	60e2                	ld	ra,24(sp)
    80003cb8:	6442                	ld	s0,16(sp)
    80003cba:	64a2                	ld	s1,8(sp)
    80003cbc:	6902                	ld	s2,0(sp)
    80003cbe:	6105                	add	sp,sp,32
    80003cc0:	8082                	ret

0000000080003cc2 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80003cc2:	1101                	add	sp,sp,-32
    80003cc4:	ec06                	sd	ra,24(sp)
    80003cc6:	e822                	sd	s0,16(sp)
    80003cc8:	e426                	sd	s1,8(sp)
    80003cca:	e04a                	sd	s2,0(sp)
    80003ccc:	1000                	add	s0,sp,32
    80003cce:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003cd0:	00850913          	add	s2,a0,8
    80003cd4:	854a                	mv	a0,s2
    80003cd6:	00003097          	auipc	ra,0x3
    80003cda:	942080e7          	jalr	-1726(ra) # 80006618 <acquire>
  lk->locked = 0;
    80003cde:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003ce2:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80003ce6:	8526                	mv	a0,s1
    80003ce8:	ffffe097          	auipc	ra,0xffffe
    80003cec:	b16080e7          	jalr	-1258(ra) # 800017fe <wakeup>
  release(&lk->lk);
    80003cf0:	854a                	mv	a0,s2
    80003cf2:	00003097          	auipc	ra,0x3
    80003cf6:	9da080e7          	jalr	-1574(ra) # 800066cc <release>
}
    80003cfa:	60e2                	ld	ra,24(sp)
    80003cfc:	6442                	ld	s0,16(sp)
    80003cfe:	64a2                	ld	s1,8(sp)
    80003d00:	6902                	ld	s2,0(sp)
    80003d02:	6105                	add	sp,sp,32
    80003d04:	8082                	ret

0000000080003d06 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80003d06:	7179                	add	sp,sp,-48
    80003d08:	f406                	sd	ra,40(sp)
    80003d0a:	f022                	sd	s0,32(sp)
    80003d0c:	ec26                	sd	s1,24(sp)
    80003d0e:	e84a                	sd	s2,16(sp)
    80003d10:	e44e                	sd	s3,8(sp)
    80003d12:	1800                	add	s0,sp,48
    80003d14:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80003d16:	00850913          	add	s2,a0,8
    80003d1a:	854a                	mv	a0,s2
    80003d1c:	00003097          	auipc	ra,0x3
    80003d20:	8fc080e7          	jalr	-1796(ra) # 80006618 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80003d24:	409c                	lw	a5,0(s1)
    80003d26:	ef99                	bnez	a5,80003d44 <holdingsleep+0x3e>
    80003d28:	4481                	li	s1,0
  release(&lk->lk);
    80003d2a:	854a                	mv	a0,s2
    80003d2c:	00003097          	auipc	ra,0x3
    80003d30:	9a0080e7          	jalr	-1632(ra) # 800066cc <release>
  return r;
}
    80003d34:	8526                	mv	a0,s1
    80003d36:	70a2                	ld	ra,40(sp)
    80003d38:	7402                	ld	s0,32(sp)
    80003d3a:	64e2                	ld	s1,24(sp)
    80003d3c:	6942                	ld	s2,16(sp)
    80003d3e:	69a2                	ld	s3,8(sp)
    80003d40:	6145                	add	sp,sp,48
    80003d42:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    80003d44:	0284a983          	lw	s3,40(s1)
    80003d48:	ffffd097          	auipc	ra,0xffffd
    80003d4c:	282080e7          	jalr	642(ra) # 80000fca <myproc>
    80003d50:	5904                	lw	s1,48(a0)
    80003d52:	413484b3          	sub	s1,s1,s3
    80003d56:	0014b493          	seqz	s1,s1
    80003d5a:	bfc1                	j	80003d2a <holdingsleep+0x24>

0000000080003d5c <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80003d5c:	1141                	add	sp,sp,-16
    80003d5e:	e406                	sd	ra,8(sp)
    80003d60:	e022                	sd	s0,0(sp)
    80003d62:	0800                	add	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003d64:	00005597          	auipc	a1,0x5
    80003d68:	ab458593          	add	a1,a1,-1356 # 80008818 <syscallnames+0x258>
    80003d6c:	00015517          	auipc	a0,0x15
    80003d70:	2b450513          	add	a0,a0,692 # 80019020 <ftable>
    80003d74:	00003097          	auipc	ra,0x3
    80003d78:	814080e7          	jalr	-2028(ra) # 80006588 <initlock>
}
    80003d7c:	60a2                	ld	ra,8(sp)
    80003d7e:	6402                	ld	s0,0(sp)
    80003d80:	0141                	add	sp,sp,16
    80003d82:	8082                	ret

0000000080003d84 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80003d84:	1101                	add	sp,sp,-32
    80003d86:	ec06                	sd	ra,24(sp)
    80003d88:	e822                	sd	s0,16(sp)
    80003d8a:	e426                	sd	s1,8(sp)
    80003d8c:	1000                	add	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80003d8e:	00015517          	auipc	a0,0x15
    80003d92:	29250513          	add	a0,a0,658 # 80019020 <ftable>
    80003d96:	00003097          	auipc	ra,0x3
    80003d9a:	882080e7          	jalr	-1918(ra) # 80006618 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003d9e:	00015497          	auipc	s1,0x15
    80003da2:	29a48493          	add	s1,s1,666 # 80019038 <ftable+0x18>
    80003da6:	00016717          	auipc	a4,0x16
    80003daa:	23270713          	add	a4,a4,562 # 80019fd8 <disk>
    if(f->ref == 0){
    80003dae:	40dc                	lw	a5,4(s1)
    80003db0:	cf99                	beqz	a5,80003dce <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003db2:	02848493          	add	s1,s1,40
    80003db6:	fee49ce3          	bne	s1,a4,80003dae <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80003dba:	00015517          	auipc	a0,0x15
    80003dbe:	26650513          	add	a0,a0,614 # 80019020 <ftable>
    80003dc2:	00003097          	auipc	ra,0x3
    80003dc6:	90a080e7          	jalr	-1782(ra) # 800066cc <release>
  return 0;
    80003dca:	4481                	li	s1,0
    80003dcc:	a819                	j	80003de2 <filealloc+0x5e>
      f->ref = 1;
    80003dce:	4785                	li	a5,1
    80003dd0:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80003dd2:	00015517          	auipc	a0,0x15
    80003dd6:	24e50513          	add	a0,a0,590 # 80019020 <ftable>
    80003dda:	00003097          	auipc	ra,0x3
    80003dde:	8f2080e7          	jalr	-1806(ra) # 800066cc <release>
}
    80003de2:	8526                	mv	a0,s1
    80003de4:	60e2                	ld	ra,24(sp)
    80003de6:	6442                	ld	s0,16(sp)
    80003de8:	64a2                	ld	s1,8(sp)
    80003dea:	6105                	add	sp,sp,32
    80003dec:	8082                	ret

0000000080003dee <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80003dee:	1101                	add	sp,sp,-32
    80003df0:	ec06                	sd	ra,24(sp)
    80003df2:	e822                	sd	s0,16(sp)
    80003df4:	e426                	sd	s1,8(sp)
    80003df6:	1000                	add	s0,sp,32
    80003df8:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80003dfa:	00015517          	auipc	a0,0x15
    80003dfe:	22650513          	add	a0,a0,550 # 80019020 <ftable>
    80003e02:	00003097          	auipc	ra,0x3
    80003e06:	816080e7          	jalr	-2026(ra) # 80006618 <acquire>
  if(f->ref < 1)
    80003e0a:	40dc                	lw	a5,4(s1)
    80003e0c:	02f05263          	blez	a5,80003e30 <filedup+0x42>
    panic("filedup");
  f->ref++;
    80003e10:	2785                	addw	a5,a5,1
    80003e12:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80003e14:	00015517          	auipc	a0,0x15
    80003e18:	20c50513          	add	a0,a0,524 # 80019020 <ftable>
    80003e1c:	00003097          	auipc	ra,0x3
    80003e20:	8b0080e7          	jalr	-1872(ra) # 800066cc <release>
  return f;
}
    80003e24:	8526                	mv	a0,s1
    80003e26:	60e2                	ld	ra,24(sp)
    80003e28:	6442                	ld	s0,16(sp)
    80003e2a:	64a2                	ld	s1,8(sp)
    80003e2c:	6105                	add	sp,sp,32
    80003e2e:	8082                	ret
    panic("filedup");
    80003e30:	00005517          	auipc	a0,0x5
    80003e34:	9f050513          	add	a0,a0,-1552 # 80008820 <syscallnames+0x260>
    80003e38:	00002097          	auipc	ra,0x2
    80003e3c:	2a8080e7          	jalr	680(ra) # 800060e0 <panic>

0000000080003e40 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80003e40:	7139                	add	sp,sp,-64
    80003e42:	fc06                	sd	ra,56(sp)
    80003e44:	f822                	sd	s0,48(sp)
    80003e46:	f426                	sd	s1,40(sp)
    80003e48:	f04a                	sd	s2,32(sp)
    80003e4a:	ec4e                	sd	s3,24(sp)
    80003e4c:	e852                	sd	s4,16(sp)
    80003e4e:	e456                	sd	s5,8(sp)
    80003e50:	0080                	add	s0,sp,64
    80003e52:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80003e54:	00015517          	auipc	a0,0x15
    80003e58:	1cc50513          	add	a0,a0,460 # 80019020 <ftable>
    80003e5c:	00002097          	auipc	ra,0x2
    80003e60:	7bc080e7          	jalr	1980(ra) # 80006618 <acquire>
  if(f->ref < 1)
    80003e64:	40dc                	lw	a5,4(s1)
    80003e66:	06f05163          	blez	a5,80003ec8 <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    80003e6a:	37fd                	addw	a5,a5,-1
    80003e6c:	0007871b          	sext.w	a4,a5
    80003e70:	c0dc                	sw	a5,4(s1)
    80003e72:	06e04363          	bgtz	a4,80003ed8 <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003e76:	0004a903          	lw	s2,0(s1)
    80003e7a:	0094ca83          	lbu	s5,9(s1)
    80003e7e:	0104ba03          	ld	s4,16(s1)
    80003e82:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80003e86:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80003e8a:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80003e8e:	00015517          	auipc	a0,0x15
    80003e92:	19250513          	add	a0,a0,402 # 80019020 <ftable>
    80003e96:	00003097          	auipc	ra,0x3
    80003e9a:	836080e7          	jalr	-1994(ra) # 800066cc <release>

  if(ff.type == FD_PIPE){
    80003e9e:	4785                	li	a5,1
    80003ea0:	04f90d63          	beq	s2,a5,80003efa <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003ea4:	3979                	addw	s2,s2,-2
    80003ea6:	4785                	li	a5,1
    80003ea8:	0527e063          	bltu	a5,s2,80003ee8 <fileclose+0xa8>
    begin_op();
    80003eac:	00000097          	auipc	ra,0x0
    80003eb0:	ad0080e7          	jalr	-1328(ra) # 8000397c <begin_op>
    iput(ff.ip);
    80003eb4:	854e                	mv	a0,s3
    80003eb6:	fffff097          	auipc	ra,0xfffff
    80003eba:	2da080e7          	jalr	730(ra) # 80003190 <iput>
    end_op();
    80003ebe:	00000097          	auipc	ra,0x0
    80003ec2:	b38080e7          	jalr	-1224(ra) # 800039f6 <end_op>
    80003ec6:	a00d                	j	80003ee8 <fileclose+0xa8>
    panic("fileclose");
    80003ec8:	00005517          	auipc	a0,0x5
    80003ecc:	96050513          	add	a0,a0,-1696 # 80008828 <syscallnames+0x268>
    80003ed0:	00002097          	auipc	ra,0x2
    80003ed4:	210080e7          	jalr	528(ra) # 800060e0 <panic>
    release(&ftable.lock);
    80003ed8:	00015517          	auipc	a0,0x15
    80003edc:	14850513          	add	a0,a0,328 # 80019020 <ftable>
    80003ee0:	00002097          	auipc	ra,0x2
    80003ee4:	7ec080e7          	jalr	2028(ra) # 800066cc <release>
  }
}
    80003ee8:	70e2                	ld	ra,56(sp)
    80003eea:	7442                	ld	s0,48(sp)
    80003eec:	74a2                	ld	s1,40(sp)
    80003eee:	7902                	ld	s2,32(sp)
    80003ef0:	69e2                	ld	s3,24(sp)
    80003ef2:	6a42                	ld	s4,16(sp)
    80003ef4:	6aa2                	ld	s5,8(sp)
    80003ef6:	6121                	add	sp,sp,64
    80003ef8:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80003efa:	85d6                	mv	a1,s5
    80003efc:	8552                	mv	a0,s4
    80003efe:	00000097          	auipc	ra,0x0
    80003f02:	348080e7          	jalr	840(ra) # 80004246 <pipeclose>
    80003f06:	b7cd                	j	80003ee8 <fileclose+0xa8>

0000000080003f08 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003f08:	715d                	add	sp,sp,-80
    80003f0a:	e486                	sd	ra,72(sp)
    80003f0c:	e0a2                	sd	s0,64(sp)
    80003f0e:	fc26                	sd	s1,56(sp)
    80003f10:	f84a                	sd	s2,48(sp)
    80003f12:	f44e                	sd	s3,40(sp)
    80003f14:	0880                	add	s0,sp,80
    80003f16:	84aa                	mv	s1,a0
    80003f18:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80003f1a:	ffffd097          	auipc	ra,0xffffd
    80003f1e:	0b0080e7          	jalr	176(ra) # 80000fca <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80003f22:	409c                	lw	a5,0(s1)
    80003f24:	37f9                	addw	a5,a5,-2
    80003f26:	4705                	li	a4,1
    80003f28:	04f76763          	bltu	a4,a5,80003f76 <filestat+0x6e>
    80003f2c:	892a                	mv	s2,a0
    ilock(f->ip);
    80003f2e:	6c88                	ld	a0,24(s1)
    80003f30:	fffff097          	auipc	ra,0xfffff
    80003f34:	0a6080e7          	jalr	166(ra) # 80002fd6 <ilock>
    stati(f->ip, &st);
    80003f38:	fb840593          	add	a1,s0,-72
    80003f3c:	6c88                	ld	a0,24(s1)
    80003f3e:	fffff097          	auipc	ra,0xfffff
    80003f42:	322080e7          	jalr	802(ra) # 80003260 <stati>
    iunlock(f->ip);
    80003f46:	6c88                	ld	a0,24(s1)
    80003f48:	fffff097          	auipc	ra,0xfffff
    80003f4c:	150080e7          	jalr	336(ra) # 80003098 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80003f50:	46e1                	li	a3,24
    80003f52:	fb840613          	add	a2,s0,-72
    80003f56:	85ce                	mv	a1,s3
    80003f58:	05093503          	ld	a0,80(s2)
    80003f5c:	ffffd097          	auipc	ra,0xffffd
    80003f60:	c00080e7          	jalr	-1024(ra) # 80000b5c <copyout>
    80003f64:	41f5551b          	sraw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80003f68:	60a6                	ld	ra,72(sp)
    80003f6a:	6406                	ld	s0,64(sp)
    80003f6c:	74e2                	ld	s1,56(sp)
    80003f6e:	7942                	ld	s2,48(sp)
    80003f70:	79a2                	ld	s3,40(sp)
    80003f72:	6161                	add	sp,sp,80
    80003f74:	8082                	ret
  return -1;
    80003f76:	557d                	li	a0,-1
    80003f78:	bfc5                	j	80003f68 <filestat+0x60>

0000000080003f7a <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003f7a:	7179                	add	sp,sp,-48
    80003f7c:	f406                	sd	ra,40(sp)
    80003f7e:	f022                	sd	s0,32(sp)
    80003f80:	ec26                	sd	s1,24(sp)
    80003f82:	e84a                	sd	s2,16(sp)
    80003f84:	e44e                	sd	s3,8(sp)
    80003f86:	1800                	add	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80003f88:	00854783          	lbu	a5,8(a0)
    80003f8c:	c3d5                	beqz	a5,80004030 <fileread+0xb6>
    80003f8e:	84aa                	mv	s1,a0
    80003f90:	89ae                	mv	s3,a1
    80003f92:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80003f94:	411c                	lw	a5,0(a0)
    80003f96:	4705                	li	a4,1
    80003f98:	04e78963          	beq	a5,a4,80003fea <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003f9c:	470d                	li	a4,3
    80003f9e:	04e78d63          	beq	a5,a4,80003ff8 <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80003fa2:	4709                	li	a4,2
    80003fa4:	06e79e63          	bne	a5,a4,80004020 <fileread+0xa6>
    ilock(f->ip);
    80003fa8:	6d08                	ld	a0,24(a0)
    80003faa:	fffff097          	auipc	ra,0xfffff
    80003fae:	02c080e7          	jalr	44(ra) # 80002fd6 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003fb2:	874a                	mv	a4,s2
    80003fb4:	5094                	lw	a3,32(s1)
    80003fb6:	864e                	mv	a2,s3
    80003fb8:	4585                	li	a1,1
    80003fba:	6c88                	ld	a0,24(s1)
    80003fbc:	fffff097          	auipc	ra,0xfffff
    80003fc0:	2ce080e7          	jalr	718(ra) # 8000328a <readi>
    80003fc4:	892a                	mv	s2,a0
    80003fc6:	00a05563          	blez	a0,80003fd0 <fileread+0x56>
      f->off += r;
    80003fca:	509c                	lw	a5,32(s1)
    80003fcc:	9fa9                	addw	a5,a5,a0
    80003fce:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80003fd0:	6c88                	ld	a0,24(s1)
    80003fd2:	fffff097          	auipc	ra,0xfffff
    80003fd6:	0c6080e7          	jalr	198(ra) # 80003098 <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    80003fda:	854a                	mv	a0,s2
    80003fdc:	70a2                	ld	ra,40(sp)
    80003fde:	7402                	ld	s0,32(sp)
    80003fe0:	64e2                	ld	s1,24(sp)
    80003fe2:	6942                	ld	s2,16(sp)
    80003fe4:	69a2                	ld	s3,8(sp)
    80003fe6:	6145                	add	sp,sp,48
    80003fe8:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80003fea:	6908                	ld	a0,16(a0)
    80003fec:	00000097          	auipc	ra,0x0
    80003ff0:	3c2080e7          	jalr	962(ra) # 800043ae <piperead>
    80003ff4:	892a                	mv	s2,a0
    80003ff6:	b7d5                	j	80003fda <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80003ff8:	02451783          	lh	a5,36(a0)
    80003ffc:	03079693          	sll	a3,a5,0x30
    80004000:	92c1                	srl	a3,a3,0x30
    80004002:	4725                	li	a4,9
    80004004:	02d76863          	bltu	a4,a3,80004034 <fileread+0xba>
    80004008:	0792                	sll	a5,a5,0x4
    8000400a:	00015717          	auipc	a4,0x15
    8000400e:	f7670713          	add	a4,a4,-138 # 80018f80 <devsw>
    80004012:	97ba                	add	a5,a5,a4
    80004014:	639c                	ld	a5,0(a5)
    80004016:	c38d                	beqz	a5,80004038 <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    80004018:	4505                	li	a0,1
    8000401a:	9782                	jalr	a5
    8000401c:	892a                	mv	s2,a0
    8000401e:	bf75                	j	80003fda <fileread+0x60>
    panic("fileread");
    80004020:	00005517          	auipc	a0,0x5
    80004024:	81850513          	add	a0,a0,-2024 # 80008838 <syscallnames+0x278>
    80004028:	00002097          	auipc	ra,0x2
    8000402c:	0b8080e7          	jalr	184(ra) # 800060e0 <panic>
    return -1;
    80004030:	597d                	li	s2,-1
    80004032:	b765                	j	80003fda <fileread+0x60>
      return -1;
    80004034:	597d                	li	s2,-1
    80004036:	b755                	j	80003fda <fileread+0x60>
    80004038:	597d                	li	s2,-1
    8000403a:	b745                	j	80003fda <fileread+0x60>

000000008000403c <filewrite>:
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if(f->writable == 0)
    8000403c:	00954783          	lbu	a5,9(a0)
    80004040:	10078e63          	beqz	a5,8000415c <filewrite+0x120>
{
    80004044:	715d                	add	sp,sp,-80
    80004046:	e486                	sd	ra,72(sp)
    80004048:	e0a2                	sd	s0,64(sp)
    8000404a:	fc26                	sd	s1,56(sp)
    8000404c:	f84a                	sd	s2,48(sp)
    8000404e:	f44e                	sd	s3,40(sp)
    80004050:	f052                	sd	s4,32(sp)
    80004052:	ec56                	sd	s5,24(sp)
    80004054:	e85a                	sd	s6,16(sp)
    80004056:	e45e                	sd	s7,8(sp)
    80004058:	e062                	sd	s8,0(sp)
    8000405a:	0880                	add	s0,sp,80
    8000405c:	892a                	mv	s2,a0
    8000405e:	8b2e                	mv	s6,a1
    80004060:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    80004062:	411c                	lw	a5,0(a0)
    80004064:	4705                	li	a4,1
    80004066:	02e78263          	beq	a5,a4,8000408a <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    8000406a:	470d                	li	a4,3
    8000406c:	02e78563          	beq	a5,a4,80004096 <filewrite+0x5a>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80004070:	4709                	li	a4,2
    80004072:	0ce79d63          	bne	a5,a4,8000414c <filewrite+0x110>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80004076:	0ac05b63          	blez	a2,8000412c <filewrite+0xf0>
    int i = 0;
    8000407a:	4981                	li	s3,0
      int n1 = n - i;
      if(n1 > max)
    8000407c:	6b85                	lui	s7,0x1
    8000407e:	c00b8b93          	add	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    80004082:	6c05                	lui	s8,0x1
    80004084:	c00c0c1b          	addw	s8,s8,-1024 # c00 <_entry-0x7ffff400>
    80004088:	a851                	j	8000411c <filewrite+0xe0>
    ret = pipewrite(f->pipe, addr, n);
    8000408a:	6908                	ld	a0,16(a0)
    8000408c:	00000097          	auipc	ra,0x0
    80004090:	22a080e7          	jalr	554(ra) # 800042b6 <pipewrite>
    80004094:	a045                	j	80004134 <filewrite+0xf8>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80004096:	02451783          	lh	a5,36(a0)
    8000409a:	03079693          	sll	a3,a5,0x30
    8000409e:	92c1                	srl	a3,a3,0x30
    800040a0:	4725                	li	a4,9
    800040a2:	0ad76f63          	bltu	a4,a3,80004160 <filewrite+0x124>
    800040a6:	0792                	sll	a5,a5,0x4
    800040a8:	00015717          	auipc	a4,0x15
    800040ac:	ed870713          	add	a4,a4,-296 # 80018f80 <devsw>
    800040b0:	97ba                	add	a5,a5,a4
    800040b2:	679c                	ld	a5,8(a5)
    800040b4:	cbc5                	beqz	a5,80004164 <filewrite+0x128>
    ret = devsw[f->major].write(1, addr, n);
    800040b6:	4505                	li	a0,1
    800040b8:	9782                	jalr	a5
    800040ba:	a8ad                	j	80004134 <filewrite+0xf8>
      if(n1 > max)
    800040bc:	00048a9b          	sext.w	s5,s1
        n1 = max;

      begin_op();
    800040c0:	00000097          	auipc	ra,0x0
    800040c4:	8bc080e7          	jalr	-1860(ra) # 8000397c <begin_op>
      ilock(f->ip);
    800040c8:	01893503          	ld	a0,24(s2)
    800040cc:	fffff097          	auipc	ra,0xfffff
    800040d0:	f0a080e7          	jalr	-246(ra) # 80002fd6 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    800040d4:	8756                	mv	a4,s5
    800040d6:	02092683          	lw	a3,32(s2)
    800040da:	01698633          	add	a2,s3,s6
    800040de:	4585                	li	a1,1
    800040e0:	01893503          	ld	a0,24(s2)
    800040e4:	fffff097          	auipc	ra,0xfffff
    800040e8:	29e080e7          	jalr	670(ra) # 80003382 <writei>
    800040ec:	84aa                	mv	s1,a0
    800040ee:	00a05763          	blez	a0,800040fc <filewrite+0xc0>
        f->off += r;
    800040f2:	02092783          	lw	a5,32(s2)
    800040f6:	9fa9                	addw	a5,a5,a0
    800040f8:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    800040fc:	01893503          	ld	a0,24(s2)
    80004100:	fffff097          	auipc	ra,0xfffff
    80004104:	f98080e7          	jalr	-104(ra) # 80003098 <iunlock>
      end_op();
    80004108:	00000097          	auipc	ra,0x0
    8000410c:	8ee080e7          	jalr	-1810(ra) # 800039f6 <end_op>

      if(r != n1){
    80004110:	009a9f63          	bne	s5,s1,8000412e <filewrite+0xf2>
        // error from writei
        break;
      }
      i += r;
    80004114:	013489bb          	addw	s3,s1,s3
    while(i < n){
    80004118:	0149db63          	bge	s3,s4,8000412e <filewrite+0xf2>
      int n1 = n - i;
    8000411c:	413a04bb          	subw	s1,s4,s3
      if(n1 > max)
    80004120:	0004879b          	sext.w	a5,s1
    80004124:	f8fbdce3          	bge	s7,a5,800040bc <filewrite+0x80>
    80004128:	84e2                	mv	s1,s8
    8000412a:	bf49                	j	800040bc <filewrite+0x80>
    int i = 0;
    8000412c:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    8000412e:	033a1d63          	bne	s4,s3,80004168 <filewrite+0x12c>
    80004132:	8552                	mv	a0,s4
  } else {
    panic("filewrite");
  }

  return ret;
}
    80004134:	60a6                	ld	ra,72(sp)
    80004136:	6406                	ld	s0,64(sp)
    80004138:	74e2                	ld	s1,56(sp)
    8000413a:	7942                	ld	s2,48(sp)
    8000413c:	79a2                	ld	s3,40(sp)
    8000413e:	7a02                	ld	s4,32(sp)
    80004140:	6ae2                	ld	s5,24(sp)
    80004142:	6b42                	ld	s6,16(sp)
    80004144:	6ba2                	ld	s7,8(sp)
    80004146:	6c02                	ld	s8,0(sp)
    80004148:	6161                	add	sp,sp,80
    8000414a:	8082                	ret
    panic("filewrite");
    8000414c:	00004517          	auipc	a0,0x4
    80004150:	6fc50513          	add	a0,a0,1788 # 80008848 <syscallnames+0x288>
    80004154:	00002097          	auipc	ra,0x2
    80004158:	f8c080e7          	jalr	-116(ra) # 800060e0 <panic>
    return -1;
    8000415c:	557d                	li	a0,-1
}
    8000415e:	8082                	ret
      return -1;
    80004160:	557d                	li	a0,-1
    80004162:	bfc9                	j	80004134 <filewrite+0xf8>
    80004164:	557d                	li	a0,-1
    80004166:	b7f9                	j	80004134 <filewrite+0xf8>
    ret = (i == n ? n : -1);
    80004168:	557d                	li	a0,-1
    8000416a:	b7e9                	j	80004134 <filewrite+0xf8>

000000008000416c <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    8000416c:	7179                	add	sp,sp,-48
    8000416e:	f406                	sd	ra,40(sp)
    80004170:	f022                	sd	s0,32(sp)
    80004172:	ec26                	sd	s1,24(sp)
    80004174:	e84a                	sd	s2,16(sp)
    80004176:	e44e                	sd	s3,8(sp)
    80004178:	e052                	sd	s4,0(sp)
    8000417a:	1800                	add	s0,sp,48
    8000417c:	84aa                	mv	s1,a0
    8000417e:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80004180:	0005b023          	sd	zero,0(a1)
    80004184:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80004188:	00000097          	auipc	ra,0x0
    8000418c:	bfc080e7          	jalr	-1028(ra) # 80003d84 <filealloc>
    80004190:	e088                	sd	a0,0(s1)
    80004192:	c551                	beqz	a0,8000421e <pipealloc+0xb2>
    80004194:	00000097          	auipc	ra,0x0
    80004198:	bf0080e7          	jalr	-1040(ra) # 80003d84 <filealloc>
    8000419c:	00aa3023          	sd	a0,0(s4)
    800041a0:	c92d                	beqz	a0,80004212 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    800041a2:	ffffc097          	auipc	ra,0xffffc
    800041a6:	fc2080e7          	jalr	-62(ra) # 80000164 <kalloc>
    800041aa:	892a                	mv	s2,a0
    800041ac:	c125                	beqz	a0,8000420c <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    800041ae:	4985                	li	s3,1
    800041b0:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    800041b4:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    800041b8:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    800041bc:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    800041c0:	00004597          	auipc	a1,0x4
    800041c4:	26058593          	add	a1,a1,608 # 80008420 <states.0+0x1a0>
    800041c8:	00002097          	auipc	ra,0x2
    800041cc:	3c0080e7          	jalr	960(ra) # 80006588 <initlock>
  (*f0)->type = FD_PIPE;
    800041d0:	609c                	ld	a5,0(s1)
    800041d2:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    800041d6:	609c                	ld	a5,0(s1)
    800041d8:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    800041dc:	609c                	ld	a5,0(s1)
    800041de:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    800041e2:	609c                	ld	a5,0(s1)
    800041e4:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    800041e8:	000a3783          	ld	a5,0(s4)
    800041ec:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    800041f0:	000a3783          	ld	a5,0(s4)
    800041f4:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    800041f8:	000a3783          	ld	a5,0(s4)
    800041fc:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80004200:	000a3783          	ld	a5,0(s4)
    80004204:	0127b823          	sd	s2,16(a5)
  return 0;
    80004208:	4501                	li	a0,0
    8000420a:	a025                	j	80004232 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    8000420c:	6088                	ld	a0,0(s1)
    8000420e:	e501                	bnez	a0,80004216 <pipealloc+0xaa>
    80004210:	a039                	j	8000421e <pipealloc+0xb2>
    80004212:	6088                	ld	a0,0(s1)
    80004214:	c51d                	beqz	a0,80004242 <pipealloc+0xd6>
    fileclose(*f0);
    80004216:	00000097          	auipc	ra,0x0
    8000421a:	c2a080e7          	jalr	-982(ra) # 80003e40 <fileclose>
  if(*f1)
    8000421e:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80004222:	557d                	li	a0,-1
  if(*f1)
    80004224:	c799                	beqz	a5,80004232 <pipealloc+0xc6>
    fileclose(*f1);
    80004226:	853e                	mv	a0,a5
    80004228:	00000097          	auipc	ra,0x0
    8000422c:	c18080e7          	jalr	-1000(ra) # 80003e40 <fileclose>
  return -1;
    80004230:	557d                	li	a0,-1
}
    80004232:	70a2                	ld	ra,40(sp)
    80004234:	7402                	ld	s0,32(sp)
    80004236:	64e2                	ld	s1,24(sp)
    80004238:	6942                	ld	s2,16(sp)
    8000423a:	69a2                	ld	s3,8(sp)
    8000423c:	6a02                	ld	s4,0(sp)
    8000423e:	6145                	add	sp,sp,48
    80004240:	8082                	ret
  return -1;
    80004242:	557d                	li	a0,-1
    80004244:	b7fd                	j	80004232 <pipealloc+0xc6>

0000000080004246 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80004246:	1101                	add	sp,sp,-32
    80004248:	ec06                	sd	ra,24(sp)
    8000424a:	e822                	sd	s0,16(sp)
    8000424c:	e426                	sd	s1,8(sp)
    8000424e:	e04a                	sd	s2,0(sp)
    80004250:	1000                	add	s0,sp,32
    80004252:	84aa                	mv	s1,a0
    80004254:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80004256:	00002097          	auipc	ra,0x2
    8000425a:	3c2080e7          	jalr	962(ra) # 80006618 <acquire>
  if(writable){
    8000425e:	02090d63          	beqz	s2,80004298 <pipeclose+0x52>
    pi->writeopen = 0;
    80004262:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80004266:	21848513          	add	a0,s1,536
    8000426a:	ffffd097          	auipc	ra,0xffffd
    8000426e:	594080e7          	jalr	1428(ra) # 800017fe <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80004272:	2204b783          	ld	a5,544(s1)
    80004276:	eb95                	bnez	a5,800042aa <pipeclose+0x64>
    release(&pi->lock);
    80004278:	8526                	mv	a0,s1
    8000427a:	00002097          	auipc	ra,0x2
    8000427e:	452080e7          	jalr	1106(ra) # 800066cc <release>
    kfree((char*)pi);
    80004282:	8526                	mv	a0,s1
    80004284:	ffffc097          	auipc	ra,0xffffc
    80004288:	d98080e7          	jalr	-616(ra) # 8000001c <kfree>
  } else
    release(&pi->lock);
}
    8000428c:	60e2                	ld	ra,24(sp)
    8000428e:	6442                	ld	s0,16(sp)
    80004290:	64a2                	ld	s1,8(sp)
    80004292:	6902                	ld	s2,0(sp)
    80004294:	6105                	add	sp,sp,32
    80004296:	8082                	ret
    pi->readopen = 0;
    80004298:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    8000429c:	21c48513          	add	a0,s1,540
    800042a0:	ffffd097          	auipc	ra,0xffffd
    800042a4:	55e080e7          	jalr	1374(ra) # 800017fe <wakeup>
    800042a8:	b7e9                	j	80004272 <pipeclose+0x2c>
    release(&pi->lock);
    800042aa:	8526                	mv	a0,s1
    800042ac:	00002097          	auipc	ra,0x2
    800042b0:	420080e7          	jalr	1056(ra) # 800066cc <release>
}
    800042b4:	bfe1                	j	8000428c <pipeclose+0x46>

00000000800042b6 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    800042b6:	711d                	add	sp,sp,-96
    800042b8:	ec86                	sd	ra,88(sp)
    800042ba:	e8a2                	sd	s0,80(sp)
    800042bc:	e4a6                	sd	s1,72(sp)
    800042be:	e0ca                	sd	s2,64(sp)
    800042c0:	fc4e                	sd	s3,56(sp)
    800042c2:	f852                	sd	s4,48(sp)
    800042c4:	f456                	sd	s5,40(sp)
    800042c6:	f05a                	sd	s6,32(sp)
    800042c8:	ec5e                	sd	s7,24(sp)
    800042ca:	e862                	sd	s8,16(sp)
    800042cc:	1080                	add	s0,sp,96
    800042ce:	84aa                	mv	s1,a0
    800042d0:	8aae                	mv	s5,a1
    800042d2:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    800042d4:	ffffd097          	auipc	ra,0xffffd
    800042d8:	cf6080e7          	jalr	-778(ra) # 80000fca <myproc>
    800042dc:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    800042de:	8526                	mv	a0,s1
    800042e0:	00002097          	auipc	ra,0x2
    800042e4:	338080e7          	jalr	824(ra) # 80006618 <acquire>
  while(i < n){
    800042e8:	0b405663          	blez	s4,80004394 <pipewrite+0xde>
  int i = 0;
    800042ec:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    800042ee:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    800042f0:	21848c13          	add	s8,s1,536
      sleep(&pi->nwrite, &pi->lock);
    800042f4:	21c48b93          	add	s7,s1,540
    800042f8:	a089                	j	8000433a <pipewrite+0x84>
      release(&pi->lock);
    800042fa:	8526                	mv	a0,s1
    800042fc:	00002097          	auipc	ra,0x2
    80004300:	3d0080e7          	jalr	976(ra) # 800066cc <release>
      return -1;
    80004304:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80004306:	854a                	mv	a0,s2
    80004308:	60e6                	ld	ra,88(sp)
    8000430a:	6446                	ld	s0,80(sp)
    8000430c:	64a6                	ld	s1,72(sp)
    8000430e:	6906                	ld	s2,64(sp)
    80004310:	79e2                	ld	s3,56(sp)
    80004312:	7a42                	ld	s4,48(sp)
    80004314:	7aa2                	ld	s5,40(sp)
    80004316:	7b02                	ld	s6,32(sp)
    80004318:	6be2                	ld	s7,24(sp)
    8000431a:	6c42                	ld	s8,16(sp)
    8000431c:	6125                	add	sp,sp,96
    8000431e:	8082                	ret
      wakeup(&pi->nread);
    80004320:	8562                	mv	a0,s8
    80004322:	ffffd097          	auipc	ra,0xffffd
    80004326:	4dc080e7          	jalr	1244(ra) # 800017fe <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    8000432a:	85a6                	mv	a1,s1
    8000432c:	855e                	mv	a0,s7
    8000432e:	ffffd097          	auipc	ra,0xffffd
    80004332:	46c080e7          	jalr	1132(ra) # 8000179a <sleep>
  while(i < n){
    80004336:	07495063          	bge	s2,s4,80004396 <pipewrite+0xe0>
    if(pi->readopen == 0 || killed(pr)){
    8000433a:	2204a783          	lw	a5,544(s1)
    8000433e:	dfd5                	beqz	a5,800042fa <pipewrite+0x44>
    80004340:	854e                	mv	a0,s3
    80004342:	ffffd097          	auipc	ra,0xffffd
    80004346:	700080e7          	jalr	1792(ra) # 80001a42 <killed>
    8000434a:	f945                	bnez	a0,800042fa <pipewrite+0x44>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    8000434c:	2184a783          	lw	a5,536(s1)
    80004350:	21c4a703          	lw	a4,540(s1)
    80004354:	2007879b          	addw	a5,a5,512
    80004358:	fcf704e3          	beq	a4,a5,80004320 <pipewrite+0x6a>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    8000435c:	4685                	li	a3,1
    8000435e:	01590633          	add	a2,s2,s5
    80004362:	faf40593          	add	a1,s0,-81
    80004366:	0509b503          	ld	a0,80(s3)
    8000436a:	ffffd097          	auipc	ra,0xffffd
    8000436e:	87e080e7          	jalr	-1922(ra) # 80000be8 <copyin>
    80004372:	03650263          	beq	a0,s6,80004396 <pipewrite+0xe0>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80004376:	21c4a783          	lw	a5,540(s1)
    8000437a:	0017871b          	addw	a4,a5,1
    8000437e:	20e4ae23          	sw	a4,540(s1)
    80004382:	1ff7f793          	and	a5,a5,511
    80004386:	97a6                	add	a5,a5,s1
    80004388:	faf44703          	lbu	a4,-81(s0)
    8000438c:	00e78c23          	sb	a4,24(a5)
      i++;
    80004390:	2905                	addw	s2,s2,1
    80004392:	b755                	j	80004336 <pipewrite+0x80>
  int i = 0;
    80004394:	4901                	li	s2,0
  wakeup(&pi->nread);
    80004396:	21848513          	add	a0,s1,536
    8000439a:	ffffd097          	auipc	ra,0xffffd
    8000439e:	464080e7          	jalr	1124(ra) # 800017fe <wakeup>
  release(&pi->lock);
    800043a2:	8526                	mv	a0,s1
    800043a4:	00002097          	auipc	ra,0x2
    800043a8:	328080e7          	jalr	808(ra) # 800066cc <release>
  return i;
    800043ac:	bfa9                	j	80004306 <pipewrite+0x50>

00000000800043ae <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    800043ae:	715d                	add	sp,sp,-80
    800043b0:	e486                	sd	ra,72(sp)
    800043b2:	e0a2                	sd	s0,64(sp)
    800043b4:	fc26                	sd	s1,56(sp)
    800043b6:	f84a                	sd	s2,48(sp)
    800043b8:	f44e                	sd	s3,40(sp)
    800043ba:	f052                	sd	s4,32(sp)
    800043bc:	ec56                	sd	s5,24(sp)
    800043be:	e85a                	sd	s6,16(sp)
    800043c0:	0880                	add	s0,sp,80
    800043c2:	84aa                	mv	s1,a0
    800043c4:	892e                	mv	s2,a1
    800043c6:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    800043c8:	ffffd097          	auipc	ra,0xffffd
    800043cc:	c02080e7          	jalr	-1022(ra) # 80000fca <myproc>
    800043d0:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    800043d2:	8526                	mv	a0,s1
    800043d4:	00002097          	auipc	ra,0x2
    800043d8:	244080e7          	jalr	580(ra) # 80006618 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800043dc:	2184a703          	lw	a4,536(s1)
    800043e0:	21c4a783          	lw	a5,540(s1)
    if(killed(pr)){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800043e4:	21848993          	add	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800043e8:	02f71763          	bne	a4,a5,80004416 <piperead+0x68>
    800043ec:	2244a783          	lw	a5,548(s1)
    800043f0:	c39d                	beqz	a5,80004416 <piperead+0x68>
    if(killed(pr)){
    800043f2:	8552                	mv	a0,s4
    800043f4:	ffffd097          	auipc	ra,0xffffd
    800043f8:	64e080e7          	jalr	1614(ra) # 80001a42 <killed>
    800043fc:	e949                	bnez	a0,8000448e <piperead+0xe0>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800043fe:	85a6                	mv	a1,s1
    80004400:	854e                	mv	a0,s3
    80004402:	ffffd097          	auipc	ra,0xffffd
    80004406:	398080e7          	jalr	920(ra) # 8000179a <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    8000440a:	2184a703          	lw	a4,536(s1)
    8000440e:	21c4a783          	lw	a5,540(s1)
    80004412:	fcf70de3          	beq	a4,a5,800043ec <piperead+0x3e>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004416:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004418:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000441a:	05505463          	blez	s5,80004462 <piperead+0xb4>
    if(pi->nread == pi->nwrite)
    8000441e:	2184a783          	lw	a5,536(s1)
    80004422:	21c4a703          	lw	a4,540(s1)
    80004426:	02f70e63          	beq	a4,a5,80004462 <piperead+0xb4>
    ch = pi->data[pi->nread++ % PIPESIZE];
    8000442a:	0017871b          	addw	a4,a5,1
    8000442e:	20e4ac23          	sw	a4,536(s1)
    80004432:	1ff7f793          	and	a5,a5,511
    80004436:	97a6                	add	a5,a5,s1
    80004438:	0187c783          	lbu	a5,24(a5)
    8000443c:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004440:	4685                	li	a3,1
    80004442:	fbf40613          	add	a2,s0,-65
    80004446:	85ca                	mv	a1,s2
    80004448:	050a3503          	ld	a0,80(s4)
    8000444c:	ffffc097          	auipc	ra,0xffffc
    80004450:	710080e7          	jalr	1808(ra) # 80000b5c <copyout>
    80004454:	01650763          	beq	a0,s6,80004462 <piperead+0xb4>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004458:	2985                	addw	s3,s3,1
    8000445a:	0905                	add	s2,s2,1
    8000445c:	fd3a91e3          	bne	s5,s3,8000441e <piperead+0x70>
    80004460:	89d6                	mv	s3,s5
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80004462:	21c48513          	add	a0,s1,540
    80004466:	ffffd097          	auipc	ra,0xffffd
    8000446a:	398080e7          	jalr	920(ra) # 800017fe <wakeup>
  release(&pi->lock);
    8000446e:	8526                	mv	a0,s1
    80004470:	00002097          	auipc	ra,0x2
    80004474:	25c080e7          	jalr	604(ra) # 800066cc <release>
  return i;
}
    80004478:	854e                	mv	a0,s3
    8000447a:	60a6                	ld	ra,72(sp)
    8000447c:	6406                	ld	s0,64(sp)
    8000447e:	74e2                	ld	s1,56(sp)
    80004480:	7942                	ld	s2,48(sp)
    80004482:	79a2                	ld	s3,40(sp)
    80004484:	7a02                	ld	s4,32(sp)
    80004486:	6ae2                	ld	s5,24(sp)
    80004488:	6b42                	ld	s6,16(sp)
    8000448a:	6161                	add	sp,sp,80
    8000448c:	8082                	ret
      release(&pi->lock);
    8000448e:	8526                	mv	a0,s1
    80004490:	00002097          	auipc	ra,0x2
    80004494:	23c080e7          	jalr	572(ra) # 800066cc <release>
      return -1;
    80004498:	59fd                	li	s3,-1
    8000449a:	bff9                	j	80004478 <piperead+0xca>

000000008000449c <flags2perm>:
#include "elf.h"

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

int flags2perm(int flags)
{
    8000449c:	1141                	add	sp,sp,-16
    8000449e:	e422                	sd	s0,8(sp)
    800044a0:	0800                	add	s0,sp,16
    800044a2:	87aa                	mv	a5,a0
    int perm = 0;
    if(flags & 0x1)
    800044a4:	8905                	and	a0,a0,1
    800044a6:	050e                	sll	a0,a0,0x3
      perm = PTE_X;
    if(flags & 0x2)
    800044a8:	8b89                	and	a5,a5,2
    800044aa:	c399                	beqz	a5,800044b0 <flags2perm+0x14>
      perm |= PTE_W;
    800044ac:	00456513          	or	a0,a0,4
    return perm;
}
    800044b0:	6422                	ld	s0,8(sp)
    800044b2:	0141                	add	sp,sp,16
    800044b4:	8082                	ret

00000000800044b6 <exec>:

int
exec(char *path, char **argv)
{
    800044b6:	df010113          	add	sp,sp,-528
    800044ba:	20113423          	sd	ra,520(sp)
    800044be:	20813023          	sd	s0,512(sp)
    800044c2:	ffa6                	sd	s1,504(sp)
    800044c4:	fbca                	sd	s2,496(sp)
    800044c6:	f7ce                	sd	s3,488(sp)
    800044c8:	f3d2                	sd	s4,480(sp)
    800044ca:	efd6                	sd	s5,472(sp)
    800044cc:	ebda                	sd	s6,464(sp)
    800044ce:	e7de                	sd	s7,456(sp)
    800044d0:	e3e2                	sd	s8,448(sp)
    800044d2:	ff66                	sd	s9,440(sp)
    800044d4:	fb6a                	sd	s10,432(sp)
    800044d6:	f76e                	sd	s11,424(sp)
    800044d8:	0c00                	add	s0,sp,528
    800044da:	892a                	mv	s2,a0
    800044dc:	dea43c23          	sd	a0,-520(s0)
    800044e0:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    800044e4:	ffffd097          	auipc	ra,0xffffd
    800044e8:	ae6080e7          	jalr	-1306(ra) # 80000fca <myproc>
    800044ec:	84aa                	mv	s1,a0

  begin_op();
    800044ee:	fffff097          	auipc	ra,0xfffff
    800044f2:	48e080e7          	jalr	1166(ra) # 8000397c <begin_op>

  if((ip = namei(path)) == 0){
    800044f6:	854a                	mv	a0,s2
    800044f8:	fffff097          	auipc	ra,0xfffff
    800044fc:	284080e7          	jalr	644(ra) # 8000377c <namei>
    80004500:	c92d                	beqz	a0,80004572 <exec+0xbc>
    80004502:	8a2a                	mv	s4,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80004504:	fffff097          	auipc	ra,0xfffff
    80004508:	ad2080e7          	jalr	-1326(ra) # 80002fd6 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    8000450c:	04000713          	li	a4,64
    80004510:	4681                	li	a3,0
    80004512:	e5040613          	add	a2,s0,-432
    80004516:	4581                	li	a1,0
    80004518:	8552                	mv	a0,s4
    8000451a:	fffff097          	auipc	ra,0xfffff
    8000451e:	d70080e7          	jalr	-656(ra) # 8000328a <readi>
    80004522:	04000793          	li	a5,64
    80004526:	00f51a63          	bne	a0,a5,8000453a <exec+0x84>
    goto bad;

  if(elf.magic != ELF_MAGIC)
    8000452a:	e5042703          	lw	a4,-432(s0)
    8000452e:	464c47b7          	lui	a5,0x464c4
    80004532:	57f78793          	add	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80004536:	04f70463          	beq	a4,a5,8000457e <exec+0xc8>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    8000453a:	8552                	mv	a0,s4
    8000453c:	fffff097          	auipc	ra,0xfffff
    80004540:	cfc080e7          	jalr	-772(ra) # 80003238 <iunlockput>
    end_op();
    80004544:	fffff097          	auipc	ra,0xfffff
    80004548:	4b2080e7          	jalr	1202(ra) # 800039f6 <end_op>
  }
  return -1;
    8000454c:	557d                	li	a0,-1
}
    8000454e:	20813083          	ld	ra,520(sp)
    80004552:	20013403          	ld	s0,512(sp)
    80004556:	74fe                	ld	s1,504(sp)
    80004558:	795e                	ld	s2,496(sp)
    8000455a:	79be                	ld	s3,488(sp)
    8000455c:	7a1e                	ld	s4,480(sp)
    8000455e:	6afe                	ld	s5,472(sp)
    80004560:	6b5e                	ld	s6,464(sp)
    80004562:	6bbe                	ld	s7,456(sp)
    80004564:	6c1e                	ld	s8,448(sp)
    80004566:	7cfa                	ld	s9,440(sp)
    80004568:	7d5a                	ld	s10,432(sp)
    8000456a:	7dba                	ld	s11,424(sp)
    8000456c:	21010113          	add	sp,sp,528
    80004570:	8082                	ret
    end_op();
    80004572:	fffff097          	auipc	ra,0xfffff
    80004576:	484080e7          	jalr	1156(ra) # 800039f6 <end_op>
    return -1;
    8000457a:	557d                	li	a0,-1
    8000457c:	bfc9                	j	8000454e <exec+0x98>
  if((pagetable = proc_pagetable(p)) == 0)
    8000457e:	8526                	mv	a0,s1
    80004580:	ffffd097          	auipc	ra,0xffffd
    80004584:	b0e080e7          	jalr	-1266(ra) # 8000108e <proc_pagetable>
    80004588:	8b2a                	mv	s6,a0
    8000458a:	d945                	beqz	a0,8000453a <exec+0x84>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000458c:	e7042d03          	lw	s10,-400(s0)
    80004590:	e8845783          	lhu	a5,-376(s0)
    80004594:	10078463          	beqz	a5,8000469c <exec+0x1e6>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004598:	4901                	li	s2,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000459a:	4d81                	li	s11,0
    if(ph.vaddr % PGSIZE != 0)
    8000459c:	6c85                	lui	s9,0x1
    8000459e:	fffc8793          	add	a5,s9,-1 # fff <_entry-0x7ffff001>
    800045a2:	def43823          	sd	a5,-528(s0)

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    if(sz - i < PGSIZE)
    800045a6:	6a85                	lui	s5,0x1
    800045a8:	a0b5                	j	80004614 <exec+0x15e>
      panic("loadseg: address should exist");
    800045aa:	00004517          	auipc	a0,0x4
    800045ae:	2ae50513          	add	a0,a0,686 # 80008858 <syscallnames+0x298>
    800045b2:	00002097          	auipc	ra,0x2
    800045b6:	b2e080e7          	jalr	-1234(ra) # 800060e0 <panic>
    if(sz - i < PGSIZE)
    800045ba:	2481                	sext.w	s1,s1
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    800045bc:	8726                	mv	a4,s1
    800045be:	012c06bb          	addw	a3,s8,s2
    800045c2:	4581                	li	a1,0
    800045c4:	8552                	mv	a0,s4
    800045c6:	fffff097          	auipc	ra,0xfffff
    800045ca:	cc4080e7          	jalr	-828(ra) # 8000328a <readi>
    800045ce:	2501                	sext.w	a0,a0
    800045d0:	24a49863          	bne	s1,a0,80004820 <exec+0x36a>
  for(i = 0; i < sz; i += PGSIZE){
    800045d4:	012a893b          	addw	s2,s5,s2
    800045d8:	03397563          	bgeu	s2,s3,80004602 <exec+0x14c>
    pa = walkaddr(pagetable, va + i);
    800045dc:	02091593          	sll	a1,s2,0x20
    800045e0:	9181                	srl	a1,a1,0x20
    800045e2:	95de                	add	a1,a1,s7
    800045e4:	855a                	mv	a0,s6
    800045e6:	ffffc097          	auipc	ra,0xffffc
    800045ea:	f66080e7          	jalr	-154(ra) # 8000054c <walkaddr>
    800045ee:	862a                	mv	a2,a0
    if(pa == 0)
    800045f0:	dd4d                	beqz	a0,800045aa <exec+0xf4>
    if(sz - i < PGSIZE)
    800045f2:	412984bb          	subw	s1,s3,s2
    800045f6:	0004879b          	sext.w	a5,s1
    800045fa:	fcfcf0e3          	bgeu	s9,a5,800045ba <exec+0x104>
    800045fe:	84d6                	mv	s1,s5
    80004600:	bf6d                	j	800045ba <exec+0x104>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80004602:	e0843903          	ld	s2,-504(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004606:	2d85                	addw	s11,s11,1
    80004608:	038d0d1b          	addw	s10,s10,56
    8000460c:	e8845783          	lhu	a5,-376(s0)
    80004610:	08fdd763          	bge	s11,a5,8000469e <exec+0x1e8>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80004614:	2d01                	sext.w	s10,s10
    80004616:	03800713          	li	a4,56
    8000461a:	86ea                	mv	a3,s10
    8000461c:	e1840613          	add	a2,s0,-488
    80004620:	4581                	li	a1,0
    80004622:	8552                	mv	a0,s4
    80004624:	fffff097          	auipc	ra,0xfffff
    80004628:	c66080e7          	jalr	-922(ra) # 8000328a <readi>
    8000462c:	03800793          	li	a5,56
    80004630:	1ef51663          	bne	a0,a5,8000481c <exec+0x366>
    if(ph.type != ELF_PROG_LOAD)
    80004634:	e1842783          	lw	a5,-488(s0)
    80004638:	4705                	li	a4,1
    8000463a:	fce796e3          	bne	a5,a4,80004606 <exec+0x150>
    if(ph.memsz < ph.filesz)
    8000463e:	e4043483          	ld	s1,-448(s0)
    80004642:	e3843783          	ld	a5,-456(s0)
    80004646:	1ef4e863          	bltu	s1,a5,80004836 <exec+0x380>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    8000464a:	e2843783          	ld	a5,-472(s0)
    8000464e:	94be                	add	s1,s1,a5
    80004650:	1ef4e663          	bltu	s1,a5,8000483c <exec+0x386>
    if(ph.vaddr % PGSIZE != 0)
    80004654:	df043703          	ld	a4,-528(s0)
    80004658:	8ff9                	and	a5,a5,a4
    8000465a:	1e079463          	bnez	a5,80004842 <exec+0x38c>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    8000465e:	e1c42503          	lw	a0,-484(s0)
    80004662:	00000097          	auipc	ra,0x0
    80004666:	e3a080e7          	jalr	-454(ra) # 8000449c <flags2perm>
    8000466a:	86aa                	mv	a3,a0
    8000466c:	8626                	mv	a2,s1
    8000466e:	85ca                	mv	a1,s2
    80004670:	855a                	mv	a0,s6
    80004672:	ffffc097          	auipc	ra,0xffffc
    80004676:	28e080e7          	jalr	654(ra) # 80000900 <uvmalloc>
    8000467a:	e0a43423          	sd	a0,-504(s0)
    8000467e:	1c050563          	beqz	a0,80004848 <exec+0x392>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80004682:	e2843b83          	ld	s7,-472(s0)
    80004686:	e2042c03          	lw	s8,-480(s0)
    8000468a:	e3842983          	lw	s3,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    8000468e:	00098463          	beqz	s3,80004696 <exec+0x1e0>
    80004692:	4901                	li	s2,0
    80004694:	b7a1                	j	800045dc <exec+0x126>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80004696:	e0843903          	ld	s2,-504(s0)
    8000469a:	b7b5                	j	80004606 <exec+0x150>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    8000469c:	4901                	li	s2,0
  iunlockput(ip);
    8000469e:	8552                	mv	a0,s4
    800046a0:	fffff097          	auipc	ra,0xfffff
    800046a4:	b98080e7          	jalr	-1128(ra) # 80003238 <iunlockput>
  end_op();
    800046a8:	fffff097          	auipc	ra,0xfffff
    800046ac:	34e080e7          	jalr	846(ra) # 800039f6 <end_op>
  p = myproc();
    800046b0:	ffffd097          	auipc	ra,0xffffd
    800046b4:	91a080e7          	jalr	-1766(ra) # 80000fca <myproc>
    800046b8:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    800046ba:	04853c83          	ld	s9,72(a0)
  sz = PGROUNDUP(sz);
    800046be:	6985                	lui	s3,0x1
    800046c0:	19fd                	add	s3,s3,-1 # fff <_entry-0x7ffff001>
    800046c2:	99ca                	add	s3,s3,s2
    800046c4:	77fd                	lui	a5,0xfffff
    800046c6:	00f9f9b3          	and	s3,s3,a5
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
    800046ca:	4691                	li	a3,4
    800046cc:	6609                	lui	a2,0x2
    800046ce:	964e                	add	a2,a2,s3
    800046d0:	85ce                	mv	a1,s3
    800046d2:	855a                	mv	a0,s6
    800046d4:	ffffc097          	auipc	ra,0xffffc
    800046d8:	22c080e7          	jalr	556(ra) # 80000900 <uvmalloc>
    800046dc:	892a                	mv	s2,a0
    800046de:	e0a43423          	sd	a0,-504(s0)
    800046e2:	e509                	bnez	a0,800046ec <exec+0x236>
  if(pagetable)
    800046e4:	e1343423          	sd	s3,-504(s0)
    800046e8:	4a01                	li	s4,0
    800046ea:	aa1d                	j	80004820 <exec+0x36a>
  uvmclear(pagetable, sz-2*PGSIZE);
    800046ec:	75f9                	lui	a1,0xffffe
    800046ee:	95aa                	add	a1,a1,a0
    800046f0:	855a                	mv	a0,s6
    800046f2:	ffffc097          	auipc	ra,0xffffc
    800046f6:	438080e7          	jalr	1080(ra) # 80000b2a <uvmclear>
  stackbase = sp - PGSIZE;
    800046fa:	7bfd                	lui	s7,0xfffff
    800046fc:	9bca                	add	s7,s7,s2
  for(argc = 0; argv[argc]; argc++) {
    800046fe:	e0043783          	ld	a5,-512(s0)
    80004702:	6388                	ld	a0,0(a5)
    80004704:	c52d                	beqz	a0,8000476e <exec+0x2b8>
    80004706:	e9040993          	add	s3,s0,-368
    8000470a:	f9040c13          	add	s8,s0,-112
    8000470e:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    80004710:	ffffc097          	auipc	ra,0xffffc
    80004714:	c2e080e7          	jalr	-978(ra) # 8000033e <strlen>
    80004718:	0015079b          	addw	a5,a0,1
    8000471c:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80004720:	ff07f913          	and	s2,a5,-16
    if(sp < stackbase)
    80004724:	13796563          	bltu	s2,s7,8000484e <exec+0x398>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80004728:	e0043d03          	ld	s10,-512(s0)
    8000472c:	000d3a03          	ld	s4,0(s10)
    80004730:	8552                	mv	a0,s4
    80004732:	ffffc097          	auipc	ra,0xffffc
    80004736:	c0c080e7          	jalr	-1012(ra) # 8000033e <strlen>
    8000473a:	0015069b          	addw	a3,a0,1
    8000473e:	8652                	mv	a2,s4
    80004740:	85ca                	mv	a1,s2
    80004742:	855a                	mv	a0,s6
    80004744:	ffffc097          	auipc	ra,0xffffc
    80004748:	418080e7          	jalr	1048(ra) # 80000b5c <copyout>
    8000474c:	10054363          	bltz	a0,80004852 <exec+0x39c>
    ustack[argc] = sp;
    80004750:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    80004754:	0485                	add	s1,s1,1
    80004756:	008d0793          	add	a5,s10,8
    8000475a:	e0f43023          	sd	a5,-512(s0)
    8000475e:	008d3503          	ld	a0,8(s10)
    80004762:	c909                	beqz	a0,80004774 <exec+0x2be>
    if(argc >= MAXARG)
    80004764:	09a1                	add	s3,s3,8
    80004766:	fb8995e3          	bne	s3,s8,80004710 <exec+0x25a>
  ip = 0;
    8000476a:	4a01                	li	s4,0
    8000476c:	a855                	j	80004820 <exec+0x36a>
  sp = sz;
    8000476e:	e0843903          	ld	s2,-504(s0)
  for(argc = 0; argv[argc]; argc++) {
    80004772:	4481                	li	s1,0
  ustack[argc] = 0;
    80004774:	00349793          	sll	a5,s1,0x3
    80004778:	f9078793          	add	a5,a5,-112 # ffffffffffffef90 <end+0xffffffff7ffdcc30>
    8000477c:	97a2                	add	a5,a5,s0
    8000477e:	f007b023          	sd	zero,-256(a5)
  sp -= (argc+1) * sizeof(uint64);
    80004782:	00148693          	add	a3,s1,1
    80004786:	068e                	sll	a3,a3,0x3
    80004788:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    8000478c:	ff097913          	and	s2,s2,-16
  sz = sz1;
    80004790:	e0843983          	ld	s3,-504(s0)
  if(sp < stackbase)
    80004794:	f57968e3          	bltu	s2,s7,800046e4 <exec+0x22e>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80004798:	e9040613          	add	a2,s0,-368
    8000479c:	85ca                	mv	a1,s2
    8000479e:	855a                	mv	a0,s6
    800047a0:	ffffc097          	auipc	ra,0xffffc
    800047a4:	3bc080e7          	jalr	956(ra) # 80000b5c <copyout>
    800047a8:	0a054763          	bltz	a0,80004856 <exec+0x3a0>
  p->trapframe->a1 = sp;
    800047ac:	060ab783          	ld	a5,96(s5) # 1060 <_entry-0x7fffefa0>
    800047b0:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    800047b4:	df843783          	ld	a5,-520(s0)
    800047b8:	0007c703          	lbu	a4,0(a5)
    800047bc:	cf11                	beqz	a4,800047d8 <exec+0x322>
    800047be:	0785                	add	a5,a5,1
    if(*s == '/')
    800047c0:	02f00693          	li	a3,47
    800047c4:	a039                	j	800047d2 <exec+0x31c>
      last = s+1;
    800047c6:	def43c23          	sd	a5,-520(s0)
  for(last=s=path; *s; s++)
    800047ca:	0785                	add	a5,a5,1
    800047cc:	fff7c703          	lbu	a4,-1(a5)
    800047d0:	c701                	beqz	a4,800047d8 <exec+0x322>
    if(*s == '/')
    800047d2:	fed71ce3          	bne	a4,a3,800047ca <exec+0x314>
    800047d6:	bfc5                	j	800047c6 <exec+0x310>
  safestrcpy(p->name, last, sizeof(p->name));
    800047d8:	4641                	li	a2,16
    800047da:	df843583          	ld	a1,-520(s0)
    800047de:	160a8513          	add	a0,s5,352
    800047e2:	ffffc097          	auipc	ra,0xffffc
    800047e6:	b2a080e7          	jalr	-1238(ra) # 8000030c <safestrcpy>
  oldpagetable = p->pagetable;
    800047ea:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    800047ee:	056ab823          	sd	s6,80(s5)
  p->sz = sz;
    800047f2:	e0843783          	ld	a5,-504(s0)
    800047f6:	04fab423          	sd	a5,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    800047fa:	060ab783          	ld	a5,96(s5)
    800047fe:	e6843703          	ld	a4,-408(s0)
    80004802:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80004804:	060ab783          	ld	a5,96(s5)
    80004808:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    8000480c:	85e6                	mv	a1,s9
    8000480e:	ffffd097          	auipc	ra,0xffffd
    80004812:	974080e7          	jalr	-1676(ra) # 80001182 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80004816:	0004851b          	sext.w	a0,s1
    8000481a:	bb15                	j	8000454e <exec+0x98>
    8000481c:	e1243423          	sd	s2,-504(s0)
    proc_freepagetable(pagetable, sz);
    80004820:	e0843583          	ld	a1,-504(s0)
    80004824:	855a                	mv	a0,s6
    80004826:	ffffd097          	auipc	ra,0xffffd
    8000482a:	95c080e7          	jalr	-1700(ra) # 80001182 <proc_freepagetable>
  return -1;
    8000482e:	557d                	li	a0,-1
  if(ip){
    80004830:	d00a0fe3          	beqz	s4,8000454e <exec+0x98>
    80004834:	b319                	j	8000453a <exec+0x84>
    80004836:	e1243423          	sd	s2,-504(s0)
    8000483a:	b7dd                	j	80004820 <exec+0x36a>
    8000483c:	e1243423          	sd	s2,-504(s0)
    80004840:	b7c5                	j	80004820 <exec+0x36a>
    80004842:	e1243423          	sd	s2,-504(s0)
    80004846:	bfe9                	j	80004820 <exec+0x36a>
    80004848:	e1243423          	sd	s2,-504(s0)
    8000484c:	bfd1                	j	80004820 <exec+0x36a>
  ip = 0;
    8000484e:	4a01                	li	s4,0
    80004850:	bfc1                	j	80004820 <exec+0x36a>
    80004852:	4a01                	li	s4,0
  if(pagetable)
    80004854:	b7f1                	j	80004820 <exec+0x36a>
  sz = sz1;
    80004856:	e0843983          	ld	s3,-504(s0)
    8000485a:	b569                	j	800046e4 <exec+0x22e>

000000008000485c <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    8000485c:	7179                	add	sp,sp,-48
    8000485e:	f406                	sd	ra,40(sp)
    80004860:	f022                	sd	s0,32(sp)
    80004862:	ec26                	sd	s1,24(sp)
    80004864:	e84a                	sd	s2,16(sp)
    80004866:	1800                	add	s0,sp,48
    80004868:	892e                	mv	s2,a1
    8000486a:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    8000486c:	fdc40593          	add	a1,s0,-36
    80004870:	ffffe097          	auipc	ra,0xffffe
    80004874:	a1e080e7          	jalr	-1506(ra) # 8000228e <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80004878:	fdc42703          	lw	a4,-36(s0)
    8000487c:	47bd                	li	a5,15
    8000487e:	02e7eb63          	bltu	a5,a4,800048b4 <argfd+0x58>
    80004882:	ffffc097          	auipc	ra,0xffffc
    80004886:	748080e7          	jalr	1864(ra) # 80000fca <myproc>
    8000488a:	fdc42703          	lw	a4,-36(s0)
    8000488e:	01a70793          	add	a5,a4,26
    80004892:	078e                	sll	a5,a5,0x3
    80004894:	953e                	add	a0,a0,a5
    80004896:	651c                	ld	a5,8(a0)
    80004898:	c385                	beqz	a5,800048b8 <argfd+0x5c>
    return -1;
  if(pfd)
    8000489a:	00090463          	beqz	s2,800048a2 <argfd+0x46>
    *pfd = fd;
    8000489e:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    800048a2:	4501                	li	a0,0
  if(pf)
    800048a4:	c091                	beqz	s1,800048a8 <argfd+0x4c>
    *pf = f;
    800048a6:	e09c                	sd	a5,0(s1)
}
    800048a8:	70a2                	ld	ra,40(sp)
    800048aa:	7402                	ld	s0,32(sp)
    800048ac:	64e2                	ld	s1,24(sp)
    800048ae:	6942                	ld	s2,16(sp)
    800048b0:	6145                	add	sp,sp,48
    800048b2:	8082                	ret
    return -1;
    800048b4:	557d                	li	a0,-1
    800048b6:	bfcd                	j	800048a8 <argfd+0x4c>
    800048b8:	557d                	li	a0,-1
    800048ba:	b7fd                	j	800048a8 <argfd+0x4c>

00000000800048bc <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    800048bc:	1101                	add	sp,sp,-32
    800048be:	ec06                	sd	ra,24(sp)
    800048c0:	e822                	sd	s0,16(sp)
    800048c2:	e426                	sd	s1,8(sp)
    800048c4:	1000                	add	s0,sp,32
    800048c6:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    800048c8:	ffffc097          	auipc	ra,0xffffc
    800048cc:	702080e7          	jalr	1794(ra) # 80000fca <myproc>
    800048d0:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    800048d2:	0d850793          	add	a5,a0,216
    800048d6:	4501                	li	a0,0
    800048d8:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    800048da:	6398                	ld	a4,0(a5)
    800048dc:	cb19                	beqz	a4,800048f2 <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    800048de:	2505                	addw	a0,a0,1
    800048e0:	07a1                	add	a5,a5,8
    800048e2:	fed51ce3          	bne	a0,a3,800048da <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    800048e6:	557d                	li	a0,-1
}
    800048e8:	60e2                	ld	ra,24(sp)
    800048ea:	6442                	ld	s0,16(sp)
    800048ec:	64a2                	ld	s1,8(sp)
    800048ee:	6105                	add	sp,sp,32
    800048f0:	8082                	ret
      p->ofile[fd] = f;
    800048f2:	01a50793          	add	a5,a0,26
    800048f6:	078e                	sll	a5,a5,0x3
    800048f8:	963e                	add	a2,a2,a5
    800048fa:	e604                	sd	s1,8(a2)
      return fd;
    800048fc:	b7f5                	j	800048e8 <fdalloc+0x2c>

00000000800048fe <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    800048fe:	715d                	add	sp,sp,-80
    80004900:	e486                	sd	ra,72(sp)
    80004902:	e0a2                	sd	s0,64(sp)
    80004904:	fc26                	sd	s1,56(sp)
    80004906:	f84a                	sd	s2,48(sp)
    80004908:	f44e                	sd	s3,40(sp)
    8000490a:	f052                	sd	s4,32(sp)
    8000490c:	ec56                	sd	s5,24(sp)
    8000490e:	e85a                	sd	s6,16(sp)
    80004910:	0880                	add	s0,sp,80
    80004912:	8b2e                	mv	s6,a1
    80004914:	89b2                	mv	s3,a2
    80004916:	8936                	mv	s2,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80004918:	fb040593          	add	a1,s0,-80
    8000491c:	fffff097          	auipc	ra,0xfffff
    80004920:	e7e080e7          	jalr	-386(ra) # 8000379a <nameiparent>
    80004924:	84aa                	mv	s1,a0
    80004926:	14050b63          	beqz	a0,80004a7c <create+0x17e>
    return 0;

  ilock(dp);
    8000492a:	ffffe097          	auipc	ra,0xffffe
    8000492e:	6ac080e7          	jalr	1708(ra) # 80002fd6 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80004932:	4601                	li	a2,0
    80004934:	fb040593          	add	a1,s0,-80
    80004938:	8526                	mv	a0,s1
    8000493a:	fffff097          	auipc	ra,0xfffff
    8000493e:	b80080e7          	jalr	-1152(ra) # 800034ba <dirlookup>
    80004942:	8aaa                	mv	s5,a0
    80004944:	c921                	beqz	a0,80004994 <create+0x96>
    iunlockput(dp);
    80004946:	8526                	mv	a0,s1
    80004948:	fffff097          	auipc	ra,0xfffff
    8000494c:	8f0080e7          	jalr	-1808(ra) # 80003238 <iunlockput>
    ilock(ip);
    80004950:	8556                	mv	a0,s5
    80004952:	ffffe097          	auipc	ra,0xffffe
    80004956:	684080e7          	jalr	1668(ra) # 80002fd6 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    8000495a:	4789                	li	a5,2
    8000495c:	02fb1563          	bne	s6,a5,80004986 <create+0x88>
    80004960:	044ad783          	lhu	a5,68(s5)
    80004964:	37f9                	addw	a5,a5,-2
    80004966:	17c2                	sll	a5,a5,0x30
    80004968:	93c1                	srl	a5,a5,0x30
    8000496a:	4705                	li	a4,1
    8000496c:	00f76d63          	bltu	a4,a5,80004986 <create+0x88>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    80004970:	8556                	mv	a0,s5
    80004972:	60a6                	ld	ra,72(sp)
    80004974:	6406                	ld	s0,64(sp)
    80004976:	74e2                	ld	s1,56(sp)
    80004978:	7942                	ld	s2,48(sp)
    8000497a:	79a2                	ld	s3,40(sp)
    8000497c:	7a02                	ld	s4,32(sp)
    8000497e:	6ae2                	ld	s5,24(sp)
    80004980:	6b42                	ld	s6,16(sp)
    80004982:	6161                	add	sp,sp,80
    80004984:	8082                	ret
    iunlockput(ip);
    80004986:	8556                	mv	a0,s5
    80004988:	fffff097          	auipc	ra,0xfffff
    8000498c:	8b0080e7          	jalr	-1872(ra) # 80003238 <iunlockput>
    return 0;
    80004990:	4a81                	li	s5,0
    80004992:	bff9                	j	80004970 <create+0x72>
  if((ip = ialloc(dp->dev, type)) == 0){
    80004994:	85da                	mv	a1,s6
    80004996:	4088                	lw	a0,0(s1)
    80004998:	ffffe097          	auipc	ra,0xffffe
    8000499c:	4a6080e7          	jalr	1190(ra) # 80002e3e <ialloc>
    800049a0:	8a2a                	mv	s4,a0
    800049a2:	c529                	beqz	a0,800049ec <create+0xee>
  ilock(ip);
    800049a4:	ffffe097          	auipc	ra,0xffffe
    800049a8:	632080e7          	jalr	1586(ra) # 80002fd6 <ilock>
  ip->major = major;
    800049ac:	053a1323          	sh	s3,70(s4)
  ip->minor = minor;
    800049b0:	052a1423          	sh	s2,72(s4)
  ip->nlink = 1;
    800049b4:	4905                	li	s2,1
    800049b6:	052a1523          	sh	s2,74(s4)
  iupdate(ip);
    800049ba:	8552                	mv	a0,s4
    800049bc:	ffffe097          	auipc	ra,0xffffe
    800049c0:	54e080e7          	jalr	1358(ra) # 80002f0a <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    800049c4:	032b0b63          	beq	s6,s2,800049fa <create+0xfc>
  if(dirlink(dp, name, ip->inum) < 0)
    800049c8:	004a2603          	lw	a2,4(s4)
    800049cc:	fb040593          	add	a1,s0,-80
    800049d0:	8526                	mv	a0,s1
    800049d2:	fffff097          	auipc	ra,0xfffff
    800049d6:	cf8080e7          	jalr	-776(ra) # 800036ca <dirlink>
    800049da:	06054f63          	bltz	a0,80004a58 <create+0x15a>
  iunlockput(dp);
    800049de:	8526                	mv	a0,s1
    800049e0:	fffff097          	auipc	ra,0xfffff
    800049e4:	858080e7          	jalr	-1960(ra) # 80003238 <iunlockput>
  return ip;
    800049e8:	8ad2                	mv	s5,s4
    800049ea:	b759                	j	80004970 <create+0x72>
    iunlockput(dp);
    800049ec:	8526                	mv	a0,s1
    800049ee:	fffff097          	auipc	ra,0xfffff
    800049f2:	84a080e7          	jalr	-1974(ra) # 80003238 <iunlockput>
    return 0;
    800049f6:	8ad2                	mv	s5,s4
    800049f8:	bfa5                	j	80004970 <create+0x72>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    800049fa:	004a2603          	lw	a2,4(s4)
    800049fe:	00004597          	auipc	a1,0x4
    80004a02:	e7a58593          	add	a1,a1,-390 # 80008878 <syscallnames+0x2b8>
    80004a06:	8552                	mv	a0,s4
    80004a08:	fffff097          	auipc	ra,0xfffff
    80004a0c:	cc2080e7          	jalr	-830(ra) # 800036ca <dirlink>
    80004a10:	04054463          	bltz	a0,80004a58 <create+0x15a>
    80004a14:	40d0                	lw	a2,4(s1)
    80004a16:	00003597          	auipc	a1,0x3
    80004a1a:	74258593          	add	a1,a1,1858 # 80008158 <etext+0x158>
    80004a1e:	8552                	mv	a0,s4
    80004a20:	fffff097          	auipc	ra,0xfffff
    80004a24:	caa080e7          	jalr	-854(ra) # 800036ca <dirlink>
    80004a28:	02054863          	bltz	a0,80004a58 <create+0x15a>
  if(dirlink(dp, name, ip->inum) < 0)
    80004a2c:	004a2603          	lw	a2,4(s4)
    80004a30:	fb040593          	add	a1,s0,-80
    80004a34:	8526                	mv	a0,s1
    80004a36:	fffff097          	auipc	ra,0xfffff
    80004a3a:	c94080e7          	jalr	-876(ra) # 800036ca <dirlink>
    80004a3e:	00054d63          	bltz	a0,80004a58 <create+0x15a>
    dp->nlink++;  // for ".."
    80004a42:	04a4d783          	lhu	a5,74(s1)
    80004a46:	2785                	addw	a5,a5,1
    80004a48:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004a4c:	8526                	mv	a0,s1
    80004a4e:	ffffe097          	auipc	ra,0xffffe
    80004a52:	4bc080e7          	jalr	1212(ra) # 80002f0a <iupdate>
    80004a56:	b761                	j	800049de <create+0xe0>
  ip->nlink = 0;
    80004a58:	040a1523          	sh	zero,74(s4)
  iupdate(ip);
    80004a5c:	8552                	mv	a0,s4
    80004a5e:	ffffe097          	auipc	ra,0xffffe
    80004a62:	4ac080e7          	jalr	1196(ra) # 80002f0a <iupdate>
  iunlockput(ip);
    80004a66:	8552                	mv	a0,s4
    80004a68:	ffffe097          	auipc	ra,0xffffe
    80004a6c:	7d0080e7          	jalr	2000(ra) # 80003238 <iunlockput>
  iunlockput(dp);
    80004a70:	8526                	mv	a0,s1
    80004a72:	ffffe097          	auipc	ra,0xffffe
    80004a76:	7c6080e7          	jalr	1990(ra) # 80003238 <iunlockput>
  return 0;
    80004a7a:	bddd                	j	80004970 <create+0x72>
    return 0;
    80004a7c:	8aaa                	mv	s5,a0
    80004a7e:	bdcd                	j	80004970 <create+0x72>

0000000080004a80 <sys_dup>:
{
    80004a80:	7179                	add	sp,sp,-48
    80004a82:	f406                	sd	ra,40(sp)
    80004a84:	f022                	sd	s0,32(sp)
    80004a86:	ec26                	sd	s1,24(sp)
    80004a88:	e84a                	sd	s2,16(sp)
    80004a8a:	1800                	add	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80004a8c:	fd840613          	add	a2,s0,-40
    80004a90:	4581                	li	a1,0
    80004a92:	4501                	li	a0,0
    80004a94:	00000097          	auipc	ra,0x0
    80004a98:	dc8080e7          	jalr	-568(ra) # 8000485c <argfd>
    return -1;
    80004a9c:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80004a9e:	02054363          	bltz	a0,80004ac4 <sys_dup+0x44>
  if((fd=fdalloc(f)) < 0)
    80004aa2:	fd843903          	ld	s2,-40(s0)
    80004aa6:	854a                	mv	a0,s2
    80004aa8:	00000097          	auipc	ra,0x0
    80004aac:	e14080e7          	jalr	-492(ra) # 800048bc <fdalloc>
    80004ab0:	84aa                	mv	s1,a0
    return -1;
    80004ab2:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    80004ab4:	00054863          	bltz	a0,80004ac4 <sys_dup+0x44>
  filedup(f);
    80004ab8:	854a                	mv	a0,s2
    80004aba:	fffff097          	auipc	ra,0xfffff
    80004abe:	334080e7          	jalr	820(ra) # 80003dee <filedup>
  return fd;
    80004ac2:	87a6                	mv	a5,s1
}
    80004ac4:	853e                	mv	a0,a5
    80004ac6:	70a2                	ld	ra,40(sp)
    80004ac8:	7402                	ld	s0,32(sp)
    80004aca:	64e2                	ld	s1,24(sp)
    80004acc:	6942                	ld	s2,16(sp)
    80004ace:	6145                	add	sp,sp,48
    80004ad0:	8082                	ret

0000000080004ad2 <sys_read>:
{
    80004ad2:	7179                	add	sp,sp,-48
    80004ad4:	f406                	sd	ra,40(sp)
    80004ad6:	f022                	sd	s0,32(sp)
    80004ad8:	1800                	add	s0,sp,48
  argaddr(1, &p);
    80004ada:	fd840593          	add	a1,s0,-40
    80004ade:	4505                	li	a0,1
    80004ae0:	ffffd097          	auipc	ra,0xffffd
    80004ae4:	7ce080e7          	jalr	1998(ra) # 800022ae <argaddr>
  argint(2, &n);
    80004ae8:	fe440593          	add	a1,s0,-28
    80004aec:	4509                	li	a0,2
    80004aee:	ffffd097          	auipc	ra,0xffffd
    80004af2:	7a0080e7          	jalr	1952(ra) # 8000228e <argint>
  if(argfd(0, 0, &f) < 0)
    80004af6:	fe840613          	add	a2,s0,-24
    80004afa:	4581                	li	a1,0
    80004afc:	4501                	li	a0,0
    80004afe:	00000097          	auipc	ra,0x0
    80004b02:	d5e080e7          	jalr	-674(ra) # 8000485c <argfd>
    80004b06:	87aa                	mv	a5,a0
    return -1;
    80004b08:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80004b0a:	0007cc63          	bltz	a5,80004b22 <sys_read+0x50>
  return fileread(f, p, n);
    80004b0e:	fe442603          	lw	a2,-28(s0)
    80004b12:	fd843583          	ld	a1,-40(s0)
    80004b16:	fe843503          	ld	a0,-24(s0)
    80004b1a:	fffff097          	auipc	ra,0xfffff
    80004b1e:	460080e7          	jalr	1120(ra) # 80003f7a <fileread>
}
    80004b22:	70a2                	ld	ra,40(sp)
    80004b24:	7402                	ld	s0,32(sp)
    80004b26:	6145                	add	sp,sp,48
    80004b28:	8082                	ret

0000000080004b2a <sys_write>:
{
    80004b2a:	7179                	add	sp,sp,-48
    80004b2c:	f406                	sd	ra,40(sp)
    80004b2e:	f022                	sd	s0,32(sp)
    80004b30:	1800                	add	s0,sp,48
  argaddr(1, &p);
    80004b32:	fd840593          	add	a1,s0,-40
    80004b36:	4505                	li	a0,1
    80004b38:	ffffd097          	auipc	ra,0xffffd
    80004b3c:	776080e7          	jalr	1910(ra) # 800022ae <argaddr>
  argint(2, &n);
    80004b40:	fe440593          	add	a1,s0,-28
    80004b44:	4509                	li	a0,2
    80004b46:	ffffd097          	auipc	ra,0xffffd
    80004b4a:	748080e7          	jalr	1864(ra) # 8000228e <argint>
  if(argfd(0, 0, &f) < 0)
    80004b4e:	fe840613          	add	a2,s0,-24
    80004b52:	4581                	li	a1,0
    80004b54:	4501                	li	a0,0
    80004b56:	00000097          	auipc	ra,0x0
    80004b5a:	d06080e7          	jalr	-762(ra) # 8000485c <argfd>
    80004b5e:	87aa                	mv	a5,a0
    return -1;
    80004b60:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80004b62:	0007cc63          	bltz	a5,80004b7a <sys_write+0x50>
  return filewrite(f, p, n);
    80004b66:	fe442603          	lw	a2,-28(s0)
    80004b6a:	fd843583          	ld	a1,-40(s0)
    80004b6e:	fe843503          	ld	a0,-24(s0)
    80004b72:	fffff097          	auipc	ra,0xfffff
    80004b76:	4ca080e7          	jalr	1226(ra) # 8000403c <filewrite>
}
    80004b7a:	70a2                	ld	ra,40(sp)
    80004b7c:	7402                	ld	s0,32(sp)
    80004b7e:	6145                	add	sp,sp,48
    80004b80:	8082                	ret

0000000080004b82 <sys_close>:
{
    80004b82:	1101                	add	sp,sp,-32
    80004b84:	ec06                	sd	ra,24(sp)
    80004b86:	e822                	sd	s0,16(sp)
    80004b88:	1000                	add	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    80004b8a:	fe040613          	add	a2,s0,-32
    80004b8e:	fec40593          	add	a1,s0,-20
    80004b92:	4501                	li	a0,0
    80004b94:	00000097          	auipc	ra,0x0
    80004b98:	cc8080e7          	jalr	-824(ra) # 8000485c <argfd>
    return -1;
    80004b9c:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80004b9e:	02054463          	bltz	a0,80004bc6 <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    80004ba2:	ffffc097          	auipc	ra,0xffffc
    80004ba6:	428080e7          	jalr	1064(ra) # 80000fca <myproc>
    80004baa:	fec42783          	lw	a5,-20(s0)
    80004bae:	07e9                	add	a5,a5,26
    80004bb0:	078e                	sll	a5,a5,0x3
    80004bb2:	953e                	add	a0,a0,a5
    80004bb4:	00053423          	sd	zero,8(a0)
  fileclose(f);
    80004bb8:	fe043503          	ld	a0,-32(s0)
    80004bbc:	fffff097          	auipc	ra,0xfffff
    80004bc0:	284080e7          	jalr	644(ra) # 80003e40 <fileclose>
  return 0;
    80004bc4:	4781                	li	a5,0
}
    80004bc6:	853e                	mv	a0,a5
    80004bc8:	60e2                	ld	ra,24(sp)
    80004bca:	6442                	ld	s0,16(sp)
    80004bcc:	6105                	add	sp,sp,32
    80004bce:	8082                	ret

0000000080004bd0 <sys_fstat>:
{
    80004bd0:	1101                	add	sp,sp,-32
    80004bd2:	ec06                	sd	ra,24(sp)
    80004bd4:	e822                	sd	s0,16(sp)
    80004bd6:	1000                	add	s0,sp,32
  argaddr(1, &st);
    80004bd8:	fe040593          	add	a1,s0,-32
    80004bdc:	4505                	li	a0,1
    80004bde:	ffffd097          	auipc	ra,0xffffd
    80004be2:	6d0080e7          	jalr	1744(ra) # 800022ae <argaddr>
  if(argfd(0, 0, &f) < 0)
    80004be6:	fe840613          	add	a2,s0,-24
    80004bea:	4581                	li	a1,0
    80004bec:	4501                	li	a0,0
    80004bee:	00000097          	auipc	ra,0x0
    80004bf2:	c6e080e7          	jalr	-914(ra) # 8000485c <argfd>
    80004bf6:	87aa                	mv	a5,a0
    return -1;
    80004bf8:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80004bfa:	0007ca63          	bltz	a5,80004c0e <sys_fstat+0x3e>
  return filestat(f, st);
    80004bfe:	fe043583          	ld	a1,-32(s0)
    80004c02:	fe843503          	ld	a0,-24(s0)
    80004c06:	fffff097          	auipc	ra,0xfffff
    80004c0a:	302080e7          	jalr	770(ra) # 80003f08 <filestat>
}
    80004c0e:	60e2                	ld	ra,24(sp)
    80004c10:	6442                	ld	s0,16(sp)
    80004c12:	6105                	add	sp,sp,32
    80004c14:	8082                	ret

0000000080004c16 <sys_link>:
{
    80004c16:	7169                	add	sp,sp,-304
    80004c18:	f606                	sd	ra,296(sp)
    80004c1a:	f222                	sd	s0,288(sp)
    80004c1c:	ee26                	sd	s1,280(sp)
    80004c1e:	ea4a                	sd	s2,272(sp)
    80004c20:	1a00                	add	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004c22:	08000613          	li	a2,128
    80004c26:	ed040593          	add	a1,s0,-304
    80004c2a:	4501                	li	a0,0
    80004c2c:	ffffd097          	auipc	ra,0xffffd
    80004c30:	6a2080e7          	jalr	1698(ra) # 800022ce <argstr>
    return -1;
    80004c34:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004c36:	10054e63          	bltz	a0,80004d52 <sys_link+0x13c>
    80004c3a:	08000613          	li	a2,128
    80004c3e:	f5040593          	add	a1,s0,-176
    80004c42:	4505                	li	a0,1
    80004c44:	ffffd097          	auipc	ra,0xffffd
    80004c48:	68a080e7          	jalr	1674(ra) # 800022ce <argstr>
    return -1;
    80004c4c:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004c4e:	10054263          	bltz	a0,80004d52 <sys_link+0x13c>
  begin_op();
    80004c52:	fffff097          	auipc	ra,0xfffff
    80004c56:	d2a080e7          	jalr	-726(ra) # 8000397c <begin_op>
  if((ip = namei(old)) == 0){
    80004c5a:	ed040513          	add	a0,s0,-304
    80004c5e:	fffff097          	auipc	ra,0xfffff
    80004c62:	b1e080e7          	jalr	-1250(ra) # 8000377c <namei>
    80004c66:	84aa                	mv	s1,a0
    80004c68:	c551                	beqz	a0,80004cf4 <sys_link+0xde>
  ilock(ip);
    80004c6a:	ffffe097          	auipc	ra,0xffffe
    80004c6e:	36c080e7          	jalr	876(ra) # 80002fd6 <ilock>
  if(ip->type == T_DIR){
    80004c72:	04449703          	lh	a4,68(s1)
    80004c76:	4785                	li	a5,1
    80004c78:	08f70463          	beq	a4,a5,80004d00 <sys_link+0xea>
  ip->nlink++;
    80004c7c:	04a4d783          	lhu	a5,74(s1)
    80004c80:	2785                	addw	a5,a5,1
    80004c82:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004c86:	8526                	mv	a0,s1
    80004c88:	ffffe097          	auipc	ra,0xffffe
    80004c8c:	282080e7          	jalr	642(ra) # 80002f0a <iupdate>
  iunlock(ip);
    80004c90:	8526                	mv	a0,s1
    80004c92:	ffffe097          	auipc	ra,0xffffe
    80004c96:	406080e7          	jalr	1030(ra) # 80003098 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80004c9a:	fd040593          	add	a1,s0,-48
    80004c9e:	f5040513          	add	a0,s0,-176
    80004ca2:	fffff097          	auipc	ra,0xfffff
    80004ca6:	af8080e7          	jalr	-1288(ra) # 8000379a <nameiparent>
    80004caa:	892a                	mv	s2,a0
    80004cac:	c935                	beqz	a0,80004d20 <sys_link+0x10a>
  ilock(dp);
    80004cae:	ffffe097          	auipc	ra,0xffffe
    80004cb2:	328080e7          	jalr	808(ra) # 80002fd6 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80004cb6:	00092703          	lw	a4,0(s2)
    80004cba:	409c                	lw	a5,0(s1)
    80004cbc:	04f71d63          	bne	a4,a5,80004d16 <sys_link+0x100>
    80004cc0:	40d0                	lw	a2,4(s1)
    80004cc2:	fd040593          	add	a1,s0,-48
    80004cc6:	854a                	mv	a0,s2
    80004cc8:	fffff097          	auipc	ra,0xfffff
    80004ccc:	a02080e7          	jalr	-1534(ra) # 800036ca <dirlink>
    80004cd0:	04054363          	bltz	a0,80004d16 <sys_link+0x100>
  iunlockput(dp);
    80004cd4:	854a                	mv	a0,s2
    80004cd6:	ffffe097          	auipc	ra,0xffffe
    80004cda:	562080e7          	jalr	1378(ra) # 80003238 <iunlockput>
  iput(ip);
    80004cde:	8526                	mv	a0,s1
    80004ce0:	ffffe097          	auipc	ra,0xffffe
    80004ce4:	4b0080e7          	jalr	1200(ra) # 80003190 <iput>
  end_op();
    80004ce8:	fffff097          	auipc	ra,0xfffff
    80004cec:	d0e080e7          	jalr	-754(ra) # 800039f6 <end_op>
  return 0;
    80004cf0:	4781                	li	a5,0
    80004cf2:	a085                	j	80004d52 <sys_link+0x13c>
    end_op();
    80004cf4:	fffff097          	auipc	ra,0xfffff
    80004cf8:	d02080e7          	jalr	-766(ra) # 800039f6 <end_op>
    return -1;
    80004cfc:	57fd                	li	a5,-1
    80004cfe:	a891                	j	80004d52 <sys_link+0x13c>
    iunlockput(ip);
    80004d00:	8526                	mv	a0,s1
    80004d02:	ffffe097          	auipc	ra,0xffffe
    80004d06:	536080e7          	jalr	1334(ra) # 80003238 <iunlockput>
    end_op();
    80004d0a:	fffff097          	auipc	ra,0xfffff
    80004d0e:	cec080e7          	jalr	-788(ra) # 800039f6 <end_op>
    return -1;
    80004d12:	57fd                	li	a5,-1
    80004d14:	a83d                	j	80004d52 <sys_link+0x13c>
    iunlockput(dp);
    80004d16:	854a                	mv	a0,s2
    80004d18:	ffffe097          	auipc	ra,0xffffe
    80004d1c:	520080e7          	jalr	1312(ra) # 80003238 <iunlockput>
  ilock(ip);
    80004d20:	8526                	mv	a0,s1
    80004d22:	ffffe097          	auipc	ra,0xffffe
    80004d26:	2b4080e7          	jalr	692(ra) # 80002fd6 <ilock>
  ip->nlink--;
    80004d2a:	04a4d783          	lhu	a5,74(s1)
    80004d2e:	37fd                	addw	a5,a5,-1
    80004d30:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004d34:	8526                	mv	a0,s1
    80004d36:	ffffe097          	auipc	ra,0xffffe
    80004d3a:	1d4080e7          	jalr	468(ra) # 80002f0a <iupdate>
  iunlockput(ip);
    80004d3e:	8526                	mv	a0,s1
    80004d40:	ffffe097          	auipc	ra,0xffffe
    80004d44:	4f8080e7          	jalr	1272(ra) # 80003238 <iunlockput>
  end_op();
    80004d48:	fffff097          	auipc	ra,0xfffff
    80004d4c:	cae080e7          	jalr	-850(ra) # 800039f6 <end_op>
  return -1;
    80004d50:	57fd                	li	a5,-1
}
    80004d52:	853e                	mv	a0,a5
    80004d54:	70b2                	ld	ra,296(sp)
    80004d56:	7412                	ld	s0,288(sp)
    80004d58:	64f2                	ld	s1,280(sp)
    80004d5a:	6952                	ld	s2,272(sp)
    80004d5c:	6155                	add	sp,sp,304
    80004d5e:	8082                	ret

0000000080004d60 <sys_unlink>:
{
    80004d60:	7151                	add	sp,sp,-240
    80004d62:	f586                	sd	ra,232(sp)
    80004d64:	f1a2                	sd	s0,224(sp)
    80004d66:	eda6                	sd	s1,216(sp)
    80004d68:	e9ca                	sd	s2,208(sp)
    80004d6a:	e5ce                	sd	s3,200(sp)
    80004d6c:	1980                	add	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80004d6e:	08000613          	li	a2,128
    80004d72:	f3040593          	add	a1,s0,-208
    80004d76:	4501                	li	a0,0
    80004d78:	ffffd097          	auipc	ra,0xffffd
    80004d7c:	556080e7          	jalr	1366(ra) # 800022ce <argstr>
    80004d80:	18054163          	bltz	a0,80004f02 <sys_unlink+0x1a2>
  begin_op();
    80004d84:	fffff097          	auipc	ra,0xfffff
    80004d88:	bf8080e7          	jalr	-1032(ra) # 8000397c <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80004d8c:	fb040593          	add	a1,s0,-80
    80004d90:	f3040513          	add	a0,s0,-208
    80004d94:	fffff097          	auipc	ra,0xfffff
    80004d98:	a06080e7          	jalr	-1530(ra) # 8000379a <nameiparent>
    80004d9c:	84aa                	mv	s1,a0
    80004d9e:	c979                	beqz	a0,80004e74 <sys_unlink+0x114>
  ilock(dp);
    80004da0:	ffffe097          	auipc	ra,0xffffe
    80004da4:	236080e7          	jalr	566(ra) # 80002fd6 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80004da8:	00004597          	auipc	a1,0x4
    80004dac:	ad058593          	add	a1,a1,-1328 # 80008878 <syscallnames+0x2b8>
    80004db0:	fb040513          	add	a0,s0,-80
    80004db4:	ffffe097          	auipc	ra,0xffffe
    80004db8:	6ec080e7          	jalr	1772(ra) # 800034a0 <namecmp>
    80004dbc:	14050a63          	beqz	a0,80004f10 <sys_unlink+0x1b0>
    80004dc0:	00003597          	auipc	a1,0x3
    80004dc4:	39858593          	add	a1,a1,920 # 80008158 <etext+0x158>
    80004dc8:	fb040513          	add	a0,s0,-80
    80004dcc:	ffffe097          	auipc	ra,0xffffe
    80004dd0:	6d4080e7          	jalr	1748(ra) # 800034a0 <namecmp>
    80004dd4:	12050e63          	beqz	a0,80004f10 <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    80004dd8:	f2c40613          	add	a2,s0,-212
    80004ddc:	fb040593          	add	a1,s0,-80
    80004de0:	8526                	mv	a0,s1
    80004de2:	ffffe097          	auipc	ra,0xffffe
    80004de6:	6d8080e7          	jalr	1752(ra) # 800034ba <dirlookup>
    80004dea:	892a                	mv	s2,a0
    80004dec:	12050263          	beqz	a0,80004f10 <sys_unlink+0x1b0>
  ilock(ip);
    80004df0:	ffffe097          	auipc	ra,0xffffe
    80004df4:	1e6080e7          	jalr	486(ra) # 80002fd6 <ilock>
  if(ip->nlink < 1)
    80004df8:	04a91783          	lh	a5,74(s2)
    80004dfc:	08f05263          	blez	a5,80004e80 <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004e00:	04491703          	lh	a4,68(s2)
    80004e04:	4785                	li	a5,1
    80004e06:	08f70563          	beq	a4,a5,80004e90 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    80004e0a:	4641                	li	a2,16
    80004e0c:	4581                	li	a1,0
    80004e0e:	fc040513          	add	a0,s0,-64
    80004e12:	ffffb097          	auipc	ra,0xffffb
    80004e16:	3b2080e7          	jalr	946(ra) # 800001c4 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004e1a:	4741                	li	a4,16
    80004e1c:	f2c42683          	lw	a3,-212(s0)
    80004e20:	fc040613          	add	a2,s0,-64
    80004e24:	4581                	li	a1,0
    80004e26:	8526                	mv	a0,s1
    80004e28:	ffffe097          	auipc	ra,0xffffe
    80004e2c:	55a080e7          	jalr	1370(ra) # 80003382 <writei>
    80004e30:	47c1                	li	a5,16
    80004e32:	0af51563          	bne	a0,a5,80004edc <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    80004e36:	04491703          	lh	a4,68(s2)
    80004e3a:	4785                	li	a5,1
    80004e3c:	0af70863          	beq	a4,a5,80004eec <sys_unlink+0x18c>
  iunlockput(dp);
    80004e40:	8526                	mv	a0,s1
    80004e42:	ffffe097          	auipc	ra,0xffffe
    80004e46:	3f6080e7          	jalr	1014(ra) # 80003238 <iunlockput>
  ip->nlink--;
    80004e4a:	04a95783          	lhu	a5,74(s2)
    80004e4e:	37fd                	addw	a5,a5,-1
    80004e50:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80004e54:	854a                	mv	a0,s2
    80004e56:	ffffe097          	auipc	ra,0xffffe
    80004e5a:	0b4080e7          	jalr	180(ra) # 80002f0a <iupdate>
  iunlockput(ip);
    80004e5e:	854a                	mv	a0,s2
    80004e60:	ffffe097          	auipc	ra,0xffffe
    80004e64:	3d8080e7          	jalr	984(ra) # 80003238 <iunlockput>
  end_op();
    80004e68:	fffff097          	auipc	ra,0xfffff
    80004e6c:	b8e080e7          	jalr	-1138(ra) # 800039f6 <end_op>
  return 0;
    80004e70:	4501                	li	a0,0
    80004e72:	a84d                	j	80004f24 <sys_unlink+0x1c4>
    end_op();
    80004e74:	fffff097          	auipc	ra,0xfffff
    80004e78:	b82080e7          	jalr	-1150(ra) # 800039f6 <end_op>
    return -1;
    80004e7c:	557d                	li	a0,-1
    80004e7e:	a05d                	j	80004f24 <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    80004e80:	00004517          	auipc	a0,0x4
    80004e84:	a0050513          	add	a0,a0,-1536 # 80008880 <syscallnames+0x2c0>
    80004e88:	00001097          	auipc	ra,0x1
    80004e8c:	258080e7          	jalr	600(ra) # 800060e0 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004e90:	04c92703          	lw	a4,76(s2)
    80004e94:	02000793          	li	a5,32
    80004e98:	f6e7f9e3          	bgeu	a5,a4,80004e0a <sys_unlink+0xaa>
    80004e9c:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004ea0:	4741                	li	a4,16
    80004ea2:	86ce                	mv	a3,s3
    80004ea4:	f1840613          	add	a2,s0,-232
    80004ea8:	4581                	li	a1,0
    80004eaa:	854a                	mv	a0,s2
    80004eac:	ffffe097          	auipc	ra,0xffffe
    80004eb0:	3de080e7          	jalr	990(ra) # 8000328a <readi>
    80004eb4:	47c1                	li	a5,16
    80004eb6:	00f51b63          	bne	a0,a5,80004ecc <sys_unlink+0x16c>
    if(de.inum != 0)
    80004eba:	f1845783          	lhu	a5,-232(s0)
    80004ebe:	e7a1                	bnez	a5,80004f06 <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004ec0:	29c1                	addw	s3,s3,16
    80004ec2:	04c92783          	lw	a5,76(s2)
    80004ec6:	fcf9ede3          	bltu	s3,a5,80004ea0 <sys_unlink+0x140>
    80004eca:	b781                	j	80004e0a <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80004ecc:	00004517          	auipc	a0,0x4
    80004ed0:	9cc50513          	add	a0,a0,-1588 # 80008898 <syscallnames+0x2d8>
    80004ed4:	00001097          	auipc	ra,0x1
    80004ed8:	20c080e7          	jalr	524(ra) # 800060e0 <panic>
    panic("unlink: writei");
    80004edc:	00004517          	auipc	a0,0x4
    80004ee0:	9d450513          	add	a0,a0,-1580 # 800088b0 <syscallnames+0x2f0>
    80004ee4:	00001097          	auipc	ra,0x1
    80004ee8:	1fc080e7          	jalr	508(ra) # 800060e0 <panic>
    dp->nlink--;
    80004eec:	04a4d783          	lhu	a5,74(s1)
    80004ef0:	37fd                	addw	a5,a5,-1
    80004ef2:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004ef6:	8526                	mv	a0,s1
    80004ef8:	ffffe097          	auipc	ra,0xffffe
    80004efc:	012080e7          	jalr	18(ra) # 80002f0a <iupdate>
    80004f00:	b781                	j	80004e40 <sys_unlink+0xe0>
    return -1;
    80004f02:	557d                	li	a0,-1
    80004f04:	a005                	j	80004f24 <sys_unlink+0x1c4>
    iunlockput(ip);
    80004f06:	854a                	mv	a0,s2
    80004f08:	ffffe097          	auipc	ra,0xffffe
    80004f0c:	330080e7          	jalr	816(ra) # 80003238 <iunlockput>
  iunlockput(dp);
    80004f10:	8526                	mv	a0,s1
    80004f12:	ffffe097          	auipc	ra,0xffffe
    80004f16:	326080e7          	jalr	806(ra) # 80003238 <iunlockput>
  end_op();
    80004f1a:	fffff097          	auipc	ra,0xfffff
    80004f1e:	adc080e7          	jalr	-1316(ra) # 800039f6 <end_op>
  return -1;
    80004f22:	557d                	li	a0,-1
}
    80004f24:	70ae                	ld	ra,232(sp)
    80004f26:	740e                	ld	s0,224(sp)
    80004f28:	64ee                	ld	s1,216(sp)
    80004f2a:	694e                	ld	s2,208(sp)
    80004f2c:	69ae                	ld	s3,200(sp)
    80004f2e:	616d                	add	sp,sp,240
    80004f30:	8082                	ret

0000000080004f32 <sys_open>:

uint64
sys_open(void)
{
    80004f32:	7131                	add	sp,sp,-192
    80004f34:	fd06                	sd	ra,184(sp)
    80004f36:	f922                	sd	s0,176(sp)
    80004f38:	f526                	sd	s1,168(sp)
    80004f3a:	f14a                	sd	s2,160(sp)
    80004f3c:	ed4e                	sd	s3,152(sp)
    80004f3e:	0180                	add	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    80004f40:	f4c40593          	add	a1,s0,-180
    80004f44:	4505                	li	a0,1
    80004f46:	ffffd097          	auipc	ra,0xffffd
    80004f4a:	348080e7          	jalr	840(ra) # 8000228e <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004f4e:	08000613          	li	a2,128
    80004f52:	f5040593          	add	a1,s0,-176
    80004f56:	4501                	li	a0,0
    80004f58:	ffffd097          	auipc	ra,0xffffd
    80004f5c:	376080e7          	jalr	886(ra) # 800022ce <argstr>
    80004f60:	87aa                	mv	a5,a0
    return -1;
    80004f62:	557d                	li	a0,-1
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004f64:	0a07c863          	bltz	a5,80005014 <sys_open+0xe2>

  begin_op();
    80004f68:	fffff097          	auipc	ra,0xfffff
    80004f6c:	a14080e7          	jalr	-1516(ra) # 8000397c <begin_op>

  if(omode & O_CREATE){
    80004f70:	f4c42783          	lw	a5,-180(s0)
    80004f74:	2007f793          	and	a5,a5,512
    80004f78:	cbdd                	beqz	a5,8000502e <sys_open+0xfc>
    ip = create(path, T_FILE, 0, 0);
    80004f7a:	4681                	li	a3,0
    80004f7c:	4601                	li	a2,0
    80004f7e:	4589                	li	a1,2
    80004f80:	f5040513          	add	a0,s0,-176
    80004f84:	00000097          	auipc	ra,0x0
    80004f88:	97a080e7          	jalr	-1670(ra) # 800048fe <create>
    80004f8c:	84aa                	mv	s1,a0
    if(ip == 0){
    80004f8e:	c951                	beqz	a0,80005022 <sys_open+0xf0>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80004f90:	04449703          	lh	a4,68(s1)
    80004f94:	478d                	li	a5,3
    80004f96:	00f71763          	bne	a4,a5,80004fa4 <sys_open+0x72>
    80004f9a:	0464d703          	lhu	a4,70(s1)
    80004f9e:	47a5                	li	a5,9
    80004fa0:	0ce7ec63          	bltu	a5,a4,80005078 <sys_open+0x146>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004fa4:	fffff097          	auipc	ra,0xfffff
    80004fa8:	de0080e7          	jalr	-544(ra) # 80003d84 <filealloc>
    80004fac:	892a                	mv	s2,a0
    80004fae:	c56d                	beqz	a0,80005098 <sys_open+0x166>
    80004fb0:	00000097          	auipc	ra,0x0
    80004fb4:	90c080e7          	jalr	-1780(ra) # 800048bc <fdalloc>
    80004fb8:	89aa                	mv	s3,a0
    80004fba:	0c054a63          	bltz	a0,8000508e <sys_open+0x15c>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004fbe:	04449703          	lh	a4,68(s1)
    80004fc2:	478d                	li	a5,3
    80004fc4:	0ef70563          	beq	a4,a5,800050ae <sys_open+0x17c>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004fc8:	4789                	li	a5,2
    80004fca:	00f92023          	sw	a5,0(s2)
    f->off = 0;
    80004fce:	02092023          	sw	zero,32(s2)
  }
  f->ip = ip;
    80004fd2:	00993c23          	sd	s1,24(s2)
  f->readable = !(omode & O_WRONLY);
    80004fd6:	f4c42783          	lw	a5,-180(s0)
    80004fda:	0017c713          	xor	a4,a5,1
    80004fde:	8b05                	and	a4,a4,1
    80004fe0:	00e90423          	sb	a4,8(s2)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004fe4:	0037f713          	and	a4,a5,3
    80004fe8:	00e03733          	snez	a4,a4
    80004fec:	00e904a3          	sb	a4,9(s2)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004ff0:	4007f793          	and	a5,a5,1024
    80004ff4:	c791                	beqz	a5,80005000 <sys_open+0xce>
    80004ff6:	04449703          	lh	a4,68(s1)
    80004ffa:	4789                	li	a5,2
    80004ffc:	0cf70063          	beq	a4,a5,800050bc <sys_open+0x18a>
    itrunc(ip);
  }

  iunlock(ip);
    80005000:	8526                	mv	a0,s1
    80005002:	ffffe097          	auipc	ra,0xffffe
    80005006:	096080e7          	jalr	150(ra) # 80003098 <iunlock>
  end_op();
    8000500a:	fffff097          	auipc	ra,0xfffff
    8000500e:	9ec080e7          	jalr	-1556(ra) # 800039f6 <end_op>

  return fd;
    80005012:	854e                	mv	a0,s3
}
    80005014:	70ea                	ld	ra,184(sp)
    80005016:	744a                	ld	s0,176(sp)
    80005018:	74aa                	ld	s1,168(sp)
    8000501a:	790a                	ld	s2,160(sp)
    8000501c:	69ea                	ld	s3,152(sp)
    8000501e:	6129                	add	sp,sp,192
    80005020:	8082                	ret
      end_op();
    80005022:	fffff097          	auipc	ra,0xfffff
    80005026:	9d4080e7          	jalr	-1580(ra) # 800039f6 <end_op>
      return -1;
    8000502a:	557d                	li	a0,-1
    8000502c:	b7e5                	j	80005014 <sys_open+0xe2>
    if((ip = namei(path)) == 0){
    8000502e:	f5040513          	add	a0,s0,-176
    80005032:	ffffe097          	auipc	ra,0xffffe
    80005036:	74a080e7          	jalr	1866(ra) # 8000377c <namei>
    8000503a:	84aa                	mv	s1,a0
    8000503c:	c905                	beqz	a0,8000506c <sys_open+0x13a>
    ilock(ip);
    8000503e:	ffffe097          	auipc	ra,0xffffe
    80005042:	f98080e7          	jalr	-104(ra) # 80002fd6 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80005046:	04449703          	lh	a4,68(s1)
    8000504a:	4785                	li	a5,1
    8000504c:	f4f712e3          	bne	a4,a5,80004f90 <sys_open+0x5e>
    80005050:	f4c42783          	lw	a5,-180(s0)
    80005054:	dba1                	beqz	a5,80004fa4 <sys_open+0x72>
      iunlockput(ip);
    80005056:	8526                	mv	a0,s1
    80005058:	ffffe097          	auipc	ra,0xffffe
    8000505c:	1e0080e7          	jalr	480(ra) # 80003238 <iunlockput>
      end_op();
    80005060:	fffff097          	auipc	ra,0xfffff
    80005064:	996080e7          	jalr	-1642(ra) # 800039f6 <end_op>
      return -1;
    80005068:	557d                	li	a0,-1
    8000506a:	b76d                	j	80005014 <sys_open+0xe2>
      end_op();
    8000506c:	fffff097          	auipc	ra,0xfffff
    80005070:	98a080e7          	jalr	-1654(ra) # 800039f6 <end_op>
      return -1;
    80005074:	557d                	li	a0,-1
    80005076:	bf79                	j	80005014 <sys_open+0xe2>
    iunlockput(ip);
    80005078:	8526                	mv	a0,s1
    8000507a:	ffffe097          	auipc	ra,0xffffe
    8000507e:	1be080e7          	jalr	446(ra) # 80003238 <iunlockput>
    end_op();
    80005082:	fffff097          	auipc	ra,0xfffff
    80005086:	974080e7          	jalr	-1676(ra) # 800039f6 <end_op>
    return -1;
    8000508a:	557d                	li	a0,-1
    8000508c:	b761                	j	80005014 <sys_open+0xe2>
      fileclose(f);
    8000508e:	854a                	mv	a0,s2
    80005090:	fffff097          	auipc	ra,0xfffff
    80005094:	db0080e7          	jalr	-592(ra) # 80003e40 <fileclose>
    iunlockput(ip);
    80005098:	8526                	mv	a0,s1
    8000509a:	ffffe097          	auipc	ra,0xffffe
    8000509e:	19e080e7          	jalr	414(ra) # 80003238 <iunlockput>
    end_op();
    800050a2:	fffff097          	auipc	ra,0xfffff
    800050a6:	954080e7          	jalr	-1708(ra) # 800039f6 <end_op>
    return -1;
    800050aa:	557d                	li	a0,-1
    800050ac:	b7a5                	j	80005014 <sys_open+0xe2>
    f->type = FD_DEVICE;
    800050ae:	00f92023          	sw	a5,0(s2)
    f->major = ip->major;
    800050b2:	04649783          	lh	a5,70(s1)
    800050b6:	02f91223          	sh	a5,36(s2)
    800050ba:	bf21                	j	80004fd2 <sys_open+0xa0>
    itrunc(ip);
    800050bc:	8526                	mv	a0,s1
    800050be:	ffffe097          	auipc	ra,0xffffe
    800050c2:	026080e7          	jalr	38(ra) # 800030e4 <itrunc>
    800050c6:	bf2d                	j	80005000 <sys_open+0xce>

00000000800050c8 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    800050c8:	7175                	add	sp,sp,-144
    800050ca:	e506                	sd	ra,136(sp)
    800050cc:	e122                	sd	s0,128(sp)
    800050ce:	0900                	add	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    800050d0:	fffff097          	auipc	ra,0xfffff
    800050d4:	8ac080e7          	jalr	-1876(ra) # 8000397c <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    800050d8:	08000613          	li	a2,128
    800050dc:	f7040593          	add	a1,s0,-144
    800050e0:	4501                	li	a0,0
    800050e2:	ffffd097          	auipc	ra,0xffffd
    800050e6:	1ec080e7          	jalr	492(ra) # 800022ce <argstr>
    800050ea:	02054963          	bltz	a0,8000511c <sys_mkdir+0x54>
    800050ee:	4681                	li	a3,0
    800050f0:	4601                	li	a2,0
    800050f2:	4585                	li	a1,1
    800050f4:	f7040513          	add	a0,s0,-144
    800050f8:	00000097          	auipc	ra,0x0
    800050fc:	806080e7          	jalr	-2042(ra) # 800048fe <create>
    80005100:	cd11                	beqz	a0,8000511c <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80005102:	ffffe097          	auipc	ra,0xffffe
    80005106:	136080e7          	jalr	310(ra) # 80003238 <iunlockput>
  end_op();
    8000510a:	fffff097          	auipc	ra,0xfffff
    8000510e:	8ec080e7          	jalr	-1812(ra) # 800039f6 <end_op>
  return 0;
    80005112:	4501                	li	a0,0
}
    80005114:	60aa                	ld	ra,136(sp)
    80005116:	640a                	ld	s0,128(sp)
    80005118:	6149                	add	sp,sp,144
    8000511a:	8082                	ret
    end_op();
    8000511c:	fffff097          	auipc	ra,0xfffff
    80005120:	8da080e7          	jalr	-1830(ra) # 800039f6 <end_op>
    return -1;
    80005124:	557d                	li	a0,-1
    80005126:	b7fd                	j	80005114 <sys_mkdir+0x4c>

0000000080005128 <sys_mknod>:

uint64
sys_mknod(void)
{
    80005128:	7135                	add	sp,sp,-160
    8000512a:	ed06                	sd	ra,152(sp)
    8000512c:	e922                	sd	s0,144(sp)
    8000512e:	1100                	add	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80005130:	fffff097          	auipc	ra,0xfffff
    80005134:	84c080e7          	jalr	-1972(ra) # 8000397c <begin_op>
  argint(1, &major);
    80005138:	f6c40593          	add	a1,s0,-148
    8000513c:	4505                	li	a0,1
    8000513e:	ffffd097          	auipc	ra,0xffffd
    80005142:	150080e7          	jalr	336(ra) # 8000228e <argint>
  argint(2, &minor);
    80005146:	f6840593          	add	a1,s0,-152
    8000514a:	4509                	li	a0,2
    8000514c:	ffffd097          	auipc	ra,0xffffd
    80005150:	142080e7          	jalr	322(ra) # 8000228e <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80005154:	08000613          	li	a2,128
    80005158:	f7040593          	add	a1,s0,-144
    8000515c:	4501                	li	a0,0
    8000515e:	ffffd097          	auipc	ra,0xffffd
    80005162:	170080e7          	jalr	368(ra) # 800022ce <argstr>
    80005166:	02054b63          	bltz	a0,8000519c <sys_mknod+0x74>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    8000516a:	f6841683          	lh	a3,-152(s0)
    8000516e:	f6c41603          	lh	a2,-148(s0)
    80005172:	458d                	li	a1,3
    80005174:	f7040513          	add	a0,s0,-144
    80005178:	fffff097          	auipc	ra,0xfffff
    8000517c:	786080e7          	jalr	1926(ra) # 800048fe <create>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80005180:	cd11                	beqz	a0,8000519c <sys_mknod+0x74>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80005182:	ffffe097          	auipc	ra,0xffffe
    80005186:	0b6080e7          	jalr	182(ra) # 80003238 <iunlockput>
  end_op();
    8000518a:	fffff097          	auipc	ra,0xfffff
    8000518e:	86c080e7          	jalr	-1940(ra) # 800039f6 <end_op>
  return 0;
    80005192:	4501                	li	a0,0
}
    80005194:	60ea                	ld	ra,152(sp)
    80005196:	644a                	ld	s0,144(sp)
    80005198:	610d                	add	sp,sp,160
    8000519a:	8082                	ret
    end_op();
    8000519c:	fffff097          	auipc	ra,0xfffff
    800051a0:	85a080e7          	jalr	-1958(ra) # 800039f6 <end_op>
    return -1;
    800051a4:	557d                	li	a0,-1
    800051a6:	b7fd                	j	80005194 <sys_mknod+0x6c>

00000000800051a8 <sys_chdir>:

uint64
sys_chdir(void)
{
    800051a8:	7135                	add	sp,sp,-160
    800051aa:	ed06                	sd	ra,152(sp)
    800051ac:	e922                	sd	s0,144(sp)
    800051ae:	e526                	sd	s1,136(sp)
    800051b0:	e14a                	sd	s2,128(sp)
    800051b2:	1100                	add	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    800051b4:	ffffc097          	auipc	ra,0xffffc
    800051b8:	e16080e7          	jalr	-490(ra) # 80000fca <myproc>
    800051bc:	892a                	mv	s2,a0
  
  begin_op();
    800051be:	ffffe097          	auipc	ra,0xffffe
    800051c2:	7be080e7          	jalr	1982(ra) # 8000397c <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    800051c6:	08000613          	li	a2,128
    800051ca:	f6040593          	add	a1,s0,-160
    800051ce:	4501                	li	a0,0
    800051d0:	ffffd097          	auipc	ra,0xffffd
    800051d4:	0fe080e7          	jalr	254(ra) # 800022ce <argstr>
    800051d8:	04054b63          	bltz	a0,8000522e <sys_chdir+0x86>
    800051dc:	f6040513          	add	a0,s0,-160
    800051e0:	ffffe097          	auipc	ra,0xffffe
    800051e4:	59c080e7          	jalr	1436(ra) # 8000377c <namei>
    800051e8:	84aa                	mv	s1,a0
    800051ea:	c131                	beqz	a0,8000522e <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    800051ec:	ffffe097          	auipc	ra,0xffffe
    800051f0:	dea080e7          	jalr	-534(ra) # 80002fd6 <ilock>
  if(ip->type != T_DIR){
    800051f4:	04449703          	lh	a4,68(s1)
    800051f8:	4785                	li	a5,1
    800051fa:	04f71063          	bne	a4,a5,8000523a <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    800051fe:	8526                	mv	a0,s1
    80005200:	ffffe097          	auipc	ra,0xffffe
    80005204:	e98080e7          	jalr	-360(ra) # 80003098 <iunlock>
  iput(p->cwd);
    80005208:	15893503          	ld	a0,344(s2)
    8000520c:	ffffe097          	auipc	ra,0xffffe
    80005210:	f84080e7          	jalr	-124(ra) # 80003190 <iput>
  end_op();
    80005214:	ffffe097          	auipc	ra,0xffffe
    80005218:	7e2080e7          	jalr	2018(ra) # 800039f6 <end_op>
  p->cwd = ip;
    8000521c:	14993c23          	sd	s1,344(s2)
  return 0;
    80005220:	4501                	li	a0,0
}
    80005222:	60ea                	ld	ra,152(sp)
    80005224:	644a                	ld	s0,144(sp)
    80005226:	64aa                	ld	s1,136(sp)
    80005228:	690a                	ld	s2,128(sp)
    8000522a:	610d                	add	sp,sp,160
    8000522c:	8082                	ret
    end_op();
    8000522e:	ffffe097          	auipc	ra,0xffffe
    80005232:	7c8080e7          	jalr	1992(ra) # 800039f6 <end_op>
    return -1;
    80005236:	557d                	li	a0,-1
    80005238:	b7ed                	j	80005222 <sys_chdir+0x7a>
    iunlockput(ip);
    8000523a:	8526                	mv	a0,s1
    8000523c:	ffffe097          	auipc	ra,0xffffe
    80005240:	ffc080e7          	jalr	-4(ra) # 80003238 <iunlockput>
    end_op();
    80005244:	ffffe097          	auipc	ra,0xffffe
    80005248:	7b2080e7          	jalr	1970(ra) # 800039f6 <end_op>
    return -1;
    8000524c:	557d                	li	a0,-1
    8000524e:	bfd1                	j	80005222 <sys_chdir+0x7a>

0000000080005250 <sys_exec>:

uint64
sys_exec(void)
{
    80005250:	7121                	add	sp,sp,-448
    80005252:	ff06                	sd	ra,440(sp)
    80005254:	fb22                	sd	s0,432(sp)
    80005256:	f726                	sd	s1,424(sp)
    80005258:	f34a                	sd	s2,416(sp)
    8000525a:	ef4e                	sd	s3,408(sp)
    8000525c:	eb52                	sd	s4,400(sp)
    8000525e:	0380                	add	s0,sp,448
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    80005260:	e4840593          	add	a1,s0,-440
    80005264:	4505                	li	a0,1
    80005266:	ffffd097          	auipc	ra,0xffffd
    8000526a:	048080e7          	jalr	72(ra) # 800022ae <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    8000526e:	08000613          	li	a2,128
    80005272:	f5040593          	add	a1,s0,-176
    80005276:	4501                	li	a0,0
    80005278:	ffffd097          	auipc	ra,0xffffd
    8000527c:	056080e7          	jalr	86(ra) # 800022ce <argstr>
    80005280:	87aa                	mv	a5,a0
    return -1;
    80005282:	557d                	li	a0,-1
  if(argstr(0, path, MAXPATH) < 0) {
    80005284:	0c07c263          	bltz	a5,80005348 <sys_exec+0xf8>
  }
  memset(argv, 0, sizeof(argv));
    80005288:	10000613          	li	a2,256
    8000528c:	4581                	li	a1,0
    8000528e:	e5040513          	add	a0,s0,-432
    80005292:	ffffb097          	auipc	ra,0xffffb
    80005296:	f32080e7          	jalr	-206(ra) # 800001c4 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    8000529a:	e5040493          	add	s1,s0,-432
  memset(argv, 0, sizeof(argv));
    8000529e:	89a6                	mv	s3,s1
    800052a0:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    800052a2:	02000a13          	li	s4,32
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    800052a6:	00391513          	sll	a0,s2,0x3
    800052aa:	e4040593          	add	a1,s0,-448
    800052ae:	e4843783          	ld	a5,-440(s0)
    800052b2:	953e                	add	a0,a0,a5
    800052b4:	ffffd097          	auipc	ra,0xffffd
    800052b8:	f3c080e7          	jalr	-196(ra) # 800021f0 <fetchaddr>
    800052bc:	02054a63          	bltz	a0,800052f0 <sys_exec+0xa0>
      goto bad;
    }
    if(uarg == 0){
    800052c0:	e4043783          	ld	a5,-448(s0)
    800052c4:	c3b9                	beqz	a5,8000530a <sys_exec+0xba>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    800052c6:	ffffb097          	auipc	ra,0xffffb
    800052ca:	e9e080e7          	jalr	-354(ra) # 80000164 <kalloc>
    800052ce:	85aa                	mv	a1,a0
    800052d0:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    800052d4:	cd11                	beqz	a0,800052f0 <sys_exec+0xa0>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    800052d6:	6605                	lui	a2,0x1
    800052d8:	e4043503          	ld	a0,-448(s0)
    800052dc:	ffffd097          	auipc	ra,0xffffd
    800052e0:	f66080e7          	jalr	-154(ra) # 80002242 <fetchstr>
    800052e4:	00054663          	bltz	a0,800052f0 <sys_exec+0xa0>
    if(i >= NELEM(argv)){
    800052e8:	0905                	add	s2,s2,1
    800052ea:	09a1                	add	s3,s3,8
    800052ec:	fb491de3          	bne	s2,s4,800052a6 <sys_exec+0x56>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800052f0:	f5040913          	add	s2,s0,-176
    800052f4:	6088                	ld	a0,0(s1)
    800052f6:	c921                	beqz	a0,80005346 <sys_exec+0xf6>
    kfree(argv[i]);
    800052f8:	ffffb097          	auipc	ra,0xffffb
    800052fc:	d24080e7          	jalr	-732(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005300:	04a1                	add	s1,s1,8
    80005302:	ff2499e3          	bne	s1,s2,800052f4 <sys_exec+0xa4>
  return -1;
    80005306:	557d                	li	a0,-1
    80005308:	a081                	j	80005348 <sys_exec+0xf8>
      argv[i] = 0;
    8000530a:	0009079b          	sext.w	a5,s2
    8000530e:	078e                	sll	a5,a5,0x3
    80005310:	fd078793          	add	a5,a5,-48
    80005314:	97a2                	add	a5,a5,s0
    80005316:	e807b023          	sd	zero,-384(a5)
  int ret = exec(path, argv);
    8000531a:	e5040593          	add	a1,s0,-432
    8000531e:	f5040513          	add	a0,s0,-176
    80005322:	fffff097          	auipc	ra,0xfffff
    80005326:	194080e7          	jalr	404(ra) # 800044b6 <exec>
    8000532a:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000532c:	f5040993          	add	s3,s0,-176
    80005330:	6088                	ld	a0,0(s1)
    80005332:	c901                	beqz	a0,80005342 <sys_exec+0xf2>
    kfree(argv[i]);
    80005334:	ffffb097          	auipc	ra,0xffffb
    80005338:	ce8080e7          	jalr	-792(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000533c:	04a1                	add	s1,s1,8
    8000533e:	ff3499e3          	bne	s1,s3,80005330 <sys_exec+0xe0>
  return ret;
    80005342:	854a                	mv	a0,s2
    80005344:	a011                	j	80005348 <sys_exec+0xf8>
  return -1;
    80005346:	557d                	li	a0,-1
}
    80005348:	70fa                	ld	ra,440(sp)
    8000534a:	745a                	ld	s0,432(sp)
    8000534c:	74ba                	ld	s1,424(sp)
    8000534e:	791a                	ld	s2,416(sp)
    80005350:	69fa                	ld	s3,408(sp)
    80005352:	6a5a                	ld	s4,400(sp)
    80005354:	6139                	add	sp,sp,448
    80005356:	8082                	ret

0000000080005358 <sys_pipe>:

uint64
sys_pipe(void)
{
    80005358:	7139                	add	sp,sp,-64
    8000535a:	fc06                	sd	ra,56(sp)
    8000535c:	f822                	sd	s0,48(sp)
    8000535e:	f426                	sd	s1,40(sp)
    80005360:	0080                	add	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80005362:	ffffc097          	auipc	ra,0xffffc
    80005366:	c68080e7          	jalr	-920(ra) # 80000fca <myproc>
    8000536a:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    8000536c:	fd840593          	add	a1,s0,-40
    80005370:	4501                	li	a0,0
    80005372:	ffffd097          	auipc	ra,0xffffd
    80005376:	f3c080e7          	jalr	-196(ra) # 800022ae <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    8000537a:	fc840593          	add	a1,s0,-56
    8000537e:	fd040513          	add	a0,s0,-48
    80005382:	fffff097          	auipc	ra,0xfffff
    80005386:	dea080e7          	jalr	-534(ra) # 8000416c <pipealloc>
    return -1;
    8000538a:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    8000538c:	0c054463          	bltz	a0,80005454 <sys_pipe+0xfc>
  fd0 = -1;
    80005390:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80005394:	fd043503          	ld	a0,-48(s0)
    80005398:	fffff097          	auipc	ra,0xfffff
    8000539c:	524080e7          	jalr	1316(ra) # 800048bc <fdalloc>
    800053a0:	fca42223          	sw	a0,-60(s0)
    800053a4:	08054b63          	bltz	a0,8000543a <sys_pipe+0xe2>
    800053a8:	fc843503          	ld	a0,-56(s0)
    800053ac:	fffff097          	auipc	ra,0xfffff
    800053b0:	510080e7          	jalr	1296(ra) # 800048bc <fdalloc>
    800053b4:	fca42023          	sw	a0,-64(s0)
    800053b8:	06054863          	bltz	a0,80005428 <sys_pipe+0xd0>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800053bc:	4691                	li	a3,4
    800053be:	fc440613          	add	a2,s0,-60
    800053c2:	fd843583          	ld	a1,-40(s0)
    800053c6:	68a8                	ld	a0,80(s1)
    800053c8:	ffffb097          	auipc	ra,0xffffb
    800053cc:	794080e7          	jalr	1940(ra) # 80000b5c <copyout>
    800053d0:	02054063          	bltz	a0,800053f0 <sys_pipe+0x98>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    800053d4:	4691                	li	a3,4
    800053d6:	fc040613          	add	a2,s0,-64
    800053da:	fd843583          	ld	a1,-40(s0)
    800053de:	0591                	add	a1,a1,4
    800053e0:	68a8                	ld	a0,80(s1)
    800053e2:	ffffb097          	auipc	ra,0xffffb
    800053e6:	77a080e7          	jalr	1914(ra) # 80000b5c <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    800053ea:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800053ec:	06055463          	bgez	a0,80005454 <sys_pipe+0xfc>
    p->ofile[fd0] = 0;
    800053f0:	fc442783          	lw	a5,-60(s0)
    800053f4:	07e9                	add	a5,a5,26
    800053f6:	078e                	sll	a5,a5,0x3
    800053f8:	97a6                	add	a5,a5,s1
    800053fa:	0007b423          	sd	zero,8(a5)
    p->ofile[fd1] = 0;
    800053fe:	fc042783          	lw	a5,-64(s0)
    80005402:	07e9                	add	a5,a5,26
    80005404:	078e                	sll	a5,a5,0x3
    80005406:	94be                	add	s1,s1,a5
    80005408:	0004b423          	sd	zero,8(s1)
    fileclose(rf);
    8000540c:	fd043503          	ld	a0,-48(s0)
    80005410:	fffff097          	auipc	ra,0xfffff
    80005414:	a30080e7          	jalr	-1488(ra) # 80003e40 <fileclose>
    fileclose(wf);
    80005418:	fc843503          	ld	a0,-56(s0)
    8000541c:	fffff097          	auipc	ra,0xfffff
    80005420:	a24080e7          	jalr	-1500(ra) # 80003e40 <fileclose>
    return -1;
    80005424:	57fd                	li	a5,-1
    80005426:	a03d                	j	80005454 <sys_pipe+0xfc>
    if(fd0 >= 0)
    80005428:	fc442783          	lw	a5,-60(s0)
    8000542c:	0007c763          	bltz	a5,8000543a <sys_pipe+0xe2>
      p->ofile[fd0] = 0;
    80005430:	07e9                	add	a5,a5,26
    80005432:	078e                	sll	a5,a5,0x3
    80005434:	97a6                	add	a5,a5,s1
    80005436:	0007b423          	sd	zero,8(a5)
    fileclose(rf);
    8000543a:	fd043503          	ld	a0,-48(s0)
    8000543e:	fffff097          	auipc	ra,0xfffff
    80005442:	a02080e7          	jalr	-1534(ra) # 80003e40 <fileclose>
    fileclose(wf);
    80005446:	fc843503          	ld	a0,-56(s0)
    8000544a:	fffff097          	auipc	ra,0xfffff
    8000544e:	9f6080e7          	jalr	-1546(ra) # 80003e40 <fileclose>
    return -1;
    80005452:	57fd                	li	a5,-1
}
    80005454:	853e                	mv	a0,a5
    80005456:	70e2                	ld	ra,56(sp)
    80005458:	7442                	ld	s0,48(sp)
    8000545a:	74a2                	ld	s1,40(sp)
    8000545c:	6121                	add	sp,sp,64
    8000545e:	8082                	ret

0000000080005460 <kernelvec>:
    80005460:	7111                	add	sp,sp,-256
    80005462:	e006                	sd	ra,0(sp)
    80005464:	e40a                	sd	sp,8(sp)
    80005466:	e80e                	sd	gp,16(sp)
    80005468:	ec12                	sd	tp,24(sp)
    8000546a:	f016                	sd	t0,32(sp)
    8000546c:	f41a                	sd	t1,40(sp)
    8000546e:	f81e                	sd	t2,48(sp)
    80005470:	fc22                	sd	s0,56(sp)
    80005472:	e0a6                	sd	s1,64(sp)
    80005474:	e4aa                	sd	a0,72(sp)
    80005476:	e8ae                	sd	a1,80(sp)
    80005478:	ecb2                	sd	a2,88(sp)
    8000547a:	f0b6                	sd	a3,96(sp)
    8000547c:	f4ba                	sd	a4,104(sp)
    8000547e:	f8be                	sd	a5,112(sp)
    80005480:	fcc2                	sd	a6,120(sp)
    80005482:	e146                	sd	a7,128(sp)
    80005484:	e54a                	sd	s2,136(sp)
    80005486:	e94e                	sd	s3,144(sp)
    80005488:	ed52                	sd	s4,152(sp)
    8000548a:	f156                	sd	s5,160(sp)
    8000548c:	f55a                	sd	s6,168(sp)
    8000548e:	f95e                	sd	s7,176(sp)
    80005490:	fd62                	sd	s8,184(sp)
    80005492:	e1e6                	sd	s9,192(sp)
    80005494:	e5ea                	sd	s10,200(sp)
    80005496:	e9ee                	sd	s11,208(sp)
    80005498:	edf2                	sd	t3,216(sp)
    8000549a:	f1f6                	sd	t4,224(sp)
    8000549c:	f5fa                	sd	t5,232(sp)
    8000549e:	f9fe                	sd	t6,240(sp)
    800054a0:	c1dfc0ef          	jal	800020bc <kerneltrap>
    800054a4:	6082                	ld	ra,0(sp)
    800054a6:	6122                	ld	sp,8(sp)
    800054a8:	61c2                	ld	gp,16(sp)
    800054aa:	7282                	ld	t0,32(sp)
    800054ac:	7322                	ld	t1,40(sp)
    800054ae:	73c2                	ld	t2,48(sp)
    800054b0:	7462                	ld	s0,56(sp)
    800054b2:	6486                	ld	s1,64(sp)
    800054b4:	6526                	ld	a0,72(sp)
    800054b6:	65c6                	ld	a1,80(sp)
    800054b8:	6666                	ld	a2,88(sp)
    800054ba:	7686                	ld	a3,96(sp)
    800054bc:	7726                	ld	a4,104(sp)
    800054be:	77c6                	ld	a5,112(sp)
    800054c0:	7866                	ld	a6,120(sp)
    800054c2:	688a                	ld	a7,128(sp)
    800054c4:	692a                	ld	s2,136(sp)
    800054c6:	69ca                	ld	s3,144(sp)
    800054c8:	6a6a                	ld	s4,152(sp)
    800054ca:	7a8a                	ld	s5,160(sp)
    800054cc:	7b2a                	ld	s6,168(sp)
    800054ce:	7bca                	ld	s7,176(sp)
    800054d0:	7c6a                	ld	s8,184(sp)
    800054d2:	6c8e                	ld	s9,192(sp)
    800054d4:	6d2e                	ld	s10,200(sp)
    800054d6:	6dce                	ld	s11,208(sp)
    800054d8:	6e6e                	ld	t3,216(sp)
    800054da:	7e8e                	ld	t4,224(sp)
    800054dc:	7f2e                	ld	t5,232(sp)
    800054de:	7fce                	ld	t6,240(sp)
    800054e0:	6111                	add	sp,sp,256
    800054e2:	10200073          	sret
    800054e6:	00000013          	nop
    800054ea:	00000013          	nop
    800054ee:	0001                	nop

00000000800054f0 <timervec>:
    800054f0:	34051573          	csrrw	a0,mscratch,a0
    800054f4:	e10c                	sd	a1,0(a0)
    800054f6:	e510                	sd	a2,8(a0)
    800054f8:	e914                	sd	a3,16(a0)
    800054fa:	6d0c                	ld	a1,24(a0)
    800054fc:	7110                	ld	a2,32(a0)
    800054fe:	6194                	ld	a3,0(a1)
    80005500:	96b2                	add	a3,a3,a2
    80005502:	e194                	sd	a3,0(a1)
    80005504:	4589                	li	a1,2
    80005506:	14459073          	csrw	sip,a1
    8000550a:	6914                	ld	a3,16(a0)
    8000550c:	6510                	ld	a2,8(a0)
    8000550e:	610c                	ld	a1,0(a0)
    80005510:	34051573          	csrrw	a0,mscratch,a0
    80005514:	30200073          	mret
	...

000000008000551a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000551a:	1141                	add	sp,sp,-16
    8000551c:	e422                	sd	s0,8(sp)
    8000551e:	0800                	add	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80005520:	0c0007b7          	lui	a5,0xc000
    80005524:	4705                	li	a4,1
    80005526:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80005528:	c3d8                	sw	a4,4(a5)
}
    8000552a:	6422                	ld	s0,8(sp)
    8000552c:	0141                	add	sp,sp,16
    8000552e:	8082                	ret

0000000080005530 <plicinithart>:

void
plicinithart(void)
{
    80005530:	1141                	add	sp,sp,-16
    80005532:	e406                	sd	ra,8(sp)
    80005534:	e022                	sd	s0,0(sp)
    80005536:	0800                	add	s0,sp,16
  int hart = cpuid();
    80005538:	ffffc097          	auipc	ra,0xffffc
    8000553c:	a66080e7          	jalr	-1434(ra) # 80000f9e <cpuid>
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005540:	0085171b          	sllw	a4,a0,0x8
    80005544:	0c0027b7          	lui	a5,0xc002
    80005548:	97ba                	add	a5,a5,a4
    8000554a:	40200713          	li	a4,1026
    8000554e:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005552:	00d5151b          	sllw	a0,a0,0xd
    80005556:	0c2017b7          	lui	a5,0xc201
    8000555a:	97aa                	add	a5,a5,a0
    8000555c:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80005560:	60a2                	ld	ra,8(sp)
    80005562:	6402                	ld	s0,0(sp)
    80005564:	0141                	add	sp,sp,16
    80005566:	8082                	ret

0000000080005568 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80005568:	1141                	add	sp,sp,-16
    8000556a:	e406                	sd	ra,8(sp)
    8000556c:	e022                	sd	s0,0(sp)
    8000556e:	0800                	add	s0,sp,16
  int hart = cpuid();
    80005570:	ffffc097          	auipc	ra,0xffffc
    80005574:	a2e080e7          	jalr	-1490(ra) # 80000f9e <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80005578:	00d5151b          	sllw	a0,a0,0xd
    8000557c:	0c2017b7          	lui	a5,0xc201
    80005580:	97aa                	add	a5,a5,a0
  return irq;
}
    80005582:	43c8                	lw	a0,4(a5)
    80005584:	60a2                	ld	ra,8(sp)
    80005586:	6402                	ld	s0,0(sp)
    80005588:	0141                	add	sp,sp,16
    8000558a:	8082                	ret

000000008000558c <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    8000558c:	1101                	add	sp,sp,-32
    8000558e:	ec06                	sd	ra,24(sp)
    80005590:	e822                	sd	s0,16(sp)
    80005592:	e426                	sd	s1,8(sp)
    80005594:	1000                	add	s0,sp,32
    80005596:	84aa                	mv	s1,a0
  int hart = cpuid();
    80005598:	ffffc097          	auipc	ra,0xffffc
    8000559c:	a06080e7          	jalr	-1530(ra) # 80000f9e <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    800055a0:	00d5151b          	sllw	a0,a0,0xd
    800055a4:	0c2017b7          	lui	a5,0xc201
    800055a8:	97aa                	add	a5,a5,a0
    800055aa:	c3c4                	sw	s1,4(a5)
}
    800055ac:	60e2                	ld	ra,24(sp)
    800055ae:	6442                	ld	s0,16(sp)
    800055b0:	64a2                	ld	s1,8(sp)
    800055b2:	6105                	add	sp,sp,32
    800055b4:	8082                	ret

00000000800055b6 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    800055b6:	1141                	add	sp,sp,-16
    800055b8:	e406                	sd	ra,8(sp)
    800055ba:	e022                	sd	s0,0(sp)
    800055bc:	0800                	add	s0,sp,16
  if(i >= NUM)
    800055be:	479d                	li	a5,7
    800055c0:	04a7cc63          	blt	a5,a0,80005618 <free_desc+0x62>
    panic("free_desc 1");
  if(disk.free[i])
    800055c4:	00015797          	auipc	a5,0x15
    800055c8:	a1478793          	add	a5,a5,-1516 # 80019fd8 <disk>
    800055cc:	97aa                	add	a5,a5,a0
    800055ce:	0187c783          	lbu	a5,24(a5)
    800055d2:	ebb9                	bnez	a5,80005628 <free_desc+0x72>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    800055d4:	00451693          	sll	a3,a0,0x4
    800055d8:	00015797          	auipc	a5,0x15
    800055dc:	a0078793          	add	a5,a5,-1536 # 80019fd8 <disk>
    800055e0:	6398                	ld	a4,0(a5)
    800055e2:	9736                	add	a4,a4,a3
    800055e4:	00073023          	sd	zero,0(a4)
  disk.desc[i].len = 0;
    800055e8:	6398                	ld	a4,0(a5)
    800055ea:	9736                	add	a4,a4,a3
    800055ec:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    800055f0:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    800055f4:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    800055f8:	97aa                	add	a5,a5,a0
    800055fa:	4705                	li	a4,1
    800055fc:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    80005600:	00015517          	auipc	a0,0x15
    80005604:	9f050513          	add	a0,a0,-1552 # 80019ff0 <disk+0x18>
    80005608:	ffffc097          	auipc	ra,0xffffc
    8000560c:	1f6080e7          	jalr	502(ra) # 800017fe <wakeup>
}
    80005610:	60a2                	ld	ra,8(sp)
    80005612:	6402                	ld	s0,0(sp)
    80005614:	0141                	add	sp,sp,16
    80005616:	8082                	ret
    panic("free_desc 1");
    80005618:	00003517          	auipc	a0,0x3
    8000561c:	2a850513          	add	a0,a0,680 # 800088c0 <syscallnames+0x300>
    80005620:	00001097          	auipc	ra,0x1
    80005624:	ac0080e7          	jalr	-1344(ra) # 800060e0 <panic>
    panic("free_desc 2");
    80005628:	00003517          	auipc	a0,0x3
    8000562c:	2a850513          	add	a0,a0,680 # 800088d0 <syscallnames+0x310>
    80005630:	00001097          	auipc	ra,0x1
    80005634:	ab0080e7          	jalr	-1360(ra) # 800060e0 <panic>

0000000080005638 <virtio_disk_init>:
{
    80005638:	1101                	add	sp,sp,-32
    8000563a:	ec06                	sd	ra,24(sp)
    8000563c:	e822                	sd	s0,16(sp)
    8000563e:	e426                	sd	s1,8(sp)
    80005640:	e04a                	sd	s2,0(sp)
    80005642:	1000                	add	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    80005644:	00003597          	auipc	a1,0x3
    80005648:	29c58593          	add	a1,a1,668 # 800088e0 <syscallnames+0x320>
    8000564c:	00015517          	auipc	a0,0x15
    80005650:	ab450513          	add	a0,a0,-1356 # 8001a100 <disk+0x128>
    80005654:	00001097          	auipc	ra,0x1
    80005658:	f34080e7          	jalr	-204(ra) # 80006588 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    8000565c:	100017b7          	lui	a5,0x10001
    80005660:	4398                	lw	a4,0(a5)
    80005662:	2701                	sext.w	a4,a4
    80005664:	747277b7          	lui	a5,0x74727
    80005668:	97678793          	add	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    8000566c:	14f71b63          	bne	a4,a5,800057c2 <virtio_disk_init+0x18a>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80005670:	100017b7          	lui	a5,0x10001
    80005674:	43dc                	lw	a5,4(a5)
    80005676:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005678:	4709                	li	a4,2
    8000567a:	14e79463          	bne	a5,a4,800057c2 <virtio_disk_init+0x18a>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000567e:	100017b7          	lui	a5,0x10001
    80005682:	479c                	lw	a5,8(a5)
    80005684:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80005686:	12e79e63          	bne	a5,a4,800057c2 <virtio_disk_init+0x18a>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    8000568a:	100017b7          	lui	a5,0x10001
    8000568e:	47d8                	lw	a4,12(a5)
    80005690:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005692:	554d47b7          	lui	a5,0x554d4
    80005696:	55178793          	add	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    8000569a:	12f71463          	bne	a4,a5,800057c2 <virtio_disk_init+0x18a>
  *R(VIRTIO_MMIO_STATUS) = status;
    8000569e:	100017b7          	lui	a5,0x10001
    800056a2:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    800056a6:	4705                	li	a4,1
    800056a8:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800056aa:	470d                	li	a4,3
    800056ac:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    800056ae:	4b98                	lw	a4,16(a5)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    800056b0:	c7ffe6b7          	lui	a3,0xc7ffe
    800056b4:	75f68693          	add	a3,a3,1887 # ffffffffc7ffe75f <end+0xffffffff47fdc3ff>
    800056b8:	8f75                	and	a4,a4,a3
    800056ba:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800056bc:	472d                	li	a4,11
    800056be:	dbb8                	sw	a4,112(a5)
  status = *R(VIRTIO_MMIO_STATUS);
    800056c0:	5bbc                	lw	a5,112(a5)
    800056c2:	0007891b          	sext.w	s2,a5
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    800056c6:	8ba1                	and	a5,a5,8
    800056c8:	10078563          	beqz	a5,800057d2 <virtio_disk_init+0x19a>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    800056cc:	100017b7          	lui	a5,0x10001
    800056d0:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    800056d4:	43fc                	lw	a5,68(a5)
    800056d6:	2781                	sext.w	a5,a5
    800056d8:	10079563          	bnez	a5,800057e2 <virtio_disk_init+0x1aa>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    800056dc:	100017b7          	lui	a5,0x10001
    800056e0:	5bdc                	lw	a5,52(a5)
    800056e2:	2781                	sext.w	a5,a5
  if(max == 0)
    800056e4:	10078763          	beqz	a5,800057f2 <virtio_disk_init+0x1ba>
  if(max < NUM)
    800056e8:	471d                	li	a4,7
    800056ea:	10f77c63          	bgeu	a4,a5,80005802 <virtio_disk_init+0x1ca>
  disk.desc = kalloc();
    800056ee:	ffffb097          	auipc	ra,0xffffb
    800056f2:	a76080e7          	jalr	-1418(ra) # 80000164 <kalloc>
    800056f6:	00015497          	auipc	s1,0x15
    800056fa:	8e248493          	add	s1,s1,-1822 # 80019fd8 <disk>
    800056fe:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    80005700:	ffffb097          	auipc	ra,0xffffb
    80005704:	a64080e7          	jalr	-1436(ra) # 80000164 <kalloc>
    80005708:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    8000570a:	ffffb097          	auipc	ra,0xffffb
    8000570e:	a5a080e7          	jalr	-1446(ra) # 80000164 <kalloc>
    80005712:	87aa                	mv	a5,a0
    80005714:	e888                	sd	a0,16(s1)
  if(!disk.desc || !disk.avail || !disk.used)
    80005716:	6088                	ld	a0,0(s1)
    80005718:	cd6d                	beqz	a0,80005812 <virtio_disk_init+0x1da>
    8000571a:	00015717          	auipc	a4,0x15
    8000571e:	8c673703          	ld	a4,-1850(a4) # 80019fe0 <disk+0x8>
    80005722:	cb65                	beqz	a4,80005812 <virtio_disk_init+0x1da>
    80005724:	c7fd                	beqz	a5,80005812 <virtio_disk_init+0x1da>
  memset(disk.desc, 0, PGSIZE);
    80005726:	6605                	lui	a2,0x1
    80005728:	4581                	li	a1,0
    8000572a:	ffffb097          	auipc	ra,0xffffb
    8000572e:	a9a080e7          	jalr	-1382(ra) # 800001c4 <memset>
  memset(disk.avail, 0, PGSIZE);
    80005732:	00015497          	auipc	s1,0x15
    80005736:	8a648493          	add	s1,s1,-1882 # 80019fd8 <disk>
    8000573a:	6605                	lui	a2,0x1
    8000573c:	4581                	li	a1,0
    8000573e:	6488                	ld	a0,8(s1)
    80005740:	ffffb097          	auipc	ra,0xffffb
    80005744:	a84080e7          	jalr	-1404(ra) # 800001c4 <memset>
  memset(disk.used, 0, PGSIZE);
    80005748:	6605                	lui	a2,0x1
    8000574a:	4581                	li	a1,0
    8000574c:	6888                	ld	a0,16(s1)
    8000574e:	ffffb097          	auipc	ra,0xffffb
    80005752:	a76080e7          	jalr	-1418(ra) # 800001c4 <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80005756:	100017b7          	lui	a5,0x10001
    8000575a:	4721                	li	a4,8
    8000575c:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    8000575e:	4098                	lw	a4,0(s1)
    80005760:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    80005764:	40d8                	lw	a4,4(s1)
    80005766:	08e7a223          	sw	a4,132(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    8000576a:	6498                	ld	a4,8(s1)
    8000576c:	0007069b          	sext.w	a3,a4
    80005770:	08d7a823          	sw	a3,144(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    80005774:	9701                	sra	a4,a4,0x20
    80005776:	08e7aa23          	sw	a4,148(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    8000577a:	6898                	ld	a4,16(s1)
    8000577c:	0007069b          	sext.w	a3,a4
    80005780:	0ad7a023          	sw	a3,160(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    80005784:	9701                	sra	a4,a4,0x20
    80005786:	0ae7a223          	sw	a4,164(a5)
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    8000578a:	4705                	li	a4,1
    8000578c:	c3f8                	sw	a4,68(a5)
    disk.free[i] = 1;
    8000578e:	00e48c23          	sb	a4,24(s1)
    80005792:	00e48ca3          	sb	a4,25(s1)
    80005796:	00e48d23          	sb	a4,26(s1)
    8000579a:	00e48da3          	sb	a4,27(s1)
    8000579e:	00e48e23          	sb	a4,28(s1)
    800057a2:	00e48ea3          	sb	a4,29(s1)
    800057a6:	00e48f23          	sb	a4,30(s1)
    800057aa:	00e48fa3          	sb	a4,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    800057ae:	00496913          	or	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    800057b2:	0727a823          	sw	s2,112(a5)
}
    800057b6:	60e2                	ld	ra,24(sp)
    800057b8:	6442                	ld	s0,16(sp)
    800057ba:	64a2                	ld	s1,8(sp)
    800057bc:	6902                	ld	s2,0(sp)
    800057be:	6105                	add	sp,sp,32
    800057c0:	8082                	ret
    panic("could not find virtio disk");
    800057c2:	00003517          	auipc	a0,0x3
    800057c6:	12e50513          	add	a0,a0,302 # 800088f0 <syscallnames+0x330>
    800057ca:	00001097          	auipc	ra,0x1
    800057ce:	916080e7          	jalr	-1770(ra) # 800060e0 <panic>
    panic("virtio disk FEATURES_OK unset");
    800057d2:	00003517          	auipc	a0,0x3
    800057d6:	13e50513          	add	a0,a0,318 # 80008910 <syscallnames+0x350>
    800057da:	00001097          	auipc	ra,0x1
    800057de:	906080e7          	jalr	-1786(ra) # 800060e0 <panic>
    panic("virtio disk should not be ready");
    800057e2:	00003517          	auipc	a0,0x3
    800057e6:	14e50513          	add	a0,a0,334 # 80008930 <syscallnames+0x370>
    800057ea:	00001097          	auipc	ra,0x1
    800057ee:	8f6080e7          	jalr	-1802(ra) # 800060e0 <panic>
    panic("virtio disk has no queue 0");
    800057f2:	00003517          	auipc	a0,0x3
    800057f6:	15e50513          	add	a0,a0,350 # 80008950 <syscallnames+0x390>
    800057fa:	00001097          	auipc	ra,0x1
    800057fe:	8e6080e7          	jalr	-1818(ra) # 800060e0 <panic>
    panic("virtio disk max queue too short");
    80005802:	00003517          	auipc	a0,0x3
    80005806:	16e50513          	add	a0,a0,366 # 80008970 <syscallnames+0x3b0>
    8000580a:	00001097          	auipc	ra,0x1
    8000580e:	8d6080e7          	jalr	-1834(ra) # 800060e0 <panic>
    panic("virtio disk kalloc");
    80005812:	00003517          	auipc	a0,0x3
    80005816:	17e50513          	add	a0,a0,382 # 80008990 <syscallnames+0x3d0>
    8000581a:	00001097          	auipc	ra,0x1
    8000581e:	8c6080e7          	jalr	-1850(ra) # 800060e0 <panic>

0000000080005822 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80005822:	7159                	add	sp,sp,-112
    80005824:	f486                	sd	ra,104(sp)
    80005826:	f0a2                	sd	s0,96(sp)
    80005828:	eca6                	sd	s1,88(sp)
    8000582a:	e8ca                	sd	s2,80(sp)
    8000582c:	e4ce                	sd	s3,72(sp)
    8000582e:	e0d2                	sd	s4,64(sp)
    80005830:	fc56                	sd	s5,56(sp)
    80005832:	f85a                	sd	s6,48(sp)
    80005834:	f45e                	sd	s7,40(sp)
    80005836:	f062                	sd	s8,32(sp)
    80005838:	ec66                	sd	s9,24(sp)
    8000583a:	e86a                	sd	s10,16(sp)
    8000583c:	1880                	add	s0,sp,112
    8000583e:	8a2a                	mv	s4,a0
    80005840:	8bae                	mv	s7,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80005842:	00c52c83          	lw	s9,12(a0)
    80005846:	001c9c9b          	sllw	s9,s9,0x1
    8000584a:	1c82                	sll	s9,s9,0x20
    8000584c:	020cdc93          	srl	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    80005850:	00015517          	auipc	a0,0x15
    80005854:	8b050513          	add	a0,a0,-1872 # 8001a100 <disk+0x128>
    80005858:	00001097          	auipc	ra,0x1
    8000585c:	dc0080e7          	jalr	-576(ra) # 80006618 <acquire>
  for(int i = 0; i < 3; i++){
    80005860:	4901                	li	s2,0
  for(int i = 0; i < NUM; i++){
    80005862:	44a1                	li	s1,8
      disk.free[i] = 0;
    80005864:	00014b17          	auipc	s6,0x14
    80005868:	774b0b13          	add	s6,s6,1908 # 80019fd8 <disk>
  for(int i = 0; i < 3; i++){
    8000586c:	4a8d                	li	s5,3
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    8000586e:	00015c17          	auipc	s8,0x15
    80005872:	892c0c13          	add	s8,s8,-1902 # 8001a100 <disk+0x128>
    80005876:	a095                	j	800058da <virtio_disk_rw+0xb8>
      disk.free[i] = 0;
    80005878:	00fb0733          	add	a4,s6,a5
    8000587c:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    80005880:	c11c                	sw	a5,0(a0)
    if(idx[i] < 0){
    80005882:	0207c563          	bltz	a5,800058ac <virtio_disk_rw+0x8a>
  for(int i = 0; i < 3; i++){
    80005886:	2605                	addw	a2,a2,1 # 1001 <_entry-0x7fffefff>
    80005888:	0591                	add	a1,a1,4
    8000588a:	05560d63          	beq	a2,s5,800058e4 <virtio_disk_rw+0xc2>
    idx[i] = alloc_desc();
    8000588e:	852e                	mv	a0,a1
  for(int i = 0; i < NUM; i++){
    80005890:	00014717          	auipc	a4,0x14
    80005894:	74870713          	add	a4,a4,1864 # 80019fd8 <disk>
    80005898:	87ca                	mv	a5,s2
    if(disk.free[i]){
    8000589a:	01874683          	lbu	a3,24(a4)
    8000589e:	fee9                	bnez	a3,80005878 <virtio_disk_rw+0x56>
  for(int i = 0; i < NUM; i++){
    800058a0:	2785                	addw	a5,a5,1
    800058a2:	0705                	add	a4,a4,1
    800058a4:	fe979be3          	bne	a5,s1,8000589a <virtio_disk_rw+0x78>
    idx[i] = alloc_desc();
    800058a8:	57fd                	li	a5,-1
    800058aa:	c11c                	sw	a5,0(a0)
      for(int j = 0; j < i; j++)
    800058ac:	00c05e63          	blez	a2,800058c8 <virtio_disk_rw+0xa6>
    800058b0:	060a                	sll	a2,a2,0x2
    800058b2:	01360d33          	add	s10,a2,s3
        free_desc(idx[j]);
    800058b6:	0009a503          	lw	a0,0(s3)
    800058ba:	00000097          	auipc	ra,0x0
    800058be:	cfc080e7          	jalr	-772(ra) # 800055b6 <free_desc>
      for(int j = 0; j < i; j++)
    800058c2:	0991                	add	s3,s3,4
    800058c4:	ffa999e3          	bne	s3,s10,800058b6 <virtio_disk_rw+0x94>
    sleep(&disk.free[0], &disk.vdisk_lock);
    800058c8:	85e2                	mv	a1,s8
    800058ca:	00014517          	auipc	a0,0x14
    800058ce:	72650513          	add	a0,a0,1830 # 80019ff0 <disk+0x18>
    800058d2:	ffffc097          	auipc	ra,0xffffc
    800058d6:	ec8080e7          	jalr	-312(ra) # 8000179a <sleep>
  for(int i = 0; i < 3; i++){
    800058da:	f9040993          	add	s3,s0,-112
{
    800058de:	85ce                	mv	a1,s3
  for(int i = 0; i < 3; i++){
    800058e0:	864a                	mv	a2,s2
    800058e2:	b775                	j	8000588e <virtio_disk_rw+0x6c>
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800058e4:	f9042503          	lw	a0,-112(s0)
    800058e8:	00a50713          	add	a4,a0,10
    800058ec:	0712                	sll	a4,a4,0x4

  if(write)
    800058ee:	00014797          	auipc	a5,0x14
    800058f2:	6ea78793          	add	a5,a5,1770 # 80019fd8 <disk>
    800058f6:	00e786b3          	add	a3,a5,a4
    800058fa:	01703633          	snez	a2,s7
    800058fe:	c690                	sw	a2,8(a3)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    80005900:	0006a623          	sw	zero,12(a3)
  buf0->sector = sector;
    80005904:	0196b823          	sd	s9,16(a3)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80005908:	f6070613          	add	a2,a4,-160
    8000590c:	6394                	ld	a3,0(a5)
    8000590e:	96b2                	add	a3,a3,a2
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80005910:	00870593          	add	a1,a4,8
    80005914:	95be                	add	a1,a1,a5
  disk.desc[idx[0]].addr = (uint64) buf0;
    80005916:	e28c                	sd	a1,0(a3)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80005918:	0007b803          	ld	a6,0(a5)
    8000591c:	9642                	add	a2,a2,a6
    8000591e:	46c1                	li	a3,16
    80005920:	c614                	sw	a3,8(a2)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80005922:	4585                	li	a1,1
    80005924:	00b61623          	sh	a1,12(a2)
  disk.desc[idx[0]].next = idx[1];
    80005928:	f9442683          	lw	a3,-108(s0)
    8000592c:	00d61723          	sh	a3,14(a2)

  disk.desc[idx[1]].addr = (uint64) b->data;
    80005930:	0692                	sll	a3,a3,0x4
    80005932:	9836                	add	a6,a6,a3
    80005934:	058a0613          	add	a2,s4,88
    80005938:	00c83023          	sd	a2,0(a6)
  disk.desc[idx[1]].len = BSIZE;
    8000593c:	0007b803          	ld	a6,0(a5)
    80005940:	96c2                	add	a3,a3,a6
    80005942:	40000613          	li	a2,1024
    80005946:	c690                	sw	a2,8(a3)
  if(write)
    80005948:	001bb613          	seqz	a2,s7
    8000594c:	0016161b          	sllw	a2,a2,0x1
    disk.desc[idx[1]].flags = 0; // device reads b->data
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80005950:	00166613          	or	a2,a2,1
    80005954:	00c69623          	sh	a2,12(a3)
  disk.desc[idx[1]].next = idx[2];
    80005958:	f9842603          	lw	a2,-104(s0)
    8000595c:	00c69723          	sh	a2,14(a3)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80005960:	00250693          	add	a3,a0,2
    80005964:	0692                	sll	a3,a3,0x4
    80005966:	96be                	add	a3,a3,a5
    80005968:	58fd                	li	a7,-1
    8000596a:	01168823          	sb	a7,16(a3)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    8000596e:	0612                	sll	a2,a2,0x4
    80005970:	9832                	add	a6,a6,a2
    80005972:	f9070713          	add	a4,a4,-112
    80005976:	973e                	add	a4,a4,a5
    80005978:	00e83023          	sd	a4,0(a6)
  disk.desc[idx[2]].len = 1;
    8000597c:	6398                	ld	a4,0(a5)
    8000597e:	9732                	add	a4,a4,a2
    80005980:	c70c                	sw	a1,8(a4)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80005982:	4609                	li	a2,2
    80005984:	00c71623          	sh	a2,12(a4)
  disk.desc[idx[2]].next = 0;
    80005988:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    8000598c:	00ba2223          	sw	a1,4(s4)
  disk.info[idx[0]].b = b;
    80005990:	0146b423          	sd	s4,8(a3)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80005994:	6794                	ld	a3,8(a5)
    80005996:	0026d703          	lhu	a4,2(a3)
    8000599a:	8b1d                	and	a4,a4,7
    8000599c:	0706                	sll	a4,a4,0x1
    8000599e:	96ba                	add	a3,a3,a4
    800059a0:	00a69223          	sh	a0,4(a3)

  __sync_synchronize();
    800059a4:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    800059a8:	6798                	ld	a4,8(a5)
    800059aa:	00275783          	lhu	a5,2(a4)
    800059ae:	2785                	addw	a5,a5,1
    800059b0:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    800059b4:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    800059b8:	100017b7          	lui	a5,0x10001
    800059bc:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    800059c0:	004a2783          	lw	a5,4(s4)
    sleep(b, &disk.vdisk_lock);
    800059c4:	00014917          	auipc	s2,0x14
    800059c8:	73c90913          	add	s2,s2,1852 # 8001a100 <disk+0x128>
  while(b->disk == 1) {
    800059cc:	4485                	li	s1,1
    800059ce:	00b79c63          	bne	a5,a1,800059e6 <virtio_disk_rw+0x1c4>
    sleep(b, &disk.vdisk_lock);
    800059d2:	85ca                	mv	a1,s2
    800059d4:	8552                	mv	a0,s4
    800059d6:	ffffc097          	auipc	ra,0xffffc
    800059da:	dc4080e7          	jalr	-572(ra) # 8000179a <sleep>
  while(b->disk == 1) {
    800059de:	004a2783          	lw	a5,4(s4)
    800059e2:	fe9788e3          	beq	a5,s1,800059d2 <virtio_disk_rw+0x1b0>
  }

  disk.info[idx[0]].b = 0;
    800059e6:	f9042903          	lw	s2,-112(s0)
    800059ea:	00290713          	add	a4,s2,2
    800059ee:	0712                	sll	a4,a4,0x4
    800059f0:	00014797          	auipc	a5,0x14
    800059f4:	5e878793          	add	a5,a5,1512 # 80019fd8 <disk>
    800059f8:	97ba                	add	a5,a5,a4
    800059fa:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    800059fe:	00014997          	auipc	s3,0x14
    80005a02:	5da98993          	add	s3,s3,1498 # 80019fd8 <disk>
    80005a06:	00491713          	sll	a4,s2,0x4
    80005a0a:	0009b783          	ld	a5,0(s3)
    80005a0e:	97ba                	add	a5,a5,a4
    80005a10:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80005a14:	854a                	mv	a0,s2
    80005a16:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80005a1a:	00000097          	auipc	ra,0x0
    80005a1e:	b9c080e7          	jalr	-1124(ra) # 800055b6 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80005a22:	8885                	and	s1,s1,1
    80005a24:	f0ed                	bnez	s1,80005a06 <virtio_disk_rw+0x1e4>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80005a26:	00014517          	auipc	a0,0x14
    80005a2a:	6da50513          	add	a0,a0,1754 # 8001a100 <disk+0x128>
    80005a2e:	00001097          	auipc	ra,0x1
    80005a32:	c9e080e7          	jalr	-866(ra) # 800066cc <release>
}
    80005a36:	70a6                	ld	ra,104(sp)
    80005a38:	7406                	ld	s0,96(sp)
    80005a3a:	64e6                	ld	s1,88(sp)
    80005a3c:	6946                	ld	s2,80(sp)
    80005a3e:	69a6                	ld	s3,72(sp)
    80005a40:	6a06                	ld	s4,64(sp)
    80005a42:	7ae2                	ld	s5,56(sp)
    80005a44:	7b42                	ld	s6,48(sp)
    80005a46:	7ba2                	ld	s7,40(sp)
    80005a48:	7c02                	ld	s8,32(sp)
    80005a4a:	6ce2                	ld	s9,24(sp)
    80005a4c:	6d42                	ld	s10,16(sp)
    80005a4e:	6165                	add	sp,sp,112
    80005a50:	8082                	ret

0000000080005a52 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80005a52:	1101                	add	sp,sp,-32
    80005a54:	ec06                	sd	ra,24(sp)
    80005a56:	e822                	sd	s0,16(sp)
    80005a58:	e426                	sd	s1,8(sp)
    80005a5a:	1000                	add	s0,sp,32
  acquire(&disk.vdisk_lock);
    80005a5c:	00014497          	auipc	s1,0x14
    80005a60:	57c48493          	add	s1,s1,1404 # 80019fd8 <disk>
    80005a64:	00014517          	auipc	a0,0x14
    80005a68:	69c50513          	add	a0,a0,1692 # 8001a100 <disk+0x128>
    80005a6c:	00001097          	auipc	ra,0x1
    80005a70:	bac080e7          	jalr	-1108(ra) # 80006618 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80005a74:	10001737          	lui	a4,0x10001
    80005a78:	533c                	lw	a5,96(a4)
    80005a7a:	8b8d                	and	a5,a5,3
    80005a7c:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    80005a7e:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80005a82:	689c                	ld	a5,16(s1)
    80005a84:	0204d703          	lhu	a4,32(s1)
    80005a88:	0027d783          	lhu	a5,2(a5)
    80005a8c:	04f70863          	beq	a4,a5,80005adc <virtio_disk_intr+0x8a>
    __sync_synchronize();
    80005a90:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80005a94:	6898                	ld	a4,16(s1)
    80005a96:	0204d783          	lhu	a5,32(s1)
    80005a9a:	8b9d                	and	a5,a5,7
    80005a9c:	078e                	sll	a5,a5,0x3
    80005a9e:	97ba                	add	a5,a5,a4
    80005aa0:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80005aa2:	00278713          	add	a4,a5,2
    80005aa6:	0712                	sll	a4,a4,0x4
    80005aa8:	9726                	add	a4,a4,s1
    80005aaa:	01074703          	lbu	a4,16(a4) # 10001010 <_entry-0x6fffeff0>
    80005aae:	e721                	bnez	a4,80005af6 <virtio_disk_intr+0xa4>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80005ab0:	0789                	add	a5,a5,2
    80005ab2:	0792                	sll	a5,a5,0x4
    80005ab4:	97a6                	add	a5,a5,s1
    80005ab6:	6788                	ld	a0,8(a5)
    b->disk = 0;   // disk is done with buf
    80005ab8:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80005abc:	ffffc097          	auipc	ra,0xffffc
    80005ac0:	d42080e7          	jalr	-702(ra) # 800017fe <wakeup>

    disk.used_idx += 1;
    80005ac4:	0204d783          	lhu	a5,32(s1)
    80005ac8:	2785                	addw	a5,a5,1
    80005aca:	17c2                	sll	a5,a5,0x30
    80005acc:	93c1                	srl	a5,a5,0x30
    80005ace:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80005ad2:	6898                	ld	a4,16(s1)
    80005ad4:	00275703          	lhu	a4,2(a4)
    80005ad8:	faf71ce3          	bne	a4,a5,80005a90 <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    80005adc:	00014517          	auipc	a0,0x14
    80005ae0:	62450513          	add	a0,a0,1572 # 8001a100 <disk+0x128>
    80005ae4:	00001097          	auipc	ra,0x1
    80005ae8:	be8080e7          	jalr	-1048(ra) # 800066cc <release>
}
    80005aec:	60e2                	ld	ra,24(sp)
    80005aee:	6442                	ld	s0,16(sp)
    80005af0:	64a2                	ld	s1,8(sp)
    80005af2:	6105                	add	sp,sp,32
    80005af4:	8082                	ret
      panic("virtio_disk_intr status");
    80005af6:	00003517          	auipc	a0,0x3
    80005afa:	eb250513          	add	a0,a0,-334 # 800089a8 <syscallnames+0x3e8>
    80005afe:	00000097          	auipc	ra,0x0
    80005b02:	5e2080e7          	jalr	1506(ra) # 800060e0 <panic>

0000000080005b06 <timerinit>:
// at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    80005b06:	1141                	add	sp,sp,-16
    80005b08:	e422                	sd	s0,8(sp)
    80005b0a:	0800                	add	s0,sp,16
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005b0c:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80005b10:	0007859b          	sext.w	a1,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    80005b14:	0037979b          	sllw	a5,a5,0x3
    80005b18:	02004737          	lui	a4,0x2004
    80005b1c:	97ba                	add	a5,a5,a4
    80005b1e:	0200c737          	lui	a4,0x200c
    80005b22:	ff873703          	ld	a4,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005b26:	000f4637          	lui	a2,0xf4
    80005b2a:	24060613          	add	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005b2e:	9732                	add	a4,a4,a2
    80005b30:	e398                	sd	a4,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    80005b32:	00259693          	sll	a3,a1,0x2
    80005b36:	96ae                	add	a3,a3,a1
    80005b38:	068e                	sll	a3,a3,0x3
    80005b3a:	00014717          	auipc	a4,0x14
    80005b3e:	5e670713          	add	a4,a4,1510 # 8001a120 <timer_scratch>
    80005b42:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    80005b44:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    80005b46:	f310                	sd	a2,32(a4)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80005b48:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    80005b4c:	00000797          	auipc	a5,0x0
    80005b50:	9a478793          	add	a5,a5,-1628 # 800054f0 <timervec>
    80005b54:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005b58:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80005b5c:	0087e793          	or	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005b60:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    80005b64:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80005b68:	0807e793          	or	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80005b6c:	30479073          	csrw	mie,a5
}
    80005b70:	6422                	ld	s0,8(sp)
    80005b72:	0141                	add	sp,sp,16
    80005b74:	8082                	ret

0000000080005b76 <start>:
{
    80005b76:	1141                	add	sp,sp,-16
    80005b78:	e406                	sd	ra,8(sp)
    80005b7a:	e022                	sd	s0,0(sp)
    80005b7c:	0800                	add	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005b7e:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80005b82:	7779                	lui	a4,0xffffe
    80005b84:	7ff70713          	add	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffdc49f>
    80005b88:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    80005b8a:	6705                	lui	a4,0x1
    80005b8c:	80070713          	add	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005b90:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005b92:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80005b96:	ffffa797          	auipc	a5,0xffffa
    80005b9a:	7d278793          	add	a5,a5,2002 # 80000368 <main>
    80005b9e:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80005ba2:	4781                	li	a5,0
    80005ba4:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80005ba8:	67c1                	lui	a5,0x10
    80005baa:	17fd                	add	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80005bac:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80005bb0:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80005bb4:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80005bb8:	2227e793          	or	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80005bbc:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80005bc0:	57fd                	li	a5,-1
    80005bc2:	83a9                	srl	a5,a5,0xa
    80005bc4:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80005bc8:	47bd                	li	a5,15
    80005bca:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    80005bce:	00000097          	auipc	ra,0x0
    80005bd2:	f38080e7          	jalr	-200(ra) # 80005b06 <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005bd6:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80005bda:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    80005bdc:	823e                	mv	tp,a5
  asm volatile("mret");
    80005bde:	30200073          	mret
}
    80005be2:	60a2                	ld	ra,8(sp)
    80005be4:	6402                	ld	s0,0(sp)
    80005be6:	0141                	add	sp,sp,16
    80005be8:	8082                	ret

0000000080005bea <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80005bea:	715d                	add	sp,sp,-80
    80005bec:	e486                	sd	ra,72(sp)
    80005bee:	e0a2                	sd	s0,64(sp)
    80005bf0:	fc26                	sd	s1,56(sp)
    80005bf2:	f84a                	sd	s2,48(sp)
    80005bf4:	f44e                	sd	s3,40(sp)
    80005bf6:	f052                	sd	s4,32(sp)
    80005bf8:	ec56                	sd	s5,24(sp)
    80005bfa:	0880                	add	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    80005bfc:	04c05763          	blez	a2,80005c4a <consolewrite+0x60>
    80005c00:	8a2a                	mv	s4,a0
    80005c02:	84ae                	mv	s1,a1
    80005c04:	89b2                	mv	s3,a2
    80005c06:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80005c08:	5afd                	li	s5,-1
    80005c0a:	4685                	li	a3,1
    80005c0c:	8626                	mv	a2,s1
    80005c0e:	85d2                	mv	a1,s4
    80005c10:	fbf40513          	add	a0,s0,-65
    80005c14:	ffffc097          	auipc	ra,0xffffc
    80005c18:	fe4080e7          	jalr	-28(ra) # 80001bf8 <either_copyin>
    80005c1c:	01550d63          	beq	a0,s5,80005c36 <consolewrite+0x4c>
      break;
    uartputc(c);
    80005c20:	fbf44503          	lbu	a0,-65(s0)
    80005c24:	00001097          	auipc	ra,0x1
    80005c28:	83a080e7          	jalr	-1990(ra) # 8000645e <uartputc>
  for(i = 0; i < n; i++){
    80005c2c:	2905                	addw	s2,s2,1
    80005c2e:	0485                	add	s1,s1,1
    80005c30:	fd299de3          	bne	s3,s2,80005c0a <consolewrite+0x20>
    80005c34:	894e                	mv	s2,s3
  }

  return i;
}
    80005c36:	854a                	mv	a0,s2
    80005c38:	60a6                	ld	ra,72(sp)
    80005c3a:	6406                	ld	s0,64(sp)
    80005c3c:	74e2                	ld	s1,56(sp)
    80005c3e:	7942                	ld	s2,48(sp)
    80005c40:	79a2                	ld	s3,40(sp)
    80005c42:	7a02                	ld	s4,32(sp)
    80005c44:	6ae2                	ld	s5,24(sp)
    80005c46:	6161                	add	sp,sp,80
    80005c48:	8082                	ret
  for(i = 0; i < n; i++){
    80005c4a:	4901                	li	s2,0
    80005c4c:	b7ed                	j	80005c36 <consolewrite+0x4c>

0000000080005c4e <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80005c4e:	711d                	add	sp,sp,-96
    80005c50:	ec86                	sd	ra,88(sp)
    80005c52:	e8a2                	sd	s0,80(sp)
    80005c54:	e4a6                	sd	s1,72(sp)
    80005c56:	e0ca                	sd	s2,64(sp)
    80005c58:	fc4e                	sd	s3,56(sp)
    80005c5a:	f852                	sd	s4,48(sp)
    80005c5c:	f456                	sd	s5,40(sp)
    80005c5e:	f05a                	sd	s6,32(sp)
    80005c60:	ec5e                	sd	s7,24(sp)
    80005c62:	e862                	sd	s8,16(sp)
    80005c64:	1080                	add	s0,sp,96
    80005c66:	8b2a                	mv	s6,a0
    80005c68:	8aae                	mv	s5,a1
    80005c6a:	8a32                	mv	s4,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80005c6c:	00060b9b          	sext.w	s7,a2
  acquire(&cons.lock);
    80005c70:	0001c517          	auipc	a0,0x1c
    80005c74:	5f050513          	add	a0,a0,1520 # 80022260 <cons>
    80005c78:	00001097          	auipc	ra,0x1
    80005c7c:	9a0080e7          	jalr	-1632(ra) # 80006618 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80005c80:	0001c497          	auipc	s1,0x1c
    80005c84:	5e048493          	add	s1,s1,1504 # 80022260 <cons>
      if(killed(myproc())){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80005c88:	0001c917          	auipc	s2,0x1c
    80005c8c:	67090913          	add	s2,s2,1648 # 800222f8 <cons+0x98>
  while(n > 0){
    80005c90:	0f405963          	blez	s4,80005d82 <consoleread+0x134>
    while(cons.r == cons.w){
    80005c94:	0984a783          	lw	a5,152(s1)
    80005c98:	09c4a703          	lw	a4,156(s1)
    80005c9c:	02f71763          	bne	a4,a5,80005cca <consoleread+0x7c>
      if(killed(myproc())){
    80005ca0:	ffffb097          	auipc	ra,0xffffb
    80005ca4:	32a080e7          	jalr	810(ra) # 80000fca <myproc>
    80005ca8:	ffffc097          	auipc	ra,0xffffc
    80005cac:	d9a080e7          	jalr	-614(ra) # 80001a42 <killed>
    80005cb0:	e149                	bnez	a0,80005d32 <consoleread+0xe4>
      sleep(&cons.r, &cons.lock);
    80005cb2:	85a6                	mv	a1,s1
    80005cb4:	854a                	mv	a0,s2
    80005cb6:	ffffc097          	auipc	ra,0xffffc
    80005cba:	ae4080e7          	jalr	-1308(ra) # 8000179a <sleep>
    while(cons.r == cons.w){
    80005cbe:	0984a783          	lw	a5,152(s1)
    80005cc2:	09c4a703          	lw	a4,156(s1)
    80005cc6:	fcf70de3          	beq	a4,a5,80005ca0 <consoleread+0x52>
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    80005cca:	0001c717          	auipc	a4,0x1c
    80005cce:	59670713          	add	a4,a4,1430 # 80022260 <cons>
    80005cd2:	0017869b          	addw	a3,a5,1
    80005cd6:	08d72c23          	sw	a3,152(a4)
    80005cda:	07f7f693          	and	a3,a5,127
    80005cde:	9736                	add	a4,a4,a3
    80005ce0:	01874983          	lbu	s3,24(a4)
    80005ce4:	00098c1b          	sext.w	s8,s3

    if(c == C('D')){  // end-of-file
    80005ce8:	4711                	li	a4,4
    80005cea:	06ec0963          	beq	s8,a4,80005d5c <consoleread+0x10e>
      }
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    80005cee:	fb3407a3          	sb	s3,-81(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005cf2:	4685                	li	a3,1
    80005cf4:	faf40613          	add	a2,s0,-81
    80005cf8:	85d6                	mv	a1,s5
    80005cfa:	855a                	mv	a0,s6
    80005cfc:	ffffc097          	auipc	ra,0xffffc
    80005d00:	ea6080e7          	jalr	-346(ra) # 80001ba2 <either_copyout>
    80005d04:	57fd                	li	a5,-1
    80005d06:	06f50e63          	beq	a0,a5,80005d82 <consoleread+0x134>
      break;

    dst++;
    80005d0a:	0a85                	add	s5,s5,1
    --n;
    80005d0c:	3a7d                	addw	s4,s4,-1

    if(c == '\n' || c == '\x8f' || c == '\x9f' || c == '\x7f' || c == '\xaf' ||
    80005d0e:	47a9                	li	a5,10
    80005d10:	06fc0963          	beq	s8,a5,80005d82 <consoleread+0x134>
    80005d14:	0bf00793          	li	a5,191
    80005d18:	f737ece3          	bltu	a5,s3,80005c90 <consoleread+0x42>
    80005d1c:	08e00793          	li	a5,142
    80005d20:	0537e763          	bltu	a5,s3,80005d6e <consoleread+0x120>
    80005d24:	47a5                	li	a5,9
    80005d26:	0737e963          	bltu	a5,s3,80005d98 <consoleread+0x14a>
    80005d2a:	479d                	li	a5,7
    80005d2c:	f737f2e3          	bgeu	a5,s3,80005c90 <consoleread+0x42>
    80005d30:	a889                	j	80005d82 <consoleread+0x134>
        release(&cons.lock);
    80005d32:	0001c517          	auipc	a0,0x1c
    80005d36:	52e50513          	add	a0,a0,1326 # 80022260 <cons>
    80005d3a:	00001097          	auipc	ra,0x1
    80005d3e:	992080e7          	jalr	-1646(ra) # 800066cc <release>
        return -1;
    80005d42:	557d                	li	a0,-1
    }
  }
  release(&cons.lock);

  return target - n;
}
    80005d44:	60e6                	ld	ra,88(sp)
    80005d46:	6446                	ld	s0,80(sp)
    80005d48:	64a6                	ld	s1,72(sp)
    80005d4a:	6906                	ld	s2,64(sp)
    80005d4c:	79e2                	ld	s3,56(sp)
    80005d4e:	7a42                	ld	s4,48(sp)
    80005d50:	7aa2                	ld	s5,40(sp)
    80005d52:	7b02                	ld	s6,32(sp)
    80005d54:	6be2                	ld	s7,24(sp)
    80005d56:	6c42                	ld	s8,16(sp)
    80005d58:	6125                	add	sp,sp,96
    80005d5a:	8082                	ret
      if(n < target){
    80005d5c:	000a071b          	sext.w	a4,s4
    80005d60:	03777163          	bgeu	a4,s7,80005d82 <consoleread+0x134>
        cons.r--;
    80005d64:	0001c717          	auipc	a4,0x1c
    80005d68:	58f72a23          	sw	a5,1428(a4) # 800222f8 <cons+0x98>
    80005d6c:	a819                	j	80005d82 <consoleread+0x134>
    80005d6e:	0719899b          	addw	s3,s3,113
    80005d72:	00002797          	auipc	a5,0x2
    80005d76:	2967b783          	ld	a5,662(a5) # 80008008 <etext+0x8>
    80005d7a:	0137d7b3          	srl	a5,a5,s3
    80005d7e:	8b85                	and	a5,a5,1
    80005d80:	db81                	beqz	a5,80005c90 <consoleread+0x42>
  release(&cons.lock);
    80005d82:	0001c517          	auipc	a0,0x1c
    80005d86:	4de50513          	add	a0,a0,1246 # 80022260 <cons>
    80005d8a:	00001097          	auipc	ra,0x1
    80005d8e:	942080e7          	jalr	-1726(ra) # 800066cc <release>
  return target - n;
    80005d92:	414b853b          	subw	a0,s7,s4
    80005d96:	b77d                	j	80005d44 <consoleread+0xf6>
    80005d98:	07f00793          	li	a5,127
    80005d9c:	eef99ae3          	bne	s3,a5,80005c90 <consoleread+0x42>
    80005da0:	b7cd                	j	80005d82 <consoleread+0x134>

0000000080005da2 <consputc>:
{
    80005da2:	1141                	add	sp,sp,-16
    80005da4:	e406                	sd	ra,8(sp)
    80005da6:	e022                	sd	s0,0(sp)
    80005da8:	0800                	add	s0,sp,16
  if(c == BACKSPACE){
    80005daa:	10000793          	li	a5,256
    80005dae:	00f50a63          	beq	a0,a5,80005dc2 <consputc+0x20>
    uartputc_sync(c);
    80005db2:	00000097          	auipc	ra,0x0
    80005db6:	5da080e7          	jalr	1498(ra) # 8000638c <uartputc_sync>
}
    80005dba:	60a2                	ld	ra,8(sp)
    80005dbc:	6402                	ld	s0,0(sp)
    80005dbe:	0141                	add	sp,sp,16
    80005dc0:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80005dc2:	4521                	li	a0,8
    80005dc4:	00000097          	auipc	ra,0x0
    80005dc8:	5c8080e7          	jalr	1480(ra) # 8000638c <uartputc_sync>
    80005dcc:	02000513          	li	a0,32
    80005dd0:	00000097          	auipc	ra,0x0
    80005dd4:	5bc080e7          	jalr	1468(ra) # 8000638c <uartputc_sync>
    80005dd8:	4521                	li	a0,8
    80005dda:	00000097          	auipc	ra,0x0
    80005dde:	5b2080e7          	jalr	1458(ra) # 8000638c <uartputc_sync>
    80005de2:	bfe1                	j	80005dba <consputc+0x18>

0000000080005de4 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80005de4:	1101                	add	sp,sp,-32
    80005de6:	ec06                	sd	ra,24(sp)
    80005de8:	e822                	sd	s0,16(sp)
    80005dea:	e426                	sd	s1,8(sp)
    80005dec:	e04a                	sd	s2,0(sp)
    80005dee:	1000                	add	s0,sp,32
    80005df0:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80005df2:	0001c517          	auipc	a0,0x1c
    80005df6:	46e50513          	add	a0,a0,1134 # 80022260 <cons>
    80005dfa:	00001097          	auipc	ra,0x1
    80005dfe:	81e080e7          	jalr	-2018(ra) # 80006618 <acquire>

  switch(c){
    80005e02:	47c1                	li	a5,16
    80005e04:	04f48b63          	beq	s1,a5,80005e5a <consoleintr+0x76>
    80005e08:	47d5                	li	a5,21
    80005e0a:	06f49a63          	bne	s1,a5,80005e7e <consoleintr+0x9a>
  case C('P'):  // Print process list.
    procdump();
    break;
  case C('U'):  // Kill line.
    while(cons.e != cons.w &&
    80005e0e:	0001c717          	auipc	a4,0x1c
    80005e12:	45270713          	add	a4,a4,1106 # 80022260 <cons>
    80005e16:	0a072783          	lw	a5,160(a4)
    80005e1a:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80005e1e:	0001c497          	auipc	s1,0x1c
    80005e22:	44248493          	add	s1,s1,1090 # 80022260 <cons>
    while(cons.e != cons.w &&
    80005e26:	4929                	li	s2,10
    80005e28:	02f70d63          	beq	a4,a5,80005e62 <consoleintr+0x7e>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80005e2c:	37fd                	addw	a5,a5,-1
    80005e2e:	07f7f713          	and	a4,a5,127
    80005e32:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    80005e34:	01874703          	lbu	a4,24(a4)
    80005e38:	03270563          	beq	a4,s2,80005e62 <consoleintr+0x7e>
      cons.e--;
    80005e3c:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    80005e40:	10000513          	li	a0,256
    80005e44:	00000097          	auipc	ra,0x0
    80005e48:	f5e080e7          	jalr	-162(ra) # 80005da2 <consputc>
    while(cons.e != cons.w &&
    80005e4c:	0a04a783          	lw	a5,160(s1)
    80005e50:	09c4a703          	lw	a4,156(s1)
    80005e54:	fcf71ce3          	bne	a4,a5,80005e2c <consoleintr+0x48>
    80005e58:	a029                	j	80005e62 <consoleintr+0x7e>
    procdump();
    80005e5a:	ffffc097          	auipc	ra,0xffffc
    80005e5e:	df4080e7          	jalr	-524(ra) # 80001c4e <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80005e62:	0001c517          	auipc	a0,0x1c
    80005e66:	3fe50513          	add	a0,a0,1022 # 80022260 <cons>
    80005e6a:	00001097          	auipc	ra,0x1
    80005e6e:	862080e7          	jalr	-1950(ra) # 800066cc <release>
}
    80005e72:	60e2                	ld	ra,24(sp)
    80005e74:	6442                	ld	s0,16(sp)
    80005e76:	64a2                	ld	s1,8(sp)
    80005e78:	6902                	ld	s2,0(sp)
    80005e7a:	6105                	add	sp,sp,32
    80005e7c:	8082                	ret
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80005e7e:	d0f5                	beqz	s1,80005e62 <consoleintr+0x7e>
    80005e80:	0001c717          	auipc	a4,0x1c
    80005e84:	3e070713          	add	a4,a4,992 # 80022260 <cons>
    80005e88:	0a072783          	lw	a5,160(a4)
    80005e8c:	09872703          	lw	a4,152(a4)
    80005e90:	9f99                	subw	a5,a5,a4
    80005e92:	07f00713          	li	a4,127
    80005e96:	fcf766e3          	bltu	a4,a5,80005e62 <consoleintr+0x7e>
      c = (c == '\r') ? '\n' : c;
    80005e9a:	47b5                	li	a5,13
    80005e9c:	12f48563          	beq	s1,a5,80005fc6 <consoleintr+0x1e2>
      if (c == 0x1b)
    80005ea0:	47ed                	li	a5,27
    80005ea2:	0cf48963          	beq	s1,a5,80005f74 <consoleintr+0x190>
      else if ((c == 0x5b) && (skipchar == 2))
    80005ea6:	05b00793          	li	a5,91
    80005eaa:	08f49763          	bne	s1,a5,80005f38 <consoleintr+0x154>
    80005eae:	00003717          	auipc	a4,0x3
    80005eb2:	bfe72703          	lw	a4,-1026(a4) # 80008aac <skipchar>
    80005eb6:	4789                	li	a5,2
    80005eb8:	0ef70e63          	beq	a4,a5,80005fb4 <consoleintr+0x1d0>
      else if (skipchar) {
    80005ebc:	00003797          	auipc	a5,0x3
    80005ec0:	bf07a783          	lw	a5,-1040(a5) # 80008aac <skipchar>
    80005ec4:	ebf5                	bnez	a5,80005fb8 <consoleintr+0x1d4>
      else if (c != '\t')
    80005ec6:	47a5                	li	a5,9
    80005ec8:	08f49563          	bne	s1,a5,80005f52 <consoleintr+0x16e>
        cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80005ecc:	0001c797          	auipc	a5,0x1c
    80005ed0:	39478793          	add	a5,a5,916 # 80022260 <cons>
    80005ed4:	0a07a703          	lw	a4,160(a5)
    80005ed8:	0017069b          	addw	a3,a4,1
    80005edc:	0ad7a023          	sw	a3,160(a5)
    80005ee0:	07f77713          	and	a4,a4,127
    80005ee4:	97ba                	add	a5,a5,a4
    80005ee6:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == '\t' || c == '\x8f' || c == '\x9f' || c == '\x7f' || c == '\xaf' ||
    80005eea:	0004879b          	sext.w	a5,s1
    80005eee:	ff74871b          	addw	a4,s1,-9
    80005ef2:	4685                	li	a3,1
    80005ef4:	08e6ff63          	bgeu	a3,a4,80005f92 <consoleintr+0x1ae>
    80005ef8:	0bf00713          	li	a4,191
    80005efc:	02974063          	blt	a4,s1,80005f1c <consoleintr+0x138>
    80005f00:	08e00713          	li	a4,142
    80005f04:	06975f63          	bge	a4,s1,80005f82 <consoleintr+0x19e>
    80005f08:	f717879b          	addw	a5,a5,-143
    80005f0c:	00002717          	auipc	a4,0x2
    80005f10:	0fc73703          	ld	a4,252(a4) # 80008008 <etext+0x8>
    80005f14:	00f757b3          	srl	a5,a4,a5
    80005f18:	8b85                	and	a5,a5,1
    80005f1a:	efa5                	bnez	a5,80005f92 <consoleintr+0x1ae>
         c == '\xbf' || c == C('H') || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    80005f1c:	0001c717          	auipc	a4,0x1c
    80005f20:	34470713          	add	a4,a4,836 # 80022260 <cons>
    80005f24:	0a072783          	lw	a5,160(a4)
    80005f28:	09872703          	lw	a4,152(a4)
    80005f2c:	9f99                	subw	a5,a5,a4
    80005f2e:	08000713          	li	a4,128
    80005f32:	f2e798e3          	bne	a5,a4,80005e62 <consoleintr+0x7e>
    80005f36:	a8b1                	j	80005f92 <consoleintr+0x1ae>
      else if (skipchar) {
    80005f38:	00003797          	auipc	a5,0x3
    80005f3c:	b747a783          	lw	a5,-1164(a5) # 80008aac <skipchar>
    80005f40:	d3d9                	beqz	a5,80005ec6 <consoleintr+0xe2>
    80005f42:	a841                	j	80005fd2 <consoleintr+0x1ee>
        else if (c == 0x43)
    80005f44:	04300793          	li	a5,67
    80005f48:	02f49363          	bne	s1,a5,80005f6e <consoleintr+0x18a>
          c = '\xaf';
    80005f4c:	0af00493          	li	s1,175
    80005f50:	bfb5                	j	80005ecc <consoleintr+0xe8>
        consputc(c);
    80005f52:	8526                	mv	a0,s1
    80005f54:	00000097          	auipc	ra,0x0
    80005f58:	e4e080e7          	jalr	-434(ra) # 80005da2 <consputc>
      if (!skipchar)
    80005f5c:	00003797          	auipc	a5,0x3
    80005f60:	b507a783          	lw	a5,-1200(a5) # 80008aac <skipchar>
    80005f64:	f3d9                	bnez	a5,80005eea <consoleintr+0x106>
    80005f66:	b79d                	j	80005ecc <consoleintr+0xe8>
          c = '\x8f';
    80005f68:	08f00493          	li	s1,143
    80005f6c:	b785                	j	80005ecc <consoleintr+0xe8>
          c = '\xbf';
    80005f6e:	0bf00493          	li	s1,191
      if (!skipchar)
    80005f72:	bfa9                	j	80005ecc <consoleintr+0xe8>
    80005f74:	4789                	li	a5,2
        skipchar = 1;
    80005f76:	00003717          	auipc	a4,0x3
    80005f7a:	b2f72b23          	sw	a5,-1226(a4) # 80008aac <skipchar>
      if(c == '\n' || c == '\t' || c == '\x8f' || c == '\x9f' || c == '\x7f' || c == '\xaf' ||
    80005f7e:	0004879b          	sext.w	a5,s1
    80005f82:	37f1                	addw	a5,a5,-4
    80005f84:	9bed                	and	a5,a5,-5
    80005f86:	2781                	sext.w	a5,a5
    80005f88:	c789                	beqz	a5,80005f92 <consoleintr+0x1ae>
    80005f8a:	07f00793          	li	a5,127
    80005f8e:	f8f497e3          	bne	s1,a5,80005f1c <consoleintr+0x138>
        cons.w = cons.e;
    80005f92:	0001c797          	auipc	a5,0x1c
    80005f96:	2ce78793          	add	a5,a5,718 # 80022260 <cons>
    80005f9a:	0a07a703          	lw	a4,160(a5)
    80005f9e:	08e7ae23          	sw	a4,156(a5)
        wakeup(&cons.r);
    80005fa2:	0001c517          	auipc	a0,0x1c
    80005fa6:	35650513          	add	a0,a0,854 # 800222f8 <cons+0x98>
    80005faa:	ffffc097          	auipc	ra,0xffffc
    80005fae:	854080e7          	jalr	-1964(ra) # 800017fe <wakeup>
    80005fb2:	bd45                	j	80005e62 <consoleintr+0x7e>
    80005fb4:	4785                	li	a5,1
    80005fb6:	b7c1                	j	80005f76 <consoleintr+0x192>
        skipchar = 0;
    80005fb8:	00003797          	auipc	a5,0x3
    80005fbc:	ae07aa23          	sw	zero,-1292(a5) # 80008aac <skipchar>
          c = '\xbf';
    80005fc0:	0bf00493          	li	s1,191
    80005fc4:	b721                	j	80005ecc <consoleintr+0xe8>
      else if (skipchar) {
    80005fc6:	00003797          	auipc	a5,0x3
    80005fca:	ae67a783          	lw	a5,-1306(a5) # 80008aac <skipchar>
      c = (c == '\r') ? '\n' : c;
    80005fce:	44a9                	li	s1,10
      else if (skipchar) {
    80005fd0:	d3c9                	beqz	a5,80005f52 <consoleintr+0x16e>
        skipchar = 0;
    80005fd2:	00003797          	auipc	a5,0x3
    80005fd6:	ac07ad23          	sw	zero,-1318(a5) # 80008aac <skipchar>
        if (c == 0x41)
    80005fda:	04100793          	li	a5,65
    80005fde:	f8f485e3          	beq	s1,a5,80005f68 <consoleintr+0x184>
        else if (c == 0x42)
    80005fe2:	04200793          	li	a5,66
    80005fe6:	f4f49fe3          	bne	s1,a5,80005f44 <consoleintr+0x160>
          c = '\x9f';
    80005fea:	09f00493          	li	s1,159
    80005fee:	bdf9                	j	80005ecc <consoleintr+0xe8>

0000000080005ff0 <consoleinit>:

void
consoleinit(void)
{
    80005ff0:	1141                	add	sp,sp,-16
    80005ff2:	e406                	sd	ra,8(sp)
    80005ff4:	e022                	sd	s0,0(sp)
    80005ff6:	0800                	add	s0,sp,16
  initlock(&cons.lock, "cons");
    80005ff8:	00003597          	auipc	a1,0x3
    80005ffc:	9c858593          	add	a1,a1,-1592 # 800089c0 <syscallnames+0x400>
    80006000:	0001c517          	auipc	a0,0x1c
    80006004:	26050513          	add	a0,a0,608 # 80022260 <cons>
    80006008:	00000097          	auipc	ra,0x0
    8000600c:	580080e7          	jalr	1408(ra) # 80006588 <initlock>

  uartinit();
    80006010:	00000097          	auipc	ra,0x0
    80006014:	32c080e7          	jalr	812(ra) # 8000633c <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80006018:	00013797          	auipc	a5,0x13
    8000601c:	f6878793          	add	a5,a5,-152 # 80018f80 <devsw>
    80006020:	00000717          	auipc	a4,0x0
    80006024:	c2e70713          	add	a4,a4,-978 # 80005c4e <consoleread>
    80006028:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    8000602a:	00000717          	auipc	a4,0x0
    8000602e:	bc070713          	add	a4,a4,-1088 # 80005bea <consolewrite>
    80006032:	ef98                	sd	a4,24(a5)
}
    80006034:	60a2                	ld	ra,8(sp)
    80006036:	6402                	ld	s0,0(sp)
    80006038:	0141                	add	sp,sp,16
    8000603a:	8082                	ret

000000008000603c <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    8000603c:	7179                	add	sp,sp,-48
    8000603e:	f406                	sd	ra,40(sp)
    80006040:	f022                	sd	s0,32(sp)
    80006042:	ec26                	sd	s1,24(sp)
    80006044:	e84a                	sd	s2,16(sp)
    80006046:	1800                	add	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    80006048:	c219                	beqz	a2,8000604e <printint+0x12>
    8000604a:	08054763          	bltz	a0,800060d8 <printint+0x9c>
    x = -xx;
  else
    x = xx;
    8000604e:	2501                	sext.w	a0,a0
    80006050:	4881                	li	a7,0
    80006052:	fd040693          	add	a3,s0,-48

  i = 0;
    80006056:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    80006058:	2581                	sext.w	a1,a1
    8000605a:	00003617          	auipc	a2,0x3
    8000605e:	99660613          	add	a2,a2,-1642 # 800089f0 <digits>
    80006062:	883a                	mv	a6,a4
    80006064:	2705                	addw	a4,a4,1
    80006066:	02b577bb          	remuw	a5,a0,a1
    8000606a:	1782                	sll	a5,a5,0x20
    8000606c:	9381                	srl	a5,a5,0x20
    8000606e:	97b2                	add	a5,a5,a2
    80006070:	0007c783          	lbu	a5,0(a5)
    80006074:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    80006078:	0005079b          	sext.w	a5,a0
    8000607c:	02b5553b          	divuw	a0,a0,a1
    80006080:	0685                	add	a3,a3,1
    80006082:	feb7f0e3          	bgeu	a5,a1,80006062 <printint+0x26>

  if(sign)
    80006086:	00088c63          	beqz	a7,8000609e <printint+0x62>
    buf[i++] = '-';
    8000608a:	fe070793          	add	a5,a4,-32
    8000608e:	00878733          	add	a4,a5,s0
    80006092:	02d00793          	li	a5,45
    80006096:	fef70823          	sb	a5,-16(a4)
    8000609a:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
    8000609e:	02e05763          	blez	a4,800060cc <printint+0x90>
    800060a2:	fd040793          	add	a5,s0,-48
    800060a6:	00e784b3          	add	s1,a5,a4
    800060aa:	fff78913          	add	s2,a5,-1
    800060ae:	993a                	add	s2,s2,a4
    800060b0:	377d                	addw	a4,a4,-1
    800060b2:	1702                	sll	a4,a4,0x20
    800060b4:	9301                	srl	a4,a4,0x20
    800060b6:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    800060ba:	fff4c503          	lbu	a0,-1(s1)
    800060be:	00000097          	auipc	ra,0x0
    800060c2:	ce4080e7          	jalr	-796(ra) # 80005da2 <consputc>
  while(--i >= 0)
    800060c6:	14fd                	add	s1,s1,-1
    800060c8:	ff2499e3          	bne	s1,s2,800060ba <printint+0x7e>
}
    800060cc:	70a2                	ld	ra,40(sp)
    800060ce:	7402                	ld	s0,32(sp)
    800060d0:	64e2                	ld	s1,24(sp)
    800060d2:	6942                	ld	s2,16(sp)
    800060d4:	6145                	add	sp,sp,48
    800060d6:	8082                	ret
    x = -xx;
    800060d8:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    800060dc:	4885                	li	a7,1
    x = -xx;
    800060de:	bf95                	j	80006052 <printint+0x16>

00000000800060e0 <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    800060e0:	1101                	add	sp,sp,-32
    800060e2:	ec06                	sd	ra,24(sp)
    800060e4:	e822                	sd	s0,16(sp)
    800060e6:	e426                	sd	s1,8(sp)
    800060e8:	1000                	add	s0,sp,32
    800060ea:	84aa                	mv	s1,a0
  pr.locking = 0;
    800060ec:	0001c797          	auipc	a5,0x1c
    800060f0:	2207aa23          	sw	zero,564(a5) # 80022320 <pr+0x18>
  printf("panic: ");
    800060f4:	00003517          	auipc	a0,0x3
    800060f8:	8d450513          	add	a0,a0,-1836 # 800089c8 <syscallnames+0x408>
    800060fc:	00000097          	auipc	ra,0x0
    80006100:	02e080e7          	jalr	46(ra) # 8000612a <printf>
  printf(s);
    80006104:	8526                	mv	a0,s1
    80006106:	00000097          	auipc	ra,0x0
    8000610a:	024080e7          	jalr	36(ra) # 8000612a <printf>
  printf("\n");
    8000610e:	00002517          	auipc	a0,0x2
    80006112:	f3a50513          	add	a0,a0,-198 # 80008048 <etext+0x48>
    80006116:	00000097          	auipc	ra,0x0
    8000611a:	014080e7          	jalr	20(ra) # 8000612a <printf>
  panicked = 1; // freeze uart output from other CPUs
    8000611e:	4785                	li	a5,1
    80006120:	00003717          	auipc	a4,0x3
    80006124:	98f72823          	sw	a5,-1648(a4) # 80008ab0 <panicked>
  for(;;)
    80006128:	a001                	j	80006128 <panic+0x48>

000000008000612a <printf>:
{
    8000612a:	7131                	add	sp,sp,-192
    8000612c:	fc86                	sd	ra,120(sp)
    8000612e:	f8a2                	sd	s0,112(sp)
    80006130:	f4a6                	sd	s1,104(sp)
    80006132:	f0ca                	sd	s2,96(sp)
    80006134:	ecce                	sd	s3,88(sp)
    80006136:	e8d2                	sd	s4,80(sp)
    80006138:	e4d6                	sd	s5,72(sp)
    8000613a:	e0da                	sd	s6,64(sp)
    8000613c:	fc5e                	sd	s7,56(sp)
    8000613e:	f862                	sd	s8,48(sp)
    80006140:	f466                	sd	s9,40(sp)
    80006142:	f06a                	sd	s10,32(sp)
    80006144:	ec6e                	sd	s11,24(sp)
    80006146:	0100                	add	s0,sp,128
    80006148:	8a2a                	mv	s4,a0
    8000614a:	e40c                	sd	a1,8(s0)
    8000614c:	e810                	sd	a2,16(s0)
    8000614e:	ec14                	sd	a3,24(s0)
    80006150:	f018                	sd	a4,32(s0)
    80006152:	f41c                	sd	a5,40(s0)
    80006154:	03043823          	sd	a6,48(s0)
    80006158:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    8000615c:	0001cd97          	auipc	s11,0x1c
    80006160:	1c4dad83          	lw	s11,452(s11) # 80022320 <pr+0x18>
  if(locking)
    80006164:	020d9b63          	bnez	s11,8000619a <printf+0x70>
  if (fmt == 0)
    80006168:	040a0263          	beqz	s4,800061ac <printf+0x82>
  va_start(ap, fmt);
    8000616c:	00840793          	add	a5,s0,8
    80006170:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80006174:	000a4503          	lbu	a0,0(s4)
    80006178:	14050f63          	beqz	a0,800062d6 <printf+0x1ac>
    8000617c:	4981                	li	s3,0
    if(c != '%'){
    8000617e:	02500a93          	li	s5,37
    switch(c){
    80006182:	07000b93          	li	s7,112
  consputc('x');
    80006186:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80006188:	00003b17          	auipc	s6,0x3
    8000618c:	868b0b13          	add	s6,s6,-1944 # 800089f0 <digits>
    switch(c){
    80006190:	07300c93          	li	s9,115
    80006194:	06400c13          	li	s8,100
    80006198:	a82d                	j	800061d2 <printf+0xa8>
    acquire(&pr.lock);
    8000619a:	0001c517          	auipc	a0,0x1c
    8000619e:	16e50513          	add	a0,a0,366 # 80022308 <pr>
    800061a2:	00000097          	auipc	ra,0x0
    800061a6:	476080e7          	jalr	1142(ra) # 80006618 <acquire>
    800061aa:	bf7d                	j	80006168 <printf+0x3e>
    panic("null fmt");
    800061ac:	00003517          	auipc	a0,0x3
    800061b0:	82c50513          	add	a0,a0,-2004 # 800089d8 <syscallnames+0x418>
    800061b4:	00000097          	auipc	ra,0x0
    800061b8:	f2c080e7          	jalr	-212(ra) # 800060e0 <panic>
      consputc(c);
    800061bc:	00000097          	auipc	ra,0x0
    800061c0:	be6080e7          	jalr	-1050(ra) # 80005da2 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    800061c4:	2985                	addw	s3,s3,1
    800061c6:	013a07b3          	add	a5,s4,s3
    800061ca:	0007c503          	lbu	a0,0(a5)
    800061ce:	10050463          	beqz	a0,800062d6 <printf+0x1ac>
    if(c != '%'){
    800061d2:	ff5515e3          	bne	a0,s5,800061bc <printf+0x92>
    c = fmt[++i] & 0xff;
    800061d6:	2985                	addw	s3,s3,1
    800061d8:	013a07b3          	add	a5,s4,s3
    800061dc:	0007c783          	lbu	a5,0(a5)
    800061e0:	0007849b          	sext.w	s1,a5
    if(c == 0)
    800061e4:	cbed                	beqz	a5,800062d6 <printf+0x1ac>
    switch(c){
    800061e6:	05778a63          	beq	a5,s7,8000623a <printf+0x110>
    800061ea:	02fbf663          	bgeu	s7,a5,80006216 <printf+0xec>
    800061ee:	09978863          	beq	a5,s9,8000627e <printf+0x154>
    800061f2:	07800713          	li	a4,120
    800061f6:	0ce79563          	bne	a5,a4,800062c0 <printf+0x196>
      printint(va_arg(ap, int), 16, 1);
    800061fa:	f8843783          	ld	a5,-120(s0)
    800061fe:	00878713          	add	a4,a5,8
    80006202:	f8e43423          	sd	a4,-120(s0)
    80006206:	4605                	li	a2,1
    80006208:	85ea                	mv	a1,s10
    8000620a:	4388                	lw	a0,0(a5)
    8000620c:	00000097          	auipc	ra,0x0
    80006210:	e30080e7          	jalr	-464(ra) # 8000603c <printint>
      break;
    80006214:	bf45                	j	800061c4 <printf+0x9a>
    switch(c){
    80006216:	09578f63          	beq	a5,s5,800062b4 <printf+0x18a>
    8000621a:	0b879363          	bne	a5,s8,800062c0 <printf+0x196>
      printint(va_arg(ap, int), 10, 1);
    8000621e:	f8843783          	ld	a5,-120(s0)
    80006222:	00878713          	add	a4,a5,8
    80006226:	f8e43423          	sd	a4,-120(s0)
    8000622a:	4605                	li	a2,1
    8000622c:	45a9                	li	a1,10
    8000622e:	4388                	lw	a0,0(a5)
    80006230:	00000097          	auipc	ra,0x0
    80006234:	e0c080e7          	jalr	-500(ra) # 8000603c <printint>
      break;
    80006238:	b771                	j	800061c4 <printf+0x9a>
      printptr(va_arg(ap, uint64));
    8000623a:	f8843783          	ld	a5,-120(s0)
    8000623e:	00878713          	add	a4,a5,8
    80006242:	f8e43423          	sd	a4,-120(s0)
    80006246:	0007b903          	ld	s2,0(a5)
  consputc('0');
    8000624a:	03000513          	li	a0,48
    8000624e:	00000097          	auipc	ra,0x0
    80006252:	b54080e7          	jalr	-1196(ra) # 80005da2 <consputc>
  consputc('x');
    80006256:	07800513          	li	a0,120
    8000625a:	00000097          	auipc	ra,0x0
    8000625e:	b48080e7          	jalr	-1208(ra) # 80005da2 <consputc>
    80006262:	84ea                	mv	s1,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80006264:	03c95793          	srl	a5,s2,0x3c
    80006268:	97da                	add	a5,a5,s6
    8000626a:	0007c503          	lbu	a0,0(a5)
    8000626e:	00000097          	auipc	ra,0x0
    80006272:	b34080e7          	jalr	-1228(ra) # 80005da2 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80006276:	0912                	sll	s2,s2,0x4
    80006278:	34fd                	addw	s1,s1,-1
    8000627a:	f4ed                	bnez	s1,80006264 <printf+0x13a>
    8000627c:	b7a1                	j	800061c4 <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    8000627e:	f8843783          	ld	a5,-120(s0)
    80006282:	00878713          	add	a4,a5,8
    80006286:	f8e43423          	sd	a4,-120(s0)
    8000628a:	6384                	ld	s1,0(a5)
    8000628c:	cc89                	beqz	s1,800062a6 <printf+0x17c>
      for(; *s; s++)
    8000628e:	0004c503          	lbu	a0,0(s1)
    80006292:	d90d                	beqz	a0,800061c4 <printf+0x9a>
        consputc(*s);
    80006294:	00000097          	auipc	ra,0x0
    80006298:	b0e080e7          	jalr	-1266(ra) # 80005da2 <consputc>
      for(; *s; s++)
    8000629c:	0485                	add	s1,s1,1
    8000629e:	0004c503          	lbu	a0,0(s1)
    800062a2:	f96d                	bnez	a0,80006294 <printf+0x16a>
    800062a4:	b705                	j	800061c4 <printf+0x9a>
        s = "(null)";
    800062a6:	00002497          	auipc	s1,0x2
    800062aa:	72a48493          	add	s1,s1,1834 # 800089d0 <syscallnames+0x410>
      for(; *s; s++)
    800062ae:	02800513          	li	a0,40
    800062b2:	b7cd                	j	80006294 <printf+0x16a>
      consputc('%');
    800062b4:	8556                	mv	a0,s5
    800062b6:	00000097          	auipc	ra,0x0
    800062ba:	aec080e7          	jalr	-1300(ra) # 80005da2 <consputc>
      break;
    800062be:	b719                	j	800061c4 <printf+0x9a>
      consputc('%');
    800062c0:	8556                	mv	a0,s5
    800062c2:	00000097          	auipc	ra,0x0
    800062c6:	ae0080e7          	jalr	-1312(ra) # 80005da2 <consputc>
      consputc(c);
    800062ca:	8526                	mv	a0,s1
    800062cc:	00000097          	auipc	ra,0x0
    800062d0:	ad6080e7          	jalr	-1322(ra) # 80005da2 <consputc>
      break;
    800062d4:	bdc5                	j	800061c4 <printf+0x9a>
  if(locking)
    800062d6:	020d9163          	bnez	s11,800062f8 <printf+0x1ce>
}
    800062da:	70e6                	ld	ra,120(sp)
    800062dc:	7446                	ld	s0,112(sp)
    800062de:	74a6                	ld	s1,104(sp)
    800062e0:	7906                	ld	s2,96(sp)
    800062e2:	69e6                	ld	s3,88(sp)
    800062e4:	6a46                	ld	s4,80(sp)
    800062e6:	6aa6                	ld	s5,72(sp)
    800062e8:	6b06                	ld	s6,64(sp)
    800062ea:	7be2                	ld	s7,56(sp)
    800062ec:	7c42                	ld	s8,48(sp)
    800062ee:	7ca2                	ld	s9,40(sp)
    800062f0:	7d02                	ld	s10,32(sp)
    800062f2:	6de2                	ld	s11,24(sp)
    800062f4:	6129                	add	sp,sp,192
    800062f6:	8082                	ret
    release(&pr.lock);
    800062f8:	0001c517          	auipc	a0,0x1c
    800062fc:	01050513          	add	a0,a0,16 # 80022308 <pr>
    80006300:	00000097          	auipc	ra,0x0
    80006304:	3cc080e7          	jalr	972(ra) # 800066cc <release>
}
    80006308:	bfc9                	j	800062da <printf+0x1b0>

000000008000630a <printfinit>:
    ;
}

void
printfinit(void)
{
    8000630a:	1101                	add	sp,sp,-32
    8000630c:	ec06                	sd	ra,24(sp)
    8000630e:	e822                	sd	s0,16(sp)
    80006310:	e426                	sd	s1,8(sp)
    80006312:	1000                	add	s0,sp,32
  initlock(&pr.lock, "pr");
    80006314:	0001c497          	auipc	s1,0x1c
    80006318:	ff448493          	add	s1,s1,-12 # 80022308 <pr>
    8000631c:	00002597          	auipc	a1,0x2
    80006320:	6cc58593          	add	a1,a1,1740 # 800089e8 <syscallnames+0x428>
    80006324:	8526                	mv	a0,s1
    80006326:	00000097          	auipc	ra,0x0
    8000632a:	262080e7          	jalr	610(ra) # 80006588 <initlock>
  pr.locking = 1;
    8000632e:	4785                	li	a5,1
    80006330:	cc9c                	sw	a5,24(s1)
}
    80006332:	60e2                	ld	ra,24(sp)
    80006334:	6442                	ld	s0,16(sp)
    80006336:	64a2                	ld	s1,8(sp)
    80006338:	6105                	add	sp,sp,32
    8000633a:	8082                	ret

000000008000633c <uartinit>:

void uartstart();

void
uartinit(void)
{
    8000633c:	1141                	add	sp,sp,-16
    8000633e:	e406                	sd	ra,8(sp)
    80006340:	e022                	sd	s0,0(sp)
    80006342:	0800                	add	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80006344:	100007b7          	lui	a5,0x10000
    80006348:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    8000634c:	f8000713          	li	a4,-128
    80006350:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80006354:	470d                	li	a4,3
    80006356:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    8000635a:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    8000635e:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80006362:	469d                	li	a3,7
    80006364:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    80006368:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    8000636c:	00002597          	auipc	a1,0x2
    80006370:	69c58593          	add	a1,a1,1692 # 80008a08 <digits+0x18>
    80006374:	0001c517          	auipc	a0,0x1c
    80006378:	fb450513          	add	a0,a0,-76 # 80022328 <uart_tx_lock>
    8000637c:	00000097          	auipc	ra,0x0
    80006380:	20c080e7          	jalr	524(ra) # 80006588 <initlock>
}
    80006384:	60a2                	ld	ra,8(sp)
    80006386:	6402                	ld	s0,0(sp)
    80006388:	0141                	add	sp,sp,16
    8000638a:	8082                	ret

000000008000638c <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    8000638c:	1101                	add	sp,sp,-32
    8000638e:	ec06                	sd	ra,24(sp)
    80006390:	e822                	sd	s0,16(sp)
    80006392:	e426                	sd	s1,8(sp)
    80006394:	1000                	add	s0,sp,32
    80006396:	84aa                	mv	s1,a0
  push_off();
    80006398:	00000097          	auipc	ra,0x0
    8000639c:	234080e7          	jalr	564(ra) # 800065cc <push_off>

  if(panicked){
    800063a0:	00002797          	auipc	a5,0x2
    800063a4:	7107a783          	lw	a5,1808(a5) # 80008ab0 <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    800063a8:	10000737          	lui	a4,0x10000
  if(panicked){
    800063ac:	c391                	beqz	a5,800063b0 <uartputc_sync+0x24>
    for(;;)
    800063ae:	a001                	j	800063ae <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    800063b0:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800063b4:	0207f793          	and	a5,a5,32
    800063b8:	dfe5                	beqz	a5,800063b0 <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    800063ba:	0ff4f513          	zext.b	a0,s1
    800063be:	100007b7          	lui	a5,0x10000
    800063c2:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    800063c6:	00000097          	auipc	ra,0x0
    800063ca:	2a6080e7          	jalr	678(ra) # 8000666c <pop_off>
}
    800063ce:	60e2                	ld	ra,24(sp)
    800063d0:	6442                	ld	s0,16(sp)
    800063d2:	64a2                	ld	s1,8(sp)
    800063d4:	6105                	add	sp,sp,32
    800063d6:	8082                	ret

00000000800063d8 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    800063d8:	00002797          	auipc	a5,0x2
    800063dc:	6e07b783          	ld	a5,1760(a5) # 80008ab8 <uart_tx_r>
    800063e0:	00002717          	auipc	a4,0x2
    800063e4:	6e073703          	ld	a4,1760(a4) # 80008ac0 <uart_tx_w>
    800063e8:	06f70a63          	beq	a4,a5,8000645c <uartstart+0x84>
{
    800063ec:	7139                	add	sp,sp,-64
    800063ee:	fc06                	sd	ra,56(sp)
    800063f0:	f822                	sd	s0,48(sp)
    800063f2:	f426                	sd	s1,40(sp)
    800063f4:	f04a                	sd	s2,32(sp)
    800063f6:	ec4e                	sd	s3,24(sp)
    800063f8:	e852                	sd	s4,16(sp)
    800063fa:	e456                	sd	s5,8(sp)
    800063fc:	0080                	add	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    800063fe:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80006402:	0001ca17          	auipc	s4,0x1c
    80006406:	f26a0a13          	add	s4,s4,-218 # 80022328 <uart_tx_lock>
    uart_tx_r += 1;
    8000640a:	00002497          	auipc	s1,0x2
    8000640e:	6ae48493          	add	s1,s1,1710 # 80008ab8 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    80006412:	00002997          	auipc	s3,0x2
    80006416:	6ae98993          	add	s3,s3,1710 # 80008ac0 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    8000641a:	00594703          	lbu	a4,5(s2) # 10000005 <_entry-0x6ffffffb>
    8000641e:	02077713          	and	a4,a4,32
    80006422:	c705                	beqz	a4,8000644a <uartstart+0x72>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80006424:	01f7f713          	and	a4,a5,31
    80006428:	9752                	add	a4,a4,s4
    8000642a:	01874a83          	lbu	s5,24(a4)
    uart_tx_r += 1;
    8000642e:	0785                	add	a5,a5,1
    80006430:	e09c                	sd	a5,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    80006432:	8526                	mv	a0,s1
    80006434:	ffffb097          	auipc	ra,0xffffb
    80006438:	3ca080e7          	jalr	970(ra) # 800017fe <wakeup>
    
    WriteReg(THR, c);
    8000643c:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    80006440:	609c                	ld	a5,0(s1)
    80006442:	0009b703          	ld	a4,0(s3)
    80006446:	fcf71ae3          	bne	a4,a5,8000641a <uartstart+0x42>
  }
}
    8000644a:	70e2                	ld	ra,56(sp)
    8000644c:	7442                	ld	s0,48(sp)
    8000644e:	74a2                	ld	s1,40(sp)
    80006450:	7902                	ld	s2,32(sp)
    80006452:	69e2                	ld	s3,24(sp)
    80006454:	6a42                	ld	s4,16(sp)
    80006456:	6aa2                	ld	s5,8(sp)
    80006458:	6121                	add	sp,sp,64
    8000645a:	8082                	ret
    8000645c:	8082                	ret

000000008000645e <uartputc>:
{
    8000645e:	7179                	add	sp,sp,-48
    80006460:	f406                	sd	ra,40(sp)
    80006462:	f022                	sd	s0,32(sp)
    80006464:	ec26                	sd	s1,24(sp)
    80006466:	e84a                	sd	s2,16(sp)
    80006468:	e44e                	sd	s3,8(sp)
    8000646a:	e052                	sd	s4,0(sp)
    8000646c:	1800                	add	s0,sp,48
    8000646e:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    80006470:	0001c517          	auipc	a0,0x1c
    80006474:	eb850513          	add	a0,a0,-328 # 80022328 <uart_tx_lock>
    80006478:	00000097          	auipc	ra,0x0
    8000647c:	1a0080e7          	jalr	416(ra) # 80006618 <acquire>
  if(panicked){
    80006480:	00002797          	auipc	a5,0x2
    80006484:	6307a783          	lw	a5,1584(a5) # 80008ab0 <panicked>
    80006488:	e7c9                	bnez	a5,80006512 <uartputc+0xb4>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000648a:	00002717          	auipc	a4,0x2
    8000648e:	63673703          	ld	a4,1590(a4) # 80008ac0 <uart_tx_w>
    80006492:	00002797          	auipc	a5,0x2
    80006496:	6267b783          	ld	a5,1574(a5) # 80008ab8 <uart_tx_r>
    8000649a:	02078793          	add	a5,a5,32
    sleep(&uart_tx_r, &uart_tx_lock);
    8000649e:	0001c997          	auipc	s3,0x1c
    800064a2:	e8a98993          	add	s3,s3,-374 # 80022328 <uart_tx_lock>
    800064a6:	00002497          	auipc	s1,0x2
    800064aa:	61248493          	add	s1,s1,1554 # 80008ab8 <uart_tx_r>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800064ae:	00002917          	auipc	s2,0x2
    800064b2:	61290913          	add	s2,s2,1554 # 80008ac0 <uart_tx_w>
    800064b6:	00e79f63          	bne	a5,a4,800064d4 <uartputc+0x76>
    sleep(&uart_tx_r, &uart_tx_lock);
    800064ba:	85ce                	mv	a1,s3
    800064bc:	8526                	mv	a0,s1
    800064be:	ffffb097          	auipc	ra,0xffffb
    800064c2:	2dc080e7          	jalr	732(ra) # 8000179a <sleep>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800064c6:	00093703          	ld	a4,0(s2)
    800064ca:	609c                	ld	a5,0(s1)
    800064cc:	02078793          	add	a5,a5,32
    800064d0:	fee785e3          	beq	a5,a4,800064ba <uartputc+0x5c>
  uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    800064d4:	0001c497          	auipc	s1,0x1c
    800064d8:	e5448493          	add	s1,s1,-428 # 80022328 <uart_tx_lock>
    800064dc:	01f77793          	and	a5,a4,31
    800064e0:	97a6                	add	a5,a5,s1
    800064e2:	01478c23          	sb	s4,24(a5)
  uart_tx_w += 1;
    800064e6:	0705                	add	a4,a4,1
    800064e8:	00002797          	auipc	a5,0x2
    800064ec:	5ce7bc23          	sd	a4,1496(a5) # 80008ac0 <uart_tx_w>
  uartstart();
    800064f0:	00000097          	auipc	ra,0x0
    800064f4:	ee8080e7          	jalr	-280(ra) # 800063d8 <uartstart>
  release(&uart_tx_lock);
    800064f8:	8526                	mv	a0,s1
    800064fa:	00000097          	auipc	ra,0x0
    800064fe:	1d2080e7          	jalr	466(ra) # 800066cc <release>
}
    80006502:	70a2                	ld	ra,40(sp)
    80006504:	7402                	ld	s0,32(sp)
    80006506:	64e2                	ld	s1,24(sp)
    80006508:	6942                	ld	s2,16(sp)
    8000650a:	69a2                	ld	s3,8(sp)
    8000650c:	6a02                	ld	s4,0(sp)
    8000650e:	6145                	add	sp,sp,48
    80006510:	8082                	ret
    for(;;)
    80006512:	a001                	j	80006512 <uartputc+0xb4>

0000000080006514 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80006514:	1141                	add	sp,sp,-16
    80006516:	e422                	sd	s0,8(sp)
    80006518:	0800                	add	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    8000651a:	100007b7          	lui	a5,0x10000
    8000651e:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006522:	8b85                	and	a5,a5,1
    80006524:	cb81                	beqz	a5,80006534 <uartgetc+0x20>
    // input data is ready.
    return ReadReg(RHR);
    80006526:	100007b7          	lui	a5,0x10000
    8000652a:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    8000652e:	6422                	ld	s0,8(sp)
    80006530:	0141                	add	sp,sp,16
    80006532:	8082                	ret
    return -1;
    80006534:	557d                	li	a0,-1
    80006536:	bfe5                	j	8000652e <uartgetc+0x1a>

0000000080006538 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    80006538:	1101                	add	sp,sp,-32
    8000653a:	ec06                	sd	ra,24(sp)
    8000653c:	e822                	sd	s0,16(sp)
    8000653e:	e426                	sd	s1,8(sp)
    80006540:	1000                	add	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    80006542:	54fd                	li	s1,-1
    80006544:	a029                	j	8000654e <uartintr+0x16>
      break;
    consoleintr(c);
    80006546:	00000097          	auipc	ra,0x0
    8000654a:	89e080e7          	jalr	-1890(ra) # 80005de4 <consoleintr>
    int c = uartgetc();
    8000654e:	00000097          	auipc	ra,0x0
    80006552:	fc6080e7          	jalr	-58(ra) # 80006514 <uartgetc>
    if(c == -1)
    80006556:	fe9518e3          	bne	a0,s1,80006546 <uartintr+0xe>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    8000655a:	0001c497          	auipc	s1,0x1c
    8000655e:	dce48493          	add	s1,s1,-562 # 80022328 <uart_tx_lock>
    80006562:	8526                	mv	a0,s1
    80006564:	00000097          	auipc	ra,0x0
    80006568:	0b4080e7          	jalr	180(ra) # 80006618 <acquire>
  uartstart();
    8000656c:	00000097          	auipc	ra,0x0
    80006570:	e6c080e7          	jalr	-404(ra) # 800063d8 <uartstart>
  release(&uart_tx_lock);
    80006574:	8526                	mv	a0,s1
    80006576:	00000097          	auipc	ra,0x0
    8000657a:	156080e7          	jalr	342(ra) # 800066cc <release>
}
    8000657e:	60e2                	ld	ra,24(sp)
    80006580:	6442                	ld	s0,16(sp)
    80006582:	64a2                	ld	s1,8(sp)
    80006584:	6105                	add	sp,sp,32
    80006586:	8082                	ret

0000000080006588 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80006588:	1141                	add	sp,sp,-16
    8000658a:	e422                	sd	s0,8(sp)
    8000658c:	0800                	add	s0,sp,16
  lk->name = name;
    8000658e:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80006590:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80006594:	00053823          	sd	zero,16(a0)
}
    80006598:	6422                	ld	s0,8(sp)
    8000659a:	0141                	add	sp,sp,16
    8000659c:	8082                	ret

000000008000659e <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    8000659e:	411c                	lw	a5,0(a0)
    800065a0:	e399                	bnez	a5,800065a6 <holding+0x8>
    800065a2:	4501                	li	a0,0
  return r;
}
    800065a4:	8082                	ret
{
    800065a6:	1101                	add	sp,sp,-32
    800065a8:	ec06                	sd	ra,24(sp)
    800065aa:	e822                	sd	s0,16(sp)
    800065ac:	e426                	sd	s1,8(sp)
    800065ae:	1000                	add	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    800065b0:	6904                	ld	s1,16(a0)
    800065b2:	ffffb097          	auipc	ra,0xffffb
    800065b6:	9fc080e7          	jalr	-1540(ra) # 80000fae <mycpu>
    800065ba:	40a48533          	sub	a0,s1,a0
    800065be:	00153513          	seqz	a0,a0
}
    800065c2:	60e2                	ld	ra,24(sp)
    800065c4:	6442                	ld	s0,16(sp)
    800065c6:	64a2                	ld	s1,8(sp)
    800065c8:	6105                	add	sp,sp,32
    800065ca:	8082                	ret

00000000800065cc <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    800065cc:	1101                	add	sp,sp,-32
    800065ce:	ec06                	sd	ra,24(sp)
    800065d0:	e822                	sd	s0,16(sp)
    800065d2:	e426                	sd	s1,8(sp)
    800065d4:	1000                	add	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800065d6:	100024f3          	csrr	s1,sstatus
    800065da:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800065de:	9bf5                	and	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800065e0:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    800065e4:	ffffb097          	auipc	ra,0xffffb
    800065e8:	9ca080e7          	jalr	-1590(ra) # 80000fae <mycpu>
    800065ec:	5d3c                	lw	a5,120(a0)
    800065ee:	cf89                	beqz	a5,80006608 <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    800065f0:	ffffb097          	auipc	ra,0xffffb
    800065f4:	9be080e7          	jalr	-1602(ra) # 80000fae <mycpu>
    800065f8:	5d3c                	lw	a5,120(a0)
    800065fa:	2785                	addw	a5,a5,1
    800065fc:	dd3c                	sw	a5,120(a0)
}
    800065fe:	60e2                	ld	ra,24(sp)
    80006600:	6442                	ld	s0,16(sp)
    80006602:	64a2                	ld	s1,8(sp)
    80006604:	6105                	add	sp,sp,32
    80006606:	8082                	ret
    mycpu()->intena = old;
    80006608:	ffffb097          	auipc	ra,0xffffb
    8000660c:	9a6080e7          	jalr	-1626(ra) # 80000fae <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80006610:	8085                	srl	s1,s1,0x1
    80006612:	8885                	and	s1,s1,1
    80006614:	dd64                	sw	s1,124(a0)
    80006616:	bfe9                	j	800065f0 <push_off+0x24>

0000000080006618 <acquire>:
{
    80006618:	1101                	add	sp,sp,-32
    8000661a:	ec06                	sd	ra,24(sp)
    8000661c:	e822                	sd	s0,16(sp)
    8000661e:	e426                	sd	s1,8(sp)
    80006620:	1000                	add	s0,sp,32
    80006622:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80006624:	00000097          	auipc	ra,0x0
    80006628:	fa8080e7          	jalr	-88(ra) # 800065cc <push_off>
  if(holding(lk))
    8000662c:	8526                	mv	a0,s1
    8000662e:	00000097          	auipc	ra,0x0
    80006632:	f70080e7          	jalr	-144(ra) # 8000659e <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80006636:	4705                	li	a4,1
  if(holding(lk))
    80006638:	e115                	bnez	a0,8000665c <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    8000663a:	87ba                	mv	a5,a4
    8000663c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006640:	2781                	sext.w	a5,a5
    80006642:	ffe5                	bnez	a5,8000663a <acquire+0x22>
  __sync_synchronize();
    80006644:	0ff0000f          	fence
  lk->cpu = mycpu();
    80006648:	ffffb097          	auipc	ra,0xffffb
    8000664c:	966080e7          	jalr	-1690(ra) # 80000fae <mycpu>
    80006650:	e888                	sd	a0,16(s1)
}
    80006652:	60e2                	ld	ra,24(sp)
    80006654:	6442                	ld	s0,16(sp)
    80006656:	64a2                	ld	s1,8(sp)
    80006658:	6105                	add	sp,sp,32
    8000665a:	8082                	ret
    panic("acquire");
    8000665c:	00002517          	auipc	a0,0x2
    80006660:	3b450513          	add	a0,a0,948 # 80008a10 <digits+0x20>
    80006664:	00000097          	auipc	ra,0x0
    80006668:	a7c080e7          	jalr	-1412(ra) # 800060e0 <panic>

000000008000666c <pop_off>:

void
pop_off(void)
{
    8000666c:	1141                	add	sp,sp,-16
    8000666e:	e406                	sd	ra,8(sp)
    80006670:	e022                	sd	s0,0(sp)
    80006672:	0800                	add	s0,sp,16
  struct cpu *c = mycpu();
    80006674:	ffffb097          	auipc	ra,0xffffb
    80006678:	93a080e7          	jalr	-1734(ra) # 80000fae <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000667c:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80006680:	8b89                	and	a5,a5,2
  if(intr_get())
    80006682:	e78d                	bnez	a5,800066ac <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80006684:	5d3c                	lw	a5,120(a0)
    80006686:	02f05b63          	blez	a5,800066bc <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    8000668a:	37fd                	addw	a5,a5,-1
    8000668c:	0007871b          	sext.w	a4,a5
    80006690:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80006692:	eb09                	bnez	a4,800066a4 <pop_off+0x38>
    80006694:	5d7c                	lw	a5,124(a0)
    80006696:	c799                	beqz	a5,800066a4 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80006698:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000669c:	0027e793          	or	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800066a0:	10079073          	csrw	sstatus,a5
    intr_on();
}
    800066a4:	60a2                	ld	ra,8(sp)
    800066a6:	6402                	ld	s0,0(sp)
    800066a8:	0141                	add	sp,sp,16
    800066aa:	8082                	ret
    panic("pop_off - interruptible");
    800066ac:	00002517          	auipc	a0,0x2
    800066b0:	36c50513          	add	a0,a0,876 # 80008a18 <digits+0x28>
    800066b4:	00000097          	auipc	ra,0x0
    800066b8:	a2c080e7          	jalr	-1492(ra) # 800060e0 <panic>
    panic("pop_off");
    800066bc:	00002517          	auipc	a0,0x2
    800066c0:	37450513          	add	a0,a0,884 # 80008a30 <digits+0x40>
    800066c4:	00000097          	auipc	ra,0x0
    800066c8:	a1c080e7          	jalr	-1508(ra) # 800060e0 <panic>

00000000800066cc <release>:
{
    800066cc:	1101                	add	sp,sp,-32
    800066ce:	ec06                	sd	ra,24(sp)
    800066d0:	e822                	sd	s0,16(sp)
    800066d2:	e426                	sd	s1,8(sp)
    800066d4:	1000                	add	s0,sp,32
    800066d6:	84aa                	mv	s1,a0
  if(!holding(lk))
    800066d8:	00000097          	auipc	ra,0x0
    800066dc:	ec6080e7          	jalr	-314(ra) # 8000659e <holding>
    800066e0:	c115                	beqz	a0,80006704 <release+0x38>
  lk->cpu = 0;
    800066e2:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    800066e6:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    800066ea:	0f50000f          	fence	iorw,ow
    800066ee:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    800066f2:	00000097          	auipc	ra,0x0
    800066f6:	f7a080e7          	jalr	-134(ra) # 8000666c <pop_off>
}
    800066fa:	60e2                	ld	ra,24(sp)
    800066fc:	6442                	ld	s0,16(sp)
    800066fe:	64a2                	ld	s1,8(sp)
    80006700:	6105                	add	sp,sp,32
    80006702:	8082                	ret
    panic("release");
    80006704:	00002517          	auipc	a0,0x2
    80006708:	33450513          	add	a0,a0,820 # 80008a38 <digits+0x48>
    8000670c:	00000097          	auipc	ra,0x0
    80006710:	9d4080e7          	jalr	-1580(ra) # 800060e0 <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051073          	csrw	sscratch,a0
    80007004:	02000537          	lui	a0,0x2000
    80007008:	357d                	addw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    8000700a:	0536                	sll	a0,a0,0xd
    8000700c:	02153423          	sd	ra,40(a0)
    80007010:	02253823          	sd	sp,48(a0)
    80007014:	02353c23          	sd	gp,56(a0)
    80007018:	04453023          	sd	tp,64(a0)
    8000701c:	04553423          	sd	t0,72(a0)
    80007020:	04653823          	sd	t1,80(a0)
    80007024:	04753c23          	sd	t2,88(a0)
    80007028:	f120                	sd	s0,96(a0)
    8000702a:	f524                	sd	s1,104(a0)
    8000702c:	fd2c                	sd	a1,120(a0)
    8000702e:	e150                	sd	a2,128(a0)
    80007030:	e554                	sd	a3,136(a0)
    80007032:	e958                	sd	a4,144(a0)
    80007034:	ed5c                	sd	a5,152(a0)
    80007036:	0b053023          	sd	a6,160(a0)
    8000703a:	0b153423          	sd	a7,168(a0)
    8000703e:	0b253823          	sd	s2,176(a0)
    80007042:	0b353c23          	sd	s3,184(a0)
    80007046:	0d453023          	sd	s4,192(a0)
    8000704a:	0d553423          	sd	s5,200(a0)
    8000704e:	0d653823          	sd	s6,208(a0)
    80007052:	0d753c23          	sd	s7,216(a0)
    80007056:	0f853023          	sd	s8,224(a0)
    8000705a:	0f953423          	sd	s9,232(a0)
    8000705e:	0fa53823          	sd	s10,240(a0)
    80007062:	0fb53c23          	sd	s11,248(a0)
    80007066:	11c53023          	sd	t3,256(a0)
    8000706a:	11d53423          	sd	t4,264(a0)
    8000706e:	11e53823          	sd	t5,272(a0)
    80007072:	11f53c23          	sd	t6,280(a0)
    80007076:	140022f3          	csrr	t0,sscratch
    8000707a:	06553823          	sd	t0,112(a0)
    8000707e:	00853103          	ld	sp,8(a0)
    80007082:	02053203          	ld	tp,32(a0)
    80007086:	01053283          	ld	t0,16(a0)
    8000708a:	00053303          	ld	t1,0(a0)
    8000708e:	12000073          	sfence.vma
    80007092:	18031073          	csrw	satp,t1
    80007096:	12000073          	sfence.vma
    8000709a:	8282                	jr	t0

000000008000709c <userret>:
    8000709c:	12000073          	sfence.vma
    800070a0:	18051073          	csrw	satp,a0
    800070a4:	12000073          	sfence.vma
    800070a8:	02000537          	lui	a0,0x2000
    800070ac:	357d                	addw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    800070ae:	0536                	sll	a0,a0,0xd
    800070b0:	02853083          	ld	ra,40(a0)
    800070b4:	03053103          	ld	sp,48(a0)
    800070b8:	03853183          	ld	gp,56(a0)
    800070bc:	04053203          	ld	tp,64(a0)
    800070c0:	04853283          	ld	t0,72(a0)
    800070c4:	05053303          	ld	t1,80(a0)
    800070c8:	05853383          	ld	t2,88(a0)
    800070cc:	7120                	ld	s0,96(a0)
    800070ce:	7524                	ld	s1,104(a0)
    800070d0:	7d2c                	ld	a1,120(a0)
    800070d2:	6150                	ld	a2,128(a0)
    800070d4:	6554                	ld	a3,136(a0)
    800070d6:	6958                	ld	a4,144(a0)
    800070d8:	6d5c                	ld	a5,152(a0)
    800070da:	0a053803          	ld	a6,160(a0)
    800070de:	0a853883          	ld	a7,168(a0)
    800070e2:	0b053903          	ld	s2,176(a0)
    800070e6:	0b853983          	ld	s3,184(a0)
    800070ea:	0c053a03          	ld	s4,192(a0)
    800070ee:	0c853a83          	ld	s5,200(a0)
    800070f2:	0d053b03          	ld	s6,208(a0)
    800070f6:	0d853b83          	ld	s7,216(a0)
    800070fa:	0e053c03          	ld	s8,224(a0)
    800070fe:	0e853c83          	ld	s9,232(a0)
    80007102:	0f053d03          	ld	s10,240(a0)
    80007106:	0f853d83          	ld	s11,248(a0)
    8000710a:	10053e03          	ld	t3,256(a0)
    8000710e:	10853e83          	ld	t4,264(a0)
    80007112:	11053f03          	ld	t5,272(a0)
    80007116:	11853f83          	ld	t6,280(a0)
    8000711a:	7928                	ld	a0,112(a0)
    8000711c:	10200073          	sret
	...
