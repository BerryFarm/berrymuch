/* Definitions of target machine for GNU compiler.  MIPS QNX Neutrino.
   Copyright (C) 2003 Free Software Foundation, Inc.

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

/* These don't work in the presence of $gp relative calls */
#undef ASM_OUTPUT_REG_PUSH
#undef ASM_OUTPUT_REG_POP

#undef MULTILIB_DEFAULTS
#define MULTILIB_DEFAULTS {""}

#define QNX_SYSTEM_LIBDIRS \
"-L %$QNX_TARGET/mips%{EL:le}%{!EL:be}/lib/gcc/%v1.%v2.%v3 \
 -L %$QNX_TARGET/mips%{EL:le}%{!EL:be}/lib \
 -L %$QNX_TARGET/mips%{EL:le}%{!EL:be}/usr/lib \
 -L %$QNX_TARGET/mips%{EL:le}%{!EL:be}/opt/lib \
 -rpath-link %$QNX_TARGET/mips%{EL:be}%{!EL:be}/lib/gcc/%v1.%v2.%v3:\
%$QNX_TARGET/mips%{EL:le}%{!EL:be}/lib:\
%$QNX_TARGET/mips%{EL:le}%{!EL:be}/usr/lib:\
%$QNX_TARGET/mips%{EL:le}%{!EL:be}/opt/lib "

#undef LIB_SPEC
#define LIB_SPEC \
  QNX_SYSTEM_LIBDIRS \
  "%{!symbolic: -lc -Bstatic %{!shared: -lc} %{shared:-lcS}}"

#undef LIBGCC_SPEC
#define LIBGCC_SPEC "-lgcc"

/* If we don't set MASK_ABICALLS, we can't default to PIC.  */
#undef TARGET_DEFAULT
#define TARGET_DEFAULT MASK_ABICALLS

#undef STARTFILE_SPEC
#define STARTFILE_SPEC \
"%{!shared: %$QNX_TARGET/mips%{EL:le}%{!EL:be}/lib/%{pg:m}%{p:m}crt1.o} \
%$QNX_TARGET/mips%{EL:le}%{!EL:be}/lib/crti_PIC.o crtbegin.o%s"

#undef ENDFILE_SPEC
#define ENDFILE_SPEC \
"crtend.o%s %$QNX_TARGET/mips%{EL:le}%{!EL:be}/lib/crtn_PIC.o"

#undef LINK_SPEC
#define LINK_SPEC "\
%{!EL:%{!mel:-EB}} %{EL|leb:-EL} \
%{G*} %{mips1} %{mips2} %{mips3} %{mips4} %{mips32} %{mips64} \
%{shared} %{non_shared} \
%{!EL:%{!mel:-belf32-tradbigmips}} %{EL|mel:-belf32-tradlittlemips} \
%{MAP: -Map mapfile} \
%{static: -dn -Bstatic} \
%{!shared: --dynamic-linker /usr/lib/ldqnx.so.3} \
-melf32btsmip"

#undef SUBTARGET_CC1_SPEC
#define SUBTARGET_CC1_SPEC "%{!mips*: %{!march*: -mips2}} \
%{mshared|mno-shared|fpic|fPIC|fpie|fPIE:;:-mno-shared -mplt}"

#undef TARGET_OS_CPP_BUILTINS
#define TARGET_OS_CPP_BUILTINS()                  \
do                                                \
   {                                              \
	NTO_TARGET_OS_CPP_BUILTINS();             \
	builtin_define_std ("__MIPS__");          \
	if (TARGET_ABICALLS)                      \
	  builtin_define ("__MIPS_ABICALLS__");   \
  }						  \
  while (0)

#undef SUBTARGET_CPP_SPEC
#define SUBTARGET_CPP_SPEC QNX_SYSTEM_INCLUDES " \
%{!EL:-D__BIGENDIAN__} \
%{EL:-D__LITTLEENDIAN__} \
%{fpic: -D__PIC__} %{fPIC: -D__PIC__} \
%{posix:-D_POSIX_SOURCE}"

#undef SUBTARGET_ASM_SPEC
#define SUBTARGET_ASM_SPEC "\
%{!mips*: %{!march*: -mips2}}" 

#undef BOOL_TYPE_SIZE
#define BOOL_TYPE_SIZE POINTER_SIZE

#undef MIPS_DEFAULT_GVALUE
#define MIPS_DEFAULT_GVALUE 0

/* The MIPS assembler has different syntax for .set. We set it to
   .dummy to trap any errors.  */
#undef SET_ASM_OP
#define SET_ASM_OP "\t.dummy\t"

#undef ASM_OUTPUT_DEF
#define ASM_OUTPUT_DEF(FILE,LABEL1,LABEL2)				\
 do {									\
	fputc ( '\t', FILE);						\
	assemble_name (FILE, LABEL1);					\
	fputs ( " = ", FILE);						\
	assemble_name (FILE, LABEL2);					\
	fputc ( '\n', FILE);						\
 } while (0)
