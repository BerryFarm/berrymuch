/* Definitions of target machine for gcc for Hitachi Super-H running
   QNX Neutrino.
   Copyright (C) 1996 Free Software Foundation, Inc.

This file is part of GNU CC.

GNU CC is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2, or (at your option)
any later version.

GNU CC is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with GNU CC; see the file COPYING.  If not, write to
the Free Software Foundation, 59 Temple Place - Suite 330,
Boston, MA 02111-1307, USA.  */

/* Run-time Target Specification.  */
#undef TARGET_VERSION
#define TARGET_VERSION  fputs (" (QNX/Neutrino/SH ELF)", stderr);

/* For now force sjlj exception handling, for compatibility with 
   older Dinkum libs. */
#define DWARF2_UNWIND_INFO 1 

#undef TARGET_DEFAULT 
#define TARGET_DEFAULT  (TARGET_CPU_DEFAULT | MASK_USERMODE | \
			TARGET_ENDIAN_DEFAULT | TARGET_OPT_DEFAULT)

/* Return to the original ELF way.  */
#undef USER_LABEL_PREFIX
#define USER_LABEL_PREFIX ""

#undef LOCAL_LABEL_PREFIX
#define LOCAL_LABEL_PREFIX "."

#undef SIZE_TYPE
#define SIZE_TYPE "unsigned int"

#undef PTRDIFF_TYPE
#define PTRDIFF_TYPE "int"

#define BOOL_TYPE_SIZE POINTER_SIZE

#define QNX_SYSTEM_LIBDIRS \
"-L %$QNX_TARGET/sh%{EB:be}%{!EB:le}/lib/gcc/%v1.%v2.%v3 \
 -L %$QNX_TARGET/sh%{EB:be}%{!EB:le}/lib \
 -L %$QNX_TARGET/sh%{EB:be}%{!EB:le}/usr/lib \
 -L %$QNX_TARGET/sh%{EB:be}%{!EB:le}/opt/lib \
 -rpath-link %$QNX_TARGET/sh%{EB:be}%{!EB:le}/lib/gcc/%v1.%v2.%v3:\
%$QNX_TARGET/sh%{EB:be}%{!EB:le}/lib:\
%$QNX_TARGET/sh%{EB:be}%{!EB:le}/usr/lib:\
%$QNX_TARGET/sh%{EB:be}%{!EB:le}/opt/lib "

#undef SUBTARGET_CPP_SPEC
#define SUBTARGET_CPP_SPEC \
QNX_SYSTEM_INCLUDES " \
 -D__SH4__ \
 %{posix:-D_POSIX_SOURCE} \
 %{!mb:-D__LITTLE_ENDIAN__} \
 %{!mb:-D__LITTLEENDIAN__} \
 %{mb:-D__BIG_ENDIAN__} \
 %{mb:-D__BIGENDIAN__}"

#undef CPP_DEFAULT_CPU_SPEC
#define CPP_DEFAULT_CPU_SPEC "-D__SH4__ -D__sh4__"

#define TARGET_OS_CPP_BUILTINS()                \
do {                                            \
        NTO_TARGET_OS_CPP_BUILTINS();           \
	builtin_define ("__SH__");              \
} while (0)

#undef ASM_SPEC
#define ASM_SPEC  "%{!mb:-little} %{mrelax:-relax} --isa=sh4"

#undef CC1_SPEC
#define CC1_SPEC "%(cc1_spec) %{!mb:-ml} -m4"

#undef CC1PLUS_SPEC
#define CC1PLUS_SPEC "%(cc1plus_spec) %{!mb:-ml} -m4"

#undef FUNCTION_PROFILER
#define SH_MCOUNT_NAME "_mcount"
#define FUNCTION_PROFILER(STREAM,LABELNO)                              \
do                                                                     \
{                                                                      \
  if (flag_pic)                                                        \
    {                                                                  \
      fprintf (STREAM, "       mov.l   3f,r1\n");                      \
      fprintf (STREAM, "       mova    3f,r0\n");                      \
      fprintf (STREAM, "       add     r1,r0\n");                      \
      fprintf (STREAM, "       mov.l   1f,r1\n");                      \
      fprintf (STREAM, "       mov.l   @(r0,r1),r1\n");                \
    }                                                                  \
  else                                                                 \
    {                                                                  \
      fprintf (STREAM, "       mov.l   1f,r1\n");                      \
    }                                                                  \
  fprintf (STREAM, "   sts.l   pr,@-r15\n");                           \
  fprintf (STREAM, "   mova    2f,r0\n");                              \
  fprintf (STREAM, "   jmp     @r1\n");                                \
  fprintf (STREAM, "   lds     r0,pr\n");                              \
  fprintf (STREAM, "   .align  2\n");                                  \
  if (flag_pic)                                                        \
    {                                                                  \
      fprintf (STREAM, "1:     .long   %s@GOT\n", SH_MCOUNT_NAME);     \
      fprintf (STREAM, "3:     .long   _GLOBAL_OFFSET_TABLE_\n");      \
    }                                                                  \
  else                                                                 \
    {                                                                  \
      fprintf (STREAM, "1:     .long   %s\n", SH_MCOUNT_NAME);         \
    }                                                                  \
  fprintf (STREAM, "2: lds.l   @r15+,pr\n");                           \
} while (0)

#undef LINK_SPEC
#define LINK_SPEC \
"%{!mb:-EL}%{mb:-EB} -z now %{!mb:-m shlelf_nto}%{mb:-m shelf_nto} \
 %{mrelax:-relax} -YP,%$QNX_TARGET/lib -YP,%$QNX_TARGET/usr/lib \
 %{MAP:-Map mapfile} %{static:-dn -Bstatic} %{shared:-G -dy} \
 %{symbolic: -Bsymbolic -G -dy} %{G:-G} \
 %{!shared: --dynamic-linker /usr/lib/ldqnx.so.2}"

#undef  LIB_SPEC
#define LIB_SPEC \
QNX_SYSTEM_LIBDIRS \
"%{!symbolic:-lc -dn -Bstatic %{!shared: -lc} %{shared: -lcS}}"

#undef  STARTFILE_SPEC
#define STARTFILE_SPEC \
"%{!shared: %$QNX_TARGET/sh%{mb:be}%{!mb:le}/lib/%{pg:m}%{p:m}crt1.o} \
%$QNX_TARGET/sh%{mb:be}%{!mb:le}/lib/crti.o crtbegin.o%s"

#undef  ENDFILE_SPEC
#define ENDFILE_SPEC "crtend.o%s \
%$QNX_TARGET/sh%{mb:be}%{!mb:le}/lib/crtn.o"
