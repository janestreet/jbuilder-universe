/* OCaml promise library
 * http://www.ocsigen.org/lwt
 * Copyright (C) 2009-2010 Jérémie Dimino
 *               2009 Mauricio Fernandez
 *               2010 Pierre Chambart
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, with linking exceptions;
 * either version 2.1 of the License, or (at your option) any later
 * version. See COPYING file for details.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
 * 02111-1307, USA.
 */

#include "lwt_config.h"

#if !defined(LWT_ON_WINDOWS)

#include <caml/mlvalues.h>
#include <caml/unixsupport.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#include "lwt_unix.h"

struct job_guess_blocking {
    struct lwt_unix_job job;
    int fd;
    int result;
};

static void worker_guess_blocking(struct job_guess_blocking *job)
{
    struct stat stat;
    if (fstat(job->fd, &stat) == 0)
        job->result = !(S_ISFIFO(stat.st_mode) || S_ISSOCK(stat.st_mode));
    else
        job->result = 1;
}

static value result_guess_blocking(struct job_guess_blocking *job)
{
    value result = Val_bool(job->result);
    lwt_unix_free_job(&job->job);
    return result;
}

CAMLprim value lwt_unix_guess_blocking_job(value val_fd)
{
    LWT_UNIX_INIT_JOB(job, guess_blocking, 0);
    job->fd = Int_val(val_fd);
    return lwt_unix_alloc_job(&(job->job));
}
#endif
