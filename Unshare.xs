#ifndef __linux
#error "No linux. Compile aborted."
#endif

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#define _GNU_SOURCE
#include <sched.h>
#define CLONE_CONTAINER CLONE_NEWNS|CLONE_NEWUTS|CLONE_NEWIPC|CLONE_NEWNET|CLONE_NEWPID|CLONE_NEWUSER
#include "const-c.inc"

MODULE = Linux::Unshare		PACKAGE = Linux::Unshare

INCLUDE: const-xs.inc
PROTOTYPES: ENABLE

SV * unshare(int flags)
	CODE:
		ST(0) = sv_newmortal();
		if(unshare(flags) == 0)
			sv_setiv(ST(0), 1);
