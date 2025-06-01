#!/bin/bash

set -eux
cd `dirname $0`

# Must create debootstrap outside the project directory since we want to mount the project inside,
# otherwise the debootstrap will have a loop and rm -rf will destroy the project files.
ROOT=${HOME}/debootstrap-bookworm
MOUNT=${ROOT}/mount

if [[ ! -d ${ROOT} ]]; then
    sudo debootstrap bookworm ${ROOT} http://deb.debian.org/debian/
fi

if [[ ! -d ${MOUNT} ]]; then
    sudo mkdir -p ${MOUNT}
fi

SUDO=${ROOT}/usr/local/bin/sudo
if [[ ! -x ${SUDO} ]]; then
    sudo touch ${SUDO}
    sudo chmod ugo+rwx ${SUDO}
    echo '#!/bin/bash' > ${SUDO}
    echo '$@' >> ${SUDO}
fi

PASSWD=${ROOT}/etc/passwd
if [[ `grep "${USER}" ${PASSWD}` == "" ]]; then
    sudo chmod ugo+rwx ${PASSWD}
    grep "${USER}" /etc/passwd >> ${PASSWD}
fi

# Mount the entire project into the debootstrap
sudo mount --bind `pwd`/.. ${MOUNT}
sudo chroot ${ROOT}
sudo umount ${MOUNT}
