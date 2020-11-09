#！ /usr/bin/bash

nasm -I ./boot/ -f bin ./boot/mbr.asm -o ./build/mbr.bin
nasm -I ./boot/ -f bin ./boot/loader.asm -o ./build/loader.bin
gcc -c ./kernel/main.c -o ./build/main.o
ld ./build/main.o -Ttext 0xc0001500 -e main -o ./build/kernel.elf

dd if=./build/mbr.bin of=./build/hd60M.img bs=512 count=1 conv=notrunc
dd if=./build/loader.bin of=./build/hd60M.img bs=512 count=4 seek=2 conv=notrunc
dd if=./build/kernel.elf of=./build/hd60M.img bs=512 count=200 seek=9 conv=notrunc

