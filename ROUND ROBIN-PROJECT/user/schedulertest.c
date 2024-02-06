#include "kernel/types.h"
#include "kernel/riscv.h"
#include "kernel/sysinfo.h"
#include "user/user.h"


void
testdefault() {
  printf("testdefault: OK\n");
}

void
testsyscall() {
  if (setpriority(10)) {
    printf("schedulertest: setpriority 10 failed\n");
    exit(1);
  }
  if (setpriority(1)) {
    printf("schedulertest: setpriority 1 failed\n");
    exit(1);
  }
  if (setpriority(0) != -1) {
    printf("schedulertest: setpriority 0 failed\n");
    exit(1);
  }
  if (setpriority(11) != -1) {
    printf("schedulertest: setpriority 11 failed\n");
    exit(1);
  }
  if (setpriority(5)) {
    printf("schedulertest: setpriority 5 failed\n");
    exit(1);
  }
  printf("testsyscall: OK\n");
}

void testprocspriority() {
  setpriority(10);
  int child_elapsed_time = uptime(), parent_elapsed_time = uptime();
  int pid = fork();
  if(pid < 0){
    printf("procspriority: fork failed\n");
    exit(1);
  }
  if(pid == 0){
    setpriority(5);
    for (int i = 0; i < 7000; ++i)
      printf(" \b");
    exit(uptime() - child_elapsed_time);
  }
  sleep(1);
  for (int i = 0; i < 7000; ++i)
      printf(" \b");
  parent_elapsed_time = uptime() - parent_elapsed_time;
  wait(&child_elapsed_time);
  int time_diff = parent_elapsed_time - child_elapsed_time;
  if (time_diff <= 3) {
    printf("\nprocspriority: failed\n");
    exit(1);
  }
  printf("\nprocspriority: OK\n");
}

void testprocspriorityinverted() {
  setpriority(5);
  int child_elapsed_time = uptime(), parent_elapsed_time = uptime();
  int pid = fork();
  if(pid < 0){
    printf("procspriorityinverted: fork failed\n");
    exit(1);
  }
  if(pid == 0){
    setpriority(10);
    for (int i = 0; i < 7000; ++i)
      printf(" \b");
    exit(uptime() - child_elapsed_time);
  }
  sleep(1);
  for (int i = 0; i < 7000; ++i)
      printf(" \b");
  parent_elapsed_time = uptime() - parent_elapsed_time;
  wait(&child_elapsed_time);
  int time_diff = child_elapsed_time - parent_elapsed_time;
  if (time_diff <= 3) {
    printf("\nprocspriorityinverted: failed\n");
    exit(1);
  }
  printf("\nprocspriorityinverted: OK\n");
}

void testprocsequal() {
  int child_elapsed_time = uptime(), parent_elapsed_time = uptime();
  int pid = fork();
  if(pid < 0){
    printf("procsequal: fork failed\n");
    exit(1);
  }
  if(pid == 0){
    for (int i = 0; i < 7000; ++i)
      printf(" \b");
    exit(uptime() - child_elapsed_time);
  }
  sleep(1);
  for (int i = 0; i < 7000; ++i)
      printf(" \b");
  parent_elapsed_time = uptime() - parent_elapsed_time;
  wait(&child_elapsed_time);
  int time_diff = (parent_elapsed_time > child_elapsed_time) ?
    parent_elapsed_time - child_elapsed_time :
    child_elapsed_time - parent_elapsed_time;
  if (time_diff > 3) {
    printf("\nprocsequal: failed:\n");
    exit(1);
  }
  printf("\nprocsequal: OK\n");
}

int
main(int argc, char *argv[])
{
  printf("schedulertest: start\n");
  testdefault();
  testsyscall();
#if defined(_NCPUS) && (_NCPUS == 1)
  testprocspriority();
  testprocspriorityinverted();
#else
  testprocsequal();
#endif
  printf("schedulertest: OK\n");
  exit(0);
}
