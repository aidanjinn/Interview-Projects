#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "sysinfo.h"
#include "proc.h"

uint64
sys_exit(void)
{
  int n;
  argint(0, &n);
  exit(n);
  return 0;  // not reached
}

uint64
sys_getpid(void)
{
  return myproc()->pid;
}

uint64
sys_fork(void)
{
  return fork();
}

uint64
sys_wait(void)
{
  uint64 p;
  argaddr(0, &p);
  return wait(p);
}

uint64
sys_sbrk(void)
{
  uint64 addr;
  int n;

  argint(0, &n);
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

uint64
sys_sleep(void)
{
  int n;
  uint ticks0;

  argint(0, &n);
  if(n < 0)
    n = 0;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

int
sys_pgaccess(void)
{
  struct proc *p = myproc();
  uint64 va, res, bitmask = 0;
  int n;

  argaddr(0, &va);
  argint(1,  &n);
  argaddr(2, &res);
  va = PGROUNDDOWN(va);
  if((n > 64) || (va + (n * PGSIZE) >= MAXVA))
    return -1;
  
  for (int i = 0; i < n; ++i) {
    pte_t *pte = walk(p->pagetable, va + (i * PGSIZE), 0);
    if(pte){
      if(*pte & PTE_A)
        bitmask |= (1L << i);
      *pte &= ~PTE_A;
    }
  }

  if(copyout(p->pagetable, res, (char*)&bitmask, sizeof(bitmask)) < 0)
    return -1;
  return 0;
}

uint64
sys_kill(void)
{
  int pid;

  argint(0, &pid);
  return kill(pid);
}

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

uint64
sys_trace(void)
{
  int mask;

  argint(0, &mask);
  myproc()->tracemask = mask;
  return 0;
}

uint64
sys_sysinfo(void)
{
  struct proc *p = myproc();
  uint64 infoaddr; // user pointer to struct sysinfo
  struct sysinfo info = { .freemem = kfreesize(), .nproc = procsinuse() };

  argaddr(0, &infoaddr);
  if(copyout(p->pagetable, infoaddr, (char*)&info, sizeof(info)) < 0)
    return -1;
  return 0;
}

uint64
sys_setpriority(void)
{
  int priority;
  argint(0, &priority);
  return setpriority(priority);
}
