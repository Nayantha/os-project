if [ ! -e images/ ]
then
mkdir images || exit
fi

if [ ! -e bin/ ]
then
mkdir bin || exit
fi

echo "# creating new floopy image."
rm -f images/OS.flp
mkdosfs -C images/OS.flp 1440 || exit

echo "# assembling bootloader.."
nasm -O0 -w+orphan-labels -f bin -o bin/bootloader.bin source/bootloader.asm || exit

echo "# Assembling OS kernal.."
nasm -O0 -w+orphan-labels -f bin -o bin/kernel.bin source/kernel.asm || exit

echo "# Adding bootloader to floppy image.."
dd status=noxfer conv=notrunc if=bin/bootloader.bin of=images/OS.flp || exit

echo "# copy kernal and programs.."
rm -rf temp-loop
mkdir temp-loop && sudo mount -o loop -t vfat images/OS.flp temp-loop && sudo cp bin/kernel.bin temp-loop

sleep 0.2

echo "# unmounting loopback floppy.."
sudo umount temp-loop || exit

rm -f images/OS.iso
mkisofs -quiet -V 'teX OS' -o images/OS.iso -b OS.flp images/ || exit

echo "# starting theOS in qemu emulator..."
qemu-system-i386 -fda ./images/OS.flp || exit

echo "# done.."
