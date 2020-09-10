require recipes-core/images/core-image-minimal.bb

DESCRIPTION = "A small image just capable of allowing a device to boot plus a \
real-time test suite."

IMAGE_INSTALL += "rt-tests"

LICENSE = "MIT"
