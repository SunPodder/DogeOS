CC=gcc
ASM=nasm
BUILD_DIR=build
SRC_DIR=src

GREEN=\033[32m
WHITE=\033[0m
YELLOW=\033[33m
BLUE=\033[34m


.PHONY: all floppy kernel bootloader clean tools always

all: floppy


#
# Floppy Image
#
floppy: $(BUILD_DIR)/floppy.img
$(BUILD_DIR)/floppy.img: bootloader kernel
	@echo "$(YELLOW)Creating floppy image$(WHITE)"
	@dd if=/dev/zero of=$(BUILD_DIR)/floppy.img bs=512 count=2880
	@echo "$(YELLOW)Creating FAT12 file system$(WHITE)"
	@mkfs.fat -F 12 -n "DogeOS" $(BUILD_DIR)/floppy.img
	@dd if=$(BUILD_DIR)/bootloader.bin of=$(BUILD_DIR)/floppy.img conv=notrunc
	@echo "$(GREEN)Copying kernel..."
	@mcopy -i $(BUILD_DIR)/floppy.img $(BUILD_DIR)/kernel.bin "::kernel.bin"
	@echo "$(GREEN)Copying hello.txt"
	@mcopy -i $(BUILD_DIR)/floppy.img $(SRC_DIR)/res/hello.txt "::hello.txt"



#
# bootloader
#
bootloader: always $(BUILD_DIR)/bootloader.bin
$(BUILD_DIR)/bootloader.bin: $(SRC_DIR)/bootloader/boot.asm
	@echo "$(BLUE)Compiling bootloader$(WHITE)"
	@$(ASM) $(SRC_DIR)/bootloader/boot.asm -f bin -o $(BUILD_DIR)/bootloader.bin


#
#kernel
#
kernel: always $(BUILD_DIR)/kernel.bin
$(BUILD_DIR)/kernel.bin: $(SRC_DIR)/kernel/main.asm
	@echo "$(BLUE)Compiling kernel$(WHITE)"
	@$(ASM) $(SRC_DIR)/kernel/main.asm -f bin -o $(BUILD_DIR)/kernel.bin


#
#tools
#
tools_fat: $(BUILD_DIR)/tools/fat
$(BUILD_DIR)/tools/fat: always tools/fat/fat.c
	@mkdir -p $(BUILD_DIR)/tools
	$(CC) tools/fat/fat.c -g -o $(BUILD_DIR)/tools/fat





run: floppy
	@echo "$(BLUE)Starting qemu...$(WHITE)"
	@qemu-system-i386 -nographic -fda $(BUILD_DIR)/floppy.img

always:
	@mkdir -p $(BUILD_DIR)

clean:
	@echo "$(YELLOW)Cleaning workspace...$(WHITE)"
	@rm -r $(BUILD_DIR)/*
