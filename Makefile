CC=gcc


.PHONY: all floppy_img kernel bootloader clean tools_fat always

all: floppy_img tools_fat


#
# Floppy Image
#
floppy_img: build/main_floppy.img

build/main_floppy.img: bootloader kernel
	dd if=/dev/zero of=build/main_floppy.img bs=512 count=2880
	mkfs.fat -F 12 -n "NBOS" build/main_floppy.img
	dd if=build/bootloader.bin of=build/main_floppy.img conv=notrunc
	mcopy -i build/main_floppy.img build/kernel.bin "::kernel.bin"
	mcopy -i build/main_floppy.img src/res/hello.txt "::hello.txt"



#
# bootloader
#
bootloader: build/bootloader.bin

build/bootloader.bin: always src/bootloader/boot.asm
	nasm src/bootloader/boot.asm -f bin -o build/bootloader.bin


#
#kernel
#
kernel: always build/kernel.bin

build/kernel.bin: src/kernel/main.asm
	nasm src/kernel/main.asm -f bin -o build/kernel.bin


#
#tools
#
tools_fat: build/tools/fat
build/tools/fat: always tools/fat/fat.c
	mkdir -p build/tools
	gcc tools/fat/fat.c -g -o build/tools/fat





run: floppy_img
	qemu-system-i386 -nographic -fda build/main_floppy.img

always:
	mkdir -p build

clean:
	rm -r build/*