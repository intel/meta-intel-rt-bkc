require linux-intel-ikt.inc

LICENSE = "GPLv2"

# echo "K_TAG = \"lts-v5.4.74-rt41-preempt-rt-201112T180541Z\"" >> conf/local.conf
# Above cmd could override preempt RT release's tag. Similarly, K_REPO, K_BRANCH
# and K_PROTOCOL could be changed as well.
K_REPO ?= "git://github.com/intel/linux-intel-lts.git"
K_TAG ?= "lts-v5.4.74-rt41-preempt-rt-201112T180541Z"
K_BRANCH ?= "5.4/preempt-rt"
K_PROTOCOL ?= "https"

LINUX_VERSION ?= "5.4"

SRC_URI_append = " \
    file://RT.cfg \
"
