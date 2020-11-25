require recipes-kernel/linux/linux-yocto.inc

OVERRIDES_append = ":kernelversion-${@'.'.join((d.getVar('LINUX_VERSION') or '').split('.')[:2])}"

LIC_FILES_CHKSUM_kernelversion-5.4 = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"
LIC_FILES_CHKSUM_kernelversion-5.9 = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

# FILESEXTRAPATHS_prepend := "${THISDIR}/linux-intel-dev/bsp/${BSP_SUBTYPE}:"

KERNEL_CONFIG_URI ?= " \
    file://defconfig \
    file://intel-dev.cfg \
"

DEPENDS += "openssl-native util-linux-native"
DEPENDS += "${@bb.utils.contains('ARCH', 'x86', 'elfutils-native', '', d)}"

SRC_URI = "${K_REPO};name=machine;branch=${K_BRANCH};tag=${K_TAG};protocol=${K_PROTOCOL}"

SRC_URI_append = " ${KERNEL_CONFIG_URI}"
#
# Don't go to the premirrors since they won't have the source, nor should
# we leak any internal branch or tag names.
PREMIRRORS = ""

LINUX_VERSION_EXTENSION = "-intel-rt"
# Set the sanity skip flag, but also set a default version so
# that PV is sane
KERNEL_VERSION_SANITY_SKIP = "1"

PV = "${LINUX_VERSION}+git${SRCPV}"

COMPATIBLE_MACHINE = "intel-corei7-64"
PACKAGE_ARCH = "${INTEL_COMMON_PACKAGE_ARCH}"

do_shared_workdir_append() {
	if [ -x tools/objtool/objtool ]
	then
		mkdir -p $kerneldir/tools/objtool
		cp tools/objtool/objtool $kerneldir/tools/objtool
	fi
}

# ensure the correct compiler is available before config process
do_kernel_configme[depends] += "${PN}:do_prepare_recipe_sysroot"

