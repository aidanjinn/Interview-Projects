#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fs.h"
#include "user/user.h"

void find(char *path, const char *name)
{
  int fd;
  struct stat st;
  struct dirent de;
  char *p, *buf = 0;

  if ((fd = open(path, 0)) < 0) {
    fprintf(2, "find: cannot open %s\n", path);
    return;
  }
  if (fstat(fd, &st) < 0) {
    fprintf(2, "find: cannot stat %s\n", path);
    return;
  }

  switch (st.type) {
    case T_FILE:
      for (p = path + strlen(path); p >= path && *p != '/'; --p);
      if (strcmp(p+1, name) == 0)
        printf("%s\n", path);
      break;
    case T_DIR:
      buf = (char*)malloc(strlen(path) + 1 + DIRSIZ + 1);
      strcpy(buf, path);
      p = buf + strlen(buf);
      *p++ = '/';
      while (read(fd, &de, sizeof(de)) == sizeof(de)) {
        if (de.inum == 0)
          continue;
        memmove(p, de.name, DIRSIZ);
        p[DIRSIZ] = 0;
        if (stat(buf, &st) < 0) {
          fprintf(2, "find: cannot stat %s\n", buf);
          continue;
        }
        if (strcmp(de.name, ".") && strcmp(de.name, ".."))
          find(buf, name);
      }
      break;
    default:
      break;
  }

  if (buf)
    free(buf);
  close(fd);
}

int main(int argc, char *argv[])
{
  if (argc != 3) {
    write(2, "error: incorrect arguments - usage: find [path] [pattern]\n", 58);
    exit(-1);
  }
  find(argv[1], argv[2]);
  exit(0);
}
