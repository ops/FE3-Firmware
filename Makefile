#
# Makefile for FE3-Firmware and utils
#

include version.inc

AS = dasm
ASFLAGS = -f3

ifdef verbose
	ASFLAGS += -v$(verbose)
endif

all: fe3firmware fe3diag.prg fe3flash.prg

fe3firmware: fe3firmware.asm
	$(AS) $< $(ASFLAGS) -o$@

fe3diag.prg: fe3diag.asm
	$(AS) $< $(ASFLAGS) -o$@

fe3flash.prg: fe3flash.asm
	$(AS) $< $(ASFLAGS) -o$@

release:
	zip fe3firmware-$(shell echo $(FW_VERSION) | tr -d \").zip \
		fe3firmware \
		fe3diag.prg \
		fe3flash.prg
clean:
	$(RM) fe3firmware
	$(RM) fe3diag.prg
	$(RM) fe3flash.prg
	$(RM) *~
	$(RM) *.zip
