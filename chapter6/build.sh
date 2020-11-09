#! /usr/bin/bash

nasm -I ./boot/ -f bin ./boot/mbr.asm -o ./build/mbr.bin
nasm -I ./boot/ -f bin ./boot/loader.asm -o ./build/loader.bin

#you must indicate gcc to build IA32 code and link in i386 mode, otherwise something unexpected will happen 
nasm -f elf ./lib/kernel/print.asm -o ./build/print.o
gcc -m32 -fno-builtin -I ./lib/kernel/ -I ./lib/ -c ./kernel/main.c -o ./build/main.o
ld -m elf_i386 ./build/main.o ./build/print.o -Ttext 0xc0001500 -e main -o ./build/kernel.elf

# AMD x86-64 mode
#nasm -f elf64 ./lib/kernel/print.asm -o ./build/print.o
#gcc -I ./lib/kernel/ -c ./kernel/main.c -o ./build/main.o
#ld ./build/main.o ./build/print.o -Ttext 0xc0001500 -e main -o ./build/kernel.elf

dd if=./build/mbr.bin of=./build/hd60M.img bs=512 count=1 conv=notrunc
dd if=./build/loader.bin of=./build/hd60M.img bs=512 count=4 seek=2 conv=notrunc
dd if=./build/kernel.elf of=./build/hd60M.img bs=512 count=200 seek=9 conv=notrunc

