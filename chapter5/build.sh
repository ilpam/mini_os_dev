#！ /usr/bin/bash

nasm -I ./boot/ -f bin ./boot/mbr.asm -o ./build/mbr.bin
nasm -I ./boot/ -f bin ./boot/loader.asm -o ./build/loader.bin
dd if=./build/mbr.bin of=./build/hd60M.img bs=512 count=1 conv=notrunc
dd if=./build/loader.bin of=./build/hd60M.img bs=512 count=4 seek=2 conv=notrunc