# Adding cyclictest/hackbench rt test cases

IMAGE_INSTALL += "rt-tests perf lvm2 bc keyutils numactl"

IMAGE_ROOTFS_EXTRA_SPACE = "2097152"
