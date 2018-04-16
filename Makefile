
TARGET = fe3firmware

AS = dasm

$(TARGET):	fe3firmware.asm
	dasm fe3firmware.asm -v4 -f3 -o$@

clean:
	$(RM) $(TARGET)
	$(RM) *~
