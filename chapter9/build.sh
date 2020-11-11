#! /bin/bash

echo "building MBR and loader..."
nasm -I ./boot/ -f bin ./boot/mbr.asm -o ./build/mbr.bin
nasm -I ./boot/ -f bin ./boot/loader.asm -o ./build/loader.bin

echo "building kernel..."
#you must indicate gcc to build IA32 code and link in i386 mode, otherwise something unexpected will happen 
nasm -f elf ./kernel/kernel.asm -o ./build/kernel.o
nasm -f elf ./lib/kernel/print.asm -o ./build/print.o
gcc -Wall -m32 -fno-builtin -fno-stack-protector -I ./lib/kernel/ -I ./lib/ -I ./kernel/ -I ./thread/ -c ./kernel/main.c -o ./build/main.o
gcc -Wall -m32 -fno-builtin -fno-stack-protector -I ./lib/kernel/ -I ./lib/ -I ./kernel/ -c ./kernel/init.c -o ./build/init.o
gcc -Wall -m32 -fno-builtin -fno-stack-protector -I ./lib/kernel/ -I ./lib/ -I ./kernel/ -c ./kernel/interrupt.c -o ./build/interrupt.o
gcc -Wall -m32 -fno-builtin -fno-stack-protector -I ./lib/kernel/ -I ./lib/ -I ./kernel/ -c ./device/timer.c -o ./build/timer.o
gcc -Wall -m32 -fno-builtin -fno-stack-protector -I ./lib/kernel/ -I ./lib/ -I ./kernel/ -c ./kernel/debug.c -o ./build/debug.o
gcc -Wall -m32 -fno-builtin -fno-stack-protector -I ./lib/kernel/ -I ./lib/ -I ./kernel/ -c ./lib/string.c -o ./build/string.o
gcc -Wall -m32 -fno-builtin -fno-stack-protector -I ./lib/kernel/ -I ./lib/ -I ./kernel/ -c ./lib/kernel/bitmap.c -o ./build/bitmap.o
gcc -Wall -m32 -fno-builtin -fno-stack-protector -I ./lib/kernel/ -I ./lib/ -I ./kernel/ -c ./kernel/memory.c -o ./build/memory.o
gcc -Wall -m32 -fno-builtin -fno-stack-protector -I ./lib/kernel/ -I ./lib/ -I ./kernel/ -c ./thread/thread.c -o ./build/thread.o

echo "linking..."
ld -m elf_i386 ./build/main.o ./build/print.o ./build/kernel.o ./build/init.o ./build/interrupt.o ./build/timer.o ./build/debug.o ./build/string.o \
    ./build/bitmap.o ./build/memory.o ./build/thread.o   \
    -Ttext 0xc0001500 -e main -Map ./build/kernel.map -o ./build/kernel.elf
  #  ./build/thread.o   \

# AMD x86-64 mode
#nasm -f elf64 ./lib/kernel/print.asm -o ./build/print.o
#gcc -I ./lib/kernel/ -c ./kernel/main.c -o ./build/main.o
#ld ./build/main.o ./build/print.o -Ttext 0xc0001500 -e main -o ./build/kernel.elf
echo "start to write hard disk..."
dd if=./build/mbr.bin of=./build/hd60M.img bs=512 count=1 conv=notrunc
dd if=./build/loader.bin of=./build/hd60M.img bs=512 count=4 seek=2 conv=notrunc
dd if=./build/kernel.elf of=./build/hd60M.img bs=512 count=200 seek=9 conv=notrunc

echo "build done"

