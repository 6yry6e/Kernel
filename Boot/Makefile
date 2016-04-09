all: boot-image
boot.bin: boot.asm PrintStringViaBIOS.asm LoadDiskViaBios.asm GDT.asm ProtectedModeActivator.asm PrintStringInPM.asm
	nasm $< -f bin -o $@

run: all
	qemu-system-i386 boot-image

kernel.bin: kernel.asm
	nasm $< -f bin -o $@

boot-image: boot.bin kernel.bin
	cat $^ > boot-image

clean:
	rm *.bin *.o


