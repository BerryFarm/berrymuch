# This shell script emits a C file. -*- C -*-
#   Copyright 2006 Free Software Foundation, Inc.
#
# This file is part of GLD, the Gnu Linker.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston, MA 02110-1301, USA.
#

# This file is sourced from elf32.em, and defines extra Neutrino 
# specific routines.

if test -n "$NTO_BASE_EM_FILE" ; then
. "${srcdir}/emultempl/${NTO_BASE_EM_FILE}.em"
fi

cat >>e${EMULATION_NAME}.c <<EOF

#include "elf/internal.h"
#include "elf-bfd.h"
#include "../bfd/libbfd.h"

#define NOTE_SEC_NAME ".note"
#define QNX_NOTE_NAME "QNX"
#define QNX_NOTE_NAMESZ 4
#define QNX_LAZY_STACK 1

#define QNT_STACK 3

bfd_boolean nto_lazy_stack = FALSE;
bfd_boolean nto_stack_flag = FALSE;
static int stacksize;

void add_note_section(void);
static void
nto_after_open (void)
{
   add_note_section();
   gld${EMULATION_NAME}_after_open ();
}

void add_note_section() {
  asection *note_sec;
  asection *info_sec;

  bfd *first_bfd;

  first_bfd = 0;
  note_sec = 0;
  LANG_FOR_EACH_INPUT_STATEMENT (f)
   { 
      if (! first_bfd)
        first_bfd = f->the_bfd;
      info_sec = bfd_get_section_by_name (f->the_bfd, NOTE_SEC_NAME);
      if (! info_sec) 
        continue;
      
      /* Do not include this copy of .note in the output.  */

   } 
   if (first_bfd && nto_stack_flag) { 
     note_sec = bfd_make_section_with_flags (first_bfd, ".note",
					   SEC_HAS_CONTENTS | SEC_READONLY); 
     if (! note_sec)
       einfo (_("%F%P: failed to create .note section\n"));
   }
   if (note_sec)  {
     char *data;
     int note_size;
     note_sec->flags &= ~SEC_EXCLUDE;
     note_sec->flags &= ~SEC_DATA;
     note_sec->flags |=  SEC_IN_MEMORY | SEC_LOAD | SEC_ALLOC;
     note_sec->output_offset = 0;
     note_sec->user_set_vma = 1;
     elf_section_data (note_sec)->this_hdr.sh_type = SHT_NOTE;
     //data = xmalloc(100);
     //strcpy(data, "QNX");
     note_size = 4 ;
     //  data[note_size++] = 0;
     //while ((note_size & 3) != 0);
     if (nto_lazy_stack) 
       note_size += 4;
     note_sec->size = 12 + QNX_NOTE_NAMESZ + note_size;
     note_sec->contents = xmalloc (note_sec->size);
     bfd_put_32 (note_sec->owner, QNX_NOTE_NAMESZ, note_sec->contents + 0);
     bfd_put_32 (note_sec->owner, note_size, note_sec->contents + 4);
     bfd_put_32 (note_sec->owner, QNT_STACK, note_sec->contents + 8);
     memcpy (note_sec->contents + 12, QNX_NOTE_NAME, QNX_NOTE_NAMESZ);
     bfd_put_32 (note_sec->owner, stacksize, note_sec->contents + 12 + QNX_NOTE_NAMESZ);
     if (nto_lazy_stack) 
       bfd_put_32 (note_sec->owner, QNX_LAZY_STACK, note_sec->contents + 12 + QNX_NOTE_NAMESZ + 4);
     free (data);
   }
}
EOF

# Define some shell vars to insert bits of code into the standard elf
# parse_args and list_options functions.
#

PARSE_AND_LIST_PROLOGUE=$PARSE_AND_LIST_PROLOGUE'
#define OPTION_STACK		500
#define OPTION_LAZY_STACK	(OPTION_STACK + 1)
'

PARSE_AND_LIST_LONGOPTS=$PARSE_AND_LIST_LONGOPTS'
  { "stack", required_argument, NULL, OPTION_STACK },
  { "lazy-stack", no_argument, NULL, OPTION_LAZY_STACK },
'

PARSE_AND_LIST_OPTIONS=$PARSE_AND_LIST_OPTIONS'
  fprintf (file, _("\
  --stack <size>	Set size of the initial stack\n\
  --lazy-stack		Set lazy allocation of stack\n\
"));
'

PARSE_AND_LIST_ARGS_CASES=$PARSE_AND_LIST_ARGS_CASES'
    case OPTION_STACK:
      {
         char *suffix;
         stacksize = strtoul(optarg, &suffix, 0);
         nto_stack_flag = TRUE; 
      }
      break;
    case OPTION_LAZY_STACK:
      nto_lazy_stack = TRUE; 
      break;
'

# Put these extra Neutrino routines in ld_${EMULATION_NAME}_emulation
#

LDEMUL_AFTER_OPEN=nto_after_open
#LDEMUL_BEFORE_ALLOCATION=nto_before_allocation
#LDEMUL_FINISH=nto_finish
