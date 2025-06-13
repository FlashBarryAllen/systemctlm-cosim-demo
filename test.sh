LD_LIBRARY_PATH=/home/codespace/cosim/install/systemc-2.3.3/cosim/lib-linux64/ ./zynq_demo unix:${HOME}/cosim/buildroot/handles/qemu-rport-_cosim@0 1000000

${HOME}/cosim/install/qemu/usr/local/bin/qemu-system-aarch64 -M arm-generic-fdt-7series -m 1G -kernel ${HOME}/cosim/buildroot/output/images/uImage -dtb ${HOME}/cosim/buildroot/output/images/zynq-zc702.dtb --initrd ${HOME}/cosim/buildroot/output/images/rootfs.cpio.gz -serial /dev/null -serial mon:stdio -display none -net nic -net nic -net user -machine-path ${HOME}/cosim/buildroot/handles -icount 0,sleep=off -rtc clock=vm -sync-quantum 1000000

wget https://cloud-images.ubuntu.com/releases/focal/release-20210125/unpacked/ubuntu-20.04-server-cloudimg-amd64-vmlinuz-generic
wget https://cloud-images.ubuntu.com/releases/focal/release-20210125/unpacked/ubuntu-20.04-server-cloudimg-amd64-initrd-generic


LD_LIBRARY_PATH=/path/to/systemc-2.3.3/lib-linux64/ ./pcie/versal/cpm4-qdma-demo unix:/tmp/machine-x86/qemu-rport-_machine_peripheral_rp0_rp 10000


#
# Change '/path/to's to the location where the Xilinx QEMU binary was
# installed and to the locations where the different images are found.
#
/home/codespace/cosim/install/qemu/usr/local/bin/qemu-system-x86_64                                                         \
    -M q35,accel=tcg,kernel-irqchip=split -cpu qemu64,rdtscp                          \
    -m 4G -smp 4 -display none                                            \
    -kernel /home/codespace/Downloads/ubuntu-20.04-server-cloudimg-amd64-vmlinuz-generic               \
    -append "root=/dev/sda1 rootwait console=tty1 console=ttyS0 intel_iommu=on"       \
    -initrd /home/codespace/Downloads/ubuntu-20.04-server-cloudimg-amd64-initrd-generic                \
    -serial mon:stdio -device intel-iommu,intremap=on,device-iotlb=on                 \
    -drive file=/home/codespace/Downloads/ubuntu-20.04-server-cloudimg-amd64.img                       \
    -drive file=/home/codespace/Downloads/user-data.img,format=raw                                     \
    -device ioh3420,id=rootport1,slot=1                                               \
    -device remote-port-pci-adaptor,bus=rootport1,id=rp0                              \
    -machine-path /tmp/machine-x86/                                                   \
    -device virtio-net-pci,netdev=net0 -netdev type=user,id=net0                      \
    -device remote-port-pcie-root-port,id=rprootport,slot=0,rp-adaptor0=rp,rp-chan0=0