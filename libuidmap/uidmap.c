#include <grp.h>
#include <pwd.h>
#include <unistd.h>

#include "android/uidmap.h"

uid_t android_uid_get(const char* name)
{
  static long pw_buf_len = 0;

  if (!pw_buf_len)
    pw_buf_len = sysconf(_SC_GETPW_R_SIZE_MAX);

  struct passwd pwd, *pwdp = NULL;
  char buf[pw_buf_len];

  if (0 == getpwnam_r(name, &pwd, buf, sizeof(buf), &pwdp))
    return pwd.pw_uid;

  return UINT_MAX;
}

gid_t android_gid_get(const char* name)
{
  static long gr_buf_len = 0;

  if (!gr_buf_len)
    gr_buf_len = sysconf(_SC_GETGR_R_SIZE_MAX);

  struct group grp, *grpp = NULL;
  char buf[gr_buf_len];

  if (0 == getgrnam_r(name, &grp, buf, sizeof(buf), &grpp))
    return grp.gr_gid;

  return UINT_MAX;
}

ANDROID_UID_GETTER_IMPL(graphics)
ANDROID_GID_GETTER_IMPL(graphics)

ANDROID_UID_GETTER_IMPL(log)
ANDROID_GID_GETTER_IMPL(log)

ANDROID_GID_GETTER_IMPL(readproc)

ANDROID_UID_GETTER_IMPL(shell)
ANDROID_GID_GETTER_IMPL(shell)

ANDROID_UID_GETTER_IMPL(system)
ANDROID_GID_GETTER_IMPL(system)
