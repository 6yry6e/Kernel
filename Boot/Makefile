all: boot-image
boot.bin: boot.asm PrintStringViaBIOS.asm LoadDiskViaBios.asm GDT.asm ProtectedModeActivator.asm PrintStringInPM.asm
	nasm $< -f bin -o $@

run: all
	qemu-system-i386 boot-image

kernel_entry.o: kernel_entry.asm
	nasm $< -f elf -o $@

kernel.o: kernel.cpp
	g++ -std=c++11 -ffreestanding -m32 -c $< -o $@

kernel.bin: kernel_entry.o kernel.o
	ld -m elf_i386 -o kernel.bin -Ttext 0x1000 $^ --oformat binary

boot-image: boot.bin kernel.bin
	cat $^ > boot-image

clean:
	rm *.bin *.o


