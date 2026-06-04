FROM quay.io/fedora/fedora-bootc:43
RUN dnf -y install https://zfsonlinux.org/fedora/zfs-release-3-0$(rpm --eval "%{dist}").noarch.rpm && \
    dnf -y install kernel-devel-$(ls /usr/lib/modules) && \
    dnf -y install zfs && \
    dkms build zfs/$(rpm -q --qf '%{VERSION}' zfs) -k $(ls /usr/lib/modules) && \
    dkms install zfs/$(rpm -q --qf '%{VERSION}' zfs) -k $(ls /usr/lib/modules) && \
    systemctl disable dkms.service
