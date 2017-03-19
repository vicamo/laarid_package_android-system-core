/*
 * Copyright (C) 2011 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifdef HAVE_WINSOCK
#include <winsock2.h>
typedef int  socklen_t;
#elif HAVE_SYS_SOCKET_H
#include <sys/socket.h>
#include <sys/un.h>
#endif
#ifdef HAVE_SYSTEMD
#include <systemd/sd-daemon.h>
#endif

#include <bionic/bionic.h> /* for strlcpy */
#include <cutils/sockets.h>

#include <sys/uio.h>

#include <log/log.h>

/* For the socket trust (credentials) check */
#include <android/uidmap.h>

bool socket_peer_is_trusted(int fd) {
    ucred cr;
    socklen_t len = sizeof(cr);
    int n = getsockopt(fd, SOL_SOCKET, SO_PEERCRED, &cr, &len);

    if (n != 0) {
        ALOGE("could not get socket credentials: %s\n", strerror(errno));
        return false;
    }

    if ((cr.uid != AUID_ROOT) && (cr.uid != AUID_SHELL)) {
        ALOGE("untrusted userid on other end of socket: userid %d\n", cr.uid);
        return false;
    }

    return true;
}

int socket_close(int sock) {
    return close(sock);
}

int socket_set_receive_timeout(cutils_socket_t sock, int timeout_ms) {
    timeval tv;
    tv.tv_sec = timeout_ms / 1000;
    tv.tv_usec = (timeout_ms % 1000) * 1000;
    return setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
}

ssize_t socket_send_buffers(cutils_socket_t sock,
                            const cutils_socket_buffer_t* buffers,
                            size_t num_buffers) {
    if (num_buffers > SOCKET_SEND_BUFFERS_MAX_BUFFERS) {
        return -1;
    }

    iovec iovec_buffers[SOCKET_SEND_BUFFERS_MAX_BUFFERS];
    for (size_t i = 0; i < num_buffers; ++i) {
        // It's safe to cast away const here; iovec declares non-const
        // void* because it's used for both send and receive, but since
        // we're only sending, the data won't be modified.
        iovec_buffers[i].iov_base = const_cast<void*>(buffers[i].data);
        iovec_buffers[i].iov_len = buffers[i].length;
    }

    return writev(sock, iovec_buffers, num_buffers);
}

int android_get_control_socket(const char* name)
{
#if defined(HAVE_SYSTEMD)
	if (sd_listen_fds(0)) {
		int n = sd_listen_fds(0);
		socklen_t addrlen;
		struct sockaddr *addr =
			(struct sockaddr*) malloc(sizeof(struct sockaddr_un) + 1);

		while (addr && (n-- > 0)) {
			addrlen = sizeof(struct sockaddr_un);
			memset(addr, 0, addrlen+ 1);
			if (-1 == getsockname(SD_LISTEN_FDS_START + n,
						addr, &addrlen))
				continue;

			char *p = basename(((struct sockaddr_un*)addr)->sun_path);
			if (0 == strcmp(name, p)) {
				free(addr);
				return SD_LISTEN_FDS_START + n;
			}
		}

		free(addr);
	}
#endif

	char key[64];
	snprintf(key, sizeof(key), ANDROID_SOCKET_ENV_PREFIX "%s", name);

	const char* val = getenv(key);
	if (!val) {
		return -1;
	}

	errno = 0;
	int fd = strtol(val, NULL, 10);
	if (errno) {
		return -1;
	}

	return fd;
}
