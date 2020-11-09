#！ /usr/bin/bash

nasm -f bin -o mbr.bin mbr.asm
nasm -f bin -o loader.bin loader.asm
dd if=./mbr.bin of=./hd60M.img bs=512 count=1 conv=notrunc
dd if=./loader.bin of=./hd60M.img bs=512 count=4 seek=2 conv=notrunc