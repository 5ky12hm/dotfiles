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
source ~/.gdbinit-gef.py
gef config context.clear_screen 0
