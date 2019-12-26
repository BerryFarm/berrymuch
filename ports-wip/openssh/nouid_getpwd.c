#include <stdlib.h>
#include <sys/types.h>
#include <pwd.h>

static struct passwd fakepwd;
static char* fakepwd_name = "AppUser";
static char* fakepwd_shell = "/bin/sh";
static char* fakepwd_passwd = "*";

struct passwd* getfakepwd()
{
    fakepwd.pw_shell = fakepwd_shell;
    fakepwd.pw_passwd = fakepwd_passwd;
    fakepwd.pw_dir = getenv("HOME");
    return &fakepwd;
}

struct passwd *nouid_getpwuid(uid_t uid){
  struct passwd *realpwd;
  realpwd = getpwuid(uid);
  if(realpwd == NULL){
    /* this user has no passwd entry.
     * Fake one up. */
    fakepwd.pw_name = fakepwd_name;
    fakepwd.pw_gecos = fakepwd_name;
    fakepwd.pw_uid = uid;
    fakepwd.pw_gid = (gid_t)uid;
    return getfakepwd();
  }
  return realpwd;
}
struct passwd *nouid_getpwnam(const char* name){
  struct passwd *realpwd;
  realpwd = getpwnam(name);
  if(realpwd == NULL){
    fakepwd.pw_name = name;
    fakepwd.pw_gecos = name;
    fakepwd.pw_uid = getuid();
    fakepwd.pw_gid = getgid();
    return getfakepwd();
  }
  return realpwd;
}
