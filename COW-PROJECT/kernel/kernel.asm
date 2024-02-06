
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0003a117          	auipc	sp,0x3a
    80000004:	c9010113          	add	sp,sp,-880 # 80039c90 <stack0>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	add	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	131050ef          	jal	80005946 <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8000001c:	7179                	add	sp,sp,-48
    8000001e:	f406                	sd	ra,40(sp)
    80000020:	f022                	sd	s0,32(sp)
    80000022:	ec26                	sd	s1,24(sp)
    80000024:	e84a                	sd	s2,16(sp)
    80000026:	e44e                	sd	s3,8(sp)
    80000028:	1800                	add	s0,sp,48
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP) {
    8000002a:	03451793          	sll	a5,a0,0x34
    8000002e:	e7a5                	bnez	a5,80000096 <kfree+0x7a>
    80000030:	84aa                	mv	s1,a0
    80000032:	00042797          	auipc	a5,0x42
    80000036:	d5e78793          	add	a5,a5,-674 # 80041d90 <end>
    8000003a:	04f56e63          	bltu	a0,a5,80000096 <kfree+0x7a>
    8000003e:	47c5                	li	a5,17
    80000040:	07ee                	sll	a5,a5,0x1b
    80000042:	04f57a63          	bgeu	a0,a5,80000096 <kfree+0x7a>
      panic("kfree");
  }

    acquire(&pgreflock);
    80000046:	00009517          	auipc	a0,0x9
    8000004a:	8ba50513          	add	a0,a0,-1862 # 80008900 <pgreflock>
    8000004e:	00006097          	auipc	ra,0x6
    80000052:	2e0080e7          	jalr	736(ra) # 8000632e <acquire>
    if (--PA2PGREF(pa) <= 0) {
    80000056:	800007b7          	lui	a5,0x80000
    8000005a:	97a6                	add	a5,a5,s1
    8000005c:	83b1                	srl	a5,a5,0xc
    8000005e:	078a                	sll	a5,a5,0x2
    80000060:	00009717          	auipc	a4,0x9
    80000064:	8d870713          	add	a4,a4,-1832 # 80008938 <pageref>
    80000068:	97ba                	add	a5,a5,a4
    8000006a:	4398                	lw	a4,0(a5)
    8000006c:	377d                	addw	a4,a4,-1
    8000006e:	0007069b          	sext.w	a3,a4
    80000072:	c398                	sw	a4,0(a5)
    80000074:	02d05963          	blez	a3,800000a6 <kfree+0x8a>
        acquire(&kmem.lock);
        r->next = kmem.freelist;
        kmem.freelist = r;
        release(&kmem.lock);
    }
    release(&pgreflock);
    80000078:	00009517          	auipc	a0,0x9
    8000007c:	88850513          	add	a0,a0,-1912 # 80008900 <pgreflock>
    80000080:	00006097          	auipc	ra,0x6
    80000084:	362080e7          	jalr	866(ra) # 800063e2 <release>
}
    80000088:	70a2                	ld	ra,40(sp)
    8000008a:	7402                	ld	s0,32(sp)
    8000008c:	64e2                	ld	s1,24(sp)
    8000008e:	6942                	ld	s2,16(sp)
    80000090:	69a2                	ld	s3,8(sp)
    80000092:	6145                	add	sp,sp,48
    80000094:	8082                	ret
      panic("kfree");
    80000096:	00008517          	auipc	a0,0x8
    8000009a:	f7a50513          	add	a0,a0,-134 # 80008010 <etext+0x10>
    8000009e:	00006097          	auipc	ra,0x6
    800000a2:	d58080e7          	jalr	-680(ra) # 80005df6 <panic>
        memset(pa, 1, PGSIZE);
    800000a6:	6605                	lui	a2,0x1
    800000a8:	4585                	li	a1,1
    800000aa:	8526                	mv	a0,s1
    800000ac:	00000097          	auipc	ra,0x0
    800000b0:	258080e7          	jalr	600(ra) # 80000304 <memset>
        acquire(&kmem.lock);
    800000b4:	00009997          	auipc	s3,0x9
    800000b8:	84c98993          	add	s3,s3,-1972 # 80008900 <pgreflock>
    800000bc:	00009917          	auipc	s2,0x9
    800000c0:	85c90913          	add	s2,s2,-1956 # 80008918 <kmem>
    800000c4:	854a                	mv	a0,s2
    800000c6:	00006097          	auipc	ra,0x6
    800000ca:	268080e7          	jalr	616(ra) # 8000632e <acquire>
        r->next = kmem.freelist;
    800000ce:	0309b783          	ld	a5,48(s3)
    800000d2:	e09c                	sd	a5,0(s1)
        kmem.freelist = r;
    800000d4:	0299b823          	sd	s1,48(s3)
        release(&kmem.lock);
    800000d8:	854a                	mv	a0,s2
    800000da:	00006097          	auipc	ra,0x6
    800000de:	308080e7          	jalr	776(ra) # 800063e2 <release>
    800000e2:	bf59                	j	80000078 <kfree+0x5c>

00000000800000e4 <freerange>:
{
    800000e4:	7179                	add	sp,sp,-48
    800000e6:	f406                	sd	ra,40(sp)
    800000e8:	f022                	sd	s0,32(sp)
    800000ea:	ec26                	sd	s1,24(sp)
    800000ec:	e84a                	sd	s2,16(sp)
    800000ee:	e44e                	sd	s3,8(sp)
    800000f0:	e052                	sd	s4,0(sp)
    800000f2:	1800                	add	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    800000f4:	6785                	lui	a5,0x1
    800000f6:	fff78713          	add	a4,a5,-1 # fff <_entry-0x7ffff001>
    800000fa:	00e504b3          	add	s1,a0,a4
    800000fe:	777d                	lui	a4,0xfffff
    80000100:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000102:	94be                	add	s1,s1,a5
    80000104:	0095ee63          	bltu	a1,s1,80000120 <freerange+0x3c>
    80000108:	892e                	mv	s2,a1
    kfree(p);
    8000010a:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    8000010c:	6985                	lui	s3,0x1
    kfree(p);
    8000010e:	01448533          	add	a0,s1,s4
    80000112:	00000097          	auipc	ra,0x0
    80000116:	f0a080e7          	jalr	-246(ra) # 8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    8000011a:	94ce                	add	s1,s1,s3
    8000011c:	fe9979e3          	bgeu	s2,s1,8000010e <freerange+0x2a>
}
    80000120:	70a2                	ld	ra,40(sp)
    80000122:	7402                	ld	s0,32(sp)
    80000124:	64e2                	ld	s1,24(sp)
    80000126:	6942                	ld	s2,16(sp)
    80000128:	69a2                	ld	s3,8(sp)
    8000012a:	6a02                	ld	s4,0(sp)
    8000012c:	6145                	add	sp,sp,48
    8000012e:	8082                	ret

0000000080000130 <kinit>:
{
    80000130:	1141                	add	sp,sp,-16
    80000132:	e406                	sd	ra,8(sp)
    80000134:	e022                	sd	s0,0(sp)
    80000136:	0800                	add	s0,sp,16
  initlock(&kmem.lock, "kmem");
    80000138:	00008597          	auipc	a1,0x8
    8000013c:	ee058593          	add	a1,a1,-288 # 80008018 <etext+0x18>
    80000140:	00008517          	auipc	a0,0x8
    80000144:	7d850513          	add	a0,a0,2008 # 80008918 <kmem>
    80000148:	00006097          	auipc	ra,0x6
    8000014c:	156080e7          	jalr	342(ra) # 8000629e <initlock>
  initlock(&pgreflock, "pgref");
    80000150:	00008597          	auipc	a1,0x8
    80000154:	ed058593          	add	a1,a1,-304 # 80008020 <etext+0x20>
    80000158:	00008517          	auipc	a0,0x8
    8000015c:	7a850513          	add	a0,a0,1960 # 80008900 <pgreflock>
    80000160:	00006097          	auipc	ra,0x6
    80000164:	13e080e7          	jalr	318(ra) # 8000629e <initlock>
  freerange(end, (void*)PHYSTOP);
    80000168:	45c5                	li	a1,17
    8000016a:	05ee                	sll	a1,a1,0x1b
    8000016c:	00042517          	auipc	a0,0x42
    80000170:	c2450513          	add	a0,a0,-988 # 80041d90 <end>
    80000174:	00000097          	auipc	ra,0x0
    80000178:	f70080e7          	jalr	-144(ra) # 800000e4 <freerange>
}
    8000017c:	60a2                	ld	ra,8(sp)
    8000017e:	6402                	ld	s0,0(sp)
    80000180:	0141                	add	sp,sp,16
    80000182:	8082                	ret

0000000080000184 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000184:	1101                	add	sp,sp,-32
    80000186:	ec06                	sd	ra,24(sp)
    80000188:	e822                	sd	s0,16(sp)
    8000018a:	e426                	sd	s1,8(sp)
    8000018c:	1000                	add	s0,sp,32
  struct run *r;


  acquire(&kmem.lock);
    8000018e:	00008517          	auipc	a0,0x8
    80000192:	78a50513          	add	a0,a0,1930 # 80008918 <kmem>
    80000196:	00006097          	auipc	ra,0x6
    8000019a:	198080e7          	jalr	408(ra) # 8000632e <acquire>
  r = kmem.freelist;
    8000019e:	00008497          	auipc	s1,0x8
    800001a2:	7924b483          	ld	s1,1938(s1) # 80008930 <kmem+0x18>
  if(r)
    800001a6:	c4b9                	beqz	s1,800001f4 <kalloc+0x70>
    kmem.freelist = r->next;
    800001a8:	609c                	ld	a5,0(s1)
    800001aa:	00008717          	auipc	a4,0x8
    800001ae:	78f73323          	sd	a5,1926(a4) # 80008930 <kmem+0x18>
  release(&kmem.lock);
    800001b2:	00008517          	auipc	a0,0x8
    800001b6:	76650513          	add	a0,a0,1894 # 80008918 <kmem>
    800001ba:	00006097          	auipc	ra,0x6
    800001be:	228080e7          	jalr	552(ra) # 800063e2 <release>

  if(r) {
      memset((char *) r, 5, PGSIZE); // fill with junk
    800001c2:	6605                	lui	a2,0x1
    800001c4:	4595                	li	a1,5
    800001c6:	8526                	mv	a0,s1
    800001c8:	00000097          	auipc	ra,0x0
    800001cc:	13c080e7          	jalr	316(ra) # 80000304 <memset>
      PA2PGREF(r) = 1;
    800001d0:	800007b7          	lui	a5,0x80000
    800001d4:	97a6                	add	a5,a5,s1
    800001d6:	83b1                	srl	a5,a5,0xc
    800001d8:	078a                	sll	a5,a5,0x2
    800001da:	00008717          	auipc	a4,0x8
    800001de:	75e70713          	add	a4,a4,1886 # 80008938 <pageref>
    800001e2:	97ba                	add	a5,a5,a4
    800001e4:	4705                	li	a4,1
    800001e6:	c398                	sw	a4,0(a5)
  }
  return (void*)r;
}
    800001e8:	8526                	mv	a0,s1
    800001ea:	60e2                	ld	ra,24(sp)
    800001ec:	6442                	ld	s0,16(sp)
    800001ee:	64a2                	ld	s1,8(sp)
    800001f0:	6105                	add	sp,sp,32
    800001f2:	8082                	ret
  release(&kmem.lock);
    800001f4:	00008517          	auipc	a0,0x8
    800001f8:	72450513          	add	a0,a0,1828 # 80008918 <kmem>
    800001fc:	00006097          	auipc	ra,0x6
    80000200:	1e6080e7          	jalr	486(ra) # 800063e2 <release>
  if(r) {
    80000204:	b7d5                	j	800001e8 <kalloc+0x64>

0000000080000206 <kcopy_n_deref>:

void *kcopy_n_deref(void *pa) {
    80000206:	7179                	add	sp,sp,-48
    80000208:	f406                	sd	ra,40(sp)
    8000020a:	f022                	sd	s0,32(sp)
    8000020c:	ec26                	sd	s1,24(sp)
    8000020e:	e84a                	sd	s2,16(sp)
    80000210:	e44e                	sd	s3,8(sp)
    80000212:	1800                	add	s0,sp,48
    80000214:	892a                	mv	s2,a0

    acquire(&pgreflock);
    80000216:	00008517          	auipc	a0,0x8
    8000021a:	6ea50513          	add	a0,a0,1770 # 80008900 <pgreflock>
    8000021e:	00006097          	auipc	ra,0x6
    80000222:	110080e7          	jalr	272(ra) # 8000632e <acquire>
    if (PA2PGREF(pa) <= 1) {
    80000226:	800004b7          	lui	s1,0x80000
    8000022a:	94ca                	add	s1,s1,s2
    8000022c:	80b1                	srl	s1,s1,0xc
    8000022e:	00249713          	sll	a4,s1,0x2
    80000232:	00008797          	auipc	a5,0x8
    80000236:	70678793          	add	a5,a5,1798 # 80008938 <pageref>
    8000023a:	97ba                	add	a5,a5,a4
    8000023c:	4398                	lw	a4,0(a5)
    8000023e:	4785                	li	a5,1
    80000240:	04e7d763          	bge	a5,a4,8000028e <kcopy_n_deref+0x88>
        release(&pgreflock);
        return pa;
    }

    uint64 newpa = (uint64)kalloc();
    80000244:	00000097          	auipc	ra,0x0
    80000248:	f40080e7          	jalr	-192(ra) # 80000184 <kalloc>
    8000024c:	89aa                	mv	s3,a0
    if (newpa == 0) {
    8000024e:	c931                	beqz	a0,800002a2 <kcopy_n_deref+0x9c>
        release(&pgreflock);
        return 0;
    }
    memmove((void*)newpa, (void*)pa, PGSIZE);
    80000250:	6605                	lui	a2,0x1
    80000252:	85ca                	mv	a1,s2
    80000254:	00000097          	auipc	ra,0x0
    80000258:	10c080e7          	jalr	268(ra) # 80000360 <memmove>

    PA2PGREF(pa)--;
    8000025c:	048a                	sll	s1,s1,0x2
    8000025e:	00008797          	auipc	a5,0x8
    80000262:	6da78793          	add	a5,a5,1754 # 80008938 <pageref>
    80000266:	97a6                	add	a5,a5,s1
    80000268:	4398                	lw	a4,0(a5)
    8000026a:	377d                	addw	a4,a4,-1
    8000026c:	c398                	sw	a4,0(a5)

    release(&pgreflock);
    8000026e:	00008517          	auipc	a0,0x8
    80000272:	69250513          	add	a0,a0,1682 # 80008900 <pgreflock>
    80000276:	00006097          	auipc	ra,0x6
    8000027a:	16c080e7          	jalr	364(ra) # 800063e2 <release>
    return (void*)newpa;
}
    8000027e:	854e                	mv	a0,s3
    80000280:	70a2                	ld	ra,40(sp)
    80000282:	7402                	ld	s0,32(sp)
    80000284:	64e2                	ld	s1,24(sp)
    80000286:	6942                	ld	s2,16(sp)
    80000288:	69a2                	ld	s3,8(sp)
    8000028a:	6145                	add	sp,sp,48
    8000028c:	8082                	ret
        release(&pgreflock);
    8000028e:	00008517          	auipc	a0,0x8
    80000292:	67250513          	add	a0,a0,1650 # 80008900 <pgreflock>
    80000296:	00006097          	auipc	ra,0x6
    8000029a:	14c080e7          	jalr	332(ra) # 800063e2 <release>
        return pa;
    8000029e:	89ca                	mv	s3,s2
    800002a0:	bff9                	j	8000027e <kcopy_n_deref+0x78>
        release(&pgreflock);
    800002a2:	00008517          	auipc	a0,0x8
    800002a6:	65e50513          	add	a0,a0,1630 # 80008900 <pgreflock>
    800002aa:	00006097          	auipc	ra,0x6
    800002ae:	138080e7          	jalr	312(ra) # 800063e2 <release>
        return 0;
    800002b2:	b7f1                	j	8000027e <kcopy_n_deref+0x78>

00000000800002b4 <krefpage>:

void krefpage(void *pa) {
    800002b4:	1101                	add	sp,sp,-32
    800002b6:	ec06                	sd	ra,24(sp)
    800002b8:	e822                	sd	s0,16(sp)
    800002ba:	e426                	sd	s1,8(sp)
    800002bc:	e04a                	sd	s2,0(sp)
    800002be:	1000                	add	s0,sp,32
    800002c0:	84aa                	mv	s1,a0
    acquire(&pgreflock);
    800002c2:	00008917          	auipc	s2,0x8
    800002c6:	63e90913          	add	s2,s2,1598 # 80008900 <pgreflock>
    800002ca:	854a                	mv	a0,s2
    800002cc:	00006097          	auipc	ra,0x6
    800002d0:	062080e7          	jalr	98(ra) # 8000632e <acquire>
    PA2PGREF(pa)++;
    800002d4:	800007b7          	lui	a5,0x80000
    800002d8:	94be                	add	s1,s1,a5
    800002da:	80b1                	srl	s1,s1,0xc
    800002dc:	048a                	sll	s1,s1,0x2
    800002de:	00008797          	auipc	a5,0x8
    800002e2:	65a78793          	add	a5,a5,1626 # 80008938 <pageref>
    800002e6:	97a6                	add	a5,a5,s1
    800002e8:	4398                	lw	a4,0(a5)
    800002ea:	2705                	addw	a4,a4,1
    800002ec:	c398                	sw	a4,0(a5)
    release(&pgreflock);
    800002ee:	854a                	mv	a0,s2
    800002f0:	00006097          	auipc	ra,0x6
    800002f4:	0f2080e7          	jalr	242(ra) # 800063e2 <release>
}
    800002f8:	60e2                	ld	ra,24(sp)
    800002fa:	6442                	ld	s0,16(sp)
    800002fc:	64a2                	ld	s1,8(sp)
    800002fe:	6902                	ld	s2,0(sp)
    80000300:	6105                	add	sp,sp,32
    80000302:	8082                	ret

0000000080000304 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    80000304:	1141                	add	sp,sp,-16
    80000306:	e422                	sd	s0,8(sp)
    80000308:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    8000030a:	ca19                	beqz	a2,80000320 <memset+0x1c>
    8000030c:	87aa                	mv	a5,a0
    8000030e:	1602                	sll	a2,a2,0x20
    80000310:	9201                	srl	a2,a2,0x20
    80000312:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    80000316:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    8000031a:	0785                	add	a5,a5,1
    8000031c:	fee79de3          	bne	a5,a4,80000316 <memset+0x12>
  }
  return dst;
}
    80000320:	6422                	ld	s0,8(sp)
    80000322:	0141                	add	sp,sp,16
    80000324:	8082                	ret

0000000080000326 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    80000326:	1141                	add	sp,sp,-16
    80000328:	e422                	sd	s0,8(sp)
    8000032a:	0800                	add	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    8000032c:	ca05                	beqz	a2,8000035c <memcmp+0x36>
    8000032e:	fff6069b          	addw	a3,a2,-1 # fff <_entry-0x7ffff001>
    80000332:	1682                	sll	a3,a3,0x20
    80000334:	9281                	srl	a3,a3,0x20
    80000336:	0685                	add	a3,a3,1
    80000338:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    8000033a:	00054783          	lbu	a5,0(a0)
    8000033e:	0005c703          	lbu	a4,0(a1)
    80000342:	00e79863          	bne	a5,a4,80000352 <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    80000346:	0505                	add	a0,a0,1
    80000348:	0585                	add	a1,a1,1
  while(n-- > 0){
    8000034a:	fed518e3          	bne	a0,a3,8000033a <memcmp+0x14>
  }

  return 0;
    8000034e:	4501                	li	a0,0
    80000350:	a019                	j	80000356 <memcmp+0x30>
      return *s1 - *s2;
    80000352:	40e7853b          	subw	a0,a5,a4
}
    80000356:	6422                	ld	s0,8(sp)
    80000358:	0141                	add	sp,sp,16
    8000035a:	8082                	ret
  return 0;
    8000035c:	4501                	li	a0,0
    8000035e:	bfe5                	j	80000356 <memcmp+0x30>

0000000080000360 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    80000360:	1141                	add	sp,sp,-16
    80000362:	e422                	sd	s0,8(sp)
    80000364:	0800                	add	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    80000366:	c205                	beqz	a2,80000386 <memmove+0x26>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    80000368:	02a5e263          	bltu	a1,a0,8000038c <memmove+0x2c>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    8000036c:	1602                	sll	a2,a2,0x20
    8000036e:	9201                	srl	a2,a2,0x20
    80000370:	00c587b3          	add	a5,a1,a2
{
    80000374:	872a                	mv	a4,a0
      *d++ = *s++;
    80000376:	0585                	add	a1,a1,1
    80000378:	0705                	add	a4,a4,1
    8000037a:	fff5c683          	lbu	a3,-1(a1)
    8000037e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    80000382:	fef59ae3          	bne	a1,a5,80000376 <memmove+0x16>

  return dst;
}
    80000386:	6422                	ld	s0,8(sp)
    80000388:	0141                	add	sp,sp,16
    8000038a:	8082                	ret
  if(s < d && s + n > d){
    8000038c:	02061693          	sll	a3,a2,0x20
    80000390:	9281                	srl	a3,a3,0x20
    80000392:	00d58733          	add	a4,a1,a3
    80000396:	fce57be3          	bgeu	a0,a4,8000036c <memmove+0xc>
    d += n;
    8000039a:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    8000039c:	fff6079b          	addw	a5,a2,-1
    800003a0:	1782                	sll	a5,a5,0x20
    800003a2:	9381                	srl	a5,a5,0x20
    800003a4:	fff7c793          	not	a5,a5
    800003a8:	97ba                	add	a5,a5,a4
      *--d = *--s;
    800003aa:	177d                	add	a4,a4,-1
    800003ac:	16fd                	add	a3,a3,-1
    800003ae:	00074603          	lbu	a2,0(a4)
    800003b2:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    800003b6:	fee79ae3          	bne	a5,a4,800003aa <memmove+0x4a>
    800003ba:	b7f1                	j	80000386 <memmove+0x26>

00000000800003bc <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    800003bc:	1141                	add	sp,sp,-16
    800003be:	e406                	sd	ra,8(sp)
    800003c0:	e022                	sd	s0,0(sp)
    800003c2:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
    800003c4:	00000097          	auipc	ra,0x0
    800003c8:	f9c080e7          	jalr	-100(ra) # 80000360 <memmove>
}
    800003cc:	60a2                	ld	ra,8(sp)
    800003ce:	6402                	ld	s0,0(sp)
    800003d0:	0141                	add	sp,sp,16
    800003d2:	8082                	ret

00000000800003d4 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    800003d4:	1141                	add	sp,sp,-16
    800003d6:	e422                	sd	s0,8(sp)
    800003d8:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q)
    800003da:	ce11                	beqz	a2,800003f6 <strncmp+0x22>
    800003dc:	00054783          	lbu	a5,0(a0)
    800003e0:	cf89                	beqz	a5,800003fa <strncmp+0x26>
    800003e2:	0005c703          	lbu	a4,0(a1)
    800003e6:	00f71a63          	bne	a4,a5,800003fa <strncmp+0x26>
    n--, p++, q++;
    800003ea:	367d                	addw	a2,a2,-1
    800003ec:	0505                	add	a0,a0,1
    800003ee:	0585                	add	a1,a1,1
  while(n > 0 && *p && *p == *q)
    800003f0:	f675                	bnez	a2,800003dc <strncmp+0x8>
  if(n == 0)
    return 0;
    800003f2:	4501                	li	a0,0
    800003f4:	a809                	j	80000406 <strncmp+0x32>
    800003f6:	4501                	li	a0,0
    800003f8:	a039                	j	80000406 <strncmp+0x32>
  if(n == 0)
    800003fa:	ca09                	beqz	a2,8000040c <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    800003fc:	00054503          	lbu	a0,0(a0)
    80000400:	0005c783          	lbu	a5,0(a1)
    80000404:	9d1d                	subw	a0,a0,a5
}
    80000406:	6422                	ld	s0,8(sp)
    80000408:	0141                	add	sp,sp,16
    8000040a:	8082                	ret
    return 0;
    8000040c:	4501                	li	a0,0
    8000040e:	bfe5                	j	80000406 <strncmp+0x32>

0000000080000410 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000410:	1141                	add	sp,sp,-16
    80000412:	e422                	sd	s0,8(sp)
    80000414:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000416:	87aa                	mv	a5,a0
    80000418:	86b2                	mv	a3,a2
    8000041a:	367d                	addw	a2,a2,-1
    8000041c:	00d05963          	blez	a3,8000042e <strncpy+0x1e>
    80000420:	0785                	add	a5,a5,1
    80000422:	0005c703          	lbu	a4,0(a1)
    80000426:	fee78fa3          	sb	a4,-1(a5)
    8000042a:	0585                	add	a1,a1,1
    8000042c:	f775                	bnez	a4,80000418 <strncpy+0x8>
    ;
  while(n-- > 0)
    8000042e:	873e                	mv	a4,a5
    80000430:	9fb5                	addw	a5,a5,a3
    80000432:	37fd                	addw	a5,a5,-1
    80000434:	00c05963          	blez	a2,80000446 <strncpy+0x36>
    *s++ = 0;
    80000438:	0705                	add	a4,a4,1
    8000043a:	fe070fa3          	sb	zero,-1(a4)
  while(n-- > 0)
    8000043e:	40e786bb          	subw	a3,a5,a4
    80000442:	fed04be3          	bgtz	a3,80000438 <strncpy+0x28>
  return os;
}
    80000446:	6422                	ld	s0,8(sp)
    80000448:	0141                	add	sp,sp,16
    8000044a:	8082                	ret

000000008000044c <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    8000044c:	1141                	add	sp,sp,-16
    8000044e:	e422                	sd	s0,8(sp)
    80000450:	0800                	add	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    80000452:	02c05363          	blez	a2,80000478 <safestrcpy+0x2c>
    80000456:	fff6069b          	addw	a3,a2,-1
    8000045a:	1682                	sll	a3,a3,0x20
    8000045c:	9281                	srl	a3,a3,0x20
    8000045e:	96ae                	add	a3,a3,a1
    80000460:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    80000462:	00d58963          	beq	a1,a3,80000474 <safestrcpy+0x28>
    80000466:	0585                	add	a1,a1,1
    80000468:	0785                	add	a5,a5,1
    8000046a:	fff5c703          	lbu	a4,-1(a1)
    8000046e:	fee78fa3          	sb	a4,-1(a5)
    80000472:	fb65                	bnez	a4,80000462 <safestrcpy+0x16>
    ;
  *s = 0;
    80000474:	00078023          	sb	zero,0(a5)
  return os;
}
    80000478:	6422                	ld	s0,8(sp)
    8000047a:	0141                	add	sp,sp,16
    8000047c:	8082                	ret

000000008000047e <strlen>:

int
strlen(const char *s)
{
    8000047e:	1141                	add	sp,sp,-16
    80000480:	e422                	sd	s0,8(sp)
    80000482:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    80000484:	00054783          	lbu	a5,0(a0)
    80000488:	cf91                	beqz	a5,800004a4 <strlen+0x26>
    8000048a:	0505                	add	a0,a0,1
    8000048c:	87aa                	mv	a5,a0
    8000048e:	86be                	mv	a3,a5
    80000490:	0785                	add	a5,a5,1
    80000492:	fff7c703          	lbu	a4,-1(a5)
    80000496:	ff65                	bnez	a4,8000048e <strlen+0x10>
    80000498:	40a6853b          	subw	a0,a3,a0
    8000049c:	2505                	addw	a0,a0,1
    ;
  return n;
}
    8000049e:	6422                	ld	s0,8(sp)
    800004a0:	0141                	add	sp,sp,16
    800004a2:	8082                	ret
  for(n = 0; s[n]; n++)
    800004a4:	4501                	li	a0,0
    800004a6:	bfe5                	j	8000049e <strlen+0x20>

00000000800004a8 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    800004a8:	1141                	add	sp,sp,-16
    800004aa:	e406                	sd	ra,8(sp)
    800004ac:	e022                	sd	s0,0(sp)
    800004ae:	0800                	add	s0,sp,16
  if(cpuid() == 0){
    800004b0:	00001097          	auipc	ra,0x1
    800004b4:	c0c080e7          	jalr	-1012(ra) # 800010bc <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    800004b8:	00008717          	auipc	a4,0x8
    800004bc:	41870713          	add	a4,a4,1048 # 800088d0 <started>
  if(cpuid() == 0){
    800004c0:	c139                	beqz	a0,80000506 <main+0x5e>
    while(started == 0)
    800004c2:	431c                	lw	a5,0(a4)
    800004c4:	2781                	sext.w	a5,a5
    800004c6:	dff5                	beqz	a5,800004c2 <main+0x1a>
      ;
    __sync_synchronize();
    800004c8:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    800004cc:	00001097          	auipc	ra,0x1
    800004d0:	bf0080e7          	jalr	-1040(ra) # 800010bc <cpuid>
    800004d4:	85aa                	mv	a1,a0
    800004d6:	00008517          	auipc	a0,0x8
    800004da:	b6a50513          	add	a0,a0,-1174 # 80008040 <etext+0x40>
    800004de:	00006097          	auipc	ra,0x6
    800004e2:	962080e7          	jalr	-1694(ra) # 80005e40 <printf>
    kvminithart();    // turn on paging
    800004e6:	00000097          	auipc	ra,0x0
    800004ea:	0d8080e7          	jalr	216(ra) # 800005be <kvminithart>
    trapinithart();   // install kernel trap vector
    800004ee:	00002097          	auipc	ra,0x2
    800004f2:	898080e7          	jalr	-1896(ra) # 80001d86 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    800004f6:	00005097          	auipc	ra,0x5
    800004fa:	e0a080e7          	jalr	-502(ra) # 80005300 <plicinithart>
  }

  scheduler();        
    800004fe:	00001097          	auipc	ra,0x1
    80000502:	0e0080e7          	jalr	224(ra) # 800015de <scheduler>
    consoleinit();
    80000506:	00006097          	auipc	ra,0x6
    8000050a:	800080e7          	jalr	-2048(ra) # 80005d06 <consoleinit>
    printfinit();
    8000050e:	00006097          	auipc	ra,0x6
    80000512:	b12080e7          	jalr	-1262(ra) # 80006020 <printfinit>
    printf("\n");
    80000516:	00008517          	auipc	a0,0x8
    8000051a:	b3a50513          	add	a0,a0,-1222 # 80008050 <etext+0x50>
    8000051e:	00006097          	auipc	ra,0x6
    80000522:	922080e7          	jalr	-1758(ra) # 80005e40 <printf>
    printf("xv6 kernel is booting\n");
    80000526:	00008517          	auipc	a0,0x8
    8000052a:	b0250513          	add	a0,a0,-1278 # 80008028 <etext+0x28>
    8000052e:	00006097          	auipc	ra,0x6
    80000532:	912080e7          	jalr	-1774(ra) # 80005e40 <printf>
    printf("\n");
    80000536:	00008517          	auipc	a0,0x8
    8000053a:	b1a50513          	add	a0,a0,-1254 # 80008050 <etext+0x50>
    8000053e:	00006097          	auipc	ra,0x6
    80000542:	902080e7          	jalr	-1790(ra) # 80005e40 <printf>
    kinit();         // physical page allocator
    80000546:	00000097          	auipc	ra,0x0
    8000054a:	bea080e7          	jalr	-1046(ra) # 80000130 <kinit>
    kvminit();       // create kernel page table
    8000054e:	00000097          	auipc	ra,0x0
    80000552:	326080e7          	jalr	806(ra) # 80000874 <kvminit>
    kvminithart();   // turn on paging
    80000556:	00000097          	auipc	ra,0x0
    8000055a:	068080e7          	jalr	104(ra) # 800005be <kvminithart>
    procinit();      // process table
    8000055e:	00001097          	auipc	ra,0x1
    80000562:	aaa080e7          	jalr	-1366(ra) # 80001008 <procinit>
    trapinit();      // trap vectors
    80000566:	00001097          	auipc	ra,0x1
    8000056a:	7f8080e7          	jalr	2040(ra) # 80001d5e <trapinit>
    trapinithart();  // install kernel trap vector
    8000056e:	00002097          	auipc	ra,0x2
    80000572:	818080e7          	jalr	-2024(ra) # 80001d86 <trapinithart>
    plicinit();      // set up interrupt controller
    80000576:	00005097          	auipc	ra,0x5
    8000057a:	d74080e7          	jalr	-652(ra) # 800052ea <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    8000057e:	00005097          	auipc	ra,0x5
    80000582:	d82080e7          	jalr	-638(ra) # 80005300 <plicinithart>
    binit();         // buffer cache
    80000586:	00002097          	auipc	ra,0x2
    8000058a:	f78080e7          	jalr	-136(ra) # 800024fe <binit>
    iinit();         // inode table
    8000058e:	00002097          	auipc	ra,0x2
    80000592:	616080e7          	jalr	1558(ra) # 80002ba4 <iinit>
    fileinit();      // file table
    80000596:	00003097          	auipc	ra,0x3
    8000059a:	58c080e7          	jalr	1420(ra) # 80003b22 <fileinit>
    virtio_disk_init(); // emulated hard disk
    8000059e:	00005097          	auipc	ra,0x5
    800005a2:	e6a080e7          	jalr	-406(ra) # 80005408 <virtio_disk_init>
    userinit();      // first user process
    800005a6:	00001097          	auipc	ra,0x1
    800005aa:	e1a080e7          	jalr	-486(ra) # 800013c0 <userinit>
    __sync_synchronize();
    800005ae:	0ff0000f          	fence
    started = 1;
    800005b2:	4785                	li	a5,1
    800005b4:	00008717          	auipc	a4,0x8
    800005b8:	30f72e23          	sw	a5,796(a4) # 800088d0 <started>
    800005bc:	b789                	j	800004fe <main+0x56>

00000000800005be <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    800005be:	1141                	add	sp,sp,-16
    800005c0:	e422                	sd	s0,8(sp)
    800005c2:	0800                	add	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    800005c4:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    800005c8:	00008797          	auipc	a5,0x8
    800005cc:	3107b783          	ld	a5,784(a5) # 800088d8 <kernel_pagetable>
    800005d0:	83b1                	srl	a5,a5,0xc
    800005d2:	577d                	li	a4,-1
    800005d4:	177e                	sll	a4,a4,0x3f
    800005d6:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    800005d8:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    800005dc:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    800005e0:	6422                	ld	s0,8(sp)
    800005e2:	0141                	add	sp,sp,16
    800005e4:	8082                	ret

00000000800005e6 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    800005e6:	7139                	add	sp,sp,-64
    800005e8:	fc06                	sd	ra,56(sp)
    800005ea:	f822                	sd	s0,48(sp)
    800005ec:	f426                	sd	s1,40(sp)
    800005ee:	f04a                	sd	s2,32(sp)
    800005f0:	ec4e                	sd	s3,24(sp)
    800005f2:	e852                	sd	s4,16(sp)
    800005f4:	e456                	sd	s5,8(sp)
    800005f6:	e05a                	sd	s6,0(sp)
    800005f8:	0080                	add	s0,sp,64
    800005fa:	84aa                	mv	s1,a0
    800005fc:	89ae                	mv	s3,a1
    800005fe:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    80000600:	57fd                	li	a5,-1
    80000602:	83e9                	srl	a5,a5,0x1a
    80000604:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80000606:	4b31                	li	s6,12
  if(va >= MAXVA)
    80000608:	04b7f263          	bgeu	a5,a1,8000064c <walk+0x66>
    panic("walk");
    8000060c:	00008517          	auipc	a0,0x8
    80000610:	a4c50513          	add	a0,a0,-1460 # 80008058 <etext+0x58>
    80000614:	00005097          	auipc	ra,0x5
    80000618:	7e2080e7          	jalr	2018(ra) # 80005df6 <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    8000061c:	060a8663          	beqz	s5,80000688 <walk+0xa2>
    80000620:	00000097          	auipc	ra,0x0
    80000624:	b64080e7          	jalr	-1180(ra) # 80000184 <kalloc>
    80000628:	84aa                	mv	s1,a0
    8000062a:	c529                	beqz	a0,80000674 <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    8000062c:	6605                	lui	a2,0x1
    8000062e:	4581                	li	a1,0
    80000630:	00000097          	auipc	ra,0x0
    80000634:	cd4080e7          	jalr	-812(ra) # 80000304 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80000638:	00c4d793          	srl	a5,s1,0xc
    8000063c:	07aa                	sll	a5,a5,0xa
    8000063e:	0017e793          	or	a5,a5,1
    80000642:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    80000646:	3a5d                	addw	s4,s4,-9 # ffffffffffffeff7 <end+0xffffffff7ffbd267>
    80000648:	036a0063          	beq	s4,s6,80000668 <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    8000064c:	0149d933          	srl	s2,s3,s4
    80000650:	1ff97913          	and	s2,s2,511
    80000654:	090e                	sll	s2,s2,0x3
    80000656:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    80000658:	00093483          	ld	s1,0(s2)
    8000065c:	0014f793          	and	a5,s1,1
    80000660:	dfd5                	beqz	a5,8000061c <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80000662:	80a9                	srl	s1,s1,0xa
    80000664:	04b2                	sll	s1,s1,0xc
    80000666:	b7c5                	j	80000646 <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    80000668:	00c9d513          	srl	a0,s3,0xc
    8000066c:	1ff57513          	and	a0,a0,511
    80000670:	050e                	sll	a0,a0,0x3
    80000672:	9526                	add	a0,a0,s1
}
    80000674:	70e2                	ld	ra,56(sp)
    80000676:	7442                	ld	s0,48(sp)
    80000678:	74a2                	ld	s1,40(sp)
    8000067a:	7902                	ld	s2,32(sp)
    8000067c:	69e2                	ld	s3,24(sp)
    8000067e:	6a42                	ld	s4,16(sp)
    80000680:	6aa2                	ld	s5,8(sp)
    80000682:	6b02                	ld	s6,0(sp)
    80000684:	6121                	add	sp,sp,64
    80000686:	8082                	ret
        return 0;
    80000688:	4501                	li	a0,0
    8000068a:	b7ed                	j	80000674 <walk+0x8e>

000000008000068c <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    8000068c:	57fd                	li	a5,-1
    8000068e:	83e9                	srl	a5,a5,0x1a
    80000690:	00b7f463          	bgeu	a5,a1,80000698 <walkaddr+0xc>
    return 0;
    80000694:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80000696:	8082                	ret
{
    80000698:	1141                	add	sp,sp,-16
    8000069a:	e406                	sd	ra,8(sp)
    8000069c:	e022                	sd	s0,0(sp)
    8000069e:	0800                	add	s0,sp,16
  pte = walk(pagetable, va, 0);
    800006a0:	4601                	li	a2,0
    800006a2:	00000097          	auipc	ra,0x0
    800006a6:	f44080e7          	jalr	-188(ra) # 800005e6 <walk>
  if(pte == 0)
    800006aa:	c105                	beqz	a0,800006ca <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    800006ac:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    800006ae:	0117f693          	and	a3,a5,17
    800006b2:	4745                	li	a4,17
    return 0;
    800006b4:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    800006b6:	00e68663          	beq	a3,a4,800006c2 <walkaddr+0x36>
}
    800006ba:	60a2                	ld	ra,8(sp)
    800006bc:	6402                	ld	s0,0(sp)
    800006be:	0141                	add	sp,sp,16
    800006c0:	8082                	ret
  pa = PTE2PA(*pte);
    800006c2:	83a9                	srl	a5,a5,0xa
    800006c4:	00c79513          	sll	a0,a5,0xc
  return pa;
    800006c8:	bfcd                	j	800006ba <walkaddr+0x2e>
    return 0;
    800006ca:	4501                	li	a0,0
    800006cc:	b7fd                	j	800006ba <walkaddr+0x2e>

00000000800006ce <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    800006ce:	715d                	add	sp,sp,-80
    800006d0:	e486                	sd	ra,72(sp)
    800006d2:	e0a2                	sd	s0,64(sp)
    800006d4:	fc26                	sd	s1,56(sp)
    800006d6:	f84a                	sd	s2,48(sp)
    800006d8:	f44e                	sd	s3,40(sp)
    800006da:	f052                	sd	s4,32(sp)
    800006dc:	ec56                	sd	s5,24(sp)
    800006de:	e85a                	sd	s6,16(sp)
    800006e0:	e45e                	sd	s7,8(sp)
    800006e2:	0880                	add	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    800006e4:	c639                	beqz	a2,80000732 <mappages+0x64>
    800006e6:	8aaa                	mv	s5,a0
    800006e8:	8b3a                	mv	s6,a4
    panic("mappages: size");
  
  a = PGROUNDDOWN(va);
    800006ea:	777d                	lui	a4,0xfffff
    800006ec:	00e5f7b3          	and	a5,a1,a4
  last = PGROUNDDOWN(va + size - 1);
    800006f0:	fff58993          	add	s3,a1,-1
    800006f4:	99b2                	add	s3,s3,a2
    800006f6:	00e9f9b3          	and	s3,s3,a4
  a = PGROUNDDOWN(va);
    800006fa:	893e                	mv	s2,a5
    800006fc:	40f68a33          	sub	s4,a3,a5
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    80000700:	6b85                	lui	s7,0x1
    80000702:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    80000706:	4605                	li	a2,1
    80000708:	85ca                	mv	a1,s2
    8000070a:	8556                	mv	a0,s5
    8000070c:	00000097          	auipc	ra,0x0
    80000710:	eda080e7          	jalr	-294(ra) # 800005e6 <walk>
    80000714:	cd1d                	beqz	a0,80000752 <mappages+0x84>
    if(*pte & PTE_V)
    80000716:	611c                	ld	a5,0(a0)
    80000718:	8b85                	and	a5,a5,1
    8000071a:	e785                	bnez	a5,80000742 <mappages+0x74>
    *pte = PA2PTE(pa) | perm | PTE_V;
    8000071c:	80b1                	srl	s1,s1,0xc
    8000071e:	04aa                	sll	s1,s1,0xa
    80000720:	0164e4b3          	or	s1,s1,s6
    80000724:	0014e493          	or	s1,s1,1
    80000728:	e104                	sd	s1,0(a0)
    if(a == last)
    8000072a:	05390063          	beq	s2,s3,8000076a <mappages+0x9c>
    a += PGSIZE;
    8000072e:	995e                	add	s2,s2,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    80000730:	bfc9                	j	80000702 <mappages+0x34>
    panic("mappages: size");
    80000732:	00008517          	auipc	a0,0x8
    80000736:	92e50513          	add	a0,a0,-1746 # 80008060 <etext+0x60>
    8000073a:	00005097          	auipc	ra,0x5
    8000073e:	6bc080e7          	jalr	1724(ra) # 80005df6 <panic>
      panic("mappages: remap");
    80000742:	00008517          	auipc	a0,0x8
    80000746:	92e50513          	add	a0,a0,-1746 # 80008070 <etext+0x70>
    8000074a:	00005097          	auipc	ra,0x5
    8000074e:	6ac080e7          	jalr	1708(ra) # 80005df6 <panic>
      return -1;
    80000752:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    80000754:	60a6                	ld	ra,72(sp)
    80000756:	6406                	ld	s0,64(sp)
    80000758:	74e2                	ld	s1,56(sp)
    8000075a:	7942                	ld	s2,48(sp)
    8000075c:	79a2                	ld	s3,40(sp)
    8000075e:	7a02                	ld	s4,32(sp)
    80000760:	6ae2                	ld	s5,24(sp)
    80000762:	6b42                	ld	s6,16(sp)
    80000764:	6ba2                	ld	s7,8(sp)
    80000766:	6161                	add	sp,sp,80
    80000768:	8082                	ret
  return 0;
    8000076a:	4501                	li	a0,0
    8000076c:	b7e5                	j	80000754 <mappages+0x86>

000000008000076e <kvmmap>:
{
    8000076e:	1141                	add	sp,sp,-16
    80000770:	e406                	sd	ra,8(sp)
    80000772:	e022                	sd	s0,0(sp)
    80000774:	0800                	add	s0,sp,16
    80000776:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80000778:	86b2                	mv	a3,a2
    8000077a:	863e                	mv	a2,a5
    8000077c:	00000097          	auipc	ra,0x0
    80000780:	f52080e7          	jalr	-174(ra) # 800006ce <mappages>
    80000784:	e509                	bnez	a0,8000078e <kvmmap+0x20>
}
    80000786:	60a2                	ld	ra,8(sp)
    80000788:	6402                	ld	s0,0(sp)
    8000078a:	0141                	add	sp,sp,16
    8000078c:	8082                	ret
    panic("kvmmap");
    8000078e:	00008517          	auipc	a0,0x8
    80000792:	8f250513          	add	a0,a0,-1806 # 80008080 <etext+0x80>
    80000796:	00005097          	auipc	ra,0x5
    8000079a:	660080e7          	jalr	1632(ra) # 80005df6 <panic>

000000008000079e <kvmmake>:
{
    8000079e:	1101                	add	sp,sp,-32
    800007a0:	ec06                	sd	ra,24(sp)
    800007a2:	e822                	sd	s0,16(sp)
    800007a4:	e426                	sd	s1,8(sp)
    800007a6:	e04a                	sd	s2,0(sp)
    800007a8:	1000                	add	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    800007aa:	00000097          	auipc	ra,0x0
    800007ae:	9da080e7          	jalr	-1574(ra) # 80000184 <kalloc>
    800007b2:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    800007b4:	6605                	lui	a2,0x1
    800007b6:	4581                	li	a1,0
    800007b8:	00000097          	auipc	ra,0x0
    800007bc:	b4c080e7          	jalr	-1204(ra) # 80000304 <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    800007c0:	4719                	li	a4,6
    800007c2:	6685                	lui	a3,0x1
    800007c4:	10000637          	lui	a2,0x10000
    800007c8:	100005b7          	lui	a1,0x10000
    800007cc:	8526                	mv	a0,s1
    800007ce:	00000097          	auipc	ra,0x0
    800007d2:	fa0080e7          	jalr	-96(ra) # 8000076e <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    800007d6:	4719                	li	a4,6
    800007d8:	6685                	lui	a3,0x1
    800007da:	10001637          	lui	a2,0x10001
    800007de:	100015b7          	lui	a1,0x10001
    800007e2:	8526                	mv	a0,s1
    800007e4:	00000097          	auipc	ra,0x0
    800007e8:	f8a080e7          	jalr	-118(ra) # 8000076e <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    800007ec:	4719                	li	a4,6
    800007ee:	004006b7          	lui	a3,0x400
    800007f2:	0c000637          	lui	a2,0xc000
    800007f6:	0c0005b7          	lui	a1,0xc000
    800007fa:	8526                	mv	a0,s1
    800007fc:	00000097          	auipc	ra,0x0
    80000800:	f72080e7          	jalr	-142(ra) # 8000076e <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    80000804:	00007917          	auipc	s2,0x7
    80000808:	7fc90913          	add	s2,s2,2044 # 80008000 <etext>
    8000080c:	4729                	li	a4,10
    8000080e:	80007697          	auipc	a3,0x80007
    80000812:	7f268693          	add	a3,a3,2034 # 8000 <_entry-0x7fff8000>
    80000816:	4605                	li	a2,1
    80000818:	067e                	sll	a2,a2,0x1f
    8000081a:	85b2                	mv	a1,a2
    8000081c:	8526                	mv	a0,s1
    8000081e:	00000097          	auipc	ra,0x0
    80000822:	f50080e7          	jalr	-176(ra) # 8000076e <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    80000826:	4719                	li	a4,6
    80000828:	46c5                	li	a3,17
    8000082a:	06ee                	sll	a3,a3,0x1b
    8000082c:	412686b3          	sub	a3,a3,s2
    80000830:	864a                	mv	a2,s2
    80000832:	85ca                	mv	a1,s2
    80000834:	8526                	mv	a0,s1
    80000836:	00000097          	auipc	ra,0x0
    8000083a:	f38080e7          	jalr	-200(ra) # 8000076e <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    8000083e:	4729                	li	a4,10
    80000840:	6685                	lui	a3,0x1
    80000842:	00006617          	auipc	a2,0x6
    80000846:	7be60613          	add	a2,a2,1982 # 80007000 <_trampoline>
    8000084a:	040005b7          	lui	a1,0x4000
    8000084e:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000850:	05b2                	sll	a1,a1,0xc
    80000852:	8526                	mv	a0,s1
    80000854:	00000097          	auipc	ra,0x0
    80000858:	f1a080e7          	jalr	-230(ra) # 8000076e <kvmmap>
  proc_mapstacks(kpgtbl);
    8000085c:	8526                	mv	a0,s1
    8000085e:	00000097          	auipc	ra,0x0
    80000862:	714080e7          	jalr	1812(ra) # 80000f72 <proc_mapstacks>
}
    80000866:	8526                	mv	a0,s1
    80000868:	60e2                	ld	ra,24(sp)
    8000086a:	6442                	ld	s0,16(sp)
    8000086c:	64a2                	ld	s1,8(sp)
    8000086e:	6902                	ld	s2,0(sp)
    80000870:	6105                	add	sp,sp,32
    80000872:	8082                	ret

0000000080000874 <kvminit>:
{
    80000874:	1141                	add	sp,sp,-16
    80000876:	e406                	sd	ra,8(sp)
    80000878:	e022                	sd	s0,0(sp)
    8000087a:	0800                	add	s0,sp,16
  kernel_pagetable = kvmmake();
    8000087c:	00000097          	auipc	ra,0x0
    80000880:	f22080e7          	jalr	-222(ra) # 8000079e <kvmmake>
    80000884:	00008797          	auipc	a5,0x8
    80000888:	04a7ba23          	sd	a0,84(a5) # 800088d8 <kernel_pagetable>
}
    8000088c:	60a2                	ld	ra,8(sp)
    8000088e:	6402                	ld	s0,0(sp)
    80000890:	0141                	add	sp,sp,16
    80000892:	8082                	ret

0000000080000894 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80000894:	715d                	add	sp,sp,-80
    80000896:	e486                	sd	ra,72(sp)
    80000898:	e0a2                	sd	s0,64(sp)
    8000089a:	fc26                	sd	s1,56(sp)
    8000089c:	f84a                	sd	s2,48(sp)
    8000089e:	f44e                	sd	s3,40(sp)
    800008a0:	f052                	sd	s4,32(sp)
    800008a2:	ec56                	sd	s5,24(sp)
    800008a4:	e85a                	sd	s6,16(sp)
    800008a6:	e45e                	sd	s7,8(sp)
    800008a8:	0880                	add	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    800008aa:	03459793          	sll	a5,a1,0x34
    800008ae:	e795                	bnez	a5,800008da <uvmunmap+0x46>
    800008b0:	8a2a                	mv	s4,a0
    800008b2:	892e                	mv	s2,a1
    800008b4:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800008b6:	0632                	sll	a2,a2,0xc
    800008b8:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    800008bc:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800008be:	6b05                	lui	s6,0x1
    800008c0:	0735e263          	bltu	a1,s3,80000924 <uvmunmap+0x90>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    800008c4:	60a6                	ld	ra,72(sp)
    800008c6:	6406                	ld	s0,64(sp)
    800008c8:	74e2                	ld	s1,56(sp)
    800008ca:	7942                	ld	s2,48(sp)
    800008cc:	79a2                	ld	s3,40(sp)
    800008ce:	7a02                	ld	s4,32(sp)
    800008d0:	6ae2                	ld	s5,24(sp)
    800008d2:	6b42                	ld	s6,16(sp)
    800008d4:	6ba2                	ld	s7,8(sp)
    800008d6:	6161                	add	sp,sp,80
    800008d8:	8082                	ret
    panic("uvmunmap: not aligned");
    800008da:	00007517          	auipc	a0,0x7
    800008de:	7ae50513          	add	a0,a0,1966 # 80008088 <etext+0x88>
    800008e2:	00005097          	auipc	ra,0x5
    800008e6:	514080e7          	jalr	1300(ra) # 80005df6 <panic>
      panic("uvmunmap: walk");
    800008ea:	00007517          	auipc	a0,0x7
    800008ee:	7b650513          	add	a0,a0,1974 # 800080a0 <etext+0xa0>
    800008f2:	00005097          	auipc	ra,0x5
    800008f6:	504080e7          	jalr	1284(ra) # 80005df6 <panic>
      panic("uvmunmap: not mapped");
    800008fa:	00007517          	auipc	a0,0x7
    800008fe:	7b650513          	add	a0,a0,1974 # 800080b0 <etext+0xb0>
    80000902:	00005097          	auipc	ra,0x5
    80000906:	4f4080e7          	jalr	1268(ra) # 80005df6 <panic>
      panic("uvmunmap: not a leaf");
    8000090a:	00007517          	auipc	a0,0x7
    8000090e:	7be50513          	add	a0,a0,1982 # 800080c8 <etext+0xc8>
    80000912:	00005097          	auipc	ra,0x5
    80000916:	4e4080e7          	jalr	1252(ra) # 80005df6 <panic>
    *pte = 0;
    8000091a:	0004b023          	sd	zero,0(s1) # ffffffff80000000 <end+0xfffffffefffbe270>
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    8000091e:	995a                	add	s2,s2,s6
    80000920:	fb3972e3          	bgeu	s2,s3,800008c4 <uvmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    80000924:	4601                	li	a2,0
    80000926:	85ca                	mv	a1,s2
    80000928:	8552                	mv	a0,s4
    8000092a:	00000097          	auipc	ra,0x0
    8000092e:	cbc080e7          	jalr	-836(ra) # 800005e6 <walk>
    80000932:	84aa                	mv	s1,a0
    80000934:	d95d                	beqz	a0,800008ea <uvmunmap+0x56>
    if((*pte & PTE_V) == 0)
    80000936:	6108                	ld	a0,0(a0)
    80000938:	00157793          	and	a5,a0,1
    8000093c:	dfdd                	beqz	a5,800008fa <uvmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V)
    8000093e:	3ff57793          	and	a5,a0,1023
    80000942:	fd7784e3          	beq	a5,s7,8000090a <uvmunmap+0x76>
    if(do_free){
    80000946:	fc0a8ae3          	beqz	s5,8000091a <uvmunmap+0x86>
      uint64 pa = PTE2PA(*pte);
    8000094a:	8129                	srl	a0,a0,0xa
      kfree((void*)pa);
    8000094c:	0532                	sll	a0,a0,0xc
    8000094e:	fffff097          	auipc	ra,0xfffff
    80000952:	6ce080e7          	jalr	1742(ra) # 8000001c <kfree>
    80000956:	b7d1                	j	8000091a <uvmunmap+0x86>

0000000080000958 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80000958:	1101                	add	sp,sp,-32
    8000095a:	ec06                	sd	ra,24(sp)
    8000095c:	e822                	sd	s0,16(sp)
    8000095e:	e426                	sd	s1,8(sp)
    80000960:	1000                	add	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80000962:	00000097          	auipc	ra,0x0
    80000966:	822080e7          	jalr	-2014(ra) # 80000184 <kalloc>
    8000096a:	84aa                	mv	s1,a0
  if(pagetable == 0)
    8000096c:	c519                	beqz	a0,8000097a <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    8000096e:	6605                	lui	a2,0x1
    80000970:	4581                	li	a1,0
    80000972:	00000097          	auipc	ra,0x0
    80000976:	992080e7          	jalr	-1646(ra) # 80000304 <memset>
  return pagetable;
}
    8000097a:	8526                	mv	a0,s1
    8000097c:	60e2                	ld	ra,24(sp)
    8000097e:	6442                	ld	s0,16(sp)
    80000980:	64a2                	ld	s1,8(sp)
    80000982:	6105                	add	sp,sp,32
    80000984:	8082                	ret

0000000080000986 <uvmfirst>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvmfirst(pagetable_t pagetable, uchar *src, uint sz)
{
    80000986:	7179                	add	sp,sp,-48
    80000988:	f406                	sd	ra,40(sp)
    8000098a:	f022                	sd	s0,32(sp)
    8000098c:	ec26                	sd	s1,24(sp)
    8000098e:	e84a                	sd	s2,16(sp)
    80000990:	e44e                	sd	s3,8(sp)
    80000992:	e052                	sd	s4,0(sp)
    80000994:	1800                	add	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    80000996:	6785                	lui	a5,0x1
    80000998:	04f67863          	bgeu	a2,a5,800009e8 <uvmfirst+0x62>
    8000099c:	8a2a                	mv	s4,a0
    8000099e:	89ae                	mv	s3,a1
    800009a0:	84b2                	mv	s1,a2
    panic("uvmfirst: more than a page");
  mem = kalloc();
    800009a2:	fffff097          	auipc	ra,0xfffff
    800009a6:	7e2080e7          	jalr	2018(ra) # 80000184 <kalloc>
    800009aa:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    800009ac:	6605                	lui	a2,0x1
    800009ae:	4581                	li	a1,0
    800009b0:	00000097          	auipc	ra,0x0
    800009b4:	954080e7          	jalr	-1708(ra) # 80000304 <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    800009b8:	4779                	li	a4,30
    800009ba:	86ca                	mv	a3,s2
    800009bc:	6605                	lui	a2,0x1
    800009be:	4581                	li	a1,0
    800009c0:	8552                	mv	a0,s4
    800009c2:	00000097          	auipc	ra,0x0
    800009c6:	d0c080e7          	jalr	-756(ra) # 800006ce <mappages>
  memmove(mem, src, sz);
    800009ca:	8626                	mv	a2,s1
    800009cc:	85ce                	mv	a1,s3
    800009ce:	854a                	mv	a0,s2
    800009d0:	00000097          	auipc	ra,0x0
    800009d4:	990080e7          	jalr	-1648(ra) # 80000360 <memmove>
}
    800009d8:	70a2                	ld	ra,40(sp)
    800009da:	7402                	ld	s0,32(sp)
    800009dc:	64e2                	ld	s1,24(sp)
    800009de:	6942                	ld	s2,16(sp)
    800009e0:	69a2                	ld	s3,8(sp)
    800009e2:	6a02                	ld	s4,0(sp)
    800009e4:	6145                	add	sp,sp,48
    800009e6:	8082                	ret
    panic("uvmfirst: more than a page");
    800009e8:	00007517          	auipc	a0,0x7
    800009ec:	6f850513          	add	a0,a0,1784 # 800080e0 <etext+0xe0>
    800009f0:	00005097          	auipc	ra,0x5
    800009f4:	406080e7          	jalr	1030(ra) # 80005df6 <panic>

00000000800009f8 <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    800009f8:	1101                	add	sp,sp,-32
    800009fa:	ec06                	sd	ra,24(sp)
    800009fc:	e822                	sd	s0,16(sp)
    800009fe:	e426                	sd	s1,8(sp)
    80000a00:	1000                	add	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    80000a02:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    80000a04:	00b67d63          	bgeu	a2,a1,80000a1e <uvmdealloc+0x26>
    80000a08:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80000a0a:	6785                	lui	a5,0x1
    80000a0c:	17fd                	add	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000a0e:	00f60733          	add	a4,a2,a5
    80000a12:	76fd                	lui	a3,0xfffff
    80000a14:	8f75                	and	a4,a4,a3
    80000a16:	97ae                	add	a5,a5,a1
    80000a18:	8ff5                	and	a5,a5,a3
    80000a1a:	00f76863          	bltu	a4,a5,80000a2a <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    80000a1e:	8526                	mv	a0,s1
    80000a20:	60e2                	ld	ra,24(sp)
    80000a22:	6442                	ld	s0,16(sp)
    80000a24:	64a2                	ld	s1,8(sp)
    80000a26:	6105                	add	sp,sp,32
    80000a28:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80000a2a:	8f99                	sub	a5,a5,a4
    80000a2c:	83b1                	srl	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    80000a2e:	4685                	li	a3,1
    80000a30:	0007861b          	sext.w	a2,a5
    80000a34:	85ba                	mv	a1,a4
    80000a36:	00000097          	auipc	ra,0x0
    80000a3a:	e5e080e7          	jalr	-418(ra) # 80000894 <uvmunmap>
    80000a3e:	b7c5                	j	80000a1e <uvmdealloc+0x26>

0000000080000a40 <uvmalloc>:
  if(newsz < oldsz)
    80000a40:	0ab66563          	bltu	a2,a1,80000aea <uvmalloc+0xaa>
{
    80000a44:	7139                	add	sp,sp,-64
    80000a46:	fc06                	sd	ra,56(sp)
    80000a48:	f822                	sd	s0,48(sp)
    80000a4a:	f426                	sd	s1,40(sp)
    80000a4c:	f04a                	sd	s2,32(sp)
    80000a4e:	ec4e                	sd	s3,24(sp)
    80000a50:	e852                	sd	s4,16(sp)
    80000a52:	e456                	sd	s5,8(sp)
    80000a54:	e05a                	sd	s6,0(sp)
    80000a56:	0080                	add	s0,sp,64
    80000a58:	8aaa                	mv	s5,a0
    80000a5a:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    80000a5c:	6785                	lui	a5,0x1
    80000a5e:	17fd                	add	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000a60:	95be                	add	a1,a1,a5
    80000a62:	77fd                	lui	a5,0xfffff
    80000a64:	00f5f9b3          	and	s3,a1,a5
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000a68:	08c9f363          	bgeu	s3,a2,80000aee <uvmalloc+0xae>
    80000a6c:	894e                	mv	s2,s3
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000a6e:	0126eb13          	or	s6,a3,18
    mem = kalloc();
    80000a72:	fffff097          	auipc	ra,0xfffff
    80000a76:	712080e7          	jalr	1810(ra) # 80000184 <kalloc>
    80000a7a:	84aa                	mv	s1,a0
    if(mem == 0){
    80000a7c:	c51d                	beqz	a0,80000aaa <uvmalloc+0x6a>
    memset(mem, 0, PGSIZE);
    80000a7e:	6605                	lui	a2,0x1
    80000a80:	4581                	li	a1,0
    80000a82:	00000097          	auipc	ra,0x0
    80000a86:	882080e7          	jalr	-1918(ra) # 80000304 <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000a8a:	875a                	mv	a4,s6
    80000a8c:	86a6                	mv	a3,s1
    80000a8e:	6605                	lui	a2,0x1
    80000a90:	85ca                	mv	a1,s2
    80000a92:	8556                	mv	a0,s5
    80000a94:	00000097          	auipc	ra,0x0
    80000a98:	c3a080e7          	jalr	-966(ra) # 800006ce <mappages>
    80000a9c:	e90d                	bnez	a0,80000ace <uvmalloc+0x8e>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000a9e:	6785                	lui	a5,0x1
    80000aa0:	993e                	add	s2,s2,a5
    80000aa2:	fd4968e3          	bltu	s2,s4,80000a72 <uvmalloc+0x32>
  return newsz;
    80000aa6:	8552                	mv	a0,s4
    80000aa8:	a809                	j	80000aba <uvmalloc+0x7a>
      uvmdealloc(pagetable, a, oldsz);
    80000aaa:	864e                	mv	a2,s3
    80000aac:	85ca                	mv	a1,s2
    80000aae:	8556                	mv	a0,s5
    80000ab0:	00000097          	auipc	ra,0x0
    80000ab4:	f48080e7          	jalr	-184(ra) # 800009f8 <uvmdealloc>
      return 0;
    80000ab8:	4501                	li	a0,0
}
    80000aba:	70e2                	ld	ra,56(sp)
    80000abc:	7442                	ld	s0,48(sp)
    80000abe:	74a2                	ld	s1,40(sp)
    80000ac0:	7902                	ld	s2,32(sp)
    80000ac2:	69e2                	ld	s3,24(sp)
    80000ac4:	6a42                	ld	s4,16(sp)
    80000ac6:	6aa2                	ld	s5,8(sp)
    80000ac8:	6b02                	ld	s6,0(sp)
    80000aca:	6121                	add	sp,sp,64
    80000acc:	8082                	ret
      kfree(mem);
    80000ace:	8526                	mv	a0,s1
    80000ad0:	fffff097          	auipc	ra,0xfffff
    80000ad4:	54c080e7          	jalr	1356(ra) # 8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80000ad8:	864e                	mv	a2,s3
    80000ada:	85ca                	mv	a1,s2
    80000adc:	8556                	mv	a0,s5
    80000ade:	00000097          	auipc	ra,0x0
    80000ae2:	f1a080e7          	jalr	-230(ra) # 800009f8 <uvmdealloc>
      return 0;
    80000ae6:	4501                	li	a0,0
    80000ae8:	bfc9                	j	80000aba <uvmalloc+0x7a>
    return oldsz;
    80000aea:	852e                	mv	a0,a1
}
    80000aec:	8082                	ret
  return newsz;
    80000aee:	8532                	mv	a0,a2
    80000af0:	b7e9                	j	80000aba <uvmalloc+0x7a>

0000000080000af2 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    80000af2:	7179                	add	sp,sp,-48
    80000af4:	f406                	sd	ra,40(sp)
    80000af6:	f022                	sd	s0,32(sp)
    80000af8:	ec26                	sd	s1,24(sp)
    80000afa:	e84a                	sd	s2,16(sp)
    80000afc:	e44e                	sd	s3,8(sp)
    80000afe:	e052                	sd	s4,0(sp)
    80000b00:	1800                	add	s0,sp,48
    80000b02:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80000b04:	84aa                	mv	s1,a0
    80000b06:	6905                	lui	s2,0x1
    80000b08:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000b0a:	4985                	li	s3,1
    80000b0c:	a829                	j	80000b26 <freewalk+0x34>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    80000b0e:	83a9                	srl	a5,a5,0xa
      freewalk((pagetable_t)child);
    80000b10:	00c79513          	sll	a0,a5,0xc
    80000b14:	00000097          	auipc	ra,0x0
    80000b18:	fde080e7          	jalr	-34(ra) # 80000af2 <freewalk>
      pagetable[i] = 0;
    80000b1c:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    80000b20:	04a1                	add	s1,s1,8
    80000b22:	03248163          	beq	s1,s2,80000b44 <freewalk+0x52>
    pte_t pte = pagetable[i];
    80000b26:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000b28:	00f7f713          	and	a4,a5,15
    80000b2c:	ff3701e3          	beq	a4,s3,80000b0e <freewalk+0x1c>
    } else if(pte & PTE_V){
    80000b30:	8b85                	and	a5,a5,1
    80000b32:	d7fd                	beqz	a5,80000b20 <freewalk+0x2e>
      panic("freewalk: leaf");
    80000b34:	00007517          	auipc	a0,0x7
    80000b38:	5cc50513          	add	a0,a0,1484 # 80008100 <etext+0x100>
    80000b3c:	00005097          	auipc	ra,0x5
    80000b40:	2ba080e7          	jalr	698(ra) # 80005df6 <panic>
    }
  }
  kfree((void*)pagetable);
    80000b44:	8552                	mv	a0,s4
    80000b46:	fffff097          	auipc	ra,0xfffff
    80000b4a:	4d6080e7          	jalr	1238(ra) # 8000001c <kfree>
}
    80000b4e:	70a2                	ld	ra,40(sp)
    80000b50:	7402                	ld	s0,32(sp)
    80000b52:	64e2                	ld	s1,24(sp)
    80000b54:	6942                	ld	s2,16(sp)
    80000b56:	69a2                	ld	s3,8(sp)
    80000b58:	6a02                	ld	s4,0(sp)
    80000b5a:	6145                	add	sp,sp,48
    80000b5c:	8082                	ret

0000000080000b5e <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80000b5e:	1101                	add	sp,sp,-32
    80000b60:	ec06                	sd	ra,24(sp)
    80000b62:	e822                	sd	s0,16(sp)
    80000b64:	e426                	sd	s1,8(sp)
    80000b66:	1000                	add	s0,sp,32
    80000b68:	84aa                	mv	s1,a0
  if(sz > 0)
    80000b6a:	e999                	bnez	a1,80000b80 <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80000b6c:	8526                	mv	a0,s1
    80000b6e:	00000097          	auipc	ra,0x0
    80000b72:	f84080e7          	jalr	-124(ra) # 80000af2 <freewalk>
}
    80000b76:	60e2                	ld	ra,24(sp)
    80000b78:	6442                	ld	s0,16(sp)
    80000b7a:	64a2                	ld	s1,8(sp)
    80000b7c:	6105                	add	sp,sp,32
    80000b7e:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80000b80:	6785                	lui	a5,0x1
    80000b82:	17fd                	add	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000b84:	95be                	add	a1,a1,a5
    80000b86:	4685                	li	a3,1
    80000b88:	00c5d613          	srl	a2,a1,0xc
    80000b8c:	4581                	li	a1,0
    80000b8e:	00000097          	auipc	ra,0x0
    80000b92:	d06080e7          	jalr	-762(ra) # 80000894 <uvmunmap>
    80000b96:	bfd9                	j	80000b6c <uvmfree+0xe>

0000000080000b98 <uvmcopy>:
// physical memory.
// returns 0 on success, -1 on failure.
// frees any allocated pages on failure.
int
uvmcopy(pagetable_t old, pagetable_t new, uint64 sz)
{
    80000b98:	7139                	add	sp,sp,-64
    80000b9a:	fc06                	sd	ra,56(sp)
    80000b9c:	f822                	sd	s0,48(sp)
    80000b9e:	f426                	sd	s1,40(sp)
    80000ba0:	f04a                	sd	s2,32(sp)
    80000ba2:	ec4e                	sd	s3,24(sp)
    80000ba4:	e852                	sd	s4,16(sp)
    80000ba6:	e456                	sd	s5,8(sp)
    80000ba8:	e05a                	sd	s6,0(sp)
    80000baa:	0080                	add	s0,sp,64
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  //char *mem;

  for(i = 0; i < sz; i += PGSIZE) {
    80000bac:	ca4d                	beqz	a2,80000c5e <uvmcopy+0xc6>
    80000bae:	8b2a                	mv	s6,a0
    80000bb0:	8aae                	mv	s5,a1
    80000bb2:	8a32                	mv	s4,a2
    80000bb4:	4481                	li	s1,0
    80000bb6:	a0b9                	j	80000c04 <uvmcopy+0x6c>
      if ((pte = walk(old, i, 0)) == 0)
          panic("uvmcopy: pte should exist");
    80000bb8:	00007517          	auipc	a0,0x7
    80000bbc:	55850513          	add	a0,a0,1368 # 80008110 <etext+0x110>
    80000bc0:	00005097          	auipc	ra,0x5
    80000bc4:	236080e7          	jalr	566(ra) # 80005df6 <panic>
      if ((*pte & PTE_V) == 0)
          panic("uvmcopy: page not present");
    80000bc8:	00007517          	auipc	a0,0x7
    80000bcc:	56850513          	add	a0,a0,1384 # 80008130 <etext+0x130>
    80000bd0:	00005097          	auipc	ra,0x5
    80000bd4:	226080e7          	jalr	550(ra) # 80005df6 <panic>
      pa = PTE2PA(*pte);

      if (*pte & PTE_W) {
          *pte = (*pte & ~PTE_W) | PTE_COW;
      }
      flags = PTE_FLAGS(*pte);
    80000bd8:	6118                	ld	a4,0(a0)

      if (mappages(new, i, PGSIZE, (uint64) pa, flags) != 0) {
    80000bda:	3ff77713          	and	a4,a4,1023
    80000bde:	86ca                	mv	a3,s2
    80000be0:	6605                	lui	a2,0x1
    80000be2:	85a6                	mv	a1,s1
    80000be4:	8556                	mv	a0,s5
    80000be6:	00000097          	auipc	ra,0x0
    80000bea:	ae8080e7          	jalr	-1304(ra) # 800006ce <mappages>
    80000bee:	89aa                	mv	s3,a0
    80000bf0:	e131                	bnez	a0,80000c34 <uvmcopy+0x9c>
          goto err;
      }
      //increment refcount
      krefpage((void*)pa);
    80000bf2:	854a                	mv	a0,s2
    80000bf4:	fffff097          	auipc	ra,0xfffff
    80000bf8:	6c0080e7          	jalr	1728(ra) # 800002b4 <krefpage>
  for(i = 0; i < sz; i += PGSIZE) {
    80000bfc:	6785                	lui	a5,0x1
    80000bfe:	94be                	add	s1,s1,a5
    80000c00:	0544f463          	bgeu	s1,s4,80000c48 <uvmcopy+0xb0>
      if ((pte = walk(old, i, 0)) == 0)
    80000c04:	4601                	li	a2,0
    80000c06:	85a6                	mv	a1,s1
    80000c08:	855a                	mv	a0,s6
    80000c0a:	00000097          	auipc	ra,0x0
    80000c0e:	9dc080e7          	jalr	-1572(ra) # 800005e6 <walk>
    80000c12:	d15d                	beqz	a0,80000bb8 <uvmcopy+0x20>
      if ((*pte & PTE_V) == 0)
    80000c14:	611c                	ld	a5,0(a0)
    80000c16:	0017f713          	and	a4,a5,1
    80000c1a:	d75d                	beqz	a4,80000bc8 <uvmcopy+0x30>
      pa = PTE2PA(*pte);
    80000c1c:	00a7d913          	srl	s2,a5,0xa
    80000c20:	0932                	sll	s2,s2,0xc
      if (*pte & PTE_W) {
    80000c22:	0047f713          	and	a4,a5,4
    80000c26:	db4d                	beqz	a4,80000bd8 <uvmcopy+0x40>
          *pte = (*pte & ~PTE_W) | PTE_COW;
    80000c28:	efb7f793          	and	a5,a5,-261
    80000c2c:	1007e793          	or	a5,a5,256
    80000c30:	e11c                	sd	a5,0(a0)
    80000c32:	b75d                	j	80000bd8 <uvmcopy+0x40>
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80000c34:	4685                	li	a3,1
    80000c36:	00c4d613          	srl	a2,s1,0xc
    80000c3a:	4581                	li	a1,0
    80000c3c:	8556                	mv	a0,s5
    80000c3e:	00000097          	auipc	ra,0x0
    80000c42:	c56080e7          	jalr	-938(ra) # 80000894 <uvmunmap>
  return -1;
    80000c46:	59fd                	li	s3,-1
}
    80000c48:	854e                	mv	a0,s3
    80000c4a:	70e2                	ld	ra,56(sp)
    80000c4c:	7442                	ld	s0,48(sp)
    80000c4e:	74a2                	ld	s1,40(sp)
    80000c50:	7902                	ld	s2,32(sp)
    80000c52:	69e2                	ld	s3,24(sp)
    80000c54:	6a42                	ld	s4,16(sp)
    80000c56:	6aa2                	ld	s5,8(sp)
    80000c58:	6b02                	ld	s6,0(sp)
    80000c5a:	6121                	add	sp,sp,64
    80000c5c:	8082                	ret
  return 0;
    80000c5e:	4981                	li	s3,0
    80000c60:	b7e5                	j	80000c48 <uvmcopy+0xb0>

0000000080000c62 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80000c62:	1141                	add	sp,sp,-16
    80000c64:	e406                	sd	ra,8(sp)
    80000c66:	e022                	sd	s0,0(sp)
    80000c68:	0800                	add	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80000c6a:	4601                	li	a2,0
    80000c6c:	00000097          	auipc	ra,0x0
    80000c70:	97a080e7          	jalr	-1670(ra) # 800005e6 <walk>
  if(pte == 0)
    80000c74:	c901                	beqz	a0,80000c84 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000c76:	611c                	ld	a5,0(a0)
    80000c78:	9bbd                	and	a5,a5,-17
    80000c7a:	e11c                	sd	a5,0(a0)
}
    80000c7c:	60a2                	ld	ra,8(sp)
    80000c7e:	6402                	ld	s0,0(sp)
    80000c80:	0141                	add	sp,sp,16
    80000c82:	8082                	ret
    panic("uvmclear");
    80000c84:	00007517          	auipc	a0,0x7
    80000c88:	4cc50513          	add	a0,a0,1228 # 80008150 <etext+0x150>
    80000c8c:	00005097          	auipc	ra,0x5
    80000c90:	16a080e7          	jalr	362(ra) # 80005df6 <panic>

0000000080000c94 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000c94:	caa5                	beqz	a3,80000d04 <copyin+0x70>
{
    80000c96:	715d                	add	sp,sp,-80
    80000c98:	e486                	sd	ra,72(sp)
    80000c9a:	e0a2                	sd	s0,64(sp)
    80000c9c:	fc26                	sd	s1,56(sp)
    80000c9e:	f84a                	sd	s2,48(sp)
    80000ca0:	f44e                	sd	s3,40(sp)
    80000ca2:	f052                	sd	s4,32(sp)
    80000ca4:	ec56                	sd	s5,24(sp)
    80000ca6:	e85a                	sd	s6,16(sp)
    80000ca8:	e45e                	sd	s7,8(sp)
    80000caa:	e062                	sd	s8,0(sp)
    80000cac:	0880                	add	s0,sp,80
    80000cae:	8b2a                	mv	s6,a0
    80000cb0:	8a2e                	mv	s4,a1
    80000cb2:	8c32                	mv	s8,a2
    80000cb4:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000cb6:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000cb8:	6a85                	lui	s5,0x1
    80000cba:	a01d                	j	80000ce0 <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000cbc:	018505b3          	add	a1,a0,s8
    80000cc0:	0004861b          	sext.w	a2,s1
    80000cc4:	412585b3          	sub	a1,a1,s2
    80000cc8:	8552                	mv	a0,s4
    80000cca:	fffff097          	auipc	ra,0xfffff
    80000cce:	696080e7          	jalr	1686(ra) # 80000360 <memmove>

    len -= n;
    80000cd2:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000cd6:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80000cd8:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000cdc:	02098263          	beqz	s3,80000d00 <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    80000ce0:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000ce4:	85ca                	mv	a1,s2
    80000ce6:	855a                	mv	a0,s6
    80000ce8:	00000097          	auipc	ra,0x0
    80000cec:	9a4080e7          	jalr	-1628(ra) # 8000068c <walkaddr>
    if(pa0 == 0)
    80000cf0:	cd01                	beqz	a0,80000d08 <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80000cf2:	418904b3          	sub	s1,s2,s8
    80000cf6:	94d6                	add	s1,s1,s5
    80000cf8:	fc99f2e3          	bgeu	s3,s1,80000cbc <copyin+0x28>
    80000cfc:	84ce                	mv	s1,s3
    80000cfe:	bf7d                	j	80000cbc <copyin+0x28>
  }
  return 0;
    80000d00:	4501                	li	a0,0
    80000d02:	a021                	j	80000d0a <copyin+0x76>
    80000d04:	4501                	li	a0,0
}
    80000d06:	8082                	ret
      return -1;
    80000d08:	557d                	li	a0,-1
}
    80000d0a:	60a6                	ld	ra,72(sp)
    80000d0c:	6406                	ld	s0,64(sp)
    80000d0e:	74e2                	ld	s1,56(sp)
    80000d10:	7942                	ld	s2,48(sp)
    80000d12:	79a2                	ld	s3,40(sp)
    80000d14:	7a02                	ld	s4,32(sp)
    80000d16:	6ae2                	ld	s5,24(sp)
    80000d18:	6b42                	ld	s6,16(sp)
    80000d1a:	6ba2                	ld	s7,8(sp)
    80000d1c:	6c02                	ld	s8,0(sp)
    80000d1e:	6161                	add	sp,sp,80
    80000d20:	8082                	ret

0000000080000d22 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80000d22:	c2dd                	beqz	a3,80000dc8 <copyinstr+0xa6>
{
    80000d24:	715d                	add	sp,sp,-80
    80000d26:	e486                	sd	ra,72(sp)
    80000d28:	e0a2                	sd	s0,64(sp)
    80000d2a:	fc26                	sd	s1,56(sp)
    80000d2c:	f84a                	sd	s2,48(sp)
    80000d2e:	f44e                	sd	s3,40(sp)
    80000d30:	f052                	sd	s4,32(sp)
    80000d32:	ec56                	sd	s5,24(sp)
    80000d34:	e85a                	sd	s6,16(sp)
    80000d36:	e45e                	sd	s7,8(sp)
    80000d38:	0880                	add	s0,sp,80
    80000d3a:	8a2a                	mv	s4,a0
    80000d3c:	8b2e                	mv	s6,a1
    80000d3e:	8bb2                	mv	s7,a2
    80000d40:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    80000d42:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000d44:	6985                	lui	s3,0x1
    80000d46:	a02d                	j	80000d70 <copyinstr+0x4e>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000d48:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    80000d4c:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80000d4e:	37fd                	addw	a5,a5,-1
    80000d50:	0007851b          	sext.w	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000d54:	60a6                	ld	ra,72(sp)
    80000d56:	6406                	ld	s0,64(sp)
    80000d58:	74e2                	ld	s1,56(sp)
    80000d5a:	7942                	ld	s2,48(sp)
    80000d5c:	79a2                	ld	s3,40(sp)
    80000d5e:	7a02                	ld	s4,32(sp)
    80000d60:	6ae2                	ld	s5,24(sp)
    80000d62:	6b42                	ld	s6,16(sp)
    80000d64:	6ba2                	ld	s7,8(sp)
    80000d66:	6161                	add	sp,sp,80
    80000d68:	8082                	ret
    srcva = va0 + PGSIZE;
    80000d6a:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    80000d6e:	c8a9                	beqz	s1,80000dc0 <copyinstr+0x9e>
    va0 = PGROUNDDOWN(srcva);
    80000d70:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    80000d74:	85ca                	mv	a1,s2
    80000d76:	8552                	mv	a0,s4
    80000d78:	00000097          	auipc	ra,0x0
    80000d7c:	914080e7          	jalr	-1772(ra) # 8000068c <walkaddr>
    if(pa0 == 0)
    80000d80:	c131                	beqz	a0,80000dc4 <copyinstr+0xa2>
    n = PGSIZE - (srcva - va0);
    80000d82:	417906b3          	sub	a3,s2,s7
    80000d86:	96ce                	add	a3,a3,s3
    80000d88:	00d4f363          	bgeu	s1,a3,80000d8e <copyinstr+0x6c>
    80000d8c:	86a6                	mv	a3,s1
    char *p = (char *) (pa0 + (srcva - va0));
    80000d8e:	955e                	add	a0,a0,s7
    80000d90:	41250533          	sub	a0,a0,s2
    while(n > 0){
    80000d94:	daf9                	beqz	a3,80000d6a <copyinstr+0x48>
    80000d96:	87da                	mv	a5,s6
    80000d98:	885a                	mv	a6,s6
      if(*p == '\0'){
    80000d9a:	41650633          	sub	a2,a0,s6
    while(n > 0){
    80000d9e:	96da                	add	a3,a3,s6
    80000da0:	85be                	mv	a1,a5
      if(*p == '\0'){
    80000da2:	00f60733          	add	a4,a2,a5
    80000da6:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <end+0xffffffff7ffbd270>
    80000daa:	df59                	beqz	a4,80000d48 <copyinstr+0x26>
        *dst = *p;
    80000dac:	00e78023          	sb	a4,0(a5)
      dst++;
    80000db0:	0785                	add	a5,a5,1
    while(n > 0){
    80000db2:	fed797e3          	bne	a5,a3,80000da0 <copyinstr+0x7e>
    80000db6:	14fd                	add	s1,s1,-1
    80000db8:	94c2                	add	s1,s1,a6
      --max;
    80000dba:	8c8d                	sub	s1,s1,a1
      dst++;
    80000dbc:	8b3e                	mv	s6,a5
    80000dbe:	b775                	j	80000d6a <copyinstr+0x48>
    80000dc0:	4781                	li	a5,0
    80000dc2:	b771                	j	80000d4e <copyinstr+0x2c>
      return -1;
    80000dc4:	557d                	li	a0,-1
    80000dc6:	b779                	j	80000d54 <copyinstr+0x32>
  int got_null = 0;
    80000dc8:	4781                	li	a5,0
  if(got_null){
    80000dca:	37fd                	addw	a5,a5,-1
    80000dcc:	0007851b          	sext.w	a0,a5
}
    80000dd0:	8082                	ret

0000000080000dd2 <uvmcheckcowpage>:

// Check if a given virtual address points to a copy-on-write page
int uvmcheckcowpage(uint64 va) {
    80000dd2:	1101                	add	sp,sp,-32
    80000dd4:	ec06                	sd	ra,24(sp)
    80000dd6:	e822                	sd	s0,16(sp)
    80000dd8:	e426                	sd	s1,8(sp)
    80000dda:	1000                	add	s0,sp,32
    80000ddc:	84aa                	mv	s1,a0
    pte_t *pte;
    struct proc *p = myproc();
    80000dde:	00000097          	auipc	ra,0x0
    80000de2:	30a080e7          	jalr	778(ra) # 800010e8 <myproc>

    return (va < p->sz) // within size of memory for the process
           && ((pte = walk(p->pagetable, va, 0))!=0)
           && (*pte & PTE_V) // page table entry exists
           && (*pte & PTE_COW); // page is a cow page
    80000de6:	653c                	ld	a5,72(a0)
    80000de8:	00f4e863          	bltu	s1,a5,80000df8 <uvmcheckcowpage+0x26>
    80000dec:	4501                	li	a0,0
}
    80000dee:	60e2                	ld	ra,24(sp)
    80000df0:	6442                	ld	s0,16(sp)
    80000df2:	64a2                	ld	s1,8(sp)
    80000df4:	6105                	add	sp,sp,32
    80000df6:	8082                	ret
           && ((pte = walk(p->pagetable, va, 0))!=0)
    80000df8:	4601                	li	a2,0
    80000dfa:	85a6                	mv	a1,s1
    80000dfc:	6928                	ld	a0,80(a0)
    80000dfe:	fffff097          	auipc	ra,0xfffff
    80000e02:	7e8080e7          	jalr	2024(ra) # 800005e6 <walk>
    80000e06:	87aa                	mv	a5,a0
           && (*pte & PTE_COW); // page is a cow page
    80000e08:	4501                	li	a0,0
           && ((pte = walk(p->pagetable, va, 0))!=0)
    80000e0a:	d3f5                	beqz	a5,80000dee <uvmcheckcowpage+0x1c>
           && (*pte & PTE_COW); // page is a cow page
    80000e0c:	6388                	ld	a0,0(a5)
    80000e0e:	10157513          	and	a0,a0,257
    80000e12:	eff50513          	add	a0,a0,-257
    80000e16:	00153513          	seqz	a0,a0
    80000e1a:	bfd1                	j	80000dee <uvmcheckcowpage+0x1c>

0000000080000e1c <uvmcowcopy>:

// Copy the cow page, then map it as writable
int uvmcowcopy(uint64 va) {
    80000e1c:	7179                	add	sp,sp,-48
    80000e1e:	f406                	sd	ra,40(sp)
    80000e20:	f022                	sd	s0,32(sp)
    80000e22:	ec26                	sd	s1,24(sp)
    80000e24:	e84a                	sd	s2,16(sp)
    80000e26:	e44e                	sd	s3,8(sp)
    80000e28:	e052                	sd	s4,0(sp)
    80000e2a:	1800                	add	s0,sp,48
    80000e2c:	89aa                	mv	s3,a0
    pte_t *pte;
    struct proc *p = myproc();
    80000e2e:	00000097          	auipc	ra,0x0
    80000e32:	2ba080e7          	jalr	698(ra) # 800010e8 <myproc>
    80000e36:	892a                	mv	s2,a0

    if((pte = walk(p->pagetable, va, 0)) == 0)
    80000e38:	4601                	li	a2,0
    80000e3a:	85ce                	mv	a1,s3
    80000e3c:	6928                	ld	a0,80(a0)
    80000e3e:	fffff097          	auipc	ra,0xfffff
    80000e42:	7a8080e7          	jalr	1960(ra) # 800005e6 <walk>
    80000e46:	c135                	beqz	a0,80000eaa <uvmcowcopy+0x8e>
    80000e48:	84aa                	mv	s1,a0
        panic("uvmcowcopy: walk");

    // copy the cow page
    // (no copying will take place if reference count is already 1)
    uint64 pa = PTE2PA(*pte);
    80000e4a:	6108                	ld	a0,0(a0)
    80000e4c:	8129                	srl	a0,a0,0xa
    uint64 new = (uint64)kcopy_n_deref((void*)pa);
    80000e4e:	0532                	sll	a0,a0,0xc
    80000e50:	fffff097          	auipc	ra,0xfffff
    80000e54:	3b6080e7          	jalr	950(ra) # 80000206 <kcopy_n_deref>
    80000e58:	8a2a                	mv	s4,a0
    if(new == 0)
    80000e5a:	c925                	beqz	a0,80000eca <uvmcowcopy+0xae>
        return -1;

    // map as writable, remove the cow flag
    uint64 flags = (PTE_FLAGS(*pte) | PTE_W) & ~PTE_COW;
    80000e5c:	6084                	ld	s1,0(s1)
    80000e5e:	2fb4f493          	and	s1,s1,763
    80000e62:	0044e493          	or	s1,s1,4
    uvmunmap(p->pagetable, PGROUNDDOWN(va), 1, 0);
    80000e66:	4681                	li	a3,0
    80000e68:	4605                	li	a2,1
    80000e6a:	75fd                	lui	a1,0xfffff
    80000e6c:	00b9f5b3          	and	a1,s3,a1
    80000e70:	05093503          	ld	a0,80(s2) # 1050 <_entry-0x7fffefb0>
    80000e74:	00000097          	auipc	ra,0x0
    80000e78:	a20080e7          	jalr	-1504(ra) # 80000894 <uvmunmap>
    if(mappages(p->pagetable, va, 1, new, flags) == -1) {
    80000e7c:	8726                	mv	a4,s1
    80000e7e:	86d2                	mv	a3,s4
    80000e80:	4605                	li	a2,1
    80000e82:	85ce                	mv	a1,s3
    80000e84:	05093503          	ld	a0,80(s2)
    80000e88:	00000097          	auipc	ra,0x0
    80000e8c:	846080e7          	jalr	-1978(ra) # 800006ce <mappages>
    80000e90:	872a                	mv	a4,a0
    80000e92:	57fd                	li	a5,-1
        panic("uvmcowcopy: mappages");
    }
    return 0;
    80000e94:	4501                	li	a0,0
    if(mappages(p->pagetable, va, 1, new, flags) == -1) {
    80000e96:	02f70263          	beq	a4,a5,80000eba <uvmcowcopy+0x9e>
    80000e9a:	70a2                	ld	ra,40(sp)
    80000e9c:	7402                	ld	s0,32(sp)
    80000e9e:	64e2                	ld	s1,24(sp)
    80000ea0:	6942                	ld	s2,16(sp)
    80000ea2:	69a2                	ld	s3,8(sp)
    80000ea4:	6a02                	ld	s4,0(sp)
    80000ea6:	6145                	add	sp,sp,48
    80000ea8:	8082                	ret
        panic("uvmcowcopy: walk");
    80000eaa:	00007517          	auipc	a0,0x7
    80000eae:	2b650513          	add	a0,a0,694 # 80008160 <etext+0x160>
    80000eb2:	00005097          	auipc	ra,0x5
    80000eb6:	f44080e7          	jalr	-188(ra) # 80005df6 <panic>
        panic("uvmcowcopy: mappages");
    80000eba:	00007517          	auipc	a0,0x7
    80000ebe:	2be50513          	add	a0,a0,702 # 80008178 <etext+0x178>
    80000ec2:	00005097          	auipc	ra,0x5
    80000ec6:	f34080e7          	jalr	-204(ra) # 80005df6 <panic>
        return -1;
    80000eca:	557d                	li	a0,-1
    80000ecc:	b7f9                	j	80000e9a <uvmcowcopy+0x7e>

0000000080000ece <copyout>:
  while(len > 0){
    80000ece:	c2d9                	beqz	a3,80000f54 <copyout+0x86>
{
    80000ed0:	715d                	add	sp,sp,-80
    80000ed2:	e486                	sd	ra,72(sp)
    80000ed4:	e0a2                	sd	s0,64(sp)
    80000ed6:	fc26                	sd	s1,56(sp)
    80000ed8:	f84a                	sd	s2,48(sp)
    80000eda:	f44e                	sd	s3,40(sp)
    80000edc:	f052                	sd	s4,32(sp)
    80000ede:	ec56                	sd	s5,24(sp)
    80000ee0:	e85a                	sd	s6,16(sp)
    80000ee2:	e45e                	sd	s7,8(sp)
    80000ee4:	e062                	sd	s8,0(sp)
    80000ee6:	0880                	add	s0,sp,80
    80000ee8:	8baa                	mv	s7,a0
    80000eea:	84ae                	mv	s1,a1
    80000eec:	8ab2                	mv	s5,a2
    80000eee:	8a36                	mv	s4,a3
    va0 = PGROUNDDOWN(dstva);
    80000ef0:	7c7d                	lui	s8,0xfffff
    n = PGSIZE - (dstva - va0);
    80000ef2:	6b05                	lui	s6,0x1
    80000ef4:	a805                	j	80000f24 <copyout+0x56>
          uvmcowcopy(dstva);
    80000ef6:	8526                	mv	a0,s1
    80000ef8:	00000097          	auipc	ra,0x0
    80000efc:	f24080e7          	jalr	-220(ra) # 80000e1c <uvmcowcopy>
    80000f00:	a805                	j	80000f30 <copyout+0x62>
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000f02:	413484b3          	sub	s1,s1,s3
    80000f06:	0009061b          	sext.w	a2,s2
    80000f0a:	85d6                	mv	a1,s5
    80000f0c:	9526                	add	a0,a0,s1
    80000f0e:	fffff097          	auipc	ra,0xfffff
    80000f12:	452080e7          	jalr	1106(ra) # 80000360 <memmove>
    len -= n;
    80000f16:	412a0a33          	sub	s4,s4,s2
    src += n;
    80000f1a:	9aca                	add	s5,s5,s2
    dstva = va0 + PGSIZE;
    80000f1c:	016984b3          	add	s1,s3,s6
  while(len > 0){
    80000f20:	020a0863          	beqz	s4,80000f50 <copyout+0x82>
      if (uvmcheckcowpage(dstva)) {
    80000f24:	8526                	mv	a0,s1
    80000f26:	00000097          	auipc	ra,0x0
    80000f2a:	eac080e7          	jalr	-340(ra) # 80000dd2 <uvmcheckcowpage>
    80000f2e:	f561                	bnez	a0,80000ef6 <copyout+0x28>
    va0 = PGROUNDDOWN(dstva);
    80000f30:	0184f9b3          	and	s3,s1,s8
    pa0 = walkaddr(pagetable, va0);
    80000f34:	85ce                	mv	a1,s3
    80000f36:	855e                	mv	a0,s7
    80000f38:	fffff097          	auipc	ra,0xfffff
    80000f3c:	754080e7          	jalr	1876(ra) # 8000068c <walkaddr>
    if(pa0 == 0)
    80000f40:	cd01                	beqz	a0,80000f58 <copyout+0x8a>
    n = PGSIZE - (dstva - va0);
    80000f42:	40998933          	sub	s2,s3,s1
    80000f46:	995a                	add	s2,s2,s6
    80000f48:	fb2a7de3          	bgeu	s4,s2,80000f02 <copyout+0x34>
    80000f4c:	8952                	mv	s2,s4
    80000f4e:	bf55                	j	80000f02 <copyout+0x34>
  return 0;
    80000f50:	4501                	li	a0,0
    80000f52:	a021                	j	80000f5a <copyout+0x8c>
    80000f54:	4501                	li	a0,0
}
    80000f56:	8082                	ret
      return -1;
    80000f58:	557d                	li	a0,-1
}
    80000f5a:	60a6                	ld	ra,72(sp)
    80000f5c:	6406                	ld	s0,64(sp)
    80000f5e:	74e2                	ld	s1,56(sp)
    80000f60:	7942                	ld	s2,48(sp)
    80000f62:	79a2                	ld	s3,40(sp)
    80000f64:	7a02                	ld	s4,32(sp)
    80000f66:	6ae2                	ld	s5,24(sp)
    80000f68:	6b42                	ld	s6,16(sp)
    80000f6a:	6ba2                	ld	s7,8(sp)
    80000f6c:	6c02                	ld	s8,0(sp)
    80000f6e:	6161                	add	sp,sp,80
    80000f70:	8082                	ret

0000000080000f72 <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    80000f72:	7139                	add	sp,sp,-64
    80000f74:	fc06                	sd	ra,56(sp)
    80000f76:	f822                	sd	s0,48(sp)
    80000f78:	f426                	sd	s1,40(sp)
    80000f7a:	f04a                	sd	s2,32(sp)
    80000f7c:	ec4e                	sd	s3,24(sp)
    80000f7e:	e852                	sd	s4,16(sp)
    80000f80:	e456                	sd	s5,8(sp)
    80000f82:	e05a                	sd	s6,0(sp)
    80000f84:	0080                	add	s0,sp,64
    80000f86:	89aa                	mv	s3,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80000f88:	00028497          	auipc	s1,0x28
    80000f8c:	de048493          	add	s1,s1,-544 # 80028d68 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000f90:	8b26                	mv	s6,s1
    80000f92:	00007a97          	auipc	s5,0x7
    80000f96:	06ea8a93          	add	s5,s5,110 # 80008000 <etext>
    80000f9a:	04000937          	lui	s2,0x4000
    80000f9e:	197d                	add	s2,s2,-1 # 3ffffff <_entry-0x7c000001>
    80000fa0:	0932                	sll	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000fa2:	0002da17          	auipc	s4,0x2d
    80000fa6:	7c6a0a13          	add	s4,s4,1990 # 8002e768 <tickslock>
    char *pa = kalloc();
    80000faa:	fffff097          	auipc	ra,0xfffff
    80000fae:	1da080e7          	jalr	474(ra) # 80000184 <kalloc>
    80000fb2:	862a                	mv	a2,a0
    if(pa == 0)
    80000fb4:	c131                	beqz	a0,80000ff8 <proc_mapstacks+0x86>
    uint64 va = KSTACK((int) (p - proc));
    80000fb6:	416485b3          	sub	a1,s1,s6
    80000fba:	858d                	sra	a1,a1,0x3
    80000fbc:	000ab783          	ld	a5,0(s5)
    80000fc0:	02f585b3          	mul	a1,a1,a5
    80000fc4:	2585                	addw	a1,a1,1 # fffffffffffff001 <end+0xffffffff7ffbd271>
    80000fc6:	00d5959b          	sllw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000fca:	4719                	li	a4,6
    80000fcc:	6685                	lui	a3,0x1
    80000fce:	40b905b3          	sub	a1,s2,a1
    80000fd2:	854e                	mv	a0,s3
    80000fd4:	fffff097          	auipc	ra,0xfffff
    80000fd8:	79a080e7          	jalr	1946(ra) # 8000076e <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000fdc:	16848493          	add	s1,s1,360
    80000fe0:	fd4495e3          	bne	s1,s4,80000faa <proc_mapstacks+0x38>
  }
}
    80000fe4:	70e2                	ld	ra,56(sp)
    80000fe6:	7442                	ld	s0,48(sp)
    80000fe8:	74a2                	ld	s1,40(sp)
    80000fea:	7902                	ld	s2,32(sp)
    80000fec:	69e2                	ld	s3,24(sp)
    80000fee:	6a42                	ld	s4,16(sp)
    80000ff0:	6aa2                	ld	s5,8(sp)
    80000ff2:	6b02                	ld	s6,0(sp)
    80000ff4:	6121                	add	sp,sp,64
    80000ff6:	8082                	ret
      panic("kalloc");
    80000ff8:	00007517          	auipc	a0,0x7
    80000ffc:	19850513          	add	a0,a0,408 # 80008190 <etext+0x190>
    80001000:	00005097          	auipc	ra,0x5
    80001004:	df6080e7          	jalr	-522(ra) # 80005df6 <panic>

0000000080001008 <procinit>:

// initialize the proc table.
void
procinit(void)
{
    80001008:	7139                	add	sp,sp,-64
    8000100a:	fc06                	sd	ra,56(sp)
    8000100c:	f822                	sd	s0,48(sp)
    8000100e:	f426                	sd	s1,40(sp)
    80001010:	f04a                	sd	s2,32(sp)
    80001012:	ec4e                	sd	s3,24(sp)
    80001014:	e852                	sd	s4,16(sp)
    80001016:	e456                	sd	s5,8(sp)
    80001018:	e05a                	sd	s6,0(sp)
    8000101a:	0080                	add	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    8000101c:	00007597          	auipc	a1,0x7
    80001020:	17c58593          	add	a1,a1,380 # 80008198 <etext+0x198>
    80001024:	00028517          	auipc	a0,0x28
    80001028:	91450513          	add	a0,a0,-1772 # 80028938 <pid_lock>
    8000102c:	00005097          	auipc	ra,0x5
    80001030:	272080e7          	jalr	626(ra) # 8000629e <initlock>
  initlock(&wait_lock, "wait_lock");
    80001034:	00007597          	auipc	a1,0x7
    80001038:	16c58593          	add	a1,a1,364 # 800081a0 <etext+0x1a0>
    8000103c:	00028517          	auipc	a0,0x28
    80001040:	91450513          	add	a0,a0,-1772 # 80028950 <wait_lock>
    80001044:	00005097          	auipc	ra,0x5
    80001048:	25a080e7          	jalr	602(ra) # 8000629e <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    8000104c:	00028497          	auipc	s1,0x28
    80001050:	d1c48493          	add	s1,s1,-740 # 80028d68 <proc>
      initlock(&p->lock, "proc");
    80001054:	00007b17          	auipc	s6,0x7
    80001058:	15cb0b13          	add	s6,s6,348 # 800081b0 <etext+0x1b0>
      p->state = UNUSED;
      p->kstack = KSTACK((int) (p - proc));
    8000105c:	8aa6                	mv	s5,s1
    8000105e:	00007a17          	auipc	s4,0x7
    80001062:	fa2a0a13          	add	s4,s4,-94 # 80008000 <etext>
    80001066:	04000937          	lui	s2,0x4000
    8000106a:	197d                	add	s2,s2,-1 # 3ffffff <_entry-0x7c000001>
    8000106c:	0932                	sll	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    8000106e:	0002d997          	auipc	s3,0x2d
    80001072:	6fa98993          	add	s3,s3,1786 # 8002e768 <tickslock>
      initlock(&p->lock, "proc");
    80001076:	85da                	mv	a1,s6
    80001078:	8526                	mv	a0,s1
    8000107a:	00005097          	auipc	ra,0x5
    8000107e:	224080e7          	jalr	548(ra) # 8000629e <initlock>
      p->state = UNUSED;
    80001082:	0004ac23          	sw	zero,24(s1)
      p->kstack = KSTACK((int) (p - proc));
    80001086:	415487b3          	sub	a5,s1,s5
    8000108a:	878d                	sra	a5,a5,0x3
    8000108c:	000a3703          	ld	a4,0(s4)
    80001090:	02e787b3          	mul	a5,a5,a4
    80001094:	2785                	addw	a5,a5,1
    80001096:	00d7979b          	sllw	a5,a5,0xd
    8000109a:	40f907b3          	sub	a5,s2,a5
    8000109e:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    800010a0:	16848493          	add	s1,s1,360
    800010a4:	fd3499e3          	bne	s1,s3,80001076 <procinit+0x6e>
  }
}
    800010a8:	70e2                	ld	ra,56(sp)
    800010aa:	7442                	ld	s0,48(sp)
    800010ac:	74a2                	ld	s1,40(sp)
    800010ae:	7902                	ld	s2,32(sp)
    800010b0:	69e2                	ld	s3,24(sp)
    800010b2:	6a42                	ld	s4,16(sp)
    800010b4:	6aa2                	ld	s5,8(sp)
    800010b6:	6b02                	ld	s6,0(sp)
    800010b8:	6121                	add	sp,sp,64
    800010ba:	8082                	ret

00000000800010bc <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    800010bc:	1141                	add	sp,sp,-16
    800010be:	e422                	sd	s0,8(sp)
    800010c0:	0800                	add	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    800010c2:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    800010c4:	2501                	sext.w	a0,a0
    800010c6:	6422                	ld	s0,8(sp)
    800010c8:	0141                	add	sp,sp,16
    800010ca:	8082                	ret

00000000800010cc <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    800010cc:	1141                	add	sp,sp,-16
    800010ce:	e422                	sd	s0,8(sp)
    800010d0:	0800                	add	s0,sp,16
    800010d2:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    800010d4:	2781                	sext.w	a5,a5
    800010d6:	079e                	sll	a5,a5,0x7
  return c;
}
    800010d8:	00028517          	auipc	a0,0x28
    800010dc:	89050513          	add	a0,a0,-1904 # 80028968 <cpus>
    800010e0:	953e                	add	a0,a0,a5
    800010e2:	6422                	ld	s0,8(sp)
    800010e4:	0141                	add	sp,sp,16
    800010e6:	8082                	ret

00000000800010e8 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    800010e8:	1101                	add	sp,sp,-32
    800010ea:	ec06                	sd	ra,24(sp)
    800010ec:	e822                	sd	s0,16(sp)
    800010ee:	e426                	sd	s1,8(sp)
    800010f0:	1000                	add	s0,sp,32
  push_off();
    800010f2:	00005097          	auipc	ra,0x5
    800010f6:	1f0080e7          	jalr	496(ra) # 800062e2 <push_off>
    800010fa:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    800010fc:	2781                	sext.w	a5,a5
    800010fe:	079e                	sll	a5,a5,0x7
    80001100:	00028717          	auipc	a4,0x28
    80001104:	83870713          	add	a4,a4,-1992 # 80028938 <pid_lock>
    80001108:	97ba                	add	a5,a5,a4
    8000110a:	7b84                	ld	s1,48(a5)
  pop_off();
    8000110c:	00005097          	auipc	ra,0x5
    80001110:	276080e7          	jalr	630(ra) # 80006382 <pop_off>
  return p;
}
    80001114:	8526                	mv	a0,s1
    80001116:	60e2                	ld	ra,24(sp)
    80001118:	6442                	ld	s0,16(sp)
    8000111a:	64a2                	ld	s1,8(sp)
    8000111c:	6105                	add	sp,sp,32
    8000111e:	8082                	ret

0000000080001120 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80001120:	1141                	add	sp,sp,-16
    80001122:	e406                	sd	ra,8(sp)
    80001124:	e022                	sd	s0,0(sp)
    80001126:	0800                	add	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80001128:	00000097          	auipc	ra,0x0
    8000112c:	fc0080e7          	jalr	-64(ra) # 800010e8 <myproc>
    80001130:	00005097          	auipc	ra,0x5
    80001134:	2b2080e7          	jalr	690(ra) # 800063e2 <release>

  if (first) {
    80001138:	00007797          	auipc	a5,0x7
    8000113c:	7487a783          	lw	a5,1864(a5) # 80008880 <first.1>
    80001140:	eb89                	bnez	a5,80001152 <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    80001142:	00001097          	auipc	ra,0x1
    80001146:	c5c080e7          	jalr	-932(ra) # 80001d9e <usertrapret>
}
    8000114a:	60a2                	ld	ra,8(sp)
    8000114c:	6402                	ld	s0,0(sp)
    8000114e:	0141                	add	sp,sp,16
    80001150:	8082                	ret
    first = 0;
    80001152:	00007797          	auipc	a5,0x7
    80001156:	7207a723          	sw	zero,1838(a5) # 80008880 <first.1>
    fsinit(ROOTDEV);
    8000115a:	4505                	li	a0,1
    8000115c:	00002097          	auipc	ra,0x2
    80001160:	9c8080e7          	jalr	-1592(ra) # 80002b24 <fsinit>
    80001164:	bff9                	j	80001142 <forkret+0x22>

0000000080001166 <allocpid>:
{
    80001166:	1101                	add	sp,sp,-32
    80001168:	ec06                	sd	ra,24(sp)
    8000116a:	e822                	sd	s0,16(sp)
    8000116c:	e426                	sd	s1,8(sp)
    8000116e:	e04a                	sd	s2,0(sp)
    80001170:	1000                	add	s0,sp,32
  acquire(&pid_lock);
    80001172:	00027917          	auipc	s2,0x27
    80001176:	7c690913          	add	s2,s2,1990 # 80028938 <pid_lock>
    8000117a:	854a                	mv	a0,s2
    8000117c:	00005097          	auipc	ra,0x5
    80001180:	1b2080e7          	jalr	434(ra) # 8000632e <acquire>
  pid = nextpid;
    80001184:	00007797          	auipc	a5,0x7
    80001188:	70078793          	add	a5,a5,1792 # 80008884 <nextpid>
    8000118c:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    8000118e:	0014871b          	addw	a4,s1,1
    80001192:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80001194:	854a                	mv	a0,s2
    80001196:	00005097          	auipc	ra,0x5
    8000119a:	24c080e7          	jalr	588(ra) # 800063e2 <release>
}
    8000119e:	8526                	mv	a0,s1
    800011a0:	60e2                	ld	ra,24(sp)
    800011a2:	6442                	ld	s0,16(sp)
    800011a4:	64a2                	ld	s1,8(sp)
    800011a6:	6902                	ld	s2,0(sp)
    800011a8:	6105                	add	sp,sp,32
    800011aa:	8082                	ret

00000000800011ac <proc_pagetable>:
{
    800011ac:	1101                	add	sp,sp,-32
    800011ae:	ec06                	sd	ra,24(sp)
    800011b0:	e822                	sd	s0,16(sp)
    800011b2:	e426                	sd	s1,8(sp)
    800011b4:	e04a                	sd	s2,0(sp)
    800011b6:	1000                	add	s0,sp,32
    800011b8:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    800011ba:	fffff097          	auipc	ra,0xfffff
    800011be:	79e080e7          	jalr	1950(ra) # 80000958 <uvmcreate>
    800011c2:	84aa                	mv	s1,a0
  if(pagetable == 0)
    800011c4:	c121                	beqz	a0,80001204 <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    800011c6:	4729                	li	a4,10
    800011c8:	00006697          	auipc	a3,0x6
    800011cc:	e3868693          	add	a3,a3,-456 # 80007000 <_trampoline>
    800011d0:	6605                	lui	a2,0x1
    800011d2:	040005b7          	lui	a1,0x4000
    800011d6:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    800011d8:	05b2                	sll	a1,a1,0xc
    800011da:	fffff097          	auipc	ra,0xfffff
    800011de:	4f4080e7          	jalr	1268(ra) # 800006ce <mappages>
    800011e2:	02054863          	bltz	a0,80001212 <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    800011e6:	4719                	li	a4,6
    800011e8:	05893683          	ld	a3,88(s2)
    800011ec:	6605                	lui	a2,0x1
    800011ee:	020005b7          	lui	a1,0x2000
    800011f2:	15fd                	add	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    800011f4:	05b6                	sll	a1,a1,0xd
    800011f6:	8526                	mv	a0,s1
    800011f8:	fffff097          	auipc	ra,0xfffff
    800011fc:	4d6080e7          	jalr	1238(ra) # 800006ce <mappages>
    80001200:	02054163          	bltz	a0,80001222 <proc_pagetable+0x76>
}
    80001204:	8526                	mv	a0,s1
    80001206:	60e2                	ld	ra,24(sp)
    80001208:	6442                	ld	s0,16(sp)
    8000120a:	64a2                	ld	s1,8(sp)
    8000120c:	6902                	ld	s2,0(sp)
    8000120e:	6105                	add	sp,sp,32
    80001210:	8082                	ret
    uvmfree(pagetable, 0);
    80001212:	4581                	li	a1,0
    80001214:	8526                	mv	a0,s1
    80001216:	00000097          	auipc	ra,0x0
    8000121a:	948080e7          	jalr	-1720(ra) # 80000b5e <uvmfree>
    return 0;
    8000121e:	4481                	li	s1,0
    80001220:	b7d5                	j	80001204 <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001222:	4681                	li	a3,0
    80001224:	4605                	li	a2,1
    80001226:	040005b7          	lui	a1,0x4000
    8000122a:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    8000122c:	05b2                	sll	a1,a1,0xc
    8000122e:	8526                	mv	a0,s1
    80001230:	fffff097          	auipc	ra,0xfffff
    80001234:	664080e7          	jalr	1636(ra) # 80000894 <uvmunmap>
    uvmfree(pagetable, 0);
    80001238:	4581                	li	a1,0
    8000123a:	8526                	mv	a0,s1
    8000123c:	00000097          	auipc	ra,0x0
    80001240:	922080e7          	jalr	-1758(ra) # 80000b5e <uvmfree>
    return 0;
    80001244:	4481                	li	s1,0
    80001246:	bf7d                	j	80001204 <proc_pagetable+0x58>

0000000080001248 <proc_freepagetable>:
{
    80001248:	1101                	add	sp,sp,-32
    8000124a:	ec06                	sd	ra,24(sp)
    8000124c:	e822                	sd	s0,16(sp)
    8000124e:	e426                	sd	s1,8(sp)
    80001250:	e04a                	sd	s2,0(sp)
    80001252:	1000                	add	s0,sp,32
    80001254:	84aa                	mv	s1,a0
    80001256:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001258:	4681                	li	a3,0
    8000125a:	4605                	li	a2,1
    8000125c:	040005b7          	lui	a1,0x4000
    80001260:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001262:	05b2                	sll	a1,a1,0xc
    80001264:	fffff097          	auipc	ra,0xfffff
    80001268:	630080e7          	jalr	1584(ra) # 80000894 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    8000126c:	4681                	li	a3,0
    8000126e:	4605                	li	a2,1
    80001270:	020005b7          	lui	a1,0x2000
    80001274:	15fd                	add	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80001276:	05b6                	sll	a1,a1,0xd
    80001278:	8526                	mv	a0,s1
    8000127a:	fffff097          	auipc	ra,0xfffff
    8000127e:	61a080e7          	jalr	1562(ra) # 80000894 <uvmunmap>
  uvmfree(pagetable, sz);
    80001282:	85ca                	mv	a1,s2
    80001284:	8526                	mv	a0,s1
    80001286:	00000097          	auipc	ra,0x0
    8000128a:	8d8080e7          	jalr	-1832(ra) # 80000b5e <uvmfree>
}
    8000128e:	60e2                	ld	ra,24(sp)
    80001290:	6442                	ld	s0,16(sp)
    80001292:	64a2                	ld	s1,8(sp)
    80001294:	6902                	ld	s2,0(sp)
    80001296:	6105                	add	sp,sp,32
    80001298:	8082                	ret

000000008000129a <freeproc>:
{
    8000129a:	1101                	add	sp,sp,-32
    8000129c:	ec06                	sd	ra,24(sp)
    8000129e:	e822                	sd	s0,16(sp)
    800012a0:	e426                	sd	s1,8(sp)
    800012a2:	1000                	add	s0,sp,32
    800012a4:	84aa                	mv	s1,a0
  if(p->trapframe)
    800012a6:	6d28                	ld	a0,88(a0)
    800012a8:	c509                	beqz	a0,800012b2 <freeproc+0x18>
    kfree((void*)p->trapframe);
    800012aa:	fffff097          	auipc	ra,0xfffff
    800012ae:	d72080e7          	jalr	-654(ra) # 8000001c <kfree>
  p->trapframe = 0;
    800012b2:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    800012b6:	68a8                	ld	a0,80(s1)
    800012b8:	c511                	beqz	a0,800012c4 <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    800012ba:	64ac                	ld	a1,72(s1)
    800012bc:	00000097          	auipc	ra,0x0
    800012c0:	f8c080e7          	jalr	-116(ra) # 80001248 <proc_freepagetable>
  p->pagetable = 0;
    800012c4:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    800012c8:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    800012cc:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    800012d0:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    800012d4:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    800012d8:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    800012dc:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    800012e0:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    800012e4:	0004ac23          	sw	zero,24(s1)
}
    800012e8:	60e2                	ld	ra,24(sp)
    800012ea:	6442                	ld	s0,16(sp)
    800012ec:	64a2                	ld	s1,8(sp)
    800012ee:	6105                	add	sp,sp,32
    800012f0:	8082                	ret

00000000800012f2 <allocproc>:
{
    800012f2:	1101                	add	sp,sp,-32
    800012f4:	ec06                	sd	ra,24(sp)
    800012f6:	e822                	sd	s0,16(sp)
    800012f8:	e426                	sd	s1,8(sp)
    800012fa:	e04a                	sd	s2,0(sp)
    800012fc:	1000                	add	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    800012fe:	00028497          	auipc	s1,0x28
    80001302:	a6a48493          	add	s1,s1,-1430 # 80028d68 <proc>
    80001306:	0002d917          	auipc	s2,0x2d
    8000130a:	46290913          	add	s2,s2,1122 # 8002e768 <tickslock>
    acquire(&p->lock);
    8000130e:	8526                	mv	a0,s1
    80001310:	00005097          	auipc	ra,0x5
    80001314:	01e080e7          	jalr	30(ra) # 8000632e <acquire>
    if(p->state == UNUSED) {
    80001318:	4c9c                	lw	a5,24(s1)
    8000131a:	cf81                	beqz	a5,80001332 <allocproc+0x40>
      release(&p->lock);
    8000131c:	8526                	mv	a0,s1
    8000131e:	00005097          	auipc	ra,0x5
    80001322:	0c4080e7          	jalr	196(ra) # 800063e2 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001326:	16848493          	add	s1,s1,360
    8000132a:	ff2492e3          	bne	s1,s2,8000130e <allocproc+0x1c>
  return 0;
    8000132e:	4481                	li	s1,0
    80001330:	a889                	j	80001382 <allocproc+0x90>
  p->pid = allocpid();
    80001332:	00000097          	auipc	ra,0x0
    80001336:	e34080e7          	jalr	-460(ra) # 80001166 <allocpid>
    8000133a:	d888                	sw	a0,48(s1)
  p->state = USED;
    8000133c:	4785                	li	a5,1
    8000133e:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80001340:	fffff097          	auipc	ra,0xfffff
    80001344:	e44080e7          	jalr	-444(ra) # 80000184 <kalloc>
    80001348:	892a                	mv	s2,a0
    8000134a:	eca8                	sd	a0,88(s1)
    8000134c:	c131                	beqz	a0,80001390 <allocproc+0x9e>
  p->pagetable = proc_pagetable(p);
    8000134e:	8526                	mv	a0,s1
    80001350:	00000097          	auipc	ra,0x0
    80001354:	e5c080e7          	jalr	-420(ra) # 800011ac <proc_pagetable>
    80001358:	892a                	mv	s2,a0
    8000135a:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    8000135c:	c531                	beqz	a0,800013a8 <allocproc+0xb6>
  memset(&p->context, 0, sizeof(p->context));
    8000135e:	07000613          	li	a2,112
    80001362:	4581                	li	a1,0
    80001364:	06048513          	add	a0,s1,96
    80001368:	fffff097          	auipc	ra,0xfffff
    8000136c:	f9c080e7          	jalr	-100(ra) # 80000304 <memset>
  p->context.ra = (uint64)forkret;
    80001370:	00000797          	auipc	a5,0x0
    80001374:	db078793          	add	a5,a5,-592 # 80001120 <forkret>
    80001378:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    8000137a:	60bc                	ld	a5,64(s1)
    8000137c:	6705                	lui	a4,0x1
    8000137e:	97ba                	add	a5,a5,a4
    80001380:	f4bc                	sd	a5,104(s1)
}
    80001382:	8526                	mv	a0,s1
    80001384:	60e2                	ld	ra,24(sp)
    80001386:	6442                	ld	s0,16(sp)
    80001388:	64a2                	ld	s1,8(sp)
    8000138a:	6902                	ld	s2,0(sp)
    8000138c:	6105                	add	sp,sp,32
    8000138e:	8082                	ret
    freeproc(p);
    80001390:	8526                	mv	a0,s1
    80001392:	00000097          	auipc	ra,0x0
    80001396:	f08080e7          	jalr	-248(ra) # 8000129a <freeproc>
    release(&p->lock);
    8000139a:	8526                	mv	a0,s1
    8000139c:	00005097          	auipc	ra,0x5
    800013a0:	046080e7          	jalr	70(ra) # 800063e2 <release>
    return 0;
    800013a4:	84ca                	mv	s1,s2
    800013a6:	bff1                	j	80001382 <allocproc+0x90>
    freeproc(p);
    800013a8:	8526                	mv	a0,s1
    800013aa:	00000097          	auipc	ra,0x0
    800013ae:	ef0080e7          	jalr	-272(ra) # 8000129a <freeproc>
    release(&p->lock);
    800013b2:	8526                	mv	a0,s1
    800013b4:	00005097          	auipc	ra,0x5
    800013b8:	02e080e7          	jalr	46(ra) # 800063e2 <release>
    return 0;
    800013bc:	84ca                	mv	s1,s2
    800013be:	b7d1                	j	80001382 <allocproc+0x90>

00000000800013c0 <userinit>:
{
    800013c0:	1101                	add	sp,sp,-32
    800013c2:	ec06                	sd	ra,24(sp)
    800013c4:	e822                	sd	s0,16(sp)
    800013c6:	e426                	sd	s1,8(sp)
    800013c8:	1000                	add	s0,sp,32
  p = allocproc();
    800013ca:	00000097          	auipc	ra,0x0
    800013ce:	f28080e7          	jalr	-216(ra) # 800012f2 <allocproc>
    800013d2:	84aa                	mv	s1,a0
  initproc = p;
    800013d4:	00007797          	auipc	a5,0x7
    800013d8:	50a7b623          	sd	a0,1292(a5) # 800088e0 <initproc>
  uvmfirst(p->pagetable, initcode, sizeof(initcode));
    800013dc:	03400613          	li	a2,52
    800013e0:	00007597          	auipc	a1,0x7
    800013e4:	4b058593          	add	a1,a1,1200 # 80008890 <initcode>
    800013e8:	6928                	ld	a0,80(a0)
    800013ea:	fffff097          	auipc	ra,0xfffff
    800013ee:	59c080e7          	jalr	1436(ra) # 80000986 <uvmfirst>
  p->sz = PGSIZE;
    800013f2:	6785                	lui	a5,0x1
    800013f4:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    800013f6:	6cb8                	ld	a4,88(s1)
    800013f8:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    800013fc:	6cb8                	ld	a4,88(s1)
    800013fe:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001400:	4641                	li	a2,16
    80001402:	00007597          	auipc	a1,0x7
    80001406:	db658593          	add	a1,a1,-586 # 800081b8 <etext+0x1b8>
    8000140a:	15848513          	add	a0,s1,344
    8000140e:	fffff097          	auipc	ra,0xfffff
    80001412:	03e080e7          	jalr	62(ra) # 8000044c <safestrcpy>
  p->cwd = namei("/");
    80001416:	00007517          	auipc	a0,0x7
    8000141a:	db250513          	add	a0,a0,-590 # 800081c8 <etext+0x1c8>
    8000141e:	00002097          	auipc	ra,0x2
    80001422:	124080e7          	jalr	292(ra) # 80003542 <namei>
    80001426:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    8000142a:	478d                	li	a5,3
    8000142c:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    8000142e:	8526                	mv	a0,s1
    80001430:	00005097          	auipc	ra,0x5
    80001434:	fb2080e7          	jalr	-78(ra) # 800063e2 <release>
}
    80001438:	60e2                	ld	ra,24(sp)
    8000143a:	6442                	ld	s0,16(sp)
    8000143c:	64a2                	ld	s1,8(sp)
    8000143e:	6105                	add	sp,sp,32
    80001440:	8082                	ret

0000000080001442 <growproc>:
{
    80001442:	1101                	add	sp,sp,-32
    80001444:	ec06                	sd	ra,24(sp)
    80001446:	e822                	sd	s0,16(sp)
    80001448:	e426                	sd	s1,8(sp)
    8000144a:	e04a                	sd	s2,0(sp)
    8000144c:	1000                	add	s0,sp,32
    8000144e:	892a                	mv	s2,a0
  struct proc *p = myproc();
    80001450:	00000097          	auipc	ra,0x0
    80001454:	c98080e7          	jalr	-872(ra) # 800010e8 <myproc>
    80001458:	84aa                	mv	s1,a0
  sz = p->sz;
    8000145a:	652c                	ld	a1,72(a0)
  if(n > 0){
    8000145c:	01204c63          	bgtz	s2,80001474 <growproc+0x32>
  } else if(n < 0){
    80001460:	02094663          	bltz	s2,8000148c <growproc+0x4a>
  p->sz = sz;
    80001464:	e4ac                	sd	a1,72(s1)
  return 0;
    80001466:	4501                	li	a0,0
}
    80001468:	60e2                	ld	ra,24(sp)
    8000146a:	6442                	ld	s0,16(sp)
    8000146c:	64a2                	ld	s1,8(sp)
    8000146e:	6902                	ld	s2,0(sp)
    80001470:	6105                	add	sp,sp,32
    80001472:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    80001474:	4691                	li	a3,4
    80001476:	00b90633          	add	a2,s2,a1
    8000147a:	6928                	ld	a0,80(a0)
    8000147c:	fffff097          	auipc	ra,0xfffff
    80001480:	5c4080e7          	jalr	1476(ra) # 80000a40 <uvmalloc>
    80001484:	85aa                	mv	a1,a0
    80001486:	fd79                	bnez	a0,80001464 <growproc+0x22>
      return -1;
    80001488:	557d                	li	a0,-1
    8000148a:	bff9                	j	80001468 <growproc+0x26>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    8000148c:	00b90633          	add	a2,s2,a1
    80001490:	6928                	ld	a0,80(a0)
    80001492:	fffff097          	auipc	ra,0xfffff
    80001496:	566080e7          	jalr	1382(ra) # 800009f8 <uvmdealloc>
    8000149a:	85aa                	mv	a1,a0
    8000149c:	b7e1                	j	80001464 <growproc+0x22>

000000008000149e <fork>:
{
    8000149e:	7139                	add	sp,sp,-64
    800014a0:	fc06                	sd	ra,56(sp)
    800014a2:	f822                	sd	s0,48(sp)
    800014a4:	f426                	sd	s1,40(sp)
    800014a6:	f04a                	sd	s2,32(sp)
    800014a8:	ec4e                	sd	s3,24(sp)
    800014aa:	e852                	sd	s4,16(sp)
    800014ac:	e456                	sd	s5,8(sp)
    800014ae:	0080                	add	s0,sp,64
  struct proc *p = myproc();
    800014b0:	00000097          	auipc	ra,0x0
    800014b4:	c38080e7          	jalr	-968(ra) # 800010e8 <myproc>
    800014b8:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    800014ba:	00000097          	auipc	ra,0x0
    800014be:	e38080e7          	jalr	-456(ra) # 800012f2 <allocproc>
    800014c2:	10050c63          	beqz	a0,800015da <fork+0x13c>
    800014c6:	8a2a                	mv	s4,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    800014c8:	048ab603          	ld	a2,72(s5)
    800014cc:	692c                	ld	a1,80(a0)
    800014ce:	050ab503          	ld	a0,80(s5)
    800014d2:	fffff097          	auipc	ra,0xfffff
    800014d6:	6c6080e7          	jalr	1734(ra) # 80000b98 <uvmcopy>
    800014da:	04054863          	bltz	a0,8000152a <fork+0x8c>
  np->sz = p->sz;
    800014de:	048ab783          	ld	a5,72(s5)
    800014e2:	04fa3423          	sd	a5,72(s4)
  *(np->trapframe) = *(p->trapframe);
    800014e6:	058ab683          	ld	a3,88(s5)
    800014ea:	87b6                	mv	a5,a3
    800014ec:	058a3703          	ld	a4,88(s4)
    800014f0:	12068693          	add	a3,a3,288
    800014f4:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    800014f8:	6788                	ld	a0,8(a5)
    800014fa:	6b8c                	ld	a1,16(a5)
    800014fc:	6f90                	ld	a2,24(a5)
    800014fe:	01073023          	sd	a6,0(a4)
    80001502:	e708                	sd	a0,8(a4)
    80001504:	eb0c                	sd	a1,16(a4)
    80001506:	ef10                	sd	a2,24(a4)
    80001508:	02078793          	add	a5,a5,32
    8000150c:	02070713          	add	a4,a4,32
    80001510:	fed792e3          	bne	a5,a3,800014f4 <fork+0x56>
  np->trapframe->a0 = 0;
    80001514:	058a3783          	ld	a5,88(s4)
    80001518:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    8000151c:	0d0a8493          	add	s1,s5,208
    80001520:	0d0a0913          	add	s2,s4,208
    80001524:	150a8993          	add	s3,s5,336
    80001528:	a00d                	j	8000154a <fork+0xac>
    freeproc(np);
    8000152a:	8552                	mv	a0,s4
    8000152c:	00000097          	auipc	ra,0x0
    80001530:	d6e080e7          	jalr	-658(ra) # 8000129a <freeproc>
    release(&np->lock);
    80001534:	8552                	mv	a0,s4
    80001536:	00005097          	auipc	ra,0x5
    8000153a:	eac080e7          	jalr	-340(ra) # 800063e2 <release>
    return -1;
    8000153e:	597d                	li	s2,-1
    80001540:	a059                	j	800015c6 <fork+0x128>
  for(i = 0; i < NOFILE; i++)
    80001542:	04a1                	add	s1,s1,8
    80001544:	0921                	add	s2,s2,8
    80001546:	01348b63          	beq	s1,s3,8000155c <fork+0xbe>
    if(p->ofile[i])
    8000154a:	6088                	ld	a0,0(s1)
    8000154c:	d97d                	beqz	a0,80001542 <fork+0xa4>
      np->ofile[i] = filedup(p->ofile[i]);
    8000154e:	00002097          	auipc	ra,0x2
    80001552:	666080e7          	jalr	1638(ra) # 80003bb4 <filedup>
    80001556:	00a93023          	sd	a0,0(s2)
    8000155a:	b7e5                	j	80001542 <fork+0xa4>
  np->cwd = idup(p->cwd);
    8000155c:	150ab503          	ld	a0,336(s5)
    80001560:	00001097          	auipc	ra,0x1
    80001564:	7fe080e7          	jalr	2046(ra) # 80002d5e <idup>
    80001568:	14aa3823          	sd	a0,336(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    8000156c:	4641                	li	a2,16
    8000156e:	158a8593          	add	a1,s5,344
    80001572:	158a0513          	add	a0,s4,344
    80001576:	fffff097          	auipc	ra,0xfffff
    8000157a:	ed6080e7          	jalr	-298(ra) # 8000044c <safestrcpy>
  pid = np->pid;
    8000157e:	030a2903          	lw	s2,48(s4)
  release(&np->lock);
    80001582:	8552                	mv	a0,s4
    80001584:	00005097          	auipc	ra,0x5
    80001588:	e5e080e7          	jalr	-418(ra) # 800063e2 <release>
  acquire(&wait_lock);
    8000158c:	00027497          	auipc	s1,0x27
    80001590:	3c448493          	add	s1,s1,964 # 80028950 <wait_lock>
    80001594:	8526                	mv	a0,s1
    80001596:	00005097          	auipc	ra,0x5
    8000159a:	d98080e7          	jalr	-616(ra) # 8000632e <acquire>
  np->parent = p;
    8000159e:	035a3c23          	sd	s5,56(s4)
  release(&wait_lock);
    800015a2:	8526                	mv	a0,s1
    800015a4:	00005097          	auipc	ra,0x5
    800015a8:	e3e080e7          	jalr	-450(ra) # 800063e2 <release>
  acquire(&np->lock);
    800015ac:	8552                	mv	a0,s4
    800015ae:	00005097          	auipc	ra,0x5
    800015b2:	d80080e7          	jalr	-640(ra) # 8000632e <acquire>
  np->state = RUNNABLE;
    800015b6:	478d                	li	a5,3
    800015b8:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    800015bc:	8552                	mv	a0,s4
    800015be:	00005097          	auipc	ra,0x5
    800015c2:	e24080e7          	jalr	-476(ra) # 800063e2 <release>
}
    800015c6:	854a                	mv	a0,s2
    800015c8:	70e2                	ld	ra,56(sp)
    800015ca:	7442                	ld	s0,48(sp)
    800015cc:	74a2                	ld	s1,40(sp)
    800015ce:	7902                	ld	s2,32(sp)
    800015d0:	69e2                	ld	s3,24(sp)
    800015d2:	6a42                	ld	s4,16(sp)
    800015d4:	6aa2                	ld	s5,8(sp)
    800015d6:	6121                	add	sp,sp,64
    800015d8:	8082                	ret
    return -1;
    800015da:	597d                	li	s2,-1
    800015dc:	b7ed                	j	800015c6 <fork+0x128>

00000000800015de <scheduler>:
{
    800015de:	7139                	add	sp,sp,-64
    800015e0:	fc06                	sd	ra,56(sp)
    800015e2:	f822                	sd	s0,48(sp)
    800015e4:	f426                	sd	s1,40(sp)
    800015e6:	f04a                	sd	s2,32(sp)
    800015e8:	ec4e                	sd	s3,24(sp)
    800015ea:	e852                	sd	s4,16(sp)
    800015ec:	e456                	sd	s5,8(sp)
    800015ee:	e05a                	sd	s6,0(sp)
    800015f0:	0080                	add	s0,sp,64
    800015f2:	8792                	mv	a5,tp
  int id = r_tp();
    800015f4:	2781                	sext.w	a5,a5
  c->proc = 0;
    800015f6:	00779a93          	sll	s5,a5,0x7
    800015fa:	00027717          	auipc	a4,0x27
    800015fe:	33e70713          	add	a4,a4,830 # 80028938 <pid_lock>
    80001602:	9756                	add	a4,a4,s5
    80001604:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    80001608:	00027717          	auipc	a4,0x27
    8000160c:	36870713          	add	a4,a4,872 # 80028970 <cpus+0x8>
    80001610:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    80001612:	498d                	li	s3,3
        p->state = RUNNING;
    80001614:	4b11                	li	s6,4
        c->proc = p;
    80001616:	079e                	sll	a5,a5,0x7
    80001618:	00027a17          	auipc	s4,0x27
    8000161c:	320a0a13          	add	s4,s4,800 # 80028938 <pid_lock>
    80001620:	9a3e                	add	s4,s4,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    80001622:	0002d917          	auipc	s2,0x2d
    80001626:	14690913          	add	s2,s2,326 # 8002e768 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000162a:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000162e:	0027e793          	or	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001632:	10079073          	csrw	sstatus,a5
    80001636:	00027497          	auipc	s1,0x27
    8000163a:	73248493          	add	s1,s1,1842 # 80028d68 <proc>
    8000163e:	a811                	j	80001652 <scheduler+0x74>
      release(&p->lock);
    80001640:	8526                	mv	a0,s1
    80001642:	00005097          	auipc	ra,0x5
    80001646:	da0080e7          	jalr	-608(ra) # 800063e2 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    8000164a:	16848493          	add	s1,s1,360
    8000164e:	fd248ee3          	beq	s1,s2,8000162a <scheduler+0x4c>
      acquire(&p->lock);
    80001652:	8526                	mv	a0,s1
    80001654:	00005097          	auipc	ra,0x5
    80001658:	cda080e7          	jalr	-806(ra) # 8000632e <acquire>
      if(p->state == RUNNABLE) {
    8000165c:	4c9c                	lw	a5,24(s1)
    8000165e:	ff3791e3          	bne	a5,s3,80001640 <scheduler+0x62>
        p->state = RUNNING;
    80001662:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    80001666:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    8000166a:	06048593          	add	a1,s1,96
    8000166e:	8556                	mv	a0,s5
    80001670:	00000097          	auipc	ra,0x0
    80001674:	684080e7          	jalr	1668(ra) # 80001cf4 <swtch>
        c->proc = 0;
    80001678:	020a3823          	sd	zero,48(s4)
    8000167c:	b7d1                	j	80001640 <scheduler+0x62>

000000008000167e <sched>:
{
    8000167e:	7179                	add	sp,sp,-48
    80001680:	f406                	sd	ra,40(sp)
    80001682:	f022                	sd	s0,32(sp)
    80001684:	ec26                	sd	s1,24(sp)
    80001686:	e84a                	sd	s2,16(sp)
    80001688:	e44e                	sd	s3,8(sp)
    8000168a:	1800                	add	s0,sp,48
  struct proc *p = myproc();
    8000168c:	00000097          	auipc	ra,0x0
    80001690:	a5c080e7          	jalr	-1444(ra) # 800010e8 <myproc>
    80001694:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80001696:	00005097          	auipc	ra,0x5
    8000169a:	c1e080e7          	jalr	-994(ra) # 800062b4 <holding>
    8000169e:	c93d                	beqz	a0,80001714 <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    800016a0:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    800016a2:	2781                	sext.w	a5,a5
    800016a4:	079e                	sll	a5,a5,0x7
    800016a6:	00027717          	auipc	a4,0x27
    800016aa:	29270713          	add	a4,a4,658 # 80028938 <pid_lock>
    800016ae:	97ba                	add	a5,a5,a4
    800016b0:	0a87a703          	lw	a4,168(a5)
    800016b4:	4785                	li	a5,1
    800016b6:	06f71763          	bne	a4,a5,80001724 <sched+0xa6>
  if(p->state == RUNNING)
    800016ba:	4c98                	lw	a4,24(s1)
    800016bc:	4791                	li	a5,4
    800016be:	06f70b63          	beq	a4,a5,80001734 <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800016c2:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800016c6:	8b89                	and	a5,a5,2
  if(intr_get())
    800016c8:	efb5                	bnez	a5,80001744 <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    800016ca:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    800016cc:	00027917          	auipc	s2,0x27
    800016d0:	26c90913          	add	s2,s2,620 # 80028938 <pid_lock>
    800016d4:	2781                	sext.w	a5,a5
    800016d6:	079e                	sll	a5,a5,0x7
    800016d8:	97ca                	add	a5,a5,s2
    800016da:	0ac7a983          	lw	s3,172(a5)
    800016de:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    800016e0:	2781                	sext.w	a5,a5
    800016e2:	079e                	sll	a5,a5,0x7
    800016e4:	00027597          	auipc	a1,0x27
    800016e8:	28c58593          	add	a1,a1,652 # 80028970 <cpus+0x8>
    800016ec:	95be                	add	a1,a1,a5
    800016ee:	06048513          	add	a0,s1,96
    800016f2:	00000097          	auipc	ra,0x0
    800016f6:	602080e7          	jalr	1538(ra) # 80001cf4 <swtch>
    800016fa:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    800016fc:	2781                	sext.w	a5,a5
    800016fe:	079e                	sll	a5,a5,0x7
    80001700:	993e                	add	s2,s2,a5
    80001702:	0b392623          	sw	s3,172(s2)
}
    80001706:	70a2                	ld	ra,40(sp)
    80001708:	7402                	ld	s0,32(sp)
    8000170a:	64e2                	ld	s1,24(sp)
    8000170c:	6942                	ld	s2,16(sp)
    8000170e:	69a2                	ld	s3,8(sp)
    80001710:	6145                	add	sp,sp,48
    80001712:	8082                	ret
    panic("sched p->lock");
    80001714:	00007517          	auipc	a0,0x7
    80001718:	abc50513          	add	a0,a0,-1348 # 800081d0 <etext+0x1d0>
    8000171c:	00004097          	auipc	ra,0x4
    80001720:	6da080e7          	jalr	1754(ra) # 80005df6 <panic>
    panic("sched locks");
    80001724:	00007517          	auipc	a0,0x7
    80001728:	abc50513          	add	a0,a0,-1348 # 800081e0 <etext+0x1e0>
    8000172c:	00004097          	auipc	ra,0x4
    80001730:	6ca080e7          	jalr	1738(ra) # 80005df6 <panic>
    panic("sched running");
    80001734:	00007517          	auipc	a0,0x7
    80001738:	abc50513          	add	a0,a0,-1348 # 800081f0 <etext+0x1f0>
    8000173c:	00004097          	auipc	ra,0x4
    80001740:	6ba080e7          	jalr	1722(ra) # 80005df6 <panic>
    panic("sched interruptible");
    80001744:	00007517          	auipc	a0,0x7
    80001748:	abc50513          	add	a0,a0,-1348 # 80008200 <etext+0x200>
    8000174c:	00004097          	auipc	ra,0x4
    80001750:	6aa080e7          	jalr	1706(ra) # 80005df6 <panic>

0000000080001754 <yield>:
{
    80001754:	1101                	add	sp,sp,-32
    80001756:	ec06                	sd	ra,24(sp)
    80001758:	e822                	sd	s0,16(sp)
    8000175a:	e426                	sd	s1,8(sp)
    8000175c:	1000                	add	s0,sp,32
  struct proc *p = myproc();
    8000175e:	00000097          	auipc	ra,0x0
    80001762:	98a080e7          	jalr	-1654(ra) # 800010e8 <myproc>
    80001766:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80001768:	00005097          	auipc	ra,0x5
    8000176c:	bc6080e7          	jalr	-1082(ra) # 8000632e <acquire>
  p->state = RUNNABLE;
    80001770:	478d                	li	a5,3
    80001772:	cc9c                	sw	a5,24(s1)
  sched();
    80001774:	00000097          	auipc	ra,0x0
    80001778:	f0a080e7          	jalr	-246(ra) # 8000167e <sched>
  release(&p->lock);
    8000177c:	8526                	mv	a0,s1
    8000177e:	00005097          	auipc	ra,0x5
    80001782:	c64080e7          	jalr	-924(ra) # 800063e2 <release>
}
    80001786:	60e2                	ld	ra,24(sp)
    80001788:	6442                	ld	s0,16(sp)
    8000178a:	64a2                	ld	s1,8(sp)
    8000178c:	6105                	add	sp,sp,32
    8000178e:	8082                	ret

0000000080001790 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80001790:	7179                	add	sp,sp,-48
    80001792:	f406                	sd	ra,40(sp)
    80001794:	f022                	sd	s0,32(sp)
    80001796:	ec26                	sd	s1,24(sp)
    80001798:	e84a                	sd	s2,16(sp)
    8000179a:	e44e                	sd	s3,8(sp)
    8000179c:	1800                	add	s0,sp,48
    8000179e:	89aa                	mv	s3,a0
    800017a0:	892e                	mv	s2,a1
  struct proc *p = myproc();
    800017a2:	00000097          	auipc	ra,0x0
    800017a6:	946080e7          	jalr	-1722(ra) # 800010e8 <myproc>
    800017aa:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    800017ac:	00005097          	auipc	ra,0x5
    800017b0:	b82080e7          	jalr	-1150(ra) # 8000632e <acquire>
  release(lk);
    800017b4:	854a                	mv	a0,s2
    800017b6:	00005097          	auipc	ra,0x5
    800017ba:	c2c080e7          	jalr	-980(ra) # 800063e2 <release>

  // Go to sleep.
  p->chan = chan;
    800017be:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    800017c2:	4789                	li	a5,2
    800017c4:	cc9c                	sw	a5,24(s1)

  sched();
    800017c6:	00000097          	auipc	ra,0x0
    800017ca:	eb8080e7          	jalr	-328(ra) # 8000167e <sched>

  // Tidy up.
  p->chan = 0;
    800017ce:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    800017d2:	8526                	mv	a0,s1
    800017d4:	00005097          	auipc	ra,0x5
    800017d8:	c0e080e7          	jalr	-1010(ra) # 800063e2 <release>
  acquire(lk);
    800017dc:	854a                	mv	a0,s2
    800017de:	00005097          	auipc	ra,0x5
    800017e2:	b50080e7          	jalr	-1200(ra) # 8000632e <acquire>
}
    800017e6:	70a2                	ld	ra,40(sp)
    800017e8:	7402                	ld	s0,32(sp)
    800017ea:	64e2                	ld	s1,24(sp)
    800017ec:	6942                	ld	s2,16(sp)
    800017ee:	69a2                	ld	s3,8(sp)
    800017f0:	6145                	add	sp,sp,48
    800017f2:	8082                	ret

00000000800017f4 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    800017f4:	7139                	add	sp,sp,-64
    800017f6:	fc06                	sd	ra,56(sp)
    800017f8:	f822                	sd	s0,48(sp)
    800017fa:	f426                	sd	s1,40(sp)
    800017fc:	f04a                	sd	s2,32(sp)
    800017fe:	ec4e                	sd	s3,24(sp)
    80001800:	e852                	sd	s4,16(sp)
    80001802:	e456                	sd	s5,8(sp)
    80001804:	0080                	add	s0,sp,64
    80001806:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    80001808:	00027497          	auipc	s1,0x27
    8000180c:	56048493          	add	s1,s1,1376 # 80028d68 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    80001810:	4989                	li	s3,2
        p->state = RUNNABLE;
    80001812:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    80001814:	0002d917          	auipc	s2,0x2d
    80001818:	f5490913          	add	s2,s2,-172 # 8002e768 <tickslock>
    8000181c:	a811                	j	80001830 <wakeup+0x3c>
      }
      release(&p->lock);
    8000181e:	8526                	mv	a0,s1
    80001820:	00005097          	auipc	ra,0x5
    80001824:	bc2080e7          	jalr	-1086(ra) # 800063e2 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001828:	16848493          	add	s1,s1,360
    8000182c:	03248663          	beq	s1,s2,80001858 <wakeup+0x64>
    if(p != myproc()){
    80001830:	00000097          	auipc	ra,0x0
    80001834:	8b8080e7          	jalr	-1864(ra) # 800010e8 <myproc>
    80001838:	fea488e3          	beq	s1,a0,80001828 <wakeup+0x34>
      acquire(&p->lock);
    8000183c:	8526                	mv	a0,s1
    8000183e:	00005097          	auipc	ra,0x5
    80001842:	af0080e7          	jalr	-1296(ra) # 8000632e <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    80001846:	4c9c                	lw	a5,24(s1)
    80001848:	fd379be3          	bne	a5,s3,8000181e <wakeup+0x2a>
    8000184c:	709c                	ld	a5,32(s1)
    8000184e:	fd4798e3          	bne	a5,s4,8000181e <wakeup+0x2a>
        p->state = RUNNABLE;
    80001852:	0154ac23          	sw	s5,24(s1)
    80001856:	b7e1                	j	8000181e <wakeup+0x2a>
    }
  }
}
    80001858:	70e2                	ld	ra,56(sp)
    8000185a:	7442                	ld	s0,48(sp)
    8000185c:	74a2                	ld	s1,40(sp)
    8000185e:	7902                	ld	s2,32(sp)
    80001860:	69e2                	ld	s3,24(sp)
    80001862:	6a42                	ld	s4,16(sp)
    80001864:	6aa2                	ld	s5,8(sp)
    80001866:	6121                	add	sp,sp,64
    80001868:	8082                	ret

000000008000186a <reparent>:
{
    8000186a:	7179                	add	sp,sp,-48
    8000186c:	f406                	sd	ra,40(sp)
    8000186e:	f022                	sd	s0,32(sp)
    80001870:	ec26                	sd	s1,24(sp)
    80001872:	e84a                	sd	s2,16(sp)
    80001874:	e44e                	sd	s3,8(sp)
    80001876:	e052                	sd	s4,0(sp)
    80001878:	1800                	add	s0,sp,48
    8000187a:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    8000187c:	00027497          	auipc	s1,0x27
    80001880:	4ec48493          	add	s1,s1,1260 # 80028d68 <proc>
      pp->parent = initproc;
    80001884:	00007a17          	auipc	s4,0x7
    80001888:	05ca0a13          	add	s4,s4,92 # 800088e0 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    8000188c:	0002d997          	auipc	s3,0x2d
    80001890:	edc98993          	add	s3,s3,-292 # 8002e768 <tickslock>
    80001894:	a029                	j	8000189e <reparent+0x34>
    80001896:	16848493          	add	s1,s1,360
    8000189a:	01348d63          	beq	s1,s3,800018b4 <reparent+0x4a>
    if(pp->parent == p){
    8000189e:	7c9c                	ld	a5,56(s1)
    800018a0:	ff279be3          	bne	a5,s2,80001896 <reparent+0x2c>
      pp->parent = initproc;
    800018a4:	000a3503          	ld	a0,0(s4)
    800018a8:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    800018aa:	00000097          	auipc	ra,0x0
    800018ae:	f4a080e7          	jalr	-182(ra) # 800017f4 <wakeup>
    800018b2:	b7d5                	j	80001896 <reparent+0x2c>
}
    800018b4:	70a2                	ld	ra,40(sp)
    800018b6:	7402                	ld	s0,32(sp)
    800018b8:	64e2                	ld	s1,24(sp)
    800018ba:	6942                	ld	s2,16(sp)
    800018bc:	69a2                	ld	s3,8(sp)
    800018be:	6a02                	ld	s4,0(sp)
    800018c0:	6145                	add	sp,sp,48
    800018c2:	8082                	ret

00000000800018c4 <exit>:
{
    800018c4:	7179                	add	sp,sp,-48
    800018c6:	f406                	sd	ra,40(sp)
    800018c8:	f022                	sd	s0,32(sp)
    800018ca:	ec26                	sd	s1,24(sp)
    800018cc:	e84a                	sd	s2,16(sp)
    800018ce:	e44e                	sd	s3,8(sp)
    800018d0:	e052                	sd	s4,0(sp)
    800018d2:	1800                	add	s0,sp,48
    800018d4:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    800018d6:	00000097          	auipc	ra,0x0
    800018da:	812080e7          	jalr	-2030(ra) # 800010e8 <myproc>
    800018de:	89aa                	mv	s3,a0
  if(p == initproc)
    800018e0:	00007797          	auipc	a5,0x7
    800018e4:	0007b783          	ld	a5,0(a5) # 800088e0 <initproc>
    800018e8:	0d050493          	add	s1,a0,208
    800018ec:	15050913          	add	s2,a0,336
    800018f0:	02a79363          	bne	a5,a0,80001916 <exit+0x52>
    panic("init exiting");
    800018f4:	00007517          	auipc	a0,0x7
    800018f8:	92450513          	add	a0,a0,-1756 # 80008218 <etext+0x218>
    800018fc:	00004097          	auipc	ra,0x4
    80001900:	4fa080e7          	jalr	1274(ra) # 80005df6 <panic>
      fileclose(f);
    80001904:	00002097          	auipc	ra,0x2
    80001908:	302080e7          	jalr	770(ra) # 80003c06 <fileclose>
      p->ofile[fd] = 0;
    8000190c:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    80001910:	04a1                	add	s1,s1,8
    80001912:	01248563          	beq	s1,s2,8000191c <exit+0x58>
    if(p->ofile[fd]){
    80001916:	6088                	ld	a0,0(s1)
    80001918:	f575                	bnez	a0,80001904 <exit+0x40>
    8000191a:	bfdd                	j	80001910 <exit+0x4c>
  begin_op();
    8000191c:	00002097          	auipc	ra,0x2
    80001920:	e26080e7          	jalr	-474(ra) # 80003742 <begin_op>
  iput(p->cwd);
    80001924:	1509b503          	ld	a0,336(s3)
    80001928:	00001097          	auipc	ra,0x1
    8000192c:	62e080e7          	jalr	1582(ra) # 80002f56 <iput>
  end_op();
    80001930:	00002097          	auipc	ra,0x2
    80001934:	e8c080e7          	jalr	-372(ra) # 800037bc <end_op>
  p->cwd = 0;
    80001938:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    8000193c:	00027497          	auipc	s1,0x27
    80001940:	01448493          	add	s1,s1,20 # 80028950 <wait_lock>
    80001944:	8526                	mv	a0,s1
    80001946:	00005097          	auipc	ra,0x5
    8000194a:	9e8080e7          	jalr	-1560(ra) # 8000632e <acquire>
  reparent(p);
    8000194e:	854e                	mv	a0,s3
    80001950:	00000097          	auipc	ra,0x0
    80001954:	f1a080e7          	jalr	-230(ra) # 8000186a <reparent>
  wakeup(p->parent);
    80001958:	0389b503          	ld	a0,56(s3)
    8000195c:	00000097          	auipc	ra,0x0
    80001960:	e98080e7          	jalr	-360(ra) # 800017f4 <wakeup>
  acquire(&p->lock);
    80001964:	854e                	mv	a0,s3
    80001966:	00005097          	auipc	ra,0x5
    8000196a:	9c8080e7          	jalr	-1592(ra) # 8000632e <acquire>
  p->xstate = status;
    8000196e:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    80001972:	4795                	li	a5,5
    80001974:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    80001978:	8526                	mv	a0,s1
    8000197a:	00005097          	auipc	ra,0x5
    8000197e:	a68080e7          	jalr	-1432(ra) # 800063e2 <release>
  sched();
    80001982:	00000097          	auipc	ra,0x0
    80001986:	cfc080e7          	jalr	-772(ra) # 8000167e <sched>
  panic("zombie exit");
    8000198a:	00007517          	auipc	a0,0x7
    8000198e:	89e50513          	add	a0,a0,-1890 # 80008228 <etext+0x228>
    80001992:	00004097          	auipc	ra,0x4
    80001996:	464080e7          	jalr	1124(ra) # 80005df6 <panic>

000000008000199a <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    8000199a:	7179                	add	sp,sp,-48
    8000199c:	f406                	sd	ra,40(sp)
    8000199e:	f022                	sd	s0,32(sp)
    800019a0:	ec26                	sd	s1,24(sp)
    800019a2:	e84a                	sd	s2,16(sp)
    800019a4:	e44e                	sd	s3,8(sp)
    800019a6:	1800                	add	s0,sp,48
    800019a8:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    800019aa:	00027497          	auipc	s1,0x27
    800019ae:	3be48493          	add	s1,s1,958 # 80028d68 <proc>
    800019b2:	0002d997          	auipc	s3,0x2d
    800019b6:	db698993          	add	s3,s3,-586 # 8002e768 <tickslock>
    acquire(&p->lock);
    800019ba:	8526                	mv	a0,s1
    800019bc:	00005097          	auipc	ra,0x5
    800019c0:	972080e7          	jalr	-1678(ra) # 8000632e <acquire>
    if(p->pid == pid){
    800019c4:	589c                	lw	a5,48(s1)
    800019c6:	01278d63          	beq	a5,s2,800019e0 <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    800019ca:	8526                	mv	a0,s1
    800019cc:	00005097          	auipc	ra,0x5
    800019d0:	a16080e7          	jalr	-1514(ra) # 800063e2 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    800019d4:	16848493          	add	s1,s1,360
    800019d8:	ff3491e3          	bne	s1,s3,800019ba <kill+0x20>
  }
  return -1;
    800019dc:	557d                	li	a0,-1
    800019de:	a829                	j	800019f8 <kill+0x5e>
      p->killed = 1;
    800019e0:	4785                	li	a5,1
    800019e2:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    800019e4:	4c98                	lw	a4,24(s1)
    800019e6:	4789                	li	a5,2
    800019e8:	00f70f63          	beq	a4,a5,80001a06 <kill+0x6c>
      release(&p->lock);
    800019ec:	8526                	mv	a0,s1
    800019ee:	00005097          	auipc	ra,0x5
    800019f2:	9f4080e7          	jalr	-1548(ra) # 800063e2 <release>
      return 0;
    800019f6:	4501                	li	a0,0
}
    800019f8:	70a2                	ld	ra,40(sp)
    800019fa:	7402                	ld	s0,32(sp)
    800019fc:	64e2                	ld	s1,24(sp)
    800019fe:	6942                	ld	s2,16(sp)
    80001a00:	69a2                	ld	s3,8(sp)
    80001a02:	6145                	add	sp,sp,48
    80001a04:	8082                	ret
        p->state = RUNNABLE;
    80001a06:	478d                	li	a5,3
    80001a08:	cc9c                	sw	a5,24(s1)
    80001a0a:	b7cd                	j	800019ec <kill+0x52>

0000000080001a0c <setkilled>:

void
setkilled(struct proc *p)
{
    80001a0c:	1101                	add	sp,sp,-32
    80001a0e:	ec06                	sd	ra,24(sp)
    80001a10:	e822                	sd	s0,16(sp)
    80001a12:	e426                	sd	s1,8(sp)
    80001a14:	1000                	add	s0,sp,32
    80001a16:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80001a18:	00005097          	auipc	ra,0x5
    80001a1c:	916080e7          	jalr	-1770(ra) # 8000632e <acquire>
  p->killed = 1;
    80001a20:	4785                	li	a5,1
    80001a22:	d49c                	sw	a5,40(s1)
  release(&p->lock);
    80001a24:	8526                	mv	a0,s1
    80001a26:	00005097          	auipc	ra,0x5
    80001a2a:	9bc080e7          	jalr	-1604(ra) # 800063e2 <release>
}
    80001a2e:	60e2                	ld	ra,24(sp)
    80001a30:	6442                	ld	s0,16(sp)
    80001a32:	64a2                	ld	s1,8(sp)
    80001a34:	6105                	add	sp,sp,32
    80001a36:	8082                	ret

0000000080001a38 <killed>:

int
killed(struct proc *p)
{
    80001a38:	1101                	add	sp,sp,-32
    80001a3a:	ec06                	sd	ra,24(sp)
    80001a3c:	e822                	sd	s0,16(sp)
    80001a3e:	e426                	sd	s1,8(sp)
    80001a40:	e04a                	sd	s2,0(sp)
    80001a42:	1000                	add	s0,sp,32
    80001a44:	84aa                	mv	s1,a0
  int k;
  
  acquire(&p->lock);
    80001a46:	00005097          	auipc	ra,0x5
    80001a4a:	8e8080e7          	jalr	-1816(ra) # 8000632e <acquire>
  k = p->killed;
    80001a4e:	0284a903          	lw	s2,40(s1)
  release(&p->lock);
    80001a52:	8526                	mv	a0,s1
    80001a54:	00005097          	auipc	ra,0x5
    80001a58:	98e080e7          	jalr	-1650(ra) # 800063e2 <release>
  return k;
}
    80001a5c:	854a                	mv	a0,s2
    80001a5e:	60e2                	ld	ra,24(sp)
    80001a60:	6442                	ld	s0,16(sp)
    80001a62:	64a2                	ld	s1,8(sp)
    80001a64:	6902                	ld	s2,0(sp)
    80001a66:	6105                	add	sp,sp,32
    80001a68:	8082                	ret

0000000080001a6a <wait>:
{
    80001a6a:	715d                	add	sp,sp,-80
    80001a6c:	e486                	sd	ra,72(sp)
    80001a6e:	e0a2                	sd	s0,64(sp)
    80001a70:	fc26                	sd	s1,56(sp)
    80001a72:	f84a                	sd	s2,48(sp)
    80001a74:	f44e                	sd	s3,40(sp)
    80001a76:	f052                	sd	s4,32(sp)
    80001a78:	ec56                	sd	s5,24(sp)
    80001a7a:	e85a                	sd	s6,16(sp)
    80001a7c:	e45e                	sd	s7,8(sp)
    80001a7e:	e062                	sd	s8,0(sp)
    80001a80:	0880                	add	s0,sp,80
    80001a82:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    80001a84:	fffff097          	auipc	ra,0xfffff
    80001a88:	664080e7          	jalr	1636(ra) # 800010e8 <myproc>
    80001a8c:	892a                	mv	s2,a0
  acquire(&wait_lock);
    80001a8e:	00027517          	auipc	a0,0x27
    80001a92:	ec250513          	add	a0,a0,-318 # 80028950 <wait_lock>
    80001a96:	00005097          	auipc	ra,0x5
    80001a9a:	898080e7          	jalr	-1896(ra) # 8000632e <acquire>
    havekids = 0;
    80001a9e:	4b81                	li	s7,0
        if(pp->state == ZOMBIE){
    80001aa0:	4a15                	li	s4,5
        havekids = 1;
    80001aa2:	4a85                	li	s5,1
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001aa4:	0002d997          	auipc	s3,0x2d
    80001aa8:	cc498993          	add	s3,s3,-828 # 8002e768 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001aac:	00027c17          	auipc	s8,0x27
    80001ab0:	ea4c0c13          	add	s8,s8,-348 # 80028950 <wait_lock>
    80001ab4:	a0d1                	j	80001b78 <wait+0x10e>
          pid = pp->pid;
    80001ab6:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    80001aba:	000b0e63          	beqz	s6,80001ad6 <wait+0x6c>
    80001abe:	4691                	li	a3,4
    80001ac0:	02c48613          	add	a2,s1,44
    80001ac4:	85da                	mv	a1,s6
    80001ac6:	05093503          	ld	a0,80(s2)
    80001aca:	fffff097          	auipc	ra,0xfffff
    80001ace:	404080e7          	jalr	1028(ra) # 80000ece <copyout>
    80001ad2:	04054163          	bltz	a0,80001b14 <wait+0xaa>
          freeproc(pp);
    80001ad6:	8526                	mv	a0,s1
    80001ad8:	fffff097          	auipc	ra,0xfffff
    80001adc:	7c2080e7          	jalr	1986(ra) # 8000129a <freeproc>
          release(&pp->lock);
    80001ae0:	8526                	mv	a0,s1
    80001ae2:	00005097          	auipc	ra,0x5
    80001ae6:	900080e7          	jalr	-1792(ra) # 800063e2 <release>
          release(&wait_lock);
    80001aea:	00027517          	auipc	a0,0x27
    80001aee:	e6650513          	add	a0,a0,-410 # 80028950 <wait_lock>
    80001af2:	00005097          	auipc	ra,0x5
    80001af6:	8f0080e7          	jalr	-1808(ra) # 800063e2 <release>
}
    80001afa:	854e                	mv	a0,s3
    80001afc:	60a6                	ld	ra,72(sp)
    80001afe:	6406                	ld	s0,64(sp)
    80001b00:	74e2                	ld	s1,56(sp)
    80001b02:	7942                	ld	s2,48(sp)
    80001b04:	79a2                	ld	s3,40(sp)
    80001b06:	7a02                	ld	s4,32(sp)
    80001b08:	6ae2                	ld	s5,24(sp)
    80001b0a:	6b42                	ld	s6,16(sp)
    80001b0c:	6ba2                	ld	s7,8(sp)
    80001b0e:	6c02                	ld	s8,0(sp)
    80001b10:	6161                	add	sp,sp,80
    80001b12:	8082                	ret
            release(&pp->lock);
    80001b14:	8526                	mv	a0,s1
    80001b16:	00005097          	auipc	ra,0x5
    80001b1a:	8cc080e7          	jalr	-1844(ra) # 800063e2 <release>
            release(&wait_lock);
    80001b1e:	00027517          	auipc	a0,0x27
    80001b22:	e3250513          	add	a0,a0,-462 # 80028950 <wait_lock>
    80001b26:	00005097          	auipc	ra,0x5
    80001b2a:	8bc080e7          	jalr	-1860(ra) # 800063e2 <release>
            return -1;
    80001b2e:	59fd                	li	s3,-1
    80001b30:	b7e9                	j	80001afa <wait+0x90>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001b32:	16848493          	add	s1,s1,360
    80001b36:	03348463          	beq	s1,s3,80001b5e <wait+0xf4>
      if(pp->parent == p){
    80001b3a:	7c9c                	ld	a5,56(s1)
    80001b3c:	ff279be3          	bne	a5,s2,80001b32 <wait+0xc8>
        acquire(&pp->lock);
    80001b40:	8526                	mv	a0,s1
    80001b42:	00004097          	auipc	ra,0x4
    80001b46:	7ec080e7          	jalr	2028(ra) # 8000632e <acquire>
        if(pp->state == ZOMBIE){
    80001b4a:	4c9c                	lw	a5,24(s1)
    80001b4c:	f74785e3          	beq	a5,s4,80001ab6 <wait+0x4c>
        release(&pp->lock);
    80001b50:	8526                	mv	a0,s1
    80001b52:	00005097          	auipc	ra,0x5
    80001b56:	890080e7          	jalr	-1904(ra) # 800063e2 <release>
        havekids = 1;
    80001b5a:	8756                	mv	a4,s5
    80001b5c:	bfd9                	j	80001b32 <wait+0xc8>
    if(!havekids || killed(p)){
    80001b5e:	c31d                	beqz	a4,80001b84 <wait+0x11a>
    80001b60:	854a                	mv	a0,s2
    80001b62:	00000097          	auipc	ra,0x0
    80001b66:	ed6080e7          	jalr	-298(ra) # 80001a38 <killed>
    80001b6a:	ed09                	bnez	a0,80001b84 <wait+0x11a>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001b6c:	85e2                	mv	a1,s8
    80001b6e:	854a                	mv	a0,s2
    80001b70:	00000097          	auipc	ra,0x0
    80001b74:	c20080e7          	jalr	-992(ra) # 80001790 <sleep>
    havekids = 0;
    80001b78:	875e                	mv	a4,s7
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001b7a:	00027497          	auipc	s1,0x27
    80001b7e:	1ee48493          	add	s1,s1,494 # 80028d68 <proc>
    80001b82:	bf65                	j	80001b3a <wait+0xd0>
      release(&wait_lock);
    80001b84:	00027517          	auipc	a0,0x27
    80001b88:	dcc50513          	add	a0,a0,-564 # 80028950 <wait_lock>
    80001b8c:	00005097          	auipc	ra,0x5
    80001b90:	856080e7          	jalr	-1962(ra) # 800063e2 <release>
      return -1;
    80001b94:	59fd                	li	s3,-1
    80001b96:	b795                	j	80001afa <wait+0x90>

0000000080001b98 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80001b98:	7179                	add	sp,sp,-48
    80001b9a:	f406                	sd	ra,40(sp)
    80001b9c:	f022                	sd	s0,32(sp)
    80001b9e:	ec26                	sd	s1,24(sp)
    80001ba0:	e84a                	sd	s2,16(sp)
    80001ba2:	e44e                	sd	s3,8(sp)
    80001ba4:	e052                	sd	s4,0(sp)
    80001ba6:	1800                	add	s0,sp,48
    80001ba8:	84aa                	mv	s1,a0
    80001baa:	892e                	mv	s2,a1
    80001bac:	89b2                	mv	s3,a2
    80001bae:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001bb0:	fffff097          	auipc	ra,0xfffff
    80001bb4:	538080e7          	jalr	1336(ra) # 800010e8 <myproc>
  if(user_dst){
    80001bb8:	c08d                	beqz	s1,80001bda <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    80001bba:	86d2                	mv	a3,s4
    80001bbc:	864e                	mv	a2,s3
    80001bbe:	85ca                	mv	a1,s2
    80001bc0:	6928                	ld	a0,80(a0)
    80001bc2:	fffff097          	auipc	ra,0xfffff
    80001bc6:	30c080e7          	jalr	780(ra) # 80000ece <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    80001bca:	70a2                	ld	ra,40(sp)
    80001bcc:	7402                	ld	s0,32(sp)
    80001bce:	64e2                	ld	s1,24(sp)
    80001bd0:	6942                	ld	s2,16(sp)
    80001bd2:	69a2                	ld	s3,8(sp)
    80001bd4:	6a02                	ld	s4,0(sp)
    80001bd6:	6145                	add	sp,sp,48
    80001bd8:	8082                	ret
    memmove((char *)dst, src, len);
    80001bda:	000a061b          	sext.w	a2,s4
    80001bde:	85ce                	mv	a1,s3
    80001be0:	854a                	mv	a0,s2
    80001be2:	ffffe097          	auipc	ra,0xffffe
    80001be6:	77e080e7          	jalr	1918(ra) # 80000360 <memmove>
    return 0;
    80001bea:	8526                	mv	a0,s1
    80001bec:	bff9                	j	80001bca <either_copyout+0x32>

0000000080001bee <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80001bee:	7179                	add	sp,sp,-48
    80001bf0:	f406                	sd	ra,40(sp)
    80001bf2:	f022                	sd	s0,32(sp)
    80001bf4:	ec26                	sd	s1,24(sp)
    80001bf6:	e84a                	sd	s2,16(sp)
    80001bf8:	e44e                	sd	s3,8(sp)
    80001bfa:	e052                	sd	s4,0(sp)
    80001bfc:	1800                	add	s0,sp,48
    80001bfe:	892a                	mv	s2,a0
    80001c00:	84ae                	mv	s1,a1
    80001c02:	89b2                	mv	s3,a2
    80001c04:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001c06:	fffff097          	auipc	ra,0xfffff
    80001c0a:	4e2080e7          	jalr	1250(ra) # 800010e8 <myproc>
  if(user_src){
    80001c0e:	c08d                	beqz	s1,80001c30 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80001c10:	86d2                	mv	a3,s4
    80001c12:	864e                	mv	a2,s3
    80001c14:	85ca                	mv	a1,s2
    80001c16:	6928                	ld	a0,80(a0)
    80001c18:	fffff097          	auipc	ra,0xfffff
    80001c1c:	07c080e7          	jalr	124(ra) # 80000c94 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80001c20:	70a2                	ld	ra,40(sp)
    80001c22:	7402                	ld	s0,32(sp)
    80001c24:	64e2                	ld	s1,24(sp)
    80001c26:	6942                	ld	s2,16(sp)
    80001c28:	69a2                	ld	s3,8(sp)
    80001c2a:	6a02                	ld	s4,0(sp)
    80001c2c:	6145                	add	sp,sp,48
    80001c2e:	8082                	ret
    memmove(dst, (char*)src, len);
    80001c30:	000a061b          	sext.w	a2,s4
    80001c34:	85ce                	mv	a1,s3
    80001c36:	854a                	mv	a0,s2
    80001c38:	ffffe097          	auipc	ra,0xffffe
    80001c3c:	728080e7          	jalr	1832(ra) # 80000360 <memmove>
    return 0;
    80001c40:	8526                	mv	a0,s1
    80001c42:	bff9                	j	80001c20 <either_copyin+0x32>

0000000080001c44 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80001c44:	715d                	add	sp,sp,-80
    80001c46:	e486                	sd	ra,72(sp)
    80001c48:	e0a2                	sd	s0,64(sp)
    80001c4a:	fc26                	sd	s1,56(sp)
    80001c4c:	f84a                	sd	s2,48(sp)
    80001c4e:	f44e                	sd	s3,40(sp)
    80001c50:	f052                	sd	s4,32(sp)
    80001c52:	ec56                	sd	s5,24(sp)
    80001c54:	e85a                	sd	s6,16(sp)
    80001c56:	e45e                	sd	s7,8(sp)
    80001c58:	0880                	add	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80001c5a:	00006517          	auipc	a0,0x6
    80001c5e:	3f650513          	add	a0,a0,1014 # 80008050 <etext+0x50>
    80001c62:	00004097          	auipc	ra,0x4
    80001c66:	1de080e7          	jalr	478(ra) # 80005e40 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001c6a:	00027497          	auipc	s1,0x27
    80001c6e:	25648493          	add	s1,s1,598 # 80028ec0 <proc+0x158>
    80001c72:	0002d917          	auipc	s2,0x2d
    80001c76:	c4e90913          	add	s2,s2,-946 # 8002e8c0 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001c7a:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80001c7c:	00006997          	auipc	s3,0x6
    80001c80:	5bc98993          	add	s3,s3,1468 # 80008238 <etext+0x238>
    printf("%d %s %s", p->pid, state, p->name);
    80001c84:	00006a97          	auipc	s5,0x6
    80001c88:	5bca8a93          	add	s5,s5,1468 # 80008240 <etext+0x240>
    printf("\n");
    80001c8c:	00006a17          	auipc	s4,0x6
    80001c90:	3c4a0a13          	add	s4,s4,964 # 80008050 <etext+0x50>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001c94:	00006b97          	auipc	s7,0x6
    80001c98:	5ecb8b93          	add	s7,s7,1516 # 80008280 <states.0>
    80001c9c:	a00d                	j	80001cbe <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    80001c9e:	ed86a583          	lw	a1,-296(a3)
    80001ca2:	8556                	mv	a0,s5
    80001ca4:	00004097          	auipc	ra,0x4
    80001ca8:	19c080e7          	jalr	412(ra) # 80005e40 <printf>
    printf("\n");
    80001cac:	8552                	mv	a0,s4
    80001cae:	00004097          	auipc	ra,0x4
    80001cb2:	192080e7          	jalr	402(ra) # 80005e40 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001cb6:	16848493          	add	s1,s1,360
    80001cba:	03248263          	beq	s1,s2,80001cde <procdump+0x9a>
    if(p->state == UNUSED)
    80001cbe:	86a6                	mv	a3,s1
    80001cc0:	ec04a783          	lw	a5,-320(s1)
    80001cc4:	dbed                	beqz	a5,80001cb6 <procdump+0x72>
      state = "???";
    80001cc6:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001cc8:	fcfb6be3          	bltu	s6,a5,80001c9e <procdump+0x5a>
    80001ccc:	02079713          	sll	a4,a5,0x20
    80001cd0:	01d75793          	srl	a5,a4,0x1d
    80001cd4:	97de                	add	a5,a5,s7
    80001cd6:	6390                	ld	a2,0(a5)
    80001cd8:	f279                	bnez	a2,80001c9e <procdump+0x5a>
      state = "???";
    80001cda:	864e                	mv	a2,s3
    80001cdc:	b7c9                	j	80001c9e <procdump+0x5a>
  }
}
    80001cde:	60a6                	ld	ra,72(sp)
    80001ce0:	6406                	ld	s0,64(sp)
    80001ce2:	74e2                	ld	s1,56(sp)
    80001ce4:	7942                	ld	s2,48(sp)
    80001ce6:	79a2                	ld	s3,40(sp)
    80001ce8:	7a02                	ld	s4,32(sp)
    80001cea:	6ae2                	ld	s5,24(sp)
    80001cec:	6b42                	ld	s6,16(sp)
    80001cee:	6ba2                	ld	s7,8(sp)
    80001cf0:	6161                	add	sp,sp,80
    80001cf2:	8082                	ret

0000000080001cf4 <swtch>:
    80001cf4:	00153023          	sd	ra,0(a0)
    80001cf8:	00253423          	sd	sp,8(a0)
    80001cfc:	e900                	sd	s0,16(a0)
    80001cfe:	ed04                	sd	s1,24(a0)
    80001d00:	03253023          	sd	s2,32(a0)
    80001d04:	03353423          	sd	s3,40(a0)
    80001d08:	03453823          	sd	s4,48(a0)
    80001d0c:	03553c23          	sd	s5,56(a0)
    80001d10:	05653023          	sd	s6,64(a0)
    80001d14:	05753423          	sd	s7,72(a0)
    80001d18:	05853823          	sd	s8,80(a0)
    80001d1c:	05953c23          	sd	s9,88(a0)
    80001d20:	07a53023          	sd	s10,96(a0)
    80001d24:	07b53423          	sd	s11,104(a0)
    80001d28:	0005b083          	ld	ra,0(a1)
    80001d2c:	0085b103          	ld	sp,8(a1)
    80001d30:	6980                	ld	s0,16(a1)
    80001d32:	6d84                	ld	s1,24(a1)
    80001d34:	0205b903          	ld	s2,32(a1)
    80001d38:	0285b983          	ld	s3,40(a1)
    80001d3c:	0305ba03          	ld	s4,48(a1)
    80001d40:	0385ba83          	ld	s5,56(a1)
    80001d44:	0405bb03          	ld	s6,64(a1)
    80001d48:	0485bb83          	ld	s7,72(a1)
    80001d4c:	0505bc03          	ld	s8,80(a1)
    80001d50:	0585bc83          	ld	s9,88(a1)
    80001d54:	0605bd03          	ld	s10,96(a1)
    80001d58:	0685bd83          	ld	s11,104(a1)
    80001d5c:	8082                	ret

0000000080001d5e <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001d5e:	1141                	add	sp,sp,-16
    80001d60:	e406                	sd	ra,8(sp)
    80001d62:	e022                	sd	s0,0(sp)
    80001d64:	0800                	add	s0,sp,16
  initlock(&tickslock, "time");
    80001d66:	00006597          	auipc	a1,0x6
    80001d6a:	54a58593          	add	a1,a1,1354 # 800082b0 <states.0+0x30>
    80001d6e:	0002d517          	auipc	a0,0x2d
    80001d72:	9fa50513          	add	a0,a0,-1542 # 8002e768 <tickslock>
    80001d76:	00004097          	auipc	ra,0x4
    80001d7a:	528080e7          	jalr	1320(ra) # 8000629e <initlock>
}
    80001d7e:	60a2                	ld	ra,8(sp)
    80001d80:	6402                	ld	s0,0(sp)
    80001d82:	0141                	add	sp,sp,16
    80001d84:	8082                	ret

0000000080001d86 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001d86:	1141                	add	sp,sp,-16
    80001d88:	e422                	sd	s0,8(sp)
    80001d8a:	0800                	add	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001d8c:	00003797          	auipc	a5,0x3
    80001d90:	4a478793          	add	a5,a5,1188 # 80005230 <kernelvec>
    80001d94:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001d98:	6422                	ld	s0,8(sp)
    80001d9a:	0141                	add	sp,sp,16
    80001d9c:	8082                	ret

0000000080001d9e <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001d9e:	1141                	add	sp,sp,-16
    80001da0:	e406                	sd	ra,8(sp)
    80001da2:	e022                	sd	s0,0(sp)
    80001da4:	0800                	add	s0,sp,16
  struct proc *p = myproc();
    80001da6:	fffff097          	auipc	ra,0xfffff
    80001daa:	342080e7          	jalr	834(ra) # 800010e8 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001dae:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001db2:	9bf5                	and	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001db4:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    80001db8:	00005697          	auipc	a3,0x5
    80001dbc:	24868693          	add	a3,a3,584 # 80007000 <_trampoline>
    80001dc0:	00005717          	auipc	a4,0x5
    80001dc4:	24070713          	add	a4,a4,576 # 80007000 <_trampoline>
    80001dc8:	8f15                	sub	a4,a4,a3
    80001dca:	040007b7          	lui	a5,0x4000
    80001dce:	17fd                	add	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80001dd0:	07b2                	sll	a5,a5,0xc
    80001dd2:	973e                	add	a4,a4,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001dd4:	10571073          	csrw	stvec,a4
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80001dd8:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80001dda:	18002673          	csrr	a2,satp
    80001dde:	e310                	sd	a2,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001de0:	6d30                	ld	a2,88(a0)
    80001de2:	6138                	ld	a4,64(a0)
    80001de4:	6585                	lui	a1,0x1
    80001de6:	972e                	add	a4,a4,a1
    80001de8:	e618                	sd	a4,8(a2)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001dea:	6d38                	ld	a4,88(a0)
    80001dec:	00000617          	auipc	a2,0x0
    80001df0:	13460613          	add	a2,a2,308 # 80001f20 <usertrap>
    80001df4:	eb10                	sd	a2,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80001df6:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80001df8:	8612                	mv	a2,tp
    80001dfa:	f310                	sd	a2,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001dfc:	10002773          	csrr	a4,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80001e00:	eff77713          	and	a4,a4,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001e04:	02076713          	or	a4,a4,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001e08:	10071073          	csrw	sstatus,a4
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001e0c:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001e0e:	6f18                	ld	a4,24(a4)
    80001e10:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80001e14:	6928                	ld	a0,80(a0)
    80001e16:	8131                	srl	a0,a0,0xc

  // jump to userret in trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80001e18:	00005717          	auipc	a4,0x5
    80001e1c:	28470713          	add	a4,a4,644 # 8000709c <userret>
    80001e20:	8f15                	sub	a4,a4,a3
    80001e22:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    80001e24:	577d                	li	a4,-1
    80001e26:	177e                	sll	a4,a4,0x3f
    80001e28:	8d59                	or	a0,a0,a4
    80001e2a:	9782                	jalr	a5
}
    80001e2c:	60a2                	ld	ra,8(sp)
    80001e2e:	6402                	ld	s0,0(sp)
    80001e30:	0141                	add	sp,sp,16
    80001e32:	8082                	ret

0000000080001e34 <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80001e34:	1101                	add	sp,sp,-32
    80001e36:	ec06                	sd	ra,24(sp)
    80001e38:	e822                	sd	s0,16(sp)
    80001e3a:	e426                	sd	s1,8(sp)
    80001e3c:	1000                	add	s0,sp,32
  acquire(&tickslock);
    80001e3e:	0002d497          	auipc	s1,0x2d
    80001e42:	92a48493          	add	s1,s1,-1750 # 8002e768 <tickslock>
    80001e46:	8526                	mv	a0,s1
    80001e48:	00004097          	auipc	ra,0x4
    80001e4c:	4e6080e7          	jalr	1254(ra) # 8000632e <acquire>
  ticks++;
    80001e50:	00007517          	auipc	a0,0x7
    80001e54:	a9850513          	add	a0,a0,-1384 # 800088e8 <ticks>
    80001e58:	411c                	lw	a5,0(a0)
    80001e5a:	2785                	addw	a5,a5,1
    80001e5c:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80001e5e:	00000097          	auipc	ra,0x0
    80001e62:	996080e7          	jalr	-1642(ra) # 800017f4 <wakeup>
  release(&tickslock);
    80001e66:	8526                	mv	a0,s1
    80001e68:	00004097          	auipc	ra,0x4
    80001e6c:	57a080e7          	jalr	1402(ra) # 800063e2 <release>
}
    80001e70:	60e2                	ld	ra,24(sp)
    80001e72:	6442                	ld	s0,16(sp)
    80001e74:	64a2                	ld	s1,8(sp)
    80001e76:	6105                	add	sp,sp,32
    80001e78:	8082                	ret

0000000080001e7a <devintr>:
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001e7a:	142027f3          	csrr	a5,scause
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80001e7e:	4501                	li	a0,0
  if((scause & 0x8000000000000000L) &&
    80001e80:	0807df63          	bgez	a5,80001f1e <devintr+0xa4>
{
    80001e84:	1101                	add	sp,sp,-32
    80001e86:	ec06                	sd	ra,24(sp)
    80001e88:	e822                	sd	s0,16(sp)
    80001e8a:	e426                	sd	s1,8(sp)
    80001e8c:	1000                	add	s0,sp,32
     (scause & 0xff) == 9){
    80001e8e:	0ff7f713          	zext.b	a4,a5
  if((scause & 0x8000000000000000L) &&
    80001e92:	46a5                	li	a3,9
    80001e94:	00d70d63          	beq	a4,a3,80001eae <devintr+0x34>
  } else if(scause == 0x8000000000000001L){
    80001e98:	577d                	li	a4,-1
    80001e9a:	177e                	sll	a4,a4,0x3f
    80001e9c:	0705                	add	a4,a4,1
    return 0;
    80001e9e:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80001ea0:	04e78e63          	beq	a5,a4,80001efc <devintr+0x82>
  }
}
    80001ea4:	60e2                	ld	ra,24(sp)
    80001ea6:	6442                	ld	s0,16(sp)
    80001ea8:	64a2                	ld	s1,8(sp)
    80001eaa:	6105                	add	sp,sp,32
    80001eac:	8082                	ret
    int irq = plic_claim();
    80001eae:	00003097          	auipc	ra,0x3
    80001eb2:	48a080e7          	jalr	1162(ra) # 80005338 <plic_claim>
    80001eb6:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001eb8:	47a9                	li	a5,10
    80001eba:	02f50763          	beq	a0,a5,80001ee8 <devintr+0x6e>
    } else if(irq == VIRTIO0_IRQ){
    80001ebe:	4785                	li	a5,1
    80001ec0:	02f50963          	beq	a0,a5,80001ef2 <devintr+0x78>
    return 1;
    80001ec4:	4505                	li	a0,1
    } else if(irq){
    80001ec6:	dcf9                	beqz	s1,80001ea4 <devintr+0x2a>
      printf("unexpected interrupt irq=%d\n", irq);
    80001ec8:	85a6                	mv	a1,s1
    80001eca:	00006517          	auipc	a0,0x6
    80001ece:	3ee50513          	add	a0,a0,1006 # 800082b8 <states.0+0x38>
    80001ed2:	00004097          	auipc	ra,0x4
    80001ed6:	f6e080e7          	jalr	-146(ra) # 80005e40 <printf>
      plic_complete(irq);
    80001eda:	8526                	mv	a0,s1
    80001edc:	00003097          	auipc	ra,0x3
    80001ee0:	480080e7          	jalr	1152(ra) # 8000535c <plic_complete>
    return 1;
    80001ee4:	4505                	li	a0,1
    80001ee6:	bf7d                	j	80001ea4 <devintr+0x2a>
      uartintr();
    80001ee8:	00004097          	auipc	ra,0x4
    80001eec:	366080e7          	jalr	870(ra) # 8000624e <uartintr>
    if(irq)
    80001ef0:	b7ed                	j	80001eda <devintr+0x60>
      virtio_disk_intr();
    80001ef2:	00004097          	auipc	ra,0x4
    80001ef6:	930080e7          	jalr	-1744(ra) # 80005822 <virtio_disk_intr>
    if(irq)
    80001efa:	b7c5                	j	80001eda <devintr+0x60>
    if(cpuid() == 0){
    80001efc:	fffff097          	auipc	ra,0xfffff
    80001f00:	1c0080e7          	jalr	448(ra) # 800010bc <cpuid>
    80001f04:	c901                	beqz	a0,80001f14 <devintr+0x9a>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80001f06:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80001f0a:	9bf5                	and	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80001f0c:	14479073          	csrw	sip,a5
    return 2;
    80001f10:	4509                	li	a0,2
    80001f12:	bf49                	j	80001ea4 <devintr+0x2a>
      clockintr();
    80001f14:	00000097          	auipc	ra,0x0
    80001f18:	f20080e7          	jalr	-224(ra) # 80001e34 <clockintr>
    80001f1c:	b7ed                	j	80001f06 <devintr+0x8c>
}
    80001f1e:	8082                	ret

0000000080001f20 <usertrap>:
{
    80001f20:	1101                	add	sp,sp,-32
    80001f22:	ec06                	sd	ra,24(sp)
    80001f24:	e822                	sd	s0,16(sp)
    80001f26:	e426                	sd	s1,8(sp)
    80001f28:	e04a                	sd	s2,0(sp)
    80001f2a:	1000                	add	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001f2c:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80001f30:	1007f793          	and	a5,a5,256
    80001f34:	ebb5                	bnez	a5,80001fa8 <usertrap+0x88>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001f36:	00003797          	auipc	a5,0x3
    80001f3a:	2fa78793          	add	a5,a5,762 # 80005230 <kernelvec>
    80001f3e:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001f42:	fffff097          	auipc	ra,0xfffff
    80001f46:	1a6080e7          	jalr	422(ra) # 800010e8 <myproc>
    80001f4a:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001f4c:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001f4e:	14102773          	csrr	a4,sepc
    80001f52:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001f54:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80001f58:	47a1                	li	a5,8
    80001f5a:	04f70f63          	beq	a4,a5,80001fb8 <usertrap+0x98>
  } else if((which_dev = devintr()) != 0){
    80001f5e:	00000097          	auipc	ra,0x0
    80001f62:	f1c080e7          	jalr	-228(ra) # 80001e7a <devintr>
    80001f66:	892a                	mv	s2,a0
    80001f68:	e561                	bnez	a0,80002030 <usertrap+0x110>
    80001f6a:	14202773          	csrr	a4,scause
  } else if ((r_scause() == 15) && uvmcheckcowpage(r_stval())) {
    80001f6e:	47bd                	li	a5,15
    80001f70:	08f70d63          	beq	a4,a5,8000200a <usertrap+0xea>
    80001f74:	142025f3          	csrr	a1,scause
      printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80001f78:	5890                	lw	a2,48(s1)
    80001f7a:	00006517          	auipc	a0,0x6
    80001f7e:	37e50513          	add	a0,a0,894 # 800082f8 <states.0+0x78>
    80001f82:	00004097          	auipc	ra,0x4
    80001f86:	ebe080e7          	jalr	-322(ra) # 80005e40 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001f8a:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001f8e:	14302673          	csrr	a2,stval
      printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001f92:	00006517          	auipc	a0,0x6
    80001f96:	39650513          	add	a0,a0,918 # 80008328 <states.0+0xa8>
    80001f9a:	00004097          	auipc	ra,0x4
    80001f9e:	ea6080e7          	jalr	-346(ra) # 80005e40 <printf>
      p->killed = 1;
    80001fa2:	4785                	li	a5,1
    80001fa4:	d49c                	sw	a5,40(s1)
    80001fa6:	a825                	j	80001fde <usertrap+0xbe>
    panic("usertrap: not from user mode");
    80001fa8:	00006517          	auipc	a0,0x6
    80001fac:	33050513          	add	a0,a0,816 # 800082d8 <states.0+0x58>
    80001fb0:	00004097          	auipc	ra,0x4
    80001fb4:	e46080e7          	jalr	-442(ra) # 80005df6 <panic>
    if(killed(p))
    80001fb8:	00000097          	auipc	ra,0x0
    80001fbc:	a80080e7          	jalr	-1408(ra) # 80001a38 <killed>
    80001fc0:	ed1d                	bnez	a0,80001ffe <usertrap+0xde>
    p->trapframe->epc += 4;
    80001fc2:	6cb8                	ld	a4,88(s1)
    80001fc4:	6f1c                	ld	a5,24(a4)
    80001fc6:	0791                	add	a5,a5,4
    80001fc8:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001fca:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001fce:	0027e793          	or	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001fd2:	10079073          	csrw	sstatus,a5
    syscall();
    80001fd6:	00000097          	auipc	ra,0x0
    80001fda:	2ce080e7          	jalr	718(ra) # 800022a4 <syscall>
  if(killed(p))
    80001fde:	8526                	mv	a0,s1
    80001fe0:	00000097          	auipc	ra,0x0
    80001fe4:	a58080e7          	jalr	-1448(ra) # 80001a38 <killed>
    80001fe8:	e939                	bnez	a0,8000203e <usertrap+0x11e>
  usertrapret();
    80001fea:	00000097          	auipc	ra,0x0
    80001fee:	db4080e7          	jalr	-588(ra) # 80001d9e <usertrapret>
}
    80001ff2:	60e2                	ld	ra,24(sp)
    80001ff4:	6442                	ld	s0,16(sp)
    80001ff6:	64a2                	ld	s1,8(sp)
    80001ff8:	6902                	ld	s2,0(sp)
    80001ffa:	6105                	add	sp,sp,32
    80001ffc:	8082                	ret
      exit(-1);
    80001ffe:	557d                	li	a0,-1
    80002000:	00000097          	auipc	ra,0x0
    80002004:	8c4080e7          	jalr	-1852(ra) # 800018c4 <exit>
    80002008:	bf6d                	j	80001fc2 <usertrap+0xa2>
  asm volatile("csrr %0, stval" : "=r" (x) );
    8000200a:	14302573          	csrr	a0,stval
  } else if ((r_scause() == 15) && uvmcheckcowpage(r_stval())) {
    8000200e:	fffff097          	auipc	ra,0xfffff
    80002012:	dc4080e7          	jalr	-572(ra) # 80000dd2 <uvmcheckcowpage>
    80002016:	dd39                	beqz	a0,80001f74 <usertrap+0x54>
    80002018:	14302573          	csrr	a0,stval
        if (uvmcowcopy(r_stval()) == -1) {
    8000201c:	fffff097          	auipc	ra,0xfffff
    80002020:	e00080e7          	jalr	-512(ra) # 80000e1c <uvmcowcopy>
    80002024:	57fd                	li	a5,-1
    80002026:	faf51ce3          	bne	a0,a5,80001fde <usertrap+0xbe>
            p->killed = 1;
    8000202a:	4785                	li	a5,1
    8000202c:	d49c                	sw	a5,40(s1)
    8000202e:	bf45                	j	80001fde <usertrap+0xbe>
  if(killed(p))
    80002030:	8526                	mv	a0,s1
    80002032:	00000097          	auipc	ra,0x0
    80002036:	a06080e7          	jalr	-1530(ra) # 80001a38 <killed>
    8000203a:	c901                	beqz	a0,8000204a <usertrap+0x12a>
    8000203c:	a011                	j	80002040 <usertrap+0x120>
    8000203e:	4901                	li	s2,0
    exit(-1);
    80002040:	557d                	li	a0,-1
    80002042:	00000097          	auipc	ra,0x0
    80002046:	882080e7          	jalr	-1918(ra) # 800018c4 <exit>
  if(which_dev == 2)
    8000204a:	4789                	li	a5,2
    8000204c:	f8f91fe3          	bne	s2,a5,80001fea <usertrap+0xca>
    yield();
    80002050:	fffff097          	auipc	ra,0xfffff
    80002054:	704080e7          	jalr	1796(ra) # 80001754 <yield>
    80002058:	bf49                	j	80001fea <usertrap+0xca>

000000008000205a <kerneltrap>:
{
    8000205a:	7179                	add	sp,sp,-48
    8000205c:	f406                	sd	ra,40(sp)
    8000205e:	f022                	sd	s0,32(sp)
    80002060:	ec26                	sd	s1,24(sp)
    80002062:	e84a                	sd	s2,16(sp)
    80002064:	e44e                	sd	s3,8(sp)
    80002066:	1800                	add	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002068:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000206c:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002070:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80002074:	1004f793          	and	a5,s1,256
    80002078:	cb85                	beqz	a5,800020a8 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000207a:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8000207e:	8b89                	and	a5,a5,2
  if(intr_get() != 0)
    80002080:	ef85                	bnez	a5,800020b8 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80002082:	00000097          	auipc	ra,0x0
    80002086:	df8080e7          	jalr	-520(ra) # 80001e7a <devintr>
    8000208a:	cd1d                	beqz	a0,800020c8 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    8000208c:	4789                	li	a5,2
    8000208e:	06f50a63          	beq	a0,a5,80002102 <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80002092:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002096:	10049073          	csrw	sstatus,s1
}
    8000209a:	70a2                	ld	ra,40(sp)
    8000209c:	7402                	ld	s0,32(sp)
    8000209e:	64e2                	ld	s1,24(sp)
    800020a0:	6942                	ld	s2,16(sp)
    800020a2:	69a2                	ld	s3,8(sp)
    800020a4:	6145                	add	sp,sp,48
    800020a6:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    800020a8:	00006517          	auipc	a0,0x6
    800020ac:	2a050513          	add	a0,a0,672 # 80008348 <states.0+0xc8>
    800020b0:	00004097          	auipc	ra,0x4
    800020b4:	d46080e7          	jalr	-698(ra) # 80005df6 <panic>
    panic("kerneltrap: interrupts enabled");
    800020b8:	00006517          	auipc	a0,0x6
    800020bc:	2b850513          	add	a0,a0,696 # 80008370 <states.0+0xf0>
    800020c0:	00004097          	auipc	ra,0x4
    800020c4:	d36080e7          	jalr	-714(ra) # 80005df6 <panic>
    printf("scause %p\n", scause);
    800020c8:	85ce                	mv	a1,s3
    800020ca:	00006517          	auipc	a0,0x6
    800020ce:	2c650513          	add	a0,a0,710 # 80008390 <states.0+0x110>
    800020d2:	00004097          	auipc	ra,0x4
    800020d6:	d6e080e7          	jalr	-658(ra) # 80005e40 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800020da:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    800020de:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    800020e2:	00006517          	auipc	a0,0x6
    800020e6:	2be50513          	add	a0,a0,702 # 800083a0 <states.0+0x120>
    800020ea:	00004097          	auipc	ra,0x4
    800020ee:	d56080e7          	jalr	-682(ra) # 80005e40 <printf>
    panic("kerneltrap");
    800020f2:	00006517          	auipc	a0,0x6
    800020f6:	2c650513          	add	a0,a0,710 # 800083b8 <states.0+0x138>
    800020fa:	00004097          	auipc	ra,0x4
    800020fe:	cfc080e7          	jalr	-772(ra) # 80005df6 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002102:	fffff097          	auipc	ra,0xfffff
    80002106:	fe6080e7          	jalr	-26(ra) # 800010e8 <myproc>
    8000210a:	d541                	beqz	a0,80002092 <kerneltrap+0x38>
    8000210c:	fffff097          	auipc	ra,0xfffff
    80002110:	fdc080e7          	jalr	-36(ra) # 800010e8 <myproc>
    80002114:	4d18                	lw	a4,24(a0)
    80002116:	4791                	li	a5,4
    80002118:	f6f71de3          	bne	a4,a5,80002092 <kerneltrap+0x38>
    yield();
    8000211c:	fffff097          	auipc	ra,0xfffff
    80002120:	638080e7          	jalr	1592(ra) # 80001754 <yield>
    80002124:	b7bd                	j	80002092 <kerneltrap+0x38>

0000000080002126 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80002126:	1101                	add	sp,sp,-32
    80002128:	ec06                	sd	ra,24(sp)
    8000212a:	e822                	sd	s0,16(sp)
    8000212c:	e426                	sd	s1,8(sp)
    8000212e:	1000                	add	s0,sp,32
    80002130:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80002132:	fffff097          	auipc	ra,0xfffff
    80002136:	fb6080e7          	jalr	-74(ra) # 800010e8 <myproc>
  switch (n) {
    8000213a:	4795                	li	a5,5
    8000213c:	0497e163          	bltu	a5,s1,8000217e <argraw+0x58>
    80002140:	048a                	sll	s1,s1,0x2
    80002142:	00006717          	auipc	a4,0x6
    80002146:	2ae70713          	add	a4,a4,686 # 800083f0 <states.0+0x170>
    8000214a:	94ba                	add	s1,s1,a4
    8000214c:	409c                	lw	a5,0(s1)
    8000214e:	97ba                	add	a5,a5,a4
    80002150:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80002152:	6d3c                	ld	a5,88(a0)
    80002154:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80002156:	60e2                	ld	ra,24(sp)
    80002158:	6442                	ld	s0,16(sp)
    8000215a:	64a2                	ld	s1,8(sp)
    8000215c:	6105                	add	sp,sp,32
    8000215e:	8082                	ret
    return p->trapframe->a1;
    80002160:	6d3c                	ld	a5,88(a0)
    80002162:	7fa8                	ld	a0,120(a5)
    80002164:	bfcd                	j	80002156 <argraw+0x30>
    return p->trapframe->a2;
    80002166:	6d3c                	ld	a5,88(a0)
    80002168:	63c8                	ld	a0,128(a5)
    8000216a:	b7f5                	j	80002156 <argraw+0x30>
    return p->trapframe->a3;
    8000216c:	6d3c                	ld	a5,88(a0)
    8000216e:	67c8                	ld	a0,136(a5)
    80002170:	b7dd                	j	80002156 <argraw+0x30>
    return p->trapframe->a4;
    80002172:	6d3c                	ld	a5,88(a0)
    80002174:	6bc8                	ld	a0,144(a5)
    80002176:	b7c5                	j	80002156 <argraw+0x30>
    return p->trapframe->a5;
    80002178:	6d3c                	ld	a5,88(a0)
    8000217a:	6fc8                	ld	a0,152(a5)
    8000217c:	bfe9                	j	80002156 <argraw+0x30>
  panic("argraw");
    8000217e:	00006517          	auipc	a0,0x6
    80002182:	24a50513          	add	a0,a0,586 # 800083c8 <states.0+0x148>
    80002186:	00004097          	auipc	ra,0x4
    8000218a:	c70080e7          	jalr	-912(ra) # 80005df6 <panic>

000000008000218e <fetchaddr>:
{
    8000218e:	1101                	add	sp,sp,-32
    80002190:	ec06                	sd	ra,24(sp)
    80002192:	e822                	sd	s0,16(sp)
    80002194:	e426                	sd	s1,8(sp)
    80002196:	e04a                	sd	s2,0(sp)
    80002198:	1000                	add	s0,sp,32
    8000219a:	84aa                	mv	s1,a0
    8000219c:	892e                	mv	s2,a1
  struct proc *p = myproc();
    8000219e:	fffff097          	auipc	ra,0xfffff
    800021a2:	f4a080e7          	jalr	-182(ra) # 800010e8 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    800021a6:	653c                	ld	a5,72(a0)
    800021a8:	02f4f863          	bgeu	s1,a5,800021d8 <fetchaddr+0x4a>
    800021ac:	00848713          	add	a4,s1,8
    800021b0:	02e7e663          	bltu	a5,a4,800021dc <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    800021b4:	46a1                	li	a3,8
    800021b6:	8626                	mv	a2,s1
    800021b8:	85ca                	mv	a1,s2
    800021ba:	6928                	ld	a0,80(a0)
    800021bc:	fffff097          	auipc	ra,0xfffff
    800021c0:	ad8080e7          	jalr	-1320(ra) # 80000c94 <copyin>
    800021c4:	00a03533          	snez	a0,a0
    800021c8:	40a00533          	neg	a0,a0
}
    800021cc:	60e2                	ld	ra,24(sp)
    800021ce:	6442                	ld	s0,16(sp)
    800021d0:	64a2                	ld	s1,8(sp)
    800021d2:	6902                	ld	s2,0(sp)
    800021d4:	6105                	add	sp,sp,32
    800021d6:	8082                	ret
    return -1;
    800021d8:	557d                	li	a0,-1
    800021da:	bfcd                	j	800021cc <fetchaddr+0x3e>
    800021dc:	557d                	li	a0,-1
    800021de:	b7fd                	j	800021cc <fetchaddr+0x3e>

00000000800021e0 <fetchstr>:
{
    800021e0:	7179                	add	sp,sp,-48
    800021e2:	f406                	sd	ra,40(sp)
    800021e4:	f022                	sd	s0,32(sp)
    800021e6:	ec26                	sd	s1,24(sp)
    800021e8:	e84a                	sd	s2,16(sp)
    800021ea:	e44e                	sd	s3,8(sp)
    800021ec:	1800                	add	s0,sp,48
    800021ee:	892a                	mv	s2,a0
    800021f0:	84ae                	mv	s1,a1
    800021f2:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    800021f4:	fffff097          	auipc	ra,0xfffff
    800021f8:	ef4080e7          	jalr	-268(ra) # 800010e8 <myproc>
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    800021fc:	86ce                	mv	a3,s3
    800021fe:	864a                	mv	a2,s2
    80002200:	85a6                	mv	a1,s1
    80002202:	6928                	ld	a0,80(a0)
    80002204:	fffff097          	auipc	ra,0xfffff
    80002208:	b1e080e7          	jalr	-1250(ra) # 80000d22 <copyinstr>
    8000220c:	00054e63          	bltz	a0,80002228 <fetchstr+0x48>
  return strlen(buf);
    80002210:	8526                	mv	a0,s1
    80002212:	ffffe097          	auipc	ra,0xffffe
    80002216:	26c080e7          	jalr	620(ra) # 8000047e <strlen>
}
    8000221a:	70a2                	ld	ra,40(sp)
    8000221c:	7402                	ld	s0,32(sp)
    8000221e:	64e2                	ld	s1,24(sp)
    80002220:	6942                	ld	s2,16(sp)
    80002222:	69a2                	ld	s3,8(sp)
    80002224:	6145                	add	sp,sp,48
    80002226:	8082                	ret
    return -1;
    80002228:	557d                	li	a0,-1
    8000222a:	bfc5                	j	8000221a <fetchstr+0x3a>

000000008000222c <argint>:

// Fetch the nth 32-bit system call argument.
void
argint(int n, int *ip)
{
    8000222c:	1101                	add	sp,sp,-32
    8000222e:	ec06                	sd	ra,24(sp)
    80002230:	e822                	sd	s0,16(sp)
    80002232:	e426                	sd	s1,8(sp)
    80002234:	1000                	add	s0,sp,32
    80002236:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002238:	00000097          	auipc	ra,0x0
    8000223c:	eee080e7          	jalr	-274(ra) # 80002126 <argraw>
    80002240:	c088                	sw	a0,0(s1)
}
    80002242:	60e2                	ld	ra,24(sp)
    80002244:	6442                	ld	s0,16(sp)
    80002246:	64a2                	ld	s1,8(sp)
    80002248:	6105                	add	sp,sp,32
    8000224a:	8082                	ret

000000008000224c <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr(int n, uint64 *ip)
{
    8000224c:	1101                	add	sp,sp,-32
    8000224e:	ec06                	sd	ra,24(sp)
    80002250:	e822                	sd	s0,16(sp)
    80002252:	e426                	sd	s1,8(sp)
    80002254:	1000                	add	s0,sp,32
    80002256:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002258:	00000097          	auipc	ra,0x0
    8000225c:	ece080e7          	jalr	-306(ra) # 80002126 <argraw>
    80002260:	e088                	sd	a0,0(s1)
}
    80002262:	60e2                	ld	ra,24(sp)
    80002264:	6442                	ld	s0,16(sp)
    80002266:	64a2                	ld	s1,8(sp)
    80002268:	6105                	add	sp,sp,32
    8000226a:	8082                	ret

000000008000226c <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    8000226c:	7179                	add	sp,sp,-48
    8000226e:	f406                	sd	ra,40(sp)
    80002270:	f022                	sd	s0,32(sp)
    80002272:	ec26                	sd	s1,24(sp)
    80002274:	e84a                	sd	s2,16(sp)
    80002276:	1800                	add	s0,sp,48
    80002278:	84ae                	mv	s1,a1
    8000227a:	8932                	mv	s2,a2
  uint64 addr;
  argaddr(n, &addr);
    8000227c:	fd840593          	add	a1,s0,-40
    80002280:	00000097          	auipc	ra,0x0
    80002284:	fcc080e7          	jalr	-52(ra) # 8000224c <argaddr>
  return fetchstr(addr, buf, max);
    80002288:	864a                	mv	a2,s2
    8000228a:	85a6                	mv	a1,s1
    8000228c:	fd843503          	ld	a0,-40(s0)
    80002290:	00000097          	auipc	ra,0x0
    80002294:	f50080e7          	jalr	-176(ra) # 800021e0 <fetchstr>
}
    80002298:	70a2                	ld	ra,40(sp)
    8000229a:	7402                	ld	s0,32(sp)
    8000229c:	64e2                	ld	s1,24(sp)
    8000229e:	6942                	ld	s2,16(sp)
    800022a0:	6145                	add	sp,sp,48
    800022a2:	8082                	ret

00000000800022a4 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
    800022a4:	1101                	add	sp,sp,-32
    800022a6:	ec06                	sd	ra,24(sp)
    800022a8:	e822                	sd	s0,16(sp)
    800022aa:	e426                	sd	s1,8(sp)
    800022ac:	e04a                	sd	s2,0(sp)
    800022ae:	1000                	add	s0,sp,32
  int num;
  struct proc *p = myproc();
    800022b0:	fffff097          	auipc	ra,0xfffff
    800022b4:	e38080e7          	jalr	-456(ra) # 800010e8 <myproc>
    800022b8:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    800022ba:	05853903          	ld	s2,88(a0)
    800022be:	0a893783          	ld	a5,168(s2)
    800022c2:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    800022c6:	37fd                	addw	a5,a5,-1
    800022c8:	4751                	li	a4,20
    800022ca:	00f76f63          	bltu	a4,a5,800022e8 <syscall+0x44>
    800022ce:	00369713          	sll	a4,a3,0x3
    800022d2:	00006797          	auipc	a5,0x6
    800022d6:	13678793          	add	a5,a5,310 # 80008408 <syscalls>
    800022da:	97ba                	add	a5,a5,a4
    800022dc:	639c                	ld	a5,0(a5)
    800022de:	c789                	beqz	a5,800022e8 <syscall+0x44>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    800022e0:	9782                	jalr	a5
    800022e2:	06a93823          	sd	a0,112(s2)
    800022e6:	a839                	j	80002304 <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    800022e8:	15848613          	add	a2,s1,344
    800022ec:	588c                	lw	a1,48(s1)
    800022ee:	00006517          	auipc	a0,0x6
    800022f2:	0e250513          	add	a0,a0,226 # 800083d0 <states.0+0x150>
    800022f6:	00004097          	auipc	ra,0x4
    800022fa:	b4a080e7          	jalr	-1206(ra) # 80005e40 <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    800022fe:	6cbc                	ld	a5,88(s1)
    80002300:	577d                	li	a4,-1
    80002302:	fbb8                	sd	a4,112(a5)
  }
}
    80002304:	60e2                	ld	ra,24(sp)
    80002306:	6442                	ld	s0,16(sp)
    80002308:	64a2                	ld	s1,8(sp)
    8000230a:	6902                	ld	s2,0(sp)
    8000230c:	6105                	add	sp,sp,32
    8000230e:	8082                	ret

0000000080002310 <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    80002310:	1101                	add	sp,sp,-32
    80002312:	ec06                	sd	ra,24(sp)
    80002314:	e822                	sd	s0,16(sp)
    80002316:	1000                	add	s0,sp,32
  int n;
  argint(0, &n);
    80002318:	fec40593          	add	a1,s0,-20
    8000231c:	4501                	li	a0,0
    8000231e:	00000097          	auipc	ra,0x0
    80002322:	f0e080e7          	jalr	-242(ra) # 8000222c <argint>
  exit(n);
    80002326:	fec42503          	lw	a0,-20(s0)
    8000232a:	fffff097          	auipc	ra,0xfffff
    8000232e:	59a080e7          	jalr	1434(ra) # 800018c4 <exit>
  return 0;  // not reached
}
    80002332:	4501                	li	a0,0
    80002334:	60e2                	ld	ra,24(sp)
    80002336:	6442                	ld	s0,16(sp)
    80002338:	6105                	add	sp,sp,32
    8000233a:	8082                	ret

000000008000233c <sys_getpid>:

uint64
sys_getpid(void)
{
    8000233c:	1141                	add	sp,sp,-16
    8000233e:	e406                	sd	ra,8(sp)
    80002340:	e022                	sd	s0,0(sp)
    80002342:	0800                	add	s0,sp,16
  return myproc()->pid;
    80002344:	fffff097          	auipc	ra,0xfffff
    80002348:	da4080e7          	jalr	-604(ra) # 800010e8 <myproc>
}
    8000234c:	5908                	lw	a0,48(a0)
    8000234e:	60a2                	ld	ra,8(sp)
    80002350:	6402                	ld	s0,0(sp)
    80002352:	0141                	add	sp,sp,16
    80002354:	8082                	ret

0000000080002356 <sys_fork>:

uint64
sys_fork(void)
{
    80002356:	1141                	add	sp,sp,-16
    80002358:	e406                	sd	ra,8(sp)
    8000235a:	e022                	sd	s0,0(sp)
    8000235c:	0800                	add	s0,sp,16
  return fork();
    8000235e:	fffff097          	auipc	ra,0xfffff
    80002362:	140080e7          	jalr	320(ra) # 8000149e <fork>
}
    80002366:	60a2                	ld	ra,8(sp)
    80002368:	6402                	ld	s0,0(sp)
    8000236a:	0141                	add	sp,sp,16
    8000236c:	8082                	ret

000000008000236e <sys_wait>:

uint64
sys_wait(void)
{
    8000236e:	1101                	add	sp,sp,-32
    80002370:	ec06                	sd	ra,24(sp)
    80002372:	e822                	sd	s0,16(sp)
    80002374:	1000                	add	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    80002376:	fe840593          	add	a1,s0,-24
    8000237a:	4501                	li	a0,0
    8000237c:	00000097          	auipc	ra,0x0
    80002380:	ed0080e7          	jalr	-304(ra) # 8000224c <argaddr>
  return wait(p);
    80002384:	fe843503          	ld	a0,-24(s0)
    80002388:	fffff097          	auipc	ra,0xfffff
    8000238c:	6e2080e7          	jalr	1762(ra) # 80001a6a <wait>
}
    80002390:	60e2                	ld	ra,24(sp)
    80002392:	6442                	ld	s0,16(sp)
    80002394:	6105                	add	sp,sp,32
    80002396:	8082                	ret

0000000080002398 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80002398:	7179                	add	sp,sp,-48
    8000239a:	f406                	sd	ra,40(sp)
    8000239c:	f022                	sd	s0,32(sp)
    8000239e:	ec26                	sd	s1,24(sp)
    800023a0:	1800                	add	s0,sp,48
  uint64 addr;
  int n;

  argint(0, &n);
    800023a2:	fdc40593          	add	a1,s0,-36
    800023a6:	4501                	li	a0,0
    800023a8:	00000097          	auipc	ra,0x0
    800023ac:	e84080e7          	jalr	-380(ra) # 8000222c <argint>
  addr = myproc()->sz;
    800023b0:	fffff097          	auipc	ra,0xfffff
    800023b4:	d38080e7          	jalr	-712(ra) # 800010e8 <myproc>
    800023b8:	6524                	ld	s1,72(a0)
  if(growproc(n) < 0)
    800023ba:	fdc42503          	lw	a0,-36(s0)
    800023be:	fffff097          	auipc	ra,0xfffff
    800023c2:	084080e7          	jalr	132(ra) # 80001442 <growproc>
    800023c6:	00054863          	bltz	a0,800023d6 <sys_sbrk+0x3e>
    return -1;
  return addr;
}
    800023ca:	8526                	mv	a0,s1
    800023cc:	70a2                	ld	ra,40(sp)
    800023ce:	7402                	ld	s0,32(sp)
    800023d0:	64e2                	ld	s1,24(sp)
    800023d2:	6145                	add	sp,sp,48
    800023d4:	8082                	ret
    return -1;
    800023d6:	54fd                	li	s1,-1
    800023d8:	bfcd                	j	800023ca <sys_sbrk+0x32>

00000000800023da <sys_sleep>:

uint64
sys_sleep(void)
{
    800023da:	7139                	add	sp,sp,-64
    800023dc:	fc06                	sd	ra,56(sp)
    800023de:	f822                	sd	s0,48(sp)
    800023e0:	f426                	sd	s1,40(sp)
    800023e2:	f04a                	sd	s2,32(sp)
    800023e4:	ec4e                	sd	s3,24(sp)
    800023e6:	0080                	add	s0,sp,64
  int n;
  uint ticks0;

  argint(0, &n);
    800023e8:	fcc40593          	add	a1,s0,-52
    800023ec:	4501                	li	a0,0
    800023ee:	00000097          	auipc	ra,0x0
    800023f2:	e3e080e7          	jalr	-450(ra) # 8000222c <argint>
  if(n < 0)
    800023f6:	fcc42783          	lw	a5,-52(s0)
    800023fa:	0607cf63          	bltz	a5,80002478 <sys_sleep+0x9e>
    n = 0;
  acquire(&tickslock);
    800023fe:	0002c517          	auipc	a0,0x2c
    80002402:	36a50513          	add	a0,a0,874 # 8002e768 <tickslock>
    80002406:	00004097          	auipc	ra,0x4
    8000240a:	f28080e7          	jalr	-216(ra) # 8000632e <acquire>
  ticks0 = ticks;
    8000240e:	00006917          	auipc	s2,0x6
    80002412:	4da92903          	lw	s2,1242(s2) # 800088e8 <ticks>
  while(ticks - ticks0 < n){
    80002416:	fcc42783          	lw	a5,-52(s0)
    8000241a:	cf9d                	beqz	a5,80002458 <sys_sleep+0x7e>
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    8000241c:	0002c997          	auipc	s3,0x2c
    80002420:	34c98993          	add	s3,s3,844 # 8002e768 <tickslock>
    80002424:	00006497          	auipc	s1,0x6
    80002428:	4c448493          	add	s1,s1,1220 # 800088e8 <ticks>
    if(killed(myproc())){
    8000242c:	fffff097          	auipc	ra,0xfffff
    80002430:	cbc080e7          	jalr	-836(ra) # 800010e8 <myproc>
    80002434:	fffff097          	auipc	ra,0xfffff
    80002438:	604080e7          	jalr	1540(ra) # 80001a38 <killed>
    8000243c:	e129                	bnez	a0,8000247e <sys_sleep+0xa4>
    sleep(&ticks, &tickslock);
    8000243e:	85ce                	mv	a1,s3
    80002440:	8526                	mv	a0,s1
    80002442:	fffff097          	auipc	ra,0xfffff
    80002446:	34e080e7          	jalr	846(ra) # 80001790 <sleep>
  while(ticks - ticks0 < n){
    8000244a:	409c                	lw	a5,0(s1)
    8000244c:	412787bb          	subw	a5,a5,s2
    80002450:	fcc42703          	lw	a4,-52(s0)
    80002454:	fce7ece3          	bltu	a5,a4,8000242c <sys_sleep+0x52>
  }
  release(&tickslock);
    80002458:	0002c517          	auipc	a0,0x2c
    8000245c:	31050513          	add	a0,a0,784 # 8002e768 <tickslock>
    80002460:	00004097          	auipc	ra,0x4
    80002464:	f82080e7          	jalr	-126(ra) # 800063e2 <release>
  return 0;
    80002468:	4501                	li	a0,0
}
    8000246a:	70e2                	ld	ra,56(sp)
    8000246c:	7442                	ld	s0,48(sp)
    8000246e:	74a2                	ld	s1,40(sp)
    80002470:	7902                	ld	s2,32(sp)
    80002472:	69e2                	ld	s3,24(sp)
    80002474:	6121                	add	sp,sp,64
    80002476:	8082                	ret
    n = 0;
    80002478:	fc042623          	sw	zero,-52(s0)
    8000247c:	b749                	j	800023fe <sys_sleep+0x24>
      release(&tickslock);
    8000247e:	0002c517          	auipc	a0,0x2c
    80002482:	2ea50513          	add	a0,a0,746 # 8002e768 <tickslock>
    80002486:	00004097          	auipc	ra,0x4
    8000248a:	f5c080e7          	jalr	-164(ra) # 800063e2 <release>
      return -1;
    8000248e:	557d                	li	a0,-1
    80002490:	bfe9                	j	8000246a <sys_sleep+0x90>

0000000080002492 <sys_kill>:

uint64
sys_kill(void)
{
    80002492:	1101                	add	sp,sp,-32
    80002494:	ec06                	sd	ra,24(sp)
    80002496:	e822                	sd	s0,16(sp)
    80002498:	1000                	add	s0,sp,32
  int pid;

  argint(0, &pid);
    8000249a:	fec40593          	add	a1,s0,-20
    8000249e:	4501                	li	a0,0
    800024a0:	00000097          	auipc	ra,0x0
    800024a4:	d8c080e7          	jalr	-628(ra) # 8000222c <argint>
  return kill(pid);
    800024a8:	fec42503          	lw	a0,-20(s0)
    800024ac:	fffff097          	auipc	ra,0xfffff
    800024b0:	4ee080e7          	jalr	1262(ra) # 8000199a <kill>
}
    800024b4:	60e2                	ld	ra,24(sp)
    800024b6:	6442                	ld	s0,16(sp)
    800024b8:	6105                	add	sp,sp,32
    800024ba:	8082                	ret

00000000800024bc <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    800024bc:	1101                	add	sp,sp,-32
    800024be:	ec06                	sd	ra,24(sp)
    800024c0:	e822                	sd	s0,16(sp)
    800024c2:	e426                	sd	s1,8(sp)
    800024c4:	1000                	add	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    800024c6:	0002c517          	auipc	a0,0x2c
    800024ca:	2a250513          	add	a0,a0,674 # 8002e768 <tickslock>
    800024ce:	00004097          	auipc	ra,0x4
    800024d2:	e60080e7          	jalr	-416(ra) # 8000632e <acquire>
  xticks = ticks;
    800024d6:	00006497          	auipc	s1,0x6
    800024da:	4124a483          	lw	s1,1042(s1) # 800088e8 <ticks>
  release(&tickslock);
    800024de:	0002c517          	auipc	a0,0x2c
    800024e2:	28a50513          	add	a0,a0,650 # 8002e768 <tickslock>
    800024e6:	00004097          	auipc	ra,0x4
    800024ea:	efc080e7          	jalr	-260(ra) # 800063e2 <release>
  return xticks;
}
    800024ee:	02049513          	sll	a0,s1,0x20
    800024f2:	9101                	srl	a0,a0,0x20
    800024f4:	60e2                	ld	ra,24(sp)
    800024f6:	6442                	ld	s0,16(sp)
    800024f8:	64a2                	ld	s1,8(sp)
    800024fa:	6105                	add	sp,sp,32
    800024fc:	8082                	ret

00000000800024fe <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    800024fe:	7179                	add	sp,sp,-48
    80002500:	f406                	sd	ra,40(sp)
    80002502:	f022                	sd	s0,32(sp)
    80002504:	ec26                	sd	s1,24(sp)
    80002506:	e84a                	sd	s2,16(sp)
    80002508:	e44e                	sd	s3,8(sp)
    8000250a:	e052                	sd	s4,0(sp)
    8000250c:	1800                	add	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    8000250e:	00006597          	auipc	a1,0x6
    80002512:	faa58593          	add	a1,a1,-86 # 800084b8 <syscalls+0xb0>
    80002516:	0002c517          	auipc	a0,0x2c
    8000251a:	26a50513          	add	a0,a0,618 # 8002e780 <bcache>
    8000251e:	00004097          	auipc	ra,0x4
    80002522:	d80080e7          	jalr	-640(ra) # 8000629e <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80002526:	00034797          	auipc	a5,0x34
    8000252a:	25a78793          	add	a5,a5,602 # 80036780 <bcache+0x8000>
    8000252e:	00034717          	auipc	a4,0x34
    80002532:	4ba70713          	add	a4,a4,1210 # 800369e8 <bcache+0x8268>
    80002536:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    8000253a:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    8000253e:	0002c497          	auipc	s1,0x2c
    80002542:	25a48493          	add	s1,s1,602 # 8002e798 <bcache+0x18>
    b->next = bcache.head.next;
    80002546:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80002548:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    8000254a:	00006a17          	auipc	s4,0x6
    8000254e:	f76a0a13          	add	s4,s4,-138 # 800084c0 <syscalls+0xb8>
    b->next = bcache.head.next;
    80002552:	2b893783          	ld	a5,696(s2)
    80002556:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80002558:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    8000255c:	85d2                	mv	a1,s4
    8000255e:	01048513          	add	a0,s1,16
    80002562:	00001097          	auipc	ra,0x1
    80002566:	496080e7          	jalr	1174(ra) # 800039f8 <initsleeplock>
    bcache.head.next->prev = b;
    8000256a:	2b893783          	ld	a5,696(s2)
    8000256e:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80002570:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002574:	45848493          	add	s1,s1,1112
    80002578:	fd349de3          	bne	s1,s3,80002552 <binit+0x54>
  }
}
    8000257c:	70a2                	ld	ra,40(sp)
    8000257e:	7402                	ld	s0,32(sp)
    80002580:	64e2                	ld	s1,24(sp)
    80002582:	6942                	ld	s2,16(sp)
    80002584:	69a2                	ld	s3,8(sp)
    80002586:	6a02                	ld	s4,0(sp)
    80002588:	6145                	add	sp,sp,48
    8000258a:	8082                	ret

000000008000258c <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    8000258c:	7179                	add	sp,sp,-48
    8000258e:	f406                	sd	ra,40(sp)
    80002590:	f022                	sd	s0,32(sp)
    80002592:	ec26                	sd	s1,24(sp)
    80002594:	e84a                	sd	s2,16(sp)
    80002596:	e44e                	sd	s3,8(sp)
    80002598:	1800                	add	s0,sp,48
    8000259a:	892a                	mv	s2,a0
    8000259c:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    8000259e:	0002c517          	auipc	a0,0x2c
    800025a2:	1e250513          	add	a0,a0,482 # 8002e780 <bcache>
    800025a6:	00004097          	auipc	ra,0x4
    800025aa:	d88080e7          	jalr	-632(ra) # 8000632e <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    800025ae:	00034497          	auipc	s1,0x34
    800025b2:	48a4b483          	ld	s1,1162(s1) # 80036a38 <bcache+0x82b8>
    800025b6:	00034797          	auipc	a5,0x34
    800025ba:	43278793          	add	a5,a5,1074 # 800369e8 <bcache+0x8268>
    800025be:	02f48f63          	beq	s1,a5,800025fc <bread+0x70>
    800025c2:	873e                	mv	a4,a5
    800025c4:	a021                	j	800025cc <bread+0x40>
    800025c6:	68a4                	ld	s1,80(s1)
    800025c8:	02e48a63          	beq	s1,a4,800025fc <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    800025cc:	449c                	lw	a5,8(s1)
    800025ce:	ff279ce3          	bne	a5,s2,800025c6 <bread+0x3a>
    800025d2:	44dc                	lw	a5,12(s1)
    800025d4:	ff3799e3          	bne	a5,s3,800025c6 <bread+0x3a>
      b->refcnt++;
    800025d8:	40bc                	lw	a5,64(s1)
    800025da:	2785                	addw	a5,a5,1
    800025dc:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800025de:	0002c517          	auipc	a0,0x2c
    800025e2:	1a250513          	add	a0,a0,418 # 8002e780 <bcache>
    800025e6:	00004097          	auipc	ra,0x4
    800025ea:	dfc080e7          	jalr	-516(ra) # 800063e2 <release>
      acquiresleep(&b->lock);
    800025ee:	01048513          	add	a0,s1,16
    800025f2:	00001097          	auipc	ra,0x1
    800025f6:	440080e7          	jalr	1088(ra) # 80003a32 <acquiresleep>
      return b;
    800025fa:	a8b9                	j	80002658 <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800025fc:	00034497          	auipc	s1,0x34
    80002600:	4344b483          	ld	s1,1076(s1) # 80036a30 <bcache+0x82b0>
    80002604:	00034797          	auipc	a5,0x34
    80002608:	3e478793          	add	a5,a5,996 # 800369e8 <bcache+0x8268>
    8000260c:	00f48863          	beq	s1,a5,8000261c <bread+0x90>
    80002610:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    80002612:	40bc                	lw	a5,64(s1)
    80002614:	cf81                	beqz	a5,8000262c <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002616:	64a4                	ld	s1,72(s1)
    80002618:	fee49de3          	bne	s1,a4,80002612 <bread+0x86>
  panic("bget: no buffers");
    8000261c:	00006517          	auipc	a0,0x6
    80002620:	eac50513          	add	a0,a0,-340 # 800084c8 <syscalls+0xc0>
    80002624:	00003097          	auipc	ra,0x3
    80002628:	7d2080e7          	jalr	2002(ra) # 80005df6 <panic>
      b->dev = dev;
    8000262c:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    80002630:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    80002634:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80002638:	4785                	li	a5,1
    8000263a:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    8000263c:	0002c517          	auipc	a0,0x2c
    80002640:	14450513          	add	a0,a0,324 # 8002e780 <bcache>
    80002644:	00004097          	auipc	ra,0x4
    80002648:	d9e080e7          	jalr	-610(ra) # 800063e2 <release>
      acquiresleep(&b->lock);
    8000264c:	01048513          	add	a0,s1,16
    80002650:	00001097          	auipc	ra,0x1
    80002654:	3e2080e7          	jalr	994(ra) # 80003a32 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80002658:	409c                	lw	a5,0(s1)
    8000265a:	cb89                	beqz	a5,8000266c <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    8000265c:	8526                	mv	a0,s1
    8000265e:	70a2                	ld	ra,40(sp)
    80002660:	7402                	ld	s0,32(sp)
    80002662:	64e2                	ld	s1,24(sp)
    80002664:	6942                	ld	s2,16(sp)
    80002666:	69a2                	ld	s3,8(sp)
    80002668:	6145                	add	sp,sp,48
    8000266a:	8082                	ret
    virtio_disk_rw(b, 0);
    8000266c:	4581                	li	a1,0
    8000266e:	8526                	mv	a0,s1
    80002670:	00003097          	auipc	ra,0x3
    80002674:	f82080e7          	jalr	-126(ra) # 800055f2 <virtio_disk_rw>
    b->valid = 1;
    80002678:	4785                	li	a5,1
    8000267a:	c09c                	sw	a5,0(s1)
  return b;
    8000267c:	b7c5                	j	8000265c <bread+0xd0>

000000008000267e <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    8000267e:	1101                	add	sp,sp,-32
    80002680:	ec06                	sd	ra,24(sp)
    80002682:	e822                	sd	s0,16(sp)
    80002684:	e426                	sd	s1,8(sp)
    80002686:	1000                	add	s0,sp,32
    80002688:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    8000268a:	0541                	add	a0,a0,16
    8000268c:	00001097          	auipc	ra,0x1
    80002690:	440080e7          	jalr	1088(ra) # 80003acc <holdingsleep>
    80002694:	cd01                	beqz	a0,800026ac <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80002696:	4585                	li	a1,1
    80002698:	8526                	mv	a0,s1
    8000269a:	00003097          	auipc	ra,0x3
    8000269e:	f58080e7          	jalr	-168(ra) # 800055f2 <virtio_disk_rw>
}
    800026a2:	60e2                	ld	ra,24(sp)
    800026a4:	6442                	ld	s0,16(sp)
    800026a6:	64a2                	ld	s1,8(sp)
    800026a8:	6105                	add	sp,sp,32
    800026aa:	8082                	ret
    panic("bwrite");
    800026ac:	00006517          	auipc	a0,0x6
    800026b0:	e3450513          	add	a0,a0,-460 # 800084e0 <syscalls+0xd8>
    800026b4:	00003097          	auipc	ra,0x3
    800026b8:	742080e7          	jalr	1858(ra) # 80005df6 <panic>

00000000800026bc <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    800026bc:	1101                	add	sp,sp,-32
    800026be:	ec06                	sd	ra,24(sp)
    800026c0:	e822                	sd	s0,16(sp)
    800026c2:	e426                	sd	s1,8(sp)
    800026c4:	e04a                	sd	s2,0(sp)
    800026c6:	1000                	add	s0,sp,32
    800026c8:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800026ca:	01050913          	add	s2,a0,16
    800026ce:	854a                	mv	a0,s2
    800026d0:	00001097          	auipc	ra,0x1
    800026d4:	3fc080e7          	jalr	1020(ra) # 80003acc <holdingsleep>
    800026d8:	c925                	beqz	a0,80002748 <brelse+0x8c>
    panic("brelse");

  releasesleep(&b->lock);
    800026da:	854a                	mv	a0,s2
    800026dc:	00001097          	auipc	ra,0x1
    800026e0:	3ac080e7          	jalr	940(ra) # 80003a88 <releasesleep>

  acquire(&bcache.lock);
    800026e4:	0002c517          	auipc	a0,0x2c
    800026e8:	09c50513          	add	a0,a0,156 # 8002e780 <bcache>
    800026ec:	00004097          	auipc	ra,0x4
    800026f0:	c42080e7          	jalr	-958(ra) # 8000632e <acquire>
  b->refcnt--;
    800026f4:	40bc                	lw	a5,64(s1)
    800026f6:	37fd                	addw	a5,a5,-1
    800026f8:	0007871b          	sext.w	a4,a5
    800026fc:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    800026fe:	e71d                	bnez	a4,8000272c <brelse+0x70>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80002700:	68b8                	ld	a4,80(s1)
    80002702:	64bc                	ld	a5,72(s1)
    80002704:	e73c                	sd	a5,72(a4)
    b->prev->next = b->next;
    80002706:	68b8                	ld	a4,80(s1)
    80002708:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    8000270a:	00034797          	auipc	a5,0x34
    8000270e:	07678793          	add	a5,a5,118 # 80036780 <bcache+0x8000>
    80002712:	2b87b703          	ld	a4,696(a5)
    80002716:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    80002718:	00034717          	auipc	a4,0x34
    8000271c:	2d070713          	add	a4,a4,720 # 800369e8 <bcache+0x8268>
    80002720:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80002722:	2b87b703          	ld	a4,696(a5)
    80002726:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    80002728:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    8000272c:	0002c517          	auipc	a0,0x2c
    80002730:	05450513          	add	a0,a0,84 # 8002e780 <bcache>
    80002734:	00004097          	auipc	ra,0x4
    80002738:	cae080e7          	jalr	-850(ra) # 800063e2 <release>
}
    8000273c:	60e2                	ld	ra,24(sp)
    8000273e:	6442                	ld	s0,16(sp)
    80002740:	64a2                	ld	s1,8(sp)
    80002742:	6902                	ld	s2,0(sp)
    80002744:	6105                	add	sp,sp,32
    80002746:	8082                	ret
    panic("brelse");
    80002748:	00006517          	auipc	a0,0x6
    8000274c:	da050513          	add	a0,a0,-608 # 800084e8 <syscalls+0xe0>
    80002750:	00003097          	auipc	ra,0x3
    80002754:	6a6080e7          	jalr	1702(ra) # 80005df6 <panic>

0000000080002758 <bpin>:

void
bpin(struct buf *b) {
    80002758:	1101                	add	sp,sp,-32
    8000275a:	ec06                	sd	ra,24(sp)
    8000275c:	e822                	sd	s0,16(sp)
    8000275e:	e426                	sd	s1,8(sp)
    80002760:	1000                	add	s0,sp,32
    80002762:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002764:	0002c517          	auipc	a0,0x2c
    80002768:	01c50513          	add	a0,a0,28 # 8002e780 <bcache>
    8000276c:	00004097          	auipc	ra,0x4
    80002770:	bc2080e7          	jalr	-1086(ra) # 8000632e <acquire>
  b->refcnt++;
    80002774:	40bc                	lw	a5,64(s1)
    80002776:	2785                	addw	a5,a5,1
    80002778:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8000277a:	0002c517          	auipc	a0,0x2c
    8000277e:	00650513          	add	a0,a0,6 # 8002e780 <bcache>
    80002782:	00004097          	auipc	ra,0x4
    80002786:	c60080e7          	jalr	-928(ra) # 800063e2 <release>
}
    8000278a:	60e2                	ld	ra,24(sp)
    8000278c:	6442                	ld	s0,16(sp)
    8000278e:	64a2                	ld	s1,8(sp)
    80002790:	6105                	add	sp,sp,32
    80002792:	8082                	ret

0000000080002794 <bunpin>:

void
bunpin(struct buf *b) {
    80002794:	1101                	add	sp,sp,-32
    80002796:	ec06                	sd	ra,24(sp)
    80002798:	e822                	sd	s0,16(sp)
    8000279a:	e426                	sd	s1,8(sp)
    8000279c:	1000                	add	s0,sp,32
    8000279e:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800027a0:	0002c517          	auipc	a0,0x2c
    800027a4:	fe050513          	add	a0,a0,-32 # 8002e780 <bcache>
    800027a8:	00004097          	auipc	ra,0x4
    800027ac:	b86080e7          	jalr	-1146(ra) # 8000632e <acquire>
  b->refcnt--;
    800027b0:	40bc                	lw	a5,64(s1)
    800027b2:	37fd                	addw	a5,a5,-1
    800027b4:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800027b6:	0002c517          	auipc	a0,0x2c
    800027ba:	fca50513          	add	a0,a0,-54 # 8002e780 <bcache>
    800027be:	00004097          	auipc	ra,0x4
    800027c2:	c24080e7          	jalr	-988(ra) # 800063e2 <release>
}
    800027c6:	60e2                	ld	ra,24(sp)
    800027c8:	6442                	ld	s0,16(sp)
    800027ca:	64a2                	ld	s1,8(sp)
    800027cc:	6105                	add	sp,sp,32
    800027ce:	8082                	ret

00000000800027d0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    800027d0:	1101                	add	sp,sp,-32
    800027d2:	ec06                	sd	ra,24(sp)
    800027d4:	e822                	sd	s0,16(sp)
    800027d6:	e426                	sd	s1,8(sp)
    800027d8:	e04a                	sd	s2,0(sp)
    800027da:	1000                	add	s0,sp,32
    800027dc:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    800027de:	00d5d59b          	srlw	a1,a1,0xd
    800027e2:	00034797          	auipc	a5,0x34
    800027e6:	67a7a783          	lw	a5,1658(a5) # 80036e5c <sb+0x1c>
    800027ea:	9dbd                	addw	a1,a1,a5
    800027ec:	00000097          	auipc	ra,0x0
    800027f0:	da0080e7          	jalr	-608(ra) # 8000258c <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    800027f4:	0074f713          	and	a4,s1,7
    800027f8:	4785                	li	a5,1
    800027fa:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    800027fe:	14ce                	sll	s1,s1,0x33
    80002800:	90d9                	srl	s1,s1,0x36
    80002802:	00950733          	add	a4,a0,s1
    80002806:	05874703          	lbu	a4,88(a4)
    8000280a:	00e7f6b3          	and	a3,a5,a4
    8000280e:	c69d                	beqz	a3,8000283c <bfree+0x6c>
    80002810:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    80002812:	94aa                	add	s1,s1,a0
    80002814:	fff7c793          	not	a5,a5
    80002818:	8f7d                	and	a4,a4,a5
    8000281a:	04e48c23          	sb	a4,88(s1)
  log_write(bp);
    8000281e:	00001097          	auipc	ra,0x1
    80002822:	0f6080e7          	jalr	246(ra) # 80003914 <log_write>
  brelse(bp);
    80002826:	854a                	mv	a0,s2
    80002828:	00000097          	auipc	ra,0x0
    8000282c:	e94080e7          	jalr	-364(ra) # 800026bc <brelse>
}
    80002830:	60e2                	ld	ra,24(sp)
    80002832:	6442                	ld	s0,16(sp)
    80002834:	64a2                	ld	s1,8(sp)
    80002836:	6902                	ld	s2,0(sp)
    80002838:	6105                	add	sp,sp,32
    8000283a:	8082                	ret
    panic("freeing free block");
    8000283c:	00006517          	auipc	a0,0x6
    80002840:	cb450513          	add	a0,a0,-844 # 800084f0 <syscalls+0xe8>
    80002844:	00003097          	auipc	ra,0x3
    80002848:	5b2080e7          	jalr	1458(ra) # 80005df6 <panic>

000000008000284c <balloc>:
{
    8000284c:	711d                	add	sp,sp,-96
    8000284e:	ec86                	sd	ra,88(sp)
    80002850:	e8a2                	sd	s0,80(sp)
    80002852:	e4a6                	sd	s1,72(sp)
    80002854:	e0ca                	sd	s2,64(sp)
    80002856:	fc4e                	sd	s3,56(sp)
    80002858:	f852                	sd	s4,48(sp)
    8000285a:	f456                	sd	s5,40(sp)
    8000285c:	f05a                	sd	s6,32(sp)
    8000285e:	ec5e                	sd	s7,24(sp)
    80002860:	e862                	sd	s8,16(sp)
    80002862:	e466                	sd	s9,8(sp)
    80002864:	1080                	add	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80002866:	00034797          	auipc	a5,0x34
    8000286a:	5de7a783          	lw	a5,1502(a5) # 80036e44 <sb+0x4>
    8000286e:	cff5                	beqz	a5,8000296a <balloc+0x11e>
    80002870:	8baa                	mv	s7,a0
    80002872:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80002874:	00034b17          	auipc	s6,0x34
    80002878:	5ccb0b13          	add	s6,s6,1484 # 80036e40 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000287c:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    8000287e:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002880:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80002882:	6c89                	lui	s9,0x2
    80002884:	a061                	j	8000290c <balloc+0xc0>
        bp->data[bi/8] |= m;  // Mark block in use.
    80002886:	97ca                	add	a5,a5,s2
    80002888:	8e55                	or	a2,a2,a3
    8000288a:	04c78c23          	sb	a2,88(a5)
        log_write(bp);
    8000288e:	854a                	mv	a0,s2
    80002890:	00001097          	auipc	ra,0x1
    80002894:	084080e7          	jalr	132(ra) # 80003914 <log_write>
        brelse(bp);
    80002898:	854a                	mv	a0,s2
    8000289a:	00000097          	auipc	ra,0x0
    8000289e:	e22080e7          	jalr	-478(ra) # 800026bc <brelse>
  bp = bread(dev, bno);
    800028a2:	85a6                	mv	a1,s1
    800028a4:	855e                	mv	a0,s7
    800028a6:	00000097          	auipc	ra,0x0
    800028aa:	ce6080e7          	jalr	-794(ra) # 8000258c <bread>
    800028ae:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    800028b0:	40000613          	li	a2,1024
    800028b4:	4581                	li	a1,0
    800028b6:	05850513          	add	a0,a0,88
    800028ba:	ffffe097          	auipc	ra,0xffffe
    800028be:	a4a080e7          	jalr	-1462(ra) # 80000304 <memset>
  log_write(bp);
    800028c2:	854a                	mv	a0,s2
    800028c4:	00001097          	auipc	ra,0x1
    800028c8:	050080e7          	jalr	80(ra) # 80003914 <log_write>
  brelse(bp);
    800028cc:	854a                	mv	a0,s2
    800028ce:	00000097          	auipc	ra,0x0
    800028d2:	dee080e7          	jalr	-530(ra) # 800026bc <brelse>
}
    800028d6:	8526                	mv	a0,s1
    800028d8:	60e6                	ld	ra,88(sp)
    800028da:	6446                	ld	s0,80(sp)
    800028dc:	64a6                	ld	s1,72(sp)
    800028de:	6906                	ld	s2,64(sp)
    800028e0:	79e2                	ld	s3,56(sp)
    800028e2:	7a42                	ld	s4,48(sp)
    800028e4:	7aa2                	ld	s5,40(sp)
    800028e6:	7b02                	ld	s6,32(sp)
    800028e8:	6be2                	ld	s7,24(sp)
    800028ea:	6c42                	ld	s8,16(sp)
    800028ec:	6ca2                	ld	s9,8(sp)
    800028ee:	6125                	add	sp,sp,96
    800028f0:	8082                	ret
    brelse(bp);
    800028f2:	854a                	mv	a0,s2
    800028f4:	00000097          	auipc	ra,0x0
    800028f8:	dc8080e7          	jalr	-568(ra) # 800026bc <brelse>
  for(b = 0; b < sb.size; b += BPB){
    800028fc:	015c87bb          	addw	a5,s9,s5
    80002900:	00078a9b          	sext.w	s5,a5
    80002904:	004b2703          	lw	a4,4(s6)
    80002908:	06eaf163          	bgeu	s5,a4,8000296a <balloc+0x11e>
    bp = bread(dev, BBLOCK(b, sb));
    8000290c:	41fad79b          	sraw	a5,s5,0x1f
    80002910:	0137d79b          	srlw	a5,a5,0x13
    80002914:	015787bb          	addw	a5,a5,s5
    80002918:	40d7d79b          	sraw	a5,a5,0xd
    8000291c:	01cb2583          	lw	a1,28(s6)
    80002920:	9dbd                	addw	a1,a1,a5
    80002922:	855e                	mv	a0,s7
    80002924:	00000097          	auipc	ra,0x0
    80002928:	c68080e7          	jalr	-920(ra) # 8000258c <bread>
    8000292c:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000292e:	004b2503          	lw	a0,4(s6)
    80002932:	000a849b          	sext.w	s1,s5
    80002936:	8762                	mv	a4,s8
    80002938:	faa4fde3          	bgeu	s1,a0,800028f2 <balloc+0xa6>
      m = 1 << (bi % 8);
    8000293c:	00777693          	and	a3,a4,7
    80002940:	00d996bb          	sllw	a3,s3,a3
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80002944:	41f7579b          	sraw	a5,a4,0x1f
    80002948:	01d7d79b          	srlw	a5,a5,0x1d
    8000294c:	9fb9                	addw	a5,a5,a4
    8000294e:	4037d79b          	sraw	a5,a5,0x3
    80002952:	00f90633          	add	a2,s2,a5
    80002956:	05864603          	lbu	a2,88(a2)
    8000295a:	00c6f5b3          	and	a1,a3,a2
    8000295e:	d585                	beqz	a1,80002886 <balloc+0x3a>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002960:	2705                	addw	a4,a4,1
    80002962:	2485                	addw	s1,s1,1
    80002964:	fd471ae3          	bne	a4,s4,80002938 <balloc+0xec>
    80002968:	b769                	j	800028f2 <balloc+0xa6>
  printf("balloc: out of blocks\n");
    8000296a:	00006517          	auipc	a0,0x6
    8000296e:	b9e50513          	add	a0,a0,-1122 # 80008508 <syscalls+0x100>
    80002972:	00003097          	auipc	ra,0x3
    80002976:	4ce080e7          	jalr	1230(ra) # 80005e40 <printf>
  return 0;
    8000297a:	4481                	li	s1,0
    8000297c:	bfa9                	j	800028d6 <balloc+0x8a>

000000008000297e <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    8000297e:	7179                	add	sp,sp,-48
    80002980:	f406                	sd	ra,40(sp)
    80002982:	f022                	sd	s0,32(sp)
    80002984:	ec26                	sd	s1,24(sp)
    80002986:	e84a                	sd	s2,16(sp)
    80002988:	e44e                	sd	s3,8(sp)
    8000298a:	e052                	sd	s4,0(sp)
    8000298c:	1800                	add	s0,sp,48
    8000298e:	89aa                	mv	s3,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80002990:	47ad                	li	a5,11
    80002992:	02b7e863          	bltu	a5,a1,800029c2 <bmap+0x44>
    if((addr = ip->addrs[bn]) == 0){
    80002996:	02059793          	sll	a5,a1,0x20
    8000299a:	01e7d593          	srl	a1,a5,0x1e
    8000299e:	00b504b3          	add	s1,a0,a1
    800029a2:	0504a903          	lw	s2,80(s1)
    800029a6:	06091e63          	bnez	s2,80002a22 <bmap+0xa4>
      addr = balloc(ip->dev);
    800029aa:	4108                	lw	a0,0(a0)
    800029ac:	00000097          	auipc	ra,0x0
    800029b0:	ea0080e7          	jalr	-352(ra) # 8000284c <balloc>
    800029b4:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    800029b8:	06090563          	beqz	s2,80002a22 <bmap+0xa4>
        return 0;
      ip->addrs[bn] = addr;
    800029bc:	0524a823          	sw	s2,80(s1)
    800029c0:	a08d                	j	80002a22 <bmap+0xa4>
    }
    return addr;
  }
  bn -= NDIRECT;
    800029c2:	ff45849b          	addw	s1,a1,-12
    800029c6:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    800029ca:	0ff00793          	li	a5,255
    800029ce:	08e7e563          	bltu	a5,a4,80002a58 <bmap+0xda>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    800029d2:	08052903          	lw	s2,128(a0)
    800029d6:	00091d63          	bnez	s2,800029f0 <bmap+0x72>
      addr = balloc(ip->dev);
    800029da:	4108                	lw	a0,0(a0)
    800029dc:	00000097          	auipc	ra,0x0
    800029e0:	e70080e7          	jalr	-400(ra) # 8000284c <balloc>
    800029e4:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    800029e8:	02090d63          	beqz	s2,80002a22 <bmap+0xa4>
        return 0;
      ip->addrs[NDIRECT] = addr;
    800029ec:	0929a023          	sw	s2,128(s3)
    }
    bp = bread(ip->dev, addr);
    800029f0:	85ca                	mv	a1,s2
    800029f2:	0009a503          	lw	a0,0(s3)
    800029f6:	00000097          	auipc	ra,0x0
    800029fa:	b96080e7          	jalr	-1130(ra) # 8000258c <bread>
    800029fe:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80002a00:	05850793          	add	a5,a0,88
    if((addr = a[bn]) == 0){
    80002a04:	02049713          	sll	a4,s1,0x20
    80002a08:	01e75593          	srl	a1,a4,0x1e
    80002a0c:	00b784b3          	add	s1,a5,a1
    80002a10:	0004a903          	lw	s2,0(s1)
    80002a14:	02090063          	beqz	s2,80002a34 <bmap+0xb6>
      if(addr){
        a[bn] = addr;
        log_write(bp);
      }
    }
    brelse(bp);
    80002a18:	8552                	mv	a0,s4
    80002a1a:	00000097          	auipc	ra,0x0
    80002a1e:	ca2080e7          	jalr	-862(ra) # 800026bc <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    80002a22:	854a                	mv	a0,s2
    80002a24:	70a2                	ld	ra,40(sp)
    80002a26:	7402                	ld	s0,32(sp)
    80002a28:	64e2                	ld	s1,24(sp)
    80002a2a:	6942                	ld	s2,16(sp)
    80002a2c:	69a2                	ld	s3,8(sp)
    80002a2e:	6a02                	ld	s4,0(sp)
    80002a30:	6145                	add	sp,sp,48
    80002a32:	8082                	ret
      addr = balloc(ip->dev);
    80002a34:	0009a503          	lw	a0,0(s3)
    80002a38:	00000097          	auipc	ra,0x0
    80002a3c:	e14080e7          	jalr	-492(ra) # 8000284c <balloc>
    80002a40:	0005091b          	sext.w	s2,a0
      if(addr){
    80002a44:	fc090ae3          	beqz	s2,80002a18 <bmap+0x9a>
        a[bn] = addr;
    80002a48:	0124a023          	sw	s2,0(s1)
        log_write(bp);
    80002a4c:	8552                	mv	a0,s4
    80002a4e:	00001097          	auipc	ra,0x1
    80002a52:	ec6080e7          	jalr	-314(ra) # 80003914 <log_write>
    80002a56:	b7c9                	j	80002a18 <bmap+0x9a>
  panic("bmap: out of range");
    80002a58:	00006517          	auipc	a0,0x6
    80002a5c:	ac850513          	add	a0,a0,-1336 # 80008520 <syscalls+0x118>
    80002a60:	00003097          	auipc	ra,0x3
    80002a64:	396080e7          	jalr	918(ra) # 80005df6 <panic>

0000000080002a68 <iget>:
{
    80002a68:	7179                	add	sp,sp,-48
    80002a6a:	f406                	sd	ra,40(sp)
    80002a6c:	f022                	sd	s0,32(sp)
    80002a6e:	ec26                	sd	s1,24(sp)
    80002a70:	e84a                	sd	s2,16(sp)
    80002a72:	e44e                	sd	s3,8(sp)
    80002a74:	e052                	sd	s4,0(sp)
    80002a76:	1800                	add	s0,sp,48
    80002a78:	89aa                	mv	s3,a0
    80002a7a:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    80002a7c:	00034517          	auipc	a0,0x34
    80002a80:	3e450513          	add	a0,a0,996 # 80036e60 <itable>
    80002a84:	00004097          	auipc	ra,0x4
    80002a88:	8aa080e7          	jalr	-1878(ra) # 8000632e <acquire>
  empty = 0;
    80002a8c:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002a8e:	00034497          	auipc	s1,0x34
    80002a92:	3ea48493          	add	s1,s1,1002 # 80036e78 <itable+0x18>
    80002a96:	00036697          	auipc	a3,0x36
    80002a9a:	e7268693          	add	a3,a3,-398 # 80038908 <log>
    80002a9e:	a039                	j	80002aac <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002aa0:	02090b63          	beqz	s2,80002ad6 <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002aa4:	08848493          	add	s1,s1,136
    80002aa8:	02d48a63          	beq	s1,a3,80002adc <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80002aac:	449c                	lw	a5,8(s1)
    80002aae:	fef059e3          	blez	a5,80002aa0 <iget+0x38>
    80002ab2:	4098                	lw	a4,0(s1)
    80002ab4:	ff3716e3          	bne	a4,s3,80002aa0 <iget+0x38>
    80002ab8:	40d8                	lw	a4,4(s1)
    80002aba:	ff4713e3          	bne	a4,s4,80002aa0 <iget+0x38>
      ip->ref++;
    80002abe:	2785                	addw	a5,a5,1
    80002ac0:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80002ac2:	00034517          	auipc	a0,0x34
    80002ac6:	39e50513          	add	a0,a0,926 # 80036e60 <itable>
    80002aca:	00004097          	auipc	ra,0x4
    80002ace:	918080e7          	jalr	-1768(ra) # 800063e2 <release>
      return ip;
    80002ad2:	8926                	mv	s2,s1
    80002ad4:	a03d                	j	80002b02 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002ad6:	f7f9                	bnez	a5,80002aa4 <iget+0x3c>
    80002ad8:	8926                	mv	s2,s1
    80002ada:	b7e9                	j	80002aa4 <iget+0x3c>
  if(empty == 0)
    80002adc:	02090c63          	beqz	s2,80002b14 <iget+0xac>
  ip->dev = dev;
    80002ae0:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80002ae4:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    80002ae8:	4785                	li	a5,1
    80002aea:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80002aee:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80002af2:	00034517          	auipc	a0,0x34
    80002af6:	36e50513          	add	a0,a0,878 # 80036e60 <itable>
    80002afa:	00004097          	auipc	ra,0x4
    80002afe:	8e8080e7          	jalr	-1816(ra) # 800063e2 <release>
}
    80002b02:	854a                	mv	a0,s2
    80002b04:	70a2                	ld	ra,40(sp)
    80002b06:	7402                	ld	s0,32(sp)
    80002b08:	64e2                	ld	s1,24(sp)
    80002b0a:	6942                	ld	s2,16(sp)
    80002b0c:	69a2                	ld	s3,8(sp)
    80002b0e:	6a02                	ld	s4,0(sp)
    80002b10:	6145                	add	sp,sp,48
    80002b12:	8082                	ret
    panic("iget: no inodes");
    80002b14:	00006517          	auipc	a0,0x6
    80002b18:	a2450513          	add	a0,a0,-1500 # 80008538 <syscalls+0x130>
    80002b1c:	00003097          	auipc	ra,0x3
    80002b20:	2da080e7          	jalr	730(ra) # 80005df6 <panic>

0000000080002b24 <fsinit>:
fsinit(int dev) {
    80002b24:	7179                	add	sp,sp,-48
    80002b26:	f406                	sd	ra,40(sp)
    80002b28:	f022                	sd	s0,32(sp)
    80002b2a:	ec26                	sd	s1,24(sp)
    80002b2c:	e84a                	sd	s2,16(sp)
    80002b2e:	e44e                	sd	s3,8(sp)
    80002b30:	1800                	add	s0,sp,48
    80002b32:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80002b34:	4585                	li	a1,1
    80002b36:	00000097          	auipc	ra,0x0
    80002b3a:	a56080e7          	jalr	-1450(ra) # 8000258c <bread>
    80002b3e:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80002b40:	00034997          	auipc	s3,0x34
    80002b44:	30098993          	add	s3,s3,768 # 80036e40 <sb>
    80002b48:	02000613          	li	a2,32
    80002b4c:	05850593          	add	a1,a0,88
    80002b50:	854e                	mv	a0,s3
    80002b52:	ffffe097          	auipc	ra,0xffffe
    80002b56:	80e080e7          	jalr	-2034(ra) # 80000360 <memmove>
  brelse(bp);
    80002b5a:	8526                	mv	a0,s1
    80002b5c:	00000097          	auipc	ra,0x0
    80002b60:	b60080e7          	jalr	-1184(ra) # 800026bc <brelse>
  if(sb.magic != FSMAGIC)
    80002b64:	0009a703          	lw	a4,0(s3)
    80002b68:	102037b7          	lui	a5,0x10203
    80002b6c:	04078793          	add	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80002b70:	02f71263          	bne	a4,a5,80002b94 <fsinit+0x70>
  initlog(dev, &sb);
    80002b74:	00034597          	auipc	a1,0x34
    80002b78:	2cc58593          	add	a1,a1,716 # 80036e40 <sb>
    80002b7c:	854a                	mv	a0,s2
    80002b7e:	00001097          	auipc	ra,0x1
    80002b82:	b2c080e7          	jalr	-1236(ra) # 800036aa <initlog>
}
    80002b86:	70a2                	ld	ra,40(sp)
    80002b88:	7402                	ld	s0,32(sp)
    80002b8a:	64e2                	ld	s1,24(sp)
    80002b8c:	6942                	ld	s2,16(sp)
    80002b8e:	69a2                	ld	s3,8(sp)
    80002b90:	6145                	add	sp,sp,48
    80002b92:	8082                	ret
    panic("invalid file system");
    80002b94:	00006517          	auipc	a0,0x6
    80002b98:	9b450513          	add	a0,a0,-1612 # 80008548 <syscalls+0x140>
    80002b9c:	00003097          	auipc	ra,0x3
    80002ba0:	25a080e7          	jalr	602(ra) # 80005df6 <panic>

0000000080002ba4 <iinit>:
{
    80002ba4:	7179                	add	sp,sp,-48
    80002ba6:	f406                	sd	ra,40(sp)
    80002ba8:	f022                	sd	s0,32(sp)
    80002baa:	ec26                	sd	s1,24(sp)
    80002bac:	e84a                	sd	s2,16(sp)
    80002bae:	e44e                	sd	s3,8(sp)
    80002bb0:	1800                	add	s0,sp,48
  initlock(&itable.lock, "itable");
    80002bb2:	00006597          	auipc	a1,0x6
    80002bb6:	9ae58593          	add	a1,a1,-1618 # 80008560 <syscalls+0x158>
    80002bba:	00034517          	auipc	a0,0x34
    80002bbe:	2a650513          	add	a0,a0,678 # 80036e60 <itable>
    80002bc2:	00003097          	auipc	ra,0x3
    80002bc6:	6dc080e7          	jalr	1756(ra) # 8000629e <initlock>
  for(i = 0; i < NINODE; i++) {
    80002bca:	00034497          	auipc	s1,0x34
    80002bce:	2be48493          	add	s1,s1,702 # 80036e88 <itable+0x28>
    80002bd2:	00036997          	auipc	s3,0x36
    80002bd6:	d4698993          	add	s3,s3,-698 # 80038918 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80002bda:	00006917          	auipc	s2,0x6
    80002bde:	98e90913          	add	s2,s2,-1650 # 80008568 <syscalls+0x160>
    80002be2:	85ca                	mv	a1,s2
    80002be4:	8526                	mv	a0,s1
    80002be6:	00001097          	auipc	ra,0x1
    80002bea:	e12080e7          	jalr	-494(ra) # 800039f8 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80002bee:	08848493          	add	s1,s1,136
    80002bf2:	ff3498e3          	bne	s1,s3,80002be2 <iinit+0x3e>
}
    80002bf6:	70a2                	ld	ra,40(sp)
    80002bf8:	7402                	ld	s0,32(sp)
    80002bfa:	64e2                	ld	s1,24(sp)
    80002bfc:	6942                	ld	s2,16(sp)
    80002bfe:	69a2                	ld	s3,8(sp)
    80002c00:	6145                	add	sp,sp,48
    80002c02:	8082                	ret

0000000080002c04 <ialloc>:
{
    80002c04:	7139                	add	sp,sp,-64
    80002c06:	fc06                	sd	ra,56(sp)
    80002c08:	f822                	sd	s0,48(sp)
    80002c0a:	f426                	sd	s1,40(sp)
    80002c0c:	f04a                	sd	s2,32(sp)
    80002c0e:	ec4e                	sd	s3,24(sp)
    80002c10:	e852                	sd	s4,16(sp)
    80002c12:	e456                	sd	s5,8(sp)
    80002c14:	e05a                	sd	s6,0(sp)
    80002c16:	0080                	add	s0,sp,64
  for(inum = 1; inum < sb.ninodes; inum++){
    80002c18:	00034717          	auipc	a4,0x34
    80002c1c:	23472703          	lw	a4,564(a4) # 80036e4c <sb+0xc>
    80002c20:	4785                	li	a5,1
    80002c22:	04e7f863          	bgeu	a5,a4,80002c72 <ialloc+0x6e>
    80002c26:	8aaa                	mv	s5,a0
    80002c28:	8b2e                	mv	s6,a1
    80002c2a:	4905                	li	s2,1
    bp = bread(dev, IBLOCK(inum, sb));
    80002c2c:	00034a17          	auipc	s4,0x34
    80002c30:	214a0a13          	add	s4,s4,532 # 80036e40 <sb>
    80002c34:	00495593          	srl	a1,s2,0x4
    80002c38:	018a2783          	lw	a5,24(s4)
    80002c3c:	9dbd                	addw	a1,a1,a5
    80002c3e:	8556                	mv	a0,s5
    80002c40:	00000097          	auipc	ra,0x0
    80002c44:	94c080e7          	jalr	-1716(ra) # 8000258c <bread>
    80002c48:	84aa                	mv	s1,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002c4a:	05850993          	add	s3,a0,88
    80002c4e:	00f97793          	and	a5,s2,15
    80002c52:	079a                	sll	a5,a5,0x6
    80002c54:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80002c56:	00099783          	lh	a5,0(s3)
    80002c5a:	cf9d                	beqz	a5,80002c98 <ialloc+0x94>
    brelse(bp);
    80002c5c:	00000097          	auipc	ra,0x0
    80002c60:	a60080e7          	jalr	-1440(ra) # 800026bc <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80002c64:	0905                	add	s2,s2,1
    80002c66:	00ca2703          	lw	a4,12(s4)
    80002c6a:	0009079b          	sext.w	a5,s2
    80002c6e:	fce7e3e3          	bltu	a5,a4,80002c34 <ialloc+0x30>
  printf("ialloc: no inodes\n");
    80002c72:	00006517          	auipc	a0,0x6
    80002c76:	8fe50513          	add	a0,a0,-1794 # 80008570 <syscalls+0x168>
    80002c7a:	00003097          	auipc	ra,0x3
    80002c7e:	1c6080e7          	jalr	454(ra) # 80005e40 <printf>
  return 0;
    80002c82:	4501                	li	a0,0
}
    80002c84:	70e2                	ld	ra,56(sp)
    80002c86:	7442                	ld	s0,48(sp)
    80002c88:	74a2                	ld	s1,40(sp)
    80002c8a:	7902                	ld	s2,32(sp)
    80002c8c:	69e2                	ld	s3,24(sp)
    80002c8e:	6a42                	ld	s4,16(sp)
    80002c90:	6aa2                	ld	s5,8(sp)
    80002c92:	6b02                	ld	s6,0(sp)
    80002c94:	6121                	add	sp,sp,64
    80002c96:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    80002c98:	04000613          	li	a2,64
    80002c9c:	4581                	li	a1,0
    80002c9e:	854e                	mv	a0,s3
    80002ca0:	ffffd097          	auipc	ra,0xffffd
    80002ca4:	664080e7          	jalr	1636(ra) # 80000304 <memset>
      dip->type = type;
    80002ca8:	01699023          	sh	s6,0(s3)
      log_write(bp);   // mark it allocated on the disk
    80002cac:	8526                	mv	a0,s1
    80002cae:	00001097          	auipc	ra,0x1
    80002cb2:	c66080e7          	jalr	-922(ra) # 80003914 <log_write>
      brelse(bp);
    80002cb6:	8526                	mv	a0,s1
    80002cb8:	00000097          	auipc	ra,0x0
    80002cbc:	a04080e7          	jalr	-1532(ra) # 800026bc <brelse>
      return iget(dev, inum);
    80002cc0:	0009059b          	sext.w	a1,s2
    80002cc4:	8556                	mv	a0,s5
    80002cc6:	00000097          	auipc	ra,0x0
    80002cca:	da2080e7          	jalr	-606(ra) # 80002a68 <iget>
    80002cce:	bf5d                	j	80002c84 <ialloc+0x80>

0000000080002cd0 <iupdate>:
{
    80002cd0:	1101                	add	sp,sp,-32
    80002cd2:	ec06                	sd	ra,24(sp)
    80002cd4:	e822                	sd	s0,16(sp)
    80002cd6:	e426                	sd	s1,8(sp)
    80002cd8:	e04a                	sd	s2,0(sp)
    80002cda:	1000                	add	s0,sp,32
    80002cdc:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002cde:	415c                	lw	a5,4(a0)
    80002ce0:	0047d79b          	srlw	a5,a5,0x4
    80002ce4:	00034597          	auipc	a1,0x34
    80002ce8:	1745a583          	lw	a1,372(a1) # 80036e58 <sb+0x18>
    80002cec:	9dbd                	addw	a1,a1,a5
    80002cee:	4108                	lw	a0,0(a0)
    80002cf0:	00000097          	auipc	ra,0x0
    80002cf4:	89c080e7          	jalr	-1892(ra) # 8000258c <bread>
    80002cf8:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002cfa:	05850793          	add	a5,a0,88
    80002cfe:	40d8                	lw	a4,4(s1)
    80002d00:	8b3d                	and	a4,a4,15
    80002d02:	071a                	sll	a4,a4,0x6
    80002d04:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    80002d06:	04449703          	lh	a4,68(s1)
    80002d0a:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80002d0e:	04649703          	lh	a4,70(s1)
    80002d12:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80002d16:	04849703          	lh	a4,72(s1)
    80002d1a:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80002d1e:	04a49703          	lh	a4,74(s1)
    80002d22:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80002d26:	44f8                	lw	a4,76(s1)
    80002d28:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002d2a:	03400613          	li	a2,52
    80002d2e:	05048593          	add	a1,s1,80
    80002d32:	00c78513          	add	a0,a5,12
    80002d36:	ffffd097          	auipc	ra,0xffffd
    80002d3a:	62a080e7          	jalr	1578(ra) # 80000360 <memmove>
  log_write(bp);
    80002d3e:	854a                	mv	a0,s2
    80002d40:	00001097          	auipc	ra,0x1
    80002d44:	bd4080e7          	jalr	-1068(ra) # 80003914 <log_write>
  brelse(bp);
    80002d48:	854a                	mv	a0,s2
    80002d4a:	00000097          	auipc	ra,0x0
    80002d4e:	972080e7          	jalr	-1678(ra) # 800026bc <brelse>
}
    80002d52:	60e2                	ld	ra,24(sp)
    80002d54:	6442                	ld	s0,16(sp)
    80002d56:	64a2                	ld	s1,8(sp)
    80002d58:	6902                	ld	s2,0(sp)
    80002d5a:	6105                	add	sp,sp,32
    80002d5c:	8082                	ret

0000000080002d5e <idup>:
{
    80002d5e:	1101                	add	sp,sp,-32
    80002d60:	ec06                	sd	ra,24(sp)
    80002d62:	e822                	sd	s0,16(sp)
    80002d64:	e426                	sd	s1,8(sp)
    80002d66:	1000                	add	s0,sp,32
    80002d68:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002d6a:	00034517          	auipc	a0,0x34
    80002d6e:	0f650513          	add	a0,a0,246 # 80036e60 <itable>
    80002d72:	00003097          	auipc	ra,0x3
    80002d76:	5bc080e7          	jalr	1468(ra) # 8000632e <acquire>
  ip->ref++;
    80002d7a:	449c                	lw	a5,8(s1)
    80002d7c:	2785                	addw	a5,a5,1
    80002d7e:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002d80:	00034517          	auipc	a0,0x34
    80002d84:	0e050513          	add	a0,a0,224 # 80036e60 <itable>
    80002d88:	00003097          	auipc	ra,0x3
    80002d8c:	65a080e7          	jalr	1626(ra) # 800063e2 <release>
}
    80002d90:	8526                	mv	a0,s1
    80002d92:	60e2                	ld	ra,24(sp)
    80002d94:	6442                	ld	s0,16(sp)
    80002d96:	64a2                	ld	s1,8(sp)
    80002d98:	6105                	add	sp,sp,32
    80002d9a:	8082                	ret

0000000080002d9c <ilock>:
{
    80002d9c:	1101                	add	sp,sp,-32
    80002d9e:	ec06                	sd	ra,24(sp)
    80002da0:	e822                	sd	s0,16(sp)
    80002da2:	e426                	sd	s1,8(sp)
    80002da4:	e04a                	sd	s2,0(sp)
    80002da6:	1000                	add	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80002da8:	c115                	beqz	a0,80002dcc <ilock+0x30>
    80002daa:	84aa                	mv	s1,a0
    80002dac:	451c                	lw	a5,8(a0)
    80002dae:	00f05f63          	blez	a5,80002dcc <ilock+0x30>
  acquiresleep(&ip->lock);
    80002db2:	0541                	add	a0,a0,16
    80002db4:	00001097          	auipc	ra,0x1
    80002db8:	c7e080e7          	jalr	-898(ra) # 80003a32 <acquiresleep>
  if(ip->valid == 0){
    80002dbc:	40bc                	lw	a5,64(s1)
    80002dbe:	cf99                	beqz	a5,80002ddc <ilock+0x40>
}
    80002dc0:	60e2                	ld	ra,24(sp)
    80002dc2:	6442                	ld	s0,16(sp)
    80002dc4:	64a2                	ld	s1,8(sp)
    80002dc6:	6902                	ld	s2,0(sp)
    80002dc8:	6105                	add	sp,sp,32
    80002dca:	8082                	ret
    panic("ilock");
    80002dcc:	00005517          	auipc	a0,0x5
    80002dd0:	7bc50513          	add	a0,a0,1980 # 80008588 <syscalls+0x180>
    80002dd4:	00003097          	auipc	ra,0x3
    80002dd8:	022080e7          	jalr	34(ra) # 80005df6 <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002ddc:	40dc                	lw	a5,4(s1)
    80002dde:	0047d79b          	srlw	a5,a5,0x4
    80002de2:	00034597          	auipc	a1,0x34
    80002de6:	0765a583          	lw	a1,118(a1) # 80036e58 <sb+0x18>
    80002dea:	9dbd                	addw	a1,a1,a5
    80002dec:	4088                	lw	a0,0(s1)
    80002dee:	fffff097          	auipc	ra,0xfffff
    80002df2:	79e080e7          	jalr	1950(ra) # 8000258c <bread>
    80002df6:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002df8:	05850593          	add	a1,a0,88
    80002dfc:	40dc                	lw	a5,4(s1)
    80002dfe:	8bbd                	and	a5,a5,15
    80002e00:	079a                	sll	a5,a5,0x6
    80002e02:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80002e04:	00059783          	lh	a5,0(a1)
    80002e08:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80002e0c:	00259783          	lh	a5,2(a1)
    80002e10:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80002e14:	00459783          	lh	a5,4(a1)
    80002e18:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80002e1c:	00659783          	lh	a5,6(a1)
    80002e20:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80002e24:	459c                	lw	a5,8(a1)
    80002e26:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002e28:	03400613          	li	a2,52
    80002e2c:	05b1                	add	a1,a1,12
    80002e2e:	05048513          	add	a0,s1,80
    80002e32:	ffffd097          	auipc	ra,0xffffd
    80002e36:	52e080e7          	jalr	1326(ra) # 80000360 <memmove>
    brelse(bp);
    80002e3a:	854a                	mv	a0,s2
    80002e3c:	00000097          	auipc	ra,0x0
    80002e40:	880080e7          	jalr	-1920(ra) # 800026bc <brelse>
    ip->valid = 1;
    80002e44:	4785                	li	a5,1
    80002e46:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80002e48:	04449783          	lh	a5,68(s1)
    80002e4c:	fbb5                	bnez	a5,80002dc0 <ilock+0x24>
      panic("ilock: no type");
    80002e4e:	00005517          	auipc	a0,0x5
    80002e52:	74250513          	add	a0,a0,1858 # 80008590 <syscalls+0x188>
    80002e56:	00003097          	auipc	ra,0x3
    80002e5a:	fa0080e7          	jalr	-96(ra) # 80005df6 <panic>

0000000080002e5e <iunlock>:
{
    80002e5e:	1101                	add	sp,sp,-32
    80002e60:	ec06                	sd	ra,24(sp)
    80002e62:	e822                	sd	s0,16(sp)
    80002e64:	e426                	sd	s1,8(sp)
    80002e66:	e04a                	sd	s2,0(sp)
    80002e68:	1000                	add	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80002e6a:	c905                	beqz	a0,80002e9a <iunlock+0x3c>
    80002e6c:	84aa                	mv	s1,a0
    80002e6e:	01050913          	add	s2,a0,16
    80002e72:	854a                	mv	a0,s2
    80002e74:	00001097          	auipc	ra,0x1
    80002e78:	c58080e7          	jalr	-936(ra) # 80003acc <holdingsleep>
    80002e7c:	cd19                	beqz	a0,80002e9a <iunlock+0x3c>
    80002e7e:	449c                	lw	a5,8(s1)
    80002e80:	00f05d63          	blez	a5,80002e9a <iunlock+0x3c>
  releasesleep(&ip->lock);
    80002e84:	854a                	mv	a0,s2
    80002e86:	00001097          	auipc	ra,0x1
    80002e8a:	c02080e7          	jalr	-1022(ra) # 80003a88 <releasesleep>
}
    80002e8e:	60e2                	ld	ra,24(sp)
    80002e90:	6442                	ld	s0,16(sp)
    80002e92:	64a2                	ld	s1,8(sp)
    80002e94:	6902                	ld	s2,0(sp)
    80002e96:	6105                	add	sp,sp,32
    80002e98:	8082                	ret
    panic("iunlock");
    80002e9a:	00005517          	auipc	a0,0x5
    80002e9e:	70650513          	add	a0,a0,1798 # 800085a0 <syscalls+0x198>
    80002ea2:	00003097          	auipc	ra,0x3
    80002ea6:	f54080e7          	jalr	-172(ra) # 80005df6 <panic>

0000000080002eaa <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80002eaa:	7179                	add	sp,sp,-48
    80002eac:	f406                	sd	ra,40(sp)
    80002eae:	f022                	sd	s0,32(sp)
    80002eb0:	ec26                	sd	s1,24(sp)
    80002eb2:	e84a                	sd	s2,16(sp)
    80002eb4:	e44e                	sd	s3,8(sp)
    80002eb6:	e052                	sd	s4,0(sp)
    80002eb8:	1800                	add	s0,sp,48
    80002eba:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80002ebc:	05050493          	add	s1,a0,80
    80002ec0:	08050913          	add	s2,a0,128
    80002ec4:	a021                	j	80002ecc <itrunc+0x22>
    80002ec6:	0491                	add	s1,s1,4
    80002ec8:	01248d63          	beq	s1,s2,80002ee2 <itrunc+0x38>
    if(ip->addrs[i]){
    80002ecc:	408c                	lw	a1,0(s1)
    80002ece:	dde5                	beqz	a1,80002ec6 <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    80002ed0:	0009a503          	lw	a0,0(s3)
    80002ed4:	00000097          	auipc	ra,0x0
    80002ed8:	8fc080e7          	jalr	-1796(ra) # 800027d0 <bfree>
      ip->addrs[i] = 0;
    80002edc:	0004a023          	sw	zero,0(s1)
    80002ee0:	b7dd                	j	80002ec6 <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    80002ee2:	0809a583          	lw	a1,128(s3)
    80002ee6:	e185                	bnez	a1,80002f06 <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80002ee8:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80002eec:	854e                	mv	a0,s3
    80002eee:	00000097          	auipc	ra,0x0
    80002ef2:	de2080e7          	jalr	-542(ra) # 80002cd0 <iupdate>
}
    80002ef6:	70a2                	ld	ra,40(sp)
    80002ef8:	7402                	ld	s0,32(sp)
    80002efa:	64e2                	ld	s1,24(sp)
    80002efc:	6942                	ld	s2,16(sp)
    80002efe:	69a2                	ld	s3,8(sp)
    80002f00:	6a02                	ld	s4,0(sp)
    80002f02:	6145                	add	sp,sp,48
    80002f04:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002f06:	0009a503          	lw	a0,0(s3)
    80002f0a:	fffff097          	auipc	ra,0xfffff
    80002f0e:	682080e7          	jalr	1666(ra) # 8000258c <bread>
    80002f12:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80002f14:	05850493          	add	s1,a0,88
    80002f18:	45850913          	add	s2,a0,1112
    80002f1c:	a021                	j	80002f24 <itrunc+0x7a>
    80002f1e:	0491                	add	s1,s1,4
    80002f20:	01248b63          	beq	s1,s2,80002f36 <itrunc+0x8c>
      if(a[j])
    80002f24:	408c                	lw	a1,0(s1)
    80002f26:	dde5                	beqz	a1,80002f1e <itrunc+0x74>
        bfree(ip->dev, a[j]);
    80002f28:	0009a503          	lw	a0,0(s3)
    80002f2c:	00000097          	auipc	ra,0x0
    80002f30:	8a4080e7          	jalr	-1884(ra) # 800027d0 <bfree>
    80002f34:	b7ed                	j	80002f1e <itrunc+0x74>
    brelse(bp);
    80002f36:	8552                	mv	a0,s4
    80002f38:	fffff097          	auipc	ra,0xfffff
    80002f3c:	784080e7          	jalr	1924(ra) # 800026bc <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80002f40:	0809a583          	lw	a1,128(s3)
    80002f44:	0009a503          	lw	a0,0(s3)
    80002f48:	00000097          	auipc	ra,0x0
    80002f4c:	888080e7          	jalr	-1912(ra) # 800027d0 <bfree>
    ip->addrs[NDIRECT] = 0;
    80002f50:	0809a023          	sw	zero,128(s3)
    80002f54:	bf51                	j	80002ee8 <itrunc+0x3e>

0000000080002f56 <iput>:
{
    80002f56:	1101                	add	sp,sp,-32
    80002f58:	ec06                	sd	ra,24(sp)
    80002f5a:	e822                	sd	s0,16(sp)
    80002f5c:	e426                	sd	s1,8(sp)
    80002f5e:	e04a                	sd	s2,0(sp)
    80002f60:	1000                	add	s0,sp,32
    80002f62:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002f64:	00034517          	auipc	a0,0x34
    80002f68:	efc50513          	add	a0,a0,-260 # 80036e60 <itable>
    80002f6c:	00003097          	auipc	ra,0x3
    80002f70:	3c2080e7          	jalr	962(ra) # 8000632e <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002f74:	4498                	lw	a4,8(s1)
    80002f76:	4785                	li	a5,1
    80002f78:	02f70363          	beq	a4,a5,80002f9e <iput+0x48>
  ip->ref--;
    80002f7c:	449c                	lw	a5,8(s1)
    80002f7e:	37fd                	addw	a5,a5,-1
    80002f80:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002f82:	00034517          	auipc	a0,0x34
    80002f86:	ede50513          	add	a0,a0,-290 # 80036e60 <itable>
    80002f8a:	00003097          	auipc	ra,0x3
    80002f8e:	458080e7          	jalr	1112(ra) # 800063e2 <release>
}
    80002f92:	60e2                	ld	ra,24(sp)
    80002f94:	6442                	ld	s0,16(sp)
    80002f96:	64a2                	ld	s1,8(sp)
    80002f98:	6902                	ld	s2,0(sp)
    80002f9a:	6105                	add	sp,sp,32
    80002f9c:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002f9e:	40bc                	lw	a5,64(s1)
    80002fa0:	dff1                	beqz	a5,80002f7c <iput+0x26>
    80002fa2:	04a49783          	lh	a5,74(s1)
    80002fa6:	fbf9                	bnez	a5,80002f7c <iput+0x26>
    acquiresleep(&ip->lock);
    80002fa8:	01048913          	add	s2,s1,16
    80002fac:	854a                	mv	a0,s2
    80002fae:	00001097          	auipc	ra,0x1
    80002fb2:	a84080e7          	jalr	-1404(ra) # 80003a32 <acquiresleep>
    release(&itable.lock);
    80002fb6:	00034517          	auipc	a0,0x34
    80002fba:	eaa50513          	add	a0,a0,-342 # 80036e60 <itable>
    80002fbe:	00003097          	auipc	ra,0x3
    80002fc2:	424080e7          	jalr	1060(ra) # 800063e2 <release>
    itrunc(ip);
    80002fc6:	8526                	mv	a0,s1
    80002fc8:	00000097          	auipc	ra,0x0
    80002fcc:	ee2080e7          	jalr	-286(ra) # 80002eaa <itrunc>
    ip->type = 0;
    80002fd0:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80002fd4:	8526                	mv	a0,s1
    80002fd6:	00000097          	auipc	ra,0x0
    80002fda:	cfa080e7          	jalr	-774(ra) # 80002cd0 <iupdate>
    ip->valid = 0;
    80002fde:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80002fe2:	854a                	mv	a0,s2
    80002fe4:	00001097          	auipc	ra,0x1
    80002fe8:	aa4080e7          	jalr	-1372(ra) # 80003a88 <releasesleep>
    acquire(&itable.lock);
    80002fec:	00034517          	auipc	a0,0x34
    80002ff0:	e7450513          	add	a0,a0,-396 # 80036e60 <itable>
    80002ff4:	00003097          	auipc	ra,0x3
    80002ff8:	33a080e7          	jalr	826(ra) # 8000632e <acquire>
    80002ffc:	b741                	j	80002f7c <iput+0x26>

0000000080002ffe <iunlockput>:
{
    80002ffe:	1101                	add	sp,sp,-32
    80003000:	ec06                	sd	ra,24(sp)
    80003002:	e822                	sd	s0,16(sp)
    80003004:	e426                	sd	s1,8(sp)
    80003006:	1000                	add	s0,sp,32
    80003008:	84aa                	mv	s1,a0
  iunlock(ip);
    8000300a:	00000097          	auipc	ra,0x0
    8000300e:	e54080e7          	jalr	-428(ra) # 80002e5e <iunlock>
  iput(ip);
    80003012:	8526                	mv	a0,s1
    80003014:	00000097          	auipc	ra,0x0
    80003018:	f42080e7          	jalr	-190(ra) # 80002f56 <iput>
}
    8000301c:	60e2                	ld	ra,24(sp)
    8000301e:	6442                	ld	s0,16(sp)
    80003020:	64a2                	ld	s1,8(sp)
    80003022:	6105                	add	sp,sp,32
    80003024:	8082                	ret

0000000080003026 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80003026:	1141                	add	sp,sp,-16
    80003028:	e422                	sd	s0,8(sp)
    8000302a:	0800                	add	s0,sp,16
  st->dev = ip->dev;
    8000302c:	411c                	lw	a5,0(a0)
    8000302e:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80003030:	415c                	lw	a5,4(a0)
    80003032:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80003034:	04451783          	lh	a5,68(a0)
    80003038:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    8000303c:	04a51783          	lh	a5,74(a0)
    80003040:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80003044:	04c56783          	lwu	a5,76(a0)
    80003048:	e99c                	sd	a5,16(a1)
}
    8000304a:	6422                	ld	s0,8(sp)
    8000304c:	0141                	add	sp,sp,16
    8000304e:	8082                	ret

0000000080003050 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003050:	457c                	lw	a5,76(a0)
    80003052:	0ed7e963          	bltu	a5,a3,80003144 <readi+0xf4>
{
    80003056:	7159                	add	sp,sp,-112
    80003058:	f486                	sd	ra,104(sp)
    8000305a:	f0a2                	sd	s0,96(sp)
    8000305c:	eca6                	sd	s1,88(sp)
    8000305e:	e8ca                	sd	s2,80(sp)
    80003060:	e4ce                	sd	s3,72(sp)
    80003062:	e0d2                	sd	s4,64(sp)
    80003064:	fc56                	sd	s5,56(sp)
    80003066:	f85a                	sd	s6,48(sp)
    80003068:	f45e                	sd	s7,40(sp)
    8000306a:	f062                	sd	s8,32(sp)
    8000306c:	ec66                	sd	s9,24(sp)
    8000306e:	e86a                	sd	s10,16(sp)
    80003070:	e46e                	sd	s11,8(sp)
    80003072:	1880                	add	s0,sp,112
    80003074:	8b2a                	mv	s6,a0
    80003076:	8bae                	mv	s7,a1
    80003078:	8a32                	mv	s4,a2
    8000307a:	84b6                	mv	s1,a3
    8000307c:	8aba                	mv	s5,a4
  if(off > ip->size || off + n < off)
    8000307e:	9f35                	addw	a4,a4,a3
    return 0;
    80003080:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80003082:	0ad76063          	bltu	a4,a3,80003122 <readi+0xd2>
  if(off + n > ip->size)
    80003086:	00e7f463          	bgeu	a5,a4,8000308e <readi+0x3e>
    n = ip->size - off;
    8000308a:	40d78abb          	subw	s5,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    8000308e:	0a0a8963          	beqz	s5,80003140 <readi+0xf0>
    80003092:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80003094:	40000c93          	li	s9,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80003098:	5c7d                	li	s8,-1
    8000309a:	a82d                	j	800030d4 <readi+0x84>
    8000309c:	020d1d93          	sll	s11,s10,0x20
    800030a0:	020ddd93          	srl	s11,s11,0x20
    800030a4:	05890613          	add	a2,s2,88
    800030a8:	86ee                	mv	a3,s11
    800030aa:	963a                	add	a2,a2,a4
    800030ac:	85d2                	mv	a1,s4
    800030ae:	855e                	mv	a0,s7
    800030b0:	fffff097          	auipc	ra,0xfffff
    800030b4:	ae8080e7          	jalr	-1304(ra) # 80001b98 <either_copyout>
    800030b8:	05850d63          	beq	a0,s8,80003112 <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    800030bc:	854a                	mv	a0,s2
    800030be:	fffff097          	auipc	ra,0xfffff
    800030c2:	5fe080e7          	jalr	1534(ra) # 800026bc <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800030c6:	013d09bb          	addw	s3,s10,s3
    800030ca:	009d04bb          	addw	s1,s10,s1
    800030ce:	9a6e                	add	s4,s4,s11
    800030d0:	0559f763          	bgeu	s3,s5,8000311e <readi+0xce>
    uint addr = bmap(ip, off/BSIZE);
    800030d4:	00a4d59b          	srlw	a1,s1,0xa
    800030d8:	855a                	mv	a0,s6
    800030da:	00000097          	auipc	ra,0x0
    800030de:	8a4080e7          	jalr	-1884(ra) # 8000297e <bmap>
    800030e2:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    800030e6:	cd85                	beqz	a1,8000311e <readi+0xce>
    bp = bread(ip->dev, addr);
    800030e8:	000b2503          	lw	a0,0(s6)
    800030ec:	fffff097          	auipc	ra,0xfffff
    800030f0:	4a0080e7          	jalr	1184(ra) # 8000258c <bread>
    800030f4:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    800030f6:	3ff4f713          	and	a4,s1,1023
    800030fa:	40ec87bb          	subw	a5,s9,a4
    800030fe:	413a86bb          	subw	a3,s5,s3
    80003102:	8d3e                	mv	s10,a5
    80003104:	2781                	sext.w	a5,a5
    80003106:	0006861b          	sext.w	a2,a3
    8000310a:	f8f679e3          	bgeu	a2,a5,8000309c <readi+0x4c>
    8000310e:	8d36                	mv	s10,a3
    80003110:	b771                	j	8000309c <readi+0x4c>
      brelse(bp);
    80003112:	854a                	mv	a0,s2
    80003114:	fffff097          	auipc	ra,0xfffff
    80003118:	5a8080e7          	jalr	1448(ra) # 800026bc <brelse>
      tot = -1;
    8000311c:	59fd                	li	s3,-1
  }
  return tot;
    8000311e:	0009851b          	sext.w	a0,s3
}
    80003122:	70a6                	ld	ra,104(sp)
    80003124:	7406                	ld	s0,96(sp)
    80003126:	64e6                	ld	s1,88(sp)
    80003128:	6946                	ld	s2,80(sp)
    8000312a:	69a6                	ld	s3,72(sp)
    8000312c:	6a06                	ld	s4,64(sp)
    8000312e:	7ae2                	ld	s5,56(sp)
    80003130:	7b42                	ld	s6,48(sp)
    80003132:	7ba2                	ld	s7,40(sp)
    80003134:	7c02                	ld	s8,32(sp)
    80003136:	6ce2                	ld	s9,24(sp)
    80003138:	6d42                	ld	s10,16(sp)
    8000313a:	6da2                	ld	s11,8(sp)
    8000313c:	6165                	add	sp,sp,112
    8000313e:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003140:	89d6                	mv	s3,s5
    80003142:	bff1                	j	8000311e <readi+0xce>
    return 0;
    80003144:	4501                	li	a0,0
}
    80003146:	8082                	ret

0000000080003148 <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003148:	457c                	lw	a5,76(a0)
    8000314a:	10d7e863          	bltu	a5,a3,8000325a <writei+0x112>
{
    8000314e:	7159                	add	sp,sp,-112
    80003150:	f486                	sd	ra,104(sp)
    80003152:	f0a2                	sd	s0,96(sp)
    80003154:	eca6                	sd	s1,88(sp)
    80003156:	e8ca                	sd	s2,80(sp)
    80003158:	e4ce                	sd	s3,72(sp)
    8000315a:	e0d2                	sd	s4,64(sp)
    8000315c:	fc56                	sd	s5,56(sp)
    8000315e:	f85a                	sd	s6,48(sp)
    80003160:	f45e                	sd	s7,40(sp)
    80003162:	f062                	sd	s8,32(sp)
    80003164:	ec66                	sd	s9,24(sp)
    80003166:	e86a                	sd	s10,16(sp)
    80003168:	e46e                	sd	s11,8(sp)
    8000316a:	1880                	add	s0,sp,112
    8000316c:	8aaa                	mv	s5,a0
    8000316e:	8bae                	mv	s7,a1
    80003170:	8a32                	mv	s4,a2
    80003172:	8936                	mv	s2,a3
    80003174:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80003176:	00e687bb          	addw	a5,a3,a4
    8000317a:	0ed7e263          	bltu	a5,a3,8000325e <writei+0x116>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    8000317e:	00043737          	lui	a4,0x43
    80003182:	0ef76063          	bltu	a4,a5,80003262 <writei+0x11a>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003186:	0c0b0863          	beqz	s6,80003256 <writei+0x10e>
    8000318a:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    8000318c:	40000c93          	li	s9,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80003190:	5c7d                	li	s8,-1
    80003192:	a091                	j	800031d6 <writei+0x8e>
    80003194:	020d1d93          	sll	s11,s10,0x20
    80003198:	020ddd93          	srl	s11,s11,0x20
    8000319c:	05848513          	add	a0,s1,88
    800031a0:	86ee                	mv	a3,s11
    800031a2:	8652                	mv	a2,s4
    800031a4:	85de                	mv	a1,s7
    800031a6:	953a                	add	a0,a0,a4
    800031a8:	fffff097          	auipc	ra,0xfffff
    800031ac:	a46080e7          	jalr	-1466(ra) # 80001bee <either_copyin>
    800031b0:	07850263          	beq	a0,s8,80003214 <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    800031b4:	8526                	mv	a0,s1
    800031b6:	00000097          	auipc	ra,0x0
    800031ba:	75e080e7          	jalr	1886(ra) # 80003914 <log_write>
    brelse(bp);
    800031be:	8526                	mv	a0,s1
    800031c0:	fffff097          	auipc	ra,0xfffff
    800031c4:	4fc080e7          	jalr	1276(ra) # 800026bc <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800031c8:	013d09bb          	addw	s3,s10,s3
    800031cc:	012d093b          	addw	s2,s10,s2
    800031d0:	9a6e                	add	s4,s4,s11
    800031d2:	0569f663          	bgeu	s3,s6,8000321e <writei+0xd6>
    uint addr = bmap(ip, off/BSIZE);
    800031d6:	00a9559b          	srlw	a1,s2,0xa
    800031da:	8556                	mv	a0,s5
    800031dc:	fffff097          	auipc	ra,0xfffff
    800031e0:	7a2080e7          	jalr	1954(ra) # 8000297e <bmap>
    800031e4:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    800031e8:	c99d                	beqz	a1,8000321e <writei+0xd6>
    bp = bread(ip->dev, addr);
    800031ea:	000aa503          	lw	a0,0(s5)
    800031ee:	fffff097          	auipc	ra,0xfffff
    800031f2:	39e080e7          	jalr	926(ra) # 8000258c <bread>
    800031f6:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    800031f8:	3ff97713          	and	a4,s2,1023
    800031fc:	40ec87bb          	subw	a5,s9,a4
    80003200:	413b06bb          	subw	a3,s6,s3
    80003204:	8d3e                	mv	s10,a5
    80003206:	2781                	sext.w	a5,a5
    80003208:	0006861b          	sext.w	a2,a3
    8000320c:	f8f674e3          	bgeu	a2,a5,80003194 <writei+0x4c>
    80003210:	8d36                	mv	s10,a3
    80003212:	b749                	j	80003194 <writei+0x4c>
      brelse(bp);
    80003214:	8526                	mv	a0,s1
    80003216:	fffff097          	auipc	ra,0xfffff
    8000321a:	4a6080e7          	jalr	1190(ra) # 800026bc <brelse>
  }

  if(off > ip->size)
    8000321e:	04caa783          	lw	a5,76(s5)
    80003222:	0127f463          	bgeu	a5,s2,8000322a <writei+0xe2>
    ip->size = off;
    80003226:	052aa623          	sw	s2,76(s5)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    8000322a:	8556                	mv	a0,s5
    8000322c:	00000097          	auipc	ra,0x0
    80003230:	aa4080e7          	jalr	-1372(ra) # 80002cd0 <iupdate>

  return tot;
    80003234:	0009851b          	sext.w	a0,s3
}
    80003238:	70a6                	ld	ra,104(sp)
    8000323a:	7406                	ld	s0,96(sp)
    8000323c:	64e6                	ld	s1,88(sp)
    8000323e:	6946                	ld	s2,80(sp)
    80003240:	69a6                	ld	s3,72(sp)
    80003242:	6a06                	ld	s4,64(sp)
    80003244:	7ae2                	ld	s5,56(sp)
    80003246:	7b42                	ld	s6,48(sp)
    80003248:	7ba2                	ld	s7,40(sp)
    8000324a:	7c02                	ld	s8,32(sp)
    8000324c:	6ce2                	ld	s9,24(sp)
    8000324e:	6d42                	ld	s10,16(sp)
    80003250:	6da2                	ld	s11,8(sp)
    80003252:	6165                	add	sp,sp,112
    80003254:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003256:	89da                	mv	s3,s6
    80003258:	bfc9                	j	8000322a <writei+0xe2>
    return -1;
    8000325a:	557d                	li	a0,-1
}
    8000325c:	8082                	ret
    return -1;
    8000325e:	557d                	li	a0,-1
    80003260:	bfe1                	j	80003238 <writei+0xf0>
    return -1;
    80003262:	557d                	li	a0,-1
    80003264:	bfd1                	j	80003238 <writei+0xf0>

0000000080003266 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80003266:	1141                	add	sp,sp,-16
    80003268:	e406                	sd	ra,8(sp)
    8000326a:	e022                	sd	s0,0(sp)
    8000326c:	0800                	add	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    8000326e:	4639                	li	a2,14
    80003270:	ffffd097          	auipc	ra,0xffffd
    80003274:	164080e7          	jalr	356(ra) # 800003d4 <strncmp>
}
    80003278:	60a2                	ld	ra,8(sp)
    8000327a:	6402                	ld	s0,0(sp)
    8000327c:	0141                	add	sp,sp,16
    8000327e:	8082                	ret

0000000080003280 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80003280:	7139                	add	sp,sp,-64
    80003282:	fc06                	sd	ra,56(sp)
    80003284:	f822                	sd	s0,48(sp)
    80003286:	f426                	sd	s1,40(sp)
    80003288:	f04a                	sd	s2,32(sp)
    8000328a:	ec4e                	sd	s3,24(sp)
    8000328c:	e852                	sd	s4,16(sp)
    8000328e:	0080                	add	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80003290:	04451703          	lh	a4,68(a0)
    80003294:	4785                	li	a5,1
    80003296:	00f71a63          	bne	a4,a5,800032aa <dirlookup+0x2a>
    8000329a:	892a                	mv	s2,a0
    8000329c:	89ae                	mv	s3,a1
    8000329e:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    800032a0:	457c                	lw	a5,76(a0)
    800032a2:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    800032a4:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    800032a6:	e79d                	bnez	a5,800032d4 <dirlookup+0x54>
    800032a8:	a8a5                	j	80003320 <dirlookup+0xa0>
    panic("dirlookup not DIR");
    800032aa:	00005517          	auipc	a0,0x5
    800032ae:	2fe50513          	add	a0,a0,766 # 800085a8 <syscalls+0x1a0>
    800032b2:	00003097          	auipc	ra,0x3
    800032b6:	b44080e7          	jalr	-1212(ra) # 80005df6 <panic>
      panic("dirlookup read");
    800032ba:	00005517          	auipc	a0,0x5
    800032be:	30650513          	add	a0,a0,774 # 800085c0 <syscalls+0x1b8>
    800032c2:	00003097          	auipc	ra,0x3
    800032c6:	b34080e7          	jalr	-1228(ra) # 80005df6 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800032ca:	24c1                	addw	s1,s1,16
    800032cc:	04c92783          	lw	a5,76(s2)
    800032d0:	04f4f763          	bgeu	s1,a5,8000331e <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800032d4:	4741                	li	a4,16
    800032d6:	86a6                	mv	a3,s1
    800032d8:	fc040613          	add	a2,s0,-64
    800032dc:	4581                	li	a1,0
    800032de:	854a                	mv	a0,s2
    800032e0:	00000097          	auipc	ra,0x0
    800032e4:	d70080e7          	jalr	-656(ra) # 80003050 <readi>
    800032e8:	47c1                	li	a5,16
    800032ea:	fcf518e3          	bne	a0,a5,800032ba <dirlookup+0x3a>
    if(de.inum == 0)
    800032ee:	fc045783          	lhu	a5,-64(s0)
    800032f2:	dfe1                	beqz	a5,800032ca <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    800032f4:	fc240593          	add	a1,s0,-62
    800032f8:	854e                	mv	a0,s3
    800032fa:	00000097          	auipc	ra,0x0
    800032fe:	f6c080e7          	jalr	-148(ra) # 80003266 <namecmp>
    80003302:	f561                	bnez	a0,800032ca <dirlookup+0x4a>
      if(poff)
    80003304:	000a0463          	beqz	s4,8000330c <dirlookup+0x8c>
        *poff = off;
    80003308:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    8000330c:	fc045583          	lhu	a1,-64(s0)
    80003310:	00092503          	lw	a0,0(s2)
    80003314:	fffff097          	auipc	ra,0xfffff
    80003318:	754080e7          	jalr	1876(ra) # 80002a68 <iget>
    8000331c:	a011                	j	80003320 <dirlookup+0xa0>
  return 0;
    8000331e:	4501                	li	a0,0
}
    80003320:	70e2                	ld	ra,56(sp)
    80003322:	7442                	ld	s0,48(sp)
    80003324:	74a2                	ld	s1,40(sp)
    80003326:	7902                	ld	s2,32(sp)
    80003328:	69e2                	ld	s3,24(sp)
    8000332a:	6a42                	ld	s4,16(sp)
    8000332c:	6121                	add	sp,sp,64
    8000332e:	8082                	ret

0000000080003330 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80003330:	711d                	add	sp,sp,-96
    80003332:	ec86                	sd	ra,88(sp)
    80003334:	e8a2                	sd	s0,80(sp)
    80003336:	e4a6                	sd	s1,72(sp)
    80003338:	e0ca                	sd	s2,64(sp)
    8000333a:	fc4e                	sd	s3,56(sp)
    8000333c:	f852                	sd	s4,48(sp)
    8000333e:	f456                	sd	s5,40(sp)
    80003340:	f05a                	sd	s6,32(sp)
    80003342:	ec5e                	sd	s7,24(sp)
    80003344:	e862                	sd	s8,16(sp)
    80003346:	e466                	sd	s9,8(sp)
    80003348:	1080                	add	s0,sp,96
    8000334a:	84aa                	mv	s1,a0
    8000334c:	8b2e                	mv	s6,a1
    8000334e:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    80003350:	00054703          	lbu	a4,0(a0)
    80003354:	02f00793          	li	a5,47
    80003358:	02f70263          	beq	a4,a5,8000337c <namex+0x4c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    8000335c:	ffffe097          	auipc	ra,0xffffe
    80003360:	d8c080e7          	jalr	-628(ra) # 800010e8 <myproc>
    80003364:	15053503          	ld	a0,336(a0)
    80003368:	00000097          	auipc	ra,0x0
    8000336c:	9f6080e7          	jalr	-1546(ra) # 80002d5e <idup>
    80003370:	8a2a                	mv	s4,a0
  while(*path == '/')
    80003372:	02f00913          	li	s2,47
  if(len >= DIRSIZ)
    80003376:	4c35                	li	s8,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80003378:	4b85                	li	s7,1
    8000337a:	a875                	j	80003436 <namex+0x106>
    ip = iget(ROOTDEV, ROOTINO);
    8000337c:	4585                	li	a1,1
    8000337e:	4505                	li	a0,1
    80003380:	fffff097          	auipc	ra,0xfffff
    80003384:	6e8080e7          	jalr	1768(ra) # 80002a68 <iget>
    80003388:	8a2a                	mv	s4,a0
    8000338a:	b7e5                	j	80003372 <namex+0x42>
      iunlockput(ip);
    8000338c:	8552                	mv	a0,s4
    8000338e:	00000097          	auipc	ra,0x0
    80003392:	c70080e7          	jalr	-912(ra) # 80002ffe <iunlockput>
      return 0;
    80003396:	4a01                	li	s4,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80003398:	8552                	mv	a0,s4
    8000339a:	60e6                	ld	ra,88(sp)
    8000339c:	6446                	ld	s0,80(sp)
    8000339e:	64a6                	ld	s1,72(sp)
    800033a0:	6906                	ld	s2,64(sp)
    800033a2:	79e2                	ld	s3,56(sp)
    800033a4:	7a42                	ld	s4,48(sp)
    800033a6:	7aa2                	ld	s5,40(sp)
    800033a8:	7b02                	ld	s6,32(sp)
    800033aa:	6be2                	ld	s7,24(sp)
    800033ac:	6c42                	ld	s8,16(sp)
    800033ae:	6ca2                	ld	s9,8(sp)
    800033b0:	6125                	add	sp,sp,96
    800033b2:	8082                	ret
      iunlock(ip);
    800033b4:	8552                	mv	a0,s4
    800033b6:	00000097          	auipc	ra,0x0
    800033ba:	aa8080e7          	jalr	-1368(ra) # 80002e5e <iunlock>
      return ip;
    800033be:	bfe9                	j	80003398 <namex+0x68>
      iunlockput(ip);
    800033c0:	8552                	mv	a0,s4
    800033c2:	00000097          	auipc	ra,0x0
    800033c6:	c3c080e7          	jalr	-964(ra) # 80002ffe <iunlockput>
      return 0;
    800033ca:	8a4e                	mv	s4,s3
    800033cc:	b7f1                	j	80003398 <namex+0x68>
  len = path - s;
    800033ce:	40998633          	sub	a2,s3,s1
    800033d2:	00060c9b          	sext.w	s9,a2
  if(len >= DIRSIZ)
    800033d6:	099c5863          	bge	s8,s9,80003466 <namex+0x136>
    memmove(name, s, DIRSIZ);
    800033da:	4639                	li	a2,14
    800033dc:	85a6                	mv	a1,s1
    800033de:	8556                	mv	a0,s5
    800033e0:	ffffd097          	auipc	ra,0xffffd
    800033e4:	f80080e7          	jalr	-128(ra) # 80000360 <memmove>
    800033e8:	84ce                	mv	s1,s3
  while(*path == '/')
    800033ea:	0004c783          	lbu	a5,0(s1)
    800033ee:	01279763          	bne	a5,s2,800033fc <namex+0xcc>
    path++;
    800033f2:	0485                	add	s1,s1,1
  while(*path == '/')
    800033f4:	0004c783          	lbu	a5,0(s1)
    800033f8:	ff278de3          	beq	a5,s2,800033f2 <namex+0xc2>
    ilock(ip);
    800033fc:	8552                	mv	a0,s4
    800033fe:	00000097          	auipc	ra,0x0
    80003402:	99e080e7          	jalr	-1634(ra) # 80002d9c <ilock>
    if(ip->type != T_DIR){
    80003406:	044a1783          	lh	a5,68(s4)
    8000340a:	f97791e3          	bne	a5,s7,8000338c <namex+0x5c>
    if(nameiparent && *path == '\0'){
    8000340e:	000b0563          	beqz	s6,80003418 <namex+0xe8>
    80003412:	0004c783          	lbu	a5,0(s1)
    80003416:	dfd9                	beqz	a5,800033b4 <namex+0x84>
    if((next = dirlookup(ip, name, 0)) == 0){
    80003418:	4601                	li	a2,0
    8000341a:	85d6                	mv	a1,s5
    8000341c:	8552                	mv	a0,s4
    8000341e:	00000097          	auipc	ra,0x0
    80003422:	e62080e7          	jalr	-414(ra) # 80003280 <dirlookup>
    80003426:	89aa                	mv	s3,a0
    80003428:	dd41                	beqz	a0,800033c0 <namex+0x90>
    iunlockput(ip);
    8000342a:	8552                	mv	a0,s4
    8000342c:	00000097          	auipc	ra,0x0
    80003430:	bd2080e7          	jalr	-1070(ra) # 80002ffe <iunlockput>
    ip = next;
    80003434:	8a4e                	mv	s4,s3
  while(*path == '/')
    80003436:	0004c783          	lbu	a5,0(s1)
    8000343a:	01279763          	bne	a5,s2,80003448 <namex+0x118>
    path++;
    8000343e:	0485                	add	s1,s1,1
  while(*path == '/')
    80003440:	0004c783          	lbu	a5,0(s1)
    80003444:	ff278de3          	beq	a5,s2,8000343e <namex+0x10e>
  if(*path == 0)
    80003448:	cb9d                	beqz	a5,8000347e <namex+0x14e>
  while(*path != '/' && *path != 0)
    8000344a:	0004c783          	lbu	a5,0(s1)
    8000344e:	89a6                	mv	s3,s1
  len = path - s;
    80003450:	4c81                	li	s9,0
    80003452:	4601                	li	a2,0
  while(*path != '/' && *path != 0)
    80003454:	01278963          	beq	a5,s2,80003466 <namex+0x136>
    80003458:	dbbd                	beqz	a5,800033ce <namex+0x9e>
    path++;
    8000345a:	0985                	add	s3,s3,1
  while(*path != '/' && *path != 0)
    8000345c:	0009c783          	lbu	a5,0(s3)
    80003460:	ff279ce3          	bne	a5,s2,80003458 <namex+0x128>
    80003464:	b7ad                	j	800033ce <namex+0x9e>
    memmove(name, s, len);
    80003466:	2601                	sext.w	a2,a2
    80003468:	85a6                	mv	a1,s1
    8000346a:	8556                	mv	a0,s5
    8000346c:	ffffd097          	auipc	ra,0xffffd
    80003470:	ef4080e7          	jalr	-268(ra) # 80000360 <memmove>
    name[len] = 0;
    80003474:	9cd6                	add	s9,s9,s5
    80003476:	000c8023          	sb	zero,0(s9) # 2000 <_entry-0x7fffe000>
    8000347a:	84ce                	mv	s1,s3
    8000347c:	b7bd                	j	800033ea <namex+0xba>
  if(nameiparent){
    8000347e:	f00b0de3          	beqz	s6,80003398 <namex+0x68>
    iput(ip);
    80003482:	8552                	mv	a0,s4
    80003484:	00000097          	auipc	ra,0x0
    80003488:	ad2080e7          	jalr	-1326(ra) # 80002f56 <iput>
    return 0;
    8000348c:	4a01                	li	s4,0
    8000348e:	b729                	j	80003398 <namex+0x68>

0000000080003490 <dirlink>:
{
    80003490:	7139                	add	sp,sp,-64
    80003492:	fc06                	sd	ra,56(sp)
    80003494:	f822                	sd	s0,48(sp)
    80003496:	f426                	sd	s1,40(sp)
    80003498:	f04a                	sd	s2,32(sp)
    8000349a:	ec4e                	sd	s3,24(sp)
    8000349c:	e852                	sd	s4,16(sp)
    8000349e:	0080                	add	s0,sp,64
    800034a0:	892a                	mv	s2,a0
    800034a2:	8a2e                	mv	s4,a1
    800034a4:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    800034a6:	4601                	li	a2,0
    800034a8:	00000097          	auipc	ra,0x0
    800034ac:	dd8080e7          	jalr	-552(ra) # 80003280 <dirlookup>
    800034b0:	e93d                	bnez	a0,80003526 <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800034b2:	04c92483          	lw	s1,76(s2)
    800034b6:	c49d                	beqz	s1,800034e4 <dirlink+0x54>
    800034b8:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800034ba:	4741                	li	a4,16
    800034bc:	86a6                	mv	a3,s1
    800034be:	fc040613          	add	a2,s0,-64
    800034c2:	4581                	li	a1,0
    800034c4:	854a                	mv	a0,s2
    800034c6:	00000097          	auipc	ra,0x0
    800034ca:	b8a080e7          	jalr	-1142(ra) # 80003050 <readi>
    800034ce:	47c1                	li	a5,16
    800034d0:	06f51163          	bne	a0,a5,80003532 <dirlink+0xa2>
    if(de.inum == 0)
    800034d4:	fc045783          	lhu	a5,-64(s0)
    800034d8:	c791                	beqz	a5,800034e4 <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800034da:	24c1                	addw	s1,s1,16
    800034dc:	04c92783          	lw	a5,76(s2)
    800034e0:	fcf4ede3          	bltu	s1,a5,800034ba <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    800034e4:	4639                	li	a2,14
    800034e6:	85d2                	mv	a1,s4
    800034e8:	fc240513          	add	a0,s0,-62
    800034ec:	ffffd097          	auipc	ra,0xffffd
    800034f0:	f24080e7          	jalr	-220(ra) # 80000410 <strncpy>
  de.inum = inum;
    800034f4:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800034f8:	4741                	li	a4,16
    800034fa:	86a6                	mv	a3,s1
    800034fc:	fc040613          	add	a2,s0,-64
    80003500:	4581                	li	a1,0
    80003502:	854a                	mv	a0,s2
    80003504:	00000097          	auipc	ra,0x0
    80003508:	c44080e7          	jalr	-956(ra) # 80003148 <writei>
    8000350c:	1541                	add	a0,a0,-16
    8000350e:	00a03533          	snez	a0,a0
    80003512:	40a00533          	neg	a0,a0
}
    80003516:	70e2                	ld	ra,56(sp)
    80003518:	7442                	ld	s0,48(sp)
    8000351a:	74a2                	ld	s1,40(sp)
    8000351c:	7902                	ld	s2,32(sp)
    8000351e:	69e2                	ld	s3,24(sp)
    80003520:	6a42                	ld	s4,16(sp)
    80003522:	6121                	add	sp,sp,64
    80003524:	8082                	ret
    iput(ip);
    80003526:	00000097          	auipc	ra,0x0
    8000352a:	a30080e7          	jalr	-1488(ra) # 80002f56 <iput>
    return -1;
    8000352e:	557d                	li	a0,-1
    80003530:	b7dd                	j	80003516 <dirlink+0x86>
      panic("dirlink read");
    80003532:	00005517          	auipc	a0,0x5
    80003536:	09e50513          	add	a0,a0,158 # 800085d0 <syscalls+0x1c8>
    8000353a:	00003097          	auipc	ra,0x3
    8000353e:	8bc080e7          	jalr	-1860(ra) # 80005df6 <panic>

0000000080003542 <namei>:

struct inode*
namei(char *path)
{
    80003542:	1101                	add	sp,sp,-32
    80003544:	ec06                	sd	ra,24(sp)
    80003546:	e822                	sd	s0,16(sp)
    80003548:	1000                	add	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    8000354a:	fe040613          	add	a2,s0,-32
    8000354e:	4581                	li	a1,0
    80003550:	00000097          	auipc	ra,0x0
    80003554:	de0080e7          	jalr	-544(ra) # 80003330 <namex>
}
    80003558:	60e2                	ld	ra,24(sp)
    8000355a:	6442                	ld	s0,16(sp)
    8000355c:	6105                	add	sp,sp,32
    8000355e:	8082                	ret

0000000080003560 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80003560:	1141                	add	sp,sp,-16
    80003562:	e406                	sd	ra,8(sp)
    80003564:	e022                	sd	s0,0(sp)
    80003566:	0800                	add	s0,sp,16
    80003568:	862e                	mv	a2,a1
  return namex(path, 1, name);
    8000356a:	4585                	li	a1,1
    8000356c:	00000097          	auipc	ra,0x0
    80003570:	dc4080e7          	jalr	-572(ra) # 80003330 <namex>
}
    80003574:	60a2                	ld	ra,8(sp)
    80003576:	6402                	ld	s0,0(sp)
    80003578:	0141                	add	sp,sp,16
    8000357a:	8082                	ret

000000008000357c <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    8000357c:	1101                	add	sp,sp,-32
    8000357e:	ec06                	sd	ra,24(sp)
    80003580:	e822                	sd	s0,16(sp)
    80003582:	e426                	sd	s1,8(sp)
    80003584:	e04a                	sd	s2,0(sp)
    80003586:	1000                	add	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80003588:	00035917          	auipc	s2,0x35
    8000358c:	38090913          	add	s2,s2,896 # 80038908 <log>
    80003590:	01892583          	lw	a1,24(s2)
    80003594:	02892503          	lw	a0,40(s2)
    80003598:	fffff097          	auipc	ra,0xfffff
    8000359c:	ff4080e7          	jalr	-12(ra) # 8000258c <bread>
    800035a0:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    800035a2:	02c92603          	lw	a2,44(s2)
    800035a6:	cd30                	sw	a2,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    800035a8:	00c05f63          	blez	a2,800035c6 <write_head+0x4a>
    800035ac:	00035717          	auipc	a4,0x35
    800035b0:	38c70713          	add	a4,a4,908 # 80038938 <log+0x30>
    800035b4:	87aa                	mv	a5,a0
    800035b6:	060a                	sll	a2,a2,0x2
    800035b8:	962a                	add	a2,a2,a0
    hb->block[i] = log.lh.block[i];
    800035ba:	4314                	lw	a3,0(a4)
    800035bc:	cff4                	sw	a3,92(a5)
  for (i = 0; i < log.lh.n; i++) {
    800035be:	0711                	add	a4,a4,4
    800035c0:	0791                	add	a5,a5,4
    800035c2:	fec79ce3          	bne	a5,a2,800035ba <write_head+0x3e>
  }
  bwrite(buf);
    800035c6:	8526                	mv	a0,s1
    800035c8:	fffff097          	auipc	ra,0xfffff
    800035cc:	0b6080e7          	jalr	182(ra) # 8000267e <bwrite>
  brelse(buf);
    800035d0:	8526                	mv	a0,s1
    800035d2:	fffff097          	auipc	ra,0xfffff
    800035d6:	0ea080e7          	jalr	234(ra) # 800026bc <brelse>
}
    800035da:	60e2                	ld	ra,24(sp)
    800035dc:	6442                	ld	s0,16(sp)
    800035de:	64a2                	ld	s1,8(sp)
    800035e0:	6902                	ld	s2,0(sp)
    800035e2:	6105                	add	sp,sp,32
    800035e4:	8082                	ret

00000000800035e6 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    800035e6:	00035797          	auipc	a5,0x35
    800035ea:	34e7a783          	lw	a5,846(a5) # 80038934 <log+0x2c>
    800035ee:	0af05d63          	blez	a5,800036a8 <install_trans+0xc2>
{
    800035f2:	7139                	add	sp,sp,-64
    800035f4:	fc06                	sd	ra,56(sp)
    800035f6:	f822                	sd	s0,48(sp)
    800035f8:	f426                	sd	s1,40(sp)
    800035fa:	f04a                	sd	s2,32(sp)
    800035fc:	ec4e                	sd	s3,24(sp)
    800035fe:	e852                	sd	s4,16(sp)
    80003600:	e456                	sd	s5,8(sp)
    80003602:	e05a                	sd	s6,0(sp)
    80003604:	0080                	add	s0,sp,64
    80003606:	8b2a                	mv	s6,a0
    80003608:	00035a97          	auipc	s5,0x35
    8000360c:	330a8a93          	add	s5,s5,816 # 80038938 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003610:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003612:	00035997          	auipc	s3,0x35
    80003616:	2f698993          	add	s3,s3,758 # 80038908 <log>
    8000361a:	a00d                	j	8000363c <install_trans+0x56>
    brelse(lbuf);
    8000361c:	854a                	mv	a0,s2
    8000361e:	fffff097          	auipc	ra,0xfffff
    80003622:	09e080e7          	jalr	158(ra) # 800026bc <brelse>
    brelse(dbuf);
    80003626:	8526                	mv	a0,s1
    80003628:	fffff097          	auipc	ra,0xfffff
    8000362c:	094080e7          	jalr	148(ra) # 800026bc <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003630:	2a05                	addw	s4,s4,1
    80003632:	0a91                	add	s5,s5,4
    80003634:	02c9a783          	lw	a5,44(s3)
    80003638:	04fa5e63          	bge	s4,a5,80003694 <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    8000363c:	0189a583          	lw	a1,24(s3)
    80003640:	014585bb          	addw	a1,a1,s4
    80003644:	2585                	addw	a1,a1,1
    80003646:	0289a503          	lw	a0,40(s3)
    8000364a:	fffff097          	auipc	ra,0xfffff
    8000364e:	f42080e7          	jalr	-190(ra) # 8000258c <bread>
    80003652:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80003654:	000aa583          	lw	a1,0(s5)
    80003658:	0289a503          	lw	a0,40(s3)
    8000365c:	fffff097          	auipc	ra,0xfffff
    80003660:	f30080e7          	jalr	-208(ra) # 8000258c <bread>
    80003664:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80003666:	40000613          	li	a2,1024
    8000366a:	05890593          	add	a1,s2,88
    8000366e:	05850513          	add	a0,a0,88
    80003672:	ffffd097          	auipc	ra,0xffffd
    80003676:	cee080e7          	jalr	-786(ra) # 80000360 <memmove>
    bwrite(dbuf);  // write dst to disk
    8000367a:	8526                	mv	a0,s1
    8000367c:	fffff097          	auipc	ra,0xfffff
    80003680:	002080e7          	jalr	2(ra) # 8000267e <bwrite>
    if(recovering == 0)
    80003684:	f80b1ce3          	bnez	s6,8000361c <install_trans+0x36>
      bunpin(dbuf);
    80003688:	8526                	mv	a0,s1
    8000368a:	fffff097          	auipc	ra,0xfffff
    8000368e:	10a080e7          	jalr	266(ra) # 80002794 <bunpin>
    80003692:	b769                	j	8000361c <install_trans+0x36>
}
    80003694:	70e2                	ld	ra,56(sp)
    80003696:	7442                	ld	s0,48(sp)
    80003698:	74a2                	ld	s1,40(sp)
    8000369a:	7902                	ld	s2,32(sp)
    8000369c:	69e2                	ld	s3,24(sp)
    8000369e:	6a42                	ld	s4,16(sp)
    800036a0:	6aa2                	ld	s5,8(sp)
    800036a2:	6b02                	ld	s6,0(sp)
    800036a4:	6121                	add	sp,sp,64
    800036a6:	8082                	ret
    800036a8:	8082                	ret

00000000800036aa <initlog>:
{
    800036aa:	7179                	add	sp,sp,-48
    800036ac:	f406                	sd	ra,40(sp)
    800036ae:	f022                	sd	s0,32(sp)
    800036b0:	ec26                	sd	s1,24(sp)
    800036b2:	e84a                	sd	s2,16(sp)
    800036b4:	e44e                	sd	s3,8(sp)
    800036b6:	1800                	add	s0,sp,48
    800036b8:	892a                	mv	s2,a0
    800036ba:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    800036bc:	00035497          	auipc	s1,0x35
    800036c0:	24c48493          	add	s1,s1,588 # 80038908 <log>
    800036c4:	00005597          	auipc	a1,0x5
    800036c8:	f1c58593          	add	a1,a1,-228 # 800085e0 <syscalls+0x1d8>
    800036cc:	8526                	mv	a0,s1
    800036ce:	00003097          	auipc	ra,0x3
    800036d2:	bd0080e7          	jalr	-1072(ra) # 8000629e <initlock>
  log.start = sb->logstart;
    800036d6:	0149a583          	lw	a1,20(s3)
    800036da:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    800036dc:	0109a783          	lw	a5,16(s3)
    800036e0:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    800036e2:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    800036e6:	854a                	mv	a0,s2
    800036e8:	fffff097          	auipc	ra,0xfffff
    800036ec:	ea4080e7          	jalr	-348(ra) # 8000258c <bread>
  log.lh.n = lh->n;
    800036f0:	4d30                	lw	a2,88(a0)
    800036f2:	d4d0                	sw	a2,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    800036f4:	00c05f63          	blez	a2,80003712 <initlog+0x68>
    800036f8:	87aa                	mv	a5,a0
    800036fa:	00035717          	auipc	a4,0x35
    800036fe:	23e70713          	add	a4,a4,574 # 80038938 <log+0x30>
    80003702:	060a                	sll	a2,a2,0x2
    80003704:	962a                	add	a2,a2,a0
    log.lh.block[i] = lh->block[i];
    80003706:	4ff4                	lw	a3,92(a5)
    80003708:	c314                	sw	a3,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    8000370a:	0791                	add	a5,a5,4
    8000370c:	0711                	add	a4,a4,4
    8000370e:	fec79ce3          	bne	a5,a2,80003706 <initlog+0x5c>
  brelse(buf);
    80003712:	fffff097          	auipc	ra,0xfffff
    80003716:	faa080e7          	jalr	-86(ra) # 800026bc <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    8000371a:	4505                	li	a0,1
    8000371c:	00000097          	auipc	ra,0x0
    80003720:	eca080e7          	jalr	-310(ra) # 800035e6 <install_trans>
  log.lh.n = 0;
    80003724:	00035797          	auipc	a5,0x35
    80003728:	2007a823          	sw	zero,528(a5) # 80038934 <log+0x2c>
  write_head(); // clear the log
    8000372c:	00000097          	auipc	ra,0x0
    80003730:	e50080e7          	jalr	-432(ra) # 8000357c <write_head>
}
    80003734:	70a2                	ld	ra,40(sp)
    80003736:	7402                	ld	s0,32(sp)
    80003738:	64e2                	ld	s1,24(sp)
    8000373a:	6942                	ld	s2,16(sp)
    8000373c:	69a2                	ld	s3,8(sp)
    8000373e:	6145                	add	sp,sp,48
    80003740:	8082                	ret

0000000080003742 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80003742:	1101                	add	sp,sp,-32
    80003744:	ec06                	sd	ra,24(sp)
    80003746:	e822                	sd	s0,16(sp)
    80003748:	e426                	sd	s1,8(sp)
    8000374a:	e04a                	sd	s2,0(sp)
    8000374c:	1000                	add	s0,sp,32
  acquire(&log.lock);
    8000374e:	00035517          	auipc	a0,0x35
    80003752:	1ba50513          	add	a0,a0,442 # 80038908 <log>
    80003756:	00003097          	auipc	ra,0x3
    8000375a:	bd8080e7          	jalr	-1064(ra) # 8000632e <acquire>
  while(1){
    if(log.committing){
    8000375e:	00035497          	auipc	s1,0x35
    80003762:	1aa48493          	add	s1,s1,426 # 80038908 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003766:	4979                	li	s2,30
    80003768:	a039                	j	80003776 <begin_op+0x34>
      sleep(&log, &log.lock);
    8000376a:	85a6                	mv	a1,s1
    8000376c:	8526                	mv	a0,s1
    8000376e:	ffffe097          	auipc	ra,0xffffe
    80003772:	022080e7          	jalr	34(ra) # 80001790 <sleep>
    if(log.committing){
    80003776:	50dc                	lw	a5,36(s1)
    80003778:	fbed                	bnez	a5,8000376a <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    8000377a:	5098                	lw	a4,32(s1)
    8000377c:	2705                	addw	a4,a4,1
    8000377e:	0027179b          	sllw	a5,a4,0x2
    80003782:	9fb9                	addw	a5,a5,a4
    80003784:	0017979b          	sllw	a5,a5,0x1
    80003788:	54d4                	lw	a3,44(s1)
    8000378a:	9fb5                	addw	a5,a5,a3
    8000378c:	00f95963          	bge	s2,a5,8000379e <begin_op+0x5c>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80003790:	85a6                	mv	a1,s1
    80003792:	8526                	mv	a0,s1
    80003794:	ffffe097          	auipc	ra,0xffffe
    80003798:	ffc080e7          	jalr	-4(ra) # 80001790 <sleep>
    8000379c:	bfe9                	j	80003776 <begin_op+0x34>
    } else {
      log.outstanding += 1;
    8000379e:	00035517          	auipc	a0,0x35
    800037a2:	16a50513          	add	a0,a0,362 # 80038908 <log>
    800037a6:	d118                	sw	a4,32(a0)
      release(&log.lock);
    800037a8:	00003097          	auipc	ra,0x3
    800037ac:	c3a080e7          	jalr	-966(ra) # 800063e2 <release>
      break;
    }
  }
}
    800037b0:	60e2                	ld	ra,24(sp)
    800037b2:	6442                	ld	s0,16(sp)
    800037b4:	64a2                	ld	s1,8(sp)
    800037b6:	6902                	ld	s2,0(sp)
    800037b8:	6105                	add	sp,sp,32
    800037ba:	8082                	ret

00000000800037bc <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    800037bc:	7139                	add	sp,sp,-64
    800037be:	fc06                	sd	ra,56(sp)
    800037c0:	f822                	sd	s0,48(sp)
    800037c2:	f426                	sd	s1,40(sp)
    800037c4:	f04a                	sd	s2,32(sp)
    800037c6:	ec4e                	sd	s3,24(sp)
    800037c8:	e852                	sd	s4,16(sp)
    800037ca:	e456                	sd	s5,8(sp)
    800037cc:	0080                	add	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    800037ce:	00035497          	auipc	s1,0x35
    800037d2:	13a48493          	add	s1,s1,314 # 80038908 <log>
    800037d6:	8526                	mv	a0,s1
    800037d8:	00003097          	auipc	ra,0x3
    800037dc:	b56080e7          	jalr	-1194(ra) # 8000632e <acquire>
  log.outstanding -= 1;
    800037e0:	509c                	lw	a5,32(s1)
    800037e2:	37fd                	addw	a5,a5,-1
    800037e4:	0007891b          	sext.w	s2,a5
    800037e8:	d09c                	sw	a5,32(s1)
  if(log.committing)
    800037ea:	50dc                	lw	a5,36(s1)
    800037ec:	e7b9                	bnez	a5,8000383a <end_op+0x7e>
    panic("log.committing");
  if(log.outstanding == 0){
    800037ee:	04091e63          	bnez	s2,8000384a <end_op+0x8e>
    do_commit = 1;
    log.committing = 1;
    800037f2:	00035497          	auipc	s1,0x35
    800037f6:	11648493          	add	s1,s1,278 # 80038908 <log>
    800037fa:	4785                	li	a5,1
    800037fc:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    800037fe:	8526                	mv	a0,s1
    80003800:	00003097          	auipc	ra,0x3
    80003804:	be2080e7          	jalr	-1054(ra) # 800063e2 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    80003808:	54dc                	lw	a5,44(s1)
    8000380a:	06f04763          	bgtz	a5,80003878 <end_op+0xbc>
    acquire(&log.lock);
    8000380e:	00035497          	auipc	s1,0x35
    80003812:	0fa48493          	add	s1,s1,250 # 80038908 <log>
    80003816:	8526                	mv	a0,s1
    80003818:	00003097          	auipc	ra,0x3
    8000381c:	b16080e7          	jalr	-1258(ra) # 8000632e <acquire>
    log.committing = 0;
    80003820:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    80003824:	8526                	mv	a0,s1
    80003826:	ffffe097          	auipc	ra,0xffffe
    8000382a:	fce080e7          	jalr	-50(ra) # 800017f4 <wakeup>
    release(&log.lock);
    8000382e:	8526                	mv	a0,s1
    80003830:	00003097          	auipc	ra,0x3
    80003834:	bb2080e7          	jalr	-1102(ra) # 800063e2 <release>
}
    80003838:	a03d                	j	80003866 <end_op+0xaa>
    panic("log.committing");
    8000383a:	00005517          	auipc	a0,0x5
    8000383e:	dae50513          	add	a0,a0,-594 # 800085e8 <syscalls+0x1e0>
    80003842:	00002097          	auipc	ra,0x2
    80003846:	5b4080e7          	jalr	1460(ra) # 80005df6 <panic>
    wakeup(&log);
    8000384a:	00035497          	auipc	s1,0x35
    8000384e:	0be48493          	add	s1,s1,190 # 80038908 <log>
    80003852:	8526                	mv	a0,s1
    80003854:	ffffe097          	auipc	ra,0xffffe
    80003858:	fa0080e7          	jalr	-96(ra) # 800017f4 <wakeup>
  release(&log.lock);
    8000385c:	8526                	mv	a0,s1
    8000385e:	00003097          	auipc	ra,0x3
    80003862:	b84080e7          	jalr	-1148(ra) # 800063e2 <release>
}
    80003866:	70e2                	ld	ra,56(sp)
    80003868:	7442                	ld	s0,48(sp)
    8000386a:	74a2                	ld	s1,40(sp)
    8000386c:	7902                	ld	s2,32(sp)
    8000386e:	69e2                	ld	s3,24(sp)
    80003870:	6a42                	ld	s4,16(sp)
    80003872:	6aa2                	ld	s5,8(sp)
    80003874:	6121                	add	sp,sp,64
    80003876:	8082                	ret
  for (tail = 0; tail < log.lh.n; tail++) {
    80003878:	00035a97          	auipc	s5,0x35
    8000387c:	0c0a8a93          	add	s5,s5,192 # 80038938 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80003880:	00035a17          	auipc	s4,0x35
    80003884:	088a0a13          	add	s4,s4,136 # 80038908 <log>
    80003888:	018a2583          	lw	a1,24(s4)
    8000388c:	012585bb          	addw	a1,a1,s2
    80003890:	2585                	addw	a1,a1,1
    80003892:	028a2503          	lw	a0,40(s4)
    80003896:	fffff097          	auipc	ra,0xfffff
    8000389a:	cf6080e7          	jalr	-778(ra) # 8000258c <bread>
    8000389e:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    800038a0:	000aa583          	lw	a1,0(s5)
    800038a4:	028a2503          	lw	a0,40(s4)
    800038a8:	fffff097          	auipc	ra,0xfffff
    800038ac:	ce4080e7          	jalr	-796(ra) # 8000258c <bread>
    800038b0:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    800038b2:	40000613          	li	a2,1024
    800038b6:	05850593          	add	a1,a0,88
    800038ba:	05848513          	add	a0,s1,88
    800038be:	ffffd097          	auipc	ra,0xffffd
    800038c2:	aa2080e7          	jalr	-1374(ra) # 80000360 <memmove>
    bwrite(to);  // write the log
    800038c6:	8526                	mv	a0,s1
    800038c8:	fffff097          	auipc	ra,0xfffff
    800038cc:	db6080e7          	jalr	-586(ra) # 8000267e <bwrite>
    brelse(from);
    800038d0:	854e                	mv	a0,s3
    800038d2:	fffff097          	auipc	ra,0xfffff
    800038d6:	dea080e7          	jalr	-534(ra) # 800026bc <brelse>
    brelse(to);
    800038da:	8526                	mv	a0,s1
    800038dc:	fffff097          	auipc	ra,0xfffff
    800038e0:	de0080e7          	jalr	-544(ra) # 800026bc <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800038e4:	2905                	addw	s2,s2,1
    800038e6:	0a91                	add	s5,s5,4
    800038e8:	02ca2783          	lw	a5,44(s4)
    800038ec:	f8f94ee3          	blt	s2,a5,80003888 <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    800038f0:	00000097          	auipc	ra,0x0
    800038f4:	c8c080e7          	jalr	-884(ra) # 8000357c <write_head>
    install_trans(0); // Now install writes to home locations
    800038f8:	4501                	li	a0,0
    800038fa:	00000097          	auipc	ra,0x0
    800038fe:	cec080e7          	jalr	-788(ra) # 800035e6 <install_trans>
    log.lh.n = 0;
    80003902:	00035797          	auipc	a5,0x35
    80003906:	0207a923          	sw	zero,50(a5) # 80038934 <log+0x2c>
    write_head();    // Erase the transaction from the log
    8000390a:	00000097          	auipc	ra,0x0
    8000390e:	c72080e7          	jalr	-910(ra) # 8000357c <write_head>
    80003912:	bdf5                	j	8000380e <end_op+0x52>

0000000080003914 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    80003914:	1101                	add	sp,sp,-32
    80003916:	ec06                	sd	ra,24(sp)
    80003918:	e822                	sd	s0,16(sp)
    8000391a:	e426                	sd	s1,8(sp)
    8000391c:	e04a                	sd	s2,0(sp)
    8000391e:	1000                	add	s0,sp,32
    80003920:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    80003922:	00035917          	auipc	s2,0x35
    80003926:	fe690913          	add	s2,s2,-26 # 80038908 <log>
    8000392a:	854a                	mv	a0,s2
    8000392c:	00003097          	auipc	ra,0x3
    80003930:	a02080e7          	jalr	-1534(ra) # 8000632e <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80003934:	02c92603          	lw	a2,44(s2)
    80003938:	47f5                	li	a5,29
    8000393a:	06c7c563          	blt	a5,a2,800039a4 <log_write+0x90>
    8000393e:	00035797          	auipc	a5,0x35
    80003942:	fe67a783          	lw	a5,-26(a5) # 80038924 <log+0x1c>
    80003946:	37fd                	addw	a5,a5,-1
    80003948:	04f65e63          	bge	a2,a5,800039a4 <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    8000394c:	00035797          	auipc	a5,0x35
    80003950:	fdc7a783          	lw	a5,-36(a5) # 80038928 <log+0x20>
    80003954:	06f05063          	blez	a5,800039b4 <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    80003958:	4781                	li	a5,0
    8000395a:	06c05563          	blez	a2,800039c4 <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    8000395e:	44cc                	lw	a1,12(s1)
    80003960:	00035717          	auipc	a4,0x35
    80003964:	fd870713          	add	a4,a4,-40 # 80038938 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    80003968:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    8000396a:	4314                	lw	a3,0(a4)
    8000396c:	04b68c63          	beq	a3,a1,800039c4 <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    80003970:	2785                	addw	a5,a5,1
    80003972:	0711                	add	a4,a4,4
    80003974:	fef61be3          	bne	a2,a5,8000396a <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    80003978:	0621                	add	a2,a2,8
    8000397a:	060a                	sll	a2,a2,0x2
    8000397c:	00035797          	auipc	a5,0x35
    80003980:	f8c78793          	add	a5,a5,-116 # 80038908 <log>
    80003984:	97b2                	add	a5,a5,a2
    80003986:	44d8                	lw	a4,12(s1)
    80003988:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    8000398a:	8526                	mv	a0,s1
    8000398c:	fffff097          	auipc	ra,0xfffff
    80003990:	dcc080e7          	jalr	-564(ra) # 80002758 <bpin>
    log.lh.n++;
    80003994:	00035717          	auipc	a4,0x35
    80003998:	f7470713          	add	a4,a4,-140 # 80038908 <log>
    8000399c:	575c                	lw	a5,44(a4)
    8000399e:	2785                	addw	a5,a5,1
    800039a0:	d75c                	sw	a5,44(a4)
    800039a2:	a82d                	j	800039dc <log_write+0xc8>
    panic("too big a transaction");
    800039a4:	00005517          	auipc	a0,0x5
    800039a8:	c5450513          	add	a0,a0,-940 # 800085f8 <syscalls+0x1f0>
    800039ac:	00002097          	auipc	ra,0x2
    800039b0:	44a080e7          	jalr	1098(ra) # 80005df6 <panic>
    panic("log_write outside of trans");
    800039b4:	00005517          	auipc	a0,0x5
    800039b8:	c5c50513          	add	a0,a0,-932 # 80008610 <syscalls+0x208>
    800039bc:	00002097          	auipc	ra,0x2
    800039c0:	43a080e7          	jalr	1082(ra) # 80005df6 <panic>
  log.lh.block[i] = b->blockno;
    800039c4:	00878693          	add	a3,a5,8
    800039c8:	068a                	sll	a3,a3,0x2
    800039ca:	00035717          	auipc	a4,0x35
    800039ce:	f3e70713          	add	a4,a4,-194 # 80038908 <log>
    800039d2:	9736                	add	a4,a4,a3
    800039d4:	44d4                	lw	a3,12(s1)
    800039d6:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    800039d8:	faf609e3          	beq	a2,a5,8000398a <log_write+0x76>
  }
  release(&log.lock);
    800039dc:	00035517          	auipc	a0,0x35
    800039e0:	f2c50513          	add	a0,a0,-212 # 80038908 <log>
    800039e4:	00003097          	auipc	ra,0x3
    800039e8:	9fe080e7          	jalr	-1538(ra) # 800063e2 <release>
}
    800039ec:	60e2                	ld	ra,24(sp)
    800039ee:	6442                	ld	s0,16(sp)
    800039f0:	64a2                	ld	s1,8(sp)
    800039f2:	6902                	ld	s2,0(sp)
    800039f4:	6105                	add	sp,sp,32
    800039f6:	8082                	ret

00000000800039f8 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    800039f8:	1101                	add	sp,sp,-32
    800039fa:	ec06                	sd	ra,24(sp)
    800039fc:	e822                	sd	s0,16(sp)
    800039fe:	e426                	sd	s1,8(sp)
    80003a00:	e04a                	sd	s2,0(sp)
    80003a02:	1000                	add	s0,sp,32
    80003a04:	84aa                	mv	s1,a0
    80003a06:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80003a08:	00005597          	auipc	a1,0x5
    80003a0c:	c2858593          	add	a1,a1,-984 # 80008630 <syscalls+0x228>
    80003a10:	0521                	add	a0,a0,8
    80003a12:	00003097          	auipc	ra,0x3
    80003a16:	88c080e7          	jalr	-1908(ra) # 8000629e <initlock>
  lk->name = name;
    80003a1a:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    80003a1e:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003a22:	0204a423          	sw	zero,40(s1)
}
    80003a26:	60e2                	ld	ra,24(sp)
    80003a28:	6442                	ld	s0,16(sp)
    80003a2a:	64a2                	ld	s1,8(sp)
    80003a2c:	6902                	ld	s2,0(sp)
    80003a2e:	6105                	add	sp,sp,32
    80003a30:	8082                	ret

0000000080003a32 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80003a32:	1101                	add	sp,sp,-32
    80003a34:	ec06                	sd	ra,24(sp)
    80003a36:	e822                	sd	s0,16(sp)
    80003a38:	e426                	sd	s1,8(sp)
    80003a3a:	e04a                	sd	s2,0(sp)
    80003a3c:	1000                	add	s0,sp,32
    80003a3e:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003a40:	00850913          	add	s2,a0,8
    80003a44:	854a                	mv	a0,s2
    80003a46:	00003097          	auipc	ra,0x3
    80003a4a:	8e8080e7          	jalr	-1816(ra) # 8000632e <acquire>
  while (lk->locked) {
    80003a4e:	409c                	lw	a5,0(s1)
    80003a50:	cb89                	beqz	a5,80003a62 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    80003a52:	85ca                	mv	a1,s2
    80003a54:	8526                	mv	a0,s1
    80003a56:	ffffe097          	auipc	ra,0xffffe
    80003a5a:	d3a080e7          	jalr	-710(ra) # 80001790 <sleep>
  while (lk->locked) {
    80003a5e:	409c                	lw	a5,0(s1)
    80003a60:	fbed                	bnez	a5,80003a52 <acquiresleep+0x20>
  }
  lk->locked = 1;
    80003a62:	4785                	li	a5,1
    80003a64:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80003a66:	ffffd097          	auipc	ra,0xffffd
    80003a6a:	682080e7          	jalr	1666(ra) # 800010e8 <myproc>
    80003a6e:	591c                	lw	a5,48(a0)
    80003a70:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    80003a72:	854a                	mv	a0,s2
    80003a74:	00003097          	auipc	ra,0x3
    80003a78:	96e080e7          	jalr	-1682(ra) # 800063e2 <release>
}
    80003a7c:	60e2                	ld	ra,24(sp)
    80003a7e:	6442                	ld	s0,16(sp)
    80003a80:	64a2                	ld	s1,8(sp)
    80003a82:	6902                	ld	s2,0(sp)
    80003a84:	6105                	add	sp,sp,32
    80003a86:	8082                	ret

0000000080003a88 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80003a88:	1101                	add	sp,sp,-32
    80003a8a:	ec06                	sd	ra,24(sp)
    80003a8c:	e822                	sd	s0,16(sp)
    80003a8e:	e426                	sd	s1,8(sp)
    80003a90:	e04a                	sd	s2,0(sp)
    80003a92:	1000                	add	s0,sp,32
    80003a94:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003a96:	00850913          	add	s2,a0,8
    80003a9a:	854a                	mv	a0,s2
    80003a9c:	00003097          	auipc	ra,0x3
    80003aa0:	892080e7          	jalr	-1902(ra) # 8000632e <acquire>
  lk->locked = 0;
    80003aa4:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003aa8:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80003aac:	8526                	mv	a0,s1
    80003aae:	ffffe097          	auipc	ra,0xffffe
    80003ab2:	d46080e7          	jalr	-698(ra) # 800017f4 <wakeup>
  release(&lk->lk);
    80003ab6:	854a                	mv	a0,s2
    80003ab8:	00003097          	auipc	ra,0x3
    80003abc:	92a080e7          	jalr	-1750(ra) # 800063e2 <release>
}
    80003ac0:	60e2                	ld	ra,24(sp)
    80003ac2:	6442                	ld	s0,16(sp)
    80003ac4:	64a2                	ld	s1,8(sp)
    80003ac6:	6902                	ld	s2,0(sp)
    80003ac8:	6105                	add	sp,sp,32
    80003aca:	8082                	ret

0000000080003acc <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80003acc:	7179                	add	sp,sp,-48
    80003ace:	f406                	sd	ra,40(sp)
    80003ad0:	f022                	sd	s0,32(sp)
    80003ad2:	ec26                	sd	s1,24(sp)
    80003ad4:	e84a                	sd	s2,16(sp)
    80003ad6:	e44e                	sd	s3,8(sp)
    80003ad8:	1800                	add	s0,sp,48
    80003ada:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80003adc:	00850913          	add	s2,a0,8
    80003ae0:	854a                	mv	a0,s2
    80003ae2:	00003097          	auipc	ra,0x3
    80003ae6:	84c080e7          	jalr	-1972(ra) # 8000632e <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80003aea:	409c                	lw	a5,0(s1)
    80003aec:	ef99                	bnez	a5,80003b0a <holdingsleep+0x3e>
    80003aee:	4481                	li	s1,0
  release(&lk->lk);
    80003af0:	854a                	mv	a0,s2
    80003af2:	00003097          	auipc	ra,0x3
    80003af6:	8f0080e7          	jalr	-1808(ra) # 800063e2 <release>
  return r;
}
    80003afa:	8526                	mv	a0,s1
    80003afc:	70a2                	ld	ra,40(sp)
    80003afe:	7402                	ld	s0,32(sp)
    80003b00:	64e2                	ld	s1,24(sp)
    80003b02:	6942                	ld	s2,16(sp)
    80003b04:	69a2                	ld	s3,8(sp)
    80003b06:	6145                	add	sp,sp,48
    80003b08:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    80003b0a:	0284a983          	lw	s3,40(s1)
    80003b0e:	ffffd097          	auipc	ra,0xffffd
    80003b12:	5da080e7          	jalr	1498(ra) # 800010e8 <myproc>
    80003b16:	5904                	lw	s1,48(a0)
    80003b18:	413484b3          	sub	s1,s1,s3
    80003b1c:	0014b493          	seqz	s1,s1
    80003b20:	bfc1                	j	80003af0 <holdingsleep+0x24>

0000000080003b22 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80003b22:	1141                	add	sp,sp,-16
    80003b24:	e406                	sd	ra,8(sp)
    80003b26:	e022                	sd	s0,0(sp)
    80003b28:	0800                	add	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003b2a:	00005597          	auipc	a1,0x5
    80003b2e:	b1658593          	add	a1,a1,-1258 # 80008640 <syscalls+0x238>
    80003b32:	00035517          	auipc	a0,0x35
    80003b36:	f1e50513          	add	a0,a0,-226 # 80038a50 <ftable>
    80003b3a:	00002097          	auipc	ra,0x2
    80003b3e:	764080e7          	jalr	1892(ra) # 8000629e <initlock>
}
    80003b42:	60a2                	ld	ra,8(sp)
    80003b44:	6402                	ld	s0,0(sp)
    80003b46:	0141                	add	sp,sp,16
    80003b48:	8082                	ret

0000000080003b4a <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80003b4a:	1101                	add	sp,sp,-32
    80003b4c:	ec06                	sd	ra,24(sp)
    80003b4e:	e822                	sd	s0,16(sp)
    80003b50:	e426                	sd	s1,8(sp)
    80003b52:	1000                	add	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80003b54:	00035517          	auipc	a0,0x35
    80003b58:	efc50513          	add	a0,a0,-260 # 80038a50 <ftable>
    80003b5c:	00002097          	auipc	ra,0x2
    80003b60:	7d2080e7          	jalr	2002(ra) # 8000632e <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003b64:	00035497          	auipc	s1,0x35
    80003b68:	f0448493          	add	s1,s1,-252 # 80038a68 <ftable+0x18>
    80003b6c:	00036717          	auipc	a4,0x36
    80003b70:	e9c70713          	add	a4,a4,-356 # 80039a08 <disk>
    if(f->ref == 0){
    80003b74:	40dc                	lw	a5,4(s1)
    80003b76:	cf99                	beqz	a5,80003b94 <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003b78:	02848493          	add	s1,s1,40
    80003b7c:	fee49ce3          	bne	s1,a4,80003b74 <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80003b80:	00035517          	auipc	a0,0x35
    80003b84:	ed050513          	add	a0,a0,-304 # 80038a50 <ftable>
    80003b88:	00003097          	auipc	ra,0x3
    80003b8c:	85a080e7          	jalr	-1958(ra) # 800063e2 <release>
  return 0;
    80003b90:	4481                	li	s1,0
    80003b92:	a819                	j	80003ba8 <filealloc+0x5e>
      f->ref = 1;
    80003b94:	4785                	li	a5,1
    80003b96:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80003b98:	00035517          	auipc	a0,0x35
    80003b9c:	eb850513          	add	a0,a0,-328 # 80038a50 <ftable>
    80003ba0:	00003097          	auipc	ra,0x3
    80003ba4:	842080e7          	jalr	-1982(ra) # 800063e2 <release>
}
    80003ba8:	8526                	mv	a0,s1
    80003baa:	60e2                	ld	ra,24(sp)
    80003bac:	6442                	ld	s0,16(sp)
    80003bae:	64a2                	ld	s1,8(sp)
    80003bb0:	6105                	add	sp,sp,32
    80003bb2:	8082                	ret

0000000080003bb4 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80003bb4:	1101                	add	sp,sp,-32
    80003bb6:	ec06                	sd	ra,24(sp)
    80003bb8:	e822                	sd	s0,16(sp)
    80003bba:	e426                	sd	s1,8(sp)
    80003bbc:	1000                	add	s0,sp,32
    80003bbe:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80003bc0:	00035517          	auipc	a0,0x35
    80003bc4:	e9050513          	add	a0,a0,-368 # 80038a50 <ftable>
    80003bc8:	00002097          	auipc	ra,0x2
    80003bcc:	766080e7          	jalr	1894(ra) # 8000632e <acquire>
  if(f->ref < 1)
    80003bd0:	40dc                	lw	a5,4(s1)
    80003bd2:	02f05263          	blez	a5,80003bf6 <filedup+0x42>
    panic("filedup");
  f->ref++;
    80003bd6:	2785                	addw	a5,a5,1
    80003bd8:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80003bda:	00035517          	auipc	a0,0x35
    80003bde:	e7650513          	add	a0,a0,-394 # 80038a50 <ftable>
    80003be2:	00003097          	auipc	ra,0x3
    80003be6:	800080e7          	jalr	-2048(ra) # 800063e2 <release>
  return f;
}
    80003bea:	8526                	mv	a0,s1
    80003bec:	60e2                	ld	ra,24(sp)
    80003bee:	6442                	ld	s0,16(sp)
    80003bf0:	64a2                	ld	s1,8(sp)
    80003bf2:	6105                	add	sp,sp,32
    80003bf4:	8082                	ret
    panic("filedup");
    80003bf6:	00005517          	auipc	a0,0x5
    80003bfa:	a5250513          	add	a0,a0,-1454 # 80008648 <syscalls+0x240>
    80003bfe:	00002097          	auipc	ra,0x2
    80003c02:	1f8080e7          	jalr	504(ra) # 80005df6 <panic>

0000000080003c06 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80003c06:	7139                	add	sp,sp,-64
    80003c08:	fc06                	sd	ra,56(sp)
    80003c0a:	f822                	sd	s0,48(sp)
    80003c0c:	f426                	sd	s1,40(sp)
    80003c0e:	f04a                	sd	s2,32(sp)
    80003c10:	ec4e                	sd	s3,24(sp)
    80003c12:	e852                	sd	s4,16(sp)
    80003c14:	e456                	sd	s5,8(sp)
    80003c16:	0080                	add	s0,sp,64
    80003c18:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80003c1a:	00035517          	auipc	a0,0x35
    80003c1e:	e3650513          	add	a0,a0,-458 # 80038a50 <ftable>
    80003c22:	00002097          	auipc	ra,0x2
    80003c26:	70c080e7          	jalr	1804(ra) # 8000632e <acquire>
  if(f->ref < 1)
    80003c2a:	40dc                	lw	a5,4(s1)
    80003c2c:	06f05163          	blez	a5,80003c8e <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    80003c30:	37fd                	addw	a5,a5,-1
    80003c32:	0007871b          	sext.w	a4,a5
    80003c36:	c0dc                	sw	a5,4(s1)
    80003c38:	06e04363          	bgtz	a4,80003c9e <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003c3c:	0004a903          	lw	s2,0(s1)
    80003c40:	0094ca83          	lbu	s5,9(s1)
    80003c44:	0104ba03          	ld	s4,16(s1)
    80003c48:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80003c4c:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80003c50:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80003c54:	00035517          	auipc	a0,0x35
    80003c58:	dfc50513          	add	a0,a0,-516 # 80038a50 <ftable>
    80003c5c:	00002097          	auipc	ra,0x2
    80003c60:	786080e7          	jalr	1926(ra) # 800063e2 <release>

  if(ff.type == FD_PIPE){
    80003c64:	4785                	li	a5,1
    80003c66:	04f90d63          	beq	s2,a5,80003cc0 <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003c6a:	3979                	addw	s2,s2,-2
    80003c6c:	4785                	li	a5,1
    80003c6e:	0527e063          	bltu	a5,s2,80003cae <fileclose+0xa8>
    begin_op();
    80003c72:	00000097          	auipc	ra,0x0
    80003c76:	ad0080e7          	jalr	-1328(ra) # 80003742 <begin_op>
    iput(ff.ip);
    80003c7a:	854e                	mv	a0,s3
    80003c7c:	fffff097          	auipc	ra,0xfffff
    80003c80:	2da080e7          	jalr	730(ra) # 80002f56 <iput>
    end_op();
    80003c84:	00000097          	auipc	ra,0x0
    80003c88:	b38080e7          	jalr	-1224(ra) # 800037bc <end_op>
    80003c8c:	a00d                	j	80003cae <fileclose+0xa8>
    panic("fileclose");
    80003c8e:	00005517          	auipc	a0,0x5
    80003c92:	9c250513          	add	a0,a0,-1598 # 80008650 <syscalls+0x248>
    80003c96:	00002097          	auipc	ra,0x2
    80003c9a:	160080e7          	jalr	352(ra) # 80005df6 <panic>
    release(&ftable.lock);
    80003c9e:	00035517          	auipc	a0,0x35
    80003ca2:	db250513          	add	a0,a0,-590 # 80038a50 <ftable>
    80003ca6:	00002097          	auipc	ra,0x2
    80003caa:	73c080e7          	jalr	1852(ra) # 800063e2 <release>
  }
}
    80003cae:	70e2                	ld	ra,56(sp)
    80003cb0:	7442                	ld	s0,48(sp)
    80003cb2:	74a2                	ld	s1,40(sp)
    80003cb4:	7902                	ld	s2,32(sp)
    80003cb6:	69e2                	ld	s3,24(sp)
    80003cb8:	6a42                	ld	s4,16(sp)
    80003cba:	6aa2                	ld	s5,8(sp)
    80003cbc:	6121                	add	sp,sp,64
    80003cbe:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80003cc0:	85d6                	mv	a1,s5
    80003cc2:	8552                	mv	a0,s4
    80003cc4:	00000097          	auipc	ra,0x0
    80003cc8:	348080e7          	jalr	840(ra) # 8000400c <pipeclose>
    80003ccc:	b7cd                	j	80003cae <fileclose+0xa8>

0000000080003cce <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003cce:	715d                	add	sp,sp,-80
    80003cd0:	e486                	sd	ra,72(sp)
    80003cd2:	e0a2                	sd	s0,64(sp)
    80003cd4:	fc26                	sd	s1,56(sp)
    80003cd6:	f84a                	sd	s2,48(sp)
    80003cd8:	f44e                	sd	s3,40(sp)
    80003cda:	0880                	add	s0,sp,80
    80003cdc:	84aa                	mv	s1,a0
    80003cde:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80003ce0:	ffffd097          	auipc	ra,0xffffd
    80003ce4:	408080e7          	jalr	1032(ra) # 800010e8 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80003ce8:	409c                	lw	a5,0(s1)
    80003cea:	37f9                	addw	a5,a5,-2
    80003cec:	4705                	li	a4,1
    80003cee:	04f76763          	bltu	a4,a5,80003d3c <filestat+0x6e>
    80003cf2:	892a                	mv	s2,a0
    ilock(f->ip);
    80003cf4:	6c88                	ld	a0,24(s1)
    80003cf6:	fffff097          	auipc	ra,0xfffff
    80003cfa:	0a6080e7          	jalr	166(ra) # 80002d9c <ilock>
    stati(f->ip, &st);
    80003cfe:	fb840593          	add	a1,s0,-72
    80003d02:	6c88                	ld	a0,24(s1)
    80003d04:	fffff097          	auipc	ra,0xfffff
    80003d08:	322080e7          	jalr	802(ra) # 80003026 <stati>
    iunlock(f->ip);
    80003d0c:	6c88                	ld	a0,24(s1)
    80003d0e:	fffff097          	auipc	ra,0xfffff
    80003d12:	150080e7          	jalr	336(ra) # 80002e5e <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80003d16:	46e1                	li	a3,24
    80003d18:	fb840613          	add	a2,s0,-72
    80003d1c:	85ce                	mv	a1,s3
    80003d1e:	05093503          	ld	a0,80(s2)
    80003d22:	ffffd097          	auipc	ra,0xffffd
    80003d26:	1ac080e7          	jalr	428(ra) # 80000ece <copyout>
    80003d2a:	41f5551b          	sraw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80003d2e:	60a6                	ld	ra,72(sp)
    80003d30:	6406                	ld	s0,64(sp)
    80003d32:	74e2                	ld	s1,56(sp)
    80003d34:	7942                	ld	s2,48(sp)
    80003d36:	79a2                	ld	s3,40(sp)
    80003d38:	6161                	add	sp,sp,80
    80003d3a:	8082                	ret
  return -1;
    80003d3c:	557d                	li	a0,-1
    80003d3e:	bfc5                	j	80003d2e <filestat+0x60>

0000000080003d40 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003d40:	7179                	add	sp,sp,-48
    80003d42:	f406                	sd	ra,40(sp)
    80003d44:	f022                	sd	s0,32(sp)
    80003d46:	ec26                	sd	s1,24(sp)
    80003d48:	e84a                	sd	s2,16(sp)
    80003d4a:	e44e                	sd	s3,8(sp)
    80003d4c:	1800                	add	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80003d4e:	00854783          	lbu	a5,8(a0)
    80003d52:	c3d5                	beqz	a5,80003df6 <fileread+0xb6>
    80003d54:	84aa                	mv	s1,a0
    80003d56:	89ae                	mv	s3,a1
    80003d58:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80003d5a:	411c                	lw	a5,0(a0)
    80003d5c:	4705                	li	a4,1
    80003d5e:	04e78963          	beq	a5,a4,80003db0 <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003d62:	470d                	li	a4,3
    80003d64:	04e78d63          	beq	a5,a4,80003dbe <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80003d68:	4709                	li	a4,2
    80003d6a:	06e79e63          	bne	a5,a4,80003de6 <fileread+0xa6>
    ilock(f->ip);
    80003d6e:	6d08                	ld	a0,24(a0)
    80003d70:	fffff097          	auipc	ra,0xfffff
    80003d74:	02c080e7          	jalr	44(ra) # 80002d9c <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003d78:	874a                	mv	a4,s2
    80003d7a:	5094                	lw	a3,32(s1)
    80003d7c:	864e                	mv	a2,s3
    80003d7e:	4585                	li	a1,1
    80003d80:	6c88                	ld	a0,24(s1)
    80003d82:	fffff097          	auipc	ra,0xfffff
    80003d86:	2ce080e7          	jalr	718(ra) # 80003050 <readi>
    80003d8a:	892a                	mv	s2,a0
    80003d8c:	00a05563          	blez	a0,80003d96 <fileread+0x56>
      f->off += r;
    80003d90:	509c                	lw	a5,32(s1)
    80003d92:	9fa9                	addw	a5,a5,a0
    80003d94:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80003d96:	6c88                	ld	a0,24(s1)
    80003d98:	fffff097          	auipc	ra,0xfffff
    80003d9c:	0c6080e7          	jalr	198(ra) # 80002e5e <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    80003da0:	854a                	mv	a0,s2
    80003da2:	70a2                	ld	ra,40(sp)
    80003da4:	7402                	ld	s0,32(sp)
    80003da6:	64e2                	ld	s1,24(sp)
    80003da8:	6942                	ld	s2,16(sp)
    80003daa:	69a2                	ld	s3,8(sp)
    80003dac:	6145                	add	sp,sp,48
    80003dae:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80003db0:	6908                	ld	a0,16(a0)
    80003db2:	00000097          	auipc	ra,0x0
    80003db6:	3c2080e7          	jalr	962(ra) # 80004174 <piperead>
    80003dba:	892a                	mv	s2,a0
    80003dbc:	b7d5                	j	80003da0 <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80003dbe:	02451783          	lh	a5,36(a0)
    80003dc2:	03079693          	sll	a3,a5,0x30
    80003dc6:	92c1                	srl	a3,a3,0x30
    80003dc8:	4725                	li	a4,9
    80003dca:	02d76863          	bltu	a4,a3,80003dfa <fileread+0xba>
    80003dce:	0792                	sll	a5,a5,0x4
    80003dd0:	00035717          	auipc	a4,0x35
    80003dd4:	be070713          	add	a4,a4,-1056 # 800389b0 <devsw>
    80003dd8:	97ba                	add	a5,a5,a4
    80003dda:	639c                	ld	a5,0(a5)
    80003ddc:	c38d                	beqz	a5,80003dfe <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    80003dde:	4505                	li	a0,1
    80003de0:	9782                	jalr	a5
    80003de2:	892a                	mv	s2,a0
    80003de4:	bf75                	j	80003da0 <fileread+0x60>
    panic("fileread");
    80003de6:	00005517          	auipc	a0,0x5
    80003dea:	87a50513          	add	a0,a0,-1926 # 80008660 <syscalls+0x258>
    80003dee:	00002097          	auipc	ra,0x2
    80003df2:	008080e7          	jalr	8(ra) # 80005df6 <panic>
    return -1;
    80003df6:	597d                	li	s2,-1
    80003df8:	b765                	j	80003da0 <fileread+0x60>
      return -1;
    80003dfa:	597d                	li	s2,-1
    80003dfc:	b755                	j	80003da0 <fileread+0x60>
    80003dfe:	597d                	li	s2,-1
    80003e00:	b745                	j	80003da0 <fileread+0x60>

0000000080003e02 <filewrite>:
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if(f->writable == 0)
    80003e02:	00954783          	lbu	a5,9(a0)
    80003e06:	10078e63          	beqz	a5,80003f22 <filewrite+0x120>
{
    80003e0a:	715d                	add	sp,sp,-80
    80003e0c:	e486                	sd	ra,72(sp)
    80003e0e:	e0a2                	sd	s0,64(sp)
    80003e10:	fc26                	sd	s1,56(sp)
    80003e12:	f84a                	sd	s2,48(sp)
    80003e14:	f44e                	sd	s3,40(sp)
    80003e16:	f052                	sd	s4,32(sp)
    80003e18:	ec56                	sd	s5,24(sp)
    80003e1a:	e85a                	sd	s6,16(sp)
    80003e1c:	e45e                	sd	s7,8(sp)
    80003e1e:	e062                	sd	s8,0(sp)
    80003e20:	0880                	add	s0,sp,80
    80003e22:	892a                	mv	s2,a0
    80003e24:	8b2e                	mv	s6,a1
    80003e26:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    80003e28:	411c                	lw	a5,0(a0)
    80003e2a:	4705                	li	a4,1
    80003e2c:	02e78263          	beq	a5,a4,80003e50 <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003e30:	470d                	li	a4,3
    80003e32:	02e78563          	beq	a5,a4,80003e5c <filewrite+0x5a>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80003e36:	4709                	li	a4,2
    80003e38:	0ce79d63          	bne	a5,a4,80003f12 <filewrite+0x110>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80003e3c:	0ac05b63          	blez	a2,80003ef2 <filewrite+0xf0>
    int i = 0;
    80003e40:	4981                	li	s3,0
      int n1 = n - i;
      if(n1 > max)
    80003e42:	6b85                	lui	s7,0x1
    80003e44:	c00b8b93          	add	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    80003e48:	6c05                	lui	s8,0x1
    80003e4a:	c00c0c1b          	addw	s8,s8,-1024 # c00 <_entry-0x7ffff400>
    80003e4e:	a851                	j	80003ee2 <filewrite+0xe0>
    ret = pipewrite(f->pipe, addr, n);
    80003e50:	6908                	ld	a0,16(a0)
    80003e52:	00000097          	auipc	ra,0x0
    80003e56:	22a080e7          	jalr	554(ra) # 8000407c <pipewrite>
    80003e5a:	a045                	j	80003efa <filewrite+0xf8>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80003e5c:	02451783          	lh	a5,36(a0)
    80003e60:	03079693          	sll	a3,a5,0x30
    80003e64:	92c1                	srl	a3,a3,0x30
    80003e66:	4725                	li	a4,9
    80003e68:	0ad76f63          	bltu	a4,a3,80003f26 <filewrite+0x124>
    80003e6c:	0792                	sll	a5,a5,0x4
    80003e6e:	00035717          	auipc	a4,0x35
    80003e72:	b4270713          	add	a4,a4,-1214 # 800389b0 <devsw>
    80003e76:	97ba                	add	a5,a5,a4
    80003e78:	679c                	ld	a5,8(a5)
    80003e7a:	cbc5                	beqz	a5,80003f2a <filewrite+0x128>
    ret = devsw[f->major].write(1, addr, n);
    80003e7c:	4505                	li	a0,1
    80003e7e:	9782                	jalr	a5
    80003e80:	a8ad                	j	80003efa <filewrite+0xf8>
      if(n1 > max)
    80003e82:	00048a9b          	sext.w	s5,s1
        n1 = max;

      begin_op();
    80003e86:	00000097          	auipc	ra,0x0
    80003e8a:	8bc080e7          	jalr	-1860(ra) # 80003742 <begin_op>
      ilock(f->ip);
    80003e8e:	01893503          	ld	a0,24(s2)
    80003e92:	fffff097          	auipc	ra,0xfffff
    80003e96:	f0a080e7          	jalr	-246(ra) # 80002d9c <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003e9a:	8756                	mv	a4,s5
    80003e9c:	02092683          	lw	a3,32(s2)
    80003ea0:	01698633          	add	a2,s3,s6
    80003ea4:	4585                	li	a1,1
    80003ea6:	01893503          	ld	a0,24(s2)
    80003eaa:	fffff097          	auipc	ra,0xfffff
    80003eae:	29e080e7          	jalr	670(ra) # 80003148 <writei>
    80003eb2:	84aa                	mv	s1,a0
    80003eb4:	00a05763          	blez	a0,80003ec2 <filewrite+0xc0>
        f->off += r;
    80003eb8:	02092783          	lw	a5,32(s2)
    80003ebc:	9fa9                	addw	a5,a5,a0
    80003ebe:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80003ec2:	01893503          	ld	a0,24(s2)
    80003ec6:	fffff097          	auipc	ra,0xfffff
    80003eca:	f98080e7          	jalr	-104(ra) # 80002e5e <iunlock>
      end_op();
    80003ece:	00000097          	auipc	ra,0x0
    80003ed2:	8ee080e7          	jalr	-1810(ra) # 800037bc <end_op>

      if(r != n1){
    80003ed6:	009a9f63          	bne	s5,s1,80003ef4 <filewrite+0xf2>
        // error from writei
        break;
      }
      i += r;
    80003eda:	013489bb          	addw	s3,s1,s3
    while(i < n){
    80003ede:	0149db63          	bge	s3,s4,80003ef4 <filewrite+0xf2>
      int n1 = n - i;
    80003ee2:	413a04bb          	subw	s1,s4,s3
      if(n1 > max)
    80003ee6:	0004879b          	sext.w	a5,s1
    80003eea:	f8fbdce3          	bge	s7,a5,80003e82 <filewrite+0x80>
    80003eee:	84e2                	mv	s1,s8
    80003ef0:	bf49                	j	80003e82 <filewrite+0x80>
    int i = 0;
    80003ef2:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    80003ef4:	033a1d63          	bne	s4,s3,80003f2e <filewrite+0x12c>
    80003ef8:	8552                	mv	a0,s4
  } else {
    panic("filewrite");
  }

  return ret;
}
    80003efa:	60a6                	ld	ra,72(sp)
    80003efc:	6406                	ld	s0,64(sp)
    80003efe:	74e2                	ld	s1,56(sp)
    80003f00:	7942                	ld	s2,48(sp)
    80003f02:	79a2                	ld	s3,40(sp)
    80003f04:	7a02                	ld	s4,32(sp)
    80003f06:	6ae2                	ld	s5,24(sp)
    80003f08:	6b42                	ld	s6,16(sp)
    80003f0a:	6ba2                	ld	s7,8(sp)
    80003f0c:	6c02                	ld	s8,0(sp)
    80003f0e:	6161                	add	sp,sp,80
    80003f10:	8082                	ret
    panic("filewrite");
    80003f12:	00004517          	auipc	a0,0x4
    80003f16:	75e50513          	add	a0,a0,1886 # 80008670 <syscalls+0x268>
    80003f1a:	00002097          	auipc	ra,0x2
    80003f1e:	edc080e7          	jalr	-292(ra) # 80005df6 <panic>
    return -1;
    80003f22:	557d                	li	a0,-1
}
    80003f24:	8082                	ret
      return -1;
    80003f26:	557d                	li	a0,-1
    80003f28:	bfc9                	j	80003efa <filewrite+0xf8>
    80003f2a:	557d                	li	a0,-1
    80003f2c:	b7f9                	j	80003efa <filewrite+0xf8>
    ret = (i == n ? n : -1);
    80003f2e:	557d                	li	a0,-1
    80003f30:	b7e9                	j	80003efa <filewrite+0xf8>

0000000080003f32 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80003f32:	7179                	add	sp,sp,-48
    80003f34:	f406                	sd	ra,40(sp)
    80003f36:	f022                	sd	s0,32(sp)
    80003f38:	ec26                	sd	s1,24(sp)
    80003f3a:	e84a                	sd	s2,16(sp)
    80003f3c:	e44e                	sd	s3,8(sp)
    80003f3e:	e052                	sd	s4,0(sp)
    80003f40:	1800                	add	s0,sp,48
    80003f42:	84aa                	mv	s1,a0
    80003f44:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80003f46:	0005b023          	sd	zero,0(a1)
    80003f4a:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80003f4e:	00000097          	auipc	ra,0x0
    80003f52:	bfc080e7          	jalr	-1028(ra) # 80003b4a <filealloc>
    80003f56:	e088                	sd	a0,0(s1)
    80003f58:	c551                	beqz	a0,80003fe4 <pipealloc+0xb2>
    80003f5a:	00000097          	auipc	ra,0x0
    80003f5e:	bf0080e7          	jalr	-1040(ra) # 80003b4a <filealloc>
    80003f62:	00aa3023          	sd	a0,0(s4)
    80003f66:	c92d                	beqz	a0,80003fd8 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80003f68:	ffffc097          	auipc	ra,0xffffc
    80003f6c:	21c080e7          	jalr	540(ra) # 80000184 <kalloc>
    80003f70:	892a                	mv	s2,a0
    80003f72:	c125                	beqz	a0,80003fd2 <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80003f74:	4985                	li	s3,1
    80003f76:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80003f7a:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80003f7e:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80003f82:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80003f86:	00004597          	auipc	a1,0x4
    80003f8a:	6fa58593          	add	a1,a1,1786 # 80008680 <syscalls+0x278>
    80003f8e:	00002097          	auipc	ra,0x2
    80003f92:	310080e7          	jalr	784(ra) # 8000629e <initlock>
  (*f0)->type = FD_PIPE;
    80003f96:	609c                	ld	a5,0(s1)
    80003f98:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80003f9c:	609c                	ld	a5,0(s1)
    80003f9e:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80003fa2:	609c                	ld	a5,0(s1)
    80003fa4:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80003fa8:	609c                	ld	a5,0(s1)
    80003faa:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80003fae:	000a3783          	ld	a5,0(s4)
    80003fb2:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80003fb6:	000a3783          	ld	a5,0(s4)
    80003fba:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80003fbe:	000a3783          	ld	a5,0(s4)
    80003fc2:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80003fc6:	000a3783          	ld	a5,0(s4)
    80003fca:	0127b823          	sd	s2,16(a5)
  return 0;
    80003fce:	4501                	li	a0,0
    80003fd0:	a025                	j	80003ff8 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80003fd2:	6088                	ld	a0,0(s1)
    80003fd4:	e501                	bnez	a0,80003fdc <pipealloc+0xaa>
    80003fd6:	a039                	j	80003fe4 <pipealloc+0xb2>
    80003fd8:	6088                	ld	a0,0(s1)
    80003fda:	c51d                	beqz	a0,80004008 <pipealloc+0xd6>
    fileclose(*f0);
    80003fdc:	00000097          	auipc	ra,0x0
    80003fe0:	c2a080e7          	jalr	-982(ra) # 80003c06 <fileclose>
  if(*f1)
    80003fe4:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80003fe8:	557d                	li	a0,-1
  if(*f1)
    80003fea:	c799                	beqz	a5,80003ff8 <pipealloc+0xc6>
    fileclose(*f1);
    80003fec:	853e                	mv	a0,a5
    80003fee:	00000097          	auipc	ra,0x0
    80003ff2:	c18080e7          	jalr	-1000(ra) # 80003c06 <fileclose>
  return -1;
    80003ff6:	557d                	li	a0,-1
}
    80003ff8:	70a2                	ld	ra,40(sp)
    80003ffa:	7402                	ld	s0,32(sp)
    80003ffc:	64e2                	ld	s1,24(sp)
    80003ffe:	6942                	ld	s2,16(sp)
    80004000:	69a2                	ld	s3,8(sp)
    80004002:	6a02                	ld	s4,0(sp)
    80004004:	6145                	add	sp,sp,48
    80004006:	8082                	ret
  return -1;
    80004008:	557d                	li	a0,-1
    8000400a:	b7fd                	j	80003ff8 <pipealloc+0xc6>

000000008000400c <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    8000400c:	1101                	add	sp,sp,-32
    8000400e:	ec06                	sd	ra,24(sp)
    80004010:	e822                	sd	s0,16(sp)
    80004012:	e426                	sd	s1,8(sp)
    80004014:	e04a                	sd	s2,0(sp)
    80004016:	1000                	add	s0,sp,32
    80004018:	84aa                	mv	s1,a0
    8000401a:	892e                	mv	s2,a1
  acquire(&pi->lock);
    8000401c:	00002097          	auipc	ra,0x2
    80004020:	312080e7          	jalr	786(ra) # 8000632e <acquire>
  if(writable){
    80004024:	02090d63          	beqz	s2,8000405e <pipeclose+0x52>
    pi->writeopen = 0;
    80004028:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    8000402c:	21848513          	add	a0,s1,536
    80004030:	ffffd097          	auipc	ra,0xffffd
    80004034:	7c4080e7          	jalr	1988(ra) # 800017f4 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80004038:	2204b783          	ld	a5,544(s1)
    8000403c:	eb95                	bnez	a5,80004070 <pipeclose+0x64>
    release(&pi->lock);
    8000403e:	8526                	mv	a0,s1
    80004040:	00002097          	auipc	ra,0x2
    80004044:	3a2080e7          	jalr	930(ra) # 800063e2 <release>
    kfree((char*)pi);
    80004048:	8526                	mv	a0,s1
    8000404a:	ffffc097          	auipc	ra,0xffffc
    8000404e:	fd2080e7          	jalr	-46(ra) # 8000001c <kfree>
  } else
    release(&pi->lock);
}
    80004052:	60e2                	ld	ra,24(sp)
    80004054:	6442                	ld	s0,16(sp)
    80004056:	64a2                	ld	s1,8(sp)
    80004058:	6902                	ld	s2,0(sp)
    8000405a:	6105                	add	sp,sp,32
    8000405c:	8082                	ret
    pi->readopen = 0;
    8000405e:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80004062:	21c48513          	add	a0,s1,540
    80004066:	ffffd097          	auipc	ra,0xffffd
    8000406a:	78e080e7          	jalr	1934(ra) # 800017f4 <wakeup>
    8000406e:	b7e9                	j	80004038 <pipeclose+0x2c>
    release(&pi->lock);
    80004070:	8526                	mv	a0,s1
    80004072:	00002097          	auipc	ra,0x2
    80004076:	370080e7          	jalr	880(ra) # 800063e2 <release>
}
    8000407a:	bfe1                	j	80004052 <pipeclose+0x46>

000000008000407c <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    8000407c:	711d                	add	sp,sp,-96
    8000407e:	ec86                	sd	ra,88(sp)
    80004080:	e8a2                	sd	s0,80(sp)
    80004082:	e4a6                	sd	s1,72(sp)
    80004084:	e0ca                	sd	s2,64(sp)
    80004086:	fc4e                	sd	s3,56(sp)
    80004088:	f852                	sd	s4,48(sp)
    8000408a:	f456                	sd	s5,40(sp)
    8000408c:	f05a                	sd	s6,32(sp)
    8000408e:	ec5e                	sd	s7,24(sp)
    80004090:	e862                	sd	s8,16(sp)
    80004092:	1080                	add	s0,sp,96
    80004094:	84aa                	mv	s1,a0
    80004096:	8aae                	mv	s5,a1
    80004098:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    8000409a:	ffffd097          	auipc	ra,0xffffd
    8000409e:	04e080e7          	jalr	78(ra) # 800010e8 <myproc>
    800040a2:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    800040a4:	8526                	mv	a0,s1
    800040a6:	00002097          	auipc	ra,0x2
    800040aa:	288080e7          	jalr	648(ra) # 8000632e <acquire>
  while(i < n){
    800040ae:	0b405663          	blez	s4,8000415a <pipewrite+0xde>
  int i = 0;
    800040b2:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    800040b4:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    800040b6:	21848c13          	add	s8,s1,536
      sleep(&pi->nwrite, &pi->lock);
    800040ba:	21c48b93          	add	s7,s1,540
    800040be:	a089                	j	80004100 <pipewrite+0x84>
      release(&pi->lock);
    800040c0:	8526                	mv	a0,s1
    800040c2:	00002097          	auipc	ra,0x2
    800040c6:	320080e7          	jalr	800(ra) # 800063e2 <release>
      return -1;
    800040ca:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    800040cc:	854a                	mv	a0,s2
    800040ce:	60e6                	ld	ra,88(sp)
    800040d0:	6446                	ld	s0,80(sp)
    800040d2:	64a6                	ld	s1,72(sp)
    800040d4:	6906                	ld	s2,64(sp)
    800040d6:	79e2                	ld	s3,56(sp)
    800040d8:	7a42                	ld	s4,48(sp)
    800040da:	7aa2                	ld	s5,40(sp)
    800040dc:	7b02                	ld	s6,32(sp)
    800040de:	6be2                	ld	s7,24(sp)
    800040e0:	6c42                	ld	s8,16(sp)
    800040e2:	6125                	add	sp,sp,96
    800040e4:	8082                	ret
      wakeup(&pi->nread);
    800040e6:	8562                	mv	a0,s8
    800040e8:	ffffd097          	auipc	ra,0xffffd
    800040ec:	70c080e7          	jalr	1804(ra) # 800017f4 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    800040f0:	85a6                	mv	a1,s1
    800040f2:	855e                	mv	a0,s7
    800040f4:	ffffd097          	auipc	ra,0xffffd
    800040f8:	69c080e7          	jalr	1692(ra) # 80001790 <sleep>
  while(i < n){
    800040fc:	07495063          	bge	s2,s4,8000415c <pipewrite+0xe0>
    if(pi->readopen == 0 || killed(pr)){
    80004100:	2204a783          	lw	a5,544(s1)
    80004104:	dfd5                	beqz	a5,800040c0 <pipewrite+0x44>
    80004106:	854e                	mv	a0,s3
    80004108:	ffffe097          	auipc	ra,0xffffe
    8000410c:	930080e7          	jalr	-1744(ra) # 80001a38 <killed>
    80004110:	f945                	bnez	a0,800040c0 <pipewrite+0x44>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80004112:	2184a783          	lw	a5,536(s1)
    80004116:	21c4a703          	lw	a4,540(s1)
    8000411a:	2007879b          	addw	a5,a5,512
    8000411e:	fcf704e3          	beq	a4,a5,800040e6 <pipewrite+0x6a>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004122:	4685                	li	a3,1
    80004124:	01590633          	add	a2,s2,s5
    80004128:	faf40593          	add	a1,s0,-81
    8000412c:	0509b503          	ld	a0,80(s3)
    80004130:	ffffd097          	auipc	ra,0xffffd
    80004134:	b64080e7          	jalr	-1180(ra) # 80000c94 <copyin>
    80004138:	03650263          	beq	a0,s6,8000415c <pipewrite+0xe0>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    8000413c:	21c4a783          	lw	a5,540(s1)
    80004140:	0017871b          	addw	a4,a5,1
    80004144:	20e4ae23          	sw	a4,540(s1)
    80004148:	1ff7f793          	and	a5,a5,511
    8000414c:	97a6                	add	a5,a5,s1
    8000414e:	faf44703          	lbu	a4,-81(s0)
    80004152:	00e78c23          	sb	a4,24(a5)
      i++;
    80004156:	2905                	addw	s2,s2,1
    80004158:	b755                	j	800040fc <pipewrite+0x80>
  int i = 0;
    8000415a:	4901                	li	s2,0
  wakeup(&pi->nread);
    8000415c:	21848513          	add	a0,s1,536
    80004160:	ffffd097          	auipc	ra,0xffffd
    80004164:	694080e7          	jalr	1684(ra) # 800017f4 <wakeup>
  release(&pi->lock);
    80004168:	8526                	mv	a0,s1
    8000416a:	00002097          	auipc	ra,0x2
    8000416e:	278080e7          	jalr	632(ra) # 800063e2 <release>
  return i;
    80004172:	bfa9                	j	800040cc <pipewrite+0x50>

0000000080004174 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80004174:	715d                	add	sp,sp,-80
    80004176:	e486                	sd	ra,72(sp)
    80004178:	e0a2                	sd	s0,64(sp)
    8000417a:	fc26                	sd	s1,56(sp)
    8000417c:	f84a                	sd	s2,48(sp)
    8000417e:	f44e                	sd	s3,40(sp)
    80004180:	f052                	sd	s4,32(sp)
    80004182:	ec56                	sd	s5,24(sp)
    80004184:	e85a                	sd	s6,16(sp)
    80004186:	0880                	add	s0,sp,80
    80004188:	84aa                	mv	s1,a0
    8000418a:	892e                	mv	s2,a1
    8000418c:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    8000418e:	ffffd097          	auipc	ra,0xffffd
    80004192:	f5a080e7          	jalr	-166(ra) # 800010e8 <myproc>
    80004196:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80004198:	8526                	mv	a0,s1
    8000419a:	00002097          	auipc	ra,0x2
    8000419e:	194080e7          	jalr	404(ra) # 8000632e <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800041a2:	2184a703          	lw	a4,536(s1)
    800041a6:	21c4a783          	lw	a5,540(s1)
    if(killed(pr)){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800041aa:	21848993          	add	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800041ae:	02f71763          	bne	a4,a5,800041dc <piperead+0x68>
    800041b2:	2244a783          	lw	a5,548(s1)
    800041b6:	c39d                	beqz	a5,800041dc <piperead+0x68>
    if(killed(pr)){
    800041b8:	8552                	mv	a0,s4
    800041ba:	ffffe097          	auipc	ra,0xffffe
    800041be:	87e080e7          	jalr	-1922(ra) # 80001a38 <killed>
    800041c2:	e949                	bnez	a0,80004254 <piperead+0xe0>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800041c4:	85a6                	mv	a1,s1
    800041c6:	854e                	mv	a0,s3
    800041c8:	ffffd097          	auipc	ra,0xffffd
    800041cc:	5c8080e7          	jalr	1480(ra) # 80001790 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800041d0:	2184a703          	lw	a4,536(s1)
    800041d4:	21c4a783          	lw	a5,540(s1)
    800041d8:	fcf70de3          	beq	a4,a5,800041b2 <piperead+0x3e>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800041dc:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800041de:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800041e0:	05505463          	blez	s5,80004228 <piperead+0xb4>
    if(pi->nread == pi->nwrite)
    800041e4:	2184a783          	lw	a5,536(s1)
    800041e8:	21c4a703          	lw	a4,540(s1)
    800041ec:	02f70e63          	beq	a4,a5,80004228 <piperead+0xb4>
    ch = pi->data[pi->nread++ % PIPESIZE];
    800041f0:	0017871b          	addw	a4,a5,1
    800041f4:	20e4ac23          	sw	a4,536(s1)
    800041f8:	1ff7f793          	and	a5,a5,511
    800041fc:	97a6                	add	a5,a5,s1
    800041fe:	0187c783          	lbu	a5,24(a5)
    80004202:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004206:	4685                	li	a3,1
    80004208:	fbf40613          	add	a2,s0,-65
    8000420c:	85ca                	mv	a1,s2
    8000420e:	050a3503          	ld	a0,80(s4)
    80004212:	ffffd097          	auipc	ra,0xffffd
    80004216:	cbc080e7          	jalr	-836(ra) # 80000ece <copyout>
    8000421a:	01650763          	beq	a0,s6,80004228 <piperead+0xb4>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000421e:	2985                	addw	s3,s3,1
    80004220:	0905                	add	s2,s2,1
    80004222:	fd3a91e3          	bne	s5,s3,800041e4 <piperead+0x70>
    80004226:	89d6                	mv	s3,s5
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80004228:	21c48513          	add	a0,s1,540
    8000422c:	ffffd097          	auipc	ra,0xffffd
    80004230:	5c8080e7          	jalr	1480(ra) # 800017f4 <wakeup>
  release(&pi->lock);
    80004234:	8526                	mv	a0,s1
    80004236:	00002097          	auipc	ra,0x2
    8000423a:	1ac080e7          	jalr	428(ra) # 800063e2 <release>
  return i;
}
    8000423e:	854e                	mv	a0,s3
    80004240:	60a6                	ld	ra,72(sp)
    80004242:	6406                	ld	s0,64(sp)
    80004244:	74e2                	ld	s1,56(sp)
    80004246:	7942                	ld	s2,48(sp)
    80004248:	79a2                	ld	s3,40(sp)
    8000424a:	7a02                	ld	s4,32(sp)
    8000424c:	6ae2                	ld	s5,24(sp)
    8000424e:	6b42                	ld	s6,16(sp)
    80004250:	6161                	add	sp,sp,80
    80004252:	8082                	ret
      release(&pi->lock);
    80004254:	8526                	mv	a0,s1
    80004256:	00002097          	auipc	ra,0x2
    8000425a:	18c080e7          	jalr	396(ra) # 800063e2 <release>
      return -1;
    8000425e:	59fd                	li	s3,-1
    80004260:	bff9                	j	8000423e <piperead+0xca>

0000000080004262 <flags2perm>:
#include "elf.h"

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

int flags2perm(int flags)
{
    80004262:	1141                	add	sp,sp,-16
    80004264:	e422                	sd	s0,8(sp)
    80004266:	0800                	add	s0,sp,16
    80004268:	87aa                	mv	a5,a0
    int perm = 0;
    if(flags & 0x1)
    8000426a:	8905                	and	a0,a0,1
    8000426c:	050e                	sll	a0,a0,0x3
      perm = PTE_X;
    if(flags & 0x2)
    8000426e:	8b89                	and	a5,a5,2
    80004270:	c399                	beqz	a5,80004276 <flags2perm+0x14>
      perm |= PTE_W;
    80004272:	00456513          	or	a0,a0,4
    return perm;
}
    80004276:	6422                	ld	s0,8(sp)
    80004278:	0141                	add	sp,sp,16
    8000427a:	8082                	ret

000000008000427c <exec>:

int
exec(char *path, char **argv)
{
    8000427c:	df010113          	add	sp,sp,-528
    80004280:	20113423          	sd	ra,520(sp)
    80004284:	20813023          	sd	s0,512(sp)
    80004288:	ffa6                	sd	s1,504(sp)
    8000428a:	fbca                	sd	s2,496(sp)
    8000428c:	f7ce                	sd	s3,488(sp)
    8000428e:	f3d2                	sd	s4,480(sp)
    80004290:	efd6                	sd	s5,472(sp)
    80004292:	ebda                	sd	s6,464(sp)
    80004294:	e7de                	sd	s7,456(sp)
    80004296:	e3e2                	sd	s8,448(sp)
    80004298:	ff66                	sd	s9,440(sp)
    8000429a:	fb6a                	sd	s10,432(sp)
    8000429c:	f76e                	sd	s11,424(sp)
    8000429e:	0c00                	add	s0,sp,528
    800042a0:	892a                	mv	s2,a0
    800042a2:	dea43c23          	sd	a0,-520(s0)
    800042a6:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    800042aa:	ffffd097          	auipc	ra,0xffffd
    800042ae:	e3e080e7          	jalr	-450(ra) # 800010e8 <myproc>
    800042b2:	84aa                	mv	s1,a0

  begin_op();
    800042b4:	fffff097          	auipc	ra,0xfffff
    800042b8:	48e080e7          	jalr	1166(ra) # 80003742 <begin_op>

  if((ip = namei(path)) == 0){
    800042bc:	854a                	mv	a0,s2
    800042be:	fffff097          	auipc	ra,0xfffff
    800042c2:	284080e7          	jalr	644(ra) # 80003542 <namei>
    800042c6:	c92d                	beqz	a0,80004338 <exec+0xbc>
    800042c8:	8a2a                	mv	s4,a0
    end_op();
    return -1;
  }
  ilock(ip);
    800042ca:	fffff097          	auipc	ra,0xfffff
    800042ce:	ad2080e7          	jalr	-1326(ra) # 80002d9c <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    800042d2:	04000713          	li	a4,64
    800042d6:	4681                	li	a3,0
    800042d8:	e5040613          	add	a2,s0,-432
    800042dc:	4581                	li	a1,0
    800042de:	8552                	mv	a0,s4
    800042e0:	fffff097          	auipc	ra,0xfffff
    800042e4:	d70080e7          	jalr	-656(ra) # 80003050 <readi>
    800042e8:	04000793          	li	a5,64
    800042ec:	00f51a63          	bne	a0,a5,80004300 <exec+0x84>
    goto bad;

  if(elf.magic != ELF_MAGIC)
    800042f0:	e5042703          	lw	a4,-432(s0)
    800042f4:	464c47b7          	lui	a5,0x464c4
    800042f8:	57f78793          	add	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    800042fc:	04f70463          	beq	a4,a5,80004344 <exec+0xc8>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80004300:	8552                	mv	a0,s4
    80004302:	fffff097          	auipc	ra,0xfffff
    80004306:	cfc080e7          	jalr	-772(ra) # 80002ffe <iunlockput>
    end_op();
    8000430a:	fffff097          	auipc	ra,0xfffff
    8000430e:	4b2080e7          	jalr	1202(ra) # 800037bc <end_op>
  }
  return -1;
    80004312:	557d                	li	a0,-1
}
    80004314:	20813083          	ld	ra,520(sp)
    80004318:	20013403          	ld	s0,512(sp)
    8000431c:	74fe                	ld	s1,504(sp)
    8000431e:	795e                	ld	s2,496(sp)
    80004320:	79be                	ld	s3,488(sp)
    80004322:	7a1e                	ld	s4,480(sp)
    80004324:	6afe                	ld	s5,472(sp)
    80004326:	6b5e                	ld	s6,464(sp)
    80004328:	6bbe                	ld	s7,456(sp)
    8000432a:	6c1e                	ld	s8,448(sp)
    8000432c:	7cfa                	ld	s9,440(sp)
    8000432e:	7d5a                	ld	s10,432(sp)
    80004330:	7dba                	ld	s11,424(sp)
    80004332:	21010113          	add	sp,sp,528
    80004336:	8082                	ret
    end_op();
    80004338:	fffff097          	auipc	ra,0xfffff
    8000433c:	484080e7          	jalr	1156(ra) # 800037bc <end_op>
    return -1;
    80004340:	557d                	li	a0,-1
    80004342:	bfc9                	j	80004314 <exec+0x98>
  if((pagetable = proc_pagetable(p)) == 0)
    80004344:	8526                	mv	a0,s1
    80004346:	ffffd097          	auipc	ra,0xffffd
    8000434a:	e66080e7          	jalr	-410(ra) # 800011ac <proc_pagetable>
    8000434e:	8b2a                	mv	s6,a0
    80004350:	d945                	beqz	a0,80004300 <exec+0x84>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004352:	e7042d03          	lw	s10,-400(s0)
    80004356:	e8845783          	lhu	a5,-376(s0)
    8000435a:	10078463          	beqz	a5,80004462 <exec+0x1e6>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    8000435e:	4901                	li	s2,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004360:	4d81                	li	s11,0
    if(ph.vaddr % PGSIZE != 0)
    80004362:	6c85                	lui	s9,0x1
    80004364:	fffc8793          	add	a5,s9,-1 # fff <_entry-0x7ffff001>
    80004368:	def43823          	sd	a5,-528(s0)

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    if(sz - i < PGSIZE)
    8000436c:	6a85                	lui	s5,0x1
    8000436e:	a0b5                	j	800043da <exec+0x15e>
      panic("loadseg: address should exist");
    80004370:	00004517          	auipc	a0,0x4
    80004374:	31850513          	add	a0,a0,792 # 80008688 <syscalls+0x280>
    80004378:	00002097          	auipc	ra,0x2
    8000437c:	a7e080e7          	jalr	-1410(ra) # 80005df6 <panic>
    if(sz - i < PGSIZE)
    80004380:	2481                	sext.w	s1,s1
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80004382:	8726                	mv	a4,s1
    80004384:	012c06bb          	addw	a3,s8,s2
    80004388:	4581                	li	a1,0
    8000438a:	8552                	mv	a0,s4
    8000438c:	fffff097          	auipc	ra,0xfffff
    80004390:	cc4080e7          	jalr	-828(ra) # 80003050 <readi>
    80004394:	2501                	sext.w	a0,a0
    80004396:	24a49863          	bne	s1,a0,800045e6 <exec+0x36a>
  for(i = 0; i < sz; i += PGSIZE){
    8000439a:	012a893b          	addw	s2,s5,s2
    8000439e:	03397563          	bgeu	s2,s3,800043c8 <exec+0x14c>
    pa = walkaddr(pagetable, va + i);
    800043a2:	02091593          	sll	a1,s2,0x20
    800043a6:	9181                	srl	a1,a1,0x20
    800043a8:	95de                	add	a1,a1,s7
    800043aa:	855a                	mv	a0,s6
    800043ac:	ffffc097          	auipc	ra,0xffffc
    800043b0:	2e0080e7          	jalr	736(ra) # 8000068c <walkaddr>
    800043b4:	862a                	mv	a2,a0
    if(pa == 0)
    800043b6:	dd4d                	beqz	a0,80004370 <exec+0xf4>
    if(sz - i < PGSIZE)
    800043b8:	412984bb          	subw	s1,s3,s2
    800043bc:	0004879b          	sext.w	a5,s1
    800043c0:	fcfcf0e3          	bgeu	s9,a5,80004380 <exec+0x104>
    800043c4:	84d6                	mv	s1,s5
    800043c6:	bf6d                	j	80004380 <exec+0x104>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    800043c8:	e0843903          	ld	s2,-504(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800043cc:	2d85                	addw	s11,s11,1
    800043ce:	038d0d1b          	addw	s10,s10,56
    800043d2:	e8845783          	lhu	a5,-376(s0)
    800043d6:	08fdd763          	bge	s11,a5,80004464 <exec+0x1e8>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    800043da:	2d01                	sext.w	s10,s10
    800043dc:	03800713          	li	a4,56
    800043e0:	86ea                	mv	a3,s10
    800043e2:	e1840613          	add	a2,s0,-488
    800043e6:	4581                	li	a1,0
    800043e8:	8552                	mv	a0,s4
    800043ea:	fffff097          	auipc	ra,0xfffff
    800043ee:	c66080e7          	jalr	-922(ra) # 80003050 <readi>
    800043f2:	03800793          	li	a5,56
    800043f6:	1ef51663          	bne	a0,a5,800045e2 <exec+0x366>
    if(ph.type != ELF_PROG_LOAD)
    800043fa:	e1842783          	lw	a5,-488(s0)
    800043fe:	4705                	li	a4,1
    80004400:	fce796e3          	bne	a5,a4,800043cc <exec+0x150>
    if(ph.memsz < ph.filesz)
    80004404:	e4043483          	ld	s1,-448(s0)
    80004408:	e3843783          	ld	a5,-456(s0)
    8000440c:	1ef4e863          	bltu	s1,a5,800045fc <exec+0x380>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80004410:	e2843783          	ld	a5,-472(s0)
    80004414:	94be                	add	s1,s1,a5
    80004416:	1ef4e663          	bltu	s1,a5,80004602 <exec+0x386>
    if(ph.vaddr % PGSIZE != 0)
    8000441a:	df043703          	ld	a4,-528(s0)
    8000441e:	8ff9                	and	a5,a5,a4
    80004420:	1e079463          	bnez	a5,80004608 <exec+0x38c>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80004424:	e1c42503          	lw	a0,-484(s0)
    80004428:	00000097          	auipc	ra,0x0
    8000442c:	e3a080e7          	jalr	-454(ra) # 80004262 <flags2perm>
    80004430:	86aa                	mv	a3,a0
    80004432:	8626                	mv	a2,s1
    80004434:	85ca                	mv	a1,s2
    80004436:	855a                	mv	a0,s6
    80004438:	ffffc097          	auipc	ra,0xffffc
    8000443c:	608080e7          	jalr	1544(ra) # 80000a40 <uvmalloc>
    80004440:	e0a43423          	sd	a0,-504(s0)
    80004444:	1c050563          	beqz	a0,8000460e <exec+0x392>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80004448:	e2843b83          	ld	s7,-472(s0)
    8000444c:	e2042c03          	lw	s8,-480(s0)
    80004450:	e3842983          	lw	s3,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80004454:	00098463          	beqz	s3,8000445c <exec+0x1e0>
    80004458:	4901                	li	s2,0
    8000445a:	b7a1                	j	800043a2 <exec+0x126>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    8000445c:	e0843903          	ld	s2,-504(s0)
    80004460:	b7b5                	j	800043cc <exec+0x150>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004462:	4901                	li	s2,0
  iunlockput(ip);
    80004464:	8552                	mv	a0,s4
    80004466:	fffff097          	auipc	ra,0xfffff
    8000446a:	b98080e7          	jalr	-1128(ra) # 80002ffe <iunlockput>
  end_op();
    8000446e:	fffff097          	auipc	ra,0xfffff
    80004472:	34e080e7          	jalr	846(ra) # 800037bc <end_op>
  p = myproc();
    80004476:	ffffd097          	auipc	ra,0xffffd
    8000447a:	c72080e7          	jalr	-910(ra) # 800010e8 <myproc>
    8000447e:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    80004480:	04853c83          	ld	s9,72(a0)
  sz = PGROUNDUP(sz);
    80004484:	6985                	lui	s3,0x1
    80004486:	19fd                	add	s3,s3,-1 # fff <_entry-0x7ffff001>
    80004488:	99ca                	add	s3,s3,s2
    8000448a:	77fd                	lui	a5,0xfffff
    8000448c:	00f9f9b3          	and	s3,s3,a5
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
    80004490:	4691                	li	a3,4
    80004492:	6609                	lui	a2,0x2
    80004494:	964e                	add	a2,a2,s3
    80004496:	85ce                	mv	a1,s3
    80004498:	855a                	mv	a0,s6
    8000449a:	ffffc097          	auipc	ra,0xffffc
    8000449e:	5a6080e7          	jalr	1446(ra) # 80000a40 <uvmalloc>
    800044a2:	892a                	mv	s2,a0
    800044a4:	e0a43423          	sd	a0,-504(s0)
    800044a8:	e509                	bnez	a0,800044b2 <exec+0x236>
  if(pagetable)
    800044aa:	e1343423          	sd	s3,-504(s0)
    800044ae:	4a01                	li	s4,0
    800044b0:	aa1d                	j	800045e6 <exec+0x36a>
  uvmclear(pagetable, sz-2*PGSIZE);
    800044b2:	75f9                	lui	a1,0xffffe
    800044b4:	95aa                	add	a1,a1,a0
    800044b6:	855a                	mv	a0,s6
    800044b8:	ffffc097          	auipc	ra,0xffffc
    800044bc:	7aa080e7          	jalr	1962(ra) # 80000c62 <uvmclear>
  stackbase = sp - PGSIZE;
    800044c0:	7bfd                	lui	s7,0xfffff
    800044c2:	9bca                	add	s7,s7,s2
  for(argc = 0; argv[argc]; argc++) {
    800044c4:	e0043783          	ld	a5,-512(s0)
    800044c8:	6388                	ld	a0,0(a5)
    800044ca:	c52d                	beqz	a0,80004534 <exec+0x2b8>
    800044cc:	e9040993          	add	s3,s0,-368
    800044d0:	f9040c13          	add	s8,s0,-112
    800044d4:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    800044d6:	ffffc097          	auipc	ra,0xffffc
    800044da:	fa8080e7          	jalr	-88(ra) # 8000047e <strlen>
    800044de:	0015079b          	addw	a5,a0,1
    800044e2:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    800044e6:	ff07f913          	and	s2,a5,-16
    if(sp < stackbase)
    800044ea:	13796563          	bltu	s2,s7,80004614 <exec+0x398>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    800044ee:	e0043d03          	ld	s10,-512(s0)
    800044f2:	000d3a03          	ld	s4,0(s10)
    800044f6:	8552                	mv	a0,s4
    800044f8:	ffffc097          	auipc	ra,0xffffc
    800044fc:	f86080e7          	jalr	-122(ra) # 8000047e <strlen>
    80004500:	0015069b          	addw	a3,a0,1
    80004504:	8652                	mv	a2,s4
    80004506:	85ca                	mv	a1,s2
    80004508:	855a                	mv	a0,s6
    8000450a:	ffffd097          	auipc	ra,0xffffd
    8000450e:	9c4080e7          	jalr	-1596(ra) # 80000ece <copyout>
    80004512:	10054363          	bltz	a0,80004618 <exec+0x39c>
    ustack[argc] = sp;
    80004516:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    8000451a:	0485                	add	s1,s1,1
    8000451c:	008d0793          	add	a5,s10,8
    80004520:	e0f43023          	sd	a5,-512(s0)
    80004524:	008d3503          	ld	a0,8(s10)
    80004528:	c909                	beqz	a0,8000453a <exec+0x2be>
    if(argc >= MAXARG)
    8000452a:	09a1                	add	s3,s3,8
    8000452c:	fb8995e3          	bne	s3,s8,800044d6 <exec+0x25a>
  ip = 0;
    80004530:	4a01                	li	s4,0
    80004532:	a855                	j	800045e6 <exec+0x36a>
  sp = sz;
    80004534:	e0843903          	ld	s2,-504(s0)
  for(argc = 0; argv[argc]; argc++) {
    80004538:	4481                	li	s1,0
  ustack[argc] = 0;
    8000453a:	00349793          	sll	a5,s1,0x3
    8000453e:	f9078793          	add	a5,a5,-112 # ffffffffffffef90 <end+0xffffffff7ffbd200>
    80004542:	97a2                	add	a5,a5,s0
    80004544:	f007b023          	sd	zero,-256(a5)
  sp -= (argc+1) * sizeof(uint64);
    80004548:	00148693          	add	a3,s1,1
    8000454c:	068e                	sll	a3,a3,0x3
    8000454e:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80004552:	ff097913          	and	s2,s2,-16
  sz = sz1;
    80004556:	e0843983          	ld	s3,-504(s0)
  if(sp < stackbase)
    8000455a:	f57968e3          	bltu	s2,s7,800044aa <exec+0x22e>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    8000455e:	e9040613          	add	a2,s0,-368
    80004562:	85ca                	mv	a1,s2
    80004564:	855a                	mv	a0,s6
    80004566:	ffffd097          	auipc	ra,0xffffd
    8000456a:	968080e7          	jalr	-1688(ra) # 80000ece <copyout>
    8000456e:	0a054763          	bltz	a0,8000461c <exec+0x3a0>
  p->trapframe->a1 = sp;
    80004572:	058ab783          	ld	a5,88(s5) # 1058 <_entry-0x7fffefa8>
    80004576:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    8000457a:	df843783          	ld	a5,-520(s0)
    8000457e:	0007c703          	lbu	a4,0(a5)
    80004582:	cf11                	beqz	a4,8000459e <exec+0x322>
    80004584:	0785                	add	a5,a5,1
    if(*s == '/')
    80004586:	02f00693          	li	a3,47
    8000458a:	a039                	j	80004598 <exec+0x31c>
      last = s+1;
    8000458c:	def43c23          	sd	a5,-520(s0)
  for(last=s=path; *s; s++)
    80004590:	0785                	add	a5,a5,1
    80004592:	fff7c703          	lbu	a4,-1(a5)
    80004596:	c701                	beqz	a4,8000459e <exec+0x322>
    if(*s == '/')
    80004598:	fed71ce3          	bne	a4,a3,80004590 <exec+0x314>
    8000459c:	bfc5                	j	8000458c <exec+0x310>
  safestrcpy(p->name, last, sizeof(p->name));
    8000459e:	4641                	li	a2,16
    800045a0:	df843583          	ld	a1,-520(s0)
    800045a4:	158a8513          	add	a0,s5,344
    800045a8:	ffffc097          	auipc	ra,0xffffc
    800045ac:	ea4080e7          	jalr	-348(ra) # 8000044c <safestrcpy>
  oldpagetable = p->pagetable;
    800045b0:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    800045b4:	056ab823          	sd	s6,80(s5)
  p->sz = sz;
    800045b8:	e0843783          	ld	a5,-504(s0)
    800045bc:	04fab423          	sd	a5,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    800045c0:	058ab783          	ld	a5,88(s5)
    800045c4:	e6843703          	ld	a4,-408(s0)
    800045c8:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    800045ca:	058ab783          	ld	a5,88(s5)
    800045ce:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    800045d2:	85e6                	mv	a1,s9
    800045d4:	ffffd097          	auipc	ra,0xffffd
    800045d8:	c74080e7          	jalr	-908(ra) # 80001248 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    800045dc:	0004851b          	sext.w	a0,s1
    800045e0:	bb15                	j	80004314 <exec+0x98>
    800045e2:	e1243423          	sd	s2,-504(s0)
    proc_freepagetable(pagetable, sz);
    800045e6:	e0843583          	ld	a1,-504(s0)
    800045ea:	855a                	mv	a0,s6
    800045ec:	ffffd097          	auipc	ra,0xffffd
    800045f0:	c5c080e7          	jalr	-932(ra) # 80001248 <proc_freepagetable>
  return -1;
    800045f4:	557d                	li	a0,-1
  if(ip){
    800045f6:	d00a0fe3          	beqz	s4,80004314 <exec+0x98>
    800045fa:	b319                	j	80004300 <exec+0x84>
    800045fc:	e1243423          	sd	s2,-504(s0)
    80004600:	b7dd                	j	800045e6 <exec+0x36a>
    80004602:	e1243423          	sd	s2,-504(s0)
    80004606:	b7c5                	j	800045e6 <exec+0x36a>
    80004608:	e1243423          	sd	s2,-504(s0)
    8000460c:	bfe9                	j	800045e6 <exec+0x36a>
    8000460e:	e1243423          	sd	s2,-504(s0)
    80004612:	bfd1                	j	800045e6 <exec+0x36a>
  ip = 0;
    80004614:	4a01                	li	s4,0
    80004616:	bfc1                	j	800045e6 <exec+0x36a>
    80004618:	4a01                	li	s4,0
  if(pagetable)
    8000461a:	b7f1                	j	800045e6 <exec+0x36a>
  sz = sz1;
    8000461c:	e0843983          	ld	s3,-504(s0)
    80004620:	b569                	j	800044aa <exec+0x22e>

0000000080004622 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80004622:	7179                	add	sp,sp,-48
    80004624:	f406                	sd	ra,40(sp)
    80004626:	f022                	sd	s0,32(sp)
    80004628:	ec26                	sd	s1,24(sp)
    8000462a:	e84a                	sd	s2,16(sp)
    8000462c:	1800                	add	s0,sp,48
    8000462e:	892e                	mv	s2,a1
    80004630:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    80004632:	fdc40593          	add	a1,s0,-36
    80004636:	ffffe097          	auipc	ra,0xffffe
    8000463a:	bf6080e7          	jalr	-1034(ra) # 8000222c <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    8000463e:	fdc42703          	lw	a4,-36(s0)
    80004642:	47bd                	li	a5,15
    80004644:	02e7eb63          	bltu	a5,a4,8000467a <argfd+0x58>
    80004648:	ffffd097          	auipc	ra,0xffffd
    8000464c:	aa0080e7          	jalr	-1376(ra) # 800010e8 <myproc>
    80004650:	fdc42703          	lw	a4,-36(s0)
    80004654:	01a70793          	add	a5,a4,26
    80004658:	078e                	sll	a5,a5,0x3
    8000465a:	953e                	add	a0,a0,a5
    8000465c:	611c                	ld	a5,0(a0)
    8000465e:	c385                	beqz	a5,8000467e <argfd+0x5c>
    return -1;
  if(pfd)
    80004660:	00090463          	beqz	s2,80004668 <argfd+0x46>
    *pfd = fd;
    80004664:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    80004668:	4501                	li	a0,0
  if(pf)
    8000466a:	c091                	beqz	s1,8000466e <argfd+0x4c>
    *pf = f;
    8000466c:	e09c                	sd	a5,0(s1)
}
    8000466e:	70a2                	ld	ra,40(sp)
    80004670:	7402                	ld	s0,32(sp)
    80004672:	64e2                	ld	s1,24(sp)
    80004674:	6942                	ld	s2,16(sp)
    80004676:	6145                	add	sp,sp,48
    80004678:	8082                	ret
    return -1;
    8000467a:	557d                	li	a0,-1
    8000467c:	bfcd                	j	8000466e <argfd+0x4c>
    8000467e:	557d                	li	a0,-1
    80004680:	b7fd                	j	8000466e <argfd+0x4c>

0000000080004682 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80004682:	1101                	add	sp,sp,-32
    80004684:	ec06                	sd	ra,24(sp)
    80004686:	e822                	sd	s0,16(sp)
    80004688:	e426                	sd	s1,8(sp)
    8000468a:	1000                	add	s0,sp,32
    8000468c:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    8000468e:	ffffd097          	auipc	ra,0xffffd
    80004692:	a5a080e7          	jalr	-1446(ra) # 800010e8 <myproc>
    80004696:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    80004698:	0d050793          	add	a5,a0,208
    8000469c:	4501                	li	a0,0
    8000469e:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    800046a0:	6398                	ld	a4,0(a5)
    800046a2:	cb19                	beqz	a4,800046b8 <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    800046a4:	2505                	addw	a0,a0,1
    800046a6:	07a1                	add	a5,a5,8
    800046a8:	fed51ce3          	bne	a0,a3,800046a0 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    800046ac:	557d                	li	a0,-1
}
    800046ae:	60e2                	ld	ra,24(sp)
    800046b0:	6442                	ld	s0,16(sp)
    800046b2:	64a2                	ld	s1,8(sp)
    800046b4:	6105                	add	sp,sp,32
    800046b6:	8082                	ret
      p->ofile[fd] = f;
    800046b8:	01a50793          	add	a5,a0,26
    800046bc:	078e                	sll	a5,a5,0x3
    800046be:	963e                	add	a2,a2,a5
    800046c0:	e204                	sd	s1,0(a2)
      return fd;
    800046c2:	b7f5                	j	800046ae <fdalloc+0x2c>

00000000800046c4 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    800046c4:	715d                	add	sp,sp,-80
    800046c6:	e486                	sd	ra,72(sp)
    800046c8:	e0a2                	sd	s0,64(sp)
    800046ca:	fc26                	sd	s1,56(sp)
    800046cc:	f84a                	sd	s2,48(sp)
    800046ce:	f44e                	sd	s3,40(sp)
    800046d0:	f052                	sd	s4,32(sp)
    800046d2:	ec56                	sd	s5,24(sp)
    800046d4:	e85a                	sd	s6,16(sp)
    800046d6:	0880                	add	s0,sp,80
    800046d8:	8b2e                	mv	s6,a1
    800046da:	89b2                	mv	s3,a2
    800046dc:	8936                	mv	s2,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    800046de:	fb040593          	add	a1,s0,-80
    800046e2:	fffff097          	auipc	ra,0xfffff
    800046e6:	e7e080e7          	jalr	-386(ra) # 80003560 <nameiparent>
    800046ea:	84aa                	mv	s1,a0
    800046ec:	14050b63          	beqz	a0,80004842 <create+0x17e>
    return 0;

  ilock(dp);
    800046f0:	ffffe097          	auipc	ra,0xffffe
    800046f4:	6ac080e7          	jalr	1708(ra) # 80002d9c <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    800046f8:	4601                	li	a2,0
    800046fa:	fb040593          	add	a1,s0,-80
    800046fe:	8526                	mv	a0,s1
    80004700:	fffff097          	auipc	ra,0xfffff
    80004704:	b80080e7          	jalr	-1152(ra) # 80003280 <dirlookup>
    80004708:	8aaa                	mv	s5,a0
    8000470a:	c921                	beqz	a0,8000475a <create+0x96>
    iunlockput(dp);
    8000470c:	8526                	mv	a0,s1
    8000470e:	fffff097          	auipc	ra,0xfffff
    80004712:	8f0080e7          	jalr	-1808(ra) # 80002ffe <iunlockput>
    ilock(ip);
    80004716:	8556                	mv	a0,s5
    80004718:	ffffe097          	auipc	ra,0xffffe
    8000471c:	684080e7          	jalr	1668(ra) # 80002d9c <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80004720:	4789                	li	a5,2
    80004722:	02fb1563          	bne	s6,a5,8000474c <create+0x88>
    80004726:	044ad783          	lhu	a5,68(s5)
    8000472a:	37f9                	addw	a5,a5,-2
    8000472c:	17c2                	sll	a5,a5,0x30
    8000472e:	93c1                	srl	a5,a5,0x30
    80004730:	4705                	li	a4,1
    80004732:	00f76d63          	bltu	a4,a5,8000474c <create+0x88>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    80004736:	8556                	mv	a0,s5
    80004738:	60a6                	ld	ra,72(sp)
    8000473a:	6406                	ld	s0,64(sp)
    8000473c:	74e2                	ld	s1,56(sp)
    8000473e:	7942                	ld	s2,48(sp)
    80004740:	79a2                	ld	s3,40(sp)
    80004742:	7a02                	ld	s4,32(sp)
    80004744:	6ae2                	ld	s5,24(sp)
    80004746:	6b42                	ld	s6,16(sp)
    80004748:	6161                	add	sp,sp,80
    8000474a:	8082                	ret
    iunlockput(ip);
    8000474c:	8556                	mv	a0,s5
    8000474e:	fffff097          	auipc	ra,0xfffff
    80004752:	8b0080e7          	jalr	-1872(ra) # 80002ffe <iunlockput>
    return 0;
    80004756:	4a81                	li	s5,0
    80004758:	bff9                	j	80004736 <create+0x72>
  if((ip = ialloc(dp->dev, type)) == 0){
    8000475a:	85da                	mv	a1,s6
    8000475c:	4088                	lw	a0,0(s1)
    8000475e:	ffffe097          	auipc	ra,0xffffe
    80004762:	4a6080e7          	jalr	1190(ra) # 80002c04 <ialloc>
    80004766:	8a2a                	mv	s4,a0
    80004768:	c529                	beqz	a0,800047b2 <create+0xee>
  ilock(ip);
    8000476a:	ffffe097          	auipc	ra,0xffffe
    8000476e:	632080e7          	jalr	1586(ra) # 80002d9c <ilock>
  ip->major = major;
    80004772:	053a1323          	sh	s3,70(s4)
  ip->minor = minor;
    80004776:	052a1423          	sh	s2,72(s4)
  ip->nlink = 1;
    8000477a:	4905                	li	s2,1
    8000477c:	052a1523          	sh	s2,74(s4)
  iupdate(ip);
    80004780:	8552                	mv	a0,s4
    80004782:	ffffe097          	auipc	ra,0xffffe
    80004786:	54e080e7          	jalr	1358(ra) # 80002cd0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    8000478a:	032b0b63          	beq	s6,s2,800047c0 <create+0xfc>
  if(dirlink(dp, name, ip->inum) < 0)
    8000478e:	004a2603          	lw	a2,4(s4)
    80004792:	fb040593          	add	a1,s0,-80
    80004796:	8526                	mv	a0,s1
    80004798:	fffff097          	auipc	ra,0xfffff
    8000479c:	cf8080e7          	jalr	-776(ra) # 80003490 <dirlink>
    800047a0:	06054f63          	bltz	a0,8000481e <create+0x15a>
  iunlockput(dp);
    800047a4:	8526                	mv	a0,s1
    800047a6:	fffff097          	auipc	ra,0xfffff
    800047aa:	858080e7          	jalr	-1960(ra) # 80002ffe <iunlockput>
  return ip;
    800047ae:	8ad2                	mv	s5,s4
    800047b0:	b759                	j	80004736 <create+0x72>
    iunlockput(dp);
    800047b2:	8526                	mv	a0,s1
    800047b4:	fffff097          	auipc	ra,0xfffff
    800047b8:	84a080e7          	jalr	-1974(ra) # 80002ffe <iunlockput>
    return 0;
    800047bc:	8ad2                	mv	s5,s4
    800047be:	bfa5                	j	80004736 <create+0x72>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    800047c0:	004a2603          	lw	a2,4(s4)
    800047c4:	00004597          	auipc	a1,0x4
    800047c8:	ee458593          	add	a1,a1,-284 # 800086a8 <syscalls+0x2a0>
    800047cc:	8552                	mv	a0,s4
    800047ce:	fffff097          	auipc	ra,0xfffff
    800047d2:	cc2080e7          	jalr	-830(ra) # 80003490 <dirlink>
    800047d6:	04054463          	bltz	a0,8000481e <create+0x15a>
    800047da:	40d0                	lw	a2,4(s1)
    800047dc:	00004597          	auipc	a1,0x4
    800047e0:	ed458593          	add	a1,a1,-300 # 800086b0 <syscalls+0x2a8>
    800047e4:	8552                	mv	a0,s4
    800047e6:	fffff097          	auipc	ra,0xfffff
    800047ea:	caa080e7          	jalr	-854(ra) # 80003490 <dirlink>
    800047ee:	02054863          	bltz	a0,8000481e <create+0x15a>
  if(dirlink(dp, name, ip->inum) < 0)
    800047f2:	004a2603          	lw	a2,4(s4)
    800047f6:	fb040593          	add	a1,s0,-80
    800047fa:	8526                	mv	a0,s1
    800047fc:	fffff097          	auipc	ra,0xfffff
    80004800:	c94080e7          	jalr	-876(ra) # 80003490 <dirlink>
    80004804:	00054d63          	bltz	a0,8000481e <create+0x15a>
    dp->nlink++;  // for ".."
    80004808:	04a4d783          	lhu	a5,74(s1)
    8000480c:	2785                	addw	a5,a5,1
    8000480e:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004812:	8526                	mv	a0,s1
    80004814:	ffffe097          	auipc	ra,0xffffe
    80004818:	4bc080e7          	jalr	1212(ra) # 80002cd0 <iupdate>
    8000481c:	b761                	j	800047a4 <create+0xe0>
  ip->nlink = 0;
    8000481e:	040a1523          	sh	zero,74(s4)
  iupdate(ip);
    80004822:	8552                	mv	a0,s4
    80004824:	ffffe097          	auipc	ra,0xffffe
    80004828:	4ac080e7          	jalr	1196(ra) # 80002cd0 <iupdate>
  iunlockput(ip);
    8000482c:	8552                	mv	a0,s4
    8000482e:	ffffe097          	auipc	ra,0xffffe
    80004832:	7d0080e7          	jalr	2000(ra) # 80002ffe <iunlockput>
  iunlockput(dp);
    80004836:	8526                	mv	a0,s1
    80004838:	ffffe097          	auipc	ra,0xffffe
    8000483c:	7c6080e7          	jalr	1990(ra) # 80002ffe <iunlockput>
  return 0;
    80004840:	bddd                	j	80004736 <create+0x72>
    return 0;
    80004842:	8aaa                	mv	s5,a0
    80004844:	bdcd                	j	80004736 <create+0x72>

0000000080004846 <sys_dup>:
{
    80004846:	7179                	add	sp,sp,-48
    80004848:	f406                	sd	ra,40(sp)
    8000484a:	f022                	sd	s0,32(sp)
    8000484c:	ec26                	sd	s1,24(sp)
    8000484e:	e84a                	sd	s2,16(sp)
    80004850:	1800                	add	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80004852:	fd840613          	add	a2,s0,-40
    80004856:	4581                	li	a1,0
    80004858:	4501                	li	a0,0
    8000485a:	00000097          	auipc	ra,0x0
    8000485e:	dc8080e7          	jalr	-568(ra) # 80004622 <argfd>
    return -1;
    80004862:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80004864:	02054363          	bltz	a0,8000488a <sys_dup+0x44>
  if((fd=fdalloc(f)) < 0)
    80004868:	fd843903          	ld	s2,-40(s0)
    8000486c:	854a                	mv	a0,s2
    8000486e:	00000097          	auipc	ra,0x0
    80004872:	e14080e7          	jalr	-492(ra) # 80004682 <fdalloc>
    80004876:	84aa                	mv	s1,a0
    return -1;
    80004878:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    8000487a:	00054863          	bltz	a0,8000488a <sys_dup+0x44>
  filedup(f);
    8000487e:	854a                	mv	a0,s2
    80004880:	fffff097          	auipc	ra,0xfffff
    80004884:	334080e7          	jalr	820(ra) # 80003bb4 <filedup>
  return fd;
    80004888:	87a6                	mv	a5,s1
}
    8000488a:	853e                	mv	a0,a5
    8000488c:	70a2                	ld	ra,40(sp)
    8000488e:	7402                	ld	s0,32(sp)
    80004890:	64e2                	ld	s1,24(sp)
    80004892:	6942                	ld	s2,16(sp)
    80004894:	6145                	add	sp,sp,48
    80004896:	8082                	ret

0000000080004898 <sys_read>:
{
    80004898:	7179                	add	sp,sp,-48
    8000489a:	f406                	sd	ra,40(sp)
    8000489c:	f022                	sd	s0,32(sp)
    8000489e:	1800                	add	s0,sp,48
  argaddr(1, &p);
    800048a0:	fd840593          	add	a1,s0,-40
    800048a4:	4505                	li	a0,1
    800048a6:	ffffe097          	auipc	ra,0xffffe
    800048aa:	9a6080e7          	jalr	-1626(ra) # 8000224c <argaddr>
  argint(2, &n);
    800048ae:	fe440593          	add	a1,s0,-28
    800048b2:	4509                	li	a0,2
    800048b4:	ffffe097          	auipc	ra,0xffffe
    800048b8:	978080e7          	jalr	-1672(ra) # 8000222c <argint>
  if(argfd(0, 0, &f) < 0)
    800048bc:	fe840613          	add	a2,s0,-24
    800048c0:	4581                	li	a1,0
    800048c2:	4501                	li	a0,0
    800048c4:	00000097          	auipc	ra,0x0
    800048c8:	d5e080e7          	jalr	-674(ra) # 80004622 <argfd>
    800048cc:	87aa                	mv	a5,a0
    return -1;
    800048ce:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    800048d0:	0007cc63          	bltz	a5,800048e8 <sys_read+0x50>
  return fileread(f, p, n);
    800048d4:	fe442603          	lw	a2,-28(s0)
    800048d8:	fd843583          	ld	a1,-40(s0)
    800048dc:	fe843503          	ld	a0,-24(s0)
    800048e0:	fffff097          	auipc	ra,0xfffff
    800048e4:	460080e7          	jalr	1120(ra) # 80003d40 <fileread>
}
    800048e8:	70a2                	ld	ra,40(sp)
    800048ea:	7402                	ld	s0,32(sp)
    800048ec:	6145                	add	sp,sp,48
    800048ee:	8082                	ret

00000000800048f0 <sys_write>:
{
    800048f0:	7179                	add	sp,sp,-48
    800048f2:	f406                	sd	ra,40(sp)
    800048f4:	f022                	sd	s0,32(sp)
    800048f6:	1800                	add	s0,sp,48
  argaddr(1, &p);
    800048f8:	fd840593          	add	a1,s0,-40
    800048fc:	4505                	li	a0,1
    800048fe:	ffffe097          	auipc	ra,0xffffe
    80004902:	94e080e7          	jalr	-1714(ra) # 8000224c <argaddr>
  argint(2, &n);
    80004906:	fe440593          	add	a1,s0,-28
    8000490a:	4509                	li	a0,2
    8000490c:	ffffe097          	auipc	ra,0xffffe
    80004910:	920080e7          	jalr	-1760(ra) # 8000222c <argint>
  if(argfd(0, 0, &f) < 0)
    80004914:	fe840613          	add	a2,s0,-24
    80004918:	4581                	li	a1,0
    8000491a:	4501                	li	a0,0
    8000491c:	00000097          	auipc	ra,0x0
    80004920:	d06080e7          	jalr	-762(ra) # 80004622 <argfd>
    80004924:	87aa                	mv	a5,a0
    return -1;
    80004926:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80004928:	0007cc63          	bltz	a5,80004940 <sys_write+0x50>
  return filewrite(f, p, n);
    8000492c:	fe442603          	lw	a2,-28(s0)
    80004930:	fd843583          	ld	a1,-40(s0)
    80004934:	fe843503          	ld	a0,-24(s0)
    80004938:	fffff097          	auipc	ra,0xfffff
    8000493c:	4ca080e7          	jalr	1226(ra) # 80003e02 <filewrite>
}
    80004940:	70a2                	ld	ra,40(sp)
    80004942:	7402                	ld	s0,32(sp)
    80004944:	6145                	add	sp,sp,48
    80004946:	8082                	ret

0000000080004948 <sys_close>:
{
    80004948:	1101                	add	sp,sp,-32
    8000494a:	ec06                	sd	ra,24(sp)
    8000494c:	e822                	sd	s0,16(sp)
    8000494e:	1000                	add	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    80004950:	fe040613          	add	a2,s0,-32
    80004954:	fec40593          	add	a1,s0,-20
    80004958:	4501                	li	a0,0
    8000495a:	00000097          	auipc	ra,0x0
    8000495e:	cc8080e7          	jalr	-824(ra) # 80004622 <argfd>
    return -1;
    80004962:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80004964:	02054463          	bltz	a0,8000498c <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    80004968:	ffffc097          	auipc	ra,0xffffc
    8000496c:	780080e7          	jalr	1920(ra) # 800010e8 <myproc>
    80004970:	fec42783          	lw	a5,-20(s0)
    80004974:	07e9                	add	a5,a5,26
    80004976:	078e                	sll	a5,a5,0x3
    80004978:	953e                	add	a0,a0,a5
    8000497a:	00053023          	sd	zero,0(a0)
  fileclose(f);
    8000497e:	fe043503          	ld	a0,-32(s0)
    80004982:	fffff097          	auipc	ra,0xfffff
    80004986:	284080e7          	jalr	644(ra) # 80003c06 <fileclose>
  return 0;
    8000498a:	4781                	li	a5,0
}
    8000498c:	853e                	mv	a0,a5
    8000498e:	60e2                	ld	ra,24(sp)
    80004990:	6442                	ld	s0,16(sp)
    80004992:	6105                	add	sp,sp,32
    80004994:	8082                	ret

0000000080004996 <sys_fstat>:
{
    80004996:	1101                	add	sp,sp,-32
    80004998:	ec06                	sd	ra,24(sp)
    8000499a:	e822                	sd	s0,16(sp)
    8000499c:	1000                	add	s0,sp,32
  argaddr(1, &st);
    8000499e:	fe040593          	add	a1,s0,-32
    800049a2:	4505                	li	a0,1
    800049a4:	ffffe097          	auipc	ra,0xffffe
    800049a8:	8a8080e7          	jalr	-1880(ra) # 8000224c <argaddr>
  if(argfd(0, 0, &f) < 0)
    800049ac:	fe840613          	add	a2,s0,-24
    800049b0:	4581                	li	a1,0
    800049b2:	4501                	li	a0,0
    800049b4:	00000097          	auipc	ra,0x0
    800049b8:	c6e080e7          	jalr	-914(ra) # 80004622 <argfd>
    800049bc:	87aa                	mv	a5,a0
    return -1;
    800049be:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    800049c0:	0007ca63          	bltz	a5,800049d4 <sys_fstat+0x3e>
  return filestat(f, st);
    800049c4:	fe043583          	ld	a1,-32(s0)
    800049c8:	fe843503          	ld	a0,-24(s0)
    800049cc:	fffff097          	auipc	ra,0xfffff
    800049d0:	302080e7          	jalr	770(ra) # 80003cce <filestat>
}
    800049d4:	60e2                	ld	ra,24(sp)
    800049d6:	6442                	ld	s0,16(sp)
    800049d8:	6105                	add	sp,sp,32
    800049da:	8082                	ret

00000000800049dc <sys_link>:
{
    800049dc:	7169                	add	sp,sp,-304
    800049de:	f606                	sd	ra,296(sp)
    800049e0:	f222                	sd	s0,288(sp)
    800049e2:	ee26                	sd	s1,280(sp)
    800049e4:	ea4a                	sd	s2,272(sp)
    800049e6:	1a00                	add	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800049e8:	08000613          	li	a2,128
    800049ec:	ed040593          	add	a1,s0,-304
    800049f0:	4501                	li	a0,0
    800049f2:	ffffe097          	auipc	ra,0xffffe
    800049f6:	87a080e7          	jalr	-1926(ra) # 8000226c <argstr>
    return -1;
    800049fa:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800049fc:	10054e63          	bltz	a0,80004b18 <sys_link+0x13c>
    80004a00:	08000613          	li	a2,128
    80004a04:	f5040593          	add	a1,s0,-176
    80004a08:	4505                	li	a0,1
    80004a0a:	ffffe097          	auipc	ra,0xffffe
    80004a0e:	862080e7          	jalr	-1950(ra) # 8000226c <argstr>
    return -1;
    80004a12:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004a14:	10054263          	bltz	a0,80004b18 <sys_link+0x13c>
  begin_op();
    80004a18:	fffff097          	auipc	ra,0xfffff
    80004a1c:	d2a080e7          	jalr	-726(ra) # 80003742 <begin_op>
  if((ip = namei(old)) == 0){
    80004a20:	ed040513          	add	a0,s0,-304
    80004a24:	fffff097          	auipc	ra,0xfffff
    80004a28:	b1e080e7          	jalr	-1250(ra) # 80003542 <namei>
    80004a2c:	84aa                	mv	s1,a0
    80004a2e:	c551                	beqz	a0,80004aba <sys_link+0xde>
  ilock(ip);
    80004a30:	ffffe097          	auipc	ra,0xffffe
    80004a34:	36c080e7          	jalr	876(ra) # 80002d9c <ilock>
  if(ip->type == T_DIR){
    80004a38:	04449703          	lh	a4,68(s1)
    80004a3c:	4785                	li	a5,1
    80004a3e:	08f70463          	beq	a4,a5,80004ac6 <sys_link+0xea>
  ip->nlink++;
    80004a42:	04a4d783          	lhu	a5,74(s1)
    80004a46:	2785                	addw	a5,a5,1
    80004a48:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004a4c:	8526                	mv	a0,s1
    80004a4e:	ffffe097          	auipc	ra,0xffffe
    80004a52:	282080e7          	jalr	642(ra) # 80002cd0 <iupdate>
  iunlock(ip);
    80004a56:	8526                	mv	a0,s1
    80004a58:	ffffe097          	auipc	ra,0xffffe
    80004a5c:	406080e7          	jalr	1030(ra) # 80002e5e <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80004a60:	fd040593          	add	a1,s0,-48
    80004a64:	f5040513          	add	a0,s0,-176
    80004a68:	fffff097          	auipc	ra,0xfffff
    80004a6c:	af8080e7          	jalr	-1288(ra) # 80003560 <nameiparent>
    80004a70:	892a                	mv	s2,a0
    80004a72:	c935                	beqz	a0,80004ae6 <sys_link+0x10a>
  ilock(dp);
    80004a74:	ffffe097          	auipc	ra,0xffffe
    80004a78:	328080e7          	jalr	808(ra) # 80002d9c <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80004a7c:	00092703          	lw	a4,0(s2)
    80004a80:	409c                	lw	a5,0(s1)
    80004a82:	04f71d63          	bne	a4,a5,80004adc <sys_link+0x100>
    80004a86:	40d0                	lw	a2,4(s1)
    80004a88:	fd040593          	add	a1,s0,-48
    80004a8c:	854a                	mv	a0,s2
    80004a8e:	fffff097          	auipc	ra,0xfffff
    80004a92:	a02080e7          	jalr	-1534(ra) # 80003490 <dirlink>
    80004a96:	04054363          	bltz	a0,80004adc <sys_link+0x100>
  iunlockput(dp);
    80004a9a:	854a                	mv	a0,s2
    80004a9c:	ffffe097          	auipc	ra,0xffffe
    80004aa0:	562080e7          	jalr	1378(ra) # 80002ffe <iunlockput>
  iput(ip);
    80004aa4:	8526                	mv	a0,s1
    80004aa6:	ffffe097          	auipc	ra,0xffffe
    80004aaa:	4b0080e7          	jalr	1200(ra) # 80002f56 <iput>
  end_op();
    80004aae:	fffff097          	auipc	ra,0xfffff
    80004ab2:	d0e080e7          	jalr	-754(ra) # 800037bc <end_op>
  return 0;
    80004ab6:	4781                	li	a5,0
    80004ab8:	a085                	j	80004b18 <sys_link+0x13c>
    end_op();
    80004aba:	fffff097          	auipc	ra,0xfffff
    80004abe:	d02080e7          	jalr	-766(ra) # 800037bc <end_op>
    return -1;
    80004ac2:	57fd                	li	a5,-1
    80004ac4:	a891                	j	80004b18 <sys_link+0x13c>
    iunlockput(ip);
    80004ac6:	8526                	mv	a0,s1
    80004ac8:	ffffe097          	auipc	ra,0xffffe
    80004acc:	536080e7          	jalr	1334(ra) # 80002ffe <iunlockput>
    end_op();
    80004ad0:	fffff097          	auipc	ra,0xfffff
    80004ad4:	cec080e7          	jalr	-788(ra) # 800037bc <end_op>
    return -1;
    80004ad8:	57fd                	li	a5,-1
    80004ada:	a83d                	j	80004b18 <sys_link+0x13c>
    iunlockput(dp);
    80004adc:	854a                	mv	a0,s2
    80004ade:	ffffe097          	auipc	ra,0xffffe
    80004ae2:	520080e7          	jalr	1312(ra) # 80002ffe <iunlockput>
  ilock(ip);
    80004ae6:	8526                	mv	a0,s1
    80004ae8:	ffffe097          	auipc	ra,0xffffe
    80004aec:	2b4080e7          	jalr	692(ra) # 80002d9c <ilock>
  ip->nlink--;
    80004af0:	04a4d783          	lhu	a5,74(s1)
    80004af4:	37fd                	addw	a5,a5,-1
    80004af6:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004afa:	8526                	mv	a0,s1
    80004afc:	ffffe097          	auipc	ra,0xffffe
    80004b00:	1d4080e7          	jalr	468(ra) # 80002cd0 <iupdate>
  iunlockput(ip);
    80004b04:	8526                	mv	a0,s1
    80004b06:	ffffe097          	auipc	ra,0xffffe
    80004b0a:	4f8080e7          	jalr	1272(ra) # 80002ffe <iunlockput>
  end_op();
    80004b0e:	fffff097          	auipc	ra,0xfffff
    80004b12:	cae080e7          	jalr	-850(ra) # 800037bc <end_op>
  return -1;
    80004b16:	57fd                	li	a5,-1
}
    80004b18:	853e                	mv	a0,a5
    80004b1a:	70b2                	ld	ra,296(sp)
    80004b1c:	7412                	ld	s0,288(sp)
    80004b1e:	64f2                	ld	s1,280(sp)
    80004b20:	6952                	ld	s2,272(sp)
    80004b22:	6155                	add	sp,sp,304
    80004b24:	8082                	ret

0000000080004b26 <sys_unlink>:
{
    80004b26:	7151                	add	sp,sp,-240
    80004b28:	f586                	sd	ra,232(sp)
    80004b2a:	f1a2                	sd	s0,224(sp)
    80004b2c:	eda6                	sd	s1,216(sp)
    80004b2e:	e9ca                	sd	s2,208(sp)
    80004b30:	e5ce                	sd	s3,200(sp)
    80004b32:	1980                	add	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80004b34:	08000613          	li	a2,128
    80004b38:	f3040593          	add	a1,s0,-208
    80004b3c:	4501                	li	a0,0
    80004b3e:	ffffd097          	auipc	ra,0xffffd
    80004b42:	72e080e7          	jalr	1838(ra) # 8000226c <argstr>
    80004b46:	18054163          	bltz	a0,80004cc8 <sys_unlink+0x1a2>
  begin_op();
    80004b4a:	fffff097          	auipc	ra,0xfffff
    80004b4e:	bf8080e7          	jalr	-1032(ra) # 80003742 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80004b52:	fb040593          	add	a1,s0,-80
    80004b56:	f3040513          	add	a0,s0,-208
    80004b5a:	fffff097          	auipc	ra,0xfffff
    80004b5e:	a06080e7          	jalr	-1530(ra) # 80003560 <nameiparent>
    80004b62:	84aa                	mv	s1,a0
    80004b64:	c979                	beqz	a0,80004c3a <sys_unlink+0x114>
  ilock(dp);
    80004b66:	ffffe097          	auipc	ra,0xffffe
    80004b6a:	236080e7          	jalr	566(ra) # 80002d9c <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80004b6e:	00004597          	auipc	a1,0x4
    80004b72:	b3a58593          	add	a1,a1,-1222 # 800086a8 <syscalls+0x2a0>
    80004b76:	fb040513          	add	a0,s0,-80
    80004b7a:	ffffe097          	auipc	ra,0xffffe
    80004b7e:	6ec080e7          	jalr	1772(ra) # 80003266 <namecmp>
    80004b82:	14050a63          	beqz	a0,80004cd6 <sys_unlink+0x1b0>
    80004b86:	00004597          	auipc	a1,0x4
    80004b8a:	b2a58593          	add	a1,a1,-1238 # 800086b0 <syscalls+0x2a8>
    80004b8e:	fb040513          	add	a0,s0,-80
    80004b92:	ffffe097          	auipc	ra,0xffffe
    80004b96:	6d4080e7          	jalr	1748(ra) # 80003266 <namecmp>
    80004b9a:	12050e63          	beqz	a0,80004cd6 <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    80004b9e:	f2c40613          	add	a2,s0,-212
    80004ba2:	fb040593          	add	a1,s0,-80
    80004ba6:	8526                	mv	a0,s1
    80004ba8:	ffffe097          	auipc	ra,0xffffe
    80004bac:	6d8080e7          	jalr	1752(ra) # 80003280 <dirlookup>
    80004bb0:	892a                	mv	s2,a0
    80004bb2:	12050263          	beqz	a0,80004cd6 <sys_unlink+0x1b0>
  ilock(ip);
    80004bb6:	ffffe097          	auipc	ra,0xffffe
    80004bba:	1e6080e7          	jalr	486(ra) # 80002d9c <ilock>
  if(ip->nlink < 1)
    80004bbe:	04a91783          	lh	a5,74(s2)
    80004bc2:	08f05263          	blez	a5,80004c46 <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004bc6:	04491703          	lh	a4,68(s2)
    80004bca:	4785                	li	a5,1
    80004bcc:	08f70563          	beq	a4,a5,80004c56 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    80004bd0:	4641                	li	a2,16
    80004bd2:	4581                	li	a1,0
    80004bd4:	fc040513          	add	a0,s0,-64
    80004bd8:	ffffb097          	auipc	ra,0xffffb
    80004bdc:	72c080e7          	jalr	1836(ra) # 80000304 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004be0:	4741                	li	a4,16
    80004be2:	f2c42683          	lw	a3,-212(s0)
    80004be6:	fc040613          	add	a2,s0,-64
    80004bea:	4581                	li	a1,0
    80004bec:	8526                	mv	a0,s1
    80004bee:	ffffe097          	auipc	ra,0xffffe
    80004bf2:	55a080e7          	jalr	1370(ra) # 80003148 <writei>
    80004bf6:	47c1                	li	a5,16
    80004bf8:	0af51563          	bne	a0,a5,80004ca2 <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    80004bfc:	04491703          	lh	a4,68(s2)
    80004c00:	4785                	li	a5,1
    80004c02:	0af70863          	beq	a4,a5,80004cb2 <sys_unlink+0x18c>
  iunlockput(dp);
    80004c06:	8526                	mv	a0,s1
    80004c08:	ffffe097          	auipc	ra,0xffffe
    80004c0c:	3f6080e7          	jalr	1014(ra) # 80002ffe <iunlockput>
  ip->nlink--;
    80004c10:	04a95783          	lhu	a5,74(s2)
    80004c14:	37fd                	addw	a5,a5,-1
    80004c16:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80004c1a:	854a                	mv	a0,s2
    80004c1c:	ffffe097          	auipc	ra,0xffffe
    80004c20:	0b4080e7          	jalr	180(ra) # 80002cd0 <iupdate>
  iunlockput(ip);
    80004c24:	854a                	mv	a0,s2
    80004c26:	ffffe097          	auipc	ra,0xffffe
    80004c2a:	3d8080e7          	jalr	984(ra) # 80002ffe <iunlockput>
  end_op();
    80004c2e:	fffff097          	auipc	ra,0xfffff
    80004c32:	b8e080e7          	jalr	-1138(ra) # 800037bc <end_op>
  return 0;
    80004c36:	4501                	li	a0,0
    80004c38:	a84d                	j	80004cea <sys_unlink+0x1c4>
    end_op();
    80004c3a:	fffff097          	auipc	ra,0xfffff
    80004c3e:	b82080e7          	jalr	-1150(ra) # 800037bc <end_op>
    return -1;
    80004c42:	557d                	li	a0,-1
    80004c44:	a05d                	j	80004cea <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    80004c46:	00004517          	auipc	a0,0x4
    80004c4a:	a7250513          	add	a0,a0,-1422 # 800086b8 <syscalls+0x2b0>
    80004c4e:	00001097          	auipc	ra,0x1
    80004c52:	1a8080e7          	jalr	424(ra) # 80005df6 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004c56:	04c92703          	lw	a4,76(s2)
    80004c5a:	02000793          	li	a5,32
    80004c5e:	f6e7f9e3          	bgeu	a5,a4,80004bd0 <sys_unlink+0xaa>
    80004c62:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004c66:	4741                	li	a4,16
    80004c68:	86ce                	mv	a3,s3
    80004c6a:	f1840613          	add	a2,s0,-232
    80004c6e:	4581                	li	a1,0
    80004c70:	854a                	mv	a0,s2
    80004c72:	ffffe097          	auipc	ra,0xffffe
    80004c76:	3de080e7          	jalr	990(ra) # 80003050 <readi>
    80004c7a:	47c1                	li	a5,16
    80004c7c:	00f51b63          	bne	a0,a5,80004c92 <sys_unlink+0x16c>
    if(de.inum != 0)
    80004c80:	f1845783          	lhu	a5,-232(s0)
    80004c84:	e7a1                	bnez	a5,80004ccc <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004c86:	29c1                	addw	s3,s3,16
    80004c88:	04c92783          	lw	a5,76(s2)
    80004c8c:	fcf9ede3          	bltu	s3,a5,80004c66 <sys_unlink+0x140>
    80004c90:	b781                	j	80004bd0 <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80004c92:	00004517          	auipc	a0,0x4
    80004c96:	a3e50513          	add	a0,a0,-1474 # 800086d0 <syscalls+0x2c8>
    80004c9a:	00001097          	auipc	ra,0x1
    80004c9e:	15c080e7          	jalr	348(ra) # 80005df6 <panic>
    panic("unlink: writei");
    80004ca2:	00004517          	auipc	a0,0x4
    80004ca6:	a4650513          	add	a0,a0,-1466 # 800086e8 <syscalls+0x2e0>
    80004caa:	00001097          	auipc	ra,0x1
    80004cae:	14c080e7          	jalr	332(ra) # 80005df6 <panic>
    dp->nlink--;
    80004cb2:	04a4d783          	lhu	a5,74(s1)
    80004cb6:	37fd                	addw	a5,a5,-1
    80004cb8:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004cbc:	8526                	mv	a0,s1
    80004cbe:	ffffe097          	auipc	ra,0xffffe
    80004cc2:	012080e7          	jalr	18(ra) # 80002cd0 <iupdate>
    80004cc6:	b781                	j	80004c06 <sys_unlink+0xe0>
    return -1;
    80004cc8:	557d                	li	a0,-1
    80004cca:	a005                	j	80004cea <sys_unlink+0x1c4>
    iunlockput(ip);
    80004ccc:	854a                	mv	a0,s2
    80004cce:	ffffe097          	auipc	ra,0xffffe
    80004cd2:	330080e7          	jalr	816(ra) # 80002ffe <iunlockput>
  iunlockput(dp);
    80004cd6:	8526                	mv	a0,s1
    80004cd8:	ffffe097          	auipc	ra,0xffffe
    80004cdc:	326080e7          	jalr	806(ra) # 80002ffe <iunlockput>
  end_op();
    80004ce0:	fffff097          	auipc	ra,0xfffff
    80004ce4:	adc080e7          	jalr	-1316(ra) # 800037bc <end_op>
  return -1;
    80004ce8:	557d                	li	a0,-1
}
    80004cea:	70ae                	ld	ra,232(sp)
    80004cec:	740e                	ld	s0,224(sp)
    80004cee:	64ee                	ld	s1,216(sp)
    80004cf0:	694e                	ld	s2,208(sp)
    80004cf2:	69ae                	ld	s3,200(sp)
    80004cf4:	616d                	add	sp,sp,240
    80004cf6:	8082                	ret

0000000080004cf8 <sys_open>:

uint64
sys_open(void)
{
    80004cf8:	7131                	add	sp,sp,-192
    80004cfa:	fd06                	sd	ra,184(sp)
    80004cfc:	f922                	sd	s0,176(sp)
    80004cfe:	f526                	sd	s1,168(sp)
    80004d00:	f14a                	sd	s2,160(sp)
    80004d02:	ed4e                	sd	s3,152(sp)
    80004d04:	0180                	add	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    80004d06:	f4c40593          	add	a1,s0,-180
    80004d0a:	4505                	li	a0,1
    80004d0c:	ffffd097          	auipc	ra,0xffffd
    80004d10:	520080e7          	jalr	1312(ra) # 8000222c <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004d14:	08000613          	li	a2,128
    80004d18:	f5040593          	add	a1,s0,-176
    80004d1c:	4501                	li	a0,0
    80004d1e:	ffffd097          	auipc	ra,0xffffd
    80004d22:	54e080e7          	jalr	1358(ra) # 8000226c <argstr>
    80004d26:	87aa                	mv	a5,a0
    return -1;
    80004d28:	557d                	li	a0,-1
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004d2a:	0a07c863          	bltz	a5,80004dda <sys_open+0xe2>

  begin_op();
    80004d2e:	fffff097          	auipc	ra,0xfffff
    80004d32:	a14080e7          	jalr	-1516(ra) # 80003742 <begin_op>

  if(omode & O_CREATE){
    80004d36:	f4c42783          	lw	a5,-180(s0)
    80004d3a:	2007f793          	and	a5,a5,512
    80004d3e:	cbdd                	beqz	a5,80004df4 <sys_open+0xfc>
    ip = create(path, T_FILE, 0, 0);
    80004d40:	4681                	li	a3,0
    80004d42:	4601                	li	a2,0
    80004d44:	4589                	li	a1,2
    80004d46:	f5040513          	add	a0,s0,-176
    80004d4a:	00000097          	auipc	ra,0x0
    80004d4e:	97a080e7          	jalr	-1670(ra) # 800046c4 <create>
    80004d52:	84aa                	mv	s1,a0
    if(ip == 0){
    80004d54:	c951                	beqz	a0,80004de8 <sys_open+0xf0>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80004d56:	04449703          	lh	a4,68(s1)
    80004d5a:	478d                	li	a5,3
    80004d5c:	00f71763          	bne	a4,a5,80004d6a <sys_open+0x72>
    80004d60:	0464d703          	lhu	a4,70(s1)
    80004d64:	47a5                	li	a5,9
    80004d66:	0ce7ec63          	bltu	a5,a4,80004e3e <sys_open+0x146>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004d6a:	fffff097          	auipc	ra,0xfffff
    80004d6e:	de0080e7          	jalr	-544(ra) # 80003b4a <filealloc>
    80004d72:	892a                	mv	s2,a0
    80004d74:	c56d                	beqz	a0,80004e5e <sys_open+0x166>
    80004d76:	00000097          	auipc	ra,0x0
    80004d7a:	90c080e7          	jalr	-1780(ra) # 80004682 <fdalloc>
    80004d7e:	89aa                	mv	s3,a0
    80004d80:	0c054a63          	bltz	a0,80004e54 <sys_open+0x15c>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004d84:	04449703          	lh	a4,68(s1)
    80004d88:	478d                	li	a5,3
    80004d8a:	0ef70563          	beq	a4,a5,80004e74 <sys_open+0x17c>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004d8e:	4789                	li	a5,2
    80004d90:	00f92023          	sw	a5,0(s2)
    f->off = 0;
    80004d94:	02092023          	sw	zero,32(s2)
  }
  f->ip = ip;
    80004d98:	00993c23          	sd	s1,24(s2)
  f->readable = !(omode & O_WRONLY);
    80004d9c:	f4c42783          	lw	a5,-180(s0)
    80004da0:	0017c713          	xor	a4,a5,1
    80004da4:	8b05                	and	a4,a4,1
    80004da6:	00e90423          	sb	a4,8(s2)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004daa:	0037f713          	and	a4,a5,3
    80004dae:	00e03733          	snez	a4,a4
    80004db2:	00e904a3          	sb	a4,9(s2)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004db6:	4007f793          	and	a5,a5,1024
    80004dba:	c791                	beqz	a5,80004dc6 <sys_open+0xce>
    80004dbc:	04449703          	lh	a4,68(s1)
    80004dc0:	4789                	li	a5,2
    80004dc2:	0cf70063          	beq	a4,a5,80004e82 <sys_open+0x18a>
    itrunc(ip);
  }

  iunlock(ip);
    80004dc6:	8526                	mv	a0,s1
    80004dc8:	ffffe097          	auipc	ra,0xffffe
    80004dcc:	096080e7          	jalr	150(ra) # 80002e5e <iunlock>
  end_op();
    80004dd0:	fffff097          	auipc	ra,0xfffff
    80004dd4:	9ec080e7          	jalr	-1556(ra) # 800037bc <end_op>

  return fd;
    80004dd8:	854e                	mv	a0,s3
}
    80004dda:	70ea                	ld	ra,184(sp)
    80004ddc:	744a                	ld	s0,176(sp)
    80004dde:	74aa                	ld	s1,168(sp)
    80004de0:	790a                	ld	s2,160(sp)
    80004de2:	69ea                	ld	s3,152(sp)
    80004de4:	6129                	add	sp,sp,192
    80004de6:	8082                	ret
      end_op();
    80004de8:	fffff097          	auipc	ra,0xfffff
    80004dec:	9d4080e7          	jalr	-1580(ra) # 800037bc <end_op>
      return -1;
    80004df0:	557d                	li	a0,-1
    80004df2:	b7e5                	j	80004dda <sys_open+0xe2>
    if((ip = namei(path)) == 0){
    80004df4:	f5040513          	add	a0,s0,-176
    80004df8:	ffffe097          	auipc	ra,0xffffe
    80004dfc:	74a080e7          	jalr	1866(ra) # 80003542 <namei>
    80004e00:	84aa                	mv	s1,a0
    80004e02:	c905                	beqz	a0,80004e32 <sys_open+0x13a>
    ilock(ip);
    80004e04:	ffffe097          	auipc	ra,0xffffe
    80004e08:	f98080e7          	jalr	-104(ra) # 80002d9c <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80004e0c:	04449703          	lh	a4,68(s1)
    80004e10:	4785                	li	a5,1
    80004e12:	f4f712e3          	bne	a4,a5,80004d56 <sys_open+0x5e>
    80004e16:	f4c42783          	lw	a5,-180(s0)
    80004e1a:	dba1                	beqz	a5,80004d6a <sys_open+0x72>
      iunlockput(ip);
    80004e1c:	8526                	mv	a0,s1
    80004e1e:	ffffe097          	auipc	ra,0xffffe
    80004e22:	1e0080e7          	jalr	480(ra) # 80002ffe <iunlockput>
      end_op();
    80004e26:	fffff097          	auipc	ra,0xfffff
    80004e2a:	996080e7          	jalr	-1642(ra) # 800037bc <end_op>
      return -1;
    80004e2e:	557d                	li	a0,-1
    80004e30:	b76d                	j	80004dda <sys_open+0xe2>
      end_op();
    80004e32:	fffff097          	auipc	ra,0xfffff
    80004e36:	98a080e7          	jalr	-1654(ra) # 800037bc <end_op>
      return -1;
    80004e3a:	557d                	li	a0,-1
    80004e3c:	bf79                	j	80004dda <sys_open+0xe2>
    iunlockput(ip);
    80004e3e:	8526                	mv	a0,s1
    80004e40:	ffffe097          	auipc	ra,0xffffe
    80004e44:	1be080e7          	jalr	446(ra) # 80002ffe <iunlockput>
    end_op();
    80004e48:	fffff097          	auipc	ra,0xfffff
    80004e4c:	974080e7          	jalr	-1676(ra) # 800037bc <end_op>
    return -1;
    80004e50:	557d                	li	a0,-1
    80004e52:	b761                	j	80004dda <sys_open+0xe2>
      fileclose(f);
    80004e54:	854a                	mv	a0,s2
    80004e56:	fffff097          	auipc	ra,0xfffff
    80004e5a:	db0080e7          	jalr	-592(ra) # 80003c06 <fileclose>
    iunlockput(ip);
    80004e5e:	8526                	mv	a0,s1
    80004e60:	ffffe097          	auipc	ra,0xffffe
    80004e64:	19e080e7          	jalr	414(ra) # 80002ffe <iunlockput>
    end_op();
    80004e68:	fffff097          	auipc	ra,0xfffff
    80004e6c:	954080e7          	jalr	-1708(ra) # 800037bc <end_op>
    return -1;
    80004e70:	557d                	li	a0,-1
    80004e72:	b7a5                	j	80004dda <sys_open+0xe2>
    f->type = FD_DEVICE;
    80004e74:	00f92023          	sw	a5,0(s2)
    f->major = ip->major;
    80004e78:	04649783          	lh	a5,70(s1)
    80004e7c:	02f91223          	sh	a5,36(s2)
    80004e80:	bf21                	j	80004d98 <sys_open+0xa0>
    itrunc(ip);
    80004e82:	8526                	mv	a0,s1
    80004e84:	ffffe097          	auipc	ra,0xffffe
    80004e88:	026080e7          	jalr	38(ra) # 80002eaa <itrunc>
    80004e8c:	bf2d                	j	80004dc6 <sys_open+0xce>

0000000080004e8e <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80004e8e:	7175                	add	sp,sp,-144
    80004e90:	e506                	sd	ra,136(sp)
    80004e92:	e122                	sd	s0,128(sp)
    80004e94:	0900                	add	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80004e96:	fffff097          	auipc	ra,0xfffff
    80004e9a:	8ac080e7          	jalr	-1876(ra) # 80003742 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80004e9e:	08000613          	li	a2,128
    80004ea2:	f7040593          	add	a1,s0,-144
    80004ea6:	4501                	li	a0,0
    80004ea8:	ffffd097          	auipc	ra,0xffffd
    80004eac:	3c4080e7          	jalr	964(ra) # 8000226c <argstr>
    80004eb0:	02054963          	bltz	a0,80004ee2 <sys_mkdir+0x54>
    80004eb4:	4681                	li	a3,0
    80004eb6:	4601                	li	a2,0
    80004eb8:	4585                	li	a1,1
    80004eba:	f7040513          	add	a0,s0,-144
    80004ebe:	00000097          	auipc	ra,0x0
    80004ec2:	806080e7          	jalr	-2042(ra) # 800046c4 <create>
    80004ec6:	cd11                	beqz	a0,80004ee2 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004ec8:	ffffe097          	auipc	ra,0xffffe
    80004ecc:	136080e7          	jalr	310(ra) # 80002ffe <iunlockput>
  end_op();
    80004ed0:	fffff097          	auipc	ra,0xfffff
    80004ed4:	8ec080e7          	jalr	-1812(ra) # 800037bc <end_op>
  return 0;
    80004ed8:	4501                	li	a0,0
}
    80004eda:	60aa                	ld	ra,136(sp)
    80004edc:	640a                	ld	s0,128(sp)
    80004ede:	6149                	add	sp,sp,144
    80004ee0:	8082                	ret
    end_op();
    80004ee2:	fffff097          	auipc	ra,0xfffff
    80004ee6:	8da080e7          	jalr	-1830(ra) # 800037bc <end_op>
    return -1;
    80004eea:	557d                	li	a0,-1
    80004eec:	b7fd                	j	80004eda <sys_mkdir+0x4c>

0000000080004eee <sys_mknod>:

uint64
sys_mknod(void)
{
    80004eee:	7135                	add	sp,sp,-160
    80004ef0:	ed06                	sd	ra,152(sp)
    80004ef2:	e922                	sd	s0,144(sp)
    80004ef4:	1100                	add	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80004ef6:	fffff097          	auipc	ra,0xfffff
    80004efa:	84c080e7          	jalr	-1972(ra) # 80003742 <begin_op>
  argint(1, &major);
    80004efe:	f6c40593          	add	a1,s0,-148
    80004f02:	4505                	li	a0,1
    80004f04:	ffffd097          	auipc	ra,0xffffd
    80004f08:	328080e7          	jalr	808(ra) # 8000222c <argint>
  argint(2, &minor);
    80004f0c:	f6840593          	add	a1,s0,-152
    80004f10:	4509                	li	a0,2
    80004f12:	ffffd097          	auipc	ra,0xffffd
    80004f16:	31a080e7          	jalr	794(ra) # 8000222c <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004f1a:	08000613          	li	a2,128
    80004f1e:	f7040593          	add	a1,s0,-144
    80004f22:	4501                	li	a0,0
    80004f24:	ffffd097          	auipc	ra,0xffffd
    80004f28:	348080e7          	jalr	840(ra) # 8000226c <argstr>
    80004f2c:	02054b63          	bltz	a0,80004f62 <sys_mknod+0x74>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80004f30:	f6841683          	lh	a3,-152(s0)
    80004f34:	f6c41603          	lh	a2,-148(s0)
    80004f38:	458d                	li	a1,3
    80004f3a:	f7040513          	add	a0,s0,-144
    80004f3e:	fffff097          	auipc	ra,0xfffff
    80004f42:	786080e7          	jalr	1926(ra) # 800046c4 <create>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004f46:	cd11                	beqz	a0,80004f62 <sys_mknod+0x74>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004f48:	ffffe097          	auipc	ra,0xffffe
    80004f4c:	0b6080e7          	jalr	182(ra) # 80002ffe <iunlockput>
  end_op();
    80004f50:	fffff097          	auipc	ra,0xfffff
    80004f54:	86c080e7          	jalr	-1940(ra) # 800037bc <end_op>
  return 0;
    80004f58:	4501                	li	a0,0
}
    80004f5a:	60ea                	ld	ra,152(sp)
    80004f5c:	644a                	ld	s0,144(sp)
    80004f5e:	610d                	add	sp,sp,160
    80004f60:	8082                	ret
    end_op();
    80004f62:	fffff097          	auipc	ra,0xfffff
    80004f66:	85a080e7          	jalr	-1958(ra) # 800037bc <end_op>
    return -1;
    80004f6a:	557d                	li	a0,-1
    80004f6c:	b7fd                	j	80004f5a <sys_mknod+0x6c>

0000000080004f6e <sys_chdir>:

uint64
sys_chdir(void)
{
    80004f6e:	7135                	add	sp,sp,-160
    80004f70:	ed06                	sd	ra,152(sp)
    80004f72:	e922                	sd	s0,144(sp)
    80004f74:	e526                	sd	s1,136(sp)
    80004f76:	e14a                	sd	s2,128(sp)
    80004f78:	1100                	add	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80004f7a:	ffffc097          	auipc	ra,0xffffc
    80004f7e:	16e080e7          	jalr	366(ra) # 800010e8 <myproc>
    80004f82:	892a                	mv	s2,a0
  
  begin_op();
    80004f84:	ffffe097          	auipc	ra,0xffffe
    80004f88:	7be080e7          	jalr	1982(ra) # 80003742 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80004f8c:	08000613          	li	a2,128
    80004f90:	f6040593          	add	a1,s0,-160
    80004f94:	4501                	li	a0,0
    80004f96:	ffffd097          	auipc	ra,0xffffd
    80004f9a:	2d6080e7          	jalr	726(ra) # 8000226c <argstr>
    80004f9e:	04054b63          	bltz	a0,80004ff4 <sys_chdir+0x86>
    80004fa2:	f6040513          	add	a0,s0,-160
    80004fa6:	ffffe097          	auipc	ra,0xffffe
    80004faa:	59c080e7          	jalr	1436(ra) # 80003542 <namei>
    80004fae:	84aa                	mv	s1,a0
    80004fb0:	c131                	beqz	a0,80004ff4 <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80004fb2:	ffffe097          	auipc	ra,0xffffe
    80004fb6:	dea080e7          	jalr	-534(ra) # 80002d9c <ilock>
  if(ip->type != T_DIR){
    80004fba:	04449703          	lh	a4,68(s1)
    80004fbe:	4785                	li	a5,1
    80004fc0:	04f71063          	bne	a4,a5,80005000 <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80004fc4:	8526                	mv	a0,s1
    80004fc6:	ffffe097          	auipc	ra,0xffffe
    80004fca:	e98080e7          	jalr	-360(ra) # 80002e5e <iunlock>
  iput(p->cwd);
    80004fce:	15093503          	ld	a0,336(s2)
    80004fd2:	ffffe097          	auipc	ra,0xffffe
    80004fd6:	f84080e7          	jalr	-124(ra) # 80002f56 <iput>
  end_op();
    80004fda:	ffffe097          	auipc	ra,0xffffe
    80004fde:	7e2080e7          	jalr	2018(ra) # 800037bc <end_op>
  p->cwd = ip;
    80004fe2:	14993823          	sd	s1,336(s2)
  return 0;
    80004fe6:	4501                	li	a0,0
}
    80004fe8:	60ea                	ld	ra,152(sp)
    80004fea:	644a                	ld	s0,144(sp)
    80004fec:	64aa                	ld	s1,136(sp)
    80004fee:	690a                	ld	s2,128(sp)
    80004ff0:	610d                	add	sp,sp,160
    80004ff2:	8082                	ret
    end_op();
    80004ff4:	ffffe097          	auipc	ra,0xffffe
    80004ff8:	7c8080e7          	jalr	1992(ra) # 800037bc <end_op>
    return -1;
    80004ffc:	557d                	li	a0,-1
    80004ffe:	b7ed                	j	80004fe8 <sys_chdir+0x7a>
    iunlockput(ip);
    80005000:	8526                	mv	a0,s1
    80005002:	ffffe097          	auipc	ra,0xffffe
    80005006:	ffc080e7          	jalr	-4(ra) # 80002ffe <iunlockput>
    end_op();
    8000500a:	ffffe097          	auipc	ra,0xffffe
    8000500e:	7b2080e7          	jalr	1970(ra) # 800037bc <end_op>
    return -1;
    80005012:	557d                	li	a0,-1
    80005014:	bfd1                	j	80004fe8 <sys_chdir+0x7a>

0000000080005016 <sys_exec>:

uint64
sys_exec(void)
{
    80005016:	7121                	add	sp,sp,-448
    80005018:	ff06                	sd	ra,440(sp)
    8000501a:	fb22                	sd	s0,432(sp)
    8000501c:	f726                	sd	s1,424(sp)
    8000501e:	f34a                	sd	s2,416(sp)
    80005020:	ef4e                	sd	s3,408(sp)
    80005022:	eb52                	sd	s4,400(sp)
    80005024:	0380                	add	s0,sp,448
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    80005026:	e4840593          	add	a1,s0,-440
    8000502a:	4505                	li	a0,1
    8000502c:	ffffd097          	auipc	ra,0xffffd
    80005030:	220080e7          	jalr	544(ra) # 8000224c <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    80005034:	08000613          	li	a2,128
    80005038:	f5040593          	add	a1,s0,-176
    8000503c:	4501                	li	a0,0
    8000503e:	ffffd097          	auipc	ra,0xffffd
    80005042:	22e080e7          	jalr	558(ra) # 8000226c <argstr>
    80005046:	87aa                	mv	a5,a0
    return -1;
    80005048:	557d                	li	a0,-1
  if(argstr(0, path, MAXPATH) < 0) {
    8000504a:	0c07c263          	bltz	a5,8000510e <sys_exec+0xf8>
  }
  memset(argv, 0, sizeof(argv));
    8000504e:	10000613          	li	a2,256
    80005052:	4581                	li	a1,0
    80005054:	e5040513          	add	a0,s0,-432
    80005058:	ffffb097          	auipc	ra,0xffffb
    8000505c:	2ac080e7          	jalr	684(ra) # 80000304 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80005060:	e5040493          	add	s1,s0,-432
  memset(argv, 0, sizeof(argv));
    80005064:	89a6                	mv	s3,s1
    80005066:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    80005068:	02000a13          	li	s4,32
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    8000506c:	00391513          	sll	a0,s2,0x3
    80005070:	e4040593          	add	a1,s0,-448
    80005074:	e4843783          	ld	a5,-440(s0)
    80005078:	953e                	add	a0,a0,a5
    8000507a:	ffffd097          	auipc	ra,0xffffd
    8000507e:	114080e7          	jalr	276(ra) # 8000218e <fetchaddr>
    80005082:	02054a63          	bltz	a0,800050b6 <sys_exec+0xa0>
      goto bad;
    }
    if(uarg == 0){
    80005086:	e4043783          	ld	a5,-448(s0)
    8000508a:	c3b9                	beqz	a5,800050d0 <sys_exec+0xba>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    8000508c:	ffffb097          	auipc	ra,0xffffb
    80005090:	0f8080e7          	jalr	248(ra) # 80000184 <kalloc>
    80005094:	85aa                	mv	a1,a0
    80005096:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    8000509a:	cd11                	beqz	a0,800050b6 <sys_exec+0xa0>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    8000509c:	6605                	lui	a2,0x1
    8000509e:	e4043503          	ld	a0,-448(s0)
    800050a2:	ffffd097          	auipc	ra,0xffffd
    800050a6:	13e080e7          	jalr	318(ra) # 800021e0 <fetchstr>
    800050aa:	00054663          	bltz	a0,800050b6 <sys_exec+0xa0>
    if(i >= NELEM(argv)){
    800050ae:	0905                	add	s2,s2,1
    800050b0:	09a1                	add	s3,s3,8
    800050b2:	fb491de3          	bne	s2,s4,8000506c <sys_exec+0x56>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800050b6:	f5040913          	add	s2,s0,-176
    800050ba:	6088                	ld	a0,0(s1)
    800050bc:	c921                	beqz	a0,8000510c <sys_exec+0xf6>
    kfree(argv[i]);
    800050be:	ffffb097          	auipc	ra,0xffffb
    800050c2:	f5e080e7          	jalr	-162(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800050c6:	04a1                	add	s1,s1,8
    800050c8:	ff2499e3          	bne	s1,s2,800050ba <sys_exec+0xa4>
  return -1;
    800050cc:	557d                	li	a0,-1
    800050ce:	a081                	j	8000510e <sys_exec+0xf8>
      argv[i] = 0;
    800050d0:	0009079b          	sext.w	a5,s2
    800050d4:	078e                	sll	a5,a5,0x3
    800050d6:	fd078793          	add	a5,a5,-48
    800050da:	97a2                	add	a5,a5,s0
    800050dc:	e807b023          	sd	zero,-384(a5)
  int ret = exec(path, argv);
    800050e0:	e5040593          	add	a1,s0,-432
    800050e4:	f5040513          	add	a0,s0,-176
    800050e8:	fffff097          	auipc	ra,0xfffff
    800050ec:	194080e7          	jalr	404(ra) # 8000427c <exec>
    800050f0:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800050f2:	f5040993          	add	s3,s0,-176
    800050f6:	6088                	ld	a0,0(s1)
    800050f8:	c901                	beqz	a0,80005108 <sys_exec+0xf2>
    kfree(argv[i]);
    800050fa:	ffffb097          	auipc	ra,0xffffb
    800050fe:	f22080e7          	jalr	-222(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005102:	04a1                	add	s1,s1,8
    80005104:	ff3499e3          	bne	s1,s3,800050f6 <sys_exec+0xe0>
  return ret;
    80005108:	854a                	mv	a0,s2
    8000510a:	a011                	j	8000510e <sys_exec+0xf8>
  return -1;
    8000510c:	557d                	li	a0,-1
}
    8000510e:	70fa                	ld	ra,440(sp)
    80005110:	745a                	ld	s0,432(sp)
    80005112:	74ba                	ld	s1,424(sp)
    80005114:	791a                	ld	s2,416(sp)
    80005116:	69fa                	ld	s3,408(sp)
    80005118:	6a5a                	ld	s4,400(sp)
    8000511a:	6139                	add	sp,sp,448
    8000511c:	8082                	ret

000000008000511e <sys_pipe>:

uint64
sys_pipe(void)
{
    8000511e:	7139                	add	sp,sp,-64
    80005120:	fc06                	sd	ra,56(sp)
    80005122:	f822                	sd	s0,48(sp)
    80005124:	f426                	sd	s1,40(sp)
    80005126:	0080                	add	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80005128:	ffffc097          	auipc	ra,0xffffc
    8000512c:	fc0080e7          	jalr	-64(ra) # 800010e8 <myproc>
    80005130:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    80005132:	fd840593          	add	a1,s0,-40
    80005136:	4501                	li	a0,0
    80005138:	ffffd097          	auipc	ra,0xffffd
    8000513c:	114080e7          	jalr	276(ra) # 8000224c <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    80005140:	fc840593          	add	a1,s0,-56
    80005144:	fd040513          	add	a0,s0,-48
    80005148:	fffff097          	auipc	ra,0xfffff
    8000514c:	dea080e7          	jalr	-534(ra) # 80003f32 <pipealloc>
    return -1;
    80005150:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80005152:	0c054463          	bltz	a0,8000521a <sys_pipe+0xfc>
  fd0 = -1;
    80005156:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    8000515a:	fd043503          	ld	a0,-48(s0)
    8000515e:	fffff097          	auipc	ra,0xfffff
    80005162:	524080e7          	jalr	1316(ra) # 80004682 <fdalloc>
    80005166:	fca42223          	sw	a0,-60(s0)
    8000516a:	08054b63          	bltz	a0,80005200 <sys_pipe+0xe2>
    8000516e:	fc843503          	ld	a0,-56(s0)
    80005172:	fffff097          	auipc	ra,0xfffff
    80005176:	510080e7          	jalr	1296(ra) # 80004682 <fdalloc>
    8000517a:	fca42023          	sw	a0,-64(s0)
    8000517e:	06054863          	bltz	a0,800051ee <sys_pipe+0xd0>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005182:	4691                	li	a3,4
    80005184:	fc440613          	add	a2,s0,-60
    80005188:	fd843583          	ld	a1,-40(s0)
    8000518c:	68a8                	ld	a0,80(s1)
    8000518e:	ffffc097          	auipc	ra,0xffffc
    80005192:	d40080e7          	jalr	-704(ra) # 80000ece <copyout>
    80005196:	02054063          	bltz	a0,800051b6 <sys_pipe+0x98>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    8000519a:	4691                	li	a3,4
    8000519c:	fc040613          	add	a2,s0,-64
    800051a0:	fd843583          	ld	a1,-40(s0)
    800051a4:	0591                	add	a1,a1,4
    800051a6:	68a8                	ld	a0,80(s1)
    800051a8:	ffffc097          	auipc	ra,0xffffc
    800051ac:	d26080e7          	jalr	-730(ra) # 80000ece <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    800051b0:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800051b2:	06055463          	bgez	a0,8000521a <sys_pipe+0xfc>
    p->ofile[fd0] = 0;
    800051b6:	fc442783          	lw	a5,-60(s0)
    800051ba:	07e9                	add	a5,a5,26
    800051bc:	078e                	sll	a5,a5,0x3
    800051be:	97a6                	add	a5,a5,s1
    800051c0:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    800051c4:	fc042783          	lw	a5,-64(s0)
    800051c8:	07e9                	add	a5,a5,26
    800051ca:	078e                	sll	a5,a5,0x3
    800051cc:	94be                	add	s1,s1,a5
    800051ce:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    800051d2:	fd043503          	ld	a0,-48(s0)
    800051d6:	fffff097          	auipc	ra,0xfffff
    800051da:	a30080e7          	jalr	-1488(ra) # 80003c06 <fileclose>
    fileclose(wf);
    800051de:	fc843503          	ld	a0,-56(s0)
    800051e2:	fffff097          	auipc	ra,0xfffff
    800051e6:	a24080e7          	jalr	-1500(ra) # 80003c06 <fileclose>
    return -1;
    800051ea:	57fd                	li	a5,-1
    800051ec:	a03d                	j	8000521a <sys_pipe+0xfc>
    if(fd0 >= 0)
    800051ee:	fc442783          	lw	a5,-60(s0)
    800051f2:	0007c763          	bltz	a5,80005200 <sys_pipe+0xe2>
      p->ofile[fd0] = 0;
    800051f6:	07e9                	add	a5,a5,26
    800051f8:	078e                	sll	a5,a5,0x3
    800051fa:	97a6                	add	a5,a5,s1
    800051fc:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    80005200:	fd043503          	ld	a0,-48(s0)
    80005204:	fffff097          	auipc	ra,0xfffff
    80005208:	a02080e7          	jalr	-1534(ra) # 80003c06 <fileclose>
    fileclose(wf);
    8000520c:	fc843503          	ld	a0,-56(s0)
    80005210:	fffff097          	auipc	ra,0xfffff
    80005214:	9f6080e7          	jalr	-1546(ra) # 80003c06 <fileclose>
    return -1;
    80005218:	57fd                	li	a5,-1
}
    8000521a:	853e                	mv	a0,a5
    8000521c:	70e2                	ld	ra,56(sp)
    8000521e:	7442                	ld	s0,48(sp)
    80005220:	74a2                	ld	s1,40(sp)
    80005222:	6121                	add	sp,sp,64
    80005224:	8082                	ret
	...

0000000080005230 <kernelvec>:
    80005230:	7111                	add	sp,sp,-256
    80005232:	e006                	sd	ra,0(sp)
    80005234:	e40a                	sd	sp,8(sp)
    80005236:	e80e                	sd	gp,16(sp)
    80005238:	ec12                	sd	tp,24(sp)
    8000523a:	f016                	sd	t0,32(sp)
    8000523c:	f41a                	sd	t1,40(sp)
    8000523e:	f81e                	sd	t2,48(sp)
    80005240:	fc22                	sd	s0,56(sp)
    80005242:	e0a6                	sd	s1,64(sp)
    80005244:	e4aa                	sd	a0,72(sp)
    80005246:	e8ae                	sd	a1,80(sp)
    80005248:	ecb2                	sd	a2,88(sp)
    8000524a:	f0b6                	sd	a3,96(sp)
    8000524c:	f4ba                	sd	a4,104(sp)
    8000524e:	f8be                	sd	a5,112(sp)
    80005250:	fcc2                	sd	a6,120(sp)
    80005252:	e146                	sd	a7,128(sp)
    80005254:	e54a                	sd	s2,136(sp)
    80005256:	e94e                	sd	s3,144(sp)
    80005258:	ed52                	sd	s4,152(sp)
    8000525a:	f156                	sd	s5,160(sp)
    8000525c:	f55a                	sd	s6,168(sp)
    8000525e:	f95e                	sd	s7,176(sp)
    80005260:	fd62                	sd	s8,184(sp)
    80005262:	e1e6                	sd	s9,192(sp)
    80005264:	e5ea                	sd	s10,200(sp)
    80005266:	e9ee                	sd	s11,208(sp)
    80005268:	edf2                	sd	t3,216(sp)
    8000526a:	f1f6                	sd	t4,224(sp)
    8000526c:	f5fa                	sd	t5,232(sp)
    8000526e:	f9fe                	sd	t6,240(sp)
    80005270:	debfc0ef          	jal	8000205a <kerneltrap>
    80005274:	6082                	ld	ra,0(sp)
    80005276:	6122                	ld	sp,8(sp)
    80005278:	61c2                	ld	gp,16(sp)
    8000527a:	7282                	ld	t0,32(sp)
    8000527c:	7322                	ld	t1,40(sp)
    8000527e:	73c2                	ld	t2,48(sp)
    80005280:	7462                	ld	s0,56(sp)
    80005282:	6486                	ld	s1,64(sp)
    80005284:	6526                	ld	a0,72(sp)
    80005286:	65c6                	ld	a1,80(sp)
    80005288:	6666                	ld	a2,88(sp)
    8000528a:	7686                	ld	a3,96(sp)
    8000528c:	7726                	ld	a4,104(sp)
    8000528e:	77c6                	ld	a5,112(sp)
    80005290:	7866                	ld	a6,120(sp)
    80005292:	688a                	ld	a7,128(sp)
    80005294:	692a                	ld	s2,136(sp)
    80005296:	69ca                	ld	s3,144(sp)
    80005298:	6a6a                	ld	s4,152(sp)
    8000529a:	7a8a                	ld	s5,160(sp)
    8000529c:	7b2a                	ld	s6,168(sp)
    8000529e:	7bca                	ld	s7,176(sp)
    800052a0:	7c6a                	ld	s8,184(sp)
    800052a2:	6c8e                	ld	s9,192(sp)
    800052a4:	6d2e                	ld	s10,200(sp)
    800052a6:	6dce                	ld	s11,208(sp)
    800052a8:	6e6e                	ld	t3,216(sp)
    800052aa:	7e8e                	ld	t4,224(sp)
    800052ac:	7f2e                	ld	t5,232(sp)
    800052ae:	7fce                	ld	t6,240(sp)
    800052b0:	6111                	add	sp,sp,256
    800052b2:	10200073          	sret
    800052b6:	00000013          	nop
    800052ba:	00000013          	nop
    800052be:	0001                	nop

00000000800052c0 <timervec>:
    800052c0:	34051573          	csrrw	a0,mscratch,a0
    800052c4:	e10c                	sd	a1,0(a0)
    800052c6:	e510                	sd	a2,8(a0)
    800052c8:	e914                	sd	a3,16(a0)
    800052ca:	6d0c                	ld	a1,24(a0)
    800052cc:	7110                	ld	a2,32(a0)
    800052ce:	6194                	ld	a3,0(a1)
    800052d0:	96b2                	add	a3,a3,a2
    800052d2:	e194                	sd	a3,0(a1)
    800052d4:	4589                	li	a1,2
    800052d6:	14459073          	csrw	sip,a1
    800052da:	6914                	ld	a3,16(a0)
    800052dc:	6510                	ld	a2,8(a0)
    800052de:	610c                	ld	a1,0(a0)
    800052e0:	34051573          	csrrw	a0,mscratch,a0
    800052e4:	30200073          	mret
	...

00000000800052ea <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    800052ea:	1141                	add	sp,sp,-16
    800052ec:	e422                	sd	s0,8(sp)
    800052ee:	0800                	add	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    800052f0:	0c0007b7          	lui	a5,0xc000
    800052f4:	4705                	li	a4,1
    800052f6:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    800052f8:	c3d8                	sw	a4,4(a5)
}
    800052fa:	6422                	ld	s0,8(sp)
    800052fc:	0141                	add	sp,sp,16
    800052fe:	8082                	ret

0000000080005300 <plicinithart>:

void
plicinithart(void)
{
    80005300:	1141                	add	sp,sp,-16
    80005302:	e406                	sd	ra,8(sp)
    80005304:	e022                	sd	s0,0(sp)
    80005306:	0800                	add	s0,sp,16
  int hart = cpuid();
    80005308:	ffffc097          	auipc	ra,0xffffc
    8000530c:	db4080e7          	jalr	-588(ra) # 800010bc <cpuid>
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005310:	0085171b          	sllw	a4,a0,0x8
    80005314:	0c0027b7          	lui	a5,0xc002
    80005318:	97ba                	add	a5,a5,a4
    8000531a:	40200713          	li	a4,1026
    8000531e:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005322:	00d5151b          	sllw	a0,a0,0xd
    80005326:	0c2017b7          	lui	a5,0xc201
    8000532a:	97aa                	add	a5,a5,a0
    8000532c:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80005330:	60a2                	ld	ra,8(sp)
    80005332:	6402                	ld	s0,0(sp)
    80005334:	0141                	add	sp,sp,16
    80005336:	8082                	ret

0000000080005338 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80005338:	1141                	add	sp,sp,-16
    8000533a:	e406                	sd	ra,8(sp)
    8000533c:	e022                	sd	s0,0(sp)
    8000533e:	0800                	add	s0,sp,16
  int hart = cpuid();
    80005340:	ffffc097          	auipc	ra,0xffffc
    80005344:	d7c080e7          	jalr	-644(ra) # 800010bc <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80005348:	00d5151b          	sllw	a0,a0,0xd
    8000534c:	0c2017b7          	lui	a5,0xc201
    80005350:	97aa                	add	a5,a5,a0
  return irq;
}
    80005352:	43c8                	lw	a0,4(a5)
    80005354:	60a2                	ld	ra,8(sp)
    80005356:	6402                	ld	s0,0(sp)
    80005358:	0141                	add	sp,sp,16
    8000535a:	8082                	ret

000000008000535c <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    8000535c:	1101                	add	sp,sp,-32
    8000535e:	ec06                	sd	ra,24(sp)
    80005360:	e822                	sd	s0,16(sp)
    80005362:	e426                	sd	s1,8(sp)
    80005364:	1000                	add	s0,sp,32
    80005366:	84aa                	mv	s1,a0
  int hart = cpuid();
    80005368:	ffffc097          	auipc	ra,0xffffc
    8000536c:	d54080e7          	jalr	-684(ra) # 800010bc <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80005370:	00d5151b          	sllw	a0,a0,0xd
    80005374:	0c2017b7          	lui	a5,0xc201
    80005378:	97aa                	add	a5,a5,a0
    8000537a:	c3c4                	sw	s1,4(a5)
}
    8000537c:	60e2                	ld	ra,24(sp)
    8000537e:	6442                	ld	s0,16(sp)
    80005380:	64a2                	ld	s1,8(sp)
    80005382:	6105                	add	sp,sp,32
    80005384:	8082                	ret

0000000080005386 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80005386:	1141                	add	sp,sp,-16
    80005388:	e406                	sd	ra,8(sp)
    8000538a:	e022                	sd	s0,0(sp)
    8000538c:	0800                	add	s0,sp,16
  if(i >= NUM)
    8000538e:	479d                	li	a5,7
    80005390:	04a7cc63          	blt	a5,a0,800053e8 <free_desc+0x62>
    panic("free_desc 1");
  if(disk.free[i])
    80005394:	00034797          	auipc	a5,0x34
    80005398:	67478793          	add	a5,a5,1652 # 80039a08 <disk>
    8000539c:	97aa                	add	a5,a5,a0
    8000539e:	0187c783          	lbu	a5,24(a5)
    800053a2:	ebb9                	bnez	a5,800053f8 <free_desc+0x72>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    800053a4:	00451693          	sll	a3,a0,0x4
    800053a8:	00034797          	auipc	a5,0x34
    800053ac:	66078793          	add	a5,a5,1632 # 80039a08 <disk>
    800053b0:	6398                	ld	a4,0(a5)
    800053b2:	9736                	add	a4,a4,a3
    800053b4:	00073023          	sd	zero,0(a4)
  disk.desc[i].len = 0;
    800053b8:	6398                	ld	a4,0(a5)
    800053ba:	9736                	add	a4,a4,a3
    800053bc:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    800053c0:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    800053c4:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    800053c8:	97aa                	add	a5,a5,a0
    800053ca:	4705                	li	a4,1
    800053cc:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    800053d0:	00034517          	auipc	a0,0x34
    800053d4:	65050513          	add	a0,a0,1616 # 80039a20 <disk+0x18>
    800053d8:	ffffc097          	auipc	ra,0xffffc
    800053dc:	41c080e7          	jalr	1052(ra) # 800017f4 <wakeup>
}
    800053e0:	60a2                	ld	ra,8(sp)
    800053e2:	6402                	ld	s0,0(sp)
    800053e4:	0141                	add	sp,sp,16
    800053e6:	8082                	ret
    panic("free_desc 1");
    800053e8:	00003517          	auipc	a0,0x3
    800053ec:	31050513          	add	a0,a0,784 # 800086f8 <syscalls+0x2f0>
    800053f0:	00001097          	auipc	ra,0x1
    800053f4:	a06080e7          	jalr	-1530(ra) # 80005df6 <panic>
    panic("free_desc 2");
    800053f8:	00003517          	auipc	a0,0x3
    800053fc:	31050513          	add	a0,a0,784 # 80008708 <syscalls+0x300>
    80005400:	00001097          	auipc	ra,0x1
    80005404:	9f6080e7          	jalr	-1546(ra) # 80005df6 <panic>

0000000080005408 <virtio_disk_init>:
{
    80005408:	1101                	add	sp,sp,-32
    8000540a:	ec06                	sd	ra,24(sp)
    8000540c:	e822                	sd	s0,16(sp)
    8000540e:	e426                	sd	s1,8(sp)
    80005410:	e04a                	sd	s2,0(sp)
    80005412:	1000                	add	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    80005414:	00003597          	auipc	a1,0x3
    80005418:	30458593          	add	a1,a1,772 # 80008718 <syscalls+0x310>
    8000541c:	00034517          	auipc	a0,0x34
    80005420:	71450513          	add	a0,a0,1812 # 80039b30 <disk+0x128>
    80005424:	00001097          	auipc	ra,0x1
    80005428:	e7a080e7          	jalr	-390(ra) # 8000629e <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    8000542c:	100017b7          	lui	a5,0x10001
    80005430:	4398                	lw	a4,0(a5)
    80005432:	2701                	sext.w	a4,a4
    80005434:	747277b7          	lui	a5,0x74727
    80005438:	97678793          	add	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    8000543c:	14f71b63          	bne	a4,a5,80005592 <virtio_disk_init+0x18a>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80005440:	100017b7          	lui	a5,0x10001
    80005444:	43dc                	lw	a5,4(a5)
    80005446:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005448:	4709                	li	a4,2
    8000544a:	14e79463          	bne	a5,a4,80005592 <virtio_disk_init+0x18a>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000544e:	100017b7          	lui	a5,0x10001
    80005452:	479c                	lw	a5,8(a5)
    80005454:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80005456:	12e79e63          	bne	a5,a4,80005592 <virtio_disk_init+0x18a>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    8000545a:	100017b7          	lui	a5,0x10001
    8000545e:	47d8                	lw	a4,12(a5)
    80005460:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005462:	554d47b7          	lui	a5,0x554d4
    80005466:	55178793          	add	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    8000546a:	12f71463          	bne	a4,a5,80005592 <virtio_disk_init+0x18a>
  *R(VIRTIO_MMIO_STATUS) = status;
    8000546e:	100017b7          	lui	a5,0x10001
    80005472:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    80005476:	4705                	li	a4,1
    80005478:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000547a:	470d                	li	a4,3
    8000547c:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    8000547e:	4b98                	lw	a4,16(a5)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80005480:	c7ffe6b7          	lui	a3,0xc7ffe
    80005484:	75f68693          	add	a3,a3,1887 # ffffffffc7ffe75f <end+0xffffffff47fbc9cf>
    80005488:	8f75                	and	a4,a4,a3
    8000548a:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000548c:	472d                	li	a4,11
    8000548e:	dbb8                	sw	a4,112(a5)
  status = *R(VIRTIO_MMIO_STATUS);
    80005490:	5bbc                	lw	a5,112(a5)
    80005492:	0007891b          	sext.w	s2,a5
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    80005496:	8ba1                	and	a5,a5,8
    80005498:	10078563          	beqz	a5,800055a2 <virtio_disk_init+0x19a>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    8000549c:	100017b7          	lui	a5,0x10001
    800054a0:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    800054a4:	43fc                	lw	a5,68(a5)
    800054a6:	2781                	sext.w	a5,a5
    800054a8:	10079563          	bnez	a5,800055b2 <virtio_disk_init+0x1aa>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    800054ac:	100017b7          	lui	a5,0x10001
    800054b0:	5bdc                	lw	a5,52(a5)
    800054b2:	2781                	sext.w	a5,a5
  if(max == 0)
    800054b4:	10078763          	beqz	a5,800055c2 <virtio_disk_init+0x1ba>
  if(max < NUM)
    800054b8:	471d                	li	a4,7
    800054ba:	10f77c63          	bgeu	a4,a5,800055d2 <virtio_disk_init+0x1ca>
  disk.desc = kalloc();
    800054be:	ffffb097          	auipc	ra,0xffffb
    800054c2:	cc6080e7          	jalr	-826(ra) # 80000184 <kalloc>
    800054c6:	00034497          	auipc	s1,0x34
    800054ca:	54248493          	add	s1,s1,1346 # 80039a08 <disk>
    800054ce:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    800054d0:	ffffb097          	auipc	ra,0xffffb
    800054d4:	cb4080e7          	jalr	-844(ra) # 80000184 <kalloc>
    800054d8:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    800054da:	ffffb097          	auipc	ra,0xffffb
    800054de:	caa080e7          	jalr	-854(ra) # 80000184 <kalloc>
    800054e2:	87aa                	mv	a5,a0
    800054e4:	e888                	sd	a0,16(s1)
  if(!disk.desc || !disk.avail || !disk.used)
    800054e6:	6088                	ld	a0,0(s1)
    800054e8:	cd6d                	beqz	a0,800055e2 <virtio_disk_init+0x1da>
    800054ea:	00034717          	auipc	a4,0x34
    800054ee:	52673703          	ld	a4,1318(a4) # 80039a10 <disk+0x8>
    800054f2:	cb65                	beqz	a4,800055e2 <virtio_disk_init+0x1da>
    800054f4:	c7fd                	beqz	a5,800055e2 <virtio_disk_init+0x1da>
  memset(disk.desc, 0, PGSIZE);
    800054f6:	6605                	lui	a2,0x1
    800054f8:	4581                	li	a1,0
    800054fa:	ffffb097          	auipc	ra,0xffffb
    800054fe:	e0a080e7          	jalr	-502(ra) # 80000304 <memset>
  memset(disk.avail, 0, PGSIZE);
    80005502:	00034497          	auipc	s1,0x34
    80005506:	50648493          	add	s1,s1,1286 # 80039a08 <disk>
    8000550a:	6605                	lui	a2,0x1
    8000550c:	4581                	li	a1,0
    8000550e:	6488                	ld	a0,8(s1)
    80005510:	ffffb097          	auipc	ra,0xffffb
    80005514:	df4080e7          	jalr	-524(ra) # 80000304 <memset>
  memset(disk.used, 0, PGSIZE);
    80005518:	6605                	lui	a2,0x1
    8000551a:	4581                	li	a1,0
    8000551c:	6888                	ld	a0,16(s1)
    8000551e:	ffffb097          	auipc	ra,0xffffb
    80005522:	de6080e7          	jalr	-538(ra) # 80000304 <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80005526:	100017b7          	lui	a5,0x10001
    8000552a:	4721                	li	a4,8
    8000552c:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    8000552e:	4098                	lw	a4,0(s1)
    80005530:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    80005534:	40d8                	lw	a4,4(s1)
    80005536:	08e7a223          	sw	a4,132(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    8000553a:	6498                	ld	a4,8(s1)
    8000553c:	0007069b          	sext.w	a3,a4
    80005540:	08d7a823          	sw	a3,144(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    80005544:	9701                	sra	a4,a4,0x20
    80005546:	08e7aa23          	sw	a4,148(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    8000554a:	6898                	ld	a4,16(s1)
    8000554c:	0007069b          	sext.w	a3,a4
    80005550:	0ad7a023          	sw	a3,160(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    80005554:	9701                	sra	a4,a4,0x20
    80005556:	0ae7a223          	sw	a4,164(a5)
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    8000555a:	4705                	li	a4,1
    8000555c:	c3f8                	sw	a4,68(a5)
    disk.free[i] = 1;
    8000555e:	00e48c23          	sb	a4,24(s1)
    80005562:	00e48ca3          	sb	a4,25(s1)
    80005566:	00e48d23          	sb	a4,26(s1)
    8000556a:	00e48da3          	sb	a4,27(s1)
    8000556e:	00e48e23          	sb	a4,28(s1)
    80005572:	00e48ea3          	sb	a4,29(s1)
    80005576:	00e48f23          	sb	a4,30(s1)
    8000557a:	00e48fa3          	sb	a4,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    8000557e:	00496913          	or	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    80005582:	0727a823          	sw	s2,112(a5)
}
    80005586:	60e2                	ld	ra,24(sp)
    80005588:	6442                	ld	s0,16(sp)
    8000558a:	64a2                	ld	s1,8(sp)
    8000558c:	6902                	ld	s2,0(sp)
    8000558e:	6105                	add	sp,sp,32
    80005590:	8082                	ret
    panic("could not find virtio disk");
    80005592:	00003517          	auipc	a0,0x3
    80005596:	19650513          	add	a0,a0,406 # 80008728 <syscalls+0x320>
    8000559a:	00001097          	auipc	ra,0x1
    8000559e:	85c080e7          	jalr	-1956(ra) # 80005df6 <panic>
    panic("virtio disk FEATURES_OK unset");
    800055a2:	00003517          	auipc	a0,0x3
    800055a6:	1a650513          	add	a0,a0,422 # 80008748 <syscalls+0x340>
    800055aa:	00001097          	auipc	ra,0x1
    800055ae:	84c080e7          	jalr	-1972(ra) # 80005df6 <panic>
    panic("virtio disk should not be ready");
    800055b2:	00003517          	auipc	a0,0x3
    800055b6:	1b650513          	add	a0,a0,438 # 80008768 <syscalls+0x360>
    800055ba:	00001097          	auipc	ra,0x1
    800055be:	83c080e7          	jalr	-1988(ra) # 80005df6 <panic>
    panic("virtio disk has no queue 0");
    800055c2:	00003517          	auipc	a0,0x3
    800055c6:	1c650513          	add	a0,a0,454 # 80008788 <syscalls+0x380>
    800055ca:	00001097          	auipc	ra,0x1
    800055ce:	82c080e7          	jalr	-2004(ra) # 80005df6 <panic>
    panic("virtio disk max queue too short");
    800055d2:	00003517          	auipc	a0,0x3
    800055d6:	1d650513          	add	a0,a0,470 # 800087a8 <syscalls+0x3a0>
    800055da:	00001097          	auipc	ra,0x1
    800055de:	81c080e7          	jalr	-2020(ra) # 80005df6 <panic>
    panic("virtio disk kalloc");
    800055e2:	00003517          	auipc	a0,0x3
    800055e6:	1e650513          	add	a0,a0,486 # 800087c8 <syscalls+0x3c0>
    800055ea:	00001097          	auipc	ra,0x1
    800055ee:	80c080e7          	jalr	-2036(ra) # 80005df6 <panic>

00000000800055f2 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    800055f2:	7159                	add	sp,sp,-112
    800055f4:	f486                	sd	ra,104(sp)
    800055f6:	f0a2                	sd	s0,96(sp)
    800055f8:	eca6                	sd	s1,88(sp)
    800055fa:	e8ca                	sd	s2,80(sp)
    800055fc:	e4ce                	sd	s3,72(sp)
    800055fe:	e0d2                	sd	s4,64(sp)
    80005600:	fc56                	sd	s5,56(sp)
    80005602:	f85a                	sd	s6,48(sp)
    80005604:	f45e                	sd	s7,40(sp)
    80005606:	f062                	sd	s8,32(sp)
    80005608:	ec66                	sd	s9,24(sp)
    8000560a:	e86a                	sd	s10,16(sp)
    8000560c:	1880                	add	s0,sp,112
    8000560e:	8a2a                	mv	s4,a0
    80005610:	8bae                	mv	s7,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80005612:	00c52c83          	lw	s9,12(a0)
    80005616:	001c9c9b          	sllw	s9,s9,0x1
    8000561a:	1c82                	sll	s9,s9,0x20
    8000561c:	020cdc93          	srl	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    80005620:	00034517          	auipc	a0,0x34
    80005624:	51050513          	add	a0,a0,1296 # 80039b30 <disk+0x128>
    80005628:	00001097          	auipc	ra,0x1
    8000562c:	d06080e7          	jalr	-762(ra) # 8000632e <acquire>
  for(int i = 0; i < 3; i++){
    80005630:	4901                	li	s2,0
  for(int i = 0; i < NUM; i++){
    80005632:	44a1                	li	s1,8
      disk.free[i] = 0;
    80005634:	00034b17          	auipc	s6,0x34
    80005638:	3d4b0b13          	add	s6,s6,980 # 80039a08 <disk>
  for(int i = 0; i < 3; i++){
    8000563c:	4a8d                	li	s5,3
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    8000563e:	00034c17          	auipc	s8,0x34
    80005642:	4f2c0c13          	add	s8,s8,1266 # 80039b30 <disk+0x128>
    80005646:	a095                	j	800056aa <virtio_disk_rw+0xb8>
      disk.free[i] = 0;
    80005648:	00fb0733          	add	a4,s6,a5
    8000564c:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    80005650:	c11c                	sw	a5,0(a0)
    if(idx[i] < 0){
    80005652:	0207c563          	bltz	a5,8000567c <virtio_disk_rw+0x8a>
  for(int i = 0; i < 3; i++){
    80005656:	2605                	addw	a2,a2,1 # 1001 <_entry-0x7fffefff>
    80005658:	0591                	add	a1,a1,4
    8000565a:	05560d63          	beq	a2,s5,800056b4 <virtio_disk_rw+0xc2>
    idx[i] = alloc_desc();
    8000565e:	852e                	mv	a0,a1
  for(int i = 0; i < NUM; i++){
    80005660:	00034717          	auipc	a4,0x34
    80005664:	3a870713          	add	a4,a4,936 # 80039a08 <disk>
    80005668:	87ca                	mv	a5,s2
    if(disk.free[i]){
    8000566a:	01874683          	lbu	a3,24(a4)
    8000566e:	fee9                	bnez	a3,80005648 <virtio_disk_rw+0x56>
  for(int i = 0; i < NUM; i++){
    80005670:	2785                	addw	a5,a5,1
    80005672:	0705                	add	a4,a4,1
    80005674:	fe979be3          	bne	a5,s1,8000566a <virtio_disk_rw+0x78>
    idx[i] = alloc_desc();
    80005678:	57fd                	li	a5,-1
    8000567a:	c11c                	sw	a5,0(a0)
      for(int j = 0; j < i; j++)
    8000567c:	00c05e63          	blez	a2,80005698 <virtio_disk_rw+0xa6>
    80005680:	060a                	sll	a2,a2,0x2
    80005682:	01360d33          	add	s10,a2,s3
        free_desc(idx[j]);
    80005686:	0009a503          	lw	a0,0(s3)
    8000568a:	00000097          	auipc	ra,0x0
    8000568e:	cfc080e7          	jalr	-772(ra) # 80005386 <free_desc>
      for(int j = 0; j < i; j++)
    80005692:	0991                	add	s3,s3,4
    80005694:	ffa999e3          	bne	s3,s10,80005686 <virtio_disk_rw+0x94>
    sleep(&disk.free[0], &disk.vdisk_lock);
    80005698:	85e2                	mv	a1,s8
    8000569a:	00034517          	auipc	a0,0x34
    8000569e:	38650513          	add	a0,a0,902 # 80039a20 <disk+0x18>
    800056a2:	ffffc097          	auipc	ra,0xffffc
    800056a6:	0ee080e7          	jalr	238(ra) # 80001790 <sleep>
  for(int i = 0; i < 3; i++){
    800056aa:	f9040993          	add	s3,s0,-112
{
    800056ae:	85ce                	mv	a1,s3
  for(int i = 0; i < 3; i++){
    800056b0:	864a                	mv	a2,s2
    800056b2:	b775                	j	8000565e <virtio_disk_rw+0x6c>
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800056b4:	f9042503          	lw	a0,-112(s0)
    800056b8:	00a50713          	add	a4,a0,10
    800056bc:	0712                	sll	a4,a4,0x4

  if(write)
    800056be:	00034797          	auipc	a5,0x34
    800056c2:	34a78793          	add	a5,a5,842 # 80039a08 <disk>
    800056c6:	00e786b3          	add	a3,a5,a4
    800056ca:	01703633          	snez	a2,s7
    800056ce:	c690                	sw	a2,8(a3)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    800056d0:	0006a623          	sw	zero,12(a3)
  buf0->sector = sector;
    800056d4:	0196b823          	sd	s9,16(a3)

  disk.desc[idx[0]].addr = (uint64) buf0;
    800056d8:	f6070613          	add	a2,a4,-160
    800056dc:	6394                	ld	a3,0(a5)
    800056de:	96b2                	add	a3,a3,a2
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800056e0:	00870593          	add	a1,a4,8
    800056e4:	95be                	add	a1,a1,a5
  disk.desc[idx[0]].addr = (uint64) buf0;
    800056e6:	e28c                	sd	a1,0(a3)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    800056e8:	0007b803          	ld	a6,0(a5)
    800056ec:	9642                	add	a2,a2,a6
    800056ee:	46c1                	li	a3,16
    800056f0:	c614                	sw	a3,8(a2)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    800056f2:	4585                	li	a1,1
    800056f4:	00b61623          	sh	a1,12(a2)
  disk.desc[idx[0]].next = idx[1];
    800056f8:	f9442683          	lw	a3,-108(s0)
    800056fc:	00d61723          	sh	a3,14(a2)

  disk.desc[idx[1]].addr = (uint64) b->data;
    80005700:	0692                	sll	a3,a3,0x4
    80005702:	9836                	add	a6,a6,a3
    80005704:	058a0613          	add	a2,s4,88
    80005708:	00c83023          	sd	a2,0(a6)
  disk.desc[idx[1]].len = BSIZE;
    8000570c:	0007b803          	ld	a6,0(a5)
    80005710:	96c2                	add	a3,a3,a6
    80005712:	40000613          	li	a2,1024
    80005716:	c690                	sw	a2,8(a3)
  if(write)
    80005718:	001bb613          	seqz	a2,s7
    8000571c:	0016161b          	sllw	a2,a2,0x1
    disk.desc[idx[1]].flags = 0; // device reads b->data
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80005720:	00166613          	or	a2,a2,1
    80005724:	00c69623          	sh	a2,12(a3)
  disk.desc[idx[1]].next = idx[2];
    80005728:	f9842603          	lw	a2,-104(s0)
    8000572c:	00c69723          	sh	a2,14(a3)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80005730:	00250693          	add	a3,a0,2
    80005734:	0692                	sll	a3,a3,0x4
    80005736:	96be                	add	a3,a3,a5
    80005738:	58fd                	li	a7,-1
    8000573a:	01168823          	sb	a7,16(a3)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    8000573e:	0612                	sll	a2,a2,0x4
    80005740:	9832                	add	a6,a6,a2
    80005742:	f9070713          	add	a4,a4,-112
    80005746:	973e                	add	a4,a4,a5
    80005748:	00e83023          	sd	a4,0(a6)
  disk.desc[idx[2]].len = 1;
    8000574c:	6398                	ld	a4,0(a5)
    8000574e:	9732                	add	a4,a4,a2
    80005750:	c70c                	sw	a1,8(a4)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80005752:	4609                	li	a2,2
    80005754:	00c71623          	sh	a2,12(a4)
  disk.desc[idx[2]].next = 0;
    80005758:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    8000575c:	00ba2223          	sw	a1,4(s4)
  disk.info[idx[0]].b = b;
    80005760:	0146b423          	sd	s4,8(a3)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80005764:	6794                	ld	a3,8(a5)
    80005766:	0026d703          	lhu	a4,2(a3)
    8000576a:	8b1d                	and	a4,a4,7
    8000576c:	0706                	sll	a4,a4,0x1
    8000576e:	96ba                	add	a3,a3,a4
    80005770:	00a69223          	sh	a0,4(a3)

  __sync_synchronize();
    80005774:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80005778:	6798                	ld	a4,8(a5)
    8000577a:	00275783          	lhu	a5,2(a4)
    8000577e:	2785                	addw	a5,a5,1
    80005780:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80005784:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80005788:	100017b7          	lui	a5,0x10001
    8000578c:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80005790:	004a2783          	lw	a5,4(s4)
    sleep(b, &disk.vdisk_lock);
    80005794:	00034917          	auipc	s2,0x34
    80005798:	39c90913          	add	s2,s2,924 # 80039b30 <disk+0x128>
  while(b->disk == 1) {
    8000579c:	4485                	li	s1,1
    8000579e:	00b79c63          	bne	a5,a1,800057b6 <virtio_disk_rw+0x1c4>
    sleep(b, &disk.vdisk_lock);
    800057a2:	85ca                	mv	a1,s2
    800057a4:	8552                	mv	a0,s4
    800057a6:	ffffc097          	auipc	ra,0xffffc
    800057aa:	fea080e7          	jalr	-22(ra) # 80001790 <sleep>
  while(b->disk == 1) {
    800057ae:	004a2783          	lw	a5,4(s4)
    800057b2:	fe9788e3          	beq	a5,s1,800057a2 <virtio_disk_rw+0x1b0>
  }

  disk.info[idx[0]].b = 0;
    800057b6:	f9042903          	lw	s2,-112(s0)
    800057ba:	00290713          	add	a4,s2,2
    800057be:	0712                	sll	a4,a4,0x4
    800057c0:	00034797          	auipc	a5,0x34
    800057c4:	24878793          	add	a5,a5,584 # 80039a08 <disk>
    800057c8:	97ba                	add	a5,a5,a4
    800057ca:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    800057ce:	00034997          	auipc	s3,0x34
    800057d2:	23a98993          	add	s3,s3,570 # 80039a08 <disk>
    800057d6:	00491713          	sll	a4,s2,0x4
    800057da:	0009b783          	ld	a5,0(s3)
    800057de:	97ba                	add	a5,a5,a4
    800057e0:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    800057e4:	854a                	mv	a0,s2
    800057e6:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    800057ea:	00000097          	auipc	ra,0x0
    800057ee:	b9c080e7          	jalr	-1124(ra) # 80005386 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    800057f2:	8885                	and	s1,s1,1
    800057f4:	f0ed                	bnez	s1,800057d6 <virtio_disk_rw+0x1e4>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    800057f6:	00034517          	auipc	a0,0x34
    800057fa:	33a50513          	add	a0,a0,826 # 80039b30 <disk+0x128>
    800057fe:	00001097          	auipc	ra,0x1
    80005802:	be4080e7          	jalr	-1052(ra) # 800063e2 <release>
}
    80005806:	70a6                	ld	ra,104(sp)
    80005808:	7406                	ld	s0,96(sp)
    8000580a:	64e6                	ld	s1,88(sp)
    8000580c:	6946                	ld	s2,80(sp)
    8000580e:	69a6                	ld	s3,72(sp)
    80005810:	6a06                	ld	s4,64(sp)
    80005812:	7ae2                	ld	s5,56(sp)
    80005814:	7b42                	ld	s6,48(sp)
    80005816:	7ba2                	ld	s7,40(sp)
    80005818:	7c02                	ld	s8,32(sp)
    8000581a:	6ce2                	ld	s9,24(sp)
    8000581c:	6d42                	ld	s10,16(sp)
    8000581e:	6165                	add	sp,sp,112
    80005820:	8082                	ret

0000000080005822 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80005822:	1101                	add	sp,sp,-32
    80005824:	ec06                	sd	ra,24(sp)
    80005826:	e822                	sd	s0,16(sp)
    80005828:	e426                	sd	s1,8(sp)
    8000582a:	1000                	add	s0,sp,32
  acquire(&disk.vdisk_lock);
    8000582c:	00034497          	auipc	s1,0x34
    80005830:	1dc48493          	add	s1,s1,476 # 80039a08 <disk>
    80005834:	00034517          	auipc	a0,0x34
    80005838:	2fc50513          	add	a0,a0,764 # 80039b30 <disk+0x128>
    8000583c:	00001097          	auipc	ra,0x1
    80005840:	af2080e7          	jalr	-1294(ra) # 8000632e <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80005844:	10001737          	lui	a4,0x10001
    80005848:	533c                	lw	a5,96(a4)
    8000584a:	8b8d                	and	a5,a5,3
    8000584c:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    8000584e:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80005852:	689c                	ld	a5,16(s1)
    80005854:	0204d703          	lhu	a4,32(s1)
    80005858:	0027d783          	lhu	a5,2(a5)
    8000585c:	04f70863          	beq	a4,a5,800058ac <virtio_disk_intr+0x8a>
    __sync_synchronize();
    80005860:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80005864:	6898                	ld	a4,16(s1)
    80005866:	0204d783          	lhu	a5,32(s1)
    8000586a:	8b9d                	and	a5,a5,7
    8000586c:	078e                	sll	a5,a5,0x3
    8000586e:	97ba                	add	a5,a5,a4
    80005870:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80005872:	00278713          	add	a4,a5,2
    80005876:	0712                	sll	a4,a4,0x4
    80005878:	9726                	add	a4,a4,s1
    8000587a:	01074703          	lbu	a4,16(a4) # 10001010 <_entry-0x6fffeff0>
    8000587e:	e721                	bnez	a4,800058c6 <virtio_disk_intr+0xa4>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80005880:	0789                	add	a5,a5,2
    80005882:	0792                	sll	a5,a5,0x4
    80005884:	97a6                	add	a5,a5,s1
    80005886:	6788                	ld	a0,8(a5)
    b->disk = 0;   // disk is done with buf
    80005888:	00052223          	sw	zero,4(a0)
    wakeup(b);
    8000588c:	ffffc097          	auipc	ra,0xffffc
    80005890:	f68080e7          	jalr	-152(ra) # 800017f4 <wakeup>

    disk.used_idx += 1;
    80005894:	0204d783          	lhu	a5,32(s1)
    80005898:	2785                	addw	a5,a5,1
    8000589a:	17c2                	sll	a5,a5,0x30
    8000589c:	93c1                	srl	a5,a5,0x30
    8000589e:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    800058a2:	6898                	ld	a4,16(s1)
    800058a4:	00275703          	lhu	a4,2(a4)
    800058a8:	faf71ce3          	bne	a4,a5,80005860 <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    800058ac:	00034517          	auipc	a0,0x34
    800058b0:	28450513          	add	a0,a0,644 # 80039b30 <disk+0x128>
    800058b4:	00001097          	auipc	ra,0x1
    800058b8:	b2e080e7          	jalr	-1234(ra) # 800063e2 <release>
}
    800058bc:	60e2                	ld	ra,24(sp)
    800058be:	6442                	ld	s0,16(sp)
    800058c0:	64a2                	ld	s1,8(sp)
    800058c2:	6105                	add	sp,sp,32
    800058c4:	8082                	ret
      panic("virtio_disk_intr status");
    800058c6:	00003517          	auipc	a0,0x3
    800058ca:	f1a50513          	add	a0,a0,-230 # 800087e0 <syscalls+0x3d8>
    800058ce:	00000097          	auipc	ra,0x0
    800058d2:	528080e7          	jalr	1320(ra) # 80005df6 <panic>

00000000800058d6 <timerinit>:
// at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    800058d6:	1141                	add	sp,sp,-16
    800058d8:	e422                	sd	s0,8(sp)
    800058da:	0800                	add	s0,sp,16
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800058dc:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    800058e0:	0007859b          	sext.w	a1,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    800058e4:	0037979b          	sllw	a5,a5,0x3
    800058e8:	02004737          	lui	a4,0x2004
    800058ec:	97ba                	add	a5,a5,a4
    800058ee:	0200c737          	lui	a4,0x200c
    800058f2:	ff873703          	ld	a4,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800058f6:	000f4637          	lui	a2,0xf4
    800058fa:	24060613          	add	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800058fe:	9732                	add	a4,a4,a2
    80005900:	e398                	sd	a4,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    80005902:	00259693          	sll	a3,a1,0x2
    80005906:	96ae                	add	a3,a3,a1
    80005908:	068e                	sll	a3,a3,0x3
    8000590a:	00034717          	auipc	a4,0x34
    8000590e:	24670713          	add	a4,a4,582 # 80039b50 <timer_scratch>
    80005912:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    80005914:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    80005916:	f310                	sd	a2,32(a4)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80005918:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    8000591c:	00000797          	auipc	a5,0x0
    80005920:	9a478793          	add	a5,a5,-1628 # 800052c0 <timervec>
    80005924:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005928:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    8000592c:	0087e793          	or	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005930:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    80005934:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80005938:	0807e793          	or	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    8000593c:	30479073          	csrw	mie,a5
}
    80005940:	6422                	ld	s0,8(sp)
    80005942:	0141                	add	sp,sp,16
    80005944:	8082                	ret

0000000080005946 <start>:
{
    80005946:	1141                	add	sp,sp,-16
    80005948:	e406                	sd	ra,8(sp)
    8000594a:	e022                	sd	s0,0(sp)
    8000594c:	0800                	add	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    8000594e:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80005952:	7779                	lui	a4,0xffffe
    80005954:	7ff70713          	add	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffbca6f>
    80005958:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    8000595a:	6705                	lui	a4,0x1
    8000595c:	80070713          	add	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005960:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005962:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80005966:	ffffb797          	auipc	a5,0xffffb
    8000596a:	b4278793          	add	a5,a5,-1214 # 800004a8 <main>
    8000596e:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80005972:	4781                	li	a5,0
    80005974:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80005978:	67c1                	lui	a5,0x10
    8000597a:	17fd                	add	a5,a5,-1 # ffff <_entry-0x7fff0001>
    8000597c:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80005980:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80005984:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80005988:	2227e793          	or	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    8000598c:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80005990:	57fd                	li	a5,-1
    80005992:	83a9                	srl	a5,a5,0xa
    80005994:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80005998:	47bd                	li	a5,15
    8000599a:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    8000599e:	00000097          	auipc	ra,0x0
    800059a2:	f38080e7          	jalr	-200(ra) # 800058d6 <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800059a6:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    800059aa:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    800059ac:	823e                	mv	tp,a5
  asm volatile("mret");
    800059ae:	30200073          	mret
}
    800059b2:	60a2                	ld	ra,8(sp)
    800059b4:	6402                	ld	s0,0(sp)
    800059b6:	0141                	add	sp,sp,16
    800059b8:	8082                	ret

00000000800059ba <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    800059ba:	715d                	add	sp,sp,-80
    800059bc:	e486                	sd	ra,72(sp)
    800059be:	e0a2                	sd	s0,64(sp)
    800059c0:	fc26                	sd	s1,56(sp)
    800059c2:	f84a                	sd	s2,48(sp)
    800059c4:	f44e                	sd	s3,40(sp)
    800059c6:	f052                	sd	s4,32(sp)
    800059c8:	ec56                	sd	s5,24(sp)
    800059ca:	0880                	add	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    800059cc:	04c05763          	blez	a2,80005a1a <consolewrite+0x60>
    800059d0:	8a2a                	mv	s4,a0
    800059d2:	84ae                	mv	s1,a1
    800059d4:	89b2                	mv	s3,a2
    800059d6:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    800059d8:	5afd                	li	s5,-1
    800059da:	4685                	li	a3,1
    800059dc:	8626                	mv	a2,s1
    800059de:	85d2                	mv	a1,s4
    800059e0:	fbf40513          	add	a0,s0,-65
    800059e4:	ffffc097          	auipc	ra,0xffffc
    800059e8:	20a080e7          	jalr	522(ra) # 80001bee <either_copyin>
    800059ec:	01550d63          	beq	a0,s5,80005a06 <consolewrite+0x4c>
      break;
    uartputc(c);
    800059f0:	fbf44503          	lbu	a0,-65(s0)
    800059f4:	00000097          	auipc	ra,0x0
    800059f8:	780080e7          	jalr	1920(ra) # 80006174 <uartputc>
  for(i = 0; i < n; i++){
    800059fc:	2905                	addw	s2,s2,1
    800059fe:	0485                	add	s1,s1,1
    80005a00:	fd299de3          	bne	s3,s2,800059da <consolewrite+0x20>
    80005a04:	894e                	mv	s2,s3
  }

  return i;
}
    80005a06:	854a                	mv	a0,s2
    80005a08:	60a6                	ld	ra,72(sp)
    80005a0a:	6406                	ld	s0,64(sp)
    80005a0c:	74e2                	ld	s1,56(sp)
    80005a0e:	7942                	ld	s2,48(sp)
    80005a10:	79a2                	ld	s3,40(sp)
    80005a12:	7a02                	ld	s4,32(sp)
    80005a14:	6ae2                	ld	s5,24(sp)
    80005a16:	6161                	add	sp,sp,80
    80005a18:	8082                	ret
  for(i = 0; i < n; i++){
    80005a1a:	4901                	li	s2,0
    80005a1c:	b7ed                	j	80005a06 <consolewrite+0x4c>

0000000080005a1e <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80005a1e:	711d                	add	sp,sp,-96
    80005a20:	ec86                	sd	ra,88(sp)
    80005a22:	e8a2                	sd	s0,80(sp)
    80005a24:	e4a6                	sd	s1,72(sp)
    80005a26:	e0ca                	sd	s2,64(sp)
    80005a28:	fc4e                	sd	s3,56(sp)
    80005a2a:	f852                	sd	s4,48(sp)
    80005a2c:	f456                	sd	s5,40(sp)
    80005a2e:	f05a                	sd	s6,32(sp)
    80005a30:	ec5e                	sd	s7,24(sp)
    80005a32:	1080                	add	s0,sp,96
    80005a34:	8aaa                	mv	s5,a0
    80005a36:	8a2e                	mv	s4,a1
    80005a38:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80005a3a:	00060b1b          	sext.w	s6,a2
  acquire(&cons.lock);
    80005a3e:	0003c517          	auipc	a0,0x3c
    80005a42:	25250513          	add	a0,a0,594 # 80041c90 <cons>
    80005a46:	00001097          	auipc	ra,0x1
    80005a4a:	8e8080e7          	jalr	-1816(ra) # 8000632e <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80005a4e:	0003c497          	auipc	s1,0x3c
    80005a52:	24248493          	add	s1,s1,578 # 80041c90 <cons>
      if(killed(myproc())){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80005a56:	0003c917          	auipc	s2,0x3c
    80005a5a:	2d290913          	add	s2,s2,722 # 80041d28 <cons+0x98>
  while(n > 0){
    80005a5e:	09305263          	blez	s3,80005ae2 <consoleread+0xc4>
    while(cons.r == cons.w){
    80005a62:	0984a783          	lw	a5,152(s1)
    80005a66:	09c4a703          	lw	a4,156(s1)
    80005a6a:	02f71763          	bne	a4,a5,80005a98 <consoleread+0x7a>
      if(killed(myproc())){
    80005a6e:	ffffb097          	auipc	ra,0xffffb
    80005a72:	67a080e7          	jalr	1658(ra) # 800010e8 <myproc>
    80005a76:	ffffc097          	auipc	ra,0xffffc
    80005a7a:	fc2080e7          	jalr	-62(ra) # 80001a38 <killed>
    80005a7e:	ed2d                	bnez	a0,80005af8 <consoleread+0xda>
      sleep(&cons.r, &cons.lock);
    80005a80:	85a6                	mv	a1,s1
    80005a82:	854a                	mv	a0,s2
    80005a84:	ffffc097          	auipc	ra,0xffffc
    80005a88:	d0c080e7          	jalr	-756(ra) # 80001790 <sleep>
    while(cons.r == cons.w){
    80005a8c:	0984a783          	lw	a5,152(s1)
    80005a90:	09c4a703          	lw	a4,156(s1)
    80005a94:	fcf70de3          	beq	a4,a5,80005a6e <consoleread+0x50>
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    80005a98:	0003c717          	auipc	a4,0x3c
    80005a9c:	1f870713          	add	a4,a4,504 # 80041c90 <cons>
    80005aa0:	0017869b          	addw	a3,a5,1
    80005aa4:	08d72c23          	sw	a3,152(a4)
    80005aa8:	07f7f693          	and	a3,a5,127
    80005aac:	9736                	add	a4,a4,a3
    80005aae:	01874703          	lbu	a4,24(a4)
    80005ab2:	00070b9b          	sext.w	s7,a4

    if(c == C('D')){  // end-of-file
    80005ab6:	4691                	li	a3,4
    80005ab8:	06db8463          	beq	s7,a3,80005b20 <consoleread+0x102>
      }
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    80005abc:	fae407a3          	sb	a4,-81(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005ac0:	4685                	li	a3,1
    80005ac2:	faf40613          	add	a2,s0,-81
    80005ac6:	85d2                	mv	a1,s4
    80005ac8:	8556                	mv	a0,s5
    80005aca:	ffffc097          	auipc	ra,0xffffc
    80005ace:	0ce080e7          	jalr	206(ra) # 80001b98 <either_copyout>
    80005ad2:	57fd                	li	a5,-1
    80005ad4:	00f50763          	beq	a0,a5,80005ae2 <consoleread+0xc4>
      break;

    dst++;
    80005ad8:	0a05                	add	s4,s4,1
    --n;
    80005ada:	39fd                	addw	s3,s3,-1

    if(c == '\n'){
    80005adc:	47a9                	li	a5,10
    80005ade:	f8fb90e3          	bne	s7,a5,80005a5e <consoleread+0x40>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80005ae2:	0003c517          	auipc	a0,0x3c
    80005ae6:	1ae50513          	add	a0,a0,430 # 80041c90 <cons>
    80005aea:	00001097          	auipc	ra,0x1
    80005aee:	8f8080e7          	jalr	-1800(ra) # 800063e2 <release>

  return target - n;
    80005af2:	413b053b          	subw	a0,s6,s3
    80005af6:	a811                	j	80005b0a <consoleread+0xec>
        release(&cons.lock);
    80005af8:	0003c517          	auipc	a0,0x3c
    80005afc:	19850513          	add	a0,a0,408 # 80041c90 <cons>
    80005b00:	00001097          	auipc	ra,0x1
    80005b04:	8e2080e7          	jalr	-1822(ra) # 800063e2 <release>
        return -1;
    80005b08:	557d                	li	a0,-1
}
    80005b0a:	60e6                	ld	ra,88(sp)
    80005b0c:	6446                	ld	s0,80(sp)
    80005b0e:	64a6                	ld	s1,72(sp)
    80005b10:	6906                	ld	s2,64(sp)
    80005b12:	79e2                	ld	s3,56(sp)
    80005b14:	7a42                	ld	s4,48(sp)
    80005b16:	7aa2                	ld	s5,40(sp)
    80005b18:	7b02                	ld	s6,32(sp)
    80005b1a:	6be2                	ld	s7,24(sp)
    80005b1c:	6125                	add	sp,sp,96
    80005b1e:	8082                	ret
      if(n < target){
    80005b20:	0009871b          	sext.w	a4,s3
    80005b24:	fb677fe3          	bgeu	a4,s6,80005ae2 <consoleread+0xc4>
        cons.r--;
    80005b28:	0003c717          	auipc	a4,0x3c
    80005b2c:	20f72023          	sw	a5,512(a4) # 80041d28 <cons+0x98>
    80005b30:	bf4d                	j	80005ae2 <consoleread+0xc4>

0000000080005b32 <consputc>:
{
    80005b32:	1141                	add	sp,sp,-16
    80005b34:	e406                	sd	ra,8(sp)
    80005b36:	e022                	sd	s0,0(sp)
    80005b38:	0800                	add	s0,sp,16
  if(c == BACKSPACE){
    80005b3a:	10000793          	li	a5,256
    80005b3e:	00f50a63          	beq	a0,a5,80005b52 <consputc+0x20>
    uartputc_sync(c);
    80005b42:	00000097          	auipc	ra,0x0
    80005b46:	560080e7          	jalr	1376(ra) # 800060a2 <uartputc_sync>
}
    80005b4a:	60a2                	ld	ra,8(sp)
    80005b4c:	6402                	ld	s0,0(sp)
    80005b4e:	0141                	add	sp,sp,16
    80005b50:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80005b52:	4521                	li	a0,8
    80005b54:	00000097          	auipc	ra,0x0
    80005b58:	54e080e7          	jalr	1358(ra) # 800060a2 <uartputc_sync>
    80005b5c:	02000513          	li	a0,32
    80005b60:	00000097          	auipc	ra,0x0
    80005b64:	542080e7          	jalr	1346(ra) # 800060a2 <uartputc_sync>
    80005b68:	4521                	li	a0,8
    80005b6a:	00000097          	auipc	ra,0x0
    80005b6e:	538080e7          	jalr	1336(ra) # 800060a2 <uartputc_sync>
    80005b72:	bfe1                	j	80005b4a <consputc+0x18>

0000000080005b74 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80005b74:	1101                	add	sp,sp,-32
    80005b76:	ec06                	sd	ra,24(sp)
    80005b78:	e822                	sd	s0,16(sp)
    80005b7a:	e426                	sd	s1,8(sp)
    80005b7c:	e04a                	sd	s2,0(sp)
    80005b7e:	1000                	add	s0,sp,32
    80005b80:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80005b82:	0003c517          	auipc	a0,0x3c
    80005b86:	10e50513          	add	a0,a0,270 # 80041c90 <cons>
    80005b8a:	00000097          	auipc	ra,0x0
    80005b8e:	7a4080e7          	jalr	1956(ra) # 8000632e <acquire>

  switch(c){
    80005b92:	47d5                	li	a5,21
    80005b94:	0af48663          	beq	s1,a5,80005c40 <consoleintr+0xcc>
    80005b98:	0297ca63          	blt	a5,s1,80005bcc <consoleintr+0x58>
    80005b9c:	47a1                	li	a5,8
    80005b9e:	0ef48763          	beq	s1,a5,80005c8c <consoleintr+0x118>
    80005ba2:	47c1                	li	a5,16
    80005ba4:	10f49a63          	bne	s1,a5,80005cb8 <consoleintr+0x144>
  case C('P'):  // Print process list.
    procdump();
    80005ba8:	ffffc097          	auipc	ra,0xffffc
    80005bac:	09c080e7          	jalr	156(ra) # 80001c44 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80005bb0:	0003c517          	auipc	a0,0x3c
    80005bb4:	0e050513          	add	a0,a0,224 # 80041c90 <cons>
    80005bb8:	00001097          	auipc	ra,0x1
    80005bbc:	82a080e7          	jalr	-2006(ra) # 800063e2 <release>
}
    80005bc0:	60e2                	ld	ra,24(sp)
    80005bc2:	6442                	ld	s0,16(sp)
    80005bc4:	64a2                	ld	s1,8(sp)
    80005bc6:	6902                	ld	s2,0(sp)
    80005bc8:	6105                	add	sp,sp,32
    80005bca:	8082                	ret
  switch(c){
    80005bcc:	07f00793          	li	a5,127
    80005bd0:	0af48e63          	beq	s1,a5,80005c8c <consoleintr+0x118>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80005bd4:	0003c717          	auipc	a4,0x3c
    80005bd8:	0bc70713          	add	a4,a4,188 # 80041c90 <cons>
    80005bdc:	0a072783          	lw	a5,160(a4)
    80005be0:	09872703          	lw	a4,152(a4)
    80005be4:	9f99                	subw	a5,a5,a4
    80005be6:	07f00713          	li	a4,127
    80005bea:	fcf763e3          	bltu	a4,a5,80005bb0 <consoleintr+0x3c>
      c = (c == '\r') ? '\n' : c;
    80005bee:	47b5                	li	a5,13
    80005bf0:	0cf48763          	beq	s1,a5,80005cbe <consoleintr+0x14a>
      consputc(c);
    80005bf4:	8526                	mv	a0,s1
    80005bf6:	00000097          	auipc	ra,0x0
    80005bfa:	f3c080e7          	jalr	-196(ra) # 80005b32 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80005bfe:	0003c797          	auipc	a5,0x3c
    80005c02:	09278793          	add	a5,a5,146 # 80041c90 <cons>
    80005c06:	0a07a683          	lw	a3,160(a5)
    80005c0a:	0016871b          	addw	a4,a3,1
    80005c0e:	0007061b          	sext.w	a2,a4
    80005c12:	0ae7a023          	sw	a4,160(a5)
    80005c16:	07f6f693          	and	a3,a3,127
    80005c1a:	97b6                	add	a5,a5,a3
    80005c1c:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    80005c20:	47a9                	li	a5,10
    80005c22:	0cf48563          	beq	s1,a5,80005cec <consoleintr+0x178>
    80005c26:	4791                	li	a5,4
    80005c28:	0cf48263          	beq	s1,a5,80005cec <consoleintr+0x178>
    80005c2c:	0003c797          	auipc	a5,0x3c
    80005c30:	0fc7a783          	lw	a5,252(a5) # 80041d28 <cons+0x98>
    80005c34:	9f1d                	subw	a4,a4,a5
    80005c36:	08000793          	li	a5,128
    80005c3a:	f6f71be3          	bne	a4,a5,80005bb0 <consoleintr+0x3c>
    80005c3e:	a07d                	j	80005cec <consoleintr+0x178>
    while(cons.e != cons.w &&
    80005c40:	0003c717          	auipc	a4,0x3c
    80005c44:	05070713          	add	a4,a4,80 # 80041c90 <cons>
    80005c48:	0a072783          	lw	a5,160(a4)
    80005c4c:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80005c50:	0003c497          	auipc	s1,0x3c
    80005c54:	04048493          	add	s1,s1,64 # 80041c90 <cons>
    while(cons.e != cons.w &&
    80005c58:	4929                	li	s2,10
    80005c5a:	f4f70be3          	beq	a4,a5,80005bb0 <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80005c5e:	37fd                	addw	a5,a5,-1
    80005c60:	07f7f713          	and	a4,a5,127
    80005c64:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    80005c66:	01874703          	lbu	a4,24(a4)
    80005c6a:	f52703e3          	beq	a4,s2,80005bb0 <consoleintr+0x3c>
      cons.e--;
    80005c6e:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    80005c72:	10000513          	li	a0,256
    80005c76:	00000097          	auipc	ra,0x0
    80005c7a:	ebc080e7          	jalr	-324(ra) # 80005b32 <consputc>
    while(cons.e != cons.w &&
    80005c7e:	0a04a783          	lw	a5,160(s1)
    80005c82:	09c4a703          	lw	a4,156(s1)
    80005c86:	fcf71ce3          	bne	a4,a5,80005c5e <consoleintr+0xea>
    80005c8a:	b71d                	j	80005bb0 <consoleintr+0x3c>
    if(cons.e != cons.w){
    80005c8c:	0003c717          	auipc	a4,0x3c
    80005c90:	00470713          	add	a4,a4,4 # 80041c90 <cons>
    80005c94:	0a072783          	lw	a5,160(a4)
    80005c98:	09c72703          	lw	a4,156(a4)
    80005c9c:	f0f70ae3          	beq	a4,a5,80005bb0 <consoleintr+0x3c>
      cons.e--;
    80005ca0:	37fd                	addw	a5,a5,-1
    80005ca2:	0003c717          	auipc	a4,0x3c
    80005ca6:	08f72723          	sw	a5,142(a4) # 80041d30 <cons+0xa0>
      consputc(BACKSPACE);
    80005caa:	10000513          	li	a0,256
    80005cae:	00000097          	auipc	ra,0x0
    80005cb2:	e84080e7          	jalr	-380(ra) # 80005b32 <consputc>
    80005cb6:	bded                	j	80005bb0 <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80005cb8:	ee048ce3          	beqz	s1,80005bb0 <consoleintr+0x3c>
    80005cbc:	bf21                	j	80005bd4 <consoleintr+0x60>
      consputc(c);
    80005cbe:	4529                	li	a0,10
    80005cc0:	00000097          	auipc	ra,0x0
    80005cc4:	e72080e7          	jalr	-398(ra) # 80005b32 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80005cc8:	0003c797          	auipc	a5,0x3c
    80005ccc:	fc878793          	add	a5,a5,-56 # 80041c90 <cons>
    80005cd0:	0a07a703          	lw	a4,160(a5)
    80005cd4:	0017069b          	addw	a3,a4,1
    80005cd8:	0006861b          	sext.w	a2,a3
    80005cdc:	0ad7a023          	sw	a3,160(a5)
    80005ce0:	07f77713          	and	a4,a4,127
    80005ce4:	97ba                	add	a5,a5,a4
    80005ce6:	4729                	li	a4,10
    80005ce8:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80005cec:	0003c797          	auipc	a5,0x3c
    80005cf0:	04c7a023          	sw	a2,64(a5) # 80041d2c <cons+0x9c>
        wakeup(&cons.r);
    80005cf4:	0003c517          	auipc	a0,0x3c
    80005cf8:	03450513          	add	a0,a0,52 # 80041d28 <cons+0x98>
    80005cfc:	ffffc097          	auipc	ra,0xffffc
    80005d00:	af8080e7          	jalr	-1288(ra) # 800017f4 <wakeup>
    80005d04:	b575                	j	80005bb0 <consoleintr+0x3c>

0000000080005d06 <consoleinit>:

void
consoleinit(void)
{
    80005d06:	1141                	add	sp,sp,-16
    80005d08:	e406                	sd	ra,8(sp)
    80005d0a:	e022                	sd	s0,0(sp)
    80005d0c:	0800                	add	s0,sp,16
  initlock(&cons.lock, "cons");
    80005d0e:	00003597          	auipc	a1,0x3
    80005d12:	aea58593          	add	a1,a1,-1302 # 800087f8 <syscalls+0x3f0>
    80005d16:	0003c517          	auipc	a0,0x3c
    80005d1a:	f7a50513          	add	a0,a0,-134 # 80041c90 <cons>
    80005d1e:	00000097          	auipc	ra,0x0
    80005d22:	580080e7          	jalr	1408(ra) # 8000629e <initlock>

  uartinit();
    80005d26:	00000097          	auipc	ra,0x0
    80005d2a:	32c080e7          	jalr	812(ra) # 80006052 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80005d2e:	00033797          	auipc	a5,0x33
    80005d32:	c8278793          	add	a5,a5,-894 # 800389b0 <devsw>
    80005d36:	00000717          	auipc	a4,0x0
    80005d3a:	ce870713          	add	a4,a4,-792 # 80005a1e <consoleread>
    80005d3e:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80005d40:	00000717          	auipc	a4,0x0
    80005d44:	c7a70713          	add	a4,a4,-902 # 800059ba <consolewrite>
    80005d48:	ef98                	sd	a4,24(a5)
}
    80005d4a:	60a2                	ld	ra,8(sp)
    80005d4c:	6402                	ld	s0,0(sp)
    80005d4e:	0141                	add	sp,sp,16
    80005d50:	8082                	ret

0000000080005d52 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    80005d52:	7179                	add	sp,sp,-48
    80005d54:	f406                	sd	ra,40(sp)
    80005d56:	f022                	sd	s0,32(sp)
    80005d58:	ec26                	sd	s1,24(sp)
    80005d5a:	e84a                	sd	s2,16(sp)
    80005d5c:	1800                	add	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    80005d5e:	c219                	beqz	a2,80005d64 <printint+0x12>
    80005d60:	08054763          	bltz	a0,80005dee <printint+0x9c>
    x = -xx;
  else
    x = xx;
    80005d64:	2501                	sext.w	a0,a0
    80005d66:	4881                	li	a7,0
    80005d68:	fd040693          	add	a3,s0,-48

  i = 0;
    80005d6c:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    80005d6e:	2581                	sext.w	a1,a1
    80005d70:	00003617          	auipc	a2,0x3
    80005d74:	ab860613          	add	a2,a2,-1352 # 80008828 <digits>
    80005d78:	883a                	mv	a6,a4
    80005d7a:	2705                	addw	a4,a4,1
    80005d7c:	02b577bb          	remuw	a5,a0,a1
    80005d80:	1782                	sll	a5,a5,0x20
    80005d82:	9381                	srl	a5,a5,0x20
    80005d84:	97b2                	add	a5,a5,a2
    80005d86:	0007c783          	lbu	a5,0(a5)
    80005d8a:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    80005d8e:	0005079b          	sext.w	a5,a0
    80005d92:	02b5553b          	divuw	a0,a0,a1
    80005d96:	0685                	add	a3,a3,1
    80005d98:	feb7f0e3          	bgeu	a5,a1,80005d78 <printint+0x26>

  if(sign)
    80005d9c:	00088c63          	beqz	a7,80005db4 <printint+0x62>
    buf[i++] = '-';
    80005da0:	fe070793          	add	a5,a4,-32
    80005da4:	00878733          	add	a4,a5,s0
    80005da8:	02d00793          	li	a5,45
    80005dac:	fef70823          	sb	a5,-16(a4)
    80005db0:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
    80005db4:	02e05763          	blez	a4,80005de2 <printint+0x90>
    80005db8:	fd040793          	add	a5,s0,-48
    80005dbc:	00e784b3          	add	s1,a5,a4
    80005dc0:	fff78913          	add	s2,a5,-1
    80005dc4:	993a                	add	s2,s2,a4
    80005dc6:	377d                	addw	a4,a4,-1
    80005dc8:	1702                	sll	a4,a4,0x20
    80005dca:	9301                	srl	a4,a4,0x20
    80005dcc:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80005dd0:	fff4c503          	lbu	a0,-1(s1)
    80005dd4:	00000097          	auipc	ra,0x0
    80005dd8:	d5e080e7          	jalr	-674(ra) # 80005b32 <consputc>
  while(--i >= 0)
    80005ddc:	14fd                	add	s1,s1,-1
    80005dde:	ff2499e3          	bne	s1,s2,80005dd0 <printint+0x7e>
}
    80005de2:	70a2                	ld	ra,40(sp)
    80005de4:	7402                	ld	s0,32(sp)
    80005de6:	64e2                	ld	s1,24(sp)
    80005de8:	6942                	ld	s2,16(sp)
    80005dea:	6145                	add	sp,sp,48
    80005dec:	8082                	ret
    x = -xx;
    80005dee:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    80005df2:	4885                	li	a7,1
    x = -xx;
    80005df4:	bf95                	j	80005d68 <printint+0x16>

0000000080005df6 <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    80005df6:	1101                	add	sp,sp,-32
    80005df8:	ec06                	sd	ra,24(sp)
    80005dfa:	e822                	sd	s0,16(sp)
    80005dfc:	e426                	sd	s1,8(sp)
    80005dfe:	1000                	add	s0,sp,32
    80005e00:	84aa                	mv	s1,a0
  pr.locking = 0;
    80005e02:	0003c797          	auipc	a5,0x3c
    80005e06:	f407a723          	sw	zero,-178(a5) # 80041d50 <pr+0x18>
  printf("panic: ");
    80005e0a:	00003517          	auipc	a0,0x3
    80005e0e:	9f650513          	add	a0,a0,-1546 # 80008800 <syscalls+0x3f8>
    80005e12:	00000097          	auipc	ra,0x0
    80005e16:	02e080e7          	jalr	46(ra) # 80005e40 <printf>
  printf(s);
    80005e1a:	8526                	mv	a0,s1
    80005e1c:	00000097          	auipc	ra,0x0
    80005e20:	024080e7          	jalr	36(ra) # 80005e40 <printf>
  printf("\n");
    80005e24:	00002517          	auipc	a0,0x2
    80005e28:	22c50513          	add	a0,a0,556 # 80008050 <etext+0x50>
    80005e2c:	00000097          	auipc	ra,0x0
    80005e30:	014080e7          	jalr	20(ra) # 80005e40 <printf>
  panicked = 1; // freeze uart output from other CPUs
    80005e34:	4785                	li	a5,1
    80005e36:	00003717          	auipc	a4,0x3
    80005e3a:	aaf72b23          	sw	a5,-1354(a4) # 800088ec <panicked>
  for(;;)
    80005e3e:	a001                	j	80005e3e <panic+0x48>

0000000080005e40 <printf>:
{
    80005e40:	7131                	add	sp,sp,-192
    80005e42:	fc86                	sd	ra,120(sp)
    80005e44:	f8a2                	sd	s0,112(sp)
    80005e46:	f4a6                	sd	s1,104(sp)
    80005e48:	f0ca                	sd	s2,96(sp)
    80005e4a:	ecce                	sd	s3,88(sp)
    80005e4c:	e8d2                	sd	s4,80(sp)
    80005e4e:	e4d6                	sd	s5,72(sp)
    80005e50:	e0da                	sd	s6,64(sp)
    80005e52:	fc5e                	sd	s7,56(sp)
    80005e54:	f862                	sd	s8,48(sp)
    80005e56:	f466                	sd	s9,40(sp)
    80005e58:	f06a                	sd	s10,32(sp)
    80005e5a:	ec6e                	sd	s11,24(sp)
    80005e5c:	0100                	add	s0,sp,128
    80005e5e:	8a2a                	mv	s4,a0
    80005e60:	e40c                	sd	a1,8(s0)
    80005e62:	e810                	sd	a2,16(s0)
    80005e64:	ec14                	sd	a3,24(s0)
    80005e66:	f018                	sd	a4,32(s0)
    80005e68:	f41c                	sd	a5,40(s0)
    80005e6a:	03043823          	sd	a6,48(s0)
    80005e6e:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    80005e72:	0003cd97          	auipc	s11,0x3c
    80005e76:	ededad83          	lw	s11,-290(s11) # 80041d50 <pr+0x18>
  if(locking)
    80005e7a:	020d9b63          	bnez	s11,80005eb0 <printf+0x70>
  if (fmt == 0)
    80005e7e:	040a0263          	beqz	s4,80005ec2 <printf+0x82>
  va_start(ap, fmt);
    80005e82:	00840793          	add	a5,s0,8
    80005e86:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005e8a:	000a4503          	lbu	a0,0(s4)
    80005e8e:	14050f63          	beqz	a0,80005fec <printf+0x1ac>
    80005e92:	4981                	li	s3,0
    if(c != '%'){
    80005e94:	02500a93          	li	s5,37
    switch(c){
    80005e98:	07000b93          	li	s7,112
  consputc('x');
    80005e9c:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005e9e:	00003b17          	auipc	s6,0x3
    80005ea2:	98ab0b13          	add	s6,s6,-1654 # 80008828 <digits>
    switch(c){
    80005ea6:	07300c93          	li	s9,115
    80005eaa:	06400c13          	li	s8,100
    80005eae:	a82d                	j	80005ee8 <printf+0xa8>
    acquire(&pr.lock);
    80005eb0:	0003c517          	auipc	a0,0x3c
    80005eb4:	e8850513          	add	a0,a0,-376 # 80041d38 <pr>
    80005eb8:	00000097          	auipc	ra,0x0
    80005ebc:	476080e7          	jalr	1142(ra) # 8000632e <acquire>
    80005ec0:	bf7d                	j	80005e7e <printf+0x3e>
    panic("null fmt");
    80005ec2:	00003517          	auipc	a0,0x3
    80005ec6:	94e50513          	add	a0,a0,-1714 # 80008810 <syscalls+0x408>
    80005eca:	00000097          	auipc	ra,0x0
    80005ece:	f2c080e7          	jalr	-212(ra) # 80005df6 <panic>
      consputc(c);
    80005ed2:	00000097          	auipc	ra,0x0
    80005ed6:	c60080e7          	jalr	-928(ra) # 80005b32 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005eda:	2985                	addw	s3,s3,1
    80005edc:	013a07b3          	add	a5,s4,s3
    80005ee0:	0007c503          	lbu	a0,0(a5)
    80005ee4:	10050463          	beqz	a0,80005fec <printf+0x1ac>
    if(c != '%'){
    80005ee8:	ff5515e3          	bne	a0,s5,80005ed2 <printf+0x92>
    c = fmt[++i] & 0xff;
    80005eec:	2985                	addw	s3,s3,1
    80005eee:	013a07b3          	add	a5,s4,s3
    80005ef2:	0007c783          	lbu	a5,0(a5)
    80005ef6:	0007849b          	sext.w	s1,a5
    if(c == 0)
    80005efa:	cbed                	beqz	a5,80005fec <printf+0x1ac>
    switch(c){
    80005efc:	05778a63          	beq	a5,s7,80005f50 <printf+0x110>
    80005f00:	02fbf663          	bgeu	s7,a5,80005f2c <printf+0xec>
    80005f04:	09978863          	beq	a5,s9,80005f94 <printf+0x154>
    80005f08:	07800713          	li	a4,120
    80005f0c:	0ce79563          	bne	a5,a4,80005fd6 <printf+0x196>
      printint(va_arg(ap, int), 16, 1);
    80005f10:	f8843783          	ld	a5,-120(s0)
    80005f14:	00878713          	add	a4,a5,8
    80005f18:	f8e43423          	sd	a4,-120(s0)
    80005f1c:	4605                	li	a2,1
    80005f1e:	85ea                	mv	a1,s10
    80005f20:	4388                	lw	a0,0(a5)
    80005f22:	00000097          	auipc	ra,0x0
    80005f26:	e30080e7          	jalr	-464(ra) # 80005d52 <printint>
      break;
    80005f2a:	bf45                	j	80005eda <printf+0x9a>
    switch(c){
    80005f2c:	09578f63          	beq	a5,s5,80005fca <printf+0x18a>
    80005f30:	0b879363          	bne	a5,s8,80005fd6 <printf+0x196>
      printint(va_arg(ap, int), 10, 1);
    80005f34:	f8843783          	ld	a5,-120(s0)
    80005f38:	00878713          	add	a4,a5,8
    80005f3c:	f8e43423          	sd	a4,-120(s0)
    80005f40:	4605                	li	a2,1
    80005f42:	45a9                	li	a1,10
    80005f44:	4388                	lw	a0,0(a5)
    80005f46:	00000097          	auipc	ra,0x0
    80005f4a:	e0c080e7          	jalr	-500(ra) # 80005d52 <printint>
      break;
    80005f4e:	b771                	j	80005eda <printf+0x9a>
      printptr(va_arg(ap, uint64));
    80005f50:	f8843783          	ld	a5,-120(s0)
    80005f54:	00878713          	add	a4,a5,8
    80005f58:	f8e43423          	sd	a4,-120(s0)
    80005f5c:	0007b903          	ld	s2,0(a5)
  consputc('0');
    80005f60:	03000513          	li	a0,48
    80005f64:	00000097          	auipc	ra,0x0
    80005f68:	bce080e7          	jalr	-1074(ra) # 80005b32 <consputc>
  consputc('x');
    80005f6c:	07800513          	li	a0,120
    80005f70:	00000097          	auipc	ra,0x0
    80005f74:	bc2080e7          	jalr	-1086(ra) # 80005b32 <consputc>
    80005f78:	84ea                	mv	s1,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005f7a:	03c95793          	srl	a5,s2,0x3c
    80005f7e:	97da                	add	a5,a5,s6
    80005f80:	0007c503          	lbu	a0,0(a5)
    80005f84:	00000097          	auipc	ra,0x0
    80005f88:	bae080e7          	jalr	-1106(ra) # 80005b32 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80005f8c:	0912                	sll	s2,s2,0x4
    80005f8e:	34fd                	addw	s1,s1,-1
    80005f90:	f4ed                	bnez	s1,80005f7a <printf+0x13a>
    80005f92:	b7a1                	j	80005eda <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    80005f94:	f8843783          	ld	a5,-120(s0)
    80005f98:	00878713          	add	a4,a5,8
    80005f9c:	f8e43423          	sd	a4,-120(s0)
    80005fa0:	6384                	ld	s1,0(a5)
    80005fa2:	cc89                	beqz	s1,80005fbc <printf+0x17c>
      for(; *s; s++)
    80005fa4:	0004c503          	lbu	a0,0(s1)
    80005fa8:	d90d                	beqz	a0,80005eda <printf+0x9a>
        consputc(*s);
    80005faa:	00000097          	auipc	ra,0x0
    80005fae:	b88080e7          	jalr	-1144(ra) # 80005b32 <consputc>
      for(; *s; s++)
    80005fb2:	0485                	add	s1,s1,1
    80005fb4:	0004c503          	lbu	a0,0(s1)
    80005fb8:	f96d                	bnez	a0,80005faa <printf+0x16a>
    80005fba:	b705                	j	80005eda <printf+0x9a>
        s = "(null)";
    80005fbc:	00003497          	auipc	s1,0x3
    80005fc0:	84c48493          	add	s1,s1,-1972 # 80008808 <syscalls+0x400>
      for(; *s; s++)
    80005fc4:	02800513          	li	a0,40
    80005fc8:	b7cd                	j	80005faa <printf+0x16a>
      consputc('%');
    80005fca:	8556                	mv	a0,s5
    80005fcc:	00000097          	auipc	ra,0x0
    80005fd0:	b66080e7          	jalr	-1178(ra) # 80005b32 <consputc>
      break;
    80005fd4:	b719                	j	80005eda <printf+0x9a>
      consputc('%');
    80005fd6:	8556                	mv	a0,s5
    80005fd8:	00000097          	auipc	ra,0x0
    80005fdc:	b5a080e7          	jalr	-1190(ra) # 80005b32 <consputc>
      consputc(c);
    80005fe0:	8526                	mv	a0,s1
    80005fe2:	00000097          	auipc	ra,0x0
    80005fe6:	b50080e7          	jalr	-1200(ra) # 80005b32 <consputc>
      break;
    80005fea:	bdc5                	j	80005eda <printf+0x9a>
  if(locking)
    80005fec:	020d9163          	bnez	s11,8000600e <printf+0x1ce>
}
    80005ff0:	70e6                	ld	ra,120(sp)
    80005ff2:	7446                	ld	s0,112(sp)
    80005ff4:	74a6                	ld	s1,104(sp)
    80005ff6:	7906                	ld	s2,96(sp)
    80005ff8:	69e6                	ld	s3,88(sp)
    80005ffa:	6a46                	ld	s4,80(sp)
    80005ffc:	6aa6                	ld	s5,72(sp)
    80005ffe:	6b06                	ld	s6,64(sp)
    80006000:	7be2                	ld	s7,56(sp)
    80006002:	7c42                	ld	s8,48(sp)
    80006004:	7ca2                	ld	s9,40(sp)
    80006006:	7d02                	ld	s10,32(sp)
    80006008:	6de2                	ld	s11,24(sp)
    8000600a:	6129                	add	sp,sp,192
    8000600c:	8082                	ret
    release(&pr.lock);
    8000600e:	0003c517          	auipc	a0,0x3c
    80006012:	d2a50513          	add	a0,a0,-726 # 80041d38 <pr>
    80006016:	00000097          	auipc	ra,0x0
    8000601a:	3cc080e7          	jalr	972(ra) # 800063e2 <release>
}
    8000601e:	bfc9                	j	80005ff0 <printf+0x1b0>

0000000080006020 <printfinit>:
    ;
}

void
printfinit(void)
{
    80006020:	1101                	add	sp,sp,-32
    80006022:	ec06                	sd	ra,24(sp)
    80006024:	e822                	sd	s0,16(sp)
    80006026:	e426                	sd	s1,8(sp)
    80006028:	1000                	add	s0,sp,32
  initlock(&pr.lock, "pr");
    8000602a:	0003c497          	auipc	s1,0x3c
    8000602e:	d0e48493          	add	s1,s1,-754 # 80041d38 <pr>
    80006032:	00002597          	auipc	a1,0x2
    80006036:	7ee58593          	add	a1,a1,2030 # 80008820 <syscalls+0x418>
    8000603a:	8526                	mv	a0,s1
    8000603c:	00000097          	auipc	ra,0x0
    80006040:	262080e7          	jalr	610(ra) # 8000629e <initlock>
  pr.locking = 1;
    80006044:	4785                	li	a5,1
    80006046:	cc9c                	sw	a5,24(s1)
}
    80006048:	60e2                	ld	ra,24(sp)
    8000604a:	6442                	ld	s0,16(sp)
    8000604c:	64a2                	ld	s1,8(sp)
    8000604e:	6105                	add	sp,sp,32
    80006050:	8082                	ret

0000000080006052 <uartinit>:

void uartstart();

void
uartinit(void)
{
    80006052:	1141                	add	sp,sp,-16
    80006054:	e406                	sd	ra,8(sp)
    80006056:	e022                	sd	s0,0(sp)
    80006058:	0800                	add	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    8000605a:	100007b7          	lui	a5,0x10000
    8000605e:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80006062:	f8000713          	li	a4,-128
    80006066:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    8000606a:	470d                	li	a4,3
    8000606c:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80006070:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80006074:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80006078:	469d                	li	a3,7
    8000607a:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    8000607e:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    80006082:	00002597          	auipc	a1,0x2
    80006086:	7be58593          	add	a1,a1,1982 # 80008840 <digits+0x18>
    8000608a:	0003c517          	auipc	a0,0x3c
    8000608e:	cce50513          	add	a0,a0,-818 # 80041d58 <uart_tx_lock>
    80006092:	00000097          	auipc	ra,0x0
    80006096:	20c080e7          	jalr	524(ra) # 8000629e <initlock>
}
    8000609a:	60a2                	ld	ra,8(sp)
    8000609c:	6402                	ld	s0,0(sp)
    8000609e:	0141                	add	sp,sp,16
    800060a0:	8082                	ret

00000000800060a2 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    800060a2:	1101                	add	sp,sp,-32
    800060a4:	ec06                	sd	ra,24(sp)
    800060a6:	e822                	sd	s0,16(sp)
    800060a8:	e426                	sd	s1,8(sp)
    800060aa:	1000                	add	s0,sp,32
    800060ac:	84aa                	mv	s1,a0
  push_off();
    800060ae:	00000097          	auipc	ra,0x0
    800060b2:	234080e7          	jalr	564(ra) # 800062e2 <push_off>

  if(panicked){
    800060b6:	00003797          	auipc	a5,0x3
    800060ba:	8367a783          	lw	a5,-1994(a5) # 800088ec <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    800060be:	10000737          	lui	a4,0x10000
  if(panicked){
    800060c2:	c391                	beqz	a5,800060c6 <uartputc_sync+0x24>
    for(;;)
    800060c4:	a001                	j	800060c4 <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    800060c6:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800060ca:	0207f793          	and	a5,a5,32
    800060ce:	dfe5                	beqz	a5,800060c6 <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    800060d0:	0ff4f513          	zext.b	a0,s1
    800060d4:	100007b7          	lui	a5,0x10000
    800060d8:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    800060dc:	00000097          	auipc	ra,0x0
    800060e0:	2a6080e7          	jalr	678(ra) # 80006382 <pop_off>
}
    800060e4:	60e2                	ld	ra,24(sp)
    800060e6:	6442                	ld	s0,16(sp)
    800060e8:	64a2                	ld	s1,8(sp)
    800060ea:	6105                	add	sp,sp,32
    800060ec:	8082                	ret

00000000800060ee <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    800060ee:	00003797          	auipc	a5,0x3
    800060f2:	8027b783          	ld	a5,-2046(a5) # 800088f0 <uart_tx_r>
    800060f6:	00003717          	auipc	a4,0x3
    800060fa:	80273703          	ld	a4,-2046(a4) # 800088f8 <uart_tx_w>
    800060fe:	06f70a63          	beq	a4,a5,80006172 <uartstart+0x84>
{
    80006102:	7139                	add	sp,sp,-64
    80006104:	fc06                	sd	ra,56(sp)
    80006106:	f822                	sd	s0,48(sp)
    80006108:	f426                	sd	s1,40(sp)
    8000610a:	f04a                	sd	s2,32(sp)
    8000610c:	ec4e                	sd	s3,24(sp)
    8000610e:	e852                	sd	s4,16(sp)
    80006110:	e456                	sd	s5,8(sp)
    80006112:	0080                	add	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80006114:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80006118:	0003ca17          	auipc	s4,0x3c
    8000611c:	c40a0a13          	add	s4,s4,-960 # 80041d58 <uart_tx_lock>
    uart_tx_r += 1;
    80006120:	00002497          	auipc	s1,0x2
    80006124:	7d048493          	add	s1,s1,2000 # 800088f0 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    80006128:	00002997          	auipc	s3,0x2
    8000612c:	7d098993          	add	s3,s3,2000 # 800088f8 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80006130:	00594703          	lbu	a4,5(s2) # 10000005 <_entry-0x6ffffffb>
    80006134:	02077713          	and	a4,a4,32
    80006138:	c705                	beqz	a4,80006160 <uartstart+0x72>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    8000613a:	01f7f713          	and	a4,a5,31
    8000613e:	9752                	add	a4,a4,s4
    80006140:	01874a83          	lbu	s5,24(a4)
    uart_tx_r += 1;
    80006144:	0785                	add	a5,a5,1
    80006146:	e09c                	sd	a5,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    80006148:	8526                	mv	a0,s1
    8000614a:	ffffb097          	auipc	ra,0xffffb
    8000614e:	6aa080e7          	jalr	1706(ra) # 800017f4 <wakeup>
    
    WriteReg(THR, c);
    80006152:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    80006156:	609c                	ld	a5,0(s1)
    80006158:	0009b703          	ld	a4,0(s3)
    8000615c:	fcf71ae3          	bne	a4,a5,80006130 <uartstart+0x42>
  }
}
    80006160:	70e2                	ld	ra,56(sp)
    80006162:	7442                	ld	s0,48(sp)
    80006164:	74a2                	ld	s1,40(sp)
    80006166:	7902                	ld	s2,32(sp)
    80006168:	69e2                	ld	s3,24(sp)
    8000616a:	6a42                	ld	s4,16(sp)
    8000616c:	6aa2                	ld	s5,8(sp)
    8000616e:	6121                	add	sp,sp,64
    80006170:	8082                	ret
    80006172:	8082                	ret

0000000080006174 <uartputc>:
{
    80006174:	7179                	add	sp,sp,-48
    80006176:	f406                	sd	ra,40(sp)
    80006178:	f022                	sd	s0,32(sp)
    8000617a:	ec26                	sd	s1,24(sp)
    8000617c:	e84a                	sd	s2,16(sp)
    8000617e:	e44e                	sd	s3,8(sp)
    80006180:	e052                	sd	s4,0(sp)
    80006182:	1800                	add	s0,sp,48
    80006184:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    80006186:	0003c517          	auipc	a0,0x3c
    8000618a:	bd250513          	add	a0,a0,-1070 # 80041d58 <uart_tx_lock>
    8000618e:	00000097          	auipc	ra,0x0
    80006192:	1a0080e7          	jalr	416(ra) # 8000632e <acquire>
  if(panicked){
    80006196:	00002797          	auipc	a5,0x2
    8000619a:	7567a783          	lw	a5,1878(a5) # 800088ec <panicked>
    8000619e:	e7c9                	bnez	a5,80006228 <uartputc+0xb4>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800061a0:	00002717          	auipc	a4,0x2
    800061a4:	75873703          	ld	a4,1880(a4) # 800088f8 <uart_tx_w>
    800061a8:	00002797          	auipc	a5,0x2
    800061ac:	7487b783          	ld	a5,1864(a5) # 800088f0 <uart_tx_r>
    800061b0:	02078793          	add	a5,a5,32
    sleep(&uart_tx_r, &uart_tx_lock);
    800061b4:	0003c997          	auipc	s3,0x3c
    800061b8:	ba498993          	add	s3,s3,-1116 # 80041d58 <uart_tx_lock>
    800061bc:	00002497          	auipc	s1,0x2
    800061c0:	73448493          	add	s1,s1,1844 # 800088f0 <uart_tx_r>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800061c4:	00002917          	auipc	s2,0x2
    800061c8:	73490913          	add	s2,s2,1844 # 800088f8 <uart_tx_w>
    800061cc:	00e79f63          	bne	a5,a4,800061ea <uartputc+0x76>
    sleep(&uart_tx_r, &uart_tx_lock);
    800061d0:	85ce                	mv	a1,s3
    800061d2:	8526                	mv	a0,s1
    800061d4:	ffffb097          	auipc	ra,0xffffb
    800061d8:	5bc080e7          	jalr	1468(ra) # 80001790 <sleep>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800061dc:	00093703          	ld	a4,0(s2)
    800061e0:	609c                	ld	a5,0(s1)
    800061e2:	02078793          	add	a5,a5,32
    800061e6:	fee785e3          	beq	a5,a4,800061d0 <uartputc+0x5c>
  uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    800061ea:	0003c497          	auipc	s1,0x3c
    800061ee:	b6e48493          	add	s1,s1,-1170 # 80041d58 <uart_tx_lock>
    800061f2:	01f77793          	and	a5,a4,31
    800061f6:	97a6                	add	a5,a5,s1
    800061f8:	01478c23          	sb	s4,24(a5)
  uart_tx_w += 1;
    800061fc:	0705                	add	a4,a4,1
    800061fe:	00002797          	auipc	a5,0x2
    80006202:	6ee7bd23          	sd	a4,1786(a5) # 800088f8 <uart_tx_w>
  uartstart();
    80006206:	00000097          	auipc	ra,0x0
    8000620a:	ee8080e7          	jalr	-280(ra) # 800060ee <uartstart>
  release(&uart_tx_lock);
    8000620e:	8526                	mv	a0,s1
    80006210:	00000097          	auipc	ra,0x0
    80006214:	1d2080e7          	jalr	466(ra) # 800063e2 <release>
}
    80006218:	70a2                	ld	ra,40(sp)
    8000621a:	7402                	ld	s0,32(sp)
    8000621c:	64e2                	ld	s1,24(sp)
    8000621e:	6942                	ld	s2,16(sp)
    80006220:	69a2                	ld	s3,8(sp)
    80006222:	6a02                	ld	s4,0(sp)
    80006224:	6145                	add	sp,sp,48
    80006226:	8082                	ret
    for(;;)
    80006228:	a001                	j	80006228 <uartputc+0xb4>

000000008000622a <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    8000622a:	1141                	add	sp,sp,-16
    8000622c:	e422                	sd	s0,8(sp)
    8000622e:	0800                	add	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80006230:	100007b7          	lui	a5,0x10000
    80006234:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006238:	8b85                	and	a5,a5,1
    8000623a:	cb81                	beqz	a5,8000624a <uartgetc+0x20>
    // input data is ready.
    return ReadReg(RHR);
    8000623c:	100007b7          	lui	a5,0x10000
    80006240:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    80006244:	6422                	ld	s0,8(sp)
    80006246:	0141                	add	sp,sp,16
    80006248:	8082                	ret
    return -1;
    8000624a:	557d                	li	a0,-1
    8000624c:	bfe5                	j	80006244 <uartgetc+0x1a>

000000008000624e <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    8000624e:	1101                	add	sp,sp,-32
    80006250:	ec06                	sd	ra,24(sp)
    80006252:	e822                	sd	s0,16(sp)
    80006254:	e426                	sd	s1,8(sp)
    80006256:	1000                	add	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    80006258:	54fd                	li	s1,-1
    8000625a:	a029                	j	80006264 <uartintr+0x16>
      break;
    consoleintr(c);
    8000625c:	00000097          	auipc	ra,0x0
    80006260:	918080e7          	jalr	-1768(ra) # 80005b74 <consoleintr>
    int c = uartgetc();
    80006264:	00000097          	auipc	ra,0x0
    80006268:	fc6080e7          	jalr	-58(ra) # 8000622a <uartgetc>
    if(c == -1)
    8000626c:	fe9518e3          	bne	a0,s1,8000625c <uartintr+0xe>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    80006270:	0003c497          	auipc	s1,0x3c
    80006274:	ae848493          	add	s1,s1,-1304 # 80041d58 <uart_tx_lock>
    80006278:	8526                	mv	a0,s1
    8000627a:	00000097          	auipc	ra,0x0
    8000627e:	0b4080e7          	jalr	180(ra) # 8000632e <acquire>
  uartstart();
    80006282:	00000097          	auipc	ra,0x0
    80006286:	e6c080e7          	jalr	-404(ra) # 800060ee <uartstart>
  release(&uart_tx_lock);
    8000628a:	8526                	mv	a0,s1
    8000628c:	00000097          	auipc	ra,0x0
    80006290:	156080e7          	jalr	342(ra) # 800063e2 <release>
}
    80006294:	60e2                	ld	ra,24(sp)
    80006296:	6442                	ld	s0,16(sp)
    80006298:	64a2                	ld	s1,8(sp)
    8000629a:	6105                	add	sp,sp,32
    8000629c:	8082                	ret

000000008000629e <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    8000629e:	1141                	add	sp,sp,-16
    800062a0:	e422                	sd	s0,8(sp)
    800062a2:	0800                	add	s0,sp,16
  lk->name = name;
    800062a4:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    800062a6:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    800062aa:	00053823          	sd	zero,16(a0)
}
    800062ae:	6422                	ld	s0,8(sp)
    800062b0:	0141                	add	sp,sp,16
    800062b2:	8082                	ret

00000000800062b4 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    800062b4:	411c                	lw	a5,0(a0)
    800062b6:	e399                	bnez	a5,800062bc <holding+0x8>
    800062b8:	4501                	li	a0,0
  return r;
}
    800062ba:	8082                	ret
{
    800062bc:	1101                	add	sp,sp,-32
    800062be:	ec06                	sd	ra,24(sp)
    800062c0:	e822                	sd	s0,16(sp)
    800062c2:	e426                	sd	s1,8(sp)
    800062c4:	1000                	add	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    800062c6:	6904                	ld	s1,16(a0)
    800062c8:	ffffb097          	auipc	ra,0xffffb
    800062cc:	e04080e7          	jalr	-508(ra) # 800010cc <mycpu>
    800062d0:	40a48533          	sub	a0,s1,a0
    800062d4:	00153513          	seqz	a0,a0
}
    800062d8:	60e2                	ld	ra,24(sp)
    800062da:	6442                	ld	s0,16(sp)
    800062dc:	64a2                	ld	s1,8(sp)
    800062de:	6105                	add	sp,sp,32
    800062e0:	8082                	ret

00000000800062e2 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    800062e2:	1101                	add	sp,sp,-32
    800062e4:	ec06                	sd	ra,24(sp)
    800062e6:	e822                	sd	s0,16(sp)
    800062e8:	e426                	sd	s1,8(sp)
    800062ea:	1000                	add	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800062ec:	100024f3          	csrr	s1,sstatus
    800062f0:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800062f4:	9bf5                	and	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800062f6:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    800062fa:	ffffb097          	auipc	ra,0xffffb
    800062fe:	dd2080e7          	jalr	-558(ra) # 800010cc <mycpu>
    80006302:	5d3c                	lw	a5,120(a0)
    80006304:	cf89                	beqz	a5,8000631e <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80006306:	ffffb097          	auipc	ra,0xffffb
    8000630a:	dc6080e7          	jalr	-570(ra) # 800010cc <mycpu>
    8000630e:	5d3c                	lw	a5,120(a0)
    80006310:	2785                	addw	a5,a5,1
    80006312:	dd3c                	sw	a5,120(a0)
}
    80006314:	60e2                	ld	ra,24(sp)
    80006316:	6442                	ld	s0,16(sp)
    80006318:	64a2                	ld	s1,8(sp)
    8000631a:	6105                	add	sp,sp,32
    8000631c:	8082                	ret
    mycpu()->intena = old;
    8000631e:	ffffb097          	auipc	ra,0xffffb
    80006322:	dae080e7          	jalr	-594(ra) # 800010cc <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80006326:	8085                	srl	s1,s1,0x1
    80006328:	8885                	and	s1,s1,1
    8000632a:	dd64                	sw	s1,124(a0)
    8000632c:	bfe9                	j	80006306 <push_off+0x24>

000000008000632e <acquire>:
{
    8000632e:	1101                	add	sp,sp,-32
    80006330:	ec06                	sd	ra,24(sp)
    80006332:	e822                	sd	s0,16(sp)
    80006334:	e426                	sd	s1,8(sp)
    80006336:	1000                	add	s0,sp,32
    80006338:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    8000633a:	00000097          	auipc	ra,0x0
    8000633e:	fa8080e7          	jalr	-88(ra) # 800062e2 <push_off>
  if(holding(lk))
    80006342:	8526                	mv	a0,s1
    80006344:	00000097          	auipc	ra,0x0
    80006348:	f70080e7          	jalr	-144(ra) # 800062b4 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    8000634c:	4705                	li	a4,1
  if(holding(lk))
    8000634e:	e115                	bnez	a0,80006372 <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80006350:	87ba                	mv	a5,a4
    80006352:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006356:	2781                	sext.w	a5,a5
    80006358:	ffe5                	bnez	a5,80006350 <acquire+0x22>
  __sync_synchronize();
    8000635a:	0ff0000f          	fence
  lk->cpu = mycpu();
    8000635e:	ffffb097          	auipc	ra,0xffffb
    80006362:	d6e080e7          	jalr	-658(ra) # 800010cc <mycpu>
    80006366:	e888                	sd	a0,16(s1)
}
    80006368:	60e2                	ld	ra,24(sp)
    8000636a:	6442                	ld	s0,16(sp)
    8000636c:	64a2                	ld	s1,8(sp)
    8000636e:	6105                	add	sp,sp,32
    80006370:	8082                	ret
    panic("acquire");
    80006372:	00002517          	auipc	a0,0x2
    80006376:	4d650513          	add	a0,a0,1238 # 80008848 <digits+0x20>
    8000637a:	00000097          	auipc	ra,0x0
    8000637e:	a7c080e7          	jalr	-1412(ra) # 80005df6 <panic>

0000000080006382 <pop_off>:

void
pop_off(void)
{
    80006382:	1141                	add	sp,sp,-16
    80006384:	e406                	sd	ra,8(sp)
    80006386:	e022                	sd	s0,0(sp)
    80006388:	0800                	add	s0,sp,16
  struct cpu *c = mycpu();
    8000638a:	ffffb097          	auipc	ra,0xffffb
    8000638e:	d42080e7          	jalr	-702(ra) # 800010cc <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80006392:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80006396:	8b89                	and	a5,a5,2
  if(intr_get())
    80006398:	e78d                	bnez	a5,800063c2 <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    8000639a:	5d3c                	lw	a5,120(a0)
    8000639c:	02f05b63          	blez	a5,800063d2 <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    800063a0:	37fd                	addw	a5,a5,-1
    800063a2:	0007871b          	sext.w	a4,a5
    800063a6:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    800063a8:	eb09                	bnez	a4,800063ba <pop_off+0x38>
    800063aa:	5d7c                	lw	a5,124(a0)
    800063ac:	c799                	beqz	a5,800063ba <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800063ae:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800063b2:	0027e793          	or	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800063b6:	10079073          	csrw	sstatus,a5
    intr_on();
}
    800063ba:	60a2                	ld	ra,8(sp)
    800063bc:	6402                	ld	s0,0(sp)
    800063be:	0141                	add	sp,sp,16
    800063c0:	8082                	ret
    panic("pop_off - interruptible");
    800063c2:	00002517          	auipc	a0,0x2
    800063c6:	48e50513          	add	a0,a0,1166 # 80008850 <digits+0x28>
    800063ca:	00000097          	auipc	ra,0x0
    800063ce:	a2c080e7          	jalr	-1492(ra) # 80005df6 <panic>
    panic("pop_off");
    800063d2:	00002517          	auipc	a0,0x2
    800063d6:	49650513          	add	a0,a0,1174 # 80008868 <digits+0x40>
    800063da:	00000097          	auipc	ra,0x0
    800063de:	a1c080e7          	jalr	-1508(ra) # 80005df6 <panic>

00000000800063e2 <release>:
{
    800063e2:	1101                	add	sp,sp,-32
    800063e4:	ec06                	sd	ra,24(sp)
    800063e6:	e822                	sd	s0,16(sp)
    800063e8:	e426                	sd	s1,8(sp)
    800063ea:	1000                	add	s0,sp,32
    800063ec:	84aa                	mv	s1,a0
  if(!holding(lk))
    800063ee:	00000097          	auipc	ra,0x0
    800063f2:	ec6080e7          	jalr	-314(ra) # 800062b4 <holding>
    800063f6:	c115                	beqz	a0,8000641a <release+0x38>
  lk->cpu = 0;
    800063f8:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    800063fc:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    80006400:	0f50000f          	fence	iorw,ow
    80006404:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    80006408:	00000097          	auipc	ra,0x0
    8000640c:	f7a080e7          	jalr	-134(ra) # 80006382 <pop_off>
}
    80006410:	60e2                	ld	ra,24(sp)
    80006412:	6442                	ld	s0,16(sp)
    80006414:	64a2                	ld	s1,8(sp)
    80006416:	6105                	add	sp,sp,32
    80006418:	8082                	ret
    panic("release");
    8000641a:	00002517          	auipc	a0,0x2
    8000641e:	45650513          	add	a0,a0,1110 # 80008870 <digits+0x48>
    80006422:	00000097          	auipc	ra,0x0
    80006426:	9d4080e7          	jalr	-1580(ra) # 80005df6 <panic>
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
