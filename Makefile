
TARGET = fe3firmware

AS = dasm

$(TARGET): fe3firmware.asm
	$(AS) fe3firmware.asm -v4 -f3 -o$@

fe3diag.prg: fe3diag.asm
	$(AS) fe3diag.asm -v4 -f3 -o$@

fe3flash.prg: fe3flash.asm
	$(AS) fe3flash.asm -v4 -f3 -o$@

clean:
	$(RM) $(TARGET)
	$(RM) fe3diag.prg
	$(RM) fe3flash.prg
	$(RM) *~
