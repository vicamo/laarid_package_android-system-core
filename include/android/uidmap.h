/*
 * Copyright (C) 2017 You-Sheng Yang
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

/* This file is used to define the uid/gid query functions for LAARiD.
*/

#ifndef _ANDROID_UIDMAP_H_
#define _ANDROID_UIDMAP_H_

#include <limits.h>
#include <sys/types.h>

#define ANDROID_UID_GETTER_NAME(name) \
	android_uid_get_ ## name
#define ANDROID_UID_GETTER_DECL(name) \
	uid_t ANDROID_UID_GETTER_NAME(name)(void)
#define ANDROID_UID_GETTER_IMPL(name) \
	uid_t ANDROID_UID_GETTER_NAME(name)(void) { \
		static uid_t id = UINT_MAX; \
		if (id == UINT_MAX) { \
			id = android_uid_get(#name); \
		} \
		return id; \
	}

#define ANDROID_GID_GETTER_NAME(name) \
	android_gid_get_ ## name
#define ANDROID_GID_GETTER_DECL(name) \
	gid_t ANDROID_GID_GETTER_NAME(name)(void)
#define ANDROID_GID_GETTER_IMPL(name) \
	uid_t ANDROID_GID_GETTER_NAME(name)(void) { \
		static gid_t id = UINT_MAX; \
		if (id == UINT_MAX) { \
			id = android_gid_get(#name); \
		} \
		return id; \
	}

__BEGIN_DECLS

uid_t android_uid_get(const char* name);
gid_t android_gid_get(const char* name);

#define AUID_ROOT 0
#define AGID_ROOT 0

ANDROID_UID_GETTER_DECL(log);
#define AUID_LOG ANDROID_UID_GETTER_NAME(log)()
ANDROID_GID_GETTER_DECL(log);
#define AGID_LOG ANDROID_GID_GETTER_NAME(log)()

ANDROID_UID_GETTER_DECL(shell);
#define AUID_SHELL ANDROID_UID_GETTER_NAME(shell)()
ANDROID_GID_GETTER_DECL(shell);
#define AGID_SHELL ANDROID_GID_GETTER_NAME(shell)()

ANDROID_UID_GETTER_DECL(system);
#define AUID_SYSTEM ANDROID_UID_GETTER_NAME(system)()
ANDROID_GID_GETTER_DECL(system);
#define AGID_SYSTEM ANDROID_GID_GETTER_NAME(system)()

__END_DECLS

#endif /* _ANDROID_UIDMAP_H_ */
