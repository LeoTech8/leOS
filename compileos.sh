export PATH=$PATH:/usr/local/i386elfgcc/bin

echo Thanks for trying leOS! Hope you enjoy!
echo Compiling boot.asm to Binaries/boot.bin with NASM
nasm "boot.asm" -f bin -o "Binaries/boot.bin"
echo Compiling kernel_entry.asm to Binaries/kernel_entry.o with NASM
nasm -f elf32 -o Binaries/kernel_entry.o kernel_entry.asm
echo Compiling kernel.cpp to Binaries/kernel.o with x86_64-elf-gcc
x86_64-elf-gcc -m32 -ffreestanding -g -c "kernel.cpp" -o "Binaries/kernel.o"
echo Compiling zeroes with NASM
nasm "zeroes.asm" -f bin -o "Binaries/zeroes.bin"

echo Linking with x86_64-elf-ld
x86_64-elf-ld -m elf_i386 -o "Binaries/full_kernel.bin" -Ttext 0x1000 "Binaries/kernel_entry.o" "Binaries/kernel.o" --oformat binary

echo Combining Binaries/boot.bin, Binaries/full_kernel.bin and Binaries/zeroes.bin into Binaries/leOS.bin
cat "Binaries/boot.bin" "Binaries/full_kernel.bin" "Binaries/zeroes.bin"  > "Binaries/leOS.bin"

echo Running with QEMU-system-x86_64
qemu-system-x86_64 -drive format=raw,file="Binaries/leOS.bin",index=0,if=floppy,  -m 128M
echo QEMU Quit. Exiting.
