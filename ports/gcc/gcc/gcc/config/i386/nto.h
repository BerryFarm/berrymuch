/* Definitions for Intel 386 running QNX/Neutrino.
   Copyright (C) 2002, 2003, 2004, 2005, 2006 Free Software Foundation, Inc.

This file is part of GCC.

GCC is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3, or (at your option)
any later version.

GCC is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with GCC; see the file COPYING3.  If not see
<http://www.gnu.org/licenses/>.  */

#undef  DEFAULT_PCC_STRUCT_RETURN
#define DEFAULT_PCC_STRUCT_RETURN 1

#undef TARGET_VERSION
#define TARGET_VERSION	fprintf (stderr, " (QNX/Neutrino/i386 ELF)");

#undef TARGET_OS_CPP_BUILTINS
#define TARGET_OS_CPP_BUILTINS()		\
  do						\
    {						\
        NTO_TARGET_OS_CPP_BUILTINS();           \
        builtin_define_std ("__X86__");		\
        builtin_define ("__LITTLEENDIAN__");    \
    }						\
  while (0)

#undef CPP_SPEC
#define CPP_SPEC \
QNX_SYSTEM_INCLUDES \
" %(cpp_cpu) \
 %{posix:-D_POSIX_SOURCE}"

#undef STARTFILE_SPEC
#define STARTFILE_SPEC \
"%{!shared: %{pg|p|profile:%$QNX_TARGET/x86/lib/mcrt1.o%s; \
		pie: %$QNX_TARGET/x86/lib/crt1S.o%s; \
		static|nopie:%$QNX_TARGET/x86/lib/crt1.o%s; \
		:%$QNX_TARGET/x86/lib/crt1S.o%s}} \
%$QNX_TARGET/x86/lib/crti.o%s crtbegin.o%s" 

#undef ENDFILE_SPEC
#define ENDFILE_SPEC "crtend.o%s %$QNX_TARGET/x86/lib/crtn.o"

#define QNX_SYSTEM_LIBDIRS \
"-L %$QNX_TARGET/x86/lib/gcc/%v1.%v2.%v3 \
 -L %$QNX_TARGET/x86/lib \
 -L %$QNX_TARGET/x86/usr/lib \
 -L %$QNX_TARGET/x86/opt/lib \
 -rpath-link %$QNX_TARGET/x86/lib/gcc/%v1.%v2.%v3:\
%$QNX_TARGET/x86/lib:\
%$QNX_TARGET/x86/usr/lib:\
%$QNX_TARGET/x86/opt/lib"

#undef LIB_SPEC
#define LIB_SPEC \
  QNX_SYSTEM_LIBDIRS \
  "%{!symbolic: -lc -Bstatic %{static|nopie: -lc;:-lcS}}"

#undef LINK_SPEC
#define LINK_SPEC \
  "%{h*} %{v:-V} \
   %{b} \
   %{!r:--build-id=md5} \
   %{static:-dn -Bstatic} \
   %{shared:-G -dy} \
   %{symbolic:-Bsymbolic -G -dy} \
   %{G:-G} \
   %{YP,*} \
   %{!YP,*:%{p:-Y P,%R/lib} \
    %{!p:-Y P,%R/lib}} \
   %{Qy:} %{!Qn:-Qy} \
   -m i386nto \
   %{!shared: \
     %{!static: \
       %{rdynamic:-export-dynamic}} \
     --dynamic-linker /usr/lib/ldqnx.so.2}"

#undef SIZE_TYPE
#define SIZE_TYPE "unsigned int"

#undef PTRDIFF_TYPE
#define PTRDIFF_TYPE "int"

#undef EH_FRAME_SECTION_NAME
#define EH_FRAME_SECTION_NAME ".eh_frame"

/* Define the register numbers to be used in Dwarf debugging information.
   QNX NTO use the SVR4 register numbers in Dwarf output code, for gdb */
#undef DBX_REGISTER_NUMBER
#define DBX_REGISTER_NUMBER(n) \
  (TARGET_64BIT ? dbx64_register_map[n] : svr4_dbx_register_map[n])

/* Put all *tf routines in libgcc.  */
#undef LIBGCC2_HAS_TF_MODE
#define LIBGCC2_HAS_TF_MODE 1
#define LIBGCC2_TF_CEXT q
#define TF_SIZE 113
