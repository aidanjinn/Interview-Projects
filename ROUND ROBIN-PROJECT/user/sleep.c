#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char *argv[])
{
  if (argc != 2) {
    write(2, "error: missing number of ticks\n", 31);
    exit(-1);
  }
  sleep(atoi(argv[1]));
  exit(0);
}
