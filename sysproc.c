#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int sys_clone(void){
  void *stack, *arg;
  void(*func)(void*);
  if(argptr(0, (void*)&func, sizeof(func))<0 || argptr(1, (void*)&arg, sizeof(arg))<0 || argptr(2, (void*)&stack, sizeof(stack)) < 0)
    return -1;
   
  return clone(func, arg, stack);
}
int sys_join(void){
  void **childStack;
  int threadId;
  if(argint(0, &threadId)<0 || argptr(1, (void*)&childStack, sizeof(childStack)) < 0)
    return -1;
  join(threadId, childStack);
  return 0;
}

int sys_threadSleep(void){
  mpthread_mutex_t *mutex;
  if(argptr(0, (void*)&mutex, sizeof(mpthread_mutex_t)) <0 )
    return -1;
  threadSleep(mutex);
  return 0;
}

int sys_threadWake(void){
  int threadId;
  if(argint(0, &threadId) < 0)
   return -1;
  threadWake(threadId);
  return 0;
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return proc->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;
  
  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}
