require recipes-sato/images/core-image-sato.bb

DESCRIPTION = "A small image just capable of allowing a device to boot plus a \
real-time test suite and tools appropriate for real-time use."

IMAGE_INSTALL += "rt-tests"

LICENSE = "MIT"
