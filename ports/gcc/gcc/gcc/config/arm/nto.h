#define HAVE_ATEXIT

#undef SIZE_TYPE
#define SIZE_TYPE "unsigned int"

#undef PTRDIFF_TYPE
#define PTRDIFF_TYPE "int"

#undef DEFAULT_SIGNED_CHAR
#define DEFAULT_SIGNED_CHAR  1 

#undef	TARGET_VERSION
#define	TARGET_VERSION fprintf(stderr, " (QNX/Neutrino/ARM ELF)");

#define	OBJECT_FORMAT_ELF
#define	HAS_INIT_SECTION

#undef	DEFAULT_VTABLE_THUNKS
#define DEFAULT_VTABLE_THUNKS   1

#undef  SUBTARGET_CPU_DEFAULT
#define SUBTARGET_CPU_DEFAULT TARGET_CPU_strongarm

#undef TARGET_DEFAULT
#define TARGET_DEFAULT MASK_APCS_FRAME

/* We default to a soft-float ABI so that binaries can run on all
   target hardware.  */
#undef TARGET_DEFAULT_FLOAT_ABI
#define TARGET_DEFAULT_FLOAT_ABI ARM_FLOAT_ABI_SOFT

#undef ARM_DEFAULT_ABI
#define ARM_DEFAULT_ABI ARM_ABI_APCS

#undef  MULTILIB_DEFAULTS
#define MULTILIB_DEFAULTS \
        { "marm", "mlittle-endian", "mhard-float", "mapcs-32", "mno-thumb-interwork" }

#define TARGET_OS_CPP_BUILTINS()                \
do {                                            \
	NTO_TARGET_OS_CPP_BUILTINS();           \
	builtin_define ("__ARM__");             \
} while (0)

#undef ASM_SPEC
#define ASM_SPEC \
"%{EB:-EB} %{!EB:-EL} %{EL:-EL} \
 %{fpic|fPIC:--defsym __PIC__=1} \
 %{mcpu=*:-mcpu=%*} \
 %{march=*:-march=%*} \
 %{mfloat-abi=*} %{mfpu=*} \
 %{mapcs-float:-mfloat} \
 %{!mhard-float: %{!mfpu=*:-mfpu=softvfp}}" 

#define QNX_SYSTEM_LIBDIRS \
"-L %$QNX_TARGET/arm%{EB:be}%{!EB:le}/lib/gcc/%v1.%v2.%v3 \
 -L %$QNX_TARGET/arm%{EB:be}%{!EB:le}/lib \
 -L %$QNX_TARGET/arm%{EB:be}%{!EB:le}/usr/lib \
 -L %$QNX_TARGET/arm%{EB:be}%{!EB:le}/opt/lib \
 -rpath-link %$QNX_TARGET/arm%{EB:be}%{!EB:le}/lib/gcc/%v1.%v2.%v3:\
%$QNX_TARGET/arm%{EB:be}%{!EB:le}/lib:\
%$QNX_TARGET/arm%{EB:be}%{!EB:le}/usr/lib:\
%$QNX_TARGET/arm%{EB:be}%{!EB:le}/opt/lib "

#undef LIB_SPEC
#define LIB_SPEC \
  QNX_SYSTEM_LIBDIRS \
  "%{!symbolic: -lc -Bstatic %{!shared: -lc} %{shared:-lcS}}"

#undef LIBGCC_SPEC
#define LIBGCC_SPEC "-lgcc"

#undef STARTFILE_SPEC
#define STARTFILE_SPEC \
"%{!shared: %$QNX_TARGET/arm%{EB:be}%{!EB:le}/lib/%{pg:m}%{p:m}crt1.o \
  } \
%$QNX_TARGET/arm%{EB:be}%{!EB:le}/lib/crti.o \
crtbegin.o%s " 

#undef ENDFILE_SPEC
#define ENDFILE_SPEC \
"crtend.o%s %$QNX_TARGET/arm%{EB:be}%{!EB:le}/lib/crtn.o"

#undef LINK_SPEC
#define LINK_SPEC \
"%{h*} %{v:-V} \
 %{b} %{Wl,*:%*} \
 %{static:-Bstatic} \
 %{shared} \
 %{symbolic:-Bsymbolic} \
 %{G:-G} %{MAP:-Map mapfile} \
 %{!shared: \
   %{!static: \
     %{rdynamic:-export-dynamic}} \
   --dynamic-linker /usr/lib/ldqnx.so.2} \
 -m armnto -X \
 %{EB:-EB} %{!EB:-EL} %{EL:-EL}"

#undef CPP_APCS_PC_DEFAULT_SPEC
#define CPP_APCS_PC_DEFAULT_SPEC "-D__APCS_32__"

#undef	SUBTARGET_CPP_SPEC
#define	SUBTARGET_CPP_SPEC \
 QNX_SYSTEM_INCLUDES "\
 %(cpp_cpu) \
 %{!EB:-D__LITTLEENDIAN__ -D__ARMEL__} \
 %{EB:-D__BIGENDIAN__ -D__ARMEB__} \
 %{posix:-D_POSIX_SOURCE}"

#undef	CC1_SPEC
#define	CC1_SPEC "%{EB:-mbig-endian} %{!EB:-mlittle-endian}"

/*
 * Keep floating point word order the same as multi-word integers
 */
#undef FLOAT_WORDS_BIG_ENDIAN

/* Call the function profiler with a given profile label. 
   This is _mcount on other nto's.  It is mcount on ntoarm.  Leave it,
   or make sure it is also changed in lib/c/prof/arm/profile.h.  */
#undef ARM_FUNCTION_PROFILER
#define ARM_FUNCTION_PROFILER(STREAM, LABELNO)  				\
{									\
  fprintf (STREAM, "\tbl\tmcount%s\n", NEED_PLT_RELOC ? "(PLT)" : "");	\
}

#undef BOOL_TYPE_SIZE
#define BOOL_TYPE_SIZE POINTER_SIZE

/* Switch into a generic section.
   This is currently only used to support section attributes.

   We make the section read-only and executable for a function decl,
   read-only for a const data decl, and writable for a non-const data decl.  */

#undef  DEFAULT_STRUCTURE_SIZE_BOUNDARY
#define DEFAULT_STRUCTURE_SIZE_BOUNDARY 8

#undef ASM_OUTPUT_EXTERNAL_LIBCALL

#undef SUBTARGET_EXTRA_SPECS
#define SUBTARGET_EXTRA_SPECS                           \
  { "subtarget_asm_float_spec", SUBTARGET_ASM_FLOAT_SPEC }, \

#undef SUBTARGET_ASM_FLOAT_SPEC
#define SUBTARGET_ASM_FLOAT_SPEC "\
 %{mapcs-float:-mfloat} %{!mhard-float:-mfpu=softvfp} %{mhard-float:-mfpu=vfp}"

#undef CLEAR_INSN_CACHE
#define CLEAR_INSN_CACHE(BEG, END)                                      \
{                                                                       \
 register unsigned long _beg __asm ("a1") = (unsigned long) (BEG);      \
  register unsigned long _len __asm ("a2") = (unsigned long) (END) - (unsigned long) (BEG); \
  register unsigned long _flg __asm ("a3") = 0x2;			\
  __asm __volatile ("bl	msync"						\
                    : "=r" (_beg)					\
                    : "r" (_beg), "r" (_len), "r" (_flg));		\
}

#undef FPUTYPE_DEFAULT
#define FPUTYPE_DEFAULT "vfp" 

#define USE_OLD_ATBASE
