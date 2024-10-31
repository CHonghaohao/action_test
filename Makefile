run:
	cargo run

all: 
	sudo qemu-system-aarch64 -machine virt,secure=on,gic-version=3,virtualization=on,iommu=smmuv3 -global arm-smmuv3.stage=2 -cpu cortex-a57 -smp 4 -m 3G -nographic -bios images/u-boot-atf.bin -device loader,file="images/hvisor.bin",addr=0x40400000,force-raw=on -device loader,file="images/Image",addr=0xa0400000,force-raw=on -device loader,file="images/linux1.dtb",addr=0xa0000000,force-raw=on -drive if=none,file=images/ubuntu_aarch64.img,id=Xa003e000,format=raw -device virtio-blk-device,drive=Xa003e000,bus=virtio-mmio-bus.31 -netdev type=user,id=net1 -device virtio-net-pci,netdev=net1,disable-legacy=on,disable-modern=off,iommu_platform=on -device pci-testdev