require linux-intel-ikt.inc

LICENSE = "GPLv2"
KBRANCH = "5.4/preempt-rt"
# echo "K_TAG = \"lts-v5.4.74-rt41-preempt-rt-201112T180541Z\"" >> conf/local.conf
# Above cmd could override preempt RT release's tag
K_TAG ?= "lts-v5.4.74-rt41-preempt-rt-201112T180541Z"

SRC_URI_append = " \
    file://RT.cfg \
"
