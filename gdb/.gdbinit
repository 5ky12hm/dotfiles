# disassembly as intel notation
set disassembly-flavor intel

# command history
set history filename ~/.gdbhist
set history save on

set auto-load local-gdbinit

set print elements 0

# specify follow target process when execute parallel
set follow-fork-mode parent

# enable golang debug
# add-auto-load-safe-path /usr/lib/go/src/runtime/runtime-gdb.py

# expand gdb
# comment out: change to pwndbg
# source /usr/share/peda/peda.py
# auto added by pwndbg setup.sh

# expand gdb
# comment out: cannot use with rosetta
# set debuginfod enabled on
# source ~/repo/tools/pwndbg/gdbinit.py
