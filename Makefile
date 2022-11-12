<<<<<<< HEAD
    OBJECTS = loader.o kmain.o io.o
=======
    OBJECTS = loader.o kmain.o
>>>>>>> d49567d6a6eebd64ef778a18ce21b5b92a8fba32
    CC = gcc
    CFLAGS = -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector \
             -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -c
    LDFLAGS = -T link.ld -melf_i386
    AS = nasm
    ASFLAGS = -f elf

    all: kernel.elf

    kernel.elf: $(OBJECTS)
	ld $(LDFLAGS) $(OBJECTS) -o kernel.elf

    os.iso: kernel.elf
	cp kernel.elf iso/boot/kernel.elf
	genisoimage -R                             \
                    -b boot/grub/stage2_eltorito       \
                    -no-emul-boot                             \
                    -boot-load-size 4                        \
                    -A os                           	       \
                    -input-charset utf8             	       \
                    -quiet                          	       \
                    -boot-info-table                 	       \
                    -o os.iso                         	       \
                    iso

    run: os.iso
	bochs -f bochsrc.txt -q

    %.o: %.c
	$(CC) $(CFLAGS)  $< -o $@

    %.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

    clean:
<<<<<<< HEAD
	rm -rf *.o kernel.elf os.iso
=======
	rm -rf *.o kernel.elf os.iso
>>>>>>> d49567d6a6eebd64ef778a18ce21b5b92a8fba32
