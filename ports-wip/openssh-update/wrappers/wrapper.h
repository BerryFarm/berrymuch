#include <process.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define SSHPATH "/app/native/root/bin/ssh"
#define INTPATH "/app/native/root/libexec/"

int main(int argc, char* argv[]){

  char* sandbox = getenv("SANDBOX");
  char* path = PROGRAM;
  char* ssh;
  char** args = calloc(argc + 4, sizeof(char*));
  int i, r, p = 1;
  size_t lp, ls;
  char fix = 0;

  args[0] = PROGRAM;

  if(sandbox != NULL){
    fix = 1;
    lp = (size_t)strlen(sandbox) + strlen(INTPATH) + strlen(PROGRAM) + 1;
    ls = (size_t)strlen(sandbox) + strlen(SSHPATH) + 1;
    path = calloc(lp, sizeof(char));
    ssh  = calloc(ls, sizeof(char));
    r = snprintf(path, lp, "%s%s%s", sandbox, INTPATH, PROGRAM);
    if(r < 0) { path = PROGRAM; fix = 0; }
    r = snprintf(ssh,  ls, "%s%s",   sandbox, SSHPATH);
    if(r < 0) { ssh = NULL, fix = 0; }
    if(fix){
      args[1] = "-S";
      args[2] = ssh;
      p = 3;
    }
  }
  /* assuming everything went well, then 
   *   path = $SANDBOX/$INTPATH/$PROGRAM
   *   ssh =  $SANDBOX/$SSHPATH
   *   p = 2
   * else
   *   path = $PROGRAM
   *   ssh = NULL
   *   p = 0
   * and we use execvp and hope PATH can sort it out.
   */
  for(i = 1; i < argc; ++i){
    args[i + p - 1] = argv[i];
  }

  if(fix){
    return execv(path, args);
  } else {
    return execvp(path, args);
  }
  return 0;
}
