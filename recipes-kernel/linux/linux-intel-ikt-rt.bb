require linux-intel-ikt.inc

KBRANCH = "5.4/preempt-rt"

SRC_URI_append = " \
    file://RT.cfg \
"
