1. nasm -f bin -o mbr.bin mbr.asm
2. nasm -f bin -o loader.bin loader.asm
3. dd if=./mbr.bin of=./hd60M.img bs=512 count=1 conv=notrunc
4. dd if=./loader.bin of=./hd60M.img bs=512 count=1 seek=2 conv=notrunc